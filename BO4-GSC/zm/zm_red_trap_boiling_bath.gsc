/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_red_trap_boiling_bath.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\scene_shared;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_traps;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;

#namespace zm_red_trap_boiling_bath;

init() {
  zm_traps::register_trap_basic_info("boiling_bath", &trap_activate, &trap_audio);
  zm_traps::register_trap_damage("boiling_bath", &trap_player_damage, &trap_damage);
  t_trap = getent("boiling_bath", "script_noteworthy");
  t_trap._trap_duration = 20;
  t_trap._trap_cooldown_time = 30;
  clientfield::register("actor", "boiling_trap_death_fx", 16000, 1, "int");
  level.var_4a0ddedd = 0;
  level.var_30ec2c9a = 0;
  level.var_d6ef5bfd = spawn("script_origin", (-2847, -1960, -20));
}

trap_activate() {
  level notify(#"hash_e2465be027280d7");
  level exploder::exploder("fxexp_trap_bath_switch");
  playsoundatposition("zmb_water_activate", level.var_d6ef5bfd.origin);
  level.var_d6ef5bfd playLoopSound(#"hash_7aab9873087e7a2d");
  level.var_c33299e2 = 0;
  level.var_bae901ce = 1;
  level function_922c05f();
  self thread zm_traps::trap_damage();
  wait self._trap_duration;
  playsoundatposition("zmb_water_deactivate", level.var_d6ef5bfd.origin);
  level.var_d6ef5bfd stoploopsound(0.5);
  level notify(#"hash_36bc97f51bb2bc8");
  level function_5bf5b467();
  self notify(#"trap_done");
  self thread trap_cooldown();
}

trap_cooldown() {
  self endon(#"death");
  self waittill(#"available");
  level exploder::stop_exploder("fxexp_trap_bath_switch");
}

trap_audio() {}

trap_player_damage(t_trap) {
  if(isplayer(self) && zm_utility::is_player_valid(self, 0, 0, 0) && !(isDefined(self.var_99557baf) && self.var_99557baf)) {
    self.var_99557baf = 1;
    level thread trap_damage_cooldown(self);
    self dodamage(25, self.origin);
  }
}

trap_damage(t_trap) {
  if(!isalive(self) || isDefined(self.var_99557baf) && self.var_99557baf || isDefined(self.b_trap_kill) && self.b_trap_kill) {
    return;
  }

  self.var_99557baf = 1;
  level thread trap_damage_cooldown(self);

  switch (self.archetype) {
    case #"zombie":
      n_percent = 35;
      break;
    case #"catalyst":
      n_percent = 35;
      break;
    case #"gegenees":
      n_percent = 5;
      break;
    case #"blight_father":
      n_percent = 5;
      break;
    default:
      n_percent = 35;
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

    if(self.archetype === #"zombie") {
      level.var_c33299e2++;
      level function_922c05f();
      self clientfield::set("boiling_trap_death_fx", 1);

      if(randomint(100) < 50 && !(isDefined(level.var_9b2dd86) && level.var_9b2dd86)) {
        level.var_9b2dd86 = 1;
        level thread function_49d1db63();
        self thread scene::play(#"aib_vign_cust_zm_red_zmb_venom_lqfy_blw_dth_01", "Shot 1", self);
      } else {
        self dodamage(n_damage, t_trap.origin);
      }
    } else {
      self dodamage(n_damage, t_trap.origin);
    }

    if(isDefined(level.var_bae901ce) && level.var_bae901ce) {
      if(isDefined(t_trap) && isplayer(t_trap.activated_by_player)) {
        t_trap.activated_by_player thread zm_vo::function_a2bd5a0c(#"hash_150ed78f0557df5f", 0.5, 1, 0, 1);
        level.var_bae901ce = undefined;
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
}

trap_damage_cooldown(e_victim) {
  wait 0.5;

  if(isDefined(e_victim)) {
    e_victim.var_99557baf = undefined;
  }
}

function_49d1db63() {
  wait 0.5;
  level.var_9b2dd86 = undefined;
}

function_922c05f() {
  if(level.var_c33299e2 < 4 && !level.var_30ec2c9a && !level.var_4a0ddedd) {
    level exploder::exploder("fxexp_trap_bath");
    return;
  }

  if(level.var_c33299e2 == 4 && !level.var_30ec2c9a || level.var_4a0ddedd) {
    level function_2b2e6b4();
    level exploder::exploder("fxexp_trap_bath_bloody_lvl1");
    level exploder::exploder("exp_lgt_bath_trap");
    level exploder::stop_exploder("fxexp_trap_bath");
    level thread function_3a067395("fxexp_trap_bath_bloody_lvl1");
    return;
  }

  if(level.var_c33299e2 == 10 || level.var_30ec2c9a) {
    level function_2b2e6b4();
    level exploder::exploder("fxexp_trap_bath_bloody_lvl2");
    level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl1");
    level thread function_3a067395("fxexp_trap_bath_bloody_lvl2");
  }
}

function_3a067395(str_exploder) {
  self notify("5a3476fe6548df85");
  self endon("5a3476fe6548df85");
  level endon(#"end_game", #"hash_e2465be027280d7");
  level waittill(#"hash_36bc97f51bb2bc8");

  if(str_exploder == "fxexp_trap_bath_bloody_lvl1") {
    level.var_4a0ddedd = 1;
    level exploder::exploder("fxexp_trap_bath_bloody_lvl1_linger");
    wait 30;
    level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl1_linger");
    level.var_4a0ddedd = 0;
    level exploder::stop_exploder("exp_lgt_bath_trap");
    return;
  }

  level.var_30ec2c9a = 1;
  level exploder::exploder("fxexp_trap_bath_bloody_lvl2_linger");
  wait 30;
  level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl2_linger");
  level.var_30ec2c9a = 0;
  level.var_4a0ddedd = 1;
  level exploder::exploder("fxexp_trap_bath_bloody_lvl1_linger");
  wait 30;
  level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl1_linger");
  level.var_4a0ddedd = 0;
  level exploder::stop_exploder("exp_lgt_bath_trap");
}

function_2b2e6b4() {
  level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl1_linger");
  level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl2_linger");
  level.var_4a0ddedd = 0;
  level.var_30ec2c9a = 0;
}

function_5bf5b467() {
  level exploder::stop_exploder("fxexp_trap_bath");
  level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl1");
  level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl2");
}