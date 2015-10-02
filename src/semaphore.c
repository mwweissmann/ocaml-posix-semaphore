#include <assert.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <stdbool.h>
#include <errno.h>
#include <time.h>
#include <fcntl.h>
#include <semaphore.h>

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h> 
#include <caml/threads.h> 
#include <caml/callback.h>
#include <caml/fail.h>
#include <caml/unixsupport.h>
#include <caml/custom.h>

#include "ocaml-posix-semaphore.h"

void finalize_ptr_free(value v) {
  sem_t *s;
  s = (sem_t *) Data_custom_val(v);
  free(s);
}

static struct custom_operations semaphore_custom_ops = {
  .identifier  = "Posix_semaphore.semaphore",
  .finalize    = finalize_ptr_free,
  .compare     = custom_compare_default,
  .hash        = custom_hash_default,
  .serialize   = custom_serialize_default,
  .deserialize = custom_deserialize_default
};

CAMLprim value caml_copy_semaphore(sem_t *s) {
  CAMLparam0();
  CAMLlocal1(v);
  v = caml_alloc_custom(&semaphore_custom_ops, sizeof(sem_t *), 0, 1);
  memcpy(Data_custom_val(v), &s, sizeof(sem_t *));
  CAMLreturn(v);
}

static value eunix;

CAMLprim value semaphore_initialize(value unit) {
  CAMLparam1(unit);
  eunix = caml_hash_variant("EUnix");
  CAMLreturn (Val_unit);
}

CAMLprim value stub_sem_init(value c) {
  CAMLparam1(c);
  CAMLlocal2(result, perrno);
  int rc, lerrno;
  sem_t *s;

  rc = -1;
  caml_release_runtime_system();
  if (NULL != (s = malloc(sizeof(sem_t)))) {
    rc = sem_init(s, 0, Int_val(c));
    lerrno = errno;
  } else {
    lerrno = ENOMEM;
    free(s);
  }
  caml_acquire_runtime_system();

  if (0 != rc) {
    goto ERROR;
  }

  result = caml_alloc(1, 0); // Result.Ok
  Store_field(result, 0, caml_copy_semaphore(s));
  goto END;

ERROR:
  perrno = caml_alloc(2, 0);
  Store_field(perrno, 0, eunix); // `EUnix
  Store_field(perrno, 1, unix_error_of_code(lerrno));
  result = caml_alloc(1, 1); // Result.Error
  Store_field(result, 0, perrno);

END:
  CAMLreturn(result);
}

CAMLprim value stub_sem_wait(value sem) {
  CAMLparam1(sem);
  CAMLlocal2(result, perrno);
  int rc, lerrno;
  sem_t *s;

  s = *Sem_val(sem);
  if (NULL == s) {
    lerrno = EINVAL;
    goto ERROR;
  }

  caml_release_runtime_system();
  rc = sem_wait(s);
  lerrno = errno;
  caml_acquire_runtime_system();

  if (0 != rc) {
    goto ERROR;
  }

  result = caml_alloc(1, 0); // Result.Ok
  Store_field(result, 0, Val_unit);
  goto END;

ERROR:
  perrno = caml_alloc(2, 0);
  Store_field(perrno, 0, eunix); // `EUnix
  Store_field(perrno, 1, unix_error_of_code(lerrno));
  result = caml_alloc(1, 1); // Result.Error
  Store_field(result, 0, perrno);

END:
  CAMLreturn(result);
}

CAMLprim value stub_sem_trywait(value sem) {
  CAMLparam1(sem);
  CAMLlocal2(result, perrno);
  int rc, lerrno;
  sem_t *s;

  s = *Sem_val(sem);
  if (NULL == s) {
    lerrno = EINVAL;
    goto ERROR;
  }

  caml_release_runtime_system();
  rc = sem_trywait(s);
  lerrno = errno;
  caml_acquire_runtime_system();

  if (0 != rc) {
    goto ERROR;
  }

  result = caml_alloc(1, 0); // Result.Ok
  Store_field(result, 0, Val_unit);
  goto END;

ERROR:
  perrno = caml_alloc(2, 0);
  Store_field(perrno, 0, eunix); // `EUnix
  Store_field(perrno, 1, unix_error_of_code(lerrno));
  result = caml_alloc(1, 1); // Result.Error
  Store_field(result, 0, perrno);

END:
  CAMLreturn(result);
}

