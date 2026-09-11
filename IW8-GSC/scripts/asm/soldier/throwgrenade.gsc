/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\throwgrenade.gsc
************************************************/

function shouldthrowgrenade(var0, var1, var2, var3) {
  if(!scripts\asm\asm_bb::bb_throwgrenaderequested()) {
    return false;
  }

  if(isDefined(var3) && isDefined(self.node) && isDefined(self.node.type) && self.node.type != var3) {
    return false;
  }

  var4 = scripts\asm\asm_bb::bb_getthrowgrenadetarget();

  if(!isDefined(var4) || !isDefined(self.enemy) || var4 != self.enemy) {
    scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "end");
    return false;
  }

  if(scripts\aitypes\throwgrenade::grenadecooldownelapsed(var4)) {
    var5 = scripts\asm\asm::asm_getanim(var0, var2);

    if(isDefined(var5)) {
      var6 = getgrenadethrowoffset(var2, var5);
      var7 = self.randomgrenaderange;
      var8 = distance(var4.origin, self.origin);

      if(var8 < 800) {
        if(var8 < 256) {
          var7 = 0;
        } else {
          var7 *= (var8 - 256) / 544;
        }
      }

      var9 = self checkgrenadethrow(var6, var7, "min energy", "min time", "max time");
      self.a.nextgrenadetrytime = gettime() + randomintrange(1000, 2000);

      if(isDefined(var9)) {
        var10 = spawnStruct();
        var10.xanim = var5;
        var10.vel = var9;
        var10.target = var4;
        var10.handoffset = var6;
        var10.fastthrow = 0;
        var10.withbounce = shouldbounce(self.grenadeweapon);
        var10.time = gettime();
        self._blackboard.throwdata = var10;
        return true;
      }
    }
  }

  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "end");
  return false;
}

function chooseanim_throwgrenade(var0, var1, var2) {
  var3 = undefined;
  var4 = scripts\asm\asm::asm_getallanimindicesforalias(var1, "exposed_grenade");

  if(isarray(var4)) {
    var5 = [];

    foreach(var7 in var4) {
      var8 = scripts\asm\asm::asm_getxanim(var1, var7);
      var9 = getnotetracktimes(var8, "grenade_throw");

      if(var9.size > 0) {
        var10 = getmovedelta(var8, 0, var9[0]);
      } else {
        var10 = getmovedelta(var8);
      }

      var10 = self localtoworldcoords(var10);

      if(self maymovefrompointtopoint(self.origin, var10)) {
        var5 = var7;
      }
    }

    if(var5.size > 0) {
      var3 = var5[randomint(var5.size)];
    } else {
      return undefined;
    }
  } else {
    var3 = var4;
  }

  return var3;
}

function playanim_throwgrenade(var0, var1, var2) {
  var3 = self._blackboard.throwdata;
  self.ispreppinggrenade = 1;
  var4 = trygrenadethrow(var0, var1, var3);

  if(!var4) {
    self endon(var1 + "_finished");
    wait 0.2;
    scripts\asm\asm::asm_fireevent(var0, "end");
    return;
  }
}

function playcoveranim_throwgrenade(var0, var1, var2) {
  if(isDefined(self.node)) {
    self.keepclaimednodeifvalid = 1;
  }

  playanim_throwgrenade(var0, var1, var2);
}

function playcoveranim_throwgrenade_cleanup(var0, var1, var2) {
  scripts\asm\soldier\cover::clearcoveranim(var0, var1, var2);
  playanim_throwgrenade_cleanup(var0, var1, var2);
}

function playanim_throwgrenade_cleanup(var0, var1, var2) {
  self._blackboard.throwdata = undefined;
  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "end");

  if(scripts\common\utility::issp() && isDefined(self.isholdinggrenade)) {
    scripts\anim\combat_utility::dropgrenade();
    self.isholdinggrenade = undefined;
  }

  self.ispreppinggrenade = undefined;
}

function shouldbounce(var0) {
  var1 = var0.basename;
  return var1 != "antigrav" && var1 != "emp" && var1 != "c8_grenade";
}

