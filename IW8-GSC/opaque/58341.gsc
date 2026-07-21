/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58341.gsc
***********************************************/

get_ai_spawner(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 6;

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return capsuletracepassed(var_4, self.radius, self.height - var_2, self, 1, 0, 0, var_5);
}

resetbreakertostate() {
  return 8;
}

request_warning_level() {
  return 360.0 / resetbreakertostate();
}

_id_11BCA(var_0, var_1, var_2) {
  var_3 = var_1 * request_warning_level() - 180.0;
  var_4 = var_0 + anglesToForward((0, var_3, 0)) * var_2;
  return var_4;
}

requiredcardtype(var_0) {
  return self._id_11BC9[var_0];
}

_id_140D0(var_0) {
  if(!isDefined(self._id_11BC9))
    self._id_11BC9 = [];

  if(!isDefined(self._id_11BC9[var_0])) {
    self._id_11BC9[var_0] = [];

    for(var_1 = 0; var_1 < resetbreakertostate(); var_1++) {
      self._id_11BC9[var_0][var_1] = spawnStruct();
      self._id_11BC9[var_0][var_1].timestamp = 0;
      self._id_11BC9[var_0][var_1].claimer = undefined;
      self._id_11BC9[var_0][var_1].origin = undefined;
      self._id_11BC9[var_0][var_1].num = var_1;
    }
  }
}

respawn_after_death(var_0) {
  var_1 = var_0.origin;

  if(isDefined(var_0.groundpos)) {
    var_1 = var_0.groundpos;

    if(isDefined(self.lootcachesopened) && var_0 == self.lootcachesopened && should_enter_combat_after_checking_gas_grenade()) {
      var_2 = reset_global_stealth_settings();

      if(isDefined(var_2))
        var_1 = var_2.origin;
    }
  } else if(isPlayer(var_0) && (var_0 isjumping() || var_0 ishighjumping())) {
    if(!isDefined(var_0._id_125BB))
      var_0._id_125BB = 0;

    if(gettime() > var_0._id_125BB) {
      var_0._id_125BA = getgroundposition(var_0.origin, 15);
      var_0._id_125BB = gettime();
    }

    if(isDefined(var_0._id_125BA))
      var_1 = var_0._id_125BA;
  }

  return var_1;
}

show_deposit_hint(var_0, var_1) {
  for(var_2 = 0; var_2 < resetbreakertostate(); var_2++) {
    var_3 = var_0 requiredcardtype(var_1);
    var_4 = var_3[var_2];

    if(isDefined(var_4.origin))
      return 1;
  }

  return 0;
}

freefall_start() {
  var_0 = self getnearestnode();
}

should_enter_combat_after_checking_gas_grenade() {
  var_0 = self getnearestnode();

  if(isDefined(var_0) && isDefined(self.lootcachesopened._id_11E35)) {
    var_1 = self.lootcachesopened._id_11E35["_encstr_934C0218"];

    if(isDefined(var_1))
      return 1;
  }

  return 0;
}

reset_global_stealth_settings() {
  var_0 = self getnearestnode();
  var_1 = self.lootcachesopened._id_11E35["_encstr_934C0218"];

  if(!isnumber(var_1))
    return var_1;
  else
    return undefined;
}

_id_1332A() {
  if(should_enter_combat_after_checking_gas_grenade()) {
    var_0 = reset_global_stealth_settings();

    if(!isDefined(var_0))
      return 0;
  }

  return 1;
}

unset_force_aitype_shotgun(var_0) {
  if(isDefined(self.lootcachesopened) && var_0 == self.lootcachesopened) {
    if(self.lootcachespawncontents > 5)
      return 1;
  }

  return 0;
}

