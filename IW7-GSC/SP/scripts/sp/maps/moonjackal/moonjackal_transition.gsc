/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moonjackal\moonjackal_transition.gsc
****************************************************************/

_id_1265F() {
  scripts\engine\utility::flag_init("show_rally_point");
  scripts\engine\utility::flag_init("boost_final_dialog");
  scripts\engine\utility::flag_init("player_moving");
  scripts\engine\utility::flag_init("started_transition");
  scripts\engine\utility::flag_init("did_transition_boost");
  scripts\engine\utility::flag_init("launch_area_clear");
  scripts\engine\utility::flag_init("launch_area_clear_up");
  scripts\engine\utility::flag_init("launch_area_clear_down");
  scripts\engine\utility::flag_init("launch_area_clear_left");
  scripts\engine\utility::flag_init("launch_area_clear_right");
  scripts\engine\utility::flag_init("nextmission_preload_started");
  scripts\engine\utility::flag_init("start_outro_allies");
}

_id_1266D() {
  scripts\sp\utility::_id_241F();
  thread scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_589B("player_jackal", 1);
  scripts\sp\maps\moonjackal\moonjackal_util::sunsettings_dogfight();
  thread scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_A12E();
  scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_F8B3();
  level._id_1D0A = spawnStruct();
  level._id_1D0A thread scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_B2E3("ally_arena_jackals", 2, 0, 1);
  var_0 = getvehiclenode("ambient_carrier_endpos", "script_noteworthy");
  level._id_3666 vehicle_teleport(var_0.origin, var_0.angles);
  level._id_3666 vehicle_setspeedimmediate(0, 500, 500);
  var_0 = getvehiclenode("ambient_dest1_endpos", "script_noteworthy");
  level._id_3667 vehicle_teleport(var_0.origin, var_0.angles);
  level._id_3667 vehicle_setspeedimmediate(0, 500, 500);
  var_0 = getvehiclenode("ambient_dest2_endpos", "script_noteworthy");
  level._id_3668 vehicle_teleport(var_0.origin, var_0.angles);
  level._id_3668 vehicle_setspeedimmediate(0, 500, 500);
  var_0 = getvehiclenode("ambient_dest3_endpos", "script_noteworthy");
  level._id_3669 vehicle_teleport(var_0.origin, var_0.angles);
  level._id_3669 vehicle_setspeedimmediate(0, 500, 500);
  var_0 = getvehiclenode("ambient_tigris_endpos", "script_noteworthy");
  level._id_118A8 vehicle_teleport(var_0.origin, var_0.angles);
  level._id_118A8 vehicle_setspeedimmediate(0, 500, 500);
}

_id_12664() {
  scripts\sp\utility::_id_13705();

  if(!scripts\engine\utility::is_true(level._id_12665))
    thread _id_BB4C();

  wait 0.2;
  thread _id_1265D();
  thread _id_12663();
  thread _id_12667();
  thread _id_1265C();

  while(!(scripts\engine\utility::flag("launch_area_clear") && level.player useButtonPressed()) && !scripts\engine\utility::is_true(level._id_12658))
    scripts\engine\utility::waitframe();

  scripts\engine\utility::flag_set("started_transition");
  thread moonjack_music_end();
  wait 0.1;
  _id_0BDC::_id_A158(1);
  _id_0BDC::_id_A15A(1);
  objective_state(scripts\sp\utility::_id_C264("OBJ_TIGRIS"), "done");
  level._id_D299 = _id_D2A6("player_sled_trans", undefined, 0);
  level._id_D2A1 = _id_D2A6("player_sled_launch", 1, 0);
  thread _id_12666();
  scripts\engine\utility::flag_wait("did_transition_boost");
  wait 2.0;
  scripts\engine\utility::flag_set("boost_final_dialog");
  wait 6.0;
  _id_0BDC::_id_A38E(0, undefined, undefined, 3);
  wait 2.0;
  _id_0BDC::_id_A226(1);
  wait 1.0;

  if(!scripts\engine\utility::is_true(level._id_12665))
    scripts\sp\utility::_id_BF95();
}

