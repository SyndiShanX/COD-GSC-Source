/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_stealth_visibility_enemy.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_stealth_utility;
#include maps\_stealth_shared_utilities;

stealth_visibility_enemy_main() {
  self enemy_init();

  self thread enemy_threat_logic();
}

MIN_TIME_TO_LOSE_ENEMY = 20 * 1000;

enemy_threat_logic() {
  self endon("death");
  self endon("pain_death");

  while(1) {
    self ent_flag_wait("_stealth_enabled");

    self waittill("enemy");

    if(!self ent_flag("_stealth_enabled")) {
      continue;
    }
    if(!isalive(self.enemy)) {
      continue;
    }
    if(!self stealth_group_spotted_flag()) {
      if(!self enemy_alert_level_logic(self.enemy)) {
        continue;
      }
    } else {
      self maps\_stealth_threat_enemy::enemy_alert_level_change("attack");
    }

    self thread enemy_threat_set_spotted();

    wait 10;

    while(isDefined(self.enemy) && self ent_flag("_stealth_enabled")) {
      time_past_last_event = gettime() - self lastKnownTime(self.enemy);

      if(MIN_TIME_TO_LOSE_ENEMY > time_past_last_event) {
        wait((MIN_TIME_TO_LOSE_ENEMY - time_past_last_event) * 0.001);
        continue;
      }

      if(distance(self.origin, self.enemy.origin) > self.enemy.maxVisibleDist) {
        break;
      }

      wait .5;
    }

    if(!self ent_flag("_stealth_enabled")) {
      continue;
    }

    if(isDefined(self.enemy)) {
      enemy_alert_level_forget(self.enemy, 0);
    }

    self clearenemy();
    self maps\_stealth_threat_enemy::enemy_alert_level_change("reset");
  }
}

enemy_alert_level_logic_start_attacking(enemy) {
  if(self ent_flag("_stealth_bad_event_listener") || enemy._stealth.logic.spotted_list[self.unique_id] > self._stealth.logic.alert_level.max_warnings) {
    if(self ent_flag("_stealth_bad_event_listener")) {
      self stealth_debug_print("BROKEN STEALTH. Received ent '" + enemy.unique_id + "' as an enemy from code. Attacked because the reason was a bad_event_listener...ie a gunshot or something equally bad");
    } else {
      self stealth_debug_print("BROKEN STEALTH. Received ent '" + enemy.unique_id + "' as an enemy from code. Attacked because " + enemy.unique_id + " had been spotted more than the max_warning amount of " + self._stealth.logic.alert_level.max_warnings);
    }

    self maps\_stealth_threat_enemy::enemy_alert_level_change("attack");
    return true;
  }

  return false;
}

enemy_recheck_time = 500;

enemy_alert_level_logic(enemy) {
  if(!isDefined(enemy._stealth)) {
    return true;
  }

  if(!isDefined(enemy._stealth.logic.spotted_list[self.unique_id])) {
    enemy._stealth.logic.spotted_list[self.unique_id] = 0;
  }

  while(1) {
    enemy._stealth.logic.spotted_list[self.unique_id]++;

    if(enemy_alert_level_logic_start_attacking(enemy)) {
      return true;
    }

    number = enemy._stealth.logic.spotted_list[self.unique_id];
    self maps\_stealth_threat_enemy::enemy_alert_level_change("warning" + number);

    self thread enemy_alert_level_forget(enemy);

    self enemy_alert_level_waittime(enemy);

    if(gettime() - self lastKnownTime(enemy) > enemy_recheck_time) {
      self clearenemy();
      return false;
    }
  }
}

enemy_threat_set_spotted() {
  self endon("death");
  self endon("pain_death");

  enemy = self.enemy;
  self.dontEverShoot = undefined;

  self[[self._stealth.logic.pre_spotted_func]]();

  if(isDefined(enemy)) {
    level._stealth.group.spotted_enemy[self.script_stealthgroup] = enemy;
  }

  self group_flag_set("_stealth_spotted");
}

enemy_prespotted_func_default() {
  wait 2.25;
}

