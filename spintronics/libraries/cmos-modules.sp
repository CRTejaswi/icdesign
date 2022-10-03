
.include 'tsmc180nm.lib'
.param SUPPLY=1.8

** Modules **

* Inverter
.subckt INV INPUT OUTPUT GND
VDD n1 GND SUPPLY
Mn1 OUTPUT INPUT GND GND CMOSN W=1u L=180n
Mp1 OUTPUT INPUT n1 n1 CMOSP W=2u L=180n
.ends

