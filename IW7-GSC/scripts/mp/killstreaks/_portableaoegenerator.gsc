/************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_portableaoegenerator.gsc
************************************************************/

init() {
  if(!isDefined(level.var_D671)) {
    level.var_D671 = [];
    level.generators = [];
  }
}

func_FB16(param_00) {
  var_01 = level.var_D671[param_00];
  self give_player_xp("flash");
  scripts\mp\utility::_giveweapon(var_01.var_39C, 0);
  self givestartammo(var_01.var_39C);
  if(!isDefined(self.var_522E)) {
    self.var_522E = [];
  }

  thread func_B9DE(param_00);
}

func_12D67(param_00) {
  self notify("end_monitorUse_" + param_00);
}

func_51B7(param_00, param_01) {
  if(!isDefined(param_00)) {
    return;
  }

  foreach(var_03 in level.players) {
    if(isDefined(var_03) && isDefined(var_03.ingame_cinematic_loop)) {
      var_03.ingame_cinematic_loop[param_01] = undefined;
    }
  }

  func_DEF2(param_00, param_01, undefined);
  param_00 notify("death");
  param_00 delete();
}

func_DEF2(param_00, param_01, param_02) {
  if(isDefined(param_02) && param_02) {
    self.var_522E[param_01] = param_00;
  } else {
    self.var_522E[param_01] = undefined;
    param_02 = undefined;
  }

  var_03 = level.generators[param_01];
  if(!isDefined(var_03)) {
    level.generators[param_01] = [];
    var_03 = level.generators[param_01];
  }

  var_04 = func_7F0C(param_00);
  var_03[var_04] = param_02;
}

func_B9DE(param_00) {
  self notify("end_monitorUse_" + param_00);
  self endon("end_monitorUse_" + param_00);
  self endon("disconnect");
  level endon("game_ended");
  var_01 = level.var_D671[param_00];
  for(;;) {
    self waittill("grenade_fire", var_02, var_03);
    if(var_03 == var_01.var_39C || var_03 == param_00) {
      if(!isalive(self)) {
        var_02 delete();
        return;
      }

      if(func_3E1B(var_02, var_01.var_CC26)) {
        var_04 = self.var_522E[param_00];
        if(isDefined(var_04)) {
          func_51B7(var_04, param_00);
        }

        var_05 = func_108EA(param_00, var_02.origin);
        var_06 = var_02 getlinkedparent();
        if(isDefined(var_06)) {
          var_05 linkto(var_06);
        }

        if(isDefined(var_02)) {
          var_02 delete();
        }

        continue;
      }

      self setweaponammostock(var_01.var_39C, self getweaponammostock("trophy_mp") + 1);
    }
  }
}

func_3E1B(param_00, param_01) {
  param_00 hide();
  param_00 waittill("missile_stuck", var_02);
  if(param_01 * param_01 < distancesquared(param_00.origin, self.origin)) {
    var_03 = bulletTrace(self.origin, self.origin - (0, 0, param_01), 0, self);
    if(var_03["fraction"] == 1) {
      param_00 delete();
      return 0;
    }

    param_00.origin = var_03["position"];
  }

  param_00 show();
  return 1;
}

func_108EA(param_00, param_01) {
  var_02 = level.var_D671[param_00];
  var_03 = spawn("script_model", param_01);
  var_03.health = var_02.health;
  var_03.team = self.team;
  var_03.triggerportableradarping = self;
  var_03 setCanDamage(1);
  var_03 setModel(var_02.placedmodel);
  if(level.teambased) {
    var_03 scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, var_02.var_8C79));
  } else {
    var_03 scripts\mp\entityheadicons::setplayerheadicon(self, (0, 0, var_02.var_8C79));
  }

  var_03 thread func_13AE2(self, param_00);
  var_03 thread func_139E5(self, param_00);
  var_03 thread func_13B9C(self, param_00);
  var_03 thread scripts\mp\utility::notusableforjoiningplayers(self);
  if(isDefined(var_02.ondeploycallback)) {
    var_03[[var_02.ondeploycallback]](self, param_00);
  }

  var_03 thread scripts\mp\weapons::createbombsquadmodel(var_02.bombsquadmodel, "tag_origin", self);
  func_DEF2(var_03, param_00, 1);
  wait(0.05);
  if(isDefined(var_03) && var_03 scripts\mp\utility::touchingbadtrigger()) {
    var_03 notify("death");
  }

  return var_03;
}

