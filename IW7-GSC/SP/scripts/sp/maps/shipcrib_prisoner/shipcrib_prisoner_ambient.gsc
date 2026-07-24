/***************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_prisoner\shipcrib_prisoner_ambient.gsc
***************************************************************************/

_id_1DBF() {
  precachemodel("p7_desk_metal_military_03_tablet");
  precachemodel("crates_plastic_tech_01");
  precachemodel("misc_scrub_brush");
  precachemodel("equipment_wall_mounted_phone_handset_01");
  precachemodel("veh_mil_air_un_jackal_landed_03b");
  scripts\engine\utility::flag_init("c12_elevator_done");
  scripts\engine\utility::flag_wait_all("shipcrib_prisoner_prime_in_tr_loaded");
  level thread _id_E46D();
  level thread _id_1E07();
  level thread _id_1DFF();
  level thread _id_1DFE();
  level thread _id_1E01();
}

_id_1E07() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_returne");

    if(isDefined(level._id_FDBC) && level._id_FDBC == "rogue") {
      level _id_10A6::_id_888A();
      level thread[[level._id_FDA2["elevator_up_func"]]]();
    }

    _id_0EE4::_id_6E5E("ambient_zone_returne");

    if(isDefined(level._id_FDBC) && level._id_FDBC == "rogue") {
      level thread _id_10A6::_id_888B();
    }
  }
}

_id_1DFF() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_bridgef");
    _id_0EF7::_id_ADF6();
    _id_0EF7::_id_ADFA("ml_prisoner");
    _id_0EE4::_id_6E5E("ambient_zone_bridgef");
    _id_0EF7::_id_40C0();
    _id_0EF7::_id_40C1("ml_prisoner");
  }
}

_id_1DFE() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_bridgee");
    level _id_10A6::_id_888A();
    level thread[[level._id_FDA2["elevator_down_func"]]]();
    _id_0EE4::_id_6E5E("ambient_zone_bridgee");
    _id_0EFB::_id_FDBB("bridge_crew");
    level thread _id_0EDE::_id_C650();
    level thread _id_10A6::_id_888B();
  }
}

_id_1E01() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_gravity");
    _id_0EE4::_id_6E5E("ambient_zone_gravity");
  }
}

_id_1E04() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_bridgef");
    _id_0EE4::_id_6E5E("ambient_zone_bridgef");
  }
}

_id_1E0B() {
  if(!scripts\engine\utility::flag("shipcrib_prisoner_ambientmr_tr_loaded")) {
    scripts\sp\utility::_id_12641("shipcrib_prisoner_ambientmr_tr");
  }
}

_id_1E0A() {
  if(!scripts\engine\utility::flag("shipcrib_prisoner_ambientml_tr_loaded")) {
    scripts\sp\utility::_id_12641("shipcrib_prisoner_ambientml_tr");
  }
}

_id_1E0E() {
  if(!scripts\engine\utility::flag("shipcrib_prisoner_ambientml_tr_loaded")) {
    scripts\sp\utility::_id_12641("shipcrib_prisoner_ambientml_tr");
  }
}

_id_1E0D() {
  if(!scripts\engine\utility::flag("shipcrib_prisoner_ambientml_tr_loaded")) {
    scripts\sp\utility::_id_12641("shipcrib_prisoner_ambientml_tr");
  }
}

_id_E46D() {
  scripts\engine\utility::flag_wait("ambient_return_elevator_2f");
  level thread scripts\sp\utility::_id_12651(["shipcrib_prisoner_jackale_tr", "shipcrib_prisoner_ambientmr_tr", "shipcrib_prisoner_hangar_tr", "shipcrib_prisoner_dropship_tr", "shipcrib_prisoner_mezz_tr"]);
  level thread scripts\sp\utility::_id_12643(["shipcrib_prisoner_bridge_tr", "shipcrib_prisoner_bridgem_tr", "shipcrib_prisoner_bridgee_tr", "shipcrib_prisoner_exterior_tr"]);
}

#using_animtree("jackal");

_id_8AB5() {
  scripts\engine\utility::flag_wait("shipcrib_prisoner_prime_tr_loaded");
  _id_0EE4::_id_984E();
  level._id_E35D._id_AA5F["dropship_bay_1"]._id_5979.origin = level._id_E35D._id_AA5F["dropship_bay_1"]._id_5979._id_4291;
  level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979.origin = level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979._id_4291;
  level thread _id_0EE4::_id_DC44("jackal_bridge_01", 1);
  level thread _id_0EE4::_id_DC44("jackal_bridge_02", 1);
  var_0 = getEntArray("leave_forklift_a_cargo", "targetname");
  var_1 = getEnt("leave_towcart_a_cargo", "targetname");
  var_2 = scripts\engine\utility::array_combine(var_0, [var_1]);
  var_3 = getEnt("prisoner_leave_deck_crate1", "targetname");
  var_3._id_4348 = getEnt("prisoner_leave_deck_crate1_col", "targetname");
  var_4 = getEnt("prisoner_leave_deck_crate2", "targetname");
  var_4._id_4348 = getEnt("prisoner_leave_deck_crate2_col", "targetname");
  var_3 hide();
  var_3._id_4348 hide();
  var_4 hide();
  var_4._id_4348 hide();

  foreach(var_6 in var_2) {
    var_6 hide();
  }

  level thread _id_0EF9::_id_FE03("jackal_cheap", "jackal_bay_1");
  level thread _id_0EF9::_id_FE03("jackal_cheap", "jackal_bay_3");
  level thread _id_10A3::_id_3B9D(0, 0, 1, 1, 1, 0, 1, 0, 0, 0);
  level thread _id_10A2::_id_1A5D();
  var_8 = ["spawner_flightdeck", "spawner_flightdeck_maintenance", "spawner_flightdeck_fuel"];
  var_9 = level._id_FD6E.jackals["jackal_bay_1"];
  var_10 = _id_0EF8::_id_FE01(var_8[randomint(var_8.size)], "jackal_service_normal_spawnloc", "cheap");
  var_11 = _id_0EF8::_id_FE01(var_8[randomint(var_8.size)], "jackal_service_normal_spawnloc", "cheap");
  var_12 = _id_0EF8::_id_FE01(var_8[randomint(var_8.size)], "jackal_service_normal_spawnloc", "cheap");
  level thread _id_10A9::_id_A314(var_9, undefined, undefined, undefined, undefined, var_10, var_11, undefined, var_12);
  var_9 _meth_82A2(%shipcrib_veh_jackal_lean_hatch_right_open_hold, 1, 0, 1);
  var_9 _meth_82A2(%shipcrib_veh_jackal_lean_hatch_center_open_hold, 1, 0, 1);
  level thread _id_E426();
  level thread _id_E417();
  level thread _id_E457("pushups_mr");
  level thread _id_E456();
  level thread _id_E44F();
  level thread _id_E450();
  level thread _id_E452();
  level thread _id_E453();
  level thread _id_E454();
  level thread _id_8ABD();
  level thread _id_B0A4();
}

