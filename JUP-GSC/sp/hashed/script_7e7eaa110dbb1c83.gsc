/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_7e7eaa110dbb1c83.gsc
*************************************************/

#using script_102d83a437e2b29f;
#using script_1b5e21ec19a8960b;
#using script_2386704e3c08f8ca;
#using script_391739915ba4b7dd;
#using script_3a8f9ace195c9da9;
#using script_3cb1beed718e7650;
#using script_448ef4d9e70ce5e;
#using script_4a6760982b403bad;
#using script_575fda2758b0a36e;
#using script_5ccf433888d82a9a;
#using script_5e254f0491793e03;
#using script_6b80871eb8142180;
#using script_6dee2410821c6c07;
#using script_6e30b5532e5a1cd2;
#using script_737f801e6beb18c7;
#using script_7e7eaa110dbb1c83;
#using script_a13c48184daa195;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\calloutmarkerping_cp;
#using scripts\cp\carriable;
#using scripts\cp\coop_personal_ents;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_achievement;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_compass;
#using scripts\cp\cp_debug;
#using scripts\cp\cp_gameskill;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_lock_door;
#using scripts\cp\cp_mapselect;
#using scripts\cp\cp_matchdata;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\damage;
#using scripts\cp\endgame;
#using scripts\cp\equipment;
#using scripts\cp\equipment\nvg;
#using scripts\cp\globallogic;
#using scripts\cp\interaction;
#using scripts\cp\killcam;
#using scripts\cp\laststand;
#using scripts\cp\loadout;
#using scripts\cp\movement;
#using scripts\cp\movement_trigger;
#using scripts\cp\perks;
#using scripts\cp\persistence;
#using scripts\cp\pickups;
#using scripts\cp\player_death;
#using scripts\cp\player_flashlight;
#using scripts\cp\spawner_scoring;
#using scripts\cp\starts;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\utility\connect_event_aggregator;
#using scripts\cp\utility\spawn_event_aggregator;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\auto_ascender;
#using scripts\cp_mp\auto_ascender_solo;
#using scripts\cp_mp\calloutmarkerping;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#namespace dungeons;

function main() {
  if(getdvarint(@ "hash_742caa13b3c2e685", 0)) {
    return;
  }

  level.var_59c3f456a9e5d4f0 = &scripts\cp\interaction::init;
  mapname = getDvar(@ "g_mapname");

  if(mapname == "cp_jup_chemical" || mapname == "cp_jup_chemical_dev") {
    level.var_1b4da6b781c9dfbd = 0;
  } else {
    level.var_1b4da6b781c9dfbd = 1;
  }

  flag_init("dungeon_intro_complete");
  scripts\cp\globallogic::init();
  scripts\common\values::register("base_jumping", 0, 0, "$self", &function_f4116328ce66a82d, "$value");
  scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&function_d215b1e8242130cd);
  scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&onplayerconnect_persistence);
  scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&function_6a98c6da3dfa5426);
  scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&onplayerconnect_vo);
  scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&scripts\common\ai::function_d7edb8535850db35);
  setDvar(@ "hash_6f41bda368c6075f", 1);
  setDvar(@ "hash_7ee8f96e0e8f6a0e", 0);
  setDvar(@ "scr_br_skiplegendarypickupsound", 1);
  setDvar(@ "hash_dff65df98f544f1b", 0);
  setDvar(@ "hash_c5cc81fb17510582", 0);
  setDvar(@ "hash_f7da54a18841a6f8", 30);
  function_e73f88105b0ed543();
  level thread scripts\cp\cp_matchdata::init();
  scripts\cp\globallogic::function_d98e304dd9d5d8cd();

  thread debug_activation(@ "hash_acbe5067720d755d", &function_95374dd0e3f02eee);
  thread function_894fdfb8a530cd8c();
}

function function_894fdfb8a530cd8c() {
  cmd = "<dev string:x1c>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x92>";
  addentrytodevgui(cmd);
  cmd = "<dev string:xf9>";
  addentrytodevgui(cmd);
}

function function_95374dd0e3f02eee(debug_ref) {
  flag_wait("<dev string:x160>");
  items = strtok(debug_ref, "<dev string:x177>");
  params = strtok(debug_ref, "<dev string:x179>");
  playertoks = strtok(debug_ref, "<dev string:x17b>");
  player = undefined;

  if(playertoks.size > 1) {
    playerint = int(playertoks[1]);
    player = level.players[playerint];
  }

  switch (items[0]) {
    case #"hash_73a5a0f643a3b82b":
      if(!istrue(level.total_fade)) {
        level.total_fade = 1;
      } else {
        level.total_fade = 0;
      }

      level.player scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(0);
      thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, level.total_fade, 0);
      announcement("<dev string:x187>" + level.total_fade);
      break;
    case #"hash_cdd70bcaab30dd7d":
      if(!istrue(level.world_fade)) {
        level.world_fade = 1;
      } else {
        level.world_fade = 0;
      }

      level.player scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(0);
      thread scripts\cp_mp\utility\game_utility::function_852712268d005332(level.player, level.world_fade, 0);
      announcement("<dev string:x1a5>" + level.world_fade);
      break;
    case #"hash_e5264cb1def599e3":
      level.player scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(0);
      thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 0, 0);
      thread scripts\cp_mp\utility\game_utility::function_852712268d005332(level.player, 0, 0);
      break;
  }
}

function function_f4116328ce66a82d(b_allow) {
  self skydive_setbasejumpingstatus(b_allow);
  self skydive_setdeploymentstatus(b_allow);

  if(b_allow) {
    self.ffsm_state = undefined;
    return;
  }

  self.ffsm_state = 5;
}

function function_4bc6502d9461648b() {
  return level.var_42afc805d63fbe6e && getdvarint(@ "hash_42ec046969fe5985", 0) == 0;
}

function ignoreeachother(group1, group2) {
  level endon("disconnect");
  level endon("game_ended");
  assertex(threatbiasgroupexists(group1), "Tried to make threatbias group " + group1 + " ignore " + group2 + " but " + group1 + " does not exist!");
  assertex(threatbiasgroupexists(group2), "Tried to make threatbias group " + group2 + " ignore " + group1 + " but " + group2 + " does not exist!");
  setignoremegroup(group1, group2);
  setignoremegroup(group2, group1);
}

function function_469c4bcf4a462a07(streakinfo) {
  level endon("disconnect");
  level endon("game_ended");

  if(!function_4bc6502d9461648b()) {
    return;
  }

  if(streakinfo.streakname == "assault_drone" || streakinfo.streakname == "radar_drone_recon") {
    level.valstruct val::set("killstreakMaskingDRONE", "ai_eventlist", "jup_sandbox_aieventlist_ksm");
    return;
  }

  level.valstruct val::set("killstreakMasking", "ai_eventlist", "jup_sandbox_aieventlist_ksm");
}

function function_352715794b363ca(streakinfo) {
  level endon("disconnect");
  level endon("game_ended");

  if(!function_4bc6502d9461648b()) {
    return;
  }

  waitframe();

  if(streakinfo.streakname == "assault_drone" || streakinfo.streakname == "radar_drone_recon") {
    return;
  }

  level.valstruct val::reset("killstreakMasking", "ai_eventlist");
}

function function_edcb5347f322a675(waitseconds) {
  if(!isDefined(waitseconds)) {
    waitseconds = 0;
  }

  level endon("disconnect");
  level endon("game_ended");

  if(!function_4bc6502d9461648b()) {
    return;
  }

  if(waitseconds == 0) {
    waitframe();
  } else {
    wait waitseconds;
  }

  if(!isDefined(level.var_f1ea3299ac2f973) || level.var_f1ea3299ac2f973 < 1) {
    level.player.ignoreme = 0;
  }
}

function function_b52ce23e19e0c544(streakinfo, targetpos) {
  level endon("disconnect");
  level endon("game_ended");

  if(!function_4bc6502d9461648b()) {
    return;
  }

  if(!isDefined(level.var_f1ea3299ac2f973)) {
    level.var_f1ea3299ac2f973 = 0;
  }

  level.var_f1ea3299ac2f973 += 1;
  createthreatbiasgroup("player_bias_group");
  createthreatbiasgroup("ks_ignore_player_biasgrp");

  if(streakinfo.streakname != "chopper_gunner" && streakinfo.streakname != "gunship") {
    level.player setthreatbiasgroup("player_bias_group");
    enemies = getaiarray("axis");

    foreach(enemy in enemies) {
      if(!isPlayer(enemy.enemy)) {
        enemy setthreatbiasgroup("ks_ignore_player_biasgrp");
        ignoreeachother("ks_ignore_player_biasgrp", "player_bias_group");
        enemy thread function_9b27cd46f6a9decf();
        continue;
      }

      enemy val::set(streakinfo.streakname, "ks_dont_forget", 1);
    }
  }

  if(streakinfo.streakname != "hover_jet") {}

  level.valstruct val::set("killstreakMasking", "global_esc_total_combat_time", -1);
  level.valstruct val::set("killstreakMasking", "global_esc_percent_threshold", 1);
}

function function_fff9fa5bbeb2d904(streakinfo, targetpos, delay) {
  if(!isDefined(delay)) {
    delay = 0;
  }

  level endon("disconnect");
  level endon("game_ended");

  if(!function_4bc6502d9461648b()) {
    return;
  }

  wait delay;
  enemies = getaiarray("axis");

  foreach(enemy in enemies) {
    if(istrue(enemy.ksdontforget)) {
      continue;
    }

    if(distancesquared(enemy.origin, targetpos) < squared(1200)) {
      enemy setstealthstate("combat");
      continue;
    }

    if(distancesquared(enemy.origin, targetpos) < squared(10000)) {
      enemy setstealthstate("hunt");
    }
  }
}

function function_9b27cd46f6a9decf() {
  self endon("disconnect");
  self endon("death");
  level endon("ksMaskEnd");

  if(!function_4bc6502d9461648b()) {
    return;
  }

  childthread function_5870c4b3a2deb739();
  childthread function_fde594d4f618e65a();
  childthread function_a872c0f90b1595a2();
  childthread function_d42eac96004b97e0();
  self waittill("PlayerMaskConditionMet");
  childthread function_3edf729e118d27fd();
  self setthreatbiasgroup();
}

function function_d42eac96004b97e0() {
  self endon("PlayerMaskConditionMet");

  while(true) {
    level waittill("friendly_in_combat", pos);

    if(distancesquared(pos, self.origin) < squared(800) && distancesquared(self.origin, level.player.origin) < squared(1600)) {
      self notify("PlayerMaskConditionMet");
      return;
    }
  }
}

function function_3edf729e118d27fd() {
  self notify("EndFriendlyCombatNotify");
  self endon("EndFriendlyCombatNotify");

  while(true) {
    self waittill("weapon_fired");

    if(isPlayer(self.enemy)) {
      level notify("friendly_in_combat", self.origin);
    }
  }
}

function function_fde594d4f618e65a() {
  self endon("PlayerMaskConditionMet");

  while(true) {
    self waittill("damage", _, _, _, _, _, _, _, _, _, _, _, _, _, inflictor);

    if(isPlayer(inflictor)) {
      self notify("PlayerMaskConditionMet");
      return;
    }
  }
}

