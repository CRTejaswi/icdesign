* Spintronics Modules

** Modules **

* FM
.subckt G_FM2 1c 2c 1z 2z 1x 2x 1y 2y THETA A=1e-14  L=1e-7  rho=19*1e-8
+lsf=5e-9 P=0.23
.param g={A/(rho*L)}
.param inf=101

Gc12 1c 2c cur=g * (v(1c) - v(2c) + P * cos(v(THETA)) * v(1z) - P * cos(v(THETA)) * v(2z) - P
+* sin(v(THETA)) * v(1x) + P * sin(v(THETA)) * v(2x))

Gz12 1z 2z cur=g * cos(v(THETA)) * (P * lsf * sinh(L / lsf) * v(1c) - P * lsf * sinh(L / lsf) * v(2c) + cos(v(THETA)) *
+P * P * lsf * sinh(L / lsf) * v(1z) - cos(v(THETA)) * P * P * lsf * sinh(L / lsf) * v(2z) + cos(v(THETA)) * L * v(1z) - cos(v(THETA))
+* L * v(2z) - cos(v(THETA)) * L * P * P * v(1z) + cos(v(THETA)) * L * P * P * v(2z) - sin(v(THETA)) * P * P * lsf * sinh(L / lsf)
+* v(1x) + sin(v(THETA)) * P * P * lsf * sinh(L / lsf) * v(2x) - sin(v(THETA)) * L * v(1x) + sin(v(THETA)) * L * v(2x) + sin(v(THETA)) *
+L * P * P * v(1x) - sin(v(THETA)) * L * P * P * v(2x)) / lsf / sinh(L / lsf)

Gx12 1x 2x cur = -g * sin(v(THETA)) * (P * lsf * sinh(L / lsf) * v(1c) - P * lsf * sinh(L / lsf)
+* v(2c) + cos(v(THETA)) * P * P * lsf * sinh(L / lsf) * v(1z) - cos(v(THETA)) * P * P * lsf * sinh(L / lsf) *
+v(2z) + cos(v(THETA)) * L * v(1z) - cos(v(THETA)) * L * v(2z) - cos(v(THETA)) * L * P * P * v(1z) + cos(v(THETA)) * L * P * P * v(2z) - sin(v(THETA))
+* P * P * lsf * sinh(L / lsf) * v(1x) + sin(v(THETA)) * P * P * lsf * sinh(L / lsf) * v(2x) - sin(v(THETA)) * L * v(1x) + sin(v(THETA))
+* L * v(2x) + sin(v(THETA)) * L * P * P * v(1x) - sin(v(THETA)) * L * P * P * v(2x)) / lsf / sinh(L / lsf)

Gz11 1z 0 cur=-g * (-L * sinh(L / lsf / 2) * cos(v(THETA))*cos(v(THETA)) + L * sinh(L / lsf / 2) *
+P * P * cos(v(THETA))*cos(v(THETA)) - inf * lsf * cosh(L / lsf / 2) + cos(v(THETA))*cos(v(THETA)) *
+inf * lsf * cosh(L / lsf / 2)) / cosh(L / lsf / 2) / lsf * v(1z) + cos(v(THETA)) * g * sin(v(THETA)) *
+(-L * tanh(L / lsf / 2) + L * tanh(L / lsf / 2) *
+P * P + inf * lsf) / lsf * v(1x)

Gx11 1x 0  cur=cos(v(THETA)) * g * sin(v(THETA)) * (-L * tanh(L / lsf / 2) + L * tanh(L / lsf / 2) *
+P * P + inf * lsf) / lsf * v(1z) + g * (L * sinh(L / lsf / 2) - L * sinh(L / lsf / 2) *
+cos(v(THETA))*cos(v(THETA)) - L * sinh(L / lsf / 2) * P * P + L * sinh(L / lsf / 2) * P * P *
+cos(v(THETA))*cos(v(THETA)) + cos(v(THETA))*cos(v(THETA))
+* inf * lsf * cosh(L / lsf / 2)) /
+cosh(L / lsf / 2) / lsf * v(1x)

Gy11 1y 0  cur=g*inf*v(1y)

Gz22 2z 0  cur=-g * (-L * sinh(L / lsf / 2) * cos(v(THETA))*cos(v(THETA)) + L * sinh(L / lsf / 2)
+* P * P * cos(v(THETA))*cos(v(THETA)) - inf * lsf * cosh(L / lsf / 2) + cos(v(THETA))*cos(v(THETA))
+* inf * lsf * cosh(L / lsf / 2)) / cosh(L / lsf / 2) / lsf * v(2z) + cos(v(THETA)) *
+g * sin(v(THETA)) * (-L * tanh(L / lsf / 2) + L * tanh(L / lsf / 2)
+* P * P + inf * lsf) / lsf * v(2x)

