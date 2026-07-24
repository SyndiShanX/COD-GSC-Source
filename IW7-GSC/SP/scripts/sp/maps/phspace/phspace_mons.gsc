/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phspace\phspace_mons.gsc
****************************************************/

_id_CAE0() {
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

_id_BAB2() {
  scripts\sp\maps\phspace\phspace::_id_107C0();
  scripts\sp\maps\phspace\phspace::_id_1062E();
  level._id_EA99 _id_0BDC::_id_6B4C("space", 0);
  level._id_1CB9 _id_0BDC::_id_6B4C("space", 0);
  level._id_EA99.ignoreme = 1;
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_F5A4();
  var_0 = scripts\sp\vehicle::_id_1080C("player_jackal");
  var_1 = scripts\engine\utility::getStruct("mons_intro_start", "targetname");
  _id_0BDC::_id_10CD1(var_0, var_1);
  wait 0.05;
  thread scripts\sp\maps\phspace\phspace_battle::_id_D868();
  thread scripts\sp\maps\phspace\phspace_battle::_id_12B5F();
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\maps\phspace\phspace_battle::_id_FE2F();
  level._id_EA99 vehicle_teleport(var_1.origin + -5000 * anglesToForward(level._id_D127.angles), var_1.angles);
  thread scripts\sp\maps\phspace\phspace_battle::_id_12B7B(1);
  wait 1.0;
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C44(level._id_111D0._id_1022B, 0.2);
}

_id_6EB8(var_0) {
  self endon("stop_outline_flash");

  for(;;) {
    wait 0.75;
    self hudoutlinedisable();
    wait 0.5;
  }
}

_id_BAAC() {
  scripts\engine\utility::flag_wait("prespawn_done");
  thread _id_54FC();
  thread _id_BAA3();
  _id_1F90();
  _id_A830();
  scripts\sp\utility::_id_266A("mons_intro");
  _id_96EC();
  level._id_12B67 _id_0BB6::_id_39E1();
  var_0 = getEnt("ca_olympus", "targetname");
  var_0._id_EEF9 = "none";
  level._id_3670 = scripts\sp\vehicle::_id_1080C("ca_olympus");
  level._id_3670 thread _id_F051();
  level._id_3670 hide();
  wait 0.05;
  level._id_3670 _id_0BB8::_id_7491();
  scripts\engine\utility::delaythread(5, ::_id_A7F7);
  _id_CF82();
  scripts\engine\utility::flag_set("olympus_arriving");
  setmusicstate("mx_291_mons_coming");
  level.player playSound("scn_phspace_mons_arrive");
  level._id_3670 thread _id_0BB8::_id_398C("idle", "idle", "high");
  level._id_3670 thread mons_ftl_in_show_delayed();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C44(level._id_111D0._id_BA9E, 0.2);
  scripts\engine\utility::flag_set("olympus_arrived");
  scripts\sp\utility::_id_10FEC("returnret");
  level._id_FD6E._id_E35D thread _id_0BDB::_id_A2F1();
  thread _id_BA82();
  thread _id_AB88();
  _id_1F8F();
  thread _id_BA9F(0);
  thread _id_513D();
}

mons_ftl_in_show_delayed() {
  wait 0.2;
  level._id_3670 notify("show_warp_core");
  level._id_3670.cannon show();

  foreach(var_1 in self._id_8B4F) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3))
        var_3 show();
    }
  }

  _id_0BB8::_id_39C8();
}

_id_513D() {
  if(!isDefined(level._id_12B4C)) {
    return;
  }
  while(_id_0B76::_id_7A60(level._id_12B4C.origin) > 0.0)
    wait 0.5;

  level._id_12B4C _id_0BA9::_id_397B();
}

_id_D083() {
  setsaveddvar("spaceshipForceSetFovBlendStrength", 10);
  setsaveddvar("spaceshipForceSetFov", 95);
  wait 0.5;
  setsaveddvar("spaceshipForceSetFovBlendStrength", 0.6);
  setsaveddvar("spaceshipForceSetFov", 50);
  wait 4;
  setsaveddvar("spaceshipForceSetFovBlendStrength", 0.1);
  setsaveddvar("spaceshipForceSetFov", 69);
  wait 15;
  setsaveddvar("spaceshipForceSetFov", 0);
}

_id_CF49() {
  level endon("return_ads_fov_normal");
  var_0 = 0;

  for(;;) {
    if(level.player adsButtonPressed() && !var_0) {
      setsaveddvar("spaceshipForceSetFovBlendStrength", 4);
      setsaveddvar("spaceshipForceSetFov", 42);
      var_0 = 1;
    }

    if(!level.player adsButtonPressed() && var_0) {
      setsaveddvar("spaceshipForceSetFov", 0);
      var_0 = 0;
    }

    wait 0.05;
  }
}

_id_CF48() {
  level notify("return_ads_fov_normal");
  level.player allowads(0);
  setsaveddvar("spaceshipForceSetFov", 0);
  wait 0.2;
  level.player allowads(1);
}

_id_AB88() {
  var_0 = 999999;
  level._id_FD6E._id_E35D linkTo(level._id_12B67._id_BCDA);
  var_1 = 5;
  var_2 = 0.12;

  while(var_1 > 0) {
    level._id_FD6E._id_E35D unlink();
    var_3 = level._id_12B67._id_BCDA gettagorigin("j_mainroot");
    var_4 = level._id_12B67._id_BCDA gettagangles("j_mainroot");
    var_5 = anglesToForward(level._id_FD6E._id_E35D.angles);
    var_6 = anglestoright(level._id_FD6E._id_E35D.angles);
    var_7 = anglestoup(level._id_FD6E._id_E35D.angles);
    level._id_FD6E._id_E35D.origin = scripts\sp\math::_id_AB6F(level._id_FD6E._id_E35D.origin, var_3, var_2);
    var_5 = scripts\sp\math::_id_AB6F(var_5, anglesToForward(var_4), var_2);
    var_6 = scripts\sp\math::_id_AB6F(var_6, anglestoright(var_4), var_2);
    var_7 = scripts\sp\math::_id_AB6F(var_7, anglestoup(var_4), var_2);
    level._id_FD6E._id_E35D.angles = axistoangles(var_5, var_6, var_7);
    level._id_FD6E._id_E35D linkTo(level._id_12B67._id_BCDA, "j_mainroot");
    var_1 = var_1 - 0.05;
    wait 0.05;
  }

  level._id_FD6E._id_E35D linkTo(level._id_12B67._id_BCDA, "j_mainroot", (0, 0, 0), (0, 0, 0));
}

_id_A828() {
  scripts\engine\utility::flag_set("jackal_landing_never_launch_drone");
  level._id_FD6E._id_E35D unlink();
  level._id_FD6E._id_E35D._id_E708 = 0.3;
  level._id_FD6E._id_E35D._id_EBA9 = 0.5;
  level._id_FD6E._id_E35D._id_B455 = 145;
  level._id_FD6E._id_E35D._id_B74F = 130;
  level._id_FD6E._id_E35D scripts\engine\utility::delaythread(0.2, _id_0BDB::_id_A2F2);
}

_id_A829() {
  scripts\engine\utility::flag_clear("jackal_landing_never_launch_drone");
  level._id_FD6E._id_E35D unlink();
  level._id_FD6E._id_E35D._id_E708 = undefined;
  level._id_FD6E._id_E35D._id_EBA9 = undefined;
  level._id_FD6E._id_E35D._id_B455 = undefined;
  level._id_FD6E._id_E35D._id_B74F = undefined;
  level._id_12B67 linkTo(level._id_FD6E._id_E35D);
  level._id_FD6E._id_E35D scripts\engine\utility::delaythread(0.2, _id_0B51::_id_E3C6, 1, 0);
}

_id_CF82() {
  wait 0.2;
  _id_A828();
  level._id_12B67 linkTo(level._id_FD6E._id_E35D);

  for(;;) {
    var_0 = level._id_FD6E._id_E35D._id_E8AD;
    var_1 = level._id_D127.origin - var_0.origin;
    var_2 = rotatevectorinverted(var_1, var_0.angles);
    var_3 = var_2[0];
    var_4 = pointonsegmentnearesttopoint(var_0.origin, var_0.origin + anglesToForward(var_0.angles) * 6000, level._id_D127.origin);
    var_5 = distance(level._id_D127.origin, var_4);

    if(var_3 < 21000 && scripts\engine\utility::flag("jackal_landing_active") && !scripts\engine\utility::flag("olympus_almost_arrived"))
      scripts\engine\utility::flag_set("olympus_almost_arrived");

    if(var_3 < 9000 && var_5 < 1000 && scripts\engine\utility::flag("jackal_landing_active")) {
      break;
    }

    wait 0.05;
  }
}

