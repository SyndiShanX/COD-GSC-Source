/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_containmentprotocol.gsc
***********************************************************/

function init() {
  var_0 = any_player_within_distance2d();

  if(!var_0) {
    return;
  }

  level._effect["vista_rocket"] = loadfx("vfx/iw8_br/gameplay/event/vfx_smktrail_vista_rocket");
  thread allassassin_give();
  thread actorid();
  thread add_player_to_focus_fire_attacker_list();
}

function allassassin_give() {
  wait 3;
  scripts\mp\utility\sound::besttime("br_zmb_dov_sfx");
}

function any_player_within_distance2d() {
  if(getdvarint("scr_br_containmentprotocol_debug_alwaysactivate", 0) == 1) {
    level.hostskipburndownlow = 1;
  }

  if(getdvarint("scr_br_containmentprotocol", 0) == 0 && !istrue(level.hostskipburndownlow)) {
    return false;
  }

  level.hostskipburndownhigh = spawnStruct();
  level.hostskipburndownhigh.intensity = getdvarint("scr_br_containmentprotocol_intensity", 1);
  var_0 = getdvarfloat("scr_br_containmentprotocol_intensity_likelihood", 0.05);
  var_1 = randomfloat(1) < var_0;
  return var_1 || istrue(level.hostskipburndownlow);
}

function actorid() {
  level endon("game_ended");
  level endon("end_containment_fx");
  jumpiffalse(level.mapname != "mp_br_mechanics") LOC_00000025;
  level waittill("br_c130_left_bounds");

  for(;;) {
    var_0 = scripts\mp\flags::gameflag("prematch_done") || istrue(level.hostskipburndownlow);

    if(var_0) {
      thread actorloopanim();
    }

    var_1 = 0;
    var_2 = scripts\mp\utility\game::round_vehicle_logic() == "reveal";

    if(!var_2 && isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      var_3 = getdvarint("scr_br_containmentprotocol_ambientfx_circlenum_delay", 5);
      var_1 = 5 * max(0, level.br_circle.circleindex);
    }

    var_4 = var_1 + getdvarint("scr_br_containmentprotocol_ambientfx_delay_min", 25);
    var_5 = var_1 + getdvarint("scr_br_containmentprotocol_ambientfx_delay_max", 70);
    var_6 = randomfloatrange(var_4, var_5);
    wait var_6;
  }
}

function actorloopanim() {
  level endon("end_containment_fx");

  for(var_0 = getdvarint("scr_br_containmentprotocol_ambientfx_rocketcount", 3); var_0 > 0; var_0--) {
    wait randomfloat(15);
    thread actorthinkpath_default();
  }

  var_1 = getdvarint("scr_br_containmentprotocol_ambientfx_delay_before_plane_strafe", 3);
  wait var_1;
  actorrope();
}

function actorthinkpath_default() {
  level endon("game_ended");
  level endon("end_containment_fx");
  var_0 = (randomintrange(-10000, 10000), randomintrange(-10000, 10000), 0);
  var_1 = level.br_level.br_mapcenter + var_0;
  var_2 = getdvarint("scr_br_containmentprotocol_ambientfx_rocketheight", -700);
  var_1 = (var_1[0], var_1[1], var_2);
  var_3 = vectorNormalize((randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0));
  var_4 = scripts\mp\utility\game_utility_mp::removespawns(0);
  var_5 = getdvarfloat("scr_br_containmentprotocol_ambientfx_rocket_pathlengthmultiplier", 1.7);
  var_6 = var_4 * var_5;
  var_7 = var_1 - var_3 * var_6 / 2;
  var_8 = var_1 + var_3 * var_6 / 2;
  var_9 = getdvarint("scr_br_containmentprotocol_ambientfx_rocketduration", 14);
  var_10 = spawn("script_model", var_7);

  if(!isDefined(var_10)) {
    return;
  }

  var_10 setModel("tag_origin");
  var_10 unmarkkeyframedmover(1);
  waitframe();
  waitframe();
  var_10 playLoopSound("zmb_cont_ks_missile_lp");
  playFXOnTag(level._effect["vista_rocket"], var_10, "tag_origin");
  var_11 = -1 * getdvarint("NPOQPMP", 800);
  var_12 = trajectorycalculateinitialvelocity(var_7, var_8, (0, 0, var_11), var_9);
  var_10 movegravity(var_12, var_9);

  if(getdvarint("scr_br_containmentprotocol_debug_logs", 0) == 1) {
    var_13 = "Vista Rocket start:" + var_7 + "destination:" + var_8;
    iprintlnbold(var_13);
    logstring(var_13);
  }

  var_14 = gettime();
  var_15 = gettime() + var_9 * 1000;

  while(gettime() < var_15) {
    var_16 = var_10.origin;
    waitframe();
    var_17 = var_10.origin;
    var_18 = var_17 - var_16;
    var_10.angles = vectortoangles(var_18);
    var_10 addpitch(90);
  }

  waitframe();
  var_10 delete();
}