moonjack_music_end() {
  setmusicstate("");
  wait 1;
  setmusicstate("mx_moonjackal_exfil");
}

_id_1265D() {
  if(scripts\engine\utility::is_true(level._id_12658)) {
    return;
  }
  scripts\sp\utility::_id_10350("moon_eth_theairbaseissec");
  scripts\sp\utility::_id_1034D("mn_jck_plr_copythatallscarsrally");
  setmusicstate("");
  wait 0.5;
  scripts\engine\utility::flag_set("show_rally_point");
  scripts\sp\utility::_id_10350("mn_jck_slt_copymovingtothelz");
  scripts\sp\utility::_id_10350("mn_jck_slt_sirwereatthelz");
  thread _id_12674();
  scripts\engine\utility::flag_wait("started_transition");
  wait 2;
  scripts\sp\utility::_id_10350("mn_jck_omr_goodworkmarineslinkup");
  scripts\sp\utility::_id_10350("mn_jck_brk_copythat");
  scripts\sp\utility::_id_10350("mn_jck_ksh_goodluckupthere");
  scripts\engine\utility::flag_wait("boost_final_dialog");
  level.player _meth_82C0("moonjack_to_samoon", 4);
  scripts\sp\utility::_id_10350("mn_jck_fer_engine_damage");
  scripts\sp\utility::_id_1034D("mn_jck_plr_raider_inbound");
  scripts\sp\utility::_id_10350("mn_jck_omr_infil_plan");
}

_id_12674() {
  level endon("started_transition");
  wait 8;
  var_0 = ["mn_jck_un2_rendezvousatthelz", "mn_jck_un2_rendezvousatthelz", "mn_jck_slt_sirwereatthelz", "mn_jck_slt_tigrisneedsourhelpmove"];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    wait(randomintrange(5, 8) + var_1 * 3);

    if(scripts\engine\utility::flag("started_transition")) {
      return;
    }
    scripts\sp\utility::_id_10350(var_0[var_1]);
  }
}

_id_BB4C() {
  if(scripts\engine\utility::flag("nextmission_preload_started")) {
    return;
  }
  wait 0.1;
  scripts\engine\utility::flag_set("nextmission_preload_started");
  thread scripts\sp\utility::_id_BF97();
}

_id_12663() {
  var_0 = scripts\engine\utility::getStructArray("launch_zone_marker", "targetname");
  var_1 = getEnt("launch_zone", "targetname");

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_2 = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  objective_add(scripts\sp\utility::_id_C264("OBJ_TIGRIS"), "current");
  objective_setpointertextoverride(scripts\sp\utility::_id_C264("OBJ_TIGRIS"), &"MOONJACKAL_LAUNCH_LZ");
  var_3 = undefined;

  for(;;) {
    if(level._id_D127 istouching(var_1) && !scripts\engine\utility::flag("launch_area_clear"))
      scripts\engine\utility::flag_set("launch_area_clear");
    else if(!level._id_D127 istouching(var_1) && scripts\engine\utility::flag("launch_area_clear"))
      scripts\engine\utility::flag_clear("launch_area_clear");

    var_0 = sortbydistance(var_0, level._id_D127.origin);

    if(!isDefined(var_3) || var_0[0] != var_3) {
      var_3 = var_0[0];
      var_2.origin = var_3.origin;
      objective_onentity(scripts\sp\utility::_id_C264("OBJ_TIGRIS"), var_2);
    }

    wait 0.2;
  }
}

_id_12667() {
  if(scripts\engine\utility::is_true(level._id_12658)) {
    return;
  }
  wait 1.0;
  scripts\engine\utility::flag_wait("show_rally_point");
  var_0 = 0;
  scripts\sp\utility::_id_56BA("move_clear");

  while(!scripts\engine\utility::flag("started_transition")) {
    if(scripts\engine\utility::flag("launch_area_clear") && !var_0) {
      var_0 = 1;
      scripts\sp\utility::_id_56BA("start_transition");
    } else if(!scripts\engine\utility::flag("launch_area_clear") && var_0) {
      var_0 = 0;
      scripts\sp\utility::_id_56BA("move_clear");
    }

    wait 0.1;
  }
}

