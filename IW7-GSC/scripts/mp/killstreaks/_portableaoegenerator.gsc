/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_portableaoegenerator.gsc
************************************************************/

init() {
  if(!isDefined(level.var_D671)) {
    level.var_D671 = [];
    level.generators = [];
  }
}

func_FB16(var_0) {
  var_1 = level.var_D671[var_0];
  self give_player_xp("flash");
  scripts\mp\utility::_giveweapon(var_1.var_39C, 0);
  self givestartammo(var_1.var_39C);
  if(!isDefined(self.var_522E)) {
    self.var_522E = [];
  }

  thread func_B9DE(var_0);
}

func_12D67(var_0) {
  self notify("end_monitorUse_" + var_0);
}

func_51B7(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }

  foreach(var_3 in level.players) {
    if(isDefined(var_3) && isDefined(var_3.ingame_cinematic_loop)) {
      var_3.ingame_cinematic_loop[var_1] = undefined;
    }
  }

  func_DEF2(var_0, var_1, undefined);
  var_0 notify("death");
  var_0 delete();
}

func_DEF2(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2) {
    self.var_522E[var_1] = var_0;
  } else {
    self.var_522E[var_1] = undefined;
    var_2 = undefined;
  }

  var_3 = level.generators[var_1];
  if(!isDefined(var_3)) {
    level.generators[var_1] = [];
    var_3 = level.generators[var_1];
  }

  var_4 = func_7F0C(var_0);
  var_3[var_4] = var_2;
}

func_B9DE(var_0) {
  self notify("end_monitorUse_" + var_0);
  self endon("end_monitorUse_" + var_0);
  self endon("disconnect");
  level endon("game_ended");
  var_1 = level.var_D671[var_0];
  for(;;) {
    self waittill("grenade_fire", var_2, var_3);
    if(var_3 == var_1.var_39C || var_3 == var_0) {
      if(!isalive(self)) {
        var_2 delete();
        return;
      }

      if(func_3E1B(var_2, var_1.var_CC26)) {
        var_4 = self.var_522E[var_0];
        if(isDefined(var_4)) {
          func_51B7(var_4, var_0);
        }

        var_5 = func_108EA(var_0, var_2.origin);
        var_6 = var_2 getlinkedparent();
        if(isDefined(var_6)) {
          var_5 linkto(var_6);
        }

        if(isDefined(var_2)) {
          var_2 delete();
        }

        continue;
      }

      self setweaponammostock(var_1.var_39C, self getweaponammostock("trophy_mp") + 1);
    }
  }
}

func_3E1B(var_0, var_1) {
  var_0 hide();
  var_0 waittill("missile_stuck", var_2);
  if(var_1 * var_1 < distancesquared(var_0.origin, self.origin)) {
    var_3 = bulletTrace(self.origin, self.origin - (0, 0, var_1), 0, self);
    if(var_3["fraction"] == 1) {
      var_0 delete();
      return 0;
    }

    var_0.origin = var_3["position"];
  }

  var_0 show();
  return 1;
}

func_108EA(var_0, var_1) {
  var_2 = level.var_D671[var_0];
  var_3 = spawn("script_model", var_1);
  var_3.health = var_2.health;
  var_3.team = self.team;
  var_3.triggerportableradarping = self;
  var_3 setCanDamage(1);
  var_3 setModel(var_2.placedmodel);
  if(level.teambased) {
    var_3 scripts\mp\entityheadicons::setteamheadicon(self.team, (0, 0, var_2.var_8C79));
  } else {
    var_3 scripts\mp\entityheadicons::setplayerheadicon(self, (0, 0, var_2.var_8C79));
  }

  var_3 thread func_13AE2(self, var_0);
  var_3 thread func_139E5(self, var_0);
  var_3 thread func_13B9C(self, var_0);
  var_3 thread scripts\mp\utility::notusableforjoiningplayers(self);
  if(isDefined(var_2.ondeploycallback)) {
    var_3[[var_2.ondeploycallback]](self, var_0);
  }

  var_3 thread scripts\mp\weapons::createbombsquadmodel(var_2.bombsquadmodel, "tag_origin", self);
  func_DEF2(var_3, var_0, 1);
  wait(0.05);
  if(isDefined(var_3) && var_3 scripts\mp\utility::touchingbadtrigger()) {
    var_3 notify("death");
  }

  return var_3;
}

