/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3877.gsc
**************************************/

_id_11408() {
  if(!isDefined(self._id_11400)) {
    _id_11406();
  }

  _id_1140B(1);
}

_id_11407() {
  _id_1140B(0);
  self notify("tagging_think");
}

_id_1140B(var_0, var_1) {
  if(!isDefined(self._id_11400)) {
    _id_11406();
  }

  if(!isDefined(var_1)) {
    var_1 = 4;
  }

  self._id_11400["enabled"] = var_0;
  self._id_11400["action_slot"] = var_1;
  _id_1140C(var_0);
}

_id_1140C(var_0) {
  if(!isDefined(self._id_11400)) {
    _id_11406();
  }

  self._id_11400["marking_enabled"] = var_0;
  var_1 = _id_11401();

  if(!self._id_11400["marking_enabled"]) {
    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(issentient(var_3) && !isalive(var_3)) {
        continue;
      }
      var_3 _id_113EB("none", self);
      var_3 notify("tagged_entity_death_cleanup");
      var_3 _id_113FA();
    }
  } else {
    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(issentient(var_3) && !isalive(var_3)) {
        continue;
      }
      if(isDefined(var_3._id_113F3) && isDefined(var_3._id_113F3[self getentitynumber()])) {
        var_3 _id_113D9(self);
      }
    }
  }
}

_id_113D9(var_0, var_1) {
  if(!isDefined(level._id_11414)) {
    level _id_11AE9();
    level._id_11414 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(self) || issentient(self) && !isalive(self)) {
    if(isDefined(self)) {
      _id_113E2(0);
    }

    return;
  }

  if(var_1 && (!isDefined(self._id_113F3) || !isDefined(self._id_113F3[var_0 getentitynumber()]) || !self._id_113F3[var_0 getentitynumber()])) {
    var_0 thread scripts\sp\utility::play_sound_on_entity("drone_tag_success");
  }

  self._id_113F3[var_0 getentitynumber()] = 1;
  _id_113E2(1);
  self._id_113E9 = undefined;
  self._id_113E8 = undefined;
  self._id_113EA = undefined;
  _id_113FB();
}

_id_113DA(var_0, var_1) {
  if(isDefined(self._id_113DB) && self._id_113DB == var_1) {
    return;
  }
  self._id_113DB = var_1;
  self notify("tag_flash_entity");
  self endon("tag_flash_entity");
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!isDefined(self) || issentient(self) && !isalive(self)) {
    if(isDefined(self)) {
      _id_113E2(0);
    }

    return;
  }

  var_2 = var_0 getentitynumber();

  if(!isDefined(var_0._id_113E1)) {
    var_0._id_113E1 = 0;
  }

  var_3 = isDefined(self._id_113F3) && scripts\engine\utility::is_true(self._id_113F3[var_2]);

  for(var_4 = 1; var_1 && getdvarint("ai_threatsight", 1); var_3 = isDefined(self._id_113F3) && scripts\engine\utility::is_true(self._id_113F3[var_2])) {
    self._id_113F9 = 1;

    if(var_4) {
      _id_113E2(1, "dead");
    } else {
      _id_113E2(var_3);
    }

    var_5 = var_0._id_113E1 - gettime();

    if(var_5 > 0) {
      wait(float(var_5) / 1000.0);
    }

    var_4 = !var_4;
    var_0._id_113E1 = gettime() + 200;
  }

  _id_113E2(var_3);
}

_id_11406() {
  if(!isDefined(level._id_11414)) {
    level _id_11AE9();
    level._id_11414 = 1;
  }

  self._id_11400 = [];
  self._id_11400["enabled"] = 1;
  self._id_11400["marking_enabled"] = 1;
  self._id_11400["outline_enabled"] = 1;
  self._id_11400["tagging_mode"] = 0;
  self._id_11400["last_tag_start"] = 0;
  self._id_11400["action_slot"] = 4;
  self._id_11400["tagging_fade_min"] = 500.0;
  self._id_11400["tagging_fade_max"] = 3000.0;
}

