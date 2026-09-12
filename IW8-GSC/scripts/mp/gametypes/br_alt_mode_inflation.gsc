/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_alt_mode_inflation.gsc
**********************************************************/

function init() {
  if(!getdvarint("scr_br_alt_mode_inflation", 0) || scripts\mp\utility\game::round_vehicle_logic() == "truckwar") {
    return;
  }

  level.debug_silo_jump = spawnStruct();
  level.debug_silo_jump.disabled = 0;
  level.debug_silo_jump.cost = getdvarint("scr_br_alt_mode_inflation_cost", 45);
  level.debug_silo_jump.minigamewinnersettings = getdvarfloat("scr_br_alt_mode_inflation_drop_percent", 1);
  level.debug_silo_jump.minigameapplyplayernamesettings = getdvarint("scr_br_alt_mode_inflation_drop_max", -1);
  level.debug_silo_jump.ref_12C89 = getdvarfloat("scr_br_alt_mode_inflation_respawn_delay", 10);
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerDropPlunderOnDeath", &playerdropplunderondeath);
  scripts\mp\gametypes\br_gametypes::ref_12B11("circleTimer", &circletimer);
  scripts\mp\gametypes\br_gametypes::ref_12B11("postPlunder", &ref_12804);
  scripts\mp\gametypes\br_gametypes::ref_12B11("markPlayerAsEliminatedOnKilled", &ref_11B16);
  scripts\mp\gametypes\br_gametypes::ref_12B11("playerGulagAutoWinWait", &ref_125BD);
  scripts\mp\gametypes\br_gametypes::ref_12B11("triggerRespawnOverlay", &ref_13DCB);
  scripts\mp\gametypes\br_gametypes::ref_12B11("assignSpectatorToSpectatePlayer", &assignspectatortospectateplayer);

  if(!getdvarint("scr_br_alt_mode_inflation_gulag", 0)) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulag");
  }

  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("useTokenToReviveTeammate");
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("gulagWinnerRestoreLoadoutUseGulag");
  thread teamswithcirclepeek();
}

function teamswithcirclepeek() {
  while(!isDefined(level.onplayerspawncallbacks)) {
    waitframe();
  }

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
}

function onplayerspawned() {
  ref_14012();
}

function ref_12516() {
  return istrue(level.br_prematchstarted) && !istrue(self.delay_enter_combat_after_investigating_grenade) && !level.debug_silo_jump.disabled && self.plundercount >= level.debug_silo_jump.cost;
}

function playerdropplunderondeath(var_0, var_1) {
  var_2 = self.plundercount;

  if(istrue(self.respawningfromtoken)) {
    var_2 -= level.debug_silo_jump.cost;

    if(var_2 < 0) {
      var_2 = 0;
    }
  }

  var_3 = int(var_2 * level.debug_silo_jump.minigamewinnersettings);
  var_2 -= var_3;
  scripts\mp\gametypes\br_plunder::playersetplundercount(var_2, roof_combat_spawn_func());

  if(level.debug_silo_jump.minigameapplyplayernamesettings >= 0) {
    var_3 = int(min(level.debug_silo_jump.minigameapplyplayernamesettings, var_3));
  }

  scripts\mp\gametypes\br_plunder::ml_p3_func(var_3, var_0);
  return true;
}

function circletimer(var_0) {
  if(!var_0) {
    scripts\mp\gametypes\br_gulag::ref_13249();
  }

  var_1 = scripts\mp\gametypes\br_gulag::remove_engineer_class();

  if(!level.debug_silo_jump.disabled && var_0 >= var_1) {
    level.debug_silo_jump.disabled = 1;

    foreach(var_3 in level.players) {
      if(!isDefined(var_3) || !isalive(var_3)) {
        continue;
      }

      ref_14012(var_3);
      scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var_3, "cash_deploy_closed", undefined, 2);
    }
  }

  return false;
}

function ref_12804(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    var_1 = var_0.ref_133E4;
  }

  ref_14012(var_1);
}

function ref_14012(var_0) {
  if(ref_12516()) {
    if(!scripts\mp\gametypes\br_public::hasrespawntoken()) {
      scripts\mp\gametypes\br_pickups::addrespawntoken(1);

      if(!istrue(var_0)) {
        thread scripts\mp\hud_message::showsplash("br_inflation_respawn_token_pickup");
        return;
      }

      return;
    }

    return;
  }

  if(scripts\mp\gametypes\br_public::hasrespawntoken()) {
    scripts\mp\gametypes\br_pickups::removerespawntoken();

    if(!istrue(var_0)) {
      thread scripts\mp\hud_message::showsplash("br_inflation_respawn_token_lost");
      return;
    }

    return;
  }
}

function ref_1336E(var_0) {
  waittillframeend();
  scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var_0 * 1000));
  scripts\mp\gametypes\br_gulag::ref_131A2(1);
  thread spawn_drones(var_0);
}

function spawn_drones(var_0) {
  self endon("disconnect");

  if(isDefined(var_0)) {
    wait var_0;
  }

  scripts\mp\gametypes\br_gulag::ref_131A2(0);
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

function roof_combat_spawn_func() {
  var_0 = spawnStruct();
  var_0.ref_133E4 = 1;
  return var_0;
}

function ref_11B16() {
  return false;
}

function ref_125BD(var_0, var_1) {
  if(!isDefined(var_0)) {
    if(level.debug_silo_jump.ref_12C89) {
      var_2 = level.debug_silo_jump.ref_12C89;
      thread ref_1336E(var_2);
      wait var_2;
      return true;
    }
  }

  return false;
}

function ref_13DCB(var_0) {
  return true;
}

function assignspectatortospectateplayer(var_0, var_1) {
  var_0 notify("assignSpectatorToSpectatePlayerWaitForTeam");

  if(istrue(level.endmatchcameratransitions)) {
    return false;
  }

  if(!isDefined(var_1) || !isPlayer(var_1) || !isalive(var_1) && !isDefined(var_1.ref_1391A)) {
    return false;
  }

  if(var_0.team == var_1.team) {
    return false;
  }

  if(!scripts\mp\utility\teams::getteamdata(var_0.team, "aliveCount")) {
    return false;
  }

  thread cargo_truck_mg_mp_init(var_0);
  return true;
}

function cargo_truck_mg_mp_init(var_0) {
  level endon("brSpawnPlayersEnding");
  var_0 endon("assignSpectatorToSpectatePlayerWaitForTeam");
  var_0 endon("death_or_disconnect");
  var_0 scripts\mp\gametypes\br_spectate::ref_126AB();
  var_0 setclientomnvar("ui_show_spectateHud", var_0 getentitynumber());
  wait 1;
  var_1 = scripts\mp\gametypes\br_spectate::regive_killstreak_after_use(var_0);
  thread scripts\mp\gametypes\br_spectate::assignspectatortospectateplayer(var_0, var_1);
}