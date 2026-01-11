/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\gametypes\_hostmigration.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\hud_util_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#namespace hostmigration;

function debug_script_structs() {
  if(isDefined(level.struct)) {
    println("" + level.struct.size);
    println("");
    for(i = 0; i < level.struct.size; i++) {
      struct = level.struct[i];
      if(isDefined(struct.targetname)) {
        println((("" + i) + "") + struct.targetname);
        continue;
      }
      println((("" + i) + "") + "");
    }
  } else {
    println("");
  }
}

function updatetimerpausedness() {
  shouldbestopped = isDefined(level.hostmigrationtimer);
  if(!level.timerstopped && shouldbestopped) {
    level.timerstopped = 1;
    level.timerpausetime = gettime();
  } else if(level.timerstopped && !shouldbestopped) {
    level.timerstopped = 0;
    level.discardtime = level.discardtime + (gettime() - level.timerpausetime);
  }
}

function callback_hostmigrationsave() {}

function callback_prehostmigrationsave() {
  zm_utility::undo_link_changes();
  if(isDefined(level._hm_should_pause_spawning) && level._hm_should_pause_spawning) {
    level flag::set("spawn_zombies");
  }
  for(i = 0; i < level.players.size; i++) {
    level.players[i] enableinvulnerability();
    level.players[i] setdstat("AfterActionReportStats", "lobbyPopup", "summary");
  }
}

function pausetimer() {
  level.migrationtimerpausetime = gettime();
}

function resumetimer() {
  level.discardtime = level.discardtime + (gettime() - level.migrationtimerpausetime);
}

function locktimer() {
  level endon("host_migration_begin");
  level endon("host_migration_end");
  for(;;) {
    currtime = gettime();
    wait(0.05);
    if(!level.timerstopped && isDefined(level.discardtime)) {
      level.discardtime = level.discardtime + (gettime() - currtime);
    }
  }
}

