/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\stealth\tagging.gsc
***********************************************/

tagging_player_thread() {
  if(!isDefined(self.tagging))
    tagging_player_init();

  if(istrue(level.ship_assault)) {} else
    thread tagging_think();

  tagging_set_enabled(1);
}

tagging_player_stop() {
  tagging_set_enabled(0);
  self notify("tagging_think");
}

tagging_set_enabled(var_0, var_1) {
  if(!isDefined(self.tagging))
    tagging_player_init();

  if(!isDefined(var_1))
    var_1 = 4;

  self.tagging["enabled"] = var_0;
  self.tagging["action_slot"] = var_1;
  tagging_set_marking_enabled(var_0);
}

tagging_set_marking_enabled(var_0) {
  if(!isDefined(self.tagging))
    tagging_player_init();

  self.tagging["marking_enabled"] = var_0;
  var_1 = tagging_entity_list();

  if(!self.tagging["marking_enabled"]) {
    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(issentient(var_3) && !isalive(var_3)) {
        continue;
      }
      var_3 tag_trace_update("none", self);
      var_3 notify("tagged_entity_death_cleanup");
      var_3 tagged_status_hide();
    }
  } else {
    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }
      if(issentient(var_3) && !isalive(var_3)) {
        continue;
      }
      if(isDefined(var_3.tagged) && isDefined(var_3.tagged[self getentitynumber()]))
        var_3 tag_entity(self);
    }
  }
}

tag_entity(var_0, var_1) {
  if(!isDefined(level.tagginginit)) {
    level tracking_init();
    level.tagginginit = 1;
  }

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(self) || issentient(self) && !isalive(self)) {
    if(isDefined(self))
      tag_outline_entity(0);

    return;
  }

  if(var_1 && (!isDefined(self.tagged) || !isDefined(self.tagged[var_0 getentitynumber()]) || !self.tagged[var_0 getentitynumber()]))
    var_0 thread scripts\engine\sp\utility::play_sound_on_entity("drone_tag_success");

  self.tagged[var_0 getentitynumber()] = 1;
  tag_outline_entity(1);
  self.tag_trace_state = undefined;
  self.tag_trace_pulse = undefined;
  self.tag_trace_track = undefined;
  tagged_status_show();
}

tag_flash_entity(var_0, var_1) {
  if(isDefined(self.tag_flashing) && self.tag_flashing == var_1) {
    return;
  }
  self.tag_flashing = var_1;
  self notify("tag_flash_entity");
  self endon("tag_flash_entity");
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!isDefined(self) || issentient(self) && !isalive(self)) {
    if(isDefined(self))
      tag_outline_entity(0);

    return;
  }

  var_2 = var_0 getentitynumber();

  if(!isDefined(var_0.tag_next_flash))
    var_0.tag_next_flash = 0;

  var_3 = isDefined(self.tagged) && istrue(self.tagged[var_2]);

  for(var_4 = 1; var_1 && getdvarint("OKQTSOMTKT", 1); var_3 = isDefined(self.tagged) && istrue(self.tagged[var_2])) {
    self.tagged_flickered = 1;

    if(var_4)
      tag_outline_entity(1, "dead");
    else
      tag_outline_entity(var_3);

    var_5 = var_0.tag_next_flash - gettime();

    if(var_5 > 0)
      wait(float(var_5) / 1000.0);

    var_4 = !var_4;
    var_0.tag_next_flash = gettime() + 200;
  }

  tag_outline_entity(var_3);
}

tagging_player_init() {
  if(!isDefined(level.tagginginit)) {
    level tracking_init();
    level.tagginginit = 1;
  }

  self.tagging = [];
  self.tagging["enabled"] = undefined;
  self.tagging["marking_enabled"] = 1;
  self.tagging["outline_enabled"] = 1;
  self.tagging["tagging_mode"] = 0;
  self.tagging["last_tag_start"] = 0;
  self.tagging["action_slot"] = 4;
  self.tagging["tagging_fade_min"] = 500.0;
  self.tagging["tagging_fade_max"] = 3000.0;
}