Gx22 2x 0  cur=cos(v(THETA)) * g * sin(v(THETA)) * (-L * tanh(L / lsf / 2) + L * tanh(L / lsf / 2) *
+P * P + inf * lsf) / lsf * v(2z) + g * (L * sinh(L / lsf / 2) - L * sinh(L / lsf / 2) *
+cos(v(THETA))*cos(v(THETA)) - L * sinh(L / lsf / 2) * P * P + L * sinh(L / lsf / 2) * P * P * cos(v(THETA))*cos(v(THETA))
+ + cos(v(THETA))*cos(v(THETA)) * inf * lsf * cosh(L / lsf / 2)) / cosh(L / lsf / 2) / lsf * v(2x)

Gy22 2y 0  cur=g*inf*v(2y)
.ends


* FM-NM Interface
.subckt G_FMI_NM cFM cNM zFM zNM xFM xNM yFM yNM Gc=1e-6 gs=1 Gr=1 Gi=1
.param gain=Gi/Gr
*** series block ***
Rc cFM cNM r=1/Gc
Rz zFM zNM r=1/gs
*** shunt block ***
Rx xFM xNM r=1/Gr
Gx xFM xNM cur=gain*(v(yFM)-v(yNM))

Ry yFM yNM r=1/Gi
Gy yFM yNM cur=-gain*(v(xFM)-v(xNM))
.ends


* FM-NM
.subckt G_FM_NM cFM cNM zFM zNM xFM xNM yFM yNM  THETA PHI g=1 a=1 b=0

* These formulas are obtained from?? U(G)U???
* G = Gse or Gsh??
* U is the Rodriguez rotation matrix for (theta,phi)??
* 4x4 Conductance Matrix for the Series Component??

E11 d11 0 vol=g
E12 d12 0 vol=g*P*cos(v(THETA))
E13 d13 0 vol=g*P*sin(v(THETA))*cos(v(PHI))
E14 d14 0 vol=g*P*sin(v(THETA))*sin(v(PHI))

E21 d21 0 vol=g*P*cos(v(THETA))
E22 d22 0 vol=(g)*cos(v(THETA))*cos(v(THETA))
E23 d23 0 vol=(g)*sin(v(THETA))*cos(v(THETA))*cos(v(PHI))
E24 d24 0 vol=(g)*sin(v(THETA))*cos(v(THETA))*sin(v(PHI))

E31 d31 0 vol=g*P*sin(v(THETA))*cos(v(PHI))
E32 d32 0 vol=(g)*sin(v(THETA))*cos(v(THETA))*cos(v(PHI))
E33 d33 0 vol=(g)*sin(v(THETA))*sin(v(THETA))*cos(v(PHI))*cos(v(PHI))
E34 d34 0 vol=(g)*sin(v(THETA))*sin(v(THETA))*cos(v(PHI))*sin(v(PHI))

E41 d41 0 vol= (g)*P*sin(v(THETA))*sin(v(PHI))
E42 d42 0 vol= (g)*sin(v(THETA))*cos(v(THETA))*sin(v(PHI))
E43 d43 0 vol= (g)*sin(v(THETA))*sin(v(THETA))*cos(v(PHI))*sin(v(PHI))
E44 d44 0 vol=(g)*sin(v(THETA))*sin(v(THETA))*sin(v(PHI))*sin(v(PHI))

GC11 cFM cNM cur=v(d11)*(v(cFM)-v(cNM))
GC12 cFM cNM cur=v(d12)*(v(zFM)-v(zNM))
GC13 cFM cNM cur=v(d13)*(v(xFM)-v(xNM))
GC14 cFM cNM cur=v(d14)*(v(yFM)-v(yNM))

GZ21 zFM zNM cur=v(d21)*(v(cFM)-v(cNM))
GZ22 zFM zNM cur=v(d22)*(v(zFM)-v(zNM))
GZ23 zFM zNM cur=v(d23)*(v(xFM)-v(xNM))
GZ24 zFM zNM cur=v(d24)*(v(yFM)-v(yNM))

