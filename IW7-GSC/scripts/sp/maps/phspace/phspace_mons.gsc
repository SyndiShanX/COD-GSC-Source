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
  level.var_EA99 func_0BDC::func_6B4C("space", 0);
  level.var_1CB9 func_0BDC::func_6B4C("space", 0);
  level.var_EA99.ignoreme = 1;
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_F5A4();
  var_0 = scripts\sp\vehicle::func_1080C("player_jackal");
  var_1 = scripts\engine\utility::getstruct("mons_intro_start", "targetname");
  func_0BDC::func_10CD1(var_0, var_1);
  wait 0.05;
  thread scripts\sp\maps\phspace\phspace_battle::func_D868();
  thread scripts\sp\maps\phspace\phspace_battle::func_12B5F();
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\maps\phspace\phspace_battle::func_FE2F();
  level.var_EA99 vehicle_teleport(var_1.origin + -5000 * anglesToForward(level.var_D127.angles), var_1.angles);
  thread scripts\sp\maps\phspace\phspace_battle::func_12B7B(1);
  wait 1.0;
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.var_111D0.var_1022B, 0.2);
}

func_6EB8(var_0) {
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
  level.var_12B67 func_0BB6::func_39E1();
  var_0 = getent("ca_olympus", "targetname");
  var_0.var_EEF9 = "none";
  level.var_3670 = scripts\sp\vehicle::func_1080C("ca_olympus");
  level.var_3670 thread func_F051();
  level.var_3670 hide();
  wait 0.05;
  level.var_3670 func_0BB8::func_7491();
  scripts\engine\utility::delaythread(5, ::func_A7F7);
  func_CF82();
  scripts\engine\utility::flag_set("olympus_arriving");
  _setmusicstate("mx_291_mons_coming");
  level.player playSound("scn_phspace_mons_arrive");
  level.var_3670 thread func_0BB8::func_398C("idle", "idle", "high");
  level.var_3670 thread mons_ftl_in_show_delayed();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.var_111D0.var_BA9E, 0.2);
  scripts\engine\utility::flag_set("olympus_arrived");
  scripts\sp\utility::func_10FEC("returnret");
  level.var_FD6E.var_E35D thread func_0BDB::func_A2F1();
  thread func_BA82();
  thread func_AB88();
  func_1F8F();
  thread func_BA9F(0);
  thread func_513D();
}

mons_ftl_in_show_delayed() {
  wait 0.2;
  level.var_3670 notify("show_warp_core");
  level.var_3670.cannon show();

  foreach(var_1 in self.var_8B4F) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3)) {
        var_3 show();
      }
    }
  }

  func_0BB8::func_39C8();
}

