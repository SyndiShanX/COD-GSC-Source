/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\cornered_code_rappel_allies.gsc
************************************************/

ally_rappel_start_aiming(var_0) {
  if(isDefined(self.is_aiming) && self.is_aiming) {
    return;
  }
  ally_rappel_stop_aiming();
  self.israppelshooting = 0;
  self.perfectaccuracy = 0;
  self.previousaccuracy = self.baseaccuracy;
  self.is_aiming = 1;
  self.no_ai = 1;
  self.rappel_type_aim = var_0;
  maps\_utility::disable_pain();
  self animcustom(::custom_aim);
}

#using_animtree("generic_human");

ally_rappel_stop_aiming() {
  if(!isDefined(self.is_aiming) || !self.is_aiming) {
    return;
  }
  self notify("stop_rappel_aim");
  self notify("stop_rappel_aim_track");
  self notify("stop_rappel_aim_shoot");
  self.israppelshooting = undefined;
  self.perfectaccuracy = undefined;
  self.previousaccuracy = undefined;
  self.is_aiming = undefined;
  self.no_ai = undefined;
  self.rappel_type_aim = undefined;
  self.angle_facing_wall = undefined;
  self.rappel_aim_idle_thread = undefined;
  self.rappel_shooting_loop = undefined;
  self.aim2_target = undefined;
  self.aim4_target = undefined;
  self.aim6_target = undefined;
  self.aim8_target = undefined;
  self.pitch_target = undefined;
  self.yaw_target = undefined;
  self.rappel_enemy = undefined;
  self.rappel_last_enemy_timer = undefined;
  self.rappel_reloading = undefined;
  maps\_utility::enable_pain();
  self.lastenemy = undefined;
  self clearanim(%exposed_modern, 0.2);
  self clearanim(%exposed_aiming, 0.2);
  self clearanim(%rappel_aim, 0.2);
  self clearanim(%rappel_fire, 0.2);
  self clearanim(%rappel_idle, 0.2);
  self.upaimlimit = 45;
  self.downaimlimit = -45;
  self.rightaimlimit = 45;
  self.leftaimlimit = -45;
}

ally_rappel_start_shooting() {
  self.israppelshooting = 1;
}

ally_rappel_stop_shooting() {
  self.israppelshooting = 0;
}

ally_rappel_set_perfect_accuracy(var_0) {
  self.perfectaccuracy = var_0;

  if(var_0) {
    self.previousaccuracy = self.accuracy;
    maps\_utility::set_baseaccuracy(9999);
    self.accuracy = 9999;
  } else {
    maps\_utility::set_baseaccuracy(self.previousaccuracy);
    self.accuracy = self.previousaccuracy;
  }
}

ally_is_aiming() {
  return isDefined(self.is_aiming) && self.is_aiming;
}

ally_is_calm_idling() {
  return isDefined(self.is_calm_idling) && self.is_calm_idling;
}

ally_rappel_start_rope(var_0) {
  var_1 = ally_rappel_get_rope_start(var_0);

  if(!isDefined(var_1)) {
    return;
  }
  self.is_on_rope = 1;
  ally_rappel_setup_rope(var_0, var_1);
  thread ally_rappel_rope(var_0, var_1);
  thread maps\cornered_code::ally_rappel_footsteps();
}

ally_rappel_stop_rope() {
  if(!isDefined(self.is_on_rope) || !self.is_on_rope) {
    return;
  }
  self.is_on_rope = undefined;
  self notify("stop_rope_management");
  self.cnd_rappel_tele_rope unlink();
  self notify("stop_rappel_footsteps");
}

ally_rappel_rope_cleanup() {
  maps\cornered_code::delete_if_defined(self.rappel_physical_rope_animation_origin);
  maps\cornered_code::delete_if_defined(self.rappel_physical_rope_origin);
}

ally_rappel_start_movement_horizontal(var_0, var_1, var_2) {
  ally_rappel_movement_setup(var_0, var_2);
  ally_rappel_start_movement_horizontal_internal(var_0, var_1, var_2);
}

ally_rappel_pause_movement_horizontal(var_0) {
  self.pause_horz = var_0;
}

ally_start_calm_idle(var_0) {
  if(isDefined(self.is_calm_idling) && self.is_calm_idling) {
    return;
  }
  self.is_calm_idling = 1;
  self.no_ai = 1;
  self.rappel_type_aim = var_0;
  maps\_utility::disable_pain();
  self animcustom(::ally_calm_idle_internal);
}

ally_stop_calm_idle() {
  if(!isDefined(self.is_calm_idling) || !self.is_calm_idling) {
    return;
  }
  self notify("stop_calm_idle");
  self.is_calm_idling = undefined;
  self.no_ai = 0;
  self.angle_facing_wall = undefined;
  self.rappel_type_aim = undefined;
  maps\_utility::enable_pain();
}

ally_calm_idle_internal() {
  self endon("stop_calm_idle");
  var_0 = ally_rappel_get_aim_anim(5);
  self.angle_facing_wall = maps\cornered_code::rappel_get_angle_facing_wall(self.rappel_type_aim);
  self animmode("nogravity");
  self orientmode("face angle", self.angle_facing_wall);
  var_1 = undefined;

  for(;;) {
    self setanimknob(%rappel_aim, 1, 0.2, 1.0);
    self setanimknob(var_0, 1, 0.2, 1.0);
    wait 0.1;
    self setanim(%rappel_idle, 1, 0.2, 1.0);
    var_2 = self.animname + "_idle";
    var_3 = aim_idle_get_random();
    self setflaggedanimknoblimitedrestart(var_2, var_3, 1, 0.2, 1.0);
    self waittillmatch(var_2, "end");
    var_1 = calm_idle_get_random(var_1);
    var_4 = level.scr_anim[self.animname][var_1];
    self setflaggedanimknoblimitedrestart(var_2, var_4, 1.0, 0.2, 1.0);
    self waittillmatch(var_2, "end");
  }
}

