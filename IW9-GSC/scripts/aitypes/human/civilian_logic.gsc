/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\human\civilian_logic.gsc
****************************************************/

initcivilian(taskid) {
  if(isDefined(self.bt.initiated))
    return anim.success;

  self.combatmode = "no_cover";
  scripts\asm\asm_bb::bb_civilianrequestspeed(170);
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
  self.fnsetstealthstate = ::setstealthstate_neutral;
  self.bt.initiated = 1;
  return anim.success;
}

setstealthstate_neutral(statename, e) {
  if(statename != "combat")
    statename = "idle";

  return scripts\aitypes\stealth::_id_20BF793DE5175709(statename, e);
}

_id_216B6A27F343C39B(taskid) {
  initcivilian(taskid);
  self _meth_0236BB8DE012BBAE();
  return anim.success;
}

_id_F10A50A61D990568(taskid) {
  state = scripts\asm\asm_bb::bb_getcivilianstate();

  switch (state) {
    case "panic":
      return "InPanic";
    case "wary":
      return "InAlert";
    case "casual":
      return "InIdle";
    default:
      return "InIdle";
  }
}

_id_6E84E4404795D5E9(taskid) {
  iprintlnbold("Terminating Interaction");
}

_id_FA485278009F93A7(taskid) {
  self notify("stop_going_to_node");
  return anim.success;
}