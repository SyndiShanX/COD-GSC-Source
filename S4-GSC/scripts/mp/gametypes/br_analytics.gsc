/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_analytics.gsc
*************************************************/

_id_2AF4() {
  level._id_9BAC = ::_id_AB3A;

  if(getdvarint("#x3b4fabb3a41fb643a", 0)) {
    level._id_46BD = [];
    _func_03FE();
  }
}

_id_0B6D() {
  return isDefined(level._id_46BD);
}

_id_0B6F() {
  var_0 = gettime();

  if(!isDefined(level._id_BBA4)) {
    var_0 = 0;
  } else {
    var_0 = var_0 - level._id_BBA4;
  }

  return var_0;
}

_id_0B6C(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = "";
  }

  var_4 = _id_0B6F();
  _func_03FF(var_1, var_0, var_2, var_4, var_3);
}

_id_0BFD(var_0) {
  if(!isDefined(var_0)) {
    return -1;
  }

  switch (var_0) {
    case "deathType_switchingTeams":
      var_1 = 6;
      break;
    case "deathType_worldDeath":
      var_1 = 3;
      break;
    case "deathType_suicide":
      var_1 = 5;
      break;
    case "deathType_friendlyFire":
      var_1 = 4;
      break;
    case "deathType_inLastStand":
      var_1 = 2;
      break;
    case "deathType_normal":
      var_1 = 1;
      break;
    case "downed":
      var_1 = 0;
      break;
    default:
      var_1 = -1;
      break;
  }

  return var_1;
}

_id_0B6E(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = "";
  }

  if(!isDefined(level._id_46BD[var_0])) {
    level._id_46BD[var_0] = [];
  }

  var_4 = spawnStruct();
  var_4.type = var_0;
  var_4.origin = var_1;
  var_4._id_5469 = var_2;
  var_4._id_4350 = var_3;
  var_4._id_E747 = 0;
  var_4._id_F1E8 = _id_0B6F();
  var_5 = level._id_46BD[var_0].size;
  level._id_46BD[var_0][var_5] = var_4;
}

_id_2B09(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(level._id_46BD) || !isDefined(level._id_46BD[var_0])) {
    return;
  }
  foreach(var_4 in level._id_46BD[var_0]) {
    if(var_4._id_5469 == var_1) {
      var_4._id_F1E8 = _id_0B6F();
      var_4._id_E747 = var_2;
      return;
    }
  }
}

_id_2B0C() {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return 0;
  }

  return 1;
}

_id_2AF1(var_0, var_1) {
  if(!_id_2B0C()) {
    return;
  }
  var_2 = var_1.basename;
  var_3 = _id_0B70(var_0);
  var_3[var_3.size] = "item_name";
  var_3[var_3.size] = var_2;
  var_0 _meth_870F("dlog_event_br_equipment_use", var_3);
}

_id_2AEB(var_0, var_1, var_2, var_3) {
  if(!_id_2B0C()) {
    return;
  }
  if(var_0.classname != "worldspawn" && var_0.classname != "script_vehicle" && var_0.classname != "script_model" && var_0.classname != "misc_turret" && var_0.classname != "trigger_hurt" && !isPlayer(var_0)) {
    var_4 = "attacker.classname: " + var_0.classname;
    scripts\mp\utility\script::_id_47BB(var_4);
  }

  if(var_0.classname == "worldspawn" || var_0.classname == "script_vehicle" || var_0.classname == "script_model" || var_0.classname == "misc_turret" || var_0.classname == "trigger_hurt") {
    var_5 = "world";
    var_0 = var_1;
  } else if(isDefined(var_2))
    var_5 = var_2.basename;
  else {
    var_6 = var_0 getcurrentweapon();
    var_5 = var_6.basename;
  }

  var_7 = var_1 getcurrentweapon();
  var_8 = var_7.basename;
  var_9 = [];
  var_9[var_9.size] = "victim";
  var_9[var_9.size] = var_1;
  var_10 = _id_0B70(var_0, "attacker");

  foreach(var_12 in var_10) {
    var_9[var_9.size] = var_12;
  }

  var_9[var_9.size] = "attacker_weapon";
  var_9[var_9.size] = var_5;
  var_14 = var_0 _meth_876E("ui_br_objective_index");

  if(!isDefined(var_14)) {
    var_15 = "none";
  } else {
    var_15 = _func_0222("mp/brmissions.csv", 0, var_14, 1);
  }

  var_9[var_9.size] = "attacker_active_mission";
  var_9[var_9.size] = var_15;
  var_16 = _id_0B71([], var_1, "victim");

  foreach(var_12 in var_16) {
    var_9[var_9.size] = var_12;
  }

  var_9[var_9.size] = "victim_weapon";
  var_9[var_9.size] = var_8;
  var_14 = var_1 _meth_876E("ui_br_objective_index");

  if(!isDefined(var_14)) {
    var_15 = "NONE";
  } else {
    var_15 = _func_0222("mp/brmissions.csv", 0, var_14, 1);
  }

  var_9[var_9.size] = "victim_active_mission";
  var_9[var_9.size] = var_15;
  var_9[var_9.size] = "death_type";
  var_9[var_9.size] = var_3;
  var_19 = scripts\mp\utility\teams::_id_6A59(var_1.team, 1);
  var_20 = 2147483647;

  foreach(var_22 in var_19) {
    if(var_22 == var_1) {
      continue;
    }
    var_23 = distance(var_1.origin, var_22.origin);

    if(var_23 < var_20 || var_20 == 2147483647) {
      var_20 = var_23;
    }
  }

  var_9[var_9.size] = "closest_victim_teammate_distance";
  var_9[var_9.size] = int(var_20);
  var_0 _meth_870F("dlog_event_br_down", var_9);

  if(_id_0B6D()) {
    _id_0B6C("down", var_1.origin, _id_0BFD(var_3), var_5);
  }
}

