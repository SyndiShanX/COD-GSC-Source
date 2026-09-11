/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\human\civilian_logic.gsc
****************************************************/

function initcivilian(var0) {
  if(isDefined(self.bt.initiated)) {
    return anim.success;
  }

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
  self.fnsetstealthstate = &setstealthstate_neutral;
  self.bt.initiated = 1;
  return anim.success;
}

function setstealthstate_neutral(var0, var1) {
  if(var0 != "combat") {
    var0 = "idle";
  }

  return scripts\aitypes\stealth::setstealthstate(var0, var1);
}

function updateeveryframe_civ_global(var0) {
  scripts\aitypes\common::updateeveryframe_magicdoorchecks();
  return anim.success;
}

function updateeveryframe_civ_default(var0) {
  if(scripts\asm\asm_bb::bb_getcivilianstate() == "noncombat") {
    var1 = scripts\asm\asm::asm_getephemeraleventdata("ai_notify", "bulletwhizby");

    if(isDefined(var1)) {
      if(!isDefined(self.disablebulletwhizbyreaction)) {
        var2 = var1[0];
        var3 = isDefined(var2) && distancesquared(self.origin, var2.origin) < 262144;

        if(var3 || scripts\engine\utility::cointoss()) {
          scripts\asm\asm_bb::bb_setcivilianstate("combat");
          var4 = spawnStruct();
          var4.gametime = gettime() - 50;
          var4.params = var1;
          scripts\asm\asm_bb::bb_requestwhizby(var4);
          return anim.success;
        }
      }
    } else {
      var5 = 5000;
      var2 = scripts\asm\asm_bb::bb_getrequestedwhizby();

      if(!isDefined(var2) || gettime() > var2.gametime + var5) {
        scripts\asm\asm_bb::bb_requestwhizby(undefined);
      }
    }

    if(!istrue(self.ignoreall)) {
      var6 = getaiarray("axis");

      foreach(var8 in var6) {
        if(distancesquared(var8.origin, self.origin) < 262144) {
          scripts\asm\asm_bb::bb_setcivilianstate("combat");
          return anim.success;
        }
      }
    }
  }

  if(scripts\asm\asm_bb::bb_getcivilianstate() == "combat" && gettime() - scripts\asm\asm_bb::bb_getcivilianstatetime() >= 10000) {
    scripts\asm\asm_bb::bb_setcivilianstate("noncombat");
  }

  return anim.success;
}

function isincover(var0) {
  if(!isDefined(self.node) || self.node.type == "Path" || self.node.type == "Exposed" || scripts\engine\utility::isnodeexposed3d(self.node) || self.node nodeisdisconnected()) {
    return anim.failure;
  }

  var1 = 16;

  if(isDefined(self.pathgoalpos)) {
    if(distancesquared(self.pathgoalpos, self.origin) > var1) {
      return anim.failure;
    }
  } else {
    var1 = 225;
  }

  var2 = undefined;

  if(scripts\engine\utility::actor_is3d()) {
    var2 = distancesquared(self.origin, self.node.origin);
  } else {
    if(abs(self.origin[2] - self.node.origin[2]) > 80) {
      return anim.failure;
    }

    var2 = distance2dsquared(self.origin, self.node.origin);
  }

  if(var2 > var1 && !istrue(self.pathpending)) {
    return anim.failure;
  }

  var3 = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(var3) && self.node != var3 && !istrue(self.pathpending)) {
    return anim.failure;
  }

  scripts\asm\asm_bb::bb_setcovernode(self.node);
  self.covernode = self.node;
  return anim.running;
}

function clearcover(var0) {
  self.covernode = undefined;
  scripts\asm\asm_bb::bb_setcovernode(undefined);
}