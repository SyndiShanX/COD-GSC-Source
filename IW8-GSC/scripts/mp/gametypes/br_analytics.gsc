/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_analytics.gsc
*************************************************/

function destroycrateinbadtrigger() {
  level.ref_11b22 = &ref_1205b;
  level.º: ] û© ý] oe°„)¡˜ jÃ) û3 #Èû’¨— = &branalytics_revive;

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
  var0 = gettime();

  if(!isDefined(level.ref_12855)) {
    var0 = 0;
  } else {
    var0 -= level.ref_12855;
  }

  return var0;
}

function add_object_to_trap_room_ents(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = (0, 0, 0);
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(!isDefined(var3)) {
    var3 = "";
  }

  var4 = add_pack_characteranim();
  analyticswritecsv(var1, var0, var2, var4, var3);
}

function ai_roof_think(var0) {
  if(!isDefined(var0)) {
    return -1;
  }

  switch (var0) {
    case "deathType_switchingTeams":
      var1 = 6;
      break;
    case "deathType_worldDeath":
      var1 = 3;
      break;
    case "deathType_suicide":
      var1 = 5;
      break;
    case "deathType_friendlyFire":
      var1 = 4;
      break;
    case "deathType_inLastStand":
      var1 = 2;
      break;
    case "deathType_normal":
      var1 = 1;
      break;
    case "downed":
      var1 = 0;
      break;
    default:
      var1 = -1;
      break;
  }

  return var1;
}

function add_pack_camanim(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = "";
  }

  if(!isDefined(level.kothtotaltime[var0])) {
    level.kothtotaltime[var0] = [];
  }

  var4 = spawnStruct();
  var4.type = var0;
  var4.origin = var1;
  var4.ent = var2;
  var4.data = var3;
  var4.state = 0;
  var4.time = add_pack_characteranim();
  var5 = level.kothtotaltime[var0].size;
  level.kothtotaltime[var0][var5] = var4;
}

function dialog_grenade_update(var0, var1, var2) {
  if(!isDefined(var0) || !isDefined(var1) || !isDefined(level.kothtotaltime) || !isDefined(level.kothtotaltime[var0])) {
    return;
  }

  foreach(var4 in level.kothtotaltime[var0]) {
    if(var4.ent == var1) {
      var4.time = add_pack_characteranim();
      var4.state = var2;
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

function branalytics_equipmentuse(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = var1.basename;
  var3 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var3.size, "item_name");
}

function dialog_monitor_hurry(var0) {
  if(!isDefined(var0)) {
    return true;
  }

  switch (var0) {
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

function branalytics_down(var0, var1, var2, var3, var4) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(isDefined(var0.classname) && var0.classname == "agent") {
    return;
  }

  var5 = dialog_monitor_hurry(var0.classname);

  if(!var5 && !isPlayer(var0)) {
    var6 = "attacker.classname: " + var0.classname;
    scripts\mp\utility\script::laststand_dogtags(var6);
  }

  if(var5) {
    var7 = "world";
    var0 = var1;
  } else {
    jumpiffalse(isDefined(var3)) LOC_00000084;
    var7 = var3.basename;
    goto LOC_00000097;
  }

  LOC_00000097:
    var9 = var3 getcurrentweapon();
  var10 = var9.basename;
  var11 = [];
  GscBinSkip0(0x2e, var11.size, "victim");
}

function branalytics_revive(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = [];
  GscBinSkip0(0x2e, var2.size, "revivee");
}

function dialog_grenade_missed(var0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var1 = _branalytics_header(var0, "revivee");
  var0 dlog_recordplayerevent("dlog_event_br_selfrevive", var1);

  if(add_outline()) {
    add_object_to_trap_room_ents("selfRevive", var0.origin);
    return;
  }
}

function diablecachesaroundorigin(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var11 = [];
  GscBinSkip0(0x2e, var11.size, "lastStandAttacker");
}

function dialog_monitor_waitreload(var0, var1, var2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var3 = [];
  GscBinSkip0(0x2e, var3.size, "door_id");
}

function branalytics_deployallowed() {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_deploy_allowed", []);
}

function branalytics_deploytriggered(var0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var1 = _branalytics_header(var0);
  var0 dlog_recordplayerevent("dlog_event_br_deploy_triggered", var1);
}

function detachriotshield(var0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var1 = _branalytics_header(var0);
  var0 dlog_recordplayerevent("dlog_event_br_deploy_land", var1);

  if(add_outline()) {
    add_object_to_trap_room_ents("land", var0.origin);
    return;
  }
}

function detonatedripfx(var0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(add_outline()) {
    add_object_to_trap_room_ents("playerCount", (0, 0, 0), 0, var0);
    return;
  }
}

function determine_starting_breadcrumb(var0, var1, var2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var3 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var3.size, "damage_taken");
}

function branalytics_lootpickup(var0, var1, var2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var3 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var3.size, "item_name");
}

function branalytics_lootdrop(var0, var1, var2, var3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = istrue(var2);
  var4 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var4.size, "item_name");
}

