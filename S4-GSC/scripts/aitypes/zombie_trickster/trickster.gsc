/**********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_trickster\trickster.gsc
**********************************************************/

geteruptionparam(var_0) {
  var_1 = [4, 3, 2];
  var_2 = [10, 20, 30];
  var_3 = [30, 40, 60];
  var_4 = [48, 64, 96];
  var_5 = [1.0, 2.0, 3.0];
  var_6 = [2.0, 3.0, 4.0];
  var_7 = spawnStruct();
  var_7._id_011A = var_1[var_0 - 1];
  var_7.damage_radius = var_4[var_0 - 1];
  var_7.damage_max = var_3[var_0 - 1];
  var_7.damage_min = var_2[var_0 - 1];
  var_7.cooldown_min = var_5[var_0 - 1];
  var_7.cooldown_max = var_6[var_0 - 1];
  var_7.eruption_exp_fx = self.eruption_explode_fxs[var_0 - 1];
  return var_7;
}

zombietrickster_init(var_0) {
  self.zm_ai_category = "elite";
  self.nextattackchecktime = gettime() + 5000;
  self.mask_num = 3;
  self.ai_explosion_damage_mult = 0;
  self.playereffects = [];
  self._id_0047 = 0;
  self.ignore_enemy_count = 1;
  self.ignore_round_timeout_cleanup = 1;
  self.eruption_explode_fxs = [];
  self.eruption_explode_fxs[0] = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_exp_sm.vfx");
  self.eruption_explode_fxs[1] = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_exp_md.vfx");
  self.eruption_explode_fxs[2] = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_exp_lg.vfx");
  self.eruption_launch = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_tell_launch.vfx");
  self.eruption_marker_loop = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_tell_marker_loop.vfx");
  self.eruption_knockdown_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_zombie_downed.vfx");
  self.ground_teleport_in_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_spawn_in.vfx");
  self.ground_teleport_out_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_spawn_out.vfx");
  self.damage_mask_impact_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_mask_hit_damage.vfx");
  self.damage_fail_impact_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_hit_no_damage.vfx");
  self.break_mask_spin_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_mask_spin_rnr.vfx");
  self.death_explosion_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_death_exp.vfx");
  self.energy_mine_hit_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_trickster_mask_counteract.vfx");
  level._id_11EF["actor_enemy_zombie_trickster_cp"]["on_damaged"] = ::ontricksterdamage;
  level._id_11EF["actor_enemy_zombie_trickster_cp"]["on_damaged_finished"] = ::ontricksterdamagefinished;
  level._id_11EF["actor_enemy_zombie_trickster_cp"]["on_killed"] = ::ontricksterkilled;
  self.can_do_scripted_anim = ::zombietrickster_candoscriptedanim;
  self.try_do_scripted_anim = ::zombietrickster_trydoscriptedanim;
  self.tesla_damage_func = ::trickster_dg2_damage_function;
  _id_0B05::_id_D602("walk");
  self _meth_8385("default");
  thread initmaskhealththreshold();

  if(!istrue(level.played_trickster_intro) && !istrue(level.skip_trickster_intro)) {
    level.played_trickster_intro = 1;
    thread updateintrovo();
  }
}

ontricksterdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(istrue(self.b_underground)) {
    return 0;
  }

  var_14 = var_8 == "head" || var_8 == "helmet" || var_8 == "neck" || isDefined(var_11) && var_11 == "j_head";
  var_15 = var_12.basename == "s4_energy_mine_zm";

  if(var_15) {
    var_2 = 100000;
    playFXOnTag(self.energy_mine_hit_fx, self, "j_head");
  } else if(var_14) {
    if(isDefined(var_6) && isDefined(var_7)) {
      playFX(self.damage_mask_impact_fx, var_6, -1 * var_7);
    }
  }

  var_16 = var_14 || _func_010F(var_4) || isweapondamageallowed(var_12);

  if(istrue(self.b_invulnerable)) {
    play_damage_immune_vo();

    if(isDefined(var_6) && isDefined(var_7)) {
      playFX(self.damage_fail_impact_fx, var_6, -1 * var_7);
    }

    if(isPlayer(var_1)) {
      _id_072E::display_damage_number(var_1, self, var_8, var_4, var_5, 0, var_6, 1);
    }

    return 0;
  } else if(!var_16)
    var_2 = int(var_2 * 0.04) + 1;

  if(isDefined(self.extra_mask_health)) {
    self.extra_mask_health = self.extra_mask_health - var_2;

    if(isPlayer(var_1)) {
      _id_072E::display_damage_number(var_1, self, var_8, var_4, var_5, var_2, var_6);
    }

    if(self.extra_mask_health <= 0) {
      self.extra_mask_health = undefined;
      self notify("break_extra_mask", var_1);
    }

    return 0;
  }

  _id_0014::_id_0F74(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_13);
}

