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

foreach year of numlist 2002(1)2010 {
	hist gestacion if gestacion<99&year==`year', scheme(s1color) freq ///
	  title("Muertes Fetales por Semana de Gestacion") width(1) ///
	  subtitle("`year'") note("En base a registros de MinSal, `year'.")
	graph export "$OUT/Gestacion`year'.eps", as(eps) replace
	macro shift
}

drop if gestacion==99
scatter peso gestacion if peso<6000 || qfit peso gestacion if peso<6000, ///
  title("Peso y tiempo de Gestacion (semanas)") scheme(s1color) ///
  note("En base a registros de MinSal, 2002-2010.") ///
  legend(label(1 "Registro Individual") label(2 "Quadratico"))
graph export "$OUT/PesoGestacion.eps", as(eps) replace

