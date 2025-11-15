/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\hostmigration.gsc
*************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\hud_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_utility;

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

  function updatetimerpausedness() {
    shouldbestopped = isDefined(level.hostmigrationtimer);

    if(!level.timerstopped && shouldbestopped) {
      level.timerstopped = 1;
      level.timerpausetime = gettime();
      return;
    }

    if(level.timerstopped && !shouldbestopped) {
      level.timerstopped = 0;
      level.discardtime += gettime() - level.timerpausetime;
    }
  }

callback_hostmigrationsave() {}

callback_prehostmigrationsave() {
  zm_utility::undo_link_changes();

  if(isDefined(level._hm_should_pause_spawning) && level._hm_should_pause_spawning) {
    level flag::set("spawn_zombies");
  }

  for(i = 0; i < level.players.size; i++) {
    level.players[i] val::set(#"host_migration", "takedamage", 0);
    level.players[i] stats::set_stat(#"afteractionreportstats", #"lobbypopup", #"summary");
    clientnum = level.players[i] getentitynumber();
    level.players[i] stats::set_stat(#"afteractionreportstats", #"clientnum", clientnum);
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

callback_hostmigration() {
  zm_utility::redo_link_changes();
  setslowmotion(1, 1, 0);
  level.hostmigrationreturnedplayercount = 0;

  if(level.gameended) {
    println("<dev string:x7b>" + gettime() + "<dev string:x99>");
    return;
  }

  sethostmigrationstatus(1);
  callback::function_daed27e8(#"on_host_migration_begin");
  level notify(#"host_migration_begin");

  for(i = 0; i < level.players.size; i++) {
    if(isDefined(level.hostmigration_link_entity_callback)) {
      if(!isDefined(level.players[i]._host_migration_link_entity)) {
        level.players[i]._host_migration_link_entity = level.players[i][
          [level.hostmigration_link_entity_callback]
        ]();
      }
    }

    level.players[i] thread hostmigrationtimerthink();
  }

  if(isDefined(level.hostmigration_ai_link_entity_callback)) {
    zombies = getaiteamarray(level.zombie_team);

    if(isDefined(zombies) && zombies.size > 0) {
      foreach(zombie in zombies) {
        if(!isDefined(zombie._host_migration_link_entity)) {
          zombie._host_migration_link_entity = zombie[[level.hostmigration_ai_link_entity_callback]]();
        }
      }
    }
  } else {
    zombies = getaiteamarray(level.zombie_team);

    if(isDefined(zombies) && zombies.size > 0) {
      foreach(zombie in zombies) {
        zombie.no_powerups = 1;
        zombie.marked_for_recycle = 1;
        zombie.has_been_damaged_by_player = 0;
        zombie dodamage(zombie.health + 1000, zombie.origin, zombie);
      }
    }
  }

  if(level.inprematchperiod) {
    level waittill(#"prematch_over");
  }

  println("<dev string:x7b>" + gettime());
  level.hostmigrationtimer = 1;
  thread locktimer();

  if(isDefined(level.b_host_migration_force_player_respawn) && level.b_host_migration_force_player_respawn) {
    foreach(player in level.players) {
      if(zm_utility::is_player_valid(player, 0, 0)) {
        player host_migration_respawn();
      }
    }
  }

  zombies = getaiteamarray(level.zombie_team);

  if(isDefined(zombies) && zombies.size > 0) {
    foreach(zombie in zombies) {
      if(isDefined(zombie._host_migration_link_entity)) {
        ent = spawn("script_origin", zombie.origin);
        ent.angles = zombie.angles;
        zombie linkto(ent);
        ent linkto(zombie._host_migration_link_entity, "tag_origin", zombie._host_migration_link_entity worldtolocalcoords(ent.origin), ent.angles + zombie._host_migration_link_entity.angles);
        zombie._host_migration_link_helper = ent;
        zombie linkto(zombie._host_migration_link_helper);
      }
    }
  }

  level endon(#"host_migration_begin");
  should_pause_spawning = level flag::get("spawn_zombies");

  if(should_pause_spawning) {
    level flag::clear("spawn_zombies");
  }

  hostmigrationwait();

  foreach(player in level.players) {
    player thread post_migration_invulnerability();
  }

  function_f7b6fbdb();
  zombies = getaiteamarray(level.zombie_team);

  if(isDefined(zombies) && zombies.size > 0) {
    foreach(zombie in zombies) {
      if(isDefined(zombie._host_migration_link_entity)) {
        zombie unlink();
        zombie._host_migration_link_helper delete();
        zombie._host_migration_link_helper = undefined;
        zombie._host_migration_link_entity = undefined;
      }
    }
  }

  if(should_pause_spawning) {
    level flag::set("spawn_zombies");
  }

  level.hostmigrationtimer = undefined;
  level._hm_should_pause_spawning = undefined;
  sethostmigrationstatus(0);
  println("<dev string:xc2>" + gettime());
  level.host = util::gethostplayer();

  for(i = 0; i < level.players.size; i++) {
    clientnum = level.players[i] getentitynumber();
    level.players[i] stats::set_stat(#"afteractionreportstats", #"clientnum", clientnum);
  }

  callback::function_daed27e8(#"on_host_migration_end");
  level notify(#"host_migration_end");
}

post_migration_become_vulnerable() {
  self endon(#"disconnect");
}

post_migration_invulnerability() {
  self thread val::set_for_time(3, "host_migration", "takedamage", 0);
}

host_migration_respawn() {
  println("<dev string:xe0>");
  new_origin = undefined;

  if(isDefined(level.var_5816975b)) {
    new_origin = [[level.var_5816975b]](self);
  }

  if(!isDefined(new_origin)) {
    new_origin = zm_player::check_for_valid_spawn_near_team(self, 1);
  }

  if(isDefined(new_origin)) {
    if(!isDefined(new_origin.angles)) {
      angles = (0, 0, 0);
    } else {
      angles = new_origin.angles;
    }

    self dontinterpolate();
    self setorigin(new_origin.origin);
    self setplayerangles(angles);
  }

  return true;
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
  var_5654073f = counttime >= 2;

  if(var_5654073f) {
    matchstarttimerconsole_internal(counttime);
  }

  luinotifyevent(#"prematch_timer_ended", 1, var_5654073f);
}

hostmigrationwait() {
  level endon(#"game_ended");

  if(level.hostmigrationreturnedplayercount < level.players.size * 2 / 3) {
    thread matchstarttimerconsole("waiting_for_teams", 20);
    hostmigrationwaitforplayers();
  }

  thread matchstarttimerconsole("match_starting_in", 9);
  wait 1;
}

hostmigrationwaitforplayers() {
  level endon(#"hostmigration_enoughplayers");
  wait 1;
}

hostmigrationtimerthink_internal() {
  level endon(#"host_migration_begin", #"host_migration_end");
  self.hostmigrationcontrolsfrozen = 0;

  while(!isalive(self)) {
    self waittill(#"spawned");
  }

  if(isDefined(self._host_migration_link_entity)) {
    ent = spawn("script_origin", self.origin);
    ent.angles = self.angles;
    self linkto(ent);
    ent linkto(self._host_migration_link_entity, "tag_origin", self._host_migration_link_entity worldtolocalcoords(ent.origin), ent.angles + self._host_migration_link_entity.angles);
    self._host_migration_link_helper = ent;
    println("<dev string:x114>" + self._host_migration_link_entity.targetname);
  }

  self.hostmigrationcontrolsfrozen = 1;
  self val::set(#"host_migration", "freezecontrols");
  self val::set(#"host_migration", "disablegadgets");
  level waittill(#"host_migration_end");
}

hostmigrationtimerthink() {
  self endon(#"disconnect");
  level endon(#"host_migration_begin");
  hostmigrationtimerthink_internal();

  if(self.hostmigrationcontrolsfrozen) {
    self val::reset(#"host_migration", "freezecontrols");
    self val::reset(#"host_migration", "disablegadgets");
    self.hostmigrationcontrolsfrozen = 0;
    println("<dev string:x12d>");
  }

  if(isDefined(self._host_migration_link_entity)) {
    self unlink();
    self._host_migration_link_helper delete();
    self._host_migration_link_helper = undefined;

    if(isDefined(self._host_migration_link_entity._post_host_migration_thread)) {
      self thread[[self._host_migration_link_entity._post_host_migration_thread]](self._host_migration_link_entity);
    }

    self._host_migration_link_entity = undefined;
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
  endtime = gettime() + duration * 1000;

  while(gettime() < endtime) {
    waittillhostmigrationstarts((endtime - gettime()) / 1000);

    if(isDefined(level.hostmigrationtimer)) {
      timepassed = waittillhostmigrationdone();
      endtime += timepassed;
    }
  }

  if(gettime() != endtime) {
    println("<dev string:x151>" + gettime() + "<dev string:x170>" + endtime);
  }

  waittillhostmigrationdone();
  return gettime() - starttime;
}

waitlongdurationwithgameendtimeupdate(duration) {
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

  if(gettime() != endtime) {
    println("<dev string:x151>" + gettime() + "<dev string:x170>" + endtime);
  }

    while(isDefined(level.hostmigrationtimer)) {
      endtime += 1000;
      setgameendtime(int(endtime));
      wait 1;
    }

  return gettime() - starttime;
}

find_alternate_player_place(v_origin, min_radius, max_radius, max_height, ignore_targetted_nodes) {
  found_node = undefined;
  a_nodes = getnodesinradiussorted(v_origin, max_radius, min_radius, max_height, "pathnodes");

  if(isDefined(a_nodes) && a_nodes.size > 0) {
    a_player_volumes = getEntArray("player_volume", "script_noteworthy");
    index = a_nodes.size - 1;

    for(i = index; i >= 0; i--) {
      n_node = a_nodes[i];

      if(ignore_targetted_nodes == 1) {
        if(isDefined(n_node.target)) {
          continue;
        }
      }

      if(!positionwouldtelefrag(n_node.origin)) {
        if(zm_utility::check_point_in_enabled_zone(n_node.origin, 1, a_player_volumes)) {
          v_start = (n_node.origin[0], n_node.origin[1], n_node.origin[2] + 30);
          v_end = (n_node.origin[0], n_node.origin[1], n_node.origin[2] - 30);
          trace = bulletTrace(v_start, v_end, 0, undefined);

          if(trace[#"fraction"] < 1) {
            override_abort = 0;

            if(isDefined(level._whoswho_reject_node_override_func)) {
              override_abort = [
                [level._whoswho_reject_node_override_func]
              ](v_origin, n_node);
            }

            if(!override_abort) {
              found_node = n_node;
              break;
            }
          }
        }
      }
    }
  }

  return found_node;
}

hostmigration_put_player_in_better_place() {
  spawnpoint = undefined;
  spawnpoint = find_alternate_player_place(self.origin, 50, 150, 64, 1);

  if(!isDefined(spawnpoint)) {
    spawnpoint = find_alternate_player_place(self.origin, 150, 400, 64, 1);
  }

  if(!isDefined(spawnpoint)) {
    spawnpoint = find_alternate_player_place(self.origin, 50, 400, 256, 0);
  }

  if(!isDefined(spawnpoint)) {
    spawnpoint = zm_player::check_for_valid_spawn_near_team(self, 1);
  }

  if(!isDefined(spawnpoint)) {
    match_string = "";
    location = level.scr_zm_map_start_location;

    if((location == "default" || location == "") && isDefined(level.default_start_location)) {
      location = level.default_start_location;
    }

    match_string = level.scr_zm_ui_gametype + "_" + location;
    spawnpoints = [];
    structs = struct::get_array("initial_spawn", "script_noteworthy");

    if(isDefined(structs)) {
      foreach(struct in structs) {
        if(isDefined(struct.script_string)) {
          tokens = strtok(struct.script_string, " ");

          foreach(token in tokens) {
            if(token == match_string) {
              spawnpoints[spawnpoints.size] = struct;
            }
          }
        }
      }
    }

    if(!isDefined(spawnpoints) || spawnpoints.size == 0) {
      spawnpoints = struct::get_array("initial_spawn_points", "targetname");
    }

    assert(isDefined(spawnpoints), "<dev string:x18b>");
    spawnpoint = zm_player::getfreespawnpoint(spawnpoints, self);
  }

  if(isDefined(spawnpoint)) {
    self setorigin(spawnpoint.origin);
  }
}