isweapondamageallowed(var_0) {
  return var_0.basename == "s4_brimstone_zm" || var_0.basename == "s4_molotov_zm" || var_0.basename == "s4_thermite_zm" || var_0.basename == "s4_energy_mine_zm";
}

ontricksterdamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1) && isPlayer(var_1)) {
    _id_06FC::_id_108F(self, var_1, var_0, var_5, var_2, var_6, var_7, var_8, var_9, var_4);
  }

  _id_0014::_id_11EC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_11, var_12);

  if(isDefined(var_1) && isPlayer(var_1)) {
    if(var_2 == 0 && isDefined(var_6) && isDefined(var_7)) {
      playFX(self.damage_fail_impact_fx, var_6, -1 * var_7);
    }

    _id_072E::display_damage_number(var_1, self, var_8, var_4, var_5, var_2, var_6, var_2 == 0);
  }
}

ontricksterkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self._id_BF49 = 0;
  self setscriptablepartstate("mask", "one");
  _id_0014::_id_0F7A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(_func_0463(self._id_25CA)) {
    self._id_25CA thread handle_trickster_death(self.death_explosion_fx);
  }
}

shouldmoveawayfromenemy(var_0) {
  return anim._id_58E3;
}

moveawayfromenemy_init(var_0) {
  _id_06BD::_id_2408(1);
  _id_0B05::_id_D602("sprint");
  self.nextmoveawayposupdatetime = 0;
}

moveawayfromenemy(var_0) {
  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  var_1 = gettime();

  if(var_1 >= self.nextmoveawayposupdatetime) {
    _id_0B05::_id_D602("sprint");
    var_2 = vectornormalize(self.origin - self._id_0192.origin);
    var_3 = self.origin + var_2 * 80;
    var_3 = self _meth_86F8(var_3);
    self _meth_84BC(0, var_3);
    self.nextmoveawayposupdatetime = var_1 + scripts\cp\utility::_id_CFF0(0.5);
  }

  return anim._id_CA5F;
}

shouldchaseenemy(var_0) {
  if(!isDefined(self._id_0192)) {
    return anim._id_EACB;
  }

  var_1 = distancesquared(self.origin, self._id_0192.origin);

  if(var_1 <= 1440000) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

chaseenemy_init(var_0) {
  _id_06BD::_id_2408(1);
  _id_0B05::_id_D602("sprint");
}

_id_341C(var_0) {
  var_1 = undefined;

  if(isDefined(self._id_0192)) {
    var_1 = _func_02AB(self._id_0192.origin);
  } else if(istrue(self._id_24F8) || !isDefined(self._id_0323)) {
    var_2 = [];

    foreach(var_4 in level.players) {
      if(var_4.ignoreme || isDefined(var_4.owner) && var_4.owner.ignoreme) {
        continue;
      }
      if(_id_0B05::_id_DB71(var_4)) {
        continue;
      }
      if(!isalive(var_4)) {
        continue;
      }
      var_2[var_2.size] = var_4;
    }

    var_6 = scripts\engine\utility::_id_6969(self.origin, var_2);

    if(!isDefined(var_6)) {
      return anim._id_58E3;
    }

    var_1 = self _meth_86F8(var_6.origin);
    self._id_24F8 = 0;
  }

  if(isDefined(var_1)) {
    self _meth_84BC(0, var_1);
  }

  return anim._id_EACB;
}

shouldrelocate(var_0) {
  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(isDefined(self.relocatecooldowntime) && gettime() < self.relocatecooldowntime) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

set_relocate_goal_pos() {
  var_0 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), 1, -1);
  var_1 = calculate_flank_pos(var_0);
  var_2 = 1;

  if(isDefined(level.check_in_playable_area_func)) {
    var_2 = [[level.check_in_playable_area_func]](var_1);
  }

  if(istrue(var_2) && can_see_enemy(var_1)) {
    var_3 = var_1;
  } else {
    var_1 = calculate_flank_pos(var_0 * -1);

    if(isDefined(level.check_in_playable_area_func)) {
      var_2 = [[level.check_in_playable_area_func]](var_1);
    }

    if(istrue(var_2) && can_see_enemy(var_1)) {
      var_3 = var_1;
    } else {
      var_3 = self _meth_86F8(self._id_0192.origin);
    }
  }

  if(isDefined(var_3)) {
    self _meth_84BC(0, var_3);
    return 1;
  }

  return 0;
}

