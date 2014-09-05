* descriptive.do 0.00            damiancclarke             yyyy-mm-dd:2014-09-05
*---|----1----|----2----|----3----|----4----|----5----|----6----|----7----|----8
*

clear all
set more off

********************************************************************************
*** (1) global local
********************************************************************************
global DAT ~/universidades/Oxford/DPhil/Thesis/Teens/Data/Defunciones
global OUT ~/investigacion/2014/ChileMuertes/Graphs

cap mkdir $OUT

local conditions all==1 edad_m<19 edad_m<35 edad_m>=19&edad_m<35 edad_m>=35 /*
*/ est_civ_m==1 est_civ_m==2 urba_rural==1 urba_rural==2 nivel_ma>3 nivel_ma<4 
local names Todos 15-19 Menor35 20-34 Mayor34 Pareja Soltera Urbana Rural /*
*/ NoUniversidad Universidad

********************************************************************************
*** (2) graphs
********************************************************************************
use $DAT/Defunciones_2002_2010
gen all=1

tokenize `names'
foreach cond of local conditions {
	hist gestacion if gestacion<99&`cond', scheme(s1color) freq width(1) ///
	  title("Muertes Fetales por Semana de Gestacion") ///
	  subtitle("`1'") note("En base a registros de MinSal, 2002-2010.")
	graph export "$OUT/Gestacion`1'.eps", as(eps) replace
	macro shift
}

