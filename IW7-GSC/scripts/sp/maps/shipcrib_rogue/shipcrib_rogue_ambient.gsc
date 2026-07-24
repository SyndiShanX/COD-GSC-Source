/*********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_ambient.gsc
*********************************************************************/

_id_1DBF() {
  scripts\engine\utility::flag_init("forklift_a_go");
  scripts\engine\utility::flag_init("forklift_a_waiting_at_elevator");
  scripts\engine\utility::flag_init("forklift_a_send_to_elevator");
  scripts\engine\utility::flag_init("forklift_b_go");
  scripts\engine\utility::flag_init("forklift_b_waiting_at_elevator");
  scripts\engine\utility::flag_init("forklift_b_send_to_elevator");
  precachemodel("vr_goggles_hero_xo");
  precachemodel("weapon_vr_rifle_wm");
  precachemodel("veh_mil_air_un_jackal_landed_03b");
  _id_10A5::_id_5E9B();
  scripts\engine\utility::flag_wait_all("shipcrib_rogue_prime_in_tr_loaded");
  level thread _id_1E07();
  level thread _id_1DFF();
  level thread _id_1DFE();
  level thread _id_1E01();
}

_id_1E07() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_returne");

    if(scripts\engine\utility::flag("shipcrib_rogue_ambientmr_tr_loaded")) {
      scripts\sp\utility::_id_1264E("shipcrib_rogue_ambientmr_tr");
    }

    _id_0EE4::_id_6E5E("ambient_zone_returne");
  }
}

_id_1DFF() {
  for(;;) {
    scripts\engine\utility::flag_wait("ambient_zone_bridgef");
    _id_0EF7::_id_ADF6();
    _id_0EF7::_id_ADFA("base_rogue");
    _id_0EE4::_id_6E5D("ambient_zone_bridgef");
    _id_0EF7::_id_40C0();
    _id_0EF7::_id_40C1("base_rogue");
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
  _id_0E69::main();
  _id_0E8F::main();
  _id_0E83::main();
  scripts\engine\utility::flag_wait("shipcrib_rogue_halore_tr_loaded");
  var_0 = "spawner_interior";
  var_1 = _id_10AC::_id_107D9("lounge_ambient_welder1", "welding_low");
  var_1 = _id_10AC::_id_107D9("lounge_ambient_welder2", "welding_high");
  var_1 = _id_0EF8::_id_FE01(var_0, "lounge_ambient_sit1", "cheap");
  var_1 thread _id_0EE5::_id_202D("shipcrib_lounge_sit_01", "sc_rogue_un3_getsomerrwhen");
  level waittill("kill_bridge_ai");
  _id_0EFB::_id_FDBB("lounge");
}

_id_B0C3() {
  _id_13560();
  _id_13559();
  var_0 = scripts\sp\utility::_id_10639("vr_goggles");
  var_1 = scripts\sp\utility::_id_10639("vr_rifle");
  var_2 = _id_0EF8::_id_FE01("spawner_vr_user", "lounge_vr_1", "cheap");
  var_3 = [var_0, var_1];
  var_4 = scripts\engine\utility::getStruct("lounge_vr_1", "targetname");
  var_4 thread scripts\sp\anim::_id_1ECC(var_2, "vr_loop");
  var_4 thread scripts\sp\anim::_id_1EE7(var_3, "vr_loop");
  var_2 waittill("death");
  var_0 delete();
  var_1 delete();
}

#using_animtree("script_model");

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

_id_1E0B() {
  if(!scripts\engine\utility::flag("shipcrib_rogue_ambientmr_tr_loaded")) {
    scripts\sp\utility::_id_12641("shipcrib_rogue_ambientmr_tr");
  }
}

_id_1E0A() {
  if(!scripts\engine\utility::flag("shipcrib_rogue_ambientml_tr_loaded")) {
    scripts\sp\utility::_id_12641("shipcrib_rogue_ambientml_tr");
  }
}

_id_1E0E() {
  if(!scripts\engine\utility::flag("shipcrib_rogue_ambientml_tr_loaded")) {
    scripts\sp\utility::_id_12641("shipcrib_rogue_ambientml_tr");
  }
}

_id_1E0D() {
  if(!scripts\engine\utility::flag("shipcrib_rogue_ambientml_tr_loaded")) {
    scripts\sp\utility::_id_12641("shipcrib_rogue_ambientml_tr");
  }
}

#using_animtree("jackal");

_id_8A80() {
  level thread scripts\sp\maps\shipcrib_rogue\shipcrib_rogue::_id_2403();
  _id_0E80::main();
  _id_0E85::main();
  level thread _id_0EEF::_id_15B0(["jackal_bay_3"], "air");
  level thread _id_0EEF::_id_15B0(["jackal_bay_3"], "gasoline");
  level thread _id_0EF9::_id_FE03("dropship_cheap", "dropship_return_elevator");
  level thread _id_0EF9::_id_FE03("jackal_cheap", "jackal_bay_2", undefined, undefined, 1);
  level thread _id_10A3::_id_3B9D(1, 1, 1, 1, 1, 1, 1, 0, 0, 0);
  level thread _id_10A2::_id_1A5D(1, 0);
  var_0 = level._id_FD6E._id_5EE3["dropship_return_elevator"];
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "dropship_service_ref", "cheap");
  var_2 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "dropship_service_ref", "cheap");
  var_3 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "dropship_service_ref", "cheap");
  level thread _id_10A5::_id_5E99(var_0, undefined, undefined, undefined, var_1, var_2, undefined, var_3);
  var_4 = ["spawner_flightdeck", "spawner_flightdeck_maintenance", "spawner_flightdeck_fuel"];
  var_5 = level._id_FD6E.jackals["jackal_bay_2"];
  var_6 = _id_0EF8::_id_FE01(var_4[randomintrange(0, 2)], "jackal_service_normal_spawnloc", "cheap");
  var_7 = _id_0EF8::_id_FE01(var_4[randomint(var_4.size)], "jackal_service_normal_spawnloc", "cheap");
  level thread _id_10AA::_id_A314(var_5, var_6, var_7);
  var_5 _meth_82A2(%shipcrib_veh_jackal_lean_canopy_opened_hold, 1, 0);
  _id_0EEB::_id_60FD("apc", "Catwalks", 1);
  level thread _id_A1E4();
  level thread _id_A36F();
  level thread _id_11A48();
  level thread _id_35B8();
  level thread _id_A0CD();
  level thread _id_8ACF();
  level thread _id_8A7B();
  level thread _id_8A23();
  level thread _id_208C();
  level thread _id_BFD7();
  level thread _id_8AB3();
  level thread _id_E38B();
  level thread _id_8A92();
  level thread _id_8A93();
  level thread _id_8A67();
  level thread _id_1A72();
}

