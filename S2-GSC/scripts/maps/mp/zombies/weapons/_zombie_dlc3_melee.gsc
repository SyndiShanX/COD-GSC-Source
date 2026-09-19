/******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\weapons\_zombie_dlc3_melee.gsc
******************************************************************/

init() {
  level._effect["zmb_blood_blast"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_med_trap_gib");
  level._effect["zmb_bat_long_hit_crit_blood"] = loadfx("vfx/blood/zmb_bat_long_hit_crit_blood");
  level._effect["zmb_raven_sword_barb_burst"] = loadfx("vfx/zombie/zmb_sword_barb_burst");
  level._effect["zmb_giestkraft_impact"] = loadfx("vfx/zombie/zmb_giestkraft_impact");

  if(!isDefined(level._id_6DF9))
    level._id_6DF9 = [];

  thread sword_init();
  thread scale_dlc3_melee_damage();
}

scale_dlc3_melee_damage() {
  while(!isDefined(level._id_0A50) || !isDefined(level._id_0A50["zombie_generic"]))
    waitframe();

  level.swordcleavedamages = [0.9, 0.6, 0.5, 0.4];
  var_0 = 1;

  for(;;) {
    var_1 = maps\mp\gametypes\zombies::_id_1E59(_id_0547::_id_0A51("zombie_generic"), var_0);
    var_2 = var_1;

    if(isDefined(level.zmb_global_zombie_health_multiplier) && isDefined(level.zmb_global_zombie_health_multiplier_wave_start) && level._id_A980 >= level.zmb_global_zombie_health_multiplier_wave_start)
      var_2 = int(var_1 * level.zmb_global_zombie_health_multiplier);

    level.sworddamage = max(1, var_2 * 0.26);
    level.swordcleavedamagebase = var_2;
    level.swordthrowimpactdamage = var_2 * 1;
    level waittill("waveupdate");
    var_0 = level._id_A980;
  }
}

setup_melee_weapon_ownership(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.hasfunc = var_0;
  var_3.gainedfunc = var_1;
  var_3.lostfunc = var_2;
  thread maps\mp\_utility::_id_6F74(::watch_melee_weapon_ownership, var_3);
}

watch_melee_weapon_ownership(var_0) {
  self endon("disconnect");
  var_1 = 0;

  for(;;) {
    var_2 = [[var_0.hasfunc]]();

    if(var_1 != var_2) {
      if(var_2)
        thread[[var_0.gainedfunc]]();
      else
        thread[[var_0.lostfunc]]();

      var_1 = var_2;
    }

    common_scripts\utility::_id_A70A("weapon_taken", "weapon_given");
  }
}

setup_melee_abilityinfo(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = 0.25;

  var_5 = spawnStruct();
  var_5._id_953E = var_0;
  var_5.firedelay = var_1;
  var_5.weaponlostendon = var_2;
  var_5.firingfunction = var_3;
  var_5.isheavymelee = var_4;
  return var_5;
}

setup_normal_melee_abilityinfo(var_0, var_1, var_2, var_3) {
  return setup_melee_abilityinfo(var_0, var_1, var_2, var_3, 0);
}

setup_heavy_melee_abilityinfo(var_0, var_1, var_2, var_3) {
  return setup_melee_abilityinfo(var_0, var_1, var_2, var_3, 1);
}

run_melee_ability(var_0) {
  self endon("disconnect");

  if(isDefined(var_0.weaponlostendon))
    self endon(var_0.weaponlostendon);

  for(;;) {
    self waittill("melee_fired", var_1);

    if(issubstr(var_1, var_0._id_953E) && var_0.isheavymelee == self _meth_8661()) {
      if(isDefined(var_0.firedelay))
        wait(var_0.firedelay);

      if(melee_ability_in_melee_state(var_0)) {
        thread[[var_0.firingfunction]](var_0);

        if(isDefined(var_0.afterfiringdelay)) {
          wait(var_0.afterfiringdelay);
          continue;
        }

        if(var_0.isheavymelee) {
          while(self _meth_8661())
            waitframe();

          continue;
        }

        while(self ismeleeing())
          waitframe();
      }
    }
  }
}

melee_ability_in_melee_state(var_0) {
  if(var_0.isheavymelee)
    return self _meth_8661();
  else
    return self ismeleeing();
}

bayo_charge_watcher_zm(var_0, var_1, var_2) {
  self endon("death");
  self endon("disconnect");
  self notify("bayoCharge_watcher_zm");
  self endon("bayoCharge_watcher_zm");

  for(;;) {
    self waittill("sprint_melee_charge_begin");
    var_3 = self getcurrentweapon();

    if(!issubstr(var_3, var_0)) {
      continue;
    }
    togglemarathonability(0);

    if(isDefined(var_1))
      self thread[[var_1]]();

    thread bayochargeendingtracking(var_2);
    thread bayochargehittracking(var_2);
  }
}

bayochargecleanup(var_0, var_1) {
  togglemarathonability(1);

  if(isDefined(var_0))
    self thread[[var_0]](var_1);

  self notify("bayoCleanup");
}

bayochargeendingtracking(var_0) {
  self endon("disconnect");
  self endon("bayoCleanup");
  var_1 = common_scripts\utility::waittill_any_return("death", "sprint_melee_charge_end");
  waittillframeend;
  thread bayochargecleanup(var_0, var_1);
}

bayochargehittracking(var_0) {
  self endon("disconnect");
  self endon("bayoCleanup");
  self waittill("sprint_melee_charge_attack");
  thread bayochargecleanup(var_0, "sprint_melee_charge_attack");
}

togglemarathonability(var_0) {
  if(!_id_056A::_id_4B7E("runperk")) {
    return;
  }
  if(var_0)
    maps\mp\_utility::giveperk("specialty_marathon");
  else
    maps\mp\_utility::_id_0735("specialty_marathon");
}

sword_init() {
  level._id_62B3["zom_dlc3_5_zm"] = ::sword_modify_damage;
  level.zombiemeleeweapon["zom_dlc3_5_zm"] = 1;
  level._id_2FE9["zom_dlc3_5_zm"] = 1;
  level._id_4D3D["zom_dlc3_5_zm"] = 1;
  level.zerorewardweapons["zom_dlc3_5_zm"] = 1;
  level.nolevelup["zom_dlc3_5_zm"] = 1;
  level.meleeaoeweapons["zom_dlc3_5_aoe_zm"] = 1;
  level._id_2FE9["zom_dlc3_5_aoe_zm"] = 1;
  level._id_4D3D["zom_dlc3_5_aoe_zm"] = 1;
  level.zerorewardweapons["zom_dlc3_5_aoe_zm"] = 1;
  level.nopainweapons["zom_dlc3_5_aoe_zm"] = 1;
  level.nolevelup["zom_dlc3_5_aoe_zm"] = 1;
  level.meleeaoeweapons["zom_dlc3_5_throw_zm"] = 1;
  level._id_2FE9["zom_dlc3_5_throw_zm"] = 1;
  level._id_4D3D["zom_dlc3_5_throw_zm"] = 1;
  level.zerorewardweapons["zom_dlc3_5_throw_zm"] = 1;
  level.meleeaoeweapons["zom_dlc3_5_bomb_zm"] = 1;
  level._id_2FE9["zom_dlc3_5_bomb_zm"] = 1;
  level._id_4D3D["zom_dlc3_5_bomb_zm"] = 1;
  level.zerorewardweapons["zom_dlc3_5_bomb_zm"] = 1;
  level.nodamagescalingweapons["zom_dlc3_5_bomb_zm"] = 1;
  level._effect["zmb_barb_victim_drain_armor"] = loadfx("vfx/gameplay/mp/zombie/zmb_melee_drain_player");
  level._effect["zmb_barb_victim_geist_drain"] = loadfx("vfx/zombie/dark_energy_burst");
  level._effect["zmb_barb_geist_bomb_vesting"] = loadfx("vfx/zombie/dark_energy_burst_flare");
  level._effect["zmb_barb_geist_bomb_ready"] = loadfx("vfx/zombie/zmb_sword_giestbomb");
  level._effect["zmb_barb_sword_activate"] = loadfx("vfx/zombie/zmb_combined_sword_activate");
  level._effect["zmb_barb_sword_activate_wv"] = loadfx("vfx/zombie/zmb_combined_sword_activate_wv");
  level._effect["zmb_barb_sword_stun"] = loadfx("vfx/zombie/zmb_giestkraft_impact");
  level._effect["zmb_barb_sword_stun_secondary"] = loadfx("vfx/zombie/zmb_sword_stunbomb_impact");
  level._effect["zmb_sword_zmb_throw"] = loadfx("vfx/trail/zmb_sword_zmb_throw");
  level._effect["zmb_sword_stunbomb_aoe"] = loadfx("vfx/zombie/zmb_sword_stunbomb_aoe");
  level._effect["zmb_giestbomb_radius"] = loadfx("vfx/zombie/zmb_giestbomb_radius");
  level._effect["zmb_sword_point_purchase"] = loadfx("vfx/zombie/zmb_giestkraft_impact");
  level._effect["zmb_giestbomb_priming"] = loadfx("vfx/zombie/zmb_giestbomb_prime");
  level._effect["zmb_giestbomb_detonation"] = loadfx("vfx/zombie/zmb_giestbomb_exp_10s");

  if(!isDefined(level._effect["zmb_delivery_radius"]))
    level._effect["zmb_delivery_radius"] = loadfx("vfx/zombie/zmb_giestbomb_radius");

  if(!isDefined(level._effect["zmb_delivery_radius_128"]))
    level._effect["zmb_delivery_radius_128"] = loadfx("vfx/zombie/zmb_giestbomb_radius_128");

  if(!isDefined(level._effect["zmb_delivery_radius_256"]))
    level._effect["zmb_delivery_radius_256"] = loadfx("vfx/zombie/zmb_giestbomb_radius_256");

  var_0 = [];
  var_0[16]["noGib"] = 1;
  var_1 = (42.816, 5.533, 0);
  var_2 = length(var_1);
  var_3["hit_worldmodel_anim"] = "va_melee_barb_swd_base_stun_hit_world";
  var_3["hit_zombie_action"] = "energy_hold_start";
  var_3["hit_zombie_snd"] = "zmb_sword_melee_hit";
  var_3["fatal_worldmodel_anim"] = "va_melee_barb_swd_base_stun_hit_world";
  var_3["fatal_zombie_action"] = "energy_hold_start";
  var_3["dismemberment_override"] = var_0;
  var_3["fatal_zombie_pos"] = var_1;
  var_3["fatal_zombie_dist"] = var_2;
  var_3["fatal_zombie_snd"] = "zmb_sword_melee_hit";
  var_3["invalid_pair_distance"] = 60;
  var_3["hit_zombie_blend_duration"] = 3;
  level._id_6DF9["heavy"]["zom_dlc3_5_zm"] = var_3;
  _id_0547::_id_7BA9(::sword_onenemykilled);
  _id_054D::_id_7BC6(::sword_stun_on_zombie_damaged);
  _id_0547::_id_7BD0("barb_sword_stun", ::sword_stun_run, ::sword_stun_interrupt, 5.5, ::sword_stun_end);
  _id_0547::_id_7BD0("barb_sword_stun_secondary", ::sword_secondary_stun_run, ::sword_secondary_stun_interrupt, 3.875, ::sword_secondary_stun_end);
  _id_0547::_id_7BD0("barb_sword_throw", ::sword_throw_run, ::sword_throw_interrupt, 5.75, ::sword_throw_end);
  setup_melee_weapon_ownership(::has_sword, ::sword_gained, ::sword_lost);
}

has_sword() {
  var_0 = self _meth_82D5();
  return issubstr(var_0, "zom_dlc3_5_zm");
}

sword_gained() {
  thread sword_think();
}

sword_lost() {
  self.laststandlastmomentcallback = undefined;
  thread sword_cleanup_empower();
  self notify("sword_lost");
}

sword_modify_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!var_1 _meth_8661()) {
    var_0.ignorethiszerodamage = 1;
    return 0;
  }

  return level.sworddamage;
}

