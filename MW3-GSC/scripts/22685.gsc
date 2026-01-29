/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\22685.gsc
**************************************/

_id_566B() {
  _id_566E();
  _id_5675();
  _id_5679("none");
  thread _id_566F();
  level._id_566D = ::_id_5697;
}

_id_566E() {
  common_scripts\utility::flag_init("pause_blizzard_ground_fx");
}

_id_566F() {
  if(!isDefined(level.players)) {
    level waittill("level.players initialized");

  }
  common_scripts\utility::array_thread(level.players, ::_id_5672);

  if(maps\_utility::_id_0A36()) {
    common_scripts\utility::array_thread(level.players, ::_id_5896);

  }
  thread _id_5695();
}

_id_5672() {
  var_0 = 0.32;

  if(maps\_utility::_id_0A36()) {
    var_0 = 0.2;

  }
  for(;;) {
    if(maps\_utility::_id_0A36()) {
      self playFX(level._effect["blizzard_main"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    } else {
      playFX(level._effect["blizzard_main"], self.origin);

    }
    wait(var_0);
  }
}

_id_5896() {
  var_0 = 0.05;

  for(;;) {
    self playFX(level._effect["blizzard_main_flake"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    wait(var_0);
  }
}

_id_5897(var_0, var_1) {
  var_1 endon("death");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("tag_origin");
  playFXOnTag(level._effect[var_0], var_2, "tag_origin");

  for(;;) {
    var_2.origin = (var_1.origin[0], var_1.origin[1], var_2.origin[2]);
    wait 0.05;
  }
}

_id_5675() {
  setsaveddvar("r_outdoorfeather", "32");
  level._effect["blizzard_level_0"] = loadfx("misc/blank");
  level._effect["blizzard_level_1"] = loadfx("snow/snow_light_hijack");
  level._effect["blizzard_level_2"] = loadfx("snow/snow_light_hijack");
  level._effect["blizzard_level_3"] = loadfx("snow/snow_light_hijack");
  level._effect["blizzard_level_4"] = loadfx("snow/snow_light_hijack");
  level._effect["blizzard_level_5"] = loadfx("misc/blank");
  level._effect["blizzard_level_6"] = loadfx("misc/blank");
  level._effect["blizzard_level_7"] = loadfx("misc/blank");
  level._effect["blizzard_level_8"] = loadfx("misc/blank");
  level._effect["blizzard_level_9"] = loadfx("misc/blank");
  level._effect["blizzard_level_10"] = loadfx("misc/blank");
  level._effect["blizzard_main_flake"] = loadfx("snow/snow_hijack_so_flake");
  level._effect["blizzard_so_level_0"] = loadfx("misc/blank");
  level._effect["blizzard_so_level_1"] = loadfx("snow/snow_hijack_so");
  level._id_5898 = [];
  level._id_5898["r"] = 0.699094;
  level._id_5898["g"] = 0.741239;
  level._id_5898["b"] = 0.82818;
  var_0 = getmapsunlight();
  level._id_5676 = (var_0[0], var_0[1], var_0[2]);
  level._id_5677 = 1.0;
  level._id_5678 = 0;
}

_id_5679(var_0) {
  level._id_5671 = _id_5690(var_0);
  _id_568F();
}

_id_567A(var_0) {
  _id_5696();
  thread _id_568E("none", var_0);
  thread _id_5686(0, 0);
  sethalfresparticles(0);
  common_scripts\utility::flag_set("pause_blizzard_ground_fx");
  _id_5678(var_0, 0);
  resetsunlight();
}

_id_567B(var_0) {
  _id_5696();
  thread _id_568E("none", var_0);
  thread _id_5686(0, 0);
  sethalfresparticles(0);
  common_scripts\utility::flag_set("pause_blizzard_ground_fx");
  _id_5678(var_0, 0.25);
  resetsunlight();
}

_id_5899(var_0) {
  _id_5696();
  thread _id_568E("climbing", var_0);
  thread _id_5686(0, 0);
  sethalfresparticles(0);
  common_scripts\utility::flag_set("pause_blizzard_ground_fx");
  _id_5678(var_0, 0.25);
}

_id_589A(var_0) {
  _id_5696();
  thread _id_568E("climbing_up", var_0);
  thread _id_5686(0, 0);
  sethalfresparticles(0);
  common_scripts\utility::flag_set("pause_blizzard_ground_fx");
  _id_5678(var_0, 0.45);
}

_id_589B(var_0) {
  _id_5696();
  thread _id_568E("snowmobile", var_0);
  thread _id_5686(0, 0);
  sethalfresparticles(0);
  common_scripts\utility::flag_set("pause_blizzard_ground_fx");
  _id_5678(var_0, 0.5);
}

_id_567C(var_0) {
  _id_5696();
  thread _id_568E("light", var_0);
  thread _id_5686(0, 0);
  sethalfresparticles(0);
  common_scripts\utility::flag_set("pause_blizzard_ground_fx");
  _id_5678(var_0, 0.45);
  thread _id_568D(1.0, var_0);
}

_id_567D(var_0) {
  _id_5696();
  thread _id_568E("med", var_0);
  thread _id_5686(0, 0);
  sethalfresparticles(0);
  common_scripts\utility::flag_set("pause_blizzard_ground_fx");
  _id_5678(var_0, 0.6);
}

_id_567E(var_0) {
  _id_5696();
  thread _id_568E("hard", var_0);
  var_1 = 1;
  thread _id_568D(var_1, var_0);
  thread _id_5686(var_0, 3000);
  sethalfresparticles(0);
  _id_5678(var_0, 0.7);
}

_id_567F(var_0) {
  _id_5696();
  thread _id_568E("extreme", var_0);
  var_1 = 0.5;
  thread _id_568D(var_1, var_0);
  thread _id_5686(var_0, 3000);
  sethalfresparticles(1);
  common_scripts\utility::flag_clear("pause_blizzard_ground_fx");
  _id_5678(var_0, 1);
}

_id_5686(var_0, var_1) {
  level notify("blizzard_set_culldist");
  level endon("blizzard_set_culldist");
  wait(var_0);
  setculldist(var_1);
}

_id_568D(var_0, var_1) {
  level notify("blizzard_set_sunlight");
  level endon("blizzard_set_sunlight");
  var_2 = int(var_1 * 20);
  var_3 = var_0 - level._id_5677;
  var_4 = var_3 / var_2;

  while(var_2) {
    level._id_5677 = level._id_5677 + var_4;
    var_5 = level._id_5676 * level._id_5677;
    setsunlight(var_5[0], var_5[1], var_5[2]);
    var_2--;
    wait 0.05;
  }

  level._id_5677 = var_0;
  var_5 = level._id_5676 * level._id_5677;
  setsunlight(var_5[0], var_5[1], var_5[2]);
}

_id_568E(var_0, var_1) {
  level notify("blizzard_level_change");
  level endon("blizzard_level_change");
  var_2 = _id_5690(var_0);

  if(level._id_5671 > var_2) {
    var_3 = level._id_5671 - var_2;
    var_1 = var_1 / var_3;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      wait(var_1);
      level._id_5671--;
      _id_568F();
    }
  }

  if(level._id_5671 < var_2) {
    var_3 = var_2 - level._id_5671;
    var_1 = var_1 / var_3;

    for(var_4 = 0; var_4 < var_3; var_4++) {
      wait(var_1);
      level._id_5671++;
      _id_568F();
    }
  }
}

_id_568F() {
  if(maps\_utility::_id_0A36()) {
    level._effect["blizzard_main"] = level._effect["blizzard_so_level_" + level._id_5671];
  } else {
    level._effect["blizzard_main"] = level._effect["blizzard_level_" + level._id_5671];
  }
}

_id_5690(var_0) {
  switch (var_0) {
    case "none":
      return 0;
    case "climbing":
      return 1;
    case "climbing_up":
      return 2;
    case "snowmobile":
      return 3;
    case "light":
      return 4;
    case "med":
      return 6;
    case "hard":
      return 9;
    case "extreme":
      return 10;
    case "light_so":
      return 1;
    case "med_so":
      return 1;
  }
}

_id_5678(var_0, var_1, var_2) {
  var_3 = self;

  if(!isplayer(var_3)) {
    var_3 = level.player;

  }
  if(!isDefined(var_1)) {
    var_1 = 1;

  }
  if(!isDefined(var_2)) {
    level._id_5691 = var_1;

  }
  var_4 = _id_5693(var_3);
  var_4.x = 0;
  var_4.y = 0;
  var_4 setshader("overlay_frozen", 640, 480);
  var_4.sort = 50;
  var_4.lowresbackground = 1;
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.alpha = level._id_5678;
  var_4 fadeovertime(var_0);
  var_4.alpha = var_1;
  level._id_5678 = var_1;
}

_id_5692(var_0) {
  if(!isDefined(var_0) || !var_0) {
    var_1 = self;

    if(!isplayer(var_1)) {
      var_1 = level.player;

    }
    var_2 = _id_5693(var_1);
    var_2 destroy();
    return;
  }

  _id_5678(var_0, 0);
}

_id_5693(var_0) {
  if(!isDefined(var_0._id_5694)) {
    var_0._id_5694 = newclienthudelem(var_0);

  }
  return var_0._id_5694;
}

_id_5695() {
  var_0 = [];
  var_0 = maps\_utility::_id_2695("lighthaze_snow");
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("lighthaze_snow_headlights"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("snow_spray_detail_runner400x400"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("snow_spray_detail_runner0x400"));
  var_0 = common_scripts\utility::array_combine(var_0, maps\_utility::_id_2695("snow_spray_detail_runner400x0"));
  wait 0.1;

  for(;;) {
    common_scripts\utility::flag_wait("pause_blizzard_ground_fx");

    foreach(var_2 in var_0) {}
    var_2 common_scripts\utility::pauseeffect();

    common_scripts\utility::flag_waitopen("pause_blizzard_ground_fx");

    foreach(var_2 in var_0) {}
    var_2 maps\_utility::_id_1655();
  }
}

_id_5696() {
  level notify("blizzard_changed");
  level notify("blizzard_set_sunlight");
}

_id_5697(var_0, var_1, var_2) {
  var_3 = level._id_5691;

  if(!isDefined(var_3)) {
    var_3 = 1;

  }
  if(issubstr(var_1, "exterior")) {
    _id_5678(1, (1 - var_0) * var_3, 1);
    return;
  }

  if(issubstr(var_2, "exterior")) {
    _id_5678(1, var_0 * var_3, 1);
  }
}