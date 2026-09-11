/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_containmentprotocol.gsc
***********************************************************/

function init() {
  var0 = any_player_within_distance2d();

  if(!var0) {
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
  var0 = getdvarfloat("scr_br_containmentprotocol_intensity_likelihood", 0.05);
  var1 = randomfloat(1) < var0;
  return var1 || istrue(level.hostskipburndownlow);
}

function actorid() {
  level endon("game_ended");
  level endon("end_containment_fx");
  jumpiffalse(level.mapname != "mp_br_mechanics") LOC_00000025;
  level waittill("br_c130_left_bounds");

  for(;;) {
    var0 = scripts\mp\flags::gameflag("prematch_done") || istrue(level.hostskipburndownlow);

    if(var0) {
      thread actorloopanim();
    }

    var1 = 0;
    var2 = scripts\mp\utility\game::round_vehicle_logic() == "reveal";

    if(!var2 && isDefined(level.br_circle) && isDefined(level.br_circle.circleindex)) {
      var3 = getdvarint("scr_br_containmentprotocol_ambientfx_circlenum_delay", 5);
      var1 = 5 * max(0, level.br_circle.circleindex);
    }

    var4 = var1 + getdvarint("scr_br_containmentprotocol_ambientfx_delay_min", 25);
    var5 = var1 + getdvarint("scr_br_containmentprotocol_ambientfx_delay_max", 70);
    var6 = randomfloatrange(var4, var5);
    wait var6;
  }
}

function actorloopanim() {
  level endon("end_containment_fx");

  for(var0 = getdvarint("scr_br_containmentprotocol_ambientfx_rocketcount", 3); var0 > 0; var0--) {
    wait randomfloat(15);
    thread actorthinkpath_default();
  }

  var1 = getdvarint("scr_br_containmentprotocol_ambientfx_delay_before_plane_strafe", 3);
  wait var1;
  actorrope();
}

function actorthinkpath_default() {
  level endon("game_ended");
  level endon("end_containment_fx");
  var0 = (randomintrange(-10000, 10000), randomintrange(-10000, 10000), 0);
  var1 = level.br_level.br_mapcenter + var0;
  var2 = getdvarint("scr_br_containmentprotocol_ambientfx_rocketheight", -700);
  var1 = (var1[0], var1[1], var2);
  var3 = vectorNormalize((randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0));
  var4 = scripts\mp\utility\game_utility_mp::removespawns(0);
  var5 = getdvarfloat("scr_br_containmentprotocol_ambientfx_rocket_pathlengthmultiplier", 1.7);
  var6 = var4 * var5;
  var7 = var1 - var3 * var6 / 2;
  var8 = var1 + var3 * var6 / 2;
  var9 = getdvarint("scr_br_containmentprotocol_ambientfx_rocketduration", 14);
  var10 = spawn("script_model", var7);

  if(!isDefined(var10)) {
    return;
  }

  var10 setModel("tag_origin");
  var10 unmarkkeyframedmover(1);
  waitframe();
  waitframe();
  var10 playLoopSound("zmb_cont_ks_missile_lp");
  playFXOnTag(level._effect["vista_rocket"], var10, "tag_origin");
  var11 = -1 * getdvarint("NPOQPMP", 800);
  var12 = trajectorycalculateinitialvelocity(var7, var8, (0, 0, var11), var9);
  var10 movegravity(var12, var9);

  if(getdvarint("scr_br_containmentprotocol_debug_logs", 0) == 1) {
    var13 = "Vista Rocket start:" + var7 + "destination:" + var8;
    iprintlnbold(var13);
    logstring(var13);
  }

  var14 = gettime();
  var15 = gettime() + var9 * 1000;

  while(gettime() < var15) {
    var16 = var10.origin;
    waitframe();
    var17 = var10.origin;
    var18 = var17 - var16;
    var10.angles = vectortoangles(var18);
    var10 addpitch(90);
  }

  waitframe();
  var10 delete();
}

function actorrope() {
  level endon("game_ended");
  level endon("end_containment_fx");
  var0 = scripts\mp\gametypes\br_circle::getrandompointincurrentcircle();

  if(getdvarint("scr_br_containmentprotocol_debug_planestafe_origin", 0) == 1) {
    var0 = (0, 0, 0);
  }

  var1 = getdvarint("scr_br_containmentprotocol_ambientfx_rumbleradius", 10000);
  var2 = var1 * var1;
  var3 = undefined;
  var4 = [];

  foreach(var6 in level.players) {
    if(var6 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal()) {
      continue;
    }

    var3 = var6;
    var7 = distancesquared(var6.origin, var0);

    if(var7 < var2) {
      var4 = var6;
    }
  }

  foreach(var6 in var4) {}

  while(istrue(level.hostskipburndownhigh.monitorexitbutton) || istrue(level.hostskipburndownhigh.ref_123ad)) {
    waitframe();
  }

  level.hostskipburndownhigh.ref_123ad = 1;
  add_practice_bots(1, var4);
  add_rider_to_decho();
  var11 = undefined;

  if(var4.size > 0) {
    var11 = var4[0];
  } else {
    var11 = var3;
  }

  if(isDefined(var11)) {
    wait 3;
    add_to_ents_to_clean_up(var4);
    var11 scripts\cp_mp\killstreaks\airstrike::game_end_watcher(var0, 1, 1);

    if(getdvarint("scr_br_containmentprotocol_debug_logs", 0) == 1) {
      iprintlnbold("Plane Strafe above:" + var0);
    }

    wait 12;
    add_to_emp_drone_target_list(var4);

    if(istrue(level.hostskipburndownhigh.ref_12abe)) {
      add_rider_to_decho(1, level.hostskipburndownhigh.instant_revive_buffer);
      wait 3;
      var11 scripts\cp_mp\killstreaks\airstrike::game_end_watcher(var0, 1, 1);

      if(getdvarint("scr_br_containmentprotocol_debug_logs", 0) == 1) {
        iprintlnbold("Plane Strafe came back over:" + var0);
      }

      wait 12;
      add_to_emp_drone_target_list(var4);
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

  var0 = add_scriptable_setup();

  if(!var0) {
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
    var0 = "";
    var1 = randomintrange(0, 4);

    switch (var1) {
      case 0:
        var0 = "alert_phase4_40";
        break;
      case 1:
        var0 = "alert_phase4_50";
        break;
      case 2:
        var0 = "alert_phase4_70";
        break;
      case 3:
        var0 = "alert_phase4_80";
        break;
      default:
        var0 = "alert_phase4_40";
        break;
    }

    game["dialog"]["containment_vo_5"] = var0;
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
  var0 = getdvarint("scr_br_containmentprotocol_vo_delay_min", 90);
  var1 = getdvarint("scr_br_containmentprotocol_vo_delay_max", 360);
  var2 = getdvarint("scr_br_containmentprotocol_vo_delay_override", -1);
  var3 = var1;

  if(var2 != -1) {
    var3 = var2;
  } else {
    var3 = randomintrange(var0, var1);
  }

  if(getdvarint("scr_br_containmentProtocol_vo_final", 0) == 1 && level.mapname != "mp_br_mechanics") {
    level waittill("dov_1_broadcast");
    return;
  }

  wait var3;
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
  var0 = 0;

  if(getdvarint("scr_br_containmentProtocol_vo_final", 0) == 1) {
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_1");
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_2");
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_3");
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("op1_", "containment_vo_4", undefined, 1);
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_5");
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_6");
    var0 += 1;
    thread elevatordoors(var0);
  } else {
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_1");
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_2");
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_3");
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_4");
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_5");
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_6");
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_7");
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_8");
    var0 += add_to_bomb_detonator_waiting_for_pick_up_array("ebr_", "containment_vo_9");
  }

  wait var0;
  add_to_fulton_actor_players();
  wait 4;
  setomnvarforallclients("ui_br_events", 0);
  level.hostskipburndownhigh.monitorexitbutton = undefined;
}

function add_to_bomb_detonator_waiting_for_pick_up_array(var0, var1, var2, var3) {
  level endon("game_ended");
  level endon("end_containment_fx");

  if(!isDefined(game["dialog"][var1]) || game["dialog"][var1] == "") {
    return 0;
  }

  var4 = "dx_brm_" + var0 + game["dialog"][var1];
  var4 = tolower(var4);
  var5 = lookupsoundlength(var4, 1) / 1000;
  var5 += 1;
  var6 = undefined;

  if(isDefined(var2)) {
    var6 = var2;
  } else {
    var6 = level.players;
  }

  foreach(var8 in var6) {
    if(!isDefined(var8)) {
      continue;
    }

    if(!istrue(var8 scripts\mp\gametypes\br_public::ref_125f3()) || istrue(var3)) {
      var8 queuedialogforplayer(var4, var1, var5);
    }
  }

  return var5;
}

function add_to_fulton_actor_players() {
  foreach(var1 in level.players) {
    if(add_spawn_disable_struct(var1)) {
      var1 playsoundtoplayer("ui_broadcast_warning", var1);
    }
  }
}

function add_struct() {
  var0 = max(0, level.hostskipburndownhigh.intensity - 1);
  setomnvarforallclients("ui_br_events", int(var0));

  foreach(var2 in level.players) {
    if(!add_spawn_disable_struct(var2)) {
      var2 setclientomnvar("ui_br_events", 0);
    }
  }
}

function elim_hud() {
  if(istrue(level.hostskipburndownhigh.monitorexitbutton)) {
    self setclientomnvar("ui_br_events", 0);
    return;
  }
}

function elevatordoors(var0) {
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

  foreach(var2 in level.players) {
    if(!add_spawn_disable_struct(var2)) {
      continue;
    }

    level.hostskipburndownhigh.ref_146f9 showtoplayer(var2);
    thread add_to_mine_list(var2);
  }
}

function add_to_mine_list(var0) {
  self endon("disconnect");
  scripts\engine\utility::waittill_notify_or_timeout_return("spawnZombie", var0);

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

function add_spawn_disable_struct(var0) {
  var1 = istrue(var0.delay_enter_combat_after_investigating_grenade);
  var2 = var0 scripts\mp\gametypes\br_public::ref_125f3();
  var3 = var0 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();
  return !var1 && !var2 && !var3;
}

function add_rider_to_decho(var0, var1) {
  var2 = -1;
  var3 = "";
  var2 = randomintrange(0, 3);

  switch (var2) {
    case 0:
      var3 = "clv_";
      break;
    case 1:
      var3 = "g51_";
      break;
    case 2:
      var3 = "g68_";
      break;
    default:
      var3 = "clv_";
      break;
  }

  if(isDefined(var1)) {
    var3 = var1;
  }

  level.hostskipburndownhigh.instant_revive_buffer = var3;
  game["dialog"]["strafing_pre"] = "";
  game["dialog"]["strafing_before"] = "";
  game["dialog"]["strafing_after"] = "";
  game["dialog"]["strafing_post"] = "";

  switch (var3) {
    case "clv_":
      var2 = randomintrange(0, 5);

      switch (var2) {
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
      var2 = randomintrange(0, 4);

      switch (var2) {
        case 0:
          game["dialog"]["strafing_pre"] = "strafing_strangers_10";
        default:
          game["dialog"]["strafing_pre"] = "";
          break;
      }

      break;
    case "g68_":
      var2 = randomintrange(0, 4);

      switch (var2) {
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

  switch (var3) {
    case "clv_":
      var2 = randomintrange(0, 6);

      switch (var2) {
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
      var2 = randomintrange(0, 3);

      switch (var2) {
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
      var2 = randomintrange(0, 2);

      switch (var2) {
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

  switch (var3) {
    case "clv_":
      var2 = randomintrange(0, 3);

      switch (var2) {
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
      var2 = randomintrange(0, 9);

      switch (var2) {
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
      var2 = randomintrange(0, 6);

      switch (var2) {
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

  switch (var3) {
    case "clv_":
      game["dialog"]["strafing_post"] = "";
      break;
    case "g51_":
      var2 = randomintrange(0, 4);

      switch (var2) {
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
      var2 = randomintrange(0, 4);

      switch (var2) {
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

  if(istrue(var0)) {
    game["dialog"]["strafing_pre"] = "";
    game["dialog"]["strafing_before"] = "";
    game["dialog"]["strafing_post"] = "";
    return;
  }
}

function add_to_ents_to_clean_up(var0) {
  level endon("end_containment_fx");
  var1 = add_to_bomb_detonator_waiting_for_pick_up_array(level.hostskipburndownhigh.instant_revive_buffer, "strafing_pre", var0);

  if(var1 != 0) {
    wait var1 + 3;
  }

  add_to_bomb_detonator_waiting_for_pick_up_array(level.hostskipburndownhigh.instant_revive_buffer, "strafing_before", var0);
}

function add_to_emp_drone_target_list(var0) {
  level endon("end_containment_fx");
  var1 = add_to_bomb_detonator_waiting_for_pick_up_array(level.hostskipburndownhigh.instant_revive_buffer, "strafing_after", var0);

  if(var1 != 0) {
    wait var1 + 3;
  }

  var1 = add_to_bomb_detonator_waiting_for_pick_up_array(level.hostskipburndownhigh.instant_revive_buffer, "strafing_post", var0);

  if(var1 != 0) {
    wait var1;
    return;
  }
}

function add_practice_bots(var0, var1) {
  level endon("game_ended");
  level endon("end_containment_fx");
  var2 = undefined;

  if(isDefined(var1)) {
    var2 = var1;
  } else {
    var2 = level.players;
  }

  var3 = gettime();
  var4 = var3 + 10000;

  while(var3 < var4) {
    waitframe();
    var5 = 0;

    foreach(var7 in var2) {
      if(!isDefined(var7)) {
        continue;
      }

      if(!var7 method_87c3()) {
        var5 = 1;
        break;
      }
    }

    if(var5) {
      var3 = gettime();
      continue;
    }

    break;
  }
}