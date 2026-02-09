/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_spawnlogic.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_callbacks;
#using scripts\cp\gametypes\_spawning;
#using scripts\cp\gametypes\_spawnlogic;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#namespace spawnlogic;

function autoexec __init__sytem__() {
  system::register("spawnlogic", &__init__, undefined, undefined);
}

function __init__() {
  function_4489f2c9();
  foreach(spawn_point in get_all_spawn_points()) {
    if(isDefined(spawn_point.scriptgroup_playerspawns_enable)) {
      foreach(trig in getEntArray(spawn_point.scriptgroup_playerspawns_enable, "scriptgroup_playerspawns_enable")) {
        spawn_point thread _spawn_point_enable(trig);
      }
    }
    if(isDefined(spawn_point.scriptgroup_playerspawns_disable)) {
      foreach(trig in getEntArray(spawn_point.scriptgroup_playerspawns_disable, "scriptgroup_playerspawns_disable")) {
        spawn_point thread _spawn_point_disable(trig);
      }
    }
  }
  level thread update_spawn_points();
  callback::on_start_gametype(&init);
  level thread debug_spawn_points();
}

function function_4489f2c9() {
  foreach(spawn_point in get_all_spawn_points()) {
    if(isDefined(spawn_point.linkto)) {
      e_linkto = getent(spawn_point.linkto, "linkname");
      spawn_point function_98b48204(e_linkto);
      continue;
    }
    if(isDefined(spawn_point.script_linkto)) {
      e_linkto = getent(spawn_point.script_linkto, "targetname");
      spawn_point function_98b48204(e_linkto);
    }
  }
}

function function_98b48204(e_linkto) {
  var_14497229 = spawn("script_origin", self.origin);
  var_14497229.angles = self.angles;
  var_14497229.targetname = self.targetname;
  var_14497229.script_objective = self.script_objective;
  var_14497229.scriptgroup_playerspawns_disable = self.scriptgroup_playerspawns_disable;
  var_14497229.scriptgroup_playerspawns_enable = self.scriptgroup_playerspawns_enable;
  if(isDefined(e_linkto)) {
    var_14497229 linkto(e_linkto);
  }
  self struct::delete();
}

function _spawn_point_enable(trig) {
  trig endon("death");
  self.disabled = 1;
  while(true) {
    trig waittill("trigger");
    function_82c857e9(0);
  }
}

function _spawn_point_disable(trig) {
  trig endon("death");
  while(true) {
    trig waittill("trigger");
    function_82c857e9(1);
  }
}

function function_82c857e9(b_enabled) {
  var_1b30c0b0 = isDefined(b_enabled) && (b_enabled ? 1 : undefined);
  if(self.disabled !== var_1b30c0b0) {
    level flagsys::set("spawnpoints_dirty");
    self.disabled = var_1b30c0b0;
  }
}

function update_spawn_points() {
  while(true) {
    if(level flagsys::get("spawnpoints_dirty")) {
      foreach(team in level.teams) {
        rebuild_spawn_points(team);
      }
      level.unified_spawn_points = undefined;
      spawning::updateallspawnpoints();
      level flagsys::clear("spawnpoints_dirty");
    }
    wait(0.05);
  }
}

function get_all_spawn_points(b_include_disabled) {
  a_spawn_points = arraycombine(get_spawnpoint_array("cp_coop_spawn", b_include_disabled), get_spawnpoint_array("cp_coop_respawn", b_include_disabled), 0, 0);
  return a_spawn_points;
}

function debug_spawn_points() {
  if(getdvarstring("") == "") {
    setDvar("", 0);
    setDvar("", 0);
  }
  while(true) {
    b_debug = getdvarint("", 0);
    if(b_debug) {
      foreach(spawn_point in get_all_spawn_points(1)) {
        color = (1, 0, 1);
        if(spawn_point.targetname === "") {
          color = (0, 0, 1);
        }
        if(isDefined(spawn_point.disabled) && spawn_point.disabled || (isDefined(spawn_point.different_skipto) && spawn_point.different_skipto)) {
          color = (1, 0, 0);
        }
        print3d(spawn_point.origin + (vectorscale((0, 0, -1), 35)), spawn_point.targetname, color, 1, 0.3, 1);
        print3d(spawn_point.origin + (vectorscale((0, 0, -1), 43)), (isDefined(spawn_point.script_objective) ? spawn_point.script_objective : ""), color, 1, 0.3, 1);
        box(spawn_point.origin, (-16, -16, -36), (16, 16, 36), 0, color, 0, 1);
      }
    }
    wait(0.05);
  }
}

