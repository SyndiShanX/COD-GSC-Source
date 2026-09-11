/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\zombies\cp_consumables.gsc
*************************************************/

function init_consumables() {
  level.consumables = [];
  setup_irish_luck_consumables();
  parse_consumables_table();
}

function setup_irish_luck_consumables() {
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
  level.irish_luck_consumables_gotten = [];
}

function parse_consumables_table() {
  if(isDefined(level.consumable_table)) {
    var_0 = level.consumable_table;
  } else {
    var_0 = "cp/loot/iw7_zombiefatefortune_loot_master.csv";
  }

  for(var_1 = 0;; var_1++) {
    var_2 = tablelookupbyrow(var_0, var_1, 1);

    if(var_2 == "") {
      break;
    }

    var_3 = tablelookupbyrow(var_0, var_1, 6);
    var_4 = int(tablelookupbyrow(var_0, var_1, 7));
    var_5 = int(tablelookupbyrow(var_0, var_1, 8));
    var_6 = int(tablelookupbyrow(var_0, var_1, 9));
    register_consumable(var_2, var_3, var_4, var_5, var_6, &give_consumable, &remove_consumable);
  }

  consumable_setup_functions("ephemeral_enhancement", &use_ephemeral_enhancement, undefined, undefined, 1);
  consumable_setup_functions("grenade_cooldown", &use_grenade_cooldown, undefined, &turn_off_grenade_cooldown, undefined);
  consumable_setup_functions("reload_damage_increase", &use_reload_damage_increase, undefined, undefined, undefined);
  consumable_setup_functions("headshot_reload", &use_headshot_reload, undefined, undefined, undefined);
  consumable_setup_functions("anywhere_but_here", &use_anywhere_but_here, undefined, undefined, undefined);
  consumable_setup_functions("now_you_see_me", &use_now_you_see_me, undefined, undefined, undefined);
  consumable_setup_functions("killing_time", &use_killing_time, undefined, undefined, undefined);
  consumable_setup_functions("phoenix_up", &use_phoenix_up, undefined, undefined, 1);
  consumable_setup_functions("spawn_instakill", &use_spawn_instakill, undefined, undefined, 1);
  consumable_setup_functions("spawn_fire_sale", &use_spawn_fire_sale, undefined, undefined, 1);
  consumable_setup_functions("spawn_nuke", &use_spawn_nuke, undefined, undefined, 1);
  consumable_setup_functions("spawn_double_money", &use_spawn_double_money, undefined, undefined, 1);
  consumable_setup_functions("spawn_max_ammo", &use_spawn_max_ammo, undefined, undefined, 1);
  consumable_setup_functions("spawn_reboard_windows", &use_spawn_reboard_windows, undefined, undefined, 1);
  consumable_setup_functions("spawn_infinite_ammo", &use_spawn_infinite_ammo, undefined, undefined, 1);
  consumable_setup_functions("bh_gun", &use_bh_gun, undefined, undefined, 1);
  consumable_setup_functions("atomizer_gun", &use_atomizer_gun, undefined, undefined, 1);
  consumable_setup_functions("claw_gun", &use_claw_gun, undefined, undefined, 1);
  consumable_setup_functions("steel_dragon", &use_steel_dragon, undefined, undefined, 1);
  consumable_setup_functions("penetration_gun", &use_penetration_gun, undefined, undefined, 1);
  consumable_setup_functions("life_link", &use_life_link, undefined, undefined, undefined);
  consumable_setup_functions("slow_enemy_movement", &use_slow_enemy_movement, undefined, undefined, undefined);
  consumable_setup_functions("increased_team_efficiency", &use_increased_team_efficiency, undefined, undefined, undefined);
  consumable_setup_functions("welfare", &use_welfare, undefined, undefined, undefined);
  consumable_setup_functions("cant_miss", &use_cant_miss, undefined, undefined, undefined);
  consumable_setup_functions("self_revive", &use_self_revive, undefined, undefined, undefined);
  consumable_setup_functions("force_push_near_death", &use_force_push_near_death, undefined, undefined, undefined);
  consumable_setup_functions("masochist", &use_masochist, undefined, undefined, undefined);
  consumable_setup_functions("timely_torrent", &use_timely_torrent, undefined, undefined, 1);
  consumable_setup_functions("purify", &use_purify, undefined, undefined, undefined);
  consumable_setup_functions("explosive_touch", &use_explosive_touch, undefined, undefined, undefined);
  consumable_setup_functions("shared_fate", &use_shared_fate, undefined, undefined, undefined);
  consumable_setup_functions("fire_chains", &use_fire_chains, undefined, undefined, undefined);
  consumable_setup_functions("irish_luck", &use_irish_luck, undefined, undefined, undefined);
  consumable_setup_functions("temporal_increase", &use_temporal_increase, undefined, undefined, undefined);
  consumable_setup_functions("twist_of_fate", &use_twister, undefined, undefined, undefined);
}

function register_consumable(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.type = var_1;
  var_7.uses = var_2;
  var_7.usageperiod = var_3;
  var_7.passiveuses = var_4;
  var_7.set = var_5;
  var_7.unset = var_6;
  var_7.timeupnotify = var_0 + "_timeup";
  level.consumables[var_0] = var_7;

  foreach(var_9 in level.irish_luck_consumables) {
    if(var_10 == var_0) {
      level.irish_luck_consumables[var_0] = level.consumables[var_0];
      level.irish_luck_consumables[var_0].name = var_0;
    }
  }
}

function consumable_setup_functions(var_0, var_1, var_2, var_3, var_4) {
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
    return;
  }
}

function init_player_consumables() {}

function init_consumable_meter() {
  thread meter_fill_up();
}

function init_consumables_used() {
  self.consumables_used = [];
  self setplayerdata("common", "numConsumables", 0);

  for(var_0 = 0; var_0 < 32; var_0++) {
    self setplayerdata("common", "consumablesUsed", var_0, 0);
  }
}

function set_player_consumables() {
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

function turn_on_cards(var_0) {
  var_1 = get_card_deck_size(self);
  self.slot_array = [];
  self playlocalsound("zmb_fnf_replenish");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self.slot_array[self.slot_array.size] = var_2;
    self setclientomnvarbit("zm_card_selection_count", var_2, 1);
  }

  update_lua_consumable_slot(0);
}

function reset_meter() {
  self notify("give_new_deck");
  self.consumable_meter = 0;
  init_consumable_meter();
  thread lightbar_off();
}

function get_card_deck_size(var_0) {
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

function setup_dpad_slots() {
  self setactionslot(1, "");
  self setactionslot(2, "");
  self setactionslot(3, "");
  self setactionslot(4, "");
  self notifyonplayercommand("D_pad_up", "+actionslot 1");
  self notifyonplayercommand("D_pad_down", "+actionslot 2");
  thread watch_for_super_button("super_default_zm");
}

function watch_for_super_button(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("offhand_fired", var_1);
    var_2 = createheadicon(var_1);

    if(var_2 == var_0) {
      if(istrue(self.inlaststand)) {
        self setweaponammoclip(var_0, 1);
        continue;
      }

      self notify("fired_super");
      self setweaponammoclip(var_0, 1);
    }
  }
}

function dpad_consumable_selection_watch() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("consumable_selected");
  self endon("give_new_deck");
  var_0 = 0;
  update_lua_consumable_slot(var_0);
  self.deck_select_ready = 1;

  for(;;) {
    var_1 = scripts\engine\utility::ref_143ae("D_pad_up", "D_pad_down", "fired_super");

    if(self.slot_array.size <= 0 || istrue(self.disable_consumables) || istrue(self.spectating) || istrue(self.inlaststand)) {
      self playlocalsound("ui_consumable_deny");
      wait 0.25;
      continue;
    }

    if(var_1 == "fired_super") {
      self.deck_select_ready = undefined;
      thread consumable_activate(self.slot_array[var_0], var_0);
    } else if(var_1 == "D_pad_up" && self.slot_array.size > 1) {
      var_0 = get_selection_index_loop_around(var_0 + 1, 0, self.slot_array.size - 1);
      update_lua_consumable_slot(var_0);
      self playlocalsound("ui_consumable_scroll");
    } else if(var_1 == "D_pad_down" && self.slot_array.size > 1) {
      var_0 = get_selection_index_loop_around(var_0 - 1, 0, self.slot_array.size - 1);
      update_lua_consumable_slot(var_0);
      self playlocalsound("ui_consumable_scroll");
    }

    waitframe();
  }
}

function update_lua_consumable_slot(var_0) {
  wait 0.1;
}

function get_selection_index_loop_around(var_0, var_1, var_2) {
  if(var_0 > var_2) {
    return var_1;
  }

  if(var_0 < var_1) {
    return var_2;
  }

  return var_0;
}

function remove_card_from_use(var_0) {
  self.slot_array = scripts\engine\utility::array_remove(self.slot_array, self.slot_array[var_0]);
}

function consumable_activate(var_0, var_1) {
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

function consumable_activate_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
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
      scripts\cp\cp_merits::processmerit("mt_faf_uses");
      thread scripts\cp\cp_vo::try_to_play_vo("wonder_consume", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);

      if(self.consumables[var_0].times_used == 1) {
        thread decrement_counter_of_consumables(var_0);
      }

      self setclientomnvar(var_1, 1);
      thread lightbar_off();
      self setclientomnvarbit("zm_card_fill_display", var_5, 1);
      remove_card_from_use(var_6);
      thread meter_fill_up();
      self playlocalsound("ui_consumable_select");
      play_consumable_activate_sound(self);
      self notify("consumable_selected");
      thread scripts\cp\utility::firegesturegrenade(self, self.fate_card_weapon);
      self.consumable_meter_full = undefined;
      level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_use_fateandfort");
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
    return;
  }
}