requiredplayercountoveride(var_0, var_1) {
  var_2 = 0;

  if(var_2)
    return var_0.origin;

  if(getdvarint("_encstr_A6131E1F9B6A09D2573291F89AD30330C6F259BB2D17589587C949A1F32746F8", 0))
    return var_0.origin;

  var_0 _id_140D0(self._id_11BCB);
  var_3 = var_0 requiredcardtype(self._id_11BCB);
  var_4 = var_1;
  var_5 = self.origin - var_4;
  var_6 = lengthsquared(var_5);

  if(var_6 < 256) {
    var_7 = -1;

    for(var_8 = 0; var_8 < resetbreakertostate(); var_8++) {
      var_9 = var_3[var_8];

      if(isDefined(var_9.claimer) && var_9.claimer == self)
        var_7 = var_9.num;
    }

    if(var_7 < 0)
      var_7 = self getentitynumber() % resetbreakertostate();

    var_10 = var_7;
  } else {
    var_11 = angleclamp180(vectortoyaw(var_5)) + 180.0;
    var_10 = var_11 / request_warning_level();
    var_7 = int(var_10 + 0.5);
  }

  var_12 = undefined;
  var_13 = -1;
  var_14 = 3;
  var_15 = 2;

  if(var_10 > var_7) {
    var_13 = var_13 * -1;
    var_14 = var_14 * -1;
    var_15 = var_15 * -1;
  }

  var_16 = resetbreakertostate();

  for(var_17 = 0; var_17 < var_16 / 2 + 1; var_17++) {
    for(var_18 = var_13; var_18 != var_14; var_18 = var_18 + var_15) {
      var_19 = var_7 + var_17 * var_18;

      if(var_19 >= var_16)
        var_19 = var_19 - var_16;
      else if(var_19 < 0)
        var_19 = var_19 + var_16;

      var_9 = var_3[var_19];

      if(!isDefined(var_12) && gettime() - var_9.timestamp >= self._id_11BCC) {
        if(isDefined(level._id_13E09) && isDefined(level._id_13E09[self.agent_type]))
          [[level._id_13E09[self.agent_type]]](var_9, var_4, self.challengetimersenabled, self.radius);
        else
          _id_13E09(var_9, var_4, self.challengetimersenabled, self.radius);
      }

      if(!isDefined(var_12) && isDefined(var_9.origin)) {
        var_20 = getclosestpointonnavmesh(var_0.origin, self);
        var_21 = navtrace(var_9.origin, var_20, self, 1);

        if(var_21["_encstr_A53009A25003666B9818C6"] < 0.95) {
          if(!ispointonnavmesh(var_0.origin))
            var_12 = var_20;

          continue;
        }

        var_22 = 0;

        if(isDefined(var_9.claimer) && var_9.claimer != self) {
          var_23 = vectorNormalize(var_4 - var_9.claimer.origin) * self.radius * 2;
          var_22 = distancesquared(var_9.claimer.origin + var_23, var_4);
        }

        if(!isalive(var_9.claimer) || !isDefined(var_9.claimer.initial_forward) || var_9.claimer.initial_forward != var_0 || var_9.claimer == self || var_6 < var_22) {
          if(isalive(var_9.claimer) && var_9.claimer != self) {
            if(!isDefined(var_9.claimer._id_12FBC)) {
              var_24 = var_9.claimer getentitynumber();

              if(getdvarint("_encstr_A28F229BC69C7DE9B76B31A595BEB9BA07C1E4B2CD9BEBCDCA361DDBE47D859B9B2B9CD1", 0) == 0) {}
            }

            if(getdvarint("_encstr_A28F229BC69C7DE9B76B31A595BEB9BA07C1E4B2CD9BEBCDCA361DDBE47D859B9B2B9CD1", 0) == 0) {}

            var_9.claimer._id_12FBC = undefined;
          }

          if(isDefined(self._id_12FBC) && self._id_12FBC != var_9)
            self._id_12FBC.claimer = undefined;

          if(!isDefined(self._id_12FBC) || self._id_12FBC != var_9) {
            self._id_12FBC = var_9;

            if(getdvarint("_encstr_A28F229BC69C7DE9B76B31A595BEB9BA07C1E4B2CD9BEBCDCA361DDBE47D859B9B2B9CD1", 0) == 0) {}

            var_9.claimer = self;
          }

          var_12 = var_9.origin;
        }
      }

      if(var_17 == 0) {
        break;
      }
    }
  }

  return var_12;
}

_id_13E09(var_0, var_1, var_2, var_3) {
  if(gettime() - var_0.timestamp >= 50) {
    var_0.origin = _id_11BCA(var_1, var_0.num, var_2);
    var_0.origin = modifybrgasdamage(var_0.origin, var_3, 55);
    var_0.timestamp = gettime();
  }
}

