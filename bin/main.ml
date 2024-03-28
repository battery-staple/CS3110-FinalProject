let login_procedure pwd =
  if FinalProject.MasterPassword.check_master pwd then
    let () = FinalProject.Encrypt.set_key pwd in
    true
  else false

let quit_procedure () =
  print_endline "Exited the program";
  exit 0

let rec logged_in_loop () =
  print_endline "Type a command:";
  let input = read_line () in
  match input with
  | "quit" -> quit_procedure
  | "list" ->
      let pwd_list = FinalProject.Persistence.read_all_encryptable () in
      List.iter
        (fun x ->
          print_endline (FinalProject.Serialization.encryptable_to_string x))
        pwd_list;
      logged_in_loop ()
  | _ ->
      print_endline "That is not a valid command.";
      logged_in_loop ()

let rec main_loop () =
  print_endline "Type a command:";
  let input = read_line () in
  match input with
  | "quit" -> quit_procedure ()
  | "login" -> begin
      print_endline "Type your master password:";
      let pwd = read_line () in
      if login_procedure pwd then logged_in_loop ()
      else
        let () = print_endline "The password does not match" in
        main_loop ()
    end
  | _ ->
      print_endline "That is not a valid command.";
      main_loop ()
