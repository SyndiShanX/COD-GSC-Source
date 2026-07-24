/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phspace\phspace_battle.gsc
******************************************************/

_id_CADB() {
  scripts\engine\utility::flag_init("begin_space_battle");
  scripts\engine\utility::flag_init("prespawn_done");
  scripts\engine\utility::flag_init("jackal_assault_complete");
  scripts\engine\utility::flag_init("all_jackals_start_patrol");
  scripts\engine\utility::flag_init("move_to_assault_pos");
  scripts\engine\utility::flag_init("ship_assault_complete");
  scripts\engine\utility::flag_init("jackals_started_spawning");
  scripts\engine\utility::flag_init("obj_sdf_squadron_start");
  scripts\engine\utility::flag_init("jackal_assault_intro_done");
  scripts\engine\utility::flag_init("player_close_to_destroyer");
  scripts\engine\utility::flag_init("player_hovering");
}

#using_animtree("vehicles");

_id_104B7(var_0) {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_F5A4();

  if(!isDefined(var_0))
    var_0 = "player_jackal";

  var_1 = ["salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_48BF(var_1);
  scripts\sp\maps\phspace\phspace::_id_107C0();
  scripts\sp\maps\phspace\phspace::_id_1062E();
  level._id_EA99 _id_0BDC::_id_6B4C("space");
  level._id_1CB9 _id_0BDC::_id_6B4C("space");
  level._id_D299 = scripts\sp\maps\phspace\phspace_launch::_id_D2A6("player_sled", 1);
  level._id_D299._id_1FBB = "sled_jackal";
  var_2 = scripts\engine\utility::getStruct("jackal_launch_animnode_clone", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  wait 0.1;
  thread _id_A24C(var_2);
  var_3 = scripts\sp\vehicle::_id_1080C(var_0);
  _id_0BDC::_id_10CD1(var_3);
  level._id_D299 _meth_83D0(#animtree);
  level._id_D299 animScripted("", var_2.origin, var_2.angles, level._id_EC85["sled_jackal"]["space_launch_boost"]);
  wait 0.05;
  level._id_D299 _meth_82B0(level._id_EC85["sled_jackal"]["space_launch_boost"], 0.654132);
  wait 0.05;
  level._id_D127 vehicle_teleport(level._id_D299.origin, level._id_D299.angles);
  _id_0BDC::_id_D164(level._id_D299._id_BD0D, 0);
  level._id_EA99 hidepart("j_panel_hide");
  level._id_1CB9 hidepart("j_panel_hide");
  scripts\engine\utility::flag_set("begin_space_battle");
}

_id_104B6() {
  wait 0.1;
  scripts\engine\utility::flag_wait("begin_space_battle");
  thread _id_4092();
  setsaveddvar("r_umbraShadowCasters", 0);

  if(getdvarint("e3", 1)) {
    scripts\sp\utility::_id_F305();

    if(scripts\sp\utility::_id_9BEE()) {
      if(level._id_DADC)
        setsaveddvar("r_postaa", 1);
    }
  }

  _id_0BDC::_id_A162();
  _id_0BDC::_id_A153(1);
  _id_0BDC::_id_A0BE(0);
  _id_0BDC::_id_A301(0, 0.1, "pearl");
  _id_0BDC::_id_A302(0, 0.1, "pearl");
  level._id_D127 _meth_8491("hover");
  level._id_D127 _id_0BDC::_id_A14A(1);
  level._id_D127 _id_0BDC::_id_A156(1);

  if(getdvarint("e3", 0) || getdvarint("exec_review", 0))
    _id_0BDC::_id_A19D(1);

  thread _id_D868(1);
  thread spawn_ret_door_hack();
  wait 4.8;
  level._id_118DC = gettime() / 1000;
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_10D14();
  thread _id_CADA();
  thread _id_20E9();
  thread _id_23A3();
  wait 0.1;
  thread _id_12B5F(5);
  level._id_12B67 thread _id_12B68();
  level._id_12B7D thread _id_12B7E();
  level._id_12B51 thread _id_12B52();
  thread _id_2731();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(3.8);
  level._id_12B4A thread _id_12B4D();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(5.0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(5.2);
  thread scripts\sp\maps\phspace\phspace::_id_1062B();

  foreach(var_1 in level._id_1D0B)
  var_1 _id_0BDC::_id_19A9();

  level._id_EA99 _id_0BDC::_id_6B4C("fly", 1);
  wait 0.1;
  level._id_1CB9 _id_0BDC::_id_6B4C("fly", 1);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(8.0);
  level._id_EA99 thread _id_10ACD("intro_spline_salter");
  level._id_EA99 playSound("phspace_reveal_jackal_npc_boost");
  level._id_1CB9 thread _id_10ACD("intro_spline_ally1", 0.2);
  level._id_1CB9 playSound("phspace_reveal_jackal_npc_boost");

  foreach(var_1 in level._id_1D0B) {
    var_1 _id_0BDC::_id_1988();
    var_1 scripts\engine\utility::delaycall(randomfloatrange(0, 0.4), ::playsound, "phspace_reveal_jackal_npc_boost");
    var_1 thread _id_1D75(0, 1);
  }

  thread _id_9ABF(level._id_EA99, [level._id_1CB9], 10000, 3000);
  thread _id_9ABF(level._id_1D0B[1], [level._id_1D0B[0], level._id_1D0B[2]], 9000, 2500);
  thread _id_9ABF(level._id_1D0B[4], [level._id_1D0B[3], level._id_1D0B[5]], 9000, 2500);
  level._id_D127 notify("launch_complete");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(9.1);
  scripts\sp\utility::_id_2669("space_approach");
  _id_0BDC::_id_A301(1.0, 1.0, "pearl");
  _id_0BDC::_id_A302(1.0, 3.0, "pearl");
  _id_0BDC::_id_D190();
  _id_0BDC::_id_A156(0);
  _id_0BDC::_id_A1DD(undefined);
  _id_0BDC::_id_A15C(0);
  level.player _meth_8463("moveto");
  level.player _meth_8463("orient");
  level.player _meth_8463("lookat");
  var_5 = level._id_111D0._id_1022B;
  var_6 = level._id_111D0._id_6C28;
  var_7 = level._id_111D0._id_6C27;
  var_8 = level._id_111D0._id_6C23;
  var_9 = 12;
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C46(var_6, var_7, var_9);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C44(var_5, var_9);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C47(var_8, var_9);
  thread _id_28B8();
}

_id_4092() {
  level waittill("launch_hud_off");
  wait 5;
  level._id_D299 delete();

  if(isDefined(level._id_D2A1))
    level._id_D2A1 delete();
}

_id_10C76() {
  level._id_3662 _id_0BB6::_id_39A3(1);
  level._id_3663 _id_0BB6::_id_39A3(1);
  level._id_3664 _id_0BB6::_id_39A3(1);
  level._id_3665 _id_0BB6::_id_39A3(1);
}

_id_1120E() {}

_id_28B8() {
  if(level.console || level.player usinggamepad())
    scripts\sp\utility::_id_56BA("basic_controls");
  else
    scripts\sp\utility::_id_56BA("basic_controls_pc");

  _id_8FF1();
  wait 0.5;

  if(level.console || level.player usinggamepad())
    scripts\sp\utility::_id_56BA("basic_boosters");
  else
    scripts\sp\utility::_id_56BA("basic_boosters_pc");

  _id_8FF2();
}

_id_8FF1() {
  var_0 = 1;
  var_1 = -1;

  for(;;) {
    var_2 = level.player getnormalizedmovement();
    var_3 = level.player _meth_814B();

    if(abs(var_2[0]) > 0.3 || abs(var_2[1]) > 0.3 || abs(var_3[0]) > 0.3 || abs(var_3[1]) > 0.3) {
      if(var_1 == -1)
        var_1 = gettime() / 1000;
      else if(gettime() / 1000 - var_1 > var_0) {
        break;
      }
    } else
      var_1 = -1;

    wait 0.05;
  }

  scripts\engine\utility::flag_set("hint_did_basics");
}

_id_8FF2() {
  var_0 = 1;
  var_1 = -1;

  for(;;) {
    if(level.player issprinting()) {
      if(var_1 == -1)
        var_1 = gettime() / 1000;
      else if(gettime() / 1000 - var_1 > var_0) {
        break;
      }
    } else
      var_1 = -1;

    wait 0.05;
  }

  scripts\engine\utility::flag_set("hint_did_boosters");
}

_id_8FF3() {
  var_0 = 0.2;
  var_1 = -1;

  for(;;) {
    if(level.player buttonPressed("BUTTON_A") || level.player buttonPressed("BUTTON_B")) {
      if(var_1 == -1)
        var_1 = gettime() / 1000;
      else if(gettime() / 1000 - var_1 > var_0) {
        break;
      }
    } else
      var_1 = -1;

    wait 0.05;
  }

  scripts\engine\utility::flag_set("hint_did_updown");
}

_id_D868(var_0) {
  level._id_12B51 = _id_FD5A("un_convoy_ship01", "una1", 1, 1, 1, 1, 0, "cannon_large_un missile_tube_un");
  level._id_12B51._id_E7D0 = 0;
  level._id_12B51._id_12FBA = 1;
  thread scripts\sp\maps\phspace\phspace::_id_107F6();

  if(scripts\engine\utility::is_true(var_0))
    wait 4.8;

  thread scripts\sp\maps\phspace\phspace::_id_107B6();
  level._id_3662 = _id_FD5A("sdf_background_ship01", "ca1", 0, 0, 0, 0);
  level._id_3663 = _id_FD5A("sdf_background_ship02", "ca2", 0, 0, 0, 0);
  level._id_3664 = _id_FD5A("sdf_background_ship03", "ca3", 0, 0, 0, 0);
  level._id_3665 = _id_FD5A("sdf_background_ship04", "ca4", 0, 0, 0, 0);
  wait 0.05;
  thread _id_F903();
  var_1 = 200;
  var_2 = 15000;
  var_3 = 0.4;
  var_4 = 0.75;
  var_5 = 13000;
  var_6 = 3000;
  var_7 = 1000;
  level._id_3662 _id_0BDC::_id_A16E(var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
  level._id_3663 _id_0BDC::_id_A16E(var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
  level._id_3664 _id_0BDC::_id_A16E(var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
  level._id_3665 _id_0BDC::_id_A16E(var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
  level._id_12B7D solid();
  level._id_12B67 solid();
  level._id_12B7D _id_0BB8::_id_39CD("heavy");
  level._id_12B7D _id_0BB8::_id_39D0("idle");
  level._id_12B7D _id_0BB8::_id_39CE("high");
  level._id_12B67 _id_0BB8::_id_39CD("heavy");
  level._id_12B67 _id_0BB8::_id_39D0("idle");
  level._id_12B67 _id_0BB8::_id_39CE("high");
  level._id_12B51 _id_0BB8::_id_39CE("low");
  level._id_3662 _id_0BB8::_id_39CE("low");
  level._id_3663 _id_0BB8::_id_39CE("high");
  level._id_3664 _id_0BB8::_id_39CE("high");
  level._id_3665 _id_0BB8::_id_39CE("low");
  level._id_3662._id_129D9 = 0;
  level._id_3663._id_129D9 = 1;
  level._id_3664._id_129D9 = 1;
  level._id_3665._id_129D9 = 0;
  level._id_3662._id_C9A2 = "patrol_s1";
  level._id_3663._id_C9A2 = "patrol_s2";
  level._id_3664._id_C9A2 = "patrol_s3";
  level._id_3665._id_C9A2 = "patrol_s4";
  level._id_3662._id_13D86 = ["ship_assault1_port_positions", "ship_assault1_starboard_positions"];
  level._id_3663._id_13D86 = ["ship_assault2_port_positions", "ship_assault2_starboard_positions"];
  level._id_3664._id_13D86 = ["ship_assault3_port_positions", "ship_assault3_starboard_positions"];
  level._id_3665._id_13D86 = ["ship_assault4_port_positions", "ship_assault4_starboard_positions"];
  level._id_3662 thread _id_FA45();
  level._id_3663 thread _id_FA45();
  level._id_3664 thread _id_FA45();
  level._id_3665 thread _id_FA45();

  if(level._id_10CDA == "hvt_handoff" || level._id_10CDA == "jackals" || level._id_10CDA == "jackals_reveal" || level._id_10CDA == "space_approach" || level._id_10CDA == "test_lighttweaks_enabled") {
    level._id_12B4A = _id_FD5A("un_background_ship02", "unb2", 1, 1, 1, 1);
    level._id_12B4C = _id_FD5A("un_background_ship03", "unb3", 1, 1, 1, 1);
    wait 0.05;
    level._id_12B60 = _id_FD5A("un_midground_ship01", "unm1", 0, 0, 0, 0);
    level._id_12B61 = _id_FD5A("un_midground_ship02", "unm2", 0, 0, 0, 0);
    level._id_12B60._id_4E09 = "vfx_destroyer_death_cheap";
    level._id_12B61._id_4E09 = "vfx_destroyer_death_cheap";
    wait 0.05;
    level._id_12B4A _id_0BB8::_id_39CE("off");
    level._id_12B4C _id_0BB8::_id_39CE("off");
  }

  if(level._id_10CDA == "trench_run" || level._id_10CDA == "ram") {
    var_8 = getEnt("ca_olympus", "targetname");
    var_8._id_EEF9 = "none";
    level._id_3670 = scripts\sp\vehicle::_id_1080C("ca_olympus");
    level._id_3670 _id_0BB8::_id_39CD("off");
    level._id_3670 _id_0BB8::_id_39D0("off");
    level._id_3670 _id_0BB8::_id_39CE("off");
    level._id_3670 thread scripts\sp\maps\phspace\phspace_mons::_id_F051();
    scripts\engine\utility::flag_set("olympus_arrived");
  }

  wait 0.05;
  scripts\engine\utility::flag_set("prespawn_done");
}

_id_F903() {}

_id_FE2F() {
  switch (level._id_10CDA) {
    case "space_approach":
      break;
    case "jackal_assault":
      var_0 = getvehiclenode("sdf_background_ship01_approach_pos", "targetname");
      var_1 = getvehiclenode("sdf_background_ship02_approach_pos", "targetname");
      var_2 = getvehiclenode("sdf_background_ship03_approach_pos", "targetname");
      var_3 = getvehiclenode("sdf_background_ship04_approach_pos", "targetname");
      level._id_3662 vehicle_teleport(var_0.origin, var_0.angles);
      level._id_3663 vehicle_teleport(var_1.origin, var_1.angles);
      level._id_3664 vehicle_teleport(var_2.origin, var_2.angles);
      level._id_3665 vehicle_teleport(var_3.origin, var_3.angles);
      var_4 = getvehiclenode("retribution_last_pos", "targetname");
      level._id_12B67 vehicle_teleport(var_4.origin, var_4.angles);
      var_4 = getvehiclenode("un_tigris_last_pos", "targetname");
      level._id_12B7D vehicle_teleport(var_4.origin, var_4.angles);
      var_4 = getvehiclenode("un_convoy_ship01_last_pos", "targetname");
      level._id_12B51 vehicle_teleport(var_4.origin, var_4.angles);
      break;
    case "ship_assault":
      _id_FE30(0, 1, 1, 0, 1);
      break;
    case "mons_intro":
      _id_FE30(0, 1, 1, 1, 1);
      break;
    case "trench_run":
      _id_FE30(1, 1, 1, 1, 1);
      break;
    case "ram":
      _id_FE30(1, 1, 1, 1, 1);
      break;
    case "landing":
      var_4 = getvehiclenode("retribution_last_pos", "targetname");
      level._id_12B67 vehicle_teleport(var_4.origin, var_4.angles);
      break;
    default:
      break;
  }
}

_id_FE30(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getvehiclenode("sdf_background_ship01_last_pos", "targetname");
  var_6 = getvehiclenode("sdf_background_ship02_last_pos", "targetname");
  var_7 = getvehiclenode("sdf_background_ship03_last_pos", "targetname");
  var_8 = getvehiclenode("sdf_background_ship04_last_pos", "targetname");
  level._id_3662 vehicle_teleport(var_5.origin, var_5.angles);
  level._id_3663 vehicle_teleport(var_6.origin, var_6.angles);
  level._id_3664 vehicle_teleport(var_7.origin, var_7.angles);
  level._id_3665 vehicle_teleport(var_8.origin, var_8.angles);
  var_9 = getvehiclenode("retribution_last_pos", "targetname");
  level._id_12B67 vehicle_teleport(var_9.origin, var_9.angles);
  var_9 = getvehiclenode("un_tigris_last_pos", "targetname");
  level._id_12B7D vehicle_teleport(var_9.origin, var_9.angles);
  var_9 = getvehiclenode("un_convoy_ship01_last_pos", "targetname");
  level._id_12B51 vehicle_teleport(var_9.origin, var_9.angles);
  wait 0.1;

  if(scripts\engine\utility::is_true(var_1))
    level._id_52D1 = scripts\engine\utility::array_add(level._id_52D1, level._id_3662 _id_0BA9::_id_39AC());

  if(scripts\engine\utility::is_true(var_2))
    level._id_52D1 = scripts\engine\utility::array_add(level._id_52D1, level._id_3663 _id_0BA9::_id_39AC());

  if(scripts\engine\utility::is_true(var_3))
    level._id_52D1 = scripts\engine\utility::array_add(level._id_52D1, level._id_3664 _id_0BA9::_id_39AC());

  if(scripts\engine\utility::is_true(var_4))
    level._id_52D1 = scripts\engine\utility::array_add(level._id_52D1, level._id_3665 _id_0BA9::_id_39AC());
}

_id_12B5F(var_0) {
  if(isDefined(var_0))
    wait(var_0);

  level._id_12B50 = _id_FD5A("un_convoy_ship00", "un0", 0, 0, 0, 0, 1, "cannon_large_un missile_tube_un");
  level._id_12B54 = _id_FD5A("un_convoy_ship03", "un3", 0, 0, 0, 0, 1, "cannon_large_un missile_tube_un");
  level._id_12B53 = _id_FD5A("un_convoy_ship02", "un2", 0, 0, 0, 0, 1, "cannon_large_un missile_tube_un");
  wait 0.05;
  level._id_12B55 = _id_FD5A("un_convoy_ship04", "un4", 0, 0, 0, 0, 1, "cannon_large_un missile_tube_un");
  level._id_12B56 = _id_FD5A("un_convoy_ship05", "un5", 0, 0, 0, 0, 1, "cannon_large_un missile_tube_un");
  level._id_12B50 _id_0BB8::_id_39CE("low");
  level._id_12B54 _id_0BB8::_id_39CE("low");
  level._id_12B55 _id_0BB8::_id_39CE("low");
  level._id_12B56 _id_0BB8::_id_39CE("low");
  level._id_12B53 _id_0BB8::_id_39CE("low");
}

_id_FD5A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_7)) {
    var_8 = getEnt(var_0, "targetname");
    var_8._id_EEF9 = var_7;
  }

  if(!isDefined(var_6))
    var_6 = 0;

  var_9 = scripts\sp\vehicle::_id_1080D(var_0);

  if(var_6)
    var_9 thread _id_0BB6::_id_39E9(var_6);

  var_9.delete_on_death = 1;
  var_9 scripts\sp\vehicle::_id_8441();
  var_9 thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13248();

  if(var_9._id_6A8D == "un") {
    var_9 scripts\engine\utility::delaythread(0.8, _id_0BB8::_id_39CD, "idle");
    var_9 scripts\engine\utility::delaythread(0.8, _id_0BB8::_id_39D0, "idle");
  } else {
    var_9 scripts\engine\utility::delaythread(0.8, _id_0BB8::_id_39CD, "idle");
    var_9 scripts\engine\utility::delaythread(0.8, _id_0BB8::_id_39D0, "idle");
  }

  var_9 castdistantshadows();
  return var_9;
}

_id_CADA() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(4.5);
  level._id_EA99 scripts\sp\utility::_id_10346("phspace_slt_yougoteyesonthi");
  scripts\sp\utility::_id_1034D("phspace_plr_affirmative");
  level._id_EA99 scripts\sp\utility::_id_10346("phspace_slt_youknowit");
  scripts\sp\utility::_id_1034D("phspace_plr_letsgetinthere");
  level._id_EA99 thread scripts\sp\utility::_id_10346("phspace_slt_always");
  scripts\sp\maps\phspace\phspace_launch::_id_104EF();
  _id_D0B6();
}

_id_D0B6() {
  _id_0BDC::_id_A153(0);
  _id_0BDC::_id_A15B(0);
  _id_0BDC::_id_A14A(0);
  _id_0BDC::_id_A149(0);
  _id_0BDC::_id_A160(0, 0.5);
  wait 2.0;
  level.player allowads(1);
}

_id_12B4D() {
  thread _id_0BA9::_id_397A(self.origin, 3);
  wait 3;
  level.player playSound("phspace_reveal_explo_lr");
  self hide();
  self._id_4E09 = undefined;
  self._id_9310 = 1;
  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0 setModel("tag_origin");
  playFXOnTag(level._effect["vfx_generic_ship_death"], var_0, "tag_origin");
  self _meth_81D0();
  wait 0.4;
  earthquake(0.07, 3, level._id_D127.origin, 10000);
  wait 3.2;
  earthquake(0.11, 4, level._id_D127.origin, 10000);
}

_id_20E9() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(12.5);
  thread phspace_audio_mix_for_2nd_explosion();
  var_0 = getEnt("trigger_shoot_missiles_at_player", "targetname");
  var_0 _id_0BDC::_id_136A6(level._id_D127);
  wait 3;
  level._id_3664 thread _id_0BB6::_id_3966(1, 0, level._id_12B4C);
  wait 1;
  level._id_EA99 thread _id_6FF4("ship_1_ally_goal_right");
  level._id_1CB9 thread _id_6FF4("ship_1_ally_goal_left");
  level._id_3662 thread _id_0BB6::_id_3984(level._id_D127);
  wait 4;
}

phspace_audio_mix_for_2nd_explosion() {
  level.player _meth_82C0("phspace_intro_cap_ship_explo_2", 2.0);
  wait 15;
  level.player _meth_82C0("jackal_cockpit", 2.0);
}

_id_6FF4(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  _id_0BDC::_id_19B7();
  _id_0BDC::_id_19A2();
  _id_0BDC::_id_19AB(600);
  self _meth_83A1();
  _id_0BDC::_id_A1EC(var_1.origin, 1, 10000, var_1.angles);
}

_id_7318(var_0, var_1) {
  if(!isDefined(var_0) || !var_0) {
    var_2 = getEnt("trigger_allies_form_up", "targetname");
    var_2 _id_0BDC::_id_136A6(level._id_D127);
  }

  var_3 = (-1000, 700, 800);
  var_4 = (-700, 700, 800);
  var_5 = (3000, 700, 200);
  var_6 = (500, 3800, 2400);
  level._id_EA99 _meth_83A1();
  level._id_EA99 _id_0BDC::_id_19B0("fly");
  level._id_EA99 _id_0BDC::_id_1986();

  if(!isDefined(var_1) || isDefined(var_1) && var_1) {
    var_7 = level._id_D127.origin + rotatevector(var_3, level._id_D127.angles);
    level._id_EA99 vehicle_teleport(var_7, level._id_D127.angles);
  }

  wait 0.05;
  level._id_EA99 _id_0BDC::_id_19AB(1200);
  level._id_EA99 _id_0BDC::_id_1994(level._id_D127, var_4, 200, 0.1, 4000, 1.0);
  wait 0.05;
  level._id_EA99 _id_0BDC::_id_19AB(1200);
  level._id_EA99 _id_0BDC::_id_199D(4, var_5, 300, 0.08, 10000, 1.0);
}

_id_7317(var_0, var_1) {
  if(!isDefined(var_0) || !var_0) {
    var_2 = getEnt("trigger_allies_form_up", "targetname");
    var_2 _id_0BDC::_id_136A6(level._id_D127);
  }

  var_3 = (-1000, -700, 800);
  var_4 = (-700, -700, 800);
  var_5 = (4000, -900, 400);
  var_6 = (1000, -3800, 2400);
  level._id_1CB9 _meth_83A1();
  level._id_1CB9 _id_0BDC::_id_19B0("fly");
  level._id_1CB9 _id_0BDC::_id_1986();

  if(!isDefined(var_1) || isDefined(var_1) && var_1) {
    var_7 = level._id_D127.origin + rotatevector(var_3, level._id_D127.angles);
    level._id_1CB9 vehicle_teleport(var_7, level._id_D127.angles);
  }

  wait 0.05;
  level._id_1CB9 _id_0BDC::_id_19AB(1200);
  level._id_1CB9 _id_0BDC::_id_1994(level._id_D127, var_4, 200, 0.1, 4000, 1.0);
  wait 0.05;
  level._id_1CB9 _id_0BDC::_id_19AB(1200);
  level._id_1CB9 _id_0BDC::_id_199D(4, var_5, 300, 0.08, 7000, 1.0);
}

_id_2731() {
  var_0 = spawnStruct();
  var_0._id_6D20 = 0.08;
  var_0._id_13535 = [8, 14];
  var_0._id_B46E = 8;
  var_0._id_6CF8 = _id_0BB6::_id_6D0C;
  level._id_39DD["missile_tube_ca"]._id_10241 = var_0;
  level._id_12B60._id_12FBA = 1;
  level._id_12B61._id_12FBA = 1;
  level._id_12B4C._id_12FBA = 1;
  level._id_12B67._id_12FBA = 1;
  level._id_12B7D._id_12FBA = 1;
  wait 0.1;
  level._id_12B60 thread _id_0BB6::_id_3966(1, 0, level._id_3662);
  level._id_12B61 thread _id_0BB6::_id_3966(1, 0, level._id_3663);
  level._id_12B4C thread _id_0BB6::_id_3966(1, 0, level._id_3664);
  level._id_12B7D thread _id_0BB6::_id_3966(1, 0, level._id_3664);
  level._id_12B4C _id_0BB6::_id_398A(1);
  wait 0.1;
  level._id_3662 _id_0BB6::_id_398A(1);
  level._id_3663 _id_0BB6::_id_398A(1);
  level._id_3664 _id_0BB6::_id_398A(1);
  level._id_3665 thread _id_0BB6::_id_3983(level._id_12B60);
  level._id_3662 thread _id_0BB6::_id_3983(level._id_12B61);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(2.8);
  level._id_12B51 _id_0BB6::_id_3984(level._id_3662);
  level._id_12B60 _id_0BB6::_id_3984(level._id_3662);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(3.1);
  level._id_12B67 _id_0BB6::_id_3984(level._id_3665);
  level._id_12B7D _id_0BB6::_id_3984(level._id_3665);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(3.4);
  level._id_3665 thread _id_0BB6::_id_3983(level._id_12B4A);
  level._id_3662 thread _id_0BB6::_id_3983(level._id_12B4A);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(3.8);
  level._id_12B51 _id_0BB6::_id_3984(level._id_3662);
  level._id_12B61 _id_0BB6::_id_3984(level._id_3663);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(4.1);
  level._id_12B67 _id_0BB6::_id_3984(level._id_3665);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(4.5);
  level._id_12B7D _id_0BB6::_id_3984(level._id_3665);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(5);
  level._id_12B51 _id_0BB6::_id_3984(level._id_3662);
  level._id_12B61 _id_0BB6::_id_3984(level._id_3663);
  level._id_3662 thread _id_0BB6::_id_3984(level._id_12B60);
  level._id_3663 thread _id_0BB6::_id_3984(level._id_12B60);
  level._id_3664 thread _id_0BB6::_id_3984(level._id_12B61);
  level._id_3665 thread _id_0BB6::_id_3984(level._id_12B61);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(5.7);
  level._id_12B51 _id_0BB6::_id_3984(level._id_3662);
  level._id_12B60 _id_0BB6::_id_3984(level._id_3662);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(6.3);
  level._id_12B7D _id_0BB6::_id_3984(level._id_3665);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(7.0);
  level._id_12B67 _id_0BB6::_id_3984(level._id_3665);
  level._id_12B61 _id_0BB6::_id_3984(level._id_3663);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(8);
  level._id_12B67 _id_0BB6::_id_3984(level._id_3665);
  level._id_12B60 _id_0BB6::_id_3984(level._id_3662);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(9.5);
  level._id_3664 thread _id_0BB6::_id_3966(1, 0, level._id_12B4C);
  level._id_3662 _id_0BB6::_id_398A(0);
  var_0._id_6D20 = 0.05;
  var_0._id_13535 = [15, 18];
  var_0._id_B46E = 4;
  var_0._id_6CF8 = _id_0BB6::_id_6D0C;
  level._id_39DD["missile_tube_ca"]._id_10241 = var_0;
  level._id_12B4C thread _id_0BB6::_id_3966(1, 0, level._id_3664);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(11);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(12);
  level._id_12B7D.turrets["cap_turret_cannon_large_un"][4] thread _id_0BB6::_id_129DF();
  level._id_12B7D.turrets["cap_turret_cannon_large_un"] = scripts\engine\utility::array_remove(level._id_12B7D.turrets["cap_turret_cannon_large_un"], level._id_12B7D.turrets["cap_turret_cannon_large_un"][4]);
  level._id_12B67 _id_0BB6::_id_3984(level._id_3665);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(14);
  level._id_12B61 _meth_81D0();
  level._id_3665 thread _id_720F(1, 1);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13801(16.2);
  level._id_12B60 _meth_81D0();
}

_id_12B7E() {
  var_0 = getvehiclenode("space_path_tigris", "targetname");
  scripts\sp\vehicle::_id_2471(var_0);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13248();
  _id_0BB8::_id_39CD("heavy");
  _id_0BB8::_id_39D0("idle");
}

_id_12B68() {
  self _meth_83A1();
  var_0 = getvehiclenode("space_path_ret", "targetname");
  scripts\sp\vehicle::_id_2471(var_0);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13248();
  _id_0BB8::_id_39CD("heavy");
  _id_0BB8::_id_39D0("idle");
}

_id_12B52() {
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_13248();
  _id_0BB8::_id_39CD("heavy");
  _id_0BB8::_id_39D0("idle");
}

_id_493A() {
  var_0 = (2, 2, 2);
  var_1 = (4500, 0, 0);
  var_2 = [];
  var_2[0] = _id_491E(level._id_D127, 1000, -2400, 300, 1, "1", var_0, var_1, 1);
  var_2[1] = _id_491E(level._id_D127, 100, -500, 1000, 1, "2", var_0, var_1, 1);
  var_2[2] = _id_491E(level._id_D127, 1000, 300, -500, 1, "3", var_0, var_1, 1);
  var_2[3] = _id_491E(level._id_D127, 300, -600, -300, 1, "4", var_0, var_1, 1);
  var_2[4] = _id_491E(level._id_D127, 1300, -250, 750, 1, "5", var_0, var_1, 1);
  var_2[5] = _id_491E(level._id_D127, 300, 1500, 200, 1, "6", var_0, var_1, 1);
  var_2[6] = _id_491E(level._id_D127, 150, -700, 200, 1, "7", var_0, var_1, 1);
  var_2[7] = _id_491E(level._id_D127, 1000, 750, -600, 1, "8", var_0, var_1, 1);
  var_2[8] = _id_491E(level._id_D127, 450, -300, 100, 1, "9", var_0, var_1, 1);
  var_2[9] = _id_491E(level._id_D127, 600, 750, 500, 1, "10", var_0, var_1, 1);
  var_2[10] = _id_491E(level._id_D127, 1050, 500, -500, 1, "11", var_0, var_1, 1);
  var_2[11] = _id_491E(level._id_D127, 600, -650, 400, 0, "12", var_0, var_1, 1);
  var_2[12] = _id_491E(level._id_D127, 150, 750, 400, 0, "13", var_0, var_1, 1);
  var_2[13] = _id_491E(level._id_D127, 1000, -210, 500, 0, "14", var_0, var_1, 1);
  var_2[14] = _id_491E(level._id_D127, 10, 750, 300, 0, "15", var_0, var_1, 1);
  var_2[15] = _id_491E(level._id_D127, 700, -2400, 300, 1, "1", var_0, var_1, 1);
  var_2[16] = _id_491E(level._id_D127, 1300, -500, 1000, 1, "2", var_0, var_1, 1);
  var_2[17] = _id_491E(level._id_D127, 200, 300, -500, 1, "3", var_0, var_1, 1);
  var_2[18] = _id_491E(level._id_D127, 60, -700, -300, 1, "4", var_0, var_1, 1);
  var_2[19] = _id_491E(level._id_D127, 1500, -250, 750, 1, "5", var_0, var_1, 1);
  var_2[20] = _id_491E(level._id_D127, 1700, 1500, -600, 1, "6", var_0, var_1, 1);
  var_2[21] = _id_491E(level._id_D127, 150, -700, 200, 1, "7", var_0, var_1, 1);
  var_2[22] = _id_491E(level._id_D127, 100, 750, -600, 1, "8", var_0, var_1, 1);
  var_2 = scripts\engine\utility::array_reverse(var_2);
  return var_2;
}

_id_493B() {
  var_0 = (2, 1, 1);
  var_1 = (3500, 2000, 4000);
  var_2 = [];
  var_2[0] = _id_491E(level._id_D127, 1000, -2400, 300, 1, "1", var_0, var_1, 1);
  var_2[1] = _id_491E(level._id_D127, 100, -500, 1000, 1, "2", var_0, var_1, 1);
  var_2[2] = _id_491E(level._id_D127, 1000, 300, -500, 1, "3", var_0, var_1, 1);
  var_2[3] = _id_491E(level._id_D127, 300, -600, -300, 1, "4", var_0, var_1, 1);
  var_2[4] = _id_491E(level._id_D127, 1300, -250, 750, 1, "5", var_0, var_1, 1);
  var_2[5] = _id_491E(level._id_D127, 300, 1500, 200, 1, "6", var_0, var_1, 1);
  var_2[6] = _id_491E(level._id_D127, 150, -700, 200, 1, "7", var_0, var_1, 1);
  var_2[7] = _id_491E(level._id_D127, 1000, 750, -600, 1, "8", var_0, var_1, 1);
  var_2[8] = _id_491E(level._id_D127, 450, -300, 100, 1, "9", var_0, var_1, 1);
  var_2[9] = _id_491E(level._id_D127, 600, 750, 500, 1, "10", var_0, var_1, 1);
  var_2[10] = _id_491E(level._id_D127, 1050, 500, -500, 1, "11", var_0, var_1, 1);
  var_2 = scripts\engine\utility::array_reverse(var_2);
  return var_2;
}

_id_B7F9(var_0, var_1, var_2) {
  var_3 = [];

  if(isDefined(self._id_8B4F["cap_hardpoint_missile_barrage"])) {
    var_3 = self._id_8B4F["cap_hardpoint_missile_barrage"];
    var_4 = "cannon_missile_ca_hardpoint";
    var_5 = level._id_39DD[var_4]._id_10241;
  } else if(isDefined(self._id_8B4F["cap_missile_tube_ca"])) {
    var_3 = self._id_8B4F["cap_missile_tube_ca"];
    var_4 = "missile_tube_ca";
    var_5 = level._id_39DD[var_4]._id_10241;
  }

  var_6 = _id_0B76::_id_A26D(0.2, 0.4, 300, 0.2, 0.4, 300);
  var_7 = 600;
  var_8 = 250;
  var_9 = 2.3;

  foreach(var_16, var_11 in var_0) {
    if(!isDefined(var_3[var_16])) {
      continue;
    }
    var_12 = var_3[var_16];
    var_13 = self gettagangles(var_12.tag);
    var_14 = (randomintrange(var_1 * -1, var_1), randomintrange(var_1 * -1, var_1), randomintrange(var_1 * -1, var_1) + 1000);
    var_15 = scripts\engine\utility::spawn_tag_origin();
    var_15.origin = self gettagorigin(var_12.tag) + anglesToForward(var_13) * 150;
    var_15.angles = var_13;
    var_15.angles = var_15.angles - (-10, 15, 0);
    var_15._id_01CF = 20;

    if(isDefined(level._id_D127) && var_11 == level._id_D127) {
      var_12 thread _id_0B76::_id_A278();

      if(isDefined(var_2) && var_2)
        var_15 thread _id_1547();

      var_15 thread _id_0B76::_id_A279(0);
    }

    self._id_AA99 = "capitalship_missile_launch";
    var_15 thread _id_0B76::_id_A332(var_0[var_16], 0, self, undefined, var_7, var_14, 0, undefined, var_8, 1, var_9, 1, undefined, var_6, 300);
    wait 0.2;
  }
}

_id_1547() {
  self endon("death");

  while(!isDefined(self._id_6E8B))
    wait 0.05;

  self._id_B464 = 2000;
  self._id_1545 = 30;
}

_id_491E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_8))
    var_8 = 0;

  var_1 = var_1 * var_6[0];
  var_1 = var_1 + var_7[0];
  var_2 = var_2 * var_6[1];
  var_2 = var_2 + var_7[1];
  var_3 = var_3 * var_6[2];
  var_3 = var_3 + var_7[2];

  if(var_8)
    var_7 = anglesToForward(var_0.angles) * var_1 + anglestoright(var_0.angles) * var_2 + anglestoup(var_0.angles) * var_3;
  else
    var_7 = (var_1, var_2, var_3);

  var_9 = spawn("script_origin", var_0.origin + var_7);
  var_9 linkTo(var_0);
  var_9._id_1A89 = var_4;
  var_9._id_5F27 = 1;
  return var_9;
}

