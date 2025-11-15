/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_container_spawn.gsc
**********************************************/

init_container_spawn() {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  if(!isDefined(level.container_spawn_table)) {
    return;
  }
  if(!isDefined(level.max_damage_based_container))
    level.max_damage_based_container = 3;

  level.num_damage_based_container = 0;
  init_warning_sounds();
}

activate_container_spawners_in_area(var_0) {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  var_1 = select_container_structs_in_area(var_0);

  foreach(var_3 in var_1) {
    var_4 = var_3.script_noteworthy;

    if(should_activate_container_in_area(var_3, var_4))
      var_3 thread activate_container(var_3, var_4);
  }
}

activate_container_spawner_by_id(var_0) {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  var_1 = common_scripts\utility::getstructarray("container_spawn", "targetname");

  foreach(var_3 in var_1) {
    if(already_activated(var_3)) {
      continue;
    }
    var_4 = var_3.script_noteworthy;

    if(var_4 == var_0)
      var_3 thread activate_container(var_3, var_4);
  }
}

activate_container(var_0, var_1) {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  var_0 endon("death");
  level endon("game_ended");
  var_0.activated = 1;
  var_2 = get_activation_method(var_1);

  switch (var_2) {
    case "proximity":
      wait_trigger_activate(var_0, var_1);
      break;
    case "damage":
      wait_damage_activate(var_0, var_1);
      break;
    case "notify":
      wait_notify_activate(var_1);
      break;
  }

  spawn_alien_from_container(var_0, var_1);
  deactivate_container(var_0);
}

spawn_alien_from_container(var_0, var_1) {
  var_2 = 0.2;
  var_3 = 10;
  var_4 = common_scripts\utility::getstructarray(var_0.target, "targetname");
  var_4 = sort_based_on_priority(var_4, var_1);
  var_5 = get_spawn_info(var_1, var_4.size);
  var_6 = get_should_force_spawn(var_1);
  var_7 = var_5.size;

  if(var_6) {
    for(var_7 = maps\mp\alien\_spawn_director::reserve_custom_spawn_space(var_7, 0); var_7 <= 0; var_7 = maps\mp\alien\_spawn_director::reserve_custom_spawn_space(var_7, 0))
      common_scripts\utility::waitframe();
  } else
    var_7 = maps\mp\alien\_spawn_director::reserve_custom_spawn_space(var_7, 1);

  if(var_7 > 0) {
    maps\mp\alien\_spawn_director::pause_cycle(var_3);
    play_warning_sfx(var_4, var_5, var_1);
  }

  for(var_8 = 0; var_8 < var_7; var_8++) {
    var_9 = var_4[var_8];
    var_10 = var_5[var_8];
    var_11 = maps\mp\alien\_spawn_director::process_intro_vignette_ai_type(var_10);
    var_12 = level.cycle_data.spawn_node_info[var_9.script_noteworthy].vignetteinfo[var_11];
    var_13 = maps\mp\alien\_spawn_director::process_custom_spawn(var_10, var_9, var_12);

    if(isDefined(var_13))
      mark_spawn_clips_on(var_13, var_0);

    wait(var_2);
  }
}

play_warning_sfx(var_0, var_1, var_2) {
  var_3 = var_0[0].origin;
  var_4 = spawn("script_origin", var_3);
  var_5 = level.container_warning_sounds[var_1[0]];
  var_6 = "emt_aln_arm_crate_alarm_lp";

  if(isDefined(var_5) && get_should_play_warning_spawn(var_2)) {
    var_7 = lookupsoundlength(var_5) / 1000;
    var_4 playSound(var_5);
    wait(var_7);
    var_4 stopsounds();
  }

  var_7 = 5;
  var_4 common_scripts\utility::delaycall(var_7 + 1, ::delete);

  if(isDefined(var_6) && get_should_play_alarm_spawn(var_2)) {
    var_4 common_scripts\utility::delaycall(var_7, ::stoploopsound);
    var_4 playLoopSound(var_6);
  }
}

init_warning_sounds() {
  if(!isDefined(level.container_warning_sounds)) {
    level.container_warning_sounds["elite"] = "scn_arm_crate_queen";
    level.container_warning_sounds["spitter"] = "scn_arm_crate_spitter";
    level.container_warning_sounds["brute"] = "scn_arm_crate_brute";
    level.container_warning_sounds["locust"] = "scn_arm_crate_brute";
  }
}

