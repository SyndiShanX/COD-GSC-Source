/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_a_skeet_fink.gsc
***********************************************/

#include script_30ba61ad5559c51d;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\fx_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\zm\ai\zm_ai_nosferatu;
#include scripts\zm\zm_mansion;
#include scripts\zm\zm_mansion_silver_bullet;
#include scripts\zm\zm_mansion_special_rounds;
#include scripts\zm\zm_mansion_util;
#include scripts\zm_common\util\ai_dog_util;
#include scripts\zm_common\util\ai_werewolf_util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_crafting;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_items;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_power;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_sq;
#include scripts\zm_common\zm_sq_modules;
#include scripts\zm_common\zm_transformation;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;
#include scripts\zm_common\zm_weapons;

#namespace mansion_a_skeet_fink;

init() {
  clientfield::register("world", "" + #"hash_3b4f11e825b1f62b", 8000, 1, "int");
  clientfield::register("world", "" + #"hash_300ef0a8a2afdab9", 8000, 3, "int");
  clientfield::register("world", "" + #"hash_300eefa8a2afd906", 8000, 3, "int");
  clientfield::register("world", "" + #"hash_300eeea8a2afd753", 8000, 3, "int");
  clientfield::register("world", "" + #"hash_300eeda8a2afd5a0", 8000, 3, "int");
  clientfield::register("world", "" + #"hash_155407a9010f2b23", 8000, 1, "int");
  clientfield::register("world", "" + #"hash_70b438bea0135fc8", 8000, 3, "int");
  clientfield::register("scriptmover", "" + #"hash_693891d7b7f47419", 8000, 2, "int");
  clientfield::register("scriptmover", "" + #"hash_c2169a9806df05e", 8000, 1, "int");
  clientfield::register("vehicle", "" + #"hash_7a260c02e8c345c2", 8000, 1, "int");
  clientfield::register("actor", "" + #"hash_7a260c02e8c345c2", 8000, 1, "int");
  clientfield::register("world", "" + #"hash_5f0c4b68b2a6a75d", 16000, 1, "int");
  zm_sq_modules::function_d8383812("ee_asf_altar", 8000, #"a_skeet_fink_charge", &function_123eb361, &function_9bb74431, 1);
  register_steps();
  level.w_stake_knife = getweapon(#"stake_knife");
  level thread function_93bd3e32();
}

register_steps() {
  zm_sq::register(#"zm_mansion_a_skeet_fink", #"step_1", #"a_skeet_fink_step_1", &function_ff75fde6, &function_ff3b1efd);
  zm_sq::register(#"zm_mansion_a_skeet_fink", #"step_2", #"a_skeet_fink_step_2", &function_39e0636, &function_4fccc01f);
  zm_sq::register(#"zm_mansion_a_skeet_fink", #"step_3", #"a_skeet_fink_step_3", &function_15c82a8a, &function_62856590);
  zm_sq::register(#"zm_mansion_a_skeet_fink", #"step_4", #"a_skeet_fink_step_4", &function_2879cfed, &function_354f0b24);
}

function_93bd3e32() {
  level flagsys::wait_till("start_zombie_round_logic");
  clientfield::set("" + #"hash_3b4f11e825b1f62b", 1);

  foreach(s_unitrigger_stub in level.var_4fe2f84d[#"zblueprint_mansion_a_skeet_fink"]) {
    s_unitrigger_stub.locked = 1;
  }

  level.var_5e01899a = array(1, 2, 3, 4);
  level.var_5e01899a = array::randomize(level.var_5e01899a);
  function_f2971bfd();
  level flag::wait_till(#"open_pap");
  zm_sq::start(#"zm_mansion_a_skeet_fink", 1);
}

function_f2971bfd(b_respawn = 0) {
  level.var_6d3c8378 = struct::get_array(#"a_skeet_fink_obj", "targetname");

  if(!b_respawn) {
    level.var_6d3c8378 = array::randomize(level.var_6d3c8378);
  }

  foreach(n_index, var_d3018aec in level.var_6d3c8378) {
    switch (level.var_5e01899a[n_index]) {
      case 1:
        var_ca5e3125 = "p8_zm_man_carving_symbols_rock_03";
        break;
      case 2:
        var_ca5e3125 = "p8_zm_man_carving_symbols_rock_04";
        break;
      case 3:
        var_ca5e3125 = "p8_zm_man_carving_symbols_rock_01";
        break;
      case 4:
        var_ca5e3125 = "p8_zm_man_carving_symbols_rock_02";
        break;
    }

    var_d3018aec.var_740e1e0e = util::spawn_model(var_ca5e3125, var_d3018aec.origin, var_d3018aec.angles);
    var_d3018aec.script_int = n_index;

    if(b_respawn) {
      var_d3018aec.var_740e1e0e clientfield::set("" + #"hash_693891d7b7f47419", 2);
    }
  }
}

function_ff75fde6(var_a276c861) {
  zm_melee_weapon::init(#"stake_knife", #"stake_knife_flourish", undefined, "", undefined, "bowie", undefined);
  zm_loadout::register_melee_weapon_for_level(#"stake_knife");
  clientfield::set("" + #"hash_300ef0a8a2afdab9", level.var_5e01899a[0]);
  clientfield::set("" + #"hash_300eefa8a2afd906", level.var_5e01899a[1]);
  clientfield::set("" + #"hash_300eeea8a2afd753", level.var_5e01899a[2]);
  clientfield::set("" + #"hash_300eeda8a2afd5a0", level.var_5e01899a[3]);
  level.var_d5f74526 = util::spawn_model(#"tag_origin");
  level.var_6d3c8378 = array::sort_by_script_int(level.var_6d3c8378, 1);
  array::thread_all(level.var_6d3c8378, &function_abf0bf8c);

  if(!var_a276c861) {
    if(zm_utility::is_trials()) {
      while(true) {
        b_success = level.var_d5f74526 function_29a3aca4();
        wait 1;

        if(b_success) {
          break;
        }

        function_834e6f7();
        function_f2971bfd(1);
        level clientfield::set("" + #"hash_300ef0a8a2afdab9", level.var_5e01899a[0]);
        level clientfield::set("" + #"hash_300eefa8a2afd906", level.var_5e01899a[1]);
        level clientfield::set("" + #"hash_300eeea8a2afd753", level.var_5e01899a[2]);
        level clientfield::set("" + #"hash_300eeda8a2afd5a0", level.var_5e01899a[3]);
        level.var_6d3c8378 = array::sort_by_script_int(level.var_6d3c8378, 1);
        array::thread_all(level.var_6d3c8378, &function_abf0bf8c);
      }

      return;
    }

    b_success = level.var_d5f74526 function_29a3aca4();
    wait 1;

    if(!b_success) {
      function_834e6f7();
      level waittill(#"forever");
    }
  }
}

function_ff3b1efd(var_a276c861, ended_early) {
  function_834e6f7();
}

function_abf0bf8c() {
  self.var_740e1e0e endon(#"death");
  self.var_740e1e0e setCanDamage(1);
  self.var_740e1e0e.health = 9999;

  while(true) {
    s_waitresult = self.var_740e1e0e waittill(#"damage");

    if(isplayer(s_waitresult.attacker) && !zm_loadout::is_offhand_weapon(s_waitresult.weapon)) {
      if(isDefined(s_waitresult.position) && distancesquared(s_waitresult.position, self.origin) < 100) {
        level.var_d5f74526 notify(#"hash_5a5c7c802e5f3037", {
          #var_c8407ea2: self.script_int, 
          #var_740e1e0e: self.var_740e1e0e, 
          #attacker: s_waitresult.attacker
        });
        self.var_740e1e0e ghost();
        wait 1;

        if(isDefined(self.var_740e1e0e)) {
          self.var_740e1e0e delete();
        }

        return;
      }
    }

    self.var_740e1e0e.health = 9999;
  }
}

function_29a3aca4() {
  self endon(#"death");
  var_1fc5672 = 0;

  while(var_1fc5672 < level.var_6d3c8378.size) {
    s_waitresult = self waittill(#"hash_5a5c7c802e5f3037");

    if(s_waitresult.var_c8407ea2 !== var_1fc5672) {
      s_waitresult.var_740e1e0e clientfield::set("" + #"hash_693891d7b7f47419", 2);
      playsoundatposition("zmb_sk_stones_dest", s_waitresult.var_740e1e0e.origin);
      return false;
    }

    s_waitresult.var_740e1e0e clientfield::set("" + #"hash_693891d7b7f47419", 1);
    var_1fc5672++;
    playsoundatposition("zmb_sk_stones_dest_correct", s_waitresult.var_740e1e0e.origin);
  }

  s_waitresult.attacker thread zm_vo::function_a2bd5a0c(#"hash_307199a2e20f6edc", 1);
  return true;
}

function_834e6f7() {
  clientfield::set("" + #"hash_300ef0a8a2afdab9", 0);
  clientfield::set("" + #"hash_300eefa8a2afd906", 0);
  clientfield::set("" + #"hash_300eeea8a2afd753", 0);
  clientfield::set("" + #"hash_300eeda8a2afd5a0", 0);

  foreach(var_d3018aec in level.var_6d3c8378) {
    if(isDefined(var_d3018aec.var_740e1e0e)) {
      var_d3018aec.var_740e1e0e delete();
    }

    if(isDefined(var_d3018aec.t_damage)) {
      var_d3018aec.t_damage delete();
    }
  }
}

function_39e0636(var_a276c861) {
  level flag::init(#"hash_6df692c4073d421b");
  level clientfield::set("" + #"hash_155407a9010f2b23", 1);
  a_s_damage = struct::get_array(#"a_skeet_fink_damage", "targetname");
  a_s_damage = array::sort_by_script_int(a_s_damage, 1);

  foreach(s_damage in a_s_damage) {
    s_damage thread function_6941c919();
  }

  if(!var_a276c861) {
    b_result = level.var_d5f74526 function_1dc8ad86();

    if(isDefined(b_result) && b_result) {
      var_f2dc13a0 = struct::get("a_skeet_fink_chunk_start", "targetname");
      var_ae18fb21 = struct::get("a_skeet_fink_chunk", "targetname");
      var_5901d1c9 = struct::get(var_ae18fb21.target, "targetname");
      mdl_stake = util::spawn_model(#"hash_1a8e66a7966f8086", var_f2dc13a0.origin, var_f2dc13a0.angles);
      mdl_stake moveto(var_ae18fb21.origin, 3.6, 3.6);
      mdl_stake rotateto(var_ae18fb21.angles, 3.6, 3.6);
      wait 3.6 * 0.7;
      mdl_stake playSound("zmb_sk_tree_branch_fall");
      wait 3.6 * 0.3;
      mdl_stake clientfield::set("" + #"hash_486960f190957256", 1);
      playrumbleonposition("grenade_rumble", var_ae18fb21.origin);
      earthquake(0.5, 0.8, var_ae18fb21.origin, 512);
      var_ae18fb21.var_bbd0b2fb = spawn("trigger_radius_use", var_5901d1c9.origin, 0, 64, 72);
      var_ae18fb21.var_bbd0b2fb setcursorhint("HINT_NOICON");
      var_ae18fb21.var_bbd0b2fb triggerignoreteam();
      var_ae18fb21.var_bbd0b2fb setvisibletoall();
      var_ae18fb21.var_bbd0b2fb.mdl_stake = mdl_stake;

      if(!var_a276c861) {
        function_c4542a0c(var_ae18fb21.var_bbd0b2fb);
      }
    }
  }
}

function_4fccc01f(var_a276c861, ended_early) {
  level clientfield::set("" + #"hash_155407a9010f2b23", 0);
  a_s_damage = struct::get_array(#"a_skeet_fink_damage", "targetname");

  foreach(s_damage in a_s_damage) {
    if(isDefined(s_damage.t_damage)) {
      s_damage.t_damage delete();
    }
  }

  var_ae18fb21 = struct::get("a_skeet_fink_chunk", "targetname");

  if(isDefined(var_ae18fb21.var_bbd0b2fb)) {
    if(isDefined(var_ae18fb21.var_bbd0b2fb.mdl_stake)) {
      var_ae18fb21.var_bbd0b2fb.mdl_stake delete();
    }
  }

  if(isDefined(var_ae18fb21.var_bbd0b2fb)) {
    var_ae18fb21.var_bbd0b2fb delete();
  }

  if(var_a276c861 || ended_early) {
    level flag::set(#"hash_6df692c4073d421b");
  }
}

function_6941c919() {
  self.t_damage = spawn("trigger_damage_new", self.origin, 0, 8, 8);
  self.t_damage endon(#"death");
  w_shield = getweapon(#"zhield_dw");

  while(true) {
    s_waitresult = self.t_damage waittill(#"damage");
    w_base_weapon = zm_weapons::get_base_weapon(s_waitresult.weapon);

    if(isplayer(s_waitresult.attacker)) {
      if(w_base_weapon === level.w_bowie_knife) {
        level.var_d5f74526 notify(#"hash_15ccd1fdda38284a", {
          #var_c8407ea2: self.script_int, 
          #attacker: s_waitresult.attacker
        });
        continue;
      }

      if(s_waitresult.weapon === w_shield && s_waitresult.mod === "MOD_MELEE") {
        level.var_d5f74526 notify(#"rune_bashed", {
          #var_c8407ea2: self.script_int, 
          #attacker: s_waitresult.attacker
        });
      }
    }
  }
}

function_1dc8ad86() {
  self endon(#"death");
  var_1fc5672 = 0;
  b_fail = 0;

  while(true) {
    s_waitresult = self waittill(#"hash_15ccd1fdda38284a", #"rune_bashed");

    if(s_waitresult._notify == #"hash_15ccd1fdda38284a") {
      if(s_waitresult.var_c8407ea2 == var_1fc5672) {
        var_1fc5672++;
        level clientfield::set("" + #"hash_70b438bea0135fc8", var_1fc5672);
        playsoundatposition("zmb_sk_tree_hit_knife", (-440, 4200, -415));
      }

      continue;
    }

    if(s_waitresult._notify == #"rune_bashed") {
      if(s_waitresult.var_c8407ea2 == 0 && var_1fc5672 == 4) {
        playsoundatposition("zmb_sk_tree_hit_shield", (-440, 4200, -415));
        return 1;
      }
    }
  }
}

function_c4542a0c(t_trig) {
  level endon(#"end_game");
  t_trig endon(#"death");
  waitresult = t_trig waittill(#"trigger");
  e_player = waitresult.activator;
  e_player playSound("zmb_sk_tree_pickup");
  level flag::set(#"hash_6df692c4073d421b");
  e_player thread zm_vo::function_a2bd5a0c(#"hash_191dec8da1ad1b1f", 1);

  if(isDefined(t_trig.mdl_stake)) {
    t_trig.mdl_stake delete();
  }

  if(isDefined(t_trig)) {
    t_trig delete();
  }
}

function_15c82a8a(var_a276c861) {
  if(level flag::get(#"hash_6df692c4073d421b")) {
    var_4b9c76d7 = struct::get(#"a_skeet_fink_charge", "targetname");
    var_4b9c76d7.mdl_stake = util::spawn_model(#"hash_1a8e66a7966f8086", var_4b9c76d7.origin, var_4b9c76d7.angles);
    var_4b9c76d7.mdl_stake notsolid();
    var_4b9c76d7.mdl_stake hide();
    var_fb11d383 = struct::get(var_4b9c76d7.target, "targetname");
    var_4b9c76d7.var_360ebd9f = spawn("trigger_radius_use", var_fb11d383.origin, 0, 64, 72);
    var_4b9c76d7.var_360ebd9f setcursorhint("HINT_NOICON");
    var_4b9c76d7.var_360ebd9f triggerignoreteam();
    var_4b9c76d7.var_360ebd9f setvisibletoall();
    level clientfield::set("" + #"hash_5f0c4b68b2a6a75d", 1);

    if(!var_a276c861) {
      waitresult = var_4b9c76d7.var_360ebd9f waittill(#"trigger");
    }

    var_4b9c76d7.mdl_stake show();
    playsoundatposition("zmb_sk_tree_branch_place", var_4b9c76d7.mdl_stake.origin);
    level clientfield::set("" + #"hash_5f0c4b68b2a6a75d", 0);

    if(!var_a276c861) {
      level.var_f8babb50 = 0;
      zm_sq_modules::function_3f808d3d("ee_asf_altar");

      if(zm_utility::is_trials()) {
        var_4b9c76d7 thread function_eb6f728f();
      }

      var_4b9c76d7 waittill(#"hash_20911f4af4e75472");
      var_4b9c76d7.mdl_stake clientfield::set("" + #"hash_c2169a9806df05e", 1);
      waitresult = var_4b9c76d7.var_360ebd9f waittill(#"trigger");
      var_4b9c76d7.mdl_stake hide();
      var_4b9c76d7.mdl_stake clientfield::set("" + #"hash_c2169a9806df05e", 0);
    }
  }
}

private function_eb6f728f() {
  self endon(#"hash_20911f4af4e75472");
  w_stake_knife = getweapon(#"stake_knife");

  while(true) {
    if(level flag::get("round_reset")) {
      level flag::wait_till_clear("round_reset");
      wait 7;
    } else if(namespace_11abec5a::is_active(w_stake_knife)) {
      n_nosferatus = zm_ai_nosferatu::function_853b43e8();

      if(n_nosferatus < 10) {
        ai = zm_ai_nosferatu::function_74f25f8a(1);

        if(isDefined(ai)) {
          ai zm_score::function_acaab828();
        }
      }
    }

    wait 1;
  }
}

function_62856590(var_a276c861, ended_early) {
  var_4b9c76d7 = struct::get("a_skeet_fink_charge", "targetname");

  if(isDefined(var_4b9c76d7.mdl_stake)) {
    var_4b9c76d7.mdl_stake delete();
  }

  if(isDefined(var_4b9c76d7.var_360ebd9f)) {
    var_4b9c76d7.var_360ebd9f delete();
  }

  level thread function_ed59d8e4();
}

function_123eb361(var_88206a50, ent) {
  if(ent.archetype !== #"bat" && ent.archetype !== #"nosferatu") {
    return false;
  }

  s_inbetween = struct::get(var_88206a50.target, "targetname");
  var_51e4bd8d = getent(s_inbetween.target, "targetname");
  return isDefined(ent) && (isplayer(ent.attacker) || isplayer(ent.damageinflictor)) && ent istouching(var_51e4bd8d);
}

function_9bb74431(var_f0e6c7a2, ent) {
  level.var_f8babb50++;

  if(level.var_f8babb50 >= 10) {
    zm_sq_modules::function_2a94055d("ee_asf_altar");
    var_f0e6c7a2 notify(#"hash_20911f4af4e75472");
  }
}

function_ed59d8e4() {
  e_give_player = undefined;

  while(!isDefined(e_give_player)) {
    a_players = util::get_active_players(#"allies");

    foreach(e_player in a_players) {
      if(zm_utility::can_use(e_player)) {
        e_give_player = e_player;
        break;
      }
    }

    waitframe(1);
  }

  zm_items::player_pick_up(e_give_player, getweapon(#"hash_4aa70c9036cc210e"));
}

function_2879cfed(var_a276c861) {
  if(level flag::get(#"hash_6df692c4073d421b")) {
    foreach(s_unitrigger_stub in level.var_4fe2f84d[#"zblueprint_mansion_a_skeet_fink"]) {
      s_unitrigger_stub.locked = undefined;
    }

    zm::function_84d343d(#"stake_knife", &zm_mansion::function_78f60fd5);
    zm::register_vehicle_damage_callback(&zm_mansion::function_293e7d89);
    zm_crafting::function_d1f16587(#"zblueprint_mansion_a_skeet_fink", &function_36194a5f);
  }
}

function_354f0b24(var_a276c861, ended_early) {}

function_36194a5f(e_player) {
  unitrigger_stub = self.stub;
  unitrigger_stub.model setModel(#"wpn_t8_zm_knife_stake_world");
  unitrigger_stub.model show();
  zm_unitrigger::unregister_unitrigger(unitrigger_stub);
  e_player thread function_db526700();
  unitrigger_stub.prompt_and_visibility_func = &function_7aa50bb7;
  zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_422acb4c);
}

function_422acb4c() {
  self endon(#"death");

  while(true) {
    s_waitresult = self waittill(#"trigger");
    e_player = s_waitresult.activator;

    if(!e_player hasweapon(level.w_stake_knife)) {
      e_player thread function_db526700();
    }
  }
}

function_7aa50bb7(e_player) {
  self endon(#"death");
  can_use = zm_utility::can_use(e_player);
  can_use &= !e_player hasweapon(level.w_stake_knife);

  if(can_use) {
    self sethintstring(self.stub.blueprint.var_391591d0);
  } else {
    self sethintstring("");
  }

  return can_use;
}

function_db526700() {
  self thread zm_vo::function_a2bd5a0c(#"hash_445d4e233806a7cf", 1);
  self zm_melee_weapon::award_melee_weapon(#"stake_knife");
}