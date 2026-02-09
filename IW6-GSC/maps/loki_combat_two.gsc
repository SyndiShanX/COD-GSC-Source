/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\loki_combat_two.gsc
*****************************************************/

section_

section_

section_flag_inits() {
  common_scripts\utility::flag_init("player_is_firing");
  common_scripts\utility::flag_init("combat_two_stage_1_done");
  common_scripts\utility::flag_init("section6");
  common_scripts\utility::flag_init("section5");
  common_scripts\utility::flag_init("section4");
  common_scripts\utility::flag_init("section3");
  common_scripts\utility::flag_init("section2");
  common_scripts\utility::flag_init("section1");
  common_scripts\utility::flag_init("turn_on_tracker");
  common_scripts\utility::flag_init("combat_two_stop_ignore");
  common_scripts\utility::flag_init("section3_justmove");
  common_scripts\utility::flag_init("combat_two_dialogue_done");
  common_scripts\utility::flag_init("allies_in_position");
  common_scripts\utility::flag_init("first_enemies_dead");
  common_scripts\utility::flag_init("combat_two_anim_intro_ally0_done");
  common_scripts\utility::flag_init("combat_two_anim_intro_ally1_done");
  common_scripts\utility::flag_init("combat_two_charge_enemy_spawned");
  common_scripts\utility::flag_init("enemies_above");
  common_scripts\utility::flag_init("sneaky_player");
  common_scripts\utility::flag_init("ally_0_combat_two_anims_finished");
  common_scripts\utility::flag_init("ally_1_combat_two_anims_finished");
}

combat_two_start() {
  maps\loki_util::player_move_to_checkpoint_start("combat_two");
  maps\loki_util::spawn_allies();
  maps\loki_space_breach::set_num_allies(2);
  level.player giveweapon(level.primary_weapon);
  level.player switchtoweapon(level.primary_weapon);
  level.player givemaxammo(level.primary_weapon);
  level.moving_cover_guys = [];
  wait 1.0;
  teleport_enemies();
  level thread show_combat_two_intro_debris();
  level thread maps\loki_moving_cover::lastframe_moving_cover();
  level thread combat_two_intro_vignette(0.0);
  level thread moving_large_debris();
  common_scripts\utility::flag_set("moving_cover_done2");
  level thread play_helmet_light_damage(10);
}

combat_two() {
  thread maps\loki_util::loki_autosave_by_name_silent("combat_two");
  thread maps\loki_audio::audio_set_default_ambience();
  thread maps\loki_fx::light_combat2_threads();
  common_scripts\utility::exploder("mc_end_impact_smk");
  common_scripts\utility::exploder("combat_two_amb_dust");
  maps\_utility::stop_exploder("mc_flare");
  common_scripts\utility::exploder("combat2_flare");
  common_scripts\utility::exploder("mc_steam_01");
  level.current_volume = getent("wave_3_in_debris_goal_volume", "targetname");
  level.current_high_volume = level.current_volume;
  level.allies[0] thread combat_two_ally_logic("y", "ally0", "combat_two_anim_intro_ally0_done");
  level.allies[1] thread combat_two_ally_logic("b", "ally1", "combat_two_anim_intro_ally1_done");
  level thread trigger_wave_3_during_moving_cover();
  level thread convert_moving_cover_enemies_to_wave_3();
  level thread combat_two_dialogue();
  level thread vo_move_up();
  level thread set_stop_ignore_flag();
  level thread ai_advancing_logic();
  level thread check_for_combat_two_done();
  level thread ally_target_logic();
  level thread change_enemy_priority();
  level thread set_sneaky_player_flag_on_trigger();
  level thread rotate_intel();
  level thread maps\loki_util::player_boundaries_on();
  level thread turn_on_node_once_player_advances("exposed_node_advance");
  level thread turn_on_node_once_player_advances("side_node_advance");
  level thread disable_nodes_before_allies_move();
  level thread fail_if_player_too_far();
  level thread combat_two_fire_straight_setup();
  level.combat_two_spawns = 0;
  var_0 = getent("combat_two_second_wave_retreat", "targetname");
  thread maps\_utility::set_flag_on_trigger(var_0, "combat_two_stage_1_done");
  wait 0.5;
  level thread spawn_enemies_on_ai_count();
  level thread spawn_enemies_on_flag();
  wait 1.5;
  common_scripts\utility::flag_wait("combat_two_done");
  level notify("end_of_combat_two");
}

play_helmet_light_damage(var_0) {
  level.player.helmet_show_damage = 1;

  while(!common_scripts\utility::flag("moving_cover_done2"))
    common_scripts\utility::waitframe();

  for(var_1 = 0; var_1 < var_0; var_1++)
    wait 1.0;

  level.player.helmet_show_damage = 0;
}

combat_two_ally_logic(var_0, var_1, var_2) {
  common_scripts\utility::flag_wait(var_2);
  maps\_utility::clear_force_color();
  self cleargoalvolume();
  common_scripts\utility::flag_wait("combat_two_stage_1_done");
  self.ignoreme = 0;
  self.ignoreall = 0;
}

hide_combat_two_intro_debris() {
  var_0 = getEntArray("combat_two_intro_debris", "targetname");

  foreach(var_2 in var_0) {
    var_2 hide();
    var_2 notsolid();
  }

  var_4 = getEntArray("intel_laptop", "script_noteworthy");

  foreach(var_6 in var_4)
  var_6 hide();
}

show_combat_two_intro_debris() {
  var_0 = getEntArray("combat_two_intro_debris", "targetname");

  foreach(var_2 in var_0) {
    var_2 show();
    var_2 solid();
  }

  var_4 = getEntArray("intel_laptop", "script_noteworthy");

  foreach(var_6 in var_4) {
    if(!getdvarint("ui_level_player_cheatpoints"))
      var_6 show();
  }
}

trigger_enemy_spawn(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");

  if(isDefined(var_3))
    var_3 waittill("trigger");

  enemy_spawn(var_1, var_2);
}

trigger_enemy_spawn_in_order(var_0, var_1, var_2, var_3) {
  var_4 = getent(var_0, "targetname");

  if(isDefined(var_4))
    var_4 waittill("trigger");

  thread maps\loki_audio::sfx_set_combat_two_amb();
  var_5 = 1;

  for(var_5 = 0; var_5 <= var_3; var_5++) {
    enemy_spawn(var_1 + "_" + var_5, var_2);
    wait 1.0;
  }
}

