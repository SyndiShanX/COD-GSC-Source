/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\yard\yard_central.gsc
*************************************************/

_id_3BDE() {
  scripts\engine\utility::flag_init("elevator_guards_alerted");
  scripts\engine\utility::flag_init("central_elevator_end");
  scripts\engine\utility::flag_init("elevator_guards_ready");
  scripts\engine\utility::flag_init("central_defend_wave_1_combat_started");
  scripts\engine\utility::flag_init("central_defend_end");
  scripts\engine\utility::flag_init("central_hack_check_done");
  scripts\engine\utility::flag_init("central_hack_hatch_pulled");
  scripts\engine\utility::flag_init("central_hack_hatch_fell");
  scripts\engine\utility::flag_init("central_hack_ethan_end");
  scripts\engine\utility::flag_init("central_light_it_up");
  scripts\engine\utility::flag_init("central_escape_end");
  scripts\engine\utility::flag_init("ramp_magnet_speed_up");
  scripts\engine\utility::flag_init("ethan_turrets_destroyed");
  scripts\engine\utility::flag_init("start_destroying_yard");
  scripts\engine\utility::flag_init("player_near_central_elevator");
  scripts\engine\utility::flag_init("core_piece_destroyed_1");
  scripts\engine\utility::flag_init("core_piece_destroyed_2");
  scripts\engine\utility::flag_init("core_piece_destroyed_3");
  scripts\engine\utility::flag_init("flag_core_magnets_destroyed");
  scripts\engine\utility::flag_init("core_destroyed");
  scripts\engine\utility::flag_init("self_destruct_enabled");
  scripts\engine\utility::flag_init("core_light_stage01");
  scripts\engine\utility::flag_init("core_light_stage02");
  scripts\engine\utility::flag_init("core_light_stage03");
  scripts\engine\utility::flag_init("yard_throw_player_back");
  scripts\engine\utility::flag_init("stolen_destroyer_leave");
  scripts\engine\utility::flag_init("stolen_destroyer_stop_firing");
  scripts\engine\utility::flag_init("final_four");
  scripts\engine\utility::flag_init("yard_stop_spacebattle");
  scripts\engine\utility::flag_init("flag_ethan_start_combat");
  scripts\engine\utility::flag_init("end_scene_player_unlink");
  precacheitem("spaceship_homing_missile_yard");
  scripts\engine\utility::flag_init("remove_enemy_ships");
  scripts\sp\utility::_id_9187("fuse", 2002, ::_id_91A3);
  scripts\sp\utility::_id_9187("main", 2001, ::_id_91A3);
  scripts\sp\utility::_id_9187("pipe_path", 2000, ::_id_91A2);
}

_id_3BE5() {
  var_0 = getEnt("central_salter_capitalship", "targetname");
  var_0._id_EEF9 = "cannon_missile_ca_hardpoint cannon_small_ca,1,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_r_ts_6,amb_turret_sml_r_ts_7,amb_turret_sml_l_ts_6,amb_turret_sml_l_ts_7 cannon_flak_ca,1,1 cannon_phalanx";
  level._id_EAD6 = scripts\sp\vehicle::_id_1080D("central_salter_capitalship");
}

_id_10BDD() {
  scripts\engine\utility::flag_set("yard_start_objectives");
  scripts\engine\utility::flag_set("yard_obj_ambush_done");
  _id_3BE5();
  scripts\sp\maps\yard\yard_audio::_id_25EE("central_elevator", "start");
  scripts\sp\maps\yard\yard_util::_id_107BE("org_salter_ship");
  scripts\sp\maps\yard\yard_util::_id_106D9("org_ethan_hack");
  scripts\sp\maps\yard\yard_junction::_id_119BB();
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("continue_central_elevator_player", "targetname"));
  var_0 = getEnt("spaced_door_clip_player_right", "targetname");
  var_1 = getEnt("spaced_door_clip_player_left", "targetname");
  var_1 notsolid();
  var_0 notsolid();
  scripts\sp\utility::_id_CF8B();
}

_id_B19F() {
  scripts\sp\maps\yard\yard_audio::_id_25EE("central_elevator", "main");
  scripts\sp\maps\yard\yard_fx::_id_132B6(1);
  thread _id_8E71();
  level._id_3BD3 = [];
  level._id_3BD2 = [];
  level._id_3BCF = getEnt("central_control_room_elevator", "targetname");
  level._id_3BD2 = getEntArray("central_elevator_model", "targetname");
  level._id_3BD3 = getEntArray("central_elevator_model_pieces", "targetname");

  if(level._id_3BD3.size > 0) {
    foreach(var_1 in level._id_3BD3) {
      var_1 linkTo(level._id_3BCF);
    }
  }

  foreach(var_4 in level._id_3BD2) {
    var_4 linkTo(level._id_3BCF);
  }

  level._id_3BD1 = getEnt("lift_light", "targetname");
  level._id_3BD1 linkTo(level._id_3BCF);
  var_6 = scripts\engine\utility::getStruct("central_elevator_first_floor_light", "targetname");
  level._id_3BD0 = var_6 scripts\engine\utility::spawn_tag_origin();
  scripts\sp\utility::_id_2669("yard_central_elevator");
  scripts\sp\utility::_id_CF8B();
  thread _id_3BD6();
  thread _id_3BD7();
  thread _id_3BD8();
  thread _id_8E78();
  thread scripts\sp\utility::_id_1264E("yard_central_hallway_tr");
  scripts\engine\utility::flag_wait("central_elevator_end");
}

_id_3B48() {
  scripts\sp\maps\yard\yard_audio::_id_25EE("central_elevator", "catchup");
  level thread _id_0E4B::_id_13485();
}

_id_3BD6() {
  var_0 = getEnt("elevator_go", "targetname");
  var_0 waittill("trigger");
  setmusicstate("mx_257_yard_elevator_finalpush");
  thread _id_4CB8();
  level notify("player_arrived");
  var_1 = scripts\sp\utility::_id_77DF("npc_peek_door");
  var_2 = scripts\sp\utility::_id_22C6(var_1, 1);
  scripts\engine\utility::array_thread(var_2, ::_id_BF02);
  var_3 = scripts\engine\utility::getStruct("central_elevator_first_floor", "targetname");
  level._id_3BCF moveTo(var_3.origin, 0.75, 0, 0.5);
  level notify("elevator_arrived");
  wait 0.75;
  var_4 = getEnt("central_elevator_first_floor_door_left", "targetname");
  var_5 = getEnt("central_elevator_first_floor_door_right", "targetname");
  var_6 = var_4.origin;
  var_7 = var_5.origin;
  var_8 = scripts\engine\utility::getStruct("central_elevator_first_floor_door_left_open", "targetname");
  var_9 = scripts\engine\utility::getStruct("central_elevator_first_floor_door_right_open", "targetname");
  var_4 scripts\engine\utility::delaycall(0.05, ::playsound, "scn_central_lift_door_open");
  var_5 scripts\engine\utility::delaycall(0.15, ::playsound, "scn_central_lift_door_open");
  var_4 moveTo(var_8.origin, 0.5, 0.25, 0.25);
  var_5 moveTo(var_9.origin, 0.5, 0.25, 0.25);
  level._id_3BCF _meth_80AF(undefined);
  wait 2;
  scripts\engine\utility::flag_set("elevator_guards_ready");
  wait 2;
  var_4 scripts\engine\utility::delaycall(0.05, ::playsound, "scn_central_lift_door_close");
  var_5 scripts\engine\utility::delaycall(0.15, ::playsound, "scn_central_lift_door_close");
  var_4 moveTo(var_6, 0.5, 0.25, 0.25);
  var_5 moveTo(var_7, 0.5, 0.25, 0.25);
  thread _id_21B6();
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_127B3("central_control_room_elevator_trig");
  level.player scripts\engine\utility::allow_sprint(0);
  scripts\sp\utility::_id_2669("yard_armory_elevator");
  var_4 scripts\engine\utility::delaycall(0.05, ::playsound, "scn_central_lift_door_close");
  var_5 scripts\engine\utility::delaycall(0.15, ::playsound, "scn_central_lift_door_close");
  var_4 moveTo(var_6, 0.5, 0.25, 0.25);
  var_5 moveTo(var_7, 0.5, 0.25, 0.25);
  var_5 waittill("movedone");
  scripts\sp\utility::_id_28D7("axis");
  level.player scripts\engine\utility::allow_sprint(1);
  scripts\engine\utility::delaythread(10.0, _id_0E4B::_id_13485);
  scripts\engine\utility::delaythread(10.0, _id_0B0B::_id_25C2);
  thread _id_3BDB();
  wait 2;
  scripts\sp\maps\yard\yard_util::_id_40BB("vol_spaced_rss_hanger");
  level notify("player_going_up");
  scripts\sp\maps\yard\yard_fx::_id_132B3(1);
}

_id_3BD7() {
  var_0 = getEnt("central_elevator_first_floor_door_left", "targetname");
  var_1 = getEnt("central_elevator_first_floor_door_right", "targetname");
  var_2 = scripts\engine\utility::getStruct("central_elevator_first_floor_door_left_open", "targetname");
  var_3 = scripts\engine\utility::getStruct("central_elevator_first_floor_door_right_open", "targetname");
  level waittill("player_arrived");
  level notify("lights_off");
  var_4 = getEnt("spaced_combat_vol", "targetname");
  var_5 = var_4 scripts\sp\utility::_id_77E3("axis");
  scripts\sp\utility::_id_13753(var_5);
  level notify("combat_over");
  wait 0.5;
  level.player scripts\sp\utility::_id_1034D("yard_plr_imclearhereetha");
  scripts\sp\utility::_id_10350("yard_eth_goodshootingsir");
  scripts\sp\utility::_id_10350("yard_eth_youllneedtotakethe");
  var_6 = getEnt("elevator_door_clip_player_left", "targetname");
  var_7 = getEnt("elevator_door_clip_player_right", "targetname");
  var_6 linkTo(var_0);
  var_7 linkTo(var_1);
  var_0 scripts\engine\utility::delaycall(0.05, ::playsound, "scn_central_lift_door_open");
  var_1 scripts\engine\utility::delaycall(0.15, ::playsound, "scn_central_lift_door_open");
  var_0 moveTo(var_2.origin, 0.5, 0.25, 0.25);
  var_1 moveTo(var_3.origin, 0.5, 0.25, 0.25);
  level.player scripts\sp\utility::_id_1034D("yard_plr_copy");
  level waittill("player_going_up");
  scripts\sp\utility::_id_10350("yard_eth_youshouldbegoin");
  level.player scripts\sp\utility::_id_1034D("yard_plr_affirmativequit");
  wait 1.75;
  scripts\sp\pip_util::_id_2ADF("yard_hud_salter_pip_02");

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  wait 1;
  scripts\sp\utility::_id_1034D("yard_plr_ethanhostileforces");
  scripts\sp\utility::_id_10350("yard_eth_sirbeadvisedyouve");
  level.player scripts\sp\utility::_id_1034D("yard_plr_rogerthatb");
  scripts\engine\utility::flag_set("yard_obj_locate_command_done");
  scripts\sp\maps\yard\yard_fx::_id_132B6(0);
}

_id_3BD8() {
  level endon("combat_alerted");
  level endon("combat_over");
  level waittill("door_peek_start");
  level.player scripts\sp\utility::_id_1034D("yard_plr_imgoingin");
}

_id_4CB8() {
  level endon("elevator_arrived");
  var_0 = getEnt("elevator_light_01", "targetname");
  var_1 = scripts\engine\utility::getfx("vfx_airlock_light_red");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("vfx_airlock_light_red"), level._id_3BD0, "tag_origin");

    if(isDefined(var_0)) {
      var_0 setlightintensity(10.0);
      var_0 _meth_82FC((1, 0, 0));
    }

    wait 0.5;
    stopFXOnTag(scripts\engine\utility::getfx("vfx_airlock_light_red"), level._id_3BD0, "tag_origin");

    if(isDefined(var_0)) {
      var_0 setlightintensity(0.0);
      var_0 _meth_82FC((1, 0, 0));
    }

    wait 0.5;
  }
}

_id_BF02() {
  self endon("death");
  level endon("combat_alerted");
  scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "elevator_guards_ready");
  self.ignoreall = 1;
  scripts\sp\utility::_id_57D6();
  self.ignoreall = 0;
}

_id_21B6() {
  thread _id_2214();
  var_0 = scripts\sp\utility::_id_22CD("yard_armory_extra", 1);

  foreach(var_2 in var_0) {
    var_2 thread _id_21B5();
    var_2 dontcastdistantshadows();
    var_2 dontcastshadows();
  }

  var_4 = getEntArray("yard_armory_walker", "targetname");

  if(var_4.size) {
    var_5 = scripts\sp\utility::_id_22CD("yard_armory_walker", 1);

    foreach(var_2 in var_5) {
      var_2 thread _id_2260();
    }
  }
}

_id_2260() {
  self endon("death");

  if(isalive(self)) {
    self.ignoreall = 1;
    self.ignoreme = 1;
    scripts\engine\utility::flag_wait("central_defend_wave_1_combat_started");
    self _meth_83A1();
    self delete();
  }
}

_id_2214() {
  var_0 = getEnt("armory_extra_elevator", "targetname");
  var_1 = scripts\engine\utility::getStruct("node_armory_extra_elevator", "targetname");
  var_2 = getEntArray("armory_pieces", "targetname");

  if(var_2.size) {
    foreach(var_4 in var_2) {
      var_4 linkTo(var_0);
    }
  }

  level waittill("player_going_up");
  wait 2;

  if(isDefined(var_1)) {
    var_0 moveTo(var_1.origin, 8, 2, 2);
  }

  scripts\engine\utility::flag_wait("central_defend_wave_1_combat_started");

  if(var_2.size) {
    foreach(var_4 in var_2) {
      var_4 unlink();
      var_4 delete();
    }
  }
}

_id_21B5() {
  self endon("death");
  scripts\engine\utility::waitframe();
  var_0 = scripts\engine\utility::getStruct(self.script_noteworthy, "targetname");
  self.allowdeath = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self._id_1FBB = "generic";
  var_0 thread scripts\sp\anim::_id_1EEA(self, var_0.script_noteworthy);
  scripts\engine\utility::flag_wait("central_defend_wave_1_combat_started");
  self _meth_83A1();
  self delete();
}

_id_3BDB(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0;
  } else {
    var_1 = 27;
  }

  level._id_3BCF _meth_83C9();
  level._id_3BCF.ready = 0;
  var_2 = scripts\engine\utility::getStruct("elevator_1_2", "targetname");
  level._id_3BCF moveTo(var_2.origin, var_1, 3, 3);
  level._id_3BCF thread scripts\sp\maps\yard\yard_audio::_id_2582();
  scripts\sp\utility::_id_127B3("control_room_combat_go");
  scripts\engine\utility::flag_set("central_elevator_end");
  level._id_3BCF waittill("movedone");
  wait 1.5;
  var_3 = getEnt("elevator_1_2_door_left", "targetname");
  var_4 = getEnt("elevator_1_2_door_right", "targetname");
  var_5 = var_3.origin;
  var_6 = var_4.origin;
  var_7 = scripts\engine\utility::getStruct("elevator_1_2_door_left_open", "targetname");
  var_8 = scripts\engine\utility::getStruct("elevator_1_2_door_right_open", "targetname");
  var_9 = getEnt("elevator_1_2_door_left_col", "targetname");
  var_10 = getEnt("elevator_1_2_door_right_col", "targetname");
  var_9 linkTo(var_3);
  var_10 linkTo(var_4);
  var_3 scripts\engine\utility::delaycall(0.05, ::playsound, "scn_central_lift_door_open");
  var_4 scripts\engine\utility::delaycall(0.15, ::playsound, "scn_central_lift_door_open");
  var_3 moveTo(var_7.origin, 0.5, 0.25, 0.25);
  var_4 moveTo(var_8.origin, 0.5, 0.25, 0.25);
  var_4 waittill("movedone");
  scripts\sp\utility::_id_127B3("central_elevator_close_second_floor");
  var_3 scripts\engine\utility::delaycall(0.05, ::playsound, "scn_central_lift_door_close");
  var_4 scripts\engine\utility::delaycall(0.15, ::playsound, "scn_central_lift_door_close");
  var_3 moveTo(var_5, 0.5, 0.25, 0.25);
  var_4 moveTo(var_6, 0.5, 0.25, 0.25);
  level.closet_runner_ignore_manager._id_C4FC solid();
  level.closet_runner_ignore_manager._id_12ACE solid();
  var_11 = getEnt("lift_light", "targetname");

  if(isDefined(var_11)) {
    var_11 delete();
  }

  var_2 = scripts\engine\utility::getStruct("elevator_1_start", "targetname");
  level._id_3BCF moveTo(var_2.origin, 2, 1, 1);
  wait 2.5;
  level._id_3BCF.ready = 1;
}

_id_10BDC() {
  scripts\engine\utility::flag_set("yard_start_objectives");
  scripts\engine\utility::flag_set("yard_obj_ambush_done");
  scripts\engine\utility::flag_set("yard_obj_locate_command_done");
  _id_3BE5();
  scripts\sp\maps\yard\yard_audio::_id_25EE("central_defend", "start");
  scripts\sp\maps\yard\yard_util::_id_106D9("org_ethan_hack");
  scripts\sp\maps\yard\yard_util::_id_107BE("org_salter_ship");
  thread _id_8E71();
  level.closet_runner_ignore_manager = getEnt("central_control_room_elevator", "targetname");
  var_0 = scripts\engine\utility::getStruct("elevator_1_start", "targetname");
  level.closet_runner_ignore_manager moveTo(var_0.origin, 0.05);
  level.closet_runner_ignore_manager.ready = 1;
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("central_defend_startpoint", "targetname"));
  thread _id_8E78();
  scripts\sp\utility::_id_CF8B();
  var_1 = getEnt("lift_light", "targetname");

  if(isDefined(var_1)) {
    var_1 delete();
  }
}

