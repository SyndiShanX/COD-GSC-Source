/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_stealth_corpse_enemy.gsc
******************************************/

stealth_corpse_enemy_main() {
  enemy_init();
  thread enemy_corpse_logic();
  thread enemy_corpse_loop();
}

enemy_corpse_loop() {
  self endon("death");
  self endon("pain_death");
  thread enemy_found_corpse_loop();

  for(;;) {
    self waittill("_stealth_saw_corpse");

    if(!maps\_utility::ent_flag("_stealth_enabled")) {
      continue;
    }
    enemy_saw_corpse_logic();
  }
}

enemy_found_corpse_loop() {
  var_0 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
  var_1 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
  self endon("death");
  self endon("pain_death");

  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  level endon(var_0);

  for(;;) {
    maps\_utility::ent_flag_wait("_stealth_enabled");

    if(maps\_utility::ent_flag_exist("_stealth_behavior_asleep"))
      maps\_utility::ent_flag_waitopen("_stealth_behavior_asleep");

    maps\_stealth_utility::stealth_group_corpse_flag_wait();

    if(!maps\_utility::ent_flag("_stealth_enabled")) {
      continue;
    }
    while(maps\_stealth_utility::stealth_group_corpse_flag()) {
      if(!maps\_utility::ent_flag("_stealth_enabled")) {
        break;
      }

      enemy_corpse_found_wrapper();
      level waittill(var_1);
    }
  }
}

enemy_saw_corpse_logic() {
  var_0 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
  var_1 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");

  if(common_scripts\utility::flag(var_0)) {
    return;
  }
  level endon(var_0);
  self endon("attack");
  level endon(var_1);

  for(;;) {
    maps\_utility::ent_flag_waitopen("_stealth_enemy_alert_level_action");
    enemy_corpse_saw_wrapper();
    self waittill("normal");
  }
}

enemy_corpse_saw_wrapper() {
  maps\_stealth_shared_utilities::enemy_find_original_goal();
  self endon("enemy_alert_level_change");
  thread maps\_stealth_shared_utilities::enemy_announce_huh();
  maps\_utility::ent_flag_set("_stealth_running_to_corpse");
  maps\_utility::ent_flag_set("_stealth_override_goalpos");
  var_0 = self._stealth.behavior.ai_functions["corpse"];
  self[[var_0["saw"]]]();
}

enemy_corpse_found_wrapper() {
  maps\_stealth_shared_utilities::enemy_find_original_goal();

  if(!maps\_utility::ent_flag("_stealth_found_corpse"))
    self notify("awareness_corpse", "heard_corpse", (0, 0, 0));

  maps\_stealth_shared_utilities::enemy_reaction_state_alert();

  if(self.type == "dog")
    maps\_utility::ent_flag_set("_stealth_override_goalpos");

  thread enemy_corpse_reset_wrapper();
  var_0 = self._stealth.behavior.ai_functions["corpse"];
  self[[var_0["found"]]]();
}

enemy_corpse_reset_wrapper() {
  var_0 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
  self endon("death");
  self endon("_stealth_enemy_alert_level_change");
  level endon(var_0);
  waittillframeend;
  self endon("enemy_awareness_reaction");
  maps\_stealth_utility::stealth_group_corpse_flag_waitopen();
  maps\_utility::ent_flag_set("_stealth_normal");
  var_1 = self._stealth.behavior.ai_functions["corpse"];
  self thread[[var_1["reset"]]]();
}

enemy_corpse_saw_behavior() {
  self.disablearrivals = 0;
  self.disableexits = 0;

  if(self.type != "dog")
    maps\_stealth_shared_utilities::stealth_set_run_anim("_stealth_combat_jog");
  else {
    maps\_utility::clear_run_anim();
    self.script_growl = 1;
    self.script_nobark = 1;
  }

  self.goalradius = 80;
  self setgoalpos(self._stealth.logic.corpse.origin);
}

enemy_corpse_found_behavior() {
  if(self.type == "dog") {
    self setgoalpos(self.origin);
    return;
  }

  var_0 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(level._stealth.logic.corpse.last_pos, 512, 40);

  if(!isDefined(var_0)) {
    return;
  }
  thread maps\_stealth_shared_utilities::enemy_runto_and_lookaround(var_0);
}

enemy_corpse_reset_behavior() {
  self endon("death");
  wait(randomfloatrange(0, 5));
  maps\_stealth_shared_utilities::enemy_stop_current_behavior();
  maps\_stealth_threat_enemy::enemy_alert_level_change("reset");
}

