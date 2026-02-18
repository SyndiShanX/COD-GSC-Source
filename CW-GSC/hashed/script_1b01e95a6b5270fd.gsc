/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1b01e95a6b5270fd.gsc
***********************************************/

#using script_164a456ce05c3483;
#using script_17dcb1172e441bf6;
#using script_1a9763988299e68d;
#using script_1b01e95a6b5270fd;
#using script_1b0b07ff57d1dde3;
#using script_1ee011cd0961afd7;
#using script_2a5bf5b4a00cee0d;
#using script_3faf478d5b0850fe;
#using script_40f967ad5d18ea74;
#using script_47851dbeea22fe66;
#using script_4d748e58ce25b60c;
#using script_5701633066d199f2;
#using script_5f20d3b434d24884;
#using script_74a56359b7d02ab6;
#using script_774302f762d76254;
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
#namespace doa_enemy;
class class_3593c7e6 {
  var m_name;
  var m_type;
  var var_24544f42;
  var var_89dfe89b;
  var var_9d95490b;
  var var_b1b82dc;
  var var_c0503cf7;
  var var_c23bfa1e;
  var var_edee94ca;
  var var_fde25292;

  constructor() {
    m_name = "";
    var_edee94ca = undefined;
    var_9d95490b = [];
    var_24544f42 = 100;
    var_c23bfa1e = undefined;
    m_type = -1;
  }

  function function_10c2bd8() {
    return var_c0503cf7;
  }

  function function_744739a() {
    return var_89dfe89b;
  }

  function function_17454656() {
    return var_24544f42;
  }

  function getspawner() {
    return var_edee94ca;
  }

  function getname() {
    return m_name;
  }

  function function_3262a6e9(var_c940cca) {
    var_fde25292 = var_c940cca;
  }

  function function_36573e6c(name) {
    var_9d95490b[var_9d95490b.size] = name;
  }

  function function_4a15d1dd() {
    return var_fde25292;
  }

  function gettype() {
    return m_type;
  }

  function function_7edd7727(val) {
    var_24544f42 = val;
  }

  function function_7f3e577e(range = 100) {
    return randomint(range) < var_24544f42;
  }

  function init(spawner, name, type, init_func, think_func, var_af7a3d7c) {
    m_name = name;
    m_type = type;
    var_b1b82dc = 1 << type;
    var_edee94ca = spawner;
    var_c0503cf7 = init_func;
    var_89dfe89b = think_func;
    var_c23bfa1e = var_af7a3d7c;
    var_fde25292 = undefined;
  }

  function function_b8c8dfea() {
    return var_b1b82dc;
  }

  function function_baae6c9d(name) {
    return isinarray(var_9d95490b, name);
  }

  function canspawn() {
    if(isDefined(var_c23bfa1e)) {
      return [[var_c23bfa1e]]();
    }

    return 1;
  }
}

function init() {
  namespace_250e9486::init();
  level.doa.var_adb2d4b9 = [];
  spawners = getspawnerarray("doa_enemy", "targetname");

  foreach(spawner in spawners) {
    var_d240d5de = undefined;
    var_41157a40 = undefined;
    var_c8ceaddf = undefined;
    spawnchance = 100;
    type = -1;
    result = level namespace_250e9486::function_2c6dd74c(spawner);

    if(isDefined(result)) {
      var_d240d5de = result.var_d240d5de;
      var_41157a40 = result.var_41157a40;
      var_c8ceaddf = result.var_c8ceaddf;
      spawnchance = result.spawnchance;
      type = result.type;
    }

    var_7a8f2a62 = function_eff7e0fb(spawner, spawner.script_noteworthy, type, var_d240d5de, var_41157a40, var_c8ceaddf);
    [[var_7a8f2a62]] - > function_7edd7727(spawnchance);

    if(isDefined(result)) {
      foreach(arena in result.var_71e54e3a) {
        [[var_7a8f2a62]] - > function_36573e6c(arena);
      }
    }

    var_663588d = "Zombietron/AI/";
    cmdline = "scr_spawn_enemy " + [[var_7a8f2a62]] - > getname() + "; zombie_devgui enemy";
    util::add_devgui(var_663588d + [[var_7a8f2a62]] - > getname(), cmdline);
  }
}

