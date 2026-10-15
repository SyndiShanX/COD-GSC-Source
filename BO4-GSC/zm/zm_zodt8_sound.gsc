/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_zodt8_sound.gsc
***********************************************/

#include scripts\core_common\struct;

#namespace zodt8_sound;

main() {
  level.var_45b0f2f3 = &function_45b0f2f3;
}

function_45b0f2f3(str_weapon_name) {
  if(!isDefined(str_weapon_name)) {
    return undefined;
  }

  str_weapon = undefined;

  switch (str_weapon_name) {
    case #"ww_tricannon_fire_t8":
    case #"ww_tricannon_earth_t8":
    case #"ww_tricannon_t8_upgraded":
    case #"ww_tricannon_air_t8_upgraded":
    case #"ww_tricannon_earth_t8_upgraded":
    case #"ww_tricannon_fire_t8_upgraded":
    case #"ww_tricannon_water_t8_upgraded":
    case #"ww_tricannon_water_t8":
    case #"ww_tricannon_t8":
    case #"ww_tricannon_air_t8":
      str_weapon = "wonder";
      break;
  }

  return str_weapon;
}