_id_1F90() {
  while(!isDefined(level._id_12B55))
    wait 0.05;

  if(scripts\engine\utility::flag("mons_intro_setup_complete")) {
    return;
  }
  level._id_12703 = [];
  level._id_3672 = spawn("script_model", (0, 0, 0));
  level._id_3672 setModel("veh_mil_air_ca_olympus_mons_bridge_piece");
  level._id_3672 notsolid();
  level._id_3672 hide();
  var_0 = scripts\engine\utility::getStruct("trenchrun_anim_node", "targetname");
  level._id_1F8E = var_0 scripts\engine\utility::spawn_tag_origin();
  level._id_1F8E.angles = var_0.angles;
  level._id_EAA5 = _id_10712("trenchrun_salter");
  level._id_D16B = _id_10712("trenchrun_player");
  level._id_3671 = _id_10712("trenchrun_mons");
  level._id_EA46 = _id_10712("trenchrun_salter_bullet_target");
  level._id_EAC0 = _id_10712("trenchrun_salter_missile_target");
  level._id_DC56 = _id_10712("trenchrun_ram_vfx");
  level._id_3672._id_BCDA = _id_10712("trenchrun_mons_tower");
  level._id_12B67._id_BCDA = _id_10712("trenchrun_ret");
  level._id_12B7D._id_BCDA = _id_10712("trenchrun_tigris");
  level._id_12B50._id_BCDA = _id_10712("trenchrun_convoy_00");
  level._id_12B51._id_BCDA = _id_10712("trenchrun_convoy_01");
  level._id_12B53._id_BCDA = _id_10712("trenchrun_convoy_02");
  level._id_12B54._id_BCDA = _id_10712("trenchrun_convoy_03");
  level._id_12B55._id_BCDA = _id_10712("trenchrun_convoy_04");
  level._id_12B56._id_BCDA = _id_10712("trenchrun_convoy_05");
  level._id_D16B._id_11512 = scripts\engine\utility::spawn_tag_origin();
  level._id_D16B._id_11512 linkTo(level._id_D16B, "j_mainroot", (0, 0, 0), (0, 0, 0));
  level._id_12704 = [level._id_EAA5, level._id_D16B, level._id_3671, level._id_EA46, level._id_EAC0, level._id_DC56, level._id_12B67._id_BCDA, level._id_12B7D._id_BCDA, level._id_12B50._id_BCDA, level._id_12B51._id_BCDA, level._id_12B53._id_BCDA, level._id_12B54._id_BCDA, level._id_12B55._id_BCDA, level._id_12B56._id_BCDA, level._id_3672._id_BCDA];
  var_1 = [level._id_12B67, level._id_12B7D, level._id_12B50, level._id_12B51, level._id_12B53, level._id_12B54, level._id_12B55, level._id_12B56, level._id_3672];

  foreach(var_3 in level._id_12704) {
    var_3 linkTo(level._id_1F8E);
    level._id_1F8E _id_1EC5(var_3);
  }

  foreach(var_6 in var_1)
  var_6 _id_BAA0();

  scripts\engine\utility::flag_set("mons_intro_setup_complete");
}

_id_F5D4(var_0) {
  level._id_12703 = scripts\engine\utility::array_add(level._id_12703, self);
  self _meth_82A2(self._id_AEBB);
  self _meth_82B0(self._id_AEBB, var_0);
}

_id_1F8F() {
  level._id_1F5B = 0.9;
  thread _id_126FD();
  thread _id_12702();
  level._id_D299 thread _id_0BDC::_id_D29B(1, 3);
  level._id_3670 linkTo(level._id_3671, "tag_origin", (0, 0, 0), (0, 0, 0));
  _id_F587();
  var_0 = level._id_D16B islegacyagent(level._id_EC85["generic_mover"][level._id_D16B._id_1FAF]);
  level._id_3670.cannon _id_F5D4(var_0);
  level._id_3670 _id_F5D4(var_0);

  foreach(var_2 in level._id_12704)
  var_2 _meth_82B1(level._id_EC85["generic_mover"][var_2._id_1FAF], 1 * level._id_1F5B);

  foreach(var_5 in level._id_12703)
  var_5 _meth_82B1(var_5._id_AEBB, 1 * level._id_1F5B);

  thread _id_1F92();
}

_id_1F98(var_0) {
  var_1 = getnotetracktimes(level._id_EC85["generic_mover"][level._id_D16B._id_1FAF], var_0);

  foreach(var_3 in level._id_12704)
  var_3 _meth_82B0(level._id_EC85["generic_mover"][var_3._id_1FAF], var_1[0]);
}

_id_5B45(var_0) {
  thread _id_0BDC::_id_ACE8(var_0);

  for(;;)
    wait 0.05;
}

_id_1F92() {
  scripts\engine\utility::flag_init("flag_player_land");
  scripts\engine\utility::flag_init("retribution_ram");
  thread _id_1F93();
  thread _id_1F97();
  thread _id_1F91();
  thread _id_1F95();
  thread _id_1F96();
  thread _id_1F94();
  level._id_3670._id_24C2 = 90;
  _id_137E2("kill_convoy02");
  level._id_12B53 thread _id_0BB6::_id_3983(level._id_3670);
  _id_BAB7(level._id_12B53);
  var_0 = _id_137E2("lookat_ethan");

  if(!var_0)
    thread _id_D1DE();

  var_0 = _id_137E2("kill_convoy00");
  level._id_12B51 thread _id_0BB6::_id_3983(level._id_3670);
  _id_BAB7(level._id_12B50, 0.25);

  if(var_0)
    var_1 = 0.05;
  else
    var_1 = 40;

  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C44(level._id_111D0._id_DC4C, var_1);
  var_0 = _id_137E2("salter_go");
  level._id_EA99 _id_0BDC::_id_6B4C("fly");
  level._id_12B51 scripts\engine\utility::delaythread(6, _id_0BB6::_id_3984, level._id_3670);
  level._id_12B51 scripts\engine\utility::delaythread(9.5, _id_0BB6::_id_3984, level._id_3670);
  _id_137E2("kill_convoy01");
  level._id_12B7D scripts\engine\utility::delaythread(1, _id_0BB6::_id_3983, level._id_3670);
  level._id_12B51._id_4E09 = undefined;
  _id_BAB7(level._id_12B51, 0.2, 1);
  level._id_3670 thread _id_0BB6::_id_39E5("front_right", level._id_12B53);
  level._id_3670 thread _id_0BB6::_id_399C("right_1", level._id_12B53);
  level._id_3670 thread _id_0BB6::_id_399C("right_2", level._id_12B53);
  _id_137E2("scale_flares_for_trench");
  level._id_D127._id_6E93 = 0.12;
  level._id_D127._id_6E97 = 0.55;
  level._id_D127._id_6E8A = 1;
  _id_137E2("flare_scale_normal");
  level._id_D127._id_6E93 = 0.29;
  level._id_D127._id_6E97 = 0.75;
  level._id_D127._id_6E8A = 0;

  if(var_0)
    var_1 = 0.05;
  else
    var_1 = 25;

  level._id_1F8E rotateTo(level._id_1F8E.angles + (0, 25, 0), var_1, var_1 * 0.5, var_1 * 0.5);
  level._id_1F8E moveTo(level._id_1F8E.origin + (-10000, -35000, 0), var_1, var_1 * 0.5, var_1 * 0.5);
  _id_137E2("kill_convoy05");
  level._id_12B54 scripts\engine\utility::delaythread(11, _id_0BB6::_id_3983, level._id_3670);
  level._id_12B54 scripts\engine\utility::delaythread(17, _id_0BB6::_id_3983, level._id_3670);
  _id_BAB7(level._id_12B56);
  level._id_3670 thread _id_0BB6::_id_39E5("front_left", level._id_12B53);
  level._id_3670 thread _id_0BB6::_id_39E5("front_right", level._id_12B54, level._id_12B55);
  level._id_3670 thread _id_0BB6::_id_39E5("back_right", level._id_12B54, level._id_12B55);
  _id_137E2("kill_convoy03");
  _id_BAB7(level._id_12B54);
  level._id_3670 thread _id_0BB6::_id_39E5("front_left", level._id_12B67);
  level._id_3670 thread _id_0BB6::_id_39E5("back_left", level._id_12B67);
  level._id_3670 thread _id_0BB6::_id_39E5("front_right", level._id_12B7D);
  level._id_3670 thread _id_0BB6::_id_39E5("back_right", level._id_12B7D);
  level._id_12B50 thread _id_0BB6::_id_39E1();
  level._id_12B53 thread _id_0BB6::_id_39E1();
  level._id_12B55 thread _id_0BB6::_id_39E1();
  _id_137E2("ram_start");
  scripts\engine\utility::flag_set("retribution_ram");
  _id_A830();
  _id_137E2("kill_convoy04");
  level._id_12B55._id_4E09 = undefined;
  level._id_12B55 scripts\engine\utility::delaycall(3, ::_meth_81D0);
  level._id_3670 thread _id_0BB6::_id_3966(1, 1, level._id_12B67);
  level._id_3670 _id_BAF7();
  level._id_12B67 thread _id_0BB6::_id_3966(1, 1, level._id_3670);
  _id_137E2("ret_ram");
  thread _id_DC50();
  level._id_3670 _id_0BB6::_id_3967();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C44(level._id_111D0.mons_warp_angles, 10);
  _id_137E2("boost_start");
  _id_0BDC::_id_A0BE(1);
  _id_0BDC::_id_A38E(5, 5, 5, 3);
  _id_137E2("swap_mons_geo");
  _id_11311();
  _id_137E2("boost_end");
  _id_0BDC::_id_A0BE(0);
  _id_137E2("salter_hover");
  level._id_EA99 _id_0BDC::_id_6B4C("hover");

  if(isDefined(level._id_D127._id_58B6)) {
    level._id_D127._id_58B6 _meth_8278(0, 1);
    level.player clearsoundsubmix();
    level._id_D127._id_58B6 scripts\engine\utility::delaycall(1, ::stoploopsound, "jackal_plr_locked_lp");
  }

  thread _id_104D0();
  thread _id_A807();
  _id_137E2("player_stopped");
  thread _id_CF49();
  level._id_12B7D thread _id_FA63();
  _id_D30F();
  _id_137E2("tigris_missiles");

  if(scripts\engine\utility::is_true(level._id_3670._id_7479))
    killfxontag(level._effect["vfx_vehicle_mons_warp_out_ftldrive_core"], level._id_3670, "TAG_ORIGIN");

  thread _id_DC4B();
  _id_137E2("mons_ftl");
  level._id_3670 _id_0BB8::_id_3991();
  level._id_3670 _id_0BB6::_id_39E1();
  level._id_3670.cannon delete();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C44(level._id_111D0._id_A7D8, 10);
  level._id_12B67 _id_0BB6::_id_39F1();
  level._id_12B67 _id_0BB6::_id_3967();
  level notify("mons_ftl_out");
  thread _id_CF48();
  level.player playRumbleOnEntity("damage_heavy");
  earthquake(0.3, 1.3, level._id_D127.origin, 20000);
  setmusicstate("");
  killfxontag(scripts\engine\utility::getfx("mons_damage_linger"), level._id_3670._id_4CF6, "tag_origin");
  _id_D25B();
  _id_137E2("player_land");
  scripts\engine\utility::flag_set("flag_player_land");
  level._id_3670._id_4CF6 delete();
  level._id_D127._id_6E93 = 1.0;
  level._id_D127._id_6E97 = 1.0;
}

