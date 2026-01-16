/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\zm_aoe.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm;

#namespace zm_aoe;

class areaofeffect {
  var spawntime;
  var state;
  var var_be1913ae;

  constructor() {
    spawntime = gettime();
    state = 0;
    var_be1913ae = gettime() + 100;
  }

}

class class_698343df {
  var var_9a08bb02;

  constructor() {
    var_9a08bb02 = [];
  }

}

autoexec __init__system__() {
  system::register(#"zm_aoe", &__init__, &__main__, undefined);
}

__init__() {
  clientfield::register("scriptmover", "aoe_state", 1, getminbitcountfornum(4), "int");
  clientfield::register("scriptmover", "aoe_id", 1, getminbitcountfornum(8), "int");
}

private __main__() {
  function_15dea507(1, "zm_aoe_spear", 15, 60000, 2000, 5, 15, 40, 80);
  function_15dea507(2, "zm_aoe_spear_small", 15, 60000, 2000, 5, 15, 20, 80);
  function_15dea507(3, "zm_aoe_spear_big", 15, 60000, 2000, 5, 15, 60, 80);
  function_15dea507(4, "zm_aoe_strafe_storm", 15, 45000, 2000, 3, 5, 80, 80);
  function_15dea507(5, "zm_aoe_chaos_bolt", 10, 30000, 2000, 3, 5, 40, 80);
  function_15dea507(6, "zm_aoe_chaos_bolt_2", 10, 60000, 2000, 3, 5, 60, 80);
  function_15dea507(7, "zm_aoe_chaos_bolt_annihilate", 10, 5000, 2000, 3, 5, 20, 80);
}

private function_e969e75(type) {
  assert(isDefined(level.var_400ae143));
  arraykeys = getarraykeys(level.var_400ae143);

  if(isinarray(arraykeys, hash(type))) {
    return level.var_400ae143[hash(type)];
  }

  return undefined;
}

function_15dea507(aoeid, type, var_3a11a165, lifetime, var_f2cd3aad, damagemin, damagemax, radius, height) {
  if(!isDefined(level.var_400ae143)) {
    level.var_400ae143 = [];
  }

  arraykeys = getarraykeys(level.var_400ae143);
  assert(!isinarray(arraykeys, hash(type)));
  var_508aaded = new class_698343df();
  level.var_400ae143[type] = var_508aaded;
  assert(damagemin <= damagemax, "<dev string:x38>");
  var_508aaded.type = type;
  var_508aaded.var_3a11a165 = var_3a11a165;
  var_508aaded.lifetime = lifetime;
  var_508aaded.damagemin = damagemin;
  var_508aaded.damagemax = damagemax;
  var_508aaded.var_f2cd3aad = var_f2cd3aad;
  var_508aaded.radius = radius;
  var_508aaded.height = height;
  var_508aaded.aoeid = aoeid;
  level thread function_60bb02f3(type);

  level thread function_e39c0be4(var_508aaded);

}

function_371b4147(aoeid, type, position, userdata) {
  var_46f1b5eb = function_e969e75(type);
  assert(isDefined(var_46f1b5eb), "<dev string:x74>");

  if(var_46f1b5eb.var_9a08bb02.size >= var_46f1b5eb.var_3a11a165) {
    function_2c33d107(type);
  }

  assert(var_46f1b5eb.var_9a08bb02.size < var_46f1b5eb.var_3a11a165);
  aoe = new areaofeffect();
  aoe.position = position;
  aoe.endtime = gettime() + var_46f1b5eb.lifetime;
  aoe.entity = spawn("script_model", position);
  aoe.type = type;
  aoe.entity clientfield::set("aoe_id", aoeid);
  function_668a9b2d(aoe, type);

  if(isDefined(userdata)) {
    aoe.userdata = userdata;
  }
}

private function_668a9b2d(aoe, type) {
  var_46f1b5eb = function_e969e75(type);
  assert(isDefined(var_46f1b5eb), "<dev string:x74>");
  array::add(var_46f1b5eb.var_9a08bb02, aoe);
  assert(var_46f1b5eb.var_9a08bb02.size <= var_46f1b5eb.var_3a11a165);
}

private function_87bbe4fc(type) {
  var_46f1b5eb = function_e969e75(type);
  assert(isDefined(var_46f1b5eb), "<dev string:x74>");

  if(var_46f1b5eb.var_9a08bb02.size) {
    oldest = var_46f1b5eb.var_9a08bb02[0];

    foreach(aoe in var_46f1b5eb.var_9a08bb02) {
      if(aoe.spawntime < oldest.spawntime) {
        oldest = aoe;
      }
    }

    return oldest;
  }
}

private function_fa03204a(aoe, type) {
  var_46f1b5eb = function_e969e75(type);
  assert(isinarray(var_46f1b5eb.var_9a08bb02, aoe));

  if(isDefined(aoe.userdata) && isDefined(level.var_6efc944c)) {
    [[level.var_6efc944c]](aoe);
  }

  arrayremovevalue(var_46f1b5eb.var_9a08bb02, aoe);
  assert(var_46f1b5eb.var_9a08bb02.size < var_46f1b5eb.var_3a11a165);
  thread function_4f0db8cf(aoe.entity);
}

private function_4f0db8cf(entity) {
  waitframe(2);
  entity delete();
}

private function_2c33d107(type) {
  var_46f1b5eb = function_e969e75(type);
  var_528d5f55 = function_87bbe4fc(type);
  function_ccf8f659(var_528d5f55, 1);
  thread function_fa03204a(var_528d5f55, type);
}

private function_ccf8f659(aoe, forceend = 0) {
  var_46f1b5eb = function_e969e75(aoe.type);
  assert(isDefined(var_46f1b5eb));

  if(forceend) {
    aoe.entity clientfield::set("aoe_state", 4);
    aoe.state = 4;
    return;
  }

  if(gettime() < aoe.var_be1913ae) {
    return;
  }

  if(aoe.state == 0) {
    aoe.entity clientfield::set("aoe_state", 1);
    aoe.state = 1;
    aoe.var_be1913ae = gettime() + 100;
    return;
  }

  if(aoe.state == 1) {
    aoe.entity clientfield::set("aoe_state", 2);
    aoe.state = 2;
    aoe.var_be1913ae = aoe.endtime;
    return;
  }

  if(aoe.state == 2) {
    aoe.entity clientfield::set("aoe_state", 3);
    aoe.state = 3;
    aoe.var_be1913ae = gettime() + var_46f1b5eb.var_f2cd3aad;
    return;
  }

  if(aoe.state == 3) {
    aoe.entity clientfield::set("aoe_state", 4);
    aoe.state = 4;
  }
}

function_3690781e() {
  foreach(var_eb93f0b0 in level.var_400ae143) {
    if(isarray(var_eb93f0b0.var_9a08bb02)) {
      var_4df07587 = arraycopy(var_eb93f0b0.var_9a08bb02);

      foreach(var_3e8795ff in var_4df07587) {
        function_ccf8f659(var_3e8795ff, 1);
        level thread function_fa03204a(var_3e8795ff, var_3e8795ff.type);
      }
    }
  }
}

private function_e5950b1e(type) {
  var_46f1b5eb = function_e969e75(type);
  assert(isDefined(var_46f1b5eb));
  var_2aad0cec = [];

  foreach(aoe in var_46f1b5eb.var_9a08bb02) {
    function_ccf8f659(aoe);

    if(aoe.state == 4) {
      array::add(var_2aad0cec, aoe, 0);
    }
  }

  foreach(aoe in var_2aad0cec) {
    function_fa03204a(aoe, aoe.type);
  }
}

private function_bea2e288(type) {
  var_46f1b5eb = function_e969e75(type);
  assert(isDefined(var_46f1b5eb));
  players = getplayers();

  foreach(aoe in var_46f1b5eb.var_9a08bb02) {
    foreach(player in players) {
      assert(isDefined(aoe.entity));
      dist = distance(aoe.entity.origin, player.origin);
      withinrange = dist <= var_46f1b5eb.radius;
      var_c0af03ae = 0;

      if(!withinrange) {
        continue;
      }

      heightdiff = abs(aoe.entity.origin[2] - player.origin[2]);

      if(heightdiff <= var_46f1b5eb.height) {
        var_c0af03ae = 1;
      }

      if(withinrange && var_c0af03ae) {
        damage = mapfloat(0, var_46f1b5eb.radius, var_46f1b5eb.damagemin, var_46f1b5eb.damagemax, dist);
        player dodamage(damage, aoe.entity.origin);
        player notify(#"aoe_damage", {
          #str_source: aoe.type, 
          #origin: aoe.entity.origin
        });
      }
    }
  }
}