tracking_init() {
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
  scripts\engine\sp\utility::hudoutline_add_channel("tagging", -1, ::tagging_hudoutline_settings);
  thread lerp_hudoutline_occlusion();
  setsaveddvar("NMROQRRONQ", 1);
}

tagging_hudoutline_settings() {
  var_0 = [];
  var_0["LRMPROLMKN"] = "0.5 0.5 0.5 0";
  var_0["NTOSKSTKQQ"] = "0.5 0.5 0.5 0";
  var_0["NSNOLMTLLL"] = "0.5 0.5 0.5 0";
  var_0["LSRTPRNOLS"] = "0.5 0.5 0.5 0";
  var_0["LNNOSQKRTP"] = "0.5 0.5 0.5 0";
  var_0["RKSQOKQNK"] = 1;
  return var_0;
}

lerp_hudoutline_occlusion() {
  var_0 = 0;
  var_1 = 0.05;
  var_2 = "0.5 0.5 0.5";
  var_3 = 1;
  var_4 = 0;

  for(;;) {
    for(var_5 = 1; var_5 < 11; var_5++) {
      if(isDefined(level.hudoutlinecurchannel) && level.hudoutlinecurchannel == "tagging") {
        setsaveddvar("NSNOLMTLLL", var_2 + var_0 + "");
        setsaveddvar("LSRTPRNOLS", var_2 + var_0 + "");
        setsaveddvar("LNNOSQKRTP", var_2 + var_0 + "");

        if(var_3)
          var_0 = scripts\engine\utility::ter_op(var_5 == 10, 0.9, var_0 + 0.1);
        else
          var_0 = scripts\engine\utility::ter_op(var_5 == 10, 0, var_0 - 0.1);

        wait(var_1);
      }
    }

    var_4++;

    if(var_4 == 2) {
      level notify("tagging_cycle");
      wait 2;
      var_4 = 0;
    } else
      wait 0.05;

    if(var_3) {
      var_3 = 0;
      continue;
    }

    var_3 = 1;
  }
}

tagging_shutdown_player() {
  self notify("tagging_shutdown");
  tagging_set_enabled(0);

  if(isDefined(self.tagging) && isDefined(self.tagging["camera"]))
    self.tagging["camera"] delete();

  self.tagging = undefined;
}

tagging_entity_list() {
  var_0 = level.stealth.enemies[self.team];
  var_1 = getEntArray("rss_static_robot", "script_noteworthy");
  var_2 = getaiarray(self.team);
  var_3 = scripts\engine\utility::array_combine(var_0, var_1);
  var_4 = scripts\engine\utility::array_combine(var_3, var_2);
  return var_4;
}

tagging_think() {
  self notify("tagging_think");
  self endon("tagging_think");
  self endon("death");
  self endon("disconnect");

  while(isDefined(self) && isDefined(self.tagging)) {
    if(!isDefined(self.tagging["enabled"])) {
      return;
    }
    if(!isDefined(self.tagging["outline_enabled"])) {
      return;
    }
    var_0 = self.tagging["enabled"] && self.tagging["outline_enabled"] && !level.player islinked();

    if(var_0 && scripts\engine\sp\utility::isads())
      tag_update_enemy_in_sights();

    wait 0.05;
  }
}