sword_think() {
  var_0 = self;

  if(!isDefined(var_0.swordinvestment))
    var_0.swordinvestment = spawnStruct();

  var_1 = setup_normal_melee_abilityinfo("zom_dlc3_5_zm", 0.45, "sword_lost", ::sword_melee_cone);
  var_1.afterfiringdelay = 0.05;
  thread run_melee_ability(var_1);

  if(common_scripts\utility::_id_562E(1))
    self.laststandlastmomentcallback = ::geist_bomb_revive_last_chance;

  thread sword_geist_bomb_detonate_think();
  thread sword_handle_empower();
}

sword_melee_cone(var_0) {
  var_1 = _id_0586::zombies_hit_by_melee_cone(350, 100);
  var_1 = _sortbydistance(var_1, self.origin);
  var_2 = [];
  var_3 = [];

  foreach(var_5 in var_1) {
    var_6 = sword_can_throw(var_5);

    if(var_5 maps\mp\agents\humanoid\_humanoid_util::_id_56BC())
      var_6 = 0;

    if(var_6) {
      var_6 = var_6 &is_sword_stunned_zombie(var_5);

      if(common_scripts\utility::_id_562E(1))
        var_6 = var_6 | is_sword_secondary_stunned_zombie(var_5);
    }

    if(var_6) {
      var_2[var_2.size] = var_5;
      continue;
    }

    var_3[var_3.size] = var_5;
  }

  var_8 = var_3.size;

  for(var_9 = 0; var_9 < var_3.size; var_9++) {
    var_10 = var_9;
    thread delayed_sword_hit(var_3[var_9], var_10, 0);
  }

  for(var_9 = 0; var_9 < var_2.size; var_9++) {
    var_10 = 0;
    thread delayed_sword_hit(var_2[var_9], var_10, 1);
  }

  var_11 = common_scripts\utility::_id_44F5("zmb_raven_sword_barb_burst");
  playFX(var_11, self.origin + (0, 0, 50), anglesToForward(self.angles));
  _id_0378::_id_8D74("zmb_sword_aoe", self.origin);
}

is_sword_stunned_zombie(var_0) {
  return isDefined(var_0.activeswordstunplayers) && var_0.activeswordstunplayers.size > 0;
}

is_sword_secondary_stunned_zombie(var_0) {
  return isDefined(var_0.activesecondarystuns) && var_0.activesecondarystuns.size > 0;
}

delayed_sword_hit(var_0, var_1, var_2) {
  var_3 = self;
  var_3 endon("disconnect");
  var_0 endon("death");

  for(var_4 = 0; var_4 < var_1; var_4++)
    waitframe();

  if(var_2) {
    wait 0;
    var_5 = create_sword_throw_params(var_3);
    var_0.throwingzombie = 1;
    var_0 _id_0547::_id_7D1A("barb_sword_throw", [var_5], 0.25);
  } else {
    var_6 = _id_0547::_id_0A51(var_0._id_0A4B);
    var_7 = common_scripts\utility::_id_562E(var_0.scaleshealthbyplayers) || common_scripts\utility::_id_562E(var_6.scaleshealthbyplayers);
    var_8 = sword_cleave_get_damage(var_7);
    var_9 = 1;

    if(common_scripts\utility::_id_562E(1)) {
      if(isDefined(var_6) && isDefined(var_6.energyholdpain) && is_sword_stunned_zombie(var_0)) {
        var_8 = int(var_8 * var_6.energyholdpain);
        var_0 notify("energyHoldPain");
        var_0.energyholdpaindealt = 1;
      }
    }

    if(common_scripts\utility::_id_562E(1)) {
      if(isDefined(var_6) && isDefined(var_6.energyholdkill))
        var_8 = var_0.maxhealth + 10;
    }

    _id_0378::_id_8D74("zmb_sword_melee_hit_delayed", var_0.origin);
    var_0 dodamage(var_8, var_3 getEye(), var_3, var_3, "MOD_MELEE", "zom_dlc3_5_aoe_zm", "none");
    _playfxontag(level._effect["zmb_giestkraft_impact"], var_0, "J_Spine4");

    if(common_scripts\utility::_id_562E(0)) {
      if(!common_scripts\utility::_id_562E(1) || level.players.size <= 0) {
        if(isDefined(var_0._id_0A4B)) {
          if(isDefined(var_6) && common_scripts\utility::_id_562E(var_6.knockbybladebarbarossa))
            _id_0547::_id_7D1B(var_3, var_0, "far");
        }
      }
    }
  }
}

sword_cleave_get_damage(var_0) {
  var_1 = level.players.size;
  var_1 = int(clamp(var_1, 1, 4));

  if(!common_scripts\utility::_id_562E(1) || common_scripts\utility::_id_562E(var_0))
    var_1 = 1;

  var_2 = level.swordcleavedamages[var_1 - 1];
  return level.swordcleavedamagebase * var_2;
}

is_sword_weapon(var_0) {
  if(!isDefined(var_0))
    return 0;

  switch (var_0) {
    case "zom_dlc3_5_bomb_zm":
    case "zom_dlc3_5_throw_zm":
    case "zom_dlc3_5_aoe_zm":
    case "zom_dlc3_5_zm":
      return 1;
  }

  return 0;
}

sword_onenemykilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self;

  if(!_isagent(var_9)) {
    return;
  }
  if(is_sword_weapon(var_4)) {
    var_9 thread playzombiekilledbeamexplodefx();

    if(var_4 != "zom_dlc3_5_bomb_zm") {
      if(1)
        var_9 sword_empower_handle_zombie_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
    }
  }

  if(isDefined(var_1) && isPlayer(var_1) && var_1 has_sword()) {
    if(common_scripts\utility::_id_562E(self._id_0103))
      var_9 thread sword_on_heavy_melee_kill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  }

  var_9 sword_stun_handle_zombie_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  var_9 sword_secondary_stun_handle_zombie_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
  var_9 sword_throw_handle_zombie_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

playzombiekilledbeamexplodefx() {
  var_0 = self gettagorigin("J_MainRoot");

  if(!isDefined(var_0))
    var_0 = self.origin;

  playFX(common_scripts\utility::_id_44F5("zmb_blood_blast"), var_0);
}

sword_stun_on_zombie_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = self;

  if(issubstr(var_5, "zom_dlc3_5_zm") && var_1 _meth_8661() && !common_scripts\utility::_id_562E(var_11._id_0103))
    var_1 attempt_sword_stun(var_11);
}

attempt_sword_stun(var_0) {
  var_1 = self;

  if(!isDefined(var_0._id_0A4B)) {
    return;
  }
  if(!sword_can_stun(var_0)) {
    return;
  }
  var_2 = sword_get_player_num(var_1);

  if(common_scripts\utility::_id_562E(1)) {
    if(var_0._id_0A4B == "zombie_heavy")
      var_0 thread _id_0567::zombie_heavy_set_grudge(var_1);
  }

  var_0 notify("sword_stun_begin_" + var_2);

  if(!isDefined(var_0.activeswordstunplayers))
    var_0.activeswordstunplayers = [];

  var_0.lastswordstunplayer = var_1;

  if(var_0.activeswordstunplayers.size == 0) {
    var_0 thread play_shock_fx("zmb_barb_sword_stun", "J_Spine4", undefined, 1.0, "sword_stun_shock", "all_sword_stuns_expired");
    var_0 _id_0547::add_zombie_stun("barb_sword", level);
    var_0 _id_0378::_id_8D74("dlc3_barbarosa_sword_stun", "stun_on");
    var_3 = [var_0, "all_sword_stuns_expired"];
    var_4 = create_sword_stun_params(var_3);
    var_0 thread _id_0547::_id_7D1A("barb_sword_stun", [var_4], undefined, var_3);
  } else {}

  var_0.activeswordstunplayers[var_2] = var_1;
  level thread sword_stun_handle_expire(var_0, var_1);
}

sword_get_player_num(var_0) {
  var_1 = var_0 getentitynumber();
  return var_1;
}

sword_stun_handle_expire(var_0, var_1) {
  var_2 = sword_get_player_num(var_1);
  var_0 endon("death");
  var_0 endon("sword_stun_begin_" + var_2);
  common_scripts\utility::_id_A70D(4, var_1, "disconnect");
  level sword_stun_verify_stunners(var_0);
  level thread sword_stun_expire(var_0, var_2);
}

play_shock_fx(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify(var_4);

  if(isDefined(var_2))
    var_2 endon("disconnect");

  self endon("death");
  self endon(var_4);
  self endon(var_5);

  for(;;) {
    var_6 = gettime() / 1000;

    if(isDefined(self.recentshockfxtime) && var_6 - self.recentshockfxtime < var_3)
      wait(var_3 - (var_6 - self.recentshockfxtime));

    _playfxontag(common_scripts\utility::_id_44F5(var_0), self, var_1);
    self.recentshockfxtime = var_6;
    wait(var_3);
  }
}

sword_stun_expire(var_0, var_1) {
  var_0.activeswordstunplayers[var_1] = undefined;
  var_0 _id_0378::_id_8D74("dlc3_barbarosa_sword_stun", "stun_off");
  var_0.lastswordstunplayer = undefined;

  if(var_0.activeswordstunplayers.size == 0) {
    var_0 _id_0547::remove_zombie_stun("barb_sword");
    var_0 notify("all_sword_stuns_expired");
  }
}

