/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_coverwater.gsc
*****************************************************/

init_coverwater(var_0) {
  if(!isDefined(var_0))
    var_0 = "";

  level.cw_znear_default = getdvar("r_znear");
  level.cw_trigger_volumes = [];
  level.current_audio_zone = maps\_utility::get_audio_zone();
  level.cw_waterwipe_above_playing = 0;
  level.cw_waterwipe_under_playing = 0;
  level.cw_player_in_rising_water = 0;
  level.cw_player_allowed_underwater_time = 15;
  level.cw_player_damage_underwater_time_exceeded = 1;
  level.cw_player_underwater_max_blur = 8;
  level.cw_player_underwater_blur = 1.5;
  level.cw_waterwipe_above = undefined;
  level.cw_waterwipe_under = undefined;
  level.cw_no_waterwipe = 0;
  level.cw_player_drowning_animate = 1;
  common_scripts\utility::flag_init("cw_player_out_of_water");
  common_scripts\utility::flag_init("cw_player_in_water");
  common_scripts\utility::flag_init("cw_player_underwater");
  common_scripts\utility::flag_init("cw_player_abovewater");
  common_scripts\utility::flag_init("cw_player_no_speed_adj");
  common_scripts\utility::flag_init("cw_player_crouch_disabled");
  common_scripts\utility::flag_init("cw_player_make_stand");
  common_scripts\utility::flag_init("underwater_forced_surface");
  level._effect["player_sprint_bokehdots"] = loadfx("vfx/gameplay/screen_effects/scrnfx_water_bokeh_dots_inst_16");
  level._effect["bullet_trail"] = loadfx("fx/water/flooded_underwater_bullet_trail");
  level._effect["scuba_bubbles_breath_player"] = loadfx("fx/water/scuba_bubbles_breath_player");
  level._effect["waterline_under"] = loadfx("vfx/moments/flood/water_waterline_plunge_runner");
  level._effect["waterline_above"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_bokehwater_heavy");
  level._effect["cw_fizzle_flashbang"] = loadfx("fx/water/flooded_body_splash");
  level._effect["underwater_movement"] = loadfx("fx/water/flood_water_wake");
  level._effect["underwater_stop"] = loadfx("fx/water/flood_water_stand");
  level._effect["water_movement"] = loadfx("fx/water/flood_water_wake");
  level._effect["water_stop"] = loadfx("fx/water/flood_water_stand");
  level._effect["water_movement_rising"] = loadfx("fx/water/flood_water_wake_rising");
  level._effect["water_stop_rising"] = loadfx("fx/water/flood_water_stand_rising");
  level._effect["water_movement_player"] = loadfx("fx/water/flood_water_wake");
  level._effect["water_stop_player"] = loadfx("fx/water/flood_water_stand");
  level._effect["sprint_splash"] = loadfx("vfx/moments/flood/flood_ai_water_splash_01");
  level._effect["sprint_splash_rising"] = loadfx("vfx/moments/flood/flood_ai_water_splash_rising_01");
  level._effect["sprint_splash_player"] = loadfx("vfx/gameplay/screen_effects/scrnfx_water_splash_high");
  level._effect["melee_water"] = loadfx("fx/water/flooded_sprint_splash");
  level._effect["water_under_splash"] = loadfx("fx/water/flood_water_wake");
  level._effect["cw_enter_splash_small"] = loadfx("fx/water/flooded_sprint_splash");
  level._effect["cw_enter_splash_big"] = loadfx("fx/water/flooded_body_splash");
  level._effect["scrnfx_water_splash_high"] = loadfx("vfx/gameplay/screen_effects/scrnfx_water_splash_high");
  level._effect["scrnfx_water_splash_low"] = loadfx("vfx/gameplay/screen_effects/scrnfx_water_splash_low");
  level._effect["scrnfx_water_splash_med"] = loadfx("vfx/gameplay/screen_effects/scrnfx_water_splash_med");
  level._effect["cw_water_emerge_weapon"] = loadfx("vfx/moments/flood/flood_water_emerge_weapon");
  level._effect["cw_character_drips"] = loadfx("vfx/moments/flood/flood_character_drips");
  level._effect["cw_player_drips"] = loadfx("vfx/moments/flood/flood_player_drips");
  level._effect["waterline"] = loadfx("vfx/moments/flood/water_waterline_loop_02");
  level._effect["quick_dunk"] = loadfx("vfx/moments/flood/water_waterline_loop_02");
  level._effect["player_water_surface_plunge"] = loadfx("vfx/moments/flood/water_waterline_plunge_runner");
  level._effect["player_water_surface_emerge"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_bokehwater_heavy");
  level._effect["player_water_surface_plunge_fast"] = loadfx("vfx/moments/flood/water_waterline_plunge_runner");
  level._effect["player_water_surface_emerge_fast"] = loadfx("vfx/gameplay/screen_effects/vfx_scrnfx_bokehwater_heavy");
  precacheitem("coverwater_magicbullet_above");
  precacheitem("coverwater_magicbullet_under");
  thread init_waistwater_archetype();
  thread setup_player_view_water_fx_source();
  thread sfx_set_audio_zone_after_deathsdoor();
  thread fizzle_flashbangs_think();
  thread start_coverwater(var_0);
}

register_coverwater_area(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "";

  common_scripts\utility::array_thread(getEntArray(var_0 + "_above", "targetname"), ::water_surface_think, var_1);
  common_scripts\utility::array_thread(getEntArray(var_0 + "_under", "targetname"), ::water_surface_think, var_1);
  var_2 = getent(var_0 + "_trigger", "targetname");
  var_2 thread trigger_volume_think(var_1);
  level.cw_trigger_volumes = common_scripts\utility::array_add(level.cw_trigger_volumes, var_2);
}

flag_checker() {
  for(;;) {
    if(common_scripts\utility::flag("cw_player_in_water"))
      jkuprint("flag getting set!");

    common_scripts\utility::waitframe();
  }
}

start_coverwater(var_0) {
  level endon(var_0);

  for(;;) {
    common_scripts\utility::flag_wait("cw_player_in_water");
    common_scripts\utility::flag_clear("cw_player_out_of_water");
    setsaveddvar("r_znear", 0.7);
    setsaveddvar("cg_enableWaterSurfaceTransitionFx", 1);
    playFXOnTag(common_scripts\utility::getfx("waterline"), level.cw_player_view_water_level_fx_source, "tag_origin");
    thread player_water_height_think(var_0);
    level.player allowprone(0);
    thread player_underwater_think(var_0);
    common_scripts\utility::flag_waitopen("cw_player_in_water");
    common_scripts\utility::flag_set("cw_player_out_of_water");
    setsaveddvar("r_znear", level.cw_znear_default);
    setsaveddvar("cg_enableWaterSurfaceTransitionFx", 0);
    killfxontag(common_scripts\utility::getfx("waterline"), level.cw_player_view_water_level_fx_source, "tag_origin");
    level.cw_player_is_drowning = undefined;
    level.player allowprone(1);
  }
}

player_underwater_think(var_0) {
  level endon(var_0);
  level endon("cw_player_out_of_water");

  for(;;) {
    if(is_player_eye_underwater()) {
      break;
    }

    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_set("cw_player_underwater");
  common_scripts\utility::flag_clear("cw_player_abovewater");
  thread create_player_going_underwater_effects();
  level.deathsdooroverride = "deathsdoor_underwater";

  if(isDefined(level._audio.in_deathsdoor)) {
    maps\_audio::set_deathsdoor();
    level thread maps\flood_audio::sfx_deathsdoor_end_underwater();
  } else if(isDefined(level.swept_away) && level.swept_away == 0)
    level.player setclienttriggeraudiozone("flood_underwater", 0.01);

  thread ai_enemy_tracking("underwater", var_0);
  thread player_breath_timer(var_0);
  thread kill_above_water_fx();
  level.player setwatersheeting(0);

  for(;;) {
    if(!is_player_eye_underwater()) {
      break;
    }

    common_scripts\utility::waitframe();
  }

  common_scripts\utility::flag_set("cw_player_abovewater");
  common_scripts\utility::flag_clear("cw_player_underwater");
  thread create_player_surfacing_effects();
  level.cw_player_is_drowning = undefined;
  thread ai_enemy_tracking("abovewater", var_0);
  player_stop_bubbles();
  level.deathsdooroverride = undefined;

  if(!isDefined(level._audio.in_deathsdoor))
    level.player clearclienttriggeraudiozone(0.01);
  else
    maps\_audio::set_deathsdoor();

  thread player_underwater_think(var_0);
}

player_in_coverwater(var_0) {
  var_0 endon("death");
  level.player endon("death");
  common_scripts\utility::flag_set("cw_player_in_water");
  waittillframeend;
  level.player thread entity_fx_and_anims_think("cw_player_out_of_water", (0, 0, 0));

  while(level.player istouching(var_0))
    common_scripts\utility::waitframe();

  common_scripts\utility::flag_clear("cw_player_in_water");
}

ai_in_coverwater(var_0) {
  var_0 endon("death");
  self endon("death");
  self endon("ai_stop_coverwater");
  self.in_coverwater = 1;
  maps\_utility::ent_flag_set("cw_ai_in_of_coverwater");
  maps\_utility::ent_flag_clear("cw_ai_out_of_coverwater");

  if(isDefined(self.cw_ai_only_stand))
    self.cw_ai_only_stand = self.cw_ai_only_stand;
  else
    self.cw_ai_only_stand = 1;

  if(self.team == "axis") {
    self.cw_previous_grenadeammo = self.grenadeammo;
    self.grenadeammo = 0;
    self.cw_previous_longdeath = self.script_longdeath;
    self.script_longdeath = 0;
  }

  thread entity_fx_and_anims_think("cw_ai_out_of_coverwater", (0, 0, 0));

  while(self istouching(var_0))
    common_scripts\utility::waitframe();

  self.in_coverwater = 0;
  maps\_utility::ent_flag_set("cw_ai_out_of_coverwater");
  maps\_utility::ent_flag_clear("cw_ai_in_of_coverwater");

  if(self.team == "axis") {
    self.grenadeammo = self.cw_previous_grenadeammo;
    self.script_longdeath = self.cw_previous_longdeath;
  }
}

trigger_volume_think(var_0) {
  self endon("death");
  level endon(var_0);

  for(;;) {
    self waittill("trigger", var_1);
    var_2 = getaiarray("axis");
    var_2 = common_scripts\utility::array_combine(var_2, getaiarray("allies"));
    var_2 = common_scripts\utility::array_add(var_2, level.player);
    var_3 = self getistouchingentities(var_2);

    foreach(var_1 in var_3) {
      if(isplayer(var_1)) {
        if(!common_scripts\utility::flag("cw_player_in_water"))
          level.player thread player_in_coverwater(self);

        continue;
      }

      if(!var_1 maps\_utility::ent_flag_exist("cw_ai_in_of_coverwater")) {
        var_1 maps\_utility::ent_flag_init("cw_ai_in_of_coverwater");
        var_1 maps\_utility::ent_flag_init("cw_ai_out_of_coverwater");
        var_1 thread ai_in_coverwater(self);
        continue;
      }

      if(!var_1 maps\_utility::ent_flag("cw_ai_in_of_coverwater"))
        var_1 thread ai_in_coverwater(self);
    }

    common_scripts\utility::waitframe();
  }
}

water_surface_think(var_0) {
  self endon("death");
  level endon(var_0);
  self.health = 1000000;
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    self.health = 1000000;

    if(var_5 == "MOD_MELEE")
      playFX(common_scripts\utility::getfx("melee_water"), var_4);
    else if(var_2.classname != "script_vehicle_nh90") {
      if(getsubstr(self.targetname, self.targetname.size - 5) == "above") {
        var_8 = var_4 - (0, 0, 1);
        var_9 = var_8 + 120 * var_3;

        if(isplayer(var_2))
          magicbullet("coverwater_magicbullet_under", var_8, var_9, level.player);
        else
          magicbullet("coverwater_magicbullet_under", var_8, var_9);

        playFX(common_scripts\utility::getfx("bullet_trail"), var_4, var_3);
      } else {
        var_8 = var_4 + (0, 0, 1);
        var_9 = var_8 + 120 * var_3;

        if(isplayer(var_2))
          magicbullet("coverwater_magicbullet_above", var_8, var_9, level.player);
        else
          magicbullet("coverwater_magicbullet_above", var_8, var_9);

        playFX(common_scripts\utility::getfx("water_under_splash"), var_4 - (0, 0, 1));
      }
    }

    common_scripts\utility::waitframe();
  }
}

player_water_height_think(var_0) {
  level endon(var_0);

  if(!isDefined(level.flood_player_default_jump_height))
    level.flood_player_default_jump_height = getdvarfloat("jump_height");

  var_1 = 40;
  var_2 = 50;

  while(common_scripts\utility::flag("cw_player_in_water")) {
    var_3 = bulletTrace(level.player.origin, level.player getEye(), 0, self);

    if(is_player_eye_underwater()) {
      if(!common_scripts\utility::flag("cw_player_no_speed_adj")) {
        if(isDefined(level.cw_player_is_drowning) && level.cw_player_is_drowning) {
          if(level.cw_player_drowning_damage_count > 10)
            maps\flood_util::player_water_movement(var_1 * 0.5, 0.25);
          else
            maps\flood_util::player_water_movement(var_1 * (1 - level.cw_player_drowning_damage_count * 0.05), 0.25);
        } else
          maps\flood_util::player_water_movement(var_1, 0.25);
      }

      setsaveddvar("jump_height", level.flood_player_default_jump_height * 0.4);
    } else if(var_3["surfacetype"] == "water") {
      var_4 = abs(level.player.origin[2] - var_3["position"][2]);
      var_5 = 100 - var_4 * (var_2 / 48);

      if(var_5 > 100)
        var_5 = 100;
      else if(var_5 < var_2)
        var_5 = var_2;

      var_6 = level.flood_player_default_jump_height * (var_5 * 0.008);
      setsaveddvar("jump_height", var_6);

      if(!common_scripts\utility::flag("cw_player_no_speed_adj"))
        maps\flood_util::player_water_movement(var_5, 0.25);
    }

    wait 0.2;
  }

  setsaveddvar("jump_height", level.flood_player_default_jump_height);

  if(!common_scripts\utility::flag("cw_player_no_speed_adj"))
    maps\flood_util::player_water_movement(100, 0.25);
}

player_surface_blur_think(var_0) {
  level endon(var_0);

  if(!isDefined(level.surface_blur)) {
    level.surface_blur = 1;
    var_1 = 1;

    for(;;) {
      while(common_scripts\utility::flag("cw_player_in_water")) {
        var_2 = level.player getEye();
        var_3 = 1.5;
        var_4 = 25;
        var_5 = bulletTrace(var_2 + (0, 0, var_3 * -1), var_2 + (0, 0, var_3), 0, self);

        if(var_5["surfacetype"] == "water") {
          var_6 = distance(var_5["position"], var_2) * (var_4 / var_3);
          setblur(var_4 - var_6, 0.05);
          var_1 = 0;
        } else if(!var_1) {
          setblur(0, 0.5);
          var_1 = 1;
        }

        common_scripts\utility::waitframe();
      }

      common_scripts\utility::flag_wait("cw_player_in_water");
    }
  }
}

entity_fx_and_anims_think(var_0, var_1, var_2, var_3) {
  level endon(var_0);
  self endon(var_0);
  self endon("death");
  self endon("ai_stop_coverwater");

  if(!isDefined(var_2))
    var_2 = 1;

  var_4 = gettime();

  if(!isplayer(self) && var_2)
    playFX(common_scripts\utility::getfx("cw_enter_splash_small"), self.origin);

  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(self.cw_in_rising_water))
    self.cw_in_rising_water = 0;

  for(;;) {
    if(!isplayer(self) && self.cw_in_rising_water)
      wait(randomfloatrange(0.05, 0.1));
    else
      wait(randomfloatrange(0.15, 0.25));

    var_5 = self.origin;
    var_6 = var_5 + (0, 0, 84);
    var_7 = bulletTrace(var_5, var_6, 0, undefined);

    if(var_7["surfacetype"] != "water") {
      continue;
    }
    var_8 = 36;
    var_9 = var_7["position"][2] - self.origin[2];

    if(!isplayer(self)) {
      if(!self.cw_in_rising_water && var_9 < var_8 && isDefined(self.animarchetype)) {
        self allowedstances("prone", "crouch", "stand");
        maps\_utility::clear_archetype();
        self.maxfaceenemydist = 512;
      }

      if(!self.cw_in_rising_water && var_9 > var_8) {
        if(!isDefined(self.animarchetype) || self.animarchetype != "waist_water") {
          if(self.cw_ai_only_stand)
            self allowedstances("stand");

          self.animarchetype = "waist_water";
          self.maxfaceenemydist = 1024;
        }
      }
    }

    var_10 = "water_movement";

    if(isplayer(self)) {
      if(!common_scripts\utility::flag("cw_player_underwater")) {
        if(distance(self getvelocity(), (0, 0, 0)) < 5)
          var_10 = "water_stop_player";
        else
          var_10 = "water_movement_player";
      }
    } else if(isDefined(level._effect["water_" + self.a.movement])) {
      if(self.cw_in_rising_water)
        var_10 = "water_" + self.a.movement + "_rising";
      else
        var_10 = "water_" + self.a.movement;
    }

    var_11 = common_scripts\utility::getfx(var_10);
    var_5 = var_7["position"] + var_1;

    if(isplayer(self)) {
      if(!common_scripts\utility::flag("cw_player_underwater")) {
        if(self getnormalizedmovement()[0] > 0) {
          var_12 = distance(self getvelocity(), (0, 0, 0));

          if(var_12 > 100) {
            if(gettime() - var_4 > 750) {
              var_4 = gettime();

              if(randomint(3) == 0)
                playFXOnTag(level._effect["scrnfx_water_splash_med"], level.cw_player_view_fx_source, "tag_origin");
              else
                playFXOnTag(level._effect["scrnfx_water_splash_high"], level.cw_player_view_fx_source, "tag_origin");
            }
          } else if(var_12 > 40) {
            if(gettime() - var_4 > 1500) {
              var_4 = gettime();
              playFXOnTag(level._effect["scrnfx_water_splash_low"], level.cw_player_view_fx_source, "tag_origin");
            }
          }
        }
      }
    } else if(self.a.movement == "run") {
      if(isDefined(self.animarchetype) && self.animarchetype != "waist_water" || !isDefined(self.animarchetype)) {
        var_5 = var_5 + 25 * anglesToForward(self.angles);

        if(self.cw_in_rising_water)
          playFX(common_scripts\utility::getfx("sprint_splash_rising"), var_5);
        else
          playFX(common_scripts\utility::getfx("sprint_splash"), var_5);
      }
    }

    if(self.cw_in_rising_water) {
      if(!common_scripts\utility::flag("cw_player_underwater"))
        thread fx_water_surface_floater(var_5, var_11, var_7["entity"], var_0, 0);

      continue;
    }

    if(isplayer(self) && isDefined(level.cw_player_in_rising_water) && level.cw_player_in_rising_water) {
      if(!common_scripts\utility::flag("cw_player_underwater"))
        thread fx_water_surface_floater(var_5, var_11, var_7["entity"], var_0, 0);

      continue;
    }

    var_13 = (0, self.angles[1], 0);
    var_14 = anglesToForward(var_13);
    var_15 = anglestoup(var_13);

    if(self getEye()[2] + 6 - var_9 > 0)
      playFX(var_11, var_5, var_15, var_14);
    else
      playFX(common_scripts\utility::getfx("underwater_movement"), var_5, var_15, var_14);
  }
}

do_wet_fx() {
  var_0 = [];
  var_0[0] = "J_Elbow_LE";
  var_0[1] = "J_Elbow_RI";
  var_0[2] = "J_Wrist_LE";
  var_0[3] = "J_Wrist_RI";
  var_0[4] = "TAG_STOWED_BACK";
  var_0[5] = "J_Neck";

  if(0) {
    if(!isDefined(self.cw_playing_wet_fx))
      self.cw_playing_wet_fx = 0;

    if(!self.cw_playing_wet_fx) {
      jkuprint("playing wet fx");
      self.cw_playing_wet_fx = 1;
    }

    if(self.a.movement == "run") {
      foreach(var_2 in var_0) {
        if(randomint(3) == 0) {
          var_3 = self gettagorigin(var_2) + (randomfloatrange(-2, 2), randomfloatrange(-2, 2), randomfloatrange(-2, 2));
          playFX(common_scripts\utility::getfx("cw_character_drips"), var_3);
        }
      }
    }
  } else {
    if(!isDefined(self.cw_playing_wet_fx))
      self.cw_playing_wet_fx = 0;

    if(self.cw_playing_wet_fx) {
      jkuprint("stopping wet fx");
      self.cw_playing_wet_fx = 0;

      foreach(var_2 in var_0) {
        var_3 = self gettagorigin(var_2) + (randomfloatrange(-2, 2), randomfloatrange(-2, 2), randomfloatrange(-2, 2));
        playFX(common_scripts\utility::getfx("cw_character_drips"), var_3);
      }
    }
  }
}

fx_water_surface_floater(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(!isDefined(var_2) || !isDefined(var_2.classname)) {
    jkuprint("floater returning because of bad ent");
    return;
  }

  var_5 = (0, 0, 2);
  var_6 = spawn("script_model", var_0 + var_5);
  var_6 setModel("tag_origin");
  var_6 hide();
  var_6.angles = (-90, 0, 0);

  if(!isDefined(var_4))
    var_6 linkto(var_2);

  playFXOnTag(var_1, var_6, "tag_origin");
  wait 3;
  var_6 delete();
}

is_player_eye_underwater(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  var_1 = level.player getEye() + (0, 0, var_0);
  var_2 = bulletTrace(var_1, var_1 + (0, 0, 250), 0, self);

  if(var_2["surfacetype"] == "water")
    return 1;
  else if(isDefined(var_2["entity"]) && isDefined(var_2["entity"].script_noteworthy) && var_2["entity"].script_noteworthy == "consider_underwater")
    return 1;
  else
    return 0;
}

create_player_surfacing_effects() {
  thread audio_water_level_logic("emerge");
  level.player setwatersheeting(1, 1.5);
  thread maps\flood_fx::fx_waterdrops_20_inst();
  common_scripts\utility::waitframe();
  thread maps\flood_fx::fx_turn_on_bokehdots_16_player();
  thread maps\_utility::set_blur(0, 0);
  maps\_art::dof_disable_script(0.0);
}

create_player_going_underwater_effects() {
  thread audio_water_level_logic("submerge");
  thread maps\flood_fx::dof_underwater_general();
  thread maps\_utility::set_blur(level.cw_player_underwater_blur, 0);
}

player_do_surfacing_models(var_0) {
  switch (var_0) {
    case "create":
      var_1 = maps\_utility::spawn_anim_model("player_rig");
      var_1 hide();
      break;
    case "kill":
      break;
  }
}

player_breath_timer(var_0) {
  level endon(var_0);
  level endon("cw_player_abovewater");
  level endon("cw_player_out_of_water");
  jkuprint("water: " + level.cw_player_allowed_underwater_time + " allowed.");

  if(level.cw_player_allowed_underwater_time > 1) {
    level thread set_blur_coverwater(var_0);
    level thread maps\flood_audio::sfx_start_heartbeat_countdown();
  }

  wait(level.cw_player_allowed_underwater_time);

  if(level.cw_player_damage_underwater_time_exceeded) {
    thread player_deal_underwater_damage(gettime(), 6000, 20, var_0);
    level thread maps\flood_audio::sfx_start_heartbeat_countdown_lp();
  }

  jkuprint("water: nh!");
  thread audio_underwater_choke();
  thread player_abovewater_defaults();
  delay_with_bubbles(6, 0.5, 1, 0, var_0);
  thread player_do_toolong_fx(var_0);
  level waittill("toolong_exit");
  thread audio_underwater_breath_surfacing();
  cw_player_make_stand();
}

set_blur_coverwater(var_0) {
  level.player endon("death");
  level endon(var_0);
  level endon("cw_player_abovewater");
  level endon("cw_player_out_of_water");
  wait 2;
  jkuprint("starting blur timer");
  maps\_utility::set_blur(level.cw_player_underwater_max_blur, level.cw_player_allowed_underwater_time + 1);
}

player_water_crouch_timer(var_0) {
  common_scripts\utility::flag_set("cw_player_crouch_disabled");
  level endon(var_0);
  level endon("cw_player_out_of_water");
  var_1 = gettime();

  while(gettime() - var_1 < 5000) {
    if(level.player getstance() == "crouch") {
      var_1 = gettime();

      if(!common_scripts\utility::flag("cw_player_make_stand")) {
        common_scripts\utility::flag_set("cw_player_make_stand");
        maps\_utility::delaythread(1, ::cw_player_make_stand);
      }
    }

    wait 0.05;
  }

  common_scripts\utility::flag_clear("cw_player_crouch_disabled");
}

cw_player_make_stand() {
  level.player endon("death");

  while(level.player getstance() != "stand") {
    level.player setstance("stand");
    wait 1;
    player_make_bubbles();
    level.player dodamage(1, level.player.origin);
  }

  common_scripts\utility::flag_clear("cw_player_make_stand");
  jkuprint("water: ms");
}

delay_with_bubbles(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_4);
  level endon("cw_player_abovewater");
  level endon("cw_player_out_of_water");

  for(var_5 = 0; var_5 < var_0; var_5++) {
    if(!var_3)
      player_make_bubbles();

    if(!var_2)
      thread audio_underwater_breath_bubbles();

    wait(var_1);
  }
}

