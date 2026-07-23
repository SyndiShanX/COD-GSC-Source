/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\25894.gsc
**************************************/

main(var_0, var_1) {
  if(!isDefined(level._effect)) {
    level._effect = [];
  }
  level._effect["flare_runner_intro"] = loadfx("misc/flare_start");
  level._effect["flare_runner"] = loadfx("misc/flare_pb");
  level._effect["flare_runner_fizzout"] = loadfx("misc/flare_end");
  maps\_vehicle::build_template("flare", var_0, var_1, "script_vehicle");
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_life(9999);
}

init_local() {}

merge_suncolor(var_0, var_1, var_2, var_3) {
  wait(var_0);
  var_1 = var_1 * 20;
  var_4 = [];

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = var_5 / var_1;
    level.thedif = var_6;
    var_7 = [];

    for(var_8 = 0; var_8 < 3; var_8++) {
      var_7[var_8] = var_3[var_8] * var_6 + var_2[var_8] * (1 - var_6);
    }
    level.sun_color = (var_7[0], var_7[1], var_7[2]);
    wait 0.05;
  }
}

merge_sunsingledvar(var_0, var_1, var_2, var_3, var_4) {
  setsaveddvar(var_0, var_3);
  wait(var_1);
  var_2 = var_2 * 20;
  var_5 = [];

  for(var_6 = 0; var_6 < var_2; var_6++) {
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

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = var_5 / var_1;
    level.thedif = var_6;
    var_7 = var_3 * var_6 + var_2 * (1 - var_6);
    level.sun_brightness = var_7;
    wait 0.05;
  }

  level.sun_brightness = var_3;
}

combine_sunlight_and_brightness() {
  level endon("stop_combining_sunlight_and_brightness");
  wait 0.05;

  for(;;) {
    var_0 = level.sun_brightness;

    if(var_0 > 1) {
      var_0 = var_0 + randomfloat(0.2);
    }
    var_1 = level.sun_color * var_0;
    setsunlight(var_1[0], var_1[1], var_1[2]);
    wait 0.05;
  }
}

flare_path() {
  thread maps\_vehicle::gopath(self);
  self waittill("flare_complete");
  self delete();
}

flare_initial_fx() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  playFXOnTag(level._effect["flare_runner_intro"], var_0, "tag_origin");
  self waittillmatch("noteworthy", "flare_intro_node");
  var_0 delete();
}

flare_explodes() {
  level notify("flare_explodes");
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  playFXOnTag(level._effect["flare_runner"], var_0, "tag_origin");
  self waittillmatch("noteworthy", "flare_fade_node");
  var_0 delete();
}

flare_burns_out() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  playFXOnTag(level._effect["flare_runner_fizzout"], var_0, "tag_origin");
  var_0 delete();
  level notify("flare_done");
  wait 1;
  self notify("flare_complete");
}

flare_fx() {
  flare_initial_fx();
  flare_explodes();
  flare_burns_out();
}

flag_flare(var_0) {
  if(!isDefined(level.flag[var_0])) {
    common_scripts\utility::flag_init(var_0);
    return;
  }
}

flare_from_targetname(var_0) {
  var_1 = maps\_vehicle::spawn_vehicle_from_targetname(var_0);
  var_1 thread flare_path();
  var_1 thread flare_fx();
}