player_can_see_corpse(var_0) {
  var_1 = maps\_utility::get_closest_player(var_0);
  var_2 = distance(var_1.origin, var_0);

  if(var_2 < 150)
    return 1;

  if(var_2 > level._stealth.logic.corpse.player_distsqrd)
    return 0;

  return sighttracepassed(var_0 + (0, 0, 48), var_1 getEye(), 0, var_1);
}

enemy_corpse_logic() {
  self endon("death");
  self endon("pain_death");
  thread enemy_corpse_found_loop();

  for(;;) {
    if(maps\_utility::ent_flag_exist("_stealth_behavior_asleep"))
      maps\_utility::ent_flag_waitopen("_stealth_behavior_asleep");

    maps\_utility::ent_flag_wait("_stealth_enabled");

    while(!maps\_stealth_utility::stealth_group_spotted_flag() && !maps\_utility::ent_flag("_stealth_attack")) {
      var_0 = 0;
      var_1 = 0;
      var_2 = undefined;
      var_3 = undefined;
      var_4 = get_corpse_array();

      for(var_5 = 0; var_5 < var_4.size; var_5++) {
        var_2 = var_4[var_5];

        if(isDefined(var_2.found)) {
          continue;
        }
        if(!isDefined(level.corpse_behavior_doesnt_require_player_sight)) {
          if(!player_can_see_corpse(var_2.origin))
            continue;
        }

        var_6 = distancesquared(self.origin, var_2.origin);

        if(self.type != "dog")
          var_3 = level._stealth.logic.corpse.found_distsqrd;
        else
          var_3 = level._stealth.logic.corpse.found_dog_distsqrd;

        if(var_6 < var_3) {
          var_0 = 1;
          break;
        }

        if(isDefined(self._stealth.logic.corpse.corpse_entity)) {
          if(self._stealth.logic.corpse.corpse_entity == var_2) {
            continue;
          }
          var_7 = distancesquared(self.origin, self._stealth.logic.corpse.corpse_entity.origin);

          if(var_7 <= var_6)
            continue;
        }

        if(var_6 > level._stealth.logic.corpse.sight_distsqrd) {
          continue;
        }
        if(var_6 < level._stealth.logic.corpse.detect_distsqrd) {
          if(self cansee(var_2)) {
            var_1 = 1;
            break;
          }
        }

        var_8 = self gettagangles("tag_eye");
        var_9 = self getEye();
        var_10 = anglesToForward(var_8);
        var_11 = vectornormalize(var_2.origin - var_9);

        if(vectordot(var_10, var_11) > 0.55) {
          if(self cansee(var_2)) {
            var_1 = 1;
            break;
          }
        }
      }

      if(var_0) {
        if(!maps\_utility::ent_flag("_stealth_found_corpse"))
          maps\_utility::ent_flag_set("_stealth_found_corpse");
        else
          self notify("_stealth_found_corpse");

        maps\_utility::ent_flag_clear("_stealth_saw_corpse");
        thread enemy_corpse_found(var_2);
        self notify("awareness_corpse", "found_corpse", var_2);
      } else if(var_1) {
        self._stealth.logic.corpse.corpse_entity = var_2;
        self._stealth.logic.corpse.origin = var_2.origin;

        if(!maps\_utility::ent_flag("_stealth_saw_corpse"))
          maps\_utility::ent_flag_set("_stealth_saw_corpse");
        else
          self notify("_stealth_saw_corpse");

        level notify("_stealth_saw_corpse");
        self notify("awareness_corpse", "saw_corpse", var_2);
      }

      wait 0.5;
    }

    remove_corpse_loop_while_stealth_broken();
    maps\_stealth_utility::stealth_group_spotted_flag_waitopen();
    maps\_utility::ent_flag_waitopen("_stealth_attack");
  }
}

remove_corpse_loop_while_stealth_broken() {
  var_0 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");

  while(common_scripts\utility::flag(var_0)) {
    var_1 = get_corpse_array();

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(isDefined(var_3.found)) {
        continue;
      }
      var_4 = distancesquared(self.origin, var_3.origin);

      if(self.type != "dog")
        var_5 = level._stealth.logic.corpse.found_distsqrd;
      else
        var_5 = level._stealth.logic.corpse.found_dog_distsqrd;

      if(var_4 < var_5) {
        var_3 setcorpseremovetimer(10);
        var_3.found = 1;
      }
    }

    wait 0.5;
  }
}

