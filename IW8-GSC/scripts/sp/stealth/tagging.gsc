/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\stealth\tagging.gsc
***********************************************/

function tagging_player_thread() {
  if(!isDefined(self.tagging)) {
    tagging_player_init();
  }

  if(istrue(level.ship_assault)) {} else {
    thread tagging_think();
  }

  tagging_set_enabled(1);
}

function tagging_player_stop() {
  tagging_set_enabled(0);
  self notify("tagging_think");
}

function tagging_set_enabled(var0, var1) {
  if(!isDefined(self.tagging)) {
    tagging_player_init();
  }

  if(!isDefined(var1)) {
    var1 = 4;
  }

  self.tagging["enabled"] = var0;
  self.tagging["action_slot"] = var1;
  tagging_set_marking_enabled(var0);
}

function tagging_set_marking_enabled(var0) {
  if(!isDefined(self.tagging)) {
    tagging_player_init();
  }

  self.tagging["marking_enabled"] = var0;
  var1 = tagging_entity_list();
  jumpiftrue(self.tagging["marking_enabled"]) LOC_00000090;

  foreach(var3 in var1) {
    if(!isDefined(var3)) {
      continue;
    }

    if(issentient(var3) && !isalive(var3)) {
      continue;
    }

    tag_trace_update(var3, "none", self);
    var3 notify("tagged_entity_death_cleanup");
    tagged_status_hide(var3);
  }

  return;
}

function tag_entity(var0, var1) {
  if(!isDefined(level.tagginginit)) {
    tracking_init(level);
    level.tagginginit = 1;
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(!isDefined(self) || issentient(self) && !isalive(self)) {
    if(isDefined(self)) {
      tag_outline_entity(0);
    }

    return;
  }

  if(var1 && (!isDefined(self.tagged) || !isDefined(self.tagged[var0 getentitynumber()]) || !self.tagged[var0 getentitynumber()])) {
    var0 thread scripts\engine\sp\utility::play_sound_on_entity("drone_tag_success");
  }

  self.tagged[var0 getentitynumber()] = 1;
  tag_outline_entity(1);
  self.tag_trace_state = undefined;
  self.tag_trace_pulse = undefined;
  self.tag_trace_track = undefined;
  tagged_status_show();
}

function tag_flash_entity(var0, var1) {
  if(isDefined(self.tag_flashing) && self.tag_flashing == var1) {
    return;
  }

  self.tag_flashing = var1;
  self notify("tag_flash_entity");
  self endon("tag_flash_entity");
  self endon("death");
  var0 endon("death");
  var0 endon("disconnect");

  if(!isDefined(self) || issentient(self) && !isalive(self)) {
    if(isDefined(self)) {
      tag_outline_entity(0);
    }

    return;
  }

  var2 = var0 getentitynumber();

  if(!isDefined(var0.tag_next_flash)) {
    var0.tag_next_flash = 0;
  }

  var3 = isDefined(self.tagged) && istrue(self.tagged[var2]);
  var4 = 1;

  while(var1 && getdvarint("OKQTSOMTKT", 1)) {
    self.tagged_flickered = 1;

    if(var4) {
      tag_outline_entity(1, "dead");
    } else {
      tag_outline_entity(var3);
    }

    var5 = var0.tag_next_flash - gettime();

    if(var5 > 0) {
      wait float(var5) / 1000;
    }

    var4 = !var4;
    var0.tag_next_flash = gettime() + 200;
    var3 = isDefined(self.tagged) && istrue(self.tagged[var2]);
  }

  tag_outline_entity(var3);
}

function tagging_player_init() {
  if(!isDefined(level.tagginginit)) {
    tracking_init(level);
    level.tagginginit = 1;
  }

  self.tagging = [];
  self.tagging["enabled"] = undefined;
  self.tagging["marking_enabled"] = 1;
  self.tagging["outline_enabled"] = 1;
  self.tagging["tagging_mode"] = 0;
  self.tagging["last_tag_start"] = 0;
  self.tagging["action_slot"] = 4;
  self.tagging["tagging_fade_min"] = 500;
  self.tagging["tagging_fade_max"] = 3000;
}

function tracking_init() {
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
  scripts\engine\sp\utility::hudoutline_add_channel("tagging", -1, &tagging_hudoutline_settings);
  thread lerp_hudoutline_occlusion();
  setsaveddvar("NMROQRRONQ", 1);
}

function tagging_hudoutline_settings() {
  var0 = [];
  GscBinSkip0(0x2e, "LRMPROLMKN", "0.5 0.5 0.5 0");
}

function lerp_hudoutline_occlusion() {
  var0 = 0;
  var1 = 0.05;
  var2 = "0.5 0.5 0.5";
  var3 = 1;
  var4 = 0;

  for(;;) {
    for(var5 = 1; var5 < 11; var5++) {
      if(isDefined(level.hudoutlinecurchannel) && level.hudoutlinecurchannel == "tagging") {
        setsaveddvar("NSNOLMTLLL", var2 + var0 + "");
        setsaveddvar("LSRTPRNOLS", var2 + var0 + "");
        setsaveddvar("LNNOSQKRTP", var2 + var0 + "");

        if(var3) {
          var0 = scripts\engine\utility::ter_op(var5 == 10, 0.9, var0 + 0.1);
        } else {
          var0 = scripts\engine\utility::ter_op(var5 == 10, 0, var0 - 0.1);
        }

        wait var1;
      }
    }

    var4++;

    if(var4 == 2) {
      level notify("tagging_cycle");
      wait 2;
      var4 = 0;
    } else {
      wait 0.05;
    }

    if(var3) {
      var3 = 0;
      continue;
    }

    var3 = 1;
  }
}

function tagging_shutdown_player() {
  self notify("tagging_shutdown");
  tagging_set_enabled(0);

  if(isDefined(self.tagging) && isDefined(self.tagging["camera"])) {
    self.tagging["camera"] delete();
  }

  self.tagging = undefined;
}

function tagging_entity_list() {
  var0 = level.stealth.enemies[self.team];
  var1 = getEntArray("rss_static_robot", "script_noteworthy");
  var2 = getaiarray(self.team);
  var3 = scripts\engine\utility::array_combine(var0, var1);
  var4 = scripts\engine\utility::array_combine(var3, var2);
  return var4;
}

function tagging_think() {
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

    var0 = self.tagging["enabled"] && self.tagging["outline_enabled"] && !level.player islinked();

    if(var0 && scripts\engine\sp\utility::isads()) {
      tag_update_enemy_in_sights();
    }

    wait 0.05;
  }
}

