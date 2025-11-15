/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_dragon_gauntlet.gsc
*************************************************/

#using scripts\shared\abilities\_ability_player;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\throttle_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\vehicles\_dragon_whelp;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_hero_weapon;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_weap_dragon_gauntlet;

function autoexec __init__sytem__() {
  system::register("zm_weap_dragon_gauntlet", & __init__, undefined, undefined);
}

function __init__() {
  level.weapon_dragon_gauntlet = getweapon("dragon_gauntlet_flamethrower");
  level.var_ae0fff53 = getweapon("dragon_gauntlet");
  zm_hero_weapon::register_hero_recharge_event(level.weapon_dragon_gauntlet, & function_fa885ef2);
  zm_hero_weapon::register_hero_recharge_event(level.var_ae0fff53, & function_fa885ef2);
  callback::on_connect( & function_44774881);
  callback::on_player_killed( & function_421902c5);
  zm_hero_weapon::register_hero_weapon("dragon_gauntlet_flamethrower");
  zm_hero_weapon::register_hero_weapon_wield_unwield_callbacks("dragon_gauntlet_flamethrower", & function_712b36f9, & function_b90c6ba);
  zm_hero_weapon::register_hero_weapon_power_callbacks("dragon_gauntlet_flamethrower", & function_cd7dbd9d, & function_2f36d185);
  zm_hero_weapon::register_hero_weapon("dragon_gauntlet");
  zm_hero_weapon::register_hero_weapon_wield_unwield_callbacks("dragon_gauntlet", & function_f79afde0, & function_d638417f);
  zm_hero_weapon::register_hero_weapon_power_callbacks("dragon_gauntlet", & function_cd7dbd9d, & function_2f36d185);
  zm::register_actor_damage_callback( & function_cb315e40);
  level.var_af9cd4ca = new throttle();
  [[level.var_af9cd4ca]] - > initialize(6, 0.05);
  level thread function_a23fb854();
}

function private function_44774881() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("death");
  self endon("hash_b24d78f");
  self function_36f6c07f(0);
  self.weapon_dragon_gauntlet = level.weapon_dragon_gauntlet;
  self.var_ae0fff53 = level.var_ae0fff53;
  self.var_d15b9a33 = "spawner_bo3_dragon_whelp";
  self.var_956fba75 = 0;
  self.var_5307dedb = 0;
  if(isDefined(self.var_cc844f4c) && self.var_cc844f4c) {
    self.var_cc844f4c = 0;
  }
  if(isDefined(self.var_4bd1ce6b)) {
    self function_22d7caeb();
  }
  do {
    self waittill("new_hero_weapon", weapon);
  }
  while(weapon != self.weapon_dragon_gauntlet);
  if(isDefined(self.var_85466cc5) && isDefined(self.var_85466cc5["dragon_gauntlet_flamethrower"])) {
    self setweaponammoclip(level.weapon_dragon_gauntlet, self.var_85466cc5["dragon_gauntlet_flamethrower"]);
    self.var_85466cc5 = undefined;
  } else {
    self setweaponammoclip(self.weapon_dragon_gauntlet, self.weapon_dragon_gauntlet.clipsize);
  }
  if(isDefined(self.var_f7f91f37)) {
    self gadgetpowerset(0, self.var_f7f91f37);
    self.var_f7f91f37 = undefined;
  } else {
    self gadgetpowerset(0, 100);
  }
  self thread weapon_change_watcher();
}

function reset_after_bleeding_out() {
  self endon("disconnect");
  self waittill("spawned_player");
  self function_421902c5();
  self thread function_44774881();
}

function function_421902c5() {
  player = self;
  if(isDefined(player.var_cc844f4c) && player.var_cc844f4c) {
    player thread function_22d7caeb();
  }
}