relocate_init(var_0) {
  _id_06BD::_id_2408(1);
  _id_06BD::_id_23F3("strafe");
  self._id_0047 = 1;
  self.relocate_start = self.origin;
  self.relocate_time = gettime() + 2500;
  self.relocate_timeout = gettime() + 7500;

  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(set_relocate_goal_pos()) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

relocate(var_0) {
  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(gettime() > self.relocate_time) {
    var_1 = distancesquared(self.relocate_start, self.origin);

    if(var_1 >= 16384 || gettime() > self.relocate_timeout) {
      self.relocate_start = self.origin;

      if(can_see_enemy(self.origin)) {
        return anim._id_EACB;
      } else {
        set_relocate_goal_pos();
      }
    }
  }

  return anim._id_CA5F;
}

relocate_terminate(var_0) {
  self._id_0047 = 0;
  self.relocatecooldowntime = gettime() + scripts\cp\utility::_id_CFF0(2);
  return anim._id_EACB;
}

shouldbreakmask(var_0) {
  return !istrue(self.b_is_final_boss) && self.break_health_threshold > 0 && self.health <= self.break_health_threshold;
}

breakmask_init(var_0) {
  self.last_nonmoveratescale = self._id_A5AC;
  self._id_A5AC = 2;
  self setscriptablepartstate("mask", getmaskscriptablestatename(self.mask_num - 1));
  _id_0009::_id_1CA1("break_mask");
  playFXOnTag(self.break_mask_spin_fx, self, "j_head");
}

breakmask(var_0) {
  if(_id_0009::_id_1C4F("breakMask", "end")) {
    return anim._id_EACB;
  }

  self _meth_8474();
  return anim._id_CA5F;
}

breakmask_terminate(var_0) {
  self._id_A5AC = self.last_nonmoveratescale;
  self.last_nonmoveratescale = undefined;
  self.mask_num = int(self.health / _func_0037(self.maxhealth / 3)) + 1;
  updatemaskhealththreshold();
  self setscriptablepartstate("mask", getmaskscriptablestatename(self.mask_num));
  stopFXOnTag(self.break_mask_spin_fx, self, "j_head");
  thread play_mask_break_vo();
}

zombietrickster_shouldattack(var_0) {
  if(isDefined(self.eruption_param)) {
    return anim._id_EACB;
  }

  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(!isDefined(self.mask_num) || self.mask_num < 1) {
    return anim._id_58E3;
  }

  if(istrue(self.playing_intro_vo)) {
    return anim._id_58E3;
  }

  if(isDefined(level.check_in_playable_area_func)) {
    var_1 = [[level.check_in_playable_area_func]](self);

    if(!istrue(var_1)) {
      return anim._id_58E3;
    }
  }

  if(isDefined(self.nextattackchecktime) && gettime() > self.nextattackchecktime && can_see_enemy(self.origin)) {
    self.eruption_targets = geteruptionavailabletargets();
    self.is_escaping = 0;
    return scripts\engine\utility::ter_op(self.eruption_targets.size > 0, anim._id_EACB, anim._id_58E3);
  }

  var_2 = distancesquared(self.origin, self._id_0192.origin);

  if(var_2 < 6400 && can_see_enemy(self.origin) || isDefined(self.force_escape_position)) {
    self.eruption_targets = geteruptionavailabletargets();
    self.is_escaping = 1;
    return scripts\engine\utility::ter_op(self.eruption_targets.size > 0, anim._id_EACB, anim._id_58E3);
  }

  return anim._id_58E3;
}

zombietrickster_attackinit(var_0) {
  self.needs_to_attack = 1;
  self.eruption_param = geteruptionparam(self.mask_num);
  playFXOnTag(self.ground_teleport_in_fx, self, "tag_origin");
  return anim._id_EACB;
}

zombietrickster_attackupdate(var_0) {
  if(_id_0009::_id_1C4F("hide_in_ground", "end")) {
    if(istrue(self.is_escaping)) {
      var_1 = geteruptionparam(1);
      explodeatpos(self.origin, var_1);
    }

    thread spawneruptionsaroundalltargets();
  }

  if(_id_0009::_id_1C4F("finish_attack", "end")) {
    return anim._id_EACB;
  }

  return anim._id_CA5F;
}

zombietrickster_attackterminate(var_0) {
  self notify("attack_terminate");
  self.nextattackchecktime = gettime() + randomfloatrange(self.eruption_param.cooldown_min, self.eruption_param.cooldown_max) * 1000;
  self.eruption_param = undefined;
  self.eruption_targets = undefined;
  self.attack_monkey_bomb = undefined;
  self.is_escaping = undefined;
  self.force_escape_position = undefined;
  self.needs_to_attack = undefined;
  stopFXOnTag(self.ground_teleport_in_fx, self, "tag_origin");
  return anim._id_EACB;
}

zombietrickster_shouldfastattack(var_0) {
  if(istrue(self.is_escaping)) {
    return anim._id_58E3;
  }

  if(randomfloat(1) < 0.34) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

zombietrickster_fastattackinit(var_0) {
  self.needs_fast_attack = 1;
  self.eruption_param = geteruptionparam(self.mask_num);
  self.eruption_param._id_011A = 1;
  thread fastspawneruptionsaroundalltargets();
  return anim._id_EACB;
}

zombietrickster_fastattackupdate(var_0) {
  if(_id_0009::_id_1C4F("finish_attack", "end")) {
    return anim._id_EACB;
  }

  return anim._id_CA5F;
}

zombietrickster_fastattackterminate(var_0) {
  self notify("fast_attack_terminate");
  self.nextattackchecktime = gettime() + randomfloatrange(self.eruption_param.cooldown_min, self.eruption_param.cooldown_max) * 1000;
  self.eruption_param = undefined;
  self.eruption_targets = undefined;
  self.attack_monkey_bomb = undefined;
  self.needs_fast_attack = undefined;
  return anim._id_EACB;
}

handle_trickster_death(var_0) {
  self endon("death");
  wait 3.8;

  if(!isDefined(self)) {
    return;
  }
  playFX(var_0, self gettagorigin("j_spine4"));
  wait 0.2;

  if(isDefined(self)) {
    self delete();
  }
}

geteruptionavailabletargets() {
  var_0 = [];
  var_1 = scripts\cp\utility::_id_6C5F(self.origin, 1200, "allies");
  var_2 = scripts\engine\utility::array_combine(var_1, _func_0070(level._id_11056));

  foreach(var_4 in var_1) {
    if(isDefined(level.check_on_moving_platform_func)) {
      if(istrue(var_4[[level.check_on_moving_platform_func]]())) {
        continue;
      }
    }

    if(scripts\cp\utility::_id_8677(var_4, 1) && !istrue(var_4._id_8A07) && scripts\engine\trace::ray_trace_passed(self getEye(), var_4 getEye(), var_2)) {
      var_0[var_0.size] = var_4;
    }
  }

  if(isDefined(level.get_objective_item_positions_func)) {
    var_6 = [[level.get_objective_item_positions_func]]();

    if(var_6.size > 0) {
      var_6 = scripts\engine\utility::_id_E026(var_6, self._id_0192.origin);
      var_7 = var_1.size;
      var_8 = 0;

      foreach(var_10 in var_6) {
        if(distancesquared(self.origin, var_10) < 1440000) {
          var_0[var_0.size] = var_10;
          var_8++;

          if(var_8 >= var_7) {
            break;
          }
        }
      }
    }
  }

  return var_0;
}

geteruptiontargetpos(var_0) {
  if(isDefined(self.attack_monkey_bomb)) {
    if(self.monkey_bomb_eruption_count > 5) {
      return undefined;
    } else {
      self.monkey_bomb_eruption_count++;
      return getrandomeruptionpoint(self.attack_monkey_bomb.origin);
    }
  }

  if(isDefined(level._id_0F23) && level._id_0F23.size > 0) {
    foreach(var_2 in level._id_0F23) {
      if(isDefined(var_2) && distance2dsquared(self.origin, var_2.origin) < 1440000) {
        self.monkey_bomb_eruption_count = 1;
        self.attack_monkey_bomb = var_2;
        return getrandomeruptionpoint(var_2.origin);
      }
    }
  }

  if(isvector(var_0)) {
    var_4 = var_0;
  } else {
    var_4 = var_0.origin;
    var_4 = var_4 + anglesToForward(var_0.angles) * 24 * 2;
  }

  return getrandomeruptionpoint(var_4);
}

getrandomeruptionpoint(var_0) {
  var_1 = undefined;

  for(var_2 = 24; !isDefined(var_1) && var_2 < 100; var_2 = var_2 * 2) {
    var_1 = _func_02A9(var_0, var_2);
  }

  return var_1;
}

getpointinplayerview(var_0) {
  var_1 = var_0.origin + anglesToForward(var_0.angles) * 256 * 1.5;
  var_2 = _func_02AA(var_1, 256, 10);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_3 = var_0 getEye();
  var_4 = var_0 getplayerangles();
  var_5 = cos(65);
  var_6 = scripts\engine\utility::array_combine(level.players, _func_0070(level._id_11056));

  foreach(var_8 in var_2) {
    var_9 = 1;

    if(isDefined(level.check_in_playable_area_func)) {
      var_9 = [[level.check_in_playable_area_func]](var_8);
    }

    if(istrue(var_9)) {
      var_10 = scripts\engine\utility::_id_10E76(var_3, var_4, var_8, var_5);

      if(var_10) {
        var_11 = scripts\engine\trace::ray_trace_passed(var_3, var_8, var_6);

        if(var_11) {
          return var_8;
        }
      }
    }
  }

  return undefined;
}

fastspawneruptionsaroundalltargets() {
  self endon("death");
  self endon("fast_attack_terminate");
  wait 0.5;

  foreach(var_1 in self.eruption_targets) {
    childthread spawneruptionsaroundtarget(var_1);
  }

  thread play_attack_vo(isDefined(self.attack_monkey_bomb));

  if(isDefined(self.attack_monkey_bomb)) {
    _id_070F::createmonkeybombdivertevent(self.attack_monkey_bomb.originating_player, self);
  }
}

spawneruptionsaroundalltargets() {
  self endon("death");
  self endon("attack_terminate");
  self hide();
  self _meth_852B(0);
  var_0 = self.origin;
  self.origin = self.origin - (0, 0, 100);
  self.b_underground = 1;
  wait 0.5;

  foreach(var_2 in self.eruption_targets) {
    childthread spawneruptionsaroundtarget(var_2);
  }

  thread play_attack_vo(isDefined(self.attack_monkey_bomb));

  if(isDefined(self.attack_monkey_bomb)) {
    _id_070F::createmonkeybombdivertevent(self.attack_monkey_bomb.originating_player, self);
  }

  wait(1.5 + self.eruption_param._id_011A * 0.5);
  wait 0.0;
  self.needs_to_attack = undefined;

  if(isDefined(self.force_escape_position)) {
    var_0 = self.force_escape_position;
  } else if(isPlayer(self._id_0192)) {
    var_4 = getpointinplayerview(self._id_0192);

    if(isDefined(var_4)) {
      var_0 = var_4;
    }
  }

  self.origin = var_0;
  waitframe();
  self show();
  wait 0.1;
  playFXOnTag(self.ground_teleport_out_fx, self, "tag_origin");
  wait 0.8;
  self.b_underground = undefined;
  stopFXOnTag(self.ground_teleport_out_fx, self, "tag_origin");
  self _meth_852B(1);
}

spawneruptionsaroundtarget(var_0) {
  for(var_1 = 0; var_1 < self.eruption_param._id_011A; var_1++) {
    if(!isalive(var_0) && !isvector(var_0)) {
      break;
    }

    var_2 = geteruptiontargetpos(var_0);

    if(!isDefined(var_2)) {
      continue;
    }
    childthread spawneruptionatpos(var_2);
    wait 0.5;
  }
}

spawneruptionatpos(var_0) {
  var_1 = magicgrenademanual("zombie_trickster_eruption", var_0, (0, 0, 0), 2.0, self);
  playrumbleonposition("light_2s", var_0);
  playsoundatpos(var_0, "ai_deceiver_bomb_start");
  playFX(self.eruption_launch, var_0);
  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin");
  var_2 thread scripts\cp\utility::_id_46C7(1.5);
  wait 1;
  var_2 playLoopSound("ai_deceiver_bomb_start_lp");
  playFXOnTag(self.eruption_marker_loop, var_2, "tag_origin");
  wait 0.5;
  explodeatpos(var_0);
}

explodeatpos(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self.eruption_param;
  }

  var_2 = level._id_11049;

  if(isDefined(level.zombie_round_override)) {
    var_2 = level.zombie_round_override;
  }

  var_3 = 1;

  if(isDefined(var_2)) {
    if(var_2 <= 5) {
      var_3 = 1;
    } else if(var_2 <= 8) {
      var_3 = 1.5;
    } else if(var_2 <= 16) {
      var_3 = 2;
    } else if(var_2 <= 30) {
      var_3 = 3;
    } else {
      var_3 = 5;
    }
  }

  _func_01BA(var_0, var_1.damage_radius, var_1.damage_max * var_3, var_1.damage_min * var_3, self, "MOD_EXPLOSIVE");
  playsoundatpos(var_0, "ai_deceiver_bomb_exp");
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.5, 0.75, var_0, var_1.damage_radius);
  playFX(var_1.eruption_exp_fx, var_0);

  if(isDefined(level._id_0F23) && level._id_0F23.size > 0) {
    foreach(var_5 in level._id_0F23) {
      if(isDefined(var_5) && !istrue(var_5._id_87FB) && distance2d(var_0, var_5.origin) < var_1.damage_radius) {
        var_5._id_87FB = 1;
        var_5 thread _id_091D::destroy_monkey_bomb();
      }
    }
  }

  var_7 = _func_0071(var_0, var_1.damage_radius);

  foreach(var_9 in var_7) {
    if(isalive(var_9) && var_9 _id_06FE::is_zm_normal()) {
      var_10 = vectornormalize(var_9.origin - var_0);
      playFXOnTag(self.eruption_knockdown_fx, var_9, "j_spine4");
      var_9 scripts\aitypes\zombie_common\push::knockdown(var_10, 0.05);
    }
  }
}