_id_12662() {
  level endon("started_transition");
  var_0 = [];
  var_0[0] = [0, 9400, 2668];
  var_0[1] = [0, 18600, 5070];
  var_0[2] = [0, 26000, 7850];
  var_0[3] = [0, 31600, 10570];
  var_0[4] = [0, 37500, 14050];
  var_0[5] = [0, 44000, 18685];
  var_0[6] = [0, 49400, 22660];
  var_1 = 200;
  var_2 = -200;
  var_3 = 500;
  var_4 = -500;
  thread _id_57D0(var_0, "launch_area_clear_right", var_4, 0);
  thread _id_57D0(var_0, "launch_area_clear_left", var_3, 0);
  thread _id_57D0(var_0, "launch_area_clear_up", 0, var_1);
  thread _id_57D0(var_0, "launch_area_clear_down", 0, var_2);
  thread _id_579E();

  for(;;) {
    if(scripts\engine\utility::flag("launch_area_clear_up") && scripts\engine\utility::flag("launch_area_clear_down") && scripts\engine\utility::flag("launch_area_clear_left") && scripts\engine\utility::flag("launch_area_clear_right") && !scripts\engine\utility::flag("player_moving"))
      scripts\engine\utility::flag_set("launch_area_clear");
    else
      scripts\engine\utility::flag_clear("launch_area_clear");

    wait 0.15;
  }
}

_id_57D0(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::getStruct("sdf_fleet_location", "targetname");

  for(;;) {
    var_5 = level._id_D127.origin;
    var_6 = var_4.origin - level._id_D127.origin;
    var_6 = vectorNormalize(var_6);
    var_6 = scripts\sp\math::_id_13198(var_6, (0, 0, 1));
    var_7 = vectortoangles(var_6);
    var_8 = anglesToForward(var_7);
    var_9 = anglestoup(var_7);
    var_10 = anglestoright(var_7);
    var_11 = 1;

    foreach(var_13 in var_0) {
      var_14 = level._id_D127.origin + var_10 * (var_13[0] + var_2) + var_8 * var_13[1] + var_9 * (var_13[2] + var_3);
      var_15 = bullettracepassed(var_5, var_14, 0, level._id_D127);

      if(!var_15)
        var_11 = 0;
      else {}

      var_5 = var_14;
    }

    var_15 = bullettracepassed(level._id_D127.origin, level._id_D127.origin + (0, 0, 20000), 0, level._id_D127);

    if(!var_15)
      var_11 = 0;

    if(var_11)
      scripts\engine\utility::flag_set(var_1);
    else
      scripts\engine\utility::flag_clear(var_1);

    wait 0.2;
  }
}

_id_579E() {
  level endon("started_transition");

  for(;;) {
    if(_id_0BDC::_id_7B9E() > 50)
      scripts\engine\utility::flag_set("player_moving");
    else
      scripts\engine\utility::flag_clear("player_moving");

    wait 0.1;
  }
}