function decrement_counter_of_consumables(var_0) {
  var_1 = get_consumable_index_in_player_data(self, var_0);

  if(isDefined(var_1)) {
    var_2 = self getplayerdata("cp", "zombiePlayerLoadout", "consumables_counter", var_1);
    var_3 = var_2 - 1;
    self setplayerdata("cp", "zombiePlayerLoadout", "consumables_counter", var_1, var_3);
    return;
  }
}

function play_consumable_activate_sound(var_0) {
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
    default:
      var_0 playlocalsound("wondercard_jock_use_gesture");
      break;
  }
}

function consume_from_inventory(var_0, var_1) {
  var_2 = get_consumable_loot_id(var_1);

  if(scripts\engine\utility::array_contains(var_0.consumables_used, var_2)) {
    return;
  }

  var_3 = var_0.consumables_used.size;

  if(isDefined(level.consumable_table)) {
    var_4 = level.consumable_table;
  } else {
    var_4 = "cp/loot/iw7_zombiefatefortune_loot_master.csv";
  }

  var_5 = tablelookup(var_4, 1, var_2, 3);

  if(isDefined(var_5)) {
    if(var_5 == "Fortune") {
      var_1 setplayerdata("common", "consumablesUsed", var_4, int(var_3));
      var_6 = var_1 getplayerdata("common", "numConsumables");
      var_1 setplayerdata("common", "numConsumables", var_6 + 1);
      var_1.consumables_used = scripts\engine\utility::array_add(var_1.consumables_used, var_3);
      return;
    }

    return;
  }
}

function get_consumable_index_in_player_data(var_0, var_1) {
  for(var_2 = 0; var_2 < 5; var_2++) {
    var_3 = var_0 getplayerdata("cp", "zombiePlayerLoadout", "zombie_consumables", var_2);

    if(var_1 == var_3) {
      return var_2;
    }
  }

  return undefined;
}

function lightbar_on() {
  self setclientomnvar("lb_gsc_controlled", 1);
  self setclientomnvar("lb_color", 0);
  self setclientomnvar("lb_pulse_time", 1);
}

function lightbar_off() {
  self setclientomnvar("lb_gsc_controlled", 0);
}

function dpad_drain_time(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  level endon("game_ended");
  thread watchforearlyexit(var_0, var_4, var_2, var_5, var_6, var_7);
  var_8 = 1;
  var_9 = var_8 / var_1;
  wait getcharactercardgesturelength();

  for(;;) {
    if(!istrue(self.spectating) && !istrue(self.inlaststand)) {
      self setclientomnvar(var_2, var_8);
      var_8 -= var_9;

      if(var_8 <= 0) {
        self setclientomnvar(var_2, 0);
        disable_consumable(var_0, var_4, var_2, var_5, var_6, var_7);
        break;
      }
    }

    wait 1;
  }
}

function dpad_drain_wave(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  thread watchforearlyexit(var_0, var_4, var_2, var_5, var_6, var_7);
  var_8 = 1;
  var_9 = var_8 / var_1;

  for(;;) {
    self setclientomnvar(var_2, var_8);
    level waittill("spawn_wave_done");
    var_8 -= var_9;

    if(var_8 <= 0) {
      self setclientomnvar(var_2, 0);
      disable_consumable(var_0, var_4, var_2, var_5, var_6, var_7);
      break;
    }

    wait 1;
  }
}

function dpad_drain_activations(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  thread watchforearlyexit(var_0, var_5, var_3, var_6, var_7, var_8);
  var_9 = self.consumables[var_0].usednotify;
  var_10 = 1;

  if(var_1 == "triggerwait") {
    self waittill(var_9);
  }

  wait 1;

  for(;;) {
    if(!istrue(self.spectating) && !istrue(self.inlaststand)) {
      var_10 -= 0.05;
      self setclientomnvar(var_3, var_10);

      if(var_10 <= 0) {
        self setclientomnvar(var_3, 0);
        disable_consumable(var_0, var_5, var_3, var_6, var_7, var_8);
        break;
      }
    }

    wait 0.05;
  }
}

function dpad_drain_triggerpassive(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  thread watchforearlyexit(var_0, var_4, var_2, var_5, var_6, var_7);
  var_8 = 1 / var_1;
  var_9 = self.consumables[var_0].usednotify;
  var_10 = 1;

  for(;;) {
    self waittill(var_9);

    if(!istrue(self.spectating) && !istrue(self.inlaststand) || var_0 == "coagulant") {
      var_10 -= var_8;
      self setclientomnvar(var_2, var_10);

      if(var_10 < 0.0001) {
        self setclientomnvar(var_2, 0);
        disable_consumable(var_0, var_4, var_2, var_5, var_6, var_7);
        break;
      }
    }
  }
}

function getcharactercardgesturelength() {
  if(scripts\cp\utility::map_check(0)) {
    switch (self.vo_prefix) {
      case "p1_":
        return self getgestureanimlength("ges_wondercard_valley_girl");
      case "p2_":
        return self getgestureanimlength("ges_wondercard_nerd");
      case "p3_":
        return self getgestureanimlength("ges_wondercard_rapper");
      case "p4_":
        return self getgestureanimlength("ges_wondercard_jock");
      default:
        return 2;
    }

    return;
  }

  if(scripts\cp\utility::map_check(1)) {
    switch (self.vo_prefix) {
      case "p1_":
        return self getgestureanimlength("ges_wondercard_chola");
      case "p2_":
        return self getgestureanimlength("ges_wondercard_raver");
      case "p3_":
        return self getgestureanimlength("ges_wondercard_grunge");
      case "p4_":
        return self getgestureanimlength("ges_wondercard_hiphop");
      default:
        return 2;
    }

    return;
  }

  switch (self.vo_prefix) {
    case "p1_":
      return self getgestureanimlength("ges_wondercard_valley_girl");
    case "p2_":
      return self getgestureanimlength("ges_wondercard_nerd");
    case "p3_":
      return self getgestureanimlength("ges_wondercard_rapper");
    case "p4_":
      return self getgestureanimlength("ges_wondercard_jock");
    default:
      return 2;
  }
}

function watchforearlyexit(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("dpad_end_" + var_0);
  self waittill(var_0 + "_exited_early");
  self setclientomnvar(var_2, 0);
  thread disable_consumable(var_0, var_1, var_2, var_3, var_4, var_5);
}

function meter_fill_up() {
  self notify("starting_meter_fill");
  self endon("starting_meter_fill");
  self endon("disconnect");
  level endon("game_ended");

  if(self.slot_array.size == 0) {
    thread scripts\cp\cp_vo::add_to_nag_vo("nag_need_fateandfort", "zmb_comment_vo", 60, 300, 6, 1);
    thread scripts\cp\cp_vo::remove_from_nag_vo("nag_use_fateandfort");
    return;
  }

  self.consumable_meter = 0;
  self.consumable_meter_max = get_max_meter();

  while(self.consumable_meter < self.consumable_meter_max) {
    self waittill("consumable_charge", var_0);

    if(istrue(self.disable_consumables)) {
      continue;
    }

    var_1 = self.consumable_meter_max - self.consumable_meter;

    if(var_0 > var_1) {
      var_0 = var_1;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      continue;
    }

    self.consumable_meter += var_0;
  }

  self notify("meter_full");
  thread scripts\cp\cp_vo::add_to_nag_vo("nag_use_fateandfort", "zmb_comment_vo", 60, 180, 6, 1);
  self playlocalsound("ui_consumable_meter_full");
  self setweaponammoclip("super_default_zm", 1);
  thread lightbar_on();
  self.consumable_meter_full = 1;
  thread dpad_consumable_selection_watch();

  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    thread scripts\cp\cp_hud_message::wait_and_play_tutorial_message("cards", 5);
    return;
  }
}

function get_max_meter() {
  var_0 = 1250;

  if(self.card_refills == 1) {
    var_0 = 3000;
  } else if(self.card_refills == 2) {
    var_0 = 5000;
  }

  return var_0;
}

