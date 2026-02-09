/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nml_stealth.gsc
*****************************************************/

_autosave_stealthcheck_nml() {
  if(common_scripts\utility::flag("_stealth_spotted"))
    return 0;

  if(!maps\_stealth_utility::stealth_is_everything_normal())
    return 0;

  if(common_scripts\utility::flag("_stealth_player_nade"))
    return 0;

  if(common_scripts\utility::flag_exist("_radiation_poisoning")) {
    if(common_scripts\utility::flag("_radiation_poisoning"))
      return 0;
  }

  var_0 = getEntArray("destructible", "classname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.healthdrain))
      return 0;
  }

  var_4 = getEntArray("grenade", "classname");

  if(var_4.size > 0)
    return 0;

  return 1;
}

stealth_settings() {}

stealth_settings_intro() {
  var_0 = [];
  var_0["prone"] = 350;
  var_0["crouch"] = 400;
  var_0["stand"] = 1024;
  var_1 = [];
  var_1["prone"] = 512;
  var_1["crouch"] = 5000;
  var_1["stand"] = 8000;
  maps\_stealth_utility::stealth_detect_ranges_set(var_0, var_1);
}

stealth_settings_tunnel() {
  var_0 = [];
  var_0["prone"] = 150;
  var_0["crouch"] = 250;
  var_0["stand"] = 1024;
  var_1 = [];
  var_1["prone"] = 512;
  var_1["crouch"] = 5000;
  var_1["stand"] = 8000;
  maps\_stealth_utility::stealth_detect_ranges_set(var_0, var_1);
}

stealth_settings_dog() {
  level.default_stealth_override = ::stealth_settings_dog;
  var_0["prone"] = 100;
  var_0["crouch"] = 300;
  var_0["stand"] = 300;
  var_1["prone"] = 150;
  var_1["crouch"] = 300;
  var_1["stand"] = 300;
  maps\_stealth_utility::stealth_detect_ranges_set(var_0, var_1);
}

stealth_settings_dog_pc() {
  level.default_stealth_override = ::stealth_settings_dog_pc;
  var_0["prone"] = 400;
  var_0["crouch"] = 400;
  var_0["stand"] = 400;
  var_1["prone"] = 500;
  var_1["crouch"] = 500;
  var_1["stand"] = 500;
  maps\_stealth_utility::stealth_detect_ranges_set(var_0, var_1);
}

stealth_settings_dog_dropdown() {
  var_0["prone"] = 1000;
  var_0["crouch"] = 1000;
  var_0["stand"] = 1000;
  var_1["prone"] = 1000;
  var_1["crouch"] = 1000;
  var_1["stand"] = 1000;
  maps\_stealth_utility::stealth_detect_ranges_set(var_0, var_1);
}

stealth_shot(var_0) {
  self endon("death");
  var_0 endon("death");
  self.ignoreall = 0;
  self.favoriteenemy = var_0;
  self getenemyinfo(var_0);
  var_0.health = 1;
  wait 0.3;
  var_0.dontattackme = undefined;
  wait 0.3;
  var_1 = self gettagorigin("tag_flash");
  var_2 = var_0 gettagorigin("j_head");
  var_3 = bulletTrace(var_1, var_2, 1);

  while(!isDefined(self.a.array) || !isDefined(self.a.array["single"]) || self.a.array["single"].size <= 0)
    wait 0.05;

  var_4 = randomint(self.a.array["single"].size);
  var_5 = self.a.array["single"][var_4];
  var_6 = 0.1 / weaponfiretime(self.weapon);
  self setflaggedanimknobrestart("fire_notify", var_5, 1, 0.05, 1.0);
  wait 0.1;
  var_7 = var_0 getEye();
  var_8 = vectornormalize(var_7 - self gettagorigin("tag_flash"));
  var_8 = var_8 * 20;
  var_9 = var_7 - var_8;
  magicbullet(self.weapon, var_9, var_7);
  wait 0.2;
  var_0 kill();
}

