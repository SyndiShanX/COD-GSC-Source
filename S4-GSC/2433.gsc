/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2433.gsc
*************************************************/

_id_7F2F() {
  level._id_3BB3 = [];
  level._id_1653 = ["self_revive"];
  _id_D7D7();
  _id_AE67();
}

_id_D7D7() {
  level._id_853C = [];
  level._id_853C["grenade_cooldown"] = [];
  level._id_853C["spawn_reboard_windows"] = [];
  level._id_853C["burned_out"] = [];
  level._id_853C["faster_health_regen_upgrade"] = [];
  level._id_853C["sniper_soft_upgrade"] = [];
  level._id_853C["extra_sniping_points"] = [];
  level._id_853C["shock_melee_upgrade"] = [];
  level._id_853C["penetration_gun"] = [];
  level._id_853C["bonus_damage_on_last_bullets"] = [];
  level._id_853C["reload_damage_increase"] = [];
  level._id_853C["door_buy_refund"] = [];
  level._id_853C["faster_window_reboard"] = [];
  level._id_853C["headshot_explosion"] = [];
  level._id_853C["increased_melee_damage"] = [];
  level._id_853C["sharp_shooter_upgrade"] = [];
  level._id_853C["spawn_double_money"] = [];
  level._id_853C["anywhere_but_here"] = [];
  level._id_853C["atomizer_gun"] = [];
  level._id_853C["bh_gun"] = [];
  level._id_853C["claw_gun"] = [];
  level._id_853C["damage_booster_upgrade"] = [];
  level._id_853C["headshot_reload"] = [];
  level._id_853C["hit_reward_upgrade"] = [];
  level._id_853C["killing_time"] = [];
  level._id_853C["slow_enemy_movement"] = [];
  level._id_853C["spawn_infinite_ammo"] = [];
  level._id_853C["spawn_instakill"] = [];
  level._id_853C["spawn_max_ammo"] = [];
  level._id_853C["spawn_nuke"] = [];
  level._id_853C["wall_power"] = [];
  level._id_853C["ephemeral_enhancement"] = [];
  level._id_853C["secret_service"] = [];
  level._id_853C["cant_miss"] = [];
  level._id_853C["spawn_fire_sale"] = [];
  level._id_853C["self_revive"] = [];
  level._id_853C["just_a_flesh_wound"] = [];
  level._id_853C["force_push_near_death"] = [];
  level._id_853C["next_purchase_free"] = [];
  level._id_853C["masochist"] = [];
  level._id_853C["magic_wheel_upgrade"] = [];
  level._id_853C["steel_dragon"] = [];
  level._id_853D = [];
}

_id_AE67() {
  if(isDefined(level._id_3BB2)) {
    var_0 = level._id_3BB2;
  } else {
    var_0 = "cp/loot/iw7_zombiefatefortune_loot_master.csv";
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
    _id_C1D3(var_2, var_3, var_4, var_5, var_6, ::_id_6ED6, ::_id_C391);
    var_1++;
  }

  _id_3BB1("ephemeral_enhancement", ::_id_FDD4, undefined, undefined, 1);
  _id_3BB1("grenade_cooldown", ::_id_FDDD, undefined, ::_id_F7EF, undefined);
  _id_3BB1("reload_damage_increase", ::_id_FDF5, undefined, undefined, undefined);
  _id_3BB1("headshot_reload", ::_id_FDDE, undefined, undefined, undefined);
  _id_3BB1("anywhere_but_here", ::_id_FDBF, undefined, undefined, undefined);
  _id_3BB1("now_you_see_me", ::_id_FDE9, undefined, undefined, undefined);
  _id_3BB1("killing_time", ::_id_FDE3, undefined, undefined, undefined);
  _id_3BB1("phoenix_up", ::_id_FDF0, undefined, undefined, 1);
  _id_3BB1("spawn_instakill", ::_id_FE06, undefined, undefined, 1);
  _id_3BB1("spawn_fire_sale", ::_id_FE04, undefined, undefined, 1);
  _id_3BB1("spawn_nuke", ::_id_FE08, undefined, undefined, 1);
  _id_3BB1("spawn_double_money", ::_id_FE03, undefined, undefined, 1);
  _id_3BB1("spawn_max_ammo", ::_id_FE07, undefined, undefined, 1);
  _id_3BB1("spawn_reboard_windows", ::_id_FE09, undefined, undefined, 1);
  _id_3BB1("spawn_infinite_ammo", ::_id_FE05, undefined, undefined, 1);
  _id_3BB1("bh_gun", ::_id_FDC2, undefined, undefined, 1);
  _id_3BB1("atomizer_gun", ::_id_FDC0, undefined, undefined, 1);
  _id_3BB1("claw_gun", ::_id_FDC9, undefined, undefined, 1);
  _id_3BB1("steel_dragon", ::_id_FE0B, undefined, undefined, 1);
  _id_3BB1("penetration_gun", ::_id_FDEF, undefined, undefined, 1);
  _id_3BB1("life_link", ::_id_FDE5, undefined, undefined, undefined);
  _id_3BB1("slow_enemy_movement", ::_id_FE01, undefined, undefined, undefined);
  _id_3BB1("increased_team_efficiency", ::_id_FDE1, undefined, undefined, undefined);
  _id_3BB1("welfare", ::_id_FE1F, undefined, undefined, undefined);
  _id_3BB1("cant_miss", ::_id_FDC8, undefined, undefined, undefined);
  _id_3BB1("self_revive", ::_id_FDFE, undefined, undefined, undefined);
  _id_3BB1("force_push_near_death", ::_id_FDD8, undefined, undefined, undefined);
  _id_3BB1("masochist", ::_id_FDE7, undefined, undefined, undefined);
  _id_3BB1("timely_torrent", ::_id_FE13, undefined, undefined, 1);
  _id_3BB1("purify", ::_id_FDF3, undefined, undefined, undefined);
  _id_3BB1("explosive_touch", ::_id_FDD6, undefined, undefined, undefined);
  _id_3BB1("shared_fate", ::_id_FE00, undefined, undefined, undefined);
  _id_3BB1("fire_chains", ::_id_FDD7, undefined, undefined, undefined);
  _id_3BB1("irish_luck", ::_id_FDE2, undefined, undefined, undefined);
  _id_3BB1("temporal_increase", ::_id_FE0D, undefined, undefined, undefined);
  _id_3BB1("twist_of_fate", ::_id_FE1C, undefined, undefined, undefined);
}

_id_C1D3(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7.type = var_1;
  var_7._id_FEBF = var_2;
  var_7._id_FDB7 = var_3;
  var_7._id_AEAE = var_4;
  var_7._id_D12B = var_5;
  var_7._id_F9B2 = var_6;
  var_7._id_F28A = var_0 + "_timeup";
  level._id_3BB3[var_0] = var_7;

  foreach(var_10, var_9 in level._id_853C) {
    if(var_10 == var_0) {
      level._id_853C[var_0] = level._id_3BB3[var_0];
      level._id_853C[var_0].name = var_0;
    }
  }
}

_id_3BB1(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level._id_3BB3[var_0];

  if(isDefined(var_1)) {
    var_5._id_FE73 = var_1;
  }

  if(isDefined(var_2)) {
    var_5._id_D12B = var_2;
  }

  if(isDefined(var_3)) {
    var_5._id_F9B2 = var_3;
  }

  if(isDefined(var_4)) {
    var_5._id_F0D7 = var_4;
  }
}

_id_805A() {
  if(istrue(self.consumables_initialized)) {
    return;
  }
  self.consumables_initialized = 1;
  _id_D333();
  thread init_self_revive_tracker();
  init_solo_self_revive();
}

init_self_revive_tracker() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    var_0 = scripts\engine\utility::_id_10897("consumable_given self_revive", "consumable_removed self_revive");

    if(isDefined(var_0)) {
      var_1 = strtok(var_0, " ");

      if(var_1.size > 1) {
        if(var_1[0] == "consumable_given") {
          if(var_1[1] == "self_revive") {
            self setclientomnvar("ui_self_revive", 1);
          }
        } else if(var_1[0] == "consumable_removed") {
          if(var_1[1] == "self_revive") {
            self setclientomnvar("ui_self_revive", 0);
          }
        }
      }
    }
  }
}

init_solo_self_revive() {
  level manage_solo_self_revive(self);
  thread watch_solo_self_revive_disconnect();
}

manage_solo_self_revive(var_0) {
  var_1 = 0;
  var_2 = 0;

  if(level.players.size == 1) {
    var_2 = 1;

    if(!level scripts\engine\utility::_id_5C00("solo_game")) {
      var_1 = 1;
      level scripts\engine\utility::_id_5C1B("solo_game");
    }
  } else if(level scripts\engine\utility::_id_5C00("solo_game")) {
    var_1 = 1;
    level scripts\engine\utility::_id_5C04("solo_game");
  }

  if(var_1) {
    if(var_2) {
      var_0 = scripts\cp\utility::_id_459B(var_0, scripts\engine\utility::_id_1BAC(level.players));

      if(isDefined(var_0)) {
        if(!istrue(var_0.hasusedsoloselfrevive)) {
          if(!istrue(var_0.consumables_initialized)) {
            var_0 _id_805A();
          }

          var_0 _id_6ED6("self_revive", 0);
          var_0.hassoloselfrevive = 1;
        }
      }
    } else {
      foreach(var_4 in level.players) {
        if(istrue(var_4.hassoloselfrevive) && !istrue(var_4.hasusedsoloselfrevive)) {
          var_4 _id_C391("self_revive");
          var_4.hassoloselfrevive = undefined;
        }
      }
    }
  }
}

watch_solo_self_revive_disconnect() {
  level endon("game_ended");
  self waittill("disconnect");
  waitframe();
  level manage_solo_self_revive(undefined);
}

_id_7F2E() {
  thread _id_9DEF();
}

_id_7F32() {
  self._id_3BB6 = [];
  self setplayerdata("common", "numConsumables", 0);

  for(var_0 = 0; var_0 < 32; var_0++) {
    self setplayerdata("common", "consumablesUsed", var_0, 0);
  }
}

_id_D333() {
  self._id_3BB3 = [];

  for(var_0 = 0; var_0 < 5; var_0++) {
    var_1 = self getplayerdata("cp", "zombiePlayerLoadout", "zombie_consumables", var_0);
    self._id_3BB3[var_1] = spawnStruct();
    self._id_3BB3[var_1]._id_FEBF = level._id_3BB3[var_1]._id_FEBF;
    self._id_3BB3[var_1]._id_AA43 = 0;
    self._id_3BB3[var_1]._id_F26C = 0;
  }

  foreach(var_1 in level._id_1653) {
    self._id_3BB3[var_1] = spawnStruct();
    self._id_3BB3[var_1]._id_FEBF = level._id_3BB3[var_1]._id_FEBF;
    self._id_3BB3[var_1]._id_AA43 = 0;
    self._id_3BB3[var_1]._id_F26C = 0;
  }

  self._id_3BB5 = self._id_3BB3;
}

_id_F7FF(var_0) {
  var_1 = _id_63B6(self);
  self._id_DDF0 = [];
  self playlocalsound("zmb_fnf_replenish");

  for(var_2 = 0; var_2 < var_1; var_2++) {
    self._id_DDF0[self._id_DDF0.size] = var_2;
    self _meth_82F8("zm_card_selection_count", var_2, 1);
  }

  _id_FB83(0);
}

