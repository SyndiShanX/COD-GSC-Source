/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_visibility_enemy.gsc
**********************************************/

stealth_visibility_enemy_main() {
  enemy_init();
  thread enemy_threat_logic();
}

enemy_threat_logic() {
  self endon("death");
  self endon("pain_death");

  for(;;) {
    maps\_utility::ent_flag_wait("_stealth_enabled");
    self waittill("enemy");

    if(!maps\_utility::ent_flag("_stealth_enabled")) {
      continue;
    }
    if(!isalive(self.enemy)) {
      continue;
    }
    if(!maps\_stealth_utility::stealth_group_spotted_flag()) {
      if(!enemy_alert_level_logic(self.enemy))
        continue;
    } else
      maps\_stealth_threat_enemy::enemy_alert_level_change("attack");

    thread enemy_threat_set_spotted();
    wait 10;

    while(isDefined(self.enemy) && maps\_utility::ent_flag("_stealth_enabled")) {
      var_0 = gettime() - self lastknowntime(self.enemy);

      if(20000 > var_0) {
        wait((20000 - var_0) * 0.001);
        continue;
      }

      if(distance(self.origin, self.enemy.origin) > self.enemy.maxvisibledist) {
        break;
      }

      wait 0.5;
    }

    if(!maps\_utility::ent_flag("_stealth_enabled")) {
      continue;
    }
    maps\_utility::ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");

    if(isDefined(self.enemy))
      maps\_stealth_shared_utilities::enemy_alert_level_forget(self.enemy, 0);

    self clearenemy();
    maps\_stealth_threat_enemy::enemy_alert_level_change("reset");
  }
}

enemy_alert_level_logic_start_attacking(var_0) {
  if(maps\_utility::ent_flag("_stealth_bad_event_listener") || var_0._stealth.logic.spotted_list[self.unique_id] > self._stealth.logic.alert_level.max_warnings) {
    maps\_stealth_threat_enemy::enemy_alert_level_change("attack");
    return 1;
  }

  return 0;
}

enemy_alert_level_logic(var_0) {
  if(!isDefined(var_0._stealth))
    return 1;

  if(!isDefined(var_0._stealth.logic.spotted_list[self.unique_id]))
    var_0._stealth.logic.spotted_list[self.unique_id] = 0;

  for(;;) {
    var_0._stealth.logic.spotted_list[self.unique_id]++;

    if(enemy_alert_level_logic_start_attacking(var_0))
      return 1;

    var_1 = var_0._stealth.logic.spotted_list[self.unique_id];
    maps\_stealth_threat_enemy::enemy_alert_level_change("warning" + var_1);
    thread maps\_stealth_shared_utilities::enemy_alert_level_forget(var_0);
    enemy_alert_level_waittime(var_0);

    if(!isDefined(var_0) || gettime() - self lastknowntime(var_0) > 500) {
      self clearenemy();
      return 0;
    }
  }
}

enemy_threat_set_spotted() {
  self endon("death");
  self endon("pain_death");
  var_0 = self.enemy;
  self.dontevershoot = undefined;
  self[[self._stealth.logic.pre_spotted_func]]();

  if(isDefined(var_0)) {
    level._stealth.group.spotted_enemy[self.script_stealthgroup] = var_0;

    if(isDefined(var_0._stealth))
      var_0 maps\_stealth_shared_utilities::group_flag_set("_stealth_spotted");
  }

  maps\_stealth_shared_utilities::group_flag_set("_stealth_spotted");
}

enemy_prespotted_func_default() {
  wait 2.25;
}

