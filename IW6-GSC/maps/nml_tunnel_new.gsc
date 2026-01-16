/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nml_tunnel_new.gsc
*****************************************************/

tunnel_new() {
  level.dog endon("death");
  thread fire_flicker();
  thread tunnel_dialogue();
  thread tunnel_spotted();
  maps\nml_util::team_unset_colors(128);
  level.dog maps\nml_util::set_move_rate(0.55);
  level.baker.goalradius = 192;
  level.baker.ignoreall = 1;
  level.baker maps\_utility::enable_cqbwalk();
  maps\nml_util::hero_paths("tunnel_enter_path", 300, 300, 200, 0, 1);
  common_scripts\utility::flag_wait("start_tunnel_btrs");
  var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("tunnel_btrs");
  var_0[0] thread maps\_utility::play_sound_on_entity("scn_nml_btr_end_of_tunnel_start");
  thread tunnel_vehix_sounds(var_0);
  maps\nml_util::hero_paths("tunnel_path_hide", 300, 200, 150, 0, 1);
  level.baker maps\_utility::disable_cqbwalk();
  level.dog maps\nml_util::set_move_rate(0.8);
  wait 1.2;
  level.baker thread maps\_utility::smart_dialogue("nml_hsh_vehiclesincomingshift");
  level.baker waittill("goal");
  level.baker allowedstances("crouch");
  level.baker thread maps\_utility::smart_dialogue("nml_hsh_easyeasyletthem");
  common_scripts\utility::flag_wait("tunnel_btr3_out");
  level.baker maps\_utility::enable_cqbwalk();
  level.baker allowedstances("stand", "crouch", "prone");
  maps\nml_util::hero_paths("tunnel_exit_path", 300, 300, 200, 0, 0.5);
  common_scripts\utility::flag_wait("tunnel_exit");
  common_scripts\utility::flag_wait("tunnel_exit_clear");

  while(isDefined(level.dog.teleported) && level.dog.teleported)
    wait 0.05;

  maps\nml_util::hero_paths("tunnel_exit_path", 300, 300, 200, 0, 1);
  wait 1;
  common_scripts\utility::flag_wait("tunnel_player_at_exit");
  level.dog maps\_utility_dogs::disable_dog_sneak();
  level.dog maps\nml_util::set_move_rate(0.6);
  maps\nml_util::hero_paths("mall_start_path", 300, 300, 200, 0, 1);
}

tunnel_dialogue() {
  level endon("start_mall");
  wait 3;
  level.baker maps\_utility::smart_dialogue("nml_hsh_tracksarefresh");
  wait 2;
  level.baker thread maps\_utility::smart_dialogue("nml_hsh_looksliketheywent");
  maps\_utility::music_play("mus_nml_tunnel");
  common_scripts\utility::flag_wait("start_tunnel_btrs");
  common_scripts\utility::flag_wait("tunnel_exit");
  common_scripts\utility::flag_wait("tunnel_exit_clear");
  level.baker thread maps\_utility::smart_dialogue("nml_hsh_perfect");
}

tunnel_spotted() {
  level endon("start_mall");
  thread tunnel_instant_spotted();
  common_scripts\utility::flag_wait("_stealth_spotted");
  thread tunnel_spotted_kill();
}

tunnel_instant_spotted() {
  level.player endon("death");
  level.dog endon("death");
  level endon("start_dog_hunt");
  maps\nml_code::instant_spotted();
}

tunnel_spotted_kill() {
  level.cansave = 0;
  level.baker maps\_utility::delaythread(1.5, maps\_utility::smart_dialogue, "nml_hsh_werespottedtakeem");
  level.player enablehealthshield(0);
  var_0 = maps\_utility::getvehiclearray();

  foreach(var_2 in var_0) {
    var_2 vehicle_setspeed(0, 10, 10);
    var_2 maps\_utility::delaythread(1, maps\_vehicle::vehicle_unload, "all");
  }

  thread tunnel_kill_dog();
}

