#include "defines.hpp"

//return strength of scent (0 = nothing, 1=100% max)

private ["_intensity"];
params ["_target"];


//start with 100% strength
_intensity = 1;

//reduction
if (surfaceIsWater position _target) then { _intensity = _intensity - GRAD_GUNDOG_INTENSITY_CHANGE_WATER; };

//im fahrzeug fast keine spur hinterlassen (20%)
if (vehicle _target != _target) then { _intensity = _intensity - GRAD_GUNDOG_INTENSITY_CHANGE_VEHICLE; };

_intensity max 0;
