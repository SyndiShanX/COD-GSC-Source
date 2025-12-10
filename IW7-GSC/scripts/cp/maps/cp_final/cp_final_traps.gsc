/*******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
      foreach(var_01 in level.players) {
        var_01 scripts\cp\zombies\achievement::update_achievement("FAILED_MAINTENANCE", 1);
      }

      level notify("achievement_given");
    }

    wait(1);
  }
}

cp_final_should_be_affected_by_trap(param_00, param_01, param_02) {
  if(isDefined(param_00.agent_type) && param_00.agent_type == "slasher") {
    return 0;
  }

  if(!scripts\cp\utility::should_be_affected_by_trap(param_00, param_01, param_02)) {
    return 0;
  }

  if(param_00.team == "allies") {
    return 0;
  }

  return 1;
}

force_panels_powered_on() {
  var_00 = scripts\engine\utility::getstructarray("laser_trap", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.powered_on = 1;
  }

  var_04 = scripts\engine\utility::getstructarray("blackhole_trap", "script_noteworthy");
  foreach(var_02 in var_04) {
    var_02.powered_on = 1;
  }

  var_07 = scripts\engine\utility::getstructarray("acid_rain_trap", "script_noteworthy");
  foreach(var_02 in var_07) {
    var_02.powered_on = 1;
  }

  var_0A = scripts\engine\utility::getstruct("fridge_trap", "script_noteworthy");
  var_0A.powered_on = 1;
  var_0B = scripts\engine\utility::getstruct("electric_trap", "script_noteworthy");
  var_0B.powered_on = 1;
}

lasers_trap_init() {
  level.trapcooldownarray["laser_trap"] = 0;
  level.lasertriggers = [];
  var_00 = scripts\engine\utility::getstructarray("laser_trap", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.powered_on = 0;
    var_02 thread listen_for_power();
  }

  var_04 = getEntArray("trap_lasers", "script_noteworthy");
  foreach(var_06 in var_04) {
    foreach(var_08 in var_04) {
      if(var_06 == var_08) {
        continue;
      }

      var_09 = getent(var_06.target, "targetname");
      if(scripts\engine\utility::array_contains(level.lasertriggers, var_09)) {
        continue;
      }

      var_0A = scripts\engine\utility::get_array_of_closest(var_06.origin, var_04, [var_06], 1, 48, 0)[0];
      if(isDefined(var_0A) && scripts\engine\utility::array_contains(level.lasertriggers, var_0A)) {
        continue;
      }

      if(isDefined(var_0A) && var_0A.origin[2] < var_06.origin[2]) {
        continue;
      }

      var_0A = scripts\engine\utility::get_array_of_closest(var_09.origin, var_04, [var_09], 1, 48, 0)[0];
      if(isDefined(var_0A) && scripts\engine\utility::array_contains(level.lasertriggers, var_0A)) {
        continue;
      }

      if(isDefined(var_0A) && var_0A.origin[2] < var_09.origin[2]) {
        continue;
      }

      var_06.name = "use_laser_trigger";
    }
  }
}

power_on_lasers(param_00) {
  var_01 = getent(self.target, "targetname");
  if(!isDefined(self.activated)) {
    var_01.activated = 1;
  } else if(scripts\engine\utility::istrue(self.activated)) {
    return;
  }

  thread create_laser_beam_fx(self, var_01, param_00);
}

laser_sound_individual() {
  self playSound("zmb_trap_laser_start");
  thread scripts\engine\utility::play_loop_sound_on_entity("zmb_trap_laser_lp", (0, 0, 0));
  level waittill("lasers_end");
  thread scripts\engine\utility::stop_loop_sound_on_entity("zmb_trap_laser_lp");
  self playSound("zmb_trap_laser_end");
}

create_laser_beam_fx(param_00, param_01, param_02) {
  var_03 = param_00;
  var_04 = param_01;
  var_03 linkto(var_04);
  scripts\engine\utility::waitframe();
  if(!isDefined(self)) {
    var_03 delete();
    var_04 delete();
    return;
  }

  var_05 = randomfloat(1);
  thread laser_sound_individual();
  if(var_05 > 0.5) {
    var_06 = playfxontagsbetweenclients(scripts\engine\utility::getfx("trap_ww_beam"), var_03, "tag_origin", var_04, "tag_origin");
  } else {
    var_06 = playfxontagsbetweenclients(scripts\engine\utility::getfx("trap_ww_beam"), var_05, "tag_origin", var_04, "tag_origin");
  }

  var_06.var_336 = "laser_beam_effect";
  thread func_403A(var_06);
  var_05 = randomfloat(1);
  if(var_05 > 0.5) {
    var_07 = playFXOnTag(scripts\engine\utility::getfx("vfx_zb_laser_lens"), var_03, "tag_origin");
    thread kill_fx_cleanup(scripts\engine\utility::getfx("vfx_zb_laser_lens"), var_03, "tag_origin");
  } else {
    var_07 = playFXOnTag(scripts\engine\utility::getfx("vfx_zb_laser_lens"), var_05, "tag_origin");
    thread kill_fx_cleanup(scripts\engine\utility::getfx("vfx_zb_laser_lens"), var_04, "tag_origin");
  }

  var_08 = undefined;
  if(isDefined(self.script_noteworthy) && self.script_noteworthy != "trap_lasers_no_trig") {
    if(isDefined(self.name) && self.name == "use_laser_trigger") {
      var_09 = distance(var_03.origin, var_04.origin);
      var_08 = spawn("trigger_rotatable_radius", var_03.origin, 0, 2, var_09);
      var_08.angles = vectortoangles(var_04.origin - var_03.origin) + (90, 0, 0);
      var_08.triggerportableradarping = param_02;
      thread damage_enemies_in_trigger(var_04, var_03, var_08);
      level thread func_403A(var_08);
    }
  }

  level thread updatefxlaserjoined();
  level thread updatefxlaserdisconnected();
  level thread movelaser(var_04, var_08);
}

movelaser(param_00, param_01) {
  level endon("lasers_end");
  if(isDefined(param_01)) {
    param_01 enablelinkto();
    param_01 linkto(param_00);
  }

  for(;;) {
    if(param_00.origin[2] < 100) {
      param_00 moveto(param_00.origin + (0, 0, 60), 1, 0.15, 0.15);
      param_00 waittill("movedone");
    }

    param_00 moveto(param_00.origin - (0, 0, 60), 1, 0.15, 0.15);
    param_00 waittill("movedone");
  }
}

kill_fx_cleanup(param_00, param_01, param_02) {
  level endon("game_ended");
  level waittill("lasers_end");
  killfxontag(param_00, param_01, param_02);
}

func_403A(param_00) {
  level endon("game_ended");
  level waittill("lasers_end");
  if(isDefined(param_00)) {
    param_00 delete();
  }
}

laser_eye_fx() {
  self endon("disconnect");
  var_00 = spawnfxforclient(level._effect["vfx_zb_laser_screen"], self getEye(), self);
  wait(0.1);
  triggerfx(var_00);
  scripts\engine\utility::waittill_any_timeout_1(2, "last_stand");
  var_00 delete();
}

damage_enemies_in_trigger(param_00, param_01, param_02, param_03) {
  level endon("lasers_end");
  self endon("death");
  param_02 endon("death");
  param_00 endon("death");
  param_01 endon("death");
  for(;;) {
    param_02 waittill("trigger", var_04);
    if(!isDefined(var_04)) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(isplayer(var_04)) {
      if(var_04 scripts\cp\utility::is_valid_player()) {
        if(!isDefined(var_04.padding_damage)) {
          var_05 = var_04 getEye()[2] + 4;
          var_06 = var_04 gettagorigin("j_ball_ri")[2] - 2;
          var_07 = param_02.origin[2];
          if(!scripts\engine\utility::istrue(param_03) && var_05 < var_07 || var_06 > var_07) {
            scripts\engine\utility::waitframe();
            continue;
          }

          thread kill_fx_on_death(param_00, param_01);
          playsoundatpos(var_04.origin, "trap_electric_shock");
          var_04 thread laser_eye_fx();
          var_04.padding_damage = 1;
          var_04 dodamage(70, param_02.origin, param_02, param_02, "MOD_UNKNOWN", "iw7_lasertrap_zm");
          var_04 thread remove_padding_damage();
          scripts\engine\utility::waitframe();
          continue;
        }
      }

      scripts\engine\utility::waitframe();
      continue;
    } else {
      if(var_04 is_cryptid()) {
        if(var_04.agent_type != "alien_goon") {
          scripts\engine\utility::waitframe();
          continue;
        }
      }

      thread kill_fx_on_death(param_00, param_01);
      thread run_laser_death(var_04, param_02.triggerportableradarping);
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

kill_fx_on_death(param_00, param_01) {
  level endon("game_ended");
  var_02 = playfxontagsbetweenclients(scripts\engine\utility::getfx("trap_ww_beam_death"), param_00, "tag_origin", param_01, "tag_origin");
  var_02.var_336 = "laser_beam_kill_effect";
  thread func_403A(var_02);
}

run_laser_death(param_00, param_01) {
  param_00 endon("death");
  param_00.marked_for_death = 1;
  param_00.atomize_me = 1;
  param_00.not_killed_by_headshot = 1;
  if(!scripts\engine\utility::istrue(level.trap_kills_laser)) {
    level.trap_kills_laser = 1;
  }

  if(isDefined(param_01)) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("lasertrap_killfirm", "zmb_comment_vo");
    param_00 dodamage(param_00.health, param_00.origin, param_01, param_01, "MOD_UNKNOWN", "iw7_lasertrap_zm");
    return;
  }

  param_00 dodamage(param_00.health, param_00.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_lasertrap_zm");
}

updatefxlaserjoined() {}

updatefxlaserdisconnected() {}

use_lasers_trap(param_00, param_01) {
  level.trapcooldownarray["laser_trap"]++;
  var_02 = isDefined(param_01) && isplayer(param_01);
  var_03 = scripts\engine\utility::getstructarray("laser_trap", "script_noteworthy");
  foreach(var_05 in var_03) {
    var_06 = getent(var_05.target, "targetname");
    var_06 setModel("mp_frag_button_on");
  }

  activate_trap_feedback(param_01);
  playFX(level._effect["console_spark"], param_00.origin + (0, 0, 40));
  foreach(param_00 in var_03) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  }

  if(var_02) {
    if(scripts\engine\utility::cointoss()) {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo");
    } else {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("lasertrap_activated", "zmb_comment_vo");
    }
  }

  var_0A = scripts\engine\utility::array_combine(getEntArray("trap_lasers", "script_noteworthy"), getEntArray("trap_lasers_no_trig", "script_noteworthy"));
  foreach(var_0C in var_0A) {
    var_0C.triggerent = undefined;
    var_0C power_on_lasers(param_01);
  }

  wait(23);
  level notify("lasers_end");
  if(isDefined(param_01) && isplayer(param_01)) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("lasertrap_deactiveated", "zmb_comment_vo");
  }

  var_0E = int(90 * level.trapcooldownarray["laser_trap"]);
  foreach(param_00 in var_03) {
    level thread scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
    level thread scripts\cp\cp_interaction::interaction_cooldown(param_00, var_0E);
  }

  wait(var_0E);
  foreach(var_05 in var_03) {
    var_06 = getent(var_05.target, "targetname");
    var_06 setModel("mp_frag_button_on_green");
  }
}

init_blackhole_trap() {
  level.trapcooldownarray["blackhole_trap"] = 0;
  var_00 = undefined;
  var_01 = undefined;
  var_02 = undefined;
  var_03 = scripts\engine\utility::getstructarray("blackhole_trap", "script_noteworthy");
  foreach(var_05 in var_03) {
    var_05.powered_on = 0;
    var_05 thread listen_for_power();
    var_05.body = getent(var_05.target, "targetname");
    var_06 = scripts\engine\utility::getstructarray(var_05.target, "targetname");
    foreach(var_08 in var_06) {
      if(isDefined(var_08.fgetarg)) {
        var_05.var_2B32 = var_08;
        continue;
      }

      var_05.var_2B30 = var_08;
    }

    var_05.var_2B37 = spawn("trigger_radius", var_05.var_2B32.origin, 0, var_05.var_2B32.fgetarg, 96);
  }

  scripts\engine\utility::flag_init("screen_trap_active");
  level thread watch_for_obtain_helmet();
}

func_2B36() {
  var_00 = scripts\engine\utility::istrue(self.requires_power) && isDefined(self.power_area);
  for(;;) {
    var_01 = "power_on";
    if(var_00) {
      var_01 = level scripts\engine\utility::waittill_any_return_no_endon_death_3("power_on", self.power_area + " power_on", "power_off");
      if(var_01 != "power_off") {
        self.powered_on = 1;
      } else {
        self.powered_on = 0;
      }
    }

    if(!var_00) {
      break;
    }

    wait(0.25);
  }
}

watch_for_obtain_helmet() {
  var_00 = getent("movie_screen_hole", "targetname");
  for(;;) {
    var_00 waittill("damage", var_01, var_02, var_03, var_04);
    if(!scripts\engine\utility::flag("screen_trap_active")) {
      continue;
    }

    if(!isDefined(var_02)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_02.is_off_grid)) {
      continue;
    }

    var_05 = var_02 getcurrentweapon();
    if(var_05 != "iw7_entangler2_zm") {
      continue;
    }

    var_06 = var_02 getplayerangles();
    var_07 = anglesToForward(var_06);
    var_08 = var_02 gettagorigin("tag_eye") + var_07 * 20;
    var_09 = var_08 + var_07 * 15000;
    var_0A = scripts\common\trace::ray_trace(var_08, var_09);
    var_0B = var_0A["position"];
    if(scripts\engine\utility::flag("pulled_out_helmet")) {
      if(!scripts\engine\utility::istrue(level.brute_helm_out_of_bounds)) {
        continue;
      }

      level.brute_helm_out_of_bounds = 0;
      level.helmet_on_brute dontinterpolate();
      level.helmet_on_brute.origin = var_0B;
      continue;
    }

    if(scripts\engine\utility::flag("set_movie_spaceland")) {
      spawn_brute_helmet(var_0B, var_02);
    }
  }
}

spawn_brute_helmet(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = level.players[0];
  }

  var_02 = spawn("script_model", param_00);
  var_02 setModel("cp_final_brute_mascot_mask");
  var_02.script_parameters = "heavy_helmet";
  var_02 physicslaunchserver(var_02.origin, (0, 0, 0));
  scripts\engine\utility::flag_set("pulled_out_helmet");
  level.helmet_on_brute = var_02;
  param_01.entangledmodel = var_02;
  var_03 = spawnStruct();
  var_03.origin = param_00;
  var_03.script_noteworthy = "cp_final_brute_mascot_mask";
  var_03.groupname = "dontvalidate";
  thread scripts\cp\crafted_entangler::watchforentanglerdamage(var_03, var_02);
  var_02 thread scripts\cp\maps\cp_final\cp_final_interactions::pickup_helmet();
}

use_blackhole_trap(param_00, param_01) {
  level endon("game_ended");
  level.trapcooldownarray["blackhole_trap"]++;
  var_02 = isDefined(param_01) && isplayer(param_01);
  activate_trap_feedback(param_01);
  playFX(level._effect["console_spark"], param_00.origin + (0, 0, 40));
  if(var_02) {
    if(scripts\engine\utility::cointoss()) {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo");
    } else {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("screentrap_activated", "zmb_comment_vo");
    }
  }

  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  var_03 = getent("theater_button", "targetname");
  var_03 setModel("mp_frag_button_on");
  param_00 thread kill_zombies(param_01);
  earthquake(0.28, int(21), param_00.origin, 500);
  scripts\engine\utility::flag_set("screen_trap_active");
  thread func_2B35(param_00.var_2B30.origin, 20);
  wait(8);
  if(isDefined(param_01) && isplayer(param_01) && scripts\engine\utility::cointoss() && scripts\engine\utility::flag("set_movie_spaceland") && !scripts\engine\utility::flag("pulled_out_helmet")) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("screentrap_item_hint", "zmb_comment_vo");
  }

  wait(12);
  param_00 notify("stop_dmg");
  param_00.var_2B30.fx delete();
  scripts\engine\utility::flag_clear("screen_trap_active");
  wait(3);
  if(isDefined(param_01) && isplayer(param_01)) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("screentrap_deactivated", "zmb_comment_vo");
  }

  var_04 = int(90 * level.trapcooldownarray["blackhole_trap"]);
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
  level scripts\cp\cp_interaction::interaction_cooldown(param_00, var_04);
  var_03 setModel("mp_frag_button_on_green");
}

func_2B35(param_00, param_01) {
  level endon("game_ended");
  playsoundatpos(param_00, "zmb_theatre_screen_wind_start");
  wait(0.3);
  var_02 = scripts\engine\utility::play_loopsound_in_space("zmb_theatre_screen_wind_lp", param_00);
  wait(param_01 - 1);
  var_02 stoploopsound();
  var_02 delete();
  playsoundatpos(param_00, "zmb_theatre_screen_wind_stop");
}

kill_zombies(param_00) {
  self endon("stop_dmg");
  self.var_2B30.fx = spawnfx(level._effect["blackhole_suction"], self.var_2B30.origin, anglesToForward(self.var_2B30.angles), anglestoup(self.var_2B30.angles));
  triggerfx(self.var_2B30.fx);
  for(;;) {
    self.var_2B37 waittill("trigger", var_01);
    if(!cp_final_should_be_affected_by_trap(var_01) || isDefined(var_01.flung)) {
      continue;
    }

    var_01.flung = 1;
    var_01 thread suck_zombie(param_00, self);
    level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(var_01, "death_blackhole", 0);
  }
}

suck_zombie(param_00, param_01) {
  self endon("death");
  var_02 = param_01.var_2B30;
  var_03 = param_01.var_2B32;
  self.scripted_mode = 1;
  wait(randomfloatrange(0, 1));
  var_04 = 16384;
  if(!isDefined(var_02.fx)) {
    self.scripted_mode = 0;
    self.flung = undefined;
    return;
  }

  var_05 = 2304;
  self.marked_for_death = 1;
  self.nocorpse = 1;
  self.precacheleaderboards = 1;
  self.anchor = spawn("script_origin", self.origin);
  self.anchor.angles = self.angles;
  self linkto(self.anchor);
  self.anchor rotateto((-90, 0, 0), 0.2);
  var_06 = 360;
  if(randomint(100) > 50) {
    var_06 = -360;
  }

  self.anchor rotateroll(var_06, 1.5);
  self.anchor moveto(var_02.origin, 1.5);
  thread scripts\engine\utility::delete_on_death(self.anchor);
  wait(1.5);
  playFX(level._effect["blackhole_trap_death"], self.origin, anglesToForward((-90, 0, 0)), anglestoup((-90, 0, 0)));
  self.disable_armor = 1;
  if(isDefined(param_00)) {
    if(!isDefined(param_00.trapkills["trap_gravitron"])) {
      param_00.trapkills["trap_gravitron"] = 1;
    } else {
      param_00.trapkills["trap_gravitron"]++;
    }

    var_07 = ["kill_trap_generic", "kill_trap_gravitron"];
    param_00 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_07), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
    if(!scripts\engine\utility::istrue(level.trap_kills_blackhole)) {
      level.trap_kills_blackhole = 1;
    }

    self dodamage(self.health + 100, var_02.origin, param_00, param_00, "MOD_UNKNOWN", "iw7_theatertrap_zm");
    return;
  }

  self dodamage(self.health + 100, var_02.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_theatertrap_zm");
}

fridge_trap_init() {
  level.trapcooldownarray["fridge_trap"] = 0;
  var_00 = scripts\engine\utility::getstruct("fridge_trap", "script_noteworthy");
  var_00.powered_on = 0;
  var_00 thread listen_for_power();
}

check_if_frost_radius() {
  self endon("explode");
  wait(1);
  for(;;) {
    earthquake(0.2, 0.5, self.origin, 240);
    foreach(var_01 in level.players) {
      if(distancesquared(self.origin, var_01.origin) < 28224) {
        var_01 thread chill_scrnfx(self);
      }
    }

    wait(0.5);
  }
}

check_players_fridge_damage_explosion() {
  earthquake(0.5, 0.3, self.origin, 240);
  foreach(var_01 in level.players) {
    if(distancesquared(self.origin, var_01.origin) < 28224) {
      var_01 dodamage(70, self.origin, self, self, "MOD_EXPLOSIVE", "iw7_fridgetrap_zm");
    }
  }
}

chill_scrnfx(param_00) {
  self endon("disconnect");
  var_01 = spawnfxforclient(level._effect["vfx_freezer_frost_scrn"], self getEye(), self);
  wait(0.1);
  triggerfx(var_01);
  self dodamage(15, param_00.origin, param_00, param_00, "MOD_EXPLOSIVE", "iw7_fridgetrap_zm");
  scripts\engine\utility::waittill_any_timeout_1(2, "last_stand");
  var_01 delete();
}

fridge_door_open() {
  var_00 = getent("swinging_fridge_door", "script_noteworthy");
  var_00 rotateto((0, 120, 0), 0.5);
}

fridge_door_close() {
  wait(1);
  var_00 = getent("swinging_fridge_door", "script_noteworthy");
  var_00 rotateto((0, 0, 0), 0.5);
}

use_fridge_trap(param_00, param_01) {
  level.trapcooldownarray["fridge_trap"]++;
  activate_trap_feedback(param_01);
  var_02 = isDefined(param_01) && isplayer(param_01);
  playFX(level._effect["console_spark"], param_00.origin + (0, 0, 20));
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  if(var_02) {
    if(scripts\engine\utility::cointoss()) {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo");
    } else {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("chumtrap_activated", "zmb_comment_vo");
    }
  }

  var_03 = getent(param_00.target, "targetname");
  var_03 thread fridge_door_open();
  wait(1);
  var_03 create_attract_positions((1, 1, 0), -115, 4, 32);
  var_03 thread fridge_lure_enemies();
  var_03 thread fridge_explode(param_01);
  var_03 thread scripts\engine\utility::play_loop_sound_on_entity("zmb_freezer_trap_wind_lp");
  var_03 thread check_if_frost_radius();
  scripts\engine\utility::exploder(33);
  wait(20);
  var_03 thread wind_down_sound();
  wait(4);
  var_03 notify("explode");
  var_03 check_players_fridge_damage_explosion();
  var_03 thread fridge_door_close();
  var_04 = int(90 * level.trapcooldownarray["fridge_trap"]);
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
  level scripts\cp\cp_interaction::interaction_cooldown(param_00, var_04);
}

wind_down_sound() {
  self playSound("zmb_freezer_trap_end");
  self stoploopsound();
}

fridge_lure_enemies() {
  self endon("fridge_death");
  self endon("fridge_explode");
  self.dancers = [];
  var_00 = 22500;
  for(;;) {
    var_01 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_01 = scripts\engine\utility::get_array_of_closest(self.origin, var_01);
    foreach(var_03 in var_01) {
      if(!cp_final_should_be_affected_by_trap(var_03) || var_03.about_to_dance) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_03.is_suicide_bomber)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_03.fridge_trap_marked)) {
        continue;
      }

      if(distancesquared(self.origin, var_03.origin) < var_00) {
        var_03.fridge_trap_marked = 1;
        var_04 = get_closest_attract_position(self, var_03);
        if(isDefined(var_04)) {
          var_03 thread go_to_radio_and_dance(self, var_04);
          var_03 thread release_zombie_on_radio_death(self);
        }
      }
    }

    wait(0.1);
  }
}

go_to_radio_and_dance(param_00, param_01) {
  param_00 endon("fridge_death");
  param_00 endon("fridge_explode");
  self endon("death");
  self endon("turned");
  self.about_to_dance = 1;
  self.scripted_mode = 1;
  self.og_goalradius = self.objective_playermask_showto;
  self.objective_playermask_showto = 32;
  var_02 = param_00.origin - param_01.origin;
  var_03 = vectortoangles(var_02);
  self.desired_dance_angles = (0, var_03[1], 0);
  self give_mp_super_weapon(param_01.origin);
  scripts\engine\utility::waittill_any_3("goal", "goal_reached");
  self.is_dancing = 1;
  param_00.dancers[param_00.dancers.size] = self;
}

release_zombie_on_radio_death(param_00) {
  self endon("death");
  param_00 scripts\engine\utility::waittill_any_3("fridge_explode", "fridge_death");
  if(isDefined(self.og_goalradius)) {
    self.objective_playermask_showto = self.og_goalradius;
  }

  self.og_goalradius = undefined;
  self.about_to_dance = 0;
  self.scripted_mode = 0;
  self.fridge_trap_marked = undefined;
}

fridge_explode(param_00) {
  self waittill("explode");
  self notify("fridge_explode");
  self playSound("zmb_freeze");
  playFX(level._effect["cc_ice_burst"], self.origin);
  physicsexplosionsphere(self.origin, 128, 128, 100);
  var_01 = self.dancers;
  var_02 = 16384;
  foreach(var_04 in var_01) {
    if(distancesquared(var_04.origin, self.origin)) {
      var_04 setvelocity(vectornormalize(var_04.origin - self.origin) * 100 + (0, 0, 50));
      var_04 thread fridge_frozen_damage(self, param_00);
    }
  }

  self notify("fridge_death");
  self notify("death");
}

fridge_frozen_damage(param_00, param_01) {
  level endon("game_ended");
  self endon("death");
  if(is_cryptid()) {
    if(self.agent_type == "alien_goon") {
      self.marked_for_death = 1;
      self.nocorpse = 1;
      self.full_gib = 1;
      self dodamage(self.health + 100, self.origin, scripts\engine\utility::ter_op(isDefined(param_01) && isplayer(param_01), param_01, undefined), param_00, "MOD_EXPLOSIVE", "iw7_fridgetrap_zm");
      playFX(scripts\engine\utility::getfx("zombie_freeze_shatter"), self.origin);
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("chumtrap_killfirm", "zmb_comment_vo");
      return;
    } else {
      return;
    }
  }

  self.marked_for_death = 1;
  self.isfrozen = 1;
  var_02 = self.health;
  self.health = 1;
  if(!scripts\engine\utility::istrue(level.trap_kills_fridge)) {
    level.trap_kills_fridge = 1;
  }

  wait(8);
  if(isDefined(param_01) && isplayer(param_01)) {
    var_03 = param_01;
  } else {
    var_03 = undefined;
  }

  param_01 thread scripts\cp\cp_vo::try_to_play_vo("chumtrap_killfirm", "zmb_comment_vo");
  self dodamage(self.health + 100, self.origin, var_03, param_00, "MOD_EXPLOSIVE", "iw7_fridgetrap_zm");
}

get_closest_attract_position(param_00, param_01) {
  var_02 = sortbydistance(param_00.attract_positions, param_00.origin);
  foreach(var_04 in var_02) {
    if(!var_04.occupied) {
      var_04.occupied = 1;
      thread releaseposonzombiedeath(var_04, param_01, param_00);
      return var_04;
    }
  }

  return undefined;
}

releaseposonzombiedeath(param_00, param_01, param_02) {
  level endon("game_ended");
  param_02 endon("fridge_death");
  param_02 endon("fridge_explode");
  param_01 waittill("death");
  param_00.occupied = 0;
}

create_attract_positions(param_00, param_01, param_02, param_03) {
  self endon("fridge_death");
  self endon("fridge_explode");
  var_04 = -27120;
  var_05 = 0;
  var_06 = 140 / param_02;
  self.attract_positions = [];
  self.occupied_positions = 0;
  self.discotrap_disabled = 0;
  for(var_07 = param_01; var_07 < 140 + param_01; var_07 = var_07 + var_06) {
    var_08 = param_00 * param_03;
    var_09 = (cos(var_07) * var_08[0] - sin(var_07) * var_08[1], sin(var_07) * var_08[0] + cos(var_07) * var_08[1], var_08[2]);
    var_0A = getclosestpointonnavmesh(self.origin + var_09 + (0, 0, 10));
    if(!scripts\cp\loot::is_in_active_volume(var_0A)) {
      continue;
    }

    var_0B = abs(var_0A[2] - self.origin[2]);
    if(isDefined(var_0A) && distancesquared(var_0A, self.origin) > var_04) {
      continue;
    } else {
      if(var_0B < 200) {
        var_0C = spawnStruct();
        var_0C.origin = var_0A;
        var_0C.occupied = 0;
        self.attract_positions[self.attract_positions.size] = var_0C;
        continue;
      }

      var_05++;
    }
  }

  for(var_07 = param_01; var_07 < 140 + param_01; var_07 = var_07 + var_06) {
    var_08 = param_00 * param_03 + 40;
    var_09 = (cos(var_07) * var_08[0] - sin(var_07) * var_08[1], sin(var_07) * var_08[0] + cos(var_07) * var_08[1], var_08[2]);
    var_0A = getclosestpointonnavmesh(self.origin + var_09 + (0, 0, 10));
    if(!scripts\cp\loot::is_in_active_volume(var_0A)) {
      continue;
    }

    var_0B = abs(var_0A[2] - self.origin[2]);
    if(isDefined(var_0A) && distancesquared(var_0A, self.origin) > var_04) {
      continue;
    } else {
      if(var_0B < 200) {
        var_0C = spawnStruct();
        var_0C.origin = var_0A;
        var_0C.occupied = 0;
        self.attract_positions[self.attract_positions.size] = var_0C;
        continue;
      }

      var_05++;
    }
  }

  return var_05;
}

electric_trap_init() {
  level.trapcooldownarray["electric_trap"] = 0;
  var_00 = scripts\engine\utility::getstructarray("electric_trap", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.powered_on = 0;
    var_02 thread listen_for_power();
  }

  level thread elec_trap_sparks();
}

elec_trap_sparks() {
  level endon("electric_trap_part_added");
  var_00 = scripts\engine\utility::getstructarray("electric_trap_sparks", "targetname");
  for(;;) {
    var_01 = scripts\engine\utility::random(var_00).origin;
    playFX(level._effect["elec_trap_sparks"], var_01);
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

electric_trap_use(param_00, param_01) {
  if(!scripts\engine\utility::istrue(param_00.powered_on)) {
    return;
  }

  level.trapcooldownarray["electric_trap"]++;
  var_02 = isDefined(param_01) && isplayer(param_01);
  activate_trap_feedback(param_01);
  var_03 = scripts\engine\utility::getstructarray(param_00.script_noteworthy, "script_noteworthy");
  foreach(var_05 in var_03) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_05);
    var_06 = getent(var_05.target, "targetname");
    var_06 setModel("mp_frag_button_on");
  }

  if(var_02) {
    if(scripts\engine\utility::cointoss()) {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo");
    } else {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("elecwater_activated", "zmb_comment_vo");
    }
  }

  var_08 = spawn("script_origin", (-729, 4873, -85));
  var_09 = spawn("script_origin", (-1031, 4914, -85));
  var_08 thread electric_start_sound();
  var_09 thread electric_start_sound();
  level notify("use_electric_trap");
  scripts\engine\utility::exploder(88);
  level thread electric_trap_damage(param_00, param_01);
  level thread electric_trap_rumble();
  wait(24);
  level notify("stop_electric_trap");
  if(isDefined(param_01) && isplayer(param_01)) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("elecwater_deactivated", "zmb_comment_vo");
  }

  var_0A = int(90 * level.trapcooldownarray["electric_trap"]);
  foreach(var_05 in var_03) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_05);
    level thread scripts\cp\cp_interaction::interaction_cooldown(var_05, var_0A);
  }

  wait(var_0A);
  foreach(var_05 in var_03) {
    var_06 = getent(var_05.target, "targetname");
    var_06 setModel("mp_frag_button_on_green");
  }
}

electric_trap_damage(param_00, param_01) {
  level endon("stop_electric_trap");
  var_02 = gettime();
  var_03 = getent("electric_trap_trig", "targetname");
  for(;;) {
    var_03 waittill("trigger", var_04);
    if(isplayer(var_04) && isalive(var_04) && !scripts\cp\cp_laststand::player_in_laststand(var_04) && !isDefined(var_04.padding_damage)) {
      playfxontagforclients(level._effect["electric_shock_plyr"], var_04, "tag_eye", var_04);
      var_04.padding_damage = 1;
      var_04 dodamage(40, var_03.origin, var_03, var_03, "MOD_UNKNOWN", "iw7_electrotrap_zm");
      var_04 thread remove_padding_damage();
      continue;
    }

    if(var_04 is_cryptid()) {
      if(var_04.agent_type == "alien_phantom" && !scripts\engine\utility::flag("electricphantom_step2")) {
        scripts\engine\utility::flag_set("electricphantom_step2");
        var_05 = var_04.origin;
        var_06 = spawnfx(level._effect["vfx_venmox_spark"], var_05);
        triggerfx(var_06);
        thread killfxaftertime(var_06);
        scripts\engine\utility::exploder(45);
      }

      if(var_04.agent_type == "alien_goon") {
        if(isDefined(param_01) && isplayer(param_01)) {
          param_01 thread scripts\cp\cp_vo::try_to_play_vo("elecwater_killfirm", "zmb_comment_vo");
        }

        thread delayed_cryptid_death(var_04, param_01);
      }

      continue;
    }

    if(scripts\engine\utility::istrue(var_04.is_turned) || !cp_final_should_be_affected_by_trap(var_04, 0, 1)) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_04.electrocuted)) {
      continue;
    }

    level thread electrocute_zombie(var_04, param_01);
  }
}

killfxaftertime(param_00) {
  level endon("game_ended");
  wait(3);
  if(isDefined(param_00)) {
    param_00 delete();
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

electrocute_zombie(param_00, param_01) {
  param_00 endon("death");
  param_00.dontmutilate = 1;
  param_00.electrocuted = 1;
  param_00.marked_for_death = 1;
  wait(randomfloat(3));
  var_02 = scripts\engine\utility::getstructarray("electric_trap_spots", "targetname");
  var_03 = scripts\engine\utility::getclosest(param_00.origin, var_02);
  var_04 = var_03.origin + (0, 0, randomintrange(-17, 17));
  var_05 = param_00.origin + (0, 0, randomintrange(20, 60));
  playfxbetweenpoints(level._effect["electric_trap_attack"], var_04, vectortoangles(var_05 - var_04), var_05);
  playFX(level._effect["electric_trap_shock"], var_05);
  if(scripts\cp\utility::should_be_affected_by_trap(param_00, 1, 0)) {
    param_00 setscriptablepartstate("electrocuted", "on");
  }

  if(isDefined(param_01) && isplayer(param_01) && param_01 scripts\cp\utility::is_valid_player()) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("elecwater_killfirm", "zmb_comment_vo");
    var_06 = param_01;
  } else {
    var_06 = undefined;
  }

  if(!scripts\engine\utility::istrue(level.trap_kills_electric)) {
    level.trap_kills_electric = 1;
  }

  param_00 dodamage(param_00.health + 100, param_00.origin, var_06, var_06, "MOD_UNKNOWN", "iw7_electrotrap_zm");
}

electric_trap_rumble() {
  level endon("stop_electric_trap");
  var_00 = getent("electric_trap_trig", "targetname");
  for(;;) {
    wait(0.2);
    earthquake(0.18, 1, var_00.origin, 784);
    wait(0.05);
    playrumbleonposition("artillery_rumble", var_00.origin);
  }
}

init_rain_trap() {
  level.trapcooldownarray["acid_rain_trap"] = 0;
  var_00 = scripts\engine\utility::getstructarray("acid_rain_trap", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02.powered_on = 0;
    var_02 thread listen_for_power();
  }

  level.ambient_acid_water = [];
  var_04 = scripts\engine\utility::getstructarray("leaking_water_acid", "script_noteworthy");
  foreach(var_06 in var_04) {
    var_07 = spawnfx(scripts\engine\utility::getfx("acid_drip"), var_06.origin);
    level.ambient_acid_water[level.ambient_acid_water.size] = var_07;
    triggerfx(var_07);
  }
}

use_rain_trap(param_00, param_01) {
  level.trapcooldownarray["acid_rain_trap"]++;
  var_02 = isDefined(param_01) && isplayer(param_01);
  activate_trap_feedback(param_01);
  var_03 = scripts\engine\utility::getstructarray(param_00.script_noteworthy, "script_noteworthy");
  foreach(var_05 in var_03) {
    level thread scripts\cp\cp_interaction::remove_from_current_interaction_list(var_05);
    var_06 = getent(var_05.target, "targetname");
    var_06 setModel("mp_frag_button_on");
  }

  if(var_02) {
    activate_trap_feedback(param_01);
  }

  playFX(level._effect["console_spark"], param_00.origin + (0, 0, 40));
  var_08 = scripts\engine\utility::play_loopsound_in_space("zmb_acid_sprinkler_lp_01", (2561.9, 5538.54, 162.494));
  var_09 = scripts\engine\utility::play_loopsound_in_space("zmb_acid_sprinkler_lp_02", (2804.16, 5413.26, 162.494));
  var_0A = scripts\engine\utility::play_loopsound_in_space("zmb_acid_sprinkler_splash_lp_01", (2909.23, 5501.22, 64.1279));
  var_0B = scripts\engine\utility::play_loopsound_in_space("zmb_acid_sprinkler_splash_lp_02", (2479.75, 5430.08, 67.123));
  foreach(var_0D in level.ambient_acid_water) {
    var_0D hide();
  }

  if(var_02) {
    if(scripts\engine\utility::cointoss()) {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo");
    } else {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("acidrain_activated", "zmb_comment_vo");
    }
  }

  scripts\engine\utility::exploder(55);
  level notify("use_rain_trap");
  level thread rain_trap_damage(param_00, param_01);
  wait(24);
  level notify("stop_acid_trap");
  var_08 stoploopsound();
  var_08 delete();
  var_09 stoploopsound();
  var_09 delete();
  var_0A stoploopsound();
  var_0A delete();
  var_0B stoploopsound();
  var_0B delete();
  foreach(var_0D in level.ambient_acid_water) {
    var_0D show();
  }

  if(isDefined(param_01) && isplayer(param_01)) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("acidrain_deactivated", "zmb_comment_vo");
  }

  var_11 = int(90 * level.trapcooldownarray["acid_rain_trap"]);
  foreach(var_05 in var_03) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_05);
    level thread scripts\cp\cp_interaction::interaction_cooldown(var_05, var_11);
  }

  wait(var_11);
  foreach(var_05 in var_03) {
    var_06 = getent(var_05.target, "targetname");
    var_06 setModel("mp_frag_button_on_green");
  }
}

remove_padding_damage_and_rain() {
  remove_padding_damage();
  if(isDefined(self)) {
    stopfxontagforclients(level._effect["sasquatch_rock_hit"], self, "tag_eye", self);
  }
}

rain_trap_damage(param_00, param_01) {
  level endon("stop_acid_trap");
  var_02 = gettime();
  var_03 = getent("acid_trap_trig", "targetname");
  for(;;) {
    var_03 waittill("trigger", var_04);
    if(scripts\engine\utility::istrue(var_04.applyacidraindamage)) {
      continue;
    }

    if(isplayer(var_04)) {
      if(isalive(var_04) && !scripts\cp\cp_laststand::player_in_laststand(var_04) && !isDefined(var_04.padding_damage)) {
        playfxontagforclients(level._effect["sasquatch_rock_hit"], var_04, "tag_eye", var_04);
        var_04.padding_damage = 1;
        var_04 dodamage(40, var_03.origin, var_03, var_03, "MOD_UNKNOWN", "iw7_raintrap_zm");
        var_04 thread remove_padding_damage_and_rain();
        scripts\engine\utility::waitframe();
        continue;
      }

      continue;
    }

    if(scripts\engine\utility::istrue(var_04.is_turned) || !cp_final_should_be_affected_by_trap(var_04, 0, 1)) {
      continue;
    }

    if(var_04 is_crog() || var_04 is_cryptid()) {
      if(var_04.agent_type == "alien_goon") {
        thread delayed_cryptid_death(var_04, param_01);
      }

      continue;
    }

    level thread rain_dmg_zombie(var_04, param_01);
  }
}

delayed_cryptid_death(param_00, param_01) {
  param_00 endon("death");
  wait(randomfloat(0.5));
  param_00.marked_for_death = 1;
  if(isDefined(param_01) && isplayer(param_01)) {
    param_00 dodamage(param_00.health + 100, param_00.origin, param_01, param_01, "MOD_UNKNOWN", "iw7_raintrap_zm");
    return;
  }

  param_00 dodamage(param_00.health + 100, param_00.origin, undefined, undefined, "MOD_UNKNOWN", "iw7_raintrap_zm");
}

rain_dmg_zombie(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  param_00 endon("death");
  param_00.applyacidraindamage = 1;
  param_00.marked_for_death = 1;
  wait(randomfloat(2.5));
  param_00.dontmutilate = 1;
  param_00.nocorpse = 1;
  if(isDefined(param_01) && isplayer(param_01) && param_01 scripts\cp\utility::is_valid_player(1)) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("acidrain_killfirm", "zmb_comment_vo");
    var_02 = param_01;
  } else {
    var_02 = undefined;
  }

  playFX(level._effect["acid_rain_death"], param_00.origin);
  if(!scripts\engine\utility::istrue(level.trap_kills_acidrain)) {
    level.trap_kills_acidrain = 1;
  }

  playsoundatpos(param_00.origin, "gib_fullbody");
  param_00 dodamage(param_00.health + 100, param_00.origin, var_02, var_02, "MOD_UNKNOWN", "iw7_raintrap_zm");
}

listen_for_power() {
  if(scripts\engine\utility::istrue(self.requires_power)) {
    level scripts\engine\utility::waittill_any_3("power_on", "traps_on");
    if(isDefined(self.target)) {
      var_00 = getent(self.target, "targetname");
      if(isDefined(var_00)) {
        if(var_00.model == "mp_frag_button_on") {
          var_00 setModel("mp_frag_button_on_green");
        }
      }
    }

    if(isDefined(self.target_secondary)) {
      var_00 = getent(self.target_secondary, "targetname");
      if(isDefined(var_00)) {
        if(var_00.model == "mp_frag_button_on") {
          var_00 setModel("mp_frag_button_on_green");
        }
      }
    }
  }

  self.powered_on = 1;
}

activate_trap_feedback(param_00) {
  if(isDefined(param_00) && isplayer(param_00)) {
    var_01 = ["fistpump", "fingercrossed", "handboom", "kissfist"];
    var_02 = scripts\engine\utility::random(var_01);
    var_03 = "iw7_" + var_02 + "_zm";
    param_00 thread scripts\cp\utility::usegrenadegesture(param_00, var_03);
  }
}