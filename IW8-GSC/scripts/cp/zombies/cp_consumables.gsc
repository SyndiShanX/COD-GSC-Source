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
    var0 = level.consumable_table;
  } else {
    var0 = "cp/loot/iw7_zombiefatefortune_loot_master.csv";
  }

  for(var1 = 0;; var1++) {
    var2 = tablelookupbyrow(var0, var1, 1);

    if(var2 == "") {
      break;
    }

    var3 = tablelookupbyrow(var0, var1, 6);
    var4 = int(tablelookupbyrow(var0, var1, 7));
    var5 = int(tablelookupbyrow(var0, var1, 8));
    var6 = int(tablelookupbyrow(var0, var1, 9));
    register_consumable(var2, var3, var4, var5, var6, &give_consumable, &remove_consumable);
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

function register_consumable(var0, var1, var2, var3, var4, var5, var6) {
  var7 = spawnStruct();
  var7.type = var1;
  var7.uses = var2;
  var7.usageperiod = var3;
  var7.passiveuses = var4;
  var7.set = var5;
  var7.unset = var6;
  var7.timeupnotify = var0 + "_timeup";
  level.consumables[var0] = var7;

  foreach(var9 in level.irish_luck_consumables) {
    if(var10 == var0) {
      level.irish_luck_consumables[var0] = level.consumables[var0];
      level.irish_luck_consumables[var0].name = var0;
    }
  }
}

function consumable_setup_functions(var0, var1, var2, var3, var4) {
  var5 = level.consumables[var0];

  if(isDefined(var1)) {
    var5.usefunc = var1;
  }

  if(isDefined(var2)) {
    var5.set = var2;
  }

  if(isDefined(var3)) {
    var5.unset = var3;
  }

  if(isDefined(var4)) {
    var5.testforsuccess = var4;
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

  for(var0 = 0; var0 < 32; var0++) {
    self setplayerdata("common", "consumablesUsed", var0, 0);
  }
}

function set_player_consumables() {
  self.consumables = [];

  for(var0 = 0; var0 < 5; var0++) {
    var1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombie_consumables", var0);
    self.consumables[var1] = spawnStruct();
    self.consumables[var1].uses = level.consumables[var1].uses;
    self.consumables[var1].on = 0;
    self.consumables[var1].times_used = 0;
  }

  self.consumables_pre_irish_luck_usage = self.consumables;
}

function turn_on_cards(var0) {
  var1 = get_card_deck_size(self);
  self.slot_array = [];
  self playlocalsound("zmb_fnf_replenish");

  for(var2 = 0; var2 < var1; var2++) {
    self.slot_array[self.slot_array.size] = var2;
    self setclientomnvarbit("zm_card_selection_count", var2, 1);
  }

  update_lua_consumable_slot(0);
}

function reset_meter() {
  self notify("give_new_deck");
  self.consumable_meter = 0;
  init_consumable_meter();
  thread lightbar_off();
}

function get_card_deck_size(var0) {
  var1 = var0 isitemunlocked("fate_card_slot_4", "fatedecksize", 1);
  var2 = var0 isitemunlocked("fate_card_slot_5", "fatedecksize", 1);
  var3 = 3;

  if(var1 && var2) {
    var3 = 5;
  } else if(var1 && !var2) {
    var3 = 4;
  } else if(!var1 && !var2) {
    var3 = 3;
  }

  return var3;
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

function watch_for_super_button(var0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("offhand_fired", var1);
    var2 = createheadicon(var1);

    if(var2 == var0) {
      if(istrue(self.inlaststand)) {
        self setweaponammoclip(var0, 1);
        continue;
      }

      self notify("fired_super");
      self setweaponammoclip(var0, 1);
    }
  }
}

function dpad_consumable_selection_watch() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("consumable_selected");
  self endon("give_new_deck");
  var0 = 0;
  update_lua_consumable_slot(var0);
  self.deck_select_ready = 1;

  for(;;) {
    var1 = scripts\engine\utility::ref_143ae("D_pad_up", "D_pad_down", "fired_super");

    if(self.slot_array.size <= 0 || istrue(self.disable_consumables) || istrue(self.spectating) || istrue(self.inlaststand)) {
      self playlocalsound("ui_consumable_deny");
      wait 0.25;
      continue;
    }

    if(var1 == "fired_super") {
      self.deck_select_ready = undefined;
      thread consumable_activate(self.slot_array[var0], var0);
    } else if(var1 == "D_pad_up" && self.slot_array.size > 1) {
      var0 = get_selection_index_loop_around(var0 + 1, 0, self.slot_array.size - 1);
      update_lua_consumable_slot(var0);
      self playlocalsound("ui_consumable_scroll");
    } else if(var1 == "D_pad_down" && self.slot_array.size > 1) {
      var0 = get_selection_index_loop_around(var0 - 1, 0, self.slot_array.size - 1);
      update_lua_consumable_slot(var0);
      self playlocalsound("ui_consumable_scroll");
    }

    waitframe();
  }
}

function update_lua_consumable_slot(var0) {
  wait 0.1;
}

function get_selection_index_loop_around(var0, var1, var2) {
  if(var0 > var2) {
    return var1;
  }

  if(var0 < var1) {
    return var2;
  }

  return var0;
}

function remove_card_from_use(var0) {
  self.slot_array = scripts\engine\utility::array_remove(self.slot_array, self.slot_array[var0]);
}

function consumable_activate(var0, var1) {
  var2 = self getplayerdata("cp", "zombiePlayerLoadout", "zombie_consumables", var0);
  var3 = "zm_card" + var0 + 1 + "_drain";
  var4 = "slot_" + var0 + 1 + "_used";
  self.consumables[var2].usednotify = var4;

  if(var2 == "irish_luck") {
    thread consumable_activate_internal_irish(var2, var3, "zm_dpad_up_uses", "zm_dpad_up_activated", var4, var0, var1);
    return;
  }

  thread consumable_activate_internal(var2, var3, "zm_dpad_up_uses", "zm_dpad_up_activated", var4, var0, var1);
}

function consumable_activate_internal(var0, var1, var2, var3, var4, var5, var6) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("dpad_end_" + var0);
  self endon("give_new_deck");

  if(self.consumables[var0].uses > 0 && self.consumables[var0].on == 0 && !scripts\cp\cp_laststand::player_in_laststand(self)) {
    self setclientomnvar("zm_fate_card_used", var5);
    self.consumables[var0].processing = 1;
    var7 = undefined;
    var8 = "fired_super";
    thread set_consumable(var0);

    if(isDefined(level.consumables[var0].usefunc)) {
      if(isDefined(level.consumables[var0].testforsuccess)) {
        var7 = self[[level.consumables[var0].usefunc]](var0);
      } else {
        var7 = self thread[[level.consumables[var0].usefunc]](var0);
      }
    }

    if(!isDefined(var7) || isDefined(var7) && var7) {
      consume_from_inventory(self, var0);
      self.consumables[var0].times_used++;
      scripts\cp\cp_merits::processmerit("mt_faf_uses");
      thread scripts\cp\cp_vo::try_to_play_vo("wonder_consume", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);

      if(self.consumables[var0].times_used == 1) {
        thread decrement_counter_of_consumables(var0);
      }

      self setclientomnvar(var1, 1);
      thread lightbar_off();
      self setclientomnvarbit("zm_card_fill_display", var5, 1);
      remove_card_from_use(var6);
      thread meter_fill_up();
      self playlocalsound("ui_consumable_select");
      play_consumable_activate_sound(self);
      self notify("consumable_selected");
      thread scripts\cp\utility::firegesturegrenade(self, self.fate_card_weapon);
      self.consumable_meter_full = undefined;
      level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_use_fateandfort");
      var9 = level.consumables[var0].type;

      if(var9 == "timedactivations") {
        thread dpad_drain_time(var0, level.consumables[var0].usageperiod, var1, var8, var2, var3, var4, var5);
      } else if(var9 == "wave") {
        thread dpad_drain_wave(var0, level.consumables[var0].usageperiod, var1, var8, var2, var3, var4, var5);
      } else if(var9 == "triggernow" || level.consumables[var0].type == "triggerwait") {
        thread dpad_drain_activations(var0, level.consumables[var0].type, self.consumables[var0].uses, var1, var8, var2, var3, var4, var5);
      } else if(var9 == "triggerpassive") {
        thread dpad_drain_triggerpassive(var0, level.consumables[var0].passiveuses, var1, var8, var2, var3, var4, var5);
      }

      if(isDefined(var7)) {
        scripts\cp\utility::notify_used_consumable(var0);
        return;
      }

      return;
    }

    self playlocalsound("ui_consumable_deny");
    self.consumables[var0].processing = undefined;
    return;
  }
}

function decrement_counter_of_consumables(var0) {
  var1 = get_consumable_index_in_player_data(self, var0);

  if(isDefined(var1)) {
    var2 = self getplayerdata("cp", "zombiePlayerLoadout", "consumables_counter", var1);
    var3 = var2 - 1;
    self setplayerdata("cp", "zombiePlayerLoadout", "consumables_counter", var1, var3);
    return;
  }
}

function play_consumable_activate_sound(var0) {
  switch (var0.fate_card_weapon) {
    case "iw7_jockcard_zm":
      var0 playlocalsound("wondercard_jock_use_gesture");
      break;
    case "iw7_nerdcard_zm":
      var0 playlocalsound("wondercard_nerd_use_gesture");
      break;
    case "iw7_valleygirlcard_zm":
      var0 playlocalsound("wondercard_valleygirl_use_gesture");
      break;
    case "iw7_rappercard_zm":
      var0 playlocalsound("wondercard_rapper_use_gesture");
      break;
    case "iw7_grungecard_zm":
      var0 playlocalsound("wondercard_gesture_grunge");
      break;
    case "iw7_cholacard_zm":
      var0 playlocalsound("wondercard_gesture_chola");
      break;
    case "iw7_ravercard_zm":
      var0 playlocalsound("wondercard_gesture_raver");
      break;
    case "iw7_hiphopcard_zm":
      var0 playlocalsound("wondercard_gesture_hiphop");
      break;
    case "iw7_survivorcard_zm":
      var0 playlocalsound("wondercard_gesture_survivor");
      break;
    default:
      var0 playlocalsound("wondercard_jock_use_gesture");
      break;
  }
}

function consume_from_inventory(var0, var1) {
  var2 = get_consumable_loot_id(var1);

  if(scripts\engine\utility::array_contains(var0.consumables_used, var2)) {
    return;
  }

  var3 = var0.consumables_used.size;

  if(isDefined(level.consumable_table)) {
    var4 = level.consumable_table;
  } else {
    var4 = "cp/loot/iw7_zombiefatefortune_loot_master.csv";
  }

  var5 = tablelookup(var4, 1, var2, 3);

  if(isDefined(var5)) {
    if(var5 == "Fortune") {
      var1 setplayerdata("common", "consumablesUsed", var4, int(var3));
      var6 = var1 getplayerdata("common", "numConsumables");
      var1 setplayerdata("common", "numConsumables", var6 + 1);
      var1.consumables_used = scripts\engine\utility::array_add(var1.consumables_used, var3);
      return;
    }

    return;
  }
}

