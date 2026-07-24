/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phspace\phspace_launch.gsc
******************************************************/

_id_CADC() {
  scripts\engine\utility::flag_init("handoff_done");
  scripts\engine\utility::flag_init("handoff_cleanup");
  scripts\engine\utility::flag_init("player_passed_dropoff");
  scripts\engine\utility::flag_init("jackal_call_down");
  scripts\engine\utility::flag_init("jackals_in_view");
  scripts\engine\utility::flag_init("jackal_fly_in_free");
  scripts\engine\utility::flag_init("jackals_landed");
  scripts\engine\utility::flag_init("start_launch");
  scripts\engine\utility::flag_init("flag_player_boosters_disengaged");
  scripts\engine\utility::flag_init("jackal_path_angle_up");
  scripts\engine\utility::flag_init("jackal_launch_stop_2");
  scripts\engine\utility::flag_init("ret_start_engines");
  scripts\engine\utility::flag_init("ret_start_boost");
  scripts\engine\utility::flag_init("ret_stop_boost");
  scripts\engine\utility::flag_init("launch_prepare_teleport");
  scripts\engine\utility::flag_init("launch_nearing_end");
}

_id_8A08() {
  setsaveddvar("bg_disableWeaponFirstRaiseAnims", 1);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_handoff");
  thread _id_1073B();
  thread scripts\sp\maps\phspace\phspace::_id_107B6();
  thread scripts\sp\maps\phspace\phspace::_id_107F6();
}

_id_8A06() {
  thread hvt_handoff_dof_scripts();
  scripts\sp\hud_util::_id_10CCC();
  level._id_D127 = scripts\sp\vehicle::_id_1080C("jackal_player");
  scripts\sp\maps\phspace\phspace::_id_107C0();
  var_0 = ["salter", "admiral", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_handoff", var_0);
  wait 0.05;
  thread scripts\sp\utility::_id_2669("phspace_started");

  foreach(var_2 in level.allies) {
    var_2 scripts\sp\utility::_id_51E1("casual_gun");
    var_2 scripts\sp\utility::_id_5504();
    var_2 scripts\sp\utility::_id_5528();
    var_2 _meth_8250(1);
  }

  level.player scripts\sp\utility::_id_F526("safe");
  level.player scripts\engine\utility::delaythread(1.0, scripts\sp\utility::_id_F526, "safe");
  level._id_920F _meth_84AE();
  wait 0.05;
  thread _id_6DCB();
  var_4 = getnode("start_handoff_salter", "targetname");
  var_5 = getnode("start_handoff_admiral", "targetname");
  var_6 = getnode("start_handoff_eth3n", "targetname");
  level.allies["salter"] thread scripts\sp\utility::_id_7226(var_4, 10000, undefined, undefined);
  level.allies["admiral"] thread scripts\sp\utility::_id_7226(var_5, 10000, undefined, undefined);
  level.allies["eth3n"] thread scripts\sp\utility::_id_7226(var_6, 10000, undefined, undefined);
  thread _id_5297();
  thread _id_8A01();
  thread _id_89FE();
  thread _id_8A05();
  scripts\sp\hud_util::_id_6A99(2);
  scripts\engine\utility::flag_wait("jackal_call_down");
  thread _id_8A00();
  setsaveddvar("bg_disableWeaponFirstRaiseAnims", 0);
}

hvt_handoff_dof_scripts() {
  thread _id_0B0A::_id_583F(0, 30, 2, 0.05, 400, 3, 0);
  wait 3;
  thread _id_0B0A::_id_583D(3);
}

_id_6DCB() {
  wait 0.5;
  var_0 = scripts\engine\utility::getStruct("jackal_callin_launch_animnode", "targetname");
  var_0 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_0 scripts\sp\anim::_id_1EC3(level._id_12B67, "jackal_callin");
  level._id_EA99 vehicle_teleport(level._id_12B67.origin, level._id_12B67.angles);
  level._id_D127 vehicle_teleport(level._id_12B67.origin, level._id_12B67.angles);
  wait 0.1;
  level._id_EA99 _id_0BDC::_id_19AB(0);
  level._id_EA99 _id_0BDC::_id_A1EC(level._id_12B67.origin, 1, 5000, level._id_12B67.angles);
}

_id_5297() {
  if(!isDefined(game["phstreets_"])) {
    _id_436B(1);
    return;
  } else {
    game["phstreets_"] = undefined;
    _id_436B();
  }

  var_0 = getEntArray("lot_script_car", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_DAF0();
  }
}

_id_DAF0() {
  var_0 = scripts\engine\utility::get_target_ent();
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3._id_1FBB = var_3.script_noteworthy;
    var_3 scripts\sp\anim::_id_F64A();
    var_3.clip = var_3 scripts\engine\utility::get_target_ent();
    var_3.clip linkTo(var_3);
    var_3.clip connectpaths();
  }

  foreach(var_3 in var_1) {
    var_0 scripts\sp\anim::_id_1EE0(var_3, "crate_explode");
    var_3.clip disconnectPaths();
  }

  wait 0.1;
  radiusdamage(var_0.origin, 500, 1000, 1000);
}

_id_436B(var_0) {
  var_1 = getEnt("lot_jackal_statue", "targetname");
  var_1._id_1FBB = "lot_statue";
  var_1 setModel("decor_aatis_tower_globe_01");
  var_2 = getEnt("tower_statue_clip", "targetname");
  var_2 linkTo(var_1, "j_base");
  var_1 scripts\sp\anim::_id_F64A();

  if(scripts\engine\utility::is_true(var_0)) {
    var_1 scripts\sp\anim::_id_1EC3(var_1, "statue_collapse");
  } else {
    var_1 scripts\sp\anim::_id_1EE0(var_1, "statue_collapse");
  }

  createnavrepulsor("statue", 0, var_1, 384);
  var_2 disconnectPaths();
}

_id_8A01() {
  level.player scripts\engine\utility::delaythread(0.2, scripts\sp\utility::_id_D090, "ges_radio_safe");
  level.player scripts\engine\utility::delaycall(0.7, ::playsound, "ges_plr_radio_on");
  wait 0.9;
  scripts\sp\utility::_id_1034D("phspace_plr_allstationsthis");
  level.player playSound("ges_plr_radio_off");
  level.player scripts\sp\utility::_id_1102B("ges_radio_safe");
  level.allies["salter"] scripts\sp\utility::_id_10346("phspace_slt_setdefsretreati");
  scripts\engine\utility::flag_set("handoff_done");
  scripts\engine\utility::flag_set("jackal_call_down");
  scripts\engine\utility::flag_set("jackals_start_call_in");
  thread scripts\sp\utility::_id_2669("handoff_complete");
  thread _id_8A04();
  level.player scripts\sp\utility::_id_D090("ges_radio_safe");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  wait 0.5;
  scripts\sp\utility::_id_1034D("phspace_plr_raidertomainlts");
  scripts\sp\utility::_id_10350("phspace_nav_ayesir32willesc");
  scripts\sp\utility::_id_1034D("phspace_plr_solidcopyseeyou");
  level.player playSound("ges_plr_radio_off");
  level.player scripts\sp\utility::_id_1102B("ges_radio_safe");
  wait 0.1;
  scripts\sp\utility::_id_10350("dps_s31_jackalstouching");
  wait 6.3;
  scripts\sp\utility::_id_1034D("phspace_plr_thatsourrideeth");
}

_id_8A04() {
  level.allies["admiral"] scripts\sp\utility::_id_61C8();
  level.allies["salter"] scripts\sp\utility::_id_61C8();
  level.allies["admiral"] scripts\sp\utility::_id_F3B5("g");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("r");
  level.allies["salter"] scripts\sp\utility::_id_61DB();
  level.allies["salter"] scripts\sp\utility::_id_61F7();
  level.allies["salter"] thread _id_1C1A();
  scripts\sp\utility::_id_15F5("handoff_done_salter");
  wait 0.5;
  level.allies["eth3n"] scripts\sp\utility::_id_61C8();
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("p");
  level.allies["eth3n"] scripts\sp\utility::_id_61DB();
  level.allies["eth3n"] scripts\sp\utility::_id_61F7();
  level.allies["eth3n"] thread _id_1C1A();
  wait 0.1;
  scripts\sp\utility::_id_15F5("handoff_done_eth3n");
}

_id_1C1A() {
  level endon("handoff_cleanup");

  for(var_0 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, self.origin); var_0 >= 0.4; var_0 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, self.origin)) {
    scripts\engine\utility::waitframe();
  }

  scripts\sp\utility::_id_4145();
}

#using_animtree("generic_human");