_id_104B4() {
  scripts\engine\utility::flag_set("hint_did_basics");
  scripts\engine\utility::flag_set("hint_did_boosters");
  thread _id_104B5();
}

_id_104B5() {}

_id_A0AC() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_F5A4();
  scripts\sp\maps\phspace\phspace::_id_107C0();
  scripts\sp\maps\phspace\phspace::_id_1062E();
  level._id_EA99 _id_0BDC::_id_6B4C("space", 0);
  level._id_1CB9 _id_0BDC::_id_6B4C("space", 0);
  var_0 = scripts\sp\vehicle::_id_1080C("player_jackal");
  _id_0BDC::_id_10CD1(var_0);
  wait 0.05;
  var_1 = scripts\engine\utility::getStruct("jackal_assault_start", "targetname");
  level._id_D127 vehicle_teleport(var_1.origin, var_1.angles);
  thread _id_D868();
  scripts\engine\utility::flag_wait("prespawn_done");
  thread scripts\sp\maps\phspace\phspace::_id_1062B();

  foreach(var_0 in level._id_1D0B)
  var_0 thread _id_1D75(1, 0, 1);

  thread _id_FE2F();
  thread _id_7318(1);
  thread _id_7317(1);
  thread _id_23A3();
}

_id_A0A9() {
  level._id_A242 = 0;
  level._id_A1A3 = 0;
  level._id_B434 = 14;
  level._id_A243 = 10;
  level._id_A37C = 180;
  var_0 = 3;
  var_1 = 5;
  var_2 = 8;
  var_3 = level._id_A37C / 4;
  var_4 = level._id_A37C / 4 * 2;
  var_5 = level._id_A37C / 4 * 3;
  level._id_A259 = [];
  level._id_A259[0] = [3, var_3, 10];
  level._id_A259[1] = [5, var_4, 7];
  level._id_A259[2] = [8, var_5, 4];
  level._id_A259[3] = [10, var_5 / 2, 0];

  if(getdvarint("exec_review", 0)) {
    level._id_A243 = 7;
    level._id_A37C = 120;
    var_0 = 2;
    var_1 = 4;
    var_2 = 6;
    var_3 = level._id_A37C / 4;
    var_4 = level._id_A37C / 4 * 2;
    var_5 = level._id_A37C / 4 * 3;
    level._id_A259 = [];
    level._id_A259[0] = [3, var_3, 10];
    level._id_A259[1] = [5, var_4, 7];
    level._id_A259[2] = [6, var_5, 4];
    level._id_A259[3] = [7, var_5 / 2, 0];
  } else if(getdvarint("e3", 0) || getdvarint("e3_ending", 0)) {
    level._id_A243 = 4;
    level._id_A37C = 75;
    var_0 = 1;
    var_1 = 2;
    var_2 = 3;
    var_3 = level._id_A37C / 4;
    var_4 = level._id_A37C / 4 * 2;
    var_5 = level._id_A37C / 4 * 3;
    level._id_A259 = [];
    level._id_A259[0] = [2, var_3, 10];
    level._id_A259[1] = [3, var_4, 5];
    level._id_A259[2] = [4, var_5, 0];
  }

  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\utility::_id_266A("jackal_assault");
  thread _id_6E99();
  scripts\engine\utility::flag_set("move_to_assault_pos");
  thread _id_A0A6();

  if(level._id_10CDA == "jackal_assault") {
    level._id_EA99 thread _id_6FF4("ship_1_ally_goal_right");
    level._id_1CB9 thread _id_6FF4("ship_1_ally_goal_left");
  }

  _id_A0A8();
  scripts\engine\utility::flag_set("jackal_assault_intro_done");
  _id_0BDC::_id_A1A9(0);
  thread _id_A1CC();
  level._id_58A4 = gettime() / 1000;
  thread _id_5886();
  level._id_EA99 thread _id_A0AA(2, "patrol_axis");
  level._id_1CB9 thread _id_A0AA(2, "patrol_axis");
  level._id_3662._id_12FBA = 1;
  level._id_3663._id_12FBA = 1;
  level._id_3665._id_12FBA = 1;
  level._id_3663 thread _id_F031(1, 1, var_1, var_4);
  level._id_3664 thread _id_F031(1, 1);
  level._id_3665 thread _id_F031(1, 1, var_0, var_3);
  level._id_3662 scripts\engine\utility::delaythread(13, ::_id_728B, 1, 0);
  wait 5.0;

  while(level._id_A242 < level._id_A243 && gettime() / 1000 - level._id_58A4 < level._id_A37C && level._id_A1A3 > 0)
    wait 0.2;

  if(getdvarint("e3", 1)) {
    scripts\sp\utility::_id_F305();

    if(scripts\sp\utility::_id_9BEE()) {
      if(level._id_DADC)
        setsaveddvar("r_postaa", 0);
    }
  }

  wait 5.0;
  level notify("stop_dogfight_bcs");
  scripts\engine\utility::flag_set("jackal_assault_complete");
  thread _id_A0A5();
}

