/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3511.gsc
***************************************/

init() {
  if(!isDefined(level.func_D671)) {
    level.func_D671 = [];
    level.generators = [];
  }
}

func_FB16(var_00) {
  var_01 = level.func_D671[var_00];
  self give_player_xp("flash");
  scripts\mp\utility\game::_giveweapon(var_1.weaponname, 0);
  self givestartammo(var_1.weaponname);

  if(!isDefined(self.func_522E)) {
    self.func_522E = [];
  }

  thread func_B9DE(var_00);
}

func_12D67(var_00) {
  self notify("end_monitorUse_" + var_00);
}

func_51B7(var_00, var_01) {
  if(!isDefined(var_00)) {
    return;
  }
  foreach(var_03 in level.players) {
    if(isDefined(var_03) && isDefined(var_3.ingame_cinematic_loop)) {
      var_3.ingame_cinematic_loop[var_01] = undefined;
    }
  }

  func_DEF2(var_00, var_01, undefined);
  var_00 notify("death");
  var_00 delete();
}

func_DEF2(var_00, var_01, var_02) {
  if(isDefined(var_02) && var_02) {
    self.func_522E[var_01] = var_00;
  }
  else {
    self.func_522E[var_01] = undefined;
    var_02 = undefined;
  }

  var_03 = level.generators[var_01];

  if(!isDefined(var_03)) {
    level.generators[var_01] = [];
    var_03 = level.generators[var_01];
  }

  var_04 = func_7F0C(var_00);
  var_3[var_04] = var_02;
}

func_B9DE(var_00) {
  self notify("end_monitorUse_" + var_00);
  self endon("end_monitorUse_" + var_00);
  self endon("disconnect");
  level endon("game_ended");
  var_01 = level.func_D671[var_00];

  for(;;) {
    self waittill("grenade_fire", var_02, var_03);

    if(var_03 == var_1.weaponname || var_03 == var_00) {
      if(!isalive(self)) {
        var_02 delete();
        return;
      }

      if(func_3E1B(var_02, var_1.func_CC26)) {
        var_04 = self.func_522E[var_00];

        if(isDefined(var_04)) {
          func_51B7(var_04, var_00);
        }

        var_05 = func_108EA(var_00, var_2.origin);
        var_06 = var_02 getlinkedparent();

        if(isDefined(var_06)) {
          var_05 linkto(var_06);
        }

        if(isDefined(var_02)) {
          var_02 delete();
        }

        continue;
      }

      self setweaponammostock(var_1.weaponname, self getweaponammostock("trophy_mp") + 1);
    }
  }
}

func_3E1B(var_00, var_01) {
  var_00 hide();
  var_00 waittill("missile_stuck", var_02);

  if(var_01 * var_01 < distancesquared(var_0.origin, self.origin)) {
    var_03 = bulletTrace(self.origin, self.origin - (0, 0, var_01), 0, self);

    if(var_3["fraction"] == 1) {
      var_00 delete();
      return 0;
    }

    var_0.origin = var_3["position"];
  }

  var_00 show();
  return 1;
}

func_108EA(var_00, var_01) {
  var_02 = level.func_D671[var_00];
  var_03 = spawn("script_model", var_01);
  var_3.health = var_2.health;
  var_3.team = self.team;
  var_3.owner = self;
  var_03 setCanDamage(1);
  var_03 setModel(var_2.placedmodel);

  if(level.teambased) {
    var_03 scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, var_2.func_8C79));
  }
  else {
    var_03 scripts\mp\entityheadicons::setplayerheadicon(self, (0, 0, var_2.func_8C79));
  }

  var_03 thread func_13AE2(self, var_00);
  var_03 thread func_139E5(self, var_00);
  var_03 thread func_13B9C(self, var_00);
  var_03 thread scripts\mp\utility\game::notusableforjoiningplayers(self);

  if(isDefined(var_2.ondeploycallback)) {
    var_03[[var_2.ondeploycallback]](self, var_00);
  }

  var_03 thread scripts\mp\weapons::createbombsquadmodel(var_2.bombsquadmodel, "tag_origin", self);
  func_DEF2(var_03, var_00, 1);
  wait 0.05;

  if(isDefined(var_03) && var_03 scripts\mp\utility\game::touchingbadtrigger()) {
    var_03 notify("death");
  }

  return var_03;
}

