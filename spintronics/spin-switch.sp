* IMA Spin-Switch
.include 'G_FM-NM.sp'
.include 'LLG.sp'
.include 'G_GSHE.sp'
.include 'G_Fixed.sp'
.include 'Mixed_Coupling.sp'


.subckt GSHE_SS w_in w_out r_out r_inp r_inn
.param pi='acos(-1)'
* Dual Reader MTJ
XMTJ r_inp r_inn r_out thetaR phiR IszR IsxR IsyR G_Fixed G0='1e-3' P='0.7'
* Writer
XLLGW HWx HWy HWz IsxW IsyW IszW thetaW phiW LLG_C
+ alpha='0.01' Hk='130' Area='80e-9*100e-9' tfm='2e-9' Ms='800' ima='1'
* Reader
XLLGR HRx HRy HRz IsxW IsyW IszW thetaW phiW LLG_C
+ alpha='0.01' Hk='130' Area='80e-9*100e-9' tfm='2e-9' Ms='800' ima='1'
* Magnetic-Coupling
XMagneticCoupling mxR myR mzR mxW myW mzW HRx HRy HRz HWx HWy HWz
Magnetic_Coupling 
+ MsR='800' VolR='80e-9*100e-9*2e-9'
+ MsW='800' VolW='80e-9*100e-9*2e-9'
+ dyy='-0.203' dxx='0.296' dzz='-0.093' dxy='0' dxz='0' dyz='0'
* FM/NM Interface for writer FM
XWriteLayer 3c 4c 0 7z 0 7x 0 7y thetaW phiW IsxW IsyW IszW G_FM_NM
+ g='5e15*(80*100*1e-18)' a='1' b='0' P='0.7'
XGSHE w_in 0 3z 0 3x 0 3y 0 G_GSHE
+ theta='-0.3' L='80*1e-9' W='100*1e-9' t=;'2*1e-9'