function function_2f73ff73() {
  level.doa.var_dcbded2 = [];
  level.doa.var_af6d47dd = [];
  level.doa.var_e2e8967b = [];
  level.doa.var_329c97a3 = [];
  level.doa.var_13e8f9c9 = undefined;
  level.doa.var_f4cf4e3 = 24;
  level.doa.zombie_health = 1000;
  level.doa.var_2ad97fac = 0;
  level.doa.var_65a70dc = function_d7c5adee("basic_zombie");
  function_83d593c5(level.doa.var_65a70dc);
}

function main() {
  function_2f73ff73();
  level thread function_7292bc();
}

function function_c617d577() {
  level endon(#"game_over");
  self notify("13d7a68c50b7bd36");
  self endon("13d7a68c50b7bd36");

  while(true) {
    level waittill(#"round_about_to_start", #"round_over", #"doa_exit_taken");
    level.doa.var_2ad97fac = 0;
  }
}

function function_7495bd30() {
  self notify("13a24a56ec61b2f9");
  self endon("13a24a56ec61b2f9");
  level endon(#"game_over", #"hash_40a4d01c20db352c");
  level thread function_c617d577();
  level.doa.var_2ad97fac = 0;
  level.doa.var_afae28e0 = 0;

  while(true) {
    last = level.doa.var_afae28e0;
    wait 1;

    if(last == level.doa.var_afae28e0) {
      if(level.doa.var_2ad97fac < 30) {
        level.doa.var_2ad97fac++;
      }

      continue;
    }

    level.doa.var_2ad97fac -= 8;

    if(level.doa.var_2ad97fac < 0) {
      level.doa.var_2ad97fac = 0;
    }
  }
}

function function_e7e91016() {
  if(flag::get("doa_round_spawning")) {
    return (level.doa.var_2ad97fac == 30);
  }

  return false;
}

function function_83d593c5(var_7a8f2a62) {
  if(!isinarray(level.doa.var_329c97a3, var_7a8f2a62)) {
    level.doa.var_329c97a3[level.doa.var_329c97a3.size] = var_7a8f2a62;
  }
}

function function_251ee3bd(name) {
  def = function_d7c5adee(name);

  if(isDefined(def)) {
    function_83d593c5(def);
  }

  return def;
}

function function_eff7e0fb(spawner, name, type, init, think, canspawn) {
  var_7a8f2a62 = new class_3593c7e6();
  [[var_7a8f2a62]] - > init(spawner, name, type, init, think, canspawn);

  if(name == "basic_zombie") {
    [[var_7a8f2a62]] - > function_3262a6e9(&function_8a080c79);
    level.doa.var_65a70dc = var_7a8f2a62;
  }

  if(name == "crawler_zombie") {
    [[var_7a8f2a62]] - > function_3262a6e9(&killme);
  }

  if(isDefined([[var_7a8f2a62]] - > getspawner())) {
    level.doa.var_adb2d4b9[level.doa.var_adb2d4b9.size] = var_7a8f2a62;
  }

  return var_7a8f2a62;
}

function function_c89f6305() {
  if(namespace_4dae815d::function_59a9cf1d() == 0) {
    namespace_1e25ad94::debugmsg("AI moveFailure at:" + self.origin + " AI Type: " + self.zombie_type);
  }
}

function function_8a080c79() {
  self namespace_ed80aead::function_586ef822();
}

function killme() {
  self thread namespace_ec06fe4a::function_570729f0(0.1);
}

function function_d7c5adee(name) {
  foreach(def in level.doa.var_adb2d4b9) {
    if([[def]] - > getname() === name) {
      return def;
    }
  }
}

function function_924423d(ent) {
  items = [];
  newqueue = [];

  foreach(item in level.doa.var_dcbded2) {
    if(item.notifyent === ent) {
      items[items.size] = ent;
      continue;
    }

    if(!isDefined(newqueue)) {
      newqueue = [];
    } else if(!isarray(newqueue)) {
      newqueue = array(newqueue);
    }

    newqueue[newqueue.size] = item;
  }

  level.doa.var_dcbded2 = newqueue;
  return items;
}

function function_f7086924(var_64a23077) {
  newqueue = [];

  foreach(item in level.doa.var_dcbded2) {
    if(item.var_64a23077 === var_64a23077) {
      continue;
    }

    if(!isDefined(newqueue)) {
      newqueue = [];
    } else if(!isarray(newqueue)) {
      newqueue = array(newqueue);
    }

    newqueue[newqueue.size] = item;
  }

  level.doa.var_dcbded2 = newqueue;
}

function function_5982ca9d(spawndef, count = 10, targetpoint, radius = 0, generator, enemy, var_294cccb7, arena, groupid, expiresat) {
  queueitem = spawnStruct();
  queueitem.spawndef = spawndef;
  queueitem.targetpoint = targetpoint;
  queueitem.radius = radius;
  queueitem.count = count;
  queueitem.enemy = enemy;
  queueitem.notifyent = var_294cccb7;
  queueitem.groupid = groupid;

  if(expiresat !== -1) {
    queueitem.expiration = isDefined(expiresat) ? expiresat : gettime() + 3000;
  }

  queueitem.var_64a23077 = isDefined(generator) ? [[generator]] - > getmodel() : undefined;

  if(isDefined(generator)) {
    queueitem.var_d55f22cb = 1;
  }

  queueitem.arena = arena;

  if(!isDefined(arena) && !isDefined(level.doa.var_6f3d327) && level.doa.world_state == 0) {
    queueitem.arena = level.doa.var_39e3fa99;
  }

  return queueitem;
}

function function_4e8ae191(spawndef, count = 10, targetpoint, radius = 0, generator, enemy, var_294cccb7, arena, groupid, expiresat) {
  queueitem = function_5982ca9d(spawndef, count, targetpoint, radius, generator, enemy, var_294cccb7, arena, groupid, expiresat);
  return spawnai(queueitem, targetpoint);
}

function function_a6b807ea(spawndef, count = 10, targetpoint, radius = 0, generator, enemy, var_294cccb7, arena, groupid, var_1be0f060 = 0, expiresat) {
  if(!isDefined(spawndef)) {
    return;
  }

  if(isDefined(generator)) {
    if(level.doa.var_dcbded2.size > 256) {
      return;
    }
  }

  assert(level.doa.var_dcbded2.size < 500, "<dev string:x38>");
  queueitem = function_5982ca9d(spawndef, count, targetpoint, radius, generator, enemy, var_294cccb7, arena, groupid, expiresat);

  if(!var_1be0f060) {
    level.doa.var_dcbded2[level.doa.var_dcbded2.size] = queueitem;
    return;
  }

  arrayinsert(level.doa.var_dcbded2, queueitem, 0);
}

function function_a0acdb92() {
  level.doa.var_dcbded2 = [];
}

function function_7292bc() {
  self notify("75a107ba19549f17");
  self endon("75a107ba19549f17");
  level endon(#"game_over");
  var_1fb31dea = gettime() + 2000;

  while(true) {
    time = gettime();

    if(namespace_4dae815d::function_59a9cf1d() != 0 && time > var_1fb31dea) {
      removequeue = [];

      foreach(queueitem in level.doa.var_dcbded2) {
        if(is_true(queueitem.var_d55f22cb) && !isDefined(queueitem.var_64a23077)) {
          removequeue[removequeue.size] = queueitem;
        }
      }

      foreach(removeitem in removequeue) {
        arrayremovevalue(level.doa.var_dcbded2, removeitem);
      }

      removequeue = [];
      var_1fb31dea = gettime() + 1000 + randomint(1500);
    }

    if(level.doa.var_dcbded2.size > 0) {
      if(is_true(level.hostmigrationtimer)) {
        waitframe(1);
        continue;
      }

      spawner::global_spawn_throttle();
      var_d42ab4a6 = 0;

      while(level.doa.var_dcbded2.size) {
        queueitem = level.doa.var_dcbded2[0];
        var_d42ab4a6++;

        if(var_d42ab4a6 > 20) {
          waitframe(1);
          var_d42ab4a6 = 0;
        }

        if(queueitem.count <= 0) {
          queueitem = undefined;
          arrayremoveindex(level.doa.var_dcbded2, 0);
          continue;
        }

        if(isDefined(queueitem.expiration) && time > queueitem.expiration) {
          arrayremoveindex(level.doa.var_dcbded2, 0);
          level.doa.var_2b4e2465 += queueitem.count;
          queueitem = undefined;
          continue;
        }

        break;
      }

      if(!isDefined(queueitem) || namespace_250e9486::function_60f6a9e() == 0) {
        waitframe(1);
        continue;
      }

      if(isDefined(queueitem.groupid)) {
        groupid = queueitem.groupid;
        sizeneeded = 0;
        idx = 0;

        while(true) {
          if(level.doa.var_dcbded2.size > idx && level.doa.var_dcbded2[idx].groupid === groupid) {
            sizeneeded += level.doa.var_dcbded2[idx].count;
            level.doa.var_dcbded2[idx].groupid = undefined;
            idx++;
            continue;
          }

          break;
        }

        for(var_44f97d52 = 10; var_44f97d52; var_44f97d52--) {
          var_68a09a83 = namespace_250e9486::function_17d3b57();

          if(var_68a09a83 >= sizeneeded) {
            break;
          }

          wait 1;
        }
      }

      if(queueitem.radius > 0) {
        var_190085e3 = namespace_ec06fe4a::function_65ee50ba(queueitem.targetpoint + (randomintrange(queueitem.radius * -1, queueitem.radius), randomintrange(queueitem.radius * -1, queueitem.radius), 0));
      } else {
        var_190085e3 = queueitem.targetpoint;
      }

      ai = spawnai(queueitem, var_190085e3);

      if(isDefined(ai)) {
        if(isDefined(ai)) {
          namespace_1e25ad94::debugmsg("<dev string:x71>" + ai getentitynumber() + "<dev string:x80>" + [[queueitem.spawndef]] - > getname() + "<dev string:x96>" + ai.origin);
        } else {
          namespace_1e25ad94::debugmsg("<dev string:xa6>" + [[queueitem.spawndef]] - > getname());
        }
      }

      continue;
    }

    wait 0.25;
  }
}

function spawnai(spawnparams, spawnloc) {
  if(!namespace_250e9486::function_60f6a9e()) {
    level.doa.var_cde5274e++;
    return;
  }

  if([[spawnparams.spawndef]] - > canspawn() == 0) {
    return;
  }

  ai = function_db55a448(spawnparams.spawndef, spawnloc, spawnparams.enemy);

  if(isDefined(ai)) {
    level.doa.var_9fcf26ea++;

    if(!is_true(ai.basic)) {
      level.doa.var_5de71250++;
    }

    spawnparams.count--;
    namespace_1e25ad94::debugmsg("Type " + [[spawnparams.spawndef]] - > getname() + " spawning; count left: " + spawnparams.count);
    ai.arena = spawnparams.arena;

    if(isDefined(spawnparams.var_64a23077) && isDefined(spawnparams.var_64a23077.generator)) {
      [[spawnparams.var_64a23077.generator]] - > function_bcd1aaf5(ai);
      center = [[spawnparams.var_64a23077.generator]] - > getcenter();
      radius = [[spawnparams.var_64a23077.generator]] - > getradius();
      ai.var_c8b974fe = center;
      ai.var_f506c5cd = radius;
      ai.var_32d07c96 = sqr(radius) + (sqr(radius) >> 2);
      ai.var_5603780 = [[spawnparams.spawndef]] - > function_4a15d1dd();
      ai.var_d55f22cb = 1;
      ai.var_227e7c79 = 0;

      if(isactor(ai)) {
        ai forceteleport(ai.origin, ai.angles + (0, randomint(360), 0));
      }

      var_6b57b559 = (getplayers().size - 1) * 0.1;

      if(var_6b57b559 > 0) {
        ai.maxhealth += int(ai.maxhealth * var_6b57b559);
        ai.health = ai.maxhealth;
      }

      spawnparams.var_64a23077 = undefined;
    }

    if(isDefined(spawnparams.notifyent)) {
      namespace_1e25ad94::debugmsg("ai_queue_spawned notify sending for ent:" + ai getentitynumber() + " at: " + gettime());
      spawnparams.notifyent notify(#"hash_4c72e79bdad8315e", {
        #ai: ai, #time: gettime()
      });
    }
  } else {
    level.doa.var_de939ab7++;
  }

  return ai;
}

function function_db55a448(spawndef, var_190085e3, enemy, target) {
  spawner = [[spawndef]] - > getspawner();

  if(isDefined(var_190085e3)) {
    spawner.origin = var_190085e3;
  }

  ai = spawner spawner::spawn(1, undefined, var_190085e3);

  if(isDefined(ai)) {
    ai.var_e53efa7e = [[spawndef]] - > gettype();
    ai.var_22b748b = [[spawndef]] - > function_b8c8dfea();
    ai.target = target;
    ai ghost();

    if(isDefined(enemy)) {
      if(issentient(enemy)) {
        ai.favoriteenemy = enemy;
      }

      ai setentitytarget(enemy);
    }

    ai.spawndef = spawndef;
    var_d240d5de = [[spawndef]] - > function_10c2bd8();

    if(!isDefined(var_d240d5de)) {
      var_d240d5de = &namespace_250e9486::function_25b2c8a9;
    }

    ai[[var_d240d5de]]();

    if(isDefined(ai.spawnloc)) {
      if(isactor(ai)) {
        ai forceteleport(ai.spawnloc.origin, ai.spawnloc.angles);
      } else if(isvehicle(ai)) {
        ai.origin = ai.spawnloc.origin;
        ai.angles = ai.spawnloc.angles;
      }
    }

    var_41157a40 = [[spawndef]] - > function_744739a();

    if(!isDefined(var_41157a40)) {
      var_41157a40 = &namespace_250e9486::function_8971bbb7;
    }

    ai thread[[var_41157a40]]();
    ai thread function_b56f90d7(ai.showdelay);
    profilestart();

    if(isDefined(level.doa.var_4425d066)) {
      ai[[level.doa.var_4425d066]]();
    }

    profilestop();
  }

  return ai;
}

function function_b56f90d7(delay = 0.1) {
  self endon(#"hash_5251ab0953e7989f");
  self endon(#"death");

  if(delay > 0) {
    wait delay;
  }

  self namespace_ec06fe4a::function_4f72130c();
  self solid();
}

function function_4b2f19cb() {
  if(namespace_4dae815d::function_59a9cf1d() == 0) {
    spot = [[level.doa.var_39e3fa99]] - > function_70fb5745();
    return spot.origin;
  }

  if(!isDefined(self.var_f506c5cd)) {
    return undefined;
  }

  range = randomfloatrange(0.65, 0.98);
  distance = self.var_f506c5cd * range;
  angle = randomint(360);
  vec = (distance, 0, 0);
  rotated = namespace_ec06fe4a::rotatevec(vec, angle);
  groundpos = groundtrace(self.var_c8b974fe + rotated + (0, 0, 1024) + (0, 0, 8), self.var_c8b974fe + rotated + (0, 0, 1024) + (0, 0, -100000), 0, self)[# "position"];
  return getclosestpointonnavmesh(groundpos, 10000);
}