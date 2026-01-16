/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phspace\phspace_battle.gsc
******************************************************/

func_CADB() {
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

func_104B7(var_0) {
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_F5A4();

  if(!isDefined(var_0)) {
    var_0 = "player_jackal";
  }

  var_1 = ["salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_48BF(var_1);
  scripts\sp\maps\phspace\phspace::func_107C0();
  scripts\sp\maps\phspace\phspace::func_1062E();
  level.var_EA99 func_0BDC::func_6B4C("space");
  level.var_1CB9 func_0BDC::func_6B4C("space");
  level.var_D299 = scripts\sp\maps\phspace\phspace_launch::func_D2A6("player_sled", 1);
  level.var_D299.var_1FBB = "sled_jackal";
  var_2 = scripts\engine\utility::getstruct("jackal_launch_animnode_clone", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  wait 0.1;
  thread func_A24C(var_2);
  var_3 = scripts\sp\vehicle::func_1080C(var_0);
  func_0BDC::func_10CD1(var_3);
  level.var_D299 glinton(#animtree);
  level.var_D299 animscripted("", var_2.origin, var_2.angles, level.var_EC85["sled_jackal"]["space_launch_boost"]);
  wait 0.05;
  level.var_D299 func_82B0(level.var_EC85["sled_jackal"]["space_launch_boost"], 0.654132);
  wait 0.05;
  level.var_D127 vehicle_teleport(level.var_D299.origin, level.var_D299.angles);
  func_0BDC::func_D164(level.var_D299.var_BD0D, 0);
  level.var_EA99 hidepart("j_panel_hide");
  level.var_1CB9 hidepart("j_panel_hide");
  scripts\engine\utility::flag_set("begin_space_battle");
}

func_104B6() {
  wait 0.1;
  scripts\engine\utility::flag_wait("begin_space_battle");
  thread func_4092();
  _setsaveddvar("r_umbraShadowCasters", 0);

  if(getdvarint("e3", 1)) {
    scripts\sp\utility::func_F305();

    if(scripts\sp\utility::func_9BEE()) {
      if(level.var_DADC) {
        _setsaveddvar("r_postaa", 1);
      }
    }
  }

  func_0BDC::func_A162();
  func_0BDC::func_A153(1);
  func_0BDC::func_A0BE(0);
  func_0BDC::func_A301(0, 0.1, "pearl");
  func_0BDC::func_A302(0, 0.1, "pearl");
  level.var_D127 func_8491("hover");
  level.var_D127 func_0BDC::func_A14A(1);
  level.var_D127 func_0BDC::func_A156(1);

  if(getdvarint("e3", 0) || getdvarint("exec_review", 0)) {
    func_0BDC::func_A19D(1);
  }

  thread func_D868(1);
  thread spawn_ret_door_hack();
  wait 4.8;
  level.var_118DC = gettime() / 1000;
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_10D14();
  thread func_CADA();
  thread func_20E9();
  thread func_23A3();
  wait 0.1;
  thread func_12B5F(5);
  level.var_12B67 thread func_12B68();
  level.var_12B7D thread func_12B7E();
  level.var_12B51 thread func_12B52();
  thread func_2731();
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(3.8);
  level.var_12B4A thread func_12B4D();
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(5.0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(5.2);
  thread scripts\sp\maps\phspace\phspace::func_1062B();

  foreach(var_1 in level.var_1D0B) {
    var_1 func_0BDC::func_19A9();
  }

  level.var_EA99 func_0BDC::func_6B4C("fly", 1);
  wait 0.1;
  level.var_1CB9 func_0BDC::func_6B4C("fly", 1);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(8.0);
  level.var_EA99 thread func_10ACD("intro_spline_salter");
  level.var_EA99 playSound("phspace_reveal_jackal_npc_boost");
  level.var_1CB9 thread func_10ACD("intro_spline_ally1", 0.2);
  level.var_1CB9 playSound("phspace_reveal_jackal_npc_boost");

  foreach(var_1 in level.var_1D0B) {
    var_1 func_0BDC::func_1988();
    var_1 scripts\engine\utility::delaycall(randomfloatrange(0, 0.4), ::playsound, "phspace_reveal_jackal_npc_boost");
    var_1 thread func_1D75(0, 1);
  }

  thread func_9ABF(level.var_EA99, [level.var_1CB9], 10000, 3000);
  thread func_9ABF(level.var_1D0B[1], [level.var_1D0B[0], level.var_1D0B[2]], 9000, 2500);
  thread func_9ABF(level.var_1D0B[4], [level.var_1D0B[3], level.var_1D0B[5]], 9000, 2500);
  level.var_D127 notify("launch_complete");
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(9.1);
  scripts\sp\utility::func_2669("space_approach");
  func_0BDC::func_A301(1.0, 1.0, "pearl");
  func_0BDC::func_A302(1.0, 3.0, "pearl");
  func_0BDC::func_D190();
  func_0BDC::func_A156(0);
  func_0BDC::func_A1DD(undefined);
  func_0BDC::func_A15C(0);
  level.player func_8463("moveto");
  level.player func_8463("orient");
  level.player func_8463("lookat");
  var_5 = level.var_111D0.var_1022B;
  var_6 = level.var_111D0.var_6C28;
  var_7 = level.var_111D0.var_6C27;
  var_8 = level.var_111D0.var_6C23;
  var_9 = 12;
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C46(var_6, var_7, var_9);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(var_5, var_9);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C47(var_8, var_9);
  thread func_28B8();
}

func_4092() {
  level waittill("launch_hud_off");
  wait 5;
  level.var_D299 delete();

  if(isDefined(level.var_D2A1)) {
    level.var_D2A1 delete();
  }
}

func_10C76() {
  level.var_3662 func_0BB6::func_39A3(1);
  level.var_3663 func_0BB6::func_39A3(1);
  level.var_3664 func_0BB6::func_39A3(1);
  level.var_3665 func_0BB6::func_39A3(1);
}

func_1120E() {}

func_28B8() {
  if(level.console || level.player global_fx()) {
    scripts\sp\utility::func_56BA("basic_controls");
  } else {
    scripts\sp\utility::func_56BA("basic_controls_pc");
  }

  func_8FF1();
  wait 0.5;

  if(level.console || level.player global_fx()) {
    scripts\sp\utility::func_56BA("basic_boosters");
  } else {
    scripts\sp\utility::func_56BA("basic_boosters_pc");
  }

  func_8FF2();
}

func_8FF1() {
  var_0 = 1;
  var_1 = -1;

  for(;;) {
    var_2 = level.player getnormalizedmovement();
    var_3 = level.player getsplashtablename();

    if(abs(var_2[0]) > 0.3 || abs(var_2[1]) > 0.3 || abs(var_3[0]) > 0.3 || abs(var_3[1]) > 0.3) {
      if(var_1 == -1) {
        var_1 = gettime() / 1000;
      } else if(gettime() / 1000 - var_1 > var_0) {
        break;
      }
    } else {
      var_1 = -1;
    }

    wait 0.05;
  }

  scripts\engine\utility::flag_set("hint_did_basics");
}

func_8FF2() {
  var_0 = 1;
  var_1 = -1;

  for(;;) {
    if(level.player issprinting()) {
      if(var_1 == -1) {
        var_1 = gettime() / 1000;
      } else if(gettime() / 1000 - var_1 > var_0) {
        break;
      }
    } else {
      var_1 = -1;
    }

    wait 0.05;
  }

  scripts\engine\utility::flag_set("hint_did_boosters");
}

func_8FF3() {
  var_0 = 0.2;
  var_1 = -1;

  for(;;) {
    if(level.player buttonpressed("BUTTON_A") || level.player buttonpressed("BUTTON_B")) {
      if(var_1 == -1) {
        var_1 = gettime() / 1000;
      } else if(gettime() / 1000 - var_1 > var_0) {
        break;
      }
    } else {
      var_1 = -1;
    }

    wait 0.05;
  }

  scripts\engine\utility::flag_set("hint_did_updown");
}

func_D868(var_0) {
  level.var_12B51 = func_FD5A("un_convoy_ship01", "una1", 1, 1, 1, 1, 0, "cannon_large_un missile_tube_un");
  level.var_12B51.var_E7D0 = 0;
  level.var_12B51.var_12FBA = 1;
  thread scripts\sp\maps\phspace\phspace::func_107F6();

  if(scripts\engine\utility::is_true(var_0)) {
    wait 4.8;
  }

  thread scripts\sp\maps\phspace\phspace::func_107B6();
  level.var_3662 = func_FD5A("sdf_background_ship01", "ca1", 0, 0, 0, 0);
  level.var_3663 = func_FD5A("sdf_background_ship02", "ca2", 0, 0, 0, 0);
  level.var_3664 = func_FD5A("sdf_background_ship03", "ca3", 0, 0, 0, 0);
  level.var_3665 = func_FD5A("sdf_background_ship04", "ca4", 0, 0, 0, 0);
  wait 0.05;
  thread func_F903();
  var_1 = 200;
  var_2 = 15000;
  var_3 = 0.4;
  var_4 = 0.75;
  var_5 = 13000;
  var_6 = 3000;
  var_7 = 1000;
  level.var_3662 func_0BDC::func_A16E(var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
  level.var_3663 func_0BDC::func_A16E(var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
  level.var_3664 func_0BDC::func_A16E(var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
  level.var_3665 func_0BDC::func_A16E(var_1, var_2, var_3, var_4, var_5, var_6, var_7, 0);
  level.var_12B7D solid();
  level.var_12B67 solid();
  level.var_12B7D func_0BB8::func_39CD("heavy");
  level.var_12B7D func_0BB8::func_39D0("idle");
  level.var_12B7D func_0BB8::func_39CE("high");
  level.var_12B67 func_0BB8::func_39CD("heavy");
  level.var_12B67 func_0BB8::func_39D0("idle");
  level.var_12B67 func_0BB8::func_39CE("high");
  level.var_12B51 func_0BB8::func_39CE("low");
  level.var_3662 func_0BB8::func_39CE("low");
  level.var_3663 func_0BB8::func_39CE("high");
  level.var_3664 func_0BB8::func_39CE("high");
  level.var_3665 func_0BB8::func_39CE("low");
  level.var_3662.var_129D9 = 0;
  level.var_3663.var_129D9 = 1;
  level.var_3664.var_129D9 = 1;
  level.var_3665.var_129D9 = 0;
  level.var_3662.var_C9A2 = "patrol_s1";
  level.var_3663.var_C9A2 = "patrol_s2";
  level.var_3664.var_C9A2 = "patrol_s3";
  level.var_3665.var_C9A2 = "patrol_s4";
  level.var_3662.var_13D86 = ["ship_assault1_port_positions", "ship_assault1_starboard_positions"];
  level.var_3663.var_13D86 = ["ship_assault2_port_positions", "ship_assault2_starboard_positions"];
  level.var_3664.var_13D86 = ["ship_assault3_port_positions", "ship_assault3_starboard_positions"];
  level.var_3665.var_13D86 = ["ship_assault4_port_positions", "ship_assault4_starboard_positions"];
  level.var_3662 thread func_FA45();
  level.var_3663 thread func_FA45();
  level.var_3664 thread func_FA45();
  level.var_3665 thread func_FA45();

  if(level.var_10CDA == "hvt_handoff" || level.var_10CDA == "jackals" || level.var_10CDA == "jackals_reveal" || level.var_10CDA == "space_approach" || level.var_10CDA == "test_lighttweaks_enabled") {
    level.var_12B4A = func_FD5A("un_background_ship02", "unb2", 1, 1, 1, 1);
    level.var_12B4C = func_FD5A("un_background_ship03", "unb3", 1, 1, 1, 1);
    wait 0.05;
    level.var_12B60 = func_FD5A("un_midground_ship01", "unm1", 0, 0, 0, 0);
    level.var_12B61 = func_FD5A("un_midground_ship02", "unm2", 0, 0, 0, 0);
    level.var_12B60.var_4E09 = "vfx_destroyer_death_cheap";
    level.var_12B61.var_4E09 = "vfx_destroyer_death_cheap";
    wait 0.05;
    level.var_12B4A func_0BB8::func_39CE("off");
    level.var_12B4C func_0BB8::func_39CE("off");
  }

  if(level.var_10CDA == "trench_run" || level.var_10CDA == "ram") {
    var_8 = getent("ca_olympus", "targetname");
    var_8.var_EEF9 = "none";
    level.var_3670 = scripts\sp\vehicle::func_1080C("ca_olympus");
    level.var_3670 func_0BB8::func_39CD("off");
    level.var_3670 func_0BB8::func_39D0("off");
    level.var_3670 func_0BB8::func_39CE("off");
    level.var_3670 thread scripts\sp\maps\phspace\phspace_mons::func_F051();
    scripts\engine\utility::flag_set("olympus_arrived");
  }

  wait 0.05;
  scripts\engine\utility::flag_set("prespawn_done");
}

func_F903() {}

func_FE2F() {
  switch (level.var_10CDA) {
    case "space_approach":
      break;
    case "jackal_assault":
      var_0 = getvehiclenode("sdf_background_ship01_approach_pos", "targetname");
      var_1 = getvehiclenode("sdf_background_ship02_approach_pos", "targetname");
      var_2 = getvehiclenode("sdf_background_ship03_approach_pos", "targetname");
      var_3 = getvehiclenode("sdf_background_ship04_approach_pos", "targetname");
      level.var_3662 vehicle_teleport(var_0.origin, var_0.angles);
      level.var_3663 vehicle_teleport(var_1.origin, var_1.angles);
      level.var_3664 vehicle_teleport(var_2.origin, var_2.angles);
      level.var_3665 vehicle_teleport(var_3.origin, var_3.angles);
      var_4 = getvehiclenode("retribution_last_pos", "targetname");
      level.var_12B67 vehicle_teleport(var_4.origin, var_4.angles);
      var_4 = getvehiclenode("un_tigris_last_pos", "targetname");
      level.var_12B7D vehicle_teleport(var_4.origin, var_4.angles);
      var_4 = getvehiclenode("un_convoy_ship01_last_pos", "targetname");
      level.var_12B51 vehicle_teleport(var_4.origin, var_4.angles);
      break;
    case "ship_assault":
      func_FE30(0, 1, 1, 0, 1);
      break;
    case "mons_intro":
      func_FE30(0, 1, 1, 1, 1);
      break;
    case "trench_run":
      func_FE30(1, 1, 1, 1, 1);
      break;
    case "ram":
      func_FE30(1, 1, 1, 1, 1);
      break;
    case "landing":
      var_4 = getvehiclenode("retribution_last_pos", "targetname");
      level.var_12B67 vehicle_teleport(var_4.origin, var_4.angles);
      break;
    default:
      break;
  }
}

func_FE30(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getvehiclenode("sdf_background_ship01_last_pos", "targetname");
  var_6 = getvehiclenode("sdf_background_ship02_last_pos", "targetname");
  var_7 = getvehiclenode("sdf_background_ship03_last_pos", "targetname");
  var_8 = getvehiclenode("sdf_background_ship04_last_pos", "targetname");
  level.var_3662 vehicle_teleport(var_5.origin, var_5.angles);
  level.var_3663 vehicle_teleport(var_6.origin, var_6.angles);
  level.var_3664 vehicle_teleport(var_7.origin, var_7.angles);
  level.var_3665 vehicle_teleport(var_8.origin, var_8.angles);
  var_9 = getvehiclenode("retribution_last_pos", "targetname");
  level.var_12B67 vehicle_teleport(var_9.origin, var_9.angles);
  var_9 = getvehiclenode("un_tigris_last_pos", "targetname");
  level.var_12B7D vehicle_teleport(var_9.origin, var_9.angles);
  var_9 = getvehiclenode("un_convoy_ship01_last_pos", "targetname");
  level.var_12B51 vehicle_teleport(var_9.origin, var_9.angles);
  wait 0.1;

  if(scripts\engine\utility::is_true(var_1)) {
    level.var_52D1 = scripts\engine\utility::array_add(level.var_52D1, level.var_3662 func_0BA9::func_39AC());
  }

  if(scripts\engine\utility::is_true(var_2)) {
    level.var_52D1 = scripts\engine\utility::array_add(level.var_52D1, level.var_3663 func_0BA9::func_39AC());
  }

  if(scripts\engine\utility::is_true(var_3)) {
    level.var_52D1 = scripts\engine\utility::array_add(level.var_52D1, level.var_3664 func_0BA9::func_39AC());
  }

  if(scripts\engine\utility::is_true(var_4)) {
    level.var_52D1 = scripts\engine\utility::array_add(level.var_52D1, level.var_3665 func_0BA9::func_39AC());
  }
}

func_12B5F(var_0) {
  if(isDefined(var_0)) {
    wait(var_0);
  }

  level.var_12B50 = func_FD5A("un_convoy_ship00", "un0", 0, 0, 0, 0, 1, "cannon_large_un missile_tube_un");
  level.var_12B54 = func_FD5A("un_convoy_ship03", "un3", 0, 0, 0, 0, 1, "cannon_large_un missile_tube_un");
  level.var_12B53 = func_FD5A("un_convoy_ship02", "un2", 0, 0, 0, 0, 1, "cannon_large_un missile_tube_un");
  wait 0.05;
  level.var_12B55 = func_FD5A("un_convoy_ship04", "un4", 0, 0, 0, 0, 1, "cannon_large_un missile_tube_un");
  level.var_12B56 = func_FD5A("un_convoy_ship05", "un5", 0, 0, 0, 0, 1, "cannon_large_un missile_tube_un");
  level.var_12B50 func_0BB8::func_39CE("low");
  level.var_12B54 func_0BB8::func_39CE("low");
  level.var_12B55 func_0BB8::func_39CE("low");
  level.var_12B56 func_0BB8::func_39CE("low");
  level.var_12B53 func_0BB8::func_39CE("low");
}

func_FD5A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_7)) {
    var_8 = getent(var_0, "targetname");
    var_8.var_EEF9 = var_7;
  }

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_9 = scripts\sp\vehicle::func_1080D(var_0);

  if(var_6) {
    var_9 thread func_0BB6::func_39E9(var_6);
  }

  var_9.delete_on_death = 1;
  var_9 scripts\sp\vehicle::playgestureviewmodel();
  var_9 thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_13248();

  if(var_9.var_6A8D == "un") {
    var_9 scripts\engine\utility::delaythread(0.8, func_0BB8::func_39CD, "idle");
    var_9 scripts\engine\utility::delaythread(0.8, func_0BB8::func_39D0, "idle");
  } else {
    var_9 scripts\engine\utility::delaythread(0.8, func_0BB8::func_39CD, "idle");
    var_9 scripts\engine\utility::delaythread(0.8, func_0BB8::func_39D0, "idle");
  }

  var_9 func_8064();
  return var_9;
}

func_CADA() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(4.5);
  level.var_EA99 scripts\sp\utility::func_10346("phspace_slt_yougoteyesonthi");
  scripts\sp\utility::func_1034D("phspace_plr_affirmative");
  level.var_EA99 scripts\sp\utility::func_10346("phspace_slt_youknowit");
  scripts\sp\utility::func_1034D("phspace_plr_letsgetinthere");
  level.var_EA99 thread scripts\sp\utility::func_10346("phspace_slt_always");
  scripts\sp\maps\phspace\phspace_launch::func_104EF();
  func_D0B6();
}

func_D0B6() {
  func_0BDC::func_A153(0);
  func_0BDC::func_A15B(0);
  func_0BDC::func_A14A(0);
  func_0BDC::func_A149(0);
  func_0BDC::func_A160(0, 0.5);
  wait 2.0;
  level.player allowads(1);
}

func_12B4D() {
  thread func_0BA9::func_397A(self.origin, 3);
  wait 3;
  level.player playSound("phspace_reveal_explo_lr");
  self hide();
  self.var_4E09 = undefined;
  self.var_9310 = 1;
  var_0 = spawn("script_model", self.origin);
  var_0.angles = self.angles;
  var_0 setModel("tag_origin");
  playFXOnTag(level._effect["vfx_generic_ship_death"], var_0, "tag_origin");
  self func_81D0();
  wait 0.4;
  earthquake(0.07, 3, level.var_D127.origin, 10000);
  wait 3.2;
  earthquake(0.11, 4, level.var_D127.origin, 10000);
}

func_20E9() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(12.5);
  thread phspace_audio_mix_for_2nd_explosion();
  var_0 = getent("trigger_shoot_missiles_at_player", "targetname");
  var_0 func_0BDC::func_136A6(level.var_D127);
  wait 3;
  level.var_3664 thread func_0BB6::func_3966(1, 0, level.var_12B4C);
  wait 1;
  level.var_EA99 thread func_6FF4("ship_1_ally_goal_right");
  level.var_1CB9 thread func_6FF4("ship_1_ally_goal_left");
  level.var_3662 thread func_0BB6::func_3984(level.var_D127);
  wait 4;
}

phspace_audio_mix_for_2nd_explosion() {
  level.player func_82C0("phspace_intro_cap_ship_explo_2", 2.0);
  wait 15;
  level.player func_82C0("jackal_cockpit", 2.0);
}

func_6FF4(var_0) {
  var_1 = scripts\engine\utility::getstruct(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  func_0BDC::func_19B7();
  func_0BDC::func_19A2();
  func_0BDC::func_19AB(600);
  self givescorefortrophyblocks();
  func_0BDC::func_A1EC(var_1.origin, 1, 10000, var_1.angles);
}

func_7318(var_0, var_1) {
  if(!isDefined(var_0) || !var_0) {
    var_2 = getent("trigger_allies_form_up", "targetname");
    var_2 func_0BDC::func_136A6(level.var_D127);
  }

  var_3 = (-1000, 700, 800);
  var_4 = (-700, 700, 800);
  var_5 = (3000, 700, 200);
  var_6 = (500, 3800, 2400);
  level.var_EA99 givescorefortrophyblocks();
  level.var_EA99 func_0BDC::func_19B0("fly");
  level.var_EA99 func_0BDC::func_1986();

  if(!isDefined(var_1) || isDefined(var_1) && var_1) {
    var_7 = level.var_D127.origin + rotatevector(var_3, level.var_D127.angles);
    level.var_EA99 vehicle_teleport(var_7, level.var_D127.angles);
  }

  wait 0.05;
  level.var_EA99 func_0BDC::func_19AB(1200);
  level.var_EA99 func_0BDC::func_1994(level.var_D127, var_4, 200, 0.1, 4000, 1.0);
  wait 0.05;
  level.var_EA99 func_0BDC::func_19AB(1200);
  level.var_EA99 func_0BDC::func_199D(4, var_5, 300, 0.08, 10000, 1.0);
}

func_7317(var_0, var_1) {
  if(!isDefined(var_0) || !var_0) {
    var_2 = getent("trigger_allies_form_up", "targetname");
    var_2 func_0BDC::func_136A6(level.var_D127);
  }

  var_3 = (-1000, -700, 800);
  var_4 = (-700, -700, 800);
  var_5 = (4000, -900, 400);
  var_6 = (1000, -3800, 2400);
  level.var_1CB9 givescorefortrophyblocks();
  level.var_1CB9 func_0BDC::func_19B0("fly");
  level.var_1CB9 func_0BDC::func_1986();

  if(!isDefined(var_1) || isDefined(var_1) && var_1) {
    var_7 = level.var_D127.origin + rotatevector(var_3, level.var_D127.angles);
    level.var_1CB9 vehicle_teleport(var_7, level.var_D127.angles);
  }

  wait 0.05;
  level.var_1CB9 func_0BDC::func_19AB(1200);
  level.var_1CB9 func_0BDC::func_1994(level.var_D127, var_4, 200, 0.1, 4000, 1.0);
  wait 0.05;
  level.var_1CB9 func_0BDC::func_19AB(1200);
  level.var_1CB9 func_0BDC::func_199D(4, var_5, 300, 0.08, 7000, 1.0);
}

func_2731() {
  var_0 = spawnStruct();
  var_0.var_6D20 = 0.08;
  var_0.var_13535 = [8, 14];
  var_0.var_B46E = 8;
  var_0.var_6CF8 = func_0BB6::func_6D0C;
  level.var_39DD["missile_tube_ca"].var_10241 = var_0;
  level.var_12B60.var_12FBA = 1;
  level.var_12B61.var_12FBA = 1;
  level.var_12B4C.var_12FBA = 1;
  level.var_12B67.var_12FBA = 1;
  level.var_12B7D.var_12FBA = 1;
  wait 0.1;
  level.var_12B60 thread func_0BB6::func_3966(1, 0, level.var_3662);
  level.var_12B61 thread func_0BB6::func_3966(1, 0, level.var_3663);
  level.var_12B4C thread func_0BB6::func_3966(1, 0, level.var_3664);
  level.var_12B7D thread func_0BB6::func_3966(1, 0, level.var_3664);
  level.var_12B4C func_0BB6::func_398A(1);
  wait 0.1;
  level.var_3662 func_0BB6::func_398A(1);
  level.var_3663 func_0BB6::func_398A(1);
  level.var_3664 func_0BB6::func_398A(1);
  level.var_3665 thread func_0BB6::func_3983(level.var_12B60);
  level.var_3662 thread func_0BB6::func_3983(level.var_12B61);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(2.8);
  level.var_12B51 func_0BB6::func_3984(level.var_3662);
  level.var_12B60 func_0BB6::func_3984(level.var_3662);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(3.1);
  level.var_12B67 func_0BB6::func_3984(level.var_3665);
  level.var_12B7D func_0BB6::func_3984(level.var_3665);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(3.4);
  level.var_3665 thread func_0BB6::func_3983(level.var_12B4A);
  level.var_3662 thread func_0BB6::func_3983(level.var_12B4A);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(3.8);
  level.var_12B51 func_0BB6::func_3984(level.var_3662);
  level.var_12B61 func_0BB6::func_3984(level.var_3663);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(4.1);
  level.var_12B67 func_0BB6::func_3984(level.var_3665);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(4.5);
  level.var_12B7D func_0BB6::func_3984(level.var_3665);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(5);
  level.var_12B51 func_0BB6::func_3984(level.var_3662);
  level.var_12B61 func_0BB6::func_3984(level.var_3663);
  level.var_3662 thread func_0BB6::func_3984(level.var_12B60);
  level.var_3663 thread func_0BB6::func_3984(level.var_12B60);
  level.var_3664 thread func_0BB6::func_3984(level.var_12B61);
  level.var_3665 thread func_0BB6::func_3984(level.var_12B61);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(5.7);
  level.var_12B51 func_0BB6::func_3984(level.var_3662);
  level.var_12B60 func_0BB6::func_3984(level.var_3662);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(6.3);
  level.var_12B7D func_0BB6::func_3984(level.var_3665);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(7.0);
  level.var_12B67 func_0BB6::func_3984(level.var_3665);
  level.var_12B61 func_0BB6::func_3984(level.var_3663);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(8);
  level.var_12B67 func_0BB6::func_3984(level.var_3665);
  level.var_12B60 func_0BB6::func_3984(level.var_3662);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(9.5);
  level.var_3664 thread func_0BB6::func_3966(1, 0, level.var_12B4C);
  level.var_3662 func_0BB6::func_398A(0);
  var_0.var_6D20 = 0.05;
  var_0.var_13535 = [15, 18];
  var_0.var_B46E = 4;
  var_0.var_6CF8 = func_0BB6::func_6D0C;
  level.var_39DD["missile_tube_ca"].var_10241 = var_0;
  level.var_12B4C thread func_0BB6::func_3966(1, 0, level.var_3664);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(11);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(12);
  level.var_12B7D.turrets["cap_turret_cannon_large_un"][4] thread func_0BB6::func_129DF();
  level.var_12B7D.turrets["cap_turret_cannon_large_un"] = ::scripts\engine\utility::array_remove(level.var_12B7D.turrets["cap_turret_cannon_large_un"], level.var_12B7D.turrets["cap_turret_cannon_large_un"][4]);
  level.var_12B67 func_0BB6::func_3984(level.var_3665);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(14);
  level.var_12B61 func_81D0();
  level.var_3665 thread func_720F(1, 1);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_13801(16.2);
  level.var_12B60 func_81D0();
}

func_12B7E() {
  var_0 = getvehiclenode("space_path_tigris", "targetname");
  scripts\sp\vehicle::func_2471(var_0);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_13248();
  func_0BB8::func_39CD("heavy");
  func_0BB8::func_39D0("idle");
}

func_12B68() {
  self givescorefortrophyblocks();
  var_0 = getvehiclenode("space_path_ret", "targetname");
  scripts\sp\vehicle::func_2471(var_0);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_13248();
  func_0BB8::func_39CD("heavy");
  func_0BB8::func_39D0("idle");
}

func_12B52() {
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_13248();
  func_0BB8::func_39CD("heavy");
  func_0BB8::func_39D0("idle");
}

func_493A() {
  var_0 = (2, 2, 2);
  var_1 = (4500, 0, 0);
  var_2 = [];
  var_2[0] = func_491E(level.var_D127, 1000, -2400, 300, 1, "1", var_0, var_1, 1);
  var_2[1] = func_491E(level.var_D127, 100, -500, 1000, 1, "2", var_0, var_1, 1);
  var_2[2] = func_491E(level.var_D127, 1000, 300, -500, 1, "3", var_0, var_1, 1);
  var_2[3] = func_491E(level.var_D127, 300, -600, -300, 1, "4", var_0, var_1, 1);
  var_2[4] = func_491E(level.var_D127, 1300, -250, 750, 1, "5", var_0, var_1, 1);
  var_2[5] = func_491E(level.var_D127, 300, 1500, 200, 1, "6", var_0, var_1, 1);
  var_2[6] = func_491E(level.var_D127, 150, -700, 200, 1, "7", var_0, var_1, 1);
  var_2[7] = func_491E(level.var_D127, 1000, 750, -600, 1, "8", var_0, var_1, 1);
  var_2[8] = func_491E(level.var_D127, 450, -300, 100, 1, "9", var_0, var_1, 1);
  var_2[9] = func_491E(level.var_D127, 600, 750, 500, 1, "10", var_0, var_1, 1);
  var_2[10] = func_491E(level.var_D127, 1050, 500, -500, 1, "11", var_0, var_1, 1);
  var_2[11] = func_491E(level.var_D127, 600, -650, 400, 0, "12", var_0, var_1, 1);
  var_2[12] = func_491E(level.var_D127, 150, 750, 400, 0, "13", var_0, var_1, 1);
  var_2[13] = func_491E(level.var_D127, 1000, -210, 500, 0, "14", var_0, var_1, 1);
  var_2[14] = func_491E(level.var_D127, 10, 750, 300, 0, "15", var_0, var_1, 1);
  var_2[15] = func_491E(level.var_D127, 700, -2400, 300, 1, "1", var_0, var_1, 1);
  var_2[16] = func_491E(level.var_D127, 1300, -500, 1000, 1, "2", var_0, var_1, 1);
  var_2[17] = func_491E(level.var_D127, 200, 300, -500, 1, "3", var_0, var_1, 1);
  var_2[18] = func_491E(level.var_D127, 60, -700, -300, 1, "4", var_0, var_1, 1);
  var_2[19] = func_491E(level.var_D127, 1500, -250, 750, 1, "5", var_0, var_1, 1);
  var_2[20] = func_491E(level.var_D127, 1700, 1500, -600, 1, "6", var_0, var_1, 1);
  var_2[21] = func_491E(level.var_D127, 150, -700, 200, 1, "7", var_0, var_1, 1);
  var_2[22] = func_491E(level.var_D127, 100, 750, -600, 1, "8", var_0, var_1, 1);
  var_2 = scripts\engine\utility::array_reverse(var_2);
  return var_2;
}

func_493B() {
  var_0 = (2, 1, 1);
  var_1 = (3500, 2000, 4000);
  var_2 = [];
  var_2[0] = func_491E(level.var_D127, 1000, -2400, 300, 1, "1", var_0, var_1, 1);
  var_2[1] = func_491E(level.var_D127, 100, -500, 1000, 1, "2", var_0, var_1, 1);
  var_2[2] = func_491E(level.var_D127, 1000, 300, -500, 1, "3", var_0, var_1, 1);
  var_2[3] = func_491E(level.var_D127, 300, -600, -300, 1, "4", var_0, var_1, 1);
  var_2[4] = func_491E(level.var_D127, 1300, -250, 750, 1, "5", var_0, var_1, 1);
  var_2[5] = func_491E(level.var_D127, 300, 1500, 200, 1, "6", var_0, var_1, 1);
  var_2[6] = func_491E(level.var_D127, 150, -700, 200, 1, "7", var_0, var_1, 1);
  var_2[7] = func_491E(level.var_D127, 1000, 750, -600, 1, "8", var_0, var_1, 1);
  var_2[8] = func_491E(level.var_D127, 450, -300, 100, 1, "9", var_0, var_1, 1);
  var_2[9] = func_491E(level.var_D127, 600, 750, 500, 1, "10", var_0, var_1, 1);
  var_2[10] = func_491E(level.var_D127, 1050, 500, -500, 1, "11", var_0, var_1, 1);
  var_2 = scripts\engine\utility::array_reverse(var_2);
  return var_2;
}

func_B7F9(var_0, var_1, var_2) {
  var_3 = [];

  if(isDefined(self.var_8B4F["cap_hardpoint_missile_barrage"])) {
    var_3 = self.var_8B4F["cap_hardpoint_missile_barrage"];
    var_4 = "cannon_missile_ca_hardpoint";
    var_5 = level.var_39DD[var_4].var_10241;
  } else if(isDefined(self.var_8B4F["cap_missile_tube_ca"])) {
    var_3 = self.var_8B4F["cap_missile_tube_ca"];
    var_4 = "missile_tube_ca";
    var_5 = level.var_39DD[var_4].var_10241;
  }

  var_6 = func_0B76::func_A26D(0.2, 0.4, 300, 0.2, 0.4, 300);
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
    var_15.var_01CF = 20;

    if(isDefined(level.var_D127) && var_11 == level.var_D127) {
      var_12 thread func_0B76::func_A278();

      if(isDefined(var_2) && var_2) {
        var_15 thread func_1547();
      }

      var_15 thread func_0B76::func_A279(0);
    }

    self.var_AA99 = "capitalship_missile_launch";
    var_15 thread func_0B76::func_A332(var_0[var_16], 0, self, undefined, var_7, var_14, 0, undefined, var_8, 1, var_9, 1, undefined, var_6, 300);
    wait 0.2;
  }
}

func_1547() {
  self endon("death");

  while(!isDefined(self.var_6E8B)) {
    wait 0.05;
  }

  self.var_B464 = 2000;
  self.var_1545 = 30;
}

func_491E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_8)) {
    var_8 = 0;
  }

  var_1 = var_1 * var_6[0];
  var_1 = var_1 + var_7[0];
  var_2 = var_2 * var_6[1];
  var_2 = var_2 + var_7[1];
  var_3 = var_3 * var_6[2];
  var_3 = var_3 + var_7[2];

  if(var_8) {
    var_7 = anglesToForward(var_0.angles) * var_1 + anglestoright(var_0.angles) * var_2 + anglestoup(var_0.angles) * var_3;
  } else {
    var_7 = (var_1, var_2, var_3);
  }

  var_9 = spawn("script_origin", var_0.origin + var_7);
  var_9 linkto(var_0);
  var_9.var_1A89 = var_4;
  var_9.var_5F27 = 1;
  return var_9;
}