function function_a872c0f90b1595a2() {
  self endon("PlayerMaskConditionMet");

  while(true) {
    self waittill("bulletwhizby", ent);

    if(isPlayer(ent)) {
      self notify("PlayerMaskConditionMet");
      return;
    }
  }
}

function function_5870c4b3a2deb739() {
  self endon("PlayerMaskConditionMet");
  var_d2e8796aa8e8ee01 = gettime();
  var_adad9caac6aeeb15 = 200 + randomfloat(100);

  while(true) {
    wait 0.1;
    distance = distancesquared(self.origin, level.player.origin);

    if(distance < squared(40)) {
      self notify("PlayerMaskConditionMet");
      return;
    }

    if(distance < squared(1000)) {
      canseeplayer = 0;

      if(getdvarint(@ "hash_ecb89fac8ea6548d", 0) == 0) {
        if(var_d2e8796aa8e8ee01 + var_adad9caac6aeeb15 <= gettime()) {
          var_d2e8796aa8e8ee01 = gettime();
          canseeplayer = function_174cb7c7e99e8032(0.6);
        }
      } else {
        canseeplayer = function_174cb7c7e99e8032(0.6, 1);
      }

      if(canseeplayer) {
        self notify("PlayerMaskConditionMet");
        return;
      }
    }
  }
}

function function_9f5615fb1f9ccd30(streakinfo) {
  level endon("disconnect");
  level endon("game_ended");

  if(!function_4bc6502d9461648b()) {
    return;
  }

  var_1a0011e85d6901ba = streakinfo.streakname;
  level.var_f1ea3299ac2f973--;

  if(level.var_f1ea3299ac2f973 > 0) {
    if(streakinfo.streakname == "assault_drone" || streakinfo.streakname == "radar_drone_recon") {
      wait 5;
      level.valstruct val::reset("killstreakMaskingDRONE", "ai_eventlist");
    }

    return;
  }

  level.valstruct val::set("killstreakMasking", "stealth_ttlt_lkp", 1);
  level.valstruct val::set("killstreakMasking", "default_time_to_drop_threat_sight", 1);
  level.valstruct val::set("killstreakMasking", "stealth_ttlt_not_lkp", 1);
  function_edcb5347f322a675(5);

  if(level.var_f1ea3299ac2f973 <= 0) {
    level notify("ksMaskEnd");
  }

  enemies = getaiarray("axis");

  foreach(enemy in enemies) {
    if(istrue(enemy.ksdontforget)) {
      enemy val::reset(streakinfo.streakname, "ks_dont_forget");
      continue;
    }

    if(level.var_f1ea3299ac2f973 <= 0) {
      enemy function_731a8d6c599a0a10(level.player);
      enemy setthreatbiasgroup();
    }
  }

  level.player setthreatbiasgroup();
  level.valstruct val::reset("killstreakMasking", "stealth_ttlt_lkp");
  level.valstruct val::reset("killstreakMasking", "default_time_to_drop_threat_sight");
  level.valstruct val::reset("killstreakMasking", "stealth_ttlt_not_lkp");

  if(level.var_f1ea3299ac2f973 <= 0) {
    level.valstruct val::reset("killstreakMasking", "global_esc_total_combat_time");
    level.valstruct val::reset("killstreakMasking", "global_esc_percent_threshold");
  }

  if(var_1a0011e85d6901ba == "assault_drone" || streakinfo.streakname == "radar_drone_recon") {
    level.valstruct val::reset("killstreakMasking", "ai_eventlist");
    level.valstruct val::reset("killstreakMaskingDRONE", "ai_eventlist");
  }
}

function function_e73f88105b0ed543() {
  setDvar(@ "hash_13b3dc9fb33fcf99", 1);
  setdvarifuninitialized(@ "enable_segmented_health_regen", 0);

  if(!isDefined(level.valstruct)) {
    level.valstruct = spawnStruct();
  }

  namespace_bed52b18307bf1e0::function_3e689374a8c8c3a2(33);
  level.wave_num = 1;
  level.powers = [];
  level.overcook_func = [];
  level.tier1modeenabled = getdvarint(@ "hash_7026ceffe6e03f2d");
  level.default_weapon = "iw9_pi_papa220_mp";
  level.health_scalar = 1.5;
  level.armoronweaponswitchlongpress = 1;
  level.allow_super = &function_82261e20cacb4de8;
  level.dogtag_revive = 1;
  level.var_f4c8727cac33c176 = 1;
  level.challengesallowed = 0;
  level.var_88e858e641bc0e8e = &function_469c4bcf4a462a07;
  level.var_bcf8ebbb820ae06d = &function_352715794b363ca;
  level.var_b67b5f9dfe488c2f = &function_b52ce23e19e0c544;
  level.var_f56a88761038798b = &function_9f5615fb1f9ccd30;
  level.var_ca1a76fbc0ba0bef = &function_fff9fa5bbeb2d904;
  level.var_e70ce1a0418791bd = ["throwingknife_cp", "throwingknife_mp"];
  function_52343d5c1b190cf0();
  scripts\cp\cp_gameskill::function_31b2bf3fe796b1b2();

  if(getdvarint(@ "hash_302b919208fafa", 0) <= 0) {
    scripts\cp\globallogic::registerfalldamagedvars();
  }

  level.exploimpactmod = 0.1;
  level.shotgundamagemod = 0.1;
  level.armorpiercingmod = 1.5;
  level.armorpiercingmodks = 2;
  level.maxlogclients = 10;
  namespace_da1f3c0af8e51b0f::function_60d43f6a3c2b5f1b(&scripts\cp\loadout::updatemovespeedscale);
  scripts\cp\movement::g_speed_set_func(170);
  level.move_speed_scale = &scripts\cp\loadout::updatemovespeedscale;
  level.getnodearrayfunction = &getnodearray;
  level.prematchfunc = &prematchfunc;
  level.callbackplayerdamage = &scripts\cp\damage::callback_playerdamage;
  level.callbackplayeractive = &function_a9a4fd8118e8faaf;
  level.callbackplayerkilled = &callbackplayerkilled;
  level.onplayerdisconnect = &onplayerdisconnect;
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.onprecachegametype = &onprecachegametype;
  level.laststand_enter_gamemodespecificaction = &enter_laststand;
  level.enter_spectator_func = &scripts\cp\laststand::enable_dogtag_revive;
  level.prespawnfromspectatorfunc = &prespawnfromspectatorfunc;
  level.getspawnpoint = &getspawnpoint;
  level.removeselfrevivetoken = &scripts\cp\laststand::disable_self_revive;
  level.endgame_write_clientmatchdata_for_player_func = &endgame_clientmatchdata;
  level.endgame = &function_958370571ded2e92;
  level.custom_shouldtakedamage = &function_cd1c9f09e2767ea6;
  level.var_ad82a0aaa9cb47e0 = &function_da8bc15db7024388;
  level.allow_players_to_restart = &function_59bec5c026c42487;
  coop_mode_enable("agent_drops");
  level.var_8679f91457606ad = getdvarint(@ "hash_a05f41e7fcf7184", 4);
  level.disable_start_spawn_on_navmesh = 1;
  level.var_16aa7ce5efacbccb = 1;
  level.skippointdisplayxp = 1;
  level.var_bb8596fb319eb83e = 1;
  level.var_f4b090dbbd2b125b = 1;
  level.battlechatterenabled = 0;
  level.var_fb613f99e7d3b47e = 1;
  setDvar(@ "hash_1832d6e1e51d3b2d", -1);
  setDvar(@ "hash_62d0381e79e8cc7c", 1);
  setdvarifuninitialized(@ "hash_82ad0cab483e9af4", 850);
  setDvar(@ "hash_b9e9ee1040e95fe3", 60000);
  setDvar(@ "hash_39f6380d005b64fa", 1);
  setDvar(@ "hash_d20b1b97fdefa92a", 0);
  setDvar(@ "hash_56ca3f5ddfa57646", 1);
  setdvarifuninitialized(@ "hash_d86c1c5277b6aff3", 1);
  function_c72ff775cd61b11(@ "hash_b13c2aa9660602c9", 1, 0);
  setdvarifuninitialized(@ "hash_b7d46b36430341a5", 1);
  setdvarifuninitialized(@ "hash_5b6df9d1639485f1", 1);
  setDvar(@ "hash_c191b1ec8110ac11", 1);
  setdvarifuninitialized(@ "hash_fbf5d62954cafb35", 0);

  setdvarifuninitialized(@ "hash_9a41dcb00ef528c4", "<dev string:x1c1>");
  setdvarifuninitialized(@ "hash_dbb53c7a147a3ed1", 0);

  setdvarifuninitialized(@ "hash_896bbf4f3903072a", 1);
  function_c72ff775cd61b11(@ "heartbeatsensortabletrange", 2000, 1800);
  function_c72ff775cd61b11(@ "heartbeatsensortabletdrawrange", 2000, 1000);
  function_c72ff775cd61b11(@ "heartbeatsensortabletmaxrange", 1500, 1200);
  function_c72ff775cd61b11(@ "heartbeatsensortabletmaxdrawrange", 1500, 1200);
  function_c72ff775cd61b11(@ "compassclippedvehicleshidemode", 1, 0);
  setDvar(@ "scr_br_carriable_spawn_chance", 1);
  setDvar(@ "hash_abec145fdf5e6352", 0);
  setDvar(@ "hash_b8669ce47c4fbdc0", 1);
  setDvar(@ "hash_4e07eb392d33f1da", 230);
  setDvar(@ "hash_fe3f3cd55b08493c", 70);
  setDvar(@ "hash_6a70857a4a8e02f8", 160);
  setDvar(@ "hash_dd3c99b07675fd4a", 100);
  setDvar(@ "hash_46196919c37855a4", 1);
  setDvar(@ "hash_1eb5365bdad13b78", 3);
  setDvar(@ "hash_fdc42aba096a2344", 1);
  setDvar(@ "hash_f983d652b2640512", 1000);
  setDvar(@ "hash_35bab6c292a12242", 4000);
  level.var_472d7a6d15e57940 = getdvarint(@ "hash_586d32848f833922", 1);
  setDvar(@ "hash_967d6957f1fb5e15", 1);
  setDvar(@ "hash_b2567fc7a93d4e30", -1);
  setDvar(@ "hash_875ebcac86159322", -1);
  setDvar(@ "hash_98fb6f768c79d031", 600);
  setDvar(@ "hash_a34fffc543c970ac", 1);
  setDvar(@ "hash_29bc744089339fc2", 400);
  setDvar(@ "execution_distance", 90);
  function_64443c1169f24af9(1);
  setDvar(@ "hash_3d3e000ab3fdf69e", 1);
  level.minimaponbydefault = 1;
  setDvar(@ "hash_4096753656b86302", 1);
  setdvarifuninitialized(@ "hash_f133094f3b5288b6", 1);
  setDvar(@ "hash_bd54dd62349d46c8", 0);
  setDvar(@ "hash_41ab31c3b86aa5b1", 0);
  setdvarifuninitialized(@ "hash_7712791fa05b41c4", 1);
  setdvarifuninitialized(@ "hash_e7c074c9ef3fd481", 0);
  setdvarifuninitialized(@ "hash_2f40a2e9ae1a9a47", 0);
  setdvarifuninitialized(@ "hash_94150a895cddf69d", 1);
  setDvar(@ "hash_4fe68158dff053c", 1);
  setDvar(@ "hash_2a9a0878901a614e", -20);
  setDvar(@ "hash_c9cc12c56dbb4a01", 10);

  if(function_3cb5da19764baa3() == "JUP") {
    setDvar(@ "hash_8136ae00f7d4f22f", 0);
  }
}

