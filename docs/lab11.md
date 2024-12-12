# Lab 11: Platform Device Driver

## Overview
In this lab, we’ll create a device driver for our LED patterns component. We’re going to create the device
driver from scratch, building it up bit-by-bit and learning about each and every piece along the way.

## Deliverables
All deliverables were demoed to the professor. 

## Questions
+ What is the purpose of the platform bus?
    
    The platform bus is connection virtually of the hardware devices to the operating system.

+ Why is the device driver's compatible property important?
    
    If the device driver is not commpatible then the device does not get bound to the driver. 

+ What is the probe function's purpose?
    
    It allocates kernel-space in memory, requests and remaps the devices physical memory, and attaches the state container to the platform device.  

+ How does your driver know what memory addresses are associated with your device?
    
    The values are set in the probe function with the offsets for each register used as variables at the top. 

+ What are the two ways we can write to our device's registers? In other words, what subsystems do we use to write to our registers?
    
    We use the misc subsystem to write to the registers, and the input subsystem, or the watchdog subsystem. These are seen in Figure 2 in the lab instructions.  

+ What is the purpose of our struct led_patterns_dev state container?
    
    The led_patterns_dev struct contains pointers to each of the registers. The __iomem token specifies that the pointer points to I/O memory, which allows the kernel to perform some code-correctness checks.