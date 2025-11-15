/******************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_consumables.gsc
******************************************************/

init_consumables() {
  level.consumables = [];
  setup_irish_luck_consumables();
  parse_consumables_table();
}

setup_irish_luck_consumables() {
  level.irish_luck_consumables = [];
  level.irish_luck_consumables["grenade_cooldown"] = [];
  level.irish_luck_consumables["spawn_reboard_windows"] = [];
  level.irish_luck_consumables["burned_out"] = [];
  level.irish_luck_consumables["faster_health_regen_upgrade"] = [];
  level.irish_luck_consumables["sniper_soft_upgrade"] = [];
  level.irish_luck_consumables["extra_sniping_points"] = [];
  level.irish_luck_consumables["shock_melee_upgrade"] = [];
  level.irish_luck_consumables["penetration_gun"] = [];
  level.irish_luck_consumables["bonus_damage_on_last_bullets"] = [];
  level.irish_luck_consumables["reload_damage_increase"] = [];
  level.irish_luck_consumables["door_buy_refund"] = [];
  level.irish_luck_consumables["faster_window_reboard"] = [];
  level.irish_luck_consumables["headshot_explosion"] = [];
  level.irish_luck_consumables["increased_melee_damage"] = [];
  level.irish_luck_consumables["sharp_shooter_upgrade"] = [];
  level.irish_luck_consumables["spawn_double_money"] = [];
  level.irish_luck_consumables["anywhere_but_here"] = [];
  level.irish_luck_consumables["atomizer_gun"] = [];
  level.irish_luck_consumables["bh_gun"] = [];
  level.irish_luck_consumables["claw_gun"] = [];
  level.irish_luck_consumables["damage_booster_upgrade"] = [];
  level.irish_luck_consumables["headshot_reload"] = [];
  level.irish_luck_consumables["hit_reward_upgrade"] = [];
  level.irish_luck_consumables["killing_time"] = [];
  level.irish_luck_consumables["slow_enemy_movement"] = [];
  level.irish_luck_consumables["spawn_infinite_ammo"] = [];
  level.irish_luck_consumables["spawn_instakill"] = [];
  level.irish_luck_consumables["spawn_max_ammo"] = [];
  level.irish_luck_consumables["spawn_nuke"] = [];
  level.irish_luck_consumables["wall_power"] = [];
  level.irish_luck_consumables["ephemeral_enhancement"] = [];
  level.irish_luck_consumables["secret_service"] = [];
  level.irish_luck_consumables["cant_miss"] = [];
  level.irish_luck_consumables["spawn_fire_sale"] = [];
  level.irish_luck_consumables["self_revive"] = [];
  level.irish_luck_consumables["just_a_flesh_wound"] = [];
  level.irish_luck_consumables["force_push_near_death"] = [];
  level.irish_luck_consumables["next_purchase_free"] = [];
  level.irish_luck_consumables["masochist"] = [];
  level.irish_luck_consumables["magic_wheel_upgrade"] = [];
  level.irish_luck_consumables["steel_dragon"] = [];
  level.irish_luck_consumables["timely_torrent"] = [];
  level.irish_luck_consumables["purify"] = [];
  level.irish_luck_consumables["explosive_touch"] = [];
  level.irish_luck_consumables["shared_fate"] = [];
  level.irish_luck_consumables["fire_chains"] = [];
  level.irish_luck_consumables["temporal_increase"] = [];
  level.irish_luck_consumables["twist_of_fate"] = [];
  level.irish_luck_consumables["dodge_mode"] = [];
  level.irish_luck_consumables["ammo_crate"] = [];
  level.irish_luck_consumables["stimulus"] = [];
  level.irish_luck_consumables_gotten = [];
}

parse_consumables_table() {
  if(isDefined(level.consumable_table)) {
    var_00 = level.consumable_table;
  } else {
    var_00 = "cp\loot\iw7_zombiefatefortune_loot_master.csv";
  }

  var_01 = 0;
  for(;;) {
    var_02 = tablelookupbyrow(var_00, var_01, 1);
    if(var_02 == "") {
      break;
    }

    var_03 = tablelookupbyrow(var_00, var_01, 6);
    var_04 = int(tablelookupbyrow(var_00, var_01, 7));
    var_05 = int(tablelookupbyrow(var_00, var_01, 8));
    var_06 = int(tablelookupbyrow(var_00, var_01, 9));
    register_consumable(var_02, var_03, var_04, var_05, var_06, ::give_consumable, ::remove_consumable);
    var_01++;
  }

  consumable_setup_functions("ephemeral_enhancement", ::use_ephemeral_enhancement, undefined, undefined, 1);
  consumable_setup_functions("grenade_cooldown", ::use_grenade_cooldown, undefined, ::turn_off_grenade_cooldown, undefined);
  consumable_setup_functions("reload_damage_increase", ::use_reload_damage_increase, undefined, undefined, undefined);
  consumable_setup_functions("headshot_reload", ::use_headshot_reload, undefined, undefined, undefined);
  consumable_setup_functions("anywhere_but_here", ::use_anywhere_but_here, undefined, undefined, undefined);
  consumable_setup_functions("now_you_see_me", ::use_now_you_see_me, undefined, undefined, undefined);
  consumable_setup_functions("killing_time", ::use_killing_time, undefined, undefined, undefined);
  consumable_setup_functions("phoenix_up", ::use_phoenix_up, undefined, undefined, 1);
  consumable_setup_functions("spawn_instakill", ::use_spawn_instakill, undefined, undefined, 1);
  consumable_setup_functions("spawn_fire_sale", ::use_spawn_fire_sale, undefined, undefined, 1);
  consumable_setup_functions("spawn_nuke", ::use_spawn_nuke, undefined, undefined, 1);
  consumable_setup_functions("spawn_double_money", ::use_spawn_double_money, undefined, undefined, 1);
  consumable_setup_functions("spawn_max_ammo", ::use_spawn_max_ammo, undefined, undefined, 1);
  consumable_setup_functions("spawn_reboard_windows", ::use_spawn_reboard_windows, undefined, undefined, 1);
  consumable_setup_functions("spawn_infinite_ammo", ::use_spawn_infinite_ammo, undefined, undefined, 1);
  consumable_setup_functions("bh_gun", ::use_bh_gun, undefined, undefined, 1);
  consumable_setup_functions("atomizer_gun", ::use_atomizer_gun, undefined, undefined, 1);
  consumable_setup_functions("claw_gun", ::use_claw_gun, undefined, undefined, 1);
  consumable_setup_functions("steel_dragon", ::use_steel_dragon, undefined, undefined, 1);
  consumable_setup_functions("penetration_gun", ::use_penetration_gun, undefined, undefined, 1);
  consumable_setup_functions("life_link", ::use_life_link, undefined, undefined, undefined);
  consumable_setup_functions("slow_enemy_movement", ::use_slow_enemy_movement, undefined, undefined, undefined);
  consumable_setup_functions("increased_team_efficiency", ::use_increased_team_efficiency, undefined, undefined, undefined);
  consumable_setup_functions("welfare", ::use_welfare, undefined, undefined, undefined);
  consumable_setup_functions("cant_miss", ::use_cant_miss, undefined, undefined, undefined);
  consumable_setup_functions("self_revive", ::use_self_revive, undefined, undefined, undefined);
  consumable_setup_functions("force_push_near_death", ::use_force_push_near_death, undefined, undefined, undefined);
  consumable_setup_functions("masochist", ::use_masochist, undefined, undefined, undefined);
  consumable_setup_functions("timely_torrent", ::use_timely_torrent, undefined, undefined, 1);
  consumable_setup_functions("purify", ::use_purify, undefined, undefined, undefined);
  consumable_setup_functions("explosive_touch", ::use_explosive_touch, undefined, undefined, undefined);
  consumable_setup_functions("shared_fate", ::use_shared_fate, undefined, undefined, undefined);
  consumable_setup_functions("fire_chains", ::use_fire_chains, undefined, undefined, undefined);
  consumable_setup_functions("irish_luck", ::use_irish_luck, undefined, undefined, undefined);
  consumable_setup_functions("temporal_increase", ::use_temporal_increase, undefined, undefined, undefined);
  consumable_setup_functions("twist_of_fate", ::use_twister, undefined, undefined, undefined);
  consumable_setup_functions("dodge_mode", ::use_dodge_mode, undefined, undefined, undefined);
  consumable_setup_functions("ammo_crate", ::use_ammo_crate, undefined, undefined, undefined);
  consumable_setup_functions("stimulus", ::use_stimulus, undefined, undefined, undefined);
  consumable_setup_functions("activate_gns_machine", ::use_activate_gns_machine, undefined, undefined, undefined);
  consumable_setup_functions("double_pap_weap", ::use_get_pap2_gun, undefined, undefined, undefined);
}

register_consumable(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = spawnStruct();
  var_07.type = param_01;
  var_07.uses = param_02;
  var_07.usageperiod = param_03;
  var_07.passiveuses = param_04;
  var_07.set = param_05;
  var_07.unset = param_06;
  var_07.timeupnotify = param_00 + "_timeup";
  level.consumables[param_00] = var_07;
  foreach(var_0A, var_09 in level.irish_luck_consumables) {
    if(var_0A == param_00) {
      level.irish_luck_consumables[param_00] = level.consumables[param_00];
      level.irish_luck_consumables[param_00].name = param_00;
    }
  }
}

consumable_setup_functions(param_00, param_01, param_02, param_03, param_04) {
  var_05 = level.consumables[param_00];
  if(isDefined(param_01)) {
    var_05.usefunc = param_01;
  }

  if(isDefined(param_02)) {
    var_05.set = param_02;
  }

  if(isDefined(param_03)) {
    var_05.unset = param_03;
  }

  if(isDefined(param_04)) {
    var_05.testforsuccess = param_04;
  }
}

init_player_consumables() {
  setup_dpad_slots();
  set_player_consumables();
  turn_on_cards(1);
  init_consumable_meter();
  init_consumables_used();
}

init_consumable_meter() {
  thread meter_fill_up();
}

init_consumables_used() {
  self.consumables_used = [];
  self setplayerdata("common", "numConsumables", 0);
  for(var_00 = 0; var_00 < 32; var_00++) {
    self setplayerdata("common", "consumablesUsed", var_00, 0);
  }
}

set_player_consumables() {
  self.consumables = [];
  for(var_00 = 0; var_00 < 5; var_00++) {
    var_01 = self getplayerdata("cp", "zombiePlayerLoadout", "zombie_consumables", var_00);
    self.consumables[var_01] = spawnStruct();
    self.consumables[var_01].uses = level.consumables[var_01].uses;
    self.consumables[var_01].on = 0;
    self.consumables[var_01].times_used = 0;
  }

  self.consumables_pre_irish_luck_usage = self.consumables;
}

turn_on_cards(param_00) {
  var_01 = get_card_deck_size(self);
  self setclientomnvar("zm_consumables_remaining", var_01);
  self setclientomnvar("zm_dpad_up_activated", 4);
  self.slot_array = [];
  self playlocalsound("zmb_fnf_replenish");
  for(var_02 = 0; var_02 < var_01; var_02++) {
    self.slot_array[self.slot_array.size] = var_02;
    self setclientomnvarbit("zm_card_selection_count", var_02, 1);
  }

  update_lua_consumable_slot(0);
}

reset_meter() {
  self notify("give_new_deck");
  self.consumable_meter = 0;
  init_consumable_meter();
  thread lightbar_off();
  self setclientomnvar("zm_dpad_up_activated", 5);
  self setclientomnvar("zm_consumable_selection_ready", 0);
}

get_card_deck_size(param_00) {
  var_01 = param_00 isitemunlocked("fate_card_slot_4", "fatedecksize", 1);
  var_02 = param_00 isitemunlocked("fate_card_slot_5", "fatedecksize", 1);
  var_03 = 3;
  if(var_01 && var_02) {
    var_03 = 5;
  } else if(var_01 && !var_02) {
    var_03 = 4;
  } else if(!var_01 && !var_02) {
    var_03 = 3;
  }

  return var_03;
}

setup_dpad_slots() {
  self setactionslot(1, "");
  self setactionslot(2, "");
  self setactionslot(3, "");
  self setactionslot(4, "");
  self notifyonplayercommand("D_pad_up", "+actionslot 1");
  self notifyonplayercommand("D_pad_down", "+actionslot 2");
  thread watch_for_super_button("super_default_zm");
}

watch_for_super_button(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("offhand_fired", var_01);
    if(var_01 == param_00) {
      if(scripts\engine\utility::istrue(self.inlaststand)) {
        self setweaponammoclip(param_00, 1);
        continue;
      }

      self notify("fired_super");
      self setweaponammoclip(param_00, 1);
    }
  }
}

dpad_consumable_selection_watch() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("consumable_selected");
  self endon("give_new_deck");
  var_00 = 0;
  self setclientomnvar("zm_consumable_selection_ready", 1);
  update_lua_consumable_slot(var_00);
  self.deck_select_ready = 1;
  for(;;) {
    var_01 = scripts\engine\utility::waittill_any_return("D_pad_up", "D_pad_down", "fired_super");
    if(self.slot_array.size <= 0 || scripts\engine\utility::istrue(level.disable_consumables) || scripts\engine\utility::istrue(self.disable_consumables) || scripts\engine\utility::istrue(self.spectating) || scripts\engine\utility::istrue(self.inlaststand)) {
      self playlocalsound("ui_consumable_deny");
      wait(0.25);
      continue;
    }

    if(var_01 == "fired_super") {
      self.deck_select_ready = undefined;
      thread consumable_activate(self.slot_array[var_00], var_00);
    } else if(var_01 == "D_pad_up" && self.slot_array.size > 1) {
      self setclientomnvar("zm_dpad_pressed", 1);
      var_00 = get_selection_index_loop_around(var_00 + 1, 0, self.slot_array.size - 1);
      update_lua_consumable_slot(var_00);
      self playlocalsound("ui_consumable_scroll");
    } else if(var_01 == "D_pad_down" && self.slot_array.size > 1) {
      self setclientomnvar("zm_dpad_pressed", 1);
      var_00 = get_selection_index_loop_around(var_00 - 1, 0, self.slot_array.size - 1);
      update_lua_consumable_slot(var_00);
      self playlocalsound("ui_consumable_scroll");
    }

    scripts\engine\utility::waitframe();
    self setclientomnvar("zm_dpad_pressed", 0);
  }
}

update_lua_consumable_slot(param_00) {
  wait(0.1);
  self setclientomnvar("zm_consumable_deck_slot_on", self.slot_array[param_00]);
  self setclientomnvar("zm_consumables_slot_count", param_00 + 1);
}

get_selection_index_loop_around(param_00, param_01, param_02) {
  if(param_00 > param_02) {
    return param_01;
  }

  if(param_00 < param_01) {
    return param_02;
  }

  return param_00;
}

remove_card_from_use(param_00) {
  self.slot_array = scripts\engine\utility::array_remove(self.slot_array, self.slot_array[param_00]);
  self setclientomnvar("zm_consumables_remaining", self.slot_array.size);
  if(isDefined(self.slot_array[0])) {
    self setclientomnvar("zm_consumable_deck_slot_on", self.slot_array[0]);
  }
}

consumable_activate(param_00, param_01) {
  var_02 = self getplayerdata("cp", "zombiePlayerLoadout", "zombie_consumables", param_00);
  var_03 = "zm_card" + param_00 + 1 + "_drain";
  var_04 = "slot_" + param_00 + 1 + "_used";
  self.consumables[var_02].usednotify = var_04;
  if(var_02 == "irish_luck") {
    thread consumable_activate_internal_irish(var_02, var_03, "zm_dpad_up_uses", "zm_dpad_up_activated", var_04, param_00, param_01);
    return;
  }

  thread consumable_activate_internal(var_02, var_03, "zm_dpad_up_uses", "zm_dpad_up_activated", var_04, param_00, param_01);
}

