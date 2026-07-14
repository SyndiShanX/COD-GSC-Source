/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\ai_lookat.gsc
****************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace ai_lookat;

function enablelookatplayer(enabletime, percent) {
  enablelookatentity(level.player, utility::function_3cf801aa1d168fc8(enabletime), percent);
}

function disablelookatplayer() {
  disablelookatentity(level.player);
}

function enablelookatentity(target, speed, percent, offset) {
  if(!isDefined(self.lookatentities)) {
    self.lookatentities = [];
  }

  self.lookatentities[self.lookatentities.size] = {
    #offset: offset, #percent: percent, #speed: speed, #target: target
  };
  function_f265a07183640c56(target, speed, percent, offset);
}

function disablelookatentity(target) {
  if(!isDefined(self.lookatentities)) {
    self.lookatentities = [];
  }

  function_582fb63c5cef0c5c(target);
  look = self.lookatentities[self.lookatentities.size - 1];
  function_f265a07183640c56(look.target, look.speed, look.percent, look.offset);
}

function private function_582fb63c5cef0c5c(target) {
  remove = [];

  foreach(look in self.lookatentities) {
    if(!isDefined(look.target) || look.target == target) {
      remove[remove.size] = look;
    }
  }

  foreach(look in remove) {
    self.lookatentities = arrayremove(self.lookatentities, look);
  }
}

function private function_f265a07183640c56(target, speed, percent, offset) {
  if(isDefined(target)) {
    self setlookatenabled(1);
    self setlookatstate("request");
    focustarget = spawnStruct();

    if(isDefined(speed)) {
      focustarget.speed = speed;
    }

    if(isDefined(percent)) {
      focustarget.percent = percent;
    }

    if(isent(target)) {
      focustarget.entity = target;
    } else {
      assert(isstruct(target) && isDefined(target.origin));
      focustarget.position = target.origin;
    }

    if(isDefined(offset)) {
      focustarget.offset = offset;
    }

    self lookat(focustarget);
    return;
  }

  self setlookatstate("neutral");
  self setlookatenabled(0);
}

function islookingatplayer() {
  return islookingatentity(level.player);
}

function islookingatentity(ent) {
  return ent == getlookatentity();
}

function getlookatentity() {
  if(!isDefined(self.lookatentities) || !self.lookatentities.size) {
    return undefined;
  }

  return utility::function_f1933af772476229(self.lookatentities);
}

