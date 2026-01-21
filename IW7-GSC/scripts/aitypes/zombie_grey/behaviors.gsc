/*****************************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_grey\behaviors.gsc
*****************************************************/

zombiegreymayshoot(var_0) {
  if(!isDefined(self.weapon)) {
    return anim.failure;
  }

  if(isDefined(self.dontevershoot) && self.dontevershoot) {
    return anim.failure;
  }

  if(!shouldshoot()) {
    return anim.failure;
  }

  return anim.success;
}

shouldshoot() {
  if(isDefined(self.dontevershoot) && self.dontevershoot) {
    return 0;
  }

  if(!isDefined(self.enemy)) {
    return 0;
  }

  if(self.bulletsinclip == 0) {
    return 0;
  }

  if(self cansee(self.enemy)) {
    scripts\anim\utility_common::dontgiveuponsuppressionyet();
    self.goodshootpos = self.enemy getshootatpos();
    return 1;
  }

  return 0;
}

zombiegreyshouldmelee(var_0) {
  if(!isgreymeleeallowed()) {
    return anim.failure;
  }

  if(![[self.fnismeleevalid]](self.enemy, 1)) {
    return anim.failure;
  }

  return anim.success;
}

isgreymeleeallowed(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self.enemy;
  }

  if(isDefined(self.dontmelee)) {
    return 0;
  }

  if(isDefined(self.bt.cannotmelee)) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(var_0.dontmelee)) {
    return 0;
  }

  if(isDefined(self._stealth) && !scripts\aitypes\melee::canmeleeduringstealth()) {
    return 0;
  }

  if(gettime() < self.next_melee_time) {
    return 0;
  }

  return 1;
}

zombiegreyinitmelee(var_0) {
  self.acceptablemeleefraction = 0.95;
  self.fnismeleevalid = ::ismeleevalid;
  self.fnmeleecharge_init = ::meleecharge_init_mp;
  self.fnmeleecharge_terminate = ::meleecharge_terminate_mp;
  self.fnmeleevsplayer_init = ::meleevsplayer_init_mp;
  self.fnmeleevsplayer_terminate = ::meleevsplayer_terminate_mp;
  self.fncanmovefrompointtopoint = ::canmovefrompointtopoint;
  set_next_melee_time(self);
  return anim.success;
}

zombiegreyinitteleporttoloner(var_0) {
  set_can_do_teleport_to_loner(self, 0);
  set_next_teleport_to_loner_time(self);
  return anim.success;
}

zombiegreyinitteleportattack(var_0) {
  set_can_do_teleport_attack(self, 0);
  set_next_teleport_attack_time(self);
  reset_recent_damage_data(self);
  return anim.success;
}

zombiegreyinitteleportsummon(var_0) {
  set_can_do_teleport_summon(self, 1);
  set_next_teleport_summon_time(self);
  return anim.success;
}

zombiegreyinitteleportdash(var_0) {
  set_can_do_teleport_dash(self, 1);
  set_next_teleport_dash_time(self);
  return anim.success;
}

zombiegreyinitduplicatingattack(var_0) {
  self.can_do_duplicating_attack = 0;
  self.trigger_clone_health = self.maxhealth * 0.33;
  return anim.success;
}

zombiegreyinithealthregen(var_0) {
  self.activate_health_regen_threshold = int(self.health * 0.2);
  self.current_max_health_regen_level = self.maxhealth;
  self.max_health_regen_level_penalty = int(self.maxhealth * 0.33);
  self.min_health_regen_level = int(self.maxhealth * 0.33);
  self.health_regen_minimum = 0;
  self.can_do_health_regen = 1;
  var_1 = self.maxhealth - self.activate_health_regen_threshold;
  var_2 = 120.0;
  self.health_addition_per_regen_segement = int(var_1 / var_2);
  return anim.success;
}

zombiegreyshouldduplicatingattack(var_0) {
  if(!self.can_do_duplicating_attack) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.i_am_clone)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.is_regening_health)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.doing_teleport_attack)) {
    return anim.failure;
  }

  if(self.health < self.trigger_clone_health) {
    setduplicatingattackdata(self, max(level.players.size, 2));
    return anim.success;
  }

  return anim.failure;
}

setduplicatingattackdata(var_0, var_1) {
  var_0 setscriptablepartstate("health_light", "no_light");
  scripts\asm\zombie_grey\zombie_grey_asm::set_grey_clone(var_0);
  var_0.doing_duplicating_attack = 1;
  var_0.num_of_clones = var_1;
  level.clone_health = int(var_0.maxhealth / var_1);
  level.damage_to_clones = 0;
}

