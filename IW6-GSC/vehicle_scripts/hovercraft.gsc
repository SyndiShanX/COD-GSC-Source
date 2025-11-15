/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\hovercraft.gsc
******************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("hovercraft", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_hovercraft_enemy");
  maps\_vehicle::build_deathmodel("vehicle_hovercraft");

  if(var_2 == "script_vehicle_hovercraft_enemy")
    maps\_vehicle::build_drive( % hovercraft_enemy_upper_fans, undefined, 0);
  else
    maps\_vehicle::build_drive( % hovercraft_movement, undefined, 0);

  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_rumble("tank_rumble", 0.15, 4.5, 600, 1, 1);
  maps\_vehicle::build_team("allies");
  level._effect["hovercraft_wake_geotrail"] = loadfx("fx/treadfx/hovercraft_wake_geo_trail");
  level._effect["hovercraft_water_splash_loop_water"] = loadfx("fx/water/hovercraft_side_wake");
  level._effect["hovercraft_water_splash_ring"] = loadfx("fx/water/hovercraft_side_wake_ring");
  level._effect["hovercraft_water_splash_loop_dirt"] = loadfx("fx/misc/no_effect");
  level._effect["hovercraft_water_splash_ring_plume"] = loadfx("fx/misc/hover_craft_water_plume");
  level._effect["hovercraft_dirt_splash_ring_plume"] = loadfx("fx/misc/hover_craft_dirt_plume");
}

init_local() {
  thread hovercraft_treadfx();
}

set_vehicle_anims(var_0) {
  return var_0;
}

hovercraft_treadfx() {
  self.water_splash_reset_function = ::water_splash_reset_hovercraft;
  thread water_splash();
}

hovercraft_treadfx_chaser(var_0) {
  self.origin = var_0 common_scripts\utility::tag_project("tag_origin", -10000);
  wait 0.1;
  playFXOnTag(common_scripts\utility::getfx("hovercraft_wake_geotrail"), self, "tag_origin");
  var_1 = 1;
  self notsolid();
  self hide();
  var_2 = (0, var_0.angles[1], 0);

  while(isalive(var_0)) {
    self.origin = var_0 gettagorigin("tag_origin") + (0, 0, 8);
    var_2 = common_scripts\utility::flat_angle(self.angles);
    self.angles = var_2;

    if(isDefined(var_0.surfacetype)) {
      if(var_1) {
        if(var_0.surfacetype != "water") {
          var_1 = 0;
          stopFXOnTag(common_scripts\utility::getfx("hovercraft_wake_geotrail"), self, "tag_origin");
        }
      } else if(var_0.surfacetype == "water") {
        playFXOnTag(common_scripts\utility::getfx("hovercraft_wake_geotrail"), self, "tag_origin");
        var_1 = 1;
      }
    }

    wait 0.05;
  }

  self delete();
}

water_splash_reset_hovercraft(var_0) {
  var_0.water_tags = [];
  var_0.water_tag_trace_cache = [];
  var_0.water_fx = [];
  var_0.water_fx["water"] = common_scripts\utility::getfx("hovercraft_water_splash_loop_water");
  var_0.water_fx["dirt"] = common_scripts\utility::getfx("hovercraft_water_splash_loop_dirt");
  var_0.water_fx["concrete"] = common_scripts\utility::getfx("hovercraft_water_splash_loop_dirt");
  var_0.water_fx["mud"] = common_scripts\utility::getfx("hovercraft_water_splash_loop_dirt");
  var_0.water_fx["default"] = common_scripts\utility::getfx("hovercraft_water_splash_loop_dirt");
  var_0.water_fx["sand"] = common_scripts\utility::getfx("hovercraft_water_splash_loop_dirt");
  var_0.water_fx_ring = common_scripts\utility::getfx("hovercraft_water_splash_ring");
  var_0.water_fx_plume = [];
  var_0.water_fx_plume["water"] = common_scripts\utility::getfx("hovercraft_water_splash_ring_plume");
  var_0.water_fx_plume["dirt"] = common_scripts\utility::getfx("hovercraft_dirt_splash_ring_plume");
  var_0.water_fx_plume["concrete"] = common_scripts\utility::getfx("hovercraft_dirt_splash_ring_plume");
  var_0.water_fx_plume["mud"] = common_scripts\utility::getfx("hovercraft_dirt_splash_ring_plume");
  var_0.water_fx_plume["sand"] = common_scripts\utility::getfx("hovercraft_dirt_splash_ring_plume");
  var_0.splash_delay = 0.01;
  var_0.ring_interval = 5;
  var_1 = 0;

  for(var_2 = 0; var_2 < 12; var_2++) {
    if(var_2 == 4 || var_2 == 5 || var_2 == 6) {
      continue;
    }
    var_0.water_tags[var_1] = "TAG_FX_WATER_SPLASH" + var_2;
    var_0.water_tag_trace_cache[var_1] = create_trace_cache(var_1);
    var_1++;
  }
}

