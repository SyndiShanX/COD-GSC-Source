/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_294dda4a4b00ffe3.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_dev;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_publicevents;
#using scripts\mp\utility\script;
#namespace namespace_b354cc7ab3b869b0;

function init() {
  level.var_adaaed38371fa15b = spawnStruct();
  level.var_adaaed38371fa15b.timescompleted = 0;
  level.var_adaaed38371fa15b.state = 0;
  level.var_adaaed38371fa15b.targets = function_76e26aff7dcf2a6a();

  if(function_afea038c5c9f1209()) {
    level.var_adaaed38371fa15b.var_d4622dbffcad86c = function_276be8b8ea7b9da7();
  }

  level.var_adaaed38371fa15b.timer = spawnStruct();
  level.var_adaaed38371fa15b.timer.duration = level.var_adaaed38371fa15b.targets[0];
  thread function_727b37a4211441b8();

  function_5c4de7736363bf0c();
}

function function_4ad287e0971672a6() {
  return getdvarint(@ "hash_4558abf9d259b284", 0) > 0;
}

function function_afea038c5c9f1209() {
  return getdvarint(@ "hash_a973ab15ba11d2ba", 1) > 0;
}

function function_76e26aff7dcf2a6a() {
  var_24abc960b59e06d0 = getDvar(@ "hash_bc9d24d7d03581e3", "0 0 0");
  var_4feae575ce34efa0 = [];

  if(var_24abc960b59e06d0 != "") {
    var_394d57a3c2ae52af = strtok(var_24abc960b59e06d0, " ");

    foreach(target in var_394d57a3c2ae52af) {
      targetvalue = int(target);
      var_4feae575ce34efa0[var_4feae575ce34efa0.size] = targetvalue;
    }
  }

  return var_4feae575ce34efa0;
}

function function_8be9bae8228a91f7(eventname) {
  var_ae18d736d9768b9a = getDvar(hashcat(@ "hash_abb46656d4b7e51c", eventname, "_pe_meter_event_weights"), "0 0 0 0 0 0 0 0");
  var_b9b56551e1acfee2 = [];

  if(var_ae18d736d9768b9a != "") {
    var_ddcea577bbdd75b0 = strtok(var_ae18d736d9768b9a, " ");

    foreach(weight in var_ddcea577bbdd75b0) {
      var_b9b56551e1acfee2[var_b9b56551e1acfee2.size] = float(weight);
    }
  }

  return var_b9b56551e1acfee2;
}

function private function_276be8b8ea7b9da7() {
  var_d4622dbffcad86c = spawnStruct();
  var_d4622dbffcad86c.eventtypes = [];
  var_b47e0ed9ba26b84f = getDvar(@ "hash_279e65fda89136b4", "");
  var_f4ef4ad8c3051332 = strtok(var_b47e0ed9ba26b84f, ",");

  if(var_f4ef4ad8c3051332.size == 0) {
    scripts\mp\utility\script::demoforcesre("Public Event Meters: No predetermined public events set! Set dvar 'scr_br_pe_meter_predetermined_events'");
    return undefined;
  }

  for(i = 0; i < var_f4ef4ad8c3051332.size; i++) {
    var_d4622dbffcad86c.eventtypes[i] = [];
    var_b8a9ecc1bbd4ad93 = strtok(var_f4ef4ad8c3051332[i], " ");

    foreach(event in var_b8a9ecc1bbd4ad93) {
      if(event.size == 0) {
        continue;
      }

      var_d4622dbffcad86c.eventtypes[i][var_d4622dbffcad86c.eventtypes[i].size] = getxhashasset(event);
    }
  }

  return var_d4622dbffcad86c;
}

function function_c6b950c21813b5cd() {
  meterlevel = level.var_adaaed38371fa15b.timescompleted;
  meterlevel = clamp(meterlevel, 0, level.var_adaaed38371fa15b.targets.size - 1);
  return int(meterlevel);
}

function function_3168dda92f94de9c() {
  endtime = level.var_adaaed38371fa15b.timer.endtime;
  currenttime = gettime();

  if(!isDefined(endtime) || currenttime >= endtime) {
    return undefined;
  }

  meterlevel = function_c6b950c21813b5cd();
  duration = level.var_adaaed38371fa15b.targets[meterlevel];
  timedifference = endtime - currenttime;
  return timedifference / duration * 1000;
}

function function_989d407ad1798eb0() {
  if(!istrue(level.var_adaaed38371fa15b.var_4d2460299ca3ab25)) {
    return false;
  }

  return level.var_adaaed38371fa15b.timescompleted > level.var_adaaed38371fa15b.targets.size - 1;
}

