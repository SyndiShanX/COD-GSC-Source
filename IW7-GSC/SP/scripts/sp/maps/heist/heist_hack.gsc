/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\heist\heist_hack.gsc
************************************************/

_id_10C70() {
  scripts\sp\maps\heist\heist_util::_id_968E();
  scripts\sp\maps\heist\heist_util::_id_1065E();
  scripts\sp\maps\heist\heist_util::_id_106D9();
  scripts\sp\maps\heist\heist_util::_id_107BE();
  scripts\sp\maps\heist\heist_util::_id_1074D();
  scripts\sp\utility::_id_F5AF("start_mons_interior", [level.player, level._id_6754, level._id_30F6, level._id_EA2C, level._id_A54E]);
  level.player giveweapon("hackingdevice");
  level.player givemaxammo("hackingdevice");
  var_0 = scripts\engine\utility::getStruct("scene_mons_breach", "targetname");
  scripts\engine\utility::array_thread(level.allies, scripts\sp\maps\heist\heist_breach::_id_1CD0, var_0, 1);
}

_id_B1EF() {
  scripts\engine\utility::flag_clear("obj_gettobridge");
  thread scripts\sp\utility::_id_28D7("axis");
  thread scripts\sp\utility::_id_28D7("allies");
  thread scripts\sp\utility::_id_CF8B();
  level._id_3031 = [];
  thread _id_0E29::_id_87ED(1);
  thread _id_0E29::_id_8781(0);
  thread _id_2FE6();
  thread _id_87C0();
  thread _id_87AD();
  thread _id_D83C();
  setsuncolorandintensity(0);
  var_0 = getEnt("bridge_console_keyboard", "targetname");
  var_0 setModel("sdf_console_control_panel_11_scale_off");
  getEnt("bridge_console_blood", "targetname") hide();
  scripts\sp\maps\heist\heist_util::_id_10751();
  level._id_A70E.allowdeath = 1;
  level._id_A70E scripts\sp\utility::_id_72EC("iw7_nrg", "primary");
  level._id_A70E scripts\sp\utility::_id_86E4();
  scripts\sp\utility::_id_9187("heistBridgeHack", 100, ::_id_919D);
  scripts\sp\utility::_id_9187("heistHighlightKotch", 1000, ::_id_919E);
  _id_0E29::_id_87A0([level._id_A70E], "heistBridgeHack");
  _id_0E29::_id_87CC(1, "hack_c6_control_mons_bridge");
  level._id_A714 = scripts\sp\utility::_id_10639("bridge_chair");
  var_1 = scripts\engine\utility::getStruct("mons_bridge_chair", "targetname");
  level._id_A714.origin = var_1.origin;
  level._id_A714.angles = var_1.angles;
  _id_0E29::_id_87CB(1, 99999);
  var_2 = scripts\engine\utility::getStruct("struct_bridge_scene", "targetname");
  var_2 thread scripts\sp\anim::_id_1EEA(level._id_A70E, "kotch_attack_idle");
  thread _id_544D();
  thread scripts\sp\maps\heist\heist_bridge::_id_30CB();
  level._id_1650 = undefined;
  thread _id_D257();
  thread _id_689E();
  _id_0E29::_id_87F3();
  level.player _meth_84FE();
  scripts\sp\maps\heist\heist_util::_id_5569(["crouch", "prone"]);
  level.player scripts\sp\utility::_id_D2CD(55, 0.05);
  level.player _meth_80D8(0.5, 0.5);
  level._id_EA2C scripts\sp\utility::_id_77B9(0.05);
  level._id_30F6 scripts\sp\utility::_id_77B9(0.05);
  var_1 = scripts\engine\utility::getStruct("post_hack_player_struct", "targetname");
  _id_0E29::_id_87E1(var_1.origin, var_1.angles);
  level notify("stop_ally_postbreach_idle");
  scripts\engine\utility::getStruct("scene_mons_breach", "targetname") notify("stop_loop");
  thread scripts\sp\maps\heist\heist_bridge::_id_A71A();
  level._id_880E = scripts\engine\utility::spawn_tag_origin();
  level._id_880E.origin = level.player.origin + (15, 0, 75);
  level._id_880E linkTo(level.player);
  var_3 = 1.5;

  if(level._id_880F._id_1FBB == "c6worker_hack_1")
    var_3 = 2.25;

  scripts\engine\utility::delaythread(var_3, ::_id_A70F);
  scripts\engine\utility::delaythread(2, ::_id_544E);
  level.player._id_10CCA = level.player.origin;
  level.player._id_10BA1 = level.player.angles;
  level.player._id_C3E1 = level.player _meth_816C();
  thread _id_2FD0();
  level.player thread _id_4D4F();
  level.player scripts\engine\utility::delaycall(0.05, ::setthreatbiasgroup);
  level.player scripts\engine\utility::delaycall(0.05, ::setviewkickscale, 0);
  _id_1065C();
  thread _id_6AC5();
  var_4 = spawnStruct();
  var_4._id_10DA6 = 1;
  var_4._id_92DC = "bridge_alerted";
  var_4._id_1115E = "struct_roundhouse";
  var_4._id_92FC = "struct_roundhouse_idle";
  var_4._id_DD5F = "struct_roundhouse_react";
  var_4._id_DD36 = 0.5;
  var_4._id_DD35 = "heist_sdf5_targetthatc6";
  var_4._id_DD2F = 56;
  var_4._id_56F3 = 128;
  var_4._id_1024D = 1;
  var_4._id_1FB0 = "roundhouse_punch_idle";
  var_4._id_1FB1 = "roundhouse_punch";
  var_4._id_1FB2 = "alert_react";
  var_4._id_6529 = "enemy_roundhouse";
  var_4._id_00F2 = "back";
  var_4._id_50AD = [0, 30];
  var_4._id_50AC = [0, 30];
  var_4._id_6DCD = 1;
  thread _id_6846(var_4, 1);
  thread scripts\sp\maps\heist\heist_util::_id_6E55("hack_sequence_complete", ::_id_11000, var_4);
  var_4 = spawnStruct();
  var_4._id_10DA6 = 1;
  var_4._id_92DC = "bridge_alerted";
  var_4._id_1115E = "struct_opsmap_slam";
  var_4._id_92FC = "struct_opsmap_slam_idle";
  var_4._id_DD5F = "struct_opsmap_slam_react";
  var_4._id_DD36 = 1.25;
  var_4._id_DD35 = "heist_sdf0_wereunderattack";
  var_4._id_56F3 = 128;
  var_4._id_1FB0 = "opsmap_slam_idle";
  var_4._id_1FB1 = "opsmap_slam";
  var_4._id_1FB2 = "alert_react";
  var_4._id_DD2E = 1.25;
  var_4._id_6529 = "enemy_opsmap_slam";
  var_4._id_00F2 = "back";
  var_4._id_50AD = [150, 180];
  var_4._id_50AC = [150, 180];
  thread _id_6846(var_4, 1);
  thread scripts\sp\maps\heist\heist_util::_id_6E55("hack_sequence_complete", ::_id_11000, var_4);
  thread _id_10C17();
  scripts\engine\utility::flag_wait("bridge_alerted");
  level.player thread _id_E5A5();
  thread _id_1064A();
  thread _id_306A();
  var_4 = spawnStruct();
  var_4._id_1115E = "struct_bridge_ramp";
  var_4._id_56F3 = 128;
  var_4._id_DC1A = 1;
  var_4._id_1FB1 = "ramp_kick";
  var_4._id_6529 = "enemy_ramp_kick";
  var_4._id_DD36 = 4;
  var_4._id_DD35 = "heist_sdf1_theyusingbots";
  var_4._id_00F2 = "back";
  var_4._id_50AD = [150, 180];
  var_4._id_50AC = [150, 180];
  thread _id_6846(var_4, 1);
  thread scripts\sp\maps\heist\heist_util::_id_6E55("hack_sequence_complete", ::_id_11000, var_4);
  var_4 = spawnStruct();
  var_4._id_1115E = "struct_bridge_shove";
  var_4._id_56F3 = 128;
  var_4._id_AB5B = 1;
  var_4._id_1FB1 = "shove";
  var_4._id_6529 = "enemy_shove";
  var_4._id_00F2 = "back";
  var_4._id_50AD = [140, 180];
  var_4._id_50AC = [130, 180];
  thread _id_6846(var_4);
  thread scripts\sp\maps\heist\heist_util::_id_6E55("hack_sequence_complete", ::_id_11000, var_4);
  _id_685B(var_2);

  if(scripts\engine\utility::flag("self_destruct_started"))
    level waittill("forever");

  if(isDefined(level._id_30B3))
    scripts\sp\utility::_id_228A(level._id_30B3);

  if(isDefined(level._id_880F))
    level._id_880F delete();

  level.player scripts\engine\utility::delaycall(5, ::setviewkickscale, level.player._id_C3E1);
  level.player showviewmodel();
  level.player _meth_84FD();
  scripts\sp\maps\heist\heist_util::_id_6229(["crouch", "prone"]);
  level.player _meth_80A1();
  level.player._id_1F1F = undefined;
  scripts\sp\maps\heist\heist_util::_id_1EFB();
  thread _id_D6D3();
  level._id_880E delete();
  scripts\engine\utility::flag_set("hack_sequence_complete");
  scripts\engine\utility::flag_clear("obj_stopkotch");
}

