/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_stealth_logic.gsc
********************************/

stealth_init() {
  system_init();
  thread system_message_loop();
}

system_set_detect_ranges(var_0, var_1, var_2) {
  if(isdefined(var_0)) {
    level._stealth.logic.detect_range["hidden"]["prone"] = var_0["prone"];
    level._stealth.logic.detect_range["hidden"]["crouch"] = var_0["crouch"];
    level._stealth.logic.detect_range["hidden"]["stand"] = var_0["stand"];
  }

  if(isdefined(var_1)) {
    level._stealth.logic.detect_range["alert"]["prone"] = var_1["prone"];
    level._stealth.logic.detect_range["alert"]["crouch"] = var_1["crouch"];
    level._stealth.logic.detect_range["alert"]["stand"] = var_1["stand"];
  }

  if(isdefined(var_2)) {
    level._stealth.logic.detect_range["spotted"]["prone"] = var_2["prone"];
    level._stealth.logic.detect_range["spotted"]["crouch"] = var_2["crouch"];
    level._stealth.logic.detect_range["spotted"]["stand"] = var_2["stand"];
  }
}

system_default_detect_ranges() {
  var_0 = [];
  var_0["prone"] = 70;
  var_0["crouch"] = 600;
  var_0["stand"] = 1024;
  var_1 = [];
  var_1["prone"] = 140;
  var_1["crouch"] = 900;
  var_1["stand"] = 1500;
  var_2 = [];
  var_2["prone"] = 512;
  var_2["crouch"] = 5000;
  var_2["stand"] = 8000;
  system_set_detect_ranges(var_0, var_1, var_2);
}

friendly_default_movespeed_scale() {
  var_0 = [];
  var_0["prone"] = 3;
  var_0["crouch"] = 2;
  var_0["stand"] = 2;
  var_1 = [];
  var_1["prone"] = 2;
  var_1["crouch"] = 2;
  var_1["stand"] = 2;
  var_2 = [];
  var_2["prone"] = 2;
  var_2["crouch"] = 2;
  var_2["stand"] = 2;
  friendly_set_movespeed_scale(var_0, var_1, var_2);
}

friendly_set_movespeed_scale(var_0, var_1, var_2, var_3) {
  if(isdefined(var_0)) {
    self._stealth.logic.movespeed_scale["hidden"]["prone"] = var_0["prone"];
    self._stealth.logic.movespeed_scale["hidden"]["crouch"] = var_0["crouch"];
    self._stealth.logic.movespeed_scale["hidden"]["stand"] = var_0["stand"];
  }

  if(isdefined(var_1)) {
    self._stealth.logic.movespeed_scale["alert"]["prone"] = var_1["prone"];
    self._stealth.logic.movespeed_scale["alert"]["crouch"] = var_1["crouch"];
    self._stealth.logic.movespeed_scale["alert"]["stand"] = var_1["stand"];
  }

  if(isdefined(var_2)) {
    self._stealth.logic.movespeed_scale["spotted"]["prone"] = var_2["prone"];
    self._stealth.logic.movespeed_scale["spotted"]["crouch"] = var_2["crouch"];
    self._stealth.logic.movespeed_scale["spotted"]["stand"] = var_2["stand"];
  }
}

