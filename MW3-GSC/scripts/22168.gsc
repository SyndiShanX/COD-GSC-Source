/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\22168.gsc
**************************************/

_id_566B() {
  level._id_566C = 0.1;
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
  thread _id_5695();
}

_id_5670() {
  var_0 = common_scripts\utility::spawn_tag_origin();
  var_1 = 0;

  for(;;) {
    if(!maps\_utility::_id_12C1() && level._id_5671 == 6) {
      if(!var_1) {
        var_1 = 1;
        playFXOnTag(level._effect["particle_fog2"], var_0, "tag_origin");
      }

      var_2 = self getplayerangles();
      var_0.origin = self.origin;
      var_0.angles = var_2;
    } else if(var_1) {
      stopFXOnTag(level._effect["particle_fog2"], var_0, "tag_origin");
      var_1 = 0;
    }

    wait 0.05;
  }
}

_id_5672() {
  for(;;) {
    if(maps\_utility::_id_12C1()) {
      playfxontagforclients(level._effect["blizzard_main"], self, "tag_origin", self);
    } else {
      playFX(level._effect["blizzard_main"], maps\_utility::_id_1277(self.origin) + (0, 0, 86));
    }
    wait(level._id_566C);
  }
}

_id_5673(var_0) {
  if(!isDefined(var_0)) {
    switch (level._id_5671) {
      case 0:
        level._id_566C = 0.3;
        break;
      case 1:
        level._id_566C = 0.08;
        break;
      case 2:
        level._id_566C = 0.17;
        break;
      case 3:
        level._id_566C = 0.3;
        break;
      case 4:
        level._id_566C = 0.24;
        break;
      case 5:
        level._id_566C = 0.14;
        break;
      case 6:
        level._id_566C = 0.07;
        break;
    }
  } else {
    level._id_566C = var_0;
  }
}

_id_5674(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0.05;
  }
  if(var_0 > level._id_566C) {
    while(var_0 > level._id_566C) {
      wait(level._id_566C);
      var_2 = level._id_566C + var_1;
      level._id_566C = min(var_2, var_0);
    }
  } else {
    while(var_0 < level._id_566C) {
      wait(level._id_566C);
      var_2 = level._id_566C - var_1;
      level._id_566C = max(var_2, var_0);
    }
  }
}

_id_5675() {
  setsaveddvar("r_outdoorfeather", "32");
  level._effect["blizzard_level_0"] = loadfx("misc/blank");
  level._effect["blizzard_level_1"] = loadfx("sand/sand_light");
  level._effect["blizzard_level_2"] = loadfx("sand/sand_medium_2");
  level._effect["blizzard_level_3"] = loadfx("sand/sand_medium_2");
  level._effect["blizzard_level_4"] = loadfx("sand/sand_medium_2");
  level._effect["blizzard_level_5"] = loadfx("sand/sand_extreme");
  level._effect["blizzard_level_6"] = loadfx("sand/sand_extreme");
  level._effect["blizzard_level_7"] = loadfx("sand/sand_aftermath");
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
  maps\_utility::vision_set_fog_changes("payback", var_0);
  thread _id_5686(0, 0);
  thread _id_568B(0, 1.0);
  sethalfresparticles(0);
  common_scripts\utility::flag_set("pause_blizzard_ground_fx");
  _id_5678(var_0, 0);
  resetsunlight();
}

_id_567B(var_0) {
  _id_5696();
  thread _id_568E("none", var_0);
  maps\_utility::vision_set_fog_changes("payback", var_0);
  thread _id_5686(0, 0);
  thread _id_568B(0, 1.0);
  sethalfresparticles(0);
  common_scripts\utility::flag_set("pause_blizzard_ground_fx");
  _id_5678(var_0, 0.25);
  resetsunlight();
}