function onstartgametype() {
  if(!isDefined(level.valstruct)) {
    level.valstruct = spawnStruct();
  }

  if(!isDefined(level.valstruct.values) || !isDefined(level.valstruct.values["global_esc_percent_threshold"]) || level.valstruct.values["global_esc_percent_threshold"].size < 1) {
    level.valstruct val::set("dungeons", "global_esc_percent_threshold", 0.3);
  }

  if(!isDefined(level.valstruct.values) || !isDefined(level.valstruct.values["global_esc_total_combat_time"]) || level.valstruct.values["global_esc_total_combat_time"].size < 1) {
    level.valstruct val::set("dungeons", "global_esc_total_combat_time", 200);
  }

  if(!isDefined(level.var_42afc805d63fbe6e)) {
    level.var_42afc805d63fbe6e = 1;
  }

  scripts\cp\starts::do_starts();
  load_binks();
  function_60d1324a435092b8();
  thread scripts\cp\player_death::init_player_death();
  scripts\cp\utility::set_segmented_health_regen_parameters(100, 100, 25, 2, 1, 0.05);
  scripts\cp\persistence::register_eog_to_lb_playerdata_mapping();
  scripts\cp\cp_analytics::initlevelvars();
  level thread update_laststand_times();
  level thread init_enemy_spawner();
  level.teamdata["allies"]["hasSpawned"] = 0;
  level.teamdata["allies"]["players"] = [];
  level.teamdata["axis"]["hasSpawned"] = 0;
  level.teamdata["axis"]["players"] = [];
  level.ascendermsgfunc = &ascendermsgfunc;
  scripts\cp\super::init_super();
  setDvar(@ "bg_piggybackarmoronnvg", 1);
  thread scripts\cp_mp\auto_ascender::init();
  thread scripts\cp_mp\auto_ascender_solo::init();
  thread scripts\cp_mp\ent_manager::init();
  thread function_c47ee3c82ea9fa70();

  if(level.pingsystemactive) {
    level scripts\cp\calloutmarkerping_cp::calloutmarkerping_init();
  }

  scripts\cp\persistence::rank_init();
  level thread handlenondeterministicentities();

  if(!scripts\cp\cp_debug::function_91979fbf5dbf3bea()) {
    level thread namespace_c0269b8ac4e7a573::debuginit();
  }

  level thread scripts\cp\laststand::checkpoint_revive();
  namespace_97f2cf3995839d6e::init();
  thread scripts\cp\cp_outofbounds::initoob();
  scripts\cp\cp_outofbounds::killstreakregisteroobcallbacks();
  level thread scripts\cp\utility::function_76ba4acf14679724();
  level thread destructible_vehicle_init();
}

function function_92a83310ab07ac05() {
  level endon("disconnect");
  level endon("game_ended");

  while(true) {
    wait 2;
    playerstruct = spawnStruct();
    playerstruct.player = self;
    playerstruct.weaponobj = self getcurrentprimaryweapon();
    playerstruct.weaponname = getbaseweaponname(playerstruct.weaponobj);
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_armor_ammo_stats", playerstruct);
  }
}

function function_60d1324a435092b8() {
  setDvar(@ "hash_6a42615125b9ab37", 1);
  setdvarifuninitialized(@ "hash_c11db9baa9e5bc9b", istrue(level.var_bb3505b72e24c478));
  setDvar(@ "hash_ce0f18cf521df1ef", 0);
  level.maxperplayerexplosives = max(getintproperty(@ "hash_b62eac49cca8c84b", 2), 8);
  level thread scripts\cp\coop_stealth::activate_stealth_settings();
  level thread namespace_a0852b262a68d01::function_f98bf6b7b70b76aa();

  if(!isDefined(level.var_e129f1e4a5717456)) {
    namespace_1170726b2799ea65::function_61411c49eaca86e2("price");
  }

  namespace_16d9c1530a364ee9::init_script_triggers();
  namespace_ba155a12c323dc5a::function_c6a62b7a2794062a();
  namespace_3248c63599f525cf::function_f454179adec481d0();

  level thread namespace_1170726b2799ea65::function_748fe2e59aef2dea();

  level thread scripts\cp\carriable::initcarriables();
  scripts\cp\killcam::init();
  function_e00cc8c1c5cc38fb(1);
  level namespace_1170726b2799ea65::function_40b2971a2486ffe1();
  level thread namespace_1170726b2799ea65::function_17e182dda2380009();
  level thread namespace_1170726b2799ea65::function_7edca09707286001();
  level thread namespace_1170726b2799ea65::function_418b23e1002e9083();
  level thread namespace_1170726b2799ea65::function_6f0de80fb3c3b9d4();
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&function_47f5bdce6050f955);
  registersharedfunc("checkpoint", "timestamp", &namespace_1170726b2799ea65::function_2bc461567e40437d);
  registersharedfunc("checkpoint", "reset", &scripts\cp\cp_checkpoint::function_5ace495feba111d3);
  registersharedfunc("checkpoint", "get_checkpoint_map", &namespace_1170726b2799ea65::function_1fcb318b0c28347b);
  registersharedfunc("backpack", "removeSmallestItemStackBackpack", &scripts\cp\pickups::removesmallestitemstackbackpack);
  create_func_ref("notetrack_linkmodel_callback", &namespace_1170726b2799ea65::function_8b4a89ac15af6483);

  if(getdvarint(@ "hash_5b6df9d1639485f1", 0)) {
    create_func_ref("anim_placeweaponon", &function_5a1de5646fdedce2);
  }

  level thread function_ab2d882fa619b15();
  level thread parachute_monitor();
  level thread dungeons_common_exfil_reduceaiaggression();
  level thread function_91fd014350085114();
  level thread function_70f5db234f4d0fe0();
  level thread function_888ffa35a33c99ef();

  if(istrue(level.var_61a54be8038f3a95)) {
    level thread namespace_b96fa4d8ce10f926::function_53b88af7755302d2(level.var_41957e049a51e8bc, level.var_8e4a4897f3b80823);
  }
}

function parachute_monitor() {
  if(!isDefined(level.player)) {
    level waittill("player_spawned");
  }

  level thread function_572d32ce5c136049();

  for(;;) {
    level.player waittill("skydive_deployparachute");
    level.player showlegsandshadow();
    level.player waittill("player_landed", var_b6a57549a0ce42f1);
    level.player hidelegsandshadow();
    waitframe();
  }
}

function function_572d32ce5c136049() {
  while(true) {
    var_b6a57549a0ce42f1 = spawnStruct();

    while(level.player isonground()) {
      wait 0.1;
    }

    var_b6a57549a0ce42f1.last_good_pos = level.player.origin;
    var_b6a57549a0ce42f1.airtime = gettime();
    var_b6a57549a0ce42f1.var_4ade7c346de27170 = spawnStruct();

    if(getdvarint(@ "hash_b598a66f5c23d9b8", 0)) {
      scripts\common\debug::debug_sphere(level.player, 25, (1, 0, 0), undefined, undefined, "<dev string:x1c2>");
    }

    while(!level.player isonground()) {
      if(getdvarint(@ "hash_b598a66f5c23d9b8", 0)) {
        line(var_b6a57549a0ce42f1.last_good_pos, level.player.origin);
        print3d(var_b6a57549a0ce42f1.last_good_pos + (0, 0, 150), round(0.0254 * distance(var_b6a57549a0ce42f1.last_good_pos, level.player.origin), 0.1) + "<dev string:x1d0>", (1, 0, 0), undefined, 3);
      }

      if(!istrue(var_b6a57549a0ce42f1.var_4ade7c346de27170.parachute) && level.player function_3c6bb30ae7106b7a()) {
        var_b6a57549a0ce42f1.var_4ade7c346de27170.parachute = 1;
      }

      waitframe();
    }

    level.player notify("player_landed", var_b6a57549a0ce42f1);
    waitframe();
  }
}

function function_958370571ded2e92(winner, endreasontextindex) {
  level thread scripts\cp\endgame::endgame(winner, endreasontextindex);

  if(winner == "allies") {
    namespace_1170726b2799ea65::function_3fc39fc10ef1d9d1(1);
    stopactivity(namespace_1170726b2799ea65::function_ce720be6f935d1d4(level.mapname), "completed");
    return;
  }

  stopactivity(namespace_1170726b2799ea65::function_ce720be6f935d1d4(level.mapname), "failed");
}

function function_21d8267ef66746a3(class_index, var_f01f8e178ff54eda) {
  self notify("loadout_class_selected", class_index);
}

function function_59bec5c026c42487(endreasontextindex) {
  var_b124cfb559178992 = [2, 3, 11];
  return scripts\engine\utility::array_contains(var_b124cfb559178992, endreasontextindex);
}

function function_ab2d882fa619b15() {
  flag_wait("flag_dungeon_intro_complete");

  if(!isDefined(level.outofboundstime)) {
    level.outofboundstime = 10;
  }

  if(!isDefined(level.var_c40a8076a9c58b32)) {
    level.var_c40a8076a9c58b32 = 4;
  }

  if(!isDefined(level.outofboundstimeminefield)) {
    level.outofboundstimeminefield = 5;
  }

  while(!isDefined(level.players) || !isDefined(level.players[0])) {
    waitframe();
  }

  if(scripts\cp\cp_outofbounds::isoobimmune(level.players[0])) {
    scripts\cp\cp_outofbounds::disableoobimmunity(level.players[0]);
  }
}

function function_cd1c9f09e2767ea6(player) {
  if(!flag("flag_dungeon_intro_complete")) {
    checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();

    if(!isDefined(checkpoint) || checkpoint == "") {
      return false;
    }
  }

  if(flag("flag_dungeon_outro_start")) {
    return false;
  }

  if(flag("player_god")) {
    return false;
  }

  return true;
}

function function_da8bc15db7024388() {
  if(flag("player_demigod")) {
    return true;
  }

  return false;
}