function function_25744b55fe6af33f(ontimeclose, ontimefar, offtimeclose, offtimefar, innerradius, outerradius, enabletimeclose, enabletimefar, percentclose, percentfar, fovcos, var_d0dcaf0cc224660f) {
  self endon("death");
  self endon("stop_idle_lookat");
  var_23dc00d3874c0941 = 1;
  var_d8cc70e768157696 = 2;
  var_2bd6b20aeec3cf0b = 2000;
  cstart = 0;
  ccantsee = 1;
  var_7af99705ff8bf6f9 = 2;
  var_9d322c59f4aa6c28 = 3;
  var_490b9698511e3343 = 4;
  var_3cfcd43cd655f4b6 = 5;
  var_ff9113cb96e62f35 = 6;
  var_6d6c16c61659c578 = 7;
  var_9c9b256a73adba0 = 8;
  var_a1c24d03078948f1 = 9;
  state = cstart;
  nextstate = cstart;
  cooldown = 0;
  ontimeclose = int(ontimeclose) * 1000;
  ontimefar = int(ontimefar) * 1000;
  offtimeclose = int(offtimeclose) * 1000;
  offtimefar = int(offtimefar) * 1000;

  setdvarifuninitialized(@ "hash_f3db11612f967c4a", 0);

  while(true) {
    disttoplayer = distance(level.player.origin, self.origin);
    diststate = var_d8cc70e768157696;

    if(disttoplayer > innerradius) {
      diststate = var_23dc00d3874c0941;
    }

    selfforward = anglesToForward(self.angles);
    playerforward = anglesToForward(level.player.angles);
    toplayer = vectorNormalize(level.player.origin - self.origin);
    canseeplayer = vectordot(selfforward, toplayer) > fovcos && disttoplayer < outerradius;
    playercansee = vectordot(playerforward, -1 * toplayer) > var_d0dcaf0cc224660f;

    if(getdvarint(@ "hash_f3db11612f967c4a", 0)) {
      statestr = "<dev string:x24>";

      switch (state) {
        case 0:
          statestr = "<dev string:x28>";
          break;
        case 1:
          statestr = "<dev string:x31>";
          break;
        case 2:
          statestr = "<dev string:x3d>";
          break;
        case 3:
          statestr = "<dev string:x4e>";
          break;
        case 4:
          statestr = "<dev string:x5c>";
          break;
        case 5:
          statestr = "<dev string:x78>";
          break;
        case 6:
          statestr = "<dev string:x93>";
          break;
        case 7:
          statestr = "<dev string:xa2>";
          break;
        case 8:
          statestr = "<dev string:xba>";
          break;
        case 9:
          statestr = "<dev string:xc8>";
          break;
        default:
          statestr = "<dev string:xdf>";
          break;
      }

      debugpos = (self.origin[0], self.origin[1], self.origin[2] + 80);
      print3d(debugpos, statestr, (0, 0, 1), 1, 0.25, 1, 1);
    }

    if(state == cstart) {
      if(!canseeplayer) {
        nextstate = ccantsee;
      } else if(canseeplayer) {
        nextstate = var_7af99705ff8bf6f9;
      }
    } else if(state == ccantsee) {
      if(canseeplayer) {
        nextstate = var_7af99705ff8bf6f9;
      }
    } else if(state == var_7af99705ff8bf6f9 && cooldown < gettime()) {
      if(!canseeplayer) {
        nextstate = ccantsee;
      } else if(diststate == var_d8cc70e768157696 && playercansee) {
        nextstate = var_9d322c59f4aa6c28;
      } else if(diststate == var_d8cc70e768157696 && !playercansee) {
        nextstate = var_ff9113cb96e62f35;
      } else if(diststate == var_23dc00d3874c0941) {
        nextstate = var_9c9b256a73adba0;
      }
    } else if(state == var_9d322c59f4aa6c28) {
      if(diststate != var_d8cc70e768157696 || !canseeplayer || !playercansee) {
        nextstate = var_490b9698511e3343;
      }
    } else if(state == var_490b9698511e3343 && cooldown < gettime()) {
      if(!canseeplayer) {
        nextstate = ccantsee;
      } else if(diststate == var_d8cc70e768157696 && playercansee) {
        nextstate = var_9d322c59f4aa6c28;
      } else if(diststate == var_d8cc70e768157696 && !playercansee) {
        nextstate = var_6d6c16c61659c578;
      } else if(diststate == var_23dc00d3874c0941) {
        nextstate = var_a1c24d03078948f1;
      }
    } else if(state == var_3cfcd43cd655f4b6 && cooldown < gettime()) {
      if(!canseeplayer) {
        nextstate = ccantsee;
      } else if(diststate == var_d8cc70e768157696 && playercansee) {
        nextstate = var_9d322c59f4aa6c28;
      } else if(diststate == var_d8cc70e768157696 && !playercansee) {
        nextstate = var_6d6c16c61659c578;
      } else if(diststate == var_23dc00d3874c0941) {
        nextstate = var_a1c24d03078948f1;
      }
    } else if(state == var_ff9113cb96e62f35 && cooldown < gettime()) {
      if(!canseeplayer) {
        nextstate = ccantsee;
      } else if(diststate == var_d8cc70e768157696 && !playercansee) {
        nextstate = var_6d6c16c61659c578;
      } else if(diststate == var_d8cc70e768157696 && playercansee) {
        nextstate = var_9d322c59f4aa6c28;
      } else if(diststate == var_23dc00d3874c0941) {
        nextstate = var_a1c24d03078948f1;
      }
    } else if(state == var_6d6c16c61659c578 && cooldown < gettime()) {
      if(!canseeplayer) {
        nextstate = ccantsee;
      } else if(diststate == var_d8cc70e768157696 && playercansee) {
        nextstate = var_3cfcd43cd655f4b6;
      } else if(diststate == var_d8cc70e768157696 && !playercansee) {
        nextstate = var_ff9113cb96e62f35;
      } else if(diststate == var_23dc00d3874c0941) {
        nextstate = var_a1c24d03078948f1;
      }
    } else if(state == var_9c9b256a73adba0 && cooldown < gettime()) {
      if(!canseeplayer) {
        nextstate = ccantsee;
      } else if(diststate == var_23dc00d3874c0941) {
        nextstate = var_a1c24d03078948f1;
      } else if(diststate == var_d8cc70e768157696 && playercansee) {
        nextstate = var_9d322c59f4aa6c28;
      } else if(diststate == var_d8cc70e768157696 && !playercansee) {
        nextstate = var_6d6c16c61659c578;
      }
    } else if(state == var_a1c24d03078948f1 && cooldown < gettime()) {
      if(!canseeplayer) {
        nextstate = ccantsee;
      } else if(diststate == var_23dc00d3874c0941) {
        nextstate = var_9c9b256a73adba0;
      } else if(diststate == var_d8cc70e768157696 && !playercansee) {
        nextstate = var_6d6c16c61659c578;
      } else if(diststate == var_d8cc70e768157696 && playercansee) {
        nextstate = var_3cfcd43cd655f4b6;
      }
    }

    if(state != nextstate) {
      if(state == cstart) {
        if(nextstate == ccantsee) {
          disablelookatplayer();
        } else if(nextstate == var_7af99705ff8bf6f9) {
          cooldown = gettime() + var_2bd6b20aeec3cf0b;
        }
      } else if(state == ccantsee) {
        if(nextstate == var_7af99705ff8bf6f9) {
          cooldown = gettime() + var_2bd6b20aeec3cf0b;
        }
      } else if(state == var_7af99705ff8bf6f9) {
        if(nextstate == ccantsee) {
          disablelookatplayer();
        } else if(nextstate == var_9d322c59f4aa6c28) {
          enablelookatplayer(enabletimeclose, percentclose);
        } else if(nextstate == var_ff9113cb96e62f35) {
          enablelookatplayer(enabletimeclose, percentclose);
          cooldown = gettime() + ontimeclose;
        } else if(nextstate == var_9c9b256a73adba0) {
          enablelookatplayer(enabletimefar, percentfar);
          cooldown = gettime() + ontimefar;
        }
      } else if(state == var_9d322c59f4aa6c28) {
        if(nextstate == var_490b9698511e3343) {
          cooldown = gettime() + var_2bd6b20aeec3cf0b;
        }
      } else if(state == var_490b9698511e3343) {
        if(nextstate == ccantsee) {
          disablelookatplayer();
        } else if(nextstate == var_6d6c16c61659c578) {
          disablelookatplayer();
          cooldown = gettime() + ontimeclose;
        } else if(nextstate == var_a1c24d03078948f1) {
          disablelookatplayer();
          cooldown = gettime() + ontimeclose;
        }
      } else if(state == var_3cfcd43cd655f4b6) {
        if(nextstate == var_9d322c59f4aa6c28) {
          enablelookatplayer(enabletimeclose, percentclose);
        } else if(nextstate == var_6d6c16c61659c578) {
          cooldown = gettime() + offtimeclose;
        } else if(nextstate == var_a1c24d03078948f1) {
          cooldown = gettime() + offtimefar;
        }
      } else if(state == var_ff9113cb96e62f35) {
        if(nextstate == ccantsee) {
          disablelookatplayer();
        } else if(nextstate == var_6d6c16c61659c578) {
          disablelookatplayer();
          cooldown = gettime() + offtimeclose;
        } else if(nextstate == var_a1c24d03078948f1) {
          disablelookatplayer();
          cooldown = gettime() + offtimefar;
        }
      } else if(state == var_6d6c16c61659c578) {
        if(nextstate == var_3cfcd43cd655f4b6) {
          cooldown = gettime() + var_2bd6b20aeec3cf0b;
        } else if(nextstate == var_ff9113cb96e62f35) {
          enablelookatplayer(enabletimeclose, percentclose);
          cooldown = gettime() + ontimeclose;
        } else if(nextstate == var_a1c24d03078948f1) {
          cooldown = gettime() + offtimefar;
        }
      } else if(state == var_9c9b256a73adba0) {
        if(nextstate == ccantsee) {
          disablelookatplayer();
        } else if(nextstate == var_a1c24d03078948f1) {
          disablelookatplayer();
          cooldown = gettime() + offtimefar;
        } else if(nextstate == var_9d322c59f4aa6c28) {} else if(nextstate == var_6d6c16c61659c578) {
          disablelookatplayer();
          cooldown = gettime() + offtimeclose;
        }
      } else if(state == var_a1c24d03078948f1) {
        if(nextstate == var_9c9b256a73adba0) {
          enablelookatplayer(enabletimefar, percentfar);
          cooldown = gettime() + ontimefar;
        } else if(nextstate == var_6d6c16c61659c578) {
          cooldown = gettime() + offtimeclose;
        } else if(nextstate == var_3cfcd43cd655f4b6) {
          cooldown = gettime() + var_2bd6b20aeec3cf0b;
        }
      }

      state = nextstate;
    }

    waitframe();
  }
}

