/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3877.gsc
************************/

func_11408() {
  if(!isDefined(self.var_11400)) {
    func_11406();
  }

  func_1140B(1);
}

func_11407() {
  func_1140B(0);
  self notify("tagging_think");
}

func_1140B(param_00, param_01) {
  if(!isDefined(self.var_11400)) {
    func_11406();
  }

  if(!isDefined(param_01)) {
    param_01 = 4;
  }

  self.var_11400["enabled"] = param_00;
  self.var_11400["action_slot"] = param_01;
  func_1140C(param_00);
}

func_1140C(param_00) {
  if(!isDefined(self.var_11400)) {
    func_11406();
  }

  self.var_11400["marking_enabled"] = param_00;
  var_01 = func_11401();
  if(!self.var_11400["marking_enabled"]) {
    foreach(var_03 in var_01) {
      if(!isDefined(var_03)) {
        continue;
      }

      if(issentient(var_03) && !isalive(var_03)) {
        continue;
      }

      var_03 func_113EB("none", self);
      var_03 notify("tagged_entity_death_cleanup");
      var_03 func_113FA();
    }

    return;
  }

  foreach(var_03 in var_03) {
    if(!isDefined(var_03)) {
      continue;
    }

    if(issentient(var_03) && !isalive(var_03)) {
      continue;
    }

    if(isDefined(var_03.var_113F3) && isDefined(var_03.var_113F3[self getentitynumber()])) {
      var_03 func_113D9(self);
    }
  }
}

func_113D9(param_00, param_01) {
  if(!isDefined(level.var_11414)) {
    level func_11AE9();
    level.var_11414 = 1;
  }

  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  if(!isDefined(self) || issentient(self) && !isalive(self)) {
    if(isDefined(self)) {
      func_113E2(0);
    }

    return;
  }

  if(param_01 && !isDefined(self.var_113F3) || !isDefined(self.var_113F3[param_00 getentitynumber()]) || !self.var_113F3[param_00 getentitynumber()]) {
    param_00 thread scripts\sp\utility::play_sound_on_entity("drone_tag_success");
  }

  self.var_113F3[param_00 getentitynumber()] = 1;
  func_113E2(1);
  self.var_113E9 = undefined;
  self.var_113E8 = undefined;
  self.var_113EA = undefined;
  func_113FB();
}

func_113DA(param_00, param_01) {
  if(isDefined(self.var_113DB) && self.var_113DB == param_01) {
    return;
  }

  self.var_113DB = param_01;
  self notify("tag_flash_entity");
  self endon("tag_flash_entity");
  self endon("death");
  param_00 endon("death");
  param_00 endon("disconnect");
  if(!isDefined(self) || issentient(self) && !isalive(self)) {
    if(isDefined(self)) {
      func_113E2(0);
    }

    return;
  }

  var_02 = param_00 getentitynumber();
  if(!isDefined(param_00.var_113E1)) {
    param_00.var_113E1 = 0;
  }

  var_03 = isDefined(self.var_113F3) && scripts\engine\utility::istrue(self.var_113F3[var_02]);
  var_04 = 1;
  while(param_01 && getdvarint("ai_threatsight", 1)) {
    self.var_113F9 = 1;
    if(var_04) {
      func_113E2(1, "dead");
    } else {
      func_113E2(var_03);
    }

    var_05 = param_00.var_113E1 - gettime();
    if(var_05 > 0) {
      wait(float(var_05) / 1000);
    }

    var_04 = !var_04;
    param_00.var_113E1 = gettime() + 200;
    var_03 = isDefined(self.var_113F3) && scripts\engine\utility::istrue(self.var_113F3[var_02]);
  }

  func_113E2(var_03);
}

func_11406() {
  if(!isDefined(level.var_11414)) {
    level func_11AE9();
    level.var_11414 = 1;
  }

  self.var_11400 = [];
  self.var_11400["enabled"] = 1;
  self.var_11400["marking_enabled"] = 1;
  self.var_11400["outline_enabled"] = 1;
  self.var_11400["tagging_mode"] = 0;
  self.var_11400["last_tag_start"] = 0;
  self.var_11400["action_slot"] = 4;
  self.var_11400["tagging_fade_min"] = 500;
  self.var_11400["tagging_fade_max"] = 3000;
}

