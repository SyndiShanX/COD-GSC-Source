/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\_adrenalinemist.gsc
*********************************************/

func_18A0() {
  level._effect["adrenaline_mist_friendly"] = loadfx("vfx\core\mp\equipment\vfx_adrenaline_device_mist_friend");
  level._effect["adrenaline_mist_enemy"] = loadfx("vfx\core\mp\equipment\vfx_adrenaline_device_mist_enemy");
  level._effect["adrenaline_mist_screen"] = loadfx("vfx\iw7\_requests\mp\vfx_adreno_fp_scrn");
}

func_18A5(var_0) {
  if(!isalive(self)) {
    var_0 delete();
    return;
  }

  if(self isonladder() || !self isonground() || self iswallrunning()) {
    var_0 delete();
    return;
  }

  var_0 hide();
  var_1 = self canplayerplacesentry(1, 12);
  if(var_1["result"]) {
    var_0.origin = var_1["origin"];
    var_0.angles = var_1["angles"];
  } else {
    var_0.origin = self.origin;
    var_0.angles = self.angles;
  }

  var_0 show();
  self playlocalsound("trophy_turret_plant_plr");
  self playsoundtoteam("trophy_turret_plant_npc", "allies", self);
  self playsoundtoteam("trophy_turret_plant_npc", "axis", self);
  var_2 = spawn("script_model", var_0.origin);
  var_2.angles = var_0.angles;
  var_2.team = self.team;
  var_2.owner = self;
  var_2 setModel("mp_trophy_system_iw6");
  var_2 thread func_189C(self);
  var_2 thread func_18A7();
  var_2 thread func_189D(self);
  var_2 thread func_18A3(self);
  var_2 thread scripts\mp\weapons::func_66B4();
  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_2 thread scripts\mp\weapons::createbombsquadmodel("mp_trophy_system_iw6_bombsquad", "tag_origin", self);
  var_2 thread func_189B(self);
  var_2 thread func_18A1(45);
  if(level.teambased) {
    var_2 scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, 65));
  } else {
    var_2 scripts\mp\entityheadicons::setplayerheadicon(self, (0, 0, 65));
  }

  scripts\mp\weapons::ontacticalequipmentplanted(var_2, "power_adrenalineMist");
  var_2 thread func_CEA3();
}

func_189C(var_0) {
  scripts\mp\damage::monitordamage(100, "trophy", ::func_189F, ::func_18A2, 0);
}

func_189F(var_0, var_1, var_2, var_3) {
  if(isDefined(self.owner) && var_0 != self.owner) {
    var_0 scripts\mp\killstreaks\killstreaks::func_83A0();
    var_0 notify("destroyed_equipment");
  }

  self notify("detonateExplosive");
}

func_18A2(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  var_5 = scripts\mp\damage::handlemeleedamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleempdamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);
  return var_5;
}