_id_12666() {
  var_0 = "moon_launch";
  var_1 = "moon_launch_boost";
  _id_0BDC::_id_A14C(1);
  _id_0BDC::_id_A1DD("hover");
  var_2 = scripts\engine\utility::getStruct("sdf_fleet_location", "targetname");
  var_3 = (0, 90, 0);
  var_4 = (level._id_D127.origin[0], level._id_D127.origin[1], 4300);
  level._id_D299 vehicle_teleport(var_4, var_3);
  level._id_D2A1 vehicle_teleport(var_4, var_3);
  wait 0.05;
  level._id_EAD6._id_1FBB = "salter_jackal";
  level._id_EAD6 _id_0BDC::_id_19A2();
  level._id_EAD6 _id_0BDC::_id_6B4C("hover", 1);
  wait 0.05;
  _id_0BDC::_id_A14A();

  if(!scripts\engine\utility::is_true(level._id_12658)) {
    var_5 = scripts\engine\utility::spawn_tag_origin(var_4 + anglesToForward(level._id_D299.angles) * 50000);
    var_5.angles = level._id_D299.angles;
    var_5 linkTo(level._id_D299);
    var_6 = 3;
    var_7 = 3;
    var_8 = 4300 - level._id_D127.origin[2];

    if(var_8 > 12000)
      var_7 = 6;
    else if(var_8 > 6000)
      var_7 = 4;

    thread _id_0BDC::_id_D165(var_5, 1.0, 0, var_6);
    thread _id_0BDC::_id_D16C(var_4, 1.0, var_7, 0);
    wait(var_7);
    thread _id_0BDC::_id_D16C(var_4, 0.0, 0, 0);
  } else
    wait 0.1;

  var_2 thread _id_1BE0();
  thread _id_12657();
  scripts\engine\utility::flag_set("start_outro_allies");
  level._id_D299 vehicle_teleport(level._id_D127.origin, var_3);
  level._id_D2A1 vehicle_teleport(level._id_D127.origin, var_3);
  wait 0.05;
  level._id_D299 thread scripts\sp\anim::_id_1F35(level._id_D299, var_0);
  level._id_D299 thread scripts\sp\anim::_id_1F35(level._id_D2A1, var_0);
  level._id_D299 thread scripts\sp\anim::_id_1EC3(level._id_EAD6, var_0);
  level._id_D299 thread scripts\sp\anim::_id_1F35(level._id_EAD6, var_0);
  _id_0BDC::_id_A14A(1);
  _id_0BDC::_id_A160(1);
  earthquake(0.22, 1.1, level._id_D127.origin, 5000);
  setomnvar("ui_jackal_autopilot", 1);
  _id_0BDC::_id_D164(level._id_D2A1._id_BD0D, 4);
  _id_0BDC::_id_A1DD("hover");
  thread _id_D2D8();
  level._id_D127 thread _id_0BDB::_id_11479();
  _id_0BDB::_id_1147B(8.5);
  level._id_D299 thread scripts\sp\anim::_id_1F35(level._id_D299, var_1);
  var_9 = 10;

  if(scripts\engine\utility::is_true(level._id_12658))
    var_9 = 0;

  thread _id_0BDB::_id_CFE0(var_9);

  if(!scripts\engine\utility::is_true(level._id_12658))
    level._id_D127 waittill("notify_player_launch");

  scripts\engine\utility::flag_set("did_transition_boost");
  _id_0BDC::_id_A38E(16, 0.7, 0.7, 1.5);
  thread _id_D27B();
  _id_0BDC::_id_A14C(0);
  _id_0BDC::_id_A14A(0);
  _id_0BDC::_id_A0BE(1);
  _id_0BDC::_id_A1DD("fly");
  level._id_D2A1 thread scripts\sp\anim::_id_1F35(level._id_D2A1, var_1);
  thread _id_5573();
  var_10 = 13;
  visionsetnaked("moonjackal_launch", var_10);
  lerpsunangles(level._id_111D0._id_1120D, (-32, 138, 0), var_10, var_10);
  thread scripts\sp\maps\moonjackal\moonjackal_util::_id_AB9F(var_10 * 0.6, 6.5);
  setsaveddvar("spaceshipForceSetFovBlendStrength", 2);
  setsaveddvar("spaceshipForceSetFov", 65);
}

