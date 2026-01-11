/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_shared_utilities.gsc
**********************************************/

ai_message_handler_spotted(var_0, var_1) {
  self endon("death");
  var_1 = var_1 + "spotted";
  self notify(var_1);
  self endon(var_1);

  switch (self.team) {
    case "allies":
      for(;;) {
        maps\_utility::ent_flag_wait("_stealth_enabled");
        maps\_stealth_utility::stealth_group_spotted_flag_wait();

        if(!maps\_utility::ent_flag("_stealth_enabled")) {
          continue;
        }
        self thread[[var_0]]();
        maps\_stealth_utility::stealth_group_spotted_flag_waitopen();
      }

      break;
    case "team3":
    case "axis":
      for(;;) {
        maps\_utility::ent_flag_wait("_stealth_enabled");
        maps\_stealth_utility::stealth_group_spotted_flag_wait();

        if(!maps\_utility::ent_flag("_stealth_enabled")) {
          continue;
        }
        self thread[[var_0]]();
        maps\_stealth_utility::stealth_group_spotted_flag_waitopen();
      }

      break;
  }
}

ai_message_handler_hidden(var_0, var_1) {
  self endon("death");
  var_1 = var_1 + "hidden";
  self notify(var_1);
  self endon(var_1);

  switch (self.team) {
    case "allies":
      for(;;) {
        maps\_utility::ent_flag_wait("_stealth_enabled");
        common_scripts\utility::flag_waitopen("_stealth_spotted");

        if(!maps\_utility::ent_flag("_stealth_enabled")) {
          continue;
        }
        self thread[[var_0]]();
        common_scripts\utility::flag_wait("_stealth_spotted");
      }

      break;
    case "team3":
    case "axis":
      for(;;) {
        maps\_utility::ent_flag_wait("_stealth_enabled");
        maps\_stealth_utility::stealth_group_spotted_flag_waitopen();

        if(!maps\_utility::ent_flag("_stealth_enabled")) {
          continue;
        }
        self thread[[var_0]]();
        maps\_stealth_utility::stealth_group_spotted_flag_wait();
      }

      break;
  }
}

ai_create_behavior_function(var_0, var_1, var_2) {
  self._stealth.behavior.ai_functions[var_0][var_1] = var_2;
}

ai_get_behavior_function(var_0, var_1) {
  return self._stealth.behavior.ai_functions[var_0][var_1];
}

ai_set_goback_override_function(var_0) {
  self._stealth.behavior.goback_startfunc = var_0;
}

stealth_event_validate(var_0) {
  if(var_0 == "heard_scream" || var_0 == "doFlashBanged" || var_0 == "explode") {
    return 1;
  }

  return 0;
}

stealth_debug_print(var_0) {}

enemy_event_debug_print(var_0) {
  setdvarifuninitialized("stealth_debug_prints", "0");

  if(!isDefined(getdvar("stealth_debug_prints"))) {
    setdvar("stealth_debug_prints", "0");
  }

  if(getdvarint("stealth_debug_prints") != 1) {
    return;
  }
}

stealth_flag_debug_print(var_0) {}

group_flag_init(var_0) {
  if(isDefined(self.script_stealthgroup)) {
    self.script_stealthgroup = maps\_utility::string(self.script_stealthgroup);
  }
  else {
    self.script_stealthgroup = "default";
  }

  if(self.team == "allies") {
    self.script_stealthgroup = self.script_stealthgroup + "allies";
  }

  var_1 = group_get_flagname(var_0);

  if(!common_scripts\utility::flag_exist(var_1)) {
    common_scripts\utility::flag_init(var_1);

    if(!isDefined(level._stealth.group.flags[var_0])) {
      level._stealth.group.flags[var_0] = [];
    }

    var_2 = level._stealth.group.flags[var_0].size;
    level._stealth.group.flags[var_0][var_2] = var_1;
  }
}

