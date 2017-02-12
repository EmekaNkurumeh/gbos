class Save
  new: (@name, @data) =>
    data = {}
    if juno.fs.exists @name
      local section
      file = juno.fs.read(@name)
      for line in file\gmatch("[^\r\n]+")
        tempSection = line\match('^%[([^%[%]]+)%]$')
        if tempSection
          section = tonumber(tempSection) and tonumber(tempSection) or tempSection
          data[section] = data[section] or {}
        param, value = line\match('^([%w|_]+)%s- ?= ?%s-(.+)$')
        if param and value != nil
          if tonumber(value)
            value = tonumber(value)
          elseif value == 'true'
            value = true
          elseif value == 'false'
            value = false
          if tonumber(param) 
            param = tonumber(param)
          if section
            data[section][param] = value
          else
            data[param] = value
    else
      juno.fs.write @name, ""

    @data = table.merge data, @data

  get: (key) =>
    @data[key]

  set: (t) =>
    @data[k] = v for k, v in pairs t

  close: =>
    if @data
      contents = ''
      for section, param in pairs(@data)
        if type(param) == "table"
          contents = contents .. ('[%s]\n')\format(section) 
          for key, value in pairs(param) do
            contents = contents .. ('%s = %s\n')\format(key, tostring(value))
        else
          contents = contents .. ('%s = %s')\format(section, tostring(param))
        contents = contents .. '\n'
      juno.fs.write @name, contents

{:Save}