_id_A0A6() {
  wait 2.0;
  scripts\sp\utility::_id_10350("phspace_aic_allscarsengaget");
  scripts\engine\utility::flag_wait("jackal_assault_intro_done");
  wait 3.5;
  level._id_EA99 scripts\sp\utility::_id_10346("phspace_slt_theyrelaunchin");
  scripts\engine\utility::flag_set("obj_sdf_squadron_start");
  thread _id_A0A7();
  thread _id_5878();
  wait 4;
  _id_0BDC::_id_A162(0);
}

_id_A0A7() {
  var_0 = 3;
  scripts\sp\utility::_id_56BE("hint_shoot_jackals", var_0);

  if(scripts\sp\utility::_id_93A6()) {
    return;
  }
  wait(var_0);
  scripts\sp\utility::_id_56BA("hint_lockon");
  level endon("player_did_lockon");
  scripts\sp\utility::_id_10350("phspace_eth_lockontoatarget");
  wait 3.0;
  level._id_EA99 scripts\sp\utility::_id_10346("phspace_slt_getalockon");
  wait 8.0;
  level._id_EA99 scripts\sp\utility::_id_10346("phspace_slt_lockemup");
}

_id_6E99() {
  wait 8;
  level._id_3662._id_B825 = 950;
  level._id_3662._id_B821 = 20;
  level._id_3662._id_594B = 1;
  var_0 = _id_493A();
  var_0 = scripts\sp\utility::_id_22B3(var_0, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);
  var_1 = [15, 16, 17, 18];

  foreach(var_4, var_3 in var_0) {
    if(scripts\engine\utility::array_contains(var_1, var_4)) {
      var_0[var_4] delete();
      var_0[var_4] = level._id_D127;
    }
  }

  scripts\engine\utility::flag_set("jackal_noflare_hint");
  level._id_3662 thread _id_B7F9(var_0, 2500, 1);
  wait 1.77;
  scripts\engine\utility::flag_clear("jackal_noflare_hint");
  var_5 = ["phspace_slt_incomingmissil", "phspace_slt_warheadsinbo", "phspace_slt_shotsincoming", "phspace_slt_heatseekersfl"];
  var_6 = scripts\engine\utility::random(var_5);
  level._id_EA99 scripts\sp\utility::_id_10346(var_6);
}