function actorrope() {
  level endon("game_ended");
  level endon("end_containment_fx");
  var_0 = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle();

  if(getdvarint("scr_br_containmentprotocol_debug_planestafe_origin", 0) == 1) {
    var_0 = (0, 0, 0);
  }

  var_1 = getdvarint("scr_br_containmentprotocol_ambientfx_rumbleradius", 10000);
  var_2 = var_1 * var_1;
  var_3 = undefined;
  var_4 = [];

  foreach(var_6 in level.players) {
    if(var_6 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
      continue;
    }

    var_3 = var_6;
    var_7 = distancesquared(var_6.origin, var_0);

    if(var_7 < var_2) {
      var_4 = var_6;
    }
  }

  foreach(var_6 in var_4) {}

  while(istrue(level.hostskipburndownhigh.monitorexitbutton) || istrue(level.hostskipburndownhigh.ref_123ad)) {
    waitframe();
  }

  level.hostskipburndownhigh.ref_123ad = 1;
  add_practice_bots(1, var_4);
  add_rider_to_decho();
  var_11 = undefined;

  if(var_4.size > 0) {
    var_11 = var_4[0];
  } else {
    var_11 = var_3;
  }

  if(isDefined(var_11)) {
    wait 3;
    add_to_ents_to_clean_up(var_4);
    var_11 scripts\cp_mp\killstreaks\airstrike::game_end_watcher(var_0, 1, 1);

    if(getdvarint("scr_br_containmentprotocol_debug_logs", 0) == 1) {
      iprintlnbold("Plane Strafe above:" + var_0);
    }

    wait 12;
    add_to_emp_drone_target_list(var_4);

    if(istrue(level.hostskipburndownhigh.ref_12abe)) {
      add_rider_to_decho(1, level.hostskipburndownhigh.instant_revive_buffer);
      wait 3;
      var_11 scripts\cp_mp\killstreaks\airstrike::game_end_watcher(var_0, 1, 1);

      if(getdvarint("scr_br_containmentprotocol_debug_logs", 0) == 1) {
        iprintlnbold("Plane Strafe came back over:" + var_0);
      }

      wait 12;
      add_to_emp_drone_target_list(var_4);
      wait 3;
    }
  }

  level.hostskipburndownhigh.instant_revive_buffer = undefined;
  level.hostskipburndownhigh.ref_12abe = undefined;
  level.hostskipburndownhigh.ref_123ad = undefined;
}

function add_player_to_focus_fire_attacker_list() {
  level endon("game_ended");
  level endon("end_containment_fx");

  if(level.mapname != "mp_br_mechanics") {
    level waittill("br_c130_left_bounds");
  }

  var_0 = add_scriptable_setup();

  if(!var_0) {
    return;
  }

  add_to_fulton_actors();
  add_stealth_logic_to_group();
}

