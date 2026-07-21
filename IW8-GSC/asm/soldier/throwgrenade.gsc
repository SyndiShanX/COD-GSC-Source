/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\throwgrenade.gsc
***********************************************/

shouldthrowgrenade(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_throwgrenaderequested())
    return 0;

  if(isDefined(var_3) && isDefined(self.node) && isDefined(self.node.type) && self.node.type != var_3)
    return 0;

  var_4 = scripts\asm\asm_bb::bb_getthrowgrenadetarget();

  if(!isDefined(var_4) || !isDefined(self.enemy) || var_4 != self.enemy) {
    scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "end");
    return 0;
  }

  if(scripts\aitypes\throwgrenade::grenadecooldownelapsed(var_4)) {
    var_5 = scripts\asm\asm::asm_getanim(var_0, var_2);

    if(isDefined(var_5)) {
      var_6 = getgrenadethrowoffset(var_2, var_5);
      var_7 = self.randomgrenaderange;
      var_8 = distance(var_4.origin, self.origin);

      if(var_8 < 800) {
        if(var_8 < 256)
          var_7 = 0;
        else
          var_7 = var_7 * ((var_8 - 256) / 544);
      }

      var_9 = self checkgrenadethrow(var_6, var_7, "min energy", "min time", "max time");
      self.a.nextgrenadetrytime = gettime() + randomintrange(1000, 2000);

      if(isDefined(var_9)) {
        var_10 = spawnStruct();
        var_10.xanim = var_5;
        var_10.vel = var_9;
        var_10.target = var_4;
        var_10.handoffset = var_6;
        var_10.fastthrow = 0;
        var_10.withbounce = shouldbounce(self.grenadeweapon);
        var_10.time = gettime();
        self._blackboard.throwdata = var_10;
        return 1;
      }
    }
  }

  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "end");
  return 0;
}

chooseanim_throwgrenade(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = scripts\asm\asm::asm_getallanimindicesforalias(var_1, "exposed_grenade");

  if(isarray(var_4)) {
    var_5 = [];

    foreach(var_7 in var_4) {
      var_8 = scripts\asm\asm::asm_getxanim(var_1, var_7);
      var_9 = getnotetracktimes(var_8, "grenade_throw");

      if(var_9.size > 0)
        var_10 = getmovedelta(var_8, 0, var_9[0]);
      else
        var_10 = getmovedelta(var_8);

      var_10 = self localtoworldcoords(var_10);

      if(self maymovefrompointtopoint(self.origin, var_10))
        var_5[var_5.size] = var_7;
    }

    if(var_5.size > 0)
      var_3 = var_5[randomint(var_5.size)];
    else
      return undefined;
  } else
    var_3 = var_4;

  return var_3;
}

playanim_throwgrenade(var_0, var_1, var_2) {
  var_3 = self._blackboard.throwdata;
  self.ispreppinggrenade = 1;
  var_4 = trygrenadethrow(var_0, var_1, var_3);

  if(!var_4) {
    self endon(var_1 + "_finished");
    wait 0.2;
    scripts\asm\asm::asm_fireevent(var_0, "end");
  }
}

playcoveranim_throwgrenade(var_0, var_1, var_2) {
  if(isDefined(self.node))
    self.keepclaimednodeifvalid = 1;

  playanim_throwgrenade(var_0, var_1, var_2);
}

playcoveranim_throwgrenade_cleanup(var_0, var_1, var_2) {
  scripts\asm\soldier\cover::clearcoveranim(var_0, var_1, var_2);
  playanim_throwgrenade_cleanup(var_0, var_1, var_2);
}

playanim_throwgrenade_cleanup(var_0, var_1, var_2) {
  self._blackboard.throwdata = undefined;
  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "end");

  if(scripts\common\utility::issp() && isDefined(self.isholdinggrenade)) {
    scripts\anim\combat_utility.gsc::dropgrenade();
    self.isholdinggrenade = undefined;
  }

  self.ispreppinggrenade = undefined;
}

shouldbounce(var_0) {
  var_1 = var_0.basename;
  return var_1 != "antigrav" && var_1 != "emp" && var_1 != "c8_grenade";
}

trygrenadethrow(var_0, var_1, var_2, var_3) {
  var_4 = var_2.destination;
  var_5 = var_2.target;
  var_6 = var_2.withbounce;

  if(!isDefined(var_6))
    var_6 = 1;

  if(isDefined(var_4)) {
    var_7 = getgrenadethrowoffset(var_1, var_2.xanim);

    if(!isDefined(var_2.fastthrow))
      var_8 = self checkgrenadethrowpos(var_7, var_4, var_6, "min energy", "min time", "max time");
    else
      var_8 = self checkgrenadethrowpos(var_7, var_4, var_6, "min time", "min energy");
  } else
    var_8 = var_2.vel;

  var_5 = var_2.target;

  if(isDefined(var_8)) {
    if(!isDefined(self.oldgrenawareness))
      self.oldgrenawareness = self.grenadeawareness;

    self.grenadeawareness = 0;
    var_9 = getdesiredgrenadetimervalue();
    setgrenadetimer(self.activegrenadetimer, min(gettime() + 3000, var_9));
    var_10 = 0;

    if(usingplayergrenadetimer()) {
      var_5.numgrenadesinprogresstowardsplayer++;
      thread reducegiptponkillanimscript(var_1, var_5);

      if(var_5.numgrenadesinprogresstowardsplayer > 1)
        var_10 = 1;

      if(self.activegrenadetimer.timername == "fraggrenade") {
        if(var_5.numgrenadesinprogresstowardsplayer <= 1)
          var_5.lastfraggrenadetoplayerstart = gettime();
      }
    }

    if(isDefined(var_3))
      thread dogrenadethrow(var_0, var_1, var_2.xanim, var_8, var_9, var_10);
    else
      dogrenadethrow(var_0, var_1, var_2.xanim, var_8, var_9, var_10);

    return 1;
  } else {}

  return 0;
}

