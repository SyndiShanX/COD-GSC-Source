/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\doa\_doa_arena.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\cp\cp_doa_bo3_fx;
#using scripts\cp\cp_doa_bo3_sound;
#using scripts\cp\doa\_doa_camera;
#using scripts\cp\doa\_doa_core;
#using scripts\cp\doa\_doa_fx;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace namespace_3ca3c537;

function private function_a55a134f() {
  arenas = struct::get_array("arena_center");
  for(i = 0; i < arenas.size; i++) {
    if(issubstr(arenas[i].script_parameters, "player_challenge")) {
      arenas[i].var_f869148f = arenas[i].script_parameters;
      arenas[i].script_parameters = "99999";
    }
  }
  unsorted = arenas;
  for(i = 1; i < unsorted.size; i++) {
    for(j = i; j > 0 && (int(unsorted[j - 1].script_parameters)) > int(unsorted[j].script_parameters); j--) {
      array::swap(unsorted, j, j - 1);
    }
  }
  return unsorted;
}

function function_bd3519f2(name) {
  switch (name) {
    case "safehouse": {
      return 500;
    }
    case "redins":
    case "tankmaze": {
      return 1000;
    }
    case "combat": {
      return 1800;
    }
    default: {
      return 600;
    }
  }
}

function function_61e2e743() {
  if(isDefined(level.doa.var_708cc739)) {
    switch (level.doa.var_708cc739) {
      case 1: {
        return 400;
      }
      case 2: {
        return 800;
      }
      case 3: {
        return 1000;
      }
      case 4: {
        return 1800;
      }
    }
    assert(0);
  }
  return level.doa.arenas[level.doa.current_arena].var_5b6a567;
}

function function_382c20a3() {
  return level.doa.arenas[level.doa.current_arena].var_bfa5d6ae;
}

