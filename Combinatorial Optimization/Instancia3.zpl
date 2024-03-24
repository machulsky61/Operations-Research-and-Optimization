#cant. de escuelas
param M := 742;

#conjunto de empresas
set I:= {1..4}; 

#conjunto de zonas (competition units)
set J:= {1..8}; 

#empresas en cada zona
set h[J] := <1> {1 ,2, 3, 4}, <2> {2,3,4}, <3> {1, 3, 4}, <4> {1, 2, 4}, <5> {3, 4}, <6> {2, 4}, <7> {1, 4}, <8> {4};  

#zonas de cada empresa
set k[I] := <1> {1,3,4,7}, <2> {1,2,4,6}, <3> {1,2,3,5}, <4> {1,2,3,4,5,6,7,8};

#cant de escuelas por zona
param e[J] := <1> 39, <2> 54, <3> 50, <4> 101, <5> 230, <6> 88, <7> 49, <8> 131;

#intervalos
set T:= {1..13};

#minimos y maximos
param inicio[T] := <1> 0, <2> 20, <3> 40, <4> 60, <5> 80, <6> 100, <7> 150, <8> 200, <9> 300, <10> 400, <11> 500, <12> 600, <13> 700;
param fin[T] := <1> 19, <2> 39, <3> 59, <4> 79, <5> 99, <6> 149, <7> 199, <8> 299, <9> 399, <10> 499, <11> 599, <12> 699, <13> 742;

param c[I*T] :=   | 1,    2,  3,  4, 5,       6,      7,      8,      9,      10,     11,     12,      13            |
		|1| 2662,    2662,   2662, 1783.54, 1464.1, 1464.1, 1464.1, 1464.1, 1464.1, 1464.1, 1464.1, 1464.1, 1464.1 |
		|2| 1891.45, 1791.9, 1692.35, 1493.25, 1294.15, 1294.15, 1294.15, 1294.15, 1294.15, 1294.15, 1294.15, 1294.15, 1294.15 |
		|3| 1605  ,  1316.1, 1155.6 ,  963  ,  802.5 ,  658.05,  561.75, 561.75,  561.75,  561.75,  561.75,  561.75,  561.75|
		|4| 4697  ,  4697,   4697 , 4697  , 4697 , 4227.3 , 3992.45, 3757.6 , 3287.9 , 2818.2 , 2348.5 , 1878.8 ,  939.4  |;

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

#subto r11: forall <j> in J: forall <i> in h[j]: x[i,j] >= 0;
subto r11: forall <i,j> in I*J: x[i,j] >= 0;
subto r13: forall <i,t> in I*T: z[i,t] >= 0;
