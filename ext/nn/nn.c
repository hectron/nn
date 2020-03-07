#include "nn.h"

VALUE rb_mNn;

void
Init_nn(void)
{
  rb_mNn = rb_define_module("Nn");
}
