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

(** A semaphore *)
type 'a semaphore

val sem_wait : 'a semaphore -> (unit, [>`EUnix of Unix.error]) Result.result
val sem_post : 'a semaphore -> (unit, [>`EUnix of Unix.error]) Result.result
val sem_init : int -> ([> `Unnamed] semaphore, [>`EUnix of Unix.error]) Result.result
val sem_getvalue : 'a semaphore -> (int, [>`EUnix of Unix.error]) Result.result
val sem_destroy : [> `Unnamed] semaphore -> (unit, [>`EUnix of Unix.error]) Result.result
val sem_close : [> `Named] semaphore -> (unit, [>`EUnix of Unix.error]) Result.result
val sem_trywait : 'a semaphore -> (unit, [>`EUnix of Unix.error]) Result.result
val sem_timedwait : 'a semaphore -> Posix_time.Timespec.t -> (unit, [>`EUnix of Unix.error]) Result.result
val sem_unlink : string -> (unit, [>`EUnix of Unix.error]) Result.result
val sem_open : string -> Unix.open_flag list -> Unix.file_perm -> int -> ([> `Named] semaphore, [>`EUnix of Unix.error]) Result.result

