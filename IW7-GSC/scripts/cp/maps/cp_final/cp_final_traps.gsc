/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_traps.gsc
*******************************************************/

register_traps() {
  level.trapcooldownarray = [];
  level.interaction_hintstrings["laser_trap"] = &"CP_FINAL_INTERACTIONS_LASER_TRAP";
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(0, "laser_trap", "trap", undefined, undefined, ::use_lasers_trap, 750, 1, ::lasers_trap_init);
  level.interaction_hintstrings["blackhole_trap"] = &"CP_FINAL_INTERACTIONS_MOVIE_WORMHOLE";
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(0, "blackhole_trap", "trap", undefined, undefined, ::use_blackhole_trap, 1250, 1, ::init_blackhole_trap);
  level.interaction_hintstrings["fridge_trap"] = &"CP_FINAL_INTERACTIONS_FRIDGE_TRAP";
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(0, "fridge_trap", "trap", undefined, undefined, ::use_fridge_trap, 750, 1, ::fridge_trap_init);
  level.interaction_hintstrings["electric_trap"] = &"CP_FINAL_INTERACTIONS_ELECTROCUTION_TRAP";
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(0, "electric_trap", "trap", undefined, undefined, ::electric_trap_use, 750, 1, ::electric_trap_init);
  level.interaction_hintstrings["acid_rain_trap"] = &"CP_FINAL_INTERACTIONS_RAINING_ACID";
  scripts\cp\maps\cp_final\cp_final_interactions::levelinteractionregistration(0, "acid_rain_trap", "trap", undefined, undefined, ::use_rain_trap, 750, 1, ::init_rain_trap);
  level thread watch_for_trap_kills_obtained();
}

watch_for_trap_kills_obtained() {
  level endon("achievement_given");
  level.trap_kills_laser = 0;
  level.trap_kills_blackhole = 0;
  level.trap_kills_fridge = 0;
  level.trap_kills_electric = 0;
  level.trap_kills_acidrain = 0;
  for(;;) {
    if(scripts\engine\utility::istrue(level.trap_kills_laser) && scripts\engine\utility::istrue(level.trap_kills_blackhole) && scripts\engine\utility::istrue(level.trap_kills_fridge) && scripts\engine\utility::istrue(level.trap_kills_electric) && scripts\engine\utility::istrue(level.trap_kills_acidrain)) {
      foreach(var_1 in level.players) {
        var_1 scripts\cp\zombies\achievement::update_achievement("FAILED_MAINTENANCE", 1);
      }

      level notify("achievement_given");
    }

    wait(1);
  }
}

cp_final_should_be_affected_by_trap(var_0, var_1, var_2) {
  if(isDefined(var_0.agent_type) && var_0.agent_type == "slasher") {
    return 0;
  }

  if(!scripts\cp\utility::should_be_affected_by_trap(var_0, var_1, var_2)) {
    return 0;
  }

  if(var_0.team == "allies") {
    return 0;
  }

  return 1;
}

force_panels_powered_on() {
  var_0 = scripts\engine\utility::getstructarray("laser_trap", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.powered_on = 1;
  }

  var_4 = scripts\engine\utility::getstructarray("blackhole_trap", "script_noteworthy");
  foreach(var_2 in var_4) {
    var_2.powered_on = 1;
  }

  var_7 = scripts\engine\utility::getstructarray("acid_rain_trap", "script_noteworthy");
  foreach(var_2 in var_7) {
    var_2.powered_on = 1;
  }

  var_10 = scripts\engine\utility::getstruct("fridge_trap", "script_noteworthy");
  var_10.powered_on = 1;
  var_11 = scripts\engine\utility::getstruct("electric_trap", "script_noteworthy");
  var_11.powered_on = 1;
}

lasers_trap_init() {
  level.trapcooldownarray["laser_trap"] = 0;
  level.lasertriggers = [];
  var_0 = scripts\engine\utility::getstructarray("laser_trap", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.powered_on = 0;
    var_2 thread listen_for_power();
  }

  var_4 = getEntArray("trap_lasers", "script_noteworthy");
  foreach(var_6 in var_4) {
    foreach(var_8 in var_4) {
      if(var_6 == var_8) {
        continue;
      }

      var_9 = getent(var_6.target, "targetname");
      if(scripts\engine\utility::array_contains(level.lasertriggers, var_9)) {
        continue;
      }

      var_10 = scripts\engine\utility::get_array_of_closest(var_6.origin, var_4, [var_6], 1, 48, 0)[0];
      if(isDefined(var_10) && scripts\engine\utility::array_contains(level.lasertriggers, var_10)) {
        continue;
      }

      if(isDefined(var_10) && var_10.origin[2] < var_6.origin[2]) {
        continue;
      }

      var_10 = scripts\engine\utility::get_array_of_closest(var_9.origin, var_4, [var_9], 1, 48, 0)[0];
      if(isDefined(var_10) && scripts\engine\utility::array_contains(level.lasertriggers, var_10)) {
        continue;
      }

      if(isDefined(var_10) && var_10.origin[2] < var_9.origin[2]) {
        continue;
      }

      var_6.name = "use_laser_trigger";
    }
  }
}

power_on_lasers(var_0) {
  var_1 = getent(self.target, "targetname");
  if(!isDefined(self.activated)) {
    var_1.activated = 1;
  } else if(scripts\engine\utility::istrue(self.activated)) {
    return;
  }

  thread create_laser_beam_fx(self, var_1, var_0);
}

laser_sound_individual() {
  self playSound("zmb_trap_laser_start");
  thread scripts\engine\utility::play_loop_sound_on_entity("zmb_trap_laser_lp", (0, 0, 0));
  level waittill("lasers_end");
  thread scripts\engine\utility::stop_loop_sound_on_entity("zmb_trap_laser_lp");
  self playSound("zmb_trap_laser_end");
}