func_13AE2(var_00, var_01) {
  self endon("death");
  level endon("game_ended");

  if(scripts\mp\utility\game::bot_is_fireteam_mode()) {
    var_00 waittill("killstreak_disowned");
  }
  else {
    var_00 scripts\engine\utility::waittill_either("killstreak_disowned", "death");
  }

  var_00 thread func_51B7(self, var_01);
}

func_139E5(var_00, var_01) {
  self.func_773C = var_01;
  var_02 = level.func_D671[var_01];
  scripts\mp\damage::monitordamage(var_2.health, var_2.damagefeedback, ::handledeathdamage, ::modifydamage, 0);
}

modifydamage(var_00, var_01, var_02, var_03, var_04) {
  var_05 = var_03;
  var_05 = scripts\mp\damage::handlemeleedamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handleempdamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handlemissiledamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handlegrenadedamage(var_01, var_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(var_01, var_02, var_05);
  return var_05;
}

handledeathdamage(var_00, var_01, var_02) {
  var_03 = self.owner;
  var_04 = level.func_D671[self.func_773C];

  if(isDefined(var_03) && var_00 != var_03) {
    var_00 notify("destroyed_equipment");
  }

  if(isDefined(var_4.func_C4F1)) {
    var_03[[var_4.func_C4F1]](self, self.func_773C);
  }

  var_03 thread func_51B7(self, self.func_773C);
}

func_13B9C(var_00, var_01) {
  self endon("death");
  level endon("game_ended");
  var_00 endon("disconnect");
  var_02 = level.func_D671[var_01];
  self setcursorhint("HINT_NOICON");
  self sethintstring(var_2.usehintstring);
  scripts\mp\utility\game::setselfusable(var_00);

  for(;;) {
    self waittill("trigger", var_03);
    var_03 playlocalsound(var_2.func_130D9);

    if(var_03 getammocount(var_2.weaponname) == 0 && !var_03 scripts\mp\utility\game::isjuggernaut()) {
      var_03 func_FB16(var_01);
    }

    var_03 thread func_51B7(self, var_01);
  }
}

func_7737() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  var_00 = randomfloat(0.5);
  wait(var_00);
  self.ingame_cinematic_loop = [];

  for(;;) {
    wait 0.05;

    if(level.generators.size > 0 || self.ingame_cinematic_loop.size > 0) {
      foreach(var_02 in level.func_D671) {
      func_3DE7(var_2.func_773C);
      }
    }
  }
}

func_3DE7(var_00) {
  var_01 = level.generators[var_00];

  if(isDefined(var_01)) {
    var_02 = level.func_D671[var_00];
    var_03 = var_2.func_2044 * var_2.func_2044;
    var_04 = undefined;

    foreach(var_06 in var_01) {
      if(isDefined(var_06) && scripts\mp\utility\game::isreallyalive(var_06)) {
        if(level.teambased && func_B3E5(var_6.team, self.team, var_2.func_11589) || !level.teambased && func_B3E4(var_6.owner, self, var_2.func_11589)) {
          var_07 = distancesquared(var_6.origin, self.origin);

          if(var_07 < var_03) {
            var_04 = var_06;
            break;
          }
        }
      }
    }

    var_09 = isDefined(var_04);
    var_10 = isDefined(self.ingame_cinematic_loop[var_00]);

    if(var_09 && !var_10) {
      self[[var_2.func_C510]]();
    }
    else if(!var_09 && var_10) {
      self[[var_2.func_C51E]]();
    }

    self.ingame_cinematic_loop[var_00] = var_04;
  }
}

func_B3E5(var_00, var_01, var_02) {
  return var_02 == "all" || var_02 == "friendly" && var_00 == var_01 || var_02 == "enemy" && var_00 != var_01;
}

func_B3E4(var_00, var_01, var_02) {
  return var_02 == "all" || var_02 == "friendly" && var_00 == var_01 || var_02 == "enemy" && var_00 != var_01;
}

func_7F0C(var_00) {
  return var_0.owner.guid + var_0.birthtime;
}