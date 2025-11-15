/*************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\speedstrip.gsc
*************************************/

func_109B8() {
  level.var_109BE = [];
  level.var_109BE = scripts\engine\utility::array_add_safe(level.var_109BE, "specialty_fastreload");
  level.var_109BE = scripts\engine\utility::array_add_safe(level.var_109BE, "specialty_quickdraw");
  level.var_109BE = scripts\engine\utility::array_add_safe(level.var_109BE, "specialty_quickswap");
}

func_109C1(param_00) {
  if(!isalive(self)) {
    param_00 delete();
    return;
  }

  param_00 waittill("missile_stuck", var_01);
  var_02 = self canplayerplacesentry(1, 12);
  var_03 = spawn("script_model", param_00.origin);
  var_03.angles = param_00.angles;
  var_03.team = self.team;
  var_03.triggerportableradarping = self;
  var_03 setModel("prop_mp_speed_strip_temp");
  var_03 thread func_109B4(self);
  var_03 thread func_109C3();
  var_03 thread func_109B5(self);
  var_03 thread func_109BF(self);
  var_03 thread scripts\mp\weapons::func_66B4();
  var_03 setotherent(self);
  var_03 scripts\mp\weapons::explosivehandlemovers(var_02["entity"], 1);
  if(isDefined(param_00)) {
    param_00 delete();
  }

  var_03 thread func_109B3(self);
  var_03 thread func_109B9(45);
  if(isDefined(var_01)) {
    var_03 scripts\mp\weapons::explosivehandlemovers(var_01, 1);
  }

  if(level.teambased) {
    var_03 scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, 40));
  } else {
    var_03 scripts\mp\entityheadicons::setplayerheadicon(self, (0, 0, 40));
  }

  scripts\mp\weapons::ontacticalequipmentplanted(var_03, "power_speedStrip");
}

func_109B4(param_00) {
  scripts\mp\damage::monitordamage(100, "trophy", ::func_109B7, ::func_109BC, 0);
}

func_109B7(param_00, param_01, param_02, param_03) {
  if(isDefined(self.triggerportableradarping) && param_00 != self.triggerportableradarping) {
    param_00 scripts\mp\killstreaks\_killstreaks::_meth_83A0();
    param_00 notify("destroyed_equipment");
  }

  self notify("detonateExplosive");
}

func_109BC(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  var_05 = scripts\mp\damage::handlemeleedamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleempdamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(param_01, param_02, var_05);
  return var_05;
}

func_109C3() {
  level endon("game_ended");
  self waittill("detonateExplosive");
  self scriptmodelclearanim();
  self stoploopsound();
  scripts\mp\weapons::equipmentdeathvfx();
  self notify("death");
  var_00 = self.origin;
  wait(3);
  if(isDefined(self)) {
    if(isDefined(self.killcament)) {
      self.killcament delete();
    }

    scripts\mp\weapons::equipmentdeletevfx();
    scripts\mp\weapons::deleteexplosive();
  }
}

func_109B5(param_00) {
  self endon("death");
  param_00 waittill("disconnect");
  self notify("detonateExplosive");
}

func_109BF(param_00) {
  self endon("disconnect");
  self endon("death");
  param_00 waittill("spawned_player");
  self notify("detonateExplosive");
}

func_109C2(param_00) {
  self endon("death");
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("death");
  self.trigger setcursorhint("HINT_NOICON");
  self.trigger sethintstring( & "MP_PICKUP_SPEED_STRIP");
  self.trigger scripts\mp\utility::setselfusable(param_00);
  self.trigger thread scripts\mp\utility::notusableforjoiningplayers(param_00);
  for(;;) {
    self.trigger waittill("trigger", param_00);
    self stoploopsound();
    self scriptmodelclearanim();
    param_00 setweaponammoclip("speed_strip_mp", 1);
    scripts\mp\weapons::deleteexplosive();
    self notify("death");
  }
}

func_109B9(param_00) {
  self endon("death");
  wait(param_00);
  self notify("detonateExplosive");
}

func_109B3(param_00) {
  var_01 = spawn("trigger_rotatable_radius", self.origin, 0, 50, 100);
  var_01.angles = self.angles;
  var_01 thread func_13B54(param_00, self);
  var_01 thread func_13B4E(self, 1);
  var_01 thread func_13B51(self);
  self.var_72FE = ::func_109C0;
  self.var_72F5 = ::func_109B6;
  self.var_109AB = 5;
  foreach(var_03 in level.players) {
    if(!isDefined(var_03) || !scripts\mp\utility::isreallyalive(var_03)) {
      continue;
    }

    var_03 thread func_D534(self, self.origin);
  }
}