create_laser_beam_fx(var_0, var_1, var_2) {
  var_3 = var_0;
  var_4 = var_1;
  var_3 linkto(var_4);
  scripts\engine\utility::waitframe();
  if(!isDefined(self)) {
    var_3 delete();
    var_4 delete();
    return;
  }

  var_5 = randomfloat(1);
  thread laser_sound_individual();
  if(var_5 > 0.5) {
    var_6 = playfxontagsbetweenclients(scripts\engine\utility::getfx("trap_ww_beam"), var_3, "tag_origin", var_4, "tag_origin");
  } else {
    var_6 = playfxontagsbetweenclients(scripts\engine\utility::getfx("trap_ww_beam"), var_5, "tag_origin", var_4, "tag_origin");
  }

  var_6.var_336 = "laser_beam_effect";
  thread func_403A(var_6);
  var_5 = randomfloat(1);
  if(var_5 > 0.5) {
    var_7 = playFXOnTag(scripts\engine\utility::getfx("vfx_zb_laser_lens"), var_3, "tag_origin");
    thread kill_fx_cleanup(scripts\engine\utility::getfx("vfx_zb_laser_lens"), var_3, "tag_origin");
  } else {
    var_7 = playFXOnTag(scripts\engine\utility::getfx("vfx_zb_laser_lens"), var_5, "tag_origin");
    thread kill_fx_cleanup(scripts\engine\utility::getfx("vfx_zb_laser_lens"), var_4, "tag_origin");
  }

  var_8 = undefined;
  if(isDefined(self.script_noteworthy) && self.script_noteworthy != "trap_lasers_no_trig") {
    if(isDefined(self.name) && self.name == "use_laser_trigger") {
      var_9 = distance(var_3.origin, var_4.origin);
      var_8 = spawn("trigger_rotatable_radius", var_3.origin, 0, 2, var_9);
      var_8.angles = vectortoangles(var_4.origin - var_3.origin) + (90, 0, 0);
      var_8.owner = var_2;
      thread damage_enemies_in_trigger(var_4, var_3, var_8);
      level thread func_403A(var_8);
    }
  }

  level thread updatefxlaserjoined();
  level thread updatefxlaserdisconnected();
  level thread movelaser(var_4, var_8);
}

movelaser(var_0, var_1) {
  level endon("lasers_end");
  if(isDefined(var_1)) {
    var_1 enablelinkto();
    var_1 linkto(var_0);
  }

  for(;;) {
    if(var_0.origin[2] < 100) {
      var_0 moveto(var_0.origin + (0, 0, 60), 1, 0.15, 0.15);
      var_0 waittill("movedone");
    }

    var_0 moveto(var_0.origin - (0, 0, 60), 1, 0.15, 0.15);
    var_0 waittill("movedone");
  }
}

kill_fx_cleanup(var_0, var_1, var_2) {
  level endon("game_ended");
  level waittill("lasers_end");
  killfxontag(var_0, var_1, var_2);
}

