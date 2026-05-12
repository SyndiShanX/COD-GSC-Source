/**************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zquests\dlc4_secrets_mp_zombie_descent.gsc
**************************************************************/

init_dlc4_secrets_mp_zombie_descent() {
  level.callbackplayerdamagesecondaryhandling = ::maps\mp\zquests\zmb_secret_challenges_util::report_player_damaged;
  lib_0547::register_postenemykilledfunc(::run_secret_challenges_kill_tracking);
  lib_0565::zombiegearchallengeregister("african_set", [::african_set_0, ::african_set_1, ::african_set_2, ::african_set_3, ::african_set_4], "african_set_kill");
  lib_0565::zombiegearchallengeregister("outlaw_set", [::outlaw_set_0, ::outlaw_set_1, ::outlaw_set_2, ::outlaw_set_3, ::outlaw_set_4], "outlaw_set_kill");
  lib_0565::zombiegearchallengeregister("arabic_set", [::arabic_set_0, ::arabic_set_1, ::arabic_set_2, ::arabic_set_3, ::arabic_set_4], "arabic_set_kill");
}

african_set_0() {
  var_00 = self;
  var_01 = "african_set_0";
  level endon(var_01);
  common_scripts\utility::func_3C9F(lib_0557::func_7838("quest_deathraven", "quest_deathraven_activate_rush"));
  level thread maps\mp\zquests\zmb_secret_challenges_util::register_on_player_dmg_func(::maps\mp\zquests\zmb_secret_challenges_util::kill_hidden_challenge, var_01, ::maps\mp\zquests\zmb_secret_challenges_util::agent_is_zombie);
  common_scripts\utility::func_3C9F(lib_0557::func_7838("quest_deathraven", "quest_deathraven_pickup_weap"));
  if(self istouching(getent("zone_gallery_deathravent_event", "targetname"))) {
    return 1;
  }

  return 0;
}

african_set_1() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00.cekillstealsscythe = 0;
  while(var_00.cekillstealsscythe < 12) {
    wait 0.05;
  }

  return 1;
}

african_set_2() {
  var_00 = self;
  var_00 endon("disconnect");
  for(;;) {
    self waittill("death_raven_energy_full", var_01);
    if(!isDefined(var_01) || common_scripts\utility::func_562E(var_01)) {
      break;
    }
  }

  return 1;
}

african_set_3() {
  var_00 = self;
  var_00 endon("disconnect");
  level endon("another_player_joined1");
  level childthread maps\mp\zquests\zmb_secret_challenges_util::fail_on_another_player_joined(self, "another_player_joined", 1);
  common_scripts\utility::func_3C9F("flag_boss_complete");
  return level.var_A980 <= 25 && level.var_744A.size == 1;
}

african_set_4() {
  var_00 = self;
  var_00 endon("disconnect");
  var_01 = ["zombie_king_uber_sun", "zombie_king_uber_flame"];
  while(isDefined(var_01) && var_01.size > 0) {
    var_00 waittill("dr_shield_activate", var_02);
    var_03 = common_scripts\utility::func_F7E(var_01, var_02);
    if(isDefined(var_02) && isDefined(var_03)) {
      var_01 = common_scripts\utility::func_F93(var_01, var_02);
    }
  }

  return 1;
}

outlaw_set_0() {
  var_00 = self;
  var_00 waittill("outlaw_0_complete");
  return 1;
}

outlaw_set_1() {
  var_00 = self;
  var_00 endon("disconnect");
  var_01 = "zone_crash";
  var_02 = "zone_alter";
  var_03 = 105;
  for(;;) {
    var_00 wait_for_player_in_zone(var_01);
    if(var_00 wait_for_player_in_zone(var_02, var_03)) {
      break;
    }
  }

  return 1;
}

wait_for_player_in_zone(param_00, param_01) {
  var_02 = self;
  var_02 endon("disconnect");
  var_03 = gettime();
  for(;;) {
    if(isDefined(param_01) && gettime() - var_03 / 1000 > param_01) {
      return 0;
    }

    var_04 = var_02 lib_055A::func_462D();
    if(lib_0547::func_5565(var_04, param_00)) {
      return 1;
    }

    wait 0.05;
  }
}

outlaw_set_2() {
  common_scripts\utility::func_3C9F("moon_constellation_1_complete");
  var_00 = gettime() * 0.001;
  while(gettime() * 0.001 - var_00 < 300 && !common_scripts\utility::func_3C77("moon_constellation_3_complete")) {
    wait(1);
  }

  if(common_scripts\utility::func_3C77("moon_constellation_3_complete") && lib_0547::func_5565(level.ravenweaponmanager["spike"].var_117, self)) {
    return 1;
  }

  return 0;
}

outlaw_set_3() {
  var_00 = self;
  var_00 waittill("dark_passenger_survived");
  return 1;
}

outlaw_set_4() {
  var_00 = self;
  var_00 endon("disconnect");
  var_00.craftedweapons = 0;
  while(var_00.craftedweapons < 4) {
    wait 0.05;
  }

  return 1;
}

arabic_set_0() {
  var_00 = self;
  var_00 endon("disconnect");
  while(!isDefined(level.var_A980) || level.var_A980 < 15) {
    wait 0.05;
  }

  return !lib_0557::func_783E("quest_firstdoor", "quest_firstdoor_bloodpool");
}

arabic_set_1() {
  if(!isDefined(level.zombie_slam_dunks)) {
    level.zombie_slam_dunks = 0;
  }

  while(level.zombie_slam_dunks < 5) {
    wait 0.05;
  }

  return 1;
}

arabic_set_2() {
  level waittill("wustlinground_trip");
  return 1;
}

arabic_set_3() {
  var_00 = self;
  var_00.boodshielddamagesustained = 0;
  while(var_00.boodshielddamagesustained < 10000) {
    wait 0.05;
  }

  return 1;
}

arabic_set_4() {
  var_00 = self;
  var_00 waittill("blood_is_power");
  return 1;
}

run_secret_challenges_kill_tracking(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  if(!isDefined(param_01)) {
    return;
  }

  if(!isPlayer(param_01)) {
    return;
  }

  if(issubstr(param_04, "scythe") && param_04 != "zom_dlc4_scythe_zm" && common_scripts\utility::func_562E(self.beingeatenbyce)) {
    param_01.cekillstealsscythe++;
  }

  if(issubstr(param_04, "scythe") && !lib_0547::func_5565(self.var_A4B, "zombie_dlc4")) {
    param_01.only_charged_scythe_with_corpse_eaters = 0;
  }

  if(common_scripts\utility::func_562E(self.throwingzombie)) {
    var_09 = common_scripts\utility::func_46B5("zmb_bloodraven_code_display", "targetname");
    if(distance2d(self.var_116, var_09.var_116) < 260) {
      level.zombie_slam_dunks++;
    }
  }
}