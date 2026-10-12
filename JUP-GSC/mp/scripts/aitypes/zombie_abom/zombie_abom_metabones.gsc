/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\zombie_abom\zombie_abom_metabones.gsc
*****************************************************************/

#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\engine\utility;
#namespace zombie_abom_metabones;

function autoexec main() {
  var_601bcee5d276f46d = "zombie_abom";
  function_d6736c5ef5ac2990(var_601bcee5d276f46d, &function_b9f4b7206d76e7ce);
  level.var_586f05706c6d0cab = [];
  level.var_586f05706c6d0cab["head_le"] = 0;
  level.var_586f05706c6d0cab["head_mid"] = 1;
  level.var_586f05706c6d0cab["head_ri"] = 2;
  level.var_28e4ea2998e3439b = [];
  level.var_28e4ea2998e3439b[0] = "head_le";
  level.var_28e4ea2998e3439b[1] = "head_mid";
  level.var_28e4ea2998e3439b[2] = "head_ri";
}

function private function_b9f4b7206d76e7ce(params) {
  function_ebb83c1efeaae2c7(params.metabone_name);
}

function private function_ebb83c1efeaae2c7(metabone_name) {
  if(self getscriptablehaspart(metabone_name)) {
    self setscriptablepartstate(metabone_name, "destroyed");
    function_3d2728c0e2252a1d(metabone_name, "destroyed");
    function_7380ccd6f2c49392(metabone_name, 1);
    function_ac90fa5cc0a80298("head_destroyed_in");
    self notify("head_destroyed_" + level.var_586f05706c6d0cab[metabone_name]);
    heads_remaining = function_2789dbcb483fa601(self);
    params = spawnStruct();
    params.metabone_name = metabone_name;
    params.heads_remaining = heads_remaining;
    callback::callback("head_destroyed", params);

    if(heads_remaining.size == 2) {
      foreach(head_name in heads_remaining) {
        function_3d2875316eed616d(head_name, self.maxhealth * 0.15, "open");
      }
    } else if(heads_remaining.size == 1) {
      foreach(head_name in heads_remaining) {
        function_5f2c6624e43cd8e(head_name, self.health, "open");
      }
    } else {
      self.killondamage = 1;
    }

    return;
  }

  assertmsg("<dev string:x1c>" + metabone_name);
}

function function_2789dbcb483fa601(entity) {
  heads_alive = [];

  for(head_index = 0; head_index <= 2; head_index++) {
    if(function_b2fae60b8f9f98b2(entity, head_index)) {
      metabone = level.var_28e4ea2998e3439b[head_index];
      heads_alive = array_add(heads_alive, metabone);
    }
  }

  return heads_alive;
}

function function_68d5f1122bc3fa26(entity) {
  heads_alive = [];

  for(head_index = 0; head_index <= 2; head_index++) {
    if(function_b2fae60b8f9f98b2(entity, head_index)) {
      heads_alive = array_add(heads_alive, head_index);
    }
  }

  return heads_alive;
}

function function_b2fae60b8f9f98b2(entity, head_index) {
  assertex(head_index >= 0 && head_index <= 2, "<dev string:x4a>");
  metabone = level.var_28e4ea2998e3439b[head_index];
  return entity function_8ddba5bfa85f8cc9(metabone) != "destroyed";
}

function function_da059a185d59d999(entity, head_index, is_open) {
  assertex(head_index >= 0 && head_index <= 2, "<dev string:x4a>");
  metabone_state = ter_op(istrue(is_open), "open", "closed");

  if(!function_b2fae60b8f9f98b2(entity, head_index)) {
    metabone_state = "destroyed";
  }

  entity function_3d2728c0e2252a1d(level.var_28e4ea2998e3439b[head_index], metabone_state);
}

function function_e5db29e6fd6f6a88(metabone_name) {
  if(self getscriptablehaspart(metabone_name)) {
    return level.var_586f05706c6d0cab[metabone_name];
  }

  return undefined;
}