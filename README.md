# Integration of PULP Hierarchical Cache into the HAMSA Dual-Issue Processor

## Project Overview  
This project integrates the **PULP hierarchical instruction cache system** into the **HAMSA dual-issue (DI) RISC-V processor**.  

We started from the baseline implementation of the HAMSA DI system:  
<img width="1250" height="722" alt="HAMSA block diagram" src="https://github.com/user-attachments/assets/0abd765d-cce7-4cf6-8c77-fa4113d7f25f" />

---

## Cache System Integration  
To implement the new PULP cache system, we connected it directly to the HAMSA core, replacing the original **TCIM** and instead using **external instruction memory**.  

The PULP cache has a hierarchical structure:  
- **L1 cache** – private to each core, 512B in size.  
- **L1.5 cache** – shared, 4KB in size.  
- On an **L1 miss**, the L1 controller refills from the L1.5 cache.  
- On an **L1.5 miss**, the cache system issues AXI transactions to external instruction memory for refill.  

A high-level overview of the PULP instruction cache system:  
<img width="1034" height="744" alt="PULP hierarchical cache diagram" src="https://github.com/user-attachments/assets/253aec58-ae14-4c5c-97f6-d91c627e6b44" />

For more information, see the [hier-icache repository](https://github.com/pulp-platform/hier-icache/tree/master).

---

## AXI Integration and Arbiter  
To support this design, we introduced an **AXI arbiter/multiplexer**. This was required because the core region contains two separate AXI nodes:  
1. **Instruction AXI** – used by the cache for refills.  
2. **Data AXI** – used by the core load-store unit for memory and peripheral access.  

We adopted the arbiter/mux module from the [PULP AXI repository](https://github.com/pulp-platform/axi).  

The resulting block diagram of our implementation (Blocks that are in Yellow are the one we changed):  
<img width="6000" height="3375" alt="Integrated block diagram" src="https://github.com/user-attachments/assets/ce623023-f93b-4774-81a9-99bd89856377" />

---

## Implementation Details  
- The cache system was added under:
ddp23_pnx/src/ips/hier_icache
- Dependencies were listed in:
- ddp23_pnx/src/ips/hier_icache/hier_icache.f
-The main testbench compilation file was updated:  
ddp23_pnx/src/ips/pulpenix/pulpenix.f
- A description of the full hierarchy, dependencies, and modified internal PULP cache files can be found in:  
ddp23_pnx/src/ips/hier_icache/Structure of the hier-icache dependencies and changes

---

## Instruction Memory Adaptation  
We changed the **instruction memory width** to **32 bits** while keeping the core dual-issue. This was necessary because:  
- AXI ↔ cache transactions operate on a 32-bit width.  
- The PULP cache can fetch instructions at **128-bit width**.  
- Therefore, the memory had to be **sliced into 32-bit chunks**.  

More documentation on how to modify this is available in:  
ddp23_pnx/docs


