/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_pack_a_punch.gsc
***********************************************/

#include script_301f64a4090c381a;
#include scripts\core_common\aat_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\demo_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\potm_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;
#include scripts\zm_common\trials\zm_trial_disable_buys;
#include scripts\zm_common\trials\zm_trial_disable_upgraded_weapons;
#include scripts\zm_common\util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_camos;
#include scripts\zm_common\zm_challenges;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_power;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_pack_a_punch;

autoexec __init__system__() {
  system::register(#"zm_pack_a_punch", &__init__, &__main__, undefined);
}

__init__() {
  level flag::init("pap_machine_active");
  zm_pap_util::init_parameters();
  zm_pap_util::function_a81f02e5();
  clientfield::register("zbarrier", "pap_working_fx", 1, 1, "int");
  clientfield::register("zbarrier", "pap_idle_fx", 1, 1, "int");
  clientfield::register("world", "pap_force_stream", 1, 1, "int");

  if(!isDefined(level.var_a3b71a00)) {
    level.var_a3b71a00 = 0.5;
  }

  if(zm_utility::get_story() == 1) {
    function_6309e7d5();
    return;
  }

  if(zm_utility::get_story() == 2) {
    function_c6d69354();
  }
}

__main__() {
  if(!isDefined(level.pap_zbarrier_state_func)) {
    level.pap_zbarrier_state_func = &process_pap_zbarrier_state;
  }

  if(zm_custom::function_901b751c(#"zmpapenabled") == 0) {
    var_ed82708a = getEntArray("zm_pack_a_punch", "targetname");

    foreach(var_4db9b7a6 in var_ed82708a) {
      if(isDefined(var_4db9b7a6.unitrigger_stub)) {
        zm_unitrigger::unregister_unitrigger(var_4db9b7a6.unitrigger_stub);
      }
    }

    return;
  }

  spawn_init();
  old_packs = getEntArray("zombie_vending_upgrade", "targetname");

  for(i = 0; i < old_packs.size; i++) {
    var_5d5bdd1b[var_5d5bdd1b.size] = old_packs[i];
  }
}

private spawn_init() {
  if(isDefined(level.var_7199d651) && level.var_7199d651) {
    function_a2e4892a();
  }

  zbarriers = getEntArray("zm_pack_a_punch", "targetname");
  var_302c8250 = getEntArray("pap_bullet_mesh", "script_noteworthy");
  var_4aaf6234 = getEntArray("pap_pedestal_bullet_mesh", "script_noteworthy");

  for(i = 0; i < zbarriers.size; i++) {
    if(!zbarriers[i] iszbarrier()) {
      continue;
    }

    if(!isDefined(level.pack_a_punch.interaction_height)) {
      level.pack_a_punch.interaction_height = 35;
    }

    if(!isDefined(level.pack_a_punch.var_11fdb083)) {
      level.pack_a_punch.var_11fdb083 = 16;
    }

    if(!isDefined(level.pack_a_punch.var_c89ce627)) {
      level.pack_a_punch.var_c89ce627 = 64;
    }

    if(!isDefined(level.pack_a_punch.var_280e196b)) {
      level.pack_a_punch.var_280e196b = 32;
    }

    if(!isDefined(level.pack_a_punch.interaction_trigger_height)) {
      level.pack_a_punch.interaction_trigger_height = 70;
    }

    var_45fd85a3 = vectornormalize(anglestoright(zbarriers[i].angles)) * level.pack_a_punch.var_11fdb083;

    if(!isDefined(level.pack_a_punch.var_fcdf795b)) {
      level.pack_a_punch.var_fcdf795b = var_45fd85a3 + (0, 0, level.pack_a_punch.interaction_height);
    }

    zbarriers[i].unitrigger_stub = spawnStruct();
    zbarriers[i].unitrigger_stub.targetname = "pap_machine_stub";
    zbarriers[i].unitrigger_stub.pap_machine = zbarriers[i];
    zbarriers[i].unitrigger_stub.origin = zbarriers[i].origin + level.pack_a_punch.var_fcdf795b;
    zbarriers[i].unitrigger_stub.angles = zbarriers[i].angles;
    zbarriers[i].unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    zbarriers[i].unitrigger_stub.cursor_hint = "HINT_NOICON";
    zbarriers[i].unitrigger_stub.script_width = level.pack_a_punch.var_280e196b;
    zbarriers[i].unitrigger_stub.script_length = level.pack_a_punch.var_c89ce627;
    zbarriers[i].unitrigger_stub.script_height = level.pack_a_punch.interaction_trigger_height;

    if(isDefined(level.var_1ffedde8) && level.var_1ffedde8) {
      zbarriers[i].unitrigger_stub.require_look_at = 0;
      zbarriers[i].unitrigger_stub.require_look_toward = 0;
    } else {
      zbarriers[i].unitrigger_stub.require_look_at = 1;
      zbarriers[i].unitrigger_stub.require_look_toward = 0;
    }

    zbarriers[i].unitrigger_stub.prompt_and_visibility_func = &zm_pap_util::update_hint_string;
    zbarriers[i] flag::init("Pack_A_Punch_on");
    zbarriers[i] flag::init("Pack_A_Punch_off");
    zbarriers[i] flag::init("pap_waiting_for_user");
    zbarriers[i] flag::init("pap_taking_gun");
    zbarriers[i] flag::init("pap_offering_gun");
    zbarriers[i] flag::init("pap_in_retrigger_delay");

    if(zm_utility::get_story() == 2) {
      foreach(var_b6758aab in var_302c8250) {
        if(var_b6758aab.origin === zbarriers[i].origin) {
          collision = var_b6758aab;
          collision notsolid();
          break;
        }
      }

      foreach(var_434a2015 in var_4aaf6234) {
        if(distancesquared(var_434a2015.origin, zbarriers[i].origin) < 256) {
          var_767a3ca9 = var_434a2015;
          var_767a3ca9 notsolid();
          break;
        }
      }
    } else {
      collision = spawn("script_model", zbarriers[i].origin, 1);
      collision.angles = zbarriers[i].angles;
      collision setModel(#"zm_collision_perks1");
      collision.script_noteworthy = "clip";
      collision disconnectpaths();
    }

    zbarriers[i].unitrigger_stub.clip = collision;
    zbarriers[i].unitrigger_stub.zbarrier = zbarriers[i];

    if(isDefined(var_767a3ca9)) {
      zbarriers[i].unitrigger_stub.var_1f0dbe42 = var_767a3ca9;
      var_767a3ca9 = undefined;
    }

    packa_rollers = spawn("script_origin", zbarriers[i].unitrigger_stub.origin);
    packa_timer = spawn("script_origin", zbarriers[i].unitrigger_stub.origin);
    packa_rollers linkto(zbarriers[i]);
    packa_timer linkto(zbarriers[i]);
    zbarriers[i].packa_rollers = packa_rollers;
    zbarriers[i].packa_timer = packa_timer;
    zbarriers[i] zbarrierpieceuseattachweapon(3);
    powered_on = get_start_state();

    if(!powered_on) {
      zbarriers[i] thread function_615ef6fe();
    } else {
      zbarriers[i] thread pap_power_on_init();
    }

    if(isDefined(level.pack_a_punch.custom_power_think)) {
      zbarriers[i] thread[[level.pack_a_punch.custom_power_think]](powered_on);
    } else {
      zbarriers[i].powered = zm_power::add_powered_item(&turn_on, &turn_off, &function_64416c32, &function_e13fa347, 0, powered_on, zbarriers[i]);
      zbarriers[i] thread toggle_think(powered_on);
    }

    if(!isDefined(level.pack_a_punch.trigger_stubs)) {
      level.pack_a_punch.trigger_stubs = [];
    } else if(!isarray(level.pack_a_punch.trigger_stubs)) {
      level.pack_a_punch.trigger_stubs = array(level.pack_a_punch.trigger_stubs);
    }

    level.pack_a_punch.trigger_stubs[level.pack_a_punch.trigger_stubs.size] = zbarriers[i].unitrigger_stub;
  }
}

function_a2e4892a() {
  var_b80f0510 = getEntArray("zm_pack_a_punch", "targetname");

  if(var_b80f0510.size == 0) {
    return;
  }

  var_cf6166dd = [];

  foreach(s_pap in var_b80f0510) {
    if(isDefined(s_pap.script_int) && s_pap.script_int > -1) {
      if(!isDefined(var_cf6166dd)) {
        var_cf6166dd = [];
      } else if(!isarray(var_cf6166dd)) {
        var_cf6166dd = array(var_cf6166dd);
      }

      var_cf6166dd[var_cf6166dd.size] = s_pap;
    }
  }

  if(var_cf6166dd.size > 1) {
    var_6d002bb1 = array::random(var_cf6166dd);

    if(isDefined(var_6d002bb1)) {
      arrayremovevalue(var_cf6166dd, var_6d002bb1, 0);
    }

    foreach(var_382df182 in var_cf6166dd) {
      a_s_sound = struct::get_array(var_382df182.target);
      a_s_sound = arraysortclosest(a_s_sound, var_382df182.origin, 1);

      if(a_s_sound.size > 0) {
        a_s_sound[0] struct::delete();
      }

      var_382df182 delete();
    }
  }
}

private function_6309e7d5() {
  zm_pap_util::set_interaction_height(44);
  zm_pap_util::function_530eb959(112);
  zm_pap_util::set_interaction_trigger_height(64);
  zm_pap_util::function_11f3a609(48);
  zm_pap_util::function_11fdb083(34);
  level.var_9fff4646 = &function_bdbf43e6;
}

private function_c6d69354() {
  zm_pap_util::set_interaction_height(60);
  zm_pap_util::function_530eb959(112);
  zm_pap_util::set_interaction_trigger_height(48);
  zm_pap_util::function_11fdb083(34);
  level.var_d6e98131 = &function_41cd6368;
  level.var_48c45225 = array(#"ar_damage_t8", #"ar_fastfire_t8", #"ar_mg1909_t8", #"shotgun_semiauto_t8", #"tr_longburst_t8", #"tr_midburst_t8");
}

private get_start_state() {
  if(zm_custom::function_901b751c(#"zmpapenabled") == 0) {
    return false;
  }

  if(isDefined(level.var_ef785c4c) && level.var_ef785c4c || zm_custom::function_901b751c(#"zmpapenabled") == 2) {
    return true;
  }

  return false;
}

function_615ef6fe() {
  self endon(#"pack_removed");
  self flag::wait_till("Pack_A_Punch_on");
  self thread pap_power_on_init();
}

pap_power_on_init() {
  self playLoopSound(#"zmb_perks_packa_loop");
  level thread shutoffpapsounds(self, self.packa_rollers, self.packa_timer);

  if(isDefined(level.pack_a_punch.power_on_callback)) {
    self thread[[level.pack_a_punch.power_on_callback]]();
  }
}

function_bb629351(b_on, str_state = "power_on", str_waittill) {
  if(!isDefined(self.powered)) {
    self.powered = spawnStruct();
  }

  if(!b_on) {
    self.powered.power = 1;
    self turn_off();
    self.powered.power = 0;
  }

  self set_pap_zbarrier_state(str_state);

  if(isDefined(str_waittill)) {
    self waittill(str_waittill);
  }

  if(b_on) {
    self.powered.power = 0;
    self turn_on();
    self.powered.power = 1;
  }
}

private turn_on(origin, radius) {
  if(isstruct(self) && isDefined(self.target)) {
    pap_machine = self.target;
  } else if(self iszbarrier()) {
    pap_machine = self;
  }

  if(!isDefined(pap_machine)) {
    assert(0, "<dev string:x38>");
    return;
  }

  if(isDefined(level.pack_a_punch.custom_power_think)) {
    if(pap_machine is_on()) {
      return;
    }
  }

  if(zm_utility::get_story() != 1) {
    self clientfield::set("pap_idle_fx", 1);
  }

  println("<dev string:x7f>");
  var_45fd85a3 = vectornormalize(anglestoright(pap_machine.angles)) * level.pack_a_punch.var_11fdb083;
  level.pack_a_punch.var_fcdf795b = var_45fd85a3 + (0, 0, level.pack_a_punch.interaction_height);

  if(!isDefined(pap_machine.unitrigger_stub)) {
    assert(0, "<dev string:x8b>");
    return;
  }

  pap_machine.unitrigger_stub.origin = pap_machine.origin + level.pack_a_punch.var_fcdf795b;
  pap_machine.unitrigger_stub.angles = pap_machine.angles + (0, -90, 0);
  zm_unitrigger::register_static_unitrigger(pap_machine.unitrigger_stub, &function_72cf5db2);
  zm_unitrigger::function_c4a5fdf5(pap_machine.unitrigger_stub, 1);
  pap_machine flag::set("pap_waiting_for_user");
  pap_machine flag::set("Pack_A_Punch_on");
  pap_machine flag::clear("Pack_A_Punch_off");
  pap_machine notify(#"hash_222aa78f79091e7");
  level notify(#"hash_222aa78f79091e7");
  level flag::set("pap_machine_active");
}

private turn_off(origin, radius) {
  if(self iszbarrier()) {
    pap_machine = self;
  } else if(isstruct(self) && isDefined(self.target)) {
    pap_machine = self.target;
  }

  if(!isDefined(pap_machine)) {
    assert(0, "<dev string:xb6>");
  }

  if(isDefined(level.pack_a_punch.custom_power_think)) {
    if(!pap_machine is_on()) {
      return;
    }
  }

  pap_machine flag::wait_till("pap_waiting_for_user");

  if(zm_utility::get_story() != 1) {
    self clientfield::set("pap_idle_fx", 0);
  }

  println("<dev string:xfe>");
  zm_unitrigger::unregister_unitrigger(pap_machine.unitrigger_stub);
  pap_machine flag::set("Pack_A_Punch_off");
  pap_machine flag::clear("Pack_A_Punch_on");
  pap_machine notify(#"hash_672bc8ddbec0fa33");
  level notify(#"hash_672bc8ddbec0fa33");
  level flag::clear("pap_machine_active");
  pap_machine thread function_615ef6fe();
}

is_on() {
  if(isDefined(self.powered)) {
    return self.powered.power;
  }

  return 0;
}

private function_e13fa347() {
  if(isDefined(self.one_time_cost)) {
    cost = self.one_time_cost;
    self.one_time_cost = undefined;
    return cost;
  }

  if(isDefined(level._power_global) && level._power_global) {
    return 0;
  }

  if(isDefined(self.self_powered) && self.self_powered) {
    return 0;
  }

  return 1;
}

private toggle_think(powered_on) {
  while(!clientfield::can_set()) {
    waitframe(1);
  }

  if(!powered_on) {
    self set_pap_zbarrier_state("initial");
    self flag::wait_till("Pack_A_Punch_on");
  }

  for(;;) {
    self set_pap_zbarrier_state("power_on");
    self flag::wait_till_clear("Pack_A_Punch_on");
    self set_pap_zbarrier_state("power_off");
    self flag::wait_till("Pack_A_Punch_on");
  }
}

private function_64416c32(delta, origin, radius) {
  if(isDefined(self.target)) {
    paporigin = self.target.origin;

    if(isDefined(self.target.trigger_off) && self.target.trigger_off) {
      paporigin = self.target.realorigin;
    } else if(isDefined(self.target.disabled) && self.target.disabled) {
      paporigin += (0, 0, 10000);
    }

    if(distancesquared(paporigin, origin) < radius * radius) {
      return true;
    }
  }

  return false;
}

function_c0bdaa76(b_on) {
  if(b_on) {
    if(isDefined(self.unitrigger_stub.registered) && self.unitrigger_stub.registered) {
      return;
    }

    zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &function_72cf5db2);
    return;
  }

  if(!(isDefined(self.unitrigger_stub.registered) && self.unitrigger_stub.registered)) {
    return;
  }

  self flag::wait_till("pap_waiting_for_user");
  zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
}

private function_72cf5db2() {
  self endon(#"hash_672bc8ddbec0fa33", #"death");
  pap_machine = self.stub.zbarrier;
  b_power_off = !pap_machine is_on();

  if(b_power_off) {
    self sethintstring(#"zombie/need_power");
    pap_machine flag::wait_till("Pack_A_Punch_on");
  }

  for(;;) {
    if(!pap_machine flag::get("pap_in_retrigger_delay")) {
      if(pap_machine flag::get("pap_waiting_for_user")) {
        player = undefined;
        pap_machine.pack_player = undefined;
        pap_machine.b_weapon_supports_aat = undefined;
        pap_machine.var_a86430cb = undefined;
        pap_machine.var_9c076b6 = undefined;
        pap_machine.var_aa0d72d4 = undefined;
        waitresult = self waittill(#"trigger");
        player = waitresult.activator;

        iprintlnbold("<dev string:x10b>" + player getentnum());

          if(!pap_machine flag::get("pap_waiting_for_user") || isDefined(player.var_486c9d59) && player.var_486c9d59) {
            continue;
          }

        current_weapon = player getcurrentweapon();
        current_weapon = player zm_weapons::switch_from_alt_weapon(current_weapon);
        b_result = player function_8a5fe651(pap_machine, current_weapon);

        if(!b_result) {
          continue;
        }

        pap_machine.b_weapon_supports_aat = zm_weapons::weapon_supports_aat(current_weapon);
        pap_machine.var_a86430cb = zm_weapons::is_weapon_upgraded(current_weapon);
        pap_machine.var_9c076b6 = pap_machine function_ec9ac3b2(player, current_weapon);
        pap_machine.var_aa0d72d4 = pap_machine function_d0288a41();
        var_376755db = pap_machine zm_pap_util::function_aaf2d8(player, current_weapon, pap_machine.b_weapon_supports_aat, pap_machine.var_a86430cb);

        if(!player zm_score::can_player_purchase(var_376755db)) {
          self playSound(#"zmb_perks_packa_deny");

          if(isDefined(level.pack_a_punch.var_25a37ed7)) {
            player[[level.pack_a_punch.var_25a37ed7]]();
          } else {
            player zm_audio::create_and_play_dialog(#"general", #"outofmoney", 0);
          }

          continue;
        }

        player thread function_222c0292(current_weapon, pap_machine.packa_rollers, pap_machine, var_376755db, pap_machine.var_9c076b6, pap_machine.var_aa0d72d4);
      } else if(isDefined(pap_machine.pack_player) && pap_machine.pack_player === self.player) {
        pap_machine flag::wait_till("pap_offering_gun");

        if(isDefined(pap_machine.pack_player)) {
          self setcursorhint("HINT_WEAPON", pap_machine.unitrigger_stub.upgrade_weapon);
          self wait_for_player_to_take(pap_machine.pack_player, pap_machine.unitrigger_stub.current_weapon, pap_machine.packa_timer, pap_machine.var_a86430cb, pap_machine.var_9c076b6, pap_machine.var_aa0d72d4);
        }
      }
    }

    waitframe(1);
  }
}

function_ec9ac3b2(e_player, current_weapon) {
  if(e_player namespace_e38c57c1::function_3da195ec(current_weapon)) {
    return true;
  }

  return false;
}

function_d0288a41() {
  if(isDefined(self.var_61d0df53) && self.var_61d0df53) {
    return 1;
  }
}

private function_8a5fe651(pap_machine, current_weapon) {
  if(isDefined(level.pack_a_punch.custom_validation)) {
    valid = pap_machine[[level.pack_a_punch.custom_validation]](self);

    if(!valid) {
      return false;
    }
  }

  if(!self zm_magicbox::can_buy_weapon(0) || self laststand::player_is_in_laststand() || isDefined(self.intermission) && self.intermission || self isthrowinggrenade() || zm_trial_disable_buys::is_active() || zm_trial_disable_upgraded_weapons::is_active() || !self zm_weapons::can_upgrade_weapon(current_weapon) && !zm_weapons::weapon_supports_aat(current_weapon)) {
    return false;
  }

  if(self isswitchingweapons()) {
    wait 0.1;

    if(!isDefined(self) || isDefined(self) && self isswitchingweapons()) {
      return false;
    }
  }

  if(!zm_weapons::is_weapon_or_base_included(current_weapon)) {
    return false;
  }

  return true;
}

private function_222c0292(current_weapon, packa_rollers, pap_machine, var_376755db, var_9c076b6 = 0, var_aa0d72d4 = 0) {
  pap_machine.pack_player = self;
  pap_machine flag::clear("pap_waiting_for_user");
  self.var_9b0383f5 = 1;
  self.var_655c0753 = undefined;
  self.restore_clip = undefined;
  self.healing_aura_revive_zm = undefined;
  self.restore_clip_size = undefined;
  self.restore_max = undefined;
  currentaathashid = -1;

  if(pap_machine.var_a86430cb && pap_machine.b_weapon_supports_aat) {
    var_5a20ddd5 = self aat::getaatonweapon(current_weapon);

    if(isDefined(var_5a20ddd5)) {
      currentaathashid = var_5a20ddd5.hash_id;
    }

    self.var_655c0753 = 1;
    self.restore_clip = self getweaponammoclip(current_weapon);
    self.restore_clip_size = current_weapon.clipsize;
    self.healing_aura_revive_zm = self getweaponammostock(current_weapon);
    self.restore_max = current_weapon.maxammo;
  }

  pap_machine thread wait_for_disconnect(self);
  pap_machine thread destroy_weapon_in_blackout();

  iprintlnbold("<dev string:x126>" + self getentnum());

    demo::bookmark(#"zm_player_use_packapunch", gettime(), self);
  potm::bookmark(#"zm_player_use_packapunch", gettime(), self);
  self zm_stats::increment_client_stat("use_pap");
  self zm_stats::increment_player_stat("use_pap");
  self zm_stats::forced_attachment("boas_use_pap");

  if(!(isDefined(level.var_e4e8d300) && level.var_e4e8d300)) {
    self zm_score::minus_to_player_score(var_376755db);
  }

  self.var_4062e9ef = self zm_audio::create_and_play_dialog(#"pap", #"wait");

  if(!isDefined(self)) {
    pap_machine flag::set("pap_waiting_for_user");
    pap_machine.pack_player = undefined;
    return;
  }

  pap_machine flag::set("pap_taking_gun");
  pap_machine.unitrigger_stub.current_weapon = current_weapon;
  upgrade_weapon = zm_weapons::get_upgrade_weapon(current_weapon);
  current_weaponoptions = self getweaponoptions(current_weapon);
  self thread function_f0fe4bae(pap_machine.unitrigger_stub);
  self third_person_weapon_upgrade(current_weapon, current_weaponoptions, upgrade_weapon, packa_rollers, pap_machine);
  pap_machine flag::clear("pap_taking_gun");
  pap_machine flag::set("pap_offering_gun");
  pap_machine thread wait_for_timeout(pap_machine.unitrigger_stub.current_weapon, pap_machine.packa_timer, self, pap_machine.var_a86430cb, var_9c076b6, var_aa0d72d4);
  s_result = pap_machine waittill(#"pap_timeout", #"pap_taken");

  if(s_result._notify == "pap_taken") {
    weaponidx = undefined;

    if(isDefined(current_weapon)) {
      weaponidx = matchrecordgetweaponindex(current_weapon);
    }

    self zm_stats::function_c0c6ab19(#"weapons_packed");
    self contracts::increment_zm_contract(#"hash_b6b948aac4bd4c");

    if(!pap_machine.var_a86430cb) {
      if(isDefined(weaponidx)) {
        self recordmapevent(19, gettime(), self.origin, level.round_number, weaponidx, var_376755db);
      }

      self zm_challenges::debug_print("<dev string:x142>");

        self zm_stats::increment_challenge_stat(#"pap_weapon_packed");
      self zm_stats::increment_challenge_stat(#"hash_2126e77556d8e66b");
      self stats::inc_stat(#"item_stats", current_weapon.name, #"packed", #"statvalue", 1);
    }

    if(pap_machine.var_a86430cb || var_9c076b6 || var_aa0d72d4) {
      if(isDefined(weaponidx)) {
        self recordmapevent(25, gettime(), self.origin, level.round_number, weaponidx, currentaathashid);
      }

      if(isDefined(pap_machine.unitrigger_stub.var_59f1d079) && pap_machine.unitrigger_stub.var_59f1d079) {
        pap_machine.unitrigger_stub.var_59f1d079 = undefined;

        self zm_challenges::debug_print("<dev string:x169>");

          self zm_stats::increment_challenge_stat(#"pap_weapon_double_packed", undefined, 1);
        self stats::inc_stat(#"item_stats", current_weapon.name, #"doublepacked", #"statvalue", 1);
        self zm_challenges::function_e40c9d13();
      }
    }
  }

  pap_machine flag::clear("pap_offering_gun");
  pap_machine flag::set("pap_waiting_for_user");
  pap_machine.unitrigger_stub.current_weapon = level.weaponnone;
  pap_machine.pack_player = undefined;

  if(pap_machine flag::get("Pack_A_Punch_on")) {
    pap_machine set_pap_zbarrier_state("powered");
  }

  if(isDefined(self)) {
    self.var_9b0383f5 = undefined;
    self notify(#"hash_1ac4338b0d419091", {
      #var_7139c18c: s_result._notify
    });
  }

  pap_machine thread function_ecb78870();
}

private third_person_weapon_upgrade(current_weapon, current_weaponoptions, upgrade_weapon, packa_rollers, pap_machine) {
  pap_machine endon(#"hash_672bc8ddbec0fa33");
  var_d85decd8 = self getbuildkitweapon(current_weapon);
  var_1eca29de = self getbuildkitweapon(upgrade_weapon);

  if(isDefined(self.var_8d5839f4) && isinarray(self.var_8d5839f4, current_weapon) && current_weapon.attachments.size) {
    var_d85decd8 = current_weapon;
    var_1eca29de = upgrade_weapon;
    pap_machine.unitrigger_stub.var_16aa21d4 = 1;
  }

    pap_machine.unitrigger_stub.current_weapon = var_d85decd8;
  var_27024943 = self zm_camos::function_6f75f3d3(var_d85decd8, current_weaponoptions);
  pap_machine.unitrigger_stub.var_f716c676 = self zm_camos::function_7c982eb6(var_d85decd8);
  pap_machine.unitrigger_stub.current_weapon_options = self getbuildkitweaponoptions(pap_machine.unitrigger_stub.current_weapon, var_27024943, pap_machine.unitrigger_stub.var_f716c676);
  pap_machine.unitrigger_stub.upgrade_weapon = var_1eca29de;
  pap_machine.unitrigger_stub.var_3ded6a21 = self zm_camos::function_4f727cf5(var_d85decd8, current_weaponoptions, 1);
  pap_machine.unitrigger_stub.upgrade_weapon_options = self getbuildkitweaponoptions(pap_machine.unitrigger_stub.upgrade_weapon, pap_machine.unitrigger_stub.var_3ded6a21, pap_machine.unitrigger_stub.var_f716c676);
  pap_machine setweapon(pap_machine.unitrigger_stub.current_weapon);
  pap_machine setweaponoptions(pap_machine.unitrigger_stub.current_weapon_options);
  pap_machine set_pap_zbarrier_state("take_gun");
  origin_offset = (0, 0, 0);
  angles_offset = (0, 0, 0);
  origin_base = self.origin;
  angles_base = self.angles;
  origin_offset = level.pack_a_punch.var_fcdf795b;
  angles_offset = (0, 90, 0);
  origin_base = pap_machine.origin;
  angles_base = pap_machine.angles;
  forward = anglesToForward(angles_base + angles_offset);
  interact_offset = origin_offset + forward * -25;
  offsetdw = (3, 3, 3);
  var_397d50da = isDefined(level.var_fbca9d31) ? level.var_fbca9d31 : 3.35;

  if(self hasperk(#"specialty_cooldown")) {
    pap_machine playSound(#"hash_552a43efc3f770d");
    var_397d50da = min(var_397d50da, 1.25);
  } else if(util::get_game_type() === #"zstandard") {
    pap_machine playSound(#"hash_552a43efc3f770d");
  } else {
    pap_machine playSound(#"zmb_perks_packa_upgrade");
  }

  wait var_397d50da;
  pap_machine setweapon(pap_machine.unitrigger_stub.upgrade_weapon);
  pap_machine setweaponoptions(pap_machine.unitrigger_stub.upgrade_weapon_options);
  pap_machine set_pap_zbarrier_state("eject_gun");

  if(isDefined(self)) {
    pap_machine playSound(#"zmb_perks_packa_ready");
    return;
  }

  return;
}

private function_ecb78870() {
  self flag::set("pap_in_retrigger_delay");
  wait level.var_a3b71a00;
  self flag::clear("pap_in_retrigger_delay");
}

private wait_for_player_to_take(player, weapon, packa_timer, var_a86430cb, var_9c076b6 = 0, var_aa0d72d4 = 0) {
  self endon(#"death");
  pap_machine = self.stub.zbarrier;
  current_weapon = pap_machine.unitrigger_stub.current_weapon;
  upgrade_weapon = pap_machine.unitrigger_stub.upgrade_weapon;
  assert(isDefined(current_weapon), "<dev string:x197>");
  assert(isDefined(upgrade_weapon), "<dev string:x1c8>");
  pap_machine endon(#"pap_timeout", #"hash_672bc8ddbec0fa33");

  while(isDefined(player)) {
    packa_timer playLoopSound(#"zmb_perks_packa_ticktock");
    waitresult = self waittill(#"trigger");
    trigger_player = waitresult.activator;

    if(level.pack_a_punch.grabbable_by_anyone) {
      player = trigger_player;
    }

    packa_timer stoploopsound(0.05);

    if(trigger_player == player) {
      player zm_stats::increment_client_stat("pap_weapon_grabbed");
      player zm_stats::increment_player_stat("pap_weapon_grabbed");
      current_weapon = player getcurrentweapon();

      if(level.weaponnone == current_weapon) {
        iprintlnbold("<dev string:x201>");
      }

        if(zm_utility::is_player_valid(player) && !player zm_utility::is_drinking() && !zm_loadout::is_placeable_mine(current_weapon) && !zm_equipment::is_equipment(current_weapon) && !player zm_utility::is_player_revive_tool(current_weapon) && level.weaponnone != current_weapon && !player zm_equipment::hacker_active()) {
          demo::bookmark(#"zm_player_grabbed_packapunch", gettime(), player);
          potm::bookmark(#"zm_player_grabbed_packapunch", gettime(), player);
          level notify(#"pap_taken", {
            #var_5e879929: pap_machine, 
            #e_player: player
          });
          pap_machine notify(#"pap_taken", {
            #e_player: player
          });
          player notify(#"pap_taken", {
            #var_5e879929: pap_machine
          });
          player.pap_used = 1;
          weapon_limit = zm_utility::get_player_weapon_limit(player);
          player zm_weapons::take_fallback_weapon();

          if(isDefined(pap_machine.unitrigger_stub.var_16aa21d4) && pap_machine.unitrigger_stub.var_16aa21d4) {
            if(!isDefined(player.var_8d5839f4)) {
              player.var_8d5839f4 = [];
            } else if(!isarray(player.var_8d5839f4)) {
              player.var_8d5839f4 = array(player.var_8d5839f4);
            }

            player.var_8d5839f4[player.var_8d5839f4.size] = upgrade_weapon;
          }

            primaries = player getweaponslistprimaries();

          if(isDefined(primaries) && primaries.size >= weapon_limit) {
            upgrade_weapon = player zm_weapons::weapon_give(upgrade_weapon, 0, 1, pap_machine.unitrigger_stub.var_3ded6a21, pap_machine.unitrigger_stub.var_f716c676);
          } else {
            upgrade_weapon = player zm_weapons::give_build_kit_weapon(upgrade_weapon, pap_machine.unitrigger_stub.var_3ded6a21, pap_machine.unitrigger_stub.var_f716c676);
            player zm_weapons::function_7c5dd4bd(upgrade_weapon);
          }

          player notify(#"weapon_give", upgrade_weapon);
          aatid = -1;

          if(var_a86430cb || var_9c076b6 || var_aa0d72d4) {
            var_5023ce90 = 1;

            if(var_a86430cb && var_9c076b6) {
              var_5023ce90 = 2;
            }

            if(var_aa0d72d4) {
              var_5023ce90 = 4;
            }

            if(!isDefined(pap_machine.unitrigger_stub.var_3ae1dddb)) {
              pap_machine.unitrigger_stub.var_3ae1dddb = 0;
            }

            player thread aat::acquire(upgrade_weapon, undefined, pap_machine.unitrigger_stub.var_da1ddb37);
            player zm_pap_util::repack_weapon(upgrade_weapon, pap_machine.unitrigger_stub.var_3ae1dddb + var_5023ce90);
            aatobj = player aat::getaatonweapon(upgrade_weapon);

            if(isDefined(aatobj)) {
              aatid = aatobj.hash_id;
              player zm_audio::create_and_play_dialog(#"pap", aatobj.name);
            }
          } else if(isDefined(pap_machine.unitrigger_stub.var_da1ddb37)) {
            player thread aat::acquire(upgrade_weapon, pap_machine.unitrigger_stub.var_da1ddb37);
          }

          pap_machine.unitrigger_stub.var_da1ddb37 = undefined;
          pap_machine.unitrigger_stub.var_3ded6a21 = undefined;
          pap_machine.unitrigger_stub.var_3ae1dddb = undefined;
          weaponidx = undefined;

          if(isDefined(weapon)) {
            weaponidx = matchrecordgetweaponindex(weapon);
          }

          if(isDefined(weaponidx)) {
            if(!(isDefined(var_a86430cb) && var_a86430cb)) {
              player recordmapevent(27, gettime(), player.origin, level.round_number, weaponidx, aatid);
            }

            if(isDefined(var_a86430cb) && var_a86430cb || var_9c076b6 || var_aa0d72d4) {
              player recordmapevent(28, gettime(), player.origin, level.round_number, weaponidx, aatid);
            }
          }

          player switchtoweapon(upgrade_weapon);

          if(!(isDefined(player.var_4062e9ef) && player.var_4062e9ef) && !player zm_audio::function_e2bd90b5("pap", "wait")) {
            player thread zm_audio::create_and_play_dialog(#"pap", #"pickup");
            player zm_weapons::play_weapon_vo(upgrade_weapon);
          }

          if(isDefined(player.var_655c0753) && player.var_655c0753 && !(isDefined(pap_machine.var_b64e889a) && pap_machine.var_b64e889a)) {
            new_clip = player.restore_clip + upgrade_weapon.clipsize - player.restore_clip_size;
            new_stock = player.healing_aura_revive_zm + upgrade_weapon.maxammo - player.restore_max;
            player setweaponammostock(upgrade_weapon, new_stock);
            player setweaponammoclip(upgrade_weapon, new_clip);
          }

          player.var_655c0753 = undefined;
          player.restore_clip = undefined;
          player.healing_aura_revive_zm = undefined;
          player.restore_max = undefined;
          player.restore_clip_size = undefined;
          player callback::callback(#"hash_790b67aca1bf8fc0", upgrade_weapon);

          if(isDefined(level.var_c5b57b4)) {
            self[[level.var_c5b57b4]](player);
          }

          return;
        }
    }

    waitframe(1);
  }
}

private wait_for_timeout(weapon, packa_timer, player, var_a86430cb, var_9c076b6 = 0, var_aa0d72d4 = 0) {
  self endon(#"pap_taken");

  if(isDefined(player) && isDefined(player.var_14361e0c)) {
    n_timeout = player.var_14361e0c;
  } else {
    n_timeout = level.pack_a_punch.timeout;
  }

  wait n_timeout;
  level notify(#"pap_timeout", {
    #var_5e879929: self, 
    #e_player: player
  });
  self notify(#"pap_timeout", {
    #e_player: player
  });
  packa_timer stoploopsound(0.05);
  packa_timer playSound(#"zmb_perks_packa_deny");

  if(isDefined(player)) {
    player notify(#"pap_timeout", {
      #var_5e879929: self
    });

    if(isDefined(level.var_c5b57b4)) {
      self[[level.var_c5b57b4]](player);
    }

    player zm_stats::increment_client_stat("pap_weapon_not_grabbed");
    player zm_stats::increment_player_stat("pap_weapon_not_grabbed");
    player zm_stats::forced_attachment("boas_pap_weapon_not_grabbed");
    weaponidx = undefined;

    if(isDefined(weapon)) {
      weaponidx = matchrecordgetweaponindex(weapon);
    }

    if(isDefined(weaponidx)) {
      if(!(isDefined(var_a86430cb) && var_a86430cb)) {
        player recordmapevent(20, gettime(), player.origin, level.round_number, weaponidx);
      }

      if(isDefined(var_a86430cb) && var_a86430cb || var_9c076b6 || var_aa0d72d4) {
        aatonweapon = player aat::getaatonweapon(weapon);
        aathash = -1;

        if(isDefined(aatonweapon)) {
          aathash = aatonweapon.hash_id;
        }

        player recordmapevent(26, gettime(), player.origin, level.round_number, weaponidx, aathash);
      }
    }
  }
}

private wait_for_disconnect(player) {
  self endon(#"pap_taken", #"pap_timeout");

  while(isDefined(player)) {
    wait 0.1;
  }

  println("<dev string:x22f>");
  self notify(#"pap_player_disconnected");
}

private destroy_weapon_in_blackout() {
  pap_machine = self;
  pap_machine endon(#"pap_timeout", #"pap_taken", #"pap_player_disconnected");
  pap_machine flag::wait_till("Pack_A_Punch_off");
  pap_machine set_pap_zbarrier_state("take_gun");
  pap_machine.pack_player playlocalsound(level.zmb_laugh_alias);
  wait 1.5;
  pap_machine set_pap_zbarrier_state("power_off");
}

private function_f0fe4bae(s_unitrigger_stub) {
  original_weapon = self getcurrentweapon();

  if(original_weapon != level.weaponnone && !zm_loadout::is_placeable_mine(original_weapon) && !zm_equipment::is_equipment(original_weapon)) {
    s_aat = self aat::getaatonweapon(original_weapon);

    if(isDefined(s_aat)) {
      s_unitrigger_stub.var_da1ddb37 = s_aat.name;
    }

    s_unitrigger_stub.var_3ae1dddb = self zm_pap_util::function_83c29ddb(original_weapon);

    if(s_unitrigger_stub.var_3ae1dddb == 0) {
      s_unitrigger_stub.var_59f1d079 = 1;
    }

    self notify(#"packing_weapon", {
      #w_current: original_weapon
    });
    self takeweapon(original_weapon);
  }

  if(!(isDefined(self.intermission) && self.intermission) && !(isDefined(self.is_drinking) && self.is_drinking)) {
    self zm_weapons::switch_back_primary_weapon();
  }
}

private shutoffpapsounds(pap_machine, var_884bde3, var_1e9dad36) {
  pap_machine endon(#"pack_removed");

  while(true) {
    pap_machine flag::wait_till("Pack_A_Punch_off");
    level thread turnonpapsounds(pap_machine);
    pap_machine stoploopsound(0.1);
    var_884bde3 stoploopsound(0.1);
    var_1e9dad36 stoploopsound(0.1);
    pap_machine flag::wait_till_clear("Pack_A_Punch_off");
  }
}

private turnonpapsounds(pap_machine) {
  pap_machine flag::wait_till("Pack_A_Punch_on");
  pap_machine playLoopSound(#"zmb_perks_packa_loop");
}

private pap_initial() {
  self setzbarrierpiecestate(0, "closed");

  if(isDefined(self.unitrigger_stub.var_1f0dbe42)) {
    self.unitrigger_stub.var_1f0dbe42 solid();
  }
}

private pap_power_off() {
  self setzbarrierpiecestate(0, "closing");
}

private pap_power_on() {
  self endon(#"zbarrier_state_change");
  self setzbarrierpiecestate(0, "opening");

  while(self getzbarrierpiecestate(0) == "opening") {
    waitframe(1);
  }

  self playSound(#"zmb_perks_power_on");
  self thread set_pap_zbarrier_state("powered");
}

private pap_powered() {
  self endon(#"zbarrier_state_change");
  self setzbarrierpiecestate(4, "closed");

  if(self.classname === "zbarrier_zm_castle_packapunch" || self.classname === "zbarrier_zm_tomb_packapunch") {
    self clientfield::set("pap_working_FX", 0);
  }
}

private pap_take_gun() {
  self setzbarrierpiecestate(1, "opening");
  self setzbarrierpiecestate(3, "opening");
  wait 0.1;

  if(self.classname === "zbarrier_zm_castle_packapunch" || self.classname === "zbarrier_zm_tomb_packapunch") {
    self clientfield::set("pap_working_FX", 1);
  }
}

private pap_eject_gun() {
  self setzbarrierpiecestate(1, "closing");
  self setzbarrierpiecestate(3, "closing");
}

private pap_leaving() {
  self setzbarrierpiecestate(5, "closing");

  do {
    waitframe(1);
  }
  while(self getzbarrierpiecestate(5) == "closing");

  self setzbarrierpiecestate(5, "closed");
  self notify(#"leave_anim_done");
}

private pap_arriving() {
  self endon(#"zbarrier_state_change");
  self setzbarrierpiecestate(0, "opening");

  while(self getzbarrierpiecestate(0) == "opening") {
    waitframe(1);
  }

  self thread set_pap_zbarrier_state("powered");
}

private get_pap_zbarrier_state() {
  return self.state;
}

private set_pap_zbarrier_state(state) {
  for(i = 0; i < self getnumzbarrierpieces(); i++) {
    self hidezbarrierpiece(i);
  }

  self notify(#"zbarrier_state_change");
  b_continue = 1;

  if(isDefined(level.var_d6e98131)) {
    b_continue = self[[level.var_d6e98131]](state);
  }

  if(b_continue) {
    self[[level.pap_zbarrier_state_func]](state);

    if(isDefined(level.var_9fff4646)) {
      self thread[[level.var_9fff4646]](state);
    }
  }
}

private process_pap_zbarrier_state(state) {
  switch (state) {
    case #"initial":
      self showzbarrierpiece(0);
      self thread pap_initial();
      self.state = "initial";
      break;
    case #"power_off":
      self showzbarrierpiece(0);
      self thread pap_power_off();
      self.state = "power_off";
      break;
    case #"power_on":
      self showzbarrierpiece(0);
      self thread pap_power_on();
      self.state = "power_on";
      break;
    case #"powered":
      self showzbarrierpiece(4);
      self thread pap_powered();
      self.state = "powered";
      break;
    case #"take_gun":
      self showzbarrierpiece(1);
      self showzbarrierpiece(3);
      self thread pap_take_gun();
      self.state = "take_gun";
      break;
    case #"eject_gun":
      self showzbarrierpiece(1);
      self showzbarrierpiece(3);
      self thread pap_eject_gun();
      self.state = "eject_gun";
      break;
    case #"leaving":
      self showzbarrierpiece(5);
      self thread pap_leaving();
      self.state = "leaving";
      break;
    case #"arriving":
      self showzbarrierpiece(0);
      self thread pap_arriving();
      self.state = "arriving";
      break;
    case #"hidden":
      self.state = "hidden";
      break;
    default:
      if(isDefined(level.var_c6c65322)) {
        self[[level.var_c6c65322]](state);
      }

      break;
  }
}

function_bdbf43e6(str_state) {
  switch (str_state) {
    case #"powered":
      self thread function_ea57e209();
      break;
    case #"take_gun":
      self showzbarrierpiece(2);
      self setzbarrierpiecestate(2, "opening");
      break;
    case #"eject_gun":
      self showzbarrierpiece(2);
      self setzbarrierpiecestate(2, "closing");
      break;
  }
}

function_ea57e209() {
  self endon(#"zbarrier_state_change");

  while(true) {
    wait randomfloatrange(180, 1800);
    self setzbarrierpiecestate(4, "opening");
    wait randomfloatrange(180, 1800);
    self setzbarrierpiecestate(4, "closing");
  }
}

function_41cd6368(str_state) {
  switch (str_state) {
    case #"take_gun":
      self thread function_7c1b15f2();
      self.state = "take_gun";
      return false;
    case #"eject_gun":
      self thread function_2bb87d58();
      self.state = "eject_gun";
      return false;
    case #"arriving":
      self showzbarrierpiece(4);
      self thread function_e0fbd38a();
      self.state = "arriving";
      return false;
    case #"leaving":
      self showzbarrierpiece(4);
      self thread function_d896758();
      self.state = "leaving";
      return false;
    case #"powered":
      self setzbarrierpiecestate(3, "closed");
      self setzbarrierpiecestate(5, "closed");
      return true;
  }

  return true;
}

private function_7c1b15f2() {
  self showzbarrierpiece(4);
  var_f27ec4b6 = function_acd31f7d();
  self showzbarrierpiece(var_f27ec4b6);
  self setzbarrierpiecestate(var_f27ec4b6, "opening");
}

private function_2bb87d58() {
  self showzbarrierpiece(4);
  var_f27ec4b6 = function_acd31f7d();
  self showzbarrierpiece(var_f27ec4b6);
  self setzbarrierpiecestate(var_f27ec4b6, "closing");
}

private function_acd31f7d() {
  var_d2fd7259 = weapons::getbaseweapon(self.unitrigger_stub.current_weapon);

  if(isDefined(level.var_48c45225) && isinarray(level.var_48c45225, var_d2fd7259.name)) {
    self zbarrierpieceuseattachweapon(5);
    return 5;
  }

  switch (self.unitrigger_stub.current_weapon.weapclass) {
    case #"smg":
    case #"rocketlauncher":
    case #"pistol":
      if(!isDefined(level.var_aaeee81e) || isDefined(level.var_aaeee81e) && !isinarray(level.var_aaeee81e, var_d2fd7259.name)) {
        self zbarrierpieceuseattachweapon(5);
        return 5;
      }
    default:
      self zbarrierpieceuseattachweapon(3);
      return 3;
  }
}

function_e0fbd38a() {
  self setzbarrierpiecestate(4, "closing");
  level clientfield::set("pap_force_stream", 1);

  while(self getzbarrierpiecestate(4) == "closing") {
    self showzbarrierpiece(4);
    waitframe(1);
  }

  self playSound(#"zmb_perks_power_on");
  self notify(#"arrive_anim_done");

  if(isDefined(self.unitrigger_stub.clip)) {
    self.unitrigger_stub.clip solid();
  }

  if(isDefined(self.unitrigger_stub.var_1f0dbe42)) {
    self.unitrigger_stub.var_1f0dbe42 notsolid();
  }

  level clientfield::set("pap_force_stream", 0);
  self thread function_85a7202d();
  self thread zm_audio::function_ef9ba49c("pap", 1, undefined, undefined, "leave_anim_done", 1);
}

function_d896758() {
  self setzbarrierpiecestate(4, "opening");

  if(isDefined(self.unitrigger_stub.clip)) {
    self.unitrigger_stub.clip notsolid();
  }

  if(isDefined(self.unitrigger_stub.var_1f0dbe42)) {
    self.unitrigger_stub.var_1f0dbe42 solid();
  }

  do {
    waitframe(1);
  }
  while(self getzbarrierpiecestate(4) == "opening");

  self notify(#"leave_anim_done");
}

set_state_initial() {
  self set_pap_zbarrier_state("initial");
}

set_state_leaving() {
  self set_pap_zbarrier_state("leaving");
}

set_state_arriving() {
  self set_pap_zbarrier_state("arriving");
}

set_state_power_on() {
  self set_pap_zbarrier_state("power_on");
}

function_85a7202d() {
  self set_pap_zbarrier_state("powered");
}

set_state_hidden() {
  self set_pap_zbarrier_state("hidden");
}