function disable_consumable(var_0, var_1, var_2, var_3, var_4, var_5) {
  turn_off_consumable(var_0, var_3);
  self.consumables[var_0].uses -= 1;
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

function turn_off_consumable(var_0, var_1) {
  self.consumables[var_0].on = 0;
  scripts\cp\utility::notify_timeup_consumable(var_0);
  thread unset_consumable(var_0);
}

function give_consumable(var_0, var_1) {
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

function remove_consumable(var_0) {
  if(isDefined(self.consumables[var_0])) {
    self.consumables[var_0].on = 0;
    return;
  }
}

function use_reload_damage_increase(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self.reload_damage_increase = undefined;

  for(;;) {
    self waittill("reload");
    self.reload_damage_increase = 1;
    wait 5;
    self.reload_damage_increase = undefined;
  }
}

function use_ephemeral_enhancement(var_0) {
  if(istrue(self.isusingsupercard)) {
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

function fnf_upgrade_weapon(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_4 = undefined;
  var_0.isusingsupercard = 1;
  var_5 = "pap" + var_0.pap[var_2].lvl;
  var_6 = getweaponattachments(var_3);
  var_7 = 0;
  var_8 = var_3;

  if(issubstr(var_3.basename, "g18_z")) {
    foreach(var_10 in var_6) {
      if(issubstr(var_10, "akimbo")) {
        var_7 = 1;
        var_6 = scripts\engine\utility::array_remove(var_6, var_10);
      }
    }
  }

  var_12 = createheadicon(var_3);

  if(isDefined(level.custom_epehermal_attachment_func)) {
    var_13 = [[level.custom_epehermal_attachment_func]](var_0, var_2, var_12);

    if(isDefined(var_13)) {
      if(var_13 == "replace_me") {
        var_5 = undefined;
      } else {
        var_5 = var_13;
      }
    }
  }

  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var_3)])) {
    var_12 = level.weapon_upgrade_path[getweaponbasename(var_3)];
  } else if(isDefined(level.custom_epehermal_weapon_func)) {
    var_12 = [[level.custom_epehermal_weapon_func]](var_0, var_2, var_3);
  }

  var_3 = asmdevgetallstates(var_12);

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

      var_14 = var_0 scripts\cp\cp_weapon::get_weapon_level(var_3);

      switch (var_2) {
        case "dischord":
          var_15 = "iw7_dischord_zm_pap1";
          var_4 = "camo20";
          break;
        case "facemelter":
          var_15 = "iw7_facemelter_zm_pap1";
          var_4 = "camo22";
          break;
        case "headcutter":
          var_15 = "iw7_headcutter_zm_pap1";
          var_4 = "camo21";
          break;
        case "forgefreeze":
          if(var_14 == 2) {
            var_15 = "iw7_forgefreeze_zm_pap1";
          } else if(var_14 == 3) {
            var_15 = "iw7_forgefreeze_zm_pap2";
          }

          var_16 = 1;
          break;
        case "axe":
          if(var_14 == 2) {
            var_15 = "iw7_axe_zm_pap1";
          } else if(var_14 == 3) {
            var_15 = "iw7_axe_zm_pap2";
          }

          break;
        case "shredder":
          var_15 = "iw7_shredder_zm_pap1";
          var_4 = "camo23";
          break;
        case "nunchucks":
        case "katana":
          var_4 = "camo222";
          break;
      }
    }

    var_16 = 0;

    if(isDefined(var_2)) {
      switch (var_2) {
        case "spiked":
        case "golf":
        case "two":
        case "axe":
        case "machete":
          var_16 = 1;
        default:
          var_16 = 0;
          break;
      }
    } else {
      var_16 = 0;
    }

    var_5 = undefined;

    if(isDefined(var_2)) {
      switch (var_2) {
        case "spiked":
        case "golf":
        case "two":
        case "machete":
        case "nunchucks":
        case "katana":
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

    var_17 = getweaponattachments(var_3);

    if(issubstr(var_3.basename, "g18_z")) {
      foreach(var_10 in var_17) {
        if(issubstr(var_10, "akimbo")) {
          var_17 = scripts\engine\utility::array_remove(var_17, var_10);
        }
      }
    }
  }

  var_20 = var_0 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_3, var_5, var_6, undefined, var_4);
  var_21 = asmdevgetallstates(var_20);

  if(isDefined(var_21)) {
    var_0.pap[var_2].lvl++;
    var_0 notify("weapon_level_changed");
    var_0.ephemeralweapon = var_21 getbaseweapon();
    thread downgradeweaponaftertimeout(var_0, var_1, var_0, var_21);
    var_0 endon("last_stand");
    wait getcharactercardgesturelength();
    var_21 = var_0 scripts\cp\utility::_giveweapon(var_21, undefined, undefined, 1);

    if(isDefined(var_8)) {
      var_0 takeweapon(var_8);
    } else {
      var_0 takeweapon(var_3);
    }

    var_0 switchtoweapon(var_21);
    return;
  }
}

function downgradeweaponaftertimeout(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_4 = undefined;

  if(issameweapon(var_2)) {
    var_4 = var_2;
  } else {
    var_4 = asmdevgetallstates(var_2);
  }

  var_5 = var_1.ephemeralweapon;
  var_6 = 0;
  var_7 = scripts\cp\utility::getrawbaseweaponname(var_4);
  var_8 = "pap" + var_1.pap[var_7].lvl - 1;
  var_9 = var_1.pap[var_7].lvl - 2;

  switch (var_7) {
    case "katana":
      var_1.pap[var_7].lvl--;

      if(var_1.pap[var_7].lvl == 1) {
        var_1.base_weapon = 1;
        var_4 = getcompleteweaponname("iw7_katana_zm");
      } else {
        var_1.ephemeral_downgrade = 1;
        var_4 = getcompleteweaponname("iw7_katana_zm_pap1");
      }

      break;
    case "nunchucks":
      var_1.pap[var_7].lvl--;

      if(var_1.pap[var_7].lvl == 1) {
        var_1.base_weapon = 1;
        var_4 = getcompleteweaponname("iw7_nunchucks_zm");
      } else {
        var_1.ephemeral_downgrade = 1;
        var_4 = getcompleteweaponname("iw7_nunchucks_zm_pap1");
      }

      break;
    case "two":
      var_1.pap[var_7].lvl--;

      if(var_1.pap[var_7].lvl == 1) {
        var_1.base_weapon = 1;
        var_4 = getcompleteweaponname("iw7_two_headed_axe_mp");
      } else {
        var_1.ephemeral_downgrade = 1;
        var_4 = getcompleteweaponname("iw7_two_headed_axe_mp_pap1");
      }

      break;
    case "machete":
      var_1.pap[var_7].lvl--;

      if(var_1.pap[var_7].lvl == 1) {
        var_1.base_weapon = 1;
        var_4 = getcompleteweaponname("iw7_machete_mp");
      } else {
        var_1.ephemeral_downgrade = 1;
        var_4 = getcompleteweaponname("iw7_machete_mp_pap1");
      }

      break;
    case "golf":
      var_1.pap[var_7].lvl--;

      if(var_1.pap[var_7].lvl == 1) {
        var_1.base_weapon = 1;
        var_4 = getcompleteweaponname("iw7_golf_club_mp");
      } else {
        var_1.ephemeral_downgrade = 1;
        var_4 = getcompleteweaponname("iw7_golf_club_mp_pap1");
      }

      break;
    case "spiked":
      var_1.pap[var_7].lvl--;

      if(var_1.pap[var_7].lvl == 1) {
        var_1.base_weapon = 1;
        var_4 = getcompleteweaponname("iw7_spiked_bat_mp");
      } else {
        var_1.ephemeral_downgrade = 1;
        var_4 = getcompleteweaponname("iw7_spiked_bat_mp_pap1");
      }

      break;
  }

  var_4 = downgradeweapon(var_1, var_4, var_7, var_8, var_9, var_3);
  var_1.base_weapon = undefined;
  var_1.ephemeral_downgrade = undefined;
  var_10 = var_1 scripts\engine\utility::ref_143ad("ephemeral_enhancement_timeup", "last_stand");

  if(var_10 != "ephemeral_enhancement_timeup") {
    var_1 notify(var_0 + "_exited_early");
  }

  var_1.isusingsupercard = undefined;
  var_11 = var_1 scripts\cp\utility::getvalidtakeweapon();
  var_12 = scripts\cp\utility::getrawbaseweaponname(var_11);

  if(var_1 scripts\cp\cp_weapon::has_weapon_variation(var_5)) {
    var_13 = var_1 getweaponslistall();

    foreach(var_15 in var_13) {
      var_16 = scripts\cp\utility::getrawbaseweaponname(var_15);

      if(var_16 == scripts\cp\utility::getrawbaseweaponname(var_5)) {
        var_1 takeweapon(var_15);
        var_6 = 1;
        var_4 = var_1 scripts\cp\utility::_giveweapon(var_4, undefined, undefined, 1);

        if(scripts\cp\utility::getrawbaseweaponname(var_4) == var_12) {
          var_1 switchtoweaponimmediate(var_4);
        }

        var_1.pap[var_7].lvl = int(max(var_1.pap[var_7].lvl - 1, 1));
        var_1 notify("weapon_level_changed");
        break;
      }
    }
  }

  if(isDefined(var_1.copy_fullweaponlist)) {
    var_18 = var_1.copy_fullweaponlist;

    foreach(var_20 in var_18) {
      var_16 = var_20 getbaseweapon();

      if(var_16 == var_5) {
        var_21 = createheadicon(var_20);
        var_22 = var_1.copy_weapon_ammo_clip[var_21];
        var_23 = var_1.copy_weapon_ammo_stock[var_21];
        var_1.copy_fullweaponlist = scripts\engine\utility::array_remove(var_1.copy_fullweaponlist, var_20);
        var_24 = createheadicon(var_4);

        if(var_16 == var_1.copy_weapon_current getbaseweapon()) {
          var_1.copy_weapon_current = var_4;
        }

        var_1.copy_fullweaponlist = scripts\engine\utility::array_add(var_1.copy_fullweaponlist, var_24);
        var_1.copy_weapon_ammo_clip[var_24] = var_22;
        var_1.copy_weapon_ammo_stock[var_24] = var_23;
        break;
      }
    }
  }

  if(isDefined(var_1.last_stand_pistol)) {
    if(var_1.last_stand_pistol getbaseweapon() == var_1.ephemeralweapon) {
      var_1.last_stand_pistol = var_4;
    }
  }

  if(isDefined(var_1.saved_last_stand_pistol)) {
    if(var_1.saved_last_stand_pistol getbaseweapon() == var_1.ephemeralweapon) {
      var_1.saved_last_stand_pistol = var_4;
    }
  }

  if(isDefined(var_1.lost_and_found_ent)) {
    var_18 = var_1.lost_and_found_ent.copy_fullweaponlist;

    foreach(var_20 in var_18) {
      var_16 = var_20 getbaseweapon();

      if(var_16 == var_5) {
        var_21 = createheadicon(var_20);
        var_22 = var_1.copy_weapon_ammo_clip[var_21];
        var_23 = var_1.copy_weapon_ammo_stock[var_21];
        var_1.lost_and_found_ent.copy_fullweaponlist = scripts\engine\utility::array_remove(var_1.lost_and_found_ent.copy_fullweaponlist, var_20);
        var_24 = createheadicon(var_4);

        if(var_16 == var_1.lost_and_found_ent.copy_weapon_current getbaseweapon()) {
          var_1.lost_and_found_ent.copy_weapon_current = var_4;
        }

        var_1.lost_and_found_ent.copy_fullweaponlist = scripts\engine\utility::array_add(var_1.lost_and_found_ent.copy_fullweaponlist, var_4);
        var_1.copy_weapon_ammo_clip[var_24] = var_22;
        var_1.copy_weapon_ammo_stock[var_24] = var_23;
        break;
      }
    }
  }

  var_1.ephemeralweapon = undefined;
}