function get_consumable_index_in_player_data(var0, var1) {
  for(var2 = 0; var2 < 5; var2++) {
    var3 = var0 getplayerdata("cp", "zombiePlayerLoadout", "zombie_consumables", var2);

    if(var1 == var3) {
      return var2;
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

function dpad_drain_time(var0, var1, var2, var3, var4, var5, var6, var7) {
  self endon("disconnect");
  self endon(var0 + "_exited_early");
  level endon("game_ended");
  thread watchforearlyexit(var0, var4, var2, var5, var6, var7);
  var8 = 1;
  var9 = var8 / var1;
  wait getcharactercardgesturelength();

  for(;;) {
    if(!istrue(self.spectating) && !istrue(self.inlaststand)) {
      self setclientomnvar(var2, var8);
      var8 -= var9;

      if(var8 <= 0) {
        self setclientomnvar(var2, 0);
        disable_consumable(var0, var4, var2, var5, var6, var7);
        break;
      }
    }

    wait 1;
  }
}

function dpad_drain_wave(var0, var1, var2, var3, var4, var5, var6, var7) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var0 + "_exited_early");
  thread watchforearlyexit(var0, var4, var2, var5, var6, var7);
  var8 = 1;
  var9 = var8 / var1;

  for(;;) {
    self setclientomnvar(var2, var8);
    level waittill("spawn_wave_done");
    var8 -= var9;

    if(var8 <= 0) {
      self setclientomnvar(var2, 0);
      disable_consumable(var0, var4, var2, var5, var6, var7);
      break;
    }

    wait 1;
  }
}

function dpad_drain_activations(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var0 + "_exited_early");
  thread watchforearlyexit(var0, var5, var3, var6, var7, var8);
  var9 = self.consumables[var0].usednotify;
  var10 = 1;

  if(var1 == "triggerwait") {
    self waittill(var9);
  }

  wait 1;

  for(;;) {
    if(!istrue(self.spectating) && !istrue(self.inlaststand)) {
      var10 -= 0.05;
      self setclientomnvar(var3, var10);

      if(var10 <= 0) {
        self setclientomnvar(var3, 0);
        disable_consumable(var0, var5, var3, var6, var7, var8);
        break;
      }
    }

    wait 0.05;
  }
}

function dpad_drain_triggerpassive(var0, var1, var2, var3, var4, var5, var6, var7) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var0 + "_exited_early");
  thread watchforearlyexit(var0, var4, var2, var5, var6, var7);
  var8 = 1 / var1;
  var9 = self.consumables[var0].usednotify;
  var10 = 1;

  for(;;) {
    self waittill(var9);

    if(!istrue(self.spectating) && !istrue(self.inlaststand) || var0 == "coagulant") {
      var10 -= var8;
      self setclientomnvar(var2, var10);

      if(var10 < 0.0001) {
        self setclientomnvar(var2, 0);
        disable_consumable(var0, var4, var2, var5, var6, var7);
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

function watchforearlyexit(var0, var1, var2, var3, var4, var5) {
  self endon("dpad_end_" + var0);
  self waittill(var0 + "_exited_early");
  self setclientomnvar(var2, 0);
  thread disable_consumable(var0, var1, var2, var3, var4, var5);
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
    self waittill("consumable_charge", var0);

    if(istrue(self.disable_consumables)) {
      continue;
    }

    var1 = self.consumable_meter_max - self.consumable_meter;

    if(var0 > var1) {
      var0 = var1;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(self)) {
      continue;
    }

    self.consumable_meter += var0;
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
  var0 = 1250;

  if(self.card_refills == 1) {
    var0 = 3000;
  } else if(self.card_refills == 2) {
    var0 = 5000;
  }

  return var0;
}

function disable_consumable(var0, var1, var2, var3, var4, var5) {
  turn_off_consumable(var0, var3);
  self.consumables[var0].uses -= 1;
  self.consumables[var0].processing = undefined;
  self setclientomnvar(var1, self.consumables[var0].uses);

  if(self.consumables[var0].uses == 0) {
    self.consumables[var0].uses = level.consumables[var0].uses;
    self notify("dpad_end_" + var0);
    self setclientomnvarbit("zm_card_selection_count", var5, 0);
    self setclientomnvarbit("zm_card_fill_display", var5, 0);
    return;
  }

  self setclientomnvar(var2, 1);
}

function turn_off_consumable(var0, var1) {
  self.consumables[var0].on = 0;
  scripts\cp\utility::notify_timeup_consumable(var0);
  thread unset_consumable(var0);
}

function give_consumable(var0, var1) {
  var2 = level.consumables[var0];

  if(isDefined(var2.usednotify)) {
    self notify(var2.usednotify);
  } else {
    self notify(var0 + " activated");
  }

  if(isDefined(level.random_consumable_chosen) && level.random_consumable_chosen.name == var0) {
    return;
  }

  self.consumables[var0].on = 1;
}

function remove_consumable(var0) {
  if(isDefined(self.consumables[var0])) {
    self.consumables[var0].on = 0;
    return;
  }
}

function use_reload_damage_increase(var0) {
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

function use_ephemeral_enhancement(var0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var0].on = 0;
    return 0;
  }

  var1 = self getcurrentweapon();
  var2 = scripts\cp\utility::getrawbaseweaponname(var1);

  if(isDefined(self.pap[var2]) && scripts\cp\cp_weapon::can_upgrade(var1, 1)) {
    thread fnf_upgrade_weapon(self, var0, var2, var1);
    return 1;
  }

  self.consumables["ephemeral_enhancement"].on = 0;
  return 0;
}

function fnf_upgrade_weapon(var0, var1, var2, var3) {
  level endon("game_ended");
  var0 endon("disconnect");
  var4 = undefined;
  var0.isusingsupercard = 1;
  var5 = "pap" + var0.pap[var2].lvl;
  var6 = getweaponattachments(var3);
  var7 = 0;
  var8 = var3;

  if(issubstr(var3.basename, "g18_z")) {
    foreach(var10 in var6) {
      if(issubstr(var10, "akimbo")) {
        var7 = 1;
        var6 = scripts\engine\utility::array_remove(var6, var10);
      }
    }
  }

  var12 = createheadicon(var3);

  if(isDefined(level.custom_epehermal_attachment_func)) {
    var13 = [[level.custom_epehermal_attachment_func]](var0, var2, var12);

    if(isDefined(var13)) {
      if(var13 == "replace_me") {
        var5 = undefined;
      } else {
        var5 = var13;
      }
    }
  }

  if(isDefined(level.weapon_upgrade_path) && isDefined(level.weapon_upgrade_path[getweaponbasename(var3)])) {
    var12 = level.weapon_upgrade_path[getweaponbasename(var3)];
  } else if(isDefined(level.custom_epehermal_weapon_func)) {
    var12 = [[level.custom_epehermal_weapon_func]](var0, var2, var3);
  }

  var3 = asmdevgetallstates(var12);

  if(isDefined(level.custom_ephermal_camo_func)) {
    var4 = [[level.custom_ephermal_camo_func]](var0, var2, var3);
  } else {
    if(isDefined(var2)) {
      if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var2)) {
        var4 = undefined;
      } else if(isDefined(level.pap_1_camo) && var0.pap[var2].lvl == 1) {
        var4 = level.pap_1_camo;
      } else if(isDefined(level.pap_2_camo) && var0.pap[var2].lvl == 2) {
        var4 = level.pap_2_camo;
      }

      var14 = var0 scripts\cp\cp_weapon::get_weapon_level(var3);

      switch (var2) {
        case "dischord":
          var15 = "iw7_dischord_zm_pap1";
          var4 = "camo20";
          break;
        case "facemelter":
          var15 = "iw7_facemelter_zm_pap1";
          var4 = "camo22";
          break;
        case "headcutter":
          var15 = "iw7_headcutter_zm_pap1";
          var4 = "camo21";
          break;
        case "forgefreeze":
          if(var14 == 2) {
            var15 = "iw7_forgefreeze_zm_pap1";
          } else if(var14 == 3) {
            var15 = "iw7_forgefreeze_zm_pap2";
          }

          var16 = 1;
          break;
        case "axe":
          if(var14 == 2) {
            var15 = "iw7_axe_zm_pap1";
          } else if(var14 == 3) {
            var15 = "iw7_axe_zm_pap2";
          }

          break;
        case "shredder":
          var15 = "iw7_shredder_zm_pap1";
          var4 = "camo23";
          break;
        case "nunchucks":
        case "katana":
          var4 = "camo222";
          break;
      }
    }

    var16 = 0;

    if(isDefined(var2)) {
      switch (var2) {
        case "spiked":
        case "golf":
        case "two":
        case "axe":
        case "machete":
          var16 = 1;
        default:
          var16 = 0;
          break;
      }
    } else {
      var16 = 0;
    }

    var5 = undefined;

    if(isDefined(var2)) {
      switch (var2) {
        case "spiked":
        case "golf":
        case "two":
        case "machete":
        case "nunchucks":
        case "katana":
          var5 = "replace_me";
          break;
        default:
          if(isDefined(var0.pap[var2])) {
            var5 = "pap" + var0.pap[var2].lvl;
          } else {
            var5 = "pap1";
          }

          break;
      }
    }

    if(isDefined(var5) && var5 == "replace_me") {
      var5 = undefined;
    }

    var17 = getweaponattachments(var3);

    if(issubstr(var3.basename, "g18_z")) {
      foreach(var10 in var17) {
        if(issubstr(var10, "akimbo")) {
          var17 = scripts\engine\utility::array_remove(var17, var10);
        }
      }
    }
  }

  var20 = var0 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var3, var5, var6, undefined, var4);
  var21 = asmdevgetallstates(var20);

  if(isDefined(var21)) {
    var0.pap[var2].lvl++;
    var0 notify("weapon_level_changed");
    var0.ephemeralweapon = var21 getbaseweapon();
    thread downgradeweaponaftertimeout(var0, var1, var0, var21);
    var0 endon("last_stand");
    wait getcharactercardgesturelength();
    var21 = var0 scripts\cp\utility::_giveweapon(var21, undefined, undefined, 1);

    if(isDefined(var8)) {
      var0 takeweapon(var8);
    } else {
      var0 takeweapon(var3);
    }

    var0 switchtoweapon(var21);
    return;
  }
}

