/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\hostmigration.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\player;
#namespace hostmigration;

function callback_hostmigration() {
  level.hostmigrationreturnedplayercount = 0;

  if(level.gameended) {
    println("<dev string:x1c>" + gettime() + "<dev string:x3b>");
    return;
  }

  if(analyticsstreamerislogfilestreamingenabled()) {
    analyticsstreamerlogfilestartstream();
  }

  println("<dev string:x1c>" + gettime());
  level thread hostmigrationconnectwatcher();

  foreach(character in level.characters) {
    character.hostmigrationcontrolsfrozen = 0;
  }

  level.hostmigrationtimer = 1;
  setDvar(@ "hash_a8ee1540ced18a88", 1);
  level.hostmigration = 1;
  level notify("host_migration_begin");
  scripts\mp\gamelogic::updatetimerpausedness();

  foreach(character in level.characters) {
    if(!isDefined(character)) {
      continue;
    }

    character thread hostmigrationtimerthink();

    if(isPlayer(character)) {
      character setclientomnvar("ui_session_state", character.sessionstate);
    }
  }

  level endon("host_migration_begin");
  hostmigrationwait();
  level.hostmigrationtimer = undefined;
  setDvar(@ "hash_a8ee1540ced18a88", 0);
  println("<dev string:x65>" + gettime());
  visionsetthermal(game["thermal_vision"]);
  level.hostmigration = 0;
  level notify("host_migration_end");
  scripts\mp\gamelogic::updatetimerpausedness();
  level thread[[level.updategameevents]]();
}

function hostmigrationconnectwatcher() {
  level endon("host_migration_end");
  level endon("host_migration_begin");
  level waittill("connected", player);
  player thread hostmigrationtimerthink();

  if(isPlayer(player)) {
    player setclientomnvar("ui_session_state", player.sessionstate);
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

  foreach(p in level.players) {
    p setclientomnvar("ui_match_start_countdown", 0);
    p setclientomnvar("ui_match_in_progress", 1);
  }

  if(istrue(level.forfeitinprogress) && !istrue(level.forfeit_aborted)) {
    setomnvar("ui_match_start_text", "opponent_forfeiting_in");
  }
}

function hostmigrationwaitforplayers() {
  level endon("hostmigration_enoughplayers");
  wait 15;
}

function hostmigrationname(ent) {
  if(!isDefined(ent)) {
    return "<removed_ent>";
  }

  entnum = -1;
  entname = "?";

  if(isDefined(ent.entity_number)) {
    entnum = ent.entity_number;
  }

  if(isPlayer(ent) && isDefined(ent.name)) {
    entname = ent.name;
  }

  if(isPlayer(ent)) {
    return ("player <" + entname + ">");
  }

  if(isagent(ent) && scripts\cp_mp\utility\game_utility::isgameparticipant(ent)) {
    return ("participant agent <" + entnum + ">");
  }

  if(isagent(ent)) {
    return ("non-participant agent <" + entnum + ">");
  }

  return "unknown entity <" + entnum + ">";
}

function hostmigrationtimerthink_internal() {
  level endon("host_migration_begin");
  level endon("host_migration_end");
  assertex(isDefined(self.hostmigrationcontrolsfrozen), "<dev string:x84>" + hostmigrationname(self));

  while(!isreallyalive(self)) {
    self waittill("spawned");
  }

  println("<dev string:xb4>" + hostmigrationname(self) + "<dev string:xd8>" + self.hostmigrationcontrolsfrozen);
  self.hostmigrationcontrolsfrozen = 1;
  _freezecontrols(1, undefined, "hostMigrationTimer");
  level waittill("host_migration_end");
}

function hostmigrationtimerthink() {
  self endon("disconnect");
  assertex(isDefined(self.hostmigrationcontrolsfrozen), "<dev string:x84>" + hostmigrationname(self));
  hostmigrationtimerthink_internal();
  assertex(isDefined(self.hostmigrationcontrolsfrozen), "<dev string:x100>" + hostmigrationname(self));
  println("<dev string:x127>" + hostmigrationname(self) + "<dev string:xd8>" + self.hostmigrationcontrolsfrozen);

  if(self.hostmigrationcontrolsfrozen) {
    _freezecontrols(0, undefined, "hostMigrationTimer");
    self.hostmigrationcontrolsfrozen = undefined;
  }
}

function waittillhostmigrationdone() {
  if(!isDefined(level.hostmigrationtimer)) {
    return 0;
  }

  starttime = gettime();
  level waittill("host_migration_end");
  return gettime() - starttime;
}

function waittillhostmigrationstarts(duration) {
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  level endon("host_migration_begin");
  wait duration;
}

function waitlongdurationwithhostmigrationpause(duration) {
  if(!isDefined(duration) || duration == 0) {
    return;
  }

  assert(duration > 0);
  starttime = gettime();
  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    waittillhostmigrationstarts((endtime - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      timepassed = waittillhostmigrationdone();
      endtime += timepassed;
    }
  }

  waittillhostmigrationdone();
  return gettime() - starttime;
}

function waittill_notify_or_timeout_hostmigration_pause(msg, duration) {
  self endon(msg);

  if(duration == 0) {
    return;
  }

  assert(duration > 0);
  starttime = gettime();
  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    waittillhostmigrationstarts((endtime - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      timepassed = waittillhostmigrationdone();
      endtime += timepassed;
    }
  }

  waittillhostmigrationdone();
  return gettime() - starttime;
}

function waitlongdurationwithgameendtimeupdate(duration) {
  if(duration == 0) {
    return;
  }

  assert(duration > 0);
  starttime = gettime();
  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    waittillhostmigrationstarts((endtime - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      endtime += 1000;
      setgameendtime(int(endtime));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    endtime += 1000;
    setgameendtime(int(endtime));
    wait 1;
  }

  return gettime() - starttime;
}