group_add_to_global_list() {
  if(!isDefined(level._stealth.group.groups[self.script_stealthgroup])) {
    level._stealth.group.groups[self.script_stealthgroup] = [];
    level._stealth.group notify(self.script_stealthgroup);
  }

  var_0 = level._stealth.group.groups[self.script_stealthgroup].size;
  level._stealth.group.groups[self.script_stealthgroup][var_0] = self;
}

group_get_flagname(var_0) {
  return group_get_flagname_from_group(var_0, self.script_stealthgroup);
}

group_get_flagname_from_group(var_0, var_1) {
  var_2 = var_0 + "-Group:" + var_1;
  return var_2;
}

group_flag_set(var_0) {
  var_1 = group_get_flagname(var_0);
  common_scripts\utility::flag_set(var_1);
  common_scripts\utility::flag_set(var_0);
}

group_return_groups_with_flag_set(var_0) {
  var_1 = [];
  var_2 = level._stealth.group.groups;

  foreach(var_6, var_4 in var_2) {
    var_5 = group_get_flagname_from_group(var_0, var_6);

    if(common_scripts\utility::flag(var_5)) {
      var_1[var_1.size] = var_6;
    }
  }

  return var_1;
}

group_return_ai_with_flag_set(var_0) {
  var_1 = [];
  var_2 = level._stealth.group.groups;

  foreach(var_7, var_4 in var_2) {
    var_5 = group_get_flagname_from_group(var_0, var_7);

    if(common_scripts\utility::flag(var_5)) {
      var_6 = group_get_ai_in_group(var_7);
      var_1 = maps\_utility::array_merge(var_1, var_6);
    }
  }

  return var_1;
}

group_flag_clear(var_0, var_1) {
  var_2 = group_get_flagname_from_group(var_0, var_1);
  common_scripts\utility::flag_clear(var_2);
  var_3 = level._stealth.group.flags[var_0];
  var_4 = 1;

  foreach(var_7, var_6 in var_3) {
    if(!issubstr(var_6, "allies") && common_scripts\utility::flag(var_6)) {
      return;
    }
  }

  common_scripts\utility::flag_clear(var_0);
}

group_get_ai_in_group(var_0) {
  level._stealth.group.groups[var_0] = maps\_utility::array_removedead(level._stealth.group.groups[var_0]);
  return level._stealth.group.groups[var_0];
}

group_wait_group_spawned(var_0) {
  if(!isDefined(level._stealth.group.groups[var_0])) {
    level._stealth.group waittill(var_0);
  }
}

ai_stealth_pause_handler() {
  self endon("death");
  self endon("pain_death");

  for(;;) {
    maps\_utility::ent_flag_waitopen("_stealth_enabled");
    var_0 = self._stealth.behavior.ai_functions["state"]["spotted"];

    switch (self.team) {
      case "allies":
        self[[var_0]]();
        break;
      case "team3":
      case "axis":
        self[[var_0]](1);
        break;
    }

    maps\_utility::ent_flag_wait("_stealth_enabled");
    var_1 = self._stealth.behavior.ai_functions["state"]["hidden"];
    self[[var_1]]();
  }
}

enemy_go_back() {
  self notify("going_back");
  self endon("death");
  self notify("stop_loop");

  if(isDefined(self._stealth.behavior.goback_startfunc)) {
    self[[self._stealth.behavior.goback_startfunc]]();
  }

  var_0 = self._stealth.behavior.last_spot;

  if(isDefined(var_0) && self.type != "dog" && !isDefined(self.custommovetransition)) {
    self.custommovetransition = maps\_patrol::patrol_resume_move_start_func;
  }

  if(isDefined(self.custommovetransition) && isDefined(self.pathgoalpos)) {
    self setgoalpos(self.origin);
    wait 0.05;
  }

  if(isDefined(self.script_patroller)) {
    if(isDefined(self.last_patrol_goal)) {
      self.target = self.last_patrol_goal.targetname;
    }

    if(isDefined(self.stealth_first_alert_new_patrol_path)) {
      self.target = self.stealth_first_alert_new_patrol_path.targetname;
      self.stealth_first_alert_new_patrol_path = undefined;
    }

    thread maps\_patrol::patrol();
  } else if(isalive(self.patrol_master)) {
    thread maps\_patrol::pet_patrol();
    maps\_utility::set_dog_walk_anim();
    self.script_growl = undefined;
  } else if(isDefined(var_0)) {
    if(self.type != "dog") {
      stealth_set_run_anim("_stealth_patrol_walk", 1);
    }
    else {
      maps\_utility::set_dog_walk_anim();
      self.script_growl = undefined;
    }

    self.disablearrivals = 1;
    self.disableexits = 1;
    self setgoalpos(var_0);
    self.goalradius = 40;
  }

  waittillframeend;
  maps\_utility::ent_flag_clear("_stealth_override_goalpos");

  if(isDefined(var_0)) {
    thread enemy_go_back_clear_lastspot(var_0);
  }
}