func_104B4() {
  scripts\engine\utility::flag_set("hint_did_basics");
  scripts\engine\utility::flag_set("hint_did_boosters");
  thread func_104B5();
}

func_104B5() {}

func_A0AC() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_F5A4();
  scripts\sp\maps\phspace\phspace::func_107C0();
  scripts\sp\maps\phspace\phspace::func_1062E();
  level.var_EA99 func_0BDC::func_6B4C("space", 0);
  level.var_1CB9 func_0BDC::func_6B4C("space", 0);
  var_0 = scripts\sp\vehicle::func_1080C("player_jackal");
  func_0BDC::func_10CD1(var_0);
  wait 0.05;
  var_1 = scripts\engine\utility::getstruct("jackal_assault_start", "targetname");
  level.var_D127 vehicle_teleport(var_1.origin, var_1.angles);
  thread func_D868();
  scripts\engine\utility::flag_wait("prespawn_done");
  thread scripts\sp\maps\phspace\phspace::func_1062B();

  foreach(var_0 in level.var_1D0B) {
    var_0 thread func_1D75(1, 0, 1);
  }

  thread func_FE2F();
  thread func_7318(1);
  thread func_7317(1);
  thread func_23A3();
}

func_A0A9() {
  level.var_A242 = 0;
  level.var_A1A3 = 0;
  level.var_B434 = 14;
  level.var_A243 = 10;
  level.var_A37C = 180;
  var_0 = 3;
  var_1 = 5;
  var_2 = 8;
  var_3 = level.var_A37C / 4;
  var_4 = level.var_A37C / 4 * 2;
  var_5 = level.var_A37C / 4 * 3;
  level.var_A259 = [];
  level.var_A259[0] = [3, var_3, 10];
  level.var_A259[1] = [5, var_4, 7];
  level.var_A259[2] = [8, var_5, 4];
  level.var_A259[3] = [10, var_5 / 2, 0];

  if(getdvarint("exec_review", 0)) {
    level.var_A243 = 7;
    level.var_A37C = 120;
    var_0 = 2;
    var_1 = 4;
    var_2 = 6;
    var_3 = level.var_A37C / 4;
    var_4 = level.var_A37C / 4 * 2;
    var_5 = level.var_A37C / 4 * 3;
    level.var_A259 = [];
    level.var_A259[0] = [3, var_3, 10];
    level.var_A259[1] = [5, var_4, 7];
    level.var_A259[2] = [6, var_5, 4];
    level.var_A259[3] = [7, var_5 / 2, 0];
  } else if(getdvarint("e3", 0) || getdvarint("e3_ending", 0)) {
    level.var_A243 = 4;
    level.var_A37C = 75;
    var_0 = 1;
    var_1 = 2;
    var_2 = 3;
    var_3 = level.var_A37C / 4;
    var_4 = level.var_A37C / 4 * 2;
    var_5 = level.var_A37C / 4 * 3;
    level.var_A259 = [];
    level.var_A259[0] = [2, var_3, 10];
    level.var_A259[1] = [3, var_4, 5];
    level.var_A259[2] = [4, var_5, 0];
  }

  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\utility::func_266A("jackal_assault");
  thread func_6E99();
  scripts\engine\utility::flag_set("move_to_assault_pos");
  thread func_A0A6();

  if(level.var_10CDA == "jackal_assault") {
    level.var_EA99 thread func_6FF4("ship_1_ally_goal_right");
    level.var_1CB9 thread func_6FF4("ship_1_ally_goal_left");
  }

  func_A0A8();
  scripts\engine\utility::flag_set("jackal_assault_intro_done");
  func_0BDC::func_A1A9(0);
  thread func_A1CC();
  level.var_58A4 = gettime() / 1000;
  thread func_5886();
  level.var_EA99 thread func_A0AA(2, "patrol_axis");
  level.var_1CB9 thread func_A0AA(2, "patrol_axis");
  level.var_3662.var_12FBA = 1;
  level.var_3663.var_12FBA = 1;
  level.var_3665.var_12FBA = 1;
  level.var_3663 thread func_F031(1, 1, var_1, var_4);
  level.var_3664 thread func_F031(1, 1);
  level.var_3665 thread func_F031(1, 1, var_0, var_3);
  level.var_3662 scripts\engine\utility::delaythread(13, ::func_728B, 1, 0);
  wait 5.0;

  while(level.var_A242 < level.var_A243 && gettime() / 1000 - level.var_58A4 < level.var_A37C && level.var_A1A3 > 0) {
    wait 0.2;
  }

  if(getdvarint("e3", 1)) {
    scripts\sp\utility::func_F305();

    if(scripts\sp\utility::func_9BEE()) {
      if(level.var_DADC) {
        _setsaveddvar("r_postaa", 0);
      }
    }
  }

  wait 5.0;
  level notify("stop_dogfight_bcs");
  scripts\engine\utility::flag_set("jackal_assault_complete");
  thread func_A0A5();
}