enemy_spawn(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = getEntArray(var_0, "targetname");

    foreach(var_4 in var_2)
    var_4 maps\_utility::add_spawn_function(var_1);
  }

  var_6 = maps\loki_util::spawn_space_ais_from_targetname(var_0);

  foreach(var_8 in var_6) {
    var_8 thread set_ai_attackeraccuracy();
    var_8 thread detectexposedandreacquire();
  }
}

detectexposedandreacquire() {
  self endon("death");
  var_0 = 64;
  var_1 = 5000;
  var_2 = self.origin;
  var_3 = gettime();

  for(;;) {
    var_4 = 0;

    if(isDefined(self.node) && self.node.type != "Exposed 3D" && distancesquared(self.origin, self.node.origin) < var_0)
      var_4 = 1;
    else if(distancesquared(self.origin, var_2) > var_0)
      var_4 = 1;

    var_5 = gettime();

    if(var_4) {
      var_2 = self.origin;
      var_3 = gettime();
    } else if(var_5 - var_1 > var_3) {
      animscripts\combat_utility::lookforbettercover();
      wait 2.0;
    } else {}

    wait 1.0;
  }
}

set_ai_attackeraccuracy() {
  self endon("death");
  self.attackeraccuracy = 0.1;
  var_0 = getent("combat_two_second_wave_retreat", "targetname");
  var_1 = getent("no_cover", "targetname");

  if(isDefined(var_0) && isDefined(var_1))
    common_scripts\utility::waittill_any_ents(var_0, "trigger", var_1, "trigger");

  self.attackeraccuracy = 0.1;
  var_0 = getent("combat_two_third_wave_extra", "targetname");

  if(isDefined(var_0))
    common_scripts\utility::waittill_any_ents(var_0, "trigger");

  self.attackeraccuracy = 0.1;
}

wait_until_volume_empty(var_0) {
  var_1 = getent(var_0, "targetname");

  while(isDefined(self) && !common_scripts\utility::flag("combat_two_done")) {
    var_2 = getaiarray("axis");
    var_3 = 1;

    foreach(var_5 in var_2) {
      if(var_5 istouching(var_1))
        var_3 = 0;
    }

    if(var_3) {
      break;
    }

    wait 0.1;
  }
}

teleport_enemies() {
  var_0 = getaiarray("axis");
  var_1 = getent("combat_two_teleport_node", "targetname");
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_1.origin = var_1.origin + (var_2, 0, 0);
    var_4 forceteleport(var_1.origin, var_1.angles);
    var_4 notify("stop_following_node_path");
    var_2 = var_2 - 40;
  }
}

convert_moving_cover_enemies_to_wave_3() {
  level.moving_cover_guys = [];
  var_0 = getent("ignore_volume", "targetname");
  var_0 waittill("trigger");
  var_1 = getaiarray("axis");
  var_2 = maps\_utility::get_ai_group_ai("combat_two_enemies");

  foreach(var_4 in var_1) {
    if(!maps\_utility::is_in_array(var_2, var_4)) {
      var_4 unlink();
      level.moving_cover_guys[level.moving_cover_guys.size] = var_4;

      if(isDefined(var_4) && isalive(var_4)) {
        if(isDefined(var_4.magic_bullet_shield))
          var_4 maps\_utility::stop_magic_bullet_shield();

        var_4 kill();
      }
    }
  }
}

combat_two_fire_straight_setup() {
  anim.fire_notetrack_functions["scripted"] = ::combat_two_fire_straight;
  common_scripts\utility::flag_wait("charge_set");
  anim.fire_notetrack_functions["scripted"] = animscripts\notetracks::fire_straight;
}

combat_two_fire_straight() {
  if(maps\_utility::get_ai_group_sentient_count("combat_two_enemies"))
    animscripts\notetracks::fire_straight();
}

trigger_on_ai_group_size(var_0, var_1) {
  self endon("death");
  self endon("trigger");

  for(;;) {
    if(var_1 == "axis") {
      var_2 = getaiarray("axis");
      var_3 = var_2.size;
    } else
      var_3 = maps\_utility::get_ai_group_sentient_count(var_1);

    if(var_3 <= var_0) {
      break;
    } else
      wait 0.1;
  }

  self notify("trigger");
}

turn_off_triggers_until_trigger() {
  var_0 = ["combat_two_third_wave_push_0", "combat_two_third_wave_push_1", "combat_two_third_wave_push_2"];

  foreach(var_2 in var_0) {
    var_2 = getent(var_2, "targetname");

    if(isDefined(var_2))
      var_2 common_scripts\utility::trigger_off();
  }

  var_2 = getent("combat_two_third_wave_extra", "targetname");

  if(isDefined(var_2))
    var_2 waittill("trigger");

  foreach(var_2 in var_0) {
    var_2 = getent(var_2, "targetname");

    if(isDefined(var_2))
      var_2 common_scripts\utility::trigger_on();
  }
}

wave_3_spawn_func() {
  self endon("death");
  level.combat_two_spawns++;
  wait 0.1;
  thread set_accuracy_when_allies_are_close();
  thread ignore_all_until_damaged();
  thread maps\loki_util::loki_drop_weapon();
  thread set_sneaky_player_flag_on_damage();
  waittill_player_advances_or_timeout();
  common_scripts\utility::flag_wait("combat_two_stop_ignore");
  common_scripts\utility::flag_wait_any("first_enemies_dead", "sneaky_player");
  wait 2.0;
  self notify("stop_ignoring");
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.favoriteenemy = level.player;
  thread swap_goal_volumes(level.current_volume);
  level waittill("enemies_charge_player");
  self notify("stop_goal_volume_swap");
  self.attackeraccuracy = 2;

  for(;;) {
    self setgoalpos(level.player.origin);
    wait 0.1;
  }
}

wave_3_high_spawn_func() {
  self endon("death");
  level.combat_two_spawns++;
  wait 0.1;
  thread set_accuracy_when_allies_are_close();
  thread ignore_all_until_damaged();
  thread maps\loki_util::loki_drop_weapon();
  thread set_sneaky_player_flag_on_damage();
  waittill_player_advances_or_timeout();
  common_scripts\utility::flag_wait("combat_two_stop_ignore");
  common_scripts\utility::flag_wait_any("first_enemies_dead", "sneaky_player");
  wait 2.0;
  self notify("stop_ignoring");
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.favoriteenemy = level.player;
  thread swap_goal_volumes(level.current_high_volume);
  level waittill("enemies_charge_player");
  self notify("stop_goal_volume_swap");
  self.attackeraccuracy = 2;

  for(;;) {
    self setgoalpos(level.player.origin);
    wait 0.1;
  }
}

