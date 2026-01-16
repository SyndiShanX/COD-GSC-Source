/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_65930a0d8e6a77c2.gsc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\scene_shared;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_traps;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;

#namespace namespace_f2050961;

init() {
  clientfield::register("toplayer", "" + #"hash_686e5c0d7af86361", 16000, 1, "int");
  zm_traps::register_trap_basic_info("venom_spray", &trap_activate, &trap_audio);
  zm_traps::register_trap_damage("venom_spray", &trap_player_damage, &trap_damage);
  t_trap = getent("venom_spray", "script_noteworthy");
  t_trap._trap_duration = 25;
  t_trap._trap_cooldown_time = 25;
  level.var_a19e2d89 = spawn("script_origin", (-873, 8877, 527));
}

trap_activate() {
  level exploder::exploder("fxexp_trap_venom_switch");
  self thread zm_traps::trap_damage();
  playsoundatposition(#"hash_1a3423b6a6b71330", level.var_a19e2d89.origin);
  level exploder::exploder("fxexp_trap_poison");
  level.var_a19e2d89 playLoopSound(#"hash_5ca6140cea7b68ca");
  level.var_7012847c = 1;
  self.var_67dd3af6 = 1;
  wait self._trap_duration;
  self.var_67dd3af6 = undefined;
  level exploder::stop_exploder("fxexp_trap_poison");
  level.var_a19e2d89 stoploopsound(0.5);
  self notify(#"trap_done");
  self thread trap_cooldown();
  playsoundatposition(#"hash_a9fa517453baef3", level.var_a19e2d89.origin);
}

trap_cooldown() {
  self endon(#"death");
  self waittill(#"available");
  level exploder::stop_exploder("fxexp_trap_venom_switch");
}

trap_audio() {}

trap_player_damage(t_trap) {
  self endon(#"death", #"disconnect");

  if(!(isDefined(self.is_in_acid) && self.is_in_acid) && isplayer(self) && zm_utility::is_player_valid(self, 0, 0, 0) && isDefined(t_trap.var_67dd3af6) && t_trap.var_67dd3af6) {
    self.is_in_acid = 1;
    self thread function_d5ee5b15();

    if(self issliding() || self issprinting()) {
      self.is_in_acid = undefined;
      self notify(#"hash_cbf6a8f73a300c8");
      return;
    }

    while(self istouching(t_trap) && isDefined(t_trap.var_67dd3af6) && t_trap.var_67dd3af6 && !self laststand::player_is_in_laststand()) {
      if(self.health <= 16) {
        self dodamage(self.health + 100, self.origin, undefined, t_trap);
      } else if(zm_utility::is_standard()) {
        self dodamage(self.maxhealth / 5.5, self.origin, undefined, t_trap);
      } else {
        self dodamage(self.maxhealth / 2.75, self.origin, undefined, t_trap);
      }

      wait 1;
    }

    self.is_in_acid = undefined;
  }
}

function_d5ee5b15() {
  self notify("65163045d66681f3");
  self endon("65163045d66681f3");
  self endon(#"disconnect");

  if(!(isDefined(self.var_31f1bba7) && self.var_31f1bba7)) {
    self.var_31f1bba7 = 1;
    self clientfield::set_to_player("" + #"hash_686e5c0d7af86361", 1);
  }

  wait 5;
  self.var_31f1bba7 = undefined;
  self clientfield::set_to_player("" + #"hash_686e5c0d7af86361", 0);
}

trap_damage(t_trap) {
  if(!isalive(self) || isDefined(self.var_7822ecda) && self.var_7822ecda || isDefined(self.b_trap_kill) && self.b_trap_kill) {
    return;
  }

  self.var_7822ecda = 1;
  level thread trap_damage_cooldown(self);
  b_stun = 0;

  switch (self.archetype) {
    case #"zombie":
      n_percent = 50;
      break;
    case #"catalyst":
      n_percent = 50;
      break;
    case #"gegenees":
      b_stun = 1;
      n_percent = 5;
      break;
    case #"blight_father":
      b_stun = 1;
      n_percent = 5;
      break;
    default:
      n_percent = 50;
      break;
  }

  if(isDefined(self.var_5c8ac43e) && self.var_5c8ac43e) {
    n_percent = 100;
  }

  n_percent /= 100;
  n_damage = int(self.maxhealth * n_percent);

  if(n_damage >= self.health) {
    level notify(#"trap_kill", {
      #e_victim: self, 
      #e_trap: t_trap
    });

    if(self.archetype === #"zombie" && randomint(100) < 80 && !(isDefined(level.var_b8d87306) && level.var_b8d87306)) {
      level.var_b8d87306 = 1;
      level thread function_49d1db63();
      self thread scene::play(#"aib_vign_cust_zm_red_zmb_venom_lqfy_abv_dth_01", "Shot 1", self);
    } else {
      self dodamage(n_damage, t_trap.origin);
    }

    if(isDefined(level.var_7012847c) && level.var_7012847c) {
      if(isDefined(t_trap) && isplayer(t_trap.activated_by_player)) {
        t_trap.activated_by_player thread zm_vo::function_a2bd5a0c(#"hash_37d475cd42f208a1", 0.5, 1, 0, 1);
        level.var_7012847c = undefined;
      }
    }

    if(isplayer(t_trap.activated_by_player)) {
      t_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
      t_trap.activated_by_player contracts::increment_zm_contract(#"contract_zm_trap_kills");
    }

    self.b_trap_kill = 1;
    return;
  }

  self dodamage(n_damage, t_trap.origin);

  if(b_stun && !(isDefined(self.var_6e294228) && self.var_6e294228)) {
    self.var_6e294228 = 1;
    self thread function_a023d131();
    self thread ai::stun(5);
  }
}

trap_damage_cooldown(e_victim) {
  wait 0.5;

  if(isDefined(e_victim)) {
    e_victim.var_7822ecda = undefined;
  }
}

function_49d1db63() {
  wait 0.5;
  level.var_b8d87306 = undefined;
}

function_a023d131() {
  self endon(#"death");
  wait 8;
  self.var_6e294228 = undefined;
}