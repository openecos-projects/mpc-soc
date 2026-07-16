ENTRY(_start)

MEMORY {
  ROM (rx) : ORIGIN = 0x30000000, LENGTH = 64K
}

SECTIONS {
  .text : {
    *(entry)
    *(.text*)
    *(.rodata*)
  } > ROM
}
