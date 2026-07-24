/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\control_room.gsc
**************************************************/

_id_45BC() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("control_room_start_player");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("control_room_start");
  scripts\sp\utility::_id_15F5("control_room_jumpto_trig");
  scripts\engine\utility::flag_set("player_is_inside");
  scripts\engine\utility::flag_set("sun_safe_zone");
  scripts\engine\utility::flag_set("start_control_vo");
}

_id_F0D1() {}

_id_F0CB() {
  scripts\engine\utility::flag_init("seal_ctrl_airlock");
  scripts\engine\utility::flag_init("ctrl_room_done");
  scripts\engine\utility::flag_init("flag_command_kill_rocks");
  scripts\engine\utility::flag_init("start_control_vo");
  scripts\engine\utility::flag_init("control_cam_effects_go");
  scripts\engine\utility::flag_init("objective_control");
}

_id_F0D2() {}

_id_3B50() {
  scripts\engine\utility::flag_set("objective_control");

  foreach(var_1 in level.allies) {
    var_1.disableplayeradsloscheck = 1;
  }
}

_id_45B6() {
  thread full_time_clip();
  thread _id_F920();
  scripts\engine\utility::flag_set("disable_sun_logic");
  scripts\engine\utility::flag_clear("sun_vision_blend");
  scripts\sp\maps\rogue\rogue_util::_id_11206(1);
  scripts\engine\utility::flag_set("player_is_inside");
  scripts\engine\utility::flag_set("flag_lgt_control_room_start");
  scripts\engine\utility::flag_set("interior_quakes");
  setmusicstate("");
  var_0 = _id_0B1E::_id_794D("depot_airlock_door");
  thread _id_0B1F::_id_1AD8("depot_entrance_airlock", 1, var_0);
  thread _id_3B50();
  var_1 = scripts\sp\maps\rogue\rogue_util::_id_F943("canyon_airlock_door");
  var_2 = getEnt("cr_exit_clip", "targetname");
  var_2 linkTo(var_1);
  var_2 connectpaths();
  var_1 rotateYaw(-120, 0.05, 0, 0);
  var_2 scripts\engine\utility::delaycall(1, ::disconnectpaths);
  scripts\sp\maps\rogue\rogue_util::_id_111E9(1);
  _id_9820();
  thread _id_45B7();
  setglobalsoundcontext("atmosphere", "helmet", 1);
  _id_45B2();
  _id_45B8();
  level._id_10AC8 = scripts\engine\utility::array_remove(level._id_10AC8, level._id_13E12);
  _id_F0CA();
}

full_time_clip() {
  var_0 = getEnt("control_airlock_player_fulltime_clip", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0 notsolid();
  level waittill("scene_started");
  var_0 solid();
}

_id_45B7() {
  level endon("scene_started");
  scripts\engine\utility::flag_wait("start_control_vo");
  scripts\engine\utility::flag_clear("combat_section_active");
  wait 1;
  level._id_B33E scripts\sp\utility::_id_10346("rogue_ksh_thinkthatwasall");
  level._id_B33B scripts\sp\utility::_id_10346("rogue_brk_werenotwaitinar");
  thread _id_C852();
  wait 5;
  level._id_B33E thread scripts\sp\utility::_id_10346("asteroid_ksh_thisiscrazy");
  level waittill("door_peek_blend_complete");
  level._id_B33E scripts\sp\utility::_id_10346("rogue_ksh_controlcentersonthe");
}

_id_C852() {
  thread scripts\engine\utility::play_sound_in_space("asteroid_anc_lockdownmodeinitiated_r", level.player.origin);
  wait(lookupsoundlength("asteroid_anc_lockdownmodeinitiated_r") / 1000);
  thread scripts\engine\utility::play_sound_in_space("asteroid_anc_reporttothenearest_r", level.player.origin);
}

_id_9820() {
  foreach(var_1 in level._id_10AC8) {
    var_1 scripts\sp\utility::_id_61C7();
    var_1 scripts\sp\utility::_id_F3B5("g");
  }
}

_id_45B2() {
  var_0 = getEnt("control_room_animNode", "targetname");
  var_1 = getEnt("control_room_jumpto_trig", "targetname");
  var_1 waittill("trigger");
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12984);
  thread _id_DD07(var_0);

  foreach(var_3 in level._id_10AC8) {
    var_3 scripts\sp\utility::_id_5522();
  }

  thread scripts\sp\utility::_id_266F();
  thread _id_59E2();
  var_5 = getEnt("canyon_airlock_door", "targetname");
  var_6 = getEnt("cr_exit_clip", "targetname");
  var_6 linkTo(var_5);
}

