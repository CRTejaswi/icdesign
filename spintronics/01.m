% Spin circuit description of a non-local spin valve
clear all

%Constants (all MKS, except energy which is in eV)
q=1.6e-19;Z=zeros(2,2);

% Parameters
% note: R => rho*lambda_sf/A; L => L/lambda_sf
ii=0;
for X=-5:0.1:5
   ii=ii+1; RT(ii)=X; RT1=10^X; RT2=10^X;% Tunnel Resistance
   PT1=0.2; PT2=0.2;% Polarization of Tunnel Contacts
   RF=1e-2; LF1=100; LF2=100; PF1=0.05; PF2=0.05;% Ferromagnetic contacts
   RN=1; LN1=100; LN2=1e-3; LN3=100;% Nonmagnetic Channel

  % Ferromagnetic contacts
  GF1 = ((1/RF/LF1)*[1 PF1;PF1 PF1*PF1])+(((1-PF1*PF1)/RF)*[0 0; 0 ...
            csch(LF1)]);
  GF2 = ((1/RF/LF2)*[1 PF2;PF2 PF2*PF2])+(((1-PF2*PF2)/RF)*[0 0; 0 ...
            csch(LF2)]);
  G0F1 = ((1-PF1*PF1)/RF)*[0 0;0 coth(LF1)-csch(LF1)];
  G0F2 = ((1-PF2*PF2)/RF)*[0 0;0 coth(LF2)-csch(LF2)];

  % Normal channel
  GN1 = (1/RN/LN1)*[1 0;0 LN1*csch(LN1)];
  GN2 = (1/RN/LN2)*[1 0;0 LN2*csch(LN2)];
  GN3 = (1/RN/LN3)*[1 0;0 LN3*csch(LN3)];
  G0N1 = (1/RN)*[0 0;0 coth(LN1)-csch(LN1)];
  G0N2 = (1/RN)*[0 0;0 coth(LN2)-csch(LN2)];
  G0N3 = (1/RN)*[0 0;0 coth(LN3)-csch(LN3)];

  % Tunnel resistances
  GT1=(1/RT1)*[1 PT1;PT1 1];
  GT2=(1/RT2)*[1 PT2;PT2 1];

  % Conductance matrix from KCL
  G = [G0F1+GF1 -GF1 Z Z Z Z Z;
    -GF1 G0F1+GF1+GT1 Z Z -GT1 Z Z;
    Z Z G0F2+GF2 -GF2 Z Z Z;
    Z Z -GF2 G0F2+GF2+GT2 Z -GT2 Z;
    Z -GT1 Z Z GN1+G0N1+G0N2+GN2+GT1 -GN2 Z;
    Z Z Z -GT2 -GN2 GN3+G0N2+G0N3+GN2+GT2 -GN3;
    Z Z Z Z Z -GN3 GN3+G0N3];

  C = [1; PF1; zeros(12,1)];% Terminal currents
  V=G\C; V=reshape(V,2,7);% Terminal voltages
  Vout(ii)=V(1,3)-V(1,7);% Output voltage

  %%% Takahashi and Maekawa formula (PRB. 67, 052409)
  RF1=RF; RF2=RF;
  Numer = 2*RN*exp(-LN2)*(PT1*RT1/RN/(1-PT1^2) + PF1*RF1/RN/(1-PF1^2))...
    *(PT2*RT2/RN/(1-PT2^2) + PF2*RF2/RN/(1-PF2^2));
  denom = (1+ 2*RT1/RN/(1-PT1^2) + 2*RF1/RN/(1-PF1^2))...
    *(1+ 2*RT2/RN/(1-PT2^2) + 2*RF2/RN/(1-PF2^2)) - exp(-LN2);
  Rnon_local(ii)=Numer/denom;
end

hold on
plot(RT,Vout/C(1),'r*');
plot(RT,Rnon_local,'bo');
set(gca,'linewidth',[3.0]);
set(gca,'Fontsize',[24]);
xlabel('log10(Tunnel resistance) -->')
ylabel('Output Voltage -->')
grid on
