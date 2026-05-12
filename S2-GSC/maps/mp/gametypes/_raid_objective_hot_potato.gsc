/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_raid_objective_hot_potato.gsc
************************************************************/

hotpotatoobjectiveinit(param_00) {
  if(!lib_04FF::func_694B()) {
    level.var_611["hill_thermite_grenade_exp"] = loadfx("vfx/map/hill/hill_thermite_grenade_exp");
    level.var_611["hill_thermite_grenade_burn"] = loadfx("vfx/map/hill/hill_thermite_grenade_burn");
    level.var_611["hill_thermite_grenade_ignite"] = loadfx("vfx/map/hill/hill_thermite_grenade_ignite");
  }

  lib_04FF::func_6934(self);
  self.var_6940 = ::hotpotatoobjectivecenter;
  var_01 = [0.1, 0.3, 0.5, 1, 2, 3, 5, 7.5, 10, 12.5, 15, 20, 25, 60];
  lib_04FF::func_6965("objectiveScoreGoal", 10);
  lib_04FF::func_6965("objectiveCaptureScore", 2);
  lib_04FF::func_6965("objectiveCatchScore", 1);
  lib_04FF::func_6963("bombPickupTime", 0.25);
  lib_04FF::func_6966("bombGrenadeWeapon", "raid_hot_potato_mp");
  lib_04FF::func_6963("bombThrowForce", 42000);
  lib_04FF::func_6963("bombThrowMovementForce", 6000);
  var_02 = [6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];
  lib_04FF::func_6965("useSourceTextIndex", 14, var_02);
  lib_04FF::func_6965("useDestTextIndex", 15, var_02);
  level.var_695E[level.var_695E.size] = ::hotpotatoobjectiveonplayerkilled;
  self.potatocatchpoints = [];
  self.potatodeliverypoints = [];
  self.potatopickuppoints = [];
  self.objectivehelth = 0;
  thread hotpotatoobjectivethink();
  thread hotpotatoobjectiveupdate();
  var_03 = lib_04FF::func_45D0("bombGrenadeWeapon");
  lib_0502::func_791A(var_03);
  lib_0505::func_9AE(var_03);
}

hotpotatoobjectivethink() {
  lib_04FF::func_6983(self.var_695A);
  self.objectivehelth = 0;
  thread onhotpotatoobjectivecompleted();
  for(;;) {
    self waittill("objectiveHit");
    var_00 = self.objectivehelth / lib_04FF::func_45D0("objectiveScoreGoal");
    self.potatocatchpoints[0] lib_04FF::func_8615(10000 - 10000 * var_00);
    if(self.objectivehelth >= lib_04FF::func_45D0("objectiveScoreGoal")) {
      lib_04FF::func_6935(self.var_695A);
      return;
    }
  }
}

hotpotatoobjectiveupdate() {
  level endon("game_ended");
  level endon(lib_04FF::func_6937(self.var_695A));
  for(;;) {
    lib_04FF::func_6981(self.var_695A);
    wait 0.05;
  }
}

onhotpotatoobjectivecompleted() {
  lib_04FF::func_6982(self.var_695A);
  level.var_695E = common_scripts\utility::func_F93(level.var_695E, ::onhotpotatoobjectivecompleted);
  foreach(var_01 in level.var_744A) {
    var_01 takehotpotato(self.var_79AD);
  }

  foreach(var_04 in self.potatocatchpoints) {
    var_04 common_scripts\utility::func_9D9F();
  }

  foreach(var_04 in self.potatodeliverypoints) {
    var_04 common_scripts\utility::func_9D9F();
  }

  foreach(var_04 in self.potatopickuppoints) {
    var_04 common_scripts\utility::func_9D9F();
  }
}

hotpotatodelivertrigger(param_00) {
  lib_04FF::func_6983(self.var_695A);
  self.potatodeliverypoints[self.potatodeliverypoints.size] = param_00;
  var_01 = lib_04FF::func_45CE(param_00);
  var_02 = [];
  var_03 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, var_02, var_01, 0, 1);
  lib_04FF::func_6942(var_03);
  param_00.var_A223 = var_03;
  var_03 maps\mp\gametypes\_gameobjects::func_C30("friendly");
  var_03 maps\mp\gametypes\_gameobjects::func_8A60("none");
  var_03 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_RESUPPLY_USING_DEST");
  var_03 maps\mp\gametypes\_gameobjects::func_8A5A(lib_04FF::func_45D0("bombPickupTime"));
  var_03.var_6BBF = ::onhotpotatodelivered;
  var_03.var_1F84 = ::canusepotatodelivertrigger;
  var_03.var_A23E = 8;
  var_03 maps\mp\gametypes\_gameobjects::func_6B52(1);
  lib_04FF::func_6982(self.var_695A);
  var_03 lib_04FF::func_7CCA();
  var_03 maps\mp\gametypes\_gameobjects::func_2F93();
  var_03 maps\mp\gametypes\_gameobjects::deleteuseobjectobjectives();
  waittillframeend;
  var_03 maps\mp\gametypes\_gameobjects::func_2D58();
  param_00 delete();
}