func_513D() {
  if(!isDefined(level.var_12B4C)) {
    return;
  }
  while(func_0B76::func_7A60(level.var_12B4C.origin) > 0.0) {
    wait 0.5;
  }

  level.var_12B4C func_0BA9::func_397B();
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
  var_0 = 0;

  for(;;) {
    if(level.player adsbuttonpressed() && !var_0) {
      _setsaveddvar("spaceshipForceSetFovBlendStrength", 4);
      _setsaveddvar("spaceshipForceSetFov", 42);
      var_0 = 1;
    }

    if(!level.player adsbuttonpressed() && var_0) {
      _setsaveddvar("spaceshipForceSetFov", 0);
      var_0 = 0;
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
  var_0 = 999999;
  level.var_FD6E.var_E35D linkto(level.var_12B67.var_BCDA);
  var_1 = 5;
  var_2 = 0.12;

  while(var_1 > 0) {
    level.var_FD6E.var_E35D unlink();
    var_3 = level.var_12B67.var_BCDA gettagorigin("j_mainroot");
    var_4 = level.var_12B67.var_BCDA gettagangles("j_mainroot");
    var_5 = anglesToForward(level.var_FD6E.var_E35D.angles);
    var_6 = anglestoright(level.var_FD6E.var_E35D.angles);
    var_7 = anglestoup(level.var_FD6E.var_E35D.angles);
    level.var_FD6E.var_E35D.origin = scripts\sp\math::func_AB6F(level.var_FD6E.var_E35D.origin, var_3, var_2);
    var_5 = scripts\sp\math::func_AB6F(var_5, anglesToForward(var_4), var_2);
    var_6 = scripts\sp\math::func_AB6F(var_6, anglestoright(var_4), var_2);
    var_7 = scripts\sp\math::func_AB6F(var_7, anglestoup(var_4), var_2);
    level.var_FD6E.var_E35D.angles = _axistoangles(var_5, var_6, var_7);
    level.var_FD6E.var_E35D linkto(level.var_12B67.var_BCDA, "j_mainroot");
    var_1 = var_1 - 0.05;
    wait 0.05;
  }

  level.var_FD6E.var_E35D linkto(level.var_12B67.var_BCDA, "j_mainroot", (0, 0, 0), (0, 0, 0));
}

func_A828() {
  scripts\engine\utility::flag_set("jackal_landing_never_launch_drone");
  level.var_FD6E.var_E35D unlink();
  level.var_FD6E.var_E35D.var_E708 = 0.3;
  level.var_FD6E.var_E35D.var_EBA9 = 0.5;
  level.var_FD6E.var_E35D.var_B455 = 145;
  level.var_FD6E.var_E35D.var_B74F = 130;
  level.var_FD6E.var_E35D scripts\engine\utility::delaythread(0.2, func_0BDB::func_A2F2);
}

func_A829() {
  scripts\engine\utility::flag_clear("jackal_landing_never_launch_drone");
  level.var_FD6E.var_E35D unlink();
  level.var_FD6E.var_E35D.var_E708 = undefined;
  level.var_FD6E.var_E35D.var_EBA9 = undefined;
  level.var_FD6E.var_E35D.var_B455 = undefined;
  level.var_FD6E.var_E35D.var_B74F = undefined;
  level.var_12B67 linkto(level.var_FD6E.var_E35D);
  level.var_FD6E.var_E35D scripts\engine\utility::delaythread(0.2, func_0B51::func_E3C6, 1, 0);
}

func_CF82() {
  wait 0.2;
  func_A828();
  level.var_12B67 linkto(level.var_FD6E.var_E35D);

  for(;;) {
    var_0 = level.var_FD6E.var_E35D.var_E8AD;
    var_1 = level.var_D127.origin - var_0.origin;
    var_2 = rotatevectorinverted(var_1, var_0.angles);
    var_3 = var_2[0];
    var_4 = pointonsegmentnearesttopoint(var_0.origin, var_0.origin + anglesToForward(var_0.angles) * 6000, level.var_D127.origin);
    var_5 = distance(level.var_D127.origin, var_4);

    if(var_3 < 21000 && scripts\engine\utility::flag("jackal_landing_active") && !scripts\engine\utility::flag("olympus_almost_arrived")) {
      scripts\engine\utility::flag_set("olympus_almost_arrived");
    }

    if(var_3 < 9000 && var_5 < 1000 && scripts\engine\utility::flag("jackal_landing_active")) {
      break;
    }
    wait 0.05;
  }
}

func_1F90() {
  while(!isDefined(level.var_12B55)) {
    wait 0.05;
  }

  if(scripts\engine\utility::flag("mons_intro_setup_complete")) {
    return;
  }
  level.var_12703 = [];
  level.var_3672 = spawn("script_model", (0, 0, 0));
  level.var_3672 setModel("veh_mil_air_ca_olympus_mons_bridge_piece");
  level.var_3672 notsolid();
  level.var_3672 hide();
  var_0 = scripts\engine\utility::getstruct("trenchrun_anim_node", "targetname");
  level.var_1F8E = var_0 scripts\engine\utility::spawn_tag_origin();
  level.var_1F8E.angles = var_0.angles;
  level.var_EAA5 = func_10712("trenchrun_salter");
  level.var_D16B = func_10712("trenchrun_player");
  level.var_3671 = func_10712("trenchrun_mons");
  level.var_EA46 = func_10712("trenchrun_salter_bullet_target");
  level.var_EAC0 = func_10712("trenchrun_salter_missile_target");
  level.var_DC56 = func_10712("trenchrun_ram_vfx");
  level.var_3672.var_BCDA = func_10712("trenchrun_mons_tower");
  level.var_12B67.var_BCDA = func_10712("trenchrun_ret");
  level.var_12B7D.var_BCDA = func_10712("trenchrun_tigris");
  level.var_12B50.var_BCDA = func_10712("trenchrun_convoy_00");
  level.var_12B51.var_BCDA = func_10712("trenchrun_convoy_01");
  level.var_12B53.var_BCDA = func_10712("trenchrun_convoy_02");
  level.var_12B54.var_BCDA = func_10712("trenchrun_convoy_03");
  level.var_12B55.var_BCDA = func_10712("trenchrun_convoy_04");
  level.var_12B56.var_BCDA = func_10712("trenchrun_convoy_05");
  level.var_D16B.var_11512 = scripts\engine\utility::spawn_tag_origin();
  level.var_D16B.var_11512 linkto(level.var_D16B, "j_mainroot", (0, 0, 0), (0, 0, 0));
  level.var_12704 = [level.var_EAA5, level.var_D16B, level.var_3671, level.var_EA46, level.var_EAC0, level.var_DC56, level.var_12B67.var_BCDA, level.var_12B7D.var_BCDA, level.var_12B50.var_BCDA, level.var_12B51.var_BCDA, level.var_12B53.var_BCDA, level.var_12B54.var_BCDA, level.var_12B55.var_BCDA, level.var_12B56.var_BCDA, level.var_3672.var_BCDA];
  var_1 = [level.var_12B67, level.var_12B7D, level.var_12B50, level.var_12B51, level.var_12B53, level.var_12B54, level.var_12B55, level.var_12B56, level.var_3672];

  foreach(var_3 in level.var_12704) {
    var_3 linkto(level.var_1F8E);
    level.var_1F8E func_1EC5(var_3);
  }

  foreach(var_6 in var_1) {
    var_6 func_BAA0();
  }

  scripts\engine\utility::flag_set("mons_intro_setup_complete");
}

func_F5D4(var_0) {
  level.var_12703 = scripts\engine\utility::array_add(level.var_12703, self);
  self give_attacker_kill_rewards(self.var_AEBB);
  self func_82B0(self.var_AEBB, var_0);
}

func_1F8F() {
  level.var_1F5B = 0.9;
  thread func_126FD();
  thread func_12702();
  level.var_D299 thread func_0BDC::func_D29B(1, 3);
  level.var_3670 linkto(level.var_3671, "tag_origin", (0, 0, 0), (0, 0, 0));
  func_F587();
  var_0 = level.var_D16B islegacyagent(level.var_EC85["generic_mover"][level.var_D16B.var_1FAF]);
  level.var_3670.cannon func_F5D4(var_0);
  level.var_3670 func_F5D4(var_0);

  foreach(var_2 in level.var_12704) {
    var_2 func_82B1(level.var_EC85["generic_mover"][var_2.var_1FAF], 1 * level.var_1F5B);
  }

  foreach(var_5 in level.var_12703) {
    var_5 func_82B1(var_5.var_AEBB, 1 * level.var_1F5B);
  }

  thread func_1F92();
}

func_1F98(var_0) {
  var_1 = getnotetracktimes(level.var_EC85["generic_mover"][level.var_D16B.var_1FAF], var_0);

  foreach(var_3 in level.var_12704) {
    var_3 func_82B0(level.var_EC85["generic_mover"][var_3.var_1FAF], var_1[0]);
  }
}

func_5B45(var_0) {
  thread func_0BDC::func_ACE8(var_0);

  for(;;) {
    wait 0.05;
  }
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
  level.var_3670.var_24C2 = 90;
  func_137E2("kill_convoy02");
  level.var_12B53 thread func_0BB6::func_3983(level.var_3670);
  func_BAB7(level.var_12B53);
  var_0 = func_137E2("lookat_ethan");

  if(!var_0) {
    thread func_D1DE();
  }

  var_0 = func_137E2("kill_convoy00");
  level.var_12B51 thread func_0BB6::func_3983(level.var_3670);
  func_BAB7(level.var_12B50, 0.25);

  if(var_0) {
    var_1 = 0.05;
  } else {
    var_1 = 40;
  }

  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.var_111D0.var_DC4C, var_1);
  var_0 = func_137E2("salter_go");
  level.var_EA99 func_0BDC::func_6B4C("fly");
  level.var_12B51 scripts\engine\utility::delaythread(6, func_0BB6::func_3984, level.var_3670);
  level.var_12B51 scripts\engine\utility::delaythread(9.5, func_0BB6::func_3984, level.var_3670);
  func_137E2("kill_convoy01");
  level.var_12B7D scripts\engine\utility::delaythread(1, func_0BB6::func_3983, level.var_3670);
  level.var_12B51.var_4E09 = undefined;
  func_BAB7(level.var_12B51, 0.2, 1);
  level.var_3670 thread func_0BB6::func_39E5("front_right", level.var_12B53);
  level.var_3670 thread func_0BB6::func_399C("right_1", level.var_12B53);
  level.var_3670 thread func_0BB6::func_399C("right_2", level.var_12B53);
  func_137E2("scale_flares_for_trench");
  level.var_D127.var_6E93 = 0.12;
  level.var_D127.var_6E97 = 0.55;
  level.var_D127.var_6E8A = 1;
  func_137E2("flare_scale_normal");
  level.var_D127.var_6E93 = 0.29;
  level.var_D127.var_6E97 = 0.75;
  level.var_D127.var_6E8A = 0;

  if(var_0) {
    var_1 = 0.05;
  } else {
    var_1 = 25;
  }

  level.var_1F8E rotateto(level.var_1F8E.angles + (0, 25, 0), var_1, var_1 * 0.5, var_1 * 0.5);
  level.var_1F8E moveto(level.var_1F8E.origin + (-10000, -35000, 0), var_1, var_1 * 0.5, var_1 * 0.5);
  func_137E2("kill_convoy05");
  level.var_12B54 scripts\engine\utility::delaythread(11, func_0BB6::func_3983, level.var_3670);
  level.var_12B54 scripts\engine\utility::delaythread(17, func_0BB6::func_3983, level.var_3670);
  func_BAB7(level.var_12B56);
  level.var_3670 thread func_0BB6::func_39E5("front_left", level.var_12B53);
  level.var_3670 thread func_0BB6::func_39E5("front_right", level.var_12B54, level.var_12B55);
  level.var_3670 thread func_0BB6::func_39E5("back_right", level.var_12B54, level.var_12B55);
  func_137E2("kill_convoy03");
  func_BAB7(level.var_12B54);
  level.var_3670 thread func_0BB6::func_39E5("front_left", level.var_12B67);
  level.var_3670 thread func_0BB6::func_39E5("back_left", level.var_12B67);
  level.var_3670 thread func_0BB6::func_39E5("front_right", level.var_12B7D);
  level.var_3670 thread func_0BB6::func_39E5("back_right", level.var_12B7D);
  level.var_12B50 thread func_0BB6::func_39E1();
  level.var_12B53 thread func_0BB6::func_39E1();
  level.var_12B55 thread func_0BB6::func_39E1();
  func_137E2("ram_start");
  scripts\engine\utility::flag_set("retribution_ram");
  func_A830();
  func_137E2("kill_convoy04");
  level.var_12B55.var_4E09 = undefined;
  level.var_12B55 scripts\engine\utility::delaycall(3, ::func_81D0);
  level.var_3670 thread func_0BB6::func_3966(1, 1, level.var_12B67);
  level.var_3670 func_BAF7();
  level.var_12B67 thread func_0BB6::func_3966(1, 1, level.var_3670);
  func_137E2("ret_ram");
  thread func_DC50();
  level.var_3670 func_0BB6::func_3967();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.var_111D0.mons_warp_angles, 10);
  func_137E2("boost_start");
  func_0BDC::func_A0BE(1);
  func_0BDC::func_A38E(5, 5, 5, 3);
  func_137E2("swap_mons_geo");
  func_11311();
  func_137E2("boost_end");
  func_0BDC::func_A0BE(0);
  func_137E2("salter_hover");
  level.var_EA99 func_0BDC::func_6B4C("hover");

  if(isDefined(level.var_D127.var_58B6)) {
    level.var_D127.var_58B6 ghostattack(0, 1);
    level.player clearsoundsubmix();
    level.var_D127.var_58B6 scripts\engine\utility::delaycall(1, ::stoploopsound, "jackal_plr_locked_lp");
  }

  thread func_104D0();
  thread func_A807();
  func_137E2("player_stopped");
  thread func_CF49();
  level.var_12B7D thread func_FA63();
  func_D30F();
  func_137E2("tigris_missiles");

  if(scripts\engine\utility::is_true(level.var_3670.var_7479)) {
    _killfxontag(level._effect["vfx_vehicle_mons_warp_out_ftldrive_core"], level.var_3670, "TAG_ORIGIN");
  }

  thread func_DC4B();
  func_137E2("mons_ftl");
  level.var_3670 func_0BB8::func_3991();
  level.var_3670 func_0BB6::func_39E1();
  level.var_3670.cannon delete();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.var_111D0.var_A7D8, 10);
  level.var_12B67 func_0BB6::func_39F1();
  level.var_12B67 func_0BB6::func_3967();
  level notify("mons_ftl_out");
  thread func_CF48();
  level.player playrumbleonentity("damage_heavy");
  earthquake(0.3, 1.3, level.var_D127.origin, 20000);
  _setmusicstate("");
  _killfxontag(scripts\engine\utility::getfx("mons_damage_linger"), level.var_3670.var_4CF6, "tag_origin");
  func_D25B();
  func_137E2("player_land");
  scripts\engine\utility::flag_set("flag_player_land");
  level.var_3670.var_4CF6 delete();
  level.var_D127.var_6E93 = 1.0;
  level.var_D127.var_6E97 = 1.0;
}

func_D30F() {
  level.var_D299 func_0BDC::func_D29B(0, 4);
  func_0BDC::func_A302(0.35);
  func_0BDC::func_D16C(level.var_D299.var_BCDA, 0.25, 0.4, 0);
  func_0BDC::func_D190(1);
  func_0BDC::func_A14A();
  func_0BDC::func_A155();
}

func_D25B() {
  var_0 = 2;
  func_0BDC::func_D164(level.var_D299.var_BCDA, var_0);
  wait(var_0);
  func_0BDC::func_A38E(25, 5, 5, 3);
  func_0BDC::func_D16C(level.var_D299.var_BCDA, 0, 1, 0);
}