_id_F920() {
  var_0 = getEnt("control_room_enter_door", "targetname");
  var_0 = scripts\sp\maps\rogue\rogue_util::_id_F943(var_0.targetname);
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.origin = var_0 gettagorigin("tag_origin");
  var_1.angles = var_0 gettagangles("tag_origin");
  var_1 scripts\sp\anim::_id_1EC3(var_0, "airlock_open_inside");
  wait 1;
  var_1 delete();
}

#using_animtree("script_model");

_id_59E2() {
  var_0 = getEnt("new_control_room_animNode", "targetname");
  var_1 = getEnt("control_room_enter_door", "targetname");
  var_1 _id_0E46::_id_48C4("tag_ui_front", (0, 0, 0));
  var_1 waittill("trigger");
  thread scripts\sp\maps\rogue\rogue_util::remove_navigating_equipment();
  level notify("scene_started");
  thread _id_10174();
  var_1.clip = var_1 scripts\engine\utility::get_target_ent();
  var_1.clip linkTo(var_1, "door_JNT");
  thread scripts\sp\maps\rogue\rogue_util::_id_D214(var_1, 1);
  wait 3;
  level notify("nearly_control_room_scene");
  wait 1;
  level notify("start_control_room_scene");
  var_2 = getEnt("player_cr_clip_blocker", "targetname");
  var_2.origin = var_2.origin - (0, 0, 150);
  var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  thread _id_3D98(var_3);
  var_4 = level scripts\engine\utility::waittill_any("player_not_near_door", "timeOut_set_door");
  var_5 = var_2.origin;
  var_6 = scripts\engine\utility::getStruct(var_3.target, "targetname");
  var_7 = 2;
  var_2 moveTo(var_3.origin, var_7 * 0.5, 0, 0);
  wait(var_7 * 0.5);
  var_1 playSound("airlock_entry_door_close");
  var_1 setanimknob(%airlock_open_door, 1, 0.2, -1);
  wait(getanimlength(%airlock_open_door) - 1.2);
  var_1 _meth_82B1(%airlock_open_door, 0);
  var_0 scripts\sp\anim::_id_1EC3(var_1, "control_room_scene");
  var_1 thread _id_BC23();
}

_id_10174() {
  var_0 = getEnt("cr_fake_airlock_door", "targetname");
  var_0.angles = (0, 210, 0);
  scripts\engine\utility::flag_set("flag_defend_cleanup");
  scripts\engine\utility::flag_wait("activate_peek_bots");
  var_0 delete();
}

_id_3D98(var_0) {
  level endon("timeOut_set_door");
  wait 2;
  var_1 = [level.player, level._id_B4F9, level._id_13E12, level._id_B33B, level._id_B33E];
  var_2 = 0;

  while(var_2 == 0) {
    var_2 = 1;

    foreach(var_4 in var_1) {
      if(distance2d(var_4.origin, var_0.origin) <= 75) {
        var_2 = 0;
        break;
      }
    }

    wait 0.1;
  }

  level notify("player_not_near_door");
}

_id_DD07(var_0, var_1) {
  foreach(var_3 in level._id_10AC8) {
    var_3 scripts\sp\utility::_id_54F7();
  }

  level._id_13E12 _meth_82EE(getnode("control_airlock_temp_node_salter", "targetname"));
  level._id_B4F9 _meth_82EE(getnode("control_airlock_temp_node_mco", "targetname"));
  level._id_B33B _meth_82EE(getnode("control_airlock_temp_node_marine_a", "targetname"));
  level._id_B33E _meth_82EE(getnode("control_airlock_temp_node_marine_b", "targetname"));
}

