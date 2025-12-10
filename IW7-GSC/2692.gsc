/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2692.gsc
***************************************/

func_18A0() {
  level._effect["adrenaline_mist_friendly"] = loadfx("vfx\core\mp\equipment\vfx_adrenaline_device_mist_friend");
  level._effect["adrenaline_mist_enemy"] = loadfx("vfx\core\mp\equipment\vfx_adrenaline_device_mist_enemy");
  level._effect["adrenaline_mist_screen"] = loadfx("vfx\iw7\_requests\mp\vfx_adreno_fp_scrn");
}

func_18A5(var_00) {
  if(!isalive(self)) {
    var_00 delete();
    return;
  }

  if(self isonladder() || !self isonground() || self iswallrunning()) {
    var_00 delete();
    return;
  }

  var_00 hide();
  var_01 = self canplayerplacesentry(1, 12);

  if(var_1["result"]) {
    var_0.origin = var_1["origin"];
    var_0.angles = var_1["angles"];
  } else {
    var_0.origin = self.origin;
    var_0.angles = self.angles;
  }

  var_00 show();
  self playlocalsound("trophy_turret_plant_plr");
  self playsoundtoteam("trophy_turret_plant_npc", "allies", self);
  self playsoundtoteam("trophy_turret_plant_npc", "axis", self);
  var_02 = spawn("script_model", var_0.origin);
  var_2.angles = var_0.angles;
  var_2.team = self.team;
  var_2.owner = self;
  var_02 setModel("mp_trophy_system_iw6");
  var_02 thread func_189C(self);
  var_02 thread func_18A7();
  var_02 thread func_189D(self);
  var_02 thread func_18A3(self);
  var_02 thread scripts\mp\weapons::func_66B4();

  if(isDefined(var_00))
    var_00 delete();

  var_02 thread scripts\mp\weapons::createbombsquadmodel("mp_trophy_system_iw6_bombsquad", "tag_origin", self);
  var_02 thread func_189B(self);
  var_02 thread func_18A1(45);

  if(level.teambased)
    var_02 scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, 65));
  else
    var_02 scripts\mp\entityheadicons::setplayerheadicon(self, (0, 0, 65));

  scripts\mp\weapons::ontacticalequipmentplanted(var_02, "power_adrenalineMist");
  var_02 thread func_CEA3();
}

func_189C(var_00) {
  scripts\mp\damage::monitordamage(100, "trophy", ::func_189F, ::func_18A2, 0);
}

func_189F(var_00, var_01, var_02, var_03) {
  if(isDefined(self.owner) && var_00 != self.owner) {
    var_00 scripts\mp\killstreaks\killstreaks::_meth_83A0();
    var_00 notify("destroyed_equipment");
  }

  self notify("detonateExplosive");
}

func_18A2(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_03;
  var_05 = scripts\mp\damage::handlemeleedamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handleempdamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(var_01, var_02, var_05);
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
  wait 3;

  if(isDefined(self)) {
    if(isDefined(self.killcament))
      self.killcament delete();

    scripts\mp\weapons::equipmentdeletevfx();
    scripts\mp\weapons::deleteexplosive();
  }
}

func_189D(var_00) {
  self endon("death");
  var_00 waittill("disconnect");
  self notify("detonateExplosive");
}

func_18A3(var_00) {
  self endon("disconnect");
  self endon("death");
  var_00 waittill("spawned_player");
  self notify("detonateExplosive");
}

func_18A6(var_00) {
  self endon("death");
  level endon("game_ended");
  var_00 endon("disconnect");
  var_00 endon("death");
  self.trigger setcursorhint("HINT_NOICON");
  self.trigger sethintstring(&"MP_PICKUP_ADRENALINE_MIST");
  self.trigger scripts\mp\utility\game::setselfusable(var_00);
  self.trigger thread scripts\mp\utility\game::notusableforjoiningplayers(var_00);

  for(;;) {
    self.trigger waittill("trigger", var_00);
    self stoploopsound();
    self scriptmodelclearanim();
    var_00 setweaponammoclip("adrenaline_mist_mp", 1);
    scripts\mp\weapons::deleteexplosive();
    self notify("death");
  }
}

func_18A1(var_00) {
  self endon("death");
  wait(var_00);
  self notify("detonateExplosive");
}

