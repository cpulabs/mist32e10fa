MIST32 Type-E - Open Source 32bit Processor
==================

Open Design Computer Project - [http://open-arch.org/](http://open-arch.org/)

MIST32E10FA
---
In order execution processor for MIST32 Type-E arcitecture.

If you need support of Operation System, We offers a MIST1032SA out of order execute processor and MIST1032ISA in order execute processor.

[MIST1032SA](https://github.com/cpulabs/mist1032sa)
[MIST1032ISA](https://github.com/cpulabs/mist1032isa)

License
---
BSD 2-Clause License

See ./LICENSE

Directory
---
  com		:	Common file. Source path, Include path...
  
  src		:	Source
  
  sim		:	Simulation


Include
---
  ./include/processor.h				:	Processor Infomation
  
  ./include/irq.h						:	Interrupt Infomation
  
  ./core/include/core.h				:	Instruction and Internal format

  
Tool
---
We have validated the correctness of this design in the following tools.

***Simulator***

Modelsim
 
 
***Synthesis***

Quartus II(Altera)