function downgradeweaponaftertimeout(var0, var1, var2, var3) {
  level endon("game_ended");
  var1 endon("disconnect");
  var4 = undefined;

  if(issameweapon(var2)) {
    var4 = var2;
  } else {
    var4 = asmdevgetallstates(var2);
  }

  var5 = var1.ephemeralweapon;
  var6 = 0;
  var7 = scripts\cp\utility::getrawbaseweaponname(var4);
  var8 = "pap" + var1.pap[var7].lvl - 1;
  var9 = var1.pap[var7].lvl - 2;

  switch (var7) {
    case "katana":
      var1.pap[var7].lvl--;

      if(var1.pap[var7].lvl == 1) {
        var1.base_weapon = 1;
        var4 = getcompleteweaponname("iw7_katana_zm");
      } else {
        var1.ephemeral_downgrade = 1;
        var4 = getcompleteweaponname("iw7_katana_zm_pap1");
      }

      break;
    case "nunchucks":
      var1.pap[var7].lvl--;

      if(var1.pap[var7].lvl == 1) {
        var1.base_weapon = 1;
        var4 = getcompleteweaponname("iw7_nunchucks_zm");
      } else {
        var1.ephemeral_downgrade = 1;
        var4 = getcompleteweaponname("iw7_nunchucks_zm_pap1");
      }

      break;
    case "two":
      var1.pap[var7].lvl--;

      if(var1.pap[var7].lvl == 1) {
        var1.base_weapon = 1;
        var4 = getcompleteweaponname("iw7_two_headed_axe_mp");
      } else {
        var1.ephemeral_downgrade = 1;
        var4 = getcompleteweaponname("iw7_two_headed_axe_mp_pap1");
      }

      break;
    case "machete":
      var1.pap[var7].lvl--;

      if(var1.pap[var7].lvl == 1) {
        var1.base_weapon = 1;
        var4 = getcompleteweaponname("iw7_machete_mp");
      } else {
        var1.ephemeral_downgrade = 1;
        var4 = getcompleteweaponname("iw7_machete_mp_pap1");
      }

      break;
    case "golf":
      var1.pap[var7].lvl--;

      if(var1.pap[var7].lvl == 1) {
        var1.base_weapon = 1;
        var4 = getcompleteweaponname("iw7_golf_club_mp");
      } else {
        var1.ephemeral_downgrade = 1;
        var4 = getcompleteweaponname("iw7_golf_club_mp_pap1");
      }

      break;
    case "spiked":
      var1.pap[var7].lvl--;

      if(var1.pap[var7].lvl == 1) {
        var1.base_weapon = 1;
        var4 = getcompleteweaponname("iw7_spiked_bat_mp");
      } else {
        var1.ephemeral_downgrade = 1;
        var4 = getcompleteweaponname("iw7_spiked_bat_mp_pap1");
      }

      break;
  }

  var4 = downgradeweapon(var1, var4, var7, var8, var9, var3);
  var1.base_weapon = undefined;
  var1.ephemeral_downgrade = undefined;
  var10 = var1 scripts\engine\utility::ref_143ad("ephemeral_enhancement_timeup", "last_stand");

  if(var10 != "ephemeral_enhancement_timeup") {
    var1 notify(var0 + "_exited_early");
  }

  var1.isusingsupercard = undefined;
  var11 = var1 scripts\cp\utility::getvalidtakeweapon();
  var12 = scripts\cp\utility::getrawbaseweaponname(var11);

  if(var1 scripts\cp\cp_weapon::has_weapon_variation(var5)) {
    var13 = var1 getweaponslistall();

    foreach(var15 in var13) {
      var16 = scripts\cp\utility::getrawbaseweaponname(var15);

      if(var16 == scripts\cp\utility::getrawbaseweaponname(var5)) {
        var1 takeweapon(var15);
        var6 = 1;
        var4 = var1 scripts\cp\utility::_giveweapon(var4, undefined, undefined, 1);

        if(scripts\cp\utility::getrawbaseweaponname(var4) == var12) {
          var1 switchtoweaponimmediate(var4);
        }

        var1.pap[var7].lvl = int(max(var1.pap[var7].lvl - 1, 1));
        var1 notify("weapon_level_changed");
        break;
      }
    }
  }

  if(isDefined(var1.copy_fullweaponlist)) {
    var18 = var1.copy_fullweaponlist;

    foreach(var20 in var18) {
      var16 = var20 getbaseweapon();

      if(var16 == var5) {
        var21 = createheadicon(var20);
        var22 = var1.copy_weapon_ammo_clip[var21];
        var23 = var1.copy_weapon_ammo_stock[var21];
        var1.copy_fullweaponlist = scripts\engine\utility::array_remove(var1.copy_fullweaponlist, var20);
        var24 = createheadicon(var4);

        if(var16 == var1.copy_weapon_current getbaseweapon()) {
          var1.copy_weapon_current = var4;
        }

        var1.copy_fullweaponlist = scripts\engine\utility::array_add(var1.copy_fullweaponlist, var24);
        var1.copy_weapon_ammo_clip[var24] = var22;
        var1.copy_weapon_ammo_stock[var24] = var23;
        break;
      }
    }
  }

  if(isDefined(var1.last_stand_pistol)) {
    if(var1.last_stand_pistol getbaseweapon() == var1.ephemeralweapon) {
      var1.last_stand_pistol = var4;
    }
  }

  if(isDefined(var1.saved_last_stand_pistol)) {
    if(var1.saved_last_stand_pistol getbaseweapon() == var1.ephemeralweapon) {
      var1.saved_last_stand_pistol = var4;
    }
  }

  if(isDefined(var1.lost_and_found_ent)) {
    var18 = var1.lost_and_found_ent.copy_fullweaponlist;

    foreach(var20 in var18) {
      var16 = var20 getbaseweapon();

      if(var16 == var5) {
        var21 = createheadicon(var20);
        var22 = var1.copy_weapon_ammo_clip[var21];
        var23 = var1.copy_weapon_ammo_stock[var21];
        var1.lost_and_found_ent.copy_fullweaponlist = scripts\engine\utility::array_remove(var1.lost_and_found_ent.copy_fullweaponlist, var20);
        var24 = createheadicon(var4);

        if(var16 == var1.lost_and_found_ent.copy_weapon_current getbaseweapon()) {
          var1.lost_and_found_ent.copy_weapon_current = var4;
        }

        var1.lost_and_found_ent.copy_fullweaponlist = scripts\engine\utility::array_add(var1.lost_and_found_ent.copy_fullweaponlist, var4);
        var1.copy_weapon_ammo_clip[var24] = var22;
        var1.copy_weapon_ammo_stock[var24] = var23;
        break;
      }
    }
  }

  var1.ephemeralweapon = undefined;
}

function downgradeweapon(var0, var1, var2, var3, var4, var5) {
  var6 = undefined;

  if(var4 >= 1) {
    if(isDefined(level.no_pap_camos) && scripts\engine\utility::array_contains(level.no_pap_camos, var2)) {
      var6 = undefined;
    } else if(isDefined(level.pap_1_camo)) {
      var6 = level.pap_1_camo;
    }

    var7 = "pap" + var4;

    switch (var2) {
      case "dischord":
        var6 = "camo20";
        break;
      case "facemelter":
        var6 = "camo22";
        break;
      case "headcutter":
        var6 = "camo21";
        break;
      case "shredder":
        var6 = "camo23";
        break;
      case "nunchucks":
      case "katana":
        var6 = "camo222";
        break;
    }
  } else {
    var7 = undefined;
  }

  switch (var3) {
    case "nunchucks":
    case "katana":
      var7 = undefined;
      break;
    case "two":
      var7 = undefined;
      break;
    case "golf":
      var7 = undefined;
      break;
    case "machete":
      var7 = undefined;
      break;
    case "spiked":
      var7 = undefined;
      break;
  }

  var8 = getweaponattachments(var2);

  if(istrue(var6)) {
    var8 = scripts\engine\utility::array_add(var8, "akimbo");
  }

  foreach(var10 in var8) {
    if(issubstr(var10, var4)) {
      var8 = scripts\engine\utility::array_remove(var8, var10);
    }
  }

  var12 = var1 scripts\cp\cp_weapon::return_weapon_name_with_like_attachments(var2, var7, var8, undefined, var7);
  return asmdevgetallstates(var12);
}

function use_spawn_instakill(var0) {
  var1 = self;

  if(spawn_power_up(var1, "instakill_30", var0)) {
    return 1;
  }

  self.consumables["spawn_instakill"].on = 0;
  return 0;
}

function use_spawn_fire_sale(var0) {
  var1 = self;

  if(spawn_power_up(var1, "fire_30", var0)) {
    return 1;
  }

  self.consumables["fire_30"].on = 0;
  return 0;
}

function use_spawn_nuke(var0) {
  var1 = self;

  if(spawn_power_up(var1, "kill_50", var0)) {
    return 1;
  }

  self.consumables["spawn_nuke"].on = 0;
  return 0;
}

function use_spawn_double_money(var0) {
  var1 = self;

  if(spawn_power_up(var1, "cash_2", var0)) {
    return 1;
  }

  self.consumables["spawn_double_money"].on = 0;
  return 0;
}

function use_spawn_max_ammo(var0) {
  var1 = self;

  if(spawn_power_up(var1, "ammo_max", var0)) {
    return 1;
  }

  self.consumables["spawn_max_ammo"].on = 0;
  return 0;
}

function use_spawn_reboard_windows(var0) {
  var1 = self;

  if(spawn_power_up(var1, "board_windows", var0)) {
    return 1;
  }

  self.consumables["spawn_reboard_windows"].on = 0;
  return 0;
}

function use_spawn_infinite_ammo(var0) {
  var1 = self;

  if(spawn_power_up(var1, "infinite_20", var0)) {
    return 1;
  }

  self.consumables["spawn_infinite_ammo"].on = 0;
  return 0;
}

function spawn_power_up(var0, var1, var2) {
  var3 = var0.origin;
  var4 = (0, 128, 0);
  var5 = self getplayerangles();
  var6 = 7;
  var3 += var4[0] * anglestoright(var5);
  var3 += var4[1] * anglesToForward(var5);
  var3 += var4[2] * anglestoup(var5);
  var7 = rotatepointaroundvector(anglestoup(var5), anglesToForward(var5), var6);
  var8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var9 = scripts\engine\trace::ray_trace(var0 getEye(), var3 + var7, self, var8);
  var3 = scripts\engine\utility::drop_to_ground(var9["position"] + var7 * -18, 32, -2000);

  if(!scripts\cp\cp_weapon::isinvalidzone(var3, level.invalid_spawn_volume_array, undefined, undefined, 1)) {
    return false;
  }

  return false;
}

function use_steel_dragon(var0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var0].on = 0;
    return false;
  }

  if(self isswitchingweapon()) {
    self.consumables[var0].on = 0;
    return false;
  }

  thread give_mp_super_weapon(var0, "iw7_steeldragon_mp");
  return true;
}

