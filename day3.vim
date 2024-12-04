function! ProcessInstruction(chunk) abort
  let chars = split(a:chunk, '\zs')
  let accumulator = [0, 0, 0, 0, 0] "
  let strings = ['', ''] "

  if chars[0] != '('
    return 0
  endif

  for c in chars[1:]
    if c =~# '\D'
      if c ==# ','
        if accumulator[0]
          return 0
        endif
        let accumulator[1] = str2nr(strings[0])
        let accumulator[3] = (strings[0] == '0' || accumulator[1] != 0)
        if !accumulator[3]
          return 0
        endif
        let accumulator[0] = 1
      elseif c ==# ')'
        if !accumulator[0]
          return 0
        endif
        let accumulator[2] = str2nr(strings[1])
        let accumulator[4] = (strings[1] == '0' || accumulator[2] != 0)
        if !accumulator[4]
          return 0
        endif
        return accumulator[1] * accumulator[2]
      else
        return 0
      endif
    else
      let strings[accumulator[0]] .= c
    endif
  endfor

  return 0
endfunction

function! CalculateTotal(input, mode) abort
  let total = 0
  let state = [1]

  for line in a:input
    for chunk in split(line, 'mul')
      if state[0]
        let total += ProcessInstruction(chunk)
      endif

      if a:mode == 2
        let segments = [split(chunk, 'do()')[-1], split(chunk, "don't()")[-1]]
        let state[0] = (strlen(segments[0]) < strlen(segments[1]) ? 1 : (strlen(segments[0]) > strlen(segments[1]) ? 0 : state[0]))
      endif
    endfor
  endfor

  return total
endfunction

let data = readfile("input.txt")
echo "Part 1: " . CalculateTotal(data, 1)
echo "Part 2: " . CalculateTotal(data, 2)
