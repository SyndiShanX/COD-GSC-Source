/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_threat_enemy.gsc
******************************************/

stealth_threat_enemy_main() {
  enemy_init();
  thread enemy_threat_loop();
}

enemy_threat_loop() {
  self endon("death");
  self endon("pain_death");

  if(self.type == "dog")
    thread enemy_threat_logic_dog();

  for(;;) {
    self waittill("_stealth_enemy_alert_level_change", var_0);

    if(!maps\_utility::ent_flag("_stealth_enabled")) {
      continue;
    }
    enemy_alert_level_change_reponse(var_0);
  }
}

enemy_alert_level_change_reponse(var_0) {
  maps\_utility::ent_flag_set("_stealth_enemy_alert_level_action");
  var_1 = var_0;

  if(issubstr(var_0, "warning"))
    var_1 = "warning";

  switch (var_1) {
    case "warning":
      thread enemy_alert_level_warning_wrapper(var_0);
      break;
    case "attack":
      thread enemy_alert_level_attack_wrapper();
      break;
    case "reset":
      thread enemy_alert_level_reset_wrapper();
      break;
  }
}

enemy_threat_logic_dog() {
  self endon("death");
  self endon("pain_death");

  if(!maps\_utility::ent_flag("_stealth_behavior_asleep")) {
    return;
  }
  enemy_threat_logic_dog_wait();
  wait 0.5;
  maps\_utility::delaythread(0.6, maps\_utility::ent_flag_clear, "_stealth_behavior_asleep");
  self.ignoreall = 0;
}

enemy_threat_logic_dog_wait() {
  self endon("pain");
  self endon("enemy");
  common_scripts\utility::array_thread(level.players, ::enemy_threat_logic_dog_wakeup_dist, self, 128);

  for(;;) {
    self waittill("event_awareness", var_0);

    if(!maps\_utility::ent_flag("_stealth_enabled")) {
      continue;
    }
    if(var_0 == "heard_scream" || var_0 == "bulletwhizby" || var_0 == "projectile_impact" || var_0 == "explode")
      return;
  }
}

enemy_threat_logic_dog_wakeup_dist(var_0, var_1) {
  var_0 endon("death");
  self endon("death");

  if(!var_0 maps\_utility::ent_flag("_stealth_behavior_asleep")) {
    return;
  }
  var_0 endon("_stealth_behavior_asleep");
  var_2 = var_1 * var_1;

  while(distancesquared(self.origin, var_0.origin) > var_2 && maps\_utility::ent_flag("_stealth_enabled"))
    wait 0.1;

  var_0.ignoreall = 0;
  var_0.favoriteenemy = self;
  wait 0.1;
  var_0.favoriteenemy = undefined;
}

enemy_alert_level_reset_wrapper() {
  self endon("_stealth_enemy_alert_level_change");
  self endon("enemy_awareness_reaction");
  self endon("death");
  self endon("pain_death");
  maps\_stealth_utility::stealth_group_spotted_flag_waitopen();
  maps\_stealth_shared_utilities::enemy_stop_current_behavior();
  maps\_utility::ent_flag_clear("_stealth_enemy_alert_level_action");

  if(isDefined(self._stealth.plugins.corpse)) {
    maps\_utility::ent_flag_clear("_stealth_saw_corpse");
    maps\_utility::ent_flag_clear("_stealth_found_corpse");
  }

  maps\_utility::ent_flag_clear("_stealth_attack");
  maps\_utility::ent_flag_set("_stealth_normal");
  var_0 = maps\_stealth_shared_utilities::ai_get_behavior_function("threat", "reset");
  self thread[[var_0]]();
}

enemy_alert_level_warning_wrapper(var_0) {
  var_1 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
  self endon("_stealth_enemy_alert_level_change");
  level endon(var_1);
  self endon("death");
  self endon("pain_death");
  self endon("event_awareness");
  maps\_stealth_shared_utilities::enemy_find_original_goal();
  maps\_stealth_shared_utilities::enemy_stop_current_behavior();
  var_2 = maps\_stealth_shared_utilities::ai_get_behavior_function("threat", var_0);
  self[[var_2]]();
  enemy_alert_level_normal_wrapper();
}

enemy_lookaround_for_time(var_0) {
  var_1 = self.fovcosine;
  self.fovcosine = 0.1;
  maps\_stealth_shared_utilities::stealth_set_idle_anim("_stealth_look_around");
  wait(var_0);
  maps\_utility::clear_generic_idle_anim();
  self.fovcosine = var_1;
}

enemy_announce_alert() {
  self endon("death");
  wait 0.25;

  if(isDefined(self.enemy) && self cansee(self.enemy)) {
    maps\_stealth_shared_utilities::enemy_announce_snd("huh");
    thread maps\_stealth_shared_utilities::enemy_announce_attack();
  } else
    thread maps\_stealth_shared_utilities::enemy_announce_huh();
}