_id_E458() {
  var_0 = getEnt("return_deck_towcart", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_handler", var_0, "cheap");
  var_1 _id_0EFB::_id_FD6F("returndeck_misc_flightcrew");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_veh_TOW_rear_idle", "stop_loop", "tag_detach");
  var_2 = scripts\engine\utility::getStruct("return_deck_towcart_convo_1", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_shooter", var_2.targetname, "cheap");
  var_1 _id_0EFB::_id_FD6F("returndeck_misc_flightcrew");
  var_2 thread scripts\sp\anim::_id_1ECC(var_1, var_2.animation);
  var_2 = scripts\engine\utility::getStruct("return_deck_towcart_convo_2", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_fuel", var_2.targetname, "cheap");
  var_1 _id_0EFB::_id_FD6F("returndeck_misc_flightcrew");
  var_2 thread scripts\sp\anim::_id_1ECC(var_1, var_2.animation);
}

_id_E452() {
  level endon("kill_return_deck_ambient");
  var_0 = _id_0EF9::_id_FE03("forklift", "return_forklift_a");
  wait 0.1;
  var_0 thread _id_0EED::_id_7309("return_forklift_a_cargo");
  var_0 _id_0EED::_id_730A("return_forklift_a");
  wait 0.5;
  var_0 _id_0EED::_id_7315();
  var_0 _id_0EED::_id_730A("return_forklift_a_deep_backup");
  var_0 _id_0EED::_id_730A("return_forklift_a_return");
  wait 2;
  _id_0EEB::_id_60F0("jackal", 20);
  _id_0EEB::_id_60FD("jackal", "Storage");
  _id_0EEB::_id_7976("jackal") waittill("move_finished");
  var_0 _id_0EED::_id_730A("return_forklift_a_storage");
  _id_0EFB::_id_FDBA(var_0._id_5BC8);
  var_0 delete();
}

_id_E453() {
  level endon("kill_return_deck_ambient");
  var_0 = _id_0EF9::_id_FE03("forklift", "return_forklift_b");
  wait 0.1;
  var_0 thread _id_0EED::_id_7305("lowered");
  var_0 _id_0EED::_id_730A("return_forklift_b");
  wait 2;
  _id_0EEB::_id_60F0("apc", 20);
  _id_0EEB::_id_60FD("apc", "Storage");
  _id_0EEB::_id_7976("apc") waittill("move_finished");
  _id_0EFB::_id_FDBA(var_0._id_5BC8);
  var_0 delete();
}

_id_E454() {
  level endon("kill_return_deck_ambient");
  var_0 = _id_0EF9::_id_FE03("forklift", "return_forklift_c");
  wait 0.1;
  var_0 thread _id_0EED::_id_7305("lowered");
  var_0 _id_0EED::_id_730A("return_forklift_c");
  _id_0EEB::_id_7976("apc") waittill("move_finished");
  _id_0EFB::_id_FDBA(var_0._id_5BC8);
  var_0 delete();
}

_id_E450() {
  level endon("kill_return_deck_ambient");
  var_0 = scripts\engine\utility::getStruct("return_deck_crate_mover_1", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "return_deck_crate_mover_1", "cheap");
  var_1 _id_0EFB::_id_FD6F("returndeck_misc_flightcrew");
  var_1._id_1FBB = "crate_mover_a";
  var_1._id_1EF1 = scripts\sp\utility::_id_10639("tech_crate_a");
  var_2 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "return_deck_crate_mover_1", "cheap");
  var_2 _id_0EFB::_id_FD6F("returndeck_misc_flightcrew");
  var_2._id_1FBB = "crate_mover_b";
  var_2._id_1EF1 = scripts\sp\utility::_id_10639("tech_crate_b");
  var_3 = [var_1, var_2, var_1._id_1EF1, var_2._id_1EF1];
  var_0 thread scripts\sp\anim::_id_1EE7(var_3, "crate_move_1_pre_idle");
  var_4 = scripts\engine\utility::getStruct("return_deck_crate_mover_2", "targetname");
  var_5 = _id_0EF8::_id_FE01("spawner_flightdeck_handler", "return_deck_crate_mover_2", "cheap");
  var_5 _id_0EFB::_id_FD6F("returndeck_misc_flightcrew");
  var_5._id_1FBB = "crate_mover_a";
  var_5._id_1EF1 = scripts\sp\utility::_id_10639("tech_crate_a");
  var_6 = _id_0EF8::_id_FE01("spawner_flightdeck", "return_deck_crate_mover_2", "cheap");
  var_6 _id_0EFB::_id_FD6F("returndeck_misc_flightcrew");
  var_6._id_1FBB = "crate_mover_b";
  var_6._id_1EF1 = scripts\sp\utility::_id_10639("tech_crate_b");
  var_7 = [var_5, var_6, var_5._id_1EF1, var_6._id_1EF1];
  var_4 thread scripts\sp\anim::_id_1EE7(var_7, "crate_move_2_pre_idle");
  level thread _id_E451(var_3, 1, var_0, "forklift_c_clear");
  level thread _id_E451(var_7, 2, var_4, "jackal_taxi_clear");
}

_id_E451(var_0, var_1, var_2, var_3) {
  var_0[0] endon("death");
  scripts\engine\utility::flag_wait(var_3);
  var_2 notify("stop_loop");
  var_2 scripts\sp\anim::_id_1F2C(var_0, "crate_move_" + var_1 + "_walk");
  var_2 scripts\sp\anim::_id_1EE7(var_0, "crate_move_" + var_1 + "_post_idle");
}

_id_E457(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_4 = _id_0EF8::_id_FE01("spawner_marine", var_3, "cheap");
    var_3 thread scripts\sp\anim::_id_1ECC(var_4, var_3.animation, "stop_loop");
    var_4 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_4 scripts\sp\utility::_id_7DC1(var_3.animation)[0], randomfloatrange(0, 1));
  }
}