function function_47f5bdce6050f955() {
  if(function_aae789091735229f()) {
    scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0);
    scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(1);
  } else {
    self setclientomnvar("ui_world_fade", 1);
  }

  scripts\cp_mp\armor::initarmor();
  setsaveddvar(@ "hash_d4f3414c2a34e19e", 0);
  thread scripts\cp\movement_trigger::movementchangerequests();
  thread namespace_1170726b2799ea65::function_65938d8e60837b34();
  scripts\cp\utility::giveperk("specialty_hack");
  namespace_9766820f5baa93fb::function_f4116328ce66a82d(1);
  scripts\cp_mp\equipment::clearallequipment();
  scripts\cp_mp\utility\damage_utility::adddamagemodifier("nerf_jltv_mg_dmg", 0.25, 1, &function_14cf6fb6ce20f9e8);

  if(!istrue(self.pers["restarted"]) && scripts\cp\starts::is_first_start()) {
    self freezecontrols(1);
  }

  val::set("cp_spawn", "nvg", 0);
  function_d013543a33878267();
  thread scripts\cp\pickups::spawn_pickups();
  thread function_ed0d19eac2d87abe();
  thread function_316420283a77f32b();

  if(namespace_1170726b2799ea65::function_ce720be6f935d1d4() == "cp_jup_dam") {
    self setprogressiondata("fogOfWarData", "fogOfWarMapData", "cp_jup_dam", "version", 0);
  }

  self setclientomnvar("ui_dungeon_extended_load_screen", 0);
  self setclientomnvar("ui_player_spawned_notify", 1);
  self setsoundsubmix("cp_jup_loadoutscreen", 0);
  self setclientomnvar("ui_show_objectives", 0);
  self setclientomnvar("ui_disable_objective_reveal_fanfare", 1);

  if(getdvarint(@ "hash_4b5c7d9c5837b915", 0) == 1) {
    thread namespace_1170726b2799ea65::function_758a56fd5a3d8eb3();
  }

  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.25);
  var_bb1a64a19851a24d = getdvarint(@ "hash_c11db9baa9e5bc9b", 0);
  var_bc038544215707c1 = function_bc038544215707c1();

  if(!var_bb1a64a19851a24d && var_bc038544215707c1) {
    var_9d5e14018a42cda5 = getStruct("loadout_camera", "targetname");
    ecamera = undefined;

    if(isDefined(var_9d5e14018a42cda5)) {
      ecamera = spawn("script_model", var_9d5e14018a42cda5.origin);
      ecamera setModel("tag_origin");
      ecamera.angles = (0, 0, 0);
      waitframe();
      self dontinterpolate();
      self cameraunlink();
      self cameralinkTo(ecamera, "tag_origin", 1, 1);
      self setdepthoffield(0, 60, 100, 200, 4, 0);
      setDvar(@ "hash_71c6c0b8428e44a7", 1);
    }
  }

  thread function_673bd8434dccf2e1();
  function_bbfe7ff526c6a32f();
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 1);
  unlocklist = level.var_1b908bf18691b097.var_884e10986cbfccc7.unlocklist;
  var_85f6878b365d2b5a = [];

  for(i = 0; i < unlocklist.size; i++) {
    if(istrue(unlocklist[i].isdefault)) {
      itemid = namespace_1170726b2799ea65::function_60bebdf35a6b266f(unlocklist, i, namespace_1170726b2799ea65::function_ce720be6f935d1d4(level.mapname));
      var_85f6878b365d2b5a[var_85f6878b365d2b5a.size] = itemid;
    }
  }

  level.var_1b908bf18691b097.var_9fe46adfd5a9aa19 = var_85f6878b365d2b5a;

  if(!var_bc038544215707c1) {
    flag_wait("player_spawned_pre_loadout");

    if(!function_aae789091735229f()) {
      thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.5);
      self setclientomnvar("ui_world_fade", 0);
    }

    if(!function_454165a6188e7913() && isDefined(self.hidehudenabled) && self.hidehudenabled > 0) {
      utility::hidehuddisable();
    }

    if(level.var_1b908bf18691b097.attempts == 1) {
      if(istrue(level.var_b9d5a2af2d535f77)) {
        thread namespace_1170726b2799ea65::function_2381e221a64411c2();
      } else {
        namespace_1170726b2799ea65::function_2381e221a64411c2();
      }
    }

    self notify("loadout_class_selected", 1);
    self freezecontrols(0);

    if(!scripts\cp\utility::is_default_start()) {
      scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(0);
      thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 1);
      scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(1);
    }
  } else if(!var_bb1a64a19851a24d) {
    self setclientomnvar("ui_requested_loadout_state", 1);
    self setclientomnvar("ui_options_menu", 5);
    setmusicstate("mx_frontend_loadout");

    if(!function_aae789091735229f()) {
      self setclientomnvar("ui_world_fade", 0);
    }

    thread namespace_1170726b2799ea65::function_b66c3d85ea26d412();
    flag_wait("player_spawned_pre_loadout");
    namespace_1170726b2799ea65::function_aa47047a0f7d56da(self, 0, 0);

    while(true) {
      self waittill("luinotifyserver", channel, value);

      if(channel == "dungeon_loadout_selected") {
        self setclientomnvar("ui_options_menu", 0);

        if(function_aae789091735229f()) {
          scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.15);
          scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(1);
        }

        self dontinterpolate();
        self cameraunlink();
        self cameradefault();
        setDvar(@ "hash_71c6c0b8428e44a7", 0);
        self freezecontrols(0);

        if(isDefined(self.hidehudenabled) && self.hidehudenabled > 0) {
          utility::hidehuddisable();
        }

        if(!scripts\cp\utility::is_default_start()) {
          scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(0);
          thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 1);
          scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(1);
        }

        self notify("loadout_class_selected", value);
        break;
      }
    }

    if(isDefined(ecamera)) {
      ecamera delete();
    }
  } else {
    self notify("loadout_class_selected", 1);

    if(!function_aae789091735229f()) {
      self setclientomnvar("ui_world_fade", 0);
    }

    if(!scripts\cp\utility::is_default_start()) {
      scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(0);
      thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 1);
      scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(1);
    }

    self freezecontrols(0);
  }

  self clearsoundsubmix("cp_jup_loadoutscreen", 0.2);
  self clearsoundsubmix("cp_matchend", 0.2);
  self clearsoundsubmix("mp_matchend_music", 0.2);
  var_cd27fd453a6003ce = getEntArray("trigger_multiple_set_minimap_floor", "classname");

  if(var_cd27fd453a6003ce.size > 1) {
    scripts\cp\cp_compass::function_ca4665b0582ee426(var_cd27fd453a6003ce);
  }
}

function function_aae789091735229f() {
  switch (level.mapname) {
    case #"hash_3705bde815a332ea":
    case #"hash_5c03122b70ff4094":
    case #"hash_619829c7b3c4c3e3":
    case #"hash_6b2477606925177a":
    case #"hash_c3c819184bc33817":
      return 1;
    case #"hash_8e2389607af0427b":
      return 0;
    default:
      return 0;
  }
}

function function_673bd8434dccf2e1() {
  self endon("cinematic_ended_early");
  self endon("disconnect");
  level endon("game_ended");
  waitframe();

  while(getdvarint(@ "cl_pregame")) {
    waitframe();
  }

  waitframe();
  self notify("cinematic_ended_early");
}

function function_bbfe7ff526c6a32f() {
  self endon("cinematic_ended_early");
  self endon("disconnect");
  level endon("game_ended");

  if(!istrue(self.pers["restarted"])) {
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0);

    while(true) {
      self waittill("luinotifyserver", channel, value);

      if(channel == "transition_bink_finished") {
        self notify("cinematic_ended_early");
        break;
      }
    }

    return;
  }

  wait 0.5;
}

function function_316420283a77f32b(equipments, var_c8d0de3b7f57bd7d) {
  self endon("disconnect");

  if(!isDefined(level.var_1b908bf18691b097)) {
    return;
  }

  equipments = default_to(equipments, strtok("nvg,ascender,armorCarrier,parachute_activator", ","));

  if(!isarray(equipments)) {
    equipments = [equipments];
  }

  foreach(equipment in equipments) {
    var_cabc886d846dd979 = default_to(var_c8d0de3b7f57bd7d, function_c52192a1d946af6e(equipment));

    if(isDefined(var_cabc886d846dd979)) {
      self setclientomnvar("ui_special_equipment_" + equipment, var_cabc886d846dd979);
    }
  }
}

function function_c52192a1d946af6e(equipment) {
  switch (equipment) {
    case #"hash_4059066c2be514e6":
      var_8d100d16b384050b = istrue(self.pers["useNVG"]) || istrue(level.var_1b908bf18691b097.nvg);
      nvgs = getStructArray("nvg_pickup", "targetname");
      return (!isDefined(nvgs) || nvgs.size == 0 ? -1 : istrue(var_8d100d16b384050b) ? 1 : level.var_1b908bf18691b097.nvg);
    case #"hash_32d233f7333dcec":
      ascenders = getStructArray("cp_ascender_device", "targetname");
      return (isDefined(ascenders) && ascenders.size > 0 ? level.var_1b908bf18691b097.ascender_tool : -1);
    case #"hash_6718050cbce9d770":
      return (level.var_1b908bf18691b097.plate_level - 1);
    case #"hash_48feb3ef9a8f1c80":
      activators = getStructArray("cp_parachute_activator", "targetname");
      return (isDefined(activators) && activators.size > 0 ? level.var_1b908bf18691b097.parachute_activated : 1);
    default:
      return -1;
  }
}

function private function_ed0d19eac2d87abe() {
  self endon("death");
  self endon("disconnect");

  while(true) {
    level waittill("pickup_hidden", pickupname);

    if(isDefined(pickupname)) {
      switch (pickupname) {
        case #"hash_c6fbab1b754d4731":
          level.player.pers["useNVG"] = 1;
          level.player thread namespace_1170726b2799ea65::function_525da54dd2ac1fe2(pickupname);
          val::set("runNVG", "nvg", 1);

          if(!istrue(level.var_bb3505b72e24c478) && !istrue(level.var_1b908bf18691b097.nvg)) {
            namespace_1170726b2799ea65::function_ed4f7e1b0b42e2c4(1);
          }

          function_316420283a77f32b("nvg", 1);
          level.player thread function_fc67dae6e32a00df(0, 28179);
          break;
        case #"hash_69a21010d8ea33c6":
          level.player.pers["parachute_activator_unlocked"] = 1;
          level.player notify("parachute_activator_pickedup");
          level.player namespace_9766820f5baa93fb::function_f4116328ce66a82d(1);
          level.player thread namespace_1170726b2799ea65::function_525da54dd2ac1fe2(pickupname);

          if(!istrue(level.var_bb3505b72e24c478) && !istrue(level.var_1b908bf18691b097.parachute_activated)) {
            namespace_1170726b2799ea65::function_f045fd5df4bf1896(1);
          }

          function_316420283a77f32b("parachute_activator", 1);
          level.player thread function_fc67dae6e32a00df(1, 1);
          break;
        case #"hash_f915fbc169649855":
          level.player.pers["ascender_device_unlocked"] = 1;
          level.player notify("ascender_device_pickedup");
          level.player thread namespace_1170726b2799ea65::function_525da54dd2ac1fe2(pickupname);

          if(!istrue(level.var_bb3505b72e24c478) && !istrue(level.var_1b908bf18691b097.ascender_tool)) {
            namespace_1170726b2799ea65::function_965540c9de8803c9(1);
          }

          function_9529eb86e25b4574();
          function_316420283a77f32b("ascender", 1);
          level.player thread function_fc67dae6e32a00df(1, 2);
          break;
        case #"hash_ada0805eed9156de":
          if(!istrue(level.var_bb3505b72e24c478) && isDefined(level.var_1b908bf18691b097.plate_level)) {
            namespace_1170726b2799ea65::function_58311dfacdcaf94c(self.platecarrierlevel);
          }

          var_3a84254a9631f527 = self.platecarrierlevel == namespace_1170726b2799ea65::function_c9e9a9b526daf36a();

          if(var_3a84254a9631f527) {
            var_233346fe08b65445 = namespace_1170726b2799ea65::function_fb43dbfed97eef6a("achievementSuitUp");
            var_c1c2d83ae3d007d3 = namespace_1170726b2799ea65::function_c795e60600c096c9().size;
            var_233346fe08b65445 = int(clamp(var_233346fe08b65445 + 1, 0, var_c1c2d83ae3d007d3));

            if(var_233346fe08b65445 == var_c1c2d83ae3d007d3) {
              level.player function_6a369480dbaf1090("jup_sp_suit_up");
            }

            level.player setprogressiondata("spdata", "achievementSuitUp", var_233346fe08b65445);
          }

          function_316420283a77f32b("armorCarrier", self.platecarrierlevel - 1);
          itemid = var_3a84254a9631f527 ? 8410 : 8554;
          level.player thread function_fc67dae6e32a00df(0, itemid);
          break;
      }
    }

    waitframe();
  }
}

