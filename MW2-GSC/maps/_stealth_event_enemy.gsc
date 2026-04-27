/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_stealth_event_enemy.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_stealth_utility;
#include maps\_stealth_shared_utilities;
#include maps\_stealth_animation_funcs;

stealth_event_enemy_main() {
  self thread enemy_event_Loop();

  self._stealth.plugins.event = true;
}

enemy_event_Loop() {
  self endon("death");
  self endon("pain_death");

  while(1) {
    self waittill("event_awareness", type);

    if(!self ent_flag("_stealth_enabled")) {
      continue;
    }
    if(self stealth_group_spotted_flag()) {
      continue;
    }

    func = self._stealth.behavior.ai_functions["event"];

    if(!isDefined(func[type]))
      continue;
    self thread enemy_event_reaction_wrapper(type);
  }
}

enemy_event_reaction_wrapper(type) {
  spotted_flag = self group_get_flagname("_stealth_spotted");

  self endon("_stealth_enemy_alert_level_change");
  level endon(spotted_flag);
  self endon("death");

  waittillframeend;
  self endon("enemy_awareness_reaction");

  enemy_reaction_state_alert();
  self enemy_find_original_goal();
  self enemy_stop_current_behavior();

  func = self._stealth.behavior.ai_functions["event"][type];
  self[[func]](type);

  self maps\_stealth_threat_enemy::enemy_alert_level_change("reset");
}

enemy_event_reaction_heard_scream(type) {
  origin = self._stealth.logic.event.awareness_param[type];

  wait 0.05;
  ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");

  node = self enemy_find_free_pathnode_near(origin, 300, 40);

  self enemy_investigate_position(node);
}

enemy_event_reaction_flashbang(type) {
  origin = self._stealth.logic.event.awareness_param[type];

  if(self isFlashed() && self.script == "<custom>") {
    wait 0.05;
    self SetFlashBanged(true);
  }

  wait 0.05;
  if(self.script == "flashed")
    self waittill("stop_flashbang_effect");

  node = self enemy_find_free_pathnode_near(origin, 300, 40);

  if(isDefined(node)) {
    self thread enemy_announce_wtf();
    self thread enemy_announce_spotted_bring_group(origin);
  }

  self enemy_investigate_position(node);
}

enemy_event_reaction_explosion(type) {
  origin = self._stealth.logic.event.awareness_param[type];

  wait 0.05;
  ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");

  node = self enemy_find_free_pathnode_near(origin, 300, 40);

  self thread enemy_announce_wtf();
  self enemy_investigate_position(node);
}

enemy_event_reaction_nothing(type) {
  return;
}

enemy_investigate_position(node, position) {
  if(isDefined(node)) {
    wait randomfloat(1);

    self thread enemy_runto_and_lookaround(node, position);

    self.disablearrivals = false;
    self.disableexits = false;

    self waittill("goal");
    wait randomfloatrange(15, 25);
  } else
    wait randomfloatrange(1, 4);
}

stealth_event_mod_all() {
  self stealth_event_mod("heard_scream");
  self stealth_event_mod("doFlashBanged");
  self stealth_event_mod("explode");
}

stealth_event_mod(type, behavior_function, animation_function, event_listener) {
  behavior = stealth_event_defaults();
  animation = self stealth_event_anim_defaults();

  if(!isDefined(behavior_function))
    behavior_function = behavior[type];
  if(!isDefined(animation_function))
    animation_function = animation[type];
  if(!isDefined(event_listener))
    event_listener = stealth_event_listener_defaults(type);

  assertex(isDefined(behavior_function), "tried to set a stealth event of " + type + " to which there is no default behavior for");
  assertex(isDefined(animation_function), "tried to set a stealth event of " + type + " to which there is no default animation for");

  self ai_create_behavior_function("event", type, behavior_function);
  self ai_create_behavior_function("animation", type, animation_function);

  self thread maps\_stealth_visibility_enemy::enemy_event_awareness(type);

  if(event_listener)
    self addAIEventListener(type);

  switch (type) {
    case "explode":
      self.ignoreExplosionEvents = true;
      break;
  }

  self thread enemy_event_debug_print(type);
}

stealth_event_defaults() {
  array = [];
  if(self.type == "dog") {
    array["heard_scream"] = ::enemy_event_reaction_nothing;
    array["doFlashBanged"] = ::enemy_event_reaction_nothing;
  } else {
    array["heard_scream"] = ::enemy_event_reaction_heard_scream;
    array["doFlashBanged"] = ::enemy_event_reaction_flashbang;
  }

  array["explode"] = ::enemy_event_reaction_explosion;

  return array;
}

stealth_event_listener_defaults(type) {
  switch (type) {
    case "heard_scream":
      return false;
    case "doFlashBanged":
      return false;
    case "explode":
      return false;
    default:
      return false;
  }
}

stealth_event_anim_defaults() {
  array = [];
  array["doFlashBanged"] = ::enemy_animation_nothing;

  if(self.type == "dog") {
    array["heard_scream"] = ::dog_animation_generic;
    array["explode"] = ::dog_animation_wakeup_fast;
  } else {
    array["heard_scream"] = ::enemy_animation_generic;
    array["explode"] = ::enemy_animation_generic;
  }

  return array;
}