calm_idle_get_random(var_0) {
  var_1 = 1;
  var_2 = 4;
  var_3 = randomintrange(var_1, var_2 + 1);
  var_4 = "cnd_rappel_stealth_fidgit_" + var_3;

  if(isDefined(var_0) && var_0 == var_4) {
    var_3 = var_3 + 1;

    if(var_3 == var_2 + 1)
      var_3 = var_1;

    var_4 = "cnd_rappel_stealth_fidgit_" + var_3;
  }

  return var_4;
}

ally_setup_aim(var_0) {
  var_1 = 1;

  if(var_1)
    self setanimknob(%rappel_aim, 1, 0.2);

  self setanimknob(ally_rappel_get_aim_anim(5), 1, var_0);
  self setanimknob(ally_rappel_get_aim_anim(2), 1, var_0);
  self setanimknob(ally_rappel_get_aim_anim(8), 1, var_0);
  self setanimknob(ally_rappel_get_aim_anim(4), 1, var_0);
  self setanimknob(ally_rappel_get_aim_anim(6), 1, var_0);
  self setanimlimited(rappel_aim_get_parent_node(2), 0, var_0);
  self setanimlimited(rappel_aim_get_parent_node(8), 0, var_0);
  self setanimlimited(rappel_aim_get_parent_node(4), 0, var_0);
  self setanimlimited(rappel_aim_get_parent_node(6), 0, var_0);
}

aim_idle_thread() {
  self endon("end_aim_idle_thread");

  if(isDefined(self.rappel_aim_idle_thread)) {
    return;
  }
  self.rappel_aim_idle_thread = 1;
  wait 0.1;
  self setanimlimited(%rappel_idle, 1, 0.2);
  var_0 = 0;

  for(;;) {
    var_1 = "idle" + var_0;
    var_2 = aim_idle_get_random();
    self setflaggedanimknoblimitedrestart(var_1, var_2, 1, 0.2);
    self waittillmatch(var_1, "end");
    var_0++;
  }

  self clearanim(%rappel_idle, 0.1);
}

aim_idle_get_random() {
  var_0 = isDefined(self.israppelshooting) && self.israppelshooting;
  var_1 = isDefined(self.rappel_disable_fidgit) && self.rappel_do_not_fidgit;

  if(var_0 || var_1)
    return % cnd_rappel_idle;
  else {
    var_2 = randomintrange(0, 3);

    switch (var_2) {
      case 0:
        return % cnd_rappel_idle;
      case 1:
        return % cnd_rappel_idle_fidgit_1;
      case 2:
        return % cnd_rappel_idle_fidgit_2;
    }
  }
}

ally_rappel_get_enemy() {
  var_0 = gettime();
  var_1 = var_0 + 5000;
  var_2 = isDefined(self.rappel_enemy) && isalive(self.rappel_enemy);
  var_3 = var_2 && self cansee(self.rappel_enemy);
  var_4 = 0;
  var_5 = undefined;

  if(var_2) {
    var_5 = level.player maps\cornered_code::player_get_favorite_enemy(1500);

    if(isDefined(var_5) && self.rappel_enemy == var_5)
      var_4 = 1;
  }

  if(var_3)
    self.rappel_last_enemy_timer = var_1;

  var_6 = var_2 && self.rappel_last_enemy_timer < var_0;
  var_7 = !var_2 || var_6 || var_4;

  if(var_7) {
    var_8 = getaiarray("axis");
    var_9 = -1;
    var_10 = undefined;

    if(!isDefined(var_5))
      var_5 = level.player maps\cornered_code::player_get_favorite_enemy(1500);

    foreach(var_12 in var_8) {
      if(!isalive(var_12)) {
        continue;
      }
      if(!self cansee(var_12)) {
        continue;
      }
      if(isDefined(var_12.ignoreme) && var_12.ignoreme) {
        continue;
      }
      if(isDefined(var_5) && var_12 == var_5) {
        continue;
      }
      var_13 = distancesquared(self.origin, var_12.origin);

      if(var_9 == -1 || var_13 < var_9) {
        var_10 = var_12;
        var_9 = var_13;
      }
    }

    self.rappel_last_enemy_timer = var_1;
    self.rappel_enemy = var_10;
  }

  return self.rappel_enemy;
}

end_aim_idle_thread() {
  self notify("end_aim_idle_thread");
  self.rappel_aim_idle_thread = undefined;
  self clearanim(%rappel_idle, 0.1);
}

custom_aim() {
  self endon("stop_rappel_aim");
  self endon("death");
  self notify("stop_loop");
  custom_aim_internal();
  self waittill("forever");
}

custom_aim_internal() {
  self.angle_facing_wall = maps\cornered_code::rappel_get_angle_facing_wall(self.rappel_type_aim);
  self animmode("nogravity");
  self orientmode("face angle", self.angle_facing_wall);
  ally_setup_aim(0.2);
  childthread aim_idle_thread();
  self.upaimlimit = 89.8;
  self.downaimlimit = -19.6;
  self.rightaimlimit = 89.2;
  self.leftaimlimit = -90.2;
  var_0 = rappel_aim_get_parent_node(2);
  var_1 = rappel_aim_get_parent_node(4);
  var_2 = rappel_aim_get_parent_node(6);
  var_3 = rappel_aim_get_parent_node(8);
  thread trackloop(var_3, var_1, var_2, var_0);

  if(!isDefined(self.rappel_shooting_loop) || !self.rappel_shooting_loop)
    thread ally_shooting_loop();
}

