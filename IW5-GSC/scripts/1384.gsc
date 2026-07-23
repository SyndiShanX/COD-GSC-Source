/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1384.gsc
**************************************/

flags_init() {
  level._effect["lighthaze_snow_headlights"] = loadfx("misc/lighthaze_snow_headlights");
  level._effect["car_taillight_uaz_l"] = loadfx("misc/car_taillight_uaz_l");
  common_scripts\utility::flag_init("truck_guys_alerted");
  common_scripts\utility::flag_init("jeep_blown_up");
  common_scripts\utility::flag_init("jeep_stopped");
}

increase_fov_when_player_is_near() {
  self endon("death");
  self endon("enemy");

  for(;;) {
    if(player_is_near()) {
      self.fovcosine = 0.01;
      return;
    }

    wait 0.5;
  }
}

player_is_near() {
  foreach(var_1 in level.players) {
    if(distancesquared(self.origin, var_1.origin) < squared(self.footstepdetectdistsprint)) {
      return 1;
    }
  }

  return 0;
}

stealth_truck_think() {
  thread base_truck_think();
  thread truck_headlights();
  self waittill("death");
  common_scripts\utility::flag_set("jeep_blown_up");
}

base_truck_guys_think() {
  self endon("death");
  level endon("_stealth_spotted");
  self endon("_stealth_attack");
  maps\_utility::ent_flag_init("jumped_out");
  thread truck_guys_think_jumpout();
  var_0 = [];
  var_0["saw"] = ::truck_guys_reaction_behavior;
  var_0["found"] = ::truck_guys_reaction_behavior;
  var_1 = [];
  var_1["warning1"] = ::truck_guys_reaction_behavior;
  var_1["warning2"] = ::truck_guys_reaction_behavior;
  var_1["attack"] = ::truck_alert_level_attack;
  var_2 = [];
  var_2["explode"] = ::truck_guys_no_enemy_reaction_behavior;
  var_2["heard_scream"] = ::truck_guys_no_enemy_reaction_behavior;
  var_2["doFlashBanged"] = ::truck_guys_no_enemy_reaction_behavior;
  maps\_stealth_shared_utilities::ai_create_behavior_function("animation", "wrapper", ::truck_animation_wrapper);
  maps\_stealth_utility::stealth_threat_behavior_custom(var_1);
  maps\_stealth_utility::stealth_corpse_behavior_custom(var_0);

  foreach(var_5, var_4 in var_2) {}
  maps/_stealth_event_enemy::stealth_event_mod(var_5, var_4);

  maps\_utility::ent_flag_set("_stealth_behavior_reaction_anim");
}

truck_guys_base_search_behavior(var_0) {
  self endon("_stealth_enemy_alert_level_change");
  level endon("_stealth_spotted");
  self endon("_stealth_attack");
  self endon("death");
  self endon("pain_death");
  thread base_truck_guys_attacked_again();
  self.disablearrivals = 0;
  self.disableexits = 0;
  var_1 = distance(var_0.origin, self.origin);
  self setgoalnode(var_0);
  self.goalradius = var_1 * 0.5;
  wait 0.05;
  maps\_utility::set_generic_run_anim("_stealth_patrol_cqb");
  self waittill("goal");

  if(!common_scripts\utility::flag("_stealth_spotted") && (!isDefined(self.enemy) || !self cansee(self.enemy))) {
    set_search_walk();
    maps\_stealth_shared_utilities::enemy_runto_and_lookaround(var_0);
  }
}

base_truck_guys_attacked_again() {
  self endon("death");
  self endon("_stealth_attack");
  level endon("_stealth_spotted");
  wait 2;
  self waittill("_stealth_bad_event_listener");
  maps\_stealth_shared_utilities::enemy_reaction_state_alert();
  maps\_utility::ent_flag_set("not_first_attack");
}

