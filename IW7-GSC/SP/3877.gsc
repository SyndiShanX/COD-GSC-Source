/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3877.gsc
*********************************************/

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

func_1140B(var_0, var_1) {
  if(!isDefined(self.var_11400)) {
    func_11406();
  }

  if(!isDefined(var_1)) {
    var_1 = 4;
  }

  self.var_11400["enabled"] = var_0;
  self.var_11400["action_slot"] = var_1;
  func_1140C(var_0);
}

func_1140C(var_0) {
  if(!isDefined(self.var_11400)) {
    func_11406();
  }

  self.var_11400["marking_enabled"] = var_0;
  var_1 = func_11401();
  if(!self.var_11400["marking_enabled"]) {
    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }

      if(issentient(var_3) && !isalive(var_3)) {
        continue;
      }

      var_3 func_113EB("none", self);
      var_3 notify("tagged_entity_death_cleanup");
      var_3 func_113FA();
    }

    return;
  }

  foreach(var_3 in var_3) {
    if(!isDefined(var_3)) {
      continue;
    }

    if(issentient(var_3) && !isalive(var_3)) {
      continue;
    }

    if(isDefined(var_3.var_113F3) && isDefined(var_3.var_113F3[self getentitynumber()])) {
      var_3 func_113D9(self);
    }
  }
}

func_113D9(var_0, var_1) {
  if(!isDefined(level.var_11414)) {
    level func_11AE9();
    level.var_11414 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(self) || issentient(self) && !isalive(self)) {
    if(isDefined(self)) {
      func_113E2(0);
    }

    return;
  }

  if(var_1 && !isDefined(self.var_113F3) || !isDefined(self.var_113F3[var_0 getentitynumber()]) || !self.var_113F3[var_0 getentitynumber()]) {
    var_0 thread scripts\sp\utility::play_sound_on_entity("drone_tag_success");
  }

  self.var_113F3[var_0 getentitynumber()] = 1;
  func_113E2(1);
  self.var_113E9 = undefined;
  self.var_113E8 = undefined;
  self.var_113EA = undefined;
  func_113FB();
}

func_113DA(var_0, var_1) {
  if(isDefined(self.var_113DB) && self.var_113DB == var_1) {
    return;
  }

  self.var_113DB = var_1;
  self notify("tag_flash_entity");
  self endon("tag_flash_entity");
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  if(!isDefined(self) || issentient(self) && !isalive(self)) {
    if(isDefined(self)) {
      func_113E2(0);
    }

    return;
  }

  var_2 = var_0 getentitynumber();
  if(!isDefined(var_0.var_113E1)) {
    var_0.var_113E1 = 0;
  }

  var_3 = isDefined(self.var_113F3) && scripts\engine\utility::istrue(self.var_113F3[var_2]);
  var_4 = 1;
  while(var_1 && getdvarint("ai_threatsight", 1)) {
    self.var_113F9 = 1;
    if(var_4) {
      func_113E2(1, "dead");
    } else {
      func_113E2(var_3);
    }

    var_5 = var_0.var_113E1 - gettime();
    if(var_5 > 0) {
      wait(float(var_5) / 1000);
    }

    var_4 = !var_4;
    var_0.var_113E1 = gettime() + 200;
    var_3 = isDefined(self.var_113F3) && scripts\engine\utility::istrue(self.var_113F3[var_2]);
  }

  func_113E2(var_3);
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
  var_0 = [];
  var_0["r_hudoutlineFillColor0"] = "0.5 0.5 0.5 0";
  var_0["r_hudoutlineFillColor1"] = "0.5 0.5 0.5 0";
  var_0["r_hudoutlineOccludedOutlineColor"] = "0.5 0.5 0.5 1";
  var_0["r_hudoutlineOccludedInlineColor"] = "0.5 0.5 0.5 0.5";
  var_0["r_hudoutlineOccludedInteriorColor"] = "0.5 0.5 0.5 0.5";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_0;
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
  var_0 = level.var_10E6D.enemies[self.team];
  var_1 = getEntArray("rss_static_robot", "script_noteworthy");
  var_2 = getaiarray(self.team);
  var_3 = scripts\engine\utility::array_combine(var_0, var_1);
  var_4 = scripts\engine\utility::array_combine(var_3, var_2);
  return var_4;
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

    var_0 = self.var_11400["enabled"] && self.var_11400["outline_enabled"];
    if(var_0 && scripts\sp\utility::func_9D27() || func_1140D()) {
      func_113EC();
    }

    wait(0.05);
  }
}