wave_3_charge_spawn_func() {
  self endon("death");
  level.combat_two_spawns++;
  level thread vo_flag_timer(4, "enemies_above");
  thread maps\loki_util::loki_drop_weapon();
  self.ignoresuppression = 1;
  wait 0.1;
  common_scripts\utility::flag_set("combat_two_charge_enemy_spawned");
  var_0 = level.enemy_chargers.size + 1;
  level.enemy_chargers[level.enemy_chargers.size] = self;
  var_1 = getent("enemy_charge_target_" + var_0, "targetname");
  self setentitytarget(var_1);
  self waittill("goal");
  common_scripts\utility::flag_set("enemies_above");
  self notify("stop_ignoring");
  self.ignoreme = 0;
  self.attackeraccuracy = 1.0;
  self clearentitytarget();
  var_2 = getent("wave_3_in_debris_goal_volume", "targetname");
  self setgoalvolume(var_2);
  wait 1.0;
  self.favoriteenemy = level.player;
}

vo_flag_timer(var_0, var_1) {
  wait(var_0);
  common_scripts\utility::flag_set(var_1);
}

set_sneaky_player_flag_on_damage() {
  common_scripts\utility::waittill_any("death", "damage");
  common_scripts\utility::flag_set("sneaky_player");
}

set_sneaky_player_flag_on_trigger() {
  var_0 = getent("combat_two_third_wave_extra", "targetname");
  var_0 waittill("trigger");
  common_scripts\utility::flag_set("sneaky_player");
}

wave_3_extra_spawn_func() {
  self endon("death");
  wait 0.1;
  thread set_accuracy_when_allies_are_close();
  common_scripts\utility::flag_wait("combat_two_stop_ignore");
  self notify("stop_ignoring");
  self.ignoreall = 0;
  self.ignoreme = 0;
  thread swap_goal_volumes(level.current_volume);
  level waittill("enemies_charge_player");
  self notify("stop_goal_volume_swap");
  self.attackeraccuracy = 1;

  for(;;) {
    self setgoalpos(level.player.origin);
    wait 0.1;
  }
}

set_stop_ignore_flag() {
  var_0 = getent("ignore_volume", "targetname");
  var_0 thread ignore_timer(10);
  var_1 = getent("combat_two_second_wave_retreat", "targetname");
  var_2 = getent("no_cover", "targetname");

  if(isDefined(var_1) && isDefined(var_2))
    common_scripts\utility::waittill_any_ents(var_1, "trigger", var_2, "trigger", var_0, "time_up");

  common_scripts\utility::flag_set("combat_two_stop_ignore");
}

ignore_timer(var_0) {
  self waittill("trigger");
  wait(var_0);
  self notify("time_up");
}

waittill_player_advances_or_timeout() {
  var_0 = getent("ignore_volume", "targetname");
  var_1 = getent("no_cover", "targetname");

  if(isDefined(var_0) && isDefined(var_1))
    common_scripts\utility::waittill_any_ents(var_0, "trigger", var_1, "trigger", self, "initial_path_completed", self, "stop_ignoring");
}

ai_advancing_logic() {
  level thread enemy_goal_volume_logic();
  var_0 = getent("combat_two_third_wave", "targetname");
  var_0 waittill("trigger");
  var_1 = spawn("script_origin", level.player.origin);
  wait 0.1;
  var_1.angles = level.player.angles;
  level.player playerlinktodelta(var_1);
  level.player disableweapons();
  wait 0.2;
  level.player unlink();
  var_1 delete();
  var_2 = level.space_speed / 5;
  setsaveddvar("player_swimSpeed", var_2);
  wait 3.0;
  level.allies[0] maps\_utility::set_goal_node_targetname("combat_two_ally0_node_start");
  wait 1.0;
  level.allies[1] maps\_utility::set_goal_node_targetname("combat_two_ally1_node_start");
  var_0 = getent("combat_two_second_wave_push", "targetname");
  var_0 notify("trigger");
  level thread allies_color_advance_logic();
  wait 1.0;
  level thread set_flag_on_trigger_or_ai_count("section2", "combat_two_second_wave_retreat_trigger", 4, 0);
  level thread set_flag_on_trigger_or_ai_count("section3", "combat_two_third_wave_push_0_trigger", 7, 1);
  level thread set_flag_on_trigger_or_ai_count("section4", "combat_two_third_wave_push_1_trigger", 4, 1);
  level thread set_flag_on_trigger_or_ai_count("section5", "combat_two_third_wave_push_1_5_trigger", 3, 1);
  wait 4.0;
  setsaveddvar("player_swimSpeed", var_2 * 2);

  if(maps\_utility::is_gen4())
    setsaveddvar("r_mbEnable", 0);

  wait 3.0;
  level.player enableweapons();
  level.player enableweaponswitch();
  level.player showviewmodel();
  setsaveddvar("player_swimSpeed", level.space_speed);
  thread maps\loki_util::loki_autosave_by_name("combat_two_begin");
  level notify("combat_2_unlinked");
}

set_flag_on_trigger_or_ai_count(var_0, var_1, var_2, var_3) {
  var_4 = getent(var_1, "targetname");

  if(isDefined(var_4))
    var_4 waittill("trigger");

  common_scripts\utility::flag_set(var_0);
}

spawn_enemies_on_ai_count() {
  while(maps\_utility::get_ai_group_sentient_count("combat_two_enemies") > 3 || level.combat_two_spawns < 6)
    wait 0.1;

  common_scripts\utility::flag_set("section3_justmove");
  wait 0.5;

  while(maps\_utility::get_ai_group_sentient_count("combat_two_enemies") > 3 || level.combat_two_spawns < 9) {
    if(!common_scripts\utility::flag("section3") && maps\_utility::get_ai_group_sentient_count("combat_two_enemies") < 1)
      common_scripts\utility::flag_set("section3");

    wait 0.1;
  }

  common_scripts\utility::flag_set("section4");
  wait 0.5;

  while(maps\_utility::get_ai_group_sentient_count("combat_two_enemies") > 2 || level.combat_two_spawns < 13)
    wait 0.1;

  level notify("enemies_charge_player");

  while(maps\_utility::get_ai_group_sentient_count("combat_two_enemies") > 0)
    wait 0.1;

  common_scripts\utility::flag_set("section5");
}