function private function_d013543a33878267() {
  equipments = strtok("nvg,ascender,armorCarrier,parachute_activator", ",");
  level.special_equipment = [];

  foreach(equipment in equipments) {
    var_497dc8c08579d3fe = 0;

    switch (equipment) {
      case #"hash_6718050cbce9d770":
        level.special_equipment[equipment] = "jup_armor_platecarrier_upgrade";
        break;
      case #"hash_4059066c2be514e6":
        var_497dc8c08579d3fe = istrue(level.var_bb3505b72e24c478) ? level.player.pers["useNVG"] : istrue(level.var_1b908bf18691b097.nvg);

        if(istrue(var_497dc8c08579d3fe)) {
          level.player.pers["useNVG"] = 1;
          level.player val::set("runNVG", "nvg", 1);
        }

        level.special_equipment[equipment] = "brloot_nvg";
        break;
      case #"hash_32d233f7333dcec":
        var_497dc8c08579d3fe = istrue(level.var_bb3505b72e24c478) ? level.player.pers["ascender_device_unlocked"] : istrue(level.var_1b908bf18691b097.ascender_tool);
        level.special_equipment[equipment] = "cp_ascender_device";
        break;
      case #"hash_48feb3ef9a8f1c80":
        var_497dc8c08579d3fe = istrue(level.var_bb3505b72e24c478) ? level.player.pers["parachute_activator_unlocked"] : istrue(level.var_1b908bf18691b097.parachute_activated);
        level.special_equipment[equipment] = "cp_parachute_activator";
        break;
    }

    if(istrue(var_497dc8c08579d3fe) && isDefined(level.special_equipment[equipment])) {
      level.player thread namespace_1170726b2799ea65::function_525da54dd2ac1fe2(level.special_equipment[equipment]);
    }
  }
}

function private function_fc67dae6e32a00df(var_d8fa38cf95ae06a, id, displaytime) {
  self endon("disconnect");
  self endon("death");

  if(!isDefined(var_d8fa38cf95ae06a)) {
    return;
  }

  omnvar = istrue(var_d8fa38cf95ae06a) ? "ui_gear_discovered" : "ui_new_item_discovered";
  displaytime = default_to(displaytime, 3);
  level notify("interrupt_tutorial_print");
  flag_waitopen_all_array(["objective_splash_onscreen", "other_splash_onscreen"]);
  flag_set("other_splash_onscreen");
  self setclientomnvar(omnvar, id);
  wait displaytime;
  flag_clear("other_splash_onscreen");
}

function private function_2289174c824d5dfa() {
  self endon("death");
  self endon("disconnect");

  while(true) {
    self waittill("luinotifyserver", message);

    switch (message) {
      case #"hash_8a66337b71ccec4c":
        self notify("tacmap_opened");
        break;
      case #"hash_899f65d5013659d0":
        self notify("tacmap_closed");

        if(getdvarint(@ "hash_896bbf4f3903072a", 1) == 1) {
          thread scripts\cp\cp_objectives::function_b338aa1e9ec37fbd(6);
        }

        break;
    }
  }
}

function check_to_turn_on_nvg(holdtime, starttime) {
  self notify("check_to_turn_on_nvg");
  self endon("check_to_turn_on_nvg");
  self endon("disconnect");
  self endon("death");
  self endon("dpadup_released");

  while(true) {
    elapsedtime = gettime() - starttime;

    if(elapsedtime >= holdtime) {
      if(!self isnightvisionon()) {
        self nightvisionviewon();
        return;
      }

      self nightvisionviewoff();
      return;
    }

    waitframe();
  }
}

function function_91fd014350085114(var_cffec1c536c39260) {
  level notify("kill_nightVision_disable");
  level endon("kill_nightVision_disable");
  level endon("game_ended");
  flag_wait("flag_dungeon_outro_start");
  var_cffec1c536c39260 = default_to(var_cffec1c536c39260, 0);

  if(!var_cffec1c536c39260 && level.player isnightvisionon()) {
    level.player nightvisionviewoff();
  }
}

function dungeons_common_exfil_reduceaiaggression(ai_array, var_e7973285a767ead9, var_fa1ab29bf6705c71, var_4cbcaddbe471ecb1) {
  level notify("kill_dungeons_common_exfil_reduceAIAggression");
  level endon("kill_dungeons_common_exfil_reduceAIAggression");
  flag_wait("flag_dungeon_outro_start");
  ai_array = default_to(ai_array, getaiarray("axis"));
  var_e7973285a767ead9 = default_to(var_e7973285a767ead9, 0);
  var_fa1ab29bf6705c71 = default_to(var_fa1ab29bf6705c71, 500);
  var_4cbcaddbe471ecb1 = default_to(var_4cbcaddbe471ecb1, 1500);

  foreach(ai in ai_array) {
    if(isalive(ai)) {
      playerpos = level.player.origin;
      var_a5bd93f48868752b = ai.origin;
      var_cedbb1f41f5e3294 = distance(var_a5bd93f48868752b, playerpos);

      if(var_cedbb1f41f5e3294 <= var_fa1ab29bf6705c71) {
        ai scripts\cp_mp\agents\agent_utils::despawnagent();
        continue;
      }

      if(var_e7973285a767ead9 || var_cedbb1f41f5e3294 <= var_4cbcaddbe471ecb1) {
        ai.attackeraccuracy = 0;
        continue;
      }

      ai.ignoreall = 1;
    }
  }
}

function private function_70f5db234f4d0fe0() {
  if(!isDefined(level.player)) {
    level waittill("player_spawned");
  }

  level endon("dungeon_load_finished");

  if(flag("dungeon_load_finished")) {
    function_3c60e4a82eeaad2e();
  }

  level thread function_a708a332a4b60491();
  level thread function_33f1e9fdc4b2d1a();
  level.player hidelegsandshadow();
  function_3c60e4a82eeaad2e();
}

function private function_a708a332a4b60491() {
  level endon("dungeon_load_finished");

  if(istrue(level.player.pers["restarted"])) {
    waittillframeend();
    function_3c60e4a82eeaad2e();
  }
}

function private function_33f1e9fdc4b2d1a() {
  level endon("dungeon_load_finished");
  flag_wait("start_is_set");

  if(!scripts\cp\starts::is_first_start()) {
    flag_set("flag_dungeon_intro_complete");
    waittillframeend();
    function_3c60e4a82eeaad2e();
  }
}

function private function_888ffa35a33c99ef() {
  flag_wait("flag_dungeon_intro_complete");
  flag_wait("player_spawned_pre_loadout");
  flag_set("other_splash_onscreen");
  level.players[0] setclientomnvar("ui_sandbox_intro_splash_state", 1);
  wait 6;
  flag_clear("other_splash_onscreen");
  flag_set("dungeon_intro_complete");
  level.players[0] setclientomnvar("ui_sandbox_intro_splash_state", 2);
}

function function_454165a6188e7913() {
  if(flag("<dev string:x1d2>") && getDvar(@ "start", "<dev string:x1c1>") != "<dev string:x1c1>") {
    return true;
  }

  return false;
}

function function_bc038544215707c1() {
  if(function_454165a6188e7913()) {
    return false;
  }

  return level.var_1b908bf18691b097.should_show_loadout == 1 && getdvarint(@ "hash_f619f65c8609c7d0", 0) == 0;
}

function function_1528dffbfe207dc2() {
  if(!isDefined(level.var_3a0fa0e5f32188e8)) {
    level.var_3a0fa0e5f32188e8 = 0;
  }

  if(level.var_3a0fa0e5f32188e8 == 0) {
    if(!flag_exist("wait_for_mission_DDL_data_clear")) {
      level flag_init("wait_for_mission_DDL_data_clear");
    }

    level thread namespace_1170726b2799ea65::function_6184d3208cbeb4fa();
    level.var_3a0fa0e5f32188e8 = 1;

    while(!flag("wait_for_mission_DDL_data_clear")) {
      waitframe();
    }
  }
}

function function_3c60e4a82eeaad2e() {
  level.var_1b908bf18691b097 = namespace_1170726b2799ea65::function_7e6994d769b9b3cd();
  level thread namespace_1170726b2799ea65::function_2f51d89f7ca2ea6f();
  level thread namespace_1170726b2799ea65::function_8dcc0f3d1bacc30c();
  level thread namespace_1170726b2799ea65::function_a7cfbaaea3046f47();
  level thread scripts\cp\cp_lock_door::function_5e512a9e89597b21();
  level thread namespace_a7031d28ff46706::function_ed68c9be9d1ddd23();
  level thread namespace_1170726b2799ea65::function_29c7b140e0c906de(level.mapname);
  startactivity(namespace_1170726b2799ea65::function_ce720be6f935d1d4(level.mapname));

  if(!isDefined(level.player.pers["map_restarted"])) {
    level.player.pers["map_restarted"] = 0;
  }

  if(getdvarint(@ "hash_aac60146b3be6185", 0) == 1 && level.player.pers["map_restarted"] == 0) {
    function_1528dffbfe207dc2();
  }

  if(level.player getprogressiondata("sandboxddlversion", "version") != 8) {
    if(level.var_1b908bf18691b097.attempts == 0) {
      level.player setprogressiondata("sandboxddlversion", "version", 8);
    } else {
      println("<dev string:x1eb>");
      level flag_init("wait_for_map_data_clear");
      thread namespace_1170726b2799ea65::function_70a87a63a6332a7b();

      while(!flag("wait_for_map_data_clear")) {
        waitframe();
      }

      level.player setprogressiondata("sandboxddlversion", "version", 8);
    }
  }

  if(getdvarint(@ "hash_508da9456883205a", 0)) {
    namespace_1170726b2799ea65::function_f7475c0922084f67();
  }

  if(getdvarint(@ "hash_2e01bf92624b0c62", 0)) {
    println("<dev string:x1eb>");
    level flag_init("wait_for_map_data_clear");
    thread namespace_1170726b2799ea65::function_70a87a63a6332a7b();

    while(!flag("wait_for_map_data_clear")) {
      waitframe();
    }

    println("<dev string:x215>");
  }

  if(isDefined(level.var_82191bfa9f751f4c) || istrue(level.var_bb3505b72e24c478)) {
    level.player setclientomnvar("ui_sboxmission_name", namespace_1170726b2799ea65::function_ce720be6f935d1d4());
  }

  if(isDefined(level.var_1b908bf18691b097)) {
    namespace_1170726b2799ea65::function_3fc39fc10ef1d9d1();
  }

  level.player setclientomnvar("ui_dungeon_extended_load_screen", 0);

  if(!getdvarint(@ "hash_c11db9baa9e5bc9b", 0)) {
    level.player utility::hidehudenable();
  }

  level flag_set("dungeon_load_finished");
  level notify("dungeon_load_finished");
}

