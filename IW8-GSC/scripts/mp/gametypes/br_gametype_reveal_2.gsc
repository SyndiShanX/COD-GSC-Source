/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_reveal_2.gsc
*********************************************************/

function init() {
  level.ref_12ce8 = spawnStruct();
  level.ref_12ce8.level_carepackage_drop_defined = getdvarint("scr_br_reveal_2_delete_loot_radius", 128);
  level.ref_12ce8.ref_13b75 = getdvarint("scr_br_reveal_2_timed_section_1", 35);
  level.ref_12ce8.ref_13b77 = getdvarint("scr_br_reveal_2_timed_section_2", 60);
  level.ref_12ce8.ref_13b79 = getdvarint("scr_br_reveal_2_timed_section_3", 15);
  level.ref_12ce8.ref_13bf9 = getdvarint("scr_br_reveal_2_time_before_force_end", 570);
  level.ref_12ce8.ref_13bfa = getdvarint("scr_br_reveal_2_time_ground_state_before_force_end", 240);
  level.ref_12ce8.ref_13b6e = getdvarint("scr_br_reveal_2_time_added_when_dropped", 0);
  level.ref_12ce8.level_carepackage_give_player_killstreak_incendiary_launcher = relic_nuketimer_addtotimer();
  level.ref_12ce8.ref_12345 = 0;
  level.ref_12ce8.ref_14385 = level.ref_12ce8.ref_13b77;
  level.ref_12ce8.ref_145cc = getdvarint("scr_br_reveal_2_device_win_time", 180);
  level.ref_12ce8.ref_13a17 = undefined;
  level.ref_12ce8.ref_13a1b = undefined;
  level.ref_12ce8.ref_13a1a = undefined;
  level.ref_12ce8.ref_13a19 = undefined;
  level.ref_12ce8.ref_129c4 = getdvarint("scr_br_reveal_2_device_holder_uav", 1);
  level.ref_12ce8.playerplunderbank = getdvarint("scr_br_reveal_2_force_quick_respawn", 0);
  level.ref_12ce8.playersetattractionbesttime = getdvarfloat("scr_br_tactical_device_friendly_icon_ping_rate", 0);
  level.ref_12ce8.nuclear_core_carrier_escaped = getdvarfloat("scr_br_tactical_device_enemy_icon_ping_rate", 0);
  level.ref_12ce8.player_pushing_vehicle_monitor = getdvarint("scr_br_reveal_2_flavor_quantity_players", 21);
  level.ref_12ce8.ref_145ce = 0;
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("teamSpectate");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("oneLife");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("match_start_VO");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("circle");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("randomizeCircleCenter");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("plunderSites");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("planeSnapToOOB");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("vehicleSpawns");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("giveStartFieldUpgrade");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("prematchBlueprints");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("allowLateJoiners");
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("circleEarlyStart");
  scripts\mp\gametypes\br_gametypes::ref_12b11("onPlayerKilled", &onplayerkilled);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerKilledSpawn", &playerrespawn);
  scripts\mp\gametypes\br_gametypes::ref_12b11("getFinalCircleCenter", &ref_12cf4);
  scripts\mp\gametypes\br_gametypes::ref_12b11("mapCenterFinalCircle", &ref_12cf4);
  scripts\mp\gametypes\br_gametypes::ref_12b11("onKillstreakBeginUseFunc", &ref_12048);
  scripts\mp\gametypes\br_gametypes::ref_12b11("dropBRKillstreak", &missing_window_blockers);
  scripts\mp\gametypes\br_gametypes::ref_12b11("createC130PathStruct", &ref_12cee);
  scripts\mp\gametypes\br_gametypes::ref_12b11("addToC130Infil", &ref_12cec);
  scripts\mp\gametypes\br_gametypes::ref_12b11("prematchSpawnMaxLocations", &ref_12862);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_tactical_device", "onCrateActivate", &ref_1200d);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_tactical_device", "onCrateUse", &ref_1200f);
  scripts\cp_mp\utility\script_utility::registersharedfunc("br_tactical_device", "onCrateDestroy", &ref_1200e);
  level.ref_133e0 = 0;
  level.scriptedphysicaldofenabled = 1;
  level.parachuterestoreweaponscb = &blankfunc;
  level.disableforfeit = 1;
  level.debug_safehouse_gunshop_start = 0;
  level.skipprematchdropspawn = 0;
  level.ref_11e96 = 1;
  level._effect["smoke_tactical_device"] = loadfx("vfx/iw8_br/gameplay/vfx_br_crate_smoke_signal.vfx");
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&ref_1206a);
  game["dialog"]["gametype_dov2"] = "gametype_dov2";
  game["dialog"]["gametype_desc_dov2"] = "gametype_desc_dov2";
  game["dialog"]["gametype_desc_dov2_crit"] = "gametype_desc_dov2_crit";
  game["dialog"]["intro_destroy"] = "intro_destroy";
  game["dialog"]["deploying_soon_nuke"] = "deploying_soon_nuke";
  game["dialog"]["inbound_nuke"] = "inbound_nuke";
  game["dialog"]["hold_device"] = "hold_device";
  game["dialog"]["30_seconds_nuke"] = "30_seconds_nuke";
  game["dialog"]["ready_nuke"] = "ready_nuke";
  game["dialog"]["activate_destroy"] = "activate_destroy";
  game["dialog"]["activate_now"] = "activate_now";
  game["dialog"]["activated_nuke"] = "activated_nuke";
  game["dialog"]["dont_listen_now"] = "dont_listen_now";
  game["dialog"]["thank_you_soldiers"] = "thank_you_soldiers";
  game["dialog"]["destroyer_you_are"] = "destroyer_you_are";
  game["dialog"]["lose_too_late"] = "lose_too_late";
  game["dialog"]["lose_what"] = "lose_what";
  game["dialog"]["lose_over"] = "lose_over";
  game["dialog"]["lose_fail"] = "lose_fail";
  game["dialog"]["win_had_to"] = "win_had_to";
  game["dialog"]["win_time"] = "win_time";
  game["dialog"]["win_saved"] = "win_saved";
  game["dialog"]["flavor_what"] = "flavor_what";
  game["dialog"]["flavor_thought"] = "flavor_thought";
  game["dialog"]["flavor_mistake"] = "flavor_mistake";
  game["dialog"]["flavor_turn_off"] = "flavor_turn_off";
  game["dialog"]["flavor_again"] = "flavor_again";
  game["dialog"]["flavor_tick"] = "flavor_tick";
  game["dialog"]["flavor_other_side"] = "flavor_other_side";
  game["dialog"]["flavor_gone"] = "flavor_gone";
  game["dialog"]["flavor_danger"] = "flavor_danger";
  game["dialog"]["flavor_warn"] = "flavor_warn";
  game["dialog"]["flavor_history"] = "flavor_history";
  game["dialog"]["flavor_learn"] = "flavor_learn";
  game["dialog"]["flavor_doomed"] = "flavor_doomed";
  game["dialog"]["flavor_not_last"] = "flavor_not_last";
  game["dialog"]["op3_dov2_dont_activate"] = "op3_dov2_dont_activate";
  game["dialog"]["op3_dov2_wait_activate"] = "op3_dov2_wait_activate";
  game["dialog"]["op3_dov2_more_time"] = "op3_dov2_more_time";
  game["dialog"]["op3_dov2_think"] = "op3_dov2_think";
  game["dialog"]["op3_dov2_choice"] = "op3_dov2_choice";
  game["dialog"]["op3_dov2_still_fight"] = "op3_dov2_still_fight";
  game["dialog"]["op2_dov1_infil_3_10"] = "op2_dov1_infil_3_10";
  game["dialog"]["op1_dov1_infil_1_10"] = "op1_dov1_infil_1_10";
  thread toggleusbstickinhand();
}