function use_claw_gun(var0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var0].on = 0;
    return false;
  }

  if(self isswitchingweapon()) {
    self.consumables[var0].on = 0;
    return false;
  }

  thread give_mp_super_weapon(var0, "iw7_claw_mp");
  return true;
}

function use_atomizer_gun(var0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var0].on = 0;
    return false;
  }

  if(self isswitchingweapon()) {
    self.consumables[var0].on = 0;
    return false;
  }

  thread give_mp_super_weapon(var0, "iw7_atomizer_mp+atomizerscope");
  return true;
}

function use_penetration_gun(var0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var0].on = 0;
    return false;
  }

  if(self isswitchingweapon()) {
    self.consumables[var0].on = 0;
    return false;
  }

  thread give_mp_super_weapon(var0, "iw7_penetrationrail_mp+penetrationrailscope");
  return true;
}

function use_bh_gun(var0) {
  if(istrue(self.isusingsupercard)) {
    self.consumables[var0].on = 0;
    return false;
  }

  if(self isswitchingweapon()) {
    self.consumables[var0].on = 0;
    return false;
  }

  thread give_mp_super_weapon(var0, "iw7_blackholegun_mp+blackholegunscope");
  return true;
}

function give_mp_super_weapon(var0, var1) {
  level endon("game_ended");
  self endon("disconnect");
  var2 = undefined;

  if(issameweapon(var1)) {
    var2 = var1;
  } else {
    var2 = asmdevgetallstates(var1);
  }

  var3 = self getcurrentweapon();
  var4 = 0;

  if(nullweapon(var3)) {
    var4 = 1;
  } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var3)) {
    var4 = 1;
  } else if(scripts\engine\utility::array_contains(level.additional_laststand_weapon_exclusion, var3 getbaseweapon())) {
    var4 = 1;
  } else if(scripts\cp\utility::is_melee_weapon(var3, 1)) {
    var4 = 1;
  }

  if(var4) {
    self.copy_fullweaponlist = self getweaponslistall();
    var3 = scripts\cp\cp_laststand::choose_last_weapon(level.additional_laststand_weapon_exclusion, 1, 1);
  }

  self.last_weapon = var3;
  self.copy_fullweaponlist = undefined;
  thread removeweaponaftertimeout(var0, var2, var3);
  self endon(var0 + "_exited_early");
  self endon("last_stand");
  wait getcharactercardgesturelength();
  var2 = scripts\cp\utility::_giveweapon(var2, undefined, undefined, 0);
  self switchtoweaponimmediate(var2);
  var5 = ammo_round_up(var2);

  while(self getcurrentweapon() != var2) {
    wait 0.05;
  }

  self notify("super_weapon_given");
  thread unlimited_ammo(var5, var2);
}

function removeweaponaftertimeout(var0, var1, var2) {
  level endon("game_ended");
  self endon("disconnect");
  self.isusingsupercard = 1;
  self.mpsuperpreviousweapon = var2;
  scripts\common\utility::allow_reload(0);
  scripts\engine\utility::ref_143b9(getcharactercardgesturelength() + 1, "super_weapon_given");
  self allowmelee(0);

  while(self isswitchingweapon()) {
    wait 0.05;
  }

  self allowmelee(1);

  if(self getcurrentweapon() == var1 && scripts\cp\utility::is_consumable_active(var0)) {
    var3 = scripts\engine\utility::ref_143b1(var0 + "_timeup", "last_stand", "weapon_switch_started", "weapon_purchased", "coaster_ride_beginning", "cards_replenished");
  } else {
    var3 = undefined;
  }

  scripts\common\utility::allow_reload(1);

  if(!isDefined(var3) || var3 != var1 + "_timeup") {
    self notify(var1 + "_exited_early");
  }

  self.isusingsupercard = undefined;

  if(!isDefined(var3) || isDefined(var3) && var3 != "last_stand") {
    if(self hasweapon(var3)) {
      self switchtoweapon(var3);
    } else {
      self switchtoweapon(self getweaponslistprimaries()[1]);
    }
  }

  if(self hasweapon(var2)) {
    self takeweapon(var2);
  }

  thread deactivate_infinite_ammo();
  self.mpsuperpreviousweapon = undefined;
  self.last_weapon = undefined;
}

function ammo_round_up(var0) {
  self endon("death");
  self endon("disconnect");
  var1 = [];

  if(isDefined(var0)) {
    GscBinSkip0(0x2e, createheadicon(var0), self getammocount(var0));
  }

  foreach(var3 in self.weaponlist) {
    var1 = self getammocount(var3);
  }

  return var1;
}

function unlimited_ammo(var0, var1) {
  self endon("death");
  self endon("disconnect");

  if(!isDefined(self.weaponlist)) {
    self.weaponlist = self getweaponslistprimaries();
  }

  var2 = self.weaponlist;

  if(isDefined(var1)) {
    GscBinSkip0(0x2e, var2.size, var1);
  }

  self.has_fnf_weapon = 1;
  scripts\cp\utility::enable_infinite_ammo(1);

  while(istrue(self.has_fnf_weapon)) {
    var3 = 0;

    foreach(var5 in var2) {
      if(var5 == self getcurrentweapon() && weapon_no_unlimited_check(var5)) {
        var3 = 1;
        self setweaponammoclip(var5, weaponclipsize(var5), "left");
      }

      if(var5 == self getcurrentweapon() && weapon_no_unlimited_check(var5)) {
        var3 = 1;
        self setweaponammoclip(var5, weaponclipsize(var5), "right");
      }

      if(var3 == 0) {
        ammo_round_up(var1);
      }
    }

    wait 0.05;
  }
}

function weapon_no_unlimited_check(var0) {
  var1 = 1;

  if(isDefined(level.opweaponsarray)) {
    foreach(var3 in level.opweaponsarray) {
      if(var0.basename == var3) {
        var1 = 0;
      }
    }
  }

  return var1;
}

function deactivate_infinite_ammo() {
  level endon("disconnect");
  level endon("game_ended");
  self.has_fnf_weapon = undefined;
  wait 0.2;
  scripts\cp\utility::enable_infinite_ammo(0);
}

function use_cant_miss(var0) {
  self endon("disconnect");
  self endon(var0 + "_timeup");
  level endon("game_ended");

  for(;;) {
    self waittill("shot_missed", var1);

    if(!scripts\cp\cp_weapon::isbulletweapon(var1)) {
      continue;
    }

    if(var1 hasattachment("g18pap1", 1) || var1 hasattachment("g18paap2")) {
      continue;
    }

    var2 = self getweaponammoclip(var1);
    self setweaponammoclip(var1, var2 + 1);
  }
}