_id_B19E() {
  scripts\sp\utility::_id_2669("yard_central_defend");
  scripts\sp\maps\yard\yard_audio::_id_25EE("central_defend", "main");
  _id_3BC8();
  _id_3BC2();
  thread _id_3BBF();
  thread _id_3BBD();
  thread _id_3BCA();
  thread scripts\sp\utility::_id_1264E("yard_central_hub_tr");
  scripts\engine\utility::flag_wait("central_defend_end");
}

_id_8E71() {
  var_0 = getEnt("command_window_broken", "targetname");
  var_0 hide();
  var_1 = getEntArray("barriers_destroyed_01", "targetname");
  var_2 = getEntArray("barriers_clean_01", "targetname");
  var_3 = getEntArray("command_window_cracks", "targetname");

  foreach(var_5 in var_1) {
    var_5 hide();
  }

  foreach(var_5 in var_2) {
    var_5 show();
  }

  foreach(var_10 in var_3) {
    var_10 hide();
  }
}

_id_3BCA() {
  var_0 = getEnt("trig_central_color_1", "targetname");
  var_1 = getEnt("trig_central_color_2", "targetname");
  var_2 = getEnt("trig_central_color_3", "targetname");
  var_3 = getEnt("trig_central_color_4", "targetname");
  var_4 = getEnt("trig_central_color_5", "targetname");
  var_0 thread _id_3BCB(var_1, var_2, var_3, var_4);
  var_1 thread _id_3BCB(var_0, var_2, var_3, var_4);
  var_2 thread _id_3BCB(var_1, var_0, var_3, var_4);
  var_3 thread _id_3BCB(var_1, var_2, var_0, var_4);
  var_4 thread _id_3BCB(var_1, var_2, var_3, var_0);
  scripts\engine\utility::flag_wait("final_four");
  var_0 scripts\engine\utility::trigger_off();
  var_1 scripts\engine\utility::trigger_off();
  var_2 scripts\engine\utility::trigger_off();
  var_3 scripts\engine\utility::trigger_off();
  var_4 scripts\engine\utility::trigger_off();
  var_5 = getaiarray("axis");

  foreach(var_7 in var_5) {
    var_7.ignoresuppression = 1;
    var_7.goalradius = 16;
  }

  scripts\sp\utility::_id_15F5("trig_final_four");
}

_id_3BCB(var_0, var_1, var_2, var_3) {
  level endon("final_four");

  for(;;) {
    self waittill("trigger", var_4);

    if(!isalive(var_4)) {
      continue;
    }
    scripts\engine\utility::trigger_off();
    var_0 scripts\engine\utility::trigger_on();
    var_1 scripts\engine\utility::trigger_on();
    var_2 scripts\engine\utility::trigger_on();
    var_3 scripts\engine\utility::trigger_on();
  }
}

_id_3BC6() {
  var_0 = getEnt("trig_central_color_1", "targetname");
  var_1 = getEnt("trig_central_color_2", "targetname");
  var_2 = getEnt("trig_central_color_3", "targetname");
  var_3 = getEnt("trig_central_color_4", "targetname");
  var_4 = getEnt("trig_central_color_5", "targetname");
  var_0 scripts\engine\utility::trigger_on();
  var_1 scripts\engine\utility::trigger_on();
  var_2 scripts\engine\utility::trigger_on();
  var_3 scripts\engine\utility::trigger_on();
  var_4 scripts\engine\utility::trigger_on();
}

_id_3B47() {
  scripts\sp\maps\yard\yard_audio::_id_25EE("central_defend", "catchup");
}

_id_3BC8() {
  level.closestenemies_array = spawnStruct();
  level.closestenemies_array.ready = 1;
  level.closestenemies_array.type = "door";
  level.closestenemies_array.trigger = getEnt("closet_1_trigger", "targetname");
  level.closestenemies_array.clip = getEnt("closet_1_clip", "targetname");
  level.closestenemies_array.clip disconnectPaths();
  level.closestenemies_array.spawners = scripts\engine\utility::getStructArray("closet_1_spawn", "targetname");
  level.closestenemies_array._id_59A7 = getEnt("closet_1_door_left", "targetname");
  level.closestenemies_array._id_59A7 hidepart("tag_screen_open");
  level.closestenemies_array._id_59A7 hidepart("tag_screen_restricted");
  level.closestenemies_array._id_59A7 showpart("tag_screen_locked");
  level.closestenemies_array._id_59E3 = getEnt("closet_1_door_right", "targetname");
  level.closestenemies_array._id_59A9 = level.closestenemies_array._id_59A7.origin;
  level.closestenemies_array._id_59E5 = level.closestenemies_array._id_59E3.origin;
  level.closestenemies_array._id_59A8 = (level.closestenemies_array._id_59A7.origin[0] + 54, level.closestenemies_array._id_59A7.origin[1], level.closestenemies_array._id_59A7.origin[2]);
  level.closestenemies_array._id_59E4 = (level.closestenemies_array._id_59E3.origin[0] - 54, level.closestenemies_array._id_59E3.origin[1], level.closestenemies_array._id_59E3.origin[2]);
  level.closestenemies_array.origin = level.closestenemies_array._id_59A7.origin;
  level.closestpoint = spawnStruct();
  level.closestpoint.ready = 1;
  level.closestpoint.type = "door";
  level.closestpoint.trigger = getEnt("closet_2_trigger", "targetname");
  level.closestpoint.clip = getEnt("closet_2_clip", "targetname");
  level.closestpoint.clip disconnectPaths();
  level.closestpoint.spawners = scripts\engine\utility::getStructArray("closet_2_spawn", "targetname");
  level.closestpoint._id_59A7 = getEnt("closet_2_door_left", "targetname");
  level.closestpoint._id_59A7 hidepart("tag_screen_open");
  level.closestpoint._id_59A7 hidepart("tag_screen_restricted");
  level.closestpoint._id_59A7 showpart("tag_screen_locked");
  level.closestpoint._id_59E3 = getEnt("closet_2_door_right", "targetname");
  level.closestpoint._id_59A9 = level.closestpoint._id_59A7.origin;
  level.closestpoint._id_59E5 = level.closestpoint._id_59E3.origin;
  level.closestpoint._id_59A8 = (level.closestpoint._id_59A7.origin[0], level.closestpoint._id_59A7.origin[1] - 54, level.closestpoint._id_59A7.origin[2]);
  level.closestpoint._id_59E4 = (level.closestpoint._id_59E3.origin[0], level.closestpoint._id_59E3.origin[1] + 54, level.closestpoint._id_59E3.origin[2]);
  level.closestpoint.origin = level.closestpoint._id_59A7.origin;
  level.closestpointtowall = spawnStruct();
  level.closestpointtowall.ready = 1;
  level.closestpointtowall.type = "door";
  level.closestpointtowall.trigger = getEnt("closet_3_trigger", "targetname");
  level.closestpointtowall.clip = getEnt("closet_3_clip", "targetname");
  level.closestpointtowall.clip disconnectPaths();
  level.closestpointtowall.spawners = scripts\engine\utility::getStructArray("closet_3_spawn", "targetname");
  level.closestpointtowall._id_59A7 = getEnt("closet_3_door_left", "targetname");
  level.closestpointtowall._id_59A7 hidepart("tag_screen_open");
  level.closestpointtowall._id_59A7 hidepart("tag_screen_restricted");
  level.closestpointtowall._id_59A7 showpart("tag_screen_locked");
  level.closestpointtowall._id_59E3 = getEnt("closet_3_door_right", "targetname");
  level.closestpointtowall._id_59A9 = level.closestpointtowall._id_59A7.origin;
  level.closestpointtowall._id_59E5 = level.closestpointtowall._id_59E3.origin;
  level.closestpointtowall._id_59A8 = (level.closestpointtowall._id_59A7.origin[0] - 54, level.closestpointtowall._id_59A7.origin[1], level.closestpointtowall._id_59A7.origin[2]);
  level.closestpointtowall._id_59E4 = (level.closestpointtowall._id_59E3.origin[0] + 54, level.closestpointtowall._id_59E3.origin[1], level.closestpointtowall._id_59E3.origin[2]);
  level.closestpointtowall.origin = level.closestpointtowall._id_59A7.origin;
  level.closet_runner_ignore_manager = spawnStruct();
  level.closet_runner_ignore_manager.type = "elevator";
  level.closet_runner_ignore_manager._id_3673 = getEnt("central_control_room_elevator", "targetname");

  if(!isDefined(level.closet_runner_ignore_manager._id_3673.ready) || !level.closet_runner_ignore_manager._id_3673.ready) {
    level.closet_runner_ignore_manager.ready = 0;
  } else {
    level.closet_runner_ignore_manager.ready = 1;
  }

  level.closet_runner_ignore_manager.spawners = [];
  var_0 = scripts\engine\utility::getStructArray("elevator_1_spawn", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
    level.closet_runner_ignore_manager.spawners = scripts\engine\utility::array_add(level.closet_runner_ignore_manager.spawners, var_3);
    var_3 linkTo(level.closet_runner_ignore_manager._id_3673);
  }

  level.closet_runner_ignore_manager._id_C509 = getEnt("elevator_1_1_trigger", "targetname");
  level.closet_runner_ignore_manager._id_C4FD = getEnt("elevator_1_1_door_left", "targetname");
  level.closet_runner_ignore_manager._id_C501 = getEnt("elevator_1_1_door_right", "targetname");
  level.closet_runner_ignore_manager._id_C500 = level.closet_runner_ignore_manager._id_C4FD.origin;
  level.closet_runner_ignore_manager._id_C504 = level.closet_runner_ignore_manager._id_C501.origin;
  var_5 = scripts\engine\utility::getStruct("elevator_1_1_door_left_open", "targetname");
  level.closet_runner_ignore_manager._id_C4FF = var_5.origin;
  var_5 = scripts\engine\utility::getStruct("elevator_1_1_door_right_open", "targetname");
  level.closet_runner_ignore_manager._id_C503 = var_5.origin;
  level.closet_runner_ignore_manager._id_C4FE = getEnt("elevator_1_1_door_left_col", "targetname");
  level.closet_runner_ignore_manager._id_C502 = getEnt("elevator_1_1_door_right_col", "targetname");
  level.closet_runner_ignore_manager._id_C4FC = getEnt("elevator_1_1_clip", "targetname");
  level.closet_runner_ignore_manager._id_C4FC notsolid();
  level.closet_runner_ignore_manager._id_C4FE linkTo(level.closet_runner_ignore_manager._id_C4FD);
  level.closet_runner_ignore_manager._id_C502 linkTo(level.closet_runner_ignore_manager._id_C501);
  level.closet_runner_ignore_manager._id_12ADC = getEnt("elevator_1_2_trigger", "targetname");
  level.closet_runner_ignore_manager._id_12AD0 = getEnt("elevator_1_2_door_left", "targetname");
  level.closet_runner_ignore_manager._id_12AD4 = getEnt("elevator_1_2_door_right", "targetname");
  level.closet_runner_ignore_manager._id_12AD3 = level.closet_runner_ignore_manager._id_12AD0.origin;
  level.closet_runner_ignore_manager._id_12AD7 = level.closet_runner_ignore_manager._id_12AD4.origin;
  var_5 = scripts\engine\utility::getStruct("elevator_1_2_door_left_open", "targetname");
  level.closet_runner_ignore_manager._id_12AD2 = var_5.origin;
  var_5 = scripts\engine\utility::getStruct("elevator_1_2_door_right_open", "targetname");
  level.closet_runner_ignore_manager._id_12AD6 = var_5.origin;
  level.closet_runner_ignore_manager._id_12AD1 = getEnt("elevator_1_2_door_left_col", "targetname");
  level.closet_runner_ignore_manager._id_12AD5 = getEnt("elevator_1_2_door_right_col", "targetname");
  level.closet_runner_ignore_manager._id_12ACE = getEnt("elevator_1_2_clip", "targetname");
  level.closet_runner_ignore_manager._id_12ACE notsolid();
  level.closet_runner_ignore_manager._id_12AD1 linkTo(level.closet_runner_ignore_manager._id_12AD0);
  level.closet_runner_ignore_manager._id_12AD5 linkTo(level.closet_runner_ignore_manager._id_12AD4);
  var_5 = scripts\engine\utility::getStruct("elevator_1_start", "targetname");
  level.closet_runner_ignore_manager.start = var_5.origin;
  var_5 = scripts\engine\utility::getStruct("elevator_1_1", "targetname");
  level.closet_runner_ignore_manager._id_C508 = var_5.origin;
  var_5 = scripts\engine\utility::getStruct("elevator_1_2", "targetname");
  level.closet_runner_ignore_manager._id_12ADB = var_5.origin;
  level.closet_runner_ignore_manager.origin = level.closet_runner_ignore_manager._id_12ADB;
  level.closetacopsmap = spawnStruct();
  level.closetacopsmap.type = "elevator";
  level.closetacopsmap._id_3673 = getEnt("elevator_2", "targetname");
  level.closetacopsmap.ready = 1;
  level.closetacopsmap.spawners = [];
  var_0 = scripts\engine\utility::getStructArray("elevator_2_spawn", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
    level.closetacopsmap.spawners = scripts\engine\utility::array_add(level.closetacopsmap.spawners, var_3);
    var_3 linkTo(level.closetacopsmap._id_3673);
  }

  level.closetacopsmap._id_C509 = getEnt("elevator_2_1_trigger", "targetname");
  level.closetacopsmap._id_C4FD = getEnt("elevator_2_1_door_left", "targetname");
  level.closetacopsmap._id_C501 = getEnt("elevator_2_1_door_right", "targetname");
  level.closetacopsmap._id_C500 = level.closetacopsmap._id_C4FD.origin;
  level.closetacopsmap._id_C504 = level.closetacopsmap._id_C501.origin;
  var_5 = scripts\engine\utility::getStruct("elevator_2_1_door_left_open", "targetname");
  level.closetacopsmap._id_C4FF = var_5.origin;
  var_5 = scripts\engine\utility::getStruct("elevator_2_1_door_right_open", "targetname");
  level.closetacopsmap._id_C503 = var_5.origin;
  level.closetacopsmap._id_12ADC = getEnt("elevator_2_2_trigger", "targetname");
  level.closetacopsmap._id_12AD0 = getEnt("elevator_2_2_door_left", "targetname");
  level.closetacopsmap._id_12AD4 = getEnt("elevator_2_2_door_right", "targetname");
  level.closetacopsmap._id_12AD3 = level.closetacopsmap._id_12AD0.origin;
  level.closetacopsmap._id_12AD7 = level.closetacopsmap._id_12AD4.origin;
  var_5 = scripts\engine\utility::getStruct("elevator_2_2_door_left_open", "targetname");
  level.closetacopsmap._id_12AD2 = var_5.origin;
  var_5 = scripts\engine\utility::getStruct("elevator_2_2_door_right_open", "targetname");
  level.closetacopsmap._id_12AD6 = var_5.origin;
  var_5 = scripts\engine\utility::getStruct("elevator_2_start", "targetname");
  level.closetacopsmap.start = var_5.origin;
  var_5 = scripts\engine\utility::getStruct("elevator_2_1", "targetname");
  level.closetacopsmap._id_C508 = var_5.origin;
  var_5 = scripts\engine\utility::getStruct("elevator_2_2", "targetname");
  level.closetacopsmap._id_12ADB = var_5.origin;
  level.closetacopsmap.origin = level.closetacopsmap._id_12ADB;
  level._id_42AD = [level.closestenemies_array, level.closestpoint, level.closestpointtowall];
  level._id_C192 = [];
  level._id_C199["npc_setup_shotgunner"] = ::_id_C19A;
}

_id_C19A() {
  scripts\sp\utility::_id_F3D5(level.player);
}

_id_3BC2() {
  level._id_C193 = scripts\sp\utility::_id_22CD("npc_control_wave_1", 1);
  scripts\engine\utility::array_thread(level._id_C193, ::_id_3BCD);
  level._id_C192 = scripts\engine\utility::array_combine(level._id_C192, level._id_C193);
  scripts\sp\utility::_id_16E5("axis", ::_id_DE32);
}

_id_DE32() {
  self.accuracy = self.accuracy * 0.85;
  self._id_2894 = self._id_2894 * 0.85;
}

_id_3BCD() {
  self._id_1FBB = "generic";
  self.accuracy = self.accuracy * 0.8;
  self._id_2894 = self._id_2894 * 0.8;

  if(scripts\engine\utility::string_starts_with(self.classname, "actor_enemy_c6")) {
    self._id_1FEC = "c6";
    thread scripts\sp\anim::_id_1EEA(self, "c6_idle_console");
    thread _id_3BCC();
  }

  if(issubstr(self.classname, "sdf")) {
    thread scripts\sp\anim::_id_1EEA(self, "idle_console");
    thread _id_3BCC();
  }
}

