/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2440.gsc
*************************************************/

init() {
  _id_06CB::_id_AA4A(::_id_AA6D);
  _id_0987::_id_C215("orb_follow", ::_id_7FBE, ::setup, ::_id_8CE4, ::_id_385C, "orb_follow", undefined, undefined, 14, undefined, undefined, ::on_player_spawned);
  _id_06CB::_id_AA65(::on_player_spawned);
  level init_dome();
}

_id_7FBE(var_0) {
  var_0._id_0DF6 = var_0._id_3BE8["teleport_pt"];
  var_0._id_529C = 1;

  if(getdvarint("#x3ce6f1c71a4bdefaa", 0) == 1) {
    var_0.b_force_play_kickoff_vo = 1;
    var_0.override_vo_func = ::override_domination_vo_func;
    var_0.override_vo_cleanup_func = ::override_domination_vo_cleanup_func;
  }
}

override_domination_vo_func(var_0) {
  if(_id_0987::is_dark_aether(var_0)) {
    var_0.override_vos = "orb_follow_dark_aether";
  }
}

override_domination_vo_cleanup_func(var_0) {
  if(_id_0987::is_dark_aether(var_0)) {
    var_0.override_vos = undefined;
  }
}

setup(var_0) {
  level.get_objective_item_positions_func = ::get_objective_positions;
  var_0 init_paths();
  var_0 _id_800F();
  var_0 thread orb_start_sequence();
  var_0 init_orb_boundary();
  var_0 init_damage_boundary();
  var_0 update_player_spawners(0);
}

_id_8CE4(var_0) {
  var_0 notify("teleport_go");
  level thread scripts\cp\zombies\objective_barriers::toggle_objective_clip(var_0._id_3BE8["prop"], 1);
  var_0.n_orb_follow_zombie_spawns = 0;
  thread play_kickoff_vo(var_0);
  var_0 notify("orb_follow_go");
  var_0 thread _id_AC5C();
}

_id_AC5C() {
  self endon("players_dead");
  self endon("game_ended");
  thread _id_FBB8(0);
  _id_0987::set_objective_ui_state(2, 0, 1);
  thread _id_10A81();
  thread set_music(1);
  thread start_damage_boundary();
  thread start_marker();
  self waittill("kickoff_vo_complete");
  thread _id_249F();
}

_id_249F() {
  level endon("game_ended");
  self endon("players_dead");
  self endon("objective_ended");
  self endon("orb_follow_complete");
  self endon("reached_path_end");
  update_zombies_spawning(self.pathtravelstarts[self.pathstraversed], 0);
  self.curpath = self._id_AEE4[self.pathstraversed];
  self._id_F4C3 = self.pathtravelstarts[self.pathstraversed];
  var_0 = self.pathgraphs[self.pathstraversed];
  var_1 = spawnStruct();
  var_1._id_BD95 = 0;
  var_1._id_9B54 = self._id_AC5B._id_9B54;
  var_2 = 1000;
  waitframe();

  for(;;) {
    var_3 = 0.05;
    var_4 = 0;
    var_5 = get_players_in_range();
    var_6 = var_5.size;
    self._id_8939 = 0;
    var_7 = 0;

    if(var_6 > 0) {
      var_8 = float(var_6 / level.players.size);
      var_4 = _id_661E(var_8);
    }

    if(!isDefined(self._id_F4C3.target) && var_2 == 0) {
      thread _id_9B23();
      var_7 = 1;
    }

    var_2 = _id_A1EB(var_4, var_3);
    thread set_moving_loop_sound(self._id_8939);
    check_zombie_spawners_wait(self._id_8939);

    if(var_7) {
      break;
    }

    if(var_2 != 0) {
      var_9 = distancesquared(self._id_F4C3.origin, self._id_AC5B.origin);
      var_10 = var_0.pathgraph[self._id_F4C3._id_0481] - var_9;
      var_11 = var_10 / var_0.totaldistsquared;
      var_1._id_BD95 = max(0, var_11);
      _id_0987::_id_FB91(self._id_AC5B._id_9B53, var_1);
      _id_FBB8(var_1._id_BD95);
      thread update_zombies_spawning(self._id_F4C3, self._id_BD88);
    }

    foreach(var_13 in var_5) {
      var_13 updateplayernearorb();
    }

    wait(var_3);
  }
}