func_403A(var_0) {
  level endon("game_ended");
  level waittill("lasers_end");
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

laser_eye_fx() {
  self endon("disconnect");
  var_0 = spawnfxforclient(level._effect["vfx_zb_laser_screen"], self getEye(), self);
  wait(0.1);
  triggerfx(var_0);
  scripts\engine\utility::waittill_any_timeout(2, "last_stand");
  var_0 delete();
}

damage_enemies_in_trigger(var_0, var_1, var_2, var_3) {
  level endon("lasers_end");
  self endon("death");
  var_2 endon("death");
  var_0 endon("death");
  var_1 endon("death");
  for(;;) {
    var_2 waittill("trigger", var_4);
    if(!isDefined(var_4)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(isPlayer(var_4)) {
      if(var_4 scripts\cp\utility::is_valid_player()) {
        if(!isDefined(var_4.padding_damage)) {
          var_5 = var_4 getEye()[2] + 4;
          var_6 = var_4 gettagorigin("j_ball_ri")[2] - 2;
          var_7 = var_2.origin[2];
          if(!scripts\engine\utility::istrue(var_3) && var_5 < var_7 || var_6 > var_7) {
            scripts\engine\utility::waitframe();
            continue;
          }

          thread kill_fx_on_death(var_0, var_1);
          playsoundatpos(var_4.origin, "trap_electric_shock");
          var_4 thread laser_eye_fx();
          var_4.padding_damage = 1;
          var_4 dodamage(70, var_2.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_lasertrap_zm");
          var_4 thread remove_padding_damage();
          scripts\engine\utility::waitframe();
          continue;
        }
      }

      scripts\engine\utility::waitframe();
      continue;
    } else {
      if(var_4 is_cryptid()) {
        if(var_4.agent_type != "alien_goon") {
          scripts\engine\utility::waitframe();
          continue;
        }
      }

      thread kill_fx_on_death(var_0, var_1);
      thread run_laser_death(var_4, var_2.owner);
      scripts\engine\utility::waitframe();
    }
  }
}

remove_padding_damage() {
  self endon("disconnect");
  wait(0.5);
  if(isDefined(self)) {
    self.padding_damage = undefined;
  }
}

kill_fx_on_death(var_0, var_1) {
  level endon("game_ended");
  var_2 = playfxontagsbetweenclients(scripts\engine\utility::getfx("trap_ww_beam_death"), var_0, "tag_origin", var_1, "tag_origin");
  var_2.var_336 = "laser_beam_kill_effect";
  thread func_403A(var_2);
}

run_laser_death(var_0, var_1) {
  var_0 endon("death");
  var_0.marked_for_death = 1;
  var_0.atomize_me = 1;
  var_0.not_killed_by_headshot = 1;
  if(!scripts\engine\utility::istrue(level.trap_kills_laser)) {
    level.trap_kills_laser = 1;
  }

  if(isDefined(var_1)) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("lasertrap_killfirm", "zmb_comment_vo");
    var_0 dodamage(var_0.health, var_0.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_lasertrap_zm");
    return;
  }

  var_0 dodamage(var_0.health, var_0.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_lasertrap_zm");
}

updatefxlaserjoined() {}

updatefxlaserdisconnected() {}

use_lasers_trap(var_0, var_1) {
  level.trapcooldownarray["laser_trap"]++;
  var_2 = isDefined(var_1) && isPlayer(var_1);
  var_3 = scripts\engine\utility::getstructarray("laser_trap", "script_noteworthy");
  foreach(var_5 in var_3) {
    var_6 = getent(var_5.target, "targetname");
    var_6 setModel("mp_frag_button_on");
  }

  activate_trap_feedback(var_1);
  playFX(level._effect["console_spark"], var_0.origin + (0, 0, 40));
  foreach(var_0 in var_3) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  }

  if(var_2) {
    if(scripts\engine\utility::cointoss()) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo");
    } else {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("lasertrap_activated", "zmb_comment_vo");
    }
  }

  var_10 = scripts\engine\utility::array_combine(getEntArray("trap_lasers", "script_noteworthy"), getEntArray("trap_lasers_no_trig", "script_noteworthy"));
  foreach(var_12 in var_10) {
    var_12.triggerent = undefined;
    var_12 power_on_lasers(var_1);
  }

  wait(23);
  level notify("lasers_end");
  if(isDefined(var_1) && isPlayer(var_1)) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("lasertrap_deactiveated", "zmb_comment_vo");
  }

  var_14 = int(90 * level.trapcooldownarray["laser_trap"]);
  foreach(var_0 in var_3) {
    level thread scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    level thread scripts\cp\cp_interaction::interaction_cooldown(var_0, var_14);
  }

  wait(var_14);
  foreach(var_5 in var_3) {
    var_6 = getent(var_5.target, "targetname");
    var_6 setModel("mp_frag_button_on_green");
  }
}

init_blackhole_trap() {
  level.trapcooldownarray["blackhole_trap"] = 0;
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = scripts\engine\utility::getstructarray("blackhole_trap", "script_noteworthy");
  foreach(var_5 in var_3) {
    var_5.powered_on = 0;
    var_5 thread listen_for_power();
    var_5.body = getent(var_5.target, "targetname");
    var_6 = scripts\engine\utility::getstructarray(var_5.target, "targetname");
    foreach(var_8 in var_6) {
      if(isDefined(var_8.fgetarg)) {
        var_5.var_2B32 = var_8;
        continue;
      }

      var_5.var_2B30 = var_8;
    }

    var_5.var_2B37 = spawn("trigger_radius", var_5.var_2B32.origin, 0, var_5.var_2B32.fgetarg, 96);
  }

  scripts\engine\utility::flag_init("screen_trap_active");
  level thread watch_for_obtain_helmet();
}

func_2B36() {
  var_0 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  for(;;) {
    var_1 = "power_on";
    if(var_0) {
      var_1 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
      if(var_1 != "power_off") {
        self.powered_on = 1;
      } else {
        self.powered_on = 0;
      }
    }

    if(!var_0) {
      break;
    }

    wait(0.25);
  }
}

watch_for_obtain_helmet() {
  var_0 = getent("movie_screen_hole", "targetname");
  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4);
    if(!scripts\engine\utility::flag("screen_trap_active")) {
      continue;
    }

    if(!isDefined(var_2)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_2.is_off_grid)) {
      continue;
    }

    var_5 = var_2 getcurrentweapon();
    if(var_5 != "iw7_entangler2_zm") {
      continue;
    }

    var_6 = var_2 getplayerangles();
    var_7 = anglesToForward(var_6);
    var_8 = var_2 gettagorigin("tag_eye") + var_7 * 20;
    var_9 = var_8 + var_7 * 15000;
    var_10 = scripts\common\trace::ray_trace(var_8, var_9);
    var_11 = var_10["position"];
    if(scripts\engine\utility::flag("pulled_out_helmet")) {
      if(!scripts\engine\utility::istrue(level.brute_helm_out_of_bounds)) {
        continue;
      }

      level.brute_helm_out_of_bounds = 0;
      level.helmet_on_brute dontinterpolate();
      level.helmet_on_brute.origin = var_11;
      continue;
    }

    if(scripts\engine\utility::flag("set_movie_spaceland")) {
      spawn_brute_helmet(var_11, var_2);
    }
  }
}

spawn_brute_helmet(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level.players[0];
  }

  var_2 = spawn("script_model", var_0);
  var_2 setModel("cp_final_brute_mascot_mask");
  var_2.script_parameters = "heavy_helmet";
  var_2 physicslaunchserver(var_2.origin, (0, 0, 0));
  scripts\engine\utility::flag_set("pulled_out_helmet");
  level.helmet_on_brute = var_2;
  var_1.entangledmodel = var_2;
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.script_noteworthy = "cp_final_brute_mascot_mask";
  var_3.groupname = "dontvalidate";
  thread scripts\cp\crafted_entangler::watchforentanglerdamage(var_3, var_2);
  var_2 thread scripts\cp\maps\cp_final\cp_final_interactions::pickup_helmet();
}

