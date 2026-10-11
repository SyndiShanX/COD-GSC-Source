/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_15ca41a3fbb0e379.gsc
*************************************************/

#using script_1193c0b83fce13b;
#using script_241ff3c86d02a28d;
#using script_2e2e13d44d465832;
#using script_3665d737b10b78d9;
#using script_419eebc6f24e287;
#using script_46b3c7d0a4338d8;
#using script_495022338d50407e;
#using script_6b7618d5ead05b66;
#using script_7fba4131729fe74d;
#using script_a62705cb078ec0a;
#using script_c00335a7aeb2728;
#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\matchdata;
#namespace namespace_42a724f5ada005f2;

function function_df414d6582eeca3() {
  if(function_a01fb124d8098725()) {
    level thread function_ac84ec73bf840e28();
  }

  scripts\engine\utility::registersharedfunc("<dev string:x1c>", "<dev string:x27>", &function_9533653868e59fb6);
  setdvarifuninitialized(@ "hash_9f23e8d498251b68", 0);

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  while(true) {
    if(getdvarint(@ "hash_9f23e8d498251b68", 0) == 1) {
      setDvar(@ "hash_9f23e8d498251b68", 0);
      function_b2e62802c55b4e06();
    }

    waitframe();
  }
}

function private function_ac84ec73bf840e28() {
  level endon("<dev string:x33>");
  waitframe();

  while(!scripts\mp\flags::gameflagexists("<dev string:x41>")) {
    waitframe();
  }

  scripts\mp\flags::gameflagwait("<dev string:x41>");
  wait 5;
  fileid = openfile("<dev string:x52>" + scripts\mp\matchdata::getmatchstarttimeutc() + "<dev string:x7e>", "<dev string:x86>");
  linenum = 0;

  foreach(stringlist in [function_455766fa035b448b(1), function_72c9cdffd3f822e0(1), function_8db779c9344416cf(), level.var_197dd712f141b8c9]) {
    foreach(string in stringlist) {
      linenum++;
      fprintln(fileid, string);

      if(linenum > 2500) {
        linenum = 0;
        waitframe();
      }
    }
  }

  fileid = closefile(fileid);
  level.var_bfd55e67af595e1e = 1;
  level.var_197dd712f141b8c9 = undefined;
}

function function_9533653868e59fb6(identifier, classname, script_noteworthy, model, targetname, target, poi, origin) {
  if(function_a01fb124d8098725()) {
    if(!isDefined(level.var_197dd712f141b8c9)) {
      level.var_197dd712f141b8c9 = [];
    }

    level.var_197dd712f141b8c9[level.var_197dd712f141b8c9.size] = function_aab2831f2d0f944a(identifier) + function_b1b21a5b869b18da(gettime()) + function_30bf74c984738a04(classname) + function_278982e83dc6ce99(script_noteworthy) + function_1bcd1f2b4cce887e(model) + function_4d7beaffcd9fe273(targetname) + function_d6253982f9352e40(target) + function_3a41ae43e44d1c4b(poi) + origintostring(origin);
  }
}

function private function_a01fb124d8098725() {
  return getdvarint(@ "hash_1a2b4309113c3e63", 0) == 1 && !istrue(level.var_bfd55e67af595e1e);
}

function private function_8db779c9344416cf() {
  strings = [];
  lootcount = getlootspawnpointcount();
  linenum = 0;

  for(i = 0; i < lootcount; i++) {
    loot = getlootspawnpoint(i);

    if(!istrue(loot.game_extrainfo)) {
      continue;
    }

    if(loot.type == 0) {
      strings[strings.size] = "<dev string:x8f>" + origintostring(loot.origin);
    } else if(loot.type == 1) {
      strings[strings.size] = "<dev string:xba>" + origintostring(loot.origin);
    }

    linenum++;

    if(linenum > 2500) {
      linenum = 0;
      waitframe();
    }
  }

  return strings;
}

