let x = "dafsdfasdf"
module MyModule = struct
  let b = x
  let c = fun () -> x

end
let main = print_string (MyModule.b)