func_13AE2(param_00, param_01) {
  self endon("death");
  level endon("game_ended");
  if(scripts\mp\utility::bot_is_fireteam_mode()) {
    param_00 waittill("killstreak_disowned");
  } else {
    param_00 scripts\engine\utility::waittill_either("killstreak_disowned", "death");
  }

  param_00 thread func_51B7(self, param_01);
}

func_139E5(param_00, param_01) {
  self.var_773C = param_01;
  var_02 = level.var_D671[param_01];
  scripts\mp\damage::monitordamage(var_02.health, var_02.damagefeedback, ::handledeathdamage, ::modifydamage, 0);
}

modifydamage(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  var_05 = scripts\mp\damage::handlemeleedamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleempdamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handlemissiledamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handlegrenadedamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(param_01, param_02, var_05);
  return var_05;
}

handledeathdamage(param_00, param_01, param_02) {
  var_03 = self.triggerportableradarping;
  var_04 = level.var_D671[self.var_773C];
  if(isDefined(var_03) && param_00 != var_03) {
    param_00 notify("destroyed_equipment");
  }

  if(isDefined(var_04.var_C4F1)) {
    var_03[[var_04.var_C4F1]](self, self.var_773C);
  }

  var_03 thread func_51B7(self, self.var_773C);
}

func_13B9C(param_00, param_01) {
  self endon("death");
  level endon("game_ended");
  param_00 endon("disconnect");
  var_02 = level.var_D671[param_01];
  self setcursorhint("HINT_NOICON");
  self sethintstring(var_02.usehintstring);
  scripts\mp\utility::setselfusable(param_00);
  for(;;) {
    self waittill("trigger", var_03);
    var_03 playlocalsound(var_02.var_130D9);
    if(var_03 getrunningforwardpainanim(var_02.var_39C) == 0 && !var_03 scripts\mp\utility::isjuggernaut()) {
      var_03 func_FB16(param_01);
    }

    var_03 thread func_51B7(self, param_01);
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
    wait(0.05);
    if(level.generators.size > 0 || self.ingame_cinematic_loop.size > 0) {
      foreach(var_02 in level.var_D671) {
        func_3DE7(var_02.var_773C);
      }
    }
  }
}

func_3DE7(param_00) {
  var_01 = level.generators[param_00];
  if(isDefined(var_01)) {
    var_02 = level.var_D671[param_00];
    var_03 = var_02.var_2044 * var_02.var_2044;
    var_04 = undefined;
    foreach(var_06 in var_01) {
      if(isDefined(var_06) && scripts\mp\utility::isreallyalive(var_06)) {
        if((level.teambased && func_B3E5(var_06.team, self.team, var_02.var_11589)) || !level.teambased && func_B3E4(var_06.triggerportableradarping, self, var_02.var_11589)) {
          var_07 = distancesquared(var_06.origin, self.origin);
          if(var_07 < var_03) {
            var_04 = var_06;
            break;
          }
        }
      }
    }

    var_09 = isDefined(var_04);
    var_0A = isDefined(self.ingame_cinematic_loop[param_00]);
    if(var_09 && !var_0A) {
      self[[var_02.var_C510]]();
    } else if(!var_09 && var_0A) {
      self[[var_02.var_C51E]]();
    }

    self.ingame_cinematic_loop[param_00] = var_04;
  }
}

func_B3E5(param_00, param_01, param_02) {
  return param_02 == "all" || param_02 == "friendly" && param_00 == param_01 || param_02 == "enemy" && param_00 != param_01;
}

func_B3E4(param_00, param_01, param_02) {
  return param_02 == "all" || param_02 == "friendly" && param_00 == param_01 || param_02 == "enemy" && param_00 != param_01;
}

func_7F0C(param_00) {
  return param_00.triggerportableradarping.guid + param_00.var_64;
}