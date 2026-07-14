/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_570f992e202c79b4.gsc
*****************************************************/

#using scripts\common\linked_list;
#namespace namespace_98284635f20f4696;

function function_76d178aa5df68fe1(cachesize) {
  assert(cachesize > 0, "<dev string:x24>");
  var_9cda955a08d9334d = spawnStruct();
  var_9cda955a08d9334d.cachesize = cachesize;
  var_9cda955a08d9334d.var_88f85ce2b4a3250f = linked_list::createstruct_linkedlist();
  var_9cda955a08d9334d.datamap = [];
  var_9cda955a08d9334d.var_7678529cb8cbb819 = 1;
  return var_9cda955a08d9334d;
}

function function_7678529cb8cbb819(var_d936cdb85511724e) {
  return isstruct(var_d936cdb85511724e) && var_d936cdb85511724e.var_7678529cb8cbb819 == 1;
}

function addtocache(datakey, datacontents) {
  assert(function_7678529cb8cbb819(self), "<dev string:x54>");
  var_9cda955a08d9334d = self;

  if(isDefined(var_9cda955a08d9334d.datamap[datakey])) {
    linkedlistnode = var_9cda955a08d9334d.datamap[datakey];
    var_9cda955a08d9334d.var_88f85ce2b4a3250f linked_list::movenodetostart(linkedlistnode);
    return;
  }

  linkedlistnode = linked_list::function_affc95f8fa292c7d();
  linkedlistnode.contents = datacontents;
  linkedlistnode.datakey = datakey;
  var_9cda955a08d9334d.datamap[datakey] = linkedlistnode;
  var_9cda955a08d9334d.var_88f85ce2b4a3250f linked_list::addnodestart(linkedlistnode);

  if(var_9cda955a08d9334d function_2e36719cdd13d41e()) {
    function_10c8809480d2e2fd("<dev string:xa8>" + datakey + "<dev string:xd8>");
  }

  if(var_9cda955a08d9334d.var_88f85ce2b4a3250f linked_list::getsize() > var_9cda955a08d9334d.cachesize) {
    var_a48922aecd908256 = var_9cda955a08d9334d.var_88f85ce2b4a3250f linked_list::getendnode();
    var_9cda955a08d9334d removefromcache(var_a48922aecd908256.datakey);

    if(var_9cda955a08d9334d function_2e36719cdd13d41e()) {
      function_10c8809480d2e2fd("<dev string:xdd>" + var_9cda955a08d9334d.cachesize + "<dev string:x10a>" + datakey + "<dev string:x135>" + var_a48922aecd908256.datakey + "<dev string:x165>");
    }
  }
}

function removefromcache(datakey) {
  assert(function_7678529cb8cbb819(self), "<dev string:x54>");
  var_9cda955a08d9334d = self;

  if(isDefined(var_9cda955a08d9334d.datamap[datakey])) {
    linkedlistnode = var_9cda955a08d9334d.datamap[datakey];
    var_9cda955a08d9334d.var_88f85ce2b4a3250f linked_list::removenode(linkedlistnode);
    linkedlistnode.contents = undefined;
    var_9cda955a08d9334d.datamap[datakey] = undefined;
  }
}

function function_35359b4155f1691b(datakey) {
  assert(function_7678529cb8cbb819(self), "<dev string:x54>");
  var_9cda955a08d9334d = self;

  if(isDefined(var_9cda955a08d9334d.datamap[datakey])) {
    linkedlistnode = var_9cda955a08d9334d.datamap[datakey];
    var_9cda955a08d9334d.var_88f85ce2b4a3250f linked_list::movenodetostart(linkedlistnode);
    return linkedlistnode.contents;
  }

  return undefined;
}

function function_1e14cf555ba6a311() {}

function function_115362d36df4ee15() {
  var_d87409da67674990 = function_76d178aa5df68fe1();
  var_d87409da67674990 function_1f798724203dd26();
  return var_d87409da67674990;
}

function function_1f798724203dd26(var_963975997d4e2ed3) {
  assert(function_7678529cb8cbb819(self), "<dev string:x54>");
  var_d87409da67674990 = self;
  var_d87409da67674990.var_e9ae8d5dbc1130cf = 1;

  if(istrue(var_963975997d4e2ed3)) {
    var_d87409da67674990.var_88f85ce2b4a3250f linked_list::function_2216cbc4f0cb048e(&function_aaf2e07bb1922eb3);
  }
}

function private function_2e36719cdd13d41e() {
  assert(function_7678529cb8cbb819(self), "<dev string:x179>");
  var_9cda955a08d9334d = self;
  return istrue(var_9cda955a08d9334d.var_e9ae8d5dbc1130cf);
}

function private function_aaf2e07bb1922eb3(nodereference) {
  function_10c8809480d2e2fd("<dev string:x1d7>" + nodereference.datakey);
}

function private function_3bc04d1a0bff9c25() {
  return "<dev string:x1e5>";
}

function private function_10c8809480d2e2fd(var_ac242bc2ecfd3790) {
  iprintln(function_3bc04d1a0bff9c25() + var_ac242bc2ecfd3790);
}

# /