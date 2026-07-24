/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_europa\shipcrib_europa_ambient.gsc
***********************************************************************/

_id_1DBF() {
  _id_10A5::_id_5E9B();
  scripts\engine\utility::flag_init("c12_clear");
  level thread _id_1DC6();
  scripts\engine\utility::flag_wait_all("shipcrib_europa_ambient_tr_loaded", "shipcrib_europa_jackal_tr_loaded");
  level thread _id_E46D();
  scripts\engine\utility::flag_wait_all("shipcrib_europa_dropship_tr_loaded", "shipcrib_europa_prime_in_tr_loaded");
  level scripts\engine\utility::delaythread(0.05, _id_0EDF::_id_E38E, "start", 0.05);
  level scripts\engine\utility::delaythread(0.05, _id_0EDF::_id_E38E, "down", 0.05);
  level thread _id_1E02();
  level thread _id_1E07();
  level thread _id_1DFF();
  level thread _id_1DFE();
  level thread _id_1E01();
}

_id_E46D() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_return_elevator_2f");
    level notify("kill_return_deck_ambient");

    if(scripts\engine\utility::flag("shipcrib_europa_ambientmr_tr_loaded")) {
      _id_0EFB::_id_FDBB("returndeck");
      _id_40B1();
      _id_408C();
      _id_406C();
      scripts\sp\utility::_id_1264E("shipcrib_europa_ambientmr_tr");
    }

    _id_0EFB::_id_FD71();

    foreach(var_1 in level._id_FD6E.jackals)
    var_1 _id_0BDC::_id_A2DA();

    scripts\sp\maps\shipcrib_europa\shipcrib_europa::_id_40B0();
    _id_0EFB::_id_FDE8(level._id_FD6E.jackals);
    _id_0EFB::_id_FDE8(level._id_FD6E._id_5EE3);
    _id_0EFB::_id_FDE8(level._id_FD6E._id_7316);
    var_3 = getEntArray("return_forklift_a_cargo", "targetname");
    var_4 = getEntArray("return_forklift_a_cargo_col", "targetname");
    scripts\engine\utility::array_call(var_3, ::delete);
    scripts\engine\utility::array_call(var_4, ::notsolid);
    level thread scripts\sp\utility::_id_12651(["shipcrib_europa_ambientmr_tr", "shipcrib_europa_hangar_tr", "shipcrib_europa_jackal_tr", "shipcrib_europa_jackale_tr", "shipcrib_europa_dropship_tr", "shipcrib_europa_mezz_tr"]);
    level thread scripts\sp\utility::_id_12643(["shipcrib_europa_bridge_tr", "shipcrib_europa_bridgee_tr", "shipcrib_europa_exterior_tr"]);
    _id_0EE4::_id_6E5E("ambient_return_elevator_2f");
  }
}

_id_1DC6() {
  if(level._id_10CDA == "europa start") {
    _id_ADD5();
    level waittill("jackal_elevator_finished");
    _id_408D();
  }
}

_id_1E02() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_hangar");
    _id_ADE6();
    _id_0EE4::_id_6E5E("ambient_zone_hangar");
    _id_40B1();
  }
}

_id_1E07() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_returne");
    level _id_10A6::_id_888A();
    level thread[[level._id_FDA2["elevator_up_func"]]]();
    _id_0EE4::_id_6E5E("ambient_zone_returne");
    level thread _id_10A6::_id_888B();
  }
}

_id_1DFF() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_bridgef");
    _id_ADC2();
    _id_0EE4::_id_6E5E("ambient_zone_bridgef");
    _id_4077();
  }
}

_id_1DFE() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_bridgee");
    _id_0EFB::_id_FDBA(level._id_76FB);
    _id_0EFB::_id_FDBA(level._id_1044B);
    _id_0EFB::_id_FDBB("bridge_crew");
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
    _id_ADB1();
    _id_0EE4::_id_6E5E("ambient_zone_gravity");
    _id_4054();
  }
}

_id_ADD5() {
  _id_10AB::_id_ADAD("sc_europa_ambient_jackalcontrol", ::_id_ADC1, ::_id_CD02);
}

_id_408D() {
  _id_0EFB::_id_FDBB("jackalcontrol");
}