spawn_enemies_on_flag() {
  common_scripts\utility::flag_wait_any("section5", "section4", "section3", "section2");
  enemy_spawn("combat_two_enemy_wave_3_extra", ::wave_3_spawn_func);
  enemy_spawn("combat_two_enemy_wave_3_extra_high", ::wave_3_high_spawn_func);
  common_scripts\utility::flag_wait_any("section5", "section4", "section3");
  enemy_spawn("combat_two_enemy_wave_3_extra_2", ::wave_3_spawn_func);
  enemy_spawn("combat_two_enemy_wave_3_extra_2_high", ::wave_3_high_spawn_func);
  common_scripts\utility::flag_wait_any("section5", "section4");
  enemy_spawn("combat_two_enemy_wave_3_extra_3", ::wave_3_spawn_func);
  enemy_spawn("combat_two_enemy_wave_3_extra_3_high", ::wave_3_high_spawn_func);
}

allies_color_advance_logic() {
  for(;;) {
    if(common_scripts\utility::flag("section5")) {
      var_0 = getent("combat_two_third_wave_push_1_5", "targetname");

      if(isDefined(var_0))
        var_0 notify("trigger");

      break;
    } else if(common_scripts\utility::flag("section4")) {
      var_0 = getent("combat_two_third_wave_push_1", "targetname");

      if(isDefined(var_0))
        var_0 notify("trigger");
    } else if(common_scripts\utility::flag("section3") || common_scripts\utility::flag("section3_justmove")) {
      var_0 = getent("combat_two_third_wave_push_0", "targetname");

      if(isDefined(var_0)) {
        var_0 notify("trigger");

        if(!common_scripts\utility::flag("section3"))
          level notify("section_3_move_up");
      }
    } else if(common_scripts\utility::flag("section2")) {
      var_0 = getent("combat_two_second_wave_retreat", "targetname");

      if(isDefined(var_0))
        var_0 notify("trigger");
    }

    wait 0.1;
  }
}

ally0_traversal_logic() {
  while(!common_scripts\utility::flag("section2"))
    wait 0.1;
}

ally_target_logic() {
  level.allies[0].ignoreall = 1;
  level.allies[0].ignoresuppression = 1;
  thread set_flag_when_first_enemies_dead("first_enemies_dead", level.enemy_chargers);
  common_scripts\utility::flag_wait("section2");
  common_scripts\utility::flag_wait("combat_two_anim_intro_ally0_done");
  level.allies[0].ignoreall = 1;
  thread wait_for_time_then_shoot_bomb(8.0);
  common_scripts\utility::flag_wait("first_enemies_dead");
  wait 2.2;
  level.allies[0] clearentitytarget();
  level.allies[0].ignoresuppression = 0;
  level.allies[0] maps\_utility::set_goal_node_targetname("combat_two_ally0_node");
  level.allies[1] maps\_utility::set_goal_node_targetname("combat_two_ally1_node");
}

enemies_around_nitro(var_0) {
  if(isDefined(var_0)) {
    foreach(var_2 in level.enemy_chargers) {
      if(isalive(var_2) && distance(var_2.origin, var_0.origin) < 250)
        return 1;
    }
  }

  return 0;
}

wait_for_time_then_shoot_bomb(var_0) {
  level endon("first_enemies_dead");
  var_1 = getent("nitro_target", "targetname");
  var_2 = getent("nitro_target_first", "targetname");
  common_scripts\utility::flag_wait_or_timeout("section3", var_0);

  while(enemies_around_nitro(var_1)) {
    level.allies[0] setentitytarget(var_1);
    wait 0.1;
  }

  level.allies[0] clearentitytarget();
}

set_flag_when_first_enemies_dead(var_0, var_1) {
  while(!isDefined(level.enemy_chargers) || level.enemy_chargers.size < 2)
    wait 0.1;

  while(level.enemy_chargers.size) {
    level.enemy_chargers = maps\_utility::array_removedead_or_dying(level.enemy_chargers);
    wait 0.1;
  }

  common_scripts\utility::flag_set(var_0);
}

set_flag_after_timer(var_0, var_1) {
  wait(var_1);
  common_scripts\utility::flag_set(var_0);
}

change_enemy_priority() {
  createthreatbiasgroup("higher_targets");
  createthreatbiasgroup("lower_targets");
  setthreatbias("allies", "higher_targets", 1000);
  setthreatbias("allies", "lower_targets", 10);

  while(!common_scripts\utility::flag("combat_two_done")) {
    var_0 = getaiarray("axis");

    foreach(var_2 in var_0) {
      if(var_2.origin[2] > 73950) {
        var_2 setthreatbiasgroup();
        var_2 setthreatbiasgroup("higher_targets");
        continue;
      }

      var_2 setthreatbiasgroup();
      var_2 setthreatbiasgroup("lower_targets");
    }

    wait 0.1;
  }
}

orient_ally(var_0) {
  var_1 = (self.angles[0], self.angles[1], 0);

  for(var_2 = 0; var_2 < var_0; var_2++) {
    var_3 = maps\_space_ai::fake_slerp(self.angles, var_1, var_2 / var_0);
    self orientmode("face angle 3d", var_3, 1);
    wait 0.05;
  }
}

enemy_goal_volume_logic() {
  for(;;) {
    if(common_scripts\utility::flag("section5")) {
      var_0 = getent("wave_3_push_advance_volume_2", "targetname");
      level.current_volume = var_0;
      var_0 = getent("wave_3_push_advance_volume_2_high", "targetname");
      level.current_high_volume = var_0;
      break;
    } else if(common_scripts\utility::flag("section4")) {
      var_0 = getent("wave_3_push_advance_volume_2", "targetname");
      level.current_volume = var_0;
      var_0 = getent("wave_3_push_advance_volume_2_high", "targetname");
      level.current_high_volume = var_0;
    } else if(common_scripts\utility::flag("section3")) {
      var_0 = getent("wave_3_push_advance_volume_1", "targetname");
      level.current_volume = var_0;
      var_0 = getent("wave_3_push_advance_volume_1_high", "targetname");
      level.current_high_volume = var_0;
    } else {
      var_0 = getent("wave_3_safe_volume", "targetname");
      level.current_volume = var_0;
      var_0 = getent("wave_3_safe_volume_high", "targetname");
      level.current_high_volume = var_0;
    }

    wait 0.1;
  }
}