_id_1A72() {
  level waittill("airboss_door_scene_start");
  var_0 = _id_0EFB::_id_FD9C("catwalks");
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_armory"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_secA"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_sec1A"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_sec1B"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_sec2A"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_sec2B"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_sec3A"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_sec3B"));

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_1DF6)) {
      var_2._id_1DF6 notify("ambient_idle_scene_end");
    }
  }

  _id_0EFB::_id_FDBB("catwalks_armory");
  _id_0EFB::_id_FDBB("catwalks_secA");
  _id_0EFB::_id_FDBB("catwalks_sec1A");
  _id_0EFB::_id_FDBB("catwalks_sec1B");
  _id_0EFB::_id_FDBB("catwalks_sec2A");
  _id_0EFB::_id_FDBB("catwalks_sec2B");
  _id_0EFB::_id_FDBB("catwalks_sec3A");
  _id_0EFB::_id_FDBB("catwalks_sec3B");
}

_id_35B8() {
  wait 5;
  var_0 = getspawner("spawner_c12", "targetname");
  level._id_359C = var_0 scripts\sp\utility::_id_10619(1);
  level._id_359C._id_1FBB = "c12";
  level._id_359C.name = "";
  level._id_359C.ignoreall = 1;
  level._id_359C setCanDamage(0);
  level._id_359C thread _id_35F7();
  var_1 = scripts\engine\utility::getStruct("c12_maintenance_guys", "targetname");
  var_2 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "c12_maintenance_guys", "cheap");
  var_2 _id_0EFB::_id_FD6F("c12_guys");
  var_3 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "c12_maintenance_guys", "cheap");
  var_3 _id_0EFB::_id_FD6F("c12_guys");
  var_1 thread scripts\sp\anim::_id_1ECC(var_2, "shipcrib_console_serv_01_A");
  var_1 thread scripts\sp\anim::_id_1ECC(var_3, "shipcrib_console_serv_01_B");
  level thread _id_35B9(var_2, var_3);
  level thread _id_361D("c12_watcher_spectator_01_02", "spawner_flightdeck_ordnance", "shipcrib_hangar_c12_event_spectator_01", 0, 0);
  level thread _id_361D("c12_watcher_spectator_01_02", "spawner_flightdeck_handler", "shipcrib_hangar_c12_event_spectator_02", 0, 0);
  level thread _id_361D("c12_watcher_spectator_06_07", "spawner_flightdeck_fuel", "shipcrib_hangar_c12_event_spectator_06", 0, 1);
  level thread _id_361D("c12_watcher_spectator_06_07", "spawner_flightdeck_handler", "shipcrib_hangar_c12_event_spectator_07", 0, 0);
  level thread _id_361D("c12_watcher_scar_01_02", "spawner_pilot", "shipcrib_hangar_c12_event_scar_01", 1, 0);
  level thread _id_361D("c12_watcher_scar_01_02", "spawner_pilot", "shipcrib_hangar_c12_event_scar_02", 1, 1);
}

