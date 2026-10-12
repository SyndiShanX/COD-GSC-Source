/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\vehicle_drop.gsc
***********************************************/

#using scripts\common\values;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\superdeploy;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#using scripts\mp\equipment\advanced_supply_drop;
#using scripts\mp\gametypes\br_armory_kiosk;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_gametype_truckwar;
#using scripts\mp\outofbounds;
#using scripts\mp\supers;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\usability;
#namespace vehicle_drop;

function function_172a790b85bbc40b() {
  thread function_369cd45b595b9c13();
  return true;
}

function function_369cd45b595b9c13() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  waitframe();
  superinfo = scripts\mp\supers::getcurrentsuper();

  if(isDefined(level.var_27f78817b59dfe32)) {
    superinfo.var_fb58a31c756db4cc = level.var_27f78817b59dfe32;
  }

  scripts\common\values::set("giveDropWeapon", "killstreaks", 0);
  deployresult = scripts\cp_mp\superdeploy::function_f3a5a94b1d50ed38(superinfo, makeweapon("deploy_vehicle_drop_mp"), "grenade_fire");
  scripts\common\values::reset_all("giveDropWeapon");

  if(istrue(deployresult)) {
    self notify("super_finished_with_deploy_weapon");

    if(issharedfuncdefined("supers", "superUseFinished")) {
      [[getsharedfunc("supers", "superUseFinished")]]();
      scripts\cp_mp\challenges::function_d997435895422ecc("super_vehicle_drop", 0);
    }

    return;
  }

  if(issharedfuncdefined("hud", "showErrorMessage") && !scripts\cp_mp\utility\game_utility::ismagellanmode()) {
    self[[getsharedfunc("hud", "showErrorMessage")]]("MP/CANNOT_USE_GENERIC");
  }

  if(issharedfuncdefined("supers", "superUseFinished")) {
    [[getsharedfunc("supers", "superUseFinished")]](1);
  }
}

function function_e203a65ecb5c85c4(grenade) {
  player = self;
  player endon("disconnect");
  player endon("vehicle_drop_grenade_explode");
  grenade waittill("death");
  waitframe();

  if(isDefined(player.super)) {
    player scripts\mp\supers::superusefinished(1);
  }
}

function function_604ed6f2f8323ea6(grenade) {
  self endon("disconnect");
  level endon("game_ended");
  grenade endon("explode_end");

  if(!isDefined(self)) {
    return;
  }

  if(scripts\mp\gametypes\br_gametype_truckwar::function_81c029669130c0d4()) {}

  grenade thread scripts\mp\utility\script::notifyafterframeend("death", "explode_end");
  thread function_e203a65ecb5c85c4(grenade);

  if(isDefined(level.var_e3ccf0898a949bec)) {
    level thread scripts\mp\equipment\advanced_supply_drop::function_22740c19d22b8b6e(self, grenade);
  }

  grenade waittill("explode", position);
  self notify("vehicle_drop_grenade_explode");

  if(scripts\mp\outofbounds::ispointinoutofbounds(position)) {
    if(isDefined(grenade)) {
      grenade delete();
    }

    if(isDefined(self.super)) {
      scripts\mp\supers::superusefinished(1);
    }

    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("SUPER_MP/VEHICLE_DROP_CANNOT_USE_OOB");
    }

    return;
  }

  var_fb932f46ef5ec56 = scripts\mp\utility\game::getsubgametype() == "truckwar";
  spawndata = spawnStruct();
  spawndata.origin = position;
  spawndata.angles = self.angles;
  spawndata.var_427538f5a2ad4f8b = 1;
  spawndata.var_ec76ffdbe2f37c5b = 1;
  spawndata.var_65da0a245b653cc = 1;
  spawndata.var_d04816fe2f5bcee6 = 1;
  itemdata = spawnStruct();
  itemdata.ref = "veh9_mil_lnd_mrap";

  if(!scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_checkspawnclearance(spawndata.origin, itemdata.ref)) {
    if(isDefined(grenade)) {
      grenade delete();
    }

    if(isDefined(self.super)) {
      scripts\mp\supers::superusefinished(1);
    }

    if(issharedfuncdefined("hud", "showErrorMessage")) {
      self[[getsharedfunc("hud", "showErrorMessage")]]("SUPER_MP/VEHICLE_DROP_CANNOT_USE_OOB");
    }
  }

  self notify("vehicle_drop_success");
  thread scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("truckwar_vehicle_deploying", level.teamdata[self.team]["players"]);
  thread scripts\mp\gametypes\br_armory_kiosk::function_3f45b3c575ec001b(itemdata, spawndata, var_fb932f46ef5ec56);
  return 1;
}

function function_852ea8e204596ed0(equipmentref) {
  return isDefined(equipmentref) && equipmentref == "equip_advanced_vehicle_drop";
}