function init() {
  level.doa.arenas = [];
  arenas = function_a55a134f();
  for(i = 0; i < arenas.size; i++) {
    arena = spawnStruct();
    arena.name = arenas[i].script_noteworthy;
    arena.center = arenas[i].origin;
    arena.var_5b6a567 = function_bd3519f2(arena.name);
    arena.var_37d3a53b = (isDefined(arenas[i].var_f869148f) ? 1 : 0);
    arena.var_aad78940 = 1.4;
    arena.var_bfa5d6ae = 0;
    arena.var_dd94482c = (1 + 2) + 16;
    arena.var_ecf7ec70 = undefined;
    if(isDefined(level.var_2eda2d85)) {
      [
        [level.var_2eda2d85]
      ](arena);
    }
    arena.exits = getEntArray(0, arena.name + "_doa_exit", "targetname");
    arena.startpoints["left"] = struct::get_array((arena.name + "_exit_start_") + "left");
    arena.startpoints["right"] = struct::get_array((arena.name + "_exit_start_") + "right");
    arena.startpoints["top"] = struct::get_array((arena.name + "_exit_start_") + "top");
    arena.startpoints["bottom"] = struct::get_array((arena.name + "_exit_start_") + "bottom");
    arena.startpoints["player"] = struct::get_array(arena.name + "_player_spawnpoint");
    if(arena.name == "vault" || arena.name == "tankmaze" || arena.name == "coop" || arena.name == "armory" || arena.name == "alien_armory" || arena.name == "wolfhole" || arena.name == "bomb_storage" || arena.name == "hangar" || arena.name == "redins" || arena.name == "truck_soccer" || arena.name == "tankmaze") {
      arena.var_869acbe6 = 1;
    }
    var_5fabae4f = struct::get(arena.name + "_camera_fixed_point");
    if(isDefined(var_5fabae4f) && isDefined(var_5fabae4f.script_parameters)) {
      campos = strtok(var_5fabae4f.script_parameters, " ");
      assert(isDefined(campos.size == 3), ("" + arena.name) + "");
      arena.var_2ac7f133 = (float(campos[0]), float(campos[1]), float(campos[2]));
    } else {
      arena.var_2ac7f133 = (0, 0, 0);
    }
    if(isDefined(var_5fabae4f) && isDefined(var_5fabae4f.script_noteworthy)) {
      var_b5091c96 = strtok(var_5fabae4f.script_noteworthy, " ");
      assert(isDefined(var_b5091c96.size == 3), ("" + arena.name) + "");
      arena.var_5fec1234 = (float(var_b5091c96[0]), float(var_b5091c96[1]), float(var_b5091c96[2]));
    } else {
      arena.var_5fec1234 = vectorscale((1, 0, 0), 60);
    }
    arena.var_7526f3f5 = arena.var_2ac7f133;
    arena.var_790aac0e = arena.var_5fec1234;
    var_5fabae4f = struct::get(arena.name + "_camera_fixed_point_flip");
    if(isDefined(var_5fabae4f)) {
      if(isDefined(var_5fabae4f.script_parameters)) {
        campos = strtok(var_5fabae4f.script_parameters, " ");
        assert(isDefined(campos.size == 3), ("" + arena.name) + "");
        arena.var_5a97f5e9 = (float(campos[0]), float(campos[1]), float(campos[2]));
      } else {
        arena.var_5a97f5e9 = (0, 0, 0);
      }
      if(isDefined(var_5fabae4f.script_noteworthy)) {
        var_b5091c96 = strtok(var_5fabae4f.script_noteworthy, " ");
        assert(isDefined(var_b5091c96.size == 3), ("" + arena.name) + "");
        arena.var_a8b67ea4 = (float(var_b5091c96[0]), float(var_b5091c96[1]), float(var_b5091c96[2]));
      } else {
        arena.var_5fec1234 = (60, 180, 0);
      }
    }
    if(isDefined(arena.var_f4f1abf3)) {
      if(arena.var_f4f1abf3 == 1) {
        arena.var_f4f1abf3 = arena.var_5fec1234;
      }
      if(arena.var_f4f1abf3 == 2) {
        arena.var_f4f1abf3 = arena.var_5a97f5e9;
      }
    }
    level.doa.arenas[level.doa.arenas.size] = arena;
  }
  level.doa.current_arena = 0;
  level.doa.var_95e3fdf9 = -1;
  level.doa.var_1a75d02b = 1;
  level.doa.var_d94564a5 = "morning";
  level thread function_a83dfb2c();
  keywords = [];
  keywords["targetname"] = [];
  if(!isDefined(keywords["targetname"])) {
    keywords["targetname"] = [];
  } else if(!isarray(keywords["targetname"])) {
    keywords["targetname"] = array(keywords["targetname"]);
  }
  keywords["targetname"][keywords["targetname"].size] = "_spot";
  if(!isDefined(keywords["targetname"])) {
    keywords["targetname"] = [];
  } else if(!isarray(keywords["targetname"])) {
    keywords["targetname"] = array(keywords["targetname"]);
  }
  keywords["targetname"][keywords["targetname"].size] = "_hazard";
  if(!isDefined(keywords["targetname"])) {
    keywords["targetname"] = [];
  } else if(!isarray(keywords["targetname"])) {
    keywords["targetname"] = array(keywords["targetname"]);
  }
  keywords["targetname"][keywords["targetname"].size] = "_pickup";
  if(!isDefined(keywords["targetname"])) {
    keywords["targetname"] = [];
  } else if(!isarray(keywords["targetname"])) {
    keywords["targetname"] = array(keywords["targetname"]);
  }
  keywords["targetname"][keywords["targetname"].size] = "_teleporter";
  if(!isDefined(keywords["targetname"])) {
    keywords["targetname"] = [];
  } else if(!isarray(keywords["targetname"])) {
    keywords["targetname"] = array(keywords["targetname"]);
  }
  keywords["targetname"][keywords["targetname"].size] = "_loot";
  if(!isDefined(keywords["targetname"])) {
    keywords["targetname"] = [];
  } else if(!isarray(keywords["targetname"])) {
    keywords["targetname"] = array(keywords["targetname"]);
  }
  keywords["targetname"][keywords["targetname"].size] = "_spawn";
  if(!isDefined(keywords["targetname"])) {
    keywords["targetname"] = [];
  } else if(!isarray(keywords["targetname"])) {
    keywords["targetname"] = array(keywords["targetname"]);
  }
  keywords["targetname"][keywords["targetname"].size] = "_destructible";
  keywords["script_noteworthy"] = [];
  if(!isDefined(keywords["script_noteworthy"])) {
    keywords["script_noteworthy"] = [];
  } else if(!isarray(keywords["script_noteworthy"])) {
    keywords["script_noteworthy"] = array(keywords["script_noteworthy"]);
  }
  keywords["script_noteworthy"][keywords["script_noteworthy"].size] = "tankmaze_gemspot";
  level function_d6bfcb75(keywords);
}

function function_d6bfcb75(keywords) {
  var_3c8074ad = getarraykeys(keywords);
  for(i = 0; i < level.struct.size; i++) {
    if(function_a5b9b9b9(keywords, var_3c8074ad, level.struct[i])) {
      arrayremoveindex(level.struct, i, 0);
      i--;
    }
  }
  var_e5c5b3d2 = level.struct_class_names;
  var_7234d8ce = getarraykeys(var_e5c5b3d2);
  for(i = 0; i < var_7234d8ce.size; i++) {
    var_df94bc60 = var_e5c5b3d2[var_7234d8ce[i]];
    keys = getarraykeys(var_df94bc60);
    for(j = 0; j < keys.size; j++) {
      values = var_df94bc60[keys[j]];
      for(k = 0; k < values.size; k++) {
        if(function_a5b9b9b9(keywords, var_3c8074ad, values[k])) {
          arrayremoveindex(values, k, 0);
          k--;
        }
      }
    }
  }
}