enemy_alert_level_warning1() {
  if(!isDefined(self.enemy)) {
    return;
  }
  thread enemy_announce_alert();

  if(isDefined(self.script_patroller)) {
    if(self.type != "dog") {
      var_0 = "a";

      if(common_scripts\utility::cointoss())
        var_0 = "b";

      maps\_stealth_shared_utilities::stealth_set_run_anim("_stealth_patrol_search_" + var_0, 1);
    } else {
      maps\_utility::set_dog_walk_anim();
      self.script_growl = 1;
    }

    self.disablearrivals = 1;
    self.disableexits = 1;
  } else if(self.type == "dog") {
    maps\_utility::set_dog_walk_anim();
    self.script_growl = 1;
    self.disablearrivals = 1;
    self.disableexits = 1;
  }

  var_1 = vectornormalize(self.enemy.origin - self.origin);
  var_2 = distance(self.enemy.origin, self.origin);
  var_2 = var_2 * 0.25;
  var_2 = clamp(var_2, 64, 128);
  var_1 = var_1 * var_2;
  var_3 = self.origin + var_1 + (0, 0, 16);
  var_4 = var_3 + (0, 0, -96);
  var_3 = physicstrace(var_3, var_4);

  if(var_3 == var_4) {
    return;
  }
  maps\_utility::ent_flag_set("_stealth_override_goalpos");
  self setgoalpos(var_3);
  self.goalradius = 64;
  common_scripts\utility::waittill_notify_or_timeout("goal", 2);

  if(!self isingoal(self.origin))
    self.shootposoverride = var_3 + (0, 0, 64);

  enemy_lookaround_for_time(10);
  self.shootposoverride = undefined;
}

enemy_alert_level_warning2() {
  if(!isDefined(self.enemy)) {
    return;
  }
  thread enemy_announce_alert();

  if(self.type != "dog")
    maps\_stealth_shared_utilities::stealth_set_run_anim("_stealth_patrol_cqb");
  else {
    maps\_utility::clear_run_anim();
    self.script_nobark = 1;
    self.script_growl = 1;
  }

  self.disablearrivals = 0;
  self.disableexits = 0;
  var_0 = self.enemy.origin;
  var_1 = distance(var_0, self.origin);
  maps\_utility::ent_flag_set("_stealth_override_goalpos");
  self setgoalpos(var_0);
  self.goalradius = var_1 * 0.5;
  self waittill("goal");

  if(self.type != "dog") {
    var_2 = "_stealth_patrol_search_a";

    if(common_scripts\utility::cointoss())
      var_2 = "_stealth_patrol_search_b";

    maps\_stealth_shared_utilities::stealth_set_run_anim(var_2, 1);
  } else {
    maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self, "gravity", "_stealth_dog_stop");
    maps\_utility::set_dog_walk_anim();
  }

  self setgoalpos(var_0);
  self.goalradius = 64;
  self.disablearrivals = 1;
  self.disableexits = 1;
  self waittill("goal");
  enemy_lookaround_for_time(15);

  if(self.type != "dog") {
    var_2 = "a";

    if(randomint(100) > 50)
      var_2 = "b";

    maps\_stealth_shared_utilities::stealth_set_run_anim("_stealth_patrol_search_" + var_2, 1);
  } else {
    maps\_utility::set_dog_walk_anim();
    self.script_growl = undefined;
  }
}

enemy_alert_level_attack_wrapper() {
  self endon("death");
  self endon("pain_death");
  self endon("_stealth_enemy_alert_level_change");
  self notify("endNewEnemyReactionAnim");
  self notify("movemode");
  self.disablearrivals = 0;
  self.disableexits = 0;
  maps\_stealth_shared_utilities::enemy_find_original_goal();
  maps\_utility::ent_flag_set("_stealth_attack");
  var_0 = maps\_stealth_shared_utilities::ai_get_behavior_function("threat", "attack");
  self[[var_0]]();
}

enemy_alert_level_attack() {
  thread maps\_stealth_shared_utilities::enemy_announce_spotted(self.origin);

  if(isDefined(self.script_goalvolume))
    thread maps\_spawner::set_goal_volume();
  else
    enemy_close_in_on_target();
}

enemy_close_in_on_target() {
  var_0 = 2048;
  self.goalradius = var_0;

  if(isDefined(self.script_stealth_dontseek) && self.script_stealth_dontseek == 1) {
    return;
  }
  self endon("death");
  maps\_utility::ent_flag_set("_stealth_override_goalpos");

  while(isDefined(self.enemy) && maps\_utility::ent_flag("_stealth_enabled")) {
    self setgoalpos(self.enemy.origin);
    self.goalradius = var_0;

    if(var_0 > 600)
      var_0 = var_0 * 0.75;
    else
      return;

    wait 15;

    if(isDefined(self.script_stealth_dontseek) && self.script_stealth_dontseek == 1)
      return;
  }
}

