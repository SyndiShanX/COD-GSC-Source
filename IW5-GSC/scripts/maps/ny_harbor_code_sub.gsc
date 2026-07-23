/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\ny_harbor_code_sub.gsc
***********************************************/

sub_setup() {
  common_scripts\utility::flag_init("barracks_sandman_opening_door");

  if(!common_scripts\utility::flag_exist("barracks_guys_dead")) {
    common_scripts\utility::flag_init("barracks_guys_dead");
  }
  level.sub_doors = [];
  maps\_utility::array_spawn_function_noteworthy("sub_enemy", ::sub_setup_enemy);
  thread setup_music();
  thread setup_sandman();
  thread sub_exterior_ambient();
  thread sub_entrance();
  thread sub_barracks();
  thread sub_reactor_room();
  thread sub_missile_room();
  thread sub_missile_tubes_show();
  thread sub_exit();
  thread remove_sub_pilots();
  thread setup_the_dead();
  thread sub_set_player_speed();
  thread vo_audio();
  thread open_hatch_rear();
  thread watch_water_on();
  thread watch_water_off();
  thread cleanup_after_sub();
  thread manage_external_water_in_sub();
  thread disable_prone_on_back_of_sub();
  silo_interior_visibility(0);
  maps\_utility::player_speed_percent(75);
  level.player allowsprint(1);
  maps\_utility::autosave_by_name("sub_exterior");
}

disable_prone_on_back_of_sub() {
  level endon("ladder_done");

  for(;;) {
    if(common_scripts\utility::flag("sub_disable_prone")) {
      level.player allowprone(0);
      level.player allowcrouch(0);
    } else {
      level.player allowprone(1);
      level.player allowcrouch(1);
    }

    wait 0.05;
  }
}

cleanup_after_sub() {
  common_scripts\utility::flag_wait("player_on_boat");

  foreach(var_1 in level.sub_doors) {}
  var_1 delete();
}

stop_script_anim(var_0, var_1) {
  while(isDefined(self) && self.health >= 30) {
    wait 0.05;

    if(isDefined(var_1) && common_scripts\utility::flag(var_1)) {
      maps\_utility::anim_stopanimscripted();
      common_scripts\utility::flag_clear(var_1);
    }
  }

  if(isDefined(self)) {
    maps\_utility::anim_stopanimscripted();
  }
}

generic_surprise_death(var_0, var_1) {}

remove_sub_pilots() {
  common_scripts\utility::flag_wait("player_surfaces");

  if(isDefined(level.sub_pilots) && level.sub_pilots.size > 0) {
    foreach(var_1 in level.sub_pilots) {}
    var_1 delete();
  }

  if(isDefined(level.sdv_grinch)) {
    level.sdv_grinch delete();
  }
  if(isDefined(level.sdv_sandman)) {
    level.sdv_sandman delete();
  }
}

debug_playerview() {}

npc_through_water(var_0) {
  var_0.origin = var_0.origin + (0, 0, 96);
  thread bobbing_actor(var_0, 0.0);
  level.russian_cine_sub setModel("vehicle_russian_oscar2_sub_breached");
}

catch_notetrack_subswap(var_0, var_1) {
  self waittillmatch("single anim", "subswap");
  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;
  level.breach_sub_scriptnode delete();
  level.breach_sub_scriptnode = undefined;
  level.russian_cine_sub hide();
  var_2 = getEnt("burya2", "targetname");
  var_2 show();
}

catch_notetrack_stopbob() {
  wait 0.05;
  level notify("stop_bob");
}

rockoutside() {
  thread rockingsub();
  thread onoutsideofsub();
}

anim_single_solo_trans(var_0, var_1, var_2, var_3) {
  thread maps\_anim::anim_single_solo(var_0, var_1, var_2);
  var_4 = var_0 maps\_utility::getanim(var_1);
  var_5 = getanimlength(var_4);
  var_0 setflaggedanim("single_anim", var_4, 1.0, var_3, 1.0);
  var_0 maps\_utility::waittill_match_or_timeout("single anim", "end", var_5);
}

sub_breach_move_allies(var_0, var_1) {
  wait 0.05;
  var_2 = var_0 gettagangles("body");
  var_3 = var_1 gettagangles("body");
  var_4 = var_1 gettagorigin("body") - var_0 gettagorigin("body");
  var_5 = var_3 - var_2;

  foreach(var_7 in level.sdvarray) {
    if(var_7 == level.player_sdv) {
      continue;
    }
    var_8 = var_7.origin + var_4;
    var_9 = var_7.angles + var_5;
    var_10 = anglesToForward(var_9);
    var_7 dontinterpolate();
    var_7 vehicle_teleport(var_8, var_9);
    var_7 vehicledriveto(var_8 + 1200 * var_10, 1.0);
    var_7 vehicle_setspeed(level.russian_sub_02 vehicle_getspeed(), 10, 10);
  }
}

sub_breach_open_view() {
  level.player lerpviewangleclamp(1.0, 0.3, 0.3, 15, 0, 15, 0);
  level.player enableslowaim();
}

bobbing_jitter_cleanup(var_0) {
  level waittill("cleanup_bob");
  var_0.bob_ref delete();
  var_0 delete();
}

delete_on_msg(var_0, var_1) {
  level waittill(var_1);

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

bobbing_jitter(var_0, var_1) {
  var_2 = var_0.bob_ref;

  if(!isDefined(var_2)) {
    var_2 = common_scripts\utility::spawn_tag_origin();
  }
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  var_0.bob_ref = var_2;
  var_0.start_origin = var_0.origin;
  level endon("stop_bob");
  var_0 endon("death");
  thread bobbing_jitter_cleanup(var_0);
  var_3 = 12.0;
  var_4 = 0;
  var_5 = 12.0;
  var_6 = 0.5;
  var_7 = 1.5;

  for(;;) {
    var_8 = randomfloatrange(0.0, 1.0);
    var_8 = var_8 * 360;
    var_9 = var_1 * randomfloatrange(0.0, var_3);
    var_10 = var_9 * cos(var_8);
    var_11 = var_9 * cos(var_8);
    var_12 = var_1 * randomfloatrange(var_4, var_5);
    var_13 = randomfloatrange(var_6, var_7);
    var_0.bob_ref moveTo(var_0.start_origin + (var_10, var_11, var_12), var_13, var_13 / 4.0, var_13 / 4.0);
    wait(var_13);
  }
}

bobbing_updown(var_0) {
  var_1 = var_0.bob_ref;

  if(!isDefined(var_1)) {
    var_1 = common_scripts\utility::spawn_tag_origin();
  }
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_0.bob_ref = var_1;
  var_0.start_origin = var_0.origin;
  level endon("stop_bob");
  thread bobbing_jitter_cleanup(var_0);
  return;
}

bobbing_ripple(var_0) {
  level endon("stop_bob");
  var_0 endon("death");
  var_1 = -430;
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = self.origin;
  var_2.angles = (-90, 0, 0);
  thread delete_on_msg(var_2, "stop_bob");
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    var_2.origin = (self.origin[0], self.origin[1], var_0.ref_origin[2] + var_1);

    if(var_3 >= var_4) {
      playFXOnTag(common_scripts\utility::getfx("ocean_ripple"), var_2, "tag_origin");
      var_4 = randomfloatrange(0.25, 0.5);
      var_3 = 0;
    } else {
      var_3 = var_3 + 0.05;
    }
    wait 0.05;
  }
}

bobbing_actor(var_0, var_1) {
  level endon("stop_bob");
  var_0 endon("death");
  var_0.start_origin = var_0.origin;
  var_0.ref_origin = var_0.origin;

  if(var_1 > 0) {
    thread bobbing_jitter(var_0, var_1);
  } else {
    thread bobbing_updown(var_0);
    thread bobbing_ripple(var_0);
  }

  for(;;) {
    var_2 = self.origin;
    var_3 = maps\_ocean::getdisplacementforvertex(level.oceantextures["water_patch"], var_2);
    var_0.ref_origin = var_0.start_origin + (0, 0, var_3);
    var_0.origin = var_0.ref_origin + (var_0.bob_ref.origin - var_0.start_origin);
    wait 0.05;
  }
}

bobbing_ally(var_0, var_1) {
  var_2 = getEnt(var_1, "targetname");
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = var_2.origin - (0, 0, 48);
  var_3.origin = var_2.origin;
  var_3.angles = var_2.angles;
  var_0 show();
  var_0 forceteleport(var_3.origin, var_3.angles);
  var_0 linkTo(var_3, "tag_origin");
  var_0 thread bobbing_actor(var_2, var_3, -6, 0.0);
}

player_surfaces() {
  common_scripts\utility::flag_wait("player_surfaces");
  thread watch_explosions();
  common_scripts\utility::flag_wait("done_watching_explosion");
  wait 1;
  common_scripts\utility::flag_wait("sub_breach_finished");
  level.player unlink();
  level notify("stop_bob");
  level.russian_sub_02 hide();
  level.player enableweapons();
  level.player freezecontrols(0);
  level.player.ignoreme = 0;
  common_scripts\utility::flag_set("get_onto_sub");
}

watch_explosions() {
  common_scripts\utility::flag_wait("submine_detonated");
  wait 1;
  common_scripts\utility::flag_set("done_watching_explosion");
}

fade_in(var_0) {
  if(level.missionfailed) {
    return;
  }
  level notify("now_fade_in");
  var_1 = get_black_overlay();

  if(var_0) {
    var_1 fadeovertime(var_0);
  }
  var_1.alpha = 0;
  wait(var_0);
}

fade_out(var_0) {
  var_1 = get_black_overlay();

  if(var_0) {
    var_1 fadeovertime(var_0);
  }
  var_1.alpha = 1;
  wait(var_0);
}

get_black_overlay() {
  if(!isDefined(level.black_overlay)) {
    level.black_overlay = maps\_hud_util::create_client_overlay("black", 0, level.player);
  }
  level.black_overlay.sort = -1;
  level.black_overlay.foreground = 0;
  return level.black_overlay;
}

hideshowents(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_3 in var_0) {
    if(var_1) {
      var_3 hide();
      var_3.hidden = 1;
      continue;
    }

    var_3 show();
    var_3.hidden = 0;
  }
}

ship2_squeeze_bob() {
  var_0 = getEnt("ship2_squeeze", "targetname");
  var_1 = getEnt("ship_squeeze_ship", "targetname");
  prep_bobbing([var_0], var_1.bobbing_fnc, var_1.bobbing_settings, var_1.bobbing_underwater);
  var_0 thread start_bobbing_single(0);
  common_scripts\utility::flag_wait("ladder_done");
  var_0 no_bobbing();
}

showwater(var_0) {
  var_1 = getEntArray("dyn_water", "script_noteworthy");
  var_2 = getEntArray("stat_water", "script_noteworthy");
  var_3 = getEntArray("dyn_water_sub", "script_noteworthy");
  var_4 = getEntArray("stat_water_sub", "script_noteworthy");
  var_5 = getEntArray("dyn_water_breachpatch_high", "script_noteworthy");
  var_6 = getEntArray("dyn_water_breachpatch_low", "script_noteworthy");
  var_7 = getEntArray("water_flyout", "script_noteworthy");
  var_8 = getEntArray("water_flyout_off", "script_noteworthy");

  switch (var_0) {
    case 0:
      hideshowents(var_3, 0);
      hideshowents(var_4, 1);
      hideshowents(var_5, 1);
      hideshowents(var_6, 0);
      hideshowents(var_1, 1);
      hideshowents(var_2, 0);
      hideshowents(var_7, 1);
      hideshowents(var_8, 0);
      break;
    case 1:
      hideshowents(var_3, 0);
      hideshowents(var_4, 1);
      hideshowents(var_5, 1);
      hideshowents(var_6, 0);
      hideshowents(var_1, 1);
      hideshowents(var_2, 0);
      hideshowents(var_7, 1);
      hideshowents(var_8, 0);
      break;
    case 2:
      hideshowents(var_3, 0);
      hideshowents(var_4, 1);
      hideshowents(var_5, 1);
      hideshowents(var_6, 0);
      hideshowents(var_1, 1);
      hideshowents(var_2, 0);
      hideshowents(var_7, 1);
      hideshowents(var_8, 0);
      break;
    case 3:
      hideshowents(var_3, 1);
      hideshowents(var_4, 1);
      hideshowents(var_5, 1);
      hideshowents(var_6, 1);
      hideshowents(var_1, 1);
      hideshowents(var_2, 1);
      hideshowents(var_7, 0);
      hideshowents(var_8, 1);
      break;
  }
}

bobobjectto(var_0) {
  self endon("stop_bobbing");

  for(;;) {
    if(common_scripts\utility::flag("outside_above_water") || self.bobbing_underwater) {
      var_1 = (self.tgt_values[3], self.tgt_values[4], self.tgt_values[5]);
      var_2 = (self.tgt_values[0], self.tgt_values[1], self.tgt_values[2]);
      self moveTo(var_1, 0.1, 0.0, 0.0);

      if(!var_0) {
        self rotateTo(var_2, 0.1, 0.0, 0.0);
      }
      wait 0.05;
      continue;
    }

    wait 0.2;
  }
}

