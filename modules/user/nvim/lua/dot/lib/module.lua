local M = {}
require('fun')()

-- TODO: NEED method to recall the config of a given arbitrary module at any time

-- A valid module file should export a table of
-- SETUP: A typical standalone lambda that should be run for setup/use of the
-- module _before_ packages are installed
-- PACKAGES: A suite of packages to be installed by packer
-- CONFIG: A typical standalone lambda that should be run _after_ packages are
-- installed
-- EXPORTS: A table of functions/values to be exported
--
-- If any of the keys are not found they should be appropriately interpreted as
-- being empty

local merge = function(t1, t2)
  for k, v in pairs(t2) do
    if (type(v) == 'table') and (type(t1[k] or false) == 'table') then
      merge(t1[k], t2[k])
    else
      t1[k] = v
    end
  end
  return t1
end

local concat = function(t1, t2)
  for i = 1, #t2 do
    t1[#t1 + 1] = t2[i]
  end
  return t1
end

local concat_all = function(tables)
  local new_table = {}
  for t in tables do
    new_table = concat(new_table, t)
  end
  return new_table
end

local run_function_list = function(list)
  for f in list do
    f()
  end
end

M.load_dir = function(dir, except)
  return require(dir)
end

M.load_all = function(modules)
  local setups = {}
  local pkgs = {}
  local configs = {}
  local exports = {}

  for modName in modules do
    local mod = require(modName)
    if mod['setup'] ~= nil then
      setups = concat(setups, mod['setup'])
    end
    if mod['packages'] ~= nil then
      pkgs = concat(pkgs, mod['packages'])
    end
    if mod['configs'] ~= nil then
      configs = concat(configs, mod['config'])
    end
    if mod['exports'] ~= nil then
      exports[modName] = mod['exports']
    end
  end

  return { setups = setups, pkgs = pkgs, configs = configs, exports = exports }
end

M.activate_all = function(modules)
  Mods = M.load_all(modules)

  -- Run setups
  run_function_list(Mods.setups)

  -- Configure packages, need packer
  local packer = require('packer')
  packer.startup(function(use)
    each(function(x)
      use(x)
    end, Mods.pkgs)
  end)

  -- Run configs
  run_function_list(Mods.configs)

  -- Place exports into the global table
  for k, v in pairs(Mods.exports) do
    _G[k] = v
  end
  -- merge module fields
  -- 1. run all setups
  -- 2. merge packages into one table and then call `use` on all of them in a
  -- `packer.setup` call
  -- 3. run all configs
  -- exports should be available to global access under their respective module
  -- names
end

return M