modifybrgasdamage(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 18;

  var_4 = var_0 + (0, 0, var_3);
  var_5 = var_0 + (0, 0, var_3 * -1);
  var_6 = self aiphysicstrace(var_4, var_5, var_1, var_2, 1);

  if(abs(var_6[2] - var_4[2]) < 0.1)
    return undefined;

  if(abs(var_6[2] - var_5[2]) < 0.1)
    return undefined;

  return var_6;
}

uavdirectionalid() {
  return isDefined(self.dismember_crawl) && self.dismember_crawl;
}

requestgamerprofile() {
  if(!isDefined(self._id_11A67) || self._id_11A67)
    return self._id_11BC4;
  else
    return self._id_11BC5;
}

required_tank_capacity() {
  if(!isDefined(self._id_11A67) || self._id_11A67)
    return self._id_11BC7;
  else
    return self._id_11BC6;
}

_id_11A68(var_0, var_1, var_2, var_3, var_4, var_5) {
  self._id_11A61 = var_0 * 1000.0;
  self._id_11A62 = var_3;
  self._id_11A60 = isDefined(var_4) && var_4;
  self._id_11A64 = var_5;
  self._id_11A69 = var_2;
  self._id_11A6A = squared(self._id_11A69);
  _id_13171(var_1);
}

_id_11A66() {
  if(isDefined(self.load_laser_fx) && self.load_laser_fx > 0) {
    self.load_laser_fx--;

    if(self.load_laser_fx > 0)
      return;
  }

  self._id_11A67 = 1;
}

_id_11A65() {
  if(!isDefined(self.load_laser_fx))
    self.load_laser_fx = 0;

  self.load_laser_fx++;
  self._id_11A67 = 0;
}

make_all_oscilloscopes_usable(var_0, var_1, var_2, var_3) {
  self.magic_shield_fake = var_0 * 1000.0;
  self.magic_rpg_ending = var_1;
  self.maderecentkill = var_2;
  self.lowpopstart = ["_encstr_B69B0589C236B6", "_encstr_8253060E2B5FE330", "_encstr_A5AD056A019C63"];
  self.lumberyard_suicide_truck_speed_manager = [];

  foreach(var_6, var_5 in self.lowpopstart)
  self.lumberyard_suicide_truck_speed_manager[var_6] = level._effect[var_3 + var_5];
}

make_airlock_interactions_usable() {
  if(isDefined(self.little_bird_trail) && self.little_bird_trail > 0) {
    self.little_bird_trail--;

    if(self.little_bird_trail > 0)
      return;
  }

  self.make_all_doors_solid = 1;
}

mainhouse_intel_sequence() {
  if(!isDefined(self.little_bird_trail))
    self.little_bird_trail = 0;

  self.little_bird_trail++;
  self.make_all_doors_solid = 0;
}

wave_spawn_selector(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self.wave_ai_spawned = var_0 * 1000.0;
  self.wave_ai_killed = var_1 * 1000.0;
  self.wave_ai_debug = var_2;
  self.wave_goto_on_spawn = var_3;
  self.wave_paused = squared(self.wave_goto_on_spawn);
  self.wave_progression = var_4;
  self.wave_revive = squared(self.wave_progression);
  self.wave_default_internal = var_6;
  self.wave_aggro_monitor = var_5;
  self.wave_enemies_remaining = 0;
  self.wave_failsafe_end = 0;
}

wave_cooldown_sounds() {
  if(isDefined(self.load_airfield) && self.load_airfield > 0) {
    self.load_airfield--;

    if(self.load_airfield > 0)
      return;
  }

  self.wave_default = 1;
}

wave_airstrikes_allowed() {
  if(!isDefined(self.load_airfield))
    self.load_airfield = 0;

  self.load_airfield++;
  self.wave_default = 0;
}