_id_689E() {
  var_0[0] = scripts\engine\utility::getStruct("struct_robothack1", "targetname");
  var_0[1] = scripts\engine\utility::getStruct("struct_robothack2", "targetname");
  var_1 = scripts\sp\utility::_id_22CD("robots_to_hack");
  level._id_3029 = var_1;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2]._id_1FBB = "c6worker_hack_" + var_2;
    var_0[var_2] thread scripts\sp\anim::_id_1EEA(var_1[var_2], "robothack_idle");
    var_1[var_2].struct = var_0[var_2];
    var_1[var_2]._id_11A0A = scripts\sp\utility::_id_10639("blowtorch");
    var_1[var_2]._id_11A0A linkTo(var_1[var_2], "tag_accessory_left", (0, 0, 0), (0, 0, 0));
    var_1[var_2].allowdeath = 1;
    var_1[var_2].ignoreme = 1;
  }

  for(;;) {
    scripts\engine\utility::flag_wait("secondary_equipment_in_use");

    if(level.player scripts\sp\utility::_id_D1DF(var_1[0].origin + (0, 0, 32), 0.5, 1) || level.player scripts\sp\utility::_id_D1DF(var_1[1].origin + (0, 0, 32), 0.5, 1)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  wait 0.75;
  thread _id_544C();
  level notify("player_hack_locking_on");
  level._id_880F = _id_0E29::_id_87F3();
  scripts\engine\utility::flag_set("player_in_bot");
  setmusicstate("mx_277_kotch_room");
  thread _id_8810();

  foreach(var_4 in var_1) {
    var_4 scripts\sp\utility::anim_stopanimScripted();

    if(var_4 != level._id_880F) {
      var_4.allowdeath = 1;
      var_4.ignoreme = 1;
      continue;
    }

    var_4 delete();
  }
}

_id_8810() {
  var_0 = level._id_880F._id_11A0A;
  var_0 unlink();
  var_1 = "bootup_stand";

  if(level._id_880F._id_1FBB == "c6worker_hack_1")
    var_1 = "bootup_kneel";

  var_2 = scripts\engine\utility::getStruct("hack_bootup_struct", "targetname");
  wait 1.25;
  var_2 thread scripts\sp\anim::_id_1F35(var_0, var_1);
  scripts\sp\maps\heist\heist_util::_id_5569("weapons");
  level.player._id_1F1F = "player_rig_c6";
  var_2 scripts\sp\maps\heist\heist_util::_id_1EFA(var_1, undefined, undefined, undefined, undefined, 1);
  scripts\sp\maps\heist\heist_util::_id_6229("weapons");
  var_0 delete();
}

_id_685B(var_0) {
  level endon("self_destruct_started");

  while(distance2d(level.player.origin, level._id_A70E.origin) > 250)
    wait 0.05;

  var_0 notify("stop_loop");
  level._id_A70E _meth_83A1();
  level._id_A70E scripts\sp\utility::_id_86E2();
  var_0 scripts\sp\anim::_id_1F35(level._id_A70E, "kotch_draw_pistol");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_A70E, "kotch_shoot_pistol");
  _id_137A5(level._id_A70E, 128);
  level notify("kotch_attack_started");
  level notify("stop_damagefunc_hacked_robot");
  level notify("stop_robotcop_gesture");
  level.player scripts\sp\utility::_id_1102B("ges_c6_heist_defensivehands");
  level._id_A70E thread scripts\sp\utility::_id_918C();
  level scripts\engine\utility::delaythread(1.5, ::_id_10FD6);
  scripts\engine\utility::delaythread(7, _id_0E29::_id_87A1);
  setmusicstate("");
  level._id_A70E stopsounds();
  level.player _meth_818A();
  var_0 notify("stop_loop");
  level._id_A70E scripts\sp\utility::anim_stopanimScripted();
  level.player._id_1F1F = "player_rig_c6";
  var_0 thread scripts\sp\maps\heist\heist_util::_id_1EFA("kotch_attack", undefined, 0.1, 1, undefined, 1);
  wait 0.1;
  var_1 = [level._id_A70E, level._id_A714];
  var_0 scripts\sp\anim::_id_1F2C(var_1, "kotch_attack");
}