_id_A0A8() {
  wait 3.3;
  wait 3;
  scripts\engine\utility::flag_set("all_jackals_start_patrol");
  level notify("stop_intro_speed_controller");
  wait 3.0;
}

_id_A1CC() {
  scripts\engine\utility::flag_wait("jackals_started_spawning");
  wait 2.0;
  var_0 = level._id_26EB._id_FE2D[0];

  foreach(var_2 in level._id_26EB._id_FE2D) {
    if(_id_0B76::_id_7A60(var_2.origin) < 0.4) {
      var_0 = var_2;
      break;
    }
  }

  var_0 endon("death");
  var_4 = anglesToForward(level._id_D127.angles);
  var_4 = vectorNormalize(var_4 * -1);
  var_5 = anglestoright(level._id_D127.angles);
  var_6 = level._id_D127.origin + var_4 * 500 + var_5 * 500;
  var_0 vehicle_teleport(var_6, level._id_D127.angles);
  var_7 = 144000000;
  var_8 = 0;
  var_0 _id_0BDC::_id_19AE("shoot_at_will");

  for(;;) {
    if(distancesquared(level._id_D127.origin, var_0.origin) > var_7) {
      break;
    }

    var_4 = anglesToForward(level._id_D127.angles);
    var_9 = anglestoup(level._id_D127.angles);
    var_10 = level._id_D127.origin + var_4 * 20000 + var_9 * 1000;
    var_11 = vectordot(var_4, vectorNormalize(level._id_D127.origin - var_0.origin));

    if(var_11 > 0)
      var_0 thread _id_0BDC::_id_19AB(1400);
    else {
      var_0 thread _id_0BDC::_id_19AB(700);

      if(var_8 == 0) {
        var_0 playSound("phspace_first_jackal_pass");
        var_8 = 1;
      }
    }

    var_0 thread _id_0BDC::_id_A1EC(var_10, 0);
    wait 0.2;
  }

  var_0 _id_0BDC::_id_19AB(550);
  var_0 _id_0BDC::_id_1986();
  var_0 _id_0BDC::_id_1990(1);
  var_0 _id_0BDC::_id_19AE("shoot_at_will");
  var_0 _id_0BDC::_id_19B3("patrol", "patrol_axis");
  var_0 _id_0BDC::_id_19B4("patrol");
}