_id_2B06(var_0, var_1) {
  if(!_id_2B0C()) {
    return;
  }
  var_2 = [];
  var_2[var_2.size] = "revivee";
  var_2[var_2.size] = var_1;
  var_3 = _id_0B70(var_0, "reviver");

  foreach(var_5 in var_3) {
    var_2[var_2.size] = var_5;
  }

  var_7 = _id_0B71([], var_1, "revivee");

  foreach(var_5 in var_7) {
    var_2[var_2.size] = var_5;
  }

  var_0 _meth_870F("dlog_event_br_revive", var_2);

  if(_id_0B6D()) {
    _id_0B6C("revive", var_1.origin);
  }
}

_id_2B08(var_0) {
  if(!_id_2B0C()) {
    return;
  }
  var_1 = _id_0B70(var_0, "revivee");
  var_0 _meth_870F("dlog_event_br_selfrevive", var_1);

  if(_id_0B6D()) {
    _id_0B6C("selfRevive", var_0.origin);
  }
}

_id_2B07(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!_id_2B0C()) {
    return;
  }
  var_11 = [];
  var_11[var_11.size] = "lastStandAttacker";
  var_11[var_11.size] = var_1;
  var_11[var_11.size] = "victim";
  var_11[var_11.size] = var_2;
  var_12 = _id_0B70(var_0, "revivee");

  foreach(var_14 in var_12) {
    var_11[var_11.size] = var_14;
  }

  var_16 = _id_0B71([], var_1, "laststandattacker");

  foreach(var_14 in var_16) {
    var_11[var_11.size] = var_14;
  }

  var_19 = _id_0B71([], var_2, "victim");

  foreach(var_14 in var_19) {
    var_11[var_11.size] = var_14;
  }

  var_11[var_11.size] = "only_cleanup";
  var_11[var_11.size] = var_7;
  var_11[var_11.size] = "only_downed";
  var_11[var_11.size] = var_8;
  var_11[var_11.size] = "bled_out";
  var_11[var_11.size] = var_9;
  var_11[var_11.size] = "downed_seconds";
  var_11[var_11.size] = var_10;

  if(!isDefined(var_3)) {
    var_3 = "";
  }

  var_11[var_11.size] = "means_of_death";
  var_11[var_11.size] = var_3;

  if(!isDefined(var_4)) {
    var_4 = "";
  }

  var_11[var_11.size] = "weapon_name";
  var_11[var_11.size] = var_4;

  if(!isDefined(var_5)) {
    var_5 = "";
  }

  var_11[var_11.size] = "laststand_means_of_death";
  var_11[var_11.size] = var_5;

  if(!isDefined(var_6)) {
    var_6 = "";
  }

  var_11[var_11.size] = "laststand_weapon_name";
  var_11[var_11.size] = var_6;
  var_0 _meth_870F("dlog_event_br_secondwind", var_11);

  if(_id_0B6D()) {
    _id_0B6C("secondWind", var_0.origin);
  }
}

_id_2AE7() {
  if(!_id_2B0C()) {
    return;
  }
  _func_03BF("dlog_event_br_deploy_allowed", []);
}

_id_2AE9(var_0) {
  if(!_id_2B0C()) {
    return;
  }
  var_1 = _id_0B70(var_0);
  var_0 _meth_870F("dlog_event_br_deploy_triggered", var_1);
}

_id_2AFB(var_0) {
  if(!_id_2B0C()) {
    return;
  }
  var_1 = _id_0B70(var_0);
  var_0 _meth_870F("dlog_event_br_deploy_land", var_1);

  if(_id_0B6D()) {
    _id_0B6C("land", var_0.origin);
  }
}

_id_2B01(var_0) {
  if(!_id_2B0C()) {
    return;
  }
  if(_id_0B6D()) {
    _id_0B6C("playerCount", (0, 0, 0), 0, var_0);
  }
}

_id_2AFD(var_0, var_1, var_2) {
  if(!_id_2B0C()) {
    return;
  }
  var_3 = _id_0B70(var_0);
  var_3[var_3.size] = "item_name";
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = "amount";
  var_3[var_3.size] = var_2;
  var_0 _meth_870F("dlog_event_br_loot_pickup", var_3);
}

_id_2AFC(var_0, var_1, var_2, var_3) {
  if(!_id_2B0C()) {
    return;
  }
  var_2 = istrue(var_2);
  var_4 = _id_0B70(var_0);
  var_4[var_4.size] = "item_name";
  var_4[var_4.size] = var_1;
  var_4[var_4.size] = "is_drop_from_weapon_switch";
  var_4[var_4.size] = var_2;
  var_4[var_4.size] = "amount";
  var_4[var_4.size] = var_3;
  var_0 _meth_870F("dlog_event_br_loot_drop", var_4);
}

_id_2AF3(var_0, var_1) {
  if(!_id_2B0C()) {
    return;
  }
  var_2 = _id_0B70(var_0);
  var_2[var_2.size] = "type";
  var_2[var_2.size] = var_1;
  var_0 _meth_870F("dlog_event_br_gulag_start", var_2);
}

