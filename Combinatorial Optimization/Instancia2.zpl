#cant. de escuelas
param M := 742;

#conjunto de empresas
set I:= {1,2};

#conjunto de zonas (unidades ...)
set J:= {1,2,3};

#empresas en cada zona
set h[J] := <1> {1}, <2> {2}, <3> {1, 2};

#zonas de cada empresa
set k[I] := <1> {1,3}, <2> {2,3};

#cant de escuelas por zona
param e[J] := <1> 195, <2> 93, <3> 454;

#intervalos
set T:= {1..13};

#minimos y maximos
param inicio[T] := <1> 0, <2> 20, <3> 40, <4> 60, <5> 80, <6> 100, <7> 150, <8> 200, <9> 300, <10> 400, <11> 500, <12> 600, <13> 700;
param fin[T] := <1> 19, <2> 39, <3> 59, <4> 79, <5> 99, <6> 149, <7> 199, <8> 299, <9> 399, <10> 499, <11> 599, <12> 699, <13> 742;

param c[I*T] :=     | 1,    2,    3,    4,    5,    6,    7,    8,    9,    10,   11,   12,   13   |
									|1| 3000, 3000, 3000, 3000, 3000, 2850, 2550, 2250, 1650, 1350, 1200, 1050, 1050 |
									|2| 1500, 1500, 1500, 1500, 1425, 1350, 1275, 1125, 975,  975,  975,  975,  975  |;

#cant de escuelas en zona j para empresa i
var x[I*J] integer;

# intervalo t se aplica a empresa i
var y[I*T] binary;

#cant de escuelas en intervalo t para empresa i
var z[I*T] integer;

minimize precio: sum <i,t> in I*T : c[i,t] * z[i,t];

subto r6: forall <j> in J:   sum <i> in h[j]  : x[i,j] == e[j];
subto r7: forall <i,t> in I*T:   sum <j> in k[i]  : x[i,j] >= inicio[t] - M*(1-y[i,t]);
subto r8: forall <i,t> in I*T:   sum <j> in k[i]  : x[i,j] <= fin[t] + M*(1-y[i,t]);
subto r9: forall <i> in I: sum <t> in T : y[i,t] == 1;
subto r10: forall <i,t> in I*T: z[i,t] + M*(1-y[i,t]) >= sum <j> in k[i]: x[i,j];

subto r11: forall <i,j> in I*J: x[i,j] >= 0;
subto r13: forall <i,t> in I*T: z[i,t] >= 0;