function toggleusbstickinhand() {
  waittillframeend();
  scripts\mp\flags::gameflaginit("dov2_timed_section_1", 0);
  scripts\mp\flags::gameflaginit("dov2_timed_section_2", 0);
  scripts\mp\flags::gameflaginit("dov2_timed_section_3", 0);
  scripts\mp\flags::gameflaginit("dov2_final_bink", 0);
  level.ref_12888 = &emp_drone_proximity_explode;
  level.ref_11c76 = &dyn_door;
  level.modeonspawnplayer = &onspawnplayer;
  level.disable_back_light = 1;
  level.playerkillstreakgetownerlookatignoreents = 1;
  thread ref_12d09();
}

function blankfunc() {}

function relic_nuketimer_addtotimer() {
  if(level.script == "mp_br_mechanics") {
    return (90, 90, 40);
  }

  return getdvarvector("scr_br_reveal_2_device_spawn_location", (-69, 986, 1770));
}

function ref_12d09() {
  level endon("game_ended");
  level endon("force_end_sequence_time_spent_in_same_state");
  level endon("force_end_sequence_time_limit");
  thread ref_12866();
  level waittill("infils_ready");
  wait 2;
  ref_12cfb();
  thread ref_13b74();
  ref_12d0a(level.ref_12ce8.ref_13b75);
  thread ref_13b76();
  ref_12d0a(level.ref_12ce8.ref_13b77);
  level waittill("dov2_device_used");
  thread ref_13b78(undefined);
  ref_12d0a(level.ref_12ce8.ref_13b79);
  ref_12cf3(1);
  thread ref_12cf0();
}

function ref_12866() {
  level endon("game_ended");
  level endon("prematch_done");
  level waittill("start_prematch");
  wait 45;

  foreach(var_1 in level.players) {
    thread ref_12d0d(var_1);
  }
}

function ref_13b74() {
  scripts\mp\flags::gameflagset("dov2_timed_section_1");
  thread playerlocationtriggerenter();
  scripts\mp\gametypes\br_gametypes::move_molotov_mortar("doFirstUnusedPrematchSpawnOrigin");
  level notify("cancel_watch_parachuters_overhead");
  ref_1366f();
  level thread scripts\mp\gametypes\br_gametype_reveal::ref_12d0f(6, 4, 0, 1);
  setomnvar("ui_br_circle_state", 4);

  foreach(var_1 in level.players) {
    var_1 scripts\mp\gametypes\br_armor::searchcirclesize();
  }

  wait level.ref_12ce8.ref_13b75 - 8;
  level notify("zombie_outbreak_1_start");
}

function ref_13b76() {
  scripts\mp\flags::gameflagset("dov2_timed_section_2");
  ref_13a1d();
  wait 1;
  level thread scripts\mp\gametypes\br_public::brleaderdialog("gametype_desc_dov2", 0, level.players);
  level thread scripts\mp\gametypes\br_public::brleaderdialog("deploying_soon_nuke", 0, level.players);
  wait 13;
  level notify("zombie_outbreak_2_start");
  wait 14;
  level notify("zombie_outbreak_3_start");
  wait 14;
  level notify("zombie_outbreak_4_start");
  wait level.ref_12ce8.ref_13b77 - 42;
  ref_13670();
  ref_13a1f();
  wait 40;
  thread ref_11f1b();
}

function ref_13b78(var_0) {
  scripts\mp\flags::gameflagset("dov2_timed_section_3");
  var_1 = 0;
  var_2 = 255;
  animscripted_loop_earlyend(var_1, var_2, undefined, 0);

  foreach(var_4 in level.players) {
    if(scripts\mp\utility\player::unset_relic_trex(var_4)) {
      var_4 scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", var_4);
    }
  }

  foreach(var_4 in level.players) {
    var_4.plotarmor = 1;
  }

  if(isDefined(level.ref_12ce8.ref_13a17)) {
    if(isDefined(level.ref_12ce8.ref_13a17.owner)) {
      level.ref_12ce8.ref_13a17.owner scripts\mp\killstreaks\killstreaks::clearkillstreaks();
    } else {
      ref_13a18();
    }
  }

  thread ref_11f1a(var_0);
  thread ref_11f13();
  thread ref_11f17(level.ref_12ce8.ref_13b79);

  if(level.mapname != "mp_br_mechanics") {
    thread ref_11f12(level.ref_12ce8.ref_13b79);
  }

  thread ref_11f16(level.ref_12ce8.ref_13b79 + 5, 6);
  thread ref_11f15(level.ref_12ce8.ref_13b79 + 5);
  thread ref_13365(level.ref_12ce8.ref_13b79);
}

function playerlocationtriggerenter() {
  level endon("game_ended");
  level endon("dov2_device_used");
  level endon("force_end_sequence_time_spent_in_same_state");
  wait level.ref_12ce8.ref_13bf9;
  level notify("force_end_sequence_time_limit");
  thread ref_13b78(1);
  ref_12d0a(level.ref_12ce8.ref_13b79);
  ref_12cf3(1);
  thread ref_12cf0();
}

function ai_molotov_used() {
  level endon("game_ended");
  level endon("dov2_device_used");
  level endon("force_end_sequence_time_limit");
  level endon("dov2_tactical_device_dropped");
  level endon("dov2_tactical_device_pickup");
  wait level.ref_12ce8.ref_13bfa;
  level notify("force_end_sequence_time_spent_in_same_state");
  thread ref_13b78(1);
  ref_12d0a(level.ref_12ce8.ref_13b79);
  ref_12cf3(1);
  thread ref_12cf0();
}

function ref_13365(var_0) {
  level endon("game_ended");
  var_1 = gettime();
  var_2 = var_0 * 1000 + var_1;
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 9, 2, 3);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 0, 9, var_0);
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 1);
  setomnvar("ui_nuke_end_milliseconds", var_2);
  setomnvarforallclients("ui_hide_minimap", 1);
  wait 3;

  foreach(var_4 in level.players) {
    thread ref_12d0b(var_4);
  }
}

function spawn_cypher_monitor_model() {
  _calloutmarkerping_handleluinotify_added::ref_13191("ui_nuke_data", 11, 1, 0);
}

function ref_11f15(var_0) {
  level endon("dov2_final_bink");

  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  for(var_1 = 3;; var_1 = max(0.5, var_1 - 0.5)) {
    foreach(var_3 in level.players) {
      var_3 playRumbleOnEntity("damage_heavy");
    }

    wait var_1;
  }
}

