/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phspace\phspace_mons.gsc
****************************************************/

func_CAE0() {
  scripts\engine\utility::flag_init("olympus_arrived");
  scripts\engine\utility::flag_init("olympus_arriving");
  scripts\engine\utility::flag_init("olympus_almost_arrived");
  scripts\engine\utility::flag_init("mons_intro_setup_complete");
  scripts\engine\utility::flag_init("mons_intro_complete");
  scripts\engine\utility::flag_init("ram_impact");
  scripts\engine\utility::flag_init("mons_ftl_out");
  scripts\engine\utility::flag_init("started_preload");
  scripts\engine\utility::flag_init("ret_swapped");
  scripts\engine\utility::flag_init("space_battle_complete");
}

func_BAB2() {
  scripts\sp\maps\phspace\phspace::func_107C0();
  scripts\sp\maps\phspace\phspace::func_1062E();
  level.func_EA99 func_0BDC::func_6B4C("space", 0);
  level.func_1CB9 func_0BDC::func_6B4C("space", 0);
  level.func_EA99.ignoreme = 1;
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_F5A4();
  var_00 = scripts\sp\vehicle::func_1080C("player_jackal");
  var_01 = scripts\engine\utility::getstruct("mons_intro_start", "targetname");
  func_0BDC::func_10CD1(var_00, var_01);
  wait 0.05;
  thread scripts\sp\maps\phspace\phspace_battle::func_D868();
  thread scripts\sp\maps\phspace\phspace_battle::func_12B5F();
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\maps\phspace\phspace_battle::func_FE2F();
  level.func_EA99 vehicle_teleport(var_1.origin + -5000 * anglesToForward(level.func_D127.angles), var_1.angles);
  thread scripts\sp\maps\phspace\phspace_battle::func_12B7B(1);
  wait 1.0;
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.func_111D0.func_1022B, 0.2);
}

func_6EB8(var_00) {
  self endon("stop_outline_flash");

  for(;;) {
    wait 0.75;
    self hudoutlinedisable();
    wait 0.5;
  }
}

func_BAAC() {
  scripts\engine\utility::flag_wait("prespawn_done");
  thread func_54FC();
  thread func_BAA3();
  func_1F90();
  func_A830();
  scripts\sp\utility::func_266A("mons_intro");
  func_96EC();
  level.func_12B67 func_0BB6::func_39E1();
  var_00 = getent("ca_olympus", "targetname");
  var_0.func_EEF9 = "none";
  level.func_3670 = scripts\sp\vehicle::func_1080C("ca_olympus");
  level.func_3670 thread func_F051();
  level.func_3670 hide();
  wait 0.05;
  level.func_3670 func_0BB8::func_7491();
  scripts\engine\utility::delaythread(5, ::func_A7F7);
  func_CF82();
  scripts\engine\utility::flag_set("olympus_arriving");
  _setmusicstate("mx_291_mons_coming");
  level.player playSound("scn_phspace_mons_arrive");
  level.func_3670 thread func_0BB8::func_398C("idle", "idle", "high");
  level.func_3670 thread mons_ftl_in_show_delayed();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.func_111D0.func_BA9E, 0.2);
  scripts\engine\utility::flag_set("olympus_arrived");
  scripts\sp\utility::func_10FEC("returnret");
  level.func_FD6E.func_E35D thread func_0BDB::func_A2F1();
  thread func_BA82();
  thread func_AB88();
  func_1F8F();
  thread func_BA9F(0);
  thread func_513D();
}

mons_ftl_in_show_delayed() {
  wait 0.2;
  level.func_3670 notify("show_warp_core");
  level.func_3670.cannon show();

  foreach(var_01 in self.func_8B4F) {
    foreach(var_03 in var_01) {
      if(isDefined(var_03))
        var_03 show();
    }
  }

  func_0BB8::func_39C8();
}

func_513D() {
  if(!isDefined(level.func_12B4C)) {
    return;
  }
  while(func_0B76::func_7A60(level.func_12B4C.origin) > 0.0)
    wait 0.5;

  level.func_12B4C func_0BA9::func_397B();
}

func_D083() {
  _setsaveddvar("spaceshipForceSetFovBlendStrength", 10);
  _setsaveddvar("spaceshipForceSetFov", 95);
  wait 0.5;
  _setsaveddvar("spaceshipForceSetFovBlendStrength", 0.6);
  _setsaveddvar("spaceshipForceSetFov", 50);
  wait 4;
  _setsaveddvar("spaceshipForceSetFovBlendStrength", 0.1);
  _setsaveddvar("spaceshipForceSetFov", 69);
  wait 15;
  _setsaveddvar("spaceshipForceSetFov", 0);
}

func_CF49() {
  level endon("return_ads_fov_normal");
  var_00 = 0;

  for(;;) {
    if(level.player adsbuttonpressed() && !var_00) {
      _setsaveddvar("spaceshipForceSetFovBlendStrength", 4);
      _setsaveddvar("spaceshipForceSetFov", 42);
      var_00 = 1;
    }

    if(!level.player adsbuttonpressed() && var_00) {
      _setsaveddvar("spaceshipForceSetFov", 0);
      var_00 = 0;
    }

    wait 0.05;
  }
}

func_CF48() {
  level notify("return_ads_fov_normal");
  level.player allowads(0);
  _setsaveddvar("spaceshipForceSetFov", 0);
  wait 0.2;
  level.player allowads(1);
}

func_AB88() {
  var_00 = 999999;
  level.func_FD6E.func_E35D linkto(level.func_12B67.func_BCDA);
  var_01 = 5;
  var_02 = 0.12;

  while(var_01 > 0) {
    level.func_FD6E.func_E35D unlink();
    var_03 = level.func_12B67.func_BCDA gettagorigin("j_mainroot");
    var_04 = level.func_12B67.func_BCDA gettagangles("j_mainroot");
    var_05 = anglesToForward(level.func_FD6E.func_E35D.angles);
    var_06 = anglestoright(level.func_FD6E.func_E35D.angles);
    var_07 = anglestoup(level.func_FD6E.func_E35D.angles);
    level.func_FD6E.func_E35D.origin = scripts\sp\math::func_AB6F(level.func_FD6E.func_E35D.origin, var_03, var_02);
    var_05 = scripts\sp\math::func_AB6F(var_05, anglesToForward(var_04), var_02);
    var_06 = scripts\sp\math::func_AB6F(var_06, anglestoright(var_04), var_02);
    var_07 = scripts\sp\math::func_AB6F(var_07, anglestoup(var_04), var_02);
    level.func_FD6E.func_E35D.angles = _axistoangles(var_05, var_06, var_07);
    level.func_FD6E.func_E35D linkto(level.func_12B67.func_BCDA, "j_mainroot");
    var_01 = var_01 - 0.05;
    wait 0.05;
  }

  level.func_FD6E.func_E35D linkto(level.func_12B67.func_BCDA, "j_mainroot", (0, 0, 0), (0, 0, 0));
}

func_A828() {
  scripts\engine\utility::flag_set("jackal_landing_never_launch_drone");
  level.func_FD6E.func_E35D unlink();
  level.func_FD6E.func_E35D.func_E708 = 0.3;
  level.func_FD6E.func_E35D.func_EBA9 = 0.5;
  level.func_FD6E.func_E35D.func_B455 = 145;
  level.func_FD6E.func_E35D.func_B74F = 130;
  level.func_FD6E.func_E35D scripts\engine\utility::delaythread(0.2, func_0BDB::func_A2F2);
}

func_A829() {
  scripts\engine\utility::flag_clear("jackal_landing_never_launch_drone");
  level.func_FD6E.func_E35D unlink();
  level.func_FD6E.func_E35D.func_E708 = undefined;
  level.func_FD6E.func_E35D.func_EBA9 = undefined;
  level.func_FD6E.func_E35D.func_B455 = undefined;
  level.func_FD6E.func_E35D.func_B74F = undefined;
  level.func_12B67 linkto(level.func_FD6E.func_E35D);
  level.func_FD6E.func_E35D scripts\engine\utility::delaythread(0.2, func_0B51::func_E3C6, 1, 0);
}

func_CF82() {
  wait 0.2;
  func_A828();
  level.func_12B67 linkto(level.func_FD6E.func_E35D);

  for(;;) {
    var_00 = level.func_FD6E.func_E35D.func_E8AD;
    var_01 = level.func_D127.origin - var_0.origin;
    var_02 = rotatevectorinverted(var_01, var_0.angles);
    var_03 = var_2[0];
    var_04 = pointonsegmentnearesttopoint(var_0.origin, var_0.origin + anglesToForward(var_0.angles) * 6000, level.func_D127.origin);
    var_05 = distance(level.func_D127.origin, var_04);

    if(var_03 < 21000 && scripts\engine\utility::flag("jackal_landing_active") && !scripts\engine\utility::flag("olympus_almost_arrived"))
      scripts\engine\utility::flag_set("olympus_almost_arrived");

    if(var_03 < 9000 && var_05 < 1000 && scripts\engine\utility::flag("jackal_landing_active")) {
      break;
    }
    wait 0.05;
  }
}