func_DC50() {
  thread func_BACA();
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_initial_impact"), level.var_DC56, "tag_vfx_000");
  level.var_DC56 playSound("phspace_mons_collide_pt1");
  earthquake(0.39, 2.9, level.var_D127.origin, 20000);
  level.player playrumbleonentity("damage_heavy");
  func_137E2("vfx_ram_drag_start");
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_drag_churn_debris"), level.var_DC56, "tag_vfx_001");
  func_137E2("tower_break");
  thread func_DC55();
  func_137E2("vfx_ram_drag_end");
  stopFXOnTag(scripts\engine\utility::getfx("ret_ram_drag_churn_debris"), level.var_DC56, "tag_vfx_001");
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_drag_end"), level.var_DC56, "tag_vfx_001");
  func_137E2("vfx_ram_slam_start");
  thread func_E313();
  thread func_E312();
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_slam_churn_debris"), level.var_DC56, "tag_vfx_002");
  func_137E2("vfx_ram_slam_end");
  level notify("stop_slam_quakes");
  stopFXOnTag(scripts\engine\utility::getfx("ret_ram_slam_churn_debris"), level.var_DC56, "tag_vfx_002");
}

func_BACA() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = level.var_DC56.origin;
  var_0.angles = level.var_3670.angles;
  var_0 linkto(level.var_3670);
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_mons_impact"), var_0, "tag_origin");
  wait 5;
  var_0 delete();
}

func_E313() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkto(level.var_DC56, "tag_vfx_002", (0, 0, 0), (0, 0, 0));
  var_0 playSound("phspace_mons_collide_pt2", "sound_done");
  var_0 waittill("sound_done");
  var_0 delete();
}

func_E312() {
  level endon("stop_slam_quakes");
  earthquake(0.25, 1.2, level.var_D127.origin, 20000);
  wait 0.3;

  for(;;) {
    earthquake(0.25, 0.4, level.var_D127.origin, 20000);
    wait(randomfloatrange(0.1, 0.2));
  }
}

func_BAB7(var_0, var_1, var_2) {
  thread func_BAB9(var_0, var_1, var_2);
}

func_BAB9(var_0, var_1, var_2) {
  var_3 = 0.25;
  var_4 = 1.75;
  var_5 = 250000;

  if(isDefined(var_2) && var_2) {
    var_6 = undefined;
  } else {
    var_6 = var_0;
  }

  level.var_3670 thread func_BA7E(var_6);
  wait 3;

  if(isDefined(var_0)) {
    var_0 func_81D0();
    thread func_BAB8(var_0.origin);
  }

  if(isDefined(var_1)) {
    earthquake(var_1, 1, level.var_D127.origin, 10000);
  }
}

func_BAB8(var_0) {
  wait 0.1;
  func_0BDC::func_DBDC(var_0, 0.35, 5000, 60000, undefined, 0.1, 1.6, 1);
}

func_1F93() {
  func_137E2("missile_volley_1");
  func_137E2("missile_volley_2");
  level.var_3670 thread func_0BB6::func_39A1(level.var_3670.var_8B45["center"], 5);
  func_137E2("missile_volley_3");
  level.var_3670 thread func_0BB6::func_39A1(level.var_3670.var_8B45["right_4"], 5);
  func_137E2("missile_volley_4");
}

func_1F97() {
  var_0 = func_137E2("target_turret_group_1");

  if(!var_0) {
    thread func_0BB6::func_39CF(level.var_3670.var_12A39["one"]);
    thread func_126FB(level.var_3670.var_12A39["one"]);
  }

  var_0 = func_137E2("target_turret_group_2");

  if(!var_0) {
    thread func_0BB6::func_39C2(level.var_3670.var_12A39["one"]);
    thread func_0BB6::func_39CF(level.var_3670.var_12A39["two"]);
    thread func_126FB(level.var_3670.var_12A39["two"]);
  }

  var_0 = func_137E2("target_turret_group_3");

  if(!var_0) {
    thread func_0BB6::func_39C2(level.var_3670.var_12A39["two"]);
    thread func_0BB6::func_39CF(level.var_3670.var_12A39["three"]);
    thread func_126FB(level.var_3670.var_12A39["three"]);
  }

  var_0 = func_137E2("ram_start");

  if(!var_0) {
    wait 5;
    level notify("stop_miniflak_for_player");
    func_D29E(4);
    thread func_0BB6::func_39C2(level.var_3670.var_12A39["three"]);
  }
}