_id_6AF6(var_0) {
  var_1 = 8;
  var_2 = spawn("script_model", level._id_D127.origin);
  var_2 setModel("tag_origin");
  var_2.angles = level._id_D127.angles + (90, 0, 0);
  var_2._id_B824 = 5000;
  var_2._id_B825 = 1300;
  var_2._id_B823 = 1300;
  var_2._id_B822 = 0.1;
  var_3 = anglestoup(level._id_D127.angles);
  var_4 = anglesToForward(level._id_D127.angles);
  var_5 = anglestoright(level._id_D127.angles);
  var_3 = vectorNormalize(var_3);
  var_4 = vectorNormalize(var_4);
  var_5 = vectorNormalize(var_5);

  while(var_1 > 0) {
    var_2.origin = level._id_D127.origin;
    var_6 = randomfloatrange(-3000, 1000);
    var_7 = randomfloatrange(500, 6000);
    var_8 = randomfloatrange(6000, 9000);

    if(scripts\engine\utility::cointoss())
      var_7 = var_7 * -1;

    var_9 = var_3 * var_6;
    var_10 = var_4 * var_8;
    var_11 = var_5 * var_7;
    var_2.origin = var_2.origin + var_9;
    var_2.origin = var_2.origin + var_10;
    var_2.origin = var_2.origin + var_11;
    var_12 = [];
    var_12[0] = "TAG_ORIGIN";
    var_2 _id_0B76::_id_1945(var_0, var_0._id_24C4, 1);
    var_1 = var_1 - 1;
    wait 0.1;
  }

  wait 1.0;
  var_2 delete();
}

_id_AA88(var_0) {
  var_1 = -1;
  var_2 = 2025000000;

  if(isDefined(var_0))
    var_2 = var_1 * var_1;

  while(var_1 == -1 || var_1 > var_2) {
    var_1 = distancesquared(level._id_D127.origin, self.origin);
    wait 0.1;
  }

  var_3 = _id_493A();
  thread _id_B7F9(var_3, 2500);
  wait 1.2;
  var_3 = _id_493B();
  thread _id_B7F9(var_3, 2500);
}

_id_10ACD(var_0, var_1) {
  if(isDefined(var_1))
    wait(var_1);

  if(self islinked())
    self unlink();

  self _meth_83A1();
  self.anims.state = "none";
  _id_0BDC::_id_6B4C("fly");
  thread _id_0BDC::_id_A1EF(scripts\sp\utility::_id_7C9A(var_0), 510, 5000);
  wait 1.0;
  self setneargoalnotifydist(5000);
  self waittill("near_goal");
  _id_0BDC::_id_19AB(550);
  _id_0BDC::_id_1986();
  _id_0BDC::_id_1990(1);
  _id_0BDC::_id_19AE("shoot_at_will");
  _id_0BDC::_id_19B3("patrol", "patrol_axis");
  _id_0BDC::_id_19B4("patrol");
}

_id_1D75(var_0, var_1, var_2) {
  self notify("new_patrol");
  self endon("death");
  self endon("new_patrol");
  _id_0BDC::_id_19B7();
  scripts\sp\vehicle::_id_8441();
  self._id_843F = 1;

  if(scripts\engine\utility::is_true(var_1) && scripts\engine\utility::cointoss())
    wait(randomfloatrange(0, 0.65));

  if(isDefined(var_2))
    wait(var_2);

  if(scripts\engine\utility::is_true(var_0)) {
    var_3 = anglestoup(level._id_D127.angles);
    var_4 = anglesToForward(level._id_D127.angles);
    var_5 = anglestoright(level._id_D127.angles);
    var_3 = vectorNormalize(var_3);
    var_4 = vectorNormalize(var_4);
    var_5 = vectorNormalize(var_5);
    var_6 = randomfloatrange(500, 2000);
    var_7 = randomfloatrange(500, 3500);
    var_8 = randomfloatrange(-500, 1500);

    if(scripts\engine\utility::cointoss())
      var_6 = var_6 * -1;

    if(scripts\engine\utility::cointoss())
      var_7 = var_7 * -1;

    var_9 = var_3 * var_6;
    var_10 = var_4 * var_8;
    var_11 = var_5 * var_7;
    var_12 = level._id_D127.origin;
    var_12 = var_12 + var_9;
    var_12 = var_12 + var_10;
    var_12 = var_12 + var_11;
    self vehicle_teleport(var_12, level._id_D127.angles);
    wait 0.05;
  } else
    thread _id_0BDC::_id_A373(self.script_noteworthy, 500);

  thread _id_2CB6();
  wait 1.0;
  self setneargoalnotifydist(5000);
  self waittill("near_goal");
  _id_0BDC::_id_19AB(550);
  _id_0BDC::_id_1986();
  _id_0BDC::_id_1990(1);
  _id_0BDC::_id_19AE("shoot_at_will");
  _id_0BDC::_id_19B3("patrol", "patrol_axis");
  _id_0BDC::_id_19B4("patrol");
}

_id_A1CD(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_1 = getclosestpointonnavmesh3d(var_1);
  _id_0BDC::_id_19AB(var_0);

  if(distancesquared(var_1, self.origin) > var_2 * var_2)
    _id_0BDC::_id_A1EC(var_1, 0, var_2);

  wait 0.2;
  _id_0BDC::_id_19B3("escape", undefined);
  _id_0BDC::_id_19AB(var_3);
  _id_0BDC::_id_1986();
  _id_0BDC::_id_19B3("patrol", var_4);
  _id_0BDC::_id_19B4("patrol");
  _id_0BDC::_id_1990(1);
  _id_0BDC::_id_19AE("shoot_at_will");
}

_id_9ABF(var_0, var_1, var_2, var_3) {
  level endon("stop_intro_speed_controller");
  var_4 = 7000;
  var_5 = 1500;

  if(isDefined(var_2))
    var_4 = var_2;

  if(isDefined(var_3))
    var_5 = var_3;

  var_6 = 510;
  var_7 = 250;
  var_8 = 750;
  var_9 = var_6;

  for(;;) {
    var_10 = level._id_D127.origin[0] - level._id_3662.origin[0];
    var_11 = var_0.origin[0] - level._id_3662.origin[0];
    var_12 = var_10 - var_11;

    if(var_12 > var_4 && var_9 != var_7)
      var_9 = var_7;
    else if(var_12 < var_5 && var_9 != var_8)
      var_9 = var_8;
    else if(var_12 < var_4 && var_12 > var_5 && var_9 != var_6)
      var_9 = var_6;

    var_0 _id_0BDC::_id_19AB(var_9);

    foreach(var_14 in var_1)
    var_14 _id_0BDC::_id_19AB(var_9);

    wait 0.2;
  }
}

_id_F031(var_0, var_1, var_2, var_3) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  self.team = "axis";
  _id_0BB6::_id_39E1();
  self._id_EEF9 = "cannon_missile_ca_hardpoint cannon_small_ca,1,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_r_ts_6,amb_turret_sml_r_ts_7,amb_turret_sml_l_ts_6,amb_turret_sml_l_ts_7 cannon_flak_ca,1,1 cannon_phalanx";
  _id_0BB6::_id_39E8();
  wait 0.1;
  self solid();
  self setCanDamage(1);
  _id_0BB6::_id_398A(1);

  if(scripts\engine\utility::is_true(var_0))
    thread _id_0BA9::_id_39C9();

  thread _id_FD45();
  self._id_B904 = "veh_mil_air_ca_destroyer";
  thread _id_0B53::_id_B909();
  _id_0BB8::_id_39CE("high");
  thread _id_0BB8::_id_39D0("idle");
  thread _id_0BB8::_id_39CD("idle");
  wait 2.2;
  thread _id_0BB6::_id_39EF();

  if(scripts\engine\utility::is_true(var_1)) {
    thread _id_0BB6::_id_39F0();
    thread _id_12A43();
  } else
    self._id_12FBA = 1;

  if(!isDefined(var_2)) {
    return;
  }
  while(level._id_A242 < var_2 && gettime() / 1000 - level._id_58A4 < var_3)
    wait 0.1;

  _id_0BB6::_id_398A(0);
  thread _id_728B(1, 1, 8);
  thread scripts\sp\utility::_id_10350("phspace_aic_enemyshipdown");
}

_id_5886() {
  _id_0BDC::_id_A1AB("enemy_lockon");
  _id_0BDC::_id_A321(0);
  level._id_26EB = spawnStruct();
  level._id_26EB._id_FE2D = [];
  level._id_26EB thread _id_B2E3("axis_arena_jackals", 1);
  thread _id_5887();

  foreach(var_1 in level._id_A259) {
    while(level._id_A242 < var_1[0] && gettime() / 1000 - level._id_58A4 < var_1[1])
      wait 0.05;

    level._id_B434 = var_1[2];
  }
}

_id_5887() {
  wait 4;

  foreach(var_1 in level._id_26EB._id_FE2D) {
    var_1 thread _id_A304();
    wait 0.5;
  }
}

