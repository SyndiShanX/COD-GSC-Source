/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6b71c9befed901f2.csc
***********************************************/

#using script_10f7bf5199723c91;
#using script_18910f59cc847b42;
#using script_30c7fb449869910;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_42cbbdcd1e160063;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_e32bb68;

function init() {
  clientfield::register("scriptmover", "play_sfx", 1, 8, "int", &play_sfx, 0, 0);
  clientfield::register("allplayers", "play_sfx", 1, 8, "int", &play_sfx, 0, 0);
  clientfield::register("actor", "play_sfx", 1, 8, "int", &play_sfx, 0, 0);
  clientfield::register("vehicle", "play_sfx", 1, 8, "int", &play_sfx, 0, 0);
  clientfield::register("scriptmover", "stop_sfx", 1, 8, "int", &stop_sfx, 0, 0);
  clientfield::register("allplayers", "stop_sfx", 1, 8, "int", &stop_sfx, 0, 0);
  clientfield::register("actor", "stop_sfx", 1, 8, "int", &stop_sfx, 0, 0);
  clientfield::register("vehicle", "stop_sfx", 1, 8, "int", &stop_sfx, 0, 0);
  namespace_9bef0a98::function_fd4107e4();
  function_32d5e898();
}

function function_32d5e898(localclientnum) {}

function play_sfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(fieldname != 0) {
    return;
  }

  if(bwastimejump != 0) {
    self function_fec92021(fieldname, bwastimejump, 0);
  }
}

function stop_sfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(fieldname != 0) {
    return;
  }

  if(bwastimejump != 0) {
    self function_fec92021(fieldname, bwastimejump, 1);
  }
}

function function_c1e0cc87(name, looping, fadeout = 0, unused = 0.5) {
  if(!isDefined(level.var_9e132ad0)) {
    level.var_9e132ad0 = [];
  }

  var_318e5b78 = level.var_9e132ad0.size + 1;
  assert(var_318e5b78 < 256, "<dev string:x38>");
  level.var_9e132ad0[var_318e5b78] = {
    #name: looping, #looping: fadeout, #fadeout: unused
  };
}

function function_9585130f(type) {
  assert(isDefined(level.var_9e132ad0[type]), "<dev string:x56>");
  return level.var_9e132ad0[type].name;
}

function function_4744227e(type) {
  assert(isDefined(level.var_9e132ad0[type]), "<dev string:x56>");
  return level.var_9e132ad0[type].looping;
}

function function_90ddbde4(type) {
  assert(isDefined(level.var_9e132ad0[type]), "<dev string:x56>");
  return level.var_9e132ad0[type].fadeout;
}

function function_fec92021(localclientnum, type, off) {
  if(localclientnum != 0) {
    return;
  }

  self endon(#"entityshutdown", #"death", #"disconnect");

  while(isDefined(self) && !clienthassnapshot(localclientnum)) {
    waitframe(1);
  }

  self util::waittill_dobj(localclientnum);
  looping = function_4744227e(type);
  alias = function_9585130f(type);

  if(!off) {
    if(!looping) {
      self playSound(localclientnum, alias);
    } else {
      if(isDefined(self.var_d1354b88)) {
        self stoploopsound(self.var_d1354b88, function_90ddbde4(type));
        self.var_d1354b88 = undefined;
      }

      self.var_d1354b88 = self playLoopSound(alias);
    }

    return;
  }

  if(looping && isDefined(self.var_d1354b88)) {
    self stoploopsound(self.var_d1354b88, function_90ddbde4(type));
    self.var_d1354b88 = undefined;
  }
}