_id_1093C() {
  var_0 = level.player getweaponslistall();

  foreach(var_2 in var_0) {
    if(var_2 == "hackingdevice") {
      thread _id_1093B();
      return;
    }
  }

  return;
}

_id_1093B() {
  var_0 = getEnt("command_special_c6_hack", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1._id_1FBB = "generic";

  if(scripts\engine\utility::string_starts_with(var_1.classname, "actor_enemy_c6")) {
    var_1._id_1FEC = "c6";
    var_1 thread scripts\sp\anim::_id_1EEA(var_1, "c6_idle_console");
  } else
    var_1 thread scripts\sp\anim::_id_1EEA(var_1, "idle_console");

  var_1 thread _id_3BCC();
  scripts\sp\utility::_id_127B3("control_room_combat_go");
  wait 9.5;
  scripts\sp\maps\yard\yard_util::_id_11685("Ethan", "Sir, I'd suggesting hacking that guy");
}

_id_3BCC() {
  self endon("death");
  scripts\engine\utility::flag_wait("central_defend_wave_1_combat_started");
  self notify("stop_loop");
  self _meth_83A1();
  self.goalradius = 16;
}

_id_3BBF() {
  scripts\engine\utility::flag_wait("central_defend_wave_1_combat_started");
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_CF8B();

  foreach(var_1 in level._id_C192) {
    var_1 notify("central_defend_wave_1_combat_started");
  }

  _id_6435(5);
  _id_4424();
  scripts\sp\utility::_id_2669("central_hack_defend_wave_3");
  _id_4425();
  _id_4426();
  var_3 = getEnt("zone_center", "targetname");
  var_4 = scripts\sp\utility::_id_7A9E("script_noteworthy", "command_human");

  foreach(var_6 in var_4) {
    var_6 scripts\sp\utility::_id_54F7();
    var_6.ignoresuppression = 1;
    var_6 _meth_82F1(var_3);
  }

  level notify("final_four");
  scripts\engine\utility::flag_set("final_four");
  scripts\engine\utility::flag_set("ethan_turrets_destroyed");
  _id_6435(0);
  var_4 = getaiarray("axis");

  if(var_4.size) {
    foreach(var_6 in var_4) {
      var_6 _meth_81D0();
    }
  }

  scripts\engine\utility::flag_set("central_defend_end");
  scripts\sp\utility::_id_28D7("axis");
}

_id_4424() {
  var_0 = _id_3BC3("npc_control_wave_2");
  _id_6435(4);
}

_id_4425() {
  var_0 = getEnt("c6_rss_spawner", "targetname");
  var_0 scripts\sp\utility::_id_E08B(scripts\sp\maps\yard\yard_elevator::_id_3356);
  var_0 scripts\sp\utility::_id_E08B(scripts\sp\maps\yard\yard_elevator::_id_602D);
  var_0 scripts\sp\utility::_id_F3B7("g");
  var_0._id_EECE = 0;
  var_1 = _id_0B6C::_id_FA2A("vol_rss_command_00");
  var_1 _id_0B6C::_id_8953();
  var_2 = _id_3BC3("npc_control_wave_3");
  _id_6435(4);
}

_id_4426() {
  var_0 = _id_0B6C::_id_FA2A("vol_rss_command_01");
  var_0 _id_0B6C::_id_8953();
  _id_6435(4);
}

_id_6435(var_0) {
  var_1 = getEnt("zone_all", "targetname");
  var_2 = var_1 scripts\sp\utility::_id_77E3("axis");

  while(var_2.size > var_0) {
    var_2 = var_1 scripts\sp\utility::_id_77E3("axis");
    scripts\engine\utility::waitframe();
  }
}

_id_679D() {
  scripts\sp\maps\yard\yard_util::_id_11685("Ethan", "Sir, I've hacked into the room's security, I'll support with the turrets", 3);
  var_0 = getEntArray("ethan_turret", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_679C();
  }
}

_id_679C() {
  var_0 = self;

  if(isDefined(var_0) && isDefined(var_0.target)) {
    var_1 = getEnt(var_0.target, "targetname");
  } else {
    return;
  }

  if(isDefined(var_1) && isDefined(var_1.target)) {
    var_2 = getEnt(var_1.target, "targetname");
  } else {
    return;
  }

  var_3 = self.angles;
  var_1 linkTo(var_0);
  var_4 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  self._id_2830 = var_4;
  var_4 linkTo(var_1);
  var_5 = 1;
  var_6 = 2;
  var_7 = 1;
  wait 2;

  while(!scripts\engine\utility::flag("central_defend_end") && !scripts\engine\utility::flag("ethan_turrets_destroyed")) {
    if(getaicount("axis", "all") > 0) {
      var_8 = scripts\engine\utility::random(getaiarray("axis"));
      var_8 thread _id_DD32(var_1);
      var_9 = vectortoangles(var_8.origin - var_1.origin);
      var_0 rotateTo(var_9, var_7);
      wait(var_7);

      while(isalive(var_8)) {
        var_10 = 12;
        var_11 = var_8.origin + (0, 0, 32);

        for(var_12 = 0; var_12 < var_10; var_12++) {
          magicbullet("iw7_sdflmg", var_4.origin, var_11);

          if(var_10 % 3 == 0) {
            bullettracer(var_4.origin, var_11, "iw7_sdflmg", 1);
            var_4 playSound("dropship_weap_noseturret_fire_npc");
          }

          playFXOnTag(level._effect["turret_muzzle"], var_4, "tag_origin");
          scripts\engine\utility::waitframe();
        }

        wait(randomfloatrange(var_5, var_6));
      }

      wait 1.5;
    }
  }

  _id_679B(var_3);
}

_id_679B(var_0) {
  playFX(level._effect["ethan_turret_death"], self.origin);
  self rotateTo(var_0, 1.5);
}

_id_DD32(var_0) {
  self endon("death");

  while(isalive(self) && !scripts\engine\utility::flag("central_defend_end") && !scripts\engine\utility::flag("ethan_turrets_destroyed")) {
    self _meth_82DE(var_0, 1);
    self shoot(1, var_0.origin, 1);
    wait 0.75;
  }
}

_id_3BC0() {
  while(getaicount("axis", "all") > 4) {
    wait 0.5;
  }

  level notify("final_four");
  scripts\engine\utility::flag_set("final_four");
}

_id_3BC3(var_0) {
  _id_3BC6();
  var_1 = getEntArray(var_0, "targetname");
  var_2 = [];

  while(var_1.size > 0) {
    var_3 = _id_3BC4();
    var_3.ready = 0;
    var_4 = [];

    for(var_5 = 0; var_5 < var_3.spawners.size; var_5++) {
      var_4 = scripts\engine\utility::array_add(var_4, var_1[0]);
      var_1 = scripts\engine\utility::array_remove(var_1, var_1[0]);

      if(var_1.size <= 0) {
        break;
      }
    }

    var_6 = thread _id_3BC5(var_4, var_3);
    var_2 = scripts\engine\utility::array_add(var_2, var_6);
    wait 0.1;
  }

  return var_2;
}

_id_3BC5(var_0, var_1) {
  var_2 = scripts\sp\utility::_id_22C6(var_0, 1);
  level._id_C192 = scripts\engine\utility::array_combine(level._id_C192, var_2);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] closetargetsinouterradius(var_1.spawners[var_3]);

    if(issubstr(var_2[var_3].classname, "c8")) {
      var_2[var_3] setgoalentity(level.player);
      var_2[var_3] scripts\sp\utility::_id_F3DD(128);
      var_2[var_3].ignoresuppression = 1;
    }

    if(isDefined(var_2[var_3].script_noteworthy)) {
      var_2[var_3] thread[[level._id_C199[var_2[var_3].script_noteworthy]]]();
    }
  }

  switch (var_1.type) {
    case "door":
      var_1._id_59A7 thread scripts\sp\utility::play_sound_on_entity("generic_door_open");
      var_1._id_59A7 moveTo(var_1._id_59A8, 0.5, 0.25, 0.25);
      var_1._id_59E3 moveTo(var_1._id_59E4, 0.5, 0.25, 0.25);
      wait 0.5;
      var_1.clip notsolid();
      var_1.clip connectpaths();
      var_4 = 0;

      while(!var_4) {
        var_5 = var_1.trigger scripts\sp\utility::_id_77E3("axis", "all");

        if(var_5.size == 0) {
          var_4 = 1;
        }

        wait 0.05;
      }

      var_1._id_59A7 thread scripts\sp\utility::play_sound_on_entity("generic_door_close");
      var_1._id_59A7 moveTo(var_1._id_59A9, 0.5, 0.25, 0.25);
      var_1._id_59E3 moveTo(var_1._id_59E5, 0.5, 0.25, 0.25);
      wait 0.5;
      var_1.clip solid();
      var_1.clip disconnectPaths();
      var_1.ready = 1;
      break;
    case "elevator":
      if(level.player.origin[2] > var_1._id_C508[2] + 128) {
        var_6 = var_1._id_12AD0;
        var_7 = var_1._id_12AD4;
        var_8 = var_1._id_12AD2;
        var_9 = var_1._id_12AD6;
        var_10 = var_1._id_12AD3;
        var_11 = var_1._id_12AD7;
        var_12 = var_1._id_12ADB;
        var_13 = var_1._id_12ADC;
      } else {
        var_6 = var_1._id_C4FD;
        var_7 = var_1._id_C501;
        var_8 = var_1._id_C4FF;
        var_9 = var_1._id_C503;
        var_10 = var_1._id_C500;
        var_11 = var_1._id_C504;
        var_12 = var_1._id_C508;
        var_13 = var_1._id_C509;
      }

      var_1._id_3673 moveTo(var_12, 2, 1, 1);
      var_1._id_3673 waittill("movedone");
      var_6 moveTo(var_8, 0.5, 0.25, 0.25);
      var_7 moveTo(var_9, 0.5, 0.25, 0.25);
      wait 0.5;
      var_1._id_3673 _meth_80AF();
      var_4 = 0;

      while(!var_4) {
        var_5 = var_1 scripts\sp\utility::_id_77E3("axis", "all");

        if(var_5.size == 0) {
          var_4 = 1;
        }

        wait 0.05;
      }

      var_1._id_3673 _meth_83C9();
      var_6 moveTo(var_10, 0.5, 0.25, 0.25);
      var_7 moveTo(var_11, 0.5, 0.25, 0.25);
      wait 0.5;
      var_1._id_3673 moveTo(var_1.start, 2, 1, 1);
      var_1._id_3673 waittill("movedone");
      var_1.ready = 1;
      break;
  }

  return var_2;
}

closetargetsinouterradius(var_0) {
  if(isnode(var_0)) {
    scripts\sp\utility::_id_1160F(var_0);
    return;
  } else if(isent(var_0)) {
    scripts\sp\utility::_id_11624(var_0);
    return;
  } else if(isstruct(var_0)) {
    scripts\sp\utility::_id_11624(var_0);
    return;
  }

  var_1 = undefined;
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(isDefined(var_1)) {
    self _meth_80F1(var_1.origin, var_1.angles);
    return;
  }

  var_1 = getnode(var_0, "targetname");

  if(isDefined(var_1)) {
    scripts\sp\utility::_id_1160F(var_1);
    return;
  }

  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1)) {
    scripts\sp\utility::_id_11624(var_1);
  }
}

_id_3BC4() {
  var_0 = undefined;
  var_1 = 0;

  while(!isDefined(var_0)) {
    foreach(var_3 in level._id_42AD) {
      if(var_3.ready) {
        var_4 = distance(level.player.origin, var_3.origin);

        if(var_4 > var_1) {
          var_0 = var_3;
          var_1 = var_4;
        }
      }
    }

    if(isDefined(var_0)) {
      return var_0;
    }

    wait 0.5;
  }
}

_id_3BBD() {
  var_0 = 15;
  var_1 = 30;
  wait 1;
  thread _id_441F();
}

_id_3BB9(var_0) {
  scripts\sp\utility::_id_15F5(var_0);
}

_id_4420() {
  thread _id_4422();
  thread _id_441F();
  thread _id_441E();
}

_id_4422() {
  var_0 = getEntArray("test_turret_node", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_4421();
  }
}

_id_441F() {
  var_0 = 8.5;
  var_1 = 12.5;

  while(!scripts\engine\utility::flag("yard_stop_spacebattle")) {
    _id_441C(1);
    wait(randomfloatrange(var_0, var_1));
  }
}

_id_441C(var_0) {
  var_1 = getEntArray("command_space_jackal_amb", "targetname");
  var_2 = scripts\engine\utility::random(var_1);
  var_3 = var_2 scripts\sp\utility::_id_10808();
  var_3 thread _id_0BDC::_id_A373(var_2.target);
  wait(var_0);
  var_2 = scripts\engine\utility::random(var_1);
  var_3 = var_2 scripts\sp\utility::_id_10808();
  var_3 thread _id_0BDC::_id_A373(var_2.target);
}

