/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\stealth\tagging.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\utility;
#using scripts\stealth\utility;
#namespace tagging;

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

function tagging_set_enabled(enabled, action_slot) {
  if(!isDefined(self.tagging)) {
    tagging_player_init();
  }

  if(!isDefined(action_slot)) {
    action_slot = 4;
  }

  self.tagging["enabled"] = enabled;
  self.tagging["action_slot"] = action_slot;
  tagging_set_marking_enabled(enabled);
}

function tagging_set_marking_enabled(enabled) {
  if(!isDefined(self.tagging)) {
    tagging_player_init();
  }

  self.tagging["marking_enabled"] = enabled;
  entitylist = tagging_entity_list();

  if(!self.tagging["marking_enabled"]) {
    foreach(entity in entitylist) {
      if(!isDefined(entity)) {
        continue;
      }

      if(issentient(entity) && !isalive(entity)) {
        continue;
      }

      entity tag_trace_update("none", self);
      entity notify("tagged_entity_death_cleanup");
      entity tagged_status_hide();
    }

    return;
  }

  foreach(entity in entitylist) {
    if(!isDefined(entity)) {
      continue;
    }

    if(issentient(entity) && !isalive(entity)) {
      continue;
    }

    if(isDefined(entity.tagged) && isDefined(entity.tagged[self getentitynumber()])) {
      entity tag_entity(self);
    }
  }
}

function tag_entity(player, var_47eb02bf85de33e5) {
  if(!isDefined(self) || !isDefined(self.model)) {
    assertmsg("<dev string:x1c>");
  }

  if(!isDefined(level.tagginginit)) {
    level tracking_init();
    level.tagginginit = 1;
  }

  if(!isDefined(var_47eb02bf85de33e5)) {
    var_47eb02bf85de33e5 = 1;
  }

  if(!isDefined(self) || issentient(self) && !isalive(self)) {
    if(isDefined(self)) {
      tag_outline_entity(0);
    }

    return;
  }

  if(var_47eb02bf85de33e5 && (!isDefined(self.tagged) || !isDefined(self.tagged[player getentitynumber()]) || !self.tagged[player getentitynumber()])) {
    player thread play_sound_on_entity("drone_tag_success");
  }

  self.tagged[player getentitynumber()] = 1;
  tag_outline_entity(1);
  self.tag_trace_state = undefined;
  self.tag_trace_pulse = undefined;
  self.tag_trace_track = undefined;
  tagged_status_show();
}

function tag_flash_entity(player, flashing) {
  if(isDefined(self.tag_flashing) && self.tag_flashing == flashing) {
    return;
  }

  self.tag_flashing = flashing;
  self notify("tag_flash_entity");
  self endon("tag_flash_entity");
  self endon("death");
  player endon("death");
  player endon("disconnect");

  if(!isDefined(self) || !isDefined(self.model)) {
    assertmsg("<dev string:x52>");
  }

  if(!isDefined(self) || issentient(self) && !isalive(self)) {
    if(isDefined(self)) {
      tag_outline_entity(0);
    }

    return;
  }

  playerentnum = player getentitynumber();

  if(!isDefined(player.tag_next_flash)) {
    player.tag_next_flash = 0;
  }

  var_870df669effdb2b1 = isDefined(self.tagged) && istrue(self.tagged[playerentnum]);
  flash = 1;

  while(flashing && getdvarint(@ "ai_threatsight", 1)) {
    self.tagged_flickered = 1;

    if(flash) {
      tag_outline_entity(1, "dead");
    } else {
      tag_outline_entity(var_870df669effdb2b1);
    }

    waittime = player.tag_next_flash - gettime();

    if(waittime > 0) {
      wait float(waittime) / 1000;
    }

    flash = !flash;
    player.tag_next_flash = gettime() + 200;
    var_870df669effdb2b1 = isDefined(self.tagged) && istrue(self.tagged[playerentnum]);
  }

  tag_outline_entity(var_870df669effdb2b1);
}