CAMLprim value stub_sem_timedwait(value sem, value time) {
  CAMLparam1(sem);
  CAMLlocal2(result, perrno);
  int rc, lerrno;
  sem_t *s;
  struct timespec t;

  t.tv_sec = Int64_val(Field(time, 0));
  t.tv_nsec = Int64_val(Field(time, 1));
  s = *Sem_val(sem);
  if (NULL == s) {
    lerrno = EINVAL;
    goto ERROR;
  }

  caml_release_runtime_system();
  rc = sem_timedwait(s, &t);
  lerrno = errno;
  caml_acquire_runtime_system();

  if (0 != rc) {
    goto ERROR;
  }

  result = caml_alloc(1, 0); // Result.Ok
  Store_field(result, 0, Val_unit);
  goto END;

ERROR:
  perrno = caml_alloc(2, 0);
  Store_field(perrno, 0, eunix); // `EUnix
  Store_field(perrno, 1, unix_error_of_code(lerrno));
  result = caml_alloc(1, 1); // Result.Error
  Store_field(result, 0, perrno);

END:
  CAMLreturn(result);
}

CAMLprim value stub_sem_post(value sem) {
  CAMLparam1(sem);
  CAMLlocal2(result, perrno);
  int rc, lerrno;
  sem_t *s;

  s = *Sem_val(sem);
  if (NULL == s) {
    lerrno = EINVAL;
    goto ERROR;
  }

  caml_release_runtime_system();
  rc = sem_post(s);
  lerrno = errno;
  caml_acquire_runtime_system();

  if (0 != rc) {
    goto ERROR;
  }

  result = caml_alloc(1, 0); // Result.Ok
  Store_field(result, 0, Val_unit);
  goto END;

ERROR:
  perrno = caml_alloc(2, 0);
  Store_field(perrno, 0, eunix); // `EUnix
  Store_field(perrno, 1, unix_error_of_code(lerrno));
  result = caml_alloc(1, 1); // Result.Error
  Store_field(result, 0, perrno);

END:
  CAMLreturn(result);
}

CAMLprim value stub_sem_getvalue(value sem) {
  CAMLparam1(sem);
  CAMLlocal2(result, perrno);
  int rc, lerrno, sval;
  sem_t *s;

  s = *Sem_val(sem);

  caml_release_runtime_system();
  rc = sem_getvalue(s, &sval);
  lerrno = errno;
  caml_acquire_runtime_system();

  if (0 != rc) {
    goto ERROR;
  }

  result = caml_alloc(1, 0); // Result.Ok
  Store_field(result, 0, Val_int(sval));
  goto END;

ERROR:
  perrno = caml_alloc(2, 0);
  Store_field(perrno, 0, eunix); // `EUnix
  Store_field(perrno, 1, unix_error_of_code(lerrno));
  result = caml_alloc(1, 1); // Result.Error
  Store_field(result, 0, perrno);

END:
  CAMLreturn(result);
}

CAMLprim value stub_sem_destroy(value sem) {
  CAMLparam1(sem);
  CAMLlocal2(result, perrno);
  int rc, lerrno;
  sem_t *s;

  s = *Sem_val(sem);
  if (NULL == s) {
    lerrno = EINVAL;
    goto ERROR;
  }

  caml_release_runtime_system();
  rc = sem_destroy(s);
  lerrno = errno;
  free(s);
  s = NULL;
  caml_acquire_runtime_system();
  memcpy(Data_custom_val(sem), &s, sizeof(sem_t *));

  if (0 != rc) {
    goto ERROR;
  }

  result = caml_alloc(1, 0); // Result.Ok
  Store_field(result, 0, Val_unit);
  goto END;

ERROR:
  perrno = caml_alloc(2, 0);
  Store_field(perrno, 0, eunix); // `EUnix
  Store_field(perrno, 1, unix_error_of_code(lerrno));
  result = caml_alloc(1, 1); // Result.Error
  Store_field(result, 0, perrno);

END:
  CAMLreturn(result);
}

