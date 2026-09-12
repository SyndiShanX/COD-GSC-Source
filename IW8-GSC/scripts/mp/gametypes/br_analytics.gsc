/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_analytics.gsc
*************************************************/

function destroycrateinbadtrigger() {
  level.ref_11b22 = &ref_1205b;
  level.br_branalytics_revivefunc = &branalytics_revive;

  if(getdvarint("NNNQSOPLKR", 0)) {
    level.kothtotaltime = [];
    analyticsaddevent();
    return;
  }
}

function add_outline() {
  return isDefined(level.kothtotaltime);
}

function add_pack_characteranim() {
  var_0 = gettime();

  if(!isDefined(level.ref_12855)) {
    var_0 = 0;
  } else {
    var_0 -= level.ref_12855;
  }

  return var_0;
}

function add_object_to_trap_room_ents(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = "";
  }

  var_4 = add_pack_characteranim();
  analyticswritecsv(var_1, var_0, var_2, var_4, var_3);
}

function ai_roof_think(var_0) {
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

function add_pack_camanim(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = "";
  }

  if(!isDefined(level.kothtotaltime[var_0])) {
    level.kothtotaltime[var_0] = [];
  }

  var_4 = spawnStruct();
  var_4.type = var_0;
  var_4.origin = var_1;
  var_4.ent = var_2;
  var_4.data = var_3;
  var_4.state = 0;
  var_4.time = add_pack_characteranim();
  var_5 = level.kothtotaltime[var_0].size;
  level.kothtotaltime[var_0][var_5] = var_4;
}

function dialog_grenade_update(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_1) || !isDefined(level.kothtotaltime) || !isDefined(level.kothtotaltime[var_0])) {
    return;
  }

  foreach(var_4 in level.kothtotaltime[var_0]) {
    if(var_4.ent == var_1) {
      var_4.time = add_pack_characteranim();
      var_4.state = var_2;
      return;
    }
  }
}

function dialog_monitor_shieldraise() {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return false;
  }

  return true;
}

function branalytics_equipmentuse(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = var_1.basename;
  var_3 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_3.size, "item_name");
}

function dialog_monitor_hurry(var_0) {
  if(!isDefined(var_0)) {
    return true;
  }

  switch (var_0) {
    case "trigger_hurt":
    case "worldspawn":
    case "misc_turret":
    case "script_model":
    case "script_vehicle":
    case "trigger_multiple":
    case "trigger_radius":
      return true;
    default:
      break;
  }

  return false;
}

function branalytics_down(var_0, var_1, var_2, var_3, var_4) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(isDefined(var_0.classname) && var_0.classname == "agent") {
    return;
  }

  var_5 = dialog_monitor_hurry(var_0.classname);

  if(!var_5 && !isPlayer(var_0)) {
    var_6 = "attacker.classname: " + var_0.classname;
    scripts\mp\utility\script::laststand_dogtags(var_6);
  }

  if(var_5) {
    var_7 = "world";
    var_0 = var_1;
  } else {
    jumpiffalse(isDefined(var_3)) LOC_00000084;
    var_7 = var_3.basename;
    goto LOC_00000097;
  }

  LOC_00000097:
    var_9 = var_3 getcurrentweapon();
  var_10 = var_9.basename;
  var_11 = [];
  GscBinSkip0(0x2e, var_11.size, "victim");
}

function branalytics_revive(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = [];
  GscBinSkip0(0x2e, var_2.size, "revivee");
}

function dialog_grenade_missed(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_1 = _branalytics_header(var_0, "revivee");
  var_0 dlog_recordplayerevent("dlog_event_br_selfrevive", var_1);

  if(add_outline()) {
    add_object_to_trap_room_ents("selfRevive", var_0.origin);
    return;
  }
}

function diablecachesaroundorigin(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_11 = [];
  GscBinSkip0(0x2e, var_11.size, "lastStandAttacker");
}

function dialog_monitor_waitreload(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_3 = [];
  GscBinSkip0(0x2e, var_3.size, "door_id");
}

function branalytics_deployallowed() {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_deploy_allowed", []);
}

function branalytics_deploytriggered(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_1 = _branalytics_header(var_0);
  var_0 dlog_recordplayerevent("dlog_event_br_deploy_triggered", var_1);
}