function private function_727b37a4211441b8() {
  level endon("cancel_public_event");
  scripts\mp\flags::gameflagwait("prematch_done");
  function_b25d69ba35a863c8(1);
  thread function_6ea8115fc5f81bbd();
}

function private function_2d3ba92b45fb796e() {
  meterlevel = function_c6b950c21813b5cd();

  if(function_afea038c5c9f1209()) {
    if(scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "zxp") {
      eventtypes = level.var_adaaed38371fa15b.var_d4622dbffcad86c.eventtypes[0];
    } else {
      eventtypes = level.var_adaaed38371fa15b.var_d4622dbffcad86c.eventtypes[meterlevel];
    }

    foreach(eventtype in eventtypes) {
      if(scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "zxp") {
        level.var_5042ca82b8056c6c = undefined;
        level.var_120b80961427b421 = undefined;
        level thread scripts\mp\gametypes\br_public::brleaderdialog("zxp_infestationStart");
      }

      level thread scripts\mp\gametypes\br_publicevents::runpubliceventoftype(eventtype, 1, meterlevel, 1);
    }
  } else {
    level thread scripts\mp\gametypes\br_publicevents::choosepubliceventtype(1, meterlevel, 1);
  }

  level.var_adaaed38371fa15b.timescompleted += 1;
}

function private function_6ea8115fc5f81bbd() {
  level endon("game_ended");

  while(true) {
    meterlevel = function_c6b950c21813b5cd();
    target = level.var_adaaed38371fa15b.targets[meterlevel];
    endtime = gettime() + target * 1000;
    function_b25d69ba35a863c8(1);
    function_793358077b37fb75(endtime);
    function_8e5a2527f76e9ba4(target);

    while(gettime() < level.var_adaaed38371fa15b.timer.endtime || level.var_adaaed38371fa15b.state == 0) {
      if(scripts\cp_mp\utility\game_utility::function_6c1fce6f6b8779d5() == "zxp") {
        currenttime = gettime();

        if(level.var_adaaed38371fa15b.timer.endtime - currenttime < target * 1000 / 2 && !isDefined(level.var_5042ca82b8056c6c)) {
          level.var_5042ca82b8056c6c = 1;
          level thread scripts\mp\gametypes\br_public::brleaderdialog("zxp_infestationTimerHalf");
        } else if(level.var_adaaed38371fa15b.timer.endtime - currenttime < 20000 && !isDefined(level.var_120b80961427b421)) {
          level.var_120b80961427b421 = 1;
          level thread scripts\mp\gametypes\br_public::brleaderdialog("zxp_infestationTimerLow");
        }
      }

      wait 0.1;
    }

    function_b25d69ba35a863c8(2);
    function_2d3ba92b45fb796e();

    while(scripts\mp\gametypes\br_publicevents::function_7ddadb6d5643bee4()) {
      level waittill_any_2("br_pe_end", "cancel_public_event");
    }

    waitframe();
  }
}

function function_d24f2dd28d26377e(seconds) {
  if(!isDefined(seconds) || seconds == 0 || !isDefined(level.var_adaaed38371fa15b.timer.endtime)) {
    return;
  }

  endtime = level.var_adaaed38371fa15b.timer.endtime;
  endtime += seconds * 1000;
  function_793358077b37fb75(endtime);
}

function private function_b25d69ba35a863c8(state) {
  if(!isDefined(state) || level.var_adaaed38371fa15b.state == state) {
    return;
  }

  assert(-1, "<dev string:x1c>");
  level.var_adaaed38371fa15b.state = state;
  scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3("ui_br_pe_meter_data", 0, 2, state);
}

function private function_793358077b37fb75(endtime) {
  level.var_adaaed38371fa15b.timer.endtime = endtime;
  secondsendtime = int(endtime / 1000);
  scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3("ui_br_pe_meter_data", 2, 11, secondsendtime);
}

function private function_8e5a2527f76e9ba4(duration) {
  level.var_adaaed38371fa15b.timer.duration = duration;
  scripts\cp_mp\utility\omnvar_utility::function_d3cf7ff1a257e2c3("ui_br_pe_meter_data", 13, 8, duration);
}

function function_5c4de7736363bf0c() {
  scripts\mp\gametypes\br_dev::registerhandlecommand(&function_19410406f863b78f);
}

function private function_19410406f863b78f(cmd, args) {
  if(cmd != "<dev string:x7b>") {
    return;
  }

  switch (args[0]) {
    case #"hash_c61546c10a51754":
      function_d24f2dd28d26377e(int(args[1]));
      break;
    case #"hash_e9545d0bee0d374a":
      level.var_adaaed38371fa15b.timescompleted = int(args[1]);
      break;
    default:
      break;
  }
}

# /