tag_update_enemy_in_sights() {
  var_0 = tagging_entity_list();
  var_1 = self getEye();
  var_2 = anglesToForward(self getplayerangles());
  var_3 = undefined;
  var_4 = max(0.01, getdvarfloat("tagging_ads_cone_range"));
  var_5 = cos(getdvarfloat("tagging_ads_cone_angle"));
  var_6 = [0.0, 0.5, 1.0];

  if(scripts\stealth\utility::tagging_shield()) {
    var_4 = level.player.tagging["tagging_fade_max"];
    var_5 = cos(getdvarfloat("QTSPTNLOL"));
  }

  var_7 = scripts\engine\trace::_bullet_trace(var_1, var_1 + var_2 * 32000, 1, self);
  var_3 = var_7["entity"];

  foreach(var_9 in var_0) {
    if(!isDefined(var_9)) {
      continue;
    }
    if(issentient(var_9) && !isalive(var_9)) {
      continue;
    }
    if(isDefined(var_9.tagged) && isDefined(var_9.tagged[self getentitynumber()])) {
      continue;
    }
    if(!getdvarint("tagging_vehicle_ride") && isDefined(var_9.vehicle_ride) && var_9.vehicle_ride.veh_speed > 0) {
      continue;
    }
    var_10 = isDefined(var_3) && var_3 == var_9;

    if(!var_10) {
      var_11 = var_9 gettagorigin("tag_origin");

      if(isai(var_9))
        var_11 = var_9 getEye();

      var_12 = distance(var_11, var_1);

      if(var_12 <= var_4) {
        var_13 = min(1.0, var_5 + (1.0 - var_5) * (var_12 / var_4));

        foreach(var_15 in var_6) {
          var_16 = vectorlerp(var_9.origin, var_11, var_15);
          var_17 = var_16 - var_1;
          var_18 = vectorNormalize(var_17);
          var_19 = vectordot(var_18, var_2);

          if(var_19 > var_13) {
            if(enemy_sight_trace_passed(var_9)) {
              var_10 = 1;
              break;
            }
          }
        }
      }
    }

    if(var_10) {
      var_9 tag_trace_update("tracking", self, 1);
      continue;
    }

    var_9 tag_trace_update("none", self, 0);
  }
}

enemy_sight_trace_request() {
  if(isDefined(self.tagging_sight_traced_queued)) {
    return;
  }
  if(!isDefined(self.tagging_sight_trace_passed))
    self.tagging_sight_trace_passed = 0;

  if(!isDefined(level.tagging_sight_trace_queue)) {
    level.tagging_sight_trace_queue = [];
    level thread enemy_sight_trace_process();
  }

  level.tagging_sight_trace_queue = scripts\engine\utility::array_add(level.tagging_sight_trace_queue, self);
  self.tagging_sight_traced_queued = 1;
}

enemy_sight_trace_process() {
  self notify("enemy_sight_trace_process");
  self endon("enemy_sight_trace_process");
  var_0 = 3;

  for(;;) {
    level.tagging_sight_trace_queue = scripts\engine\utility::array_removeundefined(level.tagging_sight_trace_queue);

    for(var_1 = 0; var_1 < min(var_0, level.tagging_sight_trace_queue.size); var_1++) {
      var_2 = level.tagging_sight_trace_queue[0];
      level.tagging_sight_trace_queue = scripts\engine\utility::array_remove(level.tagging_sight_trace_queue, var_2);
      var_2.tagging_sight_trace_passed = enemy_sight_trace(var_2);
      var_2.tagging_sight_traced_queued = undefined;
    }

    wait 0.05;
  }
}

enemy_sight_trace_passed(var_0) {
  var_0 enemy_sight_trace_request();
  return var_0.tagging_sight_trace_passed;
}

enemy_sight_trace(var_0) {
  var_1 = 0;
  var_2 = level.player getEye();

  if(!var_1 && var_0 scripts\engine\utility::hastag(var_0.model, "j_head")) {
    if(sighttracepassed(var_2, var_0 gettagorigin("j_head"), 0, var_0.sight_ignore, var_0, 0))
      var_1 = 1;
  }

  if(!var_1 && var_0 scripts\engine\utility::hastag(var_0.model, "j_spinelower")) {
    if(sighttracepassed(var_2, var_0 gettagorigin("j_spinelower"), 0, var_0.sight_ignore, var_0, 0))
      var_1 = 1;
  }

  if(!var_1 && var_0 scripts\engine\utility::hastag(var_0.model, "tag_attach")) {
    if(sighttracepassed(var_2, var_0 gettagorigin("tag_attach"), 0, var_0.sight_ignore, var_0, 0))
      var_1 = 1;
  }

  if(!var_1 && sighttracepassed(var_2, var_0.origin, 0, var_0.sight_ignore, var_0, 0))
    var_1 = 1;

  return var_1;
}

