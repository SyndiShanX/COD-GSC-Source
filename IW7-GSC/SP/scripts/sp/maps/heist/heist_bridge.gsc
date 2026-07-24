/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heist\heist_bridge.gsc
**************************************************/

_id_10C94() {
  scripts\sp\maps\heist\heist_util::_id_1065E();
  scripts\sp\maps\heist\heist_util::_id_106D9();
  scripts\sp\maps\heist\heist_util::_id_107BE();
  scripts\sp\maps\heist\heist_util::_id_1074D();
  scripts\sp\maps\heist\heist_util::_id_10751();
  scripts\sp\utility::_id_F5AF("start_mons_interior", [level.player, level._id_6754, level._id_30F6, level._id_EA2C, level._id_A54E]);
  scripts\sp\maps\heist\heist_hack::_id_1065C();
  thread _id_30CB();
  level._id_A70E.ignoreme = 1;
  var_0 = scripts\engine\utility::getStruct("scene_mons_breach", "targetname");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_6754, "postbreach_idle", "ethan_stop_loop");
  var_1[0] = scripts\engine\utility::getStruct("struct_robothack1", "targetname");
  var_1[1] = scripts\engine\utility::getStruct("struct_robothack2", "targetname");
  var_2 = scripts\sp\utility::_id_22CD("robots_to_hack");
  level._id_3029 = var_2;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3]._id_1FBB = "c6worker_hack_" + var_3;
    var_1[var_3] thread scripts\sp\anim::_id_1EEA(var_2[var_3], "robothack_idle");
    var_2[var_3].struct = var_1[var_3];
    var_2[var_3]._id_11A0A = var_2[var_3] scripts\sp\anim::_id_1EE5("engineer_blowtorch", "tag_accessory_left");
  }

  thread _id_A71A();
  level.player scripts\sp\utility::_id_65E1("hack_control_outro_done");
}

_id_B207() {
  setmusicstate("");
  setsuncolorandintensity(0);
  scripts\sp\utility::_id_2669("kotch_kill");
  scripts\sp\utility::_id_28D7("axis");
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_CF8B();
  level.player thread scripts\sp\utility::_id_D2CD(80, 0.05);
  scripts\engine\utility::delaythread(0, scripts\engine\utility::flag_set, "bridge_path_start_salter");
  scripts\engine\utility::delaythread(1, scripts\engine\utility::flag_set, "bridge_path_start_brooks");
  scripts\engine\utility::delaythread(2, scripts\engine\utility::flag_set, "bridge_path_start_kashima");
  scripts\engine\utility::delaythread(6, ::_id_2FF1);
  thread _id_302A();
  thread _id_A718();
  var_0 = scripts\engine\utility::getStruct("struct_bridge_scene", "targetname");
  level._id_A70E setModel("body_sdf_kotch_blood");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_A714, "kotch_kill_idle");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_A70E, "kotch_kill_idle");
  scripts\engine\utility::array_thread(getEntArray("bridge_salute_trigger", "targetname"), ::_id_3076);
  scripts\sp\maps\heist\heist_util::_id_13815("mons_bridge_player_safe");
  level.player thread scripts\sp\utility::_id_F526("safe");
  level.player thread scripts\sp\utility::_id_D2CD(75, 0.05);
  var_1 = scripts\engine\utility::spawn_tag_origin(level._id_A70E.origin + (0, 0, 32));
  _id_1379A(var_1);
  setsaveddvar("sm_roundrobinpriorityspotshadows", "8");
  setsaveddvar("sm_spotupdatelimit", "8");
  setsaveddvar("sm_spotdistcull", "200");
  var_1 delete();
  level.player thread scripts\sp\utility::_id_F526("normal");
  scripts\engine\utility::flag_set("kotch_death_start");
  var_0 thread _id_EBF0();
  level waittill("start_flight");
  scripts\sp\utility::_id_1034D("heist_plr_captainhastheco");
  scripts\engine\utility::flag_clear("obj_dealwithkotch");
}

