/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\equipment\blackhat.gsc
*********************************************/

func_2B29() {
  scripts\mp\powerloot::func_DF06("power_blackhat", ["passive_increased_radius"]);
}

func_E0D4() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self playlocalsound("mp_overcharge_off");
}

func_13073() {
  self endon("death");
  self endon("disconnect");
  self endon("removeBlackhat");
  level endon("game_ended");
  self playlocalsound("mp_overcharge_on");
  thread func_2B2D();
}

func_2B2D() {
  self endon("death");
  self endon("disconnect");
  self endon("blackhat_used");
  self iprintlnbold("Blackhat");
  var_0 = scripts\mp\powers::func_D735("power_blackhat");
  var_1 = 0;
  self playgestureviewmodel("ges_hack_lock_in", undefined, var_1, 0.5);
  for(;;) {
    if(!scripts\mp\powers::func_9F09(var_0)) {
      break;
    }

    if(scripts\mp\powers::func_9F09(var_0)) {
      thread func_2B2B(var_0);
      while(scripts\mp\powers::func_9F09(var_0)) {
        wait(0.05);
        if(!scripts\mp\powers::func_9F09(var_0)) {
          break;
        }
      }
    }

    wait(0.05);
  }

  self stopgestureviewmodel("ges_hack_lock_in");
}

func_2B2E() {
  self notify("powers_blackhat_used", 1);
  self notify("blackhat_used");
  self stopgestureviewmodel("ges_hack_lock_in");
}

func_2B2B(var_0) {
  self notify("using_blackhat");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("blackhat_used");
  self endon("using_blackhat");
  var_1 = [];
  var_2 = [];
  var_3 = scripts\mp\powerloot::func_7FC4("power_blackhat", 20);
  for(;;) {
    if(scripts\mp\powers::func_9F09(var_0)) {
      var_4 = [];
      var_1 = func_7E94(self);
      foreach(var_6 in var_1) {
        var_7 = self worldpointinreticle_circle(var_6.origin, 65, var_3);
        if(var_7) {
          var_4[var_4.size] = var_6;
        }
      }

      if(var_4.size) {
        var_2 = sortbydistance(var_4, self.origin);
        self.var_AA25 = var_2[0];
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.25);
        if(isDefined(self.var_AA25) && isDefined(self.var_AA26) && self.var_AA26) {
          func_11375(self.var_AA25);
          self notify("blackhat_fired");
          func_2B2E();
        } else if(isDefined(self.var_AA25)) {
          self.var_AA25 dodamage(1000, self.var_AA25.origin, self, self, "MOD_IMPACT", "power_blackhat_mp");
          self notify("blackhat_fired");
          func_2B2E();
          scripts\mp\killstreaks\killstreaks::givescoreforblackhat();
        }
      }

      self.var_AA26 = 0;
      wait(0.1);
      scripts\mp\hostmigration::waittillhostmigrationdone();
      continue;
    }

    self notify("powers_blackhat_used", 0);
    break;
  }
}

func_11375(var_0) {}

func_11319(var_0) {
  var_1 = level.weaponconfigs["sticky_mine_mp"];
  var_0 scripts\mp\weapons::stopblinkinglight();
  var_0 thread scripts\mp\weapons::doblinkinglight("tag_fx", var_1.mine_beacon["friendly"], var_1.mine_beacon["enemy"]);
}

func_2B2A() {
  var_0 = self getentitynumber();
  level.mines[var_0] = self;
  level notify("mine_planted");
}

func_2B2C() {
  var_0 = undefined;
  if(isDefined(self)) {
    var_0 = self getentitynumber();
  }

  if(isDefined(var_0)) {
    level.mines[var_0] = undefined;
  }
}

func_E12A() {
  if(!isDefined(self.entityheadicon)) {
    return;
  }

  self.entityheadicon destroy();
}

func_7E94(var_0) {
  var_1 = func_2B28();
  if(var_1.size) {
    var_2 = var_1;
    return var_2;
  }

  return var_2;
}

func_2B28(var_0) {
  var_1 = [];
  var_2 = scripts\mp\utility::getotherteam(self.team);
  if(level.teambased) {
    if(isDefined(level.mines)) {
      foreach(var_4 in level.mines) {
        if(isDefined(var_4) && var_4.team != self.team || isDefined(var_4.owner) && var_4.owner != self) {
          self.var_AA26 = 1;
          var_1[var_1.size] = var_4;
        }
      }
    }

    if(isDefined(level.turrets)) {
      foreach(var_7 in level.turrets) {
        if(isDefined(var_7) && var_7.team != self.team || isDefined(var_7.owner) && var_7.owner != self) {
          var_1[var_1.size] = var_7;
        }
      }
    }

    if(isDefined(level.uavmodels)) {
      foreach(var_10 in level.uavmodels[var_2]) {
        if(isDefined(var_10) && var_10.team != self.team || isDefined(var_10.owner) && var_10.owner != self) {
          var_1[var_1.size] = var_10;
        }
      }
    }

    if(isDefined(level.chopper) && level.chopper.team != self.team || isDefined(level.chopper.owner) && level.chopper.owner != self) {
      var_1[var_1.size] = level.chopper;
    }

    if(isDefined(level.littlebirds)) {
      foreach(var_13 in level.littlebirds) {
        if(isDefined(var_13) && var_13.team != self.team || isDefined(var_13.owner) && var_13.owner != self) {
          var_1[var_1.size] = var_13;
        }
      }
    }

    if(isDefined(level.balldrones)) {
      foreach(var_10 in level.balldrones) {
        if(isDefined(var_10) && var_10.team != self.team || isDefined(var_10.owner) && var_10.owner != self) {
          var_1[var_1.size] = var_10;
        }
      }
    }

    if(isDefined(level.var_8B5F)) {
      foreach(var_13 in level.var_8B5F) {
        if(isDefined(var_13) && var_13.team != self.team || isDefined(var_13.owner) && var_13.owner != self) {
          var_1[var_1.size] = var_13;
        }
      }
    }

    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_16 in level.characters) {
        if(isDefined(var_16) && isalive(var_16) && var_16.team != self.team || isDefined(var_16.owner) && var_16.owner != self) {
          var_1[var_1.size] = var_16;
        }
      }
    }
  } else {
    if(isDefined(level.turrets)) {
      foreach(var_7 in level.turrets) {
        if(!isDefined(var_7)) {
          continue;
        }

        var_1[var_1.size] = var_7;
      }
    }

    if(isDefined(level.uavmodels)) {
      foreach(var_10 in level.uavmodels) {
        if(!isDefined(var_10)) {
          continue;
        }

        var_1[var_1.size] = var_10;
      }
    }

    if(isDefined(level.chopper)) {
      var_1[var_1.size] = level.chopper;
    }

    if(isDefined(level.littlebirds)) {
      foreach(var_13 in level.littlebirds) {
        if(!isDefined(var_13)) {
          continue;
        }

        var_1[var_1.size] = var_13;
      }
    }

    if(isDefined(level.balldrones)) {
      foreach(var_10 in level.balldrones) {
        if(!isDefined(var_10)) {
          continue;
        }

        var_1[var_1.size] = var_10;
      }
    }

    if(isDefined(level.var_8B5F)) {
      foreach(var_13 in level.var_8B5F) {
        if(!isDefined(var_13)) {
          continue;
        }

        var_1[var_1.size] = var_13;
      }
    }

    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_16 in level.characters) {
        if(!isDefined(var_16) || !isalive(var_16)) {
          continue;
        }

        var_1[var_1.size] = var_16;
      }
    }
  }

  return var_1;
}