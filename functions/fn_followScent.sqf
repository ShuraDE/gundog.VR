#include "defines.hpp"

LOG_DEBUG(FORMAT_2("Append %1 to sector(1) %2", _idx, _sector));


//end if dead
if (!(alive _hunter)) exitWith {
  //remove pfh
  [_hunter getVariable [QIVAR(PFH),-1]] call FNC_CBA(removePerFrameHandler);
  _hunter setVariable [QIVAR(PFH),-1];
};



//if trace is found, follow trace
//lost if every node (with enough intensity) visited 
