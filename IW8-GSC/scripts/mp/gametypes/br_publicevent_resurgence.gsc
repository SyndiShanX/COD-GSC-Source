/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_resurgence.gsc
**************************************************************/

function init() {
  var_0 = spawnStruct();
  var_0.attackerswaittime = &ascendermodelview;
  var_0.isfeaturedisabled = &deactivate;
  var_0.postinitfunc = &postinitfunc;
  var_0.weight = getdvarfloat("scr_br_pe_resurgence_weight", 0);
  var_0.ref_11B78 = getdvarint("scr_br_pe_resurgence_max_times", 1);
  var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("resurgence", "55 1010105 5 1");
  var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("resurgence");
  scripts\mp\gametypes\br_publicevents::ref_12B35(14, var_0);
}

function postinitfunc() {
  game["dialog"]["vov_redeploy_authorized"] = "vov_redeploy_authorized";
  game["dialog"]["vov_redeploy_standby"] = "vov_redeploy_standby";
}

function move_spawnpoints_to_ac130() {
  level.disable_super_in_turret.ref_12883 = [];
  level.disable_super_in_turret.ref_12883["mayConsiderPlayerDead"] = level.disable_super_in_turret.funcs["mayConsiderPlayerDead"];
  level.disable_super_in_turret.ref_12883["triggerRespawnOverlay"] = level.disable_super_in_turret.funcs["triggerRespawnOverlay"];
  level.disable_super_in_turret.ref_12883["playerNakedDropLoadout"] = level.disable_super_in_turret.funcs["playerNakedDropLoadout"];
  level.disable_super_in_turret.funcs["mayConsiderPlayerDead"] = undefined;
  level.disable_super_in_turret.funcs["triggerRespawnOverlay"] = undefined;
  level.disable_super_in_turret.funcs["playerNakedDropLoadout"] = undefined;
  level.playjailbreakvo["mayConsiderPlayerDead"] = &scripts\mp\gametypes\br_gametype_rebirth::empty_function;
  level.playjailbreakvo["triggerRespawnOverlay"] = &scripts\mp\gametypes\br_gametype_rebirth::end_silo_thrust;
  level.playjailbreakvo["playerNakedDropLoadout"] = &scripts\mp\gametypes\br_gametype_rebirth::end_intro_obj;
  level.playingthrowingknifewickfx["mayConsiderPlayerDead"] = &scripts\mp\gametypes\br::dynamic_door;
  level.playingthrowingknifewickfx["triggerRespawnOverlay"] = &scripts\mp\gametypes\br_gulag::ref_13DCC;
  level.playingthrowingknifewickfx["playerNakedDropLoadout"] = &scripts\mp\gametypes\br::ref_11E23;
  scripts\mp\gametypes\br_gametypes::ref_12B11("mayConsiderPlayerDead", &add_to_score_message);
  scripts\mp\gametypes\br_gametypes::ref_12B11("triggerRespawnOverlay", &add_to_spawnflags);
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerNakedDropLoadout", &add_to_spawn_count_from_group);
  scripts\mp\gametypes\br_gametypes::ref_12B11("isTeamEliminated", &validate_and_activate_stations);
}

function validate_and_activate_stations(var_0) {
  var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");

  foreach(var_3 in var_1) {
    if(isalive(var_3)) {
      return false;
    }

    var_4 = var_3 scripts\mp\gametypes\br_gulag::ref_12517();

    if(var_4) {
      return false;
    }
  }

  return true;
}

function loadout_editglobalclassstruct() {
  level.disable_super_in_turret.funcs["mayConsiderPlayerDead"] = undefined;
  level.disable_super_in_turret.funcs["triggerRespawnOverlay"] = undefined;
  level.disable_super_in_turret.funcs["playerNakedDropLoadout"] = undefined;
  scripts\mp\gametypes\br_gametypes::ref_12B11("mayConsiderPlayerDead", level.disable_super_in_turret.ref_12883["mayConsiderPlayerDead"]);
  scripts\mp\gametypes\br_gametypes::ref_12B11("triggerRespawnOverlay", level.disable_super_in_turret.ref_12883["triggerRespawnOverlay"]);
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerNakedDropLoadout", level.disable_super_in_turret.ref_12883["playerNakedDropLoadout"]);
  level.disable_super_in_turret.ref_12883["mayConsiderPlayerDead"] = undefined;
  level.disable_super_in_turret.ref_12883["triggerRespawnOverlay"] = undefined;
  level.disable_super_in_turret.ref_12883["playerNakedDropLoadout"] = undefined;
  level.disable_super_in_turret.ref_12883 = undefined;
  scripts\mp\gametypes\br_gametypes::ref_13F25("isTeamEliminated");
}