_id_6846(var_0, var_1) {
  level endon("stop_" + var_0._id_1FB1);
  var_2 = scripts\engine\utility::getStruct(var_0._id_1115E, "targetname");
  var_3 = scripts\sp\utility::_id_22CD(var_0._id_6529, 1);
  var_0.enemies = var_3;
  var_4 = undefined;
  var_5 = undefined;

  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_3[var_6].ignoreall = 0;
    var_3[var_6] scripts\sp\utility::_id_F2D8(1000);
    var_3[var_6]._id_6BAD[var_6] = level.player;
    var_3[var_6].a.disablelongdeath = 1;
    var_3[var_6] setCanDamage(1);
    var_3[var_6].allowdeath = 1;
    var_3[var_6] scripts\sp\utility::_id_5564();
    var_3[var_6].ignorerandombulletdamage = 1;
    var_3[var_6] allowedstances("stand");
    var_3[var_6]._id_C05C = 1;

    if(var_6 == 0) {
      var_4 = var_3[var_6];
      var_3[var_6]._id_1FBB = "bridge_guy_main";
      var_5 = var_3[var_6];
    } else
      var_3[var_6]._id_1FBB = "bridge_guy_extra";

    if(isDefined(var_0._id_DC1A) && var_0._id_DC1A)
      var_3[var_6]._id_DC1A = 1;

    if(!isDefined(level._id_3028))
      level._id_3028 = [];

    if(!isDefined(level._id_3028[var_0._id_1FB1]))
      level._id_3028[var_0._id_1FB1] = [];

    level._id_3028[var_0._id_1FB1][level._id_3028[var_0._id_1FB1].size] = var_3[var_6];

    if(scripts\engine\utility::is_true(var_0._id_6DCD))
      level._id_3012 = var_3[var_6];

    var_3[var_6]._id_EBEA = var_0;
  }

  if(var_0._id_1FB1 == "opsmap_slam") {
    var_7 = scripts\engine\utility::getStruct("struct_opsmap_start", "targetname");
    var_5 _meth_80F1(var_7.origin, var_7.angles);
    var_5 setgoalpos(var_7.origin);
    var_5.fixednode = 1;
    var_5 scripts\sp\utility::_id_51E1("casual_gun");
    wait 3;
    var_8 = scripts\engine\utility::getStruct(var_0._id_92FC, "targetname");
    var_8 scripts\sp\anim::_id_1F17(var_5, var_0._id_1FB0);
    var_5 scripts\sp\utility::_id_4145();
  }

  var_8 = undefined;

  if(isDefined(var_0._id_10DA6) && var_0._id_10DA6) {
    var_8 = scripts\engine\utility::getStruct(var_0._id_92FC, "targetname");
    var_8 thread scripts\sp\anim::_id_1EE7(var_3, var_0._id_1FB0);
  }

  foreach(var_10 in var_3) {
    var_2 thread _id_B595(var_10, var_0);
    thread _id_B5AB(var_10, var_0);
  }

  _id_137A5(var_4, var_0._id_56F3, var_0._id_00F2, var_0._id_50AD, var_0._id_50AC, var_2);
  level._id_1650 = undefined;

  if(!isDefined(var_4) || !isalive(var_4)) {
    return;
  }
  scripts\engine\utility::flag_set("bridge_alerted");
  scripts\engine\utility::flag_set("hacked_robot_scene_active");
  level notify("hacked_robot_scene_ " + var_0._id_1FB1);
  scripts\engine\utility::array_thread(var_3, scripts\sp\utility::_id_F225, "unlink_scene_guy");

  foreach(var_10 in var_3)
  var_2 scripts\sp\anim::_id_1EC3(var_10, var_0._id_1FB1);

  level.player _meth_818A();
  level.player._id_1F1F = "player_rig_c6";

  if(!isDefined(var_1))
    var_2 thread scripts\sp\maps\heist\heist_util::_id_1EFA(var_0._id_1FB1, undefined, 0.1);
  else
    var_2 thread _id_8817(var_0._id_1FB1, var_5);

  if(isDefined(var_0._id_AB5B) && var_0._id_AB5B) {
    level.player._id_AB5B = scripts\sp\utility::_id_10639("player_rig_c6_legs");
    var_2 thread scripts\sp\anim::_id_1F35(level.player._id_AB5B, var_0._id_1FB1);
  }

  if(isDefined(var_8))
    var_8 notify("stop_loop");

  level notify("starting_robot_melee");
  scripts\engine\utility::array_thread(var_3, ::_id_8812, var_2, var_0._id_1FB1);
  level.player scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "melee_early_breakout");
  scripts\sp\utility::_id_178D(scripts\engine\utility::_timeout, getanimlength(level.player._id_E505 scripts\sp\utility::_id_7DC1(var_0._id_1FB1)));
  scripts\sp\utility::_id_57D6();
  var_2.finished = 1;
  thread _id_EBF9();

  if(isDefined(level.player._id_AB5B))
    level.player._id_AB5B delete();

  level.player showviewmodel();
  scripts\engine\utility::flag_clear("hacked_robot_scene_active");
}

_id_EBF9() {
  level notify("hacked_robot_slowlerp");
  level endon("hacked_robot_slowlerp");
  var_0 = 1.5;
  var_1 = var_0 / 0.05;
  var_2 = 0.2;
  var_3 = 0.5;
  var_4 = var_3 / (var_1 + var_2);

  for(var_5 = 0; var_5 < var_1; var_5++) {
    level.player _meth_80D8(var_2, var_2);
    var_2 = var_2 + var_4;
    wait 0.05;
  }
}