function function_a5b9b9b9(var_92804e37, var_b092b293, struct) {
  for(i = 0; i < var_b092b293.size; i++) {
    key = var_b092b293[i];
    var_cd3c820 = var_92804e37[key];
    for(j = 0; j < var_cd3c820.size; j++) {
      field = getstructfield(struct, key);
      if(isDefined(field) && issubstr(field, var_cd3c820[j])) {
        return true;
      }
    }
  }
  return false;
}

function restart() {
  level.doa.current_arena = 0;
  level.doa.var_95e3fdf9 = -1;
  level.doa.var_708cc739 = undefined;
  level.doa.var_1a75d02b = 1;
  level.doa.flipped = 0;
  namespace_ad544aeb::function_d22ceb57(vectorscale((1, 0, 0), 75), function_61e2e743());
  if(isDefined(level.doa.arenas[level.doa.current_arena].var_2ac7f133)) {
    level.doa.arenas[level.doa.current_arena].var_7526f3f5 = level.doa.arenas[level.doa.current_arena].var_2ac7f133;
  }
  if(isDefined(level.doa.arenas[level.doa.current_arena].var_5fec1234)) {
    level.doa.arenas[level.doa.current_arena].var_790aac0e = level.doa.arenas[level.doa.current_arena].var_5fec1234;
  }
  cleanupspawneddynents();
  if(isDefined(level.doa.var_1a3f3152)) {
    exploder::kill_exploder(level.doa.var_1a3f3152);
    level.doa.var_1a3f3152 = undefined;
  }
}

function function_a83dfb2c() {
  while(!clienthassnapshot(0)) {
    wait(0.016);
  }
  foreach(arena in level.doa.arenas) {
    arena.exits = getEntArray(0, arena.name + "_doa_exit", "targetname");
  }
  a_all_entities = getEntArray(0);
  foreach(entity in a_all_entities) {
    wait(0.01);
  }
}

function flipcamera(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.doa.var_1a75d02b = newval;
  switch (level.doa.var_1a75d02b) {
    case 0:
    case 1: {
      level.doa.flipped = 0;
      namespace_ad544aeb::function_d22ceb57(function_c530afc5(vectorscale((1, 0, 0), 75)), function_61e2e743());
      if(isDefined(level.doa.arenas[level.doa.current_arena].var_2ac7f133)) {
        level.doa.arenas[level.doa.current_arena].var_7526f3f5 = level.doa.arenas[level.doa.current_arena].var_2ac7f133;
      }
      if(isDefined(level.doa.arenas[level.doa.current_arena].var_5fec1234)) {
        level.doa.arenas[level.doa.current_arena].var_790aac0e = level.doa.arenas[level.doa.current_arena].var_5fec1234;
      }
      level.doa.var_1a75d02b = 1;
      break;
    }
    case 2: {
      level.doa.flipped = 1;
      namespace_ad544aeb::function_d22ceb57(function_c530afc5((75, 180, 0)), function_61e2e743());
      if(isDefined(level.doa.arenas[level.doa.current_arena].var_5a97f5e9)) {
        level.doa.arenas[level.doa.current_arena].var_7526f3f5 = level.doa.arenas[level.doa.current_arena].var_5a97f5e9;
      }
      if(isDefined(level.doa.arenas[level.doa.current_arena].var_a8b67ea4)) {
        level.doa.arenas[level.doa.current_arena].var_790aac0e = level.doa.arenas[level.doa.current_arena].var_a8b67ea4;
      }
      break;
    }
  }
  cleanupspawneddynents();
}

function function_c530afc5(angles) {
  if(function_61e2e743() == 400 || function_382c20a3() == 1) {
    if(level.doa.var_1a75d02b != 2) {
      return vectorscale((1, 0, 0), 88);
    }
    return (88, 180, 0);
  }
  return angles;
}

function function_be152c54() {
  if(function_61e2e743() == 400) {
    return 99;
  }
  return level.doa.arenas[level.doa.current_arena].var_aad78940;
}

