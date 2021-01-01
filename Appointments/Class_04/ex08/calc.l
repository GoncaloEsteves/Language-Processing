%{
#include "tokens.h"
%}
%%

[0-9]+          return INT;
(\+|\*|\-|\/)   return OP;
\(              return AP;
\)              return FP;
[\ \r\t]        ;
.               return ERRO;
