/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\trials\zm_trial_disable_buys.gsc
******************************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_traps;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_trial_util;
#include scripts\zm_common\zm_utility;

#namespace zm_trial_disable_buys;

autoexec __init__system__() {
  system::register(#"zm_trial_disable_buys", &__init__, undefined, undefined);
}

__init__() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  if(util::get_map_name() === "zm_red") {
    level.var_b5079c7c = array("exp_lgt_ar_accurate_t8", "exp_lgt_ar_fastfire_t8", "exp_lgt_ar_modular_t8", "exp_lgt_ar_stealth_t8", "exp_lgt_bowie", "exp_lgt_lmg_standard_t8", "exp_lgt_pistol_revolver_t8", "exp_lgt_pistol_standard_t8", "exp_lgt_shotgun_pump_t8", "exp_lgt_shotgun_trenchgun_t8", "exp_lgt_smg_accurate_t8", "exp_lgt_smg_fastfire_t8", "exp_lgt_smg_handling_t8", "exp_lgt_smg_standard_t8", "exp_lgt_sniper_quickscope_t8", "exp_lgt_tr_leveraction_t8", "exp_lgt_tr_longburst_t8", "exp_lgt_tr_powersemi_t8");
  } else {
    level.var_b5079c7c = array("exp_lgt_ar_accurate_t8", "exp_lgt_ar_fastfire_t8", "exp_lgt_ar_modular_t8", "exp_lgt_ar_stealth_t8", "exp_lgt_ar_stealth_t8_2", "exp_lgt_bowie", "exp_lgt_bowie_2", "exp_lgt_lmg_standard_t8", "exp_lgt_pistol_burst_t8", "exp_lgt_pistol_standard_t8", "exp_lgt_shotgun_pump_t8", "exp_lgt_shotgun_trenchgun_t8", "exp_lgt_smg_accurate_t8", "exp_lgt_smg_accurate_t8_2", "exp_lgt_smg_drum_pistol_t8", "exp_lgt_smg_fastfire_t8", "exp_lgt_smg_handling_t8", "exp_lgt_smg_standard_t8", "exp_lgt_sniper_quickscope_t8", "exp_lgt_tr_leveraction_t8", "exp_lgt_tr_longburst_t8", "exp_lgt_tr_powersemi_t8");
  }

  zm_trial::register_challenge(#"disable_buys", &on_begin, &on_end);
}

private on_begin(var_a29299fb) {
  if(!(isDefined(level.buys_disabled) && level.buys_disabled)) {
    level.buys_disabled = 1;
    level notify(#"disable_buys");
    function_6fd56055();
    function_a4284cb4();
    hide_magicbox();
    zm_trial_util::function_eea26e56();
    level.var_a29299fb = var_a29299fb;

    if(!isDefined(level.var_a29299fb)) {
      function_d5e17413();
    }

    zm_trial_util::function_8036c103();
    hide_traps();
  }
}

private on_end(round_reset) {
  assert(isDefined(level.buys_disabled) && level.buys_disabled);

  if(!round_reset) {
    function_fa70c8c4();
    function_c606ef4b();
    show_magicbox();
    zm_trial_util::function_ef1fce77();
    function_c348adcc();
    zm_trial_util::function_302c6014();
    level.buys_disabled = undefined;
    show_traps();
  }
}

is_active() {
  challenge = zm_trial::function_a36e8c38(#"disable_buys");
  return isDefined(challenge);
}

function_8327d26e() {
  if(!zm_trial::is_trial_mode()) {
    return;
  }

  self endon(#"chest_accessed");
  self.var_7672d70d = 0;

  if(isDefined(self.zbarrier)) {
    self.zbarrier.var_7672d70d = 0;
  }

  level waittill(#"disable_buys");

  if(level flag::get("moving_chest_now")) {
    return;
  }

  self.var_7672d70d = 1;

  if(isDefined(self.zbarrier)) {
    self.zbarrier.var_7672d70d = 1;
    self.zbarrier notify(#"box_hacked_respin");

    if(isDefined(self.zbarrier.weapon_model)) {
      self.zbarrier.weapon_model notify(#"kill_weapon_movement");
    }

    if(isDefined(self.zbarrier.weapon_model_dw)) {
      self.zbarrier.weapon_model_dw notify(#"kill_weapon_movement");
    }
  }

  wait 0.1;
  self notify(#"trigger", {
    #activator: level
  });
}

private function_6fd56055() {
  assert(isDefined(level._spawned_wallbuys));

  foreach(wallbuy in level._spawned_wallbuys) {
    target_struct = struct::get(wallbuy.target, "targetname");

    if(isDefined(target_struct) && isDefined(target_struct.target)) {
      wallbuy_fx = getent(target_struct.target, "targetname");

      if(isDefined(wallbuy_fx)) {
        wallbuy_fx ghost();
      }
    }

    model = struct::get(wallbuy.target, "targetname");

    if(isDefined(model) && isDefined(model.target)) {
      var_393a819e = getent(model.target, "targetname");

      if(isDefined(var_393a819e)) {
        var_393a819e ghost();
      }
    }

    if(isDefined(wallbuy.trigger_stub) && isDefined(wallbuy.trigger_stub.clientfieldname)) {
      assert(!isDefined(wallbuy.var_d6cca569));
      wallbuy.var_d6cca569 = level clientfield::get(wallbuy.trigger_stub.clientfieldname);
      level clientfield::set(wallbuy.trigger_stub.clientfieldname, 0);
    }
  }

  foreach(var_2b84085b in level.var_b5079c7c) {
    level exploder::exploder(var_2b84085b);
  }
}

private function_fa70c8c4() {
  assert(isDefined(level._spawned_wallbuys));

  foreach(wallbuy in level._spawned_wallbuys) {
    target_struct = struct::get(wallbuy.target, "targetname");

    if(isDefined(target_struct) && isDefined(target_struct.target)) {
      wallbuy_fx = getent(target_struct.target, "targetname");

      if(isDefined(wallbuy_fx)) {
        wallbuy_fx show();
      }
    }

    model = struct::get(wallbuy.target, "targetname");

    if(isDefined(model) && isDefined(model.target)) {
      var_393a819e = getent(model.target, "targetname");

      if(isDefined(var_393a819e)) {
        var_393a819e show();
      }
    }

    if(isDefined(wallbuy.trigger_stub) && isDefined(wallbuy.trigger_stub.clientfieldname)) {
      assert(isDefined(wallbuy.var_d6cca569));
      level clientfield::set(wallbuy.trigger_stub.clientfieldname, wallbuy.var_d6cca569);
      wallbuy.var_d6cca569 = undefined;
    }
  }

  foreach(var_2b84085b in level.var_b5079c7c) {
    level exploder::exploder_stop(var_2b84085b);
  }
}

private _open_arcs(blocker) {
  if(isDefined(blocker.script_noteworthy) && (blocker.script_noteworthy == "electric_door" || blocker.script_noteworthy == "local_electric_door")) {
    return false;
  }

  return true;
}

private function_fcf197fa(targetname, show) {
  blockers = getEntArray(targetname, "targetname");

  if(isDefined(blockers)) {
    foreach(blocker in blockers) {
      if(isDefined(blocker.target) && _open_arcs(blocker)) {
        var_c819ac8 = getEntArray(blocker.target, "targetname");

        if(isDefined(var_c819ac8)) {
          foreach(var_1d6a70e8 in var_c819ac8) {
            if(isDefined(var_1d6a70e8.objectid) && !var_1d6a70e8 zm_utility::function_1a4d2910()) {
              switch (var_1d6a70e8.objectid) {
                case #"symbol_back_debris":
                case #"symbol_front_power":
                case #"symbol_back":
                case #"symbol_front":
                case #"symbol_front_debris":
                case #"symbol_back_power":
                  if(show) {
                    var_1d6a70e8 show();
                  } else {
                    var_1d6a70e8 ghost();
                  }

                  break;
                default:
                  break;
              }
            }
          }
        }
      }
    }
  }
}

private function_a4284cb4() {
  function_fcf197fa("zombie_door", 0);
  function_fcf197fa("zombie_debris", 0);
}

private function_c606ef4b() {
  function_fcf197fa("zombie_door", 1);
  function_fcf197fa("zombie_debris", 1);
}

private function_4516d298() {
  level endon(#"end_game");

  while(level flag::get("moving_chest_now")) {
    waitframe(1);
  }
}

private function_610df6d() {
  level endon(#"end_game");

  while(isDefined(self._box_open) && self._box_open) {
    waitframe(1);
  }
}

private hide_magicbox() {
  function_4516d298();

  if(level.chest_index != -1) {
    chest = level.chests[level.chest_index];
    chest function_610df6d();
    chest zm_magicbox::hide_chest(1);
  }
}

private show_magicbox() {
  function_4516d298();

  if(level.chest_index != -1) {
    chest = level.chests[level.chest_index];
    chest zm_magicbox::show_chest();
  }
}

private function_d5e17413() {
  if(!isDefined(level.var_5bfd847e) || !level flag::exists(level.var_5bfd847e)) {
    return;
  }

  level clientfield::set("fasttravel_exploder", 0);
}

private function_c348adcc() {
  if(!isDefined(level.var_5bfd847e) || !level flag::exists(level.var_5bfd847e)) {
    return;
  }

  if(level flag::get(level.var_5bfd847e)) {
    level clientfield::set("fasttravel_exploder", 1);
  }
}

private hide_traps() {
  a_t_traps = getEntArray("zombie_trap", "targetname");
  str_text = #"hash_55d25caf8f7bbb2f";

  foreach(t_trap in a_t_traps) {
    t_trap zm_traps::trap_set_string(str_text);
  }

  level notify(#"traps_cooldown");
}

private show_traps() {
  a_t_traps = getEntArray("zombie_trap", "targetname");
  str_text = zm_utility::function_d6046228(#"hash_23c1c09e94181fdb", #"hash_6e8ef1b690e98e51");

  foreach(t_trap in a_t_traps) {
    t_trap zm_traps::trap_set_string(str_text, t_trap.zombie_cost);
  }

  level notify(#"traps_available");
}