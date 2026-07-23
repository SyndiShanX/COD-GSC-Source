/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18789.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("seaknight", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("ch_46E_ny_harbor");
  maps\_vehicle::build_deathmodel("vehicle_ch46e");
  maps\_vehicle::build_deathmodel("vehicle_ch46e_notsolid");
  maps\_vehicle::build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_drive(%sniper_escape_ch46_rotors, undefined, 0);
  maps\_vehicle::build_unload_groups(::unload_groups);
  var_3 = randomfloatrange(0, 1);
  var_4 = maps\_vehicle::get_light_model(var_0, var_2);
  maps\_vehicle::build_light(var_4, "cockpit_red_cargo02", "tag_light_cargo02", "misc/aircraft_light_cockpit_red", "interior", 0.0);
  maps\_vehicle::build_light(var_4, "cockpit_blue_cockpit01", "tag_light_cockpit01", "misc/aircraft_light_cockpit_blue", "interior", 0.1);
  maps\_vehicle::build_light(var_4, "white_blink", "tag_light_belly", "misc/aircraft_light_red_blink", "running", var_3);
  maps\_vehicle::build_light(var_4, "white_blink_tail", "tag_light_tail", "misc/aircraft_light_red_blink", "running", var_3);
  maps\_vehicle::build_light(var_4, "wingtip_green1", "tag_light_L_wing1", "misc/aircraft_light_wingtip_green", "running", var_3);
  maps\_vehicle::build_light(var_4, "wingtip_green2", "tag_light_L_wing2", "misc/aircraft_light_wingtip_green", "running", var_3);
  maps\_vehicle::build_light(var_4, "wingtip_red1", "tag_light_R_wing1", "misc/aircraft_light_wingtip_red", "running", var_3);
  maps\_vehicle::build_light(var_4, "wingtip_red2", "tag_light_R_wing2", "misc/aircraft_light_wingtip_red", "running", var_3);
}

init_local() {
  self.originheightoffset = distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
  self.script_badplace = 0;
}

set_vehicle_anims(var_0) {
  var_0[1].vehicle_getoutanim = % ch46_doors_open;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getinanim = % ch46_doors_close;
  var_0[1].vehicle_getinanim_clear = 0;
  var_0[1].vehicle_getoutsound = "seaknight_door_open";
  var_0[1].vehicle_getinsound = "seaknight_door_close";
  var_0[1].delay = getanimlength(%ch46_doors_open) - 1.7;
  var_0[2].delay = getanimlength(%ch46_doors_open) - 1.7;
  var_0[3].delay = getanimlength(%ch46_doors_open) - 1.7;
  var_0[4].delay = getanimlength(%ch46_doors_open) - 1.7;
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 6; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  var_0[0].idle[0] = % seaknight_pilot_idle;
  var_0[0].idle[1] = % seaknight_pilot_switches;
  var_0[0].idle[2] = % seaknight_pilot_twitch;
  var_0[0].idleoccurrence[0] = 1000;
  var_0[0].idleoccurrence[1] = 400;
  var_0[0].idleoccurrence[2] = 200;
  var_0[0].bhasgunwhileriding = 0;
  var_0[5].bhasgunwhileriding = 0;
  var_0[1].idle = % ch46_unload_1_idle;
  var_0[2].idle = % ch46_unload_2_idle;
  var_0[3].idle = % ch46_unload_3_idle;
  var_0[4].idle = % ch46_unload_4_idle;
  var_0[5].idle[0] = % seaknight_copilot_idle;
  var_0[5].idle[1] = % seaknight_copilot_switches;
  var_0[5].idle[2] = % seaknight_copilot_twitch;
  var_0[5].idleoccurrence[0] = 1000;
  var_0[5].idleoccurrence[1] = 400;
  var_0[5].idleoccurrence[2] = 200;
  var_0[0].sittag = "tag_detach";
  var_0[1].sittag = "tag_detach";
  var_0[2].sittag = "tag_detach";
  var_0[3].sittag = "tag_detach";
  var_0[4].sittag = "tag_detach";
  var_0[5].sittag = "tag_detach";
  var_0[1].getout = % ch46_unload_1;
  var_0[2].getout = % ch46_unload_2;
  var_0[3].getout = % ch46_unload_3;
  var_0[4].getout = % ch46_unload_4;
  var_0[1].getin = % ch46_load_1;
  var_0[2].getin = % ch46_load_2;
  var_0[3].getin = % ch46_load_3;
  var_0[4].getin = % ch46_load_4;
  return var_0;
}

unload_groups() {
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