turn_off_trigger_on_notify(var_0, var_1) {
  level endon("end_of_combat_two");
  level waittill(var_1);
  var_2 = getent(var_0, "targetname");

  if(isDefined(var_2))
    var_2 delete();
}

swap_goal_volumes(var_0) {
  self endon("death");
  self endon("stop_goal_volume_swap");
  var_1 = getent("no_cover", "targetname");
  var_2 = getent("wave_3_underside", "targetname");
  var_3 = getent("wave_3_in_open_goal_volume", "targetname");
  var_4 = getent("wave_3_everywhere_below_goal_volume", "targetname");
  wait 0.1;

  if(isalive(self)) {
    self setgoalvolumeauto(var_0);

    if(isDefined(self.node))
      self setgoalpos(self.node.origin);

    var_5 = level.current_volume;
    var_6 = self.baseaccuracy;

    while(!common_scripts\utility::flag("combat_two_done")) {
      if(level.player istouching(var_1) && !common_scripts\utility::flag("combat_two_stage_1_done")) {
        if(var_5 != var_3) {
          var_5 = var_3;
          self setgoalvolumeauto(var_3);
          self.favoriteenemy = level.player;
        }
      } else if(level.player istouching(var_2)) {
        if(var_5 != var_4) {
          var_5 = var_4;
          self setgoalvolumeauto(var_4);
          self.favoriteenemy = level.player;
        }
      } else if(var_5 != var_0) {
        var_5 = var_0;
        self setgoalvolumeauto(var_0);
        self.favoriteenemy = undefined;
      }

      wait 0.1;
    }
  }
}

send_guy_to_node_then_rotate() {
  var_0 = undefined;

  while(!isDefined(var_0)) {
    var_1 = getaiarray("axis");

    foreach(var_3 in var_1) {
      if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "spinning_cover_guy")
        var_0 = var_3;
    }

    wait 0.1;
  }

  var_0.goalradius = 4;
  var_0.ignoreall = 1;
  thread spinning_object("spinning_crate", 1);
}

spinning_cover(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_3 = getent(var_0 + "_clip", "targetname");

  if(isDefined(var_1) && isalive(var_1)) {
    var_1 waittill("goal");
    var_1 linkto(var_2);
    var_1.ignoreall = 0;
    var_2 rotatevelocity((0, 0, 2), 9999);
    var_3 rotatevelocity((0, 0, 2), 9999);
  }

  while(isDefined(var_1) && isalive(var_1)) {
    var_1 thread maps\_space_ai::doing_in_space_rotation(var_1.angles, var_2.angles, 4);
    wait 0.1;
  }
}

spinning_object(var_0, var_1) {
  var_2 = getEntArray(var_0, "script_noteworthy");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.target)) {
      var_5 = getent(var_4.target, "targetname");
      var_5 linkto(var_4);
    }

    var_4 rotatevelocity((0, 0, 2), 9999);
  }
}

check_for_combat_two_done() {
  common_scripts\utility::flag_wait("section5");

  while(level.combat_two_spawns < 13)
    wait 0.1;

  wait 1.0;

  while(maps\_utility::get_ai_group_sentient_count("combat_two_enemies") > 0)
    wait 0.1;

  level.allies[0].goalradius = 4;
  level.allies[1].goalradius = 4;
  var_0 = getent("combat_two_final_orders", "targetname");
  var_0 notify("trigger");
  common_scripts\utility::flag_set("combat_two_done");
}

trigger_wave_3_during_moving_cover() {
  level.enemy_chargers = [];
  level thread trigger_enemy_spawn("combat_two_third_wave", "combat_two_enemy_wave_3", ::wave_3_spawn_func);
  level thread trigger_enemy_spawn("combat_two_third_wave", "combat_two_enemy_wave_3_high", ::wave_3_high_spawn_func);
  level thread trigger_enemy_spawn_in_order("combat_two_second_wave_retreat_trigger", "combat_two_enemy_wave_3_charge", ::wave_3_charge_spawn_func, 2);
}

ignore_all_until_damaged() {
  self endon("stop_ignoring");
  self.ignoreall = 1;
  self.ignoreme = 1;
  self waittill("damage", var_0, var_1);

  if(isDefined(var_1)) {
    if(var_1 == level.player) {
      self.ignoreall = 0;
      var_2 = getaiarray("axis");
      var_3 = maps\_utility::get_closest_living(self.origin, var_2, 100);

      if(isDefined(var_3) && isalive(var_3)) {
        var_3.ignoreall = 0;
        var_3 notify("stop_ignoring");
      }
    }
  }
}

ignore_player_after_time(var_0, var_1) {
  level thread set_flag_when_not_firing(var_0);
  var_2 = getent("ignore_volume", "targetname");

  for(;;) {
    if(level.player istouching(var_2) && !common_scripts\utility::flag("player_is_firing") && var_1 > 0) {
      if(!level.player.ignoreme) {
        level.player.ignoreme = 1;
        var_1--;
      }
    } else if(level.player.ignoreme)
      level.player.ignoreme = 0;

    wait 0.1;
  }
}

set_flag_when_not_firing(var_0) {
  var_1 = 60 * var_0;
  var_2 = var_1;

  for(;;) {
    if(level.player attackbuttonpressed()) {
      var_2 = 0;

      if(!common_scripts\utility::flag("player_is_firing"))
        common_scripts\utility::flag_set("player_is_firing");
    } else
      var_2++;

    if(var_2 > var_1) {
      if(common_scripts\utility::flag("player_is_firing"))
        common_scripts\utility::flag_clear("player_is_firing");
    }

    common_scripts\utility::waitframe();
  }
}

set_accuracy_when_allies_are_close() {
  self endon("death");

  for(;;) {
    foreach(var_1 in level.allies) {
      if(isalive(var_1)) {
        if(distance(self.origin, var_1.origin) < 300)
          self.attackeraccuracy = 1;
      }
    }

    wait 0.1;
  }
}

combat_two_intro_vignette(var_0) {
  wait(var_0);
  level.allies[0] thread ally_0_animation();
  level.allies[1] thread ally_1_animation();
}

push_crates(var_0) {
  level.space_crate_01.animname = "combat_two_ally_01_crate_01";
  level.space_crate_01 maps\_utility::assign_animtree();
  level.space_crate_02.animname = "combat_two_ally_01_crate_02";
  level.space_crate_02 maps\_utility::assign_animtree();
  level.space_crate_01 thread maps\_anim::anim_single_solo(level.space_crate_01, "combat_two_trans_1");
  level.space_crate_02 thread maps\_anim::anim_single_solo(level.space_crate_02, "combat_two_trans_1");
}