function trygrenadethrow(var0, var1, var2, var3) {
  var4 = var2.destination;
  var5 = var2.target;
  var6 = var2.withbounce;

  if(!isDefined(var6)) {
    var6 = 1;
  }

  if(isDefined(var4)) {
    var7 = getgrenadethrowoffset(var1, var2.xanim);

    if(!isDefined(var2.fastthrow)) {
      var8 = self checkgrenadethrowpos(var7, var4, var6, "min energy", "min time", "max time");
    } else {
      var8 = self checkgrenadethrowpos(var7, var4, var6, "min time", "min energy");
    }
  } else {
    var8 = var3.vel;
  }

  var6 = var3.target;

  if(isDefined(var8)) {
    if(!isDefined(self.oldgrenawareness)) {
      self.oldgrenawareness = self.grenadeawareness;
    }

    self.grenadeawareness = 0;
    var9 = getdesiredgrenadetimervalue();
    setgrenadetimer(self.activegrenadetimer, min(gettime() + 3000, var9));
    var10 = 0;

    if(usingplayergrenadetimer()) {
      var6.numgrenadesinprogresstowardsplayer++;
      thread reducegiptponkillanimscript(var2, var6);

      if(var6.numgrenadesinprogresstowardsplayer > 1) {
        var10 = 1;
      }

      if(self.activegrenadetimer.timername == "fraggrenade") {
        if(var6.numgrenadesinprogresstowardsplayer <= 1) {
          var6.lastfraggrenadetoplayerstart = gettime();
        }
      }
    }

    if(isDefined(var4)) {
      thread dogrenadethrow(var1, var2, var3.xanim, var8, var9, var10);
    } else {
      dogrenadethrow(var1, var2, var3.xanim, var8, var9, var10);
    }

    return true;
  }

  return false;
}

function getgrenadethrowoffset(var0, var1) {
  var2 = (0, 0, 64);
  var3 = scripts\asm\shared\utility::getbasearchetype();
  var4 = 0;

  if(isDefined(anim.grenadethrowanims)) {
    if(!isDefined(anim.grenadethrowanims[var3])) {
      var3 = "soldier";
    }

    if(isDefined(anim.grenadethrowanims[var3])) {
      if(isDefined(anim.grenadethrowanims[var3][var0])) {
        foreach(var6 in anim.grenadethrowanims[var3][var0]) {
          for(var7 = 0; var7 < var6.size; var7++) {
            if(var6[var7] == var1) {
              var2 = anim.grenadethrowoffsets[var3][var0][var8][var7];
              var4 = 1;
              break;
            }
          }

          if(var4) {
            break;
          }
        }
      }
    }
  }

  return var2;
}

function getdesiredgrenadetimervalue() {
  var0 = undefined;

  if(usingplayergrenadetimer()) {
    var1 = self.activegrenadetimer.player;
    var0 = gettime() + var1.gs.playergrenadebasetime + randomint(var1.gs.playergrenaderangetime);
  } else {
    var0 = gettime() + 30000 + randomint(30000);
  }

  return var0;
}

function usingplayergrenadetimer() {
  return self.activegrenadetimer.isplayertimer;
}

function reducegiptponkillanimscript(var0, var1) {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill(var0 + "_finished");
  var1.numgrenadesinprogresstowardsplayer--;
}

function dogrenadethrow(var0, var1, var2, var3, var4, var5) {
  self endon("killanimscript");
  self endon(var1 + "_finished");
  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "start");
  var6 = scripts\asm\asm_bb::bb_getcovernode();

  if(!isDefined(var6) || var6.type == "Exposed" || var6.type == "Path") {
    self orientmode("face direction", var3);
  }

  var7 = scripts\asm\asm::asm_getbodyknob();
  var8 = scripts\asm\asm::asm_getxanim(var1, var2);
  scripts\anim\battlechatter_wrapper::evaluateattackevent(self.grenadeweapon.basename);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var8);
  self aisetanim(var1, var2, fasteranimspeed());
  thread scripts\asm\asm::asm_donotetracks(var0, var1);
  var9 = scripts\anim\utility_common::getgrenademodel();
  var10 = "none";
  var11 = 0;

  while(!var11) {
    self waittill(var1, var12);

    if(!isarray(var12)) {
      var12 = [var12];
    }

    foreach(var14 in var12) {
      if(var14 == "grenade_left" || var14 == "grenade_right") {
        var10 = attachgrenademodel(var1, var9, "tag_accessory_right");
        self.isholdinggrenade = 1;
      }

      if(var14 == "grenade_throw" || var14 == "grenade throw") {
        if(isDefined(self.animtree) && self.animtree == "c6") {
          self playSound("c6_grenade_launch");
        }

        var11 = 1;
        continue;
      }

      if(var14 == "end") {
        self.activegrenadetimer.player.numgrenadesinprogresstowardsplayer--;
        self notify("dont_reduce_giptp_on_killanimscript");
        return 0;
      }
    }
  }

  self notify("dont_reduce_giptp_on_killanimscript");

  if(usingplayergrenadetimer()) {
    thread watchgrenadetowardsplayer(var1, self.activegrenadetimer.player, var4);
  }

  var22 = self throwgrenade();

  if(!usingplayergrenadetimer()) {
    setgrenadetimer(self.activegrenadetimer, var4);
  }

  if(var5 && self.activegrenadetimer.isplayertimer) {
    var23 = self.activegrenadetimer.player;

    if(var23.numgrenadesinprogresstowardsplayer > 1 || gettime() - var23.lastgrenadelandednearplayertime < 2000) {
      var23.grenadetimers["double_grenade"] = gettime() + min(5000, var23.gs.playerdoublegrenadetime);
    }
  }

  self notify("stop grenade check");

  if(var10 != "none") {
    self detach(var9, var10);
  }

  self.isholdinggrenade = undefined;
  self.ispreppinggrenade = undefined;
  self.grenadeawareness = self.oldgrenawareness;
  self.oldgrenawareness = undefined;
  self.throwgrenadeatenemyasap = undefined;

  if(isDefined(var22) && self.team == "axis") {
    level notify("enemy_grenade_fire", var22);
  }

  self waittillmatch(var1, "end");
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
}