canusepotatodelivertrigger(param_00) {
  return common_scripts\utility::func_562E(param_00.hotpotato);
}

onhotpotatodelivered(param_00) {
  self.var_79AD.objectivehelth = clamp(self.var_79AD.objectivehelth + self.var_79AD lib_04FF::func_45D0("objectiveCaptureScore"), 0, self.var_79AD lib_04FF::func_45D0("objectiveScoreGoal"));
  self.var_79AD notify("objectiveHit");
  param_00 takehotpotato(self.var_79AD);
  var_01 = param_00.var_12C["team"];
  var_02 = maps\mp\_utility::func_45DE(var_01);
  if(self.var_79AD.objectivehelth < self.var_79AD lib_04FF::func_45D0("objectiveScoreGoal")) {
    maps\mp\_utility::func_74D9("mp_war_stinger_pos", var_01);
    maps\mp\_utility::func_74D9("mp_war_stinger_neg", var_02);
  }
}

hotpotatocatchtrigger(param_00) {
  lib_04FF::func_6983(self.var_695A);
  self.potatocatchpoints[self.potatocatchpoints.size] = param_00;
  var_01 = lib_04FF::func_45D0("objectiveScoreGoal");
  param_00.var_A23F = 10000;
  param_00 lib_04FF::func_990(param_00.var_116, undefined, undefined, 10000, 4, 0, 1, 0, 1);
  param_00 lib_04FF::func_8615(10000);
  lib_04FF::func_6982(self.var_695A);
  param_00 common_scripts\utility::func_9D9F();
}

hotpotatoobjectiveimagetimer(param_00) {
  self endon("death");
  level endon("game_ended");
  wait 0.05;
  var_01 = self.var_6896 * 1000;
  param_00.var_A23F = var_01;
  param_00 lib_04FF::func_990(self.var_116, undefined, (0, 0, 0), var_01, 110, 0, 1, 0, 1, 0, undefined, undefined, undefined, undefined, self.var_6896);
  param_00 lib_04FF::func_860A(110);
  var_02 = self.var_6896;
  for(;;) {
    if(self.var_6896 != var_02) {
      var_03 = var_02 - self.var_6896 * 1000;
      param_00 lib_04FF::func_8615(var_03);
    }

    self waittill("prop_destroyed");
  }
}

hotpotatopickupzonetrigger(param_00) {
  param_00 common_scripts\utility::func_9D9F();
  lib_04FF::func_6983(self.var_695A);
  param_00 common_scripts\utility::func_9DA3();
  self.potatopickuppoints[self.potatopickuppoints.size] = param_00;
  var_01 = lib_04FF::func_45CE(param_00);
  var_02 = [];
  var_03 = maps\mp\gametypes\_gameobjects::func_2837(game["attackers"], param_00, var_02, var_01, 0, 1);
  lib_04FF::func_6942(var_03);
  param_00.var_A223 = var_03;
  var_03 maps\mp\gametypes\_gameobjects::func_8A60("friendly");
  var_03 maps\mp\gametypes\_gameobjects::func_C30("friendly");
  var_03 maps\mp\gametypes\_gameobjects::func_8A57(&"RAIDS_USE_PLACE_EXPLOSIVE");
  var_03 maps\mp\gametypes\_gameobjects::func_8A59(&"RAIDS_USING_PLACE_EXPLOSIVE");
  var_03 maps\mp\gametypes\_gameobjects::func_8A5A(lib_04FF::func_45D0("bombPickupTime"));
  var_03.var_1F84 = ::canusepotatopickuptrigger;
  var_03.var_6BBF = ::onpotatopickupzoneuse;
  var_03.var_A414 = 1;
  var_03.var_A23E = 9;
  var_04 = lib_0502::func_4518("grab_defend", param_00.var_81E1);
  var_03 thread lib_04FF::func_990(param_00.var_116, undefined, var_01, lib_04FF::func_45D0("bombPickupTime") * 1000, var_04, 0, 1);
  var_03 lib_04FF::func_860A(var_04, param_00.var_81E1);
  lib_04FF::func_6982(self.var_695A);
  var_03 common_scripts\utility::func_9D9F();
  waittillframeend;
  param_00 delete();
}

canusepotatopickuptrigger(param_00) {
  return !common_scripts\utility::func_562E(param_00.hotpotato);
}

onpotatopickupzoneuse(param_00) {
  param_00 givehotpotato(self.var_79AD);
}

