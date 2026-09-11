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

  foreach(var1 in level.characters) {
    var1.hostmigrationcontrolsfrozen = 0;
  }

  level.hostmigrationtimer = 1;
  setDvar("ui_inhostmigration", 1);
  level.hostmigration = 1;
  level notify("host_migration_begin");
  scripts\mp\gamelogic::updatetimerpausedness();

  foreach(var1 in level.characters) {
    thread hostmigrationtimerthink();

    if(isPlayer(var1)) {
      var1 setclientomnvar("ui_session_state", var1.sessionstate);

      if(drawentitybounds()) {
        analyticsstreamerislogfilestreamingenabled(var1.guid);
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
  level waittill("connected", var0);
  thread hostmigrationtimerthink();

  if(isPlayer(var0)) {
    var0 setclientomnvar("ui_session_state", var0.sessionstate);
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

  foreach(var1 in level.players) {
    var1 setclientomnvar("ui_match_start_countdown", 0);
    var1 setclientomnvar("ui_match_in_progress", 1);
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

function hostmigrationname(var0) {
  if(!isDefined(var0)) {
    return "<removed_ent>";
  }

  var1 = -1;
  var2 = "?";

  if(isDefined(var0.entity_number)) {
    var1 = var0.entity_number;
  }

  if(isPlayer(var0) && isDefined(var0.name)) {
    var2 = var0.name;
  }

  if(isPlayer(var0)) {
    return ("player <" + var2 + ">");
  }

  if(isagent(var0) && scripts\mp\utility\entity::isgameparticipant(var0)) {
    return ("participant agent <" + var1 + ">");
  }

  if(isagent(var0)) {
    return ("non-participant agent <" + var1 + ">");
  }

  return "unknown entity <" + var1 + ">";
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

  var0 = gettime();
  level waittill("host_migration_end");
  return gettime() - var0;
}

function waittillhostmigrationstarts(var0) {
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  level endon("host_migration_begin");
  wait var0;
}

function waitlongdurationwithhostmigrationpause(var0) {
  if(var0 == 0) {
    return;
  }

  var1 = gettime();
  var2 = gettime() + var0 * 1000;

  while(gettime() < var2) {
    waittillhostmigrationstarts((var2 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      var3 = waittillhostmigrationdone();
      var2 += var3;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var1;
}

function waittill_notify_or_timeout_hostmigration_pause(var0, var1) {
  self endon(var0);

  if(var1 == 0) {
    return;
  }

  var2 = gettime();
  var3 = gettime() + var1 * 1000;

  while(gettime() < var3) {
    waittillhostmigrationstarts((var3 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      var4 = waittillhostmigrationdone();
      var3 += var4;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var2;
}

function waitlongdurationwithgameendtimeupdate(var0) {
  if(var0 == 0) {
    return;
  }

  var1 = gettime();
  var2 = gettime() + var0 * 1000;

  while(gettime() < var2) {
    waittillhostmigrationstarts((var2 - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      var2 += 1000;
      setgameendtime(int(var2));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    var2 += 1000;
    setgameendtime(int(var2));
    wait 1;
  }

  return gettime() - var1;
}