_id_D30F() {
  level._id_D299 _id_0BDC::_id_D29B(0, 4);
  _id_0BDC::_id_A302(0.35);
  _id_0BDC::_id_D16C(level._id_D299._id_BCDA, 0.25, 0.4, 0);
  _id_0BDC::_id_D190(1);
  _id_0BDC::_id_A14A();
  _id_0BDC::_id_A155();
}

_id_D25B() {
  var_0 = 2;
  _id_0BDC::_id_D164(level._id_D299._id_BCDA, var_0);
  wait(var_0);
  _id_0BDC::_id_A38E(25, 5, 5, 3);
  _id_0BDC::_id_D16C(level._id_D299._id_BCDA, 0, 1, 0);
}

_id_DC50() {
  thread _id_BACA();
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_initial_impact"), level._id_DC56, "tag_vfx_000");
  level._id_DC56 playSound("phspace_mons_collide_pt1");
  earthquake(0.39, 2.9, level._id_D127.origin, 20000);
  level.player playRumbleOnEntity("damage_heavy");
  _id_137E2("vfx_ram_drag_start");
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_drag_churn_debris"), level._id_DC56, "tag_vfx_001");
  _id_137E2("tower_break");
  thread _id_DC55();
  _id_137E2("vfx_ram_drag_end");
  stopFXOnTag(scripts\engine\utility::getfx("ret_ram_drag_churn_debris"), level._id_DC56, "tag_vfx_001");
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_drag_end"), level._id_DC56, "tag_vfx_001");
  _id_137E2("vfx_ram_slam_start");
  thread _id_E313();
  thread _id_E312();
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_slam_churn_debris"), level._id_DC56, "tag_vfx_002");
  _id_137E2("vfx_ram_slam_end");
  level notify("stop_slam_quakes");
  stopFXOnTag(scripts\engine\utility::getfx("ret_ram_slam_churn_debris"), level._id_DC56, "tag_vfx_002");
}

_id_BACA() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = level._id_DC56.origin;
  var_0.angles = level._id_3670.angles;
  var_0 linkTo(level._id_3670);
  playFXOnTag(scripts\engine\utility::getfx("ret_ram_mons_impact"), var_0, "tag_origin");
  wait 5;
  var_0 delete();
}

_id_E313() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(level._id_DC56, "tag_vfx_002", (0, 0, 0), (0, 0, 0));
  var_0 playSound("phspace_mons_collide_pt2", "sound_done");
  var_0 waittill("sound_done");
  var_0 delete();
}

_id_E312() {
  level endon("stop_slam_quakes");
  earthquake(0.25, 1.2, level._id_D127.origin, 20000);
  wait 0.3;

  for(;;) {
    earthquake(0.25, 0.4, level._id_D127.origin, 20000);
    wait(randomfloatrange(0.1, 0.2));
  }
}

_id_BAB7(var_0, var_1, var_2) {
  thread _id_BAB9(var_0, var_1, var_2);
}

_id_BAB9(var_0, var_1, var_2) {
  var_3 = 0.25;
  var_4 = 1.75;
  var_5 = 250000;

  if(isDefined(var_2) && var_2)
    var_6 = undefined;
  else
    var_6 = var_0;

  level._id_3670 thread _id_BA7E(var_6);
  wait 3;

  if(isDefined(var_0)) {
    var_0 _meth_81D0();
    thread _id_BAB8(var_0.origin);
  }

  if(isDefined(var_1))
    earthquake(var_1, 1, level._id_D127.origin, 10000);
}

_id_BAB8(var_0) {
  wait 0.1;
  _id_0BDC::_id_DBDC(var_0, 0.35, 5000, 60000, undefined, 0.1, 1.6, 1);
}

_id_1F93() {
  _id_137E2("missile_volley_1");
  _id_137E2("missile_volley_2");
  level._id_3670 thread _id_0BB6::_id_39A1(level._id_3670._id_8B45["center"], 5);
  _id_137E2("missile_volley_3");
  level._id_3670 thread _id_0BB6::_id_39A1(level._id_3670._id_8B45["right_4"], 5);
  _id_137E2("missile_volley_4");
}

_id_1F97() {
  var_0 = _id_137E2("target_turret_group_1");

  if(!var_0) {
    thread _id_0BB6::_id_39CF(level._id_3670._id_12A39["one"]);
    thread _id_126FB(level._id_3670._id_12A39["one"]);
  }

  var_0 = _id_137E2("target_turret_group_2");

  if(!var_0) {
    thread _id_0BB6::_id_39C2(level._id_3670._id_12A39["one"]);
    thread _id_0BB6::_id_39CF(level._id_3670._id_12A39["two"]);
    thread _id_126FB(level._id_3670._id_12A39["two"]);
  }

  var_0 = _id_137E2("target_turret_group_3");

  if(!var_0) {
    thread _id_0BB6::_id_39C2(level._id_3670._id_12A39["two"]);
    thread _id_0BB6::_id_39CF(level._id_3670._id_12A39["three"]);
    thread _id_126FB(level._id_3670._id_12A39["three"]);
  }

  var_0 = _id_137E2("ram_start");

  if(!var_0) {
    wait 5;
    level notify("stop_miniflak_for_player");
    _id_D29E(4);
    thread _id_0BB6::_id_39C2(level._id_3670._id_12A39["three"]);
  }
}

_id_1F91() {
  var_0 = _id_137E2("start");

  if(!var_0) {
    scripts\sp\utility::_id_DBF5();
    wait 2.2;
    scripts\sp\utility::_id_10350("phspace_slt_holyshitwhatist");
    scripts\sp\utility::_id_10350("phspace_plr_scarsdirectallf");
    wait 1.5;
    scripts\sp\utility::_id_10350("phspace_plt2_ohshi");
    scripts\sp\utility::_id_10350("phspace_plt1_36ishit36isdown");
    scripts\sp\utility::_id_10350("phspace_plr_rogethanyouflyi");
    scripts\sp\utility::_id_10350("phspace_eth_ayesir");

    if(!isDefined(level._id_D127._id_58B6)) {
      level._id_D127._id_58B6 = spawn("script_origin", level._id_D127.origin);
      level._id_D127._id_58B6 linkTo(level._id_D127);
      level._id_D127._id_58B6 _meth_8278(0);
    }

    level._id_D127._id_58B6 playLoopSound("jackal_plr_locked_lp");
    level.player setsoundsubmix("jackal_dogfight");
    level._id_D127._id_58B6 _meth_8278(1, 1);
    thread scripts\sp\utility::_id_10350("phspace_slt_raiderilltargetthe");
  }

  var_0 = _id_137E2("plr_panamasdown");
  level._id_3670 _id_0BA9::_id_39C9();
  level._id_3670 _id_0BB8::_id_39C8();

  if(!var_0) {
    level.player _meth_82C0("phspace_kotch_pip", 0.25);
    _id_A71B();
    level.player _meth_82C0("jackal_cockpit", 0.25);
    thread scripts\sp\utility::_id_10350("phspace_slt_deploycounterm");
    thread _id_12700("phspace_plr_flaresout");
  }

  var_0 = _id_137E2("dialog_turrets_1");

  if(!var_0) {
    thread scripts\sp\utility::_id_10350("phspace_slt_hitthoseturrets");
    thread scripts\sp\utility::_id_10350("phspace_slt_goodlockonthe");
    thread scripts\sp\utility::_id_10350("phspace_slt_cmoncmon");
    thread scripts\sp\utility::_id_10350("phspace_eth_noeffectontarget");
    thread scripts\sp\utility::_id_10350("phspace_slt_whatsthisthing");
    thread scripts\sp\utility::_id_10350("phspace_slt_swinginaroundfor");
    thread scripts\sp\utility::_id_10350("phspace_plr_staywithherethan");
    wait 1.0;
    thread scripts\sp\utility::_id_10350("phspace_eth_weremarkedsirde");
    thread _id_12700("phspace_plr_countermeas");
  }

  var_0 = _id_137E2("dialog_turrets_2");

  if(!var_0) {
    thread scripts\sp\utility::_id_10350("phspace_plr_targetthecannon12");
    wait 2;
    scripts\sp\utility::_id_10350("phspace_slt_impactnoeffect");
    scripts\sp\utility::_id_10350("phspace_gtr_allstationstarget");
  }

  var_0 = _id_137E2("dialog_ram_exchange2");

  if(!var_0) {
    wait 0.75;
    scripts\sp\utility::_id_10350("phspace_eth_overhalftheflee");
    scripts\sp\utility::_id_10350("phspace_plr_retributionretreatretreat");
    scripts\sp\utility::_id_10350("phspace_nav_thisisretributi");
    wait 0.25;
    scripts\sp\utility::_id_10350("phspace_eth_theyrerammingit");
    wait 0.25;
    scripts\sp\utility::_id_10350("phspace_plr_negativeretribu");
    scripts\sp\utility::_id_10350("phspace_nav_captainsordersl");
    wait 1.1;
    level._id_EA99 scripts\sp\utility::_id_10346("phspace_slt_no");
    wait 0.5;
    scripts\sp\utility::_id_10350("phspace_eth_flak");
    level._id_EA99 scripts\sp\utility::_id_10346("phspace_slt_evadeevade");
    wait 1.2;
    thread scripts\sp\utility::_id_10350("phspace_gtr_thisisretmultiplecasualties");
  }

  var_0 = _id_137E2("dialog_mons_warp");

  if(!var_0) {
    scripts\sp\utility::_id_10350("phspace_plr_focusfirewhileth");
    scripts\sp\utility::_id_10350("phspace_fer_tigrisisengagin");
    scripts\sp\utility::_id_10350("phspace_slt_theyreretreating");
    scripts\sp\utility::_id_10350("phspace_plr_stayonit2");
    wait 2.5;
    scripts\sp\utility::_id_10350("phspace_slt_theyjumped");
    wait 1.25;
    scripts\sp\utility::_id_10350("phspace_gtr_allstationsbead");
    scripts\sp\utility::_id_10350("phspace_slt_olympusbattere");
    scripts\sp\utility::_id_10350("phspace_plr_guideusintwo");
    scripts\sp\utility::_id_10350("phspace_slt_copy");
    scripts\sp\utility::_id_10350("phspace_slt_retributionscar");
    scripts\sp\utility::_id_10350("phspace_atc_copyyoureclea");

    if(!scripts\engine\utility::flag("player_jackal_drone_dock"))
      scripts\sp\utility::_id_10350("phspace_plr_roger2limaco");

    if(!scripts\engine\utility::flag("player_jackal_drone_dock"))
      scripts\sp\utility::_id_10350("phspace_atc_holdforlockstan");

    if(!scripts\engine\utility::flag("player_jackal_drone_dock"))
      var_1 = 1;
    else
      var_1 = 0;

    scripts\engine\utility::flag_wait("player_jackal_drone_dock");
    wait(var_1);
    wait 1.7;
    scripts\sp\utility::_id_10350("phspace_atc_goodlockswellta");
    scripts\sp\utility::_id_10350("phspace_plr_charliedeltacopy");
  }

  wait 2;
}