function detachriotshield(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_1 = _branalytics_header(var_0);
  var_0 dlog_recordplayerevent("dlog_event_br_deploy_land", var_1);

  if(add_outline()) {
    add_object_to_trap_room_ents("land", var_0.origin);
    return;
  }
}

function detonatedripfx(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(add_outline()) {
    add_object_to_trap_room_ents("playerCount", (0, 0, 0), 0, var_0);
    return;
  }
}

function determine_starting_breadcrumb(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_3 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_3.size, "damage_taken");
}

function branalytics_lootpickup(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_3 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_3.size, "item_name");
}

function branalytics_lootdrop(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = istrue(var_2);
  var_4 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_4.size, "item_name");
}

function destroyawardlaunchonly(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_2.size, "type");
}

function destroyaward(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_2.size, "type");
}

function devspectatetesthost(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(add_outline()) {
    add_object_to_trap_room_ents("respawn", (0, 0, 0), var_1);
    return;
  }
}

function detonatesound(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(add_outline()) {
    add_object_to_trap_room_ents("PlunderRespawn", var_0, var_1, var_2);
    return;
  }
}

function destpoint(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(add_outline()) {
    add_object_to_trap_room_ents("disconnect", (0, 0, 0), var_1);
    return;
  }
}

function dialog_intro(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_3 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_3.size, "start_station");
}

function destroy_vehicles(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_2.size, "tree_level");
}

function destroy_vehicle_on_pilot_death(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_1 = _branalytics_header(var_0);
  var_0 dlog_recordplayerevent("dlog_event_br_ff_riddle_completed", var_1);
}

function destroy_vehicle_if_driver_dies(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_2.size, "elf_level");
}

function destprogress(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_4 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_4.size, "drop_x");
}

function destroy_intro_tank(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_3 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_3.size, "drop_x");
}

function destroy_bad_traversals(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = [];
  GscBinSkip0(0x2e, var_2.size, "drop_team");
}

function descendpos(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_2.size, "time_spent_outside");
}

function descendsolostarts(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_2.size, "time_spent_inside");
}

function destinations(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_3 = [];
  GscBinSkip0(0x2e, var_3.size, "axis_contracts_completed");
}

function desired_landing_spot(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_3 = [];
  GscBinSkip0(0x2e, var_3.size, "axis_score");
}

function determinewinnertype(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  level waittill("prematch_done");
  getentitylessscriptablearray("dlog_event_br_plane_path", ["center_x", var_0[0], "center_y", var_0[1], "center_z", var_0[2], "yaw", var_1, "start_x", var_2[0], "start_y", var_2[1], "start_z", var_2[2], "end_x", var_3[0], "end_y", var_3[1], "end_z", var_3[2]]);
}

function destroy_jammer_relocate(var_0) {
  if(!dialog_monitor_shieldraise()) {
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
      var_1 = 0;
    }

    if(isDefined(var_8.plundercount)) {
      var_2 += var_8.plundercount;
      var_1 = var_1[var_8.team] + var_8.plundercount;

      if(var_8.plundercount > var_3) {
        var_3 = var_8.plundercount;
      }

      if(var_8.plundercount < var_4) {
        var_4 = var_8.plundercount;
      }
    }

    if(var_1[var_8.team] > var_5) {
      var_5 = var_1[var_8.team];
    }

    if(var_1[var_8.team] < var_6) {
      var_6 = var_1[var_8.team];
    }
  }

  var_10 = int(ref_12e53(var_2, var_0.size));
  var_11 = int(ref_12e53(var_2, var_1.size));
  var_12 = [];
  GscBinSkip0(0x2e, var_12.size, "num_players_alive");
}

function defusebomb(var_0) {
  var_1 = var_0 getcurrentweapon();
  var_2 = undefined;

  if(isDefined(var_0.primaryweaponobj) && var_1 != var_0.primaryweaponobj) {
    var_2 = var_0.primaryweaponobj;
  } else if(isDefined(var_0.secondaryweaponobj) && var_1 != var_0.secondaryweaponobj) {
    var_2 = var_0.secondaryweaponobj;
  }

  return [var_1, var_2];
}

function destroyscorelaunchonly(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = defusebomb(var_0);
  var_3 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_3.size, "reason");
}

function destructiblevehiclesetup(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_3 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_3.size, "plunder_spent");
}

function destructiblecarlightssetup(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_4 = _branalytics_header(var_0);
  GscBinSkip0(0x2e, var_4.size, "plunder_spent");
}