use_blackhole_trap(var_0, var_1) {
  level endon("game_ended");
  level.trapcooldownarray["blackhole_trap"]++;
  var_2 = isDefined(var_1) && isPlayer(var_1);
  activate_trap_feedback(var_1);
  playFX(level._effect["console_spark"], var_0.origin + (0, 0, 40));
  if(var_2) {
    if(scripts\engine\utility::cointoss()) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo");
    } else {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("screentrap_activated", "zmb_comment_vo");
    }
  }

  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  var_3 = getent("theater_button", "targetname");
  var_3 setModel("mp_frag_button_on");
  var_0 thread kill_zombies(var_1);
  earthquake(0.28, int(21), var_0.origin, 500);
  scripts\engine\utility::flag_set("screen_trap_active");
  thread func_2B35(var_0.var_2B30.origin, 20);
  wait(8);
  if(isDefined(var_1) && isPlayer(var_1) && scripts\engine\utility::cointoss() && scripts\engine\utility::flag("set_movie_spaceland") && !scripts\engine\utility::flag("pulled_out_helmet")) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("screentrap_item_hint", "zmb_comment_vo");
  }

  wait(12);
  var_0 notify("stop_dmg");
  var_0.var_2B30.fx delete();
  scripts\engine\utility::flag_clear("screen_trap_active");
  wait(3);
  if(isDefined(var_1) && isPlayer(var_1)) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("screentrap_deactivated", "zmb_comment_vo");
  }

  var_4 = int(90 * level.trapcooldownarray["blackhole_trap"]);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  level scripts\cp\cp_interaction::interaction_cooldown(var_0, var_4);
  var_3 setModel("mp_frag_button_on_green");
}

func_2B35(var_0, var_1) {
  level endon("game_ended");
  playsoundatpos(var_0, "zmb_theatre_screen_wind_start");
  wait(0.3);
  var_2 = scripts\engine\utility::play_loopsound_in_space("zmb_theatre_screen_wind_lp", var_0);
  wait(var_1 - 1);
  var_2 stoploopsound();
  var_2 delete();
  playsoundatpos(var_0, "zmb_theatre_screen_wind_stop");
}

kill_zombies(var_0) {
  self endon("stop_dmg");
  self.var_2B30.fx = spawnfx(level._effect["blackhole_suction"], self.var_2B30.origin, anglesToForward(self.var_2B30.angles), anglestoup(self.var_2B30.angles));
  triggerfx(self.var_2B30.fx);
  for(;;) {
    self.var_2B37 waittill("trigger", var_1);
    if(!cp_final_should_be_affected_by_trap(var_1) || isDefined(var_1.flung)) {
      continue;
    }

    var_1.flung = 1;
    var_1 thread suck_zombie(var_0, self);
    level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(var_1, "death_blackhole", 0);
  }
}

suck_zombie(var_0, var_1) {
  self endon("death");
  var_2 = var_1.var_2B30;
  var_3 = var_1.var_2B32;
  self.scripted_mode = 1;
  wait(randomfloatrange(0, 1));
  var_4 = 16384;
  if(!isDefined(var_2.fx)) {
    self.scripted_mode = 0;
    self.flung = undefined;
    return;
  }

  var_5 = 2304;
  self.marked_for_death = 1;
  self.nocorpse = 1;
  self.precacheleaderboards = 1;
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkto(self.anchor);
  self.anchor rotateto((-90, 0, 0), 0.2);
  var_6 = 360;
  if(randomint(100) > 50) {
    var_6 = -360;
  }

  self.anchor rotateroll(var_6, 1.5);
  self.anchor moveto(var_2.origin, 1.5);
  thread scripts\engine\utility::delete_on_death(self.anchor);
  wait(1.5);
  playFX(level._effect["blackhole_trap_death"], self.origin, anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  self.disable_armor = 1;
  if(isDefined(var_0)) {
    if(!isDefined(var_0.trapkills["trap_gravitron"])) {
      var_0.trapkills["trap_gravitron"] = 1;
    } else {
      var_0.trapkills["trap_gravitron"]++;
    }

    var_7 = ["kill_trap_generic", "kill_trap_gravitron"];
    var_0 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_7), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
    if(!scripts\engine\utility::istrue(level.trap_kills_blackhole)) {
      level.trap_kills_blackhole = 1;
    }

    self dodamage(self.health + 100, var_2.origin, var_0, var_0, "MOD_UNKNOWN", "iw7_theatertrap_zm");
    return;
  }

  self dodamage(self.health + 100, var_2.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_theatertrap_zm");
}

fridge_trap_init() {
  level.trapcooldownarray["fridge_trap"] = 0;
  var_0 = scripts\engine\utility::getstruct("fridge_trap", "script_noteworthy");
  var_0.powered_on = 0;
  var_0 thread listen_for_power();
}

check_if_frost_radius() {
  self endon("explode");
  wait(1);
  for(;;) {
    earthquake(0.2, 0.5, self.origin, 240);
    foreach(var_1 in level.players) {
      if(distancesquared(self.origin, var_1.origin) < 28224) {
        var_1 thread chill_scrnfx(self);
      }
    }

    wait(0.5);
  }
}

check_players_fridge_damage_explosion() {
  earthquake(0.5, 0.3, self.origin, 240);
  foreach(var_1 in level.players) {
    if(distancesquared(self.origin, var_1.origin) < 28224) {
      var_1 dodamage(70, self.origin, self, self, "MOD_EXPLOSIVE", "iw7_fridgetrap_zm");
    }
  }
}

chill_scrnfx(var_0) {
  self endon("disconnect");
  var_1 = spawnfxforclient(level._effect["vfx_freezer_frost_scrn"], self getEye(), self);
  wait(0.1);
  triggerfx(var_1);
  self dodamage(15, var_0.origin, var_0, var_0, "MOD_EXPLOSIVE", "iw7_fridgetrap_zm");
  scripts\engine\utility::waittill_any_timeout(2, "last_stand");
  var_1 delete();
}

fridge_door_open() {
  var_0 = getent("swinging_fridge_door", "script_noteworthy");
  var_0 rotateto((0, 120, 0), 0.5);
}

fridge_door_close() {
  wait(1);
  var_0 = getent("swinging_fridge_door", "script_noteworthy");
  var_0 rotateto((0, 0, 0), 0.5);
}

use_fridge_trap(var_0, var_1) {
  level.trapcooldownarray["fridge_trap"]++;
  activate_trap_feedback(var_1);
  var_2 = isDefined(var_1) && isPlayer(var_1);
  playFX(level._effect["console_spark"], var_0.origin + (0, 0, 20));
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  if(var_2) {
    if(scripts\engine\utility::cointoss()) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo");
    } else {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("chumtrap_activated", "zmb_comment_vo");
    }
  }

  var_3 = getent(var_0.target, "targetname");
  var_3 thread fridge_door_open();
  wait(1);
  var_3 create_attract_positions((1, 1, 0), -115, 4, 32);
  var_3 thread fridge_lure_enemies();
  var_3 thread fridge_explode(var_1);
  var_3 thread scripts\engine\utility::play_loop_sound_on_entity("zmb_freezer_trap_wind_lp");
  var_3 thread check_if_frost_radius();
  scripts\engine\utility::exploder(33);
  wait(20);
  var_3 thread wind_down_sound();
  wait(4);
  var_3 notify("explode");
  var_3 check_players_fridge_damage_explosion();
  var_3 thread fridge_door_close();
  var_4 = int(90 * level.trapcooldownarray["fridge_trap"]);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  level scripts\cp\cp_interaction::interaction_cooldown(var_0, var_4);
}