_id_11AE9() {
  setdvarifuninitialized("tagging_ads_cone_range", 3000);
  setdvarifuninitialized("tagging_ads_cone_angle", 10.0);
  setdvarifuninitialized("tagging_normal_pulse_rate", 50);
  setdvarifuninitialized("tagging_normal_prep_time", 250);
  setdvarifuninitialized("tagging_normal_track_time", 500);
  setdvarifuninitialized("tagging_slow_pulse_rate", 100);
  setdvarifuninitialized("tagging_slow_prep_time", 500);
  setdvarifuninitialized("tagging_slow_track_time", 1000);
  setdvarifuninitialized("tagging_foliage", 0);
  setdvarifuninitialized("tagging_vehicle_ride", 0);
  scripts\sp\utility::_id_9189("tagging", -1, "default");
  setsaveddvar("r_hudoutlineEnable", 1);
}

_id_11405() {
  var_0 = [];
  var_0["r_hudoutlineFillColor0"] = "0.5 0.5 0.5 0";
  var_0["r_hudoutlineFillColor1"] = "0.5 0.5 0.5 0";
  var_0["r_hudoutlineOccludedOutlineColor"] = "0.5 0.5 0.5 1";
  var_0["r_hudoutlineOccludedInlineColor"] = "0.5 0.5 0.5 0.5";
  var_0["r_hudoutlineOccludedInteriorColor"] = "0.5 0.5 0.5 0.5";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_0;
}

_id_1140E() {
  self notify("tagging_shutdown");
  _id_1140B(0);

  if(isDefined(self._id_11400) && isDefined(self._id_11400["camera"])) {
    self._id_11400["camera"] delete();
  }

  self._id_11400 = undefined;
}

_id_11401() {
  var_0 = level._id_10E6D.enemies[self.team];
  var_1 = getEntArray("rss_static_robot", "script_noteworthy");
  var_2 = getaiarray(self.team);
  var_3 = scripts\engine\utility::array_combine(var_0, var_1);
  var_4 = scripts\engine\utility::array_combine(var_3, var_2);
  return var_4;
}

_id_1140D() {
  return isDefined(self._id_C337) && isDefined(self._id_C337.active) && self._id_C337.active;
}

_id_11412() {
  self notify("tagging_think");
  self endon("tagging_think");
  self endon("death");
  self endon("disconnect");

  while(isDefined(self) && isDefined(self._id_11400)) {
    if(!isDefined(self._id_11400["enabled"])) {
      return;
    }
    if(!isDefined(self._id_11400["outline_enabled"])) {
      return;
    }
    var_0 = self._id_11400["enabled"] && self._id_11400["outline_enabled"];

    if(var_0 && (scripts\sp\utility::_id_9D27() || _id_1140D())) {
      _id_113EC();
    }

    wait 0.05;
  }
}

_id_113EC() {
  var_0 = _id_11401();
  var_1 = self getEye();
  var_2 = anglesToForward(self getplayerangles());
  var_3 = undefined;
  var_4 = max(0.01, getdvarfloat("tagging_ads_cone_range"));
  var_5 = cos(getdvarfloat("tagging_ads_cone_angle"));
  var_6 = [0.0, 0.5, 1.0];

  if(_id_1140D()) {
    var_4 = level.player._id_11400["tagging_fade_max"];
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
    if(isDefined(var_9._id_113F3) && isDefined(var_9._id_113F3[self getentitynumber()])) {
      continue;
    }
    if(!getdvarint("tagging_vehicle_ride") && isDefined(var_9._id_13223) && var_9._id_13223.veh_speed > 0) {
      continue;
    }
    var_10 = isDefined(var_3) && var_3 == var_9;

    if(!var_10) {
      var_11 = var_9 gettagorigin("tag_origin");

      if(isai(var_9)) {
        var_11 = var_9 getEye();
      }

      var_12 = distance(var_11, var_1);

      if(var_12 <= var_4) {
        var_13 = min(1.0, var_5 + (1.0 - var_5) * (var_12 / var_4));

        foreach(var_15 in var_6) {
          var_16 = vectorlerp(var_9.origin, var_11, var_15);
          var_17 = var_16 - var_1;
          var_18 = vectorNormalize(var_17);
          var_19 = vectordot(var_18, var_2);

          if(var_19 > var_13) {
            if(_id_1140D()) {
              var_10 = 1;
              break;
            }

            if(_id_650A(var_9)) {
              var_10 = 1;
              break;
            }
          }
        }
      }
    }

    if(var_10) {
      var_9 _id_113EB("tracking", self, 1);
      continue;
    }

    var_9 _id_113EB("none", self, 0);
  }
}

