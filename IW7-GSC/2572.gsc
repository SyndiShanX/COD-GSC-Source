/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 2572.gsc
************************/

func_10020(param_00) {
  if(scripts\asm\asm::asm_ephemeraleventfired("grenade response", "return throw", 0)) {
    return level.success;
  }

  return level.failure;
}

func_85D3(param_00) {
  if(scripts\asm\asm::asm_ephemeraleventfired("grenade response", "return throw complete")) {
    return level.success;
  }

  scripts\asm\asm_bb::func_2964(1);
  return level.running;
}

func_85D4(param_00) {
  scripts\asm\asm_bb::func_2964(undefined);
}

func_1001E(param_00) {
  if(scripts\asm\asm::asm_ephemeraleventfired("grenade response", "avoid", 0)) {
    return level.success;
  }

  return level.failure;
}

spectateclientnum(param_00) {
  var_01 = spawnStruct();
  var_01.var_6393 = gettime() + 10000;
  var_01.var_4767 = 0;
  self.var_3135.instancedata[param_00] = var_01;
  scripts\asm\asm_bb::func_2963(1);
  lib_0A0A::func_41A3(param_00);
}

_meth_85B1(param_00) {
  self.var_3135.instancedata[param_00] = undefined;
  scripts\asm\asm_bb::func_2963(undefined);
}

isspectatingplayer(param_00) {
  var_01 = self.var_3135.instancedata[param_00];
  var_02 = gettime();
  if(!isDefined(var_01._meth_85BA) && !isDefined(self.objective_position)) {
    var_01._meth_85BA = var_02;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("grenade dive", "end")) {
    return level.success;
  }

  if(scripts\asm\asm::asm_ephemeraleventfired("grenade cower", "end")) {
    var_01.var_4767 = 1;
    if(isDefined(var_01._meth_85BA)) {
      var_01.var_6393 = var_02;
    } else {
      var_03 = 3000;
      var_01.var_6393 = var_02 + var_03;
    }
  }

  if(var_01.var_4767) {
    if(isDefined(var_01._meth_85BA) && var_02 - var_01._meth_85BA > 500) {
      return level.success;
    }
  } else if(!isDefined(self.objective_position)) {
    return level.success;
  }

  if(var_02 > var_01.var_6393) {
    return level.success;
  }

  return level.running;
}