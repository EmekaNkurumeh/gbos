local lume = require "lib.lume"
local Object = require "lib.classic"

local Save = Object:extend()

function Save:new(name, data)
  self.type = "save"
  self.name = name
  self.data = data or {}
  local data = {}
  if juno.fs.exists(self.name) then
    local section
    local file = juno.fs.read(self.name)
    for line in file:gmatch("[^\r\n]+") do
      local tempSection = line:match("^%[([^%[%]]+)%]$")
      if tempSection then
        section = tonumber(tempSection) and tonumber(tempSection) or tempSection
        data[section] = data[section] or {}
      end
      local param, value = line:match("^([%w|_]+)%s- ?= ?%s-(.+)$")
      if param and value ~= nil then
        if tonumber(value) then
          value = tonumber(value)
        elseif value == "true" then
          value = true
        elseif value == "false" then
          value = false
        end
        if tonumber(param) then
          param = tonumber(param)
        end
        if section then
          data[section][param] = value
        else
          data[param] = value
        end
      end
    end
  else
    juno.fs.write(self.name, " ")
  end
  self.data = lume.extend(self.data, data)
end

function Save:get(key)
  return self.data[key]
end

function Save:set(t)
  for k, v in pairs(t) do
    self.data[k] = v
  end
  local contents = ""
  for section, param in pairs(self.data) do
    if type(param) == "table" then
      contents = contents .. ("[%s]\n"):format(section)
      for k, v in pairs(param) do
        contents = contents .. ("%s = %s\n"):format(k, tostring(v))
      end
    else
      contents = contents .. ("%s = %s"):format(section, tostring(param))
    end
    contents = contents .. "\n"
  end
  juno.fs.write(self.name, contents)
end

return Save
