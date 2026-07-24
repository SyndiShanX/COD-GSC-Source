/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_titan\shipcrib_titan_ambient.gsc
*********************************************************************/

_id_1DBF() {
  scripts\engine\utility::flag_wait_all("shipcrib_titan_prime_in_tr_loaded");
  level thread _id_1DE8();
  level thread _id_1E02();
  level thread _id_1E07();
  level thread _id_1DFF();
  level thread _id_1DFE();
  level thread _id_1E01();
}

_id_1DE8() {
  level._id_A7A1 = [];
  level._id_A7A2 = [];
  level._id_A7A1[0] = "shipcrib_un1_thesepipeshavesee";
  level._id_A7A1[1] = "shipcrib_un2_yeahtheyrestarting";
  level._id_A7A1[2] = "shipcrib_un1_theresaslightleak";
  level._id_A7A1[3] = "";
  level._id_A7A1[4] = "shipcrib_un1_makesureyouwriteup";
  level._id_A7A1[5] = "shipcrib_un2_whatabouttheother";
  level._id_A7A1[6] = "shipcrib_un1_theyrefairingabitbet";
  level._id_A7A1[7] = "shipcrib_un2_thatcouplingrightth";
  level._id_A7A1[8] = "shipcrib_un1_goodeyesomeone";
  level._id_A7A1[9] = "";
  level._id_A7A1[10] = "shipcrib_un1_youseethis";
  level._id_A7A1[11] = "shipcrib_un2_yeah";
  level._id_A7A1[12] = "shipcrib_un1_itsperodicityisalitt";
  level._id_A7A1[13] = "shipcrib_un2_roger";
  level._id_A7A1[14] = "shipcrib_un1_icantwaituntilwe";
  level._id_A7A1[15] = "";
  level._id_A7A1[16] = "shipcrib_un1_hewasrighthere";
  level._id_A7A1[17] = "";
  level._id_A7A1[18] = "";
  level._id_A7A1[19] = "";
  level._id_A7A1[20] = "";
  level._id_A7A1[21] = "";
  level._id_A7A1[22] = "";
  level._id_A7A1[23] = "";
  level._id_A7A1[24] = "";
  level._id_A7A1[25] = "";
  level._id_A7A1[26] = "";
  level._id_A7A1[27] = "";
  level._id_A7A1[28] = "shipcrib_un1_isweariheardthat";
  level._id_A7A1[29] = "shipcrib_un2_yeahmetoo";
  level._id_A7A1[30] = "shipcrib_un1_thingsbeendrivingme";
  level._id_A7A1[31] = "";
  level._id_A7A1[32] = "shipcrib_un1_quietithinkiheard";
  level._id_A7A1[33] = "";
  level._id_A7A1[34] = "shipcrib_un1_musthavebeenmy";
  level._id_A7A1[35] = "shipcrib_un2_youhearaboutchip";
  level._id_A7A1[36] = "shipcrib_un1_nowhatsup";
  level._id_A7A1[37] = "shipcrib_un2_felloffastepladder";
  level._id_A7A1[38] = "shipcrib_un1_manthatsmessed";
  level._id_A7A1[39] = "shipcrib_un2_yeahnowhejust";
  level._id_A7A1[40] = "shipcrib_un1_ihearitagain";
  level._id_A7A1[41] = "shipcrib_un2_toyourleft";
  level._id_A7A1[42] = "";
  level._id_A7A1[43] = "shipcrib_un2_nonoyourother";
  level._id_A7A1[44] = "shipcrib_un1_thereheis";
  level._id_A7A1[45] = "";
  level._id_A7A1[46] = "shipcrib_un1_waitwheredhego";
  level._id_A7A1[47] = "shipcrib_un2_whatdoyoumean";
  level._id_A7A1[48] = "shipcrib_un1_hejustdisappeared";
  level._id_A7A1[49] = "shipcrib_un2_yourenotmakingany";
  level._id_A7A1[50] = "shipcrib_un1_hewasrighthere";
  level._id_A7A1[51] = "shipcrib_un2_ithinkweneedagood";
}

