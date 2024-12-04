let input_data = readfile("input.txt")
let part1_count = 0
let part2_count = 0

for line in input_data
  let num_list = map(split(line, '\s\+'), 'str2nr(v:val)')
  let valid = 1
  let inc = 0
  let dec = 0
  let prev_val = num_list[0]

  for num in num_list[1:]
    let diff = num - prev_val
    if diff == 0 || abs(diff) > 3
      let valid = 0
      break
    endif
    if diff > 0
      if dec > 0
        let valid = 0
        break
      endif
      let inc = 1
    elseif diff < 0
      if inc > 0
        let valid = 0
        break
      endif
      let dec = 1
    endif
    let prev_val = num
  endfor

  let part1_count += valid

  if !valid
    let x = 0
    for skip in range(len(num_list))
      let temp_list = []
      for i in range(len(num_list))
        if i != skip
          call add(temp_list, num_list[i])
        endif
      endfor

      let tmp = 1
      let tinc = 0
      let tdec = 0
      let temp_prev = temp_list[0]

      for num in temp_list[1:]
        let diff = num - temp_prev
        if diff == 0 || abs(diff) > 3
          let tmp = 0
          break
        endif
        if diff > 0
          if tdec
            let tmp = 0
            break
          endif
          let tinc = 1
        elseif diff < 0
          if tinc
            let tmp = 0
            break
          endif
          let tdec = 1
        endif
        let temp_prev = num
      endfor

      if tmp
        let x = 1
        break
      endif
    endfor
    let part2_count += x
  else
    let part2_count += 1
  endif
endfor

echo "Part 1: " . part1_count
echo "Part 2: " . part2_count