_id_A71A() {
  foreach(var_1 in level.allies) {
    if(var_1 != level._id_6754)
      var_1 _meth_83A1();

    var_1.ignoreall = 1;
    var_1.ignoreme = 1;
    var_1 scripts\sp\utility::_id_5564();
    var_1 scripts\sp\utility::_id_F2D8(1000);

    if(var_1 == level._id_6754) {
      continue;
    }
    var_1 scripts\sp\utility::anim_stopanimScripted();
    var_1 scripts\sp\utility::_id_61E7();
    var_1 scripts\sp\utility::_id_54F7();
    var_2 = getnode("bridge_path_" + var_1._id_1FBB, "targetname");

    if(!isDefined(var_2)) {
      continue;
    }
    var_1 scripts\sp\utility::_id_1160F(var_2);
    var_1 thread scripts\sp\utility::_id_7226(var_2);
    var_1 thread _id_A717();
  }
}

_id_A717() {
  self waittill("reached_path_end");
  scripts\sp\utility::_id_7799(level.player);
  wait 0.05;
  scripts\sp\utility::_id_7798(level.player);
  scripts\engine\utility::flag_wait("bridge_shields_open");
  scripts\sp\utility::_id_77B9(0.05);
}

_id_1379A(var_0) {
  var_0 endon("trigger");
  level.player notifyonplayercommand("melee_button_pressed", "+melee");
  level.player notifyonplayercommand("melee_button_pressed", "+melee_breath");
  level.player notifyonplayercommand("melee_button_pressed", "+melee_zoom");
  var_1 = 0;
  var_2 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_2 _id_0E46::_id_48C4(undefined, undefined, undefined, undefined, undefined, 0.01, 1);

  for(;;) {
    if(_id_A715(var_0)) {
      if(!var_1) {
        var_2 _id_0E46::_id_DFE3();
        var_0 _id_0E46::_id_48C4();
        var_1 = 1;
      }
    } else if(var_1) {
      var_0 _id_0E46::_id_DFE3();
      var_2 _id_0E46::_id_48C4(undefined, undefined, undefined, undefined, undefined, 0.01, 1);
      var_1 = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_A715(var_0) {
  var_1 = cos(40);
  var_2 = anglestoright(level._id_A70E.angles) * -1;

  if(distance2d(level.player.origin, level._id_A70E.origin) > 64)
    return 0;

  if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin, var_1))
    return 0;

  if(vectordot(var_2, vectorNormalize(level.player.origin - level._id_A70E.origin)) < 0.65)
    return 0;

  return 1;
}

_id_A718() {
  if(!level.player scripts\sp\utility::_id_65DB("hack_control_outro_done"))
    level.player scripts\sp\utility::_id_65E3("hack_control_outro_done");

  scripts\sp\utility::_id_1034D("heist_plr_targetisstillal");
  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_ayesir3");
  scripts\engine\utility::flag_set("obj_gotokotch");
  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_botsarestanding");
  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_olympusc6sare");
  scripts\engine\utility::flag_wait("bridge_robot_control_dialogue");
  level.player thread scripts\sp\utility::_id_D090("ges_radio_safe");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  scripts\sp\utility::_id_1034D("heist_plr_allsatoforcesth");
  level.player playSound("ges_plr_radio_off");
  level.player scripts\sp\utility::_id_1102B("ges_radio_safe");
  scripts\engine\utility::flag_wait("player_approaching_kotch");
  scripts\engine\utility::flag_clear("obj_gotokotch");
  level._id_EA2C scripts\sp\utility::_id_10346("heist_slt_endthatbastardr");
  scripts\engine\utility::flag_set("obj_dealwithkotch");
}

_id_2FF1() {
  thread scripts\sp\maps\heist\heist_util::_id_C5F0("door_bridge_left", "door_bridge_right", 1);
  scripts\engine\utility::array_call(level.allies, ::_meth_8250, 1);
  var_0 = [level.player, level._id_EA2C, level._id_30F6, level._id_A54E];
  scripts\sp\maps\heist\heist_util::_id_1378F("on_the_bridge", var_0);

  while(distance(level.player.origin, level._id_A70E.origin) > 550)
    scripts\engine\utility::waitframe();

  scripts\sp\maps\heist\heist_util::_id_4264("door_bridge_left", "door_bridge_right", 0.5);
  scripts\engine\utility::flag_set("transient_mons_launch");
  wait 0.1;
  scripts\sp\utility::_id_BF97(undefined, undefined, 0);
}

_id_2FCE() {
  self._id_1FBB = "crawler";
  self notsolid();
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname");
  var_0 scripts\sp\anim::_id_1EE0(self, "dying_crawl_death_v2");
  scripts\engine\utility::flag_wait("kotch_death_start");
  self delete();
}

_id_3076() {
  self waittill("trigger");
  scripts\engine\utility::flag_set("bridge_robots_saluting");
  var_0 = level._id_306E[self.script_noteworthy];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(var_2) || !isalive(var_2)) {
      continue;
    }
    var_3 = var_2._id_1FE0;
    var_3 notify("stop_loop");

    if(isDefined(var_2.script_parameters) && var_2.script_parameters == "sit") {
      var_4 = var_2 scripts\sp\utility::_id_7A96();
      var_3 = var_4;
    }

    var_2 _meth_83A1();
    var_2 _id_E5A0();
    var_3 thread _id_306C(var_2);
    wait 0.2;
  }
}

