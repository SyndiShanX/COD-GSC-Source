/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heistspace\heistspace_interior.gsc
**************************************************************/

_id_3B82() {
  scripts\engine\utility::flag_clear("player_on_bridge");
  level._id_B0D5 thread scripts\sp\maps\heistspace\heistspace_util::_id_AED6();
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_3B3C();
}

_id_BA93() {
  scripts\sp\maps\heistspace\heistspace_util::_id_10733(undefined, 1);
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_F5AF("jumpto_mons_halls", [level.player, level._id_EA2C]);
  level._id_C413 hide();
  scripts\engine\utility::flag_set("guns_down_vo_complete");
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_30C8();
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_7657();
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_25EC("jumpto_mons_halls");
  var_0 = getEnt("bridge_elevator_door_blocker", "targetname");

  if(isDefined(var_0)) {
    var_0 connectpaths();
    var_0 scripts\sp\utility::_id_8E9A();
  }

  scripts\engine\utility::delaythread(2.0, scripts\sp\maps\heistspace\heistspace_arrival::_id_30BF);
}

_id_BA90() {
  level thread _id_BA94();
  level thread _id_BAE6();
  level thread _id_BAE5();
  level thread _id_BA7A();
  level thread _id_BA77();
  level thread _id_BAE4();
  level thread _id_D6E4();
  level thread _id_51EF();
  level thread _id_88A7();
  scripts\engine\utility::flag_clear("player_on_bridge");
  scripts\sp\utility::_id_7413();
  level._id_DD6F thread _id_DD70();
  scripts\sp\utility::_id_22CA("c6_rss_spawner", ::_id_336C);
  level._id_886A = _id_0B6C::_id_FA2A("upper_hall_rss");
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D3(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B0(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132BB(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CC(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CB(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132C6(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D2(0);
  level._id_EA2C thread _id_BA92();
  scripts\engine\utility::flag_wait("flag_mons_nav_combat_start");
  var_0 = scripts\sp\utility::_id_107EA("injured_c6_1");
  var_0 thread scripts\sp\maps\heistspace\heistspace_fx::_id_132E5();
  var_0 thread _id_98ED("hall_injured_c6_1_pos", "c6_injured1", "hall_c6_injured1", "salter_start_traverse_anim");
  var_1 = scripts\sp\utility::_id_107EA("injured_c6_2");
  var_1 thread scripts\sp\maps\heistspace\heistspace_fx::_id_132E5();
  var_1 thread _id_98ED(undefined, "c6_injured2", "hall_c6_injured2", "salter_start_traverse_anim");
  var_2 = scripts\sp\utility::_id_107EA("injured_c6_3");
  var_2 thread scripts\sp\maps\heistspace\heistspace_fx::_id_132E5();
  var_2 thread _id_98ED(undefined, "c6_injured3", "hall_c6_injured3", "salter_start_traverse_anim");
  scripts\sp\utility::_id_2669("heistspace_halls_done");
  thread scripts\sp\utility::_id_12641("heistspace_om_ordnance_tr");
}

_id_BA77() {
  level._id_2BDC = _id_BA5B();
  level._id_B0D5 thread scripts\sp\maps\heistspace\heistspace_util::_id_AED6();
  scripts\engine\utility::flag_wait_all("elevator_can_move", "salter_elevator_ready");
  level notify("end_random_jackal_deployments");
  level notify("end_gambit_weapon_pickup");
  scripts\sp\utility::_id_2669("heistspace_elevator_start");
  var_0 = getEnt("hall_elevator_volume", "targetname");

  for(;;) {
    if(level.player istouching(var_0)) {
      break;
    }

    wait 0.5;
  }

  level._id_C413 hide();

  if(isDefined(level._id_C41A) && isDefined(level._id_C41A._id_A35B) && isDefined(level._id_C41A._id_A35B.littoral_ship_lights)) {
    foreach(var_2 in level._id_C41A._id_A35B.littoral_ship_lights) {
      if(isDefined(var_2) && isalive(var_2)) {
        var_2 delete();
      }
    }
  }

  level._id_C41A = undefined;
  level.player _meth_80A1();
  level.player thread mons_elevator_restore_grenades();
  var_4 = getEntArray("om_elevator_entry_rail", "targetname");
  var_5 = getEntArray("om_elevator_exit_rail", "targetname");

  foreach(var_7 in var_5) {
    var_7 linkTo(level._id_2BDC._id_C6EA);
  }

  foreach(var_7 in var_4) {
    var_7 moveTo(var_7.origin + (0, 0, 32), 3.5, 1, 1.5);
  }

  wait 3.5;

  foreach(var_7 in var_4) {
    var_7 linkTo(level._id_2BDC._id_C6EA);
  }

  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_BA79();
  var_13 = scripts\engine\utility::getStruct("fake_elevator_bottom", "targetname");
  level._id_2BDC._id_C6EA moveTo(var_13.origin, 8, 2, 2);
  level._id_B0D5 thread _id_606E();
  wait 4;
  var_14 = scripts\engine\utility::getStruct("om_leave_bridge_animnode", "targetname");
  var_14 notify("end_bridge_loop");

  if(isDefined(level._id_6754)) {
    level._id_6754 scripts\sp\utility::_id_1101B();
    level._id_6754 delete();
  }

  if(isDefined(level._id_30F6)) {
    level._id_30F6 scripts\sp\utility::_id_1101B();
    level._id_30F6 delete();
  }

  if(isDefined(level._id_A54E)) {
    level._id_A54E scripts\sp\utility::_id_1101B();
    level._id_A54E delete();
  }

  level._id_8E42 = scripts\engine\utility::array_removeundefined(level._id_8E42);
  scripts\sp\utility::_id_1264E("heistspace_om_bridge_tr");
  wait 4;
  level thread scripts\engine\utility::play_sound_in_space("elevator_gate_lower", (-69614, 14697, 2528));

  foreach(var_7 in var_5) {
    var_7 unlink();
    var_7 moveTo(var_7.origin + (0, 0, -32), 3.5, 1, 1.5);
  }

  wait 1.5;
  level._id_B0D5 thread scripts\sp\maps\heistspace\heistspace_util::_id_12BD3();
  scripts\engine\utility::flag_set("elevator_door_opening");
  wait 2.0;
  scripts\engine\utility::flag_set("elevator_done");
  scripts\sp\utility::_id_2669("heistspace_elevator_done");
}

_id_BA7A() {
  level._id_D267 = scripts\sp\utility::_id_10639("player_rig");
  level._id_D267 hide();
  var_0 = getEnt("elevator_animnode", "targetname");
  var_0 scripts\sp\anim::_id_1EC3(level._id_D267, "plr_elevator_button");
  scripts\engine\utility::flag_wait("player_in_elevator");
  var_1 = getEnt("elevator_console_trigger", "targetname");
  var_1 _id_0E46::_id_48C4(undefined, undefined, &"HEIST_SPACE_ELEVATOR_BUTTON", undefined, 256);
  var_1 waittill("trigger");
  setmusicstate("mx_253_heistspace_elevator");
  level._id_2FF1 thread scripts\sp\maps\heistspace\heistspace_util::_id_AED6();
  var_2 = getEnt("bridge_elevator_door_blocker", "targetname");

  if(isDefined(var_2)) {
    var_2 disconnectPaths();
    var_2 scripts\sp\utility::_id_100FC();
  }

  level.player freezecontrols(1);
  level.player disableweapons();
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_jump(0);
  level.player scripts\engine\utility::allow_doublejump(0);
  level.player scripts\engine\utility::allow_sprint(0);
  level.player _meth_823C(level._id_D267, "tag_player", 0.35);
  wait 0.35;
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_BA78();
  level thread scripts\engine\utility::play_sound_in_space("elevator_gate_raise", (-69452, 14695, 3933));
  level._id_D267 show();
  level.player playerlinktodelta(level._id_D267, "tag_player", 1, 20, 20, 10, 10, 1);
  var_0 scripts\sp\anim::_id_1F35(level._id_D267, "plr_elevator_button");
  level.player unlink();
  level._id_D267 delete();
  level.player freezecontrols(0);
  level.player enableweapons();
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_jump(1);
  level.player scripts\engine\utility::allow_doublejump(1);
  level.player scripts\engine\utility::allow_sprint(1);
  scripts\engine\utility::flag_set("elevator_can_move");
}

mons_elevator_restore_grenades() {
  scripts\engine\utility::flag_wait("ethan_hall_vo");
  scripts\sp\utility::_id_F526("normal");
  scripts\engine\utility::allow_offhand_weapons(1);
}

_id_BA92() {
  scripts\sp\utility::_id_54F7();
  level._id_2FF1 thread _id_606D();
  var_0 = getEnt("elevator_animnode", "targetname");
  var_0 linkTo(level._id_2BDC._id_C6EA);
  var_0 scripts\sp\anim::_id_1F17(self, "elevator_enter");
  var_0 scripts\sp\anim::_id_1F35(self, "elevator_enter");
  self linkTo(var_0);
  scripts\engine\utility::flag_set("salter_elevator_ready");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "elevator_start_idle", "stop_loop");
  thread _id_60AF();
  thread _id_DD72();
  scripts\engine\utility::flag_wait("ethan_hall_vo");
  var_0 notify("stop_loop");
  var_0 thread scripts\sp\anim::_id_1F35(self, "readyroom_hall_traverse_a");
  self waittillmatch("single anim", "unlink");
  var_0 notify("stop_loop");
  self unlink();
  var_1 = scripts\engine\utility::getStruct("om_upper_hall_animnode", "targetname");
  self waittillmatch("single anim", "start_c6_medic");
  level notify("start_c6_medic_anim");
  self waittillmatch("single anim", "sec_b_branch_point");

  if(!scripts\engine\utility::flag("salter_exit_ready_room")) {
    var_1 scripts\sp\anim::_id_1F35(self, "readyroom_hall_traverse_b_branch_intro");
    var_1 thread scripts\sp\anim::_id_1EEA(self, "readyroom_hall_traverse_branch_idle", "stop_salter_loop2");
    scripts\engine\utility::flag_wait("salter_exit_ready_room");
    var_1 notify("stop_salter_loop2");
    var_1 thread scripts\sp\anim::_id_1F35(self, "readyroom_hall_traverse_b_branch_outro");
  }

  self waittillmatch("single anim", "sec_c_branch_point");
  scripts\engine\utility::flag_set("hallways_done");

  if(!scripts\engine\utility::flag("salter_move_to_nav_hall")) {
    var_1 scripts\sp\anim::_id_1F35(self, "readyroom_hall_traverse_c_branch_intro");
    level._id_EACF = level._id_EA2C scripts\engine\utility::spawn_tag_origin();
    level._id_EACF thread scripts\sp\anim::_id_1EEA(self, "readyroom_exit_traverse_branch_c_idle", "stop_salter_loop3");
    scripts\engine\utility::flag_wait("salter_move_to_nav_hall");
    level._id_EACF notify("stop_salter_loop3");
    self.asm.movementgunposeoverride = "run_gun_down";
    var_1 scripts\sp\anim::_id_1F37(self, "readyroom_hall_traverse_c_branch_outro");
  }

  scripts\engine\utility::flag_wait("salter_start_nav_combat");
  level.player scripts\sp\utility::_id_15F5("salter_move_to_nav");
}

_id_676F(var_0) {
  scripts\sp\utility::_id_10350("heistspace_eth_setdefhasbreach");
}

_id_6770(var_0) {
  scripts\sp\utility::_id_10350("heistspace_eth_olympus6sareeng");
}

_id_606D() {
  while(!isDefined(self.opened)) {
    wait 0.05;
  }

  self.scripted = 1;
  scripts\engine\utility::flag_wait("elevator_can_move");
  self.scripted = undefined;
}

_id_606E() {
  while(!isDefined(self.opened)) {
    wait 0.05;
  }

  self.scripted = 1;
  scripts\engine\utility::flag_wait("close_elevator_door");
  self.scripted = undefined;
  thread scripts\sp\maps\heistspace\heistspace_util::_id_AED6();
}

_id_BAE4() {
  var_0 = scripts\engine\utility::getStruct("om_upper_hall_animnode", "targetname");
  level._id_5998 = scripts\sp\utility::_id_107EA("upper_hall_marine1", 1);
  level._id_5998._id_1FBB = "readyroom_door_guy";
  var_0 scripts\sp\anim::_id_1EC3(level._id_5998, "readyroom_traverse_b_doorguy");
  level._id_EA2C waittillmatch("single anim", "start_doorguy");
  var_0 scripts\sp\anim::_id_1F35(level._id_5998, "readyroom_traverse_b_doorguy");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_5998, "readyroom_traverse_b_doorguy_idle", "stop_doorguy_loop2");
  scripts\engine\utility::flag_wait("ethan_hall_2_vo");
  var_0 notify("stop_doorguy_loop2");
  level._id_DD71 thread scripts\sp\maps\heistspace\heistspace_util::_id_AED6();

  if(isDefined(level._id_5998) && isalive(level._id_5998)) {
    level._id_5998 delete();
  }
}

_id_BAE6() {
  var_0 = scripts\engine\utility::getStruct("om_upper_hall_animnode", "targetname");
  var_1 = [];
  var_2 = scripts\sp\utility::_id_107EA("readyroom_marine1", 1);
  var_2._id_1FBB = "readyroom_ally1";
  var_2 scripts\sp\utility::_id_86E4();
  var_1 = scripts\engine\utility::array_add(var_1, var_2);
  var_3 = scripts\sp\utility::_id_107EA("readyroom_marine2", 1);
  var_3._id_1FBB = "readyroom_ally2";
  var_1 = scripts\engine\utility::array_add(var_1, var_3);
  var_4 = scripts\sp\utility::_id_107EA("readyroom_marine3", 1);
  var_4._id_1FBB = "readyroom_ally3";
  var_0 scripts\sp\anim::_id_1EC1(var_1, "reinforcements_enter");
  var_0 scripts\sp\anim::_id_1EC3(var_4, "reinforcements_enter");
  scripts\engine\utility::flag_wait("elevator_door_opening");
  var_0 thread scripts\sp\anim::_id_1F2C(var_1, "reinforcements_enter");
  var_0 scripts\sp\anim::_id_1F35(var_4, "reinforcements_enter");
  var_0 thread scripts\sp\anim::_id_1EE7(var_1, "reinforcements_loop", "stop_runner_loop");
  var_0 thread scripts\sp\anim::_id_1EEA(var_4, "reinforcements_loop", "stop_runner_loop");
  scripts\engine\utility::flag_wait("ethan_hall_2_vo");
  var_0 notify("stop_runner_loop");

  foreach(var_6 in var_1) {
    if(isDefined(var_6) && isalive(var_6)) {
      var_6 delete();
    }
  }

  if(isDefined(var_4) && isalive(var_4)) {
    var_4 delete();
  }
}

_id_BAE5() {
  var_0 = scripts\engine\utility::getStruct("om_upper_hall_animnode", "targetname");
  var_1 = [];
  var_2 = scripts\sp\utility::_id_107EA("readyroom_medic", 1);
  var_2._id_1FBB = "readyroom_medic";
  var_2 scripts\sp\utility::_id_86E4();
  var_1 = scripts\engine\utility::array_add(var_1, var_2);
  var_3 = scripts\sp\utility::_id_107EA("readyroom_injured_ally1", 1);
  var_3._id_1FBB = "readyroom_injured1";
  var_3 scripts\sp\utility::_id_86E4();
  var_1 = scripts\engine\utility::array_add(var_1, var_3);
  var_4 = scripts\sp\utility::_id_107EA("readyroom_injured_ally2", 1);
  var_4._id_1FBB = "readyroom_injured2";
  var_4 scripts\sp\utility::_id_86E4();
  var_1 = scripts\engine\utility::array_add(var_1, var_4);
  var_5 = scripts\sp\utility::_id_107EA("readyroom_medic_c6", 1);
  var_5 thread _id_3354();
  var_1 = scripts\engine\utility::array_add(var_1, var_5);
  var_0 thread scripts\sp\anim::_id_1EEA(var_2, "injury_approach_loop", "stop_approach_loop");
  var_0 thread scripts\sp\anim::_id_1EEA(var_3, "injury_approach_loop", "stop_approach_loop");
  var_0 thread scripts\sp\anim::_id_1EC3(var_5, "injury_approach_enter");
  var_0 thread scripts\sp\anim::_id_1EC3(var_4, "injury_approach_enter");
  level waittill("start_c6_medic_anim");
  var_0 notify("stop_approach_loop");
  var_0 scripts\sp\anim::_id_1F2C(var_1, "injury_approach_enter");
  var_0 thread scripts\sp\anim::_id_1EE7(var_1, "injury_approach_exit_loop", "stop_medic_loop");
  scripts\engine\utility::flag_wait("ethan_hall_2_vo");
  var_0 notify("stop_medic_loop");

  foreach(var_7 in var_1) {
    if(isDefined(var_7) && isalive(var_7)) {
      var_7 delete();
    }
  }
}

_id_51EF() {
  var_0 = scripts\engine\utility::getStruct("om_upper_hall_animnode", "targetname");
  var_1 = [];
  var_2 = scripts\sp\utility::_id_107EA("deploy_ally_runner1", 1);
  var_2._id_1FBB = "readyroom_hall_runner1";
  var_2 setCanDamage(1);
  thread scripts\sp\friendlyfire::_id_73B1(var_2);
  var_1 = scripts\engine\utility::array_add(var_1, var_2);
  var_3 = scripts\sp\utility::_id_107EA("deploy_ally_runner2", 1);
  var_3._id_1FBB = "readyroom_hall_runner2";
  var_3 setCanDamage(1);
  thread scripts\sp\friendlyfire::_id_73B1(var_3);
  var_1 = scripts\engine\utility::array_add(var_1, var_3);
  var_0 scripts\sp\anim::_id_1EC1(var_1, "deploy_hall_c6");
  scripts\engine\utility::flag_wait_either("exiting_ready_room", "start_deploy_c6_anim");
  var_0 thread scripts\sp\anim::_id_1F2C(var_1, "deploy_hall_c6");
  var_3 waittillmatch("single anim", "activate_c6s");
  level._id_886A thread _id_0B6C::_id_8953();
  level waittill("ordnance_anims_start");
  var_4 = getEnt("hallway_ally_delete", "targetname");
  var_5 = var_4 scripts\sp\utility::_id_77E3();

  foreach(var_7 in var_5) {
    if(isDefined(var_7) && isalive(var_7)) {
      var_7 delete();
    }
  }
}

_id_D6E4() {
  var_0 = scripts\engine\utility::getStruct("om_upper_hall_animnode", "targetname");
  var_1 = [];
  var_2 = scripts\sp\utility::_id_107EA("hall_runner_c6_1", 1);
  var_2 thread _id_3354();
  var_2._id_1FBB = "c6_runner1";
  var_2 scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_F3B5, "o");
  var_1 = scripts\engine\utility::array_add(var_1, var_2);
  var_3 = scripts\sp\utility::_id_107EA("hall_runner_c6_2", 1);
  var_3 thread _id_3354();
  var_3._id_1FBB = "c6_runner2";
  var_3 scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_F3B5, "o");
  var_1 = scripts\engine\utility::array_add(var_1, var_3);
  var_0 scripts\sp\anim::_id_1EC1(var_1, "hall_c6_runner");
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_D32A("post_ready_room_anims_setup", "start_runner_c6_anim", "c6_runner_lookat_struct");
  scripts\engine\utility::flag_wait("start_runner_c6_anim");
  var_0 scripts\sp\anim::_id_1F33(var_1, "hall_c6_runner");

  if(scripts\engine\utility::flag("flag_c6_move_to_nav")) {
    level.player scripts\sp\utility::_id_15F5("c6_move_to_nav");
  } else {
    foreach(var_5 in var_1) {
      if(isDefined(var_5) && isalive(var_5)) {
        var_5 delete();
      }
    }
  }
}

_id_98ED(var_0, var_1, var_2, var_3) {
  scripts\sp\utility::_id_86E4();
  self.team = "allies";
  self._id_1FBB = var_1;

  if(!isDefined(var_0)) {
    thread scripts\sp\anim::_id_1EEA(self, var_2, var_3);
  } else {
    var_0 = scripts\engine\utility::getStruct(var_0, "targetname");
    var_0 thread scripts\sp\anim::_id_1EEA(self, var_2, var_3);
  }

  scripts\engine\utility::flag_wait(var_3);

  if(isDefined(self) && isalive(self)) {
    self delete();
  }
}

_id_DD72() {
  self waittillmatch("single anim", "start_hallway_guys");
  scripts\engine\utility::flag_set("start_deploy_c6_anim");
}

_id_DD70() {
  while(!isDefined(self.opened)) {
    wait 0.05;
  }

  self.scripted = 1;
}

_id_3354() {
  self.team = "allies";
  self.script_team = "allies";
  self.ignoreall = 1;
  self.ignoreme = 1;
  self._id_1FBB = "c6";
  thread _id_336C();
}

_id_BA94() {
  scripts\engine\utility::flag_wait("ethan_hall_vo");
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_BA4D();
  screenshake(level.player.origin, 3.5, 3.5, 3.5, 3.5, 0, 1.0, 128, 14, 14, 14);
  wait 1.5;
  level._id_EA2C waittillmatch("single anim", "start_doorguy");
  wait 1.75;
  level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_ifsetdefretakes");
  scripts\sp\utility::_id_1034D("heistspace_plr_ifwedontgetord");
}

_id_60AF() {
  if(scripts\engine\utility::flag("player_in_elevator")) {
    return;
  }
  level endon("player_in_elevator");
  wait 8;
  scripts\sp\utility::_id_10346("heistspace_slt_hustlereyes");
  wait 10;
  scripts\sp\utility::_id_10346("heistspace_slt_letsgettoordnan");

  if(!scripts\engine\utility::flag("player_in_elevator")) {
    wait 10;
    scripts\sp\utility::_id_10346("heistspace_slt_weneedtohurry");
  }
}

_id_BA5B() {
  var_0 = spawnStruct();
  var_0._id_ACFC = [];
  var_1 = getEntArray("om_hall_elevator", "targetname");

  foreach(var_3 in var_1) {
    var_3._id_124A = var_0;

    if(!isDefined(var_3.script_type)) {
      continue;
    }
    if(var_3.script_type == "link") {
      var_0._id_ACFC[var_0._id_ACFC.size] = var_3;
      continue;
    }

    if(var_3.script_type == "elevator") {
      var_0._id_6027 = var_3;
    }
  }

  foreach(var_6 in var_0._id_ACFC) {
    var_6 linkTo(var_0._id_6027);
  }

  var_0._id_C6EA = var_0._id_6027 scripts\engine\utility::spawn_tag_origin();
  var_0._id_6027 linkTo(var_0._id_C6EA);
  return var_0;
}

_id_3B83() {
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_3B3D();
}

_id_BAD7() {
  scripts\sp\maps\heistspace\heistspace_util::_id_10733(undefined, 1);
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_F5AF("jumpto_mons_nav", [level.player, level._id_EA2C]);
  level._id_C413 hide();
  var_0 = getEntArray("om_hall_elevator", "targetname");

  foreach(var_2 in var_0) {
    var_2.origin = var_2.origin + (0, 0, -1800);
  }

  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_25EC("jumpto_mons_nav");
  level thread _id_88A7();
}

_id_BAD2() {
  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  level thread _id_BAD8();
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D3(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B0(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132BB(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CC(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B4(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D4(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CB(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132C6(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D2(0);
  level._id_EA2C thread _id_BAD6();
  thread _id_BAD3();
  level._id_EA2C thread _id_EAC4();
  wait 3;
  level thread _id_0E4B::_id_13485();
  thread _id_0B0B::_id_25C2();
  setglobalsoundcontext("atmosphere", "helmet", 1);
  scripts\engine\utility::flag_wait("mons_nav_end");
}

_id_BAD6() {
  wait 0.2;
  scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_F3B5("r");
  level.player scripts\sp\utility::_id_15F5("salter_move_to_nav_hall");
  self.ignoreall = 0;
  self.ignoreme = 0;
  objective_add(scripts\sp\utility::_id_C264("OBJ_SUPPORT_SALTER"), "active", "");
  objective_onentity(scripts\sp\utility::_id_C264("OBJ_SUPPORT_SALTER"), self, (0, 0, 60));
  objective_setpointertextoverride(scripts\sp\utility::_id_C264("OBJ_SUPPORT_SALTER"), &"HEIST_SPACE_SUPPORT");
  objective_current(scripts\sp\utility::_id_C264("OBJ_SUPPORT_SALTER"));
  scripts\engine\utility::flag_wait("navi_combat_complete");
  objective_delete(scripts\sp\utility::_id_C264("OBJ_SUPPORT_SALTER"));
  scripts\sp\utility::_id_2679();
}

_id_119C0() {
  scripts\engine\utility::flag_wait("flag_c6allies_mbs_off");
  scripts\sp\utility::_id_1101B();
}

_id_F8EF() {
  self.team = "allies";
  self.script_team = "allies";
  self._id_2894 = 0.075;
  thread _id_336C();

  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "c6_blue") {
      scripts\sp\utility::_id_F3B5("b");
    }

    if(self.script_noteworthy == "c6_green") {
      scripts\sp\utility::_id_F3B5("g");
    }

    if(self.script_noteworthy == "c6_yellow") {
      scripts\sp\utility::_id_F3B5("y");
    }
  }

  _id_0E29::_id_8795(self, self);
  scripts\sp\utility::_id_B14F();
  thread _id_119C0();
}

_id_336C() {
  self.name = "SDF-G";
  var_0 = randomintrange(100, 1000);
  self.name = self.name + var_0;
}

_id_87F7() {
  self endon("death");
  self endon("hack_unequipped");
  level endon("mons_nav_end");

  for(;;) {
    if(!_id_0E29::_id_9BF9()) {
      self waittill("secondary_equipment_pressed");
    }

    while(!isDefined(self._id_87F8)) {
      wait 0.05;
    }

    if(!isDefined(level._id_3354)) {
      wait 0.05;
    }

    var_0 = undefined;

    if(!isDefined(level._id_3355)) {
      var_0 = level._id_3354;
    } else {
      var_0 = scripts\engine\utility::array_combine(level._id_3354, level._id_3355);
    }

    var_0 = scripts\engine\utility::array_removeundefined(var_0);

    if(isDefined(var_0)) {
      foreach(var_2 in var_0) {
        if(isalive(var_2)) {
          var_2._id_87F6 = 1;
          level.player._id_87F8[level.player._id_87F8.size] = var_2;
        }
      }
    }

    wait 0.05;
  }
}

_id_FA34() {
  self.ignoreme = 1;
  self.ignoreall = 1;
  self waittill("goal");
  self delete();
}

_id_BAD3() {
  var_0 = getspawnerarray("navi_runners1");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_1747, ::_id_FA34);
  thread scripts\sp\maps\heistspace\heistspace_util::_id_3DD8("trig_navi_wave2");
  thread scripts\sp\maps\heistspace\heistspace_util::_id_3DD8("trig_combat_shift1");
  thread scripts\sp\maps\heistspace\heistspace_util::_id_3DD8("trig_navi_combat_reinforcements");
  var_1 = getspawnerarray("navi_c6_allies");
  var_2 = getspawnerarray("navi_c6_allies_reinforcements");
  var_3 = scripts\engine\utility::array_combine(var_1, var_2);

  foreach(var_5 in var_3) {
    var_5 scripts\sp\utility::_id_1747(::_id_F8EF);
  }

  scripts\engine\utility::flag_wait("flag_mons_nav_combat_start");
  thread _id_1DCC();
  thread _id_BAD5();
  thread _id_BAD9();
  level._id_3354 = scripts\sp\utility::_id_22CD("navi_c6_allies", 1, 1);
  var_7 = scripts\sp\utility::_id_22CD("navi_wave1", 1, 1);
  var_8 = scripts\sp\utility::_id_22CD("navi_runners1", 1, 1);
}

_id_B159(var_0, var_1, var_2) {
  scripts\engine\utility::flag_wait(var_0);
  magicbullet("iw7_lockon", var_1.origin, var_2.origin);
}

_id_1DCC() {
  var_0 = getEnt("magic_rpg_spot1", "targetname");
  var_1 = getEnt("magic_rpg_spot1_end", "targetname");
  var_2 = getEnt("magic_rpg_spot2", "targetname");
  var_3 = getEnt("magic_rpg_spot2_end", "targetname");
  var_4 = getEnt("magic_rpg_spot3", "targetname");
  var_5 = getEnt("magic_rpg_spot3_end", "targetname");
  thread _id_B159("flag_rpg_spot1", var_0, var_1);
  thread _id_B159("flag_rpg_spot2", var_2, var_3);
  thread _id_B159("flag_rpg_spot3", var_4, var_5);
}

_id_BAD5() {
  scripts\engine\utility::flag_wait("flag_navi_wave2");
  thread scripts\sp\utility::_id_2679();
  scripts\sp\maps\heistspace\heistspace_util::_id_E352("navi_wave1_vol", "navi_wave2_vol");
  scripts\sp\utility::_id_15F5("trig_navi_wave2_colors");
  var_0 = scripts\sp\utility::_id_22CD("navi_wave2", 1, 1);
  var_1 = getEnt("navi_wave2_vol", "targetname");
  var_2 = var_1 scripts\sp\utility::_id_77E3("axis");
  scripts\sp\maps\heistspace\heistspace_util::_id_1919(var_2, int(var_2.size - 3), "flag_navi_end_retreat");
  scripts\engine\utility::flag_wait("flag_navi_end_retreat");
  scripts\sp\maps\heistspace\heistspace_util::_id_E352("navi_wave2_vol", "navi_wave3_vol");
}

_id_BAD9() {
  scripts\engine\utility::flag_wait("flag_navi_combat_reinforcements");
  level._id_3355 = scripts\sp\utility::_id_22CD("navi_c6_allies_reinforcements", 1, 1);
}

_id_BAD8() {
  scripts\engine\utility::flag_wait("flag_rpg_spot3");
  scripts\sp\utility::_id_1034D("heistspace_plr_bridgecontactat");
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  thread _id_BAD4();
  scripts\engine\utility::flag_wait("ethan_hall_3_vo");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  level endon("ordnance_anims_start");
  scripts\engine\utility::flag_set("salter_ready_for_ordnance_anim");

  if(!isDefined(level.player._id_134F8)) {
    level.player._id_134F8 = level.player scripts\engine\utility::spawn_tag_origin();
  }

  level.player._id_134F8._id_1FBB = "ethan";
  level.player._id_134F8 linkTo(level.player, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.player._id_134F8 scripts\sp\utility::_id_10346("heistspace_eth_sirshipyardisin");
  scripts\sp\utility::_id_1034D("heistspace_plr_wevestillgotthe");
  level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_collisionmaneuv");
  scripts\sp\utility::_id_1034D("heistspace_plr_adirecthitshoul");
  level.player._id_134F8 scripts\sp\utility::_id_10346("heistspace_eth_solidcopycaptai");
  scripts\sp\utility::_id_1034D("heistspace_plr_salt");
  level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_whoreyouasking");
  scripts\sp\utility::_id_1034D("heistspace_plr_letspush");

  if(isDefined(level.player._id_134F8)) {
    level.player._id_134F8 unlink();
    level.player._id_134F8 delete();
  }
}

_id_BAD4() {
  level endon("ethan_hall_3_vo");
  level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_setdefinthecont");
  wait 4;
  level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_neartheterminal");
  wait 4;
  scripts\sp\utility::_id_1034D("heistspace_plr_bytheradar");
  wait 2;
  level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_onthelookout");
  wait 3;
  scripts\sp\utility::_id_1034D("heistspace_plr_watchthewheelho");
  scripts\engine\utility::flag_wait("flag_navi_end_retreat");
  level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_seconddeck");
}

_id_EAC4() {
  scripts\sp\utility::_id_127B3("salter_move_to_ordnance");

  while(!istransientloaded("heistspace_om_ordnance_tr")) {
    wait 0.05;
    waitforalltransients();
  }

  scripts\sp\friendlyfire::_id_1299E();
  thread hs_space_music();
  level._id_C47D = scripts\engine\utility::getStruct("om_ordnance_hall_animnode", "targetname");
  var_0 = getnode("salter_ordnance_hallway_pos1", "targetname");
  self _meth_82EE(var_0);
  level endon("stop_old_salter");

  if(!scripts\engine\utility::flag("salter_start_traverse_anim")) {
    self waittill("goal");
    scripts\engine\utility::waitframe();
    var_0 thread scripts\sp\anim::_id_1EEA(self, "hall_traverse_a_idle", "stop_loop");
    scripts\engine\utility::flag_wait("salter_start_traverse_anim");
    var_0 notify("stop_loop");
  }

  level._id_C47D thread scripts\sp\anim::_id_1F35(self, "hall_traverse_a");
  scripts\sp\utility::_id_414F();
  self waittillmatch("single anim", "spark_react");
  scripts\engine\utility::exploder("vfx_amb_damage");
  self waittillmatch("single anim", "branch_point");

  if(!scripts\engine\utility::flag("mons_nav_end")) {
    level._id_C47D scripts\sp\anim::_id_1F35(self, "hall_traverse_branch_intro");
    level._id_EACF = level._id_EA2C scripts\engine\utility::spawn_tag_origin();
    level._id_EACF thread scripts\sp\anim::_id_1EEA(self, "hall_traverse_branch_idle", "stop_loop2");
    scripts\engine\utility::flag_wait("mons_nav_end");
    level._id_EACF notify("stop_loop2");
    level._id_C47D scripts\sp\anim::_id_1F35(self, "hall_traverse_branch_outro");
    level._id_C47D scripts\sp\anim::_id_1F35(self, "hall_traverse_b");
    level._id_C47D thread scripts\sp\anim::_id_1EEA(self, "hall_traverse_end_loop", "stop_loop3");
  } else {
    self waittillmatch("single anim", "end");
    level._id_C47D scripts\sp\anim::_id_1F35(self, "hall_traverse_b");
    level._id_C47D thread scripts\sp\anim::_id_1EEA(self, "hall_traverse_end_loop", "stop_loop3");
  }
}

hs_space_music() {
  setmusicstate("");
}

_id_3B84() {
  level thread _id_BA98();
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_E747();
  thread scripts\sp\maps\heistspace\heistspace_ext_combat::_id_104BD();
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_3B3E();
  thread scripts\sp\utility::_id_241F(0);
  scripts\engine\utility::flag_set("show_jackal_combat_debris");
  scripts\engine\utility::flag_set("yard_obj_assess_ord_done");
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_8D2A("stage2");
  level thread _id_0E4B::_id_13485(1);
}

_id_BADC() {
  scripts\sp\maps\heistspace\heistspace_util::_id_10733(undefined, 1);
  scripts\sp\utility::_id_F5AF("jumpto_mons_ordnance", [level.player, level._id_EA2C]);
  level._id_C413 hide();
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_25EC("jumpto_mons_ordnance");
  level._id_EA2C.goalradius = 16;
  level._id_EA2C.ignoreall = 0;
  level._id_EA2C.ignoreme = 0;
  level._id_C47D = scripts\engine\utility::getStruct("om_ordnance_hall_animnode", "targetname");
  level._id_C47D thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "hall_traverse_end_loop", "stop_loop3");
  scripts\engine\utility::flag_set("salter_ready_for_ordnance_anim");
}

_id_BADA() {
  setglobalsoundcontext("atmosphere", "helmet");
  scripts\sp\utility::_id_2669("heistspace_ord_start");
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D3(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B0(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132BB(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CC(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132B4(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D4(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132CB(1);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132C6(0);
  scripts\sp\maps\heistspace\heistspace_fx::_id_132D2(0);
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_8D2A("stage2");
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_E747();
  level thread _id_BADB();
  level thread _id_BADD();
  scripts\engine\utility::flag_wait("ordnance_door_opened");

  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F53C(0);
  }

  scripts\engine\utility::flag_wait_or_timeout("ordnance_vo_over", 9);
  scripts\sp\utility::_id_2679();
}

#using_animtree("script_model");

_id_BADB() {
  scripts\engine\utility::flag_set("ordnance_anim_start");
  level._id_C47C = scripts\engine\utility::getStruct("om_ordnance_hall_animnode", "targetname");
  level._id_C6E7 = getEnt("ordnance_door", "targetname");
  level._id_C6E7._id_1FBB = "ordnance_door";
  level._id_C6E7 _meth_83D0(#animtree);
  level._id_C47C scripts\sp\anim::_id_1EC3(level._id_C6E7, "check_ordnance_exit");
  level._id_D267 = scripts\sp\utility::_id_10639("player_rig");
  level._id_D267 hide();
  level._id_C47C scripts\sp\anim::_id_1EC3(level._id_D267, "check_ordnance_exit");
  scripts\engine\utility::flag_wait_all("player_ready_for_ordnance_anim", "salter_ready_for_ordnance_anim");
  level._id_C6E7._id_5A40 = scripts\engine\utility::spawn_tag_origin(level._id_C6E7 gettagorigin("interact_push"), level._id_C6E7 gettagangles("interact_push"));
  level._id_C6E7._id_5A40 linkTo(level._id_C6E7);
  level._id_C6E7._id_5A40 _id_0E46::_id_48C4(undefined, undefined, undefined, 45, 200, 50, 1, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  level._id_C6E7._id_5A40 waittill("trigger");
  level._id_C6E7 _id_0E46::_id_DFE3();

  if(!scripts\engine\utility::flag("start_ordnance_vo")) {
    level._id_EA2C hide();
  }

  level notify("ordnance_anims_start");

  if(isDefined(level._id_C6E7._id_5A40)) {
    level._id_C6E7._id_5A40 delete();
  }

  thread _id_555B();
  level thread _id_BA98();
  level.player disableweapons();
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_BACB();
  var_0 = scripts\sp\utility::_id_107EA("salter_zerog", 1);
  var_0.name = "Salter";
  var_0._id_1FBB = "salter";
  var_0 scripts\sp\utility::_id_F3B5("r");
  var_0 thread scripts\sp\utility::_id_B14F();
  var_0.team = "allies";
  var_0 hide();
  var_1 = _id_C6E6();
  var_1[var_1.size] = var_0;
  level._id_C47C scripts\sp\anim::_id_1EC1(var_1, "check_ordnance_exit");
  level.player _meth_823C(level._id_D267, "tag_player", 0.75);
  wait 0.75;
  level.player _meth_823B(level._id_D267, "tag_player");
  level._id_C47C thread scripts\sp\anim::_id_1F2C(var_1, "check_ordnance_exit");
  level._id_D267 show();
  scripts\engine\utility::flag_set("ordnance_player_anim_started");
  var_0 thread _id_8959();
  var_2 = scripts\sp\utility::_id_7C23();
  var_2 scripts\engine\utility::delaythread(1.75, scripts\sp\utility::_id_E7C9, 0.25, 0.1);
  var_2 scripts\engine\utility::delaythread(3.8, scripts\sp\utility::_id_E7C7, 0.1);
  var_2 scripts\engine\utility::delaythread(8.6, scripts\sp\utility::_id_E7C9, 0.85, 2.5);
  var_2 scripts\engine\utility::delaythread(11.0, scripts\sp\utility::_id_E7C7, 0.1);
  var_2 scripts\engine\utility::delaythread(12.0, scripts\sp\utility::_id_E7C9, 0.85, 0.1);
  var_2 scripts\engine\utility::delaythread(12.5, scripts\sp\utility::_id_E7C7, 0.1);
  wait 11;
  scripts\engine\utility::flag_set("ordnance_door_opened");
  setmusicstate("mx_365_heistspace_space");
  scripts\engine\utility::flag_set("show_jackal_combat_debris");
  thread scripts\sp\utility::_id_12641("heistspace_mons_ext_bridge_tr");
  level thread scripts\sp\maps\heistspace\heistspace_util::_id_BC27("jackal_crash_begin");
  level thread scripts\sp\maps\heistspace\heistspace_audio::_id_6A1D();
  level._id_D267 thread scripts\sp\maps\heistspace\heistspace_fx::_id_13345();
  thread scripts\sp\maps\heistspace\heistspace_ext_combat::_id_13E9D();
  thread scripts\sp\utility::_id_241F(0);
  level._id_D267 waittillmatch("single anim", "salter_impact_player");
  earthquake(0.9, 1.0, level.player.origin, 200);
  level.player shellshock("default_nosound", 1);
  var_2 thread scripts\sp\utility::_id_E7C8(0.1);
  var_2 scripts\engine\utility::delaythread(1.0, scripts\sp\utility::_id_E7C7, 1.0);
  var_2 scripts\engine\utility::delaycall(3.0, ::delete);
  thread scripts\sp\maps\heistspace\heistspace_util::_id_13E81();
  thread scripts\sp\maps\heistspace\heistspace_ext_combat::_id_104BD();
  level._id_D267 waittillmatch("single anim", "gun_up");
  level.player enableweapons();
  level._id_D267 waittillmatch("single anim", "end");
  thread scripts\sp\utility::_id_1264E("heistspace_om_halls_tr");
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player unlink();
  level._id_D267 delete();

  while(!istransientloaded("heistspace_mons_ext_bridge_tr")) {
    wait 0.05;
    waitforalltransients();
  }
}

_id_8959() {
  level._id_EA2C stopsounds();
  wait 2.0;
  level notify("stop_old_salter");
  level._id_C47C notify("stop_loop3");
  level._id_EA2C scripts\sp\utility::anim_stopanimScripted();
  level._id_EA2C scripts\sp\utility::_id_1101B();
  level._id_EA2C delete();
  self show();
  level._id_EA2C = self;
  level._id_8E42 = scripts\engine\utility::array_remove_duplicates(level._id_8E42);
  level._id_8E42 = scripts\engine\utility::add_to_array(level._id_8E42, level._id_EA2C);
}

_id_C6E6() {
  var_0 = [];

  if(!isDefined(level._id_13E74)) {
    var_0[var_0.size] = level._id_D267;
  }

  if(!isDefined(level._id_C6E7)) {
    level._id_C6E7 = getEnt("ordnance_door", "targetname");
    level._id_C6E7._id_1FBB = "ordnance_door";
    level._id_C6E7 _meth_83D0(#animtree);
  }

  var_0[var_0.size] = level._id_C6E7;
  var_1 = scripts\sp\utility::_id_10639("barrel01");
  var_1.tag_origin = scripts\engine\utility::spawn_tag_origin();
  var_1.tag_origin._id_1FBB = "barrel01";
  var_1.tag_origin _meth_83D0(#animtree);
  var_1 linkTo(var_1.tag_origin, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1 thread _id_1F88();
  var_2 = scripts\sp\utility::_id_10639("barrel02");
  var_2.tag_origin = scripts\engine\utility::spawn_tag_origin();
  var_2.tag_origin._id_1FBB = "barrel02";
  var_2.tag_origin _meth_83D0(#animtree);
  var_2 linkTo(var_2.tag_origin, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2 thread _id_1F88();
  var_3 = scripts\sp\utility::_id_10639("barrel03");
  var_3.tag_origin = scripts\engine\utility::spawn_tag_origin();
  var_3.tag_origin._id_1FBB = "barrel03";
  var_3.tag_origin _meth_83D0(#animtree);
  var_3 linkTo(var_3.tag_origin, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_3 thread _id_1F88();
  var_4 = scripts\sp\utility::_id_10639("barrel04");
  var_4.tag_origin = scripts\engine\utility::spawn_tag_origin();
  var_4.tag_origin._id_1FBB = "barrel04";
  var_4.tag_origin _meth_83D0(#animtree);
  var_4 linkTo(var_4.tag_origin, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_4 thread _id_1F88();
  var_5 = scripts\sp\utility::_id_10639("barrel05");
  var_5.tag_origin = scripts\engine\utility::spawn_tag_origin();
  var_5.tag_origin._id_1FBB = "barrel05";
  var_5.tag_origin _meth_83D0(#animtree);
  var_5 linkTo(var_5.tag_origin, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_5 thread _id_1F88();
  var_6 = scripts\sp\utility::_id_10639("crate01");
  var_6.tag_origin = scripts\engine\utility::spawn_tag_origin();
  var_6.tag_origin._id_1FBB = "crate01";
  var_6.tag_origin _meth_83D0(#animtree);
  var_6 linkTo(var_6.tag_origin, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_6 thread _id_1F88();
  var_7 = scripts\sp\utility::_id_10639("crate02");
  var_7.tag_origin = scripts\engine\utility::spawn_tag_origin();
  var_7.tag_origin._id_1FBB = "crate02";
  var_7.tag_origin _meth_83D0(#animtree);
  var_7 linkTo(var_7.tag_origin, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_7 thread _id_1F88();
  var_8 = scripts\sp\utility::_id_10639("crate03");
  var_8.tag_origin = scripts\engine\utility::spawn_tag_origin();
  var_8.tag_origin._id_1FBB = "crate03";
  var_8.tag_origin _meth_83D0(#animtree);
  var_8 linkTo(var_8.tag_origin, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_8 thread _id_1F88();
  var_9 = scripts\sp\utility::_id_10639("debris01");
  var_9 thread _id_1F88();
  var_10 = scripts\sp\utility::_id_10639("debris02");
  var_10 thread _id_1F88();
  var_11 = scripts\sp\utility::_id_10639("screen");
  var_11.tag_origin = scripts\engine\utility::spawn_tag_origin();
  var_11.tag_origin._id_1FBB = "screen";
  var_11.tag_origin _meth_83D0(#animtree);
  var_11 linkTo(var_11.tag_origin, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_11 thread _id_1F88();
  var_0[var_0.size] = var_1.tag_origin;
  var_0[var_0.size] = var_2;
  var_0[var_0.size] = var_3.tag_origin;
  var_0[var_0.size] = var_4.tag_origin;
  var_0[var_0.size] = var_5.tag_origin;
  var_0[var_0.size] = var_6.tag_origin;
  var_0[var_0.size] = var_7.tag_origin;
  var_0[var_0.size] = var_8.tag_origin;

  if(!isDefined(level._id_13E74)) {
    var_0[var_0.size] = var_9;
    var_0[var_0.size] = var_10;
  }

  var_0[var_0.size] = var_11.tag_origin;
  return var_0;
}

_id_555B() {
  if(_id_0E2D::_id_9C6F()) {
    foreach(var_1 in level.player._id_4C29) {
      var_1._id_5BD7 notify("timeout");
    }
  }

  if(isDefined(level._id_F10A._id_1633) && level._id_F10A._id_1633.size != 0) {
    foreach(var_4 in level._id_F10A._id_1633) {
      var_4 _id_0E26::_id_E084();
    }
  }

  level.player _meth_844D();
  level.player _meth_844E();
  level.player clearoffhandspecial();
}

_id_1F88() {
  if(isDefined(self._id_1FBB)) {
    self.clip = getEnt(self._id_1FBB + "_clip", "targetname");

    if(isDefined(self.clip)) {
      if(self._id_1FBB == "screen") {
        self.clip linkTo(self, "tag_origin", (0, 0, 8), (0, 0, 0));
      } else if(self._id_1FBB == "crate02") {
        self.clip linkTo(self, "tag_origin", (0, 0, 30), (90, 0, 0));
      } else {
        self.clip linkTo(self, "tag_origin", (0, 0, 28), (0, 0, 0));
      }
    }
  }

  self dontcastshadows();

  if(!isDefined(level._id_13E74)) {
    if(isDefined(self.tag_origin)) {
      self.tag_origin waittillmatch("single anim", "end");
    } else {
      self waittillmatch("single anim", "end");
    }
  } else
    wait 0.5;

  if(isDefined(self._id_1FBB) && self._id_1FBB == "debris01" || self._id_1FBB == "debris02") {
    if(isDefined(self.clip)) {
      self.clip delete();
    }

    if(isDefined(self)) {
      self delete();
    }

    return;
  }

  self unlink();
  scripts\sp\utility::anim_stopanimScripted();
  scripts\engine\utility::waitframe();

  if(isDefined(self.tag_origin)) {
    self.tag_origin delete();
  }

  thread scripts\sp\maps\heistspace\heistspace_util::_id_E70E();
  scripts\engine\utility::flag_wait("player_entering_jackal");
  self notify("debris_cleanup");
  self notify("debris_done");
  wait 10;

  if(isDefined(self.clip)) {
    self.clip delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

_id_BADD() {
  thread _id_D7D4();
  scripts\engine\utility::flag_wait("ordnance_door_opened");

  if(!isDefined(level.player._id_134F8)) {
    level.player._id_134F8 = level.player scripts\engine\utility::spawn_tag_origin();
  }

  level.player._id_134F8._id_1FBB = "ethan";
  level.player._id_134F8 linkTo(level.player, "tag_origin", (0, 0, 0), (0, 0, 0));
  level.player._id_134F8 scripts\sp\utility::_id_10346("heistspace_slt_reyes");
  wait 0.5;
  level.player._id_134F8 thread scripts\sp\utility::_id_10346("heistspace_slt_ethanordnancero");
  level._id_D267 waittillmatch("single anim", "salter_impact_player");
  scripts\sp\utility::_id_1034D("heistspace_plr_umph");
  scripts\sp\utility::_id_1034D("heistspace_plr_bridgeweareouto");
  scripts\engine\utility::flag_set("ordnance_vo_over");
  level.player._id_134F8 scripts\sp\utility::_id_10346("heistspace_eth_captaintheolymp");
  scripts\sp\utility::_id_1034D("heistspace_plr_sendjackalstoou");
  scripts\engine\utility::flag_set("yard_obj_assess_ord_done");
  level.player._id_134F8 scripts\sp\utility::_id_10346("heistspace_eth_clearsir");
  scripts\sp\utility::_id_1034D("heistspace_plr_gunsuptheyreonu");

  if(isDefined(level.player._id_134F8)) {
    level.player._id_134F8 unlink();
    level.player._id_134F8 delete();
  }
}

_id_D7D4() {
  level endon("ordnance_anims_start");
  scripts\engine\utility::flag_wait("start_ordnance_vo");

  if(isDefined(level._id_EA2C)) {
    level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_ordnancecontrol");
  }

  if(isDefined(level._id_EA2C)) {
    level._id_EA2C scripts\sp\utility::_id_10346("heistspace_slt_letsgetthisopen");
  }

  scripts\engine\utility::flag_set("ordnance_door_vo_complete");
}

_id_C6E8() {
  level.player disableweapons();
  self._id_5A30 connectpaths();
  scripts\engine\utility::flag_set("ordnance_door_opened");
  level _id_0B20::_id_AB71(self, "right_push_long", 0.4, undefined, 1, 1.75);
  self._id_5A30 disconnectPaths();
  level.player enableweapons();
  level thread _id_0B20::_id_5A2E("om_ordnance_entry_door", "locked");
}

_id_88A7() {
  var_0 = getEnt("turn_off_ready_room_crate", "targetname");
  var_1 = undefined;

  if(!isDefined(var_0)) {
    return;
  }
  var_2 = scripts\engine\utility::getStructArray("ammo_pickup", "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_parameters) && var_4.script_parameters == "ready_room_ammo_cleanup") {
      var_1 = var_4;
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  while(!isDefined(var_1._id_99F7._id_4C1F)) {
    wait 0.05;
  }

  while(!scripts\engine\utility::flag("ethan_hall_2_vo")) {
    if(level.player istouching(var_0)) {
      if(isDefined(var_1._id_99F7._id_4C1F)) {
        var_1._id_99F7._id_4C1F _meth_84A4(1);
        var_1._id_99F7._id_4C1F _meth_84A9("hide");
      }
    } else if(isDefined(var_1._id_99F7._id_4C1F)) {
      var_1._id_99F7._id_4C1F _meth_84A4(300);
      var_1._id_99F7._id_4C1F _meth_84A9("show");
    }

    wait 0.5;
  }

  wait 1;
  var_0 delete();
}

_id_BA98() {
  var_0 = getEntArray("om_hall_elevator", "targetname");
  var_1 = getEntArray("om_elevator_entry_rail", "targetname");
  var_2 = getEntArray("om_elevator_exit_rail", "targetname");
  scripts\sp\utility::_id_228A(var_0);
  scripts\sp\utility::_id_228A(var_1);
  scripts\sp\utility::_id_228A(var_2);
  var_3 = getEnt("upper_hall_rss", "targetname");
  var_4 = scripts\engine\utility::getStructArray("robot_security_station", "script_noteworthy");
  var_5 = undefined;

  foreach(var_7 in var_4) {
    if(ispointinvolume(var_7.origin, var_3)) {
      var_5 = var_7;
    }
  }

  if(!isDefined(var_5)) {
    return;
  }
  var_9 = getEntArray(var_5.target, "targetname");
  scripts\sp\utility::_id_228A(var_9);
  var_10 = getaiarray("axis");

  foreach(var_12 in var_10) {
    if(isDefined(var_12)) {
      var_12 delete();
    }
  }

  var_14 = getaiarray("allies");

  foreach(var_16 in var_14) {
    if(isDefined(var_16) && var_16 != level._id_EA2C) {
      var_16 delete();
    }
  }

  var_18 = scripts\sp\utility::_id_7DB7();

  foreach(var_20 in var_18) {
    if(isDefined(var_20)) {
      var_20 delete();
    }
  }

  level notify("nav_room_ammo_cleanup");
  level notify("ready_room_ammo_cleanup");
  var_22 = getEntArray("phys_battery_destructible", "targetname");
  scripts\engine\utility::array_thread(var_22, ::_id_5341, "barrel_delete");
  var_23 = getEntArray("phys_barrel_destructible", "targetname");
  scripts\engine\utility::array_thread(var_23, ::_id_5341, "barrel_delete");
  var_24 = getEntArray("phys_antigrav_destructible", "targetname");
  scripts\engine\utility::array_thread(var_24, ::_id_5341, "barrel_delete");
}

_id_5341(var_0) {
  if(isDefined(var_0)) {
    self notify(var_0);
    scripts\engine\utility::waitframe();
  }

  if(isDefined(self)) {
    self delete();
  }
}