function function_99a68dd() {
  player = self;
  player zm_weapons::weapon_give(self.weapon_dragon_gauntlet, 0, 1);
  player thread zm_equipment::show_hint_text(&"DLC3_WEAP_DRAGON_GAUNTLET_USE_HINT", 3);
  player.var_8afc8427 = 100;
  player.hero_power = 100;
  player gadgetpowerset(0, 100);
  player zm_hero_weapon::set_hero_weapon_state(self.weapon_dragon_gauntlet, 2);
  player setweaponammoclip(self.weapon_dragon_gauntlet, self.weapon_dragon_gauntlet.clipsize);
  player.var_fd007e55 = 1;
}

function function_36f6c07f(var_147067e4) {
  self.var_147067e4 = var_147067e4;
}

function function_712b36f9(var_40c4a571) {
  if(isDefined(self.var_cc844f4c) && self.var_cc844f4c) {
    self function_22d7caeb();
  }
  if(!(isDefined(self.var_d0827e15) && self.var_d0827e15)) {
    self.var_d0827e15 = 1;
    self zm_audio::create_and_play_dialog("whelp", "aquire");
  }
  self zm_hero_weapon::default_wield(var_40c4a571);
  self function_36f6c07f(3);
  self setweaponammoclip(var_40c4a571, var_40c4a571.clipsize);
  self.var_8afc8427 = self gadgetpowerget(0);
  self.hero_power = self gadgetpowerget(0);
  self disableoffhandweapons();
  if(isDefined(self.var_8afc8427)) {
    self gadgetpowerset(0, self.var_8afc8427);
  }
  self.hero_power = self gadgetpowerget(0);
  self notify("stop_draining_hero_weapon");
  if(!isDefined(self.var_956fba75) || self.var_956fba75 < 3) {
    self thread zm_equipment::show_hint_text(&"DLC3_WEAP_DRAGON_GAUNTLET_FLAMETHROWER_HINT", 3);
    self.var_956fba75 = self.var_956fba75 + 1;
  }
  self thread zm_hero_weapon::continue_draining_hero_weapon(self.weapon_dragon_gauntlet);
  self.var_4c8e9f40 = gettime() + 1000;
  self thread function_c0093887();
  self thread function_22a08c51(var_40c4a571);
}

function function_b90c6ba(var_40c4a571) {
  self notify("hash_e48b9ad6");
  self.var_8afc8427 = self gadgetpowerget(0);
  self.hero_power = self gadgetpowerget(0);
  self zm_hero_weapon::default_unwield(var_40c4a571);
  self function_36f6c07f(1);
  self notify("stop_draining_hero_weapon");
  self enableoffhandweapons();
  if(zm_weapons::has_weapon_or_attachments(var_40c4a571)) {
    self setweaponammoclip(var_40c4a571, 0);
  }
}

function function_f79afde0(var_dabe8ae8) {
  self zm_hero_weapon::default_wield(var_dabe8ae8);
  self function_36f6c07f(3);
  self setweaponammoclip(var_dabe8ae8, var_dabe8ae8.clipsize);
  self.var_8afc8427 = self gadgetpowerget(0);
  self.hero_power = self gadgetpowerget(0);
  self disableoffhandweapons();
  if(isDefined(self.var_8afc8427)) {
    self gadgetpowerset(0, self.var_8afc8427);
  }
  if(!isDefined(self.var_5307dedb) || self.var_5307dedb < 3) {
    self thread zm_equipment::show_hint_text(&"DLC3_WEAP_DRAGON_GAUNTLET_MELEE_HINT", 3);
    self.var_5307dedb = self.var_5307dedb + 1;
  }
  self.hero_power = self gadgetpowerget(0);
  self notify("stop_draining_hero_weapon");
  self thread zm_hero_weapon::continue_draining_hero_weapon(self.var_ae0fff53);
  self thread function_d7a4275d();
  self thread function_62d6a233();
  self thread function_8e2014a0();
  self thread function_22a08c51(var_dabe8ae8);
}

