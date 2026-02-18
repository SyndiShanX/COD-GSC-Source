/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5549681e1669c11a.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2440f86f9cd325ac;
#using script_2474a362752098d2;
#using script_26187f7b449f7b92;
#using script_2a5bf5b4a00cee0d;
#using script_2c9915120c137848;
#using script_350cffecd05ef6cf;
#using script_3bbf85ab4cb9f3c2;
#using script_3faf478d5b0850fe;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_50fca1a24ae351;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_634ae70c663d1cc9;
#using script_683a55734f15d50e;
#using script_68cdf0ca5df5e;
#using script_6b6510e124bad778;
#using script_74a56359b7d02ab6;
#using script_77357b2d180aa2b8;
#using script_774302f762d76254;
#using script_f38dc50f0e82277;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_5a917022;

function init() {
  setDvar(#"hash_154b7b2766a610f3", 1);

  objective_add(11, "invisible", (0, 0, 0), #"hash_3c82fb0aa0fa4fed");
  clientfield::register("world", "set_bonus_room", 1, 5, "int");
  level.doa.var_8f6ccf63 = [];
  level.doa.var_ffb709d8 = 0;
  rooms = struct::get_array("zombietron_bonus_room", "targetname");

  foreach(room in rooms) {
    room.name = room.script_noteworthy;
    room.id = function_b3411080(room.name);
    room.var_d52d06ee = function_d52d06ee(room.id);
    room.var_8028986b = 0;
    room.var_3914cffe = 999;
    room.var_74606c86 = 1;
    room.var_7d320f40 = 1;
    room.var_6959a8a9 = 0;
    room.flipcamera = 0;
    room.timeout = 60;
    room.lightstate = 0;
    room.var_5bbf26b8 = 0;
    room.cooldown = function_f9f3607b(room.name);
    room.var_a702483f = 0;

    if(isDefined(room.script_int)) {
      room.var_8028986b = int(room.script_int);
    }

    if(isDefined(room.script_parameters)) {
      args = strtok(room.script_parameters, ";");
      room.var_899e2128 = int(args[0]);

      if(args.size > 1) {
        room.flipcamera = int(args[1]);
      }

      if(args.size > 2) {
        room.var_74606c86 = int(args[2]);
      }

      if(args.size > 3) {
        room.var_7d320f40 = int(args[3]);
      }

      if(args.size > 4) {
        room.timeout = int(args[4]);
      }

      if(args.size > 5) {
        room.lightstate = int(args[5]);
      }

      if(args.size > 6) {
        room.var_3914cffe = int(args[6]);
      }

      if(args.size > 7) {
        room.maxlevel = int(args[7]);
      }
    }

    if(room.id == 16) {
      if(getdvarint(#"hash_6bb88210d3945cbe", 1)) {
        room.var_8028986b = 20;
        room.maxlevel = 140;
        room.var_3914cffe = 3;
      } else {
        room.var_8028986b = 9999;
      }
    }

    if(getdvarint(#"hash_521cafa4a34ca4cb", 0)) {
      room.timeout = getdvarint(#"hash_521cafa4a34ca4cb", 0);
    }

    assert(room.flipcamera == 0 || room.flipcamera == 1, "<dev string:x38>");
    level.doa.var_8f6ccf63[room.script_noteworthy] = room;
    room.var_12ae4b83 = struct::get_array("zombietron_bonus_room_player_starts_" + room.name);
    room.items = struct::get_array("zombietron_bonus_room_item_" + room.name);
    room.npcs = struct::get_array("zombietron_bonus_room_npc_" + room.name);
    room.var_f9c9c0 = struct::get_array("zombietron_bonus_room_hazard_" + room.name);
    room.platforms = getEntArray("zombietron_bonus_room_platform_" + room.name, "targetname");
    room.generators = struct::get_array("zombietron_bonus_room_generator_" + room.name);
    room.doors = struct::get_array("zombietron_bonus_room_door_" + room.name);
    room.dungeon = struct::get("zombietron_bonus_room_dungeon_" + room.name, "script_noteworthy");
    room.var_2f0b512f = function_19e7d0fc(room.name);
    room.spawned_items = [];
    room.var_1406397f = getent("zombietron_bonus_room_exit_trigger_" + room.name, "targetname");
    room.var_6eb6f696 = getent("zombietron_bonus_room_abort_trigger_" + room.name, "targetname");
    assert(room.var_12ae4b83.size == 4);
    var_663588d = "Zombietron/Debug/AutoTesting/BonusRoomSoak/";
    cmdline = "scr_bonus_room_activate " + room.name + "; zombie_devgui bonusroomsoak";
    util::add_devgui(var_663588d + room.name, cmdline);
  }
}

function function_f9f3607b(name) {
  switch (name) {
    case # "slideways":
    case # "slideways2":
    case # "slideways3":
    case # "slideways4":
    case # "slideways5":
      return 4500;
    case # "eggxit_1":
      return 3600;
    case # "roj":
      return 9999999;
  }

  return 1800;
}

function function_85615bbb() {
  rooms = struct::get_array("zombietron_bonus_room", "targetname");
  var_663588d = "Zombietron/Bonus Rooms/";
  label = "Disable Room Timeouts (TRUE):0";
  util::function_85c62761(var_663588d + label);
  label = "Disable Room Timeouts (FALSE):0";
  util::function_85c62761(var_663588d + label);

  foreach(room in rooms) {
    util::function_85c62761(var_663588d + room.name);
  }

  util::function_85c62761(var_663588d);
  util::wait_network_frame();
  label = is_true(level.doa.var_206393b4) ? "Disable Room Timeouts (TRUE):0" : "Disable Room Timeouts (FALSE):0";
  util::add_devgui(var_663588d + label, "zombie_devgui bonusTimeoutDisableToggle");

  foreach(room in rooms) {
    cmdline = "scr_bonus_room_activate " + room.name + "; zombie_devgui bonusroom";
    util::add_devgui(var_663588d + room.name, cmdline);
  }
}

function main() {
  objective_setstate(11, "invisible");
  level.doa.var_6f3d327 = undefined;
  level.doa.var_206393b4 = 0;
  level.doa.var_f8e35dd0 = 1;
  level.doa.var_a5ade8f8 = 0;
  level.doa.var_ffb709d8 = 0;
  level.doa.var_6ab50f27 = undefined;
  level.doa.var_ae635e19 = -1;
  level.doa.var_79574675 = undefined;
  level.doa.var_8609e0e9 = [];

  foreach(room in level.doa.var_8f6ccf63) {
    room.var_6959a8a9 = 0;
    room.var_5bbf26b8 = 0;
  }

  function_85615bbb();
  level thread function_879f2ed0();
}

function function_9da359eb() {
  level.doa.var_206393b4 = !level.doa.var_206393b4;
  function_85615bbb();
}

function function_879f2ed0() {
  self notify("ff2c4512ebde957");
  self endon("ff2c4512ebde957");
  level endon(#"game_over");

  while(true) {
    wait 3;

    if(namespace_4dae815d::function_59a9cf1d() == 0 && flag::get("doa_round_spawning") == 0) {
      continue;
    }

    foreach(room in level.doa.var_8f6ccf63) {
      if(room.var_a702483f > 0 && room.var_a702483f != 9999999) {
        room.var_a702483f = math::clamp(0, room.var_a702483f - 3);
      }
    }
  }
}

function function_19e7d0fc(name) {
  switch (name) {
    case # "slideways":
    case # "slideways2":
    case # "slideways3":
    case # "slideways4":
    case # "slideways5":
      return &function_4d16b7a9;
    case # "snaketemple":
      return &function_ab6edfa3;
    case # "warstore":
      return &function_7cbb4f99;
    case # "roj":
      return &function_b2706226;
    case # "eggxit_1":
      return &function_2ee246a7;
  }

  return undefined;
}

function function_d52d06ee(id) {
  if(id == 6) {
    return true;
  }

  if(id == 7) {
    return true;
  }

  if(id == 5) {
    return true;
  }

  if(id == 9) {
    return true;
  }

  if(id == 10) {
    return true;
  }

  if(id == 11) {
    return true;
  }

  if(id == 12) {
    return true;
  }

  if(id == 13) {
    return true;
  }

  if(id == 16) {
    return true;
  }

  return false;
}

function function_b3411080(name) {
  switch (name) {
    case # "armory":
      return 1;
    case # "coop":
      return 2;
    case # "treasure":
      return 3;
    case # "tradingpost":
      return 4;
    case # "nukebunker":
      return 5;
    case # "snaketemple":
      return 6;
    case # "crypt":
      return 7;
    case # "cellar":
      return 8;
    case # "slideways":
      return 9;
    case # "slideways2":
      return 10;
    case # "slideways3":
      return 11;
    case # "slideways4":
      return 12;
    case # "slideways5":
      return 13;
    case # "eggxit_1":
      return 16;
    case # "warstore":
      return 14;
    case # "roj":
      return 15;
    default:
      assert(0, "<dev string:x5d>");
      break;
  }
}

function function_d496f180(name) {
  switch (name) {
    case # "armory":
      return 26;
    case # "coop":
      return 27;
    case # "treasure":
      return 17;
    case # "tradingpost":
      return 18;
    case # "nukebunker":
      return 19;
    case # "snaketemple":
      return 20;
    case # "crypt":
      return 21;
    case # "cellar":
      return 22;
    case # "slideways":
    case # "slideways2":
    case # "slideways3":
    case # "slideways4":
    case # "slideways5":
      return 23;
    case # "eggxit_1":
      return 28;
    case # "warstore":
      return 24;
    case # "roj":
      return 52;
    default:
      assert(0, "<dev string:x72>");
      break;
  }
}

function function_c8892b0f(name) {
  foreach(room in level.doa.var_8f6ccf63) {
    if(room.name === name) {
      return room;
    }
  }
}

function function_3db4a0b1(roundnumber = level.doa.roundnumber) {
  var_851aa222 = [];

  foreach(room in level.doa.var_8f6ccf63) {
    if(is_true(room.var_d52d06ee)) {
      if(is_true(level.doa.hardcoremode)) {
        continue;
      }

      if(!is_true(room.var_df9ba7a9)) {
        continue;
      }
    }

    if(room.var_3914cffe != 999 && room.var_3914cffe <= 0) {
      continue;
    }

    if(room.var_a702483f > 0) {
      continue;
    }

    if(room.name === # "cellar" && isDefined(level.doa.var_98764e02)) {
      delta = gettime() - level.doa.var_98764e02;

      if(delta < 15 * 60000) {
        continue;
      }
    }

    if(isDefined(room.maxlevel) && roundnumber >= room.maxlevel) {
      continue;
    }

    if(roundnumber >= room.var_8028986b) {
      if(!isDefined(room.var_6959a8a9)) {
        room.var_6959a8a9 = 0;
      }

      array::add_sorted(var_851aa222, room, 0, &function_f17be536);
    }
  }

  if(var_851aa222.size > 0) {
    selection = [];
    var_ea838841 = var_851aa222[0].var_6959a8a9;

    foreach(room in var_851aa222) {
      if(room.var_6959a8a9 == var_ea838841) {
        selection[selection.size] = room;
      }
    }

    return selection[randomint(selection.size)];
  }
}

function function_f17be536(a, b) {
  return a.var_6959a8a9 < b.var_6959a8a9;
}

function function_7230f033() {
  if(isDefined(level.doa.var_848746c8)) {
    room = function_c8892b0f(level.doa.var_848746c8);
    level thread function_898ca25f(room);
    level.doa.var_848746c8 = undefined;
    level.doa.var_ae635e19 = "FORCED";
    return true;
  }

  randrange = math::clamp(100 - (level.doa.roundnumber - level.doa.var_f8e35dd0) * 6 - level.doa.var_a5ade8f8, 15, 100);
  level.doa.var_ae635e19 = randomint(randrange);

  if(level.doa.var_ae635e19 > 15) {
    return false;
  }

  room = function_3db4a0b1();

  if(!isDefined(room)) {
    return false;
  }

  level thread function_898ca25f(room);
  return true;
}

function function_8dd06da3() {
  if(level.doa.teleporter_locs.size > 0) {
    level.doa.teleporter_locs = arraysortclosest(level.doa.teleporter_locs, level.doa.var_187ed224.origin);
    furthest = level.doa.teleporter_locs[level.doa.teleporter_locs.size - 1];
    level.doa.teleporter_locs = [];
    level.doa.var_9f48249a = namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_2c9923d7(39), furthest.origin, undefined, undefined, 1);

    if(isDefined(level.doa.var_9f48249a)) {
      level.doa.var_9f48249a clientfield::set("set_icon", 9);
      level.doa.var_9f48249a notify(#"hash_2a866f50cc161ca8");
      objective_onentity(13, level.doa.var_9f48249a);
      objective_setstate(13, "active");
      objective_setstate(12, "invisible");
      level thread function_160237df(level.doa.var_9f48249a);
    }
  }

  level notify(#"hash_40456743c6415fcd");
}

function function_160237df(var_82be662a) {
  level endon(#"hash_593a6814c28d14e7", #"game_over");

  if(isDefined(var_82be662a)) {
    var_82be662a endon(#"death");
    level waittill(#"ladder_up");

    if(isDefined(level.doa.var_6f3d327)) {
      level.doa.var_6f3d327.var_1406397f notify(#"trigger");
    }
  }
}

function function_898ca25f(room) {
  level endon(#"game_over");
  level notify(#"hash_7270a59e1f502d96", {
    #room: room
  });
  level.doa.var_6f3d327 = room;
  level.doa.var_60e0f7a0 = gettime();
  level.doa.var_f8e35dd0 = level.doa.roundnumber;
  level.doa.var_a5ade8f8 = 0;
  level.doa.var_50a26b4f = 0;
  namespace_ec06fe4a::function_87612422(room.var_12ae4b83[0].origin, room.var_12ae4b83[0].angles, 1, 8, room.lightstate);

  if(isDefined(level.doa.var_a77e6349)) {
    [[level.doa.var_a77e6349]] - > function_1137c8bb();
  }

  foreach(generator in level.doa.var_8acd67ef) {
    [[generator]] - > getmodel() namespace_c85a46fe::function_47c860ff(0);
  }

  foreach(player in getplayers()) {
    if(isDefined(player.doa)) {
      player.doa.var_2fb8ffeb = undefined;

      if(isDefined(player.doa.var_e46a9e57)) {
        player.doa.var_e46a9e57.var_9a5b8400 = hash(room.name);
      }
    }
  }

  level namespace_ec06fe4a::function_de70888a();
  level namespace_7f5aeb59::function_d0251f76();
  var_fbefebc = level.doa.var_ecff3871;
  oldstate = level.lighting_state;
  timeout = room.timeout;

  if(isDefined(room.var_2f0b512f)) {
    level thread[[room.var_2f0b512f]](room);
  }

  if(isDefined(room.dungeon)) {
    idx = namespace_981c1f3c::function_61e1a1cb(isDefined(room.dungeon.targetname) ? room.dungeon.targetname : room.name);

    if(isDefined(idx)) {
      level.doa.dungeons[idx].var_9105f204 = array(level.doa.var_65a70dc);
      level.doa.dungeons[idx].var_40ca2d09 = array(doa_enemy::function_d7c5adee("spider"));
      level.doa.var_a7ccb320 = &function_8dd06da3;
      level namespace_981c1f3c::function_c88b8726(idx);
      var_5b55ba1f = namespace_4dae815d::function_21cd3890(5);

      foreach(player in getplayers()) {
        player thread namespace_981c1f3c::function_fe17d41e();
      }
    }
  }

  players = namespace_7f5aeb59::function_23e1f90f();

  foreach(player in players) {
    player notify(#"hash_279998c5df86c04d");
    player notify(#"hash_7893364bd228d63e");
    player.doa.var_3cf36932 = 0;
    player.doa.var_4f3aee7b = 1;
    vehicle = player getvehicleoccupied();

    if(isDefined(vehicle)) {
      vehicle.var_3e742dc1 = 1;
      vehicle usevehicle(player, 0);
    }
  }

  players = namespace_7f5aeb59::function_23e1f90f();
  idx = 0;
  lastposition = players[0].origin;
  lastangles = players[0].angles;

  foreach(player in players) {
    player notify(#"hash_279998c5df86c04d");
    player notify(#"hash_7893364bd228d63e");
    player.doa.var_3cf36932 = 0;
    player.doa.var_4f3aee7b = 1;
    vehicle = player getvehicleoccupied();

    if(isDefined(vehicle)) {
      vehicle.var_3e742dc1 = 1;
      vehicle usevehicle(player, 0);
    }

    player setorigin(room.var_12ae4b83[idx].origin);
    player setplayerangles(room.var_12ae4b83[idx].angles);
    player.doa.var_2fb8ffeb = undefined;
    player namespace_7f5aeb59::function_61d74d57();
    idx++;
  }

  level thread function_6f63004b(room.var_74606c86, room.var_7d320f40);
  var_28a17b1b = 20;

  foreach(item in room.items) {
    if(isDefined(item.script_int)) {
      roll = int(item.script_int);

      if(randomint(100) > roll) {
        continue;
      }
    }

    room.spawned_items[room.spawned_items.size] = function_edc2fabf(item);
    var_28a17b1b--;

    if(var_28a17b1b <= 0) {
      util::wait_network_frame();
      var_28a17b1b = 20;
    }
  }

  level thread function_b49532ed(room);

  foreach(generator in room.generators) {
    a_toks = strtok(generator.script_string, ",");
    var_44eec847 = a_toks[0];

    if(a_toks.size >= 2) {
      radius = int(a_toks[1]);
    } else {
      radius = 800;
    }

    if(a_toks.size >= 3) {
      height = int(a_toks[2]);
    }

    if(a_toks.size >= 4) {
      maxalive = int(a_toks[3]);
    }

    agen = namespace_c85a46fe::function_4c16ce2c(var_44eec847, generator.origin, generator.angles, radius, height, maxalive, 3);
    generator.var_64a23077 = [[agen]] - > getmodel();
  }

  util::wait_network_frame();

  foreach(door in room.doors) {
    door.model = namespace_f63bdb08::function_2a1e5c1f(door.origin, door.angles, door.script_string, door.script_int, isDefined(door.script_objective) ? int(door.script_objective) : 1, 3, door.script_parameters);
  }

  namespace_a6056a45::function_de7fb95(room.name, 3);
  namespace_268747c0::function_96e2f261(room.var_f9c9c0, 0);
  namespace_268747c0::function_b04a33c5(room.platforms);
  util::wait_network_frame();
  players = namespace_7f5aeb59::function_23e1f90f();

  foreach(player in players) {
    player clientfield::increment_to_player("hardResetCamera");
  }

  util::wait_network_frame();
  level clientfield::set("set_bonus_room", room.id);
  util::wait_network_frame();
  namespace_8c04284b::function_a70ff03e(room.flipcamera);
  players = namespace_7f5aeb59::function_23e1f90f();
  var_899e2128 = room.var_899e2128;

  if(is_true(level.doa.var_318aa67a)) {
    var_899e2128 = 1;
  }

  foreach(player in players) {
    if(is_true(var_899e2128)) {
      player clientfield::increment_to_player("hardResetCamera");
    }

    player clientfield::increment_to_player("setCompassVis");
  }

  level util::set_lighting_state(room.lightstate, 0);
  level thread function_3c47fbe0(room);

  if(room.var_3914cffe != 999) {
    room.var_3914cffe--;
  }

  level notify(#"hash_52ca1213084f29fa");
  level thread namespace_7f5aeb59::function_836aeb74();
  namespace_9fc66ac::function_a77649db(room.name, 1);
  level doa_banner::function_7a0e5387(function_d496f180(room.name));

  if(isDefined(room.var_1406397f)) {
    objective_setposition(11, room.var_1406397f.origin);
    objective_setstate(11, "active");
  }

  if(isDefined(room.var_6eb6f696)) {
    room.var_6eb6f696 thread function_56e9011(room);
  }

  if(isDefined(room.var_1406397f)) {
    if(room.timeout === 999 || is_true(level.doa.var_206393b4)) {
      result = room.var_1406397f waittill(#"trigger", #"abort");
    } else {
      level thread namespace_6e90e490::function_c937e51f(timeout);
      level thread function_707a2001(timeout - 10);

      while(timeout > 0) {
        result = room.var_1406397f waittilltimeout(1, #"trigger", #"abort");

        if(result._notify == # "timeout") {
          timeout--;
          continue;
        }

        win = result._notify === # "abort" ? 0 : 1;
        level notify(#"hash_26543e77189e41db", {
          #success: win
        });
        break;
      }

      namespace_6e90e490::function_fa6f7ba7();
    }

    var_62ad07bf = result._notify == # "abort" ? "evt_doa_travel_doors_chosen" : "evt_doa_travel_doors_chosen";
  } else {
    room waittill(#"room_done");
    var_62ad07bf = "evt_doa_travel_doors_chosen";
  }

  foreach(player in getplayers()) {
    player namespace_e32bb68::function_3a59ec34(var_62ad07bf);
  }

  objective_setstate(11, "invisible");
  namespace_ec06fe4a::function_87612422(lastposition, lastangles, 1, 8, oldstate);
  level notify(#"hash_11a3b1e82b21ec58");
  level thread namespace_7f5aeb59::function_67f054d7();
  level waittill(#"hash_1b322de3d2e3e781");
  level notify(#"hash_593a6814c28d14e7");

  if(isDefined(var_5b55ba1f)) {
    namespace_4dae815d::function_21cd3890(var_5b55ba1f);
  }

  level clientfield::set("banner_eventplayer", 0);
  namespace_a6056a45::function_e2f97f03(3);
  level util::set_lighting_state(oldstate, 0);
  level clientfield::set("setTOD", oldstate);

  if(isDefined(var_fbefebc)) {
    namespace_8c04284b::function_a70ff03e(var_fbefebc);
  }

  players = namespace_7f5aeb59::function_23e1f90f();

  foreach(player in players) {
    player clientfield::increment_to_player("resetCamera");
  }

  level.doa.var_ffb709d8++;
  room.var_6959a8a9++;
  room.var_df9ba7a9 = 1;
  room.var_5bbf26b8 = gettime();
  room.var_a702483f = room.cooldown;
  level.doa.var_6ab50f27 = room;
}

function function_b49532ed(room) {
  self notify("5b97a3ea618c8292");
  self endon("5b97a3ea618c8292");
  level endon(#"hash_593a6814c28d14e7", #"game_reset", #"game_over");
  var_dc16035f = [];

  foreach(npc in room.npcs) {
    npc.retryattempts = 2;

    if(!isDefined(var_dc16035f)) {
      var_dc16035f = [];
    } else if(!isarray(var_dc16035f)) {
      var_dc16035f = array(var_dc16035f);
    }

    var_dc16035f[var_dc16035f.size] = npc;
  }

  done = 0;
  var_21d6599c = 0;

  while(!done && var_dc16035f.size) {
    npc = var_dc16035f[0];
    arrayremoveindex(var_dc16035f, 0);

    if(!isDefined(npc.script_string)) {
      continue;
    }

    toks = strtok(npc.script_string, ";");

    if(toks.size > 1) {
      mask = int(toks[1]);

      if(isDefined(level.doa.var_182fb75a)) {
        if(mask & 4) {
          continue;
        }
      } else if(isDefined(level.doa.var_a77e6349)) {
        if(mask & 2) {
          continue;
        }
      } else if(mask & 1 && isDefined(level.doa.var_39e3fa99)) {
        continue;
      }
    }

    var_21d6599c++;

    if(var_21d6599c % 10 == 0) {
      util::wait_network_frame();
    }

    def = doa_enemy::function_d7c5adee(toks[0]);
    count = 1;

    if(isDefined(npc.script_int)) {
      count = int(npc.script_int);
    }

    if(isDefined(def)) {
      ai = doa_enemy::function_db55a448(def, npc.origin, undefined, npc.target);

      if(isDefined(ai)) {
        ai.var_227e7c79 = !is_true(self.var_d55f22cb);
        ai.script_noteworthy = npc.script_noteworthy;
        level notify(#"bonus_ai", {
          #ai: ai
        });
        continue;
      }

      npc.retryattempts--;

      if(npc.retryattempts > 0) {
        if(!isDefined(var_dc16035f)) {
          var_dc16035f = [];
        } else if(!isarray(var_dc16035f)) {
          var_dc16035f = array(var_dc16035f);
        }

        var_dc16035f[var_dc16035f.size] = npc;
      }
    }
  }
}

function function_707a2001(sec) {
  level endon(#"hash_593a6814c28d14e7", #"game_reset", #"game_over");
  wait sec;

  foreach(player in getplayers()) {
    player namespace_e32bb68::function_3a59ec34("evt_doa_travel_warning");
  }
}

function function_3c47fbe0(room) {
  level waittill(#"hash_593a6814c28d14e7", #"game_reset");
  level clientfield::set("set_bonus_room", 0);
  namespace_9fc66ac::function_a77649db(room.name, 0);

  foreach(generator in room.generators) {
    if(isDefined(generator.var_64a23077)) {
      [[generator.var_64a23077.generator]] - > destroy();
      generator.var_64a23077 = undefined;
    }
  }

  level namespace_ec06fe4a::function_de70888a();

  foreach(trap in room.var_f9c9c0) {
    if(isDefined(trap)) {
      trap notify(#"destroy_hazard", {
        #var_760a0807: 1
      });
    }
  }

  foreach(platform in room.platforms) {
    if(isDefined(platform)) {
      platform notify(#"destroy_hazard", {
        #var_760a0807: 1
      });
    }
  }

  foreach(door in room.doors) {
    if(isDefined(door.model)) {
      door.model delete();
    }
  }

  foreach(item in room.spawned_items) {
    if(!isDefined(item)) {
      continue;
    }

    item delete();
  }

  room.spawned_items = [];
  namespace_491fa2b2::function_df55eb9d(3);
  namespace_a6056a45::function_e2f97f03(3);

  if(isDefined(room.dungeon) && isDefined(level.doa.var_182fb75a)) {
    level thread namespace_981c1f3c::function_8790b64a();
    objective_setstate(13, "invisible");
    level.doa.var_a7ccb320 = undefined;
  }

  if(isDefined(level.doa.var_182fb75a)) {
    foreach(generator in level.doa.var_8acd67ef) {
      [[generator]] - > getmodel() namespace_c85a46fe::function_47c860ff([[generator]] - > function_30a0163e());
    }
  } else {
    if(isDefined(level.doa.var_a77e6349)) {
      [[level.doa.var_a77e6349]] - > function_ce6bb21b();
    }

    foreach(generator in level.doa.var_8acd67ef) {
      [[generator]] - > getmodel() namespace_c85a46fe::function_47c860ff(1);
    }
  }

  util::wait_network_frame();

  foreach(player in getplayers()) {
    if(isbot(player)) {
      continue;
    }

    player namespace_d2efac9a::function_d7ee01df();
    player.doa.var_4f3aee7b = undefined;
    player clientfield::increment_to_player("setCompassVis");
  }

  waitframe(1);
  level namespace_ec06fe4a::function_de70888a();
  level notify(#"hash_7dd47c99b7707b1c");
  level.doa.var_6f3d327 = undefined;
  level.doa.var_50a26b4f = 1;
  level doa_banner::function_7a0e5387();
}

function function_56e9011(room) {
  level endon(#"hash_7dd47c99b7707b1c", #"game_over");
  self notify("57c4aea4f88d073d");
  self endon("57c4aea4f88d073d");
  self waittill(#"trigger");
  room.var_1406397f notify(#"abort");
}

function function_6f63004b(var_74606c86, var_7d320f40) {
  level endon(#"hash_52ca1213084f29fa", #"hash_7dd47c99b7707b1c", #"game_over");

  while(true) {
    result = level waittill(#"hash_6b1b7f8f320c0d3b");

    if(isDefined(result.pickup)) {
      if(result.type != 32 && result.type != 33) {
        if(is_true(var_74606c86)) {
          result.pickup notify(#"stopidle");
        }

        if(is_true(var_7d320f40)) {
          result.pickup notify(#"hash_2a866f50cc161ca8");
        }
      }
    }
  }
}

function function_edc2fabf(item) {
  toks = strtok(item.script_noteworthy, ";");

  if(toks.size > 1) {
    mask = int(toks[1]);

    if(isDefined(level.doa.var_182fb75a)) {
      if(mask & 4) {
        return undefined;
      }
    } else if(isDefined(level.doa.var_a77e6349)) {
      if(mask & 2) {
        return undefined;
      }
    } else if(mask & 1 && isDefined(level.doa.var_39e3fa99)) {
      return undefined;
    }
  }

  type = toks[0];

  if(type === "lootitem") {
    assert(isDefined(item.script_parameters), "<dev string:x8b>");
    object = namespace_41f5b853::spawnlootitem(item.origin, item.angles, item.script_parameters, 50, 3);

    if(isDefined(object)) {
      object.target = item.target;
    }

    return object;
  } else if(type === "pick one") {
    choices = strtok(item.script_parameters, ";");
    assert(choices.size > 1, "<dev string:xb0>");
    choice = choices[randomint(choices.size)];
    def = namespace_dfc652ee::function_6265bde4(choice);

    if(isDefined(def)) {
      pickup = namespace_dfc652ee::itemspawn(def, item.origin, item.angles, undefined, 1, "none", undefined, undefined, undefined, undefined, 0);
    } else {
      object = namespace_41f5b853::spawnlootitem(item.origin, item.angles, choice, 50, 3);

      if(isDefined(object)) {
        object.target = item.target;
      }

      return object;
    }
  } else if(type === "treasure_pile") {
    radius = isDefined(item.radius) ? item.radius : 128;
    level namespace_dfc652ee::function_68442ee7(item.origin, 20, radius, 1);
    level namespace_dfc652ee::function_d06cbfe8(item.origin, 10, radius, 0, undefined, undefined, 0.75);
    return undefined;
  } else {
    def = namespace_dfc652ee::function_6265bde4(type);
    assert(isDefined(def), "<dev string:xd2>");

    if([[def]] - > gettype() == 13) {
      scale = 1;

      if(isDefined(item.scale)) {
        scale = item.scale;
      }

      pickup = namespace_dfc652ee::function_b8f6a8cd(def, item.origin, 0, 1, scale, item.angles);
    } else {
      pickup = namespace_dfc652ee::itemspawn(def, item.origin, item.angles, undefined, 1, "none", undefined, undefined, undefined, undefined, 0);
    }
  }

  if(isDefined(pickup)) {
    pickup.angles = item.angles;
    pickup.origin = item.origin;
    pickup.radius = 18;
    level thread function_92f612b2(def, pickup);
  }

  return pickup;
}

function function_92f612b2(def, pickup) {
  switch ([[def]] - > gettype()) {
    case 32:
    case 33:
      pickup namespace_3a8e4a3::function_22c4e231(1);
      break;
    case 6:
      break;
    default:
      break;
  }
}

function function_a9f78bf(&var_4200bfbf, room) {
  assert(isDefined(var_4200bfbf) && var_4200bfbf.size >= 4, "<dev string:x102>");
  level thread namespace_7f5aeb59::function_67f054d7();
  level waittill(#"hash_1b322de3d2e3e781");
  level thread function_898ca25f(room);
  level waittill(#"hash_7dd47c99b7707b1c");
  players = namespace_7f5aeb59::function_23e1f90f();
  idx = 0;

  foreach(player in players) {
    player setorigin(var_4200bfbf[idx].origin);
    player setplayerangles(var_4200bfbf[idx].angles);
    player clientfield::increment_to_player("resetCamera");
    player namespace_7f5aeb59::function_61d74d57();
    idx++;
  }

  wait 1;
  level thread namespace_7f5aeb59::function_836aeb74();
}

function function_23ea6695(trigger, room) {
  self notify("2140265bfa49d23a");
  self endon("2140265bfa49d23a");
  assert(isDefined(room));
  assert(isDefined(trigger));
  trigger endon(#"death");
  result = trigger waittill(#"trigger");
  trigger triggerenable(0);
  trigger.visited = 1;
  var_4200bfbf = trigger.var_4200bfbf;

  if(!isDefined(var_4200bfbf)) {
    var_4200bfbf = [];
    var_4200bfbf[0] = {
      #origin: result.activator.origin, #angles: result.activator.angles + (0, 180, 0)
    };
    var_4200bfbf[1] = {
      #origin: var_4200bfbf[0].origin + (30, 0, 0), #angles: var_4200bfbf[0].angles
    };
    var_4200bfbf[2] = {
      #origin: var_4200bfbf[0].origin + (-30, 0, 0), #angles: var_4200bfbf[0].angles
    };
    var_4200bfbf[3] = {
      #origin: var_4200bfbf[0].origin + (0, 30, 0), #angles: var_4200bfbf[0].angles
    };
  }

  level thread function_a9f78bf(var_4200bfbf, room);
  level waittill(#"hash_1b322de3d2e3e781");

  if(isDefined(trigger.var_ee2cd39c)) {
    trigger.var_ee2cd39c solid();
    trigger.var_ee2cd39c show();
  }
}

function function_e5c7bce7() {
  level endon(#"game_over");
  room = level.doa.var_848746c8;
  var_dffc76c2 = 0;
  level.doa.var_1f2c7d5f = 1;

  while(true) {
    level.doa.var_848746c8 = room;
    wait 3;
    level notify(#"round_over");
    level flag::clear("doa_round_spawning");
    level namespace_ec06fe4a::function_de70888a();
    namespace_ec06fe4a::clearallcorpses();
    wait 2;

    while(true) {
      wait 1;
      guys = namespace_7f5aeb59::function_23e1f90f();
      var_271662e8 = [[level.doa.var_39e3fa99]] - > function_dfb49846();

      if(var_271662e8.size) {
        exit = var_271662e8[randomint(var_271662e8.size)];
        exit notify(#"trigger", {
          #activator: guys[randomint(guys.size)]
        });
        break;
      }

      if(isDefined(level.doa.teleporter) && randomint(5) == 0) {
        guys[0] setorigin(level.doa.teleporter.origin + (0, 0, 32));
        break;
      }
    }

    result = level waittilltimeout(10, #"hash_52ca1213084f29fa");

    if(result._notify == "timeout") {
      continue;
    }

    if(isDefined(level.doa.var_a7ccb320) && flag::get("dungeon_building")) {
      level waittill(#"hash_40456743c6415fcd");
    }

    while(true) {
      wait 1;

      if(isDefined(level.doa.var_6f3d327)) {
        level.doa.var_6f3d327.var_1406397f notify(#"trigger");
        break;
      }
    }

    level waittill(#"hash_7dd47c99b7707b1c");
    var_dffc76c2++;
    namespace_1e25ad94::function_4e3cfad("Bonus Room Evolution: " + var_dffc76c2, undefined, undefined, undefined, 10);
    level waittill(#"hash_58caf0ade03043bb");

    if(is_true(level.doa.var_d31bcf30)) {
      level waittill(#"dungeon_destroyed");
    }
  }
}

function function_170eefc7(room, aicount = 28) {
  result = level waittill(#"hash_11a3b1e82b21ec58", #"game_over", #"hash_26543e77189e41db");

  if(result._notify === # "hash_26543e77189e41db" && is_true(result.success)) {
    namespace_7f5aeb59::function_f8645db3(getdvarint(#"hash_1f4204c11443f80a", 1000));
  }

  level waittill(#"hash_7dd47c99b7707b1c");
  level.var_9fa19717 = 0;
  level.var_52f56101 = undefined;
  level.doa.var_af74d0b = 0;
  level.var_40d076a7 = 0;
  level.doa.var_4425d066 = undefined;
  level.doa.var_d5fbd3 = undefined;
  level.doa.var_8609e0e9 = [];
  setsaveddvar(#"hash_63212188205e8c27", 0);

  if(room.name == "slideways3") {
    foreach(player in getplayers()) {
      player notify(#"lantern_terminated");
    }
  }

  foreach(var_f3db6d45 in level.doa.var_8f6ccf63) {
    if(var_f3db6d45.id == 9 || var_f3db6d45.id == 10 || var_f3db6d45.id == 11 || var_f3db6d45.id == 12 || var_f3db6d45.id == 13) {
      var_f3db6d45.var_df9ba7a9 = 1;
      var_f3db6d45.var_5bbf26b8 = gettime();
      var_f3db6d45.var_a702483f = var_f3db6d45.cooldown;
    }
  }

  if(namespace_4dae815d::function_59a9cf1d() == 0 && isDefined(level.doa.var_39e3fa99)) {
    [[level.doa.var_39e3fa99]] - > function_6d5262dc(aicount);
  }

  foreach(player in getplayers()) {
    player clientfield::set_to_player("setCameraSide", 0);
    player namespace_7f5aeb59::function_fae39d88();
  }

  setjumpheight(0);
}

function function_f11b0e51() {
  self.shouldspawn = self.shouldspawn || is_true(self.var_d55f22cb);
  self.var_227e7c79 = !is_true(self.var_d55f22cb);

  if(is_true(self.basic)) {
    self.maxhealth = 2500;
    self.health = self.maxhealth;
  }

  self.zombie_move_speed = level.doa.var_6f3d327.var_5214367;
}

function function_82273c90(room) {
  level endon(#"hash_11a3b1e82b21ec58", #"game_over");

  while(level.doa.var_6f3d327 === room) {
    result = level waittill(#"player_died");

    if(isDefined(result.player)) {
      result.player thread function_4747bdd0();
      result.player thread namespace_4ff32993::function_f30a62f4();
      result.player namespace_41cb996::function_8b7acf56();
    }
  }
}

function function_ea68ae7c() {
  self notify("6fb7c471e50952f1");
  self endon("6fb7c471e50952f1");
  self endon(#"disconnect");
  level endon(#"hash_11a3b1e82b21ec58", #"game_over");
  self waittill(#"player_respawned");
  self namespace_dfc652ee::function_32370b0d(999);
  self thread function_ea68ae7c();
}

function function_4747bdd0(time = 2) {
  self notify("4e60b8929bb7a869");
  self endon("4e60b8929bb7a869");
  self endon(#"disconnect", #"player_respawned");
  self.var_4a81243b = 1;
  self namespace_e32bb68::function_3a59ec34("evt_doa_slideways_dead");
  self clientfield::set_to_player("setCameraSide", 1);
  wait time;
  self.doa.score.lives++;
  self.deaths = math::clamp(self.deaths - 1, 0, self.deaths);
  self thread namespace_7f5aeb59::function_513831e1();
}

function function_330ded6(pickupdef, origin) {
  assert(isDefined(level.doa.var_6f3d327));

  if(level.doa.var_8609e0e9.size && isinarray(level.doa.var_8609e0e9, [[origin]] - > getname())) {
    return false;
  }

  return true;
}

function function_4d16b7a9(room) {
  level.var_9fa19717 = 1;
  level.var_40d076a7 = 1;
  level.doa.var_af74d0b = 1;
  level.doa.var_4425d066 = &function_f11b0e51;
  level.doa.var_d5fbd3 = &function_330ded6;
  level.doa.var_8609e0e9 = [# "zombietron_impaler", #"zombietron_pineapplegun", #"zombietron_launcher"];
  level.var_52f56101 = &function_79b68863;
  setsaveddvar(#"hash_63212188205e8c27", 1);
  level thread function_82273c90(room);
  room.var_5214367 = "walk";
  room.var_eb86e715 = 1;
  room.var_c0e42749 = 1;
  room.var_11ce6752 = 1;
  aicount = 28;

  if(namespace_4dae815d::function_59a9cf1d() == 0) {
    aicount = [[level.doa.var_39e3fa99]] - > function_c892290a();
    [[level.doa.var_39e3fa99]] - > function_6d5262dc(40);
  }

  level thread function_170eefc7(room, aicount);
  level waittill(#"hash_52ca1213084f29fa");
  setjumpheight(128);

  foreach(player in getplayers()) {
    player clientfield::set_to_player("setCameraSide", 1);
    player allowjump(1);
    player allowcrouch(1);
    player allowslide(1);
    player allowdoublejump(1);
    player allowsprint(1);
    player setstance("stand");
    player allowmantle(0);
    player thread function_8d3502d3();
    player namespace_41cb996::function_8b7acf56();

    if(room.name == "slideways3") {
      player thread namespace_dfc652ee::function_32370b0d(999);
      player thread function_ea68ae7c();
    }
  }
}

function function_8d3502d3() {
  self notify("2cb625666c1ab592");
  self endon("2cb625666c1ab592");
  self endon(#"disconnect");
  level endon(#"hash_11a3b1e82b21ec58", #"game_over");

  while(true) {
    self waittill(#"jump_begin");
    self namespace_e32bb68::function_3a59ec34("fly_doa_jump_plr");
    self waittill(#"jump_end");
  }
}

function function_79b68863(var_c4b5b87c) {
  self allowjump(1);
  self allowcrouch(1);
  self allowslide(1);
  self allowdoublejump(1);
  self allowsprint(1);
  self setorigin(level.doa.var_6f3d327.var_12ae4b83[self.entnum].origin);
  self setplayerangles(level.doa.var_6f3d327.var_12ae4b83[self.entnum].angles);
  wait 0.5;

  if(isDefined(self)) {
    self setstance("stand");
  }
}

function function_74c9e3dc(player, defaultval) {
  level endon(#"hash_593a6814c28d14e7", #"game_over");
  player endon(#"disconnect");
  toks = strtok(self.script_noteworthy, ";");
  val = int(toks[0]);

  while(true) {
    result = self waittill(#"trigger");
    other = result.activator;

    if(player !== other) {
      continue;
    }

    player notify(#"hash_3ae4b1b9ce49f5e", {
      #val: val
    });

    while(player istouching(self)) {
      if(!is_true(player.laststand)) {
        player notify(#"hash_3ae4b1b9ce49f5e", {
          #val: val
        });
      }

      wait 0.5;
    }

    player notify(#"hash_3ae4b1b9ce49f5e", {
      #val: defaultval
    });
  }
}

function function_6a60ea16(defaultval) {
  self endon(#"disconnect");
  level endon(#"hash_593a6814c28d14e7", #"game_over");
  var_987b26ec = getEntArray("eggxit_camera_change_trigger", "targetname");

  foreach(trig in var_987b26ec) {
    trig thread function_74c9e3dc(self, defaultval);
  }

  while(true) {
    result = self waittill(#"hash_3ae4b1b9ce49f5e");

    if(isDefined(result.val)) {
      self clientfield::set_to_player("setCameraSide", result.val);
    }
  }
}

function function_270306ac(room) {
  level endon(#"hash_11a3b1e82b21ec58", #"game_over");

  while(level.doa.var_6f3d327 === room) {
    result = level waittill(#"player_died");

    if(isDefined(result.player)) {
      result.player clientfield::set_to_player("setCameraSide", 3);
    }
  }
}

function function_19dbef9a(room) {
  level endon(#"hash_11a3b1e82b21ec58", #"game_over");
  self endon(#"disconnect");

  while(level.doa.var_6f3d327 === room) {
    self waittill(#"hash_5a8ee2526fb3775b");
    self allowjump(1);
    self allowcrouch(1);
    self allowslide(1);
    self allowdoublejump(1);
    self allowsprint(1);
  }
}

function function_85a06bf3(var_c4b5b87c) {
  self allowjump(1);
  self allowcrouch(1);
  self allowslide(1);
  self allowdoublejump(1);
  self allowsprint(1);

  if(isDefined(self.last_damaged_by) && self.last_damaged_by.targetname === "eggxit_1_hurt_1") {
    if(!isDefined(self.last_damaged_by.var_4c5fe7c6)) {
      self.last_damaged_by.var_4c5fe7c6 = struct::get(self.last_damaged_by.target, "targetname");
    }

    assert(isDefined(self.last_damaged_by.var_4c5fe7c6));
    self setorigin(self.last_damaged_by.var_4c5fe7c6.origin);
    self setplayerangles(self.last_damaged_by.var_4c5fe7c6.angles);
  }

  self clientfield::set_to_player("setCameraSide", 2);
  self.last_damaged_by = undefined;
}

function function_96e96e0f(room) {
  level endon(#"hash_11a3b1e82b21ec58", #"game_over");
  result = level waittill(#"hash_673fbe4833abc44d");
  i = 0;
  var_876d2ae2 = struct::get_array("eggxit_1_gateWarp", "targetname");

  foreach(player in getplayers()) {
    if(player === result.activator) {
      continue;
    }

    player setorigin(var_876d2ae2[i].origin);
    player setplayerangles(var_876d2ae2[i].angles);
    waitframe(1);
    player namespace_83eb6304::function_3ecfde67("lightningStrike");
    player namespace_e32bb68::function_3a59ec34("evt_doa_lightning_bolt");
    i = (i + 1) % var_876d2ae2.size;
  }

  foreach(trap in room.var_f9c9c0) {
    trap notify(#"destroy_hazard", {
      #var_760a0807: 1
    });
  }

  foreach(generator in room.generators) {
    if(isDefined(generator.var_64a23077)) {
      distsq = distancesquared(var_876d2ae2[0].origin, generator.var_64a23077.origin);

      if(distsq > sqr(800)) {
        [[generator.var_64a23077.generator]] - > destroy();
        generator.var_64a23077 = undefined;
      }
    }
  }

  level namespace_ec06fe4a::function_de70888a();
  level namespace_7f5aeb59::function_d0251f76();

  foreach(item in room.spawned_items) {
    if(!isDefined(item)) {
      continue;
    }

    distsq = distancesquared(var_876d2ae2[0].origin, item.origin);

    if(distsq > sqr(1024)) {
      item delete();
    }
  }
}

function function_96bd659(inflictor, eattacker, damage, idflags, meansofdeath, weapon, var_fd90b0bb, point, dir, hitloc, offsettime, boneindex, modelindex) {
  if(is_true(level.doa.var_318aa67a)) {
    if(isDefined(boneindex)) {
      distsq = distancesquared(self.origin, boneindex.origin);

      if(distsq > sqr(2048)) {
        return 0;
      } else if(distsq < sqr(512)) {
        modelindex = modelindex;
      } else {
        lerp = 1 - distsq / sqr(2048);
        modelindex = int(lerpfloat(0, modelindex, lerp));
      }
    }
  }

  return modelindex;
}

function function_bbd6f14f(room, openpos, closedpos) {
  level endon(#"hash_7dd47c99b7707b1c");
  self notify("35bd1e44daedf28d");
  self endon("35bd1e44daedf28d");
  var_9b6b2552 = getent("eggxit_margwa_room", "targetname");
  assert(isDefined(var_9b6b2552));
  var_1ed3b211 = struct::get(var_9b6b2552.target, "targetname");
  assert(isDefined(var_1ed3b211));
  open = 0;
  self disconnectpaths();

  while(true) {
    wait 0.5;
    diff = abs(self.origin[2] - openpos[2]);

    if(diff <= 2) {
      if(!open) {
        open = 1;
        self connectpaths();
      }
    } else if(open) {
      open = 0;
      self disconnectpaths();
    }

    diff = abs(self.origin[2] - closedpos[2]);

    if(diff <= 10) {
      foreach(player in getplayers()) {
        if(player istouching(var_9b6b2552)) {
          player setorigin(var_1ed3b211.origin + (randomintrange(-40, 40), randomintrange(-40, 40), 0));
          waitframe(1);
          player namespace_83eb6304::function_3ecfde67("lightningStrike");
          player namespace_e32bb68::function_3a59ec34("evt_doa_lightning_bolt");
        }
      }
    }
  }
}

function function_430e5080(room) {
  level endon(#"hash_7dd47c99b7707b1c");
  self notify("6f89564248735904");
  self endon("6f89564248735904");

  if(!isDefined(room.var_5aafdf7)) {
    room.var_5aafdf7 = self.origin;
  }

  self.origin = room.var_5aafdf7;
  originalpos = self.origin;
  desiredpos = self.origin + (0, 0, -180);

  if(!isDefined(room.var_5aafdf7)) {
    room.var_5aafdf7 = self.origin;
  }

  timedelta = 0;
  self thread function_bbd6f14f(room, desiredpos, originalpos);
  wait 5;
  function_1eaaceab(level.doa.var_6f3d327.var_bf8dbf30);

  foreach(boss in level.doa.var_6f3d327.var_bf8dbf30) {
    if(boss.classname === # "hash_502ad85371f449ed") {
      margwa = boss;
      break;
    }
  }

  if(isDefined(margwa)) {
    assert(margwa.ignoreall == 1, "<dev string:x11f>");
    margwa.ignoreall = 1;
  }

  while(true) {
    self namespace_e32bb68::function_ae271c0b("evt_doa_stonedoor_close");
    self waittill(#"plate_activated");
    deltaz = abs(self.origin[2] - desiredpos[2]);
    timedelta = math::clamp(deltaz / 180 * 5, 0.05, 5);
    self namespace_e32bb68::function_3a59ec34("evt_doa_stonedoor_open");
    self moveto(desiredpos, timedelta);

    if(isDefined(margwa)) {
      margwa.ignoreall = 0;
      margwa.zombie_move_speed = "sprint";
      margwa setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
    }

    return;
  }
}

function function_2f1636cd(room) {
  level endon(#"hash_7dd47c99b7707b1c");
  self notify("723adc9b07be551b");
  self endon("723adc9b07be551b");

  while(true) {
    result = level waittill(#"bonus_ai");

    if(result.ai.classname === # "hash_502ad85371f449ed") {
      result.ai.ignoreall = 1;
    }
  }
}

function function_1d4f93c3(room) {
  level.var_9fa19717 = 1;
  level.doa.var_af74d0b = 1;
  level.doa.var_4425d066 = &function_46f8e766;
  level.doa.var_d5fbd3 = &function_330ded6;
  level.doa.var_8609e0e9 = [# "zombietron_impaler", #"zombietron_pineapplegun", #"zombietron_launcher"];
  level.var_52f56101 = &function_85a06bf3;
  setsaveddvar(#"hash_63212188205e8c27", 1);
  room.var_5214367 = "run";
  level thread function_2f1636cd(room);
  level waittill(#"hash_52ca1213084f29fa");
  setjumpheight(128);
  level thread function_96e96e0f(room);
  var_87f0772a = getent("eggxit_margwa_door", "targetname");
  var_87f0772a thread function_430e5080(room);
  level.overrideactordamage = &function_96bd659;

  foreach(player in getplayers()) {
    player.doa.var_4f3aee7b = 0;
    player clientfield::set_to_player("setCameraSide", 2);
    player allowjump(1);
    player allowcrouch(1);
    player allowslide(1);
    player allowdoublejump(1);
    player allowsprint(1);
    player setstance("stand");
    player allowmantle(0);
    player thread function_8d3502d3();
    player thread function_6a60ea16(2);
    player thread function_270306ac(room);
    player thread function_19dbef9a(room);
  }
}

function function_46f8e766() {
  self.shouldspawn = self.shouldspawn || is_true(self.var_d55f22cb);
  self.var_227e7c79 = !is_true(self.var_d55f22cb);

  if(is_true(self.basic)) {
    self.maxhealth = int(max(self.maxhealth, 5000 + 2000 * getplayers().size));
    self.health = self.maxhealth;
  }

  self.zombie_move_speed = level.doa.var_6f3d327.var_5214367;
  self.engagementdistance = 1800;
  self.var_a84a3d40 = sqr(self.engagementdistance);

  if(!isDefined(level.doa.var_6f3d327.var_bf8dbf30)) {
    level.doa.var_6f3d327.var_bf8dbf30 = [];
  }

  if(is_true(self.boss)) {
    if(!isDefined(level.doa.var_6f3d327.var_bf8dbf30)) {
      level.doa.var_6f3d327.var_bf8dbf30 = [];
    } else if(!isarray(level.doa.var_6f3d327.var_bf8dbf30)) {
      level.doa.var_6f3d327.var_bf8dbf30 = array(level.doa.var_6f3d327.var_bf8dbf30);
    }

    level.doa.var_6f3d327.var_bf8dbf30[level.doa.var_6f3d327.var_bf8dbf30.size] = self;
  }
}

function function_2ee246a7(room) {
  room.var_5214367 = "run";
  level.doa.var_50a26b4f = 1;
  level thread function_1d4f93c3(room);
  aicount = 28;

  if(namespace_4dae815d::function_59a9cf1d() == 0) {
    aicount = [[level.doa.var_39e3fa99]] - > function_c892290a();
    [[level.doa.var_39e3fa99]] - > function_6d5262dc(40);
  }

  level thread function_38de5c23(room, aicount);
}

function function_38de5c23(room, aicount = 28) {
  self notify("720c48f1c7d989d4");
  self endon("720c48f1c7d989d4");
  result = level waittill(#"hash_11a3b1e82b21ec58", #"game_over", #"hash_26543e77189e41db");

  if(result._notify === # "hash_26543e77189e41db" && is_true(result.success)) {
    namespace_7f5aeb59::function_f8645db3(getdvarint(#"hash_1f4204c11443f80a", 1000));
  }

  level.var_9fa19717 = 0;
  level.overrideactordamage = undefined;
  level.var_52f56101 = undefined;
  level.doa.var_af74d0b = 0;
  level.var_40d076a7 = 0;
  level.doa.var_4425d066 = undefined;
  level.doa.var_d5fbd3 = undefined;
  level.doa.var_8609e0e9 = [];
  setsaveddvar(#"hash_63212188205e8c27", 0);

  if(namespace_4dae815d::function_59a9cf1d() == 0 && isDefined(level.doa.var_39e3fa99)) {
    [[level.doa.var_39e3fa99]] - > function_6d5262dc(aicount);
  }

  foreach(player in getplayers()) {
    player clientfield::set_to_player("setCameraSide", 0);
    player namespace_7f5aeb59::function_fae39d88();
  }

  setjumpheight(0);
}

function function_e1911940(room) {
  level waittill(#"hash_7dd47c99b7707b1c");
  level.doa.var_67d8328d = 1;
}

function function_7cbb4f99(room) {
  level thread function_e1911940(room);
}

function function_885d02fd(room) {
  self notify("39092106c3d16e6d");
  self endon("39092106c3d16e6d");
  level waittill(#"hash_7dd47c99b7707b1c");

  foreach(door in room.var_b470c0a1) {
    door namespace_e32bb68::function_ae271c0b("evt_doa_stonedoor_open");
    door namespace_e32bb68::function_ae271c0b("evt_doa_stonedoor_close");
    door namespace_e32bb68::function_ae271c0b("evt_doa_stonedoor_close_fast");
  }

  foreach(trig in room.var_aaea3479) {
    trig triggerenable(0);
  }
}

function function_1dfe9126(room) {
  level endon(#"hash_7dd47c99b7707b1c");
  self notify("1205e69a3a57f0be");
  self endon("1205e69a3a57f0be");
  originalpos = self.origin;
  desiredpos = self.origin + (0, 0, -158);

  while(true) {
    self namespace_e32bb68::function_ae271c0b("evt_doa_stonedoor_close");
    self waittill(#"plate_activated");
    level notify(#"hash_62d02129547fa94a");
    deltaz = abs(self.origin[2] - desiredpos[2]);
    timedelta = math::clamp(deltaz / 158 * 5, 0.05, 5);
    self namespace_e32bb68::function_3a59ec34("evt_doa_stonedoor_open");
    self moveto(desiredpos, timedelta);
    result = self waittill(#"plate_deactivated", #"hash_7e6e589015c9e33d");
    self namespace_e32bb68::function_ae271c0b("stoneDoorOpening");

    if(result._notify == # "hash_7e6e589015c9e33d") {
      self namespace_e32bb68::function_3a59ec34("evt_doa_stonedoor_close_fast");
      self moveto(originalpos, 1);
      return;
    }

    deltaz = abs(self.origin[2] - originalpos[2]);
    timedelta = math::clamp(deltaz / 158 * 5, 0.05, 5);
    self namespace_e32bb68::function_3a59ec34("evt_doa_stonedoor_close");
    self moveto(originalpos, timedelta);
  }
}

function function_c0dff79(room) {
  level endon(#"hash_7dd47c99b7707b1c");
  self notify("31268ba2fbd43ccf");
  self endon("31268ba2fbd43ccf");
  self triggerenable(1);
  done = 0;

  while(true) {
    result = self waittill(#"trigger");

    if(isDefined(result.activator)) {
      if(!is_true(level.doa.var_e5217306)) {
        result.activator thread function_af1f8cd5(self.script_noteworthy);
        level.doa.var_e5217306 = 1;

        foreach(door in room.var_b470c0a1) {
          door notify(#"hash_7e6e589015c9e33d");
        }
      }

      target = struct::get(self.target, "targetname");
      org = namespace_ec06fe4a::spawnmodel(target.origin + (0, 0, 1000), undefined, target.angles, "doom door org");

      if(isDefined(org)) {
        org thread namespace_ec06fe4a::function_52afe5df(1.2);
        org enablelinkto();
        result.activator linkto(org);
        org moveto(target.origin, 1);
        wait 1;
        result.activator unlink();
        result.activator namespace_83eb6304::function_3ecfde67("turret_impact");
        result.activator namespace_e32bb68::function_3a59ec34("evt_doa_pickup_sentry_land");
        result.activator notify(#"hash_25e83871b7d15b33");
        org delete();
        continue;
      }

      result.activator setorigin(target.origin);
      result.activator setplayerangles(target.angles);
    }
  }

  self triggerenable(0);
}

function function_ab6edfa3(room) {
  level.doa.var_e5217306 = undefined;
  level.doa.var_1da3c49e = # "orange";

  if(randomint(100) < 50) {
    level.doa.var_1da3c49e = # "yellow";
  }

  level thread function_27cb8f5b(room);

  if(!isDefined(room.var_b470c0a1)) {
    room.var_b470c0a1 = getEntArray("doom_door", "targetname");
  }

  foreach(door in room.var_b470c0a1) {
    door thread function_1dfe9126(room);
  }

  if(!isDefined(room.var_aaea3479)) {
    room.var_aaea3479 = getEntArray("doom_trig", "targetname");
  }

  foreach(trig in room.var_aaea3479) {
    trig thread function_c0dff79(room);
  }

  level thread function_885d02fd(room);
}

function function_27cb8f5b(room) {
  level endon(#"hash_7dd47c99b7707b1c");
  self notify("2511dc5663ba09f2");
  self endon("2511dc5663ba09f2");
  level waittill(#"hash_62d02129547fa94a");
  level doa_banner::function_7a0e5387(25);
}

function function_af1f8cd5(color) {
  if(!isPlayer(self)) {
    return;
  }

  self endon(#"disconnect");
  level endon(#"game_over");
  self waittill(#"hash_25e83871b7d15b33");

  if(color == level.doa.var_1da3c49e) {
    self namespace_e32bb68::function_3a59ec34("zmb_doom_door_good");
    self namespace_83eb6304::function_3ecfde67("lightningStrike");
    self namespace_e32bb68::function_3a59ec34("evt_doa_lightning_bolt");
    var_6b186658 = 8 + (self.entnum << 4);
    level clientfield::set("banner_eventplayer", var_6b186658);
    level thread namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_extra_life"), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self);
    wait 0.5;
    level thread namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_nuke"), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self);
    wait 0.5;
    level thread namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_nuke"), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self);
    wait 0.5;
    level thread namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_boost"), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self);
    wait 0.5;
    level thread namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_boost"), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self);
    wait 0.5;
    def = namespace_dfc652ee::function_57160cba(6);
    level thread namespace_dfc652ee::itemspawn(def, self.origin, undefined, undefined, 1, undefined, undefined, undefined, self);
    wait 0.5;
    level thread namespace_dfc652ee::itemspawn(def, self.origin, undefined, undefined, 1, undefined, undefined, undefined, self);
    wait 0.5;
    level thread namespace_dfc652ee::itemspawn(def, self.origin, undefined, undefined, 1, undefined, undefined, undefined, self);
    wait 0.5;
    self.doa.var_909a4dd5 = gettime() + 420000;
    level thread namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_chicken"), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self);
    wait 0.5;
    level thread namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_chicken"), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self);
    wait 0.5;
    level thread namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4("zombietron_chicken"), self.origin, undefined, undefined, 1, undefined, undefined, undefined, self);
    return;
  }

  self namespace_e32bb68::function_3a59ec34("zmb_doom_door_bad");
  self namespace_83eb6304::function_3ecfde67("lightningStrike");
  self namespace_e32bb68::function_3a59ec34("evt_doa_lightning_bolt");
  var_6b186658 = 9 + (self.entnum << 4);
  level clientfield::set("banner_eventplayer", var_6b186658);

  if(self.doa.score.bombs > 0) {
    for(take = 7; self.doa.score.bombs > 0 && take > 0; take--) {
      model = namespace_ec06fe4a::spawnmodel(self.origin + (0, 0, 70), "zombietron_nuke", undefined, "doom door bomb");

      if(isDefined(model)) {
        self.doa.score.bombs--;
        model moveto(model.origin + (0, 0, 2000), 3);
        model thread namespace_ec06fe4a::function_52afe5df(3);
        wait 0.25;
      }
    }
  }

  if(self.doa.score.boosts > 0) {
    for(take = 4; self.doa.score.boosts > 0 && take > 0; take--) {
      model = namespace_ec06fe4a::spawnmodel(self.origin + (0, 0, 70), "zombietron_boost", undefined, "doom door boost");

      if(isDefined(model)) {
        model setscale(1.5);
        self.doa.score.boosts--;
        model moveto(model.origin + (0, 0, 2000), 3);
        model thread namespace_ec06fe4a::function_52afe5df(3);
        wait 0.25;
      }
    }
  }

  if(self.doa.score.keys > 0) {
    model = namespace_ec06fe4a::spawnmodel(self.origin + (0, 0, 70), "zombietron_skeleton_key", undefined, "doom door key");

    if(isDefined(model)) {
      model setscale(3);
      self.doa.score.keys--;
      model moveto(model.origin + (0, 0, 2000), 3);
      model thread namespace_ec06fe4a::function_52afe5df(3);
      wait 0.25;
    }
  }

  self namespace_41cb996::function_8b7acf56();
  self thread namespace_eccff4fb::function_1dd66aa1();
  self thread namespace_7f5aeb59::function_ec9a307f(60, undefined, 20);
}

function function_e0548009() {
  level endon(#"game_over");
  level endon(#"hash_2c640197a1e595fa");
  var_a3c55f87 = struct::get("roj_floor", "targetname");

  if(!isDefined(var_a3c55f87)) {
    var_a3c55f87 = spawnStruct();
    var_a3c55f87.origin = (12423, 11721, -837);
  }

  var_dfa53a08 = sqr(1000);

  while(isDefined(level.doa.var_6f3d327)) {
    wait 1;
    enemies = namespace_ec06fe4a::function_8ff7f92c();

    foreach(badguy in enemies) {
      if(badguy.origin[2] < var_a3c55f87.origin[2]) {
        badguy thread namespace_ec06fe4a::function_570729f0(0.3);
      }

      if(isvehicle(badguy)) {
        distsq = distancesquared(var_a3c55f87.origin, badguy.origin);

        if(distsq > var_dfa53a08) {
          badguy thread namespace_ec06fe4a::function_570729f0(0.3);
        }
      }
    }
  }
}

function function_b2706226(room) {
  level endon(#"game_over");
  level flag::set("doa_roj_visited");
  level.doa.var_79574675 = 1;
  level.doa.var_61ee6067 = 1;
  level waittill(#"hash_52ca1213084f29fa");
  wait 4;
  level thread function_e0548009();
  var_30073b02 = 1;
  wavetime = 30;
  level thread namespace_6e90e490::function_c937e51f(wavetime);
  done = 0;

  while(wavetime > 0) {
    done = 1;

    foreach(generator in room.generators) {
      if(isDefined(generator.var_64a23077) && generator.var_64a23077.health > 0) {
        done = 0;
        break;
      }
    }

    if(done) {
      break;
    }

    wavetime--;
    wait 1;
  }

  namespace_6e90e490::function_fa6f7ba7();

  if(!done) {
    var_30073b02 = 0;
  }

  if(var_30073b02) {
    level doa_banner::function_7a0e5387(53);
    wait 3;
    level.doa.var_a598a835 = &function_dff4eac9;
    room.var_dd856bff = struct::get_array("rof_safespot", "targetname");
    var_94f3b914 = doa_enemy::function_d7c5adee("meatball_large");
    count = 7 + getplayers().size * 3;
    spot = function_dff4eac9();
    wavetime = 60 + (getplayers().size < 2 ? 0 : 5);
    doa_enemy::function_a6b807ea(var_94f3b914, count, spot.origin, 0);
    wait 2;
    level.doa.var_a598a835 = undefined;
    level thread namespace_6e90e490::function_c937e51f(wavetime);
    done = 0;

    while(wavetime > 0) {
      done = 1;

      if(namespace_ec06fe4a::function_9788bacc()) {
        done = 0;
      }

      if(done) {
        break;
      }

      if(wavetime == 3) {
        doa_enemy::function_a0acdb92();
      }

      wavetime--;
      wait 1;
    }

    namespace_6e90e490::function_fa6f7ba7();

    if(!done) {
      var_2240c239 = namespace_ec06fe4a::function_9788bacc();

      if(var_2240c239 > 0) {
        var_49d47ba8 = getaiteamarray("<dev string:x150>");

        foreach(ai in var_49d47ba8) {
          level thread namespace_1e25ad94::debugline(getplayers()[0].origin, ai.origin, 30);
        }
      }

      var_30073b02 = 0;
    }
  }

  if(var_30073b02) {
    level doa_banner::function_7a0e5387(54);
    wait 3;
    room.var_dd856bff = struct::get_array("rof_safespot", "targetname");
    bosses = 1;
    numplayers = getplayers().size;

    switch (numplayers) {
      case 1:
        wavetime = 100;
        break;
      case 2:
        wavetime = 80;
        break;
      case 3:
        wavetime = 65;
        break;
      case 4:
        wavetime = 50;
        break;
    }

    if(numplayers >= 3) {
      bosses++;
    }

    while(bosses) {
      if(is_true(level.hostmigrationtimer)) {
        waitframe(1);
        continue;
      }

      if(numplayers == 1) {
        boss = "margwa";
      } else {
        roll = randomint(100);

        if(roll > 70) {
          boss = "werewolf";
        } else if(roll > 40) {
          boss = "gegenees";
        } else {
          boss = "margwa";
        }
      }

      var_94f3b914 = doa_enemy::function_d7c5adee(boss);
      ai = doa_enemy::function_4e8ae191(var_94f3b914, 1, room.origin, 0);

      if(isDefined(ai)) {}

      bosses--;
    }

    wait 2;
    level thread namespace_6e90e490::function_c937e51f(wavetime);
    done = 0;

    while(wavetime > 0) {
      if(is_true(level.hostmigrationtimer)) {
        waitframe(1);
        continue;
      }

      if(wavetime % 20 == 0) {
        for(count = 4 * getplayers().size; count; count--) {
          spot = function_d1e1819d();
          var_94f3b914 = doa_enemy::function_d7c5adee(randomint(100) < 50 ? "gladiator_marauder" : "gladiator_destroyer");
          ai = doa_enemy::function_4e8ae191(var_94f3b914, 1, spot.origin, 0);

          if(isDefined(ai)) {
            ai namespace_83eb6304::function_3ecfde67("electrical_explo");
            ai namespace_83eb6304::function_3ecfde67("lightningStrike");
            ai thread namespace_ec06fe4a::function_570729f0(90);
          }
        }
      }

      done = 1;

      if(namespace_ec06fe4a::function_9788bacc()) {
        done = 0;
      }

      if(done) {
        break;
      }

      wavetime--;
      wait 1;
    }

    namespace_6e90e490::function_fa6f7ba7();

    if(!done) {
      var_30073b02 = 0;
    }
  }

  level notify(#"hash_2c640197a1e595fa");
  level.doa.var_79574675 = undefined;

  foreach(generator in room.generators) {
    if(isDefined(generator.var_64a23077)) {
      [[generator.var_64a23077.generator]] - > destroy();
      generator.var_64a23077 = undefined;
    }
  }

  level.doa.var_61ee6067 = undefined;
  room.generators = [];
  namespace_ec06fe4a::function_de70888a(1);
  namespace_1c2a96f9::function_41d66855(var_30073b02);
  room notify(#"room_done");
}

function function_dff4eac9() {
  spawnloc = spawnStruct();

  if(randomint(100) < 90) {
    spot = level.doa.var_6f3d327.var_dd856bff[randomint(level.doa.var_6f3d327.var_dd856bff.size)];
    spawnloc.origin = spot.origin + (0, 0, 765);
    spawnloc.angles = spot.angles;
  } else {
    player = getplayers()[randomint(getplayers().size)];
    spawnloc.origin = player.origin + (0, 0, 765);
    spawnloc.angles = player.angles;
  }

  return spawnloc;
}

function function_d1e1819d() {
  if(isDefined(level.doa.var_6f3d327.var_dd856bff)) {
    return level.doa.var_6f3d327.var_dd856bff[randomint(level.doa.var_6f3d327.var_dd856bff.size)];
  }

  spawnloc = spawnStruct();
  player = getplayers()[randomint(getplayers().size)];
  spawnloc.origin = player.origin;
  spawnloc.angles = player.angles;
  return spawnloc;
}