getbestspectatecandidate(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self scragentsetscripted(1);
  scripts\mp\agents\scriptedagents::setstatelocked(1, "_encstr_9B9A108311C85D577DFD3A724056B35680CF");
  self.trackcratemantlingexploit = 1;
  self scragentsetorientmode("_encstr_ACA40F59396739377AD34F111539438ED7", (0, self.angles[1], 0));
  self scragentsetanimmode("_encstr_8A210C0B7396AD0132B2631DB037");
  self scragentsetanimscale(1, 1);
  scripts\mp\agents\scriptedagents::playanimnuntilnotetrack_safe(var_1, randomint(self getanimentrycount(var_1)), "_encstr_AFDB1236431673D9CA7D16B94BADAF1BB12C9B37");
  self setanimclass(var_0);
  scripts\mp\agents\scriptedagents::setstatelocked(0, "_encstr_9B9A108311C85D577DFD3A724056B35680CF");
  self.trackcratemantlingexploit = 0;
  self scragentsetscripted(0);
}

rungwperif_flak(var_0) {
  var_1 = 50;
  var_2 = 32;
  var_3 = 72;
  var_4 = getmovedelta(var_0);
  var_4 = rotatevector(var_4, self.angles);
  var_5 = self.origin + var_4;
  var_6 = (0, 0, var_1);
  var_7 = self aiphysicstrace(var_5 + var_6, var_5 - var_6, var_2, var_3);
  var_8 = var_7 - var_5;
  return var_8[2];
}

return_num_if_under_vehicle_cap(var_0, var_1, var_2, var_3) {
  var_4 = getanimlength(var_0);
  var_5 = getmovedelta(var_0, 0, var_3 / var_4);
  var_6 = rotatevector(var_5, var_2);
  return var_1 + var_6;
}

removeleadobjective(var_0) {
  var_1 = 0.2;
  var_2 = getanimlength(var_0);
  return min(var_1, var_2);
}

_id_122F9(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self scragentdoanimlerp(self.origin, var_0, var_1);
  wait(var_1);
  self scragentsetanimmode("_encstr_8A210C0B7396AD0132B2631DB037");
}

respawn_waits(var_0, var_1) {
  var_2 = 0;

  if(var_1 > 1) {
    var_3 = int(var_1 * 0.5);
    var_4 = var_3 + var_1 % 2;

    if(var_0 < 0)
      var_2 = randomint(var_4);
    else
      var_2 = var_3 + randomint(var_4);
  }

  return var_2;
}

unset_force_aitype_rpg(var_0) {
  var_1 = self.origin[2] + self.height;

  if(var_0.origin[2] < var_1)
    return 0;

  var_2 = self.origin[2] + self.height + 2 * self.radius;

  if(var_0.origin[2] > var_2)
    return 0;

  if(isPlayer(var_0)) {
    var_3 = var_0 getvelocity()[2];

    if(abs(var_3) > 12)
      return 0;
  }

  var_4 = 15.0;

  if(isDefined(var_0.radius))
    var_4 = var_0.radius;

  var_5 = self.radius + var_4;
  var_5 = var_5 * var_5;

  if(distance2dsquared(self.origin, var_0.origin) > var_5)
    return 0;

  return 1;
}

_id_1314E(var_0) {
  self.favoriteenemy = var_0;
}

is_vandalize_attack_available(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0)) {
    var_3 = var_0 - self gettagorigin("_encstr_83890D94A8AF0B79D830139788913A");
    var_3 = (var_3[0], var_3[1], 0);
    var_4 = vectortoangles(vectorNormalize(var_3));
    var_2 = var_4[1];
  } else if(isDefined(var_1)) {
    var_4 = vectortoangles(var_1);
    var_2 = var_4[1] - 180;
  }

  return var_2;
}

little_bird_initomnvars() {
  if(!isDefined(self.lmg_too_far_away))
    self.lmg_too_far_away = 0;

  self.lmg_too_far_away++;
  little_bird_mg_collision_damage_watcher();
  little_bird_mg_cp_create();
}

sg_think() {
  return istrue(self.should_skip_info_loop);
}

mortars() {
  if(isDefined(level.little_bird_mg_initlate) && level.little_bird_mg_initlate) {
    return;
  }
  if(isDefined(self.lmg_too_far_away) && self.lmg_too_far_away > 0) {
    self.lmg_too_far_away--;

    if(self.lmg_too_far_away > 0)
      return;
  }

  self.should_skip_info_loop = 1;
  mortars_fire_projectile();
  _id_131F2();
  mortars_fire_logic();
}

