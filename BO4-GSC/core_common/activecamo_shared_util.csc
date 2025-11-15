/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\activecamo_shared_util.csc
**************************************************/

#namespace activecamo;

function_385ef18d(camoweapon) {
  assert(isDefined(camoweapon));
  var_e69cf15d = function_3786d342(camoweapon);

  if(isDefined(var_e69cf15d) && var_e69cf15d != level.weaponnone) {
    camoweapon = var_e69cf15d;
  }

  return camoweapon;
}

function_c14cb514(weapon) {
  if(isDefined(level.var_f06de157)) {
    return [[level.var_f06de157]](weapon);
  }

  if(isDefined(weapon)) {
    if(level.weaponnone != weapon) {
      activecamoweapon = function_385ef18d(weapon);

      if(activecamoweapon.isaltmode) {
        if(isDefined(activecamoweapon.altweapon) && level.weaponnone != activecamoweapon.altweapon) {
          activecamoweapon = activecamoweapon.altweapon;
        }
      }

      if(isDefined(activecamoweapon.rootweapon) && level.weaponnone != activecamoweapon.rootweapon) {
        return activecamoweapon.rootweapon;
      }

      return activecamoweapon;
    }
  }

  return weapon;
}