wind_down_sound() {
  self playSound("zmb_freezer_trap_end");
  self stoploopsound();
}

fridge_lure_enemies() {
  self endon("fridge_death");
  self endon("fridge_explode");
  self.dancers = [];
  var_0 = 22500;
  for(;;) {
    var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_1 = scripts\engine\utility::get_array_of_closest(self.origin, var_1);
    foreach(var_3 in var_1) {
      if(!cp_final_should_be_affected_by_trap(var_3) || var_3.about_to_dance) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_3.is_suicide_bomber)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_3.fridge_trap_marked)) {
        continue;
      }

      if(distancesquared(self.origin, var_3.origin) < var_0) {
        var_3.fridge_trap_marked = 1;
        var_4 = get_closest_attract_position(self, var_3);
        if(isDefined(var_4)) {
          var_3 thread go_to_radio_and_dance(self, var_4);
          var_3 thread release_zombie_on_radio_death(self);
        }
      }
    }

    wait(0.1);
  }
}

go_to_radio_and_dance(var_0, var_1) {
  var_0 endon("fridge_death");
  var_0 endon("fridge_explode");
  self endon("death");
  self endon("turned");
  self.about_to_dance = 1;
  self.scripted_mode = 1;
  self.og_goalradius = self.objective_playermask_showto;
  self.objective_playermask_showto = 32;
  var_2 = var_0.origin - var_1.origin;
  var_3 = vectortoangles(var_2);
  self.desired_dance_angles = (0, var_3[1], 0);
  self give_mp_super_weapon(var_1.origin);
  scripts\engine\utility::waittill_any("goal", "goal_reached");
  self.is_dancing = 1;
  var_0.dancers[var_0.dancers.size] = self;
}

release_zombie_on_radio_death(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::waittill_any("fridge_explode", "fridge_death");
  if(isDefined(self.og_goalradius)) {
    self.objective_playermask_showto = self.og_goalradius;
  }

  self.og_goalradius = undefined;
  self.about_to_dance = 0;
  self.scripted_mode = 0;
  self.fridge_trap_marked = undefined;
}

fridge_explode(var_0) {
  self waittill("explode");
  self notify("fridge_explode");
  self playSound("zmb_freeze");
  playFX(level._effect["cc_ice_burst"], self.origin);
  physicsexplosionsphere(self.origin, 128, 128, 100);
  var_1 = self.dancers;
  var_2 = 16384;
  foreach(var_4 in var_1) {
    if(distancesquared(var_4.origin, self.origin)) {
      var_4 setvelocity(vectornormalize(var_4.origin - self.origin) * 100 + (0, 0, 50));
      var_4 thread fridge_frozen_damage(self, var_0);
    }
  }

  self notify("fridge_death");
  self notify("death");
}

fridge_frozen_damage(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  if(is_cryptid()) {
    if(self.agent_type == "alien_goon") {
      self.marked_for_death = 1;
      self.nocorpse = 1;
      self.full_gib = 1;
      self dodamage(self.health + 100, self.origin, scripts\engine\utility::ter_op(isDefined(var_1) && isPlayer(var_1), var_1, undefined), var_0, "MOD_EXPLOSIVE", "iw7_fridgetrap_zm");
      playFX(scripts\engine\utility::getfx("zombie_freeze_shatter"), self.origin);
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("chumtrap_killfirm", "zmb_comment_vo");
      return;
    } else {
      return;
    }
  }

  self.marked_for_death = 1;
  self.isfrozen = 1;
  var_2 = self.health;
  self.health = 1;
  if(!scripts\engine\utility::istrue(level.trap_kills_fridge)) {
    level.trap_kills_fridge = 1;
  }

  wait(8);
  if(isDefined(var_1) && isPlayer(var_1)) {
    var_3 = var_1;
  } else {
    var_3 = undefined;
  }

  var_1 thread scripts\cp\cp_vo::try_to_play_vo("chumtrap_killfirm", "zmb_comment_vo");
  self dodamage(self.health + 100, self.origin, var_3, var_0, "MOD_EXPLOSIVE", "iw7_fridgetrap_zm");
}

