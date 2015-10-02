#ifndef POSIX_MATH_H
#define POSIX_MATH_H

#include <semaphore.h>
#include <caml/mlvalues.h>

#define Sem_val(v) ((sem_t **) Data_custom_val(v))
CAMLextern value caml_copy_semaphore(sem_t *s);

#endif

