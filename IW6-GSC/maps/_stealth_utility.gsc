/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_utility.gsc
*****************************************************/

stealth_default() {
  stealth_plugin_basic();

  if(isplayer(self)) {
    return;
  }
  switch (self.team) {
    case "team3":
    case "axis":
      stealth_plugin_threat();
      stealth_enable_seek_player_on_spotted();
      stealth_plugin_corpse();
      stealth_plugin_event_all();
      break;
    case "allies":
      stealth_plugin_aicolor();
      stealth_plugin_accuracy();
      stealth_plugin_smart_stance();
  }
}

stealth_set_default_stealth_function(var_0, var_1) {
  level.stealth_default_func[var_0] = var_1;
}

stealth_plugin_basic(var_0) {
  if(isplayer(self)) {
    maps\_stealth_visibility_friendly::stealth_visibility_friendly_main();
    return;
  }

  if(!isDefined(self._stealth) || !isDefined(self._stealth.plugins.basic)) {
    switch (self.team) {
      case "allies":
        maps\_stealth_visibility_friendly::stealth_visibility_friendly_main();
        maps\_stealth_behavior_friendly::stealth_behavior_friendly_main();
        break;
      case "team3":
      case "axis":
        maps\_stealth_visibility_enemy::stealth_visibility_enemy_main();
        maps\_stealth_behavior_enemy::stealth_behavior_enemy_main();
        break;
    }
  }

  if(isDefined(var_0))
    stealth_basic_states_custom(var_0);

  self._stealth.plugins.basic = 1;
}

stealth_basic_states_custom(var_0) {
  switch (self.team) {
    case "allies":
      maps\_stealth_behavior_friendly::friendly_custom_state_behavior(var_0);
      break;
    case "team3":
    case "axis":
      maps\_stealth_behavior_enemy::enemy_custom_state_behavior(var_0);
      break;
  }
}

stealth_basic_states_default() {
  switch (self.team) {
    case "allies":
      maps\_stealth_behavior_friendly::friendly_default_state_behavior();
      break;
    case "team3":
    case "axis":
      maps\_stealth_behavior_enemy::enemy_default_state_behavior();
      break;
  }
}

stealth_pre_spotted_function_custom(var_0) {
  maps\_stealth_visibility_enemy::enemy_alert_level_set_pre_spotted_func(var_0);
}

stealth_pre_spotted_function_default() {
  maps\_stealth_visibility_enemy::enemy_alert_level_default_pre_spotted_func();
}

stealth_plugin_threat(var_0) {
  if(!isDefined(self._stealth.plugins.threat))
    maps\_stealth_threat_enemy::stealth_threat_enemy_main();

  if(isDefined(var_0))
    stealth_threat_behavior_replace(var_0);
}

stealth_enable_seek_player_on_spotted() {
  self.script_stealth_dontseek = 0;
}

stealth_disable_seek_player_on_spotted() {
  self.script_stealth_dontseek = 1;
}

stealth_threat_behavior_custom(var_0, var_1) {
  if(isDefined(var_0))
    maps\_stealth_threat_enemy::enemy_set_threat_behavior(var_0);

  if(isDefined(var_1))
    maps\_stealth_threat_enemy::enemy_set_threat_anim_behavior(var_1);
}

stealth_threat_behavior_replace(var_0, var_1) {
  var_2 = "threat";
  var_3 = "warning";
  var_4 = 1;
  var_5 = var_3 + var_4;

  if(isDefined(var_0)) {
    while(isDefined(self._stealth.behavior.ai_functions[var_2][var_5])) {
      if(!isDefined(var_0[var_5]))
        var_0[var_5] = maps\_stealth_shared_utilities::ai_get_behavior_function(var_2, var_5);

      var_4++;
      var_5 = var_3 + var_4;
    }
  }

  stealth_threat_behavior_custom(var_0, var_1);
}

stealth_threat_behavior_default_no_warnings() {
  var_0 = [];
  stealth_threat_behavior_custom(var_0);
}

stealth_threat_behavior_default() {
  maps\_stealth_threat_enemy::enemy_default_threat_behavior();
  maps\_stealth_threat_enemy::enemy_default_threat_anim_behavior();
}

stealth_alert_level_duration(var_0) {
  level._stealth.logic.min_alert_level_duration = var_0;
}

