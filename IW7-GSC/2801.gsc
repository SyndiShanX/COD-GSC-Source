/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2801.gsc
***************************************/

func_109B8() {
  level.func_109BE = [];
  level.func_109BE = scripts\engine\utility::add_to_array(level.func_109BE, "specialty_fastreload");
  level.func_109BE = scripts\engine\utility::add_to_array(level.func_109BE, "specialty_quickdraw");
  level.func_109BE = scripts\engine\utility::add_to_array(level.func_109BE, "specialty_quickswap");
}

func_109C1(var_00) {
  if(!isalive(self)) {
    var_00 delete();
    return;
  }

  var_00 waittill("missile_stuck", var_01);
  var_02 = self canplayerplacesentry(1, 12);
  var_03 = spawn("script_model", var_0.origin);
  var_3.angles = var_0.angles;
  var_3.team = self.team;
  var_3.owner = self;
  var_03 setModel("prop_mp_speed_strip_temp");
  var_03 thread func_109B4(self);
  var_03 thread func_109C3();
  var_03 thread func_109B5(self);
  var_03 thread func_109BF(self);
  var_03 thread scripts\mp\weapons::func_66B4();
  var_03 setotherent(self);
  var_03 scripts\mp\weapons::explosivehandlemovers(var_2["entity"], 1);

  if(isDefined(var_00)) {
    var_00 delete();
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

func_109B4(var_00) {
  scripts\mp\damage::monitordamage(100, "trophy", ::func_109B7, ::func_109BC, 0);
}

func_109B7(var_00, var_01, var_02, var_03) {
  if(isDefined(self.owner) && var_00 != self.owner) {
    var_00 scripts\mp\killstreaks\killstreaks::_meth_83A0();
    var_00 notify("destroyed_equipment");
  }

  self notify("detonateExplosive");
}

func_109BC(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_03;
  var_05 = scripts\mp\damage::handlemeleedamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handleempdamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(var_01, var_02, var_05);
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
  wait 3;

  if(isDefined(self)) {
    if(isDefined(self.killcament)) {
      self.killcament delete();
    }

    scripts\mp\weapons::equipmentdeletevfx();
    scripts\mp\weapons::deleteexplosive();
  }
}

func_109B5(var_00) {
  self endon("death");
  var_00 waittill("disconnect");
  self notify("detonateExplosive");
}

func_109BF(var_00) {
  self endon("disconnect");
  self endon("death");
  var_00 waittill("spawned_player");
  self notify("detonateExplosive");
}

func_109C2(var_00) {
  self endon("death");
  level endon("game_ended");
  var_00 endon("disconnect");
  var_00 endon("death");
  self.trigger setcursorhint("HINT_NOICON");
  self.trigger sethintstring(&"MP_PICKUP_SPEED_STRIP");
  self.trigger scripts\mp\utility\game::setselfusable(var_00);
  self.trigger thread scripts\mp\utility\game::notusableforjoiningplayers(var_00);

  for(;;) {
    self.trigger waittill("trigger", var_00);
    self stoploopsound();
    self scriptmodelclearanim();
    var_00 setweaponammoclip("speed_strip_mp", 1);
    scripts\mp\weapons::deleteexplosive();
    self notify("death");
  }
}

func_109B9(var_00) {
  self endon("death");
  wait(var_00);
  self notify("detonateExplosive");
}

func_109B3(var_00) {
  var_01 = spawn("trigger_rotatable_radius", self.origin, 0, 50, 100);
  var_1.angles = self.angles;
  var_01 thread func_13B54(var_00, self);
  var_01 thread func_13B4E(self, 1);
  var_01 thread func_13B51(self);
  self.func_72FE = ::func_109C0;
  self.func_72F5 = ::func_109B6;
  self.func_109AB = 5;

  foreach(var_03 in level.players) {
    if(!isDefined(var_03) || !scripts\mp\utility\game::isreallyalive(var_03)) {
      continue;
    }
    var_03 thread func_D534(self, self.origin);
  }
}

func_13B54(var_00, var_01) {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_02);

    if(var_2.team != var_0.team) {
      continue;
    }
    if(scripts\mp\equipment\charge_mode::func_3CEE(var_02)) {
      continue;
    }
    if(!isDefined(var_2.func_109B2)) {
      var_2.func_109B2 = 1;

      foreach(var_04 in level.func_109BE) {
        var_02 scripts\mp\utility\game::giveperk(var_04);
      }

      if(!(isDefined(var_2.powers) && var_02 scripts\mp\powers::hasequipment("power_speedBoost") && var_2.powers["power_speedBoost"].active)) {
        var_2.speedstripmod = 0.2;
        var_02 scripts\mp\weapons::updatemovespeedscale();
        var_02 thread func_13B53();
        var_2.func_109BD = var_00;
        scripts\mp\gamescore::trackbuffassist(var_00, var_02, "power_speedBoost");
      }

      if(isplayer(var_02)) {
        var_2.func_109A9 = spawnfxforclient(scripts\engine\utility::getfx("speed_strip_screen"), var_02 getEye(), var_02);
        triggerfx(var_2.func_109A9);
      }

      var_02 notify("speed_strip_start");
      var_02 thread func_13B50(var_1.func_109AB);
      var_02 thread func_13B86(self);
      var_02 thread func_13B4F();
    }
  }
}

