/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\cp_killstreaks.gsc
*************************************************/

init_killstreaks() {
  level._id_8DEB = ::streakglobals_on_killstreak_triggered;
  level._id_8DC6 = ::streakglobals_on_killstreak_begin_use;
  level._id_8DD3 = ::streakglobals_on_killstreak_finish_use;
  var_0 = spawnStruct();
  level._id_8DD5 = var_0;
  level._id_8DEE = [];
  parse_streak_table();
  init_killstreak_types();
  _id_0961::_id_C28D(::on_player_spawned);
  _id_095C::_id_C287(::_id_9551);
}

parse_streak_table() {
  var_0 = level._id_8DD5;

  if(isDefined(game["killstreakTable"])) {
    var_0._id_EA18 = game["killstreakTable"];
    return;
  }

  var_1 = spawnStruct();
  game["killstreakTable"] = var_1;
  var_0._id_EA18 = var_1;
  var_1._id_EC74 = [];
  var_2 = tablelookupgetnumrows("cp/killstreaks.csv");

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = tablelookupbyrow("cp/killstreaks.csv", var_3, 1);

    if(var_4 == "" || var_4 == "none") {
      continue;
    }
    var_1._id_EC74[var_4] = [];
    var_1._id_EC74[var_4]["index"] = int(tablelookupbyrow("cp/killstreaks.csv", var_3, 0));
    var_1._id_EC74[var_4]["hudIcon"] = tablelookupbyrow("cp/killstreaks.csv", var_3, 12);
    var_1._id_EC74[var_4]["overheadIcon"] = tablelookupbyrow("cp/killstreaks.csv", var_3, 13);
    var_1._id_EC74[var_4]["name"] = tablelookupbyrow("cp/killstreaks.csv", var_3, 2);
    var_1._id_EC74[var_4]["shownInMenu"] = tablelookupbyrow("cp/killstreaks.csv", var_3, 16);
    var_1._id_EC74[var_4]["workInProgress"] = tablelookupbyrow("cp/killstreaks.csv", var_3, 27);
    var_1._id_EC74[var_4]["type"] = tablelookupbyrow("cp/killstreaks.csv", var_3, 19);

    if(var_4 != "none") {}
  }
}

init_killstreak_types() {
  scripts\cp\killstreaks\warmachine::init_warmachine();
  scripts\cp\killstreaks\lmg_streak::init_lmg_streak();
}

register_killstreak(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_8DE6)) {
    level._id_8DE6 = [];
  }

  var_5 = spawnStruct();
  level._id_8DE6[var_0] = var_5;
  var_5._id_F61A = var_1;
  var_5._id_1F91 = var_2;
  var_5.removedfunc = var_3;
  level._id_8DEE[var_4] = var_0;
}

_id_9551(var_0, var_1) {
  if(isDefined(var_0) && var_0 == "streak_select") {
    _id_4D05(undefined, var_1);
  }
}

_id_4D05(var_0, var_1) {
  var_2 = self._id_E9FF.streak;

  if(!isDefined(var_2)) {
    return;
  }
  thread _id_F62A(var_2, var_1);
}

_id_F62A(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_2 = var_0._id_EA15;

  if(!scripts\common\utility::_id_861B() || _id_073B::_id_B4EF(self)) {
    scripts\cp\cp_hud_message::_id_DCA2("KILLSTREAKS/CANNOT_BE_USED");
    return 0;
  }

  if(isDefined(self._id_F628) && self._id_F628 == var_0) {
    return 0;
  }

  self._id_F628 = var_0;
  var_2 = var_0._id_EA15;
  var_3 = spawnStruct();
  var_3.streakname = var_0.streakname;
  var_3.owner = self;
  var_3._id_7C8C = _id_6E22(self);
  var_3._id_038F = 0;
  var_3._id_DA63 = 0;
  var_3._id_79B5 = 0;
  var_3.damage = 0;
  var_3._id_0267 = 0;
  var_3.additionalparams = var_0.additionalparams;
  var_4 = self[[var_2._id_F61A]](var_3);

  if(istrue(var_4) && isDefined(var_1)) {
    _id_ABB2(var_0, var_1);
  }

  self._id_F628 = undefined;
  return 1;
}