_id_89FE() {
  var_0 = getEnt("hvt_soldier01", "targetname");
  var_1 = getEnt("hvt_soldier02", "targetname");
  var_2 = getEnt("hvt_soldier03", "targetname");
  var_3 = var_0 scripts\sp\utility::_id_10619(1, 1);
  var_4 = var_1 scripts\sp\utility::_id_10619(1, 1);
  var_5 = var_2 scripts\sp\utility::_id_10619(1, 1);
  var_3._id_1FBB = "soldier01";
  var_4._id_1FBB = "soldier02";
  var_5._id_1FBB = "soldier03";
  var_6 = scripts\sp\utility::_id_10639("handcuffs", level._id_920F.origin, level._id_920F.angles);
  level._id_9231 = [];
  level._id_9231[0] = level._id_920F;
  level._id_9231[1] = var_3;
  level._id_9231[2] = var_4;
  level._id_9231[3] = var_5;
  var_7 = scripts\engine\utility::getStruct("hvt_handoff_animnode", "targetname");

  if(!isDefined(var_7)) {
    return;
  }
  var_8 = [];
  var_8["soldier01"] = var_3;
  var_8["soldier02"] = var_4;
  var_8["soldier03"] = var_5;
  var_8["hvt"] = level._id_920F;
  var_8["handcuffs"] = var_6;
  var_9 = 0.6;
  var_10 = getanimlength(%ph_aatis_tower_hvt_handoff_ally01);
  var_7 thread scripts\sp\anim::_id_1F2C(var_8, "hvt_handoff");
  wait 0.05;
  level._id_920F _meth_82B0(%ph_aatis_tower_hvt_handoff_hvt, var_9);
  var_3 _meth_82B0(%ph_aatis_tower_hvt_handoff_ally01, var_9);
  var_4 _meth_82B0(%ph_aatis_tower_hvt_handoff_ally02, var_9);
  var_5 _meth_82B0(%ph_aatis_tower_hvt_handoff_ally03, var_9);
  var_6 thread _id_889A(var_9);
  wait(var_10 - var_10 * var_9 - 0.05);
  var_7 thread scripts\sp\anim::_id_1EEA(var_3, "hvt_handoff_idle", "stop_handoff_idle");
  var_7 thread scripts\sp\anim::_id_1EEA(var_4, "hvt_handoff_idle", "stop_handoff_idle");
  var_7 thread scripts\sp\anim::_id_1EEA(var_5, "hvt_handoff_idle", "stop_handoff_idle");
  var_7 thread scripts\sp\anim::_id_1EEA(level._id_920F, "hvt_handoff_idle", "stop_handoff_idle");
  var_7 thread scripts\sp\anim::_id_1EEA(var_6, "hvt_handoff_idle", "stop_handoff_idle");
}

#using_animtree("script_model");

_id_889A(var_0) {
  self _meth_82B0(%ph_aatis_tower_hvt_handoff_handcuffs, var_0);
}

_id_8A05() {
  var_0 = getEntArray("hvt_marines", "targetname");
  level._id_923A = [];

  foreach(var_3, var_2 in var_0) {
    level._id_923A[var_3] = var_2 scripts\sp\utility::_id_10619();
    level._id_923A[var_3] _meth_8250(1);
  }

  wait 3.0;

  foreach(var_5 in level._id_923A) {
    var_5 scripts\sp\utility::_id_51E1("casual_gun");
  }
}

_id_1073B(var_0) {
  if(!isDefined(level._id_920F)) {
    var_1 = getEnt("hvt", "targetname");
    level._id_920F = var_1 scripts\sp\utility::_id_10619(1, 1);
    level._id_920F._id_1FBB = "hvt";
    level._id_920F.name = "Riah";
    level._id_920F.ignoreall = 1;
    level._id_920F.ignoreme = 1;
    level._id_920F.fixednode = 1;
  }

  if(isDefined(var_0)) {
    var_2 = getnode(var_0, "targetname");
    level._id_920F scripts\sp\utility::_id_1160F(var_2);
  }
}

_id_8A07() {
  level endon("handoff_done");
  scripts\engine\utility::flag_wait("player_passed_dropoff");
  level.allies["salter"] scripts\sp\utility::_id_4145();
  level.allies["eth3n"] scripts\sp\utility::_id_4145();
  level.allies["salter"] _meth_83A1();
  level.allies["eth3n"] _meth_83A1();
  level.allies["salter"] scripts\sp\utility::_id_61C7();
  level.allies["eth3n"] scripts\sp\utility::_id_61C7();
  level.allies["salter"] scripts\sp\utility::_id_F3B5("r");
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("p");
  scripts\sp\utility::_id_15F5("handoff_done");
  level.player scripts\sp\utility::_id_F526("normal");
}

_id_89FF() {
  thread _id_8A00();
}

_id_8A00() {
  scripts\engine\utility::flag_wait("handoff_cleanup");

  if(isDefined(level._id_9231)) {
    foreach(var_1 in level._id_9231) {
      if(!isDefined(var_1)) {
        continue;
      }
      var_1 scripts\sp\utility::_id_1101B();
      wait 0.05;
      var_1 delete();
    }
  }

  foreach(var_4 in level.allies) {
    if(!isDefined(var_4)) {
      continue;
    }
    if(var_4 == level.allies["eth3n"]) {
      continue;
    }
    var_4 scripts\sp\utility::_id_1101B();
    var_4 notify("stop_idle");
    var_4 _meth_83A1();
    wait 0.05;
    var_4 delete();
  }

  if(isDefined(level._id_923A)) {
    foreach(var_7 in level._id_923A) {
      if(isDefined(var_7)) {
        var_7 delete();
      }
    }
  }
}

_id_A418() {
  var_0 = ["salter", "admiral", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_jackals");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_jackals", var_0);
  scripts\engine\utility::flag_set("jackals_start_call_in");
  level.player giveweapon("iw7_ar57+ar57scope");
  level.player switchtoweaponimmediate("iw7_ar57+ar57scope");
  level.player scripts\sp\utility::_id_F526("safe");
  thread scripts\sp\maps\phspace\phspace::_id_107B6();
  thread scripts\sp\maps\phspace\phspace::_id_107F6();
  thread scripts\sp\maps\phspace\phspace::_id_107C0();
  level._id_EA99 vehicle_teleport(level._id_12B67.origin, level._id_12B67.angles);
}

_id_A417() {
  scripts\engine\utility::flag_wait("jackals_start_call_in");
  thread _id_A0EF();

  if(!isDefined(level._id_D127)) {
    level._id_D127 = scripts\sp\vehicle::_id_1080C("jackal_player");
  }

  level._id_D127 motionblurhqenable();
  level._id_D127 _id_0BDC::_id_104A6(0);
  level._id_D127._id_BBC9 = level._id_EC85["player_rig"]["ph_player_mount"];
  level._id_D127._id_BBCA = level._id_EC85["player_jackal"]["eth3n_mount_2"];
  level._id_D127 _id_0BDC::_id_F48D("default_landed");
  level._id_D127 _id_0BDC::_id_F5BD("phspace_launch");
  level._id_D127 _id_0BDC::_id_F420(500, 135, -30, 1, 1);
  level._id_D127 _id_0BDC::_id_A19F();
  level._id_D127 _id_0BDC::_id_A07D();
  var_0 = scripts\engine\utility::getStruct("jackal_callin_launch_animnode", "targetname");
  var_0 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_1 = "jackal_callin";
  wait 0.1;
  scripts\sp\vehicle_build::_id_31C6("script_vehicle_jackal_friendly_pearl", "default", "vfx/iw7/core/vehicle/jackal/vfx_jackal_wash_concrete.vfx", 1);
  scripts\sp\vehicle_build::_id_31C6("script_vehicle_jackal_friendly", "default", "vfx/iw7/core/vehicle/jackal/vfx_jackal_wash_concrete.vfx", 1);
  var_0 thread _id_376C(level._id_D127, var_1);
  var_0 thread _id_376E(level._id_EA99, var_1);
  var_0 thread _id_376D(level._id_12B67, var_1);
  level waittill("jackals_landed");
  level._id_D127 _id_0BDC::_id_6B4C("none", 0);
  level._id_A056._id_87D8 = 2.3;
  _id_0BDC::_id_137CF();

  if(scripts\sp\utility::_id_93A6()) {
    _id_0BD9::_id_FA4F();
  }

  level._id_D127 _id_0BDC::_id_A167();
  _id_0BDC::_id_A153(1);
  thread _id_6751();
  thread _id_4082();
  var_0 notify("stop_idle");
  thread _id_F5A5();
  thread disablelmgmount();
  wait 4.166;
  _id_104F6();
}

_id_6751() {
  level.player waittill("mount_link_complete");
  level.allies["eth3n"] scripts\sp\utility::_id_54F7();
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = level._id_A056._id_12F96[0].origin;
  var_0.angles = level._id_A056._id_12F96[0].angles;
  level.allies["eth3n"]._id_1FBB = "eth3n";
  var_0 scripts\sp\anim::_id_1F35(level.allies["eth3n"], "eth3n_mount_2");
  level.allies["eth3n"] scripts\sp\utility::_id_1101B();
  level.allies["eth3n"] delete();
}