func_1F91() {
  var_0 = func_137E2("start");

  if(!var_0) {
    scripts\sp\utility::func_DBF5();
    wait 2.2;
    scripts\sp\utility::func_10350("phspace_slt_holyshitwhatist");
    scripts\sp\utility::func_10350("phspace_plr_scarsdirectallf");
    wait 1.5;
    scripts\sp\utility::func_10350("phspace_plt2_ohshi");
    scripts\sp\utility::func_10350("phspace_plt1_36ishit36isdown");
    scripts\sp\utility::func_10350("phspace_plr_rogethanyouflyi");
    scripts\sp\utility::func_10350("phspace_eth_ayesir");

    if(!isDefined(level.var_D127.var_58B6)) {
      level.var_D127.var_58B6 = spawn("script_origin", level.var_D127.origin);
      level.var_D127.var_58B6 linkto(level.var_D127);
      level.var_D127.var_58B6 ghostattack(0);
    }

    level.var_D127.var_58B6 playLoopSound("jackal_plr_locked_lp");
    level.player setsoundsubmix("jackal_dogfight");
    level.var_D127.var_58B6 ghostattack(1, 1);
    thread scripts\sp\utility::func_10350("phspace_slt_raiderilltargetthe");
  }

  var_0 = func_137E2("plr_panamasdown");
  level.var_3670 func_0BA9::func_39C9();
  level.var_3670 func_0BB8::func_39C8();

  if(!var_0) {
    level.player func_82C0("phspace_kotch_pip", 0.25);
    func_A71B();
    level.player func_82C0("jackal_cockpit", 0.25);
    thread scripts\sp\utility::func_10350("phspace_slt_deploycounterm");
    thread func_12700("phspace_plr_flaresout");
  }

  var_0 = func_137E2("dialog_turrets_1");

  if(!var_0) {
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

  var_0 = func_137E2("dialog_turrets_2");

  if(!var_0) {
    thread scripts\sp\utility::func_10350("phspace_plr_targetthecannon12");
    wait 2;
    scripts\sp\utility::func_10350("phspace_slt_impactnoeffect");
    scripts\sp\utility::func_10350("phspace_gtr_allstationstarget");
  }

  var_0 = func_137E2("dialog_ram_exchange2");

  if(!var_0) {
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
    level.var_EA99 scripts\sp\utility::func_10346("phspace_slt_no");
    wait 0.5;
    scripts\sp\utility::func_10350("phspace_eth_flak");
    level.var_EA99 scripts\sp\utility::func_10346("phspace_slt_evadeevade");
    wait 1.2;
    thread scripts\sp\utility::func_10350("phspace_gtr_thisisretmultiplecasualties");
  }

  var_0 = func_137E2("dialog_mons_warp");

  if(!var_0) {
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

    if(!scripts\engine\utility::flag("player_jackal_drone_dock")) {
      scripts\sp\utility::func_10350("phspace_plr_roger2limaco");
    }

    if(!scripts\engine\utility::flag("player_jackal_drone_dock")) {
      scripts\sp\utility::func_10350("phspace_atc_holdforlockstan");
    }

    if(!scripts\engine\utility::flag("player_jackal_drone_dock")) {
      var_1 = 1;
    } else {
      var_1 = 0;
    }

    scripts\engine\utility::flag_wait("player_jackal_drone_dock");
    wait(var_1);
    wait 1.7;
    scripts\sp\utility::func_10350("phspace_atc_goodlockswellta");
    scripts\sp\utility::func_10350("phspace_plr_charliedeltacopy");
  }

  wait 2;
}

func_12700(var_0) {
  if(level.var_D127.var_6E9C.var_12B86.size > 0) {
    return;
  }
  level.var_D127 endon("missile_hit");

  while(level.var_D127.var_6E9C.var_12B86.size == 0) {
    wait 0.05;
  }

  scripts\sp\utility::func_10350(var_0);
}

func_1F95() {
  level.var_EA99.var_EF63 = 1000;
  level.var_EA99.var_EF62 = 300;
  level.var_EA99.var_EF5D = 1;
  func_137FF("missile_volley_1");
  level.var_EA99.var_EF5E = (0, 0, -200);
  thread func_102CE(4);
  func_137FF("missile_volley_2");
  thread func_102CE(4);
  func_137FF("missile_volley_3");
  thread func_102CE(6);
  func_137FF("missile_volley_4");
  thread func_102CE(4);
}

func_102CE(var_0) {
  level.var_EA99 func_0B76::func_1945(level.var_EAC0, ["tag_flash_right", "tag_flash_left"], var_0);
}

func_1F96() {
  func_137FF("scn_phsp_salt_trench_01");
  level.var_EA99 playSound("scn_phsp_salt_trench_01");
  func_137FF("scn_phsp_salt_trench_02");
  level.var_EA99 playSound("scn_phsp_salt_trench_02");
  func_137FF("scn_phsp_salt_trench_03");
  level.var_EA99 playSound("scn_phsp_salt_trench_03");
  func_137FF("scn_phsp_salt_trench_04");
  level.var_EA99 playSound("scn_phsp_salt_trench_04");
  func_137FF("scn_phsp_salt_trench_05");
  level.var_EA99 playSound("scn_phsp_salt_trench_05");
}

func_1F94() {
  var_0 = 1;
  var_1 = 4;
  level.var_EA46 makeentitysentient("axis", 0);
  level.var_EA99 func_0BDC::func_19B5(level.var_EA46);

  for(;;) {
    func_137FF("start_shooting_" + var_0);
    level.var_EA99 func_0BDC::func_19AE("shoot_forever");
    func_137FF("stop_shooting_" + var_0);
    level.var_EA99 func_0BDC::func_19AE("dont_shoot");
    var_0++;

    if(var_0 > var_1) {
      break;
    }
  }
}

func_126FB(var_0) {
  level notify("stop_miniflak_for_player");
  level endon("stop_miniflak_for_player");
  thread func_126FC();
  func_D2A8();

  for(;;) {
    var_1 = 1;
    var_2 = 0;

    foreach(var_4 in var_0) {
      if(!isDefined(var_4)) {
        continue;
      }
      var_5 = vectornormalize(var_4.origin - level.var_D127.origin);
      var_6 = vectordot(var_5, anglesToForward(level.var_D127.angles));

      if(var_6 < 0.3) {
        continue;
      }
      var_2 = 1;
      var_4 func_0BB6::func_399E("tag_flash", 0.7, 0, 0);

      if(var_1 == 1) {
        var_1 = 0;
        continue;
      }

      var_1 = 1;
      wait 0.05;
    }

    if(!var_2) {
      break;
    }
  }

  func_D29E();
  level notify("stop_miniflak_for_player");
}

func_126FC() {
  level endon("stop_miniflak_for_player");
  var_0 = 115;
  var_1 = 50;
  var_2 = 0.75;
  var_3 = 0.1;
  var_4 = 0.3;
  level.var_12706 = 1;

  for(;;) {
    var_5 = scripts\sp\math::func_6A8E(var_0, var_1, level.var_12706);
    var_6 = randomfloatrange(50, 1000);
    var_7 = randomfloatrange(-500, 500);
    var_8 = randomfloatrange(-500, 0);
    var_6 = var_6 * anglesToForward(level.var_D127.angles);
    var_7 = var_7 * anglestoright(level.var_D127.angles);
    var_8 = var_8 * anglestoup(level.var_D127.angles);
    var_9 = level.var_D127.origin + var_6 + var_7 + var_8;
    level.var_D127 getrandomarmkillstreak(var_5, var_9, undefined, undefined, "MOD_IMPACT");
    var_10 = scripts\sp\math::func_6A8E(var_3, var_2, level.var_12706);
    var_10 = randomfloatrange(var_10 * (1 - var_4), var_10 * (1 + var_4));
    wait(var_10);
  }
}

func_126FD() {
  level endon("stop_tracking_player_fire");
  level.var_D127 endon("scripted_death");
  var_0 = 1.0;
  var_1 = 0.02;
  level.var_12706 = 1;
  var_2 = 0;

  for(;;) {
    _setsaveddvar("spaceshipTargetLockAnglesScale", 1.1);

    if(level.var_D127.var_4C15.var_9DF4) {
      if(level.var_D127.var_4C15.class == "secondary") {
        var_2 = 0.75;
      } else {
        var_2 = 0.05;
      }
    } else {
      var_2 = var_2 - 0.05;
    }

    if(var_2 > 0) {
      level.var_12706 = level.var_12706 + var_0;
    } else {
      level.var_12706 = level.var_12706 - var_1;
    }

    level.var_12706 = clamp(level.var_12706, 0, 1);
    wait 0.05;
  }
}

func_137E2(var_0) {
  var_1 = 0;
  var_2 = getanimlength(level.var_EC85["generic_mover"][level.var_D16B.var_1FAF]);
  var_3 = level.var_D16B islegacyagent(level.var_EC85["generic_mover"][level.var_D16B.var_1FAF]);
  var_3 = var_3 * var_2;
  var_4 = getnotetracktimes(level.var_EC85["generic_mover"][level.var_D16B.var_1FAF], var_0);
  var_4 = var_4[0] * var_2;
  var_5 = (var_4 - var_3) * (1 / level.var_1F5B);

  if(var_5 >= 0) {
    wait(var_5);
  } else {
    var_1 = 1;
  }

  return var_1;
}

func_137E3(var_0, var_1) {
  var_2 = 0;
  var_3 = getanimlength(level.var_EC85["generic_mover"][level.var_D16B.var_1FAF]);
  var_4 = level.var_D16B islegacyagent(level.var_EC85["generic_mover"][level.var_D16B.var_1FAF]);
  var_4 = var_4 * var_3;
  var_5 = getnotetracktimes(level.var_EC85["generic_mover"][level.var_D16B.var_1FAF], var_0);
  var_5 = var_5[0] * var_3;
  var_6 = (var_5 - var_4) * (1 / level.var_1F5B);

  if(var_6 >= 0) {
    wait(var_6);

    if(isDefined(var_1)) {
      var_1 thread scripts\sp\utility::func_10346("phspace_" + var_0);
    } else {
      thread scripts\sp\utility::func_10352("phspace_" + var_0);
    }
  }
}

func_137FF(var_0) {
  var_1 = 0;
  var_2 = getanimlength(level.var_EC85["generic_mover"][level.var_EAA5.var_1FAF]);
  var_3 = level.var_D16B islegacyagent(level.var_EC85["generic_mover"][level.var_D16B.var_1FAF]);
  var_3 = var_3 * var_2;
  var_4 = getnotetracktimes(level.var_EC85["generic_mover"][level.var_EAA5.var_1FAF], var_0);
  var_4 = var_4[0] * var_2;
  var_5 = (var_4 - var_3) * (1 / level.var_1F5B);

  if(var_5 >= 0) {
    wait(var_5);
  } else {
    var_1 = 1;
  }

  return var_1;
}

func_BAA0(var_0) {
  if(isDefined(var_0)) {
    var_1 = scripts\engine\utility::spawn_tag_origin();
    var_1.angles = self.angles;
    wait 0.05;
    self linkto(var_1, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_1 moveto(self.var_BCDA.origin, var_0, var_0 * 0.5, var_0 * 0.5);
    var_1 rotateto(self.var_BCDA.angles, var_0, var_0 * 0.5, var_0 * 0.5);
    wait(var_0);
    self unlink();
    var_1 delete();
  }

  self linkto(self.var_BCDA, "j_mainroot", (0, 0, 0), (0, 0, 0));
}

func_1EC5(var_0) {
  thread scripts\sp\anim::func_1F35(var_0, var_0.var_1FAF);
  var_0 func_82B1(level.var_EC85["generic_mover"][var_0.var_1FAF], 0);
}

func_10712(var_0) {
  var_1 = scripts\sp\utility::func_10639("generic_mover");
  var_1 hide();
  var_1.var_1FAF = var_0;
  return var_1;
}

#using_animtree("jackal");

func_D1DE() {
  level notify("player_looks_at_ethan");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkto(level.var_D299.var_BCDA, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1 = scripts\sp\utility::func_107EA("eth3n_space", 1);
  var_1.var_1FBB = "eth3n";
  var_1 linkto(var_0);
  var_1 givegrabscore(1);
  playFXOnTag(scripts\engine\utility::getfx("vfx_ethan_cockpit_light"), var_1, "tag_origin");
  thread func_0BDC::func_A2B0( % jackal_pilot_heist_mons_intro_lookback, % jackal_vehicle_heist_mons_intro_lookback, 0.2, 1);
  var_0 thread scripts\sp\anim::func_1F35(var_1, "eth3n_sitting");
  wait 3;
  thread func_D12E();
  wait 5;
  var_0 delete();
  var_1 delete();
}

func_BA9F(var_0) {
  level.var_12B7D solid();
  level.var_12B67 solid();
  level.var_12B50 solid();
  level.var_12B51 solid();
  level.var_12B53 solid();
  level.var_12B54 solid();
  level.var_12B56 solid();
  level.var_12B7D func_1076A();
  level.var_12B50 func_1076A();
  level.var_12B51 func_1076A();
  level.var_12B53 func_1076A();
  level.var_12B54 func_1076A();
  level.var_12B55 func_1076A();
  level.var_12B56 func_1076A();
  level.var_12B7D.var_12FBA = 1;
  level.var_12B50.var_12FBA = 1;
  level.var_12B51.var_12FBA = 1;
  level.var_12B53.var_12FBA = 1;
  level.var_12B54.var_12FBA = 1;
  level.var_12B56.var_12FBA = 1;

  if(!var_0) {
    wait 0.5;
  }

  level.var_3670 thread func_0BB6::func_39E5("front_left", level.var_12B50);
  level.var_3670 thread func_0BB6::func_39E5("back_left", level.var_12B56);
  level.var_3670 thread func_0BB6::func_39E5("front_right", level.var_12B51);
  level.var_3670 thread func_0BB6::func_39E5("back_right", level.var_12B54, level.var_12B7D);
  wait 0.05;
  level.var_3670 thread func_0BB6::func_399C("left_1", level.var_12B50);
  level.var_3670 thread func_0BB6::func_399C("left_2", level.var_12B50);
  wait 0.05;
  level.var_3670 thread func_0BB6::func_399C("right_1", level.var_12B51);
  level.var_3670 thread func_0BB6::func_399C("right_2", level.var_12B51);

  if(!var_0) {
    wait 2.5;
  }

  level.var_12B50 thread func_0BB6::func_3966(1, 1, level.var_3670);
  level.var_12B51 thread func_0BB6::func_3966(1, 1, level.var_3670);

  if(!var_0) {
    wait 0.2;
  }

  level.var_12B53 thread func_0BB6::func_3966(1, 1, level.var_3670);
  level.var_12B7D thread func_0BB6::func_3966(1, 1, level.var_3670);

  if(!var_0) {
    wait 0.1;
  }

  level.var_12B54 thread func_0BB6::func_3966(1, 1, level.var_3670);
  level.var_12B55 thread func_0BB6::func_3966(1, 1, level.var_3670);

  if(!var_0) {
    wait 0.15;
  }

  level.var_12B56 thread func_0BB6::func_3966(1, 1, level.var_3670);
}

func_EA47() {
  level endon("olympus_almost_arrived");
  scripts\engine\utility::flag_wait("jackal_sees_ret_for_landing");
  scripts\sp\utility::func_10350("phspace_slt_gotavisualonret");
}

func_BAAF() {
  var_0 = level.var_D299.origin;
  var_1 = level.var_D299.angles;
  var_2 = (-2000, 300, 400);
  var_3 = anglesToForward(level.var_D299.angles) * var_2[0] + anglestoright(level.var_D299.angles) * var_2[1] + anglestoup(level.var_D299.angles) * var_2[2];
  level.var_EA99 delete();
  scripts\sp\maps\phspace\phspace::func_107C0();
  level.var_EA99 func_0BDC::func_1990(0);
  level.var_EA99 func_0BDC::func_19A2();
  level.var_EA99 vehicle_teleport(var_0 + var_3, var_1);
  level.var_EA99 func_0BDC::func_A1EC(var_0 + var_3, 1, 500, var_1);
  wait 1;
  var_2 = (2000, 500, 300);
  var_3 = anglesToForward(level.var_D299.angles) * var_2[0] + anglestoright(level.var_D299.angles) * var_2[1] + anglestoup(level.var_D299.angles) * var_2[2];
  var_4 = level.var_D299.origin + var_3;
  level.var_EA99 func_0BDC::func_A1EC(var_4, 1, 40, var_1);
}

func_ACEC() {
  for(;;) {
    wait 0.05;
  }
}

func_BA9C() {
  var_0 = level.var_D299.origin;
  var_1 = level.var_D299.angles;
  var_2 = (-2000, -300, 100);
  var_3 = anglesToForward(level.var_D299.angles) * var_2[0] + anglestoright(level.var_D299.angles) * var_2[1] + anglestoup(level.var_D299.angles) * var_2[2];
  level.var_1CB9 delete();
  scripts\sp\maps\phspace\phspace::func_1062E();
  level.var_1CB9 vehicle_teleport(var_0 + var_3, var_1);
  level.var_1CB9 func_0BDC::func_19A2();
  level.var_1CB9 func_0BDC::func_19AB(500);
  level.var_1CB9 func_0BDC::func_6B4C("boost_mode");
  var_4 = scripts\engine\utility::getstruct("ally1_flyto_mons", "targetname");
  level.var_1CB9 thread func_0BDC::func_A1EC(var_4.origin, 0);
  wait 3.2;
  level.var_1CB9.var_9930 = 1;
  level.var_1CB9 notify("death");
}

func_96EC() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 func_0BDC::func_D2A5();
  level.var_D299 thread func_0BDC::func_D2A0(level.var_D16B.var_11512, (0, 0, 0), 500, 0.2, 0.5, 0.5);
  level.var_D299 thread func_0BDC::func_D2A7();
}

func_D2A8(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  func_0BDC::func_A38E(25, 3, 0.55, var_0);
  level.var_D299 thread func_0BDC::func_D29A(level.var_D16B.var_11512, var_0, undefined, undefined, undefined, undefined, 0.012, undefined, 5);
}

func_D29E(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 2;
  }

  func_0BDC::func_A38E(25, 3, 0.65, var_0);
  level.var_D299 thread func_0BDC::func_D29A(level.var_D16B.var_11512, var_0, undefined, undefined, undefined, undefined, 0.5, undefined, 1);
}

func_BA82() {
  wait 0.0;
  level.var_D127 func_0BDC::func_D164(level.var_D299.var_BCDA, 3);
  level.var_D127.var_A56F = 1;
  func_0BDC::func_A153();
  thread func_DAEE();
  thread func_D083();
  earthquake(0.53, 2.8, level.var_D127.origin, 40000);
  level.player playrumbleonentity("damage_heavy");
  func_0BDC::func_A38E(35, 5, 5, 0.5);
  level.player func_8497();
  thread func_A1E2();
  thread func_0BDC::func_A287(0.2);
}

func_DAEE() {
  var_0 = 0.4;
  thread func_0BD9::func_D176(0.7, 0, var_0, 0.05, 0.8);
  wait(var_0);
  thread func_0BD9::func_D176(0.0, 0, 6.5, 0.01, 0.3);
}

func_A1E2() {
  earthquake(0.4, 1.3, level.var_D127.origin, 20000);
  level.var_D127 thread func_0BDD::func_6186(5, 0.4);
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
  level.var_D127 thread func_0BDB::func_BBE0();
  wait 0.5;
  level.player func_8497();
  thread func_0BDC::func_A388(0.2);
  func_0BDC::func_A153(0);
}

func_D17C() {
  level.var_D127.var_13BF7.weapon = "spaceship_30mm_projectile_large_radius";

  if(level.var_D127.var_4C15 == level.var_D127.var_13BF7) {
    level.var_D127 func_849E(level.var_D127.var_13BF7.weapon);
  }
}

func_BA80() {
  var_0 = [level.var_EA99, level.var_1CB9];

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
    var_2 linkto(var_3);
    var_3 func_BA83();
    var_2 func_0BDC::func_19A0(1);
    var_2 func_0BDC::func_A167();
    var_2 func_0BDC::func_6B4C("none", 1);
  }
}