_id_306C(var_0) {
  var_0 scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_7799, level.player, 0.15);
  var_0 playSound("scn_heist_bridge_c6_salute");
  thread scripts\sp\anim::_id_1F35(var_0, "c6bridge_salute");
  scripts\engine\utility::waitframe();
  scripts\sp\anim::_id_1F29(var_0, "c6bridge_salute", 0.75);
  self waittill("c6bridge_salute");
  var_0 thread scripts\sp\anim::_id_1EEA(var_0, "c6bridge_salute_idle");
}

_id_E5A0() {
  self.team = "allies";
  self.script_team = "allies";
  self.name = "SDF-G";
  var_0 = randomintrange(100, 1000);
  self.name = self.name + var_0;
}

_id_302A() {
  foreach(var_1 in level._id_3029) {
    if(!isDefined(var_1) || !isalive(var_1)) {
      continue;
    }
    _id_0E29::_id_877F(var_1);
  }

  wait 3;

  foreach(var_1 in level._id_3029) {
    if(!isDefined(var_1) || !isalive(var_1)) {
      continue;
    }
    var_1 _meth_83A1();
    var_1.struct notify("stop_loop");
    var_1._id_1FBB = "c6bridge";
    var_1 thread _id_306C(var_1);
    var_1 _id_E5A0();
    wait 0.2;
  }

  scripts\engine\utility::flag_wait("kotch_death_start");

  foreach(var_1 in level._id_3029) {
    if(!isDefined(var_1) || !isalive(var_1)) {
      continue;
    }
    var_1 delete();
  }
}