function downgradeweapon(var_0, var_1, var_2, var_3, var_4, var_5) {
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
      case "nunchucks":
      case "katana":
        var_6 = "camo222";
        break;
    }
  } else {
    var_7 = undefined;
  }

  switch (var_3) {
    case "nunchucks":
    case "katana":
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

  var_8 = getweaponattachments(var_2);

  if(istrue(var_6)) {
    var_8 = scripts\engine\utility::array_add(var_8, "akimbo");
  }

  foreach(var_10 in var_8) {
    if(issubstr(var_10, var_4)) {
      var_8 = scripts\engine\utility::array_remove(var_8, var_10);
    }
  }

  var_12 = var_1 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var_2, var_7, var_8, undefined, var_7);
  return asmdevgetallstates(var_12);
}

function use_spawn_instakill(var_0) {
  var_1 = self;

  if(spawn_power_up(var_1, "instakill_30", var_0)) {
    return 1;
  }

  self.consumables["spawn_instakill"].on = 0;
  return 0;
}

function use_spawn_fire_sale(var_0) {
  var_1 = self;

  if(spawn_power_up(var_1, "fire_30", var_0)) {
    return 1;
  }

  self.consumables["fire_30"].on = 0;
  return 0;
}

function use_spawn_nuke(var_0) {
  var_1 = self;

  if(spawn_power_up(var_1, "kill_50", var_0)) {
    return 1;
  }

  self.consumables["spawn_nuke"].on = 0;
  return 0;
}

function use_spawn_double_money(var_0) {
  var_1 = self;

  if(spawn_power_up(var_1, "cash_2", var_0)) {
    return 1;
  }

  self.consumables["spawn_double_money"].on = 0;
  return 0;
}

function use_spawn_max_ammo(var_0) {
  var_1 = self;

  if(spawn_power_up(var_1, "ammo_max", var_0)) {
    return 1;
  }

  self.consumables["spawn_max_ammo"].on = 0;
  return 0;
}

function use_spawn_reboard_windows(var_0) {
  var_1 = self;

  if(spawn_power_up(var_1, "board_windows", var_0)) {
    return 1;
  }

  self.consumables["spawn_reboard_windows"].on = 0;
  return 0;
}

function use_spawn_infinite_ammo(var_0) {
  var_1 = self;

  if(spawn_power_up(var_1, "infinite_20", var_0)) {
    return 1;
  }

  self.consumables["spawn_infinite_ammo"].on = 0;
  return 0;
}

function spawn_power_up(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = (0, 128, 0);
  var_5 = self getplayerangles();
  var_6 = 7;
  var_3 += var_4[0] * anglestoright(var_5);
  var_3 += var_4[1] * anglesToForward(var_5);
  var_3 += var_4[2] * anglestoup(var_5);
  var_7 = rotatepointaroundvector(anglestoup(var_5), anglesToForward(var_5), var_6);
  var_8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_9 = scripts\engine\trace::ray_trace(var_0 getEye(), var_3 + var_7, self, var_8);
  var_3 = scripts\engine\utility::drop_to_ground(var_9["position"] + var_7 * -18, 32, -2000);

  if(!scripts\cp\cp_weapon::isinvalidzone(var_3, level.invalid_spawn_volume_array, undefined, undefined, 1)) {
    return false;
  }

  return false;
}

function use_steel_dragon(var_0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return false;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return false;
  }

  thread give_mp_super_weapon(var_0, "iw7_steeldragon_mp");
  return true;
}

function use_claw_gun(var_0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return false;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return false;
  }

  thread give_mp_super_weapon(var_0, "iw7_claw_mp");
  return true;
}

function use_atomizer_gun(var_0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return false;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return false;
  }

  thread give_mp_super_weapon(var_0, "iw7_atomizer_mp+atomizerscope");
  return true;
}

function use_penetration_gun(var_0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return false;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return false;
  }

  thread give_mp_super_weapon(var_0, "iw7_penetrationrail_mp+penetrationrailscope");
  return true;
}

function use_bh_gun(var_0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var_0].on = 0;
    return false;
  }

  if(self isswitchingweapon()) {
    self.consumables[var_0].on = 0;
    return false;
  }

  thread give_mp_super_weapon(var_0, "iw7_blackholegun_mp+blackholegunscope");
  return true;
}

function give_mp_super_weapon(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_2 = undefined;

  if(issameweapon(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = asmdevgetallstates(var_1);
  }

  var_3 = self getcurrentweapon();
  var_4 = 0;

  if(nullweapon(var_3)) {
    var_4 = 1;
  } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_3)) {
    var_4 = 1;
  } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var_3 getbaseweapon())) {
    var_4 = 1;
  } else if(scripts\cp\utility::is_melee_weapon(var_3, 1)) {
    var_4 = 1;
  }

  if(var_4) {
    self.copy_fullweaponlist = self getweaponslistall();
    var_3 = scripts\cp\cp_laststand::choose_last_weapon(level.additional_laststand_weapon_exclusion, 1, 1);
  }

  self.last_weapon = var_3;
  self.copy_fullweaponlist = undefined;
  thread removeweaponaftertimeout(var_0, var_2, var_3);
  self endon(var_0 + "_exited_early");
  self endon("last_stand");
  wait getcharactercardgesturelength();
  var_2 = scripts\cp\utility::_giveweapon(var_2, undefined, undefined, 0);
  self switchtoweaponimmediate(var_2);
  var_5 = ammo_round_up(var_2);

  while(self getcurrentweapon() != var_2) {
    wait 0.05;
  }

  self notify("super_weapon_given");
  thread unlimited_ammo(var_5, var_2);
}

function removeweaponaftertimeout(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");
  self.isusingsupercard = 1;
  self.mpsuperpreviousweapon = var_2;
  scripts\common\utility::allow_reload(0);
  scripts\engine\utility::ref_143b9(getcharactercardgesturelength() + 1, "super_weapon_given");
  self allowmelee(0);

  while(self isswitchingweapon()) {
    wait 0.05;
  }

  self allowmelee(1);

  if(self getcurrentweapon() == var_1 && scripts\cp\utility::is_consumable_active(var_0)) {
    var_3 = scripts\engine\utility::ref_143b1(var_0 + "_timeup", "last_stand", "weapon_switch_started", "weapon_purchased", "coaster_ride_beginning", "cards_replenished");
  } else {
    var_3 = undefined;
  }

  scripts\common\utility::allow_reload(1);

  if(!isDefined(var_3) || var_3 != var_1 + "_timeup") {
    self notify(var_1 + "_exited_early");
  }

  self.isusingsupercard = undefined;

  if(!isDefined(var_3) || isDefined(var_3) && var_3 != "last_stand") {
    if(self hasweapon(var_3)) {
      self switchtoweapon(var_3);
    } else {
      self switchtoweapon(self getweaponslistprimaries()[1]);
    }
  }

  if(self hasweapon(var_2)) {
    self takeweapon(var_2);
  }

  thread deactivate_infinite_ammo();
  self.mpsuperpreviousweapon = undefined;
  self.last_weapon = undefined;
}

function ammo_round_up(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = [];

  if(isDefined(var_0)) {
    GscBinSkip0(0x2e, createheadicon(var_0), self getammocount(var_0));
  }

  foreach(var_3 in self.weaponlist) {
    var_1 = self getammocount(var_3);
  }

  return var_1;
}

function unlimited_ammo(var_0, var_1) {
  self endon("death");
  self endon("disconnect");

  if(!isDefined(self.weaponlist)) {
    self.weaponlist = self getweaponslistprimaries();
  }

  var_2 = self.weaponlist;

  if(isDefined(var_1)) {
    GscBinSkip0(0x2e, var_2.size, var_1);
  }

  self.has_fnf_weapon = 1;
  scripts\cp\utility::enable_infinite_ammo(1);

  while(istrue(self.has_fnf_weapon)) {
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

    wait 0.05;
  }
}

function weapon_no_unlimited_check(var_0) {
  var_1 = 1;

  if(isDefined(level.opweaponsarray)) {
    foreach(var_3 in level.opweaponsarray) {
      if(var_0.basename == var_3) {
        var_1 = 0;
      }
    }
  }

  return var_1;
}

function deactivate_infinite_ammo() {
  level endon("disconnect");
  level endon("game_ended");
  self.has_fnf_weapon = undefined;
  wait 0.2;
  scripts\cp\utility::enable_infinite_ammo(0);
}

function use_cant_miss(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  level endon("game_ended");

  for(;;) {
    self waittill("shot_missed", var_1);

    if(!scripts\cp\cp_weapon::isbulletweapon(var_1)) {
      continue;
    }

    if(var_1 hasattachment("g18pap1", 1) || var_1 hasattachment("g18paap2")) {
      continue;
    }

    var_2 = self getweaponammoclip(var_1);
    self setweaponammoclip(var_1, var_2 + 1);
  }
}

