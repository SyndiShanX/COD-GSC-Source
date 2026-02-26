/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_19367cd29a4485db.gsc
***********************************************/

#using script_16b1b77a76492c6a;
#using script_2618e0f3e5e11649;
#using script_3357acf79ce92f4b;
#using script_3411bb48d41bd3b;
#using script_7a5293d92c61c788;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\blackboard;
#using scripts\core_common\ai\zombie_death;
#using scripts\core_common\ai\zombie_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\armor;
#using scripts\core_common\array_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\content_manager;
#using scripts\core_common\dev_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\popups_shared;
#using scripts\core_common\rank_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_squad;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_utility;
#namespace namespace_420b39d3;

function private autoexec __init__system__() {
  system::register(#"hash_3a0015e9f67cadaf", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  util::init_dvar(#"hash_3a0015e9f67cadaf", "<dev string:x38>", &function_8cf627fd);
  util::init_dvar(#"hash_46ea982132a001ec", 0, &function_f1f26ccb);
}

function private postinit() {
  level thread function_76de3950();
}

function function_76de3950() {
  infovolumedebuginit();
  function_6f31d177();
  function_c4fe091c();

  if(is_true(level.aat_in_use)) {
    level thread aat::setup_devgui("<dev string:x3c>");
    util::add_debug_command("<dev string:x68>");
  }

  util::add_debug_command("<dev string:xba>");
  util::waittill_can_add_debug_command();

  if(isDefined(level.var_c0f77370)) {
    level thread[[level.var_c0f77370]]();
  }

  util::waittill_can_add_debug_command();

  if(isDefined(level.var_633b283d)) {
    level thread[[level.var_633b283d]]();
  }

  util::waittill_can_add_debug_command();

  if(isDefined(level.var_f793af68)) {
    level thread[[level.var_f793af68]]();
  }

  util::waittill_can_add_debug_command();

  if(isDefined(level.var_6aa829ef)) {
    level thread[[level.var_6aa829ef]]();
  }

  util::waittill_can_add_debug_command();

  if(isDefined(level.var_800654fc)) {
    level thread[[level.var_800654fc]]();
  }
}

function private function_6f31d177() {
  var_d9c347d9 = struct::get_array("<dev string:x10b>", "<dev string:x11a>");

  foreach(var_aafdab5f in var_d9c347d9) {
    if(isDefined(var_aafdab5f.target)) {
      a_s_spawns = struct::get_array(var_aafdab5f.targetname, "<dev string:x131>");

      foreach(n_index, s_spawn in a_s_spawns) {
        util::add_debug_command("<dev string:x13b>" + var_aafdab5f.target + "<dev string:x165>" + n_index + "<dev string:x170>" + var_aafdab5f.target + "<dev string:x197>" + n_index + "<dev string:x19c>");
      }

      util::add_debug_command("<dev string:x13b>" + var_aafdab5f.target + "<dev string:x1a1>" + var_aafdab5f.target + "<dev string:x19c>");
    }
  }

  util::add_debug_command("<dev string:x1d9>");
}

function private function_c4fe091c() {
  util::add_debug_command("<dev string:x22a>");
  util::add_debug_command("<dev string:x286>");
  util::add_debug_command("<dev string:x2de>");
  util::add_debug_command("<dev string:x342>");
  util::add_debug_command("<dev string:x39e>");
  util::add_debug_command("<dev string:x3f2>");
  util::add_debug_command("<dev string:x442>");
  util::add_debug_command("<dev string:x4a0>");
  util::add_debug_command("<dev string:x4ff>");
  util::add_debug_command("<dev string:x557>");
  var_de82b392 = function_19df1c1c();

  foreach(str_aitype in var_de82b392) {
    str_aitype = function_9e72a96(str_aitype);
    util::add_debug_command("<dev string:x5ac>" + str_aitype + "<dev string:x5c8>" + str_aitype + "<dev string:x19c>");
    util::add_debug_command("<dev string:x5ac>" + str_aitype + "<dev string:x5fd>" + str_aitype + "<dev string:x19c>");
    util::add_debug_command("<dev string:x5ac>" + str_aitype + "<dev string:x62f>" + str_aitype + "<dev string:x19c>");
  }
}

function function_8cf627fd(params) {
  self notify("<dev string:x664>");
  self endon("<dev string:x664>");
  waitframe(1);

  if(!isDefined(params.value)) {
    return;
  }

  cmd = strtok(params.value, "<dev string:x678>");

  if(!cmd.size) {
    return;
  }

  switch (cmd[0]) {
    case # "hash_2e685b829361da56":
      function_867e712a({
        #value: !is_true(level.var_be5f7304)
      });
      level.var_be5f7304 = !is_true(level.var_be5f7304);
      break;
    case # "hash_47552ceecca70bbf":
      function_ad391a04({
        #value: !is_true(level.var_120cb74c)
      });
      level.var_120cb74c = !is_true(level.var_120cb74c);
      break;
    case # "hash_1601070d585ddd81":
      function_3fe9e6d5({
        #value: !is_true(level.var_2602effb)
      });
      level.var_2602effb = !is_true(level.var_2602effb);
      break;
    case # "hash_7ac289b5f23d2a16":
      function_42d3c9f5({
        #value: cmd[1]
      });
      break;
    case # "aitype_spawn":
      spawn_aitype(cmd[1]);
      break;
    case # "aitype_kill":
      function_e645d51a(level.var_a46cf88a, cmd[1]);
      break;
    case # "hash_577941bb0dacd434":
      function_e645d51a(getaiarray(), cmd[1]);
      break;
    case # "defend_setup":
      array::thread_all(function_a1ef346b(), &zm_devgui::function_8d799ebd);
      break;
    case # "hash_1f1842f8525e2b9e":
      array::thread_all(function_a1ef346b(), &zm_devgui::zombie_devgui_give_money, 50);
      break;
    case # "hash_122c4df3e2c0a31e":
      array::thread_all(function_a1ef346b(), &zm_devgui::zombie_devgui_give_money, 100);
      break;
    case # "hash_346579f3f60438aa":
      array::thread_all(function_a1ef346b(), &zm_devgui::zombie_devgui_give_money, 500);
      break;
    case # "hash_ca6d38b092c2dae":
      array::thread_all(function_a1ef346b(), &zm_devgui::zombie_devgui_give_money, 5000);
      break;
    case # "hash_27d4bc4bf6d98bdf":
      array::thread_all(function_a1ef346b(), &namespace_dd7e54e3::function_b2f69241);
      break;
    case # "hash_67c3788855e430dd":
      array::thread_all(function_a1ef346b(), &namespace_dd7e54e3::give_armor, #"armor_item_lv1_t9_sr");
      break;
    case # "hash_67c3758855e42bc4":
      array::thread_all(function_a1ef346b(), &namespace_dd7e54e3::give_armor, #"armor_item_lv2_t9_sr");
      break;
    case # "hash_67c3768855e42d77":
      array::thread_all(function_a1ef346b(), &namespace_dd7e54e3::give_armor, #"armor_item_lv3_t9_sr");
      break;
    case # "hash_278d3011e8daefc9":
      var_cc6e64ae = getdvarint(#"hash_7255c78e5d6bfa33", -1);

      if(isDefined(level.var_37778628)) {
        [[level.var_37778628]](var_cc6e64ae);
      }

      break;
    case # "hash_68b02f0279a6018a":
      level.var_c7552541 = !is_true(level.var_c7552541);

      if(level.var_c7552541) {
        level thread debug_attackables();
      } else {
        level notify(#"debug_attackables");
      }

      break;
    case # "hash_79295473b7f29d5":
      var_9965967d = namespace_ce1f29cc::function_fac3e87c();
      var_625b64e6 = namespace_2c949ef8::function_10c88d2e();
      spawns = arraycombine(&var_9965967d, &var_625b64e6, 0);
      level thread function_46997bdf(&spawns, "<dev string:x67d>");
      break;
    case # "hash_6c29b11ea918c7bb":
      var_9965967d = namespace_ce1f29cc::function_fac3e87c();
      var_625b64e6 = namespace_2c949ef8::function_10c88d2e();
      spawns = arraycombine(&var_9965967d, &var_625b64e6, 0);
      function_70e877d7(&spawns);
      break;
    case # "hash_5f4a68bd8f1d951c":
      if(!level flag::get(#"hash_2948fbc2709393c1")) {
        level thread function_34f85f1b(#"hash_2948fbc2709393c1");
      } else {
        level flag::clear(#"hash_2948fbc2709393c1");
      }

      break;
    case # "hash_4dcde390e34421ba":
      if(!level flag::get(#"hash_7c64d48a72acee19")) {
        level thread function_34f85f1b(#"hash_7c64d48a72acee19", 0);
      } else {
        level flag::clear(#"hash_7c64d48a72acee19");
      }
    case # "hash_17f656e4906d263d":
      zombies = getaiarchetypearray(#"zombie");

      foreach(zombie in zombies) {
        zombie zombie_utility::set_zombie_run_cycle_override_value("<dev string:x68f>");
      }

      break;
    case # "hash_58f657c627e51661":
      level.var_f662b93f = !is_true(level.var_f662b93f);

      if(level.var_f662b93f) {
        getplayers()[0] thread function_df5be8b2();
      } else {
        level notify(#"hash_624d34392463b628");
      }

      break;
    case # "hash_3d82e58502d3b9a7":
      function_f9023d3a();
      break;
    case # "hash_166eb0846966ee22":
      function_c78fe37a();
      break;
    case # "hash_51e79de8f027c5e1":
      function_71797cab();
      break;
    case # "hash_5814e765f67e3421":
      function_dabc0bfe();

      if(isDefined(level.var_29cf6901)) {
        level.var_29cf6901 = undefined;
        level notify(#"hash_38fcca4f222bb813");
      }

      break;
    case # "hash_10568fdee341e234":
      function_832956c9();
      break;
    case # "hash_77b350e55c00c7f2":
      function_60cf1e76();
      break;
    case # "hash_15ba5e2d53488ef6":
      level.var_29cf6901.repeat = !is_true(level.var_29cf6901.repeat);
      level thread function_58e8b7e3();
      break;
    case # "hash_4f637a6935df3a1c":
      level thread function_b104a7cb();
      break;
    case # "hash_34eaa65aa218e34c":
      level function_e77b67f(params, 1);
      break;
    case # "hash_2a07c5c2234c0125":
      level function_e77b67f(params, 0);
      break;
    case # "hash_6e8b16b2c5467b11":
      level notify(#"exfil_complete", {
        #b_success: 1
      });
      break;
    case # "hash_51c4d89a493056a":
      level.var_12f54bf = !is_true(level.var_12f54bf);
      break;
    case # "hash_693513693fe08584":
      level thread function_254bafc6();
      break;
    case # "hash_790736a92ac26568":
      v_origin = getplayers()[0] function_7ae85497();
      actor = arraygetclosest(v_origin, getactorarray());

      if(isDefined(actor)) {
        if(isDefined(level.var_cc1e4a20)) {
          level.var_cc1e4a20 deletedelay();
        }

        level.var_cc1e4a20 = util::spawn_model("<dev string:x699>", v_origin);

        if(isDefined(level.var_cc1e4a20)) {
          slots = namespace_85745671::function_bdb2b85b(level.var_cc1e4a20, level.var_cc1e4a20.origin, level.var_cc1e4a20.angles, 40, 5, 16);

          if(!isDefined(slots) || slots.size <= 0) {
            return;
          }

          level.var_cc1e4a20.is_active = 1;
          level.var_cc1e4a20.var_b79a8ac7 = {
            #var_f019ea1a: 6000, #slots: slots
          };

          if(!namespace_85745671::function_a31a41e8(actor, level.var_cc1e4a20)) {
            level.var_cc1e4a20 deletedelay();
            level.var_cc1e4a20 = undefined;
          }
        }
      }

      break;
    case # "hash_7dc916f19cb3187":
      switch (cmd[1]) {
        case # "obj":
        case # "objective":
          list = level.contentmanager.var_407236bf.list;
          index = level.contentmanager.var_407236bf.index;
          break;
        case # "capsule":
        case # "cap":
          list = level.contentmanager.var_dc858a58.list;
          index = level.contentmanager.var_dc858a58.index;
          break;
      }

      if(!isDefined(list)) {
        break;
      }

      for(i = 0; i < list.size; i++) {
        if(i === index) {
          println("<dev string:x6b8>" + function_9e72a96(list[i]) + "<dev string:x6be>");
          continue;
        }

        println(function_9e72a96(list[i]) + "<dev string:x6be>");
      }

      break;
    case # "hash_5c8627bc3cc0e4ef":
      target_player = getplayers()[0];
      var_8a3f16c6 = target_player;
      spawn = var_8a3f16c6 squad_spawn::function_e402b74e(var_8a3f16c6, target_player);

      if(isDefined(spawn)) {
        debugstar(spawn.origin, 1200, (1, 0, 1));
        debugstar(var_8a3f16c6.origin, 1200, (0, 0, 1));
        line(spawn.origin, var_8a3f16c6.origin, (0, 0, 1), 1, 0, 1200);
      }

      break;
    default:
      break;
  }

  if(isDefined(level.var_c7b02cfe)) {
    [[level.var_c7b02cfe]](params);
  }

  if(isDefined(level.var_d4c3c1b9)) {
    for(index = 0; index < level.var_d4c3c1b9.size; index++) {
      [[level.var_d4c3c1b9[index]]](params);
    }
  }

  setDvar(#"hash_3a0015e9f67cadaf", "<dev string:x38>");
}

function function_d8ef0f00(callback) {
  if(!isDefined(level.var_d4c3c1b9)) {
    level.var_d4c3c1b9 = [];
  }

  level.var_d4c3c1b9[level.var_d4c3c1b9.size] = callback;
}

function function_e77b67f(params, show) {
  cmd = strtok(params.value, "<dev string:x678>");

  if(cmd.size <= 1 || cmd.size > 3) {
    return;
  }

  key = "<dev string:x6c3>";
  value = cmd[1];

  if(cmd.size > 2) {
    key = cmd[1];
    value = cmd[2];
  }

  ents = getEntArray(value, key);

  if(!ents.size) {
    println("<dev string:x6d1>" + key + "<dev string:x711>" + value);
    return;
  }

  foreach(ent in ents) {
    if(show) {
      setDvar(#"g_drawdebuginfovolumes", 1);
      showinfovolume(ent getentitynumber(), (1, 1, 0), 0.5);
      continue;
    }

    hideinfovolume(ent getentitynumber());
  }
}

function function_f9023d3a() {
  v_origin = getplayers()[0] function_7ae85497();
  v_origin = getclosestpointonnavmesh(v_origin, 64, 32);

  if(!isDefined(v_origin)) {
    return;
  }

  if(!isDefined(level.var_29cf6901)) {
    level.var_29cf6901 = {};
  }

  if(!isDefined(level.var_29cf6901.start)) {
    level.var_29cf6901.start = [];
  }

  level.var_29cf6901.start[level.var_29cf6901.start.size] = v_origin;
  level thread function_37c30a3b();
}

function function_c78fe37a() {
  v_origin = getplayers()[0] function_7ae85497();
  v_origin = getclosestpointonnavmesh(v_origin, 64, 32);

  if(!isDefined(v_origin)) {
    return;
  }

  if(!isDefined(level.var_29cf6901)) {
    level.var_29cf6901 = {};
  }

  if(!isDefined(level.var_29cf6901.end)) {
    level.var_29cf6901.end = [];
  }

  level.var_29cf6901.end[level.var_29cf6901.end.size] = v_origin;
  level thread function_37c30a3b();
}

function function_dabc0bfe() {
  function_832956c9();

  if(isDefined(level.var_29cf6901)) {
    level.var_29cf6901.start = undefined;
    level.var_29cf6901.end = undefined;
    level notify(#"hash_38fcca4f222bb813");
  }
}

function function_71797cab() {
  v_origin = getplayers()[0] function_7ae85497();
  points = [];

  if(isDefined(level.var_29cf6901.start)) {
    points = level.var_29cf6901.start;
  }

  if(isDefined(level.var_29cf6901.end)) {
    points = arraycombine(points, level.var_29cf6901.end, 1, 0);
  }

  closest_point = arraygetclosest(v_origin, points);

  if(isDefined(closest_point)) {
    if(isDefined(level.var_29cf6901.start)) {
      arrayremovevalue(level.var_29cf6901.start, closest_point);
    }

    if(isDefined(level.var_29cf6901.end)) {
      arrayremovevalue(level.var_29cf6901.end, closest_point);
    }
  }
}

function function_60cf1e76() {
  if(!(isDefined(level.var_29cf6901.start) && isDefined(level.var_29cf6901) && isDefined(level.var_29cf6901.end))) {
    return;
  }

  if(!isDefined(level.var_29cf6901.ai)) {
    level.var_29cf6901.ai = [];
  }

  start = array::random(level.var_29cf6901.start);
  end = array::random(level.var_29cf6901.end);
  forward = end - start;
  var_1a614c37 = spawnactor(#"spawner_zm_zombie", start, vectortoangles((0, forward[1], 0)), "<dev string:x71d>", 1);

  if(!isDefined(var_1a614c37)) {
    return;
  }

  var_1a614c37.ignoreall = 1;
  var_1a614c37.var_67faa700 = 1;
  var_1a614c37.backedupgoal = var_1a614c37.origin;
  var_1a614c37.b_ignore_cleanup = 1;
  var_1a614c37 thread function_eee42c73();
  level.var_29cf6901.ai[level.var_29cf6901.ai.size] = var_1a614c37;
}

function function_832956c9() {
  if(!isDefined(level.var_29cf6901.ai)) {
    return;
  }

  if(isarray(level.var_29cf6901.ai) && level.var_29cf6901.ai.size) {
    foreach(ai in level.var_29cf6901.ai) {
      ai deletedelay();
    }
  }
}

function function_b104a7cb() {
  if(is_true(level.var_26340887)) {
    level notify(#"hash_f214fb1df20b46b");
    level.var_26340887 = undefined;
    return;
  }

  level.var_26340887 = 1;
  level endon(#"hash_f214fb1df20b46b");
  record = getDvar(#"recorder_enablerec", 0);

  while(true) {
    foreach(player in function_a1ef346b()) {
      color = (0, 1, 1);
      position = player.last_valid_position;

      if(!isDefined(position)) {
        color = (1, 0, 0);
        position = player.origin;
      }

      debug2dtext((960, 180, 0), "<dev string:x72d>" + distance(player.origin, position) + "<dev string:x754>" + distancesquared(player.origin, position), (1, 1, 0), 1, (0, 0, 0), 0.75);

      if(record) {
        recordstar(position, color, "<dev string:x76b>", player);
        recordline(position, position + (0, 0, 72), color, "<dev string:x76b>", player);
        continue;
      }

      debugstar(position, 1, color);
      line(position, position + (0, 0, 72), color, 1, 1, 1);
    }

    waitframe(1);
  }
}

function function_eee42c73() {
  self endon(#"death");

  while(isDefined(level.var_29cf6901) && zm_utility::is_classic() && !is_true(self.completed_emerging_into_playable_area)) {
    waitframe(1);
  }

  current_goal = 0;
  var_6936a23a = [level.var_29cf6901.end, level.var_29cf6901.start];
  self setgoal(array::random(var_6936a23a[current_goal]));

  while(is_true(level.var_29cf6901.repeat)) {
    self waittill(#"goal");
    current_goal = !current_goal;
    self setgoal(array::random(var_6936a23a[current_goal]));
  }
}

function function_58e8b7e3() {
  while(is_true(level.var_29cf6901.repeat)) {
    debug2dtext((100, 100, 0), "<dev string:x775>", (0, 1, 0), 1, (0.5, 0.5, 0.5), 0.75);
    waitframe(1);
  }
}

function function_37c30a3b() {
  self notify("<dev string:x789>");
  self endon("<dev string:x789>");
  level endon(#"game_ended", #"hash_38fcca4f222bb813");

  while(true) {
    waitframe(1);

    if(!isDefined(level.var_29cf6901)) {
      continue;
    }

    if(isDefined(level.var_29cf6901.start)) {
      foreach(origin in level.var_29cf6901.start) {
        debugstar(origin, 1, (0, 1, 0));
      }
    }

    if(isDefined(level.var_29cf6901.end)) {
      foreach(origin in level.var_29cf6901.end) {
        debugstar(origin, 1, (1, 0, 0));
      }
    }

    if(isarray(level.var_29cf6901.ai) && level.var_29cf6901.ai.size) {
      function_1eaaceab(level.var_29cf6901.ai);

      foreach(ai in level.var_29cf6901.ai) {
        line(ai.origin, ai.origin + (0, 0, ai function_6a9ae71()), (1, 0, 1), 1, 0, 1);
      }
    }
  }
}

function function_7ae85497(dist) {
  v_forward = anglesToForward(self getplayerangles());
  v_forward = vectorscale(v_forward, 4000);
  var_5927a215 = (10, 10, 10);
  v_eye = self getplayercamerapos();
  var_abd03397 = physicstrace(v_eye, v_eye + v_forward, -1 * var_5927a215, var_5927a215, getplayers()[0], 64 | 2);
  return var_abd03397[#"position"];
}

function spawn_aitype(aitype) {
  host = getplayers()[0];
  v_origin = host function_7ae85497();
  ai = spawnactor(aitype, v_origin, host.angles + (0, 180, 0), "<dev string:x71d>", 1);

  if(isDefined(ai)) {
    if(!isDefined(level.var_a46cf88a)) {
      level.var_a46cf88a = [];
    } else if(!isarray(level.var_a46cf88a)) {
      level.var_a46cf88a = array(level.var_a46cf88a);
    }

    level.var_a46cf88a[level.var_a46cf88a.size] = ai;
    function_1eaaceab(level.var_a46cf88a);
    return;
  }

  iprintlnbold("<dev string:x79c>" + aitype + "<dev string:x7a9>" + getailimit() + "<dev string:x7e2>");
}

function private function_e645d51a(a_ai, str_aitype) {
  if(isarray(a_ai)) {
    foreach(ai in a_ai) {
      if(isalive(ai) && (!isDefined(str_aitype) || ai.aitype === str_aitype)) {
        ai.allowdeath = 1;
        ai kill();
      }
    }

    function_1eaaceab(a_ai);
  }
}

function private function_867e712a(params) {
  if(is_true(params.value)) {
    level thread function_51403488();
    return;
  }

  level notify(#"hash_275c4bf3f697b9e");
}

function private function_51403488() {
  level notify(#"hash_275c4bf3f697b9e");
  level endon(#"hash_275c4bf3f697b9e", #"end_game", #"game_ended");

  while(true) {
    player = getplayers()[0];

    if(!isDefined(player)) {
      return;
    }

    a_ai = player getenemiesinradius(player.origin, 2000);

    foreach(ai in a_ai) {
      if(isalive(ai)) {
        print3d(ai.origin + (0, 0, 68), "<dev string:x7e9>" + ai.health + "<dev string:x7f1>" + (isDefined(ai.maxhealth) ? ai.maxhealth : "<dev string:x7f6>"), (0, 1, 0), 1, 0.5);
      }
    }

    waitframe(1);
  }
}

function private function_ad391a04(params) {
  if(isint(params.value) && params.value) {
    level thread print_zombie_counts();
    return;
  }

  level notify(#"hash_87534d41fedbdf9");
}

function private print_zombie_counts() {
  level notify(#"hash_87534d41fedbdf9");
  level endon(#"hash_87534d41fedbdf9");

  while(true) {
    var_c708e6e1 = 120;
    var_6a432250 = [];
    a_ai = getaiarray();

    foreach(ai in a_ai) {
      if(isalive(ai) && isDefined(ai.archetype)) {
        if(isDefined(ai.subarchetype)) {
          str_archetype = function_9e72a96(ai.archetype) + "<dev string:x7fb>" + function_9e72a96(ai.subarchetype) + "<dev string:x801>";
        } else {
          str_archetype = function_9e72a96(ai.archetype);
        }

        if(!isDefined(var_6a432250[str_archetype])) {
          var_6a432250[str_archetype] = 0;
        }

        var_6a432250[str_archetype]++;
      }
    }

    debug2dtext((700, var_c708e6e1, 0), "<dev string:x806>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1.5, 5);
    var_c708e6e1 += 33;
    debug2dtext((700, var_c708e6e1, 0), "<dev string:x820>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 5);

    foreach(str_archetype, n_ai_count in var_6a432250) {
      var_c708e6e1 += 22;
      debug2dtext((700, var_c708e6e1, 0), function_9e72a96(str_archetype) + "<dev string:x84b>" + n_ai_count + "<dev string:x6be>", (0, 1, 0), 1, (0, 0, 0), 0.8, 1, 5);
    }

    waitframe(5);
  }
}

function private function_3fe9e6d5(params) {
  if(isDefined(params.value) && params.value !== 0) {
    spawner::add_ai_spawn_function(&function_e9939aa7);

    foreach(zombie in getactorarray()) {
      zombie thread function_e9939aa7();
    }

    return;
  }

  spawner::function_932006d1(&function_e9939aa7);
  level notify(#"hash_339fb98e940fbaf6");
}

function private function_e9939aa7() {
  self endon(#"death");
  level endon(#"hash_339fb98e940fbaf6");

  while(true) {
    waitframe(1);
    record3dtext(is_true(self.var_1fa24724) ? "<dev string:x851>" : "<dev string:x86a>", self.origin, (0, 1, 0), "<dev string:x76b>", self);
  }
}

function private function_f1f26ccb(params) {
  level.var_2b46c827 = is_true(params.value);

  if(!level.var_2b46c827) {
    level notify(#"hash_39e4c9a17bf97f7d");
  }
}

function private function_42d3c9f5(params) {
  if(params.value === "<dev string:x38>") {
    return;
  }

  var_bfae6869 = strtok(params.value, "<dev string:x197>");
  var_3480e14d = var_bfae6869[0];
  var_a75f9486 = var_bfae6869[1];
  s_instance = content_manager::get_children(struct::get(var_3480e14d))[0];
  a_s_spawns = content_manager::get_children(s_instance);

  if(isDefined(var_a75f9486)) {
    var_a75f9486 = int(var_a75f9486);
    player = getplayers()[0];
    player setorigin(a_s_spawns[var_a75f9486].origin);
    player setplayerangles(a_s_spawns[var_a75f9486].angles);
    return;
  }

  foreach(n_index, player in getplayers()) {
    s_spawn = a_s_spawns[n_index];

    if(isDefined(s_spawn)) {
      player setorigin(s_spawn.origin);
      player setplayerangles(s_spawn.angles);
    }
  }
}

function function_2fab7a62(str_type) {
  if(isDefined(str_type) && str_type != "<dev string:x38>") {
    str_dvar = "<dev string:x881>" + str_type;
    util::init_dvar(str_dvar, 0, &function_2a3a4bf6);
    util::add_devgui(content_manager::devgui_path("<dev string:x899>", function_9e72a96(str_type), 103), "<dev string:x8b7>" + str_dvar + "<dev string:x8c2>");
  }
}

function function_2a3a4bf6(params) {
  var_806a0877 = function_9e72a96(params.name);
  a_str_tokens = strtok(var_806a0877, "<dev string:x197>");
  assert(isDefined(a_str_tokens) && a_str_tokens.size > 1, var_806a0877 + "<dev string:x8ca>");
  str_type = a_str_tokens[1];

  if(params.value === 1 || params.value === 0) {
    level thread function_afb25532(str_type, params.value);
  }
}

function function_afb25532(str_type, b_enable) {
  if(!isDefined(b_enable)) {
    b_enable = 1;
  }

  level notify("<dev string:x93a>" + str_type);
  level endon("<dev string:x93a>" + str_type, #"end_game", #"game_ended");

  if(b_enable) {
    while(true) {
      player = getplayers()[0];

      if(!isDefined(player)) {
        return;
      }

      var_e5880035 = struct::get_array(str_type, "<dev string:x11a>");

      if(!var_e5880035.size) {
        return;
      }

      foreach(var_97aab885 in var_e5880035) {
        if(isDefined(var_97aab885.contentgroups[#"capture_point"][0])) {
          v_loc = var_97aab885.contentgroups[#"capture_point"][0].origin;
          v_color = (0, 1, 0);
        } else if(isDefined(var_97aab885.contentgroups[#"chest_spawn"][0])) {
          v_loc = var_97aab885.contentgroups[#"chest_spawn"][0].origin;
          v_color = (0, 1, 0);
        } else if(isDefined(var_97aab885.contentgroups[#"trigger_spawn"][0])) {
          v_loc = var_97aab885.contentgroups[#"trigger_spawn"][0].origin;
          v_color = (0, 1, 0);
        } else {
          v_loc = var_97aab885.origin;
          v_color = (1, 0, 0);
        }

        print3d(v_loc, "<dev string:x952>" + str_type + "<dev string:x963>" + (isDefined(var_97aab885.targetname) ? var_97aab885.targetname : "<dev string:x974>"), (1, 1, 0), undefined, 1);
        n_radius = 64;
        n_dist = distance(v_loc, player.origin);
        n_radius *= n_dist / 3000;
        sphere(v_loc, n_radius, v_color);
      }

      debug2dtext((100, 900, 0), "<dev string:x987>", (0, 1, 0), undefined, undefined, undefined, 1.5);
      debug2dtext((100, 925, 0), "<dev string:x9a6>", (1, 0, 0), undefined, undefined, undefined, 1.5);
      waitframe(1);
    }

    return;
  }

  level notify("<dev string:x93a>" + str_type);
}

function debug_attackables() {
  level notify(#"debug_attackables");
  level endon(#"debug_attackables");

  while(isDefined(level.attackables)) {
    foreach(attackable in level.attackables) {
      circle(attackable.origin, attackable.var_b79a8ac7.var_f019ea1a, (1, 0, 1), 0, 1);

      foreach(slot in attackable.var_b79a8ac7.slots) {
        circle(slot.origin, 8, (1, 0, 1), 0, 1);
        debugstar(slot.origin, 1, (1, 0, 1));
        line(attackable.origin, slot.origin, (1, 0, 1), 1, 0);

        if(!isalive(slot.entity)) {
          continue;
        }

        circle(slot.entity.origin, slot.entity getpathfindingradius(), (0, 1, 1), 0, 1);
        line(slot.origin, slot.entity.origin, (0, 1, 1), 1, 0);
      }
    }

    waitframe(1);
  }
}

function function_34f85f1b(str_flag, var_1303e212) {
  if(!isDefined(var_1303e212)) {
    var_1303e212 = 1;
  }

  level flag::set(str_flag);

  if(var_1303e212) {
    var_4777a582 = getDvar(#"hash_7c3872b765911891");
    setDvar(#"hash_7c3872b765911891", 0);

    if(var_4777a582 !== 0) {
      wait 3;
    }
  }

  level.var_78b6c3a4 = 0;

  while(level flag::get(str_flag)) {
    if(var_1303e212 && (!isDefined(level.hotzones) || !level.hotzones.size)) {
      wait 1;
      continue;
    }

    var_842cdacd = [];

    if(var_1303e212) {
      hotzone = arraygetclosest(getplayers()[0].origin, level.hotzones);
      var_842cdacd = struct::get_array(hotzone.targetname, "<dev string:x131>");
    } else {
      trigger = arraygetclosest(getplayers()[0].origin, getEntArray("<dev string:x9c5>", "<dev string:x6c3>"));

      if(isDefined(trigger.target)) {
        var_842cdacd = struct::get_array(trigger.target, "<dev string:x6c3>");
      }
    }

    if(!var_842cdacd.size) {
      wait 1;
      continue;
    }

    foreach(spawn_point in var_842cdacd) {
      while(level flag::get(str_flag) && (level.var_78b6c3a4 >= var_842cdacd.size || getaicount() >= getailimit())) {
        wait 1;
      }

      if(!level flag::get(str_flag)) {
        break;
      }

      new_ai = spawnactor(#"hash_7cba8a05511ceedf", spawn_point.origin, spawn_point.angles, undefined, 1);

      if(!isDefined(new_ai)) {
        println("<dev string:x9d7>" + spawn_point.origin);
        debugstar(spawn_point.origin, 30, (1, 0, 0), "<dev string:xa00>");
      }

      if(isDefined(spawn_point.var_90d0c0ff) && function_c4cb6239(#"hash_7cba8a05511ceedf", spawn_point.var_90d0c0ff)) {
        new_ai.var_c9b11cb3 = spawn_point.var_90d0c0ff;
      }

      level.var_78b6c3a4++;
      new_ai thread function_8245d8a0();

      if(isDefined(spawn_point.var_90d0c0ff)) {
        debugstar(spawn_point.origin, 100, (1, 1, 1), "<dev string:xa16>" + spawn_point.var_90d0c0ff, 0.65);
      }
    }
  }

  if(isDefined(var_4777a582)) {
    setDvar(#"hash_7c3872b765911891", var_4777a582);
  }
}

function function_8245d8a0() {
  self waittill(#"hash_790882ac8688cee5", #"death");
  wait 1;

  if(isalive(self)) {
    self.allowdeath = 1;
    self delete();
  }

  level.var_78b6c3a4--;
}

function function_46997bdf(spawn_points, var_e6c99abc) {
  level endon(#"game_ended");

  if(!isDefined(var_e6c99abc)) {
    var_e6c99abc = "<dev string:xa1c>";
  }

  totalspawns = spawn_points.size;

  if(!isDefined(level.contentmanager.currentdestination)) {
    return;
  }

  destination = level.contentmanager.currentdestination;
  iprintln("<dev string:xa26>" + var_e6c99abc + "<dev string:xa46>");
  println("<dev string:xa51>");
  println("<dev string:xa9f>" + destination.targetname + "<dev string:xaa6>" + totalspawns + "<dev string:xa46>");
  println("<dev string:xaca>" + var_e6c99abc + "<dev string:xada>");
  println("<dev string:xa51>");
  level notify(#"hash_2d15e9ef4a8fd60c");
  level.var_5c5abaf2 = 1;
  level.var_135a36f7 = [];
  level.var_d3582224 = 0;
  var_4777a582 = getdvarint(#"hash_7c3872b765911891", 0);
  setDvar(#"hash_7c3872b765911891", 0);

  if(var_4777a582 != 0) {
    wait 3;
  }

  available_slots = getailimit() - getaicount();
  iprintln("<dev string:xafc>" + available_slots);

  foreach(spawn_point in spawn_points) {
    available_slots = getailimit() - getaicount();

    if(available_slots > 0 && function_103c90c0(spawn_point, 0)) {
      available_slots -= 1;
    }

    while(available_slots <= 0) {
      available_slots = getailimit() - getaicount();
      wait 0.1;
    }
  }

  while(level.var_d3582224 > 0) {
    wait 0.1;
  }

  var_d6d7c500 = level.var_135a36f7.size > 0;
  var_76fb4fcc = var_d6d7c500 ? "<dev string:xb19>" + level.var_135a36f7.size + "<dev string:xa46>" : "<dev string:xb28>";
  color = var_d6d7c500 ? "<dev string:xb32>" : "<dev string:xb38>";
  println(color + "<dev string:xb3e>");
  println(color + "<dev string:xb8a>" + destination.targetname + "<dev string:xb8f>" + var_e6c99abc + "<dev string:xb94>" + var_76fb4fcc);
  println(color + "<dev string:xb3e>");
  iprintlnbold(color + "<dev string:xb8a>" + destination.targetname + "<dev string:xb8f>" + var_e6c99abc + "<dev string:xb94>" + var_76fb4fcc);

  if(var_d6d7c500) {
    foreach(msg in level.var_135a36f7) {
      println(color + msg);
    }

    println(color + "<dev string:xb3e>");
  }

  setDvar(#"hash_7c3872b765911891", var_4777a582);
  level.var_5c5abaf2 = 0;
}

function function_70e877d7(spawn_points) {
  level.var_135a36f7 = undefined;
  var_d610cbe2 = sqr(1000);
  player = getplayers()[0];
  player_vec = vectornormalize(anglesToForward(player getplayerangles()));
  var_167af5ff = undefined;
  best_dot = 0.707;

  foreach(spawn_point in spawn_points) {
    var_a9944b6 = vectornormalize(spawn_point.origin - player.origin);
    dot = vectordot(player_vec, var_a9944b6);

    if(dot > best_dot && distancesquared(spawn_point.origin, player.origin) < var_d610cbe2) {
      best_dot = dot;
      var_167af5ff = spawn_point;
    }
  }

  if(isDefined(var_167af5ff)) {
    iprintln("<dev string:xbaa>" + var_167af5ff.origin);

    if(function_103c90c0(var_167af5ff, 1)) {
      debugstar(var_167af5ff.origin, 30, (0, 0, 1), "<dev string:xbca>");
    }

    return;
  }

  iprintln("<dev string:xbd6>");
}

function function_103c90c0(spawn_point, var_957493b8) {
  if(!isDefined(var_957493b8)) {
    var_957493b8 = 0;
  }

  new_ai = spawnactor(#"hash_7cba8a05511ceedf", spawn_point.origin, spawn_point.angles, undefined, 1);

  if(!isDefined(new_ai)) {
    println("<dev string:x9d7>" + spawn_point.origin);
    debugstar(spawn_point.origin, 30, (1, 0, 0), "<dev string:xa00>");
    return 0;
  }

  if(!isDefined(level.var_d3582224)) {
    level.var_d3582224 = 0;
  }

  if(is_false(var_957493b8)) {
    level.var_d3582224 += 1;
  }

  if(isDefined(spawn_point.var_90d0c0ff) && function_c4cb6239(#"hash_7cba8a05511ceedf", spawn_point.var_90d0c0ff)) {
    new_ai.var_c9b11cb3 = spawn_point.var_90d0c0ff;
  }

  new_ai thread function_fabd315d(spawn_point, var_957493b8);
  return 1;
}

function function_fabd315d(spawn_point, var_957493b8) {
  if(is_false(var_957493b8)) {
    self endoncallback(&function_cad1a4b5, #"death");
  } else {
    self endon(#"death");
  }

  self waittill(#"hash_790882ac8688cee5");

  if(!ispointonnavmesh(self.origin, self)) {
    println("<dev string:xbf1>" + spawn_point.origin);
    debugstar(spawn_point.origin, 80, (1, 0, 0), "<dev string:xc2f>");

    if(isDefined(level.var_135a36f7)) {
      errormsg = "<dev string:xc47>" + spawn_point.origin;

      if(isDefined(self.var_90d0c0ff) && isDefined(self.var_1a02009e)) {
        errormsg += "<dev string:xc70>" + self.var_90d0c0ff + "<dev string:xc7d>" + function_9e72a96(self.var_1a02009e);
      }

      level.var_135a36f7[level.var_135a36f7.size] = errormsg;
    } else {
      errormsg = "<dev string:xc47>" + spawn_point.origin;

      if(isDefined(self.var_90d0c0ff) && isDefined(self.var_1a02009e)) {
        errormsg += "<dev string:xc70>" + self.var_90d0c0ff + "<dev string:xc7d>" + function_9e72a96(self.var_1a02009e);
      }

      println("<dev string:xc89>" + errormsg);
    }
  } else {
    self.cant_move_cb = &function_bc21ac74;
    var_6e56b150 = 0;

    for(i = 0; i < 2; i++) {
      goal = awareness::function_b184324d(spawn_point.origin, isDefined(spawn_point.wander_radius) ? spawn_point.wander_radius : 128, self getpathfindingradius() * 1.2, self getpathfindingradius() * 1.2);

      if(isDefined(goal)) {
        self setgoal(goal);
      }

      waitresult = self waittilltimeout(7, #"goal", #"bad_path", #"death");

      if(waitresult._notify == # "goal" || waitresult._notify == "<dev string:xc90>") {
        break;
      } else if(waitresult._notify == # "bad_path") {
        var_6e56b150++;
      }

      self waittilltimeout(2, #"goal_changed");
    }

    if(var_6e56b150 >= 2) {
      println("<dev string:xc99>" + spawn_point.origin);
      debugstar(spawn_point.origin, 80, (1, 0, 0), "<dev string:xcd0>");

      if(isDefined(level.var_135a36f7)) {
        errormsg = "<dev string:xcee>" + spawn_point.origin;

        if(isDefined(self.var_90d0c0ff) && isDefined(self.var_1a02009e)) {
          errormsg += "<dev string:xc70>" + self.var_90d0c0ff + "<dev string:xc7d>" + function_9e72a96(self.var_1a02009e);
        }

        level.var_135a36f7[level.var_135a36f7.size] = errormsg;
      }
    }
  }

  if(is_false(var_957493b8)) {
    self.allowdeath = 1;
    self kill();
  }
}

function private function_cad1a4b5(str_notify) {
  level.var_d3582224 -= 1;
}

function private function_bc21ac74() {
  self notify(#"bad_path");
}

function private function_df5be8b2() {
  self endon(#"death", #"disconnect");
  level endon(#"hash_624d34392463b628");

  while(true) {
    view_pos = self getplayercamerapos();
    dir = anglesToForward(self getplayerangles()) * 500;
    end_pos = view_pos + dir;
    trace = physicstraceex(view_pos, end_pos, (0, 0, 0), (0, 0, 0), self);

    if(getdvarint(#"recorder_enablerec", 0)) {
      recordline(view_pos, view_pos + dir * trace[#"fraction"], (0, 1, 0), "<dev string:x76b>");
    } else {
      line(view_pos, view_pos + dir * trace[#"fraction"], (0, 1, 0));
    }

    if(getdvarint(#"recorder_enablerec", 0)) {
      recordcircle(end_pos, 32, (0, 1, 0), "<dev string:x76b>");
    } else {
      circle(end_pos, 32, (0, 1, 0), 0, 1);
    }

    if(getdvarint(#"recorder_enablerec", 0)) {
      recordstar(view_pos + dir * trace[#"fraction"], (1, 0, 0), "<dev string:x76b>");
    } else {
      debugstar(view_pos + dir * trace[#"fraction"], (1, 0, 0));
    }

    waitframe(1);
  }
}

function function_254bafc6() {
  var_17b7891d = "<dev string:xd17>" + "<dev string:xd2b>";
  self notify(var_17b7891d);
  self endon(var_17b7891d);
  level endon(#"end_game");

  if(!isDefined(level.var_d9a2ea61)) {
    level.var_d9a2ea61 = 0;
  }

  level.var_d9a2ea61 = !level.var_d9a2ea61;

  if(level.var_d9a2ea61) {
    while(true) {
      foreach(volume in level.var_afa5478b) {
        foreach(node in volume.nodes) {
          recordsphere(node.origin, 10, (1, 0, 0));
          record3dtext("<dev string:xd42>" + (isDefined(node.floor) ? node.floor : "<dev string:xd4d>"), node.origin + (0, 0, 10), (1, 0, 0));

          if(is_true(node.var_6fff1a72)) {
            record3dtext("<dev string:xd54>", node.origin + (0, 0, 15), (1, 0, 0));
          }
        }
      }

      waitframe(1);
    }
  }
}