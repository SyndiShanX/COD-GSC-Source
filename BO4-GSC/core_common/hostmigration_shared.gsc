/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\hostmigration_shared.gsc
************************************************/

#include scripts\core_common\potm_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;

#namespace hostmigration;

debug_script_structs() {
  if(isDefined(level.struct)) {
    println("<dev string:x38>" + level.struct.size);
    println("<dev string:x4b>");

    for(i = 0; i < level.struct.size; i++) {
      struct = level.struct[i];

      if(isDefined(struct.targetname)) {
        println("<dev string:x4e>" + i + "<dev string:x54>" + struct.targetname);
        continue;
      }

      println("<dev string:x4e>" + i + "<dev string:x54>" + "<dev string:x5a>");
    }

    return;
  }

  println("<dev string:x61>");
}

updatetimerpausedness() {
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

pausetimer() {
  level.migrationtimerpausetime = gettime();
}

resumetimer() {
  level.discardtime += gettime() - level.migrationtimerpausetime;
}

locktimer() {
  level endon(#"host_migration_begin", #"host_migration_end");

  for(;;) {
    currtime = gettime();
    waitframe(1);

    if(!level.timerstopped && isDefined(level.discardtime)) {
      level.discardtime += gettime() - currtime;
    }
  }
}

matchstarttimerconsole_internal(counttime) {
  waittillframeend();
  level endon(#"match_start_timer_beginning");
  luinotifyevent(#"create_prematch_timer", 2, gettime() + int(counttime * 1000), 1);
  wait counttime;
}

matchstarttimerconsole(type, duration) {
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

hostmigrationwait() {
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

waittillhostmigrationcountdown() {
  level endon(#"host_migration_end");

  if(!isDefined(level.hostmigrationtimer)) {
    return;
  }

  level waittill(#"host_migration_countdown_begin");
}

hostmigrationwaitforplayers() {
  level endon(#"hostmigration_enoughplayers");
  wait 15;
}

hostmigrationtimerthink_internal() {
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

hostmigrationtimerthink() {
  self endon(#"disconnect");
  level endon(#"host_migration_begin");
  hostmigrationtimerthink_internal();

  if(self.hostmigrationcontrolsfrozen) {
    val::reset(#"hostmigration", "freezecontrols");
    val::reset(#"hostmigration", "disablegadgets");
  }
}

waittillhostmigrationdone() {
  if(!isDefined(level.hostmigrationtimer)) {
    return 0;
  }

  starttime = gettime();
  level waittill(#"host_migration_end");
  return gettime() - starttime;
}

waittillhostmigrationstarts(duration) {
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }

  level endon(#"host_migration_begin");
  wait duration;
}

waitlongdurationwithhostmigrationpause(duration) {
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
    println("<dev string:x7b>" + gettime() + "<dev string:x9a>" + endtime);
  }

  waittillhostmigrationdone();
  return gettime() - starttime;
}

waitlongdurationwithhostmigrationpauseemp(duration) {
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
    println("<dev string:x7b>" + gettime() + "<dev string:xb5>" + empendtime);
  }

  waittillhostmigrationdone();
  level.empendtime = undefined;
  return gettime() - starttime;
}

waitlongdurationwithgameendtimeupdate(duration) {
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
    println("<dev string:x7b>" + gettime() + "<dev string:x9a>" + endtime);
  }

  while(isDefined(level.hostmigrationtimer)) {
    endtime += 1000;
    setgameendtime(int(endtime));
    wait 1;
  }

  return gettime() - starttime;
}

migrationawarewait(durationms) {
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