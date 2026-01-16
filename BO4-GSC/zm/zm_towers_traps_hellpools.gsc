/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_towers_traps_hellpools.gsc
***********************************************/

#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\zm\zm_towers_util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_crafting;
#include scripts\zm_common\zm_items;
#include scripts\zm_common\zm_lockdown_util;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_traps;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_traps_hellpools;

autoexec __init__system__() {
  system::register(#"zm_traps_hellpools", &__init__, &__main__, undefined);
}

__init__() {
  level thread function_7cc8a854();
  callback::on_finalize_initialization(&init);
}

__main__() {}

init() {
  level flag::wait_till("all_players_spawned");
  zm_crafting::function_d1f16587(#"zblueprint_trap_hellpools", &function_55d14d78);
}

function_7cc8a854() {
  level.a_e_hellpools = getEntArray("mdl_hellpool_lava_grate", "targetname");

  foreach(e_hellpool in level.a_e_hellpools) {
    e_hellpool flag::init("activated");
    e_hellpool notsolid();
  }

  level.a_s_hellpool_cauldron = struct::get_array("s_hellpool_cauldron", "targetname");
  level.var_c07e6d20 = getEntArray("zm_towers_hellpool_ghost", "script_label");

  foreach(part in level.var_c07e6d20) {
    if(part trigger::is_trigger_of_type("trigger_use_new")) {
      part triggerenable(0);
      continue;
    }

    part hide();
  }

  mdl_clip = getent("mdl_acid_trap_cauldron_piece_clip", "targetname");
  mdl_clip notsolid();
  var_d58ee8b5 = getweapon(#"hash_72cba96681a7af18");
  zm_items::function_4d230236(var_d58ee8b5, &function_b54b9d5e);
  a_zombie_traps = getEntArray("zombie_trap", "targetname");
  level.var_482bcfef = array::filter(a_zombie_traps, 0, &function_9cc4d7b9);

  foreach(var_299f1fa2 in level.var_482bcfef) {
    var_299f1fa2 function_586dd237();
  }

  zm_traps::register_trap_basic_info("hellpool", &function_1d86d117, &function_722def57);
  zm_traps::register_trap_damage("hellpool", &function_506285c3, &function_db9410fa);
  level thread function_b589dae1();
  level thread function_a3661fef();
}

function_b589dae1() {
  level endon(#"end_game");
  level notify(#"hash_4cb0ebfa7040a193");
  level endon(#"hash_4cb0ebfa7040a193");

  while(true) {
    level waittill(#"host_migration_end");

    foreach(e_hellpool in level.a_e_hellpools) {
      e_hellpool notify(#"hash_5aa6001392300725");
    }
  }
}

private function_a3661fef() {
  level waittill(#"start_zombie_round_logic");
  s_blueprint = zm_crafting::function_b18074d0(#"zblueprint_trap_hellpools");

  while(true) {
    level waittill(#"component_collected");

    foreach(e_player in getplayers()) {
      if(zm_crafting::function_6d1e4410(e_player, s_blueprint)) {
        level scene::function_27f5972e(#"p8_fxanim_zm_towers_trap_acid_bundle");
        level notify(#"hash_476cae376318f3d5");
        return;
      }
    }
  }
}

function_55d14d78() {
  var_f6e18b6c = self.script_noteworthy;

  switch (var_f6e18b6c) {
    case #"odin":
      level.var_15783f81 = struct::get("zm_towers_hellpool_odin_scene", "script_noteworthy");
      level.var_15783f81 scene::init();
      var_c65eed8e = getEntArray("zm_towers_hellpool_odin", "script_noteworthy");

      foreach(part in var_c65eed8e) {
        if(part trigger::is_trigger_of_type("trigger_use_new")) {
          part triggerenable(1);
          part.script_string = "its_a_trap";
          zm_lockdown_util::function_d67bafb5(part, "lockdown_stub_type_crafting_tables");
          continue;
        }

        part show();
      }

      foreach(s_trap_button in level.a_s_trap_buttons) {
        if(s_trap_button.script_int === 3) {
          s_trap_button.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
        }
      }

      break;
    case #"zeus":
      level.var_15783f81 = struct::get("zm_towers_hellpool_zeus_scene", "script_noteworthy");
      level.var_15783f81 scene::init();
      var_c65eed8e = getEntArray("zm_towers_hellpool_zeus", "script_noteworthy");

      foreach(part in var_c65eed8e) {
        if(part trigger::is_trigger_of_type("trigger_use_new")) {
          part triggerenable(1);
          part.script_string = "its_a_trap";
          zm_lockdown_util::function_d67bafb5(part, "lockdown_stub_type_crafting_tables");
          continue;
        }

        part show();
      }

      foreach(s_trap_button in level.a_s_trap_buttons) {
        if(s_trap_button.script_int === 4) {
          s_trap_button.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
        }
      }

      break;
    case #"danu":
      level.var_15783f81 = struct::get("zm_towers_hellpool_danu_scene", "script_noteworthy");
      level.var_15783f81 scene::init();
      var_c65eed8e = getEntArray("zm_towers_hellpool_danu", "script_noteworthy");

      foreach(part in var_c65eed8e) {
        if(part trigger::is_trigger_of_type("trigger_use_new")) {
          part triggerenable(1);
          part.script_string = "its_a_trap";
          zm_lockdown_util::function_d67bafb5(part, "lockdown_stub_type_crafting_tables");
          continue;
        }

        part show();
      }

      foreach(s_trap_button in level.a_s_trap_buttons) {
        if(s_trap_button.script_int === 1) {
          s_trap_button.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
        }
      }

      break;
    case #"ra":
      level.var_15783f81 = struct::get("zm_towers_hellpool_ra_scene", "script_noteworthy");
      level.var_15783f81 scene::init();
      var_c65eed8e = getEntArray("zm_towers_hellpool_ra", "script_noteworthy");

      foreach(part in var_c65eed8e) {
        if(part trigger::is_trigger_of_type("trigger_use_new")) {
          part triggerenable(1);
          part.script_string = "its_a_trap";
          zm_lockdown_util::function_d67bafb5(part, "lockdown_stub_type_crafting_tables");
          continue;
        }

        part show();
      }

      foreach(s_trap_button in level.a_s_trap_buttons) {
        if(s_trap_button.script_int === 2) {
          s_trap_button.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
        }
      }

      break;
  }

  level thread zm_crafting::function_ca244624("zblueprint_trap_hellpools");
  level scene::function_f81475ae(#"p8_fxanim_zm_towers_trap_acid_bundle");
}

function_b54b9d5e(e_holder, w_item) {
  mdl_clip = getent("mdl_acid_trap_cauldron_piece_clip", "targetname");

  if(isDefined(mdl_clip)) {
    mdl_clip delete();
  }
}

function_9cc4d7b9(e_ent) {
  return e_ent.script_noteworthy == "hellpool";
}

function_586dd237() {
  self flag::init("activated");
}

function_722def57() {}

function_1d86d117() {
  self._trap_duration = 15;
  self._trap_cooldown_time = 60;

  if(isDefined(level.sndtrapfunc)) {
    level thread[[level.sndtrapfunc]](self, 1);
  }

  self notify(#"trap_activate");
  level notify(#"trap_activate", self);
  wait 1;
  self.activated_by_player thread function_45a2294f(self.script_string);

  foreach(e_trap in level.var_482bcfef) {
    if(e_trap.script_string === self.script_string) {
      e_trap thread zm_traps::trap_damage();
    }
  }

  self waittilltimeout(self._trap_duration, #"trap_deactivate");

  foreach(e_trap in level.var_482bcfef) {
    if(e_trap.script_string === self.script_string) {
      e_trap notify(#"trap_done");
    }
  }
}

function_45a2294f(str_id) {
  if(!isDefined(self)) {
    return;
  }

  self.b_activated = 1;

  foreach(e_hellpool in level.a_e_hellpools) {
    if(e_hellpool.script_string === str_id) {
      e_hellpool thread activate_trap(self);
    }
  }

  level notify(#"traps_activated", {
    #var_be3f58a: str_id
  });
  wait 15;
  level notify(#"traps_cooldown", {
    #var_be3f58a: str_id
  });
  n_cooldown = zm_traps::function_da13db45(60, self);
  wait n_cooldown;
  level notify(#"traps_available", {
    #var_be3f58a: str_id
  });
}

activate_trap(e_player) {
  if(!self flag::get("activated")) {
    if(isDefined(e_player)) {
      self.activated_by_player = e_player;
    }

    self flag::set("activated");
    self thread function_692db12();
    self waittilltimeout(15, #"hash_5aa6001392300725");
    self deactivate_trap();
  }
}

deactivate_trap() {
  if(self flag::get("activated")) {
    self function_efd16da2();
    self flag::clear("activated");
    self notify(#"deactivate");
  }
}

function_692db12() {
  foreach(s_cauldron in level.a_s_hellpool_cauldron) {
    if(s_cauldron.script_string === self.script_string) {
      self thread function_b327ce68(s_cauldron);
    }
  }
}

function_efd16da2() {
  foreach(s_cauldron in level.a_s_hellpool_cauldron) {
    if(s_cauldron.script_string === self.script_string) {
      self thread function_2e78a71b(s_cauldron);
    }
  }
}

function_b327ce68(s_cauldron) {
  s_cauldron thread scene::play("shot 1");
  level waittill(#"cauldron_rotate_complete");
  s_cauldron thread function_4c1fe94b();
}

function_2e78a71b(s_cauldron) {
  s_cauldron thread scene::play("shot 3");
}

function_4c1fe94b() {
  self thread scene::play("shot 2");
}

function_db9410fa(e_trap) {
  if(isactor(self) && !(isDefined(self.marked_for_death) && self.marked_for_death)) {
    self.marked_for_death = 1;

    if(isplayer(e_trap.activated_by_player)) {
      e_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
      e_trap.activated_by_player contracts::increment_zm_contract(#"contract_zm_trap_kills");
    }

    if(self.zm_ai_category == #"miniboss" || self.zm_ai_category == #"heavy") {
      self.marked_for_death = 0;
      return;
    }

    self clientfield::set("acid_trap_death_fx", 1);
    wait 0.75;

    if(isalive(self)) {
      level notify(#"trap_kill", {
        #e_victim: self, 
        #e_trap: e_trap
      });
      self dodamage(self.health + 666, self.origin, e_trap);
    }
  }
}

function_506285c3(t_damage) {
  self endoncallback(&function_6f5e73b5, #"death", #"disconnect");

  if(isalive(self) && !(isDefined(self.var_62b59590) && self.var_62b59590)) {
    self.var_62b59590 = 1;

    if(isplayer(self)) {
      if(!self laststand::player_is_in_laststand() && !level flag::get("round_reset")) {
        params = getstatuseffect(#"hash_baee445ed1d9b99");

        if(zm_utility::is_standard()) {
          params.dotdamage = int(params.dotdamage / 4);
        }

        if(zm_utility::is_ee_enabled() && self flag::get(#"hash_6757075afacfc1b4")) {
          params.dotdamage = int(params.dotdamage * 0.1);
        }

        self status_effect::status_effect_apply(params);
        self clientfield::set_to_player("acid_trap_postfx", 1);
      }

      self function_6f5e73b5();
    }
  }
}

function_6f5e73b5(var_c34665fc) {
  wait 1;

  if(isDefined(self)) {
    self.var_62b59590 = 0;
    self clientfield::set_to_player("acid_trap_postfx", 0);
  }
}