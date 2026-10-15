/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: weapons\weapons.csc
***********************************************/

#include scripts\core_common\clientfield_shared;

#namespace weapons;

init_shared() {
  level.weaponnone = getweapon(#"none");
  clientfield::register("clientuimodel", "hudItems.pickupHintWeaponIndex", 1, 10, "int", undefined, 0, 0);
}