_id_12700(var_0) {
  if(level._id_D127._id_6E9C._id_12B86.size > 0) {
    return;
  }
  level._id_D127 endon("missile_hit");

  while(level._id_D127._id_6E9C._id_12B86.size == 0)
    wait 0.05;

  scripts\sp\utility::_id_10350(var_0);
}

_id_1F95() {
  level._id_EA99._id_EF63 = 1000;
  level._id_EA99._id_EF62 = 300;
  level._id_EA99._id_EF5D = 1;
  _id_137FF("missile_volley_1");
  level._id_EA99._id_EF5E = (0, 0, -200);
  thread _id_102CE(4);
  _id_137FF("missile_volley_2");
  thread _id_102CE(4);
  _id_137FF("missile_volley_3");
  thread _id_102CE(6);
  _id_137FF("missile_volley_4");
  thread _id_102CE(4);
}

_id_102CE(var_0) {
  level._id_EA99 _id_0B76::_id_1945(level._id_EAC0, ["tag_flash_right", "tag_flash_left"], var_0);
}

_id_1F96() {
  _id_137FF("scn_phsp_salt_trench_01");
  level._id_EA99 playSound("scn_phsp_salt_trench_01");
  _id_137FF("scn_phsp_salt_trench_02");
  level._id_EA99 playSound("scn_phsp_salt_trench_02");
  _id_137FF("scn_phsp_salt_trench_03");
  level._id_EA99 playSound("scn_phsp_salt_trench_03");
  _id_137FF("scn_phsp_salt_trench_04");
  level._id_EA99 playSound("scn_phsp_salt_trench_04");
  _id_137FF("scn_phsp_salt_trench_05");
  level._id_EA99 playSound("scn_phsp_salt_trench_05");
}

_id_1F94() {
  var_0 = 1;
  var_1 = 4;
  level._id_EA46 makeentitysentient("axis", 0);
  level._id_EA99 _id_0BDC::_id_19B5(level._id_EA46);

  for(;;) {
    _id_137FF("start_shooting_" + var_0);
    level._id_EA99 _id_0BDC::_id_19AE("shoot_forever");
    _id_137FF("stop_shooting_" + var_0);
    level._id_EA99 _id_0BDC::_id_19AE("dont_shoot");
    var_0++;

    if(var_0 > var_1) {
      break;
    }
  }
}

