/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_event_enemy.gsc
*****************************************/

stealth_event_enemy_main() {
  thread enemy_event_loop();
  self._stealth.plugins.event = 1;
}

enemy_event_loop() {
  self endon("death");
  self endon("pain_death");

  for(;;) {
    self waittill("event_awareness", var_0);

    if(!maps\_utility::ent_flag("_stealth_enabled")) {
      continue;
    }
    if(maps\_stealth_utility::stealth_group_spotted_flag()) {
      continue;
    }
    var_1 = self._stealth.behavior.ai_functions["event"];

    if(!isDefined(var_1[var_0])) {
      continue;
    }
    thread enemy_event_reaction_wrapper(var_0);
  }
}

enemy_event_reaction_wrapper(var_0) {
  var_1 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
  self endon("_stealth_enemy_alert_level_change");
  level endon(var_1);
  self endon("death");
  waittillframeend;
  self endon("enemy_awareness_reaction");
  self endon("event_awareness");
  maps\_stealth_shared_utilities::enemy_reaction_state_alert();
  maps\_stealth_shared_utilities::enemy_find_original_goal();
  maps\_stealth_shared_utilities::enemy_stop_current_behavior();
  var_2 = self._stealth.behavior.ai_functions["event"][var_0];
  self[[var_2]](var_0);
  maps\_stealth_threat_enemy::enemy_alert_level_change("reset");
}

enemy_event_reaction_heard_scream(var_0) {
  var_1 = self._stealth.logic.event.awareness_param[var_0];
  wait 0.05;
  maps\_utility::ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");
  var_2 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(var_1, 300, 40);
  enemy_investigate_position(var_2);
}

enemy_event_reaction_flashbang(var_0) {
  var_1 = self._stealth.logic.event.awareness_param[var_0];

  if(common_scripts\utility::isflashed() && self.script == "<custom>") {
    wait 0.05;
    self setflashbanged(1);
  }

  wait 0.05;

  if(self.script == "flashed")
    self waittill("stop_flashbang_effect");

  var_2 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(var_1, 300, 40);

  if(isDefined(var_2)) {
    thread maps\_stealth_shared_utilities::enemy_announce_wtf();
    thread maps\_stealth_shared_utilities::enemy_announce_spotted_bring_group(var_1);
  }

  enemy_investigate_position(var_2, undefined, 1);
}

enemy_event_reaction_explosion(var_0) {
  var_1 = self._stealth.logic.event.awareness_param[var_0];
  wait 0.05;
  maps\_utility::ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");
  var_2 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(var_1, 300, 40);
  thread maps\_stealth_shared_utilities::enemy_announce_wtf();
  enemy_investigate_position(var_2, undefined, 1);
}

enemy_event_reaction_nothing(var_0) {
  return;
}

enemy_investigate_position(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    wait(randomfloat(1));

    if(isDefined(var_2) && var_2)
      thread maps\_stealth_shared_utilities::enemy_react_and_displace_to(var_0, var_1);

    thread maps\_stealth_shared_utilities::enemy_runto_and_lookaround(var_0, var_1);
    self.disablearrivals = 0;
    self.disableexits = 0;
    self waittill("goal");
    wait(randomfloatrange(15, 25));
  } else
    wait(randomfloatrange(1, 4));
}

stealth_event_mod_all() {
  stealth_event_mod("heard_scream");
  stealth_event_mod("doFlashBanged");
  stealth_event_mod("explode");
}

stealth_event_mod(var_0, var_1, var_2, var_3) {
  var_4 = stealth_event_defaults();
  var_5 = stealth_event_anim_defaults();

  if(!isDefined(var_1))
    var_1 = var_4[var_0];

  if(!isDefined(var_2))
    var_2 = var_5[var_0];

  if(!isDefined(var_3))
    var_3 = stealth_event_listener_defaults(var_0);

  maps\_stealth_shared_utilities::ai_create_behavior_function("event", var_0, var_1);
  maps\_stealth_shared_utilities::ai_create_behavior_function("animation", var_0, var_2);
  thread maps\_stealth_visibility_enemy::enemy_event_awareness(var_0);

  if(var_3)
    self addaieventlistener(var_0);

  switch (var_0) {
    case "explode":
      self.ignoreexplosionevents = 1;
      break;
  }
}

stealth_event_defaults() {
  var_0 = [];

  if(self.type == "dog") {
    var_0["heard_scream"] = ::enemy_event_reaction_nothing;
    var_0["doFlashBanged"] = ::enemy_event_reaction_nothing;
  } else {
    var_0["heard_scream"] = ::enemy_event_reaction_heard_scream;
    var_0["doFlashBanged"] = ::enemy_event_reaction_flashbang;
  }

  var_0["explode"] = ::enemy_event_reaction_explosion;
  return var_0;
}

stealth_event_listener_defaults(var_0) {
  switch (var_0) {
    case "heard_scream":
      return 0;
    case "doFlashBanged":
      return 0;
    case "explode":
      return 0;
    default:
      return 0;
  }
}

stealth_event_anim_defaults() {
  var_0 = [];
  var_0["doFlashBanged"] = maps\_stealth_animation_funcs::enemy_animation_nothing;

  if(self.type == "dog") {
    var_0["heard_scream"] = maps\_stealth_animation_funcs::dog_animation_generic;
    var_0["explode"] = maps\_stealth_animation_funcs::dog_animation_wakeup_fast;
  } else {
    var_0["heard_scream"] = maps\_stealth_animation_funcs::enemy_animation_generic;
    var_0["explode"] = maps\_stealth_animation_funcs::enemy_animation_nothing;
  }

  return var_0;
}