trackloop(var_0, var_1, var_2, var_3) {
  self endon("stop_rappel_aim_track");
  self endon("death");
  var_4 = (0, 0, 0);
  var_5 = 0;
  var_6 = 0;
  var_7 = (var_5, var_6, 0);
  var_8 = 0;

  for(;;) {
    var_9 = self getEye();
    var_10 = ally_rappel_get_enemy();

    if(isDefined(var_10)) {
      self.shootent = var_10;
      self.shootpos = self.shootent getshootatpos();
    }

    var_11 = undefined;

    if(isDefined(self.shootpos))
      var_11 = self.shootpos;

    if(isDefined(self.shootent))
      var_11 = self.shootent getshootatpos();

    var_12 = isDefined(var_11);
    var_13 = (0, 0, 0);

    if(var_12)
      var_13 = var_11;

    var_14 = 0;
    var_15 = isDefined(self.stepoutyaw);

    if(var_15)
      var_14 = self.stepoutyaw;

    var_4 = self getaimangle(var_9, var_13, var_12, var_7, var_14, var_15, var_8);
    var_16 = var_4[0];
    var_17 = var_4[1];
    var_4 = undefined;
    trackloop_setanimweights(var_0, var_1, var_2, var_3, var_16, var_17);
    common_scripts\utility::waitframe();
  }
}

trackloop_setanimweights(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = self.rappel_enemy;
  var_7 = isDefined(self.rappel_reloading) && self.rappel_reloading;
  var_8 = !var_7 && isDefined(var_6) && (!isDefined(self.lastenemy) || var_6 != self.lastenemy);
  var_9 = isDefined(self.pitch_target) && isDefined(self.yaw_target);

  if(var_7) {
    var_4 = 0;
    var_5 = 0;

    if(!isDefined(self.reload_aim_active)) {
      self.reload_aim_active = 1;
      var_9 = 1;
    }
  }

  if(var_8 || var_9) {
    self.lastenemy = var_6;
    ally_set_initial_weights(var_0, var_1, var_2, var_3, var_4, var_5);
    ally_transition_to_target_weights(var_0, var_1, var_2, var_3);
  } else if(var_7) {
    self.reload_aim_active = undefined;
    ally_reset_weights();
    self notify("aimed_forward");
  } else if(isDefined(var_6))
    ally_aim_closer_to(var_0, var_1, var_2, var_3, var_4, var_5);
}

ally_reset_weights() {
  self clearanim(%rappel_aim, 0.2);
}

ally_rappel_get_aim_yaw() {
  var_0 = self.angle_facing_wall - angleclamp180(self gettagangles("tag_flash")[1]);
  return var_0;
}

ally_rappel_get_aim_pitch() {
  var_0 = -1 * angleclamp180(self gettagangles("tag_flash")[0]);
  return var_0;
}

get_weight_change(var_0, var_1) {
  if(var_0 == 2)
    return var_1 / 8.7 * 0.1;
  else if(var_0 == 8)
    return var_1 / 2.2 * 0.1;
  else if(var_0 == 4)
    return var_1 / 8.8 * 0.1;
  else if(var_0 == 6)
    return var_1 / 9.1 * 0.1;
}

ally_aim_closer_to(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = 0.1;
  var_7 = 0.1;
  var_8 = 1;
  var_9 = ally_rappel_get_aim_yaw();
  var_10 = var_5 - var_9;

  if(abs(var_10) < 1)
    var_8 = 0;

  var_11 = ally_rappel_get_aim_pitch();
  var_12 = var_4 - var_11;

  if(abs(var_12) < 1)
    var_8 = 0;

  var_13 = abs(var_5) > 0;
  var_14 = abs(var_10) > abs(var_12);
  var_15 = abs(var_10) > var_6;
  var_16 = abs(var_4) > 0;
  var_17 = abs(var_12) > var_7;
  var_18 = 0;

  if(var_13 && var_14 && var_15) {
    if(var_5 > 0)
      _ally_aim_closer_set_anim_weight(var_2, 6, var_1, var_10, var_8);
    else if(var_5 < 0)
      _ally_aim_closer_set_anim_weight(var_1, 4, var_2, var_10, var_8);
  } else if(var_16 && var_17) {
    if(var_4 > 0)
      _ally_aim_closer_set_anim_weight(var_3, 2, var_0, var_12, var_8);
    else if(var_4 < 0)
      _ally_aim_closer_set_anim_weight(var_0, 8, var_3, var_12, var_8);
  }
}

_ally_aim_closer_set_anim_weight(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0.1;
  var_6 = 2;

  if(!var_4)
    var_6 = 0.5;

  var_7 = self getanimweight(var_0);
  var_8 = get_weight_change(var_1, var_6);
  var_8 = var_8 * common_scripts\utility::sign(var_3);

  if(var_1 == 4 || var_1 == 8)
    var_8 = var_8 * -1;

  var_9 = var_7 + var_8;
  var_9 = clamp(var_9, 0, 1);
  self setanimlimited(var_2, 0, var_5, 1, 1);
  self setanimlimited(var_0, var_9, var_5, 1, 1);
}

