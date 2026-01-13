/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2572.gsc
************************/

func_10020(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("grenade response", "return throw", 0)) {
    return level.success;
  }

  return level.failure;
}

func_85D3(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("grenade response", "return throw complete")) {
    return level.success;
  }

  scripts\asm\asm_bb::func_2964(1);
  return level.running;
}

func_85D4(var_0) {
  scripts\asm\asm_bb::func_2964(undefined);
}

func_1001E(var_0) {
  if(scripts\asm\asm::asm_ephemeraleventfired("grenade response", "avoid", 0)) {
    return level.success;
  }

  return level.failure;
}

spectateclientnum(var_0) {
  var_1 = spawnStruct();
  var_1.var_6393 = gettime() + 10000;
  var_1.var_4767 = 0;
  self.bt.instancedata[var_0] = var_1;
  scripts\asm\asm_bb::func_2963(1);
  lib_0A0A::func_41A3(var_0);
}

_meth_85B1(var_0) {
  self.bt.instancedata[var_0] = undefined;
  scripts\asm\asm_bb::func_2963(undefined);
}

isspectatingplayer(var_0) {
  var_1 = self.bt.instancedata[var_0];
  var_2 = gettime();
  if(!isDefined(var_1._meth_85BA) && !isDefined(self.objective_position)) {
    var_1._meth_85BA = var_2;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("grenade dive", "end")) {
    return level.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("grenade cower", "end")) {
    var_1.var_4767 = 1;
    if(isDefined(var_1._meth_85BA)) {
      var_1.var_6393 = var_2;
    } else {
      var_3 = 3000;
      var_1.var_6393 = var_2 + var_3;
    }
  }

  if(var_1.var_4767) {
    if(isDefined(var_1._meth_85BA) && var_2 - var_1._meth_85BA > 500) {
      return level.success;
    }
  } else if(!isDefined(self.objective_position)) {
    return level.success;
  }

  if(var_2 > var_1.var_6393) {
    return level.success;
  }

  return level.running;
}