consumable_activate_internal(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("dpad_end_" + param_00);
  self endon("give_new_deck");
  if(self.consumables[param_00].uses > 0 && self.consumables[param_00].on == 0 && !scripts\cp\cp_laststand::player_in_laststand(self)) {
    self setclientomnvar("zm_fate_card_used", param_05);
    self.consumables[param_00].processing = 1;
    var_07 = undefined;
    var_08 = "fired_super";
    thread set_consumable(param_00);
    if(isDefined(level.consumables[param_00].usefunc)) {
      if(isDefined(level.consumables[param_00].testforsuccess)) {
        var_07 = self[[level.consumables[param_00].usefunc]](param_00);
      } else {
        var_07 = self thread[[level.consumables[param_00].usefunc]](param_00);
      }
    }

    if(!isDefined(var_07) || isDefined(var_07) && var_07) {
      consume_from_inventory(self, param_00);
      self.consumables[param_00].times_used++;
      scripts\cp\zombies\zombie_analytics::log_fafcardused(1, param_00, level.wave_num, self);
      scripts\cp\cp_merits::processmerit("mt_faf_uses");
      thread scripts\cp\cp_vo::try_to_play_vo("wonder_consume", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      if(self.consumables[param_00].times_used == 1) {
        thread decrement_counter_of_consumables(param_00);
      }

      self setclientomnvar(param_01, 1);
      thread lightbar_off();
      self setclientomnvar("zm_dpad_up_activated", 5);
      self setclientomnvarbit("zm_card_fill_display", param_05, 1);
      self setclientomnvar("zm_consumable_selection_ready", 0);
      remove_card_from_use(param_06);
      thread meter_fill_up();
      self playlocalsound("ui_consumable_select");
      play_consumable_activate_sound(self);
      self notify("consumable_selected");
      thread scripts\cp\utility::firegesturegrenade(self, self.fate_card_weapon);
      self.consumable_meter_full = undefined;
      thread scripts\cp\cp_vo::remove_from_nag_vo("nag_use_fateandfort");
      var_09 = level.consumables[param_00].type;
      if(var_09 == "timedactivations") {
        thread dpad_drain_time(param_00, level.consumables[param_00].usageperiod, param_01, var_08, param_02, param_03, param_04, param_05);
      } else if(var_09 == "wave") {
        thread dpad_drain_wave(param_00, level.consumables[param_00].usageperiod, param_01, var_08, param_02, param_03, param_04, param_05);
      } else if(var_09 == "triggernow" || level.consumables[param_00].type == "triggerwait") {
        thread dpad_drain_activations(param_00, level.consumables[param_00].type, self.consumables[param_00].uses, param_01, var_08, param_02, param_03, param_04, param_05);
      } else if(var_09 == "triggerpassive") {
        thread dpad_drain_triggerpassive(param_00, level.consumables[param_00].passiveuses, param_01, var_08, param_02, param_03, param_04, param_05);
      }

      if(isDefined(var_07)) {
        scripts\cp\utility::notify_used_consumable(param_00);
        return;
      }

      return;
    }

    self playlocalsound("ui_consumable_deny");
    self.consumables[param_00].processing = undefined;
  }
}

decrement_counter_of_consumables(param_00) {
  var_01 = get_consumable_index_in_player_data(self, param_00);
  if(isDefined(var_01)) {
    var_02 = self getplayerdata("cp", "zombiePlayerLoadout", "consumables_counter", var_01);
    var_03 = var_02 - 1;
    self setplayerdata("cp", "zombiePlayerLoadout", "consumables_counter", var_01, var_03);
  }
}

play_consumable_activate_sound(param_00) {
  switch (param_00.fate_card_weapon) {
    case "iw7_jockcard_zm":
      param_00 playlocalsound("wondercard_jock_use_gesture");
      break;

    case "iw7_nerdcard_zm":
      param_00 playlocalsound("wondercard_nerd_use_gesture");
      break;

    case "iw7_valleygirlcard_zm":
      param_00 playlocalsound("wondercard_valleygirl_use_gesture");
      break;

    case "iw7_rappercard_zm":
      param_00 playlocalsound("wondercard_rapper_use_gesture");
      break;

    case "iw7_grungecard_zm":
      param_00 playlocalsound("wondercard_gesture_grunge");
      break;

    case "iw7_cholacard_zm":
      param_00 playlocalsound("wondercard_gesture_chola");
      break;

    case "iw7_ravercard_zm":
      param_00 playlocalsound("wondercard_gesture_raver");
      break;

    case "iw7_hiphopcard_zm":
      param_00 playlocalsound("wondercard_gesture_hiphop");
      break;

    case "iw7_survivorcard_zm":
      param_00 playlocalsound("wondercard_gesture_survivor");
      break;

    case "iw7_wylercard_zm":
      param_00 playlocalsound("vm_gest_zmb_willard_wondercard");
      break;

    default:
      param_00 playlocalsound("wondercard_jock_use_gesture");
      break;
  }
}

consume_from_inventory(param_00, param_01) {
  var_02 = get_consumable_loot_id(param_01);
  if(scripts\engine\utility::array_contains(param_00.consumables_used, var_02)) {
    return;
  }

  var_03 = param_00.consumables_used.size;
  if(isDefined(level.consumable_table)) {
    var_04 = level.consumable_table;
  } else {
    var_04 = "cp\loot\iw7_zombiefatefortune_loot_master.csv";
  }

  var_05 = tablelookup(var_04, 1, param_01, 3);
  if(isDefined(var_05)) {
    if(var_05 == "Fortune") {
      param_00 setplayerdata("common", "consumablesUsed", var_03, int(var_02));
      var_06 = param_00 getplayerdata("common", "numConsumables");
      param_00 setplayerdata("common", "numConsumables", var_06 + 1);
      param_00.consumables_used = scripts\engine\utility::array_add(param_00.consumables_used, var_02);
    }
  }
}

get_consumable_index_in_player_data(param_00, param_01) {
  for(var_02 = 0; var_02 < 5; var_02++) {
    var_03 = param_00 getplayerdata("cp", "zombiePlayerLoadout", "zombie_consumables", var_02);
    if(param_01 == var_03) {
      return var_02;
    }
  }

  return undefined;
}

lightbar_on() {
  self setclientomnvar("lb_gsc_controlled", 1);
  self setclientomnvar("lb_color", 0);
  self setclientomnvar("lb_pulse_time", 1);
}

lightbar_off() {
  self setclientomnvar("lb_gsc_controlled", 0);
}

dpad_drain_time(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("disconnect");
  self endon(param_00 + "_exited_early");
  level endon("game_ended");
  thread watchforearlyexit(param_00, param_04, param_02, param_05, param_06, param_07);
  var_08 = 1;
  var_09 = var_08 / param_01;
  wait(getcharactercardgesturelength());
  for(;;) {
    if(!scripts\engine\utility::istrue(self.spectating) && !scripts\engine\utility::istrue(self.inlaststand)) {
      self setclientomnvar(param_02, var_08);
      var_08 = var_08 - var_09;
      if(var_08 <= 0) {
        self setclientomnvar(param_02, 0);
        disable_consumable(param_00, param_04, param_02, param_05, param_06, param_07);
        break;
      }
    }

    wait(1);
  }
}

dpad_drain_wave(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(param_00 + "_exited_early");
  thread watchforearlyexit(param_00, param_04, param_02, param_05, param_06, param_07);
  var_08 = 1;
  var_09 = var_08 / param_01;
  for(;;) {
    self setclientomnvar(param_02, var_08);
    level waittill("spawn_wave_done");
    var_08 = var_08 - var_09;
    if(var_08 <= 0) {
      self setclientomnvar(param_02, 0);
      disable_consumable(param_00, param_04, param_02, param_05, param_06, param_07);
      break;
    }

    wait(1);
  }
}

dpad_drain_activations(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(param_00 + "_exited_early");
  thread watchforearlyexit(param_00, param_05, param_03, param_06, param_07, param_08);
  var_09 = self.consumables[param_00].usednotify;
  var_0A = 1;
  if(param_01 == "triggerwait") {
    self waittill(var_09);
  }

  wait(1);
  for(;;) {
    if(!scripts\engine\utility::istrue(self.spectating) && !scripts\engine\utility::istrue(self.inlaststand)) {
      var_0A = var_0A - 0.05;
      self setclientomnvar(param_03, var_0A);
      if(var_0A <= 0) {
        self setclientomnvar(param_03, 0);
        disable_consumable(param_00, param_05, param_03, param_06, param_07, param_08);
        break;
      }
    }

    wait(0.05);
  }
}

dpad_drain_triggerpassive(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(param_00 + "_exited_early");
  thread watchforearlyexit(param_00, param_04, param_02, param_05, param_06, param_07);
  var_08 = 1 / param_01;
  var_09 = self.consumables[param_00].usednotify;
  var_0A = 1;
  for(;;) {
    self waittill(var_09);
    if((!scripts\engine\utility::istrue(self.spectating) && !scripts\engine\utility::istrue(self.inlaststand)) || param_00 == "coagulant") {
      var_0A = var_0A - var_08;
      self setclientomnvar(param_02, var_0A);
      if(var_0A < 0.0001) {
        self setclientomnvar(param_02, 0);
        disable_consumable(param_00, param_04, param_02, param_05, param_06, param_07);
        break;
      }
    }
  }
}

getcharactercardgesturelength() {
  if(scripts\cp\utility::map_check(0)) {
    switch (self.vo_prefix) {
      case "p3_":
      case "p2_":
      case "p1_":
        return 2;

      case "p4_":
        return self getgestureanimlength("ges_wondercard_jock");

      default:
        return 2;
    }

    return;
  }

  if(scripts\cp\utility::map_check(1)) {
    switch (self.vo_prefix) {
      case "p4_":
      case "p3_":
      case "p2_":
      case "p1_":
        return 2;

      default:
        return 2;
    }

    return;
  }

  switch (self.vo_prefix) {
    case "p4_":
    case "p3_":
    case "p2_":
    case "p1_":
      return 2;

    default:
      return 2;
  }
}

watchforearlyexit(param_00, param_01, param_02, param_03, param_04, param_05) {
  self endon("dpad_end_" + param_00);
  self waittill(param_00 + "_exited_early");
  self setclientomnvar(param_02, 0);
  thread disable_consumable(param_00, param_01, param_02, param_03, param_04, param_05);
}

meter_fill_up() {
  self notify("starting_meter_fill");
  self endon("starting_meter_fill");
  self endon("disconnect");
  level endon("game_ended");
  if(self.slot_array.size == 0) {
    self setclientomnvar("zm_consumables_remaining", 0);
    self setclientomnvar("zm_dpad_up_fill", 0);
    thread scripts\cp\cp_vo::add_to_nag_vo("nag_need_fateandfort", "zmb_comment_vo", 60, 300, 6, 1);
    thread scripts\cp\cp_vo::remove_from_nag_vo("nag_use_fateandfort");
    return;
  }

  self.consumable_meter = 0;
  self.consumable_meter_max = get_max_meter();
  self setclientomnvar("zm_dpad_up_fill", 0);
  while(self.consumable_meter < self.consumable_meter_max) {
    self waittill("consumable_charge", var_00);
    if(scripts\engine\utility::istrue(self.disable_consumables)) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      continue;
    }

    if(isDefined(self.consumable_meter_scalar)) {
      var_00 = var_00 * self.consumable_meter_scalar;
    }

    var_01 = self.consumable_meter_max - self.consumable_meter;
    if(var_00 > var_01) {
      var_00 = var_01;
    }

    self.consumable_meter = self.consumable_meter + var_00;
    self setclientomnvar("zm_dpad_up_fill", self.consumable_meter / self.consumable_meter_max);
  }

  self notify("meter_full");
  thread scripts\cp\cp_vo::add_to_nag_vo("nag_use_fateandfort", "zmb_comment_vo", 60, 180, 6, 1);
  self playlocalsound("ui_consumable_meter_full");
  self setclientomnvar("zm_dpad_up_activated", 1);
  self setweaponammoclip("super_default_zm", 1);
  thread lightbar_on();
  self.consumable_meter_full = 1;
  thread dpad_consumable_selection_watch();
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    thread scripts\cp\cp_hud_message::wait_and_play_tutorial_message("cards", 5);
  }
}

get_max_meter() {
  var_00 = 1250;
  if(self.card_refills == 1) {
    var_00 = 3000;
  } else if(self.card_refills >= 2) {
    var_00 = 5000;
  }

  return var_00;
}

disable_consumable(param_00, param_01, param_02, param_03, param_04, param_05) {
  turn_off_consumable(param_00, param_03);
  self.consumables[param_00].uses = self.consumables[param_00].uses - 1;
  self.consumables[param_00].processing = undefined;
  self setclientomnvar(param_01, self.consumables[param_00].uses);
  if(self.consumables[param_00].uses == 0) {
    self.consumables[param_00].uses = level.consumables[param_00].uses;
    self notify("dpad_end_" + param_00);
    self setclientomnvarbit("zm_card_selection_count", param_05, 0);
    self setclientomnvarbit("zm_card_fill_display", param_05, 0);
    return;
  }

  self setclientomnvar(param_02, 1);
}

turn_off_consumable(param_00, param_01) {
  self.consumables[param_00].on = 0;
  scripts\cp\utility::notify_timeup_consumable(param_00);
  thread unset_consumable(param_00);
}

give_consumable(param_00, param_01) {
  var_02 = level.consumables[param_00];
  if(isDefined(var_02.usednotify)) {
    self notify(var_02.usednotify);
  } else {
    self notify(param_00 + " activated");
  }

  if(isDefined(level.random_consumable_chosen) && level.random_consumable_chosen.name == param_00) {
    return;
  }

  self.consumables[param_00].on = 1;
}

remove_consumable(param_00) {
  if(isDefined(self.consumables[param_00])) {
    self.consumables[param_00].on = 0;
  }
}

use_reload_damage_increase(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self.reload_damage_increase = undefined;
  for(;;) {
    self waittill("reload");
    self.reload_damage_increase = 1;
    wait(5);
    self.reload_damage_increase = undefined;
  }
}

use_ephemeral_enhancement(param_00) {
  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    self.consumables[param_00].on = 0;
    return 0;
  }

  var_01 = self getcurrentweapon();
  var_02 = scripts\cp\utility::getrawbaseweaponname(var_01);
  if(isDefined(self.pap[var_02]) && scripts\cp\cp_weapon::can_upgrade(var_01, 1)) {
    thread fnf_upgrade_weapon(self, param_00, var_02, var_01);
    return 1;
  }

  self.consumables["ephemeral_enhancement"].on = 0;
  return 0;
}