system_init() {
  common_scripts\utility::flag_init("_stealth_hidden");
  common_scripts\utility::flag_init("_stealth_alert");
  common_scripts\utility::flag_init("_stealth_spotted");
  common_scripts\utility::flag_init("_stealth_found_corpse");
  common_scripts\utility::flag_set("_stealth_hidden");
  level._stealth = spawnstruct();
  level._stealth.logic = spawnstruct();
  level._stealth.logic.detection_level = "hidden";
  level._stealth.logic.detect_range = [];
  level._stealth.logic.detect_range["alert"] = [];
  level._stealth.logic.detect_range["hidden"] = [];
  level._stealth.logic.detect_range["spotted"] = [];
  system_default_detect_ranges();
  level._stealth.logic.corpse = spawnstruct();
  level._stealth.logic.corpse.array = [];
  level._stealth.logic.corpse.last_pos = undefined;
  level._stealth.logic.corpse.max_num = int(getdvar("ai_corpseCount"));
  level._stealth.logic.corpse.sight_dist = 1500;
  level._stealth.logic.corpse.detect_dist = 256;
  level._stealth.logic.corpse.found_dist = 96;
  level._stealth.logic.corpse.sight_distsqrd = level._stealth.logic.corpse.sight_dist * level._stealth.logic.corpse.sight_dist;
  level._stealth.logic.corpse.detect_distsqrd = level._stealth.logic.corpse.detect_dist * level._stealth.logic.corpse.detect_dist;
  level._stealth.logic.corpse.found_distsqrd = level._stealth.logic.corpse.found_dist * level._stealth.logic.corpse.found_dist;
  level._stealth.logic.corpse.corpse_height = [];
  level._stealth.logic.corpse.corpse_height["spotted"] = 10;
  level._stealth.logic.corpse.corpse_height["alert"] = 10;
  level._stealth.logic.corpse.corpse_height["hidden"] = 6;
  level._stealth.logic.ai_event = [];
  level._stealth.logic.ai_event["ai_eventDistDeath"] = [];
  level._stealth.logic.ai_event["ai_eventDistDeath"]["spotted"] = getdvar("ai_eventDistDeath");
  level._stealth.logic.ai_event["ai_eventDistDeath"]["alert"] = 512;
  level._stealth.logic.ai_event["ai_eventDistDeath"]["hidden"] = 256;
  level._stealth.logic.ai_event["ai_eventDistPain"] = [];
  level._stealth.logic.ai_event["ai_eventDistPain"]["spotted"] = getdvar("ai_eventDistPain");
  level._stealth.logic.ai_event["ai_eventDistPain"]["alert"] = 384;
  level._stealth.logic.ai_event["ai_eventDistPain"]["hidden"] = 256;
  level._stealth.logic.ai_event["ai_eventDistExplosion"] = [];
  level._stealth.logic.ai_event["ai_eventDistExplosion"]["spotted"] = 4000;
  level._stealth.logic.ai_event["ai_eventDistExplosion"]["alert"] = 4000;
  level._stealth.logic.ai_event["ai_eventDistExplosion"]["hidden"] = 4000;
  level._stealth.logic.ai_event["ai_eventDistBullet"] = [];
  level._stealth.logic.ai_event["ai_eventDistBullet"]["spotted"] = getdvar("ai_eventDistBullet");
  level._stealth.logic.ai_event["ai_eventDistBullet"]["alert"] = 64;
  level._stealth.logic.ai_event["ai_eventDistBullet"]["hidden"] = 64;
  level._stealth.logic.ai_event["ai_eventDistFootstep"] = [];
  level._stealth.logic.ai_event["ai_eventDistFootstep"]["spotted"] = getdvar("ai_eventDistFootstep");
  level._stealth.logic.ai_event["ai_eventDistFootstep"]["alert"] = 64;
  level._stealth.logic.ai_event["ai_eventDistFootstep"]["hidden"] = 64;
  level._stealth.logic.ai_event["ai_eventDistFootstepWalk"] = [];
  level._stealth.logic.ai_event["ai_eventDistFootstepWalk"]["spotted"] = getdvar("ai_eventDistFootstepWalk");
  level._stealth.logic.ai_event["ai_eventDistFootstepWalk"]["alert"] = 32;
  level._stealth.logic.ai_event["ai_eventDistFootstepWalk"]["hidden"] = 32;
  level._stealth.logic.system_state_functions = [];
  level._stealth.logic.system_state_functions["hidden"] = ::system_state_hidden;
  level._stealth.logic.system_state_functions["alert"] = ::system_state_alert;
  level._stealth.logic.system_state_functions["spotted"] = ::system_state_spotted;
  anim.eventactionminwait["threat"]["self"] = 20000;
  anim.eventactionminwait["threat"]["squad"] = 30000;
  system_init_shadows();
}

system_init_shadows() {
  common_scripts\utility::array_thread(getentarray("_stealth_shadow", "targetname"), ::stealth_shadow_volumes);
  common_scripts\utility::array_thread(getentarray("stealth_shadow", "targetname"), ::stealth_shadow_volumes);
}

stealth_shadow_volumes() {
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  self endon("death");

  for (;;) {
    self waittill("trigger", var_0);

    if(!isalive(var_0)) {
      continue;
    }
    if(var_0 maps\_utility::ent_flag("_stealth_in_shadow")) {
      continue;
    }
    var_0 thread stealth_shadow_ai_in_volume(self);
  }
}

system_message_loop() {
  var_0 = level._stealth.logic.system_state_functions;
  thread system_message_handler("_stealth_hidden", "hidden", var_0["hidden"]);
  thread system_message_handler("_stealth_alert", "alert", var_0["alert"]);
  thread system_message_handler("_stealth_spotted", "spotted", var_0["spotted"]);
}

system_message_handler(var_0, var_1, var_2) {
  level endon("_stealth_stop_stealth_logic");

  for (;;) {
    common_scripts\utility::flag_wait(var_0);
    system_event_change(var_1);
    level._stealth.logic.detection_level = var_1;
    level notify("_stealth_detection_level_change");
    thread[[var_2]]();
    common_scripts\utility::flag_waitopen(var_0);
  }
}

system_event_change(var_0) {
  var_1 = getarraykeys(level._stealth.logic.ai_event);

  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    setsaveddvar(var_3, level._stealth.logic.ai_event[var_3][var_0]);
  }
}

system_state_spotted() {
  common_scripts\utility::flag_clear("_stealth_hidden");
  common_scripts\utility::flag_clear("_stealth_alert");
  level endon("_stealth_detection_level_change");
  level endon("_stealth_stop_stealth_logic");
  waittillframeend;

  for (var_0 = getaispeciesarray("axis", "all"); var_0.size; var_0 = getaispeciesarray("axis", "all")) {
    var_1 = 1;
    var_0 = getaispeciesarray("axis", "all");

    for (var_2 = 0; var_2 < var_0.size; var_2++) {
      if(isalive(var_0[var_2].enemy)) {
        var_1 = 0;
        break;
      }
    }

    if(var_1) {
      wait 1;
      var_0 = getaispeciesarray("axis", "all");

      for (var_2 = 0; var_2 < var_0.size; var_2++) {
        if(isalive(var_0[var_2].enemy)) {
          var_1 = 0;
          break;
        }
      }
    }

    if(var_1) {
      break;
    }

    wait 0.1;
  }

  common_scripts\utility::flag_clear("_stealth_spotted");
  common_scripts\utility::flag_set("_stealth_alert");
}