func_BA83(var_0) {
  var_1 = 22000;
  var_2 = (179, 179, 179);
  var_3 = getvehiclenode("ca_olympus_last_pos", "targetname");
  var_4 = self.origin - var_3.origin;
  var_5 = length(var_4);
  var_6 = scripts\sp\math::func_C097(5000, 80000, var_5);
  var_7 = scripts\sp\math::func_6A8E(var_1, 0, var_6);
  var_8 = scripts\sp\math::func_6A8E(0.1, 0.6, var_6);
  var_9 = vectornormalize(var_4);
  self.var_528E = self.origin + var_9 * var_7;
  wait(var_8);
  self unlink();
  self moveto(self.var_528E, 5, 0.5, 4.5);

  if(isDefined(var_0)) {
    self.var_5289 = var_0;
  } else {
    var_2 = var_2 * (1 - var_6);
    self.var_5289 = self.angles + var_2;
  }

  self rotateto(self.var_5289, 13.0, 1.3, 11.7);
}

func_BAA3() {
  level.var_D127.var_1FBB = "player_jackal";
  scripts\sp\utility::func_10350("phspace_plr_squadronthisis");
  scripts\sp\utility::func_10350("phspace_plt1_copy34returnin");
  thread func_EA47();

  if(!scripts\engine\utility::flag("olympus_almost_arrived")) {
    scripts\sp\utility::func_10350("phspace_plt2_36isrtb");
  }

  if(!scripts\engine\utility::flag("olympus_almost_arrived")) {
    scripts\sp\utility::func_10350("phspace_slt_letsregroupfuelu");
  }

  if(!scripts\engine\utility::flag("olympus_almost_arrived")) {
    scripts\sp\utility::func_10350("phspace_tao_allstationstaog");
  }

  scripts\engine\utility::flag_wait("olympus_almost_arrived");
  scripts\sp\utility::func_10350("phspace_plt1_imgettingsomea");

  if(!scripts\engine\utility::flag("olympus_arrived")) {
    scripts\sp\utility::func_10350("phspace_plt2_samecheckingsta");
  }

  scripts\engine\utility::flag_wait("olympus_arriving");
  _setmusicstate("mx_082_ph_mons_combat");
}

func_137FD() {
  var_0 = getent("trigger_safe_to_return", "targetname");
  var_0 func_0BDC::func_136A6(level.var_D127);
}

func_50BF(var_0) {
  wait(var_0);

  if(isDefined(self) && isalive(self)) {
    if(func_0B76::func_7A60(self.origin) < 0.7 && !scripts\engine\utility::cointoss()) {
      self delete();
    } else {
      self func_81D0();
    }
  }
}

func_BACF(var_0) {
  for(var_1 = 6; var_1 > 0; var_1 = var_1 - 1) {
    thread func_6D0B(var_0);
    wait(randomfloatrange(0.08, 0.25));
  }
}

func_6D0B(var_0) {
  var_1 = self.angles;
  var_1 = invertangles(var_1);
  var_2 = [];
  var_2[var_2.size] = "amb_missile_l_1";
  var_2[var_2.size] = "amb_missile_l_2";
  var_2[var_2.size] = "amb_missile_l_3";
  var_2[var_2.size] = "amb_missile_l_4";
  var_2[var_2.size] = "amb_missile_r_1";
  var_2[var_2.size] = "amb_missile_r_2";
  var_2[var_2.size] = "amb_missile_r_3";
  var_2[var_2.size] = "amb_missile_r_4";
  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_4 = scripts\engine\utility::random(var_2);
  var_3.origin = self gettagorigin(var_4);
  var_3.angles = self gettagangles(var_4);
  var_5 = randomfloatrange(300, 500);
  var_6 = (0, 0, 0);
  var_7 = var_0;
  var_3 thread func_0B76::func_A332(var_7, 1, level.var_F04E, undefined, var_5, var_6, undefined, undefined, 500, 1, 1.0, 1);
  wait 0.6;
  wait(randomfloatrange(0.2, 0.75));
  var_8 = scripts\engine\utility::spawn_tag_origin();
  var_4 = scripts\engine\utility::random(var_2);
  var_8.origin = self gettagorigin(var_4);
  var_8.angles = self gettagangles(var_4);
  var_8 thread func_0B76::func_A332(var_7, 1, level.var_F04E, undefined, var_5, var_6, undefined, undefined, 50, 1, 1.0, 1);
}