play_kickoff_vo(var_0) {
  wait 1;
  var_1 = 0;

  if(_id_0987::is_dark_aether(var_0)) {
    level.orb_follow_count_dark_aether = scripts\cp\utility::_id_459B(level.orb_follow_count_dark_aether, 1);
    var_1 = level.orb_follow_count_dark_aether;
  } else {
    level.orb_follow_count = scripts\cp\utility::_id_459B(level.orb_follow_count, 1);
    var_1 = level.orb_follow_count;
  }

  _id_0987::play_objective_kickoff_narration("orb_follow", var_1, var_0, 0);

  if(_id_0987::is_dark_aether(var_0)) {
    level.orb_follow_count_dark_aether++;
  } else {
    level.orb_follow_count++;
  }
}

orb_start_sequence() {
  self endon("players_dead");
  self endon("objective_ended");
  self endon("orb_follow_complete");
  set_orb_inactive();
  self waittill("orb_follow_go");
  thread set_orb_active();
  _id_A1EC(1);
}

set_orb_inactive() {
  level.dome._id_03A9 setscriptablepartstate("base", "normal");
  level.dome._id_03A9 setscriptablepartstate("dome", "normal");
  level.dome._id_03A9 setscriptablepartstate("fx", "off");
  self._id_AC5B stoploopsound("zmb_orb_lp");
  self._id_AC5B._id_9DE5 hide();
}

set_orb_active() {
  self endon("players_dead");
  self endon("objective_ended");
  self endon("orb_follow_complete");
  level.dome._id_03A9 setscriptablepartstate("base", "normal");
  level.dome._id_03A9 setscriptablepartstate("fx", "start");
  wait 3;
  set_orb_animation("s4_zm_orb_follow_anim");
  self._id_AC5B._id_9DE5 show();
  playsoundatpos(self._id_AC5B.origin, "zmb_orb_spawn");
  self._id_AC5B playLoopSound("zmb_orb_lp");
  level.dome._id_03A9 setscriptablepartstate("fx", "normal");
}

set_orb_animation(var_0) {
  self._id_AC5B._id_9DE5 _meth_82CB(var_0);
}

_id_800F() {
  var_0 = self.pathtravelstarts[0].origin;
  self._id_AC5B = spawn("script_model", var_0);
  self._id_AC5B setModel("tag_origin");
  self._id_AC5B._id_9DE5 = spawn("script_model", var_0);
  self._id_AC5B._id_9DE5 setModel("s4_zm_orb_follow_01");
  self._id_AC5B._id_9DE5 _meth_81B0("outline_objective");
  self._id_AC5B._id_9DE5 linkto(self._id_AC5B, "tag_origin", (0, 0, -8), (0, 0, 0));
  var_1 = scripts\engine\utility::getstruct(self.pathtravelstarts[0].target, "targetname");
  var_2 = var_1.origin - var_0;
  var_3 = vectortoangles(var_2);
  var_4 = (0, 0, 0);
  var_5 = _func_0047(var_3, var_4);
  self._id_AC5B.angles = var_5;
  self.currentorbrate = 0;
  var_4 = (0, 90, 0);
  var_5 = _func_0047(var_3, var_4);
  level.dome.origin = self._id_AC5B._id_9DE5.origin;
  level.dome.angles = var_5;
  init_moving_loop_sound();
}

get_objective_positions() {
  var_0 = level._id_3BE9._id_0F51;

  if(!isDefined(var_0._id_AC5B)) {
    return undefined;
  }

  var_1 = [];
  var_1[var_1.size] = var_0._id_AC5B.origin;
  return var_1;
}