magic_stealth_shot(var_0, var_1) {
  var_2 = self gettagorigin("tag_flash");
  var_3 = var_0 getEye();
  var_4 = vectornormalize(var_3 - var_2);
  var_4 = var_4 * 64;
  var_5 = var_3 + var_4;
  var_0.health = 1;

  if(isDefined(var_1)) {
    level.snipe_audio_fire = spawn("script_origin", var_2);
    level.snipe_audio_impact = spawn("script_origin", var_3);
    var_6 = "scn_nml_sniper_shot_0" + var_1;
    var_7 = "scn_nml_sniper_impact_0" + var_1;
    level.snipe_audio_fire thread maps\_utility::play_sound_on_entity(var_6);
    wait 0.25;
    level.snipe_audio_impact thread maps\_utility::play_sound_on_entity(var_7);
  }

  magicbullet(self.weapon, var_5, var_3);
  wait 0.1;

  if(isDefined(var_0)) {
    var_8 = var_0 getEye();
    playFX(common_scripts\utility::getfx("flesh_hit_head_fatal_exit_exaggerated"), var_8, var_4 * -1, (0, 0, 1));
    wait 0.1;

    if(isalive(var_0))
      var_0 kill();
  }
}

dog_stealth() {
  maps\_stealth_utility::stealth_plugin_basic();

  if(isPlayer(self)) {
    return;
  }
  thread dog_stealth_visibility();
  level._stealth.logic.detection_timeout = 4;

  switch (self.team) {
    case "allies":
      var_0 = [];
      var_0["hidden"] = ::dog_friendly_hidden;
      var_0["spotted"] = ::dog_friendly_spotted;
      maps\_stealth_utility::stealth_plugin_aicolor(var_0);
  }
}

dog_friendly_hidden() {
  if(isDefined(self.controlling_dog) && self.controlling_dog) {
    return;
  }
  self.goalradius = 64;
  maps\nml_util::set_move_rate(0.8);
}

dog_friendly_spotted() {
  if(isDefined(self.controlling_dog) && self.controlling_dog) {
    return;
  }
  self.goalradius = 512;
  maps\_utility::disable_ai_color();
  self.script_old_forcecolor = undefined;
  self.pathenemyfightdist = self.goalradius;
  maps\nml_util::set_move_rate(1.3);
}

dog_stealth_visibility() {
  self endon("death");

  for(;;) {
    self waittill("new_dog_command");
    var_0 = self.ignoreme;
    self.ignoreme = 0;
    self waittill("dog_command_complete");

    if(!maps\_stealth_utility::stealth_group_spotted_flag())
      self.ignoreme = var_0;
  }
}

stealth_satellite_guys() {
  thread _spawner_stealth_dog();
}

_spawner_stealth_dog() {
  thread maps\_stealth_utility::stealth_default();

  if(self.team == "axis") {
    thread listen_dog_attack();
    maps\_stealth_event_enemy::stealth_event_mod("dog_attack", ::enemy_event_reaction_dog_attack, ::enemy_animation_surprise);
    maps\_stealth_event_enemy::stealth_event_mod("dog_bark", ::enemy_event_reaction_dog_bark, ::enemy_animation_surprise);
    thread no_cover_until_spotted();
    var_0 = [];
    var_0["hidden"] = ::enemy_state_hidden;
    var_0["spotted"] = maps\_stealth_behavior_enemy::enemy_state_spotted;
    maps\_stealth_behavior_enemy::enemy_custom_state_behavior(var_0);
  }
}