_id_4082() {
  scripts\engine\utility::delaythread(9, scripts\engine\utility::flag_set, "handoff_cleanup");
  scripts\engine\utility::delaythread(22, scripts\sp\utility::_id_1264E, "phspace_ground_lite_tr");
}

disablelmgmount() {
  _id_0BDC::_id_137DA();
  _id_0BDC::_id_A156(1);
}

#using_animtree("jackal");

_id_376C(var_0, var_1) {
  var_0 scripts\engine\utility::delaythread(1, _id_0BDC::_id_6B4C, "fly", 1);
  var_0._id_99F5.draw_distance = 10000;
  var_0._id_99F5._id_56B6 = 360;
  var_0._id_99F5._id_12FC3 = 100;
  var_0._id_1FBB = "player_jackal";
  var_0 scripts\sp\anim::_id_F64A();
  var_0 _id_0BDC::_id_A2DE(1);
  var_0 scripts\engine\utility::delaythread(4.1, scripts\sp\utility::play_sound_on_tag, "phstreets_jackal_land_plr", "j_canopy");
  var_0 scripts\engine\utility::delaythread(13.8, scripts\sp\utility::play_sound_on_tag, "phstreets_jackal_land_swt", "j_canopy");
  level.player thread _id_CA93();
  var_0 scripts\engine\utility::delaythread(8.0, _id_0BDC::_id_6B4C, "hover", 1);
  thread scripts\sp\anim::_id_1F35(var_0, var_1);
  var_2 = getanimlength(level._id_EC85["player_jackal"][var_1]);
  scripts\engine\utility::delaythread(var_2 - 9, scripts\engine\utility::flag_set, "jackals_in_view");
  scripts\engine\utility::delaythread(var_2 - 4, ::_id_1130D, "jackal_callin_player_clip");
  var_0 scripts\engine\utility::delaythread(var_2 - 10, ::_id_D166);
  level.allies["eth3n"] thread _id_674E();
  wait(var_2 - 0.05);
  var_0 _meth_82B1(%ph_jackals_landing_jackal01, 0.0);
  wait 0.05;
  level._id_D127 _id_0BDC::_id_A167();
  level._id_D127._id_99F5._id_E526 = 0;
  level._id_D127 _id_0BDC::_id_104A6(1);
  scripts\engine\utility::flag_set("jackals_landed");
  _id_0BDC::_id_137CF();
  var_0 _meth_82B1(%ph_jackals_landing_jackal01, 1.0);
}

_id_D166() {
  var_0 = 8;
  objective_add(var_0, "current");
  objective_setpointertextoverride(var_0, " ");
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("tag_origin");
  var_1.angles = self.angles;
  var_2 = self gettagangles("TAG_ORIGIN");
  var_3 = vectorNormalize(anglesToForward(var_2));
  var_4 = vectorNormalize(anglestoup(var_2));
  var_5 = vectorNormalize(anglestoright(var_2));
  var_1.origin = self.origin + var_3 * 226 + var_4 * 20;
  var_1 linkTo(self);
  wait 0.1;
  objective_onentity(var_0, var_1);
  scripts\engine\utility::flag_wait("jackals_landed");
  objective_delete(var_0);
  var_1 delete();
}

_id_674E() {
  var_0 = getnode("eth3n_waiting", "targetname");
  wait 13.0;
  wait 0.15;
  scripts\sp\utility::_id_51E1("combat");
  self _meth_8250(1);
  self _meth_82EE(var_0);
  wait 0.8;
  scripts\sp\utility::_id_15F5("jackals_salter_to_jackal");
  level.allies["salter"] thread salter_chill_at_goal();
}

salter_chill_at_goal() {
  self.goalradius = 32;
  self waittill("goal");
  scripts\sp\utility::_id_51E1("casual_gun");
}

_id_376E(var_0, var_1) {
  level endon("start_launch");
  var_0._id_1FBB = "salter_jackal";
  var_0 scripts\sp\anim::_id_F64A();
  var_0 scripts\engine\utility::delaythread(10, _id_0BDC::_id_6B4C, "hover", 1);
  var_0 _id_0BDC::_id_19A0();
  var_2 = getanimlength(level._id_EC85["salter_jackal"][var_1]);
  scripts\engine\utility::delaythread(var_2 - 4, ::_id_1130D, "jackal_callin_salter_clip");
  scripts\sp\anim::_id_1F35(var_0, var_1);
  var_0 _id_0BDC::_id_A167();

  if(scripts\engine\utility::flag("start_launch")) {
    return;
  }
  var_0 _id_0BDC::_id_19A0();
  var_0 _id_0BDC::_id_6B4C("landed_mode", 1);
  thread scripts\sp\anim::_id_1EEA(var_0, "jackal_callin_idle", "stop_idle");
}

_id_376D(var_0, var_1) {
  var_0._id_1FBB = "retribution";
  var_0 scripts\sp\anim::_id_F64A();
  scripts\sp\anim::_id_1F35(var_0, var_1);
}

_id_1130D(var_0) {
  var_1 = getEnt(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  if(level.player istouching(var_1)) {
    level.player _meth_81D0();
  }

  var_1 solid();
  _id_0BDC::_id_137CF();
  wait 0.1;
  var_1 delete();
}

_id_F5A5() {
  wait 4.0;
  _id_1050B();
}

_id_6271() {
  wait 7.0;
  setsaveddvar("r_MBEnable", 1);
}

_id_A0EF() {
  scripts\engine\utility::flag_wait("jackals_in_view");
  scripts\engine\utility::flag_wait("jackals_landed");
  thread _id_8A02();
  _id_0BDC::_id_137CF();
  wait 0.1;
  wait 0.4;
  level.allies["admiral"] scripts\sp\utility::_id_10346("phspace_adm_ethanyourewithl");
  wait 1.1;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phspace_eth_yessir");
  wait 2.7;
  wait 1.5;
  scripts\sp\utility::_id_1034D("phspace_plr_sparkitfever");
  wait 0.2;
  scripts\sp\utility::_id_10350("phspace_slt_copy_2");
}

_id_8A02() {
  level.player endon("flag_player_has_jackal");
  wait 8;
  level.allies["salter"] scripts\sp\utility::_id_10346("phspace_slt_letsmountupreye");
  wait 6;
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_ltreyesyourewhe");
}

_id_CA93() {
  for(;;) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      level.player _meth_82C0("jackal_cockpit", 2);
      level waittill("jackal_landing");
      level.player playSound("jackal_landing_plr");
      level._id_D127 waittill("jackal_touchdown");
      level.player playSound("jackal_landed");
      level.player clearclienttriggeraudiozone(2.0);
      wait 2;
    } else {
      level waittill("jackal_enter");
      wait 1;
      level.player waittill("jackal_vtol_takeoff_plr");
      level.player playSound("jackal_vtol_takeoff_plr");
      wait 2;
    }

    wait 0.1;
  }
}

_id_A413() {
  thread _id_A414();
  level._id_5FA8 = 1;
}

_id_A414() {
  var_0 = getEnt("jackal_callin_player_clip", "targetname");
  var_1 = getEnt("jackal_callin_salter_clip", "targetname");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_1);
}

_id_A41B() {
  var_0 = ["salter", "admiral", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_jackals_dps");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_jackals_dps", var_0);
  scripts\engine\utility::flag_set("jackals_start_call_in");
  level.player giveweapon("iw7_ar57+ar57scope");
  level.player switchtoweaponimmediate("iw7_ar57+ar57scope");
  thread scripts\sp\maps\phspace\phspace::_id_107B6();
  thread scripts\sp\maps\phspace\phspace::_id_107F6();
}

_id_A41A() {
  level._id_D299 = _id_D2A6("player_sled");
  level._id_D2A1 = _id_D2A6("player_sled_launch", 1);
  level._id_D299._id_1FBB = "sled_jackal";
  level._id_D2A1._id_1FBB = "sled_jackal";

  if(getdvarint("e3", 0) == 1) {
    scripts\sp\maps\phspace\phspace_dps::_id_A0F0();
    var_0 = scripts\engine\utility::getStruct("jackal_callin_launch_animnode", "targetname");
    var_0 thread scripts\sp\anim::_id_1EC3(level._id_D2A1, "space_launch");
    _id_0BDC::_id_D164(level._id_D2A1._id_BD0D, 0);
    level.player freezecontrols(1);

    while(iscinematicplaying()) {
      scripts\engine\utility::waitframe();
    }

    level.player freezecontrols(0);
  }

  scripts\engine\utility::flag_wait("jackals_start_call_in");
  thread scripts\sp\maps\phspace\phspace_dps::_id_107B7();
  scripts\engine\utility::flag_set("jackals_start_call_in");
  _id_104F6();
}

_id_104FA() {
  scripts\sp\maps\phspace\phspace::_id_107A0();
  scripts\sp\maps\phspace\phspace::_id_107C0();
  _id_0BDC::_id_10CD1(level._id_D127, "launch_start_pos", "land");
  level._id_D127 _id_0BDC::_id_104A6(0);
  level._id_D127 _id_0BDC::_id_F5BD("ph_launch");
  thread scripts\sp\maps\phspace\phspace::_id_107B6();
  thread scripts\sp\maps\phspace\phspace::_id_107F6();
}

