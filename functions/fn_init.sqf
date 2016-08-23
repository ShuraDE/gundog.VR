#include "defines.hpp"

private ["_pfhMarker", "_newTargetTraces", "_newTargetSectors", "_newTarget"];
params ["_houndedTarget","_hunter"];


/*
IVAR(HOUNDED)
houndedArray  hashArray   : key = object (hounded)   value = [] data
data          array       : [] traces , hashArray sectors, perFrameHandler id
traces        array       : time, pos, scentPower

IVAR(HUNTERS)
huntersArray  hashArray   : key = object (hunter)    value = [] targets
targets       array       : object (hounded)
*/

/*

HUNTER part

*/
//append target to hunters target array
if (HASH_HAS_KEY(IVAR(HUNTERS), _hunter)) then {
  _newTarget = HASH_GET(IVAR(HUNTERS), _hunter);
  _newTarget pushBack _houndedTarget;
} else {
  _newTarget = [_houndedTarget];
};
HASH_SET(IVAR(HUNTERS), _newTarget);

/*

HOUNDED part

*/
//check target already exists, create new trace if not
if (!(HASH_HAS_KEY(IVAR(HOUNDED), _houndedTarget))) then {
//if not create a new hounded trace
  _newTargetTraces = [];
  _newTargetSectors = HASH_CREATE;
  
  //each x second append new scent to trace route
  _pfhMarker = [IFNC(appendMarker), IVAR(INTERVAL_SCENT), [_houndedTarget, _traces, _sectors]] call CBA_fnc_addPerFrameHandler;
  
  _newTarget = [_newTargetTraces, _newTargetSectors, _pfhMarker]
  
  HASH_SET(IVAR(HOUNDED), _houndedTarget, _newTarget);
};