_id_ABB2(var_0, var_1) {
  var_2 = var_0.streakname;
  var_0._id_1F84 = -1;
  _set_client_killstreak_availability(var_1, var_0._id_1F84);
  _id_C4DC();
  update_killstreak_ui_slot(var_1);
}

_id_6E22(var_0) {
  if(!isDefined(var_0.pers["nextKillstreakID"])) {
    var_0.pers["nextKillstreakID"] = 0;
  }

  var_1 = var_0.pers["nextKillstreakID"];
  var_0.pers["nextKillstreakID"]++;
  return var_1;
}

streakglobals_on_killstreak_triggered(var_0) {
  if(isDefined(var_0._id_A2B6)) {
    var_1 = on_killstreak_triggered(var_0);

    if(!var_1) {
      return 0;
    }
  }

  return 1;
}

streakglobals_on_killstreak_begin_use(var_0) {
  var_1 = var_0.owner;

  if(isDefined(var_0._id_A2B6)) {
    var_2 = on_killstreak_begin_use(var_0);

    if(!var_2) {
      return 0;
    }
  }

  if(isDefined(var_1)) {
    var_3 = var_1 getentitynumber();
  }

  var_1 notify("begin_use_streak");
  return 1;
}

streakglobals_on_killstreak_finish_use(var_0) {
  var_1 = var_0.owner;
  var_2 = 0;

  if(isDefined(var_1)) {
    var_2 = var_1 _id_7599(var_0);
  }

  if(isDefined(var_0._id_A2B6)) {
    on_killstreak_finish_use(var_0, var_2);
  }

  if(istrue(var_0._id_C0B4)) {
    var_0._id_C0B4 = undefined;
  }

  if(isDefined(var_1)) {
    if(!var_2) {
      var_1 notify("killstreak_use_finished");
    }

    if(level.codcasterenabled) {
      var_1 _meth_80CD(0);
    }
  }

  var_1 notify("end_use_streak");
}

on_killstreak_triggered(var_0) {
  return 1;
}

on_killstreak_begin_use(var_0) {
  var_1 = var_0.owner;

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!var_1 _id_FF5A(var_0.streakname)) {
    return 0;
  }

  return 1;
}

on_killstreak_finish_use(var_0, var_1) {}

_id_FF5A(var_0, var_1) {
  if(isDefined(self._id_D069)) {
    return 0;
  }

  if(!scripts\common\utility::_id_871C()) {
    return 0;
  }

  return 1;
}

_id_7599(var_0) {
  return 0;
}

is_killstreak_name(var_0) {
  return isDefined(level._id_8DD5._id_EA18._id_EC74[var_0]);
}

get_killstreak_weapon_from_ref(var_0) {
  foreach(var_3, var_2 in level._id_8DEE) {
    if(var_0 == var_2) {
      return var_3;
    }
  }

  return undefined;
}

get_killstreak_name_from_weapon(var_0) {
  var_1 = var_0.basename;

  if(isDefined(level._id_8DEE[var_1])) {
    return level._id_8DEE[var_1];
  }

  return undefined;
}

on_player_spawned() {
  if(isDefined(level._id_43FA) && !level._id_43FA) {
    reset_streak_availability(1);
  }

  self._id_F628 = undefined;
  self._id_E9FF = spawnStruct();
  self setclientomnvar("ui_score_streak_index_1", 0);
  self setclientomnvar("ui_score_streak_index_2", 0);
  self setclientomnvar("ui_score_streak_index_3", 0);
  update_killstreak_selected_ui();
  update_killstreak_ui_slots();
}