function tag_update_enemy_in_sights() {
  var0 = tagging_entity_list();
  var1 = self getEye();
  var2 = anglesToForward(self getplayerangles());
  var3 = undefined;
  var4 = max(0.01, getdvarfloat("tagging_ads_cone_range"));
  var5 = cos(getdvarfloat("tagging_ads_cone_angle"));
  var6 = [0, 0.5, 1];

  if(scripts\stealth\utility::tagging_shield()) {
    var4 = level.player.tagging["tagging_fade_max"];
    var5 = cos(getdvarfloat("QTSPTNLOL"));
  }

  var7 = scripts\engine\trace::_bullet_trace(var1, var1 + var2 * 32000, 1, self);
  var3 = var7["entity"];

  foreach(var9 in var0) {
    if(!isDefined(var9)) {
      continue;
    }

    if(issentient(var9) && !isalive(var9)) {
      continue;
    }

    if(isDefined(var9.tagged) && isDefined(var9.tagged[self getentitynumber()])) {
      continue;
    }

    if(!getdvarint("tagging_vehicle_ride") && isDefined(var9.vehicle_ride) && var9.vehicle_ride.veh_speed > 0) {
      continue;
    }

    var10 = isDefined(var3) && var3 == var9;

    if(!var10) {
      var11 = var9 gettagorigin("tag_origin");

      if(isai(var9)) {
        var11 = var9 getEye();
      }

      var12 = distance(var11, var1);

      if(var12 <= var4) {
        var13 = min(1, var5 + (1 - var5) * var12 / var4);

        foreach(var15 in var6) {
          var16 = vectorlerp(var9.origin, var11, var15);
          var17 = var16 - var1;
          var18 = vectorNormalize(var17);
          var19 = vectordot(var18, var2);

          if(var19 > var13) {
            if(enemy_sight_trace_passed(var9)) {
              var10 = 1;
              break;
            }
          }
        }
      }
    }

    if(var10) {
      tag_trace_update(var9, "tracking", self, 1);
      continue;
    }

    tag_trace_update(var9, "none", self, 0);
  }
}