_id_35B9(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");

  for(;;) {
    wait 2;
    var_0 thread scripts\sp\utility::_id_10346("shipcrib_crw1_nopetheeyeisn");
    wait 3;
    var_0 thread scripts\sp\utility::_id_10346("shipcrib_crw1_seethattryrunnin");
    var_1 scripts\engine\utility::delaythread(4, scripts\sp\utility::_id_10346, "shipcrib_crw2_alrightletsgetgi");
    wait 8;
    var_0 thread scripts\sp\utility::_id_10346("shipcrib_crw1_overridegearcon");
    var_1 scripts\engine\utility::delaythread(7, scripts\sp\utility::_id_10346, "shipcrib_crw2_uhpgotanissue");
    wait 9.5;
    var_0 thread scripts\sp\utility::_id_10346("shipcrib_crw1_letmedrivestepa");
    wait 15.5;
    var_1 thread scripts\sp\utility::_id_10346("shipcrib_crw2_targetingisgreen");
    var_0 scripts\engine\utility::delaythread(4, scripts\sp\utility::_id_10346, "shipcrib_crw1_thatonethere");
    wait 12.5;
    var_1 thread scripts\sp\utility::_id_10346("shipcrib_crw2_bingothinkwegotit");
    var_0 scripts\engine\utility::delaythread(3, scripts\sp\utility::_id_10346, "shipcrib_crw1_yepthatsitgoodw");
    var_0 waittill("looping anim");
  }
}

_id_35F7() {
  self endon("death");
  thread scripts\sp\anim::_id_1EC3(self, "c12_poweron");
  level waittill("c12_reveal");
  scripts\sp\anim::_id_1F35(self, "c12_poweron");
  thread scripts\sp\anim::_id_1EEA(self, "c12_idle");
  var_0 = getEnt("c12_scare_trigger_look", "targetname");
  var_1 = getEnt("c12_scare_trigger_close", "targetname");
  var_1 thread _id_35F9(self);
  scripts\engine\utility::flag_wait("c12_scare");
  level notify("c12_scare_start");
  self notify("stop_loop");
  scripts\sp\anim::_id_1F35(self, "c12_scare");
  thread scripts\sp\anim::_id_1EEA(self, "c12_idle");
}

_id_35FA(var_0) {
  var_0 endon("death");
  level endon("c12_scare_start");
  var_1 = scripts\engine\utility::getStruct(self.target, "targetname");

  for(;;) {
    self waittill("trigger");

    for(;;) {
      wait 1.25;

      if(level.player istouching(self)) {
        if(scripts\sp\utility::_id_D1DF(var_1.origin, 0.8, 1)) {
          scripts\engine\utility::flag_set("c12_scare");
          return;
        }
      } else
        break;

      scripts\engine\utility::waitframe();
    }
  }
}

_id_35F9(var_0) {
  var_0 endon("death");
  self waittill("trigger");
  scripts\engine\utility::flag_set("c12_scare");
}

_id_35F8() {
  var_0 = getEnt();
}

_id_361D(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_6 = _id_0EF8::_id_FE01(var_1, var_0, "cheap");
  var_6 _id_0EFB::_id_FD6F("c12_guys");

  if(isDefined(var_3)) {
    if(var_3) {
      var_6 scripts\sp\utility::_id_86E2();
    }
  }

  var_6 _id_361E(var_5, var_2, var_4);
}

_id_361E(var_0, var_1, var_2) {
  self endon("death");
  var_0 thread scripts\sp\anim::_id_1ECC(self, var_1 + "_idle_01", "stop_loop_" + var_1);
  level waittill("c12_reveal");
  wait 1;
  var_0 notify("stop_loop_" + var_1);
  var_0 scripts\sp\anim::_id_1EC7(self, var_1 + "_reveal");
  var_0 thread scripts\sp\anim::_id_1ECC(self, var_1 + "_idle_02", "stop_loop_" + var_1);
  scripts\engine\utility::flag_wait("c12_scare");
  wait 0.25;
  var_0 notify("stop_loop_" + var_1);
  var_0 scripts\sp\anim::_id_1EC7(self, var_1 + "_scare");
  var_0 thread scripts\sp\anim::_id_1ECC(self, var_1 + "_idle_02", "stop_loop_" + var_1);

  if(var_2) {
    thread _id_0EE5::_id_202D();
  }
}

