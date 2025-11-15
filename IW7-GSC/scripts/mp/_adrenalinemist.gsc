/******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\_adrenalinemist.gsc
******************************************/

func_18A0() {
  level._effect["adrenaline_mist_friendly"] = loadfx("vfx\core\mp\equipment\vfx_adrenaline_device_mist_friend");
  level._effect["adrenaline_mist_enemy"] = loadfx("vfx\core\mp\equipment\vfx_adrenaline_device_mist_enemy");
  level._effect["adrenaline_mist_screen"] = loadfx("vfx\iw7\_requests\mp\vfx_adreno_fp_scrn");
}

func_18A5(param_00) {
  if(!isalive(self)) {
    param_00 delete();
    return;
  }

  if(self isonladder() || !self isonground() || self iswallrunning()) {
    param_00 delete();
    return;
  }

  param_00 hide();
  var_01 = self canplayerplacesentry(1, 12);
  if(var_01["result"]) {
    param_00.origin = var_01["origin"];
    param_00.angles = var_01["angles"];
  } else {
    param_00.origin = self.origin;
    param_00.angles = self.angles;
  }

  param_00 show();
  self playlocalsound("trophy_turret_plant_plr");
  self playsoundtoteam("trophy_turret_plant_npc", "allies", self);
  self playsoundtoteam("trophy_turret_plant_npc", "axis", self);
  var_02 = spawn("script_model", param_00.origin);
  var_02.angles = param_00.angles;
  var_02.team = self.team;
  var_02.triggerportableradarping = self;
  var_02 setModel("mp_trophy_system_iw6");
  var_02 thread func_189C(self);
  var_02 thread func_18A7();
  var_02 thread func_189D(self);
  var_02 thread func_18A3(self);
  var_02 thread scripts\mp\weapons::func_66B4();
  if(isDefined(param_00)) {
    param_00 delete();
  }

  var_02 thread scripts\mp\weapons::createbombsquadmodel("mp_trophy_system_iw6_bombsquad", "tag_origin", self);
  var_02 thread func_189B(self);
  var_02 thread func_18A1(45);
  if(level.teambased) {
    var_02 scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, 65));
  } else {
    var_02 scripts\mp\entityheadicons::setplayerheadicon(self, (0, 0, 65));
  }

  scripts\mp\weapons::ontacticalequipmentplanted(var_02, "power_adrenalineMist");
  var_02 thread func_CEA3();
}

func_189C(param_00) {
  scripts\mp\damage::monitordamage(100, "trophy", ::func_189F, ::func_18A2, 0);
}

func_189F(param_00, param_01, param_02, param_03) {
  if(isDefined(self.triggerportableradarping) && param_00 != self.triggerportableradarping) {
    param_00 scripts\mp\killstreaks\_killstreaks::_meth_83A0();
    param_00 notify("destroyed_equipment");
  }

  self notify("detonateExplosive");
}

func_18A2(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  var_05 = scripts\mp\damage::handlemeleedamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleempdamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(param_01, param_02, var_05);
  return var_05;
}