enemy_alert_level_waittime(var_0) {
  if(maps\_stealth_utility::stealth_group_corpse_flag() || maps\_utility::ent_flag("_stealth_bad_event_listener")) {
    return;
  }
  var_1 = distance(self.origin, var_0.origin) * 0.0005;
  var_2 = level._stealth.logic.min_alert_level_duration + var_1;
  maps\_stealth_shared_utilities::stealth_debug_print("WARNING time = " + var_2);
  level endon(maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted"));
  self endon("_stealth_bad_event_listener");
  wait(var_2);
}

enemy_event_listeners_logic(var_0) {
  self endon("death");

  for(;;) {
    self waittill(var_0, var_1, var_2);

    if(!maps\_utility::ent_flag("_stealth_enabled")) {
      continue;
    }
    if(maps\_utility::ent_flag_exist("_stealth_behavior_asleep") && maps\_utility::ent_flag("_stealth_behavior_asleep")) {
      continue;
    }
    maps\_utility::ent_flag_set("_stealth_bad_event_listener");
  }
}

enemy_event_listeners_proc() {
  self endon("death");

  for(;;) {
    maps\_utility::ent_flag_wait("_stealth_bad_event_listener");
    wait 0.65;
    maps\_utility::ent_flag_clear("_stealth_bad_event_listener");
  }
}

enemy_event_awareness_notify(var_0, var_1) {
  maps\_utility::ent_flag_clear("_stealth_normal");
  self._stealth.logic.event.awareness_param[var_0] = var_1;
  self notify("event_awareness", var_0);
  level notify("event_awareness", var_0);
}

enemy_event_category_awareness(var_0) {
  self endon("death");
  self endon("pain_death");

  for(;;) {
    self waittill(var_0, var_1, var_2);

    if(!maps\_utility::ent_flag("_stealth_enabled")) {
      continue;
    }
    switch (var_0) {
      case "awareness_alert_level":
        break;
      case "ai_event":
        if(!isDefined(self._stealth.logic.event.aware_aievents[var_1])) {
          continue;
        }
        if(var_1 == "bulletwhizby" && (!isDefined(var_2.team) || var_2.team == self.team))
          continue;
      default:
        maps\_stealth_shared_utilities::group_flag_set("_stealth_event");
        level thread enemy_event_handle_clear(self.script_stealthgroup);
        break;
    }

    enemy_event_awareness_notify(var_1, var_2);
    waittillframeend;
  }
}

enemy_event_awareness(var_0) {
  self endon("death");
  self endon("pain_death");
  self._stealth.logic.event.awareness_param[var_0] = 1;

  for(;;) {
    self waittill(var_0, var_1);

    if(!maps\_utility::ent_flag("_stealth_enabled")) {
      continue;
    }
    maps\_stealth_shared_utilities::group_flag_set("_stealth_event");
    level thread enemy_event_handle_clear(self.script_stealthgroup);
    enemy_event_awareness_notify(var_0, var_1);
    waittillframeend;
  }
}

enemy_event_handle_clear(var_0) {
  var_1 = "enemy_event_handle_clear:" + var_0 + " Proc";
  var_2 = "enemy_event_handle_clear:" + var_0 + " Cleared";
  level notify(var_1);
  level endon(var_1);
  wait 2;
  var_3 = maps\_stealth_shared_utilities::group_get_ai_in_group(var_0);

  if(var_3.size) {
    level maps\_utility::add_wait(maps\_utility::array_wait, var_3, "event_awareness_waitclear_ai");
    level maps\_utility::add_endon(var_1);
    level maps\_utility::add_func(maps\_utility::send_notify, var_2);
    level thread maps\_utility::do_wait();
    common_scripts\utility::array_thread(var_3, ::event_awareness_waitclear_ai, var_1);
    level waittill(var_2);
  }

  maps\_stealth_shared_utilities::group_flag_clear("_stealth_event", var_0);
}

event_awareness_waitclear_ai(var_0) {
  level endon(var_0);
  event_awareness_waitclear_ai_proc();
  self notify("event_awareness_waitclear_ai");
}

event_awareness_waitclear_ai_proc() {
  self endon("death");
  waittillframeend;
  var_0 = 0;

  if(isDefined(self.ent_flag["_stealth_behavior_first_reaction"]))
    var_0 = maps\_utility::ent_flag("_stealth_behavior_first_reaction");

  var_1 = 0;

  if(isDefined(self.ent_flag["_stealth_behavior_reaction_anim"]))
    var_0 = maps\_utility::ent_flag("_stealth_behavior_reaction_anim");

  if(!var_0 && !var_1) {
    return;
  }
  maps\_utility::add_wait(maps\_utility::waittill_msg, "death");
  maps\_utility::add_wait(maps\_utility::waittill_msg, "going_back");
  maps\_utility::do_wait_any();
  self endon("goal");
  var_2 = common_scripts\utility::array_combine(getaiarray("allies"), level.players);
  var_3 = level._stealth.logic.detect_range["hidden"]["crouch"];
  var_4 = var_3 * var_3;
  var_5 = 1;

  if(var_5) {
    var_5 = 0;

    foreach(var_7 in var_2) {
      if(distancesquared(self.origin, var_7.origin) < var_4) {
        continue;
      }
      var_5 = 1;
    }

    wait 1;
  }
}

enemy_event_declare_to_team(var_0, var_1) {
  var_2 = undefined;
  var_3 = self.team;

  for(;;) {
    if(!isalive(self)) {
      return;
    }
    self waittill(var_0, var_4, var_5);

    if(isalive(self) && !maps\_utility::ent_flag("_stealth_enabled")) {
      continue;
    }
    switch (var_0) {
      case "death":
        var_2 = var_4;
        break;
      case "damage":
        var_2 = var_5;
        break;
    }

    if(!isDefined(var_2)) {
      continue;
    }
    if(isPlayer(var_2) || isDefined(var_2.team) && var_2.team != var_3) {
      break;
    }
  }

  if(!isDefined(self)) {
    return;
  }
  var_6 = getaispeciesarray("bad_guys", "all");
  var_7 = int(level._stealth.logic.ai_event[var_1][level._stealth.logic.detection_level]);

  for(var_8 = 0; var_8 < var_6.size; var_8++) {
    if(!isalive(var_6[var_8])) {
      continue;
    }
    if(!isDefined(var_6[var_8]._stealth)) {
      continue;
    }
    if(distance(var_6[var_8].origin, self.origin) > var_7) {
      continue;
    }
    if(var_6[var_8] maps\_utility::ent_flag_exist("_stealth_behavior_asleep") && var_6[var_8] maps\_utility::ent_flag("_stealth_behavior_asleep")) {
      continue;
    }
    var_6[var_8] maps\_utility::ent_flag_set("_stealth_bad_event_listener");
  }
}

enemy_init() {
  self clearenemy();
  self._stealth = spawnStruct();
  self._stealth.logic = spawnStruct();
  maps\_utility::ent_flag_init("_stealth_enabled");
  maps\_utility::ent_flag_set("_stealth_enabled");
  maps\_utility::ent_flag_init("_stealth_normal");
  maps\_utility::ent_flag_set("_stealth_normal");
  maps\_utility::ent_flag_init("_stealth_attack");
  maps\_stealth_shared_utilities::group_flag_init("_stealth_spotted");
  maps\_stealth_shared_utilities::group_flag_init("_stealth_event");
  maps\_stealth_shared_utilities::group_flag_init("_stealth_found_corpse");
  maps\_stealth_shared_utilities::group_add_to_global_list();

  if(!isDefined(level._stealth.behavior.sound["spotted"][self.script_stealthgroup]))
    level._stealth.behavior.sound["spotted"][self.script_stealthgroup] = 0;

  self._stealth.logic.alert_level = spawnStruct();
  self._stealth.logic.alert_level.max_warnings = 0;
  enemy_alert_level_default_pre_spotted_func();
  enemy_event_listeners_init();
}

enemy_event_listeners_init() {
  maps\_utility::ent_flag_init("_stealth_bad_event_listener");
  self._stealth.logic.event = spawnStruct();
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  thread enemy_event_listeners_logic("ai_event");
  thread enemy_event_declare_to_team("damage", "ai_eventDistPain");
  thread enemy_event_declare_to_team("death", "ai_eventDistDeath");
  thread enemy_event_listeners_proc();
  self._stealth.logic.event.awareness_param = [];
  self._stealth.logic.event.aware_aievents = [];
  self._stealth.logic.event.aware_aievents["bulletwhizby"] = 1;
  self._stealth.logic.event.aware_aievents["projectile_impact"] = 1;
  self._stealth.logic.event.aware_aievents["gunshot_teammate"] = 1;
  self._stealth.logic.event.aware_aievents["grenade danger"] = 1;
  thread enemy_event_category_awareness("ai_event");
  thread enemy_event_category_awareness("awareness_alert_level");
  thread enemy_event_category_awareness("awareness_corpse");
}

enemy_alert_level_set_pre_spotted_func(var_0) {
  self._stealth.logic.pre_spotted_func = var_0;
}

enemy_alert_level_default_pre_spotted_func() {
  self._stealth.logic.pre_spotted_func = ::enemy_prespotted_func_default;
}