enemy_go_back_clear_lastspot(var_0) {
  self endon("death");
  self endon("_stealth_enemy_alert_level_change");
  maps\_utility::waittill_true_goal(var_0);
  self._stealth.behavior.last_spot = undefined;
}

enemy_get_nearby_pathnodes(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(isDefined(level._stealth.node_search.nodes_array) && distancesquared(var_0, level._stealth.node_search.origin) < 4096 && var_1 == level._stealth.node_search.radius && var_2 == level._stealth.node_search.min_radius) {
    return level._stealth.node_search.nodes_array;
  }

  level._stealth.node_search.origin = var_0;
  level._stealth.node_search.radius = var_1;
  level._stealth.node_search.min_radius = var_2;
  level._stealth.node_search.nodes_array = getnodesinradius(var_0, var_1, var_2, 512, "Path");
  return level._stealth.node_search.nodes_array;
}

enemy_reaction_state_alert() {
  self.fovcosine = 0.01;
  self.ignoreall = 0;
  self.diequietly = 0;
  maps\_utility::clear_run_anim();
  self.fixednode = 0;
}

enemy_alert_level_forget(var_0, var_1) {
  self endon("death");
  var_0 endon("death");

  if(!isDefined(var_1)) {
    var_1 = 60;
  }

  wait(var_1);

  if(isDefined(var_0._stealth.logic.spotted_list[self.unique_id]) && var_0._stealth.logic.spotted_list[self.unique_id] > 0) {
    var_0._stealth.logic.spotted_list[self.unique_id]--;
  }
}

enemy_stop_current_behavior() {
  if(!maps\_utility::ent_flag("_stealth_behavior_reaction_anim")) {
    maps\_utility::anim_stopanimscripted();
    self notify("stop_animmode");
    self notify("stop_loop");
  }

  if(isDefined(self.script_patroller)) {
    if(isDefined(self.last_patrol_goal)) {
      self.last_patrol_goal.patrol_claimed = undefined;
    }

    self notify("release_node");
    self notify("end_patrol");
  }

  self notify("stop_first_frame");
  maps\_utility::clear_run_anim();
  maps\_utility::clear_generic_idle_anim();
}

enemy_find_original_goal() {
  if(isDefined(self._stealth.behavior.last_spot)) {
    return;
  }
  if(isDefined(self.last_set_goalnode)) {
    self._stealth.behavior.last_spot = self.last_set_goalnode.origin;
  }
  else if(isDefined(self.last_set_goalent)) {
    self._stealth.behavior.last_spot = self.last_set_goalent.origin;
  }
  else if(isDefined(self.last_set_goalpos)) {
    self._stealth.behavior.last_spot = self.last_set_goalpos;
  }
  else {
    self._stealth.behavior.last_spot = self.origin;
  }
}

enemy_set_original_goal(var_0) {
  self._stealth.behavior.last_spot = var_0;
}

