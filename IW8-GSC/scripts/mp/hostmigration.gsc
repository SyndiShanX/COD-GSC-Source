/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\hostmigration.gsc
***********************************************/

function callback_hostmigration() {
  level.hostmigrationreturnedplayercount = 0;

  if(level.gameended) {
    return;
  }

  if(drawentitybounds()) {
    analyticsstreamerlogfilewritetobuffer();
  }

  thread hostmigrationconnectwatcher();

  foreach(var_1 in level.characters) {
    var_1.hostmigrationcontrolsfrozen = 0;
  }

  level.hostmigrationtimer = 1;
  setDvar("ui_inhostmigration", 1);
  level.hostmigration = 1;
  level notify("host_migration_begin");
  scripts\mp\gamelogic::updatetimerpausedness();

  foreach(var_1 in level.characters) {
    thread hostmigrationtimerthink();

    if(isPlayer(var_1)) {
      var_1 setclientomnvar("ui_session_state", var_1.sessionstate);

      if(drawentitybounds()) {
        analyticsstreamerislogfilestreamingenabled(var_1.guid);
        LOC_000000c6:
      }
      LOC_000000c6:
    }
    LOC_000000c6:
  }

  level endon("host_migration_begin");
  hostmigrationwait();
  level.hostmigrationtimer = undefined;
  setDvar("ui_inhostmigration", 0);
  visionsetthermal(game["thermal_vision"]);
  level.hostmigration = 0;
  level notify("host_migration_end");
  scripts\mp\gamelogic::updatetimerpausedness();
  level thread[[level.updategameevents]]();
}

function hostmigrationconnectwatcher() {
  level endon("host_migration_end");
  level endon("host_migration_begin");
  level waittill("connected", var_0);
  thread hostmigrationtimerthink();

  if(isPlayer(var_0)) {
    var_0 setclientomnvar("ui_session_state", var_0.sessionstate);
    return;
  }
}

function hostmigrationwait() {
  level endon("game_ended");
  level.ingraceperiod = 25;
  thread scripts\mp\gamelogic::matchstarttimer("waiting_for_players", 20);
  hostmigrationwaitforplayers();
  level.ingraceperiod = 10;
  thread scripts\mp\gamelogic::matchstarttimer("match_resuming_in", 5);
  wait 5;
  level.ingraceperiod = 0;

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_match_start_countdown", 0);
    var_1 setclientomnvar("ui_match_in_progress", 1);
  }

  if(istrue(level.forfeitinprogress) && !istrue(level.forfeit_aborted)) {
    setomnvar("ui_match_start_text", "opponent_forfeiting_in");
    return;
  }
}

function hostmigrationwaitforplayers() {
  level endon("hostmigration_enoughplayers");
  wait 15;
}

function hostmigrationname(var_0) {
  if(!isDefined(var_0)) {
    return "<removed_ent>";
  }

  var_1 = -1;
  var_2 = "?";

  if(isDefined(var_0.entity_number)) {
    var_1 = var_0.entity_number;
  }

  if(isPlayer(var_0) && isDefined(var_0.name)) {
    var_2 = var_0.name;
  }

  if(isPlayer(var_0)) {
    return ("player <" + var_2 + ">");
  }

  if(isagent(var_0) && scripts\mp\utility\entity::isgameparticipant(var_0)) {
    return ("participant agent <" + var_1 + ">");
  }

  if(isagent(var_0)) {
    return ("non-participant agent <" + var_1 + ">");
  }

  return "unknown entity <" + var_1 + ">";
}

function hostmigrationtimerthink_internal() {
  level endon("host_migration_begin");
  level endon("host_migration_end");

  while(!scripts\mp\utility\player::isreallyalive(self)) {
    self waittill("spawned");
  }

  self.hostmigrationcontrolsfrozen = 1;
  scripts\mp\utility\player::_freezecontrols(1, undefined, "hostMigrationTimer");
  level waittill("host_migration_end");
}

function hostmigrationtimerthink() {
  self endon("disconnect");
  hostmigrationtimerthink_internal();

  if(self.hostmigrationcontrolsfrozen) {
    scripts\mp\utility\player::_freezecontrols(0, undefined, "hostMigrationTimer");
    self.hostmigrationcontrolsfrozen = undefined;
    return;
  }
}

function waittillhostmigrationdone() {
  if(!isDefined(level.hostmigrationtimer)) {
    return 0;
  }

  var_0 = gettime();
  level waittill("host_migration_end");
  return gettime() - var_0;
}

function waittillhostmigrationstarts(var_0) {
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  level endon("host_migration_begin");
  wait var_0;
}

function waitlongdurationwithhostmigrationpause(var_0) {
  if(var_0 == 0) {
    return;
  }

  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;

  while(gettime() < var_2) {
    waittillhostmigrationstarts((var_2 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      var_3 = waittillhostmigrationdone();
      var_2 += var_3;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_1;
}

function waittill_notify_or_timeout_hostmigration_pause(var_0, var_1) {
  self endon(var_0);

  if(var_1 == 0) {
    return;
  }

  var_2 = gettime();
  var_3 = gettime() + var_1 * 1000;

  while(gettime() < var_3) {
    waittillhostmigrationstarts((var_3 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      var_4 = waittillhostmigrationdone();
      var_3 += var_4;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_2;
}

function waitlongdurationwithgameendtimeupdate(var_0) {
  if(var_0 == 0) {
    return;
  }

  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;

  while(gettime() < var_2) {
    waittillhostmigrationstarts((var_2 - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      var_2 += 1000;
      setgameendtime(int(var_2));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    var_2 += 1000;
    setgameendtime(int(var_2));
    wait 1;
  }

  return gettime() - var_1;
}