ally_transition_to_target_weights(var_0, var_1, var_2, var_3) {
  if(isDefined(self.aim2_target) && _ally_transition_to_weight(var_0, 8, var_3, 2, self.aim2_target))
    self.aim2_target = undefined;

  if(isDefined(self.aim4_target) && _ally_transition_to_weight(var_1, 4, var_2, 6, self.aim4_target))
    self.aim4_target = undefined;

  if(isDefined(self.aim6_target) && _ally_transition_to_weight(var_2, 6, var_1, 4, self.aim6_target))
    self.aim6_target = undefined;

  if(isDefined(self.aim8_target) && _ally_transition_to_weight(var_3, 2, var_0, 8, self.aim8_target))
    self.aim8_target = undefined;

  if(!isDefined(self.aim2_target) && !isDefined(self.aim4_target) && !isDefined(self.aim6_target) && !isDefined(self.aim8_target)) {
    self.pitch_target = undefined;
    self.yaw_target = undefined;
  }
}

_ally_transition_to_weight(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0.1;
  var_6 = 0.1;
  var_7 = 0.1;
  var_8 = 0;
  var_9 = 0;
  var_10 = 15;
  var_11 = self getanimweight(var_2);

  if(var_11 > 0) {
    var_9 = 0 - var_11;
    var_5 = get_weight_change(var_3, var_10);
    var_0 = var_2;
  } else {
    var_11 = self getanimweight(var_0);
    var_9 = var_4 - var_11;

    if(abs(var_9) <= var_6)
      return 1;

    var_5 = get_weight_change(var_1, var_10);
  }

  var_5 = var_5 * common_scripts\utility::sign(var_9);

  if(var_5 > 0)
    var_5 = min(var_5, var_9);
  else
    var_5 = max(var_5, var_9);

  var_8 = var_11 + var_5;
  self setanimlimited(var_0, var_8, var_7, 1, 1);
  return 0;
}

ally_set_initial_weights(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(var_5 >= 0) {
    self.aim6_target = _ally_get_yaw_right_aim_weight(var_5);
    self.aim4_target = undefined;
  } else if(var_5 < 0) {
    self.aim4_target = _ally_get_yaw_left_aim_weight(var_5);
    self.aim6_target = undefined;
  }

  if(var_4 >= 0) {
    self.aim8_target = _ally_get_pitch_up_aim_weight(var_4);
    self.aim2_target = undefined;
  } else if(var_4 < 0) {
    self.aim2_target = _ally_get_pitch_down_aim_weight(var_4);
    self.aim8_target = undefined;
  }

  self.pitch_target = var_4;
  self.yaw_target = var_5;
}

_ally_get_pitch_down_aim_weight(var_0) {
  return clamp(abs(var_0) * 0.0517 - 0.0138, 0, 1.0);
}

_ally_get_pitch_up_aim_weight(var_0) {
  return clamp(abs(var_0) * 0.0111 + 0.0032, 0, 1.0);
}

_ally_get_yaw_right_aim_weight(var_0) {
  return clamp(abs(var_0) * 0.0112 - 0.0025, 0, 1.0);
}

_ally_get_yaw_left_aim_weight(var_0) {
  return clamp(abs(var_0) * 0.011 + 0.0031, 0, 1.0);
}

rappel_aim_get_parent_node(var_0) {
  if(var_0 == 2)
    return % rappel_aim_8;
  else if(var_0 == 4)
    return % rappel_aim_4;
  else if(var_0 == 6)
    return % rappel_aim_6;
  else if(var_0 == 8)
    return % rappel_aim_2;
  else {}
}

ally_rappel_get_aim_anim(var_0) {
  if(var_0 == 2)
    return % cnd_rappel_stealth_aim_8_baker_add;
  else if(var_0 == 4)
    return % cnd_rappel_stealth_aim_4_baker_add;
  else if(var_0 == 5)
    return % cnd_rappel_stealth_aim_5_baker_add;
  else if(var_0 == 6)
    return % cnd_rappel_stealth_aim_6_baker_add;
  else if(var_0 == 8)
    return % cnd_rappel_stealth_aim_2_baker_add;
  else {}
}

ally_shooting_loop() {
  self endon("stop_rappel_aim_shoot");
  self endon("death");
  self.rappel_shooting_loop = 1;

  for(;;) {
    common_scripts\utility::waitframe();

    if(!isDefined(self.israppelshooting) || !self.israppelshooting) {
      continue;
    }
    var_3 = isDefined(self.shootent);
    ally_rappel_reload();

    if(aimed_at_shoot_ent_or_pos() && var_3) {
      self.shootstyle = "burst";
      self.fastburst = 0;
      ally_shoot_at_enemy();
      hide_fire_show_aim_idle();
    }
  }
}

aimed_at_shoot_ent_or_pos() {
  var_0 = 5;
  var_1 = 5;

  if(!isDefined(self.shootpos))
    return 0;

  var_2 = self getmuzzleangle();
  var_3 = self getmuzzlepos();
  var_4 = vectortoangles(self.shootpos - var_3);
  var_5 = animscripts\utility::absangleclamp180(var_2[1] - var_4[1]);

  if(var_5 > var_0)
    return 0;

  return animscripts\utility::absangleclamp180(var_2[0] - var_4[0]) <= var_1;
}