function init() {
  if(getdvarstring("") == "") {
    setDvar("", 0);
  }
  level.storespawndata = getdvarint("");
  if(getdvarstring("") == "") {
    setDvar("", 0);
  }
  if(getdvarstring("") == "") {
    setDvar("", 0.25);
  }
  thread loop_bot_spawns();
  level.spawnlogic_deaths = [];
  level.spawnlogic_spawnkills = [];
  level.players = [];
  level.grenades = [];
  level.pipebombs = [];
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  level.spawnminsmaxsprimed = 0;
  if(isDefined(level.safespawns)) {
    for(i = 0; i < level.safespawns.size; i++) {
      level.safespawns[i] spawnpoint_init();
    }
  }
  if(getdvarstring("scr_spawn_enemyavoiddist") == "") {
    setDvar("scr_spawn_enemyavoiddist", "800");
  }
  if(getdvarstring("scr_spawn_enemyavoidweight") == "") {
    setDvar("scr_spawn_enemyavoidweight", "0");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarint("") > 0) {
    thread show_deaths_debug();
    thread update_death_info_debug();
    thread profile_debug();
  }
  if(level.storespawndata) {
    thread allow_spawn_data_reading();
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  thread watch_spawn_profile();
  thread spawn_graph_check();
}

function add_spawn_points_internal(team, spawnpoints) {
  oldspawnpoints = [];
  if(level.teamspawnpoints[team].size) {
    oldspawnpoints = level.teamspawnpoints[team];
  }
  if(isDefined(level.filter_spawnpoints)) {
    spawnpoints = [[level.filter_spawnpoints]](spawnpoints);
  }
  level.teamspawnpoints[team] = spawnpoints;
  if(!isDefined(level.spawnpoints)) {
    level.spawnpoints = [];
  }
  for(index = 0; index < level.teamspawnpoints[team].size; index++) {
    spawnpoint = level.teamspawnpoints[team][index];
    if(!isDefined(spawnpoint.inited)) {
      spawnpoint spawnpoint_init();
      level.spawnpoints[level.spawnpoints.size] = spawnpoint;
    }
  }
  for(index = 0; index < oldspawnpoints.size; index++) {
    origin = oldspawnpoints[index].origin;
    level.spawnmins = math::expand_mins(level.spawnmins, origin);
    level.spawnmaxs = math::expand_maxs(level.spawnmaxs, origin);
    level.teamspawnpoints[team][level.teamspawnpoints[team].size] = oldspawnpoints[index];
  }
}

function clear_spawn_points() {
  foreach(team in level.teams) {
    level.teamspawnpoints[team] = [];
  }
  level.spawnpoints = [];
  level.unified_spawn_points = undefined;
}

function add_spawn_points(team, spawnpointname) {
  add_spawn_point_classname(spawnpointname);
  add_spawn_point_team_classname(team, spawnpointname);
  add_spawn_points_internal(team, get_spawnpoint_array(spawnpointname));
  if(!level.teamspawnpoints[team].size) {
    if(!isDefined(level.var_a6f85f47)) {
      assert(level.teamspawnpoints[team].size, ("" + spawnpointname) + "");
    }
    wait(1);
    return;
  }
}

function rebuild_spawn_points(team) {
  level.teamspawnpoints[team] = [];
  for(index = 0; index < level.spawn_point_team_class_names[team].size; index++) {
    add_spawn_points_internal(team, get_spawnpoint_array(level.spawn_point_team_class_names[team][index]));
  }
}

function place_spawn_points(spawnpointname) {
  add_spawn_point_classname(spawnpointname);
  spawnpoints = get_spawnpoint_array(spawnpointname);
  if(!isDefined(level.extraspawnpointsused)) {
    level.extraspawnpointsused = [];
  }
  if(!spawnpoints.size) {
    println(("" + spawnpointname) + "");
    callback::abort_level();
    wait(1);
    return;
  }
  for(index = 0; index < spawnpoints.size; index++) {
    spawnpoints[index] spawnpoint_init();
    spawnpoints[index].fakeclassname = spawnpointname;
    level.extraspawnpointsused[level.extraspawnpointsused.size] = spawnpoints[index];
  }
}

function drop_spawn_points(spawnpointname) {
  spawnpoints = get_spawnpoint_array(spawnpointname);
  if(!spawnpoints.size) {
    println(("" + spawnpointname) + "");
    return;
  }
  for(index = 0; index < spawnpoints.size; index++) {
    spawnpoints[index] place_spawn();
  }
}

function add_spawn_point_classname(spawnpointclassname) {
  if(!isDefined(level.spawn_point_class_names)) {
    level.spawn_point_class_names = [];
  }
  array::add(level.spawn_point_class_names, spawnpointclassname, 0);
}

function add_spawn_point_team_classname(team, spawnpointclassname) {
  array::add(level.spawn_point_team_class_names[team], spawnpointclassname, 0);
}

function get_spawnpoint_array(classname, b_include_disabled = 0) {
  a_all_spawn_points = arraycombine(struct::get_array(classname, "targetname"), getEntArray(classname, "targetname"), 0, 0);
  a_spawn_points = [];
  if(!b_include_disabled) {
    foreach(spawn_point in a_all_spawn_points) {
      if(!(isDefined(spawn_point.disabled) && spawn_point.disabled)) {
        if(!isDefined(a_spawn_points)) {
          a_spawn_points = [];
        } else if(!isarray(a_spawn_points)) {
          a_spawn_points = array(a_spawn_points);
        }
        a_spawn_points[a_spawn_points.size] = spawn_point;
      }
    }
  } else {
    a_spawn_points = a_all_spawn_points;
  }
  if(!isDefined(level.extraspawnpoints) || !isDefined(level.extraspawnpoints[classname])) {
    return a_spawn_points;
  }
  for(i = 0; i < level.extraspawnpoints[classname].size; i++) {
    a_spawn_points[a_spawn_points.size] = level.extraspawnpoints[classname][i];
  }
  return a_spawn_points;
}

function spawnpoint_init() {
  spawnpoint = self;
  origin = spawnpoint.origin;
  if(!level.spawnminsmaxsprimed) {
    level.spawnmins = origin;
    level.spawnmaxs = origin;
    level.spawnminsmaxsprimed = 1;
  } else {
    level.spawnmins = math::expand_mins(level.spawnmins, origin);
    level.spawnmaxs = math::expand_maxs(level.spawnmaxs, origin);
  }
  spawnpoint place_spawn();
  if(!isDefined(spawnpoint.angles)) {
    spawnpoint.angles = (0, 0, 0);
  }
  spawnpoint.forward = anglesToForward(spawnpoint.angles);
  spawnpoint.sighttracepoint = spawnpoint.origin + vectorscale((0, 0, 1), 50);
  spawnpoint.inited = 1;
}

function get_team_spawnpoints(team) {
  return level.teamspawnpoints[team];
}

function get_spawnpoint_final(spawnpoints, useweights) {
  bestspawnpoint = undefined;
  if(!isDefined(spawnpoints) || spawnpoints.size == 0) {
    return undefined;
  }
  if(!isDefined(useweights)) {
    useweights = 1;
  }
  if(useweights) {
    bestspawnpoint = get_best_weighted_spawnpoint(spawnpoints);
    thread spawn_weight_debug(spawnpoints);
  } else {
    for(i = 0; i < spawnpoints.size; i++) {
      if(isDefined(self.lastspawnpoint) && self.lastspawnpoint == spawnpoints[i]) {
        continue;
      }
      if(positionwouldtelefrag(spawnpoints[i].origin)) {
        continue;
      }
      bestspawnpoint = spawnpoints[i];
      break;
    }
    if(!isDefined(bestspawnpoint)) {
      if(isDefined(self.lastspawnpoint) && !positionwouldtelefrag(self.lastspawnpoint.origin)) {
        for(i = 0; i < spawnpoints.size; i++) {
          if(spawnpoints[i] == self.lastspawnpoint) {
            bestspawnpoint = spawnpoints[i];
            break;
          }
        }
      }
    }
  }
  if(!isDefined(bestspawnpoint)) {
    if(useweights) {
      bestspawnpoint = spawnpoints[randomint(spawnpoints.size)];
    } else {
      bestspawnpoint = spawnpoints[0];
    }
  }
  self finalize_spawnpoint_choice(bestspawnpoint);
  self store_spawn_data(spawnpoints, useweights, bestspawnpoint);
  return bestspawnpoint;
}

function finalize_spawnpoint_choice(spawnpoint) {
  time = gettime();
  self.lastspawnpoint = spawnpoint;
  self.lastspawntime = time;
  spawnpoint.lastspawnedplayer = self;
  spawnpoint.lastspawntime = time;
}

function get_best_weighted_spawnpoint(spawnpoints) {
  maxsighttracedspawnpoints = 3;
  for(
    try = 0;
    try <= maxsighttracedspawnpoints;
    try ++) {
    bestspawnpoints = [];
    bestweight = undefined;
    bestspawnpoint = undefined;
    for(i = 0; i < spawnpoints.size; i++) {
      if(!isDefined(bestweight) || spawnpoints[i].weight > bestweight) {
        if(positionwouldtelefrag(spawnpoints[i].origin)) {
          continue;
        }
        bestspawnpoints = [];
        bestspawnpoints[0] = spawnpoints[i];
        bestweight = spawnpoints[i].weight;
        continue;
      }
      if(spawnpoints[i].weight == bestweight) {
        if(positionwouldtelefrag(spawnpoints[i].origin)) {
          continue;
        }
        bestspawnpoints[bestspawnpoints.size] = spawnpoints[i];
      }
    }
    if(bestspawnpoints.size == 0) {
      return undefined;
    }
    bestspawnpoint = bestspawnpoints[randomint(bestspawnpoints.size)];
    if(
      try == maxsighttracedspawnpoints) {
      return bestspawnpoint;
    }
    if(isDefined(bestspawnpoint.lastsighttracetime) && bestspawnpoint.lastsighttracetime == gettime()) {
      return bestspawnpoint;
    }
    if(!last_minute_sight_traces(bestspawnpoint)) {
      return bestspawnpoint;
    }
    penalty = get_los_penalty();
    if(level.storespawndata || level.debugspawning) {
      bestspawnpoint.spawndata[bestspawnpoint.spawndata.size] = "" + penalty;
    }
    bestspawnpoint.weight = bestspawnpoint.weight - penalty;
    bestspawnpoint.lastsighttracetime = gettime();
  }
}

function check_bad(spawnpoint) {
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if(!isalive(player) || player.sessionstate != "") {
      continue;
    }
    if(level.teambased && player.team == self.team) {
      continue;
    }
    losexists = bullettracepassed(player.origin + vectorscale((0, 0, 1), 50), spawnpoint.sighttracepoint, 0, undefined);
    if(losexists) {
      thread bad_spawn_line(spawnpoint.sighttracepoint, player.origin + vectorscale((0, 0, 1), 50), self.name, player.name);
    }
  }
}