bobobjectparam(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("stop_bobbing");
  var_7 = randomint(2);
  self.tgt_values[var_0] = var_1;

  for(;;) {
    if(common_scripts\utility::flag("outside_above_water") || self.bobbing_underwater) {
      var_8 = var_1;
      var_9 = var_4;

      switch (var_7) {
        case 0:
          var_8 = var_1 + randomfloat(var_3);
          break;
        case 1:
          if(var_2 < 0) {
            var_8 = var_1 - randomfloat(-1 * var_2);
          } else {
            var_8 = var_1 + randomfloat(var_2);
          }
          break;
      }

      var_9 = randomfloatrange(var_4, var_5);
      var_10 = var_9 / 3.0;
      var_11 = var_9 / 3.0;

      if(var_6) {
        var_12 = 0;

        if(var_0 < 3) {
          var_12 = var_8 - self.angles[var_0];
          var_12 = angleclamp180(var_12);
        }

        switch (var_0) {
          case 0:
            self rotatepitch(var_12, var_9, var_10, var_11);
            break;
          case 1:
            self rotateYaw(var_12, var_9, var_10, var_11);
            break;
          case 2:
            self rotateroll(var_12, var_9, var_10, var_11);
            break;
          case 3:
            self movex(var_8 - self.origin[0], var_9, var_10, var_11);
            break;
          case 4:
            self movey(var_8 - self.origin[1], var_9, var_10, var_11);
            break;
          case 5:
            self movez(var_8 - self.origin[2], var_9, var_10, var_11);
            break;
        }

        wait(var_9);
      } else {
        while(0 < var_9) {
          var_13 = self.tgt_values[var_0];
          var_12 = var_8 - var_13;
          self.tgt_values[var_0] = self.tgt_values[var_0] + 0.05 / var_9 * var_12;
          wait 0.05;
          var_9 = var_9 - 0.05;
        }
      }

      var_7 = 1 - var_7;
      continue;
    }

    wait 0.2;
  }
}

bobbingbuoyangles() {
  self endon("stop_bobbing");
  var_0 = 0.3;
  var_1 = 1.5;
  var_2 = 60.0;
  var_3 = 3.0;
  var_4 = 4.0;
  var_5 = var_0 * var_4;
  var_6 = 0;
  self.org_angles = self.angles;

  if(self.org_angles[0] == 0 && self.org_angles[2] == 0) {
    var_7 = 1;
  } else {
    var_7 = 0;
  }
  var_8 = (0, 0, 0);
  var_9 = 18.0 / var_2;
  var_10 = 0.36 / var_3;

  for(;;) {
    if(common_scripts\utility::flag("outside_above_water") || self.bobbing_underwater) {
      var_11 = calcrockingangles(self.org_angles, var_6, 4.0, 3.0, 60.0);
      var_12 = var_11["angles"];
      var_6 = var_11["result"];
      self rotateTo(var_12, 0.4, 0, 0);
    }

    wait 0.2;
  }
}

bobbingobject(var_0) {
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = 5;
  var_4 = 3;
  var_5 = 6;
  var_6 = 0;
  var_7 = 3;
  var_8 = 6;
  var_9 = 0;
  var_10 = 3;
  var_11 = 6;
  var_12 = 36;
  var_13 = 24;
  var_14 = 3;
  var_15 = 6;
  var_16 = 0;
  var_17 = 3;
  var_18 = 6;
  var_19 = 0;
  var_20 = 3;
  var_21 = 6;
  var_22 = 1;

  if(isDefined(var_0)) {
    if(isDefined(var_0.max_pitch)) {
      var_3 = var_0.max_pitch;
    }
    if(isDefined(var_0.min_pitch_period)) {
      var_4 = var_0.min_pitch_period;
    }
    if(isDefined(var_0.max_pitch_period)) {
      var_5 = var_0.max_pitch_period;
    }
    if(isDefined(var_0.max_yaw)) {
      var_6 = var_0.max_yaw;
    }
    if(isDefined(var_0.min_yaw_period)) {
      var_7 = var_0.min_yaw_period;
    }
    if(isDefined(var_0.max_yaw_period)) {
      var_8 = var_0.max_yaw_period;
    }
    if(isDefined(var_0.max_roll)) {
      var_9 = var_0.max_roll;
    }
    if(isDefined(var_0.min_roll_period)) {
      var_10 = var_0.min_roll_period;
    }
    if(isDefined(var_0.max_roll_period)) {
      var_11 = var_0.max_roll_period;
    }
    if(isDefined(var_0.max_sink)) {
      var_12 = var_0.max_sink;
    }
    if(isDefined(var_0.max_float)) {
      var_13 = var_0.max_float;
    }
    if(isDefined(var_0.min_bob_period)) {
      var_14 = var_0.min_bob_period;
    }
    if(isDefined(var_0.max_bob_period)) {
      var_15 = var_0.max_bob_period;
    }
    if(isDefined(var_0.max_dx)) {
      var_16 = var_0.max_dx;
    }
    if(isDefined(var_0.min_dx_period)) {
      var_17 = var_0.min_dx_period;
    }
    if(isDefined(var_0.max_dx_period)) {
      var_18 = var_0.max_dx_period;
    }
    if(isDefined(var_0.max_dy)) {
      var_19 = var_0.max_dy;
    }
    if(isDefined(var_0.min_dy_period)) {
      var_20 = var_0.min_dy_period;
    }
    if(isDefined(var_0.max_dy_period)) {
      var_21 = var_0.max_dy_period;
    }
    if(isDefined(var_0.oldstyle)) {
      var_22 = var_0.oldstyle;
    }
  }

  self.tgt_values[0] = var_2[0];
  self.tgt_values[1] = var_2[1];
  self.tgt_values[2] = var_2[2];
  self.tgt_values[3] = var_1[0];
  self.tgt_values[4] = var_1[1];
  self.tgt_values[5] = var_1[2];

  if(!var_22) {
    thread bobobjectto(isDefined(var_0.isbuoy));
  }
  if(isDefined(var_0.isbuoy)) {
    thread bobbingbuoyangles();
  } else {
    if(var_3 > 0) {
      thread bobobjectparam(0, var_2[0], 0 - var_3, var_3, var_4, var_5, var_22);
    }
    if(var_6 > 0) {
      thread bobobjectparam(1, var_2[1], 0 - var_6, var_6, var_7, var_8, var_22);
    }
    if(var_9 > 0) {
      thread bobobjectparam(2, var_2[2], 0 - var_9, var_9, var_10, var_11, var_22);
    }
  }

  if(var_16 > 0) {
    thread bobobjectparam(3, var_1[0], 0 - var_16, var_16, var_17, var_18, var_22);
  }
  if(var_19 > 0) {
    thread bobobjectparam(4, var_1[1], 0 - var_19, var_19, var_20, var_21, var_22);
  }
  if(var_13 > 0) {
    thread bobobjectparam(5, var_1[2], 0 - var_12, var_13, var_14, var_15, var_22);
  }
}

smoothvalue(var_0) {
  if(var_0 == 1) {
    var_1 = 1;
  } else {
    var_2 = var_0 * var_0;
    var_1 = 3 * var_2 - 2 * var_2 * var_0;
  }

  return var_1;
}

expensivebobbingobj(var_0) {
  self endon("stop_bobbing");
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = randomfloatrange(3, 10);
  var_4 = 0;
  var_5 = randomintrange(20, 60);
  var_6 = 0;

  for(;;) {
    var_7 = maps\_ocean::getdisplacementforvertex(level.oceantextures["water_patch"], var_1);
    self.origin = (var_1[0], var_1[1], var_1[2] + var_7);
    var_8 = (var_3 - var_4) * smoothvalue(var_6 / var_5) + var_4;
    self.angles = (var_2[0] + var_8, var_2[1], var_2[2]);
    var_6++;

    if(var_6 > var_5) {
      var_4 = var_3;

      if(var_3 > 0) {
        var_3 = -1 * randomfloatrange(3, 10);
      } else {
        var_3 = randomfloatrange(3, 10);
      }
      var_5 = randomintrange(20, 60);
      var_6 = 1;
    }

    wait 0.05;
  }
}

createdefaultbobsettings() {
  var_0 = spawnStruct();
  var_0.max_pitch = 5;
  var_0.min_pitch_period = 3;
  var_0.max_pitch_period = 6;
  var_0.max_yaw = 0;
  var_0.min_yaw_period = 3;
  var_0.max_yaw_period = 6;
  var_0.max_roll = 0;
  var_0.min_roll_period = 3;
  var_0.max_roll_period = 6;
  var_0.max_sink = 36;
  var_0.max_float = 24;
  var_0.min_bob_period = 3;
  var_0.max_bob_period = 6;
  return var_0;
}

createdefaultsmallbobsettings() {
  var_0 = spawnStruct();
  var_0.max_pitch = 10;
  var_0.min_pitch_period = 1;
  var_0.max_pitch_period = 3;
  var_0.max_yaw = 0;
  var_0.min_yaw_period = 3;
  var_0.max_yaw_period = 6;
  var_0.max_roll = 10;
  var_0.min_roll_period = 1;
  var_0.max_roll_period = 3;
  var_0.max_sink = 12;
  var_0.max_float = 12;
  var_0.min_bob_period = 1;
  var_0.max_bob_period = 3;
  var_0.isbuoy = 1;
  return var_0;
}

no_bobbing() {
  self.nobob = 1;
  self notify("stop_bobbing");
}

cleanup_bobbing() {
  self.org_angles = self.angles;
  self.org_origin = self.origin;
  self waittill("stop_bobbing");
  waittillframeend;
  self rotateTo(self.org_angles, 1, 0, 0);
  self moveTo(self.org_origin, 1, 0, 0);
}

start_bobbing_single(var_0) {
  self notify("stop_bobbing");
  self endon("stop_bobbing");
  thread cleanup_bobbing();
  wait(var_0);

  if(isDefined(self.nobob) && self.nobob) {
    return;
  }
  self[[self.bobbing_fnc]](self.bobbing_settings);
}

start_bobbing(var_0) {
  var_1 = 1.0;
  var_2 = 0.0;

  foreach(var_4 in var_0) {
    var_4 thread start_bobbing_single(var_2);
    var_2 = var_2 + 0.05;

    if(var_2 > var_1) {
      var_2 = var_2 - var_1;
    }
  }
}

stop_bobbing(var_0) {
  foreach(var_2 in var_0) {}
  var_2 notify("stop_bobbing");
}

prep_bobbing(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_5.bobbing_fnc = var_1;
    var_5.bobbing_settings = var_2;
    var_5.bobbing_underwater = var_3;
  }
}

setupbobbingships() {
  level.bobbing_objects = [];
  var_0 = createdefaultbobsettings();
  var_1 = getEntArray("bobbing_ship", "script_noteworthy");
  prep_bobbing(var_1, ::bobbingobject, var_0, 0);
  level.bobbing_objects = maps\_shg_common::array_combine_unique(level.bobbing_objects, var_1);
  var_2 = createdefaultbobsettings();
  var_2.max_pitch = 1.0;
  var_3 = getEntArray("bobbing_ship_big", "script_noteworthy");
  prep_bobbing(var_3, ::bobbingobject, var_2, 0);
  level.bobbing_objects = maps\_shg_common::array_combine_unique(level.bobbing_objects, var_3);
  var_4 = createdefaultbobsettings();
  var_4.max_pitch = 2;
  var_5 = getEntArray("sinking_ship", "script_noteworthy");
  prep_bobbing(var_5, ::bobbingobject, var_4, 0);
  level.bobbing_objects = maps\_shg_common::array_combine_unique(level.bobbing_objects, var_5);
  var_6 = createdefaultsmallbobsettings();
  var_7 = getEntArray("bobbing_object", "script_noteworthy");
  prep_bobbing(var_7, ::bobbingobject, var_6, 0);
  level.bobbing_objects = maps\_shg_common::array_combine_unique(level.bobbing_objects, var_7);
  var_8 = createdefaultsmallbobsettings();
  var_9 = getEntArray("bobbing_buoy", "script_noteworthy");
  prep_bobbing(var_9, ::bobbingobject, var_8, 0);
  level.bobbing_objects = maps\_shg_common::array_combine_unique(level.bobbing_objects, var_9);
  var_10 = getEntArray("bobbing_expensive", "script_noteworthy");
  prep_bobbing(var_10, ::expensivebobbingobj, undefined, 0);
  level.bobbing_objects = maps\_shg_common::array_combine_unique(level.bobbing_objects, var_10);
  var_11 = createdefaultbobsettings();
  var_11.max_pitch = 5;
  var_11.min_pitch_period = 3;
  var_11.max_pitch_period = 8;
  var_11.max_yaw = 10;
  var_11.min_yaw_period = 3;
  var_11.max_yaw_period = 8;
  var_11.max_roll = 5;
  var_11.min_roll_period = 3;
  var_11.max_roll_period = 8;
  var_11.max_sink = 12;
  var_11.max_float = 12;
  var_11.min_bob_period = 3;
  var_11.max_bob_period = 8;
  var_11.max_dx = 12;
  var_11.min_dx_period = 3;
  var_11.max_dx_period = 8;
  var_11.max_dy = 12;
  var_11.min_dy_period = 3;
  var_11.max_dy_period = 8;
  var_11.oldstyle = 0;
  var_12 = getEntArray("underwater_mines", "script_noteworthy");
  prep_bobbing(var_12, ::bobbingobject, var_11, 1);
  thread start_bobbing(var_12);
}

initbobbingvolumes() {
  var_0 = getEntArray("bobbing_volume", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2.bobbers = [];

    foreach(var_4 in level.bobbing_objects) {
      if(!isDefined(var_4.bobbing_volume)) {
        if(var_2 istouching(var_4)) {
          var_4.bobbing_volume = var_2;
          var_2.bobbers[var_2.bobbers.size] = var_4;
        }
      }
    }
  }

  level.always_bobbing_objects = [];

  foreach(var_4 in level.bobbing_objects) {
    if(!isDefined(var_4.bobbing_volume)) {
      level.always_bobbing_objects[level.always_bobbing_objects.size] = var_4;
    }
  }
}

activatebobbingobjects() {
  if(isDefined(self.bobbers)) {
    thread start_bobbing(self.bobbers);
  }
}

deactivatebobbingobjects() {
  if(isDefined(self.bobbers)) {
    thread stop_bobbing(self.bobbers);
  }
}

debugbobbingobjects() {
  foreach(var_1 in level.bobbing_objects) {}
  var_1.origin = var_1.origin + (0, 0, 480);
}