get_closest_attract_position(var_0, var_1) {
  var_2 = sortbydistance(var_0.attract_positions, var_0.origin);
  foreach(var_4 in var_2) {
    if(!var_4.occupied) {
      var_4.occupied = 1;
      thread releaseposonzombiedeath(var_4, var_1, var_0);
      return var_4;
    }
  }

  return undefined;
}

releaseposonzombiedeath(var_0, var_1, var_2) {
  level endon("game_ended");
  var_2 endon("fridge_death");
  var_2 endon("fridge_explode");
  var_1 waittill("death");
  var_0.occupied = 0;
}

create_attract_positions(var_0, var_1, var_2, var_3) {
  self endon("fridge_death");
  self endon("fridge_explode");
  var_4 = -27120;
  var_5 = 0;
  var_6 = 140 / var_2;
  self.attract_positions = [];
  self.occupied_positions = 0;
  self.discotrap_disabled = 0;
  for(var_7 = var_1; var_7 < 140 + var_1; var_7 = var_7 + var_6) {
    var_8 = var_0 * var_3;
    var_9 = (cos(var_7) * var_8[0] - sin(var_7) * var_8[1], sin(var_7) * var_8[0] + cos(var_7) * var_8[1], var_8[2]);
    var_10 = getclosestpointonnavmesh(self.origin + var_9 + (0, 0, 10));
    if(!scripts\cp\loot::is_in_active_volume(var_10)) {
      continue;
    }

    var_11 = abs(var_10[2] - self.origin[2]);
    if(isDefined(var_10) && distancesquared(var_10, self.origin) > var_4) {
      continue;
    } else {
      if(var_11 < 200) {
        var_12 = spawnStruct();
        var_12.origin = var_10;
        var_12.occupied = 0;
        self.attract_positions[self.attract_positions.size] = var_12;
        continue;
      }

      var_5++;
    }
  }

  for(var_7 = var_1; var_7 < 140 + var_1; var_7 = var_7 + var_6) {
    var_8 = var_0 * var_3 + 40;
    var_9 = (cos(var_7) * var_8[0] - sin(var_7) * var_8[1], sin(var_7) * var_8[0] + cos(var_7) * var_8[1], var_8[2]);
    var_10 = getclosestpointonnavmesh(self.origin + var_9 + (0, 0, 10));
    if(!scripts\cp\loot::is_in_active_volume(var_10)) {
      continue;
    }

    var_11 = abs(var_10[2] - self.origin[2]);
    if(isDefined(var_10) && distancesquared(var_10, self.origin) > var_4) {
      continue;
    } else {
      if(var_11 < 200) {
        var_12 = spawnStruct();
        var_12.origin = var_10;
        var_12.occupied = 0;
        self.attract_positions[self.attract_positions.size] = var_12;
        continue;
      }

      var_5++;
    }
  }

  return var_5;
}

electric_trap_init() {
  level.trapcooldownarray["electric_trap"] = 0;
  var_0 = scripts\engine\utility::getstructarray("electric_trap", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.powered_on = 0;
    var_2 thread listen_for_power();
  }

  level thread elec_trap_sparks();
}

elec_trap_sparks() {
  level endon("electric_trap_part_added");
  var_0 = scripts\engine\utility::getstructarray("electric_trap_sparks", "targetname");
  for(;;) {
    var_1 = scripts\engine\utility::random(var_0).origin;
    playFX(level._effect["elec_trap_sparks"], var_1);
    wait(randomintrange(1, 3));
  }
}

electric_start_sound() {
  self playSound("zmb_electric_trap_start");
  thread scripts\engine\utility::play_loop_sound_on_entity("zmb_electric_trap_lp");
  level waittill("stop_electric_trap");
  scripts\engine\utility::stop_loop_sound_on_entity("zmb_electric_trap_lp");
  self playSound("zmb_electric_trap_stop");
  self delete();
}

electric_trap_use(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_0.powered_on)) {
    return;
  }

  level.trapcooldownarray["electric_trap"]++;
  var_2 = isDefined(var_1) && isPlayer(var_1);
  activate_trap_feedback(var_1);
  var_3 = scripts\engine\utility::getstructarray(var_0.script_noteworthy, "script_noteworthy");
  foreach(var_5 in var_3) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_5);
    var_6 = getent(var_5.target, "targetname");
    var_6 setModel("mp_frag_button_on");
  }

  if(var_2) {
    if(scripts\engine\utility::cointoss()) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo");
    } else {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("elecwater_activated", "zmb_comment_vo");
    }
  }

  var_8 = spawn("script_origin", (-729, 4873, -85));
  var_9 = spawn("script_origin", (-1031, 4914, -85));
  var_8 thread electric_start_sound();
  var_9 thread electric_start_sound();
  level notify("use_electric_trap");
  scripts\engine\utility::exploder(88);
  level thread electric_trap_damage(var_0, var_1);
  level thread electric_trap_rumble();
  wait(24);
  level notify("stop_electric_trap");
  if(isDefined(var_1) && isPlayer(var_1)) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("elecwater_deactivated", "zmb_comment_vo");
  }

  var_10 = int(90 * level.trapcooldownarray["electric_trap"]);
  foreach(var_5 in var_3) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_5);
    level thread scripts\cp\cp_interaction::interaction_cooldown(var_5, var_10);
  }

  wait(var_10);
  foreach(var_5 in var_3) {
    var_6 = getent(var_5.target, "targetname");
    var_6 setModel("mp_frag_button_on_green");
  }
}

