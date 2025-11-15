/*********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
  var_00 = scripts\mp\powers::func_D735("power_blackhat");
  var_01 = 0;
  self playgestureviewmodel("ges_hack_lock_in", undefined, var_01, 0.5);
  for(;;) {
    if(!scripts\mp\powers::func_9F09(var_00)) {
      break;
    }

    if(scripts\mp\powers::func_9F09(var_00)) {
      thread func_2B2B(var_00);
      while(scripts\mp\powers::func_9F09(var_00)) {
        wait(0.05);
        if(!scripts\mp\powers::func_9F09(var_00)) {
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

func_2B2B(param_00) {
  self notify("using_blackhat");
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("blackhat_used");
  self endon("using_blackhat");
  var_01 = [];
  var_02 = [];
  var_03 = scripts\mp\powerloot::func_7FC4("power_blackhat", 20);
  for(;;) {
    if(scripts\mp\powers::func_9F09(param_00)) {
      var_04 = [];
      var_01 = func_7E94(self);
      foreach(var_06 in var_01) {
        var_07 = self worldpointinreticle_circle(var_06.origin, 65, var_03);
        if(var_07) {
          var_04[var_04.size] = var_06;
        }
      }

      if(var_04.size) {
        var_02 = sortbydistance(var_04, self.origin);
        self.var_AA25 = var_02[0];
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.25);
        if(isDefined(self.var_AA25) && isDefined(self.var_AA26) && self.var_AA26) {
          func_11375(self.var_AA25);
          self notify("blackhat_fired");
          func_2B2E();
        } else if(isDefined(self.var_AA25)) {
          self.var_AA25 dodamage(1000, self.var_AA25.origin, self, self, "MOD_IMPACT", "power_blackhat_mp");
          self notify("blackhat_fired");
          func_2B2E();
          scripts\mp\killstreaks\_killstreaks::givescoreforblackhat();
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

func_11375(param_00) {}

func_11319(param_00) {
  var_01 = level.weaponconfigs["sticky_mine_mp"];
  param_00 scripts\mp\weapons::stopblinkinglight();
  param_00 thread scripts\mp\weapons::doblinkinglight("tag_fx", var_01.mine_beacon["friendly"], var_01.mine_beacon["enemy"]);
}

func_2B2A() {
  var_00 = self getentitynumber();
  level.mines[var_00] = self;
  level notify("mine_planted");
}

func_2B2C() {
  var_00 = undefined;
  if(isDefined(self)) {
    var_00 = self getentitynumber();
  }

  if(isDefined(var_00)) {
    level.mines[var_00] = undefined;
  }
}

func_E12A() {
  if(!isDefined(self.entityheadicon)) {
    return;
  }

  self.entityheadicon destroy();
}

func_7E94(param_00) {
  var_01 = func_2B28();
  if(var_01.size) {
    var_02 = var_01;
    return var_02;
  }

  return var_02;
}

func_2B28(param_00) {
  var_01 = [];
  var_02 = scripts\mp\utility::getotherteam(self.team);
  if(level.teambased) {
    if(isDefined(level.mines)) {
      foreach(var_04 in level.mines) {
        if(isDefined(var_04) && var_04.team != self.team || isDefined(var_04.triggerportableradarping) && var_04.triggerportableradarping != self) {
          self.var_AA26 = 1;
          var_01[var_01.size] = var_04;
        }
      }
    }

    if(isDefined(level.turrets)) {
      foreach(var_07 in level.turrets) {
        if(isDefined(var_07) && var_07.team != self.team || isDefined(var_07.triggerportableradarping) && var_07.triggerportableradarping != self) {
          var_01[var_01.size] = var_07;
        }
      }
    }

    if(isDefined(level.uavmodels)) {
      foreach(var_0A in level.uavmodels[var_02]) {
        if(isDefined(var_0A) && var_0A.team != self.team || isDefined(var_0A.triggerportableradarping) && var_0A.triggerportableradarping != self) {
          var_01[var_01.size] = var_0A;
        }
      }
    }

    if(isDefined(level.chopper) && level.chopper.team != self.team || isDefined(level.chopper.triggerportableradarping) && level.chopper.triggerportableradarping != self) {
      var_01[var_01.size] = level.chopper;
    }

    if(isDefined(level.littlebirds)) {
      foreach(var_0D in level.littlebirds) {
        if(isDefined(var_0D) && var_0D.team != self.team || isDefined(var_0D.triggerportableradarping) && var_0D.triggerportableradarping != self) {
          var_01[var_01.size] = var_0D;
        }
      }
    }

    if(isDefined(level.balldrones)) {
      foreach(var_10 in level.balldrones) {
        if(isDefined(var_10) && var_10.team != self.team || isDefined(var_10.triggerportableradarping) && var_10.triggerportableradarping != self) {
          var_01[var_01.size] = var_10;
        }
      }
    }

    if(isDefined(level.var_8B5F)) {
      foreach(var_13 in level.var_8B5F) {
        if(isDefined(var_13) && var_13.team != self.team || isDefined(var_13.triggerportableradarping) && var_13.triggerportableradarping != self) {
          var_01[var_01.size] = var_13;
        }
      }
    }

    if(isDefined(param_00) && param_00 == 1) {
      foreach(var_16 in level.characters) {
        if(isDefined(var_16) && isalive(var_16) && var_16.team != self.team || isDefined(var_16.triggerportableradarping) && var_16.triggerportableradarping != self) {
          var_01[var_01.size] = var_16;
        }
      }
    }
  } else {
    if(isDefined(level.turrets)) {
      foreach(var_07 in level.turrets) {
        if(!isDefined(var_07)) {
          continue;
        }

        var_01[var_01.size] = var_07;
      }
    }

    if(isDefined(level.uavmodels)) {
      foreach(var_0A in level.uavmodels) {
        if(!isDefined(var_0A)) {
          continue;
        }

        var_01[var_01.size] = var_0A;
      }
    }

    if(isDefined(level.chopper)) {
      var_01[var_01.size] = level.chopper;
    }

    if(isDefined(level.littlebirds)) {
      foreach(var_0D in level.littlebirds) {
        if(!isDefined(var_0D)) {
          continue;
        }

        var_01[var_01.size] = var_0D;
      }
    }

    if(isDefined(level.balldrones)) {
      foreach(var_10 in level.balldrones) {
        if(!isDefined(var_10)) {
          continue;
        }

        var_01[var_01.size] = var_10;
      }
    }

    if(isDefined(level.var_8B5F)) {
      foreach(var_13 in level.var_8B5F) {
        if(!isDefined(var_13)) {
          continue;
        }

        var_01[var_01.size] = var_13;
      }
    }

    if(isDefined(param_00) && param_00 == 1) {
      foreach(var_16 in level.characters) {
        if(!isDefined(var_16) || !isalive(var_16)) {
          continue;
        }

        var_01[var_01.size] = var_16;
      }
    }
  }

  return var_01;
}