func_1F90() {
  while(!isDefined(level.func_12B55))
    wait 0.05;

  if(scripts\engine\utility::flag("mons_intro_setup_complete")) {
    return;
  }
  level.func_12703 = [];
  level.func_3672 = spawn("script_model", (0, 0, 0));
  level.func_3672 setModel("veh_mil_air_ca_olympus_mons_bridge_piece");
  level.func_3672 notsolid();
  level.func_3672 hide();
  var_00 = scripts\engine\utility::getstruct("trenchrun_anim_node", "targetname");
  level.func_1F8E = var_00 scripts\engine\utility::spawn_tag_origin();
  level.func_1F8E.angles = var_0.angles;
  level.func_EAA5 = func_10712("trenchrun_salter");
  level.func_D16B = func_10712("trenchrun_player");
  level.func_3671 = func_10712("trenchrun_mons");
  level.func_EA46 = func_10712("trenchrun_salter_bullet_target");
  level.func_EAC0 = func_10712("trenchrun_salter_missile_target");
  level.func_DC56 = func_10712("trenchrun_ram_vfx");
  level.func_3672.func_BCDA = func_10712("trenchrun_mons_tower");
  level.func_12B67.func_BCDA = func_10712("trenchrun_ret");
  level.func_12B7D.func_BCDA = func_10712("trenchrun_tigris");
  level.func_12B50.func_BCDA = func_10712("trenchrun_convoy_00");
  level.func_12B51.func_BCDA = func_10712("trenchrun_convoy_01");
  level.func_12B53.func_BCDA = func_10712("trenchrun_convoy_02");
  level.func_12B54.func_BCDA = func_10712("trenchrun_convoy_03");
  level.func_12B55.func_BCDA = func_10712("trenchrun_convoy_04");
  level.func_12B56.func_BCDA = func_10712("trenchrun_convoy_05");
  level.func_D16B.func_11512 = scripts\engine\utility::spawn_tag_origin();
  level.func_D16B.func_11512 linkto(level.func_D16B, "j_mainroot", (0, 0, 0), (0, 0, 0));
  level.func_12704 = [level.func_EAA5, level.func_D16B, level.func_3671, level.func_EA46, level.func_EAC0, level.func_DC56, level.func_12B67.func_BCDA, level.func_12B7D.func_BCDA, level.func_12B50.func_BCDA, level.func_12B51.func_BCDA, level.func_12B53.func_BCDA, level.func_12B54.func_BCDA, level.func_12B55.func_BCDA, level.func_12B56.func_BCDA, level.func_3672.func_BCDA];
  var_01 = [level.func_12B67, level.func_12B7D, level.func_12B50, level.func_12B51, level.func_12B53, level.func_12B54, level.func_12B55, level.func_12B56, level.func_3672];

  foreach(var_03 in level.func_12704) {
    var_03 linkto(level.func_1F8E);
    level.func_1F8E func_1EC5(var_03);
  }

  foreach(var_06 in var_01)
  var_06 func_BAA0();

  scripts\engine\utility::flag_set("mons_intro_setup_complete");
}

func_F5D4(var_00) {
  level.func_12703 = scripts\engine\utility::array_add(level.func_12703, self);
  self give_attacker_kill_rewards(self.func_AEBB);
  self _meth_82B0(self.func_AEBB, var_00);
}

func_1F8F() {
  level.func_1F5B = 0.9;
  thread func_126FD();
  thread func_12702();
  level.func_D299 thread func_0BDC::func_D29B(1, 3);
  level.func_3670 linkto(level.func_3671, "tag_origin", (0, 0, 0), (0, 0, 0));
  func_F587();
  var_00 = level.func_D16B islegacyagent(level.func_EC85["generic_mover"][level.func_D16B.func_1FAF]);
  level.func_3670.cannon func_F5D4(var_00);
  level.func_3670 func_F5D4(var_00);

  foreach(var_02 in level.func_12704)
  var_02 _meth_82B1(level.func_EC85["generic_mover"][var_2.func_1FAF], 1 * level.func_1F5B);

  foreach(var_05 in level.func_12703)
  var_05 _meth_82B1(var_5.func_AEBB, 1 * level.func_1F5B);

  thread func_1F92();
}

func_1F98(var_00) {
  var_01 = getnotetracktimes(level.func_EC85["generic_mover"][level.func_D16B.func_1FAF], var_00);

  foreach(var_03 in level.func_12704)
  var_03 _meth_82B0(level.func_EC85["generic_mover"][var_3.func_1FAF], var_1[0]);
}

func_5B45(var_00) {
  thread func_0BDC::func_ACE8(var_00);

  for(;;)
    wait 0.05;
}

func_1F92() {
  scripts\engine\utility::flag_init("flag_player_land");
  scripts\engine\utility::flag_init("retribution_ram");
  thread func_1F93();
  thread func_1F97();
  thread func_1F91();
  thread func_1F95();
  thread func_1F96();
  thread func_1F94();
  level.func_3670.func_24C2 = 90;
  func_137E2("kill_convoy02");
  level.func_12B53 thread func_0BB6::func_3983(level.func_3670);
  func_BAB7(level.func_12B53);
  var_00 = func_137E2("lookat_ethan");

  if(!var_00)
    thread func_D1DE();

  var_00 = func_137E2("kill_convoy00");
  level.func_12B51 thread func_0BB6::func_3983(level.func_3670);
  func_BAB7(level.func_12B50, 0.25);

  if(var_00)
    var_01 = 0.05;
  else
    var_01 = 40;

  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.func_111D0.func_DC4C, var_01);
  var_00 = func_137E2("salter_go");
  level.func_EA99 func_0BDC::func_6B4C("fly");
  level.func_12B51 scripts\engine\utility::delaythread(6, func_0BB6::func_3984, level.func_3670);
  level.func_12B51 scripts\engine\utility::delaythread(9.5, func_0BB6::func_3984, level.func_3670);
  func_137E2("kill_convoy01");
  level.func_12B7D scripts\engine\utility::delaythread(1, func_0BB6::func_3983, level.func_3670);
  level.func_12B51.func_4E09 = undefined;
  func_BAB7(level.func_12B51, 0.2, 1);
  level.func_3670 thread func_0BB6::func_39E5("front_right", level.func_12B53);
  level.func_3670 thread func_0BB6::func_399C("right_1", level.func_12B53);
  level.func_3670 thread func_0BB6::func_399C("right_2", level.func_12B53);
  func_137E2("scale_flares_for_trench");
  level.func_D127.func_6E93 = 0.12;
  level.func_D127.func_6E97 = 0.55;
  level.func_D127.func_6E8A = 1;
  func_137E2("flare_scale_normal");
  level.func_D127.func_6E93 = 0.29;
  level.func_D127.func_6E97 = 0.75;
  level.func_D127.func_6E8A = 0;

  if(var_00)
    var_01 = 0.05;
  else
    var_01 = 25;

  level.func_1F8E rotateto(level.func_1F8E.angles + (0, 25, 0), var_01, var_01 * 0.5, var_01 * 0.5);
  level.func_1F8E moveto(level.func_1F8E.origin + (-10000, -35000, 0), var_01, var_01 * 0.5, var_01 * 0.5);
  func_137E2("kill_convoy05");
  level.func_12B54 scripts\engine\utility::delaythread(11, func_0BB6::func_3983, level.func_3670);
  level.func_12B54 scripts\engine\utility::delaythread(17, func_0BB6::func_3983, level.func_3670);
  func_BAB7(level.func_12B56);
  level.func_3670 thread func_0BB6::func_39E5("front_left", level.func_12B53);
  level.func_3670 thread func_0BB6::func_39E5("front_right", level.func_12B54, level.func_12B55);
  level.func_3670 thread func_0BB6::func_39E5("back_right", level.func_12B54, level.func_12B55);
  func_137E2("kill_convoy03");
  func_BAB7(level.func_12B54);
  level.func_3670 thread func_0BB6::func_39E5("front_left", level.func_12B67);
  level.func_3670 thread func_0BB6::func_39E5("back_left", level.func_12B67);
  level.func_3670 thread func_0BB6::func_39E5("front_right", level.func_12B7D);
  level.func_3670 thread func_0BB6::func_39E5("back_right", level.func_12B7D);
  level.func_12B50 thread func_0BB6::func_39E1();
  level.func_12B53 thread func_0BB6::func_39E1();
  level.func_12B55 thread func_0BB6::func_39E1();
  func_137E2("ram_start");
  scripts\engine\utility::flag_set("retribution_ram");
  func_A830();
  func_137E2("kill_convoy04");
  level.func_12B55.func_4E09 = undefined;
  level.func_12B55 scripts\engine\utility::delaycall(3, ::_meth_81D0);
  level.func_3670 thread func_0BB6::func_3966(1, 1, level.func_12B67);
  level.func_3670 func_BAF7();
  level.func_12B67 thread func_0BB6::func_3966(1, 1, level.func_3670);
  func_137E2("ret_ram");
  thread func_DC50();
  level.func_3670 func_0BB6::func_3967();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.func_111D0.mons_warp_angles, 10);
  func_137E2("boost_start");
  func_0BDC::func_A0BE(1);
  func_0BDC::func_A38E(5, 5, 5, 3);
  func_137E2("swap_mons_geo");
  func_11311();
  func_137E2("boost_end");
  func_0BDC::func_A0BE(0);
  func_137E2("salter_hover");
  level.func_EA99 func_0BDC::func_6B4C("hover");

  if(isDefined(level.func_D127.func_58B6)) {
    level.func_D127.func_58B6 ghostattack(0, 1);
    level.player clearsoundsubmix();
    level.func_D127.func_58B6 scripts\engine\utility::delaycall(1, ::stoploopsound, "jackal_plr_locked_lp");
  }

  thread func_104D0();
  thread func_A807();
  func_137E2("player_stopped");
  thread func_CF49();
  level.func_12B7D thread func_FA63();
  func_D30F();
  func_137E2("tigris_missiles");

  if(scripts\engine\utility::is_true(level.func_3670.func_7479))
    _killfxontag(level._effect["vfx_vehicle_mons_warp_out_ftldrive_core"], level.func_3670, "TAG_ORIGIN");

  thread func_DC4B();
  func_137E2("mons_ftl");
  level.func_3670 func_0BB8::func_3991();
  level.func_3670 func_0BB6::func_39E1();
  level.func_3670.cannon delete();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.func_111D0.func_A7D8, 10);
  level.func_12B67 func_0BB6::func_39F1();
  level.func_12B67 func_0BB6::func_3967();
  level notify("mons_ftl_out");
  thread func_CF48();
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.3, 1.3, level.func_D127.origin, 20000);
  _setmusicstate("");
  _killfxontag(scripts\engine\utility::getfx("mons_damage_linger"), level.func_3670.func_4CF6, "tag_origin");
  func_D25B();
  func_137E2("player_land");
  scripts\engine\utility::flag_set("flag_player_land");
  level.func_3670.func_4CF6 delete();
  level.func_D127.func_6E93 = 1.0;
  level.func_D127.func_6E97 = 1.0;
}