_id_8817(var_0, var_1) {
  var_2 = var_1 scripts\sp\utility::_id_7DC1(var_0);
  var_3 = getanimlength(var_2);
  var_4 = getnotetracktimes(var_2, "lerp_end")[0];
  var_5 = var_3 * var_4;
  var_6 = self.origin;
  var_7 = self.angles;
  var_8 = (level.player.origin[0], level.player.origin[1], var_6[2]);
  var_9 = level.player.angles;
  var_10 = scripts\engine\utility::spawn_tag_origin(var_8, var_9);
  var_11 = scripts\engine\utility::spawn_tag_origin(level.player.origin, var_9);
  var_11 linkTo(var_10);
  level.player._id_E505 = scripts\sp\utility::_id_10639("player_rig_c6", level.player.origin, var_9);
  var_11 scripts\sp\anim::_id_1EC3(level.player._id_E505, var_0, "tag_origin");
  level.player._id_E505 linkTo(var_11);
  var_11 thread scripts\sp\maps\heist\heist_util::_id_1EFA(var_0, undefined, undefined, undefined, undefined, 1, 0.1);
  thread _id_881D(var_5);
  var_10 moveTo(var_6, var_5, var_5 / 2, 0);
  var_10 rotateTo(var_7, var_5, var_5 / 2, 0);
  var_12 = level.player._id_E505 scripts\sp\utility::_id_7DC1(var_0);
  var_4 = getnotetracktimes(var_12, "end_early")[0];

  if(isDefined(var_4)) {
    var_3 = getanimlength(var_12);
    var_5 = var_3 * var_4;
    wait(var_5);
    var_13 = var_3 - var_5;
    var_14 = gettime();
    var_15 = 0;

    while(gettime() - var_14 < var_13) {
      var_16 = level.player getnormalizedmovement();

      if(var_16[0] > 0.75) {
        level.player notify("melee_early_breakout");
        var_15 = 1;
        break;
      }

      wait 0.05;
    }

    if(var_15)
      scripts\sp\maps\heist\heist_util::_id_1EFB();
  }
}

_id_B595(var_0, var_1) {
  var_0 endon("death");
  level endon("hacked_robot_scene_ " + var_1._id_1FB1);

  if(isDefined(var_1._id_92DC)) {
    if(isDefined(var_1._id_DD2F))
      var_0 childthread _id_881F(var_1._id_DD2F, var_1._id_92DC);

    scripts\engine\utility::flag_wait(var_1._id_92DC);
    scripts\engine\utility::flag_set("melee_interrupted");

    if(isDefined(var_1._id_DD2E))
      wait(var_1._id_DD2E);

    var_2 = scripts\engine\utility::getStruct(var_1._id_92FC, "targetname");
    var_2 notify("stop_loop");
    var_0 _meth_83A1();

    if(isDefined(var_1._id_1FB2)) {
      var_3 = self;

      if(isDefined(var_1._id_DD5F))
        var_3 = scripts\engine\utility::getStruct(var_1._id_DD5F, "targetname");

      var_3 scripts\sp\anim::_id_1ECB(var_0, var_1._id_1FB2);
    }

    var_0 _meth_82DE(level._id_880E);
  }

  if(isDefined(var_1._id_1024D)) {
    return;
  }
  scripts\sp\anim::_id_1F50([var_0], var_1._id_1FB1);
  var_4 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(var_4);
  scripts\engine\utility::waittill_any_ents(var_0, "unlink_scene_guy", level, "unlink_scene_guys");
  var_4 delete();
}

_id_B5AB(var_0, var_1) {
  var_0 endon("death");
  level endon("hacked_robot_scene_ " + var_1._id_1FB1);

  if(isDefined(var_1._id_92DC)) {
    scripts\engine\utility::flag_wait(var_1._id_92DC);

    if(isDefined(var_1._id_DD2E))
      wait(var_1._id_DD2E);
  }

  if(isDefined(var_1._id_DD35)) {
    var_2 = 0;

    if(isDefined(var_1._id_DD36))
      var_2 = var_1._id_DD36;

    var_0 scripts\engine\utility::delaythread(var_2, scripts\sp\utility::play_sound_on_entity, var_1._id_DD35);
  }
}

_id_881F(var_0, var_1) {
  while(distance2d(level.player.origin, self.origin) > var_0)
    wait 0.05;

  scripts\engine\utility::flag_set(var_1);
}

_id_881D(var_0) {
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideStrength", 0.025, 0.1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideRadius", -0.05, 0.1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideDistortion", 0.015, 0.1);
  wait(var_0);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideStrength", 0, 1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideRadius", 0, 1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideDistortion", 0, 1);
}

_id_881E(var_0) {
  level.player playRumbleOnEntity("damage_light");
  earthquake(0.5, 0.75, level.player.origin, 9999);
}

_id_881B(var_0) {
  level.player playRumbleOnEntity("damage_heavy");
  earthquake(0.75, 1, level.player.origin, 9999);
}

_id_8819(var_0) {
  level.player playRumbleOnEntity("damage_heavy");
  earthquake(0.35, 0.75, level.player.origin, 9999);
  var_1 = getEnt("bridge_console_keyboard", "targetname");
  var_1 setModel("sdf_console_control_panel_11_off_d");
  getEnt("bridge_console_blood", "targetname") show();
  level._id_A70E detach(level._id_A70E.headmodel);
  level._id_A70E attach("head_sdf_kotch_blood_hqss");
  level._id_A70E.headmodel = "head_sdf_kotch_blood_hqss";
}

_id_881A(var_0) {
  screenshake(level.player.origin, 28, 0.5, 0.15, 0.5);
  level.player playRumbleOnEntity("damage_heavy");
}

_id_881C(var_0) {
  var_1 = spawn("script_model", level.player.origin);
  var_1 setModel("vm_hero_protagonist_helmet_glass_crack_01");
  var_1 _meth_81E2(level.player, "tag_origin", (0, 0, 0), (0, 0, 0), 1);
  scripts\engine\utility::flag_wait("hack_sequence_complete");
  var_1 delete();
}

_id_EBF6() {}

_id_EBF7() {
  level notify("timer destroy");
  level._id_D906 destroy();
}

_id_8812(var_0, var_1) {
  self endon("death");
  self.ignoreme = 1;
  self.ignoreall = 1;
  scripts\sp\utility::_id_F2DA(0);
  var_0 scripts\sp\anim::_id_1F35(self, var_1);
  var_0 scripts\sp\anim::_id_1EE0(self, var_1);
  scripts\sp\utility::_id_9193("heistBridgeHack");

  if(isDefined(self._id_DC1A))
    self _meth_81D0();
}