function destructable_car(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_3 = _branalytics_header(var_0, "kiosk_menu_owner");
  GscBinSkip0(0x2e, var_3.size, "kiosk_menu_owner_event");
}

function detonatefxair(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_4 = [];
  GscBinSkip0(0x2e, var_4.size, "extraction_method");
}

function detonatefx(var_0, var_1, var_2, var_3, var_4) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_5 = [];
  GscBinSkip0(0x2e, var_5.size, "num_depositers");
}

function detonatefunc(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_4 = [];
  GscBinSkip0(0x2e, var_4.size, "plunder_dropped");
}

function deregisterscriptableinstance(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(isDefined(self)) {
    var_2 = self getentitynumber() + "; " + var_1;
  } else {
    var_2 = "none; " + var_2;
  }

  var_1 = int(var_1);

  if(add_outline()) {
    add_object_to_trap_room_ents("bonusXpDebug", (0, 0, 0), var_1, var_2);
    return;
  }
}

function branalytics_modespecificscore(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = "unknown";
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_1 = int(var_1);
  var_0 dlog_recordplayerevent("dlog_event_player_modescore_earned", ["player_life_index", var_0.matchdatalifeindex, "player_score_earned", var_1, "score_event", var_2]);

  if(add_outline()) {
    if(isDefined(var_0)) {
      var_3 = self getentitynumber() + "; " + var_2;
    } else {
      var_3 = "none; " + var_3;
    }

    add_object_to_trap_room_ents("modeScore", var_1.origin, var_2, var_3);
    return;
  }
}

function dialog_low_health(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_1 = [];
  GscBinSkip0(0x2e, var_1.size, "amount");
}

function dialog_kill_watcher_civ(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_1 = [];
  GscBinSkip0(0x2e, var_1.size, "weapon_used");
}

function detonatingplayer(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_4 = [];
  GscBinSkip0(0x2e, var_4.size, "amount");
}

function detonation_time(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = [];
  GscBinSkip0(0x2e, var_2.size, "level_achieved");
}

function detonation_color_omnvar_value(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = [];
  GscBinSkip0(0x2e, var_2.size, "amount");
}

function detonation_code_omnvar_value(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = [];
  GscBinSkip0(0x2e, var_2.size, "amount");
}

function devspectateenemyteam1(var_0, var_1, var_2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_3 = [];
  GscBinSkip0(0x2e, var_3.size, "amount");
}

function devscriptedtests(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_1 = [];
  GscBinSkip0(0x2e, var_1.size, "reward_level_reached");
}

function devspectateenemyteam2() {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "amount");
}

function dialog_monitor_shieldstow(var_0, var_1) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }

  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(add_outline() && isDefined(level.ref_12855)) {
    add_pack_camanim("vehicle", var_0.origin, var_0, var_1);
    return;
  }
}

function branalytics_skyhookredeploy(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_1 = _branalytics_header(var_0);
  var_0 dlog_recordplayerevent("dlog_event_skyhook_redeploy", var_1);
}

function destroypropspecatehud(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_mission_init", ["num_missions", var_0, "num_missions_active", var_1, "num_missions_hidden", var_2, "hide_percent", var_3]);
}

function destorder(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_mission_repopulate", ["circle_index", var_0, "show_percent", var_1, "num_valid", var_2, "num_shown", var_3]);
}

function dialog_hurry(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_mission_spawn", ["id", scripts\engine\utility::ter_op(isDefined(var_0.index), "" + var_0.index, "invalid"), "type", var_0.ref_139eb, "origin_x", var_0.origin[0], "origin_y", var_0.origin[1], "origin_z", var_0.origin[2]]);

  if(add_outline() && isDefined(var_0.index)) {
    add_pack_camanim("mission", var_0.origin, "" + var_0.index, var_0.ref_139eb);
    return;
  }
}

function destroyscoreevent(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_mission_invalid", ["id", scripts\engine\utility::ter_op(isDefined(var_0.index), "" + var_0.index, "invalid"), "type", var_0.ref_139eb, "origin_x", var_0.origin[0], "origin_y", var_0.origin[1], "origin_z", var_0.origin[2]]);
}

