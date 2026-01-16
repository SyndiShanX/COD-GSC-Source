/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_flare.gsc
********************************/

main(var_0, var_1) {
  if(!isdefined(level._effect))
    level._effect = [];

  level._effect["flare_runner_intro"] = loadfx("fx\misc\flare_start");
  level._effect["flare_runner"] = loadfx("fx\misc\flare");
  level._effect["flare_runner_fizzout"] = loadfx("fx\misc\flare_end");
  maps\_vehicle::build_template("flare", var_0, var_1, "script_vehicle_flare");
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_life(9999);
}

init_local() {}

merge_suncolor(var_0, var_1, var_2, var_3) {
  wait(var_0);
  var_1 = var_1 * 20;
  var_4 = [];

  for (var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = var_5 / var_1;
    level.thedif = var_6;
    var_7 = [];

    for (var_8 = 0; var_8 < 3; var_8++)
      var_7[var_8] = var_3[var_8] * var_6 + var_2[var_8] * (1 - var_6);

    level.sun_color = (var_7[0], var_7[1], var_7[2]);
    wait 0.05;
  }
}

merge_sunsingledvar(var_0, var_1, var_2, var_3, var_4) {
  setsaveddvar(var_0, var_3);
  wait(var_1);
  var_2 = var_2 * 20;
  var_5 = [];

  for (var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_6 / var_2;
    level.thedif = var_7;
    var_8 = var_4 * var_7 + var_3 * (1 - var_7);
    setsaveddvar(var_0, var_8);
    wait 0.05;
  }

  setsaveddvar(var_0, var_4);
}

merge_sunbrightness(var_0, var_1, var_2, var_3) {
  wait(var_0);
  var_1 = var_1 * 20;
  var_4 = [];

  for (var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = var_5 / var_1;
    level.thedif = var_6;
    var_7 = var_3 * var_6 + var_2 * (1 - var_6);
    level.sun_brightness = var_7;
    wait 0.05;
  }

  level.sun_brightness = var_3;
}

normalized_color(var_0) {
  var_1 = 1.0;

  if(var_0[0] > var_0[1]) {
    if(var_0[0] > var_0[2])
      var_1 = var_0[0];
    else
      var_1 = var_0[2];
  } else if(var_0[1] > var_0[2])
    var_1 = var_0[1];
  else
    var_1 = var_0[2];

  if(var_1 < 0.01)
    return var_0;

  var_0[0] = var_0[0] / var_1;
  var_0[1] = var_0[1] / var_1;
  var_0[2] = var_0[2] / var_1;
  return var_0;
}

combine_sunlight_and_brightness() {
  level endon("stop_combining_sunlight_and_brightness");
  wait 0.05;

  for (;;) {
    var_0 = level.sun_brightness;

    if(var_0 > 0.01)
      var_0 = var_0 * (0.8 + randomfloat(0.4));

    var_1 = level.sun_color * var_0;
    setsunlight(var_1[0], var_1[1], var_1[2]);
    wait 0.05;
  }
}

flare_path() {
  thread maps\_vehicle::gopath(self);
  common_scripts\utility::flag_wait("flare_stop_setting_sundir");
  self delete();
}

flare_initial_fx() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setmodel("tag_origin");
  var_0 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  playfxontag(level._effect["flare_runner_intro"], var_0, "tag_origin");
  self waittillmatch("noteworthy", "flare_intro_node");
  var_0 delete();
}

