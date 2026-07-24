/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4262.gsc
**************************************/

_id_888A() {
  if(!isDefined(level._id_FDA2)) {
    level._id_FDA2 = [];
    _id_887A();
  }

  level._id_FDA2["return"] = [];
  level._id_FDA2["leave"] = [];

  switch (level.script) {
    case "shipcrib_moon":
      _id_F9E0();
      break;
    case "shipcrib_gravity":
      _id_F985();
      break;
    default:
      _id_F90B();
      break;
  }
}

_id_F90B() {
  _id_10674();
  _id_10673();
  level._id_FDA2["elevator_up_func"] = ::_id_E7E2;
  level._id_FDA2["elevator_down_func"] = ::_id_E7E1;
}

_id_F985() {
  _id_10700();
  _id_106FF();
  level._id_FDA2["elevator_up_func"] = ::_id_E7F8;
  level._id_FDA2["elevator_down_func"] = ::_id_E7F7;
}

_id_F9E0() {
  _id_10772();
  _id_10771();
  level._id_FDA2["elevator_up_func"] = ::_id_E806;
  level._id_FDA2["elevator_down_func"] = ::_id_E805;
}

_id_888B() {
  _id_0EFB::_id_FDBB("hallways");
}

_id_10674() {
  var_0 = scripts\engine\utility::getStructArray("sc_ambient_hallway_casual_a_rt", "targetname");
  level._id_FDA2["return"] = _id_1072B(var_0);
}