_id_2AF2(var_0, var_1) {
  if(!_id_2B0C()) {
    return;
  }
  var_2 = _id_0B70(var_0);
  var_2[var_2.size] = "type";
  var_2[var_2.size] = var_1;
  var_0 _meth_870F("dlog_event_br_gulag_end", var_2);

  if(_id_0B6D()) {
    var_3 = 0;

    switch (var_1) {
      case "winner":
        var_3 = 1;
        break;
      case "timeout":
        var_3 = 2;
        break;
      case "shutdown":
        var_3 = 3;
        break;
      case "debug":
        var_3 = 4;
        break;
      default:
        var_3 = 0;
        break;
    }

    _id_0B6C("gulag", (0, 0, 0), var_3);
  }
}

_id_2B05(var_0, var_1) {
  if(!_id_2B0C()) {
    return;
  }
  if(_id_0B6D()) {
    _id_0B6C("respawn", (0, 0, 0), var_1);
  }
}

_id_2AEA(var_0, var_1) {
  if(!_id_2B0C()) {
    return;
  }
  if(_id_0B6D()) {
    _id_0B6C("disconnect", (0, 0, 0), var_1);
  }
}

_id_2AEC(var_0, var_1, var_2) {
  if(!_id_2B0C()) {
    return;
  }
  var_3 = _id_0B70(var_0);
  var_3[var_3.size] = "drop_x";
  var_3[var_3.size] = var_1[0];
  var_3[var_3.size] = "drop_y";
  var_3[var_3.size] = var_1[1];
  var_3[var_3.size] = "drop_z";
  var_3[var_3.size] = var_1[2];
  var_0 _meth_870F("dlog_event_br_dropbag_deployed", var_3);

  if(_id_0B6D()) {
    _id_0B6E("dropkit", var_1, var_2, 0);
  }
}

_id_2AEE(var_0, var_1, var_2) {
  if(!_id_2B0C()) {
    return;
  }
  var_3 = _id_0B70(var_0);
  var_3[var_3.size] = "drop_x";
  var_3[var_3.size] = var_1[0];
  var_3[var_3.size] = "drop_y";
  var_3[var_3.size] = var_1[1];
  var_3[var_3.size] = "drop_z";
  var_3[var_3.size] = var_1[2];
  var_0 _meth_870F("dlog_event_br_dropbag_used", var_3);

  if(_id_0B6D()) {
    _id_2B09("dropkit", var_2, 1);
  }
}

_id_2AED(var_0, var_1) {
  if(!_id_2B0C()) {
    return;
  }
  var_2 = [];
  var_2[var_2.size] = "drop_team";
  var_2[var_2.size] = var_0;
  var_2[var_2.size] = "drop_x";
  var_2[var_2.size] = var_1[0];
  var_2[var_2.size] = "drop_y";
  var_2[var_2.size] = var_1[1];
  var_2[var_2.size] = "drop_z";
  var_2[var_2.size] = var_1[2];
  _func_03BF("dlog_event_br_dropbag_destroyed", var_2);
}

_id_2AE4(var_0, var_1) {
  if(!_id_2B0C()) {
    return;
  }
  var_2 = _id_0B70(var_0);
  var_2[var_2.size] = "time_spent_outside";
  var_2[var_2.size] = var_1;
  var_0 _meth_870F("dlog_event_br_circle_enter", var_2);
}

_id_2AE5(var_0, var_1) {
  if(!_id_2B0C()) {
    return;
  }
  var_2 = _id_0B70(var_0);
  var_2[var_2.size] = "time_spent_inside";
  var_2[var_2.size] = var_1;
  var_0 _meth_870F("dlog_event_br_circle_exit", var_2);
}

_id_2B00(var_0, var_1, var_2, var_3) {
  if(!_id_2B0C()) {
    return;
  }
  level waittill("prematch_done");
  _func_03BF("dlog_event_br_plane_path", ["center_x", var_0[0], "center_y", var_0[1], "center_z", var_0[2], "yaw", var_1, "start_x", var_2[0], "start_y", var_2[1], "start_z", var_2[2], "end_x", var_3[0], "end_y", var_3[1], "end_z", var_3[2]]);
}