function tagging_player_init() {
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
  self.tagging["tagging_fade_min"] = 500;
  self.tagging["tagging_fade_max"] = 3000;
}

function tracking_init() {
  setdvarifuninitialized(@ "hash_f05c8f3735320c7c", 3000);
  setdvarifuninitialized(@ "hash_804a2291b4a8b92e", 10);
  setdvarifuninitialized(@ "hash_a51875d7d6abf72", 50);
  setdvarifuninitialized(@ "hash_af0e1bddfb8d06f7", 250);
  setdvarifuninitialized(@ "hash_744c07d95523175f", 500);
  setdvarifuninitialized(@ "hash_2c74e15f8d4b6c58", 100);
  setdvarifuninitialized(@ "hash_f3a9396ca64643d", 500);
  setdvarifuninitialized(@ "hash_3fd7f3a2c9ccfda1", 1000);
  setdvarifuninitialized(@ "hash_b1c9cc21222ca5f1", 0);
  setdvarifuninitialized(@ "hash_d7fb76123edd5b2d", 0);
  hudoutline_add_channel("tagging", -1, &tagging_hudoutline_settings);
  thread lerp_hudoutline_occlusion();
  setsaveddvar(@ "r_hudoutlineenable", 1);
}

function tagging_hudoutline_settings() {
  hudoutlinesettings = [];
  hudoutlinesettings["r_hudoutlineFillColor0"] = "0.5 0.5 0.5 0";
  hudoutlinesettings["r_hudoutlineFillColor1"] = "0.5 0.5 0.5 0";
  hudoutlinesettings["r_hudoutlineOccludedOutlineColor"] = "0.5 0.5 0.5 0";
  hudoutlinesettings["r_hudoutlineOccludedInlineColor"] = "0.5 0.5 0.5 0";
  hudoutlinesettings["r_hudoutlineOccludedInteriorColor"] = "0.5 0.5 0.5 0";
  hudoutlinesettings["r_hudOutlineOccludedColorFromFill"] = 1;
  return hudoutlinesettings;
}