func_A0A6() {
  wait 2.0;
  scripts\sp\utility::func_10350("phspace_aic_allscarsengaget");
  scripts\engine\utility::flag_wait("jackal_assault_intro_done");
  wait 3.5;
  level.var_EA99 scripts\sp\utility::func_10346("phspace_slt_theyrelaunchin");
  scripts\engine\utility::flag_set("obj_sdf_squadron_start");
  thread func_A0A7();
  thread func_5878();
  wait 4;
  func_0BDC::func_A162(0);
}

func_A0A7() {
  var_0 = 3;
  scripts\sp\utility::func_56BE("hint_shoot_jackals", var_0);

  if(scripts\sp\utility::func_93A6()) {
    return;
  }
  wait(var_0);
  scripts\sp\utility::func_56BA("hint_lockon");
  level endon("player_did_lockon");
  scripts\sp\utility::func_10350("phspace_eth_lockontoatarget");
  wait 3.0;
  level.var_EA99 scripts\sp\utility::func_10346("phspace_slt_getalockon");
  wait 8.0;
  level.var_EA99 scripts\sp\utility::func_10346("phspace_slt_lockemup");
}

func_6E99() {
  wait 8;
  level.var_3662.var_B825 = 950;
  level.var_3662.var_B821 = 20;
  level.var_3662.var_594B = 1;
  var_0 = func_493A();
  var_0 = scripts\sp\utility::func_22B3(var_0, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]);
  var_1 = [15, 16, 17, 18];

  foreach(var_4, var_3 in var_0) {
    if(scripts\engine\utility::array_contains(var_1, var_4)) {
      var_0[var_4] delete();
      var_0[var_4] = level.var_D127;
    }
  }

  scripts\engine\utility::flag_set("jackal_noflare_hint");
  level.var_3662 thread func_B7F9(var_0, 2500, 1);
  wait 1.77;
  scripts\engine\utility::flag_clear("jackal_noflare_hint");
  var_5 = ["phspace_slt_incomingmissil", "phspace_slt_warheadsinbo", "phspace_slt_shotsincoming", "phspace_slt_heatseekersfl"];
  var_6 = scripts\engine\utility::random(var_5);
  level.var_EA99 scripts\sp\utility::func_10346(var_6);
}