_id_104F6() {
  thread _id_CADE();
  thread _id_104F4();
  thread _id_760C();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_10D14();
  thread _id_104E9();
  scripts\engine\utility::flag_set("start_launch");
  thread scripts\sp\utility::_id_2669("space_launch_started");
  scripts\sp\maps\phspace\phspace::_id_1062E();

  if(getdvarint("e3", 0) != 1) {
    level._id_D299 = _id_D2A6("player_sled");
    level._id_D2A1 = _id_D2A6("player_sled_launch", 1);
  }

  level._id_AA61 = scripts\sp\vehicle::_id_1080C("launch_ca_destroyer_1");
  level._id_AA62 = scripts\sp\vehicle::_id_1080C("launch_ca_destroyer_2");
  level._id_AA63 = scripts\sp\vehicle::_id_1080C("launch_ca_destroyer_3");
  level._id_EA99 _id_0BDC::_id_6B4C("hover", 1);
  level._id_D299._id_1FBB = "sled_jackal";
  level._id_D2A1._id_1FBB = "sled_jackal";
  level._id_AA61._id_1FBB = "launch_ca_destroyer_1";
  level._id_AA62._id_1FBB = "launch_ca_destroyer_2";
  level._id_AA63._id_1FBB = "launch_ca_destroyer_3";
  var_0 = scripts\engine\utility::getStruct("jackal_callin_launch_animnode", "targetname");
  var_0 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  level._id_1EF0 = scripts\engine\utility::spawn_tag_origin();
  level._id_1EF0.origin = var_0.origin;
  level._id_1EF0.angles = var_0.angles;
  level._id_1EF0 linkTo(var_0);
  level._id_1EF0.parent = var_0;
  var_1 = [];
  var_1["retribution"] = level._id_12B67;
  var_1["tigris"] = level._id_12B7D;
  var_1["launch_ca_destroyer_1"] = level._id_AA61;
  var_1["launch_ca_destroyer_2"] = level._id_AA62;
  var_1["launch_ca_destroyer_3"] = level._id_AA63;
  level._id_1CB9 thread _id_AA50();
  level._id_EA99 thread _id_AA50();
  level._id_12B67 thread _id_AA55();
  level._id_12B7D thread _id_AA55();
  level._id_D2A1 thread _id_AA8D();
  thread space_launch_bounce_light();
  level._id_12B7D thread _id_104EA(["fx_engine_l_1", "fx_engine_l_4"], "thrust_cloud_glow_tigris");
  level._id_12B67 thread _id_104EA(["tag_engine_rear_l_out_002", "tag_engine_rear_r_out_002"], "thrust_cloud_glow_tigris");
  var_2 = "space_launch";
  var_0 thread scripts\sp\anim::_id_1EC1(var_1, var_2);
  level._id_1EF0 thread scripts\sp\anim::_id_1EC3(level._id_D2A1, var_2);
  level._id_1EF0 thread scripts\sp\anim::_id_1EC3(level._id_1CB9, var_2);
  var_0 thread scripts\sp\anim::_id_1F2C(var_1, var_2);
  level._id_1EF0 thread scripts\sp\anim::_id_1F35(level._id_EA99, var_2);
  level._id_1EF0 thread scripts\sp\anim::_id_1F35(level._id_1CB9, var_2);
  level._id_EA99 linkTo(level._id_1EF0);
  level._id_1CB9 linkTo(level._id_1EF0);
  var_0 thread _id_CFDE(var_2);
  level._id_EA99 _id_0BDC::_id_19A2();
  var_3 = scripts\engine\utility::getStruct("jackal_launch_animnode_clone", "targetname");
  var_3 = scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
  thread _id_AA9D();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(45);
  thread scripts\sp\maps\phspace\phspace::_id_CA28();
  scripts\sp\utility::_id_12651(["phspace_ground_tr", "phspace_ground_lite_tr"]);
  thread scripts\sp\utility::_id_12641("phspace_space_tr");
  settransientvisibility("phspace_space_tr", 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(60);
  waitforalltransients();
  settransientvisibility("phspace_space_tr", 1);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(70);
  scripts\engine\utility::flag_set("launch_prepare_teleport");
  setsaveddvar("sm_sunSampleSizeNear", 10.3);
  level waittill("player_allow_teleport");
  var_4 = spawn("script_origin", var_0.origin);
  var_4.angles = var_0.angles;
  level._id_D2A1 linkTo(var_0);
  scripts\engine\utility::flag_set("flag_pause_sun_fx_updates");
  wait 0.05;
  level._id_1161E = abs(var_4.origin[2] - var_3.origin[2]);
  var_0 _meth_83BA(var_4, var_3);
  level._id_111D0 _meth_83BA(var_4, var_3);
  teleportscene();
  level notify("teleport_scene");
  thread scripts\sp\utility::_id_241F(0);
  level._id_12B67 _id_0BB6::_id_39E9(0, 1);
  level._id_12B7D _id_0BB6::_id_39E9(0, 1);
  wait 0.05;
  var_4 delete();
  level._id_D2A1 unlink();
  level._id_EA99 _id_0C20::_id_AA79();
  level._id_EA99 _id_0BDC::_id_A2DC();
  level._id_1CB9 _id_0C20::_id_AA79();
  level._id_1CB9 _id_0BDC::_id_A2DC();
  scripts\engine\utility::delaythread(0.1, scripts\engine\utility::flag_clear, "flag_pause_sun_fx_updates");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_1103B();
  scripts\engine\utility::flag_set("begin_space_battle");
}

_id_10318() {
  wait 2;
  waitforalltransients();
}

_id_760C() {
  wait 10;
  scripts\engine\utility::exploder("timed_explosions");
}

_id_AA50(var_0) {
  scripts\sp\anim::_id_17F6(self._id_1FBB, "shells_sides", ::_id_C0D9);
  scripts\sp\anim::_id_17F6(self._id_1FBB, "shells_middle", ::_id_C0D8);
  scripts\sp\anim::_id_17F6(self._id_1FBB, "hide_panels", ::_id_C0CF);
  scripts\sp\anim::_id_17F6(self._id_1FBB, "boost_start", ::_id_C0C5);
  scripts\sp\anim::_id_17F6(self._id_1FBB, "boost_end", ::_id_C0C4);
  scripts\sp\anim::_id_17F6(self._id_1FBB, "hide_boosts", ::_id_C0CE);
}

_id_AA55(var_0) {
  scripts\sp\anim::_id_17F6(self._id_1FBB, "bottom_thrusters_on", ::_id_C0CB);
  scripts\sp\anim::_id_17F6(self._id_1FBB, "engine_trhusters_on", ::_id_C0CA);
  scripts\sp\anim::_id_17F6(self._id_1FBB, "engine_thrusters_on", ::_id_C0CA);
  scripts\sp\anim::_id_17F6(self._id_1FBB, "engine_thrusters_off", ::_id_C0C9);
}

_id_AA8D() {
  scripts\sp\anim::_id_17F6(self._id_1FBB, "stop_booster", ::_id_CF9A);
  scripts\sp\anim::_id_17F6(self._id_1FBB, "stop_booster", ::_id_CF51);
}

_id_C0CB(var_0) {
  var_0 _id_0BB8::_id_39D0("launch");
  var_0 thread _id_39F3("vfx_capship_un_thruster_vert_lrg_launch_singleton", -109500);
}

_id_39F3(var_0, var_1) {
  self._id_11836 = scripts\engine\utility::spawn_tag_origin();
  self._id_11837 = var_0;
  self endon("stop_launch_vert_wash");

  if(self == level._id_12B67) {
    level.player playSound("scn_phspace_launch_retribution_thrusters_on");
  } else {
    level.player playSound("scn_phspace_launch_tigris_thrusters_on");
  }

  playFXOnTag(scripts\engine\utility::getfx(var_0), self._id_11836, "tag_origin");

  for(;;) {
    self._id_11836.origin = (self.origin[0], self.origin[1], var_1);
    self._id_11836.angles = (0, 0, 0);
    wait 0.05;
  }
}

_id_39F2(var_0) {
  self notify("stop_launch_vert_wash");
  stopFXOnTag(scripts\engine\utility::getfx(self._id_11837), self._id_11836, "tag_origin");
  wait 20;
  self._id_11836 delete();
  self._id_11837 = undefined;
}

_id_C0CA(var_0) {
  if(var_0 == level._id_12B67) {
    var_0 thread scripts\sp\utility::play_sound_on_tag("phspace_launch_capital_02", "tag_engine_rear_l_out_003");
    var_0 thread _id_E317(1);
    thread scripts\engine\utility::delaythread(1, scripts\engine\utility::exploder, "vfx_ph_launch_smk_plume_ret");
    var_0 thread scripts\sp\utility::_id_75C4("vfx_flare_capship_launch_friendly_hero", "tag_engine_rear_l_out_003");
    var_0 thread scripts\sp\utility::_id_75C4("vfx_flare_capship_launch_friendly_hero", "tag_engine_rear_r_out_003");
    var_0 thread scripts\sp\utility::_id_75C4("vfx_veh_retr_thrust_rear_launch_child_singleton", "tag_engine_rear_l_out_003");
  } else {
    var_0 _id_0BB8::_id_39CD("launch");
    thread scripts\engine\utility::delaythread(1, scripts\engine\utility::exploder, "vfx_ph_launch_smk_plume_tigris");
    var_0 thread scripts\sp\utility::_id_75C4("vfx_flare_capship_launch_friendly_hero", "fx_engine_l_1");
    var_0 thread scripts\sp\utility::_id_75C4("vfx_flare_capship_launch_friendly_hero", "fx_engine_l_4");
    var_0 thread scripts\sp\utility::_id_75C4("vfx_capship_un_thruster_rear_lrg_launch_singleton", "fx_engine_l_2");
  }

  if(var_0 == level._id_12B7D) {
    var_0 playSound("phspace_launch_capital_01");
  }

  wait 0.65;
  var_0 _id_0BB8::_id_39D0("off");
  var_0 thread _id_39F2();
}

_id_50B8(var_0, var_1) {
  wait(var_0);
  scripts\engine\utility::exploder(var_1);
}

_id_C0C9(var_0) {
  var_0 _id_0BB8::_id_39CD("heavy");

  if(var_0 == level._id_12B67) {
    var_0 thread _id_E317(0);
  }
}

_id_C0C5(var_0) {
  var_0 _id_0BDC::_id_6B4C("launch_mode", 1);
  var_0 thread _id_0C20::_id_AA67(0);
  var_0 thread _id_0C20::_id_AA66(0);
}

_id_C0C4(var_0) {
  wait 5;

  if(!isDefined(var_0)) {
    return;
  }
  var_0 _id_0BDC::_id_19B0("hover");
  var_0 _id_0BDC::_id_6B4C("space", 1);
}

_id_C0DA(var_0) {}

_id_C0D9(var_0) {
  if(var_0 == level._id_1CB9) {
    var_0 playSound("jackal_panels_detach_01");
    var_0 scripts\engine\utility::delaycall(8.5, ::playsound, "phspace_launch_jackal_npc_01");
  } else if(var_0 == level._id_EA99) {
    var_0 playSound("jackal_panels_detach_02");
    var_0 scripts\engine\utility::delaycall(8.5, ::playsound, "phspace_launch_jackal_npc_02");
  }

  wait 0.5;
  var_0 thread _id_0C20::_id_AA67();
}

_id_C0D8(var_0) {
  var_0 _id_0BDC::_id_A1BC();
  wait 0.5;
  var_0 thread _id_0C20::_id_AA66();
}

_id_C0CF(var_0) {}

_id_C0CE(var_0) {
  if(var_0 == level._id_1CB9) {
    var_0 playSound("jackal_booster_detach_01");
    setmusicstate("geneva_exit_atmosphere");
    setglobalsoundcontext("atmosphere", "space", 4);
  } else if(var_0 == level._id_EA99)
    var_0 playSound("jackal_booster_detach_02");
}

_id_CFDE(var_0) {
  var_1 = "space_launch_boost";
  _id_0BDC::_id_A14C(1);
  _id_0BDC::_id_A1DD("land");
  thread scripts\sp\anim::_id_1F35(level._id_D2A1, var_0);
  thread _id_424D(var_0);
  level._id_D127 _id_0BDC::_id_137DB();
  _id_0BDC::_id_A14A(1);
  _id_0BDC::_id_A160(1);

  if(getdvarint("E3", 0) && !getdvarint("e3_negus", 0)) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(5);
  }

  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(10);

  if(getdvarint("E3", 0) && !getdvarint("e3_negus", 0)) {
    _id_5F9A(10);
  }

  earthquake(0.22, 1.1, level._id_D127.origin, 5000);
  level.player notify("jackal_vtol_takeoff_plr");
  level.player playSound("jackal_vtol_takeoff_plr");
  setomnvar("ui_jackal_autopilot", 1);
  _id_0BDC::_id_D164(level._id_D2A1._id_BD0D, 0);
  _id_0BDC::_id_A1DD("hover");
  thread _id_D2F6();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(31);
  thread _id_D2D8();
  _id_0BDB::_id_1147B(8);
  thread _id_0BDB::_id_CFE0(4.5);
  level._id_D127 waittill("notify_player_launch");
  thread hack_launch_visionsets();
  _id_0BDC::_id_A38E(16, 0.7, 0.7, 1.5);
  scripts\engine\utility::delaythread(5, scripts\sp\utility::_id_2669, "space_launch_boost");
  thread _id_104F3();
  thread _id_104FB();
  thread _id_104F8();
  thread _id_104E6();
  thread _id_CADD();
  thread _id_D27B();
  _id_0BDC::_id_A0BE(1);
  _id_0BDC::_id_A1DD("fly");
  thread scripts\sp\anim::_id_1F35(level._id_D2A1, var_1);
  var_2 = 4000;
  var_3 = 0.1;
  var_4 = 5;
  var_5 = var_4;
  var_6 = 7;
  var_7 = var_6;
  var_8 = spawnStruct();
  var_8._id_BC49 = (0, 0, 0);
  var_8._id_AFF8 = (0, 0, 0);
  var_8._id_1D11 = (0, 0, 0);
  var_8._id_11535 = 0;
  var_8._id_11533 = 0;
  var_8._id_E67D = 0;

  for(;;) {
    if(!isDefined(level._id_D299) || !isDefined(level._id_D2A1)) {
      break;
    }

    var_9 = level._id_D299 islegacyagent(level._id_EC85["sled_jackal"][var_1]);
    var_10 = level._id_D2A1 islegacyagent(level._id_EC85["sled_jackal"][var_1]);
    var_11 = var_9 - var_10;

    if(var_11 > 0) {
      var_12 = 1.6;
      var_13 = 0.1;
    } else {
      var_12 = 0.2;
      var_13 = 0.1;
    }

    var_14 = scripts\sp\math::_id_C09B(abs(var_11));
    var_15 = scripts\sp\math::_id_C097(0, var_13, var_14);
    var_16 = scripts\sp\math::_id_6A8E(1, var_12, var_15);
    level._id_D2A1 _meth_82B1(level._id_EC85["sled_jackal"][var_1], var_16);
    level._id_D2A1._id_BD0D unlink();
    level._id_D2A1._id_B025 unlink();
    level._id_1EF0 unlink();
    var_17 = anglesToForward(level._id_D2A1.angles);
    var_18 = anglestoright(level._id_D2A1.angles);
    var_19 = anglestoup(level._id_D2A1.angles);

    if(var_11 > 0) {
      var_20 = scripts\sp\math::_id_C097(0, var_3, var_11);
      var_20 = scripts\sp\math::_id_6A8E(0, var_2, var_20);
    } else
      var_20 = 0;

    if(var_5 > 0) {
      var_21 = 1 - scripts\sp\math::_id_C097(0, var_4, var_5);
      var_5 = var_5 - 0.05;
    } else if(scripts\engine\utility::flag("flag_player_boosters_disengaged")) {
      var_21 = scripts\sp\math::_id_C097(0, var_6, var_7);
      var_7 = var_7 - 0.05;

      if(var_7 < 0) {
        var_7 = 0;
      }
    } else
      var_21 = 1;

    var_20 = var_20 * var_19;

    if(!scripts\engine\utility::flag("flag_player_boosters_disengaged")) {
      var_8 _id_CFDF(var_17, var_18, var_19, var_21);
    }

    level._id_D2A1._id_BD0D.origin = level._id_D2A1.origin + (var_20 + var_8._id_BC49) * var_21;
    level._id_D2A1._id_B025.origin = level._id_D2A1._id_AFEB.origin + (var_20 + var_8._id_AFF8) * var_21;
    level._id_1EF0.origin = level._id_1EF0.parent.origin + var_8._id_1D11 * var_21;
    var_22 = vectorNormalize(level._id_D2A1._id_B025.origin - level._id_D2A1._id_BD0D.origin);
    level._id_D2A1._id_BD0D.angles = axistoangles(var_22, var_18, var_19) + (0, 0, var_8._id_E67D) * var_21;
    level._id_D2A1._id_BD0D linkTo(level._id_D2A1);
    level._id_D2A1._id_B025 linkTo(level._id_D2A1._id_AFEB);
    level._id_1EF0 linkTo(level._id_1EF0.parent);
    wait 0.05;

    if(var_7 <= 0.0) {
      return;
    }
  }
}