stealth_plugin_corpse(var_0) {
  if(!isDefined(self._stealth.plugins.corpse))
    maps\_stealth_corpse_enemy::stealth_corpse_enemy_main();

  if(isDefined(var_0))
    stealth_corpse_behavior_custom(var_0);
}

stealth_corpse_behavior_custom(var_0) {
  maps\_stealth_corpse_enemy::enemy_custom_corpse_behavior(var_0);
}

stealth_corpse_behavior_default() {
  maps\_stealth_corpse_enemy::enemy_default_corpse_behavior();
}

stealth_corpse_forget_time_default() {
  maps\_stealth_corpse_system::stealth_corpse_default_forget_time();
}

stealth_corpse_forget_time_custom(var_0) {
  maps\_stealth_corpse_system::stealth_corpse_set_forget_time(var_0);
}

stealth_corpse_reset_time_default() {
  maps\_stealth_corpse_system::stealth_corpse_default_reset_time();
}

stealth_corpse_reset_time_custom(var_0) {
  maps\_stealth_corpse_system::stealth_corpse_set_reset_time(var_0);
}

stealth_corpse_collect_func(var_0) {
  maps\_stealth_corpse_system::stealth_corpse_set_collect_func(var_0);
}

stealth_corpse_reset_collect_func() {
  maps\_stealth_corpse_system::stealth_corpse_default_collect_func();
}

stealth_plugin_event_all(var_0) {
  stealth_plugin_event_main();
  maps\_stealth_event_enemy::stealth_event_mod_all();

  if(isDefined(var_0)) {
    foreach(var_3, var_2 in var_0)
    maps\_stealth_event_enemy::stealth_event_mod(var_3, var_2);
  }
}

stealth_plugin_event_main() {
  if(!isDefined(self._stealth.plugins.event))
    maps\_stealth_event_enemy::stealth_event_enemy_main();
}

stealth_plugin_event_heard_scream(var_0, var_1) {
  stealth_plugin_event_main();
  maps\_stealth_event_enemy::stealth_event_mod("heard_scream", var_0, var_1);
}

stealth_plugin_event_flashbang(var_0, var_1) {
  stealth_plugin_event_main();
  maps\_stealth_event_enemy::stealth_event_mod("doFlashBanged", var_0, var_1);
}

stealth_plugin_event_explosion(var_0, var_1) {
  stealth_plugin_event_main();
  maps\_stealth_event_enemy::stealth_event_mod("explode", var_0, var_1);
}

stealth_plugin_event_custom(var_0, var_1, var_2, var_3) {
  stealth_plugin_event_main();
  maps\_stealth_event_enemy::stealth_event_mod(var_0, var_1, var_2, var_3);
}

stealth_plugin_aicolor(var_0) {
  if(!isDefined(self._stealth.plugins.color_system))
    maps\_stealth_color_friendly::stealth_color_friendly_main();

  if(isDefined(var_0))
    stealth_color_state_custom(var_0);
}

stealth_color_state_custom(var_0) {
  maps\_stealth_color_friendly::friendly_custom_color_behavior(var_0);
}

stealth_color_state_default() {
  maps\_stealth_color_friendly::friendly_default_color_behavior();
}

stealth_plugin_accuracy(var_0) {
  if(!isDefined(self._stealth.plugins.accaracy_mod))
    maps\_stealth_accuracy_friendly::stealth_accuracy_friendly_main();

  if(isDefined(var_0))
    stealth_accuracy_state_custom(var_0);
}

stealth_accuracy_state_custom(var_0) {
  maps\_stealth_accuracy_friendly::friendly_custom_acc_behavior(var_0);
}

stealth_accuracy_state_default() {
  maps\_stealth_accuracy_friendly::friendly_default_acc_behavior();
}

stealth_plugin_smart_stance() {
  maps\_stealth_smartstance_friendly::stealth_smartstance_friendly_main();
}

enable_stealth_smart_stance() {
  maps\_utility::ent_flag_set("_stealth_stance_handler");
}

disable_stealth_smart_stance() {
  maps\_utility::ent_flag_clear("_stealth_stance_handler");
}

stealth_enemy_waittill_alert() {
  waittillframeend;
  maps\_utility::ent_flag_waitopen("_stealth_normal");
}