function function_9f1a0b26(var_c3479584) {
  localplayers = getlocalplayers();
  if(localplayers.size > 1) {
    if(level.doa.arenas[level.doa.current_arena].var_dd94482c & 4) {
      return 2;
    }
  }
  var_44509e49 = level.doa.arenas[level.doa.current_arena].var_ecf7ec70;
  if(isDefined(var_44509e49)) {
    return var_44509e49;
  }
  if(isDefined(var_c3479584) && level.doa.arenas[level.doa.current_arena].var_dd94482c &(1 << var_c3479584)) {
    return var_c3479584;
  }
  return 0;
}

function function_61d60e0b() {
  if(isDefined(level.doa.arenas) && level.doa.arenas.size > 0) {
    return level.doa.arenas[level.doa.current_arena].center;
  }
  return (0, 0, 0);
}

function function_d2d75f5d() {
  return level.doa.arenas[level.doa.current_arena].name;
}

function function_22f2039b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.weatherfx) && isDefined(level.weatherfx[localclientnum])) {
    stopfx(localclientnum, level.weatherfx[localclientnum]);
    level.weatherfx[localclientnum] = 0;
  }
}

function function_9977953(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setworldfogactivebank(localclientnum, 0);
}

function function_836d1e22(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.doa.var_1a3f3152)) {
    stopradiantexploder(localclientnum, level.doa.var_1a3f3152);
    level.doa.var_1a3f3152 = undefined;
  }
  level.doa.var_d94564a5 = "morning";
  switch (newval) {
    case 0: {
      level.doa.var_d94564a5 = "morning";
      setworldfogactivebank(localclientnum, 1);
      break;
    }
    case 1: {
      level.doa.var_d94564a5 = "noon";
      setworldfogactivebank(localclientnum, 2);
      break;
    }
    case 2: {
      level.doa.var_d94564a5 = "dusk";
      setworldfogactivebank(localclientnum, 4);
      break;
    }
    case 3: {
      level.doa.var_d94564a5 = "night";
      setworldfogactivebank(localclientnum, 8);
      break;
    }
    default: {
      level.doa.var_d94564a5 = "morning";
      setworldfogactivebank(localclientnum, 1);
      break;
    }
  }
  if(function_d2d75f5d() == "temple" || function_d2d75f5d() == "tankmaze" || function_d2d75f5d() == "sgen" || function_d2d75f5d() == "blood" || function_d2d75f5d() == "vengeance" || function_d2d75f5d() == "boss") {
    setworldfogactivebank(localclientnum, 0);
  }
  level.doa.var_1a3f3152 = (("fx_exploder_" + level.doa.arenas[level.doa.current_arena].name) + "_") + level.doa.var_d94564a5;
  namespace_693feb87::debugmsg((("" + level.doa.var_1a3f3152) + "") + localclientnum);
  playradiantexploder(localclientnum, level.doa.var_1a3f3152);
  level function_43141563(localclientnum);
}

function function_43141563(localclientnum) {
  if(isDefined(level.var_1f314fb9)) {
    [[level.var_1f314fb9]](localclientnum, level.doa.arenas[level.doa.current_arena].name, level.doa.var_d94564a5);
  }
}

function setarena(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(level.doa.current_arena == newval && level.doa.var_95e3fdf9 != -1) {
    return;
  }
  level.doa.var_708cc739 = undefined;
  level notify("hash_ec7ca67b");
  namespace_693feb87::debugmsg((("" + level.doa.arenas[level.doa.current_arena].name) + "") + level.doa.arenas[newval].name);
  level.doa.var_95e3fdf9 = level.doa.current_arena;
  level.doa.current_arena = newval;
  if(level.doa.arenas[level.doa.current_arena].var_37d3a53b) {
    namespace_ad544aeb::function_d22ceb57(vectorscale((1, 0, 0), 75), function_61e2e743());
  } else {
    namespace_ad544aeb::function_d22ceb57(undefined, function_61e2e743());
  }
  cleanupspawneddynents();
  if(isDefined(level.doa.arenas[level.doa.current_arena].var_f3114f93)) {
    level thread[[level.doa.arenas[level.doa.current_arena].var_f3114f93]](localclientnum);
  }
  players = getlocalplayers();
  while(players.size == 0) {
    players = getlocalplayers();
    wait(0.016);
  }
  players[0].var_44509e49 = function_9f1a0b26(players[0].var_44509e49);
  function_986ae2b3(localclientnum);
  players[0] cameraforcedisablescriptcam(0);
}

function function_986ae2b3(localclientnum) {
  var_46caea66 = (level.doa.var_1a75d02b == 1 ? vectorscale((1, 0, 0), 75) : (75, 180, 0));
  namespace_ad544aeb::function_d22ceb57(function_c530afc5(var_46caea66), function_61e2e743());
  level function_43141563(localclientnum);
}