function enemy_sight_trace_request() {
  if(isDefined(self.tagging_sight_traced_queued)) {
    return;
  }

  if(!isDefined(self.tagging_sight_trace_passed)) {
    self.tagging_sight_trace_passed = 0;
  }

  if(!isDefined(level.tagging_sight_trace_queue)) {
    level.tagging_sight_trace_queue = [];
    thread enemy_sight_trace_process();
  }

  level.tagging_sight_trace_queue = scripts\engine\utility::array_add(level.tagging_sight_trace_queue, self);
  self.tagging_sight_traced_queued = 1;
}

function enemy_sight_trace_process() {
  self notify("enemy_sight_trace_process");
  self endon("enemy_sight_trace_process");
  var0 = 3;

  for(;;) {
    level.tagging_sight_trace_queue = scripts\engine\utility::array_removeundefined(level.tagging_sight_trace_queue);

    for(var1 = 0; var1 < min(var0, level.tagging_sight_trace_queue.size); var1++) {
      var2 = level.tagging_sight_trace_queue[0];
      level.tagging_sight_trace_queue = scripts\engine\utility::array_remove(level.tagging_sight_trace_queue, var2);
      var2.tagging_sight_trace_passed = enemy_sight_trace(var2);
      var2.tagging_sight_traced_queued = undefined;
    }

    wait 0.05;
  }
}

function enemy_sight_trace_passed(var0) {
  enemy_sight_trace_request(var0);
  return var0.tagging_sight_trace_passed;
}

function enemy_sight_trace(var0) {
  var1 = 0;
  var2 = level.player getEye();

  if(!var1 && var0 scripts\engine\utility::hastag(var0.model, "j_head")) {
    if(sighttracepassed(var2, var0 gettagorigin("j_head"), 0, var0.sight_ignore, var0, 0)) {
      var1 = 1;
    }
  }

  if(!var1 && var0 scripts\engine\utility::hastag(var0.model, "j_spinelower")) {
    if(sighttracepassed(var2, var0 gettagorigin("j_spinelower"), 0, var0.sight_ignore, var0, 0)) {
      var1 = 1;
    }
  }

  if(!var1 && var0 scripts\engine\utility::hastag(var0.model, "tag_attach")) {
    if(sighttracepassed(var2, var0 gettagorigin("tag_attach"), 0, var0.sight_ignore, var0, 0)) {
      var1 = 1;
    }
  }

  if(!var1 && sighttracepassed(var2, var0.origin, 0, var0.sight_ignore, var0, 0)) {
    var1 = 1;
  }

  return var1;
}

function tag_trace_update(var0, var1, var2) {
  var3 = gettime();

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var4 = getdvarint("tagging_normal_pulse_rate");
  var5 = getdvarint("tagging_normal_prep_time");
  var6 = getdvarint("tagging_normal_track_time");
  var7 = 0;

  if(!var1.tagging["marking_enabled"]) {
    var0 = "range";
  }

  switch (var0) {
    case "view":
      var7 = 1;
      self.tag_trace_state = 0;
      self.tag_trace_track = undefined;
      break;
    case "range":
      self.tag_trace_state = 0;
      self.tag_trace_track = undefined;
      break;
    case "tracking_slow":
      var4 = getdvarint("tagging_slow_pulse_rate");
      var5 = getdvarint("tagging_slow_prep_time");
      var6 = getdvarint("tagging_slow_track_time");
    case "tracking":
      if(!isDefined(self.tag_trace_track)) {
        if((gettime() - var1.tagging["last_tag_start"]) / 1000 <= 0.25) {
          return;
        }

        self.tag_trace_track = var3;
        var1.tagging["last_tag_start"] = var3;
      }

      break;
    case "obstructed":
    case "none":
    default:
      tag_outline_entity(0);
      self.tag_trace_track = undefined;
      return;
  }

  var8 = var6 + var5;
  var9 = 0;

  if(isDefined(self.tag_trace_track)) {
    var9 = var3 - self.tag_trace_track;
  }

  if(var9 >= var8) {
    if(var2) {
      var1.tagged_ads = 1;
    }

    tag_entity(var1);
    return;
  }
}

function tag_outline_entity(var0, var1) {
  if(!isDefined(self)) {
    return;
  }

  if(var0) {
    tagged_status_show(var1);
    thread tagged_entity_death_cleanup();
    thread tagged_entity_update();
    return;
  }

  tagged_status_hide();
  self notify("tagged_entity_update");
}