_id_385E() {
  playsoundatpos(self._id_AC5B.origin, "zmb_orb_finale");
  level.dome._id_03A9 setscriptablepartstate("fx", "end");
  wait 0.5;
  cleanup_orb_sound();
  thread set_music(0);

  if(isDefined(self._id_AC5B)) {
    if(isDefined(self._id_AC5B._id_9DE5)) {
      self._id_AC5B._id_9DE5 delete();
    }

    self._id_AC5B delete();
  }

  self.currentorbrate = undefined;
  self notify("orb_deleted");
  level.dome._id_03A9 setscriptablepartstate("fx", "off");
  level.dome._id_03A9 setscriptablepartstate("dome", "off");
  level.dome._id_03A9 setscriptablepartstate("base", "off");
}

init_dome() {
  if(isDefined(self.dome)) {
    return;
  }
  var_0 = (0, 0, 0);
  self.dome = spawn("script_model", var_0);
  self.dome setModel("tag_origin");
  self.dome._id_03A9 = _func_03C5("s4_zm_orb_follow_01", var_0);
  self.dome._id_03A9 _meth_8746(self.dome);
  self.dome._id_03A9 setscriptablepartstate("base", "off");
  self.dome._id_03A9 setscriptablepartstate("dome", "off");
  self.dome._id_03A9 setscriptablepartstate("fx", "off");
}

init_moving_loop_sound() {
  if(isDefined(self._id_AC5B.activesfx)) {
    return;
  }
  self._id_AC5B.activesfx = scripts\engine\utility::_id_E1E9();
  self._id_AC5B.activesfx linkto(self._id_AC5B, "tag_origin", (0, 0, 0), (0, 0, 0));
  self._id_AC5B.activesfx._id_89AA = 0;
}

set_moving_loop_sound(var_0) {
  if(isDefined(self._id_AC5B.activesfx)) {
    var_1 = "zmb_orb_moving_lp";

    if(var_0 && !istrue(self._id_AC5B.activesfx._id_89AA)) {
      self._id_AC5B.activesfx playLoopSound(var_1);
      playsoundatpos(self._id_AC5B.origin, "zmb_orb_moving_start");
      self._id_AC5B.activesfx._id_89AA = 1;
    }

    if(!var_0 && istrue(self._id_AC5B.activesfx._id_89AA)) {
      self._id_AC5B.activesfx stoploopsound(var_1);
      playsoundatpos(self._id_AC5B.origin, "zmb_orb_moving_stop");
      self._id_AC5B.activesfx._id_89AA = 0;
    }
  }
}

cleanup_orb_sound() {
  self._id_AC5B.activesfx delete();
  self._id_AC5B stoploopsound("zmb_orb_lp");
}

set_music(var_0) {
  if(var_0) {
    _func_01E3("orb_follow");
  } else {
    _func_01E3("none");
    _id_0987::play_objective_complete_sfx();
  }
}

start_marker() {
  var_0 = spawnStruct();
  var_0._id_E747 = "current";
  var_0._id_96CF = self._id_AC5B;
  var_0._id_11012 = 20;
  var_0._id_7C3B = "v_ui_icons_zombies_minimap_objective";
  var_0._id_DCEA = 0;
  var_0._id_BD95 = 0;
  var_1 = "orb_follow_orb_marker";
  self._id_AC5B._id_9B53 = var_1;
  self._id_AC5B._id_9B54 = _id_0987::_id_0FFD(var_1, var_0);
}

cleanup_marker() {
  _id_0987::_id_C413(self._id_AC5B._id_9B53, self._id_AC5B._id_9B54);
  waitframe();
  self._id_AC5B._id_9B53 = undefined;
  self._id_AC5B._id_9B54 = undefined;
}

cleanup_player_spawners() {
  var_0 = self._id_3BE8["player_spawn_cluster"][0];
  var_1 = var_0._id_3BE8["player_spawn_location"];
  var_0.origin = self.pathtravelstarts[0].origin - var_0.orboffset;
  var_0.orboffset = undefined;

  foreach(var_3 in var_1) {
    var_3.origin = var_0.origin - var_3._id_A97D;
    var_3._id_A97D = undefined;
  }
}