system_state_alert() {
  common_scripts\utility::flag_clear("_stealth_hidden");
  level endon("_stealth_detection_level_change");
  level endon("_stealth_stop_stealth_logic");
  waittillframeend;
  var_0 = 15;

  for (var_1 = 0.1; var_0 > 0; var_0 = var_0 - var_1) {
    var_2 = getaispeciesarray("axis", "all");

    if(!var_2.size) {
      break;
    }

    wait(var_1);
  }

  common_scripts\utility::flag_waitopen("_stealth_found_corpse");
  common_scripts\utility::flag_clear("_stealth_spotted");
  common_scripts\utility::flag_clear("_stealth_alert");
  common_scripts\utility::flag_set("_stealth_hidden");
}

system_state_hidden() {
  level endon("_stealth_detection_level_change");
  level endon("_stealth_stop_stealth_logic");
}

friendly_logic() {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  friendly_init();
  var_0 = self._stealth.logic.current_stance_func;

  if(isplayer(self))
    thread friendly_movespeed_calc_loop();

  for (;;) {
    self[[var_0]]();
    self.maxvisibledist = friendly_compute_score();
    wait 0.05;
  }
}

friendly_init() {
  self._stealth = spawnstruct();
  self._stealth.logic = spawnstruct();

  if(isplayer(self)) {
    self._stealth.logic.getstance_func = ::friendly_getstance_player;
    self._stealth.logic.getangles_func = ::friendly_getangles_player;

    if(level.console)
      self._stealth.logic.getvelocity_func = ::friendly_getvelocity;
    else {
      self._stealth.logic.getvelocity_func = ::player_getvelocity_pc;
      self._stealth.logic.player_pc_velocity = 0;
    }

    self._stealth.logic.current_stance_func = ::friendly_compute_stances_player;
  } else {
    self._stealth.logic.getstance_func = ::friendly_getstance_ai;
    self._stealth.logic.getangles_func = ::friendly_getangles_ai;
    self._stealth.logic.getvelocity_func = ::friendly_getvelocity;
    self._stealth.logic.current_stance_func = ::friendly_compute_stances_ai;
  }

  self._stealth.logic.stance_change_time = 0.2;
  self._stealth.logic.stance_change = 0;
  self._stealth.logic.oldstance = self[[self._stealth.logic.getstance_func]]();
  self._stealth.logic.stance = self[[self._stealth.logic.getstance_func]]();
  self._stealth.logic.spotted_list = [];
  self._stealth.logic.movespeed_multiplier = [];
  self._stealth.logic.movespeed_scale = [];
  self._stealth.logic.movespeed_multiplier["hidden"] = [];
  self._stealth.logic.movespeed_multiplier["hidden"]["prone"] = 0;
  self._stealth.logic.movespeed_multiplier["hidden"]["crouch"] = 0;
  self._stealth.logic.movespeed_multiplier["hidden"]["stand"] = 0;
  self._stealth.logic.movespeed_multiplier["alert"] = [];
  self._stealth.logic.movespeed_multiplier["alert"]["prone"] = 0;
  self._stealth.logic.movespeed_multiplier["alert"]["crouch"] = 0;
  self._stealth.logic.movespeed_multiplier["alert"]["stand"] = 0;
  self._stealth.logic.movespeed_multiplier["spotted"] = [];
  self._stealth.logic.movespeed_multiplier["spotted"]["prone"] = 0;
  self._stealth.logic.movespeed_multiplier["spotted"]["crouch"] = 0;
  self._stealth.logic.movespeed_multiplier["spotted"]["stand"] = 0;
  friendly_default_movespeed_scale();
  maps\_utility::ent_flag_init("_stealth_in_shadow");
}

friendly_getvelocity() {
  return length(self getvelocity());
}

player_getvelocity_pc() {
  var_0 = length(self getvelocity());
  var_1 = self._stealth.logic.stance;
  var_2 = [];
  var_2["stand"] = 30;
  var_2["crouch"] = 15;
  var_2["prone"] = 4;
  var_3 = [];
  var_3["stand"] = 40;
  var_3["crouch"] = 25;
  var_3["prone"] = 10;

  if(!var_0)
    self._stealth.logic.player_pc_velocity = 0;
  else if(var_0 > self._stealth.logic.player_pc_velocity) {
    self._stealth.logic.player_pc_velocity = self._stealth.logic.player_pc_velocity + var_2[var_1];

    if(self._stealth.logic.player_pc_velocity > var_0)
      self._stealth.logic.player_pc_velocity = var_0;
  } else if(var_0 < self._stealth.logic.player_pc_velocity) {
    self._stealth.logic.player_pc_velocity = self._stealth.logic.player_pc_velocity - var_3[var_1];

    if(self._stealth.logic.player_pc_velocity < 0)
      self._stealth.logic.player_pc_velocity = 0;
  }

  return self._stealth.logic.player_pc_velocity;
}