function tagged_entity_update() {
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
      if(!isDefined(self.tagged_time)) {
        self.tagged_time = gettime();
      }

      var0 = int((gettime() - self.tagged_time) / 100);

      if(var0 % 2) {
        tagged_status_hide();
      } else {
        tagged_status_show();
      }

      if(var0 > 3) {
        tagged_status_show();
        self.tagged_flickered = 1;
      }
    }

    if(isDefined(self.shieldhudoutline)) {
      thread tagged_wait_shield_off();
    }

    wait 0.05;
  }
}

function tagged_wait_shield_off() {
  self notify("tagged_wait_shield_off");
  self endon("tagged_wait_shield_off");
  self endon("death");
  self waittill("hudoutline_off");
  tagged_status_show();
}

function tagged_hudoutline() {
  GscBinSkip1(0x45, "allies", "outlinefill_nodepth_cyan");
}

function tagged_status_show(var0) {
  if(!isDefined(self)) {
    return;
  }

  tagged_status_hide();
  var1 = tagged_hudoutline();
  scripts\engine\sp\utility::hudoutline_enable_new(var1, "tagging");
  thread tagged_status_update();
  self.tagging_visible = 1;
}

function _create_tagging_highlight(var0) {
  if(isDefined(self.highlight_ent)) {
    return;
  }

  if(isDefined(self.model) && scripts\engine\utility::hastag(self.model, "j_mainroot")) {
    self.highlight_ent = scripts\engine\utility::spawn_script_origin(self gettagorigin("tag_eye") + (0, 0, 20), self.angles);
    self.highlight_ent linkTo(self, "tag_origin");
    var1 = 3000;
    self.highlight_ent setCursorHint("hint_button");
    self.highlight_ent sethintdisplayrange(var1);
    self.highlight_ent setuserange(1);
    self.highlight_ent sethintonobstruction("show");
    self.highlight_ent makeusable();
    thread _remove_tagging_highlight_on_death();
    return;
  }
}

function tagging_highlight_dist_fade(var0) {
  self endon("death");
  var1 = squared(var0 / 2);

  for(;;) {
    while(distance2dsquared(self.origin, level.player.origin) > var1) {
      wait 0.1;
    }

    self.highlight_ent sethintdisplayrange(0);

    while(distance2dsquared(self.origin, level.player.origin) < var1) {
      wait 0.1;
    }

    self.highlight_ent sethintdisplayrange(var0);
  }
}

function _remove_tagging_highlight_on_death() {
  var0 = self.highlight_ent;
  scripts\engine\utility::waittill_any("death", "tagging_remove_highlight");

  if(isDefined(var0)) {
    if(target_istarget(var0)) {
      target_remove(var0);
    }

    var0 delete();
  }

  if(isDefined(self)) {
    self.highlight_ent = undefined;
    return;
  }
}

function _end_tagging_highlighting() {
  level notify("end_tagging_highlighting");

  foreach(var1 in getaiarray("axis", "allies")) {
    var1 notify("tagging_remove_highlight");
  }
}

function tagged_status_hide() {
  if(!isDefined(self)) {
    return;
  }

  self notify("tagged_status_update");
  scripts\engine\sp\utility::hudoutline_disable("tagging");
  self.tagging_visible = undefined;
}

function tagged_status_update() {
  self notify("tagged_status_update");
  self endon("tagged_status_update");
  self endon("death");

  while(isDefined(self) && (!issentient(self) || isalive(self))) {
    var0 = level.player.tagging["tagging_fade_max"];
    var1 = var0 * var0;
    var2 = lengthsquared(level.player.origin - self.origin);

    if(var2 > var1) {
      tagged_status_hide();
    } else {
      tagged_status_show();
    }

    wait 0.05;
  }
}

function tagged_entity_death_cleanup() {
  if(isDefined(self.tagged_entity_death_cleanup)) {
    return;
  }

  self notify("tagged_entity_death_cleanup");
  self endon("tagged_entity_death_cleanup");
  self.tagged_entity_death_cleanup = 1;
  self waittill("death", var0, var1);

  if(isPlayer(var0)) {
    wait 0.1;

    if(isDefined(self) && distancesquared(self.origin, level.player.origin) > 90000) {
      var2 = gettime();
      var3 = 1;

      while(isDefined(self) && gettime() - var2 < 1000) {
        if(var3 == 0 && randomint(100) < 30) {
          tag_outline_entity(1);
          var3 = 1;
        } else if(var3 == 1) {
          tag_outline_entity(0);
          var3 = 0;
        }

        wait 0.05;
      }
    }
  }

  if(isDefined(self)) {
    tag_outline_entity(0);
  }

  self.tagged_entity_death_cleanup = undefined;
}