getgrenadethrowoffset(var_0, var_1) {
  var_2 = (0, 0, 64);
  var_3 = scripts\asm\shared\utility::getbasearchetype();
  var_4 = 0;

  if(isDefined(anim.grenadethrowanims)) {
    if(!isDefined(anim.grenadethrowanims[var_3]))
      var_3 = "soldier";

    if(isDefined(anim.grenadethrowanims[var_3])) {
      if(isDefined(anim.grenadethrowanims[var_3][var_0])) {
        foreach(var_8, var_6 in anim.grenadethrowanims[var_3][var_0]) {
          for(var_7 = 0; var_7 < var_6.size; var_7++) {
            if(var_6[var_7] == var_1) {
              var_2 = anim.grenadethrowoffsets[var_3][var_0][var_8][var_7];
              var_4 = 1;
              break;
            }
          }

          if(var_4) {
            break;
          }
        }
      }
    }
  }

  return var_2;
}

getdesiredgrenadetimervalue() {
  var_0 = undefined;

  if(usingplayergrenadetimer()) {
    var_1 = self.activegrenadetimer.player;
    var_0 = gettime() + var_1.gs.playergrenadebasetime + randomint(var_1.gs.playergrenaderangetime);
  } else
    var_0 = gettime() + 30000 + randomint(30000);

  return var_0;
}

usingplayergrenadetimer() {
  return self.activegrenadetimer.isplayertimer;
}

reducegiptponkillanimscript(var_0, var_1) {
  self endon("dont_reduce_giptp_on_killanimscript");
  self waittill(var_0 + "_finished");
  var_1.numgrenadesinprogresstowardsplayer--;
}

dogrenadethrow(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("killanimscript");
  self endon(var_1 + "_finished");
  scripts\asm\asm::asm_fireephemeralevent("throwgrenade", "start");
  var_6 = scripts\asm\asm_bb::bb_getcovernode();

  if(!isDefined(var_6) || var_6.type == "Exposed" || var_6.type == "Path")
    self orientmode("face direction", var_3);

  var_7 = scripts\asm\asm::asm_getbodyknob();
  var_8 = scripts\asm\asm::asm_getxanim(var_1, var_2);
  scripts\anim\battlechatter_wrapper.gsc::evaluateattackevent(self.grenadeweapon.basename);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_8);
  self aisetanim(var_1, var_2, fasteranimspeed());
  thread scripts\asm\asm::asm_donotetracks(var_0, var_1);
  var_9 = scripts\anim\utility_common.gsc::getgrenademodel();
  var_10 = "none";
  var_11 = 0;

  while(!var_11) {
    self waittill(var_1, var_12);

    if(!isarray(var_12))
      var_12 = [var_12];

    foreach(var_14 in var_12) {
      if(var_14 == "grenade_left" || var_14 == "grenade_right") {
        var_10 = attachgrenademodel(var_1, var_9, "tag_accessory_right");
        self.isholdinggrenade = 1;
      }

      if(var_14 == "grenade_throw" || var_14 == "grenade throw") {
        if(isDefined(self.animtree) && self.animtree == "c6")
          self playSound("c6_grenade_launch");

        var_11 = 1;
        continue;
      }

      if(var_14 == "end") {
        self.activegrenadetimer.player.numgrenadesinprogresstowardsplayer--;
        self notify("dont_reduce_giptp_on_killanimscript");
        return 0;
      }
    }
  }

  self notify("dont_reduce_giptp_on_killanimscript");

  if(usingplayergrenadetimer())
    thread watchgrenadetowardsplayer(var_1, self.activegrenadetimer.player, var_4);

  var_22 = self throwgrenade();

  if(!usingplayergrenadetimer())
    setgrenadetimer(self.activegrenadetimer, var_4);

  if(var_5 && self.activegrenadetimer.isplayertimer) {
    var_23 = self.activegrenadetimer.player;

    if(var_23.numgrenadesinprogresstowardsplayer > 1 || gettime() - var_23.lastgrenadelandednearplayertime < 2000)
      var_23.grenadetimers["double_grenade"] = gettime() + min(5000, var_23.gs.playerdoublegrenadetime);
  }

  self notify("stop grenade check");

  if(var_10 != "none")
    self detach(var_9, var_10);

  self.isholdinggrenade = undefined;
  self.ispreppinggrenade = undefined;
  self.grenadeawareness = self.oldgrenawareness;
  self.oldgrenawareness = undefined;
  self.throwgrenadeatenemyasap = undefined;

  if(isDefined(var_22) && self.team == "axis")
    level notify("enemy_grenade_fire", var_22);

  self waittillmatch(var_1, "end");
  self notify("done_grenade_throw");
  self notify("weapon_switch_done");
}