func_54FC() {
  var_0 = [level.var_12B7D, level.var_12B67, level.var_12B4A, level.var_12B4C, level.var_12B60, level.var_12B61];

  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 func_0BB6::func_398A(0);
    }
  }
}

func_BAA1() {
  thread func_BAA2();
}

func_BAA2() {}

func_12705() {
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.var_111D0.var_BA9E, 0);
  scripts\sp\maps\phspace\phspace::func_107C0();
  level.var_EA99 func_0BDC::func_6B4C("space", 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_F5A4();
  var_0 = scripts\sp\vehicle::func_1080C("player_jackal");
  var_1 = scripts\engine\utility::getstruct("trench_run_start", "targetname");
  var_2 = scripts\engine\utility::getstruct("salter_trench_run_start", "targetname");
  level.var_EA99 func_0BDC::func_19A2();
  level.var_EA99 vehicle_teleport(var_2.origin, var_2.angles);
  level.var_EA99 func_0BDC::func_A1EC(var_2.origin, 1, 50, var_2.angles);
  func_0BDC::func_10CD1(var_0, var_1);
  thread scripts\sp\maps\phspace\phspace_battle::func_D868();
  thread scripts\sp\maps\phspace\phspace_battle::func_12B5F();
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\maps\phspace\phspace_battle::func_FE2F();
  func_1F90();

  if(!isDefined(level.var_D127.var_58B6)) {
    level.var_D127.var_58B6 = spawn("script_origin", level.var_D127.origin);
    level.var_D127.var_58B6 linkto(level.var_D127);
    level.var_D127.var_58B6 ghostattack(0);
  }

  level.var_D127.var_58B6 playLoopSound("jackal_plr_locked_lp");
  level.player setsoundsubmix("jackal_dogfight");
  level.var_D127.var_58B6 ghostattack(1, 1);
  func_96EC();
  level.var_D299.origin = var_1.origin;
  level.var_D299.angles = var_1.angles;
  func_0BDC::func_D164(level.var_D299.var_BCDA, 0.0);
  level.var_D127.var_A56F = 1;
  func_1F98("salter_go");
  func_1F8F();
}

func_126F9() {
  scripts\sp\utility::func_266A("jackal_trenchrun");

  if(!isDefined(level.var_D299)) {
    wait 1;
  }

  if(!scripts\engine\utility::flag_exist("retribution_ram")) {
    wait 0.05;
  }

  scripts\engine\utility::flag_wait("retribution_ram");
}

func_12702() {
  wait 2;
  level.var_EA99 func_0BDC::func_6B4C("hover");
  level.var_EA99 linkto(level.var_EAA5, "j_mainroot", (0, 0, 0), (0, 0, 0));
}

func_4968(var_0) {
  var_1 = (1, 1, 1);
  var_2 = 15;
  var_3 = 0;

  for(var_4 = []; var_3 < var_2; var_3++) {
    var_4[var_3] = ::scripts\sp\maps\phspace\phspace_battle::func_491E(level.var_3670, randomfloatrange(-8000, 8000), randomfloatrange(-8000, 8000), randomfloatrange(-8000, 8000), 1, "1", var_1, var_0);
  }

  return var_4;
}

func_EAC5(var_0) {
  level.var_EA99 endon("arrived_at_animation");
  var_1 = getanimlength(level.var_EC85["generic_mover"][level.var_D16B.var_1FAF]);
  var_2 = 300;
  var_3 = 4;
  var_4 = 1;
  var_5 = 300;

  for(;;) {
    level.var_EA99 thread func_0BDC::func_A1EC(level.var_EAA5.origin, 0, 0);
    var_6 = level.var_D16B islegacyagent(level.var_EC85["generic_mover"][level.var_D16B.var_1FAF]);
    var_6 = var_6 * var_1;
    var_7 = getnotetracktimes(level.var_EC85["generic_mover"][level.var_D16B.var_1FAF], "link_salter");
    var_7 = var_7[0] * var_1;
    var_8 = var_7 - var_6;

    if(var_8 < 0) {
      break;
    }
    var_9 = distance(level.var_EA99.origin, level.var_D16B.origin);
    var_10 = var_9 / var_8;
    var_10 = scripts\engine\utility::ips_to_mph(var_10);
    var_11 = scripts\sp\math::func_C097(var_4, var_3, var_8);
    var_12 = scripts\sp\math::func_6A8E(0, var_2, var_11);
    var_13 = var_10 + var_12;
    var_13 = clamp(var_13, 0, var_5);
    level.var_EA99 func_0BDC::func_19AB(var_13, 1000);
    wait 0.05;
  }
}

func_AB73(var_0, var_1) {}

func_126F8() {}

func_DC53() {
  scripts\sp\maps\phspace\phspace::func_107C0();
  level.var_EA99 func_0BDC::func_6B4C("space", 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_F5A4();
  var_0 = scripts\sp\vehicle::func_1080C("player_jackal");
  var_1 = scripts\engine\utility::getstruct("ram_start", "targetname");
  var_2 = scripts\engine\utility::getstruct("salter_ram_start", "targetname");
  level.var_EA99 func_0BDC::func_19A2();
  level.var_EA99 vehicle_teleport(var_2.origin, var_2.angles);
  level.var_EA99 func_0BDC::func_A1EC(var_2.origin, 1, 50, var_2.angles);
  func_0BDC::func_10CD1(var_0, var_1);
  thread scripts\sp\maps\phspace\phspace_battle::func_D868();
  thread scripts\sp\maps\phspace\phspace_battle::func_12B5F();
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\maps\phspace\phspace_battle::func_FE2F();
  func_1F90();

  if(!isDefined(level.var_D127.var_58B6)) {
    level.var_D127.var_58B6 = spawn("script_origin", level.var_D127.origin);
    level.var_D127.var_58B6 linkto(level.var_D127);
    level.var_D127.var_58B6 ghostattack(0);
  }

  level.var_D127.var_58B6 playLoopSound("jackal_plr_locked_lp");
  level.player setsoundsubmix("jackal_dogfight");
  level.var_D127.var_58B6 ghostattack(1, 1);
  func_96EC();
  level.var_D299.origin = var_1.origin;
  level.var_D299.angles = var_1.angles;
  func_0BDC::func_D164(level.var_D299.var_BCDA, 0.0);
  level.var_3670 func_F051(1);
  func_1F98("ram_start");
  func_1F8F();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.var_111D0.var_DC4C, 0);
}

func_DC51() {
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\utility::func_266A("ram");

  while(!scripts\engine\utility::flag_exist("flag_player_land")) {
    wait 0.05;
  }

  scripts\engine\utility::flag_wait("flag_player_land");
}

func_DC55() {
  level.var_3670 detach("veh_mil_air_ca_olympus_mons_bridge", "TAG_ORIGIN");
  level.var_3670 attach("veh_mil_air_ca_olympus_mons_bridge_dmg", "TAG_ORIGIN");
  level.var_3672 show();
  playFXOnTag(scripts\engine\utility::getfx("mons_bridge_piece_explo"), level.var_3670, "tag_fx_debris");
  playFXOnTag(scripts\engine\utility::getfx("mons_bridge_piece_debris"), level.var_3672, "tag_fx_debris");
}

func_DC4B() {
  thread func_DC54();
  thread func_DC52();
}

func_DC52() {}

func_DC54() {
  var_0 = func_4968((-2000, -3000, 2100));
  level.var_12B7D thread scripts\sp\maps\phspace\phspace_battle::func_B7F9(var_0, 2500);
  level.player playSound("scn_phspace_mons_ftl_out");
  wait 2.5;
  var_0 = func_4968((0, 0, 2100));
  level.var_12B7D thread scripts\sp\maps\phspace\phspace_battle::func_B7F9(var_0, 2500);
}

func_DC4D() {
  thread func_DC4E();
}

func_DC4E() {}

func_A82E() {
  scripts\engine\utility::flag_init("ret_mover_init");
  scripts\sp\maps\phspace\phspace::func_107C0();
  level.var_EA99 func_0BDC::func_6B4C("space", 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_F5A4();
  var_0 = scripts\sp\vehicle::func_1080C("player_jackal");
  var_1 = scripts\engine\utility::getstruct("landing_start", "targetname");
  var_2 = scripts\engine\utility::getstruct("salter_landing_start", "targetname");
  level.var_EA99 func_0BDC::func_19A2();
  level.var_EA99 vehicle_teleport(var_2.origin, var_2.angles);
  level.var_EA99 func_0BDC::func_A1EC(var_2.origin, 1, 50, var_2.angles);
  func_0BDC::func_10CD1(var_0, var_1);
  thread scripts\sp\maps\phspace\phspace_battle::func_D868();
  var_3 = getvehiclenode("retribution_landing_pos", "targetname");
  level.var_12B67 vehicle_teleport(var_3.origin, var_3.angles);
  func_A830();
  var_4 = getvehiclenode("tigris_landing_flyby", "targetname");
  level.var_12B7D scripts\sp\vehicle::func_2471(var_4);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.var_111D0.var_A7D8, 0);
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
  level.var_D127.var_A56F = 0;

  if(scripts\engine\utility::flag_exist("ret_mover_init")) {
    scripts\engine\utility::flag_wait("ret_mover_init");
  }
}