_id_C5C7() {
  self notify("give_new_deck");
  self._id_3BAE = 0;
  _id_7F2E();
  thread _id_945B();
}

_id_63B6(var_0) {
  var_1 = var_0 _meth_81C8("fate_card_slot_4", "fatedecksize", 1);
  var_2 = var_0 _meth_81C8("fate_card_slot_5", "fatedecksize", 1);
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

_id_D7A8() {
  self setactionslot(1, "");
  self setactionslot(2, "");
  self setactionslot(3, "");
  self setactionslot(4, "");
  self notifyonplayercommand("D_pad_up", "+actionslot 1");
  self notifyonplayercommand("D_pad_down", "+actionslot 2");
  thread _id_10A68("super_default_zm");
}

_id_10A68(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("offhand_fired", var_1);
    var_2 = getcompleteweaponname(var_1);

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

_id_4EBC() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("consumable_selected");
  self endon("give_new_deck");
  var_0 = 0;
  _id_FB83(var_0);
  self._id_4525 = 1;

  for(;;) {
    var_1 = scripts\engine\utility::_id_10898("D_pad_up", "D_pad_down", "fired_super");

    if(self._id_DDF0.size <= 0 || istrue(self._id_49EB) || istrue(self._id_E3E5) || istrue(self.inlaststand)) {
      self playlocalsound("ui_consumable_deny");
      wait 0.25;
      continue;
    }

    if(var_1 == "fired_super") {
      self._id_4525 = undefined;
      thread _id_3BAA(self._id_DDF0[var_0], var_0);
    } else if(var_1 == "D_pad_up" && self._id_DDF0.size > 1) {
      var_0 = _id_6750(var_0 + 1, 0, self._id_DDF0.size - 1);
      _id_FB83(var_0);
      self playlocalsound("ui_consumable_scroll");
    } else if(var_1 == "D_pad_down" && self._id_DDF0.size > 1) {
      var_0 = _id_6750(var_0 - 1, 0, self._id_DDF0.size - 1);
      _id_FB83(var_0);
      self playlocalsound("ui_consumable_scroll");
    }

    waitframe();
  }
}

_id_FB83(var_0) {
  wait 0.1;
}

_id_6750(var_0, var_1, var_2) {
  if(var_0 > var_2) {
    return var_1;
  }

  if(var_0 < var_1) {
    return var_2;
  }

  return var_0;
}

_id_C38C(var_0) {
  self._id_DDF0 = scripts\engine\utility::array_remove(self._id_DDF0, self._id_DDF0[var_0]);
}

_id_3BAA(var_0, var_1) {
  var_2 = self getplayerdata("cp", "zombiePlayerLoadout", "zombie_consumables", var_0);
  var_3 = "zm_card" + (var_0 + 1) + "_drain";
  var_4 = "slot_" + (var_0 + 1) + "_used";
  self._id_3BB3[var_2]._id_FE50 = var_4;

  if(var_2 == "irish_luck") {
    thread _id_3BAC(var_2, var_3, "zm_dpad_up_uses", "zm_dpad_up_activated", var_4, var_0, var_1);
  } else {
    thread _id_3BAB(var_2, var_3, "zm_dpad_up_uses", "zm_dpad_up_activated", var_4, var_0, var_1);
  }
}

_id_3BAB(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("dpad_end_" + var_0);
  self endon("give_new_deck");

  if(self._id_3BB3[var_0]._id_FEBF > 0 && self._id_3BB3[var_0]._id_AA43 == 0 && !_id_073B::_id_B4EF(self)) {
    self setclientomnvar("zm_fate_card_used", var_5);
    self._id_3BB3[var_0]._id_BD71 = 1;
    var_7 = undefined;
    var_8 = "fired_super";
    thread _id_D18E(var_0);

    if(isDefined(level._id_3BB3[var_0]._id_FE73)) {
      if(isDefined(level._id_3BB3[var_0]._id_F0D7)) {
        var_7 = self[[level._id_3BB3[var_0]._id_FE73]](var_0);
      } else {
        var_7 = self thread[[level._id_3BB3[var_0]._id_FE73]](var_0);
      }
    }

    if(!isDefined(var_7) || isDefined(var_7) && var_7) {
      _id_3BB7(self, var_0);
      self._id_3BB3[var_0]._id_F26C++;
      _id_0741::_id_BD77("mt_faf_uses");
      thread _id_076F::_id_F72D("wonder_consume", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);

      if(self._id_3BB3[var_0]._id_F26C == 1) {
        thread _id_454D(var_0);
      }

      self setclientomnvar(var_1, 1);
      thread _id_945B();
      self _meth_82F8("zm_card_fill_display", var_5, 1);
      _id_C38C(var_6);
      thread _id_9DEF();
      self playlocalsound("ui_consumable_select");
      _id_B20F(self);
      self notify("consumable_selected");
      thread scripts\cp\utility::_id_5B75(self, self._id_59D7);
      self._id_3BAF = undefined;
      level thread _id_076F::_id_C3D1("nag_use_fateandfort");
      var_9 = level._id_3BB3[var_0].type;

      if(var_9 == "timedactivations") {
        thread _id_4EBE(var_0, level._id_3BB3[var_0]._id_FDB7, var_1, var_8, var_2, var_3, var_4, var_5);
      } else if(var_9 == "wave") {
        thread _id_4EC0(var_0, level._id_3BB3[var_0]._id_FDB7, var_1, var_8, var_2, var_3, var_4, var_5);
      } else if(var_9 == "triggernow" || level._id_3BB3[var_0].type == "triggerwait") {
        thread _id_4EBD(var_0, level._id_3BB3[var_0].type, self._id_3BB3[var_0]._id_FEBF, var_1, var_8, var_2, var_3, var_4, var_5);
      } else if(var_9 == "triggerpassive") {
        thread _id_4EBF(var_0, level._id_3BB3[var_0]._id_AEAE, var_1, var_8, var_2, var_3, var_4, var_5);
      }

      if(isDefined(var_7)) {
        scripts\cp\utility::_id_A689(var_0);
        return;
      }
    } else {
      self playlocalsound("ui_consumable_deny");
      self._id_3BB3[var_0]._id_BD71 = undefined;
    }
  }
}

_id_454D(var_0) {
  var_1 = _id_640E(self, var_0);

  if(isDefined(var_1)) {
    var_2 = self getplayerdata("cp", "zombiePlayerLoadout", "consumables_counter", var_1);
    var_3 = var_2 - 1;
    self setplayerdata("cp", "zombiePlayerLoadout", "consumables_counter", var_1, var_3);
  }
}

_id_B20F(var_0) {
  switch (var_0._id_59D7) {
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
  }
}

_id_3BB7(var_0, var_1) {
  var_2 = _id_640F(var_1);

  if(scripts\engine\utility::array_contains(var_0._id_3BB6, var_2)) {
    return;
  }
  var_3 = var_0._id_3BB6.size;

  if(isDefined(level._id_3BB2)) {
    var_4 = level._id_3BB2;
  } else {
    var_4 = "cp/loot/iw7_zombiefatefortune_loot_master.csv";
  }

  var_5 = _func_0222(var_4, 1, var_1, 3);

  if(isDefined(var_5)) {
    if(var_5 == "Fortune") {
      var_0 setplayerdata("common", "consumablesUsed", var_3, int(var_2));
      var_6 = var_0 getplayerdata("common", "numConsumables");
      var_0 setplayerdata("common", "numConsumables", var_6 + 1);
      var_0._id_3BB6 = scripts\engine\utility::array_add(var_0._id_3BB6, var_2);
    }
  }
}

_id_640E(var_0, var_1) {
  for(var_2 = 0; var_2 < 5; var_2++) {
    var_3 = var_0 getplayerdata("cp", "zombiePlayerLoadout", "zombie_consumables", var_2);

    if(var_1 == var_3) {
      return var_2;
    }
  }

  return undefined;
}

_id_945C() {
  self setclientomnvar("lb_gsc_controlled", 1);
  self setclientomnvar("lb_color", 0);
  self setclientomnvar("lb_pulse_time", 1);
}

_id_945B() {
  self setclientomnvar("lb_gsc_controlled", 0);
}

_id_4EBE(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  level endon("game_ended");
  thread _id_10B0B(var_0, var_4, var_2, var_5, var_6, var_7);
  var_8 = 1;
  var_9 = var_8 / var_1;
  wait(_id_6957());

  for(;;) {
    if(!istrue(self._id_E3E5) && !istrue(self.inlaststand)) {
      self setclientomnvar(var_2, var_8);
      var_8 = var_8 - var_9;

      if(var_8 <= 0) {
        self setclientomnvar(var_2, 0);
        _id_49EA(var_0, var_4, var_2, var_5, var_6, var_7);
        break;
      }
    }

    wait 1.0;
  }
}

_id_4EC0(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  thread _id_10B0B(var_0, var_4, var_2, var_5, var_6, var_7);
  var_8 = 1;
  var_9 = var_8 / var_1;

  for(;;) {
    self setclientomnvar(var_2, var_8);
    level waittill("spawn_wave_done");
    var_8 = var_8 - var_9;

    if(var_8 <= 0) {
      self setclientomnvar(var_2, 0);
      _id_49EA(var_0, var_4, var_2, var_5, var_6, var_7);
      break;
    }

    wait 1.0;
  }
}

_id_4EBD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  thread _id_10B0B(var_0, var_5, var_3, var_6, var_7, var_8);
  var_9 = self._id_3BB3[var_0]._id_FE50;
  var_10 = 1;

  if(var_1 == "triggerwait") {
    self waittill(var_9);
  }

  wait 1.0;

  for(;;) {
    if(!istrue(self._id_E3E5) && !istrue(self.inlaststand)) {
      var_10 = var_10 - 0.05;
      self setclientomnvar(var_3, var_10);

      if(var_10 <= 0) {
        self setclientomnvar(var_3, 0);
        _id_49EA(var_0, var_5, var_3, var_6, var_7, var_8);
        break;
      }
    }

    wait 0.05;
  }
}

_id_4EBF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  thread _id_10B0B(var_0, var_4, var_2, var_5, var_6, var_7);
  var_8 = 1 / var_1;
  var_9 = self._id_3BB3[var_0]._id_FE50;
  var_10 = 1;

  for(;;) {
    self waittill(var_9);

    if(!istrue(self._id_E3E5) && !istrue(self.inlaststand) || var_0 == "coagulant") {
      var_10 = var_10 - var_8;
      self setclientomnvar(var_2, var_10);

      if(var_10 < 0.0001) {
        self setclientomnvar(var_2, 0);
        _id_49EA(var_0, var_4, var_2, var_5, var_6, var_7);
        break;
      }
    }
  }
}