create_trace_cache(var_0) {
  var_1 = spawnStruct();
  var_1.last_time = gettime() - (2000 - var_0);
  var_1.trace = [];
  var_1.trace["position"] = self.origin;
  return var_1;
}

water_splash() {
  self endon("death");
  self.touching_water_trigger = 1;
  var_0 = maps\_vehicle::get_dummy();
  var_1 = self.touching_trigger_ent;

  if(!isDefined(self.water_splash_info)) {
    var_2 = spawnStruct();
    self.water_splash_info = var_2;
    [[self.water_splash_reset_function]](var_2);
  } else
    var_2 = self.water_splash_info;

  var_3 = var_2.ring_interval;
  var_4 = 1;
  self.water_plume_inc = 0;
  self.water_plume_next = randomintrange(3, 5);

  for(;;) {
    wait(var_2.splash_delay);

    if(self vehicle_getspeed() < 1) {
      continue;
    }
    if(distancesquared(self.origin, level.player getEye()) < 64000000)
      wait(var_2.splash_delay);

    for(var_5 = 0; var_5 < var_2.water_tags.size; var_5++)
      water_splash_single(var_5);

    var_0 = maps\_vehicle::get_dummy();

    if(var_0 != self) {
      var_1 = var_0;
      continue;
    }

    var_1 = self.touching_trigger_ent;
  }
}

water_splash_single(var_0, var_1) {
  var_2 = self.water_splash_info;
  var_3 = maps\_vehicle::get_dummy();
  var_4 = var_2.water_tags[var_0];
  var_5 = var_3 gettagorigin(var_4);
  var_6 = var_5 + (0, 0, 150);
  var_7 = var_5 - (0, 0, 150);
  var_8 = var_2.water_tag_trace_cache[var_0];

  if(gettime() - var_8.last_time >= 2000) {
    var_9 = bulletTrace(var_6, var_7, 0, self);
    var_8.last_time = gettime();
    var_8.trace = var_9;
  } else {
    var_8.trace["position"] = maps\_utility::set_z(var_5, var_8.trace["position"][2]);
    var_9 = var_8.trace;
  }

  if(!isDefined(var_2.water_fx[var_9["surfacetype"]])) {
    return;
  }
  var_10 = var_9["surfacetype"];
  self.surfacetype = var_10;

  if(var_10 != "water")
    var_1 = 0;

  var_6 = var_9["position"];

  if(var_9["fraction"] == 1) {
    return;
  }
  var_11 = common_scripts\utility::flat_angle(var_3 gettagangles(var_4));
  var_12 = anglesToForward(var_11);
  var_13 = anglestoup(var_11);

  if(distancesquared(var_6, level.player getEye()) < 64000000) {
    if(isDefined(self.use_big_splash)) {
      if(var_4 == "TAG_FX_WATER_SPLASH3" || var_4 == "TAG_FX_WATER_SPLASH7") {
        if(isDefined(var_2.water_fx[var_10 + "_big"]))
          var_10 = var_10 + "_big";
      }
    }

    playFX(var_2.water_fx[var_10], var_6, var_13, var_12);
  }
}