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

  foreach(var_01 in level.characters)
  var_1.hostmigrationcontrolsfrozen = 0;

  level.hostmigrationtimer = 1;
  setdvar("ui_inhostmigration", 1);
  level.hostmigration = 1;
  level notify("host_migration_begin");
  scripts\mp\gamelogic::func_12F45();

  foreach(var_01 in level.characters) {
    if(!isDefined(var_01)) {
      continue;
    }
    var_01 thread hostmigrationtimerthink();

    if(isplayer(var_01))
      var_01 setclientomnvar("ui_session_state", var_1.sessionstate);
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
  level waittill("connected", var_00);
  var_00 thread hostmigrationtimerthink();

  if(isplayer(var_00))
    var_00 setclientomnvar("ui_session_state", var_0.sessionstate);
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

  if(scripts\mp\utility\game::istrue(level.func_72F2) && !scripts\mp\utility\game::istrue(level.func_72F1))
    setomnvar("ui_match_start_text", "opponent_forfeiting_in");
}

hostmigrationwaitforplayers() {
  level endon("hostmigration_enoughplayers");
  wait 15;
}

hostmigrationname(var_00) {
  if(!isDefined(var_00))
    return "<removed_ent>";

  var_01 = -1;
  var_02 = "?";

  if(isDefined(var_0.entity_number))
    var_01 = var_0.entity_number;

  if(isplayer(var_00) && isDefined(var_0.name))
    var_02 = var_0.name;

  if(isplayer(var_00))
    return "player <" + var_02 + ">";

  if(isagent(var_00) && scripts\mp\utility\game::isgameparticipant(var_00))
    return "participant agent <" + var_01 + ">";

  if(isagent(var_00))
    return "non-participant agent <" + var_01 + ">";

  return "unknown entity <" + var_01 + ">";
}

hostmigrationtimerthink_internal() {
  level endon("host_migration_begin");
  level endon("host_migration_end");

  while(!scripts\mp\utility\game::isreallyalive(self))
    self waittill("spawned");

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
  if(!isDefined(level.hostmigrationtimer))
    return 0;

  var_00 = gettime();
  level waittill("host_migration_end");
  return gettime() - var_00;
}

waittillhostmigrationstarts(var_00) {
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  level endon("host_migration_begin");
  wait(var_00);
}

waitlongdurationwithhostmigrationpause(var_00) {
  if(var_00 == 0) {
    return;
  }
  var_01 = gettime();
  var_02 = gettime() + var_00 * 1000;

  while(gettime() < var_02) {
    waittillhostmigrationstarts((var_02 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      var_03 = waittillhostmigrationdone();
      var_02 = var_02 + var_03;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_01;
}

waittill_notify_or_timeout_hostmigration_pause(var_00, var_01) {
  self endon(var_00);

  if(var_01 == 0) {
    return;
  }
  var_02 = gettime();
  var_03 = gettime() + var_01 * 1000;

  while(gettime() < var_03) {
    waittillhostmigrationstarts((var_03 - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      var_04 = waittillhostmigrationdone();
      var_03 = var_03 + var_04;
    }
  }

  waittillhostmigrationdone();
  return gettime() - var_02;
}

waitlongdurationwithgameendtimeupdate(var_00) {
  if(var_00 == 0) {
    return;
  }
  var_01 = gettime();
  var_02 = gettime() + var_00 * 1000;

  while(gettime() < var_02) {
    waittillhostmigrationstarts((var_02 - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      var_02 = var_02 + 1000;
      setgameendtime(int(var_02));
      wait 1;
    }
  }

  while(isDefined(level.hostmigrationtimer)) {
    var_02 = var_02 + 1000;
    setgameendtime(int(var_02));
    wait 1;
  }

  return gettime() - var_01;
}