friendly_movespeed_calc_loop() {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  var_0 = self._stealth.logic.getangles_func;
  var_1 = self._stealth.logic.getvelocity_func;
  var_2 = self[[var_0]]();

  for (;;) {
    var_3 = undefined;

    if(maps\_utility::ent_flag("_stealth_in_shadow"))
      var_3 = 0;
    else {
      var_4 = self[[var_1]]();
      var_5 = length(var_2 - self[[var_0]]());

      if(var_5 > 30)
        var_5 = 30;

      var_3 = var_4 + var_5;
    }

    self._stealth.logic.movespeed_multiplier["hidden"]["prone"] = var_3 * self._stealth.logic.movespeed_scale["hidden"]["prone"];
    self._stealth.logic.movespeed_multiplier["spotted"]["prone"] = var_3 * self._stealth.logic.movespeed_scale["spotted"]["prone"];
    self._stealth.logic.movespeed_multiplier["alert"]["prone"] = var_3 * self._stealth.logic.movespeed_scale["alert"]["prone"];
    self._stealth.logic.movespeed_multiplier["hidden"]["crouch"] = var_3 * self._stealth.logic.movespeed_scale["hidden"]["crouch"];
    self._stealth.logic.movespeed_multiplier["spotted"]["crouch"] = var_3 * self._stealth.logic.movespeed_scale["spotted"]["crouch"];
    self._stealth.logic.movespeed_multiplier["alert"]["crouch"] = var_3 * self._stealth.logic.movespeed_scale["alert"]["crouch"];
    self._stealth.logic.movespeed_multiplier["hidden"]["stand"] = var_3 * self._stealth.logic.movespeed_scale["hidden"]["stand"];
    self._stealth.logic.movespeed_multiplier["spotted"]["stand"] = var_3 * self._stealth.logic.movespeed_scale["spotted"]["stand"];
    self._stealth.logic.movespeed_multiplier["alert"]["stand"] = var_3 * self._stealth.logic.movespeed_scale["alert"]["stand"];
    var_2 = self[[var_0]]();
    wait 0.1;
  }
}

friendly_compute_score(var_0) {
  if(!isdefined(var_0))
    var_0 = self._stealth.logic.stance;

  var_1 = level._stealth.logic.detection_level;
  var_2 = level._stealth.logic.detect_range[var_1][var_0];

  if(maps\_utility::ent_flag("_stealth_in_shadow")) {
    var_2 = var_2 * 0.5;

    if(var_2 < level._stealth.logic.detect_range["hidden"]["prone"])
      var_2 = level._stealth.logic.detect_range["hidden"]["prone"];
  }

  var_3 = self._stealth.logic.movespeed_multiplier[var_1][var_0];

  if(isdefined(self._stealth_move_detection_cap) && var_3 > self._stealth_move_detection_cap)
    var_3 = self._stealth_move_detection_cap;

  return var_2 + var_3;
}

friendly_getstance_ai() {
  return self.a.pose;
}

friendly_getstance_player() {
  return level.player getstance();
}

friendly_getangles_ai() {
  return self.angles;
}

friendly_getangles_player() {
  return self getplayerangles();
}

friendly_compute_stances_ai() {
  self._stealth.logic.stance = self[[self._stealth.logic.getstance_func]]();
  self._stealth.logic.oldstance = self._stealth.logic.stance;
}

friendly_compute_stances_player() {
  var_0 = self[[self._stealth.logic.getstance_func]]();

  if(!self._stealth.logic.stance_change) {
    switch (var_0) {
      case "prone":
        if(self._stealth.logic.oldstance != "prone")
          self._stealth.logic.stance_change = self._stealth.logic.stance_change_time;

        break;
      case "crouch":
        if(self._stealth.logic.oldstance == "stand")
          self._stealth.logic.stance_change = self._stealth.logic.stance_change_time;

        break;
    }
  }

  if(self._stealth.logic.stance_change) {
    self._stealth.logic.stance = self._stealth.logic.oldstance;

    if(self._stealth.logic.stance_change > 0.05)
      self._stealth.logic.stance_change = self._stealth.logic.stance_change - 0.05;
    else {
      self._stealth.logic.stance_change = 0;
      self._stealth.logic.stance = var_0;
      self._stealth.logic.oldstance = var_0;
    }
  } else {
    self._stealth.logic.stance = var_0;
    self._stealth.logic.oldstance = var_0;
  }
}

enemy_logic() {
  enemy_init();
  thread enemy_threat_logic();
  thread enemy_corpse_logic();
}