electric_trap_damage(var_0, var_1) {
  level endon("stop_electric_trap");
  var_2 = gettime();
  var_3 = getent("electric_trap_trig", "targetname");
  for(;;) {
    var_3 waittill("trigger", var_4);
    if(isPlayer(var_4) && isalive(var_4) && !scripts\cp\cp_laststand::player_in_laststand(var_4) && !isDefined(var_4.padding_damage)) {
      playfxontagforclients(level._effect["electric_shock_plyr"], var_4, "tag_eye", var_4);
      var_4.padding_damage = 1;
      var_4 dodamage(40, var_3.origin, var_3, var_3, "MOD_UNKNOWN", "iw7_electrotrap_zm");
      var_4 thread remove_padding_damage();
      continue;
    }

    if(var_4 is_cryptid()) {
      if(var_4.agent_type == "alien_phantom" && !scripts\engine\utility::flag("electricphantom_step2")) {
        scripts\engine\utility::flag_set("electricphantom_step2");
        var_5 = var_4.origin;
        var_6 = spawnfx(level._effect["vfx_venmox_spark"], var_5);
        triggerfx(var_6);
        thread killfxaftertime(var_6);
        scripts\engine\utility::exploder(45);
      }

      if(var_4.agent_type == "alien_goon") {
        if(isDefined(var_1) && isPlayer(var_1)) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("elecwater_killfirm", "zmb_comment_vo");
        }

        thread delayed_cryptid_death(var_4, var_1);
      }

      continue;
    }

    if(scripts\engine\utility::istrue(var_4.is_turned) || !cp_final_should_be_affected_by_trap(var_4, 0, 1)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_4.electrocuted)) {
      continue;
    }

    level thread electrocute_zombie(var_4, var_1);
  }
}

killfxaftertime(var_0) {
  level endon("game_ended");
  wait(3);
  if(isDefined(var_0)) {
    var_0 delete();
  }
}

is_crog() {
  if(!isDefined(self.agent_type)) {
    return 0;
  }

  return self.agent_type == "crab_mini" || self.agent_type == "crab_brute";
}

is_cryptid() {
  if(!isDefined(self.agent_type)) {
    return 0;
  }

  return self.agent_type == "alien_goon" || self.agent_type == "alien_phantom" || self.agent_type == "alien_rhino";
}

electrocute_zombie(var_0, var_1) {
  var_0 endon("death");
  var_0.dontmutilate = 1;
  var_0.electrocuted = 1;
  var_0.marked_for_death = 1;
  wait(randomfloat(3));
  var_2 = scripts\engine\utility::getstructarray("electric_trap_spots", "targetname");
  var_3 = scripts\engine\utility::getclosest(var_0.origin, var_2);
  var_4 = var_3.origin + (0, 0, randomintrange(-17, 17));
  var_5 = var_0.origin + (0, 0, randomintrange(20, 60));
  playfxbetweenpoints(level._effect["electric_trap_attack"], var_4, vectortoangles(var_5 - var_4), var_5);
  playFX(level._effect["electric_trap_shock"], var_5);
  if(scripts\cp\utility::should_be_affected_by_trap(var_0, 1, 0)) {
    var_0 setscriptablepartstate("electrocuted", "on");
  }

  if(isDefined(var_1) && isPlayer(var_1) && var_1 scripts\cp\utility::is_valid_player()) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("elecwater_killfirm", "zmb_comment_vo");
    var_6 = var_1;
  } else {
    var_6 = undefined;
  }

  if(!scripts\engine\utility::istrue(level.trap_kills_electric)) {
    level.trap_kills_electric = 1;
  }

  var_0 dodamage(var_0.health + 100, var_0.origin, var_6, var_6, "MOD_UNKNOWN", "iw7_electrotrap_zm");
}

electric_trap_rumble() {
  level endon("stop_electric_trap");
  var_0 = getent("electric_trap_trig", "targetname");
  for(;;) {
    wait(0.2);
    earthquake(0.18, 1, var_0.origin, 784);
    wait(0.05);
    playrumbleonposition("artillery_rumble", var_0.origin);
  }
}

init_rain_trap() {
  level.trapcooldownarray["acid_rain_trap"] = 0;
  var_0 = scripts\engine\utility::getstructarray("acid_rain_trap", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.powered_on = 0;
    var_2 thread listen_for_power();
  }

  level.ambient_acid_water = [];
  var_4 = scripts\engine\utility::getstructarray("leaking_water_acid", "script_noteworthy");
  foreach(var_6 in var_4) {
    var_7 = spawnfx(scripts\engine\utility::getfx("acid_drip"), var_6.origin);
    level.ambient_acid_water[level.ambient_acid_water.size] = var_7;
    triggerfx(var_7);
  }
}