set_search_walk() {
  maps\_utility::disable_cqbwalk();
  maps\_utility::set_generic_run_anim("patrol_cold_gunup_search", 1);
  self.disablearrivals = 1;
  self.disableexits = 1;
}

truck_guys_think_jumpout() {
  self endon("death");
  self endon("pain_death");

  for(;;) {
    self waittill("jumpedout");
    maps\_stealth_shared_utilities::enemy_set_original_goal(self.origin);
    self.got_off_truck_origin = self.origin;
    maps\_utility::ent_flag_set("jumped_out");
    self waittill("enteredvehicle");
    wait 0.15;
    maps\_utility::ent_flag_clear("jumped_out");
    maps\_utility::ent_flag_set("_stealth_behavior_reaction_anim");
  }
}

truck_animation_wrapper(var_0) {
  self endon("death");
  self endon("pain_death");
  common_scripts\utility::flag_set("truck_guys_alerted");
  maps\_utility::ent_flag_wait("jumped_out");
  maps\_stealth_shared_utilities::enemy_animation_wrapper(var_0);
}

truck_guys_reaction_behavior(var_0) {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_spotted");
  self endon("_stealth_attack");
  common_scripts\utility::flag_set("truck_guys_alerted");
  maps\_utility::ent_flag_wait("jumped_out");

  if(!common_scripts\utility::flag("truck_guys_alerted")) {
    return;
  }
  if(common_scripts\utility::flag_exist("truck_guys_not_going_back") && common_scripts\utility::flag("truck_guys_not_going_back")) {
    return;
  }
  if(!common_scripts\utility::flag("_stealth_spotted") && !maps\_utility::ent_flag("_stealth_attack")) {
    var_1 = maps\_utility::get_closest_player(self.origin);
    var_2 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(var_1.origin, 1500, 128);

    if(isDefined(var_2)) {
      thread truck_guys_base_search_behavior(var_2);
    }
  }

  var_3 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");

  if(common_scripts\utility::flag(var_3)) {
    common_scripts\utility::flag_waitopen(var_3);
  } else {
    self waittill("normal");
  }
}

truck_guys_no_enemy_reaction_behavior(var_0) {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_spotted");
  self endon("_stealth_attack");
  common_scripts\utility::flag_set("truck_guys_alerted");
  maps\_utility::ent_flag_wait("jumped_out");

  if(!common_scripts\utility::flag("truck_guys_alerted")) {
    return;
  }
  if(common_scripts\utility::flag_exist("truck_guys_not_going_back") && common_scripts\utility::flag("truck_guys_not_going_back")) {
    return;
  }
  if(!common_scripts\utility::flag("_stealth_spotted") && !maps\_utility::ent_flag("_stealth_attack")) {
    var_1 = self._stealth.logic.event.awareness_param[var_0];
    var_2 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(var_1, 300, 40);
    thread maps\_stealth_shared_utilities::enemy_announce_wtf();

    if(isDefined(var_2)) {
      thread truck_guys_base_search_behavior(var_2);
    }
  }

  var_3 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");

  if(common_scripts\utility::flag(var_3)) {
    common_scripts\utility::flag_waitopen(var_3);
  } else {
    self waittill("normal");
  }
}

truck_alert_level_attack(var_0) {
  self endon("death");
  self endon("pain_death");
  common_scripts\utility::flag_set("truck_guys_alerted");
  maps\_utility::ent_flag_wait("jumped_out");
}

set_alert_cold_patrol_anims() {
  self.patrol_walk_anim = "patrol_cold_gunup";
  self.patrol_walk_twitch = "patrol_gunup_twitch_weights";
}

wait_reaction_time() {
  var_0 = distance(self.origin, maps\_utility::get_closest_player(self.origin).origin);
  var_1 = (var_0 - 200) / 1000;
  var_1 = clamp(var_1, 0, 0.5);
  wait(var_1);
}

