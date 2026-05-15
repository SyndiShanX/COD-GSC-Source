/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_stealth_utility.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;

stealth_default() {
  self stealth_plugin_basic();

  if(isPlayer(self)) {
    return;
  }
  switch (self.team) {
    case "axis":
    case "team3":
      self stealth_plugin_threat();
      self stealth_enable_seek_player_on_spotted();
      self stealth_plugin_corpse();
      self stealth_plugin_event_all();
      break;

    case "allies":
      self stealth_plugin_aicolor();
      self stealth_plugin_accuracy();
      self stealth_plugin_smart_stance();
  }
}

stealth_set_default_stealth_function(key, func) {
  level.stealth_default_func[key] = func;
}

stealth_plugin_basic(custom_state_funcs) {
  assertex(isDefined(level._stealth.logic), "call maps\_stealth::main()");

  if(isPlayer(self)) {
    self maps\_stealth_visibility_friendly::stealth_visibility_friendly_main();
    return;
  }

  if(!isDefined(self._stealth) || !isDefined(self._stealth.plugins.basic)) {
    switch (self.team) {
      case "allies":
        self maps\_stealth_visibility_friendly::stealth_visibility_friendly_main();
        self maps\_stealth_behavior_friendly::stealth_behavior_friendly_main();
        break;
      case "axis":
      case "team3":
        self maps\_stealth_visibility_enemy::stealth_visibility_enemy_main();
        self maps\_stealth_behavior_enemy::stealth_behavior_enemy_main();
        break;
    }
  }
  if(isDefined(custom_state_funcs)) {
    self stealth_basic_states_custom(custom_state_funcs);
  }

  self._stealth.plugins.basic = true;
}

stealth_basic_states_custom(array) {
  switch (self.team) {
    case "allies":
      self maps\_stealth_behavior_friendly::friendly_custom_state_behavior(array);
      break;
    case "axis":
    case "team3":
      self maps\_stealth_behavior_enemy::enemy_custom_state_behavior(array);
      break;
  }
}

stealth_basic_states_default() {
  switch (self.team) {
    case "allies":
      self maps\_stealth_behavior_friendly::friendly_default_state_behavior();
      break;
    case "axis":
    case "team3":
      self maps\_stealth_behavior_enemy::enemy_default_state_behavior();
      break;
  }
}

stealth_pre_spotted_function_custom(func) {
  assertex(isDefined(self._stealth.plugins.basic), "call maps\_stealth_utility::stealth_plugin_basic() on the AI first");

  self maps\_stealth_visibility_enemy::enemy_alert_level_set_pre_spotted_func(func);
}

stealth_pre_spotted_function_default() {
  assertex(isDefined(self._stealth.plugins.basic), "call maps\_stealth_utility::stealth_plugin_basic() on the AI first");

  self maps\_stealth_visibility_enemy::enemy_alert_level_default_pre_spotted_func();
}

stealth_plugin_threat(custom_behavior_array) {
  assertex(isDefined(self._stealth.plugins.basic), "call maps\_stealth_utility::stealth_plugin_basic() on the AI first");
  assertex(self isBadGuy(), "stealth_plugin_accuracy is a plugin for enemies only");

  if(!isDefined(self._stealth.plugins.threat)) {
    self maps\_stealth_threat_enemy::stealth_threat_enemy_main();
  }

  if(isDefined(custom_behavior_array)) {
    self stealth_threat_behavior_replace(custom_behavior_array);
  }
}

stealth_enable_seek_player_on_spotted() {
  assertex(isDefined(self._stealth.plugins.threat), "call maps\_stealth_utility::stealth_plugin_threat() on the AI first");

  self.script_stealth_dontseek = false;
}

stealth_disable_seek_player_on_spotted() {
  assertex(isDefined(self._stealth.plugins.threat), "call maps\_stealth_utility::stealth_plugin_threat() on the AI first");

  self.script_stealth_dontseek = true;
}

stealth_threat_behavior_custom(threat_array, anim_array) {
  assertex(isDefined(self._stealth.plugins.threat), "call maps\_stealth_utility::stealth_plugin_threat() on the AI first");

  if(isDefined(threat_array)) {
    self maps\_stealth_threat_enemy::enemy_set_threat_behavior(threat_array);
  }
  if(isDefined(anim_array)) {
    self maps\_stealth_threat_enemy::enemy_set_threat_anim_behavior(anim_array);
  }
}