_id_E426() {
  level endon("kill_return_deck_ambient");
  var_0 = 8;
  var_1 = 12;
  level._id_E35D._id_A2E8["a"].origin = level._id_E35D._id_A2E8["a"]._id_62EB + (0, 0, -128);
  level._id_E35D._id_A2E8["b"].origin = level._id_E35D._id_A2E8["b"]._id_62EB + (0, 0, -128);
  scripts\engine\utility::flag_wait("landing_walk_and_talk_start");
  level._id_E35D._id_A2E9 thread _id_0EE1::_id_E3D4(var_0);
  level._id_E35D._id_A2E9 moveTo(level._id_E35D._id_A2E9.origin + anglestoright(level._id_E35D._id_A2E9.angles) * 816, var_0);
  wait(var_0 + 2);
  level._id_E35D._id_A2E8["a"] playSound("scn_ship_titan_jackal_lower_start");
  level._id_E35D._id_A2E8["a"] playLoopSound("scn_ship_titan_jackal_lower_lp");
  level._id_E35D._id_A2E8["a"] moveTo(level._id_E35D._id_A2E8["a"]._id_1AE0, var_1, 1, 1);
  level._id_E35D._id_A2E8["a"] scripts\engine\utility::delaycall(var_1, ::stoploopsound);
  level._id_E35D._id_A2E8["a"] scripts\engine\utility::delaycall(var_1, ::playsound, "scn_ship_titan_jackal_lower_stop");
  wait 0.5;
  level._id_E35D._id_A2E8["b"] playSound("scn_ship_titan_jackal_lower_start");
  level._id_E35D._id_A2E8["b"] playLoopSound("scn_ship_titan_jackal_lower_lp");
  level._id_E35D._id_A2E8["b"] moveTo(level._id_E35D._id_A2E8["b"]._id_1AE0, var_1, 1, 1);
  level._id_E35D._id_A2E8["b"] scripts\engine\utility::delaycall(var_1, ::stoploopsound);
  level._id_E35D._id_A2E8["b"] scripts\engine\utility::delaycall(var_1, ::playsound, "scn_ship_titan_jackal_lower_stop");
  wait(var_1 + 1);
  level._id_E35D._id_A2E9 thread _id_0EE1::_id_E3D4(var_0);
  level._id_E35D._id_A2E9 moveTo(level._id_E35D._id_A2E9.origin + anglestoright(level._id_E35D._id_A2E9.angles) * -816, var_0);
}

_id_E417() {
  var_0 = scripts\engine\utility::getStruct("catwalk_tall_climb_ladder", "targetname");
  var_1 = ["shipcrib_return_deck_catwalk_loop_01", "shipcrib_return_deck_catwalk_loop_03"];
  var_2 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "catwalk_tall_climb_ladder", "cheap");
  var_2 _id_0EFB::_id_FD6F("returndeck_misc_flightcrew");
  var_0 thread scripts\sp\anim::_id_1ECC(var_2, "shipcrib_return_deck_catwalk_idle01");
  scripts\engine\utility::flag_wait("landing_walk_and_talk_start");
  var_0 notify("stop_loop");
  var_0 scripts\sp\anim::_id_1EC7(var_2, "shipcrib_return_deck_catwalk_ascend");
  var_2 _id_E418(var_0, var_1);
}

#using_animtree("generic_human");

_id_E418(var_0, var_1) {
  self endon("death");

  for(;;) {
    var_2 = scripts\engine\utility::array_randomize(var_1);

    foreach(var_4 in var_2) {
      var_0 thread scripts\sp\anim::_id_1ECC(self, "shipcrib_return_deck_catwalk_idle02");
      wait(getanimlength(%shipcrib_return_deck_catwalk_idle02) * randomintrange(1, 4));
      var_0 notify("stop_loop");
      var_0 scripts\sp\anim::_id_1EC7(self, var_4);
    }
  }
}

#using_animtree("jackal");

_id_E456() {
  level endon("kill_return_deck_ambient");
  level._id_E35D._id_AA5F["jackal_bay_1"]._id_7691 thread _id_0EE4::_id_A25C("max_raised", 0.05);
  level._id_E35D._id_AA5F["jackal_bay_2"]._id_7691 thread _id_0EE4::_id_A25C("max_raised", 0.05);
  level._id_E35D._id_AA5F["jackal_bay_3"]._id_7691 thread _id_0EE4::_id_A25E();
  level _id_8AB7();
  var_0 = getvehiclenode("jackal_b_dock_start", "targetname");
  level._id_FD6E._id_A0C3 vehicle_teleport(var_0.origin, var_0.angles);
  scripts\engine\utility::flag_wait("landing_walk_and_talk_start");
  level._id_FD6E._id_A0C3 vehicle_setspeedimmediate(2.0, 0.1, 0.1);
  level._id_FD6E._id_A0C1 setanimknob(%shipcrib_veh_jackal_lean_wheel_rotate, 11, 0.2, 0.3);
  level._id_FD6E._id_A0C3 scripts\sp\vehicle::_id_2471(var_0);
  level._id_FD6E._id_A0C3 waittill("reached_end_node");
  level._id_FD6E._id_A0C1 clearanim(%shipcrib_veh_jackal_lean_wheel_rotate, 0);
  level._id_E35D._id_AA5F["jackal_bay_2"]._id_7691 thread _id_0EE4::_id_A25C("jackal_load_center", 10);
}

