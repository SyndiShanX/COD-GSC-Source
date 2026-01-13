/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2750.gsc
***************************************/

callback_hostmigration() {
  level.hostmigrationreturnedplayercount = 0;

  if(level.gameended) {
    return;
  }
  level thread hostmigrationconnectwatcher();

  foreach(var_1 in level.characters) {
    var_1.hostmigrationcontrolsfrozen = 0;
  }

  level.hostmigrationtimer = 1;
  setdvar("ui_inhostmigration", 1);
  level.hostmigration = 1;
  level notify("host_migration_begin");
  scripts\mp\gamelogic::func_12F45();

  foreach(var_1 in level.characters) {
    if(!isDefined(var_1)) {
      continue;
    }
    var_1 thread hostmigrationtimerthink();

    if(isplayer(var_1)) {
      var_1 setclientomnvar("ui_session_state", var_1.sessionstate);
    }
  }

  level endon("host_migration_begin");
  hostmigrationwait();
  level.hostmigrationtimer = undefined;
  setdvar("ui_inhostmigration", 0);
  visionsetthermal(game["thermal_vision"]);
  level.hostmigration = 0;
  level notify("host_migration_end");
  scripts\mp\gamelogic::func_12F45();
  level thread scripts\mp\gamelogic::updategameevents();
  setdvar("match_running", 1);
}

hostmigrationconnectwatcher() {
  level endon("host_migration_end");
  level endon("host_migration_begin");
  level waittill("connected", var_0);
  var_0 thread hostmigrationtimerthink();

  if(isplayer(var_0)) {
    var_0 setclientomnvar("ui_session_state", var_0.sessionstate);
  }
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

  if(scripts\mp\utility\game::istrue(level.var_72F2) && !scripts\mp\utility\game::istrue(level.var_72F1)) {
    setomnvar("ui_match_start_text", "opponent_forfeiting_in");
  }
}

hostmigrationwaitforplayers() {
  level endon("hostmigration_enoughplayers");
  wait 15;
}

hostmigrationname(var_0) {
  if(!isDefined(var_0)) {
    return "<removed_ent>";
  }

  var_1 = -1;
  var_2 = "?";

  if(isDefined(var_0.entity_number)) {
    var_1 = var_0.entity_number;
  }

  if(isplayer(var_0) && isDefined(var_0.name)) {
    var_2 = var_0.name;
  }

  if(isplayer(var_0)) {
    return "player <" + var_2 + ">";
  }

  if(isagent(var_0) && scripts\mp\utility\game::isgameparticipant(var_0)) {
    return "participant agent <" + var_1 + ">";
  }

  if(isagent(var_0)) {
    return "non-participant agent <" + var_1 + ">";
  }

  return "unknown entity <" + var_1 + ">";
}

hostmigrationtimerthink_internal() {
  level endon("host_migration_begin");
  level endon("host_migration_end");

  while(!scripts\mp\utility\game::isreallyalive(self)) {
    self waittill("spawned");
  }

  self.hostmigrationcontrolsfrozen = 1;
  scripts\mp\utility\game::freezecontrolswrapper(1);
  level waittill("host_migration_end");
}

hostmigrationtimerthink() {
  self endon("disconnect");
  hostmigrationtimerthink_internal();

  if(self.hostmigrationcontrolsfrozen) {
    scripts\mp\utility\game::freezecontrolswrapper(0);
    self.hostmigrationcontrolsfrozen = undefined;
  }
}

waittillhostmigrationdone() {
  if(!isDefined(level.hostmigrationtimer)) {
    return 0;
  }

  var_0 = gettime();
  level waittill("host_migration_end");
  return gettime() - var_0;
}

waittillhostmigrationstarts(var_0) {
  if(isDefined(level.hostmigrationtimer)) {
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

  while(gettime() < var_2) {
    waittillhostmigrationstarts((var_2 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
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

  while(gettime() < var_3) {
    waittillhostmigrationstarts((var_3 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
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

  while(gettime() < var_2) {
    waittillhostmigrationstarts((var_2 - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      var_2 = var_2 + 1000;
      setgameendtime(int(var_2));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    var_2 = var_2 + 1000;
    setgameendtime(int(var_2));
    wait 1;
  }

  return gettime() - var_1;
}