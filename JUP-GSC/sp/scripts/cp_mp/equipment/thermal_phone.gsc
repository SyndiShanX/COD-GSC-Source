/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\equipment\thermal_phone.gsc
*****************************************************/



#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#namespace thermal_phone;

function function_7c59b9d44aff939b() {}

function function_d7b50d4592cd5421(equipmentref, equipmentslot, variantid) {
  thread function_d985ced7c32c7258();
}

function function_d985ced7c32c7258() {
  self endon("death_or_disconnect");
  self endon("thermal_phone_taken");

  while(true) {
    self waittill("grenade_pullback", objweapon);

    if(isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "thermal_phone_mp") {
      if(isDefined(level.var_668566d171e33358)) {
        [[level.var_668566d171e33358]](self);
      }
    }
  }
}

function function_e49fa2736f79e04b(equipmentref, equipmentslot) {
  self notify("thermal_phone_taken");
}

function function_230403b8cf5ea1e8(grenade) {
  if(isDefined(grenade)) {
    grenade delete();
  }

  if(isDefined(level.var_5a712c9d76830012)) {
    [[level.var_5a712c9d76830012]](self);
  }

  self notify("thermal_phone_finished");
}