_id_4421() {
  var_0 = 0.5;
  var_1 = 1.5;
  var_2 = scripts\engine\utility::getStructArray(self.target, "targetname");

  while(!scripts\engine\utility::flag("yard_stop_spacebattle")) {
    var_3 = scripts\engine\utility::random(var_2);
    self.angles = vectortoangles(self.origin - var_3.origin);
    playFX(level._effect["fake_turret_small"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    playFX(level._effect["fake_flack"], self.origin);
    wait(randomfloatrange(var_0, var_1));
  }
}

_id_441E() {
  var_0 = 3.5;
  var_1 = 8.5;
  var_2 = scripts\engine\utility::getStructArray("spacebattle_explosion", "targetname");

  while(!scripts\engine\utility::flag("yard_stop_spacebattle")) {
    var_3 = scripts\engine\utility::random(var_2);
    playFX(level._effect["vfx_jackal_death_01_zerog"], var_3.origin);
    wait(randomfloatrange(var_0, var_1));
  }
}

_id_10BDF() {
  scripts\engine\utility::flag_set("yard_start_objectives");
  scripts\engine\utility::flag_set("yard_obj_ambush_done");
  scripts\engine\utility::flag_set("yard_obj_locate_command_done");
  _id_3BE5();
  scripts\sp\maps\yard\yard_audio::_id_25EE("central_hack_ethan", "start");
  scripts\sp\maps\yard\yard_util::_id_106D9("org_ethan_hack");
  scripts\sp\maps\yard\yard_util::_id_107BE("org_salter_ship");
  thread _id_8E71();
  level.player scripts\sp\utility::_id_1145A("hackingdevice");
  thread _id_8E78();
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("continue_central_hack_ethan_player", "targetname"));
  scripts\sp\utility::_id_CF8B();
  var_0 = getEnt("lift_light", "targetname");

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_B1A1() {
  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  scripts\sp\utility::_id_2669("central_hack_ethan");
  scripts\sp\maps\yard\yard_audio::_id_25EE("central_hack_ethan", "main");
  var_0 = scripts\engine\utility::getStruct("org_ethan_hack", "targetname");

  if(!isDefined(level._id_6754)) {
    scripts\sp\maps\yard\yard_util::_id_106D9("org_ethan_hack");
  } else {
    if(isDefined(level._id_6037)) {
      level._id_6754 unlink();
      level._id_6037 notify("elevator_end_idle");
      level._id_6754 scripts\sp\utility::anim_stopanimScripted();
      scripts\engine\utility::waitframe();
    }

    level._id_6754 dontinterpolate();
    level._id_6754 _meth_80F1(var_0.origin, var_0.angles, 500000.0);
    level._id_6754 setgoalpos(level._id_6754.origin);
  }

  var_1 = scripts\engine\utility::getStruct("org_salter_ship", "targetname");

  if(!isDefined(level._id_EA2C)) {
    scripts\sp\maps\yard\yard_util::_id_107BE("org_salter_ship");
  } else {
    level._id_EA2C dontinterpolate();
    level._id_EA2C _meth_80F1(var_1.origin, var_1.angles, 500000.0);
    level._id_EA2C setgoalpos(level._id_EA2C.origin);
  }

  level notify("crate_hack_cleanup");
  thread _id_3BDF();
  thread _id_3BE0();
  scripts\sp\utility::_id_28D8("axis");
  scripts\engine\utility::flag_wait("central_hack_ethan_end");
  thread scripts\sp\utility::_id_1264E("yard_server_tr");
  thread scripts\sp\utility::_id_1264E("yard_tram_central_tr");

  while(!istransientloaded("yard_end_dont_unload_tr")) {
    wait 0.05;
    waitforalltransients();
  }
}

_id_3B4A() {
  scripts\sp\maps\yard\yard_audio::_id_25EE("central_hack_ethan", "catchup");
}

_id_3BDF() {
  while(level.player._id_9BFA) {
    scripts\engine\utility::waitframe();
  }

  wait 1;
  level.player thread scripts\sp\utility::_id_D08C("ges_radio");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  scripts\sp\utility::_id_1034D("yard_plr_allclearmetal1");
  level.player playSound("ges_plr_radio_off");
  level.player stopgestureviewmodel("ges_radio");
  thread scripts\sp\utility::_id_12641("yard_server_tr");
  thread scripts\sp\utility::_id_12641("yard_tram_central_tr");
  wait 1;
  scripts\sp\utility::_id_10350("yard_eth_firingcontrolte");
  level._id_6754 thread _id_7726("yard_eth_readyforyoutostar", "iff_terminal_hacked", 5, 5, 45, 5, "org_pip_ethan", 2);
  var_0 = scripts\engine\utility::getStruct("org_hack_iff", "targetname");
  var_1 = scripts\engine\utility::getStruct("org_anim_terminal", "targetname");
  var_2 = scripts\sp\utility::_id_10639("player_rig");
  var_2 hide();
  var_1 scripts\sp\anim::_id_1EC1([var_2], "hack_command");
  var_0 _id_0E46::_id_48C4(undefined, (0, 0, -8), &"YARD_HINT_HACK_TERMINAL", undefined, 5000);
  var_0 waittill("trigger");
  scripts\sp\utility::_id_DBF5();
  scripts\engine\utility::flag_set("yard_obj_activate_controls_done");
  level notify("iff_terminal_hacked");
  thread _id_87EA();
  level.player setstance("stand");
  level.player disableweapons();
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player freezecontrols(1);

  if(isDefined(level.player._id_1586)) {
    level.player scripts\sp\utility::_id_11425();
  }

  level.player _meth_823C(var_2, "tag_player", 0.5, 0.25, 0.25);
  wait 0.5;
  level.player playerlinktodelta(var_2, "tag_player", 1, 30, 30, 20, 30, 1);
  var_2 show();
  thread _id_D7BC();
  setmusicstate("");

  while(!istransientloaded("yard_server_tr") || !istransientloaded("yard_tram_central_tr")) {
    wait 0.05;
    waitforalltransients();
  }

  var_1 scripts\sp\anim::_id_1F35(var_2, "hack_command");
  var_2 hide();
  level.player showviewmodel();
  level.player enableweapons();
  level.player scripts\sp\utility::_id_F526("safe");
  var_3 = level.player getweaponslistall();
  level.player disableoffhandsecondaryweapons();

  foreach(var_5 in var_3) {
    if(var_5 == "hackingdevice") {
      level.player assignweaponoffhandsecondary("hackingdevice");
    }
  }

  _id_0E29::_id_87CA(1, 0.75);
  level.player._id_C3E4 = level.player getcurrentprimaryweapon();
  level.player freezecontrols(0);
}

_id_8786(var_0) {
  var_1 = scripts\engine\utility::getStruct("ethan_bink_node", "targetname");
  var_1 scripts\sp\anim::_id_1EC1([level._id_6754, var_0], "hack_bink");
  level._id_6754.team = "neutral";
  scripts\engine\utility::waitframe();
  level.player _meth_823B(var_0, "tag_player");
  var_2 = [];
  var_2[0] = var_0;
  var_2[1] = level._id_6754;
  var_1 scripts\sp\anim::_id_1F2C(var_2, "hack_bink");
  wait 0.1;
  var_1 scripts\sp\anim::_id_1F2C(var_2, "hack_bink");
  wait 0.1;
  var_1 scripts\sp\anim::_id_1F2C(var_2, "hack_bink");
  scripts\engine\utility::flag_set("central_hack_check_done");
}

_id_D7BC() {
  scripts\sp\utility::_id_1034D("yard_plr_okayethanyoureu");
  scripts\sp\utility::_id_10350("yard_eth_themooringcontrols");
  scripts\sp\utility::_id_1034D("yard_plr_wehavenoordnanc");
  scripts\sp\utility::_id_10350("yard_eth_yessiryouneedtohac");
  level notify("finish_prehack_anim");
  scripts\sp\utility::_id_10350("yard_eth_usethehackingmo");
  scripts\engine\utility::flag_set("central_hack_check_done");
}

_id_3BE0() {
  scripts\engine\utility::flag_wait("central_hack_check_done");
  thread scripts\sp\maps\yard\yard_audio::_id_258A();
  level.player freezecontrols(1);
  scripts\engine\utility::waitframe();
  level.player scripts\sp\utility::_id_F526("normal");
  _id_0E29::_id_87ED(1);
  _id_0E29::_id_8799(1);
  _id_0E29::_id_8782(1);
  var_0 = scripts\engine\utility::getStruct("hack_ethan_proxy", "targetname") scripts\engine\utility::spawn_tag_origin();
  var_0.weapon = "script_struct";
  _id_0E29::_id_8795(var_0, level._id_6754);
  _id_0E29::_id_87C9(var_0, 30000);
  _id_0E29::_id_8780(1);
  level.player._id_885E = 1;
  level._id_6754 scripts\sp\utility::_id_1101B();
  _id_0E29::_id_87CC(1, "hack_eth3n_control");
  level._id_6754.ignoreme = 0;
  level._id_6754.ignoreall = 0;
  level._id_8826 = 1;
  _id_87AA(var_0);
  level.player _meth_8574("fullbody_hero_eth3n_vm_legs");
  level.player scripts\engine\utility::delaycall(0.5, ::_meth_84FD);
  level.player scripts\engine\utility::delaycall(0.55, ::_meth_8573, "eth3n_shadow");
  level notify("hack_control_target");
  thread _id_679A();
  clearallcorpses();
  thread scripts\sp\utility::_id_12641("yard_end_dont_unload_tr");
  scripts\engine\utility::flag_set("yard_stop_spacebattle");
  var_1 = getspawnerteamarray("bad_guys");
  scripts\engine\utility::array_thread(var_1, scripts\sp\utility::_id_E08B, _id_0E29::_id_19C8);
  scripts\engine\utility::array_thread(var_1, scripts\sp\utility::_id_E08B, _id_0E29::_id_1933);
  scripts\engine\utility::flag_set("yard_obj_hack_ethan_done");
  wait 0.5;
  var_2 = scripts\engine\utility::getStruct("org_ethan_hack", "targetname");
  var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  thread _id_87A2();
  thread _id_6768(var_0._id_1B07);
  thread _id_6778();
  scripts\sp\maps\yard\yard_fx::_id_132B7(1);
  thread _id_677C();
  wait 0.25;
  setmusicstate("mx_247_yard_hackethan");
  level.player freezecontrols(0);
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_sprint(1);
  level.player energy_setrestorerate(1, 400);
  thread _id_676B();
  level.player takeallweapons();
  level.player enableweaponswitch();
  level.player giveweapon("iw7_sdflmg");
  level.player switchtoweapon("iw7_sdflmg");
  var_4 = getEntArray("power_relay_door_01", "targetname");
  var_5 = getEntArray("power_relay_door_02", "targetname");
  var_6 = getEntArray("power_relay_door_03", "targetname");
  var_7 = [var_4, var_5, var_6];

  foreach(var_9 in var_7) {
    scripts\engine\utility::array_thread(var_9, scripts\sp\maps\yard\yard_util::_id_F595);
  }

  var_11 = scripts\engine\utility::getStruct("org_anim_power_core", "targetname");
  level._id_66C4 = scripts\engine\utility::getStruct("org_escape", "targetname");
  level._id_66C4 scripts\sp\anim::_id_1EC3(level._id_D267, "escape_button_press");
  _id_D723();
  var_12 = scripts\sp\player_rig::get_player_score();
  clearallcorpses();
  thread scripts\sp\hud_util::_id_6AA3(2.0, "white");
  _id_87AB();

  if(isDefined(level._id_6764)) {
    level._id_6764 delete();
  }

  scripts\sp\maps\yard\yard_fx::_id_132B7(0);
  level.player _meth_823B(level._id_D267, "tag_player");
  level.player unlink();

  if(isDefined(level._id_D267)) {
    level._id_D267 delete();
  }

  level.player setstance("stand");
  level.player scripts\sp\utility::_id_F526("normal");
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player _meth_8574("body_hero_protagonist_vm_legs");
  level.player _meth_8573("default_character_shadow");
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_jump(0);
  level.player scripts\engine\utility::allow_doublejump(0);
  level.player scripts\engine\utility::allow_sprint(0);
  scripts\engine\utility::delaythread(1, scripts\sp\hud_util::_id_6A99, 1, "white");
  level.player scripts\sp\utility::_id_65E3("hack_control_outro_done");
  level.player disableweapons();
  scripts\engine\utility::flag_set("central_hack_ethan_end");
  scripts\engine\utility::flag_set("yard_obj_destroy_core_done");
  scripts\sp\utility::_id_28D7("axis");
  setsaveddvar("r_mbRadialOverridePosition", (0, 0, 0));
  setsaveddvar("r_mbRadialOverridePositionActive", 0);
  setsaveddvar("r_mbRadialOverrideRadius", 0);
  setsaveddvar("r_mbRadialOverrideChromaticAberration", 0);
  setsaveddvar("r_mbRadialOverrideDistortion", 0);
  setsaveddvar("r_mbRadialOverrideStrength", 0);
}

_id_87A2() {
  var_0 = scripts\engine\utility::getStruct("anim_ethan_hack", "targetname");
  var_1 = scripts\sp\utility::_id_10639("ethan_rig");
  var_1 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_1, "ethan_hack");
  scripts\engine\utility::waitframe();
  level.player disableweapons();
  level.player setstance("stand");
  level.player _meth_823C(var_1, "tag_player", 0.5);
  wait 0.5;
  var_1 show();
  var_0 scripts\sp\anim::_id_1F35(var_1, "ethan_hack");
  level.player unlink();
  level.player enableweapons();
  setsaveddvar("player_sprintSpeedscale", 1.9);
  level.player._id_87FE = 1.2;
  var_1 delete();
  level.player disableweaponswitch();
}

_id_6767() {
  while(!scripts\engine\utility::flag("flag_core_hatch")) {
    level.player waittill("damage");
    level.player _id_D293(1, 1);
  }
}

_id_676B() {
  scripts\engine\utility::flag_wait("flag_core_downstairs");
  setumbraportalstate("ethan_room_portal_4", 1);
  wait 0.1;
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("power_relay_door_01", "open", "unlocked", "generic_door_open");
  scripts\engine\utility::flag_wait("flag_core_server");
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("power_relay_door_01", "close", "unlocked", "generic_door_close");
  setumbraportalstate("ethan_room_portal", 1);
  wait 0.1;
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("power_relay_door_02", "open", "unlocked", "generic_door_open");
  scripts\engine\utility::flag_wait("flag_core_hall");
  setumbraportalstate("ethan_room_portal_4", 0);
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("power_relay_door_02", "close", "unlocked", "generic_door_close");
  wait 0.1;
  setumbraportalstate("ethan_room_portal", 0);
  setumbraportalstate("ethan_room_portal_2", 1);
  wait 0.1;
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("power_relay_door_03", "open", "unlocked", "generic_door_open");
  scripts\engine\utility::flag_wait("flag_core_hatch");
  thread scripts\sp\maps\yard\yard_util::_id_D5FC("power_relay_door_03", "close", "unlocked", "generic_door_close");
  wait 0.1;
  setumbraportalstate("ethan_room_portal_2", 0);
  thread _id_D770();
}

_id_6768(var_0) {
  level endon("magnet_destroyed");
  var_0 waittill("death");
  _id_0B60::_id_F322("YARD_ETHAN_FAIL");
  _id_0B60::_id_F32D();
  scripts\sp\utility::_id_B8D1();
}

_id_677C() {
  var_0 = [];
  var_1 = scripts\sp\utility::_id_10639("j_prop_hatch");
  var_1._id_1FBB = "j_prop_hatch";
  thread _id_677E();
  var_2 = scripts\engine\utility::getStruct("org_anim_power_core", "targetname");
  var_3 = scripts\sp\utility::_id_10639("ethan_rig");
  var_3 hide();
  var_0[0] = var_3;
  var_0[1] = var_1;
  var_1 thread scripts\sp\maps\yard\yard_fx::_id_13314();
  var_2 scripts\sp\anim::_id_1EC1(var_0, "hatch_pull");
  var_4 = getEnt("ethan_hatch_model", "targetname");
  var_4 linkTo(var_1, "j_prop_1");
  level._id_1189 = var_4;
  scripts\engine\utility::flag_wait("flag_core_hatch");
  var_5 = scripts\engine\utility::getStruct("ethan_hatch_pull_obj", "targetname");
  var_6 = getEnt("power_relay_hatch_blocker", "targetname");
  var_5 _id_0E46::_id_48C4(undefined, (0, 0, -8), &"YARD_HINT_PULL", undefined, 512, 128, 1);
  var_5 waittill("trigger");
  level.player setstance("stand");
  level.player disableweapons();
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player freezecontrols(1);
  var_7 = getaiarray("axis");

  if(isDefined(var_7) && var_7.size) {
    foreach(var_9 in var_7) {
      var_9 delete();
    }
  }

  level.player _meth_823C(var_3, "tag_player", 0.5, 0.25, 0.25);
  wait 0.5;
  var_3 show();
  level.player playerlinktodelta(var_3, "tag_player", 1, 0, 0, 0, 0, 1);
  thread _id_677D();
  scripts\engine\utility::flag_set("central_hack_hatch_pulled");
  var_2 scripts\sp\anim::_id_1F2C(var_0, "hatch_pull");
  level._id_1189 = undefined;
  var_4 unlink();
  var_1 delete();
  var_3 hide();
  level.player unlink();
  level.player setstance("stand");
  level.player enableweapons();
  var_11 = level.player getcurrentweapon();
  level.player switchtoweapon(var_11);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player freezecontrols(0);
  var_6 delete();
  var_12 = scripts\sp\utility::_id_10639("ethan_legs", level.player.origin, (0, 0, 0));
  var_12 hide();
  var_13 = [];
  var_13[0] = var_3;
  var_13[1] = var_12;
  scripts\engine\utility::waitframe();
  var_2 scripts\sp\anim::_id_1EC1(var_13, "hatch_fall");
  scripts\engine\utility::flag_wait("flag_ethan_falling");
  var_4 delete();
  thread _id_13E34();
  level.player setstance("stand");
  level.player disableweapons();
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player freezecontrols(1);
  level.player _meth_823C(var_3, "tag_player", 0.25, 0.1, 0.1);
  wait 0.25;
  var_3 show();
  var_12 show();
  level.player playerlinktodelta(var_3, "tag_player", 1, 0, 0, 0, 0, 1);
  scripts\engine\utility::flag_set("central_hack_hatch_fell");
  var_2 thread scripts\sp\anim::_id_1F2C(var_13, "hatch_fall");
  setumbraportalstate("ethan_room_portal_3", 0);
  scripts\engine\utility::waitframe();
  thread _id_FE3E();
  thread _id_6775(var_3);
  var_3 waittillmatch("single anim", "end");
  var_3 hide();
  var_12 hide();
  level.player unlink();
  level.player setstance("stand");
  level.player enableweapons();
  level.player scripts\engine\utility::allow_crouch(1);
  level.player freezecontrols(0);
}

_id_FE3E() {
  level.player thread _id_D293(1, 0);
  wait 0.75;
  level.player thread _id_D293(0, 0);
}

_id_677E() {
  scripts\engine\utility::flag_wait("flag_core_in_heat_area");
  level.player scripts\engine\utility::allow_sprint(0);
  level.player thread scripts\sp\utility::_id_D2CD(70, 0.2);
  wait 0.25;
  level.player playgestureviewmodel("ges_frag_block");

  while(!scripts\engine\utility::flag("flag_core_enter")) {
    setomnvar("ui_hack_ethan_overlay_glitch_state", 1);
    wait 1.5;
    setomnvar("ui_hack_ethan_overlay_glitch_state", 0);
    scripts\engine\utility::waitframe();
  }

  setomnvar("ui_hack_ethan_overlay_glitch_state", 2);
}

_id_91F0() {
  scripts\sp\utility::_id_10350("yard_eth_gruntwave");
  scripts\sp\utility::_id_1034D("yard_plr_ethanyouokaypar");
  scripts\sp\utility::_id_1034D("yard_eth_chassiscansustain");
}

_id_677D() {
  wait 0.95;
  level.player playRumbleOnEntity("damage_light");
  wait 1.05;
  level.player playRumbleOnEntity("damage_heavy");
  wait 1.1;
  level.player playRumbleOnEntity("damage_heavy");
  wait 1.4;
  level.player playRumbleOnEntity("damage_light");
  wait 1;
  level.player playRumbleOnEntity("damage_heavy");
}

_id_6775(var_0) {
  var_1 = getEnt("ethan_landing_clean", "targetname");
  var_2 = getEnt("ethan_landing_broken", "targetname");
  var_2 hide();
  var_0 waittillmatch("single anim", "ethan_land");
  level.player playRumbleOnEntity("damage_heavy");
  scripts\engine\utility::exploder("vfx_ethan_land");
  var_1 hide();
  var_2 show();
}

_id_6445() {
  var_0 = getEntArray("enemy_destroyers", "targetname");

  foreach(var_2 in var_0) {
    var_2._id_EEF9 = "cannon_small_ca,1,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_l_ts_6,amb_turret_sml_l_ts_7";
  }

  level._id_1678 = [];
  level._id_6506 = scripts\sp\vehicle::_id_1080F("enemy_destroyers");
  wait 0.5;

  foreach(var_5 in level._id_6506) {
    var_5 thread _id_129C8();
    var_5 thread _id_FD34();
  }
}

_id_FD34() {
  self endon("death");
  self endon("deleted");
  scripts\engine\utility::flag_wait("remove_enemy_ships");

  if(isDefined(self)) {
    self delete();
  }
}

_id_129C8() {
  foreach(var_1 in self.turrets) {
    foreach(var_3 in var_1) {
      var_3._id_4D1E._id_DCCA = 70000;

      if(var_3.type == "cannon_flak_ca") {
        var_3.angles = var_3.angles + (0, 90, 0);
      }

      var_4 = randomfloatrange(-1000, 1000);
      var_5 = randomfloatrange(-1000, 1000);

      if(scripts\engine\utility::cointoss()) {
        var_3 settargetentity(level._id_EAD6, (var_4, var_5, 2000));
        continue;
      }

      var_3 settargetentity(level._id_EAD6, (var_4, var_5, -2000));
    }
  }

  scripts\engine\utility::waitframe();
  thread _id_63DF();
  thread _id_0BB6::_id_39F0(undefined, undefined);
}

_id_129C6(var_0) {
  var_1 = [];
  var_2 = -512;
  var_3 = 512;
  var_4 = 0;

  foreach(var_6 in level._id_6B07) {
    var_7 = scripts\engine\utility::random(var_0);
    var_4 = var_4 + 1;
    thread _id_6CF4(var_6.origin, var_7.origin, var_4);
    scripts\engine\utility::waitframe();
  }
}

_id_63DF() {
  var_0 = [];
  var_1 = -512;
  var_2 = 512;

  foreach(var_4 in self.turrets) {
    foreach(var_6 in var_4) {
      var_6 thread _id_B801();
      scripts\engine\utility::waitframe();
    }
  }

  scripts\engine\utility::waitframe();

  foreach(var_4 in self.turrets) {
    foreach(var_6 in var_4) {
      scripts\engine\utility::waitframe();
    }
  }
}

_id_129C7() {
  var_0 = 3;
  var_1 = 6;

  while(!scripts\engine\utility::flag("central_light_it_up")) {
    self settargetentity(level._id_EAD6);
    self shootturret();
    wait(randomfloatrange(var_0, var_1));
  }
}

_id_B801() {
  var_0 = self;
  var_1 = 3;
  var_2 = 12;
  var_3 = -1000;
  var_4 = 1000;
  var_5 = -1000;
  var_6 = 1000;
  var_7 = -1000;
  var_8 = 1000;
  wait(randomfloatrange(0.5, 1));

  while(!scripts\engine\utility::flag("central_light_it_up")) {
    var_9 = var_0 gettagorigin("tag_flash") + (128, 0, 128);

    if(isDefined(var_9) && scripts\engine\utility::cointoss()) {
      var_10 = level._id_EAD6.origin + (0, 0, 4000);
      var_11 = magicbullet("spaceship_homing_missile_yard", var_9, var_10, level.player);
      level._id_1678 = scripts\engine\utility::array_add(level._id_1678, var_11);
      var_12 = randomfloatrange(var_3, var_4);
      var_13 = randomfloatrange(var_5, var_6);
      var_14 = randomfloatrange(var_7, var_8);
      var_11 missile_settargetEnt(level._id_EAD6, (var_12, var_13, var_14));
      var_11 thread _id_13E42();
    }

    wait(randomfloatrange(var_1, var_2));
  }
}

_id_13E42() {
  self endon("death");
  self endon("deleted");
  wait 4;

  if(isDefined(self)) {
    self _meth_81D0();
  }
}

_id_91E6() {
  self endon("death");
  self endon("deleted");
  var_0 = randomfloatrange(-100, 100);
  var_1 = randomfloatrange(-100, 100);
  var_2 = randomfloatrange(-100, 100);
  self missile_settargetEnt(level._id_EAD6, (var_0, var_1, var_2));
}

_id_10FC5() {
  thread _id_0BB6::_id_39F1();
}

_id_87AA(var_0) {
  level.player unlink();
  level notify("yard_defend_ammo_cleanup");
  var_1 = level.player getweaponslistall();

  foreach(var_3 in var_1) {
    level.player takeweapon(var_3);
  }

  level.player scripts\engine\utility::allow_ads(0);
  level.player scripts\engine\utility::allow_melee(0);
  level.player scripts\engine\utility::allow_reload(0);
  level.player scripts\engine\utility::allow_fire(0);
  level.player scripts\engine\utility::allow_autoreload(0);
  level.player scripts\sp\utility::_id_1C49(0);
  level.player scripts\sp\utility::_id_1C34(0);
  level.player scripts\engine\utility::allow_offhand_primary_weapons(0);
  level.player scripts\engine\utility::allow_weapon_switch(0);
  level.player._id_87FA = 0;
  level.player thread _id_0E29::_id_E592(var_0);
  level.player thread _id_0E29::_id_87AF();
  level.player._id_8802 = [];
  wait 1.0;
  scripts\engine\utility::flag_set("hack_hud_control_intro_black");
  scripts\engine\utility::flag_clear("hack_hud_control_outro_black");
  scripts\engine\utility::flag_clear("hack_hud_control_outro_finished");
  level.player scripts\sp\utility::_id_65DD("hack_control_outro_done");
  level.player notify("hack_intro_done");
  setsaveddvar("player_sprintUnlimited", 1);
  level.player thread _id_6766();
}

_id_6766() {
  level endon("ethan_at_core");
  level.player._id_8856 = 1000;
}

_id_D325() {
  setomnvar("ui_hack_control_overlay", 1);
  scripts\engine\utility::delaythread(0.35, _id_0E29::_id_87B6);
  scripts\engine\utility::noself_delaycall(0.6, ::visionsetnaked, "hack_c6_control", 0.1);
  thread scripts\engine\utility::flag_set_delayed("hack_hud_control_intro_black", 0.6);
  thread scripts\engine\utility::flag_set_delayed("hack_hud_control_intro_finished", 1.0);
  scripts\engine\utility::delaycall(0.35, ::playsound, "hack_start_hud_lr");
  scripts\engine\utility::delaycall(0.35, ::_meth_82C2, "hacking_hud_transition", "mix");
}

_id_87AB() {
  level.player _meth_80D1();
  wait 1.15;
  level._id_D365 = scripts\sp\utility::_id_10639("player_arms");
  level.player _id_0E29::_id_87B0();
  level notify("vfx_player_suicided_drone");
  level.player _id_D293(0, 0);
  setomnvar("ui_hack_ethan_overlay_glitch_state", 0);
  setsaveddvar("player_sprintUnlimited", 0);
}

_id_87A3() {
  scripts\sp\maps\yard\yard_fx::_id_13301(1);
  scripts\sp\maps\yard\yard_fx::_id_132BA(1);
}

_id_675E() {
  thread _id_675F();
  thread _id_6760();
  thread _id_6761();
}

_id_675F() {
  level notify("ai_aware_of_hacked_drone");
  scripts\engine\utility::flag_wait("flag_core_downstairs");
  var_0 = scripts\sp\utility::_id_22CD("ethan_moment_wave_1_2", 1);

  foreach(var_2 in var_0) {
    var_2 _id_6771();
    var_2 thread _id_13BC5("flag_core_server");
  }

  level notify("ai_aware_of_hacked_drone");
}

_id_6760() {
  scripts\engine\utility::flag_wait("flag_core_downstairs");
  var_0 = scripts\sp\utility::_id_22CD("ethan_moment_wave_2", 1);

  foreach(var_2 in var_0) {
    var_2 _id_6771();
    var_2 thread _id_13BC5("flag_core_enter");
  }

  level notify("ai_aware_of_hacked_drone");
}

_id_6761() {
  var_0 = getEnt("c6_rss_spawner", "targetname");
  var_0 scripts\sp\utility::_id_E08B(scripts\sp\maps\yard\yard_elevator::_id_3356);
  var_0 scripts\sp\utility::_id_1747(::_id_13E38);
  var_0 scripts\sp\utility::_id_1747(::_id_6771);
  level._id_E5A3 = _id_0B6C::_id_FA2A("vol_ethan_rss_1");
  level._id_E5A4 = _id_0B6C::_id_FA2A("vol_ethan_rss_3");
  var_1 = getEnt("vol_ethan_robot_room", "targetname");
  scripts\engine\utility::flag_wait("flag_core_server");
  thread scripts\sp\utility::_id_1034D("yard_eth_couldgetinteresting");
  var_2 = scripts\sp\utility::_id_22CD("ethan_moment_wave_2_5", 1);

  foreach(var_4 in var_2) {
    var_4 _id_6771();
    var_4 thread _id_13BC5("flag_core_enter");
  }

  level notify("ai_aware_of_hacked_drone");
  scripts\engine\utility::flag_wait("flag_core_robots");
  level._id_E5A3 _id_0B6C::_id_8953();
  level._id_E5A4 _id_0B6C::_id_8953();
  wait 5;
  scripts\engine\utility::flag_wait_or_timeout("flag_core_hall", 60);
  level notify("ai_aware_of_hacked_drone");
}

_id_13E38() {
  if(isDefined(self) && isalive(self)) {
    var_0 = "hackControl";
    scripts\sp\utility::_id_9196(1, 0, 1, var_0);
    self waittill("death");
    scripts\sp\utility::_id_9193(var_0);
  } else
    return;
}

_id_6793() {
  var_0 = scripts\engine\utility::getStructArray("server_room_heat_wave_node", "targetname");

  while(!scripts\engine\utility::flag("flag_core_close")) {
    var_1 = scripts\engine\utility::random(var_0);
    playFX(level._effect["server_heat"], var_1.origin);
    wait(randomfloatrange(0.75, 1.5));
  }
}

_id_E581() {
  var_0 = scripts\engine\utility::getStruct("robot_cover_setup_table", "targetname");
  var_1 = scripts\engine\utility::getStruct("robot_cover_setup", "targetname");
  var_2 = scripts\sp\utility::_id_10639("table");
  var_0 scripts\sp\anim::_id_1EC3(var_2, "table_flip");
  var_3 = getEnt("robot_cover", "targetname");
  scripts\engine\utility::flag_wait("flag_core_server");
  var_4 = var_3 scripts\sp\utility::_id_10619(1);
  var_4._id_1FBB = "generic";
  var_0 thread scripts\sp\anim::_id_1F35(var_2, "table_flip");
  var_1 thread scripts\sp\anim::_id_1F35(var_4, "table_flip");
  var_4.allowdeath = 1;
  scripts\engine\utility::delaythread(0.85, scripts\engine\utility::play_sound_in_space, "scn_phstreets_cafe_table_flip", var_2.origin);
}

_id_E77C() {
  scripts\engine\utility::flag_wait("flag_core_server");
  var_0 = getEnt("ethan_moment_rss_guy", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1._id_1FBB = "generic";
  var_1 thread scripts\sp\anim::_id_1EEA(var_1, "idle_console");
  wait 1;

  if(isalive(var_1)) {
    var_1 _meth_83A1();
  }
}

_id_6762() {
  scripts\engine\utility::flag_wait("flag_core_hall");
  var_0 = scripts\sp\utility::_id_22CD("ethan_moment_wave_4", 1);

  foreach(var_2 in var_0) {
    var_2 _id_6771();
    var_2 thread _id_13BC5("flag_core_close", 2);
  }

  level notify("ai_aware_of_hacked_drone");
}

_id_6763() {
  scripts\engine\utility::flag_wait("flag_core_enter");
  var_0 = scripts\sp\utility::_id_22CD("ethan_moment_wave_5", 1);

  foreach(var_2 in var_0) {
    var_2 _id_6771();
  }

  level notify("ai_aware_of_hacked_drone");
}

_id_13BC5(var_0, var_1) {
  self endon("death");
  self endon("deleted");
  scripts\engine\utility::flag_wait(var_0);

  if(isDefined(var_1)) {
    wait(var_1);
  }

  self delete();
}

_id_6771() {
  scripts\engine\utility::delaythread(0.1, _id_0E29::_id_19C8, 0);
}

_id_7726(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon(var_1);
  level.player endon(var_1);

  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  if(!isDefined(var_2)) {
    var_2 = 5;
  }

  if(!isDefined(var_3)) {
    var_3 = 10;
  }

  if(!isDefined(var_4)) {
    var_4 = 45;
  }

  if(!isDefined(var_5)) {
    var_5 = var_2;
  }

  if(!isDefined(var_7)) {
    var_7 = 0;
  }

  wait(var_5);

  for(;;) {
    scripts\sp\utility::_id_10350(scripts\engine\utility::random(var_0));
    wait(randomfloatrange(var_2 - 1, var_2 + 1));
    var_2 = min(var_4, var_2 + var_3);
  }
}

_id_677A() {
  while(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, level._id_6754.origin, 0.98)) {
    wait 0.05;
  }

  thread scripts\sp\utility::_id_1034D("yard_plr_iseeyouhackingn");
  level.player waittill("hack_control_target");
  thread scripts\sp\utility::_id_1034D("yard_plr_hackingnow");
}

_id_6778() {
  scripts\sp\utility::_id_1034D("yard_plr_okayethanwhatdoido");
  scripts\sp\utility::_id_10350("yard_eth_veryunusualsir");
  scripts\sp\utility::_id_1034D("yard_plr_whatdowedo");
  scripts\sp\utility::_id_10350("yard_eth_distributionroo");
  thread scripts\sp\utility::_id_46AD(130, "yard_final_countdown");
  thread _id_46AC();
  thread _id_46AE();
  thread _id_BB50(10);
  scripts\engine\utility::flag_wait("flag_core_why");
  scripts\sp\utility::_id_10350("yard_eth_wellpullthefuse");
  scripts\sp\utility::_id_1034D("yard_plr_ethanwhydidyoun");
  scripts\sp\utility::_id_10350("yard_eth_coreiselectroma");
  scripts\engine\utility::flag_wait("flag_core_in_heat_area");
  wait 0.3666;
  scripts\sp\utility::_id_10350("yard_eth_gruntwave");
  scripts\sp\utility::_id_10350("yard_eth_insidedistributionroom");
  scripts\sp\utility::_id_10350("yard_eth_chassiscansustain");
  thread _id_BB51(10);
}

_id_BB50(var_0) {
  wait(var_0);

  if(scripts\engine\utility::flag("flag_core_downstairs")) {
    return;
  }
  scripts\sp\utility::_id_10350("yard_eth_downthosestairssir");
  thread scripts\sp\maps\yard\yard_audio::_id_25E5();
  scripts\sp\utility::_id_10350("yard_slt_mooringsreleased");
  level notify("stop_radio_bg_fire");

  if(scripts\engine\utility::flag("flag_core_downstairs")) {
    return;
  }
  scripts\sp\utility::_id_1034D("yard_plr_statictarget");
}

_id_BB51(var_0) {
  wait(var_0);

  if(scripts\engine\utility::flag("flag_core_hatch_open")) {
    return;
  }
  thread scripts\sp\maps\yard\yard_audio::_id_25E5();
  scripts\sp\utility::_id_10350("yard_slt_lastmuchlonger");
  level notify("stop_radio_bg_fire");

  if(scripts\engine\utility::flag("flag_core_hatch_open")) {
    return;
  }
  scripts\sp\utility::_id_1034D("yard_plr_nowornever");
}

_id_6785() {
  var_0 = getEntArray("ethan_pipes", "targetname");

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_9196(1, 0, 1, "fuse");
  }

  scripts\engine\utility::flag_wait("flag_core_downstairs");

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_9193("fuse");
    var_2 delete();
  }
}

