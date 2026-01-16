/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\speedstrip.gsc
*********************************************/

func_109B8() {
  level.var_109BE = [];
  level.var_109BE = scripts\engine\utility::add_to_array(level.var_109BE, "specialty_fastreload");
  level.var_109BE = scripts\engine\utility::add_to_array(level.var_109BE, "specialty_quickdraw");
  level.var_109BE = scripts\engine\utility::add_to_array(level.var_109BE, "specialty_quickswap");
}

func_109C1(var_0) {
  if(!isalive(self)) {
    var_0 delete();
    return;
  }

  var_0 waittill("missile_stuck", var_1);
  var_2 = self canplayerplacesentry(1, 12);
  var_3 = spawn("script_model", var_0.origin);
  var_3.angles = var_0.angles;
  var_3.team = self.team;
  var_3.owner = self;
  var_3 setModel("prop_mp_speed_strip_temp");
  var_3 thread func_109B4(self);
  var_3 thread func_109C3();
  var_3 thread func_109B5(self);
  var_3 thread func_109BF(self);
  var_3 thread scripts\mp\weapons::func_66B4();
  var_3 setotherent(self);
  var_3 scripts\mp\weapons::explosivehandlemovers(var_2["entity"], 1);
  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_3 thread func_109B3(self);
  var_3 thread func_109B9(45);
  if(isDefined(var_1)) {
    var_3 scripts\mp\weapons::explosivehandlemovers(var_1, 1);
  }

  if(level.teambased) {
    var_3 scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, 40));
  } else {
    var_3 scripts\mp\entityheadicons::setplayerheadicon(self, (0, 0, 40));
  }

  scripts\mp\weapons::ontacticalequipmentplanted(var_3, "power_speedStrip");
}

func_109B4(var_0) {
  scripts\mp\damage::monitordamage(100, "trophy", ::func_109B7, ::func_109BC, 0);
}

func_109B7(var_0, var_1, var_2, var_3) {
  if(isDefined(self.owner) && var_0 != self.owner) {
    var_0 scripts\mp\killstreaks\killstreaks::func_83A0();
    var_0 notify("destroyed_equipment");
  }

  self notify("detonateExplosive");
}

func_109BC(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  var_5 = scripts\mp\damage::handlemeleedamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleempdamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);
  return var_5;
}

func_109C3() {
  level endon("game_ended");
  self waittill("detonateExplosive");
  self scriptmodelclearanim();
  self stoploopsound();
  scripts\mp\weapons::equipmentdeathvfx();
  self notify("death");
  var_0 = self.origin;
  wait(3);
  if(isDefined(self)) {
    if(isDefined(self.killcament)) {
      self.killcament delete();
    }

    scripts\mp\weapons::equipmentdeletevfx();
    scripts\mp\weapons::deleteexplosive();
  }
}

func_109B5(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  self notify("detonateExplosive");
}

func_109BF(var_0) {
  self endon("disconnect");
  self endon("death");
  var_0 waittill("spawned_player");
  self notify("detonateExplosive");
}

func_109C2(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  self.trigger setcursorhint("HINT_NOICON");
  self.trigger sethintstring(&"MP_PICKUP_SPEED_STRIP");
  self.trigger scripts\mp\utility::setselfusable(var_0);
  self.trigger thread scripts\mp\utility::notusableforjoiningplayers(var_0);
  for(;;) {
    self.trigger waittill("trigger", var_0);
    self stoploopsound();
    self scriptmodelclearanim();
    var_0 setweaponammoclip("speed_strip_mp", 1);
    scripts\mp\weapons::deleteexplosive();
    self notify("death");
  }
}

func_109B9(var_0) {
  self endon("death");
  wait(var_0);
  self notify("detonateExplosive");
}

func_109B3(var_0) {
  var_1 = spawn("trigger_rotatable_radius", self.origin, 0, 50, 100);
  var_1.angles = self.angles;
  var_1 thread func_13B54(var_0, self);
  var_1 thread func_13B4E(self, 1);
  var_1 thread func_13B51(self);
  self.var_72FE = ::func_109C0;
  self.var_72F5 = ::func_109B6;
  self.var_109AB = 5;
  foreach(var_3 in level.players) {
    if(!isDefined(var_3) || !scripts\mp\utility::isreallyalive(var_3)) {
      continue;
    }

    var_3 thread func_D534(self, self.origin);
  }
}