func_A0A8() {
  wait 3.3;
  wait 3;
  scripts\engine\utility::flag_set("all_jackals_start_patrol");
  level notify("stop_intro_speed_controller");
  wait 3.0;
}

func_A1CC() {
  scripts\engine\utility::flag_wait("jackals_started_spawning");
  wait 2.0;
  var_0 = level.var_26EB.var_FE2D[0];

  foreach(var_2 in level.var_26EB.var_FE2D) {
    if(func_0B76::func_7A60(var_2.origin) < 0.4) {
      var_0 = var_2;
      break;
    }
  }

  var_0 endon("death");
  var_4 = anglesToForward(level.var_D127.angles);
  var_4 = vectornormalize(var_4 * -1);
  var_5 = anglestoright(level.var_D127.angles);
  var_6 = level.var_D127.origin + var_4 * 500 + var_5 * 500;
  var_0 vehicle_teleport(var_6, level.var_D127.angles);
  var_7 = 144000000;
  var_8 = 0;
  var_0 func_0BDC::func_19AE("shoot_at_will");

  for(;;) {
    if(distancesquared(level.var_D127.origin, var_0.origin) > var_7) {
      break;
    }
    var_4 = anglesToForward(level.var_D127.angles);
    var_9 = anglestoup(level.var_D127.angles);
    var_10 = level.var_D127.origin + var_4 * 20000 + var_9 * 1000;
    var_11 = vectordot(var_4, vectornormalize(level.var_D127.origin - var_0.origin));

    if(var_11 > 0) {
      var_0 thread func_0BDC::func_19AB(1400);
    } else {
      var_0 thread func_0BDC::func_19AB(700);

      if(var_8 == 0) {
        var_0 playSound("phspace_first_jackal_pass");
        var_8 = 1;
      }
    }

    var_0 thread func_0BDC::func_A1EC(var_10, 0);
    wait 0.2;
  }

  var_0 func_0BDC::func_19AB(550);
  var_0 func_0BDC::func_1986();
  var_0 func_0BDC::func_1990(1);
  var_0 func_0BDC::func_19AE("shoot_at_will");
  var_0 func_0BDC::func_19B3("patrol", "patrol_axis");
  var_0 func_0BDC::func_19B4("patrol");
}

