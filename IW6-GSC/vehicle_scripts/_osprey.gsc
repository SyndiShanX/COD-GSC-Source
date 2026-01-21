/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_osprey.gsc
***************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("osprey", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_v22_osprey");
  maps\_vehicle::build_deathmodel("vehicle_v22_osprey_fly");
  maps\_vehicle::build_deathmodel("vehicle_v22_osprey_heli");
  maps\_vehicle::build_deathmodel("vehicle_v22_osprey_tailgunner");
  maps\_vehicle::build_deathfx("fx/explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_rocket_deathfx("fx/explosions/aerial_explosion_apache_mp", "tag_deathfx", "apache_helicopter_crash", undefined, undefined, undefined, undefined, 1, undefined, 0, 5);

  if(var_2 == "script_vehicle_osprey_tailgunner")
    maps\_vehicle::build_turret("osprey_tailgunner_turret", "tag_player_turret", "weapon_chinese_brave_warrior_turret", undefined, "manual", undefined, 0, 0, (128, 0, 16));

  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
  maps\_vehicle::build_drive(%v22_osprey_props, undefined, 0);
  maps\_vehicle::build_unload_groups(::unload_groups);
  var_3 = randomfloatrange(0, 1);
  maps\_vehicle::build_light(var_2, "cockpit_red_cargo02", "tag_light_cargo02", "fx/misc/aircraft_light_cockpit_red", "interior", 0.0);
  maps\_vehicle::build_light(var_2, "cockpit_blue_cockpit01", "tag_light_cockpit01", "fx/misc/aircraft_light_cockpit_blue", "interior", 0.1);
  maps\_vehicle::build_light(var_2, "white_blink", "tag_light_belly", "fx/misc/aircraft_light_red_blink", "running", var_3);
  maps\_vehicle::build_light(var_2, "white_blink_tail", "tag_light_tail", "fx/misc/aircraft_light_red_blink", "running", var_3);
  thread handle_landing();

  if(var_2 == "script_vehicle_osprey_heli")
    maps\_vehicle::build_is_helicopter();
  else
    maps\_vehicle::build_is_airplane();
}

handle_landing() {
  level waittill("load_finished");
  var_0 = getvehiclenodearray("osprey_landing", "script_noteworthy");
  var_1 = getvehiclenodearray("osprey_take_off", "script_noteworthy");
  common_scripts\utility::array_thread(var_0, ::land_structs_think, 1);
  common_scripts\utility::array_thread(var_1, ::land_structs_think, 0);
}

land_structs_think(var_0) {
  var_1 = % v22_osprey_wings_down;
  var_2 = % v22_osprey_wings_up;

  if(!var_0) {
    var_1 = % v22_osprey_wings_up;
    var_2 = % v22_osprey_wings_down;
  }

  for(;;) {
    self waittill("trigger", var_3);
    var_3 endon("death");
    var_3 clearanim(var_1, 1);
    wait 1;
    var_3 setanimrestart(var_2, 1, 0, 0.15);

    if(!var_0) {
      var_3 notify("stop_kicking_up_dust");
      var_3 clearanim(%v22_osprey_hatch_down, 0.2);
      wait 0.2;
      var_3 setanimrestart(%v22_osprey_hatch_up);
      continue;
    }

    var_3 maps\_vehicle::aircraft_wash();
  }
}

init_local() {
  self.dontdisconnectpaths = 1;
  self.originheightoffset = distance(self gettagorigin("tag_origin"), self gettagorigin("tag_ground"));
  self.script_badplace = 0;
  self.enablerocketdeath = 1;
  wait 0.05;
  self notify("stop_kicking_up_dust");
  maps\_vehicle::vehicle_lights_on("running");

  if(self.classname == "script_vehicle_osprey_heli")
    thread wings_up();
}

wings_up() {
  self useanimtree(#animtree);
  self setanim(%v22_osprey_wings_up);
}

set_vehicle_anims(var_0) {
  var_0[1].vehicle_getoutanim = % v22_osprey_hatch_down;
  var_0[1].vehicle_getoutanim_clear = 0;
  var_0[1].vehicle_getinanim = % v22_osprey_hatch_up;
  var_0[1].vehicle_getinanim_clear = 0;
  var_0[1].vehicle_getoutsound = "osprey_door_open";
  var_0[1].vehicle_getinsound = "osprey_door_close";
  var_0[1].delay = getanimlength(%v22_osprey_hatch_down) - 1.7;
  var_0[2].delay = getanimlength(%v22_osprey_hatch_down) - 1.7;
  var_0[3].delay = getanimlength(%v22_osprey_hatch_down) - 1.7;
  var_0[4].delay = getanimlength(%v22_osprey_hatch_down) - 1.7;
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 6; var_1++)
    var_0[var_1] = spawnStruct();

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
  var_0[0].sittag = "tag_detach_pilots";
  var_0[1].sittag = "tag_detach";
  var_0[2].sittag = "tag_detach";
  var_0[3].sittag = "tag_detach";
  var_0[4].sittag = "tag_detach";
  var_0[5].sittag = "tag_detach_pilots";
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