stealth_threat_behavior_replace(threat_array, anim_array) {
  name = "threat";
  string = "warning";
  num = 1;
  key = string + num;

  if(isDefined(threat_array)) {
    while(isDefined(self._stealth.behavior.ai_functions[name][key])) {
      if(!isDefined(threat_array[key])) {
        threat_array[key] = maps\_stealth_shared_utilities::ai_get_behavior_function(name, key);
      }
      num++;
      key = string + num;
    }
  }

  self stealth_threat_behavior_custom(threat_array, anim_array);
}

stealth_threat_behavior_default_no_warnings() {
  array = [];
  self stealth_threat_behavior_custom(array);
}

stealth_threat_behavior_default() {
  assertex(isDefined(self._stealth.plugins.threat), "call maps\_stealth_utility::stealth_plugin_threat() on the AI first");

  self maps\_stealth_threat_enemy::enemy_default_threat_behavior();
  self maps\_stealth_threat_enemy::enemy_default_threat_anim_behavior();
}

stealth_alert_level_duration(time) {
  level._stealth.logic.min_alert_level_duration = time;
}

stealth_plugin_corpse(custom_corpse_array) {
  assertex(isDefined(self._stealth.plugins.basic), "call maps\_stealth_utility::stealth_plugin_basic() on the AI first");
  assertex(self isBadGuy(), "stealth_plugin_accuracy is a plugin for enemies only");

  if(!isDefined(self._stealth.plugins.corpse)) {
    self maps\_stealth_corpse_enemy::stealth_corpse_enemy_main();
  }

  if(isDefined(custom_corpse_array)) {
    self stealth_corpse_behavior_custom(custom_corpse_array);
  }
}

stealth_corpse_behavior_custom(corpse_functions) {
  assertex(isDefined(self._stealth.plugins.corpse), "call maps\_stealth_utility::stealth_plugin_corpse() on the AI first");

  self maps\_stealth_corpse_enemy::enemy_custom_corpse_behavior(corpse_functions);
}

stealth_corpse_behavior_default() {
  assertex(isDefined(self._stealth.plugins.corpse), "call maps\_stealth_utility::stealth_plugin_corpse() on the AI first");

  self maps\_stealth_corpse_enemy::enemy_default_corpse_behavior();
}

stealth_corpse_forget_time_default() {
  maps\_stealth_corpse_system::stealth_corpse_default_forget_time();
}

stealth_corpse_forget_time_custom(time) {
  maps\_stealth_corpse_system::stealth_corpse_set_forget_time(time);
}

stealth_corpse_reset_time_default() {
  maps\_stealth_corpse_system::stealth_corpse_default_reset_time();
}

stealth_corpse_reset_time_custom(time) {
  maps\_stealth_corpse_system::stealth_corpse_set_reset_time(time);
}

stealth_plugin_event_all(array) {
  assertex(isDefined(self._stealth.plugins.basic), "call maps\_stealth_utility::stealth_plugin_basic() on the AI first");

  self stealth_plugin_event_main();
  self maps\_stealth_event_enemy::stealth_event_mod_all();

  if(isDefined(array)) {
    foreach(key, value in array) {
      self maps\_stealth_event_enemy::stealth_event_mod(key, value);
    }
  }
}

stealth_plugin_event_main() {
  assertex(self isBadGuy(), "stealth_plugin_accuracy is a plugin for enemies only");

  if(!isDefined(self._stealth.plugins.event)) {
    self maps\_stealth_event_enemy::stealth_event_enemy_main();
  }
}

stealth_plugin_event_heard_scream(behavior_function, animation_function) {
  assertex(isDefined(self._stealth.plugins.basic), "call maps\_stealth_utility::stealth_plugin_basic() on the AI first");

  self stealth_plugin_event_main();
  self maps\_stealth_event_enemy::stealth_event_mod("heard_scream", behavior_function, animation_function);
}

stealth_plugin_event_flashbang(behavior_function, animation_function) {
  assertex(isDefined(self._stealth.plugins.basic), "call maps\_stealth_utility::stealth_plugin_basic() on the AI first");

  self stealth_plugin_event_main();
  self maps\_stealth_event_enemy::stealth_event_mod("doFlashBanged", behavior_function, animation_function);
}