_id_650C() {
  if(isDefined(self._id_11411)) {
    return;
  }
  if(!isDefined(self._id_1140F)) {
    self._id_1140F = 0;
  }

  if(!isDefined(level._id_11410)) {
    level._id_11410 = [];
    level thread _id_650B();
  }

  level._id_11410 = scripts\engine\utility::array_add(level._id_11410, self);
  self._id_11411 = 1;
}

_id_650B() {
  self notify("enemy_sight_trace_process");
  self endon("enemy_sight_trace_process");
  var_0 = 3;

  for(;;) {
    level._id_11410 = scripts\engine\utility::array_removeundefined(level._id_11410);

    for(var_1 = 0; var_1 < min(var_0, level._id_11410.size); var_1++) {
      var_2 = level._id_11410[0];
      level._id_11410 = scripts\engine\utility::array_remove(level._id_11410, var_2);
      var_2._id_1140F = _id_6509(var_2);
      var_2._id_11411 = undefined;
    }

    wait 0.05;
  }
}

_id_650A(var_0) {
  var_0 _id_650C();
  return var_0._id_1140F;
}

_id_6509(var_0) {
  var_1 = 0;
  var_2 = level.player getEye();

  if(!var_1 && var_0 scripts\sp\utility::hastag(var_0.model, "j_head")) {
    if(sighttracepassed(var_2, var_0 gettagorigin("j_head"), 0, var_0._id_101E1, var_0, 0)) {
      var_1 = 1;
    }
  }

  if(!var_1 && var_0 scripts\sp\utility::hastag(var_0.model, "j_spinelower")) {
    if(sighttracepassed(var_2, var_0 gettagorigin("j_spinelower"), 0, var_0._id_101E1, var_0, 0)) {
      var_1 = 1;
    }
  }

  if(!var_1 && var_0 scripts\sp\utility::hastag(var_0.model, "tag_attach")) {
    if(sighttracepassed(var_2, var_0 gettagorigin("tag_attach"), 0, var_0._id_101E1, var_0, 0)) {
      var_1 = 1;
    }
  }

  if(!var_1 && sighttracepassed(var_2, var_0.origin, 0, var_0._id_101E1, var_0, 0)) {
    var_1 = 1;
  }

  return var_1;
}

_id_113EB(var_0, var_1, var_2) {
  var_3 = gettime();

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_4 = getdvarint("tagging_normal_pulse_rate");
  var_5 = getdvarint("tagging_normal_prep_time");
  var_6 = getdvarint("tagging_normal_track_time");
  var_7 = 0;

  if(!var_1._id_11400["marking_enabled"]) {
    var_0 = "range";
  }

  switch (var_0) {
    case "view":
      var_7 = 1;
      self._id_113E9 = 0;
      self._id_113EA = undefined;
      break;
    case "range":
      self._id_113E9 = 0;
      self._id_113EA = undefined;
      break;
    case "tracking_slow":
      var_4 = getdvarint("tagging_slow_pulse_rate");
      var_5 = getdvarint("tagging_slow_prep_time");
      var_6 = getdvarint("tagging_slow_track_time");
    case "tracking":
      if(!isDefined(self._id_113EA)) {
        if((gettime() - var_1._id_11400["last_tag_start"]) / 1000 <= 0.25) {
          return;
        }
        self._id_113EA = var_3;
        var_1._id_11400["last_tag_start"] = var_3;
      }

      break;
    case "obstructed":
    case "none":
    default:
      _id_113E2(0);
      self._id_113EA = undefined;
      return;
  }

  var_8 = var_6 + var_5;
  var_9 = 0;

  if(isDefined(self._id_113EA)) {
    var_9 = var_3 - self._id_113EA;
  }

  if(var_9 >= var_8) {
    if(var_2) {
      var_1._id_113F4 = 1;
    }

    _id_113D9(var_1);
  }
}