GX31 xFM xNM cur=v(d31)*(v(cFM)-v(cNM))
GX32 xFM xNM cur=v(d32)*(v(zFM)-v(zNM))
GX33 xFM xNM cur=v(d33)*(v(xFM)-v(xNM))
GX34 xFM xNM cur=v(d34)*(v(yFM)-v(yNM))

GY41 yFM yNM cur=v(d41)*(v(cFM)-v(cNM))
GY42 yFM yNM cur=v(d42)*(v(zFM)-v(zNM))
GY43 yFM yNM cur=v(d43)*(v(xFM)-v(xNM))
GY44 yFM yNM cur=v(d44)*(v(yFM)-v(yNM))

* 4x4 Conductance Matrix for the Shunt Component??
* First column is zero: No charge current through spin-shunts??

E55 d55 0 vol= g*a*sin(v(THETA))*sin(v(THETA))
E56 d56 0 vol= -g*sin(v(THETA))*(a*cos(v(PHI))*cos(v(THETA))+b*sin(v(PHI))) 
E57 d57 0 vol= -g*sin(v(THETA))*(a*sin(v(PHI))*cos(v(THETA))-b*cos(v(PHI))) 

E65 d65  0 vol= g*sin(v(THETA))*(-a*cos(v(PHI))*cos(v(THETA))+b*sin(v(PHI))) 
E66 d66  0 vol= g*a*( cos(v(PHI))*cos(v(PHI))*cos(v(THETA))*cos(v(THETA))+1-cos(v(PHI))*cos(v(PHI))) 
E67 d67  0 vol= g*(-a*sin(v(PHI))*cos(v(PHI))+a*sin(v(PHI))*cos(v(PHI))*cos(v(THETA))*cos(v(THETA))-b*cos(v(THETA)))

E75 d75  0 vol=-g*sin(v(THETA))*(a*sin(v(PHI))*cos(v(THETA))+b*cos(v(PHI)))  
E76 d76  0 vol=g*(-a*sin(v(PHI))*cos(v(PHI))+a*sin(v(PHI))*cos(v(PHI))*cos(v(THETA))*cos(v(THETA))+b*cos(v(THETA)))
E77 d77  0 vol=-g*a*(-cos(v(PHI))*cos(v(PHI))+cos(v(PHI))*cos(v(PHI))*cos(v(THETA))*cos(v(THETA))-cos(v(THETA))*cos(v(THETA))) 

GZ55 zNM 0 cur=v(d55)*(v(zNM))
GZ56 zNM 0 cur=v(d56)*(v(xNM))
GZ57 zNM 0 cur=v(d57)*(v(yNM))

GX65 xNM 0 cur=v(d65)*(v(zNM))
GX66 xNM 0 cur=v(d66)*(v(xNM))
GX67 xNM 0 cur=v(d67)*(v(yNM))

GY75 yNM 0 cur=v(d75)*(v(zNM))
GY76 yNM 0 cur=v(d76)*(v(xNM))
GY77 yNM 0 cur=v(d77)*(v(yNM))

.ends

* Giant Spin-Hall Effect
.subckt G_GSHE 1c 2c 3z 4z 3x 4x 3y 4y theta=-0.12 L=100*1e-9 W=250*1e-9
+t=20*1e-9 rho=11.3*1e-8 lsf=40*1e-9 
.param gc=t*W/L/rho
.param gsse= W*L/rho/lsf/sinh(t/lsf)
.param gssh= W*L/rho/lsf*tanh(t/2/lsf)
.param gcz= W*theta/rho

Rcc 1c 2c r=1/gc
Gc1 1c 0  cur=-gcz*(v(3z)-v(4z))
Gc2 2c 0  cur= gcz*(v(3z)-v(4z))

Rse  3z 4z r=1/gsse
Rsh1 3z  0 r=1/gssh
Rsh2 4z  0 r=1/gssh 

Gs1 4z 0 cur=-gcz*(v(1c)-v(2c))
Gs2 3z 0 cur=gcz*(v(1c)-v(2c))

.ends

* Magnetic Tunnel Junction
.subckt G_MTJ 1c 2c 1z 2z 1x 2x 1y 2y THETA sz sx sy  
.param inf = 1e20

Gcc 1c 2c cur=G0*(1+P*P*cos(v(THETA)))*(v(1c)-v(2c))
Gzz 1z 2z cur=G0*inf*(v(1z)-v(2z))
Gxx 1x 2x cur=G0*inf*(v(1x)-v(2x))
Gyy 1y 2y cur=G0*inf*(v(1y)-v(2y))

