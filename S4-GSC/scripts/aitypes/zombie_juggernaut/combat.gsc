/********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_juggernaut\combat.gsc
********************************************************/

zombiejuggernaut_init(var_0) {
  _id_D843();
  self.zm_ai_category = "special";
  self._id_E3B2 = "zombie_juggernaut";
  self._id_9D94 = self._id_9D95;
  self._id_9D97 = _func_0219(self._id_9D94);
  self._id_10DF1 = 1;
  self _meth_800D("stand");
  self._id_6A2E = ::faceenemyoverride;
  self.tesla_damage_func = ::jugg_dg2_damage_function;
  self.zombie_juggernaut = 1;
  self._id_4DA8 = 1;
  self._id_0206 = 0;
  self._id_002F = 1;
  self._id_0230 = 1;
  self._id_0168 = 1;
  self._id_02A4 = 120;
  self._id_02A3 = 120;
  self._id_9DA7 = 14400;
  self._id_9D7F = 400;
  self._id_02A7 = 500;
  self._id_9DA9 = 2500;
  self._id_9DAA = 0;
  self._id_9D8D = 0;
  self._id_9D8E = 1;
  self.meleeinprogress = 0;
  self._id_4DB6 = 1;
  self._id_4A83 = 1;
  self._id_010D = "no_cover";
  self._id_A441 = 1;
  self._id_016E = 1;
  self._id_4AA4 = 1;
  self._id_0321 = 0;
  self.playereffects = [];
  self.playing_vo_taunt = 0;
  self._id_029A = 1000;
  self.defend_loc = undefined;
  self.set_turned_func = ::set_turned;
  self.set_frozen_func = ::set_frozen;

  if(isDefined(self._id_0DDF)) {
    self._id_0DDF._id_4AC4 = 1;
  }

  self._id_3A94 = 1;
  _id_0B05::_id_D602("walk");
  self._id_0047 = 0;
  self.shoot_cooldown_end = 0;
  self.relocate_end = 0;
  self.spawn_teleport_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_portal_spawn_lg.vfx");
  self.spawn_ground_fx = loadfx("vfx/s4/zombie_ai/vfx_zai_portal_spawn_lg.vfx");
  level._id_11EF["actor_enemy_zombie_juggernaut_cp"]["on_damaged"] = ::onjuggernautdamage;
  level._id_11EF["actor_enemy_zombie_juggernaut_cp"]["on_damaged_finished"] = ::onjuggernautdamagefinished;
  level._id_11EF["actor_enemy_zombie_juggernaut_cp"]["on_killed"] = ::onjuggernautkilled;
  self _meth_84A8("zombietype", "juggernaut", 0.1);
  initbackpackhealth();
  thread meleeknockbackmonitor();
  thread zombiejuggernaut_cleanup();

  if(self _meth_86EE()) {
    thread _id_8283();
  }

  thread updatemovetype();
  thread dialoguetrack();
}

_id_8283() {
  self setscriptablepartstate("notetrack_handler", "active", 0);
  _id_110A5("base_loop");
}

dialoguetrack() {
  self endon("death");

  for(;;) {
    wait 20.0;

    while(istrue(self._id_0B67.needs_to_taunt) || istrue(self._id_1C30.playpain) || istrue(self.meleeinprogress) || istrue(self._id_8873)) {
      wait 0.1;
    }

    self _meth_8855("battlechatter", "zm_cmcp", "obhb", "stmk", "hjsk", level._id_B7F4);
    self.playing_vo_taunt = 1;
    wait(_id_0720::get_dialogue_length("zm_cmcp_obhb_stmk_hjsk"));
    self.playing_vo_taunt = 0;
  }
}

initbackpackhealth() {
  self.backpackhealth = self.maxhealth * 0.3;
}