stealth_plugin_event_explosion(behavior_function, animation_function) {
  assertex(isDefined(self._stealth.plugins.basic), "call maps\_stealth_utility::stealth_plugin_basic() on the AI first");

  self stealth_plugin_event_main();
  self maps\_stealth_event_enemy::stealth_event_mod("explode", behavior_function, animation_function);
}

stealth_plugin_event_custom(type, behavior_function, animation_function, event_listener) {
  assertex(isDefined(self._stealth.plugins.basic), "call maps\_stealth_utility::stealth_plugin_basic() on the AI first");

  self stealth_plugin_event_main();
  self maps\_stealth_event_enemy::stealth_event_mod(type, behavior_function, animation_function, event_listener);
}

stealth_plugin_aicolor(custom_color_array) {
  assertex(isDefined(self._stealth.plugins.basic), "call maps\_stealth_utility::stealth_plugin_basic() on the AI first");
  assertex(self.team == "allies", "stealth_plugin_accuracy is a plugin for friendlies only");

  if(!isDefined(self._stealth.plugins.color_system)) {
    self maps\_stealth_color_friendly::stealth_color_friendly_main();
  }

  if(isDefined(custom_color_array)) {
    self stealth_color_state_custom(custom_color_array);
  }
}

stealth_color_state_custom(array) {
  assertex(isDefined(self._stealth.plugins.color_system), "call maps\_stealth_utility::stealth_plugin_aicolor() on the AI first");

  self maps\_stealth_color_friendly::friendly_custom_color_behavior(array);
}

stealth_color_state_default() {
  assertex(isDefined(self._stealth.plugins.color_system), "call maps\_stealth_utility::stealth_plugin_aicolor() on the AI first");

  self maps\_stealth_color_friendly::friendly_default_color_behavior();
}

stealth_plugin_accuracy(custom_acc_array) {
  assertex(isDefined(self._stealth.plugins.basic), "call maps\_stealth_utility::stealth_plugin_basic() on the AI first");
  assertex(self.team == "allies", "stealth_plugin_accuracy is a plugin for friendlies only");

  if(!isDefined(self._stealth.plugins.accaracy_mod)) {
    self maps\_stealth_accuracy_friendly::stealth_accuracy_friendly_main();
  }

  if(isDefined(custom_acc_array)) {
    self stealth_accuracy_state_custom(custom_acc_array);
  }
}

stealth_accuracy_state_custom(array) {
  assertex(isDefined(self._stealth.plugins.accaracy_mod), "call maps\_stealth_utility::stealth_plugin_accuracy() on the AI first");

  self maps\_stealth_accuracy_friendly::friendly_custom_acc_behavior(array);
}

stealth_accuracy_state_default() {
  assertex(isDefined(self._stealth.plugins.accaracy_mod), "call maps\_stealth_utility::stealth_plugin_accuracy() on the AI first");

  self maps\_stealth_accuracy_friendly::friendly_default_acc_behavior();
}

stealth_plugin_smart_stance() {
  assertex(isDefined(self._stealth.plugins.basic), "call maps\_stealth_utility::stealth_plugin_basic() on the AI first");
  assertex(self.team == "allies", "stealth_plugin_accuracy is a plugin for friendlies only");

  self maps\_stealth_smartstance_friendly::stealth_smartstance_friendly_main();
}

enable_stealth_smart_stance() {
  assertex(isDefined(self._stealth.plugins.smartstance), "call maps\_stealth_utility::stealth_plugin_smart_stance() on the AI first");

  self ent_flag_set("_stealth_stance_handler");
}

disable_stealth_smart_stance() {
  assertex(isDefined(self._stealth.plugins.smartstance), "call maps\_stealth_utility::stealth_plugin_smart_stance() on the AI first");

  self ent_flag_clear("_stealth_stance_handler");
}

stealth_enemy_waittill_alert() {
  waittillframeend;

  self ent_flag_waitopen("_stealth_normal");
}

stealth_is_everything_normal() {
  groups = level._stealth.group.groups;

  foreach(key, value in groups) {
    ai = maps\_stealth_shared_utilities::group_get_ai_in_group(key);

    foreach(actor in ai) {
      if(!actor ent_flag("_stealth_normal")) {
        return false;
      }
    }
  }

  return true;
}

stealth_enemy_endon_alert() {
  stealth_enemy_waittill_alert();

  waittillframeend;
  self notify("stealth_enemy_endon_alert");
}

