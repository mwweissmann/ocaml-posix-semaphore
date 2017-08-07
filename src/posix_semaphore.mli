(*
Copyright (c) 2015 Markus W. Weissmann <markus.weissmann@in.tum.de>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*)

(** POSIX semaphore

  @author Markus W. Weissmann
*)

type 'a semaphore
(** A semaphore. The type ['a] is only a phantom type specifying if the
  semaphore is a named or unnamed one. This avoids the possible error
  of closing/destroying a semaphore with the wrong function. *)

val sem_wait : 'a semaphore -> (unit, [>`EUnix of Unix.error]) Result.result
(** [sem_wait s] decrements (locks) the semaphore [s].
  If the value of [s] is greater than zero, the decrement proceeds and
  [sem_wait] returns immediately. Otherwise the call blocks until either
  is becomes possible due to a concurrent [sem_post] or a signal handler
  interrupts the call. *)

val sem_wait_exn : 'a semaphore -> unit
(** [sem_wait_exn s] is identical to [sem_wait s] but raises a [Unix_error] on
  error. *)

val sem_post : 'a semaphore -> (unit, [>`EUnix of Unix.error]) Result.result
(** [sem_post s] increments (unlocks) the semaphore [s]. *)

val sem_post_exn : 'a semaphore -> unit
(** [sem_post_exn s] is identical to [sem_post s] but raises a [Unix_error] on
  error. *)

val sem_init : int -> ([> `Unnamed] semaphore, [>`EUnix of Unix.error]) Result.result
(** [sem_init n] creates and initializes a new unnamed semaphore.
  The initial value of the semaphore is [n]. *)

val sem_init_exn : int -> [> `Unnamed] semaphore
(** [sem_init_exn n] is identical to [sem_init n] but raises [Unix_error] on
  error. *)

val sem_getvalue : 'a semaphore -> (int, [>`EUnix of Unix.error]) Result.result
(** [sem_getvalue s] returns the current value of the semaphore [s]. *)

val sem_getvalue_exn : 'a semaphore -> int
(** [sem_getvalue_exn s] is identical to [sem_getvalue s] but raises a
  [Unix_error] on error. *)

val sem_destroy : [> `Unnamed] semaphore -> (unit, [>`EUnix of Unix.error]) Result.result
(** [sem_destroy s] destroys the unnamed semaphore [s]. *)

val sem_destroy_exn : [> `Unnamed] semaphore -> unit
(** [sem_destroy_exn s] is identical to [sem_destroy s] but raises a
  [Unix_error] on error. *)

val sem_close : [> `Named] semaphore -> (unit, [>`EUnix of Unix.error]) Result.result
(** [sem_close s] closes the named semaphore [s]. *)

val sem_close_exn : [> `Named] semaphore -> unit
(** [sem_close_exn s] is identical to [sem_close s] but raises a [Unix_error]
  on error. *)

val sem_trywait : 'a semaphore -> (unit, [>`EUnix of Unix.error]) Result.result
(** [sem_trywait s] is the same as [sem_wait s], except that if the decrement
  cannot be performed immediately, [sem_trywait] returns an error instead of blocking. *)

val sem_trywait_exn : 'a semaphore -> unit
(** [sem_trywait_exn s] is identical to [sem_trywait s] but raises a
  [Unix_error] on error. *)

val sem_timedwait : 'a semaphore -> Posix_time.Timespec.t -> (unit, [>`EUnix of Unix.error]) Result.result
(** [sem_timedwait s t] is the same as [sem_wait s] except that [t] specifies
  the amount of time the call should block if the decrement cannot be immediately
  perforned. [t] is an asbolute time; if it has already expired by the time of
  the call, and the semaphore [s] could not be locked immediately, [sem_timedwait s t]
  fails with a timeout error. *)

val sem_timedwait_exn : 'a semaphore -> Posix_time.Timespec.t -> unit
(** [sem_timedwait_exn s t] is identical to [sem_timedwait s t] but raises a
  [Unix_error] on error. *)

val sem_unlink : string -> (unit, [>`EUnix of Unix.error]) Result.result
(** [sem_unlink path] removes the named semaphore referenced by [path].
  The semaphore is removed immediately but only destroyed once all other processes
  that have the semaphore open close it. *)

val sem_unlink_exn : string -> unit
(** [sem_unlink_exn path] is identical to [sem_unlink path] but raises a
  [Unix_error] on error. *)

val sem_open : string -> Unix.open_flag list -> Unix.file_perm -> int -> ([> `Named] semaphore, [>`EUnix of Unix.error]) Result.result
(** [sem_open path flags perms n] creates a new named semaphore with initial value [n]. *)

val sem_open_exn : string -> Unix.open_flag list -> Unix.file_perm -> int -> [> `Named] semaphore
(** [sem_open_exn path flags perms n] is identical to
  [sem_open path flags perms n] but raises a [Unix_error] on error. *)