_id_46AC() {
  level.player endon("player_suicided_drone");
  level waittill("yard_final_countdown");
  _id_0B60::_id_F322("YARD_ETHAN_FAIL");
  _id_0B60::_id_F32D();
  scripts\sp\utility::_id_B8D1();
}

_id_46AE() {
  level.player waittill("player_suicided_drone");
  scripts\sp\utility::_id_46AB();
}

_id_6789() {
  scripts\engine\utility::flag_wait("flag_core_robots");
  thread scripts\sp\maps\yard\yard_audio::_id_25E5();
  scripts\sp\utility::_id_10350("yard_slt_lastmuchlonger");
  level notify("stop_radio_bg_fire");
  scripts\sp\utility::_id_1034D("yard_plr_nowornever");
  scripts\engine\utility::flag_wait("flag_core_hall");
}

_id_6777() {
  scripts\sp\utility::_id_1034D("yard_plr_ethanwhydidyoun");
  scripts\sp\utility::_id_10350("yard_eth_coreiselectroma");
  scripts\engine\utility::flag_wait("flag_core_enter");
}

_id_91A3() {
  var_0 = [];
  var_0["r_hudoutlineWidth"] = 2;
  var_0["r_hudoutlineFillColor0"] = "0 0 0 0";
  var_0["r_hudoutlineFillColor1"] = "0 0 0 0";
  var_0["r_hudoutlineOccludedOutlineColor"] = "1 1 1 1";
  var_0["r_hudoutlineOccludedInlineColor"] = "1 1 1 0.1";
  var_0["r_hudoutlineOccludedInteriorColor"] = "1 1 1 0.1";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_0;
}

_id_91A2() {
  var_0 = [];
  var_0["r_hudoutlineWidth"] = 2;
  var_0["r_hudoutlineFillColor0"] = "1 1 1 0.1";
  var_0["r_hudoutlineFillColor1"] = "1 1 1 0.1";
  var_0["r_hudoutlineOccludedOutlineColor"] = "1 1 1 1";
  var_0["r_hudoutlineOccludedInlineColor"] = "1 1 1 0.1";
  var_0["r_hudoutlineOccludedInteriorColor"] = "1 1 1 0.1";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_0;
}

_id_FE43() {
  level endon("central_hack_ethan_end");

  for(;;) {
    self waittill("trigger", var_0);

    if(var_0 == level.player) {
      level.player _id_D293(1, 1);
      wait 0.3;
      level.player freezecontrols(0);
      setomnvar("ui_hack_control_signal_failing", 0);

      while(level.player istouching(self)) {
        playFX(level._id_7649["player_shock"], (0, 0, 0));
        wait 0.1;
      }

      level.player _id_D293(0);
      level.player stoprumble("damage_light");
    }
  }
}