_id_137A5(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  level endon("stop_waittill_melee" + var_0._id_6A0B);
  var_1 = squared(var_1);
  thread _id_40DB();

  for(;;) {
    wait 0.05;
    var_6 = 0;

    if(level.player meleeButtonPressed() || level.player attackButtonPressed())
      var_6 = 1;

    var_7 = level.player scripts\sp\utility::_id_D1DF(var_0.origin + (0, 0, 64), 0.5, 1);
    var_8 = distancesquared(level.player.origin, var_0.origin);
    var_9 = var_8 < var_1;
    var_10 = 1;

    if(isDefined(var_2) && var_9)
      var_10 = var_5 _id_13D97(var_0, var_2, var_3, var_4);

    if(var_7 && var_9 && var_10) {
      level._id_1650 = var_0;
      scripts\engine\utility::flag_set("flag_hint_melee");
      scripts\sp\utility::_id_56BA("hint_melee");
      var_0 scripts\sp\utility::_id_9196(1, 0, 1, "heistBridgeHack");

      if(var_6) {
        scripts\engine\utility::flag_clear("flag_hint_melee");
        var_0 scripts\sp\utility::_id_9196(1, 0, 0, "heistBridgeHack");
        thread _id_10FD4();
        level notify("stop_waittill_melee" + var_0._id_6A0B);
      }

      continue;
    }

    if(!scripts\engine\utility::flag("hacked_robot_scene_active")) {
      if(isDefined(level._id_1650) && level._id_1650 == var_0)
        level._id_1650 = undefined;

      scripts\engine\utility::flag_clear("flag_hint_melee");
      var_0 scripts\sp\utility::_id_9196(1, 0, 0, "heistBridgeHack");
    }
  }
}

_id_13D97(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = scripts\engine\utility::flat_angle(level.player.angles);
  var_6 = scripts\engine\utility::flat_angle(var_0.angles);
  var_7 = anglesdelta(var_6, var_5);
  var_7 = var_7 * 2;

  if(var_7 > var_2[0] && var_7 < var_2[1])
    var_4 = 1;
  else
    var_4 = 0;

  var_5 = scripts\engine\utility::flat_angle(self.angles);
  var_6 = scripts\engine\utility::flat_angle(var_0.angles);
  var_7 = anglesdelta(var_5, var_6);
  var_7 = var_7 * 2;

  if(var_7 > var_3[0] && var_7 < var_3[1])
    var_4 = 1;
  else
    var_4 = 0;

  return var_4;
}

_id_D257() {
  level endon("kotch_attack_started");
  var_0 = 0;

  for(;;) {
    if(isDefined(level._id_1650) && !var_0) {
      scripts\sp\maps\heist\heist_util::_id_5569("melee");
      var_0 = 1;
    } else if(!isDefined(level._id_1650) && var_0) {
      scripts\sp\maps\heist\heist_util::_id_6229("melee");
      var_0 = 0;
    }

    wait 0.05;
  }
}

_id_2FD0() {
  var_0 = getEnt("bridge_alert_volume", "targetname");

  for(;;) {
    wait 0.05;

    if(level.player istouching(var_0)) {
      break;
    }
  }

  scripts\engine\utility::flag_set("bridge_alerted");
}

_id_A70F() {
  level._id_A70E scripts\sp\utility::_id_918B("ar_callouts_admiral_kotch", 0, (0, 0, 32));
  wait 0.25;
  scripts\sp\utility::_id_9199("heistHighlightKotch", 1);
  level._id_A70E scripts\sp\utility::_id_9196(1, 0, 1, "heistHighlightKotch");
  wait 0.2;
  level._id_A70E scripts\sp\utility::_id_9193("heistHighlightKotch");
  wait 0.2;
  level._id_A70E scripts\sp\utility::_id_9196(1, 0, 1, "heistHighlightKotch");
  wait 0.2;
  level._id_A70E scripts\sp\utility::_id_9193("heistHighlightKotch");
  wait 0.2;
  level._id_A70E scripts\sp\utility::_id_9196(1, 0, 1, "heistHighlightKotch");
  scripts\engine\utility::flag_wait("obj_stopkotch");
  var_0 = scripts\engine\utility::spawn_tag_origin(level._id_A70E.origin + (0, 0, 56), level._id_A70E.angles);
  objective_onentity(scripts\sp\utility::_id_C264("obj_stopkotch"), var_0);
  level._id_A70E scripts\sp\utility::_id_9193("heistHighlightKotch");
  scripts\sp\utility::_id_9199("heistHighlightKotch", 0);
  level._id_A70E scripts\sp\utility::_id_9196(1, 0, 0, "heistBridgeHack");
  level waittill("kotch_attack_started");
  var_0 delete();
}

_id_B5A6(var_0) {
  var_1 = getEnt("bridge_opsmap_scriptable", "targetname");
  var_1 setscriptablepartstate("glass", "broken");
}

_id_40DB() {
  level waittill("stop_waittill_melee");
  scripts\engine\utility::flag_clear("flag_hint_melee");
}

_id_11000(var_0) {
  level notify("stop_" + var_0._id_1FB1);

  if(!isDefined(var_0.finished)) {
    foreach(var_2 in var_0.enemies) {
      if(isalive(var_2))
        var_2 _meth_81D0();
    }
  }
}

_id_E5A5() {
  level endon("stop_robotcop_gesture");
  level.player notifyonplayercommand("melee_button_pressed", "+melee");
  level.player notifyonplayercommand("melee_button_pressed", "+melee_breath");
  level.player notifyonplayercommand("melee_button_pressed", "+melee_zoom");
  scripts\engine\utility::flag_waitopen("hacked_robot_scene_active");
  var_0 = level.player getgestureanimlength("ges_c6_heist_defensivehands");
  var_0 = var_0 * 1000;

  for(;;) {
    level.player waittill("damage");
    level.player forceplaygestureviewmodel("ges_c6_heist_defensivehands");
    level scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "hacked_robot_scene_active");
    level.player scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "melee_button_pressed");
    level.player scripts\sp\utility::_id_178D(::_id_13752);
    scripts\sp\utility::_id_57D6();
    level.player stopgestureviewmodel("ges_c6_heist_defensivehands", 0);

    if(scripts\engine\utility::flag("hacked_robot_scene_active"))
      scripts\engine\utility::flag_waitopen("hacked_robot_scene_active");

    while(level.player ismeleeing())
      wait 0.05;
  }
}

_id_13752() {
  level endon("hacked_robot_scene_active");
  var_0 = 1;

  for(;;) {
    var_1 = scripts\engine\utility::waittill_notify_or_timeout_return("damage", var_0);

    if(isDefined(var_1)) {
      break;
    }
  }
}

_id_13805(var_0) {
  level endon("hacked_robot_scene_active");
  var_1 = gettime();

  while(gettime() - var_1 < var_0) {
    wait 0.05;

    if(level.player ismeleeing())
      return 1;

    if(scripts\engine\utility::flag("hacked_robot_scene_active"))
      return 1;
  }
}