enemy_state_hidden() {
  self.fovcosine = 0.6;
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

no_cover_until_spotted() {
  self.combatmode = "no_cover";
  common_scripts\utility::waitframe();
  self.oldcombatmode = "cover";
  maps\_utility::ent_flag_wait("_stealth_attack");
  self.combatmode = "cover";
}

dialog_found_a_body() {
  var_0 = [];
  var_0[var_0.size] = "nml_hsh_looksliketheyfound";
  level endon("satellite_end");
  var_1 = 0;

  while(!common_scripts\utility::flag("satellite_end")) {
    common_scripts\utility::flag_wait("_stealth_found_corpse");

    if(!common_scripts\utility::flag("_stealth_spotted")) {
      maps\_utility::smart_radio_dialogue(var_0[var_1], 0.1);
      var_1++;

      if(var_1 >= var_0.size)
        var_1 = 0;
    }

    common_scripts\utility::flag_waitopen("_stealth_found_corpse");
  }
}

dialog_player_kill() {
  var_0 = ["nml_hsh_hesdown", "nml_hsh_tangodown", "nml_hsh_goodkill", "nml_hsh_nice"];
  self waittill("death", var_1, var_2);

  if(!isDefined(var_1)) {
    return;
  }
  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  if(!maps\_stealth_utility::stealth_is_everything_normal()) {
    return;
  }
  if(isPlayer(var_1) || var_1 == level.dog) {
    wait 1;

    if(!maps\_stealth_utility::stealth_is_everything_normal()) {
      return;
    }
    if(!isDefined(level.player_kill_time))
      level.player_kill_time = gettime();
    else if(gettime() < level.player_kill_time + 15000) {
      return;
    }
    level.player_kill_time = gettime();
    maps\_utility::smart_radio_dialogue(common_scripts\utility::random(var_0), 0.1);
  }
}

dialog_theyre_looking_for_you() {
  var_0 = [];
  var_0[var_0.size] = "nml_hsh_stayoutofsight";
  self endon("death");
  self endon("dog_attacks_ai");

  if(!maps\_utility::ent_flag_exist("_stealth_normal")) {
    return;
  }
  maps\_utility::ent_flag_waitopen("_stealth_normal");

  if(common_scripts\utility::flag("someone_became_alert")) {
    return;
  }
  common_scripts\utility::flag_set("someone_became_alert");
  self endon("jumpedout");
  level maps\_utility::add_wait(::wait_till_every_thing_stealth_normal_for, 3);
  level maps\_utility::add_func(common_scripts\utility::flag_clear, "someone_became_alert");
  thread maps\_utility::do_wait();
  level endon("_stealth_spotted");

  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  wait 0.75;
  var_1 = var_0[randomint(var_0.size)];
  maps\_utility::smart_radio_dialogue_interrupt(var_1);
}

wait_till_every_thing_stealth_normal_for(var_0) {
  for(;;) {
    if(maps\_stealth_utility::stealth_is_everything_normal()) {
      wait(var_0);

      if(maps\_stealth_utility::stealth_is_everything_normal())
        return;
    }

    wait 1;
  }
}

listen_dog_attack() {
  self endon("death");

  for(;;) {
    self waittill("dog_attacks_ai", var_0, var_1);
    maps\_stealth_utility::disable_stealth_for_ai();
    thread maps\_utility::set_battlechatter(0);
    var_2 = getaiarray("axis");
    var_2 = sortbydistance(var_2, self.origin);
    var_3 = 250;

    if(var_1 == "F")
      var_3 = 500;

    foreach(var_5 in var_2) {
      if(var_5 != self && isDefined(var_5._stealth)) {
        if(distance(var_5.origin, self.origin) < var_3) {
          var_5 maps\_stealth_visibility_enemy::enemy_event_awareness_notify("dog_attack", var_0);
          continue;
        }

        break;
      }
    }
  }
}

enemy_event_reaction_dog_attack(var_0) {
  var_1 = self._stealth.logic.event.awareness_param[var_0];
  wait 0.05;
  maps\_utility::ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");
  var_2 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(var_1.origin, 300, 40);
  maps\_stealth_event_enemy::enemy_investigate_position(var_2);
  thread maps\_stealth_shared_utilities::stealth_set_idle_anim("_stealth_look_around");
  wait(randomfloatrange(1, 3));
}

enemy_event_reaction_dog_bark(var_0) {
  var_1 = self._stealth.logic.event.awareness_param[var_0];
  var_2 = var_1.origin;
  wait 0.05;
  maps\_utility::ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");
  var_3 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(var_2, 300, 40);
  thread maps\_stealth_shared_utilities::stealth_set_run_anim("_stealth_patrol_search_a");
  maps\_stealth_event_enemy::enemy_investigate_position(var_3);
}

enemy_animation_surprise(var_0) {
  self.allowdeath = 1;
  var_1 = self._stealth.logic.event.awareness_param[var_0];
  var_2 = var_1;

  if(isDefined(var_2)) {
    var_3 = distance(self.origin, var_2.origin);
    var_4 = 3;
    var_5 = 1024;

    for(var_6 = 1; var_6 < var_4; var_6++) {
      var_7 = var_5 * (var_6 / var_4);

      if(var_3 < var_7) {
        break;
      }
    }
  } else
    var_6 = 4;

  var_8 = "_stealth_behavior_generic" + var_6;
  maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self, "gravity", var_8);
}