function destroyawardlaunchonly(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var2.size, "type");
}

function destroyaward(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var2.size, "type");
}

function devspectatetesthost(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(add_outline()) {
    add_object_to_trap_room_ents("respawn", (0, 0, 0), var1);
    return;
  }
}

function detonatesound(var0, var1, var2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(add_outline()) {
    add_object_to_trap_room_ents("PlunderRespawn", var0, var1, var2);
    return;
  }
}

function destpoint(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(add_outline()) {
    add_object_to_trap_room_ents("disconnect", (0, 0, 0), var1);
    return;
  }
}

function dialog_intro(var0, var1, var2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var3 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var3.size, "start_station");
}

function destroy_vehicles(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var2.size, "tree_level");
}

function destroy_vehicle_on_pilot_death(var0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var1 = _branalytics_header(var0);
  var0 dlog_recordplayerevent("dlog_event_br_ff_riddle_completed", var1);
}

function destroy_vehicle_if_driver_dies(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var2.size, "elf_level");
}

function destprogress(var0, var1, var2, var3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var4 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var4.size, "drop_x");
}

function destroy_intro_tank(var0, var1, var2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var3 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var3.size, "drop_x");
}

function destroy_bad_traversals(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = [];
  GscBinSkip0(0x2e, var2.size, "drop_team");
}

function descendpos(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var2.size, "time_spent_outside");
}

function descendsolostarts(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var2.size, "time_spent_inside");
}

function destinations(var0, var1, var2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var3 = [];
  GscBinSkip0(0x2e, var3.size, "axis_contracts_completed");
}

function desired_landing_spot(var0, var1, var2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var3 = [];
  GscBinSkip0(0x2e, var3.size, "axis_score");
}

function determinewinnertype(var0, var1, var2, var3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  level waittill("prematch_done");
  getentitylessscriptablearray("dlog_event_br_plane_path", ["center_x", var0[0], "center_y", var0[1], "center_z", var0[2], "yaw", var1, "start_x", var2[0], "start_y", var2[1], "start_z", var2[2], "end_x", var3[0], "end_y", var3[1], "end_z", var3[2]]);
}

function destroy_jammer_relocate(var0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var1 = [];
  var2 = 0;
  var3 = 0;
  var4 = 5000;
  var5 = 0;
  var6 = 5000;

  foreach(var8 in var0) {
    if(!isDefined(var1[var8.team])) {
      var1 = 0;
    }

    if(isDefined(var8.plundercount)) {
      var2 += var8.plundercount;
      var1 = var1[var8.team] + var8.plundercount;

      if(var8.plundercount > var3) {
        var3 = var8.plundercount;
      }

      if(var8.plundercount < var4) {
        var4 = var8.plundercount;
      }
    }

    if(var1[var8.team] > var5) {
      var5 = var1[var8.team];
    }

    if(var1[var8.team] < var6) {
      var6 = var1[var8.team];
    }
  }

  var10 = int(ref_12e53(var2, var0.size));
  var11 = int(ref_12e53(var2, var1.size));
  var12 = [];
  GscBinSkip0(0x2e, var12.size, "num_players_alive");
}

function defusebomb(var0) {
  var1 = var0 getcurrentweapon();
  var2 = undefined;

  if(isDefined(var0.primaryweaponobj) && var1 != var0.primaryweaponobj) {
    var2 = var0.primaryweaponobj;
  } else if(isDefined(var0.secondaryweaponobj) && var1 != var0.secondaryweaponobj) {
    var2 = var0.secondaryweaponobj;
  }

  return [var1, var2];
}