base_truck_think() {
  self endon("death");
  thread dialog_truck_coming();
  thread dialog_jeep_stopped();
  thread unload_and_attack_if_stealth_broken_and_close();
  common_scripts\utility::flag_wait("truck_guys_alerted");
  var_0 = maps\_utility::get_living_ai_array("truck_guys", "script_noteworthy");

  if(var_0.size == 0) {
    self vehicle_setspeed(0, 15);
    return;
  }

  var_1 = common_scripts\utility::random(var_0);
  var_1 maps\_stealth_shared_utilities::enemy_announce_wtf();
  self waittill("safe_to_unload");
  self vehicle_setspeed(0, 15);
  wait 1;
  maps\_vehicle::vehicle_unload();
  common_scripts\utility::flag_set("jeep_stopped");
}

unload_and_attack_if_stealth_broken_and_close() {
  self endon("truck_guys_alerted");

  for(;;) {
    common_scripts\utility::flag_wait("_stealth_spotted");

    foreach(var_1 in level.players) {}
    thread waittill_player_in_range(var_1);

    self waittill("player_in_range");

    if(!common_scripts\utility::flag("_stealth_spotted")) {
      continue;
    } else {
      break;
    }
  }

  common_scripts\utility::flag_set("truck_guys_alerted");
}

waittill_player_in_range(var_0) {
  self endon("player_in_range");
  var_0 maps\_utility::waittill_entity_in_range(self, 800);
  self notify("player_in_range");
}

truck_headlights() {
  playFXOnTag(level._effect["lighthaze_snow_headlights"], self, "TAG_LIGHT_RIGHT_FRONT");
  playFXOnTag(level._effect["lighthaze_snow_headlights"], self, "TAG_LIGHT_LEFT_FRONT");
  playFXOnTag(level._effect["car_taillight_uaz_l"], self, "TAG_LIGHT_LEFT_TAIL");
  playFXOnTag(level._effect["car_taillight_uaz_l"], self, "TAG_LIGHT_RIGHT_TAIL");
  self waittill("death");

  if(isDefined(self)) {
    delete_truck_headlights();
  }
}

delete_truck_headlights() {
  stopFXOnTag(level._effect["lighthaze_snow_headlights"], self, "TAG_LIGHT_RIGHT_FRONT");
  stopFXOnTag(level._effect["lighthaze_snow_headlights"], self, "TAG_LIGHT_LEFT_FRONT");
  stopFXOnTag(level._effect["car_taillight_uaz_l"], self, "TAG_LIGHT_LEFT_TAIL");
  stopFXOnTag(level._effect["car_taillight_uaz_l"], self, "TAG_LIGHT_RIGHT_TAIL");
}

dialog_truck_coming() {
  level endon("special_op_terminated");
  level endon("jeep_stopped");
  level endon("jeep_blown_up");
  var_0 = 1;

  for(;;) {
    waittill_player_in_truck_range();
    var_1 = maps\_utility::within_fov(self.origin, self.angles, self.close_player.origin, cos(45));

    if(var_1) {
      if(!var_0 && common_scripts\utility::cointoss()) {
        maps\_utility::radio_dialogue("cliff_pri_truckcomingback");
      } else {
        maps\_utility::radio_dialogue("cliff_pri_truckiscoming");
      }
      var_0 = 0;
      wait 10;
    }

    wait 1;
  }
}

waittill_player_in_truck_range() {
  self.close_player = undefined;

  foreach(var_1 in level.players) {}
  var_1 thread watch_for_truck(self);

  level waittill("player_in_truck_range");
}

watch_for_truck(var_0) {
  level endon("player_in_truck_range");
  var_0 maps\_utility::waittill_entity_in_range(self, 1200);
  var_0.close_player = self;
  level notify("player_in_truck_range");
}

dialog_jeep_stopped() {
  level endon("special_op_terminated");
  self waittill("unloading");

  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  maps\_utility::radio_dialogue("cliff_pri_headsup");

  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  maps\_utility::radio_dialogue("cliff_pri_lookingaround");
}