player_do_toolong_fx(var_0) {
  var_1 = getdvarint("cg_fov");
  var_2 = 0.4;
  var_3 = 0.3;
  var_4 = 0.2;
  var_5 = 0.97;
  var_6 = 0.95;
  var_7 = 0.85;
  var_8 = level.cw_player_underwater_max_blur * 1.5;
  var_9 = level.cw_player_underwater_max_blur * 1.5;
  var_10 = level.cw_player_underwater_max_blur * 2.0;
  level.player allowads(0);
  thread delay_with_bubbles(1, 0, 0, 0, var_0);
  thread maps\_utility::set_blur(var_8, var_2);
  level.player thread maps\_utility::lerp_fov_overtime(var_2, var_1 * var_5);
  wait(var_2);
  thread maps\_utility::set_blur(level.cw_player_underwater_blur, var_2);
  level.player thread maps\_utility::lerp_fov_overtime(var_2, var_1);
  wait(var_2);

  if(common_scripts\utility::flag("cw_player_abovewater") || common_scripts\utility::flag("cw_player_out_of_water")) {
    level.player allowads(1);
    level notify("toolong_exit");
    return;
  }

  thread delay_with_bubbles(1, 0, 0, 0, var_0);
  thread maps\_utility::set_blur(var_9, var_3);
  level.player thread maps\_utility::lerp_fov_overtime(var_3, var_1 * var_6);
  wait(var_3);
  thread maps\_utility::set_blur(level.cw_player_underwater_blur, var_3);
  level.player thread maps\_utility::lerp_fov_overtime(var_3, var_1);
  wait(var_3);

  if(common_scripts\utility::flag("cw_player_abovewater") || common_scripts\utility::flag("cw_player_out_of_water")) {
    level.player allowads(1);
    level notify("toolong_exit");
    return;
  }

  for(var_11 = 0; var_11 < 2; var_11++) {
    thread delay_with_bubbles(1, 0, 0, 0, var_0);
    thread maps\_utility::set_blur(var_10, var_4);
    level.player thread maps\_utility::lerp_fov_overtime(var_4, var_1 * var_7);
    wait(var_4);
    thread maps\_utility::set_blur(level.cw_player_underwater_blur, var_4);
    level.player thread maps\_utility::lerp_fov_overtime(var_4, var_1);
    wait(var_4);

    if(common_scripts\utility::flag("cw_player_abovewater") || common_scripts\utility::flag("cw_player_out_of_water")) {
      level.player allowads(1);
      level notify("toolong_exit");
      return;
    }
  }

  level.player allowads(1);
  level notify("toolong_exit");
}

