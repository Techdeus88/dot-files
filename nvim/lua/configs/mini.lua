local present_ai, mini_ai = pcall(require, "mini.ai")
local present_animate, mini_animate = pcall(require, "mini.animate")
local present_surround, mini_surround = pcall(require, "mini.surround")

if not present_ai then
  return
end

if not present_animate then
  return
end

if not present_surround then
  return
end

local run_mini_setups = function()
  mini_ai.setup { n_lines = 500 }
  mini_animate.setup {}
  mini_surround.setup {}
end

if present_ai and present_animate and present_surround then
  run_mini_setups()
end
