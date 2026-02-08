/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_logic.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;

stealth_init() {
  system_init();
  thread system_message_loop();
}

system_set_detect_ranges(hidden, alert, spotted) {
  if(isDefined(hidden)) {
    level._stealth.logic.detect_range["hidden"]["prone"] = hidden["prone"];
    level._stealth.logic.detect_range["hidden"]["crouch"] = hidden["crouch"];
    level._stealth.logic.detect_range["hidden"]["stand"] = hidden["stand"];
  }
  if(isDefined(alert)) {
    level._stealth.logic.detect_range["alert"]["prone"] = alert["prone"];
    level._stealth.logic.detect_range["alert"]["crouch"] = alert["crouch"];
    level._stealth.logic.detect_range["alert"]["stand"] = alert["stand"];
  }
  if(isDefined(spotted)) {
    level._stealth.logic.detect_range["spotted"]["prone"] = spotted["prone"];
    level._stealth.logic.detect_range["spotted"]["crouch"] = spotted["crouch"];
    level._stealth.logic.detect_range["spotted"]["stand"] = spotted["stand"];
  }
}

system_default_detect_ranges() {
  hidden = [];
  hidden["prone"] = 70;
  hidden["crouch"] = 600;
  hidden["stand"] = 1024;

  alert = [];
  alert["prone"] = 140;
  alert["crouch"] = 900;
  alert["stand"] = 1500;

  spotted = [];
  spotted["prone"] = 512;
  spotted["crouch"] = 5000;
  spotted["stand"] = 8000;

  system_set_detect_ranges(hidden, alert, spotted);
}

friendly_default_movespeed_scale() {
  hidden = [];
  hidden["prone"] = 3;
  hidden["crouch"] = 2;
  hidden["stand"] = 2;

  alert = [];
  alert["prone"] = 2;
  alert["crouch"] = 2;
  alert["stand"] = 2;

  spotted = [];
  spotted["prone"] = 2;
  spotted["crouch"] = 2;
  spotted["stand"] = 2;

  self friendly_set_movespeed_scale(hidden, alert, spotted);
}

friendly_set_movespeed_scale(hidden, alert, spotted, shadow) {
  if(isDefined(hidden)) {
    self._stealth.logic.movespeed_scale["hidden"]["prone"] = hidden["prone"];
    self._stealth.logic.movespeed_scale["hidden"]["crouch"] = hidden["crouch"];
    self._stealth.logic.movespeed_scale["hidden"]["stand"] = hidden["stand"];
  }
  if(isDefined(alert)) {
    self._stealth.logic.movespeed_scale["alert"]["prone"] = alert["prone"];
    self._stealth.logic.movespeed_scale["alert"]["crouch"] = alert["crouch"];
    self._stealth.logic.movespeed_scale["alert"]["stand"] = alert["stand"];
  }
  if(isDefined(spotted)) {
    self._stealth.logic.movespeed_scale["spotted"]["prone"] = spotted["prone"];
    self._stealth.logic.movespeed_scale["spotted"]["crouch"] = spotted["crouch"];
    self._stealth.logic.movespeed_scale["spotted"]["stand"] = spotted["stand"];
  }
}