function use_force_push_near_death(var0) {
  self endon("disconnect");
  self endon(var0 + "_timeup");
  level endon("game_ended");

  for(;;) {
    self waittill("player_damaged");

    if(self.health <= 45) {
      thread setandremoveinvulnerability();
      thread killnearbyzombies();
      scripts\cp\utility::notify_used_consumable(var0);
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

function killnearbyzombies(var0) {
  var1 = 128;
  var2 = vectorNormalize(anglesToForward(self.angles));
  var3 = var2 * var1;
  var4 = self.origin + var3;
  physicsexplosionsphere(var4, var1, 1, 2.5);
  var5 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var6 = scripts\engine\utility::get_array_of_closest(self.origin, var5, undefined, 24, 256);

  foreach(var8 in var6) {
    if(istrue(var8.immune_against_repulsor)) {
      continue;
    }

    if(isDefined(var8.agent_type) && (var8.agent_type == "zombie_sasquatch" || var8.agent_type == "slasher" || var8.agent_type == "superslasher" || var8.agent_type == "zombie_brute" || var8.agent_type == "zombie_grey" || var8.agent_type == "zombie_clown")) {
      continue;
    }

    var8 playSound("zmb_fnf_second_wind_push");
    var9 = 0;
    var10 = var8.origin;
    var11 = var8.maxhealth;
    var2 = anglesToForward(self.angles);
    var12 = vectorNormalize(var2) * -100;
    var8 setvelocity(vectorNormalize(var8.origin - self.origin + var12) * 800 + (0, 0, 300));
    killrepulsorvictim(var8, self, var11, var10, self.origin);
  }
}

function killrepulsorvictim(var0, var1, var2, var3) {
  self.do_immediate_ragdoll = 1;

  if(var1 >= self.health) {
    self.customdeath = 1;
  }

  self dodamage(var1, var2, var0, var0, "MOD_IMPACT", "zom_repulsor_mp");
}

function select_random_vector_in_radius(var0, var1, var2) {
  var3 = [];
  var4 = var0.origin;
  var5 = (0, 128, 0);
  var6 = var0 getplayerangles();
  var7 = 7;
  var8 = 0;
  var4 += var5[0] * anglestoright(var6);
  var4 += var5[1] * anglesToForward(var6);
  var4 += var5[2] * anglestoup(var6);
  var9 = rotatepointaroundvector(anglestoup(var6), anglesToForward(var6), var7);
  var10 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var11 = scripts\engine\trace::ray_trace(var0 getEye(), var4 + var9, var0, var10);
  var4 = scripts\engine\utility::drop_to_ground(var11["position"] + var9 * -18, 32, -2000);
  var12 = 0;

  foreach(var14 in var2) {
    if(scripts\engine\utility::within_fov(self getEye(), self.angles, var14.origin, cos(65))) {
      if(distance2dsquared(self.origin, var14.origin) < 1000000) {
        if(var12 <= 5) {
          self.closestenemies_array[var15] = var14;
          var3 = var14.origin;
          var12++;
          continue;
        }

        break;
      }
    }
  }

  var3 = getrandomnavpoints(var0.origin, var1, 5, undefined, var4, 1200);
  return var3;
}

function torrent_start(var0, var1, var2, var3, var4) {
  self endon("death");
  level endon("game_ended");

  if(var3 == 0 || var3 == 3 || var3 == 6) {
    playsoundatpos(var1, "zmb_fnf_timely_torrent_lava");
  }

  playFX(level._effect["lava_torrent"], self.origin, undefined, anglestoup((0, 0, 90)));

  foreach(var6 in var2) {
    var7 = (var6.origin[0], var6.origin[1], 90);

    if(isDefined(var6.flung) || isDefined(var6.agent_type) && (var6.agent_type == "zombie_brute" || var6.agent_type == "zombie_ghost" || var6.agent_type == "zombie_grey" || var6.agent_type == "slasher" || var6.agent_type == "superslasher")) {
      continue;
    }

    if(distancesquared(var6.origin, var1) < 5184) {
      var6.flung = 1;
      var6.do_immediate_ragdoll = 1;
      var6.disable_armor = 1;
      var6 setsolid(0);
      var6 setvelocity((0, 0, 600));
      wait 0.1;

      if(isDefined(var6)) {
        var6 dodamage(10000, var1, var4, var4, "MOD_EXPLOSIVE");
      }
    }
  }

  self delete();
}

function use_timely_torrent(var0) {
  self endon("disconnect");
  self endon(var0 + "_timeup");
  level endon("game_ended");
  thread run_timely_torrent(var0);
}

function select_spot_array(var0, var1) {
  if(!isDefined(var0.array_of_torrent_points)) {
    var0.array_of_torrent_points = [];
  }

  var2 = var0.origin;
  var3 = (0, 128, 0);
  var4 = var0 getplayerangles();
  var5 = 7;
  var6 = 0;
  var2 += var3[0] * anglestoright(var4);
  var2 += var3[1] * anglesToForward(var4);
  var2 += var3[2] * anglestoup(var4);
  var7 = rotatepointaroundvector(anglestoup(var4), anglesToForward(var4), 0);
  var8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var9 = scripts\engine\trace::ray_trace(var0 getEye(), var2 + var7, var0, var8);
  var2 = var9["position"] + var7;

  if(var1 == 0) {
    var0.array_of_torrent_points[var1] = var2 + anglesToForward(var4) * 60;
  } else {
    var0.array_of_torrent_points[var1] = var2 + anglesToForward(var4) * (var1 + 1) * 60;
  }

  return var0.array_of_torrent_points;
}

function run_timely_torrent(var0) {
  self endon(var0 + "_timeup");
  self endon("disconnect");
  level endon("game_ended");
  var1 = [];
  var2 = 0;

  for(;;) {
    self waittill("melee_fired");

    for(var3 = 0; var3 <= 5; var3++) {
      var1 = select_spot_array(self, var3);
    }

    var4 = 1200;
    self.closestenemies_array = [];
    var5 = scripts\cp\cp_agent_utils::get_alive_enemies();

    foreach(var8, var7 in var1) {
      var1 = spawn("script_origin", var7);
    }

    foreach(var7 in var1) {
      if(!isDefined(var7)) {
        continue;
      }

      thread torrent_start(var7, var0, var7.origin, var5, var8);
    }

    scripts\cp\utility::notify_used_consumable("timely_torrent");
  }
}

function use_purify(var0) {
  self endon("disconnect");
  self endon(var0 + "_timeup");
  self endon(var0 + "_exited_early");
  level endon("game_ended");

  foreach(var2 in level.players) {
    if(var2 scripts\cp\utility::is_valid_player()) {
      thread purify_activate(var2, var0, var2);
    }
  }

  return true;
}

function purify_activate(var0, var1, var2) {
  level endon("game_ended");
  var1 notify("force_regeneration");
  var3 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, 24, 99999, 0);

  foreach(var1 in var3) {
    thread dealaoedamage(var1);
    wait 0.5;
  }

  var2 scripts\cp\utility::notify_used_consumable("purify");
}

function dealaoedamage(var0) {
  self endon("disconnect");
  level endon("game_ended");
  var1 = scripts\cp\cp_agent_utils::get_alive_enemies();
  var2 = scripts\engine\utility::get_array_of_closest(self.origin, var1, undefined, 24, 128, 0);

  if(var2.size > 0) {
    self notify("force_regeneration");

    foreach(var4 in var2) {
      if(isDefined(var4.agent_type) && (var4.agent_type == "zombie_brute" || var4.agent_type == "zombie_ghost" || var4.agent_type == "zombie_grey" || var4.agent_type == "slasher" || var4.agent_type == "superslasher")) {
        continue;
      }

      playFX(level._effect["penetration_railgun_explosion"], self.origin);
      var4 dodamage(var4.health + 100, var4.origin, self, self, "MOD_EXPLOSIVE", "iw7_explosive_touch_zm");
    }

    self playSound("zmb_fnf_purify_explo");
    return;
  }
}

function calcfrontposbasedonvelocity(var0) {
  var1 = (0, 0, 0);
  var2 = self.origin + var1;
  var3 = anglesToForward(self.angles);
  var4 = anglestoright(self.angles);
  var5 = self getvelocity();
  var6 = vectordot(var5, self.angles);
  var7 = length(var5);

  if(var7 < 64) {
    var7 = 64;
  }

  if(var7 > 64 && var7 < 128) {
    var7 = 92;
  }

  if(var7 > 350) {
    var7 = 500;
  }

  if(var7 > 200) {
    var7 = 256;
  }

  if(var7 > 128) {
    var7 = 164;
  }

  if(var6 < 1) {
    var7 = 64;
  }

  if(isDefined(var0)) {
    var7 = var0;
  }

  return var2 + var3 * var7;
}

function watchmelee() {
  self endon("death");
  self endon("disconnect");
  self endon("removeReaper");
  level endon("game_ended");
  var0 = (0, 0, 32);

  for(;;) {
    scripts\engine\utility::ref_143a6("melee_fired", "ads_in", "ads_out");
    var1 = self.origin + var0;
    var2 = anglesToForward(self.angles);
    var3 = anglestoright(self.angles);
    self playRumbleOnEntity("damage_light");
    earthquake(0.2, 0.1, self.origin, 32);
    var4 = calcfrontposbasedonvelocity();
    var4 += var0;
    var5 = var1 + var3 * 64;
    var6 = var1 - var3 * 32;
    var7 = rotatevector(var3, (0, 45, 0));
    var8 = var1 + var7 * 64;
    var9 = rotatevector(var3, (0, 135, 0));
    var10 = var1 + var9 * 32;
    var11 = gettime();
    self.meleeorigin.origin = var5;
    wait 0.05;
    playFXOnTag(level._effect["swipe_trail"], self.meleeorigin, "tag_origin");
    wait 0.05;
    self.meleeorigin.origin = var8;
    wait 0.05;
    self.meleeorigin.origin = var4;
    thread applyradiusdamageasmelee(var4);
    wait 0.05;
    self.meleeorigin.origin = var10;
    wait 0.05;
    self.meleeorigin.origin = var6;
    wait 0.05;
    stopFXOnTag(level._effect["swipe_trail"], self.meleeorigin, "tag_origin");
  }
}

function applyradiusdamageasmelee(var0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeReaper");
  level endon("game_ended");
  var1 = distance2d(self.origin, var0) / 2;
  self radiusdamage(self.origin, var1, 600, 300, self, "MOD_MELEE", "iw7_reaperblade_mp");
}

function use_masochist(var0) {
  self endon("disconnect");
  self endon(var0 + "_timeup");
  self endon(var0 + "_exited_early");
  level endon("game_ended");
  thread removeslowmoveonlaststand(var0);

  for(;;) {
    self waittill("player_damaged");
    scripts\cp\cp_persistence::give_player_currency(100, undefined, undefined, 1, "bonus");
  }
}

function use_explosive_touch(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var0 + "_exited_early");
  self endon(var0 + "_timeup");
  thread remove_explosive_touch(var0);

  for(;;) {
    if(!istrue(self.has_explosive_touch)) {
      self.has_explosive_touch = 1;
      thread watch_for_zombie_touch(var0);
      scripts\cp\utility::adddamagemodifier("health_boost", 0.1, 0);
      self notify("force_regeneration");
      self playlocalsound("breathing_heartbeat_alt");
    }

    waitframe();
  }
}

function watch_for_zombie_touch(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var0 + "_exited_early");
  self endon(var0 + "_timeup");

  while(istrue(self.has_explosive_touch)) {
    var1 = scripts\cp\cp_agent_utils::get_alive_enemies();

    foreach(var3 in var1) {
      if(scripts\engine\utility::distance_2d_squared(var3.origin, self.origin) <= 5184) {
        var3.exp_touch = 1;

        if(var3 scripts\cp\utility::agentisfnfimmune()) {
          continue;
        }

        if(var3 scripts\cp\utility::is_zombie_agent() && !istrue(var3.is_skeleton) && var3.agent_type != "slasher" && var3.agent_type != "superslasher" && var3.agent_type != "zombie_brute" && var3.agent_type != "zombie_grey") {
          var3.nocorpse = 1;
          var3.full_gib = 1;
          playsoundatpos(var3 gettagorigin("j_spineupper"), "zmb_fnf_explosive_touch_explo");
          wait 0.1;
          playFX(scripts\engine\utility::getfx("exp_touch"), var3 gettagorigin("j_spineupper"));
          self radiusdamage(self.origin, 100, var3.maxhealth, 1000, self, "MOD_EXPLOSIVE", "iw7_explosive_touch_zm");
          wait 0.3;
        }
      }
    }

    waitframe();
  }
}

function remove_explosive_touch(var0) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::ref_143a5(var0 + "_timeup", var0 + "_exited_early");
  self.has_explosive_touch = 0;
  scripts\cp\utility::removedamagemodifier("health_boost", 0);

  if(isDefined(self.explosivetrigger)) {
    self.explosivetrigger delete();
    return;
  }
}

function use_shared_fate(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var0 + "_exited_early");
  self endon(var0 + "_timeup");
  self.marked_ents = [];
  thread look_at_and_outline_enemies(var0);
  thread outline_enemeies(var0);
  thread damage_on_marked_enemies(var0);
}

function damage_on_marked_enemies(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var0 + "_exited_early");
  self endon(var0 + "_timeup");

  for(;;) {
    self waittill("weapon_hit_marked_target", var1, var2, var3, var4, var5);
    self.marked_ents = scripts\engine\utility::array_removeundefined(self.marked_ents);
    self.marked_ents = scripts\engine\utility::array_remove(self.marked_ents, var5);

    foreach(var7 in self.marked_ents) {
      if(var5 == var7) {
        continue;
      }

      if(var7.health >= var7.maxhealth) {
        var7 setscriptablepartstate("shared_fate_fx", "inactive", 1);
      }

      self.marked_ents = scripts\engine\utility::array_remove(self.marked_ents, var7);
      var7 dodamage(var2, var7.origin, var1, var1, var3, "iw7_shared_fate_weapon");
    }
  }
}

function play_vfx_between_points_marked(var0, var1, var2) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var0 + "_exited_early");
  self endon(var0 + "_timeup");
  var3 = undefined;
  var4 = undefined;

  if(isDefined(var1)) {
    var3 = spawnfx(scripts\engine\utility::getfx("ufo_elec_beam_impact"), var1);
    triggerfx(var3);
  }

  if(isDefined(var2)) {
    var4 = spawnfx(scripts\engine\utility::getfx("ufo_elec_beam_impact"), var2);
    triggerfx(var4);
  }

  wait 3;

  if(isDefined(var3)) {
    var3 delete();
  }

  if(isDefined(var4)) {
    var4 delete();
    return;
  }
}

function deletevfx(var0) {
  scripts\engine\utility::ref_143a5(var0 + "_exited_early", var0 + "_timeup");
}

