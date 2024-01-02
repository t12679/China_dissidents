

*data cleaning

*drop observations before 1979
*drop in 1/6
*create a new firstchargedate variable that is 1 if after 1989
drop firstchargedateafter1988
gen firstchargedateafter1988=1 if firstchargedate>1988
replace firstchargedateafter1988=0 if firstchargedate<1989


gen firstchargedateafter1989=1 if firstchargedate>1989
replace firstchargedateafter1989=0 if firstchargedate<1990



drop firstchargedate1989
gen firstchargedate1989=1 if firstchargedate==1989
replace firstchargedate1989=0 if firstchargedate!=1989


*code fixed effects variables for tenure based on first charge date
drop deng
gen deng=1 if firstchargedate<1990 
replace deng=0 if firstchargedate>1989
replace deng=1 if firstchargedate<1990
drop jiang
gen jiang=0 if firstchargedate < 1990
replace jiang=1 if firstchargedate>1989
replace jiang=0 if firstchargedate>2002


drop hu
gen hu=0 if firstchargedate < 2003
replace hu=1 if firstchargedate>2002
replace hu=1 if firstchargedate<2013
replace hu=0 if firstchargedate>2012
replace hu=0 if firstchargedate<2003

drop xi
gen xi=0 if firstchargedate < 2013
replace xi=1 if firstchargedate>2012
drop regime
gen regime=0 if deng==1
replace regime=1 if jiang==1
replace regime=2 if hu==1
replace regime=3 if xi==1


*code fixed effects variables for tenure based on first charge date for denied and for exit date of those who leave
drop deng1
gen deng1=1 if bar_or_exit<1990 
replace deng1=0 if bar_or_exit>1989
replace deng1=1 if bar_or_exit<1990
drop jiang1
gen jiang1=0 if bar_or_exit < 1990
replace jiang1=1 if bar_or_exit>1989
replace jiang1=0 if bar_or_exit>2002


drop hu1
gen hu1=0 if bar_or_exit < 2003
replace hu1=1 if bar_or_exit>2002
replace hu1=1 if bar_or_exit<2013
replace hu1=0 if bar_or_exit>2012
replace hu1=0 if bar_or_exit<2003
drop xi1
gen xi1=0 if bar_or_exit < 2013
replace xi1=1 if bar_or_exit>2012

gen regime1=0 if deng1==1
replace regime1=1 if jiang1==1
replace regime1=2 if hu1==1
replace regime1=3 if xi1==1

*create new variable measuring age at charge or exit
drop ageatbar
gen ageatbar=firstchargedate-birthyear
gen ageatbar1=bar_or_exit-birthyear

*create ageatbarsquared and ageatbarsquared1  variable
drop ageatbarsquared
gen ageatbarsquared=ageatbar*ageatbar
gen ageatbarsquared1=ageatbar1*ageatbar1

*paste in recogntiion
replace recognition=1 if religion==1
replace recognition=1 if independence==1



*generate variables that indicate whether person  engaged in both combinations of two advocacy
drop democracysocial
gen democracysocial=1 if democracy==1 
replace democracysocial=1 if social==1
replace democracysocial=0 if democracy==0
replace democracysocial=0 if social==0


drop socialrecognition
gen socialrecognition=1 if social==1 & recognition==1
replace socialrecognition=0 if social==0
replace socialrecognition=0 if recognition==0

drop recognitiondemocracy
gen recognitiondemocracy=1 if democracy==1 & recognition==1
replace recognitiondemocracy=0 if democracy==0
replace recognitiondemocracy=0 if recognition==0


drop democracysocialrecognition
gen democracysocialrecognition=1 if democracy==1 & recognition==1 & social==1
replace democracysocialrecognition=0 if democracy==0
replace democracysocialrecognition=0 if recognition==0
replace democracysocialrecognition=0 if social==0

list democracysocialrecognition

g ethnicmin_democracy= ethnicmin* democracy
g ethnicmin_social= ethnicmin* social
g ethnicmin_recognition= ethnicmin* recognition

/*
g deng_democracy= deng* democracy
g jiang_democracy= jiang* democracy
g hu_democracy= hu* democracy
g xi_democracy= xi* democracy

g deng_social= deng* social
g jiang_social= jiang* social
g hu_social= hu* social
g xi_social= xi* social

g deng_recognition= deng* recognition
g jiang_recognition= jiang* recognition
g hu_recognition= hu* recognition
g xi_recognition= xi* recognition

g deng1_democracy= deng1* democracy
g jiang1_democracy= jiang1* democracy
g hu1_democracy= hu1* democracy
g xi1_democracy= xi1* democracy

g deng1_social= deng1* social
g jiang1_social= jiang1* social
g hu1_social= hu1* social
g xi1_social= xi1* social

g deng1_recognition= deng1* recognition
g jiang1_recognition= jiang1* recognition
g hu1_recognition= hu1* recognition
g xi1_recognition= xi1* recognition

*/

*Key analyses

*descriptive analyses
tab deng democracy
tab jiang democracy
tab hu democracy
tab xi democracy

tab deng social
tab jiang social
tab hu social
tab xi social


tab deng recognition
tab jiang recognition
tab hu recognition
tab xi recognition



*cross tabs
tab exitbarred ethnicmin

           |       ethnicmin
exitbarred |         0          1 |     Total
-----------+----------------------+----------
         0 |        98         14 |       112 
         1 |       141         58 |       199 
-----------+----------------------+----------
     Total |       239         72 |       311 

tab exitbarred ethnicmin if democracy==1

           |       ethnicmin
exitbarred |         0          1 |     Total
-----------+----------------------+----------
         0 |        71          3 |        74 
         1 |        68          4 |        72 
-----------+----------------------+----------
     Total |       139          7 |       146 

tab exitbarred ethnicmin if social==1

           |       ethnicmin
exitbarred |         0          1 |     Total
-----------+----------------------+----------
         0 |        41          7 |        48 
         1 |        90         15 |       105 
-----------+----------------------+----------
     Total |       131         22 |       153 

tab exitbarred ethnicmin if recognition==1

           |       ethnicmin
exitbarred |         0          1 |     Total
-----------+----------------------+----------
         0 |         7          5 |        12 
         1 |        19         46 |        65 
-----------+----------------------+----------
     Total |        26         51 |        77 

*Although the cross tabs suggest that ethnic minorities are far more likley to have their exit barred if they advocate for recognition (46/5) than social reforms (15/7) when you control for other variables this is no longer the case.

tab exitbarred intervention



 

*make histogram for bar_or_exit

histogram bar_or_exit, freq bin(45) 

histogram bar_or_exit, freq 
#each value of variable has its own bar_or_exit
histogram bar_or_exit, freq discrete


histogram bar_or_exit if democracy==1, freq bin(45)

histogram bar_or_exit if social==1, freq bin(45)

histogram bar_or_exit if recognition==1, freq bin(45)


destring exitbarred1, replace force

*impute missing data for ageatbar and ageatbar1 with multiple imputatin
mi set mlong


mi register regular exitbarred exitbarred1 male ethnicmin foreign democracy social recognition intervention democracysocial socialrecognition recognitiondemocracy democracysocialrecognition  ethnicmin_democracy ethnicmin_social ethnicmin_recognition  deng jiang hu xi deng1 jiang1 hu1 xi1  firstchargedateafter1989 firstchargedateafter1988 firstchargedate

mi register imputed ageatbar1 ageatbarsquared 
mi register imputed ageatbar


/*now impute the variables with the interaction terms. I use mvn because I am only imputing continuous varaibles.
I choose 40 rounds of multiple imputation because I have around 30 to 40% missinug
data on education*/
*mi impute mvn ageatbar, add(40) rseed(1234) force
mi impute mvn ageatbar ageatbar1 ageatbarsquared, add(40) rseed(1234) force

mi set mlong

mi register regular exitbarred exitbarred1 male ethnicmin foreign democracy social recognition intervention democracysocial socialrecognition recognitiondemocracy democracysocialrecognition  ethnicmin_democracy ethnicmin_social ethnicmin_recognition  deng jiang hu xi deng1 jiang1 hu1 xi1  firstchargedateafter1989 firstchargedateafter1988 firstchargedate 
mi register imputed ageatbar deng_democracy jiang_democracy hu_democracy xi_democracy deng_recognition jiang_recognition hu_recognition xi_recognition deng_social jiang_social hu_social xi_social
 

 mi impute mvn ageatbar deng_democracy jiang_democracy hu_democracy xi_democracy deng_recognition jiang_recognition hu_recognition xi_recognition deng_social jiang_social hu_social xi_social, add(40) rseed(1234) force

 
 
/*now impute the variables. I use mvn because I am only imputing continuous varaibles.

I choose 40 rounds of multiple imputation because I have around 30 to 40% missinug
data on education*/
*mi impute mvn ageatbar, add(40) rseed(1234) force
mi impute mvn ageatbar ageatbar1 ageatbarsquared, add(40) rseed(1234) force

set more off


*I rerun models without the fixed effects

mi estimate, or level(95): logistic exitbarred democracy, vce(robust)  


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =      19.08
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |   .3477596   .0841015    -4.37   0.000     .2164842      .55864
       _cons |   2.837209   .5039783     5.87   0.000     2.003046    4.018757
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.


mimrgns, dydx(*)


mi estimate, or level(95): logistic exitbarred1 democracy, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        312
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       8.04
Within VCE type:       Robust                   Prob > F          =     0.0046

------------------------------------------------------------------------------
 exitbarred1 | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |   .4709222   .1250492    -2.84   0.005     .2798468    .7924614
       _cons |   4.290322   .8570423     7.29   0.000     2.900363      6.3464
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.



mimrgns, dydx(*) predict(pr)


Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        311
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
Within VCE type: Delta-method                           max       =          .

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : democracy

------------------------------------------------------------------------------
             |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |  -.2608526   .0443263    -5.88   0.000    -.3477306   -.1739747
------------------------------------------------------------------------------


. 


mi estimate, or level(95): logistic exitbarred democracy male ethnicmin intervention foreign ageatbar, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        312
                                                Average RVI       =     0.0133
                                                Largest FMI       =     0.0748
DF adjustment:   Large sample                   DF:     min       =   7,010.76
                                                        avg       =   1.16e+07
                                                        max       =   2.79e+07
Model F test:       Equal FMI                   F(   6, 1.0e+06)  =       6.32
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |   .3516103   .1027958    -3.58   0.000      .198247    .6236149
        male |    2.64726   .9777606     2.64   0.008     1.283533    5.459921
   ethnicmin |   2.010654   .7833544     1.79   0.073      .936931    4.314863
intervention |   .7635826   .2554018    -0.81   0.420     .3964128    1.470837
  foreignrec |   .7455051   .2435797    -0.90   0.369     .3929494    1.414375
    ageatbar |   1.025098   .0114418     2.22   0.026     1.002912    1.047775
       _cons |   .4816266   .2751329    -1.28   0.201     .1571888    1.475704
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

