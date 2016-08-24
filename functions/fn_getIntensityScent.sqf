#include "defines.hpp"

//return strength of scent (0 = nothing, 1=100% max)

private ["_intensity"];
params ["_target"];


//start with 100% strength, can be higher then 100%
_intensity = 1;

//reduction
if (surfaceIsWater position _target) then { _intensity = _intensity - GRAD_GUNDOG_INTENSITY_CHANGE_WATER; };

//im fahrzeug fast keine spur hinterlassen (20%)
if (vehicle _target != _target) then { _intensity = _intensity - GRAD_GUNDOG_INTENSITY_CHANGE_VEHICLE; };

//wenn tot higher scent
if (!(alive _target)) then { _intensity = _intensity - GRAD_GUNDOG_INTENSITY_CHANGE_DEAD; };

//wenn verwundet
if (damage _target > 0) then { _intensity = _intensity - GRAD_GUNDOG_INTENSITY_CHANGE_BLEEDING; };

//wenn verschwitzt (ausdauer unten)
if (getFatigue _target > 0.5) then { _intensity = _intensity - GRAD_GUNDOG_INTENSITY_CHANGE_FATIGUE; };

_intensity max 0;