enemy_react_and_displace_to(var_0, var_1) {
  self notify("enemy_react_and_displace_to");
  self endon("enemy_react_and_displace_to");
  self endon("death");
  self endon("_stealth_enemy_alert_level_change");

  if(self.type == "dog") {
    return;
  }
  if(isDefined(var_0)) {
    var_2 = var_0.origin;
  }
  else {
    var_2 = var_1;
  }

  var_3 = anglesToForward(self.angles);
  var_4 = vectornormalize(var_3);
  var_5 = vectortoangles(var_4);
  var_6 = vectortoangles(var_2 - self.origin);
  var_7 = var_5[1] - var_6[1];
  var_7 = var_7 + 360;
  var_7 = int(var_7) % 360;

  if(var_7 > 315 || var_7 < 45) {
    var_8 = "8";
  }
  else if(var_7 < 135) {
    var_8 = "6";
  }
  else if(var_7 < 225) {
    var_8 = "2";
  }
  else {
    var_8 = "4";
  }

  stealth_anim_custom_animmode(self, "gravity", "_stealth_idle_to_run_" + var_8);
}

enemy_runto_and_lookaround(var_0, var_1) {
  self notify("enemy_runto_and_lookaround");
  self endon("enemy_runto_and_lookaround");
  self endon("death");
  self endon("_stealth_enemy_alert_level_change");

  if(self.type != "dog") {
    self endon("_stealth_saw_corpse");
  }

  var_2 = group_get_flagname("_stealth_spotted");
  level endon(var_2);
  self notify("stop_loop");
  maps\_utility::ent_flag_set("_stealth_override_goalpos");

  if(isDefined(var_0)) {
    self setgoalnode(var_0);
  }
  else {
    self setgoalpos(var_1);
  }

  self.goalradius = 64;
  self waittill("goal");

  if(self.type != "dog") {
    stealth_set_idle_anim("_stealth_look_around");
  }
}

enemy_find_free_pathnode_near(var_0, var_1, var_2) {
  var_3 = enemy_get_nearby_pathnodes(var_0, var_1, var_2);

  if(!isDefined(var_3) || var_3.size == 0) {
    return;
  }
  var_4 = var_3[randomint(var_3.size)];

  for(var_3 = common_scripts\utility::array_remove(var_3, var_4); isDefined(var_4.owner); var_3 = common_scripts\utility::array_remove(var_3, var_4)) {
    if(var_3.size == 0) {
      return;
    }
    var_4 = var_3[randomint(var_3.size)];
  }

  level._stealth.node_search.nodes_array = var_3;
  return var_4;
}

enemy_announce_wtf() {
  if(self.type == "dog") {
    return;
  }
  if(!enemy_announce_snd("wtf")) {
    return;
  }
  var_0 = "stealth_" + self.npcid + "_anexplosion";
  self playSound(var_0);
}

enemy_announce_huh() {
  if(self.type == "dog") {
    return;
  }
  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  if(!enemy_announce_snd("huh")) {
    return;
  }
  var_0 = "stealth_" + self.npcid + "_huh";
  self playSound(var_0);
}

enemy_announce_hmph() {
  if(self.type == "dog") {
    return;
  }
  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  if(!enemy_announce_snd("hmph")) {
    return;
  }
  var_0 = "stealth_" + self.npcid + "_hmph";
  self playSound(var_0);
}

enemy_announce_attack() {
  self endon("death");
  self endon("pain_death");

  if(self.type == "dog") {
    return;
  }
  if(!enemy_announce_snd("spotted")) {
    return;
  }
  var_0 = get_country_prefix();
  self playSound(var_0 + self.npcid + "_stealth_alert");
}

enemy_announce_spotted(var_0) {
  self endon("death");
  self endon("pain_death");
  maps\_stealth_utility::stealth_group_spotted_flag_wait();

  if(self.type == "dog") {
    return;
  }
  if(enemy_announce_snd("spotted")) {
    thread enemy_announce_spotted_bring_group(var_0);
    var_1 = get_country_prefix();
    var_2 = var_1 + self.npcid + "_stealth_alert";
    self playSound(var_2);
  }

  if(enemy_announce_snd("acknowledge")) {
    thread enemy_announce_spotted_acknowledge(self.origin, get_country_prefix());
  }
}

enemy_announce_spotted_acknowledge(var_0, var_1) {
  wait 1.5;

  if(isDefined(self.npcid)) {
    var_2 = self.npcid;
  }
  else {
    var_2 = randomint(3);
  }

  var_3 = var_1 + var_2 + "_stealth_alert_r";
  common_scripts\utility::play_sound_in_space(var_3, var_0);
}