function function_d638417f(var_dabe8ae8) {
  self notify("hash_20599947");
  self.var_8afc8427 = self gadgetpowerget(0);
  self.hero_power = self gadgetpowerget(0);
  self zm_hero_weapon::default_unwield(var_dabe8ae8);
  self function_36f6c07f(1);
  self enableoffhandweapons();
  if(zm_weapons::has_weapon_or_attachments(var_dabe8ae8)) {
    self setweaponammoclip(var_dabe8ae8, 0);
  }
  self notify("stop_draining_hero_weapon");
  if(self zm_weapons::has_weapon_or_attachments(var_dabe8ae8)) {
    self setweaponammoclip(var_dabe8ae8, 0);
  }
  if(isDefined(self.var_cc844f4c) && self.var_cc844f4c) {
    self thread zm_hero_weapon::continue_draining_hero_weapon(self.var_ae0fff53);
    self thread zm_hero_weapon::continue_draining_hero_weapon(self.weapon_dragon_gauntlet);
  }
}

function weapon_change_watcher() {
  self endon("disconnect");
  self.var_f2a52896 = undefined;
  while(true) {
    self waittill("weapon_change", w_current, w_previous);
    if(w_current === level.weapon_dragon_gauntlet) {
      if(self.var_f2a52896 === "wpn_t7_zmb_dlc3_gauntlet_dragon_elbow_upg_world") {
        self detach(self.var_f2a52896, "J_Elbow_RI");
      }
      self.var_f2a52896 = "wpn_t7_zmb_dlc3_gauntlet_dragon_elbow_world";
      self attach(self.var_f2a52896, "J_Elbow_RI");
    } else {
      if(w_current === level.var_ae0fff53) {
        if(self.var_f2a52896 === "wpn_t7_zmb_dlc3_gauntlet_dragon_elbow_world") {
          self detach(self.var_f2a52896, "J_Elbow_RI");
        }
        self.var_f2a52896 = "wpn_t7_zmb_dlc3_gauntlet_dragon_elbow_upg_world";
        self attach(self.var_f2a52896, "J_Elbow_RI");
      } else if(isDefined(self.var_f2a52896)) {
        self detach(self.var_f2a52896, "J_Elbow_RI");
        self.var_f2a52896 = undefined;
      }
    }
    if(isDefined(w_previous) && w_previous.name !== "none" && zm_utility::is_hero_weapon(w_current) && !zm_utility::is_hero_weapon(w_previous)) {
      self.var_a1ee595 = w_previous;
    }
  }
}

function function_22a08c51(weapon) {
  self endon("death");
  self endon("bled_out");
  self endon("disconnect");
  self endon("hash_b24d78f");
  self endon("stop_draining_hero_weapon");
  self endon("hash_9b74f71e");
  self notify("hash_22a08c51");
  self endon("hash_22a08c51");
  while(true) {
    if(!self laststand::player_is_in_laststand()) {
      if(isDefined(self.var_9e2dd97) && self.var_9e2dd97 && self.hero_power < 98) {
        self.hero_power = 98;
        self gadgetpowerset(0, 98);
        self.hero_power = 98;
        self.var_8afc8427 = 98;
      }
      self setweaponammoclip(weapon, weapon.clipsize);
    }
    wait(1);
  }
}

function function_c0093887() {
  self endon("disconnect");
  self endon("hash_b24d78f");
  self endon("hash_89dc36f4");
  self notify("hash_309d2dbf");
  self endon("hash_309d2dbf");
  while(self adsbuttonpressed()) {
    wait(0.05);
  }
  while(!(isDefined(self.var_cc844f4c) && self.var_cc844f4c)) {
    time = gettime();
    if(isDefined(self.var_4c8e9f40) && time < self.var_4c8e9f40) {
      wait(0.05);
      continue;
    }
    if(self gadgetpowerget(0) <= 3) {
      wait(0.05);
      continue;
    }
    if(self adsbuttonpressed() && self getcurrentweapon() === self.weapon_dragon_gauntlet && (!(isDefined(self.var_a0a9409e) && self.var_a0a9409e)) && (!isDefined(level.var_163a43e4) || !is_in_array(self, level.var_163a43e4))) {
      self disableweaponcycling();
      self function_f5802b55();
      self.var_8afc8427 = self gadgetpowerget(0);
      self switchtoweapon(self.var_ae0fff53);
      while(self getcurrentweapon() !== self.var_ae0fff53) {
        wait(0.05);
      }
      self enableweaponcycling();
      level notify("hash_fbd59317", self);
      self notify("hash_89dc36f4");
    }
    wait(0.05);
  }
}

