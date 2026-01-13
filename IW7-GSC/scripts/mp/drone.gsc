/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\drone.gsc
*********************************************/

init() {
  thread func_13962();
  level.var_5CC0 = [];
  level.var_5CC0["ability_pet_1"] = spawnStruct();
  level.var_5CC0["ability_pet_1"].var_1088C = ::func_10610;
  level.var_5CC0["ability_pet_2"] = spawnStruct();
  level.var_5CC0["ability_pet_2"].var_1088C = ::func_10611;
  level.var_5CC0["ability_pet_3"] = spawnStruct();
  level.var_5CC0["ability_pet_3"].var_1088C = ::func_10612;
  level.var_5CC0["ability_pet_4"] = spawnStruct();
  level.var_5CC0["ability_pet_4"].var_1088C = ::func_10613;
}

func_13962() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread func_D2FA();
  }
}

func_D2FA() {
  self endon("disconnect");
  for(;;) {
    if(getdvarint("scr_drone_pet_debug_spawn") != 0) {
      self waittill("spawned_player");
      var_0 = getdvarint("scr_drone_pet_debug_spawn");
      var_1 = "select_ability";
    } else {
      self waittill("luinotifyserver", var_1, var_0);
      if(var_1 != "select_ability") {
        continue;
      }
    }

    if(!scripts\mp\killstreaks\_ball_drone::tryuseballdrone(0, "ball_drone_ability_pet")) {
      continue;
    }

    self.balldrone.var_151C = var_0;
    var_2 = "ability_pet_" + var_0 + 1;
    var_3 = level.var_5CC0[var_2];
    self[[var_3.var_1088C]]();
  }
}

func_10610() {
  level.supportcranked = 1;
  level.crankedbombtimer = 30;
  scripts\mp\utility::func_B2AC("");
}

func_10611() {
  self.health = 200;
  self.movespeedscaler = 0.6;
  scripts\mp\weapons::updatemovespeedscale();
}

func_10612() {
  var_0 = self getcurrentprimaryweapon();
  if(var_0 == "none") {
    var_0 = scripts\engine\utility::getlastweapon();
  }

  if(!self hasweapon(var_0)) {
    var_0 = scripts\mp\killstreaks\_utility::getfirstprimaryweapon();
  }

  scripts\mp\utility::_takeweapon(var_0);
  scripts\mp\utility::_giveweapon("iw7_knife_mp", 0);
  scripts\mp\utility::_switchtoweapon("iw7_knife_mp");
  thread func_94A9();
}

func_10613() {
  var_0 = self getcurrentprimaryweapon();
  if(var_0 == "none") {
    var_0 = scripts\engine\utility::getlastweapon();
  }

  if(!self hasweapon(var_0)) {
    var_0 = scripts\mp\killstreaks\_utility::getfirstprimaryweapon();
  }

  scripts\mp\utility::_takeweapon(var_0);
  scripts\mp\utility::_giveweapon("iw7_knife_mp", 0);
  scripts\mp\utility::_switchtoweapon("iw7_knife_mp");
  self.movespeedscaler = 1.5;
}

func_94A9() {
  self endon("disconnect");
  self endon("death");
  for(;;) {
    var_0 = self getcurrentoffhand();
    self givemaxammo(var_0);
    wait(2);
  }
}