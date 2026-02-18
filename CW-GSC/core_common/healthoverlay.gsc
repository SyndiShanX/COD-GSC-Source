/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\healthoverlay.gsc
***********************************************/

#using scripts\abilities\gadgets\gadget_health_regen;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\status_effects\status_effect_explosive_damage;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#namespace healthoverlay;

function private autoexec __init__system__() {
  system::register(#"healthoverlay", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&init);
  level.new_health_model = getdvarint(#"new_health_model", 1) > 0;
  level.var_a7985066 = getdvarint(#"hash_1b8e30b9cc6b8dbc", 50);
  level.var_9b350462 = getdvarint(#"hash_3dfb7b6187d80898", 70);
  callback::on_joined_team(&function_5c4a1c21);
  callback::on_joined_spectate(&function_5c4a1c21);
  callback::on_disconnect(&end_health_regen);
  callback::on_player_killed(&function_5c4a1c21);

  if(level.new_health_model) {
    callback::on_spawned(&player_health_regen);
    level.start_player_health_regen = &player_health_regen;
  } else {
    callback::on_spawned(&player_health_regen_t7);
    level.start_player_health_regen = &player_health_regen_t7;
  }

  level thread function_b506b922();
}

function init() {
  level.healthoverlaycutoff = 0.55;
}

function restart_player_health_regen() {
  self end_health_regen();
  self thread[[level.start_player_health_regen]]();
}

function function_5c4a1c21(params) {
  self.var_4d9b2bc3 = 0;
  self notify(#"end_healthregen");
}

function end_health_regen() {
  self.var_4d9b2bc3 = 0;
  self notify(#"end_healthregen");
}

function player_health_regen_t7() {
  self endon(#"end_healthregen");

  if(self.health <= 0) {
    assert(!isalive(self));
    return;
  }

  maxhealth = self.health;
  oldhealth = maxhealth;
  player = self;
  regenrate = 0.1;
  usetrueregen = 0;
  veryhurt = 0;
  player.breathingstoptime = -10000;
  thread player_breathing_sound(maxhealth * 0.35);
  thread player_heartbeat_sound(maxhealth * 0.35);
  lastsoundtime_recover = 0;
  hurttime = 0;
  newhealth = 0;

  for(;;) {
    waitframe(1);

    if(isDefined(player.regenrate)) {
      regenrate = player.regenrate;
      usetrueregen = 1;
    }

    if(player.health == maxhealth) {
      veryhurt = 0;

      if(isDefined(self.atbrinkofdeath)) {
        self notify(#"challenge_survived_from_death");
        self.atbrinkofdeath = undefined;
      }

      continue;
    }

    if(player.health <= 0) {
      return;
    }

    if(player.laststand === 1 && player.var_8fd58a32 !== 1) {
      continue;
    }

    wasveryhurt = veryhurt;
    ratio = player.health / maxhealth;

    if(ratio <= level.healthoverlaycutoff) {
      veryhurt = 1;
      self.atbrinkofdeath = 1;
      self.isneardeath = 1;

      if(!wasveryhurt) {
        hurttime = gettime();
      }
    } else {
      self.isneardeath = 0;
    }

    if(player.health >= oldhealth) {
      regentime = 5000;

      if(player hasperk(#"specialty_healthregen")) {
        regentime = int(regentime / getdvarfloat(#"perk_healthregenmultiplier", 0));
      }

      if(gettime() - hurttime < regentime) {
        continue;
      }

      if(regentime <= 0) {
        continue;
      }

      if(gettime() - lastsoundtime_recover > regentime) {
        lastsoundtime_recover = gettime();
        self notify(#"snd_breathing_better");
      }

      if(veryhurt) {
        newhealth = ratio;
        veryhurttime = 3000;

        if(player hasperk(#"specialty_healthregen")) {
          veryhurttime = int(veryhurttime / getdvarfloat(#"perk_healthregenmultiplier", 0));
        }

        if(gettime() > hurttime + veryhurttime) {
          newhealth += regenrate;
        }
      } else if(usetrueregen) {
        newhealth = ratio + regenrate;
      } else {
        newhealth = 1;
      }

      if(newhealth >= 1) {
        self player::reset_attacker_list();
        newhealth = 1;
      }

      if(newhealth <= 0) {
        return;
      }

      player setnormalhealth(newhealth);
      change = player.health - oldhealth;

      if(change > 0) {
        player decay_player_damages(change);
      }

      oldhealth = player.health;
      continue;
    }

    oldhealth = player.health;
    hurttime = gettime();
    player.breathingstoptime = hurttime + 6000;
  }
}

function function_f7a21c4() {
  self endon(#"hash_2d775ef016d5c651");

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    level visionset_mgr::set_state_active(self, 1);
    waitframe(1);
  }
}

function function_8335b12() {
  if(getdvarint(#"new_blood_version", 3) != 3) {
    self visionset_mgr::activate("visionset", "crithealth", self, 0.5, &function_f7a21c4, 0.5);
  }
}

function function_306c4d60() {
  if(getdvarint(#"new_blood_version", 3) != 3) {
    self notify(#"hash_2d775ef016d5c651");
    self visionset_mgr::deactivate_per_player("visionset", "crithealth", self);
  }
}

function function_c48cb1fc() {
  self thread function_8335b12();
  self.var_61e6c24d = 1;
}

function j_sticks_front1_end_le1() {
  self thread function_306c4d60();
  self.var_61e6c24d = 0;
}

function private function_2eee85c1() {
  if(self.var_61e6c24d) {
    self j_sticks_front1_end_le1();
  }
}

function private function_df99db2() {
  player = self;

  if(player.health <= 0) {
    return false;
  }

  if(player isremotecontrolling()) {
    return false;
  }

  if(player.laststand === 1 && player.var_8fd58a32 !== 1) {
    return false;
  }

  return true;
}

function private should_heal(var_dc77251f, regen_delay) {
  if(is_true(self.disable_health_regen_delay)) {
    var_dc77251f.var_ba47a7a3 = 1;
  }

  if(!is_true(self.ignore_health_regen_delay) && var_dc77251f.time_now - var_dc77251f.var_ba47a7a3 < regen_delay) {
    return false;
  }

  if(regen_delay <= 0) {
    return false;
  }

  if(self.health >= self.var_66cb03ad) {
    return false;
  }

  return true;
}

function private function_53964fa3(var_bc840360, var_dc77251f) {
  if(self.heal.enabled == 0) {
    return 0;
  }

  regen_rate = self function_8ca62ae3();

  if(regen_rate <= 0) {
    return 0;
  }

  heal_amount = self.heal.heal_amount;

  if(!isDefined(heal_amount) || heal_amount <= 0) {
    return 0;
  }

  if(!isDefined(var_dc77251f.time_now)) {
    var_dc77251f.time_now = gettime();
  }

  if(!isDefined(self.heal.var_fa57541f)) {
    self.heal.var_fa57541f = self.health;
  }

  var_c59b0d1e = heal_amount / regen_rate;
  nt = float(var_dc77251f.time_now - (isDefined(self.heal.var_f37a08a8) ? self.heal.var_f37a08a8 : var_dc77251f.time_now)) / 1000 / var_c59b0d1e;
  exp = isDefined(self.heal.var_4e6c244d) ? self.heal.var_4e6c244d : 1;

  if(nt != 1) {
    var_6f934ab = self.heal.var_fa57541f + var_bc840360 * 1 / (1 + pow(nt / (1 - nt), exp * -1));
  } else {
    var_6f934ab = self.heal.var_fa57541f + var_bc840360;
  }

  var_6f934ab = min(var_6f934ab, var_bc840360);
  regen_amount = (var_6f934ab - var_dc77251f.old_health) / var_bc840360;
  return regen_amount;
}

function private function_8ca62ae3() {
  if(self.heal.enabled == 0) {
    return 0;
  }

  regen_rate = self.heal.rate;

  if(regen_rate == 0) {
    regen_rate = isDefined(self.n_regen_rate) ? self.n_regen_rate : self.playerrole.healthhealrate;

    if(self hasperk(#"specialty_quickrevive")) {
      regen_rate *= 1.5;
    }

    if(isDefined(self.var_5762241e)) {
      regen_rate += self.var_5762241e;
    }

    regen_rate *= self function_4e64ede5();
  }

  return regen_rate;
}

function private function_f8139729() {
  assert(isDefined(self.var_66cb03ad));
  assert(isDefined(self.maxhealth));
  assert(isPlayer(self));
  var_bc840360 = isDefined(self.heal) && isDefined(self.heal.var_bc840360) ? self.heal.var_bc840360 : 0;

  if(var_bc840360 == 0) {
    var_bc840360 = self.var_66cb03ad;
  }

  var_bc840360 = math::clamp(var_bc840360, 0, max(self.maxhealth, self.var_66cb03ad));
  return var_bc840360;
}

function private heal(var_dc77251f) {
  player = self;
  healing_enabled = player.heal.enabled == 1;
  regen_delay = 1;

  if(healing_enabled && player.heal.var_c8777194 === 1) {
    regen_delay = isDefined(player.n_regen_delay) ? player.n_regen_delay : player.healthregentime;
    regen_delay = int(int(regen_delay * 1000));
    specialty_healthregen_enabled = 0;

    if(specialty_healthregen_enabled && player hasperk(#"specialty_healthregen") || player hasperk(#"specialty_quickrevive")) {
      regen_delay = int(regen_delay / getdvarfloat(#"perk_healthregenmultiplier", 0));
    }
  }

  if(!should_heal(var_dc77251f, regen_delay)) {
    return;
  }

  if(var_dc77251f.time_now - var_dc77251f.var_7cb44c56 > regen_delay) {
    var_dc77251f.var_7cb44c56 = var_dc77251f.time_now;
    self notify(#"snd_breathing_better");
  }

  var_bc840360 = player function_f8139729();
  assert(var_bc840360 > 0);

  if(is_true(player.var_44d52546)) {
    regen_amount = 1;
  } else if(getdvarint(#"hash_7f9cfdea69a18091", 1) == 1) {
    regen_amount = player function_53964fa3(var_bc840360, var_dc77251f);
  } else {
    regen_rate = player function_8ca62ae3();
    regen_amount = regen_rate * float(var_dc77251f.time_elapsed) / 1000 / var_bc840360;
  }

  if(regen_amount == 0) {
    return;
  }

  var_dc77251f.var_ec8863bf = math::clamp(var_dc77251f.ratio + regen_amount, 0, 1);

  if(var_dc77251f.var_ec8863bf <= 0) {
    return;
  }

  if(player.var_61e6c24d && var_dc77251f.var_ec8863bf > var_dc77251f.var_dae4d7ea) {
    player j_sticks_front1_end_le1();
  }

  new_health = var_dc77251f.var_ec8863bf * var_bc840360 + var_dc77251f.var_e65dca8d;

  if(new_health < player.health) {
    new_health = player.health;
  }

  player.health = int(math::clamp(floor(new_health), 0, max(self.maxhealth, self.var_66cb03ad)));
  var_dc77251f.var_e65dca8d = new_health - player.health;

  if(player.health >= var_bc840360 && var_dc77251f.old_health < var_bc840360) {
    player player::function_c6fe9951();
  }

  if(player.health >= player.var_66cb03ad && var_dc77251f.old_health < player.var_66cb03ad) {
    player player::reset_attacker_list();
    player player::function_d1768e8e();
    return;
  }

  change = player.health - var_dc77251f.old_health;

  if(change > 0) {
    player decay_player_damages(change);

    if(sessionmodeismultiplayergame()) {
      player stats::function_dad108fa(#"total_heals", change);
    }
  }
}

function private check_max_health(var_dc77251f) {
  player = self;
  var_66cb03ad = player.var_66cb03ad < 0 ? player.maxhealth : player.var_66cb03ad;

  if(player.health >= var_66cb03ad) {
    if(isDefined(self.atbrinkofdeath)) {
      self notify(#"challenge_survived_from_death");
      self.atbrinkofdeath = undefined;
    }

    var_dc77251f.old_health = player.health;
    return true;
  }

  return false;
}

function private function_69e7b01c(ratio) {
  if(ratio <= level.healthoverlaycutoff) {
    self.atbrinkofdeath = 1;
    self.isneardeath = 1;
    return;
  }

  self.isneardeath = 0;
}

function player_health_regen() {
  if(self.health <= 0) {
    assert(!isalive(self));
    self.var_4d9b2bc3 = 0;
    return;
  }

  player = self;
  player.var_4d9b2bc3 = 1;
  player.breathingstoptime = -10000;
  player.var_dc77251f = {
    #var_ba47a7a3: 0, #time_now: 0, #time_elapsed: 0, #ratio: 0, #var_ec8863bf: 0, #var_e65dca8d: 0, #var_215539de: 0, #var_dae4d7ea: 0, #old_health: player.health, #var_7cb44c56: 0, #var_d1e06a5f: gettime()
  };
  player j_sticks_front1_end_le1();
}

function private function_8f2722f6(now, var_677a3e37) {
  player = self;

  if(!is_true(player.var_4d9b2bc3) || player.var_67ec7eb0 === 1) {
    return;
  }

  if(player.maxhealth == 0) {
    return;
  }

  if(!isalive(player)) {
    return;
  }

  if(level.autoheal && !var_677a3e37) {
    if(player.health < player.var_66cb03ad && player.heal.enabled !== 1) {
      player gadget_health_regen::function_ef6c7869(now);
    }
  }

  var_dc77251f = player.var_dc77251f;

  if(player check_max_health(var_dc77251f)) {
    var_dc77251f.var_e65dca8d = 0;
    player function_2eee85c1();
    return;
  }

  if(!player function_df99db2()) {
    var_dc77251f.var_e65dca8d = 0;
    player function_2eee85c1();
    return;
  }

  var_bc840360 = player function_f8139729();

  if(var_bc840360 <= player.health) {
    player.health = var_bc840360;
    var_dc77251f.var_e65dca8d = 0;
    player function_2eee85c1();
    return;
  }

  var_dc77251f.ratio = player.health / var_bc840360;
  var_dc77251f.var_ec8863bf = var_dc77251f.ratio;
  player function_69e7b01c(player.health / player.maxhealth);
  var_dc77251f.time_now = now;

  if(player.health < var_dc77251f.old_health) {
    player.breathingstoptime = now + 6000;
    var_dc77251f.var_ba47a7a3 = now;
  } else {
    var_dc77251f.time_elapsed = now - var_dc77251f.var_d1e06a5f;
    player heal(var_dc77251f);

    if(var_dc77251f.var_ec8863bf <= 0) {
      player.var_4d9b2bc3 = 0;
      return;
    }
  }

  var_dc77251f.var_a83bd8fd = level.var_a7985066 / player.maxhealth;
  var_dc77251f.var_dae4d7ea = level.var_9b350462 / player.maxhealth;

  if(!player.var_61e6c24d && var_dc77251f.var_ec8863bf <= var_dc77251f.var_a83bd8fd) {
    player function_c48cb1fc();
  } else if(player.var_61e6c24d && var_dc77251f.var_ec8863bf > var_dc77251f.var_dae4d7ea) {
    player j_sticks_front1_end_le1();
  }

  var_dc77251f.old_health = player.health;
}

function private function_b506b922() {
  level endon(#"game_ended");

  while(true) {
    profilestart();
    var_677a3e37 = getdvarint(#"hash_4371c604abfbb2eb", 0) > 0;
    var_1556c25 = getlevelframenumber();
    now = gettime();

    foreach(player in getplayers()) {
      if((player getentitynumber() + var_1556c25 & 1) != 0) {
        continue;
      }

      if(!isDefined(player.var_dc77251f)) {
        continue;
      }

      player function_8f2722f6(now, var_677a3e37);
      player.var_dc77251f.var_d1e06a5f = now;
    }

    profilestop();
    waitframe(1);
    util::function_5355d311();
  }
}

function decay_player_damages(decay) {
  if(!isDefined(self.attackerdamage)) {
    return;
  }

  if(!isDefined(self.attackers)) {
    return;
  }

  for(j = 0; j < self.attackers.size; j++) {
    player = self.attackers[j];

    if(!isDefined(player)) {
      continue;
    }

    if(self.attackerdamage[player.clientid].damage == 0) {
      continue;
    }

    self.attackerdamage[player.clientid].damage -= decay;

    if(self.attackerdamage[player.clientid].damage < 0) {
      self.attackerdamage[player.clientid].damage = 0;
    }
  }
}

function player_breathing_sound(healthcap) {
  self endon(#"end_healthregen");
  wait 2;
  player = self;

  for(;;) {
    wait 0.2;

    if(player.health <= 0) {
      return;
    }

    if(player util::isusingremote()) {
      continue;
    }

    if(player.health >= healthcap) {
      continue;
    }

    if(player.healthregentime <= 0 && gettime() > player.breathingstoptime) {
      continue;
    }

    player notify(#"snd_breathing_hurt");
    wait 0.784;
    wait 0.1 + randomfloat(0.8);
  }
}

function player_heartbeat_sound(healthcap) {
  self endon(#"end_healthregen");
  self.hearbeatwait = 0.2;
  wait 2;
  player = self;

  for(;;) {
    wait 0.2;

    if(player.health <= 0) {
      return;
    }

    if(player util::isusingremote()) {
      continue;
    }

    if(player.health >= healthcap) {
      self.hearbeatwait = 0.3;
      continue;
    }

    if(player.healthregentime <= 0 && gettime() > player.breathingstoptime) {
      self.hearbeatwait = 0.3;
      continue;
    }

    player playlocalsound(#"mpl_player_heartbeat");
    wait self.hearbeatwait;

    if(self.hearbeatwait <= 0.6) {
      self.hearbeatwait += 0.1;
    }
  }
}

function function_d2880c8f() {
  if(is_true(self.heal.enabled)) {
    self.health = self function_f8139729();
    return;
  }

  self.health = self.maxhealth;
}