tunnel_kill_dog() {
  level.dog endon("death");
  level.player endon("death");
  thread maps\nml_util::mission_fail_on_dog_death(&"NML_HINT_CAIRO_DEATH");
  wait 9;
  level.dog kill();
}

tunnel_vehicle_think() {
  self endon("death");
  self endon("cancel_spotted_reaction");
  childthread veh_see_player_logic();
  self vehicle_turnengineoff();

  switch (self.model) {
    case "vehicle_btr80":
      thread maps\nml_util::btr_attack_player_on_flag("_stealth_spotted");
      thread dlight_on_me("TAG_FRONT_LIGHT_RIGHT");
      break;
    case "vehicle_iveco_lynx_iw6":
      thread dlight_on_me("TAG_HEADLIGHT_RIGHT");
      break;
    case "vehicle_m800_apc":
      thread dlight_on_me("TAG_TURRET");
      thread maps\nml_util::btr_attack_player_on_flag("_stealth_spotted");
      break;
  }

  thread btr_check_player_fire();

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      maps\nml_stealth::player_set_spotted();
      break;
    }
  }
}

btr_check_player_fire() {
  self endon("death");

  for(;;) {
    level.player waittill("weapon_fired");

    if(distance(level.player.origin, self.origin) < 300) {
      maps\nml_stealth::player_set_spotted();
      break;
    }

    common_scripts\utility::waitframe();
  }
}

tunnel_vehix_sounds(var_0) {
  var_0 = sortbydistance(var_0, level.player.origin);
  var_1 = ["scn_nml_hummer1_passby", "scn_nml_truck1_passby", "scn_nml_truck2_passby"];

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    var_0[var_2] thread maps\_utility::play_sound_on_entity(var_1[var_2]);

  var_3 = ["scn_nml_hummer1_tires", "scn_nml_truck1_tires", "scn_nml_truck2_tires"];
  var_4 = ["scn_nml_jeep_stop", "scn_nml_btr1_stop", "scn_nml_btr2_stop"];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2] thread common_scripts\utility::play_loop_sound_on_entity(var_3[var_2]);
    var_0[var_2] thread tunnel_vehix_stop_sounds(var_3[var_2], var_4[var_2]);
  }
}

tunnel_vehix_stop_sounds(var_0, var_1) {
  thread btr_stopping_sounds(var_1);
  self waittill("reached_end_node");
  common_scripts\utility::stop_loop_sound_on_entity(var_0);
}

btr_stopping_sounds(var_0) {
  self endon("death");
  level endon("_stealth_spotted");

  while(self vehicle_getspeed() < 4)
    common_scripts\utility::waitframe();

  while(self vehicle_getspeed() > 4)
    common_scripts\utility::waitframe();

  thread maps\_utility::play_sound_on_entity(var_0);
}

veh_see_player_logic() {
  level endon("_stealth_spotted");
  self endon("death");

  for(;;) {
    if(!level.player maps\_utility::ent_flag("_stealth_in_shadow")) {
      if(distance2d(level.player.origin, self.origin) < 500) {
        var_0 = 0.5;
        var_1 = self.origin;
        var_2 = level.player.origin;
        var_3 = vectornormalize(var_2 - var_1);
        var_4 = anglesToForward(self.angles);
        var_5 = vectordot(var_3, var_4);

        if(var_5 >= var_0) {
          break;
        }
      }
    }

    wait 0.05;
  }

  maps\nml_stealth::player_set_spotted();
}

dlight_on_me(var_0) {
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = self gettagorigin(var_0);
  var_1.angles = self gettagangles(var_0);
  self.dlight_org = var_1;
  self.dlight_org.tag = var_0;
  var_2 = anglesToForward(var_1.angles);
  var_1.origin = var_1.origin + var_2 * 350;
  var_1 linkto(self);
  playFXOnTag(common_scripts\utility::getfx("btr_light_fadein"), var_1, "tag_origin");
  wait 3;
  stopFXOnTag(common_scripts\utility::getfx("btr_light_fadein"), var_1, "tag_origin");
  playFXOnTag(common_scripts\utility::getfx("btr_light"), var_1, "tag_origin");
  self waittill("death");
  var_1 delete();
}