function add_scriptable_setup() {
  if(level.hostskipburndownhigh.intensity == 0 || level.hostskipburndownhigh.intensity == 1) {
    if(getdvarint("scr_br_containmentprotocol_debug_alwaysactivate", 0) != 1) {
      return false;
    }

    level.hostskipburndownhigh.intensity = 2;
  }

  if(level.hostskipburndownhigh.intensity == 2) {
    game["dialog"]["containment_vo_1"] = "alert_phase1_10";
    game["dialog"]["containment_vo_2"] = "alert_phase1_20";
    game["dialog"]["containment_vo_3"] = "alert_phase1_30";
  } else if(level.hostskipburndownhigh.intensity == 3) {
    game["dialog"]["containment_vo_1"] = "alert_phase2_10";
    game["dialog"]["containment_vo_2"] = "alert_phase2_20";
    game["dialog"]["containment_vo_3"] = "alert_phase2_30";
    game["dialog"]["containment_vo_4"] = "alert_phase2_40";
    game["dialog"]["containment_vo_5"] = "alert_tv_station_10";
  } else if(level.hostskipburndownhigh.intensity == 4) {
    game["dialog"]["containment_vo_1"] = "alert_phase3_10";
    game["dialog"]["containment_vo_2"] = "alert_phase3_20";
    game["dialog"]["containment_vo_3"] = "alert_phase3_30";
    game["dialog"]["containment_vo_4"] = "alert_superstore_10";
    game["dialog"]["containment_vo_5"] = "alert_phase3_50";
  } else if(level.hostskipburndownhigh.intensity == 5) {
    game["dialog"]["containment_vo_1"] = "alert_phase4_10";
    game["dialog"]["containment_vo_2"] = "alert_phase4_20";
    game["dialog"]["containment_vo_3"] = "alert_dam_10";
    game["dialog"]["containment_vo_4"] = "alert_phase4_30";
    var_0 = "";
    var_1 = randomintrange(0, 4);

    switch (var_1) {
      case 0:
        var_0 = "alert_phase4_40";
        break;
      case 1:
        var_0 = "alert_phase4_50";
        break;
      case 2:
        var_0 = "alert_phase4_70";
        break;
      case 3:
        var_0 = "alert_phase4_80";
        break;
      default:
        var_0 = "alert_phase4_40";
        break;
    }

    game["dialog"]["containment_vo_5"] = var_0;
  } else {
    return false;
  }

  if(getdvarint("scr_br_containmentProtocol_vo_final", 0) == 1) {
    game["dialog"]["containment_vo_1"] = "alert_phase4_10";
    game["dialog"]["containment_vo_2"] = "alert_phase4_20";
    game["dialog"]["containment_vo_3"] = "alert_phase4_30";
    game["dialog"]["containment_vo_4"] = "dov1_infil_1_10";
    game["dialog"]["containment_vo_5"] = "alert_phase4_40";
    game["dialog"]["containment_vo_6"] = "alert_phase4_50";
    game["dialog"]["containment_vo_7"] = "";
    game["dialog"]["containment_vo_8"] = "";
    game["dialog"]["containment_vo_9"] = "";
  }

  return true;
}

function add_to_fulton_actors() {
  level endon("game_ended");
  level endon("end_containment_fx");
  var_0 = getdvarint("scr_br_containmentprotocol_vo_delay_min", 90);
  var_1 = getdvarint("scr_br_containmentprotocol_vo_delay_max", 360);
  var_2 = getdvarint("scr_br_containmentprotocol_vo_delay_override", -1);
  var_3 = var_1;

  if(var_2 != -1) {
    var_3 = var_2;
  } else {
    var_3 = randomintrange(var_0, var_1);
  }

  if(getdvarint("scr_br_containmentProtocol_vo_final", 0) == 1 && level.mapname != "mp_br_mechanics") {
    level waittill("dov_1_broadcast");
    return;
  }

  wait var_3;
}

function add_stealth_logic_to_group() {
  level endon("game_ended");
  level endon("end_containment_fx");

  while(istrue(level.hostskipburndownhigh.ref_123ad)) {
    waitframe();
  }

  level.hostskipburndownhigh.monitorexitbutton = 1;
  add_practice_bots(1);
  add_struct();
  add_to_fulton_actor_players();
  wait 4;
  var_0 = 0;

  if(getdvarint("scr_br_containmentProtocol_vo_final", 0) == 1) {
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_1");
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_2");
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_3");
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("op1_", "containment_vo_4", undefined, 1);
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_5");
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_6");
    var_0 += 1;
    thread elevatordoors(var_0);
  } else {
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_1");
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_2");
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_3");
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_4");
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_5");
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_6");
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_7");
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_8");
    var_0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_9");
  }

  wait var_0;
  add_to_fulton_actor_players();
  wait 4;
  setomnvarforallclients("ui_br_events", 0);
  level.hostskipburndownhigh.monitorexitbutton = undefined;
}