player_make_bubbles() {
  setup_player_view_water_fx_source();
  playFXOnTag(common_scripts\utility::getfx("scuba_bubbles_breath_player"), level.cw_player_view_bubble_source, "tag_origin");
}

player_stop_bubbles() {
  killfxontag(common_scripts\utility::getfx("scuba_bubbles_breath_player"), level.cw_player_view_bubble_source, "tag_origin");
}

player_deal_underwater_damage(var_0, var_1, var_2, var_3) {
  level endon(var_3);
  level endon("cw_player_abovewater");
  level endon("cw_player_out_of_water");
  level.player endon("death");
  level.cw_player_drowning_damage_count = 0;

  switch (maps\_utility::getdifficulty()) {
    case "easy":
      var_2 = 12;
      break;
    case "medium":
      var_2 = 16;
      break;
    case "hard":
      var_2 = 20;
      break;
    case "fu":
      var_2 = 35;
      break;
  }

  for(;;) {
    if(gettime() - var_0 >= var_1) {
      if(!isDefined(level.cw_player_is_drowning) && level.cw_player_drowning_animate)
        thread player_animate_underwater_damage();

      player_make_bubbles();
      level.cw_player_is_drowning = 1;
      level.player dodamage(var_2 / level.player.damagemultiplier, level.player.origin);
      level.cw_player_drowning_damage_count = level.cw_player_drowning_damage_count + 1;
    }

    wait 1;
  }
}

