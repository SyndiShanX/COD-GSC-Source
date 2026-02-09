/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18789.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::_id_2AC2("seaknight", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2ABE("ch_46E_ny_harbor");
  maps\_vehicle::_id_2ABE("vehicle_ch46e");
  maps\_vehicle::_id_2ABE("vehicle_ch46e_notsolid");
  maps\_vehicle::_id_2A02("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::_id_2AC5();
  maps\_vehicle::_id_2ACE(999, 500, 1500);
  maps\_vehicle::_id_2AC6("allies");
  maps\_vehicle::_id_2ACA(::_id_3A9D, ::_id_3A9C);
  maps\_vehicle::_id_2AC1(%sniper_escape_ch46_rotors, undefined, 0);
  maps\_vehicle::_id_2ACD(::_id_3E58);
  var_3 = randomfloatrange(0, 1);
  var_4 = maps\_vehicle::_id_2B1A(var_0, var_2);
  maps\_vehicle::_id_2AAD(var_4, "cockpit_red_cargo02", "tag_light_cargo02", "misc/aircraft_light_cockpit_red", "interior", 0.0);
  maps\_vehicle::_id_2AAD(var_4, "cockpit_blue_cockpit01", "tag_light_cockpit01", "misc/aircraft_light_cockpit_blue", "interior", 0.1);
  maps\_vehicle::_id_2AAD(var_4, "white_blink", "tag_light_belly", "misc/aircraft_light_red_blink", "running", var_3);
  maps\_vehicle::_id_2AAD(var_4, "white_blink_tail", "tag_light_tail", "misc/aircraft_light_red_blink", "running", var_3);
  maps\_vehicle::_id_2AAD(var_4, "wingtip_green1", "tag_light_L_wing1", "misc/aircraft_light_wingtip_green", "running", var_3);
  maps\_vehicle::_id_2AAD(var_4, "wingtip_green2", "tag_light_L_wing2", "misc/aircraft_light_wingtip_green", "running", var_3);
  maps\_vehicle::_id_2AAD(var_4, "wingtip_red1", "tag_light_R_wing1", "misc/aircraft_light_wingtip_red", "running", var_3);
  maps\_vehicle::_id_2AAD(var_4, "wingtip_red2", "tag_light_R_wing2", "misc/aircraft_light_wingtip_red", "running", var_3);
}

_id_2B1D() {
  self._id_295E = distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
  self._id_2941 = 0;
}

_id_3A9C(var_0) {
  var_0[1]._id_2523 = % ch46_doors_open;
  var_0[1]._id_257F = 0;
  var_0[1]._id_2522 = % ch46_doors_close;
  var_0[1]._id_2525 = 0;
  var_0[1]._id_2581 = "seaknight_door_open";
  var_0[1]._id_2527 = "seaknight_door_close";
  var_0[1].delay = getanimlength(%ch46_doors_open) - 1.7;
  var_0[2].delay = getanimlength(%ch46_doors_open) - 1.7;
  var_0[3].delay = getanimlength(%ch46_doors_open) - 1.7;
  var_0[4].delay = getanimlength(%ch46_doors_open) - 1.7;
  return var_0;
}

#using_animtree("generic_human");

_id_3A9D() {
  var_0 = [];

  for(var_1 = 0; var_1 < 6; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  var_0[0]._id_0F59[0] = % seaknight_pilot_idle;
  var_0[0]._id_0F59[1] = % seaknight_pilot_switches;
  var_0[0]._id_0F59[2] = % seaknight_pilot_twitch;
  var_0[0]._id_254D[0] = 1000;
  var_0[0]._id_254D[1] = 400;
  var_0[0]._id_254D[2] = 200;
  var_0[0]._id_24F4 = 0;
  var_0[5]._id_24F4 = 0;
  var_0[1]._id_0F59 = % ch46_unload_1_idle;
  var_0[2]._id_0F59 = % ch46_unload_2_idle;
  var_0[3]._id_0F59 = % ch46_unload_3_idle;
  var_0[4]._id_0F59 = % ch46_unload_4_idle;
  var_0[5]._id_0F59[0] = % seaknight_copilot_idle;
  var_0[5]._id_0F59[1] = % seaknight_copilot_switches;
  var_0[5]._id_0F59[2] = % seaknight_copilot_twitch;
  var_0[5]._id_254D[0] = 1000;
  var_0[5]._id_254D[1] = 400;
  var_0[5]._id_254D[2] = 200;
  var_0[0]._id_24F2 = "tag_detach";
  var_0[1]._id_24F2 = "tag_detach";
  var_0[2]._id_24F2 = "tag_detach";
  var_0[3]._id_24F2 = "tag_detach";
  var_0[4]._id_24F2 = "tag_detach";
  var_0[5]._id_24F2 = "tag_detach";
  var_0[1]._id_257C = % ch46_unload_1;
  var_0[2]._id_257C = % ch46_unload_2;
  var_0[3]._id_257C = % ch46_unload_3;
  var_0[4]._id_257C = % ch46_unload_4;
  var_0[1]._id_2519 = % ch46_load_1;
  var_0[2]._id_2519 = % ch46_load_2;
  var_0[3]._id_2519 = % ch46_load_3;
  var_0[4]._id_2519 = % ch46_load_4;
  return var_0;
}

_id_3E58() {
  var_0 = [];
  var_0["passengers"] = [];
  var_0["passengers"][var_0["passengers"].size] = 1;
  var_0["passengers"][var_0["passengers"].size] = 2;
  var_0["passengers"][var_0["passengers"].size] = 3;
  var_0["passengers"][var_0["passengers"].size] = 4;
  var_0["default"] = var_0["passengers"];
  return var_0;
}

_id_3E84() {}