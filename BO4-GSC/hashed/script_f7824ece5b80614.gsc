/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_f7824ece5b80614.gsc
***********************************************/

#namespace namespace_eb06e24d;

get_jumpkits() {
  if(!isDefined(level.var_aadba305)) {
    level.var_aadba305 = isDefined(getscriptbundlelist(#"jumpkits")) ? getscriptbundlelist(#"jumpkits") : array();
  }

  return level.var_aadba305;
}

function_3045dd71() {
  return get_jumpkits().size;
}

function_550c6257(var_ff60755f) {
  jumpkits = get_jumpkits();
  assert(jumpkits.size > 0);
  assert(isDefined(jumpkits[0]));

  if(var_ff60755f < 0 || var_ff60755f >= jumpkits.size || !isDefined(jumpkits[var_ff60755f])) {
    var_ff60755f = 0;
  }

  return getscriptbundle(jumpkits[var_ff60755f]);
}

function_83a2cad4(index) {
  kit = function_550c6257(index);
  return getscriptbundle(kit.parachute);
}

function_aa3a05b1(index) {
  kit = function_550c6257(index);
  return getscriptbundle(kit.wingsuit);
}

function_6452f9c5(index) {
  kit = function_550c6257(index);
  return getscriptbundle(kit.var_4fa85a25);
}

private function_c72eb508() {
  if(isDefined(self.var_9f20891)) {
    return self.var_9f20891;
  }

  count = function_3045dd71();
  seed = self getentitynumber() + (isDefined(level.item_spawn_seed) ? level.item_spawn_seed : 0);
  self.var_9f20891 = function_d59c2d03(count, seed);
  return self.var_9f20891;
}

private function_37ae175b(type) {

  if(getdvarint(#"hash_9003cbb3abd93b7", 0) != 0) {
    count = function_3045dd71();
    return int(max(0, min(count, getdvarint(#"hash_9003cbb3abd93b7", 0) - 1)));
  }

  if(getdvarint(#"hash_6c79f9280f28fabe", 0) != 0) {
    return self function_c72eb508();
  }

    if(isbot(self)) {
      return self function_c72eb508();
    }

  var_5c27e968 = self function_7d5a3c48(currentsessionmode(), type);
  return var_5c27e968;
}

get_parachute() {
  return function_83a2cad4(self function_37ae175b(0));
}

get_parachute_kit() {
  return function_550c6257(self function_37ae175b(0));
}

get_wingsuit() {
  return function_aa3a05b1(self function_37ae175b(2));
}

get_wingsuit_kit() {
  return function_550c6257(self function_37ae175b(2));
}

get_trailfx() {
  return function_6452f9c5(self function_37ae175b(1));
}

function_4a39b434() {
  return function_550c6257(self function_37ae175b(1));
}