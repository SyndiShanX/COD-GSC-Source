/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_special_weapons.gsc
*********************************************/

init() {
  level.var_A85D = [];
  level.var_A85D["flamethrower"] = &"MP_FLAMETHROWER_PICKUP";
  level.var_A85D["molotovs"] = &"MP_MOLOTOV_PICKUP";
  level.var_A85D["mortar_strike"] = &"MP_MORTAR_STRIKE_PICKUP";
  level.var_A85D["tripwire"] = &"RAIDS_TRIPWIRE_COLLECT";
  level.var_A85D["raid_superweapon"] = &"RAIDS_SUPERWEAPON_PICKUP";
  level.var_A85D["raid_tesla_moon"] = &"RAIDS_SUPERWEAPON_PICKUP";
  level.var_A85D["raid_ss_serum_a"] = &"RAIDS_SERUM_PICKUP";
  level.var_A85D["raid_ss_serum_b"] = &"RAIDS_SERUM_PICKUP";
  level.var_A85D["raid_ss_serum_c"] = &"RAIDS_SERUM_PICKUP";
  level.var_A85D["incendiary_can"] = &"MP_MOLOTOV_PICKUP";
  thread func_5356();
  thread onplayerconnect();
}

onplayerconnect() {
  level waittill("connected", var_00);
  var_00 method_8512(["killstreak_air_strike_mp"]);
}

func_5356() {
  level.var_90DB = [];
  var_00 = common_scripts\utility::func_46B7("special_weapon", "targetname");
  level.all_crates = [];
  level.all_empty_crates = [];
  foreach(var_02 in var_00) {
    var_02.var_272F = getEnt(var_02.target, "targetname");
    var_02.crate_empty = getEnt(var_02.var_272F.target, "targetname");
    var_02.crate_empty hide();
    var_02.var_9D65 = getEnt(var_02.crate_empty.target, "targetname");
    var_02.var_5A6E = var_02.var_9D65.var_8260;
    var_02.var_C5 = tablelookup("mp/killstreaktable.csv", 1, var_02.var_5A6E, 2);
    var_02.var_5A68 = tablelookup("mp/killstreaktable.csv", 1, var_02.var_5A6E, 19);
    if(issubstr(var_02.var_5A6E, "serum")) {
      level.raidserumstreaks = ["raid_ss_serum_a", "raid_ss_serum_b", "raid_ss_serum_c"];
      var_02.var_5A6E = common_scripts\utility::func_7A33(level.raidserumstreaks);
      var_02.var_5A68 = "scorestreak_raid_ss_serum_neutral_hud";
    } else if(issubstr(var_02.var_5A6E, "superweapon")) {
      level.raidsuperweaponstreaks = ["raid_superweapon", "raid_tesla_moon"];
      var_02.var_5A6E = common_scripts\utility::func_7A33(level.raidsuperweaponstreaks);
      var_02.var_5A68 = "scorestreak_raid_superweapon_neutral_hud";
    }

    var_02.var_9D65 setHintString(level.var_A85D[var_02.var_5A6E]);
    var_02.var_A582 = getEntArray(var_02.var_9D65.target, "targetname");
    var_02.oncooldown = 0;
    var_02.var_6210 = undefined;
    lib_0502::func_1D39(var_02);
    var_02 lib_0502::func_1D3A(var_02.var_272F.origin, !var_02.oncooldown);
    var_02 lib_0502::func_1D3B(!var_02.oncooldown);
    if(var_02.var_5A6E == "tripwire") {
      var_02.refillcount = var_02.var_81E1;
      var_02.var_7DB6 = 0;
      var_02 thread trackvisualmodelsshow();
    } else {
      var_02.refillcount = 0;
      var_02.var_7DB6 = var_02.var_81E1;
    }

    level.all_crates[level.all_crates.size] = var_02.var_272F;
    level.all_empty_crates[level.all_empty_crates.size] = var_02.crate_empty;
    var_02.var_272F hudoutlineenable(2, 1);
    var_02 thread func_A943();
    var_02 thread weaponplayerconnect();
    var_02 thread weaponsetupfinishonconnect();
  }

  thread outro_logic();
}

weaponsetupfinishonconnect() {
  level endon("runBomberObjective");
  level waittill("connected", var_00);
  self.var_4F6B = func_283A(self, self.var_5A68, 0, 1);
  if(isDefined(self.var_8260) && self.var_8260 == "start_disabled") {
    thread disablespecialweaponpickup();
  }

  if(isDefined(self.var_9D65.script_noteworthy) && self.var_9D65.script_noteworthy == "attackers" || self.var_9D65.script_noteworthy == "defenders") {
    var_01 = game[self.var_9D65.script_noteworthy];
    self.var_9D65 setteamfortrigger(var_01);
  }
}

