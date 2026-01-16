/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\dev_spawn.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\spawning_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\dev;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\util;

#namespace dev_spawn;

function_d8049496() {
  callback::on_start_gametype(&on_start_gametype);
  setdvar(#"hash_4c1fd51cfe763a2", "<dev string:x38>");
  setdvar(#"hash_6d53bd520b4f7853", "<dev string:x42>");
}

on_start_gametype() {
  thread function_3326cf8d();
}

function_c28b3d26() {
  show_spawns = getdvarint(#"scr_showspawns", 0);
  show_start_spawns = getdvarint(#"scr_showstartspawns", 0);
  var_8f7b54b5 = getdvarint(#"hash_42bc2c660a3d2ecd", 0);

  if(show_spawns >= 1) {
    show_spawns = 1;
  } else {
    show_spawns = 0;
  }

  if(show_start_spawns >= 1) {
    show_start_spawns = 1;
  } else {
    show_start_spawns = 0;
  }

  if(var_8f7b54b5 >= 1) {
    var_8f7b54b5 = 1;
  } else {
    var_8f7b54b5 = 0;
  }

  if(!isDefined(level.show_spawns) || level.show_spawns != show_spawns) {
    level.show_spawns = show_spawns;
    setdvar(#"scr_showspawns", level.show_spawns);

    if(level.show_spawns) {
      showspawnpoints();
    } else {
      hidespawnpoints();
    }
  }

  if(!isDefined(level.var_8f7b54b5) || level.var_8f7b54b5 != var_8f7b54b5) {
    level.var_8f7b54b5 = var_8f7b54b5;
    setdvar(#"hash_42bc2c660a3d2ecd", level.var_8f7b54b5);

    if(level.var_8f7b54b5) {
      function_1b0780eb();
      return;
    }

    function_107f44c0();
  }
}

function_f084faed() {
  if(!isDefined(level.var_2f11d3e5)) {
    level.var_2f11d3e5 = [];
    level.var_2f11d3e5[#"dm"] = "<dev string:x48>";
    level.var_2f11d3e5[#"ffa"] = "<dev string:x48>";
    level.var_2f11d3e5[#"dem"] = "<dev string:x4e>";
    level.var_2f11d3e5[#"demolition"] = "<dev string:x4e>";
    level.var_2f11d3e5[#"dom"] = "<dev string:x54>";
    level.var_2f11d3e5[#"domination"] = "<dev string:x54>";
    level.var_2f11d3e5[#"demolition_attacker_a"] = "<dev string:x5a>";
    level.var_2f11d3e5[#"demolition_attacker_b"] = "<dev string:x6b>";
    level.var_2f11d3e5[#"demolition_defender_a"] = "<dev string:x7c>";
    level.var_2f11d3e5[#"demolition_defender_b"] = "<dev string:x8d>";
    level.var_2f11d3e5[#"demolition_overtime"] = "<dev string:x9e>";
    level.var_2f11d3e5[#"demolition_remove_a"] = "<dev string:xad>";
    level.var_2f11d3e5[#"demolition_remove_b"] = "<dev string:xbc>";
    level.var_2f11d3e5[#"demolition_start_spawn"] = "<dev string:xcb>";
    level.var_2f11d3e5[#"domination_flag_a"] = "<dev string:xdd>";
    level.var_2f11d3e5[#"domination_flag_b"] = "<dev string:xea>";
    level.var_2f11d3e5[#"domination_flag_c"] = "<dev string:xf7>";
    level.var_2f11d3e5[#"ctf"] = "<dev string:x104>";
    level.var_2f11d3e5[#"frontline"] = "<dev string:x10a>";
    level.var_2f11d3e5[#"gun"] = "<dev string:x116>";
    level.var_2f11d3e5[#"koth"] = "<dev string:x11b>";
    level.var_2f11d3e5[#"infil"] = "<dev string:x122>";
    level.var_2f11d3e5[#"kc"] = "<dev string:x12a>";
    level.var_2f11d3e5[#"sd"] = "<dev string:x12f>";
    level.var_2f11d3e5[#"control"] = "<dev string:x134>";
    level.var_2f11d3e5[#"tdm"] = "<dev string:x13e>";
    level.var_2f11d3e5[#"clean"] = "<dev string:x144>";
    level.var_2f11d3e5[#"ct"] = "<dev string:x14d>";
    level.var_2f11d3e5[#"escort"] = "<dev string:x152>";
    level.var_2f11d3e5[#"bounty"] = "<dev string:x15b>";
  }
}

function_3326cf8d() {
  while(true) {
    var_14d21c2b = getdvarstring(#"scr_set_spawns");

    if(var_14d21c2b != "<dev string:x164>") {
      function_f084faed();
      var_9e1b22d = function_f0b81b80(var_14d21c2b);
      function_bf14041f(var_9e1b22d);
      setdvar(#"scr_set_spawns", "<dev string:x164>");
    }

    wait 1;
  }
}

function_bf14041f(var_9e1b22d) {
  hidespawnpoints();
  spawning::clear_spawn_points();
  globallogic_spawn::function_c40af6fa();

  foreach(spawnflag in var_9e1b22d) {
    globallogic_spawn::addsupportedspawnpointtype(spawnflag);
  }

  spawning::updateallspawnpoints();
  globallogic_spawn::addspawns();
  showspawnpoints();
}

function_f0b81b80(var_14d21c2b) {
  flagset = [];
  tokens = strtok(tolower(var_14d21c2b), "<dev string:x167>");

  foreach(token in tokens) {
    spawnflag = function_423a05a4(token);

    if(isDefined(spawnflag)) {
      flagset[spawnflag] = 1;
    }
  }

  flags = [];

  foreach(flag, isset in flagset) {
    if(isset) {
      if(!isDefined(flags)) {
        flags = [];
      } else if(!isarray(flags)) {
        flags = array(flags);
      }

      flags[flags.size] = flag;
    }
  }

  return flags;
}

function_423a05a4(gametypestr) {
  return level.var_2f11d3e5[gametypestr];
}

function_5650f4ee(var_7a594c78, var_55a94d2c, actualteam, isstartspawn) {
  if(var_55a94d2c == "<dev string:x42>") {
    return 1;
  } else if(var_55a94d2c == "<dev string:x16e>" && !isstartspawn) {
    return 0;
  } else if(isstartspawn && var_55a94d2c != "<dev string:x16e>") {
    return 0;
  } else if(var_55a94d2c == "<dev string:x176>" && var_7a594c78 != #"any") {
    if(var_7a594c78 == #"neutral" && isDefined(actualteam)) {
      return 0;
    }

    if(!(isDefined(actualteam) && actualteam == var_7a594c78)) {
      return 0;
    }
  }

  return 1;
}

function_88770699(spawnlist) {
  level endon(#"hide_spawnpoints", #"hash_12bbc39c8f50f769");
  maxdistancesq = 1000000;
  hostplayer = util::gethostplayer();

  if(!isDefined(hostplayer)) {
    return;
  }

  while(true) {
    color = (1, 1, 1);
    var_7a594c78 = getdvarstring(#"hash_4c1fd51cfe763a2");
    var_55a94d2c = getdvarstring(#"hash_6d53bd520b4f7853");
    level.var_3da2623a = [];

    for(spawn_point_index = 0; spawn_point_index < spawnlist.size; spawn_point_index++) {
      if(!function_5650f4ee(var_7a594c78, var_55a94d2c, spawnlist[spawn_point_index].team, isDefined(spawnlist[spawn_point_index]._human_were) ? spawnlist[spawn_point_index]._human_were : 0)) {
        continue;
      }

      if(distancesquared(hostplayer.origin, spawnlist[spawn_point_index].origin) > maxdistancesq) {
        continue;
      }

      if(!isDefined(level.var_3da2623a)) {
        level.var_3da2623a = [];
      } else if(!isarray(level.var_3da2623a)) {
        level.var_3da2623a = array(level.var_3da2623a);
      }

      level.var_3da2623a[level.var_3da2623a.size] = spawnlist[spawn_point_index];
      drawspawnpoint(spawnlist[spawn_point_index], color);
    }

    waitframe(1);
  }
}

showspawnpoints() {
  spawns = [];
  spawnpoints = arraycombine(level.spawnpoints, spawns, 0, 0);

  if(isDefined(level.spawn_start)) {
    foreach(startspawns in level.spawn_start) {
      spawnpoints = arraycombine(startspawns, spawnpoints, 0, 0);
    }
  }

  thread function_88770699(spawnpoints);
}

function_1b0780eb() {
  if(!isDefined(level.spawnpoints)) {
    return;
  }

  color = (1, 1, 1);
  spawns = [];
  spawnpoints = arraycombine(level.allspawnpoints, spawns, 0, 0);

  if(isDefined(level.spawn_start)) {
    foreach(startspawns in level.spawn_start) {
      spawnpoints = arraycombine(startspawns, spawnpoints, 0, 0);
    }
  }

  thread function_88770699(spawnpoints);
}

function_107f44c0() {
  level notify(#"hash_12bbc39c8f50f769");
}

hidespawnpoints() {
  level notify(#"hide_spawnpoints");
  return;
}

showstartspawnpoints() {
  if(!isDefined(level.spawn_start)) {
    return;
  }

  if(level.teambased) {
    team_colors = [];
    team_colors[#"axis"] = (1, 0, 1);
    team_colors[#"allies"] = (0, 1, 1);
    team_colors[#"team3"] = (1, 1, 0);
    team_colors[#"team4"] = (0, 1, 0);
    team_colors[#"team5"] = (0, 0, 1);
    team_colors[#"team6"] = (1, 0.5, 0);
    team_colors[#"team7"] = (1, 0.752941, 0.796078);
    team_colors[#"team8"] = (0.545098, 0.270588, 0.0745098);

    foreach(key, color in team_colors) {
      if(!isDefined(level.spawn_start[key])) {
        continue;
      }

      foreach(spawnpoint in level.spawn_start[key]) {
        showonespawnpoint(spawnpoint, color, "<dev string:x17d>");
      }
    }

    return;
  }

  color = (1, 0, 1);

  foreach(spawnpoint in level.spawn_start) {
    showonespawnpoint(spawnpoint, color, "<dev string:x17d>");
  }

  return;
}

hidestartspawnpoints() {
  level notify(#"hide_startspawnpoints");
  return;
}

drawspawnpoint(spawn_point, color, height, var_379ac7cc) {
  if(!isDefined(height) || height <= 0) {
    height = util::get_player_height();
  }

  if(!isDefined(var_379ac7cc)) {
    if(level.convert_spawns_to_structs) {
      var_379ac7cc = spawn_point.targetname;
    } else {
      var_379ac7cc = spawn_point.classname;
    }
  }

  depthtest = 0;
  center = spawn_point.origin;
  forward = anglesToForward(spawn_point.angles);
  right = anglestoright(spawn_point.angles);
  forward = vectorscale(forward, 16);
  right = vectorscale(right, 16);
  a = center + forward - right;
  b = center + forward + right;
  c = center - forward + right;
  d = center - forward - right;
  line(a, b, color, 0, depthtest);
  line(b, c, color, 0, depthtest);
  line(c, d, color, 0, depthtest);
  line(d, a, color, 0, depthtest);
  line(a, a + (0, 0, height), color, 0, depthtest);
  line(b, b + (0, 0, height), color, 0, depthtest);
  line(c, c + (0, 0, height), color, 0, depthtest);
  line(d, d + (0, 0, height), color, 0, depthtest);
  a += (0, 0, height);
  b += (0, 0, height);
  c += (0, 0, height);
  d += (0, 0, height);
  line(a, b, color, 0, depthtest);
  line(b, c, color, 0, depthtest);
  line(c, d, color, 0, depthtest);
  line(d, a, color, 0, depthtest);
  center += (0, 0, height / 2);
  arrow_forward = anglesToForward(spawn_point.angles);
  arrowhead_forward = anglesToForward(spawn_point.angles);
  arrowhead_right = anglestoright(spawn_point.angles);
  arrow_forward = vectorscale(arrow_forward, 32);
  arrowhead_forward = vectorscale(arrowhead_forward, 24);
  arrowhead_right = vectorscale(arrowhead_right, 8);
  a = center + arrow_forward;
  b = center + arrowhead_forward - arrowhead_right;
  c = center + arrowhead_forward + arrowhead_right;
  line(center, a, color, 0, depthtest);
  line(a, b, color, 0, depthtest);
  line(a, c, color, 0, depthtest);

  if(isDefined(var_379ac7cc) && var_379ac7cc != "<dev string:x164>") {
    print3d(spawn_point.origin + (0, 0, height), var_379ac7cc, color, 1, 1);
  }
}

showonespawnpoint(spawn_point, color, notification, height, print) {
  if(!isDefined(height) || height <= 0) {
    height = util::get_player_height();
  }

  if(!isDefined(print)) {
    if(level.convert_spawns_to_structs) {
      print = spawn_point.targetname;
    } else {
      print = spawn_point.classname;
    }
  }

  center = spawn_point.origin;
  forward = anglesToForward(spawn_point.angles);
  right = anglestoright(spawn_point.angles);
  forward = vectorscale(forward, 16);
  right = vectorscale(right, 16);
  a = center + forward - right;
  b = center + forward + right;
  c = center - forward + right;
  d = center - forward - right;
  thread dev::lineuntilnotified(a, b, color, 0, notification);
  thread dev::lineuntilnotified(b, c, color, 0, notification);
  thread dev::lineuntilnotified(c, d, color, 0, notification);
  thread dev::lineuntilnotified(d, a, color, 0, notification);
  thread dev::lineuntilnotified(a, a + (0, 0, height), color, 0, notification);
  thread dev::lineuntilnotified(b, b + (0, 0, height), color, 0, notification);
  thread dev::lineuntilnotified(c, c + (0, 0, height), color, 0, notification);
  thread dev::lineuntilnotified(d, d + (0, 0, height), color, 0, notification);
  a += (0, 0, height);
  b += (0, 0, height);
  c += (0, 0, height);
  d += (0, 0, height);
  thread dev::lineuntilnotified(a, b, color, 0, notification);
  thread dev::lineuntilnotified(b, c, color, 0, notification);
  thread dev::lineuntilnotified(c, d, color, 0, notification);
  thread dev::lineuntilnotified(d, a, color, 0, notification);
  center += (0, 0, height / 2);
  arrow_forward = anglesToForward(spawn_point.angles);
  arrowhead_forward = anglesToForward(spawn_point.angles);
  arrowhead_right = anglestoright(spawn_point.angles);
  arrow_forward = vectorscale(arrow_forward, 32);
  arrowhead_forward = vectorscale(arrowhead_forward, 24);
  arrowhead_right = vectorscale(arrowhead_right, 8);
  a = center + arrow_forward;
  b = center + arrowhead_forward - arrowhead_right;
  c = center + arrowhead_forward + arrowhead_right;
  thread dev::lineuntilnotified(center, a, color, 0, notification);
  thread dev::lineuntilnotified(a, b, color, 0, notification);
  thread dev::lineuntilnotified(a, c, color, 0, notification);

  if(isDefined(print) && print != "<dev string:x164>") {
    thread dev::print3duntilnotified(spawn_point.origin + (0, 0, height), print, color, 1, 1, notification);
  }

  return;
}

