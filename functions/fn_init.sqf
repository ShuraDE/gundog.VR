#include "defines.hpp"

private ["_pfhMarker", "_newTargetTraces", "_newTargetSectors", "_newTargetData", "_newHunterData"];
params ["_houndedTarget","_hunter"];


/*
IVAR(HOUNDED)
houndedArray  hashArray   : key = object (hounded)   value = [] data
data          array       : [] traces , hashArray sectors, perFrameHandler id
traces        array       : time, pos, scentPower

IVAR(HUNTERS)
huntersArray  hashArray   : key = object (hunter)    value = [] data
data          array       : [] targets , perFrameHandler id
targets       array       : object (hounded)
*/


LOG_DEBUG(FORMAT_2("new init target is %1, hunter is %2", _houndedTarget, _hunter));


/*

HUNTER part

*/
if (!(_hunter isEqualTo objNull)) then {
  //append target to hunters target array
  if (HASH_HAS_KEY(IVAR(HUNTERS), _hunter)) then {
    _newHunterData = (HASH_GET(IVAR(HUNTERS), _hunter)) select 0;
    _newHunterData pushBack _houndedTarget;
    HASH_SET(IVAR(HUNTERS), _hunter, _newHunterData);
    LOG_DEBUG(FORMAT_1("hunter hash (append) is %1", HASH_GET(IVAR(HUNTERS), _hunter)));
  } else {
    _pfhMarker = [IFNC(findScent), GRAD_GUNDOG_INITIAL_SEARCH, [_hunter]] call FNC_CBA(addPerFrameHandler);
    _newHunterData = [[_houndedTarget], _pfhMarker];
    HASH_SET(IVAR(HUNTERS), _hunter, _newHunterData);
    LOG_DEBUG(FORMAT_1("hunter hash (new) is %1", HASH_GET(IVAR(HUNTERS), _hunter)));
  };
};

/*

HOUNDED part

*/
//check target already exists, create new trace if not
if (!(HASH_HAS_KEY(IVAR(HOUNDED), _houndedTarget))) then {
//if not create a new hounded trace
  _newTargetTraces = [];
  _newTargetSectors = HASH_CREATE;

  //each x second append new scent to trace route
  _pfhMarker = [IFNC(appendMarker), GRAD_GUNDOG_INTERVAL_SCENT, [_houndedTarget, _newTargetTraces, _newTargetSectors]] call FNC_CBA(addPerFrameHandler);

  _newTargetData = [_newTargetTraces, _newTargetSectors, _pfhMarker];

  HASH_SET(IVAR(HOUNDED), _houndedTarget, _newTargetData);
};