fnf_upgrade_weapon(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  param_00 endon("disconnect");
  var_04 = undefined;
  param_00.isusingsupercard = 1;
  var_05 = "pap" + param_00.pap[param_02].lvl;
  var_06 = getweaponattachments(param_03);
  var_07 = 0;
  var_08 = param_03;
  if(issubstr(param_03, "g18_z")) {
    foreach(var_0A in var_06) {
      if(issubstr(var_0A, "akimbo")) {
        var_07 = 1;
        var_06 = scripts\engine\utility::array_remove(var_06, var_0A);
      }
    }
  }

  if(isDefined(level.custom_epehermal_attachment_func)) {
    var_0C = [[level.custom_epehermal_attachment_func]](param_00, param_02, param_03);
    if(isDefined(var_0C)) {
      if(var_0C == "replace_me") {
        var_05 = undefined;
      } else {
        var_05 = var_0C;
      }
    }
  }

  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(param_03)])) {
    param_03 = level.weapon_upgrade_path[getweaponbasename(param_03)];
  } else if(isDefined(level.custom_epehermal_weapon_func)) {
    param_03 = [[level.custom_epehermal_weapon_func]](param_00, param_02, param_03);
  }

  if(isDefined(level.custom_ephermal_camo_func)) {
    var_04 = [[level.custom_ephermal_camo_func]](param_00, param_02, param_03);
  } else {
    if(isDefined(param_02)) {
      if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, param_02)) {
        var_04 = undefined;
      } else if(isDefined(level.pap_1_camo) && param_00.pap[param_02].lvl == 1) {
        var_04 = level.pap_1_camo;
      } else if(isDefined(level.pap_2_camo) && param_00.pap[param_02].lvl == 2) {
        var_04 = level.pap_2_camo;
      }

      var_0D = param_00 scripts\cp\cp_weapon::get_weapon_level(param_03);
      switch (param_02) {
        case "dischord":
          var_0E = "iw7_dischord_zm_pap1";
          var_04 = "camo20";
          break;

        case "facemelter":
          var_0E = "iw7_facemelter_zm_pap1";
          var_04 = "camo22";
          break;

        case "headcutter":
          var_0E = "iw7_headcutter_zm_pap1";
          var_04 = "camo21";
          break;

        case "forgefreeze":
          if(var_0D == 2) {
            var_0E = "iw7_forgefreeze_zm_pap1";
          } else if(var_0D == 3) {
            var_0E = "iw7_forgefreeze_zm_pap2";
          }

          var_0F = 1;
          break;

        case "axe":
          if(var_0D == 2) {
            var_0E = "iw7_axe_zm_pap1";
          } else if(var_0D == 3) {
            var_0E = "iw7_axe_zm_pap2";
          }
          break;

        case "shredder":
          var_0E = "iw7_shredder_zm_pap1";
          var_04 = "camo23";
          break;

        case "katana":
        case "nunchucks":
          var_04 = "camo222";
          break;
      }
    }

    var_0F = 0;
    if(isDefined(param_02)) {
      switch (param_02) {
        case "spiked":
        case "golf":
        case "two":
        case "axe":
        case "machete":
          var_0F = 1;
          break;

        default:
          var_0F = 0;
          break;
      }
    } else {
      var_0F = 0;
    }

    var_05 = undefined;
    if(isDefined(param_02)) {
      switch (param_02) {
        case "spiked":
        case "golf":
        case "two":
        case "machete":
        case "katana":
        case "nunchucks":
          var_05 = "replace_me";
          break;

        default:
          if(isDefined(param_00.pap[param_02])) {
            var_05 = "pap" + param_00.pap[param_02].lvl;
          } else {
            var_05 = "pap1";
          }

          break;
      }
    }

    if(isDefined(var_05) && var_05 == "replace_me") {
      var_05 = undefined;
    }

    var_10 = getweaponattachments(param_03);
    if(issubstr(param_03, "g18_z")) {
      foreach(var_0A in var_10) {
        if(issubstr(var_0A, "akimbo")) {
          var_10 = scripts\engine\utility::array_remove(var_10, var_0A);
        }
      }
    }
  }

  var_13 = param_00 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(param_03, var_05, var_06, undefined, var_04);
  if(isDefined(var_13)) {
    param_00.pap[param_02].lvl++;
    param_00 notify("weapon_level_changed");
    param_00.ephemeralweapon = getweaponbasename(var_13);
    param_00 thread downgradeweaponaftertimeout(param_01, param_00, var_13, var_07);
    param_00 endon("last_stand");
    wait(getcharactercardgesturelength());
    var_13 = param_00 scripts\cp\utility::_giveweapon(var_13, undefined, undefined, 1);
    if(isDefined(var_08)) {
      param_00 takeweapon(var_08);
    } else {
      param_00 takeweapon(param_03);
    }

    param_00 switchtoweapon(var_13);
  }
}

downgradeweaponaftertimeout(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  param_01 endon("disconnect");
  var_04 = param_01.ephemeralweapon;
  var_05 = 0;
  var_06 = scripts\cp\utility::getrawbaseweaponname(param_02);
  var_07 = "pap" + param_01.pap[var_06].lvl - 1;
  var_08 = param_01.pap[var_06].lvl - 2;
  switch (var_06) {
    case "venomx":
      param_01.pap[var_06].lvl--;
      if(param_01.pap[var_06].lvl == 1) {
        param_01.base_weapon = 1;
        param_02 = "iw7_venomx_zm";
      } else {
        param_01.ephemeral_downgrade = 1;
        param_02 = "iw7_venomx_zm_pap1";
      }
      break;

    case "katana":
      param_01.pap[var_06].lvl--;
      if(param_01.pap[var_06].lvl == 1) {
        param_01.base_weapon = 1;
        param_02 = "iw7_katana_zm";
      } else {
        param_01.ephemeral_downgrade = 1;
        param_02 = "iw7_katana_zm_pap1";
      }
      break;

    case "nunchucks":
      param_01.pap[var_06].lvl--;
      if(param_01.pap[var_06].lvl == 1) {
        param_01.base_weapon = 1;
        param_02 = "iw7_nunchucks_zm";
      } else {
        param_01.ephemeral_downgrade = 1;
        param_02 = "iw7_nunchucks_zm_pap1";
      }
      break;

    case "two":
      param_01.pap[var_06].lvl--;
      if(param_01.pap[var_06].lvl == 1) {
        param_01.base_weapon = 1;
        param_02 = "iw7_two_headed_axe_mp";
      } else {
        param_01.ephemeral_downgrade = 1;
        param_02 = "iw7_two_headed_axe_mp_pap1";
      }
      break;

    case "machete":
      param_01.pap[var_06].lvl--;
      if(param_01.pap[var_06].lvl == 1) {
        param_01.base_weapon = 1;
        param_02 = "iw7_machete_mp";
      } else {
        param_01.ephemeral_downgrade = 1;
        param_02 = "iw7_machete_mp_pap1";
      }
      break;

    case "golf":
      param_01.pap[var_06].lvl--;
      if(param_01.pap[var_06].lvl == 1) {
        param_01.base_weapon = 1;
        param_02 = "iw7_golf_club_mp";
      } else {
        param_01.ephemeral_downgrade = 1;
        param_02 = "iw7_golf_club_mp_pap1";
      }
      break;

    case "spiked":
      param_01.pap[var_06].lvl--;
      if(param_01.pap[var_06].lvl == 1) {
        param_01.base_weapon = 1;
        param_02 = "iw7_spiked_bat_mp";
      } else {
        param_01.ephemeral_downgrade = 1;
        param_02 = "iw7_spiked_bat_mp_pap1";
      }
      break;
  }

  param_02 = downgradeweapon(param_01, param_02, var_06, var_07, var_08, param_03);
  param_01.base_weapon = undefined;
  param_01.ephemeral_downgrade = undefined;
  var_09 = param_01 scripts\engine\utility::waittill_any_return("ephemeral_enhancement_timeup", "last_stand");
  if(var_09 != "ephemeral_enhancement_timeup") {
    param_01 notify(param_00 + "_exited_early");
  }

  param_01.isusingsupercard = undefined;
  var_0A = scripts\cp\utility::getrawbaseweaponname(param_01 scripts\cp\utility::getvalidtakeweapon());
  if(param_01 scripts\cp\cp_weapon::has_weapon_variation(var_04)) {
    var_0B = param_01 getweaponslistall();
    foreach(var_0D in var_0B) {
      var_0E = scripts\cp\utility::getrawbaseweaponname(var_0D);
      if(var_0E == scripts\cp\utility::getrawbaseweaponname(var_04)) {
        param_01 takeweapon(var_0D);
        var_05 = 1;
        param_02 = param_01 scripts\cp\utility::_giveweapon(param_02, undefined, undefined, 1);
        if(scripts\cp\utility::getrawbaseweaponname(param_02) == var_0A) {
          param_01 switchtoweaponimmediate(param_02);
        }

        param_01.pap[var_06].lvl = int(max(param_01.pap[var_06].lvl - 1, 1));
        param_01 notify("weapon_level_changed");
        break;
      }
    }
  }

  if(isDefined(param_01.copy_fullweaponlist)) {
    var_10 = param_01.copy_fullweaponlist;
    foreach(var_12 in var_10) {
      var_0E = getweaponbasename(var_12);
      if(var_0E == var_04) {
        var_13 = param_01.copy_weapon_ammo_clip[var_12];
        var_14 = param_01.copy_weapon_ammo_stock[var_12];
        param_01.copy_fullweaponlist = scripts\engine\utility::array_remove(param_01.copy_fullweaponlist, var_12);
        if(var_0E == getweaponbasename(param_01.copy_weapon_current)) {
          param_01.copy_weapon_current = param_02;
        }

        param_01.copy_fullweaponlist = scripts\engine\utility::array_add(param_01.copy_fullweaponlist, param_02);
        param_01.copy_weapon_ammo_clip[param_02] = var_13;
        param_01.copy_weapon_ammo_stock[param_02] = var_14;
        break;
      }
    }
  }

  if(isDefined(param_01.last_stand_pistol)) {
    if(getweaponbasename(param_01.last_stand_pistol) == param_01.ephemeralweapon) {
      param_01.last_stand_pistol = param_02;
    }
  }

  if(isDefined(param_01.saved_last_stand_pistol)) {
    if(getweaponbasename(param_01.saved_last_stand_pistol) == param_01.ephemeralweapon) {
      param_01.saved_last_stand_pistol = param_02;
    }
  }

  if(isDefined(param_01.lost_and_found_ent)) {
    var_10 = param_01.lost_and_found_ent.copy_fullweaponlist;
    foreach(var_12 in var_10) {
      var_0E = getweaponbasename(var_12);
      if(var_0E == var_04) {
        var_13 = param_01.copy_weapon_ammo_clip[var_12];
        var_14 = param_01.copy_weapon_ammo_stock[var_12];
        param_01.lost_and_found_ent.copy_fullweaponlist = scripts\engine\utility::array_remove(param_01.lost_and_found_ent.copy_fullweaponlist, var_12);
        if(var_0E == getweaponbasename(param_01.lost_and_found_ent.copy_weapon_current)) {
          param_01.lost_and_found_ent.copy_weapon_current = param_02;
        }

        param_01.lost_and_found_ent.copy_fullweaponlist = scripts\engine\utility::array_add(param_01.lost_and_found_ent.copy_fullweaponlist, param_02);
        param_01.copy_weapon_ammo_clip[param_02] = var_13;
        param_01.copy_weapon_ammo_stock[param_02] = var_14;
        break;
      }
    }
  }

  param_01.ephemeralweapon = undefined;
}

downgradeweapon(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = undefined;
  if(param_04 >= 1) {
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, param_02)) {
      var_06 = undefined;
    } else if(isDefined(level.pap_1_camo)) {
      var_06 = level.pap_1_camo;
    }

    var_07 = "pap" + param_04;
    switch (param_02) {
      case "dischord":
        var_06 = "camo20";
        break;

      case "facemelter":
        var_06 = "camo22";
        break;

      case "headcutter":
        var_06 = "camo21";
        break;

      case "shredder":
        var_06 = "camo23";
        break;

      case "katana":
      case "nunchucks":
        var_06 = "camo222";
        break;
    }
  } else {
    var_07 = undefined;
  }

  switch (param_02) {
    case "katana":
    case "nunchucks":
      var_07 = undefined;
      break;

    case "two":
      var_07 = undefined;
      break;

    case "golf":
      var_07 = undefined;
      break;

    case "machete":
      var_07 = undefined;
      break;

    case "spiked":
      var_07 = undefined;
      break;
  }

  var_08 = getweaponattachments(param_01);
  if(scripts\engine\utility::istrue(param_05)) {
    var_08 = scripts\engine\utility::array_add(var_08, "akimbo");
  }

  foreach(var_0A in var_08) {
    if(issubstr(var_0A, param_03)) {
      var_08 = scripts\engine\utility::array_remove(var_08, var_0A);
    }
  }

  var_0C = param_00 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(param_01, var_07, var_08, undefined, var_06);
  return var_0C;
}

use_spawn_instakill(param_00) {
  var_01 = self;
  if(spawn_power_up(var_01, "instakill_30", param_00)) {
    return 1;
  }

  self.consumables["spawn_instakill"].on = 0;
  return 0;
}

use_spawn_fire_sale(param_00) {
  var_01 = self;
  if(spawn_power_up(var_01, "fire_30", param_00)) {
    return 1;
  }

  self.consumables["fire_30"].on = 0;
  return 0;
}

use_spawn_nuke(param_00) {
  var_01 = self;
  if(spawn_power_up(var_01, "kill_50", param_00)) {
    return 1;
  }

  self.consumables["spawn_nuke"].on = 0;
  return 0;
}

use_spawn_double_money(param_00) {
  var_01 = self;
  if(spawn_power_up(var_01, "cash_2", param_00)) {
    return 1;
  }

  self.consumables["spawn_double_money"].on = 0;
  return 0;
}

use_spawn_max_ammo(param_00) {
  var_01 = self;
  if(spawn_power_up(var_01, "ammo_max", param_00)) {
    return 1;
  }

  self.consumables["spawn_max_ammo"].on = 0;
  return 0;
}

use_spawn_reboard_windows(param_00) {
  var_01 = self;
  if(spawn_power_up(var_01, "board_windows", param_00)) {
    return 1;
  }

  self.consumables["spawn_reboard_windows"].on = 0;
  return 0;
}

use_spawn_infinite_ammo(param_00) {
  var_01 = self;
  if(spawn_power_up(var_01, "infinite_20", param_00)) {
    return 1;
  }

  self.consumables["spawn_infinite_ammo"].on = 0;
  return 0;
}

spawn_power_up(param_00, param_01, param_02) {
  var_03 = param_00.origin;
  var_04 = (0, 40, 0);
  var_05 = self getplayerangles();
  var_06 = 7;
  var_03 = var_03 + var_04[0] * anglestoright(var_05);
  var_03 = var_03 + var_04[1] * anglesToForward(var_05);
  var_03 = var_03 + var_04[2] * anglestoup(var_05);
  var_07 = rotatepointaroundvector(anglestoup(var_05), anglesToForward(var_05), var_06);
  var_08 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_canshootclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_09 = scripts\common\trace::ray_trace(param_00 getEye(), var_03 + var_07, self, var_08);
  var_03 = scripts\engine\utility::drop_to_ground(var_09["position"] + var_07 * -18, 32, -2000);
  if(!scripts\cp\cp_weapon::isinvalidzone(var_03, level.invalid_spawn_volume_array, undefined, undefined, 1)) {
    var_03 = param_00.origin;
  }

  if(level scripts\cp\loot::drop_loot(var_03, param_00, param_01, undefined, undefined, 1)) {
    wait(0.25);
    param_00 scripts\cp\utility::notify_used_consumable(param_02);
    return 1;
  }

  return 0;
}

use_steel_dragon(param_00) {
  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    self.consumables[param_00].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[param_00].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(param_00, "iw7_steeldragon_mp");
  return 1;
}

use_claw_gun(param_00) {
  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    self.consumables[param_00].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[param_00].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(param_00, "iw7_claw_mp");
  return 1;
}

use_atomizer_gun(param_00) {
  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    self.consumables[param_00].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[param_00].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(param_00, "iw7_atomizer_mp+atomizerscope");
  return 1;
}

use_penetration_gun(param_00) {
  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    self.consumables[param_00].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[param_00].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(param_00, "iw7_penetrationrail_mp+penetrationrailscope");
  return 1;
}

use_bh_gun(param_00) {
  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    self.consumables[param_00].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[param_00].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(param_00, "iw7_blackholegun_mp+blackholegunscope");
  return 1;
}

give_mp_super_weapon(param_00, param_01) {
  level endon("game_ended");
  self endon("disconnect");
  var_02 = self getcurrentweapon();
  var_03 = 0;
  if(var_02 == "none") {
    var_03 = 1;
  } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_02)) {
    var_03 = 1;
  } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, getweaponbasename(var_02))) {
    var_03 = 1;
  } else if(scripts\cp\utility::is_melee_weapon(var_02, 1)) {
    var_03 = 1;
  }

  if(var_03) {
    self.copy_fullweaponlist = self getweaponslistall();
    var_02 = scripts\cp\cp_laststand::choose_last_weapon(level.additional_laststand_weapon_exclusion, 1, 1);
  }

  self.last_weapon = var_02;
  self.copy_fullweaponlist = undefined;
  thread removeweaponaftertimeout(param_00, param_01, var_02);
  self endon(param_00 + "_exited_early");
  self endon("last_stand");
  wait(getcharactercardgesturelength());
  param_01 = scripts\cp\utility::_giveweapon(param_01, undefined, undefined, 0);
  self switchtoweaponimmediate(param_01);
  var_04 = ammo_round_up(param_01);
  while(self getcurrentweapon() != param_01) {
    wait(0.05);
  }

  self notify("super_weapon_given");
  thread unlimited_ammo(var_04, param_01);
}