controlbobbingvolume(var_0, var_1) {
  var_2 = getEntArray("bobbing_volume", "script_noteworthy");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_parameters) && var_4.script_parameters == var_0) {
      if(var_1) {
        var_4 thread activatebobbingobjects();
        continue;
      }

      var_4 thread deactivatebobbingobjects();
    }
  }
}

stoprocking(var_0) {
  common_scripts\utility::flag_wait("obj_capturesub_complete");
  level notify("stop_rocking");
  level.player playersetgroundreferenceent(undefined);
  self delete();

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

onoutsideofsub() {
  level.rocking_mag[0] = 0.5;
  level.rocking_mag[1] = 1.5;
  common_scripts\utility::flag_set("outside_above_water");
}

oninsideofsub() {
  level.rocking_mag[0] = 1.0;
  level.rocking_mag[1] = 2.5;
  common_scripts\utility::flag_clear("outside_above_water");
}

hide_sub_water() {
  var_0 = getEntArray("rocking_water", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();
}

show_sub_water() {
  var_0 = getEntArray("rocking_water", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();
}

watch_water_on() {
  level endon("player_on_boat");

  for(;;) {
    maps\_utility::trigger_wait_targetname("trig_water_on");
    thread show_sub_water();
    wait 0.05;
  }
}

watch_water_off() {
  level endon("player_on_boat");

  for(;;) {
    maps\_utility::trigger_wait_targetname("trig_water_off");
    thread hide_sub_water();
    wait 0.05;
  }
}

rockingsub() {
  level endon("stop_rocking");
  var_0 = getEnt("rocking_reference", "targetname");
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_2 = undefined;

  if(!isDefined(var_0)) {
    var_1.angles = (0, 0, 0);
  } else {
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
  }

  var_1 thread stoprocking(var_2);
  var_3 = 1;
  level.rocking_mag[0] = 1.0;
  level.rocking_mag[1] = 2.5;
  var_4 = getEntArray("rocking_water", "targetname");
  var_5 = getEntArray("bobbing_small", "script_noteworthy");

  foreach(var_7 in var_5) {
    var_7.start_origin = var_7.origin;
    var_7.start_angles = var_7.angles;
    var_8 = cos(var_7.angles[1]);
    var_9 = sin(var_7.angles[1]);
    var_7.rock_ang = (var_8, 0, var_9);
  }

  if(isDefined(var_2)) {
    foreach(var_7 in var_4) {}
    var_7 linkTo(var_2, "tag_origin");
  }

  thread setup_ent_rockers();
  level.player playersetgroundreferenceent(var_1);
  thread set_grav(var_1);

  for(;;) {
    var_13 = randomfloatrange(2.0, 3.0);
    var_14 = var_3 * randomfloatrange(level.rocking_mag[0], level.rocking_mag[1]);
    var_3 = -1 * var_3;
    var_15 = (0, 0, var_14);
    var_1.targetangles = var_15;
    var_1.targettime = gettime() + 1000 * var_13;
    maps\_audio::aud_send_msg("if_the_sub_is_a_rocking_dont_come_a_knocking");
    var_1 rotateTo(var_15, var_13, var_13 / 3, var_13 / 3);
    thread rock_ents(var_3, var_13, var_13 / 3, var_13 / 3);
    thread rock_debris(var_5, var_15, var_13, var_13 / 3, var_13 / 3);

    if(isDefined(var_2)) {
      var_15 = (0, 0, 0.5 * var_14);
      var_2 rotateTo(var_15, var_13, var_13 / 3, var_13 / 3);
    }

    wait(var_13);
  }
}

set_grav(var_0) {
  level endon("stop_rocking");
  thread reset_grav();
  var_1 = 0;
  var_2 = common_scripts\utility::getStruct("jolter", "targetname");
  common_scripts\utility::flag_wait("hatch_player_using_ladder");

  for(;;) {
    var_3 = anglestoup(var_0.angles);
    var_4 = -1 * var_3;
    var_5 = var_4 * (1, 10, 0.75);
    var_6 = vectorNormalize(var_5);
    setphysicsgravitydir(var_6);
    var_1++;

    if(var_1 > 10) {
      physicsjitter(var_2.origin, 1000, 800, 0.01, 0.1);
      var_1 = 0;
    }

    wait 0.05;
  }
}

reset_grav() {
  level waittill("stop_rocking");
  wait 0.05;
  setphysicsgravitydir((0, 0, -1));
}

setup_ent_rockers() {
  level.rockers = [];
  level.rockers_opp = [];
  level.rocker_hangers = [];
  var_0 = getEntArray("sub_pressuredoor_rocker", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2.target, "targetname");
    var_2 linkTo(var_3);
    level.rockers[level.rockers.size] = var_3;
  }

  var_0 = getEntArray("sub_pressuredoor_rocker_opposite", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2.target, "targetname");
    var_2 linkTo(var_3);
    level.rockers_opp[level.rockers_opp.size] = var_3;
  }

  var_7 = getEntArray("dyn_hanger", "targetname");

  foreach(var_9 in var_7) {
    var_3 = getEnt(var_9.target, "targetname");
    var_9 linkTo(var_3);
    level.rocker_hangers[level.rocker_hangers.size] = var_3;
  }
}

rock_ents(var_0, var_1, var_2, var_3) {
  var_4 = 3 * (level.rocking_mag[1] * var_0);

  foreach(var_6 in level.rockers) {}
  var_6 rotateTo((var_6.angles[0], var_6.angles[1] + var_4, var_6.angles[0]), var_1, var_2, var_3);

  foreach(var_6 in level.rockers_opp) {}
  var_6 rotateTo((var_6.angles[0], var_6.angles[1] + -1 * var_4, var_6.angles[0]), var_1, var_2, var_3);

  foreach(var_6 in level.rocker_hangers) {
    switch (var_6.script_noteworthy) {
      case "x":
        var_6 rotateTo((var_6.angles[0] + var_4, var_6.angles[1], var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "x_neg":
        var_6 rotateTo((var_6.angles[0] + -1 * var_4, var_6.angles[1], var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "y":
        var_6 rotateTo((var_6.angles[0], var_6.angles[1] + var_4, var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "y_neg":
        var_6 rotateTo((var_6.angles[0], var_6.angles[1] + -1 * var_4, var_6.angles[0]), var_1, var_2, var_3);
        break;
      case "z":
        var_6 rotateTo((var_6.angles[0], var_6.angles[1], var_6.angles[0] + var_4), var_1, var_2, var_3);
        break;
      case "z_neg":
        var_6 rotateTo((var_6.angles[0], var_6.angles[1], var_6.angles[0] + -1 * var_4), var_1, var_2, var_3);
        break;
      default:
        break;
    }
  }
}

rock_debris(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (0, 1, 0);
  var_6 = var_1[2];
  var_7 = var_6 / 2.5;

  foreach(var_9 in var_0) {
    var_10 = randomfloatrange(4, 12);
    var_11 = var_9.start_origin + var_10 * var_7 * var_5;
    var_9 moveTo(var_11, var_2, var_3, var_4);
    var_12 = randomfloatrange(3 * level.rocking_mag[0], 3 * level.rocking_mag[1]);
    var_13 = var_12 * var_7;
    var_14 = (var_9.rock_ang[0] * var_13, var_9.rock_ang[1] * var_13, var_9.rock_ang[2] * var_13);
    var_1 = var_9.start_angles + var_14;
    var_9 rotateTo(var_1, var_2, var_3, var_4);
  }
}

silo_interior_visibility(var_0) {
  var_1 = getEntArray("missle_silo_pocket", "target");

  foreach(var_3 in var_1) {
    if(var_0) {
      var_3 show();
      continue;
    }

    var_3 hide();
  }
}

open_missile_hatch(var_0, var_1) {
  var_2 = "missile_hatch_" + var_0 + "_" + var_1;
  var_3 = getEntArray(var_2, "script_noteworthy");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(!isDefined(var_6.targetname)) {
      continue;
    }
    if(var_6.targetname == "missile_hatch") {
      var_4 = var_6;
      break;
    }
  }

  var_4.animname = "missile_hatch";
  var_4 maps\_anim::setanimtree();
  var_8 = common_scripts\utility::spawn_tag_origin();
  var_8.origin = var_4.origin;
  var_8.angles = (270, 0, 0);
  playFXOnTag(common_scripts\utility::getfx("steam_missile_tube"), var_8, "tag_origin");
  var_4 maps\_anim::anim_single_solo(var_4, "open");
  var_9 = randomfloat(3) + 2;
  wait(var_9);
  stopFXOnTag(common_scripts\utility::getfx("steam_missile_tube"), var_8, "tag_origin");
  var_8 delete();
}

open_missile_silo(var_0, var_1) {
  var_2 = "missle_silo_" + var_0 + "_" + var_1;
  var_3 = getEntArray(var_2, "script_noteworthy");
  var_4 = undefined;

  foreach(var_6 in var_3) {
    if(!isDefined(var_6.targetname)) {
      continue;
    }
    if(var_6.targetname == "missile_silo_door") {
      var_4 = var_6;
      break;
    }
  }

  var_8 = undefined;

  foreach(var_6 in var_3) {
    if(!isDefined(var_6.targetname)) {
      continue;
    }
    if(var_6.targetname == var_4.target) {
      var_8 = var_6;
      break;
    }
  }

  var_4.animname = "missile_door";
  var_4 maps\_anim::setanimtree();
  var_8 linkTo(var_4, "door");
  maps\_audio::aud_send_msg("sub_missile_door_open", var_8);

  if(var_0 == "l") {
    common_scripts\utility::exploder(500 + var_1);
  }
  var_4 maps\_anim::anim_single_solo(var_4, "open");
}

wait_to_sequence_missiles() {
  common_scripts\utility::flag_wait("start_opening_missile_doors");
  silo_interior_visibility(1);

  for(var_0 = 0; var_0 < 6; var_0++) {
    var_1 = (5 - var_0) * 0.5 + randomfloatrange(0.0, 0.4);
    maps\_utility::delaythread(0.1 + var_1, ::open_missile_silo, "l", var_0);
    maps\_utility::delaythread(0.3 + var_1, ::open_missile_silo, "r", var_0);
  }

  for(var_0 = 0; var_0 < 9; var_0++) {
    var_1 = (8 - var_0) * 0.5 + randomfloatrange(0.0, 0.4);
    maps\_utility::delaythread(0.7 + var_1, ::open_missile_hatch, "l", var_0);
    maps\_utility::delaythread(1.0 + var_1, ::open_missile_hatch, "r", var_0);
  }

  maps\_utility::delaythread(2.5, ::launch_ssn19, "l", 9);
  maps\_utility::delaythread(3.5, ::launch_ssn19, "l", 7);
  level.zodiac_rumble maps\_utility::delaythread(2.8, maps\_utility::rumble_ramp_to, 0.2, 0.1);
  level.zodiac_rumble maps\_utility::delaythread(4.2, maps\_utility::rumble_ramp_to, 0, 1);
}

play_ssn19fx(var_0) {
  wait 0.95;
  playFXOnTag(common_scripts\utility::getfx("ssn12_launch_smoke12"), self, "tag_tail");
  wait 0.5;
  maps\_utility::ent_flag_waitopen("contrails");
  stopFXOnTag(common_scripts\utility::getfx("ssn12_launch_smoke12"), self, "tag_tail");
}

play_ssn19fx_alt(var_0) {
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("ssn12_launch_smoke"), self, "tag_tail");
  wait 0.5;
  playFXOnTag(common_scripts\utility::getfx("ssn12_init"), self, "tag_tail");
}

open_ssn19_wings() {
  self endon("death");
  wait 0.5;
  self setanim(level.scr_anim["ss_n_12_missile"]["open"], 1, 0);
}

launch_ssn19(var_0, var_1) {
  var_2 = "ssn19_" + var_0 + "_" + var_1;
  var_3 = maps\_vehicle::spawn_vehicle_from_targetname(var_2);
  var_3.animname = "ss_n_12_missile";
  var_3 maps\_anim::setanimtree();
  var_3 setanim(var_3 maps\_utility::getanim("close_idle"), 1, 0);
  var_3.script_vehicle_selfremove = 1;
  var_3 thread play_ssn19fx(var_2);
  maps\_audio::aud_send_msg("sub_missile_launch", var_3);
  wait 0.75;
  var_3 thread open_ssn19_wings();
  thread maps\_vehicle::gopath(var_3);
}

sub_give_player_weapon() {
  level.player enableweapons();
}

setup_sandman() {
  level.sandman.ignoreall = 0;
  level.sandman.awareness = 1;
  level.sandman maps\_utility::enable_ai_color();
  level.sandman maps\_utility::disable_surprise();
}

setup_music() {
  thread setup_music_before_door_breach();
  common_scripts\utility::flag_wait("ladder_done");
  maps\_audio::aud_send_msg("mus_enter_sub");
  common_scripts\utility::flag_wait("barracks_sandman_opening_door");
  maps\_audio::aud_send_msg("mus_sub_combat_begin");
  common_scripts\utility::flag_wait("reactor_room_announcement");
  maps\_audio::aud_send_msg("mus_sub_scuttle_announcement");
  wait 3;
  maps\_audio::aud_send_msg("aud_scuttle_alarms_start");
}

setup_music_before_door_breach() {
  common_scripts\utility::flag_wait("door_blown");
  maps\_audio::aud_send_msg("mus_sub_door_breach");
  common_scripts\utility::flag_wait("breach_done");
  maps\_audio::aud_send_msg("mus_sub_combat_end");
  common_scripts\utility::flag_wait("vo_sandman_checkpointneptune");
  maps\_audio::aud_send_msg("mus_program_launch");
}

vo_audio() {
  thread maps\ny_harbor_code_vo::vo_sub_exterior();
  thread maps\ny_harbor_code_vo::vo_sub_exterior_allies();
  thread maps\ny_harbor_code_vo::vo_sub_interior_engine_room();
  thread maps\ny_harbor_code_vo::sandman_exit_nag_vo();
  thread maps\ny_harbor_code_vo::vo_sub_interior_reactor();
  thread maps\ny_harbor_code_vo::vo_sub_interior_missile_room_1();
  thread maps\ny_harbor_code_vo::vo_sub_interior_missile_room_2();
}

sub_missile_tubes_hide() {
  var_0 = getEntArray("missile_hatch", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();

  var_0 = getEntArray("missile_silo", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();

  var_0 = getEntArray("missle_silo_pocket_middle", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();

  var_0 = getEntArray("missile_silo_door", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();

  var_0 = getEntArray("missle_silo_pocket", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();

  var_0 = getEntArray("missle_silo_pocket_rear", "targetname");

  foreach(var_2 in var_0) {}
  var_2 hide();
}

sub_missile_tubes_show() {
  common_scripts\utility::flag_wait("vo_bridge_is_done");
  var_0 = getEntArray("missile_hatch", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();

  var_0 = getEntArray("missile_silo", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();

  var_0 = getEntArray("missle_silo_pocket_middle", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();

  var_0 = getEntArray("missile_silo_door", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();

  var_0 = getEntArray("missle_silo_pocket", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();

  var_0 = getEntArray("missle_silo_pocket_rear", "targetname");

  foreach(var_2 in var_0) {}
  var_2 show();
}

setup_the_dead() {
  common_scripts\utility::flag_wait("sub_entering");
  var_0 = getEnt("sub_spawner_for_dead1", "targetname");
  var_1 = getEntArray("sub_dead_and_dying_loops", "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_0 maps\_utility::spawn_ai(1);
    wait 0.05;
    var_4 maps\_utility::gun_remove();
    var_4 dummy_keep_pose(var_3, var_3.animation);
  }
}

sub_setup_enemy() {
  maps\_utility::disable_long_death();
  maps\_utility::disable_surprise();
  self.grenadeammo = 0;

  if(isDefined(self.script_parameters)) {
    thread sub_enemy_vo();
  }
}

sub_enemy_vo() {
  var_0 = "";
  var_1 = "";

  switch (self.script_parameters) {
    case "extinguisher":
      self.animname = "extinguisher";
      var_0 = "nyharbor_ru1_extinguisher";
      var_1 = "vo_extinguisher";
      break;
    case "reactor":
      self.animname = "reactor";
      var_0 = "nyharbor_ru2_reactorroom";
      var_1 = "vo_reactor";
      break;
    case "stairs":
      self.animname = "stairs";
      var_0 = "nyharbor_ru3_rushthem";
      var_1 = "vo_stairs";
      break;
    case "missile_1":
      self.animname = "missile_1";
      var_0 = "nyharbor_ru3_intruders";
      var_1 = "missile_room_1_vo";
      break;
    case "missile_2":
      self.animname = "missile_2";
      var_0 = "nyharbor_ru3_fireyourweapon";
      var_1 = "vo_missile_room_2";
      break;
    case "missile_3":
      self.animname = "missile_3";
      var_0 = "nyharbor_ru3_outofammo";
      var_1 = "vo_missile_room_3";
      break;
  }

  thread sub_enemy_play_vo(var_1, var_0);
}

sub_enemy_play_vo(var_0, var_1) {
  self endon("death");
  common_scripts\utility::flag_wait(var_0);
  maps\_utility::dialogue_queue(var_1);
}

sub_exterior_ambient() {
  thread sub_exterior_helicopters();
}

sub_exterior_helicopters() {
  level.sub_exterior_hinds = [];
  common_scripts\utility::flag_wait("ready_for_player_slide");
  wait 15;
  var_0 = 0;

  if(!common_scripts\utility::flag("hatch_player_using_ladder")) {
    var_1 = getEnt("sub_exterior_hind_kill_player", "targetname");
    var_2 = var_1 maps\_vehicle::spawn_vehicle_and_gopath();
    maps\_audio::aud_send_msg("hind_player_killer", var_2);
    var_2 setmaxpitchroll(10, 50);
    level notify("sub_exterior_chopper_spawned", var_2);
    common_scripts\utility::flag_wait("sub_exterior_hind_kill_player_fire");

    while(!common_scripts\utility::flag("hatch_player_using_ladder")) {
      if(var_0 > 2) {
        level.player kill();
      }
      var_2 sub_exterior_heli_fire_turret(level.player, 50, 0.05);
      var_0++;
      wait 5;
    }

    var_2 delete();
  }
}

sub_exterior_fire_at_hinds() {
  common_scripts\utility::flag_wait("sub_exterior_hind_1_fire");
  var_0 = common_scripts\utility::getStructArray("sub_exterior_fire_at_hind", "targetname");
  var_1 = gettime() + 10000;

  while(var_1 > gettime()) {
    if(level.sub_exterior_hinds.size < 1) {
      break;
    }

    var_2 = common_scripts\utility::random(var_0);
    var_3 = common_scripts\utility::random(level.sub_exterior_hinds);
    magicbullet("rpg", var_2.origin, var_3.origin);
    wait(randomfloatrange(1, 2));
  }
}

sub_exterior_chinook() {
  self endon("death");
  maps\_audio::aud_send_msg("chinook_spawned", self);
  self.animname = "ch46e";
  maps\_anim::setanimtree();
  var_0 = maps\_utility::getanim("rotors");
  var_1 = getanimlength(var_0);

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    self setanim(var_0);
    wait(var_1);
  }
}

sub_exterior_helicopter_add_as_target() {
  level.sub_exterior_hinds[level.sub_exterior_hinds.size] = self;
  self waittill("death");
  level.sub_exterior_hinds = common_scripts\utility::array_remove(level.sub_exterior_hinds, self);
}

sub_exterior_helicopter_fire_turret() {
  maps\_audio::aud_send_msg("hind_spawned", self);
  var_0 = self.script_noteworthy;
  self endon("death");
  common_scripts\utility::flag_wait(var_0 + "_fire");
  var_1 = common_scripts\utility::getStruct(var_0 + "_target", "targetname");
  sub_exterior_heli_fire_turret(var_1, 75, 0.1);
}

sub_exterior_heli_fire_turret(var_0, var_1, var_2) {
  self endon("death");

  if(isDefined(self.defaultweapon)) {
    var_3 = self.defaultweapon;
  } else {
    var_3 = "hind_turret";
  }
  var_4 = "hind_turret";
  var_5 = undefined;
  var_6 = [];
  self setvehweapon(var_3);

  if(!isDefined(var_1)) {
    var_1 = 1;
  }
  if(!isDefined(var_2)) {
    var_2 = 1;
  }
  var_7 = var_0;
  var_8 = undefined;
  var_9 = undefined;

  if(!isDefined(var_0.classname)) {
    var_10 = spawn("script_origin", var_0.origin);
    thread common_scripts\utility::delete_on_death(var_10);
    var_10.targetname = var_0.targetname;
    var_10.origin = var_0.origin;
    var_7 = var_10;
  }

  if(isDefined(var_0.target)) {
    if(!isDefined(var_0.classname)) {
      var_11 = common_scripts\utility::getStruct(var_0.target, "targetname");
      var_12 = distance(var_0.origin, var_11.origin);
      var_13 = vectortoangles(var_11.origin - var_0.origin);
      var_9 = anglesToForward(var_13);
      var_8 = var_12 / var_1;
    }
  }

  self setturrettargetEnt(var_7);

  for(var_14 = 0; var_14 < var_1; var_14++) {
    self fireweapon("tag_flash", var_7);
    wait(var_2);

    if(isDefined(var_8) && isDefined(var_9)) {
      var_7.origin = var_7.origin + var_9 * var_8;
    }
  }

  self setvehweapon(var_3);
}

sub_entrance() {
  thread hatch_sandman_drop_frag();
  thread hatch_player_slide();
  common_scripts\utility::flag_wait("sub_entrance_gameplay");
  thread open_hatch();
  thread hatch_enemies();
  thread maps/ny_harbor_fx::surface_sub_hatch_moment();
}

hatch_enemies() {
  level.hatch_enemies_dead = 0;
  var_0 = getEntArray("hatch_enemy", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_utility::add_spawn_function, ::setup_hatch_enemy);
  maps\_utility::array_spawn(var_0, 1);
}

setup_hatch_enemy() {
  self endon("death");
  thread hatch_enemy_monitor_death();
  self.goalradius = 8;
  self.noragdoll = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self waittill("goal");
  wait 1;
  self.ignoreme = 0;
  self.ignoreall = 0;
}

sandman_kill(var_0) {
  playFXOnTag(common_scripts\utility::getfx("flesh_hit"), var_0, "j_head");
}

hatch_enemy(var_0, var_1, var_2, var_3) {
  var_4 = getEnt(var_1, "targetname");
  var_5 = var_4 maps\_utility::spawn_ai(1);
  maps\_utility::spawn_failed();

  if(isDefined(var_3) && var_3) {
    var_5 maps\_utility::magic_bullet_shield();
    var_5 thread ignore_until_done(var_0, var_2);
    var_5 thread hatch_enemy_monitor_death();
    var_5.allowdeath = 1;
    var_5.noragdoll = 1;
    var_0 maps\_anim::anim_generic(var_5, var_2);

    if(isDefined(var_5) && isalive(var_5)) {
      var_5 maps\_utility::stop_magic_bullet_shield();
      var_5 kill_no_react();
    }
  } else {
    var_5.goalradius = 8;
    var_5 maps\_utility::magic_bullet_shield();
    var_5 thread hatch_enemy_monitor_death();
    var_5.allowdeath = 1;
    var_5.noragdoll = 1;
    var_5 maps\_utility::delaythread(3.5, maps\_utility::stop_magic_bullet_shield);
    var_0 maps\_anim::anim_generic(var_5, var_2);
  }
}

ignore_until_done(var_0, var_1) {
  self.ignoreme = 1;
  self endon("death");
  var_0 waittill(var_1);
  wait 1;
  self.ignoreme = 0;
}

hatch_enemy_monitor_death() {
  self waittill("death");
  level.hatch_enemies_dead++;

  if(level.hatch_enemies_dead > 1) {
    common_scripts\utility::flag_set("hatch_enemies_dead");
  }
}

open_hatch() {
  var_0 = getEnt("hatch_component1", "targetname");
  var_1 = getEnt("hatch_component2", "targetname");
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_3 = getEnt("hatch_org", "targetname");
  var_2.origin = var_3.origin;
  var_2.angles = var_3.angles;

  if(isDefined(var_0)) {
    var_0 hide();
    var_0 linkTo(var_2, "tag_origin");
  }

  var_1 linkTo(var_2, "tag_origin");
  common_scripts\utility::flag_set("vo_hatch_open");
  var_2 rotateTo((154, 0, 180), 0.05);
}

open_hatch_rear() {
  var_0 = getEnt("rear_hatch_col", "targetname");
  var_0 notsolid();
  common_scripts\utility::flag_wait("sub_control_room_sandman_exit");
  var_1 = getEnt("rear_hatch_component1", "targetname");
  var_2 = getEnt("rear_hatch_component2", "targetname");
  var_3 = common_scripts\utility::spawn_tag_origin();
  var_4 = getEnt("rear_hatch_org", "targetname");
  var_3.origin = var_4.origin;
  var_3.angles = var_4.angles;

  if(isDefined(var_1)) {
    var_1 hide();
    var_1 linkTo(var_3, "tag_origin");
  }

  var_2 linkTo(var_3, "tag_origin");
  var_3 rotateTo((150, var_3.angles[1], var_3.angles[2]), 0.05);
  var_0 solid();
  var_5 = getEnt("rear_hatch_col_interior", "targetname");
  var_5 notsolid();
  var_6 = getEnt("rear_hatch_col_top", "targetname");
  var_6 notsolid();
}

hatch_sandman_drop_frag() {
  thread setup_frag();
  maps\_anim::addnotetrack_customfunction(level.sandman.animname, "show", ::show_frag, "ny_harbor_sandman_drops_frag_inhatch");

  if(!common_scripts\utility::flag_exist("hatch_enemies_dead")) {
    common_scripts\utility::flag_init("hatch_enemies_dead");
  }
  common_scripts\utility::flag_wait("hatch_enemies_dead");
  maps\_audio::aud_send_msg("aud_prime_sandman_grenade_anim");
  level.sandman maps\_utility::enable_surprise();
  var_0 = common_scripts\utility::getStruct("hatch_sandman_drop_frag_anim_ent", "targetname");
  level.sandman maps\_utility::disable_ai_color();
  var_0 maps\_anim::anim_reach_solo(level.sandman, "ny_harbor_sandman_drops_frag_inhatch");
  maps\_audio::aud_send_msg("aud_start_sandman_grenade_anim");
  thread entrance_vo_timing();
  maps\_utility::delaythread(11, ::flag_set_wrapper, "ready_for_player_slide");
  maps\_utility::delaythread(3, ::hide_grenade);
  var_0 maps\_anim::anim_single_solo(level.sandman, "ny_harbor_sandman_drops_frag_inhatch");
  level.sandman maps\_utility::enable_ai_color_dontmove();
}

smartlasersystem() {
  self endon("disable_smart_laser");

  for(;;) {
    if(self.isreloading || self.a.state == "cover" && (self.a.special == "cover_left" || self.a.special == "cover_right")) {
      self laserforceoff();
    } else {
      self laserforceon();
    }
    wait 0.05;
  }
}

hide_grenade() {
  level.frag delete();
}

flag_set_wrapper(var_0) {
  common_scripts\utility::flag_set(var_0);
}

setup_frag() {
  level.frag = getEnt("frag_grenade", "targetname");
  level.frag hide();
  var_0 = level.sandman gettagorigin("tag_inhand");
  var_1 = level.sandman gettagangles("tag_inhand");
  level.frag.origin = var_0;
  level.frag.angles = var_1;
  level.frag linkTo(level.sandman, "tag_inhand");
}

show_frag(var_0) {
  level.frag show();
}

hatch_player_slide() {
  maps\_audio::aud_send_msg("aud_prime_player_downladder");
  var_0 = getEnt("hatch_player_slide", "targetname");
  var_0 setHintString(&"NY_HARBOR_HINT_USE_TO_ENTER");
  var_0 useTriggerRequireLookAt();
  var_0 waittill("trigger");
  var_0 common_scripts\utility::trigger_off();
  level.player disableweapons();
  level.player freezecontrols(1);
  maps\_shg_common::setupplayerforanimations();
  level.sdv_player_arms hide();
  common_scripts\utility::flag_set("hatch_player_using_ladder");
  maps\_audio::aud_send_msg("aud_player_downladder");
  var_1 = common_scripts\utility::getStruct("hatch_player_slide_anim_pos", "targetname");
  var_2 = common_scripts\utility::spawn_tag_origin();
  var_2.origin = var_1.origin;
  var_2.angles = var_1.angles;
  level.player playerlinktoblend(level.sdv_player_arms, "tag_player", 0.2);
  level.sdv_player_arms dontcastshadows();
  level.sdv_player_arms common_scripts\utility::delaycall(0.3, ::show);
  level maps\_utility::delaythread(3.6, ::remove_hatch_corpses);
  var_2 maps\_anim::anim_single_solo(level.sdv_player_arms, "player_ladder_slide");
  level.sdv_player_arms hide();
  level.player freezecontrols(0);
  level.player unlink();
  level.player enableweapons();
  maps\_shg_common::setupplayerforgameplay();
  common_scripts\utility::flag_set("ladder_done");
  thread oninsideofsub();
}

remove_hatch_corpses() {
  clearallcorpses();
}

entrance_vo_timing() {
  wait 2;
  common_scripts\utility::flag_set("vo_frag_out");
  wait 5;
  common_scripts\utility::flag_set("vo_frag_out_clear");
}

sub_extra_spawn(var_0) {
  if(!isDefined(var_0)) {
    common_scripts\utility::flag_wait("sub_breach_finished");
  }
  maps\_utility::array_spawn_function_targetname("submarine_extra_friends", ::sub_extra_friendly);
  maps\_utility::array_spawn_function_targetname("submarine_extra_enemy", ::sub_extra_enemy);
  maps\_utility::array_spawn_targetname("submarine_extra_friends");
  maps\_utility::array_spawn_targetname("submarine_extra_enemy");
}

sub_extra_friendly() {
  self endon("death");
  self.noreload = 1;
  self.noragdoll = 1;
  self.grenadeammo = 0;
  maps\_utility::magic_bullet_shield();
  maps\_utility::disable_surprise();
  maps\_utility::disable_bulletwhizbyreaction();
  self.disablefriendlyfirereaction = 1;
  self.baseaccuracy = 10;
  self.accuracy = 1;

  if(isDefined(self.script_friendname) && self.script_friendname == "Grinch") {
    level.sub_grinch = self;
    level.sub_grinch.animname = "sub_grinch";
  }

  if(isDefined(self.script_friendname) && self.script_friendname == "Truck") {
    level.sub_truck = self;
    level.sub_truck.animname = "sub_truck";
  }

  thread sub_friendly_shoot_chopper();

  if(isDefined(self.script_godmode)) {
    self setCanDamage(0);
  }
  if(!common_scripts\utility::flag_exist("hatch_enemies_dead")) {
    common_scripts\utility::flag_init("hatch_enemies_dead");
  }
  common_scripts\utility::flag_wait("hatch_enemies_dead");
  self.ignoresuppression = 1;

  while(self.baseaccuracy < 50) {
    if(common_scripts\utility::flag("ladder_done")) {
      break;
    }

    self.baseaccuracy = self.baseaccuracy + 1;
    wait 0.5;
  }

  common_scripts\utility::flag_wait("ladder_done");

  if(isDefined(self.magic_bullet_shield)) {
    maps\_utility::stop_magic_bullet_shield();
  }
  self delete();
}

sub_friendly_shoot_chopper() {
  self endon("death");
  level waittill("sub_exterior_chopper_spawned", var_0);
  wait 8;
  maps\_utility::stop_magic_bullet_shield();
  self setentitytarget(var_0);
}

sub_extra_enemy() {
  self endon("death");
  self.script_noteworthy = undefined;
  self.health = 3;
  maps\_utility::disable_bulletwhizbyreaction();
  var_0 = ["body_russian_naval_assault_g", "body_russian_naval_assault_gg", "body_russian_naval_assault_h"];
  self setModel(var_0[randomint(var_0.size)]);
  self.noragdoll = 1;
  common_scripts\utility::flag_wait("ladder_done");
  self delete();
}

sub_extra_death() {
  thread sub_extra_death_thread();
  return 0;
}

sub_extra_death_thread() {
  var_0 = 10;
  var_1 = (0, -90, 0);
  var_2 = 0.25;

  if(self.script_parameters == "exposed_crouch_death_twist") {
    self orientmode("face angle", self.angles[1] - 90);
    var_1 = (0, 90, 0);
    var_0 = 30;
    var_2 = 0.15;
  }

  var_3 = getanimlength(self.deathanim);
  wait(var_3 * var_2);
  var_4 = anglesToForward(self.angles + var_1);
  var_4 = var_4 * var_0;
  self startragdollfromimpact(self gettagorigin("j_spine4"), var_4);
  wait 0.05;
}

sub_barracks() {
  thread barracks_open_door();
  thread barracks_enemies();
  thread barracks_sandman_exit();
  common_scripts\utility::flag_wait("trigger_barracks_entrance");
  thread bulkhead_door_vo();
}

barracks_open_door() {
  var_0 = getEnt("barracks_door_open_anim_ent", "targetname");
  var_1 = maps\_utility::spawn_anim_model("door", var_0.origin);
  level.sub_doors[level.sub_doors.size] = var_1;
  var_2 = "open_with_wheel";
  var_0 maps\_anim::anim_first_frame_solo(var_1, var_2);
  common_scripts\utility::flag_wait("trigger_barracks_entrance");
  level.sandman maps\_utility::disable_ai_color();
  level.sandman disable_awareness();
  level.sandman notify("disable_smart_laser");
  level.sandman laserforceoff();
  var_0 maps\_anim::anim_reach_solo(level.sandman, var_2);
  var_3 = maps\_utility::make_array(level.sandman, var_1);
  maps\_audio::aud_send_msg("aud_open_bulkhead_door");
  common_scripts\utility::flag_set("barracks_sandman_opening_door");
  maps\_utility::delaythread(5, ::barracks_open_door_collision);
  var_0 maps\_anim::anim_single(var_3, var_2);
  level.sandman maps\_utility::enable_ai_color();
  var_4 = getEnt("barracks_sandman_after_door_open", "targetname");
  var_4 notify("trigger");
  level.sandman thread shoot_magic_bullets();
  maps\_utility::battlechatter_on("allies");
  maps\_utility::battlechatter_on("axis");
  wait 2;
  level.sandman enable_awareness();
}

shoot_magic_bullets() {
  var_0 = 0;

  for(var_1 = common_scripts\utility::getStruct("org_sandman_target", "targetname"); var_0 < 6; var_0++) {
    magicbullet("mp5_silencer_reflex_harbor", self getmuzzlepos(), var_1.origin);
    wait 0.05;
  }
}

barracks_open_door_collision() {
  var_0 = getEnt("barracks_open_door_col", "targetname");
  var_0 connectpaths();
  var_0 delete();
}

bulkhead_door_vo() {
  common_scripts\utility::flag_set("vo_sub_interior_1");
  wait 5;
  common_scripts\utility::flag_set("vo_go_downstairs");
}

barracks_enemies() {
  thread barracks_slam_door();
  thread barracks_waver();
  thread barracks_run_and_stumble();
}

barracks_runner() {
  common_scripts\utility::flag_wait("trigger_barracks_entrance");
  wait 12;
  var_0 = getEnt("barracks_spawn1", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai(1);
  var_1 runners();
}

barracks_slam_door() {
  thread barracks_slam_door_collision();
  common_scripts\utility::flag_wait("trigger_barracks_entrance");
  var_0 = getEnt("barracks_slam_door", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai(1);
  maps\_utility::spawn_failed();
  var_1.animname = "barracks_2";
  var_1 thread maps\_utility::magic_bullet_shield();
  var_1.awareness = 1;
  var_1 disable_awareness();
  var_2 = common_scripts\utility::getStruct("barracks_slam_door_anim_pos", "targetname");
  var_3 = maps\_utility::spawn_anim_model("door", var_2.origin);
  level.sub_doors[level.sub_doors.size] = var_3;
  var_4 = "slam_door";
  var_5 = maps\_utility::make_array(var_1, var_3);
  var_2 maps\_anim::anim_first_frame(var_5, var_4);
  common_scripts\utility::flag_wait_or_timeout("barracks_slam_door", 20);
  common_scripts\utility::flag_set("barracks_slam_door");
  var_1 thread maps\_utility::dialogue_queue("nyharbor_ru2_behinddoor");
  maps\_utility::delaythread(0.05, maps\_anim::anim_set_rate, var_5, var_4, 1.5);
  var_2 maps\_anim::anim_single(var_5, var_4);
  var_1 maps\_utility::stop_magic_bullet_shield();
  var_1 delete();
}

barracks_slam_door_collision() {
  var_0 = getEnt("barracks_slam_door_col", "targetname");
  var_0 connectpaths();
  var_0 notsolid();
  common_scripts\utility::flag_wait("barracks_slam_door");
  var_0 disconnectPaths();
  var_0 solid();
}

barracks_waver() {
  common_scripts\utility::flag_wait("trigger_barracks_entrance");
  var_0 = getEnt("barracks_waver", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai(1);
  var_1.ignoreall = 1;
  var_1 thread maps\_utility::magic_bullet_shield();
  var_2 = common_scripts\utility::getStruct("barracks_waver_anim_pos", "targetname");
  var_2 maps\_anim::anim_generic_first_frame(var_1, "launchfacility_b_blast_door_seq_waveidle");
  common_scripts\utility::flag_wait("barracks_sandman_opening_door");
  wait 4;
  var_1.allowdeath = 1;
  var_1 maps\_utility::stop_magic_bullet_shield();
  var_1.ignoreall = 0;
  var_2 maps\_anim::anim_generic(var_1, "launchfacility_b_blast_door_seq_waveidle");
  var_1 enable_death_anims();
  var_1 thread move_to_target_node();
}

barracks_run_and_stumble() {
  common_scripts\utility::flag_wait("barracks_sandman_opening_door");
  thread maps/ny_harbor_fx::door_open_smokeout_vfx();
  wait 7.5;
  var_0 = getEnt("barracks_run_and_stumble", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai(1);
  maps\_utility::spawn_failed();
  var_1.animname = "barracks_1";
  var_1 thread maps\_utility::dialogue_queue("nyharbor_ru1_americans");
  var_1 thread ignore_until_goal();
  var_1 thread move_to_target_node();
}

ignore_until_goal() {
  self endon("death");
  self.ignoreall = 1;
  self waittill("goal");
  self.ignoreall = 0;
}

barracks_sandman_exit() {
  level endon("sandman_paired_kill");
  var_0 = common_scripts\utility::getStruct("barracks_sandman_exit_anim_pos", "targetname");
  var_1 = common_scripts\utility::getStruct("barracks_sandman_exit_anim_pos_guy", "targetname");
  var_2 = maps\_utility::spawn_anim_model("door", var_0.origin);
  level.sub_doors[level.sub_doors.size] = var_2;
  var_3 = "barracks_sandman_exit";
  var_0 maps\_anim::anim_first_frame_solo(var_2, var_3);
  common_scripts\utility::flag_wait("barracks_sandman_opening_door");
  wait 20;
  level.sandman maps\_utility::disable_ai_color();
  var_0 maps\_anim::anim_reach_solo(level.sandman, var_3);
  var_4 = maps\_utility::make_array(level.sandman, var_2);
  var_0 thread maps\_anim::anim_single_solo(var_2, "barracks_sandman_exit");
  var_1 maps\_anim::anim_single_solo(level.sandman, "barracks_sandman_exit");
  thread barracks_sandman_exit_loop(var_1);
}

barracks_sandman_exit_loop(var_0) {
  var_0 thread maps\_anim::anim_loop_solo(level.sandman, "barracks_sandman_exit_idle", "end_loop");
  common_scripts\utility::flag_set("barracks_exit_nag_vo");
  common_scripts\utility::flag_wait_either("sandman_paired_kill", "barracks_move_sandman");
  var_0 notify("end_loop");

  if(common_scripts\utility::flag("barracks_move_sandman")) {
    level.sandman maps\_utility::anim_stopanimscripted();
    var_1 = getEnt("sandman_barracks_teleport", "targetname");
    level.sandman maps\_utility::teleport_ent(var_1);
    level.sandman maps\_utility::playlocalsoundwrapper(level.sandman.origin);
  }
}

move_to_target_node() {
  self endon("death");

  if(!isalive(self)) {
    return;
  }
  if(isDefined(self.target)) {
    var_0 = getnode(self.target, "targetname");
    self setgoalpos(var_0.origin);
    waittillframeend;
    self.goalradius = 64;
  }
}

sub_reactor_room() {
  maps\_utility::array_spawn_function_noteworthy("reactor_room_runner", ::runners);
  thread reactor_room_sandman_paired_kill();
  thread reactor_room_vfx_steam();
  thread water_sheeting();
  thread reactor_room_pipe_burst();
}

reactor_room_vfx_steam() {
  common_scripts\utility::flag_wait("reactor_room_vfx_steam_start");
  common_scripts\utility::exploder(258);
  earthquake(0.3, 1.7, level.player.origin, 1024);
}

water_sheeting() {
  common_scripts\utility::flag_wait("ladder_done");
  var_0 = getEntArray("sub_water_sheeting_vol", "targetname");
  var_1 = 0;

  while(!common_scripts\utility::flag("start_zodiac")) {
    if(check_volumes(var_0)) {
      if(var_1 == 0) {
        level.player setwatersheeting(1);
        var_1 = 1;
      }

      wait 0.05;
      continue;
    }

    if(var_1 == 1) {
      level.player setwatersheeting(1, 0.5);
      var_1 = 0;
      wait 0.05;
      continue;
    }

    wait 0.05;
  }
}

reactor_room_sandman_paired_kill() {
  level endon("sandman_paired_kill_interrupted");
  maps\_anim::addnotetrack_customfunction(level.sandman.animname, "HEADSMASH", ::reactor_room_head_smash, "ny_harbor_doorway_headsmash");
  common_scripts\utility::flag_wait("sandman_paired_kill");
  thread show_sub_water();
  var_0 = common_scripts\utility::getStruct("reactor_room_sandman_paired_kill_anim_pos", "targetname");
  var_1 = getEnt("reactor_room_sandman_paired_killed_enemy", "targetname");
  var_2 = var_1 maps\_utility::spawn_ai(1);
  maps\_utility::spawn_failed();
  var_2.animname = "generic";
  var_2.ignoreall = 1;
  var_2.ignoreme = 1;
  var_2.allowdeath = 1;
  var_2.health = 999999;
  var_2 thread play_blood_fx();
  var_3 = maps\_utility::make_array(var_2, level.sandman);
  level.sandman notify("disable_smart_laser");
  level.sandman laserforceoff();
  maps\_audio::aud_send_msg("aud_sub_sandman_pairedkill_headsmash");
  var_0 thread maps\_anim::anim_single(var_3, "ny_harbor_doorway_headsmash");
  wait 5.5;
  var_2 thread dummy_keep_pose(var_0, "ny_harbor_doorway_headsmash_enemy_deadpose");
  level.sandman maps\_utility::enable_ai_color();
  var_4 = getEnt("reactor_room_sandman_color_after_paired", "targetname");
  var_4 notify("trigger");
  common_scripts\utility::flag_set("sandman_paired_kill_complete");
  level notify("sandman_paired_kill_finished");
  thread extinguisher_guy(5);
  level.sandman waittillmatch("single anim", "end");
  var_0 maps\_anim::anim_single_solo(level.sandman, "ny_harbor_doorway_headsmash_no_gun_flip");
  level.sandman setanim(level.scr_anim[level.sandman.animname]["ny_harbor_doorway_headsmash"], 0, 0);
  level.sandman setanim(level.scr_anim[level.sandman.animname]["ny_harbor_doorway_headsmash_no_gun_flip"], 1, 0);

  if(getdvarint("demo_itiot") == 1) {
    thread demo_fade();
  }
}

play_blood_fx() {
  while(!common_scripts\utility::flag("sandman_paired_kill_complete")) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(isDefined(var_3) && isDefined(var_4)) {
      if(var_4 == "MOD_PISTOL_BULLET" || var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_EXPLOSIVE_BULLET") {
        playFX(common_scripts\utility::getfx("flesh_hit"), var_3);
      }
    }

    wait 0.5;
  }
}

monitor_paired_interrupt_enemy() {
  level endon("sandman_paired_kill_finished");
  self waittill("damage");
  maps\_utility::anim_stopanimscripted();
  self kill();
  level notify("sandman_paired_kill_interrupted");
}

monitor_paired_interrupt_sandman() {
  level endon("sandman_paired_kill_finished");
  level waittill("sandman_paired_kill_interrupted");
  maps\_utility::anim_stopanimscripted();
  level.sandman maps\_utility::enable_ai_color();
  var_0 = getEnt("reactor_room_sandman_color_after_paired", "targetname");
  var_0 notify("trigger");
  common_scripts\utility::flag_set("sandman_paired_kill_complete");
  level thread extinguisher_guy(7);

  if(getdvarint("demo_itiot") == 1) {
    thread demo_fade();
  }
}

demo_fade() {
  common_scripts\utility::flag_wait("e3_guy_killed");
  wait 1;
  level.player freezecontrols(1);
  thread maps\_utility::battlechatter_off("allies");
  thread maps\_utility::battlechatter_off("axis");
  maps\_audio::aud_send_msg("e3_demo_fade_out", 1);
  thread introscreen_generic_fade_out("black", 5, 1, 1);
  var_0 = [];
  var_0[0] = &"NY_HARBOR_DEMO_1";
  thread demo_feed_lines(var_0, 1);
  maps\_utility::delaythread(1, ::delete_badguys);
  wait 3;
  itiot_bridge_breach();
}

itiot_bridge_breach() {
  level.player freezecontrols(0);
  level.player setstance("stand");
  thread hide_sub_water();
  maps\_audio::aud_send_msg("e3_demo_fade_in", 1);
  maps\_audio::aud_send_msg("start_bridge_breach");
  thread sub_missile_tubes_hide();
  thread sub_missile_tubes_show();
  thread open_hatch_rear();
  var_0 = common_scripts\utility::getStruct("start_breach_player_loc", "targetname");
  level.player maps\_utility::teleport_player(var_0);
  thread sub_exit();
  common_scripts\utility::flag_set("obj_plantmine_given");
  common_scripts\utility::flag_set("obj_plantmine_complete");
  common_scripts\utility::flag_set("obj_capturesub_given");
  common_scripts\utility::flag_set("player_surfaces");
  common_scripts\utility::flag_set("ready_for_player_slide");
  common_scripts\utility::flag_set("hatch_player_using_ladder");
  common_scripts\utility::flag_set("sub_objective_breach");
  maps\_utility::player_speed_percent(75);
  setup_sandman();
  var_1 = common_scripts\utility::getStruct("start_breach_sandman_loc", "targetname");
  level.sandman forceteleport(var_1.origin, var_1.angles);
  thread rockingsub();
  maps\_utility::vision_set_fog_changes("ny_harbor_sub_4", 0);
  setsaveddvar("sm_sunenable", 0);
  setsaveddvar("sm_spotlimit", 2);
  thread setup_music_before_door_breach();
}

extinguisher_guy(var_0) {
  common_scripts\utility::flag_init("vo_extinguisher");
  var_1 = getEnt("extinguisher_guy", "targetname");
  var_2 = common_scripts\utility::getStruct("org_fire_extinguisher", "targetname");
  var_3 = var_1 maps\_utility::spawn_ai();

  if(isDefined(var_3)) {
    var_3.animname = "guy";
    var_3.allowdeath = 1;
    var_3 maps\_utility::gun_remove();
    var_3 thread ignore_extinguisher(var_0);
    var_4 = maps\_utility::spawn_anim_model("extinguisher");
    var_4.animname = "extinguisher";
    var_5 = [];
    var_5[0] = var_3;
    var_5[1] = var_4;
    var_3 thread monitor_end_loop(var_2, var_4);
    var_3 thread maps/ny_harbor_fx::sub_interior_extinguisherfx(var_4);
    common_scripts\utility::flag_set("vo_extinguisher");
    var_2 maps\_anim::anim_loop(var_5, "extinguisher_loop", "stop_loop");
  }
}

monitor_end_loop(var_0, var_1) {
  self waittill("death");
  var_0 notify("stop_loop");
  var_1 maps\_utility::anim_stopanimscripted();
  var_1 physicslaunchclient(var_1.origin, (0, 0, 0));
}

ignore_extinguisher(var_0) {
  self endon("death");
  self.ignoreme = 1;
  wait(var_0);
  self.ignoreme = 0;
  level.sandman.favoriteenemy = self;
}

delete_badguys() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {}
  var_2 delete();
}

reactor_room_head_smash(var_0) {
  thread maps/ny_harbor_fx::head_smash_vfx();
}

runners() {
  self endon("death");
  maps\_utility::disable_long_death();
  self.awareness = 1;
  disable_awareness();
  maps\_utility::disable_cqbwalk();
  self.grenadeammo = 0;
  self notify("retreat");

  if(isDefined(self.script_parameters)) {
    thread sub_enemy_vo();
  }
  common_scripts\utility::waittill_either("goal", "damage");
  enable_awareness();
  maps\_utility::enable_cqbwalk();
}

reactor_room_pipe_burst() {
  common_scripts\utility::flag_wait("reactor_room_announcement");
  wait 1.0;
  wait 0.3;
  common_scripts\utility::exploder(259);
  maps\_audio::aud_send_msg("aud_premissileroom_pipeburst");
  var_0 = getEnt("pipe_valve", "script_noteworthy");
  var_0 hide();
}

sub_missile_room() {
  maps\_utility::array_spawn_function_noteworthy("missile_room_runner", ::runners);
}

breach_vo() {
  thread maps\ny_harbor_code_vo::vo_sub_interior_bridge();
}

bridge_breach() {
  common_scripts\utility::flag_init("breaching_on");
  thread backtrack_fail();
  thread breach_vo();
  level.bridge_dudes = [];
  level.breachenemies_active = 0;
  level.breachenemies_alive = 0;
  var_0 = getEnt("mil_frame_charge", "targetname");
  var_0 hide();
  var_1 = getEnt("bridge_breach_loc", "targetname");
  level.breach_door = maps\_utility::spawn_anim_model("breach_door", var_1.origin);
  level.breach_door.animname = "breach_door";
  level.breach_door maps\_anim::setanimtree();
  var_1 maps\_anim::anim_first_frame_solo(level.breach_door, "ny_harbor_door_breach");
  var_2 = getEnt("detonator_1", "targetname");
  var_2 hide();
  var_3 = getEnt("detonator_2", "targetname");
  var_3 hide();
  var_4 = getEnt("spawner_ambient_mis2_group2", "targetname");
  common_scripts\utility::flag_wait("sub_breach_sandman_to_postion");
  var_5 = getaiarray("axis");
  var_6 = getdvarint("cg_fov");
  var_7 = cos(var_6);
  common_scripts\utility::array_thread(var_5, ::breach_retreat_and_delete, var_7);
  maps\_audio::aud_send_msg("bridge_breach_setup");
  common_scripts\utility::flag_set("vo_wait_at_door");
  level.sandman maps\_utility::disable_cqbwalk();
  level.sandman notify("disable_smart_laser");
  level.sandman laserforceoff();
  level.sandman maps\_utility::disable_ai_color();
  var_8 = common_scripts\utility::getStruct("bridge_breach_sandman_idle", "targetname");
  var_1 maps\_anim::anim_reach_solo(level.sandman, "ny_harbor_door_breach_idle_trans");
  var_1 maps\_anim::anim_single_solo(level.sandman, "ny_harbor_door_breach_idle_trans");
  var_1 thread maps\_anim::anim_loop_solo(level.sandman, "ny_harbor_door_breach_idle", "end_idle");
  level.sandman setlookatentity(level.player);
  common_scripts\utility::flag_wait("ready_for_breach");
  common_scripts\utility::flag_set("vo_breach");
  var_9 = getEnt("bridge_breach_trigger", "targetname");
  var_9 useTriggerRequireLookAt();
  var_9 setHintString(&"NY_HARBOR_HINT_USE_TO_BREACH");
  var_9 waittill("trigger");
  maps\_audio::aud_send_msg("player_trigger_sub_door_breach");
  var_9 delete();
  level.sdv_player_arms hide();
  common_scripts\utility::flag_set("breach_started");
  var_10 = getEnt("breach_door_col", "targetname");
  level.breach_charge1 = maps\_utility::spawn_anim_model("breach_charge1", var_1.origin);
  level.breach_charge1.animname = "breach_charge1";
  level.breach_charge1 hide();
  level.breach_charge2 = maps\_utility::spawn_anim_model("breach_charge2", var_1.origin);
  level.breach_charge2.animname = "breach_charge2";
  level.breach_charge2 hide();
  level.player disableoffhandweapons();
  level.player freezecontrols(1);
  maps\_shg_common::setupplayerforanimations();
  thread maps\_utility::battlechatter_off("allies");
  thread maps\_utility::battlechatter_off("axis");
  level.player disableweapons();
  level.player waittill("weapon_change");
  thread breach_setup_player();
  var_10 connectpaths();
  var_10 delete();
  var_1 maps\_anim::anim_first_frame_solo(level.sdv_player_arms, "ny_harbor_door_breach");
  level.player playerlinktoblend(level.sdv_player_arms, "tag_player", 0.2);
  wait 0.2;
  var_0 show();
  var_2 show();
  var_3 show();
  var_0.animname = "door_charge";
  var_0 maps\_anim::setanimtree();
  var_2.animname = "breach_detonator1";
  var_2 maps\_anim::setanimtree();
  var_3.animname = "breach_detonator2";
  var_3 maps\_anim::setanimtree();
  var_11 = getEnt("bridge_breach_guy1", "targetname");
  var_12 = var_11 maps\_utility::spawn_ai(1);
  var_12 maps\_utility::gun_remove();
  var_12 = maps\_vehicle_aianim::convert_guy_to_drone(var_12);
  var_12 notsolid();
  var_12.animname = "generic";
  common_scripts\utility::flag_set("start_bridge_breach");
  var_1 notify("end_idle");
  var_5 = [level.sandman, var_0, level.breach_door, var_2, var_3, level.sdv_player_arms, var_12, level.breach_charge1, level.breach_charge2];
  level.sdv_player_arms common_scripts\utility::delaycall(0.1, ::show);
  var_1 maps\_anim::anim_single(var_5, "ny_harbor_door_breach");
  level.player thread breach_top_off_weapon();
  common_scripts\utility::flag_wait("door_blown");
  maps\_audio::aud_send_msg("bridge_breach");
  level.sdv_player_arms hide();
  level.player enableweapons();
  level.player freezecontrols(0);
  wait 1;
  level.player unlink();
  thread breach_sandman_enter_room();
  common_scripts\utility::flag_wait("breach_done");
  thread breach_cleanup_player();
}

breach_retreat_and_delete(var_0) {
  self endon("death");
  var_1 = getEnt("vol_breach_enemies_retreat", "targetname");
  self.awareness = 1;
  maps\_utility::disable_cqbwalk();
  self setgoalvolumeauto(var_1);

  while(maps\_utility::within_fov_of_players(self.origin, var_0)) {
    wait(randomfloatrange(0.05, 0.3));
  }
  self delete();
}

breach_sandman_enter_room() {
  level.sandman maps\_utility::enable_ai_color();
  var_0 = getEnt("breach_sandman_enter_room", "targetname");
  var_0 notify("trigger");
}

breach_setup_player() {
  level.player enableinvulnerability();
  level.player disableweaponswitch();
  level.player disableoffhandweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player allowjump(0);
  maps/ny_harbor_fx::door_breach_vision_change();
  maps/ny_harbor_fx::door_breach_flash_vfx();
  maps/ny_harbor_fx::door_breach_blur();
}

breach_cleanup_player() {
  level.player disableinvulnerability();
  level.player enableweaponswitch();
  level.player enableoffhandweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowsprint(1);
  level.player allowjump(1);
}

blow_door(var_0) {
  common_scripts\utility::flag_set("door_blown");
  level.breach_door setModel("ny_harbor_sub_pressuredoor_bridge_destroyed");
  var_1 = level.breach_door gettagorigin("hinge");
  var_2 = level.breach_door gettagangles("hinge");
  var_3 = anglesToForward(var_2);
  var_4 = anglestoright(var_2);
  var_5 = anglestoup(var_2);
  var_6 = (-28, -8, -12);
  var_1 = var_1 + var_3 * var_6[0] + var_4 * var_6[1] + var_5 * var_6[2];
  level.breach_destroyed_door = spawn("script_model", var_1);
  level.breach_destroyed_door setModel("ny_harbor_sub_pressuredoor_bridge_destroyed_door");
  level.breach_destroyed_door.angles = var_2;
  level.breach_destroyed_door linkTo(level.breach_door, "hinge");
  level.breach_door hidepart("hinge");
  level.breach_door hidepart("handle");
  var_7 = getEnt("detonator_1", "targetname");
  var_7 delete();
  var_8 = getEnt("detonator_2", "targetname");
  var_8 delete();
  var_9 = getEnt("mil_frame_charge", "targetname");
  var_9 delete();
  level.breach_charge1 delete();
  level.breach_charge2 delete();
  thread maps/ny_harbor_fx::door_breach_vfx();
  thread captain_animation();
  thread breach_enemy_1();
  thread breach_enemy_2();
  thread breach_enemy_3();
}

breach_slow_down(var_0) {
  thread slowmo_begins();
}

breach_top_off_weapon(var_0) {
  var_0 = self getcurrentweapon();

  if(should_topoff_breach_weapon()) {
    var_1 = weaponclipsize(var_0);

    if(self getweaponammoclip(var_0) < var_1) {
      self setweaponammoclip(var_0, var_1);
    }
  }
}

should_topoff_breach_weapon() {
  if(level.gameskill > 1) {
    return 0;
  }
  return 1;
}

show_charge_1(var_0) {
  level.breach_charge1 show();
}

detach_charge_1(var_0) {}

show_charge_2(var_0) {
  level.breach_charge2 show();
}

detach_charge_2(var_0) {}

slowmo_begins(var_0) {
  maps\_audio::aud_send_msg("door_breach_slowmo_start");
  level.slomobreachduration = 3.5;
  var_1 = 0.5;
  var_2 = 0.75;
  var_3 = 0.2;

  if(isDefined(level.breaching) && level.breaching == 1) {
    return;
  }
  level.breaching = 1;
  common_scripts\utility::flag_set("breaching_on");
  level notify("slowmo_go");
  level endon("slowmo_go");

  if(isDefined(level.slomobreachplayerspeed)) {
    var_3 = level.slomobreachplayerspeed;
  }
  var_4 = level.player;
  var_4 thread maps\_utility::play_sound_on_entity("slomo_whoosh");
  var_4 thread player_heartbeat();
  common_scripts\utility::flag_clear("can_save");
  var_4 allowmelee(0);
  maps\_utility::slowmo_setspeed_slow(0.25);
  maps\_utility::slowmo_setlerptime_in(var_1);
  maps\_utility::slowmo_lerp_in();
  var_4 setmovespeedscale(var_3);
  var_5 = gettime();
  var_6 = var_5 + level.slomobreachduration * 1000;
  var_4 thread catch_weapon_switch();
  var_4 thread catch_mission_failed();
  var_7 = 500;
  var_8 = 1000;

  for(;;) {
    if(isDefined(level.forced_slowmo_breach_slowdown)) {
      if(!level.forced_slowmo_breach_slowdown) {
        if(isDefined(level.forced_slowmo_breach_lerpout)) {
          var_2 = level.forced_slowmo_breach_lerpout;
        }
        break;
      }

      wait 0.05;
      continue;
    }

    if(gettime() >= var_6) {
      break;
    }

    if(level.breachenemies_active <= 0) {
      var_2 = 1.15;
      break;
    }

    if(!maps\_utility::is_coop()) {
      if(var_4.lastreloadstarttime >= var_5 + var_7) {
        break;
      }

      if(var_4.switchedweapons && gettime() - var_5 > var_8) {
        break;
      }
    }

    if(maps\_utility::is_specialop() && common_scripts\utility::flag("special_op_terminated")) {
      break;
    }

    if(var_4.breach_missionfailed) {
      var_2 = 0.5;
      break;
    }

    wait 0.05;
  }

  level notify("slowmo_breach_ending", var_2);
  level notify("stop_player_heartbeat");
  var_4 thread maps\_utility::play_sound_on_entity("slomo_whoosh");
  maps\_utility::slowmo_setlerptime_out(var_2);
  maps\_utility::slowmo_lerp_out();
  var_4 allowmelee(1);
  maps\_utility::slowmo_end();
  maps\_audio::aud_send_msg("door_breach_slowmo_end");
  common_scripts\utility::flag_set("can_save");
  level.player_one_already_breached = undefined;
  var_4 slowmo_player_cleanup();
  level notify("slomo_breach_over");
  level.breaching = 0;
  common_scripts\utility::flag_clear("breaching_on");
  common_scripts\utility::flag_set("breach_done");
  setsaveddvar("objectiveHide", 0);
}

player_heartbeat() {
  level endon("stop_player_heartbeat");

  for(;;) {
    self playlocalsound("breathing_heartbeat");
    wait 0.5;
  }
}

catch_weapon_switch() {
  level endon("slowmo_breach_ending");
  self.switchedweapons = 0;
  common_scripts\utility::waittill_any("weapon_switch_started", "night_vision_on", "night_vision_off");
  self.switchedweapons = 1;
}

catch_mission_failed() {
  level endon("slowmo_breach_ending");
  self.breach_missionfailed = 0;
  level waittill("mission failed");
  self.breach_missionfailed = 1;
}

slowmo_player_cleanup() {
  if(isDefined(level.playerspeed)) {
    self setmovespeedscale(level.playerspeed);
  } else {
    self setmovespeedscale(1);
  }
}

breach_enemy_track_status(var_0, var_1) {
  level.breachenemies_active++;
  var_2 = spawnStruct();
  var_2.enemy = var_0;
  var_2 thread breach_enemy_waitfor_death(var_0);
  var_2 thread breach_enemy_waitfor_death_counter(var_0);
  var_2 thread breach_enemy_catch_exceptions(var_0);
  var_2 thread breach_enemy_waitfor_breach_ending();

  if(isDefined(var_1)) {
    var_2 thread breach_enemy_waitfor_damage(var_0);
  }
  var_2 waittill("breach_status_change", var_3);
  level.breachenemies_active--;
  var_2 = undefined;
}

breach_enemy_waitfor_damage(var_0) {
  self endon("breach_status_change");
  var_0 waittill("damage");
  self notify("breach_status_change", "death");
}

breach_enemy_waitfor_death(var_0) {
  self endon("breach_status_change");
  var_0 waittill("death");
  self notify("breach_status_change", "death");
}

breach_enemy_waitfor_death_counter(var_0) {
  level.breachenemies_alive++;
  var_0 waittill("death");
  level.breachenemies_alive--;

  if(level.breachenemies_alive <= 0) {
    common_scripts\utility::flag_set("bridge_breach_all_enemies_dead");
  }
  level notify("breach_all_enemies_dead");
}

breach_enemy_catch_exceptions(var_0) {
  self endon("breach_status_change");

  while(isalive(var_0)) {
    wait 0.05;
  }
  self notify("breach_status_change", "exception");
}

breach_enemy_waitfor_breach_ending() {
  self endon("breach_status_change");
  level waittill("slowmo_breach_ending");
  self notify("breach_status_change", "breach_ending");
}

breach_enemy_monitor_dead() {
  while(!common_scripts\utility::flag("bridge_breach_all_enemies_dead")) {
    wait 0.05;
  }
}

breach_sandman_take_keys() {
  common_scripts\utility::flag_wait("bridge_breach_all_enemies_dead");
  common_scripts\utility::flag_wait("start_end_scene");
  var_0 = getEnt("bridge_breach_loc", "targetname");
  var_0 maps\_anim::anim_generic_reach(level.sandman, "ny_harbor_paried_takedown_sandman_start");
  common_scripts\utility::flag_set("vo_sub_interior_6");
  var_0 maps\_anim::anim_generic(level.sandman, "ny_harbor_paried_takedown_sandman_start");
  maps\_audio::aud_send_msg("aud_start_sandman_takes_key");
  level.sub_captain.animname = "generic";
  var_1 = [level.sandman, level.sub_captain];
  var_0 thread maps\_anim::anim_single_solo(level.sub_captain, "ny_harbor_captain_search_flip_over");
  var_0 maps\_anim::anim_single_solo(level.sandman, "ny_harbor_captain_search_flip_over");
  var_0 maps\_anim::anim_single_solo(level.sandman, "ny_harbor_captain_search_flip_over_b");
  level notify("start_missilekey");
  var_0 maps\_anim::anim_single_solo(level.sandman, "ny_harbor_captain_search_flip_over_c");
  level.sub_captain = undefined;
  common_scripts\utility::flag_set("sub_control_room_key_scene_ready");
}

controls_scene() {
  level.player endon("death");
  var_0 = getEnt("bridge_breach_loc", "targetname");
  var_1 = maps\_utility::spawn_anim_model("missile_key_panel");
  level.missile_key_panel = var_1;
  var_0 maps\_anim::anim_first_frame_solo(level.missile_key_panel, "sub_turn_key");
  level.missile_key_panel showpart("tag_lighton");
  var_2 = maps\_utility::spawn_anim_model("missile_key_panel_box");
  level.missile_key_panel_box = var_2;
  var_0 maps\_anim::anim_first_frame_solo(level.missile_key_panel_box, "sub_turn_key");
  level.missile_key_panel_box hidepart("tag_lighton");
  common_scripts\utility::flag_wait("sub_control_room_key_scene_ready");
  var_0 thread maps\_anim::anim_generic_loop(level.sandman, "sub_turn_key_idle", "stop_loop");
  maps\_audio::aud_send_msg("aud_prime_missilekeytoss");
  common_scripts\utility::flag_wait("sub_control_room_player_to_controls");
  var_3 = getEnt("sub_control_key_panel_main", "targetname");
  var_3 maps\_utility::glow();
  var_1 maps\_utility::glow();
  var_2 harbor_glow();
  var_4 = getEnt("sub_control_room_player_use", "targetname");
  var_4 useTriggerRequireLookAt();
  var_4 setHintString(&"NY_HARBOR_HINT_USE");
  var_4 waittill("trigger");
  var_4 delete();
  thread return_player_body_if_death();
  var_3 maps\_utility::stopglow();
  var_1 maps\_utility::stopglow();
  var_2 harbor_stop_glow();
  common_scripts\utility::flag_set("player_at_controls");
  common_scripts\utility::flag_set("vo_overlord_dialogue");
  level.player disableoffhandweapons();
  level.player freezecontrols(1);
  maps\_shg_common::setupplayerforanimations();
  level.player disableweapons();
  var_0 maps\_anim::anim_first_frame_solo(level.sdv_player_arms, "sub_turn_key");
  var_5 = 0.3;
  level.player playerlinktoblend(level.sdv_player_arms, "tag_player", var_5);
  wait(var_5);
  level.sdv_player_arms show();
  var_6 = maps\_utility::spawn_anim_model("missile_key_player", var_0.origin);
  var_7 = maps\_utility::spawn_anim_model("missile_key_sandman", var_0.origin);
  var_0 notify("stop_loop");
  var_8 = [level.sdv_player_arms, level.sandman, var_7, var_6, var_2, var_1];
  thread maps\ny_harbor_code_vo::vo_sandman_count_down(level.sandman);
  var_0 maps\_anim::anim_single(var_8, "sub_turn_key");
  var_0 thread maps\_anim::anim_single_solo(level.sandman, "sub_turn_key2");
  wait 3.83333;
  level.sdv_player_arms hide();
  maps\_shg_common::setupplayerforgameplay();
  level.player enableweapons();
  level.player freezecontrols(0);
  level.player unlink();
  var_7 delete();
  var_6 delete();
  wait 1.73333;
  common_scripts\utility::flag_set("sub_control_room_sandman_exit");
  common_scripts\utility::flag_wait("vo_bridge_is_done");
  maps\_utility::autosave_by_name("control_room");
  common_scripts\utility::flag_wait("start_zodiac");
  level.missile_key_panel delete();
  level.missile_key_panel_box delete();
}

return_player_body_if_death() {
  level.player waittill("death");
  level.sdv_player_arms hide();
  maps\_shg_common::setupplayerforgameplay();
  level.player enableweapons();
  level.player freezecontrols(0);
  level.player unlink();
}

harbor_glow(var_0) {
  if(isDefined(self.non_glow_model)) {
    return;
  }
  self.non_glow_model = self.model;

  if(!isDefined(var_0)) {
    var_0 = self.model + "_obj";
  }
  self setModel(var_0);
  self hidepart("tag_lighton");
}

harbor_stop_glow(var_0) {
  if(!isDefined(self.non_glow_model)) {
    return;
  }
  self setModel(self.non_glow_model);
  self hidepart("tag_lighton");
  self.non_glow_model = undefined;
}

handle_death_anim_complete() {
  self notify("death_anim_complete");
}

captain_animation() {
  var_0 = getEnt("spawn_sub_captain", "targetname");
  level.sub_captain = var_0 maps\_utility::spawn_ai(1);
  level.sub_captain maps\_utility::gun_remove();
  thread breach_enemy_track_status(level.sub_captain, 1);
  level.sub_captain.ignoreall = 1;
  level.sub_captain thread maps\_utility::magic_bullet_shield();
  level.sub_captain thread sub_captain_force_kill();
  var_1 = getEnt("bridge_breach_loc", "targetname");
  var_1 thread maps\_anim::anim_generic(level.sub_captain, "ny_harbor_paried_takedown_captain_start");
  level.sub_captain waittill("damage", var_2, var_3, var_4, var_5, var_6);

  if(isDefined(var_5) && isDefined(var_6)) {
    if(var_6 == "MOD_PISTOL_BULLET" || var_6 == "MOD_RIFLE_BULLET" || var_6 == "MOD_EXPLOSIVE_BULLET") {
      playFX(common_scripts\utility::getfx("headshot"), var_5);
    }
  }

  var_1 maps\_anim::anim_generic(level.sub_captain, "ny_harbor_paried_takedown_captain_die");
  level.sub_captain maps\_utility::stop_magic_bullet_shield();
  level.sub_captain = level.sub_captain dummy_keep_pose(var_1, "ny_harbor_paried_takedown_captain_dead_1");
  maps\_audio::aud_send_msg("aud_prime_sandman_takes_key");
  common_scripts\utility::flag_set("start_end_scene");
}

sub_captain_force_kill() {
  self endon("damage");
  wait 3;
  var_0 = level.sandman gettagorigin("tag_inhand");
  magicbullet("mp5_silencer_reflex_harbor", var_0, self.origin + (0, 0, 32), level.player);
  wait 0.05;
  self dodamage(10, level.sandman.origin, level.sandman);
}

breach_enemy_1() {
  var_0 = getEnt("breach_enemy_1", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai(1);
  var_1 thread breach_enemy_setup_no_ragdoll();
  var_2 = common_scripts\utility::getStruct("breach_enemy_loc1", "targetname");
  var_2 maps\_anim::anim_generic(var_1, "breach_enemy_1");
}

control_mbs(var_0) {
  thread maps\_utility::magic_bullet_shield();
  wait(var_0);
  thread maps\_utility::stop_magic_bullet_shield();
}

breach_enemy_2() {
  var_0 = getEnt("breach_enemy_2_1", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai(1);
  var_1 thread breach_enemy_setup_no_ragdoll();
  var_1.animname = "breacher1";
  var_0 = getEnt("breach_enemy_2_2", "targetname");
  var_2 = var_0 maps\_utility::spawn_ai(1);
  var_2 thread breach_enemy_setup_no_ragdoll();
  var_2.animname = "breacher2";
  var_3 = maps\_utility::make_array(var_1, var_2);
  var_4 = common_scripts\utility::getStruct("breach_enemy_loc2", "targetname");
  var_4 maps\_anim::anim_single(var_3, "breach_enemy_2");
}

breach_enemy_3() {
  var_0 = getEnt("breach_enemy_3", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai(1);
  var_1 thread setup_knife();
  var_1.animname = "knife_guy";
  var_1 breach_enemy_setup();
  var_1 thread slomo_breach_knife_charger();
  var_2 = [];
  var_2[0] = var_1;
  var_3 = common_scripts\utility::getStruct("breach_enemy_loc3", "targetname");
  maps\_utility::delaythread(0.05, maps\_anim::anim_set_time, var_2, "breach_react_knife_charge", 0.12);
  var_3 maps\_anim::anim_single_solo(var_1, "breach_react_knife_charge");
}

setup_knife() {
  level.player endon("death");
  level.knife = getEnt("weapon_knife", "targetname");
  var_0 = self gettagorigin("tag_inhand");
  var_1 = self gettagangles("tag_inhand");
  level.knife.origin = var_0;
  level.knife.angles = var_1;
  level.knife linkTo(self, "tag_inhand");
  self waittill("death");
  level.knife unlink();
  level.knife physicslaunchclient(level.knife.origin, (0, 0, 0));
}

breach_enemy_setup() {
  level thread breach_enemy_track_status(self, 0);
  thread breach_enemy_ragdoll_on_death();
  self.grenadeammo = 0;
  self.allowdeath = 1;
  self.health = 10;
  self.baseaccuracy = 5000;
}

breach_enemy_setup_no_ragdoll() {
  level thread breach_enemy_track_status(self, 0);
  self.grenadeammo = 0;
  self.allowdeath = 1;
  self.health = 10;
  self.baseaccuracy = 5000;
}

slomo_breach_knife_charger() {
  self endon("death");
  breach_enemy_cancel_ragdoll();
  thread breach_knife_charger_monitor_death();
  maps\_utility::set_deathanim("breach_react_knife_charge_death");
  self waittillmatch("single anim", "stab");
  wait 0.1;
  thread knife_guy_stabs_player();
  self waittill("finished_breach_start_anim");
}

breach_knife_charger_monitor_death() {
  self waittill("death");
  var_0 = self getattachsize();

  for(var_1 = 0; var_1 < var_0; var_1++) {
    if(self getattachmodelname(var_1) == "weapon_parabolic_knife") {
      self detach("weapon_parabolic_knife", "TAG_INHAND");
      break;
    }
  }
}

knife_guy_stabs_player() {
  var_0 = level.player;
  var_1 = distance(var_0.origin, self.origin);

  if(var_1 <= 50) {
    var_0 playRumbleOnEntity("grenade_rumble");
    var_0 thread maps\_utility::play_sound_on_entity("melee_knife_hit_body");
    var_0 disableinvulnerability();
    waittillframeend;
    var_0 dodamage(var_0.health + 50000, self gettagorigin("tag_weapon_right"), self);
    var_0.breach_missionfailed = 1;
  }
}

breach_enemy_ragdoll_on_death() {
  self endon("breach_enemy_cancel_ragdoll_death");
  self.ragdoll_immediate = 1;
  var_0 = common_scripts\utility::waittill_any_return("death", "finished_breach_start_anim");

  if(var_0 == "finished_breach_start_anim") {
    self.ragdoll_immediate = undefined;
  }
}

breach_enemy_cancel_ragdoll() {
  self notify("breach_enemy_cancel_ragdoll_death");
  self.ragdoll_immediate = undefined;
}

sub_exit() {
  common_scripts\utility::flag_wait("sub_control_room_sandman_exit");
  var_0 = common_scripts\utility::getStruct("sub_sandman_exit_jump", "targetname");
  var_0 maps\_anim::anim_first_frame_solo(level.sandman, "sub_exit_jump");
  level.player disableoffhandweapons();
  common_scripts\utility::flag_wait("sub_exit_player_going_out_hatch");
  var_0 maps\_anim::anim_single_solo(level.sandman, "sub_exit_jump");
  common_scripts\utility::flag_set("start_zodiac");
  clearallcorpses();
}

sub_set_player_speed() {
  common_scripts\utility::flag_wait("ladder_done");
  var_0 = getEntArray("sub_player_slow_vol", "targetname");
  var_1 = 0;

  while(!common_scripts\utility::flag("start_zodiac")) {
    if(check_volumes(var_0)) {
      if(var_1 == 0) {
        maps\_utility::player_speed_percent(50);
        level.player allowsprint(0);
        var_1 = 1;
      }

      wait 0.05;
      continue;
    }

    if(var_1 == 1) {
      maps\_utility::player_speed_percent(75);
      level.player allowsprint(1);
      var_1 = 0;
      wait 0.05;
      continue;
    }

    wait 0.05;
  }
}

check_volumes(var_0) {
  foreach(var_2 in var_0) {
    if(level.player istouching(var_2)) {
      return 1;
    }
    wait 0.05;
  }

  return 0;
}

dummy_keep_pose(var_0, var_1) {
  var_2 = maps\_vehicle_aianim::convert_guy_to_drone(self);
  var_2 startusingheroonlylighting();

  if(isarray(maps\_utility::getgenericanim(var_1))) {
    var_1 = var_1 + "_nl";
  }
  var_0 maps\_anim::anim_generic_first_frame(var_2, var_1);
  var_2 notsolid();
  return var_2;
}

disable_death_anims() {
  self.allowdeath = 1;
  self.ragdoll_immediate = 1;
}

enable_death_anims() {
  if(isalive(self)) {
    self.allowdeath = 0;
    self.ragdoll_immediate = undefined;
  }
}

kill_no_react() {
  if(!isalive(self)) {
    return;
  }
  self.allowdeath = 1;
  self.a.nodeath = 1;
  maps\_utility::set_battlechatter(0);
  self kill();
}

disable_awareness() {
  self.awareness = 0;
  self.ignoreall = 1;
  self.dontmelee = 1;
  self.ignoresuppression = 1;
  self.suppressionwait_old = self.suppressionwait;
  self.suppressionwait = 0;
  maps\_utility::disable_surprise();
  self.ignorerandombulletdamage = 1;
  maps\_utility::disable_bulletwhizbyreaction();
  maps\_utility::disable_pain();
  maps\_utility::disable_danger_react();
  self.grenadeawareness = 0;
  self.ignoreme = 1;
  maps\_utility::enable_dontevershoot();
  self.disablefriendlyfirereaction = 1;
}

has_awareness() {
  return self.awareness;
}

enable_awareness() {
  self.awareness = 1;
  self.ignoreall = 0;
  self.dontmelee = undefined;
  self.ignoresuppression = 0;
  self.suppressionwait = self.suppressionwait_old;
  self.suppressionwait_old = undefined;
  maps\_utility::enable_surprise();
  self.ignorerandombulletdamage = 0;
  maps\_utility::enable_bulletwhizbyreaction();
  maps\_utility::enable_pain();
  maps\_utility::enable_danger_react(3);
  self.grenadeawareness = 1;
  self.ignoreme = 0;
  maps\_utility::disable_dontevershoot();
  self.disablefriendlyfirereaction = undefined;
}

manage_external_water_in_sub() {
  var_0 = getEntArray("dyn_water_sub", "script_noteworthy");
  var_1 = getEntArray("dyn_water_breachpatch_low", "script_noteworthy");
  var_2 = getEntArray("water_flyout_off", "script_noteworthy");
  common_scripts\utility::flag_wait("ladder_done");
  hideshowents(var_0, 1);
  hideshowents(var_1, 1);
  hideshowents(var_2, 1);
  common_scripts\utility::flag_wait("sub_exit_player_going_out_hatch");
  hideshowents(var_0, 0);
  hideshowents(var_1, 0);
  hideshowents(var_2, 0);
}

backtrack_fail() {
  level endon("get_on_zodiac");
  common_scripts\utility::flag_wait("player_sub_backtrack");
  setDvar("ui_deadquote", "@NY_HARBOR_FAIL_SUB_DECK_ZODIAC");
  maps\_utility::missionfailedwrapper();
}

introscreen_generic_fade_out(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1.5;
  }
  var_4 = newhudelem();
  var_4.x = 0;
  var_4.y = 0;
  var_4.horzalign = "fullscreen";
  var_4.vertalign = "fullscreen";
  var_4.foreground = 1;
  var_4 setshader(var_0, 640, 480);

  if(isDefined(var_3) && var_3 > 0) {
    var_4.alpha = 0;
    var_4 fadeovertime(var_3);
    var_4.alpha = 1;
    wait(var_3);
  }

  wait(var_1);

  if(isDefined(var_2) && var_2 > 0) {
    var_4.alpha = 1;
    var_4 fadeovertime(var_2);
    var_4.alpha = 0;
    wait(var_2);
  }

  var_4 destroy();
}

demo_feed_lines(var_0, var_1) {
  var_2 = getarraykeys(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    var_5 = var_3 * var_1 + 1;
    maps\_utility::delaythread(var_5, ::centerlinethread, var_0[var_4], var_0.size - var_3 - 1, var_1, var_4);
  }
}

centerlinethread(var_0, var_1, var_2, var_3) {
  level notify("new_introscreen_element");
  var_4 = newhudelem();
  var_4.x = 0;
  var_4.y = 0;
  var_4.alignx = "center";
  var_4.aligny = "middle";
  var_4.horzalign = "center";
  var_4.vertalign = "middle_adjustable";
  var_4.sort = 1;
  var_4.foreground = 1;
  var_4 settext(var_0);
  var_4.alpha = 0;
  var_4 fadeovertime(0.2);
  var_4.alpha = 1;
  var_4.hidewheninmenu = 1;
  var_4.fontscale = 2.4;
  var_4.color = (0.8, 1, 0.8);
  var_4.font = "objective";
  var_4.glowcolor = (0.3, 0.6, 0.3);
  var_4.glowalpha = 1;
  var_5 = int(var_2 * 1000 + 4000);
  var_4 setpulsefx(30, var_5, 700);
  thread maps\_introscreen::hudelem_destroy(var_4);

  if(!isDefined(var_3)) {
    return;
  }
  if(!isstring(var_3)) {
    return;
  }
  if(var_3 != "date") {
    return;
  }
}