function function_14cf6fb6ce20f9e8(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(isDefined(objweapon) && objweapon.basename != "jup_mg_jltv_dungeons_cp" && objweapon.basename != "jup_mg_jltv_mp" && objweapon.basename != "iw9_mg_jltv_mp") {
    return true;
  }

  return false;
}

function function_5a1de5646fdedce2(weapon, position, activeweapon) {
  if(isagent(self)) {
    if(is_equal(position, "none") && !istrue(self.var_c3839981de5e0932)) {
      self.stowed_weapon = self.weapon;
      self.weapon = nullweapon();
      self.var_c3839981de5e0932 = 1;
      return;
    } else if(is_equal(position, "right") && istrue(self.var_c3839981de5e0932)) {
      self.weapon = self.stowed_weapon;
      self.var_c3839981de5e0932 = undefined;
      return;
    }
  }

  scripts\anim\shared::placeweaponon(weapon, position, activeweapon);
}

function reset_override_visionset(timer) {
  level endon("game_ended");
  self endon("disconnect");
  wait timer;

  if(isDefined(level.vision_set_override)) {
    level notify("vision_set_change_request", level.vision_set_override, self, 0.1);
  }
}

function init_enemy_spawner() {
  scripts\cp\spawner_scoring::spawner_scoring_init();
}

function onprecachegametype() {
  level._effect["vfx_gameplay_tier2_helmet_pop"] = loadfx("vfx/iw9/gameplay/mp/vfx_gameplay_tier2_helmet_pop.vfx");
  level._effect["vfx_gameplay_tier3_helmet_pop"] = loadfx("vfx/iw9/gameplay/mp/vfx_gameplay_tier3_helmet_pop.vfx");
  scripts\cp\player_flashlight::function_41b2475a04910ba();
  scripts\cp\player_flashlight::function_47f4f9f3fa1a644d();
}

function handlenondeterministicentities() {
  level endon("game_ended");
  wait 5;
  level notify("spawn_nondeterministic_entities");

  if(isDefined(level.post_nondeterministic_func)) {
    level thread[[level.post_nondeterministic_func]]();
  }
}

function function_c47ee3c82ea9fa70() {
  flag_wait("level_ready_for_script");
  var_d560fec5da37ed20 = getEntArray("ammo_refil_station", "targetname");
  var_d560fec5da37ed20 = array_combine(getEntArray("ammo_refill_station", "targetname"), var_d560fec5da37ed20);

  if(!istrue(level.var_cee48b761f8ca747) && istrue(level.var_3480abea6656fce6)) {
    foreach(ammo_refill in var_d560fec5da37ed20) {
      ammo_refill setscriptablepartstate("military_ammo_restock", "USEABLE_ON_NO_ARMOR");
    }

    return;
  }

  if(!istrue(level.var_3480abea6656fce6) && istrue(level.var_cee48b761f8ca747)) {
    foreach(ammo_refill in var_d560fec5da37ed20) {
      ammo_refill setscriptablepartstate("military_ammo_restock", "USEABLE_ON_NO_EQUIPMENT");
    }

    return;
  }

  if(!istrue(level.var_3480abea6656fce6) && !istrue(level.var_cee48b761f8ca747)) {
    foreach(ammo_refill in var_d560fec5da37ed20) {
      ammo_refill setscriptablepartstate("military_ammo_restock", "USEABLE_ON_ONLY_AMMO");
    }
  }
}

function onplayerconnect_persistence() {
  self setplayerdata("cp", "CPSession", "timeSurvivedLastMatch", 0);
  self setplayerdata("cp", "CPSession", "isPersonalBestLastMatch", 0);
  self.xpscale = getdvarint(@ "hash_e45cd6a1e800f0a8");
  self.weaponxpscale = getdvarint(@ "hash_1f4c0cfafb6305d8");

  if(rankingenabled()) {
    var_69a07d6024aeb70b = getdvarint(@ "hash_70f2982f5218f87d");
    partyxpscale = getdvarint(@ "hash_505d6d408c8b40d2");
    isinparty = self getprivatepartysize() > 1;

    if(isDefined(var_69a07d6024aeb70b)) {
      if(isinparty && var_69a07d6024aeb70b > 1) {
        self.weaponxpscale = var_69a07d6024aeb70b;
      }
    }

    if(isDefined(partyxpscale)) {
      if(isinparty && partyxpscale > 1) {
        self.xpscale = partyxpscale;
      }
    }
  }

  self.total_currency_earned = 0;
}

function function_6a98c6da3dfa5426() {
  scripts\cp\cp_analytics::on_player_connect();
  namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_on_player_first_connect", self);
}

function onplayerconnect_vo() {
  self.num_of_plays = [];
}

function function_d215b1e8242130cd() {
  self.can_give_revive_xp = 1;

  if(isDefined(self.connecttime)) {
    self.connect_time = self.connecttime;
  } else {
    self.connect_time = gettime();
  }

  thread scripts\cp\globallogic::player_init_health_regen();
  scripts\cp\persistence::session_stats_init();
  self.recentkillcount = 0;
  self.enabledignoreme = 0;
  self.timeplayed = [];

  foreach(team in level.teamnamelist) {
    self.timeplayed[team] = 0;
  }

  self.timeplayed["total"] = 0;
  self.timeplayed["missionTeam"] = 0;
  self.timeplayed["other"] = 0;
  self.timeplayed["timeDead"] = 0;
  self.achievement_registration_func = &scripts\cp\cp_achievement::register_default_achievements;
  scripts\cp\cp_achievement::init_player_achievements(self);
  thread namespace_1170726b2799ea65::function_5c700aae58d02578();
  self.spawntimestamp = self.connect_time;
  scripts\cp\cp_mapselect::set_uav_radarstrength(self);
  scripts\cp\persistence::lb_player_update_stat("waveNum", level.wave_num, 1);
  scripts\cp\persistence::player_persistence_init();
  thread scripts\cp\cp_analytics::init_weapon_and_player_analytics(self);
  thread namespace_4e11149030890e64::function_4d36d847fd19889a();

  if(getdvarint(@ "hash_7712791fa05b41c4", 1)) {
    thread namespace_e875ad14b292bd61::function_93683605237cc77e();
  }

  thread function_2289174c824d5dfa();
  thread function_e33b20f5fe616a();
  self.disabledteleportation = 0;
  allow_player_teleport(0);
  thread function_a54323530992c18();

  if(level.pingsystemactive) {
    scripts\cp_mp\calloutmarkerping::calloutmarkerping_initplayer();
  }

  if(function_a2a780464918dc3a() && getdvarint(@ "hash_b7d46b36430341a5", 0)) {
    level thread namespace_ba155a12c323dc5a::function_504a6eecbc2db511(self);
  }

  thread namespace_1170726b2799ea65::function_57d85dbfbd24236();
  self.powers = [];
  self.powers_active = [];
  self.power_cooldowns = 0;
  self.disabled_interactions = [];
  self.disabledinteractions = 0;
  self.pap = [];
  self.self_revives_purchased = 0;
  self.max_self_revive_machine_use = 3;
  self.cash_scalar = 1;
  self.infiniteammocounter = 0;
  self.enabledbasejumping = 0;

  if(istestclient(self)) {
    thread testclient_ignoreme_dvar();
  }

  scripts\cp\cp_outofbounds::enableoobimmunity(self);
  self setclientomnvar("ui_show_tac_map", 1);

  if(getdvarint(@ "hash_dbb53c7a147a3ed1", 0) == 0) {
    self setclientomnvar("ui_dungeon_extended_load_screen", 1);
  }
}

function function_a9a4fd8118e8faaf() {
  namespace_1170726b2799ea65::function_8f65921ce7cbe746();
}

function testclient_ignoreme_dvar() {
  if(getdvarint(@ "hash_bb2888f50eae5956", 0) == 0) {
    return;
  }

  wait 3;
  self.ignoreme = 1;
}

function function_e33b20f5fe616a() {
  level endon("game_ended");

  while(true) {
    self waittill("luinotifyserver", channel, index);

    if(channel == "<dev string:x238>") {
      map_name = getDvar(@ "ui_mapname");
      objective_table = "<dev string:x245>" + map_name + "<dev string:x249>";
      objective_ref = tablelookup(objective_table, 0, index, 1);
      mission_dvar = hashcat(@ "hash_287b3b75f2c14fe9", map_name);
      setdvarifuninitialized(mission_dvar, objective_ref);
      setDvar(mission_dvar, objective_ref);
      scripts\cp\endgame::function_180b06d3d67d483c("<dev string:x259>");
      scripts\cp\endgame::restart_map(undefined, "<dev string:x26b>");
    }

    if(function_53aa0268e875eafb()) {
      if(channel == "restart_from_checkpoint") {
        function_b1371367551b7b36(2);

        if(isDefined(level.var_633ee74e2649aac7)) {
          [[level.var_633ee74e2649aac7]]();
        }

        scripts\cp\endgame::freezeallplayers(1, @ "hash_682a9bc40f96ca4a", 1);

        foreach(player in level.players) {
          level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0.5);
          player.ignoreme = 1;
          player.ability_invulnerable = 1;
          player notify("force_regeneration");
        }

        scripts\cp\endgame::function_180b06d3d67d483c("Restart From Checkpoint Used");
        wait 2;
        scripts\cp\endgame::restart_map(undefined, "map_restart");
      }

      if(channel == "mission_restart") {
        scripts\cp\cp_checkpoint::function_5ace495feba111d3();
        function_b1371367551b7b36(1);
        game["star_rewards_times"] = undefined;
        game["start_time"] = undefined;

        if(isDefined(level.var_633ee74e2649aac7)) {
          [[level.var_633ee74e2649aac7]](1);
        }

        scripts\cp\cp_checkpoint::checkpoint_set("");
        scripts\cp\endgame::freezeallplayers(1, @ "hash_682a9bc40f96ca4a", 1);

        foreach(player in level.players) {
          player scripts\cp\cp_checkpoint::function_903f68999f98fa78();
          player.pers["loadout"] = undefined;
          player.pers["equipment"] = undefined;
          player.pers["super"] = undefined;
          player.pers["intel"] = undefined;
          level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0.5);
        }

        scripts\cp\endgame::function_180b06d3d67d483c("Mission Restart Used");

        for(i = 0; i < level.players.size; i++) {
          level.players[i].ignoreme = 1;
          level.players[i].ability_invulnerable = 1;
          level.players[i] notify("force_regeneration");
        }

        scripts\cp\endgame::restart_map(undefined, "pauseMenu_restart");
      }

      continue;
    }

    if(channel == "mission_restart" || channel == "restart_from_checkpoint") {
      thread scripts\cp\cp_hud_message::tutorialprint(&"COOP_GAME_PLAY/RESTART_DISABLED", 5);
    }
  }
}