_id_11A48() {
  wait 0.2;
  var_0 = _id_0EF9::_id_FE03("towcart", "towcart_armory_start");
  var_0 endon("entitydeleted");
  var_0 scripts\sp\utility::_id_65E0("start_elevator_arrive");
  var_0 scripts\sp\utility::_id_65E0("reached_elevator");
  var_0 scripts\sp\utility::_id_65E0("end_elevator_arrive");
  var_0 thread _id_11A49();
  scripts\engine\utility::flag_wait("airboss_door_scene_start");
  var_0 thread _id_0EFA::_id_11A4F();
  _id_0EEB::_id_60FD("apc", "Flight Deck", 1);
  var_0 vehicle_setspeed(0, 1, 1);

  foreach(var_2 in var_0._id_3A5D) {
    if(var_2 islinked()) {
      var_2 unlink();
    }

    var_2 delete();
  }

  var_4 = getvehiclenode("towcart_airboss_start", "targetname");
  var_0 vehicle_teleport(var_4.origin, var_4.angles);
  scripts\engine\utility::waitframe();
  var_0 attachpath(var_4);
  var_0 vehicle_setspeed(2.5);
  var_0 thread _id_0EFA::_id_11A4E("towcart_airboss_start");
  var_0 scripts\sp\utility::_id_65E3("reached_elevator");
  var_0 notify("stop_player_awareness");
  wait 2;
  scripts\engine\utility::flag_waitopen("apc_elevator_clear");
  _id_0EEB::_id_60FD("apc", "Catwalks");
  _id_0EEB::_id_7976("apc") waittill("move_finished");
  wait 2;
  var_0 scripts\sp\utility::_id_65E1("end_elevator_arrive");
  var_0 vehicle_setspeed(2.5);
  var_0 waittill("reached_end_node");
  _id_0EEB::_id_60FD("apc", "Flight Deck");
  _id_0EEB::_id_7976("apc") waittill("move_finished");
  wait 1;
  scripts\engine\utility::flag_set("forklift_b_send_to_elevator");
  scripts\engine\utility::flag_set("forklift_a_send_to_elevator");
}

_id_11A49() {
  level endon("airboss_door_scene_start");
  self endon("entitydeleted");
  _id_0EEB::_id_60F0("apc", 20);
  var_0 = getvehiclenode("towcart_armory_start", "targetname");
  self vehicle_teleport(var_0.origin, var_0.angles);
  scripts\engine\utility::waitframe();
  self attachpath(var_0);
  self startpath();
  self vehicle_setspeed(0, 1, 1);
  wait 0.5;
  _id_0EFA::_id_11A4D("towcart_cargo");
  wait 4;
  _id_0EEB::_id_60FD("apc", "Flight Deck");
  _id_0EEB::_id_7976("apc") waittill("move_finished");
  wait 2;
  self resumespeed(2.5);
}

_id_A0CD() {
  var_0 = ["spawner_flightdeck_maintenance", "spawner_flightdeck_ordnance", "spawner_flightdeck_handler"];
  var_1 = ["jackal_bay_fod_01_a", "jackal_bay_fod_02_b", "jackal_bay_fod_02_c", "jackal_bay_fod_02_d"];

  foreach(var_3 in var_1) {
    var_4 = _id_0EF8::_id_FE01(var_0[randomint(var_0.size)], var_3, "cheap");
    var_5 = scripts\engine\utility::getStruct(var_3, "targetname");
    var_4 _id_0EFB::_id_FD6F("jackal_fod_guys");
    var_5 thread scripts\sp\anim::_id_1ECC(var_4, var_5.animation);
  }
}

_id_A1E4() {
  level endon("jackal_loading_gantries_stop");
  level._id_E35D._id_AA5F["jackal_bay_1"]._id_7691 thread _id_0EE4::_id_A25C("max_raised", 1);
  level._id_E35D._id_AA5F["jackal_bay_3"]._id_7691 thread _id_0EE4::_id_A25C("max_raised", 0.05);
  level._id_E35D._id_AA5F["jackal_bay_1"]._id_7691 thread _id_0EE4::_id_A25C("max_raised", 1);
}

_id_A36F() {
  level endon("start_launch");
  level._id_FD6E._id_A371 = getEnt("jackal_a_dock_vehicle", "targetname");
  level._id_FD6E._id_A371._id_A27D = _id_0EF9::_id_FE03("jackal_cheap", "jackal_a_dock_vehicle", undefined, undefined, 1);
  level._id_FD6E._id_A371._id_A27D linkTo(level._id_FD6E._id_A371);
  var_0 = level._id_FD6E._id_A371;
  level thread _id_A0C5();
  var_0 thread _id_A370();
  scripts\engine\utility::flag_wait("airboss_door_scene_start");
  level scripts\engine\utility::delaythread(15, _id_0EEB::_id_60EC, "jackal", "Flight Deck", 1);
  var_0._id_A27D setanimknob(%shipcrib_veh_jackal_lean_wheel_rotate, 11, 0.2, 0.3);
  var_1 = getvehiclenode("jackal_a_dock_start_close", "targetname");
  var_0 scripts\sp\vehicle::_id_2471(var_1);
  var_0 waittill("reached_end_node");
  level._id_FD6E._id_A371._id_A27D clearanim(%shipcrib_veh_jackal_lean_wheel_rotate, 0);
  level._id_FD6E._id_A371._id_A27D _meth_82A2(%shipcrib_veh_jackal_lean_canopy_open, 1, 0.2);
  level notify("start_jackal_servicing_bay1");
}

