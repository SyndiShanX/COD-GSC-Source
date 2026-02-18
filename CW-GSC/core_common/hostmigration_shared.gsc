/************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\hostmigration_shared.gsc
************************************************/

#using scripts\core_common\potm_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#namespace hostmigration;

function updatetimerpausedness() {
  shouldbestopped = isDefined(level.hostmigrationtimer);

  if(!level.timerstopped && shouldbestopped) {
    level.timerstopped = 1;
    level.playabletimerstopped = 1;
    level.timerpausetime = gettime();
    return;
  }

  if(level.timerstopped && !shouldbestopped) {
    level.timerstopped = 0;
    level.playabletimerstopped = 0;
    level.discardtime += gettime() - level.timerpausetime;
  }
}

function pausetimer() {
  level.migrationtimerpausetime = gettime();
}

function resumetimer() {
  level.discardtime += gettime() - level.migrationtimerpausetime;
}

function locktimer() {
  level endon(#"host_migration_begin", #"host_migration_end");

  for(;;) {
    currtime = gettime();
    waitframe(1);

    if(!level.timerstopped && isDefined(level.discardtime)) {
      level.discardtime += gettime() - currtime;
    }
  }
}

function matchstarttimerconsole_internal(counttime) {
  waittillframeend();
  level endon(#"match_start_timer_beginning");
  luinotifyevent(#"create_prematch_timer", 2, gettime() + int(counttime * 1000), 1);
  wait counttime;
}

function matchstarttimerconsole(type, duration) {
  level notify(#"match_start_timer_beginning");
  waitframe(1);
  counttime = int(duration);

  if(isDefined(level.host_migration_activate_visionset_func)) {
    level thread[[level.host_migration_activate_visionset_func]]();
  }

  var_5654073f = counttime >= 2;

  if(var_5654073f) {
    matchstarttimerconsole_internal(counttime);
  }

  if(isDefined(level.host_migration_deactivate_visionset_func)) {
    level thread[[level.host_migration_deactivate_visionset_func]]();
  }

  luinotifyevent(#"prematch_timer_ended", 1, var_5654073f);
}

function hostmigrationwait() {
  level endon(#"game_ended");

  if(level.hostmigrationreturnedplayercount < level.players.size * 2 / 3) {
    thread matchstarttimerconsole("waiting_for_teams", 20);
    hostmigrationwaitforplayers();
  }

  potm::forceinit();
  level notify(#"host_migration_countdown_begin");
  thread matchstarttimerconsole("match_starting_in", 5);
  wait 5;
}

function waittillhostmigrationcountdown() {
  level endon(#"host_migration_end");

  if(!isDefined(level.hostmigrationtimer)) {
    return;
  }

  level waittill(#"host_migration_countdown_begin");
}

function hostmigrationwaitforplayers() {
  level endon(#"hostmigration_enoughplayers");
  wait 15;
}

function hostmigrationtimerthink_internal() {
  level endon(#"host_migration_begin", #"host_migration_end");
  self.hostmigrationcontrolsfrozen = 0;

  while(!isalive(self)) {
    self waittill(#"spawned");
  }

  self.hostmigrationcontrolsfrozen = 1;
  val::set(#"hostmigration", "freezecontrols", 1);
  val::set(#"hostmigration", "disablegadgets", 1);
  level waittill(#"host_migration_end");
}

function hostmigrationtimerthink() {
  self endon(#"disconnect");
  level endon(#"host_migration_begin");
  hostmigrationtimerthink_internal();

  if(self.hostmigrationcontrolsfrozen) {
    val::reset(#"hostmigration", "freezecontrols");
    val::reset(#"hostmigration", "disablegadgets");
  }
}

function waittillhostmigrationdone() {
  if(!isDefined(level.hostmigrationtimer)) {
    return 0;
  }

  starttime = gettime();
  level waittill(#"host_migration_end");
  return gettime() - starttime;
}

function waittillhostmigrationstarts(duration) {
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  level endon(#"host_migration_begin");
  wait duration;
}

function waitlongdurationwithhostmigrationpause(duration) {
  if(duration == 0) {
    return;
  }

  assert(duration > 0);
  starttime = gettime();
  endtime = gettime() + int(duration * 1000);

  while(gettime() < endtime) {
    waittillhostmigrationstarts(float(endtime - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      timepassed = waittillhostmigrationdone();
      endtime += timepassed;
    }
  }

  if(gettime() != endtime) {
    println("<dev string:x38>" + gettime() + "<dev string:x58>" + endtime);
  }

  waittillhostmigrationdone();
  return gettime() - starttime;
}

function waitlongdurationwithhostmigrationpauseemp(duration) {
  if(duration == 0) {
    return;
  }

  assert(duration > 0);
  starttime = gettime();
  empendtime = gettime() + int(duration * 1000);
  level.empendtime = empendtime;

  while(gettime() < empendtime) {
    waittillhostmigrationstarts(float(empendtime - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      timepassed = waittillhostmigrationdone();

      if(isDefined(empendtime)) {
        empendtime += timepassed;
      }
    }
  }

  if(gettime() != empendtime) {
    println("<dev string:x38>" + gettime() + "<dev string:x74>" + empendtime);
  }

  waittillhostmigrationdone();
  level.empendtime = undefined;
  return gettime() - starttime;
}

function waitlongdurationwithgameendtimeupdate(duration) {
  if(duration == 0) {
    return;
  }

  assert(duration > 0);
  starttime = gettime();
  endtime = gettime() + int(duration * 1000);

  while(gettime() < endtime) {
    waittillhostmigrationstarts(float(endtime - gettime()) / 1000);

    while(isDefined(level.hostmigrationtimer)) {
      endtime += 1000;
      setgameendtime(int(endtime));
      wait 1;
    }
  }

  if(gettime() != endtime) {
    println("<dev string:x38>" + gettime() + "<dev string:x58>" + endtime);
  }

  while(isDefined(level.hostmigrationtimer)) {
    endtime += 1000;
    setgameendtime(int(endtime));
    wait 1;
  }

  return gettime() - starttime;
}

function migrationawarewait(durationms) {
  waittillhostmigrationdone();
  endtime = gettime() + durationms;
  timeremaining = durationms;

  while(true) {
    event = level util::waittill_level_any_timeout(float(timeremaining) / 1000, self, "game_ended", "host_migration_begin");

    if(event != "host_migration_begin") {
      return;
    }

    timeremaining = endtime - gettime();

    if(timeremaining <= 0) {
      return;
    }

    endtime = gettime() + durationms;
    waittillhostmigrationdone();
  }
}

function function_8d332f88(durationms) {
  waittillhostmigrationdone();
  endtime = gettime() + durationms;
  timeremaining = durationms;

  while(true) {
    if(is_true(level.var_e80a117f)) {
      waitframe(1);
      continue;
    }

    event = level util::waittill_level_any_timeout(float(timeremaining) / 1000, self, "game_ended", "host_migration_begin", "esports_game_paused");

    if(event != "host_migration_begin" && event != "esports_game_paused") {
      return;
    }

    timeremaining = endtime - gettime();

    if(timeremaining <= 0) {
      return;
    }

    if(event == "host_migration_begin") {
      endtime = gettime() + durationms;
      waittillhostmigrationdone();
    }
  }
}