_id_EBF0() {
  setmusicstate("mx_222_heist_kill_kotch");
  level.player._id_1F1F = undefined;
  var_0 = 0.75;
  thread scripts\sp\maps\heist\heist_util::_id_1EFA("kotch_grab", undefined, 0.75, 1, undefined, 1);
  wait(var_0);
  var_1 = scripts\sp\utility::_id_10639("knife", level.player.origin);
  level.player._id_A6FB = var_1;
  var_1 linkTo(level.player._id_E505, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  self notify("stop_loop");
  var_2 = [level._id_A70E, level._id_A714];
  thread scripts\sp\anim::_id_1F2C(var_2, "kotch_grab");
  thread _id_EBF2();
  var_3 = getanimlength(level._id_A70E scripts\sp\utility::_id_7DC1("kotch_grab"));
  var_4 = level scripts\engine\utility::waittill_notify_or_timeout_return("player_knife_kotch", var_3);

  if(!isDefined(var_4))
    level waittill("kotch_death_complete");

  level.player._id_A6FB delete();
  level._id_A70E.a.nodeath = 1;
  level._id_A70E scripts\sp\utility::_id_1101B();
  level._id_A70E _meth_81D0();
  _id_EBF4();
}

_id_EBF2() {
  level endon("can_kill_timeout");
  level waittill("can_kill");

  for(;;) {
    if(level.player meleeButtonPressed()) {
      break;
    }

    wait 0.05;
  }

  level notify("player_knife_kotch");
  level._id_A70E scripts\engine\utility::delaycall(0.1, ::stopsounds);
  level._id_A70E thread _id_A719();
  level.player notify("stop_anim_player");
  level._id_A714 _meth_83A1();
  var_0 = [level.player._id_E505, level._id_A70E, level._id_A714];
  scripts\engine\utility::delaythread(3, scripts\sp\utility::_id_834F, "KILL_KOTCH");
  scripts\sp\anim::_id_1F2C(var_0, "kotch_kill");
  level notify("kotch_death_complete");
}

#using_animtree("generic_human");

_id_A716(var_0) {
  level endon("player_knife_kotch");
  var_0 hidepart("j_head", var_0.headmodel);
  var_0 hidepart("j_eyeball_le");
  var_0 hidepart("j_eyeball_ri");
  var_0 hidepart("j_tongue_1");
  var_0 _meth_82A2(%mayhem_heist_bridge_kotch_grab_kotch, 1.0, 0.0, 1.0);
  level waittill("kotch_grab_mayhem_stop");
  var_0 _meth_82A2(%mayhem_heist_bridge_kotch_grab_kotch, 0.0, 0.0, 1.0);
  var_0 showpart("j_head", var_0.headmodel);
  var_0 showpart("j_eyeball_le");
  var_0 showpart("j_eyeball_ri");
  var_0 showpart("j_tongue_1");
}

_id_A719() {
  self clearanim(%mayhem_heist_bridge_kotch_grab_kotch, 0);
  self _meth_82A2(%mayhem_heist_bridge_kotch_kill_kotch, 1.0, 0.0, 1.0);
  level waittill("kotch_kill_mayhem_stop");
  self _meth_82A2(%mayhem_heist_bridge_kotch_kill_kotch, 0.0, 0.0, 1.0);
  self showpart("j_head", self.headmodel);
  self showpart("j_eyeball_le");
  self showpart("j_eyeball_ri");
  self showpart("j_tongue_1");
}

_id_A5F0() {
  level waittill("can_kill");
  var_0 = scripts\sp\hud_util::createfontstring("objective", 2);
  var_0 scripts\sp\hud_util::setpoint("CENTER", undefined, 0, 150);
  var_0.alpha = 0;
  var_0 settext(&"HEIST_KILL_KOTCH");
  var_0 fadeovertime(6);
  var_0.alpha = 0.5;
  var_1 = level scripts\engine\utility::waittill_any_return("player_knife_kotch", "can_kill_timeout");

  if(var_1 == "can_kill_timeout") {
    var_0 fadeovertime(1);
    var_0.alpha = 0;
    wait 1.5;
  }

  var_0 destroy();
}

_id_A712(var_0) {
  playFXOnTag(scripts\engine\utility::getfx("vfx_eu_blood_stab_01"), level.player._id_A6FB, "tag_knife_fx");
}

_id_10CB1() {
  scripts\sp\maps\heist\heist_util::_id_1065E();
  scripts\sp\maps\heist\heist_util::_id_106D9();
  scripts\sp\maps\heist\heist_util::_id_107BE();
  scripts\sp\maps\heist\heist_util::_id_1074D();
  thread _id_30CB();
  thread _id_EBF4();
  level._id_306D = [];
}

_id_B211() {
  var_0 = scripts\engine\utility::getStructArray("start_bridge_interior", "targetname");
  var_1 = getEntArray("bridge_robots_front", "script_noteworthy");

  for(var_2 = 0; var_2 < level._id_306D.size; var_2++) {
    if(isDefined(level._id_306D[var_2]))
      level._id_306D[var_2] delete();
  }

  if(isDefined(level._id_BA7F)) {
    var_3 = spawn("script_model", level._id_BA7F.origin);
    var_3.angles = level._id_BA7F.angles;
    var_3 setModel(level._id_BA7F.model);
  }

  if(isDefined(level._id_EA2C._id_13C4D))
    level._id_EA2C._id_13C4D delete();

  scripts\engine\utility::delaythread(5, scripts\sp\utility::_id_BF98);
  scripts\engine\utility::flag_set("transient_mons_launch");
  thread _id_BAC4();
  scripts\engine\utility::flag_set("bridge_shields_open");
  getEnt("launch_window_jackal", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_BAC3, 0.75, 1);
  getEnt("launch_chase_jackal_01", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_BAC3, 0.5, 4);
  getEnt("launch_chase_jackal_02", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_BAC3, 1.5, 5);
  scripts\engine\utility::delaythread(6, scripts\sp\vehicle::_id_1080F, "launch_chase_jackals");
  scripts\sp\utility::_id_22CA("bridge_enemy_destroyers", ::_id_2FFF);
  scripts\sp\vehicle::_id_1080F("bridge_enemy_destroyers");
  var_4 = getEnt("mons_bridge_retribution", "targetname");
  var_4._id_EEF9 = "missile_cluster_turret_un cannon_small_un,1,1,amb_turret_sml_t_l_1,amb_turret_sml_t_l_2,amb_turret_sml_t_l_3,amb_turret_sml_t_l_4,amb_turret_sml_t_r_1,amb_turret_sml_t_r_2,amb_turret_sml_t_r_3,amb_turret_sml_t_r_4";
  var_4 scripts\sp\utility::_id_1747(::_id_BA57);
  scripts\sp\vehicle::_id_1080D("mons_bridge_retribution");
  thread _id_BAC6();
  wait 10;
  var_5 = scripts\sp\hud_util::createfontstring("objective", 2);
  var_5 scripts\sp\hud_util::setpoint("CENTER", undefined, 0, 100);
  var_5 settext(&"HEIST_GO_FLIGHT");
  scripts\engine\utility::flag_set("obj_initiatelaunch");
  thread _id_3039();

  for(;;) {
    if(level.player useButtonPressed()) {
      break;
    }

    wait 0.05;
  }

  level notify("player_go_flight");
  var_5 destroy();
  level.player lerpviewangleclamp(1.3, 0.5, 0.75, 0, 0, 0, 0);
  scripts\sp\utility::_id_1034D("heist_plr_olympusmons");
  var_6 = level.player getcurrentweapon();
  level.player giveweapon("iw7_gunless");
  level.player switchtoweapon("iw7_gunless");
  level.player disableweaponswitch();
  wait 0.2;
  level.player enableweapons();
  scripts\engine\utility::waitframe();
  level.player thread scripts\sp\utility::_id_D090("ges_point_firm_nondirectional");
  wait 0.3;
  scripts\sp\utility::_id_1034D("heist_plr_goflight");
  scripts\engine\utility::flag_clear("obj_initiatelaunch");
  level.player takeweapon("iw7_gunless");
  level.player switchtoweapon(var_6);
  level.player _meth_82C0("fade_to_black_minus_music", 0.3);
  scripts\sp\utility::_id_BF95();
}

_id_BAC4() {
  setsuncolorandintensity(0);
  var_0 = getEnt("lgt_mons_launch_fill", "script_noteworthy");
  var_0 setlightintensity(0);
  var_1 = getEnt("lgt_mons_launch_fill_sun", "script_noteworthy");
  var_1 setlightintensity(0);
  setsundirection(anglesToForward((-21, -42, 0)));
  scripts\engine\utility::flag_wait("bridge_shields_open");
  wait 6.5;
  setsuncolorandintensity(70);
  visionsetnaked("heist_int_mons_bridge_sun_flash", 3);
  var_1 thread scripts\sp\lights::_id_AB83(600, 8);
  wait 3;
  var_0 thread scripts\sp\lights::_id_AB83(80, 5);
  wait 6;
  visionsetnaked("heist_int_mons_bridge_sun", 5);
  var_1 thread scripts\sp\lights::_id_AB83(0, 5);
  var_0 thread scripts\sp\lights::_id_AB83(10, 5);
  visionsetalternate(1, 2);
  wait 5;
  visionsetnaked("", 2);
}

_id_BAC5() {
  scripts\sp\maps\heist\heist_util::_id_96E0();

  for(;;) {
    var_0 = randomintrange(25, 50);
    level._id_8632 rotateTo((0, 0, var_0), 5, 0.25, 0.25);
    level._id_8632 waittill("rotatedone");
    var_0 = randomintrange(-50, -25);
    level._id_8632 rotateTo((0, 0, var_0), 5, 0.25, 0.25);
    level._id_8632 waittill("rotatedone");
  }
}

_id_3039() {
  level endon("player_go_flight");
  wait 6;
  level._id_EA2C scripts\sp\utility::_id_10346("heist_slt_keyitcaptain");
  wait 6;
  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_captainwererea");
  wait 6;
  level._id_EA2C scripts\sp\utility::_id_10346("heist_slt_letsmove");
}

_id_30CB() {
  var_0 = scripts\engine\utility::getStruct("bridge_window_shields", "targetname");
  var_0.origin = var_0.origin + (0, 0, -1.5);
  var_1 = scripts\sp\utility::_id_10639("bridge_window_shields", var_0.origin, var_0.angles);
  var_0 scripts\sp\anim::_id_1EC3(var_1, "shields_open");
  scripts\engine\utility::flag_wait("bridge_shields_open");
  wait 5.5;
  level.player playSound("scn_heist_mons_windows_down_lr");
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "shields_open");
  scripts\engine\utility::waitframe();
  var_0 scripts\sp\anim::_id_1F29(var_1, "shields_open", 0.25);
}