func_6AF6(var_0) {
  var_1 = 8;
  var_2 = spawn("script_model", level.var_D127.origin);
  var_2 setModel("tag_origin");
  var_2.angles = level.var_D127.angles + (90, 0, 0);
  var_2.var_B824 = 5000;
  var_2.var_B825 = 1300;
  var_2.var_B823 = 1300;
  var_2.var_B822 = 0.1;
  var_3 = anglestoup(level.var_D127.angles);
  var_4 = anglesToForward(level.var_D127.angles);
  var_5 = anglestoright(level.var_D127.angles);
  var_3 = vectornormalize(var_3);
  var_4 = vectornormalize(var_4);
  var_5 = vectornormalize(var_5);

  while(var_1 > 0) {
    var_2.origin = level.var_D127.origin;
    var_6 = randomfloatrange(-3000, 1000);
    var_7 = randomfloatrange(500, 6000);
    var_8 = randomfloatrange(6000, 9000);

    if(scripts\engine\utility::cointoss()) {
      var_7 = var_7 * -1;
    }

    var_9 = var_3 * var_6;
    var_10 = var_4 * var_8;
    var_11 = var_5 * var_7;
    var_2.origin = var_2.origin + var_9;
    var_2.origin = var_2.origin + var_10;
    var_2.origin = var_2.origin + var_11;
    var_12 = [];
    var_12[0] = "TAG_ORIGIN";
    var_2 func_0B76::func_1945(var_0, var_0.var_24C4, 1);
    var_1 = var_1 - 1;
    wait 0.1;
  }

  wait 1.0;
  var_2 delete();
}

func_AA88(var_0) {
  var_1 = -1;
  var_2 = 2025000000;

  if(isDefined(var_0)) {
    var_2 = var_1 * var_1;
  }

  while(var_1 == -1 || var_1 > var_2) {
    var_1 = distancesquared(level.var_D127.origin, self.origin);
    wait 0.1;
  }

  var_3 = func_493A();
  thread func_B7F9(var_3, 2500);
  wait 1.2;
  var_3 = func_493B();
  thread func_B7F9(var_3, 2500);
}

func_10ACD(var_0, var_1) {
  if(isDefined(var_1)) {
    wait(var_1);
  }

  if(self getteamflagcount()) {
    self unlink();
  }

  self givescorefortrophyblocks();
  self.anims.state = "none";
  func_0BDC::func_6B4C("fly");
  thread func_0BDC::func_A1EF(scripts\sp\utility::func_7C9A(var_0), 510, 5000);
  wait 1.0;
  self setneargoalnotifydist(5000);
  self waittill("near_goal");
  func_0BDC::func_19AB(550);
  func_0BDC::func_1986();
  func_0BDC::func_1990(1);
  func_0BDC::func_19AE("shoot_at_will");
  func_0BDC::func_19B3("patrol", "patrol_axis");
  func_0BDC::func_19B4("patrol");
}

func_1D75(var_0, var_1, var_2) {
  self notify("new_patrol");
  self endon("death");
  self endon("new_patrol");
  func_0BDC::func_19B7();
  scripts\sp\vehicle::playgestureviewmodel();
  self.func_843F = 1;

  if(scripts\engine\utility::is_true(var_1) && scripts\engine\utility::cointoss()) {
    wait(randomfloatrange(0, 0.65));
  }

  if(isDefined(var_2)) {
    wait(var_2);
  }

  if(scripts\engine\utility::is_true(var_0)) {
    var_3 = anglestoup(level.var_D127.angles);
    var_4 = anglesToForward(level.var_D127.angles);
    var_5 = anglestoright(level.var_D127.angles);
    var_3 = vectornormalize(var_3);
    var_4 = vectornormalize(var_4);
    var_5 = vectornormalize(var_5);
    var_6 = randomfloatrange(500, 2000);
    var_7 = randomfloatrange(500, 3500);
    var_8 = randomfloatrange(-500, 1500);

    if(scripts\engine\utility::cointoss()) {
      var_6 = var_6 * -1;
    }

    if(scripts\engine\utility::cointoss()) {
      var_7 = var_7 * -1;
    }

    var_9 = var_3 * var_6;
    var_10 = var_4 * var_8;
    var_11 = var_5 * var_7;
    var_12 = level.var_D127.origin;
    var_12 = var_12 + var_9;
    var_12 = var_12 + var_10;
    var_12 = var_12 + var_11;
    self vehicle_teleport(var_12, level.var_D127.angles);
    wait 0.05;
  } else {
    thread func_0BDC::func_A373(self.script_noteworthy, 500);
  }

  thread func_2CB6();
  wait 1.0;
  self setneargoalnotifydist(5000);
  self waittill("near_goal");
  func_0BDC::func_19AB(550);
  func_0BDC::func_1986();
  func_0BDC::func_1990(1);
  func_0BDC::func_19AE("shoot_at_will");
  func_0BDC::func_19B3("patrol", "patrol_axis");
  func_0BDC::func_19B4("patrol");
}

func_A1CD(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_1 = _getclosestpointonnavmesh3d(var_1);
  func_0BDC::func_19AB(var_0);

  if(distancesquared(var_1, self.origin) > var_2 * var_2) {
    func_0BDC::func_A1EC(var_1, 0, var_2);
  }

  wait 0.2;
  func_0BDC::func_19B3("escape", undefined);
  func_0BDC::func_19AB(var_3);
  func_0BDC::func_1986();
  func_0BDC::func_19B3("patrol", var_4);
  func_0BDC::func_19B4("patrol");
  func_0BDC::func_1990(1);
  func_0BDC::func_19AE("shoot_at_will");
}

func_9ABF(var_0, var_1, var_2, var_3) {
  level endon("stop_intro_speed_controller");
  var_4 = 7000;
  var_5 = 1500;

  if(isDefined(var_2)) {
    var_4 = var_2;
  }

  if(isDefined(var_3)) {
    var_5 = var_3;
  }

  var_6 = 510;
  var_7 = 250;
  var_8 = 750;
  var_9 = var_6;

  for(;;) {
    var_10 = level.var_D127.origin[0] - level.var_3662.origin[0];
    var_11 = var_0.origin[0] - level.var_3662.origin[0];
    var_12 = var_10 - var_11;

    if(var_12 > var_4 && var_9 != var_7) {
      var_9 = var_7;
    } else if(var_12 < var_5 && var_9 != var_8) {
      var_9 = var_8;
    } else if(var_12 < var_4 && var_12 > var_5 && var_9 != var_6) {
      var_9 = var_6;
    }

    var_0 func_0BDC::func_19AB(var_9);

    foreach(var_14 in var_1) {
      var_14 func_0BDC::func_19AB(var_9);
    }

    wait 0.2;
  }
}

func_F031(var_0, var_1, var_2, var_3) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  self.team = "axis";
  func_0BB6::func_39E1();
  self.var_EEF9 = "cannon_missile_ca_hardpoint cannon_small_ca,1,1,amb_turret_sml_l_ts_1,amb_turret_sml_l_ts_5,amb_turret_sml_r_ts_1,amb_turret_sml_r_ts_5,amb_turret_sml_r_ts_6,amb_turret_sml_r_ts_7,amb_turret_sml_l_ts_6,amb_turret_sml_l_ts_7 cannon_flak_ca,1,1 cannon_phalanx";
  func_0BB6::func_39E8();
  wait 0.1;
  self solid();
  self setCanDamage(1);
  func_0BB6::func_398A(1);

  if(scripts\engine\utility::is_true(var_0)) {
    thread func_0BA9::func_39C9();
  }

  thread func_FD45();
  self.var_B904 = "veh_mil_air_ca_destroyer";
  thread func_0B53::func_B909();
  func_0BB8::func_39CE("high");
  thread func_0BB8::func_39D0("idle");
  thread func_0BB8::func_39CD("idle");
  wait 2.2;
  thread func_0BB6::func_39EF();

  if(scripts\engine\utility::is_true(var_1)) {
    thread func_0BB6::func_39F0();
    thread func_12A43();
  } else {
    self.var_12FBA = 1;
  }

  if(!isDefined(var_2)) {
    return;
  }
  while(level.var_A242 < var_2 && gettime() / 1000 - level.var_58A4 < var_3) {
    wait 0.1;
  }

  func_0BB6::func_398A(0);
  thread func_728B(1, 1, 8);
  thread scripts\sp\utility::func_10350("phspace_aic_enemyshipdown");
}

func_5886() {
  func_0BDC::func_A1AB("enemy_lockon");
  func_0BDC::func_A321(0);
  level.var_26EB = spawnStruct();
  level.var_26EB.var_FE2D = [];
  level.var_26EB thread func_B2E3("axis_arena_jackals", 1);
  thread func_5887();

  foreach(var_1 in level.var_A259) {
    while(level.var_A242 < var_1[0] && gettime() / 1000 - level.var_58A4 < var_1[1]) {
      wait 0.05;
    }

    level.var_B434 = var_1[2];
  }
}

func_5887() {
  wait 4;

  foreach(var_1 in level.var_26EB.var_FE2D) {
    var_1 thread func_A304();
    wait 0.5;
  }
}

func_A304() {
  func_0B76::func_39C3(2, 1);
  func_0BDC::func_105D5();
}

