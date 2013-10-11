let g:rl_tests=""

map ,ts :call UpdateRlTests()<CR>

function! UpdateRlTests()
  let g:rl_tests = input("Tests: ", g:rl_tests)
endfunction