removeweaponaftertimeout(param_00, param_01, param_02) {
  level endon("game_ended");
  self endon("disconnect");
  self.isusingsupercard = 1;
  self.mpsuperpreviousweapon = param_02;
  scripts\engine\utility::allow_reload(0);
  scripts\engine\utility::waittill_any_timeout_1(getcharactercardgesturelength() + 1, "super_weapon_given");
  self allowmelee(0);
  while(self isswitchingweapon()) {
    wait(0.05);
  }

  self allowmelee(1);
  if(self getcurrentweapon() == param_01 && scripts\cp\utility::is_consumable_active(param_00)) {
    var_03 = scripts\engine\utility::waittill_any_return(param_00 + "_timeup", "last_stand", "weapon_switch_started", "weapon_purchased", "coaster_ride_beginning", "cards_replenished");
  } else {
    var_03 = undefined;
  }

  scripts\engine\utility::allow_reload(1);
  if(!isDefined(var_03) || var_03 != param_00 + "_timeup") {
    self notify(param_00 + "_exited_early");
  }

  self.isusingsupercard = undefined;
  if(!isDefined(var_03) || isDefined(var_03) && var_03 != "last_stand") {
    if(self hasweapon(param_02)) {
      self switchtoweapon(param_02);
    } else {
      self switchtoweapon(self getweaponslistprimaries()[1]);
    }
  }

  if(self hasweapon(param_01)) {
    self takeweapon(param_01);
  }

  thread deactivate_infinite_ammo();
  self.mpsuperpreviousweapon = undefined;
  self.last_weapon = undefined;
}

ammo_round_up(param_00) {
  self endon("death");
  self endon("disconnect");
  var_01 = [];
  if(isDefined(param_00)) {
    var_01[param_00] = self getrunningforwardpainanim(param_00);
  } else {
    foreach(param_00 in self.weaponlist) {
      var_01[param_00] = self getrunningforwardpainanim(param_00);
    }
  }

  return var_01;
}

unlimited_ammo(param_00, param_01) {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(self.weaponlist)) {
    self.weaponlist = self getweaponslistprimaries();
  }

  var_02 = self.weaponlist;
  if(isDefined(param_01)) {
    var_02[var_02.size] = param_01;
  }

  self.has_fnf_weapon = 1;
  scripts\cp\utility::enable_infinite_ammo(1);
  while(scripts\engine\utility::istrue(self.has_fnf_weapon)) {
    var_03 = 0;
    foreach(var_05 in var_02) {
      if(var_05 == self getcurrentweapon() && weapon_no_unlimited_check(var_05)) {
        var_03 = 1;
        self setweaponammoclip(var_05, weaponclipsize(var_05), "left");
      }

      if(var_05 == self getcurrentweapon() && weapon_no_unlimited_check(var_05)) {
        var_03 = 1;
        self setweaponammoclip(var_05, weaponclipsize(var_05), "right");
      }

      if(var_03 == 0) {
        ammo_round_up(param_01);
      }
    }

    wait(0.05);
  }
}

weapon_no_unlimited_check(param_00) {
  var_01 = 1;
  foreach(var_03 in level.opweaponsarray) {
    if(param_00 == var_03) {
      var_01 = 0;
    }
  }

  return var_01;
}

deactivate_infinite_ammo() {
  level endon("disconnect");
  level endon("game_ended");
  self.has_fnf_weapon = undefined;
  wait(0.2);
  scripts\cp\utility::enable_infinite_ammo(0);
}

use_cant_miss(param_00) {
  self endon("disconnect");
  self endon(param_00 + "_timeup");
  level endon("game_ended");
  for(;;) {
    self waittill("shot_missed", var_01);
    if(!scripts\cp\cp_weapon::isbulletweapon(var_01)) {
      continue;
    }

    if(scripts\cp\cp_weapon::has_attachment(var_01, "g18pap1") || scripts\cp\cp_weapon::has_attachment(var_01, "g18pap2")) {
      continue;
    }

    var_02 = self getweaponammoclip(var_01);
    self setweaponammoclip(var_01, var_02 + 1);
  }
}

use_force_push_near_death(param_00) {
  self endon("disconnect");
  self endon(param_00 + "_timeup");
  level endon("game_ended");
  for(;;) {
    self waittill("player_damaged");
    if(self.health <= 45) {
      thread setandremoveinvulnerability();
      thread killnearbyzombies();
      scripts\cp\utility::notify_used_consumable(param_00);
    }
  }
}

setandremoveinvulnerability() {
  self notify("setAndRemoveInvulnerability");
  self endon("setAndRemoveInvulnerability");
  self endon("disconnect");
  level endon("game_ended");
  scripts\cp\utility::adddamagemodifier("near_death_consumable", 0, 0);
  scripts\engine\utility::waittill_any_timeout_no_endon_death_2(1, "death", "last_stand");
  scripts\cp\utility::removedamagemodifier("near_death_consumable", 0);
}

killnearbyzombies(param_00) {
  var_01 = 128;
  var_02 = vectornormalize(anglesToForward(self.angles));
  var_03 = var_02 * var_01;
  var_04 = self.origin + var_03;
  physicsexplosionsphere(var_04, var_01, 1, 2.5);
  var_05 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_06 = scripts\engine\utility::get_array_of_closest(self.origin, var_05, undefined, 24, 256);
  foreach(var_08 in var_06) {
    if(isDefined(var_08.agent_type) && var_08.agent_type == "zombie_sasquatch" || var_08.agent_type == "slasher" || var_08.agent_type == "superslasher" || var_08.agent_type == "zombie_brute" || var_08.agent_type == "zombie_grey" || var_08.agent_type == "zombie_clown" || var_08.agent_type == "alien_rhino") {
      continue;
    }

    if(scripts\engine\utility::istrue(var_08.var_9342)) {
      var_08 killrepulsorvictim(self, var_08.maxhealth, var_08.origin, self.origin);
      continue;
    }

    var_08 playSound("zmb_fnf_second_wind_push");
    var_09 = 0;
    var_0A = var_08.origin;
    var_0B = var_08.maxhealth;
    var_02 = anglesToForward(self.angles);
    var_0C = vectornormalize(var_02) * -100;
    var_08 setvelocity(vectornormalize(var_08.origin - self.origin + var_0C) * 800 + (0, 0, 300));
    var_08 killrepulsorvictim(self, var_0B, var_0A, self.origin);
  }
}

killrepulsorvictim(param_00, param_01, param_02, param_03) {
  self.do_immediate_ragdoll = 1;
  if(param_01 >= self.health) {
    self.customdeath = 1;
  }

  self dodamage(param_01, param_02, param_00, param_00, "MOD_IMPACT", "zom_repulsor_mp");
}

torrent_start(param_00, param_01, param_02, param_03, param_04) {
  self endon("death");
  level endon("game_ended");
  if(param_03 == 0 || param_03 == 3 || param_03 == 6) {
    playsoundatpos(param_01, "zmb_fnf_timely_torrent_lava");
  }

  playFX(level._effect["lava_torrent"], self.origin, undefined, anglestoup((0, 0, 90)));
  foreach(var_06 in param_02) {
    var_07 = (var_06.origin[0], var_06.origin[1], 90);
    if(var_06 scripts\cp\utility::agentisfnfimmune()) {
      continue;
    }

    if(isDefined(var_06.flung) || isDefined(var_06.agent_type) && var_06.agent_type == "zombie_brute" || var_06.agent_type == "zombie_ghost" || var_06.agent_type == "zombie_grey" || var_06.agent_type == "slasher" || var_06.agent_type == "superslasher") {
      continue;
    }

    if(distancesquared(var_06.origin, param_01) < 5184) {
      var_06.flung = 1;
      var_06.do_immediate_ragdoll = 1;
      var_06.disable_armor = 1;
      var_06 setsolid(0);
      var_06 setvelocity((0, 0, 600));
      wait(0.1);
      if(isDefined(var_06)) {
        var_06 dodamage(10000, param_01, param_04, param_04, "MOD_EXPLOSIVE");
      }
    }
  }

  self delete();
}

use_timely_torrent(param_00) {
  self endon("disconnect");
  self endon(param_00 + "_timeup");
  level endon("game_ended");
  thread run_timely_torrent(param_00);
}

select_spot_array(param_00, param_01) {
  if(!isDefined(param_00.array_of_torrent_points)) {
    param_00.array_of_torrent_points = [];
  }

  var_02 = param_00.origin;
  var_03 = (0, 128, 0);
  var_04 = param_00 getplayerangles();
  var_05 = 7;
  var_06 = 0;
  var_02 = var_02 + var_03[0] * anglestoright(var_04);
  var_02 = var_02 + var_03[1] * anglesToForward(var_04);
  var_02 = var_02 + var_03[2] * anglestoup(var_04);
  var_07 = rotatepointaroundvector(anglestoup(var_04), anglesToForward(var_04), 0);
  var_08 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_canshootclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_09 = scripts\common\trace::ray_trace(param_00 getEye(), var_02 + var_07, param_00, var_08);
  var_02 = var_09["position"] + var_07;
  if(param_01 == 0) {
    param_00.array_of_torrent_points[param_01] = var_02 + anglesToForward(var_04) * 60;
  } else {
    param_00.array_of_torrent_points[param_01] = var_02 + anglesToForward(var_04) * param_01 + 1 * 60;
  }

  return param_00.array_of_torrent_points;
}

run_timely_torrent(param_00) {
  self endon(param_00 + "_timeup");
  self endon("disconnect");
  level endon("game_ended");
  var_01 = [];
  var_02 = 0;
  for(;;) {
    self waittill("melee_fired");
    for(var_03 = 0; var_03 <= 5; var_03++) {
      var_01 = select_spot_array(self, var_03);
    }

    var_04 = 1200;
    self.closestenemies_array = [];
    var_05 = scripts\cp\cp_agent_utils::get_alive_enemies();
    foreach(var_08, var_07 in var_01) {
      var_01[var_08] = spawn("script_origin", var_07);
    }

    foreach(var_08, var_07 in var_01) {
      if(!isDefined(var_07)) {
        continue;
      }

      var_07 thread torrent_start(param_00, var_07.origin, var_05, var_08, self);
    }

    scripts\cp\utility::notify_used_consumable("timely_torrent");
  }
}

use_purify(param_00) {
  self endon("disconnect");
  self endon(param_00 + "_timeup");
  self endon(param_00 + "_exited_early");
  level endon("game_ended");
  if(!isDefined(level.purify_active)) {
    level.purify_active = 1;
  } else {
    level.purify_active++;
  }

  foreach(var_02 in level.players) {
    if(var_02 scripts\cp\utility::is_valid_player()) {
      thread purify_activate(var_02);
    }
  }

  var_04 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, 24, 99999, 0);
  foreach(var_06 in var_04) {
    var_06 thread dealaoedamage(param_00);
    wait(0.1);
  }

  scripts\cp\utility::notify_used_consumable("purify");
  return 1;
}

purify_activate(param_00) {
  param_00 notify("force_regeneration");
  thread disablepurifyregenafterdelay();
}

disablepurifyregenafterdelay() {
  level endon("game_ended");
  wait(2);
  level.purify_active--;
  if(level.purify_active <= 0) {
    level.purify_active = 0;
  }
}

dealaoedamage(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  var_01 = scripts\cp\cp_agent_utils::get_alive_enemies();
  var_02 = scripts\engine\utility::get_array_of_closest(self.origin, var_01, undefined, 24, 128, 0);
  if(var_02.size > 0) {
    self notify("force_regeneration");
    foreach(var_04 in var_02) {
      if(isDefined(var_04.agent_type) && var_04.agent_type == "zombie_brute" || var_04.agent_type == "zombie_ghost" || var_04.agent_type == "zombie_grey" || var_04.agent_type == "slasher" || var_04.agent_type == "alien_rhino" || var_04.agent_type == "superslasher") {
        continue;
      } else {
        playFX(level._effect["penetration_railgun_explosion"], self.origin);
        var_04 dodamage(var_04.health + 100, var_04.origin, self, self, "MOD_EXPLOSIVE", "iw7_explosive_touch_zm");
      }
    }

    self playSound("zmb_fnf_purify_explo");
  }
}

enable_outline_for_player(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 hudoutlineenableforclient(param_01, param_02, param_03, param_04);
}

disable_outline_for_player(param_00, param_01) {
  param_00 hudoutlinedisableforclient(param_01);
}

_magicbullet(param_00, param_01, param_02, param_03, param_04) {
  var_05 = magicbullet(param_00, param_01, param_02, param_03, param_04);
  if(isDefined(var_05) && isDefined(param_03)) {
    var_05 setotherent(param_03);
  }

  return var_05;
}

use_masochist(param_00) {
  self endon("disconnect");
  self endon(param_00 + "_timeup");
  self endon(param_00 + "_exited_early");
  level endon("game_ended");
  thread removeslowmoveonlaststand(param_00);
  for(;;) {
    self waittill("player_damaged");
    scripts\cp\cp_persistence::give_player_currency(100, undefined, undefined, 1, "bonus");
  }
}

use_explosive_touch(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(param_00 + "_exited_early");
  self endon(param_00 + "_timeup");
  thread remove_explosive_touch(param_00);
  for(;;) {
    if(!scripts\engine\utility::istrue(self.has_explosive_touch)) {
      self.has_explosive_touch = 1;
      thread watch_for_zombie_touch(param_00);
      scripts\cp\utility::adddamagemodifier("health_boost", 0.1, 0);
      self notify("force_regeneration");
      self playlocalsound("breathing_heartbeat_alt");
    }

    scripts\engine\utility::waitframe();
  }
}

