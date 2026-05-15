/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_snow_fx.gsc
*****************************************************/

main() {
  level._effect["satellite_fall_child8"] = loadfx("vfx/moments/mp_snow/satellite_fall_child8");
  level._effect["satellite_fall_child0"] = loadfx("vfx/moments/mp_snow/satellite_fall_child0");
  level._effect["satellite_fall_child1"] = loadfx("vfx/moments/mp_snow/satellite_fall_child1");
  level._effect["satellite_fall_child2"] = loadfx("vfx/moments/mp_snow/satellite_fall_child2");
  level._effect["satellite_fall_child3"] = loadfx("vfx/moments/mp_snow/satellite_fall_child3");
  level._effect["satellite_fall_child4"] = loadfx("vfx/moments/mp_snow/satellite_fall_child4");
  level._effect["satellite_fall_child5"] = loadfx("vfx/moments/mp_snow/satellite_fall_child5");
  level._effect["satellite_fall_child6"] = loadfx("vfx/moments/mp_snow/satellite_fall_child6");
  level._effect["satellite_fall_child7"] = loadfx("vfx/moments/mp_snow/satellite_fall_child7");
  level._effect["vfx_fire_server_sov"] = loadfx("vfx/ambient/fire/electrical/vfx_fire_server_sov");
  level._effect["vfx_fire_server_sov_ngonly"] = loadfx("vfx/ambient/fire/electrical/vfx_fire_server_sov_ngonly");
  level._effect["vfx_snd_emt_snow_fire_small_wood2"] = loadfx("vfx/moments/mp_snow/vfx_snd_emt_snow_fire_small_wood2");
  level._effect["satellite_fall_impact"] = loadfx("vfx/moments/mp_snow/satellite_fall_impact");
  level._effect["vfx_snd_emt_snow_fire_small_wood"] = loadfx("vfx/moments/mp_snow/vfx_snd_emt_snow_fire_small_wood");
  level._effect["vfx_snd_emt_snow_fire_med_sat_lp"] = loadfx("vfx/moments/mp_snow/vfx_snd_emt_snow_fire_med_sat_lp");
  level._effect["embers_burst_runner_cheap"] = loadfx("vfx/moments/mp_warhawk/embers_burst_runner_cheap");
  level._effect["vfx_ground_embers_mp"] = loadfx("vfx/moments/mp_snow/vfx_ground_embers_mp");
  level._effect["snow_tree_impact"] = loadfx("fx/explosions/snow_tree_impact");
  level._effect["snow_light_mp_oneshot"] = loadfx("fx/snow/snow_light_mp_oneshot");
  level._effect["snow_sattelite_impact"] = loadfx("fx/explosions/snow_sattelite_impact");
  level._effect["satellite_fall"] = loadfx("vfx/moments/mp_snow/satellite_fall_parent");
  level._effect["vfx_tree_fire_stump"] = loadfx("vfx/ambient/fire/wood/vfx_tree_fire_stump");
  level._effect["water_splashes_sm_runner"] = loadfx("vfx/moments/mp_snow/water_splashes_sm_runner");
  level._effect["vfx_snow_chopper_spiral"] = loadfx("vfx/ambient/weather/snow/vfx_snow_chopper_spiral");
  level._effect["vfx_fireplace"] = loadfx("vfx/ambient/fire/vfx_fireplace");
  level._effect["snow_door_runner"] = loadfx("fx/snow/snow_door_runner");
  level._effect["snow_window_runner"] = loadfx("fx/snow/snow_window_runner");
  level._effect["mp_snow_lighthouse"] = loadfx("vfx/moments/mp_snow/mp_snow_lighthouse");
  level._effect["vfx_falling_dirt_cave_runner"] = loadfx("vfx/moments/mp_snow/vfx_falling_dirt_cave_runner");
  level._effect["water_splashes_runner"] = loadfx("vfx/moments/mp_snow/water_splashes_runner");
  level._effect["vfx_snow_trail_falling_thin"] = loadfx("vfx/ambient/weather/snow/vfx_snow_trail_falling_thin");
  level._effect["snow_falling_tree_mp"] = loadfx("fx/snow/snow_falling_tree_mp");
  level._effect["chimney_smoke_mp_snow"] = loadfx("fx/smoke/chimney_smoke_mp_snow");
  level._effect["vfx_int_haze_mp_snow_thick"] = loadfx("vfx/ambient/atmospheric/vfx_int_haze_mp_snow_thick");
  level._effect["vfx_int_haze_mp_snow"] = loadfx("vfx/ambient/atmospheric/vfx_int_haze_mp_snow");
  level._effect["snow_spiral_updraft_runner"] = loadfx("vfx/ambient/weather/snow/snow_spiral_updraft_runner");
  level._effect["heat_vent_mp_snow"] = loadfx("vfx/ambient/misc/heat_vent_mp_snow");
  level._effect["vfx_bulb_prismatic_mp_snow"] = loadfx("vfx/ambient/lights/vfx_bulb_prismatic_mp_snow");
  level._effect["vfx_fog_water_mp"] = loadfx("vfx/ambient/atmospheric/vfx_fog_water_mp");
  level._effect["snow_spray_oriented_short"] = loadfx("fx/snow/snow_spray_oriented_short");
  level._effect["vfx_lantern"] = loadfx("vfx/ambient/misc/vfx_lantern");
  level._effect["drips_slow_10x10_mp"] = loadfx("fx/misc/drips_slow_10x10_mp");
  level._effect["snow_light_mp"] = loadfx("fx/snow/snow_light_mp");
  level._effect["flashlight_spotlight_mp"] = loadfx("vfx/ambient/lights/flashlight_spotlight_mp");
  level._effect["vfx_light_beam_outdoor_sm_mp_snow"] = loadfx("vfx/ambient/lights/vfx_light_beam_outdoor_sm_mp_snow");
  level._effect["vfx_light_beam_window_mp_snow2"] = loadfx("vfx/ambient/lights/vfx_light_beam_window_mp_snow2");
  level._effect["vfx_light_beam_window_mp_snow"] = loadfx("vfx/ambient/lights/vfx_light_beam_window_mp_snow");
  level._effect["vfx_light_blink_distance_red"] = loadfx("vfx/ambient/lights/vfx_light_blink_distance_red");
  level._effect["vfx_light_beam_outdoor_lg_mp_snow"] = loadfx("vfx/ambient/lights/vfx_light_beam_outdoor_lg_mp_snow");
  level._effect["vfx_light_beam_outdoor_mp_snow"] = loadfx("vfx/ambient/lights/vfx_light_beam_outdoor_mp_snow");
  level._effect["vfx_bulb_prismatic_mp_snow_flare"] = loadfx("vfx/ambient/lights/vfx_bulb_prismatic_mp_snow_flare");
  level._effect["vfx_oilrig_fire"] = loadfx("vfx/moments/mp_snow/vfx_oilrig_fire");
  level.snowspeed = 1;
  level thread rampsnow();
  level thread snow();
  var_0 = getEntArray("sn_fan", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread rotatefan();
  }
}