disable_stealth() {
  level.dog endon("death");
  maps\_stealth_utility::disable_stealth_system();
  wait 0.1;
  maps\nml_util::team_set_colors();
  level.dog.goalradius = 32;
  level.dog.idlelookattargets = undefined;
  level.dog setdogattackradius(256);
  level.baker maps\_utility::enable_cqbwalk();
}

reenable_stealth() {
  wait 1;

  if(common_scripts\utility::flag("_stealth_enabled")) {
    return;
  }
  level.dog setdogattackradius(128);
  thread maps\_stealth_utility::enable_stealth_system();
}

btr_stop_when_not_normal() {
  self endon("death");
  btr_mg_off();

  for(;;) {
    while(maps\_stealth_utility::stealth_is_everything_normal())
      wait 0.05;

    self vehicle_setspeed(0, 10, 10);
    wait_till_every_thing_stealth_normal_for(0.5);
    self resumespeed(0.5);
  }
}

btr_mg_off() {
  foreach(var_1 in self.mgturret)
  var_1 notify("stop_burst_fire_unmanned");
}

stealth_is_everything_normal_for_group(var_0) {
  var_1 = maps\_stealth_shared_utilities::group_get_ai_in_group(var_0);

  foreach(var_3 in var_1) {
    if(!var_3 maps\_utility::ent_flag("_stealth_normal"))
      return 0;
  }

  return 1;
}

dog_footstep_logic() {
  level.player endon("stop_dog_drive");
  level.dog endon("death");
  thread keep_dog_threat();

  for(;;) {
    var_0 = length(level.player getnormalizedmovement());

    if(!isDefined(level.dog.sprint))
      level.dog.sprint = 0;

    if(level.dog isdogbeingdriven() && var_0 > 0) {
      var_1 = level._stealth.logic.detect_range["hidden"]["prone"];

      if(level.dog.sprint)
        var_1 = level._stealth.logic.detect_range["hidden"]["crouch"];
      else {
        var_1 = 64;
        var_1 = var_0 * var_0 * var_1;
      }

      var_2 = 32;
      var_1 = max(var_2, var_1);
      var_3 = getaiarray("axis");
      var_3 = sortbydistance(var_3, level.dog.origin);

      foreach(var_5 in var_3) {
        if(isDefined(var_5._stealth) && distance(level.dog.origin, var_5.origin) < var_1) {
          var_5 maps\_stealth_visibility_enemy::enemy_event_awareness_notify("dog_bark", level.dog);
          continue;
        }

        break;
      }
    }

    common_scripts\utility::waitframe();
  }
}

keep_dog_threat() {
  level.player endon("stop_dog_drive");
  level.dog endon("death");

  for(;;) {
    if(level.dog.ignoreme)
      level.dog.ignoreme = 0;

    common_scripts\utility::waitframe();
  }
}

player_set_spotted() {
  thread player_set_spotted_internal();
}

player_set_spotted_internal() {
  common_scripts\utility::flag_set("_stealth_spotted");
  var_0 = level.player maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
  common_scripts\utility::flag_set(var_0);
}