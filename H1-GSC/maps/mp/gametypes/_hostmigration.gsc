/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_hostmigration.gsc
************************************************/

callback_hostmigration() {
  level.hostmigrationreturnedplayercount = 0;

  if(level.gameended) {
    return;
  }
  var_0 = getmatchdata("hostMigrationCount");
  var_0++;
  setmatchdata("hostMigrationCount", var_0);

  foreach(var_2 in level.characters)
  var_2.hostmigrationcontrolsfrozen = 0;

  level.hostmigrationtimer = 1;
  setdvar("ui_inhostmigration", 1);
  level notify("host_migration_begin");
  maps\mp\gametypes\_gamelogic::updatetimerpausedness();

  foreach(var_2 in level.characters) {
    var_2 thread hostmigrationtimerthink();

    if(isplayer(var_2))
      var_2 setclientomnvar("ui_session_state", var_2.sessionstate);
  }

  setdvar("ui_game_state", game["state"]);
  level endon("host_migration_begin");
  hostmigrationwait();
  level.hostmigrationtimer = undefined;
  setdvar("ui_inhostmigration", 0);
  level notify("host_migration_end");
  maps\mp\gametypes\_gamelogic::updatetimerpausedness();
  level thread maps\mp\gametypes\_gamelogic::updategameevents();
}

hostmigrationwait() {
  level endon("game_ended");
  level.ingraceperiod = 25;
  thread maps\mp\gametypes\_gamelogic::matchstarttimer(20.0);
  hostmigrationwaitforplayers();
  level.ingraceperiod = 10;
  thread maps\mp\gametypes\_gamelogic::matchstarttimer(5.0);
  wait 5;
  level.ingraceperiod = 0;
}

hostmigrationwaitforplayers() {
  level endon("hostmigration_enoughplayers");
  wait 15;
}

hostmigrationname(var_0) {
  if(!isdefined(var_0))
    return "<removed_ent>";

  var_1 = -1;
  var_2 = "?";

  if(isdefined(var_0.entity_number))
    var_1 = var_0.entity_number;

  if(isplayer(var_0) && isdefined(var_0.name))
    var_2 = var_0.name;

  if(isplayer(var_0))
    return "player <" + var_2 + "> (entNum " + var_1 + ")";

  if(isagent(var_0) && maps\mp\_utility::isgameparticipant(var_0))
    return "participant agent <" + var_1 + ">";

  if(isagent(var_0))
    return "non-participant agent <" + var_1 + ">";

  return "unknown entity <" + var_1 + ">";
}

hostmigrationtimerthink_internal() {
  level endon("host_migration_begin");
  level endon("host_migration_end");
  self endon("disconnect");
  self.hostmigrationcontrolsfrozen = 1;

  while (!maps\mp\_utility::isreallyalive(self))
    self waittill("spawned");

  maps\mp\_utility::freezecontrolswrapper(1);
  self disableammogeneration();
  level waittill("host_migration_end");
}

hostmigrationtimerthink() {
  level endon("host_migration_begin");
  self endon("disconnect");

  if(isagent(self))
    self endon("death");

  hostmigrationtimerthink_internal();

  if(self.hostmigrationcontrolsfrozen) {
    if(maps\mp\_utility::gameflag("prematch_done")) {
      maps\mp\_utility::freezecontrolswrapper(0);
      self enableammogeneration();
    }

    self.hostmigrationcontrolsfrozen = undefined;
  }
}

waittillhostmigrationdone() {
  if(!isdefined(level.hostmigrationtimer))
    return 0;

  var_0 = gettime();
  level waittill("host_migration_end");
  return gettime() - var_0;
}

waittillhostmigrationstarts(var_0) {
  if(isdefined(level.hostmigrationtimer)) {
    return;
  }
  level endon("host_migration_begin");
  wait(var_0);
}

waitlongdurationwithhostmigrationpause(var_0) {
  if(var_0 == 0) {
    return;
  }
  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;

  while (gettime() < var_2) {
    waittillhostmigrationstarts((var_2 - gettime()) / 1000);

    if(isdefined(level.hostmigrationtimer)) {
      var_3 = waittillhostmigrationdone();
      var_2 = var_2 + var_3;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_1;
}

waittill_notify_or_timeout_hostmigration_pause(var_0, var_1) {
  self endon(var_0);

  if(var_1 == 0) {
    return;
  }
  var_2 = gettime();
  var_3 = gettime() + var_1 * 1000;

  while (gettime() < var_3) {
    waittillhostmigrationstarts((var_3 - gettime()) / 1000);

    if(isdefined(level.hostmigrationtimer)) {
      var_4 = waittillhostmigrationdone();
      var_3 = var_3 + var_4;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_2;
}

waitlongdurationwithgameendtimeupdate(var_0) {
  if(var_0 == 0) {
    return;
  }
  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;

  while (gettime() < var_2) {
    waittillhostmigrationstarts((var_2 - gettime()) / 1000);

    while (isdefined(level.hostmigrationtimer)) {
      var_2 = var_2 + 1000;
      setgameendtime(int(var_2));
      wait 1;
    }
  }

  while (isdefined(level.hostmigrationtimer)) {
    var_2 = var_2 + 1000;
    setgameendtime(int(var_2));
    wait 1;
  }

  return gettime() - var_1;
}