function bad_spawn_line(start, end, name1, name2) {
  dist = distance(start, end);
  for(i = 0; i < 200; i++) {
    line(start, end, (1, 0, 0));
    print3d(start, (("" + name1) + "") + dist);
    print3d(end, name2);
    wait(0.05);
  }
}

function store_spawn_data(spawnpoints, useweights, bestspawnpoint) {
  if(!isDefined(level.storespawndata) || !level.storespawndata) {
    return;
  }
  level.storespawndata = getdvarint("");
  if(!level.storespawndata) {
    return;
  }
  if(!isDefined(level.spawnid)) {
    level.spawngameid = randomint(100);
    level.spawnid = 0;
  }
  if(bestspawnpoint.targetname == "") {
    return;
  }
  level.spawnid++;
  file = openfile("", "");
  fprintfields(file, (((((level.spawngameid + "") + level.spawnid) + "") + spawnpoints.size) + "") + self.name);
  for(i = 0; i < spawnpoints.size; i++) {
    str = vec_to_str(spawnpoints[i].origin) + "";
    if(spawnpoints[i] == bestspawnpoint) {
      str = str + "";
    } else {
      str = str + "";
    }
    if(!useweights) {
      str = str + "";
    } else {
      str = str + (spawnpoints[i].weight + "");
    }
    if(!isDefined(spawnpoints[i].spawndata)) {
      spawnpoints[i].spawndata = [];
    }
    if(!isDefined(spawnpoints[i].sightchecks)) {
      spawnpoints[i].sightchecks = [];
    }
    str = str + (spawnpoints[i].spawndata.size + "");
    for(j = 0; j < spawnpoints[i].spawndata.size; j++) {
      str = str + (spawnpoints[i].spawndata[j] + "");
    }
    str = str + (spawnpoints[i].sightchecks.size + "");
    for(j = 0; j < spawnpoints[i].sightchecks.size; j++) {
      str = str + ((spawnpoints[i].sightchecks[j].penalty + "") + vec_to_str(spawnpoints[i].origin) + "");
    }
    fprintfields(file, str);
  }
  obj = spawnStruct();
  get_all_allied_and_enemy_players(obj);
  numallies = 0;
  numenemies = 0;
  str = "";
  for(i = 0; i < obj.allies.size; i++) {
    if(obj.allies[i] == self) {
      continue;
    }
    numallies++;
    str = str + (vec_to_str(obj.allies[i].origin) + "");
  }
  for(i = 0; i < obj.enemies.size; i++) {
    numenemies++;
    str = str + (vec_to_str(obj.enemies[i].origin) + "");
  }
  str = (((numallies + "") + numenemies) + "") + str;
  fprintfields(file, str);
  otherdata = [];
  if(isDefined(level.bombguy)) {
    index = otherdata.size;
    otherdata[index] = spawnStruct();
    otherdata[index].origin = level.bombguy.origin + vectorscale((0, 0, 1), 20);
    otherdata[index].text = "";
  } else if(isDefined(level.bombpos)) {
    index = otherdata.size;
    otherdata[index] = spawnStruct();
    otherdata[index].origin = level.bombpos;
    otherdata[index].text = "";
  }
  if(isDefined(level.flags)) {
    for(i = 0; i < level.flags.size; i++) {
      index = otherdata.size;
      otherdata[index] = spawnStruct();
      otherdata[index].origin = level.flags[i].origin;
      otherdata[index].text = level.flags[i].useobj gameobjects::get_owner_team() + "";
    }
  }
  str = otherdata.size + "";
  for(i = 0; i < otherdata.size; i++) {
    str = str + (((vec_to_str(otherdata[i].origin) + "") + otherdata[i].text) + "");
  }
  fprintfields(file, str);
  closefile(file);
  thisspawnid = (level.spawngameid + "") + level.spawnid;
  self.thisspawnid = thisspawnid;
}

