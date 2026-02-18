/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\dev_spawn.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using script_7d712f77ab8d0c16;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\gametypes\dev;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\util;
#namespace dev_spawn;

function function_d8049496() {
  callback::on_start_gametype(&on_start_gametype);
  setDvar(#"hash_4c1fd51cfe763a2", "<dev string:x38>");
  setDvar(#"hash_6d53bd520b4f7853", "<dev string:x43>");
}

function on_start_gametype() {
  thread function_3326cf8d();
}

function function_f084faed() {
  if(!isDefined(level.var_2f11d3e5)) {
    level.var_2f11d3e5 = [];
    level.var_2f11d3e5[# "dm"] = "<dev string:x4a>";
    level.var_2f11d3e5[# "ffa"] = "<dev string:x4a>";
    level.var_2f11d3e5[# "dem"] = "<dev string:x51>";
    level.var_2f11d3e5[# "demolition"] = "<dev string:x51>";
    level.var_2f11d3e5[# "dom"] = "<dev string:x58>";
    level.var_2f11d3e5[# "domination"] = "<dev string:x58>";
    level.var_2f11d3e5[# "demolition_attacker_a"] = "<dev string:x5f>";
    level.var_2f11d3e5[# "demolition_attacker_b"] = "<dev string:x71>";
    level.var_2f11d3e5[# "demolition_defender_a"] = "<dev string:x83>";
    level.var_2f11d3e5[# "demolition_defender_b"] = "<dev string:x95>";
    level.var_2f11d3e5[# "demolition_overtime"] = "<dev string:xa7>";
    level.var_2f11d3e5[# "demolition_remove_a"] = "<dev string:xb7>";
    level.var_2f11d3e5[# "demolition_remove_b"] = "<dev string:xc7>";
    level.var_2f11d3e5[# "demolition_start_spawn"] = "<dev string:xd7>";
    level.var_2f11d3e5[# "domination_flag_a"] = "<dev string:xea>";
    level.var_2f11d3e5[# "domination_flag_b"] = "<dev string:xf8>";
    level.var_2f11d3e5[# "domination_flag_c"] = "<dev string:x106>";
    level.var_2f11d3e5[# "hash_4bcbc16ff5f139bb"] = "<dev string:x114>";
    level.var_2f11d3e5[# "hash_4bcbc06ff5f13808"] = "<dev string:x122>";
    level.var_2f11d3e5[# "hash_4bcbc36ff5f13d21"] = "<dev string:x130>";
    level.var_2f11d3e5[# "ctf"] = "<dev string:x13e>";
    level.var_2f11d3e5[# "frontline"] = "<dev string:x145>";
    level.var_2f11d3e5[# "gun"] = "<dev string:x152>";
    level.var_2f11d3e5[# "koth"] = "<dev string:x158>";
    level.var_2f11d3e5[# "infil"] = "<dev string:x160>";
    level.var_2f11d3e5[# "kc"] = "<dev string:x169>";
    level.var_2f11d3e5[# "sd"] = "<dev string:x16f>";
    level.var_2f11d3e5[# "control"] = "<dev string:x175>";
    level.var_2f11d3e5[# "tdm"] = "<dev string:x180>";
    level.var_2f11d3e5[# "clean"] = "<dev string:x187>";
    level.var_2f11d3e5[# "ct"] = "<dev string:x191>";
    level.var_2f11d3e5[# "escort"] = "<dev string:x197>";
    level.var_2f11d3e5[# "bounty"] = "<dev string:x1a1>";
    level.var_2f11d3e5[# "vip"] = "<dev string:x1ab>";
    level.var_2f11d3e5[# "dropkick"] = "<dev string:x1b2>";
  }
}

function function_3326cf8d() {
  while(true) {
    var_14d21c2b = getdvarstring(#"scr_set_spawns");

    if(var_14d21c2b != "<dev string:x1be>") {
      function_f084faed();
      var_9e1b22d = function_f0b81b80(var_14d21c2b);
      function_bf14041f(var_9e1b22d);
      setDvar(#"scr_set_spawns", "<dev string:x1be>");
    }

    wait 1;
  }
}

function function_bf14041f(var_9e1b22d) {
  spawning::clear_spawn_points();
  spawning::function_c40af6fa();

  foreach(spawnflag in var_9e1b22d) {
    spawning::addsupportedspawnpointtype(spawnflag);
  }

  spawning::addspawns();
}

function function_f0b81b80(var_14d21c2b) {
  flagset = [];
  tokens = strtok(tolower(var_14d21c2b), "<dev string:x1c2>");

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

function function_423a05a4(gametypestr) {
  return level.var_2f11d3e5[gametypestr];
}

function function_5650f4ee(var_7a594c78, var_55a94d2c, actualteam, isstartspawn) {
  if(var_55a94d2c == "<dev string:x43>") {
    return 1;
  } else if(var_55a94d2c == "<dev string:x1ca>" && !isstartspawn) {
    return 0;
  } else if(isstartspawn && var_55a94d2c != "<dev string:x1ca>") {
    return 0;
  } else if(var_55a94d2c == "<dev string:x1d3>" && var_7a594c78 != # "any") {
    if(var_7a594c78 == # "neutral" && isDefined(actualteam)) {
      return 0;
    }

    if(!(isDefined(actualteam) && actualteam == var_7a594c78)) {
      return 0;
    }
  }

  return 1;
}

function function_1b0780eb() {}

function function_107f44c0() {
  level notify(#"hash_12bbc39c8f50f769");
}

function hidespawnpoints() {
  level notify(#"hide_spawnpoints");
  return;
}

function showstartspawnpoints() {
  if(!isDefined(level.spawn_start)) {
    return;
  }

  if(level.teambased) {
    team_colors = [];
    team_colors[# "axis"] = (1, 0, 1);
    team_colors[# "allies"] = (0, 1, 1);
    team_colors[# "team3"] = (1, 1, 0);
    team_colors[# "team4"] = (0, 1, 0);
    team_colors[# "team5"] = (0, 0, 1);
    team_colors[# "team6"] = (1, 0.5, 0);
    team_colors[# "team7"] = (1, 0.752941, 0.796078);
    team_colors[# "team8"] = (0.545098, 0.270588, 0.0745098);

    foreach(key, color in team_colors) {
      if(!isDefined(level.spawn_start[key])) {
        continue;
      }

      foreach(spawnpoint in level.spawn_start[key]) {
        showonespawnpoint(spawnpoint, color, "<dev string:x1db>");
      }
    }

    return;
  }

  color = (1, 0, 1);

  foreach(spawnpoint in level.spawn_start) {
    showonespawnpoint(spawnpoint, color, "<dev string:x1db>");
  }

  return;
}

function hidestartspawnpoints() {
  level notify(#"hide_startspawnpoints");
  return;
}

function drawspawnpoint(spawn_point, color, height, var_379ac7cc) {
  if(!isDefined(height) || height <= 0) {
    height = util::get_player_height();
  }

  if(!isDefined(var_379ac7cc)) {
    var_379ac7cc = spawn_point.classname;
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

  if(isDefined(var_379ac7cc) && var_379ac7cc != "<dev string:x1be>") {
    print3d(spawn_point.origin + (0, 0, height), var_379ac7cc, color, 1, 1);
  }
}

function showonespawnpoint(spawn_point, color, notification, height, print) {
  if(!isDefined(height) || height <= 0) {
    height = util::get_player_height();
  }

  if(!isDefined(print)) {
    print = spawn_point.classname;
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

  if(isDefined(print) && print != "<dev string:x1be>") {
    thread dev::print3duntilnotified(spawn_point.origin + (0, 0, height), print, color, 1, 1, notification);
  }

  return;
}