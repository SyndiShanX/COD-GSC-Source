/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\aitypes\human\civilian_logic.gsc
*******************************************************/

#using scripts\aitypes\bt_util;
#using scripts\aitypes\stealth;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\engine\utility;
#namespace civilian_logic;

function initcivilian(taskid) {
  if(isDefined(self.bt.initiated)) {
    return anim.success;
  }

  self function_9f82c74eb1b7caf9(0, "entity");
  bb_civilianrequestspeed(170);
  self.ignoresuppression = 1;
  self.disableplayeradsloscheck = 1;
  self.ignoreplayersuppressionlines = 1;
  self.nextlookforcovertime = 9999999;

  if(!isDefined(self.animplaybackrate) || !isDefined(self.moveplaybackrate)) {
    self.animplaybackrate = 0.97 + randomfloat(0.13);
    self.movetransitionrate = 0.97 + randomfloat(0.13);
    self.moveplaybackrate = self.movetransitionrate;
    self.sidesteprate = 1.35;
  }

  scripts\aitypes\stealth::initstealthfunctions();
  self.fnsetstealthstate = &setstealthstate_neutral;
  self.bt.initiated = 1;
  return anim.success;
}

function setstealthstate_neutral(statename, e) {
  if(statename != "combat") {
    statename = "idle";
  }

  return scripts\aitypes\stealth::function_20bf793de5175709(statename, e);
}

function function_216b6a27f343c39b(taskid) {
  initcivilian(taskid);
  self registerciv();
  return anim.success;
}

function function_f10a50a61d990568(taskid) {
  state = bb_getcivilianstate();

  switch (state) {
    case #"hash_fec408e3f7407354":
      return "InPanic";
    case #"hash_bdb1547441050414":
      return "InAlert";
    case #"hash_46fdaf04e9be63e4":
      return "InIdle";
    default:
      return "InIdle";
  }
}

function interactioncleanup(taskid) {
  iprintlnbold("Terminating Interaction");
}

function function_fa485278009f93a7(taskid) {
  self notify("stop_going_to_node");
  return anim.success;
}