function read_spawn_data(desiredid, relativepos) {
  file = openfile("", "");
  if(file < 0) {
    return;
  }
  oldspawndata = level.curspawndata;
  level.curspawndata = undefined;
  prev = undefined;
  prevthisplayer = undefined;
  lookingfornextthisplayer = 0;
  lookingfornext = 0;
  if(isDefined(relativepos) && !isDefined(oldspawndata)) {
    return;
  }
  while(true) {
    if(freadln(file) <= 0) {
      break;
    }
    data = spawnStruct();
    data.id = fgetarg(file, 0);
    numspawns = int(fgetarg(file, 1));
    if(numspawns > 256) {
      break;
    }
    data.playername = fgetarg(file, 2);
    data.spawnpoints = [];
    data.friends = [];
    data.enemies = [];
    data.otherdata = [];
    for(i = 0; i < numspawns; i++) {
      if(freadln(file) <= 0) {
        break;
      }
      spawnpoint = spawnStruct();
      spawnpoint.origin = str_to_vec(fgetarg(file, 0));
      spawnpoint.winner = int(fgetarg(file, 1));
      spawnpoint.weight = int(fgetarg(file, 2));
      spawnpoint.data = [];
      spawnpoint.sightchecks = [];
      if(i == 0) {
        data.minweight = spawnpoint.weight;
        data.maxweight = spawnpoint.weight;
      } else {
        if(spawnpoint.weight < data.minweight) {
          data.minweight = spawnpoint.weight;
        }
        if(spawnpoint.weight > data.maxweight) {
          data.maxweight = spawnpoint.weight;
        }
      }
      argnum = 4;
      numdata = int(fgetarg(file, 3));
      if(numdata > 256) {
        break;
      }
      for(j = 0; j < numdata; j++) {
        spawnpoint.data[spawnpoint.data.size] = fgetarg(file, argnum);
        argnum++;
      }
      numsightchecks = int(fgetarg(file, argnum));
      argnum++;
      if(numsightchecks > 256) {
        break;
      }
      for(j = 0; j < numsightchecks; j++) {
        index = spawnpoint.sightchecks.size;
        spawnpoint.sightchecks[index] = spawnStruct();
        spawnpoint.sightchecks[index].penalty = int(fgetarg(file, argnum));
        argnum++;
        spawnpoint.sightchecks[index].origin = str_to_vec(fgetarg(file, argnum));
        argnum++;
      }
      data.spawnpoints[data.spawnpoints.size] = spawnpoint;
    }
    if(!isDefined(data.minweight)) {
      data.minweight = -1;
      data.maxweight = 0;
    }
    if(data.minweight == data.maxweight) {
      data.minweight = data.minweight - 1;
    }
    if(freadln(file) <= 0) {
      break;
    }
    numfriends = int(fgetarg(file, 0));
    numenemies = int(fgetarg(file, 1));
    if(numfriends > 32 || numenemies > 32) {
      break;
    }
    argnum = 2;
    for(i = 0; i < numfriends; i++) {
      data.friends[data.friends.size] = str_to_vec(fgetarg(file, argnum));
      argnum++;
    }
    for(i = 0; i < numenemies; i++) {
      data.enemies[data.enemies.size] = str_to_vec(fgetarg(file, argnum));
      argnum++;
    }
    if(freadln(file) <= 0) {
      break;
    }
    numotherdata = int(fgetarg(file, 0));
    argnum = 1;
    for(i = 0; i < numotherdata; i++) {
      otherdata = spawnStruct();
      otherdata.origin = str_to_vec(fgetarg(file, argnum));
      argnum++;
      otherdata.text = fgetarg(file, argnum);
      argnum++;
      data.otherdata[data.otherdata.size] = otherdata;
    }
    if(isDefined(relativepos)) {
      if(relativepos == "") {
        if(data.id == oldspawndata.id) {
          level.curspawndata = prevthisplayer;
          break;
        }
      } else {
        if(relativepos == "") {
          if(data.id == oldspawndata.id) {
            level.curspawndata = prev;
            break;
          }
        } else {
          if(relativepos == "") {
            if(lookingfornextthisplayer) {
              level.curspawndata = data;
              break;
            } else if(data.id == oldspawndata.id) {
              lookingfornextthisplayer = 1;
            }
          } else if(relativepos == "") {
            if(lookingfornext) {
              level.curspawndata = data;
              break;
            } else if(data.id == oldspawndata.id) {
              lookingfornext = 1;
            }
          }
        }
      }
    } else if(data.id == desiredid) {
      level.curspawndata = data;
      break;
    }
    prev = data;
    if(isDefined(oldspawndata) && data.playername == oldspawndata.playername) {
      prevthisplayer = data;
    }
  }
  closefile(file);
}

function draw_spawn_data() {
  level notify("drawing_spawn_data");
  level endon("drawing_spawn_data");
  textoffset = vectorscale((0, 0, -1), 12);
  while(true) {
    if(!isDefined(level.curspawndata)) {
      wait(0.5);
      continue;
    }
    for(i = 0; i < level.curspawndata.friends.size; i++) {
      print3d(level.curspawndata.friends[i], "", (0.5, 1, 0.5), 1, 5);
    }
    for(i = 0; i < level.curspawndata.enemies.size; i++) {
      print3d(level.curspawndata.enemies[i], "", (1, 0.5, 0.5), 1, 5);
    }
    for(i = 0; i < level.curspawndata.otherdata.size; i++) {
      print3d(level.curspawndata.otherdata[i].origin, level.curspawndata.otherdata[i].text, (0.5, 0.75, 1), 1, 2);
    }
    for(i = 0; i < level.curspawndata.spawnpoints.size; i++) {
      sp = level.curspawndata.spawnpoints[i];
      orig = sp.sighttracepoint;
      if(sp.winner) {
        print3d(orig, level.curspawndata.playername + "", (0.5, 0.5, 1), 1, 2);
        orig = orig + textoffset;
      }
      amnt = (sp.weight - level.curspawndata.minweight) / (level.curspawndata.maxweight - level.curspawndata.minweight);
      print3d(orig, "" + sp.weight, (1 - amnt, amnt, 0.5));
      orig = orig + textoffset;
      for(j = 0; j < sp.data.size; j++) {
        print3d(orig, sp.data[j], (1, 1, 1));
        orig = orig + textoffset;
      }
      for(j = 0; j < sp.sightchecks.size; j++) {
        print3d(orig, "" + sp.sightchecks[j].penalty, (1, 0.5, 0.5));
        orig = orig + textoffset;
      }
    }
    wait(0.05);
  }
}

function vec_to_str(vec) {
  return ((int(vec[0]) + "") + int(vec[1]) + "") + int(vec[2]);
}

function str_to_vec(str) {
  parts = strtok(str, "");
  if(parts.size != 3) {
    return (0, 0, 0);
  }
  return (int(parts[0]), int(parts[1]), int(parts[2]));
}

function get_spawnpoint_random(spawnpoints) {
  if(!isDefined(spawnpoints)) {
    return undefined;
  }
  for(i = 0; i < spawnpoints.size; i++) {
    j = randomint(spawnpoints.size);
    spawnpoint = spawnpoints[i];
    spawnpoints[i] = spawnpoints[j];
    spawnpoints[j] = spawnpoint;
  }
  return get_spawnpoint_final(spawnpoints, 0);
}

function get_all_other_players() {
  aliveplayers = [];
  for(i = 0; i < level.players.size; i++) {
    if(!isDefined(level.players[i])) {
      continue;
    }
    player = level.players[i];
    if(player.sessionstate != "playing" || player == self) {
      continue;
    }
    aliveplayers[aliveplayers.size] = player;
  }
  return aliveplayers;
}

function get_all_allied_and_enemy_players(obj) {
  if(level.teambased) {
    assert(isDefined(level.teams[self.team]));
    obj.allies = level.aliveplayers[self.team];
    obj.enemies = undefined;
    foreach(team in level.teams) {
      if(team == self.team) {
        continue;
      }
      if(!isDefined(obj.enemies)) {
        obj.enemies = level.aliveplayers[team];
        continue;
      }
      foreach(player in level.aliveplayers[team]) {
        obj.enemies[obj.enemies.size] = player;
      }
    }
  } else {
    obj.allies = [];
    obj.enemies = level.activeplayers;
  }
}

function init_weights(spawnpoints) {
  for(i = 0; i < spawnpoints.size; i++) {
    spawnpoints[i].weight = 0;
  }
  if(level.storespawndata || level.debugspawning) {
    for(i = 0; i < spawnpoints.size; i++) {
      spawnpoints[i].spawndata = [];
      spawnpoints[i].sightchecks = [];
    }
  }
}

