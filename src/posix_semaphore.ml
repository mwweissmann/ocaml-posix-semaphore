type semaphore

external semaphore_initialize : unit -> unit = "semaphore_initialize"
let () = semaphore_initialize ()

external sem_init : int -> (semaphore, [>`EUnix of Unix.error]) Result.result = "stub_sem_init"
external sem_post : semaphore -> (unit, [>`EUnix of Unix.error]) Result.result = "stub_sem_post"
external sem_wait : semaphore -> (unit, [>`EUnix of Unix.error]) Result.result = "stub_sem_wait"
external sem_getvalue : semaphore -> (int, [>`EUnix of Unix.error]) Result.result = "stub_sem_getvalue"
external sem_destroy : semaphore -> (unit, [>`EUnix of Unix.error]) Result.result = "stub_sem_destroy"

(*
external sem_open : string -> Unix.open_flag list -> Unix.file_perm -> int -> (t, [>`EUnix of Unix.error]) Result.result = "stub_sem_open"
external sem_close : semaphore -> (unit, [>`EUnix of Unix.error]) Result.result = "stub_sem_close"
external sem_trywait : semaphore -> (unit, [>`EUnix of Unix.error]) Result.result = "stub_sem_trywait"
external sem_timedwait : semaphore -> Posix_time.Timespec.t -> (unit, [>`EUnix of Unix.error]) Result.result = "stub_sem_timedwait"
external sem_unlink : string -> (unit, [>`EUnix of Unix.error]) Result.result = "stub_sem_unlink"
*)