_id_45B8() {
  var_0 = getEnt("new_control_room_animNode", "targetname");
  var_1 = scripts\engine\utility::array_remove(level._id_10AC8, level._id_13E12);
  thread scripts\sp\maps\rogue\rogue_util::_id_75D5("rogue_world_civs_security_feed");
  level waittill("nearly_control_room_scene");
  var_2 = [1, 0.25, 0.09];
  level._id_111C3.light = 30 * vectorNormalize((var_2[0], var_2[1], var_2[2]));
  setsunlight(level._id_111C3.light[0], level._id_111C3.light[1], level._id_111C3.light[2]);
  level._id_111C3.ent linkTo(level._id_111C3._id_C6EA, "tag_origin", (17000, 40000, 0), (0, 0, 0));
  level._id_111C3._id_1EF6 linkTo(level._id_111C3._id_E6E5, "tag_origin", (0, 0, 0), (0, 0, 270));
  scripts\sp\maps\rogue\rogue_util::_id_111E7(4, 30, 30, 150, 230);
  scripts\engine\utility::flag_clear("sun_vision_blend");
  level waittill("start_control_room_scene");

  foreach(var_4 in level._id_10AC8) {
    thread scripts\sp\anim::_id_1F12(var_4);
  }

  level.player scripts\sp\utility::_id_F526("relaxed");
  level.player notify("kill_fspar_hint");
  level.player notify("shipping_cleanup");
  var_0 thread _id_13E14();
  var_1 = scripts\engine\utility::array_remove(level._id_10AC8, level._id_B4F9);

  foreach(var_4 in var_1) {
    var_0 thread scripts\sp\anim::_id_1F35(var_4, "control_room_scene");
  }

  var_0 scripts\sp\anim::_id_1F35(level._id_B4F9, "control_room_scene");
  scripts\engine\utility::flag_set("objective_control");
}

_id_BC23() {
  var_0 = getEnt("new_control_room_animNode", "targetname");
  var_1 = self;
  var_1._id_1FBB = "airlock_door";
  var_1 scripts\sp\anim::_id_F64A();
  level waittill("close_xo_airlock");
  var_1 scripts\engine\utility::delaycall(1.0, ::playsound, "airlock_exit_door_open");
  var_1 scripts\engine\utility::delaycall(5.0, ::playsound, "airlock_exit_door_close");
  var_0 scripts\sp\anim::_id_1F35(var_1, "control_room_scene");
  var_1 notify("closed");
}

_id_13E14() {
  scripts\sp\anim::_id_1F35(level._id_13E12, "control_room_scene");
}

_id_A5C1() {
  self endon("death");
  wait(randomfloatrange(1, 4));

  if(isalive(self)) {
    self _meth_81D0();
  }
}

_id_13727() {
  var_0 = _id_0B1E::_id_794D("depot_airlock_door");
  var_1 = getEnt("canyon_airlock_volume", "targetname");

  for(;;) {
    var_2 = 1;

    foreach(var_4 in level._id_10AC8) {
      if(distance2d(var_4.origin, var_0.origin) > 208) {
        var_2 = 0;
        break;
      }
    }

    if(level.player istouching(var_1) == 0) {
      var_2 = 0;
    }

    if(var_2 == 1) {
      break;
    }

    wait 0.25;
  }
}

_id_1166F() {
  level._id_B4F9 scripts\sp\utility::_id_10346("asteroid_usf_securitycontrol");
  level.player scripts\sp\utility::_id_10350("asteroid_plr_letsgetinside");
}

_id_F0CA() {
  scripts\sp\maps\rogue\rogue_util::_id_40BF();
}

_id_75D3() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("flag_lgt_control_room_start");

  for(;;) {
    scripts\engine\utility::exploder("contr_rocksleave_00");
    scripts\engine\utility::exploder("contr_rockscrash_00");

    if(scripts\engine\utility::flag("player_in_depot")) {
      return;
    }
    wait 14;
  }
}