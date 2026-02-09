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
  maps\_vehicle::_id_2AC2("flare", var_0, var_1, "script_vehicle");
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2ACE(9999);
}

_id_2B1D() {}

_id_408E(var_0, var_1, var_2, var_3) {
  wait(var_0);
  var_1 = var_1 * 20;
  var_4 = [];

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = var_5 / var_1;
    level._id_408F = var_6;
    var_7 = [];

    for(var_8 = 0; var_8 < 3; var_8++) {
      var_7[var_8] = var_3[var_8] * var_6 + var_2[var_8] * (1 - var_6);
    }
    level._id_4090 = (var_7[0], var_7[1], var_7[2]);
    wait 0.05;
  }
}

_id_4091(var_0, var_1, var_2, var_3, var_4) {
  setsaveddvar(var_0, var_3);
  wait(var_1);
  var_2 = var_2 * 20;
  var_5 = [];

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_6 / var_2;
    level._id_408F = var_7;
    var_8 = var_4 * var_7 + var_3 * (1 - var_7);
    setsaveddvar(var_0, var_8);
    wait 0.05;
  }

  setsaveddvar(var_0, var_4);
}

_id_4092(var_0, var_1, var_2, var_3) {
  wait(var_0);
  var_1 = var_1 * 20;
  var_4 = [];

  for(var_5 = 0; var_5 < var_1; var_5++) {
    var_6 = var_5 / var_1;
    level._id_408F = var_6;
    var_7 = var_3 * var_6 + var_2 * (1 - var_6);
    level._id_4093 = var_7;
    wait 0.05;
  }

  level._id_4093 = var_3;
}

_id_4094() {
  level endon("stop_combining_sunlight_and_brightness");
  wait 0.05;

  for(;;) {
    var_0 = level._id_4093;

    if(var_0 > 1) {
      var_0 = var_0 + randomfloat(0.2);
    }
    var_1 = level._id_4090 * var_0;
    setsunlight(var_1[0], var_1[1], var_1[2]);
    wait 0.05;
  }
}

_id_4095() {
  thread maps\_vehicle::_id_1FA6(self);
  self waittill("flare_complete");
  self delete();
}

_id_4096() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  playFXOnTag(level._effect["flare_runner_intro"], var_0, "tag_origin");
  self waittillmatch("noteworthy", "flare_intro_node");
  var_0 delete();
}

_id_4097() {
  level notify("flare_explodes");
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  playFXOnTag(level._effect["flare_runner"], var_0, "tag_origin");
  self waittillmatch("noteworthy", "flare_fade_node");
  var_0 delete();
}

_id_409A() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  playFXOnTag(level._effect["flare_runner_fizzout"], var_0, "tag_origin");
  var_0 delete();
  level notify("flare_done");
  wait 1;
  self notify("flare_complete");
}

_id_285A() {
  _id_4096();
  _id_4097();
  _id_409A();
}

_id_409B(var_0) {
  if(!isDefined(level.flag[var_0])) {
    common_scripts\utility::flag_init(var_0);
    return;
  }
}

_id_409C(var_0) {
  var_1 = maps\_vehicle::_id_2A99(var_0);
  var_1 thread _id_4095();
  var_1 thread _id_285A();
}