#define GRAD_GUNDOG_INITIAL_SCENT 50
#define GRAD_GUNDOG_DECREASE_SCENT 1
#define GRAD_GUNDOG_MAX_RANGE 100

//comment this line to deactivate
#define DEBUG_MODE 1


//#define LOG_BASE(module,level,message) diag_log text LOG_FORMAT(module,level,__FILE__, __LINE__,message)
//#define LOG_BASE(module,level,message) diag_log FORMAT["%1 %2 %3 %4 %5",module,level,__FILE__, __LINE__,message]

#define LOG_BASE(module,level,message) diag_log FORMAT["%1 %2 %3 %4 %5",module,level,__FILE__,__LINE__,message]
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

#define FORMAT_1(STR,ARG1) format[STR, ARG1]
#define FORMAT_2(STR,ARG1,ARG2) format[STR, ARG1, ARG2]
#define FORMAT_3(STR,ARG1,ARG2,ARG3) format[STR, ARG1, ARG2, ARG3]
#define FORMAT_4(STR,ARG1,ARG2,ARG3,ARG4) format[STR, ARG1, ARG2, ARG3, ARG4]
#define FORMAT_5(STR,ARG1,ARG2,ARG3,ARG4,ARG5) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5]
#define FORMAT_6(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6]
#define FORMAT_7(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7]
#define FORMAT_8(STR,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8) format[STR, ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8]

#define GAMETIME {if (isServer && hasInterface) exitWith { time } serverTime; }

#define DOUBLES(var1,var2) ##var1##_##var2
#define TRIPLES(var1,var2,var3) ##var1##_##var2##_##var3

#define FNC_CBA(var1) TRIPLES(CBA,fnc,var1) //CBA Function
#define FNC(var1) DOUBLES(TRIPLES(GRAD,GUNDOG,fnc),var1);

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