func_13B54(param_00, param_01) {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_02);
    if(var_02.team != param_00.team) {
      continue;
    }

    if(scripts\mp\equipment\charge_mode::func_3CEE(var_02)) {
      continue;
    }

    if(!isDefined(var_02.var_109B2)) {
      var_02.var_109B2 = 1;
      foreach(var_04 in level.var_109BE) {
        var_02 scripts\mp\utility::giveperk(var_04);
      }

      if(!isDefined(var_02.powers) && var_02 scripts\mp\powers::hasequipment("power_speedBoost") && var_02.powers["power_speedBoost"].var_19) {
        var_02.speedstripmod = 0.2;
        var_02 scripts\mp\weapons::updatemovespeedscale();
        var_02 thread func_13B53();
        var_02.var_109BD = param_00;
        scripts\mp\gamescore::trackbuffassist(param_00, var_02, "power_speedBoost");
      }

      if(isplayer(var_02)) {
        var_02.var_109A9 = spawnfxforclient(scripts\engine\utility::getfx("speed_strip_screen"), var_02 getEye(), var_02);
        triggerfx(var_02.var_109A9);
      }

      var_02 notify("speed_strip_start");
      var_02 thread func_13B50(param_01.var_109AB);
      var_02 thread func_13B86(self);
      var_02 thread func_13B4F();
    }
  }
}

func_13B86(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    if(isDefined(self)) {
      if(!isDefined(param_00) || !self istouching(param_00)) {
        self notify("start_speed_strip_linger");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_13B50(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("start_speed_strip_linger");
  wait(param_00);
  self notify("speed_strip_end");
}

func_13B4F() {
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("speed_strip_end", "death", "disconnect");
  if(isDefined(self)) {
    func_41E0();
  }
}

func_41E0() {
  if(isDefined(self.var_109B2)) {
    self.var_109B2 = undefined;
    self.var_109BA = undefined;
    foreach(var_01 in level.var_109BE) {
      scripts\mp\utility::removeperk(var_01);
    }

    if(isDefined(self.speedstripmod)) {
      self.speedstripmod = undefined;
      scripts\mp\weapons::updatemovespeedscale();
      scripts\mp\gamescore::untrackbuffassist(self.var_109BD, self, "power_speedBoost");
      self.var_109BD = undefined;
    }

    if(isDefined(self.var_109A9)) {
      self.var_109A9 delete();
    }
  }
}

func_13B4E(param_00, param_01, param_02, param_03, param_04, param_05) {
  level endon("game_ended");
  if(isDefined(param_05)) {
    self endon(param_05);
  }

  param_00 waittill("death");
  if(isDefined(param_02)) {
    if(isDefined(param_03)) {
      switch (param_03) {
        case "player_linger":
          if(isplayer(self) && isDefined(self.var_109B2) && !isDefined(self.var_109BA)) {
            self notify(param_04);
            self.var_109BA = 1;
          }
          break;
      }
    }
  } else if(isDefined(param_04)) {
    self notify(param_04);
  }

  if(isDefined(param_01)) {
    if(isDefined(self)) {
      self delete();
    }
  }
}

func_13B53() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_00 = 0.2;
  var_01 = 0.1;
  while(var_00 >= var_01) {
    wait(1.5);
    var_00 = var_00 - 0.05;
    self.speedstripmod = var_00;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

func_13B51(param_00) {
  self endon("death");
  for(;;) {
    if(self.origin != param_00.origin) {
      self.origin = param_00.origin;
    }

    wait(0.5);
  }
}

func_D534(param_00, param_01) {
  param_00 endon("death");
  var_02 = undefined;
  var_03 = param_01;
  var_04 = 1;
  for(;;) {
    if(isDefined(param_00) && var_04) {
      if(self.team == param_00.team) {
        var_02 = spawnfxforclient(scripts\engine\utility::getfx("speed_strip_friendly"), var_03, self, anglestoup(param_00.angles), anglesToForward(param_00.angles));
      } else {
        var_02 = spawnfxforclient(scripts\engine\utility::getfx("speed_strip_enemy"), var_03, self, anglestoup(param_00.angles), anglesToForward(param_00.angles));
      }

      if(isDefined(var_02)) {
        triggerfx(var_02);
        var_02 thread func_13B4E(param_00, 1);
        thread func_13B52(param_00, var_03, var_02, "disconnect", "spawned_player", 1);
        thread func_13B52(param_00, var_03, var_02, undefined, "disconnect", 0);
      }

      var_04 = 0;
    }

    wait(0.5);
    if(var_03 != param_00.origin) {
      if(isDefined(var_02)) {
        var_02 delete();
      }

      var_03 = param_00.origin;
      self notify("speed_strip_moved");
      var_04 = 1;
    }
  }
}

func_13B52(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 endon("death");
  self endon("speed_strip_moved");
  if(isDefined(param_03)) {
    self endon(param_03);
  }

  self waittill(param_04);
  if(isDefined(param_02)) {
    param_02 delete();
  }

  if(isDefined(param_05) && param_05) {
    thread func_D534(param_00, param_01);
  }
}

func_109C0() {
  self.var_109AB = 10;
}

func_109B6() {
  self.var_109AB = 5;
}