func_B2E3(var_0, var_1, var_2) {
  level.var_A12D = 0;
  var_3 = level.var_B434;
  var_4 = getEntArray(var_0, "targetname");
  var_4 = scripts\engine\utility::array_randomize(var_4);

  foreach(var_8, var_6 in var_4) {
    wait 0.05;

    if(level.var_A12D >= level.var_B434) {
      break;
    }
    var_6 scripts\sp\utility::func_1747(func_0BDC::func_19AB, 250);
    var_6 scripts\sp\utility::func_1747(::func_ABEF, self);
    var_6 scripts\sp\utility::func_1747(::func_5880);
    var_7 = var_6 scripts\sp\utility::func_10808();
    var_7 thread func_A33D(var_6);
    level.var_A12D++;
    level.var_A1A3 = level.var_A1A3 + 1;

    if(var_8 == 3) {
      scripts\engine\utility::flag_set("jackals_started_spawning");
    }

    wait(randomfloatrange(0.2, 1.1));
  }

  while(self.var_FE2D.size > 0) {
    wait 0.1;
    self.var_FE2D = scripts\engine\utility::array_removeundefined(self.var_FE2D);
    var_9 = gettime() / 1000 - level.var_58A4 - level.var_A37C;

    if(level.var_A1A3 < level.var_B434 && level.var_B434 != 0 && level.var_A243 - level.var_A242 > 3 && var_9 > 5) {
      foreach(var_6 in var_4) {
        var_11 = vectordot(anglesToForward(level.player getplayerangles()), vectornormalize(var_6.origin - func_0BDC::func_7BBA()));

        if(var_11 < 0.3) {
          var_7 = var_6 scripts\sp\utility::func_10808();
          var_7 thread func_A33D(var_6);
          level.var_A12D++;
          level.var_A1A3 = level.var_A1A3 + 1;
          wait 4;
          break;
        }

        wait 0.05;
      }

      continue;
    }

    if(level.var_A1A3 > level.var_B434) {
      if(level.var_A242 < level.var_A243) {
        var_13 = scripts\engine\utility::random(self.var_FE2D);

        if(isDefined(var_13.var_4090)) {
          continue;
        }
        level.var_A1A3 = level.var_A1A3 - 1;
        var_13.var_4090 = 1;
        var_13 thread scripts\sp\maps\phspace\phspace_mons::func_50BF(randomfloatrange(0, 4.5));
        continue;
      }

      foreach(var_7 in self.var_FE2D) {
        if(!isDefined(var_7.var_4090)) {
          level.var_A1A3 = level.var_A1A3 - 1;
          var_7.var_4090 = 1;
          var_7 thread scripts\sp\maps\phspace\phspace_mons::func_50BF(randomfloatrange(0, 4.5));
        }
      }
    }
  }
}

func_A33D(var_0) {
  if(!isDefined(var_0.script_noteworthy)) {
    return;
  }
  wait 0.1;
  var_1 = level.var_3662;

  if(var_0.script_noteworthy == "axis_jackal_s2") {
    var_1 = level.var_3663;
  } else if(var_0.script_noteworthy == "axis_jackal_s3") {
    var_1 = level.var_3664;
  } else if(var_0.script_noteworthy == "axis_jackal_s4") {
    var_1 = level.var_3665;
  }

  if(!isDefined(var_1) && isDefined(level.var_3665)) {
    var_1 = level.var_3665;
  } else if(!isDefined(var_1) && isDefined(level.var_3663)) {
    var_1 = level.var_3663;
  }

  if(!isDefined(var_1) && isDefined(level.var_3664)) {
    var_1 = level.var_3664;
  }

  var_2 = anglesToForward(var_1.angles);
  var_3 = anglestoup(var_1.angles);
  var_4 = anglestoright(var_1.angles);
  var_5 = var_1.origin + var_2 * -2368 + var_4 * -608 + var_3 * -200;
  var_6 = _combineangles(var_1.angles, (0, 90, 0));

  if(scripts\engine\utility::cointoss()) {
    var_5 = var_1.origin + var_2 * -2368 + var_4 * 608 + var_3 * -200;
    var_6 = _combineangles(var_1.angles, (0, -90, 0));
  }

  self vehicle_teleport(var_5, var_6);
}

func_E099() {
  wait 2;
  func_0BDC::func_105D8();
}

func_ABEF(var_0) {
  var_0.var_FE2D = scripts\engine\utility::array_add(var_0.var_FE2D, self);
  wait 0.1;

  if(isDefined(self.var_A420)) {
    var_0.var_FE2D = scripts\engine\utility::array_combine(var_0.var_FE2D, self.var_A420);
  }
}

func_5880() {
  var_0 = "patrol_axis";
  func_0BDC::func_1990(1);
  func_0BDC::func_19B3("patrol", var_0);
  func_0BDC::func_19B4("patrol");
  self waittill("death");

  if(!isDefined(self.var_4090)) {
    level.var_A242 = level.var_A242 + 1;
    level.var_A1A3 = level.var_A1A3 - 1;
    wait(randomfloatrange(0.4, 0.8));
    var_1 = ["phspace_eth_goodeffectont", "phspace_eth_goodkill", "phspace_eth_theyregone", "phspace_eth_targetdestroyed", "phspace_eth_kaboom", "phspace_eth_goodthundersir"];
    var_2 = func_CB28("kill_comments", var_1);

    if(level.var_A243 - level.var_A242 == 3 && scripts\engine\utility::cointoss()) {
      var_2 = "phspace_slt_twomore";
      wait(randomfloatrange(0.5, 0.8));
    } else if(level.var_A243 - level.var_A242 == 2 && scripts\engine\utility::cointoss()) {
      var_2 = "phspace_slt_lastoneraider";
      wait(randomfloatrange(0.5, 0.8));
    } else if(level.var_A243 - level.var_A242 == 1 && scripts\engine\utility::cointoss()) {
      wait(randomfloatrange(0.5, 0.8));
    }

    level.var_EA99 scripts\sp\utility::func_10346(var_2);
  }

  level.var_A12D--;
}

func_CB28(var_0, var_1) {
  if(!isDefined(level.var_134F6)) {
    level.var_134F6 = [];
  }

  if(!isDefined(level.var_134F6[var_0])) {
    level.var_134F6[var_0] = [];

    foreach(var_4, var_3 in var_1) {
      level.var_134F6[var_0][var_4] = [var_3, 0];
    }
  }

  level.var_134F6[var_0] = ::scripts\engine\utility::array_randomize(level.var_134F6[var_0]);

  foreach(var_4, var_3 in level.var_134F6[var_0]) {
    if(var_3[1] == 0) {
      level.var_134F6[var_0][var_4][1] = level.var_134F6[var_0][var_4][1] + 1;
      return level.var_134F6[var_0][var_4][0];
    }
  }

  level.var_134F6[var_0][0][1] = level.var_134F6[var_0][0][1] + 1;
  return level.var_134F6[var_0][0][0];
}

func_A0AA(var_0, var_1) {
  wait(var_0);
  func_0BDC::func_19B7();
  func_0BDC::func_1990(1);
  func_0BDC::func_19B3("patrol", var_1);
  func_0BDC::func_19B4("patrol");
}

func_A0A4() {
  thread func_A0A5();
}

func_A0A5() {}

func_FD19() {
  scripts\sp\maps\phspace\phspace::func_107C0();
  scripts\sp\maps\phspace\phspace::func_1062E();
  level.var_EA99 func_0BDC::func_6B4C("space", 0);
  level.var_1CB9 func_0BDC::func_6B4C("space", 0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_F5A4();
  var_0 = scripts\sp\vehicle::func_1080C("player_jackal");
  func_0BDC::func_10CD1(var_0);
  wait 0.05;
  var_1 = scripts\engine\utility::getstruct("ship_assault_start", "targetname");
  level.var_D127 vehicle_teleport(var_1.origin, var_1.angles);
  thread func_D868();
  scripts\engine\utility::flag_wait("prespawn_done");
  thread scripts\sp\maps\phspace\phspace::func_1062B();
  thread func_1D76();
  thread func_12B5F();
  thread func_FE2F();
  thread func_7318(1);
  thread func_7317(1);
  thread func_5878();
  thread func_23A3();
}

func_1D76() {
  wait 1.0;

  foreach(var_1 in level.var_1D0B) {
    var_1 vehicle_teleport(level.var_3664.origin, level.var_3664.angles);
    var_1 func_8455(level.var_3664.origin, 1, level.var_3664.angles);
  }
}

func_FCFF() {
  scripts\engine\utility::flag_wait("prespawn_done");
  scripts\sp\utility::func_266A("ship_assault");
  level.var_A8B9 = level.var_3664;
  func_0BDC::func_A162();
  func_0BDC::func_A1A9(1);

  if(level.var_10CDA == "ship_assault") {
    level.var_3664 scripts\engine\utility::delaythread(2, ::func_F031, 1, 1);
  }

  thread func_FCF2(level.var_A8B9);
  thread func_FD2B(level.var_A8B9);
  thread func_FD27(level.var_A8B9);
  thread func_6DC9();
  wait 3.0;
  level.var_3664 notify("reached_dynamic_path_end");
  thread func_FD1C();

  if(getdvarint("e3", 0) == 1 || getdvarint("exec_review", 0) == 1) {
    level.var_12FB6 = 0;
  }

  while(isalive(level.var_A8B9)) {
    wait 0.1;
  }

  level notify("stop_dogfight_bcs");
  scripts\sp\utility::func_266A("jackal_assault_end");
  func_DFC2();
  wait 1.8;
  thread func_2397();
  wait 4.8;

  if(getdvarint("e3", 0) || getdvarint("exec_review", 0) || getdvarint("e3_ending", 0)) {
    func_5F9D();
  }

  scripts\engine\utility::flag_set("ship_assault_complete");
  scripts\engine\utility::exploder("returnret");
  thread func_12B7B(1);
  thread func_FCEC();
}

func_2397() {
  level.var_1CB9 scripts\sp\utility::func_10346("phspace_plt2_boombaby");
  level.var_EA99 scripts\sp\utility::func_10346("phspace_plt1_hahadamn");
  scripts\sp\utility::func_10350("phspace_aic_targetdownnice");
}

func_DFC2() {
  foreach(var_1 in level.var_A056.var_1630) {
    if(isDefined(var_1) && var_1.script_team == "allies") {
      var_1 func_0BDC::func_105DA();
    }
  }
}

func_5F9D() {
  setomnvar("ui_hide_hud", 1);
  scripts\sp\hud_util::func_6AA3(0.3, "black");
  wait 0.3;
  thread scripts\sp\hud_util::func_6A99(0.05);
  _cinematicingame("IW_Title_Card_E3");
  wait 4.5;
  _pausecinematicingame(1);
  level waittill("forever");
}

func_FCF2(var_0) {
  scripts\sp\utility::func_10350("phspace_eth_sironesetdefshi");
  var_0 func_0BDC::func_105DB("capitalship", "JACKAL_SDF_DESTROYER", "none", "enemy_capitalship", 0, 1, 1);
  var_0 func_0BDC::func_A36D();

  while(!var_0 func_FD10() || level.var_D127 func_0BDC::func_8B87()) {
    wait 0.05;
  }

  scripts\engine\utility::delaythread(0.2, scripts\sp\utility::func_56BA, "hint_shoot_ships");
  var_0 scripts\engine\utility::delaythread(2.5, ::func_FD05);
  scripts\sp\utility::func_1034D("phspace_plr_allsatodirectfir");
  scripts\sp\utility::func_10350("phspace_plt1_copyengaging");
  var_0.var_B83F = 4;
  var_0.var_A8EA = gettime();
  var_0 func_0BB6::func_39A3(1);
  scripts\sp\utility::func_56BA("hint_switch_cannons");
  thread func_53AA();
  thread func_1136B();
  wait 0.5;
  var_0 thread func_FD3C();
  wait 1.5;
  scripts\sp\utility::func_1034D("phspace_plr_airdefenses");
  wait 0.1;
  level.var_EA99 scripts\sp\utility::func_10346("phspace_slt_takeemout");
  scripts\sp\utility::func_1034D("phspace_slt_rogerthat");
}

func_FD10() {
  if(func_0BDC::func_9C1B(0.9) && func_0BDC::func_9C1A(25000)) {
    return 1;
  } else {
    return 0;
  }
}

func_53AA() {
  while(isDefined(level.var_A8B9) && isalive(level.var_A8B9)) {
    if(level.var_D127.var_4C15 == level.var_D127.var_13BF8) {
      break;
    }
    wait 0.1;
  }

  scripts\engine\utility::flag_set("hint_did_cannons");
}

func_1136B() {
  level endon("hint_did_cannons");
  level.var_EA99 scripts\sp\utility::func_10346("phspace_slt_useyourcannons");
  wait 6.0;
  level.var_EA99 scripts\sp\utility::func_10346("phspace_slt_switchtomaincannon");
}

func_FD05() {
  func_0BDC::func_A36A();
  thread func_0B76::func_39C3(3);
  self.var_12A8B = 1;
  func_0BB6::func_39CA(0, undefined, "turret_ja");
  func_0BDC::func_A112("phspace_cmp_targetsudpated");

  foreach(var_1 in self.var_8B4F) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3)) {
        var_3 func_0BDC::func_105DB("turret_ja", var_3.var_11549, var_3.var_3AF3, "enemy_jackal");
      }

      wait 0.05;
    }
  }
}