sword_stun_verify_stunners(var_0) {
  foreach(var_3, var_2 in var_0.activeswordstunplayers) {
    if(!isDefined(var_2) || !isPlayer(var_2))
      var_0.activeswordstunplayers[var_3] = undefined;
  }
}

sword_stun_handle_zombie_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self;

  if(isDefined(var_9.activeswordstunplayers)) {
    level sword_stun_verify_stunners(var_9);
    var_10 = var_9.activeswordstunplayers;

    foreach(var_13, var_12 in var_10)
    level thread sword_stun_expire(var_9, var_13);
  }

  thread sword_stun_secondary_aoe_trigger_cleanup(var_9);
}

create_sword_stun_params(var_0) {
  var_1 = spawnStruct();
  var_1.endon_pairs = var_0;
  return var_1;
}

sword_stun_run(var_0) {
  var_1 = self;
  var_2 = common_scripts\utility::_id_0F82(var_1.activeswordstunplayers);
  var_1 scragentsetscripted(1);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "barb_sword_stun");
  var_1 _id_0542::set_invalid_melee_pairing_reason("barb_sword_stun", 1);

  if(common_scripts\utility::_id_562E(1))
    thread sword_stun_secondary_aoe_trigger(var_1);

  sword_stun_intro(var_0);
  sword_stun_loop(var_0);

  if(common_scripts\utility::_id_562E(1) && isDefined(var_2) && isalive(var_2)) {
    if(sword_can_stun_kill(var_1))
      var_1 dodamage(var_1.maxhealth + 10, var_2 getEye(), var_2, var_2, "MOD_MELEE", "zom_dlc3_5_aoe_zm", "none");
  }

  sword_stun_recover(var_0);
}

sword_stun_intro(var_0) {
  var_1 = self;
  var_2 = undefined;
  var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("energy_hold_start");
  var_4 = self getanimentrycount(var_3);

  if(isDefined(var_2))
    var_5 = var_2;
  else
    var_5 = randomint(var_4);

  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  childthread maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_3, var_5, 1, "scripted_anim");
  var_1 common_scripts\utility::_id_A70A("Notetrack_Timeout", "energyHoldPain");
}

sword_stun_loop_pain_anim(var_0) {
  var_1 = self;
  var_2 = undefined;
  var_3 = var_1 maps\mp\agents\_scripted_agent_anim_util::_id_434D("energy_hold_pain");
  var_4 = var_1 getanimentrycount(var_3);

  if(isDefined(var_2))
    var_5 = var_2;
  else
    var_5 = randomint(var_4);

  var_1 scragentsetanimmode("anim deltas");
  var_1 scragentsetorientmode("face angle abs", self.angles);
  var_6 = var_1 getanimentry(var_3, var_5);
  var_7 = _getanimlength(var_6);
  var_1 setanimstate(var_3, var_5, 1);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_3, var_5, 1, "scripted_anim");
}

sword_stun_loop_anim(var_0) {
  var_1 = self;
  var_2 = undefined;
  var_3 = var_1 maps\mp\agents\_scripted_agent_anim_util::_id_434D("energy_hold_loop");
  var_4 = var_1 getanimentrycount(var_3);

  if(isDefined(var_2))
    var_5 = var_2;
  else
    var_5 = randomint(var_4);

  var_1 scragentsetanimmode("anim deltas");
  var_1 scragentsetorientmode("face angle abs", self.angles);
  var_6 = var_1 getanimentry(var_3, var_5);
  var_7 = _getanimlength(var_6);
  var_1 setanimstate(var_3, var_5, 1);
  var_1 childthread maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_3, var_5, 1, "scripted_anim");
  var_1 common_scripts\utility::_id_A70A("Notetrack_Timeout", "energyHoldPain");
}

sword_stun_loop(var_0) {
  var_1 = self;
  var_1 endon("all_sword_stuns_expired");

  while(var_1.activeswordstunplayers.size > 0) {
    if(common_scripts\utility::_id_562E(var_1.energyholdpaindealt)) {
      var_1 sword_stun_loop_pain_anim(var_0);
      var_1.energyholdpaindealt = undefined;
      continue;
    }

    var_1 sword_stun_loop_anim(var_0);
  }
}

sword_stun_recover(var_0) {
  var_1 = undefined;
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("energy_hold_end");
  var_3 = self getanimentrycount(var_2);

  if(isDefined(var_1))
    var_4 = var_1;
  else
    var_4 = randomint(var_3);

  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_2, var_4, 1, "stun_anim");
}

sword_stun_interrupt(var_0) {
  var_1 = self;

  if(var_1.activeswordstunplayers.size > 0) {
    var_0.requeued = 1;
    var_1 thread _id_0547::_id_7D1A("barb_sword_stun", [var_0], undefined, var_0.endon_pairs);
  }
}

sword_stun_end(var_0) {
  var_1 = self;
  var_1 _id_0542::set_invalid_melee_pairing_reason("barb_sword_stun", 0);
  sword_stun_secondary_aoe_trigger_cleanup(var_1);
  var_1 scragentsetscripted(0);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "barb_sword_stun");
}

sword_stun_secondary_aoe_trigger(var_0) {
  var_0 endon("death");
  var_0 endon("stun_aoe_cleanup");
  var_0.aoestuntrigger = spawn("trigger_radius", var_0.origin, 0, 36, 120);
  var_0.aoestunfx = _spawnlinkedfx(level._effect["zmb_sword_stunbomb_aoe"], var_0, "J_spine4");
  _triggerfx(var_0.aoestunfx);

  for(;;) {
    var_0.aoestuntrigger waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    if(!_isagent(var_1)) {
      continue;
    }
    if(!isalive(var_1)) {
      continue;
    }
    if(isDefined(var_1._id_000A) && var_1._id_000A == level._id_746E) {
      continue;
    }
    if(var_1 == var_0) {
      continue;
    }
    var_1 sword_add_secondary_stun(var_0);
  }
}

sword_stun_secondary_aoe_trigger_cleanup(var_0) {
  var_0 sword_secondary_stun_cleanup_outgoing_stuns();

  if(isDefined(var_0.aoestuntrigger)) {
    var_0 notify("stun_aoe_cleanup");
    var_0.aoestunfx delete();
    var_0.aoestunfx = undefined;
    var_0.aoestuntrigger delete();
    var_0.aoestuntrigger = undefined;
  }
}

create_sword_throw_params(var_0) {
  var_1 = spawnStruct();
  var_1._id_0117 = var_0;
  var_1.ownerinitialangles = var_0 _meth_8566();
  return var_1;
}

sword_throw_run(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1.immunetotackling = 1;
  var_1.swordthrowowner = var_0._id_0117;
  var_1 scragentsetscripted(1);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "barb_sword_throw");
  var_1 thread sword_throw_handle_collision(var_0);

  if(common_scripts\utility::_id_562E(1))
    var_1 thread sword_throw_damage_impacted_zombies(var_0);

  _playfxontag(common_scripts\utility::_id_44F5("zmb_sword_zmb_throw"), var_1, "tag_origin");
  var_1 _id_0378::_id_8D74("dlc3_barbarosa_swrd_knockback");
  var_1 sword_throw_animate(var_0);
}

set_sword_throw_state(var_0) {
  var_1 = self;
  var_1.swordthrowstate = var_0;
}

sword_throw_handle_collision(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("sword_throw_end");

  if(common_scripts\utility::_id_562E(0)) {
    var_2 = self gettagorigin("J_Spine4");
    var_3 = spawn("script_model", var_2);
    var_3 setModel("tag_origin");
    var_3._id_0117 = var_1;
    var_4 = 180;
    var_3 linktosynchronizedparent(var_1, "tag_origin", (0, 0, 0), (0, var_4, 0));
    var_1 maps\mp\agents\_agent_utility::deleteentonagentdeath(var_3);
    thread cleanup_ent_on_throw_end(var_3);
    var_5 = spawnStruct();
    var_5._id_2434 = 37;
    var_5._id_60C1 = 55;
    var_5._id_3A20 = 82;
    var_5._id_1B70 = 160;
    var_1 childthread _id_0547::tackle_thread(var_3, var_5);
  }

  var_6 = var_1.origin;
  var_7 = 100;
  var_8 = var_0.ownerinitialangles[1];
  var_9 = 10;
  wait 0.25;

  for(;;) {
    waitframe();
    var_10 = var_1.origin - var_6;

    if(_lengthsquared(var_10) < var_7) {
      break;
    }

    var_11 = _vectortoyaw(var_10);
    var_12 = _abs(_angleclamp180(var_11 - var_8));

    if(var_12 > var_9) {
      break;
    }

    var_6 = var_1.origin;
  }

  if(common_scripts\utility::_id_562E(1)) {
    var_14 = _id_0547::_id_43F0(var_1.origin, var_1._id_8302, var_1._id_8303 * 1.2, 1);

    foreach(var_16 in var_14) {
      if(isDefined(var_1.thrownimpacts)) {
        var_17 = var_1.thrownimpacts[var_16 getentitynumber()];

        if(isDefined(var_17) && gettime() - var_17 <= 100)
          continue;
      }

      sword_throw_zombie_impact_damage(var_0, var_1, var_16);
    }
  }

  var_1 notify("sword_throw_blocked");
}

sword_throw_damage_impacted_zombies(var_0) {
  var_1 = self;
  var_1 endon("sword_throw_blocked");
  var_1 endon("sword_throw_end");
  var_1 endon("death");

  for(;;) {
    var_1 waittill("touch", var_2);

    if(!_isagent(var_2)) {
      continue;
    }
    if(!isalive(var_2)) {
      continue;
    }
    if(isDefined(var_2._id_000A) && var_2._id_000A == level._id_746E) {
      continue;
    }
    if(var_2 == var_1) {
      continue;
    }
    if(isDefined(var_2.swordthrowstate)) {
      continue;
    }
    sword_throw_zombie_impact_damage(var_0, var_1, var_2);
  }
}

sword_throw_zombie_impact_damage(var_0, var_1, var_2) {
  if(sword_can_stun(var_2) || sword_can_secondary_stun(var_2) || sword_can_secondary_slow(var_2))
    _id_0547::_id_7D1B(_id_0547::create_temp_tackler(var_1), var_2, "close", var_1.swordthrowowner);

  var_2 dodamage(level.swordthrowimpactdamage, var_1.origin, var_0._id_0117, var_0._id_0117, "MOD_MELEE", "zom_dlc3_5_throw_zm");

  if(common_scripts\utility::_id_562E(1) && isalive(var_2)) {
    if(var_2._id_0A4B == "zombie_heavy")
      var_2 thread _id_0567::zombie_heavy_set_grudge(var_0._id_0117);
  }

  if(var_1._id_0A4B == "zombie_exploder")
    var_1 _id_0563::zombie_exploder_attempt_detonate(var_0._id_0117, "zom_dlc3_5_throw_zm");

  var_1 dodamage(level.swordthrowimpactdamage, var_1.origin, var_0._id_0117, var_0._id_0117, "MOD_MELEE", "zom_dlc3_5_throw_zm");

  if(!isDefined(var_1.thrownimpacts))
    var_1.thrownimpacts = [];

  var_1.thrownimpacts[var_2 getentitynumber()] = gettime();
}