givehotpotato(param_00) {
  var_01 = self;
  if(!var_01.var_1A7 == game["defenders"] && !common_scripts\utility::func_562E(var_01.hotpotato)) {
    var_01.hotpotato = 1;
    var_02 = param_00 lib_04FF::func_45D0("bombGrenadeWeapon");
    var_01.potatoicon = var_01 maps\mp\gametypes\_hud_util::func_280B("icon_raid_objective_resupply_carry", 50, 50);
    var_01.potatoicon maps\mp\gametypes\_hud_util::func_8707("BOTTOM RIGHT", "BOTTOM RIGHT", 0, -90);
    maps\mp\_utility::func_642(var_02);
    maps\mp\_utility::func_6D0(4, "weapon", var_02);
    var_01 thread manualthrowthink_potato(param_00);
    foreach(var_04 in param_00.potatopickuppoints) {
      var_04.var_A223 lib_04FF::func_8610(var_01);
    }
  }
}

takehotpotato(param_00, param_01) {
  var_02 = self;
  if(isDefined(param_01)) {
    wait(param_01);
  }

  if(common_scripts\utility::func_562E(var_02.hotpotato)) {
    var_02.hotpotato = 0;
    var_03 = param_00 lib_04FF::func_45D0("bombGrenadeWeapon");
    if(var_02 getcurrentweapon() == var_03) {
      var_04 = var_02 getweaponslist("primary");
      var_02 switchtoweaponimmediate(var_04[0]);
    }

    self takeweapon(var_03);
    maps\mp\killstreaks\_killstreaks::func_A170();
    if(isDefined(var_02.potatoicon)) {
      var_02.potatoicon maps\mp\gametypes\_hud_util::func_2DCC();
    }

    foreach(var_06 in param_00.potatopickuppoints) {
      var_06.var_A223 lib_04FF::set3diconsshowtoplayer(var_02);
    }

    var_02 notify("removePotato");
  }
}

hotpotatoobjectiveonplayerkilled(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = self;
}

hotpotatoobjectivecenter() {
  var_00 = lib_0502::func_207C("hotPotatoDeliveryZone");
  return var_00[0];
}

store_players_grenades_potato(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("drop_object");
  while(self method_8126()) {
    wait 0.05;
  }

  if(!isDefined(self.var_9426)) {
    self.var_9426 = [];
  }

  var_01 = spawnStruct();
  var_01.var_109 = self method_834A();
  var_01.var_2420 = self getweaponammoclip(var_01.var_109, "right");
  var_01.var_93AF = self getweaponammostock(var_01.var_109);
  self.var_9426["lethal_offhand"] = var_01;
  var_02 = spawnStruct();
  var_02.var_109 = self method_831F();
  var_02.var_2420 = self getweaponammoclip(var_02.var_109, "right");
  var_02.var_93AF = self getweaponammostock(var_02.var_109);
  self.var_9426["tactical_offhand"] = var_02;
  if(var_01.var_109 != "none") {
    self takeweapon(var_01.var_109);
  }

  if(var_02.var_109 != "none") {
    self takeweapon(var_02.var_109);
  }

  var_03 = param_00 lib_04FF::func_45D0("flagGrenadeWeapon");
  self method_8349(var_03);
  self giveweapon(var_03);
  self method_82FA(var_03, 1, "right");
  self setweaponammostock(var_03, 1);
}

restore_players_grenades_potato(param_00, param_01) {
  if(isDefined(param_01)) {
    wait(param_01);
  }

  var_02 = param_00 lib_04FF::func_45D0("flagPickupWeapon");
  if(self hasweapon(var_02)) {
    self takeweapon(var_02);
  }

  var_03 = param_00 lib_04FF::func_45D0("flagGrenadeWeapon");
  if(self hasweapon(var_03)) {
    self takeweapon(var_03);
  }

  if(!isDefined(self.var_9426)) {
    return;
  }

  var_04 = self.var_9426["lethal_offhand"];
  if(var_04.var_109 != "none") {
    self method_8349(var_04.var_109);
    self giveweapon(var_04.var_109);
    self method_82FA(var_04.var_109, var_04.var_2420, "right");
    self setweaponammostock(var_04.var_109, var_04.var_93AF);
  }

  var_05 = self.var_9426["tactical_offhand"];
  if(var_05.var_109 != "none") {
    self method_831E(var_05.var_109);
    self giveweapon(var_05.var_109);
    self method_82FA(var_05.var_109, var_05.var_2420, "right");
    self setweaponammostock(var_05.var_109, var_05.var_93AF);
  }
}

