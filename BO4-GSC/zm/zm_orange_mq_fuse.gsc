/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_mq_fuse.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\animation_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_orange_pablo;
#include scripts\zm\zm_orange_util;
#include scripts\zm_common\util\ai_dog_util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_cleanup_mgr;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_sq;
#include scripts\zm_common\zm_sq_modules;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_orange_mq_fuse;

preload() {
  zm_sq_modules::function_d8383812(#"little_bird_1", 24000, "little_bird_1", &is_soul_capture, &soul_captured, 1);
  zm_sq_modules::function_d8383812(#"little_bird_2", 24000, "little_bird_2", &is_soul_capture, &soul_captured, 1);
  zm_sq_modules::function_d8383812(#"little_bird_3", 24000, "little_bird_3", &is_soul_capture, &soul_captured, 1);
  clientfield::register("scriptmover", "elemental_shard_glow", 24000, 1, "int");
  level flag::init(#"hash_4923165da58bf5cf");
}

main() {
  level init_transformers();
  level function_6bd2a719();
  level init_fuse();
}

init_fuse() {
  level.s_fuse = struct::get("tin_foil", "targetname");
  level.s_fuse.e_model = getent(level.s_fuse.target, "targetname");
  level.s_fuse.e_model hide();
}

init_transformers() {
  level.var_d02bca0 = 2;
  level flag::init(#"hash_5630cdbbb58f1b1e");
  level.var_9d5b2598 = getent("big_bird_wing_n", "targetname");
  level.var_e48733ef = getent("big_bird_wing_s", "targetname");
}

function_6bd2a719() {
  level.var_6b43507a = 3;
  a_s_generators = struct::get_array("little_bird", "targetname");

  for(i = 0; i < a_s_generators.size; i++) {
    a_s_generators[i].var_7944be4a = 0;
    a_s_generators[i].var_b9989e12 = hash(a_s_generators[i].script_noteworthy);
    a_s_generators[i].e_vol = getent(a_s_generators[i].target, "targetname");
  }

  level.a_s_generators = a_s_generators;
  e_shard = getent("chicken_nugget", "targetname");
  e_shard playLoopSound(#"hash_52058ae478647502");
  e_shard setscale(0.5);
  e_shard clientfield::set("elemental_shard_glow", 1);
}

function_742dfdb5(var_a276c861) {
  if(!var_a276c861) {
    level function_95dff91b();
    level.s_fuse.e_model show();

    if(level.var_98138d6b > 1) {
      wait 2;
      level.var_1c53964e zm_hms_util::function_6a0d675d("vox_fuse_lighthouse", 0, 0, 1);
    }

    level.var_9d5b2598 setCanDamage(1);
    level.var_9d5b2598 val::set("mq_fuse_step", "allowDeath", 0);
    level.var_9d5b2598 thread function_d6a4619a();
    level.var_e48733ef setCanDamage(1);
    level.var_e48733ef val::set("mq_fuse_step", "allowDeath", 0);
    level.var_e48733ef thread function_d6a4619a();

    while(level.var_d02bca0 > 0) {
      wait 1;
    }

    if(level.var_98138d6b > 1) {
      level.var_1c53964e zm_hms_util::function_6a0d675d("vox_fuse_partial_charge", 0, 0, 1);
    }
  }
}

function_95dff91b() {
  s_unitrigger = level.s_fuse zm_unitrigger::create("", 96);
  level.s_fuse function_afa2f621();
  level.s_fuse zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

function_afa2f621() {
  s_activation = self waittill(#"trigger_activated");
  playsoundatposition(#"hash_fdb4c0b271c6e36", self.origin);
}

setup_door_interact() {
  s_unitrigger = level.s_fuse zm_unitrigger::create("", 96);
  level.s_fuse door_think();
  level.s_fuse zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

door_think() {
  s_activation = self waittill(#"trigger_activated");
  level function_206702d8();

  if(level.var_98138d6b > 1) {
    level.var_1c53964e thread zm_hms_util::function_6a0d675d("vox_shard_reveal", 0, 0, 1);
  }
}

function_206702d8() {
  level flag::set(#"hash_778a2b8282d704f");
  e_door = getent("grover", "targetname");
  playsoundatposition("zmb_lighthouse_double_door", (-472, 1172, 315));
  e_door rotateyaw(148, 0.5, 0.1, 0.1);
  var_cee2ebbb = getent(e_door.target, "targetname");

  if(isDefined(var_cee2ebbb)) {
    var_cee2ebbb delete();
  }
}

function_16386d70() {
  e_shard = getent("chicken_nugget", "targetname");
  s_unitrigger = e_shard zm_unitrigger::create("", 96);
  e_shard shard_think();
  e_shard zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

shard_think() {
  s_activation = self waittill(#"trigger_activated");
  playsoundatposition(#"hash_2e9ec816b70bb70e", self.origin);
  self delete();
  level shard_vo(s_activation.e_who);
}

shard_vo(e_who) {
  e_who zm_orange_util::function_51b752a9("vox_shard_place", -1, 1, 0);
}

function_d6a4619a() {
  for(b_hidden = 0; !b_hidden; b_hidden = 1) {
    s_result = self waittill(#"damage");

    if(s_result.weapon.name === #"ww_tesla_sniper_t8" || s_result.weapon.name === #"ww_tesla_sniper_upgraded_t8") {
      if(self.targetname == "big_bird_wing_n") {
        exploder::exploder("fxexp_electric_arcs_fx_to_lighthouse_left");
      } else {
        exploder::exploder("fxexp_electric_arcs_fx_to_lighthouse_right");
      }

      self playSound(#"hash_47433d730d8027ed");
      e_target = getent(self.target, "targetname");
      level.var_d02bca0 -= 1;
      e_target hide();
      self setCanDamage(0);
    }
  }
}

function_9e34b0d4(var_a276c861, var_19e802fa) {
  if(var_a276c861 || var_19e802fa) {
    exploder::stop_exploder("fxexp_electric_arcs_fx_to_lighthouse_left");
    exploder::stop_exploder("fxexp_electric_arcs_fx_to_lighthouse_right");
    level.var_9d5b2598 setCanDamage(0);
    level.var_9d5b2598 hide();
    level.var_e48733ef setCanDamage(0);
    level.var_e48733ef hide();
    level.var_d02bca0 = 0;
    level.s_fuse.e_model show();
    return;
  }

  wait 3;
  exploder::stop_exploder("fxexp_electric_arcs_fx_to_lighthouse_left");
  exploder::stop_exploder("fxexp_electric_arcs_fx_to_lighthouse_right");
}

function_c723e684(var_a276c861) {
  if(!var_a276c861) {
    foreach(var_b4602d24 in level.a_s_generators) {
      level thread zm_sq_modules::function_3f808d3d(var_b4602d24.var_b9989e12);
    }

    while(level.var_6b43507a > 0) {
      wait 1;
    }

    if(level.var_98138d6b > 1) {
      level.var_1c53964e thread zm_hms_util::function_6a0d675d("vox_fuse_complete_charge", 0, 0, 1);
    }

    wait 3;
    level exploder::stop_exploder("fxexp_electric_arcs_fx_to_lighthouse_base_1");
    level exploder::stop_exploder("fxexp_electric_arcs_fx_to_lighthouse_base_2");
    level exploder::stop_exploder("fxexp_electric_arcs_fx_to_lighthouse_base_3");
    level setup_door_interact();
    level function_16386d70();
  }
}

is_soul_capture(var_88206a50, ent) {
  if(isDefined(ent) && ent.subarchetype === #"zombie_electric") {
    b_killed_by_player = isDefined(ent.attacker) && isplayer(ent.attacker) || isDefined(ent.damageinflictor) && isplayer(ent.damageinflictor);
    var_e93788f1 = var_88206a50.e_vol;
    return (b_killed_by_player && ent istouching(var_e93788f1));
  }

  return false;
}

soul_captured(var_f0e6c7a2, ent) {
  n_souls_required = 1;
  var_f0e6c7a2.var_7944be4a++;

  if(level flag::get(#"soul_fill")) {
    var_f0e6c7a2.var_7944be4a = n_souls_required;
  }

    if(var_f0e6c7a2.var_7944be4a >= n_souls_required) {
      var_f0e6c7a2 function_a66f0de2();
    }
}

function_a66f0de2() {
  switch (self.script_noteworthy) {
    case #"little_bird_1":
      level exploder::exploder("fxexp_electric_arcs_fx_to_lighthouse_base_2");
      break;
    case #"little_bird_2":
      level exploder::exploder("fxexp_electric_arcs_fx_to_lighthouse_base_3");
      break;
    case #"little_bird_3":
      level exploder::exploder("fxexp_electric_arcs_fx_to_lighthouse_base_1");
      break;
  }

  zm_sq_modules::function_2a94055d(self.var_b9989e12);
  playsoundatposition(#"hash_7cef2cb8d950a50", self.origin);
  level.var_6b43507a -= 1;
  self notify(#"hash_1f9b852104ab2c13");
}

function_3d5a45fb(var_a276c861, var_19e802fa) {
  if(var_a276c861 || var_19e802fa) {
    level.var_6b43507a = 0;
    level function_206702d8();
    getent("chicken_nugget", "targetname") delete();
  }
}