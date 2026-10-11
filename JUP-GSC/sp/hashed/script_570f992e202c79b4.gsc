/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_570f992e202c79b4.gsc
*************************************************/

#using scripts\common\linked_list;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_3e8924d2d52a5e37;

function function_63555ee8e5fb64fc(cachesize) {
  assertex(cachesize > 0, "The LRU cache size must be greater than zero");
  var_f9c88d9020c8956c = spawnStruct();
  var_f9c88d9020c8956c.cachesize = cachesize;
  var_f9c88d9020c8956c.var_f4087a1ca01febee = createstruct_linkedlist();
  var_f9c88d9020c8956c.datamap = [];
  var_f9c88d9020c8956c.var_6331b84385d676bc = 1;
  return var_f9c88d9020c8956c;
}

function function_6331b84385d676bc(var_c41e3f9d7499501f) {
  return isstruct(var_c41e3f9d7499501f) && var_c41e3f9d7499501f.var_6331b84385d676bc == 1;
}

function addtocache(datakey, datacontents) {
  assertex(function_6331b84385d676bc(self), "This function requires that 'self' is a LRU struct as defined in 'lru_cache.gsc'");
  var_f9c88d9020c8956c = self;

  if(isDefined(var_f9c88d9020c8956c.datamap[datakey])) {
    linkedlistnode = var_f9c88d9020c8956c.datamap[datakey];
    var_f9c88d9020c8956c.var_f4087a1ca01febee movenodetostart(linkedlistnode);
    return;
  }

  linkedlistnode = function_11a80ea7fe6ea9e0();
  linkedlistnode.contents = datacontents;
  linkedlistnode.datakey = datakey;
  var_f9c88d9020c8956c.datamap[datakey] = linkedlistnode;
  var_f9c88d9020c8956c.var_f4087a1ca01febee addnode(linkedlistnode, 1);

  if(var_f9c88d9020c8956c function_63fe00fb459ea917()) {
    function_cb7caa09a0749df4("<dev string:x1c>" + datakey + "<dev string:x49>");
  }

  if(var_f9c88d9020c8956c.var_f4087a1ca01febee getsize() > var_f9c88d9020c8956c.cachesize) {
    var_3c81bd8cfe859fc3 = var_f9c88d9020c8956c.var_f4087a1ca01febee getendnode();
    var_f9c88d9020c8956c removefromcache(var_3c81bd8cfe859fc3.datakey);

    if(var_f9c88d9020c8956c function_63fe00fb459ea917()) {
      function_cb7caa09a0749df4("<dev string:x4b>" + var_f9c88d9020c8956c.cachesize + "<dev string:x75>" + datakey + "<dev string:x9d>" + var_3c81bd8cfe859fc3.datakey + "<dev string:xca>");
    }
  }
}

function removefromcache(datakey) {
  assertex(function_6331b84385d676bc(self), "This function requires that 'self' is a LRU struct as defined in 'lru_cache.gsc'");
  var_f9c88d9020c8956c = self;

  if(isDefined(var_f9c88d9020c8956c.datamap[datakey])) {
    linkedlistnode = var_f9c88d9020c8956c.datamap[datakey];
    var_f9c88d9020c8956c.var_f4087a1ca01febee removenode(linkedlistnode);
    linkedlistnode.contents = undefined;
    var_f9c88d9020c8956c.datamap[datakey] = undefined;
  }
}

function function_c908ab3353601192(datakey) {
  assertex(function_6331b84385d676bc(self), "This function requires that 'self' is a LRU struct as defined in 'lru_cache.gsc'");
  var_f9c88d9020c8956c = self;

  if(isDefined(var_f9c88d9020c8956c.datamap[datakey])) {
    linkedlistnode = var_f9c88d9020c8956c.datamap[datakey];
    var_f9c88d9020c8956c.var_f4087a1ca01febee movenodetostart(linkedlistnode);
    return linkedlistnode.contents;
  }

  return undefined;
}

function function_b070450a1a879374() {}

function function_7f5414a2ec3af004() {
  var_e7bd49da3939ba59 = function_63555ee8e5fb64fc();
  var_e7bd49da3939ba59 function_e72dd453d0c738eb();
  return var_e7bd49da3939ba59;
}

function function_e72dd453d0c738eb(var_f6db2dc3ab7b9a12) {
  assertex(function_6331b84385d676bc(self), "<dev string:xdb>");
  var_e7bd49da3939ba59 = self;
  var_e7bd49da3939ba59.var_1a19bd75a8860186 = 1;

  if(istrue(var_f6db2dc3ab7b9a12)) {
    var_e7bd49da3939ba59.var_f4087a1ca01febee function_3a28dcc9cc1b6ae3(&function_b96df1db6657354e);
  }
}

function private function_63fe00fb459ea917() {
  assertex(function_6331b84385d676bc(self), "<dev string:x12c>");
  var_f9c88d9020c8956c = self;
  return istrue(var_f9c88d9020c8956c.var_1a19bd75a8860186);
}

function private function_b96df1db6657354e(nodereference) {
  function_cb7caa09a0749df4("<dev string:x187>" + nodereference.datakey);
}

function private function_c3b303ae9042d994() {
  return "<dev string:x192>";
}

function private function_cb7caa09a0749df4(var_f0443bfaa4783689) {
  iprintln(function_c3b303ae9042d994() + var_f0443bfaa4783689);
}

# /