function get_spawnpoint_near_team(spawnpoints, favoredspawnpoints) {
  if(!isDefined(spawnpoints)) {
    return undefined;
  }
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    return get_spawnpoint_random(spawnpoints);
  }
  if(getdvarint("scr_spawnsimple") > 0) {
    return get_spawnpoint_random(spawnpoints);
  }
  begin();
  k_favored_spawn_point_bonus = 25000;
  init_weights(spawnpoints);
  obj = spawnStruct();
  get_all_allied_and_enemy_players(obj);
  numplayers = obj.allies.size + obj.enemies.size;
  allieddistanceweight = 2;
  myteam = self.team;
  for(i = 0; i < spawnpoints.size; i++) {
    spawnpoint = spawnpoints[i];
    if(!isDefined(spawnpoint.numplayersatlastupdate)) {
      spawnpoint.numplayersatlastupdate = 0;
    }
    if(spawnpoint.numplayersatlastupdate > 0) {
      allydistsum = spawnpoint.distsum[myteam];
      enemydistsum = spawnpoint.enemydistsum[myteam];
      spawnpoint.weight = (enemydistsum - (allieddistanceweight * allydistsum)) / spawnpoint.numplayersatlastupdate;
      if(level.storespawndata || level.debugspawning) {
        spawnpoint.spawndata[spawnpoint.spawndata.size] = (((((("" + int(spawnpoint.weight)) + "") + int(enemydistsum) + "") + allieddistanceweight) + "") + int(allydistsum) + "") + spawnpoint.numplayersatlastupdate;
      }
      continue;
    }
    spawnpoint.weight = 0;
    if(level.storespawndata || level.debugspawning) {
      spawnpoint.spawndata[spawnpoint.spawndata.size] = "";
    }
  }
  if(isDefined(favoredspawnpoints)) {
    for(i = 0; i < favoredspawnpoints.size; i++) {
      if(isDefined(favoredspawnpoints[i].weight)) {
        favoredspawnpoints[i].weight = favoredspawnpoints[i].weight + k_favored_spawn_point_bonus;
        continue;
      }
      favoredspawnpoints[i].weight = k_favored_spawn_point_bonus;
    }
  }
  avoid_same_spawn(spawnpoints);
  avoid_spawn_reuse(spawnpoints, 1);
  avoid_weapon_damage(spawnpoints);
  avoid_visible_enemies(spawnpoints, 1);
  result = get_spawnpoint_final(spawnpoints);
  if(getdvarstring("") == "") {
    setDvar("", "");
  }
  if(getdvarstring("") == "") {
    check_bad(result);
  }
  return result;
}

function get_spawnpoint_dm(spawnpoints) {
  if(!isDefined(spawnpoints)) {
    return undefined;
  }
  begin();
  init_weights(spawnpoints);
  aliveplayers = get_all_other_players();
  idealdist = 1600;
  baddist = 1200;
  if(aliveplayers.size > 0) {
    for(i = 0; i < spawnpoints.size; i++) {
      totaldistfromideal = 0;
      nearbybadamount = 0;
      for(j = 0; j < aliveplayers.size; j++) {
        dist = distance(spawnpoints[i].origin, aliveplayers[j].origin);
        if(dist < baddist) {
          nearbybadamount = nearbybadamount + ((baddist - dist) / baddist);
        }
        distfromideal = abs(dist - idealdist);
        totaldistfromideal = totaldistfromideal + distfromideal;
      }
      avgdistfromideal = totaldistfromideal / aliveplayers.size;
      welldistancedamount = (idealdist - avgdistfromideal) / idealdist;
      spawnpoints[i].weight = (welldistancedamount - (nearbybadamount * 2)) + randomfloat(0.2);
    }
  }
  avoid_same_spawn(spawnpoints);
  avoid_spawn_reuse(spawnpoints, 0);
  avoid_weapon_damage(spawnpoints);
  avoid_visible_enemies(spawnpoints, 0);
  return get_spawnpoint_final(spawnpoints);
}

function begin() {
  level.storespawndata = getdvarint("");
  level.debugspawning = getdvarint("") > 0;
}

function watch_spawn_profile() {
  while(true) {
    while(true) {
      if(getdvarint("") > 0) {
        break;
      }
      wait(0.05);
    }
    thread spawn_profile();
    while(true) {
      if(getdvarint("") <= 0) {
        break;
      }
      wait(0.05);
    }
    level notify("stop_spawn_profile");
  }
}

function spawn_profile() {
  level endon("stop_spawn_profile");
  while(true) {
    if(level.players.size > 0 && level.spawnpoints.size > 0) {
      playernum = randomint(level.players.size);
      player = level.players[playernum];
      attempt = 1;
      while(!isDefined(player) && attempt < level.players.size) {
        playernum = (playernum + 1) % level.players.size;
        attempt++;
        player = level.players[playernum];
      }
      player get_spawnpoint_near_team(level.spawnpoints);
    }
    wait(0.05);
  }
}

function spawn_graph_check() {
  while(true) {
    wait(3);
  }
  if(getdvarint("") < 1) {}
  thread spawn_graph();
  return;
}

function spawn_graph() {
  w = 20;
  h = 20;
  weightscale = 0.1;
  fakespawnpoints = [];
  corners = getEntArray("", "");
  if(corners.size != 2) {
    println("");
    return;
  }
  min = corners[0].origin;
  max = corners[0].origin;
  if(corners[1].origin[0] > max[0]) {
    max = (corners[1].origin[0], max[1], max[2]);
  } else {
    min = (corners[1].origin[0], min[1], min[2]);
  }
  if(corners[1].origin[1] > max[1]) {
    max = (max[0], corners[1].origin[1], max[2]);
  } else {
    min = (min[0], corners[1].origin[1], min[2]);
  }
  i = 0;
  for(y = 0; y < h; y++) {
    yamnt = y / (h - 1);
    for(x = 0; x < w; x++) {
      xamnt = x / (w - 1);
      fakespawnpoints[i] = spawnStruct();
      fakespawnpoints[i].origin = ((min[0] * xamnt) + (max[0] * (1 - xamnt)), (min[1] * yamnt) + (max[1] * (1 - yamnt)), min[2]);
      fakespawnpoints[i].angles = (0, 0, 0);
      fakespawnpoints[i].forward = anglesToForward(fakespawnpoints[i].angles);
      fakespawnpoints[i].sighttracepoint = fakespawnpoints[i].origin;
      i++;
    }
  }
  didweights = 0;
  while(true) {
    spawni = 0;
    numiters = 5;
    for(i = 0; i < numiters; i++) {
      if(!level.players.size || !isDefined(level.players[0].team) || level.players[0].team == "" || !isDefined(level.players[0].curclass)) {
        break;
      }
      endspawni = spawni + (fakespawnpoints.size / numiters);
      if(i == (numiters - 1)) {
        endspawni = fakespawnpoints.size;
      }
      while(spawni < endspawni) {
        spawnpoint_update(fakespawnpoints[spawni]);
        spawni++;
      }
      if(didweights) {
        level.players[0] draw_spawn_graph(fakespawnpoints, w, h, weightscale);
      }
      wait(0.05);
    }
    if(!level.players.size || !isDefined(level.players[0].team) || level.players[0].team == "" || !isDefined(level.players[0].curclass)) {
      wait(1);
      continue;
    }
    level.players[0] get_spawnpoint_near_team(fakespawnpoints);
    for(i = 0; i < fakespawnpoints.size; i++) {
      setup_spawn_graph_point(fakespawnpoints[i], weightscale);
    }
    didweights = 1;
    level.players[0] draw_spawn_graph(fakespawnpoints, w, h, weightscale);
    wait(0.05);
  }
}

function draw_spawn_graph(fakespawnpoints, w, h, weightscale) {
  i = 0;
  for(y = 0; y < h; y++) {
    yamnt = y / (h - 1);
    for(x = 0; x < w; x++) {
      xamnt = x / (w - 1);
      if(y > 0) {
        spawn_graph_line(fakespawnpoints[i], fakespawnpoints[i - w], weightscale);
      }
      if(x > 0) {
        spawn_graph_line(fakespawnpoints[i], fakespawnpoints[i - 1], weightscale);
      }
      i++;
    }
  }
}

