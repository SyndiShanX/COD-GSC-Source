/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6708b08fd2751700.gsc
***********************************************/

#using script_2618e0f3e5e11649;
#using script_3411bb48d41bd3b;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\bots\bot;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\rat_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\objective_manager;
#namespace rat;

function private autoexec __init__system__() {
  system::register(#"hash_2a909a3d7374cf00", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init();
  level.rat.common.gethostplayer = &util::gethostplayer;
  level.rat.deathcount = 0;
  addratscriptcmd("<dev string:x38>", &function_70f41194);
  addratscriptcmd("<dev string:x55>", &function_31980089);
  addratscriptcmd("<dev string:x67>", &function_1251949b);
  addratscriptcmd("<dev string:x7c>", &function_684893c8);
  addratscriptcmd("<dev string:x8f>", &function_7eabbc02);
  addratscriptcmd("<dev string:x9d>", &function_d50abf44);
  addratscriptcmd("<dev string:xb0>", &function_89684f6a);
  addratscriptcmd("<dev string:xc7>", &function_baeffaeb);
  addratscriptcmd("<dev string:xd8>", &function_63a39134);
  addratscriptcmd("<dev string:xee>", &function_d19f7fe9);
  addratscriptcmd("<dev string:x107>", &function_2bd96c6e);
  addratscriptcmd("<dev string:x12a>", &function_ee280019);
  addratscriptcmd("<dev string:x158>", &function_40e4c9de);
  addratscriptcmd("<dev string:x17d>", &function_fea33619);
  addratscriptcmd("<dev string:x19b>", &function_163c296a);
  addratscriptcmd("<dev string:x1b3>", &function_92891f6e);
  addratscriptcmd("<dev string:x1ca>", &function_834d65f9);
  addratscriptcmd("<dev string:x1ee>", &function_ad78fe8a);
  addratscriptcmd("<dev string:x20b>", &function_adb96ff1);
  addratscriptcmd("<dev string:x222>", &function_a93cbd41);
  setDvar(#"rat_death_count", 0);
}

function function_d50abf44(params) {
  return getplayers().size;
}

function function_7eabbc02(params) {
  remaining = 0;
  host = [[level.rat.common.gethostplayer]]();
  hostteam = host.team;

  if(isDefined(params.remaining)) {
    remaining = int(params.remaining);
  }

  if(isDefined(getplayers())) {
    for(i = 0; i < getplayers().size; i++) {
      if(getplayers().size <= remaining) {
        break;
      }

      if(!isDefined(getplayers()[i].bot) || getplayers()[i].team == hostteam || getplayers()[i].team == "<dev string:x246>") {
        continue;
      }

      bot::remove_bot(getplayers()[i]);
    }
  }
}

function function_684893c8(params) {
  count = 0;

  if(isDefined(getplayers())) {
    foreach(player in getplayers()) {
      if(player laststand::player_is_in_laststand()) {
        count++;
      }
    }
  }

  return count;
}

function function_1251949b(params) {
  player = [[level.rat.common.gethostplayer]]();
  return player laststand::player_is_in_laststand();
}

function function_70f41194(params) {
  player = [[level.rat.common.gethostplayer]]();
  return player.inventory.var_c212de25;
}

function function_31980089(params) {
  player = [[level.rat.common.gethostplayer]]();
  numitems = 1000;
  distance = 1000;
  name = "<dev string:x24e>";

  if(isDefined(params.var_1d978d3)) {
    numitems = int(params.var_1d978d3);
  }

  if(isDefined(params.distance)) {
    distance = int(params.distance);
  }

  if(isDefined(params.name)) {
    name = params.name;
  }

  items = item_world::function_2e3efdda(player.origin, undefined, numitems, distance);

  foreach(item in items) {
    if(item.itementry.name == "<dev string:x252>") {
      continue;
    }

    if(isDefined(params.handler)) {
      if(params.handler != item.itementry.handler && params.handler != "<dev string:x26a>") {
        continue;
      }
    }

    if(name == "<dev string:x24e>" || item.itementry.name == name) {
      function_55e20e75(params._id, item.origin);
    }
  }
}

function function_89684f6a(params) {
  player = [[level.rat.common.gethostplayer]]();
  return player.inventory.items[5].networkid != 32767;
}

function function_baeffaeb(params) {
  player = [[level.rat.common.gethostplayer]]();
  direction = player getplayerangles();
  direction_vec = anglesToForward(direction);
  guy = undefined;
  guy = namespace_85745671::function_9d3ad056("<dev string:x272>", player.origin, player.angles, "<dev string:x28b>");
}

function function_63a39134(params) {
  return zombie_utility::get_current_zombie_count();
}

function function_d19f7fe9(params) {
  namespace_ce1f29cc::function_368a7cde();
}

function function_2bd96c6e(params) {
  location = level.contentmanager.locations[params.location];
  return location.spawnedinstance.content_script_name;
}

function function_40e4c9de(params) {
  location = level.contentmanager.locations[params.location];
  location.spawnedinstance = undefined;
}

function function_ee280019(params) {
  location = level.contentmanager.locations[params.location];

  if(!isDefined(location.spawnedinstance.var_4272a188)) {
    return;
  }

  function_55e20e75(params._id, location.spawnedinstance.var_4272a188.origin);
}

function function_fea33619(params) {
  player = [[level.rat.common.gethostplayer]]();
  location = level.contentmanager.locations[params.location];

  if(!isDefined(location.spawnedinstance) || !isDefined(location.spawnedinstance.var_e55c8b4e)) {
    return 0;
  }

  location.spawnedinstance.var_4272a188 useby(player);
}

function function_163c296a(params) {
  if(!isDefined(level.contentmanager.activeobjective)) {
    return "<dev string:x24e>";
  }

  return level.contentmanager.activeobjective.content_script_name;
}

function function_92891f6e(params) {
  var_4f7fa3d1 = 1;

  if(params.success === "<dev string:x29c>") {
    var_4f7fa3d1 = 0;
  }

  if(!isDefined(level.contentmanager.activeobjective)) {
    return 0;
  }

  instance = level.contentmanager.activeobjective;
  objective_manager::objective_ended(level.contentmanager.activeobjective, var_4f7fa3d1);
  return instance.success;
}

function function_834d65f9(params) {
  if(!isDefined(level.contentmanager.activeobjective) || level.contentmanager.activeobjective.content_script_name != "<dev string:x2a5>") {
    return;
  }

  var_4f7fa3d1 = 1;

  if(params.success === "<dev string:x29c>") {
    var_4f7fa3d1 = 0;
  }

  instance = level.contentmanager.activeobjective;

  if(var_4f7fa3d1) {
    level notify(#"timer_defend");
    objective_manager::stop_timer();
  } else {
    foreach(s_instance in instance.contentgroups[# "console"]) {
      s_instance.mdl_console.health = 0;
      s_instance.mdl_console notify(#"damage");
    }
  }

  return instance.success;
}

function function_ad78fe8a() {
  player = [[level.rat.common.gethostplayer]]();
  portal = level.var_7d75c960.var_fb516651;
  portal.var_56356783[0].mdl_gameobject gameobjects::use_object_onuse(player);
}

function function_adb96ff1() {
  instance = level.contentmanager.activeobjective;
  level.var_7d75c960.var_fb516651.mdl_portal.health = 0;
  return instance.success;
}

function function_a93cbd41(params) {
  if(!isDefined(level.contentmanager.activeobjective) || level.contentmanager.activeobjective.content_script_name != "<dev string:x2b7>") {
    return;
  }

  var_4f7fa3d1 = 1;

  if(params.success === "<dev string:x29c>") {
    var_4f7fa3d1 = 0;
  }

  instance = level.contentmanager.activeobjective;

  if(var_4f7fa3d1) {} else {
    level notify(#"timer_payload");
    objective_manager::stop_timer();
  }

  return instance.success;
}