function destroyscorelaunchonly(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = defusebomb(var0);
  var3 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var3.size, "reason");
}

function destructiblevehiclesetup(var0, var1, var2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var3 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var3.size, "plunder_spent");
}

function destructiblecarlightssetup(var0, var1, var2, var3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var4 = _branalytics_header(var0);
  GscBinSkip0(0x2e, var4.size, "plunder_spent");
}

function destructable_car(var0, var1, var2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var3 = _branalytics_header(var0, "kiosk_menu_owner");
  GscBinSkip0(0x2e, var3.size, "kiosk_menu_owner_event");
}

function detonatefxair(var0, var1, var2, var3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var4 = [];
  GscBinSkip0(0x2e, var4.size, "extraction_method");
}

function detonatefx(var0, var1, var2, var3, var4) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var5 = [];
  GscBinSkip0(0x2e, var5.size, "num_depositers");
}

function detonatefunc(var0, var1, var2, var3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var4 = [];
  GscBinSkip0(0x2e, var4.size, "plunder_dropped");
}

function deregisterscriptableinstance(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(isDefined(self)) {
    var2 = self getentitynumber() + "; " + var1;
  } else {
    var2 = "none; " + var2;
  }

  var1 = int(var1);

  if(add_outline()) {
    add_object_to_trap_room_ents("bonusXpDebug", (0, 0, 0), var1, var2);
    return;
  }
}

function branalytics_modespecificscore(var0, var1, var2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = "unknown";
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  var1 = int(var1);
  var0 dlog_recordplayerevent("dlog_event_player_modescore_earned", ["player_life_index", var0.matchdatalifeindex, "player_score_earned", var1, "score_event", var2]);

  if(add_outline()) {
    if(isDefined(var0)) {
      var3 = self getentitynumber() + "; " + var2;
    } else {
      var3 = "none; " + var3;
    }

    add_object_to_trap_room_ents("modeScore", var1.origin, var2, var3);
    return;
  }
}

function dialog_low_health(var0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var1 = [];
  GscBinSkip0(0x2e, var1.size, "amount");
}

function dialog_kill_watcher_civ(var0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var1 = [];
  GscBinSkip0(0x2e, var1.size, "weapon_used");
}

function detonatingplayer(var0, var1, var2, var3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var4 = [];
  GscBinSkip0(0x2e, var4.size, "amount");
}

function detonation_time(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = [];
  GscBinSkip0(0x2e, var2.size, "level_achieved");
}

function detonation_color_omnvar_value(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = [];
  GscBinSkip0(0x2e, var2.size, "amount");
}

function detonation_code_omnvar_value(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = [];
  GscBinSkip0(0x2e, var2.size, "amount");
}

function devspectateenemyteam1(var0, var1, var2) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var3 = [];
  GscBinSkip0(0x2e, var3.size, "amount");
}

function devscriptedtests(var0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var1 = [];
  GscBinSkip0(0x2e, var1.size, "reward_level_reached");
}

function devspectateenemyteam2() {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var0 = [];
  GscBinSkip0(0x2e, var0.size, "amount");
}

function dialog_monitor_shieldstow(var0, var1) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    return;
  }

  if(!dialog_monitor_shieldraise()) {
    return;
  }

  if(add_outline() && isDefined(level.ref_12855)) {
    add_pack_camanim("vehicle", var0.origin, var0, var1);
    return;
  }
}

function branalytics_skyhookredeploy(var0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var1 = _branalytics_header(var0);
  var0 dlog_recordplayerevent("dlog_event_skyhook_redeploy", var1);
}

function destroypropspecatehud(var0, var1, var2, var3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_mission_init", ["num_missions", var0, "num_missions_active", var1, "num_missions_hidden", var2, "hide_percent", var3]);
}

function destorder(var0, var1, var2, var3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_mission_repopulate", ["circle_index", var0, "show_percent", var1, "num_valid", var2, "num_shown", var3]);
}

function dialog_hurry(var0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_mission_spawn", ["id", scripts\engine\utility::ter_op(isDefined(var0.index), "" + var0.index, "invalid"), "type", var0.ref_139eb, "origin_x", var0.origin[0], "origin_y", var0.origin[1], "origin_z", var0.origin[2]]);

  if(add_outline() && isDefined(var0.index)) {
    add_pack_camanim("mission", var0.origin, "" + var0.index, var0.ref_139eb);
    return;
  }
}