_id_A370() {
  level endon("airboss_door_scene_start");
  var_0 = getvehiclenode("jackal_a_dock_start", "targetname");
  self startpath(var_0);
  self._id_A27D setanimknob(%shipcrib_veh_jackal_lean_wheel_rotate, 11, 0.2, 0.3);
  self waittill("reached_end_node");
  self._id_A27D clearanim(%shipcrib_veh_jackal_lean_wheel_rotate, 0);
}

_id_A0C5() {
  level thread _id_10AA::_id_DEB9();
  var_0 = _id_0EF8::_id_FE01("spawner_pilot", "jackal_bay1_scar1", "cheap");
  var_0 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_1 = scripts\engine\utility::getStruct("jackal_bay1_scar1", "targetname");
  var_1 thread scripts\sp\anim::_id_1ECC(var_0, var_1.animation, "stop_loop");
  var_0 thread _id_0EE5::_id_202D();
  var_0 scripts\sp\utility::_id_86E2();
  var_0 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_0 scripts\sp\utility::_id_7DC1(var_1.animation)[0], randomfloatrange(0, 1));
  var_0 = _id_0EF8::_id_FE01("spawner_pilot", "jackal_bay1_scar2", "cheap");
  var_0 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_1 = scripts\engine\utility::getStruct("jackal_bay1_scar2", "targetname");
  var_0 scripts\sp\utility::_id_86E2();
  var_1 thread scripts\sp\anim::_id_1ECC(var_0, var_1.animation, "stop_loop");
  var_0 thread _id_0EE5::_id_202D();
  var_2 = scripts\engine\utility::getStruct("jackal_taxi_service_guys", "targetname");
  var_3 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "jackal_taxi_service_guys", "cheap");
  var_3._id_1FBB = "shipcrib_jackal_serv_grnd_A";
  var_3 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_2 thread scripts\sp\anim::_id_1EEA(var_3, "intro_idle");
  var_4 = _id_0EF8::_id_FE01("spawner_flightdeck_handler", "jackal_taxi_service_guys", "cheap");
  var_4._id_1FBB = "shipcrib_jackal_serv_grnd_B";
  var_4 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_2 thread scripts\sp\anim::_id_1EEA(var_4, "intro_idle");
  var_5 = [var_3, var_4];

  foreach(var_7 in var_5) {
    var_7 thread _id_A0C7(var_2);
  }
}

_id_A0C6(var_0) {
  level endon("airboss_door_scene_start");
  self endon("death");
  var_1 = "base_idle";

  for(;;) {
    var_0 scripts\sp\anim::_id_1F35(self, var_1);

    if(randomint(100) > 33) {
      var_1 = "base_idle";
      continue;
    }

    switch (randomint(3)) {
      case 0:
        var_1 = "vig_01";
        break;
      case 1:
        var_1 = "vig_02";
        break;
      case 2:
        var_1 = "vig_large";
        break;
    }
  }
}

_id_A0C7(var_0) {
  self endon("death");

  if(self._id_1FBB == "shipcrib_jackal_serv_grnd_C") {
    scripts\engine\utility::flag_wait("airboss_door_scene_start");
    var_0 thread scripts\sp\anim::_id_1EC3(self, "intro");
    wait 12;
  } else {
    level waittill("start_jackal_servicing_bay1");
    var_0 notify("stop_loop");
  }

  var_0 scripts\sp\anim::_id_1F35(self, "intro");
  level._id_FD6E._id_A371 thread scripts\sp\idles::_id_CC7F(self, 0);
}