hack_launch_visionsets() {
  visionsetnaked("phspace_ground", 0);
  wait 4;
  visionsetnaked("", 4);
  var_0 = getEnt("trigger_sunfx_fadein", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  wait 4.6;
  visionsetnaked("phspace_sky_upper", 0);
  wait 0.05;
  var_1 = 15.4;
  visionsetnaked("phspace_fill", var_1);
  level waittill("teleport_scene");
  visionsetnaked("", 0);
}

_id_104EB() {
  _id_0BDC::_id_A250();
  setomnvar("ui_jackal_autopilot", 0);
  thread _id_104EC();
  thread _id_104EE();
  thread _id_104F1();
  thread _id_104F0();
  thread _id_104F2();
  thread _id_104ED();
}

_id_104EF() {
  level notify("launch_hud_off");
  _id_0BDC::_id_A250(0);
}

_id_104EC() {
  level endon("launch_hud_off");
  level._id_1161E = 0;

  for(;;) {
    var_0 = level._id_D127.origin[2];
    var_0 = var_0 - level._id_1161E;
    var_1 = scripts\sp\math::_id_C097(-109728, 80000, var_0);
    var_2 = scripts\sp\math::_id_6A8E(0, 310000, var_1);
    setomnvar("ui_jackal_launch_alt", int(var_2));
    wait 0.05;
  }
}

_id_104EE() {
  level._id_D127 waittill("notify_player_launch");
}

_id_104F1() {
  setomnvar("ui_jackal_launch_speed", 0);
  setomnvar("ui_jackal_launch_gforce", 0.0);
  level._id_D127 waittill("notify_player_launch");
  var_0 = 2;
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 1000, var_0);
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 2, var_0);
  wait(var_0);
  var_0 = 25;
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 35750, var_0);
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 9, var_0);
  wait(var_0);
  var_0 = 11;
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 42553, var_0);
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 0, var_0);
  level waittill("flag_player_boosters_disengaged");
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", getomnvar("ui_jackal_launch_speed") + 350, 21);
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 0, 0.1);
}