ally_0_animation() {
  self stopanimscripted();
  self pushplayer(1);
  self.fixednode = 1;
  self notify("stop_traversal_hit_detection");
  common_scripts\utility::waitframe();
  var_0 = getnode("combat_two_ally1_node", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1.angles = (0, 0, 0);
  level.combat_two_start_anim_node = var_1;
  wait 0.1;
  maps\_utility::set_goal_node_targetname("combat_two_ally0_node_start");
  var_2 = maps\_utility::spawn_anim_model("combat_two_ally_02_crate_01");
  var_3 = [];
  var_3["ally_0"] = level.allies[0];
  var_3["combat_two_ally_02_crate_01"] = var_2;
  var_1 maps\_anim::anim_single(var_3, "combat_two_trans_1");
  common_scripts\utility::flag_set("combat_two_anim_intro_ally0_done");
  common_scripts\utility::flag_wait("section2");
  common_scripts\utility::flag_wait("first_enemies_dead");
  wait 2.0;
  self.ignoreall = 1;
  var_4 = getnode("combat_two_ally0_node", "targetname");
  self setgoalnode(var_4);
  self.disablearrivals = undefined;
  self waittill("goal");
  self.ignoreall = 0;
  common_scripts\utility::flag_wait_any("section3_justmove", "section3");
  wait_until_volume_empty("combat_two_safe_volume_2");
  var_5 = getnode("combat_two_ally0_node_2", "targetname");

  while(distance(level.player.origin, var_5.origin) < 50)
    wait 0.1;

  var_3 = [];
  var_3["ally_0"] = level.allies[0];
  thread maps\loki_combat_one::force_traversal_check_hit();
  var_1 maps\_anim::anim_reach_solo(self, "combat_two_trans_2");
  maps\_utility::delaythread(0.5, maps\_utility::set_goal_node_targetname, "combat_two_ally0_node_2");
  var_1 maps\_anim::anim_single(var_3, "combat_two_trans_2");
  self notify("stop_traversal_hit_detection");
  common_scripts\utility::flag_wait("section3");
  common_scripts\utility::flag_wait("section4");
  wait_until_volume_empty("combat_two_safe_volume_3");
  wait 4.0;
  var_5 = getnode("combat_two_ally0_node_3", "targetname");

  while(distance(level.player.origin, var_5.origin) < 50)
    wait 0.1;

  thread maps\loki_combat_one::force_traversal_check_hit();
  var_1 maps\_anim::anim_reach_solo(self, "combat_two_trans_3");
  maps\_utility::delaythread(0.5, maps\_utility::set_goal_node_targetname, "combat_two_ally0_node_3");
  var_1 maps\_anim::anim_single(var_3, "combat_two_trans_3");
  self notify("stop_traversal_hit_detection");
  common_scripts\utility::flag_wait("combat_two_done");
  var_1 notify("stop_loop");
  common_scripts\utility::waitframe();
  var_1 maps\_anim::anim_reach_solo(self, "combat_two_trans_4");
  maps\_utility::delaythread(0.5, maps\_utility::set_goal_node_targetname, "ally_0_breach_node");
  var_1 maps\_anim::anim_single(var_3, "combat_two_trans_4");
  common_scripts\utility::flag_set("ally_0_combat_two_anims_finished");
  var_1 thread maps\_anim::anim_loop(var_3, "combat_two_trans_4_loop", "stop_loop");
  common_scripts\utility::flag_wait("charge_set");
  var_1 notify("stop_loop");
  level.space_crate_01 delete();
  level.space_crate_02 delete();
  var_2 delete();
  var_1 delete();
}

ally_1_animation() {
  self stopanimscripted();
  self pushplayer(1);
  self.fixednode = 1;
  self.goalradius = 40;
  self notify("stop_traversal_hit_detection");
  common_scripts\utility::waitframe();
  var_0 = getnode("combat_two_ally1_node", "targetname");
  var_1 = spawn("script_origin", var_0.origin);
  var_1.angles = (0, 0, 0);
  wait 0.1;
  var_2 = maps\_utility::spawn_anim_model("combat_two_ally_02_trans_2_crate", var_1.origin);
  var_3 = [];
  var_3["combat_two_ally_02_trans_2_crate"] = var_2;
  var_1 maps\_anim::anim_first_frame(var_3, "combat_two_trans_2");
  var_4 = spawn("script_origin", var_2.origin);
  var_4 linkto(var_2);
  var_5 = getEntArray("spinning_crate_collision", "targetname");

  foreach(var_7 in var_5)
  var_7 linkto(var_4);

  var_3 = [];
  var_3["ally_1"] = level.allies[1];
  var_1 maps\_anim::anim_single(var_3, "combat_two_trans_1");
  var_1 thread maps\_anim::anim_loop(var_3, "combat_two_trans_1_loop", "stop_loop");
  common_scripts\utility::flag_wait("section2");
  common_scripts\utility::flag_wait("first_enemies_dead");
  wait 2.0;
  var_1 notify("stop_loop");
  thread maps\loki_combat_one::force_traversal_check_hit();
  maps\_utility::delaythread(0.5, maps\_utility::set_goal_node_targetname, "combat_two_ally1_node");
  var_1 maps\_anim::anim_single(var_3, "combat_two_trans_1_exit");
  self notify("stop_traversal_hit_detection");
  self.goalradius = 40;
  common_scripts\utility::flag_set("combat_two_anim_intro_ally1_done");
  self.fixednode = 1;
  self notify("force_space_rotation_update", 0, 0);
  common_scripts\utility::flag_wait_any("section3_justmove", "section3");
  wait_until_volume_empty("combat_two_safe_volume_2");
  var_9 = getnode("combat_two_ally1_node_2", "targetname");

  while(distance(level.player.origin, var_9.origin) < 50)
    wait 0.1;

  thread maps\loki_combat_one::force_traversal_check_hit();
  var_1 maps\_anim::anim_reach_solo(self, "combat_two_trans_2");
  maps\_utility::delaythread(0.5, maps\_utility::set_goal_node_targetname, "combat_two_ally1_node_2");
  level thread handle_player_crate_interaction();
  var_3 = [];
  var_3["ally_1"] = level.allies[1];
  var_3["combat_two_ally_02_trans_2_crate"] = var_2;
  var_1 maps\_anim::anim_single(var_3, "combat_two_trans_2");
  self notify("stop_traversal_hit_detection");
  self.goalradius = 40;
  level thread kill_enemy_at_arm_node();
  common_scripts\utility::flag_wait("section3");
  common_scripts\utility::flag_wait("section4");
  wait_until_volume_empty("combat_two_safe_volume_3");
  var_9 = getnode("combat_two_ally1_node_3", "targetname");

  while(distance(level.player.origin, var_9.origin) < 50)
    wait 0.1;

  thread maps\loki_combat_one::force_traversal_check_hit();
  var_1 maps\_anim::anim_reach_solo(self, "combat_two_trans_3");
  maps\_utility::delaythread(0.5, maps\_utility::set_goal_node_targetname, "combat_two_ally1_node_3");
  var_3 = [];
  var_3["ally_1"] = level.allies[1];
  var_1 maps\_anim::anim_single(var_3, "combat_two_trans_3");
  self notify("stop_traversal_hit_detection");
  common_scripts\utility::flag_wait("combat_two_done");
  var_1 notify("stop_loop");
  common_scripts\utility::waitframe();
  var_1 maps\_anim::anim_reach_solo(self, "combat_two_trans_4");
  maps\_utility::delaythread(0.5, maps\_utility::set_goal_node_targetname, "ally_1_breach_node");
  var_1 maps\_anim::anim_single(var_3, "combat_two_trans_4");
  common_scripts\utility::flag_set("ally_1_combat_two_anims_finished");
  var_1 thread maps\_anim::anim_loop(var_3, "combat_two_trans_4_loop", "stop_loop");
  common_scripts\utility::flag_wait("charge_set");
  var_1 notify("stop_loop");
  var_1 delete();
}

handle_player_crate_interaction() {
  level endon("crate_anim_done");

  while(!common_scripts\utility::flag("charge_set")) {
    level.player forcemovingplatformentity(undefined);
    common_scripts\utility::waitframe();
  }
}

turn_on_node_once_player_advances(var_0) {
  wait 0.1;
  var_1 = getnode(var_0, "targetname");

  if(isDefined(var_1)) {
    var_1 disconnectnode();
    common_scripts\utility::flag_wait("combat_two_anim_intro_ally1_done");
    var_1 connectnode();
  }
}

rotate_intel() {
  wait 3.0;
  var_0 = getEntArray("intel_laptop", "script_noteworthy");
  var_1 = getent("intelligence_item", "targetname");
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_4.classname == "script_model") {
      var_4 rotatevelocity((-2, 0, -7), 9999);
      var_4 moveto(var_4.origin + (0, 0, 450), 120);
      var_2 = var_4;
    }
  }

  if(isDefined(var_2)) {
    while(!common_scripts\utility::flag("space_breach_done")) {
      var_1.origin = var_2.origin;
      common_scripts\utility::waitframe();
    }
  }
}