function function_b1371367551b7b36(value) {
  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] == self) {
      continue;
    }

    level.players[i] setclientomnvar("ui_restart_selected", value);
  }
}

function function_53aa0268e875eafb() {
  if(istrue(level.var_bbeefad58b75989a)) {
    return false;
  }

  return true;
}

function function_cd054d9ba5a62557(bool) {
  level.var_bbeefad58b75989a = !bool;
}

function ascendermsgfunc(txt, time) {
  level endon("game_ended");
  self endon("disconnect");
  hint_prompt(txt, 1);
  wait time;
  hint_prompt(txt, 0);
}

function function_82261e20cacb4de8(player) {
  return false;
}

function private function_c2a07e33f145f082() {}

function onspawnplayer(fauxspawn) {
  self.fireshield = 0;
  self.isreviving = 0;
  self.iscarrying = 0;
  self.burning = undefined;
  self.no_outline = 0;
  self.disabledteleportation = 0;
  self.disabledinteractions = 0;
  self.can_teleport = 1;

  if(!isDefined(self.enabledignoreme)) {
    self.enabledignoreme = 0;
  }

  if(!isDefined(self.ignoreme)) {
    self.ignoreme = 0;
  }

  self.hide_tutorial = 1;
  self.flung = undefined;
  self.is_holding_deployable = 0;
  self.has_special_weapon = 0;
  self.lastkilltime = gettime();
  self.lastmultikilltime = gettime();
  self.class = "none";
  self.armorqueued = 0;
  val::nuke_all();
  scripts\cp_mp\utility\damage_utility::cleardamagemodifiers();
  thread scripts\cp\perks::watchcombatspeedscaler();

  if(isDefined(level.custom_onspawnplayer_func)) {
    self[[level.custom_onspawnplayer_func]]();
  }

  if(istrue(level.parachutecancutautodeploy)) {
    self skydive_cutautodeployon();
  } else {
    self skydive_cutautodeployoff();
  }

  if(istrue(level.parachutecancutparachute)) {
    self skydive_cutparachuteon();
  } else {
    self skydive_cutparachuteoff();
  }

  scripts\cp\globallogic::player_init_invulnerability();
  scripts\cp\globallogic::player_init_damageshield();
  thread namespace_ee632c9a776f5f85::function_ed62d4f89b19c4f7();
  thread scripts\cp\laststand::function_73707f2512aa6814();
  thread add_player_to_threatbias_group();
  thread scripts\cp\coop_personal_ents::assignpersonalmodelents(self);
  thread scripts\cp\coop_personal_ents::movepentstostructs(self);

  if(function_6aafbdd00b977115()) {
    thread scripts\cp\equipment\nvg::runnvg();
  }

  if(isDefined(self.anchor)) {
    self.anchor delete();
  }

  force_usability_enabled();
  self.hasspawned = 1;
  self.pers["hasSpawned"] = 1;
  thread function_92a83310ab07ac05();

  if(isDefined(level.devgui_setup_func)) {
    self thread[[level.devgui_setup_func]](self);
  }
}

function add_player_to_threatbias_group() {
  for(i = 0; i < level.players.size; i++) {
    if(self == level.players[i]) {
      group_num = i + 1;

      if(group_num == 5) {
        return;
      }

      self setthreatbiasgroup("player" + group_num);
    }
  }
}

function prespawnfromspectatorfunc(player) {
  if(istrue(level.var_f4c8727cac33c176)) {
    player.var_57c207fde9b78089 = 1;
  }

  revivefromspectatorweaponsetup(player);
  set_spawn_loc(player);
}

function revivefromspectatorweaponsetup(player) {
  weaponlist = spawnStruct();
  weaponlist.copy_fullweaponlist = player.copy_fullweaponlist;
  weaponlist.copy_weapon_current = player.copy_weapon_current;
  weaponlist.copy_weapon_ammo_clip = player.copy_weapon_ammo_clip;
  weaponlist.copy_weapon_ammo_stock = player.copy_weapon_ammo_stock;

  if(isDefined(player.saved_last_stand_pistol)) {
    weaponlist.last_stand_pistol = player.saved_last_stand_pistol;
    player.saved_last_stand_pistol = undefined;
  } else {
    weaponlist.last_stand_pistol = player.last_stand_pistol;
  }

  weaponlist.weapon_levels = player.copy_weapon_level;

  if(isDefined(player.current_crafted_inventory)) {
    weaponlist.current_crafted_inventory = player.current_crafted_inventory;
    player.current_crafted_inventory = undefined;
  }

  weaponlist.copy_all_powers = player.pre_laststand_powers;
  weaponlist.copy_special_ammo_type = player.special_ammo_type;
  player.weaponlist = weaponlist;
}

function set_spawn_loc(player) {
  spawnpoint = getplayerrespawnloc(player);
  player scripts\cp\globallogic::setforcespawninfo(spawnpoint.origin, spawnpoint.angles);

  if(isDefined(player.respawn_forcespawnorigin)) {
    player.forcespawnorigin = player.respawn_forcespawnorigin;
  }

  if(isDefined(player.respawn_forcespawnangles)) {
    player.forcespawnangles = player.respawn_forcespawnangles;
  }
}

function getplayerrespawnloc(downed_player) {
  if(isDefined(level.force_respawn_location)) {
    return [[level.force_respawn_location]](downed_player);
  }

  if(!isDefined(level.active_player_respawn_locs) || level.active_player_respawn_locs.size == 0 || level.players.size == 0) {
    return [[level.getspawnpoint]]();
  }

  if(isDefined(level.respawn_loc_override_func)) {
    return [[level.respawn_loc_override_func]](downed_player);
  }

  available_respawn_locs = get_available_respawn_locs();

  if(available_respawn_locs.size == 0) {
    return get_respawn_loc_near_team_center(downed_player);
  }

  if(available_respawn_locs.size == 1) {
    return available_respawn_locs[0];
  }

  return downed_player get_respawn_loc_rated(available_respawn_locs);
}

function get_available_respawn_locs() {
  available_respawn_locs = [];

  foreach(var_c337fc4166b34662 in level.active_player_respawn_locs) {
    if(!canspawn(var_c337fc4166b34662.origin)) {
      continue;
    }

    if(positionwouldtelefrag(var_c337fc4166b34662.origin)) {
      continue;
    }

    if(is_respawn_loc_near_alive_enemies(var_c337fc4166b34662)) {
      continue;
    }

    available_respawn_locs[available_respawn_locs.size] = var_c337fc4166b34662;
  }

  return available_respawn_locs;
}

function is_respawn_loc_near_alive_enemies(respawn_loc) {
  alive_enemies = scripts\mp\mp_agent::getaliveagentsofteam("axis");

  foreach(alive_enemy in alive_enemies) {
    if(distancesquared(alive_enemy.origin, respawn_loc.origin) < 250000) {
      return true;
    }
  }

  return false;
}

function get_respawn_loc_near_team_center(downed_player) {
  team_x = 0;
  team_y = 0;
  team_z = 0;
  counter = 0;
  team_center = (team_x / counter, team_y / counter, team_z / counter);
  var_2d6c745afab7a7b1 = sortbydistance(level.active_player_respawn_locs, team_center);
  return var_2d6c745afab7a7b1[0];
}

function get_respawn_loc_rated(available_respawn_locs) {
  var_5408a7783ca52166 = level.spawned_enemies.size;
  var_620c96a13d50e7bd = var_5408a7783ca52166 * 2;
  var_a7b39f36afad5914 = -99999999;
  var_d024cacec9d41efd = undefined;

  foreach(var_fdf23b2021e21ba2 in available_respawn_locs) {
    var_2cec23ddabf59363 = 0;

    foreach(spawned_enemy in level.spawned_enemies) {
      var_2cec23ddabf59363 += distancesquared(spawned_enemy.origin, var_fdf23b2021e21ba2.origin);
    }

    var_2cec23ddabf59363 /= 1000000;

    if(var_2cec23ddabf59363 > var_a7b39f36afad5914) {
      var_a7b39f36afad5914 = var_2cec23ddabf59363;
      var_d024cacec9d41efd = var_fdf23b2021e21ba2;
    }
  }

  if(!isDefined(var_d024cacec9d41efd)) {
    println("<dev string:x277>");
  }

  return var_d024cacec9d41efd;
}

function getspawnpoint() {
  if(flag_exist("strike_init_done")) {
    flag_wait("strike_init_done");
  }

  default_spawners = getStructArray("default_player_start", "targetname");

  if(isDefined(level.default_player_spawns)) {
    override_spawners = getStructArray(level.default_player_spawns, "targetname");

    if(override_spawners.size > 0) {
      default_spawners = override_spawners;
    }
  }

  if(scripts\engine\utility::issharedfuncdefined("player_spawn", "getPlayerSpawnPointOverride")) {
    funcname = scripts\engine\utility::getsharedfunc("player_spawn", "getPlayerSpawnPointOverride");
    return [[funcname]](default_spawners);
  }

  return getassignedspawnpoint(default_spawners);
}

function getassignedspawnpoint(spawnpoints) {
  assertex(spawnpoints.size > 0, "No spawn points found");
  player_entity_num = self getentitynumber();
  assertex(isDefined(spawnpoints[player_entity_num]), "No spawn point for player ID: " + player_entity_num);

  if(positionwouldtelefrag(spawnpoints[player_entity_num].origin)) {
    foreach(spawnpoint in spawnpoints) {
      if(positionwouldtelefrag(spawnpoint.origin)) {
        continue;
      }

      return spawnpoint;
    }
  }

  return spawnpoints[player_entity_num];
}

function private function_338905fc43e34e95() {}

function prematchfunc() {
  prematchperiod = 0;

  if(prematchperiod > 0) {
    player = level wait_for_first_player_connect();
    wait prematchperiod - 3;

    if(isDefined(level.postintroscreenfunc)) {
      [[level.postintroscreenfunc]]();
    }

    flag_set("introscreen_over");
    level.introscreen_done = 1;
  } else {
    level.introscreen_done = 1;
    flag_set("introscreen_over");
  }

  if(istrue(level.intermission)) {
    return;
  }
}

function onplayerdisconnect(var_2421296ba8ccb5ee, reason) {
  var_2421296ba8ccb5ee setplayerdata("cp", "CPSession", "subParty", -1);
  scripts\cp\persistence::eog_update_on_player_disconnect(var_2421296ba8ccb5ee);

  if(isDefined(level.fn_onplayerdisconnect)) {
    [[level.fn_onplayerdisconnect]](var_2421296ba8ccb5ee);
  }
}

function wait_for_first_player_connect() {
  player = undefined;

  if(level.players.size == 0) {
    level waittill("connected", player);
  } else {
    player = level.players[0];
  }

  return player;
}

function function_a54323530992c18() {
  if(isDefined(level.strike_player_connect_black_screen_fn)) {
    [[level.strike_player_connect_black_screen_fn]](self);
    return;
  }

  level function_42a9d27a643fe345(self);
}

function function_42a9d27a643fe345(player) {
  if(istrue(function_ab7b0eb488a92ec2())) {
    level.player thread function_d099c5897e9877a0();
  }
}

function function_d099c5897e9877a0() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  level waittill("show_chyrons", delay, duration);

  if(isDefined(delay)) {
    wait delay;
  }

  show_introscreen_text();
  displayduration = 6;

  if(isDefined(duration)) {
    displayduration = duration;
  }

  wait displayduration;
  function_b809ac841a0c626e();
}