throwgrenade_shouldabort(var_0, var_1, var_2, var_3) {
  if(!scripts\asm\asm_bb::bb_throwgrenaderequested()) {
    if(scripts\asm\asm::asm_eventfired(var_0, "grenade_throw") || scripts\asm\asm::asm_eventfired(var_0, "grenade throw"))
      return 0;

    if(scripts\asm\asm::asm_eventfired(var_0, "grenade_right") || scripts\asm\asm::asm_eventfired(var_0, "grenade_left"))
      return 0;

    return 1;
  }

  return 0;
}

fasteranimspeed() {
  return 1.5;
}

attachgrenademodel(var_0, var_1, var_2) {
  self attach(var_1, var_2);
  thread detachgrenadeonscriptchange(var_0, var_1, var_2);
  return var_2;
}

waittillscriptchange(var_0) {
  self endon(var_0 + "_finished");
  self waittill("killanimscript");
}

detachgrenadeonscriptchange(var_0, var_1, var_2) {
  self endon("stop grenade check");
  waittillscriptchange(var_0);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.oldgrenawareness)) {
    self.grenadeawareness = self.oldgrenawareness;
    self.oldgrenawareness = undefined;
  }

  self detach(var_1, var_2);
}

watchgrenadetowardsplayer(var_0, var_1, var_2) {
  var_1 endon("death");
  watchgrenadetowardsplayerinternal(var_0, var_2);
  var_1.numgrenadesinprogresstowardsplayer--;
}

watchgrenadetowardsplayerinternal(var_0, var_1) {
  var_2 = self.activegrenadetimer;
  var_3 = spawnStruct();
  var_3 thread watchgrenadetowardsplayertimeout(5);
  var_3 endon("watchGrenadeTowardsPlayerTimeout");
  var_4 = self.grenadeweapon.basename;
  var_5 = getgrenadeithrew(var_0);

  if(!isDefined(var_5)) {
    return;
  }
  setgrenadetimer(var_2, min(gettime() + 5000, var_1));
  var_6 = 62500;
  var_7 = 160000;

  if(var_4 == "flash_grenade") {
    var_6 = 810000;
    var_7 = 1690000;
  }

  var_8 = level.players;
  var_9 = var_5.origin;

  for(;;) {
    wait 0.1;

    if(!isDefined(var_5)) {
      break;
    }

    if(distancesquared(var_5.origin, var_9) < 400) {
      var_10 = [];

      for(var_11 = 0; var_11 < var_8.size; var_11++) {
        var_12 = var_8[var_11];
        var_13 = distancesquared(var_5.origin, var_12.origin);

        if(var_13 < var_6) {
          var_12 grenadelandednearplayer(var_2, var_1);
          continue;
        }

        if(var_13 < var_7)
          var_10[var_10.size] = var_12;
      }

      var_8 = var_10;

      if(var_8.size == 0) {
        break;
      }
    }

    var_9 = var_5.origin;
  }
}

grenadelandednearplayer(var_0, var_1) {
  var_2 = self;
  anim.throwgrenadeatplayerasap = undefined;

  if(gettime() - var_2.lastgrenadelandednearplayertime < 3000)
    var_2.grenadetimers["double_grenade"] = gettime() + var_2.gs.playerdoublegrenadetime;

  var_2.lastgrenadelandednearplayertime = gettime();
  var_3 = var_2.grenadetimers[var_0.timername];
  var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
}

setgrenadetimer(var_0, var_1) {
  if(var_0.isplayertimer) {
    var_2 = var_0.player;
    var_3 = var_2.grenadetimers[var_0.timername];
    var_2.grenadetimers[var_0.timername] = max(var_1, var_3);
  } else {
    var_3 = anim.grenadetimers[var_0.timername];
    anim.grenadetimers[var_0.timername] = max(var_1, var_3);
  }
}

getgrenadeithrew(var_0) {
  self endon("killanimscript");
  self endon(var_0 + "_finished");
  self waittill("grenade_fire", var_1);
  return var_1;
}

watchgrenadetowardsplayertimeout(var_0) {
  wait(var_0);
  self notify("watchGrenadeTowardsPlayerTimeout");
}

getgrenadetimertime(var_0) {
  if(var_0.isplayertimer)
    return var_0.player.grenadetimers[var_0.timername];
  else
    return anim.grenadetimers[var_0.timername];
}

offsettoorigin(var_0) {
  var_1 = anglesToForward(self.angles);
  var_2 = anglestoright(self.angles);
  var_3 = anglestoup(self.angles);
  var_1 = var_1 * var_0[0];
  var_2 = var_2 * var_0[1];
  var_3 = var_3 * var_0[2];
  return var_1 + var_2 + var_3;
}