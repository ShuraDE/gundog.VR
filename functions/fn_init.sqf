#include "defines.hpp"

/*
  creates a new target (hounded) and/or assign the target to a hunter
  create new hunter if !exists hunter
  
  it is not possible the initialize a hunter without a target...  why ? ;)
*/


private ["_pfhMarker", "_newTargetTraces", "_newTargetSectors", "_newTargetData", "_hunterData"];
params ["_houndedTarget","_hunter"];


/*

hounded array enthällt alle gejagten mit 
* präziser spur (traces)
* sector array (grob raster, mit referenzen (idx) auf traces
* pfh id 

IVAR(HOUNDED)
houndedArray  hashArray   : key = object (hounded)   value = [] data
data          array       : [] traces , hashArray sectors
traces        array       : time, pos, scentPower


der hunter array enthällt alle hunter und deren aktive ziele

IVAR(HUNTERS)
huntersArray  hashArray   : key = object (hunter)    value = [] targets
targets       array       : object (hounded)


der gloable sector array, enthällt von allen "hounded" betretende sectoren
der hunter sucht in fnc "find" zuerst im globalen
* ist irgendwas im aktuellen sector wenn ja 
* ist hunters target betroffen wenn ja
* gehe ziele durch 

IVAR(SECTOR)
globalSector  hashArray   : key = sectors             value = [] unique hounded object
*/

if (_houndedTarget isEqualTo objNull) exitWith { LOG_ERROR(FORMAT_1("there is no target, abort initialize! %1", _houndedTarget)); };

LOG_DEBUG(FORMAT_2("new init target is %1, hunter is %2", _houndedTarget, _hunter));

/*

HOUNDED part

*/
//check target already exists, create new trace if not
if (!(HASH_HAS_KEY(IVAR(HOUNDED), _houndedTarget))) then {
//if not create a new hounded trace
  _newTargetTraces = [];
  _newTargetSectors = HASH_CREATE;

  //each x second append new scent to trace route, pfh needs declared var's
  _pfhMarker = [IFNC(appendMarker), GRAD_GUNDOG_INTERVAL_SCENT, [_houndedTarget, _newTargetTraces, _newTargetSectors]] call FNC_CBA(addPerFrameHandler);
  _houndedTarget setVariable [QIVAR(PFH),_pfhMarker];
  
  _newTargetData = [_newTargetTraces, _newTargetSectors];
  HASH_SET(IVAR(HOUNDED), _houndedTarget, _newTargetData);  
  
};


/*

HUNTER part

*/
if (!(_hunter isEqualTo objNull)) then {
  //append target to hunters target array
  if (HASH_HAS_KEY(IVAR(HUNTERS), _hunter)) then {
    
    //get active data and clear
    _hunterData = HASH_GET(IVAR(HUNTERS), _hunter);

    //remove old pfh with old target array
    LOG_DEBUG(FORMAT_2("remove old pfh handler ID %1 from %2", _hunter getVariable [QIVAR(PFH),_1], _hunter));
    [_hunter getVariable [QIVAR(PFH),-1]] call FNC_CBA(removePerFrameHandler);
    
    //add new target to targets
    _hunterData pushBackUnique _houndedTarget;
    
    LOG_DEBUG(FORMAT_1("hunter hash (append) is %1", HASH_GET(IVAR(HUNTERS), _hunter)));
  } else {
     //create pfh for hunter
    _pfhMarker = [IFNC(findScent), GRAD_GUNDOG_INITIAL_SEARCH, [_hunter, [_houndedTarget]]] call FNC_CBA(addPerFrameHandler);
    LOG_DEBUG(FORMAT_2("append new pfh handler (search) with ID %1 for", _pfhMarker, _hunter));

    _hunterData = [_houndedTarget];
  };
  
  // create pfh  & set data
  _pfhMarker = [IFNC(findScent), GRAD_GUNDOG_INITIAL_SEARCH, [_hunter, _hunterData]] call FNC_CBA(addPerFrameHandler);
  _hunter setVariable [QIVAR(PFH),_pfhMarker];
  HASH_SET(IVAR(HUNTERS), _hunter, _hunterData);
};


