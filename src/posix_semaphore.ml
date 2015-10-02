type 'a semaphore

external semaphore_initialize : unit -> unit = "semaphore_initialize"
let () = semaphore_initialize ()

external sem_init : int ->
  ([> `Unnamed] semaphore, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_init"

external sem_post : 'a semaphore ->
  (unit, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_post"

external sem_wait : 'a semaphore
  -> (unit, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_wait"

external sem_getvalue : 'a semaphore ->
  (int, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_getvalue"

external sem_destroy : [> `Unnamed] semaphore ->
  (unit, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_destroy"

external sem_close : [> `Named] semaphore ->
  (unit, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_close"

external sem_trywait : 'a semaphore ->
  (unit, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_trywait"

external sem_timedwait : 'a semaphore -> Posix_time.Timespec.t ->
  (unit, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_timedwait"

external sem_unlink : string -> (unit, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_unlink"

external sem_open : string -> Unix.open_flag list -> Unix.file_perm -> int ->
  ([> `Named] semaphore, [>`EUnix of Unix.error]) Result.result
  = "stub_sem_open"

