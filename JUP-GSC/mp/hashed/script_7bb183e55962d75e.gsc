/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7bb183e55962d75e.gsc
*************************************************/

#using script_405d05c89e998922;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_d3a2045314c6410;

function function_d0bf32b41b280147(asmname, statename, tostatename, params) {
  if(namespace_9e6ef02d993a7eba::is_crawling()) {
    return false;
  }

  return true;
}

function choosestandingdeathanim(asmname, statename, params, bmoving) {
  if(!isDefined(self.damageyaw)) {
    self.damageyaw = 0;
  }

  alias = "left";

  if(self.damageyaw > 135 || self.damageyaw <= -135) {
    alias = "forward";
  } else if(self.damageyaw > 45 && self.damageyaw <= 135) {
    alias = "right";
  } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
    alias = "backward";
  }

  var_59c845b773d9a361 = getdamagetaken();

  if(var_59c845b773d9a361 != "light") {
    alias += "_" + var_59c845b773d9a361;
  }

  deathanim = asm_lookupanimfromalias(statename, alias);
  return deathanim;
}

function playdeathanim(asmname, statename, params) {
  self animmode("gravity");
  self animmode("angle deltas");
  playanim(asmname, statename);
}

function playdeathanim_melee_ragdolldelayed(asmname, statename, params) {
  var_2e6c636f8e86eff0 = isagent(self);

  if(!var_2e6c636f8e86eff0) {
    if(isDefined(self.meleestatename)) {
      time = params;

      if(!isDefined(time)) {
        time = 10;
      }

      asm_donotetrackswithtimeout(asmname, self.meleestatename, time);
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(!var_2e6c636f8e86eff0) {
    self startragdoll();
    wait 0.1;
  }
}

function choosemovingdeathanim(asmname, statename, params) {
  return choosestandingdeathanim(asmname, statename, params, 1);
}

function getdamagetaken() {
  damagetakentype = "light";

  if(isDefined(self.damagemod) && isexplosivedamagemod(self.damagemod)) {
    damagetakentype = "explosive";
  } else {
    ratio = self.damagetaken / self.maxhealth;

    if(ratio > 0.7) {
      damagetakentype = "heavy";
    }
  }

  return damagetakentype;
}