enemy_corpse_found_loop() {
  self endon("death");
  self endon("pain_death");
  var_0 = maps\_stealth_utility::stealth_get_group_corpse_flag();

  for(;;) {
    level waittill(var_0);

    if(!maps\_stealth_utility::stealth_group_corpse_flag()) {
      continue;
    }
    enemy_corpse_alert_level();
  }
}

enemy_corpse_alert_level() {
  var_0 = undefined;

  if(isDefined(self.enemy))
    var_0 = self.enemy;
  else
    var_0 = common_scripts\utility::random(level.players);

  if(!isDefined(var_0._stealth) && !isplayer(var_0)) {
    return;
  }
  if(!isDefined(var_0._stealth.logic.spotted_list[self.unique_id]))
    var_0._stealth.logic.spotted_list[self.unique_id] = 0;

  if(var_0._stealth.logic.spotted_list[self.unique_id] < self._stealth.logic.alert_level.max_warnings) {
    var_0._stealth.logic.spotted_list[self.unique_id]++;
    thread maps\_stealth_shared_utilities::enemy_alert_level_forget(var_0);
  }
}

enemy_corpse_found(var_0) {
  self endon("death");
  level._stealth.logic.corpse.last_pos = var_0.origin;
  var_0 setcorpseremovetimer(level._stealth.logic.corpse.reset_time);
  var_0.found = 1;

  if(self.type == "dog" && maps\_utility::ent_flag_exist("_stealth_behavior_reaction_anim_in_progress")) {
    wait 0.1;
    maps\_utility::ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");
    wait 0.5;
  } else
    wait 2;

  thread maps\_stealth_shared_utilities::enemy_announce_corpse();
  wait 2;
  var_1 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");

  if(!maps\_stealth_utility::stealth_group_corpse_flag())
    maps\_stealth_shared_utilities::group_flag_set("_stealth_found_corpse");
  else
    level notify(var_1);

  thread enemy_corpse_clear();
}

enemy_corpse_clear() {
  var_0 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
  var_1 = self.script_stealthgroup;
  level endon(var_0);
  maps\_utility::waittill_dead_or_dying(maps\_stealth_shared_utilities::group_get_ai_in_group(var_1), undefined, level._stealth.logic.corpse.reset_time);
  thread maps\_stealth_shared_utilities::group_flag_clear("_stealth_found_corpse", var_1);
}

enemy_init() {
  self._stealth.logic.corpse = spawnStruct();
  self._stealth.logic.corpse.corpse_entity = undefined;
  maps\_utility::ent_flag_init("_stealth_saw_corpse");
  maps\_utility::ent_flag_init("_stealth_found_corpse");
  enemy_default_corpse_behavior();
  enemy_default_corpse_anim_behavior();
  self._stealth.plugins.corpse = 1;
}

enemy_default_corpse_anim_behavior() {
  if(self.type == "dog") {
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "heard_corpse", maps\_stealth_animation_funcs::dog_animation_generic);
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "saw_corpse", maps\_stealth_animation_funcs::dog_animation_sawcorpse);
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "found_corpse", maps\_stealth_animation_funcs::dog_animation_foundcorpse);
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "howl", maps\_stealth_animation_funcs::dog_animation_howl);
  } else {
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "heard_corpse", maps\_stealth_animation_funcs::enemy_animation_generic);
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "saw_corpse", maps\_stealth_animation_funcs::enemy_animation_sawcorpse);
    maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "found_corpse", maps\_stealth_animation_funcs::enemy_animation_foundcorpse);
  }
}

enemy_default_corpse_behavior() {
  var_0 = [];
  var_0["saw"] = ::enemy_corpse_saw_behavior;
  var_0["found"] = ::enemy_corpse_found_behavior;
  var_0["reset"] = ::enemy_corpse_reset_behavior;
  enemy_custom_corpse_behavior(var_0);
}

enemy_custom_corpse_behavior(var_0) {
  foreach(var_3, var_2 in var_0)
  maps\_stealth_shared_utilities::ai_create_behavior_function("corpse", var_3, var_2);
}

get_corpse_array() {
  if(isDefined(level._stealth.logic.corpse.collect_func))
    return [
      [level._stealth.logic.corpse.collect_func]
    ]();

  return getcorpsearray();
}