flare_explodes() {
  common_scripts\utility::flag_set("flare_start_setting_sundir");
  level.red_suncolor = [];
  level.red_suncolor[0] = 1.0;
  level.red_suncolor[1] = 0.05;
  level.red_suncolor[2] = 0.05;
  level.red_suncolor = normalized_color(level.red_suncolor);
  level.red_suncolor = (common_scripts\utility::lineartogamma_srgb(level.red_suncolor[0]), common_scripts\utility::lineartogamma_srgb(level.red_suncolor[1]), common_scripts\utility::lineartogamma_srgb(level.red_suncolor[2]));
  level.red_sunbrightness = 0.015;
  level.original_suncolor = getmapsunlight();
  level.original_brightness = 0.0;
  level.sun_color = normalized_color(level.original_suncolor);
  level.sun_brightness = level.original_brightness;
  thread merge_sunsingledvar("sm_sunSampleSizeNear", 0, 1.0, 0.25, 1);
  thread combine_sunlight_and_brightness();
  thread merge_suncolor(0, 1.0, normalized_color(level.original_suncolor), level.red_suncolor);
  thread merge_sunbrightness(0, 1.0, level.original_brightness, level.red_sunbrightness);

  if(isdefined(level.flare_fog))
    maps\_utility::vision_set_fog_changes(level.flare_fog, 1.0);

  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setmodel("tag_origin");
  var_0 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  playfxontag(level._effect["flare_runner"], var_0, "tag_origin");
  self waittillmatch("noteworthy", "flare_fade_node");
  var_0 delete();
}

flare_burns_out() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setmodel("tag_origin");
  var_0 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  playfxontag(level._effect["flare_runner_fizzout"], var_0, "tag_origin");
  var_0 thread maps\_utility::play_sound_on_tag_endon_death("flare_runner_fizzout");
  thread merge_sunsingledvar("sm_sunSampleSizeNear", 0, 1, 1, 0.5);
  thread merge_sunbrightness(0, 1, level.red_sunbrightness, level.original_brightness);
  thread merge_suncolor(0, 0.01, level.red_suncolor, normalized_color(level.original_suncolor));

  if(isdefined(level.flare_fog_return))
    maps\_utility::vision_set_fog_changes(level.flare_fog_return, 1);

  thread maps\_vehicle::volume_down(1);
  wait 1.0;
  level notify("stop_combining_sunlight_and_brightness");
  wait 0.1;
  common_scripts\utility::flag_set("flare_stop_setting_sundir");
  waittillframeend;
  var_0 delete();
  resetsundirection();
  resetsunlight();
  common_scripts\utility::flag_set("flare_complete");
}

flare_fx() {
  flare_initial_fx();
  flare_explodes();
  flare_burns_out();
}

flag_flare(var_0) {
  if(!isdefined(level.flag[var_0])) {
    common_scripts\utility::flag_init(var_0);
    return;
  }
}

flare_from_targetname(var_0) {
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname(var_0);
  flag_flare("flare_in_use");
  flag_flare("flare_complete");
  flag_flare("flare_stop_setting_sundir");
  flag_flare("flare_start_setting_sundir");
  common_scripts\utility::flag_waitopen("flare_in_use");
  common_scripts\utility::flag_set("flare_in_use");
  resetsunlight();
  resetsundirection();
  var_1 thread flare_path();
  var_1 thread flare_fx();
  var_2 = getmapsundirection();
  var_3 = var_2;
  var_4 = var_3 * -100;
  common_scripts\utility::flag_wait("flare_start_setting_sundir");
  var_5 = getent(var_1.script_linkto, "script_linkname").origin;
  var_3 = vectortoangles(var_1.origin - var_5);
  var_6 = anglestoforward(var_3);

  for (;;) {
    wait 0.05;

    if(common_scripts\utility::flag("flare_stop_setting_sundir")) {
      break;
    }

    var_3 = vectortoangles(var_1.origin - var_5);
    var_7 = anglestoforward(var_3);
    lerpsundirection(var_6, var_7, 0.05);
    var_6 = var_7;
  }

  common_scripts\utility::flag_wait("flare_complete");
  waittillframeend;
  common_scripts\utility::flag_clear("flare_complete");
  common_scripts\utility::flag_clear("flare_stop_setting_sundir");
  common_scripts\utility::flag_clear("flare_start_setting_sundir");
  resetsunlight();
  resetsundirection();
  common_scripts\utility::flag_clear("flare_in_use");
}