function ref_11f16(var_0, var_1) {
  level endon("game_ended");

  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  var_2 = 0.01;
  var_3 = [level.mapcenter];
  jumpiftrue(getdvarint("scr_br_event_dovp2_skip_extra_shake", 0)) LOC_00000056;
  GscBinSkip0(0x2e, var_3.size, (-500, 7000, 0));

  while(var_1 > 0) {
    foreach(var_5 in var_3) {
      earthquake(var_2, 0.05, var_5, 100000);
    }

    wait 0.05;
    var_2 += 0.005;

    if(var_2 >= 0.2) {
      var_2 = 0.2;
    }

    var_1 = max(var_1 - 0.05, 0);
  }

  var_1 = 0;

  for(var_2 = 0.2; var_1 < 3 && var_2 > 0; var_2 = 0) {
    foreach(var_5 in var_3) {
      earthquake(var_2, 0.05, var_5, 100000);
    }

    wait 0.05;
    var_2 -= 0.005;

    if(var_2 <= 0) {}
  }
}

function ref_11f1a(var_0) {
  level thread scripts\mp\gametypes\br_public::brleaderdialog("activated_nuke", 0, level.players);
  wait 3;

  if(istrue(var_0)) {
    wait 34;
  } else {
    level thread scripts\mp\gametypes\br_public::brleaderdialog("win_had_to", 0, level.players);
    wait 5;
    level thread scripts\mp\gametypes\br_public::brleaderdialog("win_saved", 0, level.players);
    wait 29;
  }

  if(isDefined(level.ref_12ce8.lb_mg_dmg_factor_tail_stabilizer)) {
    level thread scripts\mp\gametypes\br_public::brleaderdialog("destroyer_you_are", 0, level.ref_12ce8.lb_mg_dmg_factor_tail_stabilizer);
    var_1 = scripts\engine\utility::array_remove_array(level.players, level.ref_12ce8.lb_mg_dmg_factor_tail_stabilizer);
    level thread scripts\mp\gametypes\br_public::brleaderdialog("lose_over", 0, var_1);
    return;
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("lose_over", 0, level.players);
}

function ref_11f1b() {
  level endon("game_ended");
  level endon("dov2_device_used");
  level endon("force_end_sequence_time_limit");

  foreach(var_1 in level.players) {
    thread ref_12d0d(var_1);
  }

  var_3 = [];

  for(var_4 = 0; var_4 < level.ref_12ce8.player_pushing_vehicle_monitor; var_4++) {
    var_5 = level.players[randomint(level.players.size)];
    var_3 = var_5;
  }

  var_3 = scripts\engine\utility::array_remove_duplicates(var_3);
  wait 12;

  foreach(var_7 in var_3) {
    thread ref_12f1c(var_7);
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("flavor_thought", var_7, 1, 1);
    LOC_000000c9:
  }

  wait 9;

  foreach(var_7 in var_3) {
    thread ref_12f1c(var_7);
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("flavor_turn_off", var_7, 1, 1);
    LOC_00000118:
  }

  wait 14;

  foreach(var_7 in var_3) {
    thread ref_12f1c(var_7);
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("flavor_history", var_7, 1, 1);
    LOC_00000168:
  }

  wait 5;

  foreach(var_7 in var_3) {
    thread ref_12d0b(var_7);
    LOC_000001ad:
  }

  wait 6;

  foreach(var_7 in var_3) {
    thread ref_12f1c(var_7);
    level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("flavor_not_last", var_7, 1, 1);
    LOC_000001f7:
  }
}

function ref_11f13(var_0) {
  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  thread midpoint_music();
  thread ref_11f18();
  setmusicstate("dovp2_rbi_nuke_end");

  foreach(var_2 in level.players) {
    var_2 setsoundsubmix("mp_br_event_dovp2_countdown", 5);
  }
}

function midpoint_music() {
  foreach(var_1 in level.players) {
    var_1 playlocalsound("br_dovp2_rbi_cd_accent");
  }

  wait 3;
  var_3 = scripts\engine\utility::play_loopsound_in_space("br_dov2_nuke_alarm_lp", (383, -2648, 4228));
  wait 12;
  var_3 scripts\engine\utility::stop_loop_sound_on_entity("br_dov2_nuke_alarm_lp");
  waitframe();
  var_3 delete();
}

function ref_11f18() {
  wait 10;

  foreach(var_1 in level.players) {
    var_1 setsoundsubmix("mp_br_event_dovp2_nuke", 3);
  }
}

function ref_11f17(var_0) {
  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  if(isDefined(level.ref_12ce8.lb_mg_dmg_factor_tail_stabilizer)) {
    foreach(var_2 in level.players) {
      foreach(var_4 in level.ref_12ce8.lb_mg_dmg_factor_tail_stabilizer) {
        var_2 thread scripts\mp\hud_message::showsplash("br_reveal_2_destroyer_verdansk", undefined, var_4);
      }
    }
  }

  foreach(var_2 in level.players) {
    if(getdvarint("scr_br_event_dovp2_check_indoors", 0) && updateghostridekills(var_2)) {
      continue;
    }

    var_2 thread scripts\cp_mp\utility\shellshock_utility::_shellshock("flash_grenade_mp", "top", 7, 1);
  }

  wait 0.5;
  spawn_cypher_monitor_model();
  wait 13.5;

  foreach(var_2 in level.players) {
    var_2 thread scripts\mp\gametypes\br_gulag::gulagfadetoblack();
  }

  wait 1;
  var_11 = spawnStruct();
  var_11.origin = getdvarvector("scr_br_reveal_2_spectate_origin", (421, -1897, 2689));
  var_11.angles = getdvarvector("scr_br_reveal_2_spectate_angles", (8, -134, 0));

  foreach(var_2 in level.players) {
    var_2 thread scripts\mp\playerlogic::spawnintermission(var_11, undefined, 0);
  }

  wait 1.5;

  foreach(var_2 in level.players) {
    var_2 thread scripts\mp\gametypes\br_gulag::gulagfadefromblack();
  }

  wait 2;
  setomnvarforallclients("post_game_state", 1);
  wait 3;
  setmusicstate("");

  foreach(var_2 in level.players) {
    var_2 setsoundsubmix("fade_to_black_all_except_music", 5.5);
    var_2 clearsoundsubmix("mp_br_event_dovp2_nuke", 6.5);
    var_2 clearsoundsubmix("mp_br_event_dovp2_countdown", 6.5);
  }
}

function ref_11f12(var_0) {
  if(isDefined(var_0) && var_0 > 0) {
    wait var_0;
  }

  var_1 = "br_dovp2_rbi_nuke_exp";

  if(soundexists(var_1)) {
    foreach(var_3 in level.players) {
      var_3 playlocalsound(var_1);
    }
  }

  var_5 = [];
  GscBinSkip0(0x2e, 0, spawn("script_model", (-120844, -162669, -1514.17)));
}

function ref_12cf4() {
  var_0 = getdvarvector("br_final_circle_override", level.grouptorewards);
  return var_0;
}

function ref_12cf5() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    scripts\mp\gametypes\br::scriptednode(var_1);
  }
}

function ref_12d0a(var_0) {
  level endon("endRevealTimeHandler");
  wait var_0;
}

function ref_12cf0() {
  createnavobstaclebyshape();
  level thread scripts\mp\gamelogic::forceend();
  level waittill("game_cleanup");
  wait 0.6;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(var_1, 1, 0.3);
  }
}

function ref_11a48(var_0) {
  return false;
}

