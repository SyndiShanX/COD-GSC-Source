/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_hostmigration.gsc
***********************************************/

hostmigrationwait() {
  level endon("game_ended");
  level.ingraceperiod = 25;
  thread matchstarttimer("waiting_for_players", 20.0);
  hostmigrationwaitforplayers();
  level.ingraceperiod = 10;
  thread matchstarttimer("match_resuming_in", 5.0);
  wait 5;
  level.ingraceperiod = 0;
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

  while(!scripts\cp_mp\utility\player_utility::_isalive())
    self waittill("spawned");

  self.hostmigrationcontrolsfrozen = 1;
  scripts\cp\utility::freezecontrolswrapper(1);
  level waittill("host_migration_end");
}

hostmigrationtimerthink() {
  self endon("disconnect");
  hostmigrationtimerthink_internal();

  if(self.hostmigrationcontrolsfrozen) {
    if(scripts\cp\utility::gameflag("prematch_done"))
      scripts\cp\utility::freezecontrolswrapper(0);

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

matchstarttimer(type, duration) {
  self notify("matchStartTimer");
  self endon("matchStartTimer");
  level notify("match_start_timer_beginning");
  _id_B710552E5D79A601 = int(duration);

  if(_id_B710552E5D79A601 >= 2) {
    setomnvar("ui_match_start_text", type);
    matchstarttimer_internal(_id_B710552E5D79A601);
    visionsetnaked("", 3.0);
  } else {
    introvisionset();
    visionsetnaked("", 1.0);
  }
}

matchstarttimer_internal(_id_B710552E5D79A601) {
  waittillframeend;
  introvisionset();
  level endon("match_start_timer_beginning");

  while(_id_B710552E5D79A601 > 0 && !level.gameended) {
    foreach(_id_AC0E424AC96A7113 in level.players) {
      _id_AC0E424AC96A7113 setclientomnvar("ui_match_start_countdown", _id_B710552E5D79A601);
      _id_AC0E424AC96A7113 setclientomnvar("ui_match_in_progress", 0);
    }

    if(_id_B710552E5D79A601 == 0)
      visionsetnaked("", 0);

    _id_B710552E5D79A601--;
    wait 1.0;
  }

  foreach(_id_AC0E424AC96A7113 in level.players) {
    _id_AC0E424AC96A7113 setclientomnvar("ui_match_start_countdown", 0);
    _id_AC0E424AC96A7113 setclientomnvar("ui_match_in_progress", 1);
  }
}

introvisionset() {
  if(!isDefined(level.introvisionset))
    level.introvisionset = "mpIntro";

  visionsetnaked(level.introvisionset, 0);
}