enemy_init() {
  self clearenemy();
  self._stealth = spawnstruct();
  self._stealth.logic = spawnstruct();
  self._stealth.logic.dog = 0;

  if(issubstr(self.classname, "dog"))
    self._stealth.logic.dog = 1;

  self._stealth.logic.alert_level = spawnstruct();
  self._stealth.logic.alert_level.lvl = undefined;
  self._stealth.logic.alert_level.enemy = undefined;
  self._stealth.logic.stoptime = 0;
  self._stealth.logic.corpse = spawnstruct();
  self._stealth.logic.corpse.corpse_entity = undefined;
  maps\_utility::ent_flag_init("_stealth_saw_corpse");
  maps\_utility::ent_flag_init("_stealth_found_corpse");
  enemy_event_listeners_init();
  maps\_utility::ent_flag_init("_stealth_in_shadow");
}

enemy_event_listeners_init() {
  maps\_utility::ent_flag_init("_stealth_bad_event_listener");
  self._stealth.logic.event = spawnstruct();
  self._stealth.logic.event.listener = [];
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "grenade danger";
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "gunshot";
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "bulletwhizby";
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "silenced_shot";
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "projectile_impact";

  for (var_0 = 0; var_0 < self._stealth.logic.event.listener.size; var_0++)
    self addaieventlistener(self._stealth.logic.event.listener[var_0]);

  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "explode";
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "doFlashBanged";

  for (var_0 = 0; var_0 < self._stealth.logic.event.listener.size; var_0++)
    thread enemy_event_listeners_logic(self._stealth.logic.event.listener[var_0]);

  thread enemy_event_declare_to_team("damage", "ai_eventDistPain");
  thread enemy_event_declare_to_team("death", "ai_eventDistDeath");
  thread enemy_event_listeners_proc();
  self._stealth.logic.event.awareness = [];
  thread enemy_event_awareness("reset");
  thread enemy_event_awareness("alerted_once");
  thread enemy_event_awareness("alerted_again");
  thread enemy_event_awareness("attack");
  thread enemy_event_awareness("heard_scream");
  thread enemy_event_awareness("heard_corpse");
  thread enemy_event_awareness("saw_corpse");
  thread enemy_event_awareness("found_corpse");
  thread enemy_event_awareness("explode");
  thread enemy_event_awareness("doFlashBanged");
  thread enemy_event_awareness("bulletwhizby");
  thread enemy_event_awareness("projectile_impact");
}

enemy_event_listeners_logic(var_0) {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");

  for (;;) {
    self waittill(var_0);
    maps\_utility::ent_flag_set("_stealth_bad_event_listener");
  }
}

enemy_event_listeners_proc() {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");

  for (;;) {
    maps\_utility::ent_flag_wait("_stealth_bad_event_listener");
    wait 0.65;
    maps\_utility::ent_flag_clear("_stealth_bad_event_listener");
  }
}

enemy_event_awareness(var_0) {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  self._stealth.logic.event.awareness[var_0] = 1;
  var_1 = undefined;

  for (;;) {
    self waittill(var_0, var_2, var_3);

    if(!self._stealth.logic.dog) {
      if(common_scripts\utility::flag("_stealth_spotted") && (isdefined(self.enemy) || isdefined(self.favoriteenemy)))
        continue;
    }

    switch (var_0) {
      case "projectile_impact":
        var_1 = var_3;
        break;
      default:
        var_1 = var_2;
        break;
    }

    self._stealth.logic.event.awareness[var_0] = var_1;
    self notify("event_awareness", var_0);
    level notify("event_awareness", var_0);
    waittillframeend;

    if(!common_scripts\utility::flag("_stealth_spotted") && var_0 != "alerted_once")
      common_scripts\utility::flag_set("_stealth_alert");
  }
}

enemy_event_declare_to_team(var_0, var_1) {
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  var_2 = undefined;
  var_3 = self.team;

  for (;;) {
    if(!isalive(self)) {
      return;
    }
    self waittill(var_0, var_4, var_5);

    switch (var_0) {
      case "death":
        var_2 = var_4;
        break;
      case "damage":
        var_2 = var_5;
        break;
    }

    if(!isdefined(var_2)) {
      continue;
    }
    if(var_2 == level.player || isdefined(var_2.team) && var_2.team != var_3) {
      break;
    }
  }

  if(!isdefined(self)) {
    return;
  }
  var_6 = getaispeciesarray("axis", "all");
  var_7 = int(level._stealth.logic.ai_event[var_1][level._stealth.logic.detection_level]);

  for (var_8 = 0; var_8 < var_6.size; var_8++) {
    if(!isalive(var_6[var_8])) {
      continue;
    }
    if(!isdefined(var_6[var_8]._stealth)) {
      continue;
    }
    if(distance(var_6[var_8].origin, self.origin) > var_7) {
      continue;
    }
    var_6[var_8] maps\_utility::ent_flag_set("_stealth_bad_event_listener");
  }
}

enemy_threat_logic() {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");

  for (;;) {
    self waittill("enemy");

    if(!isalive(self.enemy)) {
      continue;
    }
    if(!common_scripts\utility::flag("_stealth_spotted") && !self._stealth.logic.dog) {
      if(!enemy_alert_level_logic(self.enemy))
        continue;
    } else
      enemy_alert_level_change("attack", self.enemy);

    thread enemy_threat_set_spotted();
    wait 20;

    while (isdefined(self.enemy)) {
      if(distance(self.origin, self.enemy.origin) > self.maxvisibledist)
        self clearenemy();

      wait 0.25;
    }

    enemy_alert_level_change("reset", undefined);
  }
}