_id_1BE0() {
  var_0 = (0, 135158, 80608);
  var_1 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_2 = var_1.origin;
  level._id_3666 linkTo(var_1);
  level._id_3667 linkTo(var_1);
  level._id_3668 linkTo(var_1);
  level._id_3669 linkTo(var_1);
  level._id_118A8 linkTo(var_1);
  var_3 = level._id_D299.origin + var_0;
  var_1 moveTo(var_3, 0.1);
  wait 0.15;
  level._id_3666 unlink();
  level._id_3667 unlink();
  level._id_3668 unlink();
  level._id_3669 unlink();
  level._id_118A8 unlink();
  level._id_3666 vehicle_teleport(level._id_3666.origin, level._id_3666.angles);
  level._id_3667 vehicle_teleport(level._id_3667.origin, level._id_3667.angles);
  level._id_3668 vehicle_teleport(level._id_3668.origin, level._id_3668.angles);
  level._id_3669 vehicle_teleport(level._id_3669.origin, level._id_3669.angles);
  level._id_118A8 vehicle_teleport(level._id_118A8.origin, level._id_118A8.angles);
}

_id_5573() {
  wait 12;
  level.player thread _id_0BD9::_id_D176(0.0, 0, 9, 0.0, 0.0);
}

#using_animtree("jackal");

_id_D2D8() {
  thread _id_0BDC::_id_A2B0(%jackal_pilot_launch_button, %jackal_vehicle_launch_button, 1.1, 0.5);
  wait 2.1;
  earthquake(0.25, 0.75, level._id_D127.origin, 5000);
  level.player playRumbleOnEntity("damage_light");
  thread _id_104EB();
  level._id_D127 notify("notify_player_can_launch");
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
  setomnvar("ui_jackal_launch_gforce", 0.0);
  level._id_D127 waittill("notify_player_launch");
  level.player playSound("scn_moonjack_launch_plr");
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 2, 2);
  wait 2;
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 9.5, 65);
  level waittill("flag_player_boosters_disengaged");
  thread scripts\sp\utility::_id_AB89("ui_jackal_launch_gforce", 0, 15);
}

_id_104F1() {
  setomnvar("ui_jackal_launch_speed", 0);
  level._id_D127 waittill("notify_player_launch");
  scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 235, 2);
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 500, 2);
  wait 2;
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 40500, 65);
  level waittill("flag_player_boosters_disengaged");
  thread scripts\sp\utility::_id_AB8B("ui_jackal_launch_speed", 0, 15);
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
  setomnvar("ui_jackal_atmo_launch", 0);
}

_id_104ED() {
  level endon("launch_hud_off");
  setomnvar("ui_jackal_launch_fuel", 100);
  level._id_D127 waittill("notify_player_launch");
  var_0 = level._id_D2A1 islegacyagent(level._id_EC85["sled_jackal"]["moon_launch_boost"]);
  var_1 = 0.7;

  for(;;) {
    var_2 = level._id_D2A1 islegacyagent(level._id_EC85["sled_jackal"]["moon_launch_boost"]);
    var_3 = 1 - scripts\sp\math::_id_C097(var_0, var_1, var_2);
    var_4 = scripts\sp\math::_id_6A8E(0, 100, var_3);
    var_4 = scripts\sp\utility::_id_E753(var_4, 2);
    setomnvar("ui_jackal_launch_fuel", var_4);
    wait 0.05;
  }
}

_id_1379D(var_0, var_1) {
  var_2 = getanimlength(level._id_EC85["sled_jackal"]["moon_launch_boost"]);
  var_3 = level._id_D2A1 islegacyagent(level._id_EC85["sled_jackal"]["moon_launch_boost"]);
  var_3 = var_3 * var_2;
  var_4 = getnotetracktimes(level._id_EC85["sled_jackal"]["moon_launch_boost"], var_0);
  var_4 = var_4[0] * var_2;
  var_5 = var_4 - var_3 + var_1;
  wait(var_5);
}