func_13B86(var_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(isDefined(self)) {
      if(!isDefined(var_00) || !self istouching(var_00)) {
        self notify("start_speed_strip_linger");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_13B50(var_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self waittill("start_speed_strip_linger");
  wait(var_00);
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
  if(isDefined(self.func_109B2)) {
    self.func_109B2 = undefined;
    self.func_109BA = undefined;

    foreach(var_01 in level.func_109BE) {
      scripts\mp\utility\game::removeperk(var_01);
    }

    if(isDefined(self.speedstripmod)) {
      self.speedstripmod = undefined;
      scripts\mp\weapons::updatemovespeedscale();
      scripts\mp\gamescore::untrackbuffassist(self.func_109BD, self, "power_speedBoost");
      self.func_109BD = undefined;
    }

    if(isDefined(self.func_109A9)) {
      self.func_109A9 delete();
    }
  }
}

func_13B4E(var_00, var_01, var_02, var_03, var_04, var_05) {
  level endon("game_ended");

  if(isDefined(var_05)) {
    self endon(var_05);
  }

  var_00 waittill("death");

  if(isDefined(var_02)) {
    if(isDefined(var_03)) {
      switch (var_03) {
        case "player_linger":
          if(isplayer(self) && isDefined(self.func_109B2) && !isDefined(self.func_109BA)) {
            self notify(var_04);
            self.func_109BA = 1;
          }

          break;
      }
    }
  } else if(isDefined(var_04))
    self notify(var_04);

  if(isDefined(var_01)) {
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
    wait 1.5;
    var_00 = var_00 - 0.05;
    self.speedstripmod = var_00;
    scripts\mp\weapons::updatemovespeedscale();
  }
}

func_13B51(var_00) {
  self endon("death");

  for(;;) {
    if(self.origin != var_0.origin) {
      self.origin = var_0.origin;
    }

    wait 0.5;
  }
}

func_D534(var_00, var_01) {
  var_00 endon("death");
  var_02 = undefined;
  var_03 = var_01;
  var_04 = 1;

  for(;;) {
    if(isDefined(var_00) && var_04) {
      if(self.team == var_0.team) {
        var_02 = spawnfxforclient(scripts\engine\utility::getfx("speed_strip_friendly"), var_03, self, anglestoup(var_0.angles), anglesToForward(var_0.angles));
      } else {
        var_02 = spawnfxforclient(scripts\engine\utility::getfx("speed_strip_enemy"), var_03, self, anglestoup(var_0.angles), anglesToForward(var_0.angles));
      }

      if(isDefined(var_02)) {
        triggerfx(var_02);
        var_02 thread func_13B4E(var_00, 1);
        thread func_13B52(var_00, var_03, var_02, "disconnect", "spawned_player", 1);
        thread func_13B52(var_00, var_03, var_02, undefined, "disconnect", 0);
      }

      var_04 = 0;
    }

    wait 0.5;

    if(var_03 != var_0.origin) {
      if(isDefined(var_02)) {
        var_02 delete();
      }

      var_03 = var_0.origin;
      self notify("speed_strip_moved");
      var_04 = 1;
    }
  }
}

func_13B52(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_00 endon("death");
  self endon("speed_strip_moved");

  if(isDefined(var_03)) {
    self endon(var_03);
  }

  self waittill(var_04);

  if(isDefined(var_02)) {
    var_02 delete();
  }

  if(isDefined(var_05) && var_05) {
    thread func_D534(var_00, var_01);
  }
}

func_109C0() {
  self.func_109AB = 10;
}

func_109B6() {
  self.func_109AB = 5;
}