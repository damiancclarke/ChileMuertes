clear all
set more off

global DAT ~/universidades/Oxford/DPhil/Thesis/Teens/Data/Defunciones
global OUT ~/investigacion/2014/ChileMuertes/Graphs

cap mkdir $OUT

use $DAT/Defunciones_2002_2010
gen all=1

local conditions all==1 edad_m<19 edad_m<35 edad_m>=19&edad_m<35 edad_m>=35 /*
*/ est_civ_m==1 est_civ_m==2 urba_rural==1 urba_rural==2 nivel_ma>3 nivel_ma<4 

hist gestacion if gestacion<99, scheme(s1color) freq width(1) ///
  title("Muertes Fetales por Semana de Gestacion") ///
  subtitle("Todos") note("En base a registros de MinSal, 2002-2010.")
graph export $OUT/AllGestacion.eps, as(eps) replace

hist gestacion if gestacion<99&edad_m<19, scheme(s1color) freq width(1) ///
  title("Muertes Fetales por Semana de Gestacion") ///
  subtitle("Madre 15-19") note("En base a registros de MinSal, 2002-2010.")
graph export $OUT/TeenGestacion.eps, as(eps) replace

hist gestacion if gestacion<99&edad_m<35, scheme(s1color) freq  width(1) ///
  title("Muertes Fetales por Semana de Gestacion") ///
  subtitle("Madre menor que 35") note("En base a registros de MinSal, 2002-2010.")
graph export $OUT/Gestacion34menos.eps, as(eps) replace

hist gestacion if gestacion<99&edad_m>=19&edad_m<35, scheme(s1color) freq width(1) ///
  title("Muertes Fetales por Semana de Gestacion") ///
  subtitle("Madre 20-34") note("En base a registros de MinSal, 2002-2010.")
graph export $OUT/Gestacion2034a.eps, as(eps) replace

hist gestacion if gestacion<99&edad_m>=35, scheme(s1color) freq  width(1) ///
  title("Muertes Fetales por Semana de Gestacion") ///
  subtitle("Madre 35+") note("En base a registros de MinSal, 2002-2010.")
graph export $OUT/Gestacion34plus.eps, as(eps) replace

hist gestacion if gestacion<99&est_civ_m==1, scheme(s1color) freq  width(1) ///
  title("Muertes Fetales por Semana de Gestacion") ///
  subtitle("Parjea") note("En base a registros de MinSal, 2002-2010.")
graph export $OUT/GestacionPareja.eps, as(eps) replace

hist gestacion if gestacion<99&est_civ_m==2, scheme(s1color) freq  width(1) ///
  title("Muertes Fetales por Semana de Gestacion") ///
  subtitle("Soltera") note("En base a registros de MinSal, 2002-2010.")
graph export $OUT/GestacionSoltera.eps, as(eps) replace

hist gestacion if gestacion<99&urba_rural==1, scheme(s1color) freq  width(1) ///
  title("Muertes Fetales por Semana de Gestacion") ///
  subtitle("Urbana") note("En base a registros de MinSal, 2002-2010.")
graph export $OUT/GestacionUrbana.eps, as(eps) replace

hist gestacion if gestacion<99&urba_rural==2, scheme(s1color) freq  width(1) ///
  title("Muertes Fetales por Semana de Gestacion") ///
  subtitle("Rural") note("En base a registros de MinSal, 2002-2010.")
graph export $OUT/GestacionRural.eps, as(eps) replace

hist gestacion if gestacion<99&nivel_ma>3, scheme(s1color) freq  width(1) ///
  title("Muertes Fetales por Semana de Gestacion") ///
  subtitle("Educacion Terciaria") note("En base a registros de MinSal, 2002-2010.")
graph export $OUT/GestacionUniversidad.eps, as(eps) replace

hist gestacion if gestacion<99&nivel_ma<4, scheme(s1color) freq  width(1) ///
  title("Muertes Fetales por Semana de Gestacion") ///
  subtitle("Educacion Basica/Media") note("En base a registros de MinSal, 2002-2010.")
graph export $OUT/GestacionMedia.eps, as(eps) replace
