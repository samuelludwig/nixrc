local M = {}

-- A valid module file should export a table of
-- SETUP: A typical standalone lambda that should be run for setup/use of the
-- module _before_ packages are installed
-- PACKAGES: A suite of packages to be installed by packer
-- CONFIG: A typical standalone lambda that should be run _after_ packages are
-- installed
-- EXPORTS: A table of functions/values to be exported
--
--
M.load = function(name)
  require(name)
  return ":ok"
end

M.load_all = function(dir, except) end

return M
