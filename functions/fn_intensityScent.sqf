#include "defines.hpp"

//return strength of scent (0 = nothing)

//im wasser keine spuren
if (surfaceIsWater getPos GRAD_GUNDOG_TARGET) exitWith { 0 };

//im fahrzeug fast keine spur hinterlassen (10%)
if (vehicle GRAD_GUNDOG_TARGET != GRAD_GUNDOG_TARGET) exitWith { 0.1 };


//ansonsten 100% spur hinterlassen
1;