snow() {
  for(;;) {
    wait(level.snowspeed);

    if(common_scripts\utility::flag("satellite_incoming")) {
      common_scripts\utility::flag_wait("satellite_incoming");
      wait 3;
    }

    common_scripts\utility::exploder(20);
  }
}

rampsnow() {
  var_0 = 0.39;
  var_1 = 1;

  if(!maps\mp\_utility::is_gen4()) {
    level.snowspeed = var_1;
    return;
  }

  for(;;) {
    wait(randomfloatrange(40, 55));

    while(level.snowspeed > var_0) {
      wait 0.5;
      level.snowspeed = level.snowspeed - 0.1;
    }

    wait(randomfloatrange(1, 3));

    while(level.snowspeed < var_1) {
      wait 0.5;
      level.snowspeed = level.snowspeed + 0.1;
    }
  }
}

rotatefan() {
  self endon("death");

  for(;;) {
    self rotateyaw(-360, 5);
    wait 5;
  }
}

setoverlay() {
  self endon("death");
  var_0 = "fullscreen_dirtylense";
  var_1 = 1;
  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in level.players) {
    iprintlnbold("Starting");
    var_6 = newclienthudelem(var_5);
    var_6.x = var_2;
    var_6.y = var_3;
    var_7 = var_5 worldpointtoscreenpos(self.origin, 65);
    var_6.x = var_7[0];
    var_6.y = var_7[1];
    var_6 setshader(var_0, int(100), int(100));
    var_6.alignx = "center";
    var_6.aligny = "middle";
    var_6.sort = 1;
    var_6.horzalign = "center";
    var_6.vertalign = "middle";
    var_6.foreground = 1;
    var_6.hidewhendead = 1;
    var_6.enablehudlighting = 1;
    var_6.glowcolor = (1, 1, 1);
    var_6.glowalpha = 1.0;
    var_6.alpha = 1.0;

    for(;;) {
      var_7 = var_5 worldpointtoscreenpos(self.origin, 65);

      if(isDefined(var_7)) {
        var_6.x = var_7[0];
        var_6.y = var_7[1];
      }

      common_scripts\utility::waitframe();
    }
  }
}