damagebackpack(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self.backpackhealth) && self.backpackhealth > 0) {
    if(var_1) {
      var_5 = var_0 * 0.2;
    } else {
      var_5 = var_0;
      var_6 = level._effect["backpack_impact"];
      playFX(var_6, var_3, (1, 0, 0), (0, 0, 1));
    }

    self.backpackhealth = self.backpackhealth - var_5;

    if(self.backpackhealth <= 0.001) {
      if(self _meth_86EE()) {
        thread detachbackpack(var_2);

        if(isDefined(var_4) && isPlayer(var_4)) {
          var_4 _id_0752::_id_7003("juggernaut_backpack_destroyed");
        }
      }
    }
  }
}

debugshowbackpackhealth() {}

detachbackpack(var_0) {
  self setscriptablepartstate("backpack", "detached", 0);

  if(isDefined(var_0) && isDefined(var_0.origin)) {
    var_1 = var_0.origin;
  } else {
    var_1 = _func_02AB(self.origin);
  }

  var_2 = self gettagorigin("j_spine4");
  var_3 = self gettagangles("j_spine4");
  var_4 = spawnmodel("zom_juggernaut_ammo_pack", var_2);
  var_4 solid();
  var_4.angles = var_3;
  var_5 = 2000;
  var_6 = vectornormalize(var_2 - var_1) * var_5;
  var_6 = var_6;
  var_4 physicslaunchserver(var_2, var_6);
  explodebackpack(var_2, 1, var_0);
  thread launchbackpack(1.0, var_4, var_0);
  thread launchbackpack(1.5, var_4, var_0);
  thread destroybackpack(1.75, var_4);
}

explodebackpack(var_0, var_1, var_2) {
  var_3 = scripts\engine\utility::ter_op(var_1, "backpack_explosion", "backpack_explosion_sm");
  var_4 = level._effect[var_3];
  playFX(var_4, var_0, (1, 0, 0), (0, 0, 1));
  var_5 = _func_0070();

  foreach(var_7 in var_5) {
    if(var_7 == self) {
      if(isent(var_2)) {
        self _meth_81FA(self.origin, var_2);
      } else {
        self _meth_81FA(self.origin);
      }

      continue;
    }

    var_7 causebackpackdamage(var_0, var_2);
  }

  foreach(var_10 in level.players) {
    var_10 causebackpackdamage(var_0);
  }
}

causebackpackdamage(var_0, var_1) {
  var_2 = distance2dsquared(var_0, self.origin);

  if(var_2 < _func_0219(120)) {
    var_3 = _func_0218(var_2);
    var_4 = 50.0 - 30.0 * (max(var_3, 64.0) - 64.0) / 56.0;

    if(!_func_0458(var_1)) {
      self dodamage(var_4, self.origin, var_1, var_1, "MOD_EXPLOSIVE", "s4_juggernaut_backpack_explosion_zm");
    } else {
      self dodamage(var_4, self.origin);
    }
  }
}

launchbackpack(var_0, var_1, var_2) {
  wait(var_0);
  var_3 = 2000;
  var_4 = vectornormalize((randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(0, 1))) * var_3;

  if(isDefined(var_1)) {
    var_5 = var_1 _meth_8169();

    if(isDefined(var_5)) {
      var_1 physicslaunchserver(var_5, var_4);
      explodebackpack(var_5, 0, var_2);
    }
  }
}

destroybackpack(var_0, var_1) {
  wait(var_0);

  if(isDefined(var_1)) {
    var_1 delete();
  }
}

spawnmodel(var_0, var_1) {
  var_2 = spawn("script_model", var_1);
  var_2 setModel(var_0);
  var_2 setCanDamage(1);
  return var_2;
}

_id_D843() {
  self._id_13E7 = "idle";
  self._id_0359 = 15;
  self.height = 72;
  self._id_A5AC = 1.0;
  self._id_9D95 = 70;
  self._id_9D96 = _func_0219(self._id_9D95);
  self._id_24F8 = 1;
  self._id_1DF5 = 26 + self._id_0359;
  self._id_1DFC = 54;
  self._id_1DFD = -64;
  self._id_9D84 = 0.5;
  self._id_9D79 = 40;
  self._id_9D98 = 64;
  self.tauntchance = 0.25;
  self.lasttaunttime = gettime() + 5000;
}