zombiegreydoduplicatingattack(var_0) {
  if(scripts\engine\utility::is_true(self.doing_duplicating_attack)) {
    return anim.running;
  }

  return anim.failure;
}

zombiegreyshouldteleportattack(var_0) {
  if(!scripts\engine\utility::is_true(self.can_do_teleport_attack)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.i_am_clone)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.is_regening_health)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.doing_teleport_summon)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.doing_teleport_dash)) {
    return anim.failure;
  }

  if(isDefined(self.teleport_loner_target_player)) {
    return anim.failure;
  }

  var_1 = gettime();

  if(var_1 < self.next_teleport_time) {
    return anim.failure;
  }

  if(var_1 < self.next_teleport_attack_time) {
    return anim.failure;
  }

  if(var_1 < self.next_check_recent_damage_time) {
    return anim.failure;
  }

  if(!meet_recent_damage_threshold_check(self)) {
    reset_recent_damage_data(self);
    return anim.failure;
  }

  reset_recent_damage_data(self);
  self.doing_teleport_attack = 1;
  return anim.success;
}

zombiegreyshouldteleportsummon(var_0) {
  if(!scripts\engine\utility::is_true(self.can_do_teleport_summon)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.i_am_clone)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.doing_teleport_attack)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.doing_teleport_dash)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.is_regening_health)) {
    return anim.failure;
  }

  if(isDefined(self.teleport_loner_target_player)) {
    return anim.failure;
  }

  var_1 = gettime();

  if(var_1 < self.next_teleport_time) {
    return anim.failure;
  }

  if(var_1 < self.next_teleport_summon_time) {
    return anim.failure;
  }

  self.doing_teleport_summon = 1;
  return anim.success;
}

zombiegreyshouldteleportdash(var_0) {
  if(!scripts\engine\utility::is_true(self.can_do_teleport_dash)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.i_am_clone)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.doing_teleport_attack)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.doing_teleport_summon)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.is_regening_health)) {
    return anim.failure;
  }

  if(isDefined(self.teleport_loner_target_player)) {
    return anim.failure;
  }

  var_1 = gettime();

  if(var_1 < self.next_teleport_time) {
    return anim.failure;
  }

  if(var_1 < self.next_teleport_dash_time) {
    return anim.failure;
  }

  if(isDefined(self.target_player) && distancesquared(self.origin, self.target_player.origin) > 1000000) {
    return anim.failure;
  }

  self.doing_teleport_dash = 1;
  return anim.success;
}

zombiegreydoteleportattack(var_0) {
  if(scripts\engine\utility::is_true(self.doing_teleport_attack)) {
    return anim.running;
  }

  return anim.failure;
}

zombiegreydoteleportsummon(var_0) {
  if(scripts\engine\utility::is_true(self.doing_teleport_summon)) {
    return anim.running;
  }

  return anim.failure;
}

zombiegreydoteleportdash(var_0) {
  if(scripts\engine\utility::is_true(self.doing_teleport_dash)) {
    return anim.running;
  }

  return anim.failure;
}

zombiegreyshouldteleporttoloner(var_0) {
  if(!scripts\engine\utility::is_true(self.can_do_teleport_to_loner)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.i_am_clone)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.is_regening_health)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.doing_teleport_attack)) {
    return anim.failure;
  }

  var_1 = gettime();

  if(var_1 < self.next_teleport_to_loner_time) {
    return anim.failure;
  }

  var_2 = getteleportlonertargetplayer(self);

  if(isDefined(var_2)) {
    self.teleport_loner_target_player = var_2;
    set_next_teleport_to_loner_time(self);
    return anim.success;
  }

  return anim.failure;
}

zombiegreydoteleporttoloner(var_0) {
  if(isDefined(self.teleport_loner_target_player)) {
    return anim.running;
  }

  return anim.failure;
}

getteleportlonertargetplayer(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3.num_teleport_loner_encountered)) {
      var_3.num_teleport_loner_encountered = 0;
    }

    if(distancesquared(var_0.origin, var_3.origin) < 250000) {
      continue;
    }
    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_5 = undefined;
  var_6 = 999;

  foreach(var_3 in var_1) {
    if(var_3.num_teleport_loner_encountered < var_6) {
      var_6 = var_3.num_teleport_loner_encountered;
      var_5 = var_3;
    }
  }

  var_5.num_teleport_loner_encountered++;
  return var_5;
}