Ezz sz 0 vol=conv*-i(Gzz)
Exx sx 0 vol=conv*-i(Gxx)
Eyy sy 0 vol=conv*-i(Gyy)

.ends


.subckt G_MTJ 

* NM
.subckt G_NM 1c 2c 1z 2z 1x 2x 1y 2y  A=1e-18 L=1e-9 rho=1 lsf=1e-9

* Internal parameters
.param gcse=A/(rho*L)
.param gsse=gcse*(L/lsf)/sinh(L/lsf)
.param gssh=gcse*(L/lsf)*tanh(L/(2*lsf))

* Series t1-t2 
Rc12 1c 2c r=1/gcse
Rx12 1x 2x r=1/gsse
Ry12 1y 2y r=1/gsse
Rz12 1z 2z r=1/gsse

* Shunt for spin t1
Rx10 1x 0 r=1/gssh
Ry10 1y 0 r=1/gssh
Rz10 1z 0 r=1/gssh

* Shunt for spin t2
Rx20 2x 0 r=1/gssh
Ry20 2y 0 r=1/gssh
Rz20 2z 0 r=1/gssh

.ends

.subckt G_PSC t1c t2c t1z t2z A=1e-18 L=1e-9 rho=1 lsf=1e-9 gc=1e-6

* Internal parameters
.param gcse=A/(rho*L)
.param gsse=gcse*(L/lsf)/sinh(L/lsf)
.param gssh=gcse*(L/lsf)*tanh(L/(2*lsf))

* Series t1-t2 
Rc12 t1c t2c r=1/Gc
Rz12 t1z t2z r=1/gsse

* Shunt for spin t1
Rz10 t1z 0 r=1/gssh

* Shunt for spin t2
Rz20 t2z 0 r=1/gssh

.ends


* Rashba Spin-Orbit Coupling
.subckt G_RSO V1c V2c V1z V2z V1x V2x V1y V2y

GCC1 V1c 0 cur=G0 * v(V1c) - G0 * v(V2c)
GZZ1 V1z 0 cur=G0 * v(V1z) - G0 * cos(theta) * v(V2z) - G0 * sin(theta) * v(V2x)
GXX1 V1x 0 cur=G0 * v(V1x) + G0 * sin(theta) * v(V2z) - G0 * cos(theta) * v(V2x)
GYY1 V1y 0 cur=G0 * v(V1y) - G0 * v(V2y)


GCC2 V2c 0 cur=G0 * v(V2c) - G0 * v(V1c)
GZZ2 V2z 0 cur=G0 * v(V2z) - G0 * cos(theta) * v(V1z) + G0 * sin(theta) * v(V1x)
GXX2 V2x 0 cur=G0 * v(V2x) - G0 * sin(theta) * v(V1z) - G0 * cos(theta) * v(V1x)
GYY2 V2y 0 cur=G0 * v(V2y) - G0 * v(V1y)
.ends
.subckt LLG_BLOCK Theta Phi HSX HSY HSZ 

CTHETA Theta 0 c=tau
CPHI Phi 0 c=tau
GTHETA 0 Theta cur=-sin(v(Theta)) * hp * cos(v(Phi)) * sin(v(Phi)) - sin(v(Theta)) * alpha * cos(v(Theta)) - sin(v(Theta)) * alpha * hp * cos(v(Phi)) ^ 2 * cos(v(Theta)) - hs * v(HSZ) * sin(v(Theta)) + hs * sin(v(Phi)) * v(HSY) * cos(v(Theta)) + hs * cos(v(Phi)) * v(HSX) * cos(v(Theta)) + hs * cos(v(Phi)) * alpha * v(HSY) - hs * sin(v(Phi)) * alpha *v(HSX)
GPHI   0 Phi   cur=alpha * hp * sin(v(Phi)) * cos(v(Phi)) - cos(v(Phi)) ^ 2 * cos(v(Theta)) * hp - cos(v(Theta)) - hs * (v(HSX) * sin(v(Phi)) - alpha * v(HSZ) * sin(v(Theta)) + alpha * cos(v(Theta)) * v(HSY) * sin(v(Phi)) + cos(v(Phi)) * alpha * cos(v(Theta)) * v(HSX) - cos(v(Phi)) * v(HSY)) / sin(v(Theta))
EMX 6  0 vol=sin(v(Theta))*cos(v(Phi))
EMY 7  0 vol=sin(v(Theta))*sin(v(Phi))
EMZ 8  0 vol=cos(v(Theta))

.ends
