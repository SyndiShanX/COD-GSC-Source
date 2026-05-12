/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\agents\_agents.gsc
*********************************************/

func_00F9() {
  if(isDefined(level.var_27F6) && level.var_27F6) {
    return;
  }

  func_87A7();
  level.var_14F6 = ::badplace_cylinder;
  level.var_14F7 = ::badplace_delete;
  level thread maps\mp\agents\_agent_common::func_00D5();
  if(!maps\mp\_utility::func_551F() && !isDefined(level.var_585D) && level.var_585D) {}
}

func_87A7() {
  if(!isDefined(level.var_0A41)) {
    level.var_0A41 = [];
  }

  if(!isDefined(level.var_585D) && level.var_585D) {
    level.var_0A41["player"] = [];
    level.var_0A41["player"]["spawn"] = ::func_8F70;
    level.var_0A41["player"]["onAIConnect"] = ::func_6AB5;
    level.var_0A41["player"]["think"] = ::maps\mp\bots\_bots_gametype_war::func_1B25;
    level.var_0A41["player"]["on_killed"] = ::func_6A75;
    level.var_0A41["player"]["on_damaged"] = ::func_6A74;
    level.var_0A41["player"]["on_damaged_finished"] = ::func_0A40;
    level.var_0A4D = ::func_0933;
    level.var_0A4C = ::func_0921;
    level.var_0A55 = ::func_2DD5;
    level.var_0A5B = ::func_5331;
    level.var_0A5D = ::func_6AA3;
    level.var_0A5C = ::func_6A73;
    level notify("agent_funcs_init");
  }
}

func_A675() {
  while(!isDefined(level.var_0A41)) {
    wait 0.05;
  }
}

func_0933(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = maps\mp\agents\_agent_common::func_2586(param_00, param_01, param_02);
  if(isDefined(var_0B)) {
    if(isDefined(param_0A)) {
      var_0B.var_9089 = param_0A;
    }

    var_0B thread[[var_0B maps\mp\agents\_agent_utility::func_0A59("spawn")]](param_03, param_04, param_05, param_06, param_07, param_08, param_09);
  }

  return var_0B;
}

func_0921(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  return [[level.var_0A4D]]("dog", param_00, param_01, param_02, param_03, param_04, 0, param_05, param_06, param_07);
}

func_6AB5() {
  self.var_0009 = &"PLAYER";
}

func_8F70(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  self endon("disconnect");
  while(!isDefined(level.var_4696)) {
    wait 0.05;
  }

  if(self.var_4B60) {
    wait(randomintrange(6, 10));
  }

  maps\mp\agents\_agent_utility::func_5334(1);
  if(isDefined(param_00) && isDefined(param_01)) {
    var_07 = param_00;
    var_08 = param_01;
    self.var_5BE0 = spawnStruct();
    self.var_5BE0.var_0116 = var_07;
    self.var_5BE0.var_001D = var_08;
  } else {
    self method_856C();
    var_09 = [[level.var_4696]]();
    var_07 = var_09.var_0116;
    var_08 = var_09.var_001D;
    self.var_5BE0 = var_09;
  }

  maps\mp\agents\_agent_utility::func_08A7();
  self.var_5CC6 = maps\mp\agents\_agent_utility::func_45AE(self.var_0109);
  self.var_5BE2 = gettime();
  if(level.var_984D) {
    var_0A["position"] = var_07;
    var_0A["time"] = self.var_5BE2;
    level.var_7AD4[self.var_01A7][level.var_7AD4[self.var_01A7].size] = var_0A;
  }

  var_0B = var_07 + (0, 0, 25);
  var_0C = var_07;
  var_0D = playerphysicstrace(var_0B, var_0C);
  if(distancesquared(var_0D, var_0B) > 1) {
    var_07 = var_0D;
  }

  self method_838F(var_07, var_08);
  if(isDefined(param_05)) {
    self.var_0A43 = param_05;
  }

  if(isDefined(self.var_0A43)) {
    if(self.var_0A43 == "follow_code_and_dev_dvar") {
      self[[level.var_19D5["bot_set_difficulty"]]](self botgetdifficulty(), 1);
    } else {
      self[[level.var_19D5["bot_set_difficulty"]]](param_05);
    }
  } else {
    self[[level.var_19D5["bot_set_difficulty"]]](self botgetdifficulty());
  }

  if(isDefined(param_03) && param_03) {
    self.var_A1F0 = 1;
  }

  if(isDefined(self.var_A1F0) && self.var_A1F0) {
    if(!self.var_4B60) {
      var_0E = self botgetdifficultysetting("advancedPersonality");
      if(isDefined(var_0E) && var_0E != 0) {
        maps\mp\bots\_bots_personality::func_193F();
      }
    }

    maps\mp\bots\_bots_personality::func_1939();
  } else {
    self[[level.var_19D5["bot_set_personality"]]]("default");
  }

  maps\mp\agents\_agent_common::func_83FD(100);
  if(isDefined(param_04) && param_04) {
    self.var_7DAD = 1;
  }

  if(isDefined(param_02)) {
    maps\mp\agents\_agent_utility::func_83FE(param_02.var_01A7, param_02);
  }

  if(isDefined(self.var_0117)) {
    self thread[[level.var_0A55]](self.var_0117);
  }

  thread maps\mp\_flashgrenades::func_6394();
  self method_83D6(0);
  self[[level.var_6BA7]]();
  if(isDefined(param_06)) {
    self.var_0BA6 = param_06;
    self method_858A(param_06);
    maps\mp\agents\_agent_common::func_83FD(self.var_00BC);
    maps\mp\gametypes\_class::func_4774();
  } else {
    self[[level.var_0A5B]]();
    maps\mp\gametypes\_class::func_4773(self.var_01A7, self.var_2319, 1);
  }

  self thread[[level.var_19D5["bot_think_watch_enemy"]]](1);
  thread maps\mp\bots\_bots::func_1AFE();
  self thread[[level.var_19D5["bot_think_tactical_goals"]]]();
  self thread[[maps\mp\agents\_agent_utility::func_0A59("think")]]();
  if(!self.var_4B60) {
    lib_050D::func_09FA();
  }

  if(!self.var_4B60) {
    thread maps\mp\gametypes\_weapons::func_6B82();
    if(!isDefined(level.var_212F) || !level.var_212F) {
      thread maps\mp\gametypes\_battlechatter_mp::func_6B82();
    }
  }

  self.var_4B60 = 0;
  thread maps\mp\gametypes\_healthoverlay::func_73FC();
  if(isDefined(self.var_A1F0) && self.var_A1F0 && isDefined(self.var_7DAD) && self.var_7DAD) {
    self method_8528(1, self.var_01A7);
  }

  level notify("spawned_agent_player", self);
  level notify("spawned_agent", self);
  level notify("player_spawned", self);
  self notify("spawned_player");
}

