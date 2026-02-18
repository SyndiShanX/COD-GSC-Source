/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_50fca1a24ae351.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ce46999727f2f2b;
#using script_1ee011cd0961afd7;
#using script_2474a362752098d2;
#using script_2a5bf5b4a00cee0d;
#using script_2c9915120c137848;
#using script_2e9202713de2b353;
#using script_3bbf85ab4cb9f3c2;
#using script_3faf478d5b0850fe;
#using script_40f967ad5d18ea74;
#using script_41fbdfb1149a433e;
#using script_47851dbeea22fe66;
#using script_48e04a393ec6d855;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_6ad6653eed415ffc;
#using script_6b6510e124bad778;
#using script_73ad7687b437e468;
#using script_746267f0669c40ae;
#using script_74a56359b7d02ab6;
#using script_774302f762d76254;
#using script_dc59353021baee1;
#using script_f38dc50f0e82277;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_981c1f3c;

function init() {
  level.doa.var_43cb2d40 = [];
  level.doa.teleporter_locs = [];
  level.doa.var_a8a563fc = [];
  level.doa.var_783e7439 = [];
  level flag::init("dungeon_building", 0);
  clientfield::register("world", "world_dungeon_set", 1, 8, "int");
  clientfield::register("world", "world_dungeon_build", 1, 1, "counter");
  clientfield::register("world", "world_dungeon_destroy", 1, 1, "counter");
  level.var_3dd67d2d = &function_c153f40;
  namespace_c9c45ed8::init();
  namespace_5849a337::init();
  namespace_22574328::init();
  namespace_40bb01c9::init();
  namespace_1dc364c0::init();
  main();
}

function main() {
  if(isDefined(level.doa.var_182fb75a)) {
    level thread function_8790b64a();
  }

  foreach(topper in level.doa.var_43cb2d40) {
    topper delete();
  }

  level.doa.var_43cb2d40 = [];
  level.doa.var_c93506fb = undefined;
  level.doa.var_eeff50c8 = getEntArray("dungeon_generator", "targetname");
  level.doa.var_dfe4682 = 0;

  foreach(trigger in level.doa.var_eeff50c8) {
    idx = function_61e1a1cb(trigger.target);
    level.doa.dungeons[idx].var_9105f204 = array(level.doa.var_65a70dc);

    if(isDefined(trigger.script_parameters)) {
      var_f589486f = strtok(trigger.script_parameters, ";");

      foreach(ai in var_f589486f) {
        if(!isDefined(level.doa.dungeons[idx].var_9105f204)) {
          level.doa.dungeons[idx].var_9105f204 = [];
        } else if(!isarray(level.doa.dungeons[idx].var_9105f204)) {
          level.doa.dungeons[idx].var_9105f204 = array(level.doa.dungeons[idx].var_9105f204);
        }

        level.doa.dungeons[idx].var_9105f204[level.doa.dungeons[idx].var_9105f204.size] = doa_enemy::function_d7c5adee(ai);
      }
    }

    level.doa.dungeons[idx].var_40ca2d09 = array(doa_enemy::function_d7c5adee("meatball_large"));
    trigger thread function_ec0b503f(trigger.target);
  }
}

function function_470f56e6(origin, ignore, var_fcfb8b8d = 1) {
  foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
    if(player === ignore) {
      continue;
    }

    if(!isalive(player) || is_true(player.doa.respawning)) {
      player namespace_7f5aeb59::function_513831e1();
    }

    player notify(#"hash_279998c5df86c04d");
    vehicle = player getvehicleoccupied();

    if(isDefined(vehicle)) {
      vehicle.var_3e742dc1 = 1;
      vehicle usevehicle(player, 0);
    }

    if(var_fcfb8b8d) {
      player notify(#"hash_7893364bd228d63e");
    }
  }

  foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
    if(player === ignore) {
      continue;
    }

    player setorigin(origin);
  }
}