func_11AE9() {
  setdvarifuninitialized("tagging_ads_cone_range", 3000);
  setdvarifuninitialized("tagging_ads_cone_angle", 10);
  setdvarifuninitialized("tagging_normal_pulse_rate", 50);
  setdvarifuninitialized("tagging_normal_prep_time", 250);
  setdvarifuninitialized("tagging_normal_track_time", 500);
  setdvarifuninitialized("tagging_slow_pulse_rate", 100);
  setdvarifuninitialized("tagging_slow_prep_time", 500);
  setdvarifuninitialized("tagging_slow_track_time", 1000);
  setdvarifuninitialized("tagging_foliage", 0);
  setdvarifuninitialized("tagging_vehicle_ride", 0);
  scripts\sp\utility::func_9189("tagging", -1, "default");
  setsaveddvar("r_hudoutlineEnable", 1);
}

func_11405() {
  var_00 = [];
  var_00["r_hudoutlineFillColor0"] = "0.5 0.5 0.5 0";
  var_00["r_hudoutlineFillColor1"] = "0.5 0.5 0.5 0";
  var_00["r_hudoutlineOccludedOutlineColor"] = "0.5 0.5 0.5 1";
  var_00["r_hudoutlineOccludedInlineColor"] = "0.5 0.5 0.5 0.5";
  var_00["r_hudoutlineOccludedInteriorColor"] = "0.5 0.5 0.5 0.5";
  var_00["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_00;
}

func_1140E() {
  self notify("tagging_shutdown");
  func_1140B(0);
  if(isDefined(self.var_11400) && isDefined(self.var_11400["camera"])) {
    self.var_11400["camera"] delete();
  }

  self.var_11400 = undefined;
}

func_11401() {
  var_00 = level.var_10E6D.enemies[self.team];
  var_01 = getEntArray("rss_static_robot", "script_noteworthy");
  var_02 = getaiarray(self.team);
  var_03 = scripts\engine\utility::array_combine(var_00, var_01);
  var_04 = scripts\engine\utility::array_combine(var_03, var_02);
  return var_04;
}

func_1140D() {
  return isDefined(self.var_C337) && isDefined(self.var_C337.var_19) && self.var_C337.var_19;
}

func_11412() {
  self notify("tagging_think");
  self endon("tagging_think");
  self endon("death");
  self endon("disconnect");
  while(isDefined(self) && isDefined(self.var_11400)) {
    if(!isDefined(self.var_11400["enabled"])) {
      return;
    }

    if(!isDefined(self.var_11400["outline_enabled"])) {
      return;
    }

    var_00 = self.var_11400["enabled"] && self.var_11400["outline_enabled"];
    if(var_00 && scripts\sp\utility::func_9D27() || func_1140D()) {
      func_113EC();
    }

    wait(0.05);
  }
}

func_113EC() {
  var_00 = func_11401();
  var_01 = self getEye();
  var_02 = anglesToForward(self getplayerangles());
  var_03 = undefined;
  var_04 = max(0.01, getdvarfloat("tagging_ads_cone_range"));
  var_05 = cos(getdvarfloat("tagging_ads_cone_angle"));
  var_06 = [0, 0.5, 1];
  if(func_1140D()) {
    var_04 = level.player.var_11400["tagging_fade_max"];
    var_05 = cos(getdvarfloat("cg_fov"));
  }

  var_07 = bulletTrace(var_01, var_01 + var_02 * 32000, 1, self);
  var_03 = var_07["entity"];
  foreach(var_09 in var_00) {
    if(!isDefined(var_09)) {
      continue;
    }

    if(issentient(var_09) && !isalive(var_09)) {
      continue;
    }

    if(isDefined(var_09.var_113F3) && isDefined(var_09.var_113F3[self getentitynumber()])) {
      continue;
    }

    if(!getdvarint("tagging_vehicle_ride") && isDefined(var_09.var_13223) && var_09.var_13223.var_37A > 0) {
      continue;
    }

    var_0A = isDefined(var_03) && var_03 == var_09;
    if(!var_0A) {
      var_0B = var_09 gettagorigin("tag_origin");
      if(isai(var_09)) {
        var_0B = var_09 getEye();
      }

      var_0C = distance(var_0B, var_01);
      if(var_0C <= var_04) {
        var_0D = min(1, var_05 + 1 - var_05 * var_0C / var_04);
        foreach(var_0F in var_06) {
          var_10 = vectorlerp(var_09.origin, var_0B, var_0F);
          var_11 = var_10 - var_01;
          var_12 = vectornormalize(var_11);
          var_13 = vectordot(var_12, var_02);
          if(var_13 > var_0D) {
            if(func_1140D()) {
              var_0A = 1;
              break;
            }

            if(func_650A(var_09)) {
              var_0A = 1;
              break;
            }
          }
        }
      }
    }

    if(var_0A) {
      var_09 func_113EB("tracking", self, 1);
      continue;
    }

    var_09 func_113EB("none", self, 0);
  }
}

func_650C() {
  if(isDefined(self.var_11411)) {
    return;
  }

  if(!isDefined(self.var_1140F)) {
    self.var_1140F = 0;
  }

  if(!isDefined(level.var_11410)) {
    level.var_11410 = [];
    level thread func_650B();
  }

  level.var_11410 = scripts\engine\utility::array_add(level.var_11410, self);
  self.var_11411 = 1;
}

func_650B() {
  self notify("enemy_sight_trace_process");
  self endon("enemy_sight_trace_process");
  var_00 = 3;
  for(;;) {
    level.var_11410 = scripts\engine\utility::array_removeundefined(level.var_11410);
    for(var_01 = 0; var_01 < min(var_00, level.var_11410.size); var_01++) {
      var_02 = level.var_11410[0];
      level.var_11410 = scripts\engine\utility::array_remove(level.var_11410, var_02);
      var_02.var_1140F = func_6509(var_02);
      var_02.var_11411 = undefined;
    }

    wait(0.05);
  }
}

func_650A(param_00) {
  param_00 func_650C();
  return param_00.var_1140F;
}

func_6509(param_00) {
  var_01 = 0;
  var_02 = level.player getEye();
  if(!var_01 && param_00 scripts\sp\utility::hastag(param_00.model, "j_head")) {
    if(sighttracepassed(var_02, param_00 gettagorigin("j_head"), 0, param_00.var_101E1, param_00, 0)) {
      var_01 = 1;
    }
  }

  if(!var_01 && param_00 scripts\sp\utility::hastag(param_00.model, "j_spinelower")) {
    if(sighttracepassed(var_02, param_00 gettagorigin("j_spinelower"), 0, param_00.var_101E1, param_00, 0)) {
      var_01 = 1;
    }
  }

  if(!var_01 && param_00 scripts\sp\utility::hastag(param_00.model, "tag_attach")) {
    if(sighttracepassed(var_02, param_00 gettagorigin("tag_attach"), 0, param_00.var_101E1, param_00, 0)) {
      var_01 = 1;
    }
  }

  if(!var_01 && sighttracepassed(var_02, param_00.origin, 0, param_00.var_101E1, param_00, 0)) {
    var_01 = 1;
  }

  return var_01;
}

func_113EB(param_00, param_01, param_02) {
  var_03 = gettime();
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  var_04 = getdvarint("tagging_normal_pulse_rate");
  var_05 = getdvarint("tagging_normal_prep_time");
  var_06 = getdvarint("tagging_normal_track_time");
  var_07 = 0;
  if(!param_01.var_11400["marking_enabled"]) {
    param_00 = "range";
  }

  switch (param_00) {
    case "view":
      var_07 = 1;
      self.var_113E9 = 0;
      self.var_113EA = undefined;
      break;

    case "range":
      self.var_113E9 = 0;
      self.var_113EA = undefined;
      break;

    case "tracking_slow":
      var_04 = getdvarint("tagging_slow_pulse_rate");
      var_05 = getdvarint("tagging_slow_prep_time");
      var_06 = getdvarint("tagging_slow_track_time");
      break;

    case "tracking":
      if(!isDefined(self.var_113EA)) {
        if(gettime() - param_01.var_11400["last_tag_start"] / 1000 <= 0.25) {
          return;
        }

        self.var_113EA = var_03;
        param_01.var_11400["last_tag_start"] = var_03;
      }
      break;

    case "obstructed":
    case "none":
    default:
      func_113E2(0);
      self.var_113EA = undefined;
      break;
  }

  var_08 = var_06 + var_05;
  var_09 = 0;
  if(isDefined(self.var_113EA)) {
    var_09 = var_03 - self.var_113EA;
  }

  if(var_09 >= var_08) {
    if(param_02) {
      param_01.var_113F4 = 1;
    }

    func_113D9(param_01);
  }
}

func_113E2(param_00, param_01) {
  if(!isDefined(self)) {
    return;
  }

  if(param_00) {
    func_113FB(param_01);
    thread func_113F7();
    thread func_113F8();
    return;
  }

  func_113FA();
  self notify("tagged_entity_update");
}

func_113F8() {
  self endon("death");
  self notify("tagged_entity_update");
  self endon("tagged_entity_update");
  for(;;) {
    if(!getdvarint("tagging_vehicle_ride") && isDefined(self.var_13223) && self.var_13223.var_37A > 0) {
      func_113E2(0);
      self notify("tagged_entity_death_cleanup");
      self.var_113F3 = undefined;
      return;
    }

    if(!isDefined(self.var_113F9)) {
      if(!isDefined(self.var_113FD)) {
        self.var_113FD = gettime();
      }

      var_00 = int(gettime() - self.var_113FD / 100);
      if(var_00 % 2) {
        func_113FA();
      } else {
        func_113FB();
      }

      if(var_00 > 3) {
        func_113FB();
        self.var_113F9 = 1;
      }
    }

    if(isDefined(self.var_FC9D)) {
      thread func_113FE();
    }

    wait(0.05);
  }
}

func_113FE() {
  self notify("tagged_wait_shield_off");
  self endon("tagged_wait_shield_off");
  self endon("death");
  self waittill("hudoutline_off");
  func_113FB();
}

func_113F5() {
  var_00["allies"] = 3;
  var_00["axis"] = 1;
  var_00["team3"] = 0;
  var_00["dead"] = 0;
  var_01 = "dead";
  if(isDefined(self.team)) {
    var_01 = self.team;
  }

  return var_00[var_01];
}

func_113FB(param_00) {
  if(!isDefined(self)) {
    return;
  }

  func_113FA();
  var_01 = func_113F5();
  scripts\sp\utility::func_9196(var_01, 0, 1, "tagging");
  thread func_113FC();
  self.var_11413 = 1;
}

func_113FA() {
  if(!isDefined(self)) {
    return;
  }

  self notify("tagged_status_update");
  scripts\sp\utility::func_9193("tagging");
  self.var_11413 = undefined;
}

func_113FC() {
  self notify("tagged_status_update");
  self endon("tagged_status_update");
  self endon("death");
  while(isDefined(self) && !issentient(self) || isalive(self)) {
    var_00 = level.player.var_11400["tagging_fade_max"];
    var_01 = var_00 * var_00;
    var_02 = lengthsquared(level.player.origin - self.origin);
    if(var_02 > var_01) {
      func_113FA();
      continue;
    }

    func_113FB();
    wait(0.05);
  }
}

func_113F7() {
  if(isDefined(self.var_113F7)) {
    return;
  }

  self notify("tagged_entity_death_cleanup");
  self endon("tagged_entity_death_cleanup");
  self.var_113F7 = 1;
  self waittill("death", var_00, var_01);
  if(isplayer(var_00)) {
    wait(0.1);
    if(isDefined(self) && distancesquared(self.origin, level.player.origin) > 90000) {
      var_02 = gettime();
      var_03 = 1;
      while(isDefined(self) && gettime() - var_02 < 1000) {
        if(var_03 == 0 && randomint(100) < 30) {
          func_113E2(1);
          var_03 = 1;
          continue;
        }

        if(var_03 == 1) {
          func_113E2(0);
          var_03 = 0;
        }

        wait(0.05);
      }
    }
  }

  if(isDefined(self)) {
    func_113E2(0);
  }

  self.var_113F7 = undefined;
}