/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_logic.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_foliage_cover;
#include maps\_stealth_logic;
#include maps\_stealth_behavior;

stealth_init(enviroment) {
  system_init(enviroment);
  thread system_message_loop();

  if(isDefined(enviroment)) {
    switch (enviroment) {
      case "foliage":
        level._stealth.enviroment[level._stealth.enviroment.size] = "foliage";
        maps\_foliage_cover::init_foliage_cover();
        break;
    }
  }

  array_thread(getentarray("stealth_clipbrush", "targetname"), ::system_handle_clipbrush);

  level thread debug_stealth();
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

friendly_set_movespeed_scale(hidden, alert, spotted) {
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

system_init(enviroment) {
  flag_init("_stealth_hidden");
  flag_init("_stealth_alert");
  flag_init("_stealth_spotted");
  flag_init("_stealth_found_corpse");
  flag_set("_stealth_hidden");
  level._stealth = spawnstruct();
  level._stealth.logic = spawnstruct();

  if(!isDefined(enviroment))
    enviroment = "default";

  level._stealth.enviroment = [];
  level._stealth.environment[0] = enviroment;
  level._stealth.logic.detection_level = "hidden";
  level._stealth.logic.detect_range = [];
  level._stealth.logic.detect_range["alert"] = [];
  level._stealth.logic.detect_range["hidden"] = [];
  level._stealth.logic.detect_range["spotted"] = [];
  system_default_detect_ranges();
  system_default_corpse_detect_ranges();
  level._stealth.logic.ai_event = [];
  level._stealth.logic.ai_event["ai_eventDistDeath"] = [];
  level._stealth.logic.ai_event["ai_eventDistDeath"]["spotted"] = getdvar(#"ai_eventDistDeath");
  level._stealth.logic.ai_event["ai_eventDistDeath"]["alert"] = 512;
  level._stealth.logic.ai_event["ai_eventDistDeath"]["hidden"] = 256;
  level._stealth.logic.ai_event["ai_eventDistPain"] = [];
  level._stealth.logic.ai_event["ai_eventDistPain"]["spotted"] = getdvar(#"ai_eventDistPain");
  level._stealth.logic.ai_event["ai_eventDistPain"]["alert"] = 384;
  level._stealth.logic.ai_event["ai_eventDistPain"]["hidden"] = 256;
  level._stealth.logic.ai_event["ai_eventDistExplosion"] = [];
  level._stealth.logic.ai_event["ai_eventDistExplosion"]["spotted"] = 4000;
  level._stealth.logic.ai_event["ai_eventDistExplosion"]["alert"] = 4000;
  level._stealth.logic.ai_event["ai_eventDistExplosion"]["hidden"] = 4000;
  level._stealth.logic.ai_event["ai_eventDistBullet"] = [];
  level._stealth.logic.ai_event["ai_eventDistBullet"]["spotted"] = getdvar(#"ai_eventDistBullet");
  level._stealth.logic.ai_event["ai_eventDistBullet"]["alert"] = 64;
  level._stealth.logic.ai_event["ai_eventDistBullet"]["hidden"] = 64;
  level._stealth.logic.ai_event["ai_eventDistFootstep"] = [];
  level._stealth.logic.ai_event["ai_eventDistFootstep"]["spotted"] = getdvar(#"ai_eventDistFootstep");
  level._stealth.logic.ai_event["ai_eventDistFootstep"]["alert"] = 64;
  level._stealth.logic.ai_event["ai_eventDistFootstep"]["hidden"] = 64;
  level._stealth.logic.ai_event["ai_eventDistFootstepLite"] = [];
  level._stealth.logic.ai_event["ai_eventDistFootstepLite"]["spotted"] = getdvar(#"ai_eventDistFootstepLite");
  level._stealth.logic.ai_event["ai_eventDistFootstepLite"]["alert"] = 32;
  level._stealth.logic.ai_event["ai_eventDistFootstepLite"]["hidden"] = 32;
  level._stealth.logic.system_state_functions = [];
  level._stealth.logic.system_state_functions["hidden"] = ::system_state_hidden;
  level._stealth.logic.system_state_functions["alert"] = ::system_state_alert;
  level._stealth.logic.system_state_functions["spotted"] = ::system_state_spotted;
  anim.eventactionminwait["threat"]["self"] = 20000;
  anim.eventactionminwait["threat"]["squad"] = 30000;
  system_init_shadows();
}

system_default_corpse_detect_ranges() {
  level._stealth.logic.corpse = spawnstruct();
  level._stealth.logic.corpse.array = [];
  level._stealth.logic.corpse.last_pos = undefined;
  level._stealth.logic.corpse.max_num = int(getdvar(#"ai_corpseCount"));
  level._stealth.logic.corpse.sight_dist = 256;
  level._stealth.logic.corpse.detect_dist = 128;
  level._stealth.logic.corpse.found_dist = 64;
  level._stealth.logic.corpse.sight_distsqrd = level._stealth.logic.corpse.sight_dist * level._stealth.logic.corpse.sight_dist;
  level._stealth.logic.corpse.detect_distsqrd = level._stealth.logic.corpse.detect_dist * level._stealth.logic.corpse.detect_dist;
  level._stealth.logic.corpse.found_distsqrd = level._stealth.logic.corpse.found_dist * level._stealth.logic.corpse.found_dist;
  level._stealth.logic.corpse.corpse_height = [];
  level._stealth.logic.corpse.corpse_height["spotted"] = 10;
  level._stealth.logic.corpse.corpse_height["alert"] = 10;
  level._stealth.logic.corpse.corpse_height["hidden"] = 6;
}

system_init_shadows() {
  array_thread(getentarray("_stealth_shadow", "targetname"), ::stealth_shadow_volumes);
  array_thread(getentarray("stealth_shadow", "targetname"), ::stealth_shadow_volumes);
}

stealth_shadow_volumes() {
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  self endon("death");

  while(true) {
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

  while(true) {
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

  for(ai = getaispeciesarray("axis", "all"); ai.size; ai = getaispeciesarray("axis", "all")) {
    clear = 1;
    ai = getaispeciesarray("axis", "all");

    for(i = 0; i < ai.size; i++) {
      if(isalive(ai[i].enemy)) {
        clear = 0;
        break;
      }
    }

    if(clear) {
      wait 1;
      ai = getaispeciesarray("axis", "all");

      for(i = 0; i < ai.size; i++) {
        if(isalive(ai[i].enemy)) {
          clear = 0;
          break;
        }
      }
    }

    if(clear) {
      break;
    }

    wait 0.1;
  }

  flag_clear("_stealth_spotted");
  flag_set("_stealth_alert");
}

system_state_alert() {
  flag_clear("_stealth_hidden");
  level endon("_stealth_detection_level_change");
  level endon("_stealth_stop_stealth_logic");
  waittillframeend;

  for(count = 15; count > 0; count = count - 0.1) {
    ai = getaispeciesarray("axis", "all");

    if(!ai.size) {
      break;
    }

    wait 0.1;
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

  if(isplayer(self))
    self thread friendly_movespeed_calc_loop();

  while(true) {
    self[[current_stance_func]]();
    self.maxvisibledist = self friendly_compute_score();
    wait 0.05;
  }
}

friendly_init() {
  assert(!isDefined(self._stealth), "you called maps_stealth_logic::friendly_init() twice on the same ai or player");
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

  if(self ent_flag_exist("_stealth_in_shadow"))
    self ent_flag_clear("_stealth_in_shadow");
  else
    self ent_flag_init("_stealth_in_shadow");

  if(self ent_flag_exist("_stealth_in_foliage"))
    self ent_flag_clear("_stealth_in_foliage");
  else
    self ent_flag_init("_stealth_in_foliage");
}

friendly_getvelocity() {
  return length(self getvelocity());
}

player_getvelocity_pc() {
  velocity = length(self getvelocity());
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
    self._stealth.logic.player_pc_velocity = self._stealth.logic.player_pc_velocity + add[stance];

    if(self._stealth.logic.player_pc_velocity > velocity)
      self._stealth.logic.player_pc_velocity = velocity;
  } else if(velocity < self._stealth.logic.player_pc_velocity) {
    self._stealth.logic.player_pc_velocity = self._stealth.logic.player_pc_velocity - sub[stance];

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

  while(true) {
    score = undefined;

    if(self ent_flag("_stealth_in_shadow"))
      score = 0;
    else {
      score_move = self[[velocity_func]]();
      score_turn = length(oldangles - self[[angles_func]]());

      if(score_turn > 30)
        score_turn = 30;

      score = score_move + score_turn;
    }

    self._stealth.logic.movespeed_multiplier["hidden"]["prone"] = score * self._stealth.logic.movespeed_scale["hidden"]["prone"];
    self._stealth.logic.movespeed_multiplier["spotted"]["prone"] = score * self._stealth.logic.movespeed_scale["spotted"]["prone"];
    self._stealth.logic.movespeed_multiplier["alert"]["prone"] = score * self._stealth.logic.movespeed_scale["alert"]["prone"];
    self._stealth.logic.movespeed_multiplier["hidden"]["crouch"] = score * self._stealth.logic.movespeed_scale["hidden"]["crouch"];
    self._stealth.logic.movespeed_multiplier["spotted"]["crouch"] = score * self._stealth.logic.movespeed_scale["spotted"]["crouch"];
    self._stealth.logic.movespeed_multiplier["alert"]["crouch"] = score * self._stealth.logic.movespeed_scale["alert"]["crouch"];
    self._stealth.logic.movespeed_multiplier["hidden"]["stand"] = score * self._stealth.logic.movespeed_scale["hidden"]["stand"];
    self._stealth.logic.movespeed_multiplier["spotted"]["stand"] = score * self._stealth.logic.movespeed_scale["spotted"]["stand"];
    self._stealth.logic.movespeed_multiplier["alert"]["stand"] = score * self._stealth.logic.movespeed_scale["alert"]["stand"];
    oldangles = self[[angles_func]]();
    wait 0.1;
  }
}

friendly_compute_score(stance) {
  if(!isDefined(stance))
    stance = self._stealth.logic.stance;

  detection_level = level._stealth.logic.detection_level;
  score_range = level._stealth.logic.detect_range[detection_level][stance];

  if(self ent_flag("_stealth_in_shadow")) {
    score_range = score_range * 0.5;

    if(score_range < level._stealth.logic.detect_range["hidden"]["prone"])
      score_range = level._stealth.logic.detect_range["hidden"]["prone"];
  }

  if(!isai(self) && isalive(self)) {
    if(self ent_flag("_stealth_in_foliage"))
      score_range = [
        [maps\_foliage_cover::calculate_foliage_cover]
      ](stance);
  }

  score_move = self._stealth.logic.movespeed_multiplier[detection_level][stance];

  if(isDefined(self._stealth_move_detection_cap) && score_move > self._stealth_move_detection_cap)
    score_move = self._stealth_move_detection_cap;

  return score_range + score_move;
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

    if(self._stealth.logic.stance_change > 0.05)
      self._stealth.logic.stance_change = self._stealth.logic.stance_change - 0.05;
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

  if(!isDefined(self.stealth_nocorpselogic))
    self thread enemy_corpse_logic();

  self thread enemy_corpse_death();
}

enemy_init() {
  assert(!isDefined(self._stealth), "you called maps_stealth_logic::enemy_init() twice on the same ai");
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
  self ent_flag_init("_stealth_saw_corpse");
  self ent_flag_init("_stealth_found_corpse");
  self enemy_event_listeners_init();
  self ent_flag_init("_stealth_in_shadow");
  self ent_flag_init("_stealth_in_foliage");
}

enemy_event_listeners_init() {
  self ent_flag_init("_stealth_bad_event_listener");
  self._stealth.logic.event = spawnstruct();
  self._stealth.logic.event.listener = [];
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "grenade danger";
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "gunshot";
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "silenced_shot";
  self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "projectile_impact";

  if(level._stealth.environment[0] != "rain")
    self._stealth.logic.event.listener[self._stealth.logic.event.listener.size] = "bulletwhizby";

  for(i = 0; i < self._stealth.logic.event.listener.size; i++)
    self addaieventlistener(self._stealth.logic.event.listener[i]);

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

  if(level._stealth.environment[0] != "rain")
    self thread enemy_event_awareness("bulletwhizby");

  self thread enemy_event_awareness("projectile_impact");
}

enemy_event_listeners_logic(type) {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");

  while(true) {
    self waittill(type);
    self ent_flag_set("_stealth_bad_event_listener");
  }
}

enemy_event_listeners_proc() {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");

  while(true) {
    self ent_flag_wait("_stealth_bad_event_listener");
    wait 0.65;
    self ent_flag_clear("_stealth_bad_event_listener");
  }
}

enemy_event_awareness(type) {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  self._stealth.logic.event.awareness[type] = 1;
  var = undefined;

  while(true) {
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

  while(true) {
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
    if(isplayer(other) || isDefined(other.team) && other.team != team) {
      break;
    }
  }

  if(!isDefined(self)) {
    return;
  }
  ai = getaispeciesarray("axis", "all");
  check = int(level._stealth.logic.ai_event[name][level._stealth.logic.detection_level]);

  for(i = 0; i < ai.size; i++) {
    if(!isalive(ai[i])) {
      continue;
    }
    if(!isDefined(ai[i]._stealth)) {
      continue;
    }
    if(distancesquared(ai[i].origin, self.origin) > check * check) {
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

  while(true) {
    self waittill("enemy");

    if(!isalive(self.enemy)) {
      continue;
    }
    enemy_in_foliage = isinarray(level._stealth.enviroment, "foliage") && isDefined(self.enemy maps\_foliage_cover::get_current_foliage_trigger());

    if(enemy_in_foliage) {
      if(distancesquared(self.origin, self.enemy.origin) > self.enemy.maxvisibledist * self.enemy.maxvisibledist) {
        self clearenemy();
        wait 0.25;
        continue;
      }
    }

    if(!flag("_stealth_spotted") && !self._stealth.logic.dog) {
      if(!self enemy_alert_level_logic(self.enemy))
        continue;
    } else
      self enemy_alert_level_change("attack", self.enemy);

    self thread enemy_threat_set_spotted();
    wait 20;

    while(isDefined(self.enemy)) {
      if(distancesquared(self.origin, self.enemy.origin) > self.maxvisibledist * self.maxvisibledist)
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
  wait(randomfloatrange(0.25, 0.5));
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
  assert(enemy._stealth.logic.spotted_list[self.ai_number], "enemy._stealth.spotted_list[ self.ai_number ] is already 0 but being told to forget");
  enemy._stealth.logic.spotted_list[self.ai_number]--;
}

enemy_alert_level_waittime(enemy) {
  self endon("death");
  timefrac = distance(self.origin, enemy.origin) * 0.0005;
  self._stealth.logic.stoptime = 0.25 + timefrac;
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
  if(self._stealth.logic.dog) {
    return;
  }
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_stop_stealth_logic");
  self endon("_stealth_stop_stealth_logic");
  self thread enemy_corpse_found_loop();

  while(true) {
    while(!flag("_stealth_spotted")) {
      found = 0;
      saw = 0;
      corpse = undefined;

      for(i = 0; i < level._stealth.logic.corpse.array.size; i++) {
        corpse = level._stealth.logic.corpse.array[i];
        distsqrd = distancesquared(self.origin, corpse.origin);

        if(isinarray(level._stealth.enviroment, "foliage") && corpse.hidden_in_foliage) {
          found_distsqrd = level._stealth.logic.corpse.foliage_found_distsqrd;
          sight_distsqrd = level._stealth.logic.corpse.foliage_sight_distsqrd;
          detect_distsqrd = level._stealth.logic.corpse.foliage_detect_distsqrd;
        } else {
          found_distsqrd = level._stealth.logic.corpse.found_distsqrd;
          sight_distsqrd = level._stealth.logic.corpse.sight_distsqrd;
          detect_distsqrd = level._stealth.logic.corpse.detect_distsqrd;
        }

        if(distsqrd < found_distsqrd) {
          found = 1;
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

        if(distsqrd > sight_distsqrd) {
          continue;
        }
        if(distsqrd < detect_distsqrd) {
          if(self cansee(corpse)) {
            saw = 1;
            break;
          }
        }

        angles = self gettagangles("tag_eye");
        origin = self gettagorigin("tag_eye");
        sight = anglestoforward(angles);
        vec_to_corpse = vectornormalize(corpse.origin - origin);

        if(vectordot(sight, vec_to_corpse) > 0.55) {
          if(self cansee(corpse)) {
            saw = 1;
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

      wait 0.05;
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

  if(isinarray(level._stealth.enviroment, "foliage") && isDefined(self maps\_foliage_cover::get_current_foliage_trigger()))
    corpse.hidden_in_foliage = 1;
  else
    corpse.hidden_in_foliage = 0;

  corpse endon("death");

  while(isDefined(self.origin)) {
    corpse.origin = self.origin + offset;
    wait 0.01;
  }

  if(level.cheatstates["sf_use_tire_explosion"])
    wait 0.25;

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
  arrayremovevalue(level._stealth.logic.corpse.array, corpse);

  if(isDefined(self.no_corpse_announce)) {
    level notify("_stealth_no_corpse_announce");
    self notify("event_awareness", "found_corpse");
    return;
  }

  wait(randomfloatrange(0.25, 0.5));

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

  while(true) {
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
  else
    enemy = get_closest_player(self.origin);

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
    wait 0.05;

  self ent_flag_clear("_stealth_in_shadow");
}

system_handle_clipbrush() {
  self endon("death");

  if(isDefined(self.script_flag_wait))
    flag_wait(self.script_flag_wait);

  waittillframeend;
  spotted_flag = "_stealth_spotted";
  corpse_flag = "_stealth_found_corpse";
  event_flag = "_stealth_event";
  self setcandamage(1);
  self add_wait(::waittill_msg, "damage");
  level add_wait(::flag_wait, spotted_flag);
  level add_wait(::flag_wait, corpse_flag);
  level add_wait(::flag_wait, event_flag);
  do_wait_any();

  if(self.spawnflags & 1)
    self connectpaths();

  self delete();
}

stealth_ai(state_functions, alert_functions, corpse_functions, awareness_functions) {
  if(isDefined(self._stealth)) {
    return;
  }
  assert(isDefined(level._stealth.logic), "call maps_stealth_logic::main() before calling stealth_ai()");
  self stealth_ai_logic();
  self stealth_ai_behavior(state_functions, alert_functions, corpse_functions, awareness_functions);
}

stealth_ai_logic() {
  assert(isDefined(level._stealth.logic), "call maps_stealth_logic::main() before calling stealth_ai_logic()");

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
  assert(isDefined(level._stealth.behavior), "call maps_stealth_behavior::main() before calling stealth_ai_behavior()");

  if(isplayer(self)) {
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
  if(flag("_stealth_spotted")) {
    return;
  }
  level endon("_stealth_spotted");

  if(flag("_stealth_found_corpse")) {
    return;
  }
  level endon("_stealth_found_corpse");
  self endon("_stealth_enemy_alert_level_change");
  waittillframeend;

  if(self ent_flag("_stealth_saw_corpse")) {
    return;
  }
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

stealth_detect_corpse_range_set(sight_dist, detect_dist, found_dist) {
  level._stealth.logic.corpse.sight_dist = sight_dist;
  level._stealth.logic.corpse.detect_dist = detect_dist;
  level._stealth.logic.corpse.found_dist = found_dist;
  level._stealth.logic.corpse.sight_distsqrd = level._stealth.logic.corpse.sight_dist * level._stealth.logic.corpse.sight_dist;
  level._stealth.logic.corpse.detect_distsqrd = level._stealth.logic.corpse.detect_dist * level._stealth.logic.corpse.detect_dist;
  level._stealth.logic.corpse.found_distsqrd = level._stealth.logic.corpse.found_dist * level._stealth.logic.corpse.found_dist;
}

stealth_detect_corpse_range_default() {
  maps\_stealth_logic::system_default_corpse_detect_ranges();
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
    assertmsg("stealth_ai_alert_functions_set should only be called on enemies");

    return;
  }

  self maps\_stealth_behavior::ai_change_ai_functions("alert", alert_functions);
}

stealth_ai_alert_functions_default() {
  if(self.team == "allies") {
    assertmsg("stealth_ai_alert_functions_default should only be called on enemies");

    return;
  }

  self maps\_stealth_behavior::enemy_default_ai_functions("alert");
}

stealth_ai_corpse_functions_set(corpse_functions) {
  if(self.team == "allies") {
    assertmsg("stealth_ai_corpse_functions_set should only be called on enemies");

    return;
  }

  self maps\_stealth_behavior::ai_change_ai_functions("corpse", corpse_functions);
}

stealth_ai_corpse_functions_default() {
  if(self.team == "allies") {
    assertmsg("stealth_ai_corpse_functions_default should only be called on enemies");

    return;
  }

  self maps\_stealth_behavior::enemy_default_ai_functions("corpse");
}

stealth_ai_awareness_functions_set(awareness_functions) {
  if(self.team == "allies") {
    assertmsg("stealth_ai_awareness_functions_set should only be called on enemies");

    return;
  }

  self maps\_stealth_behavior::ai_change_ai_functions("awareness", awareness_functions);
}

stealth_ai_awareness_functions_default() {
  if(self.team == "allies") {
    assertmsg("stealth_ai_awareness_functions_default should only be called on enemies");

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
  guy.allowdeath = 1;
  guy stealth_insure_enabled();
  self thread maps\_anim::anim_generic_loop(guy, idle_anim, ender);
  guy maps\_stealth_behavior::ai_set_custom_animation_reaction(self, reaction_anim, tag, ender);
}

stealth_ai_reach_idle_and_react(guy, reach_anim, idle_anim, reaction_anim) {
  guy stealth_insure_enabled();
  self thread stealth_ai_reach_idle_and_react_proc(guy, reach_anim, idle_anim, reaction_anim);
}

stealth_ai_reach_idle_and_react_proc(guy, reach_anim, idle_anim, reaction_anim) {
  guy thread stealth_enemy_endon_alert();
  guy endon("stealth_enemy_endon_alert");
  guy endon("death");
  guy stealth_insure_enabled();
  self maps\_anim::anim_generic_reach(guy, reach_anim);
  stealth_ai_idle_and_react(guy, idle_anim, reaction_anim);
}

stealth_ai_reach_and_arrive_idle_and_react(guy, reach_anim, idle_anim, reaction_anim) {
  guy stealth_insure_enabled();
  self thread stealth_ai_reach_and_arrive_idle_and_react_proc(guy, reach_anim, idle_anim, reaction_anim);
}

stealth_ai_reach_and_arrive_idle_and_react_proc(guy, reach_anim, idle_anim, reaction_anim) {
  guy thread stealth_enemy_endon_alert();
  guy endon("stealth_enemy_endon_alert");
  guy endon("death");
  guy stealth_insure_enabled();
  self maps\_anim::anim_generic_reach_aligned(guy, reach_anim);
  stealth_ai_idle_and_react(guy, idle_anim, reaction_anim);
}

stealth_insure_enabled() {
  if(isDefined(self._stealth)) {
    return;
  }
  self thread stealth_ai();
}

debug_stealth() {
  wait_for_all_players();
  level.player = getplayers()[0];
  create_debug_hud_elemets();
  level thread debug_level_stealth();
  level thread debug_ai_stealth();
}

debug_level_stealth() {
  level endon("_stealth_stop_stealth_logic");
  assert(isDefined(level.stealth_hud_hidden));

  while(true) {
    if(!getdvarint(#"_id_738F6688")) {
      destroy_debug_hud_elemets();
      wait 0.5;
      continue;
    }

    create_debug_hud_elemets();
    level.stealth_hud_hidden settext("Hidden - ");
    level.stealth_hud_hidden_value setvalue(flag("_stealth_hidden"));
    level.stealth_hud_alert settext("Alert - ");
    level.stealth_hud_alert_value setvalue(flag("_stealth_alert"));
    level.stealth_hud_spotted settext("Spotted - ");
    level.stealth_hud_spotted_value setvalue(flag("_stealth_spotted"));
    level.stealth_hud_corpse settext("Found Corpse - ");
    level.stealth_hud_corpse_value setvalue(flag("_stealth_found_corpse"));

    if(isDefined(level.player.maxvisibledist)) {
      level.stealth_visibility_hud_value setvalue(level.player.maxvisibledist);
      circle(level.player.origin, level.player.maxvisibledist, (0, 1, 0), 0, 1, 1);
      recordcircle(level.player.origin, level.player.maxvisibledist, (0, 1, 0), "Script", level.player);
    }

    wait 0.05;
  }

}

debug_ai_stealth() {
  array_thread(getspawnerteamarray("axis"), ::add_spawn_function, ::debug_ai_stealth_draw_stealth_info);
  array_thread(getaiarray("axis"), ::debug_ai_stealth_draw_stealth_info);
}

debug_ai_stealth_draw_stealth_info() {
  self endon("death");

  while(true) {
    if(!getdvarint(#"_id_738F6688")) {
      wait 0.5;
      continue;
    }

    if(!isDefined(self._stealth) || isplayer(self)) {
      wait 0.5;
      continue;
    }

    if(isDefined(self._stealth.logic.alert_level.lvl) && isDefined(self._stealth.logic.alert_level.enemy)) {
      enemy = self._stealth.logic.alert_level.enemy getentitynumber();
      print3d_on_ent("alert level - " + self._stealth.logic.alert_level.lvl + " current enemy - " + enemy, 70);
    }

    if(self flag_exists("_stealth_saw_corpse"))
      print3d_on_ent("Saw a Corpse - " + ent_flag("_stealth_saw_corpse") + " Found a Corpse - " + ent_flag("_stealth_found_corpse"), 85);

    print3d_on_ent("Hidden - " + flag("_stealth_hidden") + " Alert - " + flag("_stealth_alert") + " Spotted - " + flag("_stealth_spotted") + " Found Corpse - " + flag("_stealth_found_corpse") + " GoalRadius - " + self.goalradius, 100);

    if(isDefined(self.goalpos))
      recordline(self.origin, self.goalpos, (1, 1, 1), "Script", self);

    wait 0.05;
  }

}

create_debug_hud_elemets() {
  if(!isDefined(level.stealth_hud_hidden)) {
    level.stealth_hud_hidden = newdebughudelem();
    level.stealth_hud_hidden.location = 0;
    level.stealth_hud_hidden.alignx = "left";
    level.stealth_hud_hidden.fontscale = 1.3;
    level.stealth_hud_hidden.x = -75;
    level.stealth_hud_hidden.y = 40;
    level.stealth_hud_hidden.color = (1, 1, 1);
    level.stealth_hud_hidden_value = newdebughudelem();
    level.stealth_hud_hidden_value.location = 0;
    level.stealth_hud_hidden_value.alignx = "left";
    level.stealth_hud_hidden_value.fontscale = 1.3;
    level.stealth_hud_hidden_value.x = -10;
    level.stealth_hud_hidden_value.y = 40;
    level.stealth_hud_hidden_value.color = (1, 1, 1);
    level.stealth_hud_alert = newdebughudelem();
    level.stealth_hud_alert.location = 0;
    level.stealth_hud_alert.alignx = "left";
    level.stealth_hud_alert.fontscale = 1.3;
    level.stealth_hud_alert.x = -75;
    level.stealth_hud_alert.y = 55;
    level.stealth_hud_alert.color = (1, 1, 1);
    level.stealth_hud_alert_value = newdebughudelem();
    level.stealth_hud_alert_value.location = 0;
    level.stealth_hud_alert_value.alignx = "left";
    level.stealth_hud_alert_value.fontscale = 1.3;
    level.stealth_hud_alert_value.x = -10;
    level.stealth_hud_alert_value.y = 55;
    level.stealth_hud_alert_value.color = (1, 1, 1);
    level.stealth_hud_spotted = newdebughudelem();
    level.stealth_hud_spotted.location = 0;
    level.stealth_hud_spotted.alignx = "left";
    level.stealth_hud_spotted.fontscale = 1.3;
    level.stealth_hud_spotted.x = -75;
    level.stealth_hud_spotted.y = 70;
    level.stealth_hud_spotted.color = (1, 1, 1);
    level.stealth_hud_spotted_value = newdebughudelem();
    level.stealth_hud_spotted_value.location = 0;
    level.stealth_hud_spotted_value.alignx = "left";
    level.stealth_hud_spotted_value.fontscale = 1.3;
    level.stealth_hud_spotted_value.x = -10;
    level.stealth_hud_spotted_value.y = 70;
    level.stealth_hud_spotted_value.color = (1, 1, 1);
    level.stealth_hud_corpse = newdebughudelem();
    level.stealth_hud_corpse.location = 0;
    level.stealth_hud_corpse.alignx = "left";
    level.stealth_hud_corpse.fontscale = 1.3;
    level.stealth_hud_corpse.x = -75;
    level.stealth_hud_corpse.y = 85;
    level.stealth_hud_corpse.color = (1, 1, 1);
    level.stealth_hud_corpse_value = newdebughudelem();
    level.stealth_hud_corpse_value.location = 0;
    level.stealth_hud_corpse_value.alignx = "left";
    level.stealth_hud_corpse_value.fontscale = 1.3;
    level.stealth_hud_corpse_value.x = 10;
    level.stealth_hud_corpse_value.y = 85;
    level.stealth_hud_corpse_value.color = (1, 1, 1);
    level.stealth_visibility_hud = newdebughudelem();
    level.stealth_visibility_hud.location = 0;
    level.stealth_visibility_hud.alignx = "left";
    level.stealth_visibility_hud.fontscale = 1.3;
    level.stealth_visibility_hud.x = -75;
    level.stealth_visibility_hud.y = 100;
    level.stealth_visibility_hud.color = (1, 1, 1);
    level.stealth_visibility_hud_value = newdebughudelem();
    level.stealth_visibility_hud_value.location = 0;
    level.stealth_visibility_hud_value.alignx = "left";
    level.stealth_visibility_hud_value.fontscale = 1.3;
    level.stealth_visibility_hud_value.x = 0;
    level.stealth_visibility_hud_value.y = 100;
    level.stealth_visibility_hud_value.color = (1, 1, 1);
    level.stealth_foliage_hud = newdebughudelem();
    level.stealth_foliage_hud.location = 0;
    level.stealth_foliage_hud.alignx = "left";
    level.stealth_foliage_hud.fontscale = 1.3;
    level.stealth_foliage_hud.x = -75;
    level.stealth_foliage_hud.y = 115;
    level.stealth_foliage_hud.color = (1, 1, 1);
    level.stealth_foliage_hud_value = newdebughudelem();
    level.stealth_foliage_hud_value.location = 0;
    level.stealth_foliage_hud_value.alignx = "left";
    level.stealth_foliage_hud_value.fontscale = 1.3;
    level.stealth_foliage_hud_value.x = -10;
    level.stealth_foliage_hud_value.y = 115;
    level.stealth_foliage_hud_value.color = (1, 1, 1);
  }

}

destroy_debug_hud_elemets() {
  if(isDefined(level.stealth_hud_hidden)) {
    level.stealth_hud_hidden destroy();
    level.stealth_hud_hidden_value destroy();
    level.stealth_hud_alert destroy();
    level.stealth_hud_alert_value destroy();
    level.stealth_hud_spotted destroy();
    level.stealth_hud_spotted_value destroy();
    level.stealth_hud_corpse destroy();
    level.stealth_hud_corpse_value destroy();
    level.stealth_visibility_hud_value destroy();
  }

}

print3d_on_ent(msg, offset) {
  record3dtext(msg, self.origin + (0, 0, offset), (1, 1, 1), "Script");
}