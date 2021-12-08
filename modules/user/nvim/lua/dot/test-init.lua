local u = require('lib.utils')
local f = require('lib.fun')
local mod = require('lib.module')
local inspect = require('lib.inspect')
require('packer-bootstrap')

local run_function_list = function(list)
  for _, fn in ipairs(list) do
    fn()
  end
  return ':ok'
end

local var_dump = function(x)
  print(inspect(x))
  return ':ok'
end

local prepend_mod_dot = function(x)
  return 'modules.' .. x
end

local mod_list = f.totable(f.map(prepend_mod_dot, {
  'core',
  'stopgap',
  'vimwiki-mod',
}))

local loaded = mod.load_all(mod_list)

-- run_function_list(loaded.setups)
-- run_function_list(loaded.configs)

-- loaded.exports['modules.test_module'].ping()

-- mod.run('modules.test_module')
-- mod.reload('modules.test_module')

mod.activate_all(mod_list)