_id_8ACF() {
  var_0 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "hangar_sweeper_01_a", "cheap");
  var_0 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_fuel", "hangar_sweeper_02_a", "cheap");
  var_1 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_2 = scripts\engine\utility::getStruct("hangar_sweeper_01_a", "targetname");
  var_0._id_1EF1 = scripts\sp\utility::_id_10639("broom");
  var_2 thread scripts\sp\anim::_id_1ECC(var_0, "shipcrib_hangar_sweeping_01_guy");
  var_2 thread scripts\sp\anim::_id_1EEA(var_0._id_1EF1, "shipcrib_hangar_sweeping_01_broom");
  var_2 = scripts\engine\utility::getStruct("hangar_sweeper_02_a", "targetname");
  var_1._id_1EF1 = scripts\sp\utility::_id_10639("broom");
  var_2 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_sweeping_02_guy");
  var_2 thread scripts\sp\anim::_id_1EEA(var_1._id_1EF1, "shipcrib_hangar_sweeping_02_broom");
  scripts\engine\utility::flag_wait("airboss_door_scene_start");
  var_2 = scripts\engine\utility::getStruct("hangar_sweeper_01_a", "targetname");
  var_2 notify("stop_loop");
  var_2 = scripts\engine\utility::getStruct("hangar_sweeper_01_b", "targetname");
  var_2 thread scripts\sp\anim::_id_1ECC(var_0, "shipcrib_hangar_sweeping_01_guy");
  var_2 thread scripts\sp\anim::_id_1EEA(var_0._id_1EF1, "shipcrib_hangar_sweeping_01_broom");
  var_0 thread _id_0EE5::_id_202D();
  var_2 = scripts\engine\utility::getStruct("hangar_sweeper_02_a", "targetname");
  var_2 notify("stop_loop");
  var_2 = scripts\engine\utility::getStruct("hangar_sweeper_02_b", "targetname");
  var_2 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_sweeping_02_guy");
  var_2 thread scripts\sp\anim::_id_1EEA(var_1._id_1EF1, "shipcrib_hangar_sweeping_02_broom");
  var_1 thread _id_0EE5::_id_202D();
}

_id_8A7B() {
  var_0 = _id_0EF8::_id_FE01("spawner_flightdeck_handler", "hangar_inspection_01", "cheap");
  var_0._id_1FBB = "inspector";
  var_0 _id_0EFB::_id_FD6F("inspectors");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "hangar_inspection_02", "cheap");
  var_1._id_1FBB = "inspector";
  var_1 _id_0EFB::_id_FD6F("inspectors");
  var_2 = _id_0EF8::_id_FE01("spawner_flightdeck", "hangar_inspection_03", "cheap");
  var_2._id_1FBB = "inspector";
  var_2 _id_0EFB::_id_FD6F("inspectors");
  var_0 thread _id_8A7C(scripts\engine\utility::getStruct("hangar_inspection_01", "targetname"), "low");
  var_1 thread _id_8A7C(scripts\engine\utility::getStruct("hangar_inspection_02", "targetname"), "high");
  wait 2;
  var_2 thread _id_8A7C(scripts\engine\utility::getStruct("hangar_inspection_03", "targetname"), "high");
}

_id_8A7C(var_0, var_1) {
  self endon("death");
  self attach("p7_desk_metal_military_03_tablet", "tag_inhand");
  thread _id_0EE5::_id_202D();

  for(;;) {
    var_0 thread scripts\sp\anim::_id_1EEA(self, "shipcrib_inspection_idle");
    var_2 = scripts\sp\utility::_id_7DC1("shipcrib_inspection_idle");
    var_3 = getanimlength(var_2[0]);
    wait(var_3 * randomintrange(1, 5));
    var_0 notify("stop_loop");
    var_0 scripts\sp\anim::_id_1F35(self, "shipcrib_inspection_90_" + var_1 + "_idle");
  }
}

_id_8AC3() {
  var_0 = scripts\engine\utility::getStructArray("hangar_sleeper", "targetname");

  foreach(var_2 in var_0) {
    var_3 = _id_0EF8::_id_FE01("spawner_pilot", undefined, "cheap");
    var_3 _id_0EFB::_id_FD6F("misc_hangar_crew");
    var_2 thread scripts\sp\anim::_id_1ECC(var_3, var_2.animation);
  }
}

_id_8A23() {
  var_0 = scripts\engine\utility::getStruct("hangar_box_movers_01", "targetname");
  var_1 = getEnt("rogue_leave_deck_crate1", "targetname");
  var_1._id_4348 = getEnt("rogue_leave_deck_crate1_col", "targetname");
  var_1 scripts\sp\utility::_id_23B7("crate_move_A");
  var_1._id_4348 linkTo(var_1);
  var_2 = getEnt("rogue_leave_deck_crate2", "targetname");
  var_2._id_4348 = getEnt("rogue_leave_deck_crate2_col", "targetname");
  var_2 scripts\sp\utility::_id_23B7("crate_move_B");
  var_2._id_4348 linkTo(var_2);
  var_3 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "hangar_box_movers_01", "cheap");
  var_3 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_3._id_1FBB = "crate_mover_guyA";
  var_3._id_1EF1 = var_1;
  var_3._id_1EF1._id_4348 = var_1._id_4348;
  var_4 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "hangar_box_movers_01", "cheap");
  var_4 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_4._id_1FBB = "crate_mover_guyB";
  var_4._id_1EF1 = var_2;
  var_4._id_1EF1._id_4348 = var_2._id_4348;
  _id_8A25([var_3, var_4, var_3._id_1EF1, var_4._id_1EF1], var_0);
}