zombiegreycheckhealthregen(var_0) {
  if(scripts\engine\utility::is_true(self.i_am_clone)) {
    return anim.failure;
  }

  if(scripts\engine\utility::is_true(self.is_regening_health)) {
    return anim.running;
  }

  return anim.failure;
}

zombiegreyassigntargetplayer(var_0) {
  if(isDefined(self.favorite_target_player) && !scripts\cp\cp_laststand::player_in_laststand(self.favorite_target_player)) {
    assigntargetplayer(self, self.favorite_target_player);
    return anim.failure;
  } else {
    var_1 = level.players;
    var_1 = scripts\engine\utility::array_remove(var_1, self.favorite_target_player);
    var_1 = scripts\engine\utility::array_randomize(var_1);

    foreach(var_3 in var_1) {
      if(isDefined(var_3) && !scripts\cp\cp_laststand::player_in_laststand(var_3)) {
        assigntargetplayer(self, var_3);
        return anim.failure;
      }

      assigntargetplayer(self, self.favorite_target_player);
      return anim.failure;
    }
  }

  return anim.failure;
}

assigntargetplayer(var_0, var_1) {
  var_0.target_player = var_1;
}

ismeleevalid(var_0, var_1) {
  if(distancesquared(self.origin, var_0.origin) > self.meleerangesq) {
    return 0;
  }

  if(scripts\asm\asm_bb::bb_ismissingaleg()) {
    return 0;
  }

  if(!scripts\aitypes\melee::ismeleevalid_common(var_0, var_1)) {
    return 0;
  }

  var_2 = scripts\aitypes\melee::gettargetchargepos(var_0);

  if(!isDefined(var_2)) {
    return 0;
  }

  if(!canmovefrompointtopoint(self.origin, var_2)) {
    return 0;
  }

  return 1;
}

meleecharge_init_mp(var_0) {
  self scragentsetscripted(1);
}

meleecharge_terminate_mp(var_0) {
  self scragentsetscripted(0);
}

meleevsplayer_init_mp(var_0) {
  self scragentsetscripted(1);
}

meleevsplayer_terminate_mp(var_0) {
  self scragentsetscripted(0);
}

canmovefrompointtopoint(var_0, var_1) {
  var_2 = navtrace(var_0, var_1, self, 1);
  var_3 = var_2["fraction"];

  if(var_3 >= self.acceptablemeleefraction) {
    var_4 = 0;
  } else {
    var_4 = 1;
  }

  return !var_4;
}

zombiegreyhasweapon(var_0) {
  if(isDefined(self.weapon)) {
    return anim.success;
  }

  return anim.failure;
}

is_vector_in_front_cone_of_grey(var_0, var_1) {
  var_2 = anglesToForward(var_1.angles);
  var_2 = (var_2[0], var_2[1], 0);
  return vectordot(var_0, var_2) > 0.5;
}

try_regen_health(var_0) {
  if(!can_regen_health(var_0)) {
    return;
  }
  var_0 thread regen_health_sequence(var_0);
}

can_regen_health(var_0) {
  if(!scripts\engine\utility::is_true(var_0.can_do_health_regen)) {
    return 0;
  }

  if(var_0.health > var_0.activate_health_regen_threshold) {
    return 0;
  }

  if(isDefined(level.last_health_regen_time) && gettime() - level.last_health_regen_time < 50) {
    return 0;
  }

  if(scripts\engine\utility::is_true(var_0.i_am_clone)) {
    return 0;
  }

  return 1;
}

regen_health_sequence(var_0) {
  var_0 endon("death");
  var_0.alien_fuse_exposed = undefined;
  var_0.is_regening_health = 1;
  var_0 notify("update_mobile_shield_visibility", 0);
  var_0 waittill("grey play regen");
  regen_health_internal(var_0);
}

regen_health_internal(var_0) {
  level.last_health_regen_time = gettime();
  var_0.should_shock_wave = 0;
  var_0.alien_fuse_exposed = scripts\engine\utility::random(var_0.available_fuse);

  if(isDefined(level.pre_grey_regen_func)) {
    [[level.pre_grey_regen_func]](var_0);
  }

  scripts\asm\zombie_grey\zombie_grey_asm::drop_max_ammo();
  var_0.health = var_0.maxhealth;
  var_0 notify("update_health_light");
  var_1 = scripts\engine\utility::waittill_any_timeout(6.0, "stop_regen_health");

  if(var_1 == "stop_regen_health") {
    process_stop_regen_health_action(var_0);
    var_0.should_shock_wave = 1;

    if(isDefined(level.greygetmeleedamagedfunc)) {
      [[level.greygetmeleedamagedfunc]](var_0.melee_attacker, var_0.alien_fuse_exposed);
    }
  }

  var_0.is_regening_health = 0;
  var_0.actually_doing_regen = 0;

  if(isDefined(level.post_grey_regen_func)) {
    [[level.post_grey_regen_func]]();
  }
}