function allassassin_givewait(var_0) {
  if(istrue(level.disable_super_in_turret.ref_12CA4)) {
    return [[level.playjailbreakvo[var_0]]]();
  }

  if(isDefined(level.disable_super_in_turret.ref_12883)) {
    return [[level.disable_super_in_turret.ref_12883[var_0]]]();
  }

  return [[level.playingthrowingknifewickfx[var_0]]]();
}

function allassassin_init(var_0, var_1) {
  if(istrue(level.disable_super_in_turret.ref_12CA4)) {
    return [[level.playjailbreakvo[var_0]]](var_1);
  }

  if(isDefined(level.disable_super_in_turret.ref_12883)) {
    return [[level.disable_super_in_turret.ref_12883[var_0]]](var_1);
  }

  return [[level.playingthrowingknifewickfx[var_0]]](var_1);
}

function add_to_score_message(var_0) {
  return allassassin_init("mayConsiderPlayerDead", var_0);
}

function add_to_spawnflags() {
  return allassassin_givewait("triggerRespawnOverlay");
}

function add_to_spawn_count_from_group() {
  return allassassin_givewait("playerNakedDropLoadout");
}

function ascendermodelview() {
  move_spawnpoints_to_ac130();
  setDvar("scr_br_resurgence_respawn_enable", 1);
  scripts\mp\gametypes\br_publicevents::ref_13371("br_pe_resurgence_start");
  var_0 = "vov_redeploy_standby";
  scripts\mp\gametypes\br_public::brleaderdialog(var_0, 0);
  level.disable_super_in_turret.ref_12CA4 = 1;
  level.disable_super_in_turret.fly_to_laser_trap_start_pos = 1;
  level.disable_super_in_turret.ref_14081 = 1;
  scripts\mp\gametypes\br_gametype_rebirth::end_reach_icbm_launch();
  var_1 = 30;
  level.disable_super_in_turret.ref_12A7B = var_1;

  foreach(var_3 in level.teamnamelist) {
    var_4 = level.teamdata[var_3]["players"];

    if(var_4.size <= 1) {
      continue;
    }

    var_5 = 0;
    var_6 = undefined;

    foreach(var_8 in var_4) {
      var_9 = var_8 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();

      if(isalive(var_8) && !var_9) {
        var_6 = var_8;
        continue;
      }

      var_5 = 1;
    }

    if(!isDefined(var_6) || !var_5) {
      continue;
    }

    foreach(var_8 in var_4) {
      var_12 = !isalive(var_8);
      var_9 = var_8 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();

      if(var_12 || var_9) {
        scripts\mp\gametypes\br_vip_quest::ref_142C5(var_8, var_6, "exfil_respawn");
        continue;
      }

      var_8 thread scripts\mp\hud_message::showsplash("br_squadmate_revived");
    }
  }

  setomnvar("ui_publicevent_minimap_pulse", 1);
  setomnvar("ui_publicevent_timer_type", 5);
  var_15 = scripts\mp\gametypes\br_circle::groupindex(level.br_circle.circleindex);
  var_16 = getdvarfloat("scr_br_pe_resurgence_duration", var_15);

  if(scripts\mp\gametypes\br_publicevents::unset_relic_healthpacks()) {
    var_16 = scripts\mp\gametypes\br_circle::inithelirepository();
  }

  var_17 = gettime() + var_16 * 1000;
  setomnvar("ui_publicevent_timer", var_17);
  var_18 = spawn("script_origin", (0, 0, 0));
  var_18 hide();
  wait var_16 - 5;

  for(var_19 = 0; var_19 < 5; var_19++) {
    var_18 playSound("ui_mp_fire_sale_timer");
    wait 1;
  }

  setomnvar("ui_publicevent_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
  var_18 delete();
}

function deactivate() {
  loadout_editglobalclassstruct();
  setDvar("scr_br_resurgence_respawn_enable", 0);
  level.disable_super_in_turret.ref_12CA4 = 0;
  level.disable_super_in_turret.fly_to_laser_trap_start_pos = undefined;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", 0);
    setDvar("scr_br_resurgence_hide_close_ui", 1);
    scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var_1, "respawn_disabled", undefined, 2);
    var_1 setclientomnvar("ui_br_plunder_extract_end_time", 0);
  }
}