enemy_announce_spotted_bring_group(var_0) {
  var_1 = group_get_ai_in_group(self.script_stealthgroup);

  foreach(var_4, var_3 in var_1) {
    if(var_3 == self) {
      continue;
    }
    if(isDefined(var_3.enemy) || isDefined(var_3.favoriteenemy)) {
      continue;
    }
    var_3 notify("heard_scream", var_0);
  }
}

enemy_announce_corpse() {
  self endon("death");

  if(isDefined(self.found_corpse_wait)) {
    wait(self.found_corpse_wait);
  }

  if(!enemy_announce_snd("corpse")) {
    return;
  }
  if(self.type == "dog") {
    maps\_utility::ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");
    self notify("event_awareness", "howl");
    return;
  }

  var_0 = "stealth_" + self.npcid + "_deadbody";
  self playSound(var_0);
}

enemy_announce_snd(var_0) {
  if(var_0 == "spotted") {
    if(level._stealth.behavior.sound[var_0][self.script_stealthgroup]) {
      return 0;
    }

    level._stealth.behavior.sound[var_0][self.script_stealthgroup] = 1;
  } else {
    if(level._stealth.behavior.sound[var_0]) {
      return 0;
    }

    level._stealth.behavior.sound[var_0] = 1;
    thread enemy_announce_snd_reset(var_0);
  }

  return 1;
}

enemy_announce_snd_reset(var_0) {
  wait(level._stealth.behavior.sound_reset_time);
  level._stealth.behavior.sound[var_0] = 0;
}

enemy_animation_wrapper(var_0) {
  self endon("death");
  self endon("pain_death");

  if(enemy_animation_pre_anim(var_0)) {
    return;
  }
  enemy_animation_do_anim(var_0);
  enemy_animation_post_anim(var_0);
}

enemy_animation_do_anim(var_0) {
  if(isDefined(self._stealth.behavior.event.custom_animation)) {
    enemy_animation_custom(var_0);
    return;
  }

  var_1 = self._stealth.behavior.ai_functions["animation"][var_0];
  self[[var_1]](var_0);
}

enemy_animation_custom(var_0) {
  var_1 = self._stealth.behavior.event.custom_animation.node;
  var_2 = self._stealth.behavior.event.custom_animation.anime;
  var_3 = self._stealth.behavior.event.custom_animation.tag;
  var_4 = self._stealth.behavior.event.custom_animation.ender;
  maps\_utility::ent_flag_set("_stealth_behavior_reaction_anim");
  self.allowdeath = 1;
  var_1 notify(var_4);

  if(isDefined(self.anim_props)) {
    self.anim_props_animated = 1;
    var_1 thread maps\_anim::anim_single(self.anim_props, var_2);
  }

  if(var_0 != "doFlashBanged") {
    if(isDefined(var_3) || isDefined(self.has_delta)) {
      var_1 stealth_anim(self, var_2, var_3);
    }
    else {
      var_1 stealth_anim_custom_animmode(self, "gravity", var_2);
    }
  }

  ai_clear_custom_animation_reaction();
}

enemy_animation_pre_anim(var_0) {
  self notify("enemy_awareness_reaction", var_0);

  if(maps\_utility::ent_flag("_stealth_behavior_first_reaction") || maps\_utility::ent_flag("_stealth_behavior_reaction_anim_in_progress")) {
    return 1;
  }

  enemy_stop_current_behavior();

  if(issubstr(var_0, "warning")) {
    var_0 = "warning";
  }

  switch (var_0) {
    case "found_corpse":
    case "saw_corpse":
    case "heard_corpse":
    case "explode":
      maps\_utility::ent_flag_set("_stealth_behavior_reaction_anim");
      break;
    case "reset":
    case "warning":
      break;
    default:
      if(!maps\_utility::ent_flag_exist("_stealth_behavior_asleep") || !maps\_utility::ent_flag("_stealth_behavior_asleep") || maps\_stealth_utility::stealth_group_spotted_flag()) {
        maps\_utility::ent_flag_set("_stealth_behavior_first_reaction");
        thread enemy_animation_pre_anim_dog_special_first_condition();
      }

      maps\_utility::ent_flag_set("_stealth_behavior_reaction_anim");
      break;
  }

  maps\_utility::ent_flag_set("_stealth_behavior_reaction_anim_in_progress");
  return 0;
}