_id_104F2() {
  wait 2;
  setomnvar("ui_jackal_launch_state", 1);
  wait 2.5;
  setomnvar("ui_jackal_launch_state", 0);
  level._id_D127 waittill("notify_player_launch");
  wait 10.5;
  setomnvar("ui_jackal_launch_state", 1);
  wait 2.5;
  setomnvar("ui_jackal_launch_state", 2);
  wait 2.5;
  setomnvar("ui_jackal_launch_state", 0);
  _id_1379D("stop_booster", -0.1);
  setomnvar("ui_jackal_launch_state", 3);
  _id_1379D("stop_booster", 1.9);
  setomnvar("ui_jackal_launch_state", 4);
  _id_1379D("stop_booster", 10);
  setomnvar("ui_jackal_launch_state", 5);
  wait 2.5;
  setomnvar("ui_jackal_launch_state", 0);
}

_id_104ED() {
  level endon("launch_hud_off");
  setomnvar("ui_jackal_launch_fuel", 100);
  level._id_D127 waittill("notify_player_launch");
  var_0 = level._id_D2A1 islegacyagent(level._id_EC85["sled_jackal"]["space_launch_boost"]);
  var_1 = 0.7;

  for(;;) {
    var_2 = level._id_D2A1 islegacyagent(level._id_EC85["sled_jackal"]["space_launch_boost"]);
    var_3 = 1 - scripts\sp\math::_id_C097(var_0, var_1, var_2);
    var_4 = scripts\sp\math::_id_6A8E(0, 100, var_3);
    var_4 = scripts\sp\utility::_id_E753(var_4, 2);
    setomnvar("ui_jackal_launch_fuel", var_4);
    wait 0.05;
  }
}

_id_1379D(var_0, var_1) {
  var_2 = getanimlength(level._id_EC85["sled_jackal"]["space_launch_boost"]);
  var_3 = level._id_D299 islegacyagent(level._id_EC85["sled_jackal"]["space_launch_boost"]);
  var_3 = var_3 * var_2;
  var_4 = getnotetracktimes(level._id_EC85["sled_jackal"]["space_launch_boost"], var_0);
  var_4 = var_4[0] * var_2;
  var_5 = var_4 - var_3 + var_1;
  wait(var_5);
}

_id_104F0() {
  level endon("launch_hud_off");

  for(;;) {
    var_0 = level._id_D127 gettagangles("tag_body");
    var_1 = anglesToForward(var_0);
    var_2 = vectortoangles(var_1);
    setomnvar("ui_jackal_launch_pitch", abs(360 - var_2[0]));
    wait 0.05;
  }
}

_id_AB8A(var_0, var_1, var_2) {
  var_3 = getomnvar(var_0);
  level notify(var_0 + "_lerp_savedDvar");
  level endon(var_0 + "_lerp_savedDvar");
  var_4 = var_1 - var_3;
  var_5 = 0.05;
  var_6 = int(var_2 / var_5);

  for(var_7 = var_4 / var_6; var_6; var_6--) {
    var_3 = var_3 + var_7;
    setomnvar(var_0, var_3);
    wait(var_5);
  }

  setomnvar(var_0, var_1);
}

_id_5F9A(var_0) {
  level._id_1CB9 thread _id_5F9B(var_0);
  level._id_EA99 thread _id_5F9B(var_0);
  level._id_12B67 thread _id_5F9B(var_0);
  level._id_12B7D thread _id_5F9B(var_0);
  level._id_D2A1 thread _id_5F9B(var_0);
  level._id_AA61 thread _id_5F9B(var_0);
  level._id_AA62 thread _id_5F9B(var_0);
  level._id_AA63 thread _id_5F9B(var_0);
}

_id_5F9B(var_0) {
  var_1 = getanimlength(level._id_EC85[self._id_1FBB]["space_launch"]);
  var_2 = var_0 / var_1;
  self _meth_82B0(level._id_EC85[self._id_1FBB]["space_launch"], var_2);
}

_id_D2F6() {
  var_0 = (0, 0, -80);
  var_1 = anglesToForward(level._id_D127.angles) * 350;
  var_2 = level._id_D127.origin + var_0 + var_1;
  var_3 = vectortoangles((0, 0, 1));
  var_4 = 75;
  var_5 = 0;

  while(var_5 < var_4) {
    playFX(level.vehicle._id_116CE._id_112D9[level._id_D127.classname]["concrete_dry"], var_2, anglesToForward(var_3), anglestoup(var_3));
    var_5++;
    wait 0.05;
  }
}

_id_CFDF(var_0, var_1, var_2, var_3) {
  var_4 = 160;
  var_5 = 160;
  var_6 = 4500;
  var_7 = 10000;
  var_8 = 0.03;
  var_9 = 0.14;
  var_10 = 0.17;
  var_11 = 0.13;
  var_12 = 0.03;
  var_13 = 0.985;
  var_14 = 0.95;
  var_15 = 2800;
  var_16 = -1500;
  var_17 = -3800;
  var_18 = 3800;
  var_19 = level.player _meth_814B();
  var_19 = var_19 * var_3;
  self._id_11535 = self._id_11535 + var_19[0] * var_4;
  self._id_11533 = self._id_11533 + var_19[1] * var_5;

  if(self._id_11535 > var_15) {
    self._id_11535 = var_15;
  } else if(self._id_11535 < var_16) {
    self._id_11535 = var_16;
  }

  if(self._id_11533 < var_17) {
    self._id_11533 = var_17;
  } else if(self._id_11533 > var_18) {
    self._id_11533 = var_18;
  }

  self._id_11535 = self._id_11535 * var_13;
  self._id_11533 = self._id_11533 * var_13;
  var_20 = self._id_11535 * var_2 + self._id_11533 * var_1;
  self._id_BC49 = scripts\sp\math::_id_AB6F(self._id_BC49, var_20, var_8);
  self._id_AFF8 = scripts\sp\math::_id_AB6F(self._id_BC49, var_20, var_9);
  self._id_1D11 = scripts\sp\math::_id_AB6F(self._id_1D11, self._id_BC49, var_12);
  var_21 = (self._id_AFF8[1] - self._id_BC49[1]) * var_11;
  self._id_E67D = scripts\sp\math::_id_AB6F(self._id_E67D, var_21, var_10);
  self._id_E67D = self._id_E67D * var_14;
}

_id_D2D8() {
  thread _id_0BDC::_id_A2B0(%jackal_pilot_launch_button, %jackal_vehicle_launch_button, 1.1, 0.5);
  wait 2.1;
  earthquake(0.25, 0.75, level._id_D127.origin, 5000);
  level.player playRumbleOnEntity("damage_light");
  thread _id_104EB();
  level._id_D127 notify("notify_player_can_launch");
}

