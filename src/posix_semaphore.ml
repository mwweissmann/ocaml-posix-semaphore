let get_ok name = function | Result.Ok x -> x | Result.Error (`EUnix e) -> raise (Unix.Unix_error (e, name, ""))

type 'a semaphore

external semaphore_initialize : unit -> unit = "semaphore_initialize"
let () = semaphore_initialize ()

external sem_init : int ->
  ([> `Unnamed] semaphore, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_init"

let sem_init_exn n = get_ok "sem_init" (sem_init n)

external sem_post : 'a semaphore ->
  (unit, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_post"

let sem_post_exn s = get_ok "sem_post" (sem_post s)

external sem_wait : 'a semaphore
  -> (unit, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_wait"

let sem_wait_exn s = get_ok "sem_wait" (sem_wait s)

external sem_getvalue : 'a semaphore ->
  (int, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_getvalue"

let sem_getvalue_exn s = get_ok "sem_getvalue" (sem_getvalue s)

external sem_destroy : [> `Unnamed] semaphore ->
  (unit, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_destroy"

let sem_destroy_exn s = get_ok "sem_destroy" (sem_destroy s)

external sem_close : [> `Named] semaphore ->
  (unit, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_close"

let sem_close_exn s = get_ok "sem_close" (sem_close s)

external sem_trywait : 'a semaphore ->
  (unit, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_trywait"

let sem_trywait_exn s = get_ok "sem_trywait" (sem_trywait s)

external sem_timedwait : 'a semaphore -> Posix_time.Timespec.t ->
  (unit, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_timedwait"

let sem_timedwait_exn s t = get_ok "sem_timedwait" (sem_timedwait s t)

external sem_unlink : string -> (unit, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_unlink"

let sem_unlink_exn p = get_ok "sem_unlink" (sem_unlink p)

external sem_open : string -> Unix.open_flag list -> Unix.file_perm -> int ->
  ([> `Named] semaphore, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_open"

let sem_open_exn p f r n = get_ok "sem_open" (sem_open p f r n)

