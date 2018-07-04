#!/bin/bash
if [ -e /etc/generic-makefile ]
   make -f /etc/generic-makefile/Makefile clean
   sudo rm -rf /etc/generic-makefile
fi