_id_CF9A(var_0) {
  if(var_0 != level._id_D2A1) {
    return;
  }
  var_1 = 1.9;
  wait(var_1);
  _id_0BDC::_id_A14C(0);
  level notify("player_booster_drop");
  thread _id_CAE1();
  level._id_D127 playSound("jackal_booster_detach_plr");
  level._id_D127 playSound("phspace_launch_space_creak");
  level.player stopsounds();
  level.player scripts\engine\utility::delaycall(5, ::clearsoundsubmix);
  _id_0BDC::_id_A0BE(0);
  _id_0BDC::_id_A1DD("hover");
  _id_0BDC::_id_A38E(undefined, undefined, undefined, 0.5);
  scripts\engine\utility::flag_set("flag_player_boosters_disengaged");
  wait 0.1;
  earthquake(0.32, 1.25, level._id_D127.origin, 1000000);
}

_id_CAE1() {
  scripts\engine\utility::delaythread(0.214, scripts\sp\utility::_id_1034D, "phspace_plr_breathtighten");
  scripts\engine\utility::delaythread(5.516, scripts\sp\utility::_id_10350, "phspace_gtr_vector10hours16");
  level.player scripts\engine\utility::delaycall(9.874, ::playsound, "quindar_02");
}

_id_CF51(var_0) {
  if(var_0 != level._id_D2A1) {
    return;
  }
  wait 2.0;
  level notify("player_allow_teleport");
}

_id_D352() {
  _id_0BDC::_id_A2B0(%jackal_pilot_weapon_button, %jackal_vehicle_weapon_button);
  _id_0BDC::_id_A153(0);
}

_id_D27B() {
  level endon("player_booster_drop");
  earthquake(0.48, 1.5, level._id_D127.origin, 5000);
  level._id_AA94 = 0.16;
  wait 0.75;

  for(;;) {
    var_0 = randomfloatrange(0.1, 0.15);
    var_1 = randomfloatrange(level._id_AA94, level._id_AA94 + 0.02);
    earthquake(var_1, var_0, level._id_D127.origin, 5000);
    wait(var_0 * 0.4);
  }
}

_id_D27C(var_0, var_1) {
  level notify("new_screenshake");
  level endon("new_screenshake");
  var_2 = level._id_AA94;
  var_3 = var_0 - var_2;
  var_4 = var_3 * (1 / (var_1 + 0.05) * 0.05);

  while(var_1 > 0) {
    var_1 = var_1 - 0.05;
    var_2 = var_2 + var_4;
    level._id_AA94 = var_2;
    wait 0.05;
  }

  level._id_AA94 = var_0;
}

_id_424D(var_0) {
  var_1 = getanimlength(level._id_EC85["sled_jackal"]["space_launch"]);

  if(getdvarint("E3", 0) && !getdvarint("e3_negus", 0)) {
    var_1 = var_1 - 6;
  }

  wait(var_1);
  var_2 = scripts\engine\utility::getStruct("jackal_launch_animnode_clone", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  var_2 scripts\sp\anim::_id_1F35(level._id_D299, "space_launch_boost");
}

_id_CADE() {
  wait 0.1;
  thread _id_11442();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(14);
  thread scripts\sp\utility::_id_10350("phspace_slt_lookwhatthey");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(16.767);
  thread scripts\sp\utility::_id_1034D("phspace_plr_letsgogetem");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(18.45);
  level.player playSound("quindar_01");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(18.719);
  thread scripts\sp\utility::_id_10350("phspace_gtr_toallavailablecraft");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(24.63);
  level.player playSound("quindar_02");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(25.069);
  thread scripts\sp\utility::_id_10350("phspace_slt_onetwocopylets");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(27.746);
  thread scripts\sp\utility::_id_10350("phspace_ecl_retributionthisisthe");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(31.534);
  level.player playSound("quindar_02");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(31.982);
  thread scripts\sp\utility::_id_1034D("phspace_plr_scarsfoldinwere");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(35.291);
  level.player playSound("quindar_01");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(35.032);
  thread scripts\sp\utility::_id_10350("phspace_gtr_pitching90for");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(37.933);
  level.player playSound("quindar_02");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(38.807);
  thread scripts\sp\utility::_id_1034D("phspace_plr_goflight");
}

_id_11442() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(9.967);
  setmusicstate("geneva_jackal_takeoff");
}

_id_408A() {
  var_0 = scripts\sp\utility::_id_77DA("jackals_hvr_marines");

  foreach(var_2 in var_0) {
    var_2 delete();
  }

  if(isDefined(level._id_11323)) {
    level._id_11323 delete();
    level._id_11324 delete();
    level._id_11321 delete();
    level._id_11322 delete();
  }
}

_id_AA9D() {
  level._id_12B67 thread _id_1186C();
  level._id_12B7D thread _id_1186D();
  level._id_AA61 thread _id_1186B();
  level._id_AA62 thread _id_1186B();
  level._id_AA63 thread _id_1186B();
  var_0 = level._id_39DD["cannon_large_un"]._id_10241;
  var_0._id_6D20 = 1;
  var_0._id_13536 = [1, 1];
  var_0._id_13535 = [5.1, 5.2];
  var_0 = level._id_39DD["missile_tube_un"]._id_10241;
  var_0._id_B46E = 5;
  level notify("stop_hill_vista_skyambient");
  thread _id_104F9();
  thread _id_104F5();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(10);
  scripts\engine\utility::exploder("vfx_ph_launch_smk_plume_ca1");
  scripts\engine\utility::exploder("vfx_ph_launch_smk_plume_ca2");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(13);
  level._id_12B7D scripts\engine\utility::delaycall(0.1, ::playsound, "scn_phspace_tigris_passby");
  level._id_AA61 thread _id_0BB6::_id_3966(1, 0, level._id_12B7D);
  level._id_AA62 thread _id_0BB6::_id_3966(1, 0, level._id_12B67);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(15);
  level._id_12B7D thread _id_0BB6::_id_3983(level._id_AA61);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(16);
  level._id_12B7D thread _id_0BB6::_id_3966(1, 0, level._id_AA61);
  level._id_12B67 thread _id_0BB6::_id_3966(1, 0, level._id_AA62);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(19);
  level._id_AA61 thread _id_0BB6::_id_3983(level._id_12B7D);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(20);
  level._id_12B7D thread _id_0BB6::_id_3983(level._id_AA62);
  level._id_12B67 scripts\engine\utility::delaycall(0.1, ::playsound, "scn_phspace_retribution_passby");
  level.player scripts\engine\utility::delaycall(7.0, ::playsound, "scn_phspace_launch_jackals_in");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(22);
  level._id_12B7D thread _id_0BB6::_id_3966(1, 0, level._id_AA62);
  level._id_AA62 thread _id_0BB6::_id_3983(level._id_12B67);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(24);
  level._id_12B7D thread _id_0BB6::_id_3983(level._id_AA62);
  level._id_AA61 thread _id_0BB6::_id_3967();
  level._id_AA62 thread _id_0BB6::_id_3967();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(29);
  level._id_12B7D thread _id_0BB6::_id_3983(level._id_AA62);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(33);
  level._id_12B7D thread _id_0BB6::_id_3967();
  level._id_12B67 thread _id_0BB6::_id_3967();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(45);
  level notify("stop_hill_vista_skyambient");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(51);
  level._id_AA61 _id_0BA9::_id_397B();
  level._id_AA62 _id_0BA9::_id_397B();
  level._id_AA63 _id_0BA9::_id_397B();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(77);
}

_id_1186C() {
  wait 0.1;
  _id_0BB8::_id_39CD("heavy");
  wait 0.1;
  _id_0BB8::_id_39D0("heavy");
}

_id_1186D() {
  _id_0BB8::_id_39CD("heavy");
  wait 0.1;
  _id_0BB8::_id_39D0("heavy");
}

_id_1186B() {
  scripts\sp\vehicle::_id_8441();
  self notsolid();
  _id_0BB8::_id_39D0("heavy");
  wait 0.1;
  _id_0BB8::_id_39CD("launch");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(10);
  thread scripts\sp\utility::_id_75C4("vfx_flare_capship_launch_enemy_hero", "fx_engine_l_1");
  thread scripts\sp\utility::_id_75C4("vfx_flare_capship_launch_enemy_hero", "fx_engine_l_2");
}

