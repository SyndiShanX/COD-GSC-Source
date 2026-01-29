/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\26886.gsc
**************************************/

main() {
  _id_68E7();
  _id_68EA();
  level._id_68E4 = [];
  level._id_68E5 = [];
}

_id_68E6(var_0) {
  var_1 = int(2048.0);
  var_2 = int(var_1 * 2048.0);
  var_3 = int((var_0[0] - -131072) / 128);
  var_4 = int((var_0[1] - -131072) / 128);
  var_5 = int((var_0[2] - -131072) / 128);
  var_6 = int(var_3 + var_1 * var_4 + var_2 * var_5);
  return "" + var_6;
}

_id_68E7() {
  var_0 = 1;
  var_1 = 30;
  var_2 = 2;
  var_3 = 50;
  var_4 = spawnStruct();
  var_4._id_68E8[0]["model"][0] = "c130_engine_dyn";
  var_4._id_68E8[0]["model"][1] = "727_cabin_door_dyn";
  var_4._id_68E8[0]["model"][2] = "727_coach_seat01_dyn";
  var_4._id_68E8[0]["model"][3] = "727_wing_flaps_long_left_new_dyn";
  var_4._id_68E8[0]["model"][4] = "727_wing_flaps_short_left_new_dyn";
  var_4._id_68E8[0]["model"][5] = "c130_engine_damaged_dyn";
  var_4._id_68E8[0]["class"] = "sinker";
  var_4._id_68E8[0]["classname"] = "script_model";
  var_4._id_68E8[0]["spawnflags"] = 0;
  var_4._id_68E8[0]["number"] = 5;
  var_4._id_68E8[0]["density"] = 0.05;
  var_4._id_68E8[0]["sinkvel"] = 10;
  var_4._id_68E8[0]["sinkrot"] = 1;
  var_4._id_68E8[0]["id"] = 0;
  var_4._id_68E8[1]["model"][0] = "body_russian_navy_sleevesdown";
  var_4._id_68E8[1]["model"][1] = "body_russian_navy_sleevesrolled";
  var_4._id_68E8[1]["model"][2] = "body_russian_navy_coat";
  var_4._id_68E8[1]["headmodel"][0] = "head_russian_navy_a";
  var_4._id_68E8[1]["headmodel"][1] = "head_russian_navy_b";
  var_4._id_68E8[1]["headmodel"][2] = "head_russian_navy_c";
  var_4._id_68E8[1]["class"] = "body";
  var_4._id_68E8[1]["classname"] = "script_model";
  var_4._id_68E8[1]["animation"][0] = "harbor_drowning_01_idle";
  var_4._id_68E8[1]["animation"][1] = "harbor_drowning_02_idle";
  var_4._id_68E8[1]["animation"][2] = "harbor_drowning_03_idle";
  var_4._id_68E8[1]["spawnflags"] = 0;
  var_4._id_68E8[1]["number"] = 5;
  var_4._id_68E8[1]["density"] = 0.01;
  var_4._id_68E8[1]["sinkvel"] = 4;
  var_4._id_68E8[1]["sinkrot"] = 1;
  var_4._id_68E8[1]["max_total_number"] = var_1;
  var_4._id_68E8[1]["cur_total_number"] = 0;
  var_4._id_68E8[1]["id"] = var_0;
  var_4._id_68E8[2]["model"][0] = "body_russian_navy_sleevesdown";
  var_4._id_68E8[2]["model"][1] = "body_russian_navy_sleevesrolled";
  var_4._id_68E8[2]["model"][2] = "body_russian_navy_coat";
  var_4._id_68E8[2]["headmodel"][0] = "head_russian_navy_a";
  var_4._id_68E8[2]["headmodel"][1] = "head_russian_navy_b";
  var_4._id_68E8[2]["headmodel"][2] = "head_russian_navy_c";
  var_4._id_68E8[2]["class"] = "floater";
  var_4._id_68E8[2]["classname"] = "script_model";
  var_4._id_68E8[2]["animation"][0][0] = "harbor_drowning_01";
  var_4._id_68E8[2]["animation"][0][1] = "harbor_drowning_01_idle";
  var_4._id_68E8[2]["animation"][1][0] = "harbor_drowning_02";
  var_4._id_68E8[2]["animation"][1][1] = "harbor_drowning_02_idle";
  var_4._id_68E8[2]["animation"][2][0] = "harbor_drowning_03";
  var_4._id_68E8[2]["animation"][2][1] = "harbor_drowning_03_idle";
  var_4._id_68E8[2]["animation"][3] = "harbor_floating_struggle_01";
  var_4._id_68E8[2]["animation"][4] = "harbor_floating_struggle_02";
  var_4._id_68E8[2]["animation"][5] = "harbor_floating_idle_01";
  var_4._id_68E8[2]["animation"][6] = "harbor_floating_idle_02";
  var_4._id_68E8[2]["animation"][7] = "harbor_floating_idle_03";
  var_4._id_68E8[2]["spawnflags"] = 0;
  var_4._id_68E8[2]["number"] = 5;
  var_4._id_68E8[2]["density"] = 0.1;
  var_4._id_68E8[2]["min_start_delay"] = 1;
  var_4._id_68E8[2]["max_start_delay"] = 10;
  var_4._id_68E8[2]["max_total_number"] = var_3;
  var_4._id_68E8[2]["cur_total_number"] = 0;
  var_4._id_68E8[2]["id"] = var_2;
  level._id_68E9["default"] = var_4;
  var_5 = spawnStruct();
  var_5._id_68E8[0]["model"][0] = "body_russian_navy_sleevesdown";
  var_5._id_68E8[0]["model"][1] = "body_russian_navy_sleevesrolled";
  var_5._id_68E8[0]["model"][2] = "body_russian_navy_coat";
  var_5._id_68E8[0]["headmodel"][0] = "head_russian_navy_a";
  var_5._id_68E8[0]["headmodel"][1] = "head_russian_navy_b";
  var_5._id_68E8[0]["headmodel"][2] = "head_russian_navy_c";
  var_5._id_68E8[0]["class"] = "floater";
  var_5._id_68E8[0]["classname"] = "script_model";
  var_5._id_68E8[0]["animation"][0][0] = "harbor_drowning_01";
  var_5._id_68E8[0]["animation"][0][1] = "harbor_drowning_01_idle";
  var_5._id_68E8[0]["animation"][1][0] = "harbor_drowning_02";
  var_5._id_68E8[0]["animation"][1][1] = "harbor_drowning_02_idle";
  var_5._id_68E8[0]["animation"][2][0] = "harbor_drowning_03";
  var_5._id_68E8[0]["animation"][2][1] = "harbor_drowning_03_idle";
  var_5._id_68E8[0]["animation"][3] = "harbor_floating_struggle_01";
  var_5._id_68E8[0]["animation"][4] = "harbor_floating_struggle_02";
  var_5._id_68E8[0]["animation"][5] = "harbor_floating_idle_01";
  var_5._id_68E8[0]["animation"][6] = "harbor_floating_idle_02";
  var_5._id_68E8[0]["animation"][7] = "harbor_floating_idle_03";
  var_5._id_68E8[0]["spawnflags"] = 0;
  var_5._id_68E8[0]["number"] = 5;
  var_5._id_68E8[0]["density"] = 0.2;
  var_5._id_68E8[0]["min_start_delay"] = 1;
  var_5._id_68E8[0]["max_start_delay"] = 10;
  var_5._id_68E8[0]["max_total_number"] = var_3;
  var_5._id_68E8[0]["cur_total_number"] = 0;
  var_5._id_68E8[0]["id"] = var_2;
  level._id_68E9["surface_only"] = var_5;
  var_5 = spawnStruct();
  var_5._id_68E8[0]["model"][0] = "body_russian_navy_sleevesdown";
  var_5._id_68E8[0]["model"][1] = "body_russian_navy_sleevesrolled";
  var_5._id_68E8[0]["model"][2] = "body_russian_navy_coat";
  var_5._id_68E8[0]["headmodel"][0] = "head_russian_navy_a";
  var_5._id_68E8[0]["headmodel"][1] = "head_russian_navy_b";
  var_5._id_68E8[0]["headmodel"][2] = "head_russian_navy_c";
  var_5._id_68E8[0]["class"] = "deadbody";
  var_5._id_68E8[0]["classname"] = "script_model";
  var_5._id_68E8[0]["animation"][0] = "harbor_floating_idle_04";
  var_5._id_68E8[0]["spawnflags"] = 0;
  var_5._id_68E8[0]["number"] = 5;
  var_5._id_68E8[0]["density"] = 0.2;
  var_5._id_68E8[0]["min_start_delay"] = 1;
  var_5._id_68E8[0]["max_start_delay"] = 10;
  var_5._id_68E8[0]["max_total_number"] = var_1;
  var_5._id_68E8[0]["cur_total_number"] = 0;
  var_5._id_68E8[0]["id"] = var_0;
  level._id_68E9["inpath"] = var_5;
  precachemodel("c130_engine_dyn");
  precachemodel("727_cabin_door_dyn");
  precachemodel("727_coach_seat01_dyn");
  precachemodel("727_wing_flaps_long_left_new_dyn");
  precachemodel("727_wing_flaps_short_left_new_dyn");
  precachemodel("c130_engine_damaged_dyn");
  precachemodel("body_russian_navy_sleevesdown");
  precachemodel("body_russian_navy_sleevesrolled");
  precachemodel("body_russian_navy_coat");
  precachemodel("head_russian_navy_a");
  precachemodel("head_russian_navy_b");
  precachemodel("head_russian_navy_c");
}