_id_567C(var_0) {
  _id_5696();
  thread _id_568E("light", var_0);
  maps\_utility::vision_set_fog_changes("payback", var_0);
  thread _id_5686(0, 0);
  thread _id_568B(0, 1.0);
  sethalfresparticles(0);
  common_scripts\utility::flag_set("pause_blizzard_ground_fx");
  _id_5678(var_0, 0.45);
  thread _id_568D(1.0, var_0);
}

_id_567D(var_0) {
  _id_5696();
  thread _id_568E("med", var_0);
  maps\_utility::vision_set_fog_changes("payback_medium", var_0);
  thread _id_5686(var_0, 4500);
  thread _id_568B(var_0, 0.5);
  sethalfresparticles(0);
  common_scripts\utility::flag_set("pause_blizzard_ground_fx");
  _id_5678(var_0, 0.5);
}

_id_567E(var_0) {
  _id_5696();
  thread _id_568E("hard", var_0);
  maps\_utility::vision_set_fog_changes("payback_heavy", var_0);
  var_1 = 1;
  thread _id_568D(var_1, var_0);
  thread _id_5686(var_0, 0);
  thread _id_568B(var_0, 0);
  sethalfresparticles(0);
  _id_5678(var_0, 0.7);
}

_id_567F(var_0, var_1) {
  _id_5696();
  thread _id_568E("extreme", var_0);
  var_2 = 1;
  thread _id_568D(var_2, var_0);
  thread _id_5686(var_0, 0);
  thread _id_568B(var_0, 0);
  sethalfresparticles(0);
  _id_5678(var_0, 0.7);

  if(!isDefined(var_1)) {
    thread _id_5681(var_0, 0.05);
  }
}

_id_5680(var_0, var_1) {
  wait(var_1);
  maps\_utility::vision_set_fog_changes("payback_heavy_fogonly", var_0);
}

_id_5681(var_0, var_1) {
  if(isDefined(var_1)) {
    wait(var_1);
  }
  wait(var_1);
  maps\_utility::vision_set_fog_changes("payback_heavy", var_0);
}

_id_5682(var_0, var_1) {
  if(isDefined(var_1)) {
    wait(var_1);
  }
  maps\_utility::vision_set_fog_changes("payback_heavy_sat", var_0);
}

_id_5683(var_0, var_1) {
  if(isDefined(var_1)) {
    wait(var_1);
  }
  maps\_utility::_id_27D3("payback_heavy_75", var_0);
}

_id_5684(var_0) {
  _id_5696();
  thread _id_568E("extreme", var_0);
  maps\_utility::vision_set_fog_changes("payback_blackout", var_0);
  var_1 = 1;
  thread _id_568D(var_1, var_0);
  thread _id_5686(var_0, 0);
  thread _id_568B(var_0, 0);
  sethalfresparticles(0);
  _id_5678(var_0, 0.7);
}

_id_5685(var_0) {
  _id_5696();
  thread _id_568E("aftermath", var_0);
  maps\_utility::vision_set_fog_changes("payback_heavy", var_0);
  var_1 = 1;
  thread _id_568D(var_1, var_0);
  thread _id_5686(var_0, 0);
  thread _id_568B(var_0, 0.5);
  sethalfresparticles(0);
  _id_5678(var_0, 0.7);
}

_id_5686(var_0, var_1) {
  level notify("blizzard_set_culldist");
  level endon("blizzard_set_culldist");
  var_2 = 10000;
  var_3 = level._id_5687;

  if(!isDefined(var_3) || var_3 == 0) {
    var_3 = var_2;
  }
  if(var_1 == 0) {
    var_1 = var_2;
  }
  var_4 = 0;

  for(var_5 = var_0 * 0.5; var_4 <= var_0; var_4 = var_4 + _id_5688(level._id_5687)) {
    if(var_0 > 0) {
      if(var_4 >= var_5) {
        var_6 = (var_4 - var_5) / (var_0 - var_5);
        level._id_5687 = var_3 + (var_1 - var_3) * var_6;
      } else {
        level._id_5687 = var_3;
      }
      continue;
    }

    level._id_5687 = var_1;
  }

  if(var_1 >= var_2 || var_1 == 0) {
    level._id_5687 = 0;
    _id_5688(0);
  } else {
    for(;;) {
      level._id_5687 = var_1;
      _id_5688(var_1);
    }
  }
}