func_A7F7() {
  level endon("olympus_almost_arrived");
  level endon("player_jackal_drone_dock");
  var_0 = ["phspace_eth_weshouldretur", "phspace_slt_letsgetbacktot", "phspace_eth_wereclearedtol", "phspace_slt_theyllneedusdow"];
  var_1 = [8, 14, 16, 20];
  var_2 = 0;

  for(;;) {
    while(scripts\engine\utility::flag("jackal_landing_active")) {
      wait 0.1;
    }

    if(var_2 < 3) {
      wait(var_1[var_2]);
      scripts\sp\utility::func_10350(var_0[var_2], 2);

      if(var_2 < 3) {
        var_2 = var_2 + 1;
      }

      continue;
    }

    wait 20;
    var_3 = scripts\engine\utility::random(var_0);
    scripts\sp\utility::func_10350(var_3, 2);
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
  level.var_FD6E.var_E35D.origin = level.var_12B67.origin;
  level.var_FD6E.var_E35D.angles = level.var_12B67.angles;
  level.var_FD6E.var_E35D linkto(level.var_12B67);
  level.var_FD6E.var_E35D func_0B51::func_FDCB("show");
  level.var_FD6E.var_E35D func_0B51::func_FDCB("solid");
  level.var_12B67 func_8184();
  level.var_12B67 notsolid();
  level.var_12B67 func_0BB8::func_397C();
  scripts\sp\maps\phspace\phspace_battle::delete_ret_door_hack();
  scripts\engine\utility::flag_set("ret_swapped");
}

func_11311() {
  if(isDefined(level.var_3670)) {
    level.var_3670 detach("veh_mil_air_ca_olympus_mons", "TAG_ORIGIN");
    level.var_3670 attach("veh_mil_air_ca_olympus_mons_dmg", "TAG_ORIGIN");
    level.var_3670.var_4CF6 = scripts\engine\utility::spawn_tag_origin();
    level.var_3670.var_4CF6 linkto(level.var_3670, "tag_origin", (550, 5100, 4100), (0, 0, 0));
    playFXOnTag(scripts\engine\utility::getfx("mons_damage_linger"), level.var_3670.var_4CF6, "tag_origin");
  }

  level.var_FD6E.var_E35D setModel("veh_mil_air_un_retribution_dmg");
  level.var_FD6E.var_E35D.var_4CF6 = scripts\engine\utility::spawn_tag_origin();
  level.var_FD6E.var_E35D.var_4CF6 linkto(level.var_FD6E.var_E35D, "tag_origin", (14000, -1800, 800), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("ret_damage_linger"), level.var_FD6E.var_E35D.var_4CF6, "tag_origin");
}

func_A7DD() {
  thread func_A7DE();
}

func_A7DE() {}

func_FE2E() {
  var_0 = level.var_3662 func_0BA9::func_39AC();
  var_1 = level.var_3663 func_0BA9::func_39AC();
  var_2 = level.var_3664 func_0BA9::func_39AC();
  var_3 = level.var_3665 func_0BA9::func_39AC();
  level.var_52D1 = scripts\engine\utility::array_add(level.var_52D1, var_0);
  level.var_52D1 = scripts\engine\utility::array_add(level.var_52D1, var_1);
  level.var_52D1 = scripts\engine\utility::array_add(level.var_52D1, var_2);
  level.var_52D1 = scripts\engine\utility::array_add(level.var_52D1, var_3);
}

func_F051(var_0) {
  self.delay_warp_core = "show_warp_core";
  func_1076F();
  func_0BB6::func_39E1();
  func_1078C();
  wait 0.1;
  func_0BB8::func_39CD("off");
  func_0BB8::func_39D0("off");
  func_0BB8::func_39AE();
  self.var_129D9 = 1;
  wait 1.0;

  if(!isDefined(var_0)) {
    func_0BB8::func_397F(1, 1);
  }
}

func_1078C() {
  var_0 = "cannon_small_ca_mons";
  var_1 = "cannon_missile_ca_hardpoint";
  var_2 = ["amb_missile_l_1", "amb_missile_l_2", "amb_missile_r_1", "amb_missile_r_2"];
  var_3 = "";
  var_3 = var_3 + var_0 + " ";
  var_3 = var_3 + var_1;
  self.var_EEF9 = var_3;
  self.spawn_hidden_turrets = 1;
  func_0BB6::func_39E8();
  level.var_39DD["cannon_small_ca_mons"].var_10241.var_10943 = ::func_BA6C;
  wait 0.05;
  self.var_CA99 = 1;
  level.var_C214 = -1;
  thread scripts\sp\maps\phspace\phspace_battle::func_FA45();
  thread func_6D19();
  thread func_0BB6::func_39EF();
  thread func_C418();
  wait 0.1;
  thread func_BAF5();
  thread func_FA70();
  level.var_39DD["cannon_small_ca_mons"].var_4D1E.fx.death = "vfx_cap_turret_death_sm_fast";
  level.var_39DD["cannon_large_ca"].var_4D1E.fx.death = "vfx_cap_turret_death_lrg_fast";
  level.var_39DD["cannon_missile_ca_hardpoint"].var_4D1E.fx.death = "vfx_cap_turret_death_smt_fast";
  thread func_E02C();
}

func_E02C() {
  wait 2.0;

  foreach(var_1 in self.turrets["cap_turret_small_constant"]) {
    if(var_1.var_AD42 == "amb_turret_sml_l_5" || var_1.var_AD42 == "amb_turret_sml_r_5" || var_1.var_AD42 == "amb_turret_sml_l_6" || var_1.var_AD42 == "amb_turret_sml_r_6") {
      var_1 delete();
    }
  }
}

func_4496(var_0) {
  var_1 = "";

  foreach(var_3 in var_0) {
    var_1 = var_1 + "," + var_3;
  }

  return var_1;
}

func_BA6C(var_0) {
  if(self.var_114FB == level.var_D127 || self.var_1DF8 == level.var_D127) {
    if(soundexists("capitalship_cannon_fire")) {
      self playSound("capitalship_cannon_fire");
    }

    self shootturret(var_0);
  } else {
    var_1 = level.var_39DD["cannon_small_ca_mons"];
    var_2 = func_0BB6::func_12A36(var_0);
    var_3 = func_0BB6::func_12A37(var_0, var_2);
    var_2 = anglesToForward(var_2);
    self thread[[var_1.var_10241.var_AF57]](var_3, var_2, var_0);
    var_4 = var_1.var_4D1E.fx;
  }
}

func_C418() {
  wait 0.1;

  foreach(var_1 in self.turrets) {
    foreach(var_3 in var_1) {
      var_3.health = 10;
    }
  }
}

func_1076A() {
  func_0BB6::func_39E1();
  self.var_EEF9 = "cannon_large_un missile_tube_un";
  func_0BB6::func_39E8();
  wait 0.1;
  func_0BB8::func_39CD("idle");
  func_0BB8::func_39D0("idle");
  func_0BB8::func_39AE();
}

func_6D19() {
  var_0 = self.turrets["cap_turret_phalanx"];

  if(!isDefined(var_0) || var_0.size == 0) {
    return;
  }
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 thread func_6D1A();
    }
  }
}

func_6D1A() {
  self.var_C841 endon("death");
  self.var_C841 endon("ftl_out");
  self endon("death");

  for(;;) {
    func_0BB6::func_11547();
    wait(randomfloatrange(0.1, 0.8));
  }
}

func_BAF7() {
  level notify("end_mons_turrets_target_player");

  foreach(var_5, var_1 in self.turrets) {
    if(var_5 == "cap_turret_phalanx") {
      continue;
    }
    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }
      var_3.var_114FB = var_3.var_1DF8;
      var_3.var_D92F = undefined;

      if(isDefined(var_3.var_1DF8)) {
        var_3 settargetentity(var_3.var_1DF8, (0, 0, 0));
      }
    }
  }

  level.var_D127.var_BAEF delete();
}

func_BAF5() {
  var_0 = anglesToForward(level.var_D127.angles);
  var_1 = anglestoup(level.var_D127.angles);
  var_2 = spawn("script_origin", level.var_D127.origin + var_0 * 750 + var_1 * 350);
  var_2.angles = level.var_D127.angles;
  level.var_D127.var_BAEF = var_2;
  level.var_D127.var_BAEF linkto(level.var_D127);

  foreach(var_8, var_4 in self.turrets) {
    if(var_8 == "cap_turret_phalanx") {
      continue;
    }
    foreach(var_6 in var_4) {
      var_6 thread func_BAF6();
    }
  }
}

func_BAF6() {
  self endon("death");
  level endon("end_mons_turrets_target_player");
  var_0 = 900000000;
  var_1 = 0.75;

  for(;;) {
    var_2 = distancesquared(level.var_D127.origin, self.origin);
    var_3 = func_0B76::func_7A60(self.origin);

    if(var_2 < var_0 && var_3 > var_1) {
      var_4 = level.var_D127.var_BAEF;
      self.var_114FB = var_4;
      self.var_D92F = var_4;
      self settargetentity(var_4, (0, 0, 0));
    } else if(isDefined(self.var_D92F)) {
      self.var_114FB = self.var_1DF8;
      self.var_D92F = undefined;

      if(isDefined(self.var_1DF8)) {
        self settargetentity(self.var_1DF8, (0, 0, 0));
      }

      self notify("stop_debug_line_loop");
    }

    wait 0.05;
  }
}