mortars_fire_projectile() {}

little_bird_mg_cp_create() {}

_id_131F2() {
  var_0 = clamp(level._id_1452A / 20, 0.0, 1.0);
  var_1 = lerp(var_0, 0.35, 0.55);
  var_2 = lerp(var_0, 0.06, 0.12);
  _id_11A68(5.0, self._id_11BC5 * 2, self._id_11BC5 * 1.5, "_encstr_B43F134693B87922BAB7B32F2D548A8FD0587D4A0B", level._effect["_encstr_99750C9935277B592715481B2790"]);
  make_all_oscilloscopes_usable(5.0, var_1, "_encstr_86600C8CED91D995EB13EDDBDC8E", "_encstr_ABDB0D1AD0888F5BB1993704A758A9");
  wave_spawn_selector(10.0, 2.0, var_2, 550, 350, "_encstr_8D240BB1CA8538BEC4F6BDCDE8", level._effect["_encstr_82950B3E48D8D3DB38455F3799"]);
}

mortars_fire_logic() {
  _id_11A66();
  make_airlock_interactions_usable();
  wave_cooldown_sounds();
}

lerp(var_0, var_1, var_2) {
  var_3 = var_2 - var_1;
  var_4 = var_0 * var_3;
  var_5 = var_1 + var_4;
  return var_5;
}

little_bird_mg_collision_damage_watcher() {
  _id_11A65();
  mainhouse_intel_sequence();
  wave_airstrikes_allowed();
}

_id_123CD(var_0) {
  if(!isDefined(self.currentdebugweaponindex)) {
    return;
  }
  if(self.currentdebugweaponindex != "_encstr_8DC40CAD0290E508FDD37328EABA")
    playFXOnTag(var_0, self, self.currentdebugweaponindex);
}

player_in_laststand(var_0) {
  return var_0.inlaststand;
}

play_pullout_sequence(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(player_in_laststand(var_3))
      var_1[var_1.size] = var_3;
  }

  var_5 = [];

  foreach(var_7 in var_0) {
    if(_id_11EA6(var_7)) {
      continue;
    }
    var_8 = 0;

    foreach(var_3 in var_1) {
      if(distancesquared(var_7.origin, var_3.origin) < 65536) {
        var_8 = 1;
        break;
      }
    }

    if(var_8) {
      continue;
    }
    var_5[var_5.size] = var_7;
  }

  return var_5;
}

updateteamplunderhud(var_0, var_1) {
  var_2 = self._id_11BC8 * self._id_11BC8;
  return distancesquared(var_0, var_1) <= var_2;
}

_id_145D8() {
  return updateteamplunderhud(self.origin, self.initial_forward.origin);
}

_id_145D6() {
  if(requestgamerprofile() == self._id_11BC5)
    return _id_145D7();

  var_0 = distancesquared(self.origin, self.initial_forward.origin) <= required_tank_capacity();
  return var_0;
}

_id_145D7() {
  var_0 = distancesquared(self.origin, self.initial_forward.origin) <= self._id_11BC6;

  if(!var_0 && (isPlayer(self.initial_forward) || isagent(self.initial_forward))) {
    var_1 = undefined;
    var_1 = self.initial_forward getgroundentity();

    if(isDefined(var_1) && isDefined(var_1.targetname) && var_1.targetname == "_encstr_BAE50DE60E739BA638C72068AF47B9")
      var_0 = distancesquared(self.origin, self.initial_forward.origin) <= self._id_11BC6 * 4;
  }

  if(!var_0 && isPlayer(self.initial_forward) && istrue(self.initial_forward.unset_relic_squadlink)) {
    if(length(self getvelocity()) < 5)
      var_0 = distancesquared(self.origin, self.initial_forward.origin) <= self._id_11BC6 * 4;
  }

  return var_0;
}

_id_13171(var_0) {
  self._id_11BC4 = var_0;
  self._id_11BC7 = var_0 * var_0;
}

_id_11EA6(var_0) {
  return !isDefined(var_0._id_14700);
}

safehouse_vo_start() {
  if(!isDefined(level._id_146B1))
    return 1;

  return level._id_146B1;
}