function use_force_push_near_death(var_0) {
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

function setandremoveinvulnerability() {
  self notify("setAndRemoveInvulnerability");
  self endon("setAndRemoveInvulnerability");
  self endon("disconnect");
  level endon("game_ended");
  scripts\cp\utility::adddamagemodifier("near_death_consumable", 0, 0);
  scripts\engine\utility::ref_143c0(1, "death", "last_stand");
  scripts\cp\utility::removedamagemodifier("near_death_consumable", 0);
}

function killnearbyzombies(var_0) {
  var_1 = 128;
  var_2 = vectorNormalize(anglesToForward(self.angles));
  var_3 = var_2 * var_1;
  var_4 = self.origin + var_3;
  physicsexplosionsphere(var_4, var_1, 1, 2.5);
  var_5 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_6 = scripts\engine\utility::get_array_of_closest(self.origin, var_5, undefined, 24, 256);

  foreach(var_8 in var_6) {
    if(istrue(var_8.immune_against_repulsor)) {
      continue;
    }

    if(isDefined(var_8.agent_type) && (var_8.agent_type == "zombie_sasquatch" || var_8.agent_type == "slasher" || var_8.agent_type == "superslasher" || var_8.agent_type == "zombie_brute" || var_8.agent_type == "zombie_grey" || var_8.agent_type == "zombie_clown")) {
      continue;
    }

    var_8 playSound("zmb_fnf_second_wind_push");
    var_9 = 0;
    var_10 = var_8.origin;
    var_11 = var_8.maxhealth;
    var_2 = anglesToForward(self.angles);
    var_12 = vectorNormalize(var_2) * -100;
    var_8 setvelocity(vectorNormalize(var_8.origin - self.origin + var_12) * 800 + (0, 0, 300));
    killrepulsorvictim(var_8, self, var_11, var_10, self.origin);
  }
}

function killrepulsorvictim(var_0, var_1, var_2, var_3) {
  self.do_immediate_ragdoll = 1;

  if(var_1 >= self.health) {
    self.customdeath = 1;
  }

  self dodamage(var_1, var_2, var_0, var_0, "MOD_IMPACT", "zom_repulsor_mp");
}

function select_random_vector_in_radius(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = var_0.origin;
  var_5 = (0, 128, 0);
  var_6 = var_0 getplayerangles();
  var_7 = 7;
  var_8 = 0;
  var_4 += var_5[0] * anglestoright(var_6);
  var_4 += var_5[1] * anglesToForward(var_6);
  var_4 += var_5[2] * anglestoup(var_6);
  var_9 = rotatepointaroundvector(anglestoup(var_6), anglesToForward(var_6), var_7);
  var_10 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_11 = scripts\engine\trace::ray_trace(var_0 getEye(), var_4 + var_9, var_0, var_10);
  var_4 = scripts\engine\utility::drop_to_ground(var_11["position"] + var_9 * -18, 32, -2000);
  var_12 = 0;

  foreach(var_14 in var_2) {
    if(scripts\engine\utility::within_fov(self getEye(), self.angles, var_14.origin, cos(65))) {
      if(distance2dsquared(self.origin, var_14.origin) < 1000000) {
        if(var_12 <= 5) {
          self.closestenemies_array[var_15] = var_14;
          var_3 = var_14.origin;
          var_12++;
          continue;
        }

        break;
      }
    }
  }

  var_3 = getrandomnavpoints(var_0.origin, var_1, 5, undefined, var_4, 1200);
  return var_3;
}

function torrent_start(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  level endon("game_ended");

  if(var_3 == 0 || var_3 == 3 || var_3 == 6) {
    playsoundatpos(var_1, "zmb_fnf_timely_torrent_lava");
  }

  playFX(level._effect["lava_torrent"], self.origin, undefined, anglestoup((0, 0, 90)));

  foreach(var_6 in var_2) {
    var_7 = (var_6.origin[0], var_6.origin[1], 90);

    if(isDefined(var_6.flung) || isDefined(var_6.agent_type) && (var_6.agent_type == "zombie_brute" || var_6.agent_type == "zombie_ghost" || var_6.agent_type == "zombie_grey" || var_6.agent_type == "slasher" || var_6.agent_type == "superslasher")) {
      continue;
    }

    if(distancesquared(var_6.origin, var_1) < 5184) {
      var_6.flung = 1;
      var_6.do_immediate_ragdoll = 1;
      var_6.disable_armor = 1;
      var_6 setsolid(0);
      var_6 setvelocity((0, 0, 600));
      wait 0.1;

      if(isDefined(var_6)) {
        var_6 dodamage(10000, var_1, var_4, var_4, "MOD_EXPLOSIVE");
      }
    }
  }

  self delete();
}

function use_timely_torrent(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  level endon("game_ended");
  thread run_timely_torrent(var_0);
}

function select_spot_array(var_0, var_1) {
  if(!isDefined(var_0.array_of_torrent_points)) {
    var_0.array_of_torrent_points = [];
  }

  var_2 = var_0.origin;
  var_3 = (0, 128, 0);
  var_4 = var_0 getplayerangles();
  var_5 = 7;
  var_6 = 0;
  var_2 += var_3[0] * anglestoright(var_4);
  var_2 += var_3[1] * anglesToForward(var_4);
  var_2 += var_3[2] * anglestoup(var_4);
  var_7 = rotatepointaroundvector(anglestoup(var_4), anglesToForward(var_4), 0);
  var_8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_9 = scripts\engine\trace::ray_trace(var_0 getEye(), var_2 + var_7, var_0, var_8);
  var_2 = var_9["position"] + var_7;

  if(var_1 == 0) {
    var_0.array_of_torrent_points[var_1] = var_2 + anglesToForward(var_4) * 60;
  } else {
    var_0.array_of_torrent_points[var_1] = var_2 + anglesToForward(var_4) * (var_1 + 1) * 60;
  }

  return var_0.array_of_torrent_points;
}

function run_timely_torrent(var_0) {
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
      var_1 = spawn("script_origin", var_7);
    }

    foreach(var_7 in var_1) {
      if(!isDefined(var_7)) {
        continue;
      }

      thread torrent_start(var_7, var_0, var_7.origin, var_5, var_8);
    }

    scripts\cp\utility::notify_used_consumable("timely_torrent");
  }
}

function use_purify(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  self endon(var_0 + "_exited_early");
  level endon("game_ended");

  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::is_valid_player()) {
      thread purify_activate(var_2, var_0, var_2);
    }
  }

  return true;
}

function purify_activate(var_0, var_1, var_2) {
  level endon("game_ended");
  var_1 notify("force_regeneration");
  var_3 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, 24, 99999, 0);

  foreach(var_1 in var_3) {
    thread dealaoedamage(var_1);
    wait 0.5;
  }

  var_2 scripts\cp\utility::notify_used_consumable("purify");
}

function dealaoedamage(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 = scripts\cp\cp_agent_utils::get_alive_enemies();
  var_2 = scripts\engine\utility::get_array_of_closest(self.origin, var_1, undefined, 24, 128, 0);

  if(var_2.size > 0) {
    self notify("force_regeneration");

    foreach(var_4 in var_2) {
      if(isDefined(var_4.agent_type) && (var_4.agent_type == "zombie_brute" || var_4.agent_type == "zombie_ghost" || var_4.agent_type == "zombie_grey" || var_4.agent_type == "slasher" || var_4.agent_type == "superslasher")) {
        continue;
      }

      playFX(level._effect["penetration_railgun_explosion"], self.origin);
      var_4 dodamage(var_4.health + 100, var_4.origin, self, self, "MOD_EXPLOSIVE", "iw7_explosive_touch_zm");
    }

    self playSound("zmb_fnf_purify_explo");
    return;
  }
}

function calcfrontposbasedonvelocity(var_0) {
  var_1 = (0, 0, 0);
  var_2 = self.origin + var_1;
  var_3 = anglesToForward(self.angles);
  var_4 = anglestoright(self.angles);
  var_5 = self getvelocity();
  var_6 = vectordot(var_5, self.angles);
  var_7 = length(var_5);

  if(var_7 < 64) {
    var_7 = 64;
  }

  if(var_7 > 64 && var_7 < 128) {
    var_7 = 92;
  }

  if(var_7 > 350) {
    var_7 = 500;
  }

  if(var_7 > 200) {
    var_7 = 256;
  }

  if(var_7 > 128) {
    var_7 = 164;
  }

  if(var_6 < 1) {
    var_7 = 64;
  }

  if(isDefined(var_0)) {
    var_7 = var_0;
  }

  return var_2 + var_3 * var_7;
}

function watchmelee() {
  self endon("death");
  self endon("disconnect");
  self endon("removeReaper");
  level endon("game_ended");
  var_0 = (0, 0, 32);

  for(;;) {
    scripts\engine\utility::ref_143a6("melee_fired", "ads_in", "ads_out");
    var_1 = self.origin + var_0;
    var_2 = anglesToForward(self.angles);
    var_3 = anglestoright(self.angles);
    self playRumbleOnEntity("damage_light");
    earthquake(0.2, 0.1, self.origin, 32);
    var_4 = calcfrontposbasedonvelocity();
    var_4 += var_0;
    var_5 = var_1 + var_3 * 64;
    var_6 = var_1 - var_3 * 32;
    var_7 = rotatevector(var_3, (0, 45, 0));
    var_8 = var_1 + var_7 * 64;
    var_9 = rotatevector(var_3, (0, 135, 0));
    var_10 = var_1 + var_9 * 32;
    var_11 = gettime();
    self.meleeorigin.origin = var_5;
    wait 0.05;
    playFXOnTag(level._effect["swipe_trail"], self.meleeorigin, "tag_origin");
    wait 0.05;
    self.meleeorigin.origin = var_8;
    wait 0.05;
    self.meleeorigin.origin = var_4;
    thread applyradiusdamageasmelee(var_4);
    wait 0.05;
    self.meleeorigin.origin = var_10;
    wait 0.05;
    self.meleeorigin.origin = var_6;
    wait 0.05;
    stopFXOnTag(level._effect["swipe_trail"], self.meleeorigin, "tag_origin");
  }
}