function is_in_array(item, array) {
  if(isDefined(array)) {
    foreach(index in array) {
      if(index == item) {
        return true;
      }
    }
  }
  return false;
}

function function_d7a4275d() {
  self endon("disconnect");
  self endon("death");
  self endon("bled_out");
  self endon("hash_b24d78f");
  self endon("hash_3307435");
  while(self adsbuttonpressed()) {
    if(isDefined(self.var_a0a9409e) && self.var_a0a9409e || (isDefined(level.var_163a43e4) && is_in_array(self, level.var_163a43e4))) {
      continue;
    }
    wait(0.05);
  }
  while(true) {
    time = gettime();
    if(isDefined(self.var_d4b932e6) && time < self.var_d4b932e6) {
      wait(0.05);
      continue;
    }
    if(self gadgetpowerget(0) <= 3) {
      wait(0.05);
      continue;
    }
    if(isDefined(self.var_9d9ac25d) && self.var_9d9ac25d) {
      wait(0.05);
      continue;
    }
    if(self adsbuttonpressed() && self getcurrentweapon() === self.var_ae0fff53 || (isDefined(self.var_a0a9409e) && self.var_a0a9409e) || (isDefined(level.var_163a43e4) && is_in_array(self, level.var_163a43e4)) || !isalive(self.var_4bd1ce6b)) {
      self disableweaponcycling();
      self function_22d7caeb();
      self.var_8afc8427 = self gadgetpowerget(0);
      self switchtoweapon(self.weapon_dragon_gauntlet);
      while(self getcurrentweapon() !== self.weapon_dragon_gauntlet) {
        wait(0.05);
      }
      self enableweaponcycling();
      self notify("hash_3307435");
    }
    wait(0.05);
  }
}

function function_62d6a233() {
  self endon("disconnect");
  self endon("death");
  self endon("bled_out");
  self endon("hash_b24d78f");
  self endon("hash_e48b9ad6");
  self endon("hash_20599947");
  self endon("hash_3307435");
  self notify("hash_cf68b84e");
  self endon("hash_cf68b84e");
  while(true) {
    self util::waittill_any("weapon_melee", "weapon_melee_power");
    var_ebcc1e01 = self gettagorigin("tag_weapon_right");
    physicsexplosioncylinder(var_ebcc1e01, 96, 48, 1.5);
    self thread function_345e492a(var_ebcc1e01, 128);
    wait(0.05);
  }
}

function function_8e2014a0() {
  self endon("disconnect");
  self endon("death");
  self endon("bled_out");
  self endon("hash_b24d78f");
  self endon("hash_e48b9ad6");
  self endon("hash_20599947");
  self endon("hash_3307435");
  self notify("hash_e3575e9f");
  self endon("hash_e3575e9f");
  for(;;) {
    self waittill("weapon_melee_juke", weapon);
    if(weapon === self.var_ae0fff53) {
      self playSound("zmb_rocketshield_start");
      self function_e7fe168a(weapon);
      self playSound("zmb_rocketshield_end");
      self notify("hash_206bebc2");
    }
  }
}

function function_e7fe168a(weapon) {
  self endon("disconnect");
  self endon("death");
  self endon("bled_out");
  self endon("hash_b24d78f");
  self endon("hash_e48b9ad6");
  self endon("hash_20599947");
  self endon("hash_3307435");
  self endon("weapon_melee");
  self endon("weapon_melee_power");
  self endon("weapon_melee_charge");
  self notify("hash_c0a47e94");
  self endon("hash_c0a47e94");
  start_time = gettime();
  while((start_time + 1000) > gettime()) {
    self playrumbleonentity("zod_shield_juke");
    forward = anglesToForward(self getplayerangles());
    velocity = self getvelocity();
    predicted_pos = self.origin + (velocity * 0.1);
    self thread function_345e492a(predicted_pos, 96);
    wait(0.1);
  }
}