function function_493390da3d8a2ea5(ontime, offtime, radius, enabletime, percent, fovcos, var_d0dcaf0cc224660f) {
  self endon("death");
  self endon("stop_idle_lookat");
  ccantsee = 0;
  var_7af99705ff8bf6f9 = 1;
  cglance = 2;
  var_5f650e525f4cc0fa = 3;
  var_e634c82eb55206cf = 2000;
  state = ccantsee;
  nextstate = ccantsee;
  cooldown = 0;
  ontime = int(ontime) * 1000;
  offtime = int(offtime) * 1000;

  setdvarifuninitialized(@ "hash_f3db11612f967c4a", 0);

  while(true) {
    disttoplayer = distance(level.player.origin, self.origin);
    selfforward = anglesToForward(self.angles);
    playerforward = anglesToForward(level.player.angles);
    toplayer = vectorNormalize(level.player.origin - self.origin);
    canseeplayer = vectordot(selfforward, toplayer) > fovcos && disttoplayer < radius;
    playercansee = vectordot(playerforward, -1 * toplayer) > var_d0dcaf0cc224660f;
    canseeplayer = canseeplayer && playercansee;

    if(getdvarint(@ "hash_f3db11612f967c4a", 0)) {
      statestr = "<dev string:x24>";

      switch (state) {
        case 0:
          statestr = "<dev string:x31>";
          break;
        case 1:
          statestr = "<dev string:x3d>";
          break;
        case 2:
          statestr = "<dev string:xea>";
          break;
        case 3:
          statestr = "<dev string:xf4>";
          break;
        default:
          statestr = "<dev string:xdf>";
          break;
      }

      debugpos = (self.origin[0], self.origin[1], self.origin[2] + 80);
      print3d(debugpos, statestr, (0, 0, 1), 1, 0.25, 1, 1);
    }

    if(state == ccantsee) {
      if(canseeplayer) {
        nextstate = var_7af99705ff8bf6f9;
      }
    } else if(state == var_7af99705ff8bf6f9 && cooldown < gettime()) {
      if(canseeplayer) {
        nextstate = cglance;
      } else {
        nextstate = ccantsee;
      }
    } else if(state == cglance && cooldown < gettime()) {
      if(canseeplayer) {
        nextstate = var_5f650e525f4cc0fa;
      } else {
        nextstate = ccantsee;
      }
    } else if(state == var_5f650e525f4cc0fa && cooldown < gettime()) {
      if(canseeplayer) {
        nextstate = cglance;
      } else {
        nextstate = ccantsee;
      }
    }

    if(state != nextstate) {
      if(state == ccantsee) {
        if(nextstate == var_7af99705ff8bf6f9) {
          cooldown = gettime() + var_e634c82eb55206cf;
        }
      } else if(state == var_7af99705ff8bf6f9) {
        if(nextstate == cglance) {
          enablelookatplayer(enabletime, percent);
          cooldown = gettime() + ontime;
        }
      } else if(state == cglance) {
        if(nextstate == var_5f650e525f4cc0fa) {
          disablelookatplayer();
          cooldown = gettime() + offtime;
        } else if(nextstate == ccantsee) {
          disablelookatplayer();
        }
      } else if(state == var_5f650e525f4cc0fa) {
        if(nextstate == cglance) {
          enablelookatplayer(enabletime, percent);
          cooldown = gettime() + ontime;
        }
      }

      state = nextstate;
    }

    waitframe();
  }
}

