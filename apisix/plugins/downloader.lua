--
-- Licensed to the Apache Software Foundation (ASF) under one or more
-- contributor license agreements.  See the NOTICE file distributed with
-- this work for additional information regarding copyright ownership.
-- The ASF licenses this file to You under the Apache License, Version 2.0
-- (the "License"); you may not use this file except in compliance with
-- the License.  You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
local ngx           = ngx
local apisix_plugin = require("apisix.plugin")
local plugin_config = require("apisix.plugin_config")
local core          = require("apisix.core")
local utils         = require("apisix.core.utils")
local lyaml         = require("lyaml")

local plugin_name   = "downloader"


local schema = {
  type = "object",
  properties = {
    plugins = {
      description = "List of plugins to download",
      type = "array",
      minItems = 1,
      uniqueItems = true,
      items = {
        type = "object",
        properties = {
          source = {
            description = "Source from where the file must be downloaded",
            type = "object",
            items = {
              url = {
                description = "String representing the URL",
                type = "string",
              },
              ssl_verify = {
                description = "Whether or not to perform SSL verification",
                type = "boolean",
                default = true,
              },
            },
            required = { "url" },
          },
          name = {
            description = "Plugin name",
            type = "string",
          },
          validate = {
            description = "Whether or not to check if it's a valid APISIX plugin",
            type = "boolean",
            default = true
          },
        },
        required = { "source", "name" },
        additionalProperties = false,
      },
    },
    destination = {
      description = "Location where the files must be placed",
      type = "object",
      properties = {
        path = {
          type = "string",
          default = "/usr/local/apisix/apisix/plugins/",
        },
        create_if_missing = {
          description = "Wheter to create the directory or not, if it doesn't exist",
          type = "boolean",
          default = false,
        },
      },
    },
    update_config = {
      description = "Where to update APISIX configuration to load the plugin or not",
      type = "boolean",
      default = true
    },
    config_file = {
      description = "config.yaml path. Needed if update_config is set to true",
      type = "string",
      default = "/usr/local/apisix/conf/config.yaml"
    },
    required = { "plugins" },
    additionalProperties = false,
  },
}


local _M = {
  version = 0.1,
  priority = 0,
  name = plugin_name,
  schema = schema,
  author = "Michele Righi",
  source = "https://github.com/mikyll/apisix-plugin-downloader",
}

function _M.check_schema(conf, schema_type)
  core.log.info("input conf for " .. tostring(schema_type) .. ": ", core.json.delay_encode(conf))

  -- Check if the destination is a correct path
  if conf.destination.path then
    if not conf.destination.path:match("/$") then
      conf.destination.path = conf.destination.path .. "/"
    end
  end

  -- Create path if it's missing and conf option is enabled
  if conf.destination.create_if_missing then
    -- todo
  end

  for _, plugin in ipairs(conf.plugins) do
    if not plugin.name and not plugin.validate then
      core.log.error("Either plugin.name must be set or plugin.validate must be true")
      return false, "Either plugin.name must be set or plugin.validate must be true"
    end
  end

  -- Check if config.yaml file exists
  if conf.update_config then
    -- todo
  end

  -- core.log.error("check_schema")

  return core.schema.check(schema, conf)
end

function _M.init()
  -- local apisix_plugin = require("apisix.plugin")
  -- if apisix_plugin then
  --   local metadata = apisix_plugin.plugin_metadata(plugin_name)
  --   if metadata and metadata.value.files then
  --     core.log.error("\n\nINIT:\n" .. core.json.delay_encode(metadata.value.files) .. "\n\n")
  --   end
  -- end
end

function _M.rewrite(conf, ctx)
  -- local config = plugin_config.plugin_configs()

  local results = {}

  for index, plugin in ipairs(conf.plugins) do
    results[index] = {}
    results[index].name = plugin.name
    results[index].result = false

    local http = require("resty.http")
    local httpc = http.new()
    local res, err = httpc:request_uri(
      plugin.source.url,
      {
        method = "GET",
        ssl_verify = plugin.source.ssl_verify,
      })

    if not res then
      core.log.error("Error: " .. err)

      results[index].error = err
      goto continue
    end

    core.log.warn("Response: " .. res.body)

    -- Validate plugin (via apisix module?)
    if plugin.validate then
      -- Get name if plugin.name is not set
    end

    local file_path = conf.destination.path .. plugin.name
    local file_dest, err = io.open(file_path, "w")
    if not file_dest then
      os.execute("mkdir -p $(dirname " .. conf.destination.path .. ")")

      file_dest, err = io.open(conf.destination.path, "w")
      if not file_dest then
        core.log.error("Error: " .. err)

        results[index].error = err
        goto continue
      end
    end

    file_dest:write(res.body)
    file_dest:close()

    results[index].result = true
    -- results[index].body = res.body

    -- return 200, res.body

    ::continue::
  end

  core.log.warn("Summary:\n")

  -- Update config
  if conf.update_config then
    local file_config, err = io.open(conf.config_file, "w")

    os.execute("apisix reload")
  end

  return 200, results
end

return _M