function applyradiusdamageasmelee(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeReaper");
  level endon("game_ended");
  var_1 = distance2d(self.origin, var_0) / 2;
  self radiusdamage(self.origin, var_1, 600, 300, self, "MOD_MELEE", "iw7_reaperblade_mp");
}

function use_masochist(var_0) {
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

function use_explosive_touch(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  thread remove_explosive_touch(var_0);

  for(;;) {
    if(!istrue(self.has_explosive_touch)) {
      self.has_explosive_touch = 1;
      thread watch_for_zombie_touch(var_0);
      scripts\cp\utility::adddamagemodifier("health_boost", 0.1, 0);
      self notify("force_regeneration");
      self playlocalsound("breathing_heartbeat_alt");
    }

    waitframe();
  }
}

function watch_for_zombie_touch(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");

  while(istrue(self.has_explosive_touch)) {
    var_1 = scripts\cp\cp_agent_utils::get_alive_enemies();

    foreach(var_3 in var_1) {
      if(scripts\engine\utility::distance_2d_squared(var_3.origin, self.origin) <= 5184) {
        var_3.exp_touch = 1;

        if(var_3 scripts\cp\utility::agentisfnfimmune()) {
          continue;
        }

        if(var_3 scripts\cp\utility::is_zombie_agent() && !istrue(var_3.is_skeleton) && var_3.agent_type != "slasher" && var_3.agent_type != "superslasher" && var_3.agent_type != "zombie_brute" && var_3.agent_type != "zombie_grey") {
          var_3.nocorpse = 1;
          var_3.full_gib = 1;
          playsoundatpos(var_3 gettagorigin("j_spineupper"), "zmb_fnf_explosive_touch_explo");
          wait 0.1;
          playFX(scripts\engine\utility::getfx("exp_touch"), var_3 gettagorigin("j_spineupper"));
          self radiusdamage(self.origin, 100, var_3.maxhealth, 1000, self, "MOD_EXPLOSIVE", "iw7_explosive_touch_zm");
          wait 0.3;
        }
      }
    }

    waitframe();
  }
}

function remove_explosive_touch(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::ref_143a5(var_0 + "_timeup", var_0 + "_exited_early");
  self.has_explosive_touch = 0;
  scripts\cp\utility::removedamagemodifier("health_boost", 0);

  if(isDefined(self.explosivetrigger)) {
    self.explosivetrigger delete();
    return;
  }
}

function use_shared_fate(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  self.marked_ents = [];
  thread look_at_and_outline_enemies(var_0);
  thread outline_enemeies(var_0);
  thread damage_on_marked_enemies(var_0);
}

function damage_on_marked_enemies(var_0) {
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

      if(var_7.health >= var_7.maxhealth) {
        var_7 setscriptablepartstate("shared_fate_fx", "inactive", 1);
      }

      self.marked_ents = scripts\engine\utility::array_remove(self.marked_ents, var_7);
      var_7 dodamage(var_2, var_7.origin, var_1, var_1, var_3, "iw7_shared_fate_weapon");
    }
  }
}

function play_vfx_between_points_marked(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(var_1)) {
    var_3 = spawnfx(scripts\engine\utility::getfx("ufo_elec_beam_impact"), var_1);
    triggerfx(var_3);
  }

  if(isDefined(var_2)) {
    var_4 = spawnfx(scripts\engine\utility::getfx("ufo_elec_beam_impact"), var_2);
    triggerfx(var_4);
  }

  wait 3;

  if(isDefined(var_3)) {
    var_3 delete();
  }

  if(isDefined(var_4)) {
    var_4 delete();
    return;
  }
}

function deletevfx(var_0) {
  scripts\engine\utility::ref_143a5(var_0 + "_exited_early", var_0 + "_timeup");
}

function outline_enemeies(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");

  for(;;) {
    foreach(var_2 in self.marked_ents) {
      if(var_2 scripts\cp\utility::agentisfnfimmune()) {
        continue;
      }

      if(isDefined(var_2.agent_type) && (var_2.agent_type == "zombie_sasquatch" || var_2.agent_type == "slasher" || var_2.agent_type == "superslasher" || var_2.agent_type == "zombie_brute" || var_2.agent_type == "zombie_grey" || var_2.agent_type == "zombie_clown" || var_2.agent_type == "skater")) {
        continue;
      }

      if(scripts\cp\utility::is_melee_weapon(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc_melee(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc2_melee(self getcurrentweapon())) {
        waitframe();
        continue;
      }

      if(istrue(var_2.marked_shared_fate_fnf)) {
        var_2 setscriptablepartstate("shared_fate_fx", "active", 1);
        continue;
      }

      if(isDefined(var_2)) {
        var_2 setscriptablepartstate("shared_fate_fx", "inactive", 1);
      }
    }

    waitframe();
  }
}

function look_at_and_outline_enemies(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  var_1 = 0;

  for(;;) {
    if(self adsButtonPressed() && !var_1) {
      if(scripts\cp\utility::is_melee_weapon(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc_melee(self getcurrentweapon())) {
        waitframe();
        continue;
      }

      var_1 = 1;
      var_2 = self getplayerangles();
      var_3 = self getEye();
      var_4 = anglesToForward(var_2);
      var_5 = var_3 + var_4 * 500;
      var_6 = scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 0, 0);
      var_7 = physics_raycast(var_3, var_5, var_6, self, 0, "physicsquery_closest");

      if(var_7.size <= 0) {
        waitframe();
        continue;
      }

      var_8 = var_7[0]["entity"];

      if(isDefined(var_8)) {
        if(isDefined(var_8.agent_type) && (var_8.agent_type == "zombie_sasquatch" || var_8.agent_type == "slasher" || var_8.agent_type == "superslasher" || var_8.agent_type == "zombie_brute" || var_8.agent_type == "zombie_grey" || var_8.agent_type == "zombie_clown")) {
          continue;
        }

        if(var_8 scripts\cp\utility::is_zombie_agent()) {
          if(!scripts\engine\utility::array_contains(self.marked_ents, var_8)) {
            self playlocalsound("zmb_fnf_shared_fate_highlight");
            var_8.marked_shared_fate_fnf = 1;
            self.marked_ents = scripts\engine\utility::array_add(self.marked_ents, var_8);
          }
        }
      }

      var_1 = 0;
    } else {
      var_1 = 0;
    }

    waitframe();
  }
}

function use_fire_chains(var_0) {
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
      wait 0.5;
    }

    waitframe();
  }
}

function getfirechainstarget(var_0) {
  var_1 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.players, [var_0], 4, 512);
  var_2 = sortbydistance(var_1, var_0.origin);
  var_3 = undefined;

  foreach(var_5 in var_2) {
    var_6 = sighttracepassed(var_0 getEye(), var_5 getEye(), 0, var_0);

    if(!var_6) {
      continue;
    }

    if(istrue(var_5.inlaststand)) {
      continue;
    }

    var_3 = var_5;
    break;
  }

  return var_3;
}

function linktoplayer_fire_chains(var_0, var_1, var_2) {
  while(istrue(var_0.linked_to_player)) {
    thread deal_damage_to_zombies_entering_the_link(self, var_2);

    if(istrue(var_1.inlaststand)) {
      var_0.linked_to_player = undefined;
      var_0 notify("lost_target_fire_chains");
      break;
    } else if(distance(var_0.origin, var_1.origin) > 512) {
      var_0.linked_to_player = undefined;
      var_0 notify("lost_target_fire_chains");
      break;
    }

    waitframe();
  }
}

function deal_damage_to_zombies_entering_the_link(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\engine\trace::create_character_contents();
  var_2 = [var_0, var_0.besttarget];

  foreach(var_5 in var_1) {
    var_6 = scripts\engine\trace::ray_trace(var_0 gettagorigin(var_5), var_0.besttarget gettagorigin(var_5), var_2, var_3);

    if(isDefined(var_6["entity"])) {
      if(var_6["entity"] scripts\cp\utility::is_zombie_agent() && !istrue(var_6["entity"].is_skeleton) && var_6["entity"].agent_type != "slasher" && var_6["entity"].agent_type != "superslasher" && var_6["entity"].agent_type != "zombie_brute" && var_6["entity"].agent_type != "zombie_grey") {
        scripts\engine\utility::array_add(var_2, var_6["entity"]);
        var_6["entity"].nocorpse = 1;
        var_6["entity"].full_gib = 1;
        var_6["entity"] dodamage(1000000, var_6["entity"].origin, var_0, var_0);
      }
    }
  }
}

function playfirechainsfx(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in level.players) {
    var_3 = playfxontagsbetweenclients(level._effect["fire_chains"], self, var_1, var_0, var_1, var_5);
  }

  self.fx_array_fire_chains = var_3;
  self playLoopSound("zmb_fnf_fire_chains_lp");
  var_0 playLoopSound("zmb_fnf_fire_chains_lp");
  var_7 = scripts\engine\utility::waittill_any_ents_return(self, "disconnect", self, "lost_target_fire_chains", self, "last_stand", self, var_2 + "_timeup", var_0, "disconnect", var_0, "last_stand", level, "game_ended");

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

function removefirechainsdamagemodifieronlaststand(var_0) {
  self endon(var_0 + "_timeup");
  self waittill("last_stand");
  self.life_linked = undefined;
  self.life_link_active = undefined;

  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
  }

  self notify(var_0 + "_exited_early");
}