function destroyscoreevent(var0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_mission_invalid", ["id", scripts\engine\utility::ter_op(isDefined(var0.index), "" + var0.index, "invalid"), "type", var0.ref_139eb, "origin_x", var0.origin[0], "origin_y", var0.origin[1], "origin_z", var0.origin[2]]);
}

function reset_ability_invulnerable(var0) {
  var1 = 0;

  if(var0.questcategory == "blueprintextract") {
    if(isDefined(var0.overwatch_soldiers_05_bombers)) {
      var1 = var0.overwatch_soldiers_05_bombers;
    }
  }

  return var1;
}

function determinetrackingcirclesize(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  var2 = [];
  var3 = scripts\mp\utility\teams::getfriendlyplayers(var1.team, 1);
  var2 = add_pack_modelanim(var2, var3);
  var2 = "id";
  var2 = scripts\engine\utility::ter_op(isDefined(var0.ref_11c4e), var0.ref_11c4e, "invalid");

  if(isDefined(level.br_circle)) {
    var4 = scripts\engine\utility::remove_player_rig_laser_panel(level.br_circle.circleindex);
  } else {
    var4 = -1;
  }

  var3 = "circle_index";
  var3 = var4;
  var3 = "type";
  var3 = var1.questcategory;
  var3 = "blueprint_loot_id";
  var3 = reset_ability_invulnerable(var1);
  var2 dlog_recordplayerevent("dlog_event_br_mission_start", var3);

  if(add_outline() && isDefined(var1.ref_11c4e)) {
    dialog_grenade_update("mission", var1.ref_11c4e, -1);
    return;
  }
}

function determinetrackingcircleoffset(var0, var1, var2, var3) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_mission_end", ["id", scripts\engine\utility::ter_op(isDefined(var0.ref_11c4e), var0.ref_11c4e, "invalid"), "result", scripts\engine\utility::ter_op(isDefined(var0.result), var0.result, "unknown"), "reward_tier", var1, "xp", scripts\engine\utility::ter_op(isDefined(var2["xp"]), var2["xp"], 0), "weapon_xp", scripts\engine\utility::ter_op(isDefined(var2["weapon_xp"]), var2["weapon_xp"], 0), "plunder", scripts\engine\utility::ter_op(isDefined(var2["plunder"]), var2["plunder"], 0), "num_teammates_awarded", scripts\engine\utility::ter_op(isDefined(var3), var3, 0), "type", var0.questcategory, "blueprint_loot_id", reset_ability_invulnerable(var0)]);

  if(add_outline() && isDefined(var0.ref_11c4e)) {
    if(isDefined(var0.result) && var0.result == "success") {
      dialog_grenade_update("mission", var0.ref_11c4e, var1);
      return;
    }

    dialog_grenade_update("mission", var0.ref_11c4e, -1);
    return;
  }
}

function dialog_monitor_getoffground(var0, var1) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_team_eliminated", ["team", var0, "placement", var1, "survival_time", gettime() - level.starttime]);
}

function devspectatetest(var0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_public_event_start", ["type", var0]);
}

function devspectateloc(var0) {
  if(!dialog_monitor_shieldraise()) {
    return;
  }

  getentitylessscriptablearray("dlog_event_br_public_event_end", ["type", var0]);
}

function _branalytics_header(var0, var1) {
  var2 = [];

  if(!isstring(var1)) {
    var1 = "player";
  }

  var2 = add_pack_fx(var2, var0, var1);

  if(isDefined(level.br_circle)) {
    var3 = scripts\engine\utility::remove_player_rig_laser_panel(level.br_circle.circleindex);
  } else {
    var3 = -1;
  }

  var3 = "circle_index";
  var3 = var3;
  return var3;
}

function add_pack_fx(var0, var1, var2) {
  if(!isstring(var2)) {
    var2 = "player";
  }

  var0 = var2 + "_x";
  var0 = var1.origin[0];
  var0 = var2 + "_y";
  var0 = var1.origin[1];
  var0 = var2 + "_z";
  var0 = var1.origin[2];
  var0 = var2 + "_pitch";
  var0 = scripts\engine\utility::getplayerpitch(var1);
  var0 = var2 + "_yaw";
  var0 = scripts\engine\utility::getplayeryaw(var1);
  return var0;
}