ally_shoot_at_enemy() {
  self endon("shoot_behavior_change");
  self endon("stopShooting");
  var_0 = ally_get_fire_animation();

  if(animscripts\combat_utility::aimbutdontshoot()) {
    return;
  }
  if(self.shootstyle == "full")
    ally_fire_until_out_of_ammo(var_0, 1, animscripts\shared::decidenumshotsforfull());
  else if(self.shootstyle == "burst" || self.shootstyle == "semi") {
    var_1 = 4;
    ally_fire_until_out_of_ammo(var_0, 1, var_1);
  } else if(self.shootstyle == "single")
    ally_fire_until_out_of_ammo(var_0, 1, 1);
  else
    self waittill("hell freezes over");
}

ally_fire_until_out_of_ammo(var_0, var_1, var_2) {
  var_3 = "fireAnim_" + animscripts\combat_utility::getuniqueflagnameindex();
  maps\_gameskill::resetmisstime();
  show_fire_hide_aim_idle();
  var_4 = 1.0;

  if(isDefined(self.shootrateoverride))
    var_4 = self.shootrateoverride;
  else if(self.shootstyle == "full")
    var_4 = animscripts\weaponlist::autoshootanimrate() * randomfloatrange(0.5, 1.0);
  else if(self.shootstyle == "burst")
    var_4 = animscripts\weaponlist::burstshootanimrate();
  else if(animscripts\utility::usingsidearm())
    var_4 = 3.0;
  else if(animscripts\utility::usingshotgun())
    var_4 = animscripts\combat_utility::shotgunfirerate();

  self setflaggedanimknobrestart(var_3, var_0, 1, 0.2, var_4);
  ally_fire_until_out_of_ammo_internal(var_3, var_0, var_1, var_2);
  hide_fire_show_aim_idle();
}

ally_fire_until_out_of_ammo_internal(var_0, var_1, var_2, var_3) {
  self endon("enemy");

  if(var_2) {
    thread animscripts\combat_utility::notifyonanimend(var_0, "fireAnimEnd");
    self endon("fireAnimEnd");
  }

  if(!isDefined(var_3))
    var_3 = -1;

  var_4 = 0;
  var_5 = animhasnotetrack(var_1, "fire");
  thread animscripts\combat_utility::fireuntiloutofammo_waittillended();

  while(var_4 < var_3 && var_3 > 0) {
    if(var_5)
      self waittillmatch(var_0, "fire");

    if(!self.bulletsinclip) {
      if(!animscripts\combat_utility::cheatammoifnecessary()) {
        break;
      }
    }

    shoot_at_shoot_ent_or_pos();
    self.bulletsinclip--;
    var_4++;
    thread animscripts\combat_utility::shotgunpumpsound(var_0);

    if(self.fastburst && var_4 == var_3) {
      break;
    }

    if(!var_5 || var_3 == 1 && self.shootstyle == "single")
      self waittillmatch(var_0, "end");
  }

  self shootstopsound();

  if(var_2)
    self notify("fireAnimEnd");
}

shoot_at_shoot_ent_or_pos() {
  if(isDefined(self.shootpos)) {
    var_0 = self getmuzzlepos();
    var_1 = self.shootpos;
    var_2 = 4;

    if(!isDefined(self.perfectaccuracy) || self.perfectaccuracy)
      var_3 = bulletspread(var_0, var_1, var_2);
    else
      var_3 = var_1;

    self.a.lastshoottime = gettime();
    self notify("shooting");
    self shoot(1, var_3, 1);
  }
}

start_fire_and_aim_idle_thread() {
  if(!isDefined(self.rappel_aim_idle_thread)) {
    self.lastenemy = undefined;
    thread custom_aim_internal();
  }
}

end_fire_and_anim_idle_thread() {
  end_aim_idle_thread();
  self clearanim(%rappel_fire, 0.1);
  self notify("stop_rappel_aim_track");
}

show_fire_hide_aim_idle() {
  if(isDefined(self.rappel_aim_idle_thread))
    self setanim(%rappel_idle, 0, 0.2);

  self setanim(%rappel_fire, 1, 0.1);
}

hide_fire_show_aim_idle() {
  if(isDefined(self.rappel_aim_idle_thread))
    self setanim(%rappel_idle, 1, 0.2);

  self setanim(%rappel_fire, 0, 0.1);
}

ally_get_fire_animation() {
  return % cnd_rappel_stealth_fire_baker_add;
}

ally_rappel_reload() {
  if(!animscripts\combat_utility::needtoreload(0.1))
    return 0;

  self.rappel_reloading = 1;
  common_scripts\utility::waittill_notify_or_timeout_return("aimed_forward", 5.0);
  end_fire_and_anim_idle_thread();
  var_0 = % cnd_rappel_fire_reload_1;
  self.finishedreload = 0;

  if(weaponclass(self.weapon) == "pistol")
    self orientmode("face default");

  ally_do_reload_anim(var_0);
  self notify("abort_reload");

  if(self.finishedreload)
    animscripts\weaponlist::refillclip();

  self clearanim(%cnd_rappel_fire_reload_1, 0.2);
  self.keepclaimednode = 0;
  self.rappel_reloading = undefined;
  self notify("rappel_done_reloading");
  self.finishedreload = undefined;
  start_fire_and_aim_idle_thread();
  common_scripts\utility::waitframe();
  return 1;
}

ally_do_reload_anim(var_0) {
  self endon("abort_reload");
  var_1 = 1;

  if(!animscripts\utility::usingsidearm() && !animscripts\utility::isshotgun(self.weapon) && isDefined(self.rappel_enemy) && self cansee(self.rappel_enemy) && distancesquared(self.rappel_enemy.origin, self.origin) < 1048576)
    var_1 = 1.2;

  var_2 = "reload_" + animscripts\combat_utility::getuniqueflagnameindex();
  self clearanim(%root, 0.2);
  self setflaggedanimrestart(var_2, var_0, 1, 0.2, var_1);
  animscripts\shared::donotetracks(var_2);
  self.finishedreload = 1;
}

