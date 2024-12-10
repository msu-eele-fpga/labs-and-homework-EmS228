# Lab 10: Device Trees

## Overview
Embedded systems often have many external peripherals (LEDs, switches, buttons, Ethernet controllers,
ADCs/DACs, etc.) attached via various buses (I2C, SPI, etc.). When an embedded Linux system boots, how
does it know what hardware exists? We could hardcode the hardware details into the operating system
and/or device drivers, but then we would have to do that for every embedded board we ever create—that
would be a lot of work. Instead, modern embedded Linux systems use a device tree, which is a data
structure for describing hardware. From devicetree.org:

“The devicetree is a data structure for describing hardware. Rather than hard coding every
detail of a device into an operating system, many aspects of the hardware can be described in
a data structure that is passed to the operating system at boot time.”

“A devicetree is a tree data structure with nodes that describe the devices in a system. Each
node has property/value pairs that describe the characteristics of the device being repre-
sented. Each node has exactly one parent except for the root node, which has no parent.”

We’ll use device trees to inform Linux about our custom hardware (what memory address it’s located at,
how many registers it has, etc.). This enables our device drivers to interact with our custom hardware.
This lab relies heavily on the sysfs psuedo-filesystem. sysfs is many things, but it essentially provides
access to kernel-related system information, e.g., device parameters, filesystems, etc. We will use files in
sysfs to control the LEDs. For a brief overview, consult the sysfs(5) man page. We will gradually become
more familiar with sysfs, but for now, we’ll learn mostly by exploring the filesystem. One of the best ways
to learn is to navigate the sysfs filesystem and see what’s there; we encourage you to poke around the /sys
directory on your virtual machine and/or the DE10-Nano.

## Deliverables
All deliverables were demoed to the professor. 

## Questions
+ What is the purpose of a device tree?
    
    The device tree is a simple tree structure of nodes and properties. This connects hardware to the software. 
