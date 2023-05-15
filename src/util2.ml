let is_whitespace s = s = " "

let is_all_whitespace str =
  let is_whitespace c = c = ' ' || c = '\t' || c = '\n' || c = '\r' in
  String.for_all is_whitespace str

let compare_string_caseless str1 str2 =
  let value = String.lowercase_ascii str1 = String.lowercase_ascii str2 in
  if value then 0 else if str1 < str2 then -1 else 1