_id_8AB7() {
  level._id_FD6E._id_A0C3 = getEnt("jackal_b_dock_vehicle", "targetname");
  level._id_FD6E._id_A0C1 = spawn("script_model", level._id_FD6E._id_A0C3.origin);
  level._id_FD6E._id_A0C1.angles = level._id_FD6E._id_A0C3.angles;
  level._id_FD6E._id_A0C1 setModel("veh_mil_air_un_jackal_landed_03b");
  level._id_FD6E._id_A0C1 linkTo(level._id_FD6E._id_A0C3);
  level._id_FD6E._id_A0C1 _meth_83D0(#animtree);
  level._id_FD6E._id_A0C1 _meth_82A2(%jackal_vehicle_landed_state_idle);
}

_id_E44F() {
  level._id_E35D._id_47D9.origin = level._id_E35D._id_47D9.start.origin + anglestoright(level._id_E35D._id_47D9.angles) * -836;
  _id_0EDF::_id_E38E("basket_open", 0.05);
  var_0 = scripts\engine\utility::getStruct("return_deck_basket_operator", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_fuel", "return_deck_basket_operator", "cheap");
  var_1 _id_0EFB::_id_FD6F("returndeck_misc_flightcrew");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, var_0.animation);
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "return_deck_c12_inspector_manager");
  var_0 = scripts\engine\utility::getStruct("return_deck_c12_inspector_manager", "targetname");
  var_2 = scripts\sp\utility::_id_10639("tablet", var_0.origin, var_0.angles);
  var_1._id_1EF1 = var_2;
  var_1 _id_0EFB::_id_FD6F("returndeck_misc_flightcrew");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_fod_walk_manager02");
  var_0 thread scripts\sp\anim::_id_1EEA(var_2, "shipcrib_hangar_fod_walk_manager02_tablet");
  level._id_FD6E._id_E416 = [];
  var_3 = scripts\engine\utility::getStructArray("return_deck_c12", "targetname");

  foreach(var_0 in var_3) {
    var_5 = spawn("script_model", var_0.origin);
    var_5 setModel("ally_robot_c12");
    var_5.angles = var_0.angles;
    var_5.name = "";
    level._id_FD6E._id_E416[level._id_FD6E._id_E416.size] = var_5;
  }
}

_id_CACD() {
  self endon("death");

  for(;;) {
    wait 8;
    scripts\sp\utility::_id_10346("shipcrib_crw1_howwelookin");
    wait 6;
    scripts\sp\utility::_id_10346("shipcrib_crw1_hmmyouadjustt");
    wait 8;
    scripts\sp\utility::_id_10346("shipcrib_crw1_lookthatswhere");
    wait 4;
    scripts\sp\utility::_id_10346("shipcrib_crw1_balanceisntoffkilt");
    wait 2;
    scripts\sp\utility::_id_10346("shipcrib_crw1_maybethattheerror");
  }
}

_id_3B9A() {
  self endon("death");

  for(;;) {
    wait 21;
    scripts\sp\utility::_id_10346("shipcrib_crw2_fallinbehindhere");
    wait 4.5;
    scripts\sp\utility::_id_10346("shipcrib_crw2_howmuchlonger");
    wait 1;
    scripts\sp\utility::_id_10346("shipcrib_crw2_onceordysgoodt");
    scripts\sp\utility::_id_10346("shipcrib_crw2_yougot1minute");
    self waittill("looping anim");
  }
}

_id_3B9B() {
  self endon("death");

  for(;;) {
    wait 30;
    scripts\sp\utility::_id_10346("shipcrib_crw1_finishinupnow");
    self waittill("looping anim");
  }
}

_id_8ABD() {
  scripts\engine\utility::flag_wait("ambient_return_elevator_2f");
  level notify("kill_return_deck_ambient");
  level notify("jackal_loading_gantries_stop");
  level._id_FD6E._id_A0C1 unlink();

  foreach(var_1 in level._id_FD6E._id_7316) {
    if(isDefined(var_1._id_3A5D)) {
      foreach(var_3 in var_1._id_3A5D) {
        var_3 unlink();
        var_3 delete();
      }
    }
  }

  _id_0EFB::_id_FDBA(level._id_30F6);
  _id_0EFB::_id_FDBA(level._id_A538);
  _id_0EFB::_id_FDBA(level._id_828C);
  _id_0EFB::_id_FDBB("forklift_driver");
  _id_0EFB::_id_FDBB("medics");
  _id_0EFB::_id_FDBB("civilians");
  _id_0EFB::_id_FDBB("pushups");
  var_6 = _id_0EFB::_id_FD9C("returndeck_misc_flightcrew");

  foreach(var_8 in var_6) {
    if(var_8._id_1FBB == "phone_guy") {
      var_8 detach("equipment_wall_mounted_phone_handset_01", "tag_accessory_right");
    }

    if(var_8._id_1FBB == "inspector") {
      var_8 detach("p7_desk_metal_military_03_tablet", "tag_inhand");
    }

    if(isDefined(var_8._id_1EF1)) {
      var_8._id_1EF1 delete();
    }
  }

  _id_0EFB::_id_FDBB("returndeck_misc_flightcrew");
  level thread _id_10A3::_id_3B9E();
  level thread _id_10A2::_id_1A5E();
  level thread _id_10AA::_id_A315(_id_0EFB::_id_FD9C("jackal_service"));
  _id_0EFB::_id_FD71();
  _id_0EFB::_id_FDE7(level._id_FD6E._id_A0C1);
  _id_0EFB::_id_FDE7(level._id_FD6E._id_A0C3);
  _id_0EFB::_id_FDE8(level._id_FD6E.jackals);
  var_10 = level._id_FD6E._id_5EE3["vehicle_dropship_return"] _id_0BBF::_id_796E();

  foreach(var_12 in var_10) {
    _id_0EFB::_id_FDE7(var_12);
  }

  _id_0EFB::_id_FDE8(level._id_FD6E._id_5EE3);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_7316);
  var_14 = getEnt("return_deck_towcart", "targetname");
  _id_0EFB::_id_FDE7(var_14);

  foreach(var_16 in level._id_FD6E._id_E416) {
    _id_0EFB::_id_FDE7(var_16);
  }

  _id_0EFB::_id_FDE8(level._id_FD6E._id_11A55);
  level thread scripts\sp\utility::_id_12651(["shipcrib_prisoner_hangar_tr", "shipcrib_prisoner_dropship_tr", "shipcrib_prisoner_ambientmr_tr", "shipcrib_prisoner_mezz_tr"]);
  level thread scripts\sp\utility::_id_12643(["shipcrib_prisoner_bridge_tr", "shipcrib_prisoner_bridgee_tr", "shipcrib_prisoner_bridgem_tr", "shipcrib_prisoner_exterior_tr"]);
}

_id_B0A4() {
  scripts\engine\utility::flag_wait("ambient_zone_bridgef");
  _id_0EE4::_id_6E5E("ambient_zone_bridgef");
  _id_0EFB::_id_FDBB("lounge");
}

#using_animtree("vehicles");

_id_5D90() {
  var_0 = level._id_FD6E._id_5EE3["vehicle_dropship_return"];
  var_0 clearanim(%vh_dropship_landing_gear_up, 0);
  var_0 clearanim(%vh_dropship_rear_doors_open, 0);
  var_0 setanimknob(%vh_dropship_rear_doors_close, 1.0, 0);
  var_0 setanimknob(%vh_dropship_landing_gear_down, 1.0, 0);
}