_id_D293(var_0, var_1) {
  if(var_0) {
    playFX(level._id_7649["player_shock"], (0, 0, 0));

    if(isDefined(var_1) && var_1) {
      setomnvar("ui_hack_control_signal_failing", 1);
    }

    self _meth_80D8(0.3, 0.3);
    self playRumbleOnEntity("damage_light");
    thread _id_CFA6();
    thread scripts\engine\utility::play_loop_sound_on_entity("emp_nade_plr_lp");
  } else {
    if(isDefined(var_1) && var_1) {
      level.player freezecontrols(0);
      setomnvar("ui_hack_control_signal_failing", 0);
    }

    self notify("stop soundemp_nade_plr_lp");
    playworldsound("emp_nade_plr_lp_end", self.origin);
    self _meth_80A6();
    self stoprumble("damage_light");
    self notify("done_shocked");
  }
}

_id_CFA6() {
  level.player endon("death");
  level.player endon("done_shocked");

  for(;;) {
    var_0 = randomfloatrange(0.8, 1);
    var_1 = randomfloatrange(0.8, 1);
    var_2 = randomfloatrange(0.8, 1);
    var_3 = 0.05;
    var_4 = -1;
    var_5 = -1;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 1;
    level.player _meth_8291(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    wait(var_3);
  }
}

_id_BC81() {
  if(isDefined(self)) {
    level endon("central_hack_ethan_end");

    for(;;) {
      self movex(128, 2, 0.25, 0.25);
      self waittill("movedone");
      self movex(-128, 2, 0.25, 0.25);
      self waittill("movedone");
    }
  }
}

_id_425E() {
  scripts\engine\utility::flag_wait("flag_core_close");
}

_id_6773() {
  scripts\engine\utility::flag_wait("flag_ethan_falling");
  level.player scripts\engine\utility::allow_jump(0);
  level.player scripts\engine\utility::allow_wallrun(0);
  scripts\engine\utility::flag_wait("flag_core_enter");
  wait 0.5;
  level.player scripts\engine\utility::allow_jump(1);
  level.player scripts\engine\utility::allow_wallrun(1);
}

_id_D74D() {
  level._id_DF32 = scripts\engine\utility::getStruct("power_relay_struct", "targetname");
  level._id_D722 = scripts\engine\utility::getStruct("power_relay_core_struct", "targetname");
  level waittill("magnet_destroyed");
  level waittill("magnet_destroyed");
  scripts\engine\utility::flag_set("ramp_magnet_speed_up");
  level waittill("magnet_destroyed");
  level notify("relay_primed");
  level endon("central_hack_ethan_end");
}

_id_D723() {
  thread _id_678C();
  level notify("ethan_at_core");
  _id_10A09(1);
  var_0 = randomfloatrange(2.0, 4.5);
  screenshake(level.player.origin, 0.2, 0, 0, var_0, 0, var_0 * 0.5, 0, 15);
  level.player playRumbleOnEntity("damage_heavy");
  level notify("magnet_destroyed");
  level.player playRumbleOnEntity("damage_heavy");
  scripts\engine\utility::flag_set("flag_core_magnets_destroyed");
  wait 0.1666;
  scripts\sp\utility::_id_10350("yard_eth_gruntwave");
  scripts\sp\utility::_id_1034D("yard_plr_whatdowedo");
  scripts\sp\utility::_id_10350("yard_eth_inductivecoilsi");
  scripts\sp\utility::_id_10350("yard_eth_pullthecapcacitorto");
  scripts\engine\utility::flag_wait("core_destroyed");
}

_id_D770() {
  setmusicstate("");
  wait 2.222;
  setmusicstate("mx_444_yard_hackethan_2");
}

_id_678C() {
  var_0 = scripts\engine\utility::getStruct("org_anim_power_core", "targetname");
  var_1 = scripts\sp\utility::_id_10639("ethan_rig");
  var_2 = scripts\sp\utility::_id_10639("j_prop_panel");
  level._id_6764 = var_2;
  var_3 = [];
  var_3[0] = var_1;
  var_3[1] = var_2;
  var_1 hide();
  var_0 scripts\sp\anim::_id_1EC1(var_3, "panel_start_01");
  var_4 = getEnt("panel_new", "targetname");
  var_4.origin = var_2 gettagorigin("tag_door");
  var_4.angles = var_2 gettagangles("tag_door");
  var_4 linkTo(var_2, "tag_door");
  var_5 = getEnt("console_new", "targetname");
  var_5.origin = var_2 gettagorigin("tag_console");
  var_5.angles = var_2 gettagangles("tag_console");
  var_5 linkTo(var_2, "tag_console");
  var_6 = getEnt("panel_dest", "targetname");
  var_6.origin = var_2 gettagorigin("tag_door");
  var_6.angles = var_2 gettagangles("tag_door");
  var_6 linkTo(var_2, "tag_door");
  var_7 = getEnt("console_dest", "targetname");
  var_7.origin = var_2 gettagorigin("tag_console");
  var_7.angles = var_2 gettagangles("tag_console");
  var_7 linkTo(var_2, "tag_console");
  var_6 hide();
  var_7 hide();
  var_8 = scripts\engine\utility::getStruct("ethan_tappy_button", "targetname");
  var_9 = scripts\engine\utility::spawn_tag_origin(var_8.origin, (0, 0, 0));
  scripts\engine\utility::flag_wait("flag_core_magnets_destroyed");
  thread _id_E55E();
  var_8 _id_0E46::_id_48C4(undefined, undefined, &"YARD_HINT_PULL", undefined, 1024, 128, 1);
  var_8 waittill("trigger");
  scripts\sp\utility::_id_DBF5();
  level notify("core_pull_started");
  level.player _meth_823C(var_1, "tag_player", 0.5, 0.25, 0.25);
  wait 0.5;
  level.player disableweapons();
  level.player playerlinktodelta(var_1, "tag_player", 1, 0, 0, 0, 0, 1);
  var_1 show();
  var_2 thread scripts\sp\maps\yard\yard_fx::_id_1334C();
  var_0 scripts\sp\anim::_id_1F2C(var_3, "panel_start_01");
  _id_114EE(var_0, var_3, "panel_idle_01");
  var_4 thread scripts\sp\maps\yard\yard_audio::_id_25AA("panel_start_02");
  var_0 scripts\sp\anim::_id_1F2C(var_3, "panel_start_02");
  _id_114EE(var_0, var_3, "panel_idle_02");
  thread _id_4659();
  var_4 hide();
  var_5 hide();
  var_6 show();
  var_7 show();
  thread _id_0B61::_id_95A4();
  thread _id_465A(3);
  var_4 thread scripts\sp\maps\yard\yard_audio::_id_25AA("panel_end");
  var_0 thread scripts\sp\anim::_id_1F35(var_2, "panel_end");
  var_0 scripts\sp\anim::_id_1F35(var_1, "panel_end");
  level.player unlink();
  var_1 hide();
  level.player enableweapons();
  level.player thread _id_10C9C();
  level.player scripts\engine\utility::allow_sprint(0);
  level.player scripts\engine\utility::allow_jump(0);
  level.player scripts\sp\utility::_id_F526("safe");
  level.player thread scripts\sp\utility::_id_D2CD(15, 0.05);
  var_4 unlink();
  var_5 unlink();
  var_6 unlink();
  var_7 unlink();
  thread _id_4076([var_4, var_5, var_6, var_7]);
  _id_6792();
}

_id_6781(var_0) {
  screenshake(level.player.origin, 0.8, 0.8, 0.1, 3.0, 0, 1.0, 1000, 16, 16, 2);
  setomnvar("ui_hack_control_signal_failing", 1);
  wait 4.0;
  setomnvar("ui_hack_control_signal_failing", 0);
}

_id_10C9C() {
  wait 0.25;
  var_0["pitch"]["min"] = 1;
  var_0["pitch"]["max"] = 12;
  var_0["yaw"]["min"] = -12;
  var_0["yaw"]["max"] = 6;
  var_0["roll"]["min"] = -12;
  var_0["roll"]["max"] = 10;
  _id_0B61::_id_F324(var_0["pitch"], var_0["yaw"], var_0["roll"]);

  while(length(level.player getvelocity()) < 15) {
    scripts\engine\utility::waitframe();
  }

  _id_0B61::_id_ACDE("leg_right", 0, 1.25, 0);
}

_id_4076(var_0) {
  level.player waittill("player_suicided_drone");
  wait 3;

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }
}

_id_4659() {
  wait 1.2;
  level.player playRumbleOnEntity("damage_heavy");
  earthquake(0.25, 0.25, level.player.origin, 5000);
  wait 0.4;
  level.player playRumbleOnEntity("damage_heavy");
  earthquake(0.35, 0.25, level.player.origin, 5000);
}

_id_E55E() {
  var_0 = [];
  var_0[var_0.size] = "yard_eth_breaktheglasspu";
  var_0[var_0.size] = "yard_eth_pullitsir";
  var_0[var_0.size] = "yard_eth_capacitoroffthe";
  thread _id_7726(var_0, "core_pull_started", 5, 3, 25, 7);
}

_id_FEAF() {
  scripts\sp\utility::_id_10350("yard_eth_breaktheglasspu");
  scripts\sp\utility::_id_10350("yard_plr_wecanshoot");
  scripts\sp\utility::_id_10350("yard_eth_wontdoit");
  scripts\sp\utility::_id_10350("yard_plr_whatwill");
}

_id_6792() {
  level.player enableweapons();
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player freezecontrols(0);
  scripts\sp\utility::_id_1034D("yard_plr_lookslikeitsove");
  scripts\sp\utility::_id_10350("yard_eth_nosircoresstill");
  scripts\sp\utility::_id_10350("yard_eth_itsnotenoughsir2");
  scripts\sp\utility::_id_1034D("yard_plr_whatwill");
  scripts\sp\utility::_id_10350("yard_eth_myselfdestructs");
  scripts\sp\utility::_id_10350("yard_eth_itllsetoffachai");
  scripts\sp\utility::_id_1034D("yard_plr_theresgottabean");
  thread scripts\sp\utility::_id_10350("yard_eth_imafraidnotsir");
  level.player thread _id_895C();
  level.player thread _id_F1E0();
  thread _id_6DBE();
  thread _id_62F1();
}

_id_6769() {
  wait 10;
}

_id_895C() {
  var_0 = getEnt("core_piece", "targetname");
  var_1 = undefined;
  var_2 = undefined;
  var_3 = _id_4922();

  if(isDefined(var_0)) {
    var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  } else {
    var_0 = scripts\engine\utility::getStruct("power_relay_struct", "targetname");

    if(isDefined(var_0)) {
      var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
      var_1.origin = var_1.origin + (0, 0, -72);
    }
  }

  objective_additionalentity(scripts\sp\utility::_id_C264("obj_destroy_power_core"), 1, var_1);

  while(!scripts\engine\utility::flag("core_destroyed")) {
    var_2 = scripts\common\trace::ray_trace_passed(level.player getEye(), var_1.origin, level.player, var_3);

    if(distance2d(self.origin, var_1.origin) < 200 && level.player worldpointinreticle_circle(var_1.origin, 65, 350) && var_2 == 1) {
      _id_0E29::_id_8799(0);
      scripts\sp\utility::_id_56BA("ethan_destruct");
      scripts\engine\utility::flag_set("self_destruct_enabled");
    } else {
      _id_0E29::_id_8799(1);
      level.player _meth_8497();
      scripts\engine\utility::flag_clear("self_destruct_enabled");
    }

    scripts\engine\utility::waitframe();
  }

  level.player _meth_8497();
}

_id_4922() {
  var_0 = ["physicscontents_monsterclip"];
  return physics_createcontents(var_0);
}

_id_F1E0() {
  while(!scripts\engine\utility::flag("core_destroyed")) {
    level.player waittill("primary_equipment_pressed");
    level.player scripts\sp\utility::_id_1C3E(0);

    if(scripts\engine\utility::flag("self_destruct_enabled")) {
      _id_0E29::_id_8782(0);
      level.player scripts\engine\utility::allow_usability(0);
      level.player _meth_8497();
      level notify("stop_ethan_death_nag");
      level.player notify("stop_ethan_death_nag");
      scripts\sp\utility::_id_DBF5();
      scripts\sp\utility::_id_10350("yard_eth_goodluckreyes");
      thread scripts\sp\utility::_id_10350("yard_eth_itsbeenanhonors");
      setmusicstate("");
      level.player thread _id_0B61::_id_554E();
      level.player thread scripts\sp\utility::_id_D2CA(0.05);
      level.player scripts\engine\utility::allow_sprint(1);
      scripts\engine\utility::flag_set("core_destroyed");
    }

    scripts\engine\utility::waitframe();
  }
}

_id_6DBE() {
  level endon("stop_ethan_death_nag");
  wait 3;
  scripts\sp\utility::_id_10350("yard_eth_iunderstandthec");
  var_0 = ["yard_eth_imnotgettingout", "yard_eth_ltsaltersunitis", "yard_eth_captainreyesthe", "yard_eth_sirdontwasteany", "yard_eth_youreagoodmanfo"];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    wait 10;
    scripts\sp\utility::_id_10350(var_0[var_1]);
  }
}

_id_114EE(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::getStruct("ethan_tappy_button", "targetname");
  var_3 _id_0E46::_id_48C4(undefined, undefined, &"YARD_HINT_PULL", undefined, 256, 256, 1, 1);
  level.player notifyonplayercommand("tappy_pressed", "+usereload");
  level.player notifyonplayercommand("tappy_pressed", "+activate");
  var_4 = scripts\sp\utility::_id_7C23();
  var_5 = 3;
  var_6 = 0;
  var_7 = 1;

  while(var_6 < var_5) {
    level.player waittill("tappy_pressed");

    if(var_7) {
      var_0 thread scripts\sp\anim::_id_1EE7(var_1, var_2, "stop_loop");
      var_7 = 0;
    }

    var_6++;
    thread _id_CE52();
    var_4 scripts\sp\utility::_id_F581(0.85);
    var_4 scripts\sp\utility::_id_E7C7(0.75);
    wait 0.75;
  }

  var_0 notify("stop_loop");
  level.player stoprumble("damage_heavy");
  var_3 _id_0E46::_id_DFE3();
  var_4 delete();
}

_id_CE52() {}

_id_10A09(var_0) {
  var_1 = getEnt("relay_core_piece_1", "targetname");
  var_2 = getEnt("relay_core_piece_2", "targetname");
  var_3 = getEnt("relay_core_piece_3", "targetname");
  var_4 = getEnt("relay_core_center", "targetname");
  var_5 = getEnt("relay_core_center_2", "targetname");
  var_6 = getEnt("relay_core_center_3", "targetname");
  var_4._id_10A05 = 1;
  var_5._id_10A05 = 1;
  var_6._id_10A05 = 1;
  var_1._id_4651 = var_4;
  var_2._id_4651 = var_5;
  var_3._id_4651 = var_6;
  var_1 linkTo(var_4);
  var_2 linkTo(var_5);
  var_3 linkTo(var_6);
  thread scripts\sp\maps\yard\yard_audio::_id_258F(var_1, var_2, var_3);
  scripts\sp\maps\yard\yard_fx::_id_132D9();
  var_1 thread _id_10A08("core_piece_destroyed_1");
  var_2 thread _id_10A08("core_piece_destroyed_2");
  var_3 thread _id_10A08("core_piece_destroyed_3");
  scripts\engine\utility::flag_wait("flag_core_hatch");
  level notify("yard_ammo_ethan_cleanup");

  if(var_0) {
    var_7 = 45;
    var_4 thread _id_DF33(var_7);
    var_5 thread _id_DF33(-1 * var_7);
    var_6 thread _id_DF33(var_7);
  }

  scripts\engine\utility::flag_wait("flag_core_enter");
  scripts\engine\utility::flag_set("core_light_stage02");
  thread scripts\sp\maps\yard\yard_lighting::_id_4655();
  level notify("vfx_core_overload");
}

_id_4658(var_0, var_1, var_2) {
  objective_additionalentity(scripts\sp\utility::_id_C264("obj_destroy_power_core"), 1, var_0);
  scripts\engine\utility::flag_wait("core_piece_destroyed_1");

  if(!scripts\engine\utility::flag("core_piece_destroyed_2")) {
    objective_additionalentity(scripts\sp\utility::_id_C264("obj_destroy_power_core"), 1, var_1);
    scripts\engine\utility::flag_wait("core_piece_destroyed_2");
  }

  if(!scripts\engine\utility::flag("core_piece_destroyed_3")) {
    objective_additionalentity(scripts\sp\utility::_id_C264("obj_destroy_power_core"), 1, var_2);
    scripts\engine\utility::flag_wait("core_piece_destroyed_3");
  }

  scripts\engine\utility::flag_wait_all("core_piece_destroyed_1", "core_piece_destroyed_2", "core_piece_destroyed_3");
  scripts\sp\utility::_id_C27B(scripts\sp\utility::_id_C264("obj_destroy_power_core"));
}