_id_E7E2() {
  var_0 = level._id_FDA2["return"];
  scripts\engine\utility::flag_wait("ambient_return_elevator_1f");
  var_1 = var_0["return_fl1_a"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl1_b"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl1_c"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["return_fl1_d"];
  var_1 thread _id_1F5E(0.0, 0.6);
  scripts\engine\utility::flag_wait("ambient_return_elevator_2f");
  var_1 = var_0["return_fl2_a"];
  var_1 thread _id_1F5E(0.0, 0.6);
  var_1 = var_0["return_fl2_b"];
  var_1 thread _id_1F5E(0.0, 0.6);
  var_1 = var_0["return_fl2_c"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl2_d"];
  var_1 thread _id_1F5E(0.0, 0.6);
  scripts\engine\utility::flag_wait("ambient_return_elevator_3f");
  var_1 = var_0["return_fl3_a"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl3_b"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl3_c"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl3_d"];
  var_1 thread _id_1F5E(0.0, 0.3);
  scripts\engine\utility::flag_wait("ambient_return_elevator_4f");
  var_1 = var_0["return_fl4_a"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl4_b"];
  var_1 thread _id_1F5E(0.0, 0.2);
  scripts\engine\utility::flag_wait("ambient_return_elevator_5f");
  var_1 = var_0["return_fl5_a"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl5_b"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl5_c"];
  var_1 thread _id_1F5E(0.0, 0.6);
  var_1 = var_0["return_fl5_d"];
  var_1 thread _id_1F5E(0.0, 0.6);
  scripts\engine\utility::flag_wait("ambient_return_elevator_6f");
  var_1 = var_0["return_fl6_a"];
  var_1 thread _id_1F5E(0.0, 0.5);
  var_1 = var_0["return_fl6_b"];
  var_1 thread _id_1F5E(0.0, 0.5);
  var_1 = var_0["return_fl6_c"];
  var_1 thread _id_1F5E(0.0, 0.5);
}

_id_10676() {
  var_0 = scripts\engine\utility::getStructArray("sc_ambient_hallway_casual_b_rt", "targetname");
  level._id_FDA2["return"] = _id_1072B(var_0);
}

_id_E7E4() {
  var_0 = level._id_FDA2["return"];
  scripts\engine\utility::flag_wait("ambient_return_elevator_1f");
  var_1 = var_0["return_fl1_a"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl1_b"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl1_c"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["return_fl1_d"];
  var_1 thread _id_1F5E(0.0, 0.6);
  scripts\engine\utility::flag_wait("ambient_return_elevator_2f");
  var_1 = var_0["return_fl2_a"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl2_b"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl2_c"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl2_d"];
  var_1 thread _id_1F5E(0.0, 0.2);
  scripts\engine\utility::flag_wait("ambient_return_elevator_3f");
  var_1 = var_0["return_fl3_a"];
  var_1 thread _id_1F5E(0.0, 0.0);
  var_1 = var_0["return_fl3_b"];
  var_1 thread _id_1F5E(0.0, 0.0);
  var_1 = var_0["return_fl3_c"];
  var_1 thread _id_1F5E(0.0, 0.0);
  var_1 = var_0["return_fl3_d"];
  var_1 thread _id_1F5E(0.0, 0.0);
  scripts\engine\utility::flag_wait("ambient_return_elevator_4f");
  var_1 = var_0["return_fl4_a"];
  var_1 thread _id_1F5E(1.0, 0.0);
  var_1 = var_0["return_fl4_b"];
  var_1 thread _id_1F5E(1.0, 0.0);
  scripts\engine\utility::flag_wait("ambient_return_elevator_5f");
  var_1 = var_0["return_fl5_a"];
  var_1 thread _id_1F5E(0.0, 0.0);
  var_1 = var_0["return_fl5_b"];
  var_1 thread _id_1F5E(0.0, 0.0);
  var_1 = var_0["return_fl5_c"];
  var_1 thread _id_1F5E(0.0, 0.0);
  var_1 = var_0["return_fl5_d"];
  var_1 thread _id_1F5E(0.0, 0.0);
  scripts\engine\utility::flag_wait("ambient_return_elevator_6f");
  var_1 = var_0["return_fl6_a"];
  var_1 thread _id_1F5E(4.0, 0.0);
  var_1 = var_0["return_fl6_b"];
  var_1 thread _id_1F5E(4.0, 0.0);
  var_1 = var_0["return_fl6_c"];
  var_1 thread _id_1F5E(4.0, 0.0);
}

_id_10700() {
  var_0 = scripts\engine\utility::getStructArray("sc_ambient_hallway_frantic_rt", "targetname");
  level._id_FDA2["return"] = _id_1072B(var_0);
}

_id_E7F8() {
  var_0 = level._id_FDA2["return"];
  scripts\engine\utility::flag_wait("ambient_return_elevator_1f");
  var_1 = var_0["return_fl1_a"];
  var_1 thread _id_1F5E(0.0, 0.0);
  var_1 = var_0["return_fl1_b"];
  var_1 thread _id_1F5E(0.0, 0.55);
  var_1 = var_0["return_fl1_c"];
  var_1 thread _id_1F5E(0.0, 0.0);
  var_1 = var_0["return_fl1_d"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["return_fl1_e"];
  var_1 thread _id_1F5E(0.0, 0.0);
  var_1 = var_0["return_fl1_f"];
  var_1 thread _id_1F5E(0.0, 0.0);
  scripts\engine\utility::flag_wait("ambient_return_elevator_2f");
  var_1 = var_0["return_fl2_a"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["return_fl2_b"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["return_fl2_c"];
  var_1 thread _id_1F5E(0.0, 0.4);
  scripts\engine\utility::flag_wait("ambient_return_elevator_3f");
  var_1 = var_0["return_fl3_b"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["return_fl3_a"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["return_fl3_d"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["return_fl3_c"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["return_fl3_e"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["return_fl3_f"];
  var_1 thread _id_1F5E(0.0, 0.4);
  scripts\engine\utility::flag_wait("ambient_return_elevator_4f");
  var_1 = var_0["return_fl4_a"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl4_b"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl4_d"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl4_c"];
  var_1 thread _id_1F5E(0.0, 0.3);
  scripts\engine\utility::flag_wait("ambient_return_elevator_5f");
  var_1 = var_0["return_fl5_a"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl5_b"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl5_c"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl5_d"];
  var_1 thread _id_1F5E(0.0, 0.2);
  scripts\engine\utility::flag_wait("ambient_return_elevator_6f");
  var_1 = var_0["return_fl6_a"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl6_b"];
  var_1 thread _id_1F5E(0.0, 0.5);
  var_1 = var_0["return_fl6_c"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl6_d"];
  var_1 thread _id_1F5E(0.0, 0.5);
  var_1 = var_0["return_fl6_e"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl6_f"];
  var_1 thread _id_1F5E(0.0, 0.7);
}

_id_10772() {
  var_0 = scripts\engine\utility::getStructArray("sc_ambient_hallway_moon_rt", "targetname");
  level._id_FDA2["return"] = _id_1072B(var_0);
}

_id_E806() {
  var_0 = level._id_FDA2["return"];
  scripts\engine\utility::flag_wait("ambient_return_elevator_1f");
  thread scripts\engine\utility::play_sound_in_space("sc_moon_elevator_passby_level_1", (-544, 267, -781));
  var_1 = var_0["return_fl1_a"];
  var_1 thread _id_1F5E(0.0, 0.5);
  var_1 = var_0["return_fl1_b"];
  var_1 thread _id_1F5E(0.0, 0.6);
  var_1 = var_0["return_fl1_c"];
  var_1 thread _id_1F5E(0.0, 0.5);
  var_1 = var_0["return_fl1_d"];
  var_1 thread _id_1F5E(0.0, 0.2);
  scripts\engine\utility::flag_wait("ambient_return_elevator_2f");
  thread scripts\engine\utility::play_sound_in_space("sc_moon_elevator_passby_level_2", (-544, 267, -610));
  var_1 = var_0["return_fl2_a"];
  var_1 thread _id_1F5E(0.0, 0.6);
  var_1 = var_0["return_fl2_b"];
  var_1 thread _id_1F5E(0.0, 0.6);
  var_1 = var_0["return_fl2_c"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["return_fl2_d"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["return_fl2_e"];
  var_1 thread _id_1F5E(0.0, 0.4);
  scripts\engine\utility::flag_wait("ambient_return_elevator_3f");
  thread scripts\engine\utility::play_sound_in_space("sc_moon_elevator_passby_level_3", (-544, 267, -438));
  var_1 = var_0["return_fl3_b"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["return_fl3_a"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["return_fl3_d"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl3_c"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl3_e"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl3_f"];
  var_1 thread _id_1F5E(0.0, 0.05);
  scripts\engine\utility::flag_wait("ambient_return_elevator_4f");
  thread scripts\engine\utility::play_sound_in_space("sc_moon_elevator_passby_level_4", (-544, 267, -271));
  var_1 = var_0["return_fl4_a"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl4_b"];
  var_1 thread _id_1F5E(0.0, 0.6);
  var_1 = var_0["return_fl4_d"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl4_c"];
  var_1 thread _id_1F5E(0.0, 0.3);
  scripts\engine\utility::flag_wait("ambient_return_elevator_5f");
  thread scripts\engine\utility::play_sound_in_space("sc_moon_elevator_passby_level_5", (-544, 267, -101));
  var_1 = var_0["return_fl5_a"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl5_b"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl5_c"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl5_d"];
  var_1 thread _id_1F5E(0.0, 0.2);
  scripts\engine\utility::flag_wait("ambient_return_elevator_6f");
  thread scripts\engine\utility::play_sound_in_space("sc_moon_elevator_passby_level_6", (-544, 267, 68));
  var_1 = var_0["return_fl6_a"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["return_fl6_b"];
  var_1 thread _id_1F5E(0.0, 0.5);
  var_1 = var_0["return_fl6_c"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl6_d"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["return_fl6_e"];
  var_1 thread _id_1F5E(0.0, 0.85);
  var_1 = var_0["return_fl6_f"];
  var_1 thread _id_1F5E(0.0, 0.25);
  var_1 = var_0["return_fl6_g"];
  var_1 thread _id_1F5E(0.0, 0.25);
  var_1 = var_0["return_fl6_h"];
  var_1 thread _id_1F5E(0.0, 0.25);
}

_id_10673() {
  var_0 = scripts\engine\utility::getStructArray("sc_ambient_hallway_casual_a_lv", "targetname");
  level._id_FDA2["leave"] = _id_1072B(var_0);
}

_id_E7E1() {
  var_0 = level._id_FDA2["leave"];
  scripts\engine\utility::flag_wait("ambient_bridge_elevator_3f");
  var_1 = var_0["leave_fl3_a"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["leave_fl3_b"];
  var_1 thread _id_1F5E(0.0, 0.4);
  scripts\engine\utility::flag_wait("ambient_bridge_elevator_2f");
  var_1 = var_0["leave_fl2_a"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["leave_fl2_b"];
  var_1 thread _id_1F5E(0.0, 0.5);
  var_1 = var_0["leave_fl2_c"];
  var_1 thread _id_1F5E(0.0, 0.4);
  scripts\engine\utility::flag_wait("ambient_bridge_elevator_1f");
  var_1 = var_0["leave_fl1_a"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["leave_fl1_b"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["leave_fl1_c"];
  var_1 thread _id_1F5E(0.0, 0.2);
}

_id_10675() {
  var_0 = scripts\engine\utility::getStructArray("sc_ambient_hallway_casual_b_lv", "targetname");
  level._id_FDA2["leave"] = _id_1072B(var_0);
}

_id_E7E3() {
  var_0 = level._id_FDA2["leave"];
  scripts\engine\utility::flag_wait("ambient_bridge_elevator_3f");
  scripts\engine\utility::flag_wait("ambient_bridge_elevator_2f");
  scripts\engine\utility::flag_wait("ambient_bridge_elevator_1f");
  var_1 = var_0["leave_fl1_a"];
  var_1 thread _id_1F5E(0.0, 0.1);
}

_id_106FF() {
  var_0 = scripts\engine\utility::getStructArray("sc_ambient_hallway_frantic_lv", "targetname");
  level._id_FDA2["leave"] = _id_1072B(var_0);
}

_id_E7F7() {
  var_0 = level._id_FDA2["leave"];
  scripts\engine\utility::flag_wait("ambient_bridge_elevator_3f");
  var_1 = var_0["leave_fl3_a"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["leave_fl3_b"];
  var_1 thread _id_1F5E(0.0, 0.4);
  scripts\engine\utility::flag_wait("ambient_bridge_elevator_2f");
  var_1 = var_0["leave_fl2_a"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["leave_fl2_b"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["leave_fl2_c"];
  var_1 thread _id_1F5E(0.0, 0.4);
  scripts\engine\utility::flag_wait("ambient_bridge_elevator_1f");
  var_1 = var_0["leave_fl1_a"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["leave_fl1_b"];
  var_1 thread _id_1F5E(0.0, 0.3);
}

_id_10771() {
  var_0 = scripts\engine\utility::getStructArray("sc_ambient_hallway_moon_lv", "targetname");
  level._id_FDA2["leave"] = _id_1072B(var_0);
}

_id_E805() {
  var_0 = level._id_FDA2["leave"];
  scripts\engine\utility::flag_wait("ambient_bridge_elevator_3f");
  thread scripts\engine\utility::play_sound_in_space("sc_moon_armory_elevator_passby_level_6", (236, -652, -297));
  var_1 = var_0["leave_fl3_a"];
  var_1 thread _id_1F5E(0.0, 0.2);
  var_1 = var_0["leave_fl3_b"];
  var_1 thread _id_1F5E(0.0, 0.4);
  scripts\engine\utility::flag_wait("ambient_bridge_elevator_2f");
  thread scripts\engine\utility::play_sound_in_space("sc_moon_armory_elevator_passby_level_5", (236, -652, -469));
  var_1 = var_0["leave_fl2_a"];
  var_1 thread _id_1F5E(0.0, 0.3);
  var_1 = var_0["leave_fl2_b"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["leave_fl2_c"];
  var_1 thread _id_1F5E(0.0, 0.4);
  scripts\engine\utility::flag_wait("ambient_bridge_elevator_1f");
  thread scripts\engine\utility::play_sound_in_space("sc_moon_armory_elevator_passby_level_4", (236, -652, -637));
  var_1 = var_0["leave_fl1_a"];
  var_1 thread _id_1F5E(0.0, 0.4);
  var_1 = var_0["leave_fl1_b"];
  var_1 thread _id_1F5E(0.0, 0.3);
}

_id_1072B(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = _id_79FB(var_3.script_parameters);
    var_5 = _id_0EF8::_id_FDFC(var_4, var_3, "cheap");
    var_5._id_8879 = var_3.animation;
    var_5._id_1EEF = var_3;
    var_1[var_3.script_noteworthy] = var_5;
  }

  return var_1;
}

_id_1F5E(var_0, var_1) {
  self endon("death");
  wait(var_0);
  self._id_1EEF thread scripts\sp\anim::_id_1EC7(self, self._id_8879);
  scripts\engine\utility::delaycall(0.05, ::_meth_82B0, scripts\sp\utility::_id_7DC1(self._id_8879), var_1);
}

_id_79FB(var_0) {
  var_1 = "spawner_interior";

  if(isDefined(var_0)) {
    switch (var_0) {
      case "marine":
        var_1 = "spawner_marine";
        break;
      case "marine_casual":
        var_1 = "spawner_marine_casual";
        break;
      case "pilot":
        var_1 = "spawner_pilot";
        break;
      case "crew":
        var_1 = "spawner_interior";
        break;
      case "medic":
        var_1 = "spawner_interior";
        break;
      case "mech":
        var_1 = "spawner_mech";
        break;
      case "flightdeck":
        var_1 = "spawner_flightdeck";
        break;
      case "flightdeck_green":
        var_1 = "spawner_flightdeck_maintenance";
        break;
      case "flightdeck_blue":
        var_1 = "spawner_flightdeck_handler";
        break;
      case "flightdeck_purple":
        var_1 = "spawner_flightdeck_fuel";
        break;
      case "flightdeck_red":
        var_1 = "spawner_flightdeck_ordnance";
        break;
      case "flightdeck_brown":
        var_1 = "spawner_flightdeck_plane_captain";
        break;
      default:
        var_1 = "spawner_interior";
    }
  }

  return var_1;
}

#using_animtree("generic_human");

_id_887A() {
  level._id_EC85["generic"]["shipcribmoon_elevator_secA_1_guyA"] = % shipcribmoon_elevator_seca_1_guya;
  level._id_EC85["generic"]["shipcribmoon_elevator_secA_1_guyB"] = % shipcribmoon_elevator_seca_1_guyb;
  level._id_EC85["generic"]["shipcribmoon_elevator_secA_2_guyA"] = % shipcribmoon_elevator_seca_2_guya;
  level._id_EC85["generic"]["shipcribmoon_elevator_secA_2_guyB"] = % shipcribmoon_elevator_seca_2_guyb;
  level._id_EC85["generic"]["shipcribmoon_elevator_secB_1_guyA"] = % shipcribmoon_elevator_secb_1_guya;
  level._id_EC85["generic"]["shipcribmoon_elevator_secB_1_guyB"] = % shipcribmoon_elevator_secb_1_guyb;
  level._id_EC85["generic"]["shipcribmoon_elevator_secB_2_guyA"] = % shipcribmoon_elevator_secb_2_guya;
  level._id_EC85["generic"]["shipcribmoon_elevator_secB_2_guyB"] = % shipcribmoon_elevator_secb_2_guyb;
  level._id_EC85["generic"]["shipcribmoon_elevator_secB_3_guyA"] = % shipcribmoon_elevator_secb_3_guya;
  level._id_EC85["generic"]["shipcribmoon_elevator_secB_3_guyB"] = % shipcribmoon_elevator_secb_3_guyb;
  level._id_EC85["generic"]["shipcribmoon_elevator_secC_1_guyA"] = % shipcribmoon_elevator_secc_1_guya;
  level._id_EC85["generic"]["shipcribmoon_elevator_secC_1_guyB"] = % shipcribmoon_elevator_secc_1_guyb;
  level._id_EC85["generic"]["shipcribmoon_elevator_secC_2_guyA"] = % shipcribmoon_elevator_secc_2_guya;
  level._id_EC85["generic"]["shipcribmoon_elevator_secC_2_guyB"] = % shipcribmoon_elevator_secc_2_guyb;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_01"] = % shipcribmoon_elevator_injured_01;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_02"] = % shipcribmoon_elevator_injured_02;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_01"][0] = % shipcribmoon_elevator_injured_loop_01;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_02"][0] = % shipcribmoon_elevator_injured_loop_02;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_03"][0] = % shipcribmoon_elevator_injured_loop_03;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_04"][0] = % shipcribmoon_elevator_injured_loop_04;
  level._id_EC85["generic"]["shipcribmoon_elevator_injured_loop_05"][0] = % shipcribmoon_elevator_injured_loop_05;
  level._id_EC85["generic"]["shipcribgrav_elevator_secA_1_guyA"] = % shipcribgrav_elevator_seca_1_guya;
  level._id_EC85["generic"]["shipcribgrav_elevator_secA_1_guyB"] = % shipcribgrav_elevator_seca_1_guyb;
  level._id_EC85["generic"]["shipcribgrav_elevator_secA_2_guyA"] = % shipcribgrav_elevator_seca_2_guya;
  level._id_EC85["generic"]["shipcribgrav_elevator_secA_2_guyB"] = % shipcribgrav_elevator_seca_2_guyb;
  level._id_EC85["generic"]["shipcribgrav_elevator_secA_3_guyA"] = % shipcribgrav_elevator_seca_3_guya;
  level._id_EC85["generic"]["shipcribgrav_elevator_secA_3_guyB"] = % shipcribgrav_elevator_seca_3_guyb;
  level._id_EC85["generic"]["shipcribgrav_elevator_secB_1_guyA"] = % shipcribgrav_elevator_secb_1_guya;
  level._id_EC85["generic"]["shipcribgrav_elevator_secB_1_guyB"] = % shipcribgrav_elevator_secb_1_guyb;
  level._id_EC85["generic"]["shipcribgrav_elevator_secB_2_guyA"] = % shipcribgrav_elevator_secb_2_guya;
  level._id_EC85["generic"]["shipcribgrav_elevator_secB_2_guyB"] = % shipcribgrav_elevator_secb_2_guyb;
  level._id_EC85["generic"]["shipcribgrav_elevator_secC_1_guyA"] = % shipcribgrav_elevator_secc_1_guya;
  level._id_EC85["generic"]["shipcribgrav_elevator_secC_1_guyB"] = % shipcribgrav_elevator_secc_1_guyb;
  level._id_EC85["generic"]["shipcribgrav_elevator_secC_2_guyA"] = % shipcribgrav_elevator_secc_2_guya;
  level._id_EC85["generic"]["shipcribgrav_elevator_secC_2_guyB"] = % shipcribgrav_elevator_secc_2_guyb;
  level._id_EC85["generic"]["shipcribgrav_elevator_secD_1_guyA"] = % shipcribgrav_elevator_secd_1_guya;
  level._id_EC85["generic"]["shipcribgrav_elevator_secD_1_guyB"] = % shipcribgrav_elevator_secd_1_guyb;
  level._id_EC85["generic"]["shipcribgrav_elevator_secD_2_guyA"] = % shipcribgrav_elevator_secd_2_guya;
  level._id_EC85["generic"]["shipcribgrav_elevator_secD_2_guyB"] = % shipcribgrav_elevator_secd_2_guyb;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_A01"] = % shipcrib_yel_elevator_hall_one_offs_a01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_A02"] = % shipcrib_yel_elevator_hall_one_offs_a02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_B01"] = % shipcrib_yel_elevator_hall_one_offs_b01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_B02"] = % shipcrib_yel_elevator_hall_one_offs_b02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_C01"] = % shipcrib_yel_elevator_hall_one_offs_c01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_C02"] = % shipcrib_yel_elevator_hall_one_offs_c02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_D01"] = % shipcrib_yel_elevator_hall_one_offs_d01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_D02"] = % shipcrib_yel_elevator_hall_one_offs_d02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_E01"] = % shipcrib_yel_elevator_hall_one_offs_e01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_F01"] = % shipcrib_yel_elevator_hall_one_offs_f01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_F02"] = % shipcrib_yel_elevator_hall_one_offs_f02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_G01"] = % shipcrib_yel_elevator_hall_one_offs_g01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_G02"] = % shipcrib_yel_elevator_hall_one_offs_g02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_H01"] = % shipcrib_yel_elevator_hall_one_offs_h01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_H02"] = % shipcrib_yel_elevator_hall_one_offs_h02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_J01"] = % shipcrib_yel_elevator_hall_one_offs_j01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_J02"] = % shipcrib_yel_elevator_hall_one_offs_j02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_K01"] = % shipcrib_yel_elevator_hall_one_offs_k01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_K02"] = % shipcrib_yel_elevator_hall_one_offs_k02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_L01"] = % shipcrib_yel_elevator_hall_one_offs_l01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_L02"] = % shipcrib_yel_elevator_hall_one_offs_l02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_M01"] = % shipcrib_yel_elevator_hall_one_offs_m01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_M02"] = % shipcrib_yel_elevator_hall_one_offs_m02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_N01"] = % shipcrib_yel_elevator_hall_one_offs_n01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_N02"] = % shipcrib_yel_elevator_hall_one_offs_n02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_O01"] = % shipcrib_yel_elevator_hall_one_offs_o01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_O02"] = % shipcrib_yel_elevator_hall_one_offs_o02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_P01"] = % shipcrib_yel_elevator_hall_one_offs_p01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_P02"] = % shipcrib_yel_elevator_hall_one_offs_p02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_Q01"] = % shipcrib_yel_elevator_hall_one_offs_q01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_Q02"] = % shipcrib_yel_elevator_hall_one_offs_q02;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_R01"] = % shipcrib_yel_elevator_hall_one_offs_r01;
  level._id_EC85["generic"]["shipcrib_yel_elevator_hall_one_offs_R02"] = % shipcrib_yel_elevator_hall_one_offs_r02;
  level._id_EC85["generic"]["shipcrib_dressdown_A01"] = % shipcrib_dressdown_a01;
  level._id_EC85["generic"]["shipcrib_dressdown_A02"] = % shipcrib_dressdown_a02;
  level._id_EC85["generic"]["shipcrib_tg_highfive_01"] = % shipcrib_tg_highfive_01;
  level._id_EC85["generic"]["shipcrib_tg_highfive_02"] = % shipcrib_tg_highfive_02;
  level._id_EC85["generic"]["shipcrib_chillwalll_idle_02"][0] = % shipcrib_chillwalll_idle_02;
  level._id_EC85["generic"]["shipcrib_moon_injured_table_01_A"][0] = % shipcrib_moon_injured_table_01_a;
  level._id_EC85["generic"]["shipcrib_moon_injured_table_01_B"][0] = % shipcrib_moon_injured_table_01_b;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_injured_A"][0] = % shipcrib_moon_injured_grnd_01_idle_injured_a;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_injured_B"][0] = % shipcrib_moon_injured_grnd_01_idle_injured_b;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_death_A"][0] = % shipcrib_moon_injured_grnd_01_idle_death_a;
  level._id_EC85["generic"]["shipcrib_moon_injured_grnd_01_idle_death_B"][0] = % shipcrib_moon_injured_grnd_01_idle_death_b;
}