func_113EC() {
  var_0 = func_11401();
  var_1 = self getEye();
  var_2 = anglesToForward(self getplayerangles());
  var_3 = undefined;
  var_4 = max(0.01, getdvarfloat("tagging_ads_cone_range"));
  var_5 = cos(getdvarfloat("tagging_ads_cone_angle"));
  var_6 = [0, 0.5, 1];
  if(func_1140D()) {
    var_4 = level.player.var_11400["tagging_fade_max"];
    var_5 = cos(getdvarfloat("cg_fov"));
  }

  var_7 = bulletTrace(var_1, var_1 + var_2 * 32000, 1, self);
  var_3 = var_7["entity"];
  foreach(var_9 in var_0) {
    if(!isDefined(var_9)) {
      continue;
    }

    if(issentient(var_9) && !isalive(var_9)) {
      continue;
    }

    if(isDefined(var_9.var_113F3) && isDefined(var_9.var_113F3[self getentitynumber()])) {
      continue;
    }

    if(!getdvarint("tagging_vehicle_ride") && isDefined(var_9.var_13223) && var_9.var_13223.var_37A > 0) {
      continue;
    }

    var_0A = isDefined(var_3) && var_3 == var_9;
    if(!var_0A) {
      var_0B = var_9 gettagorigin("tag_origin");
      if(isai(var_9)) {
        var_0B = var_9 getEye();
      }

      var_0C = distance(var_0B, var_1);
      if(var_0C <= var_4) {
        var_0D = min(1, var_5 + 1 - var_5 * var_0C / var_4);
        foreach(var_0F in var_6) {
          var_10 = vectorlerp(var_9.origin, var_0B, var_0F);
          var_11 = var_10 - var_1;
          var_12 = vectornormalize(var_11);
          var_13 = vectordot(var_12, var_2);
          if(var_13 > var_0D) {
            if(func_1140D()) {
              var_0A = 1;
              break;
            }

            if(func_650A(var_9)) {
              var_0A = 1;
              break;
            }
          }
        }
      }
    }

    if(var_0A) {
      var_9 func_113EB("tracking", self, 1);
      continue;
    }

    var_9 func_113EB("none", self, 0);
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
  var_0 = 3;
  for(;;) {
    level.var_11410 = scripts\engine\utility::array_removeundefined(level.var_11410);
    for(var_1 = 0; var_1 < min(var_0, level.var_11410.size); var_1++) {
      var_2 = level.var_11410[0];
      level.var_11410 = scripts\engine\utility::array_remove(level.var_11410, var_2);
      var_2.var_1140F = func_6509(var_2);
      var_2.var_11411 = undefined;
    }

    wait(0.05);
  }
}

func_650A(var_0) {
  var_0 func_650C();
  return var_0.var_1140F;
}

func_6509(var_0) {
  var_1 = 0;
  var_2 = level.player getEye();
  if(!var_1 && var_0 scripts\sp\utility::hastag(var_0.model, "j_head")) {
    if(sighttracepassed(var_2, var_0 gettagorigin("j_head"), 0, var_0.var_101E1, var_0, 0)) {
      var_1 = 1;
    }
  }

  if(!var_1 && var_0 scripts\sp\utility::hastag(var_0.model, "j_spinelower")) {
    if(sighttracepassed(var_2, var_0 gettagorigin("j_spinelower"), 0, var_0.var_101E1, var_0, 0)) {
      var_1 = 1;
    }
  }

  if(!var_1 && var_0 scripts\sp\utility::hastag(var_0.model, "tag_attach")) {
    if(sighttracepassed(var_2, var_0 gettagorigin("tag_attach"), 0, var_0.var_101E1, var_0, 0)) {
      var_1 = 1;
    }
  }

  if(!var_1 && sighttracepassed(var_2, var_0.origin, 0, var_0.var_101E1, var_0, 0)) {
    var_1 = 1;
  }

  return var_1;
}

func_113EB(var_0, var_1, var_2) {
  var_3 = gettime();
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = getdvarint("tagging_normal_pulse_rate");
  var_5 = getdvarint("tagging_normal_prep_time");
  var_6 = getdvarint("tagging_normal_track_time");
  var_7 = 0;
  if(!var_1.var_11400["marking_enabled"]) {
    var_0 = "range";
  }

  switch (var_0) {
    case "view":
      var_7 = 1;
      self.var_113E9 = 0;
      self.var_113EA = undefined;
      break;

    case "range":
      self.var_113E9 = 0;
      self.var_113EA = undefined;
      break;

    case "tracking_slow":
      var_4 = getdvarint("tagging_slow_pulse_rate");
      var_5 = getdvarint("tagging_slow_prep_time");
      var_6 = getdvarint("tagging_slow_track_time");
      break;

    case "tracking":
      if(!isDefined(self.var_113EA)) {
        if(gettime() - var_1.var_11400["last_tag_start"] / 1000 <= 0.25) {
          return;
        }

        self.var_113EA = var_3;
        var_1.var_11400["last_tag_start"] = var_3;
      }
      break;

    case "obstructed":
    case "none":
    default:
      func_113E2(0);
      self.var_113EA = undefined;
      break;
  }

  var_8 = var_6 + var_5;
  var_9 = 0;
  if(isDefined(self.var_113EA)) {
    var_9 = var_3 - self.var_113EA;
  }

  if(var_9 >= var_8) {
    if(var_2) {
      var_1.var_113F4 = 1;
    }

    func_113D9(var_1);
  }
}

func_113E2(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }

  if(var_0) {
    func_113FB(var_1);
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

      var_0 = int(gettime() - self.var_113FD / 100);
      if(var_0 % 2) {
        func_113FA();
      } else {
        func_113FB();
      }

      if(var_0 > 3) {
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
  var_0["allies"] = 3;
  var_0["axis"] = 1;
  var_0["team3"] = 0;
  var_0["dead"] = 0;
  var_1 = "dead";
  if(isDefined(self.team)) {
    var_1 = self.team;
  }

  return var_0[var_1];
}

func_113FB(var_0) {
  if(!isDefined(self)) {
    return;
  }

  func_113FA();
  var_1 = func_113F5();
  scripts\sp\utility::func_9196(var_1, 0, 1, "tagging");
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
    var_0 = level.player.var_11400["tagging_fade_max"];
    var_1 = var_0 * var_0;
    var_2 = lengthsquared(level.player.origin - self.origin);
    if(var_2 > var_1) {
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
  self waittill("death", var_0, var_1);
  if(isplayer(var_0)) {
    wait(0.1);
    if(isDefined(self) && distancesquared(self.origin, level.player.origin) > 90000) {
      var_2 = gettime();
      var_3 = 1;
      while(isDefined(self) && gettime() - var_2 < 1000) {
        if(var_3 == 0 && randomint(100) < 30) {
          func_113E2(1);
          var_3 = 1;
          continue;
        }

        if(var_3 == 1) {
          func_113E2(0);
          var_3 = 0;
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