use_rain_trap(var_0, var_1) {
  level.trapcooldownarray["acid_rain_trap"]++;
  var_2 = isDefined(var_1) && isPlayer(var_1);
  activate_trap_feedback(var_1);
  var_3 = scripts\engine\utility::getstructarray(var_0.script_noteworthy, "script_noteworthy");
  foreach(var_5 in var_3) {
    level thread scripts\cp\cp_interaction::remove_from_current_interaction_list(var_5);
    var_6 = getent(var_5.target, "targetname");
    var_6 setModel("mp_frag_button_on");
  }

  if(var_2) {
    activate_trap_feedback(var_1);
  }

  playFX(level._effect["console_spark"], var_0.origin + (0, 0, 40));
  var_8 = scripts\engine\utility::play_loopsound_in_space("zmb_acid_sprinkler_lp_01", (2561.9, 5538.54, 162.494));
  var_9 = scripts\engine\utility::play_loopsound_in_space("zmb_acid_sprinkler_lp_02", (2804.16, 5413.26, 162.494));
  var_10 = scripts\engine\utility::play_loopsound_in_space("zmb_acid_sprinkler_splash_lp_01", (2909.23, 5501.22, 64.1279));
  var_11 = scripts\engine\utility::play_loopsound_in_space("zmb_acid_sprinkler_splash_lp_02", (2479.75, 5430.08, 67.123));
  foreach(var_13 in level.ambient_acid_water) {
    var_13 hide();
  }

  if(var_2) {
    if(scripts\engine\utility::cointoss()) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo");
    } else {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("acidrain_activated", "zmb_comment_vo");
    }
  }

  scripts\engine\utility::exploder(55);
  level notify("use_rain_trap");
  level thread rain_trap_damage(var_0, var_1);
  wait(24);
  level notify("stop_acid_trap");
  var_8 stoploopsound();
  var_8 delete();
  var_9 stoploopsound();
  var_9 delete();
  var_10 stoploopsound();
  var_10 delete();
  var_11 stoploopsound();
  var_11 delete();
  foreach(var_13 in level.ambient_acid_water) {
    var_13 show();
  }

  if(isDefined(var_1) && isPlayer(var_1)) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("acidrain_deactivated", "zmb_comment_vo");
  }

  var_11 = int(90 * level.trapcooldownarray["acid_rain_trap"]);
  foreach(var_5 in var_3) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_5);
    level thread scripts\cp\cp_interaction::interaction_cooldown(var_5, var_11);
  }

  wait(var_11);
  foreach(var_5 in var_3) {
    var_6 = getent(var_5.target, "targetname");
    var_6 setModel("mp_frag_button_on_green");
  }
}

remove_padding_damage_and_rain() {
  remove_padding_damage();
  if(isDefined(self)) {
    stopfxontagforclients(level._effect["sasquatch_rock_hit"], self, "tag_eye", self);
  }
}

rain_trap_damage(var_0, var_1) {
  level endon("stop_acid_trap");
  var_2 = gettime();
  var_3 = getent("acid_trap_trig", "targetname");
  for(;;) {
    var_3 waittill("trigger", var_4);
    if(scripts\engine\utility::istrue(var_4.applyacidraindamage)) {
      continue;
    }

    if(isPlayer(var_4)) {
      if(isalive(var_4) && !scripts\cp\cp_laststand::player_in_laststand(var_4) && !isDefined(var_4.padding_damage)) {
        playfxontagforclients(level._effect["sasquatch_rock_hit"], var_4, "tag_eye", var_4);
        var_4.padding_damage = 1;
        var_4 dodamage(40, var_3.origin, var_3, var_3, "MOD_UNKNOWN", "iw7_raintrap_zm");
        var_4 thread remove_padding_damage_and_rain();
        scripts\engine\utility::waitframe();
        continue;
      }

      continue;
    }

    if(scripts\engine\utility::istrue(var_4.is_turned) || !cp_final_should_be_affected_by_trap(var_4, 0, 1)) {
      continue;
    }

    if(var_4 is_crog() || var_4 is_cryptid()) {
      if(var_4.agent_type == "alien_goon") {
        thread delayed_cryptid_death(var_4, var_1);
      }

      continue;
    }

    level thread rain_dmg_zombie(var_4, var_1);
  }
}

delayed_cryptid_death(var_0, var_1) {
  var_0 endon("death");
  wait(randomfloat(0.5));
  var_0.marked_for_death = 1;
  if(isDefined(var_1) && isPlayer(var_1)) {
    var_0 dodamage(var_0.health + 100, var_0.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_raintrap_zm");
    return;
  }

  var_0 dodamage(var_0.health + 100, var_0.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_raintrap_zm");
}

rain_dmg_zombie(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  var_0 endon("death");
  var_0.applyacidraindamage = 1;
  var_0.marked_for_death = 1;
  wait(randomfloat(2.5));
  var_0.dontmutilate = 1;
  var_0.nocorpse = 1;
  if(isDefined(var_1) && isPlayer(var_1) && var_1 scripts\cp\utility::is_valid_player(1)) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("acidrain_killfirm", "zmb_comment_vo");
    var_2 = var_1;
  } else {
    var_2 = undefined;
  }

  playFX(level._effect["acid_rain_death"], var_0.origin);
  if(!scripts\engine\utility::istrue(level.trap_kills_acidrain)) {
    level.trap_kills_acidrain = 1;
  }

  playsoundatpos(var_0.origin, "gib_fullbody");
  var_0 dodamage(var_0.health + 100, var_0.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_raintrap_zm");
}

listen_for_power() {
  if(scripts\engine\utility::istrue(self.requires_power)) {
    level scripts\engine\utility::waittill_any("power_on", "traps_on");
    if(isDefined(self.target)) {
      var_0 = getent(self.target, "targetname");
      if(isDefined(var_0)) {
        if(var_0.model == "mp_frag_button_on") {
          var_0 setModel("mp_frag_button_on_green");
        }
      }
    }

    if(isDefined(self.target_secondary)) {
      var_0 = getent(self.target_secondary, "targetname");
      if(isDefined(var_0)) {
        if(var_0.model == "mp_frag_button_on") {
          var_0 setModel("mp_frag_button_on_green");
        }
      }
    }
  }

  self.powered_on = 1;
}

activate_trap_feedback(var_0) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    var_1 = ["fistpump", "fingercrossed", "handboom", "kissfist"];
    var_2 = scripts\engine\utility::random(var_1);
    var_3 = "iw7_" + var_2 + "_zm";
    var_0 thread scripts\cp\utility::usegrenadegesture(var_0, var_3);
  }
}