_id_BAC6() {
  level._id_EA2C scripts\sp\utility::_id_72EC("iw7_m4+acogm4", "primary");
  var_0 = scripts\engine\utility::getStruct("scene_mons_breach", "targetname");
  var_0 notify("ethan_stop_loop");
  var_1 = scripts\engine\utility::getStruct("struct_bridge_scene", "targetname");
  var_1 scripts\sp\anim::_id_1F2C([level._id_EA2C, level._id_6754, level._id_30F6, level._id_A54E], "mons_launch");
  var_1 thread scripts\sp\anim::_id_1EE7([level._id_EA2C, level._id_6754, level._id_30F6, level._id_A54E], "mons_launch_idle");
}

_id_EBF4() {
  var_0 = scripts\engine\utility::getStruct("struct_bridge_scene", "targetname");
  level.player._id_1EDE = 1;
  var_0 thread scripts\sp\maps\heist\heist_util::_id_1EFA("kotch_kill", undefined, undefined, 1);
  var_1 = 25;
  level.player playerlinktodelta(level.player._id_E505, "tag_player", 1, var_1, var_1, var_1, 15, 1);
  level.player setviewangleresistance(60, 60, 60, 30, 1);
}

_id_BA57() {
  self dontcastdistantshadows();
  self dontcastshadows();
  self notsolid();
  level._id_39DD["cannon_small_un"]._id_10241._id_10943 = ::_id_E3A3;
  wait 0.05;
  thread _id_0BB6::_id_3966(1, 0, level._id_2FED[0], level._id_2FED[1]);
  thread _id_306B(level._id_2FED[0], 25, 0.15);
  wait 3;
  thread _id_306B(level._id_2FED[1], 25, 0.15);
  self waittill("reached_end_node");
  var_0 = scripts\sp\vehicle::_id_1080C("ret_empty_heli");
  var_0 setvehgoalpos(self.origin, 1);
  var_0 vehicle_teleport(self.origin, self.angles);
  self linkTo(var_0);
  var_0 setmaxpitchroll(0, 20);
  var_0 setyawspeed(10, 5, 5);
  var_0 sethoverparams(100, 10, 5);
  var_0 setvehgoalpos(self.origin, 1);
}

