/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7d712f77ab8d0c16.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace spawning;

function function_a860c440(var_ef54e156) {
  level.var_c99a6ece = var_ef54e156;
}

function spawnpoint_debug() {
  a_spawnlists = getspawnlists();
  index = 0;

  foreach(s_list in a_spawnlists) {
    adddebugcommand("<dev string:x38>" + s_list + "<dev string:x66>" + index + "<dev string:x88>");
    index++;
  }

  adddebugcommand("<dev string:x38>" + "<dev string:x8d>" + "<dev string:x94>");
  adddebugcommand("<dev string:xba>");
  adddebugcommand("<dev string:x11c>");

  while(true) {
    spawnsystem_debug_command = getdvarstring(#"spawnsystem_debug_command");

    switch (spawnsystem_debug_command) {
      case # "next_best":
        selectedplayerindex = getdvarint(#"spawnsystem_debug_current_player", 0);

        foreach(player in level.players) {
          if(player getentitynumber() == selectedplayerindex) {
            selectedplayer = player;
            break;
          }
        }

        if(!isDefined(selectedplayer)) {
          continue;
        }

        point_team = selectedplayer.pers[# "team"];
        influencer_team = selectedplayer.pers[# "team"];
        vis_team_mask = util::getotherteamsmask(selectedplayer.pers[# "team"]);
        nextbestspawnpoint = getbestspawnpoint(point_team, influencer_team, vis_team_mask, selectedplayer, 0);
        selectedplayer setorigin(nextbestspawnpoint[# "origin"]);
        selectedplayer setplayerangles(nextbestspawnpoint[# "angles"]);
        break;
      case # "refresh":
        level flag::set(#"spawnpoints_dirty");
        break;
    }

    setDvar(#"spawnsystem_debug_command", "<dev string:x175>");
    wait 0.5;
  }
}

function function_df47057f(team, label, var_2f64048d, spawnpoints) {
  if(!spawnpoints.size) {
    return;
  }

  var_2e980658 = spawnStruct();
  var_2e980658.name = label + var_2f64048d;
  var_2e980658.spawns = spawnpoints;

  if(!isDefined(level.var_94f4ca81.dataset)) {
    level.var_94f4ca81.dataset = [];
  } else if(!isarray(level.var_94f4ca81.dataset)) {
    level.var_94f4ca81.dataset = array(level.var_94f4ca81.dataset);
  }

  level.var_94f4ca81.dataset[level.var_94f4ca81.dataset.size] = var_2e980658;
}

function function_25e7711a(list_type, team, label, var_2f64048d) {
  spawnpoints = function_82061144(list_type, team);
  function_df47057f(team, label, var_2f64048d, spawnpoints);
}

function function_48a6b85() {
  level endon(#"hash_47f3d9a9e91670d1");
  self endon(#"disconnect");
  dpad_left = 0;
  dpad_right = 0;
  dpad_up = 0;
  dpad_down = 0;

  if(!isDefined(level.var_94f4ca81)) {
    level.var_94f4ca81 = spawnStruct();
    level.var_94f4ca81.dataset = [];
    var_975467b9 = "<dev string:x179>";
    function_25e7711a("<dev string:x18d>", #"none", var_975467b9, "<dev string:x19c>");

    foreach(team, team_name in level.teams) {
      function_25e7711a("<dev string:x18d>", team, var_975467b9, team_name);
    }

    var_96a18257 = "<dev string:x1a4>";

    foreach(team, team_name in level.teams) {
      function_25e7711a("<dev string:x1b7>", team, var_96a18257, team_name);
    }

    if(isDefined(level.var_c99a6ece)) {
      [[level.var_c99a6ece]]();
    }
  }

  level.var_94f4ca81.teamfilter = "<dev string:x1c6>";
  level.var_94f4ca81.currentsetindex = 0;
  level.var_94f4ca81.currentspawnindex = 0;
  var_f94a23 = 0;

  while(true) {
    self setactionslot(3, "<dev string:x175>");
    self setactionslot(4, "<dev string:x175>");

    if(!dpad_up && (self buttonPressed("<dev string:x1ce>") || self buttonPressed("<dev string:x1d9>"))) {
      level.var_94f4ca81.currentsetindex++;

      if(level.var_94f4ca81.currentsetindex >= level.var_94f4ca81.dataset.size) {
        level.var_94f4ca81.currentsetindex = 0;
      }

      level.var_94f4ca81.currentspawnindex = 0;
      dpad_up = 1;
      var_f94a23 = 1;
    } else if(!self buttonPressed("<dev string:x1ce>") || self buttonPressed("<dev string:x1d9>")) {
      dpad_up = 0;
    }

    if(!dpad_down && (self buttonPressed("<dev string:x1e4>") || self buttonPressed("<dev string:x1f1>"))) {
      level.var_94f4ca81.currentsetindex--;

      if(level.var_94f4ca81.currentsetindex < 0) {
        level.var_94f4ca81.currentsetindex = level.var_94f4ca81.dataset.size - 1;
      }

      level.var_94f4ca81.currentspawnindex = 0;
      var_f94a23 = 1;
      dpad_down = 1;
    } else if(!self buttonPressed("<dev string:x1e4>") || self buttonPressed("<dev string:x1f1>")) {
      dpad_down = 0;
    }

    if(!dpad_left && (self buttonPressed("<dev string:x1fe>") || self buttonPressed("<dev string:x20b>"))) {
      while(true) {
        level.var_94f4ca81.currentspawnindex--;

        if(level.var_94f4ca81.currentspawnindex < 0) {
          level.var_94f4ca81.currentspawnindex = level.var_94f4ca81.dataset[level.var_94f4ca81.currentsetindex].spawns.size - 1;
        }

        if(!is_true(level.var_94f4ca81.dataset[level.var_94f4ca81.currentsetindex].spawns[level.var_94f4ca81.currentspawnindex].ct)) {
          break;
        }
      }

      var_f94a23 = 1;
      dpad_left = 1;
    } else if(!self buttonPressed("<dev string:x1fe>") || self buttonPressed("<dev string:x20b>")) {
      dpad_left = 0;
    }

    if(!dpad_right && (self buttonPressed("<dev string:x218>") || self buttonPressed("<dev string:x226>"))) {
      while(true) {
        level.var_94f4ca81.currentspawnindex++;

        if(level.var_94f4ca81.currentspawnindex >= level.var_94f4ca81.dataset[level.var_94f4ca81.currentsetindex].spawns.size) {
          level.var_94f4ca81.currentspawnindex = 0;
        }

        if(!is_true(level.var_94f4ca81.dataset[level.var_94f4ca81.currentsetindex].spawns[level.var_94f4ca81.currentspawnindex].ct)) {
          break;
        }
      }

      var_f94a23 = 1;
      dpad_right = 1;
    } else if(!self buttonPressed("<dev string:x218>") || self buttonPressed("<dev string:x226>")) {
      dpad_right = 0;
    }

    if(var_f94a23 && level.var_94f4ca81.dataset[level.var_94f4ca81.currentsetindex].spawns.size > 0) {
      origin = level.var_94f4ca81.dataset[level.var_94f4ca81.currentsetindex].spawns[level.var_94f4ca81.currentspawnindex].origin;
      angles = level.var_94f4ca81.dataset[level.var_94f4ca81.currentsetindex].spawns[level.var_94f4ca81.currentspawnindex].angles;
      println("<dev string:x234>" + level.var_94f4ca81.dataset[level.var_94f4ca81.currentsetindex].name);
      self setorigin(origin);
      self setplayerangles(angles);
      var_f94a23 = 0;
    }

    debug2dtext((100, 750, 0), "<dev string:x257>" + level.var_94f4ca81.dataset[level.var_94f4ca81.currentsetindex].name, (1, 0, 0));
    debug2dtext((100, 800, 0), "<dev string:x264>" + string(level.var_94f4ca81.currentspawnindex) + "<dev string:x26f>" + string(level.var_94f4ca81.dataset[level.var_94f4ca81.currentsetindex].spawns.size), (1, 0, 0));
    waitframe(1);
  }
}

function devgui_spawn_think() {
  self notify(#"devgui_spawn_think");
  self endon(#"devgui_spawn_think");
  self endon(#"disconnect");
  dpad_left = 0;
  dpad_right = 0;
  dpad_up = 0;
  dpad_down = 0;

  for(;;) {
    self setactionslot(3, "<dev string:x175>");
    self setactionslot(4, "<dev string:x175>");

    if(!dpad_left && (self buttonPressed("<dev string:x1fe>") || self buttonPressed("<dev string:x20b>"))) {
      setDvar(#"scr_playerwarp", "<dev string:x27b>");
      dpad_left = 1;
    } else if(!self buttonPressed("<dev string:x1fe>") || self buttonPressed("<dev string:x20b>")) {
      dpad_left = 0;
    }

    if(!dpad_right && (self buttonPressed("<dev string:x218>") || self buttonPressed("<dev string:x226>"))) {
      setDvar(#"scr_playerwarp", "<dev string:x289>");
      dpad_right = 1;
    } else if(!self buttonPressed("<dev string:x218>") || self buttonPressed("<dev string:x226>")) {
      dpad_right = 0;
    }

    if(!dpad_up && (self buttonPressed("<dev string:x1ce>") || self buttonPressed("<dev string:x1d9>"))) {
      setDvar(#"scr_playerwarp", "<dev string:x297>");
      dpad_up = 1;
    } else if(!self buttonPressed("<dev string:x1ce>") || self buttonPressed("<dev string:x1d9>")) {
      dpad_up = 0;
    }

    if(!dpad_down && (self buttonPressed("<dev string:x1e4>") || self buttonPressed("<dev string:x1f1>"))) {
      setDvar(#"scr_playerwarp", "<dev string:x2ab>");
      dpad_down = 1;
    } else if(!self buttonPressed("<dev string:x1e4>") || self buttonPressed("<dev string:x1f1>")) {
      dpad_down = 0;
    }

    waitframe(1);
  }
}