_id_4D4F() {
  level endon("stop_damagefunc_hacked_robot");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    level.player waittill("damage", var_2, var_3, var_4, var_5, var_6);
    self playSound("hack_hud_static_impact");
    playFX(scripts\engine\utility::getfx("vfx_heist_imp_md_robot_camera"), level.player.origin);
    childthread _id_4CF7(var_5);

    if(scripts\engine\utility::flag("hacked_robot_scene_active")) {
      continue;
    }
    var_0 = var_0 + var_2;
    earthquake(randomfloatrange(0.1, 0.15), randomfloatrange(0.25, 0.5), level.player.origin, 9999);
    level.player dodamage(var_2, var_5, var_3, var_3);
    level.player.health = 100;

    if(var_0 > level._id_880C / 1.4 && !var_1) {
      level.player thread scripts\engine\utility::play_loop_sound_on_entity("hacked_drone_dmg_alarm");
      var_1 = 1;
    }

    wait 1;
  }
}

_id_4CF7(var_0) {
  if(!isDefined(level._id_8811))
    level._id_8818 = [];

  var_1 = undefined;
  var_2 = undefined;
  var_3 = level.player getEye();
  var_4 = anglesToForward(level.player getplayerangles());
  var_5 = vectorNormalize(var_0 - var_3);

  if(!level.player scripts\sp\utility::_id_D1DF(var_0, 0.5, 1))
    var_0 = var_3 + var_4 * 10 + var_5 * 10;

  var_1 = scripts\engine\utility::spawn_tag_origin(var_0, level.player.angles);
  var_1 linkTo(level.player);
  playFXOnTag(scripts\engine\utility::getfx("cockpit_damage_sparks"), var_1, "tag_origin");

  if(scripts\engine\utility::random([1, 0, 0, 0, 0, 0, 0])) {
    level._id_8818 = scripts\engine\utility::array_removeundefined(level._id_8818);

    if(level._id_8818.size == 0) {
      var_2 = scripts\engine\utility::spawn_tag_origin(var_0 + anglesToForward(level.player.angles) * 20, level.player.angles);
      var_2 linkTo(level.player);
      level._id_8818[level._id_8818.size] = var_2;
      playFXOnTag(scripts\engine\utility::getfx("cockpit_death_explo"), var_2, "tag_origin");
    }
  }

  wait 2;
  var_1 delete();

  if(isDefined(var_2))
    var_2 delete();
}

_id_10C11() {
  level.player notify("stop_defensive_gesture_disable");
  scripts\engine\utility::flag_set("defensive_gesture_active");
  level.player scripts\sp\utility::_id_D090("ges_c6_heist_defensivehands");
  _id_10FD4(1);
}

_id_10FD4(var_0) {
  level.player notify("stop_defensive_gesture_disable");
  level.player endon("stop_defensive_gesture_disable");

  if(isDefined(var_0))
    wait(var_0);

  level.player scripts\sp\utility::_id_1102B("ges_c6_heist_defensivehands");
  scripts\engine\utility::flag_clear("defensive_gesture_active");
}

_id_1064A() {
  level._id_30B3 = scripts\sp\utility::_id_22CD("enemy_background_shooters", 1);

  foreach(var_1 in level._id_30B3) {
    var_1.a.disablelongdeath = 1;
    var_1 scripts\sp\utility::_id_F2D8(1000);
    var_1 _meth_82DE(level._id_880E);
    var_1._id_C05C = 1;
  }
}

_id_12BA1() {
  self endon("death");
  self.ignoreall = 1;
  self waittill("goal");
  self.ignoreall = 0;
}

_id_1065C() {
  level._id_306E = [];
  level._id_306D = scripts\sp\utility::_id_22CD("bridge_robots");

  foreach(var_1 in level._id_306D) {
    if(isDefined(var_1.script_noteworthy))
      level._id_306E[var_1.script_noteworthy][var_1.script_index] = var_1;

    var_1._id_1FBB = "c6bridge";
    _id_0E29::_id_877F(var_1);
    var_1.ignoreme = 1;
    var_1.allowdeath = 1;
    var_1 scripts\sp\utility::_id_86E4();

    if(isDefined(var_1.script_parameters)) {
      if(var_1.script_parameters == "sit") {
        var_2 = var_1 scripts\engine\utility::get_target_ent();
        var_2 thread scripts\sp\anim::_id_1EEA(var_1, "c6bridge_sit_idle");
        var_1._id_1FE0 = var_2;
        var_1.allowdeath = 1;
      }

      continue;
    }

    var_1._id_1FE0 = spawnStruct();
    var_1._id_1FE0.origin = scripts\sp\utility::_id_864C(var_1.origin);
    var_1._id_1FE0.angles = var_1.angles;
    var_1._id_1FE0 thread scripts\sp\anim::_id_1EEA(var_1, "c6bridge_idle");
    var_1.allowdeath = 1;
  }
}

_id_43CE(var_0, var_1) {
  var_0 endon("death");
  level endon("hacked_robot_scene_ " + var_1._id_1FB1);

  if(isDefined(var_1._id_92DC)) {
    if(isDefined(var_1._id_DD2F))
      var_0 thread scripts\engine\utility::flag_wait(var_1._id_92DC);

    if(isDefined(var_1._id_DD2E))
      wait(var_1._id_DD2E);

    var_2 = scripts\engine\utility::getStruct(var_1._id_92FC, "targetname");
    var_2 notify("stop_loop");
    var_0 _meth_83A1();

    if(isDefined(var_1._id_1FB2)) {
      var_3 = self;

      if(isDefined(var_1._id_DD5F))
        var_3 = scripts\engine\utility::getStruct(var_1._id_DD5F, "targetname");

      var_3 scripts\sp\anim::_id_1ECB(var_0, var_1._id_1FB2);
    }

    var_0 _meth_82DE(level._id_880E);
  }

  scripts\sp\anim::_id_1F50([var_0], var_1._id_1FB1);
  var_4 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(var_4);
  scripts\engine\utility::waittill_any_ents(var_0, "unlink_scene_guy", level, "unlink_scene_guys");
  var_4 delete();
}

_id_306A() {
  while(distance(level.player.origin, level._id_A70E.origin) > 512)
    wait 1;

  scripts\engine\utility::flag_set("retreat_bridge");
}