_id_6957() {
  if(scripts\cp\utility::_id_9A9E(0)) {
    switch (self._id_105F0) {
      case "p1_":
        return self _meth_8495("ges_wondercard_valley_girl");
      case "p2_":
        return self _meth_8495("ges_wondercard_nerd");
      case "p3_":
        return self _meth_8495("ges_wondercard_rapper");
      case "p4_":
        return self _meth_8495("ges_wondercard_jock");
      default:
        return 2;
    }
  } else if(scripts\cp\utility::_id_9A9E(1)) {
    switch (self._id_105F0) {
      case "p1_":
        return self _meth_8495("ges_wondercard_chola");
      case "p2_":
        return self _meth_8495("ges_wondercard_raver");
      case "p3_":
        return self _meth_8495("ges_wondercard_grunge");
      case "p4_":
        return self _meth_8495("ges_wondercard_hiphop");
      default:
        return 2;
    }
  } else {
    switch (self._id_105F0) {
      case "p1_":
        return self _meth_8495("ges_wondercard_valley_girl");
      case "p2_":
        return self _meth_8495("ges_wondercard_nerd");
      case "p3_":
        return self _meth_8495("ges_wondercard_rapper");
      case "p4_":
        return self _meth_8495("ges_wondercard_jock");
      default:
        return 2;
    }
  }
}