function function_ec0b503f(var_499e2f80) {
  self endon(#"death");
  level endon(#"game_over");
  self notify("17273a2d0c87b864");
  self endon("17273a2d0c87b864");
  idx = function_61e1a1cb(var_499e2f80);
  assert(isDefined(idx), "<dev string:x38>");
  topper = struct::get(var_499e2f80 + "_topper", "targetname");
  var_8f13e4c5 = getent(var_499e2f80 + "_WaitVolume", "targetname");
  startnode = struct::get(var_499e2f80, "targetname");
  assert(isDefined(startnode), "<dev string:x8a>");
  assert(isDefined(startnode.target), "<dev string:xac>");
  var_3a27fe75 = struct::get(startnode.target, "targetname");
  result = self waittill(#"trigger");

  if(isDefined(level.doa.var_182fb75a)) {
    self thread function_ec0b503f(var_499e2f80);
    return;
  }

  profilestart();

  foreach(player in getplayers()) {
    player notify(#"hash_279998c5df86c04d");
    player thread namespace_7f5aeb59::turnplayershieldon(0);

    if(level.doa.dungeons[idx].policy == 0) {
      player notify(#"hash_7893364bd228d63e");
    }
  }

  level thread function_470f56e6(self.origin, result.activator, level.doa.dungeons[idx].policy == 0);
  objective_setstate(12, "invisible");
  level.doa.var_70bd361d = level.doa.dungeons[idx].policy;
  level thread namespace_ec06fe4a::function_de70888a(1, 1);
  level.doa.var_e84586f1 = var_3a27fe75;
  level.doa.var_783e7439 = struct::get_array(self.target + "_pickup", "targetname");
  level thread function_600ea4f();
  level.doa.var_36d8eb11 = undefined;
  level.doa.var_d94cfb75 = gettime();
  level.doa.var_a7ccb320 = undefined;
  profilestop();
  level function_c88b8726(idx);
  level doa_banner::function_7a0e5387(16);
  level thread namespace_9fc66ac::announce(61);
  level.doa.var_5b55ba1f = namespace_4dae815d::function_21cd3890(5);

  if(isDefined(var_8f13e4c5)) {
    namespace_7f5aeb59::function_a8b57c52(var_8f13e4c5.origin, var_8f13e4c5.angles, result.activator, var_8f13e4c5);
  }

  if(is_true(level.doa.var_c93506fb)) {
    self thread function_ec0b503f(var_499e2f80);
  }

  if(!is_true(level.doa.var_c93506fb) && isDefined(topper)) {
    if(isDefined(topper.script_noteworthy)) {
      var_2436e1b = namespace_ec06fe4a::spawnmodel(topper.origin, topper.script_noteworthy);

      if(isDefined(var_2436e1b)) {
        var_2436e1b.angles = topper.angles;
        var_2436e1b solid();
        level.doa.var_43cb2d40[level.doa.var_43cb2d40.size] = var_2436e1b;
        self.topper = var_2436e1b;
        var_2436e1b namespace_83eb6304::function_3ecfde67("explode_lg");
      }
    }
  }

  foreach(player in getplayers()) {
    player thread function_fe17d41e();

    if(!isDefined(level.doa.var_6f3d327)) {
      player namespace_6e90e490::showhint(8);
      level.doa.var_dfe4682++;
    }

    player clientfield::increment_to_player("hardResetCamera");
  }
}

function function_fe17d41e() {
  level endon(#"dungeon_cleanup", #"dungeon_destroyed");
  self endon(#"disconnect");

  while(true) {
    groundent = self getgroundent();

    if(isDefined(groundent) && groundent ismovingplatform() && groundent function_2ad80b99()) {
      self.doa.var_2fb8ffeb = groundent;

      if(is_true(groundent.tweakcam)) {
        if(!is_true(self.doa.var_af150b2c)) {
          self.doa.var_af150b2c = 1;
          self clientfield::set_to_player("setCameraDown", groundent.var_95773ba5);
        }
      } else if(is_true(self.doa.var_af150b2c)) {
        self.doa.var_af150b2c = 0;
        self clientfield::set_to_player("setCameraDown", 0);
      }

      if(groundent.var_ae9c1083 !== 1) {
        if(isDefined(groundent)) {
          groundent clientfield::set("dungeon_set_explore_state", 1);
        }

        groundent.var_ae9c1083 = 1;
      }
    }

    wait 0.25;
  }
}

function function_61e1a1cb(name) {
  for(i = 0; i < level.doa.dungeons.size; i++) {
    if(level.doa.dungeons[i].name === name) {
      return i;
    }
  }
}

function function_56bd9d70(idx) {
  assert(idx > -1 && idx < level.doa.dungeons.size);
  return level.doa.dungeons[idx].name;
}

function function_8790b64a() {
  level.doa.var_d31bcf30 = 1;
  level clientfield::increment("world_dungeon_destroy", 1);
  util::wait_network_frame();
  level namespace_c85a46fe::function_edfcfa44(2);
  namespace_ec06fe4a::function_de70888a();
  namespace_ec06fe4a::function_b6b79fd1();
  util::wait_network_frame();
  level thread namespace_95fdc800::function_b1989480();
  level waittill(#"hash_29a1cf6b91759f63");
  namespace_5849a337::function_2d3e0ee4();
  namespace_22574328::function_da7439a2();
  namespace_491fa2b2::function_df55eb9d(2);
  namespace_a6056a45::function_e2f97f03(2);
  waitframe(1);
  namespace_40bb01c9::function_ddb3fb8f();
  waitframe(1);

  foreach(item in level.doa.var_783e7439) {
    if(isDefined(item.pickup)) {
      item.pickup delete();
      item.pickup = undefined;
    }
  }

  level.doa.var_783e7439 = [];
  level.doa.var_d1501142 = [];
  level.doa.var_51400a66 = [];
  level.doa.var_f5a14209 = [];
  level.doa.var_182fb75a = undefined;
  level.doa.var_187ed224 = undefined;

  if(isDefined(level.doa.var_9f48249a)) {
    level.doa.var_9f48249a namespace_83eb6304::turnofffx("teleporter_dungeon_light");
    util::wait_network_frame();

    if(isDefined(level.doa.var_9f48249a.trigger)) {
      level.doa.var_9f48249a.trigger delete();
    }

    if(isDefined(level.doa.var_9f48249a)) {
      level.doa.var_9f48249a delete();
    }

    level.doa.var_9f48249a = undefined;
  }

  level notify(#"dungeon_destroyed");
  level.doa.var_d31bcf30 = undefined;
  level.doa.var_98764e02 = gettime();
}

function function_4be92bcc(idx, seconds) {
  var_80d530a9 = {};
  var_80d530a9.name = function_56bd9d70(idx);
  var_80d530a9.buildtime = seconds;
  var_80d530a9.tiles = level.var_c97eeeb4.size;
  var_80d530a9.rooms = level.var_d5561d56;
  var_80d530a9.halls = level.var_5d40e975;
  var_80d530a9.players = namespace_7f5aeb59::function_f08b75c1();
  var_80d530a9.var_a98f4fd2 = [];

  foreach(tileid in level.doa.var_830f8412) {
    tile = {
      #name: tileid, #count: level.doa.var_4cdaff39[tileid]
    };

    if(!isDefined(var_80d530a9.var_a98f4fd2)) {
      var_80d530a9.var_a98f4fd2 = [];
    } else if(!isarray(var_80d530a9.var_a98f4fd2)) {
      var_80d530a9.var_a98f4fd2 = array(var_80d530a9.var_a98f4fd2);
    }

    var_80d530a9.var_a98f4fd2[var_80d530a9.var_a98f4fd2.size] = tile;
  }

  level.doa.var_fa21a3aa += var_80d530a9.tiles;
  level.doa.var_f23e2931 += var_80d530a9.halls;
  level.doa.var_f5f2b4e8 += var_80d530a9.rooms;
}

function function_c88b8726(index) {
  profilestart();
  assert(!isDefined(level.doa.var_187ed224), "<dev string:xd3>");

  if(!isDefined(level.doa.var_a354a42f)) {
    level.doa.var_a354a42f = 1;
  }

  level flag::set("dungeon_building");
  level.var_d5561d56 = 0;
  level.var_5d40e975 = 0;
  level.doa.var_5db3d0bc = [];
  level.doa.var_f5a14209 = [];
  level.doa.var_d1501142 = [];
  level.var_f9c83ade = 0;
  level.doa.var_182fb75a = index;
  profilestop();
  namespace_ec06fe4a::function_de70888a();
  namespace_1e25ad94::debugmsg("Creating a new Dungeon! Instance# " + level.doa.var_a354a42f);
  level.doa.var_a354a42f++;
  level clientfield::set("world_dungeon_set", index);
  util::wait_network_frame();
  level clientfield::increment("world_dungeon_build", 1);
  namespace_95fdc800::function_d6e32b1b();
  level.doa.var_187ed224 = namespace_95fdc800::function_1bce4bde(level.doa.dungeons[index].name);
  wait 0.6;
  level util::set_lighting_state(3, 0);
}

function function_30697e3b() {
  assert(level.doa.dungeons[level.doa.var_182fb75a].var_9105f204.size);
  return level.doa.dungeons[level.doa.var_182fb75a].var_9105f204[randomint(level.doa.dungeons[level.doa.var_182fb75a].var_9105f204.size)];
}

function function_1a775179() {
  assert(level.doa.dungeons[level.doa.var_182fb75a].var_40ca2d09.size);
  return level.doa.dungeons[level.doa.var_182fb75a].var_40ca2d09[randomint(level.doa.dungeons[level.doa.var_182fb75a].var_40ca2d09.size)];
}

function function_fd83ca7f() {
  self notify("5fa33b4e47fc689c");
  self endon("5fa33b4e47fc689c");
  level endon(#"dungeon_cleanup", #"dungeon_destroyed");

  while(true) {
    result = self waittill(#"hash_4c72e79bdad8315e");
    result.ai.var_f979e699 = 0;
  }
}

function function_3574d58() {
  self notify("4631b6bca4600740");
  self endon("4631b6bca4600740");
  level endon(#"dungeon_cleanup", #"dungeon_destroyed");
  self endon(#"death");

  while(true) {
    result = self waittill(#"hash_4c72e79bdad8315e");

    if(!isDefined(level.doa.var_35c4260d)) {
      level.doa.var_35c4260d = [];
    } else if(!isarray(level.doa.var_35c4260d)) {
      level.doa.var_35c4260d = array(level.doa.var_35c4260d);
    }

    level.doa.var_35c4260d[level.doa.var_35c4260d.size] = result.ai;
    result.ai.var_f979e699 = 0;
  }
}

function doaenemyfillerfodder() {
  level endon(#"dungeon_cleanup", #"dungeon_destroyed");
  self notify("b40686875632ffd");
  self endon("b40686875632ffd");
  wait 15;
  level thread function_fd83ca7f();
  level.doa.var_35c4260d = [];
  var_764338c3 = namespace_ec06fe4a::spawnorigin((0, 0, 0));

  if(isDefined(var_764338c3)) {
    var_764338c3.targetname = "doaEnemyFillerFodder";
    var_764338c3 thread function_3574d58();
    var_764338c3 thread namespace_ec06fe4a::function_d55f042c(level, "dungeon_cleanup");
    var_764338c3 thread namespace_ec06fe4a::function_d55f042c(level, "dungeon_destroyed");
  }

  while(true) {
    if(namespace_ec06fe4a::function_9788bacc() < 4) {
      players = function_a1ef346b();

      if(players.size > 1) {
        player = players[randomint(players.size)];
      } else {
        player = players[0];
      }

      var_43f8c3d2 = [];

      if(isDefined(player)) {
        var_43f8c3d2 = arraysortclosest(level.doa.var_d1501142, player.origin, 4, 1200, 2048);
      }

      if(var_43f8c3d2.size) {
        spawnorigin = var_43f8c3d2[randomint(var_43f8c3d2.size)];
        count = randomint(8);
        doa_enemy::function_a6b807ea(function_30697e3b(), count, spawnorigin, 36, undefined, player, level);
      }
    }

    if(randomint(100) == 0) {
      arrayremovevalue(level.doa.var_35c4260d, undefined);

      if(level.doa.var_35c4260d.size < 3) {
        var_43f8c3d2 = [];

        if(isDefined(player)) {
          var_43f8c3d2 = arraysortclosest(level.doa.var_d1501142, player.origin, 4, 1200, 2048);
        }

        if(var_43f8c3d2.size) {
          spawnorigin = var_43f8c3d2[randomint(var_43f8c3d2.size)];
          doa_enemy::function_a6b807ea(function_1a775179(), 1, spawnorigin, 0, undefined, player, var_764338c3);
        }
      }
    }

    wait randomintrange(2, 4);
  }
}

function function_600ea4f() {
  retval = level waittilltimeout(30, #"hash_db5742cf48f5e5");

  if(retval._notify == # "timeout") {
    namespace_1e25ad94::function_4e3cfad("\tDungeon creation timeout!", (1, 0, 0), undefined, 1.5, 1000);
    namespace_1e25ad94::debugmsg("Dungeon creation timeout!", 1);
  }

  if(level.doa.teleporter_locs.size > 0) {
    if(isDefined(level.doa.var_187ed224)) {
      level.doa.teleporter_locs = arraysortclosest(level.doa.teleporter_locs, level.doa.var_187ed224.origin);
    }

    furthest = level.doa.teleporter_locs[level.doa.teleporter_locs.size - 1];
    level.doa.teleporter_locs = [];
    level.doa.var_9f48249a = namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_2c9923d7(39), furthest.origin, undefined, undefined, 1);
    level.doa.var_9f48249a namespace_83eb6304::function_3ecfde67("teleporter_dungeon_light");
    level.doa.var_9f48249a clientfield::set("set_icon", 9);
    level.doa.var_9f48249a notify(#"hash_2a866f50cc161ca8");
    objective_onentity(13, level.doa.var_9f48249a);
    objective_setstate(13, "active");
    objective_setstate(12, "invisible");
  }

  foreach(pickup in level.doa.var_783e7439) {
    if(!isDefined(pickup.script_noteworthy)) {
      continue;
    }

    item = namespace_dfc652ee::itemspawn(namespace_dfc652ee::function_6265bde4(pickup.script_noteworthy), pickup.origin, undefined, undefined, 1);

    if(isDefined(pickup.modelscale)) {
      item setscale(pickup.modelscale);
      item notify(#"hash_2a866f50cc161ca8");
    }

    pickup.pickup = item;
  }

  level thread function_73730269(level.doa.var_9f48249a);
}

function function_c153f40() {
  level notify(#"hash_db5742cf48f5e5");

  if(isDefined(level.doa.var_d94cfb75)) {
    level.doa.var_b5f24666 = gettime();
    seconds = (level.doa.var_b5f24666 - level.doa.var_d94cfb75) / 1000;
    function_4be92bcc(level.doa.var_182fb75a, seconds);
    namespace_1e25ad94::function_4e3cfad("\tDungeon built in : " + seconds + " seconds.Tiles: " + level.var_c97eeeb4.size + " Rooms: " + level.var_d5561d56 + " Halls: " + level.var_5d40e975, undefined, undefined, undefined, 10);
  }

  level thread namespace_5849a337::function_fabbde0d();
  level thread namespace_22574328::function_b9c8a739();
  level thread namespace_40bb01c9::function_f69dda63();

  if(isDefined(level.doa.var_a77e6349)) {
    [[level.doa.var_a77e6349]] - > function_1137c8bb();
    [[level.doa.var_a77e6349]] - > function_464d882c();
  }

  foreach(generator in level.doa.var_8acd67ef) {
    if([[generator]] - > function_30a0163e() == 0) {
      [[generator]] - > getmodel() namespace_c85a46fe::function_47c860ff(0);
    }
  }

  setsaveddvar(#"hkai_navmeshusehierarchialpathfind", 0);
  level thread doaenemyfillerfodder();
  level notify(#"hash_4d5f7cfb3c3f1c9e");
  level flag::clear("dungeon_building");

  if(isDefined(level.doa.var_a7ccb320)) {
    [[level.doa.var_a7ccb320]]();
  }

  foreach(player in getplayers()) {
    player thread function_10d89d49();
  }
}

function function_10d89d49() {
  self notify("19141bf095382546");
  self endon("19141bf095382546");
  self endon(#"disconnect");
  level endon(#"game_over", #"dungeon_cleanup", #"dungeon_destroyed");
  wait 1;

  while(isDefined(level.doa.var_182fb75a)) {
    basez = level.doa.var_187ed224.origin[2] - 256;

    if(self.origin[2] <= basez) {
      namespace_1e25ad94::debugmsg("Player " + self.name + " FELL out of the active dungeon at location: " + self.origin + "Failsafe warp to start point: " + level.doa.var_187ed224.origin, 1);
      self setorigin(level.doa.var_187ed224.origin);
    }

    wait 1;
  }
}

function function_73730269(var_f3c8eb3) {
  self notify("7457a4fbe260415c");
  self endon("7457a4fbe260415c");
  level endon(#"game_over");
  level thread namespace_ec06fe4a::function_87612422(level.doa.var_e84586f1.origin, level.doa.var_e84586f1.angles, 0.5, 999999999, level.var_564dda4);
  result = level waittill(#"ladder_up", #"game_over");

  if(result._notify == # "ladder_up" && result.pickup === var_f3c8eb3) {
    namespace_7f5aeb59::function_f8645db3(getdvarint(#"hash_2a014ab8179901f4", 500));

    foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
      player giveachievement(#"doa_achievement_dungeondiver");
      player namespace_d2efac9a::function_cb7b5503();

      if(isDefined(player.doa.var_fe639705)) {
        player[[player.doa.var_fe639705]](level.doa.dungeons[level.doa.var_182fb75a].type);
      }
    }
  }

  level notify(#"dungeon_cleanup");
  level notify(#"rg_abort");

  if(isDefined(var_f3c8eb3)) {
    var_f3c8eb3 namespace_83eb6304::turnofffx("teleporter_dungeon_light");
  }

  level thread namespace_ec06fe4a::function_87612422(level.doa.var_e84586f1.origin, level.doa.var_e84586f1.angles, 1, 8, level.var_564dda4);
  setsaveddvar(#"hkai_navmeshusehierarchialpathfind", 1);
  objective_setstate(13, "invisible");
  level namespace_c85a46fe::function_edfcfa44(2);
  namespace_ec06fe4a::function_de70888a();
  namespace_ec06fe4a::function_b6b79fd1();
  level thread namespace_7f5aeb59::function_67f054d7();
  level waittill(#"hash_1b322de3d2e3e781");
  level notify(#"hash_7893364bd228d63e");
  level function_8790b64a();
  namespace_1e25ad94::function_4e3cfad("\tDungeon destroyed", undefined, undefined, undefined, 10);

  foreach(player in getplayers()) {}

  if(result._notify === "game_over") {
    return;
  }

  namespace_7f5aeb59::function_a8b57c52(level.doa.var_e84586f1.origin, level.doa.var_e84586f1.angles);

  foreach(player in namespace_7f5aeb59::function_23e1f90f()) {
    player clientfield::increment_to_player("resetCamera");
  }

  level.doa.var_e84586f1 = undefined;
  level.doa.var_70bd361d = undefined;
  namespace_4dae815d::function_21cd3890(level.doa.var_5b55ba1f);
  level thread namespace_7f5aeb59::function_836aeb74();
  objective_setstate(12, "active");
  oldstate = level.var_564dda4;
  level util::set_lighting_state(oldstate, 0);
  level clientfield::set("setTOD", oldstate);

  if(isDefined(level.doa.var_a77e6349)) {
    [[level.doa.var_a77e6349]] - > function_90de0b96();
    [[level.doa.var_a77e6349]] - > function_ce6bb21b();
  }

  foreach(generator in level.doa.var_8acd67ef) {
    [[generator]] - > getmodel() namespace_c85a46fe::function_47c860ff(1);
  }

  level notify(#"hash_df3bb53ea54541f");
}