_id_2AEF(var_0) {
  if(!_id_2B0C()) {
    return;
  }
  var_1 = [];
  var_2 = 0;
  var_3 = 0;
  var_4 = 5000;
  var_5 = 0;
  var_6 = 5000;

  foreach(var_8 in var_0) {
    if(!isDefined(var_1[var_8.team])) {
      var_1[var_8.team] = 0;
    }

    var_2 = var_2 + var_8._id_B956;
    var_1[var_8.team] = var_1[var_8.team] + var_8._id_B956;

    if(var_8._id_B956 > var_3) {
      var_3 = var_8._id_B956;
    }

    if(var_8._id_B956 < var_4) {
      var_4 = var_8._id_B956;
    }

    if(var_1[var_8.team] > var_5) {
      var_5 = var_1[var_8.team];
    }

    if(var_1[var_8.team] < var_6) {
      var_6 = var_1[var_8.team];
    }
  }

  var_10 = int(_id_CACE(var_2, var_0.size));
  var_11 = int(_id_CACE(var_2, var_1.size));
  var_12 = [];
  var_12[var_12.size] = "num_players_alive";
  var_12[var_12.size] = _id_CAC7(var_0.size);
  var_12[var_12.size] = "num_teams_alive";
  var_12[var_12.size] = _id_CAC7(var_1.size);
  var_12[var_12.size] = "total_plunder_held";
  var_12[var_12.size] = _id_CAC7(var_2);
  var_12[var_12.size] = "top_player_plunder_held";
  var_12[var_12.size] = _id_CAC7(var_3);
  var_12[var_12.size] = "top_team_total_plunder_held";
  var_12[var_12.size] = _id_CAC7(var_5);
  var_12[var_12.size] = "avg_player_plunder_held";
  var_12[var_12.size] = _id_CAC7(var_10);
  var_12[var_12.size] = "avg_team_total_plunder_held";
  var_12[var_12.size] = _id_CAC7(var_11);
  var_12[var_12.size] = "min_player_plunder_held";
  var_12[var_12.size] = _id_CAC7(var_4);
  var_12[var_12.size] = "min_team_total_plunder_held";
  var_12[var_12.size] = _id_CAC7(var_6);
  var_12[var_12.size] = "plunder_items_picked_up";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_B937);
  var_12[var_12.size] = "plunder_value_picked_up";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_B953);
  var_12[var_12.size] = "plunder_items_dropped";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_B936);
  var_12[var_12.size] = "plunder_value_dropped";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_B952);
  var_12[var_12.size] = "plunder_awarded_by_missions_total";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_B92E);
  var_12[var_12.size] = "kiosk_spent_total";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_8DFC);
  var_12[var_12.size] = "kiosk_num_purchases";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_8DFB);
  var_12[var_12.size] = "extraction_balloon_total_value";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_581F);
  var_12[var_12.size] = "extraction_balloon_total_extractions";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_581E);
  var_12[var_12.size] = "extraction_helicoptor_total_value";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_582A);
  var_12[var_12.size] = "extraction_helicoptor_total_extractions";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_5829);
  var_12[var_12.size] = "ingame_count_uncommon_1";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_8B3A["brloot_plunder_cash_uncommon_1"]);
  var_12[var_12.size] = "ingame_count_uncommon_2";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_8B3A["brloot_plunder_cash_uncommon_2"]);
  var_12[var_12.size] = "ingame_count_uncommon_3";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_8B3A["brloot_plunder_cash_uncommon_3"]);
  var_12[var_12.size] = "ingame_count_rare_1";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_8B3A["brloot_plunder_cash_rare_1"]);
  var_12[var_12.size] = "ingame_count_rare_2";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_8B3A["brloot_plunder_cash_rare_2"]);
  var_12[var_12.size] = "ingame_count_epic_1";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_8B3A["brloot_plunder_cash_epic_1"]);
  var_12[var_12.size] = "ingame_count_epic_2";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_8B3A["brloot_plunder_cash_epic_2"]);
  var_12[var_12.size] = "ingame_count_legendary_1";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_8B3A["brloot_plunder_cash_legendary_1"]);
  var_12[var_12.size] = "count_unopened_chests";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_8B3A["br_loot_cache"]);
  var_12[var_12.size] = "count_available_missions";
  var_12[var_12.size] = _id_CAC7(level._id_2A9B._id_8B3A["missionTablets"]);
  _func_03BF("dlog_event_br_plunder_economy_snapshot", var_12);
}

_id_2AF7(var_0, var_1) {
  if(!_id_2B0C()) {
    return;
  }
  var_2 = _id_0B70(var_0);
  var_2[var_2.size] = "reason";
  var_2[var_2.size] = var_1;
  var_2[var_2.size] = "primary_weapon";
  var_2[var_2.size] = _id_CAC9(var_0 getcurrentweapon());
  var_2[var_2.size] = "secondary_weapon";
  var_2[var_2.size] = _id_CAC9(var_0 getcurrentoffhand());
  var_2[var_2.size] = "primary_equipment";
  var_2[var_2.size] = _id_CAC8(var_0.equipment["primary"]);
  var_2[var_2.size] = "secondary_equipment";
  var_2[var_2.size] = _id_CAC8(var_0.equipment["secondary"]);
  var_2[var_2.size] = "field_equipment";
  var_2[var_2.size] = _id_CAC8(var_0.equipment["super"]);
  var_2[var_2.size] = "has_gasmask";
  var_2[var_2.size] = isDefined(var_0._id_61D4) && var_0._id_61D4 == 1;
  var_2[var_2.size] = "armor_plates";
  var_2[var_2.size] = _id_CAC7(var_0 scripts\mp\equipment::_id_6A15("health"));
  var_2[var_2.size] = "plunder_total";
  var_2[var_2.size] = _id_CAC7(var_0._id_B956);
  var_2[var_2.size] = "plunder_banked";
  var_2[var_2.size] = _id_CAC7(var_0._id_B955);
  var_2[var_2.size] = "ammo_smg";
  var_2[var_2.size] = _id_CAC7(var_0._id_29F9["brloot_ammo_919"]);
  var_2[var_2.size] = "ammo_ar_lmg";
  var_2[var_2.size] = _id_CAC7(var_0._id_29F9["brloot_ammo_762"]);
  var_2[var_2.size] = "ammo_shotgun";
  var_2[var_2.size] = _id_CAC7(var_0._id_29F9["brloot_ammo_12g"]);
  var_2[var_2.size] = "ammo_sniper";
  var_2[var_2.size] = _id_CAC7(var_0._id_29F9["brloot_ammo_50cal"]);
  var_2[var_2.size] = "ammo_rockets";
  var_2[var_2.size] = _id_CAC7(var_0._id_29F9["brloot_ammo_rocket"]);
  var_3 = [];

  for(var_4 = 0; var_4 < 3; var_4++) {
    var_5 = "specialty_null";

    if(isDefined(var_0._id_3808) && isDefined(var_0._id_3808._id_969F[var_4])) {
      var_5 = var_0._id_3808._id_969F[var_4];
    }

    var_3[var_4] = var_5;
  }

  var_2[var_2.size] = "perk1";
  var_2[var_2.size] = var_3[0];
  var_2[var_2.size] = "perk2";
  var_2[var_2.size] = var_3[1];
  var_2[var_2.size] = "perk3";
  var_2[var_2.size] = var_3[2];
  var_0 _meth_870F("dlog_event_br_inventory_snapshot", var_2);
}