player_animate_underwater_damage() {
  level.player disableweapons();
  wait 0.4;

  while(isDefined(level.cw_player_is_drowning) && level.cw_player_is_drowning)
    common_scripts\utility::waitframe();

  wait 0.4;
  level.player enableweapons();
}

ai_enemy_tracking(var_0, var_1) {
  var_2 = 168;

  switch (var_0) {
    case "underwater":
      var_3 = getaiarray("axis");

      foreach(var_5 in var_3) {
        if(isDefined(var_5.enemy) && var_5.enemy != level.player)
          var_3 = common_scripts\utility::array_remove(var_3, var_5);

        if(!isDefined(var_5.enemy))
          var_3 = common_scripts\utility::array_remove(var_3, var_5);
      }

      if(var_3.size > 0) {
        foreach(var_5 in var_3) {
          if(distance2d(level.player.origin, var_5.origin) < var_2) {
            if(var_5 cansee(level.player)) {
              thread ai_enemy_target_underwater(var_2, 5);
              jkuprint("player underwater but close");
              return;
            }
          }
        }

        thread ai_enemy_target_underwater(var_2, 1);
        return;
      }

      thread player_underwater_set();
      break;
    case "abovewater":
      thread player_abovewater_set();
      break;
  }
}

ai_enemy_target_underwater(var_0, var_1) {
  level endon("cw_player_abovewater");
  level endon("cw_player_out_of_water");
  level.player.attackeraccuracy = 0.1;
  wait(var_1);
  level.player.maxvisibledist = 32;
  level.player thread maps\_utility::set_ignoreme(1);
}

