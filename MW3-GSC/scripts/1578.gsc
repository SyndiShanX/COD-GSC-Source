/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1578.gsc
**************************************/

_id_4445() {
  level.createfxexploders = [];

  foreach(var_1 in level.createfxent) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1.v["type"] != "exploder") {
      continue;
    }
    if(!isDefined(var_1.v["exploder"])) {
      continue;
    }
    var_2 = var_1.v["exploder"];

    if(!isDefined(level.createfxexploders[var_2])) {
      level.createfxexploders[var_2] = [];
    }
    level.createfxexploders[var_2][level.createfxexploders[var_2].size] = var_1;
  }

  level.createfxbyfxid = [];

  foreach(var_1 in level.createfxent) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(!isDefined(var_1.v["fxid"])) {
      continue;
    }
    var_5 = var_1.v["fxid"];

    if(!isDefined(level.createfxbyfxid[var_5])) {
      level.createfxbyfxid[var_5] = [];
    }
    level.createfxbyfxid[var_5][level.createfxbyfxid[var_5].size] = var_1;
  }
}

_id_4446(var_0) {
  var_0 = maps\_utility::string(var_0);

  if(isDefined(level.createfxexploders)) {
    return level.createfxexploders[var_0];
  }
  var_1 = [];

  foreach(var_3 in level.createfxent) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3.v["type"] != "exploder") {
      continue;
    }
    if(!isDefined(var_3.v["exploder"])) {
      continue;
    }
    if(var_3.v["exploder"] == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_4447(var_0) {
  var_0 = maps\_utility::string(var_0);

  if(isDefined(level.createfxbyfxid)) {
    return level.createfxbyfxid[var_0];
  }
  var_1 = [];

  foreach(var_3 in level.createfxent) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(var_3.v["fxid"] == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_4448(var_0) {
  var_1 = _id_4446(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {}
    var_3 common_scripts\utility::pauseeffect();
  }
}

_id_4449(var_0) {
  var_1 = _id_4447(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {}
    var_3 common_scripts\utility::pauseeffect();
  }
}

_id_444A(var_0, var_1) {
  var_2 = _id_4447(var_0);

  if(isDefined(var_2)) {
    foreach(var_4 in var_2) {
      if(isDefined(var_1) && var_4.v["type"] == var_1) {
        continue;
      }
      var_4 maps\_utility::_id_1655();
    }
  }
}

_id_444B(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_444C[0] = vectornormalize(var_0);
  var_3._id_444C[1] = vectornormalize(var_1);
  var_3._id_444C[2] = vectornormalize(var_2);
}

_id_444D(var_0, var_1) {
  var_0 = vectornormalize(var_0);
  var_2 = vectordot(var_0, var_1._id_444C[0]);
  var_3 = vectordot(var_0, var_1._id_444C[0]);
  var_4 = vectordot(var_0, var_1._id_444C[0]);
  return (var_2, var_3, var_4);
}

_id_444E(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  if(!isDefined(var_3)) {
    var_3 = 0;
  }
  var_4 = var_1 * 10;
  var_5 = var_2 * 10;

  if(var_5 > 0) {
    var_6 = var_0 / var_5;
  } else {
    var_6 = var_0;
  }
  var_7 = var_3 * 10;
  var_8 = var_4 - var_7;

  if(var_7 > 0) {
    var_9 = var_0 / var_7;
  } else {
    var_9 = var_0;
  }
  var_10 = 0.1;
  var_0 = 0;

  for(var_11 = 0; var_11 < var_4; var_11++) {
    if(var_11 <= var_5) {
      var_0 = var_0 + var_6;
    }
    if(var_11 > var_8) {
      var_0 = var_0 - var_9;
    }
    earthquake(var_0, var_10, level.player.origin, 500);
    wait(var_10);
  }
}

_id_444F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(level.createfx_enabled) {
    return 0;
  }
  var_8 = common_scripts\utility::spawn_tag_origin();
  var_9 = 1200;
  var_8.origin = level.player getorigin();
  var_10 = bulletTrace(level.player.origin + (0, 0, 12), level.player.origin + (0, 0, 1200), 0, undefined);
  var_11 = distance(var_8.origin, var_10["position"]);
  var_12 = 0.125;
  var_13 = 2;
  var_14 = 0.3;
  var_15 = 0.5;

  if(isDefined(var_2)) {
    var_12 = var_2;
  }
  if(isDefined(var_3)) {
    var_13 = var_3;
  }
  if(isDefined(var_4)) {
    var_14 = var_4;
  }
  if(isDefined(var_5)) {
    var_15 = var_5;
  }
  if(isDefined(var_7) && var_7 == 1) {
    var_11 = 1;
  }
  if(var_11 < 300) {
    if(isDefined(var_1)) {
      level.player playrumbleonentity(var_1);
    }
    level thread _id_444E(var_12, var_13, var_14, var_15);

    if(isDefined(var_6) && var_6 == 1) {
      level thread _id_4450(var_8.origin, var_13, var_12);
    }
    if(isDefined(var_0)) {
      for(var_16 = 0; var_16 < 6; var_16++) {
        wait 0.1;
        var_17 = vectornormalize(anglesToForward(level.player getplayerangles()) + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0.5)) * 1000;
        var_18 = bulletTrace(level.player.origin + (0, 0, 12), level.player.origin + (0, 0, 12) + var_17, 0, undefined);
        var_19 = distance(level.player.origin, var_18["position"]);
        var_20 = vectordot((0, 0, -1), vectornormalize(var_10["normal"]));

        if(var_19 < 450 && var_20 > 0.75) {
          playFX(common_scripts\utility::getfx(var_0), var_18["position"]);
        }
      }
    }
  }

  var_8 delete();
}

_id_4450(var_0, var_1, var_2) {
  var_3 = 0;

  while(var_3 < var_1) {
    physicsjitter(var_0, 1000, 250, 0, var_2);
    var_3 = var_3 + 0.1;
    wait 0.1;
  }
}

_id_4451(var_0, var_1, var_2) {
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_3.origin = var_0;
  var_3.angles = var_1;
  var_4 = playFXOnTag(common_scripts\utility::getfx(var_2), var_3, "tag_origin");
  var_5 = 500 + randomfloat(1500);
  var_6 = 10 + randomint(20);
  var_7 = 200;
  var_8 = vectornormalize(anglesToForward(var_1));
  var_9 = vectornormalize(common_scripts\utility::randomvector(2));
  var_3.origin = var_3.origin + var_7 * (var_9[0], var_9[1], 0);
  var_10 = randomfloat(75);
  var_11 = min(1.0, max(0.0, var_10 / 90.0));
  var_12 = vectornormalize(var_8 * (1 - var_11) + (var_9[0], var_9[1], 0) * var_11);
  var_13 = var_12 * var_5 * 0.05;
  var_14 = (0, 0, -3);

  for(var_15 = 0; var_15 < var_6; var_15++) {
    var_3.origin = var_3.origin + var_13;
    var_13 = var_13 + var_14;
    level common_scripts\utility::waitframe();
  }

  stopFXOnTag(common_scripts\utility::getfx(var_2), var_3, "tag_origin");
  var_3 delete();
}

_id_4452(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = common_scripts\utility::spawn_tag_origin();
  var_10.origin = var_0;
  var_10.angles = var_1;
  var_11 = playFXOnTag(common_scripts\utility::getfx(var_2), var_10, "tag_origin");
  var_12 = var_3 + randomfloat(var_4 - var_3);
  var_13 = var_5 + randomint(var_6 - var_5);
  var_14 = var_7;
  var_15 = vectornormalize(anglesToForward(var_1));
  var_16 = vectornormalize(common_scripts\utility::randomvector(2));
  var_10.origin = var_10.origin + var_14 * (var_16[0], var_16[1], 0);
  var_17 = randomfloat(var_8);
  var_18 = min(1.0, max(0.0, var_17 / 90.0));
  var_19 = vectornormalize(var_15 * (1 - var_18) + (var_16[0], var_16[1], 0) * var_18);
  var_20 = var_19 * var_12 * 0.05;
  var_21 = (0, 0, var_9 * -1) * 0.05 * 0.05;

  for(var_22 = 0; var_22 < var_13; var_22++) {
    var_10.origin = var_10.origin + var_20;
    var_20 = var_20 + var_21;
    level common_scripts\utility::waitframe();
  }

  stopFXOnTag(common_scripts\utility::getfx(var_2), var_10, "tag_origin");
  var_10 delete();
}

_id_4453(var_0, var_1) {
  waittillframeend;
  waittillframeend;
  waittillframeend;

  for(;;) {
    level waittill("exploding_" + var_0);
    var_2 = _id_4446(var_0);

    if(isDefined(var_2)) {
      foreach(var_4 in var_2) {
        for(var_5 = 0; var_5 < 6; var_5++) {
          thread _id_4451(var_4.v["origin"], var_4.v["angles"], var_1);
        }
      }
    }
  }
}

_id_4454(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  waittillframeend;
  waittillframeend;
  waittillframeend;

  for(;;) {
    level waittill("exploding_" + var_0);
    var_10 = _id_4446(var_0);

    if(isDefined(var_10)) {
      foreach(var_12 in var_10) {
        if(!isDefined(var_12.v["origin"])) {
          continue;
        }
        for(var_13 = 0; var_13 < int(var_2); var_13++) {
          thread _id_4452(var_12.v["origin"], var_12.v["angles"], var_1, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
        }
      }
    }
  }
}

_id_4455() {
  if(level.player buttonPressed("z") == 1) {
    return 1;
  } else {
    return 0;
  }
}

_id_4456() {}

_id_4457(var_0, var_1, var_2, var_3) {
  waittillframeend;
  common_scripts\utility::flag_init(var_1);
  var_4 = spawnStruct();

  if(!isDefined(level._id_4458)) {
    level._id_4458 = [];
    level._id_4459 = getDvar("vision_set_current");

    if(level._id_4459 == "") {
      level._id_4459 = "default";
    }
    level._id_445A = level._id_4459;
    level._id_445B = 1.0;

    if(!common_scripts\utility::flag_exist("start_vision_watcher_manager")) {
      common_scripts\utility::flag_init("vision_watcher_changed");
    }
    level thread _id_445D();
  }

  if(var_3 == undefined) {
    var_3 = level._id_445A;
  }
  var_4.v["vision_set"] = var_0;
  var_4.v["vision_set_exit"] = var_3;
  var_4.v["blendtime"] = var_2;
  var_4.v["active"] = 0;
  var_4.v["prime"] = 0;
  var_4.v["flag"] = var_1;
  level._id_4458[level._id_4458.size] = var_4;

  for(;;) {
    common_scripts\utility::flag_wait(var_1);

    if(var_4.v["active"] == 0) {
      for(var_5 = 0; var_5 < level._id_4458.size; var_5++) {
        level._id_4458[var_5].v["prime"] = 0;
      }
      var_4.v["prime"] = 1;
    }

    var_4.v["active"] = 1;
    level._id_445B = var_2;
    common_scripts\utility::flag_set("vision_watcher_changed");
    wait(var_2);
    common_scripts\utility::flag_waitopen(var_1);
    var_4.v["prime"] = 0;
    var_4.v["active"] = 0;
    level._id_4459 = var_4.v["vision_set_exit"];
    level._id_445B = var_2;
    common_scripts\utility::flag_set("vision_watcher_changed");
    wait(var_2);
  }
}

_id_445C(var_0, var_1, var_2) {
  common_scripts\utility::flag_init(var_1);
  var_3 = getDvar("vision_set_current");

  for(;;) {
    common_scripts\utility::flag_wait(var_1);
    visionsetnaked(var_0, var_2);
    wait 1.0;
    common_scripts\utility::flag_waitopen(var_1);
    visionsetnaked(var_3, var_2);
    wait 1.0;
  }
}

_id_445D() {
  for(;;) {
    common_scripts\utility::flag_wait("vision_watcher_changed");
    var_0 = -1;
    var_1 = -1;
    var_2 = 0.0;

    for(var_3 = 0; var_3 < level._id_4458.size; var_3++) {
      if(level._id_4458[var_3].v["prime"] == 1) {
        var_4 = getDvar("vision_set_current");

        if(var_4 != level._id_4458[var_3].v["vision_set"]) {
          maps\_utility::vision_set_fog_changes(level._id_4458[var_3].v["vision_set"], level._id_445B);
        }
        var_0 = var_3;
      }

      if(level._id_4458[var_3].v["active"] == 1) {
        var_1 = 1;
      }
    }

    for(var_3 = 0; var_3 < level._id_4458.size; var_3++) {
      if(level._id_4458[var_3].v["active"] == 1 && var_0 == -1) {
        maps\_utility::vision_set_fog_changes(level._id_4458[var_3].v["vision_set"], level._id_4458[var_3].v["blendtime"]);
        level._id_4458[var_3].v["prime"] = 1;
        var_0 = var_3;
        var_3 = 100000;
        common_scripts\utility::flag_clear("vision_watcher_changed");
        wait(level._id_445B);
        continue;
      }
    }

    if(var_1 != 1) {
      maps\_utility::vision_set_fog_changes(level._id_4459, level._id_445B);
    }
    common_scripts\utility::flag_clear("vision_watcher_changed");
    wait(level._id_445B);
  }
}

_id_445E(var_0, var_1, var_2, var_3) {
  common_scripts\utility::flag_init(var_1);
  common_scripts\utility::flag_init("fx_zone_" + var_0 + "_active");

  if(isDefined(var_2)) {
    common_scripts\utility::flag_init(var_2);
  }
  if(isDefined(var_3)) {
    if(!common_scripts\utility::flag_exist(var_3)) {
      common_scripts\utility::flag_init(var_3);
    }
  }

  level common_scripts\utility::waitframe();

  if(isDefined(var_3)) {
    thread _id_4464(var_0, var_3, var_1, var_2);
  }
  thread _id_4463(var_0, var_1, var_2);
}

_id_445F(var_0, var_1, var_2) {
  common_scripts\utility::flag_init(var_1);
  common_scripts\utility::flag_init("fx_zone_" + var_0 + "_active");

  if(isDefined(var_2)) {
    common_scripts\utility::flag_init(var_2);
  }
  level common_scripts\utility::waitframe();
  thread _id_4465(var_0, var_1, var_2);
}

_id_4460(var_0, var_1) {
  while(common_scripts\utility::flag(var_0) || common_scripts\utility::flag(var_1)) {
    level common_scripts\utility::waittill_either(var_0, var_1);
  }
}

_id_4461(var_0) {
  level notify("fx_zone_" + var_0 + "_activating");
  common_scripts\utility::flag_set("fx_zone_" + var_0 + "_active");
}

_id_4462(var_0) {
  level notify("fx_zone_" + var_0 + "_deactivating");
  common_scripts\utility::flag_clear("fx_zone_" + var_0 + "_active");
}

_id_4463(var_0, var_1, var_2) {
  for(;;) {
    if(!isDefined(var_2)) {
      var_2 = var_1;
    }
    common_scripts\utility::flag_wait_either(var_1, var_2);
    _id_4461(var_0);
    common_scripts\utility::exploder(var_0);
    _id_4460(var_1, var_2);
    _id_4462(var_0);
    _id_4448(var_0);
    wait 2.0;
  }
}

_id_4464(var_0, var_1, var_2, var_3) {
  for(;;) {
    if(!isDefined(var_3)) {
      var_3 = var_2;
    }
    common_scripts\utility::flag_wait(var_1);
    _id_4462(var_0);
    _id_4448(var_0);
    _id_4462(var_0);
    common_scripts\utility::flag_waitopen(var_1);

    if(common_scripts\utility::flag(var_2) || common_scripts\utility::flag(var_3)) {
      _id_4461(var_0);
      common_scripts\utility::exploder(var_0);
    }
  }
}

_id_4465(var_0, var_1, var_2) {
  for(;;) {
    if(!isDefined(var_2)) {
      var_2 = var_1;
    }
    common_scripts\utility::flag_wait_all(var_1, var_2);
    _id_4461(var_0);
    common_scripts\utility::exploder(var_0);
    _id_4460(var_1, var_2);
    _id_4462(var_0);
    _id_4448(var_0);
    wait 2.0;
  }
}

_id_4466(var_0, var_1) {
  if(!isDefined(var_1)) {
    common_scripts\utility::flag_init(var_1);
  }
  common_scripts\utility::flag_init("fx_zone_" + var_0 + "_active");
  level common_scripts\utility::waitframe();

  for(;;) {
    wait 0.1;
    common_scripts\utility::flag_waitopen(var_1);
    _id_4461(var_0);
    common_scripts\utility::exploder(var_0);
    common_scripts\utility::flag_wait(var_1);
    _id_4462(var_0);
    _id_4448(var_0);
    wait 2.0;
  }
}

_id_4467(var_0) {
  _id_4448(var_0);
}

_id_4468(var_0) {
  var_1 = _id_4447(var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(var_3.v["type"] == "exploder") {
        continue;
      }
      var_3 common_scripts\utility::pauseeffect();
    }
  }
}

_id_4469(var_0, var_1) {
  common_scripts\utility::flag_init("fx_zone_" + var_0 + "_active");

  for(;;) {
    common_scripts\utility::flag_wait(var_1);
    _id_4461(var_0);
    common_scripts\utility::exploder(var_0);
    common_scripts\utility::flag_waitopen(var_1);
    _id_4462(var_0);
    var_2 = _id_4446(var_0);

    if(isDefined(var_2)) {
      foreach(var_4 in var_2) {}
      var_4 common_scripts\utility::pauseeffect();
    }

    wait 2.0;
  }
}

_id_446A(var_0) {
  var_1 = undefined;
  var_2 = _id_4446(var_0);

  if(isDefined(var_2)) {
    foreach(var_4 in var_2) {}
    var_1 = var_4;
  }

  return var_1;
}

_id_446B(var_0) {
  var_1 = [];
  var_2 = _id_4446(var_0);

  if(isDefined(var_2)) {
    var_1 = var_2;
  }
  return var_1;
}

_id_446C(var_0) {
  var_1 = level.player getplayerangles();
  var_2 = vectornormalize(anglesToForward(var_1));
}

_id_446D(var_0, var_1, var_2) {
  if(!common_scripts\utility::flag_exist("fx_spot_flare_kill")) {
    common_scripts\utility::flag_init("fx_spot_flare_kill");
  }
  if(!isDefined(var_1)) {
    var_1 = (-90, 0, 0);
  }
  if(!isDefined(var_2)) {
    var_2 = 10000;
  }
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_4 = level.player.origin;
  var_5 = level.player getplayerangles();
  var_6 = vectornormalize(anglesToForward(var_1 * -1));
  var_7 = var_6 * -1 * var_2 + var_4;
  var_3.origin = var_7;
  var_8 = vectornormalize(anglesToForward(var_5));
  var_9 = min(1, max(0.001, vectordot(var_8, var_6 * -1)));
  var_9 = var_9 / var_9;
  var_10 = vectornormalize(var_8 * var_9 + var_6 * 2);
  var_11 = vectornormalize(var_10 - var_6) * var_9;
  var_12 = vectortoangles(vectornormalize(var_10 + var_11));
  var_3.angles = var_12;
  playFXOnTag(common_scripts\utility::getfx(var_0), var_3, "tag_origin");

  while(!common_scripts\utility::flag("fx_spot_flare_kill")) {
    var_4 = level.player.origin;
    var_5 = level.player getplayerangles();
    var_6 = vectornormalize(anglesToForward(var_1));
    var_7 = var_6 * var_2 + var_4;
    var_3.origin = var_7;
    var_8 = vectornormalize(anglesToForward(var_5));
    var_9 = min(1.0, max(0.001, vectordot(var_8, var_6)));
    var_9 = var_9 * var_9 * var_9 * var_9;
    var_9 = 1.0 - var_9;
    var_10 = vectornormalize(var_8 * var_9 + var_6 * 2);
    var_11 = vectornormalize(var_10 - var_6) * var_9;
    var_12 = vectortoangles(vectornormalize(var_10 + var_11 * 2));
    var_3.angles = var_12;
    level common_scripts\utility::waitframe();
  }

  var_3 delete();
  stopFXOnTag(common_scripts\utility::getfx(var_0), var_3, "tag_origin");
}

_id_446E(var_0, var_1, var_2) {}

_id_446F() {
  return 0;
}

_id_4470(var_0, var_1, var_2) {
  var_3 = [];

  if(!isDefined(var_1)) {
    var_1 = "default";
  }
  var_4 = spawnStruct();
  var_4.v["default"] = spawnStruct();
  var_4.v["default"].v["l_arm"] = ["j_shoulder_le", "j_elbow_le", "j_wrist_le"];
  var_4.v["default"].v["r_arm"] = ["j_shoulder_ri", "j_elbow_ri", "j_wrist_ri"];
  var_4.v["default"].v["l_leg"] = ["j_hip_le", "j_knee_le", "j_ankle_le"];
  var_4.v["default"].v["r_leg"] = ["j_hip_ri", "j_knee_ri", "j_ankle_ri"];
  var_4.v["default"].v["torso"] = ["j_mainroot", "j_spine4", "j_neck"];
  var_4.v["default"].v["head"] = ["j_neck", "j_head"];

  if(isDefined(var_2)) {
    var_5 = "override";

    if(isDefined(var_2.v["name"])) {
      var_5 = var_2.v["name"];
    }
    var_4.v[var_5] = var_2;
  }

  foreach(var_7 in var_4.v[var_1].v[var_0]) {}
  var_3[var_3.size] = var_7;

  return var_3;
}

_id_4471(var_0) {
  if(!isDefined(var_0.v["ent"])) {
    return 1;
  }
  if(isDefined(var_0.v["chain"])) {
    var_0.v["bones"] = _id_4470(var_0.v["chain"], var_0.v["chainset_name"], var_0.v["chainset_override"]);
  } else {
    return 1;
  }
  var_0.v["tags"] = [];
  var_0.v["tag_lens"] = [];

  for(var_1 = 0; var_1 < var_0.v["bones"].size - 1; var_1++) {
    var_2 = var_0.v["ent"] gettagorigin(var_0.v["bones"][var_1]);
    var_3 = var_0.v["ent"] gettagangles(var_0.v["bones"][var_1]);
    var_4 = var_0.v["ent"] gettagorigin(var_0.v["bones"][var_1 + 1]);

    if(isDefined(var_2) && isDefined(var_4)) {
      var_5 = var_4 - var_2;
      var_6 = length(var_5);
      var_7 = common_scripts\utility::spawn_tag_origin();
      var_7.origin = var_2;
      var_7.angles = vectortoangles(var_5);
      var_7 linkto(var_0.v["ent"], var_0.v["bones"][var_1]);
      var_0.v["tags"][var_0.v["tags"].size] = var_7;
      var_0.v["tag_lens"][var_0.v["tag_lens"].size] = var_6;
    }
  }
}

_id_4472(var_0) {
  level endon(var_0.v["kill_notify"]);

  for(;;) {
    for(var_1 = 0; var_1 < var_0.v["tags"].size; var_1++) {
      var_2 = var_0.v["tags"][var_1];
      var_3 = var_0.v["tag_lens"][var_1];
      var_4 = anglesToForward(var_2.angles);
      var_5 = var_2.origin + var_4 * var_3 * randomfloat(1.0);
      playFX(var_0.v["fx"], var_5, var_4, anglestoup(var_2.angles));
    }

    wait(var_0.v["looptime"]);
  }
}

_id_4473(var_0) {
  level waittill(var_0.v["kill_notify"]);

  for(var_1 = 0; var_1 < var_0.v["tags"].size; var_1++) {
    var_0.v["tags"][var_1] delete();
  }
  var_0.v["tags"] = [];
}

_id_4474(var_0) {
  var_1 = var_0.v["ent"];
  var_2 = var_0.v["fx"];
  var_3 = var_0.v["chain"];
  var_4 = var_0.v["looptime"];
  var_5 = var_0.v["chainset_name"];
  var_6 = var_0.v["chainset_override"];

  if(!isDefined(var_1)) {
    return undefined;
  }
  if(!isDefined(var_2)) {
    return undefined;
  }
  if(!isDefined(var_3)) {
    var_3 = "all";
  }
  if(!isDefined(var_4)) {
    var_4 = 1.0;
  }
  if(!isDefined(var_5)) {
    var_5 = "default";
  }
  if(!isDefined(var_6)) {
    var_6 = undefined;
  }
  var_7 = [];

  if(var_3 == "all") {
    var_7[var_7.size] = "head";
    var_7[var_7.size] = "r_arm";
    var_7[var_7.size] = "l_arm";
    var_7[var_7.size] = "r_leg";
    var_7[var_7.size] = "l_leg";
    var_7[var_7.size] = "torso";
  } else {
    var_7[0] = var_3;
  }
  var_8 = var_1.model + "kill_fx_onactor";
  var_9 = [];

  foreach(var_11 in var_7) {
    var_12 = spawnStruct();
    var_12.v["ent"] = var_1;
    var_12.v["chain"] = var_11;
    var_12.v["fx"] = var_2;
    var_12.v["looptime"] = var_4;
    var_12.v["kill_notify"] = var_8;
    var_12.v["chainset_name"] = var_5;
    var_12.v["chainset_override"] = var_6;
    _id_4471(var_12);
    thread _id_4472(var_12);
    thread _id_4473(var_12);
    var_9[var_9.size] = var_12;
  }

  return var_8;
}