function ref_12d0d(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = "dx_brm_" + game["dialog"][var_0];
  var_2 = tolower(var_2);

  if(soundexists(var_2)) {
    var_3 = lookupsoundlength(var_2, 1) / 1000;
  } else {
    var_3 = 3;
  }

  var_2 queuedialogforplayer(var_3, var_1, var_3);
}

function ref_12d0b(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_2 = "dx_bra_" + game["dialog"][var_0];
  var_2 = tolower(var_2);

  if(soundexists(var_2)) {
    var_3 = lookupsoundlength(var_2, 1) / 1000;
  } else {
    var_3 = 3;
  }

  var_2 queuedialogforplayer(var_3, var_1, var_3);
}

function ref_12cfb() {
  level.playerkillstreakgetownerlookatignoreents = 0;
  thread ref_12cf5();

  foreach(var_1 in level.players) {
    if(scripts\mp\utility\player::unset_relic_trex(var_1)) {
      var_1 scripts\mp\laststand::playanim_aibegindismountturret("self_revive_success", var_1);
    }
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("gametype_dov2", 0, level.players);
  wait 4;
  level thread scripts\mp\gametypes\br_public::brleaderdialog("gametype_desc_dov2_crit", 0, level.players);
  wait 4;
  level thread scripts\mp\gametypes\br_public::brleaderdialog("intro_destroy", 0, level.players);
  wait 9;

  foreach(var_4 in level.players) {
    var_4 thread scripts\mp\hud_message::showsplash("br_reveal_2_device_be_the_destroyer");
  }
}

function ref_12cee() {
  var_0 = (0, 0, 0);
  var_1 = 18000;
  var_2 = scripts\mp\gametypes\br_c130::createtestc130path(var_0, var_1);
  return var_2;
}

function ref_12cec() {
  thread ref_12cf9();

  foreach(var_1 in level.players) {
    var_1 scripts\mp\gametypes\br_armor::searchcirclesize();
  }
}

function ref_12cf9() {
  level endon("game_ended");
  self endon("death");
  var_0 = distance(self.ref_12205.startpt, self.ref_12205.neurotoxin_damage_monitor);
  var_1 = var_0 / scripts\mp\gametypes\br_c130::getc130speed() - 5;
  wait var_1;

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_3.br_infil_type) && var_3.br_infil_type == "c130" && !isDefined(var_3.jumptype)) {
      var_3.jumptype = "outOfBounds";
      var_3 notify("halo_kick_c130");
    }
  }
}

function ref_1206a(var_0) {
  var_0.locationtriggerupdate = var_0.origin;

  if(isDefined(level.ref_12ce8) && isDefined(level.ref_12ce8.ref_13a17) && isDefined(level.ref_12ce8.ref_13a17.owner) && var_0 == level.ref_12ce8.ref_13a17.owner) {
    ref_12caf(var_0, 1);
    return;
  }
}

function carriable_ready() {
  if(!isDefined(self.carryflag)) {
    self attach("prop_king_game_flag", "tag_stowed_back3", 1);
    self.carryflag = "prop_ctf_game_flag_west";
    return;
  }
}

function lbravo_hover_attack_think() {
  if(isDefined(self.carryflag)) {
    self detach("prop_king_game_flag", "tag_stowed_back3");
    self.carryflag = undefined;
    return;
  }
}

function ref_13a1d() {
  var_0 = 1;
  var_1 = 255;
  var_2 = level.ref_12ce8.ref_14385;
  var_3 = level.ref_12ce8.ref_14385;
  animscripted_loop_earlyend(var_0, var_1, var_2, 0);
  animscripted_loop_for_time(var_3);
}

function ref_13a1f() {
  scripts\cp_mp\killstreaks\airdrop::modifydestructibledamage(level.ref_12ce8.level_carepackage_give_player_killstreak_incendiary_launcher);

  foreach(var_1 in level.players) {
    var_1 scripts\mp\hud_message::showsplash("br_reveal_2_device_on_ground");
  }

  var_3 = 2;
  var_4 = 255;
  var_5 = level.ref_12ce8.ref_14385;
  var_6 = level.ref_12ce8.ref_145cc;
  animscripted_loop_earlyend(var_3, var_4, var_5);
  animscripted_loop_for_time(var_6);
  thread animatedprop_setup(level);
  level thread scripts\mp\gametypes\br_public::brleaderdialog("inbound_nuke", 0, level.players);
  wait 3;
  level thread scripts\mp\gametypes\br_public::brleaderdialog("hold_device", 0, level.players);
}

function animscripted_loop_earlyend(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.ref_13a20)) {
    level.ref_13a20 = spawnStruct();
    level.ref_13a20.level_check_current_drop_amount = 0;
    level.ref_13a20.level_carepackage_player_used_logic = 0;
    level.ref_13a20.level_carepackage_give_player_killstreak = 255;
    level.ref_13a20.ref_11b5a = 0;
  }

  if(isDefined(var_3)) {
    level.ref_13a20.level_check_current_drop_amount = var_3;
  }

  if(isDefined(var_0)) {
    level.ref_13a20.level_carepackage_player_used_logic = var_0;
  }

  if(isDefined(var_1)) {
    level.ref_13a20.level_carepackage_give_player_killstreak = var_1;
  }

  if(isDefined(var_2)) {
    level.ref_13a20.ref_11b5a = var_2;
  }

  var_4 = (int(level.ref_13a20.level_check_current_drop_amount) & 1) << 22;
  var_4 += (int(level.ref_13a20.level_carepackage_player_used_logic) & 7) << 19;
  var_4 += (int(level.ref_13a20.level_carepackage_give_player_killstreak) & 255) << 11;
  var_4 += int(level.ref_13a20.ref_11b5a) & 2047;
  setomnvar("ui_br_exfil_radio_state", var_4);
}

function animscripted_loop_for_time(var_0) {
  var_1 = gettime() + var_0 * 1000;
  setomnvar("ui_br_exfil_radio_end_time", int(var_1));
}

function animscripted_single_relative(var_0) {
  var_1 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_1 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_1, "current", var_0 + (0, 0, 50), "ui_mp_br_mapmenu_icon_dov_02_objective");
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_1, 1);

    foreach(var_3 in level.players) {
      objective_addclienttomask(var_1, var_3);
    }

    objective_setplayintro(var_1, 0);
    objective_showtoplayersinmask(var_1);
    level.ref_12ce8.ref_13a1b = var_1;
    var_5 = animscripted_single_earlyend();

    if(!var_5) {
      thread anin_playvo_func();
      return;
    }

    return;
  }
}

function animscripted_single_earlyend() {
  if(!isDefined(level.ref_12ce8.ref_13a17)) {
    return false;
  }

  if(!level.ref_12ce8.ref_13a17 method_87b9()) {
    return false;
  }

  var_0 = level.ref_12ce8.ref_13a17 method_87b7();

  if(!isDefined(level.ref_12ce8.ref_13a1c)) {
    level.ref_12ce8.ref_13a1c = spawn("script_model", level.ref_12ce8.ref_13a17.origin);
    level.ref_12ce8.ref_13a1c setModel("tag_origin");
  } else {
    level.ref_12ce8.ref_13a1c.origin = level.ref_12ce8.ref_13a17.origin;
  }

  level.ref_12ce8.ref_13a1c linkTo(var_0);
  objective_onentity(level.ref_12ce8.ref_13a1b, level.ref_12ce8.ref_13a1c);
  return true;
}