function private function_b2e62802c55b4e06() {
  fileid = openfile("<dev string:xe6>" + "<dev string:x100>" + scripts\mp\matchdata::getmatchstarttimeutc() + "<dev string:x7e>", "<dev string:x86>");
  funcs = [ &function_455766fa035b448b, &function_72c9cdffd3f822e0, &function_b293bcd46c2e94f3, &function_6094c4cbc86f7349, &function_67c705226d08e320, &function_573e0a776acce440, &function_a81f0b5aab63247d, &function_82123529e3e33752, &function_c76b3a8b1579f6b3, &function_a96ecbceeaded59e, &function_d04d1f2b66d72ca, &function_aa334e5e3d060a5a, &function_9c160c396ef3a059, &function_59b40f693aa4f4f9];
  linenum = 0;

  foreach(func in funcs) {
    foreach(string in [[func]]()) {
      fprintln(fileid, string);
      linenum++;

      if(linenum % 2500 == 0) {
        waitframe();
      }
    }
  }

  fileid = closefile(fileid);
}

function private function_b293bcd46c2e94f3() {
  startpointstrings = [];

  foreach(startpoint in getStructArray("<dev string:x119>", "<dev string:x130>")) {
    startpointstrings[startpointstrings.size] = "<dev string:x145>" + "<dev string:x119>" + "<dev string:x184>" + function_3a41ae43e44d1c4b(startpoint.poi) + origintostring(startpoint.origin);
  }

  for(i = 1; getStructArray("<dev string:x18e>" + i, "<dev string:x130>").size > 0; i++) {
    foreach(startpoint in getStructArray("<dev string:x18e>" + i, "<dev string:x130>")) {
      startpointstrings[startpointstrings.size] = "<dev string:x1b1>" + i + "<dev string:x1cc>" + "<dev string:x119>" + i + "<dev string:x184>" + function_3a41ae43e44d1c4b(startpoint.poi) + origintostring(startpoint.origin);
    }
  }

  return startpointstrings;
}

function private function_6094c4cbc86f7349() {
  var_68bb623616b45317 = [];

  foreach(exfil in getStructArray("<dev string:x1fb>", "<dev string:x130>")) {
    var_68bb623616b45317[var_68bb623616b45317.size] = "<dev string:x212>" + "<dev string:x1fb>" + "<dev string:x184>" + function_3a41ae43e44d1c4b(exfil.poi) + origintostring(exfil.origin);
  }

  for(i = 1; getStructArray("<dev string:x25a>" + i, "<dev string:x130>").size > 0; i++) {
    foreach(exfil in getStructArray("<dev string:x25a>" + i, "<dev string:x130>")) {
      var_68bb623616b45317[var_68bb623616b45317.size] = "<dev string:x274>" + i + "<dev string:x1cc>" + "<dev string:x25a>" + i + "<dev string:x184>" + function_3a41ae43e44d1c4b(exfil.poi) + origintostring(exfil.origin);
    }
  }

  return var_68bb623616b45317;
}

function private function_67c705226d08e320() {
  uavstrings = [];

  foreach(uav in getStructArray("<dev string:x292>", "<dev string:x29f>")) {
    uavstrings[uavstrings.size] = "<dev string:x2ad>" + function_3a41ae43e44d1c4b(uav.poi) + origintostring(uav.origin);
  }

  return uavstrings;
}

function private function_a81f0b5aab63247d() {
  var_3f39b05bdfa514d3 = [];

  foreach(fortress in getStructArray("<dev string:x312>", "<dev string:x29f>")) {
    var_3f39b05bdfa514d3[var_3f39b05bdfa514d3.size] = "<dev string:x31e>" + fortress.script_noteworthy + "<dev string:x360>" + fortress.target + "<dev string:x382>" + origintostring(fortress.origin);
  }

  return var_3f39b05bdfa514d3;
}

function private function_82123529e3e33752() {
  var_604292aa57d017e4 = [];

  foreach(zoneindex in level.var_d295f7b9a28a5a53) {
    zonename = function_aae8b5dc22c12d2c(zoneindex);

    if(issubstr(zonename, "<dev string:x388>")) {
      zonebounds = function_6a9090e74fd4e90a(zoneindex);
      var_604292aa57d017e4[var_604292aa57d017e4.size] = "<dev string:x393>" + zonename + "<dev string:x3cf>" + origintostring(zonebounds.midpoint);
    }
  }

  return var_604292aa57d017e4;
}

function private function_c76b3a8b1579f6b3() {
  var_e396a2efd83e0241 = [];

  foreach(buystation in getStructArray("<dev string:x3db>", "<dev string:x29f>")) {
    var_e396a2efd83e0241[var_e396a2efd83e0241.size] = "<dev string:x3ea>" + function_3a41ae43e44d1c4b(buystation.poi) + origintostring(buystation.origin);
  }

  return var_e396a2efd83e0241;
}