enemy_animation_pre_anim_dog_special_first_condition() {
  var_0 = group_get_flagname("_stealth_spotted");
  self endon("death");
  common_scripts\utility::flag_wait_or_timeout(var_0, 3);

  if(common_scripts\utility::flag(var_0)) {
    maps\_utility::ent_flag_set("_stealth_behavior_first_reaction");
  }
}

enemy_animation_post_anim(var_0) {
  switch (var_0) {
    default:
      maps\_utility::ent_flag_clear("_stealth_behavior_reaction_anim");
      break;
  }

  maps\_utility::ent_flag_clear("_stealth_behavior_reaction_anim_in_progress");
}

ai_clear_custom_animation_reaction() {
  self._stealth.behavior.event.custom_animation = undefined;
  self.newenemyreactiondistsq = squared(512);
}

ai_clear_custom_animation_reaction_and_idle(var_0) {
  if(!isDefined(self._stealth.behavior.event.custom_animation)) {
    return;
  }
  self._stealth.behavior.event.custom_animation.node notify("stop_loop");

  if(!isDefined(var_0) || var_0 == 0) {
    self stopanimscripted();
  }

  ai_clear_custom_animation_reaction();
}

ai_set_custom_animation_reaction(var_0, var_1, var_2, var_3) {
  self._stealth.behavior.event.custom_animation = spawnStruct();
  self._stealth.behavior.event.custom_animation.node = var_0;
  self._stealth.behavior.event.custom_animation.anime = var_1;
  self._stealth.behavior.event.custom_animation.tag = var_2;
  self._stealth.behavior.event.custom_animation.ender = var_3;
  thread ai_animate_props_on_death(var_0, var_1, var_2, var_3);
  self.newenemyreactiondistsq = 0;
}

ai_animate_props_on_death(var_0, var_1, var_2, var_3) {
  wait 0.1;

  if(!isDefined(self.anim_props)) {
    return;
  }
  var_4 = self.anim_props;
  self waittill("death");

  if(isDefined(self.anim_props_animated)) {
    return;
  }
  var_0 thread maps\_anim::anim_single(var_4, var_1);
}

event_awareness_main(var_0, var_1) {
  level notify("event_awareness_handler");
  level endon("event_awareness_handler");
  level endon("default_event_awareness_enders");
  event_awareness_enders(var_1);
  maps\_utility::add_wait(maps\_utility::waittill_msg, "event_awareness_handler");
  maps\_utility::add_wait(maps\_utility::waittill_msg, "default_event_awareness_enders");
  maps\_utility::add_func(common_scripts\utility::flag_clear, "_stealth_event");
  thread maps\_utility::do_wait_any();

  for(;;) {
    common_scripts\utility::flag_wait("_stealth_enabled");
    common_scripts\utility::flag_wait("_stealth_event");

    if(!common_scripts\utility::flag("_stealth_enabled")) {
      continue;
    }
    wait 2;
    event_awareness_dialogue_wrapper(var_0);
    common_scripts\utility::flag_waitopen("_stealth_event");
  }
}

event_awareness_dialogue_wrapper(var_0) {
  wait(randomfloatrange(0.5, 1));

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = common_scripts\utility::random(var_0);
  level thread maps\_utility::function_stack(maps\_utility::radio_dialogue, var_1);
}