_id_A304() {
  _id_0B76::_id_39C3(2, 1);
  _id_0BDC::_id_105D5();
}

_id_B2E3(var_0, var_1, var_2) {
  level._id_A12D = 0;
  var_3 = level._id_B434;
  var_4 = getEntArray(var_0, "targetname");
  var_4 = scripts\engine\utility::array_randomize(var_4);

  foreach(var_8, var_6 in var_4) {
    wait 0.05;

    if(level._id_A12D >= level._id_B434) {
      break;
    }

    var_6 scripts\sp\utility::_id_1747(_id_0BDC::_id_19AB, 250);
    var_6 scripts\sp\utility::_id_1747(::_id_ABEF, self);
    var_6 scripts\sp\utility::_id_1747(::_id_5880);
    var_7 = var_6 scripts\sp\utility::_id_10808();
    var_7 thread _id_A33D(var_6);
    level._id_A12D++;
    level._id_A1A3 = level._id_A1A3 + 1;

    if(var_8 == 3)
      scripts\engine\utility::flag_set("jackals_started_spawning");

    wait(randomfloatrange(0.2, 1.1));
  }

  while(self._id_FE2D.size > 0) {
    wait 0.1;
    self._id_FE2D = scripts\engine\utility::array_removeundefined(self._id_FE2D);
    var_9 = gettime() / 1000 - level._id_58A4 - level._id_A37C;

    if(level._id_A1A3 < level._id_B434 && level._id_B434 != 0 && level._id_A243 - level._id_A242 > 3 && var_9 > 5) {
      foreach(var_6 in var_4) {
        var_11 = vectordot(anglesToForward(level.player getplayerangles()), vectorNormalize(var_6.origin - _id_0BDC::_id_7BBA()));

        if(var_11 < 0.3) {
          var_7 = var_6 scripts\sp\utility::_id_10808();
          var_7 thread _id_A33D(var_6);
          level._id_A12D++;
          level._id_A1A3 = level._id_A1A3 + 1;
          wait 4;
          break;
        }

        wait 0.05;
      }

      continue;
    }

    if(level._id_A1A3 > level._id_B434) {
      if(level._id_A242 < level._id_A243) {
        var_13 = scripts\engine\utility::random(self._id_FE2D);

        if(isDefined(var_13._id_4090)) {
          continue;
        }
        level._id_A1A3 = level._id_A1A3 - 1;
        var_13._id_4090 = 1;
        var_13 thread scripts\sp\maps\phspace\phspace_mons::_id_50BF(randomfloatrange(0, 4.5));
        continue;
      }

      foreach(var_7 in self._id_FE2D) {
        if(!isDefined(var_7._id_4090)) {
          level._id_A1A3 = level._id_A1A3 - 1;
          var_7._id_4090 = 1;
          var_7 thread scripts\sp\maps\phspace\phspace_mons::_id_50BF(randomfloatrange(0, 4.5));
        }
      }
    }
  }
}

_id_A33D(var_0) {
  if(!isDefined(var_0.script_noteworthy)) {
    return;
  }
  wait 0.1;
  var_1 = level._id_3662;

  if(var_0.script_noteworthy == "axis_jackal_s2")
    var_1 = level._id_3663;
  else if(var_0.script_noteworthy == "axis_jackal_s3")
    var_1 = level._id_3664;
  else if(var_0.script_noteworthy == "axis_jackal_s4")
    var_1 = level._id_3665;

  if(!isDefined(var_1) && isDefined(level._id_3665))
    var_1 = level._id_3665;
  else if(!isDefined(var_1) && isDefined(level._id_3663))
    var_1 = level._id_3663;

  if(!isDefined(var_1) && isDefined(level._id_3664))
    var_1 = level._id_3664;

  var_2 = anglesToForward(var_1.angles);
  var_3 = anglestoup(var_1.angles);
  var_4 = anglestoright(var_1.angles);
  var_5 = var_1.origin + var_2 * -2368 + var_4 * -608 + var_3 * -200;
  var_6 = combineangles(var_1.angles, (0, 90, 0));

  if(scripts\engine\utility::cointoss()) {
    var_5 = var_1.origin + var_2 * -2368 + var_4 * 608 + var_3 * -200;
    var_6 = combineangles(var_1.angles, (0, -90, 0));
  }

  self vehicle_teleport(var_5, var_6);
}

_id_E099() {
  wait 2;
  _id_0BDC::_id_105D8();
}

_id_ABEF(var_0) {
  var_0._id_FE2D = scripts\engine\utility::array_add(var_0._id_FE2D, self);
  wait 0.1;

  if(isDefined(self._id_A420))
    var_0._id_FE2D = scripts\engine\utility::array_combine(var_0._id_FE2D, self._id_A420);
}

_id_5880() {
  var_0 = "patrol_axis";
  _id_0BDC::_id_1990(1);
  _id_0BDC::_id_19B3("patrol", var_0);
  _id_0BDC::_id_19B4("patrol");
  self waittill("death");

  if(!isDefined(self._id_4090)) {
    level._id_A242 = level._id_A242 + 1;
    level._id_A1A3 = level._id_A1A3 - 1;
    wait(randomfloatrange(0.4, 0.8));
    var_1 = ["phspace_eth_goodeffectont", "phspace_eth_goodkill", "phspace_eth_theyregone", "phspace_eth_targetdestroyed", "phspace_eth_kaboom", "phspace_eth_goodthundersir"];
    var_2 = _id_CB28("kill_comments", var_1);

    if(level._id_A243 - level._id_A242 == 3 && scripts\engine\utility::cointoss()) {
      var_2 = "phspace_slt_twomore";
      wait(randomfloatrange(0.5, 0.8));
    } else if(level._id_A243 - level._id_A242 == 2 && scripts\engine\utility::cointoss()) {
      var_2 = "phspace_slt_lastoneraider";
      wait(randomfloatrange(0.5, 0.8));
    } else if(level._id_A243 - level._id_A242 == 1 && scripts\engine\utility::cointoss())
      wait(randomfloatrange(0.5, 0.8));

    level._id_EA99 scripts\sp\utility::_id_10346(var_2);
  }

  level._id_A12D--;
}

_id_CB28(var_0, var_1) {
  if(!isDefined(level._id_134F6))
    level._id_134F6 = [];

  if(!isDefined(level._id_134F6[var_0])) {
    level._id_134F6[var_0] = [];

    foreach(var_4, var_3 in var_1)
    level._id_134F6[var_0][var_4] = [var_3, 0];
  }

  level._id_134F6[var_0] = scripts\engine\utility::array_randomize(level._id_134F6[var_0]);

  foreach(var_4, var_3 in level._id_134F6[var_0]) {
    if(var_3[1] == 0) {
      level._id_134F6[var_0][var_4][1] = level._id_134F6[var_0][var_4][1] + 1;
      return level._id_134F6[var_0][var_4][0];
    }
  }

  level._id_134F6[var_0][0][1] = level._id_134F6[var_0][0][1] + 1;
  return level._id_134F6[var_0][0][0];
}

_id_A0AA(var_0, var_1) {
  wait(var_0);
  _id_0BDC::_id_19B7();
  _id_0BDC::_id_1990(1);
  _id_0BDC::_id_19B3("patrol", var_1);
  _id_0BDC::_id_19B4("patrol");
}

_id_A0A4() {
  thread _id_A0A5();
}

_id_A0A5() {}

_id_FD19() {
  scripts\sp\maps\phspace\phspace::_id_107C0();
  scripts\sp\maps\phspace\phspace::_id_1062E();
  level._id_EA99 _id_0BDC::_id_6B4C("space", 0);
  level._id_1CB9 _id_0BDC::_id_6B4C("space", 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_F5A4();
  var_0 = scripts\sp\vehicle::_id_1080C("player_jackal");
  _id_0BDC::_id_10CD1(var_0);
  wait 0.05;
  var_1 = scripts\engine\utility::getStruct("ship_assault_start", "targetname");
  level._id_D127 vehicle_teleport(var_1.origin, var_1.angles);
  thread _id_D868();
  scripts\engine\utility::flag_wait("prespawn_done");
  thread scripts\sp\maps\phspace\phspace::_id_1062B();
  thread _id_1D76();
  thread _id_12B5F();
  thread _id_FE2F();
  thread _id_7318(1);
  thread _id_7317(1);
  thread _id_5878();
  thread _id_23A3();
}

_id_1D76() {
  wait 1.0;

  foreach(var_1 in level._id_1D0B) {
    var_1 vehicle_teleport(level._id_3664.origin, level._id_3664.angles);
    var_1 _meth_8455(level._id_3664.origin, 1, level._id_3664.angles);
  }
}

_id_FCFF() {
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\utility::_id_266A("ship_assault");
  level._id_A8B9 = level._id_3664;
  _id_0BDC::_id_A162();
  _id_0BDC::_id_A1A9(1);

  if(level._id_10CDA == "ship_assault")
    level._id_3664 scripts\engine\utility::delaythread(2, ::_id_F031, 1, 1);

  thread _id_FCF2(level._id_A8B9);
  thread _id_FD2B(level._id_A8B9);
  thread _id_FD27(level._id_A8B9);
  thread _id_6DC9();
  wait 3.0;
  level._id_3664 notify("reached_dynamic_path_end");
  thread _id_FD1C();

  if(getdvarint("e3", 0) == 1 || getdvarint("exec_review", 0) == 1)
    level._id_12FB6 = 0;

  while(isalive(level._id_A8B9))
    wait 0.1;

  level notify("stop_dogfight_bcs");
  scripts\sp\utility::_id_266A("jackal_assault_end");
  _id_DFC2();
  wait 1.8;
  thread _id_2397();
  wait 4.8;

  if(getdvarint("e3", 0) || getdvarint("exec_review", 0) || getdvarint("e3_ending", 0))
    _id_5F9D();

  scripts\engine\utility::flag_set("ship_assault_complete");
  scripts\engine\utility::exploder("returnret");
  thread _id_12B7B(1);
  thread _id_FCEC();
}

_id_2397() {
  level._id_1CB9 scripts\sp\utility::_id_10346("phspace_plt2_boombaby");
  level._id_EA99 scripts\sp\utility::_id_10346("phspace_plt1_hahadamn");
  scripts\sp\utility::_id_10350("phspace_aic_targetdownnice");
}

_id_DFC2() {
  foreach(var_1 in level._id_A056._id_1630) {
    if(isDefined(var_1) && var_1.script_team == "allies")
      var_1 _id_0BDC::_id_105DA();
  }
}

_id_5F9D() {
  setomnvar("ui_hide_hud", 1);
  scripts\sp\hud_util::_id_6AA3(0.3, "black");
  wait 0.3;
  thread scripts\sp\hud_util::_id_6A99(0.05);
  cinematicingame("IW_Title_Card_E3");
  wait 4.5;
  pausecinematicingame(1);
  level waittill("forever");
}

_id_FCF2(var_0) {
  scripts\sp\utility::_id_10350("phspace_eth_sironesetdefshi");
  var_0 _id_0BDC::_id_105DB("capitalship", "JACKAL_SDF_DESTROYER", "none", "enemy_capitalship", 0, 1, 1);
  var_0 _id_0BDC::_id_A36D();

  while(!var_0 _id_FD10() || level._id_D127 _id_0BDC::_id_8B87())
    wait 0.05;

  scripts\engine\utility::delaythread(0.2, scripts\sp\utility::_id_56BA, "hint_shoot_ships");
  var_0 scripts\engine\utility::delaythread(2.5, ::_id_FD05);
  scripts\sp\utility::_id_1034D("phspace_plr_allsatodirectfir");
  scripts\sp\utility::_id_10350("phspace_plt1_copyengaging");
  var_0._id_B83F = 4;
  var_0._id_A8EA = gettime();
  var_0 _id_0BB6::_id_39A3(1);
  scripts\sp\utility::_id_56BA("hint_switch_cannons");
  thread _id_53AA();
  thread _id_1136B();
  wait 0.5;
  var_0 thread _id_FD3C();
  wait 1.5;
  scripts\sp\utility::_id_1034D("phspace_plr_airdefenses");
  wait 0.1;
  level._id_EA99 scripts\sp\utility::_id_10346("phspace_slt_takeemout");
  scripts\sp\utility::_id_1034D("phspace_slt_rogerthat");
}

_id_FD10() {
  if(_id_0BDC::_id_9C1B(0.9) && _id_0BDC::_id_9C1A(25000))
    return 1;
  else
    return 0;
}

_id_53AA() {
  while(isDefined(level._id_A8B9) && isalive(level._id_A8B9)) {
    if(level._id_D127._id_4C15 == level._id_D127._id_13BF8) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("hint_did_cannons");
}

_id_1136B() {
  level endon("hint_did_cannons");
  level._id_EA99 scripts\sp\utility::_id_10346("phspace_slt_useyourcannons");
  wait 6.0;
  level._id_EA99 scripts\sp\utility::_id_10346("phspace_slt_switchtomaincannon");
}

_id_FD05() {
  _id_0BDC::_id_A36A();
  thread _id_0B76::_id_39C3(3);
  self._id_12A8B = 1;
  _id_0BB6::_id_39CA(0, undefined, "turret_ja");
  _id_0BDC::_id_A112("phspace_cmp_targetsudpated");

  foreach(var_1 in self._id_8B4F) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3))
        var_3 _id_0BDC::_id_105DB("turret_ja", var_3._id_11549, var_3._id_3AF3, "enemy_jackal");

      wait 0.05;
    }
  }
}