func_FCFB(var_0, var_1) {
  self endon("death");
  thread func_FCFA(var_0);
  var_0 waittill("death");
  thread func_FCFA(var_0);
}

func_FCFA(var_0) {
  level endon("ship_assault_complete");
  self endon("death");
  self notify("new_patrol");
  self endon("new_patrol");

  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }
  func_0BDC::func_19B7();
  func_0BDC::func_19AB(500);
  func_0BDC::func_1990(0);
  var_1 = var_0.origin;

  if(isDefined(var_0.var_24C4)) {
    var_1 = var_0 gettagorigin(scripts\engine\utility::random(var_0.var_24C4));
  }

  thread func_A1CD(500, var_1, 18000, 350, var_0.var_C9A2);
}

func_FD2B(var_0) {
  var_0.team = "axis";
  var_0.script_team = "axis";
  level.var_1D0B = scripts\engine\utility::array_removeundefined(level.var_1D0B);

  foreach(var_2 in level.var_1D0B) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_2 thread func_A1CD(400, var_0.origin, 15000, 200, var_0.var_C9A2);
      var_2 func_0BDC::func_19AE("shoot_at_will");
      var_2 thread func_DCBC(var_0);
    }
  }

  level.var_EA99 thread func_13D81(0, var_0);
  level.var_1CB9 thread func_13D81(1, var_0);
}

func_DCBC(var_0) {
  self endon("death");
  var_0 endon("death");

  for(;;) {
    wait(randomfloatrange(0, 12));

    if(randomint(100) > 75) {
      func_0B76::func_1992("tag_origin", var_0);
      wait 0.2;

      if(scripts\engine\utility::cointoss()) {
        func_0B76::func_1992("tag_origin", var_0);
      }

      wait 0.2;

      if(scripts\engine\utility::cointoss()) {
        func_0B76::func_1992("tag_origin", var_0);
      }

      wait 0.2;

      if(scripts\engine\utility::cointoss()) {
        func_0B76::func_1992("tag_origin", var_0);
      }

      wait 0.2;

      if(scripts\engine\utility::cointoss()) {
        func_0B76::func_1992("tag_origin", var_0);
      }
    }
  }
}

func_FD3C() {
  self endon("death");
  var_0 = "phspace_slt_airdefensesare";
  var_1 = "phspace_plr_stayonit1";
  level.var_FD4A = 80000;
  thread func_FD3D();
  var_2 = 1;
  self.var_4D1C = level.var_FD4A;
  thread func_FCD5();

  while(self.var_4D1C > 0) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(var_4 != level.var_D127) {
      var_3 = var_3 / 20;
    } else if(var_4 == level.var_D127) {
      var_3 = var_3 * var_2;
    }

    self.var_4D1C = self.var_4D1C - var_3;

    if(self.var_4D1C < level.var_FD4A / 3 * 2 && isDefined(var_0)) {
      level.var_EA99 thread scripts\sp\utility::func_10346(var_0);
      var_0 = undefined;
      continue;
    }

    if(self.var_4D1C < level.var_FD4A / 3 && isDefined(var_1)) {
      thread scripts\sp\utility::func_1034D(var_1);
      var_1 = undefined;
    }
  }

  self notify("stop_healthwatcher");
  level.var_EA99 thread scripts\sp\utility::func_10346("phspace_slt_shesgonnablow");
  func_728B(0, undefined, undefined, 1);
}

func_FCD5() {
  level.player endon("death");
  self endon("death");
  self endon("stop_healthwatcher");
  var_0 = func_52FA();
  var_1 = func_52F9();
  var_2 = var_0;
  var_3 = var_1;
  var_4 = 3000;
  var_5 = 1300;

  for(;;) {
    var_6 = 0;
    var_0 = func_52FA();
    var_1 = func_52F9();
    var_7 = var_2 - var_0;
    var_8 = var_3 - var_1;
    var_9 = var_7 * var_4;
    var_10 = var_8 * var_5;
    var_6 = var_9 + var_10;

    if(var_6 > 0) {
      self.var_4D1C = self.var_4D1C - var_6;
      wait 0.1;
      self getrandomarmkillstreak(1, self.origin, level.var_D127);
    }

    var_2 = var_0;
    var_3 = var_1;
    wait 0.1;
  }

  self func_81D0();
}

func_52FA() {
  var_0 = 0;

  if(isDefined(self.turrets) && isDefined(self.turrets["cap_turret_med_flak"])) {
    var_0 = scripts\engine\utility::array_removeundefined(self.turrets["cap_turret_med_flak"]).size;
  }

  if(isDefined(self.turrets) && isDefined(self.turrets["cap_turret_phalanx"])) {
    var_0 = var_0 + scripts\engine\utility::array_removeundefined(self.turrets["cap_turret_phalanx"]).size;
  }

  if(isDefined(self.turrets) && isDefined(self.turrets["cap_turret_small_constant"])) {
    var_0 = var_0 + scripts\engine\utility::array_removeundefined(self.turrets["cap_turret_small_constant"]).size;
  }

  return var_0;
}

func_52F9() {
  var_0 = 0;

  if(isDefined(self.var_8B4F) && isDefined(self.var_8B4F["cap_hardpoint_missile_barrage"])) {
    var_0 = scripts\engine\utility::array_removeundefined(self.var_8B4F["cap_hardpoint_missile_barrage"]).size;
  }

  return var_0;
}

func_FD27(var_0) {
  level.var_12B67 thread func_12B7A(var_0);
  level.var_12B7D thread func_12B7A(var_0);
  level.var_12B67 thread func_0BB6::func_3983(var_0);
  wait 2.5;
  level.var_12B7D thread func_0BB6::func_3983(var_0);
  wait 2.0;
  level.var_12B51 thread func_0BB6::func_3983(var_0);
}

func_FCF8() {
  level.var_39DD["cannon_flak_ca"].var_10241.var_6D20 = 0.5;
  level.var_39DD["cannon_flak_ca"].var_10241.var_13536 = [3, 6];
  level.var_39DD["cannon_flak_ca"].var_10241.var_13535 = [0.2, 0.6];
}

func_12B7A(var_0) {
  if(!isDefined(self)) {
    return;
  }
  thread func_0BB6::func_3966(1, 0, var_0);
  var_0 waittill("death");
  self endon("end_capitalship_ambient_targets");
  self endon("end_capitalship_attacking");
}

func_FD1C() {
  foreach(var_1 in level.var_52D1) {
    var_1 func_0BA9::func_3978();
  }
}

func_13D81(var_0, var_1) {
  self notify("new_wingman_attack_logic");
  self endon("new_wingman_attack_logic");
  self endon("death");

  if(!isDefined(var_1.var_13D86) || !isDefined(var_1.var_13D86[var_0])) {}

  var_2 = scripts\engine\utility::getstructarray(var_1.var_13D86[var_0], "script_noteworthy");

  if(!isDefined(var_2) || var_2.size == 0) {}

  func_0BDC::func_19AB(400);

  while(isDefined(var_1) && isalive(var_1)) {
    var_3 = scripts\engine\utility::random(var_2);
    func_0BDC::func_19B7();
    func_0BDC::func_19A2();
    func_0BDC::func_A1EC(var_3.origin, 1, 512, var_3.angles);
    var_4 = var_1;

    if(randomint(4) != 0) {
      var_4 = var_1 func_78CB(self);
    }

    if(isDefined(var_4)) {
      func_0BDC::func_19B5(var_4);
    }

    func_0BDC::func_19B2("face enemy");
    func_0BDC::func_19AE("shoot_at_will");
    wait(randomfloatrange(1, 4));
    func_0BDC::func_19AB(150);
  }
}