enemy_alert_level_waittime(enemy) {
  if(self stealth_group_corpse_flag() || self ent_flag("_stealth_bad_event_listener")) {
    return;
  }
  timefrac = distance(self.origin, enemy.origin) * .0005;
  waittime = level._stealth.logic.min_alert_level_duration + timefrac;

  self stealth_debug_print("WARNING time = " + waittime);

  level endon(group_get_flagname("_stealth_spotted"));
  self endon("_stealth_bad_event_listener");

  wait(waittime);
}

enemy_event_listeners_logic(type) {
  self endon("death");

  while(1) {
    self waittill(type, subtype, param);

    if(!self ent_flag("_stealth_enabled")) {
      continue;
    }
    if(self ent_flag_exist("_stealth_behavior_asleep") && self ent_flag("_stealth_behavior_asleep")) {
      continue;
    }
    self ent_flag_set("_stealth_bad_event_listener");
  }
}
enemy_event_listeners_proc() {
  self endon("death");

  while(1) {
    self ent_flag_wait("_stealth_bad_event_listener");

    wait .65;

    self ent_flag_clear("_stealth_bad_event_listener");
  }
}

enemy_event_awareness_notify(type, param) {
  self ent_flag_clear("_stealth_normal");

  self._stealth.logic.event.awareness_param[type] = param;
  self notify("event_awareness", type);
  level notify("event_awareness", type);
}
enemy_event_category_awareness(type) {
  self endon("death");
  self endon("pain_death");

  while(1) {
    self waittill(type, subtype, param);

    if(!self ent_flag("_stealth_enabled")) {
      continue;
    }

    switch (type) {
      case "awareness_alert_level":
        break;

      case "ai_event":
        if(!isDefined(self._stealth.logic.event.aware_aievents[subtype])) {
          continue;
        }
        if(subtype == "bulletwhizby" && (!isDefined(param.team) || param.team == self.team)) {
          continue;
        }

      default:
        group_flag_set("_stealth_event");
        level thread enemy_event_handle_clear(self.script_stealthgroup);
        break;
    }

    enemy_event_awareness_notify(subtype, param);

    waittillframeend;
  }
}
enemy_event_awareness(type) {
  self endon("death");
  self endon("pain_death");

  self._stealth.logic.event.awareness_param[type] = true;

  while(1) {
    self waittill(type, param);

    if(!self ent_flag("_stealth_enabled")) {
      continue;
    }
    group_flag_set("_stealth_event");
    level thread enemy_event_handle_clear(self.script_stealthgroup);

    enemy_event_awareness_notify(type, param);

    waittillframeend;
  }
}

enemy_event_handle_clear(name) {
  end_msg = "enemy_event_handle_clear:" + name + " Proc";
  wait_msg = "enemy_event_handle_clear:" + name + " Cleared";

  level notify(end_msg);
  level endon(end_msg);

  wait 2;

  ai = group_get_ai_in_group(name);

  if(ai.size) {
    level add_wait(::array_wait, ai, "event_awareness_waitclear_ai");
    level add_endon(end_msg);
    level add_func(::send_notify, wait_msg);
    level thread do_wait();

    array_thread(ai, ::event_awareness_waitclear_ai, end_msg);

    level waittill(wait_msg);
  }

  group_flag_clear("_stealth_event", name);
}

event_awareness_waitclear_ai(end_msg) {
  level endon(end_msg);

  self event_awareness_waitclear_ai_proc();
  self notify("event_awareness_waitclear_ai");
}

event_awareness_waitclear_ai_proc() {
  self endon("death");

  waittillframeend;

  check1 = false;
  if(isDefined(self.ent_flag["_stealth_behavior_first_reaction"])) {
    check1 = self ent_flag("_stealth_behavior_first_reaction");
  }

  check2 = false;
  if(isDefined(self.ent_flag["_stealth_behavior_reaction_anim"])) {
    check1 = self ent_flag("_stealth_behavior_reaction_anim");
  }

  if(!check1 && !check2) {
    return;
  }
  self add_wait(::waittill_msg, "death");
  self add_wait(::waittill_msg, "going_back");
  do_wait_any();

  self endon("goal");

  allies = array_combine(getaiarray("allies"), level.players);
  dist = level._stealth.logic.detect_range["hidden"]["crouch"];
  distsquared = dist * dist;
  loop = true;

  if(loop) {
    loop = false;
    foreach(actor in allies) {
      if(distancesquared(self.origin, actor.origin) < distsquared) {
        continue;
      }
      loop = true;
    }
    wait 1;
  }
}