enemy_threat_set_spotted() {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  level thread enemy_threat_being_spotted_clear();
  thread enemy_threat_being_spotted_clear();
  common_scripts\utility::flag_set("being_spotted");
  wait(randomfloatrange(0.25, 0.5));
  common_scripts\utility::flag_set("_stealth_spotted");
  common_scripts\utility::flag_clear("being_spotted");
}

enemy_threat_being_spotted_clear() {
  common_scripts\utility::waittill_any("_stealth_stop_stealth_logic", "death", "pain_death");
  common_scripts\utility::flag_clear("being_spotted");
}

enemy_alert_level_logic(var_0) {
  if(!isdefined(var_0._stealth))
    return 1;

  if(!isdefined(var_0._stealth.logic.spotted_list[self.ai_number]))
    var_0._stealth.logic.spotted_list[self.ai_number] = 0;

  if(!self._stealth.logic.stoptime)
    var_0._stealth.logic.spotted_list[self.ai_number]++;

  if(maps\_utility::ent_flag("_stealth_bad_event_listener") || var_0._stealth.logic.spotted_list[self.ai_number] > 2) {
    enemy_alert_level_change("attack", var_0);
    return 1;
  }

  self clearenemy();

  if(self._stealth.logic.stoptime)
    return 0;

  switch (var_0._stealth.logic.spotted_list[self.ai_number]) {
    case 1:
      enemy_alert_level_change("alerted_once", var_0);
      break;
    case 2:
      enemy_alert_level_change("alerted_again", var_0);
      break;
  }

  thread enemy_alert_level_forget(var_0);
  thread enemy_alert_level_waittime(var_0);
  return 0;
}

enemy_alert_level_forget(var_0) {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  wait 60;
  var_0._stealth.logic.spotted_list[self.ai_number]--;
}

enemy_alert_level_waittime(var_0) {
  self endon("death");
  var_1 = distance(self.origin, var_0.origin) * 0.0005;
  self._stealth.logic.stoptime = 0.25 + var_1;
  common_scripts\utility::flag_wait_or_timeout("_stealth_spotted", self._stealth.logic.stoptime);
  self._stealth.logic.stoptime = 0;
}

enemy_alert_level_change(var_0, var_1) {
  level notify("_stealth_enemy_alert_level_change");
  self notify("_stealth_enemy_alert_level_change");
  self notify(var_0, var_1);
  self._stealth.logic.alert_level.lvl = var_0;
  self._stealth.logic.alert_level.enemy = var_1;
}

enemy_corpse_logic() {
  thread enemy_corpse_death();

  if(self._stealth.logic.dog) {
    return;
  }
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  thread enemy_corpse_found_loop();

  for (;;) {
    while (!common_scripts\utility::flag("_stealth_spotted")) {
      var_0 = 0;
      var_1 = 0;
      var_2 = undefined;

      for (var_3 = 0; var_3 < level._stealth.logic.corpse.array.size; var_3++) {
        var_2 = level._stealth.logic.corpse.array[var_3];
        var_4 = distancesquared(self.origin, var_2.origin);

        if(var_4 < level._stealth.logic.corpse.found_distsqrd) {
          var_0 = 1;
          break;
        }

        if(isdefined(self._stealth.logic.corpse.corpse_entity)) {
          if(self._stealth.logic.corpse.corpse_entity == var_2) {
            continue;
          }
          var_5 = distancesquared(self.origin, self._stealth.logic.corpse.corpse_entity.origin);

          if(var_5 <= var_4)
            continue;
        }

        if(var_4 > level._stealth.logic.corpse.sight_distsqrd) {
          continue;
        }
        if(var_4 < level._stealth.logic.corpse.detect_distsqrd) {
          if(self cansee(var_2)) {
            var_1 = 1;
            break;
          }
        }

        var_6 = self gettagangles("tag_eye");
        var_7 = self gettagorigin("tag_eye");
        var_8 = anglestoforward(var_6);
        var_9 = vectornormalize(var_2.origin - var_7);

        if(vectordot(var_8, var_9) > 0.55) {
          if(self cansee(var_2)) {
            var_1 = 1;
            break;
          }
        }
      }

      if(var_0) {
        if(!maps\_utility::ent_flag("_stealth_found_corpse"))
          maps\_utility::ent_flag_set("_stealth_found_corpse");
        else
          self notify("_stealth_found_corpse");

        maps\_utility::ent_flag_clear("_stealth_saw_corpse");
        thread enemy_corpse_found(var_2);
        self notify("found_corpse", var_2);
      } else if(var_1) {
        self._stealth.logic.corpse.corpse_entity = var_2;

        if(!maps\_utility::ent_flag("_stealth_saw_corpse"))
          maps\_utility::ent_flag_set("_stealth_saw_corpse");
        else
          self notify("_stealth_saw_corpse");

        level notify("_stealth_saw_corpse");
        self notify("saw_corpse", var_2);
      }

      wait 0.05;
    }

    common_scripts\utility::flag_waitopen("_stealth_spotted");
  }
}

