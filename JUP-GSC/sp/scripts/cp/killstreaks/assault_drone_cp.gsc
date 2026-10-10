/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\killstreaks\assault_drone_cp.gsc
**********************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace assault_drone_cp;

function function_c260cd16a5c5a2d9() {
  level thread function_344254816bb001eb();
}

function function_344254816bb001eb() {
  waitframe();
  level.helperdronesettings["assault_drone"].var_cb2c3fe0819193eb = 36000000;
  level.helperdronesettings["assault_drone"].var_1947a47c2174d02c = 0;
}

function function_28fc7edb00dd6601(assaultdrone) {
  flag_clear("player_demigod");

  if(!isDefined(self.lastdroppableweaponobj) || !self hasweapon(self.lastdroppableweaponobj)) {
    lastweaponobj = "iw9_me_fists_mp";
  } else {
    lastweaponobj = scripts\cp_mp\utility\weapon_utility::restoreweaponstates(self.lastdroppableweaponobj);
  }

  _switchtoweaponimmediate(lastweaponobj);
  currentweapon = self getcurrentweapon();

  if(isDefined(currentweapon)) {
    _takeweapon(currentweapon);
  }
}