func_D30F() {
  level.func_D299 func_0BDC::func_D29B(0, 4);
  func_0BDC::func_A302(0.35);
  func_0BDC::func_D16C(level.func_D299.func_BCDA, 0.25, 0.4, 0);
  func_0BDC::func_D190(1);
  func_0BDC::func_A14A();
  func_0BDC::func_A155();
}

func_D25B() {
  var_00 = 2;
  func_0BDC::func_D164(level.func_D299.func_BCDA, var_00);
  wait(var_00);
  func_0BDC::func_A38E(25, 5, 5, 3);
  func_0BDC::func_D16C(level.func_D299.func_BCDA, 0, 1, 0);
}

func_DC50() {
  thread func_BACA();
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_initial_impact"), level.func_DC56, "tag_vfx_000");
  level.func_DC56 playSound("phspace_mons_collide_pt1");
  earthquake(0.39, 2.9, level.func_D127.origin, 20000);
  level.player playrumbleonentity("damage_heavy");
  func_137E2("vfx_ram_drag_start");
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_drag_churn_debris"), level.func_DC56, "tag_vfx_001");
  func_137E2("tower_break");
  thread func_DC55();
  func_137E2("vfx_ram_drag_end");
  stopFXOnTag(scripts\engine\utility::getfx("ret_ram_drag_churn_debris"), level.func_DC56, "tag_vfx_001");
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_drag_end"), level.func_DC56, "tag_vfx_001");
  func_137E2("vfx_ram_slam_start");
  thread func_E313();
  thread func_E312();
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_slam_churn_debris"), level.func_DC56, "tag_vfx_002");
  func_137E2("vfx_ram_slam_end");
  level notify("stop_slam_quakes");
  stopFXOnTag(scripts\engine\utility::getfx("ret_ram_slam_churn_debris"), level.func_DC56, "tag_vfx_002");
}

func_BACA() {
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = level.func_DC56.origin;
  var_0.angles = level.func_3670.angles;
  var_00 linkto(level.func_3670);
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_mons_impact"), var_00, "tag_origin");
  wait 5;
  var_00 delete();
}

func_E313() {
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00 linkto(level.func_DC56, "tag_vfx_002", (0, 0, 0), (0, 0, 0));
  var_00 playSound("phspace_mons_collide_pt2", "sound_done");
  var_00 waittill("sound_done");
  var_00 delete();
}

func_E312() {
  level endon("stop_slam_quakes");
  earthquake(0.25, 1.2, level.func_D127.origin, 20000);
  wait 0.3;

  for(;;) {
    earthquake(0.25, 0.4, level.func_D127.origin, 20000);
    wait(randomfloatrange(0.1, 0.2));
  }
}

func_BAB7(var_00, var_01, var_02) {
  thread func_BAB9(var_00, var_01, var_02);
}

func_BAB9(var_00, var_01, var_02) {
  var_03 = 0.25;
  var_04 = 1.75;
  var_05 = 250000;

  if(isDefined(var_02) && var_02)
    var_06 = undefined;
  else
    var_06 = var_00;

  level.func_3670 thread func_BA7E(var_06);
  wait 3;

  if(isDefined(var_00)) {
    var_00 _meth_81D0();
    thread func_BAB8(var_0.origin);
  }

  if(isDefined(var_01))
    earthquake(var_01, 1, level.func_D127.origin, 10000);
}

func_BAB8(var_00) {
  wait 0.1;
  func_0BDC::func_DBDC(var_00, 0.35, 5000, 60000, undefined, 0.1, 1.6, 1);
}

func_1F93() {
  func_137E2("missile_volley_1");
  func_137E2("missile_volley_2");
  level.func_3670 thread func_0BB6::func_39A1(level.func_3670.func_8B45["center"], 5);
  func_137E2("missile_volley_3");
  level.func_3670 thread func_0BB6::func_39A1(level.func_3670.func_8B45["right_4"], 5);
  func_137E2("missile_volley_4");
}

func_1F97() {
  var_00 = func_137E2("target_turret_group_1");

  if(!var_00) {
    thread func_0BB6::func_39CF(level.func_3670.func_12A39["one"]);
    thread func_126FB(level.func_3670.func_12A39["one"]);
  }

  var_00 = func_137E2("target_turret_group_2");

  if(!var_00) {
    thread func_0BB6::func_39C2(level.func_3670.func_12A39["one"]);
    thread func_0BB6::func_39CF(level.func_3670.func_12A39["two"]);
    thread func_126FB(level.func_3670.func_12A39["two"]);
  }

  var_00 = func_137E2("target_turret_group_3");

  if(!var_00) {
    thread func_0BB6::func_39C2(level.func_3670.func_12A39["two"]);
    thread func_0BB6::func_39CF(level.func_3670.func_12A39["three"]);
    thread func_126FB(level.func_3670.func_12A39["three"]);
  }

  var_00 = func_137E2("ram_start");

  if(!var_00) {
    wait 5;
    level notify("stop_miniflak_for_player");
    func_D29E(4);
    thread func_0BB6::func_39C2(level.func_3670.func_12A39["three"]);
  }
}

func_1F91() {
  var_00 = func_137E2("start");

  if(!var_00) {
    scripts\sp\utility::func_DBF5();
    wait 2.2;
    scripts\sp\utility::func_10350("phspace_slt_holyshitwhatist");
    scripts\sp\utility::func_10350("phspace_plr_scarsdirectallf");
    wait 1.5;
    scripts\sp\utility::func_10350("phspace_plt2_ohshi");
    scripts\sp\utility::func_10350("phspace_plt1_36ishit36isdown");
    scripts\sp\utility::func_10350("phspace_plr_rogethanyouflyi");
    scripts\sp\utility::func_10350("phspace_eth_ayesir");

    if(!isDefined(level.func_D127.func_58B6)) {
      level.func_D127.func_58B6 = spawn("script_origin", level.func_D127.origin);
      level.func_D127.func_58B6 linkto(level.func_D127);
      level.func_D127.func_58B6 ghostattack(0);
    }

    level.func_D127.func_58B6 playLoopSound("jackal_plr_locked_lp");
    level.player setsoundsubmix("jackal_dogfight");
    level.func_D127.func_58B6 ghostattack(1, 1);
    thread scripts\sp\utility::func_10350("phspace_slt_raiderilltargetthe");
  }

  var_00 = func_137E2("plr_panamasdown");
  level.func_3670 func_0BA9::func_39C9();
  level.func_3670 func_0BB8::func_39C8();

  if(!var_00) {
    level.player _meth_82C0("phspace_kotch_pip", 0.25);
    func_A71B();
    level.player _meth_82C0("jackal_cockpit", 0.25);
    thread scripts\sp\utility::func_10350("phspace_slt_deploycounterm");
    thread func_12700("phspace_plr_flaresout");
  }

  var_00 = func_137E2("dialog_turrets_1");

  if(!var_00) {
    thread scripts\sp\utility::func_10350("phspace_slt_hitthoseturrets");
    thread scripts\sp\utility::func_10350("phspace_slt_goodlockonthe");
    thread scripts\sp\utility::func_10350("phspace_slt_cmoncmon");
    thread scripts\sp\utility::func_10350("phspace_eth_noeffectontarget");
    thread scripts\sp\utility::func_10350("phspace_slt_whatsthisthing");
    thread scripts\sp\utility::func_10350("phspace_slt_swinginaroundfor");
    thread scripts\sp\utility::func_10350("phspace_plr_staywithherethan");
    wait 1.0;
    thread scripts\sp\utility::func_10350("phspace_eth_weremarkedsirde");
    thread func_12700("phspace_plr_countermeas");
  }

  var_00 = func_137E2("dialog_turrets_2");

  if(!var_00) {
    thread scripts\sp\utility::func_10350("phspace_plr_targetthecannon12");
    wait 2;
    scripts\sp\utility::func_10350("phspace_slt_impactnoeffect");
    scripts\sp\utility::func_10350("phspace_gtr_allstationstarget");
  }

  var_00 = func_137E2("dialog_ram_exchange2");

  if(!var_00) {
    wait 0.75;
    scripts\sp\utility::func_10350("phspace_eth_overhalftheflee");
    scripts\sp\utility::func_10350("phspace_plr_retributionretreatretreat");
    scripts\sp\utility::func_10350("phspace_nav_thisisretributi");
    wait 0.25;
    scripts\sp\utility::func_10350("phspace_eth_theyrerammingit");
    wait 0.25;
    scripts\sp\utility::func_10350("phspace_plr_negativeretribu");
    scripts\sp\utility::func_10350("phspace_nav_captainsordersl");
    wait 1.1;
    level.func_EA99 scripts\sp\utility::func_10346("phspace_slt_no");
    wait 0.5;
    scripts\sp\utility::func_10350("phspace_eth_flak");
    level.func_EA99 scripts\sp\utility::func_10346("phspace_slt_evadeevade");
    wait 1.2;
    thread scripts\sp\utility::func_10350("phspace_gtr_thisisretmultiplecasualties");
  }

  var_00 = func_137E2("dialog_mons_warp");

  if(!var_00) {
    scripts\sp\utility::func_10350("phspace_plr_focusfirewhileth");
    scripts\sp\utility::func_10350("phspace_fer_tigrisisengagin");
    scripts\sp\utility::func_10350("phspace_slt_theyreretreating");
    scripts\sp\utility::func_10350("phspace_plr_stayonit2");
    wait 2.5;
    scripts\sp\utility::func_10350("phspace_slt_theyjumped");
    wait 1.25;
    scripts\sp\utility::func_10350("phspace_gtr_allstationsbead");
    scripts\sp\utility::func_10350("phspace_slt_olympusbattere");
    scripts\sp\utility::func_10350("phspace_plr_guideusintwo");
    scripts\sp\utility::func_10350("phspace_slt_copy");
    scripts\sp\utility::func_10350("phspace_slt_retributionscar");
    scripts\sp\utility::func_10350("phspace_atc_copyyoureclea");

    if(!scripts\engine\utility::flag("player_jackal_drone_dock"))
      scripts\sp\utility::func_10350("phspace_plr_roger2limaco");

    if(!scripts\engine\utility::flag("player_jackal_drone_dock"))
      scripts\sp\utility::func_10350("phspace_atc_holdforlockstan");

    if(!scripts\engine\utility::flag("player_jackal_drone_dock"))
      var_01 = 1;
    else
      var_01 = 0;

    scripts\engine\utility::flag_wait("player_jackal_drone_dock");
    wait(var_01);
    wait 1.7;
    scripts\sp\utility::func_10350("phspace_atc_goodlockswellta");
    scripts\sp\utility::func_10350("phspace_plr_charliedeltacopy");
  }

  wait 2;
}

