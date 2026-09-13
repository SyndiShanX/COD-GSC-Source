/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\hostmigration.gsc
***********************************************/

callback_hostmigration() {
  level.hostmigrationreturnedplayercount = 0;

  if(level.gameended) {
    return;
  }
  if(analyticsstreamerislogfilestreamingenabled())
    analyticsstreamerlogfilestartstream();

  level thread hostmigrationconnectwatcher();

  foreach(_id_7DC3241E7F3C6B24 in level.characters)
  _id_7DC3241E7F3C6B24.hostmigrationcontrolsfrozen = 0;

  level.hostmigrationtimer = 1;
  setDvar("ui_inhostmigration", 1);
  level.hostmigration = 1;
  level notify("host_migration_begin");
  scripts\mp\gamelogic::updatetimerpausedness();

  foreach(_id_7DC3241E7F3C6B24 in level.characters) {
    if(!isDefined(_id_7DC3241E7F3C6B24)) {
      continue;
    }
    _id_7DC3241E7F3C6B24 thread hostmigrationtimerthink();

    if(isPlayer(_id_7DC3241E7F3C6B24))
      _id_7DC3241E7F3C6B24 setclientomnvar("ui_session_state", _id_7DC3241E7F3C6B24.sessionstate);
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

hostmigrationconnectwatcher() {
  level endon("host_migration_end");
  level endon("host_migration_begin");
  level waittill("connected", player);
  player thread hostmigrationtimerthink();

  if(isPlayer(player))
    player setclientomnvar("ui_session_state", player.sessionstate);
}

hostmigrationwait() {
  level endon("game_ended");
  level.ingraceperiod = 25;
  thread scripts\mp\gamelogic::matchstarttimer("waiting_for_players", 20.0);
  hostmigrationwaitforplayers();
  level.ingraceperiod = 10;
  thread scripts\mp\gamelogic::matchstarttimer("match_resuming_in", 5.0);
  wait 5;
  level.ingraceperiod = 0;

  foreach(_id_AC0E424AC96A7113 in level.players) {
    _id_AC0E424AC96A7113 setclientomnvar("ui_match_start_countdown", 0);
    _id_AC0E424AC96A7113 setclientomnvar("ui_match_in_progress", 1);
  }

  if(istrue(level.forfeitinprogress) && !istrue(level.forfeit_aborted))
    setomnvar("ui_match_start_text", "opponent_forfeiting_in");
}

hostmigrationwaitforplayers() {
  level endon("hostmigration_enoughplayers");
  wait 15;
}

hostmigrationname(ent) {
  if(!isDefined(ent))
    return "<removed_ent>";

  entnum = -1;
  _id_6C77123D46F26285 = "?";

  if(isDefined(ent.entity_number))
    entnum = ent.entity_number;

  if(isPlayer(ent) && isDefined(ent.name))
    _id_6C77123D46F26285 = ent.name;

  if(isPlayer(ent))
    return "player <" + _id_6C77123D46F26285 + ">";

  if(isagent(ent) && scripts\cp_mp\utility\game_utility::isgameparticipant(ent))
    return "participant agent <" + entnum + ">";

  if(isagent(ent))
    return "non-participant agent <" + entnum + ">";

  return "unknown entity <" + entnum + ">";
}

hostmigrationtimerthink_internal() {
  level endon("host_migration_begin");
  level endon("host_migration_end");

  while(!scripts\mp\utility\player::isreallyalive(self))
    self waittill("spawned");

  self.hostmigrationcontrolsfrozen = 1;
  scripts\mp\utility\player::_freezecontrols(1, undefined, "hostMigrationTimer");
  level waittill("host_migration_end");
}

hostmigrationtimerthink() {
  self endon("disconnect");
  hostmigrationtimerthink_internal();

  if(self.hostmigrationcontrolsfrozen) {
    scripts\mp\utility\player::_freezecontrols(0, undefined, "hostMigrationTimer");
    self.hostmigrationcontrolsfrozen = undefined;
  }
}

waittillhostmigrationdone() {
  if(!isDefined(level.hostmigrationtimer))
    return 0;

  starttime = gettime();
  level waittill("host_migration_end");
  return gettime() - starttime;
}

waittillhostmigrationstarts(duration) {
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  level endon("host_migration_begin");
  wait(duration);
}

waitlongdurationwithhostmigrationpause(duration) {
  if(!isDefined(duration) || duration == 0) {
    return;
  }
  starttime = gettime();
  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    waittillhostmigrationstarts((endtime - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      _id_3B5803E733581858 = waittillhostmigrationdone();
      endtime = endtime + _id_3B5803E733581858;
    }
  }

  waittillhostmigrationdone();
  return gettime() - starttime;
}

waittill_notify_or_timeout_hostmigration_pause(msg, duration) {
  self endon(msg);

  if(duration == 0) {
    return;
  }
  starttime = gettime();
  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    waittillhostmigrationstarts((endtime - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      _id_3B5803E733581858 = waittillhostmigrationdone();
      endtime = endtime + _id_3B5803E733581858;
    }
  }

  waittillhostmigrationdone();
  return gettime() - starttime;
}

waitlongdurationwithgameendtimeupdate(duration) {
  if(duration == 0) {
    return;
  }
  starttime = gettime();
  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    waittillhostmigrationstarts((endtime - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      endtime = endtime + 1000;
      setgameendtime(int(endtime));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    endtime = endtime + 1000;
    setgameendtime(int(endtime));
    wait 1;
  }

  return gettime() - starttime;
}