_id_465A(var_0) {
  var_1 = getEnt("ethan_tube_top", "targetname");
  var_2 = getEnt("ethan_tube_mid", "targetname");
  var_3 = getEnt("ethan_tube_bot", "targetname");
  var_4 = 0.75;
  var_5 = 0.5;

  if(!isDefined(var_0)) {
    var_0 = 2;
  }

  var_6 = getEnt("relay_shadow_tube", "targetname");

  if(isDefined(var_6)) {
    var_6 linkTo(var_1);
  }

  wait(var_0);
  level notify("vfx_core_exposed");
  thread scripts\sp\maps\yard\yard_audio::_id_2590(var_4, var_5, var_1, var_2, var_3);

  if(isDefined(var_3) && isDefined(var_2) && isDefined(var_1)) {
    var_1 movez(-29, var_4, 0.25, 0.1);
    wait(var_4);
    level.player playRumbleOnEntity("damage_heavy");
    wait(var_5);
    var_1 linkTo(var_2);
    var_2 movez(-41, var_4, 0.25, 0.1);
    wait(var_4);
    level.player playRumbleOnEntity("damage_heavy");
    wait(var_5);
    var_1 unlink();
    var_1 linkTo(var_3);
    var_2 linkTo(var_3);
    var_3 movez(-29, var_4, 0.25, 0.1);
    wait(var_4);
    level.player playRumbleOnEntity("damage_heavy");
  }

  scripts\engine\utility::flag_set("core_light_stage02");
  thread scripts\sp\maps\yard\yard_lighting::_id_4656();
}

_id_915D() {
  self endon("destroyed");
  scripts\sp\utility::_id_9196(1, 0, 1, "fuse");
  self setcontents(0);
}

_id_10A08(var_0) {
  thread scripts\sp\maps\yard\yard_fx::_id_132DB();
  var_1 = getEnt(self.target, "targetname");
  var_1 hide();
}

_id_8CAD(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 100;
  }

  for(var_1 = 0; var_1 < var_0; var_1 = var_2 + var_1) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
  }
}

_id_DF33(var_0) {
  self endon("speed_change");
  self endon("destroyed");
  thread _id_10312(var_0);

  if(isDefined(self._id_10A05) && !self._id_10A05) {
    return;
  }
  for(;;) {
    var_1 = 1.0;
    self rotateYaw(var_0, var_1, 0, 0);
    wait(var_1);
  }
}

_id_10312(var_0) {
  self endon("speed_change");
  self waittill("stop_spinning");
  self rotateYaw(var_0 / 2, 1, 0.1, 0.75);
  wait 1;
  self rotateYaw(var_0 / 4, 1, 0.1, 0.75);
}

_id_52A1(var_0) {
  var_1 = scripts\engine\utility::getStruct("power_realy_temp_fx_1", "targetname");
  var_2 = scripts\engine\utility::getStruct("power_realy_temp_fx_2", "targetname");
  var_3 = scripts\engine\utility::getStruct("power_realy_temp_fx_3", "targetname");
  var_4 = scripts\engine\utility::getStruct("power_realy_temp_fx_4", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  wait(var_0);
  level.player playRumbleOnEntity("damage_light");
  wait 0.5;
  level.player playRumbleOnEntity("damage_light");
  wait 0.5;
  level.player playRumbleOnEntity("damage_light");
  wait 0.5;
  level.player playRumbleOnEntity("damage_light");
}

_id_62F1() {
  level.player endon("player_suicided_drone");
  wait 45;
  level.player notify("stop_ethan_death_nag");
  level._id_EA2C scripts\sp\utility::_id_51E1("casual");
  scripts\sp\pip_util::_id_2ADF("yard_hud_salter_pip_03");
  thread scripts\sp\maps\yard\yard_audio::_id_25E5();
  scripts\sp\utility::_id_10350("yard_slt_reyesweretaking");
  level notify("stop_radio_bg_fire");
  scripts\sp\utility::_id_10350("yard_eth_captainhitthese");
}

_id_677F(var_0) {
  level.player endon("player_suicided_drone");
  var_1 = gettime() + var_0 * 1000;
  setomnvar("ui_hack_control_signal_failing", 1);

  while(gettime() < var_1) {
    wait(randomfloatrange(0.1, 0.2));
    _id_D293(1, 1);
    wait(randomfloatrange(0.1, 0.3));
    _id_D293(0, 1);
  }

  for(;;) {
    _id_D293(1, 1);
    wait(randomfloatrange(0.2, 0.35));
    _id_D293(0, 1);
    wait(randomfloatrange(1, 3));
  }
}

_id_52A2(var_0, var_1, var_2) {
  var_3 = level._id_DF32;
  level waittill("core_zap");
  level waittill("core_zap");
  level waittill("core_zap");
  _id_10209(var_3.origin, var_2.origin + (0, 0, 40));
  level.player dodamage(50, var_3.origin);
}

_id_10209(var_0, var_1) {
  var_1 = var_1 + (0, 0, 25);
  var_2 = vectorNormalize(var_1 - var_0);
  var_3 = vectortoangles(var_2);
  playfxbetweenpoints(scripts\engine\utility::getfx("vfx_power_relay_zap"), var_0, var_3, var_1, level.player);
}

_id_DF36(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 rotatepitch(var_2, var_3, 0, var_4);
  var_1 rotatepitch(-1 * var_2, var_3, 0, var_4);
  var_1 playSound(var_5);
}

_id_DF37() {
  var_0 = "scn_escape_dock_clamp_release";
  var_1 = 1.5;
  var_2 = 0.5;
  var_3 = 0.333;
  var_4 = getEnt("clamp_pivot_01", "targetname");
  var_5 = getEnt("clamp_pivot_02", "targetname");
  var_6 = getEnt("clamp_pivot_03", "targetname");
  var_7 = getEnt("clamp_pivot_04", "targetname");
  var_8 = getEnt("clamp_pivot_05", "targetname");
  var_9 = getEnt("clamp_pivot_06", "targetname");
  var_4 _id_AD03();
  var_5 _id_AD03();
  var_6 _id_AD03();
  var_7 _id_AD03();
  var_8 _id_AD03();
  var_9 _id_AD03();
  wait 0.666667;
  thread _id_DF36(var_4, var_5, 30, var_1, var_2, var_0);
  wait(var_3);
  thread _id_DF36(var_6, var_7, 30, var_1, var_2, var_0);
  wait(var_3);
  thread _id_DF36(var_8, var_9, 30, var_1, var_2, var_0);
}

_id_AD03() {
  var_0 = scripts\sp\utility::_id_7A8F();

  foreach(var_2 in var_0) {
    var_2 linkTo(self);
  }
}

_id_10BDE() {
  scripts\engine\utility::flag_set("yard_start_objectives");
  scripts\engine\utility::flag_set("yard_obj_ambush_done");
  scripts\engine\utility::flag_set("yard_obj_locate_command_done");
  scripts\engine\utility::flag_set("yard_obj_activate_controls_done");
  scripts\engine\utility::flag_set("yard_obj_hack_ethan_done");
  _id_3BE5();
  _id_0F35::main();
  scripts\sp\maps\yard\yard_audio::_id_25EE("central_escape", "start");
  var_0 = getEnt("lift_light", "targetname");

  if(isDefined(var_0)) {
    var_0 delete();
  }

  scripts\sp\maps\yard\yard_util::_id_106D9("org_ethan_hack");
  scripts\sp\maps\yard\yard_util::_id_107BE("org_salter_ship");
  thread _id_8E71();
  level._id_66C4 = scripts\engine\utility::getStruct("org_escape", "targetname") scripts\engine\utility::spawn_tag_origin();
  level.player scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("continue_central_hack_ethan_player", "targetname"));
  thread _id_8E78();
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_jump(0);
  level.player scripts\engine\utility::allow_doublejump(0);
  level.player scripts\engine\utility::allow_sprint(0);
}

_id_B1A0() {
  if(getdvarint("new_ending")) {
    scripts\sp\maps\yard\yard_ending::_id_B1DA();
    return;
  }

  scripts\sp\utility::_id_2669("central_escape");
  scripts\sp\maps\yard\yard_audio::_id_25EE("central_escape", "main");
  thread _id_3BDC();
  thread _id_62F2();
  clearallcorpses();
  wait 1;
  thread scripts\sp\utility::_id_1264E("yard_base_tr");
  wait 1;
  thread _id_D842();
  level waittill("player_landed");
  scripts\engine\utility::flag_wait("central_escape_end");
  scripts\sp\utility::_id_BF95();
}

_id_3B49() {
  scripts\sp\maps\yard\yard_audio::_id_25EE("central_escape", "catchup");
}

_id_3BDC() {
  thread _id_6445();
  thread _id_66D5();
  thread _id_87A3();
  thread scripts\sp\maps\yard\yard_audio::_id_2585();
  thread _id_EAD7();
  thread _id_8AEB(12);
  level._id_EAD6 _id_F5E7();
  _id_111B1();
  scripts\engine\utility::flag_set("central_escape_end");
}

_id_8AEB(var_0) {
  wait(var_0);
  var_1 = scripts\engine\utility::getStruct("happy_missile_start_spot", "targetname");
  var_2 = scripts\engine\utility::getStruct("happy_missile_end_spot", "targetname");
  var_3 = scripts\engine\utility::getStruct("happy_missile_goal_1", "targetname");
  var_4 = scripts\engine\utility::getStruct("happy_missile_goal_2", "targetname");
  var_5 = scripts\engine\utility::getStruct("happy_missile_goal_3", "targetname");
  wait 0.75;
  var_6 = magicbullet("spaceship_homing_missile_yard", var_1.origin, var_2.origin);
  var_6 thread scripts\sp\maps\yard\yard_audio::_id_25AB(var_1.origin, var_2.origin);
  var_6 thread _id_8AED(var_4, 3);
  var_6 thread _id_516F(6);
  wait 3.25;
  var_7 = magicbullet("spaceship_homing_missile_yard", var_1.origin, var_4.origin);
  var_7 thread scripts\sp\maps\yard\yard_audio::_id_25AB(var_1.origin, var_4.origin);
  var_7 thread _id_8AED(var_5, 3);
  var_7 thread _id_516F(6);
}

_id_516F(var_0) {
  wait(var_0);

  if(isDefined(self)) {
    self delete();
  }
}

_id_8AED(var_0, var_1) {
  wait(var_1);
  _id_8AEC(var_0.origin);
  level.player playRumbleOnEntity("artillery_rumble");
}

_id_8AEC(var_0) {
  self endon("death");
  self endon("deleted");
  var_1 = 0.5;
  var_2 = 0.1;
  var_3 = 320;
  var_4 = -500;
  var_5 = 2500;
  wait(var_1);
  var_6 = 25000000;
  var_7 = var_5 * var_5;
  var_8 = (0, 0, var_4);
  var_9 = -1 * var_3;

  while(isDefined(self)) {
    var_10 = randomfloatrange(var_9, var_3);
    var_11 = randomfloatrange(var_9, var_3);
    var_12 = randomfloatrange(var_9, var_3);
    var_13 = var_0 + (var_10, var_11, var_12);
    self missile_settargetpos(var_13);
    wait(var_2);
  }
}

_id_EAD7() {
  wait 0.5;
  level._id_EAD6 notify("show_hull");
  level._id_EAD6._id_B904 = "veh_mil_air_ca_destroyer";
  level._id_EAD6 thread _id_0B53::_id_B909();
  level._id_EAD6 setCanDamage(1);
}

_id_CFD3() {
  var_0 = scripts\sp\player_rig::get_player_score();
  var_0 show();
  level.player _meth_823B(var_0, "tag_player");
  level.player disableweapons();
  scripts\engine\utility::delaythread(3, ::_id_441C, 3);
  level._id_66C4 = scripts\engine\utility::getStruct("org_escape", "targetname");
  level._id_66C4 notify("stop_loop");
  level._id_D267 thread _id_3BE7();
  level notify("escape_player_signaled");
  level._id_D267 thread scripts\sp\maps\yard\yard_fx::_id_132FC();
  level._id_66C4 scripts\sp\anim::_id_1F35(level._id_D267, "escape_button_press");
  level.player unlink();
  var_1 = scripts\engine\utility::getStruct("continue_central_hack_ethan_player", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  level.player scripts\sp\utility::_id_F526("relaxed");
  level.player scripts\sp\utility::_id_2B76(0.8, 0.2);
  level.player scripts\engine\utility::delaycall(1, ::_meth_80D8, 0.7, 0.7);
  level._id_D267 hide();
  level.player unlink();
  level.player enableweapons();
  level.player showviewmodel();
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_jump(1);
  level.player scripts\engine\utility::allow_doublejump(1);
  level.player scripts\engine\utility::allow_sprint(1);
  wait 0.5;
  scripts\sp\utility::_id_10350("yard_slt_godspeedcaptain");
}

_id_66D5() {
  wait 3;
  scripts\engine\utility::flag_set("stolen_destroyer_leave");
}

_id_111B1() {
  var_0 = scripts\sp\player_rig::get_player_score();
  scripts\engine\utility::delaythread(15, ::_id_441C, 5);
  level._id_66C4 = scripts\engine\utility::getStruct("org_escape", "targetname");
  level._id_66C4 notify("stop_loop");
  level._id_D267 thread _id_3BE7();
  level notify("escape_player_signaled");
  level._id_D267 thread scripts\sp\maps\yard\yard_fx::_id_132FC();
  level._id_D267 thread _id_3BE4();
  level._id_66C4 scripts\sp\anim::_id_1EC3(level._id_D267, "escape_button_press");
  scripts\engine\utility::waitframe();
  level.player _meth_823B(var_0, "tag_player");
  level.player disableweapons();
  var_0 show();
  scripts\engine\utility::waitframe();
  level.player playerlinktodelta(var_0, "tag_player", 1, 20, 20, 10, 10);
  level._id_66C4 scripts\sp\anim::_id_1F35(level._id_D267, "escape_button_press");
  var_1 = scripts\engine\utility::getStruct("anim_node_end_halfway", "targetname");
  var_2 = scripts\sp\utility::_id_10639("debris");
  var_1 scripts\sp\anim::_id_1EC3(var_2, "escape_suck_out");
  var_1 scripts\sp\anim::_id_1EC3(level._id_D267, "escape_suck_out");
  scripts\engine\utility::waitframe();
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("debris_exterior_damaged_metal_panels_08_scl50");
  var_3.origin = var_2 gettagorigin("tag_origin");
  var_3.angles = var_2 gettagangles("tag_origin");
  var_3 linkTo(var_2);
  level._id_D267 thread _id_8DDC("model", 1);
  level._id_66C4 notify("stop_loop");
  level._id_D267 show();
  level.player _meth_823B(level._id_D267, "tag_player");
  level.player _meth_818A();
  var_1 thread scripts\sp\anim::_id_1F35(level._id_D267, "escape_suck_out");
  var_1 thread scripts\sp\anim::_id_1F35(var_2, "escape_suck_out");
  thread _id_13E3A();
  level.player thread _id_13E39();
  _id_0F35::_id_FB24(1, level.player);
  _id_0F35::_id_FB25(1, 0);
  _id_13E36(level.player, level._id_D267, 0.001, 7, 0);
  thread _id_100D2();
  level.player playgestureviewmodel("ges_yard_flailing_loop");
  setsaveddvar("grapple_max_distance", 10000);
  setsaveddvar("spaceJumpSpeed", 2000);
  thread _id_FD4B();
  thread _id_13E3C("end_scene_grapple");
  thread scripts\sp\utility::_id_56BE("player_escape", 5);
  var_1 = scripts\engine\utility::getStruct("anim_node_end_halfway", "targetname");
  var_1 scripts\sp\anim::_id_1EC3(level._id_D267, "escape_landing");
  level.player showviewmodel();
  thread _id_13E3F(8);
  level.player waittill("spacejump_land");
  var_3 unlink();
  var_3 delete();
  var_2 delete();
  thread _id_13E33();
  level notify("player_landed");
  level.player _meth_8497(1);
  level.player _meth_8502();
  level.player _meth_823C(level._id_D267, "tag_player", 0.05);
  level.player _meth_818A();
  level.player setblurforplayer(15, 0.05);
  level.player playRumbleOnEntity("damage_heavy");
  level._id_D267 show();
  level.player _meth_823B(level._id_D267, "tag_player");
  level.player setblurforplayer(0, 1.75);
  var_1 scripts\sp\anim::_id_1F35(level._id_D267, "escape_landing");
  wait 4.5;
}

_id_EA8C(var_0) {
  wait(var_0);
  level._id_EAD6 _id_0BB8::_id_3991();
}

_id_13E39() {
  thread scripts\sp\maps\yard\yard_audio::_id_2609();
  screenshake(self.origin, 2, 1.5, 0, 2, 0.01, 1, 0, 15, 15, 0);
  scripts\engine\utility::exploder("vfx_cmd_breach");
  thread _id_13D67();
  wait 0.1;
  scripts\engine\utility::exploder("vfx_cmd_breach_side");
}

_id_13E3A() {
  wait 2.5;
  level.player enableweapons();
}

_id_FD4B() {
  scripts\sp\utility::_id_10350("yard_slt_spoolupyouregoforjump");
  wait 1;
  wait 2;
  scripts\sp\utility::_id_10350("yard_kls_threetwoone");
  scripts\sp\utility::_id_10350("yard_slt_drop");
}

_id_8499() {
  scripts\engine\utility::flag_wait("flag_ship_fail");
  return 1;
}

_id_13E3F(var_0) {
  level endon("player_landed");
  scripts\engine\utility::flag_wait_or_timeout("flag_ship_fail", var_0);
  level.player _meth_81D0();
}

_id_13D67() {
  var_0 = getEnt("command_window_broken", "targetname");
  var_1 = getEnt("command_window_clean", "targetname");
  var_0 show();
  var_1 hide();
  var_2 = getEntArray("barriers_destroyed_01", "targetname");
  var_3 = getEntArray("barriers_clean_01", "targetname");
  var_4 = getEntArray("command_window_cracks", "targetname");
  var_5 = getEntArray("yard_debris_field", "targetname");

  foreach(var_7 in var_2) {
    var_7 show();
  }

  foreach(var_7 in var_3) {
    var_7 hide();
  }

  foreach(var_12 in var_4) {
    var_12 show();
  }

  foreach(var_15 in var_5) {
    var_15 show();
  }

  var_17 = getEntArray("yard_debris_field_spinny", "script_noteworthy");

  foreach(var_19 in var_17) {
    var_19 thread _id_4E9A();
  }
}

_id_100D2() {
  var_0 = getEntArray("control_room_vista_dome_01", "targetname");

  if(isDefined(var_0) && var_0.size) {
    foreach(var_2 in var_0) {
      var_2 show();
    }
  }
}

_id_4E9A() {
  level endon("player_landed");
  var_0 = 1;

  if(isDefined(self.script_parameters)) {
    var_0 = float(self.script_parameters);
  }

  var_1 = 8;

  for(;;) {
    var_2 = 1.0;

    if(isDefined(self)) {
      self rotatepitch(var_1 * var_0, var_2, 0, 0);
    }

    wait(var_2);
  }
}

_id_84A0() {
  var_0 = scripts\engine\utility::getStruct("end_scene_boom_node_start", "targetname");
  playFX(level._effect["vfx_jackal_death_01_zerog"], var_0.origin);
  thread scripts\engine\utility::play_sound_in_space("space_explosion", var_0.origin);
  earthquake(0.3, 0.5, level.player.origin, 256);
  wait 0.5;
  _id_8495(var_0, 0.5);
}

_id_8495(var_0, var_1) {
  if(isDefined(var_0.target)) {
    var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");
    playFX(level._effect["vfx_jackal_death_01_zerog"], var_2.origin);
    thread scripts\engine\utility::play_sound_in_space("space_explosion", var_2.origin);
    earthquake(0.3, 0.5, level.player.origin, 256);
    wait(var_1);
    _id_8495(var_2, var_1);
  } else
    return;
}

_id_87A9(var_0, var_1) {
  self._id_848F = [];
  self._id_848F["model_rope_fire"] = _id_10908("grapple_rope");
  self._id_848F["model_rope_fire"] _meth_81E4(self, "j_wrist_le", (0, 0, 0), (0, 180, 0), 1, 1, 1, 0, "none");

  if(isDefined(var_1)) {
    self._id_848F["model_rope_fire"] _meth_850D(var_1);
  } else {
    self._id_848F["model_rope_fire"] _meth_850D(var_0);
  }

  self._id_848F["model_rope_idle"] = _id_10908("grapple_rope_stretch");
}

_id_10908(var_0) {
  var_1 = scripts\sp\utility::_id_10639(var_0, (0, 0, 0));
  var_1 notsolid();
  var_1 setcontents(0);
  var_1 hide();
  return var_1;
}

_id_3BE4() {
  self waittillmatch("single anim", "salter_fire");
  scripts\engine\utility::flag_set("central_light_it_up");
  var_0 = scripts\engine\utility::getStructArray("salter_target_00", "targetname");
  var_1 = scripts\engine\utility::getStructArray("salter_target_01", "targetname");
  var_2 = scripts\engine\utility::getStructArray("salter_target_02", "targetname");
  level.missiles = 0;
  level._id_B8AD = [];
  level._id_EAD6 _id_129C6(var_0);
  level._id_EAD6 _id_129C6(var_1);
  level._id_EAD6 _id_129C6(var_2);
  self waittillmatch("single anim", "end");
  scripts\engine\utility::flag_set("yard_throw_player_back");
}

_id_679A() {
  stopcinematicingame();
  scripts\engine\utility::waitframe();
  setsaveddvar("bg_cinematicfullscreen", 0);
  cinematicingameloopresident("yard_pod_bay_idle_screens");
  scripts\engine\utility::flag_wait("flag_core_enter");
  stopcinematicingame();
}

_id_3BE7() {
  self waittillmatch("single anim", "start_bink");
  var_0 = (39.5, 25407, 1990);
  thread scripts\sp\maps\yard\yard_audio::_id_258B(var_0);
  setsaveddvar("bg_cinematicfullscreen", 0);
  cinematicingame("yard_command_end");
  _id_DF37();
}

_id_87EA() {
  var_0 = (39.5, 25407, 1990);
  thread scripts\sp\maps\yard\yard_audio::_id_258B(var_0);
  setsaveddvar("bg_cinematicfullscreen", 0);
  cinematicingame("yard_command_hack");
  wait 3;
  pausecinematicingame(1);
  wait 1.05;
  pausecinematicingame(0);
}

_id_13E3C(var_0, var_1) {
  self notify("setup_fake_grapple_point");
  self endon("setup_fake_grapple_point");
  var_2 = getEnt(var_0, "targetname");
  var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin);
  level.player _meth_8503("ges_yard_grapple_shoot", "ges_yard_grapple_shoot", level._id_10533, level._id_10532);
  level.player _meth_8501(var_3);

  for(;;) {
    level.player waittill("spacejump_takeoff", var_4, var_5, var_6, var_7, var_8);
    break;
  }
}