func_12700(var_00) {
  if(level.func_D127.func_6E9C.func_12B86.size > 0) {
    return;
  }
  level.func_D127 endon("missile_hit");

  while(level.func_D127.func_6E9C.func_12B86.size == 0)
    wait 0.05;

  scripts\sp\utility::func_10350(var_00);
}

func_1F95() {
  level.func_EA99.func_EF63 = 1000;
  level.func_EA99.func_EF62 = 300;
  level.func_EA99.func_EF5D = 1;
  func_137FF("missile_volley_1");
  level.func_EA99.func_EF5E = (0, 0, -200);
  thread func_102CE(4);
  func_137FF("missile_volley_2");
  thread func_102CE(4);
  func_137FF("missile_volley_3");
  thread func_102CE(6);
  func_137FF("missile_volley_4");
  thread func_102CE(4);
}

func_102CE(var_00) {
  level.func_EA99 func_0B76::func_1945(level.func_EAC0, ["tag_flash_right", "tag_flash_left"], var_00);
}

func_1F96() {
  func_137FF("scn_phsp_salt_trench_01");
  level.func_EA99 playSound("scn_phsp_salt_trench_01");
  func_137FF("scn_phsp_salt_trench_02");
  level.func_EA99 playSound("scn_phsp_salt_trench_02");
  func_137FF("scn_phsp_salt_trench_03");
  level.func_EA99 playSound("scn_phsp_salt_trench_03");
  func_137FF("scn_phsp_salt_trench_04");
  level.func_EA99 playSound("scn_phsp_salt_trench_04");
  func_137FF("scn_phsp_salt_trench_05");
  level.func_EA99 playSound("scn_phsp_salt_trench_05");
}

func_1F94() {
  var_00 = 1;
  var_01 = 4;
  level.func_EA46 makeentitysentient("axis", 0);
  level.func_EA99 func_0BDC::func_19B5(level.func_EA46);

  for(;;) {
    func_137FF("start_shooting_" + var_00);
    level.func_EA99 func_0BDC::func_19AE("shoot_forever");
    func_137FF("stop_shooting_" + var_00);
    level.func_EA99 func_0BDC::func_19AE("dont_shoot");
    var_0++;

    if(var_00 > var_01) {
      break;
    }
  }
}

func_126FB(var_00) {
  level notify("stop_miniflak_for_player");
  level endon("stop_miniflak_for_player");
  thread func_126FC();
  func_D2A8();

  for(;;) {
    var_01 = 1;
    var_02 = 0;

    foreach(var_04 in var_00) {
      if(!isDefined(var_04)) {
        continue;
      }
      var_05 = vectornormalize(var_4.origin - level.func_D127.origin);
      var_06 = vectordot(var_05, anglesToForward(level.func_D127.angles));

      if(var_06 < 0.3) {
        continue;
      }
      var_02 = 1;
      var_04 func_0BB6::func_399E("tag_flash", 0.7, 0, 0);

      if(var_01 == 1) {
        var_01 = 0;
        continue;
      }

      var_01 = 1;
      wait 0.05;
    }

    if(!var_02) {
      break;
    }
  }

  func_D29E();
  level notify("stop_miniflak_for_player");
}

func_126FC() {
  level endon("stop_miniflak_for_player");
  var_00 = 115;
  var_01 = 50;
  var_02 = 0.75;
  var_03 = 0.1;
  var_04 = 0.3;
  level.func_12706 = 1;

  for(;;) {
    var_05 = scripts\sp\math::func_6A8E(var_00, var_01, level.func_12706);
    var_06 = randomfloatrange(50, 1000);
    var_07 = randomfloatrange(-500, 500);
    var_08 = randomfloatrange(-500, 0);
    var_06 = var_06 * anglesToForward(level.func_D127.angles);
    var_07 = var_07 * anglestoright(level.func_D127.angles);
    var_08 = var_08 * anglestoup(level.func_D127.angles);
    var_09 = level.func_D127.origin + var_06 + var_07 + var_08;
    level.func_D127 getrandomarmkillstreak(var_05, var_09, undefined, undefined, "MOD_IMPACT");
    var_10 = scripts\sp\math::func_6A8E(var_03, var_02, level.func_12706);
    var_10 = randomfloatrange(var_10 * (1 - var_04), var_10 * (1 + var_04));
    wait(var_10);
  }
}

func_126FD() {
  level endon("stop_tracking_player_fire");
  level.func_D127 endon("scripted_death");
  var_00 = 1.0;
  var_01 = 0.02;
  level.func_12706 = 1;
  var_02 = 0;

  for(;;) {
    _setsaveddvar("spaceshipTargetLockAnglesScale", 1.1);

    if(level.func_D127.func_4C15.func_9DF4) {
      if(level.func_D127.func_4C15.class == "secondary")
        var_02 = 0.75;
      else
        var_02 = 0.05;
    } else
      var_02 = var_02 - 0.05;

    if(var_02 > 0)
      level.func_12706 = level.func_12706 + var_00;
    else
      level.func_12706 = level.func_12706 - var_01;

    level.func_12706 = clamp(level.func_12706, 0, 1);
    wait 0.05;
  }
}

func_137E2(var_00) {
  var_01 = 0;
  var_02 = getanimlength(level.func_EC85["generic_mover"][level.func_D16B.func_1FAF]);
  var_03 = level.func_D16B islegacyagent(level.func_EC85["generic_mover"][level.func_D16B.func_1FAF]);
  var_03 = var_03 * var_02;
  var_04 = getnotetracktimes(level.func_EC85["generic_mover"][level.func_D16B.func_1FAF], var_00);
  var_04 = var_4[0] * var_02;
  var_05 = (var_04 - var_03) * (1 / level.func_1F5B);

  if(var_05 >= 0)
    wait(var_05);
  else
    var_01 = 1;

  return var_01;
}

func_137E3(var_00, var_01) {
  var_02 = 0;
  var_03 = getanimlength(level.func_EC85["generic_mover"][level.func_D16B.func_1FAF]);
  var_04 = level.func_D16B islegacyagent(level.func_EC85["generic_mover"][level.func_D16B.func_1FAF]);
  var_04 = var_04 * var_03;
  var_05 = getnotetracktimes(level.func_EC85["generic_mover"][level.func_D16B.func_1FAF], var_00);
  var_05 = var_5[0] * var_03;
  var_06 = (var_05 - var_04) * (1 / level.func_1F5B);

  if(var_06 >= 0) {
    wait(var_06);

    if(isDefined(var_01))
      var_01 thread scripts\sp\utility::func_10346("phspace_" + var_00);
    else
      thread scripts\sp\utility::func_10352("phspace_" + var_00);
  }
}

func_137FF(var_00) {
  var_01 = 0;
  var_02 = getanimlength(level.func_EC85["generic_mover"][level.func_EAA5.func_1FAF]);
  var_03 = level.func_D16B islegacyagent(level.func_EC85["generic_mover"][level.func_D16B.func_1FAF]);
  var_03 = var_03 * var_02;
  var_04 = getnotetracktimes(level.func_EC85["generic_mover"][level.func_EAA5.func_1FAF], var_00);
  var_04 = var_4[0] * var_02;
  var_05 = (var_04 - var_03) * (1 / level.func_1F5B);

  if(var_05 >= 0)
    wait(var_05);
  else
    var_01 = 1;

  return var_01;
}