function function_3e43df790b0ba2cc(enable, playerradius, airadius) {
  level.var_a7516ac806d06b4f = enable;

  if(enable) {
    level thread function_de1d10d827815b89(playerradius, airadius);
    return;
  }

  level notify("end_levellookatteam");
}

function function_de1d10d827815b89(playerradius, airadius) {
  level endon("end_levellookatteam");

  if(!isDefined(playerradius)) {
    playerradius = 1024;
  }

  if(!isDefined(airadius)) {
    airadius = 512;
  }

  while(level.var_a7516ac806d06b4f) {
    wait 5;
    ai = getaiarrayinradius(level.player.origin, playerradius);

    foreach(guy in ai) {
      if(isDefined(guy isinscriptedstate()) && guy isinscriptedstate()) {
        continue;
      }

      guy thread function_c423198902a117be();

      guy thread ailookatteamlist(ai, airadius, 5);
    }
  }
}

function ailookatteamlist(ai, maxdist, maxtargets) {
  self endon("death");
  self endon("kill_lookatteam");
  enablelookatteam(1);
  function_e5b520d1a0e36c4a(ai, maxdist);
  function_61987c11611c2d28(ai, maxdist, 5);
  enablelookatteam(0);
}

function lookatteamthread(guys, maxdist, maxtargets) {
  if(!isDefined(self) || !isent(self)) {
    return;
  }

  self endon("death");
  self endon("kill_lookatteam");

  if(!isDefined(self) || self == level.player) {
    return;
  }

  enablelookatteam(1);
  guys[guys.size] = level.player;

  thread function_c423198902a117be();

  while(true) {
    function_79674e2daec9ad25();
    function_e5b520d1a0e36c4a(guys);
    function_61987c11611c2d28(guys, maxdist, maxtargets);
  }
}