_id_113E2(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }
  if(var_0) {
    _id_113FB(var_1);
    thread _id_113F7();
    thread _id_113F8();
  } else {
    _id_113FA();
    self notify("tagged_entity_update");
  }
}

_id_113F8() {
  self endon("death");
  self notify("tagged_entity_update");
  self endon("tagged_entity_update");

  for(;;) {
    if(!getdvarint("tagging_vehicle_ride") && isDefined(self._id_13223) && self._id_13223.veh_speed > 0) {
      _id_113E2(0);
      self notify("tagged_entity_death_cleanup");
      self._id_113F3 = undefined;
      return;
    }

    if(!isDefined(self._id_113F9)) {
      if(!isDefined(self._id_113FD)) {
        self._id_113FD = gettime();
      }

      var_0 = int((gettime() - self._id_113FD) / 100);

      if(var_0 % 2) {
        _id_113FA();
      } else {
        _id_113FB();
      }

      if(var_0 > 3) {
        _id_113FB();
        self._id_113F9 = 1;
      }
    }

    if(isDefined(self._id_FC9D)) {
      thread _id_113FE();
    }

    wait 0.05;
  }
}

_id_113FE() {
  self notify("tagged_wait_shield_off");
  self endon("tagged_wait_shield_off");
  self endon("death");
  self waittill("hudoutline_off");
  _id_113FB();
}

_id_113F5() {
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

_id_113FB(var_0) {
  if(!isDefined(self)) {
    return;
  }
  _id_113FA();
  var_1 = _id_113F5();
  scripts\sp\utility::_id_9196(var_1, 0, 1, "tagging");
  thread _id_113FC();
  self._id_11413 = 1;
}

_id_113FA() {
  if(!isDefined(self)) {
    return;
  }
  self notify("tagged_status_update");
  scripts\sp\utility::_id_9193("tagging");
  self._id_11413 = undefined;
}

_id_113FC() {
  self notify("tagged_status_update");
  self endon("tagged_status_update");
  self endon("death");

  while(isDefined(self) && (!issentient(self) || isalive(self))) {
    var_0 = level.player._id_11400["tagging_fade_max"];
    var_1 = var_0 * var_0;
    var_2 = lengthsquared(level.player.origin - self.origin);

    if(var_2 > var_1) {
      _id_113FA();
    } else {
      _id_113FB();
    }

    wait 0.05;
  }
}

_id_113F7() {
  if(isDefined(self._id_113F7)) {
    return;
  }
  self notify("tagged_entity_death_cleanup");
  self endon("tagged_entity_death_cleanup");
  self._id_113F7 = 1;
  self waittill("death", var_0, var_1);

  if(isPlayer(var_0)) {
    wait 0.1;

    if(isDefined(self) && distancesquared(self.origin, level.player.origin) > 90000) {
      var_2 = gettime();
      var_3 = 1;

      while(isDefined(self) && gettime() - var_2 < 1000) {
        if(var_3 == 0 && randomint(100) < 30) {
          _id_113E2(1);
          var_3 = 1;
        } else if(var_3 == 1) {
          _id_113E2(0);
          var_3 = 0;
        }

        wait 0.05;
      }
    }
  }

  if(isDefined(self)) {
    _id_113E2(0);
  }

  self._id_113F7 = undefined;
}