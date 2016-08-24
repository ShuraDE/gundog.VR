#include "functions\defines.hpp"

//prepare datastorage
IVAR(HOUNDED) = HASH_CREATE;
IVAR(HUNTERS) = HASH_CREATE;
IVAR(SECTOR) = HASH_CREATE;


[player, hunter] call IFNC(init);