sword_throw_handle_zombie_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self;

  if(isDefined(self.swordthrowstate)) {
    if(var_9._id_0A4B == "zombie_exploder")
      var_9 _id_0563::zombie_exploder_attempt_detonate(var_9.swordthrowowner, "zom_dlc3_5_throw_zm");
  }
}

cleanup_ent_on_throw_end(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 waittill("sword_throw_end");
  var_0 delete();
}

sword_throw_animate(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_2 = _randomfloatrange(0.5, 2);
  set_sword_throw_state(0);
  var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("energy_throw_start");
  var_4 = self getanimentrycount(var_3);
  var_5 = randomint(var_4);
  var_6 = solve_yaw_for_throw_anim(var_3, var_5, var_0.ownerinitialangles[1]);
  var_1.angles = (var_1.angles[0], var_6, var_1.angles[2]);
  var_7 = 2 / var_2;
  var_1 scragentsetanimmode("anim deltas");
  var_1 scragentsetorientmode("face angle rel", (var_1.angles[0], var_6, var_1.angles[2]));
  var_1 scragentsetphysicsmode("gravity");
  var_1 scragentsetanimscale(var_7, 1.0);
  var_1 set_sword_throw_state(1);
  var_3 = var_1 maps\mp\agents\_scripted_agent_anim_util::_id_434D("energy_throw_loop");
  var_4 = var_1 getanimentrycount(var_3);
  var_5 = randomint(var_4);
  var_6 = solve_yaw_for_throw_anim(var_3, var_5, var_0.ownerinitialangles[1]);
  var_1 scragentsetorientmode("face angle abs", (var_1.angles[0], var_6, var_1.angles[2]));
  var_8 = 2.0;
  var_9 = _randomfloat(1);
  var_1 maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_3, var_5, var_2, var_9);
  var_1 maps\mp\_utility::waitfortimeornotify(var_8, "sword_throw_blocked");
}

solve_yaw_for_throw_anim(var_0, var_1, var_2) {
  var_3 = self getanimentry(var_0, var_1);
  var_4 = _getmovedelta(var_3, 0, 1);
  var_5 = vectortoangles(var_4);
  return _angleclamp180(var_2 - var_5[1]);
}

sword_throw_interrupt(var_0) {}

sword_can_stun(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = _id_0547::_id_0A51(var_0._id_0A4B);

  if(common_scripts\utility::_id_562E(var_0.noenergyhold))
    return 0;

  return common_scripts\utility::_id_562E(var_1.energyhold);
}

sword_can_secondary_stun(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = _id_0547::_id_0A51(var_0._id_0A4B);

  if(common_scripts\utility::_id_562E(var_0.noenergyholdsecondary))
    return 0;

  return common_scripts\utility::_id_562E(var_1.energyholdsecondary);
}

sword_can_secondary_slow(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = _id_0547::_id_0A51(var_0._id_0A4B);

  if(common_scripts\utility::_id_562E(var_0.noenergyslowsecondary))
    return 0;

  return common_scripts\utility::_id_562E(var_1.energyslowsecondary);
}

sword_can_throw(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = _id_0547::_id_0A51(var_0._id_0A4B);

  if(common_scripts\utility::_id_562E(var_0.notthrowable))
    return 0;

  return common_scripts\utility::_id_562E(var_1.throwable);
}

sword_can_stun_kill(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = _id_0547::_id_0A51(var_0._id_0A4B);

  if(common_scripts\utility::_id_562E(var_0.noenergyholdkill))
    return 0;

  return common_scripts\utility::_id_562E(var_1.energyholdkill);
}

sword_throw_end(var_0) {
  var_1 = self;
  var_1.immunetotackling = undefined;
  var_1 set_sword_throw_state(2);
  var_1 notify("sword_throw_end");

  if(var_1._id_0A4B == "zombie_exploder")
    var_1 _id_0563::zombie_exploder_attempt_detonate(var_0._id_0117, "zom_dlc3_5_throw_zm");

  var_1 dodamage(var_1.health + 1, var_1.origin, var_0._id_0117, var_0._id_0117, "MOD_MELEE", "zom_dlc3_5_throw_zm", "head");
  var_1 scragentsetscripted(0);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "barb_sword_throw");
  var_1 scragentsetanimscale(1.0, 1.0);
  set_sword_throw_state(undefined);
  var_1.swordthrowowner = undefined;
}

sword_add_secondary_stun(var_0) {
  var_1 = self;

  if(!isDefined(var_1._id_0A4B)) {
    return;
  }
  if(common_scripts\utility::_id_562E(1)) {
    var_2 = var_0.lastswordstunplayer;

    if(!isDefined(var_2) || !isPlayer(var_2))
      var_2 = common_scripts\utility::_id_0F82(var_0.activeswordstunplayers);

    if(var_1._id_0A4B == "zombie_heavy" && isDefined(var_2) && isPlayer(var_2))
      var_1 thread _id_0567::zombie_heavy_set_grudge(var_2);
  }

  var_3 = _id_0547::_id_0A51(var_1._id_0A4B);

  if(!isDefined(var_3) || !sword_can_secondary_stun(var_1, var_3) && !sword_can_secondary_slow(var_1, var_3)) {
    return;
  }
  var_4 = var_0 getentitynumber();
  var_1 notify("secondary_stun_begin_" + var_4);

  if(!isDefined(var_1.activesecondarystuns))
    var_1.activesecondarystuns = [];

  if(!isDefined(var_0.outgoingstuns))
    var_0.outgoingstuns = [];

  if(var_1.activesecondarystuns.size == 0) {
    var_1 thread play_shock_fx("zmb_barb_sword_stun_secondary", "J_Spine4", undefined, 1.0, "sword_secondary_stun_shock", "all_secondary_stuns_expired");
    var_1 _id_0378::_id_8D74("dlc3_barbarosa_sword_stun", "stun_on");

    if(sword_can_secondary_stun(var_1, var_3)) {
      var_1 _id_0547::add_zombie_stun("barb_sword_secondary", level);
      var_5 = [var_1, "all_secondary_stuns_expired"];
      var_6 = create_sword_secondary_stun_params(var_5);
      var_1 thread _id_0547::_id_7D1A("barb_sword_stun_secondary", [var_6], undefined, var_5);
    } else if(sword_can_secondary_slow(var_1, var_3))
      var_1 applyswordsecondaryslowdebuff();
  } else {}

  if(!isDefined(var_0.outgoingstuns[var_1 getentitynumber()])) {
    var_0.outgoingstuns[var_1 getentitynumber()] = var_1;
    var_1.activesecondarystuns[var_4] = var_0;
    thread sword_secondary_stun_handle_expire(var_0);
  }
}

sword_secondary_stun_handle_expire(var_0) {
  var_1 = self;
  var_2 = var_0 getentitynumber();
  var_1 endon("death");
  var_1 endon("secondary_stun_begin_" + var_2);
  var_1 endon("secondary_stun_end_" + var_2);
  wait 4;
  var_1 thread sword_secondary_stun_expire(var_0);
}

sword_secondary_stun_expire(var_0) {
  var_1 = self;
  var_2 = var_0 getentitynumber();
  var_3 = _id_0547::_id_0A51(var_1._id_0A4B);
  var_1.activesecondarystuns[var_2] = undefined;
  var_0.outgoingstuns[var_1 getentitynumber()] = undefined;
  var_1 _id_0378::_id_8D74("dlc3_barbarosa_sword_stun", "stun_off");
  var_1 notify("secondary_stun_end_" + var_2);

  if(var_1.activesecondarystuns.size == 0) {
    if(sword_can_secondary_stun(var_1, var_3))
      var_1 _id_0547::remove_zombie_stun("barb_sword_secondary");
    else if(sword_can_secondary_slow(var_1, var_3))
      var_1 removeswordsecondaryslowdebuff();

    var_1 notify("all_secondary_stuns_expired");
  }
}

create_sword_secondary_stun_params(var_0) {
  var_1 = self;
  var_2 = spawnStruct();
  var_2.endon_pairs = var_0;
  return var_2;
}

sword_secondary_stun_run(var_0) {
  var_1 = self;
  var_1 scragentsetscripted(1);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "barb_sword_stun_secondary");
  var_1 _id_0542::set_invalid_melee_pairing_reason("barb_secondary_stun", 1);
  var_1 sword_secondary_stun_intro(var_0);
  var_1 sword_secondary_stun_loop(var_0);
}

sword_secondary_stun_intro(var_0) {
  var_1 = self;
  var_1 endon("all_secondary_stuns_expired");
  var_2 = ["side_stumble_2_left", "side_stumble_2_right", "side_stumble_3_left", "side_stumble_3_right", "pain_stand"];
  var_3 = common_scripts\utility::array_randomize(var_2)[0];
  var_4 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_3);
  var_5 = self getanimentrycount(var_4);
  var_6 = randomint(var_5);
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_4, var_6, 1, "stun_anim");
}

sword_secondary_stun_loop(var_0) {
  var_1 = self;
  var_1 endon("all_secondary_stuns_expired");

  while(var_1.activesecondarystuns.size > 0) {
    var_2 = undefined;
    var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_434D("energy_hold_secondary");
    var_4 = self getanimentrycount(var_3);

    if(self._id_0A4B == "zombie_exploder") {
      if(common_scripts\utility::_id_562E(self._id_392C))
        var_2 = 0;
      else
        var_2 = 1;
    }

    if(isDefined(var_2))
      var_5 = var_2;
    else
      var_5 = randomint(var_4);

    self scragentsetanimmode("anim deltas");
    self scragentsetorientmode("face angle abs", self.angles);
    maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_3, var_5, 1, "stun_anim");
  }
}

sword_secondary_stun_interrupt(var_0) {
  var_1 = self;

  if(var_1.activesecondarystuns.size > 0) {
    var_0.requeued = 1;
    var_1 thread _id_0547::_id_7D1A("barb_sword_stun_secondary", [var_0], undefined, var_0.endon_pairs);
  }
}

sword_secondary_stun_end(var_0) {
  var_1 = self;
  var_1 _id_0542::set_invalid_melee_pairing_reason("barb_sword_stun", 0);
  var_1 scragentsetscripted(0);
  var_1 maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "barb_sword_stun_secondary");
}