function anin_playvo_func() {
  if(!isDefined(level.ref_12ce8.ref_13a17)) {
    return;
  }

  level.ref_12ce8.ref_13a17 endon("device_cleanup");
  var_0 = level.ref_12ce8.ref_13a17.origin;

  for(;;) {
    waitframe();

    if(!isDefined(level.ref_12ce8.ref_13a17) || !isDefined(level.ref_12ce8.ref_13a1b)) {
      break;
    }

    if(distance(level.ref_12ce8.ref_13a17.origin, var_0) > 0.1) {
      var_0 = level.ref_12ce8.ref_13a17.origin;
      objective_position(level.ref_12ce8.ref_13a1b, var_0 + (0, 0, 50));
    }
  }
}

function animscripted_single_arrive_at() {
  if(isDefined(level.ref_12ce8.ref_13a1a)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(level.ref_12ce8.ref_13a1a);
    level.ref_12ce8.ref_13a1a = undefined;
  }

  if(isDefined(level.ref_12ce8.ref_13a19)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(level.ref_12ce8.ref_13a19);
    level.ref_12ce8.ref_13a19 = undefined;
  }

  if(isDefined(level.ref_12ce8.ref_13a1b)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(level.ref_12ce8.ref_13a1b);
    level.ref_12ce8.ref_13a1b = undefined;
    return;
  }
}

function animatedprop_setup(var_0) {
  level endon("game_ended");

  if(level.ref_12ce8.level_carepackage_drop_defined <= 0) {
    return;
  }

  for(;;) {
    animatedprop_setanim(var_0);
    wait 2;
  }
}

function animatedprop_setanim(var_0) {
  if(level.ref_12ce8.level_carepackage_drop_defined <= 0) {
    return;
  }

  var_1 = canceljoins(undefined, undefined, var_0, level.ref_12ce8.level_carepackage_drop_defined);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(var_3.type == "brloot_tactical_device" || !scripts\mp\gametypes\br_pickups::update_gamebattles_char_loc(var_3, 0)) {
        continue;
      }

      if(var_3 getscriptableisreserved() && !isDefined(var_3.embassy_main)) {
        continue;
      }

      scripts\mp\gametypes\br_pickups::ref_11a21(var_3);
    }

    return;
  }
}

function anim_weapon(var_0) {
  var_1 = spawnStruct();
  var_1.ml_p3_to_safehouse_transition = 0;
  var_2 = undefined;

  if(isDefined(self) && isPlayer(self)) {
    var_2 = self;
  }

  var_3 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(var_1, level.ref_12ce8.level_carepackage_give_player_killstreak_incendiary_launcher, (0, 0, 0), var_2, 0, 0, 35);
  var_4 = scripts\mp\gametypes\br_pickups::spawnpickup("brloot_tactical_device", var_3, 0, 1);

  if(!isDefined(var_4)) {
    return undefined;
  }

  var_4.keepinmap = 1;
  var_5 = 1;
  var_6 = 255;
  var_7 = level.ref_12ce8.ref_14385;
  var_8 = level.ref_12ce8.ref_14385;
  animscripted_loop_earlyend(var_5, var_6, var_7, 0);
  animscripted_loop_for_time(var_8);

  if(istrue(var_0)) {
    var_4.hidden = 1;
    var_4 setscriptablepartstate("brloot_tactical_device", "hidden");
  }

  level.ref_12ce8.ref_13a17 = var_4;
  return var_4;
}

function ref_13a1e(var_0) {
  level notify("dov2_tactical_device_pickup");
  carriable_ready(var_0);
  level.ref_12ce8.ref_13a17.owner = var_0;
  level thread scripts\mp\gametypes\br_quest_util::ref_140b1(var_0.origin, "revive");
  setmusicstate("dovp2_rbi_nuke_timer");
  animscripted_single_arrive_at();

  if(istrue(level.ref_12ce8.ref_145ce)) {
    thread scriptflags();
  } else {
    animscripted_loop(var_0);
  }

  var_1 = 3;
  var_2 = var_0 getentitynumber();
  var_3 = getdvarint("scr_br_reveal_2_device_hold_win_time", 180);
  var_4 = level.ref_12ce8.ref_145cc;
  animscripted_loop_earlyend(var_1, var_2, var_3, 0);
  animscripted_loop_for_time(var_4);
  thread aigroundturret_requestmount();
  anim_spawnposition_override(level.ref_12ce8.ref_13a17, var_0.origin);
  ammobox_tryuseinternal(var_0.origin, var_0, "ui_mp_br_mapmenu_icon_dov_02_objective_friendly", "ui_mp_br_mapmenu_icon_dov_02_objective_enemy_ingame");
  level.ref_12ce8.ref_12345 = gettime();

  if(level.ref_12ce8.ref_129c4 > 0) {
    level.activeuavs[var_0.team] += level.ref_12ce8.ref_129c4;
    scripts\cp_mp\killstreaks\uav::_setteamradarstrength(var_0.team);
    return;
  }
}

function animscripted_single() {
  level endon("game_ended");
  level endon("force_end_sequence_time_spent_in_same_state");
  level endon("force_end_sequence_time_limit");

  while(level.ref_12ce8.ref_145cc > 0) {
    level.ref_12ce8.ref_145cc -= 1;
    wait 1;
  }

  level.ref_12ce8.ref_145ce = 1;

  if(isDefined(level.ref_12ce8.ref_13a17) && isDefined(level.ref_12ce8.ref_13a17.owner)) {
    thread scriptflags();
    return;
  }
}

function animscripted_loop_relative() {
  level endon("game_ended");
  level endon("dov2_tactical_device_dropped");

  if(level.ref_12ce8.ref_145cc > 30) {
    wait level.ref_12ce8.ref_145cc - 30;
    level thread scripts\mp\gametypes\br_public::brleaderdialog("30_seconds_nuke", 0, level.players);
    return;
  }
}

function animscripted_loop_n_times() {
  var_0 = getdvarint("scr_br_reveal_2_device_hold_win_time", 180);
  animscripted_loop_earlyend(undefined, undefined, var_0);
}

function animscripted_clear() {
  animscripted_loop_earlyend(0);
}

function animscripted_loop(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.team == var_0.team) {
      if(var_2 == var_0) {
        var_2 scripts\mp\hud_message::showsplash("br_reveal_2_device_picked_up_self");
      } else {
        var_2 scripts\mp\hud_message::showsplash("br_reveal_2_device_picked_up_ally");
      }

      continue;
    }

    var_2 scripts\mp\hud_message::showsplash("br_reveal_2_device_picked_up_enemy");
  }
}

