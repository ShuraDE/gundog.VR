#include "defines.hpp"

params ["_target","_chaser"];

//vars defines
GRAD_GUNDOG_TRACK = [];
GRAD_GUNDOG_TARGET = _target;
GRAD_GUNDOG_CHASER = _chaser;
GRAD_GUNDOG_HUNTING_GROUND = HASH_CREATE;

// #TODO:0  loop appendMarker
[] call GRAD_GUNDOG_fnc_appendMarker;
// #TODO:0  loop reduceScent