_id_5688(var_0) {
  level notify("blizzard_set_culldist_checked");
  level endon("blizzard_set_culldist");
  level endon("blizzard_set_culldist_checked");
  var_1 = 0;
  var_2 = 0;

  if(!isDefined(level._id_5689)) {
    level._id_5689 = getEntArray("trig_enable_sandstorm_cull", "targetname");
  }
  while(!var_1) {
    if(var_0 == 0) {
      var_1 = 1;
    } else {
      if(isDefined(level.player._id_5689) && level.player istouching(level.player._id_5689)) {
        var_1 = _id_568A(level.player._id_5689);
      } else {
        foreach(var_4 in level._id_5689) {
          if((!isDefined(level.player._id_5689) || var_4 != level.player._id_5689) && level.player istouching(var_4)) {
            var_1 = _id_568A(var_4);
            level.player._id_5689 = var_4;
            break;
          }
        }
      }

      if(!var_1) {
        setculldist(0);
      }
    }

    var_2 = var_2 + 0.05;
    wait 0.05;
  }

  setculldist(var_0);
  return var_2;
}

_id_568A(var_0) {
  var_1 = 0;

  if(isDefined(var_0.target)) {
    var_2 = common_scripts\utility::getstruct(var_0.target, "targetname");

    if(isDefined(var_2)) {
      var_3 = anglesToForward(level.player getplayerangles());
      var_4 = vectornormalize(var_2.origin - level.player.origin);

      if(vectordot(var_3, var_4) < 0.6) {
        var_1 = 1;
      }
    }
  } else {
    var_1 = 1;
  }
  return var_1;
}

_id_568B(var_0, var_1) {
  self notify("blizzard_set_shadowquality");
  self endon("blizzard_set_shadowquality");
  var_2 = level._id_568C;

  if(!isDefined(var_2)) {
    var_2 = 1.0;
  }
  var_3 = 1;
  var_4 = 0.25;

  for(var_5 = 0; var_5 <= var_0; var_5 = var_5 + 0.05) {
    if(var_0 > 0) {
      var_6 = var_5 / var_0;
      level._id_568C = var_2 + (var_1 - var_2) * var_6;
    } else {
      level._id_568C = var_1;
    }
    var_3 = 0.25 + level._id_568C * 0.75;
    var_4 = 0.1 + level._id_568C * 0.15;
    wait 0.05;

    if(int(var_5) != int(var_5 + 0.05)) {
      setsaveddvar("sm_sunShadowScale", var_3);
      setsaveddvar("sm_sunSampleSizeNear", var_4);
    }
  }

  setsaveddvar("sm_sunShadowScale", var_3);
  setsaveddvar("sm_sunSampleSizeNear", var_4);
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
  level._effect["blizzard_main"] = level._effect["blizzard_level_" + level._id_5671];
  thread _id_5673();
}

_id_5690(var_0) {
  switch (var_0) {
    case "none":
      return 0;
    case "light":
      return 1;
    case "med":
      return 3;
    case "hard":
      return 5;
    case "extreme":
      return 6;
    case "aftermath":
      return 7;
  }
}

_id_5678(var_0, var_1, var_2) {
  var_3 = self;

  if(!isPlayer(var_3)) {
    var_3 = level.player;
  }
  if(!isDefined(var_1)) {
    var_1 = 1;
  }
  if(!isDefined(var_2)) {
    level._id_5691 = var_1;
  }
  if(var_1 > 0) {
    setsaveddvar("r_fog_depthhack_scale", "0.5");
  } else {
    setsaveddvar("r_fog_depthhack_scale", "-1");
  }
  var_4 = _id_5693(var_3);
  var_4.x = 0;
  var_4.y = 0;
  var_4 setshader("overlay_sandstorm", 640, 480);
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

    if(!isPlayer(var_1)) {
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