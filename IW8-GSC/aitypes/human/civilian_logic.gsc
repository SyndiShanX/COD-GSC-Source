/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\human\civilian_logic.gsc
***********************************************/

initcivilian(var_0) {
  if(isDefined(self.bt.initiated))
    return anim.success;

  scripts\asm\asm_bb::bb_setcivilianstate("stealth");
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

setstealthstate_neutral(var_0, var_1) {
  if(var_0 != "combat")
    var_0 = "idle";

  return scripts\aitypes\stealth::setstealthstate(var_0, var_1);
}

updateeveryframe_civ_global(var_0) {
  scripts\aitypes\common::updateeveryframe_magicdoorchecks();
  return anim.success;
}

updateeveryframe_civ_default(var_0) {
  if(scripts\asm\asm_bb::bb_getcivilianstate() == "noncombat") {
    var_1 = scripts\asm\asm::asm_getephemeraleventdata("ai_notify", "bulletwhizby");

    if(isDefined(var_1)) {
      if(!isDefined(self.disablebulletwhizbyreaction)) {
        var_2 = var_1[0];
        var_3 = isDefined(var_2) && distancesquared(self.origin, var_2.origin) < 262144;

        if(var_3 || scripts\engine\utility::cointoss()) {
          scripts\asm\asm_bb::bb_setcivilianstate("combat");
          var_4 = spawnStruct();
          var_4.gametime = gettime() - 50;
          var_4.params = var_1;
          scripts\asm\asm_bb::bb_requestwhizby(var_4);
          return anim.success;
        }
      }
    } else {
      var_5 = 5000;
      var_1 = scripts\asm\asm_bb::bb_getrequestedwhizby();

      if(!isDefined(var_1) || gettime() > var_1.gametime + var_5)
        scripts\asm\asm_bb::bb_requestwhizby(undefined);
    }

    if(!istrue(self.ignoreall)) {
      var_6 = getaiarray("axis");

      foreach(var_8 in var_6) {
        if(distancesquared(var_8.origin, self.origin) < 262144) {
          scripts\asm\asm_bb::bb_setcivilianstate("combat");
          return anim.success;
        }
      }
    }
  }

  if(scripts\asm\asm_bb::bb_getcivilianstate() == "combat" && gettime() - scripts\asm\asm_bb::bb_getcivilianstatetime() >= 10000)
    scripts\asm\asm_bb::bb_setcivilianstate("noncombat");

  return anim.success;
}

isincover(var_0) {
  if(!isDefined(self.node) || self.node.type == "Path" || self.node.type == "Exposed" || scripts\engine\utility::isnodeexposed3d(self.node) || self.node nodeisdisconnected())
    return anim.failure;

  var_1 = 16;

  if(isDefined(self.pathgoalpos)) {
    if(distancesquared(self.pathgoalpos, self.origin) > var_1)
      return anim.failure;
  } else
    var_1 = 225;

  var_2 = undefined;

  if(scripts\engine\utility::actor_is3d())
    var_2 = distancesquared(self.origin, self.node.origin);
  else {
    if(abs(self.origin[2] - self.node.origin[2]) > 80.0)
      return anim.failure;

    var_2 = distance2dsquared(self.origin, self.node.origin);
  }

  if(var_2 > var_1 && !istrue(self.pathpending))
    return anim.failure;

  var_3 = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(var_3) && self.node != var_3 && !istrue(self.pathpending))
    return anim.failure;

  scripts\asm\asm_bb::bb_setcovernode(self.node);
  self.covernode = self.node;
  return anim.running;
}

clearcover(var_0) {
  self.covernode = undefined;
  scripts\asm\asm_bb::bb_setcovernode(undefined);
}