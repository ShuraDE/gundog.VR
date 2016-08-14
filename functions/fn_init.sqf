#include "defines.hpp"

params ["_target","_chaser"];

//vars defines
//complete route
GRAD_GUNDOG_TRACK = [];
//target (scent drop)
GRAD_GUNDOG_TARGET = _target;
//gundog (sniffer)
GRAD_GUNDOG_CHASER = _chaser;
//raster on 10 km
if (GRAD_GUNDOG_SECTOR_1) then { GRAD_GUNDOG_HUNTING_GROUND_1 = HASH_CREATE; };
//raster on 1 km
if (GRAD_GUNDOG_SECTOR_2) then { GRAD_GUNDOG_HUNTING_GROUND_2 = HASH_CREATE; };
//raster on 100 m
if (GRAD_GUNDOG_SECTOR_3) then { GRAD_GUNDOG_HUNTING_GROUND_3 = HASH_CREATE; };

//scent already found
GRAD_GUNDOG_HAVE_SCENT = FALSE;
// #TODO:0  loop appendMarker
[] call FNC(appendMarker);
// #TODO:0  loop reduceScent
