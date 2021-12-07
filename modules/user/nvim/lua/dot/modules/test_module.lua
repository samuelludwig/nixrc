local pong = function()
  print('pong!')
end

local ping = function()
  print('ping!')
  pong()
end

return {
  setup = function()
    print('Running setup...')
  end,
  config = function()
    print('Running config...')
  end,
  run = function()
    print('This is arbitrary code I can call on demand!')
  end,
  exports = {
    ping = ping,
    pong = pong,
  },
}