zombiejuggernaut_cleanup() {
  self waittill("death");
  self _meth_83F8();
  self playSound("ai_juggernaut_exert_death");

  if(isDefined(self.shoot_sweep_ent)) {
    self.shoot_sweep_ent delete();
  }
}

faceenemyoverride() {
  if(!scripts\aitypes\zombie_common\awareness::is_aware()) {
    return undefined;
  }

  if(isDefined(self._id_0323)) {
    return undefined;
  }

  if(isDefined(self._id_0192) && isPlayer(self._id_0192) && self _meth_8067(self._id_0192)) {
    return self._id_0192;
  }

  return undefined;
}

updatemovetype() {
  self endon("death");

  for(;;) {
    if(scripts\aitypes\zombie_common\awareness::is_aware() && !istrue(self._id_8873)) {
      if(isDefined(self._id_0192)) {
        var_0 = distancesquared(self.origin, self._id_0192.origin);
        var_1 = scripts\cp\utility::_id_459B(level.custom_jugg_sprint_dist_sq, 1562500);

        if(istrue(self.melee_chase) || var_0 > var_1) {
          if(!_id_06BD::_id_23E6("sprint")) {
            _id_0B05::_id_D602("sprint");
            self._id_0047 = 0;
            clear_shoot_params();
          }
        } else if(istrue(self.charge_melee)) {
          if(!_id_06BD::_id_23E6("sprint")) {
            _id_0B05::_id_D602("sprint");
            self._id_0047 = 0;
            clear_shoot_params();
          }
        } else if(var_0 < 1000000) {
          if(!_id_06BD::_id_23E6("strafe")) {
            _id_06BD::_id_23F3("strafe");
            self._id_0047 = 1;
            update_shoot_params();
          } else if(!isDefined(self.lastshootenemy) || self.lastshootenemy != self._id_0192) {
            update_shoot_params();
            self.lastshootenemy = self._id_0192;
          }
        }
      } else if(!_id_06BD::_id_23E6("walk")) {
        _id_0B05::_id_D602("walk");
        self._id_0047 = 0;
        clear_shoot_params();
      }
    }

    waitframe();
  }
}

meleeknockbackmonitor() {
  self endon("death");

  for(;;) {
    self waittill("attack_hit", var_0);
    var_1 = var_0.origin - self.origin;
    var_1 = (var_1[0], var_1[1], 0);
    var_0 _meth_8508(var_1, 1000);

    if(isPlayer(var_0)) {
      var_0 earthquakeforplayer(0.5, 0.4, self.origin, 1000);
    }
  }
}

updatenearestenemy(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.ignoreme || isDefined(var_3.owner) && var_3.owner.ignoreme) {
      continue;
    }
    if(_id_0B05::_id_DB71(var_3)) {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  var_5 = undefined;

  if(var_1.size > 0) {
    var_5 = _func_0204(var_1, self.origin);
  }

  if(isDefined(var_5) && var_5.size > 0) {
    self.nearestenemy = var_5[0];
    self.nearestenemyspot = _func_02AB(self.nearestenemy.origin, self);
    var_6 = 300;
    var_7 = distancesquared(self.nearestenemy.origin, self.origin);

    if(var_7 < var_6 * var_6) {
      var_6 = 16;
    }

    self.nearestenemygoalradiussq = var_6 * var_6;
  }

  return anim._id_EACB;
}