ally_rappel_start_movement_horizontal_internal(var_0, var_1, var_2) {
  level endon(var_2);

  if(var_0 == "stealth")
    level endon(self.stealth_broken_flag);

  var_3 = 2;
  var_4 = self.animname + "_is_moving";
  common_scripts\utility::flag_clear(var_4);
  var_5 = self.animname + "_stop_anim_move";
  common_scripts\utility::flag_clear(var_5);
  self.movement_back = 0;
  self.move_type = "idle";
  self.last_move_time = 0;
  var_6 = "none";
  thread animate_after_movement(var_4, var_0);

  for(;;) {
    if(isDefined(self.pause_horz) && self.pause_horz) {
      common_scripts\utility::waitframe();
      continue;
    }

    var_7 = isDefined(self.move_to_see_enemies) && self.move_to_see_enemies;

    if(!var_7)
      var_6 = "none";

    var_8 = ally_rappel_distance2dsquared_to_player();
    var_9 = !isDefined(self.player_moving_toward_me) || self.player_moving_toward_me;
    var_10 = var_8 <= 3600;
    var_11 = var_9 || var_10;

    if(var_8 < self.close_distance_sq || var_6 == "away") {
      if(!common_scripts\utility::flag(var_4) && var_9 && _ally_is_current_volume(self.in_volume))
        thread animate_til_volume("away", var_4, self.center_volume, self.out_volume, var_2, var_0);
      else if(!common_scripts\utility::flag(var_4) && var_9 && _ally_is_current_volume(self.center_volume))
        thread animate_til_volume("away", var_4, self.out_volume, undefined, var_2, var_0);
      else if(!common_scripts\utility::flag(var_4) && var_9 && _ally_is_current_volume(self.out_volume)) {} else if(self.movement_back)
        thread animate_opposite_direction(var_4, var_2, var_0, common_scripts\utility::flag(var_4));
    } else if(var_8 > self.far_distance_sq || var_6 == "back") {
      var_12 = gettime() - self.last_move_time;

      if(common_scripts\utility::flag(var_4) || var_12 < var_3 * 1000 || var_9) {
        common_scripts\utility::waitframe();
        continue;
      }

      if(_ally_is_current_volume(self.out_volume)) {
        var_11 = 0;
        var_13 = self.center_volume;

        if(var_0 == "combat") {
          var_14 = common_scripts\utility::getstruct(self.center_volume.targetname + "_struct_" + var_1, "targetname");
          var_15 = distance2dsquared(level.player.origin, var_14.origin);
          var_11 = var_15 > self.distance_from_next_volume_sq;
        } else {
          var_15 = distance2dsquared(level.player.origin, var_13 getcentroid());
          var_11 = var_15 > self.distance_from_next_volume_sq;
        }

        if(var_11)
          thread animate_til_volume("back", var_4, self.center_volume, self.in_volume, var_2, var_0);
      } else if(_ally_is_current_volume(self.center_volume)) {
        var_11 = 0;
        var_13 = self.in_volume;

        if(var_0 == "combat") {
          var_14 = common_scripts\utility::getstruct(self.in_volume.targetname + "_struct_" + var_1, "targetname");
          var_15 = distance2dsquared(level.player.origin, var_14.origin);
          var_11 = var_15 > self.distance_from_next_volume_sq;
        } else {
          var_15 = distance2dsquared(level.player.origin, var_13 getcentroid());
          var_11 = var_15 > self.distance_from_next_volume_sq;
        }

        if(var_11)
          thread animate_til_volume("back", var_4, self.in_volume, undefined, var_2, var_0);
      } else if(_ally_is_current_volume(self.in_volume)) {} else
        thread animate_til_volume("back", var_4, self.center_volume, self.in_volume, var_2, var_0);
    } else if(!common_scripts\utility::flag(var_4) && isDefined(self.move_to_see_enemies) && self.move_to_see_enemies) {
      var_16 = 0;
      var_17 = getaiarray("axis");

      foreach(var_19 in var_17) {
        if(self cansee(var_19)) {
          var_16 = 1;
          break;
        }
      }

      if(var_6 == "away" || var_6 == "none")
        var_6 = "back";
      else
        var_6 = "away";
    }

    common_scripts\utility::waitframe();
  }
}

ally_rappel_distance2dsquared_to_player() {
  var_0 = self gettagorigin("J_MainRoot");

  if(isDefined(level.rpl_plyr_anim_origin))
    var_1 = level.rpl_plyr_anim_origin.origin;
  else
    var_1 = level.player.origin;

  var_2 = distance2dsquared(var_0, var_1);
  return var_2;
}

_ally_is_current_volume(var_0) {
  return isDefined(var_0) && (self istouching(var_0) || self.last_volume == var_0);
}

_ally_set_last_volume() {
  var_0 = -1;
  self.last_volume = undefined;

  if(isDefined(self.in_volume)) {
    self.last_volume = self.in_volume;

    if(self istouching(self.in_volume)) {
      return;
    }
    var_0 = distance2dsquared(self.origin, self.in_volume getcentroid());
  }

  if(isDefined(self.center_volume)) {
    var_1 = distance2dsquared(self.origin, self.center_volume getcentroid());

    if(var_0 == -1 || var_1 < var_0 || self istouching(self.center_volume)) {
      self.last_volume = self.center_volume;
      var_0 = var_1;
    }

    if(self istouching(self.center_volume))
      return;
  }

  if(isDefined(self.out_volume)) {
    var_1 = distance2dsquared(self.origin, self.out_volume getcentroid());

    if(var_0 == -1 || var_1 < var_0 || self istouching(self.out_volume))
      self.last_volume = self.out_volume;
  }
}