#using_animtree("jackal");

_id_8A8A() {
  _id_0EF9::_id_FE03("dropship_cheap", "vehicle_dropship_return");
  _id_5D90();
  level thread _id_0EEF::_id_15B0(["jackal_bay_4"], "nitrogen");
  _id_0EEB::_id_60FD("jackal", "Flight Deck", 1);
  _id_0EEB::_id_60FD("apc", "Flight Deck", 1);
  level thread _id_0EE4::_id_E399(level._id_E35D._id_AA5F["dropship_bay_1"]._id_5979, 0.05);
  level thread _id_0EE4::_id_E399(level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979, 0.05);
  var_0 = getEntArray("leave_forklift_a_cargo", "targetname");
  var_1 = getEnt("leave_towcart_a_cargo", "targetname");
  var_2 = scripts\engine\utility::array_combine(var_0, [var_1]);

  foreach(var_4 in var_2) {
    var_4 show();
  }

  var_6 = getEntArray("return_forklift_a_cargo", "targetname");

  if(isDefined(var_6)) {
    foreach(var_4 in var_6) {
      var_4 delete();
    }
  }

  level thread _id_0EF9::_id_FE03("jackal_cheap", "jackal_bay_1", undefined, undefined, 1);
  level thread _id_0EF9::_id_FE03("jackal_cheap", "jackal_bay_2", undefined, undefined, 1);
  level thread _id_0EF9::_id_FE03("jackal_cheap", "jackal_bay_3", undefined, undefined, 1);
  level thread _id_10A3::_id_3B9D(1, 1, 1, 0, 1, 0, 0, 0, 0, 0);
  level thread _id_10A2::_id_1A5D(1, 0);
  var_9 = ["spawner_flightdeck", "spawner_flightdeck_maintenance", "spawner_flightdeck_fuel"];
  var_10 = level._id_FD6E.jackals["jackal_bay_1"];
  var_10 _meth_82A2(%shipcrib_veh_jackal_lean_canopy_opened_hold, 1, 0);
  var_11 = _id_0EF8::_id_FE01(var_9[randomintrange(0, 2)], "jackal_service_normal_spawnloc", "cheap");
  var_12 = _id_0EF8::_id_FE01(var_9[randomintrange(0, 2)], "jackal_service_normal_spawnloc", "cheap");
  var_13 = _id_0EF8::_id_FE01(var_9[randomint(var_9.size)], "jackal_service_normal_spawnloc", "cheap");
  var_14 = _id_0EF8::_id_FE01(var_9[randomint(var_9.size)], "jackal_service_normal_spawnloc", "cheap");
  level thread _id_10A9::_id_A314(var_10, var_11, var_12, undefined, undefined, var_13, var_14, undefined, undefined);
  var_10 = level._id_FD6E.jackals["jackal_bay_3"];
  var_10 _meth_82A2(%shipcrib_veh_jackal_lean_canopy_opened_hold, 1, 0);
  var_15 = _id_0EF8::_id_FE01(var_9[randomintrange(0, 2)], "jackal_service_normal_spawnloc", "cheap");
  var_16 = _id_0EF8::_id_FE01(var_9[randomint(var_9.size)], "jackal_service_normal_spawnloc", "cheap");
  level thread _id_10AA::_id_A314(var_10, var_15, undefined, var_16);
  level thread _id_AB1F();
  level thread _id_8A84();
  level thread _id_8A81();
  level thread _id_AB18();
  level thread _id_AB1D();
  level thread _id_AB1C();
  level thread _id_AB15();
  level thread _id_AB1B();
  level thread _id_AB16();
  level thread _id_AB1A();
  level thread _id_AB17();
  level thread _id_8A87();
}

_id_AB18() {
  level endon("kill_leave_deck_ambient");
  var_0 = _id_0EF9::_id_FE03("forklift", "leave_forklift_a");
  var_0 scripts\sp\utility::_id_65E0("start_airboss_section");
  var_0 scripts\engine\utility::delaythread(1, _id_0EED::_id_7309, "leave_forklift_a_cargo");
  var_0 thread _id_AB19();
  level waittill("airboss_door_scene_start");
  var_1 = getvehiclenode("leave_forklift_a_airboss", "targetname");
  var_0 vehicle_teleport(var_1.origin, var_1.angles);
  scripts\engine\utility::waitframe();
  var_0 thread scripts\sp\utility::_id_65E2("start_airboss_section", 8);
  var_0 thread _id_0EED::_id_730B();
  var_0 _id_0EED::_id_730A("leave_forklift_a_airboss");
  wait 0.5;
  var_0 _id_0EED::_id_7315();
  var_2 = 160000;

  for(;;) {
    if(distance2dsquared(level.player.origin, var_0.origin) >= var_2) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  var_0 _id_0EED::_id_730A("leave_forklift_a_deep_backup");
  var_0 _id_0EED::_id_730A("leave_forklift_a_return");
  wait 2;
  scripts\engine\utility::flag_waitopen("player_in_apc_elevator");
  _id_0EEB::_id_60F0("apc", 20);
  _id_0EEB::_id_60FD("apc", "Storage");
  _id_0EEB::_id_7976("apc") waittill("move_finished");
  wait 0.25;
  var_0 _id_0EED::_id_730A("leave_forklift_a_storage");
  _id_0EFB::_id_FDBA(var_0._id_5BC8);
  _id_0EFB::_id_FDE7(var_0);
  var_3 = getEntArray("leave_forklift_a_cargo", "targetname");

  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      var_5 unlink();
      var_5 delete();
    }
  }
}

_id_AB19() {
  level endon("airboss_door_scene_start");
  self endon("entitydeleted");
  wait 5;
  _id_0EED::_id_730A("leave_forklift_a");
}

_id_AB1D() {
  level endon("kill_leave_deck_ambient");
  wait 0.2;
  var_0 = _id_0EF9::_id_FE03("towcart", "leave_towcart_a");
  var_0 scripts\sp\utility::_id_65E0("start_airboss_section");
  var_0 thread _id_AB1E();
  level waittill("airboss_door_scene_start");
  var_1 = getvehiclenode("leave_towcart_a_airboss", "targetname");
  var_0 vehicle_teleport(var_1.origin, var_1.angles);
  scripts\engine\utility::waitframe();
  var_0 thread scripts\engine\utility::delaythread(1, _id_0EFA::_id_11A4D, "leave_towcart_a_cargo");
  var_0 thread scripts\sp\utility::_id_65E2("start_airboss_section", 24);
  var_0 thread _id_0EFA::_id_11A4F();
  var_0 _id_0EFA::_id_11A4E("leave_towcart_a_airboss");
  _id_0EEB::_id_7976("apc") waittill("move_finished");
  wait 0.75;
  var_0 _id_0EFA::_id_11A4E("leave_towcart_a_storage");

  foreach(var_3 in var_0._id_3A5D) {
    var_3 unlink();
    var_3 delete();
  }

  _id_0EFB::_id_FDBA(var_0._id_5BC8);
  _id_0EFB::_id_FDE7(var_0);
}