stealth_is_everything_normal() {
  var_0 = level._stealth.group.groups;

  foreach(var_7, var_2 in var_0) {
    if(!issubstr(var_7, "allies")) {
      var_3 = maps\_stealth_shared_utilities::group_get_ai_in_group(var_7);

      foreach(var_5 in var_3) {
        if(!var_5 maps\_utility::ent_flag("_stealth_normal"))
          return 0;
      }
    }
  }

  return 1;
}

stealth_enemy_endon_alert() {
  stealth_enemy_waittill_alert();
  waittillframeend;
  self notify("stealth_enemy_endon_alert");
}

stealth_event_handler(var_0, var_1) {
  thread maps\_stealth_shared_utilities::event_awareness_main(var_0, var_1);
}

stealth_detect_ranges_set(var_0, var_1) {
  maps\_stealth_visibility_system::system_set_detect_ranges(var_0, var_1);
}

stealth_detect_ranges_default() {
  maps\_stealth_visibility_system::system_default_detect_ranges();
}

stealth_corpse_ranges_custom(var_0) {
  maps\_stealth_corpse_system::stealth_corpse_set_distances(var_0);
}

stealth_corpse_ranges_default() {
  maps\_stealth_corpse_system::stealth_corpse_default_distances();
}

stealth_ai_event_dist_custom(var_0) {
  var_1 = level._stealth.logic.detection_level;
  maps\_stealth_visibility_system::system_set_event_distances(var_0);
  maps\_stealth_visibility_system::system_event_change(var_1);
}

stealth_ai_event_dist_default() {
  var_0 = level._stealth.logic.detection_level;
  maps\_stealth_visibility_system::system_default_event_distances();
  maps\_stealth_visibility_system::system_event_change(var_0);
}

stealth_friendly_movespeed_scale_set(var_0, var_1) {
  maps\_stealth_visibility_friendly::friendly_set_movespeed_scale(var_0, var_1);
}

stealth_friendly_movespeed_scale_default() {
  maps\_stealth_visibility_friendly::friendly_default_movespeed_scale();
}

stealth_friendly_stance_handler_distances_set(var_0, var_1, var_2) {
  maps\_stealth_smartstance_friendly::friendly_set_stance_handler_distances(var_0, var_1, var_2);
}

stealth_friendly_stance_handler_distances_default() {
  maps\_stealth_smartstance_friendly::friendly_default_stance_handler_distances();
}

stealth_ai_clear_custom_idle_and_react(var_0) {
  maps\_stealth_shared_utilities::ai_clear_custom_animation_reaction_and_idle(var_0);
}

stealth_ai_clear_custom_react() {
  maps\_stealth_shared_utilities::ai_clear_custom_animation_reaction();
}

stealth_ai_idle_and_react(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {}

  var_0 stealth_insure_enabled();
  var_5 = var_0 maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");

  if(common_scripts\utility::flag(var_5)) {
    return;
  }
  var_6 = "stop_loop";
  var_0.allowdeath = 1;

  if(!isDefined(var_4))
    thread maps\_anim::anim_generic_custom_animmode_loop(var_0, "gravity", var_1, var_3);
  else
    thread maps\_anim::anim_generic_loop(var_0, var_1, var_3);

  var_0 maps\_stealth_shared_utilities::ai_set_custom_animation_reaction(self, var_2, var_3, var_6);
  maps\_utility::add_wait(maps\_utility::waittill_msg, "stop_idle_proc");
  maps\_utility::add_func(::stealth_ai_clear_custom_idle_and_react);
  thread do_wait_thread();
}

do_wait_thread() {
  self endon("death");
  maps\_utility::do_wait();
}

stealth_ai_react(var_0, var_1, var_2) {
  var_0 stealth_insure_enabled();
  var_0 maps\_stealth_shared_utilities::ai_set_custom_animation_reaction(self, var_1, var_2, "stop_loop");
}

stealth_ai_reach_idle_and_react(var_0, var_1, var_2, var_3, var_4) {
  var_0 stealth_insure_enabled();
  thread stealth_ai_reach_idle_and_react_proc(var_0, var_1, var_2, var_3, var_4);
}

stealth_ai_reach_idle_and_react_proc(var_0, var_1, var_2, var_3, var_4) {
  var_0 stealth_insure_enabled();
  var_0 thread stealth_enemy_endon_alert();
  var_0 endon("stealth_enemy_endon_alert");
  var_0 endon("death");
  maps\_anim::anim_generic_reach(var_0, var_1, var_4);
  stealth_ai_idle_and_react(var_0, var_2, var_3, var_4);
}