_id_12656() {
  if(!isDefined(level._id_1D0A) || !isDefined(level._id_1D0A._id_FE2D)) {
    return;
  }
  level._id_1D0A._id_FE2D = scripts\engine\utility::array_add(level._id_1D0A._id_FE2D, level._id_DE1C);
  level._id_1D0A._id_FE2D = scripts\engine\utility::array_add(level._id_1D0A._id_FE2D, level._id_DE1F);
  var_0 = [];
  var_0[0] = [1.0, (-1800, -3500, 800), (2500, 1800, 800), (1, 0, 0)];
  var_0[1] = [0.1, (-1000, -2500, -500), (1800, 750, -200), (0, 1, 0)];
  var_0[2] = [0.8, (1500, -3000, -800), (4500, -1500, -500), (0, 0, 1)];
  var_0[3] = [1.3, (1500, -3100, 1200), (3000, -1500, 1200), (1, 1, 0)];
  var_1 = scripts\engine\utility::getStruct("sdf_fleet_location", "targetname");

  while(_id_0B76::_id_7A60(var_1.origin - (0, 0, 85000)) < 0.9)
    wait 0.05;

  foreach(var_4, var_3 in level._id_1D0A._id_FE2D)
  var_3 thread _id_C7B6(var_0[var_4][0], var_0[var_4][1], var_0[var_4][2], var_0[var_4][3]);
}

_id_C7B6(var_0, var_1, var_2, var_3) {
  _id_0BDC::_id_19AB(50);
  wait(var_0);
  var_4 = anglestoright(level._id_D127.angles);
  var_5 = anglesToForward(level._id_D127.angles);
  var_6 = anglestoup(level._id_D127.angles);
  var_7 = level._id_D127.origin + var_1 * var_5 + var_1 * var_4 + var_1 * var_6;
  _id_0BDC::_id_19AB(0);
  self vehicle_teleport(var_7, level._id_D127.angles);
  _id_0BDC::_id_1990(0);
  self _meth_83A1();
  _id_0BDC::_id_19B0("fly");
  _id_0BDC::_id_1986();
  _id_0BDC::_id_1994(level._id_D127, var_2, 5000, 0.15, 15000, 0.2);
  scripts\engine\utility::flag_wait("did_transition_boost");
  _id_0BDC::_id_19B7();
}

_id_12657() {
  if(!isDefined(level._id_1D0A) || !isDefined(level._id_1D0A._id_FE2D)) {
    return;
  }
  level._id_1D0A._id_FE2D = scripts\engine\utility::array_add(level._id_1D0A._id_FE2D, level._id_DE1C);
  level._id_1D0A._id_FE2D = scripts\engine\utility::array_add(level._id_1D0A._id_FE2D, level._id_DE1F);

  if(isDefined(level._id_1D0A._id_FE2D[0]))
    level._id_1D0A._id_FE2D[0] thread _id_C7B5(0.4, (-1350, 600, -100));

  if(isDefined(level._id_1D0A._id_FE2D[1]))
    level._id_1D0A._id_FE2D[1] thread _id_C7B5(0.7, (-1050, 200, 500));

  if(isDefined(level._id_1D0A._id_FE2D[2]))
    level._id_1D0A._id_FE2D[2] thread _id_C7B5(0.8, (500, 2000, 1000));

  if(isDefined(level._id_1D0A._id_FE2D[3]))
    level._id_1D0A._id_FE2D[3] thread _id_C7B5(1.1, (-400, 2800, -350));
}

_id_C7B5(var_0, var_1) {
  scripts\engine\utility::flag_wait("start_outro_allies");

  if(isDefined(var_0) && var_0 > 0)
    wait(var_0);

  var_2 = spawn("script_origin", level._id_D299.origin);
  var_2.angles = level._id_D299.angles;
  var_3 = anglesToForward(var_2.angles);
  var_4 = anglestoup(var_2.angles);
  var_5 = anglestoright(var_2.angles);
  var_2.origin = var_2.origin + var_5 * var_1[0] + var_3 * var_1[1] + var_4 * var_1[2];
  wait 0.05;
  self._id_1FBB = "salter_jackal";
  _id_0BDC::_id_19A2();
  _id_0BDC::_id_6B4C("hover", 1);
  var_2 thread scripts\sp\anim::_id_1EC3(self, "moon_launch");
  var_2 thread scripts\sp\anim::_id_1F35(self, "moon_launch");
  scripts\engine\utility::delaycall(8, ::playsound, "scn_moonjack_launch_jackal_npc");
}

