/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_trl_create_a_script_race_euphrates.gsc
***********************************************************************/

function ref_134ac(var_0, var_1, var_2) {
  var_3 = self._blackboard.throwdata;
  self.ispreppinggrenade = 1;
  var_4 = ref_134c2(var_0, var_1, var_3);

  if(!var_4) {
    self endon(var_1 + "_finished");
    wait 0.2;
    scripts\asm\asm::asm_fireevent(var_0, "end");
    return;
  }
}

function ref_134c2(var_0, var_1, var_2, var_3) {
  var_4 = var_2.destination;
  var_5 = var_2.target;
  var_6 = var_2.withbounce;

  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  if(isDefined(var_4)) {
    var_7 = scripts\asm\soldier\throwgrenade::getgrenadethrowoffset(var_1, var_2.xanim);

    if(!isDefined(var_2.fastthrow)) {
      var_8 = self checkgrenadethrowpos(var_7, var_4, var_6, "min energy", "min time", "max time");
    } else {
      var_8 = self checkgrenadethrowpos(var_7, var_4, var_6, "min time", "min energy");
    }
  } else {
    var_8 = var_3.vel;
  }

  var_6 = var_3.target;

  if(isDefined(var_8)) {
    if(!isDefined(self.oldgrenawareness)) {
      self.oldgrenawareness = self.grenadeawareness;
    }

    self.grenadeawareness = 0;
    var_9 = reset_progress();
    scripts\asm\soldier\throwgrenade::setgrenadetimer(self.activegrenadetimer, min(gettime() + 3000, var_9));
    var_10 = 0;

    if(scripts\asm\soldier\throwgrenade::usingplayergrenadetimer()) {
      var_6.numgrenadesinprogresstowardsplayer++;
      thread scripts\asm\soldier\throwgrenade::reducegiptponkillanimscript(var_2, var_6);

      if(var_6.numgrenadesinprogresstowardsplayer > 1) {
        var_10 = 1;
      }

      if(self.activegrenadetimer.timername == "fraggrenade") {
        if(var_6.numgrenadesinprogresstowardsplayer <= 1) {
          var_6.lastfraggrenadetoplayerstart = gettime();
        }
      }
    }

    if(isDefined(var_4)) {
      thread scripts\asm\soldier\throwgrenade::dogrenadethrow(var_1, var_2, var_3.xanim, var_8, var_9, var_10);
    } else {
      scripts\asm\soldier\throwgrenade::dogrenadethrow(var_1, var_2, var_3.xanim, var_8, var_9, var_10);
    }

    return true;
  }

  return false;
}

function reset_progress() {
  var_0 = undefined;

  if(scripts\asm\soldier\throwgrenade::usingplayergrenadetimer()) {
    var_1 = self.activegrenadetimer.player;
    var_0 = gettime() + var_1.gs.playergrenadebasetime + randomint(var_1.gs.playergrenaderangetime);
  } else if(isDefined(self.set_disable_leave_truck) && isDefined(self.set_disable_leave_truck[self.activegrenadetimer.timername])) {
    var_0 = gettime() + 3000 + self.set_disable_leave_truck[self.activegrenadetimer.timername];
  } else {
    var_0 = gettime() + 30000 + randomint(30000);
  }

  return var_0;
}