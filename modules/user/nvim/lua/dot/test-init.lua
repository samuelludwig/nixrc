local u = require('lib.utils')
local f = require('lib.fun')
local mod = require('lib.module')
local inspect = require('lib.inspect')

local var_dump = function(x)
  print(inspect(x))
  return ':ok'
end

local prepend_mod_dot = function(x)
  return 'modules.' .. x
end

local mod_list = f.totable(f.map(prepend_mod_dot, {
  'init',
  'core',
  'stopgap',
}))

local loaded = mod.load_all(mod_list)

var_dump(loaded)