private function_60bb02f3(type) {
  var_46f1b5eb = function_e969e75(type);
  assert(isDefined(var_46f1b5eb));

  while(true) {
    if(!var_46f1b5eb.var_9a08bb02.size) {
      waitframe(1);
      continue;
    }

    function_e5950b1e(type);
    function_bea2e288(type);
    waitframe(1);
  }
}

private function_e39c0be4(var_46f1b5eb) {
  var_46f1b5eb endon(#"hash_343e166e4aa4288e");

  while(true) {
    if(getdvarint(#"zm_debug_aoe", 0)) {
      if(var_46f1b5eb.var_9a08bb02.size) {
        var_87bbe4fc = function_87bbe4fc(var_46f1b5eb.type);
        i = 0;

        foreach(aoe in var_46f1b5eb.var_9a08bb02) {
          circle(aoe.position, var_46f1b5eb.radius, (1, 0.5, 0), 1, 1);
          circle(aoe.position + (0, 0, var_46f1b5eb.height), var_46f1b5eb.radius, (1, 0.5, 0), 1, 1);
          line(aoe.position, aoe.position + (0, 0, var_46f1b5eb.height), (1, 0.5, 0));

          if(aoe == var_87bbe4fc) {
            print3d(aoe.position + (0, 0, var_46f1b5eb.height + 5), "<dev string:xa8>" + var_46f1b5eb.type + "<dev string:xb1>" + i + "<dev string:xb5>", (1, 0, 0));
          } else {
            print3d(aoe.position + (0, 0, var_46f1b5eb.height + 5), "<dev string:xa8>" + var_46f1b5eb.type + "<dev string:xb1>" + i + "<dev string:xb5>", (1, 0.5, 0));
          }

          i++;
        }
      }
    }

    waitframe(1);
  }
}