func_78CB(var_0) {
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

func_6DC9() {
  level endon("mons_intro_setup_complete");

  for(;;) {
    if(func_0B76::func_7A60(level.var_12B67.origin) < 0.5) {
      scripts\sp\maps\phspace\phspace_mons::func_1F90();
      return;
    }

    wait 0.1;
  }
}

func_FD18() {
  level.var_39DD["cannon_missile_ca"].var_10241.var_6D39 = 0.35;
  level.var_39DD["cannon_missile_ca"].var_10241.var_6D20 = 1;
  level.var_39DD["cannon_missile_ca"].var_10241.var_13536 = [0.9, 1];
  level.var_39DD["cannon_missile_ca"].var_10241.var_13535 = [8, 10];
  level.var_39DD["cannon_missile_ca"].var_10241.var_10943 = ::func_530A;
}

func_530A(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = ["amb_missile_l_1", "amb_missile_r_1", "amb_missile_l_3", "amb_missile_r_3", "amb_missile_l_5", "amb_missile_r_5", "amb_missile_l_7", "amb_missile_r_7", "amb_missile_l_9", "amb_missile_r_9", "amb_missile_l_11", "amb_missile_r_11"];
  var_5 = [3, 7, 11, 15, 19, 23];
  var_6 = 10;

  foreach(var_16, var_8 in var_4) {
    var_9 = func_7D23(var_8, var_0);

    if(isDefined(var_9)) {
      foreach(var_11 in var_2) {
        var_12 = var_9 func_0BB6::func_12A36(var_11);
        var_13 = var_9 func_0BB6::func_12A37(var_11, var_12);

        if(self.var_114FB != self) {
          var_9.var_114FB = self.var_114FB;
        }

        var_14 = [];
        var_14[0] = var_11;
        var_9 func_0B76::func_1945(var_9.var_114FB, var_14, 1);
      }
    }

    if(isDefined(var_1)) {
      wait(var_1.var_6D39);
    } else {
      wait 0.3;
    }

    if(scripts\engine\utility::array_contains(var_5, var_16)) {
      wait(var_6);
    }

    if(func_0BB6::func_12A3B(var_3, self.var_114FB) || scripts\engine\utility::is_true(self.var_1D62)) {
      func_0BB6::func_B2CA(var_3);
    }
  }
}

func_7D23(var_0, var_1) {
  foreach(var_3 in self.turrets[var_1]) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3.var_AD42 == var_0) {
      return var_3;
    }
  }

  return undefined;
}

func_12A43() {
  self endon("death");
  self endon("turret_threat_handler_stop");

  for(;;) {
    var_0 = 0;
    var_1 = distance(level.var_D127.origin, self.origin);

    if(var_1 < 18000 && randomint(100) < 90) {
      var_0 = 1;
    }

    if(var_1 <= 8000) {
      var_0 = 1;
    }

    if(scripts\sp\utility::func_7B9D() <= 0.1) {
      var_0 = 0;
    } else if(scripts\sp\utility::func_7B9D() >= 0.6) {
      var_0 = 1;
    }

    self.var_1D62 = var_0;
    self.var_11578 = var_0;
    wait 3;
  }
}

func_720F(var_0, var_1) {
  level.var_12B67.var_B824 = 400;
  level.var_12B67.var_B825 = 700;
  level.var_12B67.var_B823 = 700;
  level.var_12B7D.var_B824 = 400;
  level.var_12B7D.var_B825 = 700;
  level.var_12B7D.var_B823 = 700;
  level.var_12B51.var_B824 = 400;
  level.var_12B51.var_B825 = 700;
  level.var_12B51.var_B823 = 700;
  level.var_12B67 thread func_0BB6::func_3983(self);
  level.var_12B7D thread func_0BB6::func_3983(self);
  level.var_12B51 thread func_0BB6::func_3983(self);

  if(!isDefined(var_0) || !var_0) {
    if(scripts\engine\utility::cointoss()) {
      scripts\sp\utility::func_10350("phspace_plr_phalanxisdown");
      scripts\sp\utility::func_10350("phspace_plr_allshipsopenfire");
    } else {
      scripts\sp\utility::func_10350("phspace_vcp_vanguardengagin");
    }
  }

  var_2 = 0;

  while(var_2 < 2) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(var_7 == "MOD_EXPLOSIVE" && !isDefined(var_12)) {
      var_2 = var_2 + 1;
    }

    wait 0.05;
  }

  thread func_728B();
}

func_728B(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = 0;
  var_5 = 0.5;

  if(scripts\engine\utility::is_true(var_1)) {
    var_6 = -1;
    var_7 = gettime();

    while(var_6 < 0.8) {
      wait 0.1;
      var_6 = func_0B76::func_7A60(self.origin);

      if(var_6 < var_5 && !var_4) {
        func_A9D2();
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
      var_6 = func_0B76::func_7A60(self.origin);

      if(var_6 <= var_5) {
        func_A9D2();
        var_4 = 1;
        wait 0.1;
        break;
      }

      if(gettime() - var_7 > 4000) {
        break;
      }
    }
  }

  self.var_BFE3 = 1;
  var_8 = func_0BA9::func_39AA(undefined, var_0, var_3);
  level.var_52D1 = scripts\engine\utility::array_add(level.var_52D1, var_8);
}

func_A9D2() {
  var_0 = self.var_4BF7;

  if(isDefined(self.var_4BF7.target)) {
    var_0 = getvehiclenode(self.var_4BF7.target, "targetname");
  }

  while(isDefined(var_0.target)) {
    var_0 = getvehiclenode(var_0.target, "targetname");
  }

  var_1 = var_0;
  self vehicle_teleport(var_1.origin, var_1.angles);
  self vehicle_setspeedimmediate(0, 5, 500);
}

func_FD3D() {
  self waittill("death");
  level.player playSound("scn_last_capital_ship_explo_lr");
  wait 2.2;
  _setmusicstate("");
  wait 2.5;

  if(getdvarint("e3", 0)) {
    level.player func_82C0("phspace_e3_fade", 4);
  }
}

func_FD45() {
  self endon("death");
  self endon("stop_idle_listing_motion");
  var_0 = 15;
  var_1 = var_0 / 2;
  var_2 = var_0 / 2;
  self waittill("reached_dynamic_path_end");
  wait 0.2;
  var_3 = spawn("script_origin", self.origin);
  var_3.angles = self.angles;
  self linkto(var_3);

  for(;;) {
    var_4 = randomfloatrange(200, 600);
    var_5 = randomfloatrange(200, 600);
    var_6 = randomfloatrange(100, 400);

    if(scripts\engine\utility::cointoss()) {
      var_4 = var_4 * -1;
    }

    if(scripts\engine\utility::cointoss()) {
      var_5 = var_5 * -1;
    }

    if(scripts\engine\utility::cointoss()) {
      var_6 = var_6 * -1;
    }

    var_7 = randomfloatrange(2, 6);
    var_8 = randomfloatrange(4, 10);
    var_9 = randomfloatrange(3, 8);

    if(scripts\engine\utility::cointoss()) {
      var_7 = var_7 * -1;
    }

    if(scripts\engine\utility::cointoss()) {
      var_8 = var_8 * -1;
    }

    if(scripts\engine\utility::cointoss()) {
      var_9 = var_9 * -1;
    }

    var_3 moveto(var_3.origin + (var_4, var_5, var_6), var_0, var_1, var_2);
    var_3 rotateto(var_3.angles + (var_7, var_8, var_9), var_0, var_1, var_2);
    var_3 waittill("movedone");
    var_3 waittill("rotatedone");
    wait(randomfloatrange(0, 2));
    var_3 moveto(var_3.origin - (var_4, var_5, var_6), var_0, var_1, var_2);
    var_3 rotateto(var_3.angles - (var_7, var_8, var_9), var_0, var_1, var_2);
    var_3 waittill("movedone");
    var_3 waittill("rotatedone");
    wait(randomfloatrange(0, 2));
  }
}

func_FCEB() {
  thread func_FCEC();
  scripts\engine\utility::flag_set("hint_did_updown");
  scripts\engine\utility::flag_set("ship_assault_complete");
}

func_FCEC() {}

func_CF9B() {}

func_104B9() {}

func_5878() {
  scripts\sp\utility::func_28D8();
  scripts\sp\utility::func_CF8D();
}

func_A24C(var_0) {
  level.var_EA99 func_0BDC::func_19A2();
  level.var_1CB9 func_0BDC::func_19A2();
  level.var_EA99 animscripted("space_launch_done", var_0.origin, var_0.angles, level.var_EC85["salter_jackal"]["space_launch"]);
  level.var_1CB9 animscripted("space_launch_done", var_0.origin, var_0.angles, level.var_EC85["jackal_ally1"]["space_launch"]);
  wait 0.05;
  level.var_EA99 func_82B0(level.var_EC85["salter_jackal"]["space_launch"], 0.803228);
  level.var_1CB9 func_82B0(level.var_EC85["jackal_ally1"]["space_launch"], 0.803228);
  level.var_EA99 waittill("space_launch_done");
  wait 0.05;
  level.var_EA99 givescorefortrophyblocks();
  level.var_1CB9 givescorefortrophyblocks();
  level.var_EA99 func_0BDC::func_A1EC(level.var_EA99.origin, 1, 384, level.var_EA99.angles);
  level.var_1CB9 func_0BDC::func_A1EC(level.var_1CB9.origin, 1, 384, level.var_1CB9.angles);
  level.player func_8463("moveto");
  level.player func_8463("lookat");
}

#using_animtree("jackal");

func_2CB6() {
  self give_attacker_kill_rewards( % jackal_vehicle_fly_motion, 1, 0, 1.5);
  self func_82B0( % jackal_vehicle_fly_motion, randomfloatrange(0, 1));
  self give_attacker_kill_rewards( % jackal_extra_fly_motion_overlay, 0.0, 0);
  self give_attacker_kill_rewards( % jackal_extra_fly_motion_overlay, 0.5, 2);
  wait 3;
  self give_attacker_kill_rewards( % jackal_extra_fly_motion_overlay, 0, 12);
}

func_FA45() {
  var_0 = getEntArray("skyspray_org", "targetname");
  self.var_102A9 = var_0;
}

func_12B7B(var_0) {
  wait 1.0;
  var_1 = [level.var_12B50, level.var_12B54, level.var_12B55, level.var_12B56, level.var_12B53, level.var_12B7D, level.var_12B51];

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
      playFXOnTag(level._effect["capital_turret_smolder_lg"], var_3, var_5.var_AD42);
      var_5 thread func_0BA9::func_12A4F(0.1);
      var_4 = var_4 - 1;

      if(!scripts\engine\utility::is_true(var_0)) {
        wait(randomfloatrange(0.1, 2));
        continue;
      }

      wait 0.1;
    }
  }
}

func_23A3() {
  var_0 = scripts\engine\utility::getstructarray("debris_cloud_struct_assault", "script_noteworthy");
  var_1 = undefined;
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    var_2[var_5] = spawnfx(scripts\engine\utility::getfx("vfx_sc_space_debris_field_01"), var_4.origin, anglesToForward(var_4.angles), anglestoup(var_4.angles));
    wait 0.05;
    triggerfx(var_2[var_5]);
  }

  scripts\engine\utility::flag_wait("ship_assault_complete");

  foreach(var_7 in var_2) {
    var_7 delete();
  }
}

spawn_ret_door_hack() {
  while(!isDefined(level.var_12B67)) {
    wait 0.05;
  }

  if(isDefined(level.var_E311)) {
    return;
  }
  level.var_E311 = spawn("script_model", level.var_12B67.origin);
  level.var_E311 setModel("veh_mil_air_un_retribution_details_door");
  level.var_E311 linkto(level.var_12B67, "tag_origin", (0, 0, 0), (0, 0, 0));
}

delete_ret_door_hack() {
  if(!isDefined(level.var_E311)) {
    return;
  }
  level.var_E311 delete();
}