_id_FBB8(var_0) {
  if(!isDefined(self._id_BD88)) {
    self._id_BD88 = var_0;
  }

  if(self._id_BD88 < 0.5 && var_0 >= 0.5) {
    var_1 = scripts\engine\utility::ter_op(_id_0987::is_dark_aether(self), "zm_c2of_o2of_krtx_o2ca", "zm_cmcp_obof_krtx_o50t");
    thread _id_0720::play_narration(var_1);
  }

  if(self._id_BD88 < 0.75 && var_0 >= 0.75 && !_id_0987::is_dark_aether(self)) {
    thread _id_0720::play_narration("zm_cmcp_obof_blkr_o75e");
  }

  self._id_BD88 = max(self._id_BD88, var_0);
  _id_0987::set_objective_ui_bar_progress(self._id_BD88);
}

cleanup_progress() {
  _id_0987::set_objective_ui_bar_progress(0);
  self._id_BD88 = undefined;
}

init_paths() {
  self._id_AEE4 = self._id_3BE8["orb_follow_path"];
  self.pathstraversed = 0;
  self.pathtravelstarts = [];

  foreach(var_2, var_1 in self._id_AEE4) {
    if(isDefined(var_1._id_039B) && var_1._id_039B != "") {
      self.pathtravelstarts[var_2] = ::scripts\engine\utility::getstruct(var_1._id_039B, "targetname");
    }
  }

  var_3 = self._id_3BE8["player_spawn_cluster"][0];
  var_4 = [];
  var_5 = [];

  if(self.pathtravelstarts.size > 0) {
    var_6 = get_closest_path_travel_start_to_point(var_3.origin);
    var_2 = scripts\engine\utility::_id_1BAB(self.pathtravelstarts, var_6);
    var_4[var_4.size] = self._id_AEE4[var_2];
    var_5[var_5.size] = self.pathtravelstarts[var_2];
  }

  self._id_AEE4 = var_4;
  self.pathtravelstarts = var_5;

  foreach(var_2, var_8 in self.pathtravelstarts) {
    var_9 = spawnStruct();
    var_10 = [];
    var_11 = [];
    var_12 = 0;
    var_13 = var_8;

    for(var_10[var_13._id_0481] = 0; isDefined(var_13); var_13 = var_14) {
      if(!isDefined(var_13.target)) {
        break;
      }

      var_14 = scripts\engine\utility::getstruct(var_13.target, "targetname");

      if(!isDefined(var_14)) {
        break;
      }

      if(scripts\engine\utility::array_contains(var_11, var_14)) {
        break;
      }

      var_11 = scripts\engine\utility::array_add(var_11, var_14);
      var_15 = distancesquared(var_13.origin, var_14.origin);
      var_12 = var_12 + var_15;
      var_10[var_14._id_0481] = var_12;
    }

    var_9.totaldistsquared = var_12;
    var_9.pathgraph = var_10;
    self.pathgraphs[var_2] = var_9;
  }

  self.curpath = self._id_AEE4[self.pathstraversed];
  self._id_F4C3 = self.pathtravelstarts[self.pathstraversed];
  var_16 = self.pathgraphs[self.pathstraversed];
}

cleanup_paths() {
  self.pathgraphs = undefined;
  self.currentspawnername = undefined;
  self._id_41CB = undefined;
  self.arezombieswaiting = undefined;
}

init_orb_boundary() {
  var_0 = 55.0;
  var_1 = self._id_AC5B.origin - (0, 0, var_0);
  self._id_2958 = spawn("trigger_radius", var_1, 0, 150, 110);
}

cleanup_orb_boundary() {
  self._id_2958 delete();
}

init_damage_boundary() {
  var_0 = 600.0;
  var_1 = self._id_AC5B.origin - (0, 0, var_0);
  self.damageboundary = spawn("trigger_radius", var_1, 0, 600, 1200);
}

cleanup_damage_boundary() {
  _id_070C::_id_4371(self.damageboundary.name);
  _id_070C::_id_C386(self.damageboundary);
  self.damageboundary delete();
}