function removefirechainsdamagemodifierontimeout(var_0) {
  self endon("last_stand");
  self waittill(var_0 + "_timeup");
  self.life_linked = undefined;
  self.life_link_active = undefined;

  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
    return;
  }
}

function use_irish_luck(var_0) {
  self endon(var_0 + "_timeup");
  self endon("last_stand");
  self endon("disconnect");
  level endon("game_ended");
}

function irish_luck_choose_random_consumable(var_0) {
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_0.stored_fnf)) {
    var_0.stored_fnf = [];
  }

  foreach(var_2 in var_0.consumables) {
    var_0.stored_fnf[var_3] = var_3;
  }

  for(;;) {
    var_4 = scripts\engine\utility::random(level.irish_luck_consumables);

    if(scripts\engine\utility::array_contains(var_0.stored_fnf, var_4.name)) {
      waitframe();
      continue;
    } else {
      waitframe();
      return var_4;
    }

    waitframe();
  }
}

function clear_omnvar(var_0) {
  wait 5;
  self setclientomnvar(var_0, 0);
}

function consumable_activate_internal_irish(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
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
    level.random_consumable_chosen.ref = int(tablelookup("cp/loot/iw7_zombiefatefortune_loot_master.csv", 1, level.random_consumable_chosen.name, 0));
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
      scripts\cp\cp_merits::processmerit("mt_faf_uses");
      thread scripts\cp\cp_vo::try_to_play_vo("wonder_consume", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);

      if(self.consumables[var_0].times_used == 1) {
        thread decrement_counter_of_consumables(var_0);
      }

      thread lightbar_off();
      self setclientomnvarbit("zm_card_fill_display", var_5, 1);
      remove_card_from_use(var_6);
      thread meter_fill_up();
      self playlocalsound("ui_consumable_select");
      play_consumable_activate_sound(self);
      self notify("consumable_selected");
      self setweaponammostock(self.fate_card_weapon, 1);
      self giveandfireoffhand(self.fate_card_weapon);
      self.consumable_meter_full = undefined;
      level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_use_fateandfort");
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
    return;
  }
}

function use_temporal_increase(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  self endon("last_stand");
  self.temporal_increase = 2;
  thread remove_temporal_increase(var_0);
}

function remove_temporal_increase(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::ref_143a7(var_0 + "_timeup", "disconnect", "death", var_0 + "_exited_early");
  self.temporal_increase = undefined;
  return true;
}

function use_twister(var_0) {
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

function remove_twister(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 scripts\engine\utility::ref_143a7(var_0 + "_timeup", var_0 + "_exited_early", "last_stand", "death");
  level notify("stop_twister_sfx");

  if(isDefined(var_1.fx_ent)) {
    var_1.fx_ent delete();
  }

  if(isDefined(var_1.trigger_move_ent)) {
    var_1.trigger_move_ent delete();
    return;
  }
}

function activate_twister_homing(var_0, var_1) {
  self endon("disconnect");
  self endon(var_1 + "_timeup");
  self endon(var_1 + "_exited_early");
  level endon("game_ended");
  self endon("death");
  self endon("last_stand");

  if(!isDefined(self.twister_array_zombie)) {
    self.twister_array_zombie = [];
  }

  self.trigger_move_ent = spawn("script_model", var_0, 0, 512, 128);
  self.trigger_move_ent setModel("tag_origin");
  level.trigger_move_ent_sfx = spawn("script_model", var_0, 0, 512, 128);
  level.trigger_move_ent_sfx linkTo(self.trigger_move_ent);
  wait 0.5;
  thread twister_sfx();
  playFXOnTag(level._effect["twister"], self.trigger_move_ent, "tag_origin");
  self.trigger_move_ent setotherent(self);
  thread deal_damage_to_enemies(self.trigger_move_ent, self);
  thread move_ent_function(self.trigger_move_ent, var_1);
}

function twister_sfx() {
  self playSound("fnf_tornado_start_lr");
  wait 0.4;
  self playLoopSound("fnf_tornado_lr_lp");
  level waittill("stop_twister_sfx");
  level thread scripts\engine\utility::play_sound_in_space("fnf_tornado_stop_lr", self.origin);
  wait 0.15;
  self stoploopsound();
  self delete();
}

function get_zombie_targets(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon(var_1 + "_timeup");
  var_0 endon(var_1 + "_exited_early");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("last_stand");

  for(;;) {
    var_2 = scripts\cp\cp_agent_utils::get_alive_enemies();
    var_3 = scripts\engine\utility::get_array_of_closest(var_0.origin, var_2, undefined, 24, 2048);

    if(var_3.size <= 0) {
      waitframe();
      var_0.twister_array_zombie = [];
      var_0.twister_array_zombie[var_0.twister_array_zombie.size] = getclosestpointonnavmesh(self.origin) + (0, 10, 0);
      continue;
    } else {
      foreach(var_5 in var_3) {
        if(istrue(var_5.entered_playspace)) {
          var_0.twister_array_zombie = var_0 findpath(var_0.origin, scripts\engine\utility::drop_to_ground(var_3[var_3.size - 1].origin, 1, 1));
        }
      }
    }

    wait 2.5;
  }
}

function deal_damage_to_enemies(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("last_stand");
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

      if(var_4 scripts\cp\utility::agentisfnfimmune()) {
        continue;
      }

      if(distance2dsquared(self.origin, var_4.origin) < 22500) {
        if(isDefined(var_4.agent_type) && (var_4.agent_type == "slasher" || var_4.agent_type == "superslasher")) {
          var_4 dodamage(1000, var_4.origin, var_0, var_0, "MOD_UNKNOWN");
          continue;
        }

        thread fling_zombie_thundergun_harpoon(var_4, var_4.health + 1000, var_4, var_0);
      }
    }

    wait 1;
  }
}

function fling_zombie_thundergun_harpoon(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_3 endon("death");

  if(!isDefined(var_3)) {
    return;
  }

  var_4 = var_1.origin - var_3.origin;
  var_5 = anglestoup(self.angles);
  self setvelocity(vectorNormalize((var_3.origin - self.origin) * 400) + (0, 0, 800));
  wait 0.16;

  if(isDefined(var_2)) {
    var_1.do_immediate_ragdoll = 1;
    var_1.disable_armor = 1;
    var_1.customdeath = 1;
    wait 0.1;
    var_1.nocorpse = 1;
    var_1.full_gib = 1;
    self dodamage(self.health + 1000, var_1.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_twister_zm");
    return;
  }

  self.nocorpse = 1;
  self.full_gib = 1;
  self dodamage(self.health + 1000, var_1.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_twister_zm");
}

function move_ent_function(var_0, var_1) {
  self endon("death");
  self endon("last_stand");
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
            var_0 moveTo(self.twister_array_zombie[0], 0.5, 0.25, 0);
          } else {
            var_3 = getclosestpointonnavmesh(self.twister_array_zombie[0]) + (0, 10, 0);
            var_0 moveTo(var_3, 0.5, 0.25, 0);
          }

          var_2--;
        }
      } else {
        var_2 = 0;
      }

      waitframe();
      continue;
    } else {
      var_0 moveTo(self.twister_array_zombie[var_2], 0.5, 0, 0);
    }

    var_2 += 1;
    waitframe();
  }
}

function use_self_revive(var_0) {
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
    scripts\cp\cp_laststand::disable_self_revive(self);

    if(scripts\cp\utility::has_zombie_perk("perk_machine_tough")) {
      self.maxhealth = 200;
      self.health = self.maxhealth;
    }

    scripts\cp\utility::notify_used_consumable(var_0);
    break;
  }
}

function removeselfreviveonearlyexit(var_0) {
  self endon(var_0 + " activated");
  self endon("disconnect");
  level endon("game_ended");
  self waittill(var_0 + "_exited_early");
  scripts\cp\cp_laststand::disable_self_revive(self);
}

function use_welfare(var_0) {
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
  return true;
}

function use_increased_team_efficiency(var_0) {
  self endon(var_0 + "_timeup");
  self endon("disconnect");
  self endon("last_stand");
  self endon("death");

  if(!isDefined(level.consumable_cash_scalar)) {
    level.consumable_cash_scalar = 0;
  }

  thread update_team_multiplier(var_0);
  thread cleanupaftertimeoutordeath(var_0);
  setomnvar("zom_escape_combo_multiplier", 1);

  for(;;) {
    var_1 = scripts\engine\utility::ref_143ad("shot_missed", "weapon_hit_enemy");

    if(var_1 == "shot_missed") {
      level.consumable_cash_scalar -= 0.02;
    } else {
      level.consumable_cash_scalar += 0.02;
    }

    if(level.consumable_cash_scalar < 0) {
      level.consumable_cash_scalar = 0;
    }

    self notify("update_team_efficiency");
  }
}

function update_team_multiplier(var_0) {
  while(isDefined(level.consumable_cash_scalar)) {
    self waittill("update_team_efficiency");
    var_1 = 1 + level.consumable_cash_scalar;
    setomnvar("zom_escape_combo_multiplier", var_1);
  }

  setomnvar("zom_escape_combo_multiplier", -1);
}

function cleanupaftertimeoutordeath(var_0) {
  var_1 = scripts\engine\utility::ref_143af(var_0 + "_timeup", "disconnect", "last_stand", "death");
  level.consumable_cash_scalar = undefined;
}

function use_slow_enemy_movement(var_0) {
  self endon(var_0 + "_timeup");
  self endon("disconnect");
  thread removeslowmoveonlaststand(var_0);

  foreach(var_2 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    thread adjustmovespeed(var_2, var_2, var_0);
  }

  for(;;) {
    level waittill("agent_spawned", var_4);
    thread adjustmovespeed(var_4, var_4, var_0, self);
  }
}