_id_FCFB(var_0, var_1) {
  self endon("death");
  thread _id_FCFA(var_0);
  var_0 waittill("death");
  thread _id_FCFA(var_0);
}

_id_FCFA(var_0) {
  level endon("ship_assault_complete");
  self endon("death");
  self notify("new_patrol");
  self endon("new_patrol");

  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }
  _id_0BDC::_id_19B7();
  _id_0BDC::_id_19AB(500);
  _id_0BDC::_id_1990(0);
  var_1 = var_0.origin;

  if(isDefined(var_0._id_24C4))
    var_1 = var_0 gettagorigin(scripts\engine\utility::random(var_0._id_24C4));

  thread _id_A1CD(500, var_1, 18000, 350, var_0._id_C9A2);
}

_id_FD2B(var_0) {
  var_0.team = "axis";
  var_0.script_team = "axis";
  level._id_1D0B = scripts\engine\utility::array_removeundefined(level._id_1D0B);

  foreach(var_2 in level._id_1D0B) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_2 thread _id_A1CD(400, var_0.origin, 15000, 200, var_0._id_C9A2);
      var_2 _id_0BDC::_id_19AE("shoot_at_will");
      var_2 thread _id_DCBC(var_0);
    }
  }

  level._id_EA99 thread _id_13D81(0, var_0);
  level._id_1CB9 thread _id_13D81(1, var_0);
}

_id_DCBC(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    wait(randomfloatrange(0, 12));

    if(randomint(100) > 75) {
      _id_0B76::_id_1992("tag_origin", var_0);
      wait 0.2;

      if(scripts\engine\utility::cointoss())
        _id_0B76::_id_1992("tag_origin", var_0);

      wait 0.2;

      if(scripts\engine\utility::cointoss())
        _id_0B76::_id_1992("tag_origin", var_0);

      wait 0.2;

      if(scripts\engine\utility::cointoss())
        _id_0B76::_id_1992("tag_origin", var_0);

      wait 0.2;

      if(scripts\engine\utility::cointoss())
        _id_0B76::_id_1992("tag_origin", var_0);
    }
  }
}

_id_FD3C() {
  self endon("death");
  var_0 = "phspace_slt_airdefensesare";
  var_1 = "phspace_plr_stayonit1";
  level._id_FD4A = 80000;
  thread _id_FD3D();
  var_2 = 1;
  self._id_4D1C = level._id_FD4A;
  thread _id_FCD5();

  while(self._id_4D1C > 0) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(var_4 != level._id_D127)
      var_3 = var_3 / 20;
    else if(var_4 == level._id_D127)
      var_3 = var_3 * var_2;

    self._id_4D1C = self._id_4D1C - var_3;

    if(self._id_4D1C < level._id_FD4A / 3 * 2 && isDefined(var_0)) {
      level._id_EA99 thread scripts\sp\utility::_id_10346(var_0);
      var_0 = undefined;
      continue;
    }

    if(self._id_4D1C < level._id_FD4A / 3 && isDefined(var_1)) {
      thread scripts\sp\utility::_id_1034D(var_1);
      var_1 = undefined;
    }
  }

  self notify("stop_healthwatcher");
  level._id_EA99 thread scripts\sp\utility::_id_10346("phspace_slt_shesgonnablow");
  _id_728B(0, undefined, undefined, 1);
}

_id_FCD5() {
  level.player endon("death");
  self endon("death");
  self endon("stop_healthwatcher");
  var_0 = _id_52FA();
  var_1 = _id_52F9();
  var_2 = var_0;
  var_3 = var_1;
  var_4 = 3000;
  var_5 = 1300;

  for(;;) {
    var_6 = 0;
    var_0 = _id_52FA();
    var_1 = _id_52F9();
    var_7 = var_2 - var_0;
    var_8 = var_3 - var_1;
    var_9 = var_7 * var_4;
    var_10 = var_8 * var_5;
    var_6 = var_9 + var_10;

    if(var_6 > 0) {
      self._id_4D1C = self._id_4D1C - var_6;
      wait 0.1;
      self dodamage(1, self.origin, level._id_D127);
    }

    var_2 = var_0;
    var_3 = var_1;
    wait 0.1;
  }

  self _meth_81D0();
}

_id_52FA() {
  var_0 = 0;

  if(isDefined(self.turrets) && isDefined(self.turrets["cap_turret_med_flak"]))
    var_0 = scripts\engine\utility::array_removeundefined(self.turrets["cap_turret_med_flak"]).size;

  if(isDefined(self.turrets) && isDefined(self.turrets["cap_turret_phalanx"]))
    var_0 = var_0 + scripts\engine\utility::array_removeundefined(self.turrets["cap_turret_phalanx"]).size;

  if(isDefined(self.turrets) && isDefined(self.turrets["cap_turret_small_constant"]))
    var_0 = var_0 + scripts\engine\utility::array_removeundefined(self.turrets["cap_turret_small_constant"]).size;

  return var_0;
}

_id_52F9() {
  var_0 = 0;

  if(isDefined(self._id_8B4F) && isDefined(self._id_8B4F["cap_hardpoint_missile_barrage"]))
    var_0 = scripts\engine\utility::array_removeundefined(self._id_8B4F["cap_hardpoint_missile_barrage"]).size;

  return var_0;
}

_id_FD27(var_0) {
  level._id_12B67 thread _id_12B7A(var_0);
  level._id_12B7D thread _id_12B7A(var_0);
  level._id_12B67 thread _id_0BB6::_id_3983(var_0);
  wait 2.5;
  level._id_12B7D thread _id_0BB6::_id_3983(var_0);
  wait 2.0;
  level._id_12B51 thread _id_0BB6::_id_3983(var_0);
}

_id_FCF8() {
  level._id_39DD["cannon_flak_ca"]._id_10241._id_6D20 = 0.5;
  level._id_39DD["cannon_flak_ca"]._id_10241._id_13536 = [3, 6];
  level._id_39DD["cannon_flak_ca"]._id_10241._id_13535 = [0.2, 0.6];
}

_id_12B7A(var_0) {
  if(!isDefined(self)) {
    return;
  }
  thread _id_0BB6::_id_3966(1, 0, var_0);
  var_0 waittill("death");
  self endon("end_capitalship_ambient_targets");
  self endon("end_capitalship_attacking");
}

_id_FD1C() {
  foreach(var_1 in level._id_52D1)
  var_1 _id_0BA9::_id_3978();
}

_id_13D81(var_0, var_1) {
  self notify("new_wingman_attack_logic");
  self endon("new_wingman_attack_logic");
  self endon("death");

  if(!isDefined(var_1._id_13D86) || !isDefined(var_1._id_13D86[var_0])) {}

  var_2 = scripts\engine\utility::getStructArray(var_1._id_13D86[var_0], "script_noteworthy");

  if(!isDefined(var_2) || var_2.size == 0) {}

  _id_0BDC::_id_19AB(400);

  while(isDefined(var_1) && isalive(var_1)) {
    var_3 = scripts\engine\utility::random(var_2);
    _id_0BDC::_id_19B7();
    _id_0BDC::_id_19A2();
    _id_0BDC::_id_A1EC(var_3.origin, 1, 512, var_3.angles);
    var_4 = var_1;

    if(randomint(4) != 0)
      var_4 = var_1 _id_78CB(self);

    if(isDefined(var_4))
      _id_0BDC::_id_19B5(var_4);

    _id_0BDC::_id_19B2("face enemy");
    _id_0BDC::_id_19AE("shoot_at_will");
    wait(randomfloatrange(1, 4));
    _id_0BDC::_id_19AB(150);
  }
}

_id_78CB(var_0) {
  if(!isDefined(self)) {
    return;
  }
  var_1 = -1;
  var_2 = undefined;

  foreach(var_4 in self.turrets) {
    foreach(var_6 in var_4) {
      if(!isDefined(var_6)) {
        continue;
      }
      var_7 = distancesquared(var_0.origin, var_6.origin);

      if(var_7 < var_1 || var_1 == -1) {
        var_1 = var_7;
        var_2 = var_6;
      }
    }
  }

  return var_2;
}

_id_6DC9() {
  level endon("mons_intro_setup_complete");

  for(;;) {
    if(_id_0B76::_id_7A60(level._id_12B67.origin) < 0.5) {
      scripts\sp\maps\phspace\phspace_mons::_id_1F90();
      return;
    }

    wait 0.1;
  }
}

_id_FD18() {
  level._id_39DD["cannon_missile_ca"]._id_10241._id_6D39 = 0.35;
  level._id_39DD["cannon_missile_ca"]._id_10241._id_6D20 = 1;
  level._id_39DD["cannon_missile_ca"]._id_10241._id_13536 = [0.9, 1];
  level._id_39DD["cannon_missile_ca"]._id_10241._id_13535 = [8, 10];
  level._id_39DD["cannon_missile_ca"]._id_10241._id_10943 = ::_id_530A;
}