_id_10B0B(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("dpad_end_" + var_0);
  self waittill(var_0 + "_exited_early");
  self setclientomnvar(var_2, 0);
  thread _id_49EA(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_9DEF() {
  self notify("starting_meter_fill");
  self endon("starting_meter_fill");
  self endon("disconnect");
  level endon("game_ended");

  if(self._id_DDF0.size == 0) {
    thread _id_076F::_id_1048("nag_need_fateandfort", "zmb_comment_vo", 60, 300, 6, 1);
    thread _id_076F::_id_C3D1("nag_use_fateandfort");
    return;
  }

  self._id_3BAE = 0;
  self._id_3BB0 = _id_658E();

  while(self._id_3BAE < self._id_3BB0) {
    self waittill("consumable_charge", var_0);

    if(istrue(self._id_49EB)) {
      continue;
    }
    var_1 = self._id_3BB0 - self._id_3BAE;

    if(var_0 > var_1) {
      var_0 = var_1;
    }

    if(_id_073B::_id_B4EF(self)) {
      continue;
    }
    self._id_3BAE = self._id_3BAE + var_0;
  }

  self notify("meter_full");
  thread _id_076F::_id_1048("nag_use_fateandfort", "zmb_comment_vo", 60, 180, 6, 1);
  self playlocalsound("ui_consumable_meter_full");
  self setweaponammoclip("super_default_zm", 1);
  thread _id_945C();
  self._id_3BAF = 1;
  thread _id_4EBC();

  if(scripts\cp\utility::_id_89AE() || level._id_AB30) {
    thread scripts\cp\cp_hud_message::_id_106CB("cards", 5);
  }
}

_id_658E() {
  var_0 = 1250;

  if(self._id_3267 == 1) {
    var_0 = 3000;
  } else if(self._id_3267 == 2) {
    var_0 = 5000;
  }

  return var_0;
}

_id_49EA(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_F7EA(var_0, var_3);
  self._id_3BB3[var_0]._id_FEBF = self._id_3BB3[var_0]._id_FEBF - 1;
  self._id_3BB3[var_0]._id_BD71 = undefined;
  self setclientomnvar(var_1, self._id_3BB3[var_0]._id_FEBF);

  if(self._id_3BB3[var_0]._id_FEBF == 0) {
    self._id_3BB3[var_0]._id_FEBF = level._id_3BB3[var_0]._id_FEBF;
    self notify("dpad_end_" + var_0);
    self _meth_82F8("zm_card_selection_count", var_5, 0);
    self _meth_82F8("zm_card_fill_display", var_5, 0);
  } else
    self setclientomnvar(var_2, 1);
}

_id_F7EA(var_0, var_1) {
  self._id_3BB3[var_0]._id_AA43 = 0;
  scripts\cp\utility::_id_A687(var_0);
  thread _id_F9B7(var_0);
}

_id_6ED6(var_0, var_1) {
  var_2 = level._id_3BB3[var_0];

  if(isDefined(var_2._id_FE50)) {
    self notify(var_2._id_FE50);
  } else {
    self notify(var_0 + " activated");
  }

  if(isDefined(level._id_BFD9) && level._id_BFD9.name == var_0) {
    return;
  } else {
    self._id_3BB3[var_0]._id_AA43 = 1;
  }

  self notify("consumable_given " + var_0);
}

_id_C391(var_0) {
  if(isDefined(self._id_3BB3[var_0])) {
    self._id_3BB3[var_0]._id_AA43 = 0;
  }

  self notify("consumable_removed " + var_0);
}

_id_FDF5(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self._id_C310 = undefined;

  for(;;) {
    self waittill("reload");
    self._id_C310 = 1;
    wait 5;
    self._id_C310 = undefined;
  }
}

_id_FDD4(var_0) {
  if(istrue(self._id_8AD6)) {
    self._id_3BB3[var_0]._id_AA43 = 0;
    return 0;
  }

  var_1 = self getcurrentweapon();
  var_2 = scripts\cp\utility::_id_6CE3(var_1);

  if(isDefined(self._id_AE0A[var_2]) && scripts\cp\cp_weapon::_id_3101(var_1, 1)) {
    thread _id_5D80(self, var_0, var_2, var_1);
    return 1;
  } else {
    self._id_3BB3["ephemeral_enhancement"]._id_AA43 = 0;
    return 0;
  }
}

_id_5D80(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_4 = undefined;
  var_0._id_8AD6 = 1;
  var_5 = "pap" + var_0._id_AE0A[var_2]._id_991E;
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

  var_12 = getcompleteweaponname(var_3);

  if(isDefined(level._id_4242)) {
    var_13 = [[level._id_4242]](var_0, var_2, var_12);

    if(isDefined(var_13)) {
      if(var_13 == "replace_me") {
        var_5 = undefined;
      } else {
        var_5 = var_13;
      }
    }
  }

  if(isDefined(level._id_10D23) && isDefined(level._id_10D23[getweaponbasename(var_3)])) {
    var_12 = level._id_10D23[getweaponbasename(var_3)];
  } else if(isDefined(level._id_4243)) {
    var_12 = [[level._id_4243]](var_0, var_2, var_3);
  }

  var_3 = makeweaponfromstring(var_12);

  if(isDefined(level._id_4244)) {
    var_4 = [[level._id_4244]](var_0, var_2, var_3);
  } else {
    if(isDefined(var_2)) {
      if(isDefined(level._id_A524) && scripts\engine\utility::array_contains(level._id_A524, var_2)) {
        var_4 = undefined;
      } else if(isDefined(level._id_AE0B) && var_0._id_AE0A[var_2]._id_991E == 1) {
        var_4 = level._id_AE0B;
      } else if(isDefined(level._id_AE0C) && var_0._id_AE0A[var_2]._id_991E == 2) {
        var_4 = level._id_AE0C;
      }

      var_14 = var_0 scripts\cp\cp_weapon::_id_683D(var_3);

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
      }
    } else
      var_16 = 0;

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
          if(isDefined(var_0._id_AE0A[var_2])) {
            var_5 = "pap" + var_0._id_AE0A[var_2]._id_991E;
          } else {
            var_5 = "pap1";
          }
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

  var_20 = var_0 scripts\cp\cp_weapon::_id_C78E(var_3, var_5, var_6, undefined, var_4);
  var_21 = makeweaponfromstring(var_20);

  if(isDefined(var_21)) {
    var_0._id_AE0A[var_2]._id_991E++;
    var_0 notify("weapon_level_changed");
    var_0._id_553E = var_21 _meth_8625();
    var_0 thread _id_4EB4(var_1, var_0, var_21, var_7);
    var_0 endon("last_stand");
    wait(_id_6957());
    var_21 = var_0 scripts\cp\utility::_giveweapon(var_21, undefined, undefined, 1);

    if(isDefined(var_8)) {
      var_0 takeweapon(var_8);
    } else {
      var_0 takeweapon(var_3);
    }

    var_0 switchtoweapon(var_21);
  }
}

_id_4EB4(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_4 = undefined;

  if(isweapon(var_2)) {
    var_4 = var_2;
  } else {
    var_4 = makeweaponfromstring(var_2);
  }

  var_5 = var_1._id_553E;
  var_6 = 0;
  var_7 = scripts\cp\utility::_id_6CE3(var_4);
  var_8 = "pap" + (var_1._id_AE0A[var_7]._id_991E - 1);
  var_9 = var_1._id_AE0A[var_7]._id_991E - 2;

  switch (var_7) {
    case "katana":
      var_1._id_AE0A[var_7]._id_991E--;

      if(var_1._id_AE0A[var_7]._id_991E == 1) {
        var_1._id_22AC = 1;
        var_4 = makeweapon("iw7_katana_zm");
      } else {
        var_1._id_553D = 1;
        var_4 = makeweapon("iw7_katana_zm_pap1");
      }

      break;
    case "nunchucks":
      var_1._id_AE0A[var_7]._id_991E--;

      if(var_1._id_AE0A[var_7]._id_991E == 1) {
        var_1._id_22AC = 1;
        var_4 = makeweapon("iw7_nunchucks_zm");
      } else {
        var_1._id_553D = 1;
        var_4 = makeweapon("iw7_nunchucks_zm_pap1");
      }

      break;
    case "two":
      var_1._id_AE0A[var_7]._id_991E--;

      if(var_1._id_AE0A[var_7]._id_991E == 1) {
        var_1._id_22AC = 1;
        var_4 = makeweapon("iw7_two_headed_axe_mp");
      } else {
        var_1._id_553D = 1;
        var_4 = makeweapon("iw7_two_headed_axe_mp_pap1");
      }

      break;
    case "machete":
      var_1._id_AE0A[var_7]._id_991E--;

      if(var_1._id_AE0A[var_7]._id_991E == 1) {
        var_1._id_22AC = 1;
        var_4 = makeweapon("iw7_machete_mp");
      } else {
        var_1._id_553D = 1;
        var_4 = makeweapon("iw7_machete_mp_pap1");
      }

      break;
    case "golf":
      var_1._id_AE0A[var_7]._id_991E--;

      if(var_1._id_AE0A[var_7]._id_991E == 1) {
        var_1._id_22AC = 1;
        var_4 = makeweapon("iw7_golf_club_mp");
      } else {
        var_1._id_553D = 1;
        var_4 = makeweapon("iw7_golf_club_mp_pap1");
      }

      break;
    case "spiked":
      var_1._id_AE0A[var_7]._id_991E--;

      if(var_1._id_AE0A[var_7]._id_991E == 1) {
        var_1._id_22AC = 1;
        var_4 = makeweapon("iw7_spiked_bat_mp");
      } else {
        var_1._id_553D = 1;
        var_4 = makeweapon("iw7_spiked_bat_mp_pap1");
      }

      break;
  }

  var_4 = _id_4EB3(var_1, var_4, var_7, var_8, var_9, var_3);
  var_1._id_22AC = undefined;
  var_1._id_553D = undefined;
  var_10 = var_1 scripts\engine\utility::_id_10897("ephemeral_enhancement_timeup", "last_stand");

  if(var_10 != "ephemeral_enhancement_timeup") {
    var_1 notify(var_0 + "_exited_early");
  }

  var_1._id_8AD6 = undefined;
  var_11 = var_1 scripts\cp\utility::_id_6E34();
  var_12 = scripts\cp\utility::_id_6CE3(var_11);

  if(var_1 scripts\cp\cp_weapon::_id_752E(var_5)) {
    var_13 = var_1 getweaponslistall();

    foreach(var_15 in var_13) {
      var_16 = scripts\cp\utility::_id_6CE3(var_15);

      if(var_16 == scripts\cp\utility::_id_6CE3(var_5)) {
        var_1 takeweapon(var_15);
        var_6 = 1;
        var_4 = var_1 scripts\cp\utility::_giveweapon(var_4, undefined, undefined, 1);

        if(scripts\cp\utility::_id_6CE3(var_4) == var_12) {
          var_1 switchtoweaponimmediate(var_4);
        }

        var_1._id_AE0A[var_7]._id_991E = int(max(var_1._id_AE0A[var_7]._id_991E - 1, 1));
        var_1 notify("weapon_level_changed");
        break;
      }
    }
  }

  if(isDefined(var_1._id_3D58)) {
    var_18 = var_1._id_3D58;

    foreach(var_20 in var_18) {
      var_16 = var_20 _meth_8625();

      if(var_16 == var_5) {
        var_21 = getcompleteweaponname(var_20);
        var_22 = var_1._id_3D5F[var_21];
        var_23 = var_1._id_3D61[var_21];
        var_1._id_3D58 = scripts\engine\utility::array_remove(var_1._id_3D58, var_20);
        var_24 = getcompleteweaponname(var_4);

        if(var_16 == var_1._id_3D62 _meth_8625()) {
          var_1._id_3D62 = var_4;
        }

        var_1._id_3D58 = scripts\engine\utility::array_add(var_1._id_3D58, var_24);
        var_1._id_3D5F[var_24] = var_22;
        var_1._id_3D61[var_24] = var_23;
        break;
      }
    }
  }

  if(isDefined(var_1._id_8F65)) {
    if(var_1._id_8F65 _meth_8625() == var_1._id_553E) {
      var_1._id_8F65 = var_4;
    }
  }

  if(isDefined(var_1._id_CB43)) {
    if(var_1._id_CB43 _meth_8625() == var_1._id_553E) {
      var_1._id_CB43 = var_4;
    }
  }

  if(isDefined(var_1._id_98A6)) {
    var_18 = var_1._id_98A6._id_3D58;

    foreach(var_20 in var_18) {
      var_16 = var_20 _meth_8625();

      if(var_16 == var_5) {
        var_21 = getcompleteweaponname(var_20);
        var_22 = var_1._id_3D5F[var_21];
        var_23 = var_1._id_3D61[var_21];
        var_1._id_98A6._id_3D58 = scripts\engine\utility::array_remove(var_1._id_98A6._id_3D58, var_20);
        var_24 = getcompleteweaponname(var_4);

        if(var_16 == var_1._id_98A6._id_3D62 _meth_8625()) {
          var_1._id_98A6._id_3D62 = var_4;
        }

        var_1._id_98A6._id_3D58 = scripts\engine\utility::array_add(var_1._id_98A6._id_3D58, var_4);
        var_1._id_3D5F[var_24] = var_22;
        var_1._id_3D61[var_24] = var_23;
        break;
      }
    }
  }

  var_1._id_553E = undefined;
}

_id_4EB3(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(var_4 >= 1) {
    if(isDefined(level._id_A524) && scripts\engine\utility::array_contains(level._id_A524, var_2)) {
      var_6 = undefined;
    } else if(isDefined(level._id_AE0B)) {
      var_6 = level._id_AE0B;
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
  } else
    var_7 = undefined;

  switch (var_2) {
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

  var_8 = getweaponattachments(var_1);

  if(istrue(var_5)) {
    var_8 = scripts\engine\utility::array_add(var_8, "akimbo");
  }

  foreach(var_10 in var_8) {
    if(issubstr(var_10, var_3)) {
      var_8 = scripts\engine\utility::array_remove(var_8, var_10);
    }
  }

  var_12 = var_0 scripts\cp\cp_weapon::_id_C78E(var_1, var_7, var_8, undefined, var_6);
  return makeweaponfromstring(var_12);
}

_id_FE06(var_0) {
  var_1 = self;

  if(_id_E1C7(var_1, "instakill_30", var_0)) {
    return 1;
  } else {
    self._id_3BB3["spawn_instakill"]._id_AA43 = 0;
    return 0;
  }
}

_id_FE04(var_0) {
  var_1 = self;

  if(_id_E1C7(var_1, "fire_30", var_0)) {
    return 1;
  } else {
    self._id_3BB3["fire_30"]._id_AA43 = 0;
    return 0;
  }
}

_id_FE08(var_0) {
  var_1 = self;

  if(_id_E1C7(var_1, "kill_50", var_0)) {
    return 1;
  } else {
    self._id_3BB3["spawn_nuke"]._id_AA43 = 0;
    return 0;
  }
}

_id_FE03(var_0) {
  var_1 = self;

  if(_id_E1C7(var_1, "cash_2", var_0)) {
    return 1;
  } else {
    self._id_3BB3["spawn_double_money"]._id_AA43 = 0;
    return 0;
  }
}

_id_FE07(var_0) {
  var_1 = self;

  if(_id_E1C7(var_1, "ammo_max", var_0)) {
    return 1;
  } else {
    self._id_3BB3["spawn_max_ammo"]._id_AA43 = 0;
    return 0;
  }
}

_id_FE09(var_0) {
  var_1 = self;

  if(_id_E1C7(var_1, "board_windows", var_0)) {
    return 1;
  } else {
    self._id_3BB3["spawn_reboard_windows"]._id_AA43 = 0;
    return 0;
  }
}

_id_FE05(var_0) {
  var_1 = self;

  if(_id_E1C7(var_1, "infinite_20", var_0)) {
    return 1;
  } else {
    self._id_3BB3["spawn_infinite_ammo"]._id_AA43 = 0;
    return 0;
  }
}

_id_E1C7(var_0, var_1, var_2) {
  var_3 = var_0.origin;
  var_4 = (0, 128, 0);
  var_5 = self getplayerangles();
  var_6 = 7;
  var_3 = var_3 + var_4[0] * anglestoright(var_5);
  var_3 = var_3 + var_4[1] * anglesToForward(var_5);
  var_3 = var_3 + var_4[2] * anglestoup(var_5);
  var_7 = _func_01C6(anglestoup(var_5), anglesToForward(var_5), var_6);
  var_8 = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_9 = scripts\engine\trace::ray_trace(var_0 getEye(), var_3 + var_7, self, var_8);
  var_3 = scripts\engine\utility::_id_5000(var_9["position"] + var_7 * -18, 32, -2000);

  if(!scripts\cp\cp_weapon::_id_88D5(var_3, level._id_84F7, undefined, undefined, 1)) {
    return 0;
  }

  return 0;
}

_id_FE0B(var_0) {
  if(istrue(self._id_8AD6)) {
    self._id_3BB3[var_0]._id_AA43 = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self._id_3BB3[var_0]._id_AA43 = 0;
    return 0;
  }

  thread _id_6F12(var_0, "iw7_steeldragon_mp");
  return 1;
}

_id_FDC9(var_0) {
  if(istrue(self._id_8AD6)) {
    self._id_3BB3[var_0]._id_AA43 = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self._id_3BB3[var_0]._id_AA43 = 0;
    return 0;
  }

  thread _id_6F12(var_0, "iw7_claw_mp");
  return 1;
}

_id_FDC0(var_0) {
  if(istrue(self._id_8AD6)) {
    self._id_3BB3[var_0]._id_AA43 = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self._id_3BB3[var_0]._id_AA43 = 0;
    return 0;
  }

  thread _id_6F12(var_0, "iw7_atomizer_mp+atomizerscope");
  return 1;
}

_id_FDEF(var_0) {
  if(istrue(self._id_8AD6)) {
    self._id_3BB3[var_0]._id_AA43 = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self._id_3BB3[var_0]._id_AA43 = 0;
    return 0;
  }

  thread _id_6F12(var_0, "iw7_penetrationrail_mp+penetrationrailscope");
  return 1;
}

_id_FDC2(var_0) {
  if(istrue(self._id_8AD6)) {
    self._id_3BB3[var_0]._id_AA43 = 0;
    return 0;
  }

  if(self isswitchingweapon()) {
    self._id_3BB3[var_0]._id_AA43 = 0;
    return 0;
  }

  thread _id_6F12(var_0, "iw7_blackholegun_mp+blackholegunscope");
  return 1;
}

_id_6F12(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_2 = undefined;

  if(isweapon(var_1)) {
    var_2 = var_1;
  } else {
    var_2 = makeweaponfromstring(var_1);
  }

  var_3 = self getcurrentweapon();
  var_4 = 0;

  if(isnullweapon(var_3)) {
    var_4 = 1;
  } else if(scripts\engine\utility::array_contains(level._id_10D0, var_3)) {
    var_4 = 1;
  } else if(scripts\engine\utility::array_contains(level._id_10D0, var_3 _meth_8625())) {
    var_4 = 1;
  } else if(scripts\cp\utility::_id_8632(var_3, 1)) {
    var_4 = 1;
  }

  if(var_4) {
    self._id_3D58 = self getweaponslistall();
    var_3 = _id_073B::_id_3591(level._id_10D0, 1, 1);
  }

  self._id_8F79 = var_3;
  self._id_3D58 = undefined;
  thread _id_C53E(var_0, var_2, var_3);
  self endon(var_0 + "_exited_early");
  self endon("last_stand");
  wait(_id_6957());
  var_2 = scripts\cp\utility::_giveweapon(var_2, undefined, undefined, 0);
  self switchtoweaponimmediate(var_2);
  var_5 = _id_16D8(var_2);

  while(self getcurrentweapon() != var_2) {
    wait 0.05;
  }

  self notify("super_weapon_given");
  thread _id_F957(var_5, var_2);
}

_id_C53E(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("disconnect");
  self._id_8AD6 = 1;
  self._id_A2B7 = var_2;
  scripts\common\utility::_id_1575(0);
  scripts\engine\utility::_id_108A7(_id_6957() + 1, "super_weapon_given");
  self allowmelee(0);

  while(self isswitchingweapon()) {
    wait 0.05;
  }

  self allowmelee(1);

  if(self getcurrentweapon() == var_1 && scripts\cp\utility::_id_8580(var_0)) {
    var_3 = scripts\engine\utility::_id_1089B(var_0 + "_timeup", "last_stand", "weapon_switch_started", "weapon_purchased", "coaster_ride_beginning", "cards_replenished");
  } else {
    var_3 = undefined;
  }

  scripts\common\utility::_id_1575(1);

  if(!isDefined(var_3) || var_3 != var_0 + "_timeup") {
    self notify(var_0 + "_exited_early");
  }

  self._id_8AD6 = undefined;

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

  thread _id_4377();
  self._id_A2B7 = undefined;
  self._id_8F79 = undefined;
}

_id_16D8(var_0) {
  self endon("death");
  self endon("disconnect");
  var_1 = [];

  if(isDefined(var_0)) {
    var_1[getcompleteweaponname(var_0)] = self _meth_8109(var_0);
  } else {
    foreach(var_3 in self.weaponlist) {
      var_1[getcompleteweaponname(var_3)] = self _meth_8109(var_3);
    }
  }

  return var_1;
}

_id_F957(var_0, var_1) {
  self endon("death");
  self endon("disconnect");

  if(!isDefined(self.weaponlist)) {
    self.weaponlist = self getweaponslistprimaries();
  }

  var_2 = self.weaponlist;

  if(isDefined(var_1)) {
    var_2[var_2.size] = var_1;
  }

  self._id_74F1 = 1;
  scripts\cp\utility::_id_5201(1);

  while(istrue(self._id_74F1)) {
    var_3 = 0;

    foreach(var_5 in var_2) {
      if(var_5 == self getcurrentweapon() && _id_10D0A(var_5)) {
        var_3 = 1;
        self setweaponammoclip(var_5, weaponclipsize(var_5), "left");
      }

      if(var_5 == self getcurrentweapon() && _id_10D0A(var_5)) {
        var_3 = 1;
        self setweaponammoclip(var_5, weaponclipsize(var_5), "right");
      }

      if(var_3 == 0) {
        _id_16D8(var_1);
      }
    }

    wait 0.05;
  }
}

_id_10D0A(var_0) {
  var_1 = 1;

  if(isDefined(level._id_AC5A)) {
    foreach(var_3 in level._id_AC5A) {
      if(var_0.basename == var_3) {
        var_1 = 0;
      }
    }
  }

  return var_1;
}

_id_4377() {
  level endon("disconnect");
  level endon("game_ended");
  self._id_74F1 = undefined;
  wait 0.2;
  scripts\cp\utility::_id_5201(0);
}

_id_FDC8(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  level endon("game_ended");

  for(;;) {
    self waittill("shot_missed", var_1);

    if(!scripts\cp\cp_weapon::_id_8795(var_1)) {
      continue;
    }
    if(var_1 _meth_8624("g18pap1", 1) || var_1 _meth_8624("g18paap2")) {
      continue;
    }
    var_2 = self getweaponammoclip(var_1);
    self setweaponammoclip(var_1, var_2 + 1);
  }
}

_id_FDD8(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  level endon("game_ended");

  for(;;) {
    self waittill("player_damaged");

    if(self.health <= 45) {
      thread _id_D471();
      thread _id_8D8B();
      scripts\cp\utility::_id_A689(var_0);
    }
  }
}

_id_D471() {
  self notify("setAndRemoveInvulnerability");
  self endon("setAndRemoveInvulnerability");
  self endon("disconnect");
  level endon("game_ended");
  scripts\cp\utility::_id_10A2("near_death_consumable", 0.0, 0);
  scripts\engine\utility::_id_108AF(1, "death", "last_stand");
  scripts\cp\utility::_id_C48A("near_death_consumable", 0);
}

_id_8D8B(var_0) {
  var_1 = 128;
  var_2 = vectornormalize(anglesToForward(self.angles));
  var_3 = var_2 * var_1;
  var_4 = self.origin + var_3;
  physicsexplosionsphere(var_4, var_1, 1, 2.5);
  var_5 = _id_06FE::_id_68A1("axis");
  var_6 = scripts\engine\utility::_id_6369(self.origin, var_5, undefined, 24, 256);

  foreach(var_8 in var_6) {
    if(istrue(var_8._id_7D48)) {
      continue;
    }
    if(isDefined(var_8._id_1210) && (var_8._id_1210 == "zombie_sasquatch" || var_8._id_1210 == "slasher" || var_8._id_1210 == "superslasher" || var_8._id_1210 == "zombie_brute" || var_8._id_1210 == "zombie_grey" || var_8._id_1210 == "zombie_clown")) {
      continue;
    }
    var_8 playSound("zmb_fnf_second_wind_push");
    var_9 = 0;
    var_10 = var_8.origin;
    var_11 = var_8.maxhealth;
    var_2 = anglesToForward(self.angles);
    var_12 = vectornormalize(var_2) * -100;
    var_8 setvelocity(vectornormalize(var_8.origin - (self.origin + var_12)) * 800 + (0, 0, 300));
    var_8 _id_8D97(self, var_11, var_10, self.origin);
  }
}

_id_8D97(var_0, var_1, var_2, var_3) {
  self._id_4C08 = 1;

  if(var_1 >= self.health) {
    self._id_426B = 1;
  }

  self dodamage(var_1, var_2, var_0, var_0, "MOD_IMPACT", "zom_repulsor_mp");
}

_id_D049(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = var_0.origin;
  var_5 = (0, 128, 0);
  var_6 = var_0 getplayerangles();
  var_7 = 7;
  var_8 = 0;
  var_4 = var_4 + var_5[0] * anglestoright(var_6);
  var_4 = var_4 + var_5[1] * anglesToForward(var_6);
  var_4 = var_4 + var_5[2] * anglestoup(var_6);
  var_9 = _func_01C6(anglestoup(var_6), anglesToForward(var_6), var_7);
  var_10 = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_11 = scripts\engine\trace::ray_trace(var_0 getEye(), var_4 + var_9, var_0, var_10);
  var_4 = scripts\engine\utility::_id_5000(var_11["position"] + var_9 * -18, 32, -2000);
  var_12 = 0;

  foreach(var_15, var_14 in var_2) {
    if(scripts\engine\utility::_id_10E76(self getEye(), self.angles, var_14.origin, cos(65))) {
      if(distance2dsquared(self.origin, var_14.origin) < 1000000) {
        if(var_12 <= 5) {
          self._id_39F1[var_15] = var_14;
          var_3[var_12] = var_14.origin;
          var_12++;
          continue;
        }

        break;
      }
    }
  }

  var_3 = _func_02AA(var_0.origin, var_1, 5, undefined, var_4, 1200);
  return var_3;
}

_id_F350(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  level endon("game_ended");

  if(var_3 == 0 || var_3 == 3 || var_3 == 6) {
    playsoundatpos(var_1, "zmb_fnf_timely_torrent_lava");
  }

  playFX(level._effect["lava_torrent"], self.origin, undefined, anglestoup((0, 0, 90)));

  foreach(var_6 in var_2) {
    var_7 = (var_6.origin[0], var_6.origin[1], 90);

    if(isDefined(var_6._id_5D22) || isDefined(var_6._id_1210) && (var_6._id_1210 == "zombie_brute" || var_6._id_1210 == "zombie_ghost" || var_6._id_1210 == "zombie_grey" || var_6._id_1210 == "slasher" || var_6._id_1210 == "superslasher")) {
      continue;
    }
    if(distancesquared(var_6.origin, var_1) < 5184) {
      var_6._id_5D22 = 1;
      var_6._id_4C08 = 1;
      var_6._id_49D8 = 1;
      var_6 _meth_852B(0);
      var_6 setvelocity((0, 0, 600));
      wait 0.1;

      if(isDefined(var_6)) {
        var_6 dodamage(10000, var_1, var_4, var_4, "MOD_EXPLOSIVE");
      }
    }
  }

  self delete();
}

_id_FE13(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  level endon("game_ended");
  thread _id_CA0A(var_0);
}

_id_D04B(var_0, var_1) {
  if(!isDefined(var_0._id_1BBB)) {
    var_0._id_1BBB = [];
  }

  var_2 = var_0.origin;
  var_3 = (0, 128, 0);
  var_4 = var_0 getplayerangles();
  var_5 = 7;
  var_6 = 0;
  var_2 = var_2 + var_3[0] * anglestoright(var_4);
  var_2 = var_2 + var_3[1] * anglesToForward(var_4);
  var_2 = var_2 + var_3[2] * anglestoup(var_4);
  var_7 = _func_01C6(anglestoup(var_4), anglesToForward(var_4), 0);
  var_8 = physics_createcontents(["physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_ainoshoot", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_9 = scripts\engine\trace::ray_trace(var_0 getEye(), var_2 + var_7, var_0, var_8);
  var_2 = var_9["position"] + var_7;

  if(var_1 == 0) {
    var_0._id_1BBB[var_1] = var_2 + anglesToForward(var_4) * 60;
  } else {
    var_0._id_1BBB[var_1] = var_2 + anglesToForward(var_4) * (var_1 + 1) * 60;
  }

  return var_0._id_1BBB;
}

_id_CA0A(var_0) {
  self endon(var_0 + "_timeup");
  self endon("disconnect");
  level endon("game_ended");
  var_1 = [];
  var_2 = 0;

  for(;;) {
    self waittill("melee_fired");

    for(var_3 = 0; var_3 <= 5; var_3++) {
      var_1 = _id_D04B(self, var_3);
    }

    var_4 = 1200;
    self._id_39F1 = [];
    var_5 = _id_06FE::_id_6322();

    foreach(var_8, var_7 in var_1) {
      var_1[var_8] = spawn("script_origin", var_7);
    }

    foreach(var_8, var_7 in var_1) {
      if(!isDefined(var_7)) {
        continue;
      }
      var_7 thread _id_F350(var_0, var_7.origin, var_5, var_8, self);
    }

    scripts\cp\utility::_id_A689("timely_torrent");
  }
}

_id_FDF3(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  self endon(var_0 + "_exited_early");
  level endon("game_ended");

  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::_id_8708()) {
      var_2 thread _id_BE33(var_0, var_2, self);
    }
  }

  return 1;
}

_id_BE33(var_0, var_1, var_2) {
  level endon("game_ended");
  var_1 notify("force_regeneration");
  var_3 = scripts\engine\utility::_id_6369(self.origin, level.players, undefined, 24, 99999, 0);

  foreach(var_1 in var_3) {
    var_1 thread _id_43A5(var_0);
    wait 0.5;
  }

  var_2 scripts\cp\utility::_id_A689("purify");
}

_id_43A5(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 = _id_06FE::_id_6322();
  var_2 = scripts\engine\utility::_id_6369(self.origin, var_1, undefined, 24, 128, 0);

  if(var_2.size > 0) {
    self notify("force_regeneration");

    foreach(var_4 in var_2) {
      if(isDefined(var_4._id_1210) && (var_4._id_1210 == "zombie_brute" || var_4._id_1210 == "zombie_ghost" || var_4._id_1210 == "zombie_grey" || var_4._id_1210 == "slasher" || var_4._id_1210 == "superslasher")) {
        continue;
      } else {
        playFX(level._effect["penetration_railgun_explosion"], self.origin);
        var_4 dodamage(var_4.health + 100, var_4.origin, self, self, "MOD_EXPLOSIVE", "iw7_explosive_touch_zm");
      }
    }

    self playSound("zmb_fnf_purify_explo");
  }
}

_id_2EB9(var_0) {
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

_id_10BAB() {
  self endon("death");
  self endon("disconnect");
  self endon("removeReaper");
  level endon("game_ended");
  var_0 = (0, 0, 32);

  for(;;) {
    scripts\engine\utility::waittill_any_3("melee_fired", "ads_in", "ads_out");
    var_1 = self.origin + var_0;
    var_2 = anglesToForward(self.angles);
    var_3 = anglestoright(self.angles);
    self playrumbleonentity("damage_light");
    earthquake(0.2, 0.1, self.origin, 32);
    var_4 = _id_2EB9();
    var_4 = var_4 + var_0;
    var_5 = var_1 + var_3 * 64;
    var_6 = var_1 - var_3 * 32;
    var_7 = rotatevector(var_3, (0, 45, 0));
    var_8 = var_1 + var_7 * 64;
    var_9 = rotatevector(var_3, (0, 135, 0));
    var_10 = var_1 + var_9 * 32;
    var_11 = gettime();
    self._id_9D93.origin = var_5;
    wait 0.05;
    playFXOnTag(level._effect["swipe_trail"], self._id_9D93, "tag_origin");
    wait 0.05;
    self._id_9D93.origin = var_8;
    wait 0.05;
    self._id_9D93.origin = var_4;
    thread _id_19E6(var_4);
    wait 0.05;
    self._id_9D93.origin = var_10;
    wait 0.05;
    self._id_9D93.origin = var_6;
    wait 0.05;
    stopFXOnTag(level._effect["swipe_trail"], self._id_9D93, "tag_origin");
  }
}

_id_19E6(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeReaper");
  level endon("game_ended");
  var_1 = distance2d(self.origin, var_0) / 2;
  self radiusdamage(self.origin, var_1, 600, 300, self, "MOD_MELEE", "iw7_reaperblade_mp");
}

_id_FDE7(var_0) {
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  self endon(var_0 + "_exited_early");
  level endon("game_ended");
  thread _id_C51B(var_0);

  for(;;) {
    self waittill("player_damaged");
    _id_074E::_id_6F28(100, undefined, undefined, 1, "bonus");
  }
}

_id_FDD6(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  thread _id_C3B6(var_0);

  for(;;) {
    if(!istrue(self._id_74EF)) {
      self._id_74EF = 1;
      thread _id_10A70(var_0);
      scripts\cp\utility::_id_10A2("health_boost", 0.1, 0);
      self notify("force_regeneration");
      self playlocalsound("breathing_heartbeat_alt");
    }

    waitframe();
  }
}

_id_10A70(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");

  while(istrue(self._id_74EF)) {
    var_1 = _id_06FE::_id_6322();

    foreach(var_3 in var_1) {
      if(scripts\engine\utility::_id_4B8C(var_3.origin, self.origin) <= 5184) {
        var_3._id_579F = 1;

        if(var_3 scripts\cp\utility::_id_1216()) {
          continue;
        }
        if(var_3 scripts\cp\utility::_id_872B() && (!istrue(var_3._id_86BA) && var_3._id_1210 != "slasher" && var_3._id_1210 != "superslasher" && var_3._id_1210 != "zombie_brute" && var_3._id_1210 != "zombie_grey")) {
          var_3._id_A546 = 1;
          var_3._id_5FF5 = 1;
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

_id_C3B6(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_2(var_0 + "_timeup", var_0 + "_exited_early");
  self._id_74EF = 0;
  scripts\cp\utility::_id_C48A("health_boost", 0);

  if(isDefined(self._id_57EC)) {
    self._id_57EC delete();
  }
}

_id_FE00(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  self._id_9B31 = [];
  thread _id_97D1(var_0);
  thread _id_ACB3(var_0);
  thread _id_42D2(var_0);
}

_id_42D2(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");

  for(;;) {
    self waittill("weapon_hit_marked_target", var_1, var_2, var_3, var_4, var_5);
    self._id_9B31 = scripts\engine\utility::_id_1BD1(self._id_9B31);
    self._id_9B31 = scripts\engine\utility::array_remove(self._id_9B31, var_5);

    foreach(var_7 in self._id_9B31) {
      if(var_5 == var_7) {
        continue;
      }
      if(var_7.health >= var_7.maxhealth) {
        var_7 setscriptablepartstate("shared_fate_fx", "inactive", 1);
      }

      self._id_9B31 = scripts\engine\utility::array_remove(self._id_9B31, var_7);
      var_7 dodamage(var_2, var_7.origin, var_1, var_1, var_3, "iw7_shared_fate_weapon");
    }
  }
}

_id_B2F9(var_0, var_1, var_2) {
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
  }
}

_id_479E(var_0) {
  scripts\engine\utility::waittill_any_2(var_0 + "_exited_early", var_0 + "_timeup");
}

_id_ACB3(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");

  for(;;) {
    foreach(var_2 in self._id_9B31) {
      if(var_2 scripts\cp\utility::_id_1216()) {
        continue;
      }
      if(isDefined(var_2._id_1210) && (var_2._id_1210 == "zombie_sasquatch" || var_2._id_1210 == "slasher" || var_2._id_1210 == "superslasher" || var_2._id_1210 == "zombie_brute" || var_2._id_1210 == "zombie_grey" || var_2._id_1210 == "zombie_clown" || var_2._id_1210 == "skater")) {
        continue;
      }
      if(scripts\cp\utility::_id_8632(self getcurrentweapon()) || scripts\cp\utility::_id_10D02(self getcurrentweapon()) || scripts\cp\utility::_id_10D01(self getcurrentweapon())) {
        waitframe();
        continue;
      }

      if(istrue(var_2._id_9B34)) {
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

_id_97D1(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  var_1 = 0;

  for(;;) {
    if(self adsbuttonpressed() && !var_1) {
      if(scripts\cp\utility::_id_8632(self getcurrentweapon()) || scripts\cp\utility::_id_10D02(self getcurrentweapon())) {
        waitframe();
        continue;
      }

      var_1 = 1;
      var_2 = self getplayerangles();
      var_3 = self getEye();
      var_4 = anglesToForward(var_2);
      var_5 = var_3 + var_4 * 500;
      var_6 = scripts\engine\trace::_id_3EE5(1, 0, 0, 0, 0, 0, 0);
      var_7 = _func_02C1(var_3, var_5, var_6, self, 0, "physicsquery_closest");

      if(var_7.size <= 0) {
        waitframe();
        continue;
      }

      var_8 = var_7[0]["entity"];

      if(isDefined(var_8)) {
        if(isDefined(var_8._id_1210) && (var_8._id_1210 == "zombie_sasquatch" || var_8._id_1210 == "slasher" || var_8._id_1210 == "superslasher" || var_8._id_1210 == "zombie_brute" || var_8._id_1210 == "zombie_grey" || var_8._id_1210 == "zombie_clown")) {
          continue;
        }
        if(var_8 scripts\cp\utility::_id_872B()) {
          if(!scripts\engine\utility::array_contains(self._id_9B31, var_8)) {
            self playlocalsound("zmb_fnf_shared_fate_highlight");
            var_8._id_9B34 = 1;
            self._id_9B31 = scripts\engine\utility::array_add(self._id_9B31, var_8);
          }
        }
      }

      var_1 = 0;
    } else
      var_1 = 0;

    waitframe();
  }
}

_id_FDD7(var_0) {
  self endon(var_0 + "_timeup");
  self endon("last_stand");
  self endon("disconnect");
  level endon("game_ended");
  self._id_9367 = undefined;
  self._id_9368 = 1;
  var_1 = "j_spine4";
  var_2 = ["j_spine4", "j_spineupper", "j_spinelower", "j_head", "j_knee_ri", "j_knee_le", "j_elbow_ri", "j_elbow_le", "j_ankle_le", "j_ankle_ri", "j_wrist_le", "j_wrist_ri"];
  thread _id_C49C(var_0);
  thread _id_C49B(var_0);
  var_3 = self;

  for(;;) {
    var_4 = _id_6A38(self);

    if(isDefined(var_4)) {
      self._id_24D5 = var_4;
      self._id_9501 = 1;
      thread _id_B835(var_4, var_1, var_0);
      var_3._id_9367 = 1;
      _id_9518(self, var_4, var_2);
    } else {
      var_3._id_9367 = undefined;
      wait 0.5;
    }

    waitframe();
  }
}

_id_6A38(var_0) {
  var_1 = scripts\engine\utility::_id_6369(var_0.origin, level.players, [var_0], 4, 512);
  var_2 = _func_0204(var_1, var_0.origin);
  var_3 = undefined;

  foreach(var_5 in var_2) {
    var_6 = _func_0202(var_0 getEye(), var_5 getEye(), 0, var_0);

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

_id_9518(var_0, var_1, var_2) {
  while(istrue(var_0._id_9501)) {
    thread _id_43A4(self, var_2);

    if(istrue(var_1.inlaststand)) {
      var_0._id_9501 = undefined;
      var_0 notify("lost_target_fire_chains");
      break;
    } else if(distance(var_0.origin, var_1.origin) > 512) {
      var_0._id_9501 = undefined;
      var_0 notify("lost_target_fire_chains");
      break;
    }

    waitframe();
  }
}

_id_43A4(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\engine\trace::_id_3EE0();
  var_2 = [var_0, var_0._id_24D5];

  foreach(var_5 in var_1) {
    var_6 = scripts\engine\trace::ray_trace(var_0 gettagorigin(var_5), var_0._id_24D5 gettagorigin(var_5), var_2, var_3);

    if(isDefined(var_6["entity"])) {
      if(var_6["entity"] scripts\cp\utility::_id_872B() && (!istrue(var_6["entity"]._id_86BA) && var_6["entity"]._id_1210 != "slasher" && var_6["entity"]._id_1210 != "superslasher" && var_6["entity"]._id_1210 != "zombie_brute" && var_6["entity"]._id_1210 != "zombie_grey")) {
        scripts\engine\utility::array_add(var_2, var_6["entity"]);
        var_6["entity"]._id_A546 = 1;
        var_6["entity"]._id_5FF5 = 1;
        var_6["entity"] dodamage(1000000, var_6["entity"].origin, var_0, var_0);
      }
    }
  }
}

_id_B835(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in level.players) {
    var_3[var_3.size] = _func_0312(level._effect["fire_chains"], self, var_1, var_0, var_1, var_5);
  }

  self._id_6060 = var_3;
  self playLoopSound("zmb_fnf_fire_chains_lp");
  var_0 playLoopSound("zmb_fnf_fire_chains_lp");
  var_7 = scripts\engine\utility::_id_1088C(self, "disconnect", self, "lost_target_fire_chains", self, "last_stand", self, var_2 + "_timeup", var_0, "disconnect", var_0, "last_stand", level, "game_ended");

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

_id_C49B(var_0) {
  self endon(var_0 + "_timeup");
  self waittill("last_stand");
  self._id_9368 = undefined;
  self._id_9367 = undefined;

  if(isDefined(self._id_9501)) {
    self._id_9501 = undefined;
  }

  self notify(var_0 + "_exited_early");
}

_id_C49C(var_0) {
  self endon("last_stand");
  self waittill(var_0 + "_timeup");
  self._id_9368 = undefined;
  self._id_9367 = undefined;

  if(isDefined(self._id_9501)) {
    self._id_9501 = undefined;
  }
}

_id_FDE2(var_0) {
  self endon(var_0 + "_timeup");
  self endon("last_stand");
  self endon("disconnect");
  level endon("game_ended");
}

_id_853B(var_0) {
  self endon("disconnect");
  level endon("game_ended");

  if(!isDefined(var_0._id_E9C3)) {
    var_0._id_E9C3 = [];
  }

  foreach(var_3, var_2 in var_0._id_3BB3) {
    var_0._id_E9C3[var_3] = var_3;
  }

  for(;;) {
    var_4 = scripts\engine\utility::random(level._id_853C);

    if(scripts\engine\utility::array_contains(var_0._id_E9C3, var_4.name)) {
      waitframe();
      continue;
    } else {
      waitframe();
      return var_4;
    }

    waitframe();
  }
}

_id_38F1(var_0) {
  wait 5;
  self setclientomnvar(var_0, 0);
}

_id_3BAC(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("dpad_end_" + var_0);
  self endon("give_new_deck");
  self endon("last_stand");
  level._id_BFD9 = _id_853B(self);

  if(self._id_3BB3[var_0]._id_FEBF > 0 && self._id_3BB3[var_0]._id_AA43 == 0 && !_id_073B::_id_B4EF(self)) {
    self._id_3BB3[level._id_BFD9.name] = spawnStruct();
    self._id_3BB3[level._id_BFD9.name]._id_FEBF = level._id_3BB3[level._id_BFD9.name]._id_FEBF;
    self._id_3BB3[level._id_BFD9.name]._id_AA43 = 1;
    self._id_3BB3[level._id_BFD9.name]._id_F26C = 0;
    self._id_3BB3[level._id_BFD9.name]._id_FE50 = var_4;
    level._id_BFD9._id_C189 = int(_func_0222("cp/loot/iw7_zombiefatefortune_loot_master.csv", 1, level._id_BFD9.name, 0));
    self setclientomnvar("zm_fate_card_used", var_5);
    self._id_3BB3[var_0]._id_BD71 = 1;
    var_7 = undefined;
    var_8 = "fired_super";
    thread _id_D18E(var_0);

    if(isDefined(level._id_3BB3[level._id_BFD9.name]._id_FE73)) {
      if(isDefined(level._id_3BB3[level._id_BFD9.name]._id_F0D7)) {
        var_7 = self[[level._id_3BB3[level._id_BFD9.name]._id_FE73]](level._id_BFD9.name);
      } else {
        var_7 = self thread[[level._id_3BB3[level._id_BFD9.name]._id_FE73]](level._id_BFD9.name);
      }
    }

    self._id_3BB3[var_0]._id_AA43 = 0;

    if(!isDefined(var_7) || isDefined(var_7) && var_7) {
      _id_3BB7(self, var_0);
      self._id_3BB3[var_0]._id_F26C++;
      _id_0741::_id_BD77("mt_faf_uses");
      thread _id_076F::_id_F72D("wonder_consume", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);

      if(self._id_3BB3[var_0]._id_F26C == 1) {
        thread _id_454D(var_0);
      }

      thread _id_945B();
      self _meth_82F8("zm_card_fill_display", var_5, 1);
      _id_C38C(var_6);
      thread _id_9DEF();
      self playlocalsound("ui_consumable_select");
      _id_B20F(self);
      self notify("consumable_selected");
      self setweaponammostock(self._id_59D7, 1);
      self _meth_852A(self._id_59D7);
      self._id_3BAF = undefined;
      level thread _id_076F::_id_C3D1("nag_use_fateandfort");
      var_9 = level._id_3BB3[level._id_BFD9.name].type;

      if(var_9 == "timedactivations") {
        thread _id_4EBE(level._id_BFD9.name, level._id_3BB3[level._id_BFD9.name]._id_FDB7, var_1, var_8, var_2, var_3, var_4, var_5);
      } else if(var_9 == "wave") {
        thread _id_4EC0(level._id_BFD9.name, level._id_3BB3[level._id_BFD9.name]._id_FDB7, var_1, var_8, var_2, var_3, var_4, var_5);
      } else if(var_9 == "triggernow" || level._id_3BB3[level._id_BFD9.name].type == "triggerwait") {
        thread _id_4EBD(level._id_BFD9.name, level._id_3BB3[level._id_BFD9.name].type, self._id_3BB3[level._id_BFD9.name]._id_FEBF, var_1, var_8, var_2, var_3, var_4, var_5);
      } else if(var_9 == "triggerpassive") {
        thread _id_4EBF(level._id_BFD9.name, level._id_3BB3[level._id_BFD9.name]._id_AEAE, var_1, var_8, var_2, var_3, var_4, var_5);
      }

      if(isDefined(var_7)) {
        scripts\cp\utility::_id_A689(var_0);
        return;
      }
    } else {
      self playlocalsound("ui_consumable_deny");
      self._id_3BB3[var_0]._id_BD71 = undefined;
    }
  }
}

_id_FE0D(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  self endon(var_0 + "_timeup");
  self endon("last_stand");
  self._id_F07B = 2;
  thread _id_C455(var_0);
}

_id_C455(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::_id_10882(var_0 + "_timeup", "disconnect", "death", var_0 + "_exited_early");
  self._id_F07B = undefined;
  return 1;
}

_id_FE1C(var_0) {
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
  thread _id_C456(var_0, self);
  thread _id_0EDF(self.origin, var_0);
}

_id_C456(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 scripts\engine\utility::_id_10882(var_0 + "_timeup", var_0 + "_exited_early", "last_stand", "death");
  level notify("stop_twister_sfx");

  if(isDefined(var_1._id_6063)) {
    var_1._id_6063 delete();
  }

  if(isDefined(var_1._id_F5CD)) {
    var_1._id_F5CD delete();
  }
}

_id_0EDF(var_0, var_1) {
  self endon("disconnect");
  self endon(var_1 + "_timeup");
  self endon(var_1 + "_exited_early");
  level endon("game_ended");
  self endon("death");
  self endon("last_stand");

  if(!isDefined(self._id_F8D9)) {
    self._id_F8D9 = [];
  }

  self._id_F5CD = spawn("script_model", var_0, 0, 512, 128);
  self._id_F5CD setModel("tag_origin");
  level._id_F5CE = spawn("script_model", var_0, 0, 512, 128);
  level._id_F5CE linkto(self._id_F5CD);
  wait 0.5;
  level._id_F5CE thread _id_F8DA();
  playFXOnTag(level._effect["twister"], self._id_F5CD, "tag_origin");
  self._id_F5CD setotherent(self);
  self._id_F5CD thread _id_43A3(self, var_1);
  thread _id_A1D7(self._id_F5CD, var_1);
}

_id_F8DA() {
  self playSound("fnf_tornado_start_lr");
  wait 0.4;
  self playLoopSound("fnf_tornado_lr_lp");
  level waittill("stop_twister_sfx");
  level thread scripts\engine\utility::_id_B2DA("fnf_tornado_stop_lr", self.origin);
  wait 0.15;
  self stoploopsound();
  self delete();
}

_id_6872(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 endon(var_1 + "_timeup");
  var_0 endon(var_1 + "_exited_early");
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("last_stand");

  for(;;) {
    var_2 = _id_06FE::_id_6322();
    var_3 = scripts\engine\utility::_id_6369(var_0.origin, var_2, undefined, 24, 2048);

    if(var_3.size <= 0) {
      waitframe();
      var_0._id_F8D9 = [];
      var_0._id_F8D9[var_0._id_F8D9.size] = _func_02AB(self.origin) + (0, 10, 0);
      continue;
    } else {
      foreach(var_5 in var_3) {
        if(istrue(var_5._id_54D1)) {
          var_0._id_F8D9 = var_0 _meth_847B(var_0.origin, scripts\engine\utility::_id_5000(var_3[var_3.size - 1].origin, 1, 1));
        }
      }
    }

    wait 2.5;
  }
}

_id_43A3(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("last_stand");
  self endon("death");
  var_0 endon("disconnect");
  var_0 endon(var_1 + "_timeup");
  var_0 endon(var_1 + "_exited_early");
  level endon("game_ended");

  for(;;) {
    var_2 = _id_06FE::_id_6322();

    foreach(var_4 in var_2) {
      if(!isDefined(var_4)) {
        continue;
      }
      if(!var_4 scripts\cp\utility::_id_872B()) {
        continue;
      }
      if(var_4 scripts\cp\utility::_id_1216()) {
        continue;
      }
      if(distance2dsquared(self.origin, var_4.origin) < 22500) {
        if(isDefined(var_4._id_1210) && (var_4._id_1210 == "slasher" || var_4._id_1210 == "superslasher")) {
          var_4 dodamage(1000, var_4.origin, var_0, var_0, "MOD_UNKNOWN");
          continue;
        }

        var_4 thread _id_5CFC(var_4.health + 1000, var_4, var_0, self);
      }
    }

    wait 1;
  }
}

_id_5CFC(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_3 endon("death");

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_1.origin - var_3.origin;
  var_5 = anglestoup(self.angles);
  self setvelocity(vectornormalize((var_3.origin - self.origin) * 400) + (0, 0, 800));
  wait 0.16;

  if(isDefined(var_2)) {
    var_1._id_4C08 = 1;
    var_1._id_49D8 = 1;
    var_1._id_426B = 1;
    wait 0.1;
    var_1._id_A546 = 1;
    var_1._id_5FF5 = 1;
    self dodamage(self.health + 1000, var_1.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_twister_zm");
  } else {
    self._id_A546 = 1;
    self._id_5FF5 = 1;
    self dodamage(self.health + 1000, var_1.origin, var_1, var_1, "MOD_UNKNOWN", "iw7_twister_zm");
  }
}

_id_A1D7(var_0, var_1) {
  self endon("death");
  self endon("last_stand");
  self endon("disconnect");
  self endon(var_1 + "_timeup");
  self endon(var_1 + "_exited_early");
  var_2 = 0;
  thread _id_6872(self, var_1);

  for(;;) {
    if(!isDefined(self._id_F8D9[var_2]) && var_2 >= self._id_F8D9.size) {
      if(self._id_F8D9.size > 0) {
        if(isDefined(self._id_F8D9[0])) {
          if([[level._id_0F34]](self._id_F8D9[0])) {
            var_0 moveto(self._id_F8D9[0], 0.5, 0.25, 0);
          } else {
            var_3 = _func_02AB(self._id_F8D9[0]) + (0, 10, 0);
            var_0 moveto(var_3, 0.5, 0.25, 0);
          }

          var_2--;
        }
      } else
        var_2 = 0;

      waitframe();
      continue;
    } else
      var_0 moveto(self._id_F8D9[var_2], 0.5, 0, 0);

    var_2 = var_2 + 1;
    waitframe();
  }
}

_id_FDFE(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_exited_early");
  _id_073B::_id_521F(self);
  thread _id_C518(var_0);

  for(;;) {
    self waittill("player_has_self_revive", var_1);

    if(var_1) {
      continue;
    }
    self waittill("revive");
    _id_073B::_id_4A48(self);

    if(scripts\cp\utility::_id_7531("perk_machine_tough")) {
      self.maxhealth = 200;
      self.health = self.maxhealth;
    }

    scripts\cp\utility::_id_A689(var_0);
    break;
  }
}

_id_C518(var_0) {
  self endon(var_0 + " activated");
  self endon("disconnect");
  level endon("game_ended");
  self waittill(var_0 + "_exited_early");
  _id_073B::_id_4A48(self);
}

_id_FE1F(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  var_1 = _id_074E::_id_666A();
  var_2 = int(var_1 / level.players.size);
  _id_074E::_id_D337(var_2);

  foreach(var_4 in level.players) {
    if(var_4 == self) {
      continue;
    }
    var_4 _id_074E::_id_6F28(var_2, undefined, undefined, 1, "bonus");
  }

  scripts\cp\utility::_id_A689(var_0);
  return 1;
}

_id_FDE1(var_0) {
  self endon(var_0 + "_timeup");
  self endon("disconnect");
  self endon("last_stand");
  self endon("death");

  if(!isDefined(level._id_3BAD)) {
    level._id_3BAD = 0;
  }

  thread _id_FBDA(var_0);
  thread _id_386D(var_0);
  setomnvar("zom_escape_combo_multiplier", 1);

  for(;;) {
    var_1 = scripts\engine\utility::_id_10897("shot_missed", "weapon_hit_enemy");

    if(var_1 == "shot_missed") {
      level._id_3BAD = level._id_3BAD - 0.02;
    } else {
      level._id_3BAD = level._id_3BAD + 0.02;
    }

    if(level._id_3BAD < 0) {
      level._id_3BAD = 0;
    }

    self notify("update_team_efficiency");
  }
}

_id_FBDA(var_0) {
  while(isDefined(level._id_3BAD)) {
    self waittill("update_team_efficiency");
    var_1 = 1 + level._id_3BAD;
    setomnvar("zom_escape_combo_multiplier", var_1);
  }

  setomnvar("zom_escape_combo_multiplier", -1);
}

_id_386D(var_0) {
  var_1 = scripts\engine\utility::_id_10899(var_0 + "_timeup", "disconnect", "last_stand", "death");
  level._id_3BAD = undefined;
}

_id_FE01(var_0) {
  self endon(var_0 + "_timeup");
  self endon("disconnect");
  thread _id_C51B(var_0);

  foreach(var_2 in _id_06FE::_id_68A1("axis")) {
    var_2 thread _id_11A6(var_2, var_0, self);
  }

  for(;;) {
    level waittill("agent_spawned", var_4);
    var_4 thread _id_11A6(var_4, var_0, self, 1);
  }
}

_id_11A6(var_0, var_1, var_2, var_3) {
  var_0 endon("death");

  if(isDefined(var_0._id_1210) && (var_0._id_1210 == "zombie_brute" || var_0._id_1210 == "zombie_grey" || var_0._id_1210 == "zombie_ghost")) {
    return;
  }
  if(istrue(var_0._id_86D9)) {
    return;
  }
  if(istrue(var_3)) {
    wait 0.5;
  }

  if(!isDefined(var_0._id_1C30._id_4130)) {
    var_4 = var_0._id_02D6;
  } else {
    var_4 = var_0._id_1C30._id_4130;
  }

  switch (var_4) {
    case "slow_walk":
      break;
    case "walk":
    case "run":
    case "sprint":
      var_0 _id_06BD::_id_23F3("slow_walk");
      break;
  }

  var_2 scripts\engine\utility::waittill_any_3(var_1 + "_timeup", "last_stand", "disconnect");
  var_0 _id_06BD::_id_23F3(var_4);
}

_id_C51B(var_0) {
  self endon(var_0 + "_timeup");
  self waittill("last_stand");
  self notify(var_0 + "_exited_early");
}

_id_FDE5(var_0) {
  self endon(var_0 + "_timeup");
  self endon("last_stand");
  self endon("disconnect");
  level endon("game_ended");
  self._id_9367 = undefined;
  self._id_9368 = 1;
  var_1 = "j_spine4";
  thread _id_C48C(var_0);
  thread _id_C48B(var_0);
  var_2 = self;

  for(;;) {
    var_3 = _id_6B08(self);

    if(isDefined(var_3)) {
      self notify("lost_target", var_3);
      self._id_9501 = 1;
      thread _id_B875(var_3, var_1, var_0);
      var_2._id_9367 = 1;
      _id_9517(self, var_3);
      continue;
    }

    var_2._id_9367 = undefined;
    wait 0.5;
  }
}

_id_6B08(var_0) {
  var_1 = scripts\engine\utility::_id_6369(var_0.origin, level.players, [var_0], 4, 512);
  var_2 = _func_0204(var_1, var_0.origin);
  var_3 = undefined;

  foreach(var_5 in var_2) {
    var_6 = _func_0202(var_0 getEye(), var_5 getEye(), 0, var_0);

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

_id_9517(var_0, var_1) {
  var_0 endon("disconnect");

  while(istrue(var_0._id_9501)) {
    if(istrue(var_1.inlaststand)) {
      var_0._id_9501 = undefined;
      var_0 notify("lost_target");
      break;
    } else if(distance(var_0.origin, var_1.origin) > 512) {
      var_0._id_9501 = undefined;
      var_0 notify("lost_target");
      break;
    } else {
      var_2 = _func_0202(var_0 getEye(), var_1 getEye(), 0, var_0);

      if(!var_2) {
        var_0._id_9501 = undefined;
        var_0 notify("lost_target");
      }
    }

    wait 0.25;
  }
}

_id_B875(var_0, var_1, var_2) {
  var_0 endon("disconnect");
  self endon("disconnect");
  var_3 = [];
  playFXOnTag(level._effect["life_link_target"], var_0, var_1);

  foreach(var_5 in level.players) {
    var_3[var_3.size] = _func_0312(level._effect["life_link"], self, var_1, var_0, var_1, var_5);
  }

  self playLoopSound("zmb_fnf_lifelink_heal_lp");
  var_0 playLoopSound("zmb_fnf_lifelink_heal_lp");
  var_7 = scripts\engine\utility::_id_1088C(self, "disconnect", self, "lost_target", self, "last_stand", self, var_2 + "_timeup", var_0, "disconnect", var_0, "last_stand", level, "game_ended");

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
    _func_012F(level._effect["life_link_target"], var_0, var_1);
  }
}

_id_C48B(var_0) {
  self endon(var_0 + "_timeup");
  self waittill("last_stand");
  self._id_9368 = undefined;
  self._id_9367 = undefined;

  if(isDefined(self._id_9501)) {
    self._id_9501 = undefined;
  }

  self notify(var_0 + "_exited_early");
}

_id_C48C(var_0) {
  self endon("last_stand");
  self waittill(var_0 + "_timeup");
  self._id_9368 = undefined;
  self._id_9367 = undefined;

  if(isDefined(self._id_9501)) {
    self._id_9501 = undefined;
  }
}

_id_FDF0(var_0) {
  var_1 = level.players;
  var_2 = 0;

  foreach(var_4 in var_1) {
    var_5 = var_4;

    if(isDefined(var_4.owner)) {
      var_5 = var_4.owner;
    }

    if(_id_073B::_id_B4EF(var_5)) {
      var_2 = 1;
      _id_073B::_id_8302(var_5);
      _id_073B::_id_C13D(self, var_5);
    }
  }

  if(!var_2) {
    self._id_3BB3["phoenix_up"]._id_AA43 = 0;
    waitframe();
    return 0;
  }

  wait 0.25;
  scripts\cp\utility::_id_A689("phoenix_up");
  return 1;
}

_id_FDE3(var_0) {
  level endon("game_ended");

  foreach(var_2 in level.players) {
    if(!isDefined(var_2._id_8D86)) {
      var_2._id_8D86 = 0;
    }

    var_2._id_8D86++;
  }

  waitframe();
  scripts\cp\utility::_id_A689("killing_time");
  scripts\engine\utility::_id_108A9(20, "death", "last_stand", "disconnect");

  foreach(var_2 in level.players) {
    if(isDefined(var_2._id_8D86)) {
      var_2._id_8D86--;

      if(var_2._id_8D86 <= 0) {
        var_2._id_8D86 = undefined;
      }
    }
  }
}

_id_FDE9(var_0) {
  level endon("game_ended");
  self endon("last_stand");
  self endon("disconnect");
  thread _id_C4EF(var_0);

  foreach(var_2 in level.players) {
    if(var_2 == self) {
      if(var_2 scripts\cp\utility::_id_88B5()) {
        var_2 scripts\cp\utility::_id_1566(0);
      }

      continue;
    }

    var_2 scripts\cp\utility::_id_1566(1);
  }

  wait 10;

  foreach(var_2 in level.players) {
    if(var_2 scripts\cp\utility::_id_88B5()) {
      var_2 scripts\cp\utility::_id_1566(0);
    }
  }
}

_id_C4EF(var_0) {
  self endon(var_0 + "_timeup");
  var_1 = scripts\engine\utility::_id_10897("last_stand", "disconnect");

  foreach(var_3 in level.players) {
    if(var_3 scripts\cp\utility::_id_88B5()) {
      var_3 scripts\cp\utility::_id_1566(0);
    }
  }

  if(isDefined(var_1) && var_1 == "last_stand") {
    self notify(var_0 + "_exited_early");
  }
}

_id_FDBF(var_0) {
  if(!scripts\cp\utility::_id_8A9C()) {
    self._id_3BB3["anywhere_but_here"]._id_AA43 = 0;
    return 0;
  }

  if(istrue(self._id_8606)) {
    self._id_3BB3["anywhere_but_here"]._id_AA43 = 0;
    return 0;
  }

  var_1 = level._id_0F26;
  var_1 = scripts\engine\utility::_id_1BC1(var_1);

  foreach(var_3 in level._id_0F26) {
    var_4 = [[level._id_676A]]();

    foreach(var_6 in var_4) {
      if(_func_011A(var_3.origin, var_6)) {
        var_1 = scripts\engine\utility::array_remove(var_1, var_3);
      }
    }
  }

  if(var_1.size < 1) {
    var_1 = level._id_0F26;
  }

  var_9 = self[[level._id_6700]](level.players, var_1);

  if(!isDefined(var_9)) {
    self._id_3BB3["anywhere_but_here"]._id_AA43 = 0;
    return 0;
  }

  _id_0737::_id_C1A2();
  _id_0753::_id_BAA4();
  self _meth_80FC();
  self setorigin(var_9.origin);
  self setplayerangles(var_9.angles);
  self notify("left_hidden_room_early");
  scripts\cp\utility::_id_A689("anywhere_but_here");
  self._id_0E04 = gettime();
  return 1;
}

_id_8CA6(var_0) {
  level endon("game_ended");
  level.players[0] endon("death");
  level.players[0] endon("last_stand");

  foreach(var_2 in level._id_0F26) {
    level.players[0] _id_0737::_id_C1A2();
    level.players[0] _id_0753::_id_BAA4();
    level.players[0] _meth_80FC();
    level.players[0] setorigin(var_2.origin);
    level.players[0] setplayerangles(var_2.angles);
    wait 2;
  }
}

_id_FDDE(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_0 + "_timeup");
  self._id_761B = gettime();
}

_id_761A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!scripts\cp\utility::_id_8580("headshot_reload")) {
    return 0;
  }

  if(!scripts\engine\utility::_id_8794(var_3)) {
    return 0;
  }

  if(!scripts\cp\utility::_id_8891(var_4, var_6, var_3, var_1)) {
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

  if(self _meth_81BC()) {
    var_12 = self getweaponammoclip(var_9, "left");
    var_15 = min(var_12 + var_14, var_11);
    self setweaponammoclip(var_9, int(var_15), "left");
  }
}

_id_FDDD(var_0) {
  self._id_BA9B = 1;
  _id_0753::_id_BA96(1, "primary");
  var_1 = getarraykeys(self._id_BADE);

  foreach(var_3 in var_1) {
    self._id_BADE[var_3]._id_3D0D = 1;
  }
}

_id_F7EF(var_0) {
  self._id_BA9B = 0;
}

_id_640F(var_0) {
  return _func_0222("cp/loot/iw7_zombiefatefortune_loot_master.csv", 1, var_0, 0);
}

_id_D18E(var_0) {
  return self[[level._id_3BB3[var_0]._id_D12B]](var_0);
}

_id_F9B7(var_0) {
  self[[level._id_3BB3[var_0]._id_F9B2]](var_0);
}