ally_rappel_movement_setup(var_0, var_1) {
  if(var_0 == "stealth") {
    self.center_volume = getent(self.animname + "_stealth_in", "targetname");
    self.out_volume = getent(self.animname + "_stealth_out", "targetname");
    self.in_volume = getent(self.animname + "_stealth_center", "targetname");
    _ally_set_last_volume();
  } else {
    self.center_volume = getent(self.animname + "_center_combat", "targetname");
    self.in_volume = getent(self.animname + "_in_combat", "targetname");
    self.out_volume = getent(self.animname + "_out_combat", "targetname");
    self.last_volume = getent(self.animname + "_in_combat", "targetname");
  }

  if(self.animname == "rorke") {
    if(var_0 == "stealth") {
      self.close_distance_sq = 48400;
      self.far_distance_sq = 176400;
      self.distance_from_next_volume_sq = 60025;
    } else {
      self.close_distance_sq = 50625;
      self.far_distance_sq = 95625;
      self.distance_from_next_volume_sq = 60025;
    }
  } else if(var_0 == "stealth") {
    self.close_distance_sq = 48400;
    self.far_distance_sq = 176400;
    self.distance_from_next_volume_sq = 60025;
  } else {
    self.close_distance_sq = 28900;
    self.far_distance_sq = 136900;
    self.distance_from_next_volume_sq = 36100;
  }
}

animate_til_volume(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon(var_4);

  if(var_5 == "stealth")
    level endon(self.stealth_broken_flag);

  level endon(self.animname + "_stop_anim_move");

  if(!isDefined(var_6))
    var_6 = 1;

  self notify("stop_loop");
  ally_rappel_stop_shooting();
  ally_rappel_stop_aiming();
  ally_stop_calm_idle();
  common_scripts\utility::flag_set(var_1);

  if(var_0 == "away") {
    self.movement_back = 0;
    self.move_type = "move_away_start";

    if(var_6)
      maps\_anim::anim_single_solo(self, "move_away_start");

    thread maps\_anim::anim_loop_solo(self, "move_away", "stop_loop");
    self.move_type = "move_away";
  } else if(var_0 == "back") {
    self.movement_back = 1;
    self.move_type = "move_back_start";

    if(var_6)
      maps\_anim::anim_single_solo(self, "move_back_start");

    thread maps\_anim::anim_loop_solo(self, "move_back", "stop_loop");
    self.move_type = "move_back";
  }

  if(!isDefined(var_2) && isDefined(var_3)) {
    var_2 = var_3;
    var_3 = undefined;
  }

  for(;;) {
    if(self istouching(var_2)) {
      var_7 = ally_rappel_distance2dsquared_to_player();

      if(var_0 == "away") {
        if(var_7 < self.close_distance_sq) {
          if(isDefined(var_3)) {
            self.last_volume = var_2;
            var_2 = var_3;
            var_3 = undefined;
          } else {
            self.last_volume = var_2;
            self notify("stop_loop");
            waittillframeend;
            self.move_type = "move_away_stop";
            maps\_anim::anim_single_solo(self, "move_away_stop");
            break;
          }
        } else {
          self.last_volume = var_2;
          self notify("stop_loop");
          waittillframeend;
          self.move_type = "move_away_stop";
          maps\_anim::anim_single_solo(self, "move_away_stop");
          break;
        }
      } else if(var_7 > self.far_distance_sq) {
        if(isDefined(var_3)) {
          self.last_volume = var_2;
          var_2 = var_3;
          var_3 = undefined;
        } else {
          self.last_volume = var_2;
          self.movement_back = 0;
          self notify("stop_loop");
          waittillframeend;
          self.move_type = "move_back_stop";
          maps\_anim::anim_single_solo(self, "move_back_stop");
          break;
        }
      } else {
        self.last_volume = var_2;
        self.movement_back = 0;
        self notify("stop_loop");
        waittillframeend;
        self.move_type = "move_back_stop";
        maps\_anim::anim_single_solo(self, "move_back_stop");
        break;
      }
    }

    wait 0.05;
  }

  common_scripts\utility::flag_clear(var_1);
  self.last_move_time = gettime();
  thread animate_after_movement(var_1, var_5);
}

animate_opposite_direction(var_0, var_1, var_2, var_3) {
  level endon(var_1);

  if(var_2 == "stealth")
    level endon(self.stealth_broken_flag);

  common_scripts\utility::flag_set(self.animname + "_stop_anim_move");
  common_scripts\utility::flag_clear(var_0);
  common_scripts\utility::flag_set(var_0);
  self.movement_back = 0;

  if(var_3) {
    self.move_type = "turn_away";
    self notify("stop_loop");
    maps\_anim::anim_single_solo(self, "turn_away");
    self.movement_back = 0;
  }

  common_scripts\utility::flag_clear(self.animname + "_stop_anim_move");
  self.last_move_time = gettime();

  if(isDefined(self.in_volume) && self.last_volume == self.in_volume)
    thread animate_til_volume("away", var_0, self.center_volume, self.out_volume, var_1, var_2, !var_3);
  else if(isDefined(self.center_volume) && self.last_volume == self.center_volume)
    thread animate_til_volume("away", var_0, self.out_volume, undefined, var_1, var_2, !var_3);
  else if(isDefined(self.out_volume) && self.last_volume == self.out_volume)
    thread animate_til_volume("away", var_0, self.out_volume, undefined, var_1, var_2, !var_3);
  else {}
}

