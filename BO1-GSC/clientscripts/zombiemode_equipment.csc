/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\zombiemode_equipment.csc
**************************************************/

#include clientscripts\_utility;

is_equipment_included(equipment_name) {
  if(!isDefined(level._included_equipment)) {
    return false;
  }
  for (i = 0; i < level._included_equipment.size; i++) {
    if(equipment_name == level._included_equipment[i]) {
      return true;
    }
  }
  return false;
}
include_equipment(equipment) {
  if(!isDefined(level._included_equipment)) {
    level._included_equipment = [];
  }
  level._included_equipment[level._included_equipment.size] = equipment;
}