wait_trigger_activate(var_0, var_1) {
  var_2 = 1.0;
  var_3 = get_activation_trigger(var_0);
  var_3 endon("death");
  var_3 endon("timed_out");
  var_4 = get_trigger_chance(var_1);
  var_5 = get_time_before_auto_trigger_array(var_1);
  var_3 thread notify_on_timeout("timed_out", var_5);

  for(;;) {
    var_3 waittill("trigger", var_6);

    if(!isplayer(var_6)) {
      common_scripts\utility::waitframe();
      continue;
    }

    if(randomintrange(0, 100) <= var_4)
      return;
    else
      wait(var_2);
  }
}

notify_on_timeout(var_0, var_1) {
  if(var_1[0] >= 0) {
    var_2 = randomintrange(var_1[0], var_1[1]);
    wait(var_2);
    self notify(var_0);
  }
}

wait_damage_activate(var_0, var_1) {
  var_2 = get_attackable_ent(var_0, var_1);
  var_2 endon("death");

  for(;;) {
    var_2 waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(isagent(var_4)) {
      var_2.fake_health = var_2.fake_health - var_3;

      if(var_2.fake_health <= 0) {
        break;
      }
    }
  }
}

wait_notify_activate(var_0) {
  var_1 = get_notify_message(var_0);
  level waittill(var_1);
}

get_attackable_ent(var_0, var_1) {
  level.num_damage_based_container++;
  var_2 = spawn("script_model", var_0.origin);
  var_2.health = 999999;
  var_2.fake_health = get_container_health(var_1);
  var_2 setCanDamage(1);
  var_2 setCanRadiusDamage(1);
  var_2 makeentitysentient("allies", 1);
  var_2.threatbias = get_threat_bias(var_1);
  var_0.attackable_ent = var_2;
  return var_2;
}

deactivate_container_spawners_in_area(var_0) {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  var_1 = select_container_structs_in_area(var_0);

  foreach(var_3 in var_1)
  deactivate_container(var_3);
}

deactivate_container(var_0) {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    if(is_clip(var_3)) {
      continue;
    }
    var_3 delete();
  }

  if(isDefined(var_0.attackable_ent)) {
    var_0.attackable_ent freeentitysentient();
    var_0.attackable_ent delete();
    level.num_damage_based_container--;
  }

  var_0 notify("death");
}

get_activation_method(var_0) {
  var_1 = ["damage", "proximity", "notify"];
  var_2 = get_proximity_weight(var_0);
  var_3 = get_notify_weight(var_0);

  if(at_max_damage_based_container())
    var_4 = 0;
  else
    var_4 = get_damage_weight(var_0);

  var_5 = [var_4, var_2, var_3];
  var_6 = maps\mp\alien\_utility::getrandomindex(var_5);
  return var_1[var_6];
}

select_container_structs_in_area(var_0) {
  var_1 = getent(var_0, "targetname");
  var_2 = [];
  var_3 = common_scripts\utility::getstructarray("container_spawn", "targetname");

  foreach(var_5 in var_3) {
    if(ispointinvolume(var_5.origin, var_1))
      var_2[var_2.size] = var_5;
  }

  return var_2;
}

get_activation_trigger(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    if(var_3.classname == "trigger_multiple")
      return var_3;
  }
}

should_activate_container_in_area(var_0, var_1) {
  if(should_skip_area_activation(var_1) || already_activated(var_0))
    return 0;

  return should_activated_by_chance(var_1);
}

should_skip_area_activation(var_0) {
  if(!isDefined(level.should_skip_area_activation_func))
    return 0;

  return [[level.should_skip_area_activation_func]](var_0);
}

already_activated(var_0) {
  return maps\mp\alien\_utility::is_true(var_0.activated);
}

should_activated_by_chance(var_0) {
  var_1 = get_activate_chance(var_0);
  var_2 = randomintrange(0, 100);
  return var_2 < var_1;
}

get_spawn_info(var_0, var_1) {
  var_2 = get_spawn_types(var_0);
  var_3 = get_spawn_type_weights(var_0);
  var_4 = get_spawn_quantity(var_0);
  var_5 = maps\mp\alien\_utility::getrandomindex(var_3);
  var_2 = strtok(var_2[var_5], "-");
  var_4 = strtok(var_4[var_5], "-");
  var_6 = [];

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    var_8 = int(var_4[var_7]);

    if(var_8 > 1)
      var_8 = 1 + randomintrange(0, var_8);

    for(var_9 = 0; var_9 < var_8; var_9++)
      var_6[var_6.size] = var_2[var_7];
  }

  return var_6;
}