_id_1DC6() {
  if(level._id_10CDA == "titan start") {
    _id_ADD5();
  }
}

_id_1E02() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_hangar");
    _id_ADE6();
    _id_0EE4::_id_6E5E("ambient_zone_hangar");
    _id_40B1();
    _id_0EFB::_id_FD71();
  }
}

_id_1E07() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_returne");
    _id_0EFB::_id_FDBB("return_deck");
    _id_0EFB::_id_FDE7(level._id_FD6E._id_A2E4);
    _id_0EFB::_id_FDE7(level._id_FD6E._id_A2EC);

    if(scripts\engine\utility::flag("shipcrib_titan_ambientmr_tr_loaded")) {
      _id_0EFB::_id_FD71();
      scripts\sp\utility::_id_1264E("shipcrib_titan_ambientmr_tr");
    }

    _id_0EE4::_id_6E5E("ambient_zone_returne");
  }
}

_id_1DFF() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_bridgef");
    _id_AE04();
    _id_0EE4::_id_6E5D("ambient_zone_bridgef");
    _id_40CD();
  }
}

_id_1DFE() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_bridgee");
    _id_0EFB::_id_FDBB("bridge_crew");
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

_id_1E0B() {
  if(!scripts\engine\utility::flag("shipcrib_titan_ambientmr_tr_loaded")) {
    scripts\sp\utility::_id_12641("shipcrib_titan_ambientmr_tr");
  }

  level thread _id_A2EB();
  level thread scripts\sp\maps\shipcrib_titan\shipcrib_titan::_id_E3C8();
  level thread _id_0EE4::_id_E398(level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979, 0.05);
}

#using_animtree("jackal");

_id_1E0A() {
  if(!scripts\engine\utility::flag("shipcrib_titan_ambientml_tr_loaded")) {
    scripts\sp\utility::_id_12641("shipcrib_titan_ambientml_tr");
  }

  _id_0EF9::_id_FE03("jackal_cheap", "jackal_bay_3", undefined, undefined, 1);
  _id_ADD3("jackal_bay_3");
  level._id_FD6E.jackals["jackal_bay_3"] _meth_82A2(%shipcrib_veh_jackal_lean_canopy_opened_hold);
  level._id_FD6E.jackals["jackal_bay_3"] _meth_82A2(%shipcrib_veh_jackal_lean_hatch_center_open_hold);
  level._id_FD6E.jackals["jackal_bay_3"] _meth_82A2(%shipcrib_veh_jackal_lean_hatch_left_open_hold);
  level._id_FD6E.jackals["jackal_bay_3"] _meth_82A2(%shipcrib_veh_jackal_lean_hatch_right_open_hold);
  level._id_FD6E.jackals["jackal_bay_3"] _meth_82A2(%shipcrib_veh_jackal_lean_hatch_top_open_hold);
}

_id_1E0E() {
  if(!scripts\engine\utility::flag("shipcrib_titan_ambientml_tr_loaded")) {
    scripts\sp\utility::_id_12641("shipcrib_titan_ambientml_tr");
  }
}

_id_1E0D() {
  if(!scripts\engine\utility::flag("shipcrib_titan_ambientml_tr_loaded")) {
    scripts\sp\utility::_id_12641("shipcrib_titan_ambientml_tr");
  }
}

_id_ADD5() {
  _id_10AB::_id_ADAD("sc_titan_ambient_jackalcontrol", ::_id_AE08, ::_id_CE69);
}

_id_408D() {
  _id_0EFB::_id_FDBB("jackalcontrol");
}

