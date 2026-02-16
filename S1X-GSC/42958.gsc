/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42958.gsc
**************************************/

init() {
  level.killstreakfuncs["ripped_turret"] = ::tryuserippedturret;
  level.killstreakwieldweapons["turretheadmg_mp"] = "ripped_turret";
  level.killstreakwieldweapons["turretheadenergy_mp"] = "ripped_turret";
  level.killstreakwieldweapons["turretheadrocket_mp"] = "ripped_turret";
  level thread onplayerconnect();
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    level thread onplayerspawned(var_0);
  }
}

onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("killstreakUseWaiter");
    level thread updateammo(var_0);
  }
}

updateammo(var_0) {
  var_0 setclientomnvar("ui_energy_ammo", 1);

  if(!isDefined(var_0.pers["rippableSentry"])) {
    return;
  }
  var_1 = undefined;

  if(var_0 hasweapon("turretheadmg_mp")) {
    var_1 = "turretheadmg_mp";
  } else if(var_0 hasweapon("turretheadenergy_mp")) {
    var_1 = "turretheadenergy_mp";
  } else if(var_0 hasweapon("turretheadrocket_mp")) {
    var_1 = "turretheadrocket_mp";
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_0 playergetrippableammo();

  if(isturretenergyweapon(var_1)) {
    var_3 = getammoforturretweapontype(var_1);
    var_4 = var_2 / var_3;
    var_0 setclientomnvar("ui_energy_ammo", var_4);
  } else {
    var_0 setweaponammoclip(var_1, var_2);
  }
}

tryuserippedturret(var_0, var_1) {
  var_2 = tryuserippedturretinternal(var_1);

  if(var_2) {
    maps\mp\_matchdata::logkillstreakevent("ripped_turret", self.origin);
  }

  return var_2;
}

tryuserippedturretinternal(var_0) {
  if(maps\mp\_utility::isusingremote()) {
    return 0;
  }

  var_1 = playersetuprecordedturrethead(var_0);
  return var_1;
}

playergiveturrethead(var_0) {
  maps\mp\killstreaks\_killstreaks::givekillstreak("ripped_turret", 0, 0, self, [var_0]);

  if(!isDefined(self.pers["rippableSentry"])) {
    self.pers["rippableSentry"] = spawnStruct();
  }

  var_1 = getammoforturretweapontype(var_0);
  playerrecordrippableammo(var_1);

  if(!common_scripts\utility::is_player_gamepad_enabled()) {
    self notify("streakUsed1");
    waittillframeend;
  }

  self switchtoweapon(var_0);
}

playermoduleshaverippedturret(var_0) {
  foreach(var_2 in var_0) {
    if(var_2 == "turretheadenergy_mp" || var_2 == "turretheadrocket_mp" || var_2 == "turretheadmg_mp") {
      return 1;
    }
  }

  return 0;
}

playersetuprecordedturrethead(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 = playergetrippableammo();
  var_2 = var_0[0];

  if(!isturretenergyweapon(var_2)) {
    self setweaponammoclip(var_2, var_1);
  }

  self setweaponammostock(var_2, 0);
  thread playermonitorweaponswitch(var_2);

  if(isturretenergyweapon(var_2)) {
    thread playersetupturretenergybar(var_2, var_1);
  } else {
    thread playertrackturretammo(var_2);
  }

  common_scripts\utility::waittill_any_return("death", "rippable_complete", "rippable_switch");

  if(!isDefined(self)) {
    return 0;
  }

  if(isturretenergyweapon(var_2)) {
    self notifyonplayercommandremove("fire_turret_weapon", "+attack");
    self notifyonplayercommandremove("fire_turret_weapon", "+attack_akimbo_accessible");
  }

  var_3 = !playerhasrippableturretinfo();
  return var_3;
}

playermonitorweaponswitch(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("rippable_complete");
  var_1 = self getcurrentweapon();

  while(var_1 == var_0 || maps\mp\_utility::isbombsiteweapon(var_1)) {
    self waittill("weapon_change", var_1);
  }

  if(maps\mp\_utility::iskillstreakweapon(var_1)) {
    self.justswitchedtokillstreakweapon = var_1;
  }

  self notify("rippable_switch");
}

playertrackturretammo(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("rippable_switch");

  for(;;) {
    var_1 = self getweaponammoclip(var_0);
    playerrecordrippableammo(var_1);

    if(var_1 == 0) {
      playerclearrippableturretinfo();
      self notify("rippable_complete");
      return;
    }

    waitframe();
  }
}

playerhasturretheadweapon() {
  if(playerhasrippableturretinfo()) {
    return 1;
  }

  var_0 = self getweaponslistprimaries();

  foreach(var_2 in var_0) {
    if(var_2 == "turretheadenergy_mp" || var_2 == "turretheadrocket_mp" || var_2 == "turretheadmg_mp") {
      return 1;
    }
  }

  return 0;
}

getammoforturretweapontype(var_0) {
  if(var_0 == "turretheadmg_mp") {
    return 100;
  } else if(var_0 == "turretheadrocket_mp") {
    return 6;
  } else {
    return getfullenergy();
  }
}

isturretenergyweapon(var_0) {
  return var_0 == "turretheadenergy_mp";
}

playersetupturretenergybar(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("rippable_switch");
  var_2 = getfullenergy();
  self notifyonplayercommand("fire_turret_weapon", "+attack");
  self notifyonplayercommand("fire_turret_weapon", "+attack_akimbo_accessible");
  var_1 = playergetrippableammo();
  var_3 = var_1 / var_2;
  self setclientomnvar("ui_energy_ammo", var_3);

  for(;;) {
    if(!self attackButtonPressed()) {
      self waittill("fire_turret_weapon");
    }

    if(self isreloading() || self getcurrentweapon() != "turretheadenergy_mp" || !self isfiring() || self isusingoffhand()) {
      waitframe();
      continue;
    }

    var_1 = playergetrippableammo();
    var_1 = clamp(var_1 - 1, 0, getfullenergy());
    var_3 = var_1 / var_2;
    self setclientomnvar("ui_energy_ammo", var_3);

    if(var_1 <= 0) {
      var_4 = self getweaponslistprimaries();

      if(var_4.size > 0) {
        self switchtoweapon(var_4[0]);
      } else {
        self takeweapon(var_0);
      }

      playerclearrippableturretinfo();
      self notify("rippable_complete");
      return;
    }

    waitframe();
    playerrecordrippableammo(var_1);
  }
}

getfullenergy() {
  return 200.0;
}

playergetrippableammo() {
  return self.pers["rippableSentry"].ammo;
}

playerrecordrippableammo(var_0) {
  self.pers["rippableSentry"].ammo = var_0;
}

playerhasrippableturretinfo() {
  return isDefined(self.pers["rippableSentry"]) && playergetrippableammo() > 0;
}

playerclearrippableturretinfo() {
  self.pers["rippableSentry"] = undefined;
}