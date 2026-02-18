/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\item_world_fixup.csc
***********************************************/

#using scripts\core_common\flag_shared;
#namespace item_world_fixup;

function autoexec __init__() {
  level.itemreplacement = [];
  level.var_ee110db8 = [];
  level.var_93c59949 = [];
  level.var_1d777960 = [];
  level.var_bf9b06d3 = [];
  level.var_8d50adaa = [];
}

function private function_59c1a869(&replacementarray, var_d1c21f6f, var_b06dd57e) {
  if(!ishash(var_d1c21f6f) || !ishash(var_b06dd57e)) {
    assert(0);
    return;
  }

  assert(!isDefined(replacementarray[var_d1c21f6f]));

  if(isDefined(replacementarray[var_d1c21f6f])) {
    return;
  }

  function_d50342ad(var_b06dd57e);

  replacementarray[var_d1c21f6f] = var_b06dd57e;
}

function private function_41015db1(&replacementarray, itemname, replacementitemname) {
  if(!ishash(itemname) || !ishash(replacementitemname)) {
    assert(0);
    return;
  }

  assert(!isDefined(replacementarray[itemname]));

  if(isDefined(replacementarray[itemname])) {
    return;
  }

  if(replacementitemname == # "") {
    replacementitemname = "";
  }

  function_cd5f2152(replacementitemname);

  replacementarray[itemname] = replacementitemname;
}

function private function_bbc0b67f() {
  flag = # "hash_67b445a4b1d59922";

  if(level flag::get(flag)) {
    assert(0, "<dev string:x38>");
    return false;
  }

  return true;
}

function private function_cd5f2152(itemname) {
  if(itemname == "<dev string:x82>") {
    return;
  }
}

function private function_d50342ad(var_d1c21f6f) {
  if(var_d1c21f6f == "<dev string:x82>") {
    return;
  }
}

function function_6991057(var_d1c21f6f, var_b06dd57e) {
  function_59c1a869(level.var_ee110db8, var_d1c21f6f, var_b06dd57e);
}

function add_item_replacement(itemname, replacementitemname) {
  function_41015db1(level.itemreplacement, itemname, replacementitemname);
}

function add_spawn_point(origin, targetname, angles = (0, 0, 0)) {
  if(!isvec(origin) || !isvec(angles) || !ishash(targetname)) {
    assert(0);
    return;
  }

  if(!isDefined(level.var_1d777960[targetname])) {
    level.var_1d777960[targetname] = array();
  }

  foreach(var_1d777960 in level.var_1d777960) {
    foreach(spawnpoint in var_1d777960) {
      if(spawnpoint.origin == origin) {
        return;
      }
    }
  }

  var_3cc38ddd = level.var_1d777960[targetname].size;
  level.var_1d777960[targetname][var_3cc38ddd] = {
    #origin: origin, #angles: angles
  };
}

function function_e70fa91c(var_cf456610, var_2ab9d3bd, var_6647c284 = -1) {
  if(!ishash(var_cf456610) || !ishash(var_2ab9d3bd) || !isint(var_6647c284)) {
    assert(0);
    return;
  }

  if(!isDefined(level.var_93c59949[var_cf456610])) {
    level.var_93c59949[var_cf456610] = [];
  }

  replacementcount = level.var_93c59949[var_cf456610].size;
  level.var_93c59949[var_cf456610][replacementcount] = {
    #replacement: var_2ab9d3bd, #count: var_6647c284
  };
}

function function_2749fcc3(var_89b7987e, var_cf456610, var_2ab9d3bd, var_6647c284 = 1) {
  if(!ishash(var_cf456610) || !ishash(var_2ab9d3bd) || !isint(var_6647c284)) {
    assert(0);
    return;
  }

  if(!isDefined(level.var_93c59949[var_cf456610])) {
    level.var_93c59949[var_cf456610] = [];
  }

  replacementcount = level.var_93c59949[var_cf456610].size;
  level.var_93c59949[var_cf456610][replacementcount] = {
    #replacement: var_2ab9d3bd, #count: var_6647c284, #var_52a66db0: var_89b7987e
  };
}

function remove_item(itemname) {
  if(!ishash(itemname)) {
    assert(0);
    return;
  }

  level.itemreplacement[itemname] = "";
}

function function_a997e342(origin, radius) {
  if(!isvec(origin) || !isfloat(radius) && !isint(radius)) {
    assert(0);
    return;
  }

  level.var_bf9b06d3[level.var_bf9b06d3.size] = origin;
  level.var_8d50adaa[level.var_8d50adaa.size] = radius;
  assert(level.var_bf9b06d3.size == level.var_8d50adaa.size);
}