function adjustmovespeed(var_0, var_1, var_2, var_3) {
  var_0 endon("death");

  if(isDefined(var_0.agent_type) && (var_0.agent_type == "zombie_brute" || var_0.agent_type == "zombie_grey" || var_0.agent_type == "zombie_ghost")) {
    return;
  }

  if(istrue(var_0.is_suicide_bomber)) {
    return;
  }

  if(istrue(var_3)) {
    wait 0.5;
  }

  if(!isDefined(var_0.asm.cur_move_mode)) {
    var_4 = var_0.movemode;
  } else {
    var_4 = var_1.asm.cur_move_mode;
  }

  switch (var_4) {
    case "slow_walk":
      break;
    case "walk":
    case "run":
    case "sprint":
      var_1 scripts\asm\asm_bb::bb_requestmovetype("slow_walk");
      break;
  }

  var_3 scripts\engine\utility::ref_143a6(var_2 + "_timeup", "last_stand", "disconnect");
  var_1 scripts\asm\asm_bb::bb_requestmovetype(var_4);
}

function removeslowmoveonlaststand(var_0) {
  self endon(var_0 + "_timeup");
  self waittill("last_stand");
  self notify(var_0 + "_exited_early");
}

function use_life_link(var_0) {
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
    wait 0.5;
  }
}

function getlifelinktarget(var_0) {
  var_1 = scripts\engine\utility::get_array_of_closest(var_0.origin, level.players, [var_0], 4, 512);
  var_2 = sortbydistance(var_1, var_0.origin);
  var_3 = undefined;

  foreach(var_5 in var_2) {
    var_6 = sighttracepassed(var_0 getEye(), var_5 getEye(), 0, var_0);

    if(!var_6) {
      continue;
    }

    if(istrue(var_5.inlaststand)) {
      continue;
    }

    var_3 = var_5;
    break;
  }

  return var_3;
}

function linktoplayer(var_0, var_1) {
  var_0 endon("disconnect");

  while(istrue(var_0.linked_to_player)) {
    if(istrue(var_1.inlaststand)) {
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

    wait 0.25;
  }
}

function playlifelinkfx(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  self endon("disconnect");
  var_3 = [];
  playFXOnTag(level._effect["life_link_target"], var_0, var_1);

  foreach(var_5 in level.players) {
    var_3 = playfxontagsbetweenclients(level._effect["life_link"], self, var_1, var_0, var_1, var_5);
  }

  self playLoopSound("zmb_fnf_lifelink_heal_lp");
  var_0 playLoopSound("zmb_fnf_lifelink_heal_lp");
  var_7 = scripts\engine\utility::waittill_any_ents_return(self, "disconnect", self, "lost_target", self, "last_stand", self, var_2 + "_timeup", var_0, "disconnect", var_0, "last_stand", level, "game_ended");

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
    return;
  }
}

function removedamagemodifieronlaststand(var_0) {
  self endon(var_0 + "_timeup");
  self waittill("last_stand");
  self.life_linked = undefined;
  self.life_link_active = undefined;

  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
  }

  self notify(var_0 + "_exited_early");
}

function removedamagemodifierontimeout(var_0) {
  self endon("last_stand");
  self waittill(var_0 + "_timeup");
  self.life_linked = undefined;
  self.life_link_active = undefined;

  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
    return;
  }
}

function use_phoenix_up(var_0) {
  var_1 = level.players;
  var_2 = 0;

  foreach(var_4 in var_1) {
    var_5 = var_4;

    if(isDefined(var_4.owner)) {
      var_5 = var_4.owner;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_5)) {
      var_2 = 1;
      scripts\cp\cp_laststand::instant_revive(var_5);
      scripts\cp\cp_laststand::record_revive_success(self, var_5);
    }
  }

  if(!var_2) {
    self.consumables["phoenix_up"].on = 0;
    waitframe();
    return false;
  }

  wait 0.25;
  scripts\cp\utility::notify_used_consumable("phoenix_up");
  return true;
}

function use_killing_time(var_0) {
  level endon("game_ended");

  foreach(var_2 in level.players) {
    if(!isDefined(var_2.killing_time)) {
      var_2.killing_time = 0;
    }

    var_2.killing_time++;
  }

  waitframe();
  scripts\cp\utility::notify_used_consumable("killing_time");
  scripts\engine\utility::ref_143bb(20, "death", "last_stand", "disconnect");

  foreach(var_2 in level.players) {
    if(isDefined(var_2.killing_time)) {
      var_2.killing_time--;

      if(var_2.killing_time <= 0) {
        var_2.killing_time = undefined;
      }
    }
  }
}

function use_now_you_see_me(var_0) {
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

  wait 10;

  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::isignoremeenabled()) {
      var_2 scripts\cp\utility::allow_player_ignore_me(0);
    }
  }
}

function removenowyouseemeonlaststand(var_0) {
  self endon(var_0 + "_timeup");
  var_1 = scripts\engine\utility::ref_143ad("last_stand", "disconnect");

  foreach(var_3 in level.players) {
    if(var_3 scripts\cp\utility::isignoremeenabled()) {
      var_3 scripts\cp\utility::allow_player_ignore_me(0);
    }
  }

  if(isDefined(var_1) && var_1 == "last_stand") {
    self notify(var_0 + "_exited_early");
    return;
  }
}

function use_anywhere_but_here(var_0) {
  if(!scripts\cp\utility::isteleportenabled()) {
    self.consumables["anywhere_but_here"].on = 0;
    return false;
  }

  if(istrue(self.is_in_pap)) {
    self.consumables["anywhere_but_here"].on = 0;
    return false;
  }

  var_1 = level.active_player_respawn_locs;
  var_1 = scripts\engine\utility::array_remove_duplicates(var_1);

  foreach(var_3 in level.active_player_respawn_locs) {
    var_4 = [[level.get_spawn_volume_func]]();

    foreach(var_6 in var_4) {
      if(ispointinvolume(var_3.origin, var_6)) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_3);
      }
    }
  }

  if(var_1.size < 1) {
    var_1 = level.active_player_respawn_locs;
  }

  var_9 = self[[level.get_respawn_loc_rated]](level.players, var_1);

  if(!isDefined(var_9)) {
    self.consumables["anywhere_but_here"].on = 0;
    return false;
  }

  scripts\cp\cp_interaction::refresh_interaction();
  scripts\cp\cp_powers::power_enablepower();
  self forceusehintoff();
  self setOrigin(var_9.origin);
  self setplayerangles(var_9.angles);
  self notify("left_hidden_room_early");
  scripts\cp\utility::notify_used_consumable("anywhere_but_here");
  self.abh_used = gettime();
  return true;
}

function jumptoanywherebutherespawns(var_0) {
  level endon("game_ended");
  level.players[0] endon("death");
  level.players[0] endon("last_stand");

  foreach(var_2 in level.active_player_respawn_locs) {
    level.players[0] scripts\cp\cp_interaction::refresh_interaction();
    level.players[0] scripts\cp\cp_powers::power_enablepower();
    level.players[0] forceusehintoff();
    level.players[0] setOrigin(var_2.origin);
    level.players[0] setplayerangles(var_2.angles);
    wait 2;
  }
}

function use_headshot_reload(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  self.headshot_reload_time = gettime();
}

function headshot_reload_check(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!scripts\cp\utility::is_consumable_active("headshot_reload")) {
    return 0;
  }

  if(!scripts\engine\utility::isbulletdamage(var_3)) {
    return 0;
  }

  if(!scripts\cp\utility::isheadshot(var_4, var_6, var_3, var_1)) {
    return 0;
  }

  var_9 = self getcurrentweapon();
  var_10 = self getweaponammostock(var_9);
  var_11 = weaponclipsize(var_9);
  var_12 = self getweaponammoclip(var_9);
  var_13 = var_11 - var_12;

  if(var_10 >= var_13) {
    self setweaponammostock(var_9, var_10 - var_13);
  } else {
    var_11 = var_10;
    self setweaponammostock(var_9, 0);
  }

  var_14 = var_11;
  var_15 = min(var_12 + var_14, var_11);
  self setweaponammoclip(var_9, int(var_15));

  if(self isdualwielding()) {
    var_12 = self getweaponammoclip(var_9, "left");
    var_15 = min(var_12 + var_14, var_11);
    self setweaponammoclip(var_9, int(var_15), "left");
    return;
  }
}

function use_grenade_cooldown(var_0) {
  self.power_cooldowns = 1;
  scripts\cp\cp_powers::power_adjustcharges(1, "primary");
  var_1 = getarraykeys(self.powers);

  foreach(var_3 in var_1) {
    self.powers[var_3].cooldownratemod = 1;
  }
}

function turn_off_grenade_cooldown(var_0) {
  self.power_cooldowns = 0;
}

function write_consumable_used(var_0, var_1) {
  if(!isDefined(var_0.consumables)) {
    return;
  }

  var_2 = 0;

  foreach(var_4 in var_0.consumables_pre_irish_luck_usage) {
    var_5 = get_consumable_loot_id(var_6);
    setclientmatchdata("player", var_1, "cardsUsed", var_2, "loot_ID", int(var_5));
    setclientmatchdata("player", var_1, "cardsUsed", var_2, "num_of_times_used", var_4.times_used);
    var_2++;
  }
}

function get_consumable_loot_id(var_0) {
  return tablelookup("cp/loot/iw7_zombiefatefortune_loot_master.csv", 1, var_0, 0);
}

function set_consumable(var_0) {
  return self[[level.consumables[var_0].set]](var_0);
}

function unset_consumable(var_0) {
  self[[level.consumables[var_0].unset]](var_0);
}