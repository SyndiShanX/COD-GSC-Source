/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3604.gsc
************************/

func_B557() {
  level thread func_B559();
}

func_B559() {
  for(;;) {
    level waittill("player_spawned", var_00);
    if(isai(var_00)) {
      continue;
    }
  }
}

func_B558() {}

func_B554(param_00) {
  self.var_B551 = 1;
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(!param_00) {
    self iprintlnbold("C.E.C.O.T drive active");
    thread func_B553();
  }

  var_01 = 450;
  var_02 = 1200;
  var_03 = 350;
  self energy_setmax(0, var_01);
  self goal_radius(0, var_01);
  self goalflag(0, var_02);
  self goal_type(0, var_03);
  return 1;
}

func_B552(param_00) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  var_01 = 400;
  var_02 = 400;
  self energy_setmax(0, var_01);
  self goal_radius(0, var_01);
  self goalflag(0, var_02);
  self goal_type(0, 900);
  if(!param_00) {
    self.var_B551 = 0;
    self setscriptablepartstate("megaboost", "megaboostOff", 0);
    self notify("megaboost_end");
  }
}

func_B555() {
  self endon("megaboost_end");
  scripts\engine\utility::waittill_any_3("death", "disconnect", "game_ended");
  thread func_B552();
}

func_9E95() {
  if(!isDefined(self.var_B551)) {
    return 0;
  }

  return self.var_B551;
}

func_B553() {
  self endon("disconnect");
  self endon("megaboost_end");
  self forceplaygestureviewmodel("ges_hold");
  self setscriptablepartstate("megaboost", "megaboostOn", 0);
}