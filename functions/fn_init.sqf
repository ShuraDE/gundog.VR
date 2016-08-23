#include "defines.hpp"

private ["_pfhMarker", "_newTargetTraces", "_newTargetSectors", "_newTargetData", "_hunterData"];
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
    //get active data and clear
    _hunterData = HASH_GET(IVAR(HUNTERS), _hunter);

    //remove old pfh, add new target to targets
    LOG_DEBUG(FORMAT_1("remove old pfh handler ID %1", _hunterData select 1));
    [(_hunterData select 1)] call CBA_fnc_removePerFrameHandler;
    _hunterData = _hunterData select 0;
    _hunterData pushBackUnique _houndedTarget;

    //create new pfh with new targetsarray (reduce query)
    _pfhMarker = [IFNC(findScent), GRAD_GUNDOG_INITIAL_SEARCH, [_hunter, _hunterData]] call FNC_CBA(addPerFrameHandler);
    LOG_DEBUG(FORMAT_2("append new pfh handler (search) with ID %1 for", _pfhMarker, _hunter));
    //be sure left all data correct in array
    _hunterData = [_hunterData, _pfhMarker];

    HASH_SET(IVAR(HUNTERS), _hunter, _hunterData);
    LOG_DEBUG(FORMAT_1("hunter hash (append) is %1", HASH_GET(IVAR(HUNTERS), _hunter)));
  } else {
    _pfhMarker = [IFNC(findScent), GRAD_GUNDOG_INITIAL_SEARCH, [_hunter, [_houndedTarget]]] call FNC_CBA(addPerFrameHandler);
    LOG_DEBUG(FORMAT_2("append new pfh handler (search) with ID %1 for", _pfhMarker, _hunter));
    _hunterData = [[_houndedTarget], _pfhMarker];
    HASH_SET(IVAR(HUNTERS), _hunter, _hunterData);
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