function add_pack_modelanim(var0, var1) {
  var0 = "living_player_pos";
  var2 = [];

  foreach(var4 in var1) {
    var2 = "x";
    var2 = var4.origin[0];
    var2 = "y";
    var2 = var4.origin[1];
    var2 = "z";
    var2 = var4.origin[2];
    var2 = "pitch";
    var2 = scripts\engine\utility::getplayerpitch(var4);
    var2 = "yaw";
    var2 = scripts\engine\utility::getplayeryaw(var4);
  }

  var0 = var2;
  return var0;
}

function ref_12e4f(var0) {
  if(isDefined(var0)) {
    return var0;
  }

  return "empty";
}

function ref_12e50(var0) {
  if(isDefined(var0)) {
    return var0;
  }

  return "";
}

function ref_12e51(var0) {
  if(isDefined(var0)) {
    return var0.basename;
  }

  return "empty";
}

function ref_12e4e(var0) {
  if(isDefined(var0)) {
    return var0;
  }

  return 0;
}

function ref_12e53(var0, var1) {
  if(!isDefined(var1) || var1 <= 0) {
    return (var0 / 1);
  }

  return var0 / var1;
}

function destroy_lmgs() {
  if(add_outline()) {
    if(isDefined(level.kothtotaltime["vehicle"])) {
      foreach(var1 in level.kothtotaltime["vehicle"]) {
        if(!isDefined(var1.ent)) {
          var1.state = 1;
          continue;
        }

        if(distancesquared(var1.origin, var1.ent.origin) > squared(1000)) {
          var1.state = 1;
        }
      }
    }

    if(isDefined(level.br_armory_kiosk)) {
      foreach(var4 in level.br_armory_kiosk.scriptables) {
        if(istrue(var4.visible)) {
          analyticswritecsv(var4.origin, "kiosk", 1, 0, "");
          continue;
        }

        analyticswritecsv(var4.origin, "kiosk", 0, 0, "");
      }
    }

    if(isDefined(level.br_level) && isDefined(level.br_level.default_class_chosen)) {
      var6 = level.br_level.default_class_chosen.size - 1;
      var7 = 0;

      for(var8 = 0; var8 < var6; var8++) {
        var9 = level.br_level.default_class_chosen[var8 + 1];
        var10 = level.br_level.br_circleradii[var8 + 1];
        var11 = level.br_level.br_circledelaytimes[var8];
        var12 = level.br_level.br_circleclosetimes[var8];
        var7 = var7 + var11 + var12;
        analyticswritecsv(var9, "circle", int(var10), int(var7), "");
      }
    }

    foreach(var14 in level.kothtotaltime) {
      foreach(var16 in var14) {
        analyticswritecsv(var16.origin, var16.type, var16.state, var16.time, var16.data);
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

  foreach(var1 in level.teamnamelist) {
    var2 = spawnStruct();
    var2.sources = [];
    var2.ref_13bf0 = [];

    foreach(var4 in level.get_vehicle_driver_hint_string_func) {
      var2.sources[var4] = 0;
      var2.ref_13bf0[var4] = 0;
    }

    level.get_veh_spawn_test_spawners[var1] = var2;
  }

  level waittill("prematch_done");
  thread ref_12aa6();
}

function ref_12aa6() {
  for(var0 = 60; !istrue(level.gameended); var0 = max(60 - var12, 0)) {
    level scripts\engine\utility::waittill_notify_or_timeout("game_ended", var0);
    var1 = gettime();
    var2 = scripts\mp\gamescore::run_common_functions_stealth();

    foreach(var4 in level.teamnamelist) {
      if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var4)) {
        continue;
      }

      if(!isDefined(var4)) {
        continue;
      }

      var5 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
      var6 = [];
      var6 = "match_complete";
      var6 = 0;
      var6 = "time";
      var6 = var5;
      var6 = "team";
      var6 = var4;
      var6 = "placement";
      var6 = var2[var4];

      foreach(var8 in level.get_vehicle_driver_hint_string_func) {
        var9 = level.get_veh_spawn_test_spawners[var4].sources[var8];
        var6 = "cash_source_" + var8;
        var6 = var9;
        level.get_veh_spawn_test_spawners[var4].ref_13bf0[var8] += var9;
        level.get_veh_spawn_test_spawners[var4].sources[var8] = 0;
      }

      getentitylessscriptablearray("dlog_event_blood_money_interval", var6);
      waitframe();
    }

    var12 = (gettime() - var1) * 0.001;
  }

  var5 = scripts\mp\matchdata::gettimefrommatchstart(gettime());
  var2 = scripts\mp\gamescore::run_common_functions_stealth();

  foreach(var4 in level.teamnamelist) {
    if(level scripts\mp\utility\game::vehicle_collision_ignorefuturemultievent(var4)) {
      continue;
    }

    var6 = [];
    var6 = "match_complete";
    var6 = 1;
    var6 = "time";
    var6 = var5;
    var6 = "team";
    var6 = var4;
    var6 = "placement";
    var6 = var2[var4];

    foreach(var8 in level.get_vehicle_driver_hint_string_func) {
      var9 = level.get_veh_spawn_test_spawners[var4].ref_13bf0[var8];
      var6 = "cash_source_" + var8;
      var6 = var9;
    }

    getentitylessscriptablearray("dlog_event_blood_money_interval", var6);
  }
}

function ref_13c44(var0, var1, var2) {
  if(!isDefined(var0) || !isDefined(var0.team)) {
    return;
  }

  if(add_outline()) {
    add_object_to_trap_room_ents("plunder_award", var0.origin, var2, var0.team + "; " + var0 getentitynumber() + "; " + var1);
  }

  if(!isDefined(level.get_veh_spawn_test_spawners)) {
    return;
  }

  var3 = var0.team;
  level.get_veh_spawn_test_spawners[var3].sources[var1] += var2;
}

function ref_1205b() {
  thread allowed_objectives();
}

function allowed_objectives() {
  waittillframeend();
  var0 = level.disable_super_in_turret.name;
  var1 = scripts\engine\utility::remove_player_rig_laser_panel(level.maxteamsize);
  var2 = scripts\engine\utility::remove_player_rig_laser_panel(level.players.size);
  var3 = scripts\engine\utility::remove_player_rig_laser_panel(level.teamswithplayers.size);
  var4 = 0;

  foreach(var6 in level.players) {
    if(isbot(var6) || var6 calloutmarkerping_getEnt()) {
      continue;
    }

    var4++;
  }

  if(isDefined(level.br_armory_kiosk)) {
    var8 = scripts\engine\utility::remove_player_rig_laser_panel(level.br_armory_kiosk.ref_13ac2);
  } else {
    var8 = 0;
  }

  var9 = scripts\engine\utility::remove_player_rig_laser_panel(level.usegulag);

  if(isDefined(level.gulag)) {
    var10 = scripts\engine\utility::remove_player_rig_laser_panel(level.gulag.maxuses);
    var11 = scripts\engine\utility::remove_player_rig_laser_panel(level.gulag.ref_11f2d);
    var12 = scripts\engine\utility::remove_player_rig_laser_panel(level.gulag.ref_13672);
  } else {
    var10 = 0;
    var11 = 0;
    var12 = 0;
  }

  var13 = [];

  if(isDefined(level.questinfo)) {
    foreach(var15 in level.questinfo.tabletinfo) {
      var13 = "name";
      var13 = var16;
      var13 = "is_enabled";
      var13 = isDefined(var15) && istrue(var15.enabled);
    }
  }

  var17 = scripts\engine\utility::remove_player_rig_laser_panel(getplaylistid());

  if(isDefined(level.ref_12855)) {
    var18 = level.ref_12855;
  } else {
    var18 = -1;
  }

  var19 = function_042d();
  getentitylessscriptablearray("dlog_event_br_server_match_start", ["br_mission_type_info", var17, "map", level.script, "sub_game_type", var5, "max_team_size", var6, "player_count", var7, "human_player_count", var8, "team_count", var8, "kiosk_respawn_cost", var12, "gulag_active", var10, "gulag_max_uses", var11, "gulag_starting_armor", var12, "gulag_spawn_loot", var13, "prematch_end_time", var18, "playlist_id", var18, "playlist_name", var19]);
}