tag_trace_update(var_0, var_1, var_2) {
  var_3 = gettime();

  if(!isDefined(var_2))
    var_2 = 0;

  var_4 = getdvarint("tagging_normal_pulse_rate");
  var_5 = getdvarint("tagging_normal_prep_time");
  var_6 = getdvarint("tagging_normal_track_time");
  var_7 = 0;

  if(!var_1.tagging["marking_enabled"])
    var_0 = "range";

  switch (var_0) {
    case "view":
      var_7 = 1;
      self.tag_trace_state = 0;
      self.tag_trace_track = undefined;
      break;
    case "range":
      self.tag_trace_state = 0;
      self.tag_trace_track = undefined;
      break;
    case "tracking_slow":
      var_4 = getdvarint("tagging_slow_pulse_rate");
      var_5 = getdvarint("tagging_slow_prep_time");
      var_6 = getdvarint("tagging_slow_track_time");
    case "tracking":
      if(!isDefined(self.tag_trace_track)) {
        if((gettime() - var_1.tagging["last_tag_start"]) / 1000 <= 0.25) {
          return;
        }
        self.tag_trace_track = var_3;
        var_1.tagging["last_tag_start"] = var_3;
      }

      break;
    case "obstructed":
    case "none":
    default:
      tag_outline_entity(0);
      self.tag_trace_track = undefined;
      return;
  }

  var_8 = var_6 + var_5;
  var_9 = 0;

  if(isDefined(self.tag_trace_track))
    var_9 = var_3 - self.tag_trace_track;

  if(var_9 >= var_8) {
    if(var_2)
      var_1.tagged_ads = 1;

    tag_entity(var_1);
  }
}

tag_outline_entity(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }
  if(var_0) {
    tagged_status_show(var_1);
    thread tagged_entity_death_cleanup();
    thread tagged_entity_update();
  } else {
    tagged_status_hide();
    self notify("tagged_entity_update");
  }
}

tagged_entity_update() {
  self endon("death");
  self notify("tagged_entity_update");
  self endon("tagged_entity_update");

  for(;;) {
    if(!getdvarint("tagging_vehicle_ride") && isDefined(self.vehicle_ride) && self.vehicle_ride.veh_speed > 0) {
      tag_outline_entity(0);
      self notify("tagged_entity_death_cleanup");
      self.tagged = undefined;
      return;
    }

    if(!isDefined(self.tagged_flickered)) {
      if(!isDefined(self.tagged_time))
        self.tagged_time = gettime();

      var_0 = int((gettime() - self.tagged_time) / 100);

      if(var_0 % 2)
        tagged_status_hide();
      else
        tagged_status_show();

      if(var_0 > 3) {
        tagged_status_show();
        self.tagged_flickered = 1;
      }
    }

    if(isDefined(self.shieldhudoutline))
      thread tagged_wait_shield_off();

    wait 0.05;
  }
}

tagged_wait_shield_off() {
  self notify("tagged_wait_shield_off");
  self endon("tagged_wait_shield_off");
  self endon("death");
  self waittill("hudoutline_off");
  tagged_status_show();
}

tagged_hudoutline() {
  var_0["allies"] = "outlinefill_nodepth_cyan";
  var_0["axis"] = "outlinefill_nodepth_red";
  var_0["team3"] = "outlinefill_nodepth_white";
  var_0["dead"] = "outlinefill_nodepth_white";
  var_1 = "dead";

  if(isDefined(self.team))
    var_1 = self.team;

  return var_0[var_1];
}