func_BAA0(var_00) {
  if(isDefined(var_00)) {
    var_01 = scripts\engine\utility::spawn_tag_origin();
    var_1.angles = self.angles;
    wait 0.05;
    self linkto(var_01, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_01 moveto(self.func_BCDA.origin, var_00, var_00 * 0.5, var_00 * 0.5);
    var_01 rotateto(self.func_BCDA.angles, var_00, var_00 * 0.5, var_00 * 0.5);
    wait(var_00);
    self unlink();
    var_01 delete();
  }

  self linkto(self.func_BCDA, "j_mainroot", (0, 0, 0), (0, 0, 0));
}

func_1EC5(var_00) {
  thread scripts\sp\anim::func_1F35(var_00, var_0.func_1FAF);
  var_00 _meth_82B1(level.func_EC85["generic_mover"][var_0.func_1FAF], 0);
}

func_10712(var_00) {
  var_01 = scripts\sp\utility::func_10639("generic_mover");
  var_01 hide();
  var_1.func_1FAF = var_00;
  return var_01;
}

#using_animtree("jackal");

func_D1DE() {
  level notify("player_looks_at_ethan");
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00 linkto(level.func_D299.func_BCDA, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_01 = scripts\sp\utility::func_107EA("eth3n_space", 1);
  var_1.func_1FBB = "eth3n";
  var_01 linkto(var_00);
  var_01 givegrabscore(1);
  playFXOnTag(scripts\engine\utility::getfx("vfx_ethan_cockpit_light"), var_01, "tag_origin");
  thread func_0BDC::func_A2B0( % jackal_pilot_heist_mons_intro_lookback, % jackal_vehicle_heist_mons_intro_lookback, 0.2, 1);
  var_00 thread scripts\sp\anim::func_1F35(var_01, "eth3n_sitting");
  wait 3;
  thread func_D12E();
  wait 5;
  var_00 delete();
  var_01 delete();
}

func_BA9F(var_00) {
  level.func_12B7D solid();
  level.func_12B67 solid();
  level.func_12B50 solid();
  level.func_12B51 solid();
  level.func_12B53 solid();
  level.func_12B54 solid();
  level.func_12B56 solid();
  level.func_12B7D func_1076A();
  level.func_12B50 func_1076A();
  level.func_12B51 func_1076A();
  level.func_12B53 func_1076A();
  level.func_12B54 func_1076A();
  level.func_12B55 func_1076A();
  level.func_12B56 func_1076A();
  level.func_12B7D.func_12FBA = 1;
  level.func_12B50.func_12FBA = 1;
  level.func_12B51.func_12FBA = 1;
  level.func_12B53.func_12FBA = 1;
  level.func_12B54.func_12FBA = 1;
  level.func_12B56.func_12FBA = 1;

  if(!var_00)
    wait 0.5;

  level.func_3670 thread func_0BB6::func_39E5("front_left", level.func_12B50);
  level.func_3670 thread func_0BB6::func_39E5("back_left", level.func_12B56);
  level.func_3670 thread func_0BB6::func_39E5("front_right", level.func_12B51);
  level.func_3670 thread func_0BB6::func_39E5("back_right", level.func_12B54, level.func_12B7D);
  wait 0.05;
  level.func_3670 thread func_0BB6::func_399C("left_1", level.func_12B50);
  level.func_3670 thread func_0BB6::func_399C("left_2", level.func_12B50);
  wait 0.05;
  level.func_3670 thread func_0BB6::func_399C("right_1", level.func_12B51);
  level.func_3670 thread func_0BB6::func_399C("right_2", level.func_12B51);

  if(!var_00)
    wait 2.5;

  level.func_12B50 thread func_0BB6::func_3966(1, 1, level.func_3670);
  level.func_12B51 thread func_0BB6::func_3966(1, 1, level.func_3670);

  if(!var_00)
    wait 0.2;

  level.func_12B53 thread func_0BB6::func_3966(1, 1, level.func_3670);
  level.func_12B7D thread func_0BB6::func_3966(1, 1, level.func_3670);

  if(!var_00)
    wait 0.1;

  level.func_12B54 thread func_0BB6::func_3966(1, 1, level.func_3670);
  level.func_12B55 thread func_0BB6::func_3966(1, 1, level.func_3670);

  if(!var_00)
    wait 0.15;

  level.func_12B56 thread func_0BB6::func_3966(1, 1, level.func_3670);
}

func_EA47() {
  level endon("olympus_almost_arrived");
  scripts\engine\utility::flag_wait("jackal_sees_ret_for_landing");
  scripts\sp\utility::func_10350("phspace_slt_gotavisualonret");
}

func_BAAF() {
  var_00 = level.func_D299.origin;
  var_01 = level.func_D299.angles;
  var_02 = (-2000, 300, 400);
  var_03 = anglesToForward(level.func_D299.angles) * var_2[0] + anglestoright(level.func_D299.angles) * var_2[1] + anglestoup(level.func_D299.angles) * var_2[2];
  level.func_EA99 delete();
  scripts\sp\maps\phspace\phspace::func_107C0();
  level.func_EA99 func_0BDC::func_1990(0);
  level.func_EA99 func_0BDC::func_19A2();
  level.func_EA99 vehicle_teleport(var_00 + var_03, var_01);
  level.func_EA99 func_0BDC::func_A1EC(var_00 + var_03, 1, 500, var_01);
  wait 1;
  var_02 = (2000, 500, 300);
  var_03 = anglesToForward(level.func_D299.angles) * var_2[0] + anglestoright(level.func_D299.angles) * var_2[1] + anglestoup(level.func_D299.angles) * var_2[2];
  var_04 = level.func_D299.origin + var_03;
  level.func_EA99 func_0BDC::func_A1EC(var_04, 1, 40, var_01);
}

func_ACEC() {
  for(;;)
    wait 0.05;
}

func_BA9C() {
  var_00 = level.func_D299.origin;
  var_01 = level.func_D299.angles;
  var_02 = (-2000, -300, 100);
  var_03 = anglesToForward(level.func_D299.angles) * var_2[0] + anglestoright(level.func_D299.angles) * var_2[1] + anglestoup(level.func_D299.angles) * var_2[2];
  level.func_1CB9 delete();
  scripts\sp\maps\phspace\phspace::func_1062E();
  level.func_1CB9 vehicle_teleport(var_00 + var_03, var_01);
  level.func_1CB9 func_0BDC::func_19A2();
  level.func_1CB9 func_0BDC::func_19AB(500);
  level.func_1CB9 func_0BDC::func_6B4C("boost_mode");
  var_04 = scripts\engine\utility::getstruct("ally1_flyto_mons", "targetname");
  level.func_1CB9 thread func_0BDC::func_A1EC(var_4.origin, 0);
  wait 3.2;
  level.func_1CB9.func_9930 = 1;
  level.func_1CB9 notify("death");
}

func_96EC() {
  var_00 = scripts\engine\utility::spawn_tag_origin();
  var_00 func_0BDC::func_D2A5();
  level.func_D299 thread func_0BDC::func_D2A0(level.func_D16B.func_11512, (0, 0, 0), 500, 0.2, 0.5, 0.5);
  level.func_D299 thread func_0BDC::func_D2A7();
}

func_D2A8(var_00) {
  if(!isDefined(var_00))
    var_00 = 1;

  func_0BDC::func_A38E(25, 3, 0.55, var_00);
  level.func_D299 thread func_0BDC::func_D29A(level.func_D16B.func_11512, var_00, undefined, undefined, undefined, undefined, 0.012, undefined, 5);
}

func_D29E(var_00) {
  if(!isDefined(var_00))
    var_00 = 2;

  func_0BDC::func_A38E(25, 3, 0.65, var_00);
  level.func_D299 thread func_0BDC::func_D29A(level.func_D16B.func_11512, var_00, undefined, undefined, undefined, undefined, 0.5, undefined, 1);
}

func_BA82() {
  wait 0.0;
  level.func_D127 func_0BDC::func_D164(level.func_D299.func_BCDA, 3);
  level.func_D127.func_A56F = 1;
  func_0BDC::func_A153();
  thread func_DAEE();
  thread func_D083();
  earthquake(0.53, 2.8, level.func_D127.origin, 40000);
  level.player playrumbleonentity("damage_heavy");
  func_0BDC::func_A38E(35, 5, 5, 0.5);
  level.player _meth_8497();
  thread func_A1E2();
  thread func_0BDC::func_A287(0.2);
}

func_DAEE() {
  var_00 = 0.4;
  thread func_0BD9::func_D176(0.7, 0, var_00, 0.05, 0.8);
  wait(var_00);
  thread func_0BD9::func_D176(0.0, 0, 6.5, 0.01, 0.3);
}

func_A1E2() {
  earthquake(0.4, 1.3, level.func_D127.origin, 20000);
  level.func_D127 thread func_0BDD::func_6186(5, 0.4);
  func_0BDC::func_A10B("damage_alarm");
  func_0BD5::func_A2B3(1);
  wait 7;
  func_0BD5::func_A2B3(0);
  wait 6;
  func_0BDC::func_A10B("default");
}

func_D12E() {
  level notify("player_power_on");
  wait 0.4;
  level.func_D127 thread func_0BDB::func_BBE0();
  wait 0.5;
  level.player _meth_8497();
  thread func_0BDC::func_A388(0.2);
  func_0BDC::func_A153(0);
}

func_D17C() {
  level.func_D127.func_13BF7.weapon = "spaceship_30mm_projectile_large_radius";

  if(level.func_D127.func_4C15 == level.func_D127.func_13BF7)
    level.func_D127 _meth_849E(level.func_D127.func_13BF7.weapon);
}

func_BA80() {
  var_00 = [level.func_EA99, level.func_1CB9];

  foreach(var_02 in var_00) {
    var_03 = var_02 scripts\engine\utility::spawn_tag_origin();
    var_02 linkto(var_03);
    var_03 func_BA83();
    var_02 func_0BDC::func_19A0(1);
    var_02 func_0BDC::func_A167();
    var_02 func_0BDC::func_6B4C("none", 1);
  }
}

func_BA83(var_00) {
  var_01 = 22000;
  var_02 = (179, 179, 179);
  var_03 = getvehiclenode("ca_olympus_last_pos", "targetname");
  var_04 = self.origin - var_3.origin;
  var_05 = length(var_04);
  var_06 = scripts\sp\math::func_C097(5000, 80000, var_05);
  var_07 = scripts\sp\math::func_6A8E(var_01, 0, var_06);
  var_08 = scripts\sp\math::func_6A8E(0.1, 0.6, var_06);
  var_09 = vectornormalize(var_04);
  self.func_528E = self.origin + var_09 * var_07;
  wait(var_08);
  self unlink();
  self moveto(self.func_528E, 5, 0.5, 4.5);

  if(isDefined(var_00))
    self.func_5289 = var_00;
  else {
    var_02 = var_02 * (1 - var_06);
    self.func_5289 = self.angles + var_02;
  }

  self rotateto(self.func_5289, 13.0, 1.3, 11.7);
}

func_BAA3() {
  level.func_D127.func_1FBB = "player_jackal";
  scripts\sp\utility::func_10350("phspace_plr_squadronthisis");
  scripts\sp\utility::func_10350("phspace_plt1_copy34returnin");
  thread func_EA47();

  if(!scripts\engine\utility::flag("olympus_almost_arrived"))
    scripts\sp\utility::func_10350("phspace_plt2_36isrtb");

  if(!scripts\engine\utility::flag("olympus_almost_arrived"))
    scripts\sp\utility::func_10350("phspace_slt_letsregroupfuelu");

  if(!scripts\engine\utility::flag("olympus_almost_arrived"))
    scripts\sp\utility::func_10350("phspace_tao_allstationstaog");

  scripts\engine\utility::flag_wait("olympus_almost_arrived");
  scripts\sp\utility::func_10350("phspace_plt1_imgettingsomea");

  if(!scripts\engine\utility::flag("olympus_arrived"))
    scripts\sp\utility::func_10350("phspace_plt2_samecheckingsta");

  scripts\engine\utility::flag_wait("olympus_arriving");
  _setmusicstate("mx_082_ph_mons_combat");
}

func_137FD() {
  var_00 = getent("trigger_safe_to_return", "targetname");
  var_00 func_0BDC::func_136A6(level.func_D127);
}

func_50BF(var_00) {
  wait(var_00);

  if(isDefined(self) && isalive(self)) {
    if(func_0B76::func_7A60(self.origin) < 0.7 && !scripts\engine\utility::cointoss())
      self delete();
    else
      self _meth_81D0();
  }
}

func_BACF(var_00) {
  for(var_01 = 6; var_01 > 0; var_01 = var_01 - 1) {
    thread func_6D0B(var_00);
    wait(randomfloatrange(0.08, 0.25));
  }
}

func_6D0B(var_00) {
  var_01 = self.angles;
  var_01 = invertangles(var_01);
  var_02 = [];
  var_2[var_2.size] = "amb_missile_l_1";
  var_2[var_2.size] = "amb_missile_l_2";
  var_2[var_2.size] = "amb_missile_l_3";
  var_2[var_2.size] = "amb_missile_l_4";
  var_2[var_2.size] = "amb_missile_r_1";
  var_2[var_2.size] = "amb_missile_r_2";
  var_2[var_2.size] = "amb_missile_r_3";
  var_2[var_2.size] = "amb_missile_r_4";
  var_03 = scripts\engine\utility::spawn_tag_origin();
  var_04 = scripts\engine\utility::random(var_02);
  var_3.origin = self gettagorigin(var_04);
  var_3.angles = self gettagangles(var_04);
  var_05 = randomfloatrange(300, 500);
  var_06 = (0, 0, 0);
  var_07 = var_00;
  var_03 thread func_0B76::func_A332(var_07, 1, level.func_F04E, undefined, var_05, var_06, undefined, undefined, 500, 1, 1.0, 1);
  wait 0.6;
  wait(randomfloatrange(0.2, 0.75));
  var_08 = scripts\engine\utility::spawn_tag_origin();
  var_04 = scripts\engine\utility::random(var_02);
  var_8.origin = self gettagorigin(var_04);
  var_8.angles = self gettagangles(var_04);
  var_08 thread func_0B76::func_A332(var_07, 1, level.func_F04E, undefined, var_05, var_06, undefined, undefined, 50, 1, 1.0, 1);
}

func_54FC() {
  var_00 = [level.func_12B7D, level.func_12B67, level.func_12B4A, level.func_12B4C, level.func_12B60, level.func_12B61];

  foreach(var_02 in var_00) {
    if(isDefined(var_02))
      var_02 func_0BB6::func_398A(0);
  }
}

func_BAA1() {
  thread func_BAA2();
}

func_BAA2() {}

func_12705() {
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.func_111D0.func_BA9E, 0);
  scripts\sp\maps\phspace\phspace::func_107C0();
  level.func_EA99 func_0BDC::func_6B4C("space", 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_F5A4();
  var_00 = scripts\sp\vehicle::func_1080C("player_jackal");
  var_01 = scripts\engine\utility::getstruct("trench_run_start", "targetname");
  var_02 = scripts\engine\utility::getstruct("salter_trench_run_start", "targetname");
  level.func_EA99 func_0BDC::func_19A2();
  level.func_EA99 vehicle_teleport(var_2.origin, var_2.angles);
  level.func_EA99 func_0BDC::func_A1EC(var_2.origin, 1, 50, var_2.angles);
  func_0BDC::func_10CD1(var_00, var_01);
  thread scripts\sp\maps\phspace\phspace_battle::func_D868();
  thread scripts\sp\maps\phspace\phspace_battle::func_12B5F();
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\maps\phspace\phspace_battle::func_FE2F();
  func_1F90();

  if(!isDefined(level.func_D127.func_58B6)) {
    level.func_D127.func_58B6 = spawn("script_origin", level.func_D127.origin);
    level.func_D127.func_58B6 linkto(level.func_D127);
    level.func_D127.func_58B6 ghostattack(0);
  }

  level.func_D127.func_58B6 playLoopSound("jackal_plr_locked_lp");
  level.player setsoundsubmix("jackal_dogfight");
  level.func_D127.func_58B6 ghostattack(1, 1);
  func_96EC();
  level.func_D299.origin = var_1.origin;
  level.func_D299.angles = var_1.angles;
  func_0BDC::func_D164(level.func_D299.func_BCDA, 0.0);
  level.func_D127.func_A56F = 1;
  func_1F98("salter_go");
  func_1F8F();
}

func_126F9() {
  scripts\sp\utility::func_266A("jackal_trenchrun");

  if(!isDefined(level.func_D299))
    wait 1;

  if(!scripts\engine\utility::flag_exist("retribution_ram"))
    wait 0.05;

  scripts\engine\utility::flag_wait("retribution_ram");
}

func_12702() {
  wait 2;
  level.func_EA99 func_0BDC::func_6B4C("hover");
  level.func_EA99 linkto(level.func_EAA5, "j_mainroot", (0, 0, 0), (0, 0, 0));
}

func_4968(var_00) {
  var_01 = (1, 1, 1);
  var_02 = 15;
  var_03 = 0;

  for(var_04 = []; var_03 < var_02; var_3++)
    var_4[var_03] = ::scripts\sp\maps\phspace\phspace_battle::func_491E(level.func_3670, randomfloatrange(-8000, 8000), randomfloatrange(-8000, 8000), randomfloatrange(-8000, 8000), 1, "1", var_01, var_00);

  return var_04;
}

func_EAC5(var_00) {
  level.func_EA99 endon("arrived_at_animation");
  var_01 = getanimlength(level.func_EC85["generic_mover"][level.func_D16B.func_1FAF]);
  var_02 = 300;
  var_03 = 4;
  var_04 = 1;
  var_05 = 300;

  for(;;) {
    level.func_EA99 thread func_0BDC::func_A1EC(level.func_EAA5.origin, 0, 0);
    var_06 = level.func_D16B islegacyagent(level.func_EC85["generic_mover"][level.func_D16B.func_1FAF]);
    var_06 = var_06 * var_01;
    var_07 = getnotetracktimes(level.func_EC85["generic_mover"][level.func_D16B.func_1FAF], "link_salter");
    var_07 = var_7[0] * var_01;
    var_08 = var_07 - var_06;

    if(var_08 < 0) {
      break;
    }
    var_09 = distance(level.func_EA99.origin, level.func_D16B.origin);
    var_10 = var_09 / var_08;
    var_10 = scripts\engine\utility::ips_to_mph(var_10);
    var_11 = scripts\sp\math::func_C097(var_04, var_03, var_08);
    var_12 = scripts\sp\math::func_6A8E(0, var_02, var_11);
    var_13 = var_10 + var_12;
    var_13 = clamp(var_13, 0, var_05);
    level.func_EA99 func_0BDC::func_19AB(var_13, 1000);
    wait 0.05;
  }
}

func_AB73(var_00, var_01) {}

func_126F8() {}

func_DC53() {
  scripts\sp\maps\phspace\phspace::func_107C0();
  level.func_EA99 func_0BDC::func_6B4C("space", 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_F5A4();
  var_00 = scripts\sp\vehicle::func_1080C("player_jackal");
  var_01 = scripts\engine\utility::getstruct("ram_start", "targetname");
  var_02 = scripts\engine\utility::getstruct("salter_ram_start", "targetname");
  level.func_EA99 func_0BDC::func_19A2();
  level.func_EA99 vehicle_teleport(var_2.origin, var_2.angles);
  level.func_EA99 func_0BDC::func_A1EC(var_2.origin, 1, 50, var_2.angles);
  func_0BDC::func_10CD1(var_00, var_01);
  thread scripts\sp\maps\phspace\phspace_battle::func_D868();
  thread scripts\sp\maps\phspace\phspace_battle::func_12B5F();
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\maps\phspace\phspace_battle::func_FE2F();
  func_1F90();

  if(!isDefined(level.func_D127.func_58B6)) {
    level.func_D127.func_58B6 = spawn("script_origin", level.func_D127.origin);
    level.func_D127.func_58B6 linkto(level.func_D127);
    level.func_D127.func_58B6 ghostattack(0);
  }

  level.func_D127.func_58B6 playLoopSound("jackal_plr_locked_lp");
  level.player setsoundsubmix("jackal_dogfight");
  level.func_D127.func_58B6 ghostattack(1, 1);
  func_96EC();
  level.func_D299.origin = var_1.origin;
  level.func_D299.angles = var_1.angles;
  func_0BDC::func_D164(level.func_D299.func_BCDA, 0.0);
  level.func_3670 func_F051(1);
  func_1F98("ram_start");
  func_1F8F();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.func_111D0.func_DC4C, 0);
}

func_DC51() {
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\utility::func_266A("ram");

  while(!scripts\engine\utility::flag_exist("flag_player_land"))
    wait 0.05;

  scripts\engine\utility::flag_wait("flag_player_land");
}

func_DC55() {
  level.func_3670 detach("veh_mil_air_ca_olympus_mons_bridge", "TAG_ORIGIN");
  level.func_3670 attach("veh_mil_air_ca_olympus_mons_bridge_dmg", "TAG_ORIGIN");
  level.func_3672 show();
  playFXOnTag(scripts\engine\utility::getfx("mons_bridge_piece_explo"), level.func_3670, "tag_fx_debris");
  playFXOnTag(scripts\engine\utility::getfx("mons_bridge_piece_debris"), level.func_3672, "tag_fx_debris");
}

func_DC4B() {
  thread func_DC54();
  thread func_DC52();
}

func_DC52() {}

func_DC54() {
  var_00 = func_4968((-2000, -3000, 2100));
  level.func_12B7D thread scripts\sp\maps\phspace\phspace_battle::func_B7F9(var_00, 2500);
  level.player playSound("scn_phspace_mons_ftl_out");
  wait 2.5;
  var_00 = func_4968((0, 0, 2100));
  level.func_12B7D thread scripts\sp\maps\phspace\phspace_battle::func_B7F9(var_00, 2500);
}

func_DC4D() {
  thread func_DC4E();
}

func_DC4E() {}

func_A82E() {
  scripts\engine\utility::flag_init("ret_mover_init");
  scripts\sp\maps\phspace\phspace::func_107C0();
  level.func_EA99 func_0BDC::func_6B4C("space", 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_F5A4();
  var_00 = scripts\sp\vehicle::func_1080C("player_jackal");
  var_01 = scripts\engine\utility::getstruct("landing_start", "targetname");
  var_02 = scripts\engine\utility::getstruct("salter_landing_start", "targetname");
  level.func_EA99 func_0BDC::func_19A2();
  level.func_EA99 vehicle_teleport(var_2.origin, var_2.angles);
  level.func_EA99 func_0BDC::func_A1EC(var_2.origin, 1, 50, var_2.angles);
  func_0BDC::func_10CD1(var_00, var_01);
  thread scripts\sp\maps\phspace\phspace_battle::func_D868();
  var_03 = getvehiclenode("retribution_landing_pos", "targetname");
  level.func_12B67 vehicle_teleport(var_3.origin, var_3.angles);
  func_A830();
  var_04 = getvehiclenode("tigris_landing_flyby", "targetname");
  level.func_12B7D scripts\sp\vehicle::func_2471(var_04);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.func_111D0.func_A7D8, 0);
  wait 0.5;
  scripts\engine\utility::flag_set("ret_mover_init");
}

func_A7F5() {
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\utility::func_266A("landing");
  wait 0.05;
  func_A829();
  thread func_A807();
  thread func_A7F7();
  func_0BDC::func_D190(1);
  func_0BDC::func_A14A(0);
  func_0BDC::func_A155(0);
  func_0BDC::func_A302(1);
  level.func_D127.func_A56F = 0;

  if(scripts\engine\utility::flag_exist("ret_mover_init"))
    scripts\engine\utility::flag_wait("ret_mover_init");
}

func_A7F7() {
  level endon("olympus_almost_arrived");
  level endon("player_jackal_drone_dock");
  var_00 = ["phspace_eth_weshouldretur", "phspace_slt_letsgetbacktot", "phspace_eth_wereclearedtol", "phspace_slt_theyllneedusdow"];
  var_01 = [8, 14, 16, 20];
  var_02 = 0;

  for(;;) {
    while(scripts\engine\utility::flag("jackal_landing_active"))
      wait 0.1;

    if(var_02 < 3) {
      wait(var_1[var_02]);
      scripts\sp\utility::func_10350(var_0[var_02], 2);

      if(var_02 < 3)
        var_02 = var_02 + 1;

      continue;
    }

    wait 20;
    var_03 = scripts\engine\utility::random(var_00);
    scripts\sp\utility::func_10350(var_03, 2);
  }
}

func_A807() {
  if(scripts\engine\utility::flag("started_preload")) {
    return;
  }
  scripts\engine\utility::flag_set("started_preload");
  scripts\sp\utility::func_1264E("phspace_base_tr");
  wait 2.0;
  level thread scripts\sp\utility::func_BF97();
}

func_A830() {
  if(scripts\engine\utility::flag("ret_swapped")) {
    return;
  }
  level.func_FD6E.func_E35D.origin = level.func_12B67.origin;
  level.func_FD6E.func_E35D.angles = level.func_12B67.angles;
  level.func_FD6E.func_E35D linkto(level.func_12B67);
  level.func_FD6E.func_E35D func_0B51::func_FDCB("show");
  level.func_FD6E.func_E35D func_0B51::func_FDCB("solid");
  level.func_12B67 _meth_8184();
  level.func_12B67 notsolid();
  level.func_12B67 func_0BB8::func_397C();
  scripts\sp\maps\phspace\phspace_battle::delete_ret_door_hack();
  scripts\engine\utility::flag_set("ret_swapped");
}

func_11311() {
  if(isDefined(level.func_3670)) {
    level.func_3670 detach("veh_mil_air_ca_olympus_mons", "TAG_ORIGIN");
    level.func_3670 attach("veh_mil_air_ca_olympus_mons_dmg", "TAG_ORIGIN");
    level.func_3670.func_4CF6 = scripts\engine\utility::spawn_tag_origin();
    level.func_3670.func_4CF6 linkto(level.func_3670, "tag_origin", (550, 5100, 4100), (0, 0, 0));
    playFXOnTag(scripts\engine\utility::getfx("mons_damage_linger"), level.func_3670.func_4CF6, "tag_origin");
  }

  level.func_FD6E.func_E35D setModel("veh_mil_air_un_retribution_dmg");
  level.func_FD6E.func_E35D.func_4CF6 = scripts\engine\utility::spawn_tag_origin();
  level.func_FD6E.func_E35D.func_4CF6 linkto(level.func_FD6E.func_E35D, "tag_origin", (14000, -1800, 800), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("ret_damage_linger"), level.func_FD6E.func_E35D.func_4CF6, "tag_origin");
}

func_A7DD() {
  thread func_A7DE();
}

func_A7DE() {}

func_FE2E() {
  var_00 = level.func_3662 func_0BA9::func_39AC();
  var_01 = level.func_3663 func_0BA9::func_39AC();
  var_02 = level.func_3664 func_0BA9::func_39AC();
  var_03 = level.func_3665 func_0BA9::func_39AC();
  level.func_52D1 = scripts\engine\utility::array_add(level.func_52D1, var_00);
  level.func_52D1 = scripts\engine\utility::array_add(level.func_52D1, var_01);
  level.func_52D1 = scripts\engine\utility::array_add(level.func_52D1, var_02);
  level.func_52D1 = scripts\engine\utility::array_add(level.func_52D1, var_03);
}

func_F051(var_00) {
  self.delay_warp_core = "show_warp_core";
  func_1076F();
  func_0BB6::func_39E1();
  func_1078C();
  wait 0.1;
  func_0BB8::func_39CD("off");
  func_0BB8::func_39D0("off");
  func_0BB8::func_39AE();
  self.func_129D9 = 1;
  wait 1.0;

  if(!isDefined(var_00))
    func_0BB8::func_397F(1, 1);
}

func_1078C() {
  var_00 = "cannon_small_ca_mons";
  var_01 = "cannon_missile_ca_hardpoint";
  var_02 = ["amb_missile_l_1", "amb_missile_l_2", "amb_missile_r_1", "amb_missile_r_2"];
  var_03 = "";
  var_03 = var_03 + var_00 + " ";
  var_03 = var_03 + var_01;
  self.func_EEF9 = var_03;
  self.spawn_hidden_turrets = 1;
  func_0BB6::func_39E8();
  level.func_39DD["cannon_small_ca_mons"].func_10241.func_10943 = ::func_BA6C;
  wait 0.05;
  self.func_CA99 = 1;
  level.func_C214 = -1;
  thread scripts\sp\maps\phspace\phspace_battle::func_FA45();
  thread func_6D19();
  thread func_0BB6::func_39EF();
  thread func_C418();
  wait 0.1;
  thread func_BAF5();
  thread func_FA70();
  level.func_39DD["cannon_small_ca_mons"].func_4D1E.fx.death = "vfx_cap_turret_death_sm_fast";
  level.func_39DD["cannon_large_ca"].func_4D1E.fx.death = "vfx_cap_turret_death_lrg_fast";
  level.func_39DD["cannon_missile_ca_hardpoint"].func_4D1E.fx.death = "vfx_cap_turret_death_smt_fast";
  thread func_E02C();
}

func_E02C() {
  wait 2.0;

  foreach(var_01 in self.turrets["cap_turret_small_constant"]) {
    if(var_1.func_AD42 == "amb_turret_sml_l_5" || var_1.func_AD42 == "amb_turret_sml_r_5" || var_1.func_AD42 == "amb_turret_sml_l_6" || var_1.func_AD42 == "amb_turret_sml_r_6")
      var_01 delete();
  }
}

func_4496(var_00) {
  var_01 = "";

  foreach(var_03 in var_00)
  var_01 = var_01 + "," + var_03;

  return var_01;
}

func_BA6C(var_00) {
  if(self.func_114FB == level.func_D127 || self.func_1DF8 == level.func_D127) {
    if(soundexists("capitalship_cannon_fire"))
      self playSound("capitalship_cannon_fire");

    self shootturret(var_00);
  } else {
    var_01 = level.func_39DD["cannon_small_ca_mons"];
    var_02 = func_0BB6::func_12A36(var_00);
    var_03 = func_0BB6::func_12A37(var_00, var_02);
    var_02 = anglesToForward(var_02);
    self thread[[var_1.func_10241.func_AF57]](var_03, var_02, var_00);
    var_04 = var_1.func_4D1E.fx;
  }
}

func_C418() {
  wait 0.1;

  foreach(var_01 in self.turrets) {
    foreach(var_03 in var_01)
    var_3.health = 10;
  }
}

func_1076A() {
  func_0BB6::func_39E1();
  self.func_EEF9 = "cannon_large_un missile_tube_un";
  func_0BB6::func_39E8();
  wait 0.1;
  func_0BB8::func_39CD("idle");
  func_0BB8::func_39D0("idle");
  func_0BB8::func_39AE();
}

func_6D19() {
  var_00 = self.turrets["cap_turret_phalanx"];

  if(!isDefined(var_00) || var_0.size == 0) {
    return;
  }
  foreach(var_02 in var_00) {
    if(isDefined(var_02))
      var_02 thread func_6D1A();
  }
}

func_6D1A() {
  self.func_C841 endon("death");
  self.func_C841 endon("ftl_out");
  self endon("death");

  for(;;) {
    func_0BB6::func_11547();
    wait(randomfloatrange(0.1, 0.8));
  }
}

func_BAF7() {
  level notify("end_mons_turrets_target_player");

  foreach(var_05, var_01 in self.turrets) {
    if(var_05 == "cap_turret_phalanx") {
      continue;
    }
    foreach(var_03 in var_01) {
      if(!isDefined(var_03)) {
        continue;
      }
      var_3.func_114FB = var_3.func_1DF8;
      var_3.func_D92F = undefined;

      if(isDefined(var_3.func_1DF8))
        var_03 settargetentity(var_3.func_1DF8, (0, 0, 0));
    }
  }

  level.func_D127.func_BAEF delete();
}

func_BAF5() {
  var_00 = anglesToForward(level.func_D127.angles);
  var_01 = anglestoup(level.func_D127.angles);
  var_02 = spawn("script_origin", level.func_D127.origin + var_00 * 750 + var_01 * 350);
  var_2.angles = level.func_D127.angles;
  level.func_D127.func_BAEF = var_02;
  level.func_D127.func_BAEF linkto(level.func_D127);

  foreach(var_08, var_04 in self.turrets) {
    if(var_08 == "cap_turret_phalanx") {
      continue;
    }
    foreach(var_06 in var_04)
    var_06 thread func_BAF6();
  }
}

func_BAF6() {
  self endon("death");
  level endon("end_mons_turrets_target_player");
  var_00 = 900000000;
  var_01 = 0.75;

  for(;;) {
    var_02 = distancesquared(level.func_D127.origin, self.origin);
    var_03 = func_0B76::func_7A60(self.origin);

    if(var_02 < var_00 && var_03 > var_01) {
      var_04 = level.func_D127.func_BAEF;
      self.func_114FB = var_04;
      self.func_D92F = var_04;
      self settargetentity(var_04, (0, 0, 0));
    } else if(isDefined(self.func_D92F)) {
      self.func_114FB = self.func_1DF8;
      self.func_D92F = undefined;

      if(isDefined(self.func_1DF8))
        self settargetentity(self.func_1DF8, (0, 0, 0));

      self notify("stop_debug_line_loop");
    }

    wait 0.05;
  }
}

func_FA63() {
  func_0BB6::func_39E1();
  self.func_EEF9 = "cannon_large_un cannon_missile_ca_hardpoint";
  func_0BB6::func_39E8();
}

func_FA70() {
  var_00 = ["amb_turret_sml_l_5", "amb_turret_sml_l_6", "amb_turret_l_1", "amb_turret_l_2", "amb_turret_sml_l_2", "amb_turret_sml_l_3", "amb_turret_sml_l_4", "amb_turret_sml_l_7", "amb_turret_l_3", "amb_turret_l_4", "amb_turret_sml_l_8", "amb_turret_sml_l_10", "amb_turret_l_5", "amb_turret_l_6", "amb_turret_l_4", "amb_turret_sml_l_9", "amb_turret_sml_l_11", "amb_turret_sml_l_12", "amb_turret_l_7", "amb_turret_l_8", "amb_turret_l_9", "amb_turret_sml_l_13"];
  var_01 = ["amb_turret_r_5", "amb_turret_r_6", "amb_turret_sml_r_7", "amb_turret_sml_r_9", "amb_turret_sml_r_10", "amb_turret_r_4", "amb_turret_sml_r_8", "amb_turret_r_3", "amb_turret_r_7", "amb_turret_sml_r_2", "amb_turret_sml_r_3", "amb_turret_r_1", "amb_turret_r_2", "amb_turret_sml_r_4", "amb_turret_r_8", "amb_turret_r_9", "amb_turret_r_10", "amb_turret_r_11", "amb_turret_r_12", "amb_turret_r_13", "amb_turret_r_14", "amb_turret_r_15"];
  var_02 = ["amb_turret_sml_r_11", "amb_turret_sml_r_12", "amb_turret_sml_r_13", "amb_turret_sml_r_14", "amb_turret_sml_r_15", "amb_turret_sml_r_16", "amb_turret_sml_r_17", "amb_turret_sml_r_18"];
  self.func_12A39["one"] = [];
  self.func_12A39["two"] = [];
  self.func_12A39["three"] = [];

  foreach(var_04 in self.turrets) {
    foreach(var_06 in var_04) {
      if(isDefined(var_06)) {
        if(scripts\engine\utility::array_contains(var_00, var_6.func_AD42)) {
          self.func_12A39["one"][self.func_12A39["one"].size] = var_06;
          continue;
        }

        if(scripts\engine\utility::array_contains(var_01, var_6.func_AD42)) {
          self.func_12A39["two"][self.func_12A39["two"].size] = var_06;
          continue;
        }

        if(scripts\engine\utility::array_contains(var_02, var_6.func_AD42))
          self.func_12A39["three"][self.func_12A39["three"].size] = var_06;
      }
    }
  }

  self.func_8B45["left_1"] = [];
  self.func_8B45["left_2"] = [];
  self.func_8B45["left_3"] = [];
  self.func_8B45["left_4"] = [];
  self.func_8B45["right_1"] = [];
  self.func_8B45["right_2"] = [];
  self.func_8B45["right_3"] = [];
  self.func_8B45["right_4"] = [];
  self.func_8B45["center"] = [];
  var_09 = 10;

  foreach(var_11 in self.func_8B4F) {
    foreach(var_13 in var_11) {
      if(isDefined(var_13)) {
        if(scripts\engine\utility::array_contains(self.func_8B46["left_1"], var_13.func_AD42))
          self.func_8B45["left_1"][self.func_8B45["left_1"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self.func_8B46["right_1"], var_13.func_AD42))
          self.func_8B45["right_1"][self.func_8B45["right_1"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self.func_8B46["left_2"], var_13.func_AD42))
          self.func_8B45["left_2"][self.func_8B45["left_2"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self.func_8B46["right_2"], var_13.func_AD42))
          self.func_8B45["right_2"][self.func_8B45["right_2"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self.func_8B46["left_3"], var_13.func_AD42))
          var_13 delete();
        else if(scripts\engine\utility::array_contains(self.func_8B46["right_3"], var_13.func_AD42))
          var_13 delete();
        else if(scripts\engine\utility::array_contains(self.func_8B46["left_4"], var_13.func_AD42))
          self.func_8B45["left_4"][self.func_8B45["left_4"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self.func_8B46["right_4"], var_13.func_AD42))
          self.func_8B45["right_4"][self.func_8B45["right_4"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self.func_8B46["center"], var_13.func_AD42))
          self.func_8B45["center"][self.func_8B45["center"].size] = var_13;

        var_9--;

        if(var_09 <= 0) {
          wait 0.05;
          var_09 = 10;
        }
      }
    }
  }
}

func_104D0() {
  var_00 = scripts\engine\utility::getstructarray("debris_cloud_struct", "script_noteworthy");
  var_01 = undefined;
  var_02 = scripts\engine\utility::spawn_tag_origin(level.func_3670 gettagorigin("fx_light_running_lrg_b3_1"), level.func_3670 gettagangles("fx_light_running_lrg_b3_1"));
  var_03 = anglesToForward(level.func_3670.angles);
  var_04 = anglestoright(level.func_3670.angles);
  var_05 = anglestoup(level.func_3670.angles);
  var_06 = scripts\engine\utility::spawn_tag_origin(var_2.origin + var_03 * 4500 + var_04 * -500 + var_05 * -1000, var_2.angles);
  playFXOnTag(level._effect["vfx_ca_destroyer_ambient_debris"], var_02, "tag_origin");
  playFXOnTag(level._effect["vfx_ca_destroyer_ambient_debris"], var_06, "tag_origin");
}

#using_animtree("vehicles");

func_1076F() {
  var_00 = spawn("script_model", (0, 0, 0));
  var_00 setModel("veh_mil_air_ca_olympus_mons_gun_rig");
  var_00 glinton(#animtree);
  var_00 linkto(self, "tag_main_cannon", (0, 0, 0), (0, 0, 0));
  self.cannon = var_00;
  self.cannon hide();
}

func_BA7E(var_00) {
  var_01 = 2;
  var_02 = 2;

  if(!isDefined(self.cannon.func_11512))
    self.cannon.func_11512 = scripts\engine\utility::spawn_tag_origin();

  if(isDefined(var_00)) {
    self.cannon.func_11512.origin = var_0.origin;
    self.cannon.func_11512 linkto(var_00);
  } else
    self.cannon.func_11512 linkto(self.cannon, "tag_flash", (20000, 0, 0), (0, 0, 0));

  self.cannon playSound("mons_megacannon_fire");
  earthquake(0.25, 0.75, self.cannon.origin, 15000);
  thread func_0BB4::func_BA6A(var_01, var_02, 0);
  wait(var_01);
  var_03 = self.cannon gettagorigin("tag_flash");
  var_04 = self.cannon gettagangles("tag_flash");
  var_05 = var_03 + anglesToForward(var_04) * 1000;
  var_06 = self.cannon.func_11512.origin;
  var_07 = bulletTrace(var_05, var_06, 1, self.cannon);

  if(var_7["fraction"] < 1)
    playFX(scripts\engine\utility::getfx("vfx_mons_fspar_impact"), var_7["position"], anglesToForward(var_04), anglestoup(var_04));
}

func_F587() {
  level.func_3670.cannon.func_AEBB = % ph_trenchrun_local_megacannon;
  level.func_3670.func_AEBB = % ph_trenchrun_local_mons;
}

func_9347() {
  scripts\engine\utility::flag_init("ret_mover_init");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_F5A4();
  var_00 = scripts\sp\vehicle::func_1080C("player_jackal");
  var_01 = scripts\engine\utility::getstruct("landing_start", "targetname");
  var_02 = scripts\engine\utility::getstruct("salter_landing_start", "targetname");
  func_0BDC::func_10CD1(var_00, var_01);
  thread scripts\sp\maps\phspace\phspace_battle::func_D868();
  var_03 = getvehiclenode("retribution_landing_pos", "targetname");
  level.func_12B67 vehicle_teleport(var_3.origin, var_3.angles);
  level.func_3670 = func_0BB8::func_398E("ca_olympus", "idle", "heavy", "high");
  level.func_3670 thread func_F051();
  func_A830();
  wait 0.5;
  func_11311();
  wait 0.1;
  level.func_3670 detach("veh_mil_air_ca_olympus_mons_bridge", "TAG_ORIGIN");
  level.func_3670 attach("veh_mil_air_ca_olympus_mons_bridge_dmg", "TAG_ORIGIN");
  scripts\engine\utility::flag_set("ret_mover_init");
}

func_A71B() {
  _setsaveddvar("bg_cinematicFullScreen", "1");
  _setsaveddvar("bg_cinematicCanPause", "1");
  _cinematicingame("phspace_hud_kotch_pip_01_full");

  while(!iscinematicplaying())
    wait 0.05;

  while(iscinematicplaying())
    wait 0.05;

  _stopcinematicingame();
  _setsaveddvar("bg_cinematicFullScreen", "1");
  _setsaveddvar("bg_cinematicCanPause", "1");
}

func_9346() {}