process_stop_regen_health_action(var_0) {
  if(!isDefined(var_0.num_of_times_stop_regen_health)) {
    var_0.num_of_times_stop_regen_health = 0;
  }

  var_0.num_of_times_stop_regen_health++;

  if(var_0.num_of_times_stop_regen_health == 1) {
    var_0.health_regen_minimum = int(var_0.maxhealth * 0.33);
    var_0.should_regen_summon = 1;
  } else if(var_0.num_of_times_stop_regen_health >= 2) {
    var_0.can_do_health_regen = 0;
  }
}

meet_recent_damage_threshold_check(var_0) {
  if(var_0.sum_of_recent_damage > 500) {
    return 1;
  }

  if(var_0.recent_player_attackers.size >= 2) {
    return 1;
  }

  return 0;
}

get_recent_damage_amount_threshold() {
  return 500;
}

reset_recent_damage_data(var_0) {
  var_0.next_check_recent_damage_time = gettime() + 1000;
  var_0.sum_of_recent_damage = 0;
  var_0.recent_player_attackers = [];
}

set_next_teleport_attack_time(var_0) {
  var_0.next_teleport_attack_time = gettime() + randomintrange(2000, 5000);
  set_next_teleport_time(var_0);
}

set_next_teleport_summon_time(var_0) {
  var_0.next_teleport_summon_time = gettime() + randomintrange(12000, 15000);
  set_next_teleport_time(var_0);
}

set_next_teleport_dash_time(var_0) {
  var_0.next_teleport_dash_time = gettime() + randomintrange(6000, 9000);
  set_next_teleport_time(var_0);
}

set_next_melee_time(var_0) {
  var_1 = 3;

  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    var_1 = 0.5;
  }

  var_0.next_melee_time = gettime() + var_1 * 1000;
}

set_next_teleport_time(var_0) {
  var_0.next_teleport_time = gettime() + randomintrange(2000, 3000);
}

set_next_teleport_to_loner_time(var_0) {
  var_0.next_teleport_to_loner_time = gettime() + randomintrange(12000, 18000);
}

greymeleevsplayer_init(var_0) {
  melee_init(var_0);

  if(isDefined(self.fnmeleevsplayer_init)) {
    self[[self.fnmeleevsplayer_init]](var_0);
  }

  thread scripts\aitypes\melee::meleedeathhandler(self.enemy);
}

melee_init(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self.enemy;
  }

  if(isDefined(self.melee)) {
    scripts\aitypes\melee::melee_destroy();
  }

  scripts\asm\asm_bb::bb_setmeleetarget(var_1);
  self.melee.taskid = var_0;
  var_1.melee.taskid = var_0;
  return anim.success;
}

greymeleevsplayer_update(var_0) {
  return scripts\aitypes\melee::meleevsplayer_update(var_0);
}

greymeleevsplayer_terminate(var_0) {
  scripts\aitypes\melee::meleevsplayer_terminate(var_0);
}

set_can_do_teleport_attack(var_0, var_1) {
  var_0.can_do_teleport_attack = var_1;
}

set_can_do_teleport_summon(var_0, var_1) {
  var_0.can_do_teleport_summon = var_1;
}

set_can_do_teleport_dash(var_0, var_1) {
  var_0.can_do_teleport_dash = var_1;
}

set_can_do_teleport_to_loner(var_0, var_1) {
  var_0.can_do_teleport_to_loner = var_1;
}

deactivate_mobile_shields(var_0) {
  foreach(var_2 in var_0.mobile_shields) {
    var_2 delete();
  }

  var_0.mobile_shields = undefined;
}

activate_mobile_shields(var_0) {
  var_0 endon("death");
  level endon("game_ended");
  var_0 waittill("shockwave_deploy");
  var_0.mobile_shields = [];

  foreach(var_3, var_2 in level.players) {
    activate_mobile_shield_designated_for(var_2, var_0, 80 + var_3 * 20);
  }
}