sword_secondary_stun_cleanup_outgoing_stuns() {
  var_0 = self;

  if(isDefined(var_0.outgoingstuns)) {
    var_1 = var_0.outgoingstuns;

    foreach(var_3 in var_1)
    var_3 thread sword_secondary_stun_expire(var_0);
  }
}

sword_secondary_stun_handle_zombie_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self;
  var_9 sword_secondary_stun_cleanup_outgoing_stuns();

  if(isDefined(var_9.activesecondarystuns)) {
    var_10 = var_9.activesecondarystuns;

    foreach(var_12 in var_10)
    var_9 thread sword_secondary_stun_expire(var_12);
  }
}

applyswordsecondaryslowdebuff() {
  var_0 = self;
  var_0 _id_054D::_id_099B("secondary_slow", getswordsecondaryslowdebuff());
}

removeswordsecondaryslowdebuff() {
  var_0 = self;
  var_0 _id_054D::removebuffbyname("secondary_slow");
}

getswordsecondaryslowdebuff() {
  var_0 = self;
  var_1 = var_0 _id_054D::_id_443F("secondary_slow");

  if(!isDefined(var_1))
    var_1 = var_0 spawnswordsecondaryslowdebuff();

  return var_1;
}

spawnswordsecondaryslowdebuff() {
  var_0 = self;
  var_1 = spawnStruct();
  var_1._id_1CF0 = ::cleanupswordsecondaryslowdebuff;
  var_1._id_90F0 = 0.3;
  var_0 notify("speed_debuffs_changed");
  return var_1;
}

cleanupswordsecondaryslowdebuff(var_0) {
  var_1 = self;
  var_1 notify("speed_debuffs_changed");
}

sword_on_heavy_melee_kill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self;
  var_10 = var_1;

  if(common_scripts\utility::_id_562E(1)) {
    var_11 = 0;
    var_12 = 0;
    var_13 = 0;

    if(common_scripts\utility::_id_562E(1)) {
      var_12 = var_12 | common_scripts\utility::_id_562E(var_10.swordempower._id_08BE);
      var_11 = 1;
    }

    if(common_scripts\utility::_id_562E(1)) {
      var_14 = isDefined(get_geist_bomb_for_position(var_10.origin, var_10));
      var_12 = var_12 | var_14;
      var_13 = var_14;
      var_11 = 1;
    }

    if(!var_11 || var_12) {
      var_15 = var_10 thread sword_try_grant_armor();

      if(var_15 && common_scripts\utility::_id_562E(1) && !var_13)
        var_10 sword_empower_off();
    }
  }

  var_10 thread sword_handle_power_investment(var_9);
}

sword_try_grant_armor() {
  var_0 = self;

  if(var_0.health < var_0.maxhealth)
    var_0 notify("immediateHealthRegen");

  if(var_0 _id_0547::_id_73E9() < var_0 _id_0547::playergetmaxarmorcount()) {
    var_0 thread sword_grant_armor_internal();
    return 1;
  }

  return 0;
}

sword_grant_armor_internal() {
  var_0 = self;
  var_0 endon("disconnect");
  _playfxontagforclients(common_scripts\utility::_id_44F5("zmb_barb_victim_drain_armor"), var_0, "J_Spine4", var_0);
  var_0 _id_0378::_id_8D74("zmb_sword_finisher_effects");
  wait 0.2;
  var_0 _id_0547::_id_73AC(1);
}

sword_handle_empower() {
  var_0 = self;
  var_0.swordempower = spawnStruct();
  var_0.swordempower.empowerkills = 0;

  if(common_scripts\utility::_id_562E(0))
    thread sword_empower_watch_player_meter();

  thread sword_empower_watch_last_stand();
  thread sword_empower_watch_game_end();
}

sword_empower_watch_player_meter() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0.swordempower endon("sword_empower_cleanup");
  var_0.swordempower._id_08BE = 0;

  for(;;) {
    var_1 = var_0 _meth_85BB() >= 1.0;

    if(var_1) {
      if(!common_scripts\utility::_id_562E(var_0.swordempower._id_08BE)) {
        var_0 thread sword_empower_on();
        var_0.swordempower._id_08BE = 1;
      }
    } else if(common_scripts\utility::_id_562E(var_0.swordempower._id_08BE)) {
      var_0 thread sword_empower_off();
      var_0.swordempower._id_08BE = 0;
    }

    waitframe();
  }
}

sword_empower_watch_last_stand() {
  var_0 = self;
  var_0.swordempower endon("sword_empower_cleanup");
  var_0 endon("disconnect");

  for(;;) {
    var_0 common_scripts\utility::_id_A70A("begin_last_stand", "enter_last_stand", "death");
    var_0 sword_empower_off();
  }
}

sword_empower_watch_game_end() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0.swordempower endon("sword_empower_cleanup");

  for(;;) {
    level waittill("game_ended");
    var_0 sword_empower_off();
  }
}

sword_empower_handle_zombie_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  var_9 = var_1;
  var_9.swordempower.empowerkills++;

  if(!common_scripts\utility::_id_562E(var_9.swordempower._id_08BE) && var_9.swordempower.empowerkills >= 30)
    var_9 thread sword_empower_on();
}

sword_empower_on() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 endon("sword_empower_off");
  var_1 = 0;
  var_0.swordempower._id_08BE = 1;

  for(;;) {
    var_2 = var_0 getcurrentweapon();
    var_3 = issubstr(var_2, "zom_dlc3_5_zm");

    if(var_3) {
      if(!var_1)
        thread sword_empower_fx_on();
    } else if(var_1)
      thread sword_empower_fx_off();

    var_1 = var_3;
    var_0 common_scripts\utility::_id_A70A("weapon_given", "weapon_taken", "zombie_player_spawn_finished", "melee_weapon_change", "weapon_switch_started");
    waitframe();

    while(var_0 isswitchingweapon())
      waitframe();
  }
}

sword_empower_off() {
  var_0 = self;

  if(!isDefined(var_0.swordempower) || !common_scripts\utility::_id_562E(var_0.swordempower._id_08BE)) {
    return;
  }
  var_0.swordempower._id_08BE = 0;
  var_0.swordempower.empowerkills = 0;
  var_0 notify("sword_empower_off");
  thread sword_empower_fx_off();
}

sword_cleanup_empower() {
  var_0 = self;
  var_0 thread sword_empower_off();
  var_0.swordempower notify("sword_empower_cleanup");
  var_0.swordempower = undefined;
}

sword_empower_fx_on() {
  var_0 = self;
  var_1 = common_scripts\utility::_id_44F5("zmb_barb_sword_activate");
  var_0.swordempower._id_35A6 = _spawnlinkedfxforclient(var_1, var_0, "TAG_WW_MELEE_FX", var_0, 1);
  var_0 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_0.swordempower._id_35A6);
  setfxkillondelete(var_0.swordempower._id_35A6, 1);
  _triggerfx(var_0.swordempower._id_35A6);
  var_0.swordempower._id_35A6 _id_0378::_id_8D74("dlc3_barbarosa_sword_empowered");
  var_2 = common_scripts\utility::_id_44F5("zmb_barb_sword_activate_wv");
  var_0.swordempower.wv_effects = _spawnlinkedfx(var_2, var_0, "TAG_WW_MELEE_FX", 1);
  var_0 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_0.swordempower.wv_effects);
  setfxkillondelete(var_0.swordempower.wv_effects, 1);
  _triggerfx(var_0.swordempower.wv_effects);
  var_0.swordempower.wv_effects _meth_8006(var_0);
}

sword_empower_fx_off() {
  var_0 = self;

  if(isDefined(var_0.swordempower._id_35A6))
    var_0.swordempower._id_35A6 delete();

  if(isDefined(var_0.swordempower.wv_effects))
    var_0.swordempower.wv_effects delete();
}

sword_handle_power_investment(var_0) {
  self endon("death");
  self endon("disconnect");

  if(!sword_player_can_invest(var_0)) {
    return;
  }
  thread sword_offer_power_investment(var_0);
  var_1 = common_scripts\utility::_id_562E(sword_wait_investment_choice(var_0));

  if(var_1)
    thread sword_activate_investment(var_0);

  thread sword_revoke_power_investment_offer();
}

sword_offer_power_investment(var_0) {
  var_1 = self;
  var_1.swordinvestment.offer = 1;
  thread sword_investment_handle_corpse_transition(var_0);

  if(isDefined(var_1.priminggeistbomb)) {
    var_1.priminggeistbomb geist_bomb_end_priming();
    var_1.priminggeistbomb geist_bomb_disarmed();
  }

  var_1 _id_0547::force_use_hint_on(&"ZOMBIE_WEAPONDLC3_INVEST_PROMPT", "sword_invest");
}

sword_revoke_power_investment_offer() {
  var_0 = self;
  var_0 _id_0547::force_use_hint_off("sword_invest");
  var_0.swordinvestment.offer = 0;
  var_0.swordinvestment._id_2670 = undefined;
  var_0.swordinvestment.no_corpse = undefined;
  var_0.swordinvestment notify("corpse_update");
}

sword_investment_handle_corpse_transition(var_0) {
  self endon("disconnect");
  var_1 = var_0 common_scripts\utility::_id_A70F(0.5, var_0, "body_spawned");

  if(_isstring(var_1[0]) && var_1[0] == "timeout") {
    self.swordinvestment.no_corpse = 1;
    self.swordinvestment notify("corpse_update");
    return;
  }

  var_2 = var_1[1];
  var_3 = var_1[0];

  if(var_1.size > 2)
    var_4 = common_scripts\utility::_id_0FA3(var_1, 2, var_1.size);
  else
    var_4 = [];

  self.swordinvestment._id_2670 = var_4[0];
  self.swordinvestment._id_2670 waittill("entitydeleted");
  self.swordinvestment._id_2670 = undefined;
  self.swordinvestment.no_corpse = 1;
  self.swordinvestment notify("corpse_update");
}

sword_corpse_wait_success() {
  var_0 = self;
  var_0 endon("disconnect");

  if(!isDefined(var_0.swordinvestment._id_2670)) {
    if(common_scripts\utility::_id_562E(var_0.swordinvestment.no_corpse))
      return 0;

    var_0.swordinvestment waittill("corpse_update");

    if(!isDefined(var_0.swordinvestment._id_2670))
      return 0;
  }

  return 1;
}

sword_wait_investment_choice(var_0) {
  self endon("investment_expire");
  self endon("enter_last_stand");
  self endon("begin_last_stand");
  self endon("disconnect");
  childthread sword_notify_on_heavy_melee_end();

  while(!self usebuttonpressed())
    waitframe();

  return 1;
}

sword_notify_on_heavy_melee_end() {
  while(self _meth_8661())
    waitframe();

  self notify("investment_expire");
}

