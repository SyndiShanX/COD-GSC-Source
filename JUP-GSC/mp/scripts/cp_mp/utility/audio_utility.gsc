/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\utility\audio_utility.gsc
******************************************************/

#using scripts\engine\utility;
#namespace audio_utility;

function snd_init() {
  if(!isDefined(level.snd)) {
    level.snd = spawnStruct();
    level.snd.objects = [];
    level.snd.unlinkedobjects = [];
    level.snd.fnplaysoundonmovingent = &playsoundonmovingent;
  }
}

function function_b3e5599c9f6a8895(obj) {
  assert(obj == level || isstruct(obj) || isent(obj));

  if(!isstruct(obj.snd)) {
    obj.snd = spawnStruct();
  }

  assertex(isstruct(obj.snd), "<dev string:x1c>");
}

function function_f0b5522ee5ce0cb1() {
  if(isstruct(level.snd)) {
    return true;
  }

  return false;
}

function function_40a17693396019a7() {
  while(function_f0b5522ee5ce0cb1() == 0) {
    waitframe();
  }
}

function private function_55f5473e977f265f(team_name) {
  players = [];

  if(isarray(level.teamdata) && isarray(level.teamdata[team_name]) && isarray(level.teamdata[team_name]["players"])) {
    players = level.teamdata[team_name]["players"];
  }

  return players;
}

function function_d6fe092bc83da45b(var_6e077719c0efcb61, radius, team_name) {
  origin = undefined;
  radius = default_to(radius, 240);
  team_name = default_to(team_name, "");
  players = [];

  if(isvector(var_6e077719c0efcb61)) {
    origin = var_6e077719c0efcb61;
  } else if(isent(var_6e077719c0efcb61)) {
    origin = var_6e077719c0efcb61.origin;
  }

  if(isvector(origin)) {
    regional_players = getentarrayinradius("player", "classname", origin, radius);

    foreach(player in regional_players) {
      if(isPlayer(player) && !isagent(player)) {
        if(team_name == "" || isstring(player.team) && player.team == team_name) {
          players[players.size] = player;
        }
      }
    }

    return players;
  } else {
    assertmsg("<dev string:x44>");
  }

  return players;
}

function function_ad9f5152bfdebcfe(gamekey, statekey, value) {
  assertex(isstring(gamekey), "<dev string:x82>");
  assertex(isstring(statekey), "<dev string:xae>");
  game[gamekey][statekey] = value;
}

function function_d05e164d112ab01(gamekey, statekey) {
  function_ad9f5152bfdebcfe(gamekey, statekey, undefined);
}

function function_9a0f23d8adcd6392(gamekey, statekey) {
  assertex(isstring(gamekey), "<dev string:xdb>");
  assertex(isstring(statekey), "<dev string:x107>");
  data = game[gamekey][statekey];
  return data;
}

function function_5cb73579174212fd(gamekey, statekey) {
  value = function_9a0f23d8adcd6392(gamekey, statekey);

  if(isarray(value)) {
    index = 0;

    if(value.size > 1) {
      index = randomintrange(0, value.size);
      assertex(index >= 0 && index < value.size, "<dev string:x134>" + index);
    }

    value = value[index];
  }

  return value;
}

function function_7acde5feb50c98f2(players, soundalias) {
  players = default_to(players, []);
  soundalias = default_to(soundalias, "");

  if(isarray(players)) {
    foreach(player in players) {
      if(isPlayer(player) && !isagent(player)) {
        player playlocalsound(soundalias);
      }
    }

    return;
  }

  assertmsg("<dev string:x165>");
}

function function_66f41f0823bd279c(players, soundalias) {
  players = default_to(players, []);
  soundalias = default_to(soundalias, "");

  if(isarray(players)) {
    foreach(player in players) {
      if(isPlayer(player) && !isagent(player)) {
        player stoplocalsound(soundalias);
      }
    }

    return;
  }

  assertmsg("<dev string:x19a>");
}

