/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3604.gsc
*********************************************/

func_B557() {
  level thread func_B559();
}

func_B559() {
  for(;;) {
    level waittill("player_spawned", var_0);
    if(isai(var_0)) {
      continue;
    }
  }
}

func_B558() {}

func_B554(var_0) {
  self.var_B551 = 1;
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(!var_0) {
    self iprintlnbold("C.E.C.O.T drive active");
    thread func_B553();
  }

  var_1 = 450;
  var_2 = 1200;
  var_3 = 350;
  self energy_setmax(0, var_1);
  self energy_setenergy(0, var_1);
  self energy_setrestorerate(0, var_2);
  self energy_setresttimems(0, var_3);
  return 1;
}

func_B552(var_0) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = 400;
  var_2 = 400;
  self energy_setmax(0, var_1);
  self energy_setenergy(0, var_1);
  self energy_setrestorerate(0, var_2);
  self energy_setresttimems(0, 900);
  if(!var_0) {
    self.var_B551 = 0;
    self setscriptablepartstate("megaboost", "megaboostOff", 0);
    self notify("megaboost_end");
  }
}

func_B555() {
  self endon("megaboost_end");
  scripts\engine\utility::waittill_any("death", "disconnect", "game_ended");
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