function function_345e492a(var_ebcc1e01, radius) {
  player = self;
  a_enemies_in_range = array::get_all_closest(var_ebcc1e01, getaiteamarray(level.zombie_team), undefined, undefined, radius);
  if(!isDefined(a_enemies_in_range) || a_enemies_in_range.size <= 0) {
    return;
  }
  foreach(enemy in a_enemies_in_range) {
    if(!isDefined(enemy) || (isDefined(enemy.var_96906507) && enemy.var_96906507)) {
      continue;
    }
    range_sq = distancesquared(enemy.origin, var_ebcc1e01);
    radius_sq = radius * radius;
    enemy.var_96906507 = 1;
    if(range_sq > radius_sq) {
      continue;
    }
    [[level.var_af9cd4ca]] - > waitinqueue(enemy);
    if(isDefined(enemy) && isalive(enemy)) {
      enemy dodamage(enemy.health + 6000, var_ebcc1e01, player, undefined, undefined, "MOD_MELEE", 0, level.var_ae0fff53);
      if(isvehicle(enemy)) {
        continue;
      }
      if(enemy.health <= 0) {
        n_random_x = randomfloatrange(-3, 3);
        n_random_y = randomfloatrange(-3, 3);
        player thread zm_audio::create_and_play_dialog("whelp", "punch");
        enemy startragdoll(1);
        enemy launchragdoll(100 * (vectornormalize((enemy.origin - self.origin) + (n_random_x, n_random_y, 100))), "torso_lower");
      }
    }
  }
}

function function_fa885ef2(e_player, ai_enemy) {
  if(e_player laststand::player_is_in_laststand()) {
    return;
  }
  if(ai_enemy.damageweapon === level.weapon_dragon_gauntlet || ai_enemy.damageweapon === level.var_ae0fff53) {
    return;
  }
  if(isDefined(e_player.var_cc844f4c) && e_player.var_cc844f4c) {
    return;
  }
  if(e_player.var_147067e4 === 0) {
    return;
  }
  if(isDefined(e_player.disable_hero_power_charging) && e_player.disable_hero_power_charging) {
    return;
  }
  e_player.var_8afc8427 = e_player gadgetpowerget(0);
  if(isDefined(e_player) && isDefined(e_player.var_8afc8427)) {
    if(isDefined(ai_enemy.heroweapon_kill_power)) {
      n_perk_factor = 1;
      if(e_player hasperk("specialty_overcharge")) {
        n_perk_factor = getdvarfloat("gadgetPowerOverchargePerkScoreFactor");
      }
      if(isDefined(ai_enemy.damageweapon)) {
        weapon = ai_enemy.damageweapon;
        if(issubstr(weapon.name, "elemental_bow_demongate") || issubstr(weapon.name, "elemental_bow_run_prison") || issubstr(weapon.name, "elemental_bow_storm") || issubstr(weapon.name, "elemental_bow_wolf_howl")) {
          n_perk_factor = 0.25;
        }
      }
      e_player.var_8afc8427 = e_player.var_8afc8427 + (n_perk_factor * ai_enemy.heroweapon_kill_power);
      e_player.var_8afc8427 = math::clamp(e_player.var_8afc8427, 0, 100);
      if(e_player.var_8afc8427 >= e_player.hero_power_prev) {
        e_player gadgetpowerset(0, e_player.var_8afc8427);
        e_player clientfield::set_player_uimodel("zmhud.swordEnergy", e_player.var_8afc8427 / 100);
        e_player clientfield::increment_uimodel("zmhud.swordChargeUpdate");
      }
    }
  }
}