function lerp_hudoutline_occlusion() {
  alpha = 0;
  time = 0.05;
  value = "0.5 0.5 0.5";
  bool = 1;
  cycles = 0;

  while(true) {
    for(i = 1; i < 11; i++) {
      if(isDefined(level.hudoutlinecurchannel) && level.hudoutlinecurchannel == "tagging") {
        setsaveddvar(@ "r_hudoutlineOccludedOutlineColor", value + alpha + "");
        setsaveddvar(@ "r_hudoutlineOccludedInlineColor", value + alpha + "");
        setsaveddvar(@ "r_hudoutlineOccludedInteriorColor", value + alpha + "");

        if(bool) {
          alpha = ter_op(i == 10, 0.9, alpha + 0.1);
        } else {
          alpha = ter_op(i == 10, 0, alpha - 0.1);
        }

        wait time;
      }
    }

    cycles++;

    if(cycles == 2) {
      level notify("tagging_cycle");
      wait 2;
      cycles = 0;
    } else {
      wait 0.05;
    }

    if(bool) {
      bool = 0;
      continue;
    }

    bool = 1;
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

function function_5dfb4dd763f46cb3(hudelem) {
  self notify("<dev string:x8e>");
  self endon("<dev string:x8e>");
  self endon("<dev string:xa8>");

  while(isDefined(hudelem)) {
    hudelem.color = (getdvarfloat(@ "hash_85d2b91461a769e7"), getdvarfloat(@ "hash_85d2a41461a73bb8"), getdvarfloat(@ "hash_85d2a91461a746b7"));
    hudelem.alpha = getdvarfloat(@ "hash_85d2aa1461a748ea");
    wait 0.05;
  }
}

function tagging_entity_list() {
  enemyai = level.stealth.enemies[self.team];
  var_4417ddf013b240ba = getEntArray("rss_static_robot", "script_noteworthy");
  allies = getaiarray(self.team);
  enemies = scripts\engine\utility::array_combine(enemyai, var_4417ddf013b240ba);
  result = scripts\engine\utility::array_combine(enemies, allies);
  return result;
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

    var_e025306f5374186a = self.tagging["enabled"] && self.tagging["outline_enabled"] && !level.player islinked();

    if(var_e025306f5374186a && isads()) {
      tag_update_enemy_in_sights();
    }

    wait 0.05;
  }
}

function tag_update_enemy_in_sights() {
  entitylist = tagging_entity_list();
  eye = self getEye();
  var_87ea8542a557d603 = anglesToForward(self getplayerangles());
  var_bffac07b1b82af17 = undefined;
  var_5c5bc7719e4b1c11 = max(0.01, getdvarfloat(@ "hash_f05c8f3735320c7c"));
  var_2cebd0c753447713 = cos(getdvarfloat(@ "hash_804a2291b4a8b92e"));
  checkpoints = [0, 0.5, 1];

  if(scripts\stealth\utility::tagging_shield()) {
    var_5c5bc7719e4b1c11 = level.player.tagging["tagging_fade_max"];
    var_2cebd0c753447713 = cos(getdvarfloat(@ "cg_fov"));
  }

  trace = scripts\engine\trace::_bullet_trace(eye, eye + var_87ea8542a557d603 * 32000, 1, self);
  var_bffac07b1b82af17 = trace["entity"];

  foreach(entity in entitylist) {
    if(!isDefined(entity)) {
      continue;
    }

    if(issentient(entity) && !isalive(entity)) {
      continue;
    }

    if(isDefined(entity.tagged) && isDefined(entity.tagged[self getentitynumber()])) {
      continue;
    }

    if(!getdvarint(@ "hash_d7fb76123edd5b2d") && isDefined(entity.vehicle_ride) && entity.vehicle_ride.veh_speed > 0) {
      continue;
    }

    tracking = isDefined(var_bffac07b1b82af17) && var_bffac07b1b82af17 == entity;

    if(!tracking) {
      enemyeye = entity gettagorigin("tag_origin");

      if(isai(entity)) {
        enemyeye = entity getEye();
      }

      dist = distance(enemyeye, eye);

      if(dist <= var_5c5bc7719e4b1c11) {
        var_f290de2119e68c76 = min(1, var_2cebd0c753447713 + (1 - var_2cebd0c753447713) * dist / var_5c5bc7719e4b1c11);

        foreach(check in checkpoints) {
          testpoint = vectorlerp(entity.origin, enemyeye, check);
          delta = testpoint - eye;
          dir = vectorNormalize(delta);
          dot = vectordot(dir, var_87ea8542a557d603);

          if(dot > var_f290de2119e68c76) {
            if(enemy_sight_trace_passed(entity)) {
              tracking = 1;
              break;
            }
          }
        }
      }
    }

    if(tracking) {
      entity tag_trace_update("tracking", self, 1);
      continue;
    }

    entity tag_trace_update("none", self, 0);
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
    level thread enemy_sight_trace_process();
  }

  level.tagging_sight_trace_queue = array_add(level.tagging_sight_trace_queue, self);
  self.tagging_sight_traced_queued = 1;
}

function enemy_sight_trace_process() {
  self notify("enemy_sight_trace_process");
  self endon("enemy_sight_trace_process");
  var_98cfcdbee7100d1 = 3;

  while(true) {
    level.tagging_sight_trace_queue = array_removeundefined(level.tagging_sight_trace_queue);

    for(i = 0; i < min(var_98cfcdbee7100d1, level.tagging_sight_trace_queue.size); i++) {
      enemy = level.tagging_sight_trace_queue[0];
      level.tagging_sight_trace_queue = array_remove(level.tagging_sight_trace_queue, enemy);
      enemy.tagging_sight_trace_passed = enemy_sight_trace(enemy);
      enemy.tagging_sight_traced_queued = undefined;
    }

    wait 0.05;
  }
}

function enemy_sight_trace_passed(enemy) {
  enemy enemy_sight_trace_request();
  return enemy.tagging_sight_trace_passed;
}

function enemy_sight_trace(enemy) {
  result = 0;
  eyepos = level.player getEye();

  if(!result && enemy hastag(enemy.model, "j_head")) {
    if(sighttracepassed(eyepos, enemy gettagorigin("j_head"), 0, enemy.sight_ignore, enemy, 0)) {
      result = 1;
    }
  }

  if(!result && enemy hastag(enemy.model, "j_spinelower")) {
    if(sighttracepassed(eyepos, enemy gettagorigin("j_spinelower"), 0, enemy.sight_ignore, enemy, 0)) {
      result = 1;
    }
  }

  if(!result && enemy hastag(enemy.model, "tag_attach")) {
    if(sighttracepassed(eyepos, enemy gettagorigin("tag_attach"), 0, enemy.sight_ignore, enemy, 0)) {
      result = 1;
    }
  }

  if(!result && sighttracepassed(eyepos, enemy.origin, 0, enemy.sight_ignore, enemy, 0)) {
    result = 1;
  }

  return result;
}

function tag_trace_update(var_1b84be526a9c06f2, player, var_cc6f6a269ef25dca) {
  now = gettime();

  if(!isDefined(var_cc6f6a269ef25dca)) {
    var_cc6f6a269ef25dca = 0;
  }

  pulserate = getdvarint(@ "hash_a51875d7d6abf72");
  var_321a8156113cfdea = getdvarint(@ "hash_af0e1bddfb8d06f7");
  var_a39f3dc28acd7edc = getdvarint(@ "hash_744c07d95523175f");
  outofview = 0;

  if(!player.tagging["marking_enabled"]) {
    var_1b84be526a9c06f2 = "range";
  }

  switch (var_1b84be526a9c06f2) {
    case #"hash_3293967944b10658":
      outofview = 1;
      self.tag_trace_state = 0;
      self.tag_trace_track = undefined;
      break;
    case #"hash_e8392ab0bfe96fb2":
      self.tag_trace_state = 0;
      self.tag_trace_track = undefined;
      break;
    case #"hash_a51479b7a82ab324":
      pulserate = getdvarint(@ "hash_2c74e15f8d4b6c58");
      var_321a8156113cfdea = getdvarint(@ "hash_f3a9396ca64643d");
      var_a39f3dc28acd7edc = getdvarint(@ "hash_3fd7f3a2c9ccfda1");
    case #"hash_125ae3420ba0fbdc":
      if(!isDefined(self.tag_trace_track)) {
        if((gettime() - player.tagging["last_tag_start"]) / 1000 <= 0.25) {
          return;
        }

        self.tag_trace_track = now;
        player.tagging["last_tag_start"] = now;
      }

      break;
    case #"hash_696f35aa003adfec":
    case #"hash_db653a4972b3c13b":
    default:
      tag_outline_entity(0);
      self.tag_trace_track = undefined;
      return;
  }

  var_f4fa69353ba530ae = var_a39f3dc28acd7edc + var_321a8156113cfdea;
  var_b6024bb6422c13b9 = 0;

  if(isDefined(self.tag_trace_track)) {
    var_b6024bb6422c13b9 = now - self.tag_trace_track;
  }

  if(var_b6024bb6422c13b9 >= var_f4fa69353ba530ae) {
    if(var_cc6f6a269ef25dca) {
      player.tagged_ads = 1;
    }

    tag_entity(player);
  }
}

function tag_outline_entity(outline, forcedteam) {
  if(!isDefined(self)) {
    return;
  }

  if(outline) {
    tagged_status_show(forcedteam);
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

  while(true) {
    if(!getdvarint(@ "hash_d7fb76123edd5b2d") && isDefined(self.vehicle_ride) && self.vehicle_ride.veh_speed > 0) {
      tag_outline_entity(0);
      self notify("tagged_entity_death_cleanup");
      self.tagged = undefined;
      return;
    }

    if(!isDefined(self.tagged_flickered)) {
      if(!isDefined(self.tagged_time)) {
        self.tagged_time = gettime();
      }

      cycle = int((gettime() - self.tagged_time) / 100);

      if(cycle % 2) {
        tagged_status_hide();
      } else {
        tagged_status_show();
      }

      if(cycle > 3) {
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
  var_9c3219ab2e3b0d50["allies"] = "outlinefill_nodepth_cyan";
  var_9c3219ab2e3b0d50["axis"] = "outlinefill_nodepth_red";
  var_9c3219ab2e3b0d50["team3"] = "outlinefill_nodepth_white";
  var_9c3219ab2e3b0d50["dead"] = "outlinefill_nodepth_white";
  team = "dead";

  if(isDefined(self.team)) {
    team = self.team;
  }

  return var_9c3219ab2e3b0d50[team];
}

function tagged_status_show(forcedteam) {
  if(!isDefined(self)) {
    return;
  }

  tagged_status_hide();
  hudoutlineasset = tagged_hudoutline();
  hudoutline_enable_new(hudoutlineasset, "tagging");
  thread tagged_status_update();
  self.tagging_visible = 1;
}

function _create_tagging_highlight(color) {
  if(isDefined(self.highlight_ent)) {
    return;
  }

  if(isDefined(self.model) && hastag(self.model, "j_mainroot")) {
    self.highlight_ent = spawn_script_origin(self gettagorigin("tag_eye") + (0, 0, 20), self.angles);
    self.highlight_ent linkTo(self, "tag_origin");
    range = 3000;
    self.highlight_ent makeusable();
    self.highlight_ent setCursorHint("hint_button");
    self.highlight_ent sethintdisplayrange(range);
    self.highlight_ent setuserange(1);
    self.highlight_ent sethintonobstruction("show");
    thread _remove_tagging_highlight_on_death();
  }
}

function tagging_highlight_dist_fade(range) {
  self endon("death");
  cutoff = squared(range / 2);

  while(true) {
    while(distance2dsquared(self.origin, level.player.origin) > cutoff) {
      wait 0.1;
    }

    self.highlight_ent sethintdisplayrange(0);

    while(distance2dsquared(self.origin, level.player.origin) < cutoff) {
      wait 0.1;
    }

    self.highlight_ent sethintdisplayrange(range);
  }
}

function _remove_tagging_highlight_on_death() {
  highlight_ent = self.highlight_ent;
  waittill_any("death", "tagging_remove_highlight");

  if(isDefined(highlight_ent)) {
    if(target_istarget(highlight_ent)) {
      target_remove(highlight_ent);
    }

    highlight_ent delete();
  }

  if(isDefined(self)) {
    self.highlight_ent = undefined;
  }
}

function _end_tagging_highlighting() {
  level notify("end_tagging_highlighting");

  foreach(ai in getaiarray("axis", "allies")) {
    ai notify("tagging_remove_highlight");
  }
}

function tagged_status_hide() {
  if(!isDefined(self)) {
    return;
  }

  self notify("tagged_status_update");
  hudoutline_disable("tagging");
  self.tagging_visible = undefined;
}

function tagged_status_update() {
  self notify("tagged_status_update");
  self endon("tagged_status_update");
  self endon("death");

  while(isDefined(self) && (!issentient(self) || isalive(self))) {
    maxdist = level.player.tagging["tagging_fade_max"];
    maxdistsq = maxdist * maxdist;
    distsq = lengthsquared(level.player.origin - self.origin);

    if(distsq > maxdistsq) {
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
  self waittill("death", killer, dmgmod);

  if(isPlayer(killer)) {
    wait 0.1;

    if(isDefined(self) && distancesquared(self.origin, level.player.origin) > 90000) {
      start = gettime();
      state = 1;

      while(isDefined(self) && gettime() - start < 1000) {
        if(state == 0 && randomint(100) < 30) {
          tag_outline_entity(1);
          state = 1;
        } else if(state == 1) {
          tag_outline_entity(0);
          state = 0;
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