stealth_event_handler(dialogue_array, ender_array) {
  thread maps\_stealth_shared_utilities::event_awareness_main(dialogue_array, ender_array);
}

stealth_detect_ranges_set(hidden, spotted) {
  maps\_stealth_visibility_system::system_set_detect_ranges(hidden, spotted);
}

stealth_detect_ranges_default() {
  maps\_stealth_visibility_system::system_default_detect_ranges();
}

stealth_corpse_ranges_custom(distances) {
  maps\_stealth_corpse_system::stealth_corpse_set_distances(distances);
}

stealth_corpse_ranges_default() {
  maps\_stealth_corpse_system::stealth_corpse_default_distances();
}

stealth_ai_event_dist_custom(array) {
  state = level._stealth.logic.detection_level;

  maps\_stealth_visibility_system::system_set_event_distances(array);
  maps\_stealth_visibility_system::system_event_change(state);
}

stealth_ai_event_dist_default() {
  state = level._stealth.logic.detection_level;

  maps\_stealth_visibility_system::system_default_event_distances();
  maps\_stealth_visibility_system::system_event_change(state);
}

stealth_friendly_movespeed_scale_set(hidden, spotted) {
  self maps\_stealth_visibility_friendly::friendly_set_movespeed_scale(hidden, spotted);
}

stealth_friendly_movespeed_scale_default() {
  self maps\_stealth_visibility_friendly::friendly_default_movespeed_scale();
}

stealth_friendly_stance_handler_distances_set(looking_away, neutral, looking_towards) {
  self maps\_stealth_smartstance_friendly::friendly_set_stance_handler_distances(looking_away, neutral, looking_towards);
}

stealth_friendly_stance_handler_distances_default() {
  self maps\_stealth_smartstance_friendly::friendly_default_stance_handler_distances();
}

stealth_ai_clear_custom_idle_and_react(wait_anim_end) {
  self maps\_stealth_shared_utilities::ai_clear_custom_animation_reaction_and_idle(wait_anim_end);
}

stealth_ai_clear_custom_react() {
  self maps\_stealth_shared_utilities::ai_clear_custom_animation_reaction();
}

stealth_ai_idle_and_react(guy, idle_anim, reaction_anim, tag) {
  guy stealth_insure_enabled();

  spotted_flag = guy maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");

  if(flag(spotted_flag)) {
    return;
  }
  ender = "stop_loop";

  guy.allowdeath = true;

  self thread maps\_anim::anim_generic_custom_animmode_loop(guy, "gravity", idle_anim, tag);
  guy maps\_stealth_shared_utilities::ai_set_custom_animation_reaction(self, reaction_anim, tag, ender);

  self add_wait(::waittill_msg, "stop_idle_proc");
  self add_func(::stealth_ai_clear_custom_idle_and_react);

  self thread do_wait_thread();
}
do_wait_thread() {
  self endon("death");
  self do_wait();
}

stealth_ai_react(guy, reaction_anim, tag) {
  guy stealth_insure_enabled();
  guy maps\_stealth_shared_utilities::ai_set_custom_animation_reaction(self, reaction_anim, tag, "stop_loop");
}

stealth_ai_reach_idle_and_react(guy, reach_anim, idle_anim, reaction_anim, tag) {
  guy stealth_insure_enabled();
  self thread stealth_ai_reach_idle_and_react_proc(guy, reach_anim, idle_anim, reaction_anim, tag);
}

stealth_ai_reach_idle_and_react_proc(guy, reach_anim, idle_anim, reaction_anim, tag) {
  guy stealth_insure_enabled();

  guy thread stealth_enemy_endon_alert();
  guy endon("stealth_enemy_endon_alert");
  guy endon("death");

  self maps\_anim::anim_generic_reach(guy, reach_anim, tag);
  stealth_ai_idle_and_react(guy, idle_anim, reaction_anim, tag);
}

stealth_ai_reach_and_arrive_idle_and_react(guy, reach_anim, idle_anim, reaction_anim, tag) {
  guy stealth_insure_enabled();
  self thread stealth_ai_reach_and_arrive_idle_and_react_proc(guy, reach_anim, idle_anim, reaction_anim, tag);
}

