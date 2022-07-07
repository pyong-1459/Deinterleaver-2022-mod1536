# Deinterleaver-2022-mod1536
## Project Specification
Deinterleaving A~H interleaved data

A~H: vector of range(1536) each

### Interleave rule
A:  Out(8w+0) = A((w + 0)    mod 1536)

B:  Out(8w+1) = B((w + 768)  mod 1536)

C:  Out(8w+2) = C((w + 384)  mod 1536)

D:  Out(8w+3) = D((w + 1152) mod 1536)

E:  Out(8w+4) = E((w + 1344) mod 1536)

F:  Out(8w+5) = F((w + 192)  mod 1536)

G:  Out(8w+6) = G((w + 960)  mod 1536)

H:  Out(8w+7) = H((w + 576)  mod 1536)

w: range(1536)
## Verilog
### deinterleaver.v
Main Control logic
### sram.v
Behavior code of simple SRAM
### top_deinter.v
Merge deinterleaver.v and sram.v
### tb.v
Testbench with using vector1.txt
## Python
### vector_gen.py
Generate vector1.txt file