stealth_ai_reach_and_arrive_idle_and_react(var_0, var_1, var_2, var_3, var_4) {
  var_0 stealth_insure_enabled();
  thread stealth_ai_reach_and_arrive_idle_and_react_proc(var_0, var_1, var_2, var_3, var_4);
}

stealth_ai_reach_and_arrive_idle_and_react_proc(var_0, var_1, var_2, var_3, var_4) {
  var_0 stealth_insure_enabled();
  var_0 thread stealth_enemy_endon_alert();
  var_0 endon("stealth_enemy_endon_alert");
  var_0 endon("death");
  maps\_anim::anim_generic_reach_and_arrive(var_0, var_1, var_4);
  stealth_ai_idle_and_react(var_0, var_2, var_3, var_4);
}

stealth_insure_enabled() {}

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
  var_0 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
  return common_scripts\utility::flag(var_0);
}

stealth_group_corpse_flag() {
  var_0 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
  return common_scripts\utility::flag(var_0);
}

stealth_group_spotted_flag_wait() {
  var_0 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
  common_scripts\utility::flag_wait(var_0);
}

stealth_group_corpse_flag_wait() {
  var_0 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
  common_scripts\utility::flag_wait(var_0);
}

stealth_group_spotted_flag_waitopen() {
  var_0 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
  return common_scripts\utility::flag_waitopen(var_0);
}

stealth_group_corpse_flag_waitopen() {
  var_0 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
  return common_scripts\utility::flag_waitopen(var_0);
}

stealth_get_group_spotted_flag() {
  return maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
}

stealth_get_group_corpse_flag() {
  return maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
}

stealth_set_group(var_0) {
  stealth_set_group_proc(var_0);
}

stealth_set_group_default() {
  stealth_set_group_proc("default");
}

stealth_set_group_proc(var_0) {
  if(isDefined(self.script_stealthgroup))
    level._stealth.group.groups[self.script_stealthgroup] = common_scripts\utility::array_remove(level._stealth.group.groups[self.script_stealthgroup], self);

  self.script_stealthgroup = maps\_utility::string(var_0);

  if(isDefined(self._stealth.plugins.basic)) {
    maps\_stealth_shared_utilities::group_flag_init("_stealth_spotted");
    maps\_stealth_shared_utilities::group_flag_init("_stealth_event");
    maps\_stealth_shared_utilities::group_flag_init("_stealth_found_corpse");
    maps\_stealth_shared_utilities::group_add_to_global_list();
  }
}

stealth_get_group() {
  return self.script_stealthgroup;
}

enable_stealth_system() {
  common_scripts\utility::flag_set("_stealth_enabled");
  var_0 = getaispeciesarray("all", "all");

  foreach(var_3, var_2 in var_0)
  var_2 enable_stealth_for_ai();

  foreach(var_5 in level.players) {
    if(var_5 maps\_utility::ent_flag_exist("_stealth_enabled"))
      var_5 maps\_utility::ent_flag_set("_stealth_enabled");

    var_5 maps\_stealth_visibility_friendly::friendly_visibility_logic();
  }

  maps\_stealth_visibility_system::system_event_change("hidden");
}

disable_stealth_system() {
  common_scripts\utility::flag_clear("_stealth_enabled");
  var_0 = getaispeciesarray("all", "all");

  foreach(var_3, var_2 in var_0)
  var_2 disable_stealth_for_ai();

  foreach(var_5 in level.players) {
    var_5.maxvisibledist = 8192;

    if(var_5 maps\_utility::ent_flag_exist("_stealth_enabled"))
      var_5 maps\_utility::ent_flag_clear("_stealth_enabled");
  }

  maps\_stealth_visibility_system::system_event_change("spotted");
}

enable_stealth_for_ai() {
  if(maps\_utility::ent_flag_exist("_stealth_enabled"))
    maps\_utility::ent_flag_set("_stealth_enabled");

  if(self.team == "allies")
    thread maps\_stealth_visibility_friendly::friendly_visibility_logic();
}

disable_stealth_for_ai() {
  if(maps\_utility::ent_flag_exist("_stealth_enabled"))
    maps\_utility::ent_flag_clear("_stealth_enabled");

  self.maxvisibledist = 8192;
}