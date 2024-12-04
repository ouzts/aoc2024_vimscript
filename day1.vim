let input_data = readfile("input.txt")

let list_data = [[], []]
for line in input_data
  let parts = split(line, '\s\+')
  call add(list_data[0], str2nr(parts[0]))
  call add(list_data[1], str2nr(parts[-1]))
endfor
call sort(list_data[0])
call sort(list_data[1])

let diff_sum = 0
for idx in range(len(list_data[0]))
  let diff_sum += abs(list_data[0][idx] - list_data[1][idx])
endfor
echo "Part 1: " . diff_sum

let item_map = {}
for elem in list_data[1]
  let item_map[elem] = get(item_map, elem, 0) + 1
endfor

let score = 0
for elem in list_data[0]
  if has_key(item_map, elem)
    let score += elem * item_map[elem]
  endif
endfor
echo "Part 2: " . score