func_2DD5(param_00) {
  self endon("death");
  param_00 waittill("killstreak_disowned");
  self notify("owner_disconnect");
  if(maps\mp\gametypes\_hostmigration::func_A782()) {
    wait 0.05;
  }

  self suicide();
}

func_0A40(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(isDefined(param_00) || isDefined(param_01)) {
    if(!isDefined(param_00)) {
      param_00 = param_01;
    }

    if(isDefined(self.var_0C31) && !self.var_0C31) {
      if(isDefined(param_00.var_003A) && param_00.var_003A == "script_vehicle") {
        return 0;
      }
    }

    if(isDefined(param_00.var_003A) && param_00.var_003A == "auto_turret") {
      param_01 = param_00;
    }

    if(isDefined(param_01) && param_04 != "MOD_FALLING" && param_04 != "MOD_SUICIDE") {
      if(level.var_984D) {
        if(isDefined(param_01.var_01A7) && param_01.var_01A7 != self.var_01A7) {
          self method_8391(param_01);
        }
      } else {
        self method_8391(param_01);
      }
    }
  }

  var_0B = self method_8390(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, 0);
  if(isDefined(var_0B)) {
    thread func_3BA5(var_0B[0], var_0B[1], var_0B[2], var_0B[3], var_0B[4], var_0B[5], var_0B[6]);
  }

  if(!isDefined(self.var_565F)) {
    self.var_A6ED = 1;
  }

  return 1;
}

func_3BA5(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  waittillframeend;
  if(!isDefined(self) || !isDefined(param_00)) {
    return;
  }

  self method_853B(param_00, param_01, param_02, param_03, param_04, param_05, param_06);
}