function add_to_bomb_detonator_waiting_for_pick_up_array(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level endon("end_containment_fx");

  if(!isDefined(game["dialog"][var_1]) || game["dialog"][var_1] == "") {
    return 0;
  }

  var_4 = "dx_brm_" + var_0 + game["dialog"][var_1];
  var_4 = tolower(var_4);
  var_5 = lookupsoundlength(var_4, 1) / 1000;
  var_5 += 1;
  var_6 = undefined;

  if(isDefined(var_2)) {
    var_6 = var_2;
  } else {
    var_6 = level.players;
  }

  foreach(var_8 in var_6) {
    if(!isDefined(var_8)) {
      continue;
    }

    if(!istrue(var_8 scripts\mp\gametypes\br_public::ref_125f3()) || istrue(var_3)) {
      var_8 queuedialogforplayer(var_4, var_1, var_5);
    }
  }

  return var_5;
}

function add_to_fulton_actor_players() {
  foreach(var_1 in level.players) {
    if(add_spawn_disable_struct(var_1)) {
      var_1 playsoundtoplayer("ui_broadcast_warning", var_1);
    }
  }
}

function add_struct() {
  var_0 = max(0, level.hostskipburndownhigh.intensity - 1);
  setomnvarforallclients("ui_br_events", int(var_0));

  foreach(var_2 in level.players) {
    if(!add_spawn_disable_struct(var_2)) {
      var_2 setclientomnvar("ui_br_events", 0);
    }
  }
}

function elim_hud() {
  if(istrue(level.hostskipburndownhigh.monitorexitbutton)) {
    self setclientomnvar("ui_br_events", 0);
    return;
  }
}

function elevatordoors(var_0) {
  if(getdvarint("scr_br_containmentprotocol", 0) == 0 && !istrue(level.hostskipburndownlow)) {
    return;
  }

  if(getdvarint("scr_br_containmentProtocol_vo_final", 0) != 1) {
    return;
  }

  if(!isDefined(level.hostskipburndownhigh.ref_146f9)) {
    level.hostskipburndownhigh.ref_146f9 = scripts\engine\utility::play_loopsound_in_space("zmb_takeover_radio_background", (0, 0, 0));
    level.hostskipburndownhigh.ref_146f9 unmarkkeyframedmover(1);
    level.hostskipburndownhigh.ref_146f9 hide();
  }

  foreach(var_2 in level.players) {
    if(!add_spawn_disable_struct(var_2)) {
      continue;
    }

    level.hostskipburndownhigh.ref_146f9 showtoplayer(var_2);
    thread add_to_mine_list(var_2);
  }
}

function add_to_mine_list(var_0) {
  self endon("disconnect");
  scripts\engine\utility::waittill_notify_or_timeout_return("spawnZombie", var_0);

  if(!isDefined(level.hostskipburndownhigh.ref_146f9)) {
    return;
  }

  level.hostskipburndownhigh.ref_146f9 hidefromplayer(self);

  if(istrue(level.hostskipburndownhigh.monitorexitbutton) && !add_spawn_disable_struct(self)) {
    self setclientomnvar("ui_br_events", 0);
    return;
  }
}

function elevator_trigger_wait_for_spawn() {
  if(!isDefined(level.hostskipburndownhigh.ref_146f9)) {
    return;
  }

  level.hostskipburndownhigh.ref_146f9 delete();
  level.hostskipburndownhigh.ref_146f9 = undefined;
}

function add_spawn_disable_struct(var_0) {
  var_1 = istrue(var_0.delay_enter_combat_after_investigating_grenade);
  var_2 = var_0 scripts\mp\gametypes\br_public::ref_125f3();
  var_3 = var_0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();
  return !var_1 && !var_2 && !var_3;
}