enemy_alert_level_normal_wrapper() {
  enemy_set_alert_level("reset");
  maps\_utility::ent_flag_clear("_stealth_enemy_alert_level_action");

  if(maps\_utility::ent_flag_exist("_stealth_saw_corpse"))
    maps\_utility::ent_flag_waitopen("_stealth_saw_corpse");

  wait 0.05;

  if(maps\_utility::ent_flag_exist("_stealth_found_corpse"))
    maps\_utility::ent_flag_waitopen("_stealth_found_corpse");

  maps\_utility::ent_flag_set("_stealth_normal");
  var_0 = maps\_stealth_shared_utilities::ai_get_behavior_function("threat", "normal");
  self[[var_0]]();
}

enemy_alert_level_normal() {
  thread maps\_stealth_shared_utilities::enemy_announce_hmph();
  maps\_stealth_shared_utilities::enemy_go_back();
}

enemy_init() {
  enemy_default_threat_behavior();
  enemy_default_threat_anim_behavior();
  self._stealth.plugins.threat = 1;
  self.script_stealth_dontseek = 1;
  self.alertlevel = "noncombat";
  self.newenemyreactiondistsq = squared(level._stealth.logic.ai_event["ai_eventDistFootstepSprint"]["hidden"]);
}

enemy_default_threat_behavior() {
  var_0 = [];
  var_0["reset"] = ::enemy_alert_level_normal;
  var_0["warning1"] = ::enemy_alert_level_warning1;
  var_0["warning2"] = ::enemy_alert_level_warning2;
  var_0["attack"] = ::enemy_alert_level_attack;
  var_0["normal"] = ::enemy_alert_level_normal;

  if(!isDefined(level._stealth.logic.alert_level_table)) {
    level._stealth.logic.alert_level_table = [];
    level._stealth.logic.alert_level_table["reset"] = "noncombat";
    level._stealth.logic.alert_level_table["warning"] = "alert";
    level._stealth.logic.alert_level_table["attack"] = "combat";
  }

  enemy_set_threat_behavior(var_0);
}

enemy_set_alert_level(var_0) {
  self.alertlevel = level._stealth.logic.alert_level_table[var_0];
}

enemy_set_threat_behavior(var_0) {
  self._stealth.behavior.ai_functions["threat"] = [];

  if(!isDefined(var_0["reset"]))
    var_0["reset"] = ::enemy_alert_level_normal;

  if(!isDefined(var_0["attack"]))
    var_0["attack"] = ::enemy_alert_level_attack;

  if(!isDefined(var_0["normal"]))
    var_0["normal"] = ::enemy_alert_level_normal;

  foreach(var_3, var_2 in var_0)
  maps\_stealth_shared_utilities::ai_create_behavior_function("threat", var_3, var_2);

  self._stealth.logic.alert_level.max_warnings = var_0.size - 3;
}

enemy_alert_level_change(var_0) {
  while(isDefined(self.syncedmeleetarget))
    wait 0.05;

  self notify("_stealth_enemy_alert_level_change", var_0);

  if(!isDefined(self._stealth.plugins.threat)) {
    self.goalradius = level.default_goalradius;
    return;
  }

  if(issubstr(var_0, "warning"))
    var_0 = "warning";

  enemy_set_alert_level(var_0);
  self notify("awareness_alert_level", var_0);
}

enemy_threat_anim_defaults() {
  var_0 = [];
  var_0["reset"] = maps\_stealth_animation_funcs::enemy_animation_nothing;
  var_0["warning"] = maps\_stealth_animation_funcs::enemy_animation_nothing;

  if(self.type == "dog")
    var_0["attack"] = maps\_stealth_animation_funcs::dog_animation_generic;
  else
    var_0["attack"] = maps\_stealth_animation_funcs::enemy_animation_attack;

  return var_0;
}

enemy_set_threat_anim_behavior(var_0) {
  var_1 = enemy_threat_anim_defaults();

  if(!isDefined(var_0["reset"]))
    var_0["reset"] = var_1["reset"];

  if(!isDefined(var_0["warning"]))
    var_0["warning"] = var_1["warning"];

  if(!isDefined(var_0["attack"]))
    var_0["attack"] = var_1["attack"];

  foreach(var_4, var_3 in var_0)
  maps\_stealth_shared_utilities::ai_create_behavior_function("animation", var_4, var_3);
}

enemy_default_threat_anim_behavior() {
  var_0 = enemy_threat_anim_defaults();
  enemy_set_threat_anim_behavior(var_0);
}