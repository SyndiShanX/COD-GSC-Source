/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6b8ada8db8d28c77.gsc
*************************************************/

#using script_12668187dcf15b96;
#using script_3113b52a395cd586;
#using script_d09ad38bcf5794b;
#using scripts\common\utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\scriptable_door_utility;
#using scripts\engine\scriptable_door;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\locksandkeys;
#namespace namespace_2b6fc7c256cafc0;

function init() {
  if(!isDefined(level.exgm)) {
    level.exgm = spawnStruct();
  }

  scripts\mp\locksandkeys::init();
  scripts\engine\scriptable_door::function_29ba88e5ce21f3fd(&function_6416fb9a24d278b4);
  scripts\engine\scriptable_door::function_e37078f3d00ef312(&function_504f19b32802cb8d);

  while(!isDefined(level.tool_use) || !istrue(level.tool_use.init)) {
    waitframe();
  }

  function_b2eb3fc6ccae115e();

  level thread debug_doors();
}

function private function_b2eb3fc6ccae115e() {
  if(isDefined(level.exgm) && isDefined(level.exgm.lockedspaces)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  level.exgm.lockedspaces = [];
  var_4c7bfe49f37e4faf = getStructArray("exgm_locked_space", "script_noteworthy");
  assert(isDefined(var_4c7bfe49f37e4faf));

  if(var_4c7bfe49f37e4faf.size <= 0) {
    println("<dev string:x5e>");
    return;
  }

  function_656d643079457017(var_4c7bfe49f37e4faf);

  var_52e1498c41df1407 = function_39c8d8e7c1719ed4(var_4c7bfe49f37e4faf);

  if(!isDefined(var_52e1498c41df1407)) {
    println("<dev string:xb6>");
    return;
  }

  foreach(node in var_52e1498c41df1407) {
    if(!isDefined(node)) {
      continue;
    }

    node function_4f241614c981db96();
    level.exgm.lockedspaces[level.exgm.lockedspaces.size] = node;
  }
}

function private function_39c8d8e7c1719ed4(var_4c7bfe49f37e4faf) {
  if(getdvarint(@ "hash_e87cee823579fbd8", 0) == 1) {
    return var_4c7bfe49f37e4faf;
  }

  hotzones = function_1363930cb3f53aef();

  if(!isDefined(hotzones)) {
    return undefined;
  }

  var_7c28d6d15ff7e61e = [];

  foreach(hotzone in hotzones) {
    if(!isDefined(hotzone)) {
      continue;
    }

    zoneindex = hotzone.zoneindex;
    zonetype = hotzone.zonetype;

    if(!isDefined(zoneindex) || !isDefined(zonetype) || zonetype != 8) {
      continue;
    }

    mainnode = function_f6ca723a91bb41bf(zoneindex, var_4c7bfe49f37e4faf, var_7c28d6d15ff7e61e);

    if(!isDefined(mainnode)) {
      println("<dev string:xfe>" + namespace_36be7f9eab6ca7bc::function_bf040858853b69df(zoneindex));
      continue;
    }

    mainnode.zoneindex = zoneindex;
    mainnode.zonename = function_aae8b5dc22c12d2c(zoneindex);

    var_7c28d6d15ff7e61e = array_add(var_7c28d6d15ff7e61e, mainnode);
  }

  return var_7c28d6d15ff7e61e;
}

function private function_f6ca723a91bb41bf(zoneindex, var_96ef5feafe62d6fa, excludenodes) {
  if(isDefined(zoneindex) && isDefined(var_96ef5feafe62d6fa)) {
    epsilon = 0.1;

    foreach(mainnode in var_96ef5feafe62d6fa) {
      if(!isDefined(mainnode) || isDefined(excludenodes) && array_contains(excludenodes, mainnode)) {
        continue;
      }

      var_3cbdb56ae84724e6 = function_c56aa54c03c6ff11(zoneindex, mainnode.origin);

      if(isDefined(var_3cbdb56ae84724e6) && var_3cbdb56ae84724e6 < epsilon) {
        return mainnode;
      }
    }
  }

  return undefined;
}

function private function_4f241614c981db96() {
  subnodes = getStructArray(self.target, "targetname");
  assert(isDefined(subnodes));

  foreach(node in subnodes) {
    if(!isDefined(node) || !isDefined(node.script_noteworthy) || !isDefined(node.origin)) {
      continue;
    }

    if(!isDefined(node.angles)) {
      node.angles = (0, 0, 0);
    }

    function_db053c578a9de360(node);
  }
}

function private function_db053c578a9de360(subnode) {
  assert(isDefined(subnode));

  switch (tolower(subnode.script_noteworthy)) {
    case #"hash_8f30172a5213bf0a":
      function_7ed146ec8f255585(subnode);
      break;
    case #"hash_9c365061f1e6f507":
      function_d2d0c9d710b1d69d(subnode);
      break;
    case #"hash_f776ad1e72595fcb":
      setupcache(subnode);
      break;
    default:
      setupprop(subnode);
      break;
  }
}

function private setupcache(subnode) {
  assert(isDefined(subnode));

  if(!isDefined(self.caches)) {
    self.caches = [];
  }

  cache = spawnscriptable("cache_exgm_cache_crowbar_door", subnode.origin, subnode.angles);

  if(!isDefined(cache)) {
    println("<dev string:x13a>");
    return;
  }

  cache.node = subnode;
  self.caches[self.caches.size] = cache;
}

function private function_d2d0c9d710b1d69d(subnode) {
  assert(isDefined(subnode));

  if(!isDefined(self.var_6c0ed674eec9b897)) {
    self.var_6c0ed674eec9b897 = [];
  }

  doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(subnode.origin, 100, 100);

  if(isDefined(doors) && doors.size > 0) {
    foreach(door in doors) {
      if(!isDefined(door)) {
        continue;
      }

      door function_9af4c9b2cc1bf989();
      door.var_d9169fc096165e2b = 1;
      self.var_6c0ed674eec9b897[self.var_6c0ed674eec9b897.size] = door;
    }
  }
}

function private setupprop(subnode) {
  assert(isDefined(subnode));

  if(!isDefined(self.props)) {
    self.props = [];
  }

  prop = namespace_92675a37bd817c19::function_c682e2b1b49deb8f(subnode);

  if(!isDefined(prop)) {
    println("<dev string:x16d>");
    return;
  }

  prop.node = subnode;
  self.props[self.props.size] = prop;
}

function function_95faa2e34b9a63a9(subnode, var_9b044ef6110bc60f) {
  if(!isDefined(subnode) || !isDefined(subnode.origin) || !isDefined(subnode.angles)) {
    println("<dev string:x19e>");
    return;
  }

  if(!isDefined(var_9b044ef6110bc60f)) {
    println("<dev string:x1d1>");
    return;
  }

  doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(subnode.origin, 100, 100);

  if(isDefined(doors) && doors.size > 0) {
    foreach(door in doors) {
      if(!isDefined(door) || door scriptabledoorisdouble()) {
        continue;
      }

      door setscriptablepartstate("door", "invisible");
    }
  }

  spawneddoor = spawnscriptable(var_9b044ef6110bc60f, subnode.origin, subnode.angles);

  if(!isDefined(spawneddoor)) {
    println("<dev string:x20a>" + var_9b044ef6110bc60f);
  }

  return spawneddoor;
}

function private function_7ed146ec8f255585(subnode) {
  assert(isDefined(subnode));
  assert(isDefined(subnode.origin));
  assert(isDefined(subnode.angles));

  if(!isDefined(self.tooldoors)) {
    self.tooldoors = [];
  }

  newdoor = function_95faa2e34b9a63a9(subnode, "scriptable_door_exgm_tool_use");

  if(isDefined(newdoor)) {
    newdoor.node = subnode;
    newdoor.var_12669c62db1142f2 = 1;
    newdoor function_88d3ebef9894c114();
    self.tooldoors[self.tooldoors.size] = newdoor;
  }
}

function private function_88d3ebef9894c114() {
  thread namespace_8a301a9e06bc923e::function_9c3bc425fad907df(self);
}

function function_504f19b32802cb8d(scriptable, player, var_85e3240d30e184e7) {
  if(function_d9169fc096165e2b(scriptable) || function_12669c62db1142f2(scriptable)) {
    return 0;
  }

  return scripts\mp\locksandkeys::function_504f19b32802cb8d(scriptable, player, var_85e3240d30e184e7);
}

function function_6416fb9a24d278b4(scriptable, player) {
  if(function_d9169fc096165e2b(scriptable) || function_12669c62db1142f2(scriptable)) {
    return &"MP_DMZ_LOCKS/LOCKED";
  }

  return scripts\mp\locksandkeys::function_6416fb9a24d278b4(scriptable, player);
}

function private function_12669c62db1142f2(scriptable) {
  return isDefined(scriptable) && istrue(scriptable.var_12669c62db1142f2);
}

function private function_d9169fc096165e2b(scriptable) {
  return isDefined(scriptable) && istrue(scriptable.var_d9169fc096165e2b);
}

function private function_77b38d54acb385f2(door, player) {
  assert(isDefined(door) && isDefined(player));
  var_1551eedc8effb6b6 = player.origin - door.origin;
  doorforward = anglesToForward(door.angles);
  crossz = doorforward[0] * var_1551eedc8effb6b6[1] - doorforward[1] * var_1551eedc8effb6b6[0];

  if(abs(crossz) < 0.1) {
    assertmsg("<dev string:x23e>");
    return 0;
  }

  if(crossz > 0) {
    return 1;
  }

  return 0;
}

function debug_doors() {
  level endon("<dev string:x29d>");

  while(true) {
    if(getdvarint(@ "hash_6d2af0dd80a139a8", 0) == 1) {
      setDvar(@ "hash_6d2af0dd80a139a8", 0);
      level thread function_b314668b145fe144();
    }

    if(getdvarint(@ "hash_a1ffbba0cca4a8be", 0) == 1) {
      setDvar(@ "hash_a1ffbba0cca4a8be", 0);
      level thread function_5808f7179c6a8a9d();
    }

    if(getdvarint(@ "hash_7314da8a381200a3", 0) == 1) {
      level thread function_8e69a7b58eeff341();
    }

    if(getdvarint(@ "hash_18d9381f047d4e0f", 0) == 1) {
      level thread function_bd85f751464c186d();
    }

    waitframe();
  }
}

function function_b314668b145fe144() {
  var_34c03e07a8e8888 = [];

  foreach(var_809fdff7726141bb in level.exgm.lockedspaces) {
    if(!isDefined(var_809fdff7726141bb)) {
      continue;
    }

    foreach(door in var_809fdff7726141bb.tooldoors) {
      if(isDefined(door) && !isDefined(door.tool_user)) {
        var_34c03e07a8e8888[var_34c03e07a8e8888.size] = door;
      }
    }
  }

  foreach(door in var_34c03e07a8e8888) {
    door scriptabledoorclose();
  }

  wait 2;

  foreach(door in var_34c03e07a8e8888) {
    door function_88d3ebef9894c114();
  }
}

function function_5808f7179c6a8a9d() {
  subnode = spawnStruct();
  subnode.angles = level.players[0].angles;
  subnode.origin = level.players[0].origin + anglesToForward(level.players[0].angles) * 50;
  subnode.origin = scripts\mp\gametypes\br_public::droptogroundmultitrace(subnode.origin, 100, -100);
  mainnode = spawnStruct();
  mainnode.target = "<dev string:x2ab>";
  mainnode.origin = subnode.origin + (0, 0, 100);
  mainnode.zonename = "<dev string:x2ab>";
  mainnode.var_d7204dbfcf3540cb = [];
  mainnode.var_d7204dbfcf3540cb[0] = subnode;
  function_7c1bf24c78f1b6db(mainnode);
  mainnode function_7ed146ec8f255585(subnode);
  level.exgm.lockedspaces[level.exgm.lockedspaces.size] = mainnode;
}

function function_656d643079457017(mainnodes) {
  foreach(node in mainnodes) {
    function_7c1bf24c78f1b6db(node);
  }
}

function function_7c1bf24c78f1b6db(mainnode) {
  if(!isDefined(mainnode)) {
    return;
  }

  if(!isDefined(level.exgm.var_1d27449e146df7c5)) {
    level.exgm.var_1d27449e146df7c5 = [];
  }

  if(!isDefined(mainnode.var_d7204dbfcf3540cb)) {
    mainnode.var_d7204dbfcf3540cb = getStructArray(mainnode.target, "<dev string:x2be>");
  }

  level.exgm.var_1d27449e146df7c5[level.exgm.var_1d27449e146df7c5.size] = mainnode;
}

function function_8e69a7b58eeff341() {
  if(!isDefined(level.exgm.var_1d27449e146df7c5) || level.exgm.var_1d27449e146df7c5.size == 0) {
    return;
  }

  colorred = (1, 0, 0);
  colorgreen = (0, 1, 0);

  foreach(node in level.exgm.var_1d27449e146df7c5) {
    if(!isDefined(node)) {
      continue;
    }

    function_d4e7dd0e52999f80(node, colorred, colorgreen);
  }
}

function function_bd85f751464c186d() {
  if(!isDefined(level.exgm.lockedspaces) || level.exgm.lockedspaces.size == 0) {
    return;
  }

  coloryellow = (1, 1, 0);

  foreach(node in level.exgm.lockedspaces) {
    if(!isDefined(node)) {
      continue;
    }

    function_d4e7dd0e52999f80(node, coloryellow, coloryellow);
  }
}

function function_d4e7dd0e52999f80(mainnode, var_d785d83def2cb406, var_17b0e0732d31c8fb) {
  if(!isDefined(mainnode.target) || !isDefined(mainnode.origin)) {
    return;
  }

  debugtextoffset = (0, 0, -20);
  debugcircleradius = 15;
  var_51a809d1653be858 = (0, 0, -10);
  var_d785d83def2cb406 = ter_op(isDefined(var_d785d83def2cb406), var_d785d83def2cb406, (1, 0, 0));
  var_17b0e0732d31c8fb = ter_op(isDefined(var_17b0e0732d31c8fb), var_17b0e0732d31c8fb, (1, 0, 0));
  var_f1faf36202ac327f = 1000;
  sphere(mainnode.origin, var_f1faf36202ac327f, var_d785d83def2cb406);
  function_203964a4bdac9656(mainnode, "<dev string:x2cc>", undefined, var_d785d83def2cb406, mainnode.origin + debugtextoffset, var_51a809d1653be858);
  subnodes = [];
  subnodes = mainnode.var_d7204dbfcf3540cb;

  if(!isDefined(subnodes) || !isarray(subnodes) || subnodes.size == 0) {
    return;
  }

  foreach(node in subnodes) {
    if(!isDefined(node)) {
      continue;
    }

    function_203964a4bdac9656(node, "<dev string:x2d8>", mainnode, var_17b0e0732d31c8fb, node.origin + debugtextoffset, var_51a809d1653be858);
  }
}

function function_203964a4bdac9656(node, nodename, mainnode, debugcolor, var_5f7a6434de19ecb, var_51a809d1653be858) {
  if(!isDefined(node) || !isDefined(node.origin)) {
    return;
  }

  var_240b001b02e3191f = 15;
  sphere(node.origin, var_240b001b02e3191f, debugcolor);

  if(isDefined(mainnode) && isDefined(mainnode.origin) && mainnode != node) {
    thread draw_line_for_time(node.origin, mainnode.origin, debugcolor[0], debugcolor[1], debugcolor[2], level.framedurationseconds);
  }

  if(isDefined(nodename)) {
    debugtext = nodename + "<dev string:x2e3>";
    print3d(var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1);
    var_5f7a6434de19ecb += var_51a809d1653be858;
  }

  debugtext = "<dev string:x2e8>" + node.origin[0] + "<dev string:x2f5>" + node.origin[1] + "<dev string:x2f5>" + node.origin[2] + "<dev string:x2fb>";
  print3d(var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1);
  var_5f7a6434de19ecb += var_51a809d1653be858;

  if(isDefined(node.angles)) {
    debugtext = "<dev string:x300>" + node.angles[0] + "<dev string:x2f5>" + node.angles[1] + "<dev string:x2f5>" + node.angles[2] + "<dev string:x2fb>";
    print3d(var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1);
    var_5f7a6434de19ecb += var_51a809d1653be858;
  }

  if(isDefined(node.zoneindex)) {
    debugtext = "<dev string:x30d>" + node.zoneindex;
    print3d(var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1);
    var_5f7a6434de19ecb += var_51a809d1653be858;
  }

  if(isDefined(node.zonename)) {
    debugtext = "<dev string:x31c>" + node.zonename;
    print3d(var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1);
    var_5f7a6434de19ecb += var_51a809d1653be858;
  }

  if(isDefined(node.target)) {
    debugtext = "<dev string:x32a>" + node.target;
    print3d(var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1);
    var_5f7a6434de19ecb += var_51a809d1653be858;
  }

  if(isDefined(node.targetname)) {
    debugtext = "<dev string:x336>" + node.targetname;
    print3d(var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1);
    var_5f7a6434de19ecb += var_51a809d1653be858;
  }

  if(isDefined(node.script_noteworthy)) {
    debugtext = "<dev string:x346>" + node.script_noteworthy;
    print3d(var_5f7a6434de19ecb, debugtext, debugcolor, 1, 1);
    var_5f7a6434de19ecb += var_51a809d1653be858;
  }
}

# /