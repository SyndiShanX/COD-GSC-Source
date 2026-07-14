/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_2838bf44b7dbfea.gsc
****************************************************/

#using script_1f139695c61f1549;
#using script_4db4e7f305ce5a21;
#namespace namespace_4c2df310039c1ff0;

function function_2cc420853a7d4592(var_2c51db6714cb3bea) {
  struct = function_e316c00d3be4e20c(namespace_2c51db6714cb3bea::function_a5bcbdda929e1faf(var_2c51db6714cb3bea), namespace_2c51db6714cb3bea::function_cdd4ed29a8cadd5(var_2c51db6714cb3bea), namespace_2c51db6714cb3bea::function_4f9246af08cef149(var_2c51db6714cb3bea), namespace_2c51db6714cb3bea::function_1693943f39824463(var_2c51db6714cb3bea), namespace_2c51db6714cb3bea::function_8c80f69167046124(var_2c51db6714cb3bea), namespace_2c51db6714cb3bea::function_6ec422928b339542(var_2c51db6714cb3bea), namespace_2c51db6714cb3bea::function_8cc696a7ebfd1f54(var_2c51db6714cb3bea));
  return struct;
}

function function_e316c00d3be4e20c(rewardcacheassetname, var_d7c9cbc5cfad0958, perplayerloot, rewardgrouptype, rewardspawnlocationtype, spawnactivationname, spawnactivitymoment) {
  struct = spawnStruct();
  struct.var_277c9aed2c7bff8b = 1;
  struct.rewardcacheassetname = rewardcacheassetname;
  struct.var_d7c9cbc5cfad0958 = var_d7c9cbc5cfad0958;
  struct.perplayerloot = perplayerloot;
  struct.rewardgrouptype = rewardgrouptype;
  struct.rewardspawnlocationtype = rewardspawnlocationtype;
  struct.spawnactivationname = spawnactivationname;
  struct.spawnactivitymoment = spawnactivitymoment;
  return struct;
}

function function_cf6de98c9a0d5a78(var_ddaa3fb303aecb1f) {
  if(isDefined(var_ddaa3fb303aecb1f)) {
    return var_ddaa3fb303aecb1f.rewardcacheassetname;
  }

  return undefined;
}

function function_b6800ae76a33c716(var_ddaa3fb303aecb1f) {
  if(isDefined(var_ddaa3fb303aecb1f)) {
    return var_ddaa3fb303aecb1f.var_d7c9cbc5cfad0958;
  }

  return undefined;
}

function getperplayerloot(var_ddaa3fb303aecb1f) {
  if(isDefined(var_ddaa3fb303aecb1f)) {
    return var_ddaa3fb303aecb1f.perplayerloot;
  }

  return undefined;
}

function getrewardgrouptype(var_ddaa3fb303aecb1f) {
  if(isDefined(var_ddaa3fb303aecb1f)) {
    return var_ddaa3fb303aecb1f.rewardgrouptype;
  }

  return undefined;
}

function function_15ac8069ace3615d(var_ddaa3fb303aecb1f) {
  if(isDefined(var_ddaa3fb303aecb1f)) {
    return var_ddaa3fb303aecb1f.rewardspawnlocationtype;
  }

  return undefined;
}

function function_f615d407f190e6b8(var_ddaa3fb303aecb1f) {
  if(isDefined(var_ddaa3fb303aecb1f)) {
    return var_ddaa3fb303aecb1f.spawnactivationname;
  }

  return undefined;
}

function function_eef250fc9aac4ce(var_ddaa3fb303aecb1f) {
  if(isDefined(var_ddaa3fb303aecb1f)) {
    return var_ddaa3fb303aecb1f.spawnactivitymoment;
  }

  return undefined;
}

function function_6375b543e2a6d47(var_ddaa3fb303aecb1f) {
  rewardcachebundlename = function_cf6de98c9a0d5a78(var_ddaa3fb303aecb1f);

  if(!isDefined(rewardcachebundlename)) {
    return undefined;
  }

  return reward_cache_settings::function_4d826d8eeb27d5c2(rewardcachebundlename);
}

function function_d30573585239b6f5(var_ddaa3fb303aecb1f) {
  var_1b2704dec14cd010 = function_b6800ae76a33c716(var_ddaa3fb303aecb1f);

  if(!isDefined(var_1b2704dec14cd010)) {
    return undefined;
  }

  return namespace_a7ab1233794fcbbb::function_92a544e324964891(var_1b2704dec14cd010);
}