/******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
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
    var_0 = level.consumable_table;
  } else {
    var_0 = "cp\loot\iw7_zombiefatefortune_loot_master.csv";
  }

  var_1 = 0;
  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 1);
    if(var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_0, var_1, 6);
    var_4 = int(tablelookupbyrow(var_0, var_1, 7));
    var_5 = int(tablelookupbyrow(var_0, var_1, 8));
    var_6 = int(tablelookupbyrow(var_0, var_1, 9));
    register_consumable(var_2, var_3, var_4, var_5, var_6, ::give_consumable, ::remove_consumable);
    var_1++;
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

register_consumable(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.type = var_1;
  var_7.uses = var_2;
  var_7.usageperiod = var_3;
  var_7.passiveuses = var_4;
  var_7.set = var_5;
  var_7.unset = var_6;
  var_7.timeupnotify = var_0 + "_timeup";
  level.consumables[var_0] = var_7;
  foreach(var_10, var_9 in level.irish_luck_consumables) {
    if(var_10 == var_0) {
      level.irish_luck_consumables[var_0] = level.consumables[var_0];
      level.irish_luck_consumables[var_0].name = var_0;
    }
  }
}

consumable_setup_functions(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.consumables[var_0];
  if(isDefined(var_1)) {
    var_5.usefunc = var_1;
  }

  if(isDefined(var_2)) {
    var_5.set = var_2;
  }

  if(isDefined(var_3)) {
    var_5.unset = var_3;
  }

  if(isDefined(var_4)) {
    var_5.testforsuccess = var_4;
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
  for(var_0 = 0; var_0 < 32; var_0++) {
    self setplayerdata("common", "consumablesUsed", var_0, 0);
  }
}

set_player_consumables() {
  self.consumables = [];
  for(var_0 = 0; var_0 < 5; var_0++) {
    var_1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombie_consumables", var_0);
    self.consumables[var_1] = spawnStruct();
    self.consumables[var_1].uses = level.consumables[var_1].uses;
    self.consumables[var_1].on = 0;
    self.consumables[var_1].times_used = 0;
  }

  self.consumables_pre_irish_luck_usage = self.consumables;
}

turn_on_cards(var_0) {
  var_1 = get_card_deck_size(self);
  self setclientomnvar("zm_consumables_remaining", var_1);
  self setclientomnvar("zm_dpad_up_activated", 4);
  self.slot_array = [];
  self playlocalsound("zmb_fnf_replenish");
  for(var_2 = 0; var_2 < var_1; var_2++) {
    self.slot_array[self.slot_array.size] = var_2;
    self setclientomnvarbit("zm_card_selection_count", var_2, 1);
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

get_card_deck_size(var_0) {
  var_1 = var_0 isitemunlocked("fate_card_slot_4", "fatedecksize", 1);
  var_2 = var_0 isitemunlocked("fate_card_slot_5", "fatedecksize", 1);
  var_3 = 3;
  if(var_1 && var_2) {
    var_3 = 5;
  } else if(var_1 && !var_2) {
    var_3 = 4;
  } else if(!var_1 && !var_2) {
    var_3 = 3;
  }

  return var_3;
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

watch_for_super_button(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("offhand_fired", var_1);
    if(var_1 == var_0) {
      if(scripts\engine\utility::istrue(self.inlaststand)) {
        self setweaponammoclip(var_0, 1);
        continue;
      }

      self notify("fired_super");
      self setweaponammoclip(var_0, 1);
    }
  }
}

dpad_consumable_selection_watch() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("consumable_selected");
  self endon("give_new_deck");
  var_0 = 0;
  self setclientomnvar("zm_consumable_selection_ready", 1);
  update_lua_consumable_slot(var_0);
  self.deck_select_ready = 1;
  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_return("D_pad_up", "D_pad_down", "fired_super");
    if(self.slot_array.size <= 0 || scripts\engine\utility::istrue(level.disable_consumables) || scripts\engine\utility::istrue(self.disable_consumables) || scripts\engine\utility::istrue(self.spectating) || scripts\engine\utility::istrue(self.inlaststand)) {
      self playlocalsound("ui_consumable_deny");
      wait(0.25);
      continue;
    }

    if(var_1 == "fired_super") {
      self.deck_select_ready = undefined;
      thread consumable_activate(self.slot_array[var_0], var_0);
    } else if(var_1 == "D_pad_up" && self.slot_array.size > 1) {
      self setclientomnvar("zm_dpad_pressed", 1);
      var_0 = get_selection_index_loop_around(var_0 + 1, 0, self.slot_array.size - 1);
      update_lua_consumable_slot(var_0);
      self playlocalsound("ui_consumable_scroll");
    } else if(var_1 == "D_pad_down" && self.slot_array.size > 1) {
      self setclientomnvar("zm_dpad_pressed", 1);
      var_0 = get_selection_index_loop_around(var_0 - 1, 0, self.slot_array.size - 1);
      update_lua_consumable_slot(var_0);
      self playlocalsound("ui_consumable_scroll");
    }

    scripts\engine\utility::waitframe();
    self setclientomnvar("zm_dpad_pressed", 0);
  }
}

update_lua_consumable_slot(var_0) {
  wait(0.1);
  self setclientomnvar("zm_consumable_deck_slot_on", self.slot_array[var_0]);
  self setclientomnvar("zm_consumables_slot_count", var_0 + 1);
}

get_selection_index_loop_around(var_0, var_1, var_2) {
  if(var_0 > var_2) {
    return var_1;
  }

  if(var_0 < var_1) {
    return var_2;
  }

  return var_0;
}

remove_card_from_use(var_0) {
  self.slot_array = scripts\engine\utility::array_remove(self.slot_array, self.slot_array[var_0]);
  self setclientomnvar("zm_consumables_remaining", self.slot_array.size);
  if(isDefined(self.slot_array[0])) {
    self setclientomnvar("zm_consumable_deck_slot_on", self.slot_array[0]);
  }
}

consumable_activate(var_0, var_1) {
  var_2 = self getplayerdata("cp", "zombiePlayerLoadout", "zombie_consumables", var_0);
  var_3 = "zm_card" + var_0 + 1 + "_drain";
  var_4 = "slot_" + var_0 + 1 + "_used";
  self.consumables[var_2].usednotify = var_4;
  if(var_2 == "irish_luck") {
    thread consumable_activate_internal_irish(var_2, var_3, "zm_dpad_up_uses", "zm_dpad_up_activated", var_4, var_0, var_1);
    return;
  }

  thread consumable_activate_internal(var_2, var_3, "zm_dpad_up_uses", "zm_dpad_up_activated", var_4, var_0, var_1);
}

consumable_activate_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("dpad_end_" + var_0);
  self endon("give_new_deck");
  if(self.consumables[var_0].uses > 0 && self.consumables[var_0].on == 0 && !scripts\cp\cp_laststand::player_in_laststand(self)) {
    self setclientomnvar("zm_fate_card_used", var_5);
    self.consumables[var_0].processing = 1;
    var_7 = undefined;
    var_8 = "fired_super";
    thread set_consumable(var_0);
    if(isDefined(level.consumables[var_0].usefunc)) {
      if(isDefined(level.consumables[var_0].testforsuccess)) {
        var_7 = self[[level.consumables[var_0].usefunc]](var_0);
      } else {
        var_7 = self thread[[level.consumables[var_0].usefunc]](var_0);
      }
    }

    if(!isDefined(var_7) || isDefined(var_7) && var_7) {
      consume_from_inventory(self, var_0);
      self.consumables[var_0].times_used++;
      scripts\cp\zombies\zombie_analytics::log_fafcardused(1, var_0, level.wave_num, self);
      scripts\cp\cp_merits::processmerit("mt_faf_uses");
      thread scripts\cp\cp_vo::try_to_play_vo("wonder_consume", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      if(self.consumables[var_0].times_used == 1) {
        thread decrement_counter_of_consumables(var_0);
      }

      self setclientomnvar(var_1, 1);
      thread lightbar_off();
      self setclientomnvar("zm_dpad_up_activated", 5);
      self setclientomnvarbit("zm_card_fill_display", var_5, 1);
      self setclientomnvar("zm_consumable_selection_ready", 0);
      remove_card_from_use(var_6);
      thread meter_fill_up();
      self playlocalsound("ui_consumable_select");
      play_consumable_activate_sound(self);
      self notify("consumable_selected");
      thread scripts\cp\utility::firegesturegrenade(self, self.fate_card_weapon);
      self.consumable_meter_full = undefined;
      thread scripts\cp\cp_vo::remove_from_nag_vo("nag_use_fateandfort");
      var_9 = level.consumables[var_0].type;
      if(var_9 == "timedactivations") {
        thread dpad_drain_time(var_0, level.consumables[var_0].usageperiod, var_1, var_8, var_2, var_3, var_4, var_5);
      } else if(var_9 == "wave") {
        thread dpad_drain_wave(var_0, level.consumables[var_0].usageperiod, var_1, var_8, var_2, var_3, var_4, var_5);
      } else if(var_9 == "triggernow" || level.consumables[var_0].type == "triggerwait") {
        thread dpad_drain_activations(var_0, level.consumables[var_0].type, self.consumables[var_0].uses, var_1, var_8, var_2, var_3, var_4, var_5);
      } else if(var_9 == "triggerpassive") {
        thread dpad_drain_triggerpassive(var_0, level.consumables[var_0].passiveuses, var_1, var_8, var_2, var_3, var_4, var_5);
      }

      if(isDefined(var_7)) {
        scripts\cp\utility::notify_used_consumable(var_0);
        return;
      }

      return;
    }

    self playlocalsound("ui_consumable_deny");
    self.consumables[var_0].processing = undefined;
  }
}

decrement_counter_of_consumables(var_0) {
  var_1 = get_consumable_index_in_player_data(self, var_0);
  if(isDefined(var_1)) {
    var_2 = self getplayerdata("cp", "zombiePlayerLoadout", "consumables_counter", var_1);
    var_3 = var_2 - 1;
    self setplayerdata("cp", "zombiePlayerLoadout", "consumables_counter", var_1, var_3);
  }
}

play_consumable_activate_sound(var_0) {
  switch (var_0.fate_card_weapon) {
    case "iw7_jockcard_zm":
      var_0 playlocalsound("wondercard_jock_use_gesture");
      break;

    case "iw7_nerdcard_zm":
      var_0 playlocalsound("wondercard_nerd_use_gesture");
      break;

    case "iw7_valleygirlcard_zm":
      var_0 playlocalsound("wondercard_valleygirl_use_gesture");
      break;

    case "iw7_rappercard_zm":
      var_0 playlocalsound("wondercard_rapper_use_gesture");
      break;

    case "iw7_grungecard_zm":
      var_0 playlocalsound("wondercard_gesture_grunge");
      break;

    case "iw7_cholacard_zm":
      var_0 playlocalsound("wondercard_gesture_chola");
      break;

    case "iw7_ravercard_zm":
      var_0 playlocalsound("wondercard_gesture_raver");
      break;

    case "iw7_hiphopcard_zm":
      var_0 playlocalsound("wondercard_gesture_hiphop");
      break;

    case "iw7_survivorcard_zm":
      var_0 playlocalsound("wondercard_gesture_survivor");
      break;

    case "iw7_wylercard_zm":
      var_0 playlocalsound("vm_gest_zmb_willard_wondercard");
      break;

    default:
      var_0 playlocalsound("wondercard_jock_use_gesture");
      break;
  }
}

consume_from_inventory(var_0, var_1) {
  var_2 = get_consumable_loot_id(var_1);
  if(scripts\engine\utility::array_contains(var_0.consumables_used, var_2)) {
    return;
  }

  var_3 = var_0.consumables_used.size;
  if(isDefined(level.consumable_table)) {
    var_4 = level.consumable_table;
  } else {
    var_4 = "cp\loot\iw7_zombiefatefortune_loot_master.csv";
  }

  var_5 = tablelookup(var_4, 1, var_1, 3);
  if(isDefined(var_5)) {
    if(var_5 == "Fortune") {
      var_0 setplayerdata("common", "consumablesUsed", var_3, int(var_2));
      var_6 = var_0 getplayerdata("common", "numConsumables");
      var_0 setplayerdata("common", "numConsumables", var_6 + 1);
      var_0.consumables_used = scripts\engine\utility::array_add(var_0.consumables_used, var_2);
    }
  }
}

get_consumable_index_in_player_data(var_0, var_1) {
  for(var_2 = 0; var_2 < 5; var_2++) {
    var_3 = var_0 getplayerdata("cp", "zombiePlayerLoadout", "zombie_consumables", var_2);
    if(var_1 == var_3) {
      return var_2;
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

dpad_drain_time(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  level endon("game_ended");
  thread watchforearlyexit(var_0, var_4, var_2, var_5, var_6, var_7);
  var_8 = 1;
  var_9 = var_8 / var_1;
  wait(getcharactercardgesturelength());
  for(;;) {
    if(!scripts\engine\utility::istrue(self.spectating) && !scripts\engine\utility::istrue(self.inlaststand)) {
      self setclientomnvar(var_2, var_8);
      var_8 = var_8 - var_9;
      if(var_8 <= 0) {
        self setclientomnvar(var_2, 0);
        disable_consumable(var_0, var_4, var_2, var_5, var_6, var_7);
        break;
      }
    }

    wait(1);
  }
}

dpad_drain_wave(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  thread watchforearlyexit(var_0, var_4, var_2, var_5, var_6, var_7);
  var_8 = 1;
  var_9 = var_8 / var_1;
  for(;;) {
    self setclientomnvar(var_2, var_8);
    level waittill("spawn_wave_done");
    var_8 = var_8 - var_9;
    if(var_8 <= 0) {
      self setclientomnvar(var_2, 0);
      disable_consumable(var_0, var_4, var_2, var_5, var_6, var_7);
      break;
    }

    wait(1);
  }
}

dpad_drain_activations(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  thread watchforearlyexit(var_0, var_5, var_3, var_6, var_7, var_8);
  var_9 = self.consumables[var_0].usednotify;
  var_10 = 1;
  if(var_1 == "triggerwait") {
    self waittill(var_9);
  }

  wait(1);
  for(;;) {
    if(!scripts\engine\utility::istrue(self.spectating) && !scripts\engine\utility::istrue(self.inlaststand)) {
      var_10 = var_10 - 0.05;
      self setclientomnvar(var_3, var_10);
      if(var_10 <= 0) {
        self setclientomnvar(var_3, 0);
        disable_consumable(var_0, var_5, var_3, var_6, var_7, var_8);
        break;
      }
    }

    wait(0.05);
  }
}

dpad_drain_triggerpassive(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  thread watchforearlyexit(var_0, var_4, var_2, var_5, var_6, var_7);
  var_8 = 1 / var_1;
  var_9 = self.consumables[var_0].usednotify;
  var_10 = 1;
  for(;;) {
    self waittill(var_9);
    if((!scripts\engine\utility::istrue(self.spectating) && !scripts\engine\utility::istrue(self.inlaststand)) || var_0 == "coagulant") {
      var_10 = var_10 - var_8;
      self setclientomnvar(var_2, var_10);
      if(var_10 < 0.0001) {
        self setclientomnvar(var_2, 0);
        disable_consumable(var_0, var_4, var_2, var_5, var_6, var_7);
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

watchforearlyexit(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("dpad_end_" + var_0);
  self waittill(var_0 + "_exited_early");
  self setclientomnvar(var_2, 0);
  thread disable_consumable(var_0, var_1, var_2, var_3, var_4, var_5);
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
    self waittill("consumable_charge", var_0);
    if(scripts\engine\utility::istrue(self.disable_consumables)) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      continue;
    }

    if(isDefined(self.consumable_meter_scalar)) {
      var_0 = var_0 * self.consumable_meter_scalar;
    }

    var_1 = self.consumable_meter_max - self.consumable_meter;
    if(var_0 > var_1) {
      var_0 = var_1;
    }

    self.consumable_meter = self.consumable_meter + var_0;
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
  var_0 = 1250;
  if(self.card_refills == 1) {
    var_0 = 3000;
  } else if(self.card_refills >= 2) {
    var_0 = 5000;
  }

  return var_0;
}

disable_consumable(var_0, var_1, var_2, var_3, var_4, var_5) {
  turn_off_consumable(var_0, var_3);
  self.consumables[var_0].uses = self.consumables[var_0].uses - 1;
  self.consumables[var_0].processing = undefined;
  self setclientomnvar(var_1, self.consumables[var_0].uses);
  if(self.consumables[var_0].uses == 0) {
    self.consumables[var_0].uses = level.consumables[var_0].uses;
    self notify("dpad_end_" + var_0);
    self setclientomnvarbit("zm_card_selection_count", var_5, 0);
    self setclientomnvarbit("zm_card_fill_display", var_5, 0);
    return;
  }

  self setclientomnvar(var_2, 1);
}

turn_off_consumable(var_0, var_1) {
  self.consumables[var_0].on = 0;
  scripts\cp\utility::notify_timeup_consumable(var_0);
  thread unset_consumable(var_0);
}

give_consumable(var_0, var_1) {
  var_2 = level.consumables[var_0];
  if(isDefined(var_2.usednotify)) {
    self notify(var_2.usednotify);
  } else {
    self notify(var_0 + " activated");
  }

  if(isDefined(level.random_consumable_chosen) && level.random_consumable_chosen.name == var_0) {
    return;
  }

  self.consumables[var_0].on = 1;
}

remove_consumable(var_0) {
  if(isDefined(self.consumables[var_0])) {
    self.consumables[var_0].on = 0;
  }
}

use_reload_damage_increase(var_0) {
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

use_ephemeral_enhancement(var_0) {
  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  var_1 = self getcurrentweapon();
  var_2 = scripts\cp\utility::getrawbaseweaponname(var_1);
  if(isDefined(self.pap[var_2]) && scripts\cp\cp_weapon::can_upgrade(var_1, 1)) {
    thread fnf_upgrade_weapon(self, var_0, var_2, var_1);
    return 1;
  }

  self.consumables["ephemeral_enhancement"].on = 0;
  return 0;
}

fnf_upgrade_weapon(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_4 = undefined;
  var_0.isusingsupercard = 1;
  var_5 = "pap" + var_0.pap[var_2].lvl;
  var_6 = getweaponattachments(var_3);
  var_7 = 0;
  var_8 = var_3;
  if(issubstr(var_3, "g18_z")) {
    foreach(var_10 in var_6) {
      if(issubstr(var_10, "akimbo")) {
        var_7 = 1;
        var_6 = scripts\engine\utility::array_remove(var_6, var_10);
      }
    }
  }

  if(isDefined(level.custom_epehermal_attachment_func)) {
    var_12 = [[level.custom_epehermal_attachment_func]](var_0, var_2, var_3);
    if(isDefined(var_12)) {
      if(var_12 == "replace_me") {
        var_5 = undefined;
      } else {
        var_5 = var_12;
      }
    }
  }

  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_3)])) {
    var_3 = level.weapon_upgrade_path[getweaponbasename(var_3)];
  } else if(isDefined(level.custom_epehermal_weapon_func)) {
    var_3 = [[level.custom_epehermal_weapon_func]](var_0, var_2, var_3);
  }

  if(isDefined(level.custom_ephermal_camo_func)) {
    var_4 = [[level.custom_ephermal_camo_func]](var_0, var_2, var_3);
  } else {
    if(isDefined(var_2)) {
      if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_2)) {
        var_4 = undefined;
      } else if(isDefined(level.pap_1_camo) && var_0.pap[var_2].lvl == 1) {
        var_4 = level.pap_1_camo;
      } else if(isDefined(level.pap_2_camo) && var_0.pap[var_2].lvl == 2) {
        var_4 = level.pap_2_camo;
      }

      var_13 = var_0 scripts\cp\cp_weapon::get_weapon_level(var_3);
      switch (var_2) {
        case "dischord":
          var_14 = "iw7_dischord_zm_pap1";
          var_4 = "camo20";
          break;

        case "facemelter":
          var_14 = "iw7_facemelter_zm_pap1";
          var_4 = "camo22";
          break;

        case "headcutter":
          var_14 = "iw7_headcutter_zm_pap1";
          var_4 = "camo21";
          break;

        case "forgefreeze":
          if(var_13 == 2) {
            var_14 = "iw7_forgefreeze_zm_pap1";
          } else if(var_13 == 3) {
            var_14 = "iw7_forgefreeze_zm_pap2";
          }

          var_15 = 1;
          break;

        case "axe":
          if(var_13 == 2) {
            var_14 = "iw7_axe_zm_pap1";
          } else if(var_13 == 3) {
            var_14 = "iw7_axe_zm_pap2";
          }
          break;

        case "shredder":
          var_14 = "iw7_shredder_zm_pap1";
          var_4 = "camo23";
          break;

        case "katana":
        case "nunchucks":
          var_4 = "camo222";
          break;
      }
    }

    var_15 = 0;
    if(isDefined(var_2)) {
      switch (var_2) {
        case "spiked":
        case "golf":
        case "two":
        case "axe":
        case "machete":
          var_15 = 1;
          break;

        default:
          var_15 = 0;
          break;
      }
    } else {
      var_15 = 0;
    }

    var_5 = undefined;
    if(isDefined(var_2)) {
      switch (var_2) {
        case "spiked":
        case "golf":
        case "two":
        case "machete":
        case "katana":
        case "nunchucks":
          var_5 = "replace_me";
          break;

        default:
          if(isDefined(var_0.pap[var_2])) {
            var_5 = "pap" + var_0.pap[var_2].lvl;
          } else {
            var_5 = "pap1";
          }

          break;
      }
    }

    if(isDefined(var_5) && var_5 == "replace_me") {
      var_5 = undefined;
    }

    var_10 = getweaponattachments(var_3);
    if(issubstr(var_3, "g18_z")) {
      foreach(var_10 in var_10) {
        if(issubstr(var_10, "akimbo")) {
          var_10 = scripts\engine\utility::array_remove(var_10, var_10);
        }
      }
    }
  }

  var_13 = var_0 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_3, var_5, var_6, undefined, var_4);
  if(isDefined(var_13)) {
    var_0.pap[var_2].lvl++;
    var_0 notify("weapon_level_changed");
    var_0.ephemeralweapon = getweaponbasename(var_13);
    var_0 thread downgradeweaponaftertimeout(var_1, var_0, var_13, var_7);
    var_0 endon("last_stand");
    wait(getcharactercardgesturelength());
    var_13 = var_0 scripts\cp\utility::_giveweapon(var_13, undefined, undefined, 1);
    if(isDefined(var_8)) {
      var_0 takeweapon(var_8);
    } else {
      var_0 takeweapon(var_3);
    }

    var_0 switchtoweapon(var_13);
  }
}

downgradeweaponaftertimeout(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_4 = var_1.ephemeralweapon;
  var_5 = 0;
  var_6 = scripts\cp\utility::getrawbaseweaponname(var_2);
  var_7 = "pap" + var_1.pap[var_6].lvl - 1;
  var_8 = var_1.pap[var_6].lvl - 2;
  switch (var_6) {
    case "venomx":
      var_1.pap[var_6].lvl--;
      if(var_1.pap[var_6].lvl == 1) {
        var_1.base_weapon = 1;
        var_2 = "iw7_venomx_zm";
      } else {
        var_1.ephemeral_downgrade = 1;
        var_2 = "iw7_venomx_zm_pap1";
      }
      break;

    case "katana":
      var_1.pap[var_6].lvl--;
      if(var_1.pap[var_6].lvl == 1) {
        var_1.base_weapon = 1;
        var_2 = "iw7_katana_zm";
      } else {
        var_1.ephemeral_downgrade = 1;
        var_2 = "iw7_katana_zm_pap1";
      }
      break;

    case "nunchucks":
      var_1.pap[var_6].lvl--;
      if(var_1.pap[var_6].lvl == 1) {
        var_1.base_weapon = 1;
        var_2 = "iw7_nunchucks_zm";
      } else {
        var_1.ephemeral_downgrade = 1;
        var_2 = "iw7_nunchucks_zm_pap1";
      }
      break;

    case "two":
      var_1.pap[var_6].lvl--;
      if(var_1.pap[var_6].lvl == 1) {
        var_1.base_weapon = 1;
        var_2 = "iw7_two_headed_axe_mp";
      } else {
        var_1.ephemeral_downgrade = 1;
        var_2 = "iw7_two_headed_axe_mp_pap1";
      }
      break;

    case "machete":
      var_1.pap[var_6].lvl--;
      if(var_1.pap[var_6].lvl == 1) {
        var_1.base_weapon = 1;
        var_2 = "iw7_machete_mp";
      } else {
        var_1.ephemeral_downgrade = 1;
        var_2 = "iw7_machete_mp_pap1";
      }
      break;

    case "golf":
      var_1.pap[var_6].lvl--;
      if(var_1.pap[var_6].lvl == 1) {
        var_1.base_weapon = 1;
        var_2 = "iw7_golf_club_mp";
      } else {
        var_1.ephemeral_downgrade = 1;
        var_2 = "iw7_golf_club_mp_pap1";
      }
      break;

    case "spiked":
      var_1.pap[var_6].lvl--;
      if(var_1.pap[var_6].lvl == 1) {
        var_1.base_weapon = 1;
        var_2 = "iw7_spiked_bat_mp";
      } else {
        var_1.ephemeral_downgrade = 1;
        var_2 = "iw7_spiked_bat_mp_pap1";
      }
      break;
  }

  var_2 = downgradeweapon(var_1, var_2, var_6, var_7, var_8, var_3);
  var_1.base_weapon = undefined;
  var_1.ephemeral_downgrade = undefined;
  var_9 = var_1 scripts\engine\utility::waittill_any_return("ephemeral_enhancement_timeup", "last_stand");
  if(var_9 != "ephemeral_enhancement_timeup") {
    var_1 notify(var_0 + "_exited_early");
  }

  var_1.isusingsupercard = undefined;
  var_10 = scripts\cp\utility::getrawbaseweaponname(var_1 scripts\cp\utility::getvalidtakeweapon());
  if(var_1 scripts\cp\cp_weapon::has_weapon_variation(var_4)) {
    var_11 = var_1 getweaponslistall();
    foreach(var_13 in var_11) {
      var_14 = scripts\cp\utility::getrawbaseweaponname(var_13);
      if(var_14 == scripts\cp\utility::getrawbaseweaponname(var_4)) {
        var_1 takeweapon(var_13);
        var_5 = 1;
        var_2 = var_1 scripts\cp\utility::_giveweapon(var_2, undefined, undefined, 1);
        if(scripts\cp\utility::getrawbaseweaponname(var_2) == var_10) {
          var_1 switchtoweaponimmediate(var_2);
        }

        var_1.pap[var_6].lvl = int(max(var_1.pap[var_6].lvl - 1, 1));
        var_1 notify("weapon_level_changed");
        break;
      }
    }
  }

  if(isDefined(var_1.copy_fullweaponlist)) {
    var_10 = var_1.copy_fullweaponlist;
    foreach(var_12 in var_10) {
      var_14 = getweaponbasename(var_12);
      if(var_14 == var_4) {
        var_13 = var_1.copy_weapon_ammo_clip[var_12];
        var_14 = var_1.copy_weapon_ammo_stock[var_12];
        var_1.copy_fullweaponlist = scripts\engine\utility::array_remove(var_1.copy_fullweaponlist, var_12);
        if(var_14 == getweaponbasename(var_1.copy_weapon_current)) {
          var_1.copy_weapon_current = var_2;
        }

        var_1.copy_fullweaponlist = scripts\engine\utility::array_add(var_1.copy_fullweaponlist, var_2);
        var_1.copy_weapon_ammo_clip[var_2] = var_13;
        var_1.copy_weapon_ammo_stock[var_2] = var_14;
        break;
      }
    }
  }

  if(isDefined(var_1.last_stand_pistol)) {
    if(getweaponbasename(var_1.last_stand_pistol) == var_1.ephemeralweapon) {
      var_1.last_stand_pistol = var_2;
    }
  }

  if(isDefined(var_1.saved_last_stand_pistol)) {
    if(getweaponbasename(var_1.saved_last_stand_pistol) == var_1.ephemeralweapon) {
      var_1.saved_last_stand_pistol = var_2;
    }
  }

  if(isDefined(var_1.lost_and_found_ent)) {
    var_10 = var_1.lost_and_found_ent.copy_fullweaponlist;
    foreach(var_12 in var_10) {
      var_14 = getweaponbasename(var_12);
      if(var_14 == var_4) {
        var_13 = var_1.copy_weapon_ammo_clip[var_12];
        var_14 = var_1.copy_weapon_ammo_stock[var_12];
        var_1.lost_and_found_ent.copy_fullweaponlist = scripts\engine\utility::array_remove(var_1.lost_and_found_ent.copy_fullweaponlist, var_12);
        if(var_14 == getweaponbasename(var_1.lost_and_found_ent.copy_weapon_current)) {
          var_1.lost_and_found_ent.copy_weapon_current = var_2;
        }

        var_1.lost_and_found_ent.copy_fullweaponlist = scripts\engine\utility::array_add(var_1.lost_and_found_ent.copy_fullweaponlist, var_2);
        var_1.copy_weapon_ammo_clip[var_2] = var_13;
        var_1.copy_weapon_ammo_stock[var_2] = var_14;
        break;
      }
    }
  }

  var_1.ephemeralweapon = undefined;
}

downgradeweapon(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;
  if(var_4 >= 1) {
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_2)) {
      var_6 = undefined;
    } else if(isDefined(level.pap_1_camo)) {
      var_6 = level.pap_1_camo;
    }

    var_7 = "pap" + var_4;
    switch (var_2) {
      case "dischord":
        var_6 = "camo20";
        break;

      case "facemelter":
        var_6 = "camo22";
        break;

      case "headcutter":
        var_6 = "camo21";
        break;

      case "shredder":
        var_6 = "camo23";
        break;

      case "katana":
      case "nunchucks":
        var_6 = "camo222";
        break;
    }
  } else {
    var_7 = undefined;
  }

  switch (var_2) {
    case "katana":
    case "nunchucks":
      var_7 = undefined;
      break;

    case "two":
      var_7 = undefined;
      break;

    case "golf":
      var_7 = undefined;
      break;

    case "machete":
      var_7 = undefined;
      break;

    case "spiked":
      var_7 = undefined;
      break;
  }

  var_8 = getweaponattachments(var_1);
  if(scripts\engine\utility::istrue(var_5)) {
    var_8 = scripts\engine\utility::array_add(var_8, "akimbo");
  }

  foreach(var_10 in var_8) {
    if(issubstr(var_10, var_3)) {
      var_8 = scripts\engine\utility::array_remove(var_8, var_10);
    }
  }

  var_12 = var_0 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_1, var_7, var_8, undefined, var_6);
  return var_12;
}

use_spawn_instakill(var_0) {
  var_1 = self;
  if(spawn_power_up(var_1, "instakill_30", var_0)) {
    return 1;
  }

  self.consumables["spawn_instakill"].on = 0;
  return 0;
}

use_spawn_fire_sale(var_0) {
  var_1 = self;
  if(spawn_power_up(var_1, "fire_30", var_0)) {
    return 1;
  }

  self.consumables["fire_30"].on = 0;
  return 0;
}

use_spawn_nuke(var_0) {
  var_1 = self;
  if(spawn_power_up(var_1, "kill_50", var_0)) {
    return 1;
  }

  self.consumables["spawn_nuke"].on = 0;
  return 0;
}

use_spawn_double_money(var_0) {
  var_1 = self;
  if(spawn_power_up(var_1, "cash_2", var_0)) {
    return 1;
  }

  self.consumables["spawn_double_money"].on = 0;
  return 0;
}

use_spawn_max_ammo(var_0) {
  var_1 = self;
  if(spawn_power_up(var_1, "ammo_max", var_0)) {
    return 1;
  }

  self.consumables["spawn_max_ammo"].on = 0;
  return 0;
}

use_spawn_reboard_windows(var_0) {
  var_1 = self;
  if(spawn_power_up(var_1, "board_windows", var_0)) {
    return 1;
  }

  self.consumables["spawn_reboard_windows"].on = 0;
  return 0;
}

use_spawn_infinite_ammo(var_0) {
  var_1 = self;
  if(spawn_power_up(var_1, "infinite_20", var_0)) {
    return 1;
  }

  self.consumables["spawn_infinite_ammo"].on = 0;
  return 0;
}

spawn_power_up(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = (0, 40, 0);
  var_5 = self getplayerangles();
  var_6 = 7;
  var_3 = var_3 + var_4[0] * anglestoright(var_5);
  var_3 = var_3 + var_4[1] * anglesToForward(var_5);
  var_3 = var_3 + var_4[2] * anglestoup(var_5);
  var_7 = rotatepointaroundvector(anglestoup(var_5), anglesToForward(var_5), var_6);
  var_8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_canshootclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_9 = scripts\common\trace::ray_trace(var_0 getEye(), var_3 + var_7, self, var_8);
  var_3 = scripts\engine\utility::drop_to_ground(var_9["position"] + var_7 * -18, 32, -2000);
  if(!scripts\cp\cp_weapon::isinvalidzone(var_3, level.invalid_spawn_volume_array, undefined, undefined, 1)) {
    var_3 = var_0.origin;
  }

  if(level scripts\cp\loot::drop_loot(var_3, var_0, var_1, undefined, undefined, 1)) {
    wait(0.25);
    var_0 scripts\cp\utility::notify_used_consumable(var_2);
    return 1;
  }

  return 0;
}

use_steel_dragon(var_0) {
  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(var_0, "iw7_steeldragon_mp");
  return 1;
}

use_claw_gun(var_0) {
  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(var_0, "iw7_claw_mp");
  return 1;
}

use_atomizer_gun(var_0) {
  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(var_0, "iw7_atomizer_mp+atomizerscope");
  return 1;
}

use_penetration_gun(var_0) {
  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(var_0, "iw7_penetrationrail_mp+penetrationrailscope");
  return 1;
}

use_bh_gun(var_0) {
  if(scripts\engine\utility::istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  thread give_mp_super_weapon(var_0, "iw7_blackholegun_mp+blackholegunscope");
  return 1;
}

give_mp_super_weapon(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_2 = self getcurrentweapon();
  var_3 = 0;
  if(var_2 == "none") {
    var_3 = 1;
  } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_2)) {
    var_3 = 1;
  } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, getweaponbasename(var_2))) {
    var_3 = 1;
  } else if(scripts\cp\utility::is_melee_weapon(var_2, 1)) {
    var_3 = 1;
  }

  if(var_3) {
    self.copy_fullweaponlist = self getweaponslistall();
    var_2 = scripts\cp\cp_laststand::choose_last_weapon(level.additional_laststand_weapon_exclusion, 1, 1);
  }

  self.last_weapon = var_2;
  self.copy_fullweaponlist = undefined;
  thread removeweaponaftertimeout(var_0, var_1, var_2);
  self endon(var_0 + "_exited_early");
  self endon("last_stand");
  wait(getcharactercardgesturelength());
  var_1 = scripts\cp\utility::_giveweapon(var_1, undefined, undefined, 0);
  self switchtoweaponimmediate(var_1);
  var_4 = ammo_round_up(var_1);
  while(self getcurrentweapon() != var_1) {
    wait(0.05);
  }

  self notify("super_weapon_given");
  thread unlimited_ammo(var_4, var_1);
}

removeweaponaftertimeout(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");
  self.isusingsupercard = 1;
  self.mpsuperpreviousweapon = var_2;
  scripts\engine\utility::allow_reload(0);
  scripts\engine\utility::waittill_any_timeout(getcharactercardgesturelength() + 1, "super_weapon_given");
  self allowmelee(0);
  while(self isswitchingweapon()) {
    wait(0.05);
  }

  self allowmelee(1);
  if(self getcurrentweapon() == var_1 && scripts\cp\utility::is_consumable_active(var_0)) {
    var_3 = scripts\engine\utility::waittill_any_return(var_0 + "_timeup", "last_stand", "weapon_switch_started", "weapon_purchased", "coaster_ride_beginning", "cards_replenished");
  } else {
    var_3 = undefined;
  }

  scripts\engine\utility::allow_reload(1);
  if(!isDefined(var_3) || var_3 != var_0 + "_timeup") {
    self notify(var_0 + "_exited_early");
  }

  self.isusingsupercard = undefined;
  if(!isDefined(var_3) || isDefined(var_3) && var_3 != "last_stand") {
    if(self hasweapon(var_2)) {
      self switchtoweapon(var_2);
    } else {
      self switchtoweapon(self getweaponslistprimaries()[1]);
    }
  }

  if(self hasweapon(var_1)) {
    self takeweapon(var_1);
  }

  thread deactivate_infinite_ammo();
  self.mpsuperpreviousweapon = undefined;
  self.last_weapon = undefined;
}

ammo_round_up(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = [];
  if(isDefined(var_0)) {
    var_1[var_0] = self getrunningforwardpainanim(var_0);
  } else {
    foreach(var_0 in self.weaponlist) {
      var_1[var_0] = self getrunningforwardpainanim(var_0);
    }
  }

  return var_1;
}

unlimited_ammo(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(self.weaponlist)) {
    self.weaponlist = self getweaponslistprimaries();
  }

  var_2 = self.weaponlist;
  if(isDefined(var_1)) {
    var_2[var_2.size] = var_1;
  }

  self.has_fnf_weapon = 1;
  scripts\cp\utility::enable_infinite_ammo(1);
  while(scripts\engine\utility::istrue(self.has_fnf_weapon)) {
    var_3 = 0;
    foreach(var_5 in var_2) {
      if(var_5 == self getcurrentweapon() && weapon_no_unlimited_check(var_5)) {
        var_3 = 1;
        self setweaponammoclip(var_5, weaponclipsize(var_5), "left");
      }

      if(var_5 == self getcurrentweapon() && weapon_no_unlimited_check(var_5)) {
        var_3 = 1;
        self setweaponammoclip(var_5, weaponclipsize(var_5), "right");
      }

      if(var_3 == 0) {
        ammo_round_up(var_1);
      }
    }

    wait(0.05);
  }
}

weapon_no_unlimited_check(var_0) {
  var_1 = 1;
  foreach(var_3 in level.opweaponsarray) {
    if(var_0 == var_3) {
      var_1 = 0;
    }
  }

  return var_1;
}

deactivate_infinite_ammo() {
  level endon("disconnect");
  level endon("game_ended");
  self.has_fnf_weapon = undefined;
  wait(0.2);
  scripts\cp\utility::enable_infinite_ammo(0);
}

use_cant_miss(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  level endon("game_ended");
  for(;;) {
    self waittill("shot_missed", var_1);
    if(!scripts\cp\cp_weapon::isbulletweapon(var_1)) {
      continue;
    }

    if(scripts\cp\cp_weapon::has_attachment(var_1, "g18pap1") || scripts\cp\cp_weapon::has_attachment(var_1, "g18pap2")) {
      continue;
    }

    var_2 = self getweaponammoclip(var_1);
    self setweaponammoclip(var_1, var_2 + 1);
  }
}

use_force_push_near_death(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  level endon("game_ended");
  for(;;) {
    self waittill("player_damaged");
    if(self.health <= 45) {
      thread setandremoveinvulnerability();
      thread killnearbyzombies();
      scripts\cp\utility::notify_used_consumable(var_0);
    }
  }
}

setandremoveinvulnerability() {
  self notify("setAndRemoveInvulnerability");
  self endon("setAndRemoveInvulnerability");
  self endon("disconnect");
  level endon("game_ended");
  scripts\cp\utility::adddamagemodifier("near_death_consumable", 0, 0);
  scripts\engine\utility::waittill_any_timeout_no_endon_death(1, "death", "last_stand");
  scripts\cp\utility::removedamagemodifier("near_death_consumable", 0);
}

killnearbyzombies(var_0) {
  var_1 = 128;
  var_2 = vectornormalize(anglesToForward(self.angles));
  var_3 = var_2 * var_1;
  var_4 = self.origin + var_3;
  physicsexplosionsphere(var_4, var_1, 1, 2.5);
  var_5 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_6 = scripts\engine\utility::get_array_of_closest(self.origin, var_5, undefined, 24, 256);
  foreach(var_8 in var_6) {
    if(isDefined(var_8.agent_type) && var_8.agent_type == "zombie_sasquatch" || var_8.agent_type == "slasher" || var_8.agent_type == "superslasher" || var_8.agent_type == "zombie_brute" || var_8.agent_type == "zombie_grey" || var_8.agent_type == "zombie_clown" || var_8.agent_type == "alien_rhino") {
      continue;
    }

    if(scripts\engine\utility::istrue(var_8.var_9342)) {
      var_8 killrepulsorvictim(self, var_8.maxhealth, var_8.origin, self.origin);
      continue;
    }

    var_8 playSound("zmb_fnf_second_wind_push");
    var_9 = 0;
    var_10 = var_8.origin;
    var_11 = var_8.maxhealth;
    var_2 = anglesToForward(self.angles);
    var_12 = vectornormalize(var_2) * -100;
    var_8 setvelocity(vectornormalize(var_8.origin - self.origin + var_12) * 800 + (0, 0, 300));
    var_8 killrepulsorvictim(self, var_11, var_10, self.origin);
  }
}

killrepulsorvictim(var_0, var_1, var_2, var_3) {
  self.do_immediate_ragdoll = 1;
  if(var_1 >= self.health) {
    self.customdeath = 1;
  }

  self dodamage(var_1, var_2, var_0, var_0, "MOD_IMPACT", "zom_repulsor_mp");
}

torrent_start(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  level endon("game_ended");
  if(var_3 == 0 || var_3 == 3 || var_3 == 6) {
    playsoundatpos(var_1, "zmb_fnf_timely_torrent_lava");
  }

  playFX(level._effect["lava_torrent"], self.origin, undefined, anglestoup((0, 0, 90)));
  foreach(var_6 in var_2) {
    var_7 = (var_6.origin[0], var_6.origin[1], 90);
    if(var_6 scripts\cp\utility::agentisfnfimmune()) {
      continue;
    }

    if(isDefined(var_6.flung) || isDefined(var_6.agent_type) && var_6.agent_type == "zombie_brute" || var_6.agent_type == "zombie_ghost" || var_6.agent_type == "zombie_grey" || var_6.agent_type == "slasher" || var_6.agent_type == "superslasher") {
      continue;
    }

    if(distancesquared(var_6.origin, var_1) < 5184) {
      var_6.flung = 1;
      var_6.do_immediate_ragdoll = 1;
      var_6.disable_armor = 1;
      var_6 setsolid(0);
      var_6 setvelocity((0, 0, 600));
      wait(0.1);
      if(isDefined(var_6)) {
        var_6 dodamage(10000, var_1, var_4, var_4, "MOD_EXPLOSIVE");
      }
    }
  }

  self delete();
}

use_timely_torrent(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  level endon("game_ended");
  thread run_timely_torrent(var_0);
}

select_spot_array(var_0, var_1) {
  if(!isDefined(var_0.array_of_torrent_points)) {
    var_0.array_of_torrent_points = [];
  }

  var_2 = var_0.origin;
  var_3 = (0, 128, 0);
  var_4 = var_0 getplayerangles();
  var_5 = 7;
  var_6 = 0;
  var_2 = var_2 + var_3[0] * anglestoright(var_4);
  var_2 = var_2 + var_3[1] * anglesToForward(var_4);
  var_2 = var_2 + var_3[2] * anglestoup(var_4);
  var_7 = rotatepointaroundvector(anglestoup(var_4), anglesToForward(var_4), 0);
  var_8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_canshootclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_9 = scripts\common\trace::ray_trace(var_0 getEye(), var_2 + var_7, var_0, var_8);
  var_2 = var_9["position"] + var_7;
  if(var_1 == 0) {
    var_0.array_of_torrent_points[var_1] = var_2 + anglesToForward(var_4) * 60;
  } else {
    var_0.array_of_torrent_points[var_1] = var_2 + anglesToForward(var_4) * var_1 + 1 * 60;
  }

  return var_0.array_of_torrent_points;
}

run_timely_torrent(var_0) {
  self endon(var_0 + "_timeup");
  self endon("disconnect");
  level endon("game_ended");
  var_1 = [];
  var_2 = 0;
  for(;;) {
    self waittill("melee_fired");
    for(var_3 = 0; var_3 <= 5; var_3++) {
      var_1 = select_spot_array(self, var_3);
    }

    var_4 = 1200;
    self.closestenemies_array = [];
    var_5 = scripts\cp\cp_agent_utils::get_alive_enemies();
    foreach(var_8, var_7 in var_1) {
      var_1[var_8] = spawn("script_origin", var_7);
    }

    foreach(var_8, var_7 in var_1) {
      if(!isDefined(var_7)) {
        continue;
      }

      var_7 thread torrent_start(var_0, var_7.origin, var_5, var_8, self);
    }

    scripts\cp\utility::notify_used_consumable("timely_torrent");
  }
}

use_purify(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  self endon(var_0 + "_exited_early");
  level endon("game_ended");
  if(!isDefined(level.purify_active)) {
    level.purify_active = 1;
  } else {
    level.purify_active++;
  }

  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::is_valid_player()) {
      thread purify_activate(var_2);
    }
  }

  var_4 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, 24, 99999, 0);
  foreach(var_6 in var_4) {
    var_6 thread dealaoedamage(var_0);
    wait(0.1);
  }

  scripts\cp\utility::notify_used_consumable("purify");
  return 1;
}

purify_activate(var_0) {
  var_0 notify("force_regeneration");
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

dealaoedamage(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 = scripts\cp\cp_agent_utils::get_alive_enemies();
  var_2 = scripts\engine\utility::get_array_of_closest(self.origin, var_1, undefined, 24, 128, 0);
  if(var_2.size > 0) {
    self notify("force_regeneration");
    foreach(var_4 in var_2) {
      if(isDefined(var_4.agent_type) && var_4.agent_type == "zombie_brute" || var_4.agent_type == "zombie_ghost" || var_4.agent_type == "zombie_grey" || var_4.agent_type == "slasher" || var_4.agent_type == "alien_rhino" || var_4.agent_type == "superslasher") {
        continue;
      } else {
        playFX(level._effect["penetration_railgun_explosion"], self.origin);
        var_4 dodamage(var_4.health + 100, var_4.origin, self, self, "MOD_EXPLOSIVE", "iw7_explosive_touch_zm");
      }
    }

    self playSound("zmb_fnf_purify_explo");
  }
}

enable_outline_for_player(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 hudoutlineenableforclient(var_1, var_2, var_3, var_4);
}

disable_outline_for_player(var_0, var_1) {
  var_0 hudoutlinedisableforclient(var_1);
}

_magicbullet(var_0, var_1, var_2, var_3, var_4) {
  var_5 = magicbullet(var_0, var_1, var_2, var_3, var_4);
  if(isDefined(var_5) && isDefined(var_3)) {
    var_5 setotherent(var_3);
  }

  return var_5;
}

use_masochist(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  self endon(var_0 + "_exited_early");
  level endon("game_ended");
  thread removeslowmoveonlaststand(var_0);
  for(;;) {
    self waittill("player_damaged");
    scripts\cp\cp_persistence::give_player_currency(100, undefined, undefined, 1, "bonus");
  }
}

use_explosive_touch(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  thread remove_explosive_touch(var_0);
  for(;;) {
    if(!scripts\engine\utility::istrue(self.has_explosive_touch)) {
      self.has_explosive_touch = 1;
      thread watch_for_zombie_touch(var_0);
      scripts\cp\utility::adddamagemodifier("health_boost", 0.1, 0);
      self notify("force_regeneration");
      self playlocalsound("breathing_heartbeat_alt");
    }

    scripts\engine\utility::waitframe();
  }
}

watch_for_zombie_touch(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  while(scripts\engine\utility::istrue(self.has_explosive_touch)) {
    var_1 = scripts\cp\cp_agent_utils::get_alive_enemies();
    foreach(var_3 in var_1) {
      if(scripts\engine\utility::distance_2d_squared(var_3.origin, self.origin) <= 5184) {
        if(var_3 scripts\cp\utility::agentisfnfimmune()) {
          continue;
        }

        if(var_3 scripts\cp\utility::is_zombie_agent() && var_3.agent_type != "slasher" && var_3.agent_type != "superslasher" && var_3.agent_type != "zombie_brute" && var_3.agent_type != "zombie_grey") {
          var_3.exp_touch = 1;
          var_3.nocorpse = 1;
          var_3.full_gib = 1;
          playsoundatpos(var_3 gettagorigin("j_spineupper"), "zmb_fnf_explosive_touch_explo");
          wait(0.1);
          playFX(scripts\engine\utility::getfx("exp_touch"), var_3 gettagorigin("j_spineupper"));
          self radiusdamage(self.origin, 100, var_3.health + 1000, var_3.health, self, "MOD_EXPLOSIVE", "iw7_explosive_touch_zm");
          wait(0.3);
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

remove_explosive_touch(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::waittill_any(var_0 + "_timeup", var_0 + "_exited_early");
  self.has_explosive_touch = 0;
  scripts\cp\utility::removedamagemodifier("health_boost", 0);
  if(isDefined(self.explosivetrigger)) {
    self.explosivetrigger delete();
  }
}

use_shared_fate(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  self.marked_ents = [];
  thread look_at_and_outline_enemies(var_0);
  thread damage_on_marked_enemies(var_0);
}

damage_on_marked_enemies(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  for(;;) {
    self waittill("weapon_hit_marked_target", var_1, var_2, var_3, var_4, var_5);
    self.marked_ents = scripts\engine\utility::array_removeundefined(self.marked_ents);
    self.marked_ents = scripts\engine\utility::array_remove(self.marked_ents, var_5);
    foreach(var_7 in self.marked_ents) {
      if(var_5 == var_7) {
        continue;
      }

      if(var_7 scripts\cp\utility::agentisfnfimmune()) {
        continue;
      }

      if(var_7.health - var_2 <= 0) {
        var_7 setscriptablepartstate("shared_fate_fx", "inactive", 1);
      }

      self.marked_ents = scripts\engine\utility::array_remove(self.marked_ents, var_7);
      var_7 dodamage(var_2, var_7.origin, var_1, var_1, var_3, "iw7_shared_fate_weapon");
    }
  }
}

outline_enemeies(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  for(;;) {
    foreach(var_2 in self.marked_ents) {
      if(var_2 scripts\cp\utility::agentisfnfimmune()) {
        continue;
      }

      if(isDefined(var_2.agent_type) && var_2.agent_type == "zombie_sasquatch" || var_2.agent_type == "slasher" || var_2.agent_type == "superslasher" || var_2.agent_type == "zombie_brute" || var_2.agent_type == "zombie_grey" || var_2.agent_type == "zombie_clown" || var_2.agent_type == "skater") {
        continue;
      }

      if(scripts\cp\utility::is_melee_weapon(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc_melee(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc2_melee(self getcurrentweapon())) {
        scripts\engine\utility::waitframe();
        continue;
      }

      if(scripts\engine\utility::istrue(var_2.marked_shared_fate_fnf)) {
        var_2 setscriptablepartstate("shared_fate_fx", "active", 1);
        continue;
      }

      if(isDefined(var_2)) {
        var_2 setscriptablepartstate("shared_fate_fx", "inactive", 1);
      }
    }

    scripts\engine\utility::waitframe();
  }
}

look_at_and_outline_enemies(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  var_1 = 0;
  for(;;) {
    if(self adsButtonPressed() && !var_1) {
      if(scripts\cp\utility::is_melee_weapon(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc_melee(self getcurrentweapon())) {
        scripts\engine\utility::waitframe();
        continue;
      }

      var_1 = 1;
      var_2 = self getplayerangles();
      var_3 = self getEye();
      var_4 = anglesToForward(var_2);
      var_5 = var_3 + var_4 * 500;
      var_6 = scripts\common\trace::create_contents(1, 0, 0, 0, 0, 0, 0);
      var_7 = physics_raycast(var_3, var_5, var_6, self, 0, "physicsquery_closest");
      if(var_7.size <= 0) {
        scripts\engine\utility::waitframe();
        continue;
      }

      var_8 = var_7[0]["entity"];
      if(isDefined(var_8)) {
        if(var_8 scripts\cp\utility::agentisfnfimmune()) {
          continue;
        }

        if(isDefined(var_8.agent_type) && var_8.agent_type == "zombie_sasquatch" || var_8.agent_type == "slasher" || var_8.agent_type == "superslasher" || var_8.agent_type == "zombie_brute" || var_8.agent_type == "zombie_grey" || var_8.agent_type == "zombie_clown") {
          continue;
        }

        if(var_8 scripts\cp\utility::is_zombie_agent()) {
          if(!scripts\engine\utility::array_contains(self.marked_ents, var_8)) {
            self playlocalsound("zmb_fnf_shared_fate_highlight");
            var_8.marked_shared_fate_fnf = 1;
            self.marked_ents = scripts\engine\utility::array_add(self.marked_ents, var_8);
            var_8 setscriptablepartstate("shared_fate_fx", "active", 1);
          }
        }
      }

      var_1 = 0;
    } else {
      var_1 = 0;
    }

    scripts\engine\utility::waitframe();
  }
}

use_fire_chains(var_0) {
  self endon(var_0 + "_timeup");
  self endon("last_stand");
  self endon("disconnect");
  level endon("game_ended");
  self.life_link_active = undefined;
  self.life_linked = 1;
  var_1 = "j_spine4";
  var_2 = ["j_spine4", "j_spineupper", "j_spinelower", "j_head", "j_knee_ri", "j_knee_le", "j_elbow_ri", "j_elbow_le", "j_ankle_le", "j_ankle_ri", "j_wrist_le", "j_wrist_ri"];
  thread removefirechainsdamagemodifierontimeout(var_0);
  thread removefirechainsdamagemodifieronlaststand(var_0);
  var_3 = self;
  for(;;) {
    var_4 = getfirechainstarget(self);
    if(isDefined(var_4)) {
      self.besttarget = var_4;
      self.linked_to_player = 1;
      thread playfirechainsfx(var_4, var_1, var_0);
      var_3.life_link_active = 1;
      linktoplayer_fire_chains(self, var_4, var_2);
    } else {
      var_3.life_link_active = undefined;
      wait(0.5);
    }

    scripts\engine\utility::waitframe();
  }
}

getfirechainstarget(var_0) {
  var_1 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.players, [var_0], 4, 512);
  var_2 = sortbydistance(var_1, var_0.origin);
  var_3 = undefined;
  foreach(var_5 in var_2) {
    var_6 = sighttracepassed(var_0 getEye(), var_5 getEye(), 0, var_0);
    if(!var_6) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_5.inlaststand)) {
      continue;
    }

    var_3 = var_5;
    break;
  }

  return var_3;
}

linktoplayer_fire_chains(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_0 endon("disconnect");
  while(scripts\engine\utility::istrue(var_0.linked_to_player)) {
    thread deal_damage_to_zombies_entering_the_link(self, var_2);
    if(scripts\engine\utility::istrue(var_1.inlaststand)) {
      var_0.linked_to_player = undefined;
      var_0 notify("lost_target_fire_chains");
      break;
    } else if(distance(var_0.origin, var_1.origin) > 512) {
      var_0.linked_to_player = undefined;
      var_0 notify("lost_target_fire_chains");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

deal_damage_to_zombies_entering_the_link(var_0, var_1) {
  var_0 endon("disconnect");
  var_2 = [];
  var_3 = scripts\common\trace::create_character_contents();
  var_2 = [var_0, var_0.besttarget];
  if(!isDefined(var_0.besttarget)) {
    return;
  }

  foreach(var_5 in var_1) {
    var_6 = scripts\common\trace::ray_trace(var_0 gettagorigin(var_5), var_0.besttarget gettagorigin(var_5), var_2, var_3);
    if(isDefined(var_6["entity"])) {
      if(var_6["entity"] scripts\cp\utility::agentisfnfimmune()) {
        continue;
      }

      var_7 = scripts\engine\utility::istrue(var_6["entity"].is_skeleton);
      if(level.script == "cp_final") {
        var_7 = 0;
      }

      if(var_6["entity"] scripts\cp\utility::is_zombie_agent() && var_6["entity"].agent_type != "slasher" && var_6["entity"].agent_type != "superslasher" && var_6["entity"].agent_type != "zombie_brute" && var_6["entity"].agent_type != "zombie_grey") {
        scripts\engine\utility::array_add(var_2, var_6["entity"]);
        var_6["entity"].nocorpse = 1;
        var_6["entity"].full_gib = 1;
        var_6["entity"] dodamage(1000000, var_6["entity"].origin, var_0, var_0);
      }
    }
  }
}

playfirechainsfx(var_0, var_1, var_2) {
  var_3 = [];
  foreach(var_5 in level.players) {
    var_3[var_3.size] = playfxontagsbetweenclients(level._effect["fire_chains"], self, var_1, var_0, var_1, var_5);
  }

  self.fx_array_fire_chains = var_3;
  self playLoopSound("zmb_fnf_fire_chains_lp");
  var_0 playLoopSound("zmb_fnf_fire_chains_lp");
  var_7 = scripts\cp\utility::waittill_any_ents_return(self, "disconnect", self, "lost_target_fire_chains", self, "last_stand", self, var_2 + "_timeup", var_0, "disconnect", var_0, "last_stand", level, "game_ended");
  if(isDefined(self)) {
    self stoploopsound();
  }

  if(isDefined(var_0)) {
    var_0 stoploopsound();
  }

  foreach(var_9 in var_3) {
    if(isDefined(var_9)) {
      var_9 delete();
    }
  }
}

removefirechainsdamagemodifieronlaststand(var_0) {
  self endon(var_0 + "_timeup");
  self waittill("last_stand");
  self.life_linked = undefined;
  self.life_link_active = undefined;
  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
  }

  self notify(var_0 + "_exited_early");
}

removefirechainsdamagemodifierontimeout(var_0) {
  self endon("last_stand");
  self waittill(var_0 + "_timeup");
  self.life_linked = undefined;
  self.life_link_active = undefined;
  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
  }
}

use_irish_luck(var_0) {
  self endon(var_0 + "_timeup");
  self endon("last_stand");
  self endon("disconnect");
  level endon("game_ended");
}

irish_luck_choose_random_consumable(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  if(!isDefined(var_0.stored_fnf)) {
    var_0.stored_fnf = [];
  }

  foreach(var_3, var_2 in var_0.consumables) {
    var_0.stored_fnf[var_3] = var_3;
  }

  for(;;) {
    var_4 = scripts\engine\utility::random(level.irish_luck_consumables);
    if(getDvar("irish_luck_debug", "") != "") {
      var_0.stored_fnf = [];
      var_5 = getDvar("irish_luck_debug", "");
      foreach(var_8, var_7 in level.irish_luck_consumables) {
        if(var_8 == var_5) {
          var_4 = level.irish_luck_consumables[var_8];
        }
      }
    }

    if(scripts\engine\utility::array_contains(var_0.stored_fnf, var_4.name)) {
      scripts\engine\utility::waitframe();
      continue;
    } else {
      scripts\engine\utility::waitframe();
      return var_4;
    }

    scripts\engine\utility::waitframe();
  }
}

clear_omnvar(var_0) {
  self endon("disconnect");
  wait(5);
  self setclientomnvar(var_0, 0);
}

consumable_activate_internal_irish(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("dpad_end_" + var_0);
  self endon("give_new_deck");
  self endon("last_stand");
  level.random_consumable_chosen = irish_luck_choose_random_consumable(self);
  if(self.consumables[var_0].uses > 0 && self.consumables[var_0].on == 0 && !scripts\cp\cp_laststand::player_in_laststand(self)) {
    self.consumables[level.random_consumable_chosen.name] = spawnStruct();
    self.consumables[level.random_consumable_chosen.name].uses = level.consumables[level.random_consumable_chosen.name].uses;
    self.consumables[level.random_consumable_chosen.name].on = 1;
    self.consumables[level.random_consumable_chosen.name].times_used = 0;
    self.consumables[level.random_consumable_chosen.name].usednotify = var_4;
    level.random_consumable_chosen.ref = int(tablelookup("cp\loot\iw7_zombiefatefortune_loot_master.csv", 1, level.random_consumable_chosen.name, 0));
    self setclientomnvar("zm_ui_irish_luck", level.random_consumable_chosen.ref);
    thread clear_omnvar("zm_ui_irish_luck");
    self setclientomnvar("zm_fate_card_used", var_5);
    self.consumables[var_0].processing = 1;
    var_7 = undefined;
    var_8 = "fired_super";
    thread set_consumable(var_0);
    if(isDefined(level.consumables[level.random_consumable_chosen.name].usefunc)) {
      if(isDefined(level.consumables[level.random_consumable_chosen.name].testforsuccess)) {
        var_7 = self[[level.consumables[level.random_consumable_chosen.name].usefunc]](level.random_consumable_chosen.name);
      } else {
        var_7 = self thread[[level.consumables[level.random_consumable_chosen.name].usefunc]](level.random_consumable_chosen.name);
      }
    }

    self.consumables[var_0].on = 0;
    if(!isDefined(var_7) || isDefined(var_7) && var_7) {
      consume_from_inventory(self, var_0);
      self.consumables[var_0].times_used++;
      scripts\cp\zombies\zombie_analytics::log_fafcardused(1, var_0, level.wave_num, self);
      scripts\cp\cp_merits::processmerit("mt_faf_uses");
      thread scripts\cp\cp_vo::try_to_play_vo("wonder_consume", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
      if(self.consumables[var_0].times_used == 1) {
        thread decrement_counter_of_consumables(var_0);
      }

      thread lightbar_off();
      self setclientomnvar("zm_dpad_up_activated", 5);
      self setclientomnvarbit("zm_card_fill_display", var_5, 1);
      self setclientomnvar("zm_consumable_selection_ready", 0);
      remove_card_from_use(var_6);
      thread meter_fill_up();
      self playlocalsound("ui_consumable_select");
      play_consumable_activate_sound(self);
      self notify("consumable_selected");
      self setweaponammostock(self.fate_card_weapon, 1);
      self giveandfireoffhand(self.fate_card_weapon);
      self.consumable_meter_full = undefined;
      thread scripts\cp\cp_vo::remove_from_nag_vo("nag_use_fateandfort");
      var_9 = level.consumables[level.random_consumable_chosen.name].type;
      if(var_9 == "timedactivations") {
        thread dpad_drain_time(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].usageperiod, var_1, var_8, var_2, var_3, var_4, var_5);
      } else if(var_9 == "wave") {
        thread dpad_drain_wave(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].usageperiod, var_1, var_8, var_2, var_3, var_4, var_5);
      } else if(var_9 == "triggernow" || level.consumables[level.random_consumable_chosen.name].type == "triggerwait") {
        thread dpad_drain_activations(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].type, self.consumables[level.random_consumable_chosen.name].uses, var_1, var_8, var_2, var_3, var_4, var_5);
      } else if(var_9 == "triggerpassive") {
        thread dpad_drain_triggerpassive(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].passiveuses, var_1, var_8, var_2, var_3, var_4, var_5);
      }

      if(isDefined(var_7)) {
        scripts\cp\utility::notify_used_consumable(var_0);
        return;
      }

      return;
    }

    self playlocalsound("ui_consumable_deny");
    self.consumables[var_0].processing = undefined;
  }
}

use_temporal_increase(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  self endon("last_stand");
  if(isDefined(level.temporal_increase)) {
    return 0;
  }

  level.temporal_increase = 2;
  thread remove_temporal_increase(var_0);
}

remove_temporal_increase(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::waittill_any(var_0 + "_timeup", "disconnect", "death", var_0 + "_exited_early");
  level.temporal_increase = undefined;
  return 1;
}

use_twister(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  self endon(var_0 + "_exited_early");
  self endon("death");
  self endon("last_stand");
  level endon("game_ended");
  var_1 = self getplayerangles();
  var_2 = self getEye();
  var_3 = (0, 0, 0);
  var_4 = anglesToForward(var_1);
  var_5 = var_2 + var_4 * 100;
  thread remove_twister(var_0, self);
  thread activate_twister_homing(self.origin, var_0);
}

remove_twister(var_0, var_1) {
  level endon("game_ended");
  var_1 scripts\engine\utility::waittill_any(var_0 + "_timeup", var_0 + "_exited_early", "disconnect");
  level notify("stop_twister_sfx");
  if(isDefined(var_1.fx_ent)) {
    var_1.fx_ent delete();
  }

  if(isDefined(var_1.trigger_move_ent)) {
    var_1.trigger_move_ent delete();
  }
}

activate_twister_homing(var_0, var_1) {
  self endon("disconnect");
  self endon(var_1 + "_timeup");
  self endon(var_1 + "_exited_early");
  level endon("game_ended");
  if(!isDefined(self.twister_array_zombie)) {
    self.twister_array_zombie = [];
  }

  self.trigger_move_ent = spawn("script_model", var_0, 0, 512, 128);
  self.trigger_move_ent setModel("tag_origin");
  level.trigger_move_ent_sfx = spawn("script_model", var_0, 0, 512, 128);
  level.trigger_move_ent_sfx linkto(self.trigger_move_ent);
  wait(0.5);
  level.trigger_move_ent_sfx thread twister_sfx();
  playFXOnTag(level._effect["twister"], self.trigger_move_ent, "tag_origin");
  self.trigger_move_ent setotherent(self);
  self.trigger_move_ent thread deal_damage_to_enemies(self, var_1);
  thread move_ent_function(self.trigger_move_ent, var_1);
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

get_zombie_targets(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon(var_1 + "_timeup");
  var_0 endon(var_1 + "_exited_early");
  level endon("game_ended");
  for(;;) {
    var_2 = scripts\cp\cp_agent_utils::get_alive_enemies();
    var_3 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2, undefined, 24, 2048);
    if(isDefined(level.dlc4_boss)) {
      if(scripts\engine\utility::array_contains(var_3, level.dlc4_boss)) {
        var_3 = scripts\engine\utility::array_remove(var_3, level.dlc4_boss);
      }
    }

    if(var_3.size <= 0) {
      scripts\engine\utility::waitframe();
      var_0.twister_array_zombie = [];
      var_0.twister_array_zombie[var_0.twister_array_zombie.size] = getclosestpointonnavmesh(self.origin) + (0, 10, 0);
      continue;
    } else {
      foreach(var_5 in var_3) {
        if(var_5 scripts\cp\utility::agentisfnfimmune() && var_5.agent_type != "alien_rhino") {
          scripts\engine\utility::waitframe();
          continue;
        }

        if(scripts\engine\utility::istrue(level.meph_fight_started)) {
          if(var_5 scripts\cp\utility::agentisfnfimmune()) {
            scripts\engine\utility::waitframe();
            continue;
          } else {
            var_0.twister_array_zombie = var_0 findpath(var_0.origin, scripts\engine\utility::drop_to_ground(var_3[var_3.size - 1].origin, 1, 1));
          }

          continue;
        }

        if(isDefined(level.rhino_array) && level.rhino_array.size > 0) {
          var_0.twister_array_zombie = var_0 findpath(var_0.origin, scripts\engine\utility::drop_to_ground(var_3[var_3.size - 1].origin, 1, 1));
          continue;
        }

        if(scripts\engine\utility::istrue(var_5.entered_playspace)) {
          var_0.twister_array_zombie = var_0 findpath(var_0.origin, scripts\engine\utility::drop_to_ground(var_3[var_3.size - 1].origin, 1, 1));
        }
      }
    }

    wait(2.5);
  }
}

deal_damage_to_enemies(var_0, var_1) {
  self endon("death");
  var_0 endon("disconnect");
  var_0 endon(var_1 + "_timeup");
  var_0 endon(var_1 + "_exited_early");
  level endon("game_ended");
  for(;;) {
    var_2 = scripts\cp\cp_agent_utils::get_alive_enemies();
    foreach(var_4 in var_2) {
      if(!isDefined(var_4)) {
        continue;
      }

      if(!var_4 scripts\cp\utility::is_zombie_agent()) {
        continue;
      }

      if(distance2dsquared(self.origin, var_4.origin) < 22500) {
        if(var_4 scripts\cp\utility::agentisfnfimmune()) {
          var_4 dodamage(5, var_4.origin, var_0, var_0, "MOD_UNKNOWN");
          continue;
        }

        if(isDefined(var_4.agent_type) && var_4.agent_type == "slasher" || var_4.agent_type == "superslasher") {
          var_4 dodamage(1000, var_4.origin, var_0, var_0, "MOD_UNKNOWN");
          continue;
        }

        var_4 thread fling_zombie_thundergun_harpoon(var_4.health + 1000, var_4, var_0, self);
      }
    }

    wait(1);
  }
}

fling_zombie_thundergun_harpoon(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_3 endon("death");
  if(!isDefined(var_3)) {
    return;
  }

  var_4 = var_1.origin - var_3.origin;
  var_5 = anglestoup(self.angles);
  self setvelocity(vectornormalize(var_3.origin - self.origin * 400) + (0, 0, 800));
  wait(0.16);
  if(isDefined(var_2)) {
    var_1.do_immediate_ragdoll = 1;
    var_1.disable_armor = 1;
    var_1.customdeath = 1;
    wait(0.1);
    var_1.nocorpse = 1;
    var_1.full_gib = 1;
    self dodamage(self.health + 1000, var_1.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_twister_zm");
    return;
  }

  self.nocorpse = 1;
  self.full_gib = 1;
  self dodamage(self.health + 1000, var_1.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_twister_zm");
}

move_ent_function(var_0, var_1) {
  self endon("disconnect");
  self endon(var_1 + "_timeup");
  self endon(var_1 + "_exited_early");
  var_2 = 0;
  thread get_zombie_targets(self, var_1);
  for(;;) {
    if(!isDefined(self.twister_array_zombie[var_2]) && var_2 >= self.twister_array_zombie.size) {
      if(self.twister_array_zombie.size > 0) {
        if(isDefined(self.twister_array_zombie[0])) {
          if([[level.active_volume_check]](self.twister_array_zombie[0])) {
            var_0 moveto(self.twister_array_zombie[0], 0.5, 0.25, 0);
          } else {
            var_3 = getclosestpointonnavmesh(self.twister_array_zombie[0]) + (0, 10, 0);
            var_0 moveto(var_3, 0.5);
          }

          var_2--;
        }
      } else {
        var_2 = 0;
      }

      scripts\engine\utility::waitframe();
      continue;
    } else {
      var_0 moveto(self.twister_array_zombie[var_2], 0.5, 0, 0);
    }

    var_2 = var_2 + 1;
    scripts\engine\utility::waitframe();
  }
}

use_dodge_mode(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  self endon(var_0 + "_exited_early");
  self endon("last_stand");
  self endon("death");
  level endon("game_ended");
  self energy_setmax(1, 50);
  self energy_setenergy(1, 50);
  self energy_setrestorerate(1, 25);
  self energy_setresttimems(1, 0);
  self allowdodge(1);
  self func_8454(5);
  thread func_139F9(var_0);
  thread remove_dodge_mode(var_0);
}

remove_dodge_mode(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any(var_0 + "_timeup", var_0 + "_exited_early", "death", "last_stand");
  self allowdodge(0);
  self notify(var_0 + "_timeup");
  self notify(var_0 + "_exited_early");
}

watchforzombiecollisions(var_0) {
  self endon("death");
  self endon("disconnect");
  self notify("setDodge");
  self endon("setDodge");
  self endon(var_0 + "_timeup");
  self endon(var_0 + "_exited_early");
  level endon("game_ended");
  self endon("last_stand");
  while(scripts\engine\utility::istrue(self.dodging)) {
    var_1 = scripts\cp\cp_agent_utils::get_alive_enemies();
    foreach(var_3 in var_1) {
      if(scripts\engine\utility::distance_2d_squared(var_3.origin, self.origin) <= 5184) {
        if(var_3 scripts\cp\utility::agentisfnfimmune()) {
          continue;
        }

        if(var_3 scripts\cp\utility::is_zombie_agent() && var_3.agent_type != "slasher" && var_3.agent_type != "superslasher" && var_3.agent_type != "zombie_brute" && var_3.agent_type != "zombie_grey") {
          var_3.exp_touch = 1;
          var_3.nocorpse = 1;
          var_3.full_gib = 1;
          var_3.hit_by_dodging_player = 1;
          playsoundatpos(var_3 gettagorigin("j_spineupper"), "zmb_fnf_explosive_touch_explo");
          wait(0.1);
          playFX(scripts\engine\utility::getfx("dodge_touch"), var_3 gettagorigin("j_spineupper"));
          var_3 dodamage(var_3.health + 100, var_3.origin, self, self, "MOD_EXPLOSIVE", "iw7_pickup_zm");
        }
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_139F9(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  self endon(var_0 + "_exited_early");
  level endon("game_ended");
  self endon("last_stand");
  self endon("death");
  for(;;) {
    self waittill("dodgeBegin");
    if(isDefined(self.controlsfrozen) && self.controlsfrozen == 1) {
      continue;
    }

    self.dodging = 1;
    thread func_139FB(var_0);
    thread watchforzombiecollisions(var_0);
    var_1 = self getnormalizedmovement();
    for(;;) {
      if(var_1[0] > 0) {
        if(var_1[1] <= 0.7 && var_1[1] >= -0.7) {
          playFX(scripts\engine\utility::getfx("dodge_fwd_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
          break;
        }

        if(var_1[0] > 0.5 && var_1[1] > 0.7) {
          playFX(scripts\engine\utility::getfx("dodge_fwd_right_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
          break;
        }

        if(var_1[0] > 0.5 && var_1[1] < -0.7) {
          playFX(scripts\engine\utility::getfx("dodge_fwd_left_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
          break;
        }
      }

      if(var_1[0] < 0) {
        if(var_1[1] < 0.4 && var_1[1] > -0.4) {
          playFX(scripts\engine\utility::getfx("dodge_back_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
          break;
        }

        if(var_1[0] < -0.5 && var_1[1] > 0.5) {
          playFX(scripts\engine\utility::getfx("dodge_back_right_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
          break;
        }

        if(var_1[0] < -0.5 && var_1[1] < -0.5) {
          playFX(scripts\engine\utility::getfx("dodge_back_left_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
          break;
        }
      }

      if(var_1[1] > 0.4) {
        playFX(scripts\engine\utility::getfx("dodge_right_screen"), self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles), self);
        break;
      }

      if(var_1[1] < -0.4) {
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

func_139FB(var_0) {
  level endon("game_ended");
  scripts\engine\utility::waittill_any("dodgeEnd", "death", "disconnect", "last_stand");
  self.dodging = 0;
  if(isDefined(self.var_5809)) {
    self.var_5809 delete();
  }
}

use_ammo_crate(var_0) {
  if(isDefined(level.ammo_crate)) {
    self.consumables[var_0].on = 0;
    return 0;
  }

  create_ammo_crate_interaction(var_0);
}

create_ammo_crate_interaction(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  self endon(var_0 + "_exited_early");
  self endon("death");
  self endon("last_stand");
  level endon("game_ended");
  var_1 = scripts\engine\utility::drop_to_ground(self.origin, 0, -2000);
  var_2 = spawn("script_model", var_1);
  var_2 setModel("tag_origin_ammo_crate");
  level.ammo_crate = var_2;
  level.ammo_crate thread give_ammo_to_players_standing_nearby(self, var_0);
  thread remove_ammo_crate(var_0);
}

give_ammo_to_players_standing_nearby(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("last_stand");
  self endon("death");
  var_0 endon("disconnect");
  var_0 endon(var_1 + "_timeup");
  var_0 endon(var_1 + "_exited_early");
  level endon("game_ended");
  for(;;) {
    foreach(var_0 in level.players) {
      if(!isDefined(var_0)) {
        continue;
      }

      if(distance2dsquared(self.origin, var_0.origin) < 22500) {
        if(var_0 cangive_ammo()) {
          playFX(level._effect["ammo_crate_ping"], self.origin, anglesToForward(self.angles), anglestoup(self.angles));
          var_0 give_ammo_to_player_through_crate();
          var_0 notify("consumable_charge", 150);
          var_0 thread scripts\cp\cp_vo::try_to_play_vo("pillage_ammo", "zmb_comment_vo", "low", 10, 0, 1, 0, 50);
          scripts\engine\utility::waitframe();
          continue;
        }

        var_0 scripts\cp\utility::setlowermessage("max_ammo", &"COOP_GAME_PLAY_AMMO_MAX", 3);
      }
    }

    wait(5);
  }
}

cangive_ammo() {
  var_0 = scripts\cp\utility::getvalidtakeweapon();
  var_1 = self getweaponammoclip(var_0);
  var_2 = weaponclipsize(var_0);
  var_3 = weaponmaxammo(var_0);
  var_4 = self getweaponammostock(var_0);
  if(var_4 < var_3 || var_1 < var_2) {
    return 1;
  }

  return 0;
}

give_ammo_to_player_through_crate() {
  var_0 = self getweaponslistprimaries();
  foreach(var_2 in var_0) {
    if(!scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(weapontype(var_2) == "riotshield") {
      continue;
    }

    if(scripts\cp\cp_weapon::is_incompatible_weapon(var_2)) {
      continue;
    }

    var_3 = weaponclipsize(var_2);
    adjust_clip_ammo_from_stock(self, var_2, "right", var_3, 0);
    if(self isdualwielding()) {
      adjust_clip_ammo_from_stock(self, var_2, "left", var_3, 1);
    }
  }

  self playlocalsound("weap_ammo_pickup");
}

adjust_clip_ammo_from_stock(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\engine\utility::istrue(var_4)) {
    var_5 = weaponmaxammo(var_1);
    var_6 = var_0 getweaponammostock(var_1);
    var_7 = var_5 - var_6;
    var_8 = scripts\engine\utility::ter_op(var_7 >= var_3, var_6 + var_3, var_5);
    var_0 setweaponammostock(var_1, var_8);
  }

  var_9 = var_0 getweaponammoclip(var_1, var_2);
  var_10 = var_3 - var_9;
  var_11 = min(var_9 + var_10, var_3);
  var_0 setweaponammoclip(var_1, int(var_11), var_2);
}

remove_ammo_crate(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any(var_0 + "_timeup", var_0 + "_exited_early", "last_stand", "death");
  scripts\cp\utility::notify_used_consumable("ammo_crate");
  if(isDefined(level.ammo_crate)) {
    level.ammo_crate delete();
  }
}

use_stimulus(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  self endon(var_0 + "_exited_early");
  self endon("death");
  self endon("last_stand");
  level endon("game_ended");
  self.stimulus_active = 1;
  thread remove_stimulus(var_0);
}

revive_downed_entities(var_0) {
  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  scripts\cp\cp_laststand::instant_revive(var_0);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.1);
}

remove_stimulus(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any(var_0 + "_timeup", var_0 + "_exited_early", "last_stand", "death");
  if(scripts\engine\utility::istrue(self.stimulus_active)) {
    self.stimulus_active = undefined;
  }
}

applyvisionsettoallplayers(var_0) {
  level.current_vision_set = var_0;
  level.vision_set_override = level.current_vision_set;
  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!isalive(var_2)) {
      continue;
    }

    var_2 visionsetnakedforplayer(var_0, 1);
  }

  switch (var_0) {
    case "cp_town_bw_r":
      var_0 = "cp_town_bw_r";
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
      var_0 = "cp_town_bw_g";
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
      var_0 = "cp_town_bw_b";
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
      var_0 = "cp_town_color";
      setomnvar("zm_chem_current_color", 0);
      setomnvar("zm_chem_bvalue_choice", level.bad_choice_index_default);
      setomnvar("zm_chem_value_choice", 0);
      break;
  }
}

use_activate_gns_machine(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  foreach(var_2 in level.players) {
    if(self != var_2) {
      if(var_2 scripts\cp\utility::is_consumable_active(var_0)) {
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
  thread remove_activate_gns_machine(var_0);
  self waittill("end_this_gns_fnf_card");
  if(isDefined(level.gns_game_console_vfx)) {
    level.gns_game_console_vfx delete();
  }

  if(isDefined(level.entered_thru_card)) {
    level.entered_thru_card = undefined;
  }

  scripts\cp\utility::notify_used_consumable(var_0);
  self notify(var_0 + "_timeup");
  self notify(var_0 + "_exited_early");
}

remove_activate_gns_machine(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("end_this_gns_fnf_card");
  for(;;) {
    var_1 = scripts\cp\utility::waittill_any_ents_return(self, "last_stand", self, var_0 + "_timeup", self, var_0 + "_exited_early", level, "end_this_thread_of_gns_fnf_card");
    if(isDefined(var_1)) {
      if(var_1 == "last_stand") {
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

get_activated_vfx_postion_based_on_map(var_0) {
  switch (var_0) {
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

get_corner_position_based_on_map(var_0) {
  switch (var_0) {
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

get_activation_radius_square_based_on_map(var_0) {
  switch (var_0) {
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

wait_for_player_activation(var_0) {
  self endon("last_stand");
  self endon("end_this_gns_fnf_card");
  level endon("player_debug_activate_cabinet");
  level endon("end_this_thread_of_gns_fnf_card");
  var_1 = get_activated_vfx_postion_based_on_map(level.script);
  var_2 = undefined;
  if(level.script == "cp_zmb") {
    var_2 = disable_arcade_cabinet_next_to_ghost_n_skull();
    var_3 = getent("ghost_arcade_activation_area", "targetname");
  }

  level.gns_game_console_vfx = spawnfx(level._effect["GnS_activation"], var_1);
  triggerfx(level.gns_game_console_vfx);
  var_4 = get_corner_position_based_on_map(level.script);
  var_5 = get_activation_radius_square_based_on_map(level.script);
  for(;;) {
    var_6 = 1;
    foreach(var_8 in level.players) {
      if(scripts\engine\utility::istrue(var_8.inlaststand)) {
        var_6 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_8.iscarrying)) {
        var_6 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_8.isusingsupercard)) {
        var_6 = 0;
        break;
      }

      if(distancesquared(var_8.origin, var_4) > var_5) {
        var_6 = 0;
        break;
      }

      if(!var_8 useButtonPressed()) {
        var_6 = 0;
        break;
      }

      if(!scripts\engine\utility::istrue(var_0.activate_gns_machine)) {
        var_6 = 0;
        break;
      }
    }

    wait(0.25);
    if(var_6) {
      var_6 = 1;
      foreach(var_8 in level.players) {
        if(scripts\engine\utility::istrue(var_8.inlaststand)) {
          var_6 = 0;
          break;
        }

        if(scripts\engine\utility::istrue(var_8.iscarrying)) {
          var_6 = 0;
          break;
        }

        if(scripts\engine\utility::istrue(var_8.isusingsupercard)) {
          var_6 = 0;
          break;
        }

        if(distancesquared(var_8.origin, var_4) > var_5) {
          var_6 = 0;
          break;
        }

        if(!var_8 useButtonPressed()) {
          var_6 = 0;
          break;
        }

        if(!scripts\engine\utility::istrue(var_0.activate_gns_machine)) {
          var_6 = 0;
          break;
        }

        if(level.script == "cp_disco") {
          if(isDefined(level.clock_interaction) && isDefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_8) {
            var_6 = 0;
          }

          if(isDefined(level.clock_interaction_q2) && isDefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_8) {
            var_6 = 0;
          }

          if(isDefined(level.clock_interaction_q3) && isDefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_8) {
            var_6 = 0;
          }

          if(scripts\engine\utility::istrue(var_8.start_breaking_clock)) {
            var_6 = 0;
          }

          if(scripts\engine\utility::istrue(var_8.is_using_gourd)) {
            var_6 = 0;
          }

          if(scripts\engine\utility::istrue(var_8.kung_fu_mode)) {
            var_6 = 0;
          }
        }
      }
    }

    if(var_6) {
      if(isDefined(level.gns_game_console_vfx)) {
        level.gns_game_console_vfx delete();
        if(level.script == "cp_zmb") {
          enable_arcade_cabinet_next_to_ghost_n_skull(var_2);
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
  var_0 = get_arcade_interaction_next_to_ghost_n_skull();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  return var_0;
}

enable_arcade_cabinet_next_to_ghost_n_skull(var_0) {
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

get_arcade_interaction_next_to_ghost_n_skull() {
  var_0 = (2829, -538, 241);
  foreach(var_2 in level.current_interaction_structs) {
    if(distancesquared(var_2.origin, var_0) < 100) {
      return var_2;
    }
  }
}

use_get_pap2_gun(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  if(self isonladder()) {
    self.consumables[var_0].on = 0;
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
    self.consumables[var_0].on = 0;
    return 0;
  }

  var_1 = choose_random_weapon_from_list(var_0);
  scripts\cp\utility::notify_used_consumable(var_0);
  return var_1;
}

choose_random_weapon_from_list(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  for(;;) {
    var_1 = scripts\engine\utility::random(level.pap);
    var_2 = self getcurrentweapon();
    var_3 = scripts\cp\utility::getrawbaseweaponname(var_1);
    if(can_upgrade_via_pap2fnfcard(var_1, 1)) {
      thread settenthstimer(self, var_0, var_3, var_1);
      self.isusingsupercard = 0;
      return 1;
    } else {
      scripts\engine\utility::waitframe();
      continue;
    }
  }
}

settenthstimer(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = self getweaponslistprimaries();
  var_10 = self getweaponslistprimaries().size;
  var_11 = 3;
  var_12 = var_2;
  var_13 = spawnStruct();
  var_13.lvl = 2;
  var_0.pap[var_12] = var_13;
  if(!var_0 scripts\cp\cp_weapon::has_weapon_variation(var_3)) {
    var_14 = var_0 scripts\cp\utility::getvalidtakeweapon();
    var_0.curr_weap = var_14;
    if(isDefined(var_14)) {
      var_5 = 1;
      var_15 = scripts\cp\utility::getrawbaseweaponname(var_14);
      if(var_0 scripts\cp\utility::has_special_weapon() && var_10 < var_11 + 1) {
        var_5 = 0;
      }

      foreach(var_11 in var_9) {
        if(scripts\cp\utility::isstrstart(var_11, "alt_")) {
          var_11++;
        }
      }

      if(scripts\cp\utility::has_zombie_perk("perk_machine_more")) {
        var_11++;
      }

      if(var_9.size < var_11) {
        var_5 = 0;
      }

      if(var_5) {
        if(isDefined(var_0.pap[var_15])) {
          var_0.pap[var_15] = undefined;
          var_0 notify("weapon_level_changed");
        }

        var_0 takeweapon(var_14);
      }
    }

    if(isDefined(var_0.weapon_build_models[var_12])) {
      var_6 = var_0.weapon_build_models[var_12];
    } else {
      var_6 = var_3;
    }

    if(isDefined(var_2)) {
      if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var_2)) {
        var_8 = undefined;
      } else if(isDefined(level.pap_1_camo) && var_0.pap[var_2].lvl == 1) {
        var_8 = level.pap_1_camo;
      } else if(isDefined(level.pap_2_camo) && var_0.pap[var_2].lvl == 2) {
        var_8 = level.pap_2_camo;
      }

      var_13 = var_0 scripts\cp\cp_weapon::get_weapon_level(var_3);
    }

    var_14 = 0;
    var_15 = undefined;
    if(isDefined(var_2)) {
      if(isDefined(var_0.pap[var_2])) {
        var_15 = "pap" + var_0.pap[var_2].lvl;
      } else {
        var_15 = "pap1";
      }
    }

    if(isDefined(var_15) && var_15 == "replace_me") {
      var_15 = undefined;
    }

    var_16 = getweaponattachments(var_6);
    var_17 = scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_6, var_15, var_16, undefined, var_8);
    var_17 = scripts\cp\utility::_giveweapon(var_17, undefined, undefined, 1);
    self.pap2_card_weapon = var_17;
    var_0.itempicked = var_17;
    var_0 scripts\cp\utility::take_fists_weapon(self);
    var_0 notify("weapon_purchased");
    var_0.pap[var_2].lvl = 3;
    var_0 givemaxammo(var_17);
    var_0 notify("weapon_level_changed");
    var_0 switchtoweapon(var_17);
    while(var_0 isswitchingweapon()) {
      wait(0.05);
    }
  } else {
    var_0.purchasing_ammo = 1;
    var_12 = undefined;
    var_18 = var_0 getweaponslistall();
    var_19 = var_0 getcurrentweapon();
    var_1A = scripts\cp\utility::getrawbaseweaponname(var_3);
    var_1B = undefined;
    foreach(var_3 in var_18) {
      var_12 = scripts\cp\utility::getrawbaseweaponname(var_3);
      if(var_12 == var_1A) {
        var_1B = var_3;
        break;
      }
    }

    var_1E = weaponmaxammo(var_1B);
    var_1F = var_0 scripts\cp\perks\prestige::prestige_getminammo();
    var_20 = int(var_1F * var_1E);
    var_21 = var_0 getweaponammostock(var_1B);
    if(var_21 < var_20) {
      var_0 setweaponammostock(var_1B, var_20);
    }
  }

  wait(0.05);
  var_0 notify("weapon_purchased");
  var_0.purchasing_ammo = undefined;
}

can_upgrade_via_pap2fnfcard(var_0, var_1) {
  var_2 = self getweaponslistall();
  foreach(var_4 in var_2) {
    var_5 = scripts\cp\utility::getrawbaseweaponname(var_0);
    var_6 = scripts\cp\utility::getrawbaseweaponname(var_4);
    if(var_5 == var_6) {
      return 0;
    }
  }

  if(scripts\cp\utility::weapon_is_dlc_melee(var_0) || scripts\cp\utility::weapon_is_dlc2_melee(var_0) || issubstr(var_0, "knife") || issubstr(var_0, "slasher") || issubstr(var_0, "axe") || issubstr(var_0, "lawnmower") || issubstr(var_0, "harpoon")) {
    return 0;
  }

  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_0)])) {
    return 0;
  }

  if(issubstr(var_0, "forgefreeze") || issubstr(var_0, "cutie") || issubstr(var_0, "nunchucks") || issubstr(var_0, "katana") || issubstr(var_0, "headcutter") || issubstr(var_0, "dischord") || issubstr(var_0, "facemelter") || issubstr(var_0, "shredder")) {
    return 0;
  }

  if(!isDefined(level.pap)) {
    return 0;
  }

  if(isDefined(var_0)) {
    var_5 = scripts\cp\utility::getrawbaseweaponname(var_0);
  } else {
    return 0;
  }

  if(!isDefined(var_5)) {
    return 0;
  }

  if(!isDefined(level.pap[var_5])) {
    var_4 = getsubstr(var_5, 0, var_5.size - 1);
    if(!isDefined(level.pap[var_4])) {
      return 0;
    }
  }

  if(isDefined(self.pap[var_5]) && self.pap[var_5].lvl >= 3) {
    return 0;
  } else {
    return 1;
  }

  if(scripts\engine\utility::istrue(var_1) && isDefined(self.pap[var_5]) && self.pap[var_5].lvl <= min(level.pap_max + 1, 2)) {
    return 1;
  }

  return 1;
}

use_self_revive(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  scripts\cp\cp_laststand::enable_self_revive(self);
  thread removeselfreviveonearlyexit(var_0);
  for(;;) {
    self waittill("player_has_self_revive", var_1);
    if(var_1) {
      continue;
    }

    self waittill("revive");
    self stoplocalsound("zmb_laststand_music");
    scripts\cp\cp_laststand::disable_self_revive(self);
    if(scripts\cp\utility::has_zombie_perk("perk_machine_tough")) {
      self.maxhealth = 200;
      self.health = self.maxhealth;
    }

    scripts\cp\utility::notify_used_consumable(var_0);
    break;
  }
}

removeselfreviveonearlyexit(var_0) {
  self endon(var_0 + " activated");
  self endon("disconnect");
  level endon("game_ended");
  self waittill(var_0 + "_exited_early");
  scripts\cp\cp_laststand::disable_self_revive(self);
}

use_welfare(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 = scripts\cp\cp_persistence::get_player_currency();
  var_2 = int(var_1 / level.players.size);
  scripts\cp\cp_persistence::set_player_currency(var_2);
  foreach(var_4 in level.players) {
    if(var_4 == self) {
      continue;
    }

    var_4 scripts\cp\cp_persistence::give_player_currency(var_2, undefined, undefined, 1, "bonus");
  }

  scripts\cp\utility::notify_used_consumable(var_0);
  return 1;
}

use_increased_team_efficiency(var_0) {
  self endon(var_0 + "_timeup");
  self endon("disconnect");
  if(!isDefined(level.consumable_cash_scalar)) {
    level.consumable_cash_scalar = 0;
  }

  thread update_team_multiplier(var_0);
  thread cleanupaftertimeoutordeath(var_0);
  setomnvar("zom_escape_combo_multiplier", 1);
  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_return("shot_missed", "weapon_hit_enemy");
    if(var_1 == "shot_missed") {
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

update_team_multiplier(var_0) {
  self endon(var_0 + "_timeup");
  self endon("disconnect");
  while(isDefined(level.consumable_cash_scalar)) {
    self waittill("update_team_efficiency");
    var_1 = 1 + level.consumable_cash_scalar;
    setomnvar("zom_escape_combo_multiplier", var_1);
  }

  setomnvar("zom_escape_combo_multiplier", -1);
}

cleanupaftertimeoutordeath(var_0) {
  var_1 = scripts\engine\utility::waittill_any_return(var_0 + "_timeup", var_0 + "_exited_early", "disconnect");
  level.consumable_cash_scalar = undefined;
}

use_slow_enemy_movement(var_0) {
  self endon(var_0 + "_timeup");
  self endon("disconnect");
  thread removeslowmoveonlaststand(var_0);
  foreach(var_2 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    var_2 thread adjustmovespeed(var_2, var_0, self);
  }

  for(;;) {
    level waittill("agent_spawned", var_4);
    var_4 thread adjustmovespeed(var_4, var_0, self, 1);
  }
}

adjustmovespeed(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  if(isDefined(var_0.agent_type) && var_0.agent_type == "zombie_brute" || var_0.agent_type == "zombie_grey" || var_0.agent_type == "zombie_ghost") {
    return;
  }

  if(isDefined(var_0.agent_type) && var_0.agent_type == "crab_brute" || var_0.agent_type == "crab_mini") {
    return;
  }

  if(var_0 scripts\cp\utility::agentisfnfimmune()) {
    return;
  }

  if(scripts\engine\utility::istrue(var_0.is_suicide_bomber)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_3)) {
    wait(0.5);
  }

  if(!isDefined(var_0.asm.cur_move_mode)) {
    var_4 = var_0.synctransients;
  } else {
    var_4 = var_1.asm.cur_move_mode;
  }

  switch (var_4) {
    case "slow_walk":
      break;

    case "walk":
    case "sprint":
    case "run":
      var_0 scripts\asm\asm_bb::bb_requestmovetype("slow_walk");
      break;
  }

  var_2 scripts\engine\utility::waittill_any(var_1 + "_timeup", "last_stand", "disconnect");
  var_0 scripts\asm\asm_bb::bb_requestmovetype(var_4);
}

removeslowmoveonlaststand(var_0) {
  self endon(var_0 + "_timeup");
  self waittill("last_stand");
  self notify(var_0 + "_exited_early");
}

use_life_link(var_0) {
  self endon(var_0 + "_timeup");
  self endon("last_stand");
  self endon("disconnect");
  level endon("game_ended");
  self.life_link_active = undefined;
  self.life_linked = 1;
  var_1 = "j_spine4";
  thread removedamagemodifierontimeout(var_0);
  thread removedamagemodifieronlaststand(var_0);
  var_2 = self;
  for(;;) {
    var_3 = getlifelinktarget(self);
    if(isDefined(var_3)) {
      self notify("lost_target", var_3);
      self.linked_to_player = 1;
      thread playlifelinkfx(var_3, var_1, var_0);
      var_2.life_link_active = 1;
      linktoplayer(self, var_3);
      continue;
    }

    var_2.life_link_active = undefined;
    wait(0.5);
  }
}

getlifelinktarget(var_0) {
  var_1 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.players, [var_0], 4, 512);
  var_2 = sortbydistance(var_1, var_0.origin);
  var_3 = undefined;
  foreach(var_5 in var_2) {
    var_6 = sighttracepassed(var_0 getEye(), var_5 getEye(), 0, var_0);
    if(!var_6) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_5.inlaststand)) {
      continue;
    }

    var_3 = var_5;
    break;
  }

  return var_3;
}

linktoplayer(var_0, var_1) {
  var_0 endon("disconnect");
  while(scripts\engine\utility::istrue(var_0.linked_to_player)) {
    if(scripts\engine\utility::istrue(var_1.inlaststand)) {
      var_0.linked_to_player = undefined;
      var_0 notify("lost_target");
      break;
    } else if(distance(var_0.origin, var_1.origin) > 512) {
      var_0.linked_to_player = undefined;
      var_0 notify("lost_target");
      break;
    } else {
      var_2 = sighttracepassed(var_0 getEye(), var_1 getEye(), 0, var_0);
      if(!var_2) {
        var_0.linked_to_player = undefined;
        var_0 notify("lost_target");
      }
    }

    wait(0.25);
  }
}

playlifelinkfx(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  self endon("disconnect");
  var_3 = [];
  playFXOnTag(level._effect["life_link_target"], var_0, var_1);
  foreach(var_5 in level.players) {
    var_3[var_3.size] = playfxontagsbetweenclients(level._effect["life_link"], self, var_1, var_0, var_1, var_5);
  }

  self playLoopSound("zmb_fnf_lifelink_heal_lp");
  var_0 playLoopSound("zmb_fnf_lifelink_heal_lp");
  var_7 = scripts\cp\utility::waittill_any_ents_return(self, "disconnect", self, "lost_target", self, "last_stand", self, var_2 + "_timeup", var_0, "disconnect", var_0, "last_stand", level, "game_ended");
  if(isDefined(self)) {
    self stoploopsound();
  }

  if(isDefined(var_0)) {
    var_0 stoploopsound();
  }

  foreach(var_9 in var_3) {
    if(isDefined(var_9)) {
      var_9 delete();
    }
  }

  if(isDefined(var_0)) {
    killfxontag(level._effect["life_link_target"], var_0, var_1);
  }
}

removedamagemodifieronlaststand(var_0) {
  self endon(var_0 + "_timeup");
  self waittill("last_stand");
  self.life_linked = undefined;
  self.life_link_active = undefined;
  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
  }

  self notify(var_0 + "_exited_early");
}

removedamagemodifierontimeout(var_0) {
  self endon("last_stand");
  self waittill(var_0 + "_timeup");
  self.life_linked = undefined;
  self.life_link_active = undefined;
  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
  }
}

use_phoenix_up(var_0) {
  var_1 = level.players;
  var_2 = 0;
  foreach(var_4 in var_1) {
    var_5 = var_4;
    if(isDefined(var_4.owner)) {
      var_5 = var_4.owner;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_5)) {
      var_2 = 1;
      if(scripts\engine\utility::istrue(var_5.kill_trigger_event_processed)) {
        thread delayed_instant_revive(var_5);
        continue;
      }

      scripts\cp\cp_laststand::instant_revive(var_5);
      scripts\cp\cp_laststand::record_revive_success(self, var_5);
    }
  }

  if(!var_2) {
    self.consumables["phoenix_up"].on = 0;
    scripts\engine\utility::waitframe();
    return 0;
  }

  wait(0.25);
  scripts\cp\utility::notify_used_consumable("phoenix_up");
  return 1;
}

delayed_instant_revive(var_0) {
  var_0 endon("disconnect");
  var_0 endon("revive");
  wait(4);
  scripts\cp\cp_laststand::instant_revive(var_0);
  scripts\cp\cp_laststand::record_revive_success(self, var_0);
}

use_killing_time(var_0) {
  level endon("game_ended");
  if(isDefined(level.meph_fight_started)) {
    return 0;
  }

  foreach(var_2 in level.players) {
    if(!isDefined(var_2.killing_time)) {
      var_2.killing_time = 0;
    }

    var_2.killing_time++;
  }

  scripts\engine\utility::waitframe();
  scripts\cp\utility::notify_used_consumable("killing_time");
  scripts\engine\utility::waittill_any_timeout(20, "death", "last_stand", "disconnect");
  foreach(var_2 in level.players) {
    if(isDefined(var_2.killing_time)) {
      var_2.killing_time--;
      if(var_2.killing_time <= 0) {
        var_2.killing_time = undefined;
      }
    }
  }
}

use_now_you_see_me(var_0) {
  level endon("game_ended");
  self endon("last_stand");
  self endon("disconnect");
  thread removenowyouseemeonlaststand(var_0);
  foreach(var_2 in level.players) {
    if(var_2 == self) {
      if(var_2 scripts\cp\utility::isignoremeenabled()) {
        var_2 scripts\cp\utility::allow_player_ignore_me(0);
      }

      continue;
    }

    var_2 scripts\cp\utility::allow_player_ignore_me(1);
  }

  wait(10);
  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::isignoremeenabled()) {
      var_2 scripts\cp\utility::allow_player_ignore_me(0);
    }
  }
}

removenowyouseemeonlaststand(var_0) {
  var_1 = scripts\engine\utility::waittill_any_return("last_stand", "disconnect", var_0 + "_timeup", var_0 + "_exited_early");
  foreach(var_3 in level.players) {
    if(var_3 scripts\cp\utility::isignoremeenabled()) {
      var_3 scripts\cp\utility::allow_player_ignore_me(0);
    }
  }

  if(isDefined(var_1) && var_1 == "last_stand") {
    self notify(var_0 + "_exited_early");
  }
}

use_anywhere_but_here(var_0) {
  if(!scripts\cp\utility::isteleportenabled() || scripts\engine\utility::istrue(self.is_in_pap)) {
    self.consumables["anywhere_but_here"].on = 0;
    return 0;
  }

  if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight()) {
    self.consumables["anywhere_but_here"].on = 0;
    return 0;
  }

  var_1 = level.active_player_respawn_locs;
  var_1 = scripts\engine\utility::array_remove_duplicates(var_1);
  foreach(var_3 in level.active_player_respawn_locs) {
    var_4 = scripts\cp\zombies\zombies_spawning::get_spawn_volumes_player_is_in(0, 1, self);
    foreach(var_6 in var_4) {
      if(ispointinvolume(var_3.origin, var_6)) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_3);
      }
    }
  }

  if(var_1.size < 1) {
    var_1 = level.active_player_respawn_locs;
  }

  var_9 = scripts\cp\gametypes\zombie::get_respawn_loc_rated(level.players, var_1);
  if(!isDefined(var_9)) {
    self.consumables["anywhere_but_here"].on = 0;
    return 0;
  }

  if(scripts\cp\utility::map_check(4)) {
    var_10 = scripts\cp\zombies\zombies_spawning::get_spawn_volumes_player_is_in(0, 1, self);
    foreach(var_12 in var_10) {
      if(isDefined(level.facilityvolumes) && scripts\engine\utility::array_contains(level.facilityvolumes, var_12.basename)) {
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
  self setorigin(var_9.origin);
  self setplayerangles(var_9.angles);
  self notify("left_hidden_room_early");
  scripts\cp\utility::notify_used_consumable("anywhere_but_here");
  self.abh_used = gettime();
  return 1;
}

jumptoanywherebutherespawns(var_0) {
  level endon("game_ended");
  level.players[0] endon("death");
  level.players[0] endon("last_stand");
  foreach(var_2 in level.active_player_respawn_locs) {
    level.players[0] scripts\cp\powers\coop_phaseshift::doscreenflash();
    level.players[0] scripts\cp\cp_interaction::refresh_interaction();
    level.players[0] scripts\cp\powers\coop_powers::power_enablepower();
    level.players[0] getrigindexfromarchetyperef();
    level.players[0] setorigin(var_2.origin);
    level.players[0] setplayerangles(var_2.angles);
    wait(2);
  }
}

use_headshot_reload(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  self.headshot_reload_time = gettime();
}

headshot_reload_check(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!scripts\cp\utility::is_consumable_active("headshot_reload")) {
    return 0;
  }

  if(!scripts\engine\utility::isbulletdamage(var_3)) {
    return 0;
  }

  if(!scripts\cp\utility::isheadshot(var_4, var_6, var_3, var_1)) {
    return 0;
  }

  if(isDefined(var_9) && var_9 scripts\cp\utility::agentisfnfimmune()) {
    return 0;
  }

  var_4 = self getcurrentweapon();
  var_10 = self getweaponammostock(var_4);
  var_11 = weaponclipsize(var_4);
  var_12 = self getweaponammoclip(var_4);
  var_13 = var_11 - var_12;
  if(var_10 >= var_13) {
    self setweaponammostock(var_4, var_10 - var_13);
  } else {
    var_11 = var_10;
    self setweaponammostock(var_4, 0);
  }

  var_14 = var_11;
  var_15 = min(var_12 + var_14, var_11);
  self setweaponammoclip(var_4, int(var_15));
  if(self isdualwielding()) {
    var_12 = self getweaponammoclip(var_4, "left");
    var_15 = min(var_12 + var_14, var_11);
    self setweaponammoclip(var_4, int(var_15), "left");
  }
}

use_grenade_cooldown(var_0) {
  self.power_cooldowns = 1;
  scripts\cp\powers\coop_powers::power_adjustcharges(1, "primary");
  var_1 = getarraykeys(self.powers);
  foreach(var_3 in var_1) {
    self.powers[var_3].cooldownratemod = 1;
  }
}

turn_off_grenade_cooldown(var_0) {
  self.power_cooldowns = 0;
}

write_consumable_used(var_0, var_1) {
  if(!isDefined(var_0.consumables)) {
    return;
  }

  var_2 = 0;
  foreach(var_6, var_4 in var_0.consumables_pre_irish_luck_usage) {
    var_5 = get_consumable_loot_id(var_6);
    setclientmatchdata("player", var_1, "cardsUsed", var_2, "loot_ID", int(var_5));
    setclientmatchdata("player", var_1, "cardsUsed", var_2, "num_of_times_used", var_4.times_used);
    var_2++;
  }
}

get_consumable_loot_id(var_0) {
  return tablelookup("cp\loot\iw7_zombiefatefortune_loot_master.csv", 1, var_0, 0);
}

set_consumable(var_0) {
  return self[[level.consumables[var_0].set]](var_0);
}

unset_consumable(var_0) {
  self[[level.consumables[var_0].unset]](var_0);
}