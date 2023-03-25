let x = "shit"
module MyModule = struct
  let b = x
end
let main = print_string (MyModule.b)
