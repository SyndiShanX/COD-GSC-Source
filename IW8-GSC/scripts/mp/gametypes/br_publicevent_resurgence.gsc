/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_publicevent_resurgence.gsc
**************************************************************/

function init() {
  var0 = spawnStruct();
  var0.attackerswaittime = &ascendermodelview;
  var0.isfeaturedisabled = &deactivate;
  var0.‹Á¿ ø {
    ÏXX;
    â # / = &postinitfunc;
    var0.weight = getdvarfloat("scr_br_pe_resurgence_weight", 0);
    var0.ref_11b78 = getdvarint("scr_br_pe_resurgence_max_times", 1);
    var0.guard_door_clip = scripts\mp\gametypes\br_publicevents::relic_squadlink_init_vfx("resurgence", "55 1010105 5 1");
    var0.£¼#w]
  j‹ ƒ½ Ï‚ UÀíÌI¸ Û« = scripts\mp\gametypes\br_publicevents_meter::getdvarpemetereventweights("resurgence");
  scripts\mp\gametypes\br_publicevents::ref_12b35(14, var0);
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
  level.playingthrowingknifewickfx["triggerRespawnOverlay"] = &scripts\mp\gametypes\br_gulag::ref_13dcc;
  level.playingthrowingknifewickfx["playerNakedDropLoadout"] = &scripts\mp\gametypes\br::ref_11e23;
  scripts\mp\gametypes\br_gametypes::ref_12b11("mayConsiderPlayerDead", &add_to_score_message);
  scripts\mp\gametypes\br_gametypes::ref_12b11("triggerRespawnOverlay", &add_to_spawnflags);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerNakedDropLoadout", &add_to_spawn_count_from_group);
  scripts\mp\gametypes\br_gametypes::ref_12b11("isTeamEliminated", &validate_and_activate_stations);
}

function validate_and_activate_stations(var0) {
  var1 = scripts\mp\utility\teams::getteamdata(var0, "players");

  foreach(var3 in var1) {
    if(isalive(var3)) {
      return false;
    }

    var4 = var3 scripts\mp\gametypes\br_gulag::ref_12517();

    if(var4) {
      return false;
    }
  }

  return true;
}

function loadout_editglobalclassstruct() {
  level.disable_super_in_turret.funcs["mayConsiderPlayerDead"] = undefined;
  level.disable_super_in_turret.funcs["triggerRespawnOverlay"] = undefined;
  level.disable_super_in_turret.funcs["playerNakedDropLoadout"] = undefined;
  scripts\mp\gametypes\br_gametypes::ref_12b11("mayConsiderPlayerDead", level.disable_super_in_turret.ref_12883["mayConsiderPlayerDead"]);
  scripts\mp\gametypes\br_gametypes::ref_12b11("triggerRespawnOverlay", level.disable_super_in_turret.ref_12883["triggerRespawnOverlay"]);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerNakedDropLoadout", level.disable_super_in_turret.ref_12883["playerNakedDropLoadout"]);
  level.disable_super_in_turret.ref_12883["mayConsiderPlayerDead"] = undefined;
  level.disable_super_in_turret.ref_12883["triggerRespawnOverlay"] = undefined;
  level.disable_super_in_turret.ref_12883["playerNakedDropLoadout"] = undefined;
  level.disable_super_in_turret.ref_12883 = undefined;
  scripts\mp\gametypes\br_gametypes::ref_13f25("isTeamEliminated");
}

function allassassin_givewait(var0) {
  if(istrue(level.disable_super_in_turret.ref_12ca4)) {
    return [[level.playjailbreakvo[var0]]]();
  }

  if(isDefined(level.disable_super_in_turret.ref_12883)) {
    return [[level.disable_super_in_turret.ref_12883[var0]]]();
  }

  return [[level.playingthrowingknifewickfx[var0]]]();
}

function allassassin_init(var0, var1) {
  if(istrue(level.disable_super_in_turret.ref_12ca4)) {
    return [[level.playjailbreakvo[var0]]](var1);
  }

  if(isDefined(level.disable_super_in_turret.ref_12883)) {
    return [[level.disable_super_in_turret.ref_12883[var0]]](var1);
  }

  return [[level.playingthrowingknifewickfx[var0]]](var1);
}

function add_to_score_message(var0) {
  return allassassin_init("mayConsiderPlayerDead", var0);
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
  var0 = "vov_redeploy_standby";
  scripts\mp\gametypes\br_public::brleaderdialog(var0, 0);
  level.disable_super_in_turret.ref_12ca4 = 1;
  level.disable_super_in_turret.fly_to_laser_trap_start_pos = 1;
  level.disable_super_in_turret.ref_14081 = 1;
  scripts\mp\gametypes\br_gametype_rebirth::end_reach_icbm_launch();
  var1 = 30;
  level.disable_super_in_turret.ref_12a7b = var1;

  foreach(var3 in level.teamnamelist) {
    var4 = level.teamdata[var3]["players"];

    if(var4.size <= 1) {
      continue;
    }

    var5 = 0;
    var6 = undefined;

    foreach(var8 in var4) {
      var9 = var8 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();

      if(isalive(var8) && !var9) {
        var6 = var8;
        continue;
      }

      var5 = 1;
    }

    if(!isDefined(var6) || !var5) {
      continue;
    }

    foreach(var8 in var4) {
      var12 = !isalive(var8);
      var9 = var8 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal();

      if(var12 || var9) {
        scripts\mp\gametypes\br_vip_quest::ref_142c5(var8, var6, "exfil_respawn");
        continue;
      }

      var8 thread scripts\mp\hud_message::showsplash("br_squadmate_revived");
    }
  }

  setomnvar("ui_publicevent_minimap_pulse", 1);
  setomnvar("ui_publicevent_timer_type", 5);
  var15 = scripts\mp\gametypes\br_circle::groupindex(level.br_circle.circleindex);
  var16 = getdvarfloat("scr_br_pe_resurgence_duration", var15);

  if(scripts\mp\gametypes\br_publicevents::unset_relic_healthpacks()) {
    var16 = scripts\mp\gametypes\br_circle::inithelirepository();
  }

  var17 = gettime() + var16 * 1000;
  setomnvar("ui_publicevent_timer", var17);
  var18 = spawn("script_origin", (0, 0, 0));
  var18 hide();
  wait var16 - 5;

  for(var19 = 0; var19 < 5; var19++) {
    var18 playSound("ui_mp_fire_sale_timer");
    wait 1;
  }

  setomnvar("ui_publicevent_minimap_pulse", 0);
  setomnvar("ui_publicevent_timer_type", 0);
  var18 delete();
}

function deactivate() {
  loadout_editglobalclassstruct();
  setDvar("scr_br_resurgence_respawn_enable", 0);
  level.disable_super_in_turret.ref_12ca4 = 0;
  level.disable_super_in_turret.fly_to_laser_trap_start_pos = undefined;

  foreach(var1 in level.players) {
    if(!isDefined(var1)) {
      continue;
    }

    var1 scripts\mp\gametypes\br_public::updatebrscoreboardstat("respawnInSeconds", 0);
    setDvar("scr_br_resurgence_hide_close_ui", 1);
    scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var1, "respawn_disabled", undefined, 2);
    var1 setclientomnvar("ui_br_plunder_extract_end_time", 0);
  }
}