function reset_ability_invulnerable(var_0) {
  var_1 = 0;

  if(var_0.questcategory == "blueprintextract") {
    if(isDefined(var_0.overwatch_soldiers_05_bombers)) {
      var_1 = var_0.overwatch_soldiers_05_bombers;
    }
  }

  return var_1;
}

function determinetrackingcirclesize(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var_2 = [];
  var_3 = scripts\mp\utility\teams::getfriendlyplayers(var_1.team, 1);
  var_2 = add_pack_modelanim(var_2, var_3);
  var_2 = "id";
  var_2 = scripts\engine\utility::ter_op(isDefined(var_0.ref_11c4e), var_0.ref_11c4e, "invalid");

  if(isDefined(level.br_circle)) {
    var_4 = scripts\engine\utility::remove_player_rig_laser_panel(level.br_circle.circleindex);
  } else {
    var_4 = -1;
  }

  var_3 = "circle_index";
  var_3 = var_4;
  var_3 = "type";
  var_3 = var_1.questcategory;
  var_3 = "blueprint_loot_id";
  var_3 = reset_ability_invulnerable(var_1);
  var_2 dlog_recordplayerevent("dlog_event_br_mission_start", var_3);

  if(add_outline() && isDefined(var_1.ref_11c4e)) {
    dialog_grenade_update("mission", var_1.ref_11c4e, -1);
    return;
  }
}

function determinetrackingcircleoffset(var_0, var_1, var_2, var_3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_mission_end", ["id", scripts\engine\utility::ter_op(isDefined(var_0.ref_11c4e), var_0.ref_11c4e, "invalid"), "result", scripts\engine\utility::ter_op(isDefined(var_0.result), var_0.result, "unknown"), "reward_tier", var_1, "xp", scripts\engine\utility::ter_op(isDefined(var_2["xp"]), var_2["xp"], 0), "weapon_xp", scripts\engine\utility::ter_op(isDefined(var_2["weapon_xp"]), var_2["weapon_xp"], 0), "plunder", scripts\engine\utility::ter_op(isDefined(var_2["plunder"]), var_2["plunder"], 0), "num_teammates_awarded", scripts\engine\utility::ter_op(isDefined(var_3), var_3, 0), "type", var_0.questcategory, "blueprint_loot_id", reset_ability_invulnerable(var_0)]);

  if(add_outline() && isDefined(var_0.ref_11c4e)) {
    if(isDefined(var_0.result) && var_0.result == "success") {
      dialog_grenade_update("mission", var_0.ref_11c4e, var_1);
      return;
    }

    dialog_grenade_update("mission", var_0.ref_11c4e, -1);
    return;
  }
}

function dialog_monitor_getoffground(var_0, var_1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_team_eliminated", ["team", var_0, "placement", var_1, "survival_time", gettime() - level.starttime]);
}

function devspectatetest(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_public_event_start", ["type", var_0]);
}

function devspectateloc(var_0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_public_event_end", ["type", var_0]);
}

function _branalytics_header(var_0, var_1) {
  var_2 = [];

  if(!isstring(var_1)) {
    var_1 = "player";
  }

  var_2 = add_pack_fx(var_2, var_0, var_1);

  if(isDefined(level.br_circle)) {
    var_3 = scripts\engine\utility::remove_player_rig_laser_panel(level.br_circle.circleindex);
  } else {
    var_3 = -1;
  }

  var_3 = "circle_index";
  var_3 = var_3;
  return var_3;
}

function add_pack_fx(var_0, var_1, var_2) {
  if(!isstring(var_2)) {
    var_2 = "player";
  }

  var_0 = var_2 + "_x";
  var_0 = var_1.origin[0];
  var_0 = var_2 + "_y";
  var_0 = var_1.origin[1];
  var_0 = var_2 + "_z";
  var_0 = var_1.origin[2];
  var_0 = var_2 + "_pitch";
  var_0 = scripts\engine\utility::getplayerpitch(var_1);
  var_0 = var_2 + "_yaw";
  var_0 = scripts\engine\utility::getplayeryaw(var_1);
  return var_0;
}

function add_pack_modelanim(var_0, var_1) {
  var_0 = "living_player_pos";
  var_2 = [];

  foreach(var_4 in var_1) {
    var_2 = "x";
    var_2 = var_4.origin[0];
    var_2 = "y";
    var_2 = var_4.origin[1];
    var_2 = "z";
    var_2 = var_4.origin[2];
    var_2 = "pitch";
    var_2 = scripts\engine\utility::getplayerpitch(var_4);
    var_2 = "yaw";
    var_2 = scripts\engine\utility::getplayeryaw(var_4);
  }

  var_0 = var_2;
  return var_0;
}