_id_E3A3(var_0) {
  self shootturret(var_0);
}

_id_BAC3(var_0, var_1) {
  var_2 = self.spawner;
  var_3 = var_2 scripts\sp\utility::_id_7A8E();
  var_3 scripts\engine\utility::delaythread(var_0, scripts\sp\vehicle::_id_1080B);
  wait(var_1);

  if(isDefined(var_2._id_ED46))
    self._id_72B1 = scripts\sp\utility::_id_7DC3(var_2._id_ED46);

  self notify("death");
}

_id_306B(var_0, var_1, var_2) {
  var_0 endon("death");

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = scripts\engine\utility::spawn_tag_origin();
    var_5 = anglesToForward(self.angles);
    var_4.origin = self.origin + (0, 0, 1000);
    var_4.origin = var_4.origin + var_5 * 3000;
    var_4 thread _id_0B76::_id_A332(var_0, 1, undefined, "vfx_heist_player_missile");

    if(isDefined(var_2))
      wait(var_2);
  }
}

_id_2FFF() {
  self dontcastdistantshadows();
  self dontcastshadows();
  self._id_4E09 = "vfx_heist_building_explosion_lrg";
  scripts\engine\utility::waitframe();
  _id_0BB8::_id_39CD("off_kill");
  level._id_2FED[self.script_index] = self;

  if(self.script_index == 0) {
    wait 10;
    earthquake(0.3, 2, level.player.origin, 999);
  } else {
    wait 13;
    earthquake(0.2, 1.5, level.player.origin, 999);
  }

  var_0 = anglesToForward(self.angles);
  var_1 = anglestoright(self.angles) * 4000;
  var_2 = anglestoup(self.angles);
  var_3 = [self.origin + var_0 * -7000 + var_2 * randomintrange(-1024, 1024) + var_1, self.origin + var_0 * -5000 + var_2 * randomintrange(-1024, 1024) + var_1, self.origin + var_0 * -3000 + var_2 * randomintrange(-1024, 1024) + var_1, self.origin + var_2 * randomintrange(-1024, 1024) + var_1, self.origin + var_0 * 3000 + var_2 * randomintrange(-1024, 1024) + var_1, self.origin + var_0 * 5000 + var_2 * randomintrange(-1024, 1024) + var_1, self.origin + var_0 * 7000 + var_2 * randomintrange(-1024, 1024) + var_1, self.origin + var_0 * 9000 + var_2 * randomintrange(-1024, 1024) + var_1, self.origin + var_0 * 11000 + var_2 * randomintrange(-1024, 1024) + var_1, self.origin + var_0 * 14000 + var_2 * randomintrange(-1024, 1024) + var_1];
  var_4 = self._id_4E09;

  foreach(var_6 in var_3) {
    var_7 = (self.angles[0], randomintrange(1, 365), self.angles[2]);
    playFX(level._effect[var_4], var_6, anglesToForward(var_7), var_2);
    wait(randomfloatrange(0.1, 0.3));
  }

  self notify("death");
  scripts\engine\utility::waitframe();
  self delete();
}

