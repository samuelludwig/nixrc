local u = require('lib.utils')
local f = require('lib.fun')
local mod = require('lib.module')
--local inspect = require('lib.inspect')
require('packer-bootstrap')

local prepend_mod_dot = function(x)
  return 'modules.' .. x
end

local mod_list = f.totable(f.map(prepend_mod_dot, {
  'core',
  'telescope-mod',
  'language_smartness',
  'vimwiki-mod',
  'galaxyline-mod',
  'themes',
}))

mod.activate_all(mod_list)