enemy_event_declare_to_team(type, name) {
  other = undefined;
  team = self.team;

  while(1) {
    if(!isalive(self)) {
      return;
    }
    self waittill(type, var1, var2);

    if(isalive(self) && !self ent_flag("_stealth_enabled")) {
      continue;
    }
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

  ai = getaispeciesarray("bad_guys", "all");

  check = int(level._stealth.logic.ai_event[name][level._stealth.logic.detection_level]);

  for(i = 0; i < ai.size; i++) {
    if(!isalive(ai[i])) {
      continue;
    }
    if(!isDefined(ai[i]._stealth)) {
      continue;
    }
    if(distance(ai[i].origin, self.origin) > check) {
      continue;
    }
    if(ai[i] ent_flag_exist("_stealth_behavior_asleep") && ai[i] ent_flag("_stealth_behavior_asleep")) {
      continue;
    }
    ai[i] ent_flag_set("_stealth_bad_event_listener");
  }
}

enemy_init() {
  assertex(!isDefined(self._stealth), "you called maps\_stealth_logic::enemy_init() twice on the same ai");

  self clearenemy();
  self._stealth = spawnStruct();
  self._stealth.logic = spawnStruct();

  self ent_flag_init("_stealth_enabled");
  self ent_flag_set("_stealth_enabled");

  self ent_flag_init("_stealth_normal");
  self ent_flag_set("_stealth_normal");

  self ent_flag_init("_stealth_attack");

  self group_flag_init("_stealth_spotted");
  self group_flag_init("_stealth_event");
  self group_flag_init("_stealth_found_corpse");

  self group_add_to_global_list();
  if(!isDefined(level._stealth.behavior.sound["spotted"][self.script_stealthgroup])) {
    level._stealth.behavior.sound["spotted"][self.script_stealthgroup] = false;
  }

  self._stealth.logic.alert_level = spawnStruct();
  self._stealth.logic.alert_level.max_warnings = 0;
  self enemy_alert_level_default_pre_spotted_func();

  self enemy_event_listeners_init();
}

enemy_event_listeners_init() {
  self ent_flag_init("_stealth_bad_event_listener");

  self._stealth.logic.event = spawnStruct();

  self addAIEventListener("grenade danger");
  self addAIEventListener("gunshot");
  self addAIEventListener("gunshot_teammate");
  self addAIEventListener("silenced_shot");
  self addAIEventListener("bulletwhizby");
  self addAIEventListener("projectile_impact");

  self thread enemy_event_listeners_logic("ai_event");

  self thread enemy_event_declare_to_team("damage", "ai_eventDistPain");
  self thread enemy_event_declare_to_team("death", "ai_eventDistDeath");

  self thread enemy_event_listeners_proc();

  self._stealth.logic.event.awareness_param = [];

  self._stealth.logic.event.aware_aievents = [];
  self._stealth.logic.event.aware_aievents["bulletwhizby"] = true;
  self._stealth.logic.event.aware_aievents["projectile_impact"] = true;
  self._stealth.logic.event.aware_aievents["gunshot_teammate"] = true;
  self._stealth.logic.event.aware_aievents["grenade danger"] = true;

  self thread enemy_event_category_awareness("ai_event");
  self thread enemy_event_category_awareness("awareness_alert_level");
  self thread enemy_event_category_awareness("awareness_corpse");

  self thread enemy_event_debug_print("awareness_alert_level");
  self thread enemy_event_debug_print("awareness_corpse");
  self thread enemy_event_debug_print("ai_event");
}

enemy_alert_level_set_pre_spotted_func(func) {
  self._stealth.logic.pre_spotted_func = func;
}

enemy_alert_level_default_pre_spotted_func() {
  self._stealth.logic.pre_spotted_func = ::enemy_prespotted_func_default;
}