manualthrowthink_potato(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("removePotato");
  self endon("death");
  for(;;) {
    self waittill("grenade_fire", var_01, var_02);
    if(!isvalidpotato(var_02)) {
      continue;
    }

    thread throwphysicspotato(self, var_01, param_00);
    takehotpotato(param_00, 0.5);
    break;
  }
}

isvalidpotato(param_00) {
  switch (param_00) {
    case "raid_hot_potato_mp":
    case "raid_carryflag_physics_mp":
    case "raid_carryflag_mp":
      return 1;

    default:
      return 0;
  }
}

throwphysicspotato(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_01.var_116);
  var_03 setModel("ger_jerry_can_01_gas_raid_projectile");
  var_03.var_1A7 = param_00.var_1A7;
  var_03.var_117 = param_00;
  var_03 setdamagecallbackon(1);
  var_03.var_29B5 = ::potatoobjectcallback;
  var_03 setCanDamage(1);
  var_03.var_BC = 999999;
  var_03.var_FB = 999999;
  var_04 = -8;
  var_05 = 37000;
  var_06 = param_00 getangles();
  var_06 = var_06 + (var_04, 0, 0);
  var_06 = (clamp(var_06[0], -85, 85), var_06[1], var_06[2]);
  var_07 = anglesToForward(var_06);
  var_08 = param_00 getvelocity();
  var_09 = vectornormalize((var_07[0], var_07[1], 0));
  var_0A = vectornormalize((var_08[0], var_08[1], 0));
  var_0B = 0;
  if(vectordot(var_09, var_0A) >= 0.42 && length(var_08) > 120) {
    var_0B = 6000;
  }

  var_03.var_116 = param_01.var_116;
  var_03 thread detonateatrest();
  var_03 thread potatobadtriggerwatch();
  var_03 thread potatocatchtriggerwatch(param_02);
  var_03 potatophysicslaunch(var_07 * var_05 + var_0B, param_00);
}

potatophysicslaunch(param_00, param_01) {
  if(isDefined(param_01)) {
    var_02 = param_01.var_1D;
    self.var_1D = (0, var_02[1] + 250, 120);
  }

  self physicslaunchserver(self.var_116, param_00);
}

potatoobjectcallback(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!isDefined(param_01) || !isDefined(param_01.var_1A7) || param_01.var_3A == "worldspawn" || !isPlayer(param_01)) {
    return;
  }

  if(param_04 == "MOD_EXPLOSIVE") {
    return;
  }

  if(self.var_1A7 == param_01.var_1A7 && param_01 != self.var_117) {
    return;
  }

  param_01 maps\mp\gametypes\_damagefeedback::func_A102("standard");
  lib_04F3::func_79CB("mp_war_bomb_explo", self.var_116);
  playFX(common_scripts\utility::func_44F5("hill_thermite_grenade_exp"), self.var_116);
  physicsexplosionsphere(self.var_116, 300, 50, 2);
  self delete();
}

detonateatrest() {
  self endon("death");
  self waittill("physics_finished");
  playFX(common_scripts\utility::func_44F5("hill_thermite_grenade_exp"), self.var_116);
  physicsexplosionsphere(self.var_116, 300, 50, 2);
  self delete();
}

potatocatchtriggerwatch(param_00) {
  level endon("game_ended");
  self endon("death");
  for(;;) {
    self waittill("physics_impact", var_01, var_02, var_03, var_04);
    var_05 = getEntArray("out_of_bounds", "targetname");
    foreach(var_07 in param_00.potatocatchpoints) {
      if(self istouching(var_07)) {
        param_00.objectivehelth = clamp(param_00.objectivehelth + param_00 lib_04FF::func_45D0("objectiveCatchScore"), 0, param_00 lib_04FF::func_45D0("objectiveScoreGoal"));
        param_00 notify("objectiveHit");
        playFX(common_scripts\utility::func_44F5("hill_thermite_grenade_burn"), self.var_116);
        self delete();
      }
    }
  }
}

potatobadtriggerwatch() {
  level endon("game_ended");
  self endon("death");
  for(;;) {
    if(potatoistouchingbadtrigger()) {
      waittillframeend;
      if(isDefined(self)) {
        lib_04F3::func_79CB("mp_war_bomb_explo", self.var_116);
        playFX(common_scripts\utility::func_44F5("hill_thermite_grenade_exp"), self.var_116);
        physicsexplosionsphere(self.var_116, 300, 50, 2);
        self delete();
      }

      return;
    }

    wait 0.05;
  }
}

potatoistouchingbadtrigger() {
  var_00 = getEntArray("trigger_hurt", "classname");
  var_01 = getEntArray("out_of_bounds", "targetname");
  foreach(var_03 in var_01) {
    var_00[var_00.size] = var_03;
  }

  foreach(var_03 in var_00) {
    if(self istouching(var_03)) {
      return 1;
    }
  }

  return 0;
}