activate_mobile_shield_designated_for(var_0, var_1, var_2) {
  var_3 = calculate_mobile_shield_pos(var_0, var_1, var_2);
  var_4 = spawnhelicopter(level.players[0], var_3.mobile_shield_pos, vectortoangles(var_3.mobile_shield_face_dir), "zombie_grey_shield", "zmb_temp_grey_shield_des");
  var_4 makevehiclenotcollidewithplayers(1);
  var_4 vehicle_setspeed(100, 200, 200);
  var_4 setturningability(1.0);
  var_4 setneargoalnotifydist(10);
  var_4 sethoverparams(1, 0, 0);
  var_4 setyawspeed(360, 360);
  var_5 = spawn("script_model", var_3.mobile_shield_look_at_pos);
  var_4 setlookatent(var_5);
  var_4.mobile_shield_look_at_ent = var_5;
  var_4.distance_from_grey = var_2;
  var_4.designated_player = var_0;
  var_4.in_delay_update_next_hide_time = 0;
  var_4 thread mobile_shield_clean_up_monitor(var_1, var_4);
  var_4 thread mobile_shield_damage_monitor(var_4);
  var_4 thread mobile_shield_update_pos(var_4, var_0, var_1);
  var_4 thread mobile_shield_visibility_monitor(var_1, var_4);
  var_5 thread mobile_shield_look_at_ent_clean_up_monitor(var_4, var_5);
  var_1.mobile_shields[var_1.mobile_shields.size] = var_4;
}

calculate_mobile_shield_pos(var_0, var_1, var_2) {
  var_3 = var_1.origin + (0, 0, 45);
  var_4 = vectornormalize(var_0 getEye() - var_3);
  var_5 = spawnStruct();
  var_5.mobile_shield_pos = var_3 + var_4 * var_2;
  var_5.mobile_shield_look_at_pos = var_5.mobile_shield_pos + var_4 * 10;
  var_5.mobile_shield_face_dir = var_4;
  return var_5;
}

mobile_shield_clean_up_monitor(var_0, var_1) {
  var_1 endon("death");
  var_0 waittill("death");
  var_1 delete();
}

mobile_shield_look_at_ent_clean_up_monitor(var_0, var_1) {
  var_0 waittill("death");
  var_1 delete();
}

mobile_shield_update_pos(var_0, var_1, var_2) {
  var_0 endon("death");
  var_2 endon("death");
  var_1 endon("disconnect");

  for(;;) {
    var_3 = calculate_mobile_shield_pos(var_1, var_2, var_0.distance_from_grey);
    var_0 setvehgoalpos(var_3.mobile_shield_pos, 1);
    var_0.mobile_shield_look_at_ent.origin = var_3.mobile_shield_look_at_pos;
    scripts\engine\utility::waitframe();
  }
}

mobile_shield_visibility_monitor(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("death");
  update_next_hide_time(var_1, 5);

  for(;;) {
    var_2 = check_is_in_front_of(var_1, var_0);

    if(var_2 && scripts\engine\utility::is_true(var_0.is_shooting)) {
      var_1 hide();
    } else {
      var_3 = gettime();

      if(var_3 < var_1.next_hide_time) {
        var_1 show();
      } else {
        var_1 hide();
      }
    }

    scripts\engine\utility::waitframe();
  }
}

check_is_in_front_of(var_0, var_1) {
  var_2 = var_0.origin - var_1.origin;
  var_2 = (var_2[0], var_2[1], 0);
  var_2 = vectornormalize(var_2);
  var_3 = anglesToForward(var_1.angles);
  return vectordot(var_2, var_3) > 0.525;
}

update_next_hide_time(var_0, var_1) {
  var_0.next_hide_time = gettime() + var_1 * 1000;
}

mobile_shield_damage_monitor(var_0) {
  var_0 endon("death");
  var_0 setCanDamage(1);
  var_0.health = 99999999;

  for(;;) {
    var_0 waittill("damage", var_1);
    var_0.health = var_0.health + var_1;
    update_next_hide_time(var_0, 2);
  }
}

try_update_mobile_shield(var_0, var_1) {
  if(!(isDefined(var_1) && isplayer(var_1))) {
    return;
  }
  if(!isDefined(var_0.mobile_shields)) {
    return;
  }
  foreach(var_3 in var_0.mobile_shields) {
    if(var_3.designated_player == var_1) {
      var_3 thread delay_update_next_hide_time(var_3);
    }
  }
}

delay_update_next_hide_time(var_0) {
  var_0 endon("death");

  if(scripts\engine\utility::is_true(var_0.in_delay_update_next_hide_time)) {
    return;
  }
  var_0.in_delay_update_next_hide_time = 1;
  wait 1.5;
  update_next_hide_time(var_0, 3);
  var_0.in_delay_update_next_hide_time = 0;
}