function setup_spawn_graph_point(s1, weightscale) {
  s1.visible = 1;
  if(s1.weight < -1000 / weightscale) {
    s1.visible = 0;
  }
}

function spawn_graph_line(s1, s2, weightscale) {
  if(!s1.visible || !s2.visible) {
    return;
  }
  p1 = s1.origin + (0, 0, (s1.weight * weightscale) + 100);
  p2 = s2.origin + (0, 0, (s2.weight * weightscale) + 100);
  line(p1, p2, (1, 1, 1));
}

function loop_bot_spawns() {
  while(true) {
    if(getdvarint("") < 1) {
      wait(3);
      continue;
    }
    if(!isDefined(level.players)) {
      wait(0.05);
      continue;
    }
    bots = [];
    for(i = 0; i < level.players.size; i++) {
      if(!isDefined(level.players[i])) {
        continue;
      }
      if(level.players[i].sessionstate == "" && issubstr(level.players[i].name, "")) {
        bots[bots.size] = level.players[i];
      }
    }
    if(bots.size > 0) {
      if(getdvarint("") == 1) {
        killer = bots[randomint(bots.size)];
        victim = bots[randomint(bots.size)];
        victim thread[[level.callbackplayerdamage]](killer, killer, 1000, 0, "", level.weaponnone, (0, 0, 0), (0, 0, 0), "", (0, 0, 0), 0, 0, (1, 0, 0));
      } else {
        numkills = getdvarint("");
        lastvictim = undefined;
        for(index = 0; index < numkills; index++) {
          killer = bots[randomint(bots.size)];
          victim = bots[randomint(bots.size)];
          while(isDefined(lastvictim) && victim == lastvictim) {
            victim = bots[randomint(bots.size)];
          }
          victim thread[[level.callbackplayerdamage]](killer, killer, 1000, 0, "", level.weaponnone, (0, 0, 0), (0, 0, 0), "", (0, 0, 0), 0, 0, (1, 0, 0));
          lastvictim = victim;
        }
      }
    }
    if(getdvarstring("") != "") {
      wait(getdvarfloat(""));
    } else {
      wait(0.05);
    }
  }
}

function allow_spawn_data_reading() {
  setDvar("", "");
  prevval = getdvarstring("");
  prevrelval = getdvarstring("");
  readthistime = 0;
  while(true) {
    val = getdvarstring("");
    relval = undefined;
    if(!isDefined(val) || val == prevval) {
      relval = getdvarstring("");
      if(isDefined(relval) && relval != "") {
        setDvar("", "");
      } else {
        wait(0.5);
        continue;
      }
    }
    prevval = val;
    readthistime = 0;
    read_spawn_data(val, relval);
    if(!isDefined(level.curspawndata)) {
      println("");
    } else {
      println("" + level.curspawndata.id);
    }
    thread draw_spawn_data();
  }
}

function show_deaths_debug() {
  while(true) {
    if(getdvarstring("") == "") {
      wait(3);
      continue;
    }
    time = gettime();
    for(i = 0; i < level.spawnlogic_deaths.size; i++) {
      if(isDefined(level.spawnlogic_deaths[i].los)) {
        line(level.spawnlogic_deaths[i].org, level.spawnlogic_deaths[i].killorg, (1, 0, 0));
      } else {
        line(level.spawnlogic_deaths[i].org, level.spawnlogic_deaths[i].killorg, (1, 1, 1));
      }
      killer = level.spawnlogic_deaths[i].killer;
      if(isDefined(killer) && isalive(killer)) {
        line(level.spawnlogic_deaths[i].killorg, killer.origin, (0.4, 0.4, 0.8));
      }
    }
    for(p = 0; p < level.players.size; p++) {
      if(!isDefined(level.players[p])) {
        continue;
      }
      if(isDefined(level.players[p].spawnlogic_killdist)) {
        print3d(level.players[p].origin + vectorscale((0, 0, 1), 64), level.players[p].spawnlogic_killdist, (1, 1, 1));
      }
    }
    oldspawnkills = level.spawnlogic_spawnkills;
    level.spawnlogic_spawnkills = [];
    for(i = 0; i < oldspawnkills.size; i++) {
      spawnkill = oldspawnkills[i];
      if(spawnkill.dierwasspawner) {
        line(spawnkill.spawnpointorigin, spawnkill.dierorigin, (0.4, 0.5, 0.4));
        line(spawnkill.dierorigin, spawnkill.killerorigin, (0, 1, 1));
        print3d(spawnkill.dierorigin + vectorscale((0, 0, 1), 32), "", (0, 1, 1));
      } else {
        line(spawnkill.spawnpointorigin, spawnkill.killerorigin, (0.4, 0.5, 0.4));
        line(spawnkill.killerorigin, spawnkill.dierorigin, (0, 1, 1));
        print3d(spawnkill.dierorigin + vectorscale((0, 0, 1), 32), "", (0, 1, 1));
      }
      if((time - spawnkill.time) < 60000) {
        level.spawnlogic_spawnkills[level.spawnlogic_spawnkills.size] = oldspawnkills[i];
      }
    }
    wait(0.05);
  }
}

function update_death_info_debug() {
  while(true) {
    if(getdvarstring("scr_spawnpointdebug") == "0") {
      wait(3);
      continue;
    }
    update_death_info();
    wait(3);
  }
}

function spawn_weight_debug(spawnpoints) {
  level notify("stop_spawn_weight_debug");
  level endon("stop_spawn_weight_debug");
  while(true) {
    if(getdvarstring("") == "") {
      wait(3);
      continue;
    }
    textoffset = vectorscale((0, 0, -1), 12);
    for(i = 0; i < spawnpoints.size; i++) {
      amnt = 1 * (1 - (spawnpoints[i].weight / -100000));
      if(amnt < 0) {
        amnt = 0;
      }
      if(amnt > 1) {
        amnt = 1;
      }
      orig = spawnpoints[i].origin + vectorscale((0, 0, 1), 80);
      print3d(orig, int(spawnpoints[i].weight), (1, amnt, 0.5));
      orig = orig + textoffset;
      if(isDefined(spawnpoints[i].spawndata)) {
        for(j = 0; j < spawnpoints[i].spawndata.size; j++) {
          print3d(orig, spawnpoints[i].spawndata[j], vectorscale((1, 1, 1), 0.5));
          orig = orig + textoffset;
        }
      }
      if(isDefined(spawnpoints[i].sightchecks)) {
        for(j = 0; j < spawnpoints[i].sightchecks.size; j++) {
          if(spawnpoints[i].sightchecks[j].penalty == 0) {
            continue;
          }
          print3d(orig, "" + spawnpoints[i].sightchecks[j].penalty, vectorscale((1, 1, 1), 0.5));
          orig = orig + textoffset;
        }
      }
    }
    wait(0.05);
  }
}

function profile_debug() {
  while(true) {
    if(getdvarstring("scr_spawnpointprofile") != "1") {
      wait(3);
      continue;
    }
    for(i = 0; i < level.spawnpoints.size; i++) {
      level.spawnpoints[i].weight = randomint(10000);
    }
    if(level.players.size > 0) {
      level.players[randomint(level.players.size)] get_spawnpoint_near_team(level.spawnpoints);
    }
    wait(0.05);
  }
}