function add_rider_to_decho(var_0, var_1) {
  var_2 = -1;
  var_3 = "";
  var_2 = randomintrange(0, 3);

  switch (var_2) {
    case 0:
      var_3 = "clv_";
      break;
    case 1:
      var_3 = "g51_";
      break;
    case 2:
      var_3 = "g68_";
      break;
    default:
      var_3 = "clv_";
      break;
  }

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  level.hostskipburndownhigh.instant_revive_buffer = var_3;
  game["dialog"]["strafing_pre"] = "";
  game["dialog"]["strafing_before"] = "";
  game["dialog"]["strafing_after"] = "";
  game["dialog"]["strafing_post"] = "";

  switch (var_3) {
    case "clv_":
      var_2 = randomintrange(0, 5);

      switch (var_2) {
        case 0:
          game["dialog"]["strafing_pre"] = "missile_away_10";
          break;
        case 1:
          game["dialog"]["strafing_pre"] = "missile_away_20";
          break;
        default:
          game["dialog"]["strafing_pre"] = "";
          break;
      }

      break;
    case "g51_":
      var_2 = randomintrange(0, 4);

      switch (var_2) {
        case 0:
          game["dialog"]["strafing_pre"] = "strafing_strangers_10";
        default:
          game["dialog"]["strafing_pre"] = "";
          break;
      }

      break;
    case "g68_":
      var_2 = randomintrange(0, 4);

      switch (var_2) {
        case 0:
          game["dialog"]["strafing_pre"] = "strafing_strangers_10";
          break;
        case 1:
          game["dialog"]["strafing_pre"] = "strafing_swarming_10";
          break;
        default:
          game["dialog"]["strafing_pre"] = "";
          break;
      }

      break;
    default:
      break;
  }

  switch (var_3) {
    case "clv_":
      var_2 = randomintrange(0, 6);

      switch (var_2) {
        case 0:
          game["dialog"]["strafing_before"] = "missile_inbound_10";
          break;
        case 1:
          game["dialog"]["strafing_before"] = "missile_launch_confirmed_10";
          break;
        case 2:
          game["dialog"]["strafing_before"] = "missile_launch_confirmed_20";
          break;
        case 3:
          game["dialog"]["strafing_before"] = "missile_launched_10";
          break;
        case 4:
          game["dialog"]["strafing_before"] = "missile_launched_20";
          break;
        case 5:
          game["dialog"]["strafing_before"] = "missile_launched_30";
          break;
        default:
          game["dialog"]["strafing_before"] = "";
          break;
      }

      break;
    case "g51_":
      var_2 = randomintrange(0, 3);

      switch (var_2) {
        case 0:
          game["dialog"]["strafing_before"] = "strafing_commence_10";
          break;
        case 1:
          game["dialog"]["strafing_before"] = "strafing_inbound_10";
          break;
        case 2:
          game["dialog"]["strafing_before"] = "strafing_weapon_drop_10";
          break;
        default:
          game["dialog"]["strafing_before"] = "";
          break;
      }

      break;
    case "g68_":
      var_2 = randomintrange(0, 2);

      switch (var_2) {
        case 0:
          game["dialog"]["strafing_before"] = "strafing_ground_attack_10";
          break;
        case 1:
          game["dialog"]["strafing_before"] = "strafing_target_grid_10";
          break;
        default:
          game["dialog"]["strafing_before"] = "";
          break;
      }

      break;
    default:
      break;
  }

  switch (var_3) {
    case "clv_":
      var_2 = randomintrange(0, 3);

      switch (var_2) {
        case 0:
          game["dialog"]["strafing_after"] = "missile_miss_10";
          break;
        case 1:
          game["dialog"]["strafing_after"] = "missile_miss_20";
          break;
        case 2:
          game["dialog"]["strafing_after"] = "missile_miss_30";
          break;
        default:
          game["dialog"]["strafing_after"] = "";
          break;
      }

      break;
    case "g51_":
      var_2 = randomintrange(0, 9);

      switch (var_2) {
        case 0:
          game["dialog"]["strafing_after"] = "strafing_1_kill_10";
          break;
        case 1:
          game["dialog"]["strafing_after"] = "strafing_2_kill_10";
          break;
        case 2:
          game["dialog"]["strafing_after"] = "strafing_eliminated_10";
          break;
        case 3:
          game["dialog"]["strafing_after"] = "strafing_fail_10";
          break;
        case 4:
          game["dialog"]["strafing_after"] = "strafing_fail_20";
          break;
        case 5:
          game["dialog"]["strafing_after"] = "strafing_fail_30";
          break;
        case 6:
          game["dialog"]["strafing_after"] = "strafing_hits_10";
          break;
        case 7:
          game["dialog"]["strafing_after"] = "strafing_multiple_hit_10";
          break;
        case 8:
          game["dialog"]["strafing_after"] = "strafing_strangers_down_10";
          break;
        default:
          game["dialog"]["strafing_after"] = "";
          break;
      }

      break;
    case "g68_":
      var_2 = randomintrange(0, 6);

      switch (var_2) {
        case 0:
          game["dialog"]["strafing_after"] = "strafing_1_kill_10";
          break;
        case 1:
          game["dialog"]["strafing_after"] = "strafing_2_targets_down_10";
          break;
        case 2:
          game["dialog"]["strafing_after"] = "strafing_2_kill_10";
          break;
        case 3:
          game["dialog"]["strafing_after"] = "strafing_3_kill_10";
          break;
        case 4:
          game["dialog"]["strafing_after"] = "strafing_fail_10";
          break;
        case 5:
          game["dialog"]["strafing_after"] = "strafing_fail_20";
          break;
        case 6:
          game["dialog"]["strafing_after"] = "strafing_fail_30";
          break;
        case 7:
          game["dialog"]["strafing_after"] = "strafing_on_target_10";
          break;
        case 8:
          game["dialog"]["strafing_after"] = "strafing_stranger_down_10";
          break;
        default:
          game["dialog"]["strafing_after"] = "";
          break;
      }

      break;
    default:
      break;
  }

  switch (var_3) {
    case "clv_":
      game["dialog"]["strafing_post"] = "";
      break;
    case "g51_":
      var_2 = randomintrange(0, 4);

      switch (var_2) {
        case 0:
          game["dialog"]["strafing_post"] = "strafing_down_there_10";
          break;
        case 1:
          game["dialog"]["strafing_post"] = "strafing_reengage_12";
          level.hostskipburndownhigh.ref_12abe = 1;
          break;
        default:
          game["dialog"]["strafing_pre"] = "";
          break;
      }

      break;
    case "g68_":
      var_2 = randomintrange(0, 4);

      switch (var_2) {
        case 0:
          game["dialog"]["strafing_post"] = "strafing_down_there_10";
          break;
        case 1:
          game["dialog"]["strafing_post"] = "strafing_reengage_10";
          level.hostskipburndownhigh.ref_12abe = 1;
          break;
        default:
          game["dialog"]["strafing_post"] = "";
          break;
      }

      break;
    default:
      break;
  }

  if(istrue(var_0)) {
    game["dialog"]["strafing_pre"] = "";
    game["dialog"]["strafing_before"] = "";
    game["dialog"]["strafing_post"] = "";
    return;
  }
}