_id_13E36(var_0, var_1, var_2, var_3, var_4) {
  var_0 _meth_8239(1);

  if(isDefined(var_4) && !var_4) {
    if(isDefined(var_3)) {
      wait(var_3);
    } else {
      wait 5;
    }

    level.player unlink();
    var_1 hide();
  } else
    var_1 waittillmatch("single anim", "end");

  var_5 = var_0 getvelocity();
  var_6 = vectorNormalize(var_5);
  var_7 = length(var_5);

  if(!isDefined(var_2)) {
    var_2 = 200;
  }

  var_8 = var_7 / var_2;
  var_9 = var_8;
  var_10 = var_7 * var_9 * 0.5;
  var_11 = var_0.origin + var_10 * var_6;
  var_6 = vectorNormalize(var_11 - var_0.origin);
  var_0 unlink();
  var_0 setvelocity(var_6 / var_2);
}

_id_88B2() {
  _id_12975();
  wait 2;
  _id_12994();
}

_id_12975() {
  setsaveddvar("bg_viewBobAmplitudeStanding", 0.0);
  setsaveddvar("bg_weaponBobAmplitudeStanding", 0.0);
}

_id_12994() {
  setsaveddvar("bg_viewBobAmplitudeStanding", 0.007);
  setsaveddvar("bg_weaponBobAmplitudeStanding", 0.007);
}

_id_13E34() {
  scripts\sp\maps\yard\yard_util::_id_40BB("vol_ethan_rss_1");
  scripts\sp\maps\yard\yard_util::_id_40BB("vol_ethan_rss_2");
  scripts\sp\maps\yard\yard_util::_id_40BB("vol_ethan_rss_3");
  scripts\sp\maps\yard\yard_util::_id_40BB("vol_ethan_rss_4");
  scripts\sp\maps\yard\yard_util::_id_40BB("vol_rss_command_00");
  scripts\sp\maps\yard\yard_util::_id_40BB("vol_rss_command_01");
}

_id_5EFC(var_0) {
  self endon("death");
  self endon("deleted");
  var_1 = 0.5;
  var_2 = 0.1;
  var_3 = 320;
  var_4 = -500;
  var_5 = 2500;
  wait(var_1);
  var_6 = 25000000;
  var_7 = var_5 * var_5;
  var_8 = (0, 0, var_4);
  var_9 = -1 * var_3;

  while(isDefined(self) && var_6 > var_7) {
    var_10 = randomfloatrange(var_9, var_3);
    var_11 = randomfloatrange(var_9, var_3);
    var_12 = randomfloatrange(var_9, var_3);
    var_13 = var_0 + (var_10, var_11, var_12);
    self missile_settargetpos(var_13);
    var_6 = scripts\engine\utility::distance_2d_squared(self.origin, var_0);
    wait(var_2);
  }

  if(isDefined(self)) {
    self missile_settargetpos(var_0 + var_8);
  }
}

_id_6CF4(var_0, var_1, var_2) {
  var_3 = magicbullet("spaceship_homing_missile_yard", var_0, var_1, level.player);
  var_3 thread scripts\sp\maps\yard\yard_audio::_id_25AB(var_0, var_1, var_2);
  var_3 thread _id_5EFC(var_1);
  var_3 thread _id_B81D();
}

_id_B81D() {
  scripts\engine\utility::waittill_any("damage", "destroyed", "death");
  level notify("salter_missile_hit");
}

_id_8E78() {
  var_0 = getEnt("control_front_screen_dest_1", "targetname");
  var_1 = getEnt("control_front_screen_dest_2", "targetname");
  var_2 = getEnt("control_front_screen_dest_3", "targetname");
  var_0 hide();
  var_1 hide();
  var_2 hide();
}

_id_1130B() {
  var_0 = getEnt("control_front_screen_dest_1", "targetname");
  var_1 = getEnt("control_front_screen_dest_2", "targetname");
  var_2 = getEnt("control_front_screen_dest_3", "targetname");
  var_3 = getEntArray("control_front_screen_new_1", "targetname");
  var_4 = getEnt("control_front_screen_new_2", "targetname");
  var_5 = getEnt("control_front_screen_new_3", "targetname");
}

_id_8DDC(var_0, var_1) {
  self waittillmatch("single anim", "cracked_screen");
  thread _id_100F9();
  scripts\engine\utility::flag_set("end_scene_player_unlink");
  _id_0E4B::_id_8E06();

  if(scripts\sp\utility::_id_93A6()) {
    level._id_10964.helmet attach("vm_hero_protagonist_helmet_glass_crack_04", "tag_origin");
  } else {
    level.player.helmet attach("vm_hero_protagonist_helmet_glass_crack_04", "tag_origin");
  }
}

_id_100F9() {
  var_0 = getEntArray("salter_deck_geo", "targetname");

  foreach(var_2 in var_0) {
    var_2 show();
  }

  var_4 = getEntArray("salter_deck_models", "targetname");

  foreach(var_6 in var_4) {
    var_6 show();
  }
}

_id_13E33() {
  scripts\engine\utility::flag_set("remove_enemy_ships");
  thread _id_13E32();
  thread _id_13E31();
  thread _id_13E30();
}

_id_13E2F() {
  var_0 = getEntArray("yard_end_door_cleanup", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 delete();
  }

  var_0 = getEntArray("yard_end_door_cleanup", "script_parameters");

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

_id_13E35() {
  var_0 = getEntArray("yard_end_server_cleanup", "script_parameters");

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

_id_13E32() {
  var_0 = getEntArray("phys_battery_destructible", "targetname");

  foreach(var_2 in var_0) {
    var_2 delete();
  }

  var_4 = getEntArray("phys_antigrav_destructible", "targetname");

  foreach(var_2 in var_4) {
    var_2 delete();
  }

  var_7 = getEntArray("phys_barrel_destructible", "targetname");

  foreach(var_2 in var_7) {
    var_2 delete();
  }
}

_id_13E31() {
  var_0 = getEntArray("central_elevator_model", "targetname");

  foreach(var_2 in var_0) {
    var_2 unlink();
    var_2 delete();
  }

  var_4 = getEntArray("central_elevator_model_pieces", "targetname");

  foreach(var_6 in var_4) {
    var_6 unlink();
    var_6 delete();
  }
}

_id_13E30() {
  var_0 = getEnt("robo_1", "targetname");
  var_0 delete();
}

_id_13E37() {
  var_0 = level._id_EAD6 scripts\engine\utility::spawn_tag_origin();
  var_0.origin = var_0.origin + anglesToForward(level._id_EAD6.angles) * 13000;
  var_0 linkTo(level._id_EAD6);
  var_1 = 1;
  screenshake(level.player.origin, 0.2, 0.2, 0.2, var_1, -1, 0, 0, 12, 12, 12);
  visionsetalternate(1, var_1);
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_06_center_energy_point_a_startup"), var_0, "tag_origin");
  scripts\engine\utility::noself_delaycall(1, ::playfxontag, scripts\engine\utility::getfx("vfx_veh_retr_ftl_05_dialation_sphere_a_startup"), var_0, "tag_origin");
  level notify("jump_started");
  var_2 = getDvar("r_mbRadialOverridePosition");
  var_3 = getDvar("r_mbRadialOverrideAngleAttenuation");
  var_4 = getDvar("r_mbRadialOverrideRadius");
  var_5 = getDvar("r_mbRadialOverrideFocusDir");
  level thread _id_13E3D();
  screenshake(level.player.origin, 1.5, 1.5, 1.5, 0.5, 0, 0, 0, 16, 16, 16);
  level.player _meth_81DE(30, 0.1);
  level.player scripts\engine\utility::delaycall(0.15, ::_meth_81DE, 65, 0.1);
  visionsetalternate(3, 0);
  scripts\engine\utility::noself_delaycall(0.25, ::visionsetalternate, 2, 0.5);
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_05_dialation_sphere_b_travel"), var_0, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_06_center_energy_point_b_travel"), var_0, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_08_sparks_b_travel"), var_0, "tag_origin");
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_05_dialation_sphere_a_startup"), var_0, "tag_origin");
  killfxontag(scripts\engine\utility::getfx("vfx_veh_retr_ftl_06_center_energy_point_a_startup"), var_0, "tag_origin");
  scripts\engine\utility::noself_delaycall(1.5, ::visionsetalternate, 3, 1);
}

_id_13E41(var_0, var_1) {
  var_2 = spawnStruct();

  if(!isDefined(var_2._id_111D7)) {
    var_2._id_111D7 = getmapsuncolorandintensity()[3];
  }

  var_3 = var_1 / 0.05;
  var_4 = var_0 - var_2._id_111D7;
  var_5 = var_4 / var_3;

  for(var_6 = 0; var_6 < var_3; var_6++) {
    setsuncolorandintensity(var_2._id_111D7 + var_5);

    if(var_3 == 1) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  var_2._id_111D7 = var_0;
}

_id_13E3D() {
  level endon("stop_ftl_aberration");
  var_0 = anglesToForward(level._id_EAD6.angles) * 5000;
  setsaveddvar("r_mbRadialOverrideChromaticAberration", 0.9);
  setsaveddvar("r_mbRadialOverridePosition", var_0);
  setsaveddvar("r_mbRadialOverridePositionActive", 1);
  setsaveddvar("r_mbRadialOverrideRadius", -0.2);
  setsaveddvar("r_mbRadialOverrideFocusDir", 0.2);
  setsaveddvar("r_mbRadialOverrideAngleAttenuation", 0.1);
  setsaveddvar("r_mbradialoverridestrength", 0.0);
  setsaveddvar("r_mbradialoverridedistortion", 0.05);
  thread scripts\sp\utility::_id_AB9A("r_mbradialoverridedistortion", 0.025, 0.1);
  scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", 0.015, 0.1);

  for(;;) {
    var_1 = randomfloatrange(0.05, 0.1);
    var_2 = randomfloatrange(0.005, 0.02);
    thread scripts\sp\utility::_id_AB9A("r_mbradialoverridedistortion", var_2 * 2, var_1);
    scripts\sp\utility::_id_AB9A("r_mbradialoverridestrength", var_2, var_1);
  }
}

_id_13E3E() {
  level endon("ftl_stop");
  var_0 = getEntArray("lgt_ftl_whitescroll", "script_noteworthy");

  if(var_0.size == 0) {
    return;
  }
  foreach(var_2 in var_0) {
    var_2.og_origin = var_2.origin;
    var_2._id_BC4A = var_2.origin + (-1800, 0, 0);
  }

  var_4 = 0.6;

  for(;;) {
    foreach(var_2 in var_0) {
      var_2 setlightintensity(400);
      var_2 moveTo(var_2._id_BC4A, var_4);
    }

    wait(var_4);

    foreach(var_2 in var_0) {
      var_2 setlightintensity(0);
      var_2 moveTo(var_2.og_origin, 0.01);
    }

    wait(var_4);
  }
}

_id_DC6C() {
  wait 3;
  var_0 = scripts\engine\utility::getStruct("happy_missile_start_spot", "targetname");
  var_1 = scripts\engine\utility::getStruct("happy_missile_end_spot", "targetname");

  for(;;) {
    magicbullet("cap_turret_phalanx", var_0.origin, var_1.origin);
    wait 1;
  }
}

_id_F5E7() {
  level._id_6B07 = [];
  var_0 = "amb_turret_sml_r_ts_6";
  var_1 = self gettagorigin(var_0);
  var_1 = var_1 + anglestoup(self gettagangles(var_0)) * 200;

  for(var_2 = 0; var_2 < 7; var_2++) {
    var_3 = spawn("script_origin", var_1);
    var_3 linkTo(self);
    level._id_6B07[level._id_6B07.size] = var_3;
    var_4 = anglestoright(self gettagangles(var_0));
    var_1 = var_1 + var_4 * 150;
  }
}

_id_62F2() {
  scripts\engine\utility::flag_wait("end_scene_player_unlink");
  thread scripts\sp\utility::_id_1264E("yard_central_tr");
  scripts\engine\utility::flag_wait("central_escape_end");
  thread scripts\sp\utility::_id_1264E("yard_vista_tr");
}

_id_D842() {
  level._id_D267 waittillmatch("single anim", "start_bink");
  level thread scripts\sp\utility::_id_BF97();
  scripts\engine\utility::flag_wait("end_scene_player_unlink");
}