function function_a408e30ca85e03a9(players, zonename, fadetime) {
  players = default_to(players, []);
  zonename = default_to(zonename, "");
  fadetime = default_to(fadetime, 1);

  if(isarray(players)) {
    assertex(isstring(zonename), "<dev string:x1cf>");
    assertex(isnumber(fadetime), "<dev string:x20c>");

    foreach(player in players) {
      if(isPlayer(player) && !isagent(player)) {
        player setclienttriggeraudiozone(zonename, fadetime);
      }
    }

    return;
  }

  assertmsg("<dev string:x249>");
}

function function_326e5ed05234a4f0(players, fadetime) {
  players = default_to(players, []);
  fadetime = default_to(fadetime, 1);

  if(isarray(players)) {
    assertex(isnumber(fadetime), "<dev string:x286>");

    foreach(player in players) {
      if(isPlayer(player) && !isagent(player)) {
        player clearclienttriggeraudiozone(fadetime);
      }
    }

    return;
  }

  assertmsg("<dev string:x2c5>");
}

function setmusicset(musicset, value) {
  function_ad9f5152bfdebcfe("music", musicset, value);
}

function getmusicset(musicset) {
  state = function_9a0f23d8adcd6392("music", musicset);

  if(isarray(state)) {
    if(state.size == 0) {
      state = undefined;
    } else {
      state = state[0];
    }
  } else if(!isstring(state)) {
    state = undefined;
  }

  if(!isDefined(state)) {
    return "";
  }

  return state;
}

function function_17ee301cf0b5ba85(musicset) {
  state = function_5cb73579174212fd("music", musicset);

  if(!isDefined(state) || !isstring(state)) {
    return "";
  }

  return state;
}

function function_5df2f278f44a6ffd(style) {
  if(isstring(style) && isDefined(level.music_style) && isstring(level.music_style) && level.music_style == style) {
    return true;
  }

  return false;
}

function function_fe75a89529dd0fd0(players, var_9adc1bcdce9cf8b0, var_c342527a25f10cc5, except, var_206c8dfdb8c43d68) {
  players = default_to(players, []);
  var_9adc1bcdce9cf8b0 = default_to(var_9adc1bcdce9cf8b0, "");
  var_206c8dfdb8c43d68 = default_to(var_206c8dfdb8c43d68, "");

  if(isDefined(level.var_973185176be76120)) {
    level thread[[level.var_973185176be76120]](players, var_9adc1bcdce9cf8b0, var_c342527a25f10cc5);
    return;
  }

  if(isarray(players)) {
    foreach(player in players) {
      if(isPlayer(player) && !isagent(player)) {
        if(var_9adc1bcdce9cf8b0 == "" && isDefined(except)) {
          player function_9bb444fe81766f7e(except);
          continue;
        }

        if(isarray(var_c342527a25f10cc5)) {
          player setplayermusicstate(var_9adc1bcdce9cf8b0, var_c342527a25f10cc5);
          continue;
        }

        if(isDefined(player.musicpack) && player.musicpack == 1) {
          player setplayermusicstate(var_206c8dfdb8c43d68);
          continue;
        }

        player setplayermusicstate(var_9adc1bcdce9cf8b0);
      }
    }

    return;
  }

  assertmsg("<dev string:x304>");
}

function function_46979d2fd81a6d4b(team_name, var_9adc1bcdce9cf8b0, var_c342527a25f10cc5, var_206c8dfdb8c43d68) {
  team_name = default_to(team_name, "");
  var_9adc1bcdce9cf8b0 = default_to(var_9adc1bcdce9cf8b0, "");
  var_206c8dfdb8c43d68 = default_to(var_206c8dfdb8c43d68, "");
  players = function_55f5473e977f265f(team_name);
  function_fe75a89529dd0fd0(players, var_9adc1bcdce9cf8b0, var_c342527a25f10cc5, undefined, var_206c8dfdb8c43d68);
}

