/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_behavior_enemy.gsc
********************************************/

stealth_behavior_enemy_main() {
  enemy_init();
  var_0 = self._stealth.behavior.ai_functions["state"]["hidden"];
  thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_0, "enemy_behavior");
  var_0 = self._stealth.behavior.ai_functions["state"]["spotted"];
  thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_0, "enemy_behavior");
  thread enemy_animation_loop();
}

enemy_animation_loop() {
  self endon("death");
  self endon("pain_death");
  self endon("damage");
  self endon("dog_attacks_ai");

  for(;;) {
    self waittill("event_awareness", var_0);

    if(!maps\_utility::ent_flag("_stealth_enabled")) {
      continue;
    }
    var_1 = self._stealth.behavior.ai_functions["animation"]["wrapper"];
    self thread[[var_1]](var_0);
  }
}

enemy_state_hidden() {
  self.fovcosine = 0.5;
  self.fovcosinebusy = 0.1;
  self.favoriteenemy = undefined;
  self.dontattackme = 1;
  self.dontevershoot = 1;
  thread maps\_utility::set_battlechatter(0);

  if(self.type == "dog") {
    return;
  }
  self.diequietly = 1;
  self clearenemy();
}

enemy_state_spotted(var_0) {
  self.fovcosine = 0.01;

  if(!isDefined(self.dog_attacking_me)) {
    self.ignoreall = 0;
    thread maps\_utility::set_battlechatter(1);
  }

  self.dontattackme = undefined;
  self.dontevershoot = undefined;

  if(isDefined(self.oldfixednode))
    self.fixednode = self.oldfixednode;

  if(self.type != "dog") {
    self.diequietly = 0;

    if(!isDefined(var_0)) {
      maps\_utility::clear_run_anim();
      maps\_stealth_shared_utilities::enemy_stop_current_behavior();
    }
  } else {
    self.script_growl = undefined;
    self.script_nobark = undefined;
  }

  if(isDefined(var_0)) {
    return;
  }
  if(isDefined(level._stealth.group.spotted_enemy)) {
    var_1 = level._stealth.group.spotted_enemy[self.script_stealthgroup];

    if(isDefined(var_1))
      self getenemyinfo(var_1);
  }
}

enemy_init() {
  maps\_utility::ent_flag_init("_stealth_override_goalpos");
  maps\_utility::ent_flag_init("_stealth_enemy_alert_level_action");
  maps\_utility::ent_flag_init("_stealth_running_to_corpse");
  maps\_utility::ent_flag_init("_stealth_behavior_reaction_anim");
  maps\_utility::ent_flag_init("_stealth_behavior_first_reaction");
  maps\_utility::ent_flag_init("_stealth_behavior_reaction_anim_in_progress");
  self._stealth.behavior = spawnStruct();
  self.a.nofirstframemelee = 1;
  self._stealth.behavior.ai_functions = [];
  enemy_default_state_behavior();
  enemy_default_anim_behavior();
  self._stealth.behavior.event = spawnStruct();

  if(self.type == "dog")
    enemy_dog_init();

  self._stealth.plugins = spawnStruct();
  thread maps\_stealth_shared_utilities::ai_stealth_pause_handler();
}

enemy_dog_init() {
  if(threatbiasgroupexists("dog"))
    self setthreatbiasgroup("dog");

  if(isDefined(self.enemy) || isDefined(self.favoriteenemy)) {
    return;
  }
  maps\_utility::ent_flag_init("_stealth_behavior_asleep");

  if(isDefined(self.script_pet) || isDefined(self.script_patroller)) {
    return;
  }
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.allowdeath = 1;
  thread maps\_anim::anim_generic_custom_animmode_loop(self, "gravity", "_stealth_dog_sleeping");
  maps\_utility::ent_flag_set("_stealth_behavior_asleep");
}

enemy_custom_state_behavior(var_0) {
  foreach(var_3, var_2 in var_0)
  maps\_stealth_shared_utilities::ai_create_behavior_function("state", var_3, var_2);

  var_4 = self._stealth.behavior.ai_functions["state"]["hidden"];
  thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_4, "enemy_behavior");
  var_4 = self._stealth.behavior.ai_functions["state"]["spotted"];
  thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_4, "enemy_behavior");
}

enemy_default_state_behavior() {
  var_0 = [];
  var_0["hidden"] = ::enemy_state_hidden;
  var_0["spotted"] = ::enemy_state_spotted;
  enemy_custom_state_behavior(var_0);
}

enemy_default_anim_behavior() {
  maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "wrapper", maps\_stealth_shared_utilities::enemy_animation_wrapper);

  if(self.type == "dog") {
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "grenade danger", maps\_stealth_animation_funcs::dog_animation_wakeup_fast);
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "bulletwhizby", maps\_stealth_animation_funcs::dog_animation_wakeup_fast);
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "gunshot_teammate", maps\_stealth_animation_funcs::dog_animation_wakeup_fast);
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "projectile_impact", maps\_stealth_animation_funcs::dog_animation_wakeup_slow);
  } else {
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "grenade danger", maps\_stealth_animation_funcs::enemy_animation_nothing);
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "bulletwhizby", maps\_stealth_animation_funcs::enemy_animation_nothing);
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "gunshot_teammate", maps\_stealth_animation_funcs::enemy_animation_nothing);
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "projectile_impact", maps\_stealth_animation_funcs::enemy_animation_nothing);
  }
}