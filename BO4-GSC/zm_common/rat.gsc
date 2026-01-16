/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\rat.gsc
***********************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\rat_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace rat;

autoexec __init__system__() {
  system::register(#"rat", &__init__, undefined, undefined);
}

__init__() {
  init();
  level.rat.common.gethostplayer = &util::gethostplayer;
  addratscriptcmd("<dev string:x38>", &derriesezombiespawnnavmeshtest);
  addratscriptcmd("<dev string:x4e>", &function_b8181e0d);
  addratscriptcmd("<dev string:x59>", &function_38d6a592);
  addratscriptcmd("<dev string:x65>", &function_ff8061ca);
  addratscriptcmd("<dev string:x71>", &function_1428d95e);
  addratscriptcmd("<dev string:x87>", &function_63a39134);
  addratscriptcmd("<dev string:x9c>", &function_26a15f4d);
  addratscriptcmd("<dev string:xac>", &function_3d37c034);
  addratscriptcmd("<dev string:xbf>", &function_7a11ca68);
  addratscriptcmd("<dev string:xd6>", &function_782c6850);
  addratscriptcmd("<dev string:xeb>", &function_125e2d8d);
  addratscriptcmd("<dev string:x102>", &function_e7dffcf9);
  addratscriptcmd("<dev string:x117>", &function_c3aa7d01);
  addratscriptcmd("<dev string:x12a>", &function_684f2efb);
  addratscriptcmd("<dev string:x143>", &function_123195b9);
  addratscriptcmd("<dev string:x15a>", &function_c79c0501);
  addratscriptcmd("<dev string:x167>", &function_3bbff2c5);
  addratscriptcmd("<dev string:x17b>", &function_ea4b3f00);
  addratscriptcmd("<dev string:x18f>", &function_8f340c78);
  addratscriptcmd("<dev string:x1a7>", &function_1bd3da0f);
  addratscriptcmd("<dev string:x1b8>", &function_6ea9a113);
  addratscriptcmd("<dev string:x1cd>", &function_e2143adf);
  addratscriptcmd("<dev string:x1e2>", &function_ff8f5737);
  addratscriptcmd("<dev string:x200>", &function_5b9ddfdb);
  addratscriptcmd("<dev string:x21b>", &function_d49caa1a);
  addratscriptcmd("<dev string:x238>", &function_d52c7fc3);
  addratscriptcmd("<dev string:x253>", &function_d87f9fe1);
  addratscriptcmd("<dev string:x264>", &function_94ac25d9);
  addratscriptcmd("<dev string:x27b>", &function_a6f7ea4a);
  addratscriptcmd("<dev string:x295>", &function_303319e9);
  addratscriptcmd("<dev string:x2b1>", &function_e1bdc812);
}

function_e1bdc812(params) {
  return zm_trial::function_ba9853db();
}

function_303319e9(params) {
  zombies = getaiarchetypearray("<dev string:x2c4>", level.zombie_team);
  player = getplayer(params);
  forward = anglesToForward(player.angles);
  distance = 25;

  if(isDefined(params.distance)) {
    distance = float(params.distance);
  }

  spawn = player.origin + forward * distance;

  foreach(zombie in zombies) {
    zombie forceteleport(spawn, player.angles);

    if(isDefined(params.is_dummy) && params.is_dummy == 1) {
      zombie pathmode("<dev string:x2cd>");
    }
  }
}

function_a6f7ea4a(params) {
  zombie_utility::set_zombie_var(#"rebuild_barrier_cap_per_round", 2147483647);
}

function_94ac25d9(params) {
  windows = level.exterior_goals;

  if(isDefined(windows)) {
    foreach(window in windows) {
      origin = window.origin;
      function_55e20e75(params._id, origin);
      angles = window.angles;
      function_55e20e75(params._id, angles);
    }
  }
}

function_8f340c78(params) {
  chests = level.chests;

  if(isDefined(chests)) {
    foreach(chest in chests) {
      if(chest.hidden == 0) {
        origin = chest.origin;
        function_55e20e75(params._id, origin);
        angles = (chest.angles[0], chest.angles[1] - 90, chest.angles[2]);
        function_55e20e75(params._id, angles);
        break;
      }
    }
  }
}

function_d52c7fc3(params) {
  for(i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
    triggerstub = level._unitriggers.trigger_stubs[i];

    if(isDefined(triggerstub.script_noteworthy)) {
      if(triggerstub.script_noteworthy == "<dev string:x2d9>" || triggerstub.script_noteworthy == "<dev string:x2e4>") {
        origin = (triggerstub.origin[0], triggerstub.origin[1], triggerstub.origin[2]);
        function_55e20e75(params._id, origin);
        angles = (triggerstub.angles[0], triggerstub.angles[1], triggerstub.angles[2]);
        function_55e20e75(params._id, angles);
      }
    }
  }
}

function_d87f9fe1(params) {
  host = util::gethostplayer();
  return isDefined(host.var_4e90ce0c);
}

function_6ea9a113(params) {
  foreach(items in level.item_spawns) {
    foreach(item in items) {
      if(isDefined(item)) {
        offset = (item.origin[0], item.origin[1], item.origin[2]);
        function_55e20e75(params._id, offset);
        forward = item.origin - offset;
        angle = vectornormalize(forward);
        angles = (item.angles[0], item.angles[1], item.angles[2]);
        function_55e20e75(params._id, angles);
      }
    }
  }
}

function_ff8f5737(params) {
  for(i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
    triggerstub = level._unitriggers.trigger_stubs[i];

    if(isDefined(triggerstub.target)) {
      if(triggerstub.target == "<dev string:x2ef>") {
        origin = (triggerstub.origin[0], triggerstub.origin[1], triggerstub.origin[2]);
        function_55e20e75(params._id, origin);
        angles = (triggerstub.angles[0], triggerstub.angles[1] + 180, triggerstub.angles[2]);
        function_55e20e75(params._id, angles);
      }
    }
  }
}

function_5b9ddfdb(params) {
  for(i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
    triggerstub = level._unitriggers.trigger_stubs[i];

    if(isDefined(triggerstub.target)) {
      if(triggerstub.target == "<dev string:x2fe>") {
        origin = (triggerstub.origin[0], triggerstub.origin[1], triggerstub.origin[2]);
        function_55e20e75(params._id, origin);
        angles = (triggerstub.angles[0], triggerstub.angles[1] + 180, triggerstub.angles[2]);
        function_55e20e75(params._id, angles);
      }
    }
  }
}

function_e2143adf(params) {
  if(isDefined(level.item_inventory)) {
    return level.item_inventory.size;
  }

  return 0;
}

function_1bd3da0f(params) {
  chunks = level.s_pap_quest.a_s_locations;

  if(isDefined(chunks)) {
    foreach(chunk in chunks) {
      origin = (chunk.origin[0], chunk.origin[1] - 40, chunk.origin[2] - 40);
      function_55e20e75(params._id, origin);
      angles = (chunk.angles[0], chunk.angles[1] + 180, chunk.angles[2]);
      function_55e20e75(params._id, angles);
    }
  }
}

function_d49caa1a(params) {
  return level.s_pap_quest.var_be6e6f65;
}

function_ea4b3f00(params) {
  host = util::gethostplayer();
  skip = 0;

  if(isDefined(params.var_f870f386)) {
    if(params.var_f870f386 == "<dev string:x30a>") {
      skip = 1;
    }
  }

  players = getplayers();

  foreach(player in players) {
    if(skip) {
      if(player != host) {
        player enableinvulnerability();
      }

      continue;
    }

    skip = 0;
  }
}

function_c79c0501(params) {
  if(isDefined(params.round)) {
    setdvar(#"scr_zombie_round", int(params.round));
    adddebugcommand("<dev string:x311>");
  }
}

function_3bbff2c5(params) {
  num = 3;

  if(isDefined(params.num)) {
    num = int(params.num);
  }

  if(num > 0) {
    adddebugcommand("<dev string:x327>" + num);
  }
}

function_123195b9(params) {}

function_684f2efb(params) {
  trigs = getEntArray("<dev string:x346>", "<dev string:x358>");

  foreach(ent in trigs) {
    ent_parts = getEntArray(ent.target, "<dev string:x358>");

    foreach(e in ent_parts) {
      if(isDefined(e.script_noteworthy) && e.script_noteworthy == "<dev string:x365>") {
        master_switch = e;
        function_55e20e75(params._id, master_switch.origin);
        angles = (master_switch.angles[0], master_switch.angles[1], master_switch.angles[2]);
        function_55e20e75(params._id, angles);
        break;
      }
    }
  }
}

function_c3aa7d01(params) {
  player = util::gethostplayer();

  if(isDefined(player)) {
    if(isDefined(player.perk_purchased)) {
      return player.perk_purchased;
    }
  }
}

function_125e2d8d(params) {
  zombie_doors = getEntArray("<dev string:x375>", "<dev string:x358>");
  count = 0;

  if(isDefined(zombie_doors)) {
    for(i = 0; i < zombie_doors.size; i++) {
      if(isDefined(zombie_doors[i].purchaser)) {
        count++;
      }
    }
  }

  return count;
}

function_e7dffcf9(params) {
  zombie_doors = getEntArray("<dev string:x375>", "<dev string:x358>");

  if(isDefined(zombie_doors)) {
    for(i = 0; i < zombie_doors.size; i++) {
      door = zombie_doors[i];

      if(isDefined(door.script_noteworthy)) {
        if(door.script_noteworthy == "<dev string:x383>" && door._door_open == 0) {
          function_55e20e75(params._id, door.origin);
          angles = (door.angles[0], door.angles[1] + 90, door.angles[2]);
          function_55e20e75(params._id, angles);
        }
      }
    }
  }
}

function_7a11ca68(params) {
  for(i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
    triggerstub = level._unitriggers.trigger_stubs[i];

    if(triggerstub.cursor_hint == "<dev string:x38d>") {
      origin = triggerstub zm_unitrigger::unitrigger_origin();
      origin = (origin[0], origin[1], origin[2] - 40);
      function_55e20e75(params._id, origin);
      angles = triggerstub.angles;
      angles = (angles[0], angles[1] - 90, angles[2]);
      function_55e20e75(params._id, angles);
    }
  }
}

function_782c6850(params) {
  for(i = 0; i < level._unitriggers.trigger_stubs.size; i++) {
    triggerstub = level._unitriggers.trigger_stubs[i];

    if(isDefined(triggerstub.hint_string) && triggerstub.hint_string == "<dev string:x39b>") {
      origin = triggerstub zm_unitrigger::unitrigger_origin();
      function_55e20e75(params._id, origin);
      angles = triggerstub.angles;
      angles = (angles[0], angles[1] + 180, angles[2]);
      function_55e20e75(params._id, angles);
    }
  }
}

function_3d37c034(params) {
  a_e_players = getplayers();

  foreach(e_player in a_e_players) {
    if(isDefined(e_player.intermission) || e_player.sessionstate == "<dev string:x3ad>" || e_player.sessionstate == "<dev string:x3b9>") {
      continue;
    }

    return 1;
  }

  return 0;
}

function_38d6a592(params) {
  setdvar(#"zombie_cheat", 2);
}

function_26a15f4d(params) {
  setdvar(#"zombie_cheat", 0);
}

function_1428d95e(params) {
  player = util::gethostplayer();
  forward = anglesToForward(player.angles);
  spawn = player.origin + forward * 10;
  zombie = zm_devgui::devgui_zombie_spawn();

  if(isDefined(zombie)) {
    zombie forceteleport(spawn, player.angles + (0, 180, 0));
    zombie pathmode("<dev string:x2cd>");
  }
}

function_63a39134(params) {
  return zombie_utility::get_current_zombie_count();
}

function_b8181e0d(params) {
  player = util::gethostplayer();
  return player.score;
}

function_ff8061ca(params) {
  if(isDefined(level.power_local_doors_globally)) {
    return 1;
  }

  return 0;
}

derriesezombiespawnnavmeshtest(params, inrat) {
  if(!isDefined(inrat)) {
    inrat = 1;
  }

  if(inrat) {
    wait 10;
  }

  enemy = zm_devgui::devgui_zombie_spawn();
  enemy.is_rat_test = 1;
  failed_spawn_origin = [];
  failed_node_origin = [];
  failed_attack_spot_spawn_origin = [];
  failed_attack_spot = [];
  size = 0;
  failed_attack_spot_size = 0;
  wait 0.2;

  foreach(zone in level.zones) {
    foreach(loc in zone.a_loc_types[#"zombie_location"]) {
      angles = (0, 0, 0);
      enemy forceteleport(loc.origin, angles);
      wait 0.2;
      node = undefined;

      for(j = 0; j < level.exterior_goals.size; j++) {
        if(isDefined(level.exterior_goals[j].script_string) && level.exterior_goals[j].script_string == loc.script_string) {
          node = level.exterior_goals[j];
        }
      }

      if(isDefined(node)) {
        ispath = enemy setgoal(node.origin);

        if(!ispath) {
          failed_spawn_origin[size] = loc.origin;
          failed_node_origin[size] = node.origin;
          size++;
        }

        wait 0.2;

        for(j = 0; j < node.attack_spots.size; j++) {
          isattackpath = enemy setgoal(node.attack_spots[j]);

          if(!isattackpath) {
            failed_attack_spot_spawn_origin[failed_attack_spot_size] = loc.origin;
            failed_attack_spot[failed_attack_spot_size] = node.attack_spots[j];
            failed_attack_spot_size++;
          }

          wait 0.2;
        }
      }
    }
  }

  if(inrat) {
    errmsg = "<dev string:x3c8>";

    for(i = 0; i < size; i++) {
      errmsg += "<dev string:x3e2>" + failed_spawn_origin[i] + "<dev string:x3ed>" + failed_node_origin[i] + "<dev string:x3f8>";
    }

    for(i = 0; i < failed_attack_spot_size; i++) {
      errmsg += "<dev string:x3e2>" + failed_attack_spot_spawn_origin[i] + "<dev string:x3fd>" + failed_attack_spot[i] + "<dev string:x3f8>";
    }

    if(size > 0 || failed_attack_spot_size > 0) {
      ratreportcommandresult(params._id, 0, errmsg);
      return;
    }

    ratreportcommandresult(params._id, 1);
  }
}

