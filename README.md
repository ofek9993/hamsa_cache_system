Our project is to integrate the PULP hierarchical cache system into the HAMSA dual-issue RISC-V processor.

For more information about the cache system, see:
https://github.com/pulp-platform/hier-icache/tree/master

For details about the AXI components, see:
https://github.com/pulp-platform/axi

A very basic overview of our testbench environment:

<img width="6000" height="3375" alt="block" src="https://github.com/user-attachments/assets/ce623023-f93b-4774-81a9-99bd89856377" />

We added the cache system in:
ddp23_pnx/src/ips/hier_icache
and created ddp23_pnx/src/ips/hier_icache/hier_icache.f to include all dependency files. Finally, we added it to ddp23_pnx/src/ips/pulpenix/pulpenix.f, which is the base testbench compilation file.

We also changed the instruction memory to be 32-bit wide but kept the core as dual-issue. This is because the cache ↔ AXI transactions operate with a 32-bit data width, while the PULP cache system can be configured to fetch instruction data at 128-bit width. Therefore, we needed to slice the memory into 32-bit chunks. More information about how to change this can be found in:
ddp23_pnx/docs