func_18A7() {
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

func_189D(var_0) {
  self endon("death");
  var_0 waittill("disconnect");
  self notify("detonateExplosive");
}

func_18A3(var_0) {
  self endon("disconnect");
  self endon("death");
  var_0 waittill("spawned_player");
  self notify("detonateExplosive");
}

func_18A6(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("death");
  self.trigger setcursorhint("HINT_NOICON");
  self.trigger sethintstring(&"MP_PICKUP_ADRENALINE_MIST");
  self.trigger scripts\mp\utility::setselfusable(var_0);
  self.trigger thread scripts\mp\utility::notusableforjoiningplayers(var_0);
  for(;;) {
    self.trigger waittill("trigger", var_0);
    self stoploopsound();
    self scriptmodelclearanim();
    var_0 setweaponammoclip("adrenaline_mist_mp", 1);
    scripts\mp\weapons::deleteexplosive();
    self notify("death");
  }
}

func_18A1(var_0) {
  self endon("death");
  wait(var_0);
  self notify("detonateExplosive");
}

func_189B(var_0) {
  var_1 = spawn("trigger_radius", self.origin, 0, 150, 100);
  var_1 thread func_13992(var_0, self);
  var_1 thread func_1398E(self);
  var_1 thread func_13990(self);
  self.var_72FE = ::func_18A4;
  self.var_72F5 = ::func_189E;
  self.var_FCA3 = 40;
  foreach(var_3 in level.players) {
    if(!isDefined(var_3) || !scripts\mp\utility::isreallyalive(var_3)) {
      continue;
    }

    var_3 thread func_CEA4(self, self.origin);
  }
}

func_13992(var_0, var_1) {
  self endon("death");
  var_2 = 0;
  for(;;) {
    self waittill("trigger", var_3);
    if(var_3.team != var_0.team) {
      continue;
    }

    if(!isDefined(var_3.var_189A) || var_2 != var_1.var_FCA3) {
      if(var_2 != var_1.var_FCA3) {
        var_3 func_4193();
        var_3 notify("exit_adrenaline_mist");
      }

      var_3.var_189A = 1;
      var_3 scripts\mp\utility::func_F741(var_1.var_FCA3);
      var_2 = var_1.var_FCA3;
      if(isplayer(var_3)) {
        var_3.var_1894 = spawnfxforclient(scripts\engine\utility::getfx("adrenaline_mist_screen"), var_3 getEye(), var_3);
        triggerfx(var_3.var_1894);
        scripts\mp\gamescore::trackbuffassist(var_0, var_3, "adrenaline_mist_mp");
      }

      var_3 notify("enter_adrenaline_mist");
      var_3 setclientomnvar("ui_adrenaline_mist", 1);
      var_3 thread func_13B83(self, var_0);
      var_3 thread func_1398F(self);
      var_3 thread func_13A09(self);
    }
  }
}

func_13B83(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  for(;;) {
    if(isDefined(self)) {
      if(!self istouching(var_0)) {
        func_4193();
        self notify("exit_adrenaline_mist");
        scripts\mp\gamescore::untrackbuffassist(var_1, self, "adrenaline_mist_mp");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_1398F(var_0) {
  self endon("exit_adrenaline_mist");
  var_0 waittill("death");
  if(isDefined(self)) {
    func_4193();
  }
}

func_13A09(var_0) {
  self endon("exit_adrenaline_mist");
  var_0 endon("death");
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

func_1398E(var_0) {
  level endon("game_ended");
  var_0 waittill("death");
  if(isDefined(self)) {
    self delete();
  }
}

func_13990(var_0) {
  self endon("death");
  for(;;) {
    if(self.origin != var_0.origin) {
      self.origin = var_0.origin;
    }

    wait(0.5);
  }
}

func_CEA4(var_0, var_1) {
  var_0 endon("death");
  var_2 = undefined;
  var_3 = var_1;
  var_4 = 1;
  for(;;) {
    if(isDefined(var_0) && var_4) {
      if(self.team == var_0.team) {
        var_2 = spawnfxforclient(scripts\engine\utility::getfx("adrenaline_mist_friendly"), var_3, self);
      } else {
        var_2 = spawnfxforclient(scripts\engine\utility::getfx("adrenaline_mist_enemy"), var_3, self);
      }

      if(isDefined(var_2)) {
        triggerfx(var_2);
        var_2 thread func_1398E(var_0);
        thread func_13991(var_0, var_3, var_2, "disconnect", "spawned_player", 1);
        thread func_13991(var_0, var_3, var_2, undefined, "disconnect", 0);
      }

      var_4 = 0;
    }

    wait(0.5);
    if(var_3 != var_0.origin) {
      if(isDefined(var_2)) {
        var_2 delete();
      }

      var_3 = var_0.origin;
      self notify("adrenaline_mist_moved");
      var_4 = 1;
    }
  }
}

func_13991(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  self endon("adrenaline_mist_moved");
  if(isDefined(var_3)) {
    self endon(var_3);
  }

  self waittill(var_4);
  if(isDefined(var_2)) {
    var_2 delete();
  }

  if(isDefined(var_5) && var_5) {
    thread func_CEA4(var_0, var_1);
  }
}

func_CEA3() {}

func_18A4() {
  self.var_FCA3 = 60;
}

func_189E() {
  self.var_FCA3 = 40;
}