function outline_enemeies(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var0 + "_exited_early");
  self endon(var0 + "_timeup");

  for(;;) {
    foreach(var2 in self.marked_ents) {
      if(var2 scripts\cp\utility::agentisfnfimmune()) {
        continue;
      }

      if(isDefined(var2.agent_type) && (var2.agent_type == "zombie_sasquatch" || var2.agent_type == "slasher" || var2.agent_type == "superslasher" || var2.agent_type == "zombie_brute" || var2.agent_type == "zombie_grey" || var2.agent_type == "zombie_clown" || var2.agent_type == "skater")) {
        continue;
      }

      if(scripts\cp\utility::is_melee_weapon(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc_melee(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc2_melee(self getcurrentweapon())) {
        waitframe();
        continue;
      }

      if(istrue(var2.marked_shared_fate_fnf)) {
        var2 setscriptablepartstate("shared_fate_fx", "active", 1);
        continue;
      }

      if(isDefined(var2)) {
        var2 setscriptablepartstate("shared_fate_fx", "inactive", 1);
      }
    }

    waitframe();
  }
}

function look_at_and_outline_enemies(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var0 + "_exited_early");
  self endon(var0 + "_timeup");
  var1 = 0;

  for(;;) {
    if(self adsButtonPressed() && !var1) {
      if(scripts\cp\utility::is_melee_weapon(self getcurrentweapon()) || scripts\cp\utility::weapon_is_dlc_melee(self getcurrentweapon())) {
        waitframe();
        continue;
      }

      var1 = 1;
      var2 = self getplayerangles();
      var3 = self getEye();
      var4 = anglesToForward(var2);
      var5 = var3 + var4 * 500;
      var6 = scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 0, 0);
      var7 = physics_raycast(var3, var5, var6, self, 0, "physicsquery_closest");

      if(var7.size <= 0) {
        waitframe();
        continue;
      }

      var8 = var7[0]["entity"];

      if(isDefined(var8)) {
        if(isDefined(var8.agent_type) && (var8.agent_type == "zombie_sasquatch" || var8.agent_type == "slasher" || var8.agent_type == "superslasher" || var8.agent_type == "zombie_brute" || var8.agent_type == "zombie_grey" || var8.agent_type == "zombie_clown")) {
          continue;
        }

        if(var8 scripts\cp\utility::is_zombie_agent()) {
          if(!scripts\engine\utility::array_contains(self.marked_ents, var8)) {
            self playlocalsound("zmb_fnf_shared_fate_highlight");
            var8.marked_shared_fate_fnf = 1;
            self.marked_ents = scripts\engine\utility::array_add(self.marked_ents, var8);
          }
        }
      }

      var1 = 0;
    } else {
      var1 = 0;
    }

    waitframe();
  }
}

function use_fire_chains(var0) {
  self endon(var0 + "_timeup");
  self endon("last_stand");
  self endon("disconnect");
  level endon("game_ended");
  self.life_link_active = undefined;
  self.life_linked = 1;
  var1 = "j_spine4";
  var2 = ["j_spine4", "j_spineupper", "j_spinelower", "j_head", "j_knee_ri", "j_knee_le", "j_elbow_ri", "j_elbow_le", "j_ankle_le", "j_ankle_ri", "j_wrist_le", "j_wrist_ri"];
  thread removefirechainsdamagemodifierontimeout(var0);
  thread removefirechainsdamagemodifieronlaststand(var0);
  var3 = self;

  for(;;) {
    var4 = getfirechainstarget(self);

    if(isDefined(var4)) {
      self.besttarget = var4;
      self.linked_to_player = 1;
      thread playfirechainsfx(var4, var1, var0);
      var3.life_link_active = 1;
      linktoplayer_fire_chains(self, var4, var2);
    } else {
      var3.life_link_active = undefined;
      wait 0.5;
    }

    waitframe();
  }
}

function getfirechainstarget(var0) {
  var1 = scripts\engine\utility::get_array_of_closest(var0.origin, level.players, [var0], 4, 512);
  var2 = sortbydistance(var1, var0.origin);
  var3 = undefined;

  foreach(var5 in var2) {
    var6 = sighttracepassed(var0 getEye(), var5 getEye(), 0, var0);

    if(!var6) {
      continue;
    }

    if(istrue(var5.inlaststand)) {
      continue;
    }

    var3 = var5;
    break;
  }

  return var3;
}

function linktoplayer_fire_chains(var0, var1, var2) {
  while(istrue(var0.linked_to_player)) {
    thread deal_damage_to_zombies_entering_the_link(self, var2);

    if(istrue(var1.inlaststand)) {
      var0.linked_to_player = undefined;
      var0 notify("lost_target_fire_chains");
      break;
    } else if(distance(var0.origin, var1.origin) > 512) {
      var0.linked_to_player = undefined;
      var0 notify("lost_target_fire_chains");
      break;
    }

    waitframe();
  }
}

function deal_damage_to_zombies_entering_the_link(var0, var1) {
  var2 = [];
  var3 = scripts\engine\trace::create_character_contents();
  var2 = [var0, var0.besttarget];

  foreach(var5 in var1) {
    var6 = scripts\engine\trace::ray_trace(var0 gettagorigin(var5), var0.besttarget gettagorigin(var5), var2, var3);

    if(isDefined(var6["entity"])) {
      if(var6["entity"] scripts\cp\utility::is_zombie_agent() && !istrue(var6["entity"].is_skeleton) && var6["entity"].agent_type != "slasher" && var6["entity"].agent_type != "superslasher" && var6["entity"].agent_type != "zombie_brute" && var6["entity"].agent_type != "zombie_grey") {
        scripts\engine\utility::array_add(var2, var6["entity"]);
        var6["entity"].nocorpse = 1;
        var6["entity"].full_gib = 1;
        var6["entity"] dodamage(1000000, var6["entity"].origin, var0, var0);
      }
    }
  }
}

function playfirechainsfx(var0, var1, var2) {
  var3 = [];

  foreach(var5 in level.players) {
    var3 = playfxontagsbetweenclients(level._effect["fire_chains"], self, var1, var0, var1, var5);
  }

  self.fx_array_fire_chains = var3;
  self playLoopSound("zmb_fnf_fire_chains_lp");
  var0 playLoopSound("zmb_fnf_fire_chains_lp");
  var7 = scripts\engine\utility::waittill_any_ents_return(self, "disconnect", self, "lost_target_fire_chains", self, "last_stand", self, var2 + "_timeup", var0, "disconnect", var0, "last_stand", level, "game_ended");

  if(isDefined(self)) {
    self stoploopsound();
  }

  if(isDefined(var0)) {
    var0 stoploopsound();
  }

  foreach(var9 in var3) {
    if(isDefined(var9)) {
      var9 delete();
    }
  }
}

function removefirechainsdamagemodifieronlaststand(var0) {
  self endon(var0 + "_timeup");
  self waittill("last_stand");
  self.life_linked = undefined;
  self.life_link_active = undefined;

  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
  }

  self notify(var0 + "_exited_early");
}

function removefirechainsdamagemodifierontimeout(var0) {
  self endon("last_stand");
  self waittill(var0 + "_timeup");
  self.life_linked = undefined;
  self.life_link_active = undefined;

  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
    return;
  }
}

function use_irish_luck(var0) {
  self endon(var0 + "_timeup");
  self endon("last_stand");
  self endon("disconnect");
  level endon("game_ended");
}

function irish_luck_choose_random_consumable(var0) {
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var0.stored_fnf)) {
    var0.stored_fnf = [];
  }

  foreach(var2 in var0.consumables) {
    var0.stored_fnf[var3] = var3;
  }

  for(;;) {
    var4 = scripts\engine\utility::random(level.irish_luck_consumables);

    if(scripts\engine\utility::array_contains(var0.stored_fnf, var4.name)) {
      waitframe();
      continue;
    } else {
      waitframe();
      return var4;
    }

    waitframe();
  }
}

function clear_omnvar(var0) {
  wait 5;
  self setclientomnvar(var0, 0);
}

function consumable_activate_internal_irish(var0, var1, var2, var3, var4, var5, var6) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("dpad_end_" + var0);
  self endon("give_new_deck");
  self endon("last_stand");
  level.random_consumable_chosen = irish_luck_choose_random_consumable(self);

  if(self.consumables[var0].uses > 0 && self.consumables[var0].on == 0 && !scripts\cp\cp_laststand::player_in_laststand(self)) {
    self.consumables[level.random_consumable_chosen.name] = spawnStruct();
    self.consumables[level.random_consumable_chosen.name].uses = level.consumables[level.random_consumable_chosen.name].uses;
    self.consumables[level.random_consumable_chosen.name].on = 1;
    self.consumables[level.random_consumable_chosen.name].times_used = 0;
    self.consumables[level.random_consumable_chosen.name].usednotify = var4;
    level.random_consumable_chosen.ref = int(tablelookup("cp/loot/iw7_zombiefatefortune_loot_master.csv", 1, level.random_consumable_chosen.name, 0));
    self setclientomnvar("zm_fate_card_used", var5);
    self.consumables[var0].processing = 1;
    var7 = undefined;
    var8 = "fired_super";
    thread set_consumable(var0);

    if(isDefined(level.consumables[level.random_consumable_chosen.name].usefunc)) {
      if(isDefined(level.consumables[level.random_consumable_chosen.name].testforsuccess)) {
        var7 = self[[level.consumables[level.random_consumable_chosen.name].usefunc]](level.random_consumable_chosen.name);
      } else {
        var7 = self thread[[level.consumables[level.random_consumable_chosen.name].usefunc]](level.random_consumable_chosen.name);
      }
    }

    self.consumables[var0].on = 0;

    if(!isDefined(var7) || isDefined(var7) && var7) {
      consume_from_inventory(self, var0);
      self.consumables[var0].times_used++;
      scripts\cp\cp_merits::processmerit("mt_faf_uses");
      thread scripts\cp\cp_vo::try_to_play_vo("wonder_consume", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);

      if(self.consumables[var0].times_used == 1) {
        thread decrement_counter_of_consumables(var0);
      }

      thread lightbar_off();
      self setclientomnvarbit("zm_card_fill_display", var5, 1);
      remove_card_from_use(var6);
      thread meter_fill_up();
      self playlocalsound("ui_consumable_select");
      play_consumable_activate_sound(self);
      self notify("consumable_selected");
      self setweaponammostock(self.fate_card_weapon, 1);
      self giveandfireoffhand(self.fate_card_weapon);
      self.consumable_meter_full = undefined;
      level thread scripts\cp\cp_vo::remove_from_nag_vo("nag_use_fateandfort");
      var9 = level.consumables[level.random_consumable_chosen.name].type;

      if(var9 == "timedactivations") {
        thread dpad_drain_time(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].usageperiod, var1, var8, var2, var3, var4, var5);
      } else if(var9 == "wave") {
        thread dpad_drain_wave(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].usageperiod, var1, var8, var2, var3, var4, var5);
      } else if(var9 == "triggernow" || level.consumables[level.random_consumable_chosen.name].type == "triggerwait") {
        thread dpad_drain_activations(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].type, self.consumables[level.random_consumable_chosen.name].uses, var1, var8, var2, var3, var4, var5);
      } else if(var9 == "triggerpassive") {
        thread dpad_drain_triggerpassive(level.random_consumable_chosen.name, level.consumables[level.random_consumable_chosen.name].passiveuses, var1, var8, var2, var3, var4, var5);
      }

      if(isDefined(var7)) {
        scripts\cp\utility::notify_used_consumable(var0);
        return;
      }

      return;
    }

    self playlocalsound("ui_consumable_deny");
    self.consumables[var0].processing = undefined;
    return;
  }
}