weaponplayerconnect() {
  level endon("runBomberObjective");
  level endon("game_ended");
  var_00 = self;
  for(;;) {
    level waittill("connected", var_01);
    var_01 thread onplayerspawned(var_00);
  }
}

onplayerspawned(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  level endon("runBomberObjective");
  for(;;) {
    self waittill("spawned_player");
    var_01 = param_00.var_9D65 getpickuptriggerteam();
    var_02 = common_scripts\utility::func_F79(var_01, self);
    if(isDefined(param_00.var_9D65.script_noteworthy)) {
      var_03 = 0;
      var_01 = getpickuptriggerteam();
      if((isDefined(var_01) && !common_scripts\utility::func_F79(var_01, self)) || lib_0502::func_573E(var_03, self) == 0 || isDefined(self.var_A9F6) && self.var_A9F6 == "war_tripwire_mp" || self.var_A9F6 == "killstreak_molotov_cocktail_mp" || self.var_A9F6 == "killstreak_molotov_cocktail_grenadier_mp") {
        if(param_00.oncooldown == 0) {
          if(isDefined(param_00.refillcount) && param_00.refillcount > 0) {
            weapsethighlight(param_00, var_02);
          }

          if(var_02 && param_00.var_6989 != -1) {
            weapsethighlight(param_00, var_02);
            objective_playermask_showto(param_00.var_6989, self getentitynumber());
          } else if(param_00.var_6989 != -1) {
            weapsethighlight(param_00, var_02);
            objective_playermask_showto(param_00.var_6989, self getentitynumber());
            objective_playermask_hidefrom(param_00.var_6989, self getentitynumber());
          }
        }
      }
    }
  }
}

weapsethighlight(param_00, param_01) {
  if(param_01) {
    param_00.var_272F hudoutlineenableforclient(self, 2, 1);
    param_00.crate_empty hidefromclient(self);
    param_00.var_272F showtoclient(self);
    return;
  }

  param_00.var_272F hudoutlinedisableforclient(self);
  param_00.var_272F hidefromclient(self);
  param_00.crate_empty showtoclient(self);
}

func_A943() {
  level endon("game_ended");
  level endon("runBomberObjective");
  self.var_9D65 waittill("trigger", var_00);
  var_01 = maps / mp / killstreaks / _raid_ss_serum_util::pickupisserum(self.var_5A6E);
  if(var_01) {
    while(!maps / mp / killstreaks / _raid_ss_serum_util::handleserumpickup(var_00)) {
      self.var_9D65 waittill("trigger", var_00);
    }
  }

  var_02 = 0;
  var_03 = getpickuptriggerteam();
  if((isDefined(var_03) && !common_scripts\utility::func_F79(var_03, var_00)) || lib_0502::func_573E(var_02, var_00) == 0 || isDefined(var_00.var_A9F6) && var_00.var_A9F6 == "war_tripwire_mp" || var_00.var_A9F6 == "killstreak_molotov_cocktail_mp" || var_00.var_A9F6 == "killstreak_molotov_cocktail_grenadier_mp" || var_00.var_A9F6 == "flamethrower_mp" || var_00.var_A9F6 == "flamethrower_grenadier_mp" || var_00.var_A9F6 == "flamethrower_german_mp" || var_00.var_A9F6 == "flamethrower_german_grenadier_mp") {
    thread func_A943();
    return;
  }

  self.refillcount--;
  self.var_9D65 makeunusable();
  var_00 maps\mp\killstreaks\_killstreaks::func_478D(self.var_5A6E, 0, 0, var_00, var_02);
  var_00 thread maps\mp\gametypes\_hud_message::func_5A78(self.var_5A6E, 500, undefined, undefined);
  if(var_01) {
    thread maps / mp / killstreaks / _raid_ss_serum_util::handledisableserumonpickup(self.var_5A6E, var_00);
  }

  self.var_4F6B.alpha = 0;
  foreach(var_05 in self.var_A582) {
    var_05 hide();
  }

  self.var_272F hudoutlinedisable();
  thread func_7DB5();
  thread playerholdingkillstreakwatcher(var_00);
}

disablespecialweaponpickup() {
  self.var_9D65 makeunusable();
  self.var_4F6B.alpha = 0;
  foreach(var_01 in self.var_A582) {
    var_01 hide();
  }

  self.var_272F hudoutlinedisable();
}

enablespecialweaponpickup() {
  self.var_9D65 makeusable();
  self.var_4F6B.alpha = 1;
  foreach(var_01 in self.var_A582) {
    var_01 show();
  }

  self.var_272F hudoutlineenable(2, 1);
}