_id_2FE6() {
  scripts\engine\utility::waitframe();
  setsaveddvar("bg_cinematicfullscreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  wait 0.25;
  cinematicingame("heistspace_fspar_connect");
  wait 0.1;
  pausecinematicingame(1);
}

_id_10C17() {
  level endon("stop_destruct_sequence");
  scripts\engine\utility::flag_wait_or_timeout("bridge_alerted", 12);

  if(!scripts\engine\utility::flag("bridge_alerted")) {
    level._id_3012 scripts\sp\utility::_id_10346("heist_omn_watchoutbot");
    scripts\engine\utility::flag_set("mons_destruct_started");
    wait 2;

    if(isalive(level._id_3012))
      scripts\engine\utility::flag_set(level._id_3012._id_EBEA._id_92DC);
  } else {
    wait 2;
    scripts\engine\utility::flag_set("mons_destruct_started");
  }

  level.player thread scripts\engine\utility::play_loop_sound_on_entity("alarm_heist_mons_lp3");
  var_0 = 20;
  level._id_5330 = var_0;

  for(var_1 = var_0; var_1 > 0; var_1--) {
    level._id_5330 = var_1;
    level.player thread scripts\sp\utility::play_sound_on_entity("hack_robot_explode_beep");
    wait 1;
  }

  thread _id_BA75();
}

_id_BA75() {
  level notify("stop_robotcop_gesture");
  scripts\engine\utility::flag_set("self_destruct_started");
  playFXOnTag(level._effect["vfx_heist_control_room_death"], level.player, "TAG_ORIGIN");
  earthquake(0.35, 99999, level.player.origin, 9999);
  wait 0.25;

  foreach(var_1 in level._id_306D) {
    if(!isDefined(var_1) || !isalive(var_1)) {
      continue;
    }
    radiusdamage(var_1.origin, 56, 99999, 99999, var_1, "MOD_EXPLOSIVE");
  }

  wait 0.25;
  level.player stopgestureviewmodel();
  level.player _meth_84FE();
  level.player playRumbleOnEntity("grenade_rumble");
  level.player scripts\sp\utility::_id_D090("ges_player_death_frag_1");
  wait 1.5;
  _id_0B60::_id_F32D("HEIST_DESTRUCT_FAIL");
  scripts\sp\utility::_id_B8D1();
  thread scripts\sp\hud_util::_id_6AA3(1, "black");
}

_id_10FD6() {
  level notify("stop_destruct_sequence");
  level.player thread scripts\engine\utility::stop_loop_sound_on_entity("alarm_heist_mons_lp3");
}

_id_919D() {
  var_0 = [];
  var_0["r_hudoutlineWidth"] = 1;
  var_0["r_hudoutlineFillColor0"] = "1 1 1 0.4";
  var_0["r_hudoutlineFillColor1"] = "0.8 0.8 0.8 0.4";
  var_0["r_hudoutlineOccludedOutlineColor"] = "1 1 1 0";
  var_0["r_hudoutlineOccludedInlineColor"] = "0.6 0.6 0.6 0.3";
  var_0["r_hudoutlineOccludedInteriorColor"] = "0.6 0.6 0.6 0.3";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_0;
}

_id_919E() {
  var_0 = [];
  var_0["r_hudoutlineWidth"] = 1;
  var_0["r_hudoutlineFillColor0"] = "1 1 1 0.8";
  var_0["r_hudoutlineFillColor1"] = "1 1 1 0.8";
  var_0["r_hudoutlineOccludedOutlineColor"] = "1 1 1 1";
  var_0["r_hudoutlineOccludedInlineColor"] = "1 1 1 0.8";
  var_0["r_hudoutlineOccludedInteriorColor"] = "1 1 1 0.8";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_0;
}

_id_D6D3() {
  scripts\engine\utility::flag_wait("hack_hud_control_outro_finished");
  scripts\sp\utility::_id_CF8B();
}

_id_87C0() {
  level waittill("marker_on");
  var_0 = scripts\engine\utility::getStruct("struct_robothack2", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin + (0, 20, 50), var_0.angles);
  objective_onentity(scripts\sp\utility::_id_C264("obj_hack"), var_1);
  level waittill("player_hack_locking_on");
  var_1 delete();
}

_id_87AD() {
  level endon("player_in_bot");
  level waittill("marker_on");
  wait 6;
  scripts\engine\utility::flag_init("player_has_device");
  scripts\engine\utility::flag_init("hacking_device_in_slot");
  scripts\engine\utility::flag_init("hacking_device_has_ammo");
  thread _id_53E8();
  thread _id_53E9();
  thread _id_53E7();

  for(;;) {
    var_0 = undefined;

    if(!scripts\engine\utility::flag("player_has_device"))
      var_0 = "hacking_hint_pickup";
    else if(!scripts\engine\utility::flag("hacking_device_in_slot"))
      var_0 = "hacking_hint_slot";
    else if(!scripts\engine\utility::flag("hacking_device_has_ammo"))
      var_0 = "hacking_hint_ammo";
    else if(_id_0E29::_id_87A7() == "none")
      var_0 = "hacking_hint_use";

    if(isDefined(var_0) && (!isDefined(level._id_BA72) || var_0 != level._id_BA72)) {
      level._id_BA72 = var_0;
      scripts\sp\utility::_id_56BA(var_0);
    } else if(!isDefined(var_0))
      level._id_BA72 = undefined;

    wait 0.05;
  }
}

_id_53E8() {
  level endon("player_in_bot");

  for(;;) {
    if(scripts\sp\utility::_id_D0BD("hackingdevice", 1))
      scripts\engine\utility::flag_set("player_has_device");
    else
      scripts\engine\utility::flag_clear("player_has_device");

    wait 0.05;
  }
}

_id_53E9() {
  level endon("player_in_bot");

  for(;;) {
    if(scripts\sp\utility::_id_D0BD("hackingdevice", 0))
      scripts\engine\utility::flag_set("hacking_device_in_slot");
    else
      scripts\engine\utility::flag_clear("hacking_device_in_slot");

    wait 0.05;
  }
}

_id_53E7() {
  level endon("player_in_bot");

  for(;;) {
    if(scripts\sp\utility::_id_D0BD("hackingdevice", 0) && level.player scripts\sp\utility::_id_7C3E() > 0)
      scripts\engine\utility::flag_set("hacking_device_has_ammo");
    else
      scripts\engine\utility::flag_clear("hacking_device_has_ammo");

    wait 0.05;
  }
}

_id_87CE() {
  if(scripts\engine\utility::flag("player_in_bot") || !isDefined(level._id_BA72) || level._id_BA72 != "hacking_hint_pickup")
    return 1;

  return 0;
}

_id_87E5() {
  if(scripts\engine\utility::flag("player_in_bot") || !isDefined(level._id_BA72) || level._id_BA72 != "hacking_hint_slot")
    return 1;

  return 0;
}

_id_8783() {
  if(scripts\engine\utility::flag("player_in_bot") || !isDefined(level._id_BA72) || level._id_BA72 != "hacking_hint_ammo")
    return 1;

  return 0;
}

_id_87F1() {
  if(scripts\engine\utility::flag("player_in_bot") || !isDefined(level._id_BA72) || level._id_BA72 != "hacking_hint_use")
    return 1;

  return 0;
}

_id_D83C() {
  if(!isDefined(level._id_6754)) {
    return;
  }
  var_0 = "call_heist_eth_captainthehacki";
  level._id_6754 waittillmatch("single anim", var_0);
  scripts\sp\utility::_id_2669("prehack");
}

_id_6AC5() {
  level endon("kotch_attack_started");
  scripts\sp\maps\heist\heist_util::_id_1378F("vol_bridge_passed_kotch", [level.player]);
  _id_BA75();
}

_id_544D() {
  scripts\engine\utility::flag_set("obj_hack");
  level endon("player_hack_locking_on");

  while(!isDefined(level._id_6754))
    scripts\engine\utility::waitframe();

  if(level._id_10CDA == "mons_hack") {
    level._id_6754 scripts\sp\utility::_id_10346("heist_eth_captainthehacki");
    level._id_EA2C scripts\sp\utility::_id_10346("heist_slt_helmsgotmechsan");
    level._id_EA2C scripts\sp\utility::_id_10346("heist_slt_takeitraider");
  } else {
    level._id_6754 thread _id_C0D2("heist_eth_captainthehacki");
    level._id_EA2C thread _id_C0D2("heist_slt_helmsgotmechsan");

    if(!level.player scripts\sp\utility::_id_D0BD("hackingdevice", 1))
      level._id_EA2C _id_C0D2("heist_slt_takeitraider", "heist_slt_reyesgofortheha");
    else
      level._id_EA2C _id_C0D2("heist_slt_takeitraider");
  }

  wait 4;
  level notify("marker_on");

  if(level._id_10CDA != "mons_hack")
    level scripts\engine\utility::waittill_either("call_heist_slt_takeitraider", "heist_slt_reyesgofortheha");

  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_hurrysir");
  wait 8;
  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_hackisexpirings");
  wait 8;
  level._id_6754 scripts\sp\utility::_id_10346("heist_eth_theyrescuttling");
}

_id_C0D2(var_0, var_1) {
  level endon("player_hack_locking_on");
  var_2 = "call_" + var_0;
  self waittillmatch("single anim", var_2);

  if(isDefined(var_1)) {
    scripts\sp\utility::_id_10346(var_1);
    level notify(var_1);
  } else
    scripts\sp\utility::_id_10346(var_0);
}

_id_544C() {
  level.player scripts\sp\utility::_id_1034D("heist_plr_workerdronesthe");
  level._id_EA2C scripts\sp\utility::_id_10346("heist_slt_copygetinthere");
}

_id_544E() {
  level endon("kotch_attack_started");
  thread _id_544F();
  wait 1;
  thread scripts\sp\utility::_id_1034D("heist_plr_imin");
  scripts\engine\utility::flag_clear("obj_hack");
  level._id_6754 scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_10350, "heist_eth_siryouhavetosto");
  level._id_A70E scripts\engine\utility::delaythread(5, ::smart_dialogue_kotch, "heist_kch_setallleveldeto");
  scripts\engine\utility::delaythread(2, scripts\engine\utility::flag_set, "obj_stopkotch");
  scripts\engine\utility::flag_wait("mons_destruct_started");
  level._id_6754 notify("stop_delay_thread");
  level._id_A70E notify("stop_delay_thread");
  wait 1;
  level._id_A70E smart_dialogue_kotch("heist_kch_killthebot");
  level._id_A70E smart_dialogue_kotch("heist_kch_overheatreactor");
  level._id_A70E smart_dialogue_kotch("heist_kch_ionexhausttoful");

  while(level._id_5330 > 13)
    wait 0.05;

  level._id_A70E smart_dialogue_kotch("heist_kch_scuttlekeyishot");

  while(level._id_5330 > 5)
    wait 0.05;

  level._id_A70E smart_dialogue_kotch("heist_kch_5secondskillhim");
}