function private function_a96ecbceeaded59e() {
  var_afe74a4a4eb003f8 = [];

  foreach(gasstation in getStructArray("<dev string:x465>", "<dev string:x29f>")) {
    var_afe74a4a4eb003f8[var_afe74a4a4eb003f8.size] = "<dev string:x474>" + function_3a41ae43e44d1c4b(gasstation.poi) + origintostring(gasstation.origin);
  }

  foreach(gasstation in getStructArray("<dev string:x4c3>", "<dev string:x29f>")) {
    var_afe74a4a4eb003f8[var_afe74a4a4eb003f8.size] = "<dev string:x4d9>" + function_3a41ae43e44d1c4b(gasstation.poi) + origintostring(gasstation.origin);
  }

  return var_afe74a4a4eb003f8;
}

function private function_d04d1f2b66d72ca() {
  reinforcestrings = [];

  foreach(node in getStructArray("<dev string:x536>", "<dev string:x130>")) {
    reinforcestrings[reinforcestrings.size] = "<dev string:x545>" + function_4d7beaffcd9fe273(node.targetname) + "<dev string:x382>" + function_3a41ae43e44d1c4b(node.poi) + origintostring(node.origin);
  }

  return reinforcestrings;
}

function private function_aa334e5e3d060a5a() {
  var_8cc7b67b8bd0fefc = [];

  foreach(vehicleref, vehicledata in level.var_a0b2c978ca57ffc5) {
    foreach(spawnstruct in scripts\cp_mp\vehicles\vehicle_spawn::function_b08e7e3a0b14f76f(vehicleref)) {
      vehicletype = spawnstruct.vehicletype;

      if(!isDefined(vehicletype)) {
        vehicletype = vehicleref;
      }

      var_8cc7b67b8bd0fefc[var_8cc7b67b8bd0fefc.size] = "<dev string:x5b4>" + vehicletype + "<dev string:x5c3>" + vehicletype + "<dev string:x382>" + function_1bcd1f2b4cce887e(vehicledata.model) + "<dev string:x184>" + origintostring(spawnstruct.origin);
    }
  }

  return var_8cc7b67b8bd0fefc;
}

function private function_9c160c396ef3a059() {
  struct = spawnStruct();
  struct.strings = [];
  getaiarraystrings(level.firstkillfoddernodes, struct, "<dev string:x5d2>");
  getaiarraystrings(level.looseguardnodes, struct, "<dev string:x5e7>");
  getaiarraystrings(level.var_bfb4ada8beae5881, struct, "<dev string:x5f0>");
  getaiarraystrings(getStructArray("<dev string:x5fb>", "<dev string:x130>"), struct, "<dev string:x614>");

  foreach(path in level.patrolpaths) {
    getaiarraystrings(path.path, struct, "<dev string:x625>");
  }

  return struct.strings;
}

function private getaiarraystrings(array, struct, identifier) {
  foreach(node in array) {
    struct.strings[struct.strings.size] = "<dev string:x5b4>" + identifier + "<dev string:x634>" + function_278982e83dc6ce99(node.script_noteworthy) + "<dev string:x382>" + function_4d7beaffcd9fe273(node.targetname) + function_d6253982f9352e40(node.target) + function_3a41ae43e44d1c4b(node.poi) + origintostring(node.origin);
  }
}

function private function_59b40f693aa4f4f9() {
  strings = [];
  lootcount = getlootspawnpointcount();
  linenum = 0;

  for(i = 0; i < lootcount; i++) {
    loot = getlootspawnpoint(i);

    if(loot.type == 0) {
      strings[strings.size] = "<dev string:x650>" + origintostring(loot.origin);
    } else if(loot.type == 1) {
      strings[strings.size] = "<dev string:x674>" + origintostring(loot.origin);
    }

    linenum++;

    if(linenum > 2500) {
      linenum = 0;
      waitframe();
    }
  }

  return strings;
}