_id_9685() {
  if(isDefined(level._id_BA52)) {
    return;
  }
  level._id_BA52 = scripts\engine\utility::get_target_ent("heist_mons_bridge_mover");
  var_0 = scripts\engine\utility::getStruct("bm_link_pos", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("loc_bridge_mover_1", "targetname");
  level._id_BA52.origin = var_0.origin;
  level._id_BA52.angles = var_0.angles;
  var_2 = scripts\engine\utility::getStruct("ref_bridge_shield_top_move1", "targetname");
  var_3 = scripts\engine\utility::getStruct("ref_bridge_shield_bottom_move1", "targetname");
  var_4 = scripts\engine\utility::getStruct("ref_bridge_shield_bottom_move2", "targetname");
  level._id_BA59 = var_2 scripts\engine\utility::spawn_tag_origin();
  level._id_BA54 = var_3 scripts\engine\utility::spawn_tag_origin();
  level._id_BA55 = var_4 scripts\engine\utility::spawn_tag_origin();
  level._id_BA59 linkTo(level._id_BA52);
  level._id_BA54 linkTo(level._id_BA52);
  level._id_BA55 linkTo(level._id_BA52);
  level._id_BA52.origin = var_1.origin;
  level._id_BA52.angles = var_1.angles;
  scripts\engine\utility::waitframe();
  level._id_BA52 _meth_80AF(undefined);
}

_id_BC44() {
  if(isDefined(level._id_C413)) {
    return;
  }
  var_0 = scripts\engine\utility::get_target_ent("heist_om_vehicle");
  level._id_C413 = var_0 scripts\sp\utility::_id_10808();
  var_1 = scripts\engine\utility::getStruct("loc_bridge_mover_1", "targetname");

  if(level._id_BA52.origin == var_1.origin && level._id_BA52.angles == var_1.angles)
    level._id_BA52 _meth_83C9(undefined);

  var_1 = scripts\engine\utility::getStruct("om_link_point", "script_noteworthy");
  level._id_BA52 dontinterpolate();
  level._id_BA52.origin = var_1.origin;
  level._id_BA52.angles = var_1.angles;
  level._id_BA52 linkTo(level._id_C413);
  var_2 = getvehiclenode("om_geneva_skybox_spot", "targetname");
  level._id_C413 vehicle_teleport(var_2.origin, var_2.angles);
  scripts\engine\utility::waitframe();
  level._id_BA52 _meth_80AF(undefined);
  scripts\engine\utility::flag_set("pre_load_mons_launch");
}

_id_8D15(var_0) {
  self attachpath(var_0);
  thread scripts\sp\vehicle::_id_1321A(var_0);
  scripts\sp\vehicle_paths::_id_845A(self);
}