function function_2f36d185(weapon) {
  self zm_hero_weapon::default_power_empty(weapon);
  self notify("stop_draining_hero_weapon");
  self notify("hash_b24d78f");
  self.var_8afc8427 = 0;
  self.hero_power = 0;
  if(isDefined(self.var_cc844f4c) && self.var_cc844f4c) {
    self function_22d7caeb();
  }
  current_weapon = self getcurrentweapon();
  if(self hasweapon(weapon) && current_weapon === weapon) {
    self setweaponammoclip(weapon, 0);
  }
  if(current_weapon === self.weapon_dragon_gauntlet || current_weapon === self.var_ae0fff53) {
    if(isDefined(self.var_a1ee595) && !issubstr(self.var_a1ee595.name, "minigun")) {
      self switchtoweapon(self.var_a1ee595);
    } else {
      self zm_weapons::switch_back_primary_weapon();
    }
  }
}

function function_cd7dbd9d(weapon) {
  self thread zm_equipment::show_hint_text(&"DLC3_WEAP_DRAGON_GAUNTLET_USE_HINT", 3);
  self zm_hero_weapon::set_hero_weapon_state(weapon, 2);
  self function_36f6c07f(2);
  self setweaponammoclip(weapon, weapon.clipsize);
  if(!(isDefined(self.var_fd007e55) && self.var_fd007e55)) {
    self thread zm_audio::create_and_play_dialog("whelp", "ready");
  }
  self.var_fd007e55 = 0;
}

function function_f5802b55() {
  if(isDefined(self.var_cc844f4c) && self.var_cc844f4c || isDefined(self.var_4bd1ce6b)) {
    return;
  }
  self.var_cc844f4c = 1;
  spawn_pos = self gettagorigin("tag_dragon_world");
  spawn_angles = self gettagangles("tag_dragon_world");
  var_42c06d64 = spawnvehicle(self.var_d15b9a33, spawn_pos, spawn_angles);
  if(isDefined(var_42c06d64)) {
    self.var_4bd1ce6b = var_42c06d64;
    var_42c06d64 ai::set_ignoreme(1);
    var_42c06d64 setignorepauseworld(1);
    var_42c06d64.owner = self;
    self thread zm_audio::create_and_play_dialog("whelp", "command");
    var_42c06d64 thread function_44ecb9cb();
    var_42c06d64 thread function_b80d5548();
    self thread function_1692b405();
  }
  self.var_d4b932e6 = gettime() + 1000;
}

function function_44ecb9cb() {
  self endon("death");
  self ghost();
  wait(0.15);
  self show();
}

function function_1692b405() {
  self notify("hash_22d7caeb");
  self endon("hash_22d7caeb");
  self waittill("entering_last_stand");
  self thread function_22d7caeb();
}

function function_22d7caeb() {
  self notify("hash_22d7caeb");
  self.var_cc844f4c = 0;
  if(isDefined(self.var_4bd1ce6b)) {
    var_42c06d64 = self.var_4bd1ce6b;
    var_42c06d64 notify("hash_22d7caeb");
    var_42c06d64.dragon_recall_death = 1;
    var_42c06d64.var_a0e2dfff = 1;
    var_42c06d64 kill();
  }
}

function function_b80d5548() {
  while(isDefined(self)) {
    if(!isDefined(self.owner) || self.owner laststand::player_is_in_laststand()) {
      self.dragon_recall_death = 1;
      self.var_a0e2dfff = 1;
      self kill();
    }
    wait(0.25);
  }
}

function function_cb315e40(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isDefined(attacker) && isplayer(attacker)) {
    if(isDefined(weapon) && weapon === level.weapon_dragon_gauntlet) {
      if(meansofdeath === "MOD_BURNED") {
        self.weapon_specific_fire_death_torso_fx = "dlc3/stalingrad/fx_fire_torso_zmb_green";
        self.weapon_specific_fire_death_sm_fx = "dlc3/stalingrad/fx_fire_generic_zmb_green";
        if(self.archetype === "zombie" || (isDefined(level.zombie_vars[attacker.team]) && (isDefined(level.zombie_vars[attacker.team]["zombie_insta_kill"]) && level.zombie_vars[attacker.team]["zombie_insta_kill"]))) {
          damage = self.health + 6000;
          attacker thread zm_audio::create_and_play_dialog("whelp", "flamethrower_kill");
          return damage;
        }
      }
      if(meansofdeath === "MOD_MELEE" && (!(isDefined(self.var_96906507) && self.var_96906507))) {
        damage = self.health + 6000;
        self.deathfunction = & function_cb6fb97;
        return damage;
      }
    }
    if(isDefined(weapon) && weapon === level.var_ae0fff53) {
      if(meansofdeath === "MOD_MELEE" && (!(isDefined(self.var_96906507) && self.var_96906507))) {
        damage = self.health + 6000;
        self.deathfunction = & function_d775fe77;
        return damage;
      }
    }
  }
  return -1;
}

