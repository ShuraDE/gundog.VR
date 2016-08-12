#include "defines.hpp"
//return strength of scent (0 = nothing)
private ["_intensity"];

_intensity = 1;

//im wasser keine spuren
if (surfaceIsWater getPos GRAD_GUNDOG_TARGET) then { _intensity = _intensity - 0.9 };

//im fahrzeug fast keine spur hinterlassen (20%)
if (vehicle GRAD_GUNDOG_TARGET != GRAD_GUNDOG_TARGET) then { _intensity = _intensity - 0.7 };



_intensity max 0;