_id_530A(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = ["amb_missile_l_1", "amb_missile_r_1", "amb_missile_l_3", "amb_missile_r_3", "amb_missile_l_5", "amb_missile_r_5", "amb_missile_l_7", "amb_missile_r_7", "amb_missile_l_9", "amb_missile_r_9", "amb_missile_l_11", "amb_missile_r_11"];
  var_5 = [3, 7, 11, 15, 19, 23];
  var_6 = 10;

  foreach(var_16, var_8 in var_4) {
    var_9 = _id_7D23(var_8, var_0);

    if(isDefined(var_9)) {
      foreach(var_11 in var_2) {
        var_12 = var_9 _id_0BB6::_id_12A36(var_11);
        var_13 = var_9 _id_0BB6::_id_12A37(var_11, var_12);

        if(self._id_114FB != self)
          var_9._id_114FB = self._id_114FB;

        var_14 = [];
        var_14[0] = var_11;
        var_9 _id_0B76::_id_1945(var_9._id_114FB, var_14, 1);
      }
    }

    if(isDefined(var_1))
      wait(var_1._id_6D39);
    else
      wait 0.3;

    if(scripts\engine\utility::array_contains(var_5, var_16))
      wait(var_6);

    if(_id_0BB6::_id_12A3B(var_3, self._id_114FB) || scripts\engine\utility::is_true(self._id_1D62))
      _id_0BB6::_id_B2CA(var_3);
  }
}

_id_7D23(var_0, var_1) {
  foreach(var_3 in self.turrets[var_1]) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3._id_AD42 == var_0)
      return var_3;
  }

  return undefined;
}

_id_12A43() {
  self endon("death");
  self endon("turret_threat_handler_stop");

  for(;;) {
    var_0 = 0;
    var_1 = distance(level._id_D127.origin, self.origin);

    if(var_1 < 18000 && randomint(100) < 90)
      var_0 = 1;

    if(var_1 <= 8000)
      var_0 = 1;

    if(scripts\sp\utility::_id_7B9D() <= 0.1)
      var_0 = 0;
    else if(scripts\sp\utility::_id_7B9D() >= 0.6)
      var_0 = 1;

    self._id_1D62 = var_0;
    self._id_11578 = var_0;
    wait 3;
  }
}

_id_720F(var_0, var_1) {
  level._id_12B67._id_B824 = 400;
  level._id_12B67._id_B825 = 700;
  level._id_12B67._id_B823 = 700;
  level._id_12B7D._id_B824 = 400;
  level._id_12B7D._id_B825 = 700;
  level._id_12B7D._id_B823 = 700;
  level._id_12B51._id_B824 = 400;
  level._id_12B51._id_B825 = 700;
  level._id_12B51._id_B823 = 700;
  level._id_12B67 thread _id_0BB6::_id_3983(self);
  level._id_12B7D thread _id_0BB6::_id_3983(self);
  level._id_12B51 thread _id_0BB6::_id_3983(self);

  if(!isDefined(var_0) || !var_0) {
    if(scripts\engine\utility::cointoss()) {
      scripts\sp\utility::_id_10350("phspace_plr_phalanxisdown");
      scripts\sp\utility::_id_10350("phspace_plr_allshipsopenfire");
    } else
      scripts\sp\utility::_id_10350("phspace_vcp_vanguardengagin");
  }

  var_2 = 0;

  while(var_2 < 2) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(var_7 == "MOD_EXPLOSIVE" && !isDefined(var_12))
      var_2 = var_2 + 1;

    wait 0.05;
  }

  thread _id_728B();
}

_id_728B(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = 0;
  var_5 = 0.5;

  if(scripts\engine\utility::is_true(var_1)) {
    var_6 = -1;
    var_7 = gettime();

    while(var_6 < 0.8) {
      wait 0.1;
      var_6 = _id_0B76::_id_7A60(self.origin);

      if(var_6 < var_5 && !var_4) {
        _id_A9D2();
        var_4 = 1;
      }

      if(isDefined(var_2) && gettime() - var_7 > var_2 * 1000) {
        break;
      }
    }
  } else {
    var_7 = gettime();

    while(!var_4) {
      wait 0.1;
      var_6 = _id_0B76::_id_7A60(self.origin);

      if(var_6 <= var_5) {
        _id_A9D2();
        var_4 = 1;
        wait 0.1;
        break;
      }

      if(gettime() - var_7 > 4000) {
        break;
      }
    }
  }

  self._id_BFE3 = 1;
  var_8 = _id_0BA9::_id_39AA(undefined, var_0, var_3);
  level._id_52D1 = scripts\engine\utility::array_add(level._id_52D1, var_8);
}

_id_A9D2() {
  var_0 = self._id_4BF7;

  if(isDefined(self._id_4BF7.target))
    var_0 = getvehiclenode(self._id_4BF7.target, "targetname");

  while(isDefined(var_0.target))
    var_0 = getvehiclenode(var_0.target, "targetname");

  var_1 = var_0;
  self vehicle_teleport(var_1.origin, var_1.angles);
  self vehicle_setspeedimmediate(0, 5, 500);
}

_id_FD3D() {
  self waittill("death");
  level.player playSound("scn_last_capital_ship_explo_lr");
  wait 2.2;
  setmusicstate("");
  wait 2.5;

  if(getdvarint("e3", 0))
    level.player _meth_82C0("phspace_e3_fade", 4);
}

_id_FD45() {
  self endon("death");
  self endon("stop_idle_listing_motion");
  var_0 = 15;
  var_1 = var_0 / 2;
  var_2 = var_0 / 2;
  self waittill("reached_dynamic_path_end");
  wait 0.2;
  var_3 = spawn("script_origin", self.origin);
  var_3.angles = self.angles;
  self linkTo(var_3);

  for(;;) {
    var_4 = randomfloatrange(200, 600);
    var_5 = randomfloatrange(200, 600);
    var_6 = randomfloatrange(100, 400);

    if(scripts\engine\utility::cointoss())
      var_4 = var_4 * -1;

    if(scripts\engine\utility::cointoss())
      var_5 = var_5 * -1;

    if(scripts\engine\utility::cointoss())
      var_6 = var_6 * -1;

    var_7 = randomfloatrange(2, 6);
    var_8 = randomfloatrange(4, 10);
    var_9 = randomfloatrange(3, 8);

    if(scripts\engine\utility::cointoss())
      var_7 = var_7 * -1;

    if(scripts\engine\utility::cointoss())
      var_8 = var_8 * -1;

    if(scripts\engine\utility::cointoss())
      var_9 = var_9 * -1;

    var_3 moveTo(var_3.origin + (var_4, var_5, var_6), var_0, var_1, var_2);
    var_3 rotateTo(var_3.angles + (var_7, var_8, var_9), var_0, var_1, var_2);
    var_3 waittill("movedone");
    var_3 waittill("rotatedone");
    wait(randomfloatrange(0, 2));
    var_3 moveTo(var_3.origin - (var_4, var_5, var_6), var_0, var_1, var_2);
    var_3 rotateTo(var_3.angles - (var_7, var_8, var_9), var_0, var_1, var_2);
    var_3 waittill("movedone");
    var_3 waittill("rotatedone");
    wait(randomfloatrange(0, 2));
  }
}

_id_FCEB() {
  thread _id_FCEC();
  scripts\engine\utility::flag_set("hint_did_updown");
  scripts\engine\utility::flag_set("ship_assault_complete");
}

_id_FCEC() {}

_id_CF9B() {}

_id_104B9() {}

_id_5878() {
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
}

_id_A24C(var_0) {
  level._id_EA99 _id_0BDC::_id_19A2();
  level._id_1CB9 _id_0BDC::_id_19A2();
  level._id_EA99 animScripted("space_launch_done", var_0.origin, var_0.angles, level._id_EC85["salter_jackal"]["space_launch"]);
  level._id_1CB9 animScripted("space_launch_done", var_0.origin, var_0.angles, level._id_EC85["jackal_ally1"]["space_launch"]);
  wait 0.05;
  level._id_EA99 _meth_82B0(level._id_EC85["salter_jackal"]["space_launch"], 0.803228);
  level._id_1CB9 _meth_82B0(level._id_EC85["jackal_ally1"]["space_launch"], 0.803228);
  level._id_EA99 waittill("space_launch_done");
  wait 0.05;
  level._id_EA99 _meth_83A1();
  level._id_1CB9 _meth_83A1();
  level._id_EA99 _id_0BDC::_id_A1EC(level._id_EA99.origin, 1, 384, level._id_EA99.angles);
  level._id_1CB9 _id_0BDC::_id_A1EC(level._id_1CB9.origin, 1, 384, level._id_1CB9.angles);
  level.player _meth_8463("moveto");
  level.player _meth_8463("lookat");
}

#using_animtree("jackal");

_id_2CB6() {
  self _meth_82A2(%jackal_vehicle_fly_motion, 1, 0, 1.5);
  self _meth_82B0(%jackal_vehicle_fly_motion, randomfloatrange(0, 1));
  self _meth_82A2(%jackal_extra_fly_motion_overlay, 0.0, 0);
  self _meth_82A2(%jackal_extra_fly_motion_overlay, 0.5, 2);
  wait 3;
  self _meth_82A2(%jackal_extra_fly_motion_overlay, 0, 12);
}

_id_FA45() {
  var_0 = getEntArray("skyspray_org", "targetname");
  self._id_102A9 = var_0;
}

_id_12B7B(var_0) {
  wait 1.0;
  var_1 = [level._id_12B50, level._id_12B54, level._id_12B55, level._id_12B56, level._id_12B53, level._id_12B7D, level._id_12B51];

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = randomintrange(2, 4);

    while(var_4 > 0) {
      var_5 = scripts\engine\utility::random(var_3.turrets["cap_turret_cannon_large_un"]);

      if(!isDefined(var_5)) {
        continue;
      }
      playFXOnTag(level._effect["capital_turret_smolder_lg"], var_3, var_5._id_AD42);
      var_5 thread _id_0BA9::_id_12A4F(0.1);
      var_4 = var_4 - 1;

      if(!scripts\engine\utility::is_true(var_0)) {
        wait(randomfloatrange(0.1, 2));
        continue;
      }

      wait 0.1;
    }
  }
}

_id_23A3() {
  var_0 = scripts\engine\utility::getStructArray("debris_cloud_struct_assault", "script_noteworthy");
  var_1 = undefined;
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    var_2[var_5] = spawnfx(scripts\engine\utility::getfx("vfx_sc_space_debris_field_01"), var_4.origin, anglesToForward(var_4.angles), anglestoup(var_4.angles));
    wait 0.05;
    triggerfx(var_2[var_5]);
  }

  scripts\engine\utility::flag_wait("ship_assault_complete");

  foreach(var_7 in var_2)
  var_7 delete();
}

spawn_ret_door_hack() {
  while(!isDefined(level._id_12B67))
    wait 0.05;

  if(isDefined(level._id_E311)) {
    return;
  }
  level._id_E311 = spawn("script_model", level._id_12B67.origin);
  level._id_E311 setModel("veh_mil_air_un_retribution_details_door");
  level._id_E311 linkTo(level._id_12B67, "tag_origin", (0, 0, 0), (0, 0, 0));
}

delete_ret_door_hack() {
  if(!isDefined(level._id_E311)) {
    return;
  }
  level._id_E311 delete();
}