getmaskscriptablestatename(var_0) {
  switch (var_0) {
    case 3:
      return "three";
    case 2:
      return "two";
    case 1:
      return "one";
  }

  return undefined;
}

initmaskhealththreshold() {
  self endon("death");
  self.break_health_threshold = 0;
  waitframe();
  updatemaskhealththreshold();
}

updatemaskhealththreshold() {
  var_0 = _func_0037(self.maxhealth / 3);
  self.break_health_threshold = (self.mask_num - 1) * var_0;
}

can_see_enemy(var_0) {
  if(!isDefined(self._id_0192)) {
    return 0;
  }

  var_1 = self._id_0192 getEye();
  var_2 = self getEye();
  var_3 = scripts\engine\utility::array_combine(level.players, _func_0070(level._id_11056));
  var_4 = scripts\engine\trace::ray_trace_passed(var_2, var_1, var_3);
  return var_4;
}

calculate_flank_pos(var_0) {
  var_1 = _func_000A(self.angles[1] + 45 * var_0);
  var_2 = anglesToForward((0, var_1, 0));
  var_3 = self.origin + var_2 * 256;
  var_4 = self _meth_86F8(var_3);
  return var_4;
}

invulnerable_after_break_mask() {
  self endon("death");
  self endon("invulnerable");

  if(!istrue(self.b_invulnerable)) {
    self.b_invulnerable = 1;
    wait 2;
    self.b_invulnerable = undefined;
  }
}

