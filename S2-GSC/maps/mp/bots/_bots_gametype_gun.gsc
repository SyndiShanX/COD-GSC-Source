/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_gun.gsc
***********************************************/

func_00F9() {
  func_87A7();
  func_8795();
}

func_87A7() {
  level.var_19D5["gametype_think"] = ::func_1A0E;
}

func_8795() {}

func_1A0D(param_00, param_01) {
  if(isDefined(param_00)) {
    var_02 = param_00 + "";
    var_03 = level.var_1B2C[var_02];
    if(isDefined(var_03)) {
      var_04 = strtok(var_03, "| ");
      if(maps\mp\_utility::func_472A(maps\mp\_utility::func_452B(param_00)) == "weapon_pistol") {
        var_04 = ["cqb", "run_and_gun"];
      }

      if(var_04.size > 0) {
        var_05 = undefined;
        if(common_scripts\utility::func_0F79(var_04, param_01)) {
          var_05 = param_01;
        } else {
          var_05 = common_scripts\utility::func_7A33(var_04);
        }

        maps\mp\bots\_bots_util::func_1AD5(var_05);
        return;
      }
    }
  }
}

func_1A0E() {
  self notify("bot_gun_think");
  self endon("bot_gun_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");
  var_00 = "";
  var_01 = self.var_6F7D;
  wait(0.1);
  for(;;) {
    var_02 = self getcurrentweapon();
    if(var_02 != "none" && !maps\mp\_utility::func_5740(var_02) && var_02 != var_00) {
      var_00 = var_02;
      if(self botgetdifficultysetting("advancedPersonality") && self botgetdifficultysetting("strategyLevel") > 0) {
        var_03 = maps\mp\_utility::func_452A(var_02);
        func_1A0D(var_03, var_01);
      }
    }

    self[[self.var_6F7F]]();
    wait 0.05;
  }
}