animate_after_movement(var_0, var_1) {
  if(var_1 == "stealth") {
    if(common_scripts\utility::flag(self.stealth_broken_flag)) {
      ally_stop_calm_idle();
      ally_rappel_start_aiming(var_1);
      ally_rappel_start_shooting();
    } else if(isDefined(self.start_aiming_after_move) && self.start_aiming_after_move) {
      ally_stop_calm_idle();
      ally_rappel_start_aiming(var_1);
      self.start_aiming_after_move = 0;
      self notify("aim_after_move");
    } else {
      ally_rappel_stop_aiming();
      ally_start_calm_idle("stealth");
    }
  } else if(isDefined(level.flag_to_check) && !common_scripts\utility::flag(level.flag_to_check)) {
    if(level.flag_to_check == "all_rappel_one_enemies_in_front_dead") {
      ally_rappel_start_aiming(var_1);
      ally_rappel_start_shooting();
    } else if(level.flag_to_check == "all_rappel_two_enemies_in_front_dead") {
      ally_rappel_start_aiming(var_1);
      ally_rappel_start_shooting();
    }
  } else {
    self notify("stop_loop");
    ally_rappel_start_aiming(var_1);
  }

  self.move_type = "idle";
}

ally_rappel_get_rope_start(var_0) {
  if(var_0 == "stealth") {
    if(self.animname == "rorke") {
      var_1 = common_scripts\utility::getstruct("rorke_rope_ref_stealth", "targetname");
      return var_1;
    } else {
      var_1 = common_scripts\utility::getstruct("baker_rope_ref_stealth", "targetname");
      return var_1;
    }
  } else if(var_0 == "inverted") {
    if(self.animname == "rorke") {
      var_1 = common_scripts\utility::getstruct("rorke_rope_ref_inverted", "targetname");
      return var_1;
    } else {
      var_1 = common_scripts\utility::getstruct("baker_rope_ref_inverted", "targetname");
      return var_1;
    }
  } else if(var_0 == "combat") {
    if(self.animname == "rorke") {
      var_1 = common_scripts\utility::getstruct("rorke_rope_ref_combat", "targetname");
      return var_1;
    } else {
      var_1 = common_scripts\utility::getstruct("baker_rope_ref_combat", "targetname");
      return var_1;
    }
  }
}

#using_animtree("animated_props");

ally_rappel_setup_rope(var_0, var_1) {
  var_2 = var_1 common_scripts\utility::spawn_tag_origin();
  var_3 = spawn("script_model", var_2.origin);
  var_3.angles = var_1.angles + (0, -90, 0);
  var_3 setModel("generic_prop_raven");
  var_3 useanimtree(#animtree);
  var_3 linkto(var_2, "tag_origin");
  self.rappel_physical_rope_animation_origin = var_3;
  self.rappel_physical_rope_origin = var_2;
  self.rope_unwind_anim = % cnd_rappel_inv_top_rope_unwind;
  self.rope_unwind_length = 2254.0;
  var_4 = (0, 0, 0);

  if(var_0 == "combat")
    var_4 = (0, 235, 0);

  self.cnd_rappel_tele_rope = maps\_utility::spawn_anim_model("cnd_rappel_tele_rope");
  self.cnd_rappel_tele_rope.origin = self.rappel_physical_rope_animation_origin.origin;
  self.cnd_rappel_tele_rope.angles = (0, 0, 0);
  self.cnd_rappel_tele_rope linkto(self.rappel_physical_rope_animation_origin, "J_prop_1", (0, 0, 0), var_4);
  self.cnd_rappel_tele_rope setanim(self.rope_unwind_anim, 1, 0, 0);
}

ally_rappel_rope(var_0, var_1) {
  self endon("stop_rope_management");

  if(isDefined(level.start_point) && level.start_point == "rappel_stealth" && var_0 == "stealth")
    wait 0.5;

  var_2 = 46;
  var_3 = 1.0 / self.rope_unwind_length;
  var_4 = maps\cornered_code::rappel_get_plane_normal_left(var_0);
  var_5 = maps\cornered_code::rappel_get_plane_normal_out(var_0);
  var_6 = maps\cornered_code::rappel_get_plane_d(var_4, var_1.origin);
  var_7 = maps\cornered_code::rappel_get_plane_d(var_5, var_1.origin);

  for(;;) {
    var_8 = self gettagorigin("tag_stowed_back");
    var_9 = distance(var_8, var_1.origin);
    var_10 = vectordot(var_4, var_8) + var_6;
    var_11 = -1 * asin(var_10 / var_9);
    var_10 = vectordot(var_5, var_8) + var_7;
    var_12 = -1 * asin(var_10 / var_9);
    self.rappel_physical_rope_origin.angles = (var_12, self.rappel_physical_rope_origin.angles[1], var_11);
    var_13 = var_9;
    var_14 = var_13 - var_2;
    var_15 = var_14 * var_3;
    var_15 = clamp(var_15, 0, 0.9999);
    var_16 = self.cnd_rappel_tele_rope getanimtime(self.rope_unwind_anim);

    if(var_15 == var_16) {
      common_scripts\utility::waitframe();
      continue;
    }

    self.cnd_rappel_tele_rope setanimtime(self.rope_unwind_anim, var_15);
    common_scripts\utility::waitframe();
  }
}