updateintrovo() {
  self.playing_intro_vo = 1;
  var_0 = 1;
  var_1 = undefined;
  self playSound("ai_deceiver_spawn");

  while(var_0) {
    wait 0.2;

    foreach(var_3 in level.players) {
      var_4 = _func_0202(var_3 getEye(), self getEye(), 0, var_3);
      var_5 = _id_0720::is_in_front(var_3, self.origin);
      var_6 = distance2dsquared(var_3.origin, self.origin) < 640000;

      if(var_4 && var_5 && var_6) {
        var_0 = 0;
        var_1 = var_3;
      }
    }
  }

  if(!isDefined(var_1) || !isDefined(var_1.demon_zaballa_intro_alias) || !isDefined(var_1.demon_hub_alias_a)) {
    self.playing_intro_vo = undefined;
    return;
  }

  var_8 = var_1.demon_zaballa_intro_alias;
  var_9 = var_1.demon_hub_alias_a;
  self _meth_8855("battlechatter", "zm_caiz", "eaiz", "zbla", var_8, level._id_B7F4);
  wait(_id_0720::get_dialogue_length("zm_caiz_eaiz_zbla_" + var_8));
  self.playing_intro_vo = undefined;
  _id_0720::play_narration("zm_caiz_eaiz_" + var_9 + "_ezaf");
  _id_0720::_id_BEC0("zm_caiz_eaiz_" + var_9 + "_ezeb");

  foreach(var_3 in level.players) {
    var_11 = _id_0728::_id_69D6("equip_monkey_bomb");
    var_12 = var_3 _id_0728::_id_69A4(var_11);

    if(isDefined(var_12) && var_12 == "equip_monkey_bomb") {
      var_3 _id_0720::_id_BEC0("trickster_monkey_hint");
    }
  }
}