function ref_12e4f(var_0) {
  if(isDefined(var_0)) {
    return var_0;
  }

  return "empty";
}

function ref_12e50(var_0) {
  if(isDefined(var_0)) {
    return var_0;
  }

  return "";
}

function ref_12e51(var_0) {
  if(isDefined(var_0)) {
    return var_0.basename;
  }

  return "empty";
}

function ref_12e4e(var_0) {
  if(isDefined(var_0)) {
    return var_0;
  }

  return 0;
}

function ref_12e53(var_0, var_1) {
  if(!isDefined(var_1) || var_1 <= 0) {
    return (var_0 / 1);
  }

  return var_0 / var_1;
}

function destroy_lmgs() {
  if(add_outline()) {
    if(isDefined(level.kothtotaltime["vehicle"])) {
      foreach(var_1 in level.kothtotaltime["vehicle"]) {
        if(!isDefined(var_1.ent)) {
          var_1.state = 1;
          continue;
        }

        if(distancesquared(var_1.origin, var_1.ent.origin) > squared(1000)) {
          var_1.state = 1;
        }
      }
    }

    if(isDefined(level.br_armory_kiosk)) {
      foreach(var_4 in level.br_armory_kiosk.scriptables) {
        if(istrue(var_4.visible)) {
          analyticswritecsv(var_4.origin, "kiosk", 1, 0, "");
          continue;
        }

        analyticswritecsv(var_4.origin, "kiosk", 0, 0, "");
      }
    }

    if(isDefined(level.br_level) && isDefined(level.br_level.default_class_chosen)) {
      var_6 = level.br_level.default_class_chosen.size - 1;
      var_7 = 0;

      for(var_8 = 0; var_8 < var_6; var_8++) {
        var_9 = level.br_level.default_class_chosen[var_8 + 1];
        var_10 = level.br_level.br_circleradii[var_8 + 1];
        var_11 = level.br_level.br_circledelaytimes[var_8];
        var_12 = level.br_level.br_circleclosetimes[var_8];
        var_7 = var_7 + var_11 + var_12;
        analyticswritecsv(var_9, "circle", int(var_10), int(var_7), "");
      }
    }

    foreach(var_14 in level.kothtotaltime) {
      foreach(var_16 in var_14) {
        analyticswritecsv(var_16.origin, var_16.type, var_16.state, var_16.time, var_16.data);
      }
    }
  }

  objective_setspecialobjectivedisplay();
}

function teamvehicles() {
  level.get_vehicle_driver_hint_string_func = [];
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "loot";
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "mission";
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "combat";
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "cache";
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "cache_legendary";
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "cache_scavenger";
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "loot_chopper";
  level.get_vehicle_driver_hint_string_func[level.get_vehicle_driver_hint_string_func.size] = "c130_box";
  level.get_veh_spawn_test_spawners = [];

  foreach(var_1 in level.teamnamelist) {
    var_2 = spawnStruct();
    var_2.sources = [];
    var_2.ref_13bf0 = [];

    foreach(var_4 in level.get_vehicle_driver_hint_string_func) {
      var_2.sources[var_4] = 0;
      var_2.ref_13bf0[var_4] = 0;
    }

    level.get_veh_spawn_test_spawners[var_1] = var_2;
  }

  level waittill("prematch_done");
  thread ref_12aa6();
}