_id_1436E() {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    self waittill("_encstr_86E5092BA829F7AB738DA4");
    self.clearsoundsubmixmpbrinfilac130 = 1;

    if(isDefined(self.lootcachesopened))
      self.lootcachespawncontents++;
  }
}

sfx_misc_field_expl() {
  return 1;
}

lightsfloor01() {
  if(isDefined(self.wam_interaction_activate) && isDefined(self.wam_first_node) && distance2dsquared(self.initial_forward.origin, self.wam_interaction_activate) < 4 && distancesquared(self.origin, self.wam_first_node) < 2500)
    return 1;

  return 0;
}

lightscriptable() {
  if(isDefined(self.walla_lab_civ_scientists) && isDefined(self.wake_on_objective_b) && distance2dsquared(self.initial_forward.origin, self.walla_lab_civ_scientists) < 4 && distancesquared(self.origin, self.wake_on_objective_b) < 2500)
    return 1;

  return 0;
}

updatesuperuiprogress(var_0, var_1) {
  var_2 = 0;
  var_3 = var_1[2] - var_0[2];
  var_2 = var_3 <= self.change_stealth_state_to_combat_warpper && var_3 >= self.change_yaw_angle;

  if(!var_2 && isPlayer(self.initial_forward) && istrue(self.initial_forward.unset_relic_squadlink)) {
    if(length(self getvelocity()) < 5)
      var_2 = var_3 <= self.change_stealth_state_to_combat_warpper * 2 && var_3 >= self.change_yaw_angle;
  }

  return var_2;
}

vehicle_collision_dvarinit(var_0) {
  return updatesuperuiprogress(self.origin, var_0);
}

updateteambettermissionrewardsui(var_0, var_1) {
  return distance2dsquared(var_0, var_1) < required_tank_capacity() * 0.75 * 0.75;
}

vehicle_collision_dvarupdate(var_0) {
  return updateteambettermissionrewardsui(self.origin, var_0);
}

_id_1441E() {
  if(unset_force_aitype_rpg(self.initial_forward))
    return 0;

  return !vehicle_collision_dvarinit(self.initial_forward.origin) && vehicle_collision_dvarupdate(self.initial_forward.origin);
}

update_hack_objective_marker() {
  var_0 = self.origin + (0, 0, self._id_11BBB);
  var_1 = self.initial_forward.origin + (0, 0, self._id_11BBB);

  if(!isPlayer(self.initial_forward) && !isai(self.initial_forward))
    return 0;

  var_2 = scripts\engine\trace::create_default_contents(1);

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1, self.initial_forward, var_2))
    return 0;

  return 1;
}

isreallyalive(var_0) {
  if(isalive(var_0) && !isDefined(var_0.fauxdead))
    return 1;

  return 0;
}

_id_12A48(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(self.initial_forward))
    return 0;

  if(!isreallyalive(self.initial_forward))
    return 0;

  if(self.aistate == "_encstr_B8C809C3F5BF6B6D9093AF")
    return 0;

  if(!unset_force_aitype_rpg(self.initial_forward)) {
    if(!vehicle_collision_dvarinit(self.initial_forward.origin))
      return 0;

    if(var_0 == "_encstr_B8F1082832CF83F1AF68" && !_id_145D8())
      return 0;

    if(var_0 == "_encstr_820E07FAE8780B3A4C" && !_id_145D6())
      return 0;
    else if(var_0 == "_encstr_A29B05E9400E5D" && !_id_145D7())
      return 0;
  }

  self.wam_failure_threshold = undefined;

  if(var_1 && update_hack_objective_marker()) {
    self.wam_failure_threshold = 1;
    return 0;
  }

  return 1;
}