function use_temporal_increase(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var0 + "_exited_early");
  self endon(var0 + "_timeup");
  self endon("last_stand");
  self.temporal_increase = 2;
  thread remove_temporal_increase(var0);
}

function remove_temporal_increase(var0) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::ref_143a7(var0 + "_timeup", "disconnect", "death", var0 + "_exited_early");
  self.temporal_increase = undefined;
  return true;
}

function use_twister(var0) {
  self endon("disconnect");
  self endon(var0 + "_timeup");
  self endon(var0 + "_exited_early");
  self endon("death");
  self endon("last_stand");
  level endon("game_ended");
  var1 = self getplayerangles();
  var2 = self getEye();
  var3 = (0, 0, 0);
  var4 = anglesToForward(var1);
  var5 = var2 + var4 * 100;
  thread remove_twister(var0, self);
  thread activate_twister_homing(self.origin, var0);
}

function remove_twister(var0, var1) {
  self endon("disconnect");
  level endon("game_ended");
  var1 scripts\engine\utility::ref_143a7(var0 + "_timeup", var0 + "_exited_early", "last_stand", "death");
  level notify("stop_twister_sfx");

  if(isDefined(var1.fx_ent)) {
    var1.fx_ent delete();
  }

  if(isDefined(var1.trigger_move_ent)) {
    var1.trigger_move_ent delete();
    return;
  }
}

function activate_twister_homing(var0, var1) {
  self endon("disconnect");
  self endon(var1 + "_timeup");
  self endon(var1 + "_exited_early");
  level endon("game_ended");
  self endon("death");
  self endon("last_stand");

  if(!isDefined(self.twister_array_zombie)) {
    self.twister_array_zombie = [];
  }

  self.trigger_move_ent = spawn("script_model", var0, 0, 512, 128);
  self.trigger_move_ent setModel("tag_origin");
  level.trigger_move_ent_sfx = spawn("script_model", var0, 0, 512, 128);
  level.trigger_move_ent_sfx linkTo(self.trigger_move_ent);
  wait 0.5;
  thread twister_sfx();
  playFXOnTag(level._effect["twister"], self.trigger_move_ent, "tag_origin");
  self.trigger_move_ent setotherent(self);
  thread deal_damage_to_enemies(self.trigger_move_ent, self);
  thread move_ent_function(self.trigger_move_ent, var1);
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

function get_zombie_targets(var0, var1) {
  var0 endon("disconnect");
  var0 endon(var1 + "_timeup");
  var0 endon(var1 + "_exited_early");
  level endon("game_ended");
  var0 endon("death");
  var0 endon("last_stand");

  for(;;) {
    var2 = scripts\cp\cp_agent_utils::get_alive_enemies();
    var3 = scripts\engine\utility::get_array_of_closest(var0.origin, var2, undefined, 24, 2048);

    if(var3.size <= 0) {
      waitframe();
      var0.twister_array_zombie = [];
      var0.twister_array_zombie[var0.twister_array_zombie.size] = getclosestpointonnavmesh(self.origin) + (0, 10, 0);
      continue;
    } else {
      foreach(var5 in var3) {
        if(istrue(var5.entered_playspace)) {
          var0.twister_array_zombie = var0 findpath(var0.origin, scripts\engine\utility::drop_to_ground(var3[var3.size - 1].origin, 1, 1));
        }
      }
    }

    wait 2.5;
  }
}

function deal_damage_to_enemies(var0, var1) {
  var0 endon("death");
  var0 endon("last_stand");
  self endon("death");
  var0 endon("disconnect");
  var0 endon(var1 + "_timeup");
  var0 endon(var1 + "_exited_early");
  level endon("game_ended");

  for(;;) {
    var2 = scripts\cp\cp_agent_utils::get_alive_enemies();

    foreach(var4 in var2) {
      if(!isDefined(var4)) {
        continue;
      }

      if(!var4 scripts\cp\utility::is_zombie_agent()) {
        continue;
      }

      if(var4 scripts\cp\utility::agentisfnfimmune()) {
        continue;
      }

      if(distance2dsquared(self.origin, var4.origin) < 22500) {
        if(isDefined(var4.agent_type) && (var4.agent_type == "slasher" || var4.agent_type == "superslasher")) {
          var4 dodamage(1000, var4.origin, var0, var0, "MOD_UNKNOWN");
          continue;
        }

        thread fling_zombie_thundergun_harpoon(var4, var4.health + 1000, var4, var0);
      }
    }

    wait 1;
  }
}

function fling_zombie_thundergun_harpoon(var0, var1, var2, var3) {
  self endon("death");
  var3 endon("death");

  if(!isDefined(var3)) {
    return;
  }

  var4 = var1.origin - var3.origin;
  var5 = anglestoup(self.angles);
  self setvelocity(vectorNormalize((var3.origin - self.origin) * 400) + (0, 0, 800));
  wait 0.16;

  if(isDefined(var2)) {
    var1.do_immediate_ragdoll = 1;
    var1.disable_armor = 1;
    var1.customdeath = 1;
    wait 0.1;
    var1.nocorpse = 1;
    var1.full_gib = 1;
    self dodamage(self.health + 1000, var1.origin, var2, var2, "MOD_UNKNOWN", "iw7_twister_zm");
    return;
  }

  self.nocorpse = 1;
  self.full_gib = 1;
  self dodamage(self.health + 1000, var1.origin, var1, var1, "MOD_UNKNOWN", "iw7_twister_zm");
}

function move_ent_function(var0, var1) {
  self endon("death");
  self endon("last_stand");
  self endon("disconnect");
  self endon(var1 + "_timeup");
  self endon(var1 + "_exited_early");
  var2 = 0;
  thread get_zombie_targets(self, var1);

  for(;;) {
    if(!isDefined(self.twister_array_zombie[var2]) && var2 >= self.twister_array_zombie.size) {
      if(self.twister_array_zombie.size > 0) {
        if(isDefined(self.twister_array_zombie[0])) {
          if([[level.active_volume_check]](self.twister_array_zombie[0])) {
            var0 moveTo(self.twister_array_zombie[0], 0.5, 0.25, 0);
          } else {
            var3 = getclosestpointonnavmesh(self.twister_array_zombie[0]) + (0, 10, 0);
            var0 moveTo(var3, 0.5, 0.25, 0);
          }

          var2--;
        }
      } else {
        var2 = 0;
      }

      waitframe();
      continue;
    } else {
      var0 moveTo(self.twister_array_zombie[var2], 0.5, 0, 0);
    }

    var2 += 1;
    waitframe();
  }
}

function use_self_revive(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var0 + "_exited_early");
  scripts\cp\cp_laststand::enable_self_revive(self);
  thread removeselfreviveonearlyexit(var0);

  for(;;) {
    self waittill("player_has_self_revive", var1);

    if(var1) {
      continue;
    }

    self waittill("revive");
    scripts\cp\cp_laststand::disable_self_revive(self);

    if(scripts\cp\utility::has_zombie_perk("perk_machine_tough")) {
      self.maxhealth = 200;
      self.health = self.maxhealth;
    }

    scripts\cp\utility::notify_used_consumable(var0);
    break;
  }
}

function removeselfreviveonearlyexit(var0) {
  self endon(var0 + " activated");
  self endon("disconnect");
  level endon("game_ended");
  self waittill(var0 + "_exited_early");
  scripts\cp\cp_laststand::disable_self_revive(self);
}

function use_welfare(var0) {
  self endon("disconnect");
  level endon("game_ended");
  var1 = scripts\cp\cp_persistence::get_player_currency();
  var2 = int(var1 / level.players.size);
  scripts\cp\cp_persistence::set_player_currency(var2);

  foreach(var4 in level.players) {
    if(var4 == self) {
      continue;
    }

    var4 scripts\cp\cp_persistence::give_player_currency(var2, undefined, undefined, 1, "bonus");
  }

  scripts\cp\utility::notify_used_consumable(var0);
  return true;
}