trackvisualmodelsshow() {
  level endon("game_ended");
  level endon("runBomberObjective");
  var_00 = self.var_A582;
  var_01 = self.refillcount;
  while(self.refillcount > 0) {
    foreach(var_03 in var_00) {
      if(isDefined(var_03.var_81E1)) {
        var_04 = var_03.var_81E1;
        if(var_04 > self.refillcount / var_01 * var_00.size) {
          var_03 hide();
        } else {
          var_03 show();
        }
      }
    }

    wait 0.05;
  }

  lib_0502::func_1D3B(0);
}

getpickuptriggerteam() {
  if(isDefined(self.script_noteworthy)) {
    var_00 = lib_0502::func_4627(game[self.script_noteworthy]);
    return var_00;
  }

  return [];
}

func_7DB5() {
  level endon("game_ended");
  level endon("runBomberObjective");
  if(self.var_5A6E == "tripwire" && self.refillcount == 0) {
    return;
  }

  self.oncooldown = 1;
  lib_0502::func_1D3B(!self.oncooldown);
  if(issubstr(self.var_5A6E, "serum")) {
    self.var_5A6E = common_scripts\utility::func_7A33(level.raidserumstreaks);
  } else if(issubstr(self.var_5A68, "superweapon")) {
    self.var_5A6E = common_scripts\utility::func_7A33(level.raidsuperweaponstreaks);
  }

  if(getdvarint("mp_raid_dlc4_test_serums", 0) == 1) {
    wait(5);
  } else {
    wait(self.var_7DB6);
  }

  self.oncooldown = 0;
  lib_0502::func_1D3B(!self.oncooldown);
  self.var_9D65 makeusable();
  foreach(var_01 in self.var_A582) {
    var_01 show();
  }

  self.var_272F hudoutlineenable(2, 1);
  self.var_4F6B.alpha = 0.4;
  wait 0.05;
  thread func_A943();
}

playerholdingkillstreakwatcher(param_00) {
  level endon("game_ended");
  level endon("runBomberObjective");
  var_01 = 0;
  param_00 lib_0502::replacehintstringclient(&"MP_MOLOTOV_PICKUP", &"RAIDS_TRIPWIRE_BLANK");
  param_00 lib_0502::replacehintstringclient(&"RAIDS_TRIPWIRE_COLLECT", &"RAIDS_TRIPWIRE_BLANK");
  while(lib_0502::func_573E(var_01, param_00) == 0 || isDefined(param_00.var_A9F6) && param_00.var_A9F6 == "killstreak_molotov_cocktail_mp" || param_00.var_A9F6 == "killstreak_molotov_cocktail_grenadier_mp") {
    common_scripts\utility::func_F71(level.all_crates, ::hidefromclient, param_00);
    common_scripts\utility::func_F71(level.all_empty_crates, ::showtoclient, param_00);
    wait 0.05;
  }

  param_00 lib_0502::replacehintstringclient(&"MP_MOLOTOV_PICKUP", undefined);
  param_00 lib_0502::replacehintstringclient(&"RAIDS_TRIPWIRE_COLLECT", undefined);
  common_scripts\utility::func_F71(level.all_empty_crates, ::hidefromclient, param_00);
  common_scripts\utility::func_F71(level.all_crates, ::showtoclient, param_00);
}

func_283A(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_00) || !isDefined(param_00.origin)) {
    return;
  }

  if(!isDefined(param_03)) {
    param_03 = 1;
  }

  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  var_04 = undefined;
  if(isDefined(param_00.script_noteworthy) && param_00.script_noteworthy == "attackers" || param_00.script_noteworthy == "defenders") {
    var_05 = game[param_00.script_noteworthy];
    var_04 = newteamhudelem(var_05);
  } else {
    var_04 = newhudelem();
  }

  var_04 setshader(param_01, 0, 0, 7);
  var_04.alpha = 0.4;
  var_04 setwaypoint(1, 0, 0, 0, 0, 0, 0, param_03);
  var_04.x = param_00.origin[0];
  var_04.y = param_00.origin[1];
  var_04.z = param_00.origin[2] + 10 - param_02;
  var_04.elemtype = "icon";
  var_04.parent = level.uiparent;
  level.var_90DB = common_scripts\utility::func_F6F(level.var_90DB, var_04);
  level.var_90DB = common_scripts\utility::func_F97(level.var_90DB);
  return var_04;
}

remove_all_special_weaps() {
  var_00 = common_scripts\utility::func_46B7("special_weapon", "targetname");
  foreach(var_02 in var_00) {
    foreach(var_04 in var_02.var_A582) {
      var_04 delete();
    }

    var_02.crate_empty delete();
    var_02.var_272F delete();
  }

  if(isDefined(level.var_90DB)) {
    foreach(var_08 in level.var_90DB) {
      var_08 destroy();
    }
  }
}

outro_logic() {
  level waittill("game_end_vignette");
  remove_all_special_weaps();
}