_id_DB84(var_0) {
  _id_06BD::_id_23AF();

  if(self._id_0229) {
    return anim._id_58E3;
  }

  if(!isDefined(self._id_012F)) {
    return anim._id_58E3;
  }

  if(istrue(self._id_012F.ignoreme)) {
    return anim._id_58E3;
  }

  if(istrue(self._id_012F.zombie_juggernaut)) {
    return anim._id_58E3;
  }

  if(self._id_13E7 == "melee" || _id_0017::_id_8A63()) {
    return anim._id_58E3;
  }

  if(isDefined(self._id_9D82)) {
    var_1 = gettime() - self._id_9013;

    if(var_1 < self._id_9D82 * 1000) {
      return anim._id_58E3;
    }
  }

  if(!_id_0B05::_id_C0AF("normal")) {
    return anim._id_58E3;
  }

  if(!istrue(self.playing_vo_taunt)) {
    self _meth_827E("ai_juggernaut_exert_charge");
  }

  self.meleeinprogress = 1;
  return anim._id_EACB;
}

shouldchaseenemy(var_0) {
  if(self._id_0229) {
    self._id_012F = undefined;
    return anim._id_58E3;
  }

  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  self._id_012F = self._id_0192;
  self.melee_chase = 0;
  var_1 = istrue(self.charge_melee);
  self.charge_melee = 0;

  if(has_defend_location()) {
    return anim._id_58E3;
  }

  var_2 = distancesquared(self.origin, self._id_0192.origin);

  if(var_2 <= 16384 && !istrue(self._id_012F.zombie_juggernaut)) {
    self.melee_chase = 1;

    if(istrue(var_1)) {
      self.charge_melee = 1;
    }
  } else if(var_2 <= 1000000) {
    if(!istrue(self._id_012F.zombie_juggernaut) && can_charge_melee(var_2)) {
      self.charge_melee = try_charge_melee(var_1);
    }

    if(!self.charge_melee && _id_884A()) {
      if(can_shoot_from_pos(self.origin)) {
        if(!isDefined(level.jugg_stop_chase_enemy_chance)) {
          return anim._id_58E3;
        }

        if(randomfloat(1) < level.jugg_stop_chase_enemy_chance) {
          return anim._id_58E3;
        }
      }
    }
  }

  return anim._id_EACB;
}

_id_884A(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0.8;
  }

  var_1 = anglesToForward(self.angles);
  var_2 = vectornormalize(self._id_0192.origin - self.origin);
  var_3 = vectordot(var_1, var_2);

  if(var_3 < var_0) {
    return 0;
  }

  return 1;
}