function use_increased_team_efficiency(var0) {
  self endon(var0 + "_timeup");
  self endon("disconnect");
  self endon("last_stand");
  self endon("death");

  if(!isDefined(level.consumable_cash_scalar)) {
    level.consumable_cash_scalar = 0;
  }

  thread update_team_multiplier(var0);
  thread cleanupaftertimeoutordeath(var0);
  setomnvar("zom_escape_combo_multiplier", 1);

  for(;;) {
    var1 = scripts\engine\utility::ref_143ad("shot_missed", "weapon_hit_enemy");

    if(var1 == "shot_missed") {
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

function update_team_multiplier(var0) {
  while(isDefined(level.consumable_cash_scalar)) {
    self waittill("update_team_efficiency");
    var1 = 1 + level.consumable_cash_scalar;
    setomnvar("zom_escape_combo_multiplier", var1);
  }

  setomnvar("zom_escape_combo_multiplier", -1);
}

function cleanupaftertimeoutordeath(var0) {
  var1 = scripts\engine\utility::ref_143af(var0 + "_timeup", "disconnect", "last_stand", "death");
  level.consumable_cash_scalar = undefined;
}

function use_slow_enemy_movement(var0) {
  self endon(var0 + "_timeup");
  self endon("disconnect");
  thread removeslowmoveonlaststand(var0);

  foreach(var2 in scripts\cp\cp_agent_utils::getaliveagentsofteam("axis")) {
    thread adjustmovespeed(var2, var2, var0);
  }

  for(;;) {
    level waittill("agent_spawned", var4);
    thread adjustmovespeed(var4, var4, var0, self);
  }
}

function adjustmovespeed(var0, var1, var2, var3) {
  var0 endon("death");

  if(isDefined(var0.agent_type) && (var0.agent_type == "zombie_brute" || var0.agent_type == "zombie_grey" || var0.agent_type == "zombie_ghost")) {
    return;
  }

  if(istrue(var0.is_suicide_bomber)) {
    return;
  }

  if(istrue(var3)) {
    wait 0.5;
  }

  if(!isDefined(var0.asm.cur_move_mode)) {
    var4 = var0.movemode;
  } else {
    var4 = var1.asm.cur_move_mode;
  }

  switch (var4) {
    case "slow_walk":
      break;
    case "walk":
    case "run":
    case "sprint":
      var1 scripts\asm\asm_bb::bb_requestmovetype("slow_walk");
      break;
  }

  var3 scripts\engine\utility::ref_143a6(var2 + "_timeup", "last_stand", "disconnect");
  var1 scripts\asm\asm_bb::bb_requestmovetype(var4);
}

function removeslowmoveonlaststand(var0) {
  self endon(var0 + "_timeup");
  self waittill("last_stand");
  self notify(var0 + "_exited_early");
}

function use_life_link(var0) {
  self endon(var0 + "_timeup");
  self endon("last_stand");
  self endon("disconnect");
  level endon("game_ended");
  self.life_link_active = undefined;
  self.life_linked = 1;
  var1 = "j_spine4";
  thread removedamagemodifierontimeout(var0);
  thread removedamagemodifieronlaststand(var0);
  var2 = self;

  for(;;) {
    var3 = getlifelinktarget(self);

    if(isDefined(var3)) {
      self notify("lost_target", var3);
      self.linked_to_player = 1;
      thread playlifelinkfx(var3, var1, var0);
      var2.life_link_active = 1;
      linktoplayer(self, var3);
      continue;
    }

    var2.life_link_active = undefined;
    wait 0.5;
  }
}

function getlifelinktarget(var0) {
  var1 = scripts\engine\utility::get_array_of_closest(var0.origin, level.players, [var0], 4, 512);
  var2 = sortbydistance(var1, var0.origin);
  var3 = undefined;

  foreach(var5 in var2) {
    var6 = sighttracepassed(var0 getEye(), var5 getEye(), 0, var0);

    if(!var6) {
      continue;
    }

    if(istrue(var5.inlaststand)) {
      continue;
    }

    var3 = var5;
    break;
  }

  return var3;
}

function linktoplayer(var0, var1) {
  var0 endon("disconnect");

  while(istrue(var0.linked_to_player)) {
    if(istrue(var1.inlaststand)) {
      var0.linked_to_player = undefined;
      var0 notify("lost_target");
      break;
    } else if(distance(var0.origin, var1.origin) > 512) {
      var0.linked_to_player = undefined;
      var0 notify("lost_target");
      break;
    } else {
      var2 = sighttracepassed(var0 getEye(), var1 getEye(), 0, var0);

      if(!var2) {
        var0.linked_to_player = undefined;
        var0 notify("lost_target");
      }
    }

    wait 0.25;
  }
}

function playlifelinkfx(var0, var1, var2) {
  var0 endon("disconnect");
  self endon("disconnect");
  var3 = [];
  playFXOnTag(level._effect["life_link_target"], var0, var1);

  foreach(var5 in level.players) {
    var3 = playfxontagsbetweenclients(level._effect["life_link"], self, var1, var0, var1, var5);
  }

  self playLoopSound("zmb_fnf_lifelink_heal_lp");
  var0 playLoopSound("zmb_fnf_lifelink_heal_lp");
  var7 = scripts\engine\utility::waittill_any_ents_return(self, "disconnect", self, "lost_target", self, "last_stand", self, var2 + "_timeup", var0, "disconnect", var0, "last_stand", level, "game_ended");

  if(isDefined(self)) {
    self stoploopsound();
  }

  if(isDefined(var0)) {
    var0 stoploopsound();
  }

  foreach(var9 in var3) {
    if(isDefined(var9)) {
      var9 delete();
    }
  }

  if(isDefined(var0)) {
    killfxontag(level._effect["life_link_target"], var0, var1);
    return;
  }
}

function removedamagemodifieronlaststand(var0) {
  self endon(var0 + "_timeup");
  self waittill("last_stand");
  self.life_linked = undefined;
  self.life_link_active = undefined;

  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
  }

  self notify(var0 + "_exited_early");
}

function removedamagemodifierontimeout(var0) {
  self endon("last_stand");
  self waittill(var0 + "_timeup");
  self.life_linked = undefined;
  self.life_link_active = undefined;

  if(isDefined(self.linked_to_player)) {
    self.linked_to_player = undefined;
    return;
  }
}

function use_phoenix_up(var0) {
  var1 = level.players;
  var2 = 0;

  foreach(var4 in var1) {
    var5 = var4;

    if(isDefined(var4.owner)) {
      var5 = var4.owner;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var5)) {
      var2 = 1;
      scripts\cp\cp_laststand::instant_revive(var5);
      scripts\cp\cp_laststand::record_revive_success(self, var5);
    }
  }

  if(!var2) {
    self.consumables["phoenix_up"].on = 0;
    waitframe();
    return false;
  }

  wait 0.25;
  scripts\cp\utility::notify_used_consumable("phoenix_up");
  return true;
}

function use_killing_time(var0) {
  level endon("game_ended");

  foreach(var2 in level.players) {
    if(!isDefined(var2.killing_time)) {
      var2.killing_time = 0;
    }

    var2.killing_time++;
  }

  waitframe();
  scripts\cp\utility::notify_used_consumable("killing_time");
  scripts\engine\utility::ref_143bb(20, "death", "last_stand", "disconnect");

  foreach(var2 in level.players) {
    if(isDefined(var2.killing_time)) {
      var2.killing_time--;

      if(var2.killing_time <= 0) {
        var2.killing_time = undefined;
      }
    }
  }
}

function use_now_you_see_me(var0) {
  level endon("game_ended");
  self endon("last_stand");
  self endon("disconnect");
  thread removenowyouseemeonlaststand(var0);

  foreach(var2 in level.players) {
    if(var2 == self) {
      if(var2 scripts\cp\utility::isignoremeenabled()) {
        var2 scripts\cp\utility::allow_player_ignore_me(0);
      }

      continue;
    }

    var2 scripts\cp\utility::allow_player_ignore_me(1);
  }

  wait 10;

  foreach(var2 in level.players) {
    if(var2 scripts\cp\utility::isignoremeenabled()) {
      var2 scripts\cp\utility::allow_player_ignore_me(0);
    }
  }
}

function removenowyouseemeonlaststand(var0) {
  self endon(var0 + "_timeup");
  var1 = scripts\engine\utility::ref_143ad("last_stand", "disconnect");

  foreach(var3 in level.players) {
    if(var3 scripts\cp\utility::isignoremeenabled()) {
      var3 scripts\cp\utility::allow_player_ignore_me(0);
    }
  }

  if(isDefined(var1) && var1 == "last_stand") {
    self notify(var0 + "_exited_early");
    return;
  }
}

function use_anywhere_but_here(var0) {
  if(!scripts\cp\utility::isteleportenabled()) {
    self.consumables["anywhere_but_here"].on = 0;
    return false;
  }

  if(istrue(self.is_in_pap)) {
    self.consumables["anywhere_but_here"].on = 0;
    return false;
  }

  var1 = level.active_player_respawn_locs;
  var1 = scripts\engine\utility::array_remove_duplicates(var1);

  foreach(var3 in level.active_player_respawn_locs) {
    var4 = [[level.get_spawn_volume_func]]();

    foreach(var6 in var4) {
      if(ispointinvolume(var3.origin, var6)) {
        var1 = scripts\engine\utility::array_remove(var1, var3);
      }
    }
  }

  if(var1.size < 1) {
    var1 = level.active_player_respawn_locs;
  }

  var9 = self[[level.get_respawn_loc_rated]](level.players, var1);

  if(!isDefined(var9)) {
    self.consumables["anywhere_but_here"].on = 0;
    return false;
  }

  scripts\cp\cp_interaction::refresh_interaction();
  scripts\cp\cp_powers::power_enablepower();
  self forceusehintoff();
  self setOrigin(var9.origin);
  self setplayerangles(var9.angles);
  self notify("left_hidden_room_early");
  scripts\cp\utility::notify_used_consumable("anywhere_but_here");
  self.abh_used = gettime();
  return true;
}

function jumptoanywherebutherespawns(var0) {
  level endon("game_ended");
  level.players[0] endon("death");
  level.players[0] endon("last_stand");

  foreach(var2 in level.active_player_respawn_locs) {
    level.players[0] scripts\cp\cp_interaction::refresh_interaction();
    level.players[0] scripts\cp\cp_powers::power_enablepower();
    level.players[0] forceusehintoff();
    level.players[0] setOrigin(var2.origin);
    level.players[0] setplayerangles(var2.angles);
    wait 2;
  }
}

function use_headshot_reload(var0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var0 + "_timeup");
  self.headshot_reload_time = gettime();
}

function headshot_reload_check(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(!scripts\cp\utility::is_consumable_active("headshot_reload")) {
    return 0;
  }

  if(!scripts\engine\utility::isbulletdamage(var3)) {
    return 0;
  }

  if(!scripts\cp\utility::isheadshot(var4, var6, var3, var1)) {
    return 0;
  }

  var9 = self getcurrentweapon();
  var10 = self getweaponammostock(var9);
  var11 = weaponclipsize(var9);
  var12 = self getweaponammoclip(var9);
  var13 = var11 - var12;

  if(var10 >= var13) {
    self setweaponammostock(var9, var10 - var13);
  } else {
    var11 = var10;
    self setweaponammostock(var9, 0);
  }

  var14 = var11;
  var15 = min(var12 + var14, var11);
  self setweaponammoclip(var9, int(var15));

  if(self isdualwielding()) {
    var12 = self getweaponammoclip(var9, "left");
    var15 = min(var12 + var14, var11);
    self setweaponammoclip(var9, int(var15), "left");
    return;
  }
}

function use_grenade_cooldown(var0) {
  self.power_cooldowns = 1;
  scripts\cp\cp_powers::power_adjustcharges(1, "primary");
  var1 = getarraykeys(self.powers);

  foreach(var3 in var1) {
    self.powers[var3].cooldownratemod = 1;
  }
}

function turn_off_grenade_cooldown(var0) {
  self.power_cooldowns = 0;
}

function write_consumable_used(var0, var1) {
  if(!isDefined(var0.consumables)) {
    return;
  }

  var2 = 0;

  foreach(var4 in var0.consumables_pre_irish_luck_usage) {
    var5 = get_consumable_loot_id(var6);
    setclientmatchdata("player", var1, "cardsUsed", var2, "loot_ID", int(var5));
    setclientmatchdata("player", var1, "cardsUsed", var2, "num_of_times_used", var4.times_used);
    var2++;
  }
}

function get_consumable_loot_id(var0) {
  return tablelookup("cp/loot/iw7_zombiefatefortune_loot_master.csv", 1, var0, 0);
}

function set_consumable(var0) {
  return self[[level.consumables[var0].set]](var0);
}

function unset_consumable(var0) {
  self[[level.consumables[var0].unset]](var0);
}