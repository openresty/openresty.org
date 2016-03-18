local PostgresArray
do
  local _class_0
  local _base_0 = { }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "PostgresArray"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  PostgresArray = _class_0
end
getmetatable(PostgresArray).__call = function(self, t)
  return setmetatable(t, self.__base)
end
local default_escape_literal = nil
local encode_array
do
  local append_buffer
  append_buffer = function(escape_literal, buffer, values)
    for _index_0 = 1, #values do
      local item = values[_index_0]
      if type(item) == "table" and not getmetatable(item) then
        table.insert(buffer, "[")
        append_buffer(escape_literal, buffer, item)
        buffer[#buffer] = "]"
        table.insert(buffer, ",")
      else
        table.insert(buffer, escape_literal(item))
        table.insert(buffer, ",")
      end
    end
    return buffer
  end
  encode_array = function(tbl, escape_literal)
    escape_literal = escape_literal or default_escape_literal
    if not (escape_literal) then
      local Postgres
      Postgres = require("pgmoon").Postgres
      default_escape_literal = function(v)
        return Postgres.escape_literal(nil, v)
      end
      escape_literal = default_escape_literal
    end
    local buffer = append_buffer(escape_literal, {
      "ARRAY["
    }, tbl)
    buffer[#buffer] = "]"
    return table.concat(buffer)
  end
end
local convert_values
convert_values = function(array, fn)
  for idx, v in ipairs(array) do
    if type(v) == "table" then
      convert_values(v, fn)
    else
      array[idx] = fn(v)
    end
  end
  return array
end
local decode_array
do
  local P, R, S, V, Ct, C, Cs
  do
    local _obj_0 = require("lpeg")
    P, R, S, V, Ct, C, Cs = _obj_0.P, _obj_0.R, _obj_0.S, _obj_0.V, _obj_0.Ct, _obj_0.C, _obj_0.Cs
  end
  local g = P({
    "array",
    array = Ct(V("open") * (V("value") * (P(",") * V("value")) ^ 0) ^ -1 * V("close")),
    value = V("invalid_char") + V("string") + V("array") + V("literal"),
    string = P('"') * Cs((P([[\\]]) / [[\]] + P([[\"]]) / [["]] + (P(1) - P('"'))) ^ 0) * P('"'),
    literal = C((P(1) - S("},")) ^ 1),
    invalid_char = S(" \t\r\n") / function()
      return error("got unexpected whitespace")
    end,
    open = P("{"),
    delim = P(","),
    close = P("}")
  })
  decode_array = function(str, convert_fn)
    local out = (assert(g:match(str), "failed to parse postgresql array"))
    setmetatable(out, PostgresArray.__base)
    if convert_fn then
      return convert_values(out, convert_fn)
    else
      return out
    end
  end
end
return {
  encode_array = encode_array,
  decode_array = decode_array,
  PostgresArray = PostgresArray
}