_id_AB1E() {
  level endon("airboss_door_scene_start");
  self endon("entitydeleted");
  wait 2;
  _id_0EFA::_id_11A4E("leave_towcart_a");
}

_id_AB1F() {
  level._id_E35D._id_AA5F["jackal_bay_1"]._id_7691 thread _id_0EE4::_id_A25C("max_raised", 0.05);
  level._id_E35D._id_AA5F["jackal_bay_2"]._id_7691 thread _id_0EE4::_id_A25E();
  level._id_E35D._id_AA5F["jackal_bay_3"]._id_7691 thread _id_0EE4::_id_A25C("max_raised", 0.05);
  level._id_E35D._id_AA5F["jackal_bay_4"]._id_7691 thread _id_0EE4::_id_A25C("max_lowered", 0.05);
}

_id_8A84() {
  level endon("kill_leave_deck_ambient");
  level thread _id_8A85();
  var_0 = getEnt("prisoner_leave_deck_crate1", "targetname");
  var_0._id_4348 = getEnt("prisoner_leave_deck_crate1_col", "targetname");
  var_0 hide();
  var_0._id_4348 hide();
  var_0 scripts\sp\utility::_id_23B7("tech_crate_a");
  var_1 = getEnt("prisoner_leave_deck_crate2", "targetname");
  var_1._id_4348 = getEnt("prisoner_leave_deck_crate2_col", "targetname");
  var_1 hide();
  var_1._id_4348 hide();
  var_1 scripts\sp\utility::_id_23B7("tech_crate_b");
  level waittill("airboss_door_scene_start");
  var_2 = level._id_FD6E._id_5EE3["dropship_bay_1"];
  var_2 vehicle_setspeed(0, 1, 1);
  var_3 = _id_0EFB::_id_7CBC("dropship_bay_1", "script_noteworthy", "dropship_pos1");
  var_2 vehicle_teleport(var_3.origin, var_3.angles);
  var_2 thread _id_0BBC::_id_C5F1(["back"]);
  var_2 thread scripts\sp\utility::play_sound_on_tag("scn_ship_launch_bkdoor_open", "j_lowerbackdoor1");
  var_4 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", var_2);
  var_4._id_1FBB = "crate_mover_a";
  var_5 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", var_2);
  var_5._id_1FBB = "crate_mover_b";
  var_4._id_1EF2 = var_0;
  var_4._id_1EF2._id_4348 = var_0._id_4348;
  var_4._id_1EF2._id_1FBB = "tech_crate_a";
  var_4._id_1EF2 show();
  var_4._id_1EF2._id_4348 show();
  var_4._id_1EF2._id_4348 linkTo(var_4._id_1EF2);
  var_5._id_1EF2 = var_1;
  var_5._id_1EF2._id_4348 = var_1._id_4348;
  var_5._id_1EF2._id_1FBB = "tech_crate_b";
  var_5._id_1EF2 show();
  var_5._id_1EF2._id_4348 show();
  var_5._id_1EF2._id_4348 linkTo(var_5._id_1EF2);
  var_4 _id_0EFB::_id_FD6F("leave_deck_misc");
  var_5 _id_0EFB::_id_FD6F("leave_deck_misc");
  var_2 thread scripts\sp\anim::_id_1EE7([var_4, var_5, var_4._id_1EF2, var_5._id_1EF2], "crate_move_3_pre_idle", "stop_crate_3_move_idle");
  wait 10;
  var_2 notify("stop_crate_3_move_idle");
  var_2 scripts\sp\anim::_id_1F2C([var_4, var_5, var_4._id_1EF2, var_5._id_1EF2], "crate_move_3_walk");
  var_2 thread scripts\sp\anim::_id_1EE7([var_4._id_1EF2, var_5._id_1EF2], "crate_move_3_post_idle");
  var_2 thread scripts\sp\anim::_id_1EE7([var_4, var_5], "crate_move_3_post_idle");
}

_id_8A85() {
  level endon("airboss_door_scene_start");
  var_0 = _id_0EF9::_id_FE03("dropship", "dropship_bay_1");
  var_0 _id_0BBC::_id_4265(["back"], 1);
  var_0 _id_0BBF::_id_F458();
  var_1 = getvehiclenode("dropship_bay_1_tow", "targetname");
  var_0 vehicle_teleport(var_1.origin, var_1.angles);
  scripts\engine\utility::waitframe();
  var_0 attachpath(var_1);
  var_0 startpath(var_1);
  var_0 vehicle_setspeed(0, 1, 1);
  wait 5;
  var_0 vehicle_setspeed(1.0, 1, 1);
  var_0 resumespeed(1.0);
}

_id_840D(var_0) {
  level endon("kill_leave_deck_ambient");
  self.goalradius = 256;
  var_1 = getnode(var_0, "targetname");
  thread _id_0B77::_id_8409();
  var_1 waittill("trigger");
  scripts\sp\utility::_id_51E1("casual_gun");
  thread _id_0EE5::_id_202D();
}