function debug_nearby_players(players, origin) {
  if(getdvarstring("") == "") {
    return;
  }
  starttime = gettime();
  while(true) {
    for(i = 0; i < players.size; i++) {
      line(players[i].origin, origin, (0.5, 1, 0.5));
    }
    if((gettime() - starttime) > 5000) {
      return;
    }
    wait(0.05);
  }
}

function death_occured(dier, killer) {}

function check_for_similar_deaths(deathinfo) {
  for(i = 0; i < level.spawnlogic_deaths.size; i++) {
    if(level.spawnlogic_deaths[i].killer == deathinfo.killer) {
      dist = distance(level.spawnlogic_deaths[i].org, deathinfo.org);
      if(dist > 200) {
        continue;
      }
      dist = distance(level.spawnlogic_deaths[i].killorg, deathinfo.killorg);
      if(dist > 200) {
        continue;
      }
      level.spawnlogic_deaths[i].remove = 1;
    }
  }
}

function update_death_info() {
  time = gettime();
  for(i = 0; i < level.spawnlogic_deaths.size; i++) {
    deathinfo = level.spawnlogic_deaths[i];
    if((time - deathinfo.time) > 90000 || !isDefined(deathinfo.killer) || !isalive(deathinfo.killer) || !isDefined(level.teams[deathinfo.killer.team]) || distance(deathinfo.killer.origin, deathinfo.killorg) > 400) {
      level.spawnlogic_deaths[i].remove = 1;
    }
  }
  oldarray = level.spawnlogic_deaths;
  level.spawnlogic_deaths = [];
  start = 0;
  if((oldarray.size - 1024) > 0) {
    start = oldarray.size - 1024;
  }
  for(i = start; i < oldarray.size; i++) {
    if(!isDefined(oldarray[i].remove)) {
      level.spawnlogic_deaths[level.spawnlogic_deaths.size] = oldarray[i];
    }
  }
}

function is_point_vulnerable(playerorigin) {
  pos = self.origin + level.bettymodelcenteroffset;
  playerpos = playerorigin + vectorscale((0, 0, 1), 32);
  distsqrd = distancesquared(pos, playerpos);
  forward = anglesToForward(self.angles);
  if(distsqrd < (level.bettydetectionradius * level.bettydetectionradius)) {
    playerdir = vectornormalize(playerpos - pos);
    angle = acos(vectordot(playerdir, forward));
    if(angle < level.bettydetectionconeangle) {
      return true;
    }
  }
  return false;
}

function avoid_weapon_damage(spawnpoints) {
  if(getdvarstring("scr_spawnpointnewlogic") == "0") {
    return;
  }
  weapondamagepenalty = 100000;
  if(getdvarstring("scr_spawnpointweaponpenalty") != "" && getdvarstring("scr_spawnpointweaponpenalty") != "0") {
    weapondamagepenalty = getdvarfloat("scr_spawnpointweaponpenalty");
  }
  mingrenadedistsquared = 62500;
  for(i = 0; i < spawnpoints.size; i++) {
    for(j = 0; j < level.grenades.size; j++) {
      if(!isDefined(level.grenades[j])) {
        continue;
      }
      if(distancesquared(spawnpoints[i].origin, level.grenades[j].origin) < mingrenadedistsquared) {
        spawnpoints[i].weight = spawnpoints[i].weight - weapondamagepenalty;
        if(level.storespawndata || level.debugspawning) {
          spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "" + int(weapondamagepenalty);
        }
      }
    }
  }
}

function spawn_per_frame_update() {
  spawnpointindex = 0;
  while(true) {
    wait(0.05);
    if(!isDefined(level.spawnpoints)) {
      return;
    }
    spawnpointindex = (spawnpointindex + 1) % level.spawnpoints.size;
    spawnpoint = level.spawnpoints[spawnpointindex];
    spawnpoint_update(spawnpoint);
  }
}

function get_non_team_sum(skip_team, sums) {
  value = 0;
  foreach(team in level.teams) {
    if(team == skip_team) {
      continue;
    }
    value = value + sums[team];
  }
  return value;
}

function get_non_team_min_dist(skip_team, mindists) {
  dist = 9999999;
  foreach(team in level.teams) {
    if(team == skip_team) {
      continue;
    }
    if(dist > mindists[team]) {
      dist = mindists[team];
    }
  }
  return dist;
}

function spawnpoint_update(spawnpoint) {
  if(level.teambased) {
    sights = [];
    foreach(team in level.teams) {
      spawnpoint.enemysights[team] = 0;
      sights[team] = 0;
      spawnpoint.nearbyplayers[team] = [];
    }
  } else {
    spawnpoint.enemysights = 0;
    spawnpoint.nearbyplayers["all"] = [];
  }
  spawnpointdir = spawnpoint.forward;
  debug = 0;
  debug = getdvarint("") > 0;
  mindist = [];
  distsum = [];
  if(!level.teambased) {
    mindist["all"] = 9999999;
  }
  foreach(team in level.teams) {
    spawnpoint.distsum[team] = 0;
    spawnpoint.enemydistsum[team] = 0;
    spawnpoint.minenemydist[team] = 9999999;
    mindist[team] = 9999999;
  }
  spawnpoint.numplayersatlastupdate = 0;
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if(player.sessionstate != "playing") {
      continue;
    }
    diff = player.origin - spawnpoint.origin;
    diff = (diff[0], diff[1], 0);
    dist = length(diff);
    team = "all";
    if(level.teambased) {
      team = player.team;
    }
    if(dist < 1024) {
      spawnpoint.nearbyplayers[team][spawnpoint.nearbyplayers[team].size] = player;
    }
    if(dist < mindist[team]) {
      mindist[team] = dist;
    }
    distsum[team] = distsum[team] + dist;
    spawnpoint.numplayersatlastupdate++;
    pdir = anglesToForward(player.angles);
    if(vectordot(spawnpointdir, diff) < 0 && vectordot(pdir, diff) > 0) {
      continue;
    }
    losexists = bullettracepassed(player.origin + vectorscale((0, 0, 1), 50), spawnpoint.sighttracepoint, 0, undefined);
    spawnpoint.lastsighttracetime = gettime();
    if(losexists) {
      if(level.teambased) {
        sights[player.team]++;
      } else {
        spawnpoint.enemysights++;
      }
      if(debug) {
        line(player.origin + vectorscale((0, 0, 1), 50), spawnpoint.sighttracepoint, (0.5, 1, 0.5));
      }
    }
  }
  if(level.teambased) {
    foreach(team in level.teams) {
      spawnpoint.enemysights[team] = get_non_team_sum(team, sights);
      spawnpoint.minenemydist[team] = get_non_team_min_dist(team, mindist);
      spawnpoint.distsum[team] = distsum[team];
      spawnpoint.enemydistsum[team] = get_non_team_sum(team, distsum);
    }
  } else {
    spawnpoint.distsum["all"] = distsum["all"];
    spawnpoint.enemydistsum["all"] = distsum["all"];
    spawnpoint.minenemydist["all"] = mindist["all"];
  }
}