func_189B(var_00) {
  var_01 = spawn("trigger_radius", self.origin, 0, 150, 100);
  var_01 thread func_13992(var_00, self);
  var_01 thread func_1398E(self);
  var_01 thread func_13990(self);
  self.func_72FE = ::func_18A4;
  self.func_72F5 = ::func_189E;
  self.func_FCA3 = 40;

  foreach(var_03 in level.players) {
    if(!isDefined(var_03) || !scripts\mp\utility\game::isreallyalive(var_03)) {
      continue;
    }
    var_03 thread func_CEA4(self, self.origin);
  }
}

func_13992(var_00, var_01) {
  self endon("death");
  var_02 = 0;

  for(;;) {
    self waittill("trigger", var_03);

    if(var_3.team != var_0.team) {
      continue;
    }
    if(!isDefined(var_3.func_189A) || var_02 != var_1.func_FCA3) {
      if(var_02 != var_1.func_FCA3) {
        var_03 func_4193();
        var_03 notify("exit_adrenaline_mist");
      }

      var_3.func_189A = 1;
      var_03 scripts\mp\utility\game::func_F741(var_1.func_FCA3);
      var_02 = var_1.func_FCA3;

      if(isplayer(var_03)) {
        var_3.func_1894 = spawnfxforclient(scripts\engine\utility::getfx("adrenaline_mist_screen"), var_03 getEye(), var_03);
        triggerfx(var_3.func_1894);
        scripts\mp\gamescore::trackbuffassist(var_00, var_03, "adrenaline_mist_mp");
      }

      var_03 notify("enter_adrenaline_mist");
      var_03 setclientomnvar("ui_adrenaline_mist", 1);
      var_03 thread func_13B83(self, var_00);
      var_03 thread func_1398F(self);
      var_03 thread func_13A09(self);
    }
  }
}

func_13B83(var_00, var_01) {
  self endon("death");
  var_00 endon("death");

  for(;;) {
    if(isDefined(self)) {
      if(!self istouching(var_00)) {
        func_4193();
        self notify("exit_adrenaline_mist");
        scripts\mp\gamescore::untrackbuffassist(var_01, self, "adrenaline_mist_mp");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

func_1398F(var_00) {
  self endon("exit_adrenaline_mist");
  var_00 waittill("death");

  if(isDefined(self))
    func_4193();
}

func_13A09(var_00) {
  self endon("exit_adrenaline_mist");
  var_00 endon("death");
  self waittill("death");

  if(isDefined(self))
    func_4193();
}

func_4193() {
  if(isDefined(self.func_189A)) {
    self.func_189A = undefined;
    scripts\mp\utility\game::clearhealthshield();

    if(isDefined(self.func_1894))
      self.func_1894 delete();

    self setclientomnvar("ui_adrenaline_mist", 0);
  }
}

func_1398E(var_00) {
  level endon("game_ended");
  var_00 waittill("death");

  if(isDefined(self))
    self delete();
}

func_13990(var_00) {
  self endon("death");

  for(;;) {
    if(self.origin != var_0.origin)
      self.origin = var_0.origin;

    wait 0.5;
  }
}

func_CEA4(var_00, var_01) {
  var_00 endon("death");
  var_02 = undefined;
  var_03 = var_01;
  var_04 = 1;

  for(;;) {
    if(isDefined(var_00) && var_04) {
      if(self.team == var_0.team)
        var_02 = spawnfxforclient(scripts\engine\utility::getfx("adrenaline_mist_friendly"), var_03, self);
      else
        var_02 = spawnfxforclient(scripts\engine\utility::getfx("adrenaline_mist_enemy"), var_03, self);

      if(isDefined(var_02)) {
        triggerfx(var_02);
        var_02 thread func_1398E(var_00);
        thread func_13991(var_00, var_03, var_02, "disconnect", "spawned_player", 1);
        thread func_13991(var_00, var_03, var_02, undefined, "disconnect", 0);
      }

      var_04 = 0;
    }

    wait 0.5;

    if(var_03 != var_0.origin) {
      if(isDefined(var_02))
        var_02 delete();

      var_03 = var_0.origin;
      self notify("adrenaline_mist_moved");
      var_04 = 1;
    }
  }
}

func_13991(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_00 endon("death");
  self endon("adrenaline_mist_moved");

  if(isDefined(var_03))
    self endon(var_03);

  self waittill(var_04);

  if(isDefined(var_02))
    var_02 delete();

  if(isDefined(var_05) && var_05)
    thread func_CEA4(var_00, var_01);
}

func_CEA3() {}

func_18A4() {
  self.func_FCA3 = 60;
}

func_189E() {
  self.func_FCA3 = 40;
}