_id_8A81() {
  level endon("kill_leave_deck_ambient");
  level waittill("hangar_start_c12");
  var_0 = scripts\engine\utility::getStruct("shipcrib_prisoner_leave_marine1", "targetname");
  var_1 = _id_0EF8::_id_FDFC("spawner_marine", "shipcrib_prisoner_leave_marine1");
  var_1.target = var_0.targetname;
  var_1 _id_0EFB::_id_FD6F("leave_c12_guys");
  var_1 scripts\sp\utility::_id_86E2();
  var_1 scripts\sp\utility::_id_51E1("combat");
  var_1 scripts\sp\utility::_id_F492(0.9);
  var_1 thread _id_840D("c12_marine1_node");
  var_0 = scripts\engine\utility::getStruct("shipcrib_prisoner_leave_marine2", "targetname");
  var_2 = _id_0EF8::_id_FDFC("spawner_marine", "shipcrib_prisoner_leave_marine2");
  var_2.target = var_0.targetname;
  var_2 _id_0EFB::_id_FD6F("leave_c12_guys");
  var_2 scripts\sp\utility::_id_86E2();
  var_2 scripts\sp\utility::_id_51E1("combat");
  var_2 scripts\sp\utility::_id_F492(0.9);
  var_2 thread _id_840D("c12_marine1_node");
  var_3 = getEnt("spawner_c12", "targetname");
  var_4 = var_3 scripts\sp\utility::_id_10619(1);
  var_4 _id_0EFB::_id_FD6F("leave_c12_guys");
  var_4._id_1FBB = "c12";
  var_4 scripts\sp\utility::_id_51E1("casual");
  var_4.goalradius = 128;
  var_4.disablearrivals = 1;
  var_4.name = "";
  var_4 setCanDamage(0);
  var_4 scripts\sp\utility::_id_65E0("enable_arrivals");
  var_4 scripts\sp\utility::_id_65E3("enable_arrivals");
  wait 1;
  var_4.disablearrivals = 0;
  var_4 waittill("reached_path_end");
  wait 1;
  scripts\engine\utility::flag_waitopen("c12_elevator_clear");
  level._id_E35D._id_B147 solid();
  level thread _id_0EEB::_id_60F0("magazine", 25);
  level thread _id_0EEB::_id_60FD("magazine", "Storage");
  _id_0EEB::_id_7976("magazine") waittill("move_finished");
  scripts\engine\utility::flag_set("c12_elevator_done");
  var_2 waittill("reached_path_end");
  _id_0EFB::_id_FDBA(var_1);
  _id_0EFB::_id_FDBA(var_2);
}

#using_animtree("generic_human");

_id_AB15() {
  level endon("kill_leave_deck_ambient");
  level waittill("airboss_door_scene_start");
  _id_0E7B::main();
  var_0 = level._id_FD6E._id_5EE3["dropship_bay_1"];
  var_1 = scripts\sp\utility::_id_10639("tablet");
  _id_0EF8::_id_FDFC("spawner_brooks", var_0);
  var_2 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", var_0, "cheap");
  var_2 _id_0EFB::_id_FD6F("leave_deck_misc");
  level._id_30F6 _id_0EFB::_id_EB8D("prisoner");
  level._id_30F6 scripts\sp\utility::_id_86E2();
  level._id_30F6 thread scripts\sp\interaction::_id_CD4B("sh_pri_brooks_reaction", var_0);
  var_0 thread scripts\sp\anim::_id_1ECC(var_2, "SH_PRI_7_17_RS_PU1_Vig01_Ally_idle", "stop_brooks_assistant_loop");
  var_0 thread scripts\sp\anim::_id_1EEA(var_1, "SH_PRI_7_17_RS_PU1_Vig01_tablet_idle", "stop_brooks_assistant_loop");
  level._id_30F6 waittill("playing_interaction_scene");
  level._id_30F6 clearanim(%head, 0.2);
  level._id_30F6 thread scripts\sp\utility::_id_7798(level.player);
  level._id_30F6 thread scripts\sp\utility::_id_7799(level.player);
  level._id_30F6 waittill("interaction_done");
  level._id_30F6 scripts\sp\utility::_id_77B9(0.7);
  level._id_30F6 thread scripts\sp\interaction::_id_9A0F();
  var_0 notify("stop_brooks_assistant_loop");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_30F6, "SH_PRI_7_17_RS_PU1_Vig01_MR1_walk");
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "SH_PRI_7_17_RS_PU1_Vig01_tablet_walk");
  var_0 scripts\sp\anim::_id_1EC7(var_2, "SH_PRI_7_17_RS_PU1_Vig01_Ally_walk");
  var_0 thread scripts\sp\anim::_id_1ECC(var_2, "SH_PRI_7_17_RS_PU1_Vig01_Ally_idle02");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_30F6, "SH_PRI_7_17_RS_PU1_Vig01_MR1_idle02");
  var_0 thread scripts\sp\anim::_id_1EEA(var_1, "SH_PRI_7_17_RS_PU1_Vig01_tablet_idle02");
  level._id_30F6 thread _id_0EE5::_id_202D();
}

_id_AB1B() {
  level endon("kill_leave_deck_ambient");
  level waittill("airboss_door_scene_start");
  _id_0E7C::main();
  var_0 = scripts\engine\utility::getStruct("leave_deck_macallum_subordinate1", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "leave_deck_macallum_subordinate1", "cheap");
  var_1 _id_0EFB::_id_FD6F("leave_deck_misc");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, var_0.animation);
  var_0 = scripts\engine\utility::getStruct("leave_deck_macallum_subordinate2", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "leave_deck_macallum_subordinate2", "cheap");
  var_1 _id_0EFB::_id_FD6F("leave_deck_misc");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, var_0.animation);
  var_1 thread _id_0EE5::_id_202D();
  _id_0EF8::_id_FDFC("spawner_mac", "leave_deck_macallum", "cheap");
  level._id_B11D attach("p7_desk_metal_military_03_tablet", "tag_accessory_left");
  level._id_B11D thread _id_0EE5::_id_202D("sh_pri_mac_blended_react", "sc_prisoner_mac_captainnobottle");
}

_id_AB16() {
  level endon("kill_leave_deck_ambient");
  level waittill("airboss_door_scene_start");
  var_0 = _id_0EFB::_id_FD9C("catwalks_armory");
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_armory"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_secA"));

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_1DF6)) {
      var_2._id_1DF6 notify("ambient_idle_scene_end");
    }
  }

  _id_0EFB::_id_FDBB("catwalks_armory");
  _id_0EFB::_id_FDBB("catwalks_secA");
}

_id_AB1A() {
  level endon("kill_leave_deck_ambient");
  level waittill("airboss_door_scene_start");
  var_0 = _id_10A7::_id_8A6A("e3_hangar_hustle");
}