function private function_573e0a776acce440() {
  activitystrings = [];
  activityfuncs = [];
  activityfuncs["<dev string:x699>"] = &namespace_e1bfa87a2a692d3c::function_a07f7c4c0c4ef8e3;
  activityfuncs["<dev string:x6a0>"] = &namespace_4f4cbea0f5b0bdb8::function_a07f7c4c0c4ef8e3;
  activityfuncs["<dev string:x6aa>"] = &namespace_300f9f7dca7fc109::function_a07f7c4c0c4ef8e3;
  activityfuncs["<dev string:x6b2>"] = &namespace_b11859036e02907d::function_a07f7c4c0c4ef8e3;
  activityfuncs["<dev string:x6ba>"] = &namespace_fa9fd40f68ab8478::function_a07f7c4c0c4ef8e3;
  activityfuncs["<dev string:x6c3>"] = &namespace_b8c00f1eafbbd213::function_a07f7c4c0c4ef8e3;
  activityfuncs["<dev string:x6cb>"] = &namespace_30baceecda213256::function_a07f7c4c0c4ef8e3;
  activityfuncs["<dev string:x6d2>"] = &namespace_232aeaeb467df5bd::function_a07f7c4c0c4ef8e3;
  activityfuncs["<dev string:x6dd>"] = &namespace_38da3c68826ceb02::function_a07f7c4c0c4ef8e3;
  activityfuncs["<dev string:x6e5>"] = &namespace_168c086126cfa488::function_a07f7c4c0c4ef8e3;
  activityfuncs["<dev string:x6f5>"] = &namespace_210d6dd43cfaf195::function_a07f7c4c0c4ef8e3;

  foreach(name, func in activityfuncs) {
    foreach(node in [[func]]()) {
      activitystrings[activitystrings.size] = function_bc14aaa5b9b5cab3(node, name);

      if(activitystrings.size % 2500 == 0) {
        waitframe();
      }
    }
  }

  return activitystrings;
}

function private function_bc14aaa5b9b5cab3(node, name) {
  return "<dev string:x5b4>" + name + "<dev string:x705>" + name + function_278982e83dc6ce99(node.script_noteworthy) + function_1bcd1f2b4cce887e(node.model) + function_4d7beaffcd9fe273(node.targetname) + "<dev string:x382>" + function_3a41ae43e44d1c4b(node.poi) + origintostring(node.origin);
}

function private function_455766fa035b448b(includetime) {
  return ["<dev string:x71d>" + ter_op(istrue(includetime), "<dev string:x734>", "<dev string:x73f>") + "<dev string:x5c3>" + 2 + "<dev string:x743>"];
}

function private function_72c9cdffd3f822e0(includetime) {
  assert(isDefined(level.mapcorners) && isDefined(level.minimapmaterial));
  strings = [];

  foreach(corner in level.mapcorners) {
    strings[strings.size] = "<dev string:x756>" + ter_op(istrue(includetime), "<dev string:x734>", "<dev string:x73f>") + "<dev string:x5c3>" + level.minimapmaterial + "<dev string:x773>" + origintostring(corner.origin);
  }

  return strings;
}

function private function_aab2831f2d0f944a(identifier) {
  if(isDefined(identifier)) {
    return ("<dev string:x5b4>" + identifier);
  }

  return "<dev string:x781>";
}

function private function_b1b21a5b869b18da(timestep) {
  if(isDefined(timestep)) {
    return ("<dev string:x786>" + timestep);
  }

  return "<dev string:x382>";
}

function private function_30bf74c984738a04(classname) {
  if(isDefined(classname)) {
    return ("<dev string:x5c3>" + classname);
  }

  return "<dev string:x382>";
}

function private function_278982e83dc6ce99(script_noteworthy) {
  if(isDefined(script_noteworthy)) {
    return ("<dev string:x790>" + script_noteworthy);
  }

  return "<dev string:x382>";
}

function private function_1bcd1f2b4cce887e(model) {
  if(isDefined(model)) {
    return ("<dev string:x7a7>" + model);
  }

  return "<dev string:x382>";
}

function private function_4d7beaffcd9fe273(targetname) {
  if(isDefined(targetname)) {
    return ("<dev string:x7b2>" + targetname);
  }

  return "<dev string:x382>";
}

function private function_d6253982f9352e40(target) {
  if(isDefined(target)) {
    return ("<dev string:x7c2>" + target);
  }

  return "<dev string:x382>";
}

function private origintostring(origin) {
  assert(isDefined(origin));
  return "<dev string:x7ce>" + origin[0] + "<dev string:x7ce>" + origin[1] + "<dev string:x7ce>" + origin[2];
}

function private function_3a41ae43e44d1c4b(poi) {
  if(isDefined(poi)) {
    return ("<dev string:x7d3>" + poi);
  }

  return "<dev string:x382>";
}

# /