/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\activities_util.csc
***********************************************/

#using scripts\core_common\util_shared;
#namespace activities;

function private function_10de102b(outcome = "failed") {
  foreach(player in getlocalplayers()) {
    player function_4877c948(level.activities.mapname, outcome);
  }

  level.activities = undefined;
}

function private function_4c80102b() {
  foreach(player in getlocalplayers()) {
    player function_bbe3235(level.activities.mapname, level.activities.gametype, player getchrname(), level.activities.difficulty);
  }
}

function private function_be258f26() {}

function private function_1c01a227(task) {
  level.activities.var_31ac96bc = task;

  foreach(player in getlocalplayers()) {
    player function_cb812d61(task, level.activities.difficulty);
  }
}

function private function_2c46b6f9(outcome) {
  foreach(player in getlocalplayers()) {
    player function_7a093b3b(level.activities.var_31ac96bc, outcome);
  }
}

function private event_handler[event_6ba27c50] function_83a031fd(eventstruct) {
  if(isDefined(level.activities)) {
    function_2c46b6f9("failed");
    function_1c01a227(level.activities.var_31ac96bc);
  }
}

function private event_handler[systemstatechange] function_406f0371(eventstruct) {
  if(eventstruct.system == "a:obj") {
    s = strtok(eventstruct.state, ",");

    switch (s[0]) {
      case # "0":
        levelname = s[4];
      case # "1":
        task = s[1];
        world.gameskill = int(s[2]);
        var_6dfed201 = int(s[3]);
        break;
      default:
        return;
    }

    if(!isDefined(level.activities)) {
      if(!isDefined(levelname)) {
        levelname = util::get_map_name();
      }

      level.activities = {
        #mapname: levelname, #gametype: getDvar(#"g_gametype")
      };
    }

    if(!isDefined(level.activities.difficulty)) {
      level.activities.difficulty = world.gameskill;
    } else if(world.gameskill != level.activities.difficulty) {
      level.activities.difficulty = world.gameskill;
      function_2c46b6f9("failed");
      function_1c01a227(level.activities.var_31ac96bc);
    }

    if(isDefined(level.activities.var_31ac96bc)) {
      function_2c46b6f9("completed");
    } else if(var_6dfed201) {
      function_be258f26();
    } else {
      function_4c80102b();
    }

    if(task == "_exit") {
      function_10de102b("completed");
      return;
    }

    function_1c01a227(task);
  }
}