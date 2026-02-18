/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\spawn_manager.gsc
***********************************************/

#using script_2c9bc8b876b81af8;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#namespace spawn_manager;

function private autoexec __init__system__() {
  system::register(#"spawn_manager", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.var_7c90ec19 = 0;
  level.var_539b11be = 50;
  level.var_e4fdd7dd = 0;
  level.var_ec8c9d99 = 0;
  level.spawn_managers = [];
  level.spawn_managers = getEntArray("spawn_manager", "classname");
  array::thread_all(level.spawn_managers, &function_b574e20c);
  function_edad3267();

  callback::on_connect(&on_player_connect);
  level thread function_50a58f3();
}

function function_21b5cb9e() {
  assert(isDefined(self));
  assert(isDefined(self.target));
  assert(self.var_ff71eda6 >= self.var_3ea8113, "<dev string:x38>" + self.sm_id);

  if(!isDefined(self.var_ae34b6c9) || self.var_ae34b6c9 > self.allspawners.size) {
    self.var_ae34b6c9 = self.allspawners.size;
  }

  if(!isDefined(self.var_25a70a68) || self.var_25a70a68 > self.allspawners.size) {
    self.var_25a70a68 = self.allspawners.size;
  }

  assert(self.var_25a70a68 >= self.var_ae34b6c9, "<dev string:x38>" + self.sm_id);
  self.var_82a78b41 = randomintrange(self.var_ae34b6c9, self.var_25a70a68 + 1);
  self.spawners = self function_bf4a387a();
  function_405a4f7c();
  assert(self.var_3ea8113 <= self.var_b02a42f7, "<dev string:x90>");

  if(!isDefined(self.script_forcespawn)) {
    self.script_forcespawn = 0;
  }
}

function function_7051aeac(spawngroupsize) {
  totalfree = self.count >= 0 ? self.count : level.var_539b11be;
  var_54642189 = self.var_b02a42f7 - self.var_5ee53e3.size;
  var_514ec5ff = var_54642189 >= spawngroupsize && totalfree >= spawngroupsize && spawngroupsize > 0;
  var_7d4f7444 = level.var_539b11be - level.var_e4fdd7dd;
  assert(self.enable == level flag::get("<dev string:xc3>" + self.sm_id + "<dev string:xca>"), "<dev string:xd6>");

  if(self.script_forcespawn == 0) {
    return (totalfree > 0 && var_54642189 > 0 && var_7d4f7444 > 0 && var_514ec5ff && self.enable);
  }

  return totalfree > 0 && var_54642189 > 0 && self.enable;
}

function spawn_manager_spawn(maxdelay) {
  self endon(#"death");
  start = gettime();

  while(true) {
    ai = self spawner::spawn();

    if(isDefined(ai) || gettime() - start > 1000 * maxdelay) {
      return ai;
    }

    wait 0.5;
  }
}

function function_ae26af62(spawner, spawngroupsize) {
  for(i = 0; i < spawngroupsize; i++) {
    ai = undefined;

    if(isDefined(spawner) && isDefined(spawner.targetname)) {
      ai = spawner spawn_manager_spawn(2);

      if(isDefined(ai)) {
        ai.sm_id = self.sm_id;
      }
    } else {
      continue;
    }

    if(!spawner::spawn_failed(ai)) {
      if(isDefined(self.script_radius)) {
        ai.script_radius = self.script_radius;
      }

      if(isDefined(spawner.script_radius)) {
        ai.script_radius = spawner.script_radius;
      }

      ai thread function_39f8667d(spawner, self);
    }
  }
}

function function_39f8667d(spawner, manager) {
  targetname = manager.targetname;
  classname = spawner.classname;
  level.var_7c90ec19++;
  manager.spawncount++;

  if(manager.count > 0) {
    manager.count--;
  }

  level.var_e4fdd7dd++;
  origin = spawner.origin;
  manager.var_5ee53e3[manager.var_5ee53e3.size] = self;
  spawner.var_5ee53e3[spawner.var_5ee53e3.size] = self;
  self waittill(#"death");

  if(isDefined(spawner)) {
    arrayremovevalue(spawner.var_5ee53e3, self);
  }

  if(isDefined(manager)) {
    arrayremovevalue(manager.var_5ee53e3, self);
  }

  level.var_e4fdd7dd--;
}

function function_b4ecf5f4() {
  if(isDefined(self.name)) {
    function_827b4278(self.name);

    self.sm_id = self.name;
  } else if(isDefined(self.targetname) && !strstartswith(self.targetname, "pf")) {
    function_827b4278(self.targetname);

    self.sm_id = self.targetname;
  } else {
    function_2abead89();
  }

  if(!isDefined(self.var_439d74d6)) {
    self.var_439d74d6 = self.count;
  }

  if(!isDefined(self.var_897f477f)) {
    self.var_897f477f = isDefined(self.var_2023678c) ? self.var_2023678c : level.var_539b11be;
  }

  if(!isDefined(self.var_97077fdd)) {
    self.var_97077fdd = isDefined(self.var_b02a42f7) ? self.var_b02a42f7 : level.var_539b11be;
  }

  if(!isDefined(self.var_2fda6f65)) {
    self.var_2fda6f65 = isDefined(self.var_3ea8113) ? self.var_3ea8113 : 1;
  }

  if(!isDefined(self.var_47f22892)) {
    self.var_47f22892 = isDefined(self.var_ff71eda6) ? self.var_ff71eda6 : 1;
  }
}

function function_827b4278(str_name) {
  var_2f99f0ac = getEntArray("<dev string:x114>", "<dev string:x125>");

  foreach(sm in var_2f99f0ac) {
    if(sm != self) {
      if(sm.targetname === str_name || sm.name === str_name) {
        assertmsg("<dev string:x132>" + str_name + "<dev string:x162>" + self.origin + "<dev string:x17b>" + sm.origin);
      }
    }
  }
}

function function_2abead89() {
  if(!isDefined(level.var_f64196ab)) {
    level.var_f64196ab = 0;
  }

  self.sm_id = "sm_auto" + level.var_f64196ab;
  level.var_f64196ab++;
}

function function_224fb326() {
  if(level.players.size >= 4 && isDefined(self.var_a2ec7486)) {
    n_count = self.var_a2ec7486;
  } else if(level.players.size >= 3 && isDefined(self.var_65d52474)) {
    n_count = self.var_65d52474;
  } else if(level.players.size >= 2 && isDefined(self.var_a19de51c)) {
    n_count = self.var_a19de51c;
  } else {
    n_count = self.var_439d74d6;
  }

  if(n_count > 0) {
    self.count = n_count;
    return;
  }

  self.count = -1;
}

function function_1038fe33() {
  if(level.players.size >= 4 && isDefined(self.var_c8ce7001)) {
    self.var_2023678c = self.var_c8ce7001;
    return;
  }

  if(level.players.size >= 3 && isDefined(self.var_d53e3e5b)) {
    self.var_2023678c = self.var_d53e3e5b;
    return;
  }

  if(level.players.size >= 2 && isDefined(self.var_14e898e6)) {
    self.var_2023678c = self.var_14e898e6;
    return;
  }

  self.var_2023678c = self.var_897f477f;
}

function function_ddc537ad() {
  if(level.players.size >= 4 && isDefined(self.var_76359bd7)) {
    self.var_b02a42f7 = self.var_76359bd7;
    return;
  }

  if(level.players.size >= 3 && isDefined(self.var_ddf6a107)) {
    self.var_b02a42f7 = self.var_ddf6a107;
    return;
  }

  if(level.players.size >= 2 && isDefined(self.var_d9e469f5)) {
    self.var_b02a42f7 = self.var_d9e469f5;
    return;
  }

  self.var_b02a42f7 = self.var_97077fdd;
}

function function_570206ab() {
  if(level.players.size >= 4 && isDefined(self.var_6213e93b)) {
    self.var_3ea8113 = self.var_6213e93b;
    return;
  }

  if(level.players.size >= 3 && isDefined(self.var_d8f4c7db)) {
    self.var_3ea8113 = self.var_d8f4c7db;
    return;
  }

  if(level.players.size >= 2 && isDefined(self.var_ccd50a48)) {
    self.var_3ea8113 = self.var_ccd50a48;
    return;
  }

  self.var_3ea8113 = self.var_2fda6f65;
}

function function_162ab3ec() {
  if(level.players.size >= 4 && isDefined(self.var_8bfc65ea)) {
    self.var_ff71eda6 = self.var_8bfc65ea;
    return;
  }

  if(level.players.size >= 3 && isDefined(self.var_107d6c78)) {
    self.var_ff71eda6 = self.var_107d6c78;
    return;
  }

  if(level.players.size >= 2 && isDefined(self.var_4d716e23)) {
    self.var_ff71eda6 = self.var_4d716e23;
    return;
  }

  self.var_ff71eda6 = self.var_47f22892;
}

function function_405a4f7c() {
  function_224fb326();
  function_1038fe33();
  function_ddc537ad();
  function_570206ab();
  function_162ab3ec();

  foreach(sp in self.spawners) {
    sp function_224fb326();
    sp function_1038fe33();
    sp function_ddc537ad();
  }
}

function function_18b42a8b() {
  if(!isDefined(self.var_dd59b9fd)) {
    self.var_dd59b9fd = 0;
  }

  if(!isDefined(self.var_ed48d143)) {
    self.var_ed48d143 = 0;
  }

  if(self.var_ed48d143 > 0 && self.var_ed48d143 > self.var_dd59b9fd) {
    wait randomfloatrange(self.var_dd59b9fd, self.var_ed48d143);
    return;
  }

  if(self.var_dd59b9fd > 0) {
    wait self.var_dd59b9fd;
  }
}

function function_b574e20c() {
  self endon(#"death");
  self function_b4ecf5f4();
  self function_a239f3bc();
  self thread function_415ef8f();
  self thread function_16231fe();
  self.enable = 0;
  self.var_5ee53e3 = [];
  self.spawncount = 0;
  isfirsttime = 1;
  self.allspawners = getEntArray(self.target, "targetname");
  assert(self.allspawners.size, "<dev string:x186>" + self.sm_id + "<dev string:x199>");
  level flag::wait_till("sm_" + self.sm_id + "_enabled");
  util::script_delay();
  self function_21b5cb9e();
  var_73138af8 = 1;
  self function_5bc5bce6();

  while(self.count != 0 && self.spawners.size > 0) {
    function_423f86ff();
    n_active = self.var_5ee53e3.size;
    var_3ed9a82e = self.var_b02a42f7 - n_active;

    if(!var_73138af8 && self.var_5ee53e3.size <= self.var_2023678c) {
      var_73138af8 = 1;
      function_18b42a8b();
    } else if(var_73138af8 && var_3ed9a82e < self.var_ed3f1bbb) {
      var_73138af8 = 0;
    }

    if(!var_73138af8) {
      waitframe(1);
      continue;
    }

    self function_5bc5bce6();

    if(self.count > 0) {
      if(self.var_ed3f1bbb > self.count) {
        self.var_ed3f1bbb = self.count;
      }
    }

    spawned = 0;

    while(!spawned) {
      function_423f86ff();

      if(self.spawners.size <= 0) {
        break;
      }

      if(self function_7051aeac(self.var_ed3f1bbb)) {
        assert(self.var_ed3f1bbb > 0);
        var_33440dfa = [];
        var_76d7ba22 = [];

        for(i = 0; i < self.spawners.size; i++) {
          current_spawner = self.spawners[i];

          if(isDefined(current_spawner)) {
            if(current_spawner.var_5ee53e3.size > current_spawner.var_2023678c) {
              continue;
            }

            if(!function_42a4d0d8(current_spawner)) {
              continue;
            }

            var_20c0d5a8 = current_spawner.var_b02a42f7 - current_spawner.var_5ee53e3.size;

            if(var_20c0d5a8 >= self.var_ed3f1bbb) {
              if(isDefined(current_spawner.spawnflags) && (current_spawner.spawnflags & 32) == 32) {
                var_76d7ba22[var_76d7ba22.size] = current_spawner;
                continue;
              }

              var_33440dfa[var_33440dfa.size] = current_spawner;
            }
          }
        }

        if(var_33440dfa.size > 0 || var_76d7ba22.size > 0) {
          if(var_76d7ba22.size > 0) {
            spawner = array::random(var_76d7ba22);
          } else {
            spawner = array::random(var_33440dfa);
          }

          if(!(isDefined(spawner.spawnflags) && (spawner.spawnflags & 64) == 64) && spawner.count < self.var_ed3f1bbb) {
            self.var_ed3f1bbb = spawner.count;
          }

          if(!isfirsttime) {
            function_26374d3f();
          } else {
            isfirsttime = 0;
          }

          if(!self.enable) {
            continue;
          }

          self function_ae26af62(spawner, self.var_ed3f1bbb);
          spawned = 1;
        } else {
          var_7fdb9de8 = 0;

          for(i = 0; i < self.spawners.size; i++) {
            current_spawner = self.spawners[i];

            if(isDefined(current_spawner)) {
              if(current_spawner.var_b02a42f7 > var_7fdb9de8) {
                var_7fdb9de8 = current_spawner.var_b02a42f7;
              }
            }
          }

          if(var_7fdb9de8 < self.var_ff71eda6) {
            self.var_ff71eda6 = var_7fdb9de8;
            self function_5bc5bce6();
          }
        }
      }

      waitframe(1);
    }

    waitframe(1);
    assert(!level flag::get("<dev string:xc3>" + self.sm_id + "<dev string:x1bb>"), "<dev string:xd6>");
    assert(!level flag::get("<dev string:xc3>" + self.sm_id + "<dev string:x1c6>"), "<dev string:xd6>");
  }

  self function_f00c27f1();

  if(isDefined(self.var_5ee53e3) && self.var_5ee53e3.size != 0) {
    array::wait_till(self.var_5ee53e3, "death");
  }

  function_257e48e2();
  self delete();
}

function function_415ef8f() {
  self endon(#"death");

  while(isDefined(self)) {
    self waittill(#"enable");
    self.enable = 1;
    self function_2b1e3e5f();
    self waittill(#"disable");
    self function_e6bfc4ff();
  }

  self function_e6bfc4ff();
}

function function_9db43c7f(spawn_manager) {
  spawn_manager endon(#"death", #"enable");
  self endon(#"death");
  self waittill(#"trigger");
  spawn_manager notify(#"enable");
}

function function_16231fe() {
  self waittill(#"death");
  sm_id = self.sm_id;
  a_spawners = self.allspawners;
  var_61262c99 = self.var_5ee53e3;
  level flag::clear("sm_" + sm_id + "_enabled");
  level flag::set("sm_" + sm_id + "_killed");
  level flag::set("sm_" + sm_id + "_complete");
  function_257e48e2();

  if(var_61262c99.size) {
    array::wait_till(var_61262c99, "death");
  }

  level flag::set("sm_" + sm_id + "_cleared");
  arrayremovevalue(level.spawn_managers, undefined);
}

function function_edad3267(var_8bfffc1b) {
  triggers = trigger::get_all("trigger_multiple", "trigger_once", "trigger_use", "trigger_radius", "trigger_lookat", "trigger_damage", "trigger_box");

  foreach(trig in triggers) {
    if(isDefined(trig.target)) {
      targets = function_aaa872c1(trig.target);

      foreach(target in targets) {
        trig thread function_9db43c7f(target);
      }
    }
  }
}

function function_aaa872c1(targetname) {
  if(isDefined(targetname)) {
    var_a900263 = [];

    for(i = 0; i < level.spawn_managers.size; i++) {
      if(isDefined(level.spawn_managers[i])) {
        if(level.spawn_managers[i].targetname === targetname || level.spawn_managers[i].name === targetname) {
          if(!isDefined(var_a900263)) {
            var_a900263 = [];
          } else if(!isarray(var_a900263)) {
            var_a900263 = array(var_a900263);
          }

          var_a900263[var_a900263.size] = level.spawn_managers[i];
        }
      }
    }

    return var_a900263;
  }

  return level.spawn_managers;
}

function function_bf4a387a() {
  arrayremovevalue(self.allspawners, undefined);
  exclude = [];

  for(i = 0; i < self.allspawners.size; i++) {
    if(isDefined(level.var_6a15351c) && self.allspawners[i].classname == "actor_enemy_dog_sp") {
      if(!isDefined(exclude)) {
        exclude = [];
      } else if(!isarray(exclude)) {
        exclude = array(exclude);
      }

      exclude[exclude.size] = self.allspawners[i];
    }
  }

  self.allspawners = array::exclude(self.allspawners, exclude);
  var_698d805a = 0;

  foreach(sp in self.allspawners) {
    if(!isDefined(sp.var_439d74d6)) {
      sp.var_439d74d6 = sp.count;
    }

    if(!isDefined(sp.var_97077fdd)) {
      sp.var_97077fdd = isDefined(sp.var_b02a42f7) ? sp.var_b02a42f7 : level.var_539b11be;
    }

    if(!isDefined(sp.var_897f477f)) {
      sp.var_897f477f = isDefined(sp.var_2023678c) ? sp.var_2023678c : sp.var_97077fdd;
    }

    sp.var_5ee53e3 = [];
  }

  var_7b00ead3 = arraycopy(self.allspawners);
  var_92174f16 = self.var_82a78b41;

  if(var_92174f16 > self.allspawners.size) {
    var_92174f16 = self.allspawners.size;
  }

  spawners = [];

  while(spawners.size < var_92174f16) {
    spawner = array::random(var_7b00ead3);

    if(!isDefined(spawners)) {
      spawners = [];
    } else if(!isarray(spawners)) {
      spawners = array(spawners);
    }

    spawners[spawners.size] = spawner;
    arrayremovevalue(var_7b00ead3, spawner);
  }

  return spawners;
}

function function_5bc5bce6() {
  if(self.var_3ea8113 < self.var_ff71eda6) {
    self.var_ed3f1bbb = randomintrange(self.var_3ea8113, self.var_ff71eda6 + 1);
  } else {
    self.var_ed3f1bbb = self.var_3ea8113;
  }

  return self.var_ed3f1bbb;
}

function function_257e48e2() {
  if(isDefined(self.spawners)) {
    foreach(spawner in self.spawners) {
      if(isDefined(spawner) && !is_false(spawner.script_delete)) {
        spawner delete();
      }
    }

    self.spawners = undefined;
  }
}

function function_423f86ff() {
  spawners = [];

  for(i = 0; i < self.spawners.size; i++) {
    if(isDefined(self.spawners[i])) {
      if(self.spawners[i].count != 0) {
        spawners[spawners.size] = self.spawners[i];
        continue;
      }

      self.spawners[i] delete();
    }
  }

  self.spawners = spawners;
}

function function_26374d3f() {
  if(isDefined(self.script_wait)) {
    wait self.script_wait;

    if(isDefined(self.script_wait_add)) {
      self.script_wait += self.script_wait_add;
    }

    return;
  }

  if(isDefined(self.script_wait_min) && isDefined(self.script_wait_max)) {
    var_8d59d673 = 1;
    players = getplayers();

    if(players.size == 2) {
      var_8d59d673 = 0.7;
    } else if(players.size == 3) {
      var_8d59d673 = 0.5;
    } else if(players.size == 4) {
      var_8d59d673 = 0.3;
    }

    diff = self.script_wait_max - self.script_wait_min;

    if(abs(diff) > 0) {
      wait randomfloatrange(self.script_wait_min, self.script_wait_min + diff * var_8d59d673);
    } else {
      wait self.script_wait_min;
    }

    if(isDefined(self.script_wait_add)) {
      self.script_wait_min += self.script_wait_add;
      self.script_wait_max += self.script_wait_add;
    }
  }
}

function function_42a4d0d8(spawner) {
  if(!isDefined(spawner.var_3717c478)) {
    return true;
  }

  radius = isDefined(spawner.var_3717c478) ? spawner.var_3717c478 : 0;
  players = getplayers();

  if(!isDefined(players) || players.size == 0) {
    return true;
  }

  foreach(player in players) {
    if(distancesquared(spawner.origin, player.origin) <= sqr(spawner.var_3717c478)) {
      return false;
    }
  }

  return true;
}

function function_a239f3bc() {
  level flag::init("sm_" + self.sm_id + "_enabled");
  level flag::init("sm_" + self.sm_id + "_complete");
  level flag::init("sm_" + self.sm_id + "_killed");
  level flag::init("sm_" + self.sm_id + "_cleared");
}

function function_2b1e3e5f() {
  assert(!level flag::get("<dev string:xc3>" + self.sm_id + "<dev string:xca>"), "<dev string:xd6>");
  level flag::set("sm_" + self.sm_id + "_enabled");
}

function function_e6bfc4ff() {
  self.enable = 0;
  level flag::clear("sm_" + self.sm_id + "_enabled");
}

function function_c81f3c84() {
  assert(!level flag::get("<dev string:xc3>" + self.sm_id + "<dev string:x1bb>"), "<dev string:xd6>");
  level flag::set("sm_" + self.sm_id + "_killed");
}

function function_f00c27f1() {
  assert(!level flag::get("<dev string:xc3>" + self.sm_id + "<dev string:x1c6>"), "<dev string:xd6>");
  level flag::set("sm_" + self.sm_id + "_complete");
}

function function_a1dec600() {
  assert(!level flag::get("<dev string:xc3>" + self.sm_id + "<dev string:x1d3>"), "<dev string:xd6>");
  level flag::set("sm_" + self.sm_id + "_cleared");
}

function function_3c035c82(var_2594900) {
  assert(var_2594900 <= 32, "<dev string:x1df>");
  level.var_539b11be = var_2594900;
}

function function_883b9499(var_368d405d, trig_name, var_66d7c971, once_only) {
  if(isDefined(once_only) && once_only) {
    trigger = getent(trig_name, var_66d7c971);
    assert(isDefined(trigger), "<dev string:x21f>" + var_66d7c971 + "<dev string:x22f>" + trig_name + "<dev string:x236>");
    trigger endon(#"trigger");
  }

  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    level flag::wait_till("sm_" + var_368d405d + "_complete");
    trigger::use(trig_name, var_66d7c971);
    return;
  }

  assertmsg("<dev string:x24a>" + var_368d405d + "<dev string:x275>");
}

function function_fc60286c(var_368d405d, trig_name, var_66d7c971, once_only) {
  if(isDefined(once_only) && once_only) {
    trigger = getent(trig_name, var_66d7c971);
    assert(isDefined(trigger), "<dev string:x21f>" + var_66d7c971 + "<dev string:x22f>" + trig_name + "<dev string:x236>");
    trigger endon(#"trigger");
  }

  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    level flag::wait_till("sm_" + var_368d405d + "_cleared");
    trigger::use(trig_name, var_66d7c971);
    return;
  }

  assertmsg("<dev string:x285>" + var_368d405d + "<dev string:x275>");
}

function function_eba7c12(var_368d405d, trig_name, var_66d7c971, once_only) {
  if(isDefined(once_only) && once_only) {
    trigger = getent(trig_name, var_66d7c971);
    assert(isDefined(trigger), "<dev string:x21f>" + var_66d7c971 + "<dev string:x22f>" + trig_name + "<dev string:x236>");
    trigger endon(#"trigger");
  }

  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    level flag::wait_till("sm_" + var_368d405d + "_enabled");
    trigger::use(trig_name, var_66d7c971);
    return;
  }

  assertmsg("<dev string:x285>" + var_368d405d + "<dev string:x275>");
}

function function_cf623c0e(var_368d405d, process, ent, var1, var2, var3, var4, var5) {
  assert(isDefined(process), "<dev string:x2b2>");
  assert(level flag::exists("<dev string:xc3>" + var_368d405d + "<dev string:xca>"), "<dev string:x2e9>" + var_368d405d + "<dev string:x275>");
  wait_till_complete(var_368d405d);
  util::single_func(ent, process, var1, var2, var3, var4, var5);
}

function function_685f0f0b(var_368d405d, process, ent, var1, var2, var3, var4, var5) {
  assert(isDefined(process), "<dev string:x314>");
  assert(level flag::exists("<dev string:xc3>" + var_368d405d + "<dev string:xca>"), "<dev string:x34a>" + var_368d405d + "<dev string:x275>");
  wait_till_cleared(var_368d405d);
  util::single_func(ent, process, var1, var2, var3, var4, var5);
}

function function_2886c4a9(var_368d405d, process, ent, var1, var2, var3, var4, var5) {
  assert(isDefined(process), "<dev string:x374>");
  assert(level flag::exists("<dev string:xc3>" + var_368d405d + "<dev string:xca>"), "<dev string:x3aa>" + var_368d405d + "<dev string:x275>");
  function_58415221(var_368d405d);
  util::single_func(ent, process, var1, var2, var3, var4, var5);
}

function enable(var_368d405d, var_6ea96389) {
  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    foreach(sm in level.spawn_managers) {
      if(isDefined(sm) && sm.sm_id == var_368d405d) {
        sm notify(#"enable");
        return;
      }
    }

    return;
  }

  if(!is_true(var_6ea96389)) {
    assertmsg("<dev string:x3d4>" + var_368d405d + "<dev string:x275>");
  }
}

function disable(var_368d405d, var_6ea96389) {
  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    foreach(sm in level.spawn_managers) {
      if(isDefined(sm) && sm.sm_id == var_368d405d) {
        sm notify(#"disable");
        return;
      }
    }

    return;
  }

  if(!is_true(var_6ea96389)) {
    assertmsg("<dev string:x3ef>" + var_368d405d + "<dev string:x275>");
  }
}

function kill(var_368d405d, var_6ea96389) {
  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    foreach(sm in level.spawn_managers) {
      if(isDefined(sm) && sm.sm_id == var_368d405d) {
        sm delete();
        arrayremovevalue(level.spawn_managers, undefined);
        return;
      }
    }

    return;
  }

  if(!is_true(var_6ea96389)) {
    assertmsg("<dev string:x40b>" + var_368d405d + "<dev string:x275>");
  }
}

function is_enabled(var_368d405d) {
  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    if(level flag::get("sm_" + var_368d405d + "_enabled")) {
      return 1;
    }

    return 0;
  }

  assertmsg("<dev string:x424>" + var_368d405d + "<dev string:x275>");
}

function is_complete(var_368d405d) {
  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    if(level flag::get("sm_" + var_368d405d + "_complete")) {
      return 1;
    }

    return 0;
  }

  assertmsg("<dev string:x443>" + var_368d405d + "<dev string:x275>");
}

function function_abe43927(var_368d405d) {
  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    if(level flag::get("sm_" + var_368d405d + "_cleared")) {
      return 1;
    }

    return 0;
  }

  assertmsg("<dev string:x463>" + var_368d405d + "<dev string:x275>");
}

function is_killed(var_368d405d) {
  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    if(level flag::get("sm_" + var_368d405d + "_killed")) {
      return 1;
    }

    return 0;
  }

  assertmsg("<dev string:x482>" + var_368d405d + "<dev string:x275>");
}

function wait_till_cleared(var_368d405d) {
  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    level flag::wait_till("sm_" + var_368d405d + "_cleared");
    return;
  }

  assertmsg("<dev string:x4a0>" + var_368d405d + "<dev string:x275>");
}

function function_1e9819fa(var_368d405d, var_e672b95b) {
  assert(isDefined(var_e672b95b), "<dev string:x4c6>");
  assert(var_e672b95b, "<dev string:x50f>");

  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    level flag::wait_till("sm_" + var_368d405d + "_complete");
  } else {
    assertmsg("<dev string:x570>" + var_368d405d + "<dev string:x275>");
  }

  if(level flag::get("sm_" + var_368d405d + "_cleared")) {
    return;
  }

  while(get_ai(var_368d405d).size > var_e672b95b) {
    wait 0.1;
  }
}

function wait_till_complete(var_368d405d) {
  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    level flag::wait_till("sm_" + var_368d405d + "_complete");
    return;
  }

  assertmsg("<dev string:x59b>" + var_368d405d + "<dev string:x275>");
}

function function_58415221(var_368d405d) {
  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    level flag::wait_till("sm_" + var_368d405d + "_enabled");
    return;
  }

  assertmsg("<dev string:x5c2>" + var_368d405d + "<dev string:x275>");
}

function function_371d10c1(var_368d405d, count) {
  if(level flag::exists("sm_" + var_368d405d + "_enabled")) {
    level flag::wait_till("sm_" + var_368d405d + "_enabled");
  } else {
    assertmsg("<dev string:x5e8>" + var_368d405d + "<dev string:x275>");
  }

  spawn_manager = function_aaa872c1(var_368d405d);
  assert(spawn_manager.size, "<dev string:x614>");
  assert(spawn_manager.size == 1, "<dev string:x660>");

  while(true) {
    if(isDefined(spawn_manager[0].spawncount) && spawn_manager[0].spawncount < count && !is_killed(var_368d405d)) {
      wait 0.5;
      continue;
    }

    break;
  }
}

function get_ai(var_368d405d) {
  a_ai = getaiarray(var_368d405d, "sm_id");
  return a_ai;
}