enemy_corpse_death() {
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_corpse_logic");
  var_0 = self.ai_number;
  self waittill("death");

  if(!isdefined(self.origin)) {
    return;
  }
  var_1 = level._stealth.logic.corpse.corpse_height[level._stealth.logic.detection_level];
  var_2 = (0, 0, var_1);
  var_3 = spawn("script_origin", self.origin + var_2);
  var_3.targetname = "corpse";
  var_3.ai_number = var_0;
  var_3.script_noteworthy = var_3.targetname + "_" + var_3.ai_number;
  var_3 endon("death");

  while (isdefined(self.origin)) {
    var_3.origin = self.origin + var_2;
    wait 0.01;
  }

  if(level.cheatstates["sf_use_tire_explosion"])
    wait 0.25;

  var_3 enemy_corpse_add_to_stack();
}

enemy_corpse_add_to_stack() {
  if(level._stealth.logic.corpse.array.size == level._stealth.logic.corpse.max_num)
    enemy_corpse_shorten_stack();

  level._stealth.logic.corpse.array[level._stealth.logic.corpse.array.size] = self;
}

enemy_corpse_shorten_stack() {
  var_0 = [];
  var_1 = level._stealth.logic.corpse.array;
  var_2 = level._stealth.logic.corpse.array[0];

  for (var_3 = 1; var_3 < level._stealth.logic.corpse.max_num; var_3++)
    var_0[var_0.size] = var_1[var_3];

  level._stealth.logic.corpse.array = var_0;
  var_2 delete();
}

enemy_corpse_found(var_0) {
  level._stealth.logic.corpse.last_pos = var_0.origin;
  level._stealth.logic.corpse.array = common_scripts\utility::array_remove(level._stealth.logic.corpse.array, var_0);

  if(isdefined(self.no_corpse_announce)) {
    level notify("_stealth_no_corpse_announce");
    self notify("event_awareness", "found_corpse");
    return;
  }

  wait(randomfloatrange(0.25, 0.5));

  if(!common_scripts\utility::flag("_stealth_found_corpse"))
    common_scripts\utility::flag_set("_stealth_found_corpse");
  else
    level notify("_stealth_found_corpse");

  thread enemy_corpse_clear();
}

enemy_corpse_found_loop() {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");

  for (;;) {
    level waittill("_stealth_found_corpse");

    if(!common_scripts\utility::flag("_stealth_found_corpse")) {
      continue;
    }
    enemy_corpse_alert_level();
  }
}

enemy_corpse_alert_level() {
  var_0 = undefined;

  if(isdefined(self.enemy))
    var_0 = self.enemy;
  else
    var_0 = level.player;

  if(!isdefined(var_0._stealth.logic.spotted_list[self.ai_number]))
    var_0._stealth.logic.spotted_list[self.ai_number] = 0;

  switch (var_0._stealth.logic.spotted_list[self.ai_number]) {
    case 0:
      var_0._stealth.logic.spotted_list[self.ai_number]++;
      thread enemy_alert_level_forget(var_0);
      break;
    case 1:
      var_0._stealth.logic.spotted_list[self.ai_number]++;
      thread enemy_alert_level_forget(var_0);
      break;
    case 2:
      var_0._stealth.logic.spotted_list[self.ai_number]++;
      thread enemy_alert_level_forget(var_0);
      break;
  }

  common_scripts\utility::flag_set("_stealth_alert");
}

enemy_corpse_clear() {
  level endon("_stealth_found_corpse");
  level endon("_stealth_stop_stealth_logic");
  maps\_utility::waittill_dead_or_dying(getaiarray("axis"), undefined, 90);
  common_scripts\utility::flag_clear("_stealth_found_corpse");
}

