/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_3797b5e38af8666f.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\cap;
#using scripts\asm\shared\utility;
#using scripts\engine\utility;
#namespace base_interaction;

function initcap(asmname, statename, params) {
  if(isai(self)) {
    self animmode("noclip");
    self orientmode("face current");
  } else {
    self.fnasm_handlenotetrack = level._defaultnotetrackhandler;
  }

  if(isDefined(self.scriptedarrivalent)) {
    self.scriptedarrivalent delete();
  }
}

function cap_playturnanim() {}

function cap_chooseturnanim() {}

function function_dc875c74aa7545f4(asmname, statename, params) {
  if(!isDefined(self._blackboard.cowerstate)) {
    self._blackboard.cowerstate = "a";
  }

  if(self._blackboard.cowerstate == "b") {
    return cap_chooseanim(asmname, statename, "a_to_b");
  }

  return cap_chooseanim(asmname, statename, "b_to_a");
}

function function_e9f61f14d08fcd61(asmname, statename, params) {
  return false;
}

function function_92087655510b0e0(asmname, statename, params) {
  return false;
}

function function_6d55fddf9c7024e2(asmname, statename, params) {
  if(isDefined(self.interaction_angles)) {
    self forceteleport(self.origin, self.interaction_angles);
  }

  cap_playanim(asmname, statename, params);
}

function function_56c32e6f7b6ed8ed(asmname, statename, params) {
  self.interaction_angles = undefined;
  cap_exit(asmname, statename, params);
}