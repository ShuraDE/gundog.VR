#define LIB GRAD
#define MODULE GUNDOG
#define IPREFIX DOUBLES(LIB,MODULE)

#define GRAD_GUNDOG_INITIAL_SCENT 50
#define GRAD_GUNDOG_INITIAL_SEARCH 50
#define GRAD_GUNDOG_INITIAL_FOLLOW 50
#define GRAD_GUNDOG_DECREASE_SCENT 1
#define GRAD_GUNDOG_INTERVAL_SCENT 5
#define GRAD_GUNDOG_IMPACT_SCENT 2.5
#define GRAD_GUNDOG_MAX_RANGE 100

//positive values REDUCE !! scent level
#define GRAD_GUNDOG_INTENSITY_CHANGE_WATER 0.9
#define GRAD_GUNDOG_INTENSITY_CHANGE_VEHICLE 0.8
#define GRAD_GUNDOG_INTENSITY_CHANGE_DEAD -2
#define GRAD_GUNDOG_INTENSITY_CHANGE_BLEEDING -2
#define GRAD_GUNDOG_INTENSITY_CHANGE_FATIGUE -1.2


//use x digit sector
#define GRAD_GUNDOG_SECTOR_1 TRUE
#define GRAD_GUNDOG_SECTOR_2 TRUE
#define GRAD_GUNDOG_SECTOR_3 TRUE

//comment this line to deactivate
#define DEBUG_MODE 1
#define TRACE_MODE 1


//#define LOG_BASE(module,level,message) diag_log text LOG_FORMAT(module,level,__FILE__, __LINE__,message)
//#define LOG_BASE(module,level,message) diag_log FORMAT["%1 %2 %3 %4 %5",module,level,__FILE__, __LINE__,message]

/*
//funkt net  :-/
//MISSION_ROOT in descruption ext
//#define GETVAR_SYS(var1) parsingNamespace getVariable [QUOTE(var1)]
//test hardcoded
#define GETVAR_SYS(x) "C:\Users\Shura\Documents\Arma 3\missions\gundog.VR"
#define MISSIONDIR GETVAR_SYS(MISSION_ROOT)
#define DIR_AR_MISSION {MISSIONDIR splitString "\"}
#define DIR_AR_FILE {__FILE__ splitString "\"}
#define DIR_AR_DELTA {DIR_AR_FILE - DIR_AR_MISSION}
#define SCRIPT_FILE {DIR_AR_DELTA joinString "\"}
*/

//("C:\Users\Shura\Documents\Arma 3\missions\gundog.VR\functions\fn_reduceScent.sqf" splitString "\")  - (parsingNamespace getVariable "MISSION_ROOT" splitString "\") joinString "\"
//#define  ...  get file by __FILE__ - missions root
//#define LOG_BASE(module,level,message) diag_log FORMAT["%1 %2 %3 %4 %5",module,level,__FILE__,__LINE__,message]
#define LOG_BASE(module,level,message) diag_log FORMAT["%1 %2 %3 %4 %5",module,level,"...",__LINE__,message]
#define LOG_ERR(message) LOG_BASE("GUNDOG","ERROR",message)
#define LOG_INFO(message) LOG_BASE("GUNDOG","INFO",message)
#define LOG_WARN(message) LOG_BASE("GUNDOG","WARN",message)

#ifdef DEBUG_MODE
  #define DEBUG_ENABLE TRUE
  #define LOG_DEBUG(message) LOG_BASE("GUNDOG","DEBUG",message)
#else
  #define DEBUG_ENABLE FALSE
  #define LOG_DEBUG(message)
#endif
#ifdef TRACE_MODE
  #define TRACE_ENABLE TRUE
  #define LOG_TRACE(message) LOG_BASE("GUNDOG","TRACE",message)
#else
  #define TRACE_ENABLE FALSE
  #define LOG_TRACE(message)
#endif

#define FORMAT_1(STR,ARG1) format[STR, ARG1]
#define FORMAT_2(STR,ARG1,ARG2) format[STR, ARG1, ARG2]
#define FORMAT_3(STR,ARG1,ARG2,ARG3) format[STR, ARG1, ARG2, ARG3]
#define FORMAT_4(STR,ARG1,ARG2,ARG3,ARG4) format[STR, ARG1, ARG2, ARG3, ARG4]
#define FORMAT_5(STR,ARG1,ARG2,ARG3,ARG4,ARG5) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5]
#define FORMAT_6(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6]
#define FORMAT_7(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7]
#define FORMAT_8(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8]

#define GAMETIME {if (isServer && hasInterface) exitWith { time } serverTime; }

#define QUOTE(var1) #var1
#define DOUBLES(var1,var2) ##var1##_##var2
#define TRIPLES(var1,var2,var3) ##var1##_##var2##_##var3

#define FNC_BIS(var1) TRIPLES(BIS,fnc,var1) //BIS Function
#define FNC_CBA(var1) TRIPLES(CBA,fnc,var1) //CBA Function
#define IFNC(var1) TRIPLES(IPREFIX,fnc,var1)
#define IVAR(var1) DOUBLES(IPREFIX,var1)
#define QIVAR(var1) QUOTE(IVAR(var1))

#define HASH_CREATE                         ([] call FNC_CBA(hashCreate))
// #TODO:9 HASH_NEW rework
#define HASH_NEW(haarray, defValue)         ([haarray, defValue] call FNC_CBA(hashCreate)) //creates a new hash [[]]
//#define HASH_NEW(haarray)                   ([haarray] call FNC_CBA(hashCreate)) //creates a new hash [[]]
#define HASH_GET(haarray, keyValue)         ([haarray, keyValue] call FNC_CBA(hashGet)) //get value entry from key
#define HASH_SET(haarray, keyValue, value)  ([haarray, keyValue, value] call FNC_CBA(hashSet)) //set new value with given key, replace if exists
#define HASH_HAS_KEY(haarray, keyValue)     ([haarray, keyValue] call FNC_CBA(hashHasKey)) //check key exists, return true if exists
#define HASH_REM(haarray, keyValue)         ([haarray, keyValue] call FNC_CBA(hashRem)) //remove entry from hash table with given key
#define HASH_FOREACH(haarray, codeValue)    ([haarray, codeValue] call FNC_CBA(hashEachPair)) // execute code each element. using _key and _value
#define HASH_IS_HASH(object)                ([_object] call FNC_CBA(isHash)) // return true if is hashtable
