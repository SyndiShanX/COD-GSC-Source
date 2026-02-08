/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_flare.gsc
**************************************/

#include maps\_vehicle_aianim;
#include maps\_utility;
#include maps\_vehicle;
#include common_scripts\utility;
#using_animtree("vehicles");
main(model, type, color) {
  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  if(!isDefined(color)) {
    color = "default";
  }

  switch (color) {
    case "white":
      level._effect["flare_runner_intro"] = loadfx("misc/flare_start");
      level._effect["flare_runner"] = loadfx("misc/fx_flare_sky_white");
      level._effect["flare_runner_fizzout"] = loadfx("misc/flare_end");
      break;

    default:
      level._effect["flare_runner_intro"] = loadfx("misc/flare_start");
      level._effect["flare_runner"] = loadfx("misc/flare");
      level._effect["flare_runner_fizzout"] = loadfx("misc/flare_end");
      break;
  }

  flag_flare("flare_in_use");
  flag_flare("flare_complete");
  flag_flare("flare_stop_setting_sundir");
  flag_flare("flare_start_setting_sundir");

  build_template("flare", model, type);
  build_localinit(::init_local);

  build_life(9999);

  if(!isDefined(level._flare_monitor)) {
    level thread flare_monitor();
    level._flare_monitor = 1;
  }
}

flare_monitor() {
  level._flare_frame = 0;

  while(1) {
    wait_network_frame();
    level._flare_frame = !level._flare_frame;
  }
}

is_position_frame() {
  return (level._flare_frame == 0);
}

is_color_frame() {
  return (level._flare_frame == 1);
}

init_local() {}

merge_suncolor(delay, timer, rgb1, rgb2) {
  wait(delay);
  timer = timer * 20;
  suncolor = [];

  for(i = 0; i < timer; i++) {
    dif = i / timer;
    level.thedif = dif;
    c = [];
    for(p = 0; p < 3; p++) {
      c[p] = rgb2[p] * dif + rgb1[p] * (1 - dif);
    }

    level.sun_color = (c[0], c[1], c[2]);
    wait(0.05);
  }
}

merge_sunsingledvar(dvar, delay, timer, l1, l2) {
  setsaveddvar(dvar, l1);
  wait(delay);
  timer = timer * 20;
  suncolor = [];

  for(i = 0; i < timer; i++) {
    dif = i / timer;
    level.thedif = dif;
    ld = l2 * dif + l1 * (1 - dif);

    setsaveddvar(dvar, ld);

    if(NumRemoteClients()) {
      wait_network_frame();
    } else {
      wait(0.05);
    }
  }

  setsaveddvar(dvar, l2);
}

merge_sunbrightness(delay, timer, l1, l2) {
  wait(delay);
  timer = timer * 20;
  suncolor = [];
  for(i = 0; i < timer; i++) {
    dif = i / timer;
    level.thedif = dif;
    ld = l2 * dif + l1 * (1 - dif);

    level.sun_brightness = ld;
    wait(0.05);
  }
  level.sun_brightness = l2;
}

combine_sunlight_and_brightness(flicker) {
  level endon("stop_combining_sunlight_and_brightness");
  wait(0.05);
  for(;;) {
    brightness = level.sun_brightness;

    brightness += randomfloat(flicker);

    rgb = vector_Multiply(level.sun_color, brightness);
    if(NumRemoteClients()) {
      if(is_color_frame()) {
        setSunLight(rgb[0], rgb[1], rgb[2]);
        println("set col");
        wait_network_frame();
      }
    } else {
      setSunLight(rgb[0], rgb[1], rgb[2]);
    }
    wait(0.1);
  }
}

flare_path() {
  thread goPath(self);
  flag_wait("flare_stop_setting_sundir");
  self delete();
}

flare_initial_fx() {
  model = spawn("script_model", (0, 0, 0));
  model setModel("tag_origin");
  model linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  model playSound("flare_launch");
  playFXOnTag(level._effect["flare_runner_intro"], model, "tag_origin");
  self waittill("flare_intro_node");
  model delete();
}