sword_player_can_invest(var_0) {
  if(isDefined(var_0) && _id_0547::_id_5565(var_0._id_2A9D, "scripted_soul_eat"))
    return 0;

  if(!isDefined(self.swordempower) || !common_scripts\utility::_id_562E(self.swordempower._id_08BE))
    return 0;

  if(common_scripts\utility::_id_562E(0)) {
    if(self _meth_85BA("active"))
      return 0;

    if(self _meth_85BB() < 1.0)
      return 0;
  }

  if(common_scripts\utility::_id_562E(1)) {
    if(_id_0547::_id_73E9() < _id_0547::playergetmaxarmorcount())
      return 0;
  }

  if(common_scripts\utility::_id_562E(1)) {
    if(_id_0547::playergetmaxarmorcount() == 0)
      return 0;
  }

  return 1;
}

sword_activate_investment(var_0) {
  var_1 = self;

  if(common_scripts\utility::_id_562E(0))
    var_1 _id_0533::_id_0F37(-1.0, 1, 1);

  if(common_scripts\utility::_id_562E(0))
    var_1 _id_0547::_id_7454(0);

  if(common_scripts\utility::_id_562E(1)) {
    var_1 _id_0547::playersetmaxarmorcount(var_1 _id_0547::playergetmaxarmorcount() - 1);
    _playfxontagforclients(common_scripts\utility::_id_44F5("zmb_barb_victim_drain_armor"), var_1, "J_Spine4", var_1);
  }

  if(1)
    var_1 sword_empower_off();

  var_2 = geist_bomb_create(var_0, var_1);
}

geist_bomb_create(var_0, var_1) {
  var_2 = spawnStruct();

  if(!isDefined(var_1.geistbombs))
    var_1.geistbombs = [];

  var_1.geistbombs = common_scripts\utility::_id_0F6F(var_1.geistbombs, var_2);
  var_2.player = var_1;
  var_2._id_8203 = spawn("script_model", var_1.origin);
  var_2._id_8203 setModel("tag_origin");

  if(isDefined(var_0)) {
    if(_isagent(var_0))
      var_2._id_AB4D = var_0;
  }

  var_2 thread geist_bomb_think();
  return var_2;
}

geist_bomb_think() {
  var_0 = self;
  var_1 = var_0.player;
  var_0 endon("geist_bomb_cleanup");
  thread geist_bomb_handle_death_disconnect();
  thread geist_bomb_handle_initial_positioning();
  thread geist_bomb_creation_zombie_fx();
  thread geist_bomb_handle_vesting();

  if(common_scripts\utility::_id_562E(1))
    thread geist_bomb_handle_revive();

  thread geist_bomb_handle_withdrawal();
}

geist_bomb_handle_initial_positioning() {
  var_0 = self;
  var_1 = var_0.player;

  if(isDefined(var_1.swordinvestment._id_2670))
    var_0._id_8203.origin = var_1.swordinvestment._id_2670.origin + (0, 0, 48);
  else
    var_0._id_8203.origin = var_1.origin + anglesToForward(var_1.angles) * 36 + (0, 0, 48);

  var_0._id_487B = _getgroundposition(var_0._id_8203.origin, 24, 48, 0, 0);

  if(!isDefined(var_0._id_487B))
    var_0._id_487B = var_0._id_8203.origin - (0, 0, 24);
}

geist_bomb_creation_zombie_fx() {
  var_0 = self;
  var_1 = var_0.player;
  var_1 endon("disconnect");

  if(!var_1 sword_corpse_wait_success()) {
    return;
  }
  var_2 = var_1.swordinvestment._id_2670;
  var_0.creation_fx_beam = _func_382("zmb_geistkraft_reg_beam_med", var_2, "j_neck", var_0._id_8203, "tag_origin");
  var_1 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_0.creation_fx_beam);
  _playfxontag(common_scripts\utility::_id_44F5("zmb_barb_victim_geist_drain"), var_2, "j_neck");
  common_scripts\utility::_id_A70D(10, var_1.swordinvestment, "corpse_update", var_0, "geist_bomb_cleanup");
  var_0.creation_fx_beam delete();
}

geist_bomb_handle_death_disconnect() {
  var_0 = self;
  var_1 = var_0.player;
  var_0 endon("geist_bomb_cleanup");
  var_1 common_scripts\utility::_id_A70A("death", "disconnect", "sword_lost");
  var_0 geist_bomb_cleanup();
}

geist_bomb_handle_vesting() {
  var_0 = self;
  var_1 = var_0.player;
  var_1 endon("disconnect");
  var_0 endon("geist_bomb_cleanup");
  var_0 thread geist_bomb_run_vesting();
  var_0 geist_bomb_wait_for_vesting();
  childthread geist_bomb_ready_vfx();
}

geist_bomb_handle_withdrawal() {
  var_0 = self;
  var_1 = var_0.player;
  var_1 endon("disconnect");
  var_0 endon("geist_bomb_cleanup");
  var_0 geist_bomb_wait_for_vesting();
}

geist_bomb_withdraw_power() {
  var_0 = self;
  var_1 = var_0.player;

  if(common_scripts\utility::_id_562E(1))
    var_1 _id_0547::_id_7454(var_1 _id_0547::playergetmaxarmorcount());

  if(common_scripts\utility::_id_562E(0))
    var_1 _id_0533::_id_0F37(1.0, 1, 1);

  geist_bomb_cleanup();
}

geist_bomb_handle_revive() {
  var_0 = self;
  var_1 = var_0.player;
  var_1 endon("disconnect");
  var_0 endon("geist_bomb_cleanup");
  var_0 geist_bomb_wait_for_vesting();

  if(!isDefined(var_1.geist_bomb_revives))
    var_1.geist_bomb_revives = [];

  var_0.revive_enabled = 1;
  var_1.geist_bomb_revives = common_scripts\utility::_id_0F6F(var_1.geist_bomb_revives, var_0);

  if(var_1.geist_bomb_revives.size == 1)
    var_1.mapreviveenabled = 1;

  for(;;) {
    if(!_id_0547::_id_577E(var_1))
      var_1 waittill("enter_last_stand");

    var_0 geist_bomb_attempt_revive();
  }
}

geist_bomb_cleanup_revive() {
  var_0 = self;
  var_1 = var_0.player;

  if(common_scripts\utility::_id_562E(var_0.revive_enabled))
    var_1.geist_bomb_revives = common_scripts\utility::_id_0F93(var_1.geist_bomb_revives, var_0);

  if(var_1.geist_bomb_revives.size == 0)
    var_1.mapreviveenabled = undefined;
}

geist_bomb_attempt_revive() {
  var_0 = self;
  var_1 = var_0.player;
  var_0.within_revive_distance = 0;

  while(_id_0547::_id_577E(var_1)) {
    var_2 = 0;

    if(_distance2d(var_1.origin, var_0._id_8203.origin) > 75)
      var_2 = 1;

    if(_abs(var_1.origin[2] - var_0._id_487B[2]) > 74)
      var_2 = 1;

    if(!var_2) {
      var_3 = _func_38E(var_1.origin, var_0._id_8203.origin);

      if(var_3 > 75)
        var_2 = 1;
    }

    if(var_2)
      geist_bomb_revive_too_far();
    else
      geist_bomb_revive_within_range();

    wait 0.5;
  }
}

geist_bomb_revive_too_far() {
  var_0 = self;

  if(common_scripts\utility::_id_562E(var_0.within_revive_distance))
    var_0 notify("bomb_too_far_away");

  var_0.within_revive_distance = 0;
}

geist_bomb_revive_within_range() {
  var_0 = self;
  var_1 = var_0.player;

  if(!common_scripts\utility::_id_562E(var_0.within_revive_distance)) {
    thread geist_bomb_revive_fx();

    if(common_scripts\utility::_id_562E(0))
      thread geist_bomb_revive_timer();
  }

  var_0.within_revive_distance = 1;
}

geist_bomb_revive_timer() {
  var_0 = self;
  var_1 = var_0.player;
  var_1 endon("revive");
  var_1 endon("death");
  var_1 endon("disconnect");
  var_0 endon("bomb_too_far_away");
  var_0 endon("geist_bomb_cleanup");
  var_2 = 0;
  var_3 = 60;

  while(var_2 < var_3) {
    var_4 = 0;

    if(common_scripts\utility::_id_562E(var_1._id_172C))
      var_4 = 1;

    if(var_4)
      var_2 = 0;
    else
      var_2++;

    waitframe();
  }

  geist_bomb_revive();
}

geist_bomb_revive() {
  var_0 = self;
  var_1 = var_0.player;
  var_1 _id_0553::_id_53E2(var_1);
  thread geist_bomb_withdraw_power();
}

geist_bomb_revive_last_chance() {
  var_0 = self;

  if(isDefined(var_0.geist_bomb_revives) && var_0.geist_bomb_revives.size > 0) {
    foreach(var_2 in var_0.geist_bomb_revives) {
      if(common_scripts\utility::_id_562E(var_2.within_revive_distance)) {
        var_2 geist_bomb_revive();
        waitframe();
        return;
      }
    }
  }
}

get_geist_bomb_for_position(var_0, var_1) {
  if(isDefined(var_1.geistbombs)) {
    foreach(var_3 in var_1.geist_bomb_revives) {
      if(_distance2d(var_0, var_3._id_8203.origin) < 75) {
        if(_abs(var_1.origin[2] - var_3._id_487B[2]) <= 74)
          return var_3;
      }
    }
  }

  return undefined;
}

geist_bomb_revive_fx() {
  var_0 = self;
  var_1 = var_0.player;
  var_1 endon("disconnect");
  var_2 = _func_382("zmb_giestbomb_revive_beam", var_0._id_8203, "tag_origin", var_0.player, "tag_origin");
  var_1 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_2);
  _id_0378::_id_8D74("dlc3_giest_bomb_revive", var_1, var_2);
  common_scripts\utility::_id_A70C(var_0, "bomb_too_far_away", var_0, "geist_bomb_cleanup", var_1, "revive", var_1, "death");
  var_2 delete();
}

geist_bomb_wait_for_vesting() {
  var_0 = self;

  if(!common_scripts\utility::_id_562E(var_0.vested))
    var_0 waittill("geist_bomb_vested");
}

geist_bomb_run_vesting() {
  var_0 = self;
  var_1 = var_0.player;
  var_0 endon("geist_bomb_cleanup");
  var_1 endon("disconnect");
  var_2 = 0;
  var_3 = 0;

  if(0 || 0) {
    while(!var_2) {
      level waittill("zombie_wave_started");

      if(!var_3) {
        var_0.starting_round = level.currentwave;
        var_0.starting_objective_count = level.objectivescompleted;
        var_3 = 1;
      }

      level waittill("zombie_wave_ended");
      var_4 = level.currentwave - var_0.starting_round;
      var_5 = level.objectivescompleted - var_0.starting_objective_count;

      if(var_4 > 0 && var_5 > 0)
        var_2 = 1;
    }
  } else
    var_2 = 1;

  var_0 notify("geist_bomb_vested");
  var_0.vested = 1;
}