func_18A7() {
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

func_189D(param_00) {
  self endon("death");
  param_00 waittill("disconnect");
  self notify("detonateExplosive");
}

func_18A3(param_00) {
  self endon("disconnect");
  self endon("death");
  param_00 waittill("spawned_player");
  self notify("detonateExplosive");
}

func_18A6(param_00) {
  self endon("death");
  level endon("game_ended");
  param_00 endon("disconnect");
  param_00 endon("death");
  self.trigger setcursorhint("HINT_NOICON");
  self.trigger sethintstring( & "MP_PICKUP_ADRENALINE_MIST");
  self.trigger scripts\mp\utility::setselfusable(param_00);
  self.trigger thread scripts\mp\utility::notusableforjoiningplayers(param_00);
  for(;;) {
    self.trigger waittill("trigger", param_00);
    self stoploopsound();
    self scriptmodelclearanim();
    param_00 setweaponammoclip("adrenaline_mist_mp", 1);
    scripts\mp\weapons::deleteexplosive();
    self notify("death");
  }
}

func_18A1(param_00) {
  self endon("death");
  wait(param_00);
  self notify("detonateExplosive");
}

func_189B(param_00) {
  var_01 = spawn("trigger_radius", self.origin, 0, 150, 100);
  var_01 thread func_13992(param_00, self);
  var_01 thread func_1398E(self);
  var_01 thread func_13990(self);
  self.var_72FE = ::func_18A4;
  self.var_72F5 = ::func_189E;
  self.var_FCA3 = 40;
  foreach(var_03 in level.players) {
    if(!isDefined(var_03) || !scripts\mp\utility::isreallyalive(var_03)) {
      continue;
    }

    var_03 thread func_CEA4(self, self.origin);
  }
}

func_13992(param_00, param_01) {
  self endon("death");
  var_02 = 0;
  for(;;) {
    self waittill("trigger", var_03);
    if(var_03.team != param_00.team) {
      continue;
    }

    if(!isDefined(var_03.var_189A) || var_02 != param_01.var_FCA3) {
      if(var_02 != param_01.var_FCA3) {
        var_03 func_4193();
        var_03 notify("exit_adrenaline_mist");
      }

      var_03.var_189A = 1;
      var_03 scripts\mp\utility::func_F741(param_01.var_FCA3);
      var_02 = param_01.var_FCA3;
      if(isplayer(var_03)) {
        var_03.var_1894 = spawnfxforclient(scripts\engine\utility::getfx("adrenaline_mist_screen"), var_03 getEye(), var_03);
        triggerfx(var_03.var_1894);
        scripts\mp\gamescore::trackbuffassist(param_00, var_03, "adrenaline_mist_mp");
      }

      var_03 notify("enter_adrenaline_mist");
      var_03 setclientomnvar("ui_adrenaline_mist", 1);
      var_03 thread func_13B83(self, param_00);
      var_03 thread func_1398F(self);
      var_03 thread func_13A09(self);
    }
  }
}

func_13B83(param_00, param_01) {
  self endon("death");
  param_00 endon("death");
  for(;;) {
    if(isDefined(self)) {
      if(!self istouching(param_00)) {
        func_4193();
        self notify("exit_adrenaline_mist");
        scripts\mp\gamescore::untrackbuffassist(param_01, self, "adrenaline_mist_mp");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_1398F(param_00) {
  self endon("exit_adrenaline_mist");
  param_00 waittill("death");
  if(isDefined(self)) {
    func_4193();
  }
}

func_13A09(param_00) {
  self endon("exit_adrenaline_mist");
  param_00 endon("death");
  self waittill("death");
  if(isDefined(self)) {
    func_4193();
  }
}

func_4193() {
  if(isDefined(self.var_189A)) {
    self.var_189A = undefined;
    scripts\mp\utility::clearhealthshield();
    if(isDefined(self.var_1894)) {
      self.var_1894 delete();
    }

    self setclientomnvar("ui_adrenaline_mist", 0);
  }
}

func_1398E(param_00) {
  level endon("game_ended");
  param_00 waittill("death");
  if(isDefined(self)) {
    self delete();
  }
}

func_13990(param_00) {
  self endon("death");
  for(;;) {
    if(self.origin != param_00.origin) {
      self.origin = param_00.origin;
    }

    wait(0.5);
  }
}

func_CEA4(param_00, param_01) {
  param_00 endon("death");
  var_02 = undefined;
  var_03 = param_01;
  var_04 = 1;
  for(;;) {
    if(isDefined(param_00) && var_04) {
      if(self.team == param_00.team) {
        var_02 = spawnfxforclient(scripts\engine\utility::getfx("adrenaline_mist_friendly"), var_03, self);
      } else {
        var_02 = spawnfxforclient(scripts\engine\utility::getfx("adrenaline_mist_enemy"), var_03, self);
      }

      if(isDefined(var_02)) {
        triggerfx(var_02);
        var_02 thread func_1398E(param_00);
        thread func_13991(param_00, var_03, var_02, "disconnect", "spawned_player", 1);
        thread func_13991(param_00, var_03, var_02, undefined, "disconnect", 0);
      }

      var_04 = 0;
    }

    wait(0.5);
    if(var_03 != param_00.origin) {
      if(isDefined(var_02)) {
        var_02 delete();
      }

      var_03 = param_00.origin;
      self notify("adrenaline_mist_moved");
      var_04 = 1;
    }
  }
}

func_13991(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 endon("death");
  self endon("adrenaline_mist_moved");
  if(isDefined(param_03)) {
    self endon(param_03);
  }

  self waittill(param_04);
  if(isDefined(param_02)) {
    param_02 delete();
  }

  if(isDefined(param_05) && param_05) {
    thread func_CEA4(param_00, param_01);
  }
}

func_CEA3() {}

func_18A4() {
  self.var_FCA3 = 60;
}

func_189E() {
  self.var_FCA3 = 40;
}