fake_function() {
  level.player setplayerangles((0, 90, 0));
}

turn_on_ally_tracker() {
  common_scripts\utility::flag_wait("turn_on_tracker");
  var_0 = newhudelem();
  var_0 setshader("apache_target_lock", 1, 1);
  var_0.alpha = 1.0;
  var_0.color = (0, 1, 1);
  var_0 setwaypoint(1);
  objective_position(maps\_utility::obj("obj_advance"), self.origin);

  while(!common_scripts\utility::flag("combat_two_done")) {
    var_0.x = self gettagorigin("j_spinelower")[0];
    var_0.y = self gettagorigin("j_spinelower")[1];
    var_0.z = self gettagorigin("j_spinelower")[2];
    common_scripts\utility::waitframe();
  }

  var_0 destroy();
}

kill_enemy_at_arm_node() {
  var_0 = getnode("combat_two_ally1_node_2", "targetname");
  var_1 = getnode("arm_node", "script_noteworthy");
  var_2 = spawn("script_origin", var_1.origin);
  var_3 = undefined;
  var_4 = 0.1;

  while(!common_scripts\utility::flag("combat_two_done")) {
    if(isnodeoccupied(var_0) && isnodeoccupied(var_1)) {
      var_5 = getaiarray("axis");
      var_3 = undefined;

      foreach(var_7 in var_5) {
        if(distance(var_7.origin, var_1.origin) < 60)
          var_3 = var_7;
      }

      if(isDefined(var_3)) {
        var_4 = var_3.attackeraccuracy;
        var_3.attackeraccuracy = 10.0;
        var_2.origin = var_3.origin + (5, 5, 20);
        level.allies[1].favoriteenemy = var_3;
      }
    } else {
      if(isDefined(var_3) && isalive(var_3)) {
        var_3.attackeraccuracy = var_4;
        var_3 = undefined;
      }

      level.allies[1].favoriteenemy = undefined;
    }

    wait 0.1;
  }

  level.allies[1].ignoreall = 0;
  var_2 delete();
}

diable_nodes_if_near_player() {
  var_0 = getEntArray("disable_nodes", "targetname");

  foreach(var_2 in var_0)
  var_2 thread turn_off_nodes();
}

disable_nodes_if_allies_nearby(var_0) {
  var_1 = 200;

  while(!common_scripts\utility::flag("combat_two_done")) {
    var_2 = 0;
    var_3 = getnodearray("close_node", "script_noteworthy");

    foreach(var_5 in var_3) {
      if(distance(self.origin, var_5.origin) < var_1) {
        var_2 = 1;
        var_5 disconnectnode();
        badplace_cylinder(var_0, 0, var_5.origin, 32, 32, "axis");
      }
    }

    if(!var_2)
      badplace_delete(var_0);

    wait 0.1;
  }
}

disable_nodes_before_allies_move() {
  common_scripts\utility::flag_wait("section3");
  thread disconnect_and_bad_place("left_pallet_node", "script_noteworthy");
  thread disconnect_and_bad_place("right_pallet_node", "script_noteworthy");
  thread disconnect_and_bad_place("exposed_node_advance", "targetname");
  common_scripts\utility::flag_wait("section4");
  thread disconnect_and_bad_place("center_cover_1", "script_noteworthy");
  thread disconnect_and_bad_place("center_cover_2", "script_noteworthy");
  thread disconnect_and_bad_place("right_three_box_node", "script_noteworthy");
  thread disconnect_and_bad_place("right_back_three_box_node", "script_noteworthy");
  thread disconnect_and_bad_place("back_three_box_node", "script_noteworthy");
}

