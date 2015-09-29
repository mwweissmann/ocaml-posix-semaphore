open Posix_semaphore

let _ =
  let x = match sem_init 23 with | Result.Ok x -> x in
  match sem_getvalue x with | Result.Ok v -> Printf.printf "%d\n" v;
  match sem_wait x with | Result.Ok () -> print_endline "ok";
  match sem_getvalue x with | Result.Ok v -> Printf.printf "%d\n" v;
  match sem_wait x with | Result.Ok () -> print_endline "ok";
  match sem_getvalue x with | Result.Ok v -> Printf.printf "%d\n" v;
  match sem_wait x with | Result.Ok () -> print_endline "ok";
  match sem_getvalue x with | Result.Ok v -> Printf.printf "%d\n" v;
  match sem_destroy x with | Result.Ok () -> print_endline "ok";
  match sem_destroy x with | Result.Error (`EUnix err) -> print_endline (Unix.error_message err);
  print_endline "done"