_id_D2A6(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_3 = scripts\sp\vehicle::_id_13237(var_2);
  var_3._id_4074 = [];

  if(isDefined(var_1) && var_1) {
    var_3._id_AFEB = scripts\engine\utility::spawn_tag_origin();
    var_3._id_AFEB.origin = var_3.origin + anglesToForward(var_3.angles) * 2500;
    var_3._id_AFEB linkTo(var_3);
    var_3._id_BD0D = scripts\engine\utility::spawn_tag_origin();
    var_3._id_BD0D linkTo(var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_3._id_B025 = scripts\engine\utility::spawn_tag_origin();
    var_3._id_B025 linkTo(var_3._id_AFEB, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_3._id_4074 = scripts\engine\utility::array_add(var_3._id_4074, var_3._id_AFEB);
    var_3._id_4074 = scripts\engine\utility::array_add(var_3._id_4074, var_3._id_BD0D);
    var_3._id_4074 = scripts\engine\utility::array_add(var_3._id_4074, var_3._id_B025);
  }

  var_3 setvehicleteam("allies");
  var_3 notsolid();
  var_3 thread _id_0BDC::_id_D29D();
  return var_3;
}

_id_104F9() {
  level._id_1028D show();
  var_0 = getEnt("trigger_show_upper_skybox_blend", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  level._id_1028B show();
  level._id_1028D hide();
}

_id_104F5() {
  var_0 = getEnt("trigger_local_cloudfx_thick", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  _id_104F7("vfx_ph_launch_player_local_clouds_thick");
  var_0 = getEnt("trigger_local_cloudfx_thin", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  _id_104F7("vfx_ph_launch_player_local_clouds_thin", "vfx_ph_launch_player_local_clouds_thick");
}

_id_AA74(var_0) {
  _id_0BB8::_id_39CD("burst");
  wait(var_0);
  _id_0BB8::_id_39CD("launch");
}

_id_104F7(var_0, var_1) {
  if(isDefined(var_0)) {
    playFXOnTag(scripts\engine\utility::getfx(var_0), level._id_D127, "j_mainroot_ship");
  }

  if(isDefined(var_1)) {
    stopFXOnTag(scripts\engine\utility::getfx(var_1), level._id_D127, "j_mainroot_ship");
  }
}

_id_104FC() {
  var_0 = getEnt("trigger_local_cloudfx_thick", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  var_1 = scripts\engine\utility::getStruct("clouds_mid_fx_struct", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin);
  wait 0.05;
  playFXOnTag(scripts\engine\utility::getfx("vfx_ph_launch_clouds_scattered_mid_02"), var_2, "tag_origin");
  level waittill("player_booster_drop");
  wait 3;
  killfxontag(scripts\engine\utility::getfx("vfx_ph_launch_clouds_scattered_mid_02"), var_2, "tag_origin");
  var_2 delete();
}

space_launch_bounce_light() {
  level.space_launch_bounce_light = scripts\engine\utility::spawn_tag_origin();
  level.space_launch_bounce_light.color = (0, 0, 0);
  level.space_launch_bounce_light thread space_launch_bounce_light_origin();
  var_0 = getEnt("trigger_sunfx_fadeout", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  playFXOnTag(scripts\engine\utility::getfx("launch_sky_bounce_light"), level.space_launch_bounce_light, "tag_origin");
  level.space_launch_bounce_light.color = (1, 0, 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(70);
  level.space_launch_bounce_light.color = (0, 1, 0);
  killfxontag(scripts\engine\utility::getfx("launch_sky_bounce_light"), level.space_launch_bounce_light, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("launch_sky_bounce_light_fade"), level.space_launch_bounce_light, "tag_origin");
  wait 6;
  level.space_launch_bounce_light delete();
}

space_launch_bounce_light_origin() {
  self endon("death");

  for(;;) {
    var_0 = level._id_12B7D space_launch_get_offset_from_ship();
    var_1 = level._id_12B67 space_launch_get_offset_from_ship();
    self.origin = (var_0 + var_1) * 0.5;
    self.angles = level._id_12B7D.angles;
    wait 0.05;
  }
}

space_launch_get_offset_from_ship() {
  return self.origin + anglesToForward(self.angles) * 3000 + anglestoup(self.angles) * 6000 + anglestoright(self.angles) * -1000;
}

_id_104EA(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = getEnt("trigger_local_cloudfx_thick", "targetname");
  var_3 _id_0BDC::_id_136A6(self);

  foreach(var_5 in var_0) {
    scripts\sp\utility::_id_75C4(var_1, var_5, var_2);
  }
}

_id_104E9() {
  var_0 = scripts\engine\utility::getStruct("cloudbank_fx_struct", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  scripts\engine\utility::waitframe();
  level waittill("space_launch_cleanup");
  scripts\sp\utility::_id_10FEC("ground_fx");
  var_1 delete();
}

_id_104F3() {
  var_0 = level._id_111D0._id_42D2;
  var_1 = 14;
  var_2 = (1, 1, 1);
  var_3 = 5;
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C44(var_0, var_3);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C46(var_2, var_1, var_3);
  var_0 = level._id_111D0._id_42D3;
  var_3 = 25;
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C44(var_0, var_3);
  playFXOnTag(scripts\engine\utility::getfx("vfx_sunflare"), level._id_111D0, "tag_origin");
  wait 9;
  var_0 = level._id_111D0._id_E485;
  var_2 = level._id_111D0._id_E487;
  var_1 = level._id_111D0._id_E486;
  var_3 = 12;
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C46(var_2, var_1, var_3);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C44(var_0, var_3);
}

_id_104F8() {
  var_0 = getEnt("trigger_sunfx_fadeout", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  wait 5;
  thread _id_D27C(0.22, 5);
  var_0 = getEnt("trigger_sunfx_fadein", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  thread _id_D27C(0.17, 3);
  wait 8;
  thread _id_D27C(0.24, 14);
}

_id_104E6() {
  var_0 = getEnt("trigger_sunfx_fadeout", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  wait 3;
  level._id_D127 thread scripts\sp\utility::_id_75C4("vfx_ph_jackal_canopy_drops", "j_mainroot_ship");
}

_id_104FB() {
  var_0 = getEnt("trigger_sunfx_fadeout", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  killfxontag(scripts\engine\utility::getfx("vfx_sunflare"), level._id_111D0, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_sunflare_fadeout"), level._id_111D0, "tag_origin");
  var_0 = getEnt("trigger_sunfx_fadein", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  killfxontag(scripts\engine\utility::getfx("vfx_sunflare_fadeout"), level._id_111D0, "tag_origin");
  wait 0.5;
}

_id_104F4() {
  _id_0BDC::_id_137CF();
  wait 1.5;

  while(!isDefined(level._id_AA61)) {
    wait 0.05;
  }

  level._id_AA61 castdistantshadows();
  level._id_AA62 castdistantshadows();
  level._id_AA63 castdistantshadows();
  level._id_12B67 castdistantshadows();
  level._id_12B7D castdistantshadows();
}

_id_1050B() {
  setsaveddvar("r_transShadowEnable", 1);
  setsaveddvar("r_heightfieldSunShadow", 0);
  setsaveddvar("sm_sunSampleSizeNear", 10.3);
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 3);
}

_id_CADD() {
  thread _id_CAE2();
  level.player playSound("phspace_launch_plr");
  wait 0.5;
  level.player setsoundsubmix("scn_jackal_plr");
  wait 25;
  setglobalsoundcontext("atmosphere", "space", 4);
  wait 1;
  level.player clearclienttriggeraudiozone(0);
  level.player _meth_82C0("jackal_cockpit", 4);
}

_id_CAE2() {
  scripts\engine\utility::delaythread(2.824, scripts\sp\utility::_id_1034D, "phspace_plr_oneonegoodthrottle");
  level.player scripts\engine\utility::delaycall(8.619, ::playsound, "quindar_01");
  level.player scripts\engine\utility::delaycall(16.854, ::playsound, "quindar_02");
  level.player scripts\engine\utility::delaycall(22.555, ::playsound, "quindar_01");
  level.player scripts\engine\utility::delaycall(32.726, ::playsound, "quindar_02");
  scripts\engine\utility::delaythread(5.323, scripts\sp\utility::_id_10350, "phspace_slt_onetwogoodthrottle");
  scripts\engine\utility::delaythread(10.021, scripts\sp\utility::_id_10350, "phspace_gtr_nominalgains");
  scripts\engine\utility::delaythread(14.903, scripts\sp\utility::_id_10350, "phspace_gtr_goingthru21000");
  scripts\engine\utility::delaythread(29.3, scripts\sp\utility::_id_10350, "phspace_gtr_atmosdragaccept");
}

_id_104E7() {
  thread _id_104E8();
}

_id_104E8() {
  level notify("space_launch_cleanup");
}

_id_E317(var_0) {
  var_1 = ["tag_engine_rear_l_out_01_launch", "tag_engine_rear_l_out_02_launch", "tag_engine_rear_l_out_03_launch", "tag_engine_rear_l_out_04_launch", "tag_engine_rear_r_out_01_launch", "tag_engine_rear_r_out_02_launch", "tag_engine_rear_r_out_03_launch", "tag_engine_rear_r_out_04_launch"];

  if(var_0) {
    var_2 = scripts\sp\utility::_id_75C4;
  } else {
    var_2 = scripts\sp\utility::_id_75F8;
  }

  foreach(var_4 in var_1) {
    self[[var_2]]("retribution_thrust_rear_launch", var_4);
  }
}

_id_118B9(var_0) {
  var_1 = ["fx_engine_l_1", "fx_engine_l_4"];

  if(var_0) {
    var_2 = scripts\sp\utility::_id_75C4;
  } else {
    var_2 = scripts\sp\utility::_id_75F8;
  }

  foreach(var_4 in var_1) {
    self[[var_2]]("un_thruster_rear_lrg_launch", var_4);
  }
}