function add_to_ents_to_clean_up(var_0) {
  level endon("end_containment_fx");
  var_1 = add_to_bomb_detonator_waiting_for_pick_up_array(level.hostskipburndownhigh.instant_revive_buffer, "strafing_pre", var_0);

  if(var_1 != 0) {
    wait var_1 + 3;
  }

  add_to_bomb_detonator_waiting_for_pick_up_array(level.hostskipburndownhigh.instant_revive_buffer, "strafing_before", var_0);
}

function add_to_emp_drone_target_list(var_0) {
  level endon("end_containment_fx");
  var_1 = add_to_bomb_detonator_waiting_for_pick_up_array(level.hostskipburndownhigh.instant_revive_buffer, "strafing_after", var_0);

  if(var_1 != 0) {
    wait var_1 + 3;
  }

  var_1 = add_to_bomb_detonator_waiting_for_pick_up_array(level.hostskipburndownhigh.instant_revive_buffer, "strafing_post", var_0);

  if(var_1 != 0) {
    wait var_1;
    return;
  }
}

function add_practice_bots(var_0, var_1) {
  level endon("game_ended");
  level endon("end_containment_fx");
  var_2 = undefined;

  if(isDefined(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = level.players;
  }

  var_3 = gettime();
  var_4 = var_3 + 10000;

  while(var_3 < var_4) {
    waitframe();
    var_5 = 0;

    foreach(var_7 in var_2) {
      if(!isDefined(var_7)) {
        continue;
      }

      if(!var_7 method_87c3()) {
        var_5 = 1;
        break;
      }
    }

    if(var_5) {
      var_3 = gettime();
      continue;
    }

    break;
  }
}