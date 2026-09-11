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
  level.debug_silo_jump.ref_12c89 = getdvarfloat("scr_br_alt_mode_inflation_respawn_delay", 10);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerDropPlunderOnDeath", &playerdropplunderondeath);
  scripts\mp\gametypes\br_gametypes::ref_12b11("circleTimer", &circletimer);
  scripts\mp\gametypes\br_gametypes::ref_12b11("postPlunder", &ref_12804);
  scripts\mp\gametypes\br_gametypes::ref_12b11("markPlayerAsEliminatedOnKilled", &ref_11b16);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerGulagAutoWinWait", &ref_125bd);
  scripts\mp\gametypes\br_gametypes::ref_12b11("triggerRespawnOverlay", &ref_13dcb);
  scripts\mp\gametypes\br_gametypes::ref_12b11("assignSpectatorToSpectatePlayer", &assignspectatortospectateplayer);

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

function playerdropplunderondeath(var0, var1) {
  var2 = self.plundercount;

  if(istrue(self.respawningfromtoken)) {
    var2 -= level.debug_silo_jump.cost;

    if(var2 < 0) {
      var2 = 0;
    }
  }

  var3 = int(var2 * level.debug_silo_jump.minigamewinnersettings);
  var2 -= var3;
  scripts\mp\gametypes\br_plunder::playersetplundercount(var2, roof_combat_spawn_func());

  if(level.debug_silo_jump.minigameapplyplayernamesettings >= 0) {
    var3 = int(min(level.debug_silo_jump.minigameapplyplayernamesettings, var3));
  }

  scripts\mp\gametypes\br_plunder::ml_p3_func(var3, var0);
  return true;
}

function circletimer(var0) {
  if(!var0) {
    scripts\mp\gametypes\br_gulag::ref_13249();
  }

  var1 = scripts\mp\gametypes\br_gulag::remove_engineer_class();

  if(!level.debug_silo_jump.disabled && var0 >= var1) {
    level.debug_silo_jump.disabled = 1;

    foreach(var3 in level.players) {
      if(!isDefined(var3) || !isalive(var3)) {
        continue;
      }

      ref_14012(var3);
      scripts\mp\gametypes\br_killstreaks::isbrsquadleader(var3, "cash_deploy_closed", undefined, 2);
    }
  }

  return false;
}

function ref_12804(var0) {
  var1 = 0;

  if(isDefined(var0)) {
    var1 = var0.ref_133e4;
  }

  ref_14012(var1);
}

function ref_14012(var0) {
  if(ref_12516()) {
    if(!scripts\mp\gametypes\br_public::hasrespawntoken()) {
      scripts\mp\gametypes\br_pickups::addrespawntoken(1);

      if(!istrue(var0)) {
        thread scripts\mp\hud_message::showsplash("br_inflation_respawn_token_pickup");
        return;
      }

      return;
    }

    return;
  }

  if(scripts\mp\gametypes\br_public::hasrespawntoken()) {
    scripts\mp\gametypes\br_pickups::removerespawntoken();

    if(!istrue(var0)) {
      thread scripts\mp\hud_message::showsplash("br_inflation_respawn_token_lost");
      return;
    }

    return;
  }
}

function ref_1336e(var0) {
  waittillframeend();
  scripts\mp\utility\lower_message::setlowermessageomnvar(9, int(gettime() + var0 * 1000));
  scripts\mp\gametypes\br_gulag::ref_131a2(1);
  thread spawn_drones(var0);
}

function spawn_drones(var0) {
  self endon("disconnect");

  if(isDefined(var0)) {
    wait var0;
  }

  scripts\mp\gametypes\br_gulag::ref_131a2(0);
  scripts\mp\utility\lower_message::setlowermessageomnvar(0);
}

function roof_combat_spawn_func() {
  var0 = spawnStruct();
  var0.ref_133e4 = 1;
  return var0;
}

function ref_11b16() {
  return false;
}

function ref_125bd(var0, var1) {
  if(!isDefined(var0)) {
    if(level.debug_silo_jump.ref_12c89) {
      var2 = level.debug_silo_jump.ref_12c89;
      thread ref_1336e(var2);
      wait var2;
      return true;
    }
  }

  return false;
}

function ref_13dcb(var0) {
  return true;
}

function assignspectatortospectateplayer(var0, var1) {
  var0 notify("assignSpectatorToSpectatePlayerWaitForTeam");

  if(istrue(level.endmatchcameratransitions)) {
    return false;
  }

  if(!isDefined(var1) || !isPlayer(var1) || !isalive(var1) && !isDefined(var1.ref_1391a)) {
    return false;
  }

  if(var0.team == var1.team) {
    return false;
  }

  if(!scripts\mp\utility\teams::getteamdata(var0.team, "aliveCount")) {
    return false;
  }

  thread cargo_truck_mg_mp_init(var0);
  return true;
}

function cargo_truck_mg_mp_init(var0) {
  level endon("brSpawnPlayersEnding");
  var0 endon("assignSpectatorToSpectatePlayerWaitForTeam");
  var0 endon("death_or_disconnect");
  var0 scripts\mp\gametypes\br_spectate::ref_126ab();
  var0 setclientomnvar("ui_show_spectateHud", var0 getentitynumber());
  wait 1;
  var1 = scripts\mp\gametypes\br_spectate::regive_killstreak_after_use(var0);
  thread scripts\mp\gametypes\br_spectate::assignspectatortospectateplayer(var0, var1);
}