_id_5461(var_0, var_1) {
  level._id_A70E hidepart("j_head", level._id_A70E.headmodel);
  level._id_A70E hidepart("j_eyeball_le");
  level._id_A70E hidepart("j_eyeball_ri");
  level._id_A70E hidepart("j_tongue_1");
  level._id_A70E thread scripts\sp\utility::_id_10346(var_1);
  level._id_A70E _meth_82A2(var_0, 1.0, 0.0, 1.0);
  wait(getanimlength(var_0));
  level._id_A70E _meth_82A2(var_0, 0.0, 0.0, 1.0);
  level._id_A70E showpart("j_head", level._id_A70E.headmodel);
  level._id_A70E showpart("j_eyeball_le");
  level._id_A70E showpart("j_eyeball_ri");
  level._id_A70E showpart("j_tongue_1");
}

_id_544F() {
  while(distance2d(level.player.origin, level._id_A70E.origin) > 250)
    wait 0.05;

  level._id_A70E thread smart_dialogue_kotch("heist_kch_bot");
  wait 1.5;
  level endon("kotch_attack_started");
  level.player scripts\sp\utility::_id_10353("heist_slt_gethimreyes");
  wait 3;
  level.player scripts\sp\utility::_id_10353("heist_brk_killthatredcowa");
}

smart_dialogue_kotch(var_0) {
  scripts\engine\utility::flag_waitopen("kotch_vo_active");
  scripts\engine\utility::flag_set("kotch_vo_active");
  scripts\sp\utility::_id_10346(var_0);
  scripts\engine\utility::flag_clear("kotch_vo_active");
  scripts\engine\utility::waitframe();
}

_id_8D18() {
  level._id_A714 = scripts\sp\utility::_id_10639("bridge_chair");
  var_0 = scripts\engine\utility::getStruct("mons_bridge_chair", "targetname");
  level._id_A714.origin = var_0.origin;
  level._id_A714.angles = var_0.angles;

  if(isDefined(level._id_A70E)) {
    level._id_A70E detach(level._id_A70E.headmodel);
    level._id_A70E attach("head_sdf_kotch_blood_hqss");
    level._id_A70E.headmodel = "head_sdf_kotch_blood_hqss";
  }

  thread _id_2FE6();
  scripts\engine\utility::flag_set("hack_sequence_complete");
}