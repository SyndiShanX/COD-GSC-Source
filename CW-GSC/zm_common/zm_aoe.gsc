/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_aoe.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm;
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

function private autoexec __init__system__() {
  system::register(#"zm_aoe", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "aoe_state", 1, getminbitcountfornum(5), "int");
  clientfield::register("scriptmover", "aoe_id", 1, getminbitcountfornum(2), "int");
}

function private postinit() {
  function_15dea507(1, "zm_aoe_radiation_hazard", 10, 95000, 5000, 1, 1, 75, 175);
}

function private function_e969e75(type) {
  assert(isDefined(level.var_400ae143));
  arraykeys = getarraykeys(level.var_400ae143);

  if(isinarray(arraykeys, hash(type))) {
    return level.var_400ae143[hash(type)];
  }

  return undefined;
}

function function_15dea507(aoeid, type, var_3a11a165, lifetime, var_f2cd3aad, damagemin, damagemax, radius, height) {
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

function function_371b4147(aoeid, type, position, userdata, var_fb4d789f, var_6efc944c) {
  var_46f1b5eb = function_e969e75(type);
  assert(isDefined(var_46f1b5eb), "<dev string:x75>");

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

  if(isDefined(var_fb4d789f)) {
    aoe.var_fb4d789f = var_fb4d789f;
  }

  if(isDefined(var_6efc944c)) {
    aoe.var_6efc944c = var_6efc944c;
  }
}

function private function_668a9b2d(aoe, type) {
  var_46f1b5eb = function_e969e75(type);
  assert(isDefined(var_46f1b5eb), "<dev string:x75>");
  array::add(var_46f1b5eb.var_9a08bb02, aoe);
  assert(var_46f1b5eb.var_9a08bb02.size <= var_46f1b5eb.var_3a11a165);
}

function private function_87bbe4fc(type) {
  var_46f1b5eb = function_e969e75(type);
  assert(isDefined(var_46f1b5eb), "<dev string:x75>");

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

function private function_fa03204a(aoe, type) {
  var_46f1b5eb = function_e969e75(type);
  assert(isinarray(var_46f1b5eb.var_9a08bb02, aoe));

  if(isDefined(aoe.userdata)) {
    if(isDefined(level.var_6efc944c)) {
      [[level.var_6efc944c]](aoe);
    }

    if(isDefined(aoe.var_6efc944c)) {
      [[aoe.var_6efc944c]](aoe);
    }
  }

  arrayremovevalue(var_46f1b5eb.var_9a08bb02, aoe);
  assert(var_46f1b5eb.var_9a08bb02.size < var_46f1b5eb.var_3a11a165);
  thread function_4f0db8cf(aoe.entity);
}

function private function_4f0db8cf(entity) {
  waitframe(2);
  entity delete();
}

function private function_2c33d107(type) {
  var_46f1b5eb = function_e969e75(type);
  var_528d5f55 = function_87bbe4fc(type);
  function_ccf8f659(var_528d5f55, 1);
  thread function_fa03204a(var_528d5f55, type);
}

function private function_ccf8f659(aoe, forceend = 0) {
  var_46f1b5eb = function_e969e75(aoe.type);
  assert(isDefined(var_46f1b5eb));

  if(aoe.state == 5) {
    return;
  }

  if(forceend || is_true(aoe.forceend)) {
    if(aoe.state != 3 && aoe.state != 4) {
      function_97d801ea(aoe, var_46f1b5eb, aoe.var_a0739fc1);
      return;
    }
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

    if(isDefined(aoe.var_fb4d789f)) {
      [[aoe.var_fb4d789f]](aoe);
    }

    return;
  }

  if(aoe.state == 2) {
    function_97d801ea(aoe, var_46f1b5eb, 0);
    return;
  }

  if(aoe.state == 3 || aoe.state == 4) {
    aoe.entity clientfield::set("aoe_state", 5);
    aoe.state = 5;
  }
}

function private function_97d801ea(aoe, var_46f1b5eb, var_a0739fc1) {
  var_46f1b5eb.var_be1913ae = gettime() + var_a0739fc1.var_f2cd3aad;

  if(is_true(var_46f1b5eb.var_a0739fc1)) {
    var_46f1b5eb.entity clientfield::set("aoe_state", 4);
    var_46f1b5eb.state = 4;
    var_46f1b5eb notify(#"hash_16055baf8d7c453a");
    return;
  }

  var_46f1b5eb.entity clientfield::set("aoe_state", 3);
  var_46f1b5eb.state = 3;
  var_46f1b5eb notify(#"hash_3913004963ca6fe4");
}

function function_3690781e() {
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

function function_389bf7bf(aoe, var_a0739fc1) {
  aoe.forceend = 1;
  aoe.var_a0739fc1 = var_a0739fc1;
}

function private function_e5950b1e(type) {
  var_46f1b5eb = function_e969e75(type);
  assert(isDefined(var_46f1b5eb));
  var_2aad0cec = [];

  foreach(aoe in var_46f1b5eb.var_9a08bb02) {
    function_ccf8f659(aoe);

    if(aoe.state == 5) {
      array::add(var_2aad0cec, aoe, 0);
    }
  }

  foreach(aoe in var_2aad0cec) {
    function_fa03204a(aoe, aoe.type);
  }
}

function private function_bea2e288(type) {
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
          #str_source: aoe.type, #origin: aoe.entity.origin
        });
      }
    }
  }
}

function private function_60bb02f3(type) {
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

function private function_e39c0be4(var_46f1b5eb) {
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
            print3d(aoe.position + (0, 0, var_46f1b5eb.height + 5), "<dev string:xaa>" + var_46f1b5eb.type + "<dev string:xb4>" + i + "<dev string:xb9>", (1, 0, 0));
          } else {
            print3d(aoe.position + (0, 0, var_46f1b5eb.height + 5), "<dev string:xaa>" + var_46f1b5eb.type + "<dev string:xb4>" + i + "<dev string:xb9>", (1, 0.5, 0));
          }

          i++;
        }
      }
    }

    waitframe(1);
  }
}