_id_68EA() {
  var_0 = getEntArray("info_volume", "code_classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "debris_volume") {
      _id_68EC(var_2);
    }
  }

  if(isDefined(level._id_68EB)) {
    foreach(var_5 in level._id_68EB) {}
    var_5 thread _id_68F0();
  }
}

_id_68EC(var_0) {
  var_0._id_49E0 = 0;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  if(isDefined(var_0.target)) {
    var_3 = var_0.target;
    var_1 = getent(var_0.target, "targetname");

    if(isDefined(var_1) && isDefined(var_1.target)) {
      var_2 = getent(var_1.target, "targetname");
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(level._id_68EB) || !isDefined(level._id_68EB[var_3])) {
    var_4 = spawnStruct();
    var_4._id_68ED[0] = var_0;
    var_4._id_68EE = var_1;
    var_4._id_68EF = var_2;
    var_4._id_49E0 = 0;
    level._id_68EB[var_3] = var_4;
  } else {
    var_5 = level._id_68EB[var_3]._id_68ED.size;
    level._id_68EB[var_3]._id_68ED[var_5] = var_0;
  }
}

_id_68F0() {
  for(;;) {
    self._id_68EE waittill("trigger");
    self._id_49E0 = 1;

    foreach(var_1 in self._id_68ED) {}
    var_1 _id_68F1();

    if(!isDefined(self._id_68EF)) {
      return;
    }
    self._id_68EF waittill("trigger");
    self._id_49E0 = 0;

    foreach(var_1 in self._id_68ED) {}
    var_1 _id_68F4();
  }
}

_id_68F1() {
  var_0 = self getpointinbounds(-1, -1, -1);
  var_1 = self getpointinbounds(1, 1, 1);
  var_2 = var_1 - var_0;
  var_3 = abs(var_2[0]) * abs(var_2[1]) * abs(var_2[2]);
  var_3 = var_3 / 2097152;
  var_4 = abs(var_2[0]) * abs(var_2[1]);
  var_4 = var_4 / 16384;
  var_5 = "default";

  if(isDefined(self._id_164F)) {
    var_5 = self._id_164F;

  }
  if(!isDefined(level._id_68E9[var_5])) {
    return;
  }
  var_6 = level._id_68E9[var_5];

  foreach(var_8 in var_6._id_68E8) {
    var_9 = var_8["number"];
    var_10 = var_8["class"];
    var_11 = var_8["id"];

    if(isDefined(var_8["density"])) {
      var_12 = var_8["density"];

      if(var_10 == "floater") {
        var_9 = int(var_4 * var_12);
      } else {
        var_9 = int(var_3 * var_12);
      }
    }

    var_13 = 2;
    var_14 = 0;

    for(var_15 = 0; var_15 < var_9; var_15++) {
      var_16 = undefined;

      if(!isDefined(var_8["max_total_number"]) || !isDefined(level._id_68E5[var_11]) || level._id_68E5[var_11] < var_8["max_total_number"]) {
        switch (var_10) {
          case "static":
            var_16 = _id_68F7(var_8, self);
            break;
          case "sinker":
            var_16 = _id_68F8(var_8, self);
            break;
          case "body":
            var_16 = _id_68FB(var_8, self);
            break;
          case "floater":
            var_16 = _id_68FC(var_8, self);
            break;
          case "deadbody":
            var_16 = _id_6902(var_8, self);
            break;
          case "fx":
            var_16 = _id_6904(var_8, self);
            break;
        }

        if(isDefined(var_16)) {
          var_14++;

          if(!isDefined(self._id_68F2)) {
            self._id_68F2[0] = var_16;
          } else {
            self._id_68F2[self._id_68F2.size] = var_16;

          }
          var_16._id_68F3 = var_11;

          if(isDefined(var_8["max_total_number"])) {
            if(!isDefined(level._id_68E5[var_16._id_68F3])) {
              level._id_68E5[var_16._id_68F3] = 0;

            }
            level._id_68E5[var_16._id_68F3]++;
          }
        }

        if(var_14 >= var_13) {
          var_14 = 0;
          wait 0.05;
        }
      }
    }
  }
}

_id_68F4() {
  if(isDefined(self._id_68F2)) {
    foreach(var_1 in self._id_68F2) {
      if(isDefined(var_1._id_68E4) && var_1._id_68E4 != "0") {
        level._id_68E4[var_1._id_68E4] = undefined;

      }
      if(isDefined(level._id_68E5[var_1._id_68F3])) {
        level._id_68E5[var_1._id_68F3]--;

      }
      var_1 delete();
    }

    self._id_68F2 = undefined;
  }
}

_id_68F5(var_0, var_1, var_2, var_3, var_4) {
  if(!(isDefined(var_4) && var_4 && isDefined(level._id_68F6))) {
    var_4 = 0;

  }
  var_5 = (0, 0, 0);
  var_6 = 0;

  for(var_7 = 0; var_7 < 10; var_7++) {
    var_8 = randomfloatrange(-1, 1);
    var_9 = randomfloatrange(-1, 1);
    var_10 = randomfloatrange(-1, 1);
    var_5 = var_0 getpointinbounds(var_8, var_9, var_10);

    if(var_4) {
      var_5 = (var_5[0], var_5[1], level._id_68F6);

    }
    var_6 = _id_68E6(var_5);

    if(!isDefined(level._id_68E4[var_6])) {
      break;
    } else {
      var_6 = 0;
    }
  }

  var_11 = spawn(var_1, var_5, var_3);
  var_11._id_68E4 = var_6;

  if(var_6 != "0") {
    level._id_68E4[var_6] = var_11;

  }
  var_11 setModel(var_2);
  var_8 = randomfloatrange(-180, 180);
  var_9 = randomfloatrange(-180, 180);
  var_10 = randomfloatrange(-180, 180);

  if(var_4) {
    var_8 = 0;
    var_10 = 0;
  }

  var_11.angles = (var_8, var_9, var_10);
  return var_11;
}

_id_68F7(var_0, var_1) {
  if(isarray(var_0["model"])) {
    var_2 = common_scripts\utility::random(var_0["model"]);
  } else {
    var_2 = var_0["model"];

  }
  var_3 = _id_68F5(var_1, var_0["classname"], var_2, var_0["spawnflags"]);
  return var_3;
}

_id_68F8(var_0, var_1) {
  if(isarray(var_0["model"])) {
    var_2 = common_scripts\utility::random(var_0["model"]);
  } else {
    var_2 = var_0["model"];

  }
  var_3 = _id_68F5(var_1, var_0["classname"], var_2, var_0["spawnflags"]);
  var_3 thread _id_68FA(var_0, var_1);
  return var_3;
}

_id_68F9(var_0, var_1) {
  self endon("death");
  var_2 = bulletTrace(self.origin + (0, 0, 12), self.origin + (0, 0, -12000), 0, undefined);
  var_3 = var_2["position"];
  var_4 = distance(self.origin, var_3);
  var_5 = var_4 / var_0;
  self moveto(var_3, var_5, 0, 0);

  if(var_1) {
    var_6 = randomfloatrange(-4, 4);
    var_7 = randomfloatrange(-4, 4);
    var_8 = randomfloatrange(-4, 4);
    self rotatevelocity((var_6, var_7, var_8), var_5, 0, 0);
  }

  wait(var_5);
}

_id_68FA(var_0, var_1) {
  self endon("death");

  if(isDefined(var_0["sinkvel"])) {
    var_2 = var_0["sinkvel"];

    if(var_2 != 0) {
      _id_68F9(var_2, isDefined(var_0["sinkrot"]));
    }
  }
}

_id_68FB(var_0, var_1) {
  if(isarray(var_0["model"])) {
    var_2 = common_scripts\utility::random(var_0["model"]);
  } else {
    var_2 = var_0["model"];

  }
  var_3 = _id_68F5(var_1, var_0["classname"], var_2, var_0["spawnflags"]);
  var_3._id_1032 = "floating_body";
  var_3 maps\_anim::_id_1244();

  if(isDefined(var_0["headmodel"])) {
    if(isarray(var_0["headmodel"])) {
      var_4 = common_scripts\utility::random(var_0["headmodel"]);
    } else {
      var_4 = var_0["headmodel"];

    }
    var_3 attach(var_4, "", 1);
  }

  if(isarray(var_0["animation"])) {
    var_5 = common_scripts\utility::random(var_0["animation"]);
  } else {
    var_5 = var_0["animation"];

  }
  var_3 thread maps\_anim::_id_11C8(var_3, var_5);
  var_3 thread body(var_0, var_1);
  return var_3;
}

body(var_0, var_1) {
  self endon("death");

  if(isDefined(var_0["sinkvel"])) {
    var_2 = var_0["sinkvel"];

    if(var_2 != 0) {
      _id_68F9(var_2, isDefined(var_0["sinkrot"]));
    }
  }
}

_id_68FC(var_0, var_1) {
  if(isarray(var_0["model"])) {
    var_2 = common_scripts\utility::random(var_0["model"]);
  } else {
    var_2 = var_0["model"];

  }
  var_3 = _id_68F5(var_1, var_0["classname"], var_2, var_0["spawnflags"], 1);
  var_3._id_1032 = "floating_body";
  var_3 maps\_anim::_id_1244();

  if(isDefined(var_0["headmodel"])) {
    if(isarray(var_0["headmodel"])) {
      var_4 = common_scripts\utility::random(var_0["headmodel"]);
    } else {
      var_4 = var_0["headmodel"];

    }
    var_3 attach(var_4, "", 1);
  }

  var_5 = common_scripts\utility::random(var_0["animation"]);
  var_3 thread _id_68FD(var_0, var_1, var_5);
  return var_3;
}

_id_68FD(var_0, var_1, var_2) {
  self endon("death");

  if(isarray(var_2)) {
    maps\_anim::_id_11C0(self, var_2[0]);

    for(;;) {
      var_3 = distance2d(level.player.origin, self.origin);

      if(var_3 < 1200) {
        break;
      }

      wait 0.2;
    }

    wait(randomfloatrange(var_0["min_start_delay"], var_0["max_start_delay"]));
    maps\_anim::_id_11C1(self, var_2[0]);
    var_4 = var_2[1];
  } else {
    var_4 = var_2;

  }
  maps\_anim::_id_11C8(self, var_4);
}

_id_68FE(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_0._id_3DB0 = var_1;
  var_0 linkto(var_1, "tag_origin");

  if(!isDefined(level._id_68FF)) {
    level._id_68FF[0] = var_0;
  } else {
    level._id_68FF[level._id_68FF.size] = var_0;

  }
  var_0 thread _id_6901();
}

_id_6900(var_0) {
  level._id_68FF = common_scripts\utility::array_remove(level._id_68FF, var_0);
}

_id_6901() {
  self waittill("death");
  _id_6900(self);
  self._id_3DB0 delete();
}

_id_6902(var_0, var_1) {
  if(isarray(var_0["model"])) {
    var_2 = common_scripts\utility::random(var_0["model"]);
  } else {
    var_2 = var_0["model"];

  }
  var_3 = _id_68F5(var_1, var_0["classname"], var_2, var_0["spawnflags"]);
  var_3._id_1032 = "floating_body";
  var_3 maps\_anim::_id_1244();

  if(isDefined(var_0["headmodel"])) {
    if(isarray(var_0["headmodel"])) {
      var_4 = common_scripts\utility::random(var_0["headmodel"]);
    } else {
      var_4 = var_0["headmodel"];

    }
    var_3 attach(var_4, "", 1);
  }

  if(isarray(var_0["animation"])) {
    var_5 = common_scripts\utility::random(var_0["animation"]);
  } else {
    var_5 = var_0["animation"];

  }
  var_3 thread maps\_anim::_id_11C8(var_3, var_5);
  _id_68FE(var_3);
  var_3 thread _id_6903(var_0, var_1);
  return var_3;
}

_id_6903(var_0, var_1) {
  self endon("death");
}

_id_6904(var_0, var_1) {}

_id_6905() {
  var_0 = (1, 1, 1);
  var_1[0] = self getpointinbounds(-1, -1, -1);
  var_1[1] = self getpointinbounds(-1, -1, 1);
  var_1[2] = self getpointinbounds(-1, 1, -1);
  var_1[3] = self getpointinbounds(-1, 1, 1);
  var_1[4] = self getpointinbounds(1, -1, -1);
  var_1[5] = self getpointinbounds(1, -1, 1);
  var_1[6] = self getpointinbounds(1, 1, -1);
  var_1[7] = self getpointinbounds(1, 1, 1);

  for(var_2 = 0; var_2 < 8; var_2 = var_2 + 2) {}

  for(var_2 = 0; var_2 < 4; var_2 = var_2 + 1) {}

  for(var_2 = 0; var_2 < 2; var_2 = var_2 + 1) {}

  for(var_2 = 4; var_2 < 5; var_2 = var_2 + 1) {}
}

_id_6877() {
  for(;;) {
    foreach(var_2, var_1 in level._id_68E5) {}
    iprintln("dvc " + var_2 + " = " + var_1);

    foreach(var_8, var_4 in level._id_68EB) {
      if(var_4._id_49E0) {
        iprintln("dv " + var_8 + " active");

        foreach(var_6 in var_4._id_68ED) {}
        var_6 _id_6905();
      }
    }

    wait 0.05;
  }
}