_id_AB1C() {
  level endon("kill_leave_deck_ambient");
  level waittill("airboss_door_scene_start");
  var_0 = _id_0EF9::_id_FE03("apc", "leaving_apc_a");
  var_0 scripts\sp\utility::_id_65E0("apc_start");
  var_1 = getvehiclenode("leaving_apc_a", "targetname");
  var_0 thread scripts\sp\vehicle::_id_1321A(var_1);
  var_0 startpath(var_1);
  wait 6;
  var_2 = scripts\engine\utility::getStructArray("scar_rally", "targetname");
  var_3 = [];

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_5 = _id_0EF8::_id_FE01("spawner_marine", var_2[var_4]);
    var_5 _id_0EFB::_id_FD6F("scar_rally");

    if(isDefined(var_2[var_4]._id_EE52)) {
      var_5._id_EE52 = var_2[var_4]._id_EE52;
    }

    if(isDefined(var_2[var_4].script_parameters)) {
      var_5.script_parameters = var_2[var_4].script_parameters;
    }

    var_5 scripts\sp\utility::_id_65E0("enable_arrivals");
    var_5 scripts\sp\utility::_id_65E0("at_elevator");
    var_5 scripts\sp\utility::_id_65E0("leave_elevator");
    var_5 scripts\sp\utility::_id_86E2();
    var_5 scripts\sp\utility::_id_51E1("combat");
    var_5 thread _id_8A9A(var_2[var_4].animation, var_2[var_4].target, var_4);
    var_5.disablearrivals = 1;
    var_3[var_3.size] = var_5;
  }

  foreach(var_7 in var_3) {
    var_7 scripts\sp\utility::_id_65E3("at_elevator");
    var_7 scripts\engine\utility::delaythread(randomfloatrange(4.0, 10.0), scripts\sp\utility::_id_51E1, "casual_gun");
  }

  scripts\engine\utility::flag_waitopen("jackal_elevator_clear");
  _id_0EEB::_id_60F0("jackal", 30);
  level thread _id_0EEB::_id_60FD("jackal", "Storage");
  _id_0EEB::_id_7976("jackal") waittill("move_finished");
  wait 0.5;
  level thread _id_8A8D(var_0);

  foreach(var_7 in var_3) {
    wait(randomfloatrange(0.5, 1.5));
    var_7 scripts\sp\utility::_id_65E1("leave_elevator");
  }
}

_id_8A8D(var_0) {
  level endon("kill_leave_deck_ambient");
  var_0 scripts\sp\utility::_id_65E1("apc_start");
  var_0 waittill("reached_end_node");
  _id_0EFB::_id_FDE7(var_0);
}

_id_8A9A(var_0, var_1, var_2) {
  level endon("kill_leave_deck_ambient");
  self endon("death");
  var_3 = _id_0EFB::_id_7D7A(var_1).origin;
  scripts\sp\utility::_id_F3DC(var_3);
  self.goalradius = 8;
  self.target = var_1;
  thread _id_0B77::_id_8409();

  if(isDefined(self.script_parameters) && self.script_parameters == "front") {
    level._id_EBC1 = self;
    scripts\sp\utility::_id_F492(1);
    scripts\engine\utility::delaycall(0.05, ::_meth_82B0, scripts\sp\utility::_id_7DC1(var_0), 0.305);
  } else if(isDefined(self.script_parameters) && self.script_parameters == "rear") {
    level._id_EBC6 = self;
    scripts\engine\utility::delaycall(0.05, ::_meth_82B0, scripts\sp\utility::_id_7DC1(var_0), 0.31);
  } else
    scripts\engine\utility::delaycall(0.05, ::_meth_82B0, scripts\sp\utility::_id_7DC1(var_0), 0.31);

  scripts\sp\anim::_id_1EC7(self, var_0);
  scripts\sp\utility::_id_65E3("enable_arrivals");
  self.disablearrivals = 0;
  self waittill("reached_path_end");
  _id_0EFB::_id_FDBA(self);
}

_id_1EB6(var_0, var_1, var_2, var_3) {
  level endon("kill_leave_deck_ambient");
  thread _id_0B77::_id_8409();
}

_id_AB17() {
  level endon("kill_leave_deck_ambient");
  level waittill("airboss_door_scene_start");
  wait 3;
  level _id_0EDF::_id_E38E("unload", 60);
  level _id_0EDF::_id_E38E("basket_open_unload", 2);
  wait 10;
  level _id_0EDF::_id_E38E("basket_closed", 2);
  level _id_0EDF::_id_E38E("start", 75);
}

_id_8A87() {
  level waittill("kill_leave_deck_ambient");

  foreach(var_1 in _id_0EFB::_id_FD9C("leave_deck_misc")) {
    if(isDefined(var_1._id_1EF2)) {
      if(isDefined(var_1._id_1EF2._id_4348)) {
        var_1._id_1EF2._id_4348 delete();
      }

      var_1._id_1EF2 delete();
    }

    _id_0EFB::_id_FDBA(var_1);
  }

  _id_0EFB::_id_FDBA(level._id_828C);
  _id_0EFB::_id_FDBA(level._id_EA29);
  _id_0EFB::_id_FDBA(level._id_30F6);
  _id_0EFB::_id_FDBA(level._id_B11D);
  _id_0EFB::_id_FDBB("scar_rally");
  _id_0EFB::_id_FDBB("leave_c12_guys");
  _id_10A7::_id_8A6B(_id_0EFB::_id_FD9C("hangar_hustle"));
  level thread _id_10A3::_id_3B9E();
  level thread _id_10A2::_id_1A5E();
  level thread _id_10A5::_id_5E9A(_id_0EFB::_id_FD9C("dropship_service"));
  level thread _id_10AA::_id_A315(_id_0EFB::_id_FD9C("jackal_service"));
  var_3 = scripts\engine\utility::array_combine(level._id_FD6E._id_209C, level._id_FD6E.jackals);
  var_3 = scripts\engine\utility::array_combine(var_3, level._id_FD6E._id_11A55);
  var_3 = scripts\engine\utility::array_combine(var_3, level._id_FD6E._id_7316);
  var_3[var_3.size] = level._id_FD6E._id_5EE3["dropship_bay_1"];

  if(isDefined(level._id_FD6E._id_11A55["leave_towcart_a"])) {
    if(isDefined(level._id_FD6E._id_11A55["leave_towcart_a"]._id_3A5D)) {
      foreach(var_5 in level._id_FD6E._id_11A55["leave_towcart_a"]._id_3A5D) {
        var_5 unlink();
        var_5 delete();
      }
    }
  }

  var_5 = getEntArray("leave_forklift_a_cargo", "targetname");

  if(isDefined(var_5)) {
    foreach(var_8 in var_5) {
      var_8 unlink();
      var_8 delete();
    }
  }

  foreach(var_11 in var_3) {
    _id_0EFB::_id_FDE7(var_11);
  }
}