coefplot, drop( _cons) coeflabels(democracy="democratization advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(1) eform xtitle(Figure 5: Odds Ratios for barring exit) 

mi estimate, or level(95): logistic exitbarred1 democracy male ethnicmin intervention foreign ageatbar, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0290
                                                Largest FMI       =     0.1655
DF adjustment:   Large sample                   DF:     min       =   1,444.20
                                                        avg       =   9.89e+07
                                                        max       =   3.01e+08
Model F test:       Equal FMI                   F(   6,214516.1)  =       3.58
Within VCE type:       Robust                   Prob > F          =     0.0015

------------------------------------------------------------------------------
 exitbarred1 | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |   .5765017   .1822616    -1.74   0.081     .3102361    1.071295
        male |   1.915694   .7232133     1.72   0.085     .9140718    4.014875
   ethnicmin |   2.233016   .9856774     1.82   0.069     .9400741     5.30422
intervention |   .8094336   .2927426    -0.58   0.559     .3984122    1.644485
  foreignrec |   2.765974    1.23781     2.27   0.023     1.150599    6.649242
    ageatbar |   1.015358   .0121863     1.27   0.204     .9917325    1.039546
       _cons |   .9824817   .5817948    -0.03   0.976     .3076725    3.137331

	   




*!*
mimrgns, dydx(*) predict(pr)


Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        311
                                                Average RVI       =     0.0211
                                                Largest FMI       =     0.1002
DF adjustment:   Large sample                   DF:     min       =   3,921.84
                                                        avg       = 4009866.86
Within VCE type: Delta-method                           max       = 8156549.28

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : democracy male ethnicmin intervention foreignrec ageatbar

------------------------------------------------------------------------------
             |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |  -.2287965   .0537224    -4.26   0.000    -.3340907   -.1235024
        male |   .1837837   .0724114     2.54   0.011       .04186    .3257074
   ethnicmin |   .1138386    .075418     1.51   0.131     -.033978    .2616552
intervention |  -.0593556   .0668197    -0.89   0.374    -.1903198    .0716086
  foreignrec |  -.0541363   .0653604    -0.83   0.408    -.1822403    .0739677
    ageatbar |   .0057528   .0023213     2.48   0.013     .0012016    .0103039
------------------------------------------------------------------------------

mimrgns, dydx(*) predict(pr)




coefplot, drop( _cons) coeflabels(social="democratization advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95)xline(0) xtitle(Figure 5: AMEs for China barring exit) 




mi estimate, or level (95): logistic exitbarred male intervention foreign ageatbar democracy##ethnicmin, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        312
                                                Average RVI       =     0.0120
                                                Largest FMI       =     0.0766
DF adjustment:   Large sample                   DF:     min       =   6,695.22
                                                        avg       =   1.45e+07
                                                        max       =   4.95e+07
Model F test:       Equal FMI                   F(   7, 1.6e+06)  =       5.42
Within VCE type:       Robust                   Prob > F          =     0.0000

-------------------------------------------------------------------------------------
         exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
--------------------+----------------------------------------------------------------
               male |   2.630537   .9824309     2.59   0.010     1.265158    5.469455
       intervention |   .7624275   .2543421    -0.81   0.416     .3964988    1.466072
         foreignrec |   .7670652   .2618078    -0.78   0.437     .3929233    1.497465
           ageatbar |   1.025431   .0113625     2.27   0.023     1.003397    1.047949
        1.democracy |   .3660542    .112695    -3.26   0.001     .2002123    .6692678
        1.ethnicmin |   2.171443    .951649     1.77   0.077     .9198222    5.126171
                    |
democracy#ethnicmin |
               1 1  |   .6935155   .7487652    -0.34   0.735     .0835685    5.755323
                    |
              _cons |   .4633012   .2673647    -1.33   0.182     .1494899    1.435869
-------------------------------------------------------------------------------------
Note: _cons estimates baseline odds.


mimrgns, dydx(*) predict(pr)


mi estimate, or level (95): logistic exitbarred1 male intervention foreign ageatbar democracy##ethnicmin, vce(robust)


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        312
                                                Average RVI       =     0.0190
                                                Largest FMI       =     0.1286
DF adjustment:   Large sample                   DF:     min       =   2,383.53
                                                        avg       =   1.36e+08
                                                        max       =   5.92e+08
Model F test:       Equal FMI                   F(   7,595083.7)  =       3.35
Within VCE type:       Robust                   Prob > F          =     0.0014

-------------------------------------------------------------------------------------
        exitbarred1 | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
--------------------+----------------------------------------------------------------
               male |   2.331368   .8784059     2.25   0.025     1.114032    4.878923
       intervention |   .8414441     .30002    -0.48   0.628     .4183369    1.692483
         foreignrec |   2.525949     1.0623     2.20   0.028     1.107765    5.759719
           ageatbar |   1.015096   .0120266     1.26   0.206     .9917838    1.038955
        1.democracy |   .6201297    .201599    -1.47   0.142      .327917    1.172738
        1.ethnicmin |   2.460269   1.132081     1.96   0.050     .9984042    6.062601
                    |
democracy#ethnicmin |
               1 1  |   .9680201   1.362427    -0.02   0.982     .0613581    15.27204
                    |
              _cons |   .7652289    .449468    -0.46   0.649     .2419425    2.420308
-------------------------------------------------------------------------------------
Note: _cons estimates baseline odds.


mi estimate, or level (95): logistic exitbarred democracy male ethnicmin intervention foreign ageatbar jiang hu xi, vce(robust)  


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0122
                                                Largest FMI       =     0.0963
DF adjustment:   Large sample                   DF:     min       =   4,241.82
                                                        avg       =   7.14e+07
                                                        max       =   3.71e+08
Model F test:       Equal FMI                   F(   9, 1.9e+06)  =       8.19
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |   1.426275   .5244438     0.97   0.334      .693769    2.932186
        male |   2.569126   1.200702     2.02   0.043     1.027944    6.420981
   ethnicmin |    1.78103   .7402619     1.39   0.165      .788643    4.022186
intervention |   .6186822   .2396536    -1.24   0.215     .2895643    1.321875
  foreignrec |   .7106852   .2679428    -0.91   0.365     .3394352    1.487982
    ageatbar |   .9914096   .0145177    -0.59   0.556      .963352    1.020284
       jiang |   4.802806   1.943913     3.88   0.000     2.172576    10.61733
          hu |   22.53483   10.91116     6.43   0.000     8.723853    58.21036
          xi |   23.81581   11.09062     6.81   0.000     9.560315    59.32786
       _cons |   .1407892   .1021223    -2.70   0.007     .0339722    .5834653
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.


coefplot, drop( _cons) coeflabels(democracy="democratization advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95) xline(1) eform xtitle(Figure 9: ORs for barring exit with administration effects) 


mimrgns, dydx(*) predict(pr)

. 
mi estimate, or level (95): logistic exitbarred1 democracy male ethnicmin intervention foreign ageatbar jiang hu xi, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0210
                                                Largest FMI       =     0.1594
DF adjustment:   Large sample                   DF:     min       =   1,555.62
                                                        avg       =   2.14e+07
                                                        max       =   9.82e+07
Model F test:       Equal FMI                   F(   9,672585.4)  =       6.17
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
 exitbarred1 | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |   1.747547   .6848809     1.42   0.154     .8106524    3.767239
        male |   2.069677    .856319     1.76   0.079     .9198609    4.656753
   ethnicmin |   1.733002   .7842902     1.21   0.224     .7138017    4.207464
intervention |   .7728371   .3064668    -0.65   0.516     .3552596    1.681241
  foreignrec |   3.661646   2.013936     2.36   0.018     1.245972     10.7608
    ageatbar |   .9856209   .0136114    -1.05   0.294     .9592806    1.012685
       jiang |   7.297186   3.362046     4.31   0.000      2.95787    18.00245
          hu |   22.53149   14.34221     4.89   0.000     6.470877     78.4543
          xi |   11.23871   5.173442     5.26   0.000     4.559125    27.70456
       _cons |   .3352633   .2174402    -1.69   0.092     .0940278    1.195407
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.





*regression with linear year of bar/exit term

mi estimate, or level(95): logistic exitbarred democracy male ethnicmin intervention foreign ageatbar bar_or_exit, vce(robust) 


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0131
                                                Largest FMI       =     0.0909
DF adjustment:   Large sample                   DF:     min       =   4,764.02
                                                        avg       =   1.16e+09
                                                        max       =   4.59e+09
Model F test:       Equal FMI                   F(   7, 1.2e+06)  =       7.33
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |   .8271546   .2595478    -0.60   0.545     .4471914     1.52996
        male |   2.538072   1.105667     2.14   0.033      1.08067    5.960945
   ethnicmin |   1.746825    .707217     1.38   0.168     .7900109    3.862475
intervention |   .6569256   .2306144    -1.20   0.231     .3301422    1.307168
  foreignrec |   .7462512   .2605842    -0.84   0.402     .3764031    1.479507
    ageatbar |   1.008946   .0132856     0.68   0.499     .9832336    1.035331
 bar_or_exit |   1.077534   .0160917     5.00   0.000     1.046452     1.10954
       _cons |   6.74e-66   2.01e-64    -5.04   0.000     2.90e-91    1.57e-40
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.






mi estimate, level(95): regress exitbarred democracy male ethnicmin intervention foreign ageatbar jiang hu xi, vce(robust)  

*ns


*interaction terms
mi estimate, level(95): regress exitbarred male ethnicmin intervention foreign ageatbar democracy##jiang democracy##hu democracy##xi, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0094
                                                Largest FMI       =     0.0962
                                                Complete DF       =        301
DF adjustment:   Small sample                   DF:     min       =     254.62
                                                        avg       =     294.26
                                                        max       =     299.00
Model F test:       Equal FMI                   F(  12,  299.0)   =      16.65
Within VCE type:       Robust                   Prob > F          =     0.0000

---------------------------------------------------------------------------------
     exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
----------------+----------------------------------------------------------------
           male |   .1662494   .0817799     2.03   0.043     .0053124    .3271864
      ethnicmin |    .072053   .0576518     1.25   0.212    -.0414033    .1855094
   intervention |  -.0652346   .0648928    -1.01   0.316    -.1929393      .06247
     foreignrec |  -.0565789   .0634912    -0.89   0.374    -.1815256    .0683679
       ageatbar |  -.0012847   .0023257    -0.55   0.581    -.0058648    .0032954
    1.democracy |   .2137777   .0923414     2.32   0.021     .0320562    .3954991
        1.jiang |   .5038185   .1341287     3.76   0.000     .2398604    .7677766
                |
democracy#jiang |
           1 1  |  -.2046603   .1661246    -1.23   0.219    -.5315825    .1222619
                |
           1.hu |   .7607124   .0877304     8.67   0.000     .5880619    .9333629
                |
   democracy#hu |
           1 1  |  -.1634608   .1384532    -1.18   0.239    -.4359282    .1090066
                |
           1.xi |   .7848012   .0865186     9.07   0.000     .6145338    .9550687
                |
   democracy#xi |
           1 1  |  -.2210405   .1253745    -1.76   0.079    -.4677698    .0256888
                |
          _cons |  -.0287188   .1330397    -0.22   0.829    -.2905712    .2331336
---------------------------------------------------------------------------------



mi estimate, level(95): regress exitbarred male ethnicmin intervention foreign ageatbar social##jiang social##hu social##xi, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0090
                                                Largest FMI       =     0.0877
                                                Complete DF       =        301
DF adjustment:   Small sample                   DF:     min       =     259.40
                                                        avg       =     294.45
                                                        max       =     298.99
Model F test:       Equal FMI                   F(  12,  299.0)   =      26.49
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
        male |   .1386192   .0838017     1.65   0.099    -.0262966     .303535
   ethnicmin |    .014835   .0626477     0.24   0.813    -.1084536    .1381237
intervention |  -.0701744   .0649059    -1.08   0.280    -.1979047     .057556
  foreignrec |  -.0395547   .0641344    -0.62   0.538    -.1657668    .0866575
    ageatbar |   -.000867   .0022779    -0.38   0.704    -.0053526    .0036186
    1.social |    .019885   .1056272     0.19   0.851    -.1879819    .2277518
     1.jiang |   .3342042   .1022624     3.27   0.001     .1329581    .5354503
             |
social#jiang |
        1 1  |  -.0153407   .1782707    -0.09   0.931    -.3661649    .3354835
             |
        1.hu |   .7424904   .0654021    11.35   0.000     .6137812    .8711997
             |
   social#hu |
        1 1  |  -.2446817   .1322464    -1.85   0.065    -.5049342    .0155708
             |
        1.xi |     .66081   .0905755     7.30   0.000     .4825555    .8390645
             |
   social#xi |
        1 1  |   -.082297   .1333949    -0.62   0.538    -.3448091    .1802151
             |
       _cons |   .1573332   .1184847     1.33   0.185    -.0758778    .3905443
----------------------------------------------------------



mi estimate, level(95): regress exitbarred male ethnicmin intervention foreign ageatbar recognition##jiang recognition##hu recognition##xi, vce(robust)  


Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0080
                                                Largest FMI       =     0.0871
                                                Complete DF       =        301
DF adjustment:   Small sample                   DF:     min       =     259.77
                                                        avg       =     294.36
                                                        max       =     298.97
Model F test:       Equal FMI                   F(  12,  299.0)   =      16.11
Within VCE type:       Robust                   Prob > F          =     0.0000

--------------------------------------------------------------------------------
    exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
---------------+----------------------------------------------------------------
          male |   .1473098   .0813458     1.81   0.071    -.0127731    .3073928
     ethnicmin |    .027262   .0710136     0.38   0.701    -.1124894    .1670134
  intervention |  -.0559642   .0622146    -0.90   0.369    -.1783982    .0664697
    foreignrec |  -.0536236   .0622938    -0.86   0.390    -.1762136    .0689664
      ageatbar |  -.0008327   .0022964    -0.36   0.717    -.0053545    .0036892
 1.recognition |  -.0342074   .2478807    -0.14   0.890    -.5220206    .4536058
       1.jiang |   .3698711    .089609     4.13   0.000     .1935263    .5462159
               |
   recognition#|
         jiang |
          1 1  |  -.2109447   .2992886    -0.70   0.481    -.7999278    .3780384
               |
          1.hu |   .5620516   .0835609     6.73   0.000     .3976044    .7264989
               |
recognition#hu |
          1 1  |    .132623   .2533748     0.52   0.601    -.3660011    .6312471
               |
          1.xi |   .5621602   .0744132     7.55   0.000     .4157152    .7086051
               |
recognition#xi |
          1 1  |   .1608801    .249272     0.65   0.519    -.3296717     .651432
               |
         _cons |   .1545358   .1128638     1.37   0.172    -.0676166    .3766882
--------------------------------------------------------------------------------


mi estimate, or level(95): logistic exitbarred male ethnicmin intervention foreign ageatbar jiang hu xi social##jiang social##hu social##xi, vce(robust)  

mi estimate, or level(95): logistic exitbarred social##hu, vce(robust)  


mi estimate, or level(95): logistic exitbarred recognition male ethnicmin intervention foreign ageatbar bar_or_exit, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0128
                                                Largest FMI       =     0.0898
DF adjustment:   Large sample                   DF:     min       =   4,881.95
                                                        avg       =   6.09e+08
                                                        max       =   3.24e+09
Model F test:       Equal FMI                   F(   7, 1.3e+06)  =       7.85
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   1.652363   .7163958     1.16   0.247     .7064153    3.865014
        male |   2.380598   1.022496     2.02   0.043     1.025852    5.524433
   ethnicmin |   1.459726   .6745576     0.82   0.413     .5900926    3.610957
intervention |   .6399031   .2221184    -1.29   0.198     .3240794    1.263505
  foreignrec |   .7723422   .2666079    -0.75   0.454     .3926269    1.519286
    ageatbar |   1.008531    .013149     0.65   0.515     .9830792    1.034641
 bar_or_exit |   1.077987   .0158015     5.12   0.000     1.047458    1.109407
       _cons |   2.65e-66   7.75e-65    -5.17   0.000     3.61e-91    1.95e-41
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.



*now with whether they were charged in 1989

mi estimate, or level(95): logistic exitbarred democracy male ethnicmin intervention foreign ageatbar firstchargedate1989, vce(robust) 


mi estimate, or level(95): logistic exitbarred recognition male ethnicmin intervention foreign ageatbar firstchargedate1989, vce(robust) 


mi estimate, or level(95): logistic exitbarred social male ethnicmin intervention foreign ageatbar firstchargedate1989, vce(robust) 





mi estimate, or level(95): logistic exitbarred social, vce(robust)  



Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       1.71
Within VCE type:       Robust                   Prob > F          =     0.1912

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   1.358288   .3182244     1.31   0.191      .858162     2.14988
       _cons |   1.430769   .2316822     2.21   0.027     1.041684    1.965184
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

. 


mimrgns, dydx(*) predict(pr) post



mi estimate, or level(95): logistic exitbarred social, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       2.24
Within VCE type:       Robust                   Prob > F          =     0.1347

------------------------------------------------------------------------------
 exitbarred1 | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   1.484312   .3919454     1.50   0.135     .8846228    2.490533
       _cons |   2.511111   .4433448     5.22   0.000     1.776575    3.549346
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.






mi estimate, or level(95): logistic exitbarred social male ethnicmin intervention foreign ageatbar, vce(robust)  



Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0201
                                                Largest FMI       =     0.1105
DF adjustment:   Large sample                   DF:     min       =   3,224.35
                                                        avg       = 9891112.26
                                                        max       =   2.59e+07
Model F test:       Equal FMI                   F(   6,452404.5)  =       4.33
Within VCE type:       Robust                   Prob > F          =     0.0002

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   1.826836   .4956747     2.22   0.026     1.073355    3.109252
        male |   2.171424   .8259638     2.04   0.042     1.030305    4.576397
   ethnicmin |   4.061551   1.482332     3.84   0.000     1.986238    8.305244
intervention |   .7499441   .2417832    -0.89   0.372     .3986577    1.410775
  foreignrec |   .7335455   .2344726    -0.97   0.332     .3920545    1.372485
    ageatbar |   1.026274   .0125378     2.12   0.034     1.001984    1.051154
       _cons |   .2051716    .123681    -2.63   0.009     .0629406     .668811
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.


mimrgns, dydx(*) predict(pr) post

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        314
                                                Average RVI       =     0.0229
                                                Largest FMI       =     0.1107
DF adjustment:   Large sample                   DF:     min       =   3,212.32
                                                        avg       =   1.47e+07
Within VCE type: Delta-method                           max       =   3.88e+07

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : social male ethnicmin intervention foreignrec ageatbar

------------------------------------------------------------------------------
             |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   .1269031   .0548371     2.31   0.021     .0194241     .234382
        male |   .1632637   .0787247     2.07   0.038     .0089661    .3175612
   ethnicmin |   .2951135   .0695388     4.24   0.000       .15882     .431407
intervention |  -.0605921   .0677327    -0.89   0.371    -.1933457    .0721616
  foreignrec |  -.0652405   .0668111    -0.98   0.329    -.1961878    .0657068
    ageatbar |   .0054561   .0024675     2.21   0.027      .000618    .0102942

	
	
mi estimate, or level(95): logistic exitbarred1 social male ethnicmin intervention foreign ageatbar, vce(robust)  


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0294
                                                Largest FMI       =     0.1671
DF adjustment:   Large sample                   DF:     min       =   1,416.48
                                                        avg       =   9.49e+07
                                                        max       =   2.85e+08
Model F test:       Equal FMI                   F(   6,208611.6)  =       3.21
Within VCE type:       Robust                   Prob > F          =     0.0037

------------------------------------------------------------------------------
 exitbarred1 | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   1.702373   .5125615     1.77   0.077     .9435592    3.071426
        male |   1.989473   .7695234     1.78   0.075     .9321708    4.246008
   ethnicmin |   3.413793   1.437748     2.92   0.004     1.495362    7.793419
intervention |   .7794733   .2823417    -0.69   0.492     .3832463    1.585348
  foreignrec |   2.888916   1.297359     2.36   0.018     1.198053    6.966165
    ageatbar |   1.014941   .0125696     1.20   0.231     .9905806    1.039899
       _cons |   .5204579   .3060246    -1.11   0.267       .16434    1.648268
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.







coefplot, drop( _cons) coeflabels(social="social reform advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95) xline(1) eform xtitle(Figure 7: Odds Ratios for barring exit) 




.
mimrgns, dydx(*) predict(pr) post


Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        311
                                                Average RVI       =     0.0234
                                                Largest FMI       =     0.1091
DF adjustment:   Large sample                   DF:     min       =   3,309.65
                                                        avg       = 3602926.79
Within VCE type: Delta-method                           max       = 7718951.34

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : social male ethnicmin intervention foreignrec ageatbar

------------------------------------------------------------------------------
             |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   .1380963   .0543138     2.54   0.011      .031643    .2445496
        male |   .1830811   .0772757     2.37   0.018     .0316234    .3345387
   ethnicmin |   .2644304   .0680089     3.89   0.000     .1311353    .3977255
intervention |  -.0801364    .066671    -1.20   0.229    -.2108092    .0505364
  foreignrec |  -.0347065   .0673474    -0.52   0.606    -.1667051     .097292
    ageatbar |   .0060116   .0024686     2.44   0.015     .0011716    .0108517
------------------------------------------------------------------------------



coefplot, drop( _cons) coeflabels(social="social reform advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95)xline(0) xtitle(Figure 7: AMEs for China barring exit) 



mi estimate, or level(95): logistic exitbarred male intervention foreign ageatbar social##ethnicmin, vce(robust)  




Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0172
                                                Largest FMI       =     0.1056
DF adjustment:   Large sample                   DF:     min       =   3,529.27
                                                        avg       = 8243338.34
                                                        max       =   2.38e+07
Model F test:       Equal FMI                   F(   7,750957.1)  =       4.97
Within VCE type:       Robust                   Prob > F          =     0.0000

----------------------------------------------------------------------------------
      exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-----------------+----------------------------------------------------------------
            male |   1.985582   .7357903     1.85   0.064     .9604198    4.105015
    intervention |   .7636043   .2504262    -0.82   0.411     .4015266    1.452186
      foreignrec |   .7305507    .238156    -0.96   0.336     .3856228    1.384006
        ageatbar |    1.02594   .0124006     2.12   0.034     1.001913    1.050543
        1.social |   2.205478    .621367     2.81   0.005     1.269658    3.831058
     1.ethnicmin |   6.785427   3.038582     4.28   0.000     2.820983    16.32127
                 |
social#ethnicmin |
            1 1  |   .2375549   .1709852    -2.00   0.046     .0579553    .9737214
                 |
           _cons |   .2023954    .119488    -2.71   0.007     .0636234    .6438501
----------------------------------------------------------------------------------
Note: _cons estimates baseline odds.


mimrgns, dydx(*) predict(pr)


mi estimate, or level(95): logistic exitbarred1 male intervention foreign ageatbar social##ethnicmin, vce(robust)  


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0239
                                                Largest FMI       =     0.1561
DF adjustment:   Large sample                   DF:     min       =   1,622.40
                                                        avg       =   7.56e+07
                                                        max       =   2.00e+08
Model F test:       Equal FMI                   F(   7,381537.0)  =       3.53
Within VCE type:       Robust                   Prob > F          =     0.0009

----------------------------------------------------------------------------------
     exitbarred1 | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-----------------+----------------------------------------------------------------
            male |   1.814002   .6990181     1.55   0.122     .8523749     3.86051
    intervention |   .7892929   .2939806    -0.64   0.525     .3803637    1.637862
      foreignrec |   2.908527   1.328764     2.34   0.019     1.187956    7.121077
        ageatbar |   1.014032   .0124304     1.14   0.256     .9899414    1.038709
        1.social |   2.170744   .6654603     2.53   0.011     1.190324    3.958694
     1.ethnicmin |   7.182175   4.131228     3.43   0.001     2.326163    22.17543
                 |
social#ethnicmin |
            1 1  |   .1384021   .1124669    -2.43   0.015     .0281481    .6805141
                 |
           _cons |    .516624   .2988592    -1.14   0.254     .1662055    1.605845
----------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

. 

mi estimate, or level (95): logistic exitbarred male intervention foreign ageatbar social##ethnicmin, vce(robust)


mimrgns, dydx(*) predict(pr)

mi estimate, or level(95): logistic exitbarred social male ethnicmin intervention foreign ageatbar jiang hu xi, vce(robust)  


 
Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0111
                                                Largest FMI       =     0.0939
DF adjustment:   Large sample                   DF:     min       =   4,463.16
                                                        avg       =   1.25e+08
                                                        max       =   7.70e+08
Model F test:       Equal FMI                   F(   9, 2.3e+06)  =       8.29
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   .6496932   .2145887    -1.31   0.192     .3400658    1.241234
        male |   2.457851   1.152314     1.92   0.055     .9805889    6.160617
   ethnicmin |   1.400229   .5552585     0.85   0.396     .6436596    3.046083
intervention |   .6302886   .2414945    -1.20   0.228      .297442    1.335601
  foreignrec |   .7098069   .2668837    -0.91   0.362     .3396979    1.483159
    ageatbar |   .9918849   .0144717    -0.56   0.577     .9639151    1.020666
       jiang |   4.630369   1.903171     3.73   0.000     2.068974    10.36278
          hu |   22.26187   10.78119     6.41   0.000     8.616529    57.51629
          xi |   24.54928   11.79902     6.66   0.000     9.570336    62.97242
       _cons |   .2224388   .1508522    -2.22   0.027     .0588732     .840434
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.


coefplot, drop( _cons) coeflabels(social="social reform advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95) xline(1) eform xtitle(Figure 9: ORs for barring exit with administration effects) 

mimrgns, dydx(*) predict(pr)

 
*run a linear model
mi estimate, level(95): regress exitbarred social male ethnicmin intervention foreign ageatbar jiang hu xi, vce(robust)  



mi estimate, or level(95): logistic exitbarred1 social male ethnicmin intervention foreign ageatbar jiang hu xi, vce(robust)  



Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0196
                                                Largest FMI       =     0.1516
DF adjustment:   Large sample                   DF:     min       =   1,720.31
                                                        avg       =   3.37e+07
                                                        max       =   1.22e+08
Model F test:       Equal FMI                   F(   9,765694.6)  =       6.38
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
 exitbarred1 | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   .8746244   .2761235    -0.42   0.671     .4710779    1.623867
        male |   2.148212   .9047991     1.82   0.069     .9409399    4.904471
   ethnicmin |   1.349499   .6028088     0.67   0.502     .5622739    3.238895
intervention |   .8041779   .3138206    -0.56   0.577     .3742667    1.727918
  foreignrec |   3.458879   1.919859     2.24   0.025     1.165397     10.2659
    ageatbar |   .9866572   .0134348    -0.99   0.324     .9606557    1.013362
       jiang |   6.626915   3.058465     4.10   0.000     2.682026    16.37419
          hu |   17.22698   10.07689     4.87   0.000     5.473924    54.21503
          xi |   8.909764   3.923121     4.97   0.000     3.758913    21.11884
       _cons |   .5321138   .3258304    -1.03   0.303     .1602096    1.767341
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.






mi estimate, or level(95): logistic exitbarred recognition, vce(robust) 



Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =      16.94
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   3.916084   1.298806     4.12   0.000     2.044292    7.501722
       _cons |   1.257143   .1646531     1.75   0.081     .9725218    1.625062
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.



. 




mi estimate, or level(95): logistic exitbarred recognition, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =      16.94
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   3.916084   1.298806     4.12   0.000     2.044292    7.501722
       _cons |   1.257143   .1646531     1.75   0.081     .9725218    1.625062
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.



mimrgns, dydx(*) predict(pr)

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        314
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
Within VCE type: Delta-method                           max       =          .

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : recognition

------------------------------------------------------------------------------
             |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   .3012167   .0663661     4.54   0.000     .1711415     .431292
----------------------------------------------------------------------


-------------------------------------------------

mi estimate, or level(95): logistic exitbarred1 recognition, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       7.23
Within VCE type:       Robust                   Prob > F          =     0.0072

------------------------------------------------------------------------------
 exitbarred1 | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   2.695858   .9941156     2.69   0.007     1.308612    5.553711
       _cons |   2.485294   .3574759     6.33   0.000     1.874753    3.294668
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

. 


***

 mi estimate, or level(95): logistic exitbarred recognition male ethnicmin intervention foreign ageatbar, vce(robust) 


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0199
                                                Largest FMI       =     0.1096
DF adjustment:   Large sample                   DF:     min       =   3,276.18
                                                        avg       = 5897614.52
                                                        max       =   1.36e+07
Model F test:       Equal FMI                   F(   6,464040.1)  =       5.34
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   2.545532   1.060042     2.24   0.025     1.125409    5.757666
        male |   1.735493   .6506198     1.47   0.141     .8323686    3.618514
   ethnicmin |   2.137977   .9365323     1.73   0.083     .9060191    5.045089
intervention |   .7270036   .2265613    -1.02   0.306     .3947032    1.339068
  foreignrec |   .8054163   .2473706    -0.70   0.481     .4411513     1.47046
    ageatbar |   1.026945   .0122738     2.22   0.026      1.00316    1.051294
       _cons |   .3020809   .1706384    -2.12   0.034     .0998188    .9141846
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.



mimrgns, dydx(*) predict(pr)
Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        314
                                                Average RVI       =     0.0227
                                                Largest FMI       =     0.1098
DF adjustment:   Large sample                   DF:     min       =   3,267.53
                                                        avg       = 8377663.33
Within VCE type: Delta-method                           max       =   2.02e+07

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : recognition male ethnicmin intervention foreignrec ageatbar

------------------------------------------------------------------------------
             |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   .1968278   .0859214     2.29   0.022     .0284247    .3652308
        male |   .1161137   .0785759     1.48   0.139    -.0378922    .2701196
   ethnicmin |   .1600302   .0910386     1.76   0.079    -.0184023    .3384628
intervention |  -.0671555   .0653373    -1.03   0.304    -.1952143    .0609034
  foreignrec |  -.0455704    .064485    -0.71   0.480    -.1719586    .0808179
    ageatbar |   .0055954   .0024073     2.32   0.020     .0008756    .0103153
------------------------------------------------------------





coefplot, drop( _cons) coeflabels(recognition="recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(1) eform xtitle(Figure 6: Odds Ratios for barring exit) 



. 
. mimrgns, dydx(*) predict(pr) post

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        311
                                                Average RVI       =     0.0238
                                                Largest FMI       =     0.1094
DF adjustment:   Large sample                   DF:     min       =   3,291.84
                                                        avg       = 3052843.50
Within VCE type: Delta-method                           max       = 5113389.71

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : recognition male ethnicmin intervention foreignrec ageatbar

------------------------------------------------------------------------------
             |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   .2192362   .0877645     2.50   0.012     .0472207    .3912517
        male |   .1236061    .075624     1.63   0.102    -.0246141    .2718264
   ethnicmin |   .1175928   .0899804     1.31   0.191    -.0587656    .2939513
intervention |  -.0886756     .06413    -1.38   0.167    -.2143681     .037017
  foreignrec |  -.0201684   .0646104    -0.31   0.755    -.1468026    .1064657
    ageatbar |   .0062346   .0023913     2.61   0.009      .001546    .0109231
------------------------------------------------------------------------------


coefplot, drop( _cons) coeflabels(social="recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95)xline(0) xtitle(Figure 6: AMEs for China barring exit) 






 mi estimate, or level(95): logistic exitbarred1 recognition male ethnicmin intervention foreign ageatbar, vce(robust) 
 
Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0299
                                                Largest FMI       =     0.1690
DF adjustment:   Large sample                   DF:     min       =   1,385.48
                                                        avg       =   4.78e+07
                                                        max       =   1.62e+08
Model F test:       Equal FMI                   F(   6,202021.4)  =       3.18
Within VCE type:       Robust                   Prob > F          =     0.0040

------------------------------------------------------------------------------
 exitbarred1 | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   1.793524   .8764383     1.20   0.232     .6882592    4.673718
        male |   1.638862   .6093658     1.33   0.184     .7907634    3.396552
   ethnicmin |   2.168912   1.115889     1.50   0.132     .7912344    5.945369
intervention |   .7772194   .2698773    -0.73   0.468     .3935294    1.535006
  foreignrec |   3.038571   1.320893     2.56   0.011     1.296118    7.123511
    ageatbar |   1.016111   .0122271     1.33   0.184     .9924064    1.040382
       _cons |   .7245801   .4068785    -0.57   0.566     .2409469    2.178971
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.





mi estimate, or level(95): logistic exitbarred recognition##ethnicmin male intervention foreign ageatbar, vce(robust)


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0181
                                                Largest FMI       =     0.1109
DF adjustment:   Large sample                   DF:     min       =   3,202.98
                                                        avg       = 5518224.65
                                                        max       =   1.33e+07
Model F test:       Equal FMI                   F(   7,679268.1)  =       4.56
Within VCE type:       Robust                   Prob > F          =     0.0000

---------------------------------------------------------------------------------------
           exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
----------------------+----------------------------------------------------------------
        1.recognition |   1.852863   .8638974     1.32   0.186     .7429686     4.62079
          1.ethnicmin |   1.469153   .7982585     0.71   0.479      .506489    4.261518
                      |
recognition#ethnicmin |
                 1 1  |    2.61446   2.246118     1.12   0.263     .4854036    14.08189
                      |
                 male |    1.60978   .6193958     1.24   0.216     .7572674    3.422029
         intervention |   .7163229   .2225803    -1.07   0.283     .3895993    1.317042
           foreignrec |   .8349951   .2544782    -0.59   0.554     .4594799    1.517404
             ageatbar |   1.026891   .0121501     2.24   0.025     1.003342    1.050992
                _cons |   .3307266   .1898688    -1.93   0.054     .1073289    1.019111
---------------------------------------------------------------------------------------
Note: _cons estimates baseline odds.



mimrgns, dydx(*) predict(pr)


mi estimate, or level(95): logistic exitbarred1 recognition##ethnicmin male intervention foreign ageatbar, vce(robust)


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0260
                                                Largest FMI       =     0.1672
DF adjustment:   Large sample                   DF:     min       =   1,415.51
                                                        avg       =   4.81e+07
                                                        max       =   2.03e+08
Model F test:       Equal FMI                   F(   7,322490.8)  =       2.91
Within VCE type:       Robust                   Prob > F          =     0.0048

---------------------------------------------------------------------------------------
          exitbarred1 | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
----------------------+----------------------------------------------------------------
        1.recognition |   1.275347    .666655     0.47   0.642     .4578092    3.552813
          1.ethnicmin |   1.388737   .8244823     0.55   0.580     .4337784    4.446024
                      |
recognition#ethnicmin |
                 1 1  |    2.92649   2.778258     1.13   0.258      .455261    18.81195
                      |
                 male |   1.517094   .5847253     1.08   0.280     .7127521    3.229137
         intervention |   .7669174   .2667623    -0.76   0.446     .3878548     1.51645
           foreignrec |   3.126018   1.332832     2.67   0.008     1.355398    7.209681
             ageatbar |   1.016425   .0121944     1.36   0.175     .9927831     1.04063
                _cons |   .7870569   .4500364    -0.42   0.675     .2565231    2.414826
---------------------------------------------------------------------------------------
Note: _cons estimates baseline odds.





 mi estimate, or level(95): logistic exitbarred recognition male ethnicmin intervention foreign ageatbar jiang hu xi, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0104
                                                Largest FMI       =     0.0890
DF adjustment:   Large sample                   DF:     min       =   4,969.27
                                                        avg       =   2.25e+08
                                                        max       =   1.55e+09
Model F test:       Equal FMI                   F(   9, 2.6e+06)  =       8.35
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   1.469125   .6671219     0.85   0.397     .6032994    3.577543
        male |    2.66365   1.225187     2.13   0.033      1.08132    6.561458
   ethnicmin |   1.301287    .633992     0.54   0.589     .5007998    3.381285
intervention |   .6414138   .2452604    -1.16   0.245      .303152    1.357114
  foreignrec |   .6631575   .2502817    -1.09   0.276      .316494     1.38953
    ageatbar |   .9918143   .0142198    -0.57   0.566     .9643254    1.020087
       jiang |   4.313216   1.768558     3.56   0.000     1.930994    9.634328
          hu |   17.56905   8.425621     5.98   0.000      6.86333    44.97401
          xi |   18.64768    8.56583     6.37   0.000     7.579188    45.88038
       _cons |   .1833623   .1215265    -2.56   0.010     .0500189    .6721799
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.


mimrgns, dydx(*) predict(pr)

coefplot, drop( _cons) coeflabels(social="recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95) xline(1) eform xtitle(Figure 10: ORs for barring exit with administration effects) 



mi estimate, level(95): regress exitbarred recognition male ethnicmin intervention foreign ageatbar jiang hu xi, vce(robust)  




 
 mi estimate, or level(95): logistic exitbarred1 recognition male ethnicmin intervention foreign ageatbar jiang hu xi, vce(robust) 
 
Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0195
                                                Largest FMI       =     0.1508
DF adjustment:   Large sample                   DF:     min       =   1,737.68
                                                        avg       =   4.19e+07
                                                        max       =   1.47e+08
Model F test:       Equal FMI                   F(   9,769956.5)  =       5.96
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
 exitbarred1 | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |    1.03142   .5641863     0.06   0.955     .3530436    3.013301
        male |   2.203645    .897093     1.94   0.052      .992251    4.893973
   ethnicmin |   1.392402   .7779194     0.59   0.554     .4658084    4.162188
intervention |   .8055482   .3139738    -0.55   0.579     .3752525    1.729256
  foreignrec |    3.41863    1.89912     2.21   0.027     1.150779    10.15576
    ageatbar |   .9868425   .0134379    -0.97   0.331     .9608352    1.013554
       jiang |   6.557946   2.998071     4.11   0.000     2.676868    16.06603
          hu |   16.20109   9.413453     4.79   0.000     5.187545    50.59722
          xi |   8.288413   3.659362     4.79   0.000     3.488659    19.69175
       _cons |   .4962309   .2898469    -1.20   0.230     .1579046    1.559454
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.




*appendix analyses:

*redo analyses with exitbarred1







*include linear probability regression model
*for democracy

mi estimate: regress exitbarred democracy, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
                                                Complete DF       =        312
DF adjustment:   Small sample                   DF:     min       =     310.02
                                                        avg       =     310.02
                                                        max       =     310.02
Model F test:       Equal FMI                   F(   1,  310.0)   =      20.58
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |  -.2427496   .0535149    -4.54   0.000    -.3480479   -.1374514
       _cons |   .7393939   .0342828    21.57   0.000     .6719376    .8068503
------------------------------------------------------------------------------




mi estimate: regress exitbarred democracy male ethnicmin intervention foreign ageatbar, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0182
                                                Largest FMI       =     0.1009
                                                Complete DF       =        307
DF adjustment:   Small sample                   DF:     min       =     256.62
                                                        avg       =     293.57
                                                        max       =     304.76
Model F test:       Equal FMI                   F(   6,  304.8)   =       8.67
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |  -.2020381    .061313    -3.30   0.001    -.3226898   -.0813864
        male |   .1682538   .0820402     2.05   0.041     .0068168    .3296907
   ethnicmin |   .1489649    .065789     2.26   0.024      .019504    .2784259
intervention |  -.0479898   .0729746    -0.66   0.511     -.191588    .0956083
  foreignrec |  -.0839093   .0703165    -1.19   0.234    -.2222768    .0544582
    ageatbar |   .0054265   .0023695     2.29   0.023     .0007603    .0100926
       _cons |   .3594183   .1245974     2.88   0.004     .1141408    .6046957
------------------------------------------------------------------------------



------------------------------------------------------------

mi estimate: regress exitbarred male intervention foreign ageatbar democracy##ethnicmin, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0169
                                                Largest FMI       =     0.1051
                                                Complete DF       =        306
DF adjustment:   Small sample                   DF:     min       =     253.35
                                                        avg       =     293.20
                                                        max       =     303.77
Model F test:       Equal FMI                   F(   7,  303.8)   =       7.81
Within VCE type:       Robust                   Prob > F          =     0.0000

-------------------------------------------------------------------------------------
         exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
--------------------+----------------------------------------------------------------
               male |   .1670344   .0827642     2.02   0.044     .0041706    .3298981
       intervention |  -.0484751   .0730195    -0.66   0.507    -.1921634    .0952133
         foreignrec |   -.078868   .0730147    -1.08   0.281    -.2225467    .0648108
           ageatbar |   .0055119   .0023598     2.34   0.020     .0008646    .0101593
        1.democracy |  -.1944893   .0651072    -2.99   0.003    -.3226097   -.0663688
        1.ethnicmin |   .1600865   .0693845     2.31   0.022     .0235466    .2966264
                    |
democracy#ethnicmin |
               1 1  |  -.0678532   .2265072    -0.30   0.765    -.5135772    .3778709
                    |
              _cons |   .3516293   .1255514     2.80   0.005     .1044626     .598796
-------------------------------------------------------------------------------------




mi estimate: regress exitbarred democracy male ethnicmin intervention foreign ageatbar jiang hu xi, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0116
                                                Largest FMI       =     0.0936
                                                Complete DF       =        304
DF adjustment:   Small sample                   DF:     min       =     258.51
                                                        avg       =     295.30
                                                        max       =     301.99
Model F test:       Equal FMI                   F(   9,  301.9)   =      17.37
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |   .0590414   .0576455     1.02   0.307     -.054397    .1724797
        male |   .1555716   .0818937     1.90   0.058    -.0055829    .3167261
   ethnicmin |   .0753164   .0584253     1.29   0.198    -.0396575    .1902903
intervention |  -.0749437   .0642865    -1.17   0.245      -.20145    .0515627
  foreignrec |  -.0538473   .0632684    -0.85   0.395    -.1783507    .0706561
    ageatbar |  -.0013795   .0022963    -0.60   0.549    -.0059013    .0031422
          hu |   .6288983   .0707578     8.89   0.000     .4896503    .7681463
       jiang |   .3409601   .0834442     4.09   0.000     .1767528    .5051674
          xi |    .636711   .0690997     9.21   0.000     .5007229     .772699
       _cons |   .1148493   .1173862     0.98   0.329    -.1161856    .3458842
------------------------------------------------------------------------------


coefplot, drop( _cons) coeflabels(social="recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95) xline(1) eform xtitle(Figure 10: ORs for barring exit with administration effects) 


mi estimate: regress exitbarred social, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
                                                Complete DF       =        312
DF adjustment:   Small sample                   DF:     min       =     310.02
                                                        avg       =     310.02
                                                        max       =     310.02
Model F test:       Equal FMI                   F(   1,  310.0)   =       1.72
Within VCE type:       Robust                   Prob > F          =     0.1910

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   .0716488   .0546769     1.31   0.191    -.0359359    .1792336
       _cons |   .5886076   .0392735    14.99   0.000     .5113312     .665884
------------------------------------------------------------------------------



----------------------------------------------------------

mi estimate: regress exitbarred social male ethnicmin intervention foreign ageatbar, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0193
                                                Largest FMI       =     0.1063
                                                Complete DF       =        307
DF adjustment:   Small sample                   DF:     min       =     253.38
                                                        avg       =     293.69
                                                        max       =     304.74
Model F test:       Equal FMI                   F(   6,  304.7)   =       5.89
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   .1325519   .0576147     2.30   0.022     .0191768    .2459271
        male |   .1712694   .0840874     2.04   0.043      .005804    .3367348
   ethnicmin |   .2790625   .0614492     4.54   0.000      .158142    .3999829
intervention |  -.0673169   .0724773    -0.93   0.354    -.2099365    .0753026
  foreignrec |  -.0663188   .0710248    -0.93   0.351      -.20608    .0734425
    ageatbar |   .0053843   .0024563     2.19   0.029     .0005469    .0102218
       _cons |   .1679575   .1251761     1.34   0.181    -.0784421    .4143571
------------------------------------------------------------------------------






mi estimate: regress exitbarred  male  intervention foreign ageatbar social##ethnicmin, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0170
                                                Largest FMI       =     0.1027
                                                Complete DF       =        306
DF adjustment:   Small sample                   DF:     min       =     254.76
                                                        avg       =     294.37
                                                        max       =     303.76
Model F test:       Equal FMI                   F(   7,  303.8)   =       7.58
Within VCE type:       Robust                   Prob > F          =     0.0000

----------------------------------------------------------------------------------
      exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-----------------+----------------------------------------------------------------
            male |   .1529442   .0837514     1.83   0.069    -.0118625    .3177508
    intervention |   -.060214   .0737182    -0.82   0.415    -.2052771    .0848491
      foreignrec |  -.0673425   .0719259    -0.94   0.350    -.2088785    .0741935
        ageatbar |   .0052851   .0024135     2.19   0.029     .0005321     .010038
        1.social |   .1851651   .0647916     2.86   0.005     .0576654    .3126649
     1.ethnicmin |   .3767632   .0693746     5.43   0.000     .2402445    .5132818
                 |
social#ethnicmin |
            1 1  |  -.2792332   .1338005    -2.09   0.038    -.5425306   -.0159359
                 |
           _cons |   .1571509    .123183     1.28   0.203    -.0853232    .3996249
----------------------------------------------------------------------------------



mi estimate: regress exitbarred democracy male ethnicmin intervention foreign ageatbar jiang hu xi, vce(robust)  


Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0116
                                                Largest FMI       =     0.0936
                                                Complete DF       =        304
DF adjustment:   Small sample                   DF:     min       =     258.51
                                                        avg       =     295.30
                                                        max       =     301.99
Model F test:       Equal FMI                   F(   9,  301.9)   =      17.37
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |   .0590414   .0576455     1.02   0.307     -.054397    .1724797
        male |   .1555716   .0818937     1.90   0.058    -.0055829    .3167261
   ethnicmin |   .0753164   .0584253     1.29   0.198    -.0396575    .1902903
intervention |  -.0749437   .0642865    -1.17   0.245      -.20145    .0515627
  foreignrec |  -.0538473   .0632684    -0.85   0.395    -.1783507    .0706561
    ageatbar |  -.0013795   .0022963    -0.60   0.549    -.0059013    .0031422
       jiang |   .3409601   .0834442     4.09   0.000     .1767528    .5051674
          hu |   .6288983   .0707578     8.89   0.000     .4896503    .7681463
          xi |    .636711   .0690997     9.21   0.000     .5007229     .772699
       _cons |   .1148493   .1173862     0.98   0.329    -.1161856    .3458842
------------------------------------------------------------------------------



coefplot, drop( _cons) coeflabels(democracy="democratization advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95) xline(1) xtitle(Figure 9: Odds Ratios for barring exit) 






mi estimate: regress exitbarred recognition, vce(robust)  


Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
                                                Complete DF       =        312
DF adjustment:   Small sample                   DF:     min       =     310.02
                                                        avg       =     310.02
                                                        max       =     310.02
Model F test:       Equal FMI                   F(   1,  310.0)   =      26.09
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   .2742068   .0536838     5.11   0.000     .1685761    .3798375
       _cons |    .556962   .0323703    17.21   0.000     .4932688    .6206553
------------------------------------------------------------------------------





mi estimate,: regress exitbarred recognition male ethnicmin intervention foreign ageatbar, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0203
                                                Largest FMI       =     0.1090
                                                Complete DF       =        307
DF adjustment:   Small sample                   DF:     min       =     251.75
                                                        avg       =     292.50
                                                        max       =     304.66
Model F test:       Equal FMI                   F(   6,  304.7)   =       8.76
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   .1789298   .0779164     2.30   0.022     .0256045    .3322552
        male |   .1205115   .0860604     1.40   0.162    -.0488367    .2898596
   ethnicmin |   .1402962   .0816419     1.72   0.087    -.0203609    .3009533
intervention |  -.0718627   .0716913    -1.00   0.317    -.2129356    .0692101
  foreignrec |   -.042966    .070403    -0.61   0.542    -.1815038    .0955719
    ageatbar |   .0056641   .0024032     2.36   0.019     .0009312     .010397
       _cons |   .2499058    .121864     2.05   0.041     .0100042    .4898075
-----------------


coefplot, drop( _cons) coeflabels(social="recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95) xline(1) xtitle(Figure 10: Odds Ratios for barring exit) 






mi estimate: regress exitbarred male intervention foreign ageatbar recognition##ethnicmin, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0188
                                                Largest FMI       =     0.1107
                                                Complete DF       =        306
DF adjustment:   Small sample                   DF:     min       =     249.99
                                                        avg       =     293.22
                                                        max       =     303.59
Model F test:       Equal FMI                   F(   7,  303.8)   =       9.03
Within VCE type:       Robust                   Prob > F          =     0.0000

---------------------------------------------------------------------------------------
           exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
----------------------+----------------------------------------------------------------
                 male |   .1105652   .0886716     1.25   0.213    -.0639235    .2850539
         intervention |  -.0742969   .0719341    -1.03   0.302    -.2158495    .0672556
           foreignrec |  -.0384865   .0705187    -0.55   0.586    -.1772537    .1002808
             ageatbar |   .0056847   .0023911     2.38   0.018     .0009755    .0103939
        1.recognition |   .1382467   .0966881     1.43   0.154    -.0520197     .328513
          1.ethnicmin |     .08568   .1254413     0.68   0.495    -.1611669     .332527
                      |
recognition#ethnicmin |
                 1 1  |   .1112064    .161871     0.69   0.493    -.2073274    .4297401
                      |
                _cons |   .2617091   .1248836     2.10   0.037     .0158664    .5075517
---------------------------------------------------------------------------------------







mi estimate: regress exitbarred recognition male ethnicmin intervention foreign ageatbar jiang hu xi, vce(robust)  




Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        314
                                                Average RVI       =     0.0101
                                                Largest FMI       =     0.0865
                                                Complete DF       =        304
DF adjustment:   Small sample                   DF:     min       =     262.56
                                                        avg       =     295.86
                                                        max       =     301.98
Model F test:       Equal FMI                   F(   9,  301.9)   =      17.84
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   .0455637   .0701868     0.65   0.517    -.0925535    .1836809
        male |   .1595412   .0812529     1.96   0.051    -.0003524    .3194348
   ethnicmin |   .0318312   .0719727     0.44   0.659    -.1098021    .1734644
intervention |  -.0682989   .0641926    -1.06   0.288    -.1946203    .0580225
  foreignrec |  -.0625658   .0632288    -0.99   0.323    -.1869909    .0618593
    ageatbar |  -.0011958    .002294    -0.52   0.603    -.0057128    .0033213
       jiang |   .3243712    .084543     3.84   0.000      .158002    .4907404
          hu |   .5884568   .0721545     8.16   0.000     .4464631    .7304504
          xi |   .5968304   .0695816     8.58   0.000     .4598971    .7337636
       _cons |   .1564933   .1120891     1.40   0.164     -.064124    .3771106
------------------------------------------------------------------------------





*estimate linear terms for year and dummy term for first charge in 1989





mi estimate, or level(95): logistic exitbarred democracy intervention foreign ethnicmin male ageatbar firstchargedate, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0172
                                                Largest FMI       =     0.1167
DF adjustment:   Large sample                   DF:     min       =   2,895.44
                                                        avg       =   3.32e+08
                                                        max       =   1.58e+09
Model F test:       Equal FMI                   F(   7,711474.4)  =       9.15
Within VCE type:       Robust                   Prob > F          =     0.0000

---------------------------------------------------------------------------------
     exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
----------------+----------------------------------------------------------------
      democracy |   .8312975   .2922576    -0.53   0.599     .4173508    1.655815
   intervention |   .5394688   .1997881    -1.67   0.096      .261054    1.114814
     foreignrec |   1.100228   .3945381     0.27   0.790     .5448091     2.22188
      ethnicmin |   1.201537   .5038799     0.44   0.662     .5281714    2.733377
           male |   3.376885   1.487402     2.76   0.006     1.424266    8.006474
       ageatbar |   .9957781    .014466    -0.29   0.771     .9678135    1.024551
firstchargedate |   1.109775    .020271     5.70   0.000     1.070747    1.150225
          _cons |   2.65e-91   9.63e-90    -5.73   0.000     2.8e-122    2.53e-60
---------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

mi estimate, or level(95): logistic exitbarred democracy intervention foreign ethnicmin male ageatbar firstchargedate1989, vce(robust)  

 mi estimate, or level(95): logistic exitbarred democracy intervention foreign ethnicmin male ageatbar firstchargedate1989, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0115
                                                Largest FMI       =     0.0763
DF adjustment:   Large sample                   DF:     min       =   6,741.89
                                                        avg       =   2.50e+07
                                                        max       =   5.71e+07
Model F test:       Equal FMI                   F(   7, 1.6e+06)  =       7.20
Within VCE type:       Robust                   Prob > F          =     0.0000

-------------------------------------------------------------------------------------
         exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
--------------------+----------------------------------------------------------------
          democracy |   .5062469   .1586723    -2.17   0.030      .273887    .9357362
       intervention |   .7662499   .2649726    -0.77   0.441     .3890641    1.509106
         foreignrec |   .6512822   .2171659    -1.29   0.198     .3387984    1.251979
          ethnicmin |   1.587298   .6296843     1.16   0.244     .7294328    3.454076
               male |   2.521335   1.053639     2.21   0.027     1.111533    5.719245
           ageatbar |   1.017646   .0126955     1.40   0.161     .9930608     1.04284
firstchargedate1989 |   .1599059   .0600243    -4.88   0.000     .0766208      .33372
              _cons |   .9104562   .5651471    -0.15   0.880      .269678    3.073779
-------------------------------------------------------------------------------------
Note: _cons estimates baseline odds.


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0115
                                                Largest FMI       =     0.0763
DF adjustment:   Large sample                   DF:     min       =   6,741.89
                                                        avg       =   2.50e+07
                                                        max       =   5.71e+07
Model F test:       Equal FMI                   F(   7, 1.6e+06)  =       7.20
Within VCE type:       Robust                   Prob > F          =     0.0000

-------------------------------------------------------------------------------------
         exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
--------------------+----------------------------------------------------------------
          democracy |   .5062469   .1586723    -2.17   0.030      .273887    .9357362
       intervention |   .7662499   .2649726    -0.77   0.441     .3890641    1.509106
         foreignrec |   .6512822   .2171659    -1.29   0.198     .3387984    1.251979
          ethnicmin |   1.587298   .6296843     1.16   0.244     .7294328    3.454076
               male |   2.521335   1.053639     2.21   0.027     1.111533    5.719245
           ageatbar |   1.017646   .0126955     1.40   0.161     .9930608     1.04284
firstchargedate1989 |   .1599059   .0600243    -4.88   0.000     .0766208      .33372
              _cons |   .9104562   .5651471    -0.15   0.880      .269678    3.073779
-------------------------------------------------------------------------------------



mi estimate, or level(95): logistic exitbarred social intervention foreign ethnicmin male ageatbar firstchargedate, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0178
                                                Largest FMI       =     0.1213
DF adjustment:   Large sample                   DF:     min       =   2,680.81
                                                        avg       =   2.38e+08
                                                        max       =   8.87e+08
Model F test:       Equal FMI                   F(   7,669429.0)  =       9.48
Within VCE type:       Robust                   Prob > F          =     0.0000

---------------------------------------------------------------------------------
     exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
----------------+----------------------------------------------------------------
         social |    .805963   .2549786    -0.68   0.495     .4335354    1.498324
   intervention |   .5265079   .1917155    -1.76   0.078     .2579051    1.074855
     foreignrec |   1.169044    .416493     0.44   0.661     .5815341    2.350103
      ethnicmin |   1.213166   .4929052     0.48   0.634     .5471168    2.690053
           male |   3.111449   1.374631     2.57   0.010     1.308891    7.396422
       ageatbar |   .9957997   .0145988    -0.29   0.774     .9675812    1.024841
firstchargedate |   1.117526   .0196792     6.31   0.000     1.079613     1.15677
          _cons |   2.54e-97   8.88e-96    -6.36   0.000     4.5e-127    1.45e-67
-----------------------------------------





mi estimate, or level(95): logistic exitbarred social intervention foreign ethnicmin male ageatbar firstchargedate1989, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0126
                                                Largest FMI       =     0.0824
DF adjustment:   Large sample                   DF:     min       =   5,793.04
                                                        avg       =   2.23e+07
                                                        max       =   5.30e+07
Model F test:       Equal FMI                   F(   7, 1.3e+06)  =       7.03
Within VCE type:       Robust                   Prob > F          =     0.0000

-------------------------------------------------------------------------------------
         exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
--------------------+----------------------------------------------------------------
             social |   1.308157    .400756     0.88   0.381     .7176174    2.384662
       intervention |   .7271637   .2451626    -0.94   0.345      .375535    1.408037
         foreignrec |   .6961176   .2287431    -1.10   0.270     .3655773    1.325519
          ethnicmin |   2.255558   .8616999     2.13   0.033     1.066758    4.769161
               male |   2.346663   .9947525     2.01   0.044     1.022411    5.386117
           ageatbar |    1.01729    .012928     1.35   0.177     .9922594    1.042952
firstchargedate1989 |   .1382434   .0501443    -5.46   0.000     .0679035     .281447
              _cons |   .5859486   .4002488    -0.78   0.434     .1535982    2.235284
--------------------------------------------------------------------------------



mi estimate, or level(95): logistic exitbarred recognition intervention foreign ethnicmin male ageatbar firstchargedate, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0168
                                                Largest FMI       =     0.1154
DF adjustment:   Large sample                   DF:     min       =   2,958.24
                                                        avg       =   2.07e+09
                                                        max       =   1.52e+10
Model F test:       Equal FMI                   F(   7,748622.5)  =       9.57
Within VCE type:       Robust                   Prob > F          =     0.0000

---------------------------------------------------------------------------------
     exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
----------------+----------------------------------------------------------------
    recognition |   1.658229   .7881951     1.06   0.287     .6532032    4.209597
   intervention |   .5269246   .1921745    -1.76   0.079     .2578143    1.076936
     foreignrec |   1.106264    .396022     0.28   0.778     .5484591    2.231378
      ethnicmin |   .9986624   .4995944    -0.00   0.998     .3746221     2.66222
           male |   3.141938   1.334049     2.70   0.007     1.367043     7.22126
       ageatbar |   .9955585   .0143081    -0.31   0.757     .9678952    1.024012
firstchargedate |   1.110674   .0192717     6.05   0.000     1.073537    1.149096
          _cons |   4.81e-92   1.66e-90    -6.09   0.000     2.1e-121    1.12e-62
---------------------------------------------------------------------------------
Note: _cons estimates baseline odds.



 mi estimate, or level(95): logistic exitbarred recognition intervention foreign ethnicmin male ageatbar firstchargedate1989, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0121
                                                Largest FMI       =     0.0798
DF adjustment:   Large sample                   DF:     min       =   6,170.35
                                                        avg       =   2.65e+07
                                                        max       =   7.03e+07
Model F test:       Equal FMI                   F(   7, 1.5e+06)  =       7.64
Within VCE type:       Robust                   Prob > F          =     0.0000

-------------------------------------------------------------------------------------
         exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
--------------------+----------------------------------------------------------------
        recognition |    2.10881   .9758791     1.61   0.107     .8513986    5.223264
       intervention |   .7123494   .2358888    -1.02   0.306     .3722412    1.363206
         foreignrec |   .7106014    .229131    -1.06   0.289     .3777105    1.336882
          ethnicmin |   1.434995   .6608662     0.78   0.433     .5818909    3.538824
               male |   2.034315   .8114532     1.78   0.075     .9308692    4.445779
           ageatbar |   1.017081   .0127098     1.36   0.175     .9924677    1.042304
firstchargedate1989 |   .1401986   .0501392    -5.49   0.000      .069555    .2825915
              _cons |   .7167753    .432732    -0.55   0.581     .2195033    2.340588
-------------------------------------------------------------------------------------
Note: _cons estimates baseline odds.







mi estimate, or level(95): logistic exitbarred democracysocial intervention foreign ethnicmin male ageatbar, vce(robust)  


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0216
                                                Largest FMI       =     0.1163
DF adjustment:   Large sample                   DF:     min       =   2,915.78
                                                        avg       = 4522300.94
                                                        max       = 9236462.71
Model F test:       Equal FMI                   F(   6,398034.1)  =       4.17
Within VCE type:       Robust                   Prob > F          =     0.0003

---------------------------------------------------------------------------------
     exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
----------------+----------------------------------------------------------------
democracysocial |   .8905218   .3171645    -0.33   0.745      .443082    1.789802
   intervention |   .7410946   .2326881    -0.95   0.340     .4005108    1.371302
     foreignrec |   .8019911    .250165    -0.71   0.479     .4351654    1.478035
      ethnicmin |   3.479348   1.240542     3.50   0.000     1.729842    6.998247
           male |   1.845931   .6769827     1.67   0.095     .8995865    3.787807
       ageatbar |   1.029238   .0123432     2.40   0.016     1.005318    1.053727
          _cons |   .2930124   .1678557    -2.14   0.032     .0953152    .9007618
---------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

. 




mi estimate, or level(95): logistic exitbarred socialrecognition, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =   8.22e+62
                                                        avg       =   8.22e+62
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       0.38
Within VCE type:       Robust                   Prob > F          =     0.5353

-----------------------------------------------------------------------------------
       exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
------------------+----------------------------------------------------------------
socialrecognition |   1.300063   .5502464     0.62   0.535     .5671483    2.980108
            _cons |   1.623853   .1980262     3.98   0.000     1.278628    2.062288
-----------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

. 




mi estimate, or level(95): logistic exitbarred socialrecognition intervention foreign ethnicmin male ageatbar, vce(robust)


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0214
                                                Largest FMI       =     0.1157
DF adjustment:   Large sample                   DF:     min       =   2,943.16
                                                        avg       = 5715747.07
                                                        max       =   1.53e+07
Model F test:       Equal FMI                   F(   6,405567.5)  =       4.11
Within VCE type:       Robust                   Prob > F          =     0.0004

-----------------------------------------------------------------------------------
       exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
------------------+----------------------------------------------------------------
socialrecognition |   1.288162   .5908956     0.55   0.581     .5242198    3.165391
     intervention |   .7372573    .230666    -0.97   0.330     .3993036    1.361241
       foreignrec |   .7990951   .2480413    -0.72   0.470     .4348938    1.468297
        ethnicmin |   3.529116   1.232921     3.61   0.000     1.779478    6.999053
             male |   1.864901   .6870242     1.69   0.091     .9058905    3.839158
         ageatbar |   1.028592   .0124467     2.33   0.020     1.004474    1.053289
            _cons |   .2859013    .162792    -2.20   0.028      .093636    .8729504
-----------------------------------------------------------------------------------
Note: _cons estimates baseline odds.




mi estimate, or level(95): logistic exitbarred recognitiondemocracy, vce(robust)  


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       0.54
Within VCE type:       Robust                   Prob > F          =     0.4639

--------------------------------------------------------------------------------------
          exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
---------------------+----------------------------------------------------------------
recognitiondemocracy |   1.831579   1.513382     0.73   0.464     .3626619    9.250162
               _cons |   1.637931    .193305     4.18   0.000     1.299687    2.064204
--------------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

. 


mi estimate, or level(95): logistic exitbarred recognitiondemocracy intervention foreign ethnicmin male ageatbar, vce(robust)  


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0212
                                                Largest FMI       =     0.1163
DF adjustment:   Large sample                   DF:     min       =   2,911.55
                                                        avg       =   3.13e+08
                                                        max       =   2.16e+09
Model F test:       Equal FMI                   F(   6,411758.2)  =       4.12
Within VCE type:       Robust                   Prob > F          =     0.0004

--------------------------------------------------------------------------------------
          exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
---------------------+----------------------------------------------------------------
recognitiondemocracy |   1.596515   1.435482     0.52   0.603      .274049    9.300751
        intervention |   .7258943   .2277853    -1.02   0.307      .392434    1.342703
          foreignrec |   .8148647   .2531703    -0.66   0.510     .4432265    1.498116
           ethnicmin |   3.519733   1.231152     3.60   0.000     1.773256    6.986312
                male |   1.813726   .6669907     1.62   0.105     .8821567    3.729047
            ageatbar |   1.029226   .0123748     2.40   0.017     1.005245    1.053778
               _cons |   .2893497   .1655599    -2.17   0.030     .0942491    .8883192
--------------------------------------------------------------------------------------
Note: _cons estimates baseline odds.




*rerun second models with fixed effects for each government

mi estimate, or level(95): logistic exitbarred democracy male ethnicmin intervention foreign ageatbar jiang1 hu1 xi1, vce(robust) 


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0129
                                                Largest FMI       =     0.1099
DF adjustment:   Large sample                   DF:     min       =   3,258.82
                                                        avg       =   7.82e+08
                                                        max       =   3.91e+09
Model F test:       Equal FMI                   F(   9, 1.7e+06)  =       7.79
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   1.785879   .8124473     1.27   0.202     .7321775       4.356
        male |   2.381649   .9840378     2.10   0.036     1.059699    5.352701
   ethnicmin |   1.006657   .4817419     0.01   0.989     .3940336    2.571754
intervention |   .6012608    .220072    -1.39   0.165     .2934325     1.23202
  foreignrec |   .7214891   .2600394    -0.91   0.365     .3559913    1.462245
    ageatbar |   1.004553   .0137946     0.33   0.741      .977867    1.031967
      jiang1 |   2.325106   .9129338     2.15   0.032     1.077024    5.019496
         hu1 |   14.58328     7.1679     5.45   0.000     5.565145    38.21501
         xi1 |   10.32515   4.453792     5.41   0.000     4.433291    24.04732
       _cons |   .1703445   .1125741    -2.68   0.007     .0466394    .6221623

coefplot, drop( _cons) coeflabels(democracy="democratization advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95) eform xline(1) xtitle(Figure 9: Odds Ratios for barring exit with administration effects) 


. 
. mimrgns, dydx(*) predict(pr)

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        311
                                                Average RVI       =     0.0144
                                                Largest FMI       =     0.1099
DF adjustment:   Large sample                   DF:     min       =   3,262.86
                                                        avg       =   8.53e+08
Within VCE type: Delta-method                           max       =   3.15e+09

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : democracy male ethnicmin intervention foreignrec ageatbar jiang1 hu1 xi1

------------------------------------------------------------------------------
             |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |  -.0436501   .0606264    -0.72   0.472    -.1624757    .0751755
        male |   .1609769   .0705608     2.28   0.023     .0226804    .2992735
   ethnicmin |   .0343466   .0695005     0.49   0.621    -.1018719    .1705652
intervention |  -.0787277   .0636252    -1.24   0.216    -.2034309    .0459754
  foreignrec |   -.056275   .0607898    -0.93   0.355    -.1754208    .0628708
    ageatbar |   .0008868   .0023177     0.38   0.702    -.0036575    .0054312
      jiang1 |   .1510217   .0625417     2.41   0.016     .0284422    .2736013
         hu1 |   .4457649   .0694179     6.42   0.000     .3097078     .581822
         xi1 |   .3910841    .061544     6.35   0.000     .2704587    .5117094
-------------------



mi estimate, or level(95): logistic exitbarred social male ethnicmin intervention foreign ageatbar jiang1 hu1 xi1, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0140
                                                Largest FMI       =     0.1158
DF adjustment:   Large sample                   DF:     min       =   2,936.34
                                                        avg       =   1.16e+09
                                                        max       =   5.20e+09
Model F test:       Equal FMI                   F(   9, 1.5e+06)  =       7.46
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   .8104652   .2761707    -0.62   0.537     .4156067     1.58047
        male |   2.345433   .9931243     2.01   0.044     1.022821    5.378318
   ethnicmin |   1.253684   .5253405     0.54   0.590     .5514453    2.850188
intervention |   .6032554    .221122    -1.38   0.168     .2941001    1.237392
  foreignrec |   .7534911   .2694656    -0.79   0.429     .3738256    1.518753
    ageatbar |   1.004936    .013971     0.35   0.723     .9779121    1.032707
      jiang1 |    2.61601   1.022031     2.46   0.014     1.216436    5.625868
         hu1 |   17.63846   9.071009     5.58   0.000     6.437381     48.3295
         xi1 |   12.78963   6.139055     5.31   0.000     4.992042    32.76711
       _cons |   .1757017   .1227457    -2.49   0.013     .0446762    .6909961
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

coefplot, drop( _cons) coeflabels(social="social reform advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95) eform xline(1) xtitle(Figure 10: Odds Ratios for barring exit with administration effects) 




. mimrgns, dydx(*) predict(pr)

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        311
                                                Average RVI       =     0.0155
                                                Largest FMI       =     0.1156
DF adjustment:   Large sample                   DF:     min       =   2,946.83
                                                        avg       =   1.18e+09
Within VCE type: Delta-method                           max       =   6.16e+09

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : social male ethnicmin intervention foreignrec ageatbar jiang1 hu1 xi1

------------------------------------------------------------------------------
             |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |  -.0354759   .0574688    -0.62   0.537    -.1481127    .0771608
        male |   .1439113   .0700903     2.05   0.040     .0065369    .2812857
   ethnicmin |   .0381623   .0710127     0.54   0.591    -.1010201    .1773448
intervention |  -.0853228   .0614879    -1.39   0.165    -.2058368    .0351913
  foreignrec |  -.0477798   .0599755    -0.80   0.426    -.1653295      .06977
    ageatbar |   .0008303   .0023438     0.35   0.723    -.0037655     .005426
      jiang1 |   .1623461   .0632165     2.57   0.010     .0384441    .2862481
         hu1 |   .4845251    .068471     7.08   0.000      .350324    .6187262
         xi1 |   .4302614   .0656468     6.55   0.000     .3015949    .5589279
------------------------------------------------------------------------------



mi estimate, or level(95): logistic exitbarred social male ethnicmin intervention foreign ageatbar social##ethnicmin, vce(robust) 
Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0159
                                                Largest FMI       =     0.0956
DF adjustment:   Large sample                   DF:     min       =   4,303.38
                                                        avg       = 3616383.10
                                                        max       = 7114158.44
Model F test:       Equal FMI                   F(   7,877574.8)  =       5.24
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   2.495764   .7189571     3.17   0.001     1.419048    4.389451
        male |   2.146708   .7985975     2.05   0.040     1.035422    4.450706
   ethnicmin |   6.789744   3.048997     4.27   0.000     2.815875    16.37168
intervention |   .6963613   .2323037    -1.08   0.278     .3621402    1.339037
  foreignrec |   .8389879   .2815076    -0.52   0.601     .4346603    1.619427
    ageatbar |   1.029201   .0128807     2.30   0.022     1.004255    1.054766
    1.social |          1  (omitted)
 1.ethnicmin |          1  (omitted)
             |
      social#|
   ethnicmin |
        1 1  |    .178746   .1263837    -2.44   0.015     .0447083    .7146361
             |
       _cons |   .1696544   .1035342    -2.91   0.004      .051293    .5611407
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

. 
coefplot, drop( _cons) coeflabels(social="recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95) eform xline(1) xtitle(Figure 10: Odds Ratios for barring exit with administration effects) 




mi estimate, or level(95): logistic exitbarred recognition male ethnicmin intervention foreign  ageatbar jiang1 hu1 xi1, vce(robust) 


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0129
                                                Largest FMI       =     0.1099
DF adjustment:   Large sample                   DF:     min       =   3,258.82
                                                        avg       =   7.82e+08
                                                        max       =   3.91e+09
Model F test:       Equal FMI                   F(   9, 1.7e+06)  =       7.79
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   1.785879   .8124473     1.27   0.202     .7321775       4.356
        male |   2.381649   .9840378     2.10   0.036     1.059699    5.352701
   ethnicmin |   1.006657   .4817419     0.01   0.989     .3940336    2.571754
intervention |   .6012608    .220072    -1.39   0.165     .2934325     1.23202
  foreignrec |   .7214891   .2600394    -0.91   0.365     .3559913    1.462245
    ageatbar |   1.004553   .0137946     0.33   0.741      .977867    1.031967
      jiang1 |   2.325106   .9129338     2.15   0.032     1.077024    5.019496
         hu1 |   14.58328     7.1679     5.45   0.000     5.565145    38.21501
         xi1 |   10.32515   4.453792     5.41   0.000     4.433291    24.04732
       _cons |   .1703445   .1125741    -2.68   0.007     .0466394    .6221623
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.


end of do-file

. mimrgns, dydx(*) predict(pr)

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        311
                                                Average RVI       =     0.0143
                                                Largest FMI       =     0.1098
DF adjustment:   Large sample                   DF:     min       =   3,267.88
                                                        avg       =   6.20e+08
Within VCE type: Delta-method                           max       =   2.92e+09

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : recognition male ethnicmin intervention foreignrec ageatbar jiang1 hu1 xi1

------------------------------------------------------------------------------
             |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   .0975019   .0766562     1.27   0.203    -.0527415    .2477454
        male |   .1459027   .0677418     2.15   0.031     .0131312    .2786742
   ethnicmin |   .0011103   .0804614     0.01   0.989    -.1565913    .1588119
intervention |   -.085533   .0611358    -1.40   0.162    -.2053569    .0342909
  foreignrec |  -.0548827   .0601354    -0.91   0.361     -.172746    .0629806
    ageatbar |   .0007629   .0023057     0.33   0.741    -.0037579    .0052836
      jiang1 |   .1418661   .0636477     2.23   0.026     .0171189    .2666134
         hu1 |   .4505765   .0646763     6.97   0.000     .3238127    .5773402
         xi1 |   .3925238   .0573712     6.84   0.000      .280077    .5049707
------------------------------------------------------------------------------

coefplot, drop( _cons) coeflabels(recognition="recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95) eform xline(1) xtitle(Figure 11: ORs for barring exit with administration effects) 





mi estimate, or level(95): logistic exitbarred social male ethnicmin intervention foreign  ageatbar jiang hu xi, vce(robust) 


coefplot, drop( _cons) coeflabels(recognition="social reform advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95) eform xline(1) xtitle(Figure 11: ORs for barring exit with administration effects) 


*

***now run logistic regerssions with interactions



mi estimate, or level(95): logistic exitbarred democracy intervention foreignrec ethnicmin male ageatbar jiang1 hu1 xi1 jiang1_democracy hu1_democracy xi1_democracy, vce(robust) 
Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0108
                                                Largest FMI       =     0.1144
DF adjustment:   Large sample                   DF:     min       =   3,013.00
                                                        avg       =   8.92e+08
                                                        max       =   5.51e+09
Model F test:       Equal FMI                   F(  12, 3.5e+06)  =       5.65
Within VCE type:       Robust                   Prob > F          =     0.0000

----------------------------------------------------------------------------------
      exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-----------------+----------------------------------------------------------------
       democracy |   4.651405   5.136916     1.39   0.164      .533992    40.51666
    intervention |   .6595723   .2517238    -1.09   0.276     .3121792    1.393545
      foreignrec |   .7032483   .2595015    -0.95   0.340     .3412022    1.449458
       ethnicmin |   1.163607   .5117743     0.34   0.730     .4913975    2.755366
            male |   3.161349   1.434592     2.54   0.011     1.298987    7.693787
        ageatbar |   1.007571   .0140783     0.54   0.589     .9803414    1.035556
          jiang1 |   9.511574   11.01344     1.95   0.052     .9832111    92.01487
             hu1 |   85.45472   97.03897     3.92   0.000     9.228806    791.2735
             xi1 |    63.8747   70.62335     3.76   0.000     7.314658    557.7811
jiang1_democracy |   .2229979    .274795    -1.22   0.223     .0199244    2.495836
   hu1_democracy |   .0753808   .1000226    -1.95   0.051      .005595    1.015588
   xi1_democracy |   .0799481   .0988569    -2.04   0.041     .0070841     .902258
           _cons |   .0300998   .0386684    -2.73   0.006     .0024268    .3733239
----------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

. mimrgns, dydx(*) predict(pr)

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        311
                                                Average RVI       =     0.0116
                                                Largest FMI       =     0.1141
DF adjustment:   Large sample                   DF:     min       =   3,026.56
                                                        avg       =   8.93e+08
Within VCE type: Delta-method                           max       =   5.54e+09

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : democracy intervention foreignrec ethnicmin male ageatbar jiang1 hu1 xi1 jiang1_democracy hu1_democracy xi1_democrac
> y

----------------------------------------------------------------------------------
                 |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-----------------+----------------------------------------------------------------
       democracy |   .2540462    .181488     1.40   0.162    -.1016637    .6097562
    intervention |   -.068779   .0630337    -1.09   0.275    -.1923229    .0547648
      foreignrec |  -.0581793   .0607048    -0.96   0.338    -.1771585    .0607998
       ethnicmin |   .0250364   .0728157     0.34   0.731    -.1176797    .1677525
            male |   .1902211   .0726675     2.62   0.009     .0477954    .3326468
        ageatbar |   .0012451   .0023031     0.54   0.589    -.0032706    .0057608
          jiang1 |   .3722789   .1878808     1.98   0.048     .0040393    .7405185
             hu1 |   .7351189   .1733486     4.24   0.000     .3953619    1.074876
             xi1 |   .6870169   .1697867     4.05   0.000     .3542409    1.019793
jiang1_democracy |  -.2480087   .2026791    -1.22   0.221    -.6452525    .1492351
   hu1_democracy |  -.4272479   .2173382    -1.97   0.049    -.8532229   -.0012729
   xi1_democracy |  -.4175233   .2015568    -2.07   0.038    -.8125673   -.0224793
----------------------------------------------------------------------------------




mi estimate, or level(95): logistic exitbarred social intervention foreignrec ethnicmin male ageatbar jiang1 hu1 xi1 jiang1_social hu1_social xi1_social, vce(robust)

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0120
                                                Largest FMI       =     0.1264
DF adjustment:   Large sample                   DF:     min       =   2,468.92
                                                        avg       =   4.36e+08
                                                        max       =   2.04e+09
Model F test:       Equal FMI                   F(  12, 2.8e+06)  =       5.47
Within VCE type:       Robust                   Prob > F          =     0.0000

-------------------------------------------------------------------------------
   exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
--------------+----------------------------------------------------------------
       social |   1.037059   .6863446     0.05   0.956     .2834412    3.794409
 intervention |   .6258282   .2200618    -1.33   0.183     .3141554     1.24671
   foreignrec |   .7790937   .2764118    -0.70   0.482     .3886826    1.561652
    ethnicmin |   1.438592   .6652323     0.79   0.432     .5811998    3.560816
         male |   2.519849   1.105745     2.11   0.035     1.066241    5.955162
     ageatbar |   1.007171   .0141791     0.51   0.612     .9797474    1.035363
       jiang1 |   3.111561   1.456821     2.42   0.015     1.242937    7.789466
          hu1 |   31.98722   27.76211     3.99   0.000     5.837243    175.2852
          xi1 |    7.86999    5.04396     3.22   0.001     2.240932    27.63883
jiang1_social |   .5667029   .4817121    -0.67   0.504     .1071056    2.998463
   hu1_social |   .3439177   .3672938    -1.00   0.318      .042403     2.78941
   xi1_social |   1.622984   1.438012     0.55   0.585     .2858411    9.215182
        _cons |   .1413078   .1058366    -2.61   0.009     .0325522    .6134117
-------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

. 
. mimrgns, dydx(*) predict(pr)

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        311
                                                Average RVI       =     0.0130
                                                Largest FMI       =     0.1262
DF adjustment:   Large sample                   DF:     min       =   2,475.05
                                                        avg       =   4.71e+08
Within VCE type: Delta-method                           max       =   2.07e+09

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : social intervention foreignrec ethnicmin male ageatbar jiang1 hu1 xi1 jiang1_social hu1_social xi1_social

-------------------------------------------------------------------------------
              |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
--------------+----------------------------------------------------------------
       social |   .0060884   .1107224     0.05   0.956    -.2109235    .2231002
 intervention |  -.0784315   .0582953    -1.35   0.178    -.1926882    .0358252
   foreignrec |  -.0417716   .0589936    -0.71   0.479    -.1573969    .0738537
    ethnicmin |   .0608504   .0774502     0.79   0.432    -.0909492      .21265
         male |   .1546591   .0718672     2.15   0.031     .0138019    .2955162
     ageatbar |   .0011944   .0023491     0.51   0.611     -.003412    .0058008
       jiang1 |   .1899613   .0748463     2.54   0.011     .0432653    .3366573
          hu1 |   .5799115   .1327856     4.37   0.000     .3196565    .8401665
          xi1 |    .345258   .1001815     3.45   0.001     .1489051    .5416109
jiang1_social |  -.0950351   .1414942    -0.67   0.502    -.3723586    .1822884
   hu1_social |  -.1786076   .1781392    -1.00   0.316     -.527754    .1705388
   xi1_social |   .0810361   .1482232     0.55   0.585    -.2094761    .3715482
------------




mi estimate, or level(95): logistic exitbarred recognition intervention foreignrec ethnicmin male ageatbar jiang1 hu1 xi1 jiang1_recognition hu1_recognition xi1_recognition, vce(robust)

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0102
                                                Largest FMI       =     0.1088
DF adjustment:   Large sample                   DF:     min       =   3,328.55
                                                        avg       =   1.81e+08
                                                        max       =   1.30e+09
Model F test:       Equal FMI                   F(  12, 3.8e+06)  =      19.24
Within VCE type:       Robust                   Prob > F          =     0.0000




------------------------------------------------------------------------------------
        exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------------+----------------------------------------------------------------
       recognition |    2858274    3133228    13.56   0.000     333441.9    2.45e+07
      intervention |   .5451266   .1995437    -1.66   0.097     .2660204    1.117069
        foreignrec |   .7613173   .2785636    -0.75   0.456     .3716326    1.559616
         ethnicmin |   1.014696    .515062     0.03   0.977     .3752008     2.74415
              male |    2.31775   .9736372     2.00   0.045     1.017408    5.280052
          ageatbar |   1.007296   .0139355     0.53   0.599     .9803401    1.034993
            ji ang1 |   3.137881   1.272517     2.82   0.005     1.417247    6.947483
               hu1 |   13.25326   6.935494     4.94   0.000     4.752088    36.96247
               xi1 |   9.258866   4.062585     5.07   0.000     3.918034       21.88
jiang1_recognition |   1.22e-07   1.62e-07   -11.98   0.000     9.02e-09    1.65e-06
   hu1_recognition |   1.04e-06   1.47e-06    -9.73   0.000     6.50e-08    .0000167
   xi1_recognition |   1.20e-06   1.60e-06   -10.19   0.000     8.72e-08    .0000165
             _cons |   .1519471    .100894    -2.84   0.005     .0413467     .558399
------------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

. mimrgns, dydx(*) predict(pr)

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        311
                                                Average RVI       =     0.0111
                                                Largest FMI       =     0.1085
DF adjustment:   Large sample                   DF:     min       =   3,343.45
                                                        avg       =   2.22e+08
Within VCE type: Delta-method                           max       =   1.39e+09

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : recognition intervention foreignrec ethnicmin male ageatbar jiang1 hu1 xi1 jiang1_recognition hu1_recognition xi1_re
> cognition

------------------------------------------------------------------------------------
                   |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-------------------+----------------------------------------------------------------
       recognition |    2.42733   .2256271    10.76   0.000     1.985109    2.869551
      intervention |  -.0990706   .0592684    -1.67   0.095    -.2152344    .0170933
        foreignrec |  -.0445271   .0593284    -0.75   0.453    -.1608087    .0717546
         ethnicmin |   .0023742   .0828899     0.03   0.977    -.1600871    .1648355
              male |   .1372571   .0671123     2.05   0.041     .0057193    .2687949
          ageatbar |   .0011857   .0022533     0.53   0.599    -.0032323    .0056038
            jiang1 |   .1867276   .0625891     2.98   0.003     .0640551       .3094
               hu1 |   .4219778   .0692864     6.09   0.000     .2861785     .557777
               xi1 |   .3634154   .0588891     6.17   0.000     .2479938    .4788369
jiang1_recognition |  -2.599217   .2523196   -10.30   0.000    -3.093754   -2.104679
   hu1_recognition |  -2.249174    .264808    -8.49   0.000    -2.768188    -1.73016
   xi1_recognition |  -2.226147   .2621035    -8.49   0.000    -2.739861   -1.712434
------------------------------------------------------------------------------------










*now do interactions with LPMs:

mi estimate, level(95): regress exitbarred democracy intervention foreignrec ethnicmin male ageatbar jiang1 hu1 xi1 jiang1_democracy hu1_democracy xi1_democracy, vce(robust)  


Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0106
                                                Largest FMI       =     0.1128
                                                Complete DF       =        298
DF adjustment:   Small sample                   DF:     min       =     242.71
                                                        avg       =     290.52
                                                        max       =     295.97
Model F test:       Equal FMI                   F(  12,  296.0)   =      13.99
Within VCE type:       Robust                   Prob > F          =     0.0000

----------------------------------------------------------------------------------
      exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-----------------+----------------------------------------------------------------
       democracy |    .212649   .1100205     1.93   0.054    -.0038729    .4291709
    intervention |  -.0697849   .0668955    -1.04   0.298    -.2014361    .0618663
      foreignrec |   -.054337   .0618502    -0.88   0.380    -.1760593    .0673852
       ethnicmin |   .0159676   .0595597     0.27   0.789    -.1012484    .1331835
            male |   .1838264   .0759403     2.42   0.016      .034375    .3332777
        ageatbar |   .0012907   .0023204     0.56   0.579    -.0032801    .0058614
          jiang1 |   .3840985    .150497     2.55   0.011     .0879149     .680282
             hu1 |   .7832558   .1025285     7.64   0.000     .5814736    .9850379
             xi1 |    .743926   .1025754     7.25   0.000     .5420488    .9458033
jiang1_democracy |  -.2083617   .1785813    -1.17   0.244    -.5598136    .1430902
   hu1_democracy |  -.3591573   .1610481    -2.23   0.026    -.6761019   -.0422128
   xi1_democracy |   -.364753   .1475984    -2.47   0.014    -.6552285   -.0742776
           _cons |  -.0839771   .1406863    -0.60   0.551    -.3608906    .1929364
----------------------------------------------------------------------------------




mi estimate, level(95): regress exitbarred social intervention foreignrec ethnicmin male ageatbar jiang1 hu1 xi1 jiang1_social hu
> 1_social xi1_social, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0118
                                                Largest FMI       =     0.1234
                                                Complete DF       =        298
DF adjustment:   Small sample                   DF:     min       =     236.49
                                                        avg       =     289.51
                                                        max       =     295.99
Model F test:       Equal FMI                   F(  12,  295.9)   =      11.57
Within VCE type:       Robust                   Prob > F          =     0.0000

-------------------------------------------------------------------------------
   exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
--------------+----------------------------------------------------------------
       social |   .0080127    .123908     0.06   0.948    -.2358395    .2518649
 intervention |  -.0795465   .0642436    -1.24   0.217    -.2059788    .0468857
   foreignrec |  -.0367799   .0624571    -0.59   0.556    -.1596964    .0861366
    ethnicmin |   .0525164   .0724966     0.72   0.469    -.0901601     .195193
         male |    .158953   .0775102     2.05   0.041      .006412     .311494
     ageatbar |   .0011927    .002366     0.50   0.615    -.0034684    .0058538
       jiang1 |   .2627476   .1040756     2.52   0.012      .057925    .4675702
          hu1 |   .6103924   .0906338     6.73   0.000     .4320218    .7887629
          xi1 |   .4683949   .1129998     4.15   0.000     .2460008    .6907891
jiang1_social |  -.1384612   .1788068    -0.77   0.439     -.490355    .2134327
   hu1_social |  -.0940278    .146806    -0.64   0.522    -.3829449    .1948893
   xi1_social |   .0680099   .1538177     0.44   0.659    -.2347054    .3707252
        _cons |   .1128762   .1265017     0.89   0.373    -.1361502    .3619026
-------------------------------------------------------------------------------



-------------------------------------------------------------------

mi estimate, level(95): regress exitbarred recognition intervention foreignrec ethnicmin male ageatbar jiang1 hu1 xi1 jiang1_recognition hu1_recognition xi1_recognition, vce(robust)
ltiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0109
                                                Largest FMI       =     0.1062
                                                Complete DF       =        298
DF adjustment:   Small sample                   DF:     min       =     246.52
                                                        avg       =     289.63
                                                        max       =     295.98
Model F test:       Equal FMI                   F(  12,  296.0)   =      25.72
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------------
        exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------------+----------------------------------------------------------------
       recognition |   .8068137   .0757322    10.65   0.000     .6577635    .9558639
      intervention |  -.1000395   .0639055    -1.57   0.119    -.2258063    .0257272
        foreignrec |  -.0359934   .0611739    -0.59   0.557    -.1563844    .0843976
         ethnicmin |  -.0037922   .0738288    -0.05   0.959    -.1490898    .1415055
              male |    .140341   .0749215     1.87   0.062    -.0071053    .2877873
          ageatbar |    .001324   .0022941     0.58   0.564    -.0031946    .0058426
            jiang1 |   .2597409   .0894667     2.90   0.004     .0836687     .435813
               hu1 |   .5456589    .085522     6.38   0.000     .3773459     .713972
               xi1 |   .4870112   .0793437     6.14   0.000     .3308548    .6431676
jiang1_recognition |  -1.048211   .1771677    -5.92   0.000    -1.396884   -.6995376
   hu1_recognition |  -.6990545    .118292    -5.91   0.000    -.9318577   -.4662513
   xi1_recognition |  -.6552498   .1167359    -5.61   0.000     -.884994   -.4255057
             _cons |   .1237567    .113308     1.09   0.276    -.0992958    .3468091
------------------------------------------------------------------------------------


mi estimate, or level(95): logistic exitbarred democracy intervention foreign ethnicmin male ageatbar jiang hu xi jiang##democracy hu##democracy xi##democracy, vce(robust) 

mi estimate, or level(95): logistic exitbarred recognition intervention foreign ethnicmin male ageatbar jiang hu xi jiang##recognition hu##recognition xi##recognition, vce(robust) 

mi estimate, or level(95): logistic exitbarred social intervention foreign ethnicmin male ageatbar jiang hu xi jiang##social hu##social xi##social, vce(robust) 




*This reveals how during the Deng era, those dissidents who advocated for democracy were more likely to successfully migrate than those who did not, but this was not the case during the Jiang and Hu era

*if you include interaction term you get these results:
*This reveals how during the Deng era, those dissidents who advocated for democracy were more likely to successfully migrate than those who did not, but this was not the case during the Hu era. 
*emigrate from the PRC 


#running interactions with imputed variables
mi estimate, or level(95): logistic exitbarred democracy intervention foreign ethnicmin male ageatbar jiang1 hu1 xi1 jiang1##democracy hu1##democracy xi1##democracy, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0119
                                                Largest FMI       =     0.1209
DF adjustment:   Large sample                   DF:     min       =   2,697.86
                                                        avg       =   5.22e+08
                                                        max       =   3.30e+09
Model F test:       Equal FMI                   F(  12, 2.9e+06)  =       6.43
Within VCE type:       Robust                   Prob > F          =     0.0000

---------------------------------------------------------------------------------
     exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
----------------+----------------------------------------------------------------
      democracy |   5.525515   6.095507     1.55   0.121     .6358642    48.01546
   intervention |   .6175442   .2442337    -1.22   0.223     .2844623    1.340637
     foreignrec |   .7246118   .2764739    -0.84   0.399     .3430295    1.530662
      ethnicmin |   1.244611   .5863008     0.46   0.642     .4943751    3.133361
           male |   3.659334   1.753258     2.71   0.007     1.430786    9.358997
       ageatbar |    .994309   .0151941    -0.37   0.709     .9649576    1.024553
          jiang |   16.75907   19.08353     2.48   0.013      1.79882    156.1393
             hu |   141.3894   158.0006     4.43   0.000     15.82017    1263.637
             xi |   135.3567   149.1522     4.45   0.000     15.61434    1173.372
        1.jiang |          1  (omitted)
    1.democracy |          1  (omitted)
                |
jiang#democracy |
           1 1  |   .2409986   .2948833    -1.16   0.245     .0219025    2.651769
                |
           1.hu |          1  (omitted)
                |
   hu#democracy |
           1 1  |   .1337361   .1881724    -1.43   0.153     .0084834    2.108265
                |
           1.xi |          1  (omitted)
                |
   xi#democracy |
           1 1  |   .0773707   .0964766    -2.05   0.040     .0067171    .8911957
                |
          _cons |   .0283223    .037076    -2.72   0.006     .0021769    .3684878
---------------------------------------------------------------------------------
Note: _cons estimates baseline odds.


 mimrgns, dydx(*) predict(pr)
 
 Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        310
                                                Average RVI       =     0.0065
                                                Largest FMI       =     0.0495
DF adjustment:   Large sample                   DF:     min       =  16,019.48
                                                        avg       =   1.48e+09
Within VCE type: Delta-method                           max       =   9.65e+09

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : intervention foreignrec ethnicmin male ageatbar 1.jiang 1.democracy
>  1.hu 1.xi

------------------------------------------------------------------------------
             |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
intervention |  -.0342867   .0530948    -0.65   0.518    -.1383505    .0697771
  foreignrec |  -.0597664      .0563    -1.06   0.288    -.1701123    .0505795
   ethnicmin |   .0381332   .0704187     0.54   0.588     -.099885    .1761514
        male |   .1918583   .0690551     2.78   0.005     .0565128    .3272038
    ageatbar |  -.0001052   .0020686    -0.05   0.959      -.00416    .0039495
     1.jiang |   .2079665    .042276     4.92   0.000      .125107     .290826
 1.democracy |   .0142346   .0583077     0.24   0.807    -.1000465    .1285156
        1.hu |   .4666329    .041656    11.20   0.000     .3849886    .5482772
        1.xi |   .4668953   .0467045    10.00   0.000     .3753561    .5584345
------------------------------------------------------------------------------
Note: dy/dx for factor levels is the discrete change from the base level.



*Those who advocate for democracy were more likely to migrate than those who did not during the Jiang, Hu and Xi era than those who did not, and this was especially the case during the Hu and Xi era. 




*social
mi estimate, or level(95): logistic exitbarred social intervention foreign ethnicmin male ageatbar jiang hu xi jiang_social hu_social xi_social, vce(robust) 



Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        314
                                                Average RVI       =     0.0133
                                                Largest FMI       =     0.1379
DF adjustment:   Large sample                   DF:     min       =   2,075.87
                                                        avg       =   5.39e+08
                                                        max       =   5.01e+09
Model F test:       Equal FMI                   F(  12, 2.3e+06)  =     459.62
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   1.121799    .653437     0.20   0.844     .3581777    3.513433
intervention |    .631725   .2371881    -1.22   0.221     .3026461    1.318624
  foreignrec |   .7652736   .2845998    -0.72   0.472     .3691994    1.586253
   ethnicmin |   1.211277   .5353692     0.43   0.665     .5093576    2.880474
        male |   2.225096   1.030564     1.73   0.084     .8976574    5.515524
    ageatbar |   .9922122    .014602    -0.53   0.595     .9639854    1.021266
       jiang |   4.540675   2.177014     3.16   0.002     1.774246    11.62056
          hu |   1.03e+08   4.14e+07    45.77   0.000     4.66e+07    2.26e+08
          xi |    31.4283   23.37075     4.64   0.000     7.317213    134.9883
jiang_social |   .9384828   .7805573    -0.08   0.939     .1838497    4.790599
   hu_social |   9.89e-08   7.28e-08   -21.89   0.000     2.33e-08    4.19e-07
   xi_social |   .5131753   .4848796    -0.71   0.480     .0805375    3.269891
       _cons |    .207522   .1416729    -2.30   0.021     .0544378     .791094
------------------------------------------------------------------------------
Note: _cons estimates baseline odds.







mimrgns, dydx(*) predict(pr)

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        311
                                                Average RVI       =     0.0168
                                                Largest FMI       =     0.1328
DF adjustment:   Large sample                   DF:     min       =   2,238.49
                                                        avg       =   9.87e+08
Within VCE type: Delta-method                           max       =   9.90e+09

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : social intervention foreignrec ethnicmin male ageatbar jiang hu xi jiang_social hu_social xi_social

------------------------------------------------------------------------------
             |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |  -.0261333   .0889565    -0.29   0.769    -.2004847    .1482182
intervention |  -.0453429    .053969    -0.84   0.401    -.1511203    .0604345
  foreignrec |  -.0444792   .0570314    -0.78   0.435    -.1562587    .0673004
   ethnicmin |   .0046541   .0702921     0.07   0.947     -.133116    .1424242
        male |    .145607   .0652437     2.23   0.026     .0177316    .2734824
    ageatbar |  -.0006584   .0021335    -0.31   0.758    -.0048424    .0035255
       jiang |   .2191674   .0647381     3.39   0.001      .092283    .3460517
          hu |   2.570585    .184928    13.90   0.000     2.208132    2.933039
          xi |   .4415694   .0973246     4.54   0.000     .2508163    .6323224
jiang_social |   .0011217   .1257507     0.01   0.993    -.2453451    .2475884
   hu_social |  -2.137642   .2247818    -9.51   0.000    -2.578207   -1.697076
   xi_social |   .0179096   .1409645     0.13   0.899    -.2583757    .2941949
------------------------------------------------------------------------------


*recognition
mi estimate, or level(95): logistic exitbarred recognition intervention foreign ethnicmin male ageatbar jiang1 hu1 xi1 jiang1_recogition hu1_recognition xi1_recognition, vce(robust) 


*!*



*recognition##ethnicmin
mi estimate, or level(95): logistic exitbarred  intervention foreign ethnicmin male ageatbar deng_recognition jiang_recognition hu_recognition ethnicmin, vce(robust) 




mi estimate, or level(95): logistic exitbarred  intervention foreign ethnicmin male ageatbar deng##recognition jiang##recognition hu##recognition, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        310
                                                Average RVI       =     0.0047
                                                Largest FMI       =     0.0537
DF adjustment:   Large sample                   DF:     min       =  13,583.03
                                                        avg       =   6.48e+09
                                                        max       =   6.57e+10
Model F test:       Equal FMI                   F(  12, 1.8e+07)  =       6.36
Within VCE type:       Robust                   Prob > F          =     0.0000

--------------------------------------------------------------------------------
    exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
---------------+----------------------------------------------------------------
  intervention |   .7686954   .2600099    -0.78   0.437     .3961291    1.491667
    foreignrec |   .6876247   .2601154    -0.99   0.322     .3276106    1.443261
     ethnicmin |   .9753432   .5316257    -0.05   0.963     .3351174     2.83869
          male |   2.715431   1.197569     2.27   0.024     1.144034    6.445233
      ageatbar |   .9990428    .013532    -0.07   0.944     .9728672    1.025923
        1.deng |   .0680855   .0317657    -5.76   0.000     .0272848    .1698981
 1.recognition |   3.779868   3.285823     1.53   0.126     .6879086    20.76933
               |
          deng#|
   recognition |
          1 1  |    .240742   .3531314    -0.97   0.332     .0135822    4.267105
               |
       1.jiang |   .3132753   .1478186    -2.46   0.014     .1242474     .789887
               |
         jiang#|
   recognition |
          1 1  |   .1085405   .1189181    -2.03   0.043     .0126767    .9293454
               |
          1.hu |   1.279117   .6578954     0.48   0.632     .4667747    3.505206
               |
hu#recognition |
          1 1  |   1.309748   1.791085     0.20   0.844     .0897774     19.1077
               |
         _cons |   2.201634   1.593115     1.09   0.275     .5330766    9.092862
--------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

mimrgns, dydx(*) predict(pr)



mi estimate, or level(95): logistic exitbarred  intervention foreign ethnicmin male ageatbar jiang##recognition hu##recognition xi##recognition, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        310
                                                Average RVI       =     0.0047
                                                Largest FMI       =     0.0537
DF adjustment:   Large sample                   DF:     min       =  13,583.03
                                                        avg       =   6.07e+09
                                                        max       =   6.57e+10
Model F test:       Equal FMI                   F(  12, 1.8e+07)  =       6.36
Within VCE type:       Robust                   Prob > F          =     0.0000

--------------------------------------------------------------------------------
    exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
---------------+----------------------------------------------------------------
  intervention |   .7686954   .2600099    -0.78   0.437     .3961291    1.491667
    foreignrec |   .6876247   .2601154    -0.99   0.322     .3276106    1.443261
     ethnicmin |   .9753432   .5316257    -0.05   0.963     .3351174     2.83869
          male |   2.715431   1.197569     2.27   0.024     1.144034    6.445233
      ageatbar |   .9990428    .013532    -0.07   0.944     .9728672    1.025923
       1.jiang |   4.601205   1.912647     3.67   0.000     2.037233    10.39208
 1.recognition |   .9099732   1.173304    -0.07   0.942     .0726948    11.39078
               |
         jiang#|
   recognition |
          1 1  |   .4508581   .6524062    -0.55   0.582     .0264438    7.686984
               |
          1.hu |   18.78693   9.897372     5.57   0.000     6.689964    52.75794
               |
hu#recognition |
          1 1  |   5.440463    9.02721     1.02   0.307     .2105042    140.6083
               |
          1.xi |   14.68742   6.852505     5.76   0.000     5.885882    36.65044
               |
xi#recognition |
          1 1  |   4.153824   6.093018     0.97   0.332     .2343509    73.62569
               |
         _cons |   .1498993   .0936203    -3.04   0.002     .0440727    .5098356
--------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        310
                                                Average RVI       =     0.0066
                                                Largest FMI       =     0.0537
DF adjustment:   Large sample                   DF:     min       =  13,594.99
                                                        avg       =   8.49e+09
Within VCE type: Delta-method                           max       =   5.64e+10

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : intervention foreignrec ethnicmin male ageatbar 1.jiang 1.recogniti
> on 1.hu 1.xi

-------------------------------------------------------------------------------
              |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
--------------+----------------------------------------------------------------
 intervention |  -.0393432   .0505633    -0.78   0.437    -.1384455    .0597591
   foreignrec |  -.0560118   .0559194    -1.00   0.317    -.1656118    .0535881
    ethnicmin |  -.0037341   .0814907    -0.05   0.963     -.163453    .1559848
         male |   .1494026   .0641823     2.33   0.020     .0236076    .2751977
     ageatbar |  -.0001433   .0020256    -0.07   0.944    -.0041138    .0038272
      1.jiang |   .1963303   .0462702     4.24   0.000     .1056424    .2870181
1.recognition |   .0320189   .0806334     0.40   0.691    -.1260196    .1900575
         1.hu |   .4387107   .0444711     9.87   0.000      .351549    .5258725
         1.xi |   .4467869   .0493788     9.05   0.000     .3500061    .5435678
-------------------------------------------------------------------------------
Note: dy/dx for factor levels is the discrete change from the base level.

*those who advocated for reognition had a lower probability of succesfully emigrating from the PRC
*than those who did not, and their probablity of emigrating was twice as lower if they 
*emigrated druing the Xi and Hu era than the Deng era.



variable recognition_jiang not found
an error occurred when mi estimate executed logistic on m=1
r(111);


*run interactions with ethnicmin
mi estimate, level(95): regress exitbarred democracy male ethnicmin intervention foreign ageatbar ethnicmin_democracy , vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0195
                                                Largest FMI       =     0.1074
                                                Complete DF       =        303
DF adjustment:   Small sample                   DF:     min       =     249.65
                                                        avg       =     286.80
                                                        max       =     300.65
Model F test:       Equal FMI                   F(   7,  300.8)   =       9.03
Within VCE type:       Robust                   Prob > F          =     0.0000

-------------------------------------------------------------------------------------
         exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
--------------------+----------------------------------------------------------------
          democracy |  -.2397232   .0639915    -3.75   0.000    -.3656561   -.1137904
               male |   .2000567   .0759442     2.63   0.009     .0506058    .3495076
          ethnicmin |    .028782   .0662431     0.43   0.664    -.1015831    .1591472
       intervention |  -.0457727   .0681261    -0.67   0.502    -.1798383    .0882928
         foreignrec |  -.0264727   .0709267    -0.37   0.709    -.1660507    .1131053
           ageatbar |  -.0063842   .0021917    -2.91   0.004    -.0107008   -.0020677
ethnicmin_democracy |    .088105   .2053372     0.43   0.668    -.3159751    .4921851
              _cons |  -11.94747   4.307599    -2.77   0.006    -20.43134   -3.463609
-------------------------------------------------------------------------------------


mi estimate, level(95): regress exitbarred social male ethnicmin intervention foreign ageatbar ethnicmin_social , vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0161
                                                Largest FMI       =     0.0915
                                                Complete DF       =        303
DF adjustment:   Small sample                   DF:     min       =     258.87
                                                        avg       =     292.72
                                                        max       =     300.52
Model F test:       Equal FMI                   F(   7,  300.8)   =       7.86
Within VCE type:       Robust                   Prob > F          =     0.0000

----------------------------------------------------------------------------------
      exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-----------------+----------------------------------------------------------------
          social |   .2099024   .0646402     3.25   0.001     .0826951    .3371096
            male |   .1663051   .0826471     2.01   0.045     .0036642     .328946
       ethnicmin |   .3722978   .0689927     5.40   0.000     .2365257    .5080699
    intervention |  -.0780684   .0732872    -1.07   0.288    -.2222895    .0661527
      foreignrec |  -.0356677   .0708605    -0.50   0.615    -.1751137    .1037783
        ageatbar |   .0056886   .0023724     2.40   0.017      .001017    .0103602
ethnicmin_social |    -.33447   .1341699    -2.49   0.013    -.5985048   -.0704352
           _cons |   .1325967   .1221996     1.09   0.279    -.1079357     .373129
----------------------------------------------------------------------------------






mi estimate, level(95): regress exitbarred recognition  male ethnicmin intervention foreign ageatbar ethnicmin_recognition, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0198
                                                Largest FMI       =     0.1075
                                                Complete DF       =        303
DF adjustment:   Small sample                   DF:     min       =     249.62
                                                        avg       =     290.63
                                                        max       =     300.42
Model F test:       Equal FMI                   F(   7,  300.8)   =       8.70
Within VCE type:       Robust                   Prob > F          =     0.0000

---------------------------------------------------------------------------------------
           exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
----------------------+----------------------------------------------------------------
          recognition |   .1534849   .0989994     1.55   0.122    -.0413366    .3483065
                 male |   .1182489   .0873764     1.35   0.177    -.0536989    .2901967
            ethnicmin |    .042054   .1246586     0.34   0.736     -.203263    .2873711
         intervention |  -.0968271   .0715457    -1.35   0.177    -.2376213    .0439671
           foreignrec |  -.0105785   .0697667    -0.15   0.880    -.1478723    .1267153
             ageatbar |   .0062476   .0023583     2.65   0.009     .0016028    .0108924
ethnicmin_recognition |   .1216802   .1641722     0.74   0.459    -.2013956     .444756
                _cons |   .2489104    .125646     1.98   0.049     .0015616    .4962592
---------------------------------------------------------------------------------------

. 











mi estimate, or level(95): logistic exitbarred democracy  male ethnicmin intervention foreign ageatbar ethnicmin_democracy, vce(robust) 


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0170
                                                Largest FMI       =     0.1048
DF adjustment:   Large sample                   DF:     min       =   3,582.79
                                                        avg       = 3882431.00
                                                        max       =   1.25e+07
Model F test:       Equal FMI                   F(   7,764871.7)  =       5.77
Within VCE type:       Robust                   Prob > F          =     0.0000

-------------------------------------------------------------------------------------
         exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
--------------------+----------------------------------------------------------------
          democracy |    .324689   .1015056    -3.60   0.000     .1759387    .5992028
               male |   2.510617   .9450531     2.45   0.014     1.200518    5.250396
          ethnicmin |   1.857811   .7829279     1.47   0.142     .8133614    4.243452
       intervention |   .7414439   .2494199    -0.89   0.374     .3834742    1.433575
         foreignrec |   .7750539   .2672429    -0.74   0.460     .3943055     1.52346
           ageatbar |   1.029618   .0124902     2.41   0.016     1.005418      1.0544
ethnicmin_democracy |   .7932607   .8596918    -0.21   0.831     .0948268    6.635916
              _cons |   .4705977   .2841374    -1.25   0.212     .1440878    1.536995
-------------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

. 
. mimrgns, dydx(*) predict(pr)

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        311
                                                Average RVI       =     0.0189
                                                Largest FMI       =     0.1035
DF adjustment:   Large sample                   DF:     min       =   3,676.76
                                                        avg       = 4699566.20
Within VCE type: Delta-method                           max       =   1.40e+07

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : democracy male ethnicmin intervention foreignrec ageatbar ethnicmin_democracy

-------------------------------------------------------------------------------------
                    |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
--------------------+----------------------------------------------------------------
          democracy |  -.2236967   .0570098    -3.92   0.000    -.3354341   -.1119594
               male |    .183036   .0730198     2.51   0.012     .0399197    .3261523
          ethnicmin |   .1231403   .0835274     1.47   0.140    -.0405705    .2868512
       intervention |  -.0594785   .0667048    -0.89   0.373    -.1902176    .0712606
         foreignrec |  -.0506722   .0682832    -0.74   0.458    -.1845048    .0831605
           ageatbar |   .0057991   .0023067     2.51   0.012     .0012766    .0103215
ethnicmin_democracy |  -.0460067   .2155917    -0.21   0.831    -.4685586    .3765453
-------------------------------------------------------------------------------------




mi estimate, or level(95): logistic exitbarred social  male ethnicmin intervention foreign ageatbar ethnicmin_social, vce(robust)
>  

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0159
                                                Largest FMI       =     0.0956
DF adjustment:   Large sample                   DF:     min       =   4,303.38
                                                        avg       = 3616383.10
                                                        max       = 7114158.44
Model F test:       Equal FMI                   F(   7,877574.8)  =       5.24
Within VCE type:       Robust                   Prob > F          =     0.0000

----------------------------------------------------------------------------------
      exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
-----------------+----------------------------------------------------------------
          social |   2.495764   .7189571     3.17   0.001     1.419048    4.389451
            male |   2.146708   .7985975     2.05   0.040     1.035422    4.450706
       ethnicmin |   6.789744   3.048997     4.27   0.000     2.815875    16.37168
    intervention |   .6963613   .2323037    -1.08   0.278     .3621402    1.339037
      foreignrec |   .8389879   .2815076    -0.52   0.601     .4346603    1.619427
        ageatbar |   1.029201   .0128807     2.30   0.022     1.004255    1.054766
ethnicmin_social |    .178746   .1263837    -2.44   0.015     .0447083    .7146361
           _cons |   .1696544   .1035342    -2.91   0.004      .051293    .5611407
----------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

. mimrgns, dydx(*) predict(pr)

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        311
                                                Average RVI       =     0.0175
                                                Largest FMI       =     0.0940
DF adjustment:   Large sample                   DF:     min       =   4,447.79
                                                        avg       = 3462437.02
Within VCE type: Delta-method                           max       = 7987604.02

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : social male ethnicmin intervention foreignrec ageatbar ethnicmin_social

----------------------------------------------------------------------------------
                 |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
-----------------+----------------------------------------------------------------
          social |   .1849328   .0548162     3.37   0.001     .0774948    .2923709
            male |   .1544448    .073654     2.10   0.036     .0100855    .2988041
       ethnicmin |   .3872583   .0837136     4.63   0.000     .2231826    .5513341
    intervention |  -.0731575   .0671148    -1.09   0.276    -.2047001     .058385
      foreignrec |  -.0354932   .0677603    -0.52   0.600     -.168301    .0973145
        ageatbar |   .0058148   .0024377     2.39   0.017     .0010357     .010594
ethnicmin_social |  -.3481365   .1407936    -2.47   0.013     -.624087    -.072186
----------------------------------------------------------------------------------




mi estimate, or level(95): logistic exitbarred recognition  male ethnicmin intervention foreign ageatbar ethnicmin_recognition, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        311
                                                Average RVI       =     0.0183
                                                Largest FMI       =     0.1086
DF adjustment:   Large sample                   DF:     min       =   3,342.04
                                                        avg       = 2752197.68
                                                        max       = 5097272.02
Model F test:       Equal FMI                   F(   7,660754.0)  =       4.55
Within VCE type:       Robust                   Prob > F          =     0.0000

---------------------------------------------------------------------------------------
           exitbarred | Odds ratio   Std. err.      t    P>|t|     [95% conf. interval]
----------------------+----------------------------------------------------------------
          recognition |   2.017493   1.014673     1.40   0.163     .7528538    5.406467
                 male |   1.676215   .6418899     1.35   0.177     .7913532    3.550496
            ethnicmin |   1.226049   .6563397     0.38   0.703     .4293731    3.500912
         intervention |    .643735    .202242    -1.40   0.161     .3477646    1.191595
           foreignrec |   .9416789   .2949298    -0.19   0.848     .5096946    1.739785
             ageatbar |   1.030463   .0125272     2.47   0.014     1.006192     1.05532
ethnicmin_recognition |   2.722493    2.40116     1.14   0.256     .4833163    15.33565
                _cons |   .2994605   .1773186    -2.04   0.042     .0938077     .955962
---------------------------------------------------------------------------------------
Note: _cons estimates baseline odds.

. 
. mimrgns, dydx(*) predict(pr)

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        311
                                                Average RVI       =     0.0205
                                                Largest FMI       =     0.1081
DF adjustment:   Large sample                   DF:     min       =   3,369.33
                                                        avg       = 3175992.34
Within VCE type: Delta-method                           max       = 5665724.80

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : recognition male ethnicmin intervention foreignrec ageatbar ethnicmin_recognition

---------------------------------------------------------------------------------------
                      |      dy/dx   Std. err.      t    P>|t|     [95% conf. interval]
----------------------+----------------------------------------------------------------
          recognition |   .1444116   .1016547     1.42   0.155     -.054828    .3436513
                 male |   .1062615   .0783232     1.36   0.175    -.0472491    .2597721
            ethnicmin |   .0418985   .1099179     0.38   0.703    -.1735368    .2573338
         intervention |  -.0906154   .0640551    -1.41   0.157    -.2161612    .0349304
           foreignrec |  -.0123609   .0644051    -0.19   0.848    -.1385926    .1138708
             ageatbar |   .0061685   .0023701     2.60   0.009     .0015216    .0108154
ethnicmin_recognition |   .2060798   .1819265     1.13   0.257    -.1504897    .5626493
-------------------




*ethnic minority dissidents only have substantially lower probability of emigrating if they advocated for recognition than if they did not, and dissidents who advocate for recongition of culturla minorities have a significantly lower probability of emigrating if they are ethnic minorities than if they are not.



*linear probability regressions



mi estimate, level(95): regress exitbarred democracy, vce(robust)  


Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
                                                Complete DF       =        309
DF adjustment:   Small sample                   DF:     min       =     307.02
                                                        avg       =     307.02
                                                        max       =     307.02
Model F test:       Equal FMI                   F(   1,  307.0)   =      27.27
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |  -.2765463   .0529563    -5.22   0.000    -.3807494   -.1723431
       _cons |    .769697   .0328828    23.41   0.000     .7049928    .8344011
------------------------------------------------------------------------------



. 


mi estimate, level(95): regress exitbarred democracy male ethnicmin intervention foreign ageatbar, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0222
                                                Largest FMI       =     0.1095
                                                Complete DF       =        304
DF adjustment:   Small sample                   DF:     min       =     249.17
                                                        avg       =     285.44
                                                        max       =     301.03
Model F test:       Equal FMI                   F(   6,  301.7)   =      10.52
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |  -.2306192   .0610567    -3.78   0.000    -.3507755   -.1104629
        male |   .1985281   .0762973     2.60   0.010     .0483844    .3486717
   ethnicmin |   .0427154   .0628405     0.68   0.497    -.0809505    .1663814
intervention |  -.0460949   .0679737    -0.68   0.498    -.1798586    .0876689
  foreignrec |  -.0204641   .0698391    -0.29   0.770    -.1579001     .116972
    ageatbar |   -.006319   .0021702    -2.91   0.004    -.0105932   -.0020448
       _cons |  -11.82479   4.266694    -2.77   0.006    -20.22817   -3.421401
------------------------------------------------------------------------------

mi estimate, level(95): regress exitbarred democracy male ethnicmin intervention foreign ageatbar, vce(robust)  


coefplot, drop( _cons) coeflabels(social="democracy advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95)xline(0) xtitle(Figure A1: LPM coefficients for China barring exit) 

mi estimate, level(95): regress exitbarred democracy male ethnicmin intervention foreign ageatbar, vce(robust)  

coefplot, drop( _cons) coeflabels(social="social reform advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95)xline(0) xtitle(Figure A2: LPM coefficients for China barring exit) 

mi estimate, level(95): regress recognition democracy male ethnicmin intervention foreign ageatbar, vce(robust)  

coefplot, drop( _cons) coeflabels(social="recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar/exit") levels(95)xline(0) xtitle(Figure A3: LPM coefficients for China barring exit) 



mi estimate, level(95): regress exitbarred social, vce(robust)  


Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
                                                Complete DF       =        309
DF adjustment:   Small sample                   DF:     min       =     307.02
                                                        avg       =     307.02
                                                        max       =     307.02
Model F test:       Equal FMI                   F(   1,  307.0)   =       2.83
Within VCE type:       Robust                   Prob > F          =     0.0937

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   .0913378   .0543269     1.68   0.094    -.0155624     .198238
       _cons |   .5949367   .0391804    15.18   0.000     .5178406    .6720329
-----------------------





mi estimate, level(95): regress exitbarred social male ethnicmin intervention foreign ageatbar, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0263
                                                Largest FMI       =     0.1266
                                                Complete DF       =        304
DF adjustment:   Small sample                   DF:     min       =     238.90
                                                        avg       =     281.76
                                                        max       =     301.04
Model F test:       Equal FMI                   F(   6,  301.6)   =       7.71
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |   .1409622   .0565337     2.49   0.013     .0297078    .2522166
        male |   .2033853   .0808083     2.52   0.012     .0443646    .3624061
   ethnicmin |   .1804274    .063351     2.85   0.005     .0557471    .3051076
intervention |  -.0745279   .0653177    -1.14   0.255    -.2030653    .0540094
  foreignrec |   .0003991   .0708687     0.01   0.996     -.139063    .1398612
    ageatbar |   -.007019   .0021796    -3.22   0.001    -.0113127   -.0027254
       _cons |  -13.41122    4.27219    -3.14   0.002     -21.8272   -4.995249
------------------------------------------------------------------------------








 mi estimate, level(95): regress exitbarred recognition, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
                                                Complete DF       =        309
DF adjustment:   Small sample                   DF:     min       =     307.02
                                                        avg       =     307.02
                                                        max       =     307.02
Model F test:       Equal FMI                   F(   1,  307.0)   =      26.59
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   .2715063   .0526515     5.16   0.000     .1679029    .3751097
       _cons |   .5726496   .0324436    17.65   0.000     .5088095    .6364896
------------------------------------------------------------------------------









mi estimate, level(95): regress exitbarred recognition male ethnicmin intervention foreign ageatbar, vce(robust) 


Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0302
                                                Largest FMI       =     0.1387
                                                Complete DF       =        304
DF adjustment:   Small sample                   DF:     min       =     231.60
                                                        avg       =     280.25
                                                        max       =     300.87
Model F test:       Equal FMI                   F(   6,  301.5)   =       9.59
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   .1893439   .0721132     2.63   0.009      .047431    .3312567
        male |   .1443179   .0800246     1.80   0.072    -.0131617    .3017974
   ethnicmin |    .031709   .0747868     0.42   0.672    -.1154695    .1788875
intervention |  -.0750224   .0672228    -1.12   0.265    -.2073087    .0572639
  foreignrec |   .0185982   .0703049     0.26   0.792    -.1197542    .1569506
    ageatbar |  -.0072829    .002133    -3.41   0.001    -.0114855   -.0030803
       _cons |  -13.82515   4.190184    -3.30   0.001     -22.0809   -5.569404
------------------------------------------------------------------------------

. 




mi estimate, level(95): regress exitbarred democracy male ethnicmin intervention foreign ageatbar jiang1 hu1 xi1, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0145
                                                Largest FMI       =     0.1164
                                                Complete DF       =        301
DF adjustment:   Small sample                   DF:     min       =     242.83
                                                        avg       =     286.86
                                                        max       =     298.88
Model F test:       Equal FMI                   F(   9,  298.9)   =      13.95
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
   democracy |  -.0478169   .0627083    -0.76   0.446    -.1712226    .0755888
        male |   .1659353   .0753316     2.20   0.028     .0176878    .3141828
   ethnicmin |   .0148688   .0594397     0.25   0.803    -.1021064     .131844
intervention |  -.0437793   .0651836    -0.67   0.502    -.1720565     .084498
  foreignrec |  -.0540705   .0630024    -0.86   0.391    -.1780566    .0699157
    ageatbar |  -.0020495   .0021582    -0.95   0.343    -.0063008    .0022017
      jiang1 |   .2084044   .0844875     2.47   0.014     .0421384    .3746703
         hu1 |   .5327633    .083103     6.41   0.000     .3692175    .6963092
         xi1 |   .4833758    .080621     6.00   0.000     .3247107    .6420409
       _cons |  -3.822226   4.215871    -0.91   0.366    -12.12657    4.482116
------------------------------------------------------------------------------

mi estimate, level(95): regress exitbarred social male ethnicmin intervention foreign ageatbar jiang1 hu1 xi1, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0148
                                                Largest FMI       =     0.1205
                                                Complete DF       =        301
DF adjustment:   Small sample                   DF:     min       =     240.43
                                                        avg       =     286.21
                                                        max       =     298.87
Model F test:       Equal FMI                   F(   9,  298.9)   =      14.38
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |  -.0265398   .0586855    -0.45   0.651     -.142029    .0889495
        male |   .1518432   .0768292     1.98   0.049     .0006486    .3030379
   ethnicmin |   .0202706   .0640646     0.32   0.752    -.1058061    .1463472
intervention |  -.0485969   .0645201    -0.75   0.452    -.1755684    .0783746
  foreignrec |  -.0451482   .0630407    -0.72   0.474    -.1692096    .0789132
    ageatbar |  -.0020491    .002162    -0.95   0.344    -.0063079    .0022097
      jiang1 |   .2195715   .0846197     2.59   0.010     .0530453    .3860978
         hu1 |   .5683962   .0801618     7.09   0.000     .4106368    .7261556
         xi1 |   .5207805   .0810661     6.42   0.000     .3612377    .6803233
       _cons |  -3.844271   4.227977    -0.91   0.364    -12.17288    4.484336
--------------------------------


mi estimate, level(95): regress exitbarred recognition male ethnicmin intervention foreign ageatbar jiang1 hu1 xi1, vce(robust)  

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0148
                                                Largest FMI       =     0.1205
                                                Complete DF       =        301
DF adjustment:   Small sample                   DF:     min       =     240.43
                                                        avg       =     286.21
                                                        max       =     298.87
Model F test:       Equal FMI                   F(   9,  298.9)   =      14.38
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social |  -.0265398   .0586855    -0.45   0.651     -.142029    .0889495
        male |   .1518432   .0768292     1.98   0.049     .0006486    .3030379
   ethnicmin |   .0202706   .0640646     0.32   0.752    -.1058061    .1463472
intervention |  -.0485969   .0645201    -0.75   0.452    -.1755684    .0783746
  foreignrec |  -.0451482   .0630407    -0.72   0.474    -.1692096    .0789132
    ageatbar |  -.0020491    .002162    -0.95   0.344    -.0063079    .0022097
      jiang1 |   .2195715   .0846197     2.59   0.010     .0530453    .3860978
         hu1 |   .5683962   .0801618     7.09   0.000     .4106368    .7261556
         xi1 |   .5207805   .0810661     6.42   0.000     .3612377    .6803233
       _cons |  -3.844271   4.227977    -0.91   0.364    -12.17288    4.484336
--------------------------------



mi estimate,  level(95): regress exitbarred recognition male ethnicmin intervention foreign  ageatbar jiang1 hu1 xi1, vce(robust)


Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        311
                                                Average RVI       =     0.0146
                                                Largest FMI       =     0.1191
                                                Complete DF       =        301
DF adjustment:   Small sample                   DF:     min       =     241.23
                                                        avg       =     286.35
                                                        max       =     298.86
Model F test:       Equal FMI                   F(   9,  298.9)   =      15.22
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Coefficient  Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
 recognition |   .0801425   .0698818     1.15   0.252    -.0573805    .2176654
        male |   .1509142   .0747491     2.02   0.044     .0038129    .2980154
   ethnicmin |  -.0137556   .0719713    -0.19   0.849    -.1553918    .1278807
intervention |  -.0492228   .0642259    -0.77   0.444    -.1756154    .0771698
  foreignrec |  -.0484195   .0626762    -0.77   0.440    -.1717635    .0749245
    ageatbar |  -.0020383   .0021555    -0.95   0.345    -.0062843    .0022077
      jiang1 |   .2038242   .0852465     2.39   0.017     .0360647    .3715838
         hu1 |   .5403198   .0780453     6.92   0.000      .386726    .6939136
         xi1 |   .4909237   .0747979     6.56   0.000     .3437161    .6381312
       _cons |  -3.826437   4.215393    -0.91   0.365    -12.13012    4.477242
---------------------------












*survival analysis 
*I am analyzing survival-time or time-span data


/*
In survival-time
data, the observations represent periods and typically contain three variables that record the start
time of the period, the end time, and an indicator of whether failure or right-censoring occurred at
the end of the period. The representation of the response of these three variables makes survival
data unique in terms of implementing the statistical methods in the software. Such representation is
specific to right-censored survival-time data. Interval-censored survival-time data are represented by
two time variables that record the endpoints of time intervals in which failures are known to have
occurred. Throughout the manual, when we refer to survival-time data, we will assume right-censored
survival-time data.

ctset is used to tell Stata the names of the variables in your count data that record the time, the
number failed, and the number censored. You ctset your data before typing cttost to convert it
to survival-time data. Because you ctset your data, you can type cttost without any arguments to
perform the conversion. Stata remembers how the data are ctset.


Snapshot data are data in which each observation records the status of a given subject at a certain
point in time. Usually you have multiple observations on each subject that chart the subject's progress
through the study

Before using Stata's survival analysis commands with snapshot data, you must first convert the data
to survival-time data; that is, the observations in the data should represent intervals

Before converting snapshot data to
time-span data, you must understand the distinction between enduring variables and instantaneous
variables. Enduring variables record characteristics of the subject that endure throughout the time
span, such as sex or smoking status. Instantaneous variables describe events that occur at the end of a
time span, such as failure or censoring. When you convert snapshots to intervals, enduring variables
obtain their values from the previous recorded snapshot or are set to missing for the first interval.
Instantaneous variables obtain their values from the current recorded snapshot because the existing
time variable now records the end of the span.

Stata's snapspan makes this whole process easy. You specify an ID variable identifying your
subjects, the snapshot time variable, the name of the new variable to hold the beginning times of the
spans, and any variables that you want to treat as instantaneous variables. Stata does the rest for you.

Stata does not automatically recognize survival-time data, so you must declare your survival-time
data to Stata by using stset. Every st command, except stintreg and stintcox, relies on the
information that is provided when you stset your data.

Once you stset the data, you can use stdescribe to describe the aspects of your survival data.
For example, you will see the number of subjects you were successful in declaring, the total number
of records associated with these subjects, the total time at risk for these subjects, time gaps for any
of these subjects, any delayed entry, etc. You can use stsum to summarize your survival data, for
example, to obtain the total time at risk and the quartiles of time-to-failure in analysis-time units.

stir is used to estimate incidence rates and to compare incidence rates across groups. stci is
the survival-time data analog of ci means and is used to obtain confidence intervals for means and
percentiles of time to failure. strate is used to tabulate failure rates. stptime is used to calculate
person-time and standardized mortality/morbidity ratios (SMRs). stmh calculates rate ratios by using
the Mantel–Haenszel method, and stmc calculates rate ratios by using the Mantel–Cox method.
ltable displays and graphs life tables for individual-level or aggregate data.

stcox fits the Cox proportional hazards model and predict after stcox can be used to retrieve
estimates of the baseline survivor function, the baseline cumulative hazard function, and the baseline
hazard contributions. predict after stcox can also calculate a myriad of Cox regression diagnostic
quantities, such as martingale residuals, efficient score residuals, and Schoenfeld residuals. stcox
has four options for handling tied failures. stcox can be used to fit stratified Cox models, where
the baseline hazard is allowed to differ over the strata, and it can be used to model multivariate
survival data by using a shared-frailty model, which can be thought of as a Cox model with random
effects. After stcox, you can use estat phtest to test the proportional-hazards assumption or
estat concordance to compute the concordance probability. With stphplot and stcoxkm, you
can graphically assess the proportional-hazards assumption.

Stata offers six parametric regression models for survival data: exponential, Weibull, lognormal,
loglogistic, Gompertz, and generalized gamma. All six models are fit using streg for right-censored
data and stintreg for interval-censored data, and you can specify the model you want with the
distribution() option. All of these models, except for the exponential, have ancillary parameters
that are estimated (along with the linear predictor) from the data. By default, these ancillary parameters
are treated as constant, but you may optionally model the ancillary parameters as functions of a
linear predictor. Stratified models may also be fit using streg and stintreg. Y

xtstreg fits random-intercept parametric survival models to clustered survival data. Random
intercepts are assumed to be normally distributed. A random-intercept model with Gaussian intercepts
can be viewed as a shared-frailty model with lognormal frailty. xtstreg supports five distributions:
exponential, loglogistic, Weibull, lognormal, and gamma, which you can specify using the distribution() option. Several predictions, such as mean, median, or survivor or hazard functions, can
be obtained by using predict after fitting a model with xtstreg.
mestreg fits multilevel mixed-effects parametric survival models. It supports five distributions:
exponential, loglogistic, Weibull, lognormal, and gamma, which you can specify using the distribution() option. mestreg allows for multiple levels of random effects and for random coefficients.
Marginal or conditional predictions for several statistics and functions of interest, such as mean,
median, or survival or hazard functions, can be obtained by using predict after fitting a model with
mestreg.

*/


*/


*/




*rerun analysis with dummies for each type of advocacy, advocating two causes, and advocating all three causes












*model 1 democracy
/*
mi estimate, or level(95): logistic exitbarred democracy, vce(robust) 

mimrgns, dydx(*) predict(pr)

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
Within VCE type: Delta-method                           max       =          .

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : democracy

------------------------------------------------------------------------------
             |      dy/dx   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
   democracy |  -.3404711   .0539547    -6.31   0.000    -.4462203   -.2347218
------------------------------------------------------------------------------


*/
   
*model 2 democracy

*linear probability model
mi estimate, level(95): regress exitbarred democracy firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 

coefplot, drop(firstchargedateafter1988 _cons) coeflabels(social="social reform advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(0) eform xtitle(Figure a1: Linear probability model for China barring exit) 


*odds ratio model
mi estimate, or level(95): logistic exitbarred democracy firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0101
                                                Largest FMI       =     0.0676
DF adjustment:   Large sample                   DF:     min       =   8,599.32
                                                        avg       =   7.17e+07
                                                        max       =   2.17e+08
Model F test:       Equal FMI                   F(   7, 2.2e+06)  =       3.83
Within VCE type:       Robust                   Prob > F          =     0.0004

----------------------------------------------------------------------------------
      exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [95% Conf. Interval]
-----------------+----------------------------------------------------------------
       democracy |   .2218496   .0851112    -3.92   0.000     .1045925    .4705619
firstchargedateafter1988 |   9.776237   10.71222     2.08   0.037     1.141499    83.72743
    intervention |   1.124148   .5150973     0.26   0.798     .4579236    2.759648
      foreignrec |   .7541802   .3067851    -0.69   0.488     .3398003    1.673889
       ethnicmin |   4.439168   2.906305     2.28   0.023     1.230335    16.01695
            male |   .2772501   .1585264    -2.24   0.025     .0904005     .850301
        ageatbar |   1.009488   .0154103     0.62   0.536     .9797277    1.040153
           _cons |   .3544397   .4656459    -0.79   0.430     .0269943    4.653849
----------------------------
coefplot, drop(firstchargedateafter1988 _cons) coeflabels(democracy="democracy advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(1) eform xtitle(Figure a2: Odds ratio for China barring exit) 

*predicted probability results
mi estimate, level(95): logistic exitbarred democracy firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 


mimrgns, dydx(*) predict(pr) post
/*
Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        152
                                                Average RVI       =     0.0113
                                                Largest FMI       =     0.0684
DF adjustment:   Large sample                   DF:     min       =   8,393.14
                                                        avg       =   8.05e+07
Within VCE type: Delta-method                           max       =   2.35e+08

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : democracy firstchargedateafter1988 intervention foreignrec ethnicmin male ageatbar

----------------------------------------------------------------------------------
                 |      dy/dx   Std. Err.      t    P>|t|     [95% Conf. Interval]
-----------------+----------------------------------------------------------------
       democracy |  -.2875098    .058146    -4.94   0.000    -.4014739   -.1735457
firstchargedateafter1988 |   .4353476   .2041519     2.13   0.033     .0352171    .8354781
    intervention |   .0223443   .0872567     0.26   0.798    -.1486758    .1933644
      foreignrec |  -.0538673   .0775423    -0.69   0.487    -.2058473    .0981128
       ethnicmin |   .2845794   .1162498     2.45   0.014     .0567339    .5124249
            male |  -.2449374   .1010761    -2.42   0.015     -.443043   -.0468318
        ageatbar |   .0018015   .0028827     0.62   0.532    -.0038494    .0074524
----------------------------------------------------------------------------------
*/


coefplot, drop(firstchargedateafter1988 _cons) coeflabels(democracy="advocated democratization" intervention="foreign intervention" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(90) xline(0) xtitle(Figure 2: Probabilities for China barring exit) 


*model 1 social
mi estimate, level(95): regress exitbarred social, vce(robust) 


mi estimate, or level(95): logistic exitbarred social, vce(robust) 

mimrgns, dydx(*) predict(pr)


*model 2 social
/*
mi estimate, level(95): regress exitbarred social firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 
coefplot, drop(firstchargedateafter1988 _cons) coeflabels(social="social reform advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(0) xtitle(Figure a4: Linear probability model for China barring exit) 

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        152
                                                Average RVI       =     0.0137
                                                Largest FMI       =     0.0913
                                                Complete DF       =        144
DF adjustment:   Small sample                   DF:     min       =     125.97
                                                        avg       =     139.30
                                                        max       =     141.95
Model F test:       Equal FMI                   F(   7,  142.0)   =       7.63
Within VCE type:       Robust                   Prob > F          =     0.0000

----------------------------------------------------------------------------------
      exitbarred |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-----------------+----------------------------------------------------------------
          social |    .188892   .0800052     2.36   0.020     .0307356    .3470483
firstchargedateafter1988 |   .3130864   .1082494     2.89   0.004     .0990857     .527087
    intervention |  -.0294608   .0963078    -0.31   0.760    -.2198441    .1609225
      foreignrec |  -.0165502   .0866215    -0.19   0.849     -.187785    .1546846
       ethnicmin |   .3046219   .1059737     2.87   0.005     .0951263    .5141176
            male |  -.2505146   .1056908    -2.37   0.019    -.4594467   -.0415825
        ageatbar |   .0024812   .0031604     0.79   0.434     -.003773    .0087355
           _cons |   .1514131   .1655546     0.91   0.362    -.1759358    .4787619
----------------------------------------------------------------------------------

. 

/*
mi estimate, or level(95): logistic exitbarred social firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 

*/
Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0135
                                                Largest FMI       =     0.0884
DF adjustment:   Large sample                   DF:     min       =   5,027.95
                                                        avg       =   3.48e+07
                                                        max       =   9.87e+07
Model F test:       Equal FMI                   F(   7, 1.2e+06)  =       2.73
Within VCE type:       Robust                   Prob > F          =     0.0079

----------------------------------------------------------------------------------
      exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [95% Conf. Interval]
-----------------+----------------------------------------------------------------
          social |   2.471276   .9041017     2.47   0.013     1.206463    5.062072
firstchargedateafter1988 |   8.138506   8.923847     1.91   0.056     .9488659    69.80469
    intervention |   .9194832   .4064101    -0.19   0.849     .3866465    2.186621
      foreignrec |   .8970566   .3591937    -0.27   0.786     .4092485    1.966313
       ethnicmin |   5.028686   3.181932     2.55   0.011     1.454961    17.38031
            male |   .2846489   .1619815    -2.21   0.027     .0933098    .8683441
        ageatbar |   1.011545   .0150664     0.77   0.441     .9824353    1.041517
           _cons |   .1126817   .1489883    -1.65   0.099     .0084409    1.504247
----------------------------------------------------------------------------------


*/
coefplot, drop(firstchargedateafter1988 _cons) coeflabels(social="advocated social reform" intervention="foreign intervention" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(1) eform xtitle(Figure a5: Odds ratio for China barring exit) 

mi estimate, level(95): logistic exitbarred social firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 


mimrgns, dydx(*) predict(pr) post

/*
Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        152
                                                Average RVI       =     0.0154
                                                Largest FMI       =     0.0905
DF adjustment:   Large sample                   DF:     min       =   4,806.02
                                                        avg       =   3.71e+07
Within VCE type: Delta-method                           max       =   1.02e+08

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : social firstchargedateafter1988 intervention foreignrec ethnicmin male ageatbar

----------------------------------------------------------------------------------
                 |      dy/dx   Std. Err.      t    P>|t|     [95% Conf. Interval]
-----------------+----------------------------------------------------------------
          social |   .1862236   .0693758     2.68   0.007     .0502496    .3221977
firstchargedateafter1988 |   .4315674   .2218972     1.94   0.052    -.0033432     .866478
    intervention |  -.0172785   .0909401    -0.19   0.849    -.1955178    .1609608
      foreignrec |   -.022359   .0823716    -0.27   0.786    -.1838043    .1390864
       ethnicmin |   .3324313   .1182827     2.81   0.005     .1006015    .5642612
            male |  -.2586144   .1078469    -2.40   0.016    -.4699904   -.0472383
        ageatbar |     .00236   .0030097     0.78   0.433    -.0035404    .0082603
----------------------------------------------------------------------------------

. 

*/

coefplot, drop(firstchargedateafter1988 _cons) coeflabels(social="advocated social reform" intervention="foreign intervention" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(0) xtitle(Figure 3: Probabilities for China barring exit) 


*model 1 recognition

mi estimate, level(95): regress exitbarred recognition, vce(robust) 

/*
Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
                                                Complete DF       =        150
DF adjustment:   Small sample                   DF:     min       =     148.04
                                                        avg       =     148.04
                                                        max       =     148.04
Model F test:       Equal FMI                   F(   1,  148.0)   =      13.18
Within VCE type:       Robust                   Prob > F          =     0.0004

------------------------------------------------------------------------------
  exitbarred |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
 recognition |   .3505512   .0965536     3.63   0.000     .1597498    .5413526
       _cons |   .4094488   .0439241     9.32   0.000     .3226496     .496248
------------------------------------------------------------------------------

*/

mi estimate, or level(95): logistic exitbarred recognition, vce(robust) 

mimrgns, dydx(*) predict(pr) post
/*Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
Within VCE type: Delta-method                           max       =          .

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : recognition

------------------------------------------------------------------------------
             |      dy/dx   Std. Err.      t    P>|t|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
 recognition |   .3524369   .1029662     3.42   0.001     .1506269    .5542469
------------------------------------------------------------------------------

. 
*/

*model 2 recognition

mi estimate, level(95): regress exitbarred recognition firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 
coefplot, drop(firstchargedateafter1988 _cons) coeflabels(social="recognition advocacy" intervention="foreign intervention" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(0) xtitle(Figure a6: Linear probability coefficients for China barring exit) 

/*Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        152
                                                Average RVI       =     0.0133
                                                Largest FMI       =     0.0894
                                                Complete DF       =        144
DF adjustment:   Small sample                   DF:     min       =     126.36
                                                        avg       =     139.37
                                                        max       =     141.94
Model F test:       Equal FMI                   F(   7,  142.0)   =       6.07
Within VCE type:       Robust                   Prob > F          =     0.0000

----------------------------------------------------------------------------------
      exitbarred |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-----------------+----------------------------------------------------------------
     recognition |   .2923775   .1008854     2.90   0.004     .0929448    .4918102
firstchargedateafter1988 |   .3180656   .1180105     2.70   0.008     .0847696    .5513615
    intervention |  -.0161715   .0976524    -0.17   0.869    -.2092127    .1768698
      foreignrec |  -.0389184   .0879594    -0.44   0.659     -.212798    .1349613
       ethnicmin |    .241577   .1105007     2.19   0.030     .0231323    .4600216
            male |  -.2983164   .1096009    -2.72   0.007    -.5149774   -.0816553
        ageatbar |   .0024902   .0032606     0.76   0.446    -.0039622    .0089426
           _cons |   .2565984    .177689     1.44   0.151     -.094744    .6079408
----------------------------------------------------------------------------------


*/

mi estimate, or level(95): logistic exitbarred recognition firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 

/*Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0136
                                                Largest FMI       =     0.0888
DF adjustment:   Large sample                   DF:     min       =   4,991.56
                                                        avg       =   3.25e+07
                                                        max       =   7.51e+07
Model F test:       Equal FMI                   F(   7, 1.2e+06)  =       2.46
Within VCE type:       Robust                   Prob > F          =     0.0162

----------------------------------------------------------------------------------
      exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [95% Conf. Interval]
-----------------+----------------------------------------------------------------
     recognition |   4.111831    2.18836     2.66   0.008     1.448828    11.66954
firstchargedateafter1988 |   8.429005     11.225     1.60   0.109     .6197578    114.6385
    intervention |   .9699939   .4414832    -0.07   0.947     .3975145    2.366928
      foreignrec |   .8523831   .3636577    -0.37   0.708     .3693867    1.966928
       ethnicmin |   3.616635   2.312915     2.01   0.044     1.032626    12.66679
            male |   .2419176   .1437476    -2.39   0.017     .0754889    .7752681
        ageatbar |   1.012873   .0153453     0.84   0.399     .9832318    1.043408
           _cons |   .1661649    .258635    -1.15   0.249      .007864    3.511016
----------------------------------------------------------------------------------

. 

*/
coefplot, drop(firstchargedateafter1988 _cons) coeflabels(social="social reform advocacy" intervention="foreign intervention" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(1) eform xtitle(Figure a7: Odds ratio for China barring exit) 

mi estimate, level(95): logistic exitbarred recognition firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 

mimrgns, dydx(*) predict(pr) post

/*
Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        152
                                                Average RVI       =     0.0154
                                                Largest FMI       =     0.0905
DF adjustment:   Large sample                   DF:     min       =   4,803.25
                                                        avg       =   3.46e+07
Within VCE type: Delta-method                           max       =   7.40e+07

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : recognition firstchargedateafter1988 intervention foreignrec ethnicmin male ageatbar

----------------------------------------------------------------------------------
                 |      dy/dx   Std. Err.      t    P>|t|     [95% Conf. Interval]
-----------------+----------------------------------------------------------------
     recognition |   .2880351   .0963928     2.99   0.003     .0991086    .4769616
firstchargedateafter1988 |   .4343022   .2657518     1.63   0.102    -.0865617    .9551662
    intervention |  -.0062087    .092777    -0.07   0.947    -.1880483    .1756308
      foreignrec |   -.032539   .0868417    -0.37   0.708    -.2027456    .1376675
       ethnicmin |   .2618736   .1216027     2.15   0.031     .0235367    .5002105
            male |   -.289105   .1088129    -2.66   0.008    -.5023745   -.0758356
        ageatbar |   .0026025   .0030244     0.86   0.390    -.0033267    .0085318
----------------------------------------------------------------------------------


*/

coefplot, drop(firstchargedateafter1988 _cons) coeflabels(recognition="advocated recognition" intervention="foreign intervention" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(90) xline(0) xtitle(Figure 4: Probabilities for China barring exit) 


*democracy and social advocacy
*model 1

mi estimate, level(90): regress exitbarred democracysocial, vce(robust) 


/*Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
                                                Complete DF       =        150
DF adjustment:   Small sample                   DF:     min       =     148.04
                                                        avg       =     148.04
                                                        max       =     148.04
Model F test:       Equal FMI                   F(   1,  148.0)   =       8.48
Within VCE type:       Robust                   Prob > F          =     0.0041

---------------------------------------------------------------------------------
     exitbarred |      Coef.   Std. Err.      t    P>|t|     [90% Conf. Interval]
----------------+----------------------------------------------------------------
democracysocial |     -.3125   .1072902    -2.91   0.004     -.490088    -.134912
          _cons |         .5   .0431595    11.58   0.000     .4285618    .5714382
---------------------------------------------------------------------------------

*/





mi estimate, or level(90): logistic exitbarred democracysocial, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       4.86
Within VCE type:       Robust                   Prob > F          =     0.0275

---------------------------------------------------------------------------------
     exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
----------------+----------------------------------------------------------------
democracysocial |   .2307694   .1535231    -2.20   0.028     .0772582    .6893058
          _cons |          1   .1720655     0.00   1.000     .7535028    1.327135
---------------------------------------------------------------------------------




mimrgns, dydx(*) predict(pr) post

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
Within VCE type: Delta-method                           max       =          .

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : democracysocial

---------------------------------------------------------------------------------
                |      dy/dx   Std. Err.      t    P>|t|     [95% Conf. Interval]
----------------+----------------------------------------------------------------
democracysocial |  -.3515107   .1503747    -2.34   0.019    -.6462397   -.0567817
---------------------------------------------------------------------------------



*model 2



mi estimate, level(95): regress exitbarred democracysocial firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        152
                                                Average RVI       =     0.0160
                                                Largest FMI       =     0.1033
                                                Complete DF       =        144
DF adjustment:   Small sample                   DF:     min       =     123.51
                                                        avg       =     138.86
                                                        max       =     141.87
Model F test:       Equal FMI                   F(   7,  141.9)   =       7.11
Within VCE type:       Robust                   Prob > F          =     0.0000

----------------------------------------------------------------------------------
      exitbarred |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
-----------------+----------------------------------------------------------------
 democracysocial |  -.2877297   .1052025    -2.74   0.007    -.4956975   -.0797619
firstchargedateafter1988 |   .3650824    .110113     3.32   0.001     .1473954    .5827695
    intervention |  -.0201376    .095569    -0.21   0.833    -.2090611    .1687858
      foreignrec |   -.019099   .0861545    -0.22   0.825    -.1894115    .1512135
       ethnicmin |    .321839    .109503     2.94   0.004      .105366    .5383119
            male |  -.2627031   .1068634    -2.46   0.015    -.4739536   -.0514527
        ageatbar |   .0029657    .003193     0.93   0.355    -.0033543    .0092857
           _cons |   .2280983    .173064     1.32   0.190    -.1141128    .5703094
----------------------------------------------------------------------------------

. 

*/

coefplot, drop(firstchargedateafter1988 _cons) coeflabels(social="recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(0) eform xtitle(Figure a8: Linear probability model for China barring exit) 


mi estimate, or level(95): logistic exitbarred recognition firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 



mi estimate, level(95): logistic exitbarred democracysocial firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 

mimrgns, dydx(*) predict(pr) post


Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        152
                                                Average RVI       =     0.0182
                                                Largest FMI       =     0.1067
DF adjustment:   Large sample                   DF:     min       =   3,458.90
                                                        avg       =   2.35e+07
Within VCE type: Delta-method                           max       =   4.66e+07

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : democracysocial firstchargedateafter1988 intervention foreignrec ethnicmin male ageatbar

----------------------------------------------------------------------------------
                 |      dy/dx   Std. Err.      t    P>|t|     [95% Conf. Interval]
-----------------+----------------------------------------------------------------
 democracysocial |  -.3055781   .1334614    -2.29   0.022    -.5671577   -.0439984
firstchargedateafter1988 |   .4427822   .2176664     2.03   0.042     .0161639    .8694006
    intervention |  -.0127237   .0926641    -0.14   0.891     -.194342    .1688947
      foreignrec |  -.0205083   .0831909    -0.25   0.805    -.1835595    .1425429
       ethnicmin |   .3406561   .1251366     2.72   0.006     .0953928    .5859194
            male |  -.2605517   .1087692    -2.40   0.017    -.4737355   -.0473678
        ageatbar |    .002845   .0030056     0.95   0.344    -.0030479     .008738
-------------------------------


coefplot, drop(firstchargedateafter1988 _cons) coeflabels(democracysocial="advocated democracy + social reform" intervention="foreign intervention" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(90) xline(0) xtitle(Figure 5: Probabilities for China barring exit) 



*model 1 socialrecognition

mi estimate, level(95): regerss exitbarred socialrecognition, vce(robust) 


Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       5.71
Within VCE type:       Robust                   Prob > F          =     0.0169

-----------------------------------------------------------------------------------
       exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [95% Conf. Interval]
------------------+----------------------------------------------------------------
socialrecognition |   3.733332   2.058861     2.39   0.017     1.266704    11.00317
            _cons |        .75   .1318488    -1.64   0.102     .5313998    1.058525
-----------------------------------------------------------------------------------




mi estimate, or level(95): logistic exitbarred socialrecognition, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       5.71
Within VCE type:       Robust                   Prob > F          =     0.0169

-----------------------------------------------------------------------------------
       exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [95% Conf. Interval]
------------------+----------------------------------------------------------------
socialrecognition |   3.733332   2.058861     2.39   0.017     1.266704    11.00317
            _cons |        .75   .1318488    -1.64   0.102     .5313998    1.058525
-----------------------------------------------------------------------------------



mi estimate, level(95): logistic exitbarred socialrecognition, vce(robust) 


mimrgns, dydx(*) predict(pr) post

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
Within VCE type: Delta-method                           max       =          .

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : socialrecognition

-----------------------------------------------------------------------------------
                  |      dy/dx   Std. Err.      t    P>|t|     [95% Conf. Interval]
------------------+----------------------------------------------------------------
socialrecognition |   .3142078   .1218607     2.58   0.010     .0753653    .5530504
-------------


*model 2 socialrecognition

mi estimate, level(95): regress exitbarred socialrecognition firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 


Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        152
                                                Average RVI       =     0.0142
                                                Largest FMI       =     0.0952
                                                Complete DF       =        144
DF adjustment:   Small sample                   DF:     min       =     125.18
                                                        avg       =     139.18
                                                        max       =     141.92
Model F test:       Equal FMI                   F(   7,  142.0)   =       5.25
Within VCE type:       Robust                   Prob > F          =     0.0000

-----------------------------------------------------------------------------------
       exitbarred |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
------------------+----------------------------------------------------------------
socialrecognition |   .2431198   .1124998     2.16   0.032     .0207273    .4655123
 firstchargedateafter1988 |   .3324944   .1188319     2.80   0.006     .0975737    .5674151
     intervention |  -.0327069   .0971159    -0.34   0.737    -.2246878     .159274
       foreignrec |  -.0150563   .0872023    -0.17   0.863    -.1874396    .1573269
        ethnicmin |   .2915138    .110537     2.64   0.009     .0729972    .5100304
             male |  -.2786626   .1091276    -2.55   0.012    -.4943884   -.0629368
         ageatbar |   .0026194   .0032578     0.80   0.423    -.0038281     .009067
            _cons |   .2307829   .1779529     1.30   0.197    -.1210855    .5826513
-----------------------------------------------------------------------------------



coefplot, drop(firstchargedateafter1988 _cons) coeflabels(socialrecognition="social and recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(0) eform xtitle(Figure a8: Linear probabilities for China barring exit) 

mi estimate, or level(95): logistic exitbarred socialrecognition firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0145
                                                Largest FMI       =     0.0945
DF adjustment:   Large sample                   DF:     min       =   4,409.74
                                                        avg       =   2.57e+07
                                                        max       =   5.47e+07
Model F test:       Equal FMI                   F(   7, 1.0e+06)  =       2.08
Within VCE type:       Robust                   Prob > F          =     0.0419

-----------------------------------------------------------------------------------
       exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [95% Conf. Interval]
------------------+----------------------------------------------------------------
socialrecognition |    3.38495    2.01108     2.05   0.040     1.056412    10.84605
 firstchargedateafter1988 |    8.96294   12.07396     1.63   0.104     .6394383    125.6326
     intervention |   .9137502   .4117287    -0.20   0.841      .377818    2.209898
       foreignrec |    .947348   .3875704    -0.13   0.895     .4248873     2.11225
        ethnicmin |   4.465533   2.868225     2.33   0.020     1.268072    15.72543
             male |   .2621981   .1545065    -2.27   0.023     .0826112    .8321861
         ageatbar |   1.013074   .0151865     0.87   0.386     .9837341    1.043289
            _cons |    .150998   .2378565    -1.20   0.230     .0068886    3.309873
-----------------------------------------------------------------------------------


coefplot, drop(firstchargedateafter1988 _cons) coeflabels(socialrecognition="social and recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(1) eform xtitle(Figure a9: Odds ratios for China barring exit) 

mi estimate, level(95): logistic exitbarred socialrecognition firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 


mimrgns, dydx(*) predict(pr) post

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        152
                                                Average RVI       =     0.0165
                                                Largest FMI       =     0.0968
DF adjustment:   Large sample                   DF:     min       =   4,201.99
                                                        avg       =   2.83e+07
Within VCE type: Delta-method                           max       =   6.31e+07

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : socialrecognition firstchargedateafter1988 intervention foreignrec ethnicmin male ageatbar

-----------------------------------------------------------------------------------
                  |      dy/dx   Std. Err.      t    P>|t|     [95% Conf. Interval]
------------------+----------------------------------------------------------------
socialrecognition |   .2536522   .1136907     2.23   0.026     .0308225    .4764819
 firstchargedateafter1988 |   .4562552   .2733932     1.67   0.095    -.0795857     .992096
     intervention |  -.0187672    .093862    -0.20   0.842    -.2027333    .1651989
       foreignrec |  -.0112511    .085131    -0.13   0.895    -.1781048    .1556026
        ethnicmin |   .3112678   .1207812     2.58   0.010      .074541    .5479946
             male |   -.278466   .1115405    -2.50   0.013    -.4970814   -.0598506
         ageatbar |   .0026987   .0030508     0.88   0.376    -.0032825      .00868
-----------------------------------------------------------------------------------

. 


coefplot, drop(firstchargedateafter1988 _cons) coeflabels(socialrecognition="social reform + recognition advocacy" intervention="foreign intervention" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(90) xline(0) xtitle(Figure 6: Probabilities for China barring exit) 



*model 1 democracyrecognition

mi estimate, level(95): regress exitbarred democracyrecognition, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
                                                Complete DF       =        150
DF adjustment:   Small sample                   DF:     min       =     148.04
                                                        avg       =     148.04
                                                        max       =     148.04
Model F test:       Equal FMI                   F(   1,  148.0)   =       0.54
Within VCE type:       Robust                   Prob > F          =     0.4636

--------------------------------------------------------------------------------------
          exitbarred |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
---------------------+----------------------------------------------------------------
democracyrecognition |   .2035794   .2770428     0.73   0.464    -.3438898    .7510486
               _cons |   .4630872   .0411212    11.26   0.000     .3818268    .5443477
--------------------------------------------------------------------------------------



mi estimate, or level(95): logistic exitbarred democracyrecognition, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       0.46
Within VCE type:       Robust                   Prob > F          =     0.4975

--------------------------------------------------------------------------------------
          exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [95% Conf. Interval]
---------------------+----------------------------------------------------------------
democracyrecognition |   2.318841     2.8749     0.68   0.498     .2041507     26.3385
               _cons |      .8625   .1421726    -0.90   0.370     .6243799    1.191432
--------------------------------------------------------------------------------------



mi estimate, level(95): logistic exitbarred democracyrecognition, vce(robust) 


mimrgns, dydx(*) predict(pr) post



*model 2 democracy recognition

mi estimate, level(95): regress exitbarred democracyrecognition firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 
coefplot, drop(firstchargedateafter1988 _cons) coeflabels(democracyrecognition="democracy and recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(0) xtitle(Figure a10: Linear probabilities for China barring exit) 


Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        152
                                                Average RVI       =     0.0154
                                                Largest FMI       =     0.1034
                                                Complete DF       =        144
DF adjustment:   Small sample                   DF:     min       =     123.47
                                                        avg       =     138.84
                                                        max       =     141.97
Model F test:       Equal FMI                   F(   7,  141.9)   =       5.78
Within VCE type:       Robust                   Prob > F          =     0.0000

--------------------------------------------------------------------------------------
          exitbarred |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
---------------------+----------------------------------------------------------------
democracyrecognition |   .0484741   .2010274     0.24   0.810    -.3489198     .445868
    firstchargedateafter1988 |   .3324081   .1076874     3.09   0.002     .1195151    .5453011
        intervention |   -.036603   .0965425    -0.38   0.705    -.2274508    .1542447
          foreignrec |  -.0093386   .0890159    -0.10   0.917    -.1853072    .1666299
           ethnicmin |   .3284204   .1134232     2.90   0.004     .1041973    .5526436
                male |  -.2849335   .1092434    -2.61   0.010    -.5008885   -.0689785
            ageatbar |   .0028815   .0032653     0.88   0.379    -.0035817    .0093448
               _cons |   .2501332   .1746109     1.43   0.154    -.0951418    .5954083
--------------------------------------------------------------------------------------




mi estimate, or level(95): logistic exitbarred democracyrecognition firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 
coefplot, drop(firstchargedateafter1988 _cons) coeflabels(democracyrecognition="democracy and recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(1) eform xtitle(Figure a11: Odds Ratios for China barring exit) 

e-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0155
                                                Largest FMI       =     0.1035
DF adjustment:   Large sample                   DF:     min       =   3,672.98
                                                        avg       =   1.10e+09
                                                        max       =   8.67e+09
Model F test:       Equal FMI                   F(   7,895572.9)  =       2.33
Within VCE type:       Robust                   Prob > F          =     0.0226

--------------------------------------------------------------------------------------
          exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [95% Conf. Interval]
---------------------+----------------------------------------------------------------
democracyrecognition |   1.160648   1.137217     0.15   0.879     .1700914    7.919876
    firstchargedateafter1988 |   7.453463   7.965363     1.88   0.060     .9176908    60.53685
        intervention |   .8726673   .3780573    -0.31   0.753     .3733283    2.039889
          foreignrec |   .9497308   .3820818    -0.13   0.898     .4316757    2.089505
           ethnicmin |   5.098437   3.370821     2.46   0.014     1.395298    18.62976
                male |   .2664654   .1521583    -2.32   0.021      .087013    .8160142
            ageatbar |   1.012629   .0148044     0.86   0.391     .9840158    1.042075
               _cons |   .2088442   .2720629    -1.20   0.229     .0162537    2.683448
--------------------------------------------------------------------------------------



mi estimate, level(95): logistic exitbarred democracyrecognition firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 


mimrgns, dydx(*) predict(pr) post

Multiple-imputation estimates                   Imputations       =         40
Average marginal effects                        Number of obs     =        152
                                                Average RVI       =     0.0177
                                                Largest FMI       =     0.1053
DF adjustment:   Large sample                   DF:     min       =   3,553.05
                                                        avg       =   1.23e+09
Within VCE type: Delta-method                           max       =   8.47e+09

Expression   : Pr(exitbarred), predict(pr)
dy/dx w.r.t. : democracyrecognition firstchargedateafter1988 intervention foreignrec ethnicmin male ageatbar

--------------------------------------------------------------------------------------
                     |      dy/dx   Std. Err.      t    P>|t|     [95% Conf. Interval]
---------------------+----------------------------------------------------------------
democracyrecognition |   .0319812    .210602     0.15   0.879    -.3807911    .4447534
    firstchargedateafter1988 |   .4312342   .2251113     1.92   0.055     -.009976    .8724443
        intervention |  -.0292412   .0930221    -0.31   0.753    -.2115611    .1530787
          foreignrec |  -.0110701   .0863828    -0.13   0.898    -.1803772    .1582371
           ethnicmin |   .3496586   .1294285     2.70   0.007     .0959834    .6033338
                male |  -.2838886   .1123716    -2.53   0.012    -.5041329   -.0636443
            ageatbar |   .0026904   .0030822     0.87   0.383    -.0033527    .0087335
--------------------------------------------------------------------------------------


coefplot, drop(firstchargedateafter1988 _cons) coeflabels(democracyrecognition="advocated democratization + recognition" intervention="foreign intervention" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(90) xline(0) xtitle(Figure 7: Probabilities for China barring exit) 


*model 1 democracysocialrecognition
mi estimate, or level(90): logistic exitbarred democracysocialrecognition, vce(robust) 

mimrgns, dydx(*) predict(pr) post

*model 2

mi estimate, level(95): linear exitbarred democracysocialrecognition firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 
coefplot, drop(firstchargedateafter1988 _cons) coeflabels(democracyrecognition="democracy and recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(0) eform xtitle(Figure a11a: Linear probabilities for China barring exit) 


mi estimate, or level(95): logistic exitbarred democracysocialrecognition firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 
coefplot, drop(firstchargedateafter1988 _cons) coeflabels(democracyrecognition="democracy and recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(1) eform xtitle(Figure a12: Odds Ratios for China barring exit) 

mi estimate, level(95): logistic exitbarred democracysocialrecognition firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 



mimrgns, dydx(*) predict(pr) post

coefplot, drop(firstchargedateafter1988 _cons) coeflabels(democracysocialrecognition="democracy + social + recognition advocacy" foreignrec="foreign award" ethnicmin="ethnic minority" ageatbar="age at time of bar") levels(95) xline(0) xtitle(Figure 8: Average Marginal Effects for China barring exit) 




*results from above regressions:
 
. *model 1 democracy

. mi estimate, or level(90): logistic exitbarred democracy, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =      20.02
Within VCE type:       Robust                   Prob > F          =     0.0000

------------------------------------------------------------------------------
  exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
-------------+----------------------------------------------------------------
   democracy |   .2037722   .0724488    -4.47   0.000     .1135444    .3656992
       _cons |   1.793103   .4169467     2.51   0.012     1.223204    2.628524
------------------------------------------------------------------------------

. 
. *model 2 democracy

. mi estimate, or level(90): logistic exitbarred democracy firstchargedateafter1988 intervention foreign ethnicmin
>  male ageatbar, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0101
                                                Largest FMI       =     0.0676
DF adjustment:   Large sample                   DF:     min       =   8,599.32
                                                        avg       =   7.17e+07
                                                        max       =   2.17e+08
Model F test:       Equal FMI                   F(   7, 2.2e+06)  =       3.83
Within VCE type:       Robust                   Prob > F          =     0.0004

----------------------------------------------------------------------------------
      exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
-----------------+----------------------------------------------------------------
       democracy |   .2218496   .0851112    -3.92   0.000     .1180328    .4169796
firstchargedateafter1988 |   9.776237   10.71222     2.08   0.037     1.612236    59.28092
    intervention |   1.124148   .5150973     0.26   0.798     .5290535     2.38862
      foreignrec |   .7541802   .3067851    -0.69   0.488     .3862707    1.472511
       ethnicmin |   4.439168   2.906305     2.28   0.023     1.512234    13.03119
            male |   .2772501   .1585264    -2.24   0.025     .1082479    .7101074
        ageatbar |   1.009488   .0154103     0.62   0.536     .9844533     1.03516
           _cons |   .3544397   .4656459    -0.79   0.430     .0408377    3.076264
----------------------------------------------------------------------------------

. 
. 
. 
. *model 1 social

. mi estimate, or level(90): logistic exitbarred social, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       9.17
Within VCE type:       Robust                   Prob > F          =     0.0025

------------------------------------------------------------------------------
  exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
-------------+----------------------------------------------------------------
      social |   2.831403   .9732395     3.03   0.002     1.608635     4.98363
       _cons |   .4772727   .1270049    -2.78   0.005     .3080873    .7393658
------------------------------------------------------------------------------

. *model 2 social

. mi estimate, or level(90): logistic exitbarred social firstchargedateafter1988 intervention foreign ethnicmin ma
> le ageatbar, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0135
                                                Largest FMI       =     0.0884
DF adjustment:   Large sample                   DF:     min       =   5,027.95
                                                        avg       =   3.48e+07
                                                        max       =   9.87e+07
Model F test:       Equal FMI                   F(   7, 1.2e+06)  =       2.73
Within VCE type:       Robust                   Prob > F          =     0.0079

----------------------------------------------------------------------------------
      exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
-----------------+----------------------------------------------------------------
          social |   2.471276   .9041017     2.47   0.013      1.35388    4.510891
firstchargedateafter1988 |   8.138506   8.923847     1.91   0.056     1.340483    49.41152
    intervention |   .9194832   .4064101    -0.19   0.849     .4444284     1.90233
      foreignrec |   .8970566   .3591937    -0.27   0.786     .4642843    1.733228
       ethnicmin |   5.028686   3.181932     2.55   0.011     1.776007    14.23851
            male |   .2846489   .1619815    -2.21   0.027     .1116357    .7257984
        ageatbar |   1.011545   .0150664     0.77   0.441     .9870596    1.036638
           _cons |   .1126817   .1489883    -1.65   0.099     .0128036    .9916842
----------------------------------------------------------------------------------

. 
. 
. 
. *model 1 recognition

. 
. mi estimate, or level(90): logistic exitbarred recognition, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       9.10
Within VCE type:       Robust                   Prob > F          =     0.0026

------------------------------------------------------------------------------
  exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
-------------+----------------------------------------------------------------
 recognition |   4.567307   2.299721     3.02   0.003     1.995133    10.45559
       _cons |   .6933333   .1255293    -2.02   0.043     .5147633    .9338489
------------------------------------------------------------------------------

. 
. *model 2 recognition

. mi estimate, or level(90): logistic exitbarred democracy firstchargedateafter1988 intervention foreign ethnicmin
>  male ageatbar, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0101
                                                Largest FMI       =     0.0676
DF adjustment:   Large sample                   DF:     min       =   8,599.32
                                                        avg       =   7.17e+07
                                                        max       =   2.17e+08
Model F test:       Equal FMI                   F(   7, 2.2e+06)  =       3.83
Within VCE type:       Robust                   Prob > F          =     0.0004

----------------------------------------------------------------------------------
      exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
-----------------+----------------------------------------------------------------
       democracy |   .2218496   .0851112    -3.92   0.000     .1180328    .4169796
firstchargedateafter1988 |   9.776237   10.71222     2.08   0.037     1.612236    59.28092
    intervention |   1.124148   .5150973     0.26   0.798     .5290535     2.38862
      foreignrec |   .7541802   .3067851    -0.69   0.488     .3862707    1.472511
       ethnicmin |   4.439168   2.906305     2.28   0.023     1.512234    13.03119
            male |   .2772501   .1585264    -2.24   0.025     .1082479    .7101074
        ageatbar |   1.009488   .0154103     0.62   0.536     .9844533     1.03516
           _cons |   .3544397   .4656459    -0.79   0.430     .0408377    3.076264
----------------------------------------------------------------------------------

. 
. 
. *model 1 democracysocial

. 
. mi estimate, or level(90): logistic exitbarred democracysocial, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       4.86
Within VCE type:       Robust                   Prob > F          =     0.0275

---------------------------------------------------------------------------------
     exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
----------------+----------------------------------------------------------------
democracysocial |   .2307694   .1535231    -2.20   0.028     .0772582    .6893058
          _cons |          1   .1720655     0.00   1.000     .7535028    1.327135
---------------------------------------------------------------------------------

. 
. *model 2

. mi estimate, or level(90): logistic exitbarred democracysocial firstchargedateafter1988 intervention foreign eth
> nicmin male ageatbar, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0159
                                                Largest FMI       =     0.1054
DF adjustment:   Large sample                   DF:     min       =   3,544.49
                                                        avg       =   1.65e+07
                                                        max       =   4.42e+07
Model F test:       Equal FMI                   F(   7,849984.1)  =       2.80
Within VCE type:       Robust                   Prob > F          =     0.0064

----------------------------------------------------------------------------------
      exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
-----------------+----------------------------------------------------------------
 democracysocial |    .228635   .1547953    -2.18   0.029     .0750754    .6962857
firstchargedateafter1988 |   8.481614   9.145558     1.98   0.047     1.439488    49.97457
    intervention |   .9404372   .4203573    -0.14   0.891     .4508465    1.961692
      foreignrec |   .9057005   .3636381    -0.25   0.805     .4679218    1.753057
       ethnicmin |   5.181215   3.443978     2.47   0.013     1.736198    15.46194
            male |   .2841663   .1613404    -2.22   0.027     .1116831    .7230325
        ageatbar |   1.013852   .0149702     0.93   0.352     .9895186    1.038784
           _cons |   .1896968   .2494277    -1.26   0.206      .021816    1.649473
----------------------------------------------------------------------------------

. 
. 
. *model 1 socialrecognition

. mi estimate, or level(90): logistic exitbarred socialrecognition, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       5.71
Within VCE type:       Robust                   Prob > F          =     0.0169

-----------------------------------------------------------------------------------
       exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
------------------+----------------------------------------------------------------
socialrecognition |   3.733332   2.058861     2.39   0.017     1.507113     9.24799
            _cons |        .75   .1318488    -1.64   0.102     .5616678    1.001482
-----------------------------------------------------------------------------------

. 
. *model 2 socialrecognition

. mi estimate, or level(90): logistic exitbarred socialrecognition firstchargedateafter1988 intervention foreign ethnicmin male ageatbar, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0145
                                                Largest FMI       =     0.0945
DF adjustment:   Large sample                   DF:     min       =   4,409.74
                                                        avg       =   2.57e+07
                                                        max       =   5.47e+07
Model F test:       Equal FMI                   F(   7, 1.0e+06)  =       2.08
Within VCE type:       Robust                   Prob > F          =     0.0419

-----------------------------------------------------------------------------------
       exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
------------------+----------------------------------------------------------------
socialrecognition |    3.38495    2.01108     2.05   0.040     1.273912    8.994255
 firstchargedateafter1988 |    8.96294   12.07396     1.63   0.104     .9775746    82.17714
     intervention |   .9137502   .4117287    -0.20   0.841     .4354583    1.917381
       foreignrec |    .947348   .3875704    -0.13   0.895      .483349    1.856771
        ethnicmin |   4.465533   2.868225     2.33   0.020     1.552543    12.84408
             male |   .2621981   .1545065    -2.27   0.023     .0994675    .6911589
         ageatbar |   1.013074   .0151865     0.87   0.386     .9883948    1.038369
            _cons |    .150998   .2378565    -1.20   0.230     .0113163    2.014834
-----------------------------------------------------------------------------------

. 
. 
. *model 1 democracyrecognition

. mi estimate, or level(90): logistic exitbarred democracyrecognition, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       0.46
Within VCE type:       Robust                   Prob > F          =     0.4975

--------------------------------------------------------------------------------------
          exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
---------------------+----------------------------------------------------------------
democracyrecognition |   2.318841     2.8749     0.68   0.498     .3017299    17.82065
               _cons |      .8625   .1421726    -0.90   0.370     .6576685    1.131126
--------------------------------------------------------------------------------------

. 
. *model 2 democracy recognition

. mi estimate, or level(90): logistic exitbarred democracyrecognition firstchargedateafter1988 intervention foreig
> n ethnicmin male ageatbar, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0155
                                                Largest FMI       =     0.1035
DF adjustment:   Large sample                   DF:     min       =   3,672.98
                                                        avg       =   1.10e+09
                                                        max       =   8.67e+09
Model F test:       Equal FMI                   F(   7,895572.9)  =       2.33
Within VCE type:       Robust                   Prob > F          =     0.0226

--------------------------------------------------------------------------------------
          exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
---------------------+----------------------------------------------------------------
democracyrecognition |   1.160648   1.137217     0.15   0.879     .2316169     5.81608
    firstchargedateafter1988 |   7.453463   7.965363     1.88   0.060     1.285127    43.22851
        intervention |   .8726673   .3780573    -0.31   0.753     .4279346     1.77959
          foreignrec |   .9497308   .3820818    -0.13   0.898     .4900195     1.84072
           ethnicmin |   5.098437   3.370821     2.46   0.014     1.718484    15.12616
                male |   .2664654   .1521583    -2.32   0.021     .1041667    .6816362
            ageatbar |   1.012629   .0148044     0.86   0.391     .9885628    1.037282
               _cons |   .2088442   .2720629    -1.20   0.229     .0245036    1.779981
--------------------------------------------------------------------------------------

. 
. 
. *model 1 democracysocialrecognition

mi estimate, or level(90): logistic exitbarred democracysocialrecognition, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =          .
                                                        avg       =          .
                                                        max       =          .
Model F test:       Equal FMI                   F(   1,      .)   =       0.01
Within VCE type:       Robust                   Prob > F          =     0.9255

--------------------------------------------------------------------------------------------
                exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
---------------------------+----------------------------------------------------------------
democracysocialrecognition |   1.142857    1.63241     0.09   0.926     .1090543    11.97681
                     _cons |       .875   .1436789    -0.81   0.416     .6678954    1.146325
--------------------------------------------------------------------------------------------

. *model 2

. mi estimate, or level(90): logistic exitbarred democracysocialrecognition firstchargedateafter1988 intervention 
> foreign ethnicmin male ageatbar, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0154
                                                Largest FMI       =     0.1037
DF adjustment:   Large sample                   DF:     min       =   3,664.45
                                                        avg       =   3.48e+09
                                                        max       =   2.77e+10
Model F test:       Equal FMI                   F(   7,903110.5)  =       2.21
Within VCE type:       Robust                   Prob > F          =     0.0306

--------------------------------------------------------------------------------------------
                exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
---------------------------+----------------------------------------------------------------
democracysocialrecognition |   .7008866   .7337091    -0.34   0.734     .1252691    3.921495
          firstchargedateafter1988 |   7.551738   8.112914     1.88   0.060     1.290066    44.20607
              intervention |   .8746092   .3795227    -0.31   0.758     .4283836    1.785645
                foreignrec |   .9538221   .3811563    -0.12   0.906     .4943176     1.84047
                 ethnicmin |   5.293773   3.413105     2.58   0.010     1.833137    15.28747
                      male |   .2685508     .15362    -2.30   0.022     .1048079    .6881116
                  ageatbar |   1.012625   .0147709     0.86   0.390     .9886122    1.037221
                     _cons |   .2052381   .2676764    -1.21   0.225     .0240205    1.753614
--------------------------------------------------------------------------------------------






*interaction effects



*interact democracy and ethnicmin
mi estimate, level(90): regress exitbarred democracy#ethnicmin firstchargedateafter1988 foreign male ageatbar, vce(robust) 
*not significant






*interact social and ethnicmin

regress exitbarred social#ethnicmin firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 


/*
Linear regression                               Number of obs     =        132
                                                F(8, 123)         =       4.64
                                                Prob > F          =     0.0001
                                                R-squared         =     0.1523
                                                Root MSE          =     .47246

-------------------------------------------------------------------------------
              |               Robust
   exitbarred | Coefficient  std. err.      t    P>|t|     [95% conf. interval]
--------------+----------------------------------------------------------------
       social#|
    ethnicmin |
         0 1  |   .1930775   .2662262     0.73   0.470    -.3339009    .7200559
         1 0  |   .1295716   .0908295     1.43   0.156    -.0502199    .3093631
         1 1  |   .4777737   .1385337     3.45   0.001     .2035548    .7519926
              |
firstchargedatea~1988 |   .2904032   .1121513     2.59   0.011     .0684066    .5123998
 intervention |   -.064906   .1014612    -0.64   0.524    -.2657423    .1359303
   foreignrec |   .0514605   .0949447     0.54   0.589    -.1364768    .2393978
         male |  -.2400636   .1203462    -1.99   0.048    -.4782815   -.0018456
     ageatbar |   .0033394   .0032495     1.03   0.306    -.0030928    .0097716
        _cons |   .1223451   .1771491     0.69   0.491    -.2283107     .473001
-------------------------------------------------------------------------------

*/

margins social#ethnicmin
/*
Predictive margins                                         Number of obs = 132
Model VCE: Robust

Expression: Linear prediction, predict()

------------------------------------------------------------------------------
             |            Delta-method
             |     Margin   std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social#|
   ethnicmin |
        0 0  |   .3233303   .0659982     4.90   0.000     .1926909    .4539697
        0 1  |   .5164078   .2571164     2.01   0.047     .0074616    1.025354
        1 0  |   .4529019   .0607617     7.45   0.000     .3326278    .5731759
        1 1  |    .801104   .1227739     6.53   0.000     .5580805    1.044127
------------------------------

*/

regress exitbarred social#ethnicmin firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 
margins social#ethnicmin
marginsplot

logit exitbarred social##ethnicmin firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins social##ethnicmin

marginsplot

*INTERESTING
regress exitbarred recognition##ethnicmin firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins recognition##ethnicmin

marginsplot


logit exitbarred recognition##ethnicmin firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins recognition##ethnicmin

marginsplot


regress exitbarred democracy##ethnicmin firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins democracy##ethnicmin

marginsplot


logit exitbarred democracy##ethnicmin firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins democracy##ethnicmin

marginsplot


regress exitbarred democracy##intervention firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins democracy##intervention

marginsplot


logit exitbarred democracy##intervention firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins democracy##intervention

marginsplot


regress exitbarred social##intervention firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins social##intervention

marginsplot

*WOULD BE INTERESTING IF IT WERE STATISTICALLY SIGNIFICANT:

logit exitbarred social##intervention firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins social##intervention

marginsplot

regress exitbarred recognition##intervention firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins recognition##intervention

marginsplot


logit exitbarred recognition##intervention firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins recognition##intervention

marginsplot



*outcome variables with foreignrec
regress exitbarred democracy##foreignrec firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins democracy##foreignrec

marginsplot


logit exitbarred democracy##foreignrec firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins democracy##foreignrec

marginsplot


regress exitbarred social##foreignrec firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins social##foreignrec

marginsplot


logit exitbarred social##foreignrec firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins social##foreignrec

marginsplot

regress exitbarred recognition##foreignrec firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins recognition##foreignrec

marginsplot


logit exitbarred recognition##foreignrec firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 

margins recognition##foreignrec

marginsplot






marginsplot


*try this with multiply imputed data
mi estimate, level(90): regress exitbarred social#ethnicmin firstchargedateafter1988 intervention foreign male ageatbar, vce(robust) 
/*
Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        152
                                                Average RVI       =     0.0135
                                                Largest FMI       =     0.0884
                                                Complete DF       =        144
DF adjustment:   Small sample                   DF:     min       =     126.56
                                                        avg       =     139.39
                                                        max       =     142.00
Model F test:       Equal FMI                   F(   7,  142.0)   =       7.69
Within VCE type:       Robust                   Prob > F          =     0.0000

----------------------------------------------------------------------------------
      exitbarred |      Coef.   Std. Err.      t    P>|t|     [90% Conf. Interval]
-----------------+----------------------------------------------------------------
social#ethnicmin |
            0 1  |   .3296629   .2313719     1.42   0.156    -.0534106    .7127363
            1 0  |   .1930305    .085181     2.27   0.025     .0519993    .3340618
            1 1  |   .4888759   .1196581     4.09   0.000     .2907602    .6869915
                 |
firstchargedateafter1988 |   .3088797   .1057801     2.92   0.004     .1337367    .4840228
      foreignrec |  -.0283724    .086431    -0.33   0.743    -.1714723    .1147275
            male |  -.2555777   .1030292    -2.48   0.014    -.4261595   -.0849958
        ageatbar |   .0024955   .0031773     0.79   0.434    -.0027691    .0077602
           _cons |   .1520009   .1651229     0.92   0.359    -.1214353    .4254372
----------------------------------------------------------------------------------
*/

mimrgns social#ethnicmin

/*
Multiple-imputation estimates                   Imputations       =         40
Predictive margins                              Number of obs     =        152
                                                Average RVI       =     0.0018
                                                Largest FMI       =     0.0041
                                                Complete DF       =        143
DF adjustment:   Small sample                   DF:     min       =     140.49
                                                        avg       =     140.79
Within VCE type: Delta-method                           max       =     140.97

Expression   : Linear prediction, predict(xb)

------------------------------------------------------------------------------
             |     Margin   Std. err.      t    P>|t|     [95% conf. interval]
-------------+----------------------------------------------------------------
      social#|
   ethnicmin |
        0 0  |   .3220128   .0617989     5.21   0.000     .1998403    .4441852
        0 1  |   .6441028   .2225897     2.89   0.004     .2040535    1.084152
        1 0  |   .5121401   .0567727     9.02   0.000     .3999034    .6243767
        1 1  |   .8123349   .1033054     7.86   0.000     .6081007    1.016569
-----------

*/

marginsplot
*but for some reason margins plot does not work so I use the method of UCLA IDRE

*write wrapper program called emargins

program emargins, eclass properties(mi)
  version 15
  args outcome
  regress exitbarred social#ethnicmin firstchargedateafter1988 intervention foreign male ageatbar
  margins, at(social=(0 1) at(ethnicmin=(0 1) atmeans asbalanced  ///
    post  predict(outcome(`outcome')) 
end


*The important part to notice is that the program is marked "eclass"  and we have use the "post" option on the margins statement. This is done so that the predicted probabilities and variance-covariance matrix estimated for each imputed dataset will be saved correctly in the mi ereturn list where mi estimate can access the estimates (not the return list where it would normally go).

mi estimate, cmdok: emargins 1

* save the combined margins predicted probabilities e(b_mi) and variance-covariance matrix e(V_mi) produced by mi estimate into matrices b and V, run a standard margins on the _mi_m == 0 (non-imputed) data, and then repost the results from b and V back into the margins return list r(b) and r(V) where marginsplot can access them. We do the last part with a program called myret.ado which looks like this.

program myret, rclass
    return add
    return matrix b = b
    return matrix V= V
end

*now putting everything together:

set seed 1234543

mi set mlong
mi register regular male firstchargedateafter1988 ethnicmin foreign democracy social recognition intervention exitbarred 

mi register imputed ageatbar

* this is to get the ologit coefficients and standard errors
mi estimate: regress exitbarred social#ethnicmin firstchargedateafter1988 intervention foreign male ageatbar

* loop once for each of the response values of ses
forvalues i=1/6 {

  mi estimate, cmdok: emargins `i'      // emargins is defined above
  mat b= e(b_mi)                        // save mi point estimates
  mat V = e(V_mi)                       // save mi vce
 
* run regress and margins on the _mi_m==0 data
  quietly regress exitbarred social#ethnicmin firstchargedateafter1988 intervention foreign male ageatbar if _mi_m == 0
  quietly margins, at(social=(0 1) ethnicmin=(0 1)) ///
    atmeans asbalanced predict(outcome(`i'))

  myret                                 // myret is defined above
	*Technically we ran the program myret between margins and marginsplot.	
*E(cmd) is the eclass scalar that tells Stata what the previous command was.
* So we have to set that to "margins" for marginsplot to work correctly.
    
mata: st_global("e(cmd)", "margins")  // set previous cmd to margins

marginsplot, x(social) recast(line) noci name(regress`i', replace))
}

*interact recognition and ethnicmin

mi estimate, level(95): regress exitbarred recognition#ethnicmin firstchargedateafter1988 foreign male ageatbar, vce(robust) 


Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        152
                                                Average RVI       =     0.0146
                                                Largest FMI       =     0.0956
                                                Complete DF       =        144
DF adjustment:   Small sample                   DF:     min       =     125.09
                                                        avg       =     139.00
                                                        max       =     141.96
Model F test:       Equal FMI                   F(   7,  142.0)   =       8.12
Within VCE type:       Robust                   Prob > F          =     0.0000

---------------------------------------------------------------------------------------
           exitbarred |      Coef.   Std. Err.      t    P>|t|     [90% Conf. Interval]
----------------------+----------------------------------------------------------------
recognition#ethnicmin |
                 0 1  |    .369866   .1346932     2.75   0.007     .1468456    .5928863
                 1 0  |   .3677089   .1107382     3.32   0.001     .1843634    .5510543
                 1 1  |    .406144    .173172     2.35   0.020       .11943     .692858
                      |
     firstchargedateafter1988 |   .2860059   .1089359     2.63   0.010     .1056348    .4663771
           foreignrec |  -.0361761   .0834075    -0.43   0.665    -.1742703    .1019182
                 male |  -.2860186    .109383    -2.61   0.010    -.4671198   -.1049173
             ageatbar |   .0031701   .0032312     0.98   0.328    -.0021844    .0085247
                _cons |   .2343604   .1783726     1.31   0.191    -.0610201    .5297409
---------------------------------------------------------------------------------------

*significant report

regress exitbarred recognition#ethnicmin firstchargedateafter1988 foreign male ageatbar, vce(robust) 


margins recognition#ethnicmin

marginsplot

regress exitbarred democracy#intervention firstchargedateafter1988 foreign ethnicmin male ageatbar, vce(robust) 



*interact advocacy variables and intervention
mi estimate, level(90): regress exitbarred democracy#intervention firstchargedateafter1988 foreign ethnicmin male ageatbar, vce(robust) 
/*significant

Multiple-imputation estimates                   Imputations       =         40
Linear regression                               Number of obs     =        152
                                                Average RVI       =     0.0098
                                                Largest FMI       =     0.0730
                                                Complete DF       =        143
DF adjustment:   Small sample                   DF:     min       =     128.72
                                                        avg       =     139.19
                                                        max       =     140.97
Model F test:       Equal FMI                   F(   8,  141.0)   =      10.26
Within VCE type:       Robust                   Prob > F          =     0.0000

----------------------------------------------------------------------------------------
            exitbarred |      Coef.   Std. Err.      t    P>|t|     [90% Conf. Interval]
-----------------------+----------------------------------------------------------------
democracy#intervention |
                  0 1  |  -.0795182   .1422182    -0.56   0.577    -.3149942    .1559577
                  1 0  |  -.3631957   .0928543    -3.91   0.000    -.5169377   -.2094537
                  1 1  |  -.2729229   .1199176    -2.28   0.024    -.4714755   -.0743703
                       |
      firstchargedateafter1988 |   .2839011   .1176909     2.41   0.017     .0890306    .4787717
            foreignrec |  -.0463911   .0829348    -0.56   0.577    -.1837091     .090927
             ethnicmin |   .2501706   .1053402     2.37   0.019     .0757524    .4245888
                  male |  -.2255598   .1001793    -2.25   0.026    -.3914306   -.0596891
              ageatbar |   .0021859   .0030127     0.73   0.469    -.0028054    .0071773
                 _cons |   .4512009   .1744321     2.59   0.011     .1623512    .7400506
----------------------------------------------------------------------------------------



*/

regress exitbarred democracy#intervention firstchargedateafter1988 foreign ethnicmin male ageatbar, vce(robust)


margins democracy#intervention
marginsplot

mi estimate, level(95): regress exitbarred social#intervention firstchargedateafter1988 foreign ethnicmin male ageatbar, vce(robust) 


mi estimate, level(95): regress exitbarred recognition#intervention firstchargedateafter1988 foreign ethnicmin male ageatbar, vce(robust) 

*interact foreignrec with types of advocacy
mi estimate, level(95): regress exitbarred democracy#foreignrec firstchargedateafter1988 foreign ethnicmin male ageatbar, vce(robust) 

mi estimate, level(95): regress exitbarred social#foreignrec firstchargedateafter1988 foreign ethnicmin male ageatbar, vce(robust) 

mi estimate, level(95): regress exitbarred recognition#foreignrec firstchargedateafter1988 foreign ethnicmin male ageatbar, vce(robust) 






program emargins, eclass properties(mi)
  version 15
  args outcome
  ologit ses female read math
  margins, at(female=(0 1) read=(30(10)70)) atmeans asbalanced  ///
    post  predict(outcome(`outcome')) 
end

*note this will only run so upload data and do it in office
forvalues i=1/3 {
mi estimate, cmdok: emargins `i'      // emargins is defined above
mat b= e(b_mi)                        // save mi point estimates
mat V = e(V_mi)                       // save mi vce

* run ologit and margins on the _mi_m==0 data
quietly regress ses female read math if _mi_m == 0
quietly margins, at(social=(0 1) ethnicmin=(0 1) ///
atmeans asbalanced predict(outcome(`i'))
myret                                 // myret is defined above
*Technically we ran the program myret between margins and marginsvplot.  
*E(cmd) is the eclass scalar that tells Stata what the previous command was.
*So we have to set that to "margins" for marginsplot to work correctly.
     
mata: st_global("e(cmd)", "margins")  // set previous cmd to margins
 
marginsplot, x(ethnicmin) recast(line) noci name(regress`i', replace)
 } 

 




mi estimate, or level(90): logistic exitbarred democracy social recognition firstchargedateafter1988, vce(robust) 

/*
 mi estimate, or level(90): logistic exitbarred democracy social recognition firstchargedateafter1988, vce(robust) 

Multiple-imputation estimates                   Imputations       =         40
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0000
                                                Largest FMI       =     0.0000
DF adjustment:   Large sample                   DF:     min       =   3.78e+64
                                                        avg       =   3.78e+64
                                                        max       =          .
Model F test:       Equal FMI                   F(   4,      .)   =       6.25
Within VCE type:       Robust                   Prob > F          =     0.0001

----------------------------------------------------------------------------------
      exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
-----------------+----------------------------------------------------------------
       democracy |   .2516911   .1188508    -2.92   0.003     .1157564    .5472564
          social |   1.062026   .5081062     0.13   0.900     .4834677    2.332936
     recognition |    2.83406   1.539569     1.92   0.055     1.159702    6.925825
firstchargedateafter1988 |   8.704237   10.33717     1.82   0.068     1.234145    61.38968
           _cons |   .1694877   .2152517    -1.40   0.162     .0209847    1.368906
-------------------------------------------------------------------------------



*/

*model 2


mi estimate, or level(90): logistic exitbarred democracy social recognition firstchargedateafter1988 intervention foreign ageatbar male ethnicmin, vce(robust) 


/*
Multiple-imputation estimates                   Imputations       =         80
Logistic regression                             Number of obs     =        152
                                                Average RVI       =     0.0076
                                                Largest FMI       =     0.0614
DF adjustment:   Large sample                   DF:     min       =  21,038.75
                                                        avg       =   2.23e+08
                                                        max       =   6.58e+08
Model F test:       Equal FMI                   F(   9, 1.1e+07)  =       3.01
Within VCE type:       Robust                   Prob > F          =     0.0013

----------------------------------------------------------------------------------
      exitbarred | Odds Ratio   Std. Err.      t    P>|t|     [90% Conf. Interval]
-----------------+----------------------------------------------------------------
       democracy |   .2608729   .1258757    -2.78   0.005      .117962    .5769199
          social |   .9919292    .479524    -0.02   0.987      .447863     2.19693
     recognition |   2.575188   1.354605     1.80   0.072     1.084039    6.117488
firstchargedateafter1988 |   10.21532   12.93646     1.84   0.066      1.27237    82.01449
    intervention |   1.170177   .5432945     0.34   0.735     .5452425    2.511385
      foreignrec |   .7240402   .2990787    -0.78   0.434     .3670171    1.428365
        ageatbar |   1.009682   .0154309     0.63   0.528     .9846153    1.035386
            male |   .2592662   .1516379    -2.31   0.021     .0990697    .6785014
       ethnicmin |   3.298492    1.97997     1.99   0.047     1.228897    8.853507
           _cons |   .2944158   .4533941    -0.79   0.427     .0233817    3.707207
----------------------------------------------------------------------------------


*/



*rerun analysis with new cases
exactcc democracy social, exact
exactcc democracy recognition, exact
exactcc democracy firstchargedateafter1988, exact
exactcc democracy intervention, exact
exactcc democracy foreignrec, exact
exactcc democracy ethnicmin, exact
exactcc democracy male, exact
exactcc social recogntiion, exact
exactcc social firstchargedateafter1988, exact

exactcc social intervention, exact
exactcc social foreignrec, exact
exactcc social ethnicmin, exact
exactcc recognition firstchargedateafter1988, exact
exactcc recognition intervention, exact
exactcc recognition foreignrec, exact
exactcc recognition male, exact
exactcc recognition ethnicmin, exact

exactcc firstchargedateafter1988 intervention, exact
exactcc firstchargedateafter1988 foreignrec, exact
exactcc firstchargedateafter1988 male, exact
exactcc firstchargedateafter1988 ethnicmin, exact
exactcc intervention foreignrec, exact
exactcc intervention male, exact
exactcc intervention ethnicmin, exact
exactcc foreignrec male, exact
exactcc foreignrec ethnicmin, exact
exactcc male ethnicmin, exact