player_underwater_set() {
  level.player.attackeraccuracy = 0.1;
  level.player.maxvisibledist = 32;
  level.player thread maps\_utility::set_ignoreme(1);
}

player_abovewater_set() {
  level endon("cw_player_underwater");
  wait 1;
  thread player_abovewater_defaults();
}

player_abovewater_defaults() {
  level endon("cw_player_underwater");
  level.player.attackeraccuracy = 1;
  level.player.maxvisibledist = 8192;
  level.player maps\_utility::set_ignoreme(0);
}

print_player_speed() {
  for(;;) {
    jkuprint("player max pos speed: " + getdvar("g_speed"));
    var_0 = level.player getvelocity();
    var_1 = distance((var_0[0], var_0[1], 0), (0, 0, 0));
    jkuprint("curr speed: " + var_1);
    wait 1;
  }
}

#using_animtree("generic_human");

init_waistwater_archetype() {
  if(!isDefined(anim.archetypes) || !isDefined(anim.archetypes["waist_water"])) {
    var_0 = [];
    var_1 = [];
    var_2 = [];
    var_3 = [];
    var_4 = [];
    var_1["straight"] = % flood_ai_walk_cqb_f;
    var_1["straight_twitch"] = [ % flood_ai_walk_cqb_f];
    var_1["move_f"] = % flood_ai_walk_cqb_f;
    var_1["move_l"] = % flood_ai_walk_left;
    var_1["move_r"] = % flood_ai_walk_right;
    var_1["move_b"] = % flood_ai_walk_backward;
    var_2["0"] = % flood_ai_cqb_walk_turn_2;
    var_2["1"] = % flood_ai_cqb_walk_turn_1;
    var_2["2"] = % flood_ai_cqb_walk_turn_4;
    var_2["3"] = % flood_ai_cqb_walk_turn_7;
    var_2["5"] = % flood_ai_cqb_walk_turn_9;
    var_2["6"] = % flood_ai_cqb_walk_turn_6;
    var_2["7"] = % flood_ai_cqb_walk_turn_3;
    var_2["8"] = % flood_ai_cqb_walk_turn_2;
    var_3["cover_left_stand"] = [ % corner_standl_painb, %corner_standl_painc];
    var_3["run_long"] = [ % run_pain_leg, %run_pain_shoulder, %run_pain_stomach_stumble, %run_pain_head, %run_pain_stomach, %run_pain_stumble, %run_pain_stomach_fast, %run_pain_leg_fast];
    var_3["run_medium"] = [ % run_pain_stomach, %run_pain_stumble, %run_pain_stomach_fast, %run_pain_leg_fast];
    var_3["run_short"] = [ % run_pain_stumble, %run_pain_stomach_fast];
    var_3["torso_upper"] = [ % exposed_pain_face];
    var_3["head"] = [ % exposed_pain_face];
    var_3["damage_shield_pain_array"] = [ % stand_exposed_extendedpain_hip, %stand_exposed_extendedpain_shoulderswing, %exposed_pain_face, %exposed_pain_groin];
    var_3["default_extended"] = [ % stand_exposed_extendedpain_hip, %stand_exposed_extendedpain_shoulderswing, %exposed_pain_face, %exposed_pain_groin];
    var_3["torso_lower_extended"] = [ % stand_exposed_extendedpain_hip, %stand_exposed_extendedpain_shoulderswing, %exposed_pain_face, %exposed_pain_groin];
    var_3["leg_extended"] = [ % stand_exposed_extendedpain_hip, %stand_exposed_extendedpain_shoulderswing, %exposed_pain_face, %exposed_pain_groin];
    var_3["foot_extended"] = [ % stand_exposed_extendedpain_hip, %stand_exposed_extendedpain_shoulderswing, %exposed_pain_face, %exposed_pain_groin];
    var_3["torso_upper_extended"] = [ % stand_exposed_extendedpain_hip, %stand_exposed_extendedpain_shoulderswing, %exposed_pain_face, %exposed_pain_groin];
    var_3["head_extended"] = [ % stand_exposed_extendedpain_hip, %stand_exposed_extendedpain_shoulderswing, %exposed_pain_face, %exposed_pain_groin];
    var_3["left_arm_extended"] = [ % stand_exposed_extendedpain_hip, %stand_exposed_extendedpain_shoulderswing, %exposed_pain_face, %exposed_pain_groin];
    var_4["running_forward"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %run_death_facedown, %run_death_roll, %run_death_fallonback, %run_death_flop];
    var_4["stand_lower_body"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %exposed_death_groin, %stand_death_leg];
    var_4["stand_lower_body_extended"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %stand_death_crotch, %stand_death_guts];
    var_4["stand_head"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %exposed_death_headshot, %exposed_death_flop];
    var_4["stand_neck"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %exposed_death_neckgrab];
    var_4["stand_left_shoulder"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %exposed_death_twist, %stand_death_shoulder_spin, %stand_death_shoulderback];
    var_4["stand_torso_upper"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %stand_death_tumbleforward, %stand_death_stumbleforward];
    var_4["stand_torso_upper_extended"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %stand_death_fallside];
    var_4["stand_front_head"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %stand_death_face, %stand_death_headshot_slowfall];
    var_4["stand_front_head_extended"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %stand_death_head_straight_back];
    var_4["stand_front_torso"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %stand_death_tumbleback];
    var_4["stand_front_torso_extended"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %stand_death_chest_stunned];
    var_4["stand_back"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %exposed_death_falltoknees, %exposed_death_falltoknees_02];
    var_4["stand_default"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %exposed_death_02, %exposed_death_nerve];
    var_4["stand_default_firing"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %exposed_death_firing_02, %exposed_death_firing];
    var_4["stand_backup_default"] = [ % flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %flood_ai_death_fallback_01, %flood_ai_death_fallfront_01, %exposed_death];
    var_0["cqb_stand"]["reload_crouchhide"] = [ % cqb_stand_reload_steady];
    var_0["grenade"]["cower_squat"] = % exposed_idle_reactb;
    var_0["grenade"]["cower_squat_idle"] = % exposed_idle_twitch_v4;
    var_0["cover_right_stand"]["alert_to_look"] = % flood_ai_corner_standr_alert_2_look;
    var_0["cover_right_stand"]["look_to_alert"] = % flood_ai_corner_standr_look_2_alert;
    var_0["cover_right_stand"]["look_to_alert_fast"] = % flood_ai_corner_standr_look_2_alert_fast;
    var_0["cover_right_stand"]["look_idle"] = % flood_ai_corner_standr_look_idle;
    var_0["cover_left_stand"]["alert_to_look"] = % flood_ai_corner_standl_alert_2_look;
    var_0["cover_left_stand"]["look_to_alert"] = % flood_ai_corner_standl_look_2_alert;
    var_0["cover_left_stand"]["look_to_alert_fast"] = % flood_ai_corner_standl_look_2_alert_fast_v1;
    var_0["cover_left_stand"]["look_idle"] = % flood_ai_corner_standl_look_idle;
    var_0["run"] = var_1;
    var_0["walk"] = var_1;
    var_0["cqb"] = var_1;
    var_0["run_turn"] = var_2;
    var_0["cqb_turn"] = var_2;
    var_0["pain"] = var_3;
    var_0["death"] = var_4;
    maps\_utility::register_archetype("waist_water", var_0);
  }
}