function function_d775fe77(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  n_random_x = randomfloatrange(-3, 3);
  n_random_y = randomfloatrange(-3, 3);
  self startragdoll(1);
  self launchragdoll(100 * (vectornormalize((self.origin - attacker.origin) + (n_random_x, n_random_y, 100))), "torso_lower");
}

function function_cb6fb97(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  gibserverutils::gibhead(self);
  n_random_x = randomfloatrange(-3, 3);
  n_random_y = randomfloatrange(-3, 3);
  self startragdoll(1);
  self launchragdoll(100 * (vectornormalize((self.origin - attacker.origin) + (n_random_x, n_random_y, 100))), "torso_lower");
}

function function_a23fb854() {
  wait(0.05);
  level waittill("start_zombie_round_logic");
  wait(0.05);
  var_40c4a571 = self.weapon_dragon_gauntlet;
  equipment_id = var_40c4a571.name;
  str_cmd = ("" + equipment_id) + "";
  adddebugcommand(str_cmd);
  str_cmd = ("" + equipment_id) + "";
  adddebugcommand(str_cmd);
  str_cmd = ("" + equipment_id) + "";
  adddebugcommand(str_cmd);
  str_cmd = ("" + equipment_id) + "";
  adddebugcommand(str_cmd);
  str_cmd = "";
  adddebugcommand(str_cmd);
  str_cmd = "";
  adddebugcommand(str_cmd);
  while(true) {
    equipment_id = getdvarstring("");
    if(equipment_id != "") {
      foreach(player in getplayers()) {
        if(equipment_id == var_40c4a571.name) {
          player function_99a68dd();
        }
      }
      setdvar("", "");
    }
    equipment_id = getdvarstring("");
    if(equipment_id != "") {
      foreach(player in getplayers()) {
        if(equipment_id == var_40c4a571.name) {
          player gadgetpowerset(0, 100);
          player.var_8afc8427 = 100;
          player.hero_power = 100;
        }
      }
      setdvar("", "");
    }
    equipment_id = getdvarstring("");
    if(equipment_id != "") {
      foreach(player in getplayers()) {
        if(equipment_id == var_40c4a571.name) {
          player gadgetpowerset(0, 100);
          player.var_8afc8427 = 100;
          player.var_9e2dd97 = 1;
        }
      }
      setdvar("", "");
    }
    equipment_id = getdvarstring("");
    if(equipment_id != "") {
      foreach(player in getplayers()) {
        if(equipment_id == var_40c4a571.name) {
          player.var_9e2dd97 = 0;
        }
      }
      setdvar("", "");
    }
    string = getdvarstring("");
    if(string === "") {
      foreach(player in getplayers()) {
        player thread function_82f11e44();
      }
      setdvar("", "");
    }
    string = getdvarstring("");
    if(string === "") {
      foreach(player in getplayers()) {
        player function_c2e5ffc1();
      }
      setdvar("", "");
    }
    wait(0.05);
  }
}

function function_82f11e44() {
  self endon("disconnect");
  self endon("death");
  self endon("bled_out");
  self endon("hash_bd42c97e");
  while(true) {
    self enableinvulnerability();
    wait(0.5);
  }
}

function function_c2e5ffc1() {
  self notify("hash_bd42c97e");
  self disableinvulnerability();
}