zombiejuggernaut_shouldshoot(var_0) {
  if(istrue(self._id_0181)) {
    return anim._id_58E3;
  }

  if(gettime() < self.shoot_cooldown_end) {
    return anim._id_58E3;
  }

  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  if(self._id_0063) {
    return anim._id_58E3;
  }

  if(istrue(self._id_1C30.playpain)) {
    return anim._id_58E3;
  }

  if(!_id_884A()) {
    return anim._id_58E3;
  }

  var_1 = distancesquared(self.origin, self._id_0192.origin);

  if(var_1 > 1000000) {
    return anim._id_58E3;
  }

  if(istrue(self.melee_chase)) {
    return anim._id_58E3;
  }

  if(istrue(self.charge_melee)) {
    return anim._id_58E3;
  }

  if(can_shoot_from_pos(self.origin)) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

shouldrelocate(var_0) {
  if(istrue(self.melee_chase)) {
    return anim._id_58E3;
  }

  if(istrue(self.charge_melee)) {
    return anim._id_58E3;
  }

  if(istrue(self.should_relocate)) {
    return anim._id_EACB;
  }

  return anim._id_58E3;
}

shouldtaunt(var_0) {
  if(istrue(self.try_taunt)) {
    if(gettime() > self.lasttaunttime) {
      if(randomfloat(1) < self.tauntchance) {
        self.tauntchance = 0.25;
        return anim._id_EACB;
      } else
        self.tauntchance = self.tauntchance + 0.1;
    }

    self.try_taunt = 0;
  }

  return anim._id_58E3;
}

zombiejuggernaut_melee(var_0) {
  _id_06BD::_id_23F0(self._id_012F);

  if(_id_0009::_id_1C4F("melee", "end")) {
    reset_shoot_cooldown();

    if(istrue(self.charge_melee)) {
      reset_charge_melee_cooldown();
    }

    if(!_id_06BD::_id_23E6("strafe")) {
      _id_06BD::_id_23F3("strafe");
      self._id_0047 = 1;
      update_shoot_params();
    }

    self.meleeinprogress = 0;
    return anim._id_EACB;
  }

  return anim._id_CA5F;
}

_id_341C(var_0) {
  _id_06BD::_id_2408(1);
  var_1 = _func_02AB(self._id_0192.origin);
  self _meth_84BC(0, var_1);
  return anim._id_EACB;
}

setupshootsweep() {
  self endon("death");
  var_0 = self._id_0192 _meth_8176();
  var_1 = vectornormalize(var_0 - self.origin);
  var_2 = anglestoup(self._id_0192.angles);
  var_3 = _func_025B(var_2, var_1);
  var_4 = 64;

  if(scripts\engine\utility::cointoss()) {
    var_4 = var_4 * -1;
  }

  var_5 = var_0 + var_3 * var_4;
  var_6 = var_0 - var_3 * var_4;

  if(isDefined(self.shoot_sweep_ent)) {
    self.shoot_sweep_ent.origin = var_5;
    wait 0.25;
    self.shoot_sweep_ent moveto(var_6, 1.0, 0.05, 0.05);
    wait 1.0;
    self.shoot_sweep_ent moveto(var_5, 1.0, 0.05, 0.05);
  }
}

hitzombies() {
  var_0 = self _meth_8561();
  var_1 = _func_0071(self.origin, 1000);
  var_2 = 0;

  foreach(var_4 in var_1) {
    var_5 = vectornormalize(var_4.origin - self.origin);

    if(vectordot(var_0, var_5) > 0.98) {
      if(var_2 < 2) {
        var_6 = randomfloatrange(0, 0.2);

        if(var_4 scripts\aitypes\zombie_common\push::knockdown(var_5, var_6)) {
          var_2++;
        }
      }

      if(!istrue(var_4.isknockeddown)) {
        var_7 = scripts\cp\utility::_id_459B(var_4.damage_fail_impact_fx, level._effect["juggernaut_bullet_impact"]);
        playFX(var_7, var_4 gettagorigin("j_spineupper"), var_5);
      }
    }
  }
}

shootwindup(var_0) {
  scripts\asm\zombie_juggernaut\zombie_juggernaut::zombiejuggernaut_startshooting();

  if(_id_0009::_id_1C4F("windup", "end")) {
    return anim._id_EACB;
  }

  return anim._id_CA5F;
}

shootinit(var_0) {
  _id_06BD::_id_2408(1);
  self _meth_84BC(0, self.origin);
  _id_06BD::_id_23AC(var_0);

  if(isPlayer(self._id_0192) && istrue(level.juggernaut_shoot_sweep_on_zipline_player) && isDefined(level.check_on_moving_platform_func)) {
    if(istrue(self._id_0192[[level.check_on_moving_platform_func]]())) {
      self.stop_shoot_sweep_on_shoot_terminate = 1;
      self.uses_shoot_sweep = 1;
    }
  }

  if(istrue(self.uses_shoot_sweep)) {
    thread setupshootsweep();
  }

  if(istrue(self.uses_shoot_sweep)) {
    self.shoot_time_end = gettime() + 2000.0;
  } else {
    self.shoot_time_end = gettime() + 2000.0;
  }

  self.shoot_delay = gettime();
  return anim._id_EACB;
}

update_shoot_params() {
  if(!isDefined(self._id_0192)) {
    return;
  }
  var_0 = self._id_0192 _meth_8176();
  var_1 = 1;
  var_2 = self._id_0192;

  if(!istrue(self._id_0B67._id_03CE)) {
    self _meth_8857(var_0, var_2, var_1);
  } else {
    self _meth_8858(var_0, var_2, var_1);
  }
}

clear_shoot_params() {
  if(istrue(self._id_0B67._id_03CE)) {
    _id_06BD::_id_23B5();
  }
}

shootupdate(var_0) {
  if(!isDefined(self._id_0192)) {
    return anim._id_58E3;
  }

  scripts\anim\weaponlist::_id_C194();

  if(istrue(self.uses_shoot_sweep) && isDefined(self.shoot_sweep_ent)) {
    self _meth_8251("face point", self.shoot_sweep_ent.origin);
  } else {
    self _meth_8251("face current");
  }

  if(gettime() > self.shoot_time_end) {
    return anim._id_EACB;
  }

  if(gettime() > self.shoot_delay) {
    hitzombies();
    var_1 = 0;

    if(istrue(self.uses_shoot_sweep) || !_id_884A(0.2)) {
      var_1 = 1;
    }

    self _meth_83BE(1.0, undefined, 1, var_1);
    self.shoot_delay = gettime() + 75;
  }

  return anim._id_CA5F;
}

reset_shoot_cooldown() {
  var_0 = scripts\cp\utility::_id_459B(level.custom_jugg_shoot_cooldown_min, 500);
  var_1 = scripts\cp\utility::_id_459B(level.custom_jugg_shoot_cooldown_max, 1500);
  var_2 = randomintrange(var_0, var_1);
  self.shoot_cooldown_end = gettime() + var_2;
}

shootterminate(var_0) {
  scripts\asm\zombie_juggernaut\zombie_juggernaut::zombiejuggernaut_stopshooting();
  self.shoot_time_end = undefined;
  reset_shoot_cooldown();
  self.should_relocate = 1;
  self.try_taunt = 1;

  if(istrue(self.stop_shoot_sweep_on_shoot_terminate)) {
    self.stop_shoot_sweep_on_shoot_terminate = 0;
    self.uses_shoot_sweep = undefined;
  }

  return anim._id_EACB;
}

shouldshootdoor(var_0) {
  self._id_0B67.doortoshoot = scripts\aitypes\zombie_common\ai_util::get_door_in_path();

  if(isDefined(self._id_0B67.doortoshoot)) {
    if(distancesquared(self.origin, self._id_0B67.doortoshoot.origin) < 1000000) {
      return anim._id_EACB;
    }
  }

  return anim._id_58E3;
}

destroydoor(var_0) {
  self radiusdamage(var_0.origin, 10, 1000, 1000, self, "MOD_EXPLOSIVE", undefined, 1);
}

shootdoorinit(var_0) {
  self _meth_84BC(0, self.origin);
  self.shoot_windup_end = gettime() + 250.0;
  self.shoot_windup_done = 0;
  self.shoot_delay = gettime();
  self.shoot_at_pos = self._id_0B67.doortoshoot _meth_878E();
  return anim._id_EACB;
}

shootdoorupdate(var_0) {
  if(!isDefined(self._id_0B67.doortoshoot)) {
    return anim._id_58E3;
  }

  scripts\anim\weaponlist::_id_C194();
  self _meth_8251("face point", self.shoot_at_pos);

  if(!self.shoot_windup_done) {
    if(gettime() > self.shoot_windup_end) {
      self.shoot_windup_done = 1;
      self.shoot_time_end = gettime() + 400.0;
    }

    return anim._id_CA5F;
  }

  if(gettime() > self.shoot_time_end) {
    destroydoor(self._id_0B67.doortoshoot);
    return anim._id_EACB;
  }

  if(gettime() > self.shoot_delay) {
    hitzombies();
    self _meth_83BE(1.0, undefined, 1, 1, 1);
    self.shoot_delay = gettime() + 75;
  }

  return anim._id_CA5F;
}

shootdoorterminate(var_0) {
  self.shoot_time_end = undefined;
  return anim._id_EACB;
}

_id_7CA9(var_0) {
  self _meth_8474();
  return anim._id_EACB;
}

can_shoot_from_pos(var_0) {
  if(!isDefined(self._id_0192)) {
    return 0;
  }

  if(isDefined(level.check_in_playable_area_func)) {
    var_1 = [[level.check_in_playable_area_func]](self);

    if(!istrue(var_1)) {
      return 0;
    }
  }

  if(istrue(self.outside_playspace)) {
    return 0;
  }

  var_2 = self._id_0192 _meth_8176();
  var_3 = self _meth_815C();
  var_4 = scripts\engine\utility::array_combine(level.players, _func_0070(level._id_11056));
  var_5 = scripts\engine\trace::ray_trace_passed(var_3, var_2, var_4);
  return var_5;
}

calculate_shoot_from_pos(var_0) {
  var_1 = _func_000A(self.angles[1] + 45 * var_0);
  var_2 = anglesToForward((0, var_1, 0));
  var_3 = self.origin + var_2 * 256;
  var_4 = self _meth_86F8(var_3);
  return var_4;
}

set_relocate_goal_pos() {
  var_0 = 1;

  if(scripts\engine\utility::cointoss()) {
    var_0 = var_0 * -1;
  }

  var_1 = calculate_shoot_from_pos(var_0);

  if(can_shoot_from_pos(var_1)) {
    var_2 = var_1;
  } else {
    var_1 = calculate_shoot_from_pos(var_0 * -1);

    if(can_shoot_from_pos(var_1)) {
      var_2 = var_1;
    } else {
      var_2 = self _meth_86F8(self._id_0192.origin);
    }
  }

  if(isDefined(var_2)) {
    self _meth_84BC(0, var_2);
    return 1;
  }

  return 0;
}

relocateinit(var_0) {
  self.relocate_start = self.origin;
  self.relocate_dist_sq = 0;
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

      if(can_shoot_from_pos(self.origin)) {
        return anim._id_EACB;
      } else {
        set_relocate_goal_pos();
      }
    }
  }

  return anim._id_CA5F;
}