init_waistwater_out_archetype() {
  if(!isDefined(anim.archetypes) || !isDefined(anim.archetypes["waist_water_out"])) {
    var_0 = [];
    var_1 = [];
    var_2 = [];
    var_3 = [];
    var_4["straight"] = % walk_cqb_f;
    var_4["move_f"] = % walk_cqb_f;
    var_4["move_l"] = % walk_left;
    var_4["move_r"] = % walk_right;
    var_4["move_b"] = % walk_backward;
    var_5["straight"] = % run_lowready_f;
    var_5["move_f"] = % walk_forward;
    var_5["move_l"] = % walk_left;
    var_5["move_r"] = % walk_right;
    var_5["move_b"] = % walk_backward;
    var_6["straight"] = % run_cqb_f_search_v1;
    var_6["straight_twitch"] = [ % cqb_run_twitch_c_iw6];
    var_6["move_f"] = % walk_cqb_f;
    var_6["move_l"] = % walk_left;
    var_6["move_r"] = % walk_right;
    var_6["move_b"] = % walk_backward;
    var_7["0"] = % run_turn_180;
    var_7["1"] = % run_turn_l135;
    var_7["2"] = % run_turn_l90;
    var_7["3"] = % run_turn_l45;
    var_7["5"] = % run_turn_r45;
    var_7["6"] = % run_turn_r90;
    var_7["7"] = % run_turn_r135;
    var_7["8"] = % run_turn_180;
    var_8["0"] = % cqb_walk_turn_2;
    var_8["1"] = % cqb_walk_turn_1;
    var_8["2"] = % cqb_walk_turn_4;
    var_8["3"] = % cqb_walk_turn_7;
    var_8["5"] = % cqb_walk_turn_9;
    var_8["6"] = % cqb_walk_turn_6;
    var_8["7"] = % cqb_walk_turn_3;
    var_8["8"] = % cqb_walk_turn_2;
    var_0["cqb_stand"]["reload_crouchhide"] = [ % cqb_stand_reload_knee];
    var_3["cover_left_stand"] = [ % corner_standl_painb, %corner_standl_painc, %corner_standl_paind, %corner_standl_paine];
    var_3["run_long"] = [ % run_pain_leg, %run_pain_shoulder, %run_pain_stomach_stumble, %run_pain_head, %run_pain_fallonknee_02, %run_pain_stomach, %run_pain_stumble, %run_pain_stomach_fast, %run_pain_leg_fast, %run_pain_fall];
    var_3["run_medium"] = [ % run_pain_fallonknee_02, %run_pain_stomach, %run_pain_stumble, %run_pain_stomach_fast, %run_pain_leg_fast, %run_pain_fall];
    var_3["run_short"] = [ % run_pain_fallonknee, %run_pain_fallonknee_03];
    var_3["torso_upper"] = [ % exposed_pain_face, %stand_exposed_extendedpain_neck];
    var_3["head"] = [ % exposed_pain_face, %stand_exposed_extendedpain_neck];
    var_3["damage_shield_pain_array"] = [ % stand_exposed_extendedpain_chest, %stand_exposed_extendedpain_head_2_crouch, %stand_exposed_extendedpain_hip_2_crouch];
    var_3["default_extended"] = [ % stand_extendedpainc, %stand_exposed_extendedpain_chest];
    var_3["torso_lower_extended"] = [ % stand_exposed_extendedpain_gut, %stand_exposed_extendedpain_stomach, %stand_exposed_extendedpain_hip_2_crouch, %stand_exposed_extendedpain_feet_2_crouch, %stand_exposed_extendedpain_stomach];
    var_3["leg_extended"] = [ % stand_exposed_extendedpain_hip_2_crouch, %stand_exposed_extendedpain_feet_2_crouch, %stand_exposed_extendedpain_stomach];
    var_3["foot_extended"] = [ % stand_exposed_extendedpain_feet_2_crouch];
    var_3["torso_upper_extended"] = [ % stand_exposed_extendedpain_gut, %stand_exposed_extendedpain_stomach, %stand_exposed_extendedpain_head_2_crouch];
    var_3["head_extended"] = [ % stand_exposed_extendedpain_head_2_crouch];
    var_3["left_arm_extended"] = [ % stand_exposed_extendedpain_shoulder_2_crouch];
    var_0["grenade"]["cower_squat"] = % exposed_squat_down_grenade_f;
    var_0["grenade"]["cower_squat_idle"] = % exposed_squat_idle_grenade_f;
    var_0["run"] = var_5;
    var_0["walk"] = var_4;
    var_0["cqb"] = var_6;
    var_0["run_turn"] = var_7;
    var_0["cqb_turn"] = var_8;
    var_0["pain"] = var_3;
    maps\_utility::register_archetype("waist_water_out", var_0);
  }
}