disconnect_and_bad_place(var_0, var_1) {
  var_2 = getnode(var_0, var_1);

  if(isDefined(var_2)) {
    var_2 disconnectnode();
    badplace_cylinder(var_0, 0, var_2.origin, 32, 32, "axis");
  }
}

turn_off_nodes() {
  while(!common_scripts\utility::flag("combat_two_done")) {
    if(level.player istouching(self)) {
      var_0 = getnodearray("node_to_disable", "targetname");

      foreach(var_2 in var_0)
      var_2 disconnectnode();
    } else {
      var_0 = getnodearray("node_to_disable", "targetname");

      foreach(var_2 in var_0)
      var_2 connectnode();
    }

    wait 0.1;
  }
}

node_preference_logic() {
  var_0 = getnode("arm_node", "script_noteworthy");
  var_1 = getnode("left_pallet_node", "targetname");
  level thread node_change_logic(var_0, var_1);
  common_scripts\utility::flag_wait_any("section5", "section4", "section3");
  var_0 = getnode("small_crates_node", "script_noteworthy");
  var_2 = getnode("center_cover_1", "script_noteworthy");
  var_3 = getnode("center_cover_2", "script_noteworthy");
  var_1 = maps\_utility::make_array(var_2, var_3);
  level thread node_change_logic(var_0, var_1);
  common_scripts\utility::flag_wait_any("section5", "section4");
  var_0 = getnode("floating_crate_2", "script_noteworthy");
  var_1 = getnode("back_cover_2", "script_noteworthy");
  level thread node_change_logic(var_0, var_1);
  var_0 = getnode("floating_crate_1", "script_noteworthy");
  var_1 = getnode("back_cover_1", "script_noteworthy");
  level thread node_change_logic(var_0, var_1);
}

node_change_logic(var_0, var_1) {
  if(!isarray(var_1))
    var_1 = maps\_utility::make_array(var_1);

  var_2 = 1;

  while(!common_scripts\utility::flag("combat_two_done")) {
    var_3 = 0;

    if(!isnodeoccupied(var_0)) {
      foreach(var_5 in var_1) {
        if(isnodeoccupied(var_5)) {
          if(!var_3) {
            var_0 disconnectnode();
            var_3 = 1;
            var_2 = 0;
          }
        }
      }

      if(!var_3 && !var_2) {
        var_0 connectnode();
        var_2 = 1;
      }
    }

    common_scripts\utility::waitframe();
  }
}

moving_large_debris() {
  var_0 = getEntArray("ambient_debris", "targetname");
  var_1 = getent("ambient_debris_ref_node", "targetname");
  var_2 = 20000;
  var_3 = 2000;

  foreach(var_5 in var_0)
  var_5 hide();

  common_scripts\utility::flag_wait("moving_cover_done2");

  foreach(var_5 in var_0) {
    var_5 show();
    var_8 = var_5.origin - var_1.origin;
    var_8 = vectornormalize(var_8);

    if(isDefined(var_5.script_noteworthy) && var_5.script_noteworthy == "small_debris") {
      var_9 = var_3 * randomfloatrange(0.2, 0.3);
      var_10 = (randomintrange(10, 20), randomintrange(10, 20), randomintrange(10, 20));
    } else {
      var_9 = var_3 * randomfloatrange(1.0, 2.0);
      var_10 = (randomintrange(1, 20), randomintrange(1, 20), randomintrange(1, 20));
    }

    var_11 = var_8 * var_2 + var_5.origin;
    var_5 moveto(var_11, var_9);
    var_5 rotatevelocity(var_10, var_3);
  }

  common_scripts\utility::flag_wait("charge_set");

  foreach(var_5 in var_0)
  var_5 delete();
}

fail_if_player_too_far() {
  level endon("charge_set");
  var_0 = getent("player_too_far", "targetname");
  var_0 waittill("trigger");
  setDvar("ui_deadquote", &"LOKI_BOUNDS_FAIL");
  level thread maps\_utility::missionfailedwrapper();
}

combat_two_dialogue() {
  level.player endon("death");
  waittill_trigger_targetname("ignore_volume");
  maps\_utility::battlechatter_off("allies");
  wait 7.0;
  maps\_utility::smart_radio_dialogue("loki_gs3_thompsonwecantstop");
  common_scripts\utility::flag_set("combat_two_music_start");
  common_scripts\utility::flag_wait("combat_two_charge_enemy_spawned");
  wait 2.0;

  while(!common_scripts\utility::flag("first_enemies_dead")) {
    if(common_scripts\utility::flag("enemies_above")) {
      maps\_utility::smart_radio_dialogue("loki_kgn_thompsontangos12high");
      break;
    }

    wait 0.1;
  }

  common_scripts\utility::flag_wait("first_enemies_dead");
  wait 2.0;
  maps\_utility::smart_radio_dialogue("loki_mrk_icaruscommandweretaking");
  maps\_utility::smart_radio_dialogue("loki_gs3_werenearthecontrol");
  maps\_utility::smart_radio_dialogue("loki_gs3_wellhavetobreach");
  maps\_utility::battlechatter_on("allies");
  waittill_trigger_targetname("combat_two_second_wave_push", 10);
  waittill_trigger_targetname("combat_two_third_wave_extra");
  wait 2.0;
  common_scripts\utility::flag_wait("combat_two_done");
  maps\_utility::battlechatter_off("allies");
  thread maps\loki_audio::sfx_end_combat_amb();
  maps\_utility::smart_radio_dialogue("loki_gs3_allclearmoveup");
  var_0 = getent("combat_two_third_wave_push_2_trigger", "targetname");

  if(!level.player istouching(var_0)) {
    maps\_utility::smart_radio_dialogue("loki_mrk_icaruscommandourground");
    maps\_utility::smart_radio_dialogue("loki_gs3_copywerebreachingnow");
  } else
    maps\_utility::smart_radio_dialogue("loki_kgn_controlmodulesjustahead");

  common_scripts\utility::flag_set("combat_two_dialogue_done");
}

vo_move_up() {
  level waittill("section_3_move_up");
  wait 5.0;

  if(!common_scripts\utility::flag("section3"))
    maps\_utility::smart_radio_dialogue("loki_kgn_keeppressingthompson");
}

waittill_trigger_targetname(var_0, var_1) {
  var_2 = getent(var_0, "targetname");

  if(isDefined(var_2)) {
    if(isDefined(var_1))
      var_2 childthread common_scripts\utility::_timeout(var_1);

    var_2 common_scripts\utility::waittill_any("trigger", "returned");
  }
}