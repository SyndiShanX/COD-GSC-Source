/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5404bcacf34a92d.gsc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_drop;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\weapons\weaponobjects;
#using scripts\zm\perk\zm_perk_tombstone;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_weapons;
#namespace namespace_e0966e1e;

function private autoexec __init__system__() {
  system::register(#"hash_6f7d2657f403b90d", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  entry = spawnStruct();
  entry.weapon_name = # "hash_f223cacb02788e3";
  entry.item_name = # "item_zmintel_gold_omega_artifact_4";

  if(!isDefined(level.var_d385a742)) {
    level.var_d385a742 = [];
  } else if(!isarray(level.var_d385a742)) {
    level.var_d385a742 = array(level.var_d385a742);
  }

  level.var_d385a742[level.var_d385a742.size] = entry;
  zm_perk_tombstone::function_7c589e7("tactical", #"item_zmintel_gold_omega_artifact_4");
  weaponobjects::function_e6400478(#"hash_f223cacb02788e3", &function_36bda67f, 1);
  clientfield::register("scriptmover", "" + # "hash_452045cf5cb8bc4c", 16000, 2, "int");
  clientfield::register("scriptmover", "" + # "hash_7833487f87cacad1", 16000, 1, "int");
  clientfield::register("scriptmover", "" + # "hash_1e3fecb02ce56163", 16000, 1, "int");
  callback::on_item_pickup(&on_item_pickup);
  callback::on_item_drop(&on_item_drop);
  callback::on_bleedout(&function_b31c7f6);
  callback::on_disconnect(&function_b31c7f6);
  level.var_cdd63615 = &function_32e79e8;
}

function on_item_pickup(params) {
  if(!isDefined(params.item) || params.item.itementry.name !== # "item_zmintel_gold_omega_artifact_4") {
    return;
  }

  assert(isDefined(params.item.var_7961a37e), "<dev string:x38>");
  item = params.item;
  level flag::set(#"hash_1dc3d47b1604d916");
  item notify(#"hash_46b95c46bf0a5522");

  if(self.var_348162a4 !== item.var_7961a37e) {
    if(isDefined(self.var_2a68975a)) {
      self.var_2a68975a.owner = undefined;
      self.var_2a68975a = undefined;
    }
  }

  if(isDefined(item.owner)) {
    item.owner.var_2a68975a = undefined;
  }

  if(isDefined(item.var_646dca28)) {
    self.var_646dca28 = item.var_646dca28;
    level notify(#"hash_c1bf755b6bc771e" + item.var_7961a37e, {
      #entity: self
    });
  }

  if(isDefined(item.var_9f865186)) {
    level util::delay(0.1, undefined, &function_5c927d7, item.var_9f865186);
  }

  self.var_348162a4 = item.var_7961a37e;

  if(isDefined(self.var_646dca28)) {
    var_646dca28 = item.var_646dca28.aitype;

    if(isDefined(self.var_646dca28.var_d9558be1)) {
      var_d9558be1 = "<dev string:x70>";
    } else {
      var_d9558be1 = "<dev string:x7f>";
    }
  } else {
    var_646dca28 = "<dev string:x8d>";
    var_d9558be1 = "<dev string:x7f>";
  }

  function_2586c596("<dev string:x9a>" + item.var_7961a37e + "<dev string:xb9>" + var_646dca28 + "<dev string:xcf>" + var_d9558be1);
}

function function_5c927d7(zombie) {
  if(!isDefined(zombie)) {
    return;
  }

  level function_1c8713ac(zombie, undefined);
}

function on_item_drop(params) {
  if(!isDefined(params.item) || params.item.itementry.name !== # "item_zmintel_gold_omega_artifact_4" || !isDefined(self.var_348162a4)) {
    return;
  }

  assert(isDefined(self.var_348162a4), "<dev string:xe1>");
  function_2586c596("<dev string:x10c>" + self.var_348162a4);

  params.item.var_7961a37e = self.var_348162a4;

  if(isDefined(self.var_646dca28)) {
    params.item.var_646dca28 = self.var_646dca28;
    level notify(#"hash_c1bf755b6bc771e" + self.var_348162a4, {
      #entity: params.item
    });
  }

  self.var_348162a4 = undefined;
  self.var_646dca28 = undefined;
  params.item thread function_646c719c(180, 0);
}

function function_b31c7f6(params) {
  assert(isPlayer(self));

  if(isDefined(self.var_348162a4)) {
    point = function_4ba8fde(#"item_zmintel_gold_omega_artifact_4");
    self item_drop::drop_item(0, getweapon(#"hash_f223cacb02788e3"), 1, 0, point.id, self.origin, self.angles, 0);
  }
}

function function_36bda67f(watcher) {
  watcher.onspawn = &function_c50ebe3c;
  watcher.onspawnretrievetriggers = &empty_function;
  watcher.ondamage = &empty_function;
  watcher.deleteonplayerspawn = 0;
  watcher.altdetonate = 1;
  watcher.var_e7ebbd38 = &function_2ba36cfa;
}

function function_fee6bda() {
  self endon(#"death");
  self waittill(#"stationary");
  self ghost();
  self.var_dac47117 = util::spawn_model(#"p9_fxanim_zm_gold_essence_trap_mod", self.origin, self.angles);
  self.var_dac47117 thread function_889999bf(self);
  self.var_dac47117 playSound(#"hash_842c1f262fe471d");
  self.var_dac47117 notsolid();
  self thread function_e7592c16();

  if(isDefined(self.var_646dca28)) {
    self.var_dac47117 function_652b9314(1);
    self.var_dac47117 thread scene::play(#"p9_fxanim_zm_gold_essence_trap_bundle", "shake", self.var_dac47117);
    return;
  }

  self thread function_41956b36();
}

function function_41956b36() {
  self endon(#"death");
  self zm_vo::function_d6f8bbd9(#"hash_11a0021e8a0de4cf");
  self waittill(#"hash_7c721ba2998c698b");
  self zm_vo::function_d6f8bbd9(#"hash_52b3ab09bea15ef1");
}

function function_889999bf(var_bea4648f) {
  level endon(#"end_game");
  self endon(#"death");
  var_bea4648f waittill(#"death");

  if(isDefined(self)) {
    self delete();
  }
}

function function_c50ebe3c(watcher, owner) {
  self endon(#"death");
  self.var_86cccd7b = undefined;
  self thread function_646c719c(180, 1);
  self thread function_fee6bda();
  self function_619a5c20();
  self.var_7961a37e = owner.var_348162a4;

  self callback::on_death(&function_71d12dd9);

  if(isDefined(owner)) {
    if(isDefined(owner.var_646dca28)) {
      self.var_646dca28 = owner.var_646dca28;
      owner.var_646dca28 = undefined;
      level notify(#"hash_c1bf755b6bc771e" + self.var_7961a37e, {
        #entity: self
      });
    }

    owner.var_2a68975a = self;
    self.owner = owner;

    if(isDefined(level.var_cdd63615)) {
      owner thread[[level.var_cdd63615]]();
    }
  }

  function_2586c596("<dev string:x129>" + self.var_7961a37e);
}

function function_e7592c16() {
  self endon(#"death");
  self.var_dac47117 function_6018b54a(1);

  while(true) {
    var_245d737a = undefined;
    zombies = getaiteamarray(level.zombie_team);
    var_4f6af2f4 = arraysortclosest(zombies, self.origin, 5, undefined, 64);

    if(isDefined(var_4f6af2f4)) {
      foreach(zombie in var_4f6af2f4) {
        if(!is_true(zombie.var_943dace9) && !is_true(zombie.is_locked) && !is_true(zombie.var_9d11c76e)) {
          self notify(#"hash_7c721ba2998c698b");
          var_245d737a = zombie;
          break;
        }
      }
    }

    if(isDefined(var_245d737a)) {
      if(!isDefined(self.var_86cccd7b)) {
        self.var_dac47117 function_6018b54a(0);
      }
    } else if(isDefined(self.var_86cccd7b)) {
      self.var_dac47117 function_6018b54a(1);
    }

    self.var_86cccd7b = var_245d737a;
    waitframe(1);
  }
}

function function_2ba36cfa(watcher) {
  if(!isDefined(self.var_2a68975a) || !isDefined(self.var_2a68975a.var_86cccd7b) || is_true(self.var_2a68975a.var_86cccd7b.is_locked) || is_true(self.var_2a68975a.var_98d25e8e) || is_true(self.var_2a68975a.broken) || isDefined(self.var_646dca28) || isDefined(self.var_2a68975a.var_646dca28) || !isDefined(self.var_2a68975a.var_dac47117)) {
    function_2586c596("<dev string:x147>");

    return;
  }

  self.var_2a68975a.var_98d25e8e = 1;
  self.var_2a68975a thread function_b6bf3f94(5);
  self.var_2a68975a thread function_62d26159(self.var_2a68975a.var_86cccd7b, self);
  self function_bc82f900(#"zm_interact_rumble");
}

function function_62d26159(var_86cccd7b, player) {
  self endon(#"death", #"hash_46b95c46bf0a5522");
  self.var_9f865186 = var_86cccd7b;
  self.var_dac47117 linkto(self.var_9f865186);
  var_86cccd7b ai::stun(10);
  var_86cccd7b.b_ignore_cleanup = 1;
  var_86cccd7b.is_inert = 1;
  var_86cccd7b.is_locked = 1;
  self.var_dac47117 thread scene::play(#"p9_fxanim_zm_gold_essence_trap_bundle", "open", self.var_dac47117);
  wait 0.5;
  self.var_dac47117 thread function_6fff9b43();
  self.var_dac47117 function_e512e77b(1);
  self.var_dac47117 notify(#"hash_53ccfec5da1e6068");
  wait 3;
  self.var_dac47117 notify(#"hash_6eff933a50ad6ea");

  if(isalive(var_86cccd7b)) {
    var_86cccd7b hide();
    var_86cccd7b notsolid();
    var_86cccd7b val::set(#"being_captured", "allowdeath", 0);
    var_86cccd7b val::set(#"being_captured", "takedamage", 0);
  }

  self.var_dac47117 thread scene::play(#"p9_fxanim_zm_gold_essence_trap_bundle", "close", self.var_dac47117);
  self.var_dac47117 function_e512e77b(0);
  wait 0.1;

  if(isalive(var_86cccd7b)) {
    self.var_dac47117 function_e512e77b(2);
    self.var_dac47117 thread scene::play(#"p9_fxanim_zm_gold_essence_trap_bundle", "shake", self.var_dac47117);
    wait 2;
    self.var_dac47117 function_e512e77b(0);
  }

  if(isalive(var_86cccd7b)) {
    if(var_86cccd7b.health <= var_86cccd7b.maxhealth * (isDefined(var_86cccd7b.var_d9558be1) ? 0.15 : 0.25)) {
      function_2586c596("<dev string:x179>" + var_86cccd7b.aitype);

      var_86cccd7b callback::callback(#"hash_3beb0aebbde81394");
      self.var_646dca28 = var_86cccd7b;
      var_86cccd7b.is_locked = 0;
      var_86cccd7b.var_943dace9 = 1;
      self.var_dac47117 function_652b9314(1);
      self notify(#"hash_5600121a4b0794ab");
      var_86cccd7b ai::stun(600);

      if(isDefined(self.var_7961a37e)) {
        level thread function_3b028b4a(180, var_86cccd7b, self.var_7961a37e, self);
        level thread function_56c2c289(self.var_7961a37e);
      }

      if(isalive(player)) {
        player function_bc82f900(#"damage_heavy");
      }
    } else {
      item_drop::function_ba4c90d9(self);

      if(isalive(player)) {
        player function_bc82f900(#"damage_heavy");
      }

      self.var_dac47117 thread scene::play(#"p9_fxanim_zm_gold_essence_trap_bundle", "open", self.var_dac47117);
      self.broken = 1;
      self.var_dac47117 playSound(#"hash_3543cdcc15d2b0db");
      wait 0.2;
      self.var_dac47117 function_e512e77b(3);

      if(isalive(var_86cccd7b)) {
        level function_1c8713ac(var_86cccd7b);
      }

      self thread zm_vo::function_d6f8bbd9(#"hash_54110dbfbcdb085f");
      self thread function_b3ba3bb3(2);

      function_2586c596("<dev string:x193>");
    }
  }

  self.var_98d25e8e = 0;
  self.var_9f865186 = undefined;
}

function function_b3ba3bb3(delay_time) {
  self endon(#"death");
  wait delay_time;
  level notify(#"hash_6382150c7bec4fd9", {
    #id: self.var_7961a37e
  });
  weaponobjects::function_f2a06099(self, undefined);
  self deletedelay();
}

function function_b6bf3f94(time) {
  self endon(#"death");
  wait time;
  self.var_98d25e8e = undefined;
}

function function_43cd5eff() {
  function_2586c596("<dev string:x1c3>");
  assert(isDefined(self.var_348162a4));

  level notify(#"hash_52b46513284ae413", {
    #id: self.var_348162a4
  });
  level notify(#"hash_56f7aed0dabf82ca" + self.var_348162a4);

  if(isDefined(self.var_646dca28)) {
    self.var_646dca28 delete();
  }

  self thread zm_weapons::weapon_take(getweapon(#"hash_f223cacb02788e3"));
  self.var_348162a4 = undefined;
}

function function_646c719c(time, is_deployed = 0) {
  self endon(#"death", #"hash_5600121a4b0794ab");
  wait time;
  assert(isDefined(self.var_7961a37e));
  level notify(#"hash_6382150c7bec4fd9", {
    #id: self.var_7961a37e
  });

  if(is_true(is_deployed) && isDefined(self.owner)) {
    self.owner.var_2a68975a = undefined;
  }

  if(isDefined(self.var_646dca28)) {
    level function_1c8713ac(self.var_646dca28, self.origin);
    level notify(#"hash_56f7aed0dabf82ca" + self.var_7961a37e);
  }

  if(isDefined(self.var_9f865186)) {
    level function_1c8713ac(self.var_9f865186);
  }

  weaponobjects::function_f2a06099(self, undefined);
  self deletedelay();
}

function function_3b028b4a(time_left, var_646dca28, var_7961a37e, var_b512a2d) {
  level endon(#"end_game", #"hash_56f7aed0dabf82ca" + var_7961a37e);
  start_time = gettime();
  var_28dbb034 = 0;

  if(!isDefined(level.var_acb5d4ce)) {
    level.var_acb5d4ce = [];
  } else if(!isarray(level.var_acb5d4ce)) {
    level.var_acb5d4ce = array(level.var_acb5d4ce);
  }

  level.var_acb5d4ce[var_7961a37e] = spawnStruct();
  level.var_acb5d4ce[var_7961a37e].var_b512a2d = var_b512a2d;
  level.var_acb5d4ce[var_7961a37e].var_b722fee6 = var_b512a2d;

  while(true) {
    result = level waittilltimeout(time_left, #"hash_c1bf755b6bc771e" + var_7961a37e);
    var_1967ad3 = level.var_acb5d4ce[var_7961a37e].var_b512a2d;
    var_b722fee6 = level.var_acb5d4ce[var_7961a37e].var_b722fee6;

    if(result._notify == # "timeout") {
      if(!isDefined(var_646dca28)) {
        println("<dev string:x1eb>");
      } else if(isDefined(var_1967ad3)) {
        level function_1c8713ac(var_646dca28, var_1967ad3.origin, var_28dbb034);
      } else if(isDefined(var_b722fee6)) {
        level function_1c8713ac(var_646dca28, var_b722fee6.origin, var_28dbb034);
      } else {
        assert(0, "<dev string:x203>");
      }

      if(var_28dbb034) {
        if(isPlayer(var_1967ad3)) {
          var_1967ad3 function_bc82f900(#"damage_heavy");
          var_1967ad3 thread zm_weapons::weapon_take(getweapon(#"hash_f223cacb02788e3"));
        }
      } else if(isDefined(var_1967ad3)) {
        item_drop::function_ba4c90d9(var_1967ad3);
        var_dac47117 = var_1967ad3.var_dac47117;

        if(isDefined(var_dac47117)) {
          var_dac47117 thread scene::play(#"p9_fxanim_zm_gold_essence_trap_bundle", "open", var_dac47117);
          var_1967ad3.broken = 1;
          wait 0.2;

          if(isDefined(var_dac47117)) {
            var_dac47117 function_e512e77b(3);
          }

          if(isDefined(var_1967ad3)) {
            var_1967ad3 thread function_b3ba3bb3(2);
          }
        } else {
          var_1967ad3 delete();
        }
      }

      level notify(#"hash_6382150c7bec4fd9", {
        #id: var_7961a37e
      });
      break;
    } else {
      if(isPlayer(result.entity)) {
        var_28dbb034 = 1;
      } else {
        var_28dbb034 = 0;
      }

      level.var_acb5d4ce[var_7961a37e].var_b722fee6 = var_1967ad3;
      level.var_acb5d4ce[var_7961a37e].var_b512a2d = result.entity;
    }

    time_now = gettime();
    time_left -= float(time_now - start_time) / 1000;
    start_time = time_now;
  }
}

function function_56c2c289(var_7961a37e) {
  level endon(#"end_game", #"hash_56f7aed0dabf82ca" + var_7961a37e);
  level thread function_8fc5d602(var_7961a37e, #"hash_203ea2f2b45c85ca");
  wait float(max(isDefined(soundgetplaybacktime(#"hash_203ea2f2b45c85ca")) ? soundgetplaybacktime(#"hash_203ea2f2b45c85ca") : 500, 500)) / 1000;
  level thread function_8fc5d602(var_7961a37e, #"hash_169d351a60759115");
  wait 60 - float(max(isDefined(soundgetplaybacktime(#"hash_203ea2f2b45c85ca")) ? soundgetplaybacktime(#"hash_203ea2f2b45c85ca") : 500, 500)) / 1000;
  level thread function_8fc5d602(var_7961a37e, #"hash_59d0393887a59de");
  wait 60;
  level thread function_8fc5d602(var_7961a37e, #"hash_5dbc46214b51bc37");
  wait 30;
  level thread function_8fc5d602(var_7961a37e, #"hash_3b9f80e58542df7e");
  wait 20;
  level thread function_8fc5d602(var_7961a37e, #"hash_1ff54b5aac84119c");
  wait 1;
  level thread function_8fc5d602(var_7961a37e, #"hash_1ff54c5aac84134f");
  wait 1;
  level thread function_8fc5d602(var_7961a37e, #"hash_1ff54d5aac841502");
  wait 1;
  level thread function_8fc5d602(var_7961a37e, #"hash_1ff54e5aac8416b5");
  wait 1;
  level thread function_8fc5d602(var_7961a37e, #"hash_1ff5475aac840ad0");
  wait 1;
  level thread function_8fc5d602(var_7961a37e, #"hash_1ff5485aac840c83");
  wait 1;
  level thread function_8fc5d602(var_7961a37e, #"hash_1ff5495aac840e36");
  wait 1;
  level thread function_8fc5d602(var_7961a37e, #"hash_1ff54a5aac840fe9");
  wait 1;
  level thread function_8fc5d602(var_7961a37e, #"hash_1ff5535aac841f34");
  wait 1;
  level thread function_8fc5d602(var_7961a37e, #"hash_1ff5545aac8420e7");
  wait 1;
  level thread function_8fc5d602(var_7961a37e, #"hash_41512e441a2e4ce1");
}

function function_8fc5d602(var_7961a37e, vo_string) {
  entity = isDefined(level.var_acb5d4ce[var_7961a37e].var_b512a2d) ? level.var_acb5d4ce[var_7961a37e].var_b512a2d : level.var_acb5d4ce[var_7961a37e].var_b512a2d;

  if(!isDefined(entity)) {
    return;
  }

  if(isPlayer(entity)) {
    level zm_vo::function_d6f8bbd9(vo_string, undefined, entity);
    return;
  }

  var_a5a8e724 = util::spawn_model(#"tag_origin", entity.origin, entity.angles);
  var_a5a8e724 zm_vo::function_d6f8bbd9(vo_string);

  if(isDefined(var_a5a8e724)) {
    var_a5a8e724 delete();
  }
}

function function_1c8713ac(var_646dca28, var_19d9c3aa, var_82529e94 = 0) {
  function_2586c596("<dev string:x21f>");

  if(isDefined(var_19d9c3aa)) {
    if(var_82529e94) {
      var_19d9c3aa += (100, 100, 0);
    }

    var_b45574e6 = getclosestpointonnavmesh(var_19d9c3aa, 500);

    if(!isDefined(var_b45574e6)) {
      var_b45574e6 = var_19d9c3aa;
    }

    var_646dca28 forceteleport(var_b45574e6);
  }

  var_646dca28 thread function_f8ca0196();
}

function function_f8ca0196() {
  self endon(#"death");
  wait 0.1;
  self ai::clear_stun();
  self show();
  self solid();
  self val::reset(#"being_captured", "allowdeath");
  self val::reset(#"being_captured", "takedamage");
  self.b_ignore_cleanup = 0;
  self.is_inert = 0;
  self.var_943dace9 = 0;
  self.is_locked = 0;
}

function function_32e79e8() {
  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(self.var_40f24532)) {
    if(gettime() - self.var_40f24532 > int(10 * 1000)) {
      self zm_equipment::show_hint_text(#"hash_7d040d8a217dc904");

      if(isPlayer(self)) {
        self.var_40f24532 = gettime();
      }
    }

    return;
  }

  self zm_equipment::show_hint_text(#"hash_7d040d8a217dc904");

  if(isPlayer(self)) {
    self.var_40f24532 = gettime();
  }
}

function function_6fff9b43() {
  self endon(#"hash_6eff933a50ad6ea", #"death");
  self waittill(#"hash_53ccfec5da1e6068");

  while(true) {
    a_players = function_a1ef346b();

    foreach(player in a_players) {
      if(distancesquared(player.origin, self.origin) < 62500) {
        player function_bc82f900(#"zm_gold_interact_rumble_small");
      }
    }

    wait 0.3;
  }
}

function function_e512e77b(state) {
  self clientfield::set("" + # "hash_452045cf5cb8bc4c", state);
}

function function_6018b54a(state) {
  self clientfield::set("" + # "hash_7833487f87cacad1", state);
}

function function_652b9314(state) {
  self clientfield::set("" + # "hash_1e3fecb02ce56163", state);
}

function empty_function(watcher, player) {}

function function_71d12dd9(params) {
  if(isDefined(self.var_fd1ae96a)) {
    return;
  }

  function_2586c596("<dev string:x247>" + self.var_7961a37e);
  self.var_fd1ae96a = 1;
}

function function_2586c596(string) {
  if(!getdvarint(#"hash_6c6f56f6f67992a4", 0)) {
    return;
  }

  iprintlnbold(string);
}