function ammobox_tryuseinternal(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_4 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_4, "current", var_0, var_2);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_4, 1);
    thread apachepilotpool(var_1, var_4, level.ref_12ce8.playersetattractionbesttime);
    objective_removeallfrommask(var_4);
    var_5 = scripts\mp\utility\teams::getteamdata(var_1.team, "players");

    foreach(var_7 in var_5) {
      objective_addclienttomask(var_4, var_7);
    }

    objective_showtoplayersinmask(var_4);
    objective_setplayintro(var_4, 0);
    level.ref_12ce8.ref_13a1a = var_4;
  }

  var_9 = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(var_9 != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(var_9, "current", var_0, var_3);
    scripts\mp\objidpoolmanager::update_objective_setbackground(var_9, 1);
    thread apachepilotpool(var_1, var_9, level.ref_12ce8.nuclear_core_carrier_escaped);
    objective_removeallfrommask(var_9);

    foreach(var_7 in level.players) {
      if(var_7.team == var_1.team) {
        objective_addclienttomask(var_9, var_7);
      }
    }

    objective_hidefromplayersinmask(var_9);
    objective_setplayintro(var_9, 0);
    level.ref_12ce8.ref_13a19 = var_9;
    thread anyplayersinlaststandhold(var_1);
    return;
  }
}

function apachepilotpool(var_0, var_1, var_2) {
  level endon("dov2_tactical_device_dropped");

  if(var_2 <= 0) {
    scripts\mp\objidpoolmanager::update_objective_setzoffset(var_1, 115);
    scripts\mp\objidpoolmanager::update_objective_onentity(var_1, var_0);
    return;
  }

  for(;;) {
    if(isDefined(var_0)) {
      scripts\mp\objidpoolmanager::update_objective_position(var_1, var_0.origin + (0, 0, 115));

      if(var_0 scripts\cp_mp\utility\player_utility::isinvehicle()) {
        wait 0.1;
        continue;
      }

      wait var_2;
    }
  }
}

function anyplayersinlaststandhold(var_0) {
  level endon("dov2_tactical_device_dropped");
  level endon("game_ended");
  level endon("dov2_device_used");

  for(;;) {
    objective_removeallfrommask(level.ref_12ce8.ref_13a19);
    var_1 = scripts\mp\utility\player::getplayersinradius(var_0.origin, 1200);

    foreach(var_3 in var_1) {
      if(var_3.team == var_0.team) {
        continue;
      }

      objective_addclienttomask(level.ref_12ce8.ref_13a19, var_3);
    }

    objective_showtoplayersinmask(level.ref_12ce8.ref_13a19);
    wait 3;
  }
}

function ref_12caf(var_0) {
  modifydamagetoprop(1, var_0);
}

function modifydamagetoprop(var_0, var_1) {
  var_2 = self;
  level endon("game_ended");
  level notify("dov2_tactical_device_dropped");
  var_2 notify("tactical_device_win_timer_wait");
  var_2 endon("tactical_device_win_timer_wait");
  thread ai_molotov_used();
  lbravo_hover_attack_think(var_2);
  var_3 = animatedprop_startanim();

  foreach(var_5 in level.players) {
    var_5 thread scripts\mp\hud_message::showsplash("br_reveal_2_device_dropped");
  }

  if(!istrue(var_1)) {
    wait 0.5;
  }

  ref_13a18();

  if(!istrue(var_0)) {
    var_7 = level.ref_12ce8.level_carepackage_give_player_killstreak_incendiary_launcher;
    level.ref_12ce8.level_carepackage_give_player_killstreak_incendiary_launcher = var_2.origin + (0, 0, 35);
  } else {
    var_7 = undefined;
  }

  anim_weapon();

  if(!isDefined(level.ref_12ce8.ref_13a17)) {
    if(isDefined(var_7)) {
      level.ref_12ce8.level_carepackage_give_player_killstreak_incendiary_launcher = var_7;
      anim_weapon();
    }

    if(!isDefined(level.ref_12ce8.ref_13a17)) {
      level.ref_12ce8.level_carepackage_give_player_killstreak_incendiary_launcher = relic_nuketimer_addtotimer();
      anim_weapon();
    }
  }

  var_8 = 2;
  var_9 = 255;
  var_10 = getdvarint("scr_br_reveal_2_device_hold_win_time", 180);
  var_11 = level.ref_12ce8.ref_145cc;
  animscripted_loop_earlyend(var_8, var_9, var_10, 1);
  animscripted_loop_for_time(var_11);
  thread animatedprop_setup(level);

  if(isDefined(var_3) && isDefined(var_3.team) && level.ref_12ce8.ref_129c4 > 0) {
    level.activeuavs[var_3.team] -= level.ref_12ce8.ref_129c4;
    scripts\cp_mp\killstreaks\uav::_setteamradarstrength(var_3.team);
  }

  animscripted_single_relative(level.ref_12ce8.ref_13a17.origin);
}

function ref_13a18() {
  animscripted_single_arrive_at();

  if(isDefined(level.ref_12ce8.ref_13a17)) {
    level.ref_12ce8.ref_13a17 notify("device_cleanup");
    anim_scene_stance_override(level.ref_12ce8.ref_13a17);
    level.ref_12ce8.ref_13a17 freescriptable();
    level.ref_12ce8.ref_13a17 = undefined;
    return;
  }
}

function animatedprop_startanim() {
  var_0 = level.ref_12ce8.ref_145cc;

  if(isDefined(level.ref_12ce8.ref_12345)) {
    var_0 = level.ref_12ce8.ref_145cc - (gettime() - level.ref_12ce8.ref_12345) / 1000;
  }

  return var_0;
}

function anim_spawnposition_override(var_0) {
  var_1 = scripts\mp\gametypes\br_circle::getrandompointincircle(var_0, 500, 0, 0.4, 0, 0);
  level.ref_12ce8.ref_13a17 scripts\mp\gametypes\br_quest_util::init_tactical_boxes(4, 11, 1, var_1);
  level.ref_12ce8.ref_13a17 scripts\mp\gametypes\br_quest_util::ref_1316f(1000);
  thread anim_trafficking_play_scene(level);

  foreach(var_3 in level.players) {
    level.ref_12ce8.ref_13a17 scripts\mp\gametypes\br_quest_util::ref_1336a(var_3);
    LOC_000000a2:
  }
}

function anim_trafficking_play_scene(var_0) {
  level endon("dov2_tactical_device_dropped");
  level endon("game_ended");
  level endon("dov2_device_used");
  var_1 = level.ref_12ce8.ref_13a17.owner;

  for(;;) {
    var_2 = (var_1.origin[0], var_1.origin[1], 1000);
    var_2 += scripts\engine\math::random_vector_2d() * randomfloatrange(100, 300);
    level.ref_12ce8.ref_13a17.mapcircle.origin = var_2;
    level.ref_12ce8.ref_13a17.guard_spawners = var_2;
    wait 4;
  }
}

function anim_scene_stance_override() {
  if(!isDefined(level.ref_12ce8.ref_13a17.mapcircle)) {
    return;
  }

  level.ref_12ce8.ref_13a17 scripts\mp\gametypes\br_quest_util::spawn_double_cargo();
}

function scriptflags() {
  self endon("death_or_disconnect");
  var_0 = self;
  var_0 scripts\mp\hud_message::showsplash("br_reveal_2_device_ready_to_launch");
  level thread scripts\mp\gametypes\br_public::brleaderdialog("ready_nuke", 0, level.players);
  thread anim_ref();
  var_0 scripts\mp\gametypes\br_pickups::playerpackdataintogulagomnvar("nuke", 1);
  level waittill("dov2_device_used");
  level.ref_12ce8.lb_mg_dmg_factor_tail_stabilizer = scripts\mp\utility\teams::getteamdata(var_0.team, "alivePlayers");
  level thread scripts\mp\gametypes\br_public::brleaderdialog("thank_you_soldiers", 0, level.ref_12ce8.lb_mg_dmg_factor_tail_stabilizer);
  ref_13a18();
  var_0 scripts\mp\killstreaks\killstreaks::clearkillstreaks();
  lootchopper_getspawnlocations(var_0);
}