_id_D2A6(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, "targetname");
  var_4 = scripts\sp\vehicle::_id_13237(var_3);
  var_4._id_4074 = [];
  var_4._id_1FBB = "sled_jackal";

  if(isDefined(var_1) && var_1) {
    var_4._id_AFEB = scripts\engine\utility::spawn_tag_origin();
    var_4._id_AFEB.origin = var_4.origin + anglesToForward(var_4.angles) * 2500;
    var_4._id_AFEB linkTo(var_4);
    var_4._id_BD0D = scripts\engine\utility::spawn_tag_origin();
    var_4._id_BD0D linkTo(var_4, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_4._id_B025 = scripts\engine\utility::spawn_tag_origin();
    var_4._id_B025 linkTo(var_4._id_AFEB, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_4._id_4074 = scripts\engine\utility::array_add(var_4._id_4074, var_4._id_AFEB);
    var_4._id_4074 = scripts\engine\utility::array_add(var_4._id_4074, var_4._id_BD0D);
    var_4._id_4074 = scripts\engine\utility::array_add(var_4._id_4074, var_4._id_B025);
  }

  var_4 setvehicleteam("allies");
  var_4 notsolid();
  var_4 thread _id_0BDC::_id_D29D();

  if(scripts\engine\utility::is_true(var_2))
    var_4 setModel("veh_mil_air_un_jackal_02");

  return var_4;
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

_id_12659() {
  level._id_12658 = 1;
  _id_1266D();
}

_id_1265B() {
  level._id_12665 = 1;
  _id_1266D();
}

_id_11721() {
  scripts\sp\utility::_id_241F();
  thread scripts\sp\maps\moonjackal\moonjackal_dogfight::_id_589B("player_jackal", 1);
  scripts\sp\maps\moonjackal\moonjackal_util::sunsettings_dogfight();

  while(!level.player buttonPressed("DPAD_DOWN"))
    wait 0.05;

  level._id_D127 notify("script_death");
}

_id_1265C() {
  scripts\engine\utility::flag_wait("started_transition");
  wait 1.0;
  level._id_3666 _id_0BB6::_id_39E1();
  level._id_3667 _id_0BB6::_id_39E1();
  level._id_3668 _id_0BB6::_id_39E1();
  level._id_3669 _id_0BB6::_id_39E1();
  level._id_118A8 _id_0BB6::_id_39E1();
  level._id_3666 _id_0BB6::_id_3967();
  level._id_3667 _id_0BB6::_id_3967();
  level._id_3668 _id_0BB6::_id_3967();
  level._id_3669 _id_0BB6::_id_3967();
  level._id_118A8 _id_0BB6::_id_3967();
  level._id_3666 _id_0BB6::_id_398A(0);
  level._id_3667 _id_0BB6::_id_398A(0);
  level._id_3668 _id_0BB6::_id_398A(0);
  level._id_3669 _id_0BB6::_id_398A(0);
  level._id_118A8 _id_0BB6::_id_398A(0);

  foreach(var_1 in level._id_864B) {
    foreach(var_3 in var_1.turrets) {
      var_3.targets = [];
      var_3._id_4BC7 = undefined;
      var_3 notify("stop_forever");
      var_3 cleartargetentity();
    }
  }

  wait 6.0;
  scripts\engine\utility::flag_wait("did_transition_boost");
  wait 0.8;
  var_6 = -30000;
  var_7 = 15;
  var_8 = scripts\engine\utility::spawn_tag_origin(level._id_3666.origin, level._id_3666.angles);
  wait 0.05;
  level._id_3666 linkTo(var_8);
  level._id_3667 linkTo(var_8);
  level._id_3668 linkTo(var_8);
  level._id_3669 linkTo(var_8);
  level._id_118A8 linkTo(var_8);
  wait 0.05;
  var_8 movez(var_6, var_7, 1, 1);
  wait 2.8;
}