_id_2AFA(var_0, var_1, var_2) {
  if(!_id_2B0C()) {
    return;
  }
  var_3 = _id_0B70(var_0);
  var_3[var_3.size] = "plunder_spent";
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = "player_plunder_after_purchase";
  var_3[var_3.size] = var_0._id_B956;
  var_3[var_3.size] = "primary_weapon";
  var_3[var_3.size] = _id_CAC8(var_2._id_9688);
  var_3[var_3.size] = "secondary_weapon";
  var_3[var_3.size] = _id_CAC8(var_2._id_9697);
  var_3[var_3.size] = "primary_equipment";
  var_3[var_3.size] = _id_CAC8(var_2._id_966A);
  var_3[var_3.size] = "secondary_equipment";
  var_3[var_3.size] = _id_CAC8(var_2._id_966B);
  var_3[var_3.size] = "perk_1";
  var_3[var_3.size] = _id_CAC8(var_2._id_967F[0]);
  var_3[var_3.size] = "perk_2";
  var_3[var_3.size] = _id_CAC8(var_2._id_967F[1]);
  var_3[var_3.size] = "perk_3";
  var_3[var_3.size] = _id_CAC8(var_2._id_967F[2]);
  var_0 _meth_870F("dlog_event_br_kiosk_purchase_loadout", var_3);
}

_id_2AF9(var_0, var_1, var_2, var_3) {
  if(!_id_2B0C()) {
    return;
  }
  var_4 = _id_0B70(var_0);
  var_4[var_4.size] = "plunder_spent";
  var_4[var_4.size] = _id_CAC7(var_1);
  var_4[var_4.size] = "player_plunder_after_purchase";
  var_4[var_4.size] = _id_CAC7(var_0._id_B956);
  var_4[var_4.size] = "purchase_type";
  var_4[var_4.size] = var_2;
  var_4[var_4.size] = "item_name";
  var_4[var_4.size] = var_3;
  var_0 _meth_870F("dlog_event_br_kiosk_purchase_item", var_4);

  if(_id_0B6D()) {
    _id_0B6C("purchase", var_0.origin, var_0 getentitynumber(), var_3);
  }
}

_id_2AF8(var_0, var_1, var_2) {
  if(!_id_2B0C()) {
    return;
  }
  var_3 = _id_0B70(var_0, "kiosk_menu_owner");
  var_3[var_3.size] = "kiosk_menu_owner_event";
  var_3[var_3.size] = var_1;
  var_3[var_3.size] = "kiosk_menu_owner_event_param";

  if(isDefined(var_2)) {
    var_3[var_3.size] = var_2;
  } else {
    var_3[var_3.size] = "none";
  }

  var_3[var_3.size] = "kiosk_menu_owner_event_time";
  var_3[var_3.size] = gettime() - level._id_E72D;
  var_3[var_3.size] = "kiosk_menu_owner_kiosk";

  if(isDefined(var_0._id_2A6B)) {
    var_3[var_3.size] = var_0._id_2A6B.index;
  } else {
    var_3[var_3.size] = -1;
  }

  var_3[var_3.size] = "kiosk_menu_owner_allowed";
  var_3[var_3.size] = istrue(var_0._id_1B85);
  var_3[var_3.size] = "kiosk_menu_owner_error";

  if(var_1 != "menu_close" && !isDefined(var_0._id_2A6B)) {
    var_3[var_3.size] = "unexpected_undefined_kiosk";
  } else {
    var_3[var_3.size] = "none";
  }

  var_0 _meth_870F("dlog_event_br_kiosk_menu_event", var_3);
}

_id_2B04(var_0, var_1, var_2, var_3) {
  if(!_id_2B0C()) {
    return;
  }
  var_4 = [];
  var_4[var_4.size] = "extraction_method";
  var_4[var_4.size] = var_1;
  var_4[var_4.size] = "plunder_placed_into_extraction";
  var_4[var_4.size] = var_3;
  var_4[var_4.size] = "extraction_point_x";
  var_4[var_4.size] = var_2[0];
  var_4[var_4.size] = "extraction_point_y";
  var_4[var_4.size] = var_2[1];
  var_4[var_4.size] = "extraction_point_z";
  var_4[var_4.size] = var_2[2];
  var_0 _meth_870F("dlog_event_br_plunder_placed_into_extraction", var_4);
}