function ref_12aa6() {
  for(var_0 = 60; !istrue(level.gameended); var_0 = max(60 - var_12, 0)) {
    level scripts\engine\utility::waittill_notify_or_timeout("game_ended", var_0);
    var_1 = gettime();
    var_2 = scripts\mp\gamescore::run_common_functions_stealth();

    foreach(var_4 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_4)) {
        continue;
      }

      if(!isDefined(var_4)) {
        continue;
      }

      var_5 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
      var_6 = [];
      var_6 = "match_complete";
      var_6 = 0;
      var_6 = "time";
      var_6 = var_5;
      var_6 = "team";
      var_6 = var_4;
      var_6 = "placement";
      var_6 = var_2[var_4];

      foreach(var_8 in level.get_vehicle_driver_hint_string_func) {
        var_9 = level.get_veh_spawn_test_spawners[var_4].sources[var_8];
        var_6 = "cash_source_" + var_8;
        var_6 = var_9;
        level.get_veh_spawn_test_spawners[var_4].ref_13bf0[var_8] += var_9;
        level.get_veh_spawn_test_spawners[var_4].sources[var_8] = 0;
      }

      getentitylessscriptablearray("dlog_event_blood_money_interval", var_6);
      waitframe();
    }

    var_12 = (gettime() - var_1) * 0.001;
  }

  var_5 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var_2 = scripts\mp\gamescore::run_common_functions_stealth();

  foreach(var_4 in level.teamnamelist) {
    if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var_4)) {
      continue;
    }

    var_6 = [];
    var_6 = "match_complete";
    var_6 = 1;
    var_6 = "time";
    var_6 = var_5;
    var_6 = "team";
    var_6 = var_4;
    var_6 = "placement";
    var_6 = var_2[var_4];

    foreach(var_8 in level.get_vehicle_driver_hint_string_func) {
      var_9 = level.get_veh_spawn_test_spawners[var_4].ref_13bf0[var_8];
      var_6 = "cash_source_" + var_8;
      var_6 = var_9;
    }

    getentitylessscriptablearray("dlog_event_blood_money_interval", var_6);
  }
}

function ref_13c44(var_0, var_1, var_2) {
  if(!isDefined(var_0) || !isDefined(var_0.team)) {
    return;
  }

  if(add_outline()) {
    add_object_to_trap_room_ents("plunder_award", var_0.origin, var_2, var_0.team + "; " + var_0 getentitynumber() + "; " + var_1);
  }

  if(!isDefined(level.get_veh_spawn_test_spawners)) {
    return;
  }

  var_3 = var_0.team;
  level.get_veh_spawn_test_spawners[var_3].sources[var_1] += var_2;
}

function ref_1205b() {
  thread allowed_objectives();
}

function allowed_objectives() {
  waittillframeend();
  var_0 = level.disable_super_in_turret.name;
  var_1 = scripts\engine\utility::remove_player_rig_laser_panel(level.maxteamsize);
  var_2 = scripts\engine\utility::remove_player_rig_laser_panel(level.players.size);
  var_3 = scripts\engine\utility::remove_player_rig_laser_panel(level.teamswithplayers.size);
  var_4 = 0;

  foreach(var_6 in level.players) {
    if(isbot(var_6) || var_6 calloutmarkerping_getEnt()) {
      continue;
    }

    var_4++;
  }

  if(isDefined(level.br_armory_kiosk)) {
    var_8 = scripts\engine\utility::remove_player_rig_laser_panel(level.br_armory_kiosk.ref_13ac2);
  } else {
    var_8 = 0;
  }

  var_9 = scripts\engine\utility::remove_player_rig_laser_panel(level.usegulag);

  if(isDefined(level.gulag)) {
    var_10 = scripts\engine\utility::remove_player_rig_laser_panel(level.gulag.maxuses);
    var_11 = scripts\engine\utility::remove_player_rig_laser_panel(level.gulag.ref_11f2d);
    var_12 = scripts\engine\utility::remove_player_rig_laser_panel(level.gulag.ref_13672);
  } else {
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;
  }

  var_13 = [];

  if(isDefined(level.questinfo)) {
    foreach(var_15 in level.questinfo.tabletinfo) {
      var_13 = "name";
      var_13 = var_16;
      var_13 = "is_enabled";
      var_13 = isDefined(var_15) && istrue(var_15.enabled);
    }
  }

  var_17 = scripts\engine\utility::remove_player_rig_laser_panel(getplaylistid());

  if(isDefined(level.ref_12855)) {
    var_18 = level.ref_12855;
  } else {
    var_18 = -1;
  }

  var_19 = function_042d();
  getentitylessscriptablearray("dlog_event_br_server_match_start", ["br_mission_type_info", var_17, "map", level.script, "sub_game_type", var_5, "max_team_size", var_6, "player_count", var_7, "human_player_count", var_8, "team_count", var_8, "kiosk_respawn_cost", var_12, "gulag_active", var_10, "gulag_max_uses", var_11, "gulag_starting_armor", var_12, "gulag_spawn_loot", var_13, "prematch_end_time", var_18, "playlist_id", var_18, "playlist_name", var_19]);
}