function function_ab7b0eb488a92ec2() {
  if(getdvarint(@ "hash_8e13d59b3f6a0521") || istrue(level.var_37190777eeb4333f)) {
    return true;
  }

  map_name = getDvar(@ "ui_mapname");
  obj_ref = getDvar(hashcat(@ "hash_287b3b75f2c14fe9", map_name), function_62438bc91ac11d42());
  return isDefined(obj_ref) && obj_ref != "";
}

function show_introscreen_text() {
  flag_set("chyrons_on");
  map_name = getDvar(@ "ui_mapname");
  obj_ref = getDvar(hashcat(@ "hash_287b3b75f2c14fe9", map_name), function_62438bc91ac11d42());
  objective_table = "cp/" + map_name + "_objectives.csv";
  objective_index = int(tablelookup(objective_table, 1, obj_ref, 0));

  if(isDefined(obj_ref) && obj_ref != "") {
    self setclientomnvar("ui_chyron_mission_index", objective_index);
    self setclientomnvar("ui_chyron_on", 1);
  }
}

function function_b809ac841a0c626e() {
  self setclientomnvar("ui_chyron_mission_index", 0);
  self setclientomnvar("ui_chyron_on", 0);
  flag_clear("chyrons_on");
}

function function_62438bc91ac11d42() {
  switch (level.script) {
    case #"hash_6b2477606925177a":
    case #"hash_9883158f04265d18":
      return "obj_find_hostage";
    case #"hash_c3c819184bc33817":
      return "obj_reconArea";
    case #"hash_8e2389607af0427b":
      return "obj_bombs";
    case #"hash_5c03122b70ff4094":
      return "obj_retrieve_trackers";
    case #"hash_619829c7b3c4c3e3":
      return "obj_search";
    case #"hash_3705bde815a332ea":
      return "obj_reach_comms";
    default:
      println("<dev string:x299>");
      return "";
  }
}

function private function_a5119983dfc1efbc() {}

function callbackplayerkilled(inflictor, attacker, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration) {
  scripts\cp\damage::playerkilled_internal(inflictor, attacker, self, damage, damageflags, meansofdeath, objweapon, direction_vec, hitloc, psoffsettime, deathanimduration, 0);
}

function enter_laststand(player, attacker) {
  player scripts\cp\persistence::eog_player_update_stat("downs", 1);
  player scripts\cp\cp_analytics::log_event("dropped_to_last_stand", 1, [player.clientid], [player.clientid], [player.clientid]);
  player.pre_arcade_game_weapon = undefined;
  player.pre_arcade_game_weapon_clip = undefined;
  player.pre_arcade_game_weapon_stock = undefined;
  player.former_mule_weapon = undefined;
  player scripts\cp\equipment::store_equipment();
  player scripts\cp_mp\equipment::clearallequipment();
  currentweapon = player getcurrentweapon();
  currentweapon_name = getweaponbasename(currentweapon);
  var_6a3b7f7386ab3be8 = player getcurrentweaponclipammo();

  if(!isDefined(player.downsperweaponlog[currentweapon_name])) {
    player.downsperweaponlog[currentweapon_name] = 1;
  } else {
    player.downsperweaponlog[currentweapon_name]++;
  }

  player clearclienttriggeraudiozone(0);

  if(!self issplitscreenplayer()) {
    player setclienttriggeraudiozonepartialwithfade("last_stand_cp", 0.02, "mix", "reverb", "filter");
  }

  have_self_revive = player has_auto_revive();

  if(have_self_revive) {
    var_f4a1f546fffcd5e4 = isplayingsolo() || level.only_one_player;
    player notify("player_has_self_revive", var_f4a1f546fffcd5e4);
  }

  if(isDefined(player.mule_weapon) && !istrue(player.playing_ghosts_n_skulls)) {
    player.former_mule_weapon = player.mule_weapon;
  } else {
    player.former_mule_weapon = undefined;
  }

  player allow_player_ignore_me(1);
  player setclientomnvar("ui_is_laststand", 1);
}

function endgame_clientmatchdata(player, player_index) {}

function update_laststand_times() {
  scripts\cp\laststand::init_laststand_anims();
  inanim = level.scr_anim["ls_revive_helper"]["in_stand_1"];
  idleanim = level.scr_anim["ls_revive_helper"]["idle_stand_1"];
  outanim = level.scr_anim["ls_revive_helper"]["out_stand_1"];
  var_f05037a2663b00d9 = getanimlength(inanim);
  var_2385b76cf2542716 = getanimlength(idleanim);
  var_dcd276b4fda552a = getanimlength(outanim);
  buffer = 0.5;
  normal_revive_time = (var_f05037a2663b00d9 + var_2385b76cf2542716 + var_dcd276b4fda552a + buffer) * 1000;
  spectator_revive_time = 5000;
  fast_revive_time = (var_f05037a2663b00d9 + var_dcd276b4fda552a + buffer) * 1000;
  scripts\cp\laststand::set_revive_time(normal_revive_time, spectator_revive_time, fast_revive_time);
}

function private function_cb23fd43fd34357f() {}

function function_52343d5c1b190cf0() {
  level.tier1modeenabled = getdvarint(@ "hash_127490a7577f169f", 0);

  if(!istrue(level.tier1modeenabled)) {
    return;
  }

  level.var_ee05489a095df4d1 = getdvarint(@ "hash_509b01d1370107af", 0) == 1;
  level.var_11d8636343eae20c = getdvarint(@ "hash_e05a6970966d8552", 0);
  level.var_accb27010daa82d = getdvarint(@ "hash_4a592b7d1efa862d", 0);
  level.var_1921cb8dd51a8f73 = getdvarint(@ "hash_4c748c9425636394", 1);
  level.var_a80e6d45222f9a47 = 0;
  level.var_f63478bca59e2670 = getdvarint(@ "hash_3b76545d82d3fd12", 4);
  level.testrandomrealismclients = getdvarint(@ "hash_596700a25033a832", 0) == 1;

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    level.healthregendisabled = 1;
  }

  setomnvar("ui_realism_mode", scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924());

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    level.modifyplayerdamage = &scripts\cp\damage::gamemodemodifyplayerdamage;
    setDvar(@ "jump_slowdownenable", 1);
    setDvar(@ "sprintleap_enabled", 0);
    level.var_57ece26e490ad8c4 = 1;

    if(istrue(level.var_1921cb8dd51a8f73)) {
      level.var_26109c02a53cea84 = [];
      level.var_26109c02a53cea84["rocketlauncher"] = getdvarfloat(@ "hash_2b6ceef99f7c775", 0.75);
      level.var_26109c02a53cea84["sniper"] = getdvarfloat(@ "hash_2b2aaef99f38272", 0.8);
      level.var_26109c02a53cea84["mg"] = getdvarfloat(@ "hash_263c3ef999d0b4f", 0.85);
      level.var_26109c02a53cea84["rifle"] = getdvarfloat(@ "hash_274c6ef99af1c44", 0.9);
      level.var_26109c02a53cea84["smg"] = getdvarfloat(@ "hash_2b2a9ef99f3803f", 0.95);
      level.var_26109c02a53cea84["spread"] = getdvarfloat(@ "hash_2b2b3ef99f3963d", 0.95);
      level.var_26109c02a53cea84["grenade"] = getdvarfloat(@ "hash_27db6ef99b917c2", 1);
      level.var_26109c02a53cea84["melee"] = getdvarfloat(@ "hash_263c5ef999d0fb5", 1);
      level.var_26109c02a53cea84["pistol"] = getdvarfloat(@ "hash_2bfa5ef9a018bf8", 1);
    }

    if(!isusingmatchrulesdata()) {
      setDvar(@ "scr_game_enableminimap", 0);
      setDvar(@ "scr_player_maxhealth", 30);
      setDvar(@ "scr_player_healthregentime", 0);
      setDvar(@ "scr_team_fftype", 4);
      setDvar(@ "scr_game_allowkillcam", 0);
      setDvar(@ "scr_player_allowarmor", 0);
      setDvar(@ "scr_player_spawnarmor", 0);
      setDvar(@ "hash_8ad1ab9436bccca", 0);
      setDvar(@ "hash_28d450f7f28644b7", 0);
      setDvar(@ "scr_game_allow_loot", 0);
    }

    scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&function_3708850eab3864c2);
    scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(&function_3708850eab3864c2);
  }
}

function function_3708850eab3864c2() {
  if(istrue(level.testrandomrealismclients)) {
    if(!isDefined(self.isrealismenabled)) {
      if(cointoss()) {
        self setclientomnvar("ui_realism_hud", 1);
        self.isrealismenabled = 1;
      } else {
        self setclientomnvar("ui_realism_hud", 0);
        self.isrealismenabled = 0;
      }
    }

    return;
  }

  self setclientomnvar("ui_realism_hud", scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924());
}

function private function_7d0c276084275566() {}

function load_binks() {
  if(!scripts\cp\cp_checkpoint::checkpoint_isset() && is_default_start()) {
    index = namespace_d6cca25f4b0ab62::getlevelindex(level.script);

    if(isDefined(index)) {
      bink = namespace_d6cca25f4b0ab62::getlevelbink(index);

      if(isDefined(bink)) {
        setomnvar("ui_transition_movie", bink);
      }
    }
  }
}

function private function_9e93918f5afdbc59() {}

function destructible_vehicle_init() {
  thread destructible_vehicle_main();
}

function destructible_vehicle_main() {
  flag_wait("scriptables_ready");
  flag_wait("level_ready_for_script");
  scriptables = getEntArray("scriptable", "code_classname");

  foreach(scriptable in scriptables) {
    if(scriptable.model == "" && (issubstr(scriptable.classname, "veh_") || issubstr(scriptable.classname, "veh8_") || issubstr(scriptable.classname, "veh9_"))) {
      scriptable thread destructible_vehicle_thread();
      continue;
    }

    if(issubstr(scriptable.model, "veh_") || issubstr(scriptable.model, "veh8_") || issubstr(scriptable.model, "veh9_")) {
      scriptable thread destructible_vehicle_thread();
    }
  }
}

function destructible_vehicle_thread() {
  self.destructible_type = "vehicle";

  while(true) {
    self waittill("scriptableNotification", note, param);

    switch (note) {
      case #"hash_e5776eac05aaee34":
      case #"hash_f292a20224944002":
        thread burningcar_indicator();
        break;
      case #"hash_3b9cb3e6d5ebb052":
      case #"hash_65f8b242ffc4f6e8":
      case #"hash_ac44ea5d34937252":
        self notify("destroyed");

        if(isDefined(self.burningcarindicator)) {
          self.burningcarindicator delete();
        }

        self.onfire = undefined;
        return;
    }
  }
}

function burningcar_indicator() {
  if(isDefined(self.burningcarindicator)) {
    return;
  }

  self endon("destroyed");
  self.onfire = 1;
  wait 0.2;
  self.burningcarindicator = magicgrenademanual("car_grenade", self.origin + (0, 0, 10), (0, 0, 0));
  self.burningcarindicator.targetname = "offhand_car_grenade";
  self.burningcarindicator makeunusable();
}