setup_player_view_water_fx_source() {
  if(!isDefined(level.cw_player_view_fx_source)) {
    level.cw_player_view_water_level_fx_source = spawn("script_model", (0, 0, 0));
    level.cw_player_view_water_level_fx_source setModel("tag_origin");
    level.cw_player_view_water_level_fx_source linktoplayerviewfollowwatersurface(level.player);
    level.cw_player_view_fx_source = spawn("script_model", (0, 0, 0));
    level.cw_player_view_fx_source setModel("tag_origin");
    level.cw_player_view_fx_source linktoplayerviewattachwatersurfacetransitioneffects(level.player);
    level.cw_player_view_bubble_source = spawn("script_model", level.cw_player_view_fx_source.origin + (10, 0, -60));
    level.cw_player_view_bubble_source setModel("tag_origin");
    level.cw_player_view_bubble_source linkto(level.cw_player_view_fx_source);
  }
}

fx_waterwipe_under() {
  killfxontag(common_scripts\utility::getfx(level.cw_waterwipe_above), level.cw_player_view_fx_source, "tag_origin");
  level.cw_waterwipe_above_playing = 0;

  if(!level.cw_waterwipe_under_playing) {
    level.cw_waterwipe_under_playing = 1;
    playFXOnTag(common_scripts\utility::getfx(level.cw_waterwipe_under), level.cw_player_view_fx_source, "tag_origin");
    wait 0.5;
    level.cw_waterwipe_under_playing = 0;
  }
}

fx_waterwipe_above() {
  killfxontag(common_scripts\utility::getfx(level.cw_waterwipe_under), level.cw_player_view_fx_source, "tag_origin");
  level.cw_waterwipe_under_playing = 0;

  if(!level.cw_waterwipe_above_playing) {
    level.cw_waterwipe_above_playing = 1;
    playFXOnTag(common_scripts\utility::getfx(level.cw_waterwipe_above), level.cw_player_view_fx_source, "tag_origin");
    wait 0.5;
    level.cw_waterwipe_above_playing = 0;
  }
}

kill_above_water_fx() {
  thread maps\flood_fx::fx_create_bokehdots_source();
  killfxontag(common_scripts\utility::getfx("scrnfx_water_splash_med"), level.cw_player_view_fx_source, "tag_origin");
  killfxontag(common_scripts\utility::getfx("scrnfx_water_splash_high"), level.cw_player_view_fx_source, "tag_origin");
  common_scripts\utility::waitframe();
  killfxontag(common_scripts\utility::getfx("scrnfx_water_splash_low"), level.cw_player_view_fx_source, "tag_origin");
  killfxontag(common_scripts\utility::getfx("bokehdots_and_waterdrops_heavy"), level.flood_source_bokehdots, "tag_origin");
  common_scripts\utility::waitframe();
  killfxontag(common_scripts\utility::getfx("waterdrops_20_inst"), level.flood_source_bokehdots, "tag_origin");
  killfxontag(common_scripts\utility::getfx("waterdrops_3"), level.flood_source_bokehdots, "tag_origin");
  common_scripts\utility::waitframe();
  killfxontag(common_scripts\utility::getfx("bokehdots_close"), level.flood_source_bokehdots, "tag_origin");
  killfxontag(common_scripts\utility::getfx("bokehdots_far"), level.flood_source_bokehdots, "tag_origin");
  common_scripts\utility::waitframe();
  killfxontag(common_scripts\utility::getfx("bokehdots_16"), level.flood_source_bokehdots, "tag_origin");
  killfxontag(common_scripts\utility::getfx("bokehdots_64"), level.flood_source_bokehdots, "tag_origin");
}

splash_on_player(var_0) {
  level endon(var_0);
  var_1 = spawn("script_model", (0, 0, 20));
  var_1 setModel("tag_origin");
  var_2 = spawn("script_model", (0, 0, 20));
  var_2 setModel("tag_origin");

  for(;;) {
    if(common_scripts\utility::flag("do_bokehdot")) {
      level.splash_fx = "scrnfx_water_splash_med";
      splash_on_player_choose_location();
      var_1 linktoplayerview(self, level.splash_tag, (level.splash_x, level.splash_y, level.splash_z), level.splash_angles, 1);
      playFXOnTag(common_scripts\utility::getfx(level.splash_fx), var_1, "tag_origin");
      wait(randomfloatrange(0.2, 0.4));
      var_1 unlinkfromplayerview(level.player);
      splash_on_player_choose_location();
      var_2 linktoplayerview(self, level.splash_tag, (level.splash_x, level.splash_y, level.splash_z), level.splash_angles, 1);
      playFXOnTag(common_scripts\utility::getfx(level.splash_fx), var_2, "tag_origin");
      wait(randomfloatrange(0.1, 0.3));
      var_2 unlinkfromplayerview(level.player);
    }

    common_scripts\utility::waitframe();
  }
}

splash_on_player_choose_location() {
  var_0 = randomint(3);

  switch (var_0) {
    case 0:
      if(self getcurrentweapon() == "m9a1") {
        level.splash_tag = "tag_flash";
        level.splash_x = randomfloatrange(-10, -1);
        level.splash_y = randomfloatrange(-0.5, 0.5);
        level.splash_z = randomfloatrange(0.0, 0.5);
        level.splash_angles = (0, 0, 0);
        break;
      } else if(self getcurrentweapon() == "flood_knife") {
        level.splash_tag = "tag_weapon";
        level.splash_x = randomfloatrange(0.5, 9.5);
        level.splash_y = randomfloatrange(-0.5, 0.5);
        level.splash_z = randomfloatrange(-0.5, 0.5);
        level.splash_angles = (90, 0, 0);
        break;
      } else {
        level.splash_tag = "tag_flash";
        level.splash_x = randomfloatrange(-16, -12);
        level.splash_y = randomfloatrange(-0.5, 0.5);
        level.splash_z = randomfloatrange(-10, -2);
        level.splash_angles = (0, 0, 0);
        break;
      }
    case 1:
      level.splash_tag = "j_elbow_le";
      level.splash_x = randomfloatrange(0, 18);
      level.splash_y = randomfloatrange(-1, 1);
      level.splash_z = randomfloatrange(-3, 2);
      level.splash_angles = (90, 0, 0);
      break;
    case 2:
      level.splash_tag = "j_thumb_le_0";
      level.splash_x = randomfloatrange(-2, 2);
      level.splash_y = randomfloatrange(0.5, 1.5);
      level.splash_z = randomfloatrange(-1, 1);
      level.splash_angles = (90, 0, 0);
      break;
  }
}