reset_streak_availability(var_0) {
  if(!isDefined(self)) {
    return;
  }
  var_1 = get_current_killstreak_struct();

  if(isDefined(var_1) && isDefined(var_1.streakname)) {
    if(istrue(var_0)) {
      var_1._id_1F84 = 0;
    } else if(istrue(var_1._id_8A51)) {
      var_1._id_1F84 = 0;
    } else if(var_1._id_1F84 == -1) {
      var_1._id_1F84 = 0;
    }

    _set_client_killstreak_availability(var_1._id_1F84);
  }
}

_set_client_killstreak_availability(var_0, var_1) {
  if(var_1 < 0) {
    var_1 = 0;
  }
}

_set_client_killstreak_indexes(var_0, var_1) {}

update_killstreak_selected_ui() {
  var_0 = get_selected_killstreak_index();

  if(isDefined(var_0)) {
    self setclientomnvar("ui_score_streak_selected_slot", var_0);
  } else {
    self setclientomnvar("ui_score_streak_selected_slot", -1);
  }
}

get_selected_killstreak_index() {
  return 0;
}

get_current_killstreak_struct() {
  return self._id_E9FF.streak;
}

update_killstreak_ui_slots() {
  if(!scripts\cp\utility\player::isreallyalive(self)) {
    return;
  }
  var_0 = level._id_8DD5;
  update_killstreak_ui_slot(0);
}

update_killstreak_ui_slot(var_0) {
  var_1 = level._id_8DD5;
  var_2 = get_current_killstreak_struct();

  if(isDefined(var_2) && isDefined(var_2.streakname)) {
    var_3 = get_killstreak_index(var_2.streakname);
    self setclientomnvar("ui_score_streak_index_0", var_3);
    self setclientomnvar("ui_zm_score_streak_available", var_2._id_1F84);
    _set_client_killstreak_indexes(var_0, var_3);
    _set_client_killstreak_availability(var_0, var_2._id_1F84);
  } else {
    self setclientomnvar("ui_score_streak_index_0", 0);
    self setclientomnvar("ui_zm_score_streak_available", 0);
    _set_client_killstreak_indexes(var_0, 0);
    _set_client_killstreak_availability(var_0, 0);
  }
}

get_killstreak_index(var_0) {
  return level._id_8DD5._id_EA18._id_EC74[var_0]["index"];
}

drop_current_killstreak(var_0, var_1, var_2) {
  if(isDefined(self._id_E9FF.streak)) {
    var_3 = self._id_E9FF.streak.streakname;
    var_4 = _id_C4DC();
    _id_092E::spawn_killstreak(var_3, var_0, var_1, var_2, 1, undefined, var_4);
  }
}

grant_killstreak(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self getcurrentweapon();

  if(isDefined(self._id_E9FF.streak)) {
    drop_current_killstreak(var_1, var_2, var_3);
  }

  var_6 = create_streak_item_struct(var_0, var_4);
  award_killstreak_from_struct(var_6);

  if(isDefined(self.previousweaponbeforekillstreak) && scripts\cp\utility::_id_88F6(var_5.basename)) {
    self switchtoweapon(self.previousweaponbeforekillstreak);
  }
}

create_streak_item_struct(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_1F84 = 0;
  var_2.streakname = var_0;
  var_2._id_EA15 = get_killstreak_setup_info(var_0);
  var_2._id_9925 = -1;
  var_2.additionalparams = var_1;
  return var_2;
}

get_killstreak_setup_info(var_0) {
  var_1 = level._id_8DE6[var_0];
  return var_1;
}

award_killstreak_from_struct(var_0, var_1, var_2, var_3, var_4) {
  var_0._id_887C = 1;
  var_5 = 0;

  if(isDefined(var_4)) {
    var_5 = var_4;
  }

  if(isDefined(var_0)) {
    if(!isDefined(var_1)) {
      var_1 = var_0._id_EA0F;
    }

    if(!isDefined(var_2)) {
      var_2 = var_0._id_EA10;
    }
  }

  self._id_E9FF.streak = var_0;
  make_killstreak_available(var_5, var_1, var_2, var_3);
}