_id_126FB(var_0) {
  level notify("stop_miniflak_for_player");
  level endon("stop_miniflak_for_player");
  thread _id_126FC();
  _id_D2A8();

  for(;;) {
    var_1 = 1;
    var_2 = 0;

    foreach(var_4 in var_0) {
      if(!isDefined(var_4)) {
        continue;
      }
      var_5 = vectorNormalize(var_4.origin - level._id_D127.origin);
      var_6 = vectordot(var_5, anglesToForward(level._id_D127.angles));

      if(var_6 < 0.3) {
        continue;
      }
      var_2 = 1;
      var_4 _id_0BB6::_id_399E("tag_flash", 0.7, 0, 0);

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

  _id_D29E();
  level notify("stop_miniflak_for_player");
}

_id_126FC() {
  level endon("stop_miniflak_for_player");
  var_0 = 115;
  var_1 = 50;
  var_2 = 0.75;
  var_3 = 0.1;
  var_4 = 0.3;
  level._id_12706 = 1;

  for(;;) {
    var_5 = scripts\sp\math::_id_6A8E(var_0, var_1, level._id_12706);
    var_6 = randomfloatrange(50, 1000);
    var_7 = randomfloatrange(-500, 500);
    var_8 = randomfloatrange(-500, 0);
    var_6 = var_6 * anglesToForward(level._id_D127.angles);
    var_7 = var_7 * anglestoright(level._id_D127.angles);
    var_8 = var_8 * anglestoup(level._id_D127.angles);
    var_9 = level._id_D127.origin + var_6 + var_7 + var_8;
    level._id_D127 dodamage(var_5, var_9, undefined, undefined, "MOD_IMPACT");
    var_10 = scripts\sp\math::_id_6A8E(var_3, var_2, level._id_12706);
    var_10 = randomfloatrange(var_10 * (1 - var_4), var_10 * (1 + var_4));
    wait(var_10);
  }
}

_id_126FD() {
  level endon("stop_tracking_player_fire");
  level._id_D127 endon("scripted_death");
  var_0 = 1.0;
  var_1 = 0.02;
  level._id_12706 = 1;
  var_2 = 0;

  for(;;) {
    setsaveddvar("spaceshipTargetLockAnglesScale", 1.1);

    if(level._id_D127._id_4C15._id_9DF4) {
      if(level._id_D127._id_4C15.class == "secondary")
        var_2 = 0.75;
      else
        var_2 = 0.05;
    } else
      var_2 = var_2 - 0.05;

    if(var_2 > 0)
      level._id_12706 = level._id_12706 + var_0;
    else
      level._id_12706 = level._id_12706 - var_1;

    level._id_12706 = clamp(level._id_12706, 0, 1);
    wait 0.05;
  }
}

_id_137E2(var_0) {
  var_1 = 0;
  var_2 = getanimlength(level._id_EC85["generic_mover"][level._id_D16B._id_1FAF]);
  var_3 = level._id_D16B islegacyagent(level._id_EC85["generic_mover"][level._id_D16B._id_1FAF]);
  var_3 = var_3 * var_2;
  var_4 = getnotetracktimes(level._id_EC85["generic_mover"][level._id_D16B._id_1FAF], var_0);
  var_4 = var_4[0] * var_2;
  var_5 = (var_4 - var_3) * (1 / level._id_1F5B);

  if(var_5 >= 0)
    wait(var_5);
  else
    var_1 = 1;

  return var_1;
}

_id_137E3(var_0, var_1) {
  var_2 = 0;
  var_3 = getanimlength(level._id_EC85["generic_mover"][level._id_D16B._id_1FAF]);
  var_4 = level._id_D16B islegacyagent(level._id_EC85["generic_mover"][level._id_D16B._id_1FAF]);
  var_4 = var_4 * var_3;
  var_5 = getnotetracktimes(level._id_EC85["generic_mover"][level._id_D16B._id_1FAF], var_0);
  var_5 = var_5[0] * var_3;
  var_6 = (var_5 - var_4) * (1 / level._id_1F5B);

  if(var_6 >= 0) {
    wait(var_6);

    if(isDefined(var_1))
      var_1 thread scripts\sp\utility::_id_10346("phspace_" + var_0);
    else
      thread scripts\sp\utility::_id_10352("phspace_" + var_0);
  }
}

_id_137FF(var_0) {
  var_1 = 0;
  var_2 = getanimlength(level._id_EC85["generic_mover"][level._id_EAA5._id_1FAF]);
  var_3 = level._id_D16B islegacyagent(level._id_EC85["generic_mover"][level._id_D16B._id_1FAF]);
  var_3 = var_3 * var_2;
  var_4 = getnotetracktimes(level._id_EC85["generic_mover"][level._id_EAA5._id_1FAF], var_0);
  var_4 = var_4[0] * var_2;
  var_5 = (var_4 - var_3) * (1 / level._id_1F5B);

  if(var_5 >= 0)
    wait(var_5);
  else
    var_1 = 1;

  return var_1;
}

_id_BAA0(var_0) {
  if(isDefined(var_0)) {
    var_1 = scripts\engine\utility::spawn_tag_origin();
    var_1.angles = self.angles;
    wait 0.05;
    self linkTo(var_1, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_1 moveTo(self._id_BCDA.origin, var_0, var_0 * 0.5, var_0 * 0.5);
    var_1 rotateTo(self._id_BCDA.angles, var_0, var_0 * 0.5, var_0 * 0.5);
    wait(var_0);
    self unlink();
    var_1 delete();
  }

  self linkTo(self._id_BCDA, "j_mainroot", (0, 0, 0), (0, 0, 0));
}

_id_1EC5(var_0) {
  thread scripts\sp\anim::_id_1F35(var_0, var_0._id_1FAF);
  var_0 _meth_82B1(level._id_EC85["generic_mover"][var_0._id_1FAF], 0);
}

_id_10712(var_0) {
  var_1 = scripts\sp\utility::_id_10639("generic_mover");
  var_1 hide();
  var_1._id_1FAF = var_0;
  return var_1;
}

#using_animtree("jackal");

_id_D1DE() {
  level notify("player_looks_at_ethan");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(level._id_D299._id_BCDA, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1 = scripts\sp\utility::_id_107EA("eth3n_space", 1);
  var_1._id_1FBB = "eth3n";
  var_1 linkTo(var_0);
  var_1 setviewmodeldepth(1);
  playFXOnTag(scripts\engine\utility::getfx("vfx_ethan_cockpit_light"), var_1, "tag_origin");
  thread _id_0BDC::_id_A2B0(%jackal_pilot_heist_mons_intro_lookback, %jackal_vehicle_heist_mons_intro_lookback, 0.2, 1);
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "eth3n_sitting");
  wait 3;
  thread _id_D12E();
  wait 5;
  var_0 delete();
  var_1 delete();
}

_id_BA9F(var_0) {
  level._id_12B7D solid();
  level._id_12B67 solid();
  level._id_12B50 solid();
  level._id_12B51 solid();
  level._id_12B53 solid();
  level._id_12B54 solid();
  level._id_12B56 solid();
  level._id_12B7D _id_1076A();
  level._id_12B50 _id_1076A();
  level._id_12B51 _id_1076A();
  level._id_12B53 _id_1076A();
  level._id_12B54 _id_1076A();
  level._id_12B55 _id_1076A();
  level._id_12B56 _id_1076A();
  level._id_12B7D._id_12FBA = 1;
  level._id_12B50._id_12FBA = 1;
  level._id_12B51._id_12FBA = 1;
  level._id_12B53._id_12FBA = 1;
  level._id_12B54._id_12FBA = 1;
  level._id_12B56._id_12FBA = 1;

  if(!var_0)
    wait 0.5;

  level._id_3670 thread _id_0BB6::_id_39E5("front_left", level._id_12B50);
  level._id_3670 thread _id_0BB6::_id_39E5("back_left", level._id_12B56);
  level._id_3670 thread _id_0BB6::_id_39E5("front_right", level._id_12B51);
  level._id_3670 thread _id_0BB6::_id_39E5("back_right", level._id_12B54, level._id_12B7D);
  wait 0.05;
  level._id_3670 thread _id_0BB6::_id_399C("left_1", level._id_12B50);
  level._id_3670 thread _id_0BB6::_id_399C("left_2", level._id_12B50);
  wait 0.05;
  level._id_3670 thread _id_0BB6::_id_399C("right_1", level._id_12B51);
  level._id_3670 thread _id_0BB6::_id_399C("right_2", level._id_12B51);

  if(!var_0)
    wait 2.5;

  level._id_12B50 thread _id_0BB6::_id_3966(1, 1, level._id_3670);
  level._id_12B51 thread _id_0BB6::_id_3966(1, 1, level._id_3670);

  if(!var_0)
    wait 0.2;

  level._id_12B53 thread _id_0BB6::_id_3966(1, 1, level._id_3670);
  level._id_12B7D thread _id_0BB6::_id_3966(1, 1, level._id_3670);

  if(!var_0)
    wait 0.1;

  level._id_12B54 thread _id_0BB6::_id_3966(1, 1, level._id_3670);
  level._id_12B55 thread _id_0BB6::_id_3966(1, 1, level._id_3670);

  if(!var_0)
    wait 0.15;

  level._id_12B56 thread _id_0BB6::_id_3966(1, 1, level._id_3670);
}

_id_EA47() {
  level endon("olympus_almost_arrived");
  scripts\engine\utility::flag_wait("jackal_sees_ret_for_landing");
  scripts\sp\utility::_id_10350("phspace_slt_gotavisualonret");
}

_id_BAAF() {
  var_0 = level._id_D299.origin;
  var_1 = level._id_D299.angles;
  var_2 = (-2000, 300, 400);
  var_3 = anglesToForward(level._id_D299.angles) * var_2[0] + anglestoright(level._id_D299.angles) * var_2[1] + anglestoup(level._id_D299.angles) * var_2[2];
  level._id_EA99 delete();
  scripts\sp\maps\phspace\phspace::_id_107C0();
  level._id_EA99 _id_0BDC::_id_1990(0);
  level._id_EA99 _id_0BDC::_id_19A2();
  level._id_EA99 vehicle_teleport(var_0 + var_3, var_1);
  level._id_EA99 _id_0BDC::_id_A1EC(var_0 + var_3, 1, 500, var_1);
  wait 1;
  var_2 = (2000, 500, 300);
  var_3 = anglesToForward(level._id_D299.angles) * var_2[0] + anglestoright(level._id_D299.angles) * var_2[1] + anglestoup(level._id_D299.angles) * var_2[2];
  var_4 = level._id_D299.origin + var_3;
  level._id_EA99 _id_0BDC::_id_A1EC(var_4, 1, 40, var_1);
}

_id_ACEC() {
  for(;;)
    wait 0.05;
}

_id_BA9C() {
  var_0 = level._id_D299.origin;
  var_1 = level._id_D299.angles;
  var_2 = (-2000, -300, 100);
  var_3 = anglesToForward(level._id_D299.angles) * var_2[0] + anglestoright(level._id_D299.angles) * var_2[1] + anglestoup(level._id_D299.angles) * var_2[2];
  level._id_1CB9 delete();
  scripts\sp\maps\phspace\phspace::_id_1062E();
  level._id_1CB9 vehicle_teleport(var_0 + var_3, var_1);
  level._id_1CB9 _id_0BDC::_id_19A2();
  level._id_1CB9 _id_0BDC::_id_19AB(500);
  level._id_1CB9 _id_0BDC::_id_6B4C("boost_mode");
  var_4 = scripts\engine\utility::getStruct("ally1_flyto_mons", "targetname");
  level._id_1CB9 thread _id_0BDC::_id_A1EC(var_4.origin, 0);
  wait 3.2;
  level._id_1CB9._id_9930 = 1;
  level._id_1CB9 notify("death");
}

_id_96EC() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0 _id_0BDC::_id_D2A5();
  level._id_D299 thread _id_0BDC::_id_D2A0(level._id_D16B._id_11512, (0, 0, 0), 500, 0.2, 0.5, 0.5);
  level._id_D299 thread _id_0BDC::_id_D2A7();
}

_id_D2A8(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  _id_0BDC::_id_A38E(25, 3, 0.55, var_0);
  level._id_D299 thread _id_0BDC::_id_D29A(level._id_D16B._id_11512, var_0, undefined, undefined, undefined, undefined, 0.012, undefined, 5);
}

_id_D29E(var_0) {
  if(!isDefined(var_0))
    var_0 = 2;

  _id_0BDC::_id_A38E(25, 3, 0.65, var_0);
  level._id_D299 thread _id_0BDC::_id_D29A(level._id_D16B._id_11512, var_0, undefined, undefined, undefined, undefined, 0.5, undefined, 1);
}

_id_BA82() {
  wait 0.0;
  level._id_D127 _id_0BDC::_id_D164(level._id_D299._id_BCDA, 3);
  level._id_D127._id_A56F = 1;
  _id_0BDC::_id_A153();
  thread _id_DAEE();
  thread _id_D083();
  earthquake(0.53, 2.8, level._id_D127.origin, 40000);
  level.player playRumbleOnEntity("damage_heavy");
  _id_0BDC::_id_A38E(35, 5, 5, 0.5);
  level.player _meth_8497();
  thread _id_A1E2();
  thread _id_0BDC::_id_A287(0.2);
}

_id_DAEE() {
  var_0 = 0.4;
  thread _id_0BD9::_id_D176(0.7, 0, var_0, 0.05, 0.8);
  wait(var_0);
  thread _id_0BD9::_id_D176(0.0, 0, 6.5, 0.01, 0.3);
}

_id_A1E2() {
  earthquake(0.4, 1.3, level._id_D127.origin, 20000);
  level._id_D127 thread _id_0BDD::_id_6186(5, 0.4);
  _id_0BDC::_id_A10B("damage_alarm");
  _id_0BD5::_id_A2B3(1);
  wait 7;
  _id_0BD5::_id_A2B3(0);
  wait 6;
  _id_0BDC::_id_A10B("default");
}

_id_D12E() {
  level notify("player_power_on");
  wait 0.4;
  level._id_D127 thread _id_0BDB::_id_BBE0();
  wait 0.5;
  level.player _meth_8497();
  thread _id_0BDC::_id_A388(0.2);
  _id_0BDC::_id_A153(0);
}

_id_D17C() {
  level._id_D127._id_13BF7.weapon = "spaceship_30mm_projectile_large_radius";

  if(level._id_D127._id_4C15 == level._id_D127._id_13BF7)
    level._id_D127 _meth_849E(level._id_D127._id_13BF7.weapon);
}

_id_BA80() {
  var_0 = [level._id_EA99, level._id_1CB9];

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
    var_2 linkTo(var_3);
    var_3 _id_BA83();
    var_2 _id_0BDC::_id_19A0(1);
    var_2 _id_0BDC::_id_A167();
    var_2 _id_0BDC::_id_6B4C("none", 1);
  }
}

_id_BA83(var_0) {
  var_1 = 22000;
  var_2 = (179, 179, 179);
  var_3 = getvehiclenode("ca_olympus_last_pos", "targetname");
  var_4 = self.origin - var_3.origin;
  var_5 = length(var_4);
  var_6 = scripts\sp\math::_id_C097(5000, 80000, var_5);
  var_7 = scripts\sp\math::_id_6A8E(var_1, 0, var_6);
  var_8 = scripts\sp\math::_id_6A8E(0.1, 0.6, var_6);
  var_9 = vectorNormalize(var_4);
  self._id_528E = self.origin + var_9 * var_7;
  wait(var_8);
  self unlink();
  self moveTo(self._id_528E, 5, 0.5, 4.5);

  if(isDefined(var_0))
    self._id_5289 = var_0;
  else {
    var_2 = var_2 * (1 - var_6);
    self._id_5289 = self.angles + var_2;
  }

  self rotateTo(self._id_5289, 13.0, 1.3, 11.7);
}

_id_BAA3() {
  level._id_D127._id_1FBB = "player_jackal";
  scripts\sp\utility::_id_10350("phspace_plr_squadronthisis");
  scripts\sp\utility::_id_10350("phspace_plt1_copy34returnin");
  thread _id_EA47();

  if(!scripts\engine\utility::flag("olympus_almost_arrived"))
    scripts\sp\utility::_id_10350("phspace_plt2_36isrtb");

  if(!scripts\engine\utility::flag("olympus_almost_arrived"))
    scripts\sp\utility::_id_10350("phspace_slt_letsregroupfuelu");

  if(!scripts\engine\utility::flag("olympus_almost_arrived"))
    scripts\sp\utility::_id_10350("phspace_tao_allstationstaog");

  scripts\engine\utility::flag_wait("olympus_almost_arrived");
  scripts\sp\utility::_id_10350("phspace_plt1_imgettingsomea");

  if(!scripts\engine\utility::flag("olympus_arrived"))
    scripts\sp\utility::_id_10350("phspace_plt2_samecheckingsta");

  scripts\engine\utility::flag_wait("olympus_arriving");
  setmusicstate("mx_082_ph_mons_combat");
}

_id_137FD() {
  var_0 = getEnt("trigger_safe_to_return", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
}

_id_50BF(var_0) {
  wait(var_0);

  if(isDefined(self) && isalive(self)) {
    if(_id_0B76::_id_7A60(self.origin) < 0.7 && !scripts\engine\utility::cointoss())
      self delete();
    else
      self _meth_81D0();
  }
}

_id_BACF(var_0) {
  for(var_1 = 6; var_1 > 0; var_1 = var_1 - 1) {
    thread _id_6D0B(var_0);
    wait(randomfloatrange(0.08, 0.25));
  }
}

_id_6D0B(var_0) {
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
  var_3 thread _id_0B76::_id_A332(var_7, 1, level._id_F04E, undefined, var_5, var_6, undefined, undefined, 500, 1, 1.0, 1);
  wait 0.6;
  wait(randomfloatrange(0.2, 0.75));
  var_8 = scripts\engine\utility::spawn_tag_origin();
  var_4 = scripts\engine\utility::random(var_2);
  var_8.origin = self gettagorigin(var_4);
  var_8.angles = self gettagangles(var_4);
  var_8 thread _id_0B76::_id_A332(var_7, 1, level._id_F04E, undefined, var_5, var_6, undefined, undefined, 50, 1, 1.0, 1);
}

_id_54FC() {
  var_0 = [level._id_12B7D, level._id_12B67, level._id_12B4A, level._id_12B4C, level._id_12B60, level._id_12B61];

  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 _id_0BB6::_id_398A(0);
  }
}

_id_BAA1() {
  thread _id_BAA2();
}

_id_BAA2() {}

_id_12705() {
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C44(level._id_111D0._id_BA9E, 0);
  scripts\sp\maps\phspace\phspace::_id_107C0();
  level._id_EA99 _id_0BDC::_id_6B4C("space", 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_F5A4();
  var_0 = scripts\sp\vehicle::_id_1080C("player_jackal");
  var_1 = scripts\engine\utility::getStruct("trench_run_start", "targetname");
  var_2 = scripts\engine\utility::getStruct("salter_trench_run_start", "targetname");
  level._id_EA99 _id_0BDC::_id_19A2();
  level._id_EA99 vehicle_teleport(var_2.origin, var_2.angles);
  level._id_EA99 _id_0BDC::_id_A1EC(var_2.origin, 1, 50, var_2.angles);
  _id_0BDC::_id_10CD1(var_0, var_1);
  thread scripts\sp\maps\phspace\phspace_battle::_id_D868();
  thread scripts\sp\maps\phspace\phspace_battle::_id_12B5F();
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\maps\phspace\phspace_battle::_id_FE2F();
  _id_1F90();

  if(!isDefined(level._id_D127._id_58B6)) {
    level._id_D127._id_58B6 = spawn("script_origin", level._id_D127.origin);
    level._id_D127._id_58B6 linkTo(level._id_D127);
    level._id_D127._id_58B6 _meth_8278(0);
  }

  level._id_D127._id_58B6 playLoopSound("jackal_plr_locked_lp");
  level.player setsoundsubmix("jackal_dogfight");
  level._id_D127._id_58B6 _meth_8278(1, 1);
  _id_96EC();
  level._id_D299.origin = var_1.origin;
  level._id_D299.angles = var_1.angles;
  _id_0BDC::_id_D164(level._id_D299._id_BCDA, 0.0);
  level._id_D127._id_A56F = 1;
  _id_1F98("salter_go");
  _id_1F8F();
}

_id_126F9() {
  scripts\sp\utility::_id_266A("jackal_trenchrun");

  if(!isDefined(level._id_D299))
    wait 1;

  if(!scripts\engine\utility::flag_exist("retribution_ram"))
    wait 0.05;

  scripts\engine\utility::flag_wait("retribution_ram");
}

_id_12702() {
  wait 2;
  level._id_EA99 _id_0BDC::_id_6B4C("hover");
  level._id_EA99 linkTo(level._id_EAA5, "j_mainroot", (0, 0, 0), (0, 0, 0));
}

_id_4968(var_0) {
  var_1 = (1, 1, 1);
  var_2 = 15;
  var_3 = 0;

  for(var_4 = []; var_3 < var_2; var_3++)
    var_4[var_3] = scripts\sp\maps\phspace\phspace_battle::_id_491E(level._id_3670, randomfloatrange(-8000, 8000), randomfloatrange(-8000, 8000), randomfloatrange(-8000, 8000), 1, "1", var_1, var_0);

  return var_4;
}

_id_EAC5(var_0) {
  level._id_EA99 endon("arrived_at_animation");
  var_1 = getanimlength(level._id_EC85["generic_mover"][level._id_D16B._id_1FAF]);
  var_2 = 300;
  var_3 = 4;
  var_4 = 1;
  var_5 = 300;

  for(;;) {
    level._id_EA99 thread _id_0BDC::_id_A1EC(level._id_EAA5.origin, 0, 0);
    var_6 = level._id_D16B islegacyagent(level._id_EC85["generic_mover"][level._id_D16B._id_1FAF]);
    var_6 = var_6 * var_1;
    var_7 = getnotetracktimes(level._id_EC85["generic_mover"][level._id_D16B._id_1FAF], "link_salter");
    var_7 = var_7[0] * var_1;
    var_8 = var_7 - var_6;

    if(var_8 < 0) {
      break;
    }

    var_9 = distance(level._id_EA99.origin, level._id_D16B.origin);
    var_10 = var_9 / var_8;
    var_10 = scripts\engine\utility::ips_to_mph(var_10);
    var_11 = scripts\sp\math::_id_C097(var_4, var_3, var_8);
    var_12 = scripts\sp\math::_id_6A8E(0, var_2, var_11);
    var_13 = var_10 + var_12;
    var_13 = clamp(var_13, 0, var_5);
    level._id_EA99 _id_0BDC::_id_19AB(var_13, 1000);
    wait 0.05;
  }
}

_id_AB73(var_0, var_1) {}

_id_126F8() {}

_id_DC53() {
  scripts\sp\maps\phspace\phspace::_id_107C0();
  level._id_EA99 _id_0BDC::_id_6B4C("space", 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_F5A4();
  var_0 = scripts\sp\vehicle::_id_1080C("player_jackal");
  var_1 = scripts\engine\utility::getStruct("ram_start", "targetname");
  var_2 = scripts\engine\utility::getStruct("salter_ram_start", "targetname");
  level._id_EA99 _id_0BDC::_id_19A2();
  level._id_EA99 vehicle_teleport(var_2.origin, var_2.angles);
  level._id_EA99 _id_0BDC::_id_A1EC(var_2.origin, 1, 50, var_2.angles);
  _id_0BDC::_id_10CD1(var_0, var_1);
  thread scripts\sp\maps\phspace\phspace_battle::_id_D868();
  thread scripts\sp\maps\phspace\phspace_battle::_id_12B5F();
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\maps\phspace\phspace_battle::_id_FE2F();
  _id_1F90();

  if(!isDefined(level._id_D127._id_58B6)) {
    level._id_D127._id_58B6 = spawn("script_origin", level._id_D127.origin);
    level._id_D127._id_58B6 linkTo(level._id_D127);
    level._id_D127._id_58B6 _meth_8278(0);
  }

  level._id_D127._id_58B6 playLoopSound("jackal_plr_locked_lp");
  level.player setsoundsubmix("jackal_dogfight");
  level._id_D127._id_58B6 _meth_8278(1, 1);
  _id_96EC();
  level._id_D299.origin = var_1.origin;
  level._id_D299.angles = var_1.angles;
  _id_0BDC::_id_D164(level._id_D299._id_BCDA, 0.0);
  level._id_3670 _id_F051(1);
  _id_1F98("ram_start");
  _id_1F8F();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C44(level._id_111D0._id_DC4C, 0);
}

_id_DC51() {
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\utility::_id_266A("ram");

  while(!scripts\engine\utility::flag_exist("flag_player_land"))
    wait 0.05;

  scripts\engine\utility::flag_wait("flag_player_land");
}

_id_DC55() {
  level._id_3670 detach("veh_mil_air_ca_olympus_mons_bridge", "TAG_ORIGIN");
  level._id_3670 attach("veh_mil_air_ca_olympus_mons_bridge_dmg", "TAG_ORIGIN");
  level._id_3672 show();
  playFXOnTag(scripts\engine\utility::getfx("mons_bridge_piece_explo"), level._id_3670, "tag_fx_debris");
  playFXOnTag(scripts\engine\utility::getfx("mons_bridge_piece_debris"), level._id_3672, "tag_fx_debris");
}

_id_DC4B() {
  thread _id_DC54();
  thread _id_DC52();
}

_id_DC52() {}

_id_DC54() {
  var_0 = _id_4968((-2000, -3000, 2100));
  level._id_12B7D thread scripts\sp\maps\phspace\phspace_battle::_id_B7F9(var_0, 2500);
  level.player playSound("scn_phspace_mons_ftl_out");
  wait 2.5;
  var_0 = _id_4968((0, 0, 2100));
  level._id_12B7D thread scripts\sp\maps\phspace\phspace_battle::_id_B7F9(var_0, 2500);
}

_id_DC4D() {
  thread _id_DC4E();
}

_id_DC4E() {}

_id_A82E() {
  scripts\engine\utility::flag_init("ret_mover_init");
  scripts\sp\maps\phspace\phspace::_id_107C0();
  level._id_EA99 _id_0BDC::_id_6B4C("space", 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_F5A4();
  var_0 = scripts\sp\vehicle::_id_1080C("player_jackal");
  var_1 = scripts\engine\utility::getStruct("landing_start", "targetname");
  var_2 = scripts\engine\utility::getStruct("salter_landing_start", "targetname");
  level._id_EA99 _id_0BDC::_id_19A2();
  level._id_EA99 vehicle_teleport(var_2.origin, var_2.angles);
  level._id_EA99 _id_0BDC::_id_A1EC(var_2.origin, 1, 50, var_2.angles);
  _id_0BDC::_id_10CD1(var_0, var_1);
  thread scripts\sp\maps\phspace\phspace_battle::_id_D868();
  var_3 = getvehiclenode("retribution_landing_pos", "targetname");
  level._id_12B67 vehicle_teleport(var_3.origin, var_3.angles);
  _id_A830();
  var_4 = getvehiclenode("tigris_landing_flyby", "targetname");
  level._id_12B7D scripts\sp\vehicle::_id_2471(var_4);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C44(level._id_111D0._id_A7D8, 0);
  wait 0.5;
  scripts\engine\utility::flag_set("ret_mover_init");
}

_id_A7F5() {
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\utility::_id_266A("landing");
  wait 0.05;
  _id_A829();
  thread _id_A807();
  thread _id_A7F7();
  _id_0BDC::_id_D190(1);
  _id_0BDC::_id_A14A(0);
  _id_0BDC::_id_A155(0);
  _id_0BDC::_id_A302(1);
  level._id_D127._id_A56F = 0;

  if(scripts\engine\utility::flag_exist("ret_mover_init"))
    scripts\engine\utility::flag_wait("ret_mover_init");
}

_id_A7F7() {
  level endon("olympus_almost_arrived");
  level endon("player_jackal_drone_dock");
  var_0 = ["phspace_eth_weshouldretur", "phspace_slt_letsgetbacktot", "phspace_eth_wereclearedtol", "phspace_slt_theyllneedusdow"];
  var_1 = [8, 14, 16, 20];
  var_2 = 0;

  for(;;) {
    while(scripts\engine\utility::flag("jackal_landing_active"))
      wait 0.1;

    if(var_2 < 3) {
      wait(var_1[var_2]);
      scripts\sp\utility::_id_10350(var_0[var_2], 2);

      if(var_2 < 3)
        var_2 = var_2 + 1;

      continue;
    }

    wait 20;
    var_3 = scripts\engine\utility::random(var_0);
    scripts\sp\utility::_id_10350(var_3, 2);
  }
}

_id_A807() {
  if(scripts\engine\utility::flag("started_preload")) {
    return;
  }
  scripts\engine\utility::flag_set("started_preload");
  scripts\sp\utility::_id_1264E("phspace_base_tr");
  wait 2.0;
  level thread scripts\sp\utility::_id_BF97();
}

_id_A830() {
  if(scripts\engine\utility::flag("ret_swapped")) {
    return;
  }
  level._id_FD6E._id_E35D.origin = level._id_12B67.origin;
  level._id_FD6E._id_E35D.angles = level._id_12B67.angles;
  level._id_FD6E._id_E35D linkTo(level._id_12B67);
  level._id_FD6E._id_E35D _id_0B51::_id_FDCB("show");
  level._id_FD6E._id_E35D _id_0B51::_id_FDCB("solid");
  level._id_12B67 _meth_8184();
  level._id_12B67 notsolid();
  level._id_12B67 _id_0BB8::_id_397C();
  scripts\sp\maps\phspace\phspace_battle::delete_ret_door_hack();
  scripts\engine\utility::flag_set("ret_swapped");
}

_id_11311() {
  if(isDefined(level._id_3670)) {
    level._id_3670 detach("veh_mil_air_ca_olympus_mons", "TAG_ORIGIN");
    level._id_3670 attach("veh_mil_air_ca_olympus_mons_dmg", "TAG_ORIGIN");
    level._id_3670._id_4CF6 = scripts\engine\utility::spawn_tag_origin();
    level._id_3670._id_4CF6 linkTo(level._id_3670, "tag_origin", (550, 5100, 4100), (0, 0, 0));
    playFXOnTag(scripts\engine\utility::getfx("mons_damage_linger"), level._id_3670._id_4CF6, "tag_origin");
  }

  level._id_FD6E._id_E35D setModel("veh_mil_air_un_retribution_dmg");
  level._id_FD6E._id_E35D._id_4CF6 = scripts\engine\utility::spawn_tag_origin();
  level._id_FD6E._id_E35D._id_4CF6 linkTo(level._id_FD6E._id_E35D, "tag_origin", (14000, -1800, 800), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("ret_damage_linger"), level._id_FD6E._id_E35D._id_4CF6, "tag_origin");
}

_id_A7DD() {
  thread _id_A7DE();
}

_id_A7DE() {}

_id_FE2E() {
  var_0 = level._id_3662 _id_0BA9::_id_39AC();
  var_1 = level._id_3663 _id_0BA9::_id_39AC();
  var_2 = level._id_3664 _id_0BA9::_id_39AC();
  var_3 = level._id_3665 _id_0BA9::_id_39AC();
  level._id_52D1 = scripts\engine\utility::array_add(level._id_52D1, var_0);
  level._id_52D1 = scripts\engine\utility::array_add(level._id_52D1, var_1);
  level._id_52D1 = scripts\engine\utility::array_add(level._id_52D1, var_2);
  level._id_52D1 = scripts\engine\utility::array_add(level._id_52D1, var_3);
}

_id_F051(var_0) {
  self.delay_warp_core = "show_warp_core";
  _id_1076F();
  _id_0BB6::_id_39E1();
  _id_1078C();
  wait 0.1;
  _id_0BB8::_id_39CD("off");
  _id_0BB8::_id_39D0("off");
  _id_0BB8::_id_39AE();
  self._id_129D9 = 1;
  wait 1.0;

  if(!isDefined(var_0))
    _id_0BB8::_id_397F(1, 1);
}

_id_1078C() {
  var_0 = "cannon_small_ca_mons";
  var_1 = "cannon_missile_ca_hardpoint";
  var_2 = ["amb_missile_l_1", "amb_missile_l_2", "amb_missile_r_1", "amb_missile_r_2"];
  var_3 = "";
  var_3 = var_3 + var_0 + " ";
  var_3 = var_3 + var_1;
  self._id_EEF9 = var_3;
  self.spawn_hidden_turrets = 1;
  _id_0BB6::_id_39E8();
  level._id_39DD["cannon_small_ca_mons"]._id_10241._id_10943 = ::_id_BA6C;
  wait 0.05;
  self._id_CA99 = 1;
  level._id_C214 = -1;
  thread scripts\sp\maps\phspace\phspace_battle::_id_FA45();
  thread _id_6D19();
  thread _id_0BB6::_id_39EF();
  thread _id_C418();
  wait 0.1;
  thread _id_BAF5();
  thread _id_FA70();
  level._id_39DD["cannon_small_ca_mons"]._id_4D1E.fx.death = "vfx_cap_turret_death_sm_fast";
  level._id_39DD["cannon_large_ca"]._id_4D1E.fx.death = "vfx_cap_turret_death_lrg_fast";
  level._id_39DD["cannon_missile_ca_hardpoint"]._id_4D1E.fx.death = "vfx_cap_turret_death_smt_fast";
  thread _id_E02C();
}

_id_E02C() {
  wait 2.0;

  foreach(var_1 in self.turrets["cap_turret_small_constant"]) {
    if(var_1._id_AD42 == "amb_turret_sml_l_5" || var_1._id_AD42 == "amb_turret_sml_r_5" || var_1._id_AD42 == "amb_turret_sml_l_6" || var_1._id_AD42 == "amb_turret_sml_r_6")
      var_1 delete();
  }
}

_id_4496(var_0) {
  var_1 = "";

  foreach(var_3 in var_0)
  var_1 = var_1 + "," + var_3;

  return var_1;
}

_id_BA6C(var_0) {
  if(self._id_114FB == level._id_D127 || self._id_1DF8 == level._id_D127) {
    if(soundexists("capitalship_cannon_fire"))
      self playSound("capitalship_cannon_fire");

    self shootturret(var_0);
  } else {
    var_1 = level._id_39DD["cannon_small_ca_mons"];
    var_2 = _id_0BB6::_id_12A36(var_0);
    var_3 = _id_0BB6::_id_12A37(var_0, var_2);
    var_2 = anglesToForward(var_2);
    self thread[[var_1._id_10241._id_AF57]](var_3, var_2, var_0);
    var_4 = var_1._id_4D1E.fx;
  }
}

_id_C418() {
  wait 0.1;

  foreach(var_1 in self.turrets) {
    foreach(var_3 in var_1)
    var_3.health = 10;
  }
}

_id_1076A() {
  _id_0BB6::_id_39E1();
  self._id_EEF9 = "cannon_large_un missile_tube_un";
  _id_0BB6::_id_39E8();
  wait 0.1;
  _id_0BB8::_id_39CD("idle");
  _id_0BB8::_id_39D0("idle");
  _id_0BB8::_id_39AE();
}

_id_6D19() {
  var_0 = self.turrets["cap_turret_phalanx"];

  if(!isDefined(var_0) || var_0.size == 0) {
    return;
  }
  foreach(var_2 in var_0) {
    if(isDefined(var_2))
      var_2 thread _id_6D1A();
  }
}

_id_6D1A() {
  self._id_C841 endon("death");
  self._id_C841 endon("ftl_out");
  self endon("death");

  for(;;) {
    _id_0BB6::_id_11547();
    wait(randomfloatrange(0.1, 0.8));
  }
}

_id_BAF7() {
  level notify("end_mons_turrets_target_player");

  foreach(var_5, var_1 in self.turrets) {
    if(var_5 == "cap_turret_phalanx") {
      continue;
    }
    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }
      var_3._id_114FB = var_3._id_1DF8;
      var_3._id_D92F = undefined;

      if(isDefined(var_3._id_1DF8))
        var_3 settargetentity(var_3._id_1DF8, (0, 0, 0));
    }
  }

  level._id_D127._id_BAEF delete();
}

_id_BAF5() {
  var_0 = anglesToForward(level._id_D127.angles);
  var_1 = anglestoup(level._id_D127.angles);
  var_2 = spawn("script_origin", level._id_D127.origin + var_0 * 750 + var_1 * 350);
  var_2.angles = level._id_D127.angles;
  level._id_D127._id_BAEF = var_2;
  level._id_D127._id_BAEF linkTo(level._id_D127);

  foreach(var_8, var_4 in self.turrets) {
    if(var_8 == "cap_turret_phalanx") {
      continue;
    }
    foreach(var_6 in var_4)
    var_6 thread _id_BAF6();
  }
}

_id_BAF6() {
  self endon("death");
  level endon("end_mons_turrets_target_player");
  var_0 = 900000000;
  var_1 = 0.75;

  for(;;) {
    var_2 = distancesquared(level._id_D127.origin, self.origin);
    var_3 = _id_0B76::_id_7A60(self.origin);

    if(var_2 < var_0 && var_3 > var_1) {
      var_4 = level._id_D127._id_BAEF;
      self._id_114FB = var_4;
      self._id_D92F = var_4;
      self settargetentity(var_4, (0, 0, 0));
    } else if(isDefined(self._id_D92F)) {
      self._id_114FB = self._id_1DF8;
      self._id_D92F = undefined;

      if(isDefined(self._id_1DF8))
        self settargetentity(self._id_1DF8, (0, 0, 0));

      self notify("stop_debug_line_loop");
    }

    wait 0.05;
  }
}

_id_FA63() {
  _id_0BB6::_id_39E1();
  self._id_EEF9 = "cannon_large_un cannon_missile_ca_hardpoint";
  _id_0BB6::_id_39E8();
}

_id_FA70() {
  var_0 = ["amb_turret_sml_l_5", "amb_turret_sml_l_6", "amb_turret_l_1", "amb_turret_l_2", "amb_turret_sml_l_2", "amb_turret_sml_l_3", "amb_turret_sml_l_4", "amb_turret_sml_l_7", "amb_turret_l_3", "amb_turret_l_4", "amb_turret_sml_l_8", "amb_turret_sml_l_10", "amb_turret_l_5", "amb_turret_l_6", "amb_turret_l_4", "amb_turret_sml_l_9", "amb_turret_sml_l_11", "amb_turret_sml_l_12", "amb_turret_l_7", "amb_turret_l_8", "amb_turret_l_9", "amb_turret_sml_l_13"];
  var_1 = ["amb_turret_r_5", "amb_turret_r_6", "amb_turret_sml_r_7", "amb_turret_sml_r_9", "amb_turret_sml_r_10", "amb_turret_r_4", "amb_turret_sml_r_8", "amb_turret_r_3", "amb_turret_r_7", "amb_turret_sml_r_2", "amb_turret_sml_r_3", "amb_turret_r_1", "amb_turret_r_2", "amb_turret_sml_r_4", "amb_turret_r_8", "amb_turret_r_9", "amb_turret_r_10", "amb_turret_r_11", "amb_turret_r_12", "amb_turret_r_13", "amb_turret_r_14", "amb_turret_r_15"];
  var_2 = ["amb_turret_sml_r_11", "amb_turret_sml_r_12", "amb_turret_sml_r_13", "amb_turret_sml_r_14", "amb_turret_sml_r_15", "amb_turret_sml_r_16", "amb_turret_sml_r_17", "amb_turret_sml_r_18"];
  self._id_12A39["one"] = [];
  self._id_12A39["two"] = [];
  self._id_12A39["three"] = [];

  foreach(var_4 in self.turrets) {
    foreach(var_6 in var_4) {
      if(isDefined(var_6)) {
        if(scripts\engine\utility::array_contains(var_0, var_6._id_AD42)) {
          self._id_12A39["one"][self._id_12A39["one"].size] = var_6;
          continue;
        }

        if(scripts\engine\utility::array_contains(var_1, var_6._id_AD42)) {
          self._id_12A39["two"][self._id_12A39["two"].size] = var_6;
          continue;
        }

        if(scripts\engine\utility::array_contains(var_2, var_6._id_AD42))
          self._id_12A39["three"][self._id_12A39["three"].size] = var_6;
      }
    }
  }

  self._id_8B45["left_1"] = [];
  self._id_8B45["left_2"] = [];
  self._id_8B45["left_3"] = [];
  self._id_8B45["left_4"] = [];
  self._id_8B45["right_1"] = [];
  self._id_8B45["right_2"] = [];
  self._id_8B45["right_3"] = [];
  self._id_8B45["right_4"] = [];
  self._id_8B45["center"] = [];
  var_9 = 10;

  foreach(var_11 in self._id_8B4F) {
    foreach(var_13 in var_11) {
      if(isDefined(var_13)) {
        if(scripts\engine\utility::array_contains(self._id_8B46["left_1"], var_13._id_AD42))
          self._id_8B45["left_1"][self._id_8B45["left_1"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self._id_8B46["right_1"], var_13._id_AD42))
          self._id_8B45["right_1"][self._id_8B45["right_1"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self._id_8B46["left_2"], var_13._id_AD42))
          self._id_8B45["left_2"][self._id_8B45["left_2"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self._id_8B46["right_2"], var_13._id_AD42))
          self._id_8B45["right_2"][self._id_8B45["right_2"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self._id_8B46["left_3"], var_13._id_AD42))
          var_13 delete();
        else if(scripts\engine\utility::array_contains(self._id_8B46["right_3"], var_13._id_AD42))
          var_13 delete();
        else if(scripts\engine\utility::array_contains(self._id_8B46["left_4"], var_13._id_AD42))
          self._id_8B45["left_4"][self._id_8B45["left_4"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self._id_8B46["right_4"], var_13._id_AD42))
          self._id_8B45["right_4"][self._id_8B45["right_4"].size] = var_13;
        else if(scripts\engine\utility::array_contains(self._id_8B46["center"], var_13._id_AD42))
          self._id_8B45["center"][self._id_8B45["center"].size] = var_13;

        var_9--;

        if(var_9 <= 0) {
          wait 0.05;
          var_9 = 10;
        }
      }
    }
  }
}

_id_104D0() {
  var_0 = scripts\engine\utility::getStructArray("debris_cloud_struct", "script_noteworthy");
  var_1 = undefined;
  var_2 = scripts\engine\utility::spawn_tag_origin(level._id_3670 gettagorigin("fx_light_running_lrg_b3_1"), level._id_3670 gettagangles("fx_light_running_lrg_b3_1"));
  var_3 = anglesToForward(level._id_3670.angles);
  var_4 = anglestoright(level._id_3670.angles);
  var_5 = anglestoup(level._id_3670.angles);
  var_6 = scripts\engine\utility::spawn_tag_origin(var_2.origin + var_3 * 4500 + var_4 * -500 + var_5 * -1000, var_2.angles);
  playFXOnTag(level._effect["vfx_ca_destroyer_ambient_debris"], var_2, "tag_origin");
  playFXOnTag(level._effect["vfx_ca_destroyer_ambient_debris"], var_6, "tag_origin");
}

#using_animtree("vehicles");

_id_1076F() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("veh_mil_air_ca_olympus_mons_gun_rig");
  var_0 _meth_83D0(#animtree);
  var_0 linkTo(self, "tag_main_cannon", (0, 0, 0), (0, 0, 0));
  self.cannon = var_0;
  self.cannon hide();
}

_id_BA7E(var_0) {
  var_1 = 2;
  var_2 = 2;

  if(!isDefined(self.cannon._id_11512))
    self.cannon._id_11512 = scripts\engine\utility::spawn_tag_origin();

  if(isDefined(var_0)) {
    self.cannon._id_11512.origin = var_0.origin;
    self.cannon._id_11512 linkTo(var_0);
  } else
    self.cannon._id_11512 linkTo(self.cannon, "tag_flash", (20000, 0, 0), (0, 0, 0));

  self.cannon playSound("mons_megacannon_fire");
  earthquake(0.25, 0.75, self.cannon.origin, 15000);
  thread _id_0BB4::_id_BA6A(var_1, var_2, 0);
  wait(var_1);
  var_3 = self.cannon gettagorigin("tag_flash");
  var_4 = self.cannon gettagangles("tag_flash");
  var_5 = var_3 + anglesToForward(var_4) * 1000;
  var_6 = self.cannon._id_11512.origin;
  var_7 = bulletTrace(var_5, var_6, 1, self.cannon);

  if(var_7["fraction"] < 1)
    playFX(scripts\engine\utility::getfx("vfx_mons_fspar_impact"), var_7["position"], anglesToForward(var_4), anglestoup(var_4));
}

_id_F587() {
  level._id_3670.cannon._id_AEBB = % ph_trenchrun_local_megacannon;
  level._id_3670._id_AEBB = % ph_trenchrun_local_mons;
}

_id_9347() {
  scripts\engine\utility::flag_init("ret_mover_init");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_F5A4();
  var_0 = scripts\sp\vehicle::_id_1080C("player_jackal");
  var_1 = scripts\engine\utility::getStruct("landing_start", "targetname");
  var_2 = scripts\engine\utility::getStruct("salter_landing_start", "targetname");
  _id_0BDC::_id_10CD1(var_0, var_1);
  thread scripts\sp\maps\phspace\phspace_battle::_id_D868();
  var_3 = getvehiclenode("retribution_landing_pos", "targetname");
  level._id_12B67 vehicle_teleport(var_3.origin, var_3.angles);
  level._id_3670 = _id_0BB8::_id_398E("ca_olympus", "idle", "heavy", "high");
  level._id_3670 thread _id_F051();
  _id_A830();
  wait 0.5;
  _id_11311();
  wait 0.1;
  level._id_3670 detach("veh_mil_air_ca_olympus_mons_bridge", "TAG_ORIGIN");
  level._id_3670 attach("veh_mil_air_ca_olympus_mons_bridge_dmg", "TAG_ORIGIN");
  scripts\engine\utility::flag_set("ret_mover_init");
}

_id_A71B() {
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame("phspace_hud_kotch_pip_01_full");

  while(!iscinematicplaying())
    wait 0.05;

  while(iscinematicplaying())
    wait 0.05;

  stopcinematicingame();
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
}

_id_9346() {}