drip_on_player(var_0) {
  level endon(var_0);
  level endon("cw_player_underwater");

  if(isDefined(level.drip_ent1))
    level.drip_ent1 delete();

  if(isDefined(level.drip_ent2))
    level.drip_ent2 delete();

  level.splash_fx = "cw_player_drips";

  for(var_1 = 0; var_1 < 8; var_1++) {
    drip_on_player_choose_location();
    level.drip_ent1 = spawn("script_model", (0, 0, 20));
    level.drip_ent1 setModel("tag_origin");
    level.drip_ent1 linktoplayerview(self, level.splash_tag, (level.splash_x, level.splash_y, level.splash_z), level.splash_angles, 1);
    playFXOnTag(common_scripts\utility::getfx(level.splash_fx), level.drip_ent1, "tag_origin");
    wait(randomfloatrange(0.25, 0.4));
    level.drip_ent1 delete();
    drip_on_player_choose_location();
    level.drip_ent2 = spawn("script_model", (0, 0, 20));
    level.drip_ent2 setModel("tag_origin");
    level.drip_ent2 linktoplayerview(self, level.splash_tag, (level.splash_x, level.splash_y, level.splash_z), level.splash_angles, 1);
    playFXOnTag(common_scripts\utility::getfx(level.splash_fx), level.drip_ent2, "tag_origin");
    wait(randomfloatrange(0.25, 0.4));
    level.drip_ent2 delete();
  }
}

drip_on_player_choose_location() {
  var_0 = 0;

  switch (var_0) {
    case 0:
      if(self getcurrentweapon() == "m9a1") {
        level.splash_tag = "tag_flash";
        level.splash_x = randomfloatrange(-10, -1);
        level.splash_y = randomfloatrange(-0.5, 0.5);
        level.splash_z = randomfloatrange(0.0, 0.5);
        level.splash_angles = (0, 0, 0);
        break;
      } else if(self getcurrentweapon() == "flood_knife") {
        level.splash_tag = "tag_weapon";
        level.splash_x = randomfloatrange(0.5, 9.5);
        level.splash_y = randomfloatrange(-0.5, 0.5);
        level.splash_z = randomfloatrange(-0.5, 0.5);
        level.splash_angles = (90, 0, 0);
        break;
      } else {
        level.splash_tag = "tag_flash";
        level.splash_x = randomfloatrange(-16, -12);
        level.splash_y = randomfloatrange(-0.5, 0.5);
        level.splash_z = randomfloatrange(-10, -2);
        level.splash_angles = (0, 0, 0);
        break;
      }
    case 1:
      level.splash_tag = "j_elbow_le";
      level.splash_x = randomfloatrange(0, 18);
      level.splash_y = randomfloatrange(-1, 1);
      level.splash_z = randomfloatrange(-3, 2);
      level.splash_angles = (90, 0, 0);
      break;
    case 2:
      level.splash_tag = "j_thumb_le_0";
      level.splash_x = randomfloatrange(-2, 2);
      level.splash_y = randomfloatrange(0.5, 1.5);
      level.splash_z = randomfloatrange(-1, 1);
      level.splash_angles = (90, 0, 0);
      break;
  }
}

audio_underwater_breath_surfacing() {
  wait 0.2;
  level.player playSound("flood_ply_gasp");
  common_scripts\utility::flag_set("underwater_forced_surface");
}

audio_underwater_breath_bubbles() {
  level.player playSound("breath_underwater_bubbles");
}

audio_underwater_choke() {
  if(!isDefined(level.underwater_choke_node)) {
    level.underwater_choke_node = spawn("script_origin", level.player.origin);
    level.underwater_choke_node linkto(level.player);
    level.underwater_choke_node playSound("breath_underwater_choke");
  }
}

audio_stop_choke() {
  if(isDefined(level.underwater_choke_node)) {
    if(!common_scripts\utility::flag("underwater_forced_surface")) {
      level.underwater_choke_node stopsounds();
      wait 0.1;

      if(isDefined(level.underwater_choke_node))
        level.underwater_choke_node delete();
    } else {
      wait 1;

      if(isDefined(level.underwater_choke_node))
        level.underwater_choke_node stopsounds();

      wait 0.1;

      if(isDefined(level.underwater_choke_node))
        level.underwater_choke_node delete();
    }
  }

  common_scripts\utility::flag_clear("underwater_forced_surface");
}

audio_wait_to_delete_water_node(var_0) {
  wait 0.2;

  if(isDefined(var_0))
    var_0 stopsounds();

  wait 0.1;

  if(isDefined(var_0))
    var_0 delete();
}

audio_water_level_logic(var_0) {
  if(var_0 == "submerge") {
    if(isDefined(level.emerge_node))
      thread audio_wait_to_delete_water_node(level.emerge_node);

    level.submerge_node = spawn("script_origin", level.player.origin);
    level.submerge_node playSound("flood_plr_water_submerge_ss", "sounddone");
    level.submerge_node waittill("sounddone");

    if(isDefined(level.submerge_node))
      level.submerge_node delete();
  } else if(var_0 == "emerge") {
    thread audio_stop_choke();

    if(isDefined(level.submerge_node))
      thread audio_wait_to_delete_water_node(level.submerge_node);

    level.emerge_node = spawn("script_origin", level.player.origin);
    level.emerge_node playSound("flood_plr_water_emerge_ss", "sounddone");
    level.emerge_node waittill("sounddone");

    if(isDefined(level.emerge_node))
      level.emerge_node delete();
  }
}

sfx_set_audio_zone_after_deathsdoor() {
  level.player waittill("player_has_red_flashing_overlay");
  waittillframeend;

  for(;;) {
    if(!level.player maps\_utility::ent_flag("player_has_red_flashing_overlay")) {
      if(common_scripts\utility::flag("cw_player_underwater")) {
        break;
      } else
        break;
    }

    wait 0.01;
  }

  thread sfx_set_audio_zone_after_deathsdoor();
}

fizzle_flashbangs_think() {
  if(!isDefined(level.cw_fizzle_flashbangs_thinking)) {
    level.cw_fizzle_flashbangs_thinking = 1;

    for(;;) {
      var_0 = getEntArray("grenade", "classname");

      foreach(var_2 in var_0) {
        if(!isDefined(var_2.fizzle_tracked) && var_2.model == "weapon_twist_flashbang") {
          var_2.fizzle_tracked = 1;
          var_2 thread flashbang_fizzle();
        }
      }

      common_scripts\utility::waitframe();
    }
  }
}

flashbang_fizzle() {
  self endon("death");
  var_0 = gettime();

  while(gettime() - var_0 < 950)
    common_scripts\utility::waitframe();

  foreach(var_2 in level.cw_trigger_volumes) {
    if(self istouching(var_2)) {
      playFX(common_scripts\utility::getfx("cw_fizzle_flashbang"), self.origin);
      self delete();
      break;
    }
  }
}

jkuprint(var_0) {
  if(isDefined(level.jkudebug) && level.jkudebug)
    iprintln(var_0);
}