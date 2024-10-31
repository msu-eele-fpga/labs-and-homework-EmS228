# Lab 7: Verifying Your Custom Component Using System Console and /dev/mem

## Overview
We will use /dev/mem to test the software control mode of your HPS_LED_Patterns
hardware component. In Linux, /dev/mem is a character device file whose byte addresses are interpreted as physical memory addresses. You already know the physical address of your registers because you created them and placed them in memory
with Platform Designer. Thus you can directly write to the LED_reg register to
create patterns on the LEDs from software.

## Deliverables

### Questions

> What hex value did you write to base_period to have a 0.125 second base period?

I used the base period hex value of 0x2.

> What hex value did you write to base_period to have a 0.5625 second base period?

I used the base period value of 0x9.