make_killstreak_available(var_0, var_1, var_2, var_3) {
  var_4 = get_current_killstreak_struct();

  if(!isDefined(var_4)) {
    return;
  }
  var_5 = var_4.streakname;
  load_associated_killstreak_weapons(var_5);
  var_6 = var_4._id_EA15;

  if(self.team == "spectator") {
    return;
  }
  var_4._id_1F84 = 1;
  _set_client_killstreak_availability(var_0, var_4._id_1F84);
  update_killstreak_selected_ui();
  update_killstreak_ui_slot(0);

  if(isDefined(var_6._id_1F91)) {
    self[[var_6._id_1F91]](var_4);
  }

  if(var_4._id_887C) {
    self notify("received_earned_killstreak");
  }

  var_4._id_9925 = gettime();
  var_4._id_EA0F = self._id_936C;
  var_4._id_EA10 = self._id_9BC0;
  var_4.owner = self;
  var_4._id_ADB5 = self getxuid();

  if(isDefined(var_1)) {
    var_4._id_EA0F = var_1;
  }

  if(isDefined(var_2)) {
    var_4._id_EA10 = var_2;
  }

  if(isDefined(var_3)) {
    var_4.owner = var_3;
    var_4._id_ADB5 = var_3 getxuid();
  }
}

load_associated_killstreak_weapons(var_0) {
  var_1 = [];
  var_2 = _id_6ADF(var_0);
  var_1[var_1.size] = var_2;
  var_3 = _id_6AE2(var_0);
  var_1 = scripts\engine\utility::array_combine(var_1, var_3);
  self loadweaponsforplayer(var_1, 1);
}

_id_6ADF(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "airdrop_multiple":
    case "airdrop":
      var_1 = "s4_deploy_airdrop_mp";
      break;
    case "juggernaut":
      var_1 = "s4_ks_deploy_flamenaut_mp";
      break;
    case "ball_turret_gunner":
    case "white_phosphorus":
    case "chopper_support":
    case "uav":
    case "radar_drone_overwatch":
    case "directional_uav":
    case "bradley":
      var_1 = "s4_ks_gesture_generic_mp";
      break;
    case "toma_strike":
      var_1 = "s4_ks_targeting_radio_mp";
      break;
    case "precision_airstrike":
      var_1 = "s4_binoculars_mp";
      break;
    case "cruise_predator":
    case "chopper_gunner":
      var_1 = "ks_remote_device_mp";
      break;
    case "pac_sentry":
      var_1 = "s4_ks_remote_goliath_mp";
      break;
    case "scrambler_drone_guard":
    case "hover_jet":
      var_1 = "ks_remote_map_mp";
      break;
    case "manual_turret":
      var_1 = "deploy_manual_turret_mp";
      break;
    case "sentry_gun":
      var_1 = "deploy_sentry_mp";
      break;
    case "nuke":
      var_1 = "ks_remote_nuke_mp";
      break;
  }

  return var_1;
}

_id_6AE2(var_0) {
  var_1 = [];

  switch (var_0) {
    case "juggernaut":
      var_1 = ["s4_gw_flima35_mp"];
      break;
    case "manual_turret":
      var_1 = ["manual_turret_mp"];
      break;
    case "sentry_gun":
      var_1 = ["sentry_turret_mp"];
      break;
  }

  return var_1;
}

_id_C4DC() {
  var_0 = undefined;

  if(isDefined(self._id_E9FF.streak._id_EA15.removedfunc)) {
    var_0 = self[[self._id_E9FF.streak._id_EA15.removedfunc]](self._id_E9FF.streak);
  }

  self._id_E9FF.streak = undefined;
  return var_0;
}