_id_2B03(var_0, var_1, var_2, var_3, var_4) {
  if(!_id_2B0C()) {
    return;
  }
  var_5 = [];
  var_5[var_5.size] = "num_depositers";
  var_5[var_5.size] = var_0;
  var_5[var_5.size] = "plunder_extracted";
  var_5[var_5.size] = var_1;
  var_5[var_5.size] = "method";
  var_5[var_5.size] = var_2;
  var_5[var_5.size] = "contains_enemy_plunder";
  var_5[var_5.size] = var_3;
  var_5[var_5.size] = "extraction_origin_x";
  var_5[var_5.size] = var_4[0];
  var_5[var_5.size] = "extraction_origin_y";
  var_5[var_5.size] = var_4[1];
  var_5[var_5.size] = "extraction_origin_z";
  var_5[var_5.size] = var_4[2];
  _func_03BF("dlog_event_br_plunder_extraction_success", var_5);
}

_id_2B02(var_0, var_1, var_2, var_3) {
  if(!_id_2B0C()) {
    return;
  }
  var_4 = [];
  var_4[var_4.size] = "plunder_dropped";
  var_4[var_4.size] = var_0;
  var_4[var_4.size] = "method";
  var_4[var_4.size] = var_1;
  var_4[var_4.size] = "extraction_origin_x";
  var_4[var_4.size] = var_2[0];
  var_4[var_4.size] = "extraction_origin_y";
  var_4[var_4.size] = var_2[1];
  var_4[var_4.size] = "extraction_origin_z";
  var_4[var_4.size] = var_2[2];
  var_4[var_4.size] = "destruction_origin_x";
  var_4[var_4.size] = var_3[0];
  var_4[var_4.size] = "destruction_origin_y";
  var_4[var_4.size] = var_3[1];
  var_4[var_4.size] = "destruction_origin_z";
  var_4[var_4.size] = var_3[2];
  _func_03BF("dlog_event_br_plunder_extraction_failure", var_4);
}

_id_2AE3(var_0, var_1) {
  if(!_id_2B0C()) {
    return;
  }
  if(isDefined(self)) {
    var_2 = self getxuid() + " " + var_1;
  } else {
    var_2 = "none " + var_1;
  }

  var_0 = int(var_0);

  if(_id_0B6D()) {
    _id_0B6C("bonusXpDebug", (0, 0, 0), var_0, var_2);
  }
}

_id_2B0D(var_0, var_1) {
  if(!_id_2B0C()) {
    return;
  }
  if(_id_0B6D() && isDefined(level._id_BBA4)) {
    _id_0B6E("vehicle", var_0.origin, var_0, var_1);
  }
}

_id_2AF5(var_0, var_1, var_2, var_3) {
  if(!_id_2B0C()) {
    return;
  }
  _func_03BF("dlog_event_br_mission_init", ["num_missions", var_0, "num_missions_active", var_1, "num_missions_hidden", var_2, "hide_percent", var_3]);
}

_id_2AE6(var_0, var_1, var_2, var_3) {
  if(!_id_2B0C()) {
    return;
  }
  _func_03BF("dlog_event_br_mission_repopulate", ["circle_index", var_0, "show_percent", var_1, "num_valid", var_2, "num_shown", var_3]);
}

_id_2B0A(var_0) {
  if(!_id_2B0C()) {
    return;
  }
  _func_03BF("dlog_event_br_mission_spawn", ["id", scripts\engine\utility::ter_op(isDefined(var_0.index), "" + var_0.index, "invalid"), "type", var_0._id_EC8D, "origin_x", var_0.origin[0], "origin_y", var_0.origin[1], "origin_z", var_0.origin[2]]);

  if(_id_0B6D() && isDefined(var_0.index)) {
    _id_0B6E("mission", var_0.origin, "" + var_0.index, var_0._id_EC8D);
  }
}

_id_2AF6(var_0) {
  if(!_id_2B0C()) {
    return;
  }
  _func_03BF("dlog_event_br_mission_invalid", ["id", scripts\engine\utility::ter_op(isDefined(var_0.index), "" + var_0.index, "invalid"), "type", var_0._id_EC8D, "origin_x", var_0.origin[0], "origin_y", var_0.origin[1], "origin_z", var_0.origin[2]]);
}

_id_2AFF(var_0, var_1) {
  if(!_id_2B0C()) {
    return;
  }
  var_2 = [];
  var_3 = scripts\mp\utility\teams::_id_6A59(var_1.team, 1);
  var_2 = _id_0B72(var_2, var_3);
  var_2[var_2.size] = "id";
  var_2[var_2.size] = ::scripts\engine\utility::ter_op(isDefined(var_0._id_9F9A), var_0._id_9F9A, "invalid");

  if(isDefined(level._id_2A1B)) {
    var_4 = scripts\engine\utility::_id_6AC7(level._id_2A1B._id_372F);
  } else {
    var_4 = -1;
  }

  var_2[var_2.size] = "circle_index";
  var_2[var_2.size] = var_4;
  var_2[var_2.size] = "type";
  var_2[var_2.size] = var_0._id_BEAD;
  var_1 _meth_870F("dlog_event_br_mission_start", var_2);

  if(_id_0B6D() && isDefined(var_0._id_9F9A)) {
    _id_2B09("mission", var_0._id_9F9A, -1);
  }
}