stealth_shadow_ai_in_volume(var_0) {
  self endon("death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  maps\_utility::ent_flag_set("_stealth_in_shadow");

  while (self istouching(var_0))
    wait 0.05;

  maps\_utility::ent_flag_clear("_stealth_in_shadow");
}

stealth_ai(var_0, var_1, var_2, var_3) {
  stealth_ai_logic();
  stealth_ai_behavior(var_0, var_1, var_2, var_3);
}

stealth_ai_logic() {
  switch (self.team) {
    case "allies":
      thread friendly_logic();
      break;
    case "axis":
      thread enemy_logic();
      break;
  }
}

stealth_ai_behavior(var_0, var_1, var_2, var_3) {
  if(isplayer(self)) {
    return;
  }
  switch (self.team) {
    case "allies":
      thread maps\_stealth_behavior::friendly_logic(var_0);
      break;
    case "axis":
      thread maps\_stealth_behavior::enemy_logic(var_0, var_1, var_2, var_3);
      break;
  }
}

stealth_enemy_waittill_alert() {
  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  level endon("_stealth_spotted");

  if(common_scripts\utility::flag("_stealth_found_corpse")) {
    return;
  }
  level endon("_stealth_found_corpse");
  self endon("_stealth_enemy_alert_level_change");
  waittillframeend;

  if(maps\_utility::ent_flag("_stealth_saw_corpse")) {
    return;
  }
  self endon("_stealth_saw_corpse");
  self waittill("event_awareness", var_0);
}

stealth_enemy_endon_alert() {
  stealth_enemy_waittill_alert();
  waittillframeend;
  self notify("stealth_enemy_endon_alert");
}

stealth_detect_ranges_set(var_0, var_1, var_2) {
  system_set_detect_ranges(var_0, var_1, var_2);
}

stealth_detect_ranges_default() {
  system_default_detect_ranges();
}

stealth_friendly_movespeed_scale_set(var_0, var_1, var_2) {
  friendly_set_movespeed_scale(var_0, var_1, var_2);
}

stealth_friendly_movespeed_scale_default() {
  friendly_default_movespeed_scale();
}

stealth_friendly_stance_handler_distances_set(var_0, var_1) {
  maps\_stealth_behavior::friendly_set_stance_handler_distances(var_0, var_1);
}

stealth_friendly_stance_handler_distances_default() {
  maps\_stealth_behavior::friendly_default_stance_handler_distances();
}

stealth_ai_state_functions_set(var_0) {
  switch (self.team) {
    case "allies":
      maps\_stealth_behavior::ai_change_ai_functions("state", var_0);
    case "axis":
      maps\_stealth_behavior::ai_change_ai_functions("state", var_0);
  }
}

stealth_ai_state_functions_default() {
  switch (self.team) {
    case "allies":
      maps\_stealth_behavior::friendly_default_ai_functions("state");
    case "axis":
      maps\_stealth_behavior::enemy_default_ai_functions("state");
  }
}

stealth_ai_alert_functions_set(var_0) {
  if(self.team == "allies") {
    return;
  }
  maps\_stealth_behavior::ai_change_ai_functions("alert", var_0);
}

stealth_ai_alert_functions_default() {
  if(self.team == "allies") {
    return;
  }
  maps\_stealth_behavior::enemy_default_ai_functions("alert");
}

stealth_ai_corpse_functions_set(var_0) {
  if(self.team == "allies") {
    return;
  }
  maps\_stealth_behavior::ai_change_ai_functions("corpse", var_0);
}

stealth_ai_corpse_functions_default() {
  if(self.team == "allies") {
    return;
  }
  maps\_stealth_behavior::enemy_default_ai_functions("corpse");
}

stealth_ai_awareness_functions_set(var_0) {
  if(self.team == "allies") {
    return;
  }
  maps\_stealth_behavior::ai_change_ai_functions("awareness", var_0);
}

stealth_ai_awareness_functions_default() {
  if(self.team == "allies") {
    return;
  }
  maps\_stealth_behavior::enemy_default_ai_functions("awareness");
}

stealth_ai_clear_custom_idle_and_react() {
  maps\_stealth_behavior::ai_clear_custom_animation_reaction_and_idle();
}

stealth_ai_clear_custom_react() {
  maps\_stealth_behavior::ai_clear_custom_animation_reaction();
}

stealth_ai_idle_and_react(var_0, var_1, var_2, var_3) {
  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  var_4 = "stop_loop";
  var_0.allowdeath = 1;
  var_0 stealth_insure_enabled();
  thread maps\_anim::anim_generic_loop(var_0, var_1, var_3, var_4);
  var_0 maps\_stealth_behavior::ai_set_custom_animation_reaction(self, var_2, var_3, var_4);
}

stealth_ai_reach_idle_and_react(var_0, var_1, var_2, var_3, var_4) {
  var_0 stealth_insure_enabled();
  thread stealth_ai_reach_idle_and_react_proc(var_0, var_1, var_2, var_3, var_4);
}

stealth_ai_reach_idle_and_react_proc(var_0, var_1, var_2, var_3, var_4) {
  var_0 thread stealth_enemy_endon_alert();
  var_0 endon("stealth_enemy_endon_alert");
  var_0 endon("death");
  var_0 stealth_insure_enabled();
  maps\_anim::anim_generic_reach(var_0, var_1, var_4);
  stealth_ai_idle_and_react(var_0, var_2, var_3, var_4);
}

stealth_ai_reach_and_arrive_idle_and_react(var_0, var_1, var_2, var_3, var_4) {
  var_0 stealth_insure_enabled();
  thread stealth_ai_reach_and_arrive_idle_and_react_proc(var_0, var_1, var_2, var_3, var_4);
}

stealth_ai_reach_and_arrive_idle_and_react_proc(var_0, var_1, var_2, var_3, var_4) {
  var_0 thread stealth_enemy_endon_alert();
  var_0 endon("stealth_enemy_endon_alert");
  var_0 endon("death");
  var_0 stealth_insure_enabled();
  maps\_anim::anim_generic_reach_and_arrive(var_0, var_1, var_4);
  stealth_ai_idle_and_react(var_0, var_2, var_3, var_4);
}

stealth_insure_enabled() {
  if(isdefined(self._stealth)) {
    return;
  }
  thread stealth_ai();
}