function enablelookatteam(enable) {
  self setlookatenabled(enable);
  self.var_5ec73b3b0ea2c6b5 = enable;

  if(!enable) {
    self notify("kill_lookatteam");
  }
}

function function_e5b520d1a0e36c4a(guys, maxdist) {
  if(!isDefined(self.var_5ec73b3b0ea2c6b5) || !self.var_5ec73b3b0ea2c6b5) {
    return;
  }

  guys = function_46f9072493651dc9(guys);
  guy = utility::random(guys);

  if(guys.size < 2) {
    return;
  }

  if(!isDefined(guy) || vectordot(self.origin, guy.origin) < 0) {
    return;
  }

  if(guy == self) {
    function_79674e2daec9ad25();
    return;
  }

  if(self.lastlookattarget == guy) {
    self.lastlookattarget = undefined;
    return;
  }

  if(isDefined(maxdist) && distancesquared(self.origin, guy.origin) > maxdist * maxdist) {
    return;
  }

  if(vectordot(self.origin, guy.origin) <= 0) {
    return;
  }

  self.lastlookattarget = guy;

  self.lookatstate = "<dev string:x107>";

  stare(guy);
}

function function_61987c11611c2d28(guys, maxdist, maxtargets) {
  assert(self != level.player);
  guys = function_46f9072493651dc9(guys);
  guys = sortbydistance(guys, self.origin);

  if(guys.size < 2) {
    return;
  }

  self.lookatstate = "<dev string:x111>";

  for(lookattargetindex = 0; lookattargetindex < guys.size; lookattargetindex++) {
    guy = guys[lookattargetindex];

    if(!isDefined(self.var_5ec73b3b0ea2c6b5) || !self.var_5ec73b3b0ea2c6b5) {
      continue;
    }

    if(!isDefined(guy)) {
      continue;
    }

    if(self == guy) {
      continue;
    }

    if(!isalive(guy)) {
      continue;
    }

    if(self.lastlookattarget == guy) {
      self.lastlookattarget = undefined;
      continue;
    }

    if(lookattargetindex >= maxtargets) {
      return;
    }

    if(isDefined(maxdist) && distancesquared(self.origin, guy.origin) > maxdist * maxdist) {
      continue;
    }

    if(vectordot(self.origin, guy.origin) <= 0) {
      continue;
    }

    self.lastlookattarget = guy;
    stare(guy);
  }

  function_79674e2daec9ad25();
}

function function_79674e2daec9ad25() {
  if(!isDefined(self) || !isent(self)) {
    return;
  }

  minidletime = 2;
  maxidletime = 4;

  self.lookatstate = "<dev string:x11c>";

  self setlookatenabled(0);
  wait randomfloatrange(minidletime, maxidletime);
  self setlookatenabled(1);
}

function stare(other) {
  percent = 0.8;
  speed = 1;
  enablelookatentity(other, utility::function_3cf801aa1d168fc8(speed), percent);
  var_d78a68d84e0411e0 = 0.5;
  var_34750964448a44b2 = 1;

  if(isDefined(other)) {
    if(self.team == other.team) {
      var_d78a68d84e0411e0 = 1.5;
      var_34750964448a44b2 = 2.5;
    } else {
      var_d78a68d84e0411e0 = 1;
      var_34750964448a44b2 = 1.5;
    }
  }

  wait randomfloatrange(var_d78a68d84e0411e0, var_34750964448a44b2);
}

function function_c423198902a117be() {
  self endon("<dev string:x124>");
  self endon("<dev string:x12d>");
  setdvarifuninitialized(@ "hash_4e640bf30799c32f", 0);

  while(true) {
    waitframe();

    if(getdvarint(@ "hash_4e640bf30799c32f", 0)) {
      debugpos = self.origin + (0, 0, 88);

      if(isDefined(self.lookatstate)) {
        print3d(debugpos, self.lookatstate, (1, 1, 1), 1, 0.25);
      }
    }
  }
}

# /