_id_CD02(var_0) {
  var_1 = var_0["jackalcontrol_guy_01"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["jackalcontrol_guy_02"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["jackalcontrol_guy_03"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["jackalcontrol_guy_04"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
}

#using_animtree("generic_human");

_id_ADC1() {
  level._id_EC85["generic"]["shipcrib_jackal_control_ally01_idle01"][0] = % shipcrib_jackal_control_ally01_idle01;
  level._id_EC85["generic"]["shipcrib_jackal_control_ally01_idle02"][0] = % shipcrib_jackal_control_ally01_idle02;
  level._id_EC85["generic"]["shipcrib_jackal_control_ally02_idle01"][0] = % shipcrib_jackal_control_ally02_idle01;
  level._id_EC85["generic"]["shipcrib_jackal_control_ally02_idle02"][0] = % shipcrib_jackal_control_ally02_idle02;
}

_id_ADE6() {
  level thread _id_10A3::_id_3B9D(0, 1, 1, 0, 1, 0, 1, 0, 1, 0);
  level thread _id_10A2::_id_1A5D();
}

_id_40B1() {
  _id_406C();
  level thread _id_10A3::_id_3B9E();
  level thread _id_10A2::_id_1A5E();
}

_id_8ABE() {
  level thread _id_0EEB::_id_60F0("apc", 20);
  level scripts\engine\utility::delaythread(2, _id_0EEB::_id_60FD, "apc", "Catwalks");
  level thread _id_0EE4::_id_E398(level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979, 20);
  level thread _id_0EE4::_id_E398(level._id_E35D._id_AA5F["dropship_bay_1"]._id_5979, 15);
  level thread _id_8AB6();
  level thread _id_8ABB();
  level._id_E35D._id_AA5F["jackal_bay_1"]._id_7691 thread _id_0EE4::_id_A25C("jackal_load_center", 0.05);
  level._id_E35D._id_AA5F["jackal_bay_2"]._id_7691 thread _id_0EE4::_id_A25C("max_raised", 0.05);
  level._id_E35D._id_AA5F["jackal_bay_3"]._id_7691 thread _id_0EE4::_id_A25E();
  level._id_E35D._id_AA5F["jackal_bay_4"]._id_7691 thread _id_0EE4::_id_A25E();
  level thread _id_0EF9::_id_FE03("jackal_cheap", "jackal_bay_1", undefined, undefined, 1);
  level thread _id_0EF9::_id_FE03("jackal_cheap", "jackal_bay_2", undefined, undefined, 1);
}

_id_8AB6() {
  _id_0EDF::_id_E38E("up", 7);
  wait 2;
  _id_0EDF::_id_E38E("unload", 60);
  _id_0EDF::_id_E38E("basket_open_unload", 5);
}

_id_8ABB() {
  level endon("kill_return_deck_ambient");
  var_0 = _id_0EF9::_id_FE03("forklift", "return_forklift_a");
  wait 0.1;
  var_0 thread _id_0EED::_id_7309("return_forklift_a_cargo");
  var_0 _id_0EED::_id_730A("return_forklift_a");
  wait 0.5;
  var_0 _id_0EED::_id_7315();
  var_0 _id_0EED::_id_730A("forklift_deep_backup");
  level thread _id_0EEB::_id_60FD("apc", "Flight Deck");
  var_0 _id_0EED::_id_730A("return_forklift_a_return");
}

_id_CD04(var_0) {
  var_1 = var_0["returndeck_armory_associate"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["returndeck_sidemarine_01"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["returndeck_sidemarine_02"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["returndeck_phone_guy"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 attach("equipment_wall_mounted_phone_handset_01", "tag_accessory_right");
  var_1 = var_0["returndeck_injuredmarine_01"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["returndeck_injuredmarine_02"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["returndeck_injuredmarine_03"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["returndeck_medic_01"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["returndeck_marineleader"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  level._id_B34A = var_1;
  level._id_B34A thread _id_B34B();
  var_1 = var_0["returndeck_marineline_01"];
  var_1 thread _id_10AB::_id_1F5E(0.0, randomfloatrange(0, 0.75));
  var_1.weapon = "iw7_m4";
  var_1 scripts\sp\utility::_id_86E2();
  var_1 scripts\sp\utility::_id_7799(level._id_B34A);
  var_1 = var_0["returndeck_marineline_02"];
  var_1 thread _id_10AB::_id_1F5E(0.0, randomfloatrange(0, 0.75));
  var_1.weapon = "iw7_m4";
  var_1 scripts\sp\utility::_id_86E2();
  var_1 scripts\sp\utility::_id_7799(level._id_B34A);
  var_1 = var_0["returndeck_marineline_03"];
  var_1 thread _id_10AB::_id_1F5E(0.0, randomfloatrange(0, 0.75));
  var_1.weapon = "iw7_m4";
  var_1 scripts\sp\utility::_id_86E2();
  var_1 scripts\sp\utility::_id_7799(level._id_B34A);
  var_1 = var_0["returndeck_marineline_04"];
  var_1 thread _id_10AB::_id_1F5E(0.0, randomfloatrange(0, 0.75));
  var_1.weapon = "iw7_m4";
  var_1 scripts\sp\utility::_id_86E2();
  var_1 scripts\sp\utility::_id_7799(level._id_B34A);
  var_1 = var_0["returndeck_marineline_05"];
  var_1 thread _id_10AB::_id_1F5E(0.0, randomfloatrange(0, 0.75));
  var_1.weapon = "iw7_m4";
  var_1 scripts\sp\utility::_id_86E2();
  var_1 scripts\sp\utility::_id_7799(level._id_B34A);
  var_1 = var_0["returndeck_marineline_06"];
  var_1 thread _id_10AB::_id_1F5E(0.0, randomfloatrange(0, 0.75));
  var_1.weapon = "iw7_m4";
  var_1 scripts\sp\utility::_id_86E2();
  var_1 scripts\sp\utility::_id_7799(level._id_B34A);
  var_1 = var_0["returndeck_marineline_07"];
  var_1 thread _id_10AB::_id_1F5E(0.0, randomfloatrange(0, 0.75));
  var_1.weapon = "iw7_m4";
  var_1 scripts\sp\utility::_id_86E2();
  var_1 scripts\sp\utility::_id_7799(level._id_B34A);
  var_1 = var_0["returndeck_marineline_08"];
  var_1 thread _id_10AB::_id_1F5E(0.0, randomfloatrange(0, 0.75));
  var_1.weapon = "iw7_m4";
  var_1 scripts\sp\utility::_id_86E2();
  var_1 scripts\sp\utility::_id_7799(level._id_B34A);
  var_1 = var_0["returndeck_marineline_09"];
  var_1 thread _id_10AB::_id_1F5E(0.0, randomfloatrange(0, 0.75));
  var_1.weapon = "iw7_m4";
  var_1 scripts\sp\utility::_id_86E2();
  var_1 scripts\sp\utility::_id_7799(level._id_B34A);
  var_1 = var_0["returndeck_marineline_10"];
  var_1 thread _id_10AB::_id_1F5E(0.0, randomfloatrange(0, 0.75));
  var_1.weapon = "iw7_m4";
  var_1 scripts\sp\utility::_id_86E2();
  var_1 scripts\sp\utility::_id_7799(level._id_B34A);
}

_id_ADC5() {
  level._id_EC85["generic"]["shipcrib_marine_idle_02_standA_01_active"][0] = % shipcrib_marine_idle_02_standa_01_active;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_marine_03_idle_02"][0] = % shipcrib_hangar_c12_event_marine_03_idle_02;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_marine_04_idle_02"][0] = % shipcrib_hangar_c12_event_marine_04_idle_02;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_scar_01_idle_01"][0] = % shipcrib_hangar_c12_event_scar_01_idle_01;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_scar_02_idle_01"][0] = % shipcrib_hangar_c12_event_scar_02_idle_01;
  level._id_EC85["generic"]["shipcrib_hangar_c12_event_scar_02_idle_02"][0] = % shipcrib_hangar_c12_event_scar_02_idle_02;
  level._id_EC85["generic"]["shipcrib_drill_sargent_01"][0] = % shipcrib_drill_sargent_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_guyA_idle_01"][0] = % shipcrib_moon_injured_guya_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_drag02_guyC_idle_01"][0] = % shipcrib_moon_injured_drag02_guyc_idle_01;
  level._id_EC85["generic"]["shipcrib_moon_injured_table_01_A"][0] = % shipcrib_moon_injured_table_01_a;
  level._id_EC85["generic"]["shipcrib_moon_injured_table_01_B"][0] = % shipcrib_moon_injured_table_01_b;
  level._id_EC85["generic"]["shipcrib_armory_idle_01"][0] = % shipcrib_armory_idle_01;
  level._id_EC85["generic"]["shipcrib_marine_idle_01_B"][0] = % shipcrib_marine_idle_01_b;
  level._id_EC85["generic"]["shipcrib_marine_idle_01_A"][0] = % shipcrib_marine_idle_01_a;
  level._id_EC85["generic"]["shipcrib_hangar_phone_idle_02"][0] = % shipcrib_hangar_phone_idle_02;
  _id_ADC6();
}

_id_ADC6() {}

_id_CDE1() {
  scripts\engine\utility::flag_wait("shipcrib_europa_hangar_tr_loaded");

  if(level._id_10CDA == "europa start" || level._id_10CDA == "europa start dev") {
    var_0 = _id_0EF8::_id_FDFC("spawner_interior", "returndeck_walker1_start");
    var_1 = _id_0EF8::_id_FDFC("spawner_mech", "returndeck_walker2_start");
    var_2 = _id_0EF8::_id_FDFC("spawner_flightdeck_fuel", "returndeck_walker3_start");
    var_0 thread _id_0B6A::_id_EC0A("returndeck_walker1_end");
    wait 0.25;
    var_1 thread _id_0B6A::_id_EC0A("returndeck_walker2_end");
    wait 2;
    var_0 scripts\sp\utility::_id_13861("on", var_1);
    var_1 scripts\sp\utility::_id_13861("on", var_0);
    wait 2;
    var_1 thread scripts\sp\utility::_id_77A9(level._id_828C);
    var_2 thread _id_0B6A::_id_EC0A("returndeck_walker3_end");
    wait 1;
    var_0 thread scripts\sp\utility::_id_77B7("salute");
    wait 2;
    var_0 scripts\sp\utility::_id_13861("off", var_1);
    wait 5;
    _id_0EFB::_id_FDBA(var_0);
    _id_0EFB::_id_FDBA(var_1);
    wait 10;
    _id_0EFB::_id_FDBA(var_2);
  }
}

_id_174F() {
  self._id_247B = spawn("script_model", self.origin);
  self._id_247B setModel("p7_desk_metal_military_03_tablet");
  self._id_247B linkTo(self, "tag_inhand", (0, 0, 0), (0, 0, 0));
  self._id_247B thread _id_40A1(self);
}

_id_40A1(var_0) {
  var_0 waittill("death");

  if(isDefined(self))
    self delete();
}

_id_16CB() {
  self._id_247A = spawn("script_model", self.origin);
  self._id_247A setModel("equipment_industrial_power_drill_01");
  self._id_247A linkTo(self, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  self._id_247A thread _id_40A1(self);
}

_id_B34B() {
  self endon("death");
  scripts\engine\utility::flag_wait("marine_leader_start_vo");
  scripts\sp\utility::_id_10346("sc_europa_un3_okaygentlemen");
  scripts\sp\utility::_id_10346("sc_europa_un3_weregoingback");
  scripts\sp\utility::_id_10346("sc_europa_un3_butthoseassholes");
  scripts\sp\utility::_id_10346("sc_europa_un3_youregoingtohave");
}

_id_ADD3(var_0) {
  var_1 = ["spawner_flightdeck", "spawner_flightdeck_maintenance", "spawner_flightdeck_fuel"];
  var_2 = level._id_FD6E.jackals[var_0];
  var_3 = _id_0EF8::_id_FE01(var_1[randomintrange(0, 2)], "jackal_service_normal_spawnloc", "cheap");
  var_4 = _id_0EF8::_id_FE01(var_1[randomint(var_1.size)], "jackal_service_normal_spawnloc", "cheap");
  var_5 = _id_0EF8::_id_FE01(var_1[randomint(var_1.size)], "jackal_service_normal_spawnloc", "cheap");
  level thread _id_10AA::_id_A314(var_2, var_3, var_4, var_5);
}

_id_ADD4(var_0) {
  var_1 = level._id_FD6E.jackals[var_0];
  var_2 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "jackal_service_inaccessible_spawnloc", "cheap");
  var_3 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "jackal_service_inaccessible_spawnloc", "cheap");
  var_4 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "jackal_service_inaccessible_spawnloc", "cheap");
  var_5 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "jackal_service_inaccessible_spawnloc", "cheap");
  var_6 = _id_0EF8::_id_FE01("spawner_flightdeck_plane_captain", "jackal_service_inaccessible_spawnloc", "cheap");
  var_7 = _id_0EF8::_id_FE01("spawner_flightdeck_fuel", "jackal_service_inaccessible_spawnloc", "cheap");
  var_8 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "jackal_service_inaccessible_spawnloc", "cheap");
  var_9 = _id_0EF8::_id_FE01("spawner_flightdeck_plane_captain", "jackal_service_inaccessible_spawnloc", "cheap");
  level thread _id_10A9::_id_A314(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, undefined, var_9);
}

_id_408C() {
  level thread _id_10A9::_id_A315(_id_0EFB::_id_FD9C("jackal_service"));
}

_id_ADBC(var_0) {
  var_1 = level._id_FD6E._id_5EE3[var_0];
  var_2 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "dropship_service_ref", "cheap");
  var_3 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "dropship_service_ref", "cheap");
  var_4 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "dropship_service_ref", "cheap");
  var_5 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "dropship_service_ref", "cheap");
  var_6 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "dropship_service_ref", "cheap");
  var_7 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "dropship_service_ref", "cheap");
  var_8 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "dropship_service_ref", "cheap");
  level thread _id_10A5::_id_5E99(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

_id_406C() {
  level thread _id_10A5::_id_5E9A(_id_0EFB::_id_FD9C("dropship_service"));
}

_id_ADC2() {
  _id_10AB::_id_ADAD("sc_europa_ambient_lounge", ::_id_ADC3, ::_id_CD03);
  _id_10AC::_id_107D9("sc_europa_lounge_welders", "welding_high", "welding_sparks_small_heavy");
  thread _id_0EE9::_id_ADFC();
  level thread _id_E7EF();
  wait 1;
}

_id_4077() {
  _id_0EDB::_id_40C2();
  _id_0EFB::_id_FDBB("lounge");
  _id_0EFB::_id_FDBB("bridge_hall");
  wait 1;
}

_id_CD03(var_0) {
  var_1 = var_0["lounge_repairguy_01"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["lounge_repairguy_02"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 _id_174F();
  var_1 _id_0EE5::_id_202D();
  var_2 = var_0["lounge_repairguy_03"];
  var_2 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_3 = var_0["lounge_repairguy_04"];
  var_3 thread _id_10AB::_id_1F5E(0.0, 0.0);
  level thread _id_DB6A(var_2, var_3);
  var_1 = var_0["lounge_boxrepair"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["lounge_scrubber"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["lounge_driller"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 _id_16CB();
  var_1 = var_0["lounge_sweeper"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["lounge_tableguy_01"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  thread _id_0EF7::_id_DB77(var_1);
  var_1 = var_0["lounge_tableguy_02"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 = var_0["lounge_tableguy_03"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
}

_id_ADC3() {
  level._id_EC85["generic"]["shipcrib_inspection_idle"][0] = % shipcrib_inspection_idle;
  level._id_EC85["generic"]["SH3_15_EUR_ARM_HALL_JACK_idle"][0] = % sh3_15_eur_arm_hall_jack_idle;
  level._id_EC85["generic"]["shipcrib_bridge_micro_manage_idle_02"][0] = % shipcrib_bridge_micro_manage_idle_02;
  level._id_EC85["generic"]["Shipcrib_hangar_scrubbing_01_guy"][0] = % shipcrib_hangar_scrubbing_01_guy;
  level._id_EC85["generic"]["shipcrib_lounge_chess_idleA_01"][0] = % shipcrib_lounge_chess_idlea_01;
  level._id_EC85["generic"]["shipcrib_lounge_seated_table_idle_05_guyA"][0] = % shipcrib_lounge_seated_table_idle_05_guya;
  level._id_EC85["generic"]["shipcrib_lounge_seated_table_idle_05_guyB"][0] = % shipcrib_lounge_seated_table_idle_05_guyb;
  level._id_EC85["generic"]["shipcrib_lounge_sit_idle_02"][0] = % shipcrib_lounge_sit_idle_02;
  level._id_EC85["generic"]["shipcrib_lounge_sit_idle_03"][0] = % shipcrib_lounge_sit_idle_03;
  level._id_EC85["generic"]["shipcrib_hangar_drill_low_idle"][0] = % shipcrib_hangar_drill_low_idle;
  level._id_EC85["generic"]["shipcrib_hangar_sweeping_01_guy"][0] = % shipcrib_hangar_sweeping_01_guy;
  level._id_EC85["generic"]["shipcrib_europa_bridge_hall_repair_ladder_02"][0] = % shipcrib_europa_bridge_hall_repair_ladder_02;
  level._id_EC85["generic"]["shipcrib_europa_bridge_hall_repair_powerbox"][0] = % shipcrib_europa_bridge_hall_repair_powerbox;
  _id_ADC4();
}

#using_animtree("script_model");

_id_ADC4() {
  level._id_EC8C["broom"] = "equipment_push_broom_01";
  level._id_EC87["broom"] = #animtree;
  level._id_EC85["broom"]["shipcrib_hangar_sweeping_01_guy"][0] = % shipcrib_hangar_sweeping_01_broom;
  level._id_EC8C["brush"] = "misc_scrub_brush";
  level._id_EC87["brush"] = #animtree;
  level._id_EC85["brush"]["Shipcrib_hangar_scrubbing_01_guy"][0] = % shipcrib_hangar_scrubbing_01_brush;
}

_id_DB6A(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");

  for(;;) {
    if(var_1 scripts\sp\interaction_manager::_id_9EED(100) && scripts\engine\utility::flag_exist("hallway_vo_finished") && scripts\engine\utility::flag("hallway_vo_finished")) {
      wait 1.5;
      break;
    }

    scripts\engine\utility::waitframe();
  }

  var_1 _id_0EE9::_id_CD78("sc_europa_un1_imtellingyou");
  var_0 _id_0EE9::_id_CD78("sc_europa_un2_imnothearingitnow");
  var_0 _id_0EE9::_id_CD78("sc_europa_un2_illseeificanreinforce");
  var_1 _id_0EE9::_id_CD78("sc_europa_un2_getmethenext");
}

_id_E7EC() {}

_id_CD00() {}

_id_E7EF() {
  level thread _id_B0C3();
}

_id_B0C3() {
  _id_13560();
  _id_13559();
  var_0 = scripts\sp\utility::_id_10639("vr_rifle");
  var_1 = _id_0EF8::_id_FDFC("spawner_vr_user", "lounge_vr_1", "cheap");
  var_2 = scripts\engine\utility::getStruct("lounge_vr_1", "targetname");
  var_2 thread scripts\sp\anim::_id_1ECC(var_1, "vr_loop");
  var_2 thread scripts\sp\anim::_id_1EEA(var_0, "vr_loop");
  thread _id_E09B();
  var_1 waittill("death");
  var_0 delete();
}

_id_13560() {
  level._id_EC87["vr_goggles"] = #animtree;
  level._id_EC8C["vr_goggles"] = "vr_goggles_hero_xo";
  level._id_EC85["vr_goggles"]["vr_loop"][0] = % shipcrib_lounge_vr_goggles_loop;
  level._id_EC87["vr_rifle"] = #animtree;
  level._id_EC8C["vr_rifle"] = "weapon_vr_rifle_wm";
  level._id_EC85["vr_rifle"]["vr_loop"][0] = % shipcrib_lounge_vr_gun_loop;
}

#using_animtree("generic_human");

_id_13559() {
  level._id_EC85["generic"]["vr_loop"][0] = % shipcrib_lounge_vr_loop;
}

_id_E09B() {
  _id_0EE8::_id_FA5A();
}

_id_ADB1() {
  _id_10AB::_id_ADAD("sc_europa_ambient_armoryhallway", ::_id_ADBE, ::_id_CCFF);
}

_id_4054() {
  _id_10AB::_id_404E("armoryhallway");
}

_id_CCFF(var_0) {
  var_1 = var_0["armoryhallway_inventoryguy"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 _id_174F();
  var_1 = var_0["armoryhallway_inventoryguy2"];
  var_1 thread _id_10AB::_id_1F5E(0.0, 0.0);
  var_1 _id_174F();
}

_id_ADBE() {
  level._id_EC85["generic"]["shipcrib_inspection_idle"][0] = % shipcrib_inspection_idle;
  level._id_EC85["generic"]["shipcrib_inspection_90_low_idle"][0] = % shipcrib_inspection_90_low_idle;
}

_id_CD57() {
  var_0 = scripts\engine\utility::getStruct("ambient_inventory_look1", "targetname");
  var_1 = scripts\engine\utility::getStruct("ambient_inventory_look2", "targetname");
  var_2 = scripts\engine\utility::getStruct("ambient_inventory_look3", "targetname");
  var_3 = scripts\engine\utility::getStruct("ambient_inventory_look4", "targetname");
  var_4 = [var_0, var_1, var_2, var_3];
  var_5 = 1;

  while(var_5) {
    var_6 = randomint(4);
    thread scripts\sp\utility::_id_7799(var_4[var_6], 2.0, 1.5);
    wait(randomfloatrange(5, 6));
    scripts\sp\utility::_id_77B9(2);
    wait 2;
    wait 8;
  }
}

_id_1E0B() {
  level scripts\engine\utility::delaythread(21, ::_id_CDE1);
  scripts\engine\utility::flag_wait("shipcrib_europa_dropship_tr_loaded");
  level thread _id_0EF9::_id_FE03("dropship_cheap", "dropship_return_elevator");
  level thread _id_0EF9::_id_FE03("dropship_cheap", "dropship_return_bay_1");
  scripts\engine\utility::flag_wait_all("shipcrib_europa_hangar_tr_loaded", "shipcrib_europa_ambientmr_tr_loaded");
  _id_ADBC("dropship_return_bay_1");
  _id_8ABE();
  _id_10AB::_id_ADAD("sc_europa_ambient_returndeck", ::_id_ADC5, ::_id_CD04);
  _id_ADD4("jackal_bay_1");
  _id_ADD4("jackal_bay_2");
  _id_10AC::_id_ADAE("sc_europa_returndeck_welders");
}

_id_1E0A() {
  if(!scripts\engine\utility::flag("shipcrib_europa_ambientml_tr_loaded"))
    scripts\sp\utility::_id_12641("shipcrib_europa_ambientml_tr");
}

_id_1E0E() {
  if(!scripts\engine\utility::flag("shipcrib_europa_ambientml_tr_loaded"))
    scripts\sp\utility::_id_12641("shipcrib_europa_ambientml_tr");
}

_id_1E0D() {
  if(!scripts\engine\utility::flag("shipcrib_europa_ambientml_tr_loaded"))
    scripts\sp\utility::_id_12641("shipcrib_europa_ambientml_tr");
}

_id_8A8B(var_0) {
  level thread scripts\sp\maps\shipcrib_europa\shipcrib_europa::_id_490D();
  level thread _id_0EF9::_id_FE03("dropship", "dropship_bay_2");
  level thread _id_0EE4::_id_E399(level._id_E35D._id_AA5F["dropship_bay_1"]._id_5979, 0.05);
  level thread _id_0EE4::_id_E399(level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979, 0.05);
  _id_0EEB::_id_60FD("apc", "Flight Deck", 1);
  level thread _id_10AC::_id_ADAE("leaving_welder", "welding_sparks_hangar", "spawner_flightdeck_maintenance");
  _id_0EF9::_id_FE03("dropship", "dropship_bay_1");
  var_1 = level._id_FD6E._id_5EE3["dropship_bay_1"];
  var_1 _id_0BBF::_id_F452("loading", "sctitanload");
  var_1 scripts\engine\utility::delaythread(2, _id_0BBF::_id_F458);
  var_2 = level thread _id_10AC::_id_ADAE("leaving_welder_jackal", "welding_sparks_hangar_small", "spawner_flightdeck_ordnance");
  level._id_13CF0 = var_2[0];
  var_2 = level thread _id_10AC::_id_ADAE("leaving_welder_gantry", "welding_sparks_hangar", "spawner_flightdeck_maintenance");
  level._id_13CEE = var_2[0];
  level._id_13CEE scripts\engine\utility::delaythread(9, _id_10AC::_id_13CED);
  var_2 = level thread _id_10AC::_id_ADAE("leaving_welder_high", "welding_sparks_hangar", "spawner_flightdeck_maintenance");
  level._id_13CEF = var_2[0];
  level._id_13CEF scripts\engine\utility::delaythread(14, _id_10AC::_id_13CED);
  var_2 = level thread _id_10AC::_id_ADAE("leaving_welder_jackal_high", "welding_sparks_hangar", "spawner_flightdeck_maintenance");
  level._id_13CF1 = var_2[0];
  var_3 = _id_10A7::_id_8A6A("e3_hangar_hustle");

  foreach(var_5 in var_3) {
    if(isDefined(var_5.script_index)) {
      switch (var_5.script_index) {
        case 1:
          var_5 thread _id_10A7::_id_8A69(12.25);
          break;
        case 2:
          var_5 thread _id_10A7::_id_8A69(13.5);
          break;
        case 3:
          var_5 thread _id_10A7::_id_8A69(13, 1);
          break;
      }
    }
  }

  level thread _id_8A82();
  level thread _id_A0CD();
  level thread scripts\sp\maps\shipcrib_europa\shipcrib_europa::_id_A308();
  level thread _id_8A9B();
  level thread _id_8A92();
  level thread _id_8A94();
  level thread _id_8A88();
  level thread _id_8A98();
  level thread _id_8A95();
  level thread _id_8A97();
  level thread _id_8A8F();
  level thread _id_8A99();
  level thread _id_8A91("hangar_marine_idle_ml");
  level scripts\engine\utility::delaythread(1.5, ::_id_B358, "intro", "combat", "flight", "player_in_flight_elevator", 4);
  level scripts\engine\utility::delaythread(0.05, ::_id_1E0A);
  level._id_E35D._id_AA5F["jackal_bay_2"]._id_5979 thread _id_0EE0::_id_E3B9("open", 0.05);
  level._id_E35D._id_AA5F["jackal_bay_1"]._id_5979 thread _id_0EE0::_id_E3B9("open", 0.05);
  level._id_E35D._id_AA5F["jackal_bay_1"]._id_5979 scripts\engine\utility::delaythread(7, _id_0EE0::_id_E3B9, "close", 8);
  _id_0EEF::_id_15B0(["dropship_bay_1", "dropship_bay_2"], "air");
  _id_0EEF::_id_15B0(["dropship_bay_1", "dropship_bay_2"], "gasoline");
  _id_0EEF::_id_15B0(["dropship_bay_1", "dropship_bay_2"], "nitrogen");

  if(isDefined(level._id_8289)) {
    level thread _id_8A81();
    level thread _id_B35B("forklift", "casual_gun");
    level scripts\engine\utility::delaythread(14, ::_id_8A9C);
    level thread scripts\engine\utility::flag_set_delayed("hangar_leaving_apc_move", 0);
    level scripts\engine\utility::delaythread(0, ::_id_B358, "apc", "casual_gun", "jackal", "player_in_jackal_elevator", 5);
  } else {
    level thread _id_5F9F();
    level thread _id_B358("apc", "casual_gun", "jackal", "player_in_jackal_elevator", 5);
    level thread scripts\engine\utility::flag_set_delayed("hangar_leaving_apc_move", 0);
  }

  switch (var_0) {
    case "airboss":
      break;
    case "armory":
      break;
    case "fast_travel":
      break;
  }
}

_id_A0CD() {
  var_0 = ["spawner_flightdeck_maintenance", "spawner_flightdeck_maintenance", "spawner_flightdeck_handler", "spawner_flightdeck_maintenance", "spawner_flightdeck_plane_captain"];
  var_1 = ["jackal_bay_fod_01_a", "jackal_bay_fod_02_b", "jackal_bay_fod_01_b", "jackal_bay_fod_02_c", "jackal_bay_fod_02_d"];

  foreach(var_7, var_3 in var_1) {
    var_4 = _id_0EF8::_id_FE01(var_0[var_7], var_3, "cheap");
    var_5 = scripts\engine\utility::getStruct(var_3, "targetname");
    var_4 _id_0EFB::_id_FD6F("jackal_fod_guys");
    var_5 thread scripts\sp\anim::_id_1ECC(var_4, var_5.animation);
    var_6 = 0.6;
    var_4 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_4 scripts\sp\utility::_id_7DC1(var_5.animation)[0], var_6);
  }

  var_4 = _id_0EF8::_id_FE01("spawner_flightdeck_director", "jackal_bay_fod_manager", "cheap");
  var_5 = scripts\engine\utility::getStruct("jackal_bay_fod_manager", "targetname");
  var_8 = scripts\sp\utility::_id_10639("fod_tablet", var_5.origin, var_5.angles);
  var_4._id_1DF7 = var_8;
  var_4 thread _id_0EE5::_id_202D();
  var_4 _id_0EFB::_id_FD6F("jackal_fod_guys");
  var_5 thread scripts\sp\anim::_id_1ECC(var_4, "shipcrib_hangar_fod_walk_manager01");
  var_5 thread scripts\sp\anim::_id_1EEA(var_8, "shipcrib_hangar_fod_walk_manager01_tablet");
}

_id_8A82() {
  level._id_E35D._id_47D9._id_67A7 = _id_0EFB::_id_7CBE("hangar_crane_pos", "targetname", "europa_leaving");
  level._id_E35D._id_47D9 moveTo(level._id_E35D._id_47D9._id_67A7.origin, 0.05);
  level _id_0EDF::_id_E38E("basket_open", 0.05);
  wait 0.05;
  var_0 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", level._id_E35D._id_47DC._id_EF68, "cheap");
  var_0 linkTo(level._id_E35D._id_47DC._id_EF68);
  level._id_E35D._id_47DC._id_EF68 thread scripts\sp\anim::_id_1ECC(var_0, "shipcrib_hangar_crane_load_B_guy02_exit");
  var_0 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", level._id_E35D._id_47DC._id_EF68, "cheap");
  var_0 linkTo(level._id_E35D._id_47DC._id_EF68);
  level._id_E35D._id_47DC._id_EF68 thread scripts\sp\anim::_id_1ECC(var_0, "shipcrib_hangar_crane_load_C_guy01_exit");
  var_1 = scripts\sp\utility::_id_10639("ammo_crate");
  level._id_E35D._id_47DC._id_EF68 thread scripts\sp\anim::_id_1EEA(var_1, "shipcrib_hangar_crane_load_B_box01_exit");
  var_1 linkTo(level._id_E35D._id_47DC._id_EF68);
  var_1 = scripts\sp\utility::_id_10639("ammo_crate");
  level._id_E35D._id_47DC._id_EF68 thread scripts\sp\anim::_id_1EEA(var_1, "shipcrib_hangar_crane_load_B_box02_exit");
  var_1 linkTo(level._id_E35D._id_47DC._id_EF68);
  var_1 = scripts\sp\utility::_id_10639("ammo_crate");
  level._id_E35D._id_47DC._id_EF68 thread scripts\sp\anim::_id_1EEA(var_1, "shipcrib_hangar_crane_load_C_box01_exit");
  var_1 linkTo(level._id_E35D._id_47DC._id_EF68);
  var_1 = scripts\sp\utility::_id_10639("ammo_crate");
  level._id_E35D._id_47DC._id_EF68 thread scripts\sp\anim::_id_1EEA(var_1, "shipcrib_hangar_crane_load_C_box02_exit");
  var_1 linkTo(level._id_E35D._id_47DC._id_EF68);
  level _id_0EDF::_id_E38E("basket_closed", 2);
  level _id_0EDF::_id_E38E("up", 8);
  wait 2;
  level _id_0EDF::_id_E38E("unload", 30);
  level _id_0EDF::_id_E38E("basket_open_unload", 5);
}

_id_8A9B() {
  var_0 = _id_0EF9::_id_FE03("towcart", "leaving_towcart_a");
  var_0 endon("entitydeleted");
  var_0._id_ED6C = 1;
  var_0._id_EEFC = 0;
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_director", var_0, "cheap");
  var_1._id_EEC9 = 1;
  var_0 thread scripts\sp\vehicle_aianim::_id_8739(var_1);
  var_1 = _id_0EF8::_id_FE01("spawner_marine", var_0, "cheap");
  var_1._id_EEC9 = 2;
  var_0 thread scripts\sp\vehicle_aianim::_id_8739(var_1);
  var_0 thread _id_0EFA::_id_11A4F();
  wait 0.1;
  var_0 _id_0EFA::_id_11A4E("leaving_towcart_a");
  wait 0.25;
  level thread _id_0EEB::_id_60F0("magazine", 25);
  scripts\engine\utility::flag_waitopen("towcart_elevator_clear");
  level._id_E35D._id_B147 solid();
  level thread _id_0EEB::_id_60FD("magazine", "Storage");
}

_id_8A9C() {
  var_0 = _id_0EF9::_id_FE03("towcart", "leaving_towcart_b");
  var_0 endon("entitydeleted");
  var_0._id_ED6C = 1;
  var_0._id_EEFC = 0;
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", var_0, "cheap");
  var_1._id_EEC9 = 1;
  var_0 thread scripts\sp\vehicle_aianim::_id_8739(var_1);
  var_1 = _id_0EF8::_id_FE01("spawner_marine", var_0, "cheap");
  var_1._id_EEC9 = 2;
  var_0 thread scripts\sp\vehicle_aianim::_id_8739(var_1);
  var_0 thread _id_0EFA::_id_11A4F();
  wait 0.1;
  wait 11;
  var_0 _id_0EFA::_id_11A4E("leaving_towcart_b");
  wait 2;
}

_id_8A92() {
  var_0 = _id_0EF9::_id_FE03("forklift", "leaving_forklift_a_load");
  var_0 endon("entitydeleted");
  var_0 thread _id_0EED::_id_730B();
  var_0 _id_0EED::_id_730A("leaving_forklift_a_load");
  var_0 _id_0EED::_id_7309("leaving_forklift_a_cargo");
  wait 1.5;
  var_0 _id_0EED::_id_730A("leaving_forklift_a");
  wait 1;
  scripts\engine\utility::flag_waitopen("player_in_apc_elevator");
  level thread _id_0EEB::_id_60F0("apc", 35);
  level _id_0EEB::_id_60FD("apc", "Storage");
  _id_0EEB::_id_7976("apc") waittill("move_finished");
  var_1 = getnode("storage_death_apc", "targetname");
  var_1 thread scripts\sp\anim::_id_1ED0(level._id_3598, "stand_idle", undefined, "Exposed");
  var_0 _id_0EED::_id_730A("leaving_forklift_a_deathmarch");
  level thread _id_0EEB::_id_60FD("apc", "Catwalks");
  var_0 delete();
}

_id_8A93() {
  var_0 = _id_0EF9::_id_FE03("forklift", "leaving_forklift_a");
  var_0 endon("entitydeleted");
  wait 0.1;
  var_0 _id_0EED::_id_730A("leaving_forklift_b");
}

_id_8A94() {
  var_0 = _id_0EF9::_id_FE03("forklift", "leaving_forklift_top");
  var_0 endon("entitydeleted");
  wait 0.1;
  var_0 _id_0EED::_id_730A("leaving_forklift_top");
  var_0 _id_0EED::_id_7309("leaving_forklift_top_cargo");
  var_0 _id_0EED::_id_730A("leaving_forklift_top_return");
}

_id_8A8F() {
  var_0 = _id_0EF9::_id_FE03("apc", "leaving_apc_a");
  var_1 = _id_0EF9::_id_FE03("apc", "leaving_apc_b");
  var_2 = _id_0EF9::_id_FE03("apc", "apc_load_b");
  var_0 endon("death");
  var_1 endon("death");
  var_2 endon("death");
  var_3 = getvehiclenode("leaving_apc_a", "targetname");
  var_0 thread scripts\sp\vehicle::_id_1321A(var_3);
  var_0 startpath(var_3);
  var_0 thread scripts\vehicle\apache::_id_205C();
  var_3 = getvehiclenode("leaving_apc_b", "targetname");
  var_1 thread scripts\sp\vehicle::_id_1321A(var_3);
  var_1 startpath(var_3);
  var_1 thread scripts\vehicle\apache::_id_205C();
  var_3 = getvehiclenode("apc_load_b", "targetname");
  var_2 thread scripts\sp\vehicle::_id_1321A(var_3);
  var_2 startpath(var_3);
  var_2 thread scripts\vehicle\apache::_id_205C();
  level scripts\engine\utility::flag_wait("hangar_leaving_apc_move");
  _id_0EEB::_id_7976("jackal") waittill("move_finished");
  wait 4.5;
  var_3 = getvehiclenode("leaving_apc_a_deathmarch", "targetname");
  var_0 thread scripts\sp\vehicle::_id_1321A(var_3);
  var_0 startpath(var_3);
  var_3 = getvehiclenode("leaving_apc_b_deathmarch", "targetname");
  var_1 thread scripts\sp\vehicle::_id_1321A(var_3);
  var_1 startpath(var_3);
  var_1 waittill("reached_end_node");
  var_0 delete();
  var_1 delete();
  level _id_0EEB::_id_60FD("jackal", "Flight Deck");
}

_id_8A81() {
  var_0 = getEnt("spawner_c12_b", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1 _id_0EFB::_id_FD6F("c12");
  var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_1 scripts\sp\utility::_id_51E1("casual");
  var_1 setCanDamage(0);
  var_2 thread scripts\sp\anim::_id_1ED0(var_1, "stand_idle", undefined, "Exposed");

  if(isDefined(level._id_8289)) {
    var_0 = getEnt("spawner_c12_e3_b", "targetname");
    var_1 = var_0 scripts\sp\utility::_id_10619(1);
    var_1 _id_0EFB::_id_FD6F("c12");
    level._id_3598 = var_1;
    var_2 = scripts\engine\utility::getStruct("spawner_c12_e3_b_goal", "targetname");
    var_1 scripts\sp\utility::_id_51E1("casual");
    var_2 scripts\engine\utility::delaythread(10, scripts\sp\anim::_id_1ED0, var_1, "stand_idle", undefined, "Exposed");
  }

  var_0 = getEnt("spawner_c12", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1 _id_0EFB::_id_FD6F("c12");
  level._id_3508 = var_1;
  var_2 = scripts\engine\utility::getStruct("c12_first_goal", "targetname");
  var_1 scripts\sp\utility::_id_51E1("casual");
  var_1.disablearrivals = 1;
  var_1.goalradius = 192;
  var_1 setgoalpos(var_2.origin);
  var_1 waittill("goal");
  scripts\engine\utility::flag_set("c12_clear");
  var_1.disablearrivals = 0;
  var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  var_3 scripts\sp\anim::_id_1ED0(var_1, "stand_idle", undefined, "Exposed");
}

_id_5F9F() {
  var_0 = getEnt("spawner_c12_b", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1 _id_0EFB::_id_FD6F("c12");
  var_1.name = "";
  var_1 setCanDamage(0);
  var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_1 scripts\sp\utility::_id_51E1("casual");
  var_2 thread scripts\sp\anim::_id_1ED0(var_1, "stand_idle", undefined, "Exposed");
  var_0 = getEnt("spawner_c12_e3", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1 _id_0EFB::_id_FD6F("c12");
  level._id_3508 = var_1;
  var_1.name = "";
  var_1 setCanDamage(0);
  var_2 = scripts\engine\utility::getStruct("c12_first_goal", "targetname");
  var_1 scripts\sp\utility::_id_51E1("casual");
  var_1 scripts\sp\utility::_id_F492(0.9);
  var_1.disablearrivals = 1;
  var_1.goalradius = 192;
  var_1 setgoalpos(var_2.origin);
  var_1 waittill("goal");
  scripts\engine\utility::flag_set("c12_clear");
  var_1.disablearrivals = 0;
  var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  var_3 scripts\sp\anim::_id_1ED0(var_1, "stand_idle", undefined, "Exposed");
}

_id_8A88() {
  _id_0EA0::main();
  _id_0E9E::main();
  _id_0E88::main();
  var_0 = scripts\engine\utility::getStructArray("hangar_reaction", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = _id_0EF8::_id_FE01("spawner_flightdeck_plane_captain", var_2, "cheap");
    var_3 thread scripts\sp\interaction::_id_DE14(300);
  }

  var_2 = scripts\engine\utility::getStruct("hangar_reaction_bay2", "script_noteworthy");
  var_3 = _id_0EF8::_id_FE01("spawner_flightdeck_director", var_2, "cheap");
  var_5 = ["shipcrib_un2_yourjackalsupon", "shipcrib_plr_thankschief"];
  var_3 thread _id_0EE5::_id_202D("shipcrib_stand_point_left_01", ["shipcrib_un2_yourjackalsupon"]);
  var_3 scripts\engine\utility::delaythread(0.5, scripts\sp\interaction::_id_DE14, 400);
  var_2 = scripts\engine\utility::getStruct("hangar_reaction_bay3", "script_noteworthy");
  var_3 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", var_2, "cheap");
  var_3 thread _id_0EE5::_id_202D("shipcrib_guard_reaction_idle_01", ["shipcrib_unf1_sir", "shipcrib_plr_asyouwere"]);
  var_3 scripts\engine\utility::delaythread(0.5, scripts\sp\interaction::_id_DE14, 170);
  var_2 = scripts\engine\utility::getStruct("hangar_reaction_bay4", "script_noteworthy");
  var_3 = _id_0EF8::_id_FE01("spawner_flightdeck_director", var_2, "cheap");
  var_3 thread _id_0EE5::_id_202D("shipcrib_salute_reaction_idle_01", ["shipcrib_un3_captain"]);
  var_3 scripts\engine\utility::delaythread(0.5, scripts\sp\interaction::_id_DE14, 450);
}

#using_animtree("jackal");

_id_8A98() {
  var_0 = _id_0EF9::_id_FE03("jackal_cheap", "hangar_leaving_jackal_move_veh", undefined, undefined, 1);
  var_1 = getEnt("hangar_leaving_jackal_move_veh", "targetname");
  var_0 linkTo(var_1);
  var_2 = getvehiclenode(var_1.target, "targetname");
  var_1 startpath(var_2);
  wait 1.5;
  var_1 playSound("shipcrib_europa_jackal_pull_in_shutdown");
  setmusicstate("mx_370b_flightdeck");
  var_1 waittill("reached_end_node");
  level notify("moving jackal stopped");
  var_1 scripts\engine\utility::delaycall(randomfloatrange(0.5, 2), ::playsound, "shipcrib_europa_jackal_pull_in_hatches");
  var_0 scripts\engine\utility::delaycall(randomfloatrange(0.5, 2), ::_meth_82A2, %shipcrib_veh_jackal_lean_hatch_center_open, 1, 0, 0.25);
  var_0 scripts\engine\utility::delaycall(randomfloatrange(0.5, 2), ::_meth_82A2, %shipcrib_veh_jackal_lean_hatch_left_open, 1, 0, 0.25);
  var_0 scripts\engine\utility::delaycall(randomfloatrange(0.5, 2), ::_meth_82A2, %shipcrib_veh_jackal_lean_hatch_right_open, 1, 0, 0.25);
  var_0 scripts\engine\utility::delaycall(randomfloatrange(0.5, 2), ::_meth_82A2, %shipcrib_veh_jackal_lean_hatch_top_open, 1, 0, 0.25);
}

_id_8A95() {
  level._id_E35D._id_AA5F["jackal_bay_1"]._id_7691 thread _id_0EE4::_id_A25C("max_raised", 0.05);
  var_0 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", level._id_E35D._id_AA5F["jackal_bay_2"]._id_7691._id_45D5, "cheap");
  var_0 linkTo(level._id_E35D._id_AA5F["jackal_bay_2"]._id_7691, "tag_platform");
  var_0 thread scripts\sp\anim::_id_1ECC(var_0, "shipcrib_standing_console_idle_02", "stop_loop");
  level._id_E35D._id_AA5F["jackal_bay_2"]._id_7691 thread _id_0EE4::_id_A25C("unload_ground", 0.05);
  scripts\engine\utility::flag_wait("player_near_gantry_2");
  level._id_E35D._id_AA5F["jackal_bay_2"]._id_7691 thread _id_0EE4::_id_A25C("unload", 5.0);
}

_id_B34F(var_0, var_1) {
  var_2 = _id_0EF8::_id_FDFC("spawner_marine", var_1);
  var_2 scripts\sp\utility::_id_86E2();
  var_2 scripts\sp\utility::_id_51E1(var_0);
  var_2.moveplaybackrate = 1;
  var_2.ignoreall = 1;
  var_2.goalradius = 16;
  var_2 _meth_84E5(0.5);
  return var_2;
}

_id_B358(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_0EFB::_id_7CC0("marine_moving", "targetname", var_0);
  var_6 = undefined;

  foreach(var_8 in var_5) {
    var_6 = _id_B34F(var_1, var_8);
    var_6 _meth_82EE(getnode(var_8.target, "targetname"));

    if(isDefined(var_2)) {
      var_9 = _id_0EEB::_id_7976(var_2);
      var_6 thread _id_600A(var_9, var_2);
    }
  }

  if(isDefined(var_2)) {
    var_9 = _id_0EEB::_id_7976(var_2);
    var_9 thread _id_60AB(var_2, var_4, "Storage", var_3);
  }
}

_id_600A(var_0, var_1) {
  self endon("death");
  self waittill("goal");
  var_0 notify("goal_notified");
  var_0 waittill("move_finished");

  if(!isDefined(var_1))
    var_1 = "jackal";

  var_2 = getnode("storage_death_" + var_1, "targetname");
  self setgoalpos(var_2.origin);
  self waittill("goal");

  if(isDefined(self._id_B14F))
    scripts\sp\utility::_id_1101B();

  _id_0EFB::_id_FDBA(self);
}

_id_60AB(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; var_4 < var_1; var_4++)
    self waittill("goal_notified");

  wait 1;
  scripts\engine\utility::flag_waitopen(var_3);
  level thread _id_0EEB::_id_60F0(var_0, 35);
  level _id_0EEB::_id_60FD(var_0, var_2);
}

_id_B35B(var_0, var_1, var_2, var_3) {
  var_4 = _id_0EFB::_id_7CC0("marine_moving", "targetname", var_0);
  var_5 = undefined;

  foreach(var_7 in var_4) {
    var_5 = _id_B34F(var_1, var_7);
    var_8 = scripts\engine\utility::getStruct(var_7.target, "targetname");
    var_5 thread _id_0B6A::_id_EC0A(var_8);
  }
}

_id_8A91(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_4 = undefined;
    var_5 = randomint(3);

    switch (var_5) {
      case 0:
        var_4 = "spawner_pilot";
        break;
      default:
        var_4 = "spawner_marine";
        break;
    }

    var_6 = _id_0EF8::_id_FE01(var_4, var_3, "cheap");
    var_6 _id_0EFB::_id_FD6F("hangar_leaving_crew");
    var_6 thread _id_0EE5::_id_202D();

    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "hasgun")
      var_6 attach(getweaponmodel("iw7_m4"), "tag_weapon_right");

    var_3 thread scripts\sp\anim::_id_1ECC(var_6, var_3.animation, "stop_loop");
    var_6 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_6 scripts\sp\utility::_id_7DC1(var_3.animation)[0], randomfloatrange(0, 1));
  }
}

_id_8A97() {
  var_0 = scripts\engine\utility::getStructArray("hangar_inspector", "targetname");

  foreach(var_2 in var_0) {
    var_3 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", var_2, "cheap");
    var_3 _id_0EFB::_id_FD6F("hangar_leaving_crew");
    var_3 attach("p7_desk_metal_military_03_tablet", "tag_inhand");
    var_3 thread _id_0EE5::_id_202D();
    var_3 thread _id_8A96(var_2);
  }
}

_id_8A96(var_0) {
  self endon("death");
  scripts\engine\utility::delaycall(0.05, ::_meth_82B0, scripts\sp\utility::_id_7DC1("shipcrib_inspection_90_high_idle"), randomfloatrange(0, 1));

  for(;;) {
    var_0 scripts\sp\anim::_id_1EC7(self, "shipcrib_inspection_90_high_idle");
    var_0 scripts\sp\anim::_id_1EC7(self, "shipcrib_inspection_90_low_idle");
  }
}

_id_8A99() {
  var_0 = scripts\engine\utility::getStruct("hangar_nitrogen_inspector", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_handler", "hangar_nitrogen_inspector", "cheap");
  var_1 _id_0EFB::_id_FD6F("hangar_leaving_crew");
  var_1 thread _id_0EE5::_id_202D();
  var_1 endon("death");
  var_0 scripts\sp\anim::_id_1ECA(var_1, "shipcrib_hangar_nitro_term_serv_01_raise");
  var_1 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_ramp_agent_loop", "stop_loop");
  level waittill("moving jackal stopped");
  var_0 notify("stop_loop");
  var_1 scripts\sp\anim::_id_1EC7(var_1, "shipcrib_hangar_ramp_agent_exit");
  level scripts\engine\utility::delaythread(2, _id_0EEF::_id_15B0, ["jackal_bay_1"], "nitrogen");
  var_0 scripts\sp\anim::_id_1EC7(var_1, "shipcrib_hangar_nitro_term_serv_01_raise");

  for(;;) {
    var_0 scripts\sp\anim::_id_1EC7(var_1, "shipcrib_hangar_nitro_term_serv_01_loop_01");
    var_0 scripts\sp\anim::_id_1EC7(var_1, "shipcrib_hangar_nitro_term_serv_01_loop_02");
  }
}

_id_8A8E() {
  var_0 = _id_0EF8::_id_FE01("spawner_flightdeck_handler", "leaving_apc_director", "cheap");
  var_0 thread scripts\sp\anim::_id_1ECC(var_0, "shipcrib_hangar_ramp_agent_loop", "stop_loop");
}

_id_8A90() {
  var_0 = scripts\engine\utility::getStruct("hangar_leaving_c12_event_guy1", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_shooter", "hangar_leaving_c12_event_guy1", "cheap");
  var_1 thread _id_0EE5::_id_202D();
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_c12_event_spectator_06_idle_01", "stop_loop");
  var_2 = scripts\engine\utility::getStruct("hangar_leaving_c12_event_guy2", "targetname");
  var_3 = _id_0EF8::_id_FE01("spawner_flightdeck_fuel", "hangar_leaving_c12_event_guy2", "cheap");
  var_3 thread _id_0EE5::_id_202D();
  var_2 thread scripts\sp\anim::_id_1ECC(var_3, "shipcrib_hangar_c12_event_spectator_07_idle_01", "stop_loop");

  while(!isDefined(level._id_3508))
    scripts\engine\utility::waitframe();

  var_1 endon("death");
  var_3 endon("death");
  level._id_3508 endon("death");

  while(distance2dsquared(level._id_3508.origin, var_1.origin) > 184900)
    scripts\engine\utility::waitframe();

  var_0 notify("stop_loop");
  var_2 notify("stop_loop");
  var_0 thread scripts\sp\anim::_id_1EC7(var_1, "shipcrib_hangar_c12_event_spectator_06_reveal");
  var_2 scripts\sp\anim::_id_1EC7(var_3, "shipcrib_hangar_c12_event_spectator_07_reveal");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_c12_event_spectator_06_idle_02", "stop_loop");
  var_2 thread scripts\sp\anim::_id_1ECC(var_3, "shipcrib_hangar_c12_event_spectator_07_idle_02", "stop_loop");
}