func_FA63() {
  func_0BB6::func_39E1();
  self.var_EEF9 = "cannon_large_un cannon_missile_ca_hardpoint";
  func_0BB6::func_39E8();
}

func_FA70() {
  var_0 = ["amb_turret_sml_l_5", "amb_turret_sml_l_6", "amb_turret_l_1", "amb_turret_l_2", "amb_turret_sml_l_2", "amb_turret_sml_l_3", "amb_turret_sml_l_4", "amb_turret_sml_l_7", "amb_turret_l_3", "amb_turret_l_4", "amb_turret_sml_l_8", "amb_turret_sml_l_10", "amb_turret_l_5", "amb_turret_l_6", "amb_turret_l_4", "amb_turret_sml_l_9", "amb_turret_sml_l_11", "amb_turret_sml_l_12", "amb_turret_l_7", "amb_turret_l_8", "amb_turret_l_9", "amb_turret_sml_l_13"];
  var_1 = ["amb_turret_r_5", "amb_turret_r_6", "amb_turret_sml_r_7", "amb_turret_sml_r_9", "amb_turret_sml_r_10", "amb_turret_r_4", "amb_turret_sml_r_8", "amb_turret_r_3", "amb_turret_r_7", "amb_turret_sml_r_2", "amb_turret_sml_r_3", "amb_turret_r_1", "amb_turret_r_2", "amb_turret_sml_r_4", "amb_turret_r_8", "amb_turret_r_9", "amb_turret_r_10", "amb_turret_r_11", "amb_turret_r_12", "amb_turret_r_13", "amb_turret_r_14", "amb_turret_r_15"];
  var_2 = ["amb_turret_sml_r_11", "amb_turret_sml_r_12", "amb_turret_sml_r_13", "amb_turret_sml_r_14", "amb_turret_sml_r_15", "amb_turret_sml_r_16", "amb_turret_sml_r_17", "amb_turret_sml_r_18"];
  self.var_12A39["one"] = [];
  self.var_12A39["two"] = [];
  self.var_12A39["three"] = [];

  foreach(var_4 in self.turrets) {
    foreach(var_6 in var_4) {
      if(isDefined(var_6)) {
        if(scripts\engine\utility::array_contains(var_0, var_6.var_AD42)) {
          self.var_12A39["one"][self.var_12A39["one"].size] = var_6;
          continue;
        }

        if(scripts\engine\utility::array_contains(var_1, var_6.var_AD42)) {
          self.var_12A39["two"][self.var_12A39["two"].size] = var_6;
          continue;
        }

        if(scripts\engine\utility::array_contains(var_2, var_6.var_AD42)) {
          self.var_12A39["three"][self.var_12A39["three"].size] = var_6;
        }
      }
    }
  }

  self.var_8B45["left_1"] = [];
  self.var_8B45["left_2"] = [];
  self.var_8B45["left_3"] = [];
  self.var_8B45["left_4"] = [];
  self.var_8B45["right_1"] = [];
  self.var_8B45["right_2"] = [];
  self.var_8B45["right_3"] = [];
  self.var_8B45["right_4"] = [];
  self.var_8B45["center"] = [];
  var_9 = 10;

  foreach(var_11 in self.var_8B4F) {
    foreach(var_13 in var_11) {
      if(isDefined(var_13)) {
        if(scripts\engine\utility::array_contains(self.var_8B46["left_1"], var_13.var_AD42)) {
          self.var_8B45["left_1"][self.var_8B45["left_1"].size] = var_13;
        } else if(scripts\engine\utility::array_contains(self.var_8B46["right_1"], var_13.var_AD42)) {
          self.var_8B45["right_1"][self.var_8B45["right_1"].size] = var_13;
        } else if(scripts\engine\utility::array_contains(self.var_8B46["left_2"], var_13.var_AD42)) {
          self.var_8B45["left_2"][self.var_8B45["left_2"].size] = var_13;
        } else if(scripts\engine\utility::array_contains(self.var_8B46["right_2"], var_13.var_AD42)) {
          self.var_8B45["right_2"][self.var_8B45["right_2"].size] = var_13;
        } else if(scripts\engine\utility::array_contains(self.var_8B46["left_3"], var_13.var_AD42)) {
          var_13 delete();
        } else if(scripts\engine\utility::array_contains(self.var_8B46["right_3"], var_13.var_AD42)) {
          var_13 delete();
        } else if(scripts\engine\utility::array_contains(self.var_8B46["left_4"], var_13.var_AD42)) {
          self.var_8B45["left_4"][self.var_8B45["left_4"].size] = var_13;
        } else if(scripts\engine\utility::array_contains(self.var_8B46["right_4"], var_13.var_AD42)) {
          self.var_8B45["right_4"][self.var_8B45["right_4"].size] = var_13;
        } else if(scripts\engine\utility::array_contains(self.var_8B46["center"], var_13.var_AD42)) {
          self.var_8B45["center"][self.var_8B45["center"].size] = var_13;
        }

        var_9--;

        if(var_9 <= 0) {
          wait 0.05;
          var_9 = 10;
        }
      }
    }
  }
}

func_104D0() {
  var_0 = scripts\engine\utility::getstructarray("debris_cloud_struct", "script_noteworthy");
  var_1 = undefined;
  var_2 = scripts\engine\utility::spawn_tag_origin(level.var_3670 gettagorigin("fx_light_running_lrg_b3_1"), level.var_3670 gettagangles("fx_light_running_lrg_b3_1"));
  var_3 = anglesToForward(level.var_3670.angles);
  var_4 = anglestoright(level.var_3670.angles);
  var_5 = anglestoup(level.var_3670.angles);
  var_6 = scripts\engine\utility::spawn_tag_origin(var_2.origin + var_3 * 4500 + var_4 * -500 + var_5 * -1000, var_2.angles);
  playFXOnTag(level._effect["vfx_ca_destroyer_ambient_debris"], var_2, "tag_origin");
  playFXOnTag(level._effect["vfx_ca_destroyer_ambient_debris"], var_6, "tag_origin");
}

#using_animtree("vehicles");

func_1076F() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("veh_mil_air_ca_olympus_mons_gun_rig");
  var_0 glinton(#animtree);
  var_0 linkto(self, "tag_main_cannon", (0, 0, 0), (0, 0, 0));
  self.cannon = var_0;
  self.cannon hide();
}

func_BA7E(var_0) {
  var_1 = 2;
  var_2 = 2;

  if(!isDefined(self.cannon.var_11512)) {
    self.cannon.var_11512 = scripts\engine\utility::spawn_tag_origin();
  }

  if(isDefined(var_0)) {
    self.cannon.var_11512.origin = var_0.origin;
    self.cannon.var_11512 linkto(var_0);
  } else {
    self.cannon.var_11512 linkto(self.cannon, "tag_flash", (20000, 0, 0), (0, 0, 0));
  }

  self.cannon playSound("mons_megacannon_fire");
  earthquake(0.25, 0.75, self.cannon.origin, 15000);
  thread func_0BB4::func_BA6A(var_1, var_2, 0);
  wait(var_1);
  var_3 = self.cannon gettagorigin("tag_flash");
  var_4 = self.cannon gettagangles("tag_flash");
  var_5 = var_3 + anglesToForward(var_4) * 1000;
  var_6 = self.cannon.var_11512.origin;
  var_7 = bulletTrace(var_5, var_6, 1, self.cannon);

  if(var_7["fraction"] < 1) {
    playFX(scripts\engine\utility::getfx("vfx_mons_fspar_impact"), var_7["position"], anglesToForward(var_4), anglestoup(var_4));
  }
}

func_F587() {
  level.var_3670.cannon.var_AEBB = % ph_trenchrun_local_megacannon;
  level.var_3670.var_AEBB = % ph_trenchrun_local_mons;
}

func_9347() {
  scripts\engine\utility::flag_init("ret_mover_init");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_F5A4();
  var_0 = scripts\sp\vehicle::func_1080C("player_jackal");
  var_1 = scripts\engine\utility::getstruct("landing_start", "targetname");
  var_2 = scripts\engine\utility::getstruct("salter_landing_start", "targetname");
  func_0BDC::func_10CD1(var_0, var_1);
  thread scripts\sp\maps\phspace\phspace_battle::func_D868();
  var_3 = getvehiclenode("retribution_landing_pos", "targetname");
  level.var_12B67 vehicle_teleport(var_3.origin, var_3.angles);
  level.var_3670 = func_0BB8::func_398E("ca_olympus", "idle", "heavy", "high");
  level.var_3670 thread func_F051();
  func_A830();
  wait 0.5;
  func_11311();
  wait 0.1;
  level.var_3670 detach("veh_mil_air_ca_olympus_mons_bridge", "TAG_ORIGIN");
  level.var_3670 attach("veh_mil_air_ca_olympus_mons_bridge_dmg", "TAG_ORIGIN");
  scripts\engine\utility::flag_set("ret_mover_init");
}

func_A71B() {
  _setsaveddvar("bg_cinematicFullScreen", "1");
  _setsaveddvar("bg_cinematicCanPause", "1");
  _cinematicingame("phspace_hud_kotch_pip_01_full");

  while(!iscinematicplaying()) {
    wait 0.05;
  }

  while(iscinematicplaying()) {
    wait 0.05;
  }

  _stopcinematicingame();
  _setsaveddvar("bg_cinematicFullScreen", "1");
  _setsaveddvar("bg_cinematicCanPause", "1");
}

func_9346() {}