system_init() {
  flag_init("_stealth_hidden");
  flag_init("_stealth_alert");
  flag_init("_stealth_spotted");
  flag_init("_stealth_found_corpse");

  flag_set("_stealth_hidden");

  level._stealth = spawnStruct();
  level._stealth.logic = spawnStruct();

  level._stealth.logic.detection_level = "hidden";
  level._stealth.logic.detect_range = [];
  level._stealth.logic.detect_range["alert"] = [];
  level._stealth.logic.detect_range["hidden"] = [];
  level._stealth.logic.detect_range["spotted"] = [];
  system_default_detect_ranges();

  level._stealth.logic.corpse = spawnStruct();
  level._stealth.logic.corpse.array = [];
  level._stealth.logic.corpse.last_pos = undefined;
  level._stealth.logic.corpse.max_num = int(getDvar("ai_corpseCount"));
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
  level._stealth.logic.ai_event["ai_eventDistDeath"]["spotted"] = getDvar("ai_eventDistDeath");
  level._stealth.logic.ai_event["ai_eventDistDeath"]["alert"] = 512;
  level._stealth.logic.ai_event["ai_eventDistDeath"]["hidden"] = 256;

  level._stealth.logic.ai_event["ai_eventDistPain"] = [];
  level._stealth.logic.ai_event["ai_eventDistPain"]["spotted"] = getDvar("ai_eventDistPain");
  level._stealth.logic.ai_event["ai_eventDistPain"]["alert"] = 384;
  level._stealth.logic.ai_event["ai_eventDistPain"]["hidden"] = 256;

  level._stealth.logic.ai_event["ai_eventDistExplosion"] = [];
  level._stealth.logic.ai_event["ai_eventDistExplosion"]["spotted"] = 4000;
  level._stealth.logic.ai_event["ai_eventDistExplosion"]["alert"] = 4000;
  level._stealth.logic.ai_event["ai_eventDistExplosion"]["hidden"] = 4000;

  level._stealth.logic.ai_event["ai_eventDistBullet"] = [];
  level._stealth.logic.ai_event["ai_eventDistBullet"]["spotted"] = getDvar("ai_eventDistBullet");
  level._stealth.logic.ai_event["ai_eventDistBullet"]["alert"] = 64;
  level._stealth.logic.ai_event["ai_eventDistBullet"]["hidden"] = 64;

  level._stealth.logic.ai_event["ai_eventDistFootstep"] = [];
  level._stealth.logic.ai_event["ai_eventDistFootstep"]["spotted"] = getDvar("ai_eventDistFootstep");
  level._stealth.logic.ai_event["ai_eventDistFootstep"]["alert"] = 64;
  level._stealth.logic.ai_event["ai_eventDistFootstep"]["hidden"] = 64;

  level._stealth.logic.ai_event["ai_eventDistFootstepLite"] = [];
  level._stealth.logic.ai_event["ai_eventDistFootstepLite"]["spotted"] = getDvar("ai_eventDistFootstepLite");
  level._stealth.logic.ai_event["ai_eventDistFootstepLite"]["alert"] = 32;
  level._stealth.logic.ai_event["ai_eventDistFootstepLite"]["hidden"] = 32;

  level._stealth.logic.system_state_functions = [];
  level._stealth.logic.system_state_functions["hidden"] = ::system_state_hidden;
  level._stealth.logic.system_state_functions["alert"] = ::system_state_alert;
  level._stealth.logic.system_state_functions["spotted"] = ::system_state_spotted;

  anim.eventActionMinWait["threat"]["self"] = 20000;
  anim.eventActionMinWait["threat"]["squad"] = 30000;

  system_init_shadows();
}

system_init_shadows() {
  array_thread(getEntArray("_stealth_shadow", "targetname"), ::stealth_shadow_volumes);
  array_thread(getEntArray("stealth_shadow", "targetname"), ::stealth_shadow_volumes);
}

stealth_shadow_volumes() {
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  self endon("death");

  while(1) {
    self waittill("trigger", other);

    if(!isalive(other)) {
      continue;
    }
    if(other ent_flag("_stealth_in_shadow")) {
      continue;
    }
    other thread stealth_shadow_ai_in_volume(self);
  }
}

system_message_loop() {
  funcs = level._stealth.logic.system_state_functions;
  thread system_message_handler("_stealth_hidden", "hidden", funcs["hidden"]);
  thread system_message_handler("_stealth_alert", "alert", funcs["alert"]);
  thread system_message_handler("_stealth_spotted", "spotted", funcs["spotted"]);
}

system_message_handler(_flag, detection_level, function) {
  level endon("_stealth_stop_stealth_logic");

  while(1) {
    flag_wait(_flag);
    system_event_change(detection_level);
    level._stealth.logic.detection_level = detection_level;
    level notify("_stealth_detection_level_change");
    thread[[function]]();

    flag_waitopen(_flag);
  }
}
system_event_change(name) {
  keys = getarraykeys(level._stealth.logic.ai_event);
  for(i = 0; i < keys.size; i++) {
    key = keys[i];
    setsaveddvar(key, level._stealth.logic.ai_event[key][name]);
  }
}
system_state_spotted() {
  flag_clear("_stealth_hidden");
  flag_clear("_stealth_alert");

  level endon("_stealth_detection_level_change");
  level endon("_stealth_stop_stealth_logic");

  waittillframeend;

  ai = getaispeciesarray("axis", "all");
  while(ai.size) {
    clear = true;
    ai = getaispeciesarray("axis", "all");
    for(i = 0; i < ai.size; i++) {
      if(isalive(ai[i].enemy)) {
        clear = false;
        break;
      }
    }

    if(clear) {
      wait 1;

      ai = getaispeciesarray("axis", "all");
      for(i = 0; i < ai.size; i++) {
        if(isalive(ai[i].enemy)) {
          clear = false;
          break;
        }
      }
    }

    if(clear) {
      break;
    }

    wait .1;
    ai = getaispeciesarray("axis", "all");
  }
  flag_clear("_stealth_spotted");
  flag_set("_stealth_alert");
}
system_state_alert() {
  flag_clear("_stealth_hidden");

  level endon("_stealth_detection_level_change");
  level endon("_stealth_stop_stealth_logic");

  waittillframeend;

  count = 15;
  interval = .1;

  while(count > 0) {
    ai = getaispeciesarray("axis", "all");
    if(!ai.size) {
      break;
    }

    wait interval;
    count -= interval;
  }

  flag_waitopen("_stealth_found_corpse");
  flag_clear("_stealth_spotted");
  flag_clear("_stealth_alert");
  flag_set("_stealth_hidden");
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

  self friendly_init();

  current_stance_func = self._stealth.logic.current_stance_func;

  if(isPlayer(self))
    self thread friendly_movespeed_calc_loop();

  while(1) {
    self[[current_stance_func]]();

    self.maxVisibleDist = self friendly_compute_score();

    wait .05;
  }
}