func_13B54(var_0, var_1) {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_2);
    if(var_2.team != var_0.team) {
      continue;
    }

    if(scripts\mp\equipment\charge_mode::func_3CEE(var_2)) {
      continue;
    }

    if(!isDefined(var_2.var_109B2)) {
      var_2.var_109B2 = 1;
      foreach(var_4 in level.var_109BE) {
        var_2 scripts\mp\utility::giveperk(var_4);
      }

      if(!isDefined(var_2.powers) && var_2 scripts\mp\powers::hasequipment("power_speedBoost") && var_2.powers["power_speedBoost"].var_19) {
        var_2.speedstripmod = 0.2;
        var_2 scripts\mp\weapons::updatemovespeedscale();
        var_2 thread func_13B53();
        var_2.var_109BD = var_0;
        scripts\mp\gamescore::trackbuffassist(var_0, var_2, "power_speedBoost");
      }

      if(isplayer(var_2)) {
        var_2.var_109A9 = spawnfxforclient(scripts\engine\utility::getfx("speed_strip_screen"), var_2 getEye(), var_2);
        triggerfx(var_2.var_109A9);
      }

      var_2 notify("speed_strip_start");
      var_2 thread func_13B50(var_1.var_109AB);
      var_2 thread func_13B86(self);
      var_2 thread func_13B4F();
    }
  }
}

func_13B86(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    if(isDefined(self)) {
      if(!isDefined(var_0) || !self istouching(var_0)) {
        self notify("start_speed_strip_linger");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_13B50(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("start_speed_strip_linger");
  wait(var_0);
  self notify("speed_strip_end");
}

func_13B4F() {
  level endon("game_ended");
  scripts\engine\utility::waittill_any("speed_strip_end", "death", "disconnect");
  if(isDefined(self)) {
    func_41E0();
  }
}

func_41E0() {
  if(isDefined(self.var_109B2)) {
    self.var_109B2 = undefined;
    self.var_109BA = undefined;
    foreach(var_1 in level.var_109BE) {
      scripts\mp\utility::removeperk(var_1);
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

func_13B4E(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  if(isDefined(var_5)) {
    self endon(var_5);
  }

  var_0 waittill("death");
  if(isDefined(var_2)) {
    if(isDefined(var_3)) {
      switch (var_3) {
        case "player_linger":
          if(isplayer(self) && isDefined(self.var_109B2) && !isDefined(self.var_109BA)) {
            self notify(var_4);
            self.var_109BA = 1;
          }
          break;
      }
    }
  } else if(isDefined(var_4)) {
    self notify(var_4);
  }

  if(isDefined(var_1)) {
    if(isDefined(self)) {
      self delete();
    }
  }
}

func_13B53() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = 0.2;
  var_1 = 0.1;
  while(var_0 >= var_1) {
    wait(1.5);
    var_0 = var_0 - 0.05;
    self.speedstripmod = var_0;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

func_13B51(var_0) {
  self endon("death");
  for(;;) {
    if(self.origin != var_0.origin) {
      self.origin = var_0.origin;
    }

    wait(0.5);
  }
}

func_D534(var_0, var_1) {
  var_0 endon("death");
  var_2 = undefined;
  var_3 = var_1;
  var_4 = 1;
  for(;;) {
    if(isDefined(var_0) && var_4) {
      if(self.team == var_0.team) {
        var_2 = spawnfxforclient(scripts\engine\utility::getfx("speed_strip_friendly"), var_3, self, anglestoup(var_0.angles), anglesToForward(var_0.angles));
      } else {
        var_2 = spawnfxforclient(scripts\engine\utility::getfx("speed_strip_enemy"), var_3, self, anglestoup(var_0.angles), anglesToForward(var_0.angles));
      }

      if(isDefined(var_2)) {
        triggerfx(var_2);
        var_2 thread func_13B4E(var_0, 1);
        thread func_13B52(var_0, var_3, var_2, "disconnect", "spawned_player", 1);
        thread func_13B52(var_0, var_3, var_2, undefined, "disconnect", 0);
      }

      var_4 = 0;
    }

    wait(0.5);
    if(var_3 != var_0.origin) {
      if(isDefined(var_2)) {
        var_2 delete();
      }

      var_3 = var_0.origin;
      self notify("speed_strip_moved");
      var_4 = 1;
    }
  }
}

func_13B52(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  self endon("speed_strip_moved");
  if(isDefined(var_3)) {
    self endon(var_3);
  }

  self waittill(var_4);
  if(isDefined(var_2)) {
    var_2 delete();
  }

  if(isDefined(var_5) && var_5) {
    thread func_D534(var_0, var_1);
  }
}

func_109C0() {
  self.var_109AB = 10;
}

func_109B6() {
  self.var_109AB = 5;
}