watch_for_zombie_touch(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(param_00 + "_exited_early");
  self endon(param_00 + "_timeup");
  while(scripts\engine\utility::istrue(self.has_explosive_touch)) {
    var_01 = scripts\cp\cp_agent_utils::get_alive_enemies();
    foreach(var_03 in var_01) {
      if(scripts\engine\utility::distance_2d_squared(var_03.origin, self.origin) <= 5184) {
        if(var_03 scripts\cp\utility::agentisfnfimmune()) {
          continue;
        }

        if(var_03 scripts\cp\utility::is_zombie_agent() && var_03.agent_type != "slasher" && var_03.agent_type != "superslasher" && var_03.agent_type != "zombie_brute" && var_03.agent_type != "zombie_grey") {
          var_03.exp_touch = 1;
          var_03.nocorpse = 1;
          var_03.full_gib = 1;
          playsoundatpos(var_03 gettagorigin("j_spineupper"), "zmb_fnf_explosive_touch_explo");
          wait(0.1);
          playFX(scripts\engine\utility::getfx("exp_touch"), var_03 gettagorigin("j_spineupper"));
          self radiusdamage(self.origin, 100, var_03.health + 1000, var_03.health, self, "MOD_EXPLOSIVE", "iw7_explosive_touch_zm");
          wait(0.3);
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

remove_explosive_touch(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3(param_00 + "_timeup", param_00 + "_exited_early");
  self.has_explosive_touch = 0;
  scripts\cp\utility::removedamagemodifier("health_boost", 0);
  if(isDefined(self.explosivetrigger)) {
    self.explosivetrigger delete();
  }
}

use_shared_fate(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(param_00 + "_exited_early");
  self endon(param_00 + "_timeup");
  self.marked_ents = [];
  thread look_at_and_outline_enemies(param_00);
  thread damage_on_marked_enemies(param_00);
}

damage_on_marked_enemies(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(param_00 + "_exited_early");
  self endon(param_00 + "_timeup");
  for(;;) {
    self waittill("weapon_hit_marked_target", var_01, var_02, var_03, var_04, var_05);
    self.marked_ents = scripts\engine\utility::array_removeundefined(self.marked_ents);
    self.marked_ents = scripts\engine\utility::array_remove(self.marked_ents, var_05);
    foreach(var_07 in self.marked_ents) {
      if(var_05 == var_07) {
        continue;
      }

      if(var_07 scripts\cp\utility::agentisfnfimmune()) {
        continue;
      }

      if(var_07.health - var_02 <= 0) {
        var_07 setscriptablepartstate("shared_fate_fx", "inactive", 1);
      }

      self.marked_ents = scripts\engine\utility::array_remove(self.marked_ents, var_07);
      var_07 dodamage(var_02, var_07.origin, var_01, var_01, var_03, "iw7_shared_fate_weapon");
    }
  }
}

outline_enemeies(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(param_00 + "_exited_early");
  self endon(param_00 + "_timeup");
  for(;;) {
    foreach(var_02 in self.marked_ents) {
      if(var_02 scripts\cp\utility::agentisfnfimmune()) {
        continue;
      }

      if(isDefined(var_02.agent_type) && var_02.agent_type == "zombie_sasquatch" || var_02.agent_type == "slasher" || var_02.agent_type == "superslasher" || var_02.agent_type == "zombie_brute" || var_02.agent_type == "zombie_grey" || var_02.agent_type == "zombie_clown" || var_02.agent_type == "skater") {
        continue;
      }

      if(scripts\cp\utility::is_melee_weapon(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc_melee(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc2_melee(self getcurrentweapon())) {
        scripts\engine\utility::waitframe();
        continue;
      }

      if(scripts\engine\utility::istrue(var_02.marked_shared_fate_fnf)) {
        var_02 setscriptablepartstate("shared_fate_fx", "active", 1);
        continue;
      }

      if(isDefined(var_02)) {
        var_02 setscriptablepartstate("shared_fate_fx", "inactive", 1);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

look_at_and_outline_enemies(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(param_00 + "_exited_early");
  self endon(param_00 + "_timeup");
  var_01 = 0;
  for(;;) {
    if(self adsbuttonpressed() && !var_01) {
      if(scripts\cp\utility::is_melee_weapon(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc_melee(self getcurrentweapon())) {
        scripts\engine\utility::waitframe();
        continue;
      }

      var_01 = 1;
      var_02 = self getplayerangles();
      var_03 = self getEye();
      var_04 = anglesToForward(var_02);
      var_05 = var_03 + var_04 * 500;
      var_06 = scripts\common\trace::create_contents(1, 0, 0, 0, 0, 0, 0);
      var_07 = physics_raycast(var_03, var_05, var_06, self, 0, "physicsquery_closest");
      if(var_07.size <= 0) {
        scripts\engine\utility::waitframe();
        continue;
      }

      var_08 = var_07[0]["entity"];
      if(isDefined(var_08)) {
        if(var_08 scripts\cp\utility::agentisfnfimmune()) {
          continue;
        }

        if(isDefined(var_08.agent_type) && var_08.agent_type == "zombie_sasquatch" || var_08.agent_type == "slasher" || var_08.agent_type == "superslasher" || var_08.agent_type == "zombie_brute" || var_08.agent_type == "zombie_grey" || var_08.agent_type == "zombie_clown") {
          continue;
        }

        if(var_08 scripts\cp\utility::is_zombie_agent()) {
          if(!scripts\engine\utility::array_contains(self.marked_ents, var_08)) {
            self playlocalsound("zmb_fnf_shared_fate_highlight");
            var_08.marked_shared_fate_fnf = 1;
            self.marked_ents = scripts\engine\utility::array_add(self.marked_ents, var_08);
            var_08 setscriptablepartstate("shared_fate_fx", "active", 1);
          }
        }
      }

      var_01 = 0;
    } else {
      var_01 = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

use_fire_chains(param_00) {
  self endon(param_00 + "_timeup");
  self endon("last_stand");
  self endon("disconnect");
  level endon("game_ended");
  self.life_link_active = undefined;
  self.life_linked = 1;
  var_01 = "j_spine4";
  var_02 = ["j_spine4", "j_spineupper", "j_spinelower", "j_head", "j_knee_ri", "j_knee_le", "j_elbow_ri", "j_elbow_le", "j_ankle_le", "j_ankle_ri", "j_wrist_le", "j_wrist_ri"];
  thread removefirechainsdamagemodifierontimeout(param_00);
  thread removefirechainsdamagemodifieronlaststand(param_00);
  var_03 = self;
  for(;;) {
    var_04 = getfirechainstarget(self);
    if(isDefined(var_04)) {
      self.besttarget = var_04;
      self.linked_to_player = 1;
      thread playfirechainsfx(var_04, var_01, param_00);
      var_03.life_link_active = 1;
      linktoplayer_fire_chains(self, var_04, var_02);
    } else {
      var_03.life_link_active = undefined;
      wait(0.5);
    }

    scripts\engine\utility::waitframe();
  }
}

getfirechainstarget(param_00) {
  var_01 = scripts\engine\utility::get_array_of_closest(param_00.origin, level.players, [param_00], 4, 512);
  var_02 = sortbydistance(var_01, param_00.origin);
  var_03 = undefined;
  foreach(var_05 in var_02) {
    var_06 = sighttracepassed(param_00 getEye(), var_05 getEye(), 0, param_00);
    if(!var_06) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_05.inlaststand)) {
      continue;
    }

    var_03 = var_05;
    break;
  }

  return var_03;
}

linktoplayer_fire_chains(param_00, param_01, param_02) {
  param_01 endon("disconnect");
  param_00 endon("disconnect");
  while(scripts\engine\utility::istrue(param_00.linked_to_player)) {
    thread deal_damage_to_zombies_entering_the_link(self, param_02);
    if(scripts\engine\utility::istrue(param_01.inlaststand)) {
      param_00.linked_to_player = undefined;
      param_00 notify("lost_target_fire_chains");
      break;
    } else if(distance(param_00.origin, param_01.origin) > 512) {
      param_00.linked_to_player = undefined;
      param_00 notify("lost_target_fire_chains");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

deal_damage_to_zombies_entering_the_link(param_00, param_01) {
  param_00 endon("disconnect");
  var_02 = [];
  var_03 = scripts\common\trace::create_character_contents();
  var_02 = [param_00, param_00.besttarget];
  if(!isDefined(param_00.besttarget)) {
    return;
  }

  foreach(var_05 in param_01) {
    var_06 = scripts\common\trace::ray_trace(param_00 gettagorigin(var_05), param_00.besttarget gettagorigin(var_05), var_02, var_03);
    if(isDefined(var_06["entity"])) {
      if(var_06["entity"] scripts\cp\utility::agentisfnfimmune()) {
        continue;
      }

      var_07 = scripts\engine\utility::istrue(var_06["entity"].is_skeleton);
      if(level.script == "cp_final") {
        var_07 = 0;
      }

      if(var_06["entity"] scripts\cp\utility::is_zombie_agent() && var_06["entity"].agent_type != "slasher" && var_06["entity"].agent_type != "superslasher" && var_06["entity"].agent_type != "zombie_brute" && var_06["entity"].agent_type != "zombie_grey") {
        scripts\engine\utility::array_add(var_02, var_06["entity"]);
        var_06["entity"].nocorpse = 1;
        var_06["entity"].full_gib = 1;
        var_06["entity"] dodamage(1000000, var_06["entity"].origin, param_00, param_00);
      }
    }
  }
}

playfirechainsfx(param_00, param_01, param_02) {
  var_03 = [];
  foreach(var_05 in level.players) {
    var_03[var_03.size] = playfxontagsbetweenclients(level._effect["fire_chains"], self, param_01, param_00, param_01, var_05);
  }

  self.fx_array_fire_chains = var_03;
  self playLoopSound("zmb_fnf_fire_chains_lp");
  param_00 playLoopSound("zmb_fnf_fire_chains_lp");
  var_07 = scripts\cp\utility::waittill_any_ents_return(self, "disconnect", self, "lost_target_fire_chains", self, "last_stand", self, param_02 + "_timeup", param_00, "disconnect", param_00, "last_stand", level, "game_ended");
  if(isDefined(self)) {
    self stoploopsound();
  }

  if(isDefined(param_00)) {
    param_00 stoploopsound();
  }

  foreach(var_09 in var_03) {
    if(isDefined(var_09)) {
      var_09 delete();
    }
  }
}

removefirechainsdamagemodifieronlaststand(param_00) {
  self endon(param_00 + "_timeup");
  self waittill("last_stand");
  self.life_linked = undefined;
  self.life_link_active = undefined;
  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
  }

  self notify(param_00 + "_exited_early");
}

removefirechainsdamagemodifierontimeout(param_00) {
  self endon("last_stand");
  self waittill(param_00 + "_timeup");
  self.life_linked = undefined;
  self.life_link_active = undefined;
  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
  }
}

use_irish_luck(param_00) {
  self endon(param_00 + "_timeup");
  self endon("last_stand");
  self endon("disconnect");
  level endon("game_ended");
}

irish_luck_choose_random_consumable(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  if(!isDefined(param_00.stored_fnf)) {
    param_00.stored_fnf = [];
  }

  foreach(var_03, var_02 in param_00.consumables) {
    param_00.stored_fnf[var_03] = var_03;
  }

  for(;;) {
    var_04 = scripts\engine\utility::random(level.irish_luck_consumables);
    if(getdvar("irish_luck_debug", "") != "") {
      param_00.stored_fnf = [];
      var_05 = getdvar("irish_luck_debug", "");
      foreach(var_08, var_07 in level.irish_luck_consumables) {
        if(var_08 == var_05) {
          var_04 = level.irish_luck_consumables[var_08];
        }
      }
    }

    if(scripts\engine\utility::array_contains(param_00.stored_fnf, var_04.name)) {
      scripts\engine\utility::waitframe();
      continue;
    } else {
      scripts\engine\utility::waitframe();
      return var_04;
    }

    scripts\engine\utility::waitframe();
  }
}

clear_omnvar(param_00) {
  self endon("disconnect");
  wait(5);
  self setclientomnvar(param_00, 0);
}

consumable_activate_internal_irish(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("dpad_end_" + param_00);
  self endon("give_new_deck");
  self endon("last_stand");
  level.random_consumable_chosen = irish_luck_choose_random_consumable(self);
  if(self.consumables[param_00].uses > 0 && self.consumables[param_00].on == 0 && !scripts\cp\cp_laststand::player_in_laststand(self)) {
    self.consumables[level.random_consumable_chosen.name] = spawnStruct();
    self.consumables[level.random_consumable_chosen.name].uses = level.consumables[level.random_consumable_chosen.name].uses;
    self.consumables[level.random_consumable_chosen.name].on = 1;
    self.consumables[level.random_consumable_chosen.name].times_used = 0;
    self.consumables[level.random_consumable_chosen.name].usednotify = param_04;
    level.random_consumable_chosen.ref = int(tablelookup("cp\loot\iw7_zombiefatefortune_loot_master.csv", 1, level.random_consumable_chosen.name, 0));
    self setclientomnvar("zm_ui_irish_luck", level.random_consumable_chosen.ref);
    thread clear_omnvar("zm_ui_irish_luck");
    self setclientomnvar("zm_fate_card_used", param_05);
    self.consumables[param_00].processing = 1;
    var_07 = undefined;
    var_08 = "fired_super";
    thread set_consumable(param_00);
    if(isDefined(level.consumables[level.random_consumable_chosen.name].usefunc)) {
      if(isDefined(level.consumables[level.random_consumable_chosen.name].testforsuccess)) {
        var_07 = self[[level.consumables[level.random_consumable_chosen.name].usefunc]](level.random_consumable_chosen.name);
      } else {
        var_07 = self thread[[level.consumables[level.random_consumable_chosen.name].usefunc]](level.random_consumable_chosen.name);
      }
    }

    self.consumables[param_00].on = 0;
    if(!isDefined(var_07) || isDefined(var_07) && var_07) {
      consume_from_inventory(self, param_00);
      self.consumables[param_00].times_used++;
      scripts\cp\zombies\zombie_analytics::log_fafcardused(1, param_00, level.wave_num, self);
      scripts\cp\cp_merits::processmerit("mt_faf_uses");
      thread scripts\cp\cp_vo::try_to_play_vo("wonder_consume", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      if(self.consumables[param_00].times_used == 1) {
        thread decrement_counter_of_consumables(param_00);
      }

      thread lightbar_off();
      self setclientomnvar("zm_dpad_up_activated", 5);
      self setclientomnvarbit("zm_card_fill_display", param_05, 1);
      self setclientomnvar("zm_consumable_selection_ready", 0);
      remove_card_from_use(param_06);
      thread meter_fill_up();
      self playlocalsound("ui_consumable_select");
      play_consumable_activate_sound(self);
      self notify("consumable_selected");
      self setweaponammostock(self.fate_card_weapon, 1);
      self giveandfireoffhand(self.fate_card_weapon);
      self.consumable_meter_full = undefined;
      thread scripts\cp\cp_vo::remove_from_nag_vo("nag_use_fateandfort");
      var_09 = level.consumables[level.random_consumable_chosen.name].type;
      if(var_09 == "timedactivations") {
        thread dpad_drain_time(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].usageperiod, param_01, var_08, param_02, param_03, param_04, param_05);
      } else if(var_09 == "wave") {
        thread dpad_drain_wave(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].usageperiod, param_01, var_08, param_02, param_03, param_04, param_05);
      } else if(var_09 == "triggernow" || level.consumables[level.random_consumable_chosen.name].type == "triggerwait") {
        thread dpad_drain_activations(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].type, self.consumables[level.random_consumable_chosen.name].uses, param_01, var_08, param_02, param_03, param_04, param_05);
      } else if(var_09 == "triggerpassive") {
        thread dpad_drain_triggerpassive(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].passiveuses, param_01, var_08, param_02, param_03, param_04, param_05);
      }

      if(isDefined(var_07)) {
        scripts\cp\utility::notify_used_consumable(param_00);
        return;
      }

      return;
    }

    self playlocalsound("ui_consumable_deny");
    self.consumables[param_00].processing = undefined;
  }
}

use_temporal_increase(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(param_00 + "_exited_early");
  self endon(param_00 + "_timeup");
  self endon("last_stand");
  if(isDefined(level.temporal_increase)) {
    return 0;
  }

  level.temporal_increase = 2;
  thread remove_temporal_increase(param_00);
}

remove_temporal_increase(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3(param_00 + "_timeup", "disconnect", "death", param_00 + "_exited_early");
  level.temporal_increase = undefined;
  return 1;
}

use_twister(param_00) {
  self endon("disconnect");
  self endon(param_00 + "_timeup");
  self endon(param_00 + "_exited_early");
  self endon("death");
  self endon("last_stand");
  level endon("game_ended");
  var_01 = self getplayerangles();
  var_02 = self getEye();
  var_03 = (0, 0, 0);
  var_04 = anglesToForward(var_01);
  var_05 = var_02 + var_04 * 100;
  thread remove_twister(param_00, self);
  thread activate_twister_homing(self.origin, param_00);
}

remove_twister(param_00, param_01) {
  level endon("game_ended");
  param_01 scripts\engine\utility::waittill_any_3(param_00 + "_timeup", param_00 + "_exited_early", "disconnect");
  level notify("stop_twister_sfx");
  if(isDefined(param_01.fx_ent)) {
    param_01.fx_ent delete();
  }

  if(isDefined(param_01.trigger_move_ent)) {
    param_01.trigger_move_ent delete();
  }
}

activate_twister_homing(param_00, param_01) {
  self endon("disconnect");
  self endon(param_01 + "_timeup");
  self endon(param_01 + "_exited_early");
  level endon("game_ended");
  if(!isDefined(self.twister_array_zombie)) {
    self.twister_array_zombie = [];
  }

  self.trigger_move_ent = spawn("script_model", param_00, 0, 512, 128);
  self.trigger_move_ent setModel("tag_origin");
  level.trigger_move_ent_sfx = spawn("script_model", param_00, 0, 512, 128);
  level.trigger_move_ent_sfx linkto(self.trigger_move_ent);
  wait(0.5);
  level.trigger_move_ent_sfx thread twister_sfx();
  playFXOnTag(level._effect["twister"], self.trigger_move_ent, "tag_origin");
  self.trigger_move_ent setotherent(self);
  self.trigger_move_ent thread deal_damage_to_enemies(self, param_01);
  thread move_ent_function(self.trigger_move_ent, param_01);
}

twister_sfx() {
  self playSound("fnf_tornado_start_lr");
  wait(0.4);
  self playLoopSound("fnf_tornado_lr_lp");
  level waittill("stop_twister_sfx");
  level thread scripts\engine\utility::play_sound_in_space("fnf_tornado_stop_lr", self.origin);
  wait(0.15);
  self stoploopsound();
  self delete();
}

get_zombie_targets(param_00, param_01) {
  param_00 endon("disconnect");
  param_00 endon(param_01 + "_timeup");
  param_00 endon(param_01 + "_exited_early");
  level endon("game_ended");
  for(;;) {
    var_02 = scripts\cp\cp_agent_utils::get_alive_enemies();
    var_03 = scripts\engine\utility::get_array_of_closest(param_00.origin, var_02, undefined, 24, 2048);
    if(isDefined(level.dlc4_boss)) {
      if(scripts\engine\utility::array_contains(var_03, level.dlc4_boss)) {
        var_03 = scripts\engine\utility::array_remove(var_03, level.dlc4_boss);
      }
    }

    if(var_03.size <= 0) {
      scripts\engine\utility::waitframe();
      param_00.twister_array_zombie = [];
      param_00.twister_array_zombie[param_00.twister_array_zombie.size] = getclosestpointonnavmesh(self.origin) + (0, 10, 0);
      continue;
    } else {
      foreach(var_05 in var_03) {
        if(var_05 scripts\cp\utility::agentisfnfimmune() && var_05.agent_type != "alien_rhino") {
          scripts\engine\utility::waitframe();
          continue;
        }

        if(scripts\engine\utility::istrue(level.meph_fight_started)) {
          if(var_05 scripts\cp\utility::agentisfnfimmune()) {
            scripts\engine\utility::waitframe();
            continue;
          } else {
            param_00.twister_array_zombie = param_00 findpath(param_00.origin, scripts\engine\utility::drop_to_ground(var_03[var_03.size - 1].origin, 1, 1));
          }

          continue;
        }

        if(isDefined(level.rhino_array) && level.rhino_array.size > 0) {
          param_00.twister_array_zombie = param_00 findpath(param_00.origin, scripts\engine\utility::drop_to_ground(var_03[var_03.size - 1].origin, 1, 1));
          continue;
        }

        if(scripts\engine\utility::istrue(var_05.entered_playspace)) {
          param_00.twister_array_zombie = param_00 findpath(param_00.origin, scripts\engine\utility::drop_to_ground(var_03[var_03.size - 1].origin, 1, 1));
        }
      }
    }

    wait(2.5);
  }
}

deal_damage_to_enemies(param_00, param_01) {
  self endon("death");
  param_00 endon("disconnect");
  param_00 endon(param_01 + "_timeup");
  param_00 endon(param_01 + "_exited_early");
  level endon("game_ended");
  for(;;) {
    var_02 = scripts\cp\cp_agent_utils::get_alive_enemies();
    foreach(var_04 in var_02) {
      if(!isDefined(var_04)) {
        continue;
      }

      if(!var_04 scripts\cp\utility::is_zombie_agent()) {
        continue;
      }

      if(distance2dsquared(self.origin, var_04.origin) < 22500) {
        if(var_04 scripts\cp\utility::agentisfnfimmune()) {
          var_04 dodamage(5, var_04.origin, param_00, param_00, "MOD_UNKNOWN");
          continue;
        }

        if(isDefined(var_04.agent_type) && var_04.agent_type == "slasher" || var_04.agent_type == "superslasher") {
          var_04 dodamage(1000, var_04.origin, param_00, param_00, "MOD_UNKNOWN");
          continue;
        }

        var_04 thread fling_zombie_thundergun_harpoon(var_04.health + 1000, var_04, param_00, self);
      }
    }

    wait(1);
  }
}

fling_zombie_thundergun_harpoon(param_00, param_01, param_02, param_03) {
  self endon("death");
  param_03 endon("death");
  if(!isDefined(param_03)) {
    return;
  }

  var_04 = param_01.origin - param_03.origin;
  var_05 = anglestoup(self.angles);
  self setvelocity(vectornormalize(param_03.origin - self.origin * 400) + (0, 0, 800));
  wait(0.16);
  if(isDefined(param_02)) {
    param_01.do_immediate_ragdoll = 1;
    param_01.disable_armor = 1;
    param_01.customdeath = 1;
    wait(0.1);
    param_01.nocorpse = 1;
    param_01.full_gib = 1;
    self dodamage(self.health + 1000, param_01.origin, param_02, param_02, "MOD_UNKNOWN", "iw7_twister_zm");
    return;
  }

  self.nocorpse = 1;
  self.full_gib = 1;
  self dodamage(self.health + 1000, param_01.origin, param_01, param_01, "MOD_UNKNOWN", "iw7_twister_zm");
}

move_ent_function(param_00, param_01) {
  self endon("disconnect");
  self endon(param_01 + "_timeup");
  self endon(param_01 + "_exited_early");
  var_02 = 0;
  thread get_zombie_targets(self, param_01);
  for(;;) {
    if(!isDefined(self.twister_array_zombie[var_02]) && var_02 >= self.twister_array_zombie.size) {
      if(self.twister_array_zombie.size > 0) {
        if(isDefined(self.twister_array_zombie[0])) {
          if([
              [level.active_volume_check]
            ](self.twister_array_zombie[0])) {
            param_00 moveto(self.twister_array_zombie[0], 0.5, 0.25, 0);
          } else {
            var_03 = getclosestpointonnavmesh(self.twister_array_zombie[0]) + (0, 10, 0);
            param_00 moveto(var_03, 0.5);
          }

          var_02--;
        }
      } else {
        var_02 = 0;
      }

      scripts\engine\utility::waitframe();
      continue;
    } else {
      param_00 moveto(self.twister_array_zombie[var_02], 0.5, 0, 0);
    }

    var_02 = var_02 + 1;
    scripts\engine\utility::waitframe();
  }
}

use_dodge_mode(param_00) {
  self endon("disconnect");
  self endon(param_00 + "_timeup");
  self endon(param_00 + "_exited_early");
  self endon("last_stand");
  self endon("death");
  level endon("game_ended");
  self energy_setmax(1, 50);
  self goal_radius(1, 50);
  self goalflag(1, 25);
  self goal_type(1, 0);
  self allowdodge(1);
  self _meth_8454(5);
  thread func_139F9(param_00);
  thread remove_dodge_mode(param_00);
}

remove_dodge_mode(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3(param_00 + "_timeup", param_00 + "_exited_early", "death", "last_stand");
  self allowdodge(0);
  self notify(param_00 + "_timeup");
  self notify(param_00 + "_exited_early");
}

watchforzombiecollisions(param_00) {
  self endon("death");
  self endon("disconnect");
  self notify("setDodge");
  self endon("setDodge");
  self endon(param_00 + "_timeup");
  self endon(param_00 + "_exited_early");
  level endon("game_ended");
  self endon("last_stand");
  while(scripts\engine\utility::istrue(self.dodging)) {
    var_01 = scripts\cp\cp_agent_utils::get_alive_enemies();
    foreach(var_03 in var_01) {
      if(scripts\engine\utility::distance_2d_squared(var_03.origin, self.origin) <= 5184) {
        if(var_03 scripts\cp\utility::agentisfnfimmune()) {
          continue;
        }

        if(var_03 scripts\cp\utility::is_zombie_agent() && var_03.agent_type != "slasher" && var_03.agent_type != "superslasher" && var_03.agent_type != "zombie_brute" && var_03.agent_type != "zombie_grey") {
          var_03.exp_touch = 1;
          var_03.nocorpse = 1;
          var_03.full_gib = 1;
          var_03.hit_by_dodging_player = 1;
          playsoundatpos(var_03 gettagorigin("j_spineupper"), "zmb_fnf_explosive_touch_explo");
          wait(0.1);
          playFX(scripts\engine\utility::getfx("dodge_touch"), var_03 gettagorigin("j_spineupper"));
          var_03 dodamage(var_03.health + 100, var_03.origin, self, self, "MOD_EXPLOSIVE", "iw7_pickup_zm");
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_139F9(param_00) {
  self endon("disconnect");
  self endon(param_00 + "_timeup");
  self endon(param_00 + "_exited_early");
  level endon("game_ended");
  self endon("last_stand");
  self endon("death");
  for(;;) {
    self waittill("dodgeBegin");
    if(isDefined(self.controlsfrozen) && self.controlsfrozen == 1) {
      continue;
    }

    self.dodging = 1;
    thread func_139FB(param_00);
    thread watchforzombiecollisions(param_00);
    var_01 = self getnormalizedmovement();
    for(;;) {
      if(var_01[0] > 0) {
        if(var_01[1] <= 0.7 && var_01[1] >= -0.7) {
          playFX(scripts\engine\utility::getfx("dodge_fwd_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
          break;
        }

        if(var_01[0] > 0.5 && var_01[1] > 0.7) {
          playFX(scripts\engine\utility::getfx("dodge_fwd_right_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
          break;
        }

        if(var_01[0] > 0.5 && var_01[1] < -0.7) {
          playFX(scripts\engine\utility::getfx("dodge_fwd_left_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
          break;
        }
      }

      if(var_01[0] < 0) {
        if(var_01[1] < 0.4 && var_01[1] > -0.4) {
          playFX(scripts\engine\utility::getfx("dodge_back_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
          break;
        }

        if(var_01[0] < -0.5 && var_01[1] > 0.5) {
          playFX(scripts\engine\utility::getfx("dodge_back_right_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
          break;
        }

        if(var_01[0] < -0.5 && var_01[1] < -0.5) {
          playFX(scripts\engine\utility::getfx("dodge_back_left_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
          break;
        }
      }

      if(var_01[1] > 0.4) {
        playFX(scripts\engine\utility::getfx("dodge_right_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
        break;
      }

      if(var_01[1] < -0.4) {
        playFX(scripts\engine\utility::getfx("dodge_left_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
        break;
      } else {
        break;
      }
    }

    self playlocalsound("zmb_fnf_evade");
    self playSound("zmb_fnf_evade_npc");
  }
}

func_139FB(param_00) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("dodgeEnd", "death", "disconnect", "last_stand");
  self.dodging = 0;
  if(isDefined(self.var_5809)) {
    self.var_5809 delete();
  }
}

use_ammo_crate(param_00) {
  if(isDefined(level.ammo_crate)) {
    self.consumables[param_00].on = 0;
    return 0;
  }

  create_ammo_crate_interaction(param_00);
}

create_ammo_crate_interaction(param_00) {
  self endon("disconnect");
  self endon(param_00 + "_timeup");
  self endon(param_00 + "_exited_early");
  self endon("death");
  self endon("last_stand");
  level endon("game_ended");
  var_01 = scripts\engine\utility::drop_to_ground(self.origin, 0, -2000);
  var_02 = spawn("script_model", var_01);
  var_02 setModel("tag_origin_ammo_crate");
  level.ammo_crate = var_02;
  level.ammo_crate thread give_ammo_to_players_standing_nearby(self, param_00);
  thread remove_ammo_crate(param_00);
}

give_ammo_to_players_standing_nearby(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("last_stand");
  self endon("death");
  param_00 endon("disconnect");
  param_00 endon(param_01 + "_timeup");
  param_00 endon(param_01 + "_exited_early");
  level endon("game_ended");
  for(;;) {
    foreach(param_00 in level.players) {
      if(!isDefined(param_00)) {
        continue;
      }

      if(distance2dsquared(self.origin, param_00.origin) < 22500) {
        if(param_00 cangive_ammo()) {
          playFX(level._effect["ammo_crate_ping"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
          param_00 give_ammo_to_player_through_crate();
          param_00 notify("consumable_charge", 150);
          param_00 thread scripts\cp\cp_vo::try_to_play_vo("pillage_ammo", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
          scripts\engine\utility::waitframe();
          continue;
        }

        param_00 scripts\cp\utility::setlowermessage("max_ammo", & "COOP_GAME_PLAY_AMMO_MAX", 3);
      }
    }

    wait(5);
  }
}

cangive_ammo() {
  var_00 = scripts\cp\utility::getvalidtakeweapon();
  var_01 = self getweaponammoclip(var_00);
  var_02 = weaponclipsize(var_00);
  var_03 = weaponmaxammo(var_00);
  var_04 = self getweaponammostock(var_00);
  if(var_04 < var_03 || var_01 < var_02) {
    return 1;
  }

  return 0;
}

give_ammo_to_player_through_crate() {
  var_00 = self getweaponslistprimaries();
  foreach(var_02 in var_00) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(weapontype(var_02) == "riotshield") {
      continue;
    }

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_02)) {
      continue;
    }

    var_03 = weaponclipsize(var_02);
    adjust_clip_ammo_from_stock(self, var_02, "right", var_03, 0);
    if(self isdualwielding()) {
      adjust_clip_ammo_from_stock(self, var_02, "left", var_03, 1);
    }
  }

  self playlocalsound("weap_ammo_pickup");
}

adjust_clip_ammo_from_stock(param_00, param_01, param_02, param_03, param_04) {
  if(!scripts\engine\utility::istrue(param_04)) {
    var_05 = weaponmaxammo(param_01);
    var_06 = param_00 getweaponammostock(param_01);
    var_07 = var_05 - var_06;
    var_08 = scripts\engine\utility::ter_op(var_07 >= param_03, var_06 + param_03, var_05);
    param_00 setweaponammostock(param_01, var_08);
  }

  var_09 = param_00 getweaponammoclip(param_01, param_02);
  var_0A = param_03 - var_09;
  var_0B = min(var_09 + var_0A, param_03);
  param_00 setweaponammoclip(param_01, int(var_0B), param_02);
}

remove_ammo_crate(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3(param_00 + "_timeup", param_00 + "_exited_early", "last_stand", "death");
  scripts\cp\utility::notify_used_consumable("ammo_crate");
  if(isDefined(level.ammo_crate)) {
    level.ammo_crate delete();
  }
}

use_stimulus(param_00) {
  self endon("disconnect");
  self endon(param_00 + "_timeup");
  self endon(param_00 + "_exited_early");
  self endon("death");
  self endon("last_stand");
  level endon("game_ended");
  self.stimulus_active = 1;
  thread remove_stimulus(param_00);
}

revive_downed_entities(param_00) {
  param_00 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  scripts\cp\cp_laststand::instant_revive(param_00);
  param_00 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
}

remove_stimulus(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3(param_00 + "_timeup", param_00 + "_exited_early", "last_stand", "death");
  if(scripts\engine\utility::istrue(self.stimulus_active)) {
    self.stimulus_active = undefined;
  }
}

applyvisionsettoallplayers(param_00) {
  level.current_vision_set = param_00;
  level.vision_set_override = level.current_vision_set;
  foreach(var_02 in level.players) {
    if(!var_02 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!isalive(var_02)) {
      continue;
    }

    var_02 visionsetnakedforplayer(param_00, 1);
  }

  switch (param_00) {
    case "cp_town_bw_r":
      param_00 = "cp_town_bw_r";
      if(level.bomb_compound.color == "red") {
        setomnvar("zm_chem_value_choice", level.bomb_compound.choice);
        setomnvar("zm_chem_bvalue_choice", 0);
      } else {
        setomnvar("zm_chem_bvalue_choice", level.bad_choice_index_color_red);
        setomnvar("zm_chem_value_choice", 0);
      }

      setomnvar("zm_chem_current_color", 1);
      break;

    case "cp_town_bw_g":
      param_00 = "cp_town_bw_g";
      if(level.bomb_compound.color == "green") {
        setomnvar("zm_chem_value_choice", level.bomb_compound.choice);
        setomnvar("zm_chem_bvalue_choice", 0);
      } else {
        setomnvar("zm_chem_bvalue_choice", level.bad_choice_index_color_green);
        setomnvar("zm_chem_value_choice", 0);
      }

      setomnvar("zm_chem_current_color", 2);
      break;

    case "cp_town_bw_b":
      param_00 = "cp_town_bw_b";
      if(level.bomb_compound.color == "blue") {
        setomnvar("zm_chem_value_choice", level.bomb_compound.choice);
        setomnvar("zm_chem_bvalue_choice", 0);
      } else {
        setomnvar("zm_chem_bvalue_choice", level.bad_choice_index_color_blue);
        setomnvar("zm_chem_value_choice", 0);
      }

      setomnvar("zm_chem_current_color", 3);
      break;

    case "cp_town_color":
      param_00 = "cp_town_color";
      setomnvar("zm_chem_current_color", 0);
      setomnvar("zm_chem_bvalue_choice", level.bad_choice_index_default);
      setomnvar("zm_chem_value_choice", 0);
      break;
  }
}

use_activate_gns_machine(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  foreach(var_02 in level.players) {
    if(self != var_02) {
      if(var_02 scripts\cp\utility::is_consumable_active(param_00)) {
        self playlocalsound("ui_consumable_deny");
        return 0;
      }
    }
  }

  level.skulls_before_activation = getomnvar("zm_num_ghost_n_skull_coin");
  if(level.skulls_before_activation == 6 || level.skulls_before_activation == -1) {
    return 0;
  }

  self.activate_gns_machine = 1;
  level thread wait_for_player_activation(self);
  thread remove_activate_gns_machine(param_00);
  self waittill("end_this_gns_fnf_card");
  if(isDefined(level.gns_game_console_vfx)) {
    level.gns_game_console_vfx delete();
  }

  if(isDefined(level.entered_thru_card)) {
    level.entered_thru_card = undefined;
  }

  scripts\cp\utility::notify_used_consumable(param_00);
  self notify(param_00 + "_timeup");
  self notify(param_00 + "_exited_early");
}

remove_activate_gns_machine(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_this_gns_fnf_card");
  for(;;) {
    var_01 = scripts\cp\utility::waittill_any_ents_return(self, "last_stand", self, param_00 + "_timeup", self, param_00 + "_exited_early", level, "end_this_thread_of_gns_fnf_card");
    if(isDefined(var_01)) {
      if(var_01 == "last_stand") {
        if(!scripts\engine\utility::istrue(level.entered_thru_card)) {
          cleanup_gns_scriptstuff();
        }

        continue;
      }

      cleanup_gns_scriptstuff();
    }
  }
}

cleanup_gns_scriptstuff() {
  if(scripts\engine\utility::istrue(self.activate_gns_machine)) {
    self.activate_gns_machine = undefined;
  }

  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::update_num_of_coin_inserted(level.skulls_before_activation);
  if(level.script == "cp_town") {
    if(!isDefined(level.film_grain_off)) {
      level thread applyvisionsettoallplayers("cp_town_bw");
    } else {
      level thread applyvisionsettoallplayers(level.current_vision_set);
    }
  }

  self notify("end_this_gns_fnf_card");
}

get_activated_vfx_postion_based_on_map(param_00) {
  switch (param_00) {
    case "cp_zmb":
      return (5459, -4767, 29);

    case "cp_rave":
      return (-282, -1483, 437);

    case "cp_disco":
      return (-713, 2609, 943);

    case "cp_town":
      return (5459, -4767, 29);

    case "cp_final":
      return (5638, -6260, 103);
  }
}

get_corner_position_based_on_map(param_00) {
  switch (param_00) {
    case "cp_zmb":
      return (2874, -542, 242);

    case "cp_rave":
      return (-294, -1469, 396);

    case "cp_disco":
      return (-731, 2611, 898);

    case "cp_town":
      return (5444, -4760, -14);

    case "cp_final":
      return (5652, -6231, 71);
  }
}

get_activation_radius_square_based_on_map(param_00) {
  switch (param_00) {
    case "cp_zmb":
      return 2500;

    case "cp_rave":
      return 2500;

    case "cp_disco":
      return 2500;

    case "cp_town":
      return 10000;

    case "cp_final":
      return 10000;
  }
}

wait_for_player_activation(param_00) {
  self endon("last_stand");
  self endon("end_this_gns_fnf_card");
  level endon("player_debug_activate_cabinet");
  level endon("end_this_thread_of_gns_fnf_card");
  var_01 = get_activated_vfx_postion_based_on_map(level.script);
  var_02 = undefined;
  if(level.script == "cp_zmb") {
    var_02 = disable_arcade_cabinet_next_to_ghost_n_skull();
    var_03 = getent("ghost_arcade_activation_area", "targetname");
  }

  level.gns_game_console_vfx = spawnfx(level._effect["GnS_activation"], var_01);
  triggerfx(level.gns_game_console_vfx);
  var_04 = get_corner_position_based_on_map(level.script);
  var_05 = get_activation_radius_square_based_on_map(level.script);
  for(;;) {
    var_06 = 1;
    foreach(var_08 in level.players) {
      if(scripts\engine\utility::istrue(var_08.inlaststand)) {
        var_06 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_08.iscarrying)) {
        var_06 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_08.isusingsupercard)) {
        var_06 = 0;
        break;
      }

      if(distancesquared(var_08.origin, var_04) > var_05) {
        var_06 = 0;
        break;
      }

      if(!var_08 usebuttonpressed()) {
        var_06 = 0;
        break;
      }

      if(!scripts\engine\utility::istrue(param_00.activate_gns_machine)) {
        var_06 = 0;
        break;
      }
    }

    wait(0.25);
    if(var_06) {
      var_06 = 1;
      foreach(var_08 in level.players) {
        if(scripts\engine\utility::istrue(var_08.inlaststand)) {
          var_06 = 0;
          break;
        }

        if(scripts\engine\utility::istrue(var_08.iscarrying)) {
          var_06 = 0;
          break;
        }

        if(scripts\engine\utility::istrue(var_08.isusingsupercard)) {
          var_06 = 0;
          break;
        }

        if(distancesquared(var_08.origin, var_04) > var_05) {
          var_06 = 0;
          break;
        }

        if(!var_08 usebuttonpressed()) {
          var_06 = 0;
          break;
        }

        if(!scripts\engine\utility::istrue(param_00.activate_gns_machine)) {
          var_06 = 0;
          break;
        }

        if(level.script == "cp_disco") {
          if(isDefined(level.clock_interaction) && isDefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_08) {
            var_06 = 0;
          }

          if(isDefined(level.clock_interaction_q2) && isDefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_08) {
            var_06 = 0;
          }

          if(isDefined(level.clock_interaction_q3) && isDefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_08) {
            var_06 = 0;
          }

          if(scripts\engine\utility::istrue(var_08.start_breaking_clock)) {
            var_06 = 0;
          }

          if(scripts\engine\utility::istrue(var_08.is_using_gourd)) {
            var_06 = 0;
          }

          if(scripts\engine\utility::istrue(var_08.kung_fu_mode)) {
            var_06 = 0;
          }
        }
      }
    }

    if(var_06) {
      if(isDefined(level.gns_game_console_vfx)) {
        level.gns_game_console_vfx delete();
        if(level.script == "cp_zmb") {
          enable_arcade_cabinet_next_to_ghost_n_skull(var_02);
        }

        level thread complete_clean_arcade_cabinet();
        return;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

complete_clean_arcade_cabinet() {
  level.entered_thru_card = 1;
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::notify_activation_progress(level.skulls_before_activation, 0.5);
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::start_ghost_wave();
}

disable_arcade_cabinet_next_to_ghost_n_skull() {
  var_00 = get_arcade_interaction_next_to_ghost_n_skull();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_00);
  return var_00;
}

enable_arcade_cabinet_next_to_ghost_n_skull(param_00) {
  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

get_arcade_interaction_next_to_ghost_n_skull() {
  var_00 = (2829, -538, 241);
  foreach(var_02 in level.current_interaction_structs) {
    if(distancesquared(var_02.origin, var_00) < 100) {
      return var_02;
    }
  }
}

use_get_pap2_gun(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(param_00 + "_exited_early");
  if(self isonladder()) {
    self.consumables[param_00].on = 0;
    self playlocalsound("perk_machine_deny");
    return 0;
  }

  if(scripts\engine\utility::istrue(self.is_in_pap)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(level.gns_active)) {
    return 0;
  }

  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    self.consumables[param_00].on = 0;
    return 0;
  }

  var_01 = choose_random_weapon_from_list(param_00);
  scripts\cp\utility::notify_used_consumable(param_00);
  return var_01;
}

choose_random_weapon_from_list(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(param_00 + "_exited_early");
  self endon(param_00 + "_timeup");
  for(;;) {
    var_01 = scripts\engine\utility::random(level.pap);
    var_02 = self getcurrentweapon();
    var_03 = scripts\cp\utility::getrawbaseweaponname(var_01);
    if(can_upgrade_via_pap2fnfcard(var_01, 1)) {
      thread settenthstimer(self, param_00, var_03, var_01);
      self.isusingsupercard = 0;
      return 1;
    } else {
      scripts\engine\utility::waitframe();
      continue;
    }
  }
}

settenthstimer(param_00, param_01, param_02, param_03) {
  var_04 = 0;
  var_05 = undefined;
  var_06 = undefined;
  var_07 = undefined;
  var_08 = undefined;
  var_09 = self getweaponslistprimaries();
  var_0A = self getweaponslistprimaries().size;
  var_0B = 3;
  var_0C = param_02;
  var_0D = spawnStruct();
  var_0D.lvl = 2;
  param_00.pap[var_0C] = var_0D;
  if(!param_00 scripts\cp\cp_weapon::has_weapon_variation(param_03)) {
    var_0E = param_00 scripts\cp\utility::getvalidtakeweapon();
    param_00.curr_weap = var_0E;
    if(isDefined(var_0E)) {
      var_05 = 1;
      var_0F = scripts\cp\utility::getrawbaseweaponname(var_0E);
      if(param_00 scripts\cp\utility::has_special_weapon() && var_0A < var_0B + 1) {
        var_05 = 0;
      }

      foreach(var_11 in var_09) {
        if(scripts\cp\utility::isstrstart(var_11, "alt_")) {
          var_0B++;
        }
      }

      if(scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
        var_0B++;
      }

      if(var_09.size < var_0B) {
        var_05 = 0;
      }

      if(var_05) {
        if(isDefined(param_00.pap[var_0F])) {
          param_00.pap[var_0F] = undefined;
          param_00 notify("weapon_level_changed");
        }

        param_00 takeweapon(var_0E);
      }
    }

    if(isDefined(param_00.weapon_build_models[var_0C])) {
      var_06 = param_00.weapon_build_models[var_0C];
    } else {
      var_06 = param_03;
    }

    if(isDefined(param_02)) {
      if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, param_02)) {
        var_08 = undefined;
      } else if(isDefined(level.pap_1_camo) && param_00.pap[param_02].lvl == 1) {
        var_08 = level.pap_1_camo;
      } else if(isDefined(level.pap_2_camo) && param_00.pap[param_02].lvl == 2) {
        var_08 = level.pap_2_camo;
      }

      var_13 = param_00 scripts\cp\cp_weapon::get_weapon_level(param_03);
    }

    var_14 = 0;
    var_15 = undefined;
    if(isDefined(param_02)) {
      if(isDefined(param_00.pap[param_02])) {
        var_15 = "pap" + param_00.pap[param_02].lvl;
      } else {
        var_15 = "pap1";
      }
    }

    if(isDefined(var_15) && var_15 == "replace_me") {
      var_15 = undefined;
    }

    var_16 = getweaponattachments(var_06);
    var_17 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_06, var_15, var_16, undefined, var_08);
    var_17 = scripts\cp\utility::_giveweapon(var_17, undefined, undefined, 1);
    self.pap2_card_weapon = var_17;
    param_00.itempicked = var_17;
    param_00 scripts\cp\utility::take_fists_weapon(self);
    param_00 notify("weapon_purchased");
    param_00.pap[param_02].lvl = 3;
    param_00 givemaxammo(var_17);
    param_00 notify("weapon_level_changed");
    param_00 switchtoweapon(var_17);
    while(param_00 isswitchingweapon()) {
      wait(0.05);
    }
  } else {
    param_00.purchasing_ammo = 1;
    var_0C = undefined;
    var_18 = param_00 getweaponslistall();
    var_19 = param_00 getcurrentweapon();
    var_1A = scripts\cp\utility::getrawbaseweaponname(param_03);
    var_1B = undefined;
    foreach(param_03 in var_18) {
      var_0C = scripts\cp\utility::getrawbaseweaponname(param_03);
      if(var_0C == var_1A) {
        var_1B = param_03;
        break;
      }
    }

    var_1E = weaponmaxammo(var_1B);
    var_1F = param_00 scripts\cp\perks\prestige::prestige_getminammo();
    var_20 = int(var_1F * var_1E);
    var_21 = param_00 getweaponammostock(var_1B);
    if(var_21 < var_20) {
      param_00 setweaponammostock(var_1B, var_20);
    }
  }

  wait(0.05);
  param_00 notify("weapon_purchased");
  param_00.purchasing_ammo = undefined;
}

can_upgrade_via_pap2fnfcard(param_00, param_01) {
  var_02 = self getweaponslistall();
  foreach(var_04 in var_02) {
    var_05 = scripts\cp\utility::getrawbaseweaponname(param_00);
    var_06 = scripts\cp\utility::getrawbaseweaponname(var_04);
    if(var_05 == var_06) {
      return 0;
    }
  }

  if(scripts\cp\utility::weapon_is_dlc_melee(param_00) || scripts\cp\utility::weapon_is_dlc2_melee(param_00) || issubstr(param_00, "knife") || issubstr(param_00, "slasher") || issubstr(param_00, "axe") || issubstr(param_00, "lawnmower") || issubstr(param_00, "harpoon")) {
    return 0;
  }

  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(param_00)])) {
    return 0;
  }

  if(issubstr(param_00, "forgefreeze") || issubstr(param_00, "cutie") || issubstr(param_00, "nunchucks") || issubstr(param_00, "katana") || issubstr(param_00, "headcutter") || issubstr(param_00, "dischord") || issubstr(param_00, "facemelter") || issubstr(param_00, "shredder")) {
    return 0;
  }

  if(!isDefined(level.pap)) {
    return 0;
  }

  if(isDefined(param_00)) {
    var_05 = scripts\cp\utility::getrawbaseweaponname(param_00);
  } else {
    return 0;
  }

  if(!isDefined(var_05)) {
    return 0;
  }

  if(!isDefined(level.pap[var_05])) {
    var_04 = getsubstr(var_05, 0, var_05.size - 1);
    if(!isDefined(level.pap[var_04])) {
      return 0;
    }
  }

  if(isDefined(self.pap[var_05]) && self.pap[var_05].lvl >= 3) {
    return 0;
  } else {
    return 1;
  }

  if(scripts\engine\utility::istrue(param_01) && isDefined(self.pap[var_05]) && self.pap[var_05].lvl <= min(level.pap_max + 1, 2)) {
    return 1;
  }

  return 1;
}

use_self_revive(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(param_00 + "_exited_early");
  scripts\cp\cp_laststand::enable_self_revive(self);
  thread removeselfreviveonearlyexit(param_00);
  for(;;) {
    self waittill("player_has_self_revive", var_01);
    if(var_01) {
      continue;
    }

    self waittill("revive");
    self stoplocalsound("zmb_laststand_music");
    scripts\cp\cp_laststand::disable_self_revive(self);
    if(scripts\cp\utility::has_zombie_perk("perk_machine_tough")) {
      self.maxhealth = 200;
      self.health = self.maxhealth;
    }

    scripts\cp\utility::notify_used_consumable(param_00);
    break;
  }
}

removeselfreviveonearlyexit(param_00) {
  self endon(param_00 + " activated");
  self endon("disconnect");
  level endon("game_ended");
  self waittill(param_00 + "_exited_early");
  scripts\cp\cp_laststand::disable_self_revive(self);
}

use_welfare(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  var_01 = scripts\cp\cp_persistence::get_player_currency();
  var_02 = int(var_01 / level.players.size);
  scripts\cp\cp_persistence::set_player_currency(var_02);
  foreach(var_04 in level.players) {
    if(var_04 == self) {
      continue;
    }

    var_04 scripts\cp\cp_persistence::give_player_currency(var_02, undefined, undefined, 1, "bonus");
  }

  scripts\cp\utility::notify_used_consumable(param_00);
  return 1;
}

use_increased_team_efficiency(param_00) {
  self endon(param_00 + "_timeup");
  self endon("disconnect");
  if(!isDefined(level.consumable_cash_scalar)) {
    level.consumable_cash_scalar = 0;
  }

  thread update_team_multiplier(param_00);
  thread cleanupaftertimeoutordeath(param_00);
  setomnvar("zom_escape_combo_multiplier", 1);
  for(;;) {
    var_01 = scripts\engine\utility::waittill_any_return("shot_missed", "weapon_hit_enemy");
    if(var_01 == "shot_missed") {
      level.consumable_cash_scalar = level.consumable_cash_scalar - 0.02;
    } else {
      level.consumable_cash_scalar = level.consumable_cash_scalar + 0.02;
    }

    if(level.consumable_cash_scalar < 0) {
      level.consumable_cash_scalar = 0;
    }

    self notify("update_team_efficiency");
  }
}

update_team_multiplier(param_00) {
  self endon(param_00 + "_timeup");
  self endon("disconnect");
  while(isDefined(level.consumable_cash_scalar)) {
    self waittill("update_team_efficiency");
    var_01 = 1 + level.consumable_cash_scalar;
    setomnvar("zom_escape_combo_multiplier", var_01);
  }

  setomnvar("zom_escape_combo_multiplier", -1);
}

cleanupaftertimeoutordeath(param_00) {
  var_01 = scripts\engine\utility::waittill_any_return(param_00 + "_timeup", param_00 + "_exited_early", "disconnect");
  level.consumable_cash_scalar = undefined;
}

use_slow_enemy_movement(param_00) {
  self endon(param_00 + "_timeup");
  self endon("disconnect");
  thread removeslowmoveonlaststand(param_00);
  foreach(var_02 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    var_02 thread adjustmovespeed(var_02, param_00, self);
  }

  for(;;) {
    level waittill("agent_spawned", var_04);
    var_04 thread adjustmovespeed(var_04, param_00, self, 1);
  }
}

adjustmovespeed(param_00, param_01, param_02, param_03) {
  param_00 endon("death");
  if(isDefined(param_00.agent_type) && param_00.agent_type == "zombie_brute" || param_00.agent_type == "zombie_grey" || param_00.agent_type == "zombie_ghost") {
    return;
  }

  if(isDefined(param_00.agent_type) && param_00.agent_type == "crab_brute" || param_00.agent_type == "crab_mini") {
    return;
  }

  if(param_00 scripts\cp\utility::agentisfnfimmune()) {
    return;
  }

  if(scripts\engine\utility::istrue(param_00.is_suicide_bomber)) {
    return;
  }

  if(scripts\engine\utility::istrue(param_03)) {
    wait(0.5);
  }

  if(!isDefined(param_00.asm.cur_move_mode)) {
    var_04 = param_00.synctransients;
  } else {
    var_04 = param_01.asm.cur_move_mode;
  }

  switch (var_04) {
    case "slow_walk":
      break;

    case "walk":
    case "sprint":
    case "run":
      param_00 scripts\asm\asm_bb::bb_requestmovetype("slow_walk");
      break;
  }

  param_02 scripts\engine\utility::waittill_any_3(param_01 + "_timeup", "last_stand", "disconnect");
  param_00 scripts\asm\asm_bb::bb_requestmovetype(var_04);
}

removeslowmoveonlaststand(param_00) {
  self endon(param_00 + "_timeup");
  self waittill("last_stand");
  self notify(param_00 + "_exited_early");
}

use_life_link(param_00) {
  self endon(param_00 + "_timeup");
  self endon("last_stand");
  self endon("disconnect");
  level endon("game_ended");
  self.life_link_active = undefined;
  self.life_linked = 1;
  var_01 = "j_spine4";
  thread removedamagemodifierontimeout(param_00);
  thread removedamagemodifieronlaststand(param_00);
  var_02 = self;
  for(;;) {
    var_03 = getlifelinktarget(self);
    if(isDefined(var_03)) {
      self notify("lost_target", var_03);
      self.linked_to_player = 1;
      thread playlifelinkfx(var_03, var_01, param_00);
      var_02.life_link_active = 1;
      linktoplayer(self, var_03);
      continue;
    }

    var_02.life_link_active = undefined;
    wait(0.5);
  }
}

getlifelinktarget(param_00) {
  var_01 = scripts\engine\utility::get_array_of_closest(param_00.origin, level.players, [param_00], 4, 512);
  var_02 = sortbydistance(var_01, param_00.origin);
  var_03 = undefined;
  foreach(var_05 in var_02) {
    var_06 = sighttracepassed(param_00 getEye(), var_05 getEye(), 0, param_00);
    if(!var_06) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_05.inlaststand)) {
      continue;
    }

    var_03 = var_05;
    break;
  }

  return var_03;
}

linktoplayer(param_00, param_01) {
  param_00 endon("disconnect");
  while(scripts\engine\utility::istrue(param_00.linked_to_player)) {
    if(scripts\engine\utility::istrue(param_01.inlaststand)) {
      param_00.linked_to_player = undefined;
      param_00 notify("lost_target");
      break;
    } else if(distance(param_00.origin, param_01.origin) > 512) {
      param_00.linked_to_player = undefined;
      param_00 notify("lost_target");
      break;
    } else {
      var_02 = sighttracepassed(param_00 getEye(), param_01 getEye(), 0, param_00);
      if(!var_02) {
        param_00.linked_to_player = undefined;
        param_00 notify("lost_target");
      }
    }

    wait(0.25);
  }
}

playlifelinkfx(param_00, param_01, param_02) {
  param_00 endon("disconnect");
  self endon("disconnect");
  var_03 = [];
  playFXOnTag(level._effect["life_link_target"], param_00, param_01);
  foreach(var_05 in level.players) {
    var_03[var_03.size] = playfxontagsbetweenclients(level._effect["life_link"], self, param_01, param_00, param_01, var_05);
  }

  self playLoopSound("zmb_fnf_lifelink_heal_lp");
  param_00 playLoopSound("zmb_fnf_lifelink_heal_lp");
  var_07 = scripts\cp\utility::waittill_any_ents_return(self, "disconnect", self, "lost_target", self, "last_stand", self, param_02 + "_timeup", param_00, "disconnect", param_00, "last_stand", level, "game_ended");
  if(isDefined(self)) {
    self stoploopsound();
  }

  if(isDefined(param_00)) {
    param_00 stoploopsound();
  }

  foreach(var_09 in var_03) {
    if(isDefined(var_09)) {
      var_09 delete();
    }
  }

  if(isDefined(param_00)) {
    killfxontag(level._effect["life_link_target"], param_00, param_01);
  }
}

removedamagemodifieronlaststand(param_00) {
  self endon(param_00 + "_timeup");
  self waittill("last_stand");
  self.life_linked = undefined;
  self.life_link_active = undefined;
  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
  }

  self notify(param_00 + "_exited_early");
}

removedamagemodifierontimeout(param_00) {
  self endon("last_stand");
  self waittill(param_00 + "_timeup");
  self.life_linked = undefined;
  self.life_link_active = undefined;
  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
  }
}

use_phoenix_up(param_00) {
  var_01 = level.players;
  var_02 = 0;
  foreach(var_04 in var_01) {
    var_05 = var_04;
    if(isDefined(var_04.triggerportableradarping)) {
      var_05 = var_04.triggerportableradarping;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_05)) {
      var_02 = 1;
      if(scripts\engine\utility::istrue(var_05.kill_trigger_event_processed)) {
        thread delayed_instant_revive(var_05);
        continue;
      }

      scripts\cp\cp_laststand::instant_revive(var_05);
      scripts\cp\cp_laststand::record_revive_success(self, var_05);
    }
  }

  if(!var_02) {
    self.consumables["phoenix_up"].on = 0;
    scripts\engine\utility::waitframe();
    return 0;
  }

  wait(0.25);
  scripts\cp\utility::notify_used_consumable("phoenix_up");
  return 1;
}

delayed_instant_revive(param_00) {
  param_00 endon("disconnect");
  param_00 endon("revive");
  wait(4);
  scripts\cp\cp_laststand::instant_revive(param_00);
  scripts\cp\cp_laststand::record_revive_success(self, param_00);
}

use_killing_time(param_00) {
  level endon("game_ended");
  if(isDefined(level.meph_fight_started)) {
    return 0;
  }

  foreach(var_02 in level.players) {
    if(!isDefined(var_02.killing_time)) {
      var_02.killing_time = 0;
    }

    var_02.killing_time++;
  }

  scripts\engine\utility::waitframe();
  scripts\cp\utility::notify_used_consumable("killing_time");
  scripts\engine\utility::waittill_any_timeout_1(20, "death", "last_stand", "disconnect");
  foreach(var_02 in level.players) {
    if(isDefined(var_02.killing_time)) {
      var_02.killing_time--;
      if(var_02.killing_time <= 0) {
        var_02.killing_time = undefined;
      }
    }
  }
}

use_now_you_see_me(param_00) {
  level endon("game_ended");
  self endon("last_stand");
  self endon("disconnect");
  thread removenowyouseemeonlaststand(param_00);
  foreach(var_02 in level.players) {
    if(var_02 == self) {
      if(var_02 scripts\cp\utility::isignoremeenabled()) {
        var_02 scripts\cp\utility::allow_player_ignore_me(0);
      }

      continue;
    }

    var_02 scripts\cp\utility::allow_player_ignore_me(1);
  }

  wait(10);
  foreach(var_02 in level.players) {
    if(var_02 scripts\cp\utility::isignoremeenabled()) {
      var_02 scripts\cp\utility::allow_player_ignore_me(0);
    }
  }
}

removenowyouseemeonlaststand(param_00) {
  var_01 = scripts\engine\utility::waittill_any_return("last_stand", "disconnect", param_00 + "_timeup", param_00 + "_exited_early");
  foreach(var_03 in level.players) {
    if(var_03 scripts\cp\utility::isignoremeenabled()) {
      var_03 scripts\cp\utility::allow_player_ignore_me(0);
    }
  }

  if(isDefined(var_01) && var_01 == "last_stand") {
    self notify(param_00 + "_exited_early");
  }
}

use_anywhere_but_here(param_00) {
  if(!scripts\cp\utility::isteleportenabled() || scripts\engine\utility::istrue(self.is_in_pap)) {
    self.consumables["anywhere_but_here"].on = 0;
    return 0;
  }

  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    self.consumables["anywhere_but_here"].on = 0;
    return 0;
  }

  var_01 = level.active_player_respawn_locs;
  var_01 = scripts\engine\utility::array_remove_duplicates(var_01);
  foreach(var_03 in level.active_player_respawn_locs) {
    var_04 = scripts\cp\zombies\zombies_spawning::get_spawn_volumes_player_is_in(0, 1, self);
    foreach(var_06 in var_04) {
      if(ispointinvolume(var_03.origin, var_06)) {
        var_01 = scripts\engine\utility::array_remove(var_01, var_03);
      }
    }
  }

  if(var_01.size < 1) {
    var_01 = level.active_player_respawn_locs;
  }

  var_09 = scripts\cp\gametypes\zombie::get_respawn_loc_rated(level.players, var_01);
  if(!isDefined(var_09)) {
    self.consumables["anywhere_but_here"].on = 0;
    return 0;
  }

  if(scripts\cp\utility::map_check(4)) {
    var_0A = scripts\cp\zombies\zombies_spawning::get_spawn_volumes_player_is_in(0, 1, self);
    foreach(var_0C in var_0A) {
      if(isDefined(level.facilityvolumes) && scripts\engine\utility::array_contains(level.facilityvolumes, var_0C.basename)) {
        self.currentlocation = "facility";
        continue;
      }

      self.currentlocation = "theater";
    }
  }

  scripts\cp\powers\coop_phaseshift::doscreenflash();
  scripts\cp\cp_interaction::refresh_interaction();
  scripts\cp\powers\coop_powers::power_enablepower();
  self getrigindexfromarchetyperef();
  self setorigin(var_09.origin);
  self setplayerangles(var_09.angles);
  self notify("left_hidden_room_early");
  scripts\cp\utility::notify_used_consumable("anywhere_but_here");
  self.abh_used = gettime();
  return 1;
}

jumptoanywherebutherespawns(param_00) {
  level endon("game_ended");
  level.players[0] endon("death");
  level.players[0] endon("last_stand");
  foreach(var_02 in level.active_player_respawn_locs) {
    level.players[0] scripts\cp\powers\coop_phaseshift::doscreenflash();
    level.players[0] scripts\cp\cp_interaction::refresh_interaction();
    level.players[0] scripts\cp\powers\coop_powers::power_enablepower();
    level.players[0] getrigindexfromarchetyperef();
    level.players[0] setorigin(var_02.origin);
    level.players[0] setplayerangles(var_02.angles);
    wait(2);
  }
}

use_headshot_reload(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(param_00 + "_timeup");
  self.headshot_reload_time = gettime();
}

headshot_reload_check(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!scripts\cp\utility::is_consumable_active("headshot_reload")) {
    return 0;
  }

  if(!scripts\engine\utility::isbulletdamage(param_03)) {
    return 0;
  }

  if(!scripts\cp\utility::isheadshot(param_04, param_06, param_03, param_01)) {
    return 0;
  }

  if(isDefined(param_09) && param_09 scripts\cp\utility::agentisfnfimmune()) {
    return 0;
  }

  param_04 = self getcurrentweapon();
  var_0A = self getweaponammostock(param_04);
  var_0B = weaponclipsize(param_04);
  var_0C = self getweaponammoclip(param_04);
  var_0D = var_0B - var_0C;
  if(var_0A >= var_0D) {
    self setweaponammostock(param_04, var_0A - var_0D);
  } else {
    var_0B = var_0A;
    self setweaponammostock(param_04, 0);
  }

  var_0E = var_0B;
  var_0F = min(var_0C + var_0E, var_0B);
  self setweaponammoclip(param_04, int(var_0F));
  if(self isdualwielding()) {
    var_0C = self getweaponammoclip(param_04, "left");
    var_0F = min(var_0C + var_0E, var_0B);
    self setweaponammoclip(param_04, int(var_0F), "left");
  }
}

use_grenade_cooldown(param_00) {
  self.power_cooldowns = 1;
  scripts\cp\powers\coop_powers::power_adjustcharges(1, "primary");
  var_01 = getarraykeys(self.powers);
  foreach(var_03 in var_01) {
    self.powers[var_03].cooldownratemod = 1;
  }
}

turn_off_grenade_cooldown(param_00) {
  self.power_cooldowns = 0;
}

write_consumable_used(param_00, param_01) {
  if(!isDefined(param_00.consumables)) {
    return;
  }

  var_02 = 0;
  foreach(var_06, var_04 in param_00.consumables_pre_irish_luck_usage) {
    var_05 = get_consumable_loot_id(var_06);
    setclientmatchdata("player", param_01, "cardsUsed", var_02, "loot_ID", int(var_05));
    setclientmatchdata("player", param_01, "cardsUsed", var_02, "num_of_times_used", var_04.times_used);
    var_02++;
  }
}

get_consumable_loot_id(param_00) {
  return tablelookup("cp\loot\iw7_zombiefatefortune_loot_master.csv", 1, param_00, 0);
}

set_consumable(param_00) {
  return self[[level.consumables[param_00].set]](param_00);
}

unset_consumable(param_00) {
  self[[level.consumables[param_00].unset]](param_00);
}