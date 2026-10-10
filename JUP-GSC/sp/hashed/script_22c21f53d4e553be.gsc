/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_22c21f53d4e553be.gsc
*************************************************/

#using script_22c21f53d4e553be;
#using scripts\asm\asm_bb;
#using scripts\asm\cap;
#using scripts\common\cap;
#namespace namespace_1e1677c627b86ef;

function function_5451dca3c782adc7(asmname, statename, params) {
  if(!isDefined(params)) {
    if(isDefined(self.var_2b7fd37b90be5d3)) {
      result = scripts\asm\cap::function_18e6c36c02a94dbd(statename, self.var_2b7fd37b90be5d3);

      if(isDefined(result)) {
        self.var_2b7fd37b90be5d3 = undefined;
        return result;
      }
    }

    randomalias = scripts\asm\cap::function_976d6ccb0a2807f3(statename);

    if(isDefined(randomalias)) {
      return scripts\asm\cap::function_18e6c36c02a94dbd(statename, randomalias);
    }
  }

  result = undefined;

  if(isDefined(self.var_2b7fd37b90be5d3)) {
    alias = self.var_2b7fd37b90be5d3 + "_" + params;
    result = scripts\asm\cap::function_18e6c36c02a94dbd(statename, alias);

    if(isDefined(result)) {
      if(params == "end") {
        self.var_2b7fd37b90be5d3 = undefined;
      }

      return result;
    }
  }

  prefixstr = scripts\asm\asm_bb::bb_getprefixstring(params);

  if(isDefined(prefixstr)) {
    randomalias = scripts\asm\cap::function_976d6ccb0a2807f3(statename, prefixstr);
    result = scripts\asm\cap::function_18e6c36c02a94dbd(statename, randomalias);
  } else {
    result = scripts\asm\cap::function_18e6c36c02a94dbd(statename, params);
  }

  return result;
}

function function_e21cd33efed8c6b9(asm, arc, override) {
  thread function_d6a959e322512d83(asm, arc, override);
}

function function_d6a959e322512d83(asm, arc, override) {
  self endon("death");
  wait 0.05;
  namespace_5bbfce4b2ded6c4c::function_8eff1baf0c6bbad6(override);
  scripts\common\cap::cap_start(asm, arc);
}

function function_8eff1baf0c6bbad6(alias) {
  self.var_2b7fd37b90be5d3 = alias;
}

function function_c474c81abbc98247() {}