event_awareness_enders(var_0) {
  level endon("default_event_awareness_enders");
  level endon("event_awareness_handler");

  if(isDefined(var_0)) {
    foreach(var_2 in var_0) {
      if(common_scripts\utility::flag_exist(var_2) && common_scripts\utility::flag(var_2)) {
        level notify("default_event_awareness_enders");
      }
    }

    foreach(var_2 in var_0) {
    maps\_utility::add_wait(maps\_utility::waittill_msg, var_2);
    }
  }

  maps\_utility::add_wait(common_scripts\utility::flag_wait, "_stealth_spotted");
  maps\_utility::add_wait(maps\_utility::waittill_msg, "end_event_awareness_handler");
  maps\_utility::add_wait(maps\_utility::waittill_msg, "event_awareness_handler");
  maps\_utility::add_func(maps\_utility::send_notify, "default_event_awareness_enders");
  thread maps\_utility::do_wait_any();
}

_autosave_stealthcheck() {
  if(!maps\_stealth_utility::stealth_is_everything_normal()) {
    return 0;
  }

  if(common_scripts\utility::flag("_stealth_player_nade")) {
    return 0;
  }

  if(common_scripts\utility::flag_exist("_radiation_poisoning")) {
    if(common_scripts\utility::flag("_radiation_poisoning")) {
      return 0;
    }
  }

  var_0 = getEntArray("destructible", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.healthdrain)) {
      return 0;
    }
  }

  var_4 = getEntArray("grenade", "classname");

  if(var_4.size > 0) {
    return 0;
  }

  return 1;
}

_patrol_endon_spotted_flag() {
  var_0 = maps\_stealth_utility::stealth_get_group_spotted_flag();
  var_1 = maps\_stealth_utility::stealth_get_group_corpse_flag();
  maps\_utility::add_wait(common_scripts\utility::flag_wait, var_0);
  maps\_utility::add_wait(common_scripts\utility::flag_wait, var_1);
  maps\_utility::add_abort(maps\_utility::waittill_msg, "death");
  maps\_utility::add_func(maps\_utility::send_notify, "end_patrol");
  thread maps\_utility::do_wait_any();
}

_spawner_stealth_default() {
  thread maps\_stealth_utility::stealth_default();
}

stealth_set_run_anim(var_0, var_1) {
  if(isDefined(self.script_animation) && isDefined(level.scr_anim["generic"][var_0 + "_" + self.script_animation])) {
    maps\_utility::set_generic_run_anim(var_0 + "_" + self.script_animation, var_1);
    return;
  }

  maps\_utility::set_generic_run_anim(var_0, var_1);
}

stealth_set_idle_anim(var_0) {
  if(isDefined(self.script_animation) && isDefined(level.scr_anim["generic"][var_0 + "_" + self.script_animation])) {
    maps\_utility::set_generic_idle_anim(var_0 + "_" + self.script_animation);
    return;
  }

  maps\_utility::set_generic_idle_anim(var_0);
}

stealth_anim_custom_animmode(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.script_animation) && isDefined(level.scr_anim["generic"][var_2 + "_" + var_0.script_animation])) {
    maps\_anim::anim_custom_animmode_solo(var_0, var_1, var_2 + "_" + var_0.script_animation, var_3);
    return;
  }

  maps\_anim::anim_generic_custom_animmode(var_0, var_1, var_2, var_3);
}

stealth_anim(var_0, var_1, var_2) {
  if(isDefined(var_0.script_animation) && isDefined(level.scr_anim["generic"][var_1 + "_" + var_0.script_animation])) {
    maps\_anim::anim_single_solo(var_0, var_1 + "_" + var_0.script_animation, var_2);
    return;
  }

  maps\_anim::anim_generic(var_0, var_1, var_2);
}

get_country_prefix() {
  var_0 = self.voice;

  switch (var_0) {
    case "african":
      return "AF_";
    case "american":
      return "US_";
    case "arab":
      return "AB_";
    case "british":
      return "UK_";
    case "czech":
      return "CZ_";
    case "delta":
      return "DF_";
    case "french":
      return "FR_";
    case "pmc":
      return "PC_";
    case "portugese":
      return "PG_";
    case "seal":
      return "GS_";
    case "secretservice":
      return "SS_";
    case "russian":
    case "shadowcompany":
      return "SP_";
    case "taskforce":
      return "tf_";
    default:
      return undefined;
  }
}