function function_fdd0934f1a32f70d(var_6e077719c0efcb61, radius, var_9adc1bcdce9cf8b0, team_name, var_c342527a25f10cc5, var_206c8dfdb8c43d68) {
  var_9adc1bcdce9cf8b0 = default_to(var_9adc1bcdce9cf8b0, "");
  var_206c8dfdb8c43d68 = default_to(var_206c8dfdb8c43d68, "");
  players = function_d6fe092bc83da45b(var_6e077719c0efcb61, radius, team_name);
  function_fe75a89529dd0fd0(players, var_9adc1bcdce9cf8b0, var_c342527a25f10cc5, undefined, var_206c8dfdb8c43d68);
}

function function_4e8ba327eb12540c(players, submix_name, fadetime, scale) {
  players = default_to(players, []);
  submix_name = default_to(submix_name, "");
  fadetime = default_to(fadetime, -1);
  scale = default_to(scale, 1);

  if(isarray(players)) {
    foreach(player in players) {
      if(isPlayer(player) && !isagent(player)) {
        player setsoundsubmix(submix_name, fadetime, scale);
      }
    }

    return;
  }

  assertmsg("<dev string:x339>");
}

function function_c7f38d0611aa82e7(team_name, submix_name, fadetime, scale) {
  submix_name = default_to(submix_name, "");
  team_name = default_to(team_name, "");
  players = function_55f5473e977f265f(team_name);
  function_4e8ba327eb12540c(players, submix_name, fadetime, scale);
}

function function_c79f9300ee85f805(players, submix_name, fadetime) {
  players = default_to(players, []);
  submix_name = default_to(submix_name, "");
  fadetime = default_to(fadetime, -1);

  if(isarray(players)) {
    foreach(player in players) {
      player clearsoundsubmix(submix_name, fadetime);
    }

    return;
  }

  assertmsg("<dev string:x339>");
}

function function_e3a3a924d8604018(team_name, submix_name, fadetime, scale) {
  submix_name = default_to(submix_name, "");
  team_name = default_to(team_name, "");
  players = function_55f5473e977f265f(team_name);
  function_c79f9300ee85f805(players, submix_name, fadetime);
}

function function_110d3ab280057f5b(condition, alerttext) {
  if(istrue(condition)) {
    println(alerttext);
  }

  return condition;
}

function private function_5b159f140bd186df() {
  function_40a17693396019a7();

  if(!isarray(level.snd.transient_banks)) {
    level.snd.transient_banks = [];
  }

  if(!isent(level.snd.var_4388174fd6467686)) {
    level.snd.var_4388174fd6467686 = spawn("sound_transient_soundbanks", (0, 0, 0));
  }
}

function function_1186ca4e2e51afea(name) {
  if(isstruct(level.snd) && isDefined(level.snd.transient_banks) && isDefined(level.snd.transient_banks[name])) {
    return true;
  }

  return false;
}

function snd_transient_load(name) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  function_5b159f140bd186df();
  assert(function_f0b5522ee5ce0cb1());
  assert(isent(level.snd.var_4388174fd6467686));
  assert(isarray(level.snd.transient_banks));
  assertex(isstring(name), "<dev string:x36a>");
  isloaded = function_1186ca4e2e51afea(name);

  if(function_110d3ab280057f5b(isloaded, "snd_transient_load loaded '" + name + "'")) {
    return;
  }

  level.snd.var_4388174fd6467686 settransientsoundbank(name + ".all", 1);
  level.snd.transient_banks[name] = level.snd.transient_banks.size;
}

function snd_transient_unload(name) {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  function_5b159f140bd186df();
  assert(function_f0b5522ee5ce0cb1());
  assert(isent(level.snd.var_4388174fd6467686));
  assert(isarray(level.snd.transient_banks));
  assertex(isstring(name), "<dev string:x399>");
  isloaded = function_1186ca4e2e51afea(name);

  if(function_110d3ab280057f5b(!isloaded, "snd_transient_unload '" + name + "' not loaded")) {
    return;
  }

  level.snd.var_4388174fd6467686 settransientsoundbank(name + ".all", 0);
  level.snd.transient_banks[name] = undefined;
}