flare_explodes(starting_brightness, ending_brightness, flicker, color) {
  flag_set("flare_start_setting_sundir");
  level.sun_brightness = 1;
  level.flare_suncolor = color;
  level.original_suncolor = getMapSunLight();
  level.sun_color = level.original_suncolor;
  thread merge_sunsingledvar("sm_sunSampleSizeNear", 0, 0.25, 0.25, 1);

  thread combine_sunlight_and_brightness(flicker);
  thread merge_suncolor(0, 0.25, level.original_sunColor, level.flare_suncolor);
  thread merge_sunbrightness(0, 0.25, starting_brightness, ending_brightness);

  self playSound("flare_exp");

  model2 = spawn("script_model", (0, 0, 0));
  model2 setModel("tag_origin");
  model2 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  playFXOnTag(level._effect["flare_runner"], model2, "tag_origin");

  model2 playLoopSound("flare_loop");

  self waittill("flare_fade_node");

  model2 stoploopsound(3);
  wait(3);
  model2 delete();
}

flare_burns_out() {
  model3 = spawn("script_model", (0, 0, 0));
  model3 setModel("tag_origin");
  model3 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));

  playFXOnTag(level._effect["flare_runner_fizzout"], model3, "tag_origin");
  wait(0.3);

  thread merge_sunsingledvar("sm_sunSampleSizeNear", 0, 1, 1, 0.25);
  thread merge_sunbrightness(0, 1, 3, 0);
  thread merge_suncolor(0, 1, level.flare_suncolor, level.original_suncolor);
  thread merge_sunbrightness(1, 1, 0, 1);

  model3 delete();
  thread volume_down(1);
  wait(1);
  flag_set("flare_stop_setting_sundir");
  resetSunDirection();
  wait(1);
  level notify("stop_combining_sunlight_and_brightness");
  waittillframeend;

  resetSunLight();

  flag_set("flare_complete");
}

flare_fx(starting_brightness, ending_brightness, flicker, color) {
  flare_initial_fx();
  flare_explodes(starting_brightness, ending_brightness, flicker, color);
  flare_burns_out();
}

flag_flare(msg) {
  if(!isDefined(level.flag[msg])) {
    flag_init(msg);
    return;
  }
}

flare_from_targetname(targetname, starting_brightness, ending_brightness, flicker, color) {
  flare = spawn_vehicle_from_targetname(targetname);

  flag_waitopen("flare_in_use");
  flag_set("flare_in_use");

  if(!isDefined(starting_brightness)) {
    starting_brightness = 1;
  }

  if(!isDefined(ending_brightness)) {
    ending_brightness = 3;
  }

  if(!isDefined(flicker)) {
    flicker = 0.2;
  }

  if(!isDefined(color)) {
    color = (0.8, 0.4, 0.4);
  }

  resetSunLight();
  resetSunDirection();
  flare thread flare_path();
  flare thread flare_fx(starting_brightness, ending_brightness, flicker, color);

  sundir = getMapSunDirection();
  angles = sundir;
  vec = vectorscale(angles, -100);

  flag_wait("flare_start_setting_sundir");

  sunPointsTo = getent(flare.script_linkto, "script_linkname").origin;

  angles = vectortoangles(flare.origin - sunPointsTo);
  oldForward = anglesToForward(angles);
  for(;;) {
    wait(0.05);

    if(flag("flare_stop_setting_sundir")) {
      break;
    }

    angles = vectortoangles(flare.origin - sunPointsTo);
    forward = anglesToForward(angles);
    if(NumRemoteClients()) {
      if(is_position_frame()) {
        lerpSunDirection(oldForward, forward, 0.05);
        println("setpos");
        wait_network_frame();
      }
    } else {
      lerpSunDirection(oldForward, forward, 0.05);
    }
    oldForward = forward;
  }

  flag_wait("flare_complete");
  waittillframeend;
  flag_clear("flare_complete");
  flag_clear("flare_stop_setting_sundir");
  flag_clear("flare_start_setting_sundir");
  resetSunLight();
  resetSunDirection();
  flag_clear("flare_in_use");
}