function throwgrenade_shouldabort(var0, var1, var2, var3) {
  if(!scripts\asm\asm_bb::bb_throwgrenaderequested()) {
    if(scripts\asm\asm::asm_eventfired(var0, "grenade_throw") || scripts\asm\asm::asm_eventfired(var0, "grenade throw")) {
      return false;
    }

    if(scripts\asm\asm::asm_eventfired(var0, "grenade_right") || scripts\asm\asm::asm_eventfired(var0, "grenade_left")) {
      return false;
    }

    return true;
  }

  return false;
}

function fasteranimspeed() {
  return 1.5;
}

function attachgrenademodel(var0, var1, var2) {
  self attach(var1, var2);
  thread detachgrenadeonscriptchange(var0, var1, var2);
  return var2;
}

function waittillscriptchange(var0) {
  self endon(var0 + "_finished");
  self waittill("killanimscript");
}

function detachgrenadeonscriptchange(var0, var1, var2) {
  self endon("stop grenade check");
  waittillscriptchange(var0);

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.oldgrenawareness)) {
    self.grenadeawareness = self.oldgrenawareness;
    self.oldgrenawareness = undefined;
  }

  self detach(var1, var2);
}

function watchgrenadetowardsplayer(var0, var1, var2) {
  var1 endon("death");
  watchgrenadetowardsplayerinternal(var0, var2);
  var1.numgrenadesinprogresstowardsplayer--;
}

function watchgrenadetowardsplayerinternal(var0, var1) {
  var2 = self.activegrenadetimer;
  var3 = spawnStruct();
  thread watchgrenadetowardsplayertimeout(var3);
  var3 endon("watchGrenadeTowardsPlayerTimeout");
  var4 = self.grenadeweapon.basename;
  var5 = getgrenadeithrew(var0);

  if(!isDefined(var5)) {
    return;
  }

  setgrenadetimer(var2, min(gettime() + 5000, var1));
  var6 = 62500;
  var7 = 160000;

  if(var4 == "flash_grenade") {
    var6 = 810000;
    var7 = 1690000;
  }

  var8 = level.players;
  var9 = var5.origin;

  for(;;) {
    wait 0.1;

    if(distancesquared(var5.origin, var9) < 400) {
      var10 = [];

      for(var11 = 0; var11 < var8.size; var11++) {
        var12 = var8[var11];
        var13 = distancesquared(var5.origin, var12.origin);

        if(var13 < var6) {
          grenadelandednearplayer(var12, var2, var1);
          continue;
        }

        if(var13 < var7) {
          var10 = var12;
        }
      }

      var8 = var10;

      if(var8.size == 0) {
        break;
      }
    }

    var5 = var1.origin;
  }
}

function grenadelandednearplayer(var0, var1) {
  var2 = self;
  anim.throwgrenadeatplayerasap = undefined;

  if(gettime() - var2.lastgrenadelandednearplayertime < 3000) {
    var2.grenadetimers["double_grenade"] = gettime() + var2.gs.playerdoublegrenadetime;
  }

  var2.lastgrenadelandednearplayertime = gettime();
  var3 = var2.grenadetimers[var0.timername];
  var2.grenadetimers[var0.timername] = max(var1, var3);
}

function setgrenadetimer(var0, var1) {
  if(var0.isplayertimer) {
    var2 = var0.player;
    var3 = var2.grenadetimers[var0.timername];
    var2.grenadetimers[var0.timername] = max(var1, var3);
    return;
  }

  var3 = anim.grenadetimers[var1.timername];
  anim.grenadetimers[var1.timername] = max(var3, var3);
}

function getgrenadeithrew(var0) {
  self endon("killanimscript");
  self endon(var0 + "_finished");
  self waittill("grenade_fire", var1);
  return var1;
}

function watchgrenadetowardsplayertimeout(var0) {
  wait var0;
  self notify("watchGrenadeTowardsPlayerTimeout");
}

function getgrenadetimertime(var0) {
  if(var0.isplayertimer) {
    return var0.player.grenadetimers[var0.timername];
  }

  return anim.grenadetimers[var0.timername];
}

function offsettoorigin(var0) {
  var1 = anglesToForward(self.angles);
  var2 = anglestoright(self.angles);
  var3 = anglestoup(self.angles);
  var1 *= var0[0];
  var2 *= var0[1];
  var3 *= var0[2];
  return var1 + var2 + var3;
}