func_6A73(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  if(isDefined(self.var_0117)) {
    var_0B = isDefined(param_01) && self.var_0117 == param_01;
    var_0C = maps\mp\_utility::func_118D(self.var_0117, param_01) || var_0B;
  } else {
    var_0B = 0;
    var_0C = maps\mp\_utility::func_118D(self, param_02);
  }

  if(level.var_984D && var_0C && !level.var_3EC4 && !common_scripts\utility::func_562E(param_01.candamageallies)) {
    return 0;
  }

  if(!level.var_984D && var_0B) {
    return 0;
  }

  if(isDefined(param_04) && param_04 == "MOD_CRUSH" && isDefined(param_00) && isDefined(param_00.var_003A) && param_00.var_003A == "script_vehicle") {
    return 0;
  }

  if(!isDefined(self) || !maps\mp\_utility::func_57A0(self)) {
    return 0;
  }

  if(isDefined(param_01) && param_01.var_003A == "script_origin" && isDefined(param_01.var_01B9) && param_01.var_01B9 == "soft_landing") {
    return 0;
  }

  if(param_05 == "killstreak_emp_mp") {
    return 0;
  }

  if(param_05 == "bouncingbetty_mp" && !maps\mp\gametypes\_weapons::func_61DA(param_00, self)) {
    return 0;
  }

  if((param_05 == "throwingknife_mp" || param_05 == "throwingknifejugg_mp") && param_04 == "MOD_IMPACT") {
    param_02 = self.var_00BC + 1;
  }

  if(isDefined(param_00) && isDefined(param_00.var_9488) && param_00.var_9488 == self) {
    param_02 = self.var_00BC + 1;
  }

  if(param_02 <= 0) {
    return 0;
  }

  if(isDefined(level.var_62AD)) {
    param_02 = [[level.var_62AD]](self, param_00, param_01, param_02, param_04, param_05, param_06, param_07, param_08, param_0A);
  }

  if(maps\mp\_utility::func_585F()) {
    var_0D = common_scripts\utility::func_562E(self.ignorethiszerodamage);
    self.ignorethiszerodamage = undefined;
    if(var_0D && param_02 <= 0) {
      return 0;
    }
  }

  if(isDefined(param_01) && param_01 != self && param_02 > 0 && !isDefined(param_08) || param_08 != "shield") {
    if(param_03 &level.var_5040) {
      var_0E = "stun";
    } else if(!maps\mp\gametypes\_damage::func_8BB3(param_06)) {
      var_0E = "none";
    } else {
      var_0E = "standard";
      if(isDefined(level.var_585D) && level.var_585D && isDefined(level.var_1E41)) {
        var_0E = [[level.var_1E41]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A);
      }
    }

    param_01 thread maps\mp\gametypes\_damagefeedback::func_A102(var_0E);
  }

  return self[[maps\mp\agents\_agent_utility::func_0A59("on_damaged_finished")]](param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, var_0B);
}

func_6A74(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  var_0B = isDefined(param_01) && isDefined(self.var_0117) && self.var_0117 == param_01;
  if(!level.var_984D && var_0B) {
    return 0;
  }

  maps\mp\gametypes\_damage::func_1E68(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

func_6A75(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  self[[level.var_0A5D]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, 1);
  if(isPlayer(param_01) && (!isDefined(self.var_0117) || param_01 != self.var_0117) && !isDefined(self.var_672C) || !self.var_672C) {
    maps\mp\gametypes\_damage::func_6B4B(param_01, param_04, param_03, param_02, "destroyed_squad_mate");
  }

  if(isDefined(level.var_6A75)) {
    [[level.var_6A75]](param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  }

  thread maps\mp\gametypes\_weapons::func_34A9(param_01, param_03, param_04);
  if(self.var_565F) {
    self.var_4B60 = 1;
    if(maps\mp\_utility::func_44FC() != 1 && isDefined(self.var_7DAD) && self.var_7DAD) {
      self thread[[maps\mp\agents\_agent_utility::func_0A59("spawn")]]();
      return;
    }

    maps\mp\agents\_agent_utility::func_2A73();
  }
}

func_6AA3(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(maps\mp\_riotshield::func_4B8D()) {
    maps\mp\gametypes\_damage::func_5C2D(param_02, param_03);
    if(!param_09) {
      var_0A = self dropitem(self getcurrentweapon());
      if(isDefined(var_0A)) {
        var_0A thread maps\mp\gametypes\_weapons::func_2D45();
        var_0A.var_0117 = self;
        var_0A.var_6DAF = param_01;
        var_0A makeunusable();
      }
    }
  }

  if(param_09) {
    self thread[[level.var_A9C5]](param_01, param_03, param_04);
  }

  self.var_18A8 = self method_8392(param_08);
  if(!maps\mp\gametypes\_damage::func_8B8B(self)) {
    self.var_18A8 startragdoll();
  } else {
    thread maps\mp\gametypes\_damage::func_2CEC(self.var_18A8, param_06, param_05, param_04, param_00, param_03);
  }

  maps\mp\_riotshield::func_7E96();
}

func_5331() {
  if(isDefined(self.var_231C)) {
    self.var_2319 = self.var_231C;
    return;
  }

  if(maps\mp\bots\_bots_loadout::func_1ADE()) {
    self.var_2319 = "callback";
    return;
  }

  self.var_2319 = "class1";
}