geist_bomb_ready_vfx() {
  var_0 = self;
  var_1 = var_0.player;
  var_0 endon("geist_bomb_cleanup");
  var_0.radiusvfx = _spawnlinkedfxforclient(common_scripts\utility::_id_44F5("zmb_giestbomb_radius"), var_0._id_8203, "tag_origin", var_1);
  _id_0378::_id_8D74("dlc3_geist_bomb_activate", var_0);

  for(;;) {
    _playfxontag(common_scripts\utility::_id_44F5("zmb_barb_geist_bomb_ready"), var_0._id_8203, "tag_origin");
    _triggerfx(var_0.radiusvfx);
    wait 3;
  }
}

geist_bomb_ready_vfx_cleanup() {
  var_0 = self;

  if(isDefined(var_0.radiusvfx))
    var_0.radiusvfx delete();
}

geist_bomb_cleanup() {
  var_0 = self;
  var_1 = var_0.player;

  if(!isDefined(var_0)) {
    return;
  }
  if(!common_scripts\utility::_id_562E(var_0.cleaned)) {
    if(isDefined(var_1) && isPlayer(var_1)) {
      var_1.geistbombs = common_scripts\utility::_id_0F93(var_1.geistbombs, var_0);
      var_0 geist_bomb_cleanup_revive();

      if(common_scripts\utility::_id_562E(1)) {
        var_1 _id_0547::playersetmaxarmorcount(var_1 _id_0547::playergetmaxarmorcount() + 1);

        if(isalive(var_1))
          _playfxontagforclients(common_scripts\utility::_id_44F5("zmb_barb_victim_drain_armor"), var_1, "J_Spine4", var_1);
      }
    }

    var_0 geist_bomb_ready_vfx_cleanup();
    var_0._id_8203 delete();
    var_0.cleaned = 1;
  }

  var_0 notify("geist_bomb_cleanup");
}

sword_geist_bomb_detonate_think() {
  var_0 = self;
  var_0 endon("sword_lost");
  var_0 endon("disconnect");
  var_0.priminggeistbombtime = 0;
  var_1 = 0.2;

  for(;;) {
    wait(var_1);
    var_2 = sword_geist_bomb_detonate_pick_bomb();

    if(isDefined(var_0.priminggeistbomb) && !_id_0547::_id_5565(var_2, var_0.priminggeistbomb)) {
      var_0.priminggeistbombtime = 0;
      var_0.priminggeistbomb geist_bomb_end_priming();
      var_0.priminggeistbomb geist_bomb_disarmed();
      var_0.priminggeistbomb = undefined;
    }

    if(!isDefined(var_2)) {
      continue;
    }
    if(isDefined(var_0.priminggeistbomb) && _id_0547::_id_5565(var_2, var_0.priminggeistbomb)) {
      var_0.priminggeistbombtime = var_0.priminggeistbombtime + var_1;

      if(!common_scripts\utility::_id_562E(var_0.priminggeistbomb.is_armed) && var_0.priminggeistbombtime > 1)
        var_0.priminggeistbomb thread geist_bomb_armed();

      continue;
    }

    var_0.priminggeistbomb = var_2;
    var_0.priminggeistbomb thread geist_bomb_start_priming();
  }
}

sword_geist_bomb_detonate_pick_bomb() {
  var_0 = self;

  if(!isDefined(var_0.swordempower) || !common_scripts\utility::_id_562E(var_0.swordempower._id_08BE))
    return undefined;

  if(!isDefined(var_0.geistbombs) || var_0.geistbombs.size == 0)
    return undefined;

  if(isDefined(var_0.swordinvestment) && common_scripts\utility::_id_562E(var_0.swordinvestment.offer))
    return undefined;

  if(var_0 getstance() != "stand")
    return undefined;

  if(!var_0 adsbuttonpressed(0))
    return undefined;

  if(!issubstr(var_0 getcurrentprimaryweapon(), "zom_dlc3_5_zm"))
    return undefined;

  var_1 = undefined;
  var_2 = 0;
  var_3 = _cos(5);
  var_4 = anglesToForward(var_0 _meth_8566());

  foreach(var_6 in var_0.geistbombs) {
    if(common_scripts\utility::_id_562E(var_6.detonating)) {
      continue;
    }
    var_7 = var_6._id_8203.origin - var_0 getEye();
    var_8 = vectordot(vectorNormalize(var_7), var_4);

    if(var_8 >= var_3 && var_8 > var_2) {
      var_2 = var_8;
      var_1 = var_6;
    }
  }

  return var_1;
}

geist_bomb_start_priming() {
  var_0 = self;
  var_0 endon("geist_bomb_cleanup");
  var_0 endon("geist_bomb_end_priming");
  _id_0378::_id_8D74("dlc3_giest_bomb_arm", var_0);

  for(;;) {
    _playfxontag(common_scripts\utility::_id_44F5("zmb_giestbomb_priming"), var_0._id_8203, "tag_origin");
    wait 2.5;
  }
}

geist_bomb_end_priming() {
  var_0 = self;
  var_0 notify("geist_bomb_end_priming");
}

geist_bomb_armed() {
  var_0 = self;
  var_0 endon("geist_bomb_cleanup");
  var_0 endon("geist_bomb_disarmed");
  var_1 = var_0.player;
  var_0.is_armed = 1;
  var_1 _id_0547::force_use_hint_on(&"ZOMBIE_WEAPONDLC3_DETONATE_PROMPT", "sword_detonate");
  var_2 = 0;
  var_3 = 0.1;

  for(;;) {
    wait(var_3);

    if(var_1 usebuttonpressed()) {
      var_2 = var_2 + var_3;

      if(var_2 > 1) {
        thread geist_bomb_detonate();
        thread geist_bomb_end_priming();
        var_1 thread sword_empower_off();
        thread geist_bomb_disarmed();
      }

      continue;
    }

    var_2 = 0;
  }
}

geist_bomb_disarmed() {
  var_0 = self;
  var_1 = var_0.player;

  if(common_scripts\utility::_id_562E(var_0.is_armed)) {
    var_0.is_armed = undefined;
    var_1 _id_0547::force_use_hint_off("sword_detonate");
    var_0 notify("geist_bomb_disarmed");
  }
}

geist_bomb_detonate() {
  var_0 = self;
  var_1 = var_0.player;
  var_2 = anglesToForward(var_1.angles);
  var_3 = var_2 * -12 + (0, 0, -1.5);
  var_4 = _spawnfx(common_scripts\utility::_id_44F5("zmb_giestbomb_detonation"), var_0._id_8203.origin + var_3, var_2, (0, 0, 1));
  _triggerfx(var_4);
  _id_0378::_id_8D74("dlc3_geist_bomb_detonate", var_0);
  var_0.detonating = 1;
  thread geist_bomb_detonate_kill_radius();
  common_scripts\utility::_id_A70D(10, var_0, "geist_bomb_cleanup");
  var_4 delete();
  var_0 notify("geist_bomb_detonate_end");
  var_0.kill_trigger delete();
  var_0 thread geist_bomb_cleanup();
}

geist_bomb_detonate_kill_radius() {
  var_0 = self;
  var_1 = var_0.player;
  var_0 endon("geist_bomb_detonate_end");
  var_1 endon("disconnect");

  if(!isDefined(level.geistbomblastid))
    level.geistbomblastid = 0;

  var_2 = level.geistbomblastid;
  level.geistbomblastid++;
  var_3 = 720;
  var_0.kill_trigger = spawn("trigger_radius", var_0._id_8203.origin - (0, 0, var_3 * 0.5), 0, 360, var_3);

  for(;;) {
    var_0.kill_trigger waittill("trigger", var_4);

    if(!isDefined(var_4)) {
      continue;
    }
    if(!_isagent(var_4)) {
      continue;
    }
    if(!isalive(var_4)) {
      continue;
    }
    if(isDefined(var_4._id_000A) && var_4._id_000A == level._id_746E) {
      continue;
    }
    if(!isDefined(var_4._id_0A4B)) {
      continue;
    }
    var_5 = _id_0547::_id_0A51(var_4._id_0A4B);

    if(!isDefined(var_5)) {
      continue;
    }
    var_6 = var_4.bombsabotagefunc;

    if(!isDefined(var_6))
      var_6 = var_5.bombsabotagefunc;

    if(isDefined(var_6)) {
      if(!isDefined(var_4.bombsabotages) || !common_scripts\utility::_id_562E(var_4.bombsabotages[var_2])) {
        var_4 thread[[var_6]](var_1, "zom_dlc3_5_bomb_zm", "MOD_MELEE");
        var_4.bombsabotages[var_2] = 1;
      }
    }

    if(sword_can_stun(var_4, var_5)) {
      var_4 dodamage(var_4.maxhealth + 10, var_0._id_8203.origin, var_1, var_1, "MOD_ENERGY", "zom_dlc3_5_bomb_zm");
      wait 0.25;
    }
  }
}

sword_delivery_init() {
  var_0 = getEntArray("circle_point_off", "targetname");
  var_1 = getEntArray("circle_point_on", "targetname");
  var_2 = common_scripts\utility::_id_46B5("circle_center", "targetname");

  if(!isDefined(var_0) || isDefined(var_0) && var_0.size <= 0) {
    var_0 = common_scripts\utility::_id_46B7("circle_point_struct", "targetname");
    var_1 = var_0;
  }

  var_3 = 1;
  level.sworddelivery = spawnStruct();
  level.sworddelivery._id_7546 = [];
  level.sworddelivery._id_206B = var_2;

  if(!isDefined(level.sworddelivery._id_206B))
    var_3 = 0;

  foreach(var_5 in var_1) {
    var_6 = var_5.setmovespeedscale;

    if(!isDefined(var_6)) {
      var_3 = 0;
      continue;
    }

    if(isDefined(level.sworddelivery._id_7546[var_6]))
      var_3 = 0;

    var_8 = spawnStruct();
    level.sworddelivery._id_7546[var_6] = var_8;
    var_8.onent = var_5;
    var_8.origin = var_5.origin;
    var_8._id_00D4 = var_5.setmovespeedscale;
  }

  foreach(var_5 in var_0) {
    var_6 = var_5.setmovespeedscale;

    if(!isDefined(var_6)) {
      var_3 = 0;
      continue;
    }

    var_8 = level.sworddelivery._id_7546[var_6];

    if(!isDefined(var_8)) {
      var_3 = 0;
      continue;
    }

    var_8.offent = var_5;
  }

  var_12 = [];

  for(var_6 = 0; var_6 < 7; var_6++) {
    var_8 = level.sworddelivery._id_7546[var_6];

    if(!isDefined(var_8)) {
      var_12[var_6] = 1;
      var_3 = 0;
      continue;
    }

    if(isDefined(var_8.onent) && isDefined(var_8.offent)) {
      if(distance(var_8.onent.origin, var_8.offent.origin) > 36)
        var_3 = 0;
    }
  }

  if(var_12.size > 0)
    var_3 = 0;

  if(common_scripts\utility::_id_562E(level.sworddeliveryoff)) {
    foreach(var_8 in level.sworddelivery._id_7546) {
      if(isDefined(var_8.onent))
        var_8.onent delete();

      if(isDefined(var_8.offent))
        var_8.offent delete();
    }

    level.sworddelivery = undefined;
    return;
  }

  if(var_3) {
    sword_delivery_position_checking();
    thread maps\mp\_utility::_id_6F74(::sword_delivery_per_player);
  }
}