_id_CE69(var_0) {
  var_1 = var_0["jackalcontrol_guy_01"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["jackalcontrol_guy_02"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["jackalcontrol_guy_03"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["jackalcontrol_guy_04"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
}

_id_AE08() {}

_id_ADE6() {
  level thread _id_10A2::_id_1A5D();
}

_id_40B1() {
  _id_10AB::_id_404E("returndeck");
  level thread _id_10A2::_id_1A5E();
}

_id_CE6A(var_0) {
  var_1 = var_0["returndeck_guy_01"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["returndeck_guy_02"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["returndeck_guy_03"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["returndeck_guy_04"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
}

#using_animtree("generic_human");

_id_AE0A() {
  level._id_EC85["generic"]["shipcrib_marine_idle_02_convo_01_crouch_B"][0] = % shipcrib_marine_idle_02_convo_01_crouch_b;
  level._id_EC85["generic"]["shipcrib_marine_idle_02_convo_01_stand_A"][0] = % shipcrib_marine_idle_02_convo_01_stand_a;
  level._id_EC85["generic"]["shipcrib_hangar_stand_lean_idle_01"][0] = % shipcrib_hangar_stand_lean_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_wall_wounded01"][0] = % shipcrib_moon_wall_wounded01;
}

#using_animtree("jackal");

_id_A2EB() {
  level._id_FD6E._id_A2EC = getEnt("jackal_return_load_vehicle", "targetname");
  level._id_FD6E._id_A2E4 = spawn("script_model", level._id_FD6E._id_A2EC.origin);
  level._id_FD6E._id_A2E4.angles = level._id_FD6E._id_A2EC.angles;
  level._id_FD6E._id_A2E4.collision = level._id_FD6E._id_A2E4 _id_0EF9::_id_A0AE();
  level._id_FD6E._id_A2E4 setModel("veh_mil_air_un_jackal_landed_03b");
  level._id_FD6E._id_A2E4 linkTo(level._id_FD6E._id_A2EC);
  level._id_FD6E._id_A2E4 _meth_83D0(#animtree);
  level._id_FD6E._id_A2E4 _meth_82A2(%jackal_vehicle_landed_state_idle);
  level._id_FD6E._id_A2EC vehicle_setspeedimmediate(1, 0.1, 0.1);
  level._id_FD6E._id_A2EC startpath(getvehiclenode("jackal_return_load_start", "targetname"));
}

_id_ADD3(var_0) {
  var_1 = ["spawner_flightdeck", "spawner_flightdeck_maintenance", "spawner_flightdeck_fuel"];
  var_2 = level._id_FD6E.jackals[var_0];
  var_3 = _id_0EF8::_id_FE01(var_1[randomintrange(0, 2)], "jackal_service_normal_spawnloc", "cheap");
  var_4 = _id_0EF8::_id_FE01(var_1[randomint(var_1.size)], "jackal_service_normal_spawnloc", "cheap");
  var_5 = _id_0EF8::_id_FE01(var_1[randomint(var_1.size)], "jackal_service_normal_spawnloc", "cheap");
  level thread _id_10AA::_id_A314(var_2, var_3, var_4, var_5);
}

_id_1DDC() {
  _id_0EA0::main();
  _id_0EA1::main();
  _id_0E9E::main();
  _id_0E88::main();
  _id_0E85::main();
  var_0 = scripts\engine\utility::getStruct("hangar_reaction_bay1", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_director", var_0, "cheap");
  var_1 thread _id_0EE5::_id_202D("shipcrib_stand_point_right_01");
  var_0 = scripts\engine\utility::getStruct("hangar_reaction_bay2", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_director", var_0, "cheap");
  var_1 thread _id_0EE5::_id_202D("shipcrib_salute_reaction_idle_01");
  var_0 = scripts\engine\utility::getStruct("hangar_reaction_bay3", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_director", var_0, "cheap");
  var_1 thread _id_0EE5::_id_202D("shipcrib_guard_reaction_idle_01");
  var_0 = scripts\engine\utility::getStruct("hangar_reaction_crouch", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_director", var_0, "cheap");
  var_1 thread _id_0EE5::_id_202D("shipcrib_crouch_point_right_01");
}

_id_A313() {
  var_0 = scripts\engine\utility::getStructArray("jackal_service", "targetname");

  foreach(var_2 in var_0) {
    var_3 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", var_2, "cheap");
    var_3._id_1FBB = "generic";

    if(isDefined(var_2.script_parameters)) {
      var_4 = strtok(var_2.script_parameters, " ");

      foreach(var_6 in var_4) {
        switch (var_6) {
          case "jackal_load":
            var_3 thread _id_A316(var_2);
            break;
        }
      }

      continue;
    }

    var_2 thread scripts\sp\anim::_id_1ECC(var_3, var_2.animation, "stop_loop");
    var_3 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_3 scripts\sp\utility::_id_7DC1(var_2.animation)[0], randomfloatrange(0, 1));
  }
}

_id_A316(var_0) {
  self endon("death");
  var_0 thread scripts\sp\anim::_id_1ECC(self, "stand_stationary_idle", "stop_loop");
  level._id_FD6E._id_A056["jackal_a_dock_vehicle"] waittill("reached_end_node");
  var_0 notify("stop_loop");
  var_0 thread scripts\sp\anim::_id_1ECC(self, var_0.animation, "stop_loop");
}

_id_B348(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_4 = _id_0EF8::_id_FE01("spawner_marine", var_3, "cheap");
    var_4 thread _id_0EE5::_id_202D();

    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "hasgun") {
      var_4 scripts\sp\utility::_id_86E2();
    }

    var_3 thread scripts\sp\anim::_id_1ECC(var_4, var_3.animation, "stop_loop");
    var_4 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_4 scripts\sp\utility::_id_7DC1(var_3.animation)[0], randomfloatrange(0, 1));
  }
}

_id_EB8B() {
  wait 1.0;
  scripts\sp\utility::_id_10346("shipcrib_us1_fivebyfive");
  wait 0.5;
  level.player scripts\sp\utility::play_sound_on_entity("shipcrib_plr_keepitthatway");
}

_id_1569() {
  wait 0.75;
  scripts\sp\utility::_id_10346("shipcrib_us1_sir1");
}

_id_156A() {
  wait 0.75;
  scripts\sp\utility::_id_10346("shipcrib_us1_sir2");
}

_id_156B() {
  wait 0.75;
  scripts\sp\utility::_id_10346("shipcrib_us1_captain");
}

_id_138DB() {
  wait 0.75;
  scripts\sp\utility::_id_10346("shipcrib_us1_wantedonbridge");
}

_id_CC8B(var_0, var_1) {
  wait(var_0);
  scripts\sp\utility::_id_10346(var_1);
}

_id_AE04() {
  _id_AE02();
  _id_AE09();
  _id_AE0B();
  scripts\engine\utility::waitframe();
}

_id_40CD() {
  _id_40CF();
  _id_40D0();
}

_id_AE02() {
  _id_0E8B::main();
  _id_0E8A::main();
  var_0 = scripts\engine\utility::getStruct("pipe_repair_1", "targetname");

  if(isDefined(var_0)) {
    var_1 = _id_0EF8::_id_FE01("spawner_interior", var_0, "cheap");
    var_1 thread scripts\sp\interaction::_id_CD50("shipcrib_hall_pipe_repair_01", var_0);
    var_2 = _id_0EF8::_id_FE01("spawner_interior", var_0, "cheap");
    var_2 thread scripts\sp\interaction::_id_CD50("shipcrib_hall_ladder_repair_01", var_0);
    var_3 = [];
    var_3[0] = var_1;
    var_3[1] = var_2;
    var_1 scripts\engine\utility::delaythread(2, ::_id_FDD4, var_3, level._id_A7A1, 300);
  }

  var_4 = scripts\engine\utility::getStruct("titan_bridgehallway_hustle", "targetname");
  var_5 = _id_0EF8::_id_FE01("spawner_interior", var_4, "cheap");
  var_4 thread scripts\sp\anim::_id_1EEA(var_5, "hallway_hustle", "stop_idle");
}

_id_AE09() {
  _id_E823();
}

_id_40CF() {
  _id_0EFB::_id_FDBB("lounge");
  _id_0EFB::_id_FDBB("bridge_hall");
}

_id_AE0B() {
  _id_0EF7::_id_ADF6();
}

_id_40D0() {
  _id_0EF7::_id_40C0();
}

_id_AE05() {
  thread _id_0EE9::_id_ADFC();
}

_id_40CE() {
  _id_0EDB::_id_40C2();
}

_id_E822() {}

_id_11379() {}

_id_CE67() {
  _id_0EDB::_id_CCB8();
}

_id_CD87() {}

_id_CD88() {}

_id_1DDF() {}

_id_E823() {}

_id_ADB1() {
  _id_107E3();
  _id_10AB::_id_ADAD("sc_titan_ambient_armoryhallway", ::_id_AE01, ::_id_CE66);
}

_id_4054() {
  _id_40C9();
  _id_10AB::_id_404E("sc_titan_ambient_armoryhallway");
}

_id_107E3() {
  if(!isDefined(level._id_A052)) {
    var_0 = scripts\engine\utility::getStruct("jack_fx", "targetname");
    level._id_A052 = playFX(scripts\engine\utility::getfx("broken_pipe_steam"), var_0.origin);
  }
}

_id_40C9() {
  if(isDefined(level._id_A052)) {
    level._id_A052 delete();
  }
}

_id_CE66(var_0) {
  var_1 = var_0["armoryhallway_inventoryguy"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 _id_174F();
  var_1 = var_0["armoryhallway_inventoryguy2"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 _id_174F();
}

#using_animtree("generic_human");

_id_AE01() {
  level._id_EC85["generic"]["shipcrib_inspection_idle"][0] = % shipcrib_inspection_idle;
  level._id_EC85["generic"]["shipcrib_inspection_90_low_idle"][0] = % shipcrib_inspection_90_low_idle;
}

_id_174F() {
  self._id_247B = spawn("script_model", self.origin);
  self._id_247B setModel("p7_desk_metal_military_03_tablet");
  self._id_247B linkTo(self, "tag_inhand", (0, 0, 0), (0, 0, 0));
  self._id_247B thread _id_40A1(self);
}

_id_40A1(var_0) {
  var_0 waittill("death");

  if(isDefined(self)) {
    self delete();
  }
}

#using_animtree("jackal");

_id_21AF(var_0) {
  if(!isDefined(level._id_21B1)) {
    level._id_21B1 = 1;
    _id_0EF9::_id_FE03("apc", "hangar_apc");
    level _id_E38D("crane_platform");
    level._id_FD6E.jackals["jackal_b_dock_vehicle"] = getEnt("jackal_b_dock_vehicle", "targetname");
    level._id_FD6E.jackals["jackal_b_dock_vehicle"] setModel("veh_mil_air_un_jackal_landed_03b");
    level._id_FD6E.jackals["jackal_b_dock_vehicle"].collision = level._id_FD6E.jackals["jackal_b_dock_vehicle"] _id_0EF9::_id_A0AE();
    level._id_FD6E.jackals["jackal_b_dock_vehicle"] _meth_83D0(#animtree);
    level._id_FD6E.jackals["jackal_b_dock_vehicle"] _meth_82A2(%shipcrib_veh_jackal_lean_canopy_opened_hold, 1, 0.2, 5);
    level._id_FD6E.jackals["jackal_b_dock_vehicle"] _meth_82A2(%shipcrib_veh_jackal_lean_hatch_right_open, 1, 0, 5);
    var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_handler", level._id_FD6E.jackals["jackal_b_dock_vehicle"], "cheap");
    var_1 _id_0EFB::_id_FD6F("jackal_guys");
    var_1 thread _id_A2EE(level._id_FD6E.jackals["jackal_b_dock_vehicle"], "shipcrib_jackal_serv_top_02");
    _id_0EEF::_id_15B0(["jackal_bay_1", "jackal_bay_4"], "air");
    _id_0EEF::_id_15B0(["jackal_bay_1", "jackal_bay_4"], "gasoline", 1);
    _id_0EEF::_id_15B0(["jackal_bay_1", "jackal_bay_3", "jackal_bay_4"], "gasoline", 2);
    _id_0EEF::_id_15B0(["jackal_bay_1", "jackal_bay_3", "jackal_bay_4"], "nitrogen");
    _id_0EEF::_id_15B0(["dropship_bay_1"], "air");
    _id_0EEF::_id_15B0(["dropship_bay_1"], "gasoline");
    _id_0EEF::_id_15B0(["dropship_bay_1"], "nitrogen");
    level thread _id_10AC::_id_ADAE("leaving_welder", "welding_sparks_hangar", "spawner_flightdeck_maintenance");
  }

  level thread _id_10A3::_id_3B9E();

  if(!isDefined(var_0)) {
    var_0 = "";
  }

  switch (var_0) {
    case "close":
      _id_0EFB::_id_FDBB("apc_walker");
      var_2 = getvehiclenode("apc_load_start_close", "targetname");
      level._id_FD6E._id_209C["hangar_apc"] vehicle_teleport(var_2.origin, var_2.angles);
      level._id_FD6E._id_209C["hangar_apc"] vehicle_setspeedimmediate(1.25, 1, 1);
      level._id_FD6E._id_209C["hangar_apc"] startpath(var_2);
      level thread _id_8A82();
      level thread _id_8A8C("apc_load_waver", 20);
      level thread _id_10A3::_id_3B9D(0, 1, 1, 0, 1, 0, 1, 0, 1, 0);
      var_3 = getvehiclenode("jackal_b_dock_start_close", "targetname");
      level._id_FD6E.jackals["jackal_b_dock_vehicle"] vehicle_teleport(var_3.origin, var_3.angles);
      level._id_FD6E.jackals["jackal_b_dock_vehicle"] vehicle_setspeedimmediate(1.5, 0.1, 0.1);
      level._id_FD6E.jackals["jackal_b_dock_vehicle"] startpath(var_3);
      level._id_FD6E.jackals["jackal_b_dock_vehicle"] _meth_82A2(%shipcrib_veh_jackal_lean_wheel_rotate, 1, 0.2, 0.2);
      level._id_FD6E.jackals["jackal_b_dock_vehicle"] scripts\engine\utility::delaycall(2.5, ::playsound, "shipcrib_titan_jackal_arrive_shutdown");
      break;
    default:
      _id_0EFB::_id_FDBB("apc_walker");
      var_2 = getvehiclenode("apc_load_start", "targetname");
      level._id_FD6E._id_209C["hangar_apc"] vehicle_teleport(var_2.origin, var_2.angles);
      level._id_FD6E._id_209C["hangar_apc"] vehicle_setspeedimmediate(2.25, 1, 1);
      level._id_FD6E._id_209C["hangar_apc"] startpath(var_2);
      var_4 = scripts\engine\utility::getStructArray("apc_load_walker_start", "targetname");

      foreach(var_6 in var_4) {
        var_7 = _id_0EF8::_id_FE01("spawner_flightdeck_handler", var_6);
        var_7 _id_0EFB::_id_FD6F("apc_walker");
        var_7 thread _id_0EE4::_id_8ADE(var_6, 0.8);
        var_7 thread _id_0EE4::_id_8ADF();
      }

      level thread _id_8A83();
      level thread _id_10A3::_id_3B9D();
      level._id_FD6E.jackals["jackal_b_dock_vehicle"] vehicle_setspeedimmediate(1.25, 1, 1);
      level._id_FD6E.jackals["jackal_b_dock_vehicle"] startpath(getvehiclenode("jackal_b_dock_start", "targetname"));
      level._id_FD6E.jackals["jackal_b_dock_vehicle"] _meth_82A2(%shipcrib_veh_jackal_lean_wheel_rotate, 1, 0.2, 0.2);
      break;
  }
}

_id_8A83() {
  level thread _id_0EDF::_id_E38E("start", 0.05);
  level thread _id_0EDF::_id_E38E("down", 0.05);
  wait 0.05;
  level _id_0EDF::_id_E38E("up", 30);
}

_id_8A82() {
  level thread _id_0EDF::_id_E38E("start", 0.05);
  level thread _id_0EDF::_id_E38E("up", 0.05);
  wait 0.05;
  level _id_0EDF::_id_E38E("unload", 70);
  level _id_0EDF::_id_E38E("basket_open_unload", 10);
}

_id_E38D(var_0) {
  if(!isDefined(level._id_8A33)) {
    level._id_8A33 = 1;
  } else {
    return;
  }

  var_1 = getEntArray(var_0, "targetname");
  var_2 = getEnt("hangar_crane_leave_origin", "targetname");
  var_3 = scripts\engine\utility::getStructArray("crane_platform_guy", "targetname");
  scripts\engine\utility::array_call(var_1, ::linkto, var_2);

  foreach(var_5 in var_3) {
    var_6 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", var_5, "cheap");
    var_6 _id_0EFB::_id_FD6F("crane_rider");
    var_6 thread scripts\sp\anim::_id_1ECC(var_6, var_5.animation, "stop_loop");
    var_6 linkTo(var_2);
  }

  var_8 = var_2 scripts\engine\utility::spawn_tag_origin();
  var_8.origin = var_8.origin + anglestoup(var_8.angles) * -70;
  var_8 linkTo(var_2);
  playFXOnTag(scripts\engine\utility::getfx("vfx_platform_nitrogen_base"), var_8, "tag_origin");
  var_2.origin = level._id_E35D._id_47DC gettagorigin("tag_floor");
  var_2 linkTo(level._id_E35D._id_47DC);
}

_id_8A8C(var_0, var_1) {
  var_0 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = _id_0EF8::_id_FE01("spawner_flightdeck_handler", var_0);
  var_2 _id_0EFB::_id_FD6F("apc_walker");
  var_2 endon("death");
  var_2 thread scripts\sp\anim::_id_1ECC(var_2, "shipcrib_hangar_apc_direct_loop_01", "stop_loop");
  wait(var_1);
  var_2 notify("stop_loop");
  var_2 _id_0B6A::_id_EC0A("apc_load_waver_end");
  var_2 thread _id_0EE5::_id_202D("shipcrib_stand_point_left_01");
}

_id_A2EE(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self linkTo(var_0);
  scripts\engine\utility::waitframe();
  var_0 thread scripts\sp\anim::_id_1ECC(self, var_1);
}

_id_FDD4(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(var_0.size < 2) {
    return;
  }
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  for(;;) {
    var_6 = distancesquared(level.player.origin, var_0[0].origin);

    if(var_6 > var_2 * var_2) {
      if(var_3 == 1) {
        foreach(var_8 in var_0) {
          var_8 _meth_8278(0, 0.5);
        }

        var_3 = 0;
      }

      wait 0.5;
      continue;
    }

    if(var_3 == 0) {
      foreach(var_8 in var_0) {
        var_8 _meth_8278(1, 0.5);
      }

      var_3 = 1;
    }

    if(var_5 < var_1.size) {
      if(soundexists(var_1[var_5])) {
        var_0[var_4] _id_0EE9::_id_CD78(var_1[var_5]);
      }

      var_4 = var_4 + 1;
      var_5 = var_5 + 1;

      if(var_4 > var_0.size - 1) {
        var_4 = 0;
      }

      wait(randomfloatrange(0.5, 1));
      continue;
    }

    var_4 = 0;
    var_5 = 0;
    wait(randomfloatrange(5, 10));
  }
}