func_13AE2(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  if(scripts\mp\utility::bot_is_fireteam_mode()) {
    var_0 waittill("killstreak_disowned");
  } else {
    var_0 scripts\engine\utility::waittill_either("killstreak_disowned", "death");
  }

  var_0 thread func_51B7(self, var_1);
}

func_139E5(var_0, var_1) {
  self.var_773C = var_1;
  var_2 = level.var_D671[var_1];
  scripts\mp\damage::monitordamage(var_2.health, var_2.damagefeedback, ::handledeathdamage, ::modifydamage, 0);
}

modifydamage(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  var_5 = scripts\mp\damage::handlemeleedamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleempdamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handlemissiledamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handlegrenadedamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);
  return var_5;
}

handledeathdamage(var_0, var_1, var_2) {
  var_3 = self.triggerportableradarping;
  var_4 = level.var_D671[self.var_773C];
  if(isDefined(var_3) && var_0 != var_3) {
    var_0 notify("destroyed_equipment");
  }

  if(isDefined(var_4.var_C4F1)) {
    var_3[[var_4.var_C4F1]](self, self.var_773C);
  }

  var_3 thread func_51B7(self, self.var_773C);
}

func_13B9C(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("disconnect");
  var_2 = level.var_D671[var_1];
  self setcursorhint("HINT_NOICON");
  self sethintstring(var_2.usehintstring);
  scripts\mp\utility::setselfusable(var_0);
  for(;;) {
    self waittill("trigger", var_3);
    var_3 playlocalsound(var_2.var_130D9);
    if(var_3 getrunningforwardpainanim(var_2.var_39C) == 0 && !var_3 scripts\mp\utility::isjuggernaut()) {
      var_3 func_FB16(var_1);
    }

    var_3 thread func_51B7(self, var_1);
  }
}

func_7737() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");
  var_0 = randomfloat(0.5);
  wait(var_0);
  self.ingame_cinematic_loop = [];
  for(;;) {
    wait(0.05);
    if(level.generators.size > 0 || self.ingame_cinematic_loop.size > 0) {
      foreach(var_2 in level.var_D671) {
        func_3DE7(var_2.var_773C);
      }
    }
  }
}

func_3DE7(var_0) {
  var_1 = level.generators[var_0];
  if(isDefined(var_1)) {
    var_2 = level.var_D671[var_0];
    var_3 = var_2.var_2044 * var_2.var_2044;
    var_4 = undefined;
    foreach(var_6 in var_1) {
      if(isDefined(var_6) && scripts\mp\utility::isreallyalive(var_6)) {
        if((level.teambased && func_B3E5(var_6.team, self.team, var_2.var_11589)) || !level.teambased && func_B3E4(var_6.triggerportableradarping, self, var_2.var_11589)) {
          var_7 = distancesquared(var_6.origin, self.origin);
          if(var_7 < var_3) {
            var_4 = var_6;
            break;
          }
        }
      }
    }

    var_9 = isDefined(var_4);
    var_0A = isDefined(self.ingame_cinematic_loop[var_0]);
    if(var_9 && !var_0A) {
      self[[var_2.var_C510]]();
    } else if(!var_9 && var_0A) {
      self[[var_2.var_C51E]]();
    }

    self.ingame_cinematic_loop[var_0] = var_4;
  }
}

func_B3E5(var_0, var_1, var_2) {
  return var_2 == "all" || var_2 == "friendly" && var_0 == var_1 || var_2 == "enemy" && var_0 != var_1;
}

func_B3E4(var_0, var_1, var_2) {
  return var_2 == "all" || var_2 == "friendly" && var_0 == var_1 || var_2 == "enemy" && var_0 != var_1;
}

func_7F0C(var_0) {
  return var_0.triggerportableradarping.guid + var_0.var_64;
}