_id_8A25(var_0, var_1) {
  var_0[0] endon("death");
  var_1 thread scripts\sp\anim::_id_1EE7(var_0, "crate_move_pre_idle");
  level waittill("c12_reveal");
  wait 2;
  var_1 notify("stop_loop");
  var_1 scripts\sp\anim::_id_1F2C(var_0, "crate_move");
  var_1 thread scripts\sp\anim::_id_1EE7(var_0, "crate_move_post_idle");
  _id_8A24(var_0[0], var_0[1]);
}

_id_8A24(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");

  for(;;) {
    if(distance2dsquared(var_0.origin, level.player.origin) <= 65536) {
      break;
    } else
      wait 0.2;
  }

  var_1 scripts\sp\utility::_id_10346("shipcrib_sc2_ihatewaitinman");
  wait 1;
  var_0 scripts\sp\utility::_id_10346("shipcrib_sc1_yeahifeelyou");
  wait 1;
  var_1 scripts\sp\utility::_id_10346("shipcrib_sc2_whatsupyougood");
  wait 2;
  var_0 scripts\sp\utility::_id_10346("shipcrib_sc1_stilltryintofigure");
}

_id_208C() {
  var_0 = scripts\engine\utility::getStruct("apc_repair_guy_1", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "apc_repair_guy_1", "cheap");
  var_1 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, var_0.animation);
  var_1 thread _id_0EE5::_id_202D();
  var_0 = scripts\engine\utility::getStruct("apc_repair_guy_2", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "apc_repair_guy_2", "cheap");
  var_1 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, var_0.animation);
}