function callback_hostmigration() {
  zm_utility::redo_link_changes();
  setslowmotion(1, 1, 0);
  zm_utility::upload_zm_dash_counters();
  level.hostmigrationreturnedplayercount = 0;
  if(level.gameended) {
    println(("" + gettime()) + "");
    return;
  }
  sethostmigrationstatus(1);
  level notify("host_migration_begin");
  for(i = 0; i < level.players.size; i++) {
    if(isDefined(level.hostmigration_link_entity_callback)) {
      if(!isDefined(level.players[i]._host_migration_link_entity)) {
        level.players[i]._host_migration_link_entity = level.players[i][[level.hostmigration_link_entity_callback]]();
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
    level waittill("prematch_over");
  }
  println("" + gettime());
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
  level endon("host_migration_begin");
  should_pause_spawning = level flag::get("spawn_zombies");
  if(should_pause_spawning) {
    level flag::clear("spawn_zombies");
  }
  hostmigrationwait();
  foreach(player in level.players) {
    player thread post_migration_invulnerability();
  }
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
  println("" + gettime());
  level notify("host_migration_end");
}

function post_migration_become_vulnerable() {
  self endon("disconnect");
}

function post_migration_invulnerability() {
  self endon("disconnect");
  was_inv = self enableinvulnerability();
  wait(3);
  self disableinvulnerability();
}

function host_migration_respawn() {
  println("");
  new_origin = undefined;
  if(isDefined(level.check_valid_spawn_override)) {
    new_origin = [[level.check_valid_spawn_override]](self);
  }
  if(!isDefined(new_origin)) {
    new_origin = zm::check_for_valid_spawn_near_team(self, 1);
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

function matchstarttimerconsole_internal(counttime, matchstarttimer) {
  waittillframeend();
  level endon("match_start_timer_beginning");
  while(counttime > 0 && !level.gameended) {
    matchstarttimer thread hud::font_pulse(level);
    wait(matchstarttimer.inframes * 0.05);
    matchstarttimer setvalue(counttime);
    counttime--;
    wait(1 - (matchstarttimer.inframes * 0.05));
  }
}

function matchstarttimerconsole(type, duration) {
  thread matchstartblacscreen(duration);
  level notify("match_start_timer_beginning");
  wait(0.05);
  matchstarttext = hud::createserverfontstring("objective", 1.5);
  matchstarttext hud::setpoint("CENTER", "CENTER", 0, -40);
  matchstarttext.sort = 1001;
  matchstarttext settext(game["strings"]["waiting_for_teams"]);
  matchstarttext.foreground = 0;
  matchstarttext.hidewheninmenu = 1;
  matchstarttext settext(game["strings"][type]);
  matchstarttimer = hud::createserverfontstring("objective", 2.2);
  matchstarttimer hud::setpoint("CENTER", "CENTER", 0, 0);
  matchstarttimer.sort = 1001;
  matchstarttimer.color = (1, 1, 0);
  matchstarttimer.foreground = 0;
  matchstarttimer.hidewheninmenu = 1;
  matchstarttimer hud::font_pulse_init();
  counttime = int(duration);
  if(counttime >= 2) {
    matchstarttimerconsole_internal(counttime, matchstarttimer);
  }
  matchstarttimer hud::destroyelem();
  matchstarttext hud::destroyelem();
}

function matchstartblacscreen(duration) {
  array::thread_all(getplayers(), &zm::initialblack);
  fade_time = 4;
  n_black_screen = duration - fade_time;
  level thread zm::fade_out_intro_screen_zm(n_black_screen, fade_time, 1);
  wait(fade_time);
}

function hostmigrationwait() {
  level endon("game_ended");
  if(level.hostmigrationreturnedplayercount < ((level.players.size * 2) / 3)) {
    thread matchstarttimerconsole("waiting_for_teams", 20);
    hostmigrationwaitforplayers();
  }
  thread matchstarttimerconsole("match_starting_in", 9);
  wait(5);
}

function hostmigrationwaitforplayers() {
  level endon("hostmigration_enoughplayers");
  wait(15);
}

function hostmigrationtimerthink_internal() {
  level endon("host_migration_begin");
  level endon("host_migration_end");
  self.hostmigrationcontrolsfrozen = 0;
  while(!isalive(self)) {
    self waittill("spawned");
  }
  if(isDefined(self._host_migration_link_entity)) {
    ent = spawn("script_origin", self.origin);
    ent.angles = self.angles;
    self linkto(ent);
    ent linkto(self._host_migration_link_entity, "tag_origin", self._host_migration_link_entity worldtolocalcoords(ent.origin), ent.angles + self._host_migration_link_entity.angles);
    self._host_migration_link_helper = ent;
    println("" + self._host_migration_link_entity.targetname);
  }
  self.hostmigrationcontrolsfrozen = 1;
  self freezecontrols(1);
  level waittill("host_migration_end");
}

function hostmigrationtimerthink() {
  self endon("disconnect");
  level endon("host_migration_begin");
  hostmigrationtimerthink_internal();
  if(self.hostmigrationcontrolsfrozen) {
    self freezecontrols(0);
    self.hostmigrationcontrolsfrozen = 0;
    println("");
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
  wait(duration);
}

function waitlongdurationwithhostmigrationpause(duration) {
  if(duration == 0) {
    return;
  }
  assert(duration > 0);
  starttime = gettime();
  endtime = gettime() + (duration * 1000);
  while(gettime() < endtime) {
    waittillhostmigrationstarts((endtime - gettime()) / 1000);
    if(isDefined(level.hostmigrationtimer)) {
      timepassed = waittillhostmigrationdone();
      endtime = endtime + timepassed;
    }
  }
  if(gettime() != endtime) {
    println((("" + gettime()) + "") + endtime);
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
  endtime = gettime() + (duration * 1000);
  while(gettime() < endtime) {
    waittillhostmigrationstarts((endtime - gettime()) / 1000);
    while(isDefined(level.hostmigrationtimer)) {
      endtime = endtime + 1000;
      setgameendtime(int(endtime));
      wait(1);
    }
  }
  if(gettime() != endtime) {
    println((("" + gettime()) + "") + endtime);
  }
  while(isDefined(level.hostmigrationtimer)) {
    endtime = endtime + 1000;
    setgameendtime(int(endtime));
    wait(1);
  }
  return gettime() - starttime;
}

function find_alternate_player_place(v_origin, min_radius, max_radius, max_height, ignore_targetted_nodes) {
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
          if(trace["fraction"] < 1) {
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

function hostmigration_put_player_in_better_place() {
  spawnpoint = undefined;
  spawnpoint = find_alternate_player_place(self.origin, 50, 150, 64, 1);
  if(!isDefined(spawnpoint)) {
    spawnpoint = find_alternate_player_place(self.origin, 150, 400, 64, 1);
  }
  if(!isDefined(spawnpoint)) {
    spawnpoint = find_alternate_player_place(self.origin, 50, 400, 256, 0);
  }
  if(!isDefined(spawnpoint)) {
    spawnpoint = zm::check_for_valid_spawn_near_team(self, 1);
  }
  if(!isDefined(spawnpoint)) {
    match_string = "";
    location = level.scr_zm_map_start_location;
    if(location == "default" || location == "" && isDefined(level.default_start_location)) {
      location = level.default_start_location;
    }
    match_string = (level.scr_zm_ui_gametype + "_") + location;
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
    assert(isDefined(spawnpoints), "");
    spawnpoint = zm::getfreespawnpoint(spawnpoints, self);
  }
  if(isDefined(spawnpoint)) {
    self setorigin(spawnpoint.origin);
  }
}