relocateterminate(var_0) {
  if(!istrue(self._id_8873)) {
    self _meth_84BC(0, self.origin);
  }

  self.should_relocate = 0;
  return anim._id_EACB;
}

reset_taunt_cooldown() {
  self.lasttaunttime = gettime() + randomintrange(3500, 5000);
}

tauntinit(var_0) {
  scripts\asm\zombie_juggernaut\zombie_juggernaut::zombiejuggernaut_requesttaunt();

  if(!istrue(self.playing_vo_taunt)) {
    self _meth_827E("ai_juggernaut_exert_charge");
  }

  return anim._id_EACB;
}

taunt(var_0) {
  if(_id_0009::_id_1C4F("taunt", "end")) {
    return anim._id_EACB;
  }

  return anim._id_CA5F;
}

tauntterminate(var_0) {
  reset_taunt_cooldown();
  return anim._id_EACB;
}

onjuggernautdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  _id_0014::_id_0F74(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_13);
}

onjuggernautdamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(isDefined(var_1) && isPlayer(var_1)) {
    _id_06FC::_id_108F(self, var_1, var_0, var_5, var_2, var_6, var_7, var_8, var_9, var_4);
  }

  _id_0014::_id_11EC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_11, var_12);
  var_13 = 0;
  var_14 = 0;

  if(isDefined(var_12) && var_12 == "j_cosmetic_ammo_pack") {
    var_13 = 1;
    var_14 = 0;
  } else if(var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_PROJECTILE" || var_4 == "MOD_PROJECTILE_SPLASH" || var_4 == "MOD_GRENADE_SPLASH")
    var_14 = 1;

  var_15 = var_8 == "helmet" || var_8 == "head" || var_8 == "neck";

  if(!var_13 && !var_14) {
    if(var_15) {
      if(isvector(var_7)) {
        var_16 = vectornormalize(anglesToForward(self.angles));
        var_17 = vectordot(var_7, var_16);

        if(var_17 > 0.6) {
          var_13 = 1;
        }
      }
    }
  }

  if(var_13 || var_14) {
    damagebackpack(var_2, var_14, var_0, var_6, var_1);
  }

  if(isDefined(var_1) && isPlayer(var_1)) {
    _id_072E::display_damage_number(var_1, self, var_8, var_4, var_5, var_2, var_6);
  }
}

onjuggernautkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  _id_0014::_id_0F7A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(isPlayer(var_1) && self.zm_ai_category == "special") {
    scripts\cp\cp_playerstats::incrementcombatstat(var_1, "specialKills", 1);
    scripts\cp\cp_playerstats::_id_7DF5(var_1, var_4, "specialKills", 1);
  }

  _id_110A5("glow_off");
}

_id_110A5(var_0) {
  if(self _meth_86EE() && self _meth_867A("ai_glow", var_0)) {
    self setscriptablepartstate("ai_glow", var_0);
  }
}

set_turned(var_0) {
  _id_110A5(scripts\engine\utility::ter_op(var_0, "brainrot_loop", "base_loop"));
}

set_frozen(var_0) {
  self.base_model = scripts\cp\utility::_id_459B(self.base_model, "zom_juggernaut_wholebody");
  self.frozen_model = scripts\cp\utility::_id_459B(self.frozen_model, "zom_juggernaut_wholebody_frost");
  self setModel(scripts\engine\utility::ter_op(var_0, self.frozen_model, self.base_model));
}

reset_charge_melee_cooldown() {
  if(!istrue(level.jugg_can_charge_melee)) {
    return;
  }
  self.charge_melee_cooldown_end = gettime() + 45000;
}

can_charge_melee(var_0, var_1) {
  if(!istrue(level.jugg_can_charge_melee)) {
    return 0;
  }

  if(self.health / self.maxhealth > 0.15) {
    return 0;
  }

  if(!isDefined(self.charge_melee_cooldown_end) || gettime() > self.charge_melee_cooldown_end) {
    if(var_0 > 16384) {
      return 1;
    }
  }

  return 0;
}