sort_based_on_priority(var_0, var_1) {
  var_2 = get_spawner_id_array(var_1);
  var_3 = get_spawner_priority_array(var_1);
  var_0 = assign_spawn_priority(var_0, var_2, var_3);
  var_0 = common_scripts\utility::array_sort_with_func(var_0, ::is_higher_priority);
  return var_0;
}

is_higher_priority(var_0, var_1) {
  return var_0.priority > var_1.priority;
}

assign_spawn_priority(var_0, var_1, var_2) {
  foreach(var_4 in var_0)
  var_4.priority = get_spawn_priority(var_4, var_1, var_2);

  return var_0;
}

get_spawn_priority(var_0, var_1, var_2) {
  foreach(var_5, var_4 in var_1) {
    if(var_0.script_noteworthy == var_4)
      return var_2[var_5];
  }
}

at_max_damage_based_container() {
  return level.num_damage_based_container >= level.max_damage_based_container;
}

get_activate_chance(var_0) {
  return get_container_info(var_0, 1, 1);
}

get_proximity_weight(var_0) {
  return get_container_info(var_0, 2, 1);
}

get_damage_weight(var_0) {
  return get_container_info(var_0, 3, 1);
}

get_notify_weight(var_0) {
  return get_container_info(var_0, 4, 1);
}

get_trigger_chance(var_0) {
  return get_container_info(var_0, 5, 1);
}

get_container_health(var_0) {
  return get_container_info(var_0, 6, 1);
}

get_threat_bias(var_0) {
  return get_container_info(var_0, 7, 1);
}

get_notify_message(var_0) {
  return get_container_info(var_0, 8, 0);
}

get_spawn_types(var_0) {
  return get_container_info_array(var_0, 9, 0);
}

get_spawn_type_weights(var_0) {
  return get_container_info_array(var_0, 10, 1);
}

get_spawn_quantity(var_0) {
  return get_container_info_array(var_0, 11, 0);
}

get_should_force_spawn(var_0) {
  return get_container_info(var_0, 12, 0) == "true";
}

get_spawner_id_array(var_0) {
  return get_container_info_array(var_0, 13, 0);
}

get_spawner_priority_array(var_0) {
  return get_container_info_array(var_0, 14, 1);
}

get_should_play_alarm_spawn(var_0) {
  return get_container_info(var_0, 15, 0) == "true";
}

get_should_play_warning_spawn(var_0) {
  return get_container_info(var_0, 16, 0) == "true";
}

get_time_before_auto_trigger_array(var_0) {
  return get_container_info_array(var_0, 17, 1);
}

get_container_info(var_0, var_1, var_2) {
  var_3 = tablelookup(level.container_spawn_table, 0, var_0, var_1);

  if(var_2)
    var_3 = int(var_3);

  return var_3;
}

get_container_info_array(var_0, var_1, var_2) {
  var_3 = tablelookup(level.container_spawn_table, 0, var_0, var_1);
  var_3 = strtok(var_3, " ");

  if(var_2) {
    foreach(var_6, var_5 in var_3)
    var_3[var_6] = int(var_5);
  }

  return var_3;
}

mark_spawn_clips_on(var_0, var_1) {
  var_2 = getEntArray(var_1.target, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(is_clip(var_5))
      var_3[var_3.size] = var_5;
  }

  var_0.intro_clips = var_3;
}

is_clip(var_0) {
  return var_0.classname == "script_brushmodel";
}

container_spawn_hive_monitor(var_0) {
  level endon("game_ended");

  for(;;) {
    level waittill("drill_planted");
    activate_container_spawn_for_hive(level.current_hive_name, var_0);
  }
}

activate_container_spawn_for_hive(var_0, var_1) {
  var_2 = get_container_id_list_for_hive(var_0, var_1);

  foreach(var_4 in var_2)
  activate_container_spawner_by_id(var_4);
}

get_container_id_list_for_hive(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_1) {
    if(common_scripts\utility::array_contains(var_4, var_0))
      var_2[var_2.size] = var_5;
  }

  return var_2;
}