start_damage_boundary() {
  _id_070C::_id_0FA1(self.damageboundary);
  _id_070C::_id_0E9F(self.damageboundary.name);
}

_id_A1EB(var_0, var_1) {
  if(isDefined(self.currentorbrate)) {
    if(var_0 > self.currentorbrate) {
      self.currentorbrate = min(self.currentorbrate + 50.0 * var_1, var_0);
    }

    if(var_0 < self.currentorbrate) {
      self.currentorbrate = max(self.currentorbrate - 50.0 * var_1, var_0);
    }

    if(self.currentorbrate == 0) {
      return 0;
    }

    var_2 = self.currentorbrate * var_1;

    if(var_2 > 0) {
      self._id_8939 = 1;
    }

    return _id_A1EC(var_2);
  } else
    return 0;
}

_id_A1EC(var_0) {
  _update_travel_target(var_0);

  if(!isDefined(self._id_F4C3.target) && distancesquared(self._id_F4C3.origin, self._id_AC5B.origin) <= _func_0219(var_0)) {
    var_1 = self._id_F4C3.origin;
  } else {
    var_1 = self._id_AC5B.origin + vectornormalize(self._id_F4C3.origin - self._id_AC5B.origin) * var_0;
  }

  _id_0C6A(var_1);
  var_2 = distancesquared(self._id_F4C3.origin, var_1);
  return var_2;
}

_id_0C6A(var_0) {
  var_1 = self._id_AC5B.origin;
  var_2 = var_0 - var_1;
  self._id_AC5B.origin = var_0;
  level.dome.origin = self._id_AC5B._id_9DE5.origin;
  self._id_2958.origin = self._id_2958.origin + var_2;

  if(isDefined(self.damageboundary) && !_func_0458(self.damageboundary) && isDefined(self.damageboundary.origin)) {
    self.damageboundary.origin = self.damageboundary.origin + var_2;
  }

  var_3 = vectortoangles(var_2);
  var_4 = (0, 0, 0);
  var_5 = _func_0047(var_3, var_4);

  if(!scripts\engine\utility::is_equal(var_5, self._id_AC5B.angles)) {
    var_6 = _func_0317(self._id_AC5B.angles, var_5, 5.0);
    self._id_AC5B.angles = var_6;
  }

  var_7 = _id_09C7::_id_CEE7(self._id_AC5B.origin, 100, 20);
  var_8 = anglesToForward(_func_0047(self._id_AC5B.angles, -1 * var_4));

  foreach(var_10 in var_7) {
    if(!var_10 _meth_8728() || var_10 _id_0722::is_destroyed()) {
      continue;
    }
    if(_func_043B(var_8, var_10.origin - self._id_AC5B.origin, 1) > 0) {
      var_10 _meth_873C("away", self._id_AC5B.origin);
    }
  }

  update_player_spawners(1);
}

_update_travel_target(var_0) {
  self endon("players_dead");
  self endon("objective_ended");
  self endon("orb_follow_complete");

  while(distancesquared(self._id_F4C3.origin, self._id_AC5B.origin) <= _func_0219(var_0)) {
    if(isDefined(self._id_F4C3.target)) {
      self._id_F4C3 = scripts\engine\utility::getstruct(self._id_F4C3.target, "targetname");
      continue;
    }

    break;
  }
}

updateplayernearorb() {
  self.near_payload_time = gettime();

  if(!isDefined(self.last_payload_event_time)) {
    self.last_payload_event_time = gettime();
    thread _id_0752::_id_7003("aether_orb_progress");
  } else if(self.near_payload_time - 2500 > self.last_payload_event_time) {
    self.last_payload_event_time = gettime();
    thread _id_0752::_id_7003("aether_orb_progress");
  }
}