tunnel_guys_exit_think() {
  self.dog_attack_alt_func = ::dog_attack_tunnel_sniper;
  thread maps\_utility::flag_on_death("tunnel_exit_clear");
}

dog_attack_tunnel_sniper(var_0) {
  self.teleported = 0;
  var_0 setthreatbiasgroup("dog_targets");
  maps\_utility_dogs::disable_dog_sneak();
  self hudoutlinedisable();
  var_1 = common_scripts\utility::get_target_ent("tunnel_exit_dog_teleport");
  var_2 = var_1 common_scripts\utility::get_target_ent();
  thread dog_return_to_sender(var_0, var_1, var_2);
  maps\nml_util::set_move_rate(1.3);
  thread maps\_utility::play_sound_on_entity("anml_dog_growl");
  self.goalradius = 64;
  self setgoalpos(var_1.origin);
  self waittill("goal");
  self.teleported = 1;
  self forceteleport(var_2.origin, var_2.angles);
  self.ignoreall = 0;
  self setgoalentity(var_0);
  var_0 waittill("dog_attacks_ai");
  maps\_utility::set_hudoutline("friendly", 0);
  var_0 waittill("death");
  self waittill("back_on_ground");
}

dog_return_to_sender(var_0, var_1, var_2) {
  var_0 waittill("death");

  if(self.teleported) {
    self setgoalpos(var_2.origin);
    self waittill("goal");
  }

  self hudoutlinedisable();
  self forceteleport(var_1.origin, var_1.angles);
  self.teleported = undefined;
  self notify("back_on_ground");
}

fire_flicker() {
  var_0 = getEntArray("burning_trash_fire", "targetname");
  common_scripts\utility::array_thread(var_0, ::flicker, "start_dog_hunt");
}

flicker(var_0) {
  wait 0.1;

  if(!isDefined(self.script_maxdist))
    self.script_maxdist = 20;

  var_1 = self getlightintensity();

  if(var_1 <= 0) {
    return;
  }
  thread flickering_light(self, var_1 * 0.6, var_1);
  thread moving_light(self, self.script_maxdist);
}

flickering_light(var_0, var_1, var_2) {
  level endon("level_cleanup");
  var_0 endon("stop_flicker");
  var_0.linked_models = [];
  var_0.has_model = 0;

  if(isDefined(var_0.script_linkto)) {
    var_3 = var_0 common_scripts\utility::get_linked_ents();
    var_0.on_models = [];
    var_0.off_models = [];

    foreach(var_5 in var_3) {
      if(var_5.script_noteworthy == "off") {
        var_0.off_models = common_scripts\utility::array_add(var_0.off_models, var_5);
        continue;
      }

      var_0.on_models = common_scripts\utility::array_add(var_0.on_models, var_5);
    }

    foreach(var_8 in var_0.on_models) {
      if(isDefined(var_8.script_linkto)) {
        var_9 = var_8 common_scripts\utility::get_linked_ent();
        var_8.effect = common_scripts\utility::createoneshoteffect(var_9.script_fxid);
        var_8.effect.v["origin"] = var_9.origin;
        var_8.effect.v["angles"] = var_9.angles;
      }
    }

    var_0.has_model = 1;
  }

  for(;;) {
    var_11 = randomfloatrange(var_1, var_2);
    var_0 setlightintensity(var_11);
    wait(randomfloatrange(0.1, 0.2));
  }
}

moving_light(var_0, var_1) {
  level endon("level_cleanup");
  var_0 endon("stop_movement");
  var_2 = var_0.origin;

  for(;;) {
    var_3 = 0.05 + randomint(4) / 10;
    var_0 moveto(var_2 - (randomint(var_1), randomint(var_1), randomint(var_1)), var_3);
    wait(var_3);
  }
}