requested_veh_spawners(var_0) {
  if(!isDefined(self._id_11BBA))
    self._id_11BBA = spawnStruct();

  if(unset_force_aitype_shotgun(var_0) && !should_enter_combat_after_checking_gas_grenade())
    freefall_start();

  var_1 = respawn_after_death(var_0);
  self._id_11BBA.nuke_addteamrankxpmultiplier = var_1;
  var_2 = requiredplayercountoveride(var_0, var_1);

  if(isDefined(var_2)) {
    self._id_11BBA._id_140C0 = 1;
    self._id_11BBA.origin = var_2;
  } else {
    self._id_11BBA._id_140C0 = 0;
    self._id_11BBA.origin = var_1;

    if(isDefined(self.lootcachesopened)) {
      if(!isDefined(modifybrgasdamage(self._id_11BBA.origin, 15, 55))) {
        if(!isDefined(self._id_129FA)) {
          self._id_129FA = [];

          for(var_3 = 0; var_3 < resetbreakertostate(); var_3++)
            self._id_129FA[self._id_129FA.size] = var_3;

          self._id_129FA = scripts\engine\utility::array_randomize(self._id_129FA);
        }

        foreach(var_5 in self._id_129FA) {
          var_6 = var_0 requiredcardtype(self._id_11BCB);
          var_7 = var_6[var_5];

          if(isDefined(var_7.origin)) {
            self._id_11BBA.origin = var_7.origin;
            break;
          }
        }
      }
    }
  }

  return self._id_11BBA;
}

_id_13303(var_0, var_1) {
  if(istrue(player_in_laststand(var_0)))
    return 1;

  if(isDefined(var_0.team) && isDefined(self.team) && self.team == var_0.team)
    return 1;

  if(updateondamagepredamagemodrelics(var_0))
    return 1;

  if(isDefined(var_0.killing_time))
    return 1;

  if(istrue(var_0.notarget))
    return 1;

  if(istrue(var_0.ignoreme))
    return 1;

  if(!isalive(var_0))
    return 1;

  if(!istrue(var_1) && !istrue(self._id_13305)) {
    if(isDefined(var_0.trial_targs) && !var_0.trial_targs)
      return 1;
  }

  if(isDefined(level._id_13304)) {
    if([[level._id_13304]](var_0))
      return 1;
  }

  return 0;
}

updateondamagepredamagemodrelics(var_0) {
  return isDefined(var_0.trial_flare_watcher) && var_0.trial_flare_watcher;
}

get_all_doors_ai_should_open(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 6;

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return capsuletracepassed(var_4, self.radius, self.height - var_2, self, 1, 0, 0, var_5);
}

ishost(var_0) {
  return level.brclampstepdamage.iskillstreakdeployweapon["_encstr_BD5A07E308CB04BA97"][var_0];
}

ishotjoiningplayer(var_0) {
  var_1 = scripts\mp\agents\scriptedagents::getangleindexfromselfyaw(var_0);
  return level.brclampstepdamage.iskillstreakdeployweapon["_encstr_AD990DA12DD1444B9395D81D2DDE73"][var_1];
}

respawncircleinterppct(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2))
    var_4 = var_3[var_0][var_1][var_2];
  else
    var_4 = var_3[var_0][var_1];

  return var_4[randomint(var_4.size)];
}

_id_13173(var_0) {
  self.legacy.movemode = var_0;
  scripts\asm\asm_bb::bb_requestmovetype(self.legacy.movemode);

  if(var_0 == "_encstr_99F605EE16B1DA")
    self._id_11EB2 = 0.8;
  else if(var_0 == "_encstr_B4190493D573")
    self._id_11EB2 = 1.0;
  else if(var_0 == "_encstr_92100762872552A643")
    self._id_11EB2 = 1.2;
}

_id_131BB(var_0) {
  var_1["_encstr_99F605EE16B1DA"] = [0.65, 1.2];
  var_1["_encstr_B4190493D573"] = [0.8, 1.1];
  var_1["_encstr_92100762872552A643"] = [0.9, 1.3];

  if(!isDefined(self._id_12A07))
    self._id_12A07 = randomfloatrange(-0.1, 0.1);

  var_2 = clamp(var_0 + self._id_12A07, 0.0, 2.0);

  if(var_0 <= 1.0) {
    var_3 = var_1[self.legacy.movemode][0];
    var_4 = 1;
    var_5 = var_3 + var_0 * (var_4 - var_3);
  } else {
    var_3 = 1;
    var_4 = var_1[self.legacy.movemode][1];
    var_5 = var_3 + (var_0 - 1) * (var_4 - var_3);
  }

  self._id_11DB4 = var_5;
  self._id_13D13 = var_5;
}