_id_2AFE(var_0, var_1, var_2, var_3) {
  if(!_id_2B0C()) {
    return;
  }
  _func_03BF("dlog_event_br_mission_end", ["id", scripts\engine\utility::ter_op(isDefined(var_0._id_9F9A), var_0._id_9F9A, "invalid"), "result", scripts\engine\utility::ter_op(isDefined(var_0._id_0372), var_0._id_0372, "unknown"), "reward_tier", var_1, "xp", scripts\engine\utility::ter_op(isDefined(var_2["xp"]), var_2["xp"], 0), "weapon_xp", scripts\engine\utility::ter_op(isDefined(var_2["weapon_xp"]), var_2["weapon_xp"], 0), "plunder", scripts\engine\utility::ter_op(isDefined(var_2["plunder"]), var_2["plunder"], 0), "num_teammates_awarded", scripts\engine\utility::ter_op(isDefined(var_3), var_3, 0), "type", var_0._id_BEAD]);

  if(_id_0B6D() && isDefined(var_0._id_9F9A)) {
    if(isDefined(var_0._id_0372) && var_0._id_0372 == "success") {
      _id_2B09("mission", var_0._id_9F9A, var_1);
    } else {
      _id_2B09("mission", var_0._id_9F9A, -1);
    }
  }
}

_id_2B0B(var_0, var_1) {
  if(!_id_2B0C()) {
    return;
  }
  _func_03BF("dlog_event_br_team_eliminated", ["team", var_0, "placement", var_1, "survival_time", gettime() - level._id_E72D]);
}

_id_0B70(var_0, var_1) {
  var_2 = [];

  if(!_func_0121(var_1)) {
    var_1 = "player";
  }

  var_2 = _id_0B71(var_2, var_0, var_1);

  if(isDefined(level._id_2A1B)) {
    var_3 = scripts\engine\utility::_id_6AC7(level._id_2A1B._id_372F);
  } else {
    var_3 = -1;
  }

  var_2[var_2.size] = "circle_index";
  var_2[var_2.size] = var_3;
  return var_2;
}

_id_0B71(var_0, var_1, var_2) {
  if(!_func_0121(var_2)) {
    var_2 = "player";
  }

  var_0[var_0.size] = var_2 + "_x";
  var_0[var_0.size] = var_1.origin[0];
  var_0[var_0.size] = var_2 + "_y";
  var_0[var_0.size] = var_1.origin[1];
  var_0[var_0.size] = var_2 + "_z";
  var_0[var_0.size] = var_1.origin[2];
  var_0[var_0.size] = var_2 + "_pitch";
  var_0[var_0.size] = ::scripts\engine\utility::_id_6C59(var_1);
  var_0[var_0.size] = var_2 + "_yaw";
  var_0[var_0.size] = ::scripts\engine\utility::_id_6C72(var_1);
  return var_0;
}

_id_0B72(var_0, var_1) {
  var_0[var_0.size] = "living_player_pos";
  var_2 = [];

  foreach(var_4 in var_1) {
    var_2[var_2.size] = "x";
    var_2[var_2.size] = var_4.origin[0];
    var_2[var_2.size] = "y";
    var_2[var_2.size] = var_4.origin[1];
    var_2[var_2.size] = "z";
    var_2[var_2.size] = var_4.origin[2];
    var_2[var_2.size] = "pitch";
    var_2[var_2.size] = ::scripts\engine\utility::_id_6C59(var_4);
    var_2[var_2.size] = "yaw";
    var_2[var_2.size] = ::scripts\engine\utility::_id_6C72(var_4);
  }

  var_0[var_0.size] = var_2;
  return var_0;
}

_id_CAC8(var_0) {
  if(isDefined(var_0)) {
    return var_0;
  } else {
    return "empty";
  }
}

_id_CAC9(var_0) {
  if(isDefined(var_0)) {
    return var_0.basename;
  } else {
    return "empty";
  }
}

_id_CAC7(var_0) {
  if(isDefined(var_0)) {
    return var_0;
  } else {
    return 0;
  }
}

_id_CACE(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0) {
    return var_0 / 1;
  } else {
    return var_0 / var_1;
  }
}

_id_2AF0() {
  if(_id_0B6D()) {
    if(isDefined(level._id_46BD["vehicle"])) {
      foreach(var_1 in level._id_46BD["vehicle"]) {
        if(!isDefined(var_1._id_5469)) {
          var_1._id_E747 = 1;
          continue;
        }

        if(distancesquared(var_1.origin, var_1._id_5469.origin) > _func_0219(1000)) {
          var_1._id_E747 = 1;
        }
      }
    }

    if(isDefined(level._id_2A10)) {
      foreach(var_4 in level._id_2A10._id_CF26) {
        if(istrue(var_4._id_10417)) {
          _func_03FF(var_4.origin, "kiosk", 1, 0, "");
          continue;
        }

        _func_03FF(var_4.origin, "kiosk", 0, 0, "");
      }
    }

    if(isDefined(level._id_2A73) && isDefined(level._id_2A73._id_2A1F)) {
      var_6 = level._id_2A73._id_2A1F.size - 1;
      var_7 = 0;

      for(var_8 = 0; var_8 < var_6; var_8++) {
        var_9 = level._id_2A73._id_2A1F[var_8 + 1];
        var_10 = level._id_2A73._id_2A25[var_8 + 1];
        var_11 = level._id_2A73._id_2A21[var_8];
        var_12 = level._id_2A73._id_2A20[var_8];
        var_7 = var_7 + var_11 + var_12;
        _func_03FF(var_9, "circle", int(var_10), int(var_7), "");
      }
    }

    foreach(var_14 in level._id_46BD) {
      foreach(var_16 in var_14) {
        _func_03FF(var_16.origin, var_16.type, var_16._id_E747, var_16._id_F1E8, var_16._id_4350);
      }
    }

    _func_0400();
  }
}

