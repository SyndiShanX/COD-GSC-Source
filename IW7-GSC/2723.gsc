/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2723.gsc
***************************************/

init() {
  thread func_13962();
  level.func_5CC0 = [];
  level.func_5CC0["ability_pet_1"] = spawnStruct();
  level.func_5CC0["ability_pet_1"].func_1088C = ::func_10610;
  level.func_5CC0["ability_pet_2"] = spawnStruct();
  level.func_5CC0["ability_pet_2"].func_1088C = ::func_10611;
  level.func_5CC0["ability_pet_3"] = spawnStruct();
  level.func_5CC0["ability_pet_3"].func_1088C = ::func_10612;
  level.func_5CC0["ability_pet_4"] = spawnStruct();
  level.func_5CC0["ability_pet_4"].func_1088C = ::func_10613;
}

func_13962() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_D2FA();
  }
}

func_D2FA() {
  self endon("disconnect");

  for(;;) {
    if(getdvarint("scr_drone_pet_debug_spawn") != 0) {
      self waittill("spawned_player");
      var_00 = getdvarint("scr_drone_pet_debug_spawn");
      var_01 = "select_ability";
    } else {
      self waittill("luinotifyserver", var_01, var_00);

      if(var_01 != "select_ability") {
        continue;
      }
    }

    if(!scripts\mp\killstreaks\ball_drone::tryuseballdrone(0, "ball_drone_ability_pet")) {
      continue;
    }
    self.balldrone.func_151C = var_00;
    var_02 = "ability_pet_" + (var_00 + 1);
    var_03 = level.func_5CC0[var_02];
    self[[var_3.func_1088C]]();
  }
}

func_10610() {
  level.supportcranked = 1;
  level.crankedbombtimer = 30.0;
  scripts\mp\utility\game::func_B2AC("");
}

func_10611() {
  self.health = 200;
  self.movespeedscaler = 0.6;
  scripts\mp\weapons::updatemovespeedscale();
}

func_10612() {
  var_00 = self getcurrentprimaryweapon();

  if(var_00 == "none") {
    var_00 = scripts\engine\utility::getlastweapon();
  }

  if(!self hasweapon(var_00)) {
    var_00 = scripts\mp\killstreaks\utility::getfirstprimaryweapon();
  }

  scripts\mp\utility\game::_takeweapon(var_00);
  scripts\mp\utility\game::_giveweapon("iw7_knife_mp", 0);
  scripts\mp\utility\game::_switchtoweapon("iw7_knife_mp");
  thread func_94A9();
}

func_10613() {
  var_00 = self getcurrentprimaryweapon();

  if(var_00 == "none") {
    var_00 = scripts\engine\utility::getlastweapon();
  }

  if(!self hasweapon(var_00)) {
    var_00 = scripts\mp\killstreaks\utility::getfirstprimaryweapon();
  }

  scripts\mp\utility\game::_takeweapon(var_00);
  scripts\mp\utility\game::_giveweapon("iw7_knife_mp", 0);
  scripts\mp\utility\game::_switchtoweapon("iw7_knife_mp");
  self.movespeedscaler = 1.5;
}

func_94A9() {
  self endon("disconnect");
  self endon("death");

  for(;;) {
    var_00 = self getcurrentoffhand();
    self givemaxammo(var_00);
    wait 2.0;
  }
}