function anim_ref() {
  var_0 = self;
  level endon("game_ended");
  level endon("dov2_device_used");
  level endon("dov2_tactical_device_dropped");
  var_0 endon("disconnect");
  level thread scripts\mp\gametypes\br_public::brleaderdialog("activate_destroy", 0, scripts\mp\utility\teams::getteamdata(var_0.team, "players"));
  wait 6;

  foreach(var_0 in scripts\mp\utility\teams::getteamdata(var_0.team, "alivePlayers")) {
    thread ref_12d0b(var_0);
  }

  wait 4;
  level thread scripts\mp\gametypes\br_public::brleaderdialog("activate_now", 0, scripts\mp\utility\teams::getteamdata(var_0.team, "players"));
  wait 4;

  foreach(var_0 in scripts\mp\utility\teams::getteamdata(var_0.team, "alivePlayers")) {
    thread ref_12d0b(var_0);
  }

  wait 5;
  var_5 = scripts\mp\utility\teams::getteamdata(var_0.team, "players");

  foreach(var_0 in var_5) {
    thread ref_12f1c(var_0);
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("flavor_doomed", 0, var_5);
  wait 5;

  foreach(var_0 in scripts\mp\utility\teams::getteamdata(var_0.team, "alivePlayers")) {
    thread ref_12d0b(var_0);
  }

  wait 6;
  level thread scripts\mp\gametypes\br_public::brleaderdialog("dont_listen_now", 0, scripts\mp\utility\teams::getteamdata(var_0.team, "players"));
  wait 5;
  level thread scripts\mp\gametypes\br_public::brleaderdialog("win_time", 0, scripts\mp\utility\teams::getteamdata(var_0.team, "players"));
  wait 7;
  var_5 = scripts\mp\utility\teams::getteamdata(var_0.team, "players");

  foreach(var_0 in var_5) {
    thread ref_12f1c(var_0);
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("flavor_gone", 0, var_5);
  wait 4;
  var_5 = scripts\mp\utility\teams::getteamdata(var_0.team, "players");

  foreach(var_0 in var_5) {
    thread ref_12f1c(var_0);
  }

  level thread scripts\mp\gametypes\br_public::brleaderdialog("flavor_learn", 0, var_5);
}

function ref_12048(var_0) {
  if(var_0.streakname == "nuke") {
    level notify("dov2_device_used");
    return 0;
  }

  return undefined;
}

function missing_window_blockers(var_0, var_1, var_2, var_3) {
  return scripts\mp\gametypes\br_pickups::haskillstreak("nuke");
}

function aigroundturret_requestmount() {
  var_0 = self;
  level endon("dov2_tactical_device_dropped");
  level endon("game_ended");
  level endon("dov2_device_used");
  level endon("force_end_sequence_time_limit");
  level endon("force_end_sequence_time_spent_in_same_state");
  var_0 endon("disconnect");

  for(;;) {
    foreach(var_2 in level.teamdata[var_0.team]["alivePlayers"]) {
      var_2 thread scripts\mp\rank::giverankxp("br_reveal_2_device_holding_xp", 100);
      var_2 thread scripts\mp\rank::scoreeventpopup("br_reveal_2_device_holding_xp");
    }

    wait 5;
  }
}

function updateghostridekills() {
  var_0 = self;
  var_1 = 0;
  var_2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 0);

  if(!scripts\engine\trace::ray_trace_passed(var_0.origin, var_0.origin + (0, 0, 10000), undefined, var_2)) {
    var_1 = 1;
  }

  return var_1;
}

function ref_1200d(var_0) {}

function ref_1200f(var_0) {
  anim_weapon(1);
  thread ref_13a1e(level.ref_12ce8.ref_13a17);
  thread animscripted_single();
  level.ref_12ce8.plundereventtime delete();
}

function ref_1200e(var_0) {}

function ref_12cf3(var_0) {
  wait 12;
  scripts\mp\flags::gameflagset("dov2_final_bink");
  wait 8;
}

function ref_12f1c(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  var_1 playlocalsound("br_event1_scramble_sfx");
  var_1 setclientomnvar("ui_br_bink_overlay_state", 4);
  var_1 setclientomnvar("ui_scrambler_strength", 5);
  wait var_0;
  var_1 stoplocalsound("br_event1_scramble_sfx");
  var_1 setclientomnvar("ui_br_bink_overlay_state", 0);
  var_1 setclientomnvar("ui_scrambler_strength", 0);
}

function playerrespawn(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");

  if(!istrue(level.br_prematchstarted) || istrue(level.ref_12ce8.playerplunderbank)) {
    thread ref_126a4(1);
  } else {
    thread ref_12539();
  }

  return true;
}

function ref_12539() {
  level endon("game_ended");
  self endon("disconnect");

  if(istrue(level.gameended)) {
    return;
  }

  if(getdvarint("scr_bmo_use_spawn_fix", 1) == 1) {
    self endon("brWaitAndSpawnClientComplete");
  }

  var_0 = 0;
  var_1 = 5;
  var_2 = 2;
  thread scripts\mp\gametypes\br_gametype_dmz::patchfix(var_2);
  wait 1;
  var_3 = getdvarint("scr_br_reveal_2_spawn_wait", 5);
  scripts\engine\utility::ent_flag_init("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  var_4 = scripts\engine\utility::waittill_notify_or_timeout_return("squad_wipe_death", var_1);
  self notify("stop_updatePrestreamRespawn");
  self.ref_1286f = scripts\mp\gametypes\br::getspawnpoint(1);
  var_5 = 2500;
  var_6 = scripts\engine\utility::drop_to_ground(self.ref_1286f.origin, 1500, -20000);
  var_7 = (0, 0, var_5);
  self.ref_1286f.origin = scripts\mp\gametypes\br::getoffsetspawnorigin(var_6, var_7);
  var_8 = self.ref_1286f;
  scripts\engine\utility::ent_flag_clear("playerRespawn_intermission_spawned");
  self.trial_moving_target_think = undefined;
  self.trial_other_team = undefined;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  scripts\cp_mp\execution::_clearexecution();
  scripts\mp\gametypes\br_pickups::initplayer();
  scripts\mp\gametypes\br_gulag::gulagwinnerrespawn(1, undefined, var_8, 1, var_8.origin, 1, undefined, undefined, undefined, 1);
  scripts\mp\gametypes\br::ref_13f21(self);
  scripts\mp\gametypes\br_armor::searchcirclesize();
  scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
  thread scripts\mp\gametypes\br::defend_wave_2();
  _calloutmarkerping_handleluinotify_added::ref_13133("ui_br_transition_type", 0);
  scripts\mp\damage::resetplayervariables();
}

function ref_126a4(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self.ref_1286f = scripts\mp\gametypes\br::getspawnpoint(1);
  var_1 = 1300;
  var_2 = scripts\engine\utility::drop_to_ground(self.ref_1286f.origin, 1500, -20000);
  var_3 = (0, 0, var_1);
  self.ref_1286f.origin = scripts\mp\gametypes\br::getoffsetspawnorigin(var_2, var_3);
  scripts\mp\playerlogic::waitandspawnclient(0);
  self freezecontrols(1);

  if(!istrue(level.skipprematchdropspawn)) {
    thread scripts\mp\gametypes\br::prematchdeployparachute();
  }

  while(!isalive(self)) {
    waitframe();
  }

  waitframe();

  if(!istrue(game["inLiveLobby"])) {
    scripts\mp\gametypes\br::scriptednode(self);
    scripts\mp\gametypes\br_armor::searchcirclesize();
  }

  scripts\mp\gametypes\br_weapons::debug_spawncover_badnodetest();
  thread scripts\mp\gametypes\br::defend_wave_2();
  self skydive_setdeploymentstatus(1);
  self skydive_setbasejumpingstatus(1);
  var_4 = !self calloutmarkerping_getEnt();
  var_5 = gettime();

  if(var_4) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist)) {
      if(var_5 + 3000 < gettime()) {
        break;
      }

      waitframe();
    }
  }

  self notify("brWaitAndSpawnClientComplete");
  self.waitingtospawn = 0;
  self freezecontrols(0);

  if(var_0) {
    scripts\mp\gametypes\br::ref_13f21(self);
    return;
  }
}