stealth_ai_reach_and_arrive_idle_and_react_proc(guy, reach_anim, idle_anim, reaction_anim, tag) {
  guy stealth_insure_enabled();

  guy thread stealth_enemy_endon_alert();
  guy endon("stealth_enemy_endon_alert");
  guy endon("death");

  self maps\_anim::anim_generic_reach_and_arrive(guy, reach_anim, tag);
  stealth_ai_idle_and_react(guy, idle_anim, reaction_anim, tag);
}

stealth_insure_enabled() {
  assertex(isDefined(self._stealth.plugins.basic), "call maps\_stealth_utility::stealth_plugin_basic() on the AI first");
}

stealth_group_return_groups_with_spotted_flag() {
  return maps\_stealth_shared_utilities::group_return_groups_with_flag_set("_stealth_spotted");
}

stealth_group_return_groups_with_event_flag() {
  return maps\_stealth_shared_utilities::group_return_groups_with_flag_set("_stealth_event");
}

stealth_group_return_groups_with_corpse_flag() {
  return maps\_stealth_shared_utilities::group_return_groups_with_flag_set("_stealth_found_corpse");
}

stealth_group_return_ai_with_spotted_flag() {
  return maps\_stealth_shared_utilities::group_return_ai_with_flag_set("_stealth_spotted");
}

stealth_group_return_ai_with_event_flag() {
  return maps\_stealth_shared_utilities::group_return_ai_with_flag_set("_stealth_event");
}

stealth_group_return_ai_with_corpse_flag() {
  return maps\_stealth_shared_utilities::group_return_ai_with_flag_set("_stealth_found_corpse");
}

stealth_group_spotted_flag() {
  name = self maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
  return flag(name);
}

stealth_group_corpse_flag() {
  name = self maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
  return flag(name);
}

stealth_group_spotted_flag_wait() {
  name = self maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
  flag_wait(name);
}

stealth_group_corpse_flag_wait() {
  name = self maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
  flag_wait(name);
}

stealth_group_spotted_flag_waitopen() {
  name = self maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
  return flag_waitopen(name);
}

stealth_group_corpse_flag_waitopen() {
  name = self maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
  return flag_waitopen(name);
}

stealth_get_group_spotted_flag() {
  return self maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
}

stealth_get_group_corpse_flag() {
  return self maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
}

stealth_set_group(var) {
  self stealth_set_group_proc(var);
}

stealth_set_group_default() {
  self stealth_set_group_proc("default");
}

stealth_set_group_proc(var) {
  if(isDefined(self.script_stealthgroup)) {
    level._stealth.group.groups[self.script_stealthgroup] = array_remove(level._stealth.group.groups[self.script_stealthgroup], self);
  }

  self.script_stealthgroup = string(var);

  if(isDefined(self._stealth.plugins.basic)) {
    self maps\_stealth_shared_utilities::group_flag_init("_stealth_spotted");
    self maps\_stealth_shared_utilities::group_flag_init("_stealth_event");
    self maps\_stealth_shared_utilities::group_flag_init("_stealth_found_corpse");
    self maps\_stealth_shared_utilities::group_add_to_global_list();
  }
}

stealth_get_group() {
  return self.script_stealthgroup;
}

enable_stealth_system() {
  flag_set("_stealth_enabled");
  ai = getaispeciesarray("all", "all");
  foreach(key, value in ai) {
    value enable_stealth_for_ai();
  }

  foreach(player in level.players) {
    player maps\_stealth_visibility_friendly::friendly_visibility_logic();
  }

  maps\_stealth_visibility_system::system_event_change("hidden");
}

disable_stealth_system() {
  flag_clear("_stealth_enabled");
  ai = getaispeciesarray("all", "all");
  foreach(key, value in ai) {
    value disable_stealth_for_ai();
  }

  foreach(player in level.players) {
    player.maxVisibleDist = 8192;

    if(player ent_flag_exist("_stealth_enabled")) {
      player ent_flag_clear("_stealth_enabled");
    }
  }

  maps\_stealth_visibility_system::system_event_change("spotted");
}

enable_stealth_for_ai() {
  if(self ent_flag_exist("_stealth_enabled")) {
    self ent_flag_set("_stealth_enabled");
  }

  if(self.team == "allies") {
    self maps\_stealth_visibility_friendly::friendly_visibility_logic();
  }
}

disable_stealth_for_ai() {
  if(self ent_flag_exist("_stealth_enabled")) {
    self ent_flag_clear("_stealth_enabled");
  }

  self.maxVisibleDist = 8192;
}