_id_BFD7() {
  var_0 = scripts\engine\utility::getStruct("hangar_nitrogen_inspector", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_fuel", "hangar_nitrogen_inspector", "cheap");
  var_1 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_nitro_term_serv_01_idle");
  var_1 thread _id_BFD6(var_0);
}

_id_BFD6(var_0) {
  self endon("death");
  level waittill("airboss_elevator_arrived");
  wait 1;
  var_0 notify("stop_loop");
  thread _id_0EE5::_id_202D();
  scripts\engine\utility::delaythread(2, _id_0EEF::_id_15B0, ["jackal_bay_3"], "nitrogen");
  var_0 scripts\sp\anim::_id_1EC7(self, "shipcrib_hangar_nitro_term_serv_01_raise");

  for(;;) {
    var_0 scripts\sp\anim::_id_1EC7(self, "shipcrib_hangar_nitro_term_serv_01_loop_01");
    var_0 scripts\sp\anim::_id_1EC7(self, "shipcrib_hangar_nitro_term_serv_01_loop_02");
  }
}

_id_8AB3() {
  var_0 = _id_0EF8::_id_FE01("spawner_flightdeck_handler", "hangar_reaction_fod", "cheap");
  var_0 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_0 thread _id_0EE5::_id_202D("stand_idle_3_back_reaction", "sc_rogue_un2_baysclosedunt");
  var_0 = _id_0EF8::_id_FE01("spawner_flightdeck_fuel", "hangar_reaction_pointer", "cheap");
  var_0 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_0 thread _id_0EE5::_id_202D("shipcrib_attn_pointright_1", "sc_rogue_un1_yourravensin");
}

_id_E38B() {
  level endon("start_launch");
  var_0 = level._id_E35D._id_47DC._id_EF68;
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_handler", var_0, "cheap");
  var_1 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_1 linkTo(var_0);
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_crane_load_B_guy01_exit");
  var_2 = _id_0EF8::_id_FE01("spawner_flightdeck_handler", var_0, "cheap");
  var_2 _id_0EFB::_id_FD6F("misc_hangar_crew");
  var_2 linkTo(var_0);
  var_0 thread scripts\sp\anim::_id_1ECC(var_2, "shipcrib_hangar_crane_load_B_guy02_exit");
  var_1._id_1EF1 = scripts\sp\utility::_id_10639("hangar_crane_crate01", var_0.origin, var_0.angles);
  var_1._id_1EF1 linkTo(var_0);
  var_0 thread scripts\sp\anim::_id_1EEA(var_1._id_1EF1, "idle");
  var_2._id_1EF1 = scripts\sp\utility::_id_10639("hangar_crane_crate02", var_0.origin, var_0.angles);
  var_2._id_1EF1 linkTo(var_0);
  var_0 thread scripts\sp\anim::_id_1EEA(var_2._id_1EF1, "idle");
  level thread _id_0EDF::_id_E38E("start", 0.05);
  wait 10;
  level _id_0EDF::_id_E38E("down", 8);
  level _id_0EDF::_id_E38E("basket_open_unload", 2);
  scripts\engine\utility::flag_wait("airboss_door_scene_start");
  level _id_0EDF::_id_E38E("basket_closed", 0.05);
  level _id_0EDF::_id_E38E("up", 9);
  wait 0.5;
  level _id_0EDF::_id_E38E("unload", 30);
  level _id_0EDF::_id_E38E("basket_open_unload", 2);
}

_id_8A92() {
  level waittill("airboss_door_scene_start");
  wait 2;
  var_0 = _id_0EF9::_id_FE03("forklift", "airboss_forklift_a");
  var_0 thread _id_0EED::_id_730B();
  var_0 endon("entitydeleted");
  wait 0.1;
  level thread scripts\engine\utility::flag_set_delayed("forklift_a_go", 20);
  var_0 thread _id_0EED::_id_7309("airboss_forklift_a_cargo");
  var_0 _id_0EED::_id_730A("airboss_forklift_a");
  wait 0.5;
  var_0 _id_0EED::_id_7315();
  var_1 = 160000;

  for(;;) {
    if(distance2dsquared(level.player.origin, var_0.origin) >= var_1) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  var_0 _id_0EED::_id_730A("forklift_deep_backup");
  var_0 thread _id_0EED::_id_730A("airboss_forklift_a_return");
  scripts\engine\utility::flag_wait("forklift_a_waiting_at_elevator");
  var_0 notify("stop_player_awareness");
  scripts\engine\utility::flag_wait("forklift_a_send_to_elevator");
  var_0 thread _id_0EED::_id_730B();
  var_0 waittill("reached_end_node");
  wait 1;
  scripts\engine\utility::flag_waitopen("apc_elevator_clear");
  _id_0EEB::_id_60FD("apc", "Storage");
  _id_0EEB::_id_7976("apc") waittill("move_finished");
  wait 0.5;
  var_0 resumespeed(3);
  var_0 thread _id_0EED::_id_730A("leave_forklift_a_storage");
  wait 0.5;
  level._id_FD6E._id_7316["airboss_forklift_b"] _id_0EED::_id_730A("leave_forklift_b_storage");
}

_id_8A93() {
  level waittill("airboss_door_scene_start");
  var_0 = _id_0EF9::_id_FE03("forklift", "airboss_forklift_b");
  var_0 thread _id_0EED::_id_730B();
  var_0 endon("entitydeleted");
  wait 0.1;
  level thread scripts\engine\utility::flag_set_delayed("forklift_b_go", 16);
  var_0 _id_0EED::_id_7309("airboss_forklift_b_cargo");
  var_0 thread _id_0EED::_id_730A("airboss_forklift_b");
  scripts\engine\utility::flag_wait("forklift_b_waiting_at_elevator");
  var_0 notify("stop_player_awareness");
  scripts\engine\utility::flag_wait("forklift_b_send_to_elevator");
  var_0 thread _id_0EED::_id_730B();
}

_id_8A67() {
  level waittill("airboss_door_scene_start");
  level thread _id_10A7::_id_8A6A("hangar_hustle");
}

_id_A5F7() {
  _id_0EFB::_id_FDBA(level._id_828C);
  _id_0EFB::_id_FDBA(level._id_EA29);
  var_0 = _id_0EFB::_id_FD9C("misc_hangar_crew");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_1EF1)) {
      if(isDefined(var_2._id_1EF1._id_4348)) {
        var_2._id_1EF1._id_4348 delete();
      }

      var_2._id_1EF1 delete();
    }

    _id_0EFB::_id_FDBA(var_2);
  }

  var_0 = _id_0EFB::_id_FD9C("inspectors");

  foreach(var_2 in var_0) {
    var_2 detach("p7_desk_metal_military_03_tablet", "tag_inhand");
    _id_0EFB::_id_FDBA(var_2);
  }

  _id_10A7::_id_8A6B(_id_0EFB::_id_FD9C("hangar_hustle"));
  _id_0EFB::_id_FDBB("c12_guys");
  level._id_359C _meth_81D0();
  level._id_359C delete();
  _id_0EFB::_id_FDBB("jackal_fod_guys");
  _id_0EFB::_id_FDBB("crane_rider");
  _id_0EFB::_id_FDBB("forklift_driver");
  level notify("jackal_loading_gantries_stop");
  level notify("dropship_crane_stop");
  level._id_FD6E._id_A371._id_A27D unlink();
  _id_0EFB::_id_FDE7(level._id_FD6E._id_A371);
  _id_0EFB::_id_FDE7(level._id_FD6E._id_A371._id_A27D);
  _id_0EFB::_id_FDE7(level._id_FD6E._id_5EE3["dropship_return_elevator"]);
  level._id_FD6E._id_11A55["towcart_armory_start"] _id_0BF1::_id_11A4C();
  level thread _id_10A3::_id_3B9E();
  level thread _id_10A2::_id_1A5E();
  level thread _id_10A5::_id_5E9A(_id_0EFB::_id_FD9C("dropship_service"));
  level thread _id_10AA::_id_A315(_id_0EFB::_id_FD9C("jackal_service"));
  _id_0EFB::_id_FD71();
  level thread scripts\sp\maps\shipcrib_rogue\shipcrib_rogue::_id_12BCC();
}