function get_los_penalty() {
  if(getdvarstring("scr_spawnpointlospenalty") != "" && getdvarstring("scr_spawnpointlospenalty") != "0") {
    return getdvarfloat("scr_spawnpointlospenalty");
  }
  return 100000;
}

function last_minute_sight_traces(spawnpoint) {
  if(!isDefined(spawnpoint.nearbyplayers)) {
    return false;
  }
  closest = undefined;
  closestdistsq = undefined;
  secondclosest = undefined;
  secondclosestdistsq = undefined;
  foreach(team in spawnpoint.nearbyplayers) {
    if(team == self.team) {
      continue;
    }
    for(i = 0; i < spawnpoint.nearbyplayers[team].size; i++) {
      player = spawnpoint.nearbyplayers[team][i];
      if(!isDefined(player)) {
        continue;
      }
      if(player.sessionstate != "playing") {
        continue;
      }
      if(player == self) {
        continue;
      }
      distsq = distancesquared(spawnpoint.origin, player.origin);
      if(!isDefined(closest) || distsq < closestdistsq) {
        secondclosest = closest;
        secondclosestdistsq = closestdistsq;
        closest = player;
        closestdistsq = distsq;
        continue;
      }
      if(!isDefined(secondclosest) || distsq < secondclosestdistsq) {
        secondclosest = player;
        secondclosestdistsq = distsq;
      }
    }
  }
  if(isDefined(closest)) {
    if(bullettracepassed(closest.origin + vectorscale((0, 0, 1), 50), spawnpoint.sighttracepoint, 0, undefined)) {
      return true;
    }
  }
  if(isDefined(secondclosest)) {
    if(bullettracepassed(secondclosest.origin + vectorscale((0, 0, 1), 50), spawnpoint.sighttracepoint, 0, undefined)) {
      return true;
    }
  }
  return false;
}

function avoid_visible_enemies(spawnpoints, teambased) {
  if(getdvarstring("scr_spawnpointnewlogic") == "0") {
    return;
  }
  lospenalty = get_los_penalty();
  mindistteam = self.team;
  if(teambased) {
    for(i = 0; i < spawnpoints.size; i++) {
      if(!isDefined(spawnpoints[i].enemysights)) {
        continue;
      }
      penalty = lospenalty * spawnpoints[i].enemysights[self.team];
      spawnpoints[i].weight = spawnpoints[i].weight - penalty;
      if(level.storespawndata || level.debugspawning) {
        index = spawnpoints[i].sightchecks.size;
        spawnpoints[i].sightchecks[index] = spawnStruct();
        spawnpoints[i].sightchecks[index].penalty = penalty;
      }
    }
  } else {
    for(i = 0; i < spawnpoints.size; i++) {
      if(!isDefined(spawnpoints[i].enemysights)) {
        continue;
      }
      penalty = lospenalty * spawnpoints[i].enemysights;
      spawnpoints[i].weight = spawnpoints[i].weight - penalty;
      if(level.storespawndata || level.debugspawning) {
        index = spawnpoints[i].sightchecks.size;
        spawnpoints[i].sightchecks[index] = spawnStruct();
        spawnpoints[i].sightchecks[index].penalty = penalty;
      }
    }
    mindistteam = "all";
  }
  avoidweight = getdvarfloat("scr_spawn_enemyavoidweight");
  if(avoidweight != 0) {
    nearbyenemyouterrange = getdvarfloat("scr_spawn_enemyavoiddist");
    nearbyenemyouterrangesq = nearbyenemyouterrange * nearbyenemyouterrange;
    nearbyenemypenalty = 1500 * avoidweight;
    nearbyenemyminorpenalty = 800 * avoidweight;
    lastattackerorigin = vectorscale((-1, -1, -1), 99999);
    lastdeathpos = vectorscale((-1, -1, -1), 99999);
    if(isalive(self.lastattacker)) {
      lastattackerorigin = self.lastattacker.origin;
    }
    if(isDefined(self.lastdeathpos)) {
      lastdeathpos = self.lastdeathpos;
    }
    for(i = 0; i < spawnpoints.size; i++) {
      mindist = spawnpoints[i].minenemydist[mindistteam];
      if(mindist < (nearbyenemyouterrange * 2)) {
        penalty = nearbyenemyminorpenalty * (1 - (mindist / (nearbyenemyouterrange * 2)));
        if(mindist < nearbyenemyouterrange) {
          penalty = penalty + (nearbyenemypenalty * (1 - (mindist / nearbyenemyouterrange)));
        }
        if(penalty > 0) {
          spawnpoints[i].weight = spawnpoints[i].weight - penalty;
          if(level.storespawndata || level.debugspawning) {
            spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = (("" + int(spawnpoints[i].minenemydist[mindistteam])) + "") + int(penalty);
          }
        }
      }
    }
  }
}

function avoid_spawn_reuse(spawnpoints, teambased) {
  if(getdvarstring("scr_spawnpointnewlogic") == "0") {
    return;
  }
  time = gettime();
  maxtime = 10000;
  maxdistsq = 1048576;
  for(i = 0; i < spawnpoints.size; i++) {
    spawnpoint = spawnpoints[i];
    if(!isDefined(spawnpoint.lastspawnedplayer) || !isDefined(spawnpoint.lastspawntime) || !isalive(spawnpoint.lastspawnedplayer)) {
      continue;
    }
    if(spawnpoint.lastspawnedplayer == self) {
      continue;
    }
    if(teambased && spawnpoint.lastspawnedplayer.team == self.team) {
      continue;
    }
    timepassed = time - spawnpoint.lastspawntime;
    if(timepassed < maxtime) {
      distsq = distancesquared(spawnpoint.lastspawnedplayer.origin, spawnpoint.origin);
      if(distsq < maxdistsq) {
        worsen = (5000 * (1 - (distsq / maxdistsq))) * (1 - (timepassed / maxtime));
        spawnpoint.weight = spawnpoint.weight - worsen;
        if(level.storespawndata || level.debugspawning) {
          spawnpoint.spawndata[spawnpoint.spawndata.size] = "" + worsen;
        }
      } else {
        spawnpoint.lastspawnedplayer = undefined;
      }
      continue;
    }
    spawnpoint.lastspawnedplayer = undefined;
  }
}

function avoid_same_spawn(spawnpoints) {
  if(getdvarstring("scr_spawnpointnewlogic") == "0") {
    return;
  }
  if(!isDefined(self.lastspawnpoint)) {
    return;
  }
  for(i = 0; i < spawnpoints.size; i++) {
    if(spawnpoints[i] == self.lastspawnpoint) {
      spawnpoints[i].weight = spawnpoints[i].weight - 50000;
      if(level.storespawndata || level.debugspawning) {
        spawnpoints[i].spawndata[spawnpoints[i].spawndata.size] = "";
      }
      break;
    }
  }
}

function get_random_intermission_point() {
  spawnpoints = struct::get_array("cp_global_intermission", "targetname");
  if(!spawnpoints.size) {
    spawnpoints = struct::get_array("cp_coop_spawn", "targetname");
  }
  assert(spawnpoints.size);
  spawnpoint = get_spawnpoint_random(spawnpoints);
  return spawnpoint;
}

function place_spawn() {}