function ref_1366f() {
  level.delete_script_object = [];
  level.ref_12864 = [];
  level.prematchspawnoriginsforteams = undefined;
  level.delete_script_object = [scripts\mp\gametypes\br::createspawnlocation((-3589, 672, 2169), 0, 900), scripts\mp\gametypes\br::createspawnlocation((-435, 6921, 1807), 0, 900), scripts\mp\gametypes\br::createspawnlocation((-4721, 4432, 675), 0, 900), scripts\mp\gametypes\br::createspawnlocation((-3928, -9, 820), 0, 900), scripts\mp\gametypes\br::createspawnlocation((-577, -9128, 265), 0, 900), scripts\mp\gametypes\br::createspawnlocation((3953, -5968, 502), 0, 900), scripts\mp\gametypes\br::createspawnlocation((3702, -1636, 1214), 0, 900), scripts\mp\gametypes\br::createspawnlocation((-25, -1305, 1970), 0, 900), scripts\mp\gametypes\br::createspawnlocation((-330, 3351, 1900), 0, 900), scripts\mp\gametypes\br::createspawnlocation((3839, 167, 610), 0, 900)];
  level.prematchspawnorigins = scripts\mp\gametypes\br::getprematchlocationspawnorigins();

  for(var_0 = 0; var_0 < level.delete_script_object.size; var_0++) {
    level.ref_12864[level.ref_12864.size] = 0;
  }
}

function ref_13670() {
  level.delete_script_object = [];
  level.ref_12864 = [];
  level.prematchspawnoriginsforteams = undefined;
  level.delete_script_object = [scripts\mp\gametypes\br::createspawnlocation((1302, 1719, 2013), 0, 900), scripts\mp\gametypes\br::createspawnlocation((-229, 785, 2061), 0, 900), scripts\mp\gametypes\br::createspawnlocation((2137, -2813, 2076), 0, 900), scripts\mp\gametypes\br::createspawnlocation((833, 4426, 1825), 0, 900), scripts\mp\gametypes\br::createspawnlocation((-1775, -3274, 2337), 0, 900), scripts\mp\gametypes\br::createspawnlocation((3702, -1636, 1214), 0, 900), scripts\mp\gametypes\br::createspawnlocation((-25, -1305, 1970), 0, 900), scripts\mp\gametypes\br::createspawnlocation((-3260, 309, 2087), 0, 900), scripts\mp\gametypes\br::createspawnlocation((-1510, -3522, 1888), 0, 900)];
  level.prematchspawnorigins = scripts\mp\gametypes\br::getprematchlocationspawnorigins();

  for(var_0 = 0; var_0 < level.delete_script_object.size; var_0++) {
    level.ref_12864[level.ref_12864.size] = 0;
  }
}

function ref_12862() {
  return false;
}

function dyn_door(var_0) {
  return true;
}

function onspawnplayer() {
  self notify("br_spawned");

  if(isagent(self)) {
    return;
  }

  var_0 = istrue(self.gulag);
  scripts\mp\gametypes\br_pickups::initplayer(var_0);
  scripts\mp\gametypes\br_functional_poi::initplayer();
  scripts\mp\gametypes\br_armor::teamfriendlyto();
  self.oldprimarygun = undefined;
  self.newprimarygun = undefined;
  self.healthregendisabled = 0;
  self.br_lastscenecheck = gettime();
  self.needtoplayintro = undefined;
  self.gunnlessweapon = undefined;
  level.superdelay = 0;
  level.superpointsmod = 1;
  self.br_perks = [0, 0, 0, 0, 0];
  self.br_perkpoints = 0;

  if(istrue(level.ref_121c8)) {
    self getclientomnvar();
  } else {
    self weaponswitchbuttonPressed();
  }

  if(istrue(level.ref_121c9)) {
    self skydive_cutautodeployon();
    return;
  }

  self skydive_cutautodeployoff();
}

function emp_drone_proximity_explode(var_0) {
  var_1 = 0.5;

  if(!isDefined(self.ref_1286f) || self calloutmarkerping_getEnt()) {
    self setclientomnvar("ui_br_extended_load_screen", 0);
    return;
  }

  thread scripts\mp\gametypes\br::emp_drone_should_take_damage();
  self.thrust_fx_model = undefined;
  scripts\mp\gametypes\br_public::ref_126ed();
  self freezecontrols(0);
}

function setupmapquadrantcornersandgrid() {}

function onplayerkilled(var_0) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }

  if(level.gameended) {
    return;
  }

  if(isDefined(var_0) && isDefined(var_0.inflictor) && isDefined(var_0.inflictor.classname) && (var_0.inflictor.classname == "trigger_multiple" || var_0.inflictor.classname == "trigger_hurt") && isDefined(level.ref_12ce8) && isDefined(level.ref_12ce8.ref_13a17) && isDefined(level.ref_12ce8.ref_13a17.owner) && var_0.victim == level.ref_12ce8.ref_13a17.owner) {
    ref_12caf();
    return;
  }

  if(!isDefined(var_0.attacker) || !isPlayer(var_0.attacker) || !isDefined(var_0.victim) || var_0.attacker == var_0.victim) {
    return;
  }

  var_1 = var_0.attacker.team;

  if(!isDefined(level.teamdata[var_1]["kills"])) {
    level.teamdata[var_1]["kills"] = 0;
  }

  level.teamdata[var_1]["kills"]++;

  if(isDefined(level.ref_12d05)) {
    if(!istrue(level.br_prematchstarted)) {
      return;
    }

    if(level.gameended) {
      return;
    }

    var_2 = var_0.victim;
    var_3 = var_0.attacker;

    if(!isDefined(var_3) || !isPlayer(var_3) || !isDefined(var_2)) {
      return;
    }

    return;
  }
}

function lootchopper_getspawnlocations(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(var_0.team, "players");

  foreach(var_3 in var_1) {
    var_4 = var_3 == var_0;
    var_3 dlog_recordplayerevent("dlog_event_br_dov", ["pushed_button", var_4]);
  }
}