tagged_status_show(var_0) {
  if(!isDefined(self)) {
    return;
  }
  tagged_status_hide();
  var_1 = tagged_hudoutline();
  scripts\engine\sp\utility::hudoutline_enable_new(var_1, "tagging");
  thread tagged_status_update();
  self.tagging_visible = 1;
}

_create_tagging_highlight(var_0) {
  if(isDefined(self.highlight_ent)) {
    return;
  }
  if(isDefined(self.model) && scripts\engine\utility::hastag(self.model, "j_mainroot")) {
    self.highlight_ent = scripts\engine\utility::spawn_script_origin(self gettagorigin("tag_eye") + (0, 0, 20), self.angles);
    self.highlight_ent linkTo(self, "tag_origin");
    var_1 = 3000;
    self.highlight_ent setCursorHint("hint_button");
    self.highlight_ent sethintdisplayrange(var_1);
    self.highlight_ent setuserange(1);
    self.highlight_ent sethintonobstruction("show");
    self.highlight_ent makeusable();
    thread _remove_tagging_highlight_on_death();
  }
}

tagging_highlight_dist_fade(var_0) {
  self endon("death");
  var_1 = squared(var_0 / 2);

  for(;;) {
    while(distance2dsquared(self.origin, level.player.origin) > var_1)
      wait 0.1;

    self.highlight_ent sethintdisplayrange(0);

    while(distance2dsquared(self.origin, level.player.origin) < var_1)
      wait 0.1;

    self.highlight_ent sethintdisplayrange(var_0);
  }
}

_remove_tagging_highlight_on_death() {
  var_0 = self.highlight_ent;
  scripts\engine\utility::waittill_any("death", "tagging_remove_highlight");

  if(isDefined(var_0)) {
    if(target_istarget(var_0))
      target_remove(var_0);

    var_0 delete();
  }

  if(isDefined(self))
    self.highlight_ent = undefined;
}

_end_tagging_highlighting() {
  level notify("end_tagging_highlighting");

  foreach(var_1 in getaiarray("axis", "allies"))
  var_1 notify("tagging_remove_highlight");
}

tagged_status_hide() {
  if(!isDefined(self)) {
    return;
  }
  self notify("tagged_status_update");
  scripts\engine\sp\utility::hudoutline_disable("tagging");
  self.tagging_visible = undefined;
}

tagged_status_update() {
  self notify("tagged_status_update");
  self endon("tagged_status_update");
  self endon("death");

  while(isDefined(self) && (!issentient(self) || isalive(self))) {
    var_0 = level.player.tagging["tagging_fade_max"];
    var_1 = var_0 * var_0;
    var_2 = lengthsquared(level.player.origin - self.origin);

    if(var_2 > var_1)
      tagged_status_hide();
    else
      tagged_status_show();

    wait 0.05;
  }
}

tagged_entity_death_cleanup() {
  if(isDefined(self.tagged_entity_death_cleanup)) {
    return;
  }
  self notify("tagged_entity_death_cleanup");
  self endon("tagged_entity_death_cleanup");
  self.tagged_entity_death_cleanup = 1;
  self waittill("death", var_0, var_1);

  if(isPlayer(var_0)) {
    wait 0.1;

    if(isDefined(self) && distancesquared(self.origin, level.player.origin) > 90000) {
      var_2 = gettime();
      var_3 = 1;

      while(isDefined(self) && gettime() - var_2 < 1000) {
        if(var_3 == 0 && randomint(100) < 30) {
          tag_outline_entity(1);
          var_3 = 1;
        } else if(var_3 == 1) {
          tag_outline_entity(0);
          var_3 = 0;
        }

        wait 0.05;
      }
    }
  }

  if(isDefined(self))
    tag_outline_entity(0);

  self.tagged_entity_death_cleanup = undefined;
}