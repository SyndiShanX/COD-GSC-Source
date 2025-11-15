/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phspace\phspace_launch.gsc
******************************************************/

func_CADC() {
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

func_8A08() {
  _setsaveddvar("bg_disableWeaponFirstRaiseAnims", 1);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_BC53("start_handoff");
  thread func_1073B();
  thread scripts\sp\maps\phspace\phspace::func_107B6();
  thread scripts\sp\maps\phspace\phspace::func_107F6();
}

func_8A06() {
  thread hvt_handoff_dof_scripts();
  scripts\sp\hud_util::func_10CCC();
  level.func_D127 = scripts\sp\vehicle::func_1080C("jackal_player");
  scripts\sp\maps\phspace\phspace::func_107C0();
  var_00 = ["salter", "admiral", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_BC05("start_handoff", var_00);
  wait 0.05;
  thread scripts\sp\utility::func_2669("phspace_started");

  foreach(var_02 in level.allies) {
    var_02 scripts\sp\utility::func_51E1("casual_gun");
    var_02 scripts\sp\utility::func_5504();
    var_02 scripts\sp\utility::func_5528();
    var_02 _meth_8250(1);
  }

  level.player scripts\sp\utility::func_F526("safe");
  level.player scripts\engine\utility::delaythread(1.0, scripts\sp\utility::func_F526, "safe");
  level.func_920F _meth_84AE();
  wait 0.05;
  thread func_6DCB();
  var_04 = getnode("start_handoff_salter", "targetname");
  var_05 = getnode("start_handoff_admiral", "targetname");
  var_06 = getnode("start_handoff_eth3n", "targetname");
  level.allies["salter"] thread scripts\sp\utility::func_7226(var_04, 10000, undefined, undefined);
  level.allies["admiral"] thread scripts\sp\utility::func_7226(var_05, 10000, undefined, undefined);
  level.allies["eth3n"] thread scripts\sp\utility::func_7226(var_06, 10000, undefined, undefined);
  thread func_5297();
  thread func_8A01();
  thread func_89FE();
  thread func_8A05();
  scripts\sp\hud_util::func_6A99(2);
  scripts\engine\utility::flag_wait("jackal_call_down");
  thread func_8A00();
  _setsaveddvar("bg_disableWeaponFirstRaiseAnims", 0);
}

hvt_handoff_dof_scripts() {
  thread func_0B0A::func_583F(0, 30, 2, 0.05, 400, 3, 0);
  wait 3;
  thread func_0B0A::func_583D(3);
}

func_6DCB() {
  wait 0.5;
  var_00 = scripts\engine\utility::getstruct("jackal_callin_launch_animnode", "targetname");
  var_00 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_00 scripts\sp\anim::func_1EC3(level.func_12B67, "jackal_callin");
  level.func_EA99 vehicle_teleport(level.func_12B67.origin, level.func_12B67.angles);
  level.func_D127 vehicle_teleport(level.func_12B67.origin, level.func_12B67.angles);
  wait 0.1;
  level.func_EA99 func_0BDC::func_19AB(0);
  level.func_EA99 func_0BDC::func_A1EC(level.func_12B67.origin, 1, 5000, level.func_12B67.angles);
}

func_5297() {
  if(!isDefined(game["phstreets_"])) {
    func_436B(1);
    return;
  } else {
    game["phstreets_"] = undefined;
    func_436B();
  }

  var_00 = getEntArray("lot_script_car", "targetname");

  foreach(var_02 in var_00)
  var_02 thread func_DAF0();
}

func_DAF0() {
  var_00 = scripts\engine\utility::get_target_ent();
  var_01 = getEntArray(var_0.target, "targetname");

  foreach(var_03 in var_01) {
    var_3.func_1FBB = var_3.script_noteworthy;
    var_03 scripts\sp\anim::func_F64A();
    var_3.clip = var_03 scripts\engine\utility::get_target_ent();
    var_3.clip linkto(var_03);
    var_3.clip connectpaths();
  }

  foreach(var_03 in var_01) {
    var_00 scripts\sp\anim::func_1EE0(var_03, "crate_explode");
    var_3.clip disconnectpaths();
  }

  wait 0.1;
  radiusdamage(var_0.origin, 500, 1000, 1000);
}

func_436B(var_00) {
  var_01 = getent("lot_jackal_statue", "targetname");
  var_1.func_1FBB = "lot_statue";
  var_01 setModel("decor_aatis_tower_globe_01");
  var_02 = getent("tower_statue_clip", "targetname");
  var_02 linkto(var_01, "j_base");
  var_01 scripts\sp\anim::func_F64A();

  if(scripts\engine\utility::is_true(var_00))
    var_01 scripts\sp\anim::func_1EC3(var_01, "statue_collapse");
  else
    var_01 scripts\sp\anim::func_1EE0(var_01, "statue_collapse");

  _createnavrepulsor("statue", 0, var_01, 384);
  var_02 disconnectpaths();
}

func_8A01() {
  level.player scripts\engine\utility::delaythread(0.2, scripts\sp\utility::func_D090, "ges_radio_safe");
  level.player scripts\engine\utility::delaycall(0.7, ::playsound, "ges_plr_radio_on");
  wait 0.9;
  scripts\sp\utility::func_1034D("phspace_plr_allstationsthis");
  level.player playSound("ges_plr_radio_off");
  level.player scripts\sp\utility::func_1102B("ges_radio_safe");
  level.allies["salter"] scripts\sp\utility::func_10346("phspace_slt_setdefsretreati");
  scripts\engine\utility::flag_set("handoff_done");
  scripts\engine\utility::flag_set("jackal_call_down");
  scripts\engine\utility::flag_set("jackals_start_call_in");
  thread scripts\sp\utility::func_2669("handoff_complete");
  thread func_8A04();
  level.player scripts\sp\utility::func_D090("ges_radio_safe");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  wait 0.5;
  scripts\sp\utility::func_1034D("phspace_plr_raidertomainlts");
  scripts\sp\utility::func_10350("phspace_nav_ayesir32willesc");
  scripts\sp\utility::func_1034D("phspace_plr_solidcopyseeyou");
  level.player playSound("ges_plr_radio_off");
  level.player scripts\sp\utility::func_1102B("ges_radio_safe");
  wait 0.1;
  scripts\sp\utility::func_10350("dps_s31_jackalstouching");
  wait 6.3;
  scripts\sp\utility::func_1034D("phspace_plr_thatsourrideeth");
}

func_8A04() {
  level.allies["admiral"] scripts\sp\utility::func_61C8();
  level.allies["salter"] scripts\sp\utility::func_61C8();
  level.allies["admiral"] scripts\sp\utility::func_F3B5("g");
  level.allies["salter"] scripts\sp\utility::func_F3B5("r");
  level.allies["salter"] scripts\sp\utility::func_61DB();
  level.allies["salter"] scripts\sp\utility::func_61F7();
  level.allies["salter"] thread func_1C1A();
  scripts\sp\utility::func_15F5("handoff_done_salter");
  wait 0.5;
  level.allies["eth3n"] scripts\sp\utility::func_61C8();
  level.allies["eth3n"] scripts\sp\utility::func_F3B5("p");
  level.allies["eth3n"] scripts\sp\utility::func_61DB();
  level.allies["eth3n"] scripts\sp\utility::func_61F7();
  level.allies["eth3n"] thread func_1C1A();
  wait 0.1;
  scripts\sp\utility::func_15F5("handoff_done_eth3n");
}

func_1C1A() {
  level endon("handoff_cleanup");

  for(var_00 = scripts\sp\utility::func_7951(level.player.origin, level.player.angles, self.origin); var_00 >= 0.4; var_00 = scripts\sp\utility::func_7951(level.player.origin, level.player.angles, self.origin))
    scripts\engine\utility::waitframe();

  scripts\sp\utility::func_4145();
}

#using_animtree("generic_human");

func_89FE() {
  var_00 = getent("hvt_soldier01", "targetname");
  var_01 = getent("hvt_soldier02", "targetname");
  var_02 = getent("hvt_soldier03", "targetname");
  var_03 = var_00 scripts\sp\utility::func_10619(1, 1);
  var_04 = var_01 scripts\sp\utility::func_10619(1, 1);
  var_05 = var_02 scripts\sp\utility::func_10619(1, 1);
  var_3.func_1FBB = "soldier01";
  var_4.func_1FBB = "soldier02";
  var_5.func_1FBB = "soldier03";
  var_06 = scripts\sp\utility::func_10639("handcuffs", level.func_920F.origin, level.func_920F.angles);
  level.func_9231 = [];
  level.func_9231[0] = level.func_920F;
  level.func_9231[1] = var_03;
  level.func_9231[2] = var_04;
  level.func_9231[3] = var_05;
  var_07 = scripts\engine\utility::getstruct("hvt_handoff_animnode", "targetname");

  if(!isDefined(var_07)) {
    return;
  }
  var_08 = [];
  var_8["soldier01"] = var_03;
  var_8["soldier02"] = var_04;
  var_8["soldier03"] = var_05;
  var_8["hvt"] = level.func_920F;
  var_8["handcuffs"] = var_06;
  var_09 = 0.6;
  var_10 = getanimlength( % ph_aatis_tower_hvt_handoff_ally01);
  var_07 thread scripts\sp\anim::func_1F2C(var_08, "hvt_handoff");
  wait 0.05;
  level.func_920F _meth_82B0( % ph_aatis_tower_hvt_handoff_hvt, var_09);
  var_03 _meth_82B0( % ph_aatis_tower_hvt_handoff_ally01, var_09);
  var_04 _meth_82B0( % ph_aatis_tower_hvt_handoff_ally02, var_09);
  var_05 _meth_82B0( % ph_aatis_tower_hvt_handoff_ally03, var_09);
  var_06 thread func_889A(var_09);
  wait(var_10 - var_10 * var_09 - 0.05);
  var_07 thread scripts\sp\anim::func_1EEA(var_03, "hvt_handoff_idle", "stop_handoff_idle");
  var_07 thread scripts\sp\anim::func_1EEA(var_04, "hvt_handoff_idle", "stop_handoff_idle");
  var_07 thread scripts\sp\anim::func_1EEA(var_05, "hvt_handoff_idle", "stop_handoff_idle");
  var_07 thread scripts\sp\anim::func_1EEA(level.func_920F, "hvt_handoff_idle", "stop_handoff_idle");
  var_07 thread scripts\sp\anim::func_1EEA(var_06, "hvt_handoff_idle", "stop_handoff_idle");
}

#using_animtree("script_model");

func_889A(var_00) {
  self _meth_82B0( % ph_aatis_tower_hvt_handoff_handcuffs, var_00);
}

func_8A05() {
  var_00 = getEntArray("hvt_marines", "targetname");
  level.func_923A = [];

  foreach(var_03, var_02 in var_00) {
    level.func_923A[var_03] = var_02 scripts\sp\utility::func_10619();
    level.func_923A[var_03] _meth_8250(1);
  }

  wait 3.0;

  foreach(var_05 in level.func_923A)
  var_05 scripts\sp\utility::func_51E1("casual_gun");
}

func_1073B(var_00) {
  if(!isDefined(level.func_920F)) {
    var_01 = getent("hvt", "targetname");
    level.func_920F = var_01 scripts\sp\utility::func_10619(1, 1);
    level.func_920F.func_1FBB = "hvt";
    level.func_920F.name = "Riah";
    level.func_920F.ignoreall = 1;
    level.func_920F.ignoreme = 1;
    level.func_920F.fixednode = 1;
  }

  if(isDefined(var_00)) {
    var_02 = getnode(var_00, "targetname");
    level.func_920F scripts\sp\utility::func_1160F(var_02);
  }
}

func_8A07() {
  level endon("handoff_done");
  scripts\engine\utility::flag_wait("player_passed_dropoff");
  level.allies["salter"] scripts\sp\utility::func_4145();
  level.allies["eth3n"] scripts\sp\utility::func_4145();
  level.allies["salter"] givescorefortrophyblocks();
  level.allies["eth3n"] givescorefortrophyblocks();
  level.allies["salter"] scripts\sp\utility::func_61C7();
  level.allies["eth3n"] scripts\sp\utility::func_61C7();
  level.allies["salter"] scripts\sp\utility::func_F3B5("r");
  level.allies["eth3n"] scripts\sp\utility::func_F3B5("p");
  scripts\sp\utility::func_15F5("handoff_done");
  level.player scripts\sp\utility::func_F526("normal");
}

func_89FF() {
  thread func_8A00();
}

func_8A00() {
  scripts\engine\utility::flag_wait("handoff_cleanup");

  if(isDefined(level.func_9231)) {
    foreach(var_01 in level.func_9231) {
      if(!isDefined(var_01)) {
        continue;
      }
      var_01 scripts\sp\utility::func_1101B();
      wait 0.05;
      var_01 delete();
    }
  }

  foreach(var_04 in level.allies) {
    if(!isDefined(var_04)) {
      continue;
    }
    if(var_04 == level.allies["eth3n"]) {
      continue;
    }
    var_04 scripts\sp\utility::func_1101B();
    var_04 notify("stop_idle");
    var_04 givescorefortrophyblocks();
    wait 0.05;
    var_04 delete();
  }

  if(isDefined(level.func_923A)) {
    foreach(var_07 in level.func_923A) {
      if(isDefined(var_07))
        var_07 delete();
    }
  }
}

func_A418() {
  var_00 = ["salter", "admiral", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_BC53("start_jackals");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_BC05("start_jackals", var_00);
  scripts\engine\utility::flag_set("jackals_start_call_in");
  level.player giveweapon("iw7_ar57+ar57scope");
  level.player switchtoweaponimmediate("iw7_ar57+ar57scope");
  level.player scripts\sp\utility::func_F526("safe");
  thread scripts\sp\maps\phspace\phspace::func_107B6();
  thread scripts\sp\maps\phspace\phspace::func_107F6();
  thread scripts\sp\maps\phspace\phspace::func_107C0();
  level.func_EA99 vehicle_teleport(level.func_12B67.origin, level.func_12B67.angles);
}

func_A417() {
  scripts\engine\utility::flag_wait("jackals_start_call_in");
  thread func_A0EF();

  if(!isDefined(level.func_D127))
    level.func_D127 = scripts\sp\vehicle::func_1080C("jackal_player");

  level.func_D127 motionblurhqenable();
  level.func_D127 func_0BDC::func_104A6(0);
  level.func_D127.func_BBC9 = level.func_EC85["player_rig"]["ph_player_mount"];
  level.func_D127.func_BBCA = level.func_EC85["player_jackal"]["eth3n_mount_2"];
  level.func_D127 func_0BDC::func_F48D("default_landed");
  level.func_D127 func_0BDC::func_F5BD("phspace_launch");
  level.func_D127 func_0BDC::func_F420(500, 135, -30, 1, 1);
  level.func_D127 func_0BDC::func_A19F();
  level.func_D127 func_0BDC::func_A07D();
  var_00 = scripts\engine\utility::getstruct("jackal_callin_launch_animnode", "targetname");
  var_00 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_01 = "jackal_callin";
  wait 0.1;
  scripts\sp\vehicle_build::func_31C6("script_vehicle_jackal_friendly_pearl", "default", "vfx\iw7\core\vehicle\jackal\vfx_jackal_wash_concrete.vfx", 1);
  scripts\sp\vehicle_build::func_31C6("script_vehicle_jackal_friendly", "default", "vfx\iw7\core\vehicle\jackal\vfx_jackal_wash_concrete.vfx", 1);
  var_00 thread func_376C(level.func_D127, var_01);
  var_00 thread func_376E(level.func_EA99, var_01);
  var_00 thread func_376D(level.func_12B67, var_01);
  level waittill("jackals_landed");
  level.func_D127 func_0BDC::func_6B4C("none", 0);
  level.func_A056.func_87D8 = 2.3;
  func_0BDC::func_137CF();

  if(scripts\sp\utility::func_93A6())
    func_0BD9::func_FA4F();

  level.func_D127 func_0BDC::func_A167();
  func_0BDC::func_A153(1);
  thread func_6751();
  thread func_4082();
  var_00 notify("stop_idle");
  thread func_F5A5();
  thread disablelmgmount();
  wait 4.166;
  func_104F6();
}

func_6751() {
  level.player waittill("mount_link_complete");
  level.allies["eth3n"] scripts\sp\utility::func_54F7();
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = level.func_A056.func_12F96[0].origin;
  var_0.angles = level.func_A056.func_12F96[0].angles;
  level.allies["eth3n"].func_1FBB = "eth3n";
  var_00 scripts\sp\anim::func_1F35(level.allies["eth3n"], "eth3n_mount_2");
  level.allies["eth3n"] scripts\sp\utility::func_1101B();
  level.allies["eth3n"] delete();
}

func_4082() {
  scripts\engine\utility::delaythread(9, scripts\engine\utility::flag_set, "handoff_cleanup");
  scripts\engine\utility::delaythread(22, scripts\sp\utility::func_1264E, "phspace_ground_lite_tr");
}

disablelmgmount() {
  func_0BDC::func_137DA();
  func_0BDC::func_A156(1);
}

#using_animtree("jackal");

func_376C(var_00, var_01) {
  var_00 scripts\engine\utility::delaythread(1, func_0BDC::func_6B4C, "fly", 1);
  var_0.func_99F5.draw_distance = 10000;
  var_0.func_99F5.func_56B6 = 360;
  var_0.func_99F5.func_12FC3 = 100;
  var_0.func_1FBB = "player_jackal";
  var_00 scripts\sp\anim::func_F64A();
  var_00 func_0BDC::func_A2DE(1);
  var_00 scripts\engine\utility::delaythread(4.1, scripts\sp\utility::play_sound_on_tag, "phstreets_jackal_land_plr", "j_canopy");
  var_00 scripts\engine\utility::delaythread(13.8, scripts\sp\utility::play_sound_on_tag, "phstreets_jackal_land_swt", "j_canopy");
  level.player thread func_CA93();
  var_00 scripts\engine\utility::delaythread(8.0, func_0BDC::func_6B4C, "hover", 1);
  thread scripts\sp\anim::func_1F35(var_00, var_01);
  var_02 = getanimlength(level.func_EC85["player_jackal"][var_01]);
  scripts\engine\utility::delaythread(var_02 - 9, scripts\engine\utility::flag_set, "jackals_in_view");
  scripts\engine\utility::delaythread(var_02 - 4, ::func_1130D, "jackal_callin_player_clip");
  var_00 scripts\engine\utility::delaythread(var_02 - 10, ::func_D166);
  level.allies["eth3n"] thread func_674E();
  wait(var_02 - 0.05);
  var_00 _meth_82B1( % ph_jackals_landing_jackal01, 0.0);
  wait 0.05;
  level.func_D127 func_0BDC::func_A167();
  level.func_D127.func_99F5.func_E526 = 0;
  level.func_D127 func_0BDC::func_104A6(1);
  scripts\engine\utility::flag_set("jackals_landed");
  func_0BDC::func_137CF();
  var_00 _meth_82B1( % ph_jackals_landing_jackal01, 1.0);
}

func_D166() {
  var_00 = 8;
  _objective_add(var_00, "current");
  _objective_setpointertextoverride(var_00, " ");
  var_01 = spawn("script_model", self.origin);
  var_01 setModel("tag_origin");
  var_1.angles = self.angles;
  var_02 = self gettagangles("TAG_ORIGIN");
  var_03 = vectornormalize(anglesToForward(var_02));
  var_04 = vectornormalize(anglestoup(var_02));
  var_05 = vectornormalize(anglestoright(var_02));
  var_1.origin = self.origin + var_03 * 226 + var_04 * 20;
  var_01 linkto(self);
  wait 0.1;
  objective_onentity(var_00, var_01);
  scripts\engine\utility::flag_wait("jackals_landed");
  objective_delete(var_00);
  var_01 delete();
}

func_674E() {
  var_00 = getnode("eth3n_waiting", "targetname");
  wait 13.0;
  wait 0.15;
  scripts\sp\utility::func_51E1("combat");
  self _meth_8250(1);
  self give_more_perk(var_00);
  wait 0.8;
  scripts\sp\utility::func_15F5("jackals_salter_to_jackal");
  level.allies["salter"] thread salter_chill_at_goal();
}

salter_chill_at_goal() {
  self.goalradius = 32;
  self waittill("goal");
  scripts\sp\utility::func_51E1("casual_gun");
}

func_376E(var_00, var_01) {
  level endon("start_launch");
  var_0.func_1FBB = "salter_jackal";
  var_00 scripts\sp\anim::func_F64A();
  var_00 scripts\engine\utility::delaythread(10, func_0BDC::func_6B4C, "hover", 1);
  var_00 func_0BDC::func_19A0();
  var_02 = getanimlength(level.func_EC85["salter_jackal"][var_01]);
  scripts\engine\utility::delaythread(var_02 - 4, ::func_1130D, "jackal_callin_salter_clip");
  scripts\sp\anim::func_1F35(var_00, var_01);
  var_00 func_0BDC::func_A167();

  if(scripts\engine\utility::flag("start_launch")) {
    return;
  }
  var_00 func_0BDC::func_19A0();
  var_00 func_0BDC::func_6B4C("landed_mode", 1);
  thread scripts\sp\anim::func_1EEA(var_00, "jackal_callin_idle", "stop_idle");
}

func_376D(var_00, var_01) {
  var_0.func_1FBB = "retribution";
  var_00 scripts\sp\anim::func_F64A();
  scripts\sp\anim::func_1F35(var_00, var_01);
}

func_1130D(var_00) {
  var_01 = getent(var_00, "targetname");

  if(!isDefined(var_01)) {
    return;
  }
  if(level.player istouching(var_01))
    level.player _meth_81D0();

  var_01 solid();
  func_0BDC::func_137CF();
  wait 0.1;
  var_01 delete();
}

func_F5A5() {
  wait 4.0;
  func_1050B();
}

func_6271() {
  wait 7.0;
  _setsaveddvar("r_MBEnable", 1);
}

func_A0EF() {
  scripts\engine\utility::flag_wait("jackals_in_view");
  scripts\engine\utility::flag_wait("jackals_landed");
  thread func_8A02();
  func_0BDC::func_137CF();
  wait 0.1;
  wait 0.4;
  level.allies["admiral"] scripts\sp\utility::func_10346("phspace_adm_ethanyourewithl");
  wait 1.1;
  level.allies["eth3n"] scripts\sp\utility::func_10346("phspace_eth_yessir");
  wait 2.7;
  wait 1.5;
  scripts\sp\utility::func_1034D("phspace_plr_sparkitfever");
  wait 0.2;
  scripts\sp\utility::func_10350("phspace_slt_copy_2");
}

func_8A02() {
  level.player endon("flag_player_has_jackal");
  wait 8;
  level.allies["salter"] scripts\sp\utility::func_10346("phspace_slt_letsmountupreye");
  wait 6;
  level.allies["admiral"] scripts\sp\utility::func_10346("phstreets_adm_ltreyesyourewhe");
}

func_CA93() {
  for(;;) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      level.player _meth_82C0("jackal_cockpit", 2);
      level waittill("jackal_landing");
      level.player playSound("jackal_landing_plr");
      level.func_D127 waittill("jackal_touchdown");
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

func_A413() {
  thread func_A414();
  level.func_5FA8 = 1;
}

func_A414() {
  var_00 = getent("jackal_callin_player_clip", "targetname");
  var_01 = getent("jackal_callin_salter_clip", "targetname");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_EA01(var_00);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_EA01(var_01);
}

func_A41B() {
  var_00 = ["salter", "admiral", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_BC53("start_jackals_dps");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_BC05("start_jackals_dps", var_00);
  scripts\engine\utility::flag_set("jackals_start_call_in");
  level.player giveweapon("iw7_ar57+ar57scope");
  level.player switchtoweaponimmediate("iw7_ar57+ar57scope");
  thread scripts\sp\maps\phspace\phspace::func_107B6();
  thread scripts\sp\maps\phspace\phspace::func_107F6();
}

func_A41A() {
  level.func_D299 = func_D2A6("player_sled");
  level.func_D2A1 = func_D2A6("player_sled_launch", 1);
  level.func_D299.func_1FBB = "sled_jackal";
  level.func_D2A1.func_1FBB = "sled_jackal";

  if(getdvarint("e3", 0) == 1) {
    scripts\sp\maps\phspace\phspace_dps::func_A0F0();
    var_00 = scripts\engine\utility::getstruct("jackal_callin_launch_animnode", "targetname");
    var_00 thread scripts\sp\anim::func_1EC3(level.func_D2A1, "space_launch");
    func_0BDC::func_D164(level.func_D2A1.func_BD0D, 0);
    level.player getroundswon(1);

    while(iscinematicplaying())
      scripts\engine\utility::waitframe();

    level.player getroundswon(0);
  }

  scripts\engine\utility::flag_wait("jackals_start_call_in");
  thread scripts\sp\maps\phspace\phspace_dps::func_107B7();
  scripts\engine\utility::flag_set("jackals_start_call_in");
  func_104F6();
}

func_104FA() {
  scripts\sp\maps\phspace\phspace::func_107A0();
  scripts\sp\maps\phspace\phspace::func_107C0();
  func_0BDC::func_10CD1(level.func_D127, "launch_start_pos", "land");
  level.func_D127 func_0BDC::func_104A6(0);
  level.func_D127 func_0BDC::func_F5BD("ph_launch");
  thread scripts\sp\maps\phspace\phspace::func_107B6();
  thread scripts\sp\maps\phspace\phspace::func_107F6();
}

func_104F6() {
  thread func_CADE();
  thread func_104F4();
  thread func_760C();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_10D14();
  thread func_104E9();
  scripts\engine\utility::flag_set("start_launch");
  thread scripts\sp\utility::func_2669("space_launch_started");
  scripts\sp\maps\phspace\phspace::func_1062E();

  if(getdvarint("e3", 0) != 1) {
    level.func_D299 = func_D2A6("player_sled");
    level.func_D2A1 = func_D2A6("player_sled_launch", 1);
  }

  level.func_AA61 = scripts\sp\vehicle::func_1080C("launch_ca_destroyer_1");
  level.func_AA62 = scripts\sp\vehicle::func_1080C("launch_ca_destroyer_2");
  level.func_AA63 = scripts\sp\vehicle::func_1080C("launch_ca_destroyer_3");
  level.func_EA99 func_0BDC::func_6B4C("hover", 1);
  level.func_D299.func_1FBB = "sled_jackal";
  level.func_D2A1.func_1FBB = "sled_jackal";
  level.func_AA61.func_1FBB = "launch_ca_destroyer_1";
  level.func_AA62.func_1FBB = "launch_ca_destroyer_2";
  level.func_AA63.func_1FBB = "launch_ca_destroyer_3";
  var_00 = scripts\engine\utility::getstruct("jackal_callin_launch_animnode", "targetname");
  var_00 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  level.func_1EF0 = scripts\engine\utility::spawn_tag_origin();
  level.func_1EF0.origin = var_0.origin;
  level.func_1EF0.angles = var_0.angles;
  level.func_1EF0 linkto(var_00);
  level.func_1EF0.parent = var_00;
  var_01 = [];
  var_1["retribution"] = level.func_12B67;
  var_1["tigris"] = level.func_12B7D;
  var_1["launch_ca_destroyer_1"] = level.func_AA61;
  var_1["launch_ca_destroyer_2"] = level.func_AA62;
  var_1["launch_ca_destroyer_3"] = level.func_AA63;
  level.func_1CB9 thread func_AA50();
  level.func_EA99 thread func_AA50();
  level.func_12B67 thread func_AA55();
  level.func_12B7D thread func_AA55();
  level.func_D2A1 thread func_AA8D();
  thread space_launch_bounce_light();
  level.func_12B7D thread func_104EA(["fx_engine_l_1", "fx_engine_l_4"], "thrust_cloud_glow_tigris");
  level.func_12B67 thread func_104EA(["tag_engine_rear_l_out_002", "tag_engine_rear_r_out_002"], "thrust_cloud_glow_tigris");
  var_02 = "space_launch";
  var_00 thread scripts\sp\anim::func_1EC1(var_01, var_02);
  level.func_1EF0 thread scripts\sp\anim::func_1EC3(level.func_D2A1, var_02);
  level.func_1EF0 thread scripts\sp\anim::func_1EC3(level.func_1CB9, var_02);
  var_00 thread scripts\sp\anim::func_1F2C(var_01, var_02);
  level.func_1EF0 thread scripts\sp\anim::func_1F35(level.func_EA99, var_02);
  level.func_1EF0 thread scripts\sp\anim::func_1F35(level.func_1CB9, var_02);
  level.func_EA99 linkto(level.func_1EF0);
  level.func_1CB9 linkto(level.func_1EF0);
  var_00 thread func_CFDE(var_02);
  level.func_EA99 func_0BDC::func_19A2();
  var_03 = scripts\engine\utility::getstruct("jackal_launch_animnode_clone", "targetname");
  var_03 = scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
  thread func_AA9D();
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(45);
  thread scripts\sp\maps\phspace\phspace::func_CA28();
  scripts\sp\utility::func_12651(["phspace_ground_tr", "phspace_ground_lite_tr"]);
  thread scripts\sp\utility::func_12641("phspace_space_tr");
  _settransientvisibility("phspace_space_tr", 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(60);
  _waitforalltransients();
  _settransientvisibility("phspace_space_tr", 1);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(70);
  scripts\engine\utility::flag_set("launch_prepare_teleport");
  _setsaveddvar("sm_sunSampleSizeNear", 10.3);
  level waittill("player_allow_teleport");
  var_04 = spawn("script_origin", var_0.origin);
  var_4.angles = var_0.angles;
  level.func_D2A1 linkto(var_00);
  scripts\engine\utility::flag_set("flag_pause_sun_fx_updates");
  wait 0.05;
  level.func_1161E = abs(var_4.origin[2] - var_3.origin[2]);
  var_00 giveweaponpassives(var_04, var_03);
  level.func_111D0 giveweaponpassives(var_04, var_03);
  _teleportscene();
  level notify("teleport_scene");
  thread scripts\sp\utility::func_241F(0);
  level.func_12B67 func_0BB6::func_39E9(0, 1);
  level.func_12B7D func_0BB6::func_39E9(0, 1);
  wait 0.05;
  var_04 delete();
  level.func_D2A1 unlink();
  level.func_EA99 func_0C20::func_AA79();
  level.func_EA99 func_0BDC::func_A2DC();
  level.func_1CB9 func_0C20::func_AA79();
  level.func_1CB9 func_0BDC::func_A2DC();
  scripts\engine\utility::delaythread(0.1, scripts\engine\utility::flag_clear, "flag_pause_sun_fx_updates");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_1103B();
  scripts\engine\utility::flag_set("begin_space_battle");
}

func_10318() {
  wait 2;
  _waitforalltransients();
}

func_760C() {
  wait 10;
  scripts\engine\utility::exploder("timed_explosions");
}

func_AA50(var_00) {
  scripts\sp\anim::func_17F6(self.func_1FBB, "shells_sides", ::func_C0D9);
  scripts\sp\anim::func_17F6(self.func_1FBB, "shells_middle", ::func_C0D8);
  scripts\sp\anim::func_17F6(self.func_1FBB, "hide_panels", ::func_C0CF);
  scripts\sp\anim::func_17F6(self.func_1FBB, "boost_start", ::func_C0C5);
  scripts\sp\anim::func_17F6(self.func_1FBB, "boost_end", ::func_C0C4);
  scripts\sp\anim::func_17F6(self.func_1FBB, "hide_boosts", ::func_C0CE);
}

func_AA55(var_00) {
  scripts\sp\anim::func_17F6(self.func_1FBB, "bottom_thrusters_on", ::func_C0CB);
  scripts\sp\anim::func_17F6(self.func_1FBB, "engine_trhusters_on", ::func_C0CA);
  scripts\sp\anim::func_17F6(self.func_1FBB, "engine_thrusters_on", ::func_C0CA);
  scripts\sp\anim::func_17F6(self.func_1FBB, "engine_thrusters_off", ::func_C0C9);
}

func_AA8D() {
  scripts\sp\anim::func_17F6(self.func_1FBB, "stop_booster", ::func_CF9A);
  scripts\sp\anim::func_17F6(self.func_1FBB, "stop_booster", ::func_CF51);
}

func_C0CB(var_00) {
  var_00 func_0BB8::func_39D0("launch");
  var_00 thread func_39F3("vfx_capship_un_thruster_vert_lrg_launch_singleton", -109500);
}

func_39F3(var_00, var_01) {
  self.func_11836 = scripts\engine\utility::spawn_tag_origin();
  self.func_11837 = var_00;
  self endon("stop_launch_vert_wash");

  if(self == level.func_12B67)
    level.player playSound("scn_phspace_launch_retribution_thrusters_on");
  else
    level.player playSound("scn_phspace_launch_tigris_thrusters_on");

  playFXOnTag(scripts\engine\utility::getfx(var_00), self.func_11836, "tag_origin");

  for(;;) {
    self.func_11836.origin = (self.origin[0], self.origin[1], var_01);
    self.func_11836.angles = (0, 0, 0);
    wait 0.05;
  }
}

func_39F2(var_00) {
  self notify("stop_launch_vert_wash");
  stopFXOnTag(scripts\engine\utility::getfx(self.func_11837), self.func_11836, "tag_origin");
  wait 20;
  self.func_11836 delete();
  self.func_11837 = undefined;
}

func_C0CA(var_00) {
  if(var_00 == level.func_12B67) {
    var_00 thread scripts\sp\utility::play_sound_on_tag("phspace_launch_capital_02", "tag_engine_rear_l_out_003");
    var_00 thread func_E317(1);
    thread scripts\engine\utility::delaythread(1, scripts\engine\utility::exploder, "vfx_ph_launch_smk_plume_ret");
    var_00 thread scripts\sp\utility::func_75C4("vfx_flare_capship_launch_friendly_hero", "tag_engine_rear_l_out_003");
    var_00 thread scripts\sp\utility::func_75C4("vfx_flare_capship_launch_friendly_hero", "tag_engine_rear_r_out_003");
    var_00 thread scripts\sp\utility::func_75C4("vfx_veh_retr_thrust_rear_launch_child_singleton", "tag_engine_rear_l_out_003");
  } else {
    var_00 func_0BB8::func_39CD("launch");
    thread scripts\engine\utility::delaythread(1, scripts\engine\utility::exploder, "vfx_ph_launch_smk_plume_tigris");
    var_00 thread scripts\sp\utility::func_75C4("vfx_flare_capship_launch_friendly_hero", "fx_engine_l_1");
    var_00 thread scripts\sp\utility::func_75C4("vfx_flare_capship_launch_friendly_hero", "fx_engine_l_4");
    var_00 thread scripts\sp\utility::func_75C4("vfx_capship_un_thruster_rear_lrg_launch_singleton", "fx_engine_l_2");
  }

  if(var_00 == level.func_12B7D)
    var_00 playSound("phspace_launch_capital_01");

  wait 0.65;
  var_00 func_0BB8::func_39D0("off");
  var_00 thread func_39F2();
}

func_50B8(var_00, var_01) {
  wait(var_00);
  scripts\engine\utility::exploder(var_01);
}

func_C0C9(var_00) {
  var_00 func_0BB8::func_39CD("heavy");

  if(var_00 == level.func_12B67)
    var_00 thread func_E317(0);
}

func_C0C5(var_00) {
  var_00 func_0BDC::func_6B4C("launch_mode", 1);
  var_00 thread func_0C20::func_AA67(0);
  var_00 thread func_0C20::func_AA66(0);
}

func_C0C4(var_00) {
  wait 5;

  if(!isDefined(var_00)) {
    return;
  }
  var_00 func_0BDC::func_19B0("hover");
  var_00 func_0BDC::func_6B4C("space", 1);
}

func_C0DA(var_00) {}

func_C0D9(var_00) {
  if(var_00 == level.func_1CB9) {
    var_00 playSound("jackal_panels_detach_01");
    var_00 scripts\engine\utility::delaycall(8.5, ::playsound, "phspace_launch_jackal_npc_01");
  } else if(var_00 == level.func_EA99) {
    var_00 playSound("jackal_panels_detach_02");
    var_00 scripts\engine\utility::delaycall(8.5, ::playsound, "phspace_launch_jackal_npc_02");
  }

  wait 0.5;
  var_00 thread func_0C20::func_AA67();
}

func_C0D8(var_00) {
  var_00 func_0BDC::func_A1BC();
  wait 0.5;
  var_00 thread func_0C20::func_AA66();
}

func_C0CF(var_00) {}

func_C0CE(var_00) {
  if(var_00 == level.func_1CB9) {
    var_00 playSound("jackal_booster_detach_01");
    _setmusicstate("geneva_exit_atmosphere");
    setglobalsoundcontext("atmosphere", "space", 4);
  } else if(var_00 == level.func_EA99)
    var_00 playSound("jackal_booster_detach_02");
}

func_CFDE(var_00) {
  var_01 = "space_launch_boost";
  func_0BDC::func_A14C(1);
  func_0BDC::func_A1DD("land");
  thread scripts\sp\anim::func_1F35(level.func_D2A1, var_00);
  thread func_424D(var_00);
  level.func_D127 func_0BDC::func_137DB();
  func_0BDC::func_A14A(1);
  func_0BDC::func_A160(1);

  if(getdvarint("E3", 0) && !getdvarint("e3_negus", 0))
    scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(5);

  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(10);

  if(getdvarint("E3", 0) && !getdvarint("e3_negus", 0))
    func_5F9A(10);

  earthquake(0.22, 1.1, level.func_D127.origin, 5000);
  level.player notify("jackal_vtol_takeoff_plr");
  level.player playSound("jackal_vtol_takeoff_plr");
  setomnvar("ui_jackal_autopilot", 1);
  func_0BDC::func_D164(level.func_D2A1.func_BD0D, 0);
  func_0BDC::func_A1DD("hover");
  thread func_D2F6();
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(31);
  thread func_D2D8();
  func_0BDB::func_1147B(8);
  thread func_0BDB::func_CFE0(4.5);
  level.func_D127 waittill("notify_player_launch");
  thread hack_launch_visionsets();
  func_0BDC::func_A38E(16, 0.7, 0.7, 1.5);
  scripts\engine\utility::delaythread(5, scripts\sp\utility::func_2669, "space_launch_boost");
  thread func_104F3();
  thread func_104FB();
  thread func_104F8();
  thread func_104E6();
  thread func_CADD();
  thread func_D27B();
  func_0BDC::func_A0BE(1);
  func_0BDC::func_A1DD("fly");
  thread scripts\sp\anim::func_1F35(level.func_D2A1, var_01);
  var_02 = 4000;
  var_03 = 0.1;
  var_04 = 5;
  var_05 = var_04;
  var_06 = 7;
  var_07 = var_06;
  var_08 = spawnStruct();
  var_8.func_BC49 = (0, 0, 0);
  var_8.func_AFF8 = (0, 0, 0);
  var_8.func_1D11 = (0, 0, 0);
  var_8.func_11535 = 0;
  var_8.func_11533 = 0;
  var_8.func_E67D = 0;

  for(;;) {
    if(!isDefined(level.func_D299) || !isDefined(level.func_D2A1)) {
      break;
    }
    var_09 = level.func_D299 islegacyagent(level.func_EC85["sled_jackal"][var_01]);
    var_10 = level.func_D2A1 islegacyagent(level.func_EC85["sled_jackal"][var_01]);
    var_11 = var_09 - var_10;

    if(var_11 > 0) {
      var_12 = 1.6;
      var_13 = 0.1;
    } else {
      var_12 = 0.2;
      var_13 = 0.1;
    }

    var_14 = scripts\sp\math::func_C09B(abs(var_11));
    var_15 = scripts\sp\math::func_C097(0, var_13, var_14);
    var_16 = scripts\sp\math::func_6A8E(1, var_12, var_15);
    level.func_D2A1 _meth_82B1(level.func_EC85["sled_jackal"][var_01], var_16);
    level.func_D2A1.func_BD0D unlink();
    level.func_D2A1.func_B025 unlink();
    level.func_1EF0 unlink();
    var_17 = anglesToForward(level.func_D2A1.angles);
    var_18 = anglestoright(level.func_D2A1.angles);
    var_19 = anglestoup(level.func_D2A1.angles);

    if(var_11 > 0) {
      var_20 = scripts\sp\math::func_C097(0, var_03, var_11);
      var_20 = scripts\sp\math::func_6A8E(0, var_02, var_20);
    } else
      var_20 = 0;

    if(var_05 > 0) {
      var_21 = 1 - scripts\sp\math::func_C097(0, var_04, var_05);
      var_05 = var_05 - 0.05;
    } else if(scripts\engine\utility::flag("flag_player_boosters_disengaged")) {
      var_21 = scripts\sp\math::func_C097(0, var_06, var_07);
      var_07 = var_07 - 0.05;

      if(var_07 < 0)
        var_07 = 0;
    } else
      var_21 = 1;

    var_20 = var_20 * var_19;

    if(!scripts\engine\utility::flag("flag_player_boosters_disengaged"))
      var_08 func_CFDF(var_17, var_18, var_19, var_21);

    level.func_D2A1.func_BD0D.origin = level.func_D2A1.origin + (var_20 + var_8.func_BC49) * var_21;
    level.func_D2A1.func_B025.origin = level.func_D2A1.func_AFEB.origin + (var_20 + var_8.func_AFF8) * var_21;
    level.func_1EF0.origin = level.func_1EF0.parent.origin + var_8.func_1D11 * var_21;
    var_22 = vectornormalize(level.func_D2A1.func_B025.origin - level.func_D2A1.func_BD0D.origin);
    level.func_D2A1.func_BD0D.angles = _axistoangles(var_22, var_18, var_19) + (0, 0, var_8.func_E67D) * var_21;
    level.func_D2A1.func_BD0D linkto(level.func_D2A1);
    level.func_D2A1.func_B025 linkto(level.func_D2A1.func_AFEB);
    level.func_1EF0 linkto(level.func_1EF0.parent);
    wait 0.05;

    if(var_07 <= 0.0)
      return;
  }
}

hack_launch_visionsets() {
  visionsetnaked("phspace_ground", 0);
  wait 4;
  visionsetnaked("", 4);
  var_00 = getent("trigger_sunfx_fadein", "targetname");
  var_00 func_0BDC::func_136A6(level.func_D127);
  wait 4.6;
  visionsetnaked("phspace_sky_upper", 0);
  wait 0.05;
  var_01 = 15.4;
  visionsetnaked("phspace_fill", var_01);
  level waittill("teleport_scene");
  visionsetnaked("", 0);
}

func_104EB() {
  func_0BDC::func_A250();
  setomnvar("ui_jackal_autopilot", 0);
  thread func_104EC();
  thread func_104EE();
  thread func_104F1();
  thread func_104F0();
  thread func_104F2();
  thread func_104ED();
}

func_104EF() {
  level notify("launch_hud_off");
  func_0BDC::func_A250(0);
}

func_104EC() {
  level endon("launch_hud_off");
  level.func_1161E = 0;

  for(;;) {
    var_00 = level.func_D127.origin[2];
    var_00 = var_00 - level.func_1161E;
    var_01 = scripts\sp\math::func_C097(-109728, 80000, var_00);
    var_02 = scripts\sp\math::func_6A8E(0, 310000, var_01);
    setomnvar("ui_jackal_launch_alt", int(var_02));
    wait 0.05;
  }
}

func_104EE() {
  level.func_D127 waittill("notify_player_launch");
}

func_104F1() {
  setomnvar("ui_jackal_launch_speed", 0);
  setomnvar("ui_jackal_launch_gforce", 0.0);
  level.func_D127 waittill("notify_player_launch");
  var_00 = 2;
  thread scripts\sp\utility::func_AB8B("ui_jackal_launch_speed", 1000, var_00);
  thread scripts\sp\utility::func_AB89("ui_jackal_launch_gforce", 2, var_00);
  wait(var_00);
  var_00 = 25;
  thread scripts\sp\utility::func_AB8B("ui_jackal_launch_speed", 35750, var_00);
  thread scripts\sp\utility::func_AB89("ui_jackal_launch_gforce", 9, var_00);
  wait(var_00);
  var_00 = 11;
  thread scripts\sp\utility::func_AB8B("ui_jackal_launch_speed", 42553, var_00);
  thread scripts\sp\utility::func_AB89("ui_jackal_launch_gforce", 0, var_00);
  level waittill("flag_player_boosters_disengaged");
  thread scripts\sp\utility::func_AB8B("ui_jackal_launch_speed", getomnvar("ui_jackal_launch_speed") + 350, 21);
  thread scripts\sp\utility::func_AB89("ui_jackal_launch_gforce", 0, 0.1);
}

func_104F2() {
  wait 2;
  setomnvar("ui_jackal_launch_state", 1);
  wait 2.5;
  setomnvar("ui_jackal_launch_state", 0);
  level.func_D127 waittill("notify_player_launch");
  wait 10.5;
  setomnvar("ui_jackal_launch_state", 1);
  wait 2.5;
  setomnvar("ui_jackal_launch_state", 2);
  wait 2.5;
  setomnvar("ui_jackal_launch_state", 0);
  func_1379D("stop_booster", -0.1);
  setomnvar("ui_jackal_launch_state", 3);
  func_1379D("stop_booster", 1.9);
  setomnvar("ui_jackal_launch_state", 4);
  func_1379D("stop_booster", 10);
  setomnvar("ui_jackal_launch_state", 5);
  wait 2.5;
  setomnvar("ui_jackal_launch_state", 0);
}

func_104ED() {
  level endon("launch_hud_off");
  setomnvar("ui_jackal_launch_fuel", 100);
  level.func_D127 waittill("notify_player_launch");
  var_00 = level.func_D2A1 islegacyagent(level.func_EC85["sled_jackal"]["space_launch_boost"]);
  var_01 = 0.7;

  for(;;) {
    var_02 = level.func_D2A1 islegacyagent(level.func_EC85["sled_jackal"]["space_launch_boost"]);
    var_03 = 1 - scripts\sp\math::func_C097(var_00, var_01, var_02);
    var_04 = scripts\sp\math::func_6A8E(0, 100, var_03);
    var_04 = scripts\sp\utility::func_E753(var_04, 2);
    setomnvar("ui_jackal_launch_fuel", var_04);
    wait 0.05;
  }
}

func_1379D(var_00, var_01) {
  var_02 = getanimlength(level.func_EC85["sled_jackal"]["space_launch_boost"]);
  var_03 = level.func_D299 islegacyagent(level.func_EC85["sled_jackal"]["space_launch_boost"]);
  var_03 = var_03 * var_02;
  var_04 = getnotetracktimes(level.func_EC85["sled_jackal"]["space_launch_boost"], var_00);
  var_04 = var_4[0] * var_02;
  var_05 = var_04 - var_03 + var_01;
  wait(var_05);
}

func_104F0() {
  level endon("launch_hud_off");

  for(;;) {
    var_00 = level.func_D127 gettagangles("tag_body");
    var_01 = anglesToForward(var_00);
    var_02 = vectortoangles(var_01);
    setomnvar("ui_jackal_launch_pitch", abs(360 - var_2[0]));
    wait 0.05;
  }
}

func_AB8A(var_00, var_01, var_02) {
  var_03 = getomnvar(var_00);
  level notify(var_00 + "_lerp_savedDvar");
  level endon(var_00 + "_lerp_savedDvar");
  var_04 = var_01 - var_03;
  var_05 = 0.05;
  var_06 = int(var_02 / var_05);

  for(var_07 = var_04 / var_06; var_06; var_6--) {
    var_03 = var_03 + var_07;
    setomnvar(var_00, var_03);
    wait(var_05);
  }

  setomnvar(var_00, var_01);
}

func_5F9A(var_00) {
  level.func_1CB9 thread func_5F9B(var_00);
  level.func_EA99 thread func_5F9B(var_00);
  level.func_12B67 thread func_5F9B(var_00);
  level.func_12B7D thread func_5F9B(var_00);
  level.func_D2A1 thread func_5F9B(var_00);
  level.func_AA61 thread func_5F9B(var_00);
  level.func_AA62 thread func_5F9B(var_00);
  level.func_AA63 thread func_5F9B(var_00);
}

func_5F9B(var_00) {
  var_01 = getanimlength(level.func_EC85[self.func_1FBB]["space_launch"]);
  var_02 = var_00 / var_01;
  self _meth_82B0(level.func_EC85[self.func_1FBB]["space_launch"], var_02);
}

func_D2F6() {
  var_00 = (0, 0, -80);
  var_01 = anglesToForward(level.func_D127.angles) * 350;
  var_02 = level.func_D127.origin + var_00 + var_01;
  var_03 = vectortoangles((0, 0, 1));
  var_04 = 75;
  var_05 = 0;

  while(var_05 < var_04) {
    playFX(level.vehicle.func_116CE.func_112D9[level.func_D127.classname]["concrete_dry"], var_02, anglesToForward(var_03), anglestoup(var_03));
    var_5++;
    wait 0.05;
  }
}

func_CFDF(var_00, var_01, var_02, var_03) {
  var_04 = 160;
  var_05 = 160;
  var_06 = 4500;
  var_07 = 10000;
  var_08 = 0.03;
  var_09 = 0.14;
  var_10 = 0.17;
  var_11 = 0.13;
  var_12 = 0.03;
  var_13 = 0.985;
  var_14 = 0.95;
  var_15 = 2800;
  var_16 = -1500;
  var_17 = -3800;
  var_18 = 3800;
  var_19 = level.player getsplashtablename();
  var_19 = var_19 * var_03;
  self.func_11535 = self.func_11535 + var_19[0] * var_04;
  self.func_11533 = self.func_11533 + var_19[1] * var_05;

  if(self.func_11535 > var_15)
    self.func_11535 = var_15;
  else if(self.func_11535 < var_16)
    self.func_11535 = var_16;

  if(self.func_11533 < var_17)
    self.func_11533 = var_17;
  else if(self.func_11533 > var_18)
    self.func_11533 = var_18;

  self.func_11535 = self.func_11535 * var_13;
  self.func_11533 = self.func_11533 * var_13;
  var_20 = self.func_11535 * var_02 + self.func_11533 * var_01;
  self.func_BC49 = scripts\sp\math::func_AB6F(self.func_BC49, var_20, var_08);
  self.func_AFF8 = scripts\sp\math::func_AB6F(self.func_BC49, var_20, var_09);
  self.func_1D11 = scripts\sp\math::func_AB6F(self.func_1D11, self.func_BC49, var_12);
  var_21 = (self.func_AFF8[1] - self.func_BC49[1]) * var_11;
  self.func_E67D = scripts\sp\math::func_AB6F(self.func_E67D, var_21, var_10);
  self.func_E67D = self.func_E67D * var_14;
}

func_D2D8() {
  thread func_0BDC::func_A2B0( % jackal_pilot_launch_button, % jackal_vehicle_launch_button, 1.1, 0.5);
  wait 2.1;
  earthquake(0.25, 0.75, level.func_D127.origin, 5000);
  level.player playrumbleonentity("damage_light");
  thread func_104EB();
  level.func_D127 notify("notify_player_can_launch");
}

func_CF9A(var_00) {
  if(var_00 != level.func_D2A1) {
    return;
  }
  var_01 = 1.9;
  wait(var_01);
  func_0BDC::func_A14C(0);
  level notify("player_booster_drop");
  thread func_CAE1();
  level.func_D127 playSound("jackal_booster_detach_plr");
  level.func_D127 playSound("phspace_launch_space_creak");
  level.player stopsounds();
  level.player scripts\engine\utility::delaycall(5, ::clearsoundsubmix);
  func_0BDC::func_A0BE(0);
  func_0BDC::func_A1DD("hover");
  func_0BDC::func_A38E(undefined, undefined, undefined, 0.5);
  scripts\engine\utility::flag_set("flag_player_boosters_disengaged");
  wait 0.1;
  earthquake(0.32, 1.25, level.func_D127.origin, 1000000);
}

func_CAE1() {
  scripts\engine\utility::delaythread(0.214, scripts\sp\utility::func_1034D, "phspace_plr_breathtighten");
  scripts\engine\utility::delaythread(5.516, scripts\sp\utility::func_10350, "phspace_gtr_vector10hours16");
  level.player scripts\engine\utility::delaycall(9.874, ::playsound, "quindar_02");
}

func_CF51(var_00) {
  if(var_00 != level.func_D2A1) {
    return;
  }
  wait 2.0;
  level notify("player_allow_teleport");
}

func_D352() {
  func_0BDC::func_A2B0( % jackal_pilot_weapon_button, % jackal_vehicle_weapon_button);
  func_0BDC::func_A153(0);
}

func_D27B() {
  level endon("player_booster_drop");
  earthquake(0.48, 1.5, level.func_D127.origin, 5000);
  level.func_AA94 = 0.16;
  wait 0.75;

  for(;;) {
    var_00 = randomfloatrange(0.1, 0.15);
    var_01 = randomfloatrange(level.func_AA94, level.func_AA94 + 0.02);
    earthquake(var_01, var_00, level.func_D127.origin, 5000);
    wait(var_00 * 0.4);
  }
}

func_D27C(var_00, var_01) {
  level notify("new_screenshake");
  level endon("new_screenshake");
  var_02 = level.func_AA94;
  var_03 = var_00 - var_02;
  var_04 = var_03 * (1 / (var_01 + 0.05) * 0.05);

  while(var_01 > 0) {
    var_01 = var_01 - 0.05;
    var_02 = var_02 + var_04;
    level.func_AA94 = var_02;
    wait 0.05;
  }

  level.func_AA94 = var_00;
}

func_424D(var_00) {
  var_01 = getanimlength(level.func_EC85["sled_jackal"]["space_launch"]);

  if(getdvarint("E3", 0) && !getdvarint("e3_negus", 0))
    var_01 = var_01 - 6;

  wait(var_01);
  var_02 = scripts\engine\utility::getstruct("jackal_launch_animnode_clone", "targetname");
  var_02 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  var_02 scripts\sp\anim::func_1F35(level.func_D299, "space_launch_boost");
}

func_CADE() {
  wait 0.1;
  thread func_11442();
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(14);
  thread scripts\sp\utility::func_10350("phspace_slt_lookwhatthey");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(16.767);
  thread scripts\sp\utility::func_1034D("phspace_plr_letsgogetem");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(18.45);
  level.player playSound("quindar_01");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(18.719);
  thread scripts\sp\utility::func_10350("phspace_gtr_toallavailablecraft");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(24.63);
  level.player playSound("quindar_02");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(25.069);
  thread scripts\sp\utility::func_10350("phspace_slt_onetwocopylets");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(27.746);
  thread scripts\sp\utility::func_10350("phspace_ecl_retributionthisisthe");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(31.534);
  level.player playSound("quindar_02");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(31.982);
  thread scripts\sp\utility::func_1034D("phspace_plr_scarsfoldinwere");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(35.291);
  level.player playSound("quindar_01");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(35.032);
  thread scripts\sp\utility::func_10350("phspace_gtr_pitching90for");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(37.933);
  level.player playSound("quindar_02");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(38.807);
  thread scripts\sp\utility::func_1034D("phspace_plr_goflight");
}

func_11442() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(9.967);
  _setmusicstate("geneva_jackal_takeoff");
}

func_408A() {
  var_00 = scripts\sp\utility::func_77DA("jackals_hvr_marines");

  foreach(var_02 in var_00)
  var_02 delete();

  if(isDefined(level.func_11323)) {
    level.func_11323 delete();
    level.func_11324 delete();
    level.func_11321 delete();
    level.func_11322 delete();
  }
}

func_AA9D() {
  level.func_12B67 thread func_1186C();
  level.func_12B7D thread func_1186D();
  level.func_AA61 thread func_1186B();
  level.func_AA62 thread func_1186B();
  level.func_AA63 thread func_1186B();
  var_00 = level.func_39DD["cannon_large_un"].func_10241;
  var_0.func_6D20 = 1;
  var_0.func_13536 = [1, 1];
  var_0.func_13535 = [5.1, 5.2];
  var_00 = level.func_39DD["missile_tube_un"].func_10241;
  var_0.func_B46E = 5;
  level notify("stop_hill_vista_skyambient");
  thread func_104F9();
  thread func_104F5();
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(10);
  scripts\engine\utility::exploder("vfx_ph_launch_smk_plume_ca1");
  scripts\engine\utility::exploder("vfx_ph_launch_smk_plume_ca2");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(13);
  level.func_12B7D scripts\engine\utility::delaycall(0.1, ::playsound, "scn_phspace_tigris_passby");
  level.func_AA61 thread func_0BB6::func_3966(1, 0, level.func_12B7D);
  level.func_AA62 thread func_0BB6::func_3966(1, 0, level.func_12B67);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(15);
  level.func_12B7D thread func_0BB6::func_3983(level.func_AA61);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(16);
  level.func_12B7D thread func_0BB6::func_3966(1, 0, level.func_AA61);
  level.func_12B67 thread func_0BB6::func_3966(1, 0, level.func_AA62);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(19);
  level.func_AA61 thread func_0BB6::func_3983(level.func_12B7D);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(20);
  level.func_12B7D thread func_0BB6::func_3983(level.func_AA62);
  level.func_12B67 scripts\engine\utility::delaycall(0.1, ::playsound, "scn_phspace_retribution_passby");
  level.player scripts\engine\utility::delaycall(7.0, ::playsound, "scn_phspace_launch_jackals_in");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(22);
  level.func_12B7D thread func_0BB6::func_3966(1, 0, level.func_AA62);
  level.func_AA62 thread func_0BB6::func_3983(level.func_12B67);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(24);
  level.func_12B7D thread func_0BB6::func_3983(level.func_AA62);
  level.func_AA61 thread func_0BB6::func_3967();
  level.func_AA62 thread func_0BB6::func_3967();
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(29);
  level.func_12B7D thread func_0BB6::func_3983(level.func_AA62);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(33);
  level.func_12B7D thread func_0BB6::func_3967();
  level.func_12B67 thread func_0BB6::func_3967();
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(45);
  level notify("stop_hill_vista_skyambient");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(51);
  level.func_AA61 func_0BA9::func_397B();
  level.func_AA62 func_0BA9::func_397B();
  level.func_AA63 func_0BA9::func_397B();
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(77);
}

func_1186C() {
  wait 0.1;
  func_0BB8::func_39CD("heavy");
  wait 0.1;
  func_0BB8::func_39D0("heavy");
}

func_1186D() {
  func_0BB8::func_39CD("heavy");
  wait 0.1;
  func_0BB8::func_39D0("heavy");
}

func_1186B() {
  scripts\sp\vehicle::playgestureviewmodel();
  self notsolid();
  func_0BB8::func_39D0("heavy");
  wait 0.1;
  func_0BB8::func_39CD("launch");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(10);
  thread scripts\sp\utility::func_75C4("vfx_flare_capship_launch_enemy_hero", "fx_engine_l_1");
  thread scripts\sp\utility::func_75C4("vfx_flare_capship_launch_enemy_hero", "fx_engine_l_2");
}

func_D2A6(var_00, var_01) {
  var_02 = getent(var_00, "targetname");
  var_03 = scripts\sp\vehicle::func_13237(var_02);
  var_3.func_4074 = [];

  if(isDefined(var_01) && var_01) {
    var_3.func_AFEB = scripts\engine\utility::spawn_tag_origin();
    var_3.func_AFEB.origin = var_3.origin + anglesToForward(var_3.angles) * 2500;
    var_3.func_AFEB linkto(var_03);
    var_3.func_BD0D = scripts\engine\utility::spawn_tag_origin();
    var_3.func_BD0D linkto(var_03, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_3.func_B025 = scripts\engine\utility::spawn_tag_origin();
    var_3.func_B025 linkto(var_3.func_AFEB, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_3.func_4074 = scripts\engine\utility::array_add(var_3.func_4074, var_3.func_AFEB);
    var_3.func_4074 = scripts\engine\utility::array_add(var_3.func_4074, var_3.func_BD0D);
    var_3.func_4074 = scripts\engine\utility::array_add(var_3.func_4074, var_3.func_B025);
  }

  var_03 setvehicleteam("allies");
  var_03 notsolid();
  var_03 thread func_0BDC::func_D29D();
  return var_03;
}

func_104F9() {
  level.func_1028D show();
  var_00 = getent("trigger_show_upper_skybox_blend", "targetname");
  var_00 func_0BDC::func_136A6(level.func_D127);
  level.func_1028B show();
  level.func_1028D hide();
}

func_104F5() {
  var_00 = getent("trigger_local_cloudfx_thick", "targetname");
  var_00 func_0BDC::func_136A6(level.func_D127);
  func_104F7("vfx_ph_launch_player_local_clouds_thick");
  var_00 = getent("trigger_local_cloudfx_thin", "targetname");
  var_00 func_0BDC::func_136A6(level.func_D127);
  func_104F7("vfx_ph_launch_player_local_clouds_thin", "vfx_ph_launch_player_local_clouds_thick");
}

func_AA74(var_00) {
  func_0BB8::func_39CD("burst");
  wait(var_00);
  func_0BB8::func_39CD("launch");
}

func_104F7(var_00, var_01) {
  if(isDefined(var_00))
    playFXOnTag(scripts\engine\utility::getfx(var_00), level.func_D127, "j_mainroot_ship");

  if(isDefined(var_01))
    stopFXOnTag(scripts\engine\utility::getfx(var_01), level.func_D127, "j_mainroot_ship");
}

func_104FC() {
  var_00 = getent("trigger_local_cloudfx_thick", "targetname");
  var_00 func_0BDC::func_136A6(level.func_D127);
  var_01 = scripts\engine\utility::getstruct("clouds_mid_fx_struct", "targetname");
  var_02 = scripts\engine\utility::spawn_tag_origin(var_1.origin);
  wait 0.05;
  playFXOnTag(scripts\engine\utility::getfx("vfx_ph_launch_clouds_scattered_mid_02"), var_02, "tag_origin");
  level waittill("player_booster_drop");
  wait 3;
  _killfxontag(scripts\engine\utility::getfx("vfx_ph_launch_clouds_scattered_mid_02"), var_02, "tag_origin");
  var_02 delete();
}

space_launch_bounce_light() {
  level.space_launch_bounce_light = scripts\engine\utility::spawn_tag_origin();
  level.space_launch_bounce_light.color = (0, 0, 0);
  level.space_launch_bounce_light thread space_launch_bounce_light_origin();
  var_00 = getent("trigger_sunfx_fadeout", "targetname");
  var_00 func_0BDC::func_136A6(level.func_D127);
  playFXOnTag(scripts\engine\utility::getfx("launch_sky_bounce_light"), level.space_launch_bounce_light, "tag_origin");
  level.space_launch_bounce_light.color = (1, 0, 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(70);
  level.space_launch_bounce_light.color = (0, 1, 0);
  _killfxontag(scripts\engine\utility::getfx("launch_sky_bounce_light"), level.space_launch_bounce_light, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("launch_sky_bounce_light_fade"), level.space_launch_bounce_light, "tag_origin");
  wait 6;
  level.space_launch_bounce_light delete();
}

space_launch_bounce_light_origin() {
  self endon("death");

  for(;;) {
    var_00 = level.func_12B7D space_launch_get_offset_from_ship();
    var_01 = level.func_12B67 space_launch_get_offset_from_ship();
    self.origin = (var_00 + var_01) * 0.5;
    self.angles = level.func_12B7D.angles;
    wait 0.05;
  }
}

space_launch_get_offset_from_ship() {
  return self.origin + anglesToForward(self.angles) * 3000 + anglestoup(self.angles) * 6000 + anglestoright(self.angles) * -1000;
}

func_104EA(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = 0;

  var_03 = getent("trigger_local_cloudfx_thick", "targetname");
  var_03 func_0BDC::func_136A6(self);

  foreach(var_05 in var_00)
  scripts\sp\utility::func_75C4(var_01, var_05, var_02);
}

func_104E9() {
  var_00 = scripts\engine\utility::getstruct("cloudbank_fx_struct", "targetname");
  var_01 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  scripts\engine\utility::waitframe();
  level waittill("space_launch_cleanup");
  scripts\sp\utility::func_10FEC("ground_fx");
  var_01 delete();
}

func_104F3() {
  var_00 = level.func_111D0.func_42D2;
  var_01 = 14;
  var_02 = (1, 1, 1);
  var_03 = 5;
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(var_00, var_03);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C46(var_02, var_01, var_03);
  var_00 = level.func_111D0.func_42D3;
  var_03 = 25;
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(var_00, var_03);
  playFXOnTag(scripts\engine\utility::getfx("vfx_sunflare"), level.func_111D0, "tag_origin");
  wait 9;
  var_00 = level.func_111D0.func_E485;
  var_02 = level.func_111D0.func_E487;
  var_01 = level.func_111D0.func_E486;
  var_03 = 12;
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C46(var_02, var_01, var_03);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(var_00, var_03);
}

func_104F8() {
  var_00 = getent("trigger_sunfx_fadeout", "targetname");
  var_00 func_0BDC::func_136A6(level.func_D127);
  wait 5;
  thread func_D27C(0.22, 5);
  var_00 = getent("trigger_sunfx_fadein", "targetname");
  var_00 func_0BDC::func_136A6(level.func_D127);
  thread func_D27C(0.17, 3);
  wait 8;
  thread func_D27C(0.24, 14);
}

func_104E6() {
  var_00 = getent("trigger_sunfx_fadeout", "targetname");
  var_00 func_0BDC::func_136A6(level.func_D127);
  wait 3;
  level.func_D127 thread scripts\sp\utility::func_75C4("vfx_ph_jackal_canopy_drops", "j_mainroot_ship");
}

func_104FB() {
  var_00 = getent("trigger_sunfx_fadeout", "targetname");
  var_00 func_0BDC::func_136A6(level.func_D127);
  _killfxontag(scripts\engine\utility::getfx("vfx_sunflare"), level.func_111D0, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_sunflare_fadeout"), level.func_111D0, "tag_origin");
  var_00 = getent("trigger_sunfx_fadein", "targetname");
  var_00 func_0BDC::func_136A6(level.func_D127);
  _killfxontag(scripts\engine\utility::getfx("vfx_sunflare_fadeout"), level.func_111D0, "tag_origin");
  wait 0.5;
}

func_104F4() {
  func_0BDC::func_137CF();
  wait 1.5;

  while(!isDefined(level.func_AA61))
    wait 0.05;

  level.func_AA61 _meth_8064();
  level.func_AA62 _meth_8064();
  level.func_AA63 _meth_8064();
  level.func_12B67 _meth_8064();
  level.func_12B7D _meth_8064();
}

func_1050B() {
  _setsaveddvar("r_transShadowEnable", 1);
  _setsaveddvar("r_heightfieldSunShadow", 0);
  _setsaveddvar("sm_sunSampleSizeNear", 10.3);
  _setsaveddvar("sm_sunCascadeSizeMultiplier2", 3);
}

func_CADD() {
  thread func_CAE2();
  level.player playSound("phspace_launch_plr");
  wait 0.5;
  level.player setsoundsubmix("scn_jackal_plr");
  wait 25;
  setglobalsoundcontext("atmosphere", "space", 4);
  wait 1;
  level.player clearclienttriggeraudiozone(0);
  level.player _meth_82C0("jackal_cockpit", 4);
}

func_CAE2() {
  scripts\engine\utility::delaythread(2.824, scripts\sp\utility::func_1034D, "phspace_plr_oneonegoodthrottle");
  level.player scripts\engine\utility::delaycall(8.619, ::playsound, "quindar_01");
  level.player scripts\engine\utility::delaycall(16.854, ::playsound, "quindar_02");
  level.player scripts\engine\utility::delaycall(22.555, ::playsound, "quindar_01");
  level.player scripts\engine\utility::delaycall(32.726, ::playsound, "quindar_02");
  scripts\engine\utility::delaythread(5.323, scripts\sp\utility::func_10350, "phspace_slt_onetwogoodthrottle");
  scripts\engine\utility::delaythread(10.021, scripts\sp\utility::func_10350, "phspace_gtr_nominalgains");
  scripts\engine\utility::delaythread(14.903, scripts\sp\utility::func_10350, "phspace_gtr_goingthru21000");
  scripts\engine\utility::delaythread(29.3, scripts\sp\utility::func_10350, "phspace_gtr_atmosdragaccept");
}

func_104E7() {
  thread func_104E8();
}

func_104E8() {
  level notify("space_launch_cleanup");
}

func_E317(var_00) {
  var_01 = ["tag_engine_rear_l_out_01_launch", "tag_engine_rear_l_out_02_launch", "tag_engine_rear_l_out_03_launch", "tag_engine_rear_l_out_04_launch", "tag_engine_rear_r_out_01_launch", "tag_engine_rear_r_out_02_launch", "tag_engine_rear_r_out_03_launch", "tag_engine_rear_r_out_04_launch"];

  if(var_00)
    var_02 = scripts\sp\utility::func_75C4;
  else
    var_02 = scripts\sp\utility::func_75F8;

  foreach(var_04 in var_01)
  self[[var_02]]("retribution_thrust_rear_launch", var_04);
}

func_118B9(var_00) {
  var_01 = ["fx_engine_l_1", "fx_engine_l_4"];

  if(var_00)
    var_02 = scripts\sp\utility::func_75C4;
  else
    var_02 = scripts\sp\utility::func_75F8;

  foreach(var_04 in var_01)
  self[[var_02]]("un_thruster_rear_lrg_launch", var_04);
}