CAMLprim value stub_sem_close(value sem) {
  CAMLparam1(sem);
  CAMLlocal2(result, perrno);
  int rc, lerrno;
  sem_t *s;

  s = *Sem_val(sem);
  if (NULL == s) {
    lerrno = EINVAL;
    goto ERROR;
  }

  caml_release_runtime_system();
  rc = sem_close(s);
  lerrno = errno;
  free(s);
  s = NULL;
  caml_acquire_runtime_system();
  memcpy(Data_custom_val(sem), &s, sizeof(sem_t *));

  if (0 != rc) {
    goto ERROR;
  }

  result = caml_alloc(1, 0); // Result.Ok
  Store_field(result, 0, Val_unit);
  goto END;

ERROR:
  perrno = caml_alloc(2, 0);
  Store_field(perrno, 0, eunix); // `EUnix
  Store_field(perrno, 1, unix_error_of_code(lerrno));
  result = caml_alloc(1, 1); // Result.Error
  Store_field(result, 0, perrno);

END:
  CAMLreturn(result);
}

CAMLprim value stub_sem_unlink(value path) {
  CAMLparam1(path);
  CAMLlocal2(result, perrno);
  int rc, lerrno;
  char *p;
  size_t plen;

  plen = caml_string_length(path);
#ifdef NOALLOCA
  if (NULL == (p = malloc(msg_len + 1))) {
    caml_raise_out_of_memory();
  }
#else
  p = alloca(plen + 1);
#endif
  memcpy(p, String_val(path), plen);
  p[plen] = '\0';

  caml_release_runtime_system();
  rc = sem_unlink(p);
  lerrno = errno;
#ifdef NOALLOCA
  free(p);
#endif
  caml_acquire_runtime_system();

  if (0 != rc) {
    goto ERROR;
  }

  result = caml_alloc(1, 0); // Result.Ok
  Store_field(result, 0, Val_unit);
  goto END;

ERROR:
  perrno = caml_alloc(2, 0);
  Store_field(perrno, 0, eunix); // `EUnix
  Store_field(perrno, 1, unix_error_of_code(lerrno));
  result = caml_alloc(1, 1); // Result.Error
  Store_field(result, 0, perrno);

END:
  CAMLreturn(result);
}

static int open_flag_table[] = {
  O_RDONLY,
  O_WRONLY,
  O_RDWR,
  O_NONBLOCK,
  O_APPEND,
  O_CREAT,
  O_TRUNC, O_EXCL,
  O_NOCTTY,
  O_DSYNC,
  O_SYNC,
  O_RSYNC,
  0 /* O_SHARE_DELETE */,
  O_CLOEXEC,
};

CAMLprim value stub_sem_open(value path, value flags, value perm, value size) {
  CAMLparam4(path, flags, perm, size);
  CAMLlocal2(result, perrno);
  int s, fs, lerrno;
  mode_t mode;
  char *p;
  size_t plen;
  sem_t *sem;

  fs = convert_flag_list(flags, open_flag_table);
  mode = Int_val(perm);
  s = Int_val(size);

  plen = caml_string_length(path);
#ifdef NOALLOCA
  if (NULL == (p = malloc(msg_len + 1))) {
    caml_raise_out_of_memory();
  }
#else
  p = alloca(plen + 1);
#endif
  memcpy(p, String_val(path), plen);
  p[plen] = '\0';

  caml_release_runtime_system();
  sem = sem_open(p, fs, mode, s);
  lerrno = errno;
#ifdef NOALLOCA
  free(p);
#endif
  caml_acquire_runtime_system();

  if (SEM_FAILED == sem) {
    goto ERROR;
  }
  
  result = caml_alloc(1, 0); // Result.Ok
  Store_field(result, 0, caml_copy_semaphore(sem));
  goto END;

ERROR:
  perrno = caml_alloc(2, 0);
  Store_field(perrno, 0, eunix); // `EUnix
  Store_field(perrno, 1, unix_error_of_code(lerrno));
  result = caml_alloc(1, 1); // Result.Error
  Store_field(result, 0, perrno);

END:
  CAMLreturn(result);
}