_id_815D() {
  level._id_3308 = [];
  level._id_3308[level._id_3308.size] = "loot";
  level._id_3308[level._id_3308.size] = "mission";
  level._id_3308[level._id_3308.size] = "combat";
  level._id_3308[level._id_3308.size] = "cache";
  level._id_3308[level._id_3308.size] = "cache_legendary";
  level._id_3308[level._id_3308.size] = "cache_scavenger";
  level._id_3308[level._id_3308.size] = "loot_chopper";
  level._id_3308[level._id_3308.size] = "c130_box";
  level._id_3306 = [];

  foreach(var_1 in level._id_EF89) {
    var_2 = spawnStruct();
    var_2._id_E070 = [];
    var_2._id_F376 = [];

    foreach(var_4 in level._id_3308) {
      var_2._id_E070[var_4] = 0;
      var_2._id_F376[var_4] = 0;
    }

    level._id_3306[var_1] = var_2;
  }

  level waittill("prematch_done");
  level thread _id_C149();
}

_id_C149() {
  for(var_0 = 60.0; !istrue(level.gameended); var_0 = max(60.0 - var_12, 0)) {
    level scripts\engine\utility::_id_108F5("game_ended", var_0);
    var_1 = gettime();
    var_2 = scripts\mp\gamescore::_id_6DD9();

    foreach(var_4 in level._id_EF89) {
      if(!isDefined(var_4)) {
        continue;
      }
      var_5 = _id_07EE::_id_6DE4(gettime());
      var_6 = [];
      var_6[var_6.size] = "match_complete";
      var_6[var_6.size] = 0;
      var_6[var_6.size] = "time";
      var_6[var_6.size] = var_5;
      var_6[var_6.size] = "team";
      var_6[var_6.size] = var_4;
      var_6[var_6.size] = "placement";
      var_6[var_6.size] = var_2[var_4];

      foreach(var_8 in level._id_3308) {
        var_9 = level._id_3306[var_4]._id_E070[var_8];
        var_6[var_6.size] = "cash_source_" + var_8;
        var_6[var_6.size] = var_9;
        level._id_3306[var_4]._id_F376[var_8] = level._id_3306[var_4]._id_F376[var_8] + var_9;
        level._id_3306[var_4]._id_E070[var_8] = 0;
      }

      _func_03BF("dlog_event_blood_money_interval", var_6);
      waitframe();
    }

    var_12 = (gettime() - var_1) * 0.001;
  }

  var_5 = _id_07EE::_id_6DE4(gettime());
  var_2 = scripts\mp\gamescore::_id_6DD9();

  foreach(var_4 in level._id_EF89) {
    var_6 = [];
    var_6[var_6.size] = "match_complete";
    var_6[var_6.size] = 1;
    var_6[var_6.size] = "time";
    var_6[var_6.size] = var_5;
    var_6[var_6.size] = "team";
    var_6[var_6.size] = var_4;
    var_6[var_6.size] = "placement";
    var_6[var_6.size] = var_2[var_4];

    foreach(var_8 in level._id_3308) {
      var_9 = level._id_3306[var_4]._id_F376[var_8];
      var_6[var_6.size] = "cash_source_" + var_8;
      var_6[var_6.size] = var_9;
    }

    _func_03BF("dlog_event_blood_money_interval", var_6);
  }
}

_id_F3F7(var_0, var_1, var_2) {
  if(!isDefined(level._id_3306) || !isDefined(var_0) || !isDefined(var_0.team)) {
    return;
  }
  var_3 = var_0.team;
  level._id_3306[var_3]._id_E070[var_1] = level._id_3306[var_3]._id_E070[var_1] + var_2;
}

_id_AB3A() {
  thread _id_0C83();
}

_id_0C83() {
  waittillframeend;
  var_0 = level._id_2BB5.name;
  var_1 = scripts\engine\utility::_id_6AC7(level.maxteamsize);
  var_2 = scripts\engine\utility::_id_6AC7(level.players.size);
  var_3 = scripts\engine\utility::_id_6AC7(level._id_EFB3.size);
  var_4 = 0;

  foreach(var_6 in level.players) {
    if(isbot(var_6) || var_6 _meth_878F()) {
      continue;
    }
    var_4++;
  }

  if(isDefined(level._id_2A10)) {
    var_8 = scripts\engine\utility::_id_6AC7(level._id_2A10._id_EF9D);
  } else {
    var_8 = 0;
  }

  var_9 = scripts\engine\utility::_id_6AC7(level._id_FE76);

  if(isDefined(level._id_7262)) {
    var_10 = scripts\engine\utility::_id_6AC7(level._id_7262._id_9CB7);
    var_11 = scripts\engine\utility::_id_6AC7(level._id_7262._id_A76D);
    var_12 = scripts\engine\utility::_id_6AC7(level._id_7262._id_E31D);
  } else {
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;
  }

  var_13 = [];

  foreach(var_17, var_15 in level._id_BEAF._id_EC87) {
    var_13[var_13.size] = "name";
    var_13[var_13.size] = var_17;
    var_16 = isDefined(var_15) && istrue(var_15._id_523F);
    var_13[var_13.size] = "is_enabled";
    var_13[var_13.size] = var_16;
  }

  _func_03BF("dlog_event_br_server_match_start", ["br_mission_type_info", var_13, "map", level.script, "sub_game_type", var_0, "max_team_size", var_1, "player_count", var_2, "human_player_count", var_4, "team_count", var_3, "kiosk_respawn_cost", var_8, "gulag_active", var_9, "gulag_max_uses", var_10, "gulag_starting_armor", var_11, "gulag_spawn_loot", var_12]);
}