play_attack_vo(var_0) {
  if(istrue(self.b_is_final_boss)) {
    return;
  }
  if(var_0) {
    self _meth_8855("battlechatter", "zm_caiz", "eaiz", "zbla", "ezea", level._id_B7F4);
    return;
  }

  switch (self.mask_num) {
    case 3:
      self _meth_8855("battlechatter", "zm_caiz", "eaiz", "zbla", "ezca", level._id_B7F4);
      break;
    case 2:
      self _meth_8855("battlechatter", "zm_caiz", "eaiz", "zbla", "ezcb", level._id_B7F4);
      break;
    case 1:
      self _meth_8855("battlechatter", "zm_caiz", "eaiz", "zbla", "ezcc", level._id_B7F4);
      break;
  }
}

play_mask_break_vo() {
  switch (self.mask_num) {
    case 2:
      self _meth_8855("battlechatter", "zm_caiz", "eaiz", "zbla", "ezfa", level._id_B7F4);
      break;
    case 1:
      self _meth_8855("battlechatter", "zm_caiz", "eaiz", "zbla", "ezfb", level._id_B7F4);
      break;
    default:
      break;
  }
}

play_damage_immune_vo() {
  if(!istrue(level.played_trickster_mask_hint)) {
    level.played_trickster_mask_hint = 1;
    thread _id_0720::play_narration("zm_caiz_eaiz_krft_ezda");
  }
}

play_cc_immune_vo() {
  if(!istrue(level.played_trickster_cc_immune_hint)) {
    level.played_trickster_cc_immune_hint = 1;
    thread _id_0720::play_narration("zm_caiz_eaiz_krft_ezba");
  }
}

zombietrickster_candoscriptedanim() {
  var_0 = istrue(self.b_underground);
  return !var_0;
}

zombietrickster_trydoscriptedanim(var_0, var_1, var_2) {
  if(isDefined(var_0) && isDefined(var_1) && zombietrickster_candoscriptedanim()) {
    _id_0AED::_id_18D0("zombie_trickster", var_0, var_1, var_2);
    return 1;
  }

  return 0;
}

trickster_dg2_damage_function(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3.dg2_level) || !isDefined(level.dg2_damage_to_specials["trickster"][var_3.dg2_level])) {
    return;
  }
  var_4 = scripts\engine\utility::ter_op(var_2 > 1, 10, level.dg2_damage_to_specials["trickster"][var_3.dg2_level]);
  self dodamage(var_4, var_0, var_1, undefined, "MOD_UNKNOWN", var_3._id_04F6, "head");
}