update_player_spawners(var_0) {
  var_1 = self._id_3BE8["player_spawn_cluster"][0];
  var_2 = var_1._id_3BE8["player_spawn_location"];

  if(!isDefined(var_1.orboffset)) {
    var_1.orboffset = self._id_AC5B.origin - var_1.origin;

    foreach(var_4 in var_2) {
      var_4._id_A97D = var_1.origin - var_4.origin;
    }
  }

  if(var_0) {
    var_1.origin = self._id_AC5B.origin;
  } else {
    var_1.origin = self._id_AC5B.origin - var_1.orboffset;
  }

  foreach(var_4 in var_2) {
    var_7 = var_1.origin - var_4._id_A97D;

    if(var_0) {
      var_7 = (var_7[0], var_7[1], self._id_AC5B.origin[2]);
    }

    var_4.origin = var_7;
  }
}

update_zombies_spawning(var_0, var_1) {
  var_2 = get_zombies_spawner_name(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = self.currentspawnername;
  self.currentspawnername = var_2;
  var_4 = !isDefined(var_3) || var_3 != self.currentspawnername;

  if(var_4) {
    level thread _id_0991::_id_E8E2(0);
    waittillframeend;
    self._id_41CB = get_intensity(var_1, get_cluster_intensity_name(var_0));
    var_5 = orb_follow_post_ship_spawner_fixup(var_0._id_039B);

    if(_func_0107(var_5) && var_5.size > 0) {
      level thread _id_0991::_id_C9FC(self._id_41CB, undefined, var_5);
    } else {
      level thread _id_0991::_id_C9FC(self._id_41CB, self.currentspawnername);
    }
  }
}

orb_follow_post_ship_spawner_fixup(var_0) {
  var_1 = [];

  if(scripts\engine\utility::is_equal(self._id_0481, "objective_sumpf_top_orb_follow")) {
    if(scripts\engine\utility::is_equal(var_0, "sumpf_top_orb_follow_spawner_cluster_01") || scripts\engine\utility::is_equal(var_0, "sumpf_top_orb_follow_spawner_cluster_02")) {
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_top_orb_follow_spawner_cluster_01", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_top_orb_follow_spawner_cluster_02", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_top_orb_follow_spawner_cluster_03", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_top_orb_follow_spawner_cluster_04", "targetname");
    }

    if(scripts\engine\utility::is_equal(var_0, "sumpf_top_orb_follow_spawner_cluster_03")) {
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_top_orb_follow_spawner_cluster_03", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_top_orb_follow_spawner_cluster_04", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_top_orb_follow_spawner_cluster_05", "targetname");
    }

    if(scripts\engine\utility::is_equal(var_0, "sumpf_top_orb_follow_spawner_cluster_06") || scripts\engine\utility::is_equal(var_0, "sumpf_top_orb_follow_spawner_cluster_07")) {
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_top_orb_follow_spawner_cluster_03", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_top_orb_follow_spawner_cluster_06", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_top_orb_follow_spawner_cluster_07", "targetname");
    }

    if(scripts\engine\utility::is_equal(var_0, "sumpf_top_orb_follow_spawner_cluster_09") || scripts\engine\utility::is_equal(var_0, "sumpf_top_orb_follow_spawner_cluster_10")) {
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_top_orb_follow_spawner_cluster_03", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_top_orb_follow_spawner_cluster_09", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_top_orb_follow_spawner_cluster_10", "targetname");
    }
  } else if(scripts\engine\utility::is_equal(self._id_0481, "objective_sumpf_orb_follow")) {
    if(scripts\engine\utility::is_equal(var_0, "sumpf_bottom_orb_follow_spawner_cluster_07")) {
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_bottom_orb_follow_spawner_cluster_07", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_bottom_orb_follow_spawner_cluster_08", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_bottom_orb_follow_spawner_cluster_01", "targetname");
    }

    if(scripts\engine\utility::is_equal(var_0, "sumpf_bottom_orb_follow_spawner_cluster_08")) {
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_bottom_orb_follow_spawner_cluster_09", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_bottom_orb_follow_spawner_cluster_08", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_bottom_orb_follow_spawner_cluster_01", "targetname");
    }

    if(scripts\engine\utility::is_equal(var_0, "sumpf_bottom_orb_follow_spawner_cluster_09")) {
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_bottom_orb_follow_spawner_cluster_09", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_bottom_orb_follow_spawner_cluster_10", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("sumpf_bottom_orb_follow_spawner_cluster_01", "targetname");
    }
  } else if(scripts\engine\utility::is_equal(self._id_0481, "objective_royal_hotel_east_orb_follow")) {
    if(scripts\engine\utility::is_equal(var_0, "royal_hotel_east_orb_follow_spawner_cluster_12") || scripts\engine\utility::is_equal(var_0, "royal_hotel_east_orb_follow_spawner_cluster_10")) {
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("royal_hotel_east_orb_follow_spawner_cluster_10", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("royal_hotel_east_orb_follow_spawner_cluster_7", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("royal_hotel_east_orb_follow_spawner_cluster_12", "targetname");
    }

    if(scripts\engine\utility::is_equal(var_0, "royal_hotel_east_orb_follow_spawner_cluster_9")) {
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("royal_hotel_east_orb_follow_spawner_cluster_9", "targetname");
      var_1[var_1.size] = ::scripts\engine\utility::getStructArray("royal_hotel_east_orb_follow_spawner_cluster_7", "targetname");
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  return get_combined_spawner_array(var_1);
}

get_combined_spawner_array(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_1 = scripts\engine\utility::array_combine(var_1, var_3[0]._id_3BE8["spawn_manager_spawner"]);
  }

  return var_1;
}

check_zombie_spawners_wait(var_0) {
  self endon("players_dead");
  self endon("objective_ended");
  self endon("orb_follow_complete");

  if(!isDefined(self.currentspawnername)) {
    return;
  }
  if(!isDefined(self.arezombieswaiting)) {
    self.arezombieswaiting = 0;
  }

  var_1 = get_is_most_players_down();

  if(var_1 && !self.arezombieswaiting && !var_0) {
    self.arezombieswaiting = 1;
    level thread _id_0991::_id_E8E2(0);
    waittillframeend;
    level thread _id_0991::_id_C9FC("cp_zm_zod_orb_follow_travel_intensity_01", self.currentspawnername);
  } else if(self.arezombieswaiting && (!var_1 || var_0)) {
    self.arezombieswaiting = 0;
    level thread _id_0991::_id_E8E2(0);
    waittillframeend;
    level thread _id_0991::_id_C9FC(self._id_41CB, self.currentspawnername);
  }
}

get_is_most_players_down() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(!isalive(var_2) || istrue(var_2.inlaststand)) {
      var_0++;
    }
  }

  if(var_0 * 2 >= level.players.size) {
    return 1;
  }

  return 0;
}

get_cluster_intensity_name(var_0) {
  var_1 = get_zombies_spawner_cluster(var_0);

  if(isDefined(var_1)) {
    if(isDefined(var_1._id_3BE8["cp_zm_zod_orb_follow_travel_intensity_01"])) {
      return "cp_zm_zod_orb_follow_travel_intensity_01";
    }

    if(isDefined(var_1._id_3BE8["cp_zm_zod_orb_follow_travel_intensity_02"])) {
      return "cp_zm_zod_orb_follow_travel_intensity_02";
    }

    if(isDefined(var_1._id_3BE8["cp_zm_zod_orb_follow_travel_intensity_03"])) {
      return "cp_zm_zod_orb_follow_travel_intensity_03";
    }

    if(isDefined(var_1._id_3BE8["cp_zm_zod_orb_follow_travel_intensity_02_simple"])) {
      return "cp_zm_zod_orb_follow_travel_intensity_02_simple";
    }

    if(isDefined(var_1._id_3BE8["cp_zm_zod_orb_follow_travel_intensity_03_simple"])) {
      return "cp_zm_zod_orb_follow_travel_intensity_03_simple";
    }
  }

  return undefined;
}

get_intensity(var_0, var_1) {
  if(isDefined(var_1)) {
    return var_1;
  }

  if(var_0 >= 0.66) {
    return "cp_zm_zod_orb_follow_travel_intensity_03";
  } else if(var_0 >= 0.33) {
    return "cp_zm_zod_orb_follow_travel_intensity_02";
  }

  return "cp_zm_zod_orb_follow_travel_intensity_01";
}

get_zombies_spawner_cluster(var_0) {
  var_1 = var_0._id_039B;

  if(!isDefined(var_1)) {
    return undefined;
  }

  return self._id_3BE8[var_1][0];
}

get_zombies_spawner_name(var_0) {
  var_1 = get_zombies_spawner_cluster(var_0);

  if(!isDefined(var_1)) {
    return undefined;
  }

  var_2 = var_1._id_3BE8["spawn_manager_spawner"];
  return var_2[0]._id_0481;
}

get_spawner_index(var_0) {
  if(var_0 >= 0.66) {
    return 2;
  } else if(var_0 >= 0.33) {
    return 1;
  }

  return 0;
}

_id_10A81() {
  self endon("players_dead");
  self endon("objective_ended");
  var_0 = ["reached_path_end", "orb_follow_complete"];

  for(;;) {
    var_1 = scripts\engine\utility::_id_10892(var_0);
    var_2 = 0;

    switch (var_1) {
      case "reached_path_end":
        self.pathstraversed++;

        if(self.pathstraversed < self._id_AEE4.size) {
          thread _id_249F();
        } else {
          thread mark_objective_complete();
        }

        break;
      case "orb_follow_complete":
        thread set_orb_animation("s4_zm_orb_beam_anim");
        level thread _id_0991::_id_E8E2(1);
        level thread _id_0987::kill_all_objective_zombies();
        wait 1.5;
        level thread _id_0987::set_objective_ui_state(2, 0, 2);
        level thread _id_0987::_id_A871(self, 1);
        wait 1;
        thread cleanup_visuals();
        var_2 = 1;
        break;
      default:
        break;
    }

    if(var_2) {
      break;
    }

    waitframe();
  }
}

complete_objective() {
  level._id_3BE9._id_0F51 notify("orb_follow_complete");
}

_id_661E(var_0) {
  if(var_0 == 0) {
    return 0;
  }

  return 120.0 * (1 + var_0) / 2;
}

mark_objective_complete() {
  waitframe();
  self notify("orb_follow_complete");
}

_id_9B23() {
  self notify("reached_path_end");
  self._id_F4C3 = undefined;
}

_id_63F6(var_0) {
  var_1 = get_closest_path_travel_start_to_point(var_0);

  if(isDefined(var_1)) {
    return var_1.origin;
  } else {
    return self.origin;
  }
}

get_closest_path_travel_start_to_point(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in self.pathtravelstarts) {
    if(!isDefined(var_1) || distancesquared(var_4.origin, var_0) < var_2) {
      var_1 = var_4;
      var_2 = distancesquared(var_4.origin, var_0);
    }
  }

  return var_1;
}

_id_AA6D(var_0) {}

cleanup_visuals() {
  cleanup_orb_boundary();
  cleanup_damage_boundary();
  cleanup_marker();
  _id_385E();
}

_id_385C() {
  cleanup_player_spawners();
  cleanup_paths();
  cleanup_progress();
  level thread scripts\cp\zombies\objective_barriers::toggle_objective_clip(self._id_3BE8["prop"], 0);

  if(isDefined(self._id_EACB) && self._id_EACB) {
    return;
  }
}

get_players_in_range() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(!_func_0458(self._id_2958) && var_2 istouching(self._id_2958) && isalive(var_2) && !istrue(var_2.inlaststand)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

on_player_spawned() {
  if(isDefined(level._id_3BE9) && isDefined(level._id_3BE9._id_0F51) && scripts\engine\utility::is_equal(level._id_3BE9._id_0F51._id_3BE5, "orb_follow")) {
    if(isDefined(level._id_3BE9._id_0F51._id_BD88)) {
      _id_0987::set_objective_ui_bar_progress(level._id_3BE9._id_0F51._id_BD88);
    } else {
      _id_0987::set_objective_ui_bar_progress(0);
    }

    _id_0987::set_objective_ui_state(2, 0, 5);
  }
}