friendly_init() {
  assertex(!isDefined(self._stealth), "you called maps\_stealth_logic::friendly_init() twice on the same ai or player");

  self._stealth = spawnStruct();
  self._stealth.logic = spawnStruct();

  if(isPlayer(self)) {
    self._stealth.logic.getstance_func = ::friendly_getstance_player;
    self._stealth.logic.getangles_func = ::friendly_getangles_player;
    if(level.Console)
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

  self._stealth.logic.stance_change_time = .2;
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

  self ent_flag_init("_stealth_in_shadow");
}

friendly_getvelocity() {
  return length(self getVelocity());
}

player_getvelocity_pc() {
  velocity = length(self getVelocity());

  stance = self._stealth.logic.stance;

  add = [];
  add["stand"] = 30;
  add["crouch"] = 15;
  add["prone"] = 4;

  sub = [];
  sub["stand"] = 40;
  sub["crouch"] = 25;
  sub["prone"] = 10;

  if(!velocity)
    self._stealth.logic.player_pc_velocity = 0;
  else if(velocity > self._stealth.logic.player_pc_velocity) {
    self._stealth.logic.player_pc_velocity += add[stance];
    if(self._stealth.logic.player_pc_velocity > velocity)
      self._stealth.logic.player_pc_velocity = velocity;
  } else if(velocity < self._stealth.logic.player_pc_velocity) {
    self._stealth.logic.player_pc_velocity -= sub[stance];
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

  angles_func = self._stealth.logic.getangles_func;
  velocity_func = self._stealth.logic.getvelocity_func;
  oldangles = self[[angles_func]]();

  while(1) {
    score = undefined;

    if(self ent_flag("_stealth_in_shadow")) {
      score = 0;
    } else {
      score_move = self[[velocity_func]]();
      score_turn = length(oldangles - self[[angles_func]]());
      if(score_turn > 30)
        score_turn = 30;

      score = score_move + score_turn;
    }

    self._stealth.logic.movespeed_multiplier["hidden"]["prone"] = (score) * self._stealth.logic.movespeed_scale["hidden"]["prone"];
    self._stealth.logic.movespeed_multiplier["spotted"]["prone"] = (score) * self._stealth.logic.movespeed_scale["spotted"]["prone"];
    self._stealth.logic.movespeed_multiplier["alert"]["prone"] = (score) * self._stealth.logic.movespeed_scale["alert"]["prone"];

    self._stealth.logic.movespeed_multiplier["hidden"]["crouch"] = (score) * self._stealth.logic.movespeed_scale["hidden"]["crouch"];
    self._stealth.logic.movespeed_multiplier["spotted"]["crouch"] = (score) * self._stealth.logic.movespeed_scale["spotted"]["crouch"];
    self._stealth.logic.movespeed_multiplier["alert"]["crouch"] = (score) * self._stealth.logic.movespeed_scale["alert"]["crouch"];

    self._stealth.logic.movespeed_multiplier["hidden"]["stand"] = (score) * self._stealth.logic.movespeed_scale["hidden"]["stand"];
    self._stealth.logic.movespeed_multiplier["spotted"]["stand"] = (score) * self._stealth.logic.movespeed_scale["spotted"]["stand"];
    self._stealth.logic.movespeed_multiplier["alert"]["stand"] = (score) * self._stealth.logic.movespeed_scale["alert"]["stand"];

    oldangles = self[[angles_func]]();
    wait .1;
  }
}

friendly_compute_score(stance) {
  if(!isDefined(stance))
    stance = self._stealth.logic.stance;

  detection_level = level._stealth.logic.detection_level;

  score_range = level._stealth.logic.detect_range[detection_level][stance];
  if(self ent_flag("_stealth_in_shadow")) {
    score_range *= .5;
    if(score_range < level._stealth.logic.detect_range["hidden"]["prone"])
      score_range = level._stealth.logic.detect_range["hidden"]["prone"];
  }
  score_move = self._stealth.logic.movespeed_multiplier[detection_level][stance];
  if(isDefined(self._stealth_move_detection_cap) && score_move > self._stealth_move_detection_cap)
    score_move = self._stealth_move_detection_cap;

  return (score_range + score_move);
}

friendly_getstance_ai() {
  return self.a.pose;
}

friendly_getstance_player() {
  players = get_players();
  return players[0] getstance();
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
  stance = self[[self._stealth.logic.getstance_func]]();

  if(!self._stealth.logic.stance_change) {
    switch (stance) {
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

    if(self._stealth.logic.stance_change > .05)
      self._stealth.logic.stance_change -= .05;
    else {
      self._stealth.logic.stance_change = 0;
      self._stealth.logic.stance = stance;
      self._stealth.logic.oldstance = stance;
    }
  } else {
    self._stealth.logic.stance = stance;
    self._stealth.logic.oldstance = stance;
  }
}

enemy_logic() {
  self enemy_init();

  self thread enemy_threat_logic();
  self thread enemy_corpse_logic();
}

enemy_init() {
  assertex(!isDefined(self._stealth), "you called maps\_stealth_logic::enemy_init() twice on the same ai");

  self clearenemy();
  self._stealth = spawnStruct();
  self._stealth.logic = spawnStruct();

  self._stealth.logic.dog = false;
  if(issubstr(self.classname, "dog"))
    self._stealth.logic.dog = true;

  self._stealth.logic.alert_level = spawnStruct();
  self._stealth.logic.alert_level.lvl = undefined;
  self._stealth.logic.alert_level.enemy = undefined;

  self._stealth.logic.stoptime = 0;

  self._stealth.logic.corpse = spawnStruct();
  self._stealth.logic.corpse.corpse_entity = undefined;

  self ent_flag_init("_stealth_saw_corpse");
  self ent_flag_init("_stealth_found_corpse");

  self enemy_event_listeners_init();

  self ent_flag_init("_stealth_in_shadow");
}
enemy_event_listeners_init() {
  self ent_flag_init("_stealth_bad_event_listener");

  self._stealth.logic.event = spawnStruct();
  self._stealth.logic.event.listener = [];

  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "grenade danger";
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "gunshot";
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "bulletwhizby";
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "silenced_shot";
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "projectile_impact";

  for(i = 0; i < self._stealth.logic.event.listener.size; i++)
    self addAIEventListener(self._stealth.logic.event.listener[i]);

  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "explode";
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "doFlashBanged";

  for(i = 0; i < self._stealth.logic.event.listener.size; i++)
    self thread enemy_event_listeners_logic(self._stealth.logic.event.listener[i]);

  self thread enemy_event_declare_to_team("damage", "ai_eventDistPain");
  self thread enemy_event_declare_to_team("death", "ai_eventDistDeath");
  self thread enemy_event_listeners_proc();

  self._stealth.logic.event.awareness = [];

  self thread enemy_event_awareness("reset");
  self thread enemy_event_awareness("alerted_once");
  self thread enemy_event_awareness("alerted_again");
  self thread enemy_event_awareness("attack");

  self thread enemy_event_awareness("heard_scream");
  self thread enemy_event_awareness("heard_corpse");
  self thread enemy_event_awareness("saw_corpse");
  self thread enemy_event_awareness("found_corpse");

  self thread enemy_event_awareness("explode");
  self thread enemy_event_awareness("doFlashBanged");
  self thread enemy_event_awareness("bulletwhizby");
  self thread enemy_event_awareness("projectile_impact");
}

enemy_event_listeners_logic(type) {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");

  while(1) {
    self waittill(type);
    self ent_flag_set("_stealth_bad_event_listener");
  }
}
enemy_event_listeners_proc() {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");

  while(1) {
    self ent_flag_wait("_stealth_bad_event_listener");

    wait .65;

    self ent_flag_clear("_stealth_bad_event_listener");
  }
}

enemy_event_awareness(type) {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  self._stealth.logic.event.awareness[type] = true;

  var = undefined;

  while(1) {
    self waittill(type, var1, var2);

    if(!self._stealth.logic.dog) {
      if(flag("_stealth_spotted") && (isDefined(self.enemy) || isDefined(self.favoriteenemy)))
        continue;
    }

    switch (type) {
      case "projectile_impact":
        var = var2;
        break;
      default:
        var = var1;
        break;
    }

    self._stealth.logic.event.awareness[type] =
      var;
    self notify("event_awareness", type);
    level notify("event_awareness", type);

    waittillframeend;

    if(!flag("_stealth_spotted") && type != "alerted_once")
      flag_set("_stealth_alert");
  }
}

enemy_event_declare_to_team(type, name) {
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");

  other = undefined;
  team = self.team;

  while(1) {
    if(!isalive(self)) {
      return;
    }
    self waittill(type, var1, var2);

    switch (type) {
      case "death":
        other = var1;
        break;
      case "damage":
        other = var2;
        break;
    }

    if(!isDefined(other)) {
      continue;
    }
    if(isPlayer(other) || (isDefined(other.team) && other.team != team)) {
      break;
    }
  }

  if(!isDefined(self)) {
    return;
  }

  ai = getaispeciesarray("axis", "all");

  check = int(level._stealth.logic.ai_event[name][level._stealth.logic.detection_level]);

  for(i = 0; i < ai.size; i++) {
    if(!isalive(ai[i]))
      continue;
    if(!isDefined(ai[i]._stealth))
      continue;
    if(distance(ai[i].origin, self.origin) > check) {
      continue;
    }
    ai[i] ent_flag_set("_stealth_bad_event_listener");
  }
}

enemy_threat_logic() {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");

  while(1) {
    self waittill("enemy");

    if(!isalive(self.enemy)) {
      continue;
    }
    if(!flag("_stealth_spotted") && !self._stealth.logic.dog) {
      if(!(self enemy_alert_level_logic(self.enemy)))
        continue;
    } else
      self enemy_alert_level_change("attack", self.enemy);

    self thread enemy_threat_set_spotted();

    wait 20;

    while(isDefined(self.enemy)) {
      if(distance(self.origin, self.enemy.origin) > self.maxVisibleDist)
        self clearenemy();

      wait .25;
    }

    enemy_alert_level_change("reset", undefined);
  }
}

enemy_threat_set_spotted() {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");

  wait randomfloatrange(.25, .5);

  flag_set("_stealth_spotted");
}

enemy_alert_level_logic(enemy) {
  if(!isDefined(enemy._stealth))
    return true;

  if(!isDefined(enemy._stealth.logic.spotted_list[self.ai_number]))
    enemy._stealth.logic.spotted_list[self.ai_number] = 0;

  if(!self._stealth.logic.stoptime)
    enemy._stealth.logic.spotted_list[self.ai_number]++;

  if(self ent_flag("_stealth_bad_event_listener") || enemy._stealth.logic.spotted_list[self.ai_number] > 2) {
    self enemy_alert_level_change("attack", enemy);
    return true;
  }

  self clearenemy();

  if(self._stealth.logic.stoptime)
    return false;

  switch (enemy._stealth.logic.spotted_list[self.ai_number]) {
    case 1:
      self enemy_alert_level_change("alerted_once", enemy);
      break;
    case 2:
      self enemy_alert_level_change("alerted_again", enemy);
      break;
  }

  self thread enemy_alert_level_forget(enemy);
  self thread enemy_alert_level_waittime(enemy);
  return false;
}

enemy_alert_level_forget(enemy) {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  wait 60;

  assertEX(enemy._stealth.logic.spotted_list[self.ai_number], "enemy._stealth.spotted_list[ self.ai_number ] is already 0 but being told to forget");
  enemy._stealth.logic.spotted_list[self.ai_number]--;
}

enemy_alert_level_waittime(enemy) {
  self endon("death");

  timefrac = distance(self.origin, enemy.origin) * .0005;
  self._stealth.logic.stoptime = .25 + timefrac;

  flag_wait_or_timeout("_stealth_spotted", self._stealth.logic.stoptime);

  self._stealth.logic.stoptime = 0;
}

enemy_alert_level_change(type, enemy) {
  level notify("_stealth_enemy_alert_level_change");
  self notify("_stealth_enemy_alert_level_change");
  self notify(type, enemy);

  self._stealth.logic.alert_level.lvl = type;
  self._stealth.logic.alert_level.enemy = enemy;
}

enemy_corpse_logic() {
  self thread enemy_corpse_death();

  if(self._stealth.logic.dog) {
    return;
  }
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");

  self thread enemy_corpse_found_loop();
  while(1) {
    while(!flag("_stealth_spotted")) {
      found = false;
      saw = false;
      corpse = undefined;

      for(i = 0; i < level._stealth.logic.corpse.array.size; i++) {
        corpse = level._stealth.logic.corpse.array[i];
        distsqrd = distancesquared(self.origin, corpse.origin);

        if(distsqrd < level._stealth.logic.corpse.found_distsqrd) {
          found = true;
          break;
        }

        if(isDefined(self._stealth.logic.corpse.corpse_entity)) {
          if(self._stealth.logic.corpse.corpse_entity == corpse) {
            continue;
          }
          distsqrd2 = distancesquared(self.origin, self._stealth.logic.corpse.corpse_entity.origin);
          if(distsqrd2 <= distsqrd)
            continue;
        }

        if(distsqrd > level._stealth.logic.corpse.sight_distsqrd) {
          continue;
        }
        if(distsqrd < level._stealth.logic.corpse.detect_distsqrd) {
          if(self cansee(corpse)) {
            saw = true;
            break;
          }
        }

        angles = self gettagangles("tag_eye");
        origin = self gettagorigin("tag_eye");

        sight = anglesToForward(angles);
        vec_to_corpse = vectornormalize(corpse.origin - origin);

        if(vectordot(sight, vec_to_corpse) > .55) {
          if(self cansee(corpse)) {
            saw = true;
            break;
          }
        }
      }
      if(found) {
        if(!ent_flag("_stealth_found_corpse"))
          self ent_flag_set("_stealth_found_corpse");
        else
          self notify("_stealth_found_corpse");

        self ent_flag_clear("_stealth_saw_corpse");

        self thread enemy_corpse_found(corpse);

        self notify("found_corpse", corpse);
      } else if(saw) {
        self._stealth.logic.corpse.corpse_entity = corpse;

        if(!ent_flag("_stealth_saw_corpse"))
          self ent_flag_set("_stealth_saw_corpse");
        else
          self notify("_stealth_saw_corpse");

        level notify("_stealth_saw_corpse");
        self notify("saw_corpse", corpse);
      }

      wait .05;
    }

    flag_waitopen("_stealth_spotted");
  }
}
enemy_corpse_death() {
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_corpse_logic");

  id = self.ai_number;

  self waittill("death");

  if(!isDefined(self.origin)) {
    return;
  }
  height = level._stealth.logic.corpse.corpse_height[level._stealth.logic.detection_level];
  offset = (0, 0, height);

  corpse = spawn("script_origin", self.origin + offset);

  corpse.targetname = "corpse";
  corpse.ai_number = id;
  corpse.script_noteworthy = corpse.targetname + "_" + corpse.ai_number;

  corpse endon("death");

  while(isDefined(self.origin)) {
    corpse.origin = self.origin + offset;
    wait .01;
  }

  if(level.cheatStates["sf_use_tire_explosion"])
    wait .25;

  corpse enemy_corpse_add_to_stack();
}

enemy_corpse_add_to_stack() {
  if(level._stealth.logic.corpse.array.size == level._stealth.logic.corpse.max_num)
    enemy_corpse_shorten_stack();

  level._stealth.logic.corpse.array[level._stealth.logic.corpse.array.size] = self;
}

enemy_corpse_shorten_stack() {
  array1 = [];
  array2 = level._stealth.logic.corpse.array;
  remove = level._stealth.logic.corpse.array[0];

  for(i = 1; i < level._stealth.logic.corpse.max_num; i++)
    array1[array1.size] = array2[i];

  level._stealth.logic.corpse.array = array1;

  remove delete();
}

enemy_corpse_found(corpse) {
  level._stealth.logic.corpse.last_pos = corpse.origin;
  level._stealth.logic.corpse.array = array_remove(level._stealth.logic.corpse.array, corpse);

  if(isDefined(self.no_corpse_announce)) {
    level notify("_stealth_no_corpse_announce");
    self notify("event_awareness", "found_corpse");
    return;
  }

  wait randomfloatrange(.25, .5);

  if(!flag("_stealth_found_corpse"))
    flag_set("_stealth_found_corpse");
  else
    level notify("_stealth_found_corpse");

  thread enemy_corpse_clear();
}

enemy_corpse_found_loop() {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");

  while(1) {
    level waittill("_stealth_found_corpse");

    if(!flag("_stealth_found_corpse")) {
      continue;
    }
    self enemy_corpse_alert_level();
  }
}

enemy_corpse_alert_level() {
  enemy = undefined;

  if(isDefined(self.enemy))
    enemy = self.enemy;
  else {
    enemy = get_closest_player(self.origin);
  }

  if(!isDefined(enemy._stealth.logic.spotted_list[self.ai_number]))
    enemy._stealth.logic.spotted_list[self.ai_number] = 0;

  switch (enemy._stealth.logic.spotted_list[self.ai_number]) {
    case 0:
      enemy._stealth.logic.spotted_list[self.ai_number]++;
      self thread enemy_alert_level_forget(enemy);
      break;
    case 1:
      enemy._stealth.logic.spotted_list[self.ai_number]++;
      self thread enemy_alert_level_forget(enemy);
      break;
    case 2:
      enemy._stealth.logic.spotted_list[self.ai_number]++;
      self thread enemy_alert_level_forget(enemy);
      break;
  }
  flag_set("_stealth_alert");
}

enemy_corpse_clear() {
  level endon("_stealth_found_corpse");
  level endon("_stealth_stop_stealth_logic");

  waittill_dead_or_dying(getaiarray("axis"), undefined, 90);

  flag_clear("_stealth_found_corpse");
}

stealth_shadow_ai_in_volume(volume) {
  self endon("death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");

  self ent_flag_set("_stealth_in_shadow");

  while(self istouching(volume))
    wait .05;

  self ent_flag_clear("_stealth_in_shadow");
}

stealth_ai(state_functions, alert_functions, corpse_functions, awareness_functions) {
  assertex(isDefined(level._stealth.logic), "call maps\_stealth_logic::main() before calling stealth_ai()");

  self stealth_ai_logic();
  self stealth_ai_behavior(state_functions, alert_functions, corpse_functions, awareness_functions);
}

stealth_ai_logic() {
  assertex(isDefined(level._stealth.logic), "call maps\_stealth_logic::main() before calling stealth_ai_logic()");

  switch (self.team) {
    case "allies":
      self thread maps\_stealth_logic::friendly_logic();
      break;
    case "axis":
      self thread maps\_stealth_logic::enemy_logic();
      break;
  }
}

stealth_ai_behavior(state_functions, alert_functions, corpse_functions, awareness_functions) {
  assertex(isDefined(level._stealth.behavior), "call maps\_stealth_behavior::main() before calling stealth_ai_behavior()");

  if(isPlayer(self)) {
    return;
  }
  switch (self.team) {
    case "allies":
      self thread maps\_stealth_behavior::friendly_logic(state_functions);
      break;
    case "axis":
      self thread maps\_stealth_behavior::enemy_logic(state_functions, alert_functions, corpse_functions, awareness_functions);
      break;
  }
}

stealth_enemy_waittill_alert() {
  if(flag("_stealth_spotted"))
    return;
  level endon("_stealth_spotted");

  if(flag("_stealth_found_corpse"))
    return;
  level endon("_stealth_found_corpse");

  self endon("_stealth_enemy_alert_level_change");

  waittillframeend;

  if(self ent_flag("_stealth_saw_corpse"))
    return;
  self endon("_stealth_saw_corpse");

  self waittill("event_awareness", type);
}

stealth_enemy_endon_alert() {
  stealth_enemy_waittill_alert();
  waittillframeend;
  self notify("stealth_enemy_endon_alert");
}

stealth_detect_ranges_set(hidden, alert, spotted) {
  maps\_stealth_logic::system_set_detect_ranges(hidden, alert, spotted);
}

stealth_detect_ranges_default() {
  maps\_stealth_logic::system_default_detect_ranges();
}

stealth_friendly_movespeed_scale_set(hidden, alert, spotted) {
  self maps\_stealth_logic::friendly_set_movespeed_scale(hidden, alert, spotted);
}

stealth_friendly_movespeed_scale_default() {
  self maps\_stealth_logic::friendly_default_movespeed_scale();
}

stealth_friendly_stance_handler_distances_set(hidden, alert) {
  self maps\_stealth_behavior::friendly_set_stance_handler_distances(hidden, alert);
}

stealth_friendly_stance_handler_distances_default() {
  self maps\_stealth_behavior::friendly_default_stance_handler_distances();
}

stealth_ai_state_functions_set(state_functions) {
  switch (self.team) {
    case "allies":
      self maps\_stealth_behavior::ai_change_ai_functions("state", state_functions);
    case "axis":
      self maps\_stealth_behavior::ai_change_ai_functions("state", state_functions);
  }
}

stealth_ai_state_functions_default() {
  switch (self.team) {
    case "allies":
      self maps\_stealth_behavior::friendly_default_ai_functions("state");
    case "axis":
      self maps\_stealth_behavior::enemy_default_ai_functions("state");
  }
}

stealth_ai_alert_functions_set(alert_functions) {
  if(self.team == "allies") {
    assertMsg("stealth_ai_alert_functions_set should only be called on enemies");
    return;
  }
  self maps\_stealth_behavior::ai_change_ai_functions("alert", alert_functions);
}

stealth_ai_alert_functions_default() {
  if(self.team == "allies") {
    assertMsg("stealth_ai_alert_functions_default should only be called on enemies");
    return;
  }

  self maps\_stealth_behavior::enemy_default_ai_functions("alert");
}

stealth_ai_corpse_functions_set(corpse_functions) {
  if(self.team == "allies") {
    assertMsg("stealth_ai_corpse_functions_set should only be called on enemies");
    return;
  }
  self maps\_stealth_behavior::ai_change_ai_functions("corpse", corpse_functions);
}

stealth_ai_corpse_functions_default() {
  if(self.team == "allies") {
    assertMsg("stealth_ai_corpse_functions_default should only be called on enemies");
    return;
  }
  self maps\_stealth_behavior::enemy_default_ai_functions("corpse");
}

stealth_ai_awareness_functions_set(awareness_functions) {
  if(self.team == "allies") {
    assertMsg("stealth_ai_awareness_functions_set should only be called on enemies");
    return;
  }
  self maps\_stealth_behavior::ai_change_ai_functions("awareness", awareness_functions);
}

stealth_ai_awareness_functions_default() {
  if(self.team == "allies") {
    assertMsg("stealth_ai_awareness_functions_default should only be called on enemies");
    return;
  }
  self maps\_stealth_behavior::enemy_default_ai_functions("awareness");
}

stealth_ai_clear_custom_idle_and_react() {
  self maps\_stealth_behavior::ai_clear_custom_animation_reaction_and_idle();
}

stealth_ai_clear_custom_react() {
  self maps\_stealth_behavior::ai_clear_custom_animation_reaction();
}

stealth_ai_idle_and_react(guy, idle_anim, reaction_anim, tag) {
  if(flag("_stealth_spotted")) {
    return;
  }
  ender = "stop_loop";

  guy.allowdeath = true;
  guy stealth_insure_enabled();
  self thread maps\_anim::anim_generic_loop(guy, idle_anim, tag, ender);
  guy maps\_stealth_behavior::ai_set_custom_animation_reaction(self, reaction_anim, tag, ender);
}

stealth_ai_reach_idle_and_react(guy, reach_anim, idle_anim, reaction_anim, tag) {
  guy stealth_insure_enabled();
  self thread stealth_ai_reach_idle_and_react_proc(guy, reach_anim, idle_anim, reaction_anim, tag);
}

stealth_ai_reach_idle_and_react_proc(guy, reach_anim, idle_anim, reaction_anim, tag) {
  guy thread stealth_enemy_endon_alert();
  guy endon("stealth_enemy_endon_alert");
  guy endon("death");

  guy stealth_insure_enabled();
  self maps\_anim::anim_generic_reach(guy, reach_anim, tag);
  stealth_ai_idle_and_react(guy, idle_anim, reaction_anim, tag);
}

stealth_ai_reach_and_arrive_idle_and_react(guy, reach_anim, idle_anim, reaction_anim, tag) {
  guy stealth_insure_enabled();
  self thread stealth_ai_reach_and_arrive_idle_and_react_proc(guy, reach_anim, idle_anim, reaction_anim, tag);
}

stealth_ai_reach_and_arrive_idle_and_react_proc(guy, reach_anim, idle_anim, reaction_anim, tag) {
  guy thread stealth_enemy_endon_alert();
  guy endon("stealth_enemy_endon_alert");
  guy endon("death");

  guy stealth_insure_enabled();
  self maps\_anim::anim_generic_reach_and_arrive(guy, reach_anim, tag);
  stealth_ai_idle_and_react(guy, idle_anim, reaction_anim, tag);
}

stealth_insure_enabled() {
  if(isDefined(self._stealth))
    return;
  self thread stealth_ai();
}