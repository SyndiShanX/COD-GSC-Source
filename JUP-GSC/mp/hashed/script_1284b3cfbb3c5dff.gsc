/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1284b3cfbb3c5dff.gsc
*************************************************/

#using script_14381cefe2740093;
#using script_3e34d236a84cfd96;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_52446ed313e6237d;

function function_c477fdff9390e85c() {
  function_2e4174511b58a5f0();

  if(!function_592efdf139e81f74()) {
    return;
  }

  if(isDefined(level.var_34378a90a5412533)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  level.var_34378a90a5412533 = spawnStruct();
  level.var_34378a90a5412533.limits = function_449be28dc3149e33();
  level.var_34378a90a5412533.totallimits = [];
  level.var_34378a90a5412533.counts = undefined;
  level.var_34378a90a5412533.totalcounts = function_7c6efe951a18dfc8();
  level.var_34378a90a5412533.entities = [];
  level.var_34378a90a5412533.scriptables = [];
  level.var_34378a90a5412533.vehicles = [];
  level.var_aeae08211b84be70 = &function_27d3cfc3416beaa;
  level.var_21b79ec3ff697b98 = &function_16d899c3f197127e;
  level.obspawnvehicle = &function_e0d97f24ef3e433f;
  function_fba48b7cfdbc592();
}

function function_f9eefc763d0de614() {
  return ["entities", "scriptables", "vehicles"];
}

function function_592efdf139e81f74() {
  return getdvarint(@ "hash_cdb4e7b9dc1375dd", 1) != 0;
}

function private function_7c6efe951a18dfc8() {
  resourcetypes = function_f9eefc763d0de614();
  typescontainer = [];

  foreach(resource in resourcetypes) {
    typescontainer[resource] = 0;
  }

  return typescontainer;
}

function private function_27d3cfc3416beaa() {}

function private function_16d899c3f197127e() {}

function private function_e0d97f24ef3e433f() {}

function private function_fba48b7cfdbc592() {
  assert(!isDefined(level.var_34378a90a5412533.counts));
  classes = function_6a64df48ad4ce4f9();

  foreach(class in classes) {
    level.var_34378a90a5412533.counts[class] = function_7c6efe951a18dfc8();
  }

  assert(level.var_34378a90a5412533.totallimits.size == 0);
  level.var_34378a90a5412533.totallimits["entities"] = int(max(getdvarint(@ "hash_4dc99f3054df38f1", 800), 0));
  level.var_34378a90a5412533.totallimits["scriptables"] = int(max(getdvarint(@ "hash_5d026b677a8c5410", 200), 0));
  level.var_34378a90a5412533.totallimits["vehicles"] = int(max(getdvarint(@ "hash_8145cf83bbc69bd7", 60), 0));
}

function private function_d87d61d06422bce4(resourcetype, activityclass, activitytype, activityname, amount) {
  if(!isDefined(amount) || amount <= 0) {
    return true;
  }

  currentresources = level.var_34378a90a5412533.totalcounts[resourcetype];
  resourcelimit = level.var_34378a90a5412533.totallimits[resourcetype];
  return currentresources + amount <= resourcelimit;
}

function function_756b62f54a8121ff(activityclass, activitytype, activityname, resourcebundle) {
  if(!isDefined(resourcebundle)) {
    return true;
  }

  classlimits = level.var_34378a90a5412533.limits[activityclass];

  if(isDefined(classlimits)) {}

  if(!function_d87d61d06422bce4("entities", activityclass, activitytype, activityname, resourcebundle.var_7c8b5f741410fc9b)) {
    return false;
  }

  if(!function_d87d61d06422bce4("scriptables", activityclass, activitytype, activityname, resourcebundle.var_c113b50ec587c0e4)) {
    return false;
  }

  if(!function_d87d61d06422bce4("vehicles", activityclass, activitytype, activityname, resourcebundle.var_bb34e9fd0b25ca19)) {
    return false;
  }

  return true;
}

function private function_e17c6b6b1aef59a9(resourcetype, activityclass, activitytype, activityname, amount) {
  if(!isDefined(amount) || amount <= 0) {
    return;
  }

  level.var_34378a90a5412533.counts[activityclass][resourcetype] += amount;
  level.var_34378a90a5412533.totalcounts[resourcetype] += amount;
}

function private function_8f2ecf87251b657b(resourcetype, activityclass, activitytype, activityname, amount) {
  if(!isDefined(amount) || amount <= 0) {
    return;
  }

  level.var_34378a90a5412533.counts[activityclass][resourcetype] -= amount;
  level.var_34378a90a5412533.totalcounts[resourcetype] -= amount;
  assert(level.var_34378a90a5412533.counts[activityclass][resourcetype] >= 0);
  assert(level.var_34378a90a5412533.totalcounts[resourcetype] >= 0);
}

function function_cf5c19fe5c042e90(activityclass, activitytype, activityname, resourcebundle) {
  if(!isDefined(resourcebundle)) {
    return;
  }

  function_8f2ecf87251b657b("entities", activityclass, activitytype, activityname, resourcebundle.var_7c8b5f741410fc9b);
  function_8f2ecf87251b657b("scriptables", activityclass, activitytype, activityname, resourcebundle.var_c113b50ec587c0e4);
  function_8f2ecf87251b657b("vehicles", activityclass, activitytype, activityname, resourcebundle.var_bb34e9fd0b25ca19);
}

function function_1f896f1cc450fd5f(activityclass, activitytype, activityname, resourcebundle) {
  if(!isDefined(resourcebundle)) {
    return;
  }

  function_e17c6b6b1aef59a9("entities", activityclass, activitytype, activityname, resourcebundle.var_7c8b5f741410fc9b);
  function_e17c6b6b1aef59a9("scriptables", activityclass, activitytype, activityname, resourcebundle.var_c113b50ec587c0e4);
  function_e17c6b6b1aef59a9("vehicles", activityclass, activitytype, activityname, resourcebundle.var_bb34e9fd0b25ca19);
}