/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_hammer.gsc
***********************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\throttle_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\zm_lightning_chain;
#include scripts\zm_common\callbacks;
#include scripts\zm_common\trials\zm_trial_restrict_loadout;
#include scripts\zm_common\zm_armor;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_net;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_hammer;

autoexec __init__system__() {
  system::register(#"zm_weap_hammer", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("allplayers", "" + #"lightning_bolt_fx", 1, 1, "counter");
  clientfield::register("toplayer", "" + #"hero_hammer_armor_postfx", 1, 1, "counter");
  clientfield::register("scriptmover", "" + #"lightning_miss_fx", 1, 1, "int");
  clientfield::register("scriptmover", "" + #"hammer_storm", 1, 1, "int");
  clientfield::register("actor", "" + #"lightning_impact_fx", 1, 1, "int");
  clientfield::register("vehicle", "" + #"lightning_impact_fx", 1, 1, "int");
  clientfield::register("actor", "" + #"hero_hammer_melee_impact_trail", 1, 1, "counter");
  clientfield::register("vehicle", "" + #"hero_hammer_melee_impact_trail", 1, 1, "counter");
  clientfield::register("actor", "" + #"lightning_arc_fx", 1, 1, "int");
  clientfield::register("vehicle", "" + #"lightning_arc_fx", 1, 1, "int");
  clientfield::register("actor", "" + #"hero_hammer_stun", 1, 1, "int");
  clientfield::register("vehicle", "" + #"hero_hammer_stun", 1, 1, "int");
  clientfield::register("toplayer", "" + #"hammer_rumble", 1, 1, "counter");
  level.hero_weapon[#"hammer"][0] = getweapon(#"hero_hammer_lv1");
  level.hero_weapon[#"hammer"][1] = getweapon(#"hero_hammer_lv2");
  level.hero_weapon[#"hammer"][2] = getweapon(#"hero_hammer_lv3");
  level.var_af47ddb5 = getweapon(#"hash_76986baf9b6770c6");
  zm_loadout::register_hero_weapon_for_level("hero_hammer_lv1");
  zm_loadout::register_hero_weapon_for_level("hero_hammer_lv2");
  zm_loadout::register_hero_weapon_for_level("hero_hammer_lv3");
  level.var_b9efae55 = 22500;
  level.var_87fbf13 = 57600;
  level.var_5cc0eb9f = 10000;

  if(!isDefined(level.var_61d958e8)) {
    level.var_61d958e8 = new throttle();
    [[level.var_61d958e8]] - > initialize(3, 0.1);
  }

  callback::on_connect(&function_c3f6fd96);
  callback::on_disconnect(&on_player_disconnect);
  callback::function_4b58e5ab(&function_4b58e5ab);
  level._effect[#"lightning_eyes"] = #"hash_5aa1120d061d1f6c";
  ability_player::register_gadget_activation_callbacks(11, undefined, &hammer_off);
}

function_f820b73(weapon, var_e7c11b0c = 1) {
  if(weapon == level.hero_weapon[#"hammer"][2]) {
    return true;
  }

  if(weapon == level.hero_weapon[#"hammer"][1] && var_e7c11b0c < 3) {
    return true;
  }

  if(weapon == level.hero_weapon[#"hammer"][0] && var_e7c11b0c < 2) {
    return true;
  }

  return false;
}

private function_c3f6fd96() {
  self endon(#"disconnect");

  while(true) {
    waitresult = self waittill(#"weapon_change");
    wpn_cur = waitresult.weapon;
    wpn_prev = waitresult.last_weapon;

    if(isinarray(level.hero_weapon[#"hammer"], wpn_cur)) {
      self thread hammer_rumble(1);
      self thread function_4493c71b(wpn_cur);
      self thread activate_armor(wpn_cur);
    }

    if(wpn_cur == level.hero_weapon[#"hammer"][0]) {
      zm_hero_weapon::show_hint(wpn_cur, #"hash_10c853c67454fff6");
      continue;
    }

    if(wpn_cur == level.hero_weapon[#"hammer"][1]) {
      zm_hero_weapon::show_hint(wpn_cur, #"hash_2745ea06a4f8e7fd");
      self thread function_82466b73(wpn_cur);
      self thread function_478a4910(wpn_cur);
      continue;
    }

    if(wpn_cur == level.hero_weapon[#"hammer"][2]) {
      if(!self gamepadusedlast()) {
        self zm_hero_weapon::show_hint(wpn_cur, #"hash_78fab15695ef9758");
      } else {
        self zm_hero_weapon::show_hint(wpn_cur, #"hash_7b9c8543bd5b051c");
      }

      self thread function_82466b73(wpn_cur);
      self thread function_7399cd86(wpn_cur);
      self thread function_68ff89f7(wpn_cur);
    }
  }
}

function_1286cbf(s_params) {
  if(isplayer(s_params.eattacker) && function_f820b73(s_params.weapon, 1) && s_params.smeansofdeath == "MOD_MELEE") {
    player = s_params.eattacker;
    var_d695a618 = 50 - player zm_armor::get(#"hero_weapon_armor");

    if(var_d695a618 >= 10) {
      var_20694322 = 10;
    } else {
      var_20694322 = var_d695a618;
    }

    player set_armor(var_20694322);
  }
}

private function_82466b73(weapon) {
  self endon(#"weapon_change", #"disconnect", #"bled_out");

  while(true) {
    self waittill(#"weapon_melee_power_left");

    if(!zm_trial_restrict_loadout::function_5fbf572(weapon)) {
      continue;
    }

    weapon thread function_1b60eebf(self);
    weapon function_70dbf9d1(self);
  }
}

private function_70dbf9d1(player) {
  player endon(#"weapon_change", #"disconnect", #"bled_out");
  wait 0.5;
  player playSound(#"hash_334d4a903f12856f");
  v_start = player getEye();
  v_forward = player getweaponforwarddir();
  v_end = v_start + v_forward * 32;
  s_trace = groundtrace(v_start, v_end, 0, player);
  v_start = s_trace[#"position"] + (0, 0, 5);
  v_end = v_start + (0, 0, -200);
  s_trace = groundtrace(v_start, v_end, 0, player);
  n_offset = v_end[2] + 96;
  v_drop = zm_utility::function_b0eeaada(s_trace[#"position"]);

  if(!isDefined(v_drop) || n_offset >= player.origin[2]) {

      return;
  }

  while(!isDefined(player.e_storm)) {
    player.e_storm = util::spawn_model("tag_origin", player.origin);
    util::wait_network_frame();
  }

  player.e_storm.origin = v_drop[#"point"] + (0, 0, 20);
  player thread storm_think();
}

storm_think() {
  self endon(#"disconnect");
  self notify(#"storm_think");
  self endon(#"storm_think");
  waitframe(3);

  if(self.e_storm clientfield::get("" + #"hammer_storm")) {
    self.e_storm clientfield::set("" + #"hammer_storm", 0);
    util::wait_network_frame();
  }

  self.e_storm clientfield::set("" + #"hammer_storm", 1);
  self thread function_fd8e3604();
  wait 10;
  self.e_storm clientfield::set("" + #"hammer_storm", 0);
  util::wait_network_frame();
  self.e_storm delete();
}

private function_4493c71b(weapon) {
  self endon(#"weapon_change", #"disconnect", #"bled_out");

  while(true) {
    self waittill(#"weapon_melee_power");

    if(!zm_trial_restrict_loadout::function_5fbf572(weapon, 1)) {
      continue;
    }

    weapon function_439c9b04(self);
  }
}

function_1b60eebf(player) {
  player endon(#"weapon_change", #"disconnect");
  waitframe(15);
  player thread hammer_rumble(2);
  player thread function_1b29b59e(1, self);
}

function_439c9b04(player) {
  player endon(#"weapon_change", #"disconnect");
  waitframe(5);
  player thread function_1b29b59e(2, self);
  waitframe(11);
  player thread function_1b29b59e(3, self);
}

private activate_armor(weapon) {
  level callback::on_ai_killed(&function_1286cbf);
  self clientfield::increment_to_player("" + #"hero_hammer_armor_postfx");
  self waittill(#"weapon_change");
  level callback::remove_on_ai_killed(&function_1286cbf);
}

private set_armor(n_armor) {
  self thread zm_armor::add(#"hero_weapon_armor", n_armor, 50);
}

private function_7399cd86(weapon) {
  self endon(#"weapon_change", #"disconnect", #"bled_out");

  while(true) {
    self waittill(#"weapon_melee");

    if(!zm_trial_restrict_loadout::function_5fbf572(weapon)) {
      continue;
    }

    self thread lightning_bolt(weapon);
  }
}

function_9799924f(e_target, weapon = level.weaponnone, var_3e3892a7, v_to_target, n_damage) {
  if(!isalive(e_target)) {
    return;
  }

  if(!isDefined(e_target.zm_ai_category)) {
    return;
  }

  self thread hammer_rumble(4);

  if(isactor(e_target)) {
    [[level.var_61d958e8]] - > waitinqueue(e_target);

    if(!isDefined(e_target)) {
      return;
    }

    switch (e_target.zm_ai_category) {
      case #"popcorn":
      case #"basic":
      case #"enhanced":
        n_damage = e_target.health;
        break;
      case #"heavy":
        n_damage = int(e_target.maxhealth * 0.25);
        break;
      case #"miniboss":
        n_damage = int(e_target.maxhealth * 0.15);
        break;
    }

    e_target.no_gib = 1;
    e_target thread zm_hero_weapon::function_acee2761();
    e_target playSound(#"hash_774c028e67b9c337");
    self playsoundtoplayer(#"hash_45070d2fde57b8aa", self);
    e_target dodamage(n_damage, self.origin, self, self, "none", "MOD_MELEE", 0, weapon);

    if(e_target.health <= 0) {
      e_target clientfield::increment("" + #"hero_hammer_melee_impact_trail");
      e_target.ignoremelee = 1;

      switch (var_3e3892a7) {
        case 1:
          v_fling = (0, 0, -1) * 250;
          break;
        case 2:
        case 3:
          v_fling = v_to_target * 250;
          break;
      }

      self playrumbleonentity("damage_heavy");
      e_target zm_utility::function_ffc279(v_fling, self, undefined, weapon);
    } else {
      self playrumbleonentity("shotgun_fire");
    }

    return;
  }

  e_target dodamage(n_damage, self.origin, self, self, "none", "MOD_MELEE", 0, weapon);
}

function_1b29b59e(var_3e3892a7, weapon = level.weaponnone) {
  if(var_3e3892a7 == 1) {
    n_damage = 5000;
  } else {
    n_damage = 2500;
  }

  view_pos = self getEye();
  forward_view_angles = anglesToForward(self getplayerangles());

  if(forward_view_angles[2] < -0.7) {
    var_ccb70dad = (forward_view_angles[0], forward_view_angles[1], -0.25);
  } else {
    var_ccb70dad = forward_view_angles;
  }

  a_e_targets = zm_hero_weapon::function_7c3681f7();

  foreach(e_target in a_e_targets) {
    if(!isalive(e_target)) {
      continue;
    }

    test_origin = e_target getcentroid();
    dist_sq = distancesquared(view_pos, test_origin);

    if(isDefined(e_target.var_35d30dee)) {
      dist_to_check = e_target.var_35d30dee;
    } else {
      dist_to_check = level.var_b9efae55;
    }

    if(dist_sq > dist_to_check) {
      continue;
    }

    v_normal = vectornormalize(test_origin - self.origin);
    dot = vectordot(var_ccb70dad, v_normal);

    if(dot <= 0 && dist_sq > 1600) {
      continue;
    }

    if(0 == e_target damageconetrace(view_pos, self, forward_view_angles)) {
      continue;
    }

    n_random_x = randomfloatrange(-3, 3);
    n_random_y = randomfloatrange(-3, 3);
    var_61906722 = randomfloatrange(5, 20);
    v_ragdoll = vectornormalize(e_target.origin - self.origin + (n_random_x, n_random_y, var_61906722));

    if(isDefined(e_target.var_5554df1)) {
      self thread[[e_target.var_5554df1]](e_target, weapon, var_3e3892a7, v_ragdoll);
    } else {
      self thread function_9799924f(e_target, weapon, var_3e3892a7, v_ragdoll, n_damage);
    }

    waitframe(1);
  }
}

lightning_bolt(weapon) {
  self endon(#"disconnect");
  self playSound("wpn_hammer_bolt_fire");
  self thread hammer_rumble(3);
  waitframe(9);
  var_d571151f = vectortoangles(self getweaponforwarddir());
  var_d0407533 = self getweaponmuzzlepoint();
  level notify(#"lightning_ball_created", {
    #player: self
  });
  self notify(#"lightning_ball_created");

  if(!isDefined(var_d571151f)) {
    var_d571151f = (0, 0, 0);
  }

  e_ball_fx = util::spawn_model(#"tag_origin", var_d0407533 + anglesToForward(var_d571151f) * 60, var_d571151f);
  e_ball_fx.str_weapon = weapon;
  e_ball_fx.n_range = 250;
  e_ball_fx.n_damage_per_sec = 1000;
  e_ball_fx clientfield::set("" + #"lightning_miss_fx", 1);
  e_ball_fx playLoopSound(#"hash_15299b453cf5dd24", 0.5);
  v_end = var_d0407533 + anglesToForward(var_d571151f) * 600;
  trace = bulletTrace(var_d0407533, v_end, 0, self);

  if(trace[#"fraction"] != 1) {
    v_end = trace[#"position"];
  }

  if(isDefined(trace[#"entity"]) && function_ffa5b184(trace[#"entity"])) {
    self thread multiple_watcher(trace[#"entity"]);
  }

  if(isDefined(level.var_2e32e0bb)) {
    self thread function_f911e261();
  }

  staff_lightning_ball_speed = 600 / 8 * 5;
  n_dist = distance(e_ball_fx.origin, v_end);
  n_max_movetime_s = 600 / staff_lightning_ball_speed;
  n_movetime_s = n_dist / staff_lightning_ball_speed;
  n_leftover_time = n_max_movetime_s - n_movetime_s;
  e_ball_fx thread staff_lightning_ball_kill_zombies(self);
  e_ball_fx moveto(v_end, n_movetime_s);
  finished_playing = e_ball_fx lightning_ball_wait(n_leftover_time);

  if(isDefined(e_ball_fx)) {
    e_ball_fx stoploopsound(0.25);
    e_ball_fx playSound(#"hash_3f29c3ebe4a7417a");
    e_ball_fx notify(#"stop_killing");
    e_ball_fx notify(#"stop_debug_position");
    e_ball_fx clientfield::set("" + #"lightning_miss_fx", 0);
  }

  waitframe(1);

  if(isDefined(e_ball_fx)) {
    e_ball_fx delete();
  }
}

function_f911e261() {
  var_2ed6f142 = self getweaponmuzzlepoint();
  v_forward = self getweaponforwarddir();
  v_end = var_2ed6f142 + v_forward * 10000;
  a_trace = bulletTrace(var_2ed6f142, v_end, 0, self);
  level notify(#"hero_weapon_hit", {
    #player: self, 
    #e_entity: a_trace[#"entity"], 
    #var_80e17549: self.currentweapon, 
    #v_position: a_trace[#"position"]
  });
}

function_fd8e3604() {
  self endon(#"disconnect", #"bled_out", #"death", #"storm_think");
  self.e_storm endon(#"death");

  while(true) {
    a_e_targets = zm_hero_weapon::function_7c3681f7();
    array::thread_all(a_e_targets, &storm_check, self);
    wait 0.05;
  }
}

storm_check(player) {
  player endon(#"disconnect", #"bled_out", #"death", #"storm_think");
  player.e_storm endon(#"death");
  assert(isDefined(player));
  var_359c1a94 = 10000;
  var_75ccefac = player.e_storm.origin;

  if(!isalive(self) || isDefined(self.takedamage) && !self.takedamage) {
    return;
  }

  if(!isDefined(self.zm_ai_category)) {
    return;
  }

  if(self check_for_range(var_75ccefac, 96, var_359c1a94)) {
    self.var_74558e5 = 1;

    if(isalive(self)) {
      switch (self.zm_ai_category) {
        case #"heavy":
        case #"miniboss":
        case #"basic":
        case #"enhanced":
          self thread function_97429d68();
          break;
        case #"boss":
          self dodamage(1, var_75ccefac, player, player);
          break;
        case #"popcorn":
          self.var_bc973222 = 1;
          self dodamage(self.health + 100, var_75ccefac, player, player);
          break;
      }
    }
  }
}

function_97429d68() {
  self endon(#"death");

  if(isDefined(self.aat_turned) && self.aat_turned || isDefined(self.var_c6aafbdb) && self.var_c6aafbdb) {
    return;
  }

  self ai::stun();
  self.var_c6aafbdb = 1;

  if(!self clientfield::get("" + #"hero_hammer_stun")) {
    self clientfield::set("" + #"hero_hammer_stun", 1);

    if(self.archetype == #"zombie") {
      bhtnactionstartevent(self, "electrocute");
    }
  }

  wait 0.2;
  self ai::clear_stun();
  self clientfield::set("" + #"hero_hammer_stun", 0);
  self.var_c6aafbdb = 0;
}

check_for_range(v_attack_source, n_allowed_z_diff, n_radius_sq) {
  if(isalive(self)) {
    n_z_diff = self.origin[2] - v_attack_source[2];

    if(abs(n_z_diff) < n_allowed_z_diff) {
      if(distance2dsquared(self.origin, v_attack_source) < n_radius_sq) {
        return true;
      }
    }
  }

  return false;
}

function_4b58e5ab() {
  if(isDefined(self.var_74558e5) && self.var_74558e5) {
    self.var_74558e5 = 0;
    self clientfield::set("lc_fx", 0);
  }
}

multiple_watcher(var_b9812c05) {
  var_b9812c05 endon(#"death");
  var_b9812c05 dodamage(1000, self.origin, self, self);
}

staff_lightning_ball_kill_zombies(e_attacker) {
  self endon(#"death", #"stop_killing");

  while(true) {
    a_zombies = staff_lightning_get_valid_targets(e_attacker, self.origin);

    if(isDefined(a_zombies)) {
      foreach(zombie in a_zombies) {
        if(staff_lightning_is_target_valid(zombie)) {
          e_attacker thread staff_lightning_arc_fx(self, zombie);
          wait 0.05;
        }
      }
    }

    wait 0.05;
  }
}

staff_lightning_get_valid_targets(player, v_source) {
  a_enemies = [];
  a_zombies = zm_hero_weapon::function_7c3681f7();
  a_zombies = util::get_array_of_closest(v_source, a_zombies, undefined, undefined, self.n_range);

  if(isDefined(a_zombies)) {
    foreach(ai_zombie in a_zombies) {
      if(staff_lightning_is_target_valid(ai_zombie)) {
        a_enemies[a_enemies.size] = ai_zombie;
      }
    }
  }

  return a_enemies;
}

staff_lightning_arc_fx(e_source, ai_zombie) {
  if(isplayer(self)) {
    self endon(#"disconnect");
  }

  if(!isDefined(ai_zombie)) {
    return;
  }

  if(!bullet_trace_throttled(e_source.origin, ai_zombie.origin + (0, 0, 20), ai_zombie)) {
    return;
  }

  if(isDefined(e_source) && isDefined(ai_zombie) && isalive(ai_zombie)) {
    level thread staff_lightning_ball_damage_over_time(e_source, ai_zombie, self);
  }
}

staff_lightning_ball_damage_over_time(e_source, e_target, e_attacker) {
  if(isplayer(e_attacker)) {
    e_attacker endon(#"disconnect");
  }

  if(!isalive(e_target) || isDefined(e_target.takedamage) && !e_target.takedamage) {
    return;
  }

  e_target endon(#"death");

  if(!isDefined(e_target.zm_ai_category)) {
    return;
  }

  e_target clientfield::set("" + #"lightning_impact_fx", 1);

  if(e_target.archetype === #"zombie") {
    bhtnactionstartevent(e_target, "electrocute");
  }

  n_range_sq = e_source.n_range * e_source.n_range;
  e_target.is_being_zapped = 1;
  e_target clientfield::set("" + #"lightning_arc_fx", 1);

  if(isDefined(e_source)) {
    if(!isDefined(e_source.n_damage_per_sec)) {
      e_source.n_damage_per_sec = 1000;
    }

    n_damage_per_pulse = e_source.n_damage_per_sec * 0.25;
  }

  while(isDefined(e_source) && isalive(e_target)) {
    e_target thread stun_zombie();
    w_attack = e_source.str_weapon;
    wait 0.25;

    if(!isalive(e_target)) {
      break;
    }

    if(isalive(e_target) && isDefined(e_source)) {
      switch (e_target.zm_ai_category) {
        case #"basic":
        case #"enhanced":
          if(e_target.archetype != #"tiger" && e_target.archetype != #"catalyst") {
            e_target thread zombie_shock_eyes();
          }

          e_target.var_b7e3212 = 1;
          e_target thread function_1ca3b529(e_attacker, e_target.health + 100, w_attack, "MOD_ELECTROCUTED");
          break;
        default:
          e_target thread function_1ca3b529(e_attacker, n_damage_per_pulse, w_attack, "MOD_ELECTROCUTED");
          break;
      }
    }
  }

  if(isalive(e_target)) {
    e_target.is_being_zapped = 0;
    e_target clientfield::set("" + #"lightning_arc_fx", 0);
    e_target clientfield::set("" + #"lightning_impact_fx", 0);
  }
}

bullet_trace_throttled(v_start, v_end, e_ignore) {
  if(!isDefined(level.bullet_traces_this_frame)) {
    level thread _throttle_bullet_trace_think();
  }

  while(level.bullet_traces_this_frame >= 2) {
    util::wait_network_frame();
  }

  level.bullet_traces_this_frame++;
  return bullettracepassed(v_start, v_end, 0, e_ignore);
}

_throttle_bullet_trace_think() {
  do {
    level.bullet_traces_this_frame = 0;
    util::wait_network_frame();
  }
  while(true);
}

function_1ca3b529(e_attacker, n_amount, w_damage, str_mod) {
  self endon(#"death");
  [[level.var_61d958e8]] - > waitinqueue(self);

  if(isstring(w_damage)) {
    w_damage = getweapon(w_damage);
  }

  if(!isDefined(n_amount)) {
    return;
  }

  self.staff_dmg = w_damage;
  self dodamage(n_amount, self.origin, e_attacker, e_attacker, "none", str_mod, 0, w_damage);
}

lightning_ball_wait(n_lifetime_after_move) {
  level endon(#"lightning_ball_created");
  self waittill(#"movedone");
  wait n_lifetime_after_move;
  return true;
}

staff_lightning_is_target_valid(ai_zombie) {
  if(!isDefined(ai_zombie)) {
    return false;
  }

  if(isDefined(ai_zombie.is_being_zapped) && ai_zombie.is_being_zapped) {
    return false;
  }

  if(isDefined(ai_zombie.is_mechz) && ai_zombie.is_mechz) {
    return false;
  }

  if(isvehicle(ai_zombie) && isDefined(ai_zombie.takedamage) && !ai_zombie.takedamage) {
    return false;
  }

  return true;
}

stun_zombie() {
  self endon(#"death");

  if(self.zm_ai_category === #"miniboss" || self.zm_ai_category === #"boss") {
    return;
  }

  if(isDefined(self.is_electrocuted) && self.is_electrocuted) {
    return;
  }

  if(!(isDefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)) {
    return;
  }

  self ai::stun();
}

zombie_shock_eyes_network_safe(fx, entity, tag) {
  if(zm_net::network_entity_valid(entity)) {
    if(!(isDefined(self.head_gibbed) && self.head_gibbed) && !gibserverutils::isgibbed(self, 8)) {
      playFXOnTag(fx, entity, tag);
    }
  }
}

zombie_shock_eyes() {
  if(isDefined(self.head_gibbed) && self.head_gibbed || gibserverutils::isgibbed(self, 8)) {
    return;
  }

  if(self.zm_ai_category === #"miniboss" || self.zm_ai_category === #"boss" || isvehicle(self)) {
    return;
  }

  if(isDefined(self gettagorigin("j_eyeball_le"))) {
    zm_net::network_safe_init("shock_eyes", 2);
    zm_net::network_choke_action("shock_eyes", &zombie_shock_eyes_network_safe, level._effect[#"lightning_eyes"], self, "j_eyeball_le");
  }
}

on_player_disconnect() {
  self function_371c585a();
}

function_371c585a() {
  if(isDefined(self.e_storm)) {
    self.e_storm clientfield::set("" + #"hammer_storm", 0);
    self.e_storm delete();
  }
}

hammer_off(n_slot, w_hero) {
  self notify(#"storm_think");
  self function_371c585a();
}

hammer_rumble(n_index) {
  self endon(#"death");

  if(n_index) {
    waitframe(1);

    switch (n_index) {
      case 1:
        self playrumbleonentity("zm_weap_special_activate_rumble");
        break;
      case 2:
        playrumbleonposition("zm_weap_hammer_slam_rumble", self.origin);
        break;
      case 3:
        playrumbleonposition("zm_weap_hammer_storm_rumble", self.origin);
        break;
      case 4:
        self clientfield::increment_to_player("" + #"hammer_rumble", 4);
        break;
    }
  }
}

function_478a4910(w_hammer) {
  self endon(#"weapon_change", #"disconnect", #"bled_out");
  s_result = self waittill(#"weapon_melee_power_left");

  if(s_result.weapon == w_hammer) {
    self thread zm_audio::create_and_play_dialog(#"hero_level_2", #"hammer");
  }
}

function_68ff89f7(w_hammer) {
  self endon(#"weapon_change", #"disconnect", #"bled_out");
  s_result = self waittill(#"weapon_melee");

  if(s_result.weapon === w_hammer) {
    self thread zm_audio::create_and_play_dialog(#"hero_level_3", #"hammer");
  }
}