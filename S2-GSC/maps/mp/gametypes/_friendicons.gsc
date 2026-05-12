/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_friendicons.gsc
**********************************************/

func_00D5() {
  level.var_33D6 = 0;
  game["headicon_allies"] = maps\mp\gametypes\_teams::func_46D1("allies");
  game["headicon_axis"] = maps\mp\gametypes\_teams::func_46D1("axis");
  level thread func_6B6C();
  for(;;) {
    func_A117();
    wait(5);
  }
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_6B82();
    var_00 thread func_6B7B();
  }
}

func_6B82() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    thread func_8BFA();
  }
}

func_6B7B() {
  self endon("disconnect");
  for(;;) {
    self waittill("killed_player");
    self.var_00BA = "";
  }
}

func_8BFA() {
  if(level.var_33D6) {
    if(self.var_012C["team"] == "allies") {
      self.var_00BA = game["headicon_allies"];
      self.var_00BB = "allies";
      return;
    }

    self.var_00BA = game["headicon_axis"];
    self.var_00BB = "axis";
  }
}

func_A117() {
  var_00 = maps\mp\_utility::func_4529("scr_drawfriend", level.var_33D6);
  if(level.var_33D6 != var_00) {
    level.var_33D6 = var_00;
    func_A116();
  }
}

func_A116() {
  var_00 = level.var_744A;
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_02 = var_00[var_01];
    if(isDefined(var_02.var_012C["team"]) && var_02.var_012C["team"] != "spectator" && var_02.var_0178 == "playing") {
      if(level.var_33D6) {
        if(var_02.var_012C["team"] == "allies") {
          var_02.var_00BA = game["headicon_allies"];
          var_02.var_00BB = "allies";
        } else {
          var_02.var_00BA = game["headicon_axis"];
          var_02.var_00BB = "axis";
        }

        continue;
      }

      var_00 = level.var_744A;
      for(var_01 = 0; var_01 < var_00.size; var_01++) {
        var_02 = var_00[var_01];
        if(isDefined(var_02.var_012C["team"]) && var_02.var_012C["team"] != "spectator" && var_02.var_0178 == "playing") {
          var_02.var_00BA = "";
        }
      }
    }
  }
}