try_charge_melee(var_0) {
  if(!istrue(var_0)) {
    self.charge_melee_timeout = gettime() + 10000;
    return 1;
  } else if(isDefined(self.charge_melee_timeout) && gettime() > self.charge_melee_timeout) {
    reset_charge_melee_cooldown();
    return 0;
  }

  return 1;
}

shoulddefendlocation(var_0) {
  if(self._id_0229) {
    self._id_012F = undefined;
    return anim._id_58E3;
  }

  if(!has_defend_location()) {
    return anim._id_58E3;
  }

  return anim._id_EACB;
}

_id_461F(var_0) {
  _id_06BD::_id_2408(1);

  if(has_defend_location() && !within_defend_location()) {
    force_defend_location();
  }

  return anim._id_EACB;
}

set_defend_location(var_0) {
  if(!isDefined(var_0)) {
    self.defend_loc = undefined;
    return 1;
  } else {
    var_1 = self _meth_86F8(var_0);

    if(isDefined(var_1)) {
      self.defend_loc = var_1;
      force_defend_location();
      return 1;
    }
  }

  return 0;
}

has_defend_location() {
  return isDefined(self.defend_loc);
}

within_defend_location() {
  if(!has_defend_location()) {
    return 0;
  }

  var_0 = distancesquared(self.origin, self.defend_loc);
  return var_0 <= 4096;
}

force_defend_location() {
  self _meth_84BC(0, self.defend_loc);
}

jugg_dg2_damage_function(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3.dg2_level) || !isDefined(level.dg2_damage_to_specials["jugg"][var_3.dg2_level])) {
    return;
  }
  var_4 = scripts\engine\utility::ter_op(var_2 > 1, 10, level.dg2_damage_to_specials["jugg"][var_3.dg2_level]);
  self dodamage(var_4, var_0, var_1, undefined, "MOD_UNKNOWN", var_3._id_04F6, "head");
}