sword_delivery_position_checking() {
  foreach(var_1 in level.sworddelivery._id_7546)
  var_1.dist2d = _distance2d(var_1.origin, level.sworddelivery._id_206B.origin);

  var_3 = common_scripts\utility::_id_7897(level.sworddelivery._id_7546, ::delivery_point_sort_from_center);
  var_4 = common_scripts\utility::_id_0FA3(var_3, 0, 3);
  var_5 = 0;

  foreach(var_1 in var_4)
  var_5 = var_5 + var_1.dist2d;

  level.sworddelivery.innerradius = var_5 / 3;
  var_8 = common_scripts\utility::_id_0FA3(var_3, 3, 7);
  var_5 = 0;

  foreach(var_1 in var_8)
  var_5 = var_5 + var_1.dist2d;

  level.sworddelivery.outerradius = var_5 / 4;
}

delivery_point_sort_from_center(var_0, var_1) {
  return var_0.dist2d <= var_1.dist2d;
}

sword_delivery_per_player() {
  var_0 = self;
  var_0 endon("disconnect");
  var_1 = 0;

  if(_isonlinegame() && var_0 getplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "hasCompletedEESequence"))
    var_1 = 1;

  if(!var_1) {
    foreach(var_3 in level.sworddelivery._id_7546) {
      if(isDefined(var_3.offent) && var_3.offent.targetname != "circle_point_struct")
        var_3.offent _meth_8006(var_0);

      if(isDefined(var_3.onent) && var_3.onent.targetname != "circle_point_struct")
        var_3.onent _meth_8006(var_0);
    }

    return;
  }

  for(;;) {
    var_0.sworddeliverypointsactive = [];

    foreach(var_3 in level.sworddelivery._id_7546) {
      if(isDefined(var_3.offent) && var_3.offent.targetname != "circle_point_struct")
        var_3.offent showtoplayer(var_0);

      if(isDefined(var_3.onent) && var_3.onent.targetname != "circle_point_struct")
        var_3.onent _meth_8006(var_0);

      var_0 thread sword_delivery_point_watch_buy(var_3);
    }

    var_0 sword_delivery_wait_until_activation();
    var_0 sword_delivery_handle_revive();
    var_0 sword_delivery_wait_until_abandon_sword();
  }
}

sword_delivery_wait_until_abandon_sword() {
  var_0 = self;

  for(;;) {
    var_0 waittill("sword_lost");

    if(isalive(var_0)) {
      break;
    } else {
      var_0 waittill("zombie_player_spawn_finished");
      waitframe();

      if(!var_0 has_sword()) {
        break;
      }
    }
  }
}

sword_delivery_point_watch_buy(var_0) {
  var_1 = self;
  var_1 endon("disconnect");

  for(;;) {
    var_1 waittill("money_share_success");
    var_2 = 7 * _id_0544::_id_467D();
    var_3 = _id_0544::_id_467F(var_1);

    if(var_3 < var_2) {
      continue;
    }
    var_4 = _id_0544::getsharedmoneypickupsbyplayer(var_1);
    var_5 = 0;
    var_6 = [];

    foreach(var_11, var_8 in var_4) {
      var_9 = 48;

      if(isDefined(var_0.onent.scriptmodelplayanim))
        var_9 = var_0.onent.scriptmodelplayanim;

      if(isDefined(var_0.offent.scriptmodelplayanim))
        var_9 = var_0.offent.scriptmodelplayanim;

      if(distance(var_0.origin, var_8.origin) > var_9) {
        continue;
      }
      var_10 = var_8 _id_0544::getsharedmoneyinpickupbyplayer(var_1);

      if(var_10 > 0) {
        var_6[var_11] = var_10;
        var_5 = var_5 + var_10;

        if(var_5 >= var_2) {
          break;
        }
      }
    }

    if(var_5 < var_2) {
      continue;
    }
    var_12 = 1;

    foreach(var_11, var_14 in var_6)
    var_12 = var_12 &var_4[var_11] _id_0544::sharemoneyremoveamountbyplayer(var_1, var_14);

    break;
  }

  var_1 sword_delivery_point_on_purchase(var_0);
}

sword_delivery_wait_until_activation() {
  var_0 = self;

  while(var_0.sworddeliverypointsactive.size < 7)
    var_0 waittill("sword_delivery_point_activated");
}

sword_delivery_handle_revive() {
  var_0 = self;
  var_1 = "zmb_delivery_radius_128";

  if(common_scripts\utility::_id_562E(level.sworddelivery_uselargeradius))
    var_1 = "zmb_delivery_radius_256";

  var_2 = _spawnfxforclient(common_scripts\utility::_id_44F5(var_1), level.sworddelivery._id_206B.origin, var_0, anglesToForward(level.sworddelivery._id_206B.angles), anglestoup(level.sworddelivery._id_206B.angles));
  _triggerfx(var_2);
  var_0 maps\mp\gametypes\_playerlogic::deleteentonplayerdisconnect(var_2);
  var_0.mapreviveenabled = 1;
  var_3 = var_0 sword_delivery_revive_wait_for_position();
  var_0 thread sword_delivery_revive();

  if(isDefined(var_2))
    var_2 delete();
}

sword_delivery_revive_wait_for_position() {
  var_0 = self;

  for(;;) {
    if(!_id_0547::_id_577E(var_0))
      var_0 waittill("enter_last_stand");

    var_1 = 0;
    var_2 = level.sworddelivery.innerradius;

    if(isDefined(level.sworddelivery_checkradius))
      var_2 = level.sworddelivery_checkradius;

    if(_distance2d(var_0.origin, level.sworddelivery._id_206B.origin) > var_2)
      var_1 = 1;

    if(!var_1) {
      if(_abs(var_0.origin[2] - level.sworddelivery._id_206B.origin[2]) > 84)
        var_1 = 1;
    }

    if(!var_1) {
      break;
    }

    wait 0.2;
  }

  return 1;
}

sword_delivery_revive() {
  var_0 = self;
  var_0 _id_0553::_id_53E2(var_0);
  var_0 _id_0586::_id_078C("zom_dlc3_5_zm");
  var_0 thread sword_pull_out_animation();

  if(common_scripts\utility::_id_562E(1))
    var_0 thread sword_delivery_after_death();
}

sword_pull_out_animation() {
  var_0 = self;
  var_0 endon("death");
  var_0 endon("disconnect");
  var_1 = gettime();

  for(;;) {
    if(gettime() - var_1 > 5000) {
      return;
    }
    if(issubstr(var_0 getcurrentprimaryweapon(), "zom_dlc3_5_zm")) {
      return;
    }
    while(var_0 isswitchingweapon())
      waitframe();

    var_0 _id_0586::_id_078E("zom_dlc3_5_zm");
    waitframe();
  }
}

sword_delivery_after_death() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 endon("sword_lost");
  var_0 notify("sword_delivery_after_death");
  var_0 endon("sword_delivery_after_death");

  for(;;) {
    var_0 waittill("zombie_player_spawn_finished");
    var_0 _id_0586::_id_078C("zom_dlc3_5_zm");
    var_0 thread sword_pull_out_animation();
  }
}

sword_delivery_point_on_purchase(var_0) {
  var_1 = self;

  if(isDefined(var_0.offent) && var_0.offent.targetname != "circle_point_struct")
    var_0.offent _meth_8006(var_1);

  if(isDefined(var_0.onent) && var_0.onent.targetname != "circle_point_struct")
    var_0.onent showtoplayer(var_1);

  thread sword_delivery_point_purchase_vfx(var_0);
  var_1.sworddeliverypointsactive[var_0._id_00D4] = 1;
  var_1 notify("sword_delivery_point_activated");
}

sword_delivery_point_purchase_vfx(var_0) {
  var_1 = _spawnfx(common_scripts\utility::_id_44F5("zmb_sword_point_purchase"), var_0.origin);
  _triggerfx(var_1);
  var_1 _id_0378::_id_8D74("dlc3_rune_jolt_absorb");
  wait 3;
  var_1 delete();
}

sword_post_ee_complete_handler() {
  var_0 = common_scripts\utility::_id_46B5("sword_spawn_loc", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.target)) {
    return;
  }
  var_1 = _getent(var_0.target, "targetname");
  var_2 = 0;

  if(_isonlinegame()) {
    foreach(var_4 in level.players) {
      if(var_4 getplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "hasCompletedEESequence")) {
        var_2 = 1;
        break;
      }
    }
  }

  if(!var_2) {
    foreach(var_4 in level.players)
    var_1 disableplayeruse(var_4);
  } else {
    var_8 = spawn("script_model", var_0.origin);
    var_8.angles = var_0.angles;
    var_8 setModel("npc_zom_barb_sword_02");
    var_8 hide();

    foreach(var_4 in level.players) {
      var_10 = var_4 getplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "hasCompletedEESequence");

      if(var_10) {
        var_1 disableplayeruse(var_4);
        var_8 showtoplayer(var_4);
        var_1 enableplayeruse(var_4);
        var_1 _meth_8660(1, var_0.origin);
        var_1 sethintstring(&"ZOMBIE_DLC3_PICKUP_SWORD");
        level thread sword_post_ee_complete_trig_think(var_1, var_0, var_4);
        continue;
      }

      var_1 disableplayeruse(var_4);
    }
  }
}

sword_post_ee_complete_trig_think(var_0, var_1, var_2) {
  var_2 endon("disconnect");

  for(;;) {
    var_0 waittill("trigger", var_3);

    if(var_3 != var_2) {
      continue;
    }
    if(_id_0547::_id_73F9(var_3, "zom_dlc3_5_zm")) {
      continue;
    }
    var_3 _id_0378::_id_8D74("aud_pickup_barbarosa_sword", var_1.origin);
    var_3.special_melee_weapon = "zom_dlc3_5_zm";
    var_3 _id_0586::_id_078C("zom_dlc3_5_zm");
    var_3 thread sword_pull_out_animation();
  }
}