/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_globallogic.gsc
**********************************************/

func_00D5() {
  level.var_910F = issplitscreen();
  level.var_258F = getDvar("5554") == "true";
  level.var_6B4D = function_02A3();
  level.var_7A67 = function_03AC();
  level.var_7616 = getdvarint("664");
  level.var_2F98 = getdvarint("78", 1) == 0;
  level.var_2F7A = getdvarint("1349", 1) == 0;
  level.var_2FAA = getdvarint("437", 1) == 0;
  maps\mp\_utility::func_86FB();
  if(getdvarint("5357") == 1) {
    level.var_6B4D = 1;
  }

  level.var_015D = tolower(getDvar("1673"));
  if(function_0367()) {
    level.var_3FDC = "hub";
  } else if(getdvarint("4017", 0)) {
    level.var_3FDC = "vlobby";
  } else {
    level.var_3FDC = tolower(getDvar("1924"));
  }

  level.var_985B = ["axis", "allies"];
  level.var_6C63["allies"] = "axis";
  level.var_6C63["axis"] = "allies";
  level.var_6520 = 0;
  maps\mp\_utility::func_873B(0);
  level.var_6933 = 0;
  level.var_36BE = 1;
  level.var_8C03 = 0;
  level.var_9A27 = getdvarint("scr_tispawndelay");
  if(!isDefined(level.var_9FC5)) {
    maps\mp\gametypes\_tweakables::func_00D5();
  }

  precachestring(&"MP_HALFTIME");
  precachestring(&"MP_OVERTIME");
  precachestring(&"MP_ROUNDEND");
  precachestring(&"MP_INTERMISSION");
  precachestring(&"MP_SWITCHING_SIDES");
  precachestring(&"MP_FRIENDLY_FIRE_WILL_NOT");
  precachestring(&"MP_SUICIDE_PUNISHED");
  precachestring(&"PLATFORM_REVIVE");
  precachestring(&"MP_OBITUARY_NEUTRAL");
  precachestring(&"MP_OBITUARY_FRIENDLY");
  precachestring(&"MP_OBITUARY_ENEMY");
  if(level.var_910F) {
    precachestring(&"MP_ENDED_GAME");
  } else {
    precachestring(&"MP_HOST_ENDED_GAME");
  }

  level.var_495B = "halftime";
  if(level.var_3FDC == "dom" || level.var_3FDC == "lockdown") {
    level.var_4959 = 1;
  } else {
    level.var_4959 = 0;
  }

  level.halftimestopwatch = 0;
  level.var_5C00 = 0;
  level.var_A87B = "none";
  level.var_5BDF = 0;
  level.var_7006["allies"] = [];
  level.var_7006["axis"] = [];
  level.var_7006["all"] = [];
  level.var_75EE = 5;
  if(maps\mp\_utility::func_761E()) {
    level.var_75EE = 0;
  }

  level.var_7460 = [];
  func_7BDF();
  precachemodel("tag_origin");
  level.var_984F["allies"] = 0;
  level.var_984F["axis"] = 0;
  level.var_984F["spectator"] = 0;
  level.var_0BC3["allies"] = 0;
  level.var_0BC3["axis"] = 0;
  level.var_0BC3["spectator"] = 0;
  level.var_5DDB["allies"] = 0;
  level.var_5DDB["axis"] = 0;
  level.var_6AF5 = [];
  level.var_4B96["allies"] = 0;
  level.var_4B96["axis"] = 0;
  var_00 = 9;
  func_5211(var_00);
}

func_5211(param_00) {
  for(var_01 = 0; var_01 < param_00; var_01++) {
    var_02 = "team_" + var_01;
    level.var_7006[var_02] = [];
    level.var_984F[var_02] = 0;
    level.var_0BC3[var_02] = 0;
    level.var_5DDB[var_02] = 0;
    level.var_4B96[var_02] = 0;
  }
}

func_7BDF() {
  setomnvar("ui_bomb_a_state", 0);
  setomnvar("ui_bomb_b_state", 0);
  setomnvar("ui_nuke_end_milliseconds", 0);
  setDvar("ui_danger_team", "");
  setDvar("ui_inhostmigration", 0);
  setDvar("311", getdvarint("scr_thirdPerson"));
}

func_8A0C() {
  level.var_6BCE = ::func_6BCE;
  level.var_4696 = ::func_4437;
  level.var_7658 = ::lib_050E::func_4436;
  level.var_A278 = ::lib_050E::func_A278;
  level.var_6BA7 = ::func_1786;
  level.var_6B96 = ::func_1786;
  level.var_6BB6 = ::maps\mp\gametypes\_gamelogic::func_2BB0;
  level.var_6B42 = ::maps\mp\gametypes\_gamelogic::func_2BAE;
  level.var_6AE2 = ::maps\mp\gametypes\_gamelogic::func_2BAD;
  level.var_6B5E = ::maps\mp\gametypes\_gamelogic::func_2BAF;
  level.var_6B86 = ::func_1786;
  level.var_6BAF = ::func_1786;
  level.var_6B7B = ::func_1786;
  level.var_1385 = ::maps\mp\gametypes\_menus::func_1385;
}

func_4437() {
  if(!isDefined(self.var_9070)) {
    self.var_9070 = spawnStruct();
  }

  var_00 = [[level.var_7658]](function_02D5(self), self.var_9070, undefined, isPlayer(self), undefined, 1);
  if(isDefined(self.var_9070)) {
    var_01 = self.var_9070.var_76E6;
    self.var_9070.var_76E6 = self.var_9070.var_9087;
    self.var_9070.var_9087 = var_00;
    if(getdvarint("spawning_revised_fatique") != 0) {
      var_02 = [];
      var_03 = 0;
      if(isDefined(self.var_9070.var_3A5D)) {
        foreach(var_05 in self.var_9070.var_3A5D) {
          var_06 = 0;
          var_07 = var_05["spawnPoint"];
          if(var_07 == var_00) {
            var_03 = 1;
            if(var_05["spawnsSinceLastUsed"] == 0) {
              var_05["spawnCount"]++;
            } else {
              var_05["spawnsSinceLastUsed"] = 0;
              var_05["spawnCount"] = 1;
            }
          } else {
            var_05["spawnCount"] = 0;
            var_05["spawnsSinceLastUsed"]++;
            if(var_05["spawnsSinceLastUsed"] > 3) {
              var_06 = 1;
            }
          }

          if(!var_06) {
            var_02[var_02.size] = var_05;
          }
        }
      }

      if(!var_08) {
        if(isDefined(self.var_9070.var_76E6) && self.var_9070.var_76E6 == var_05) {
          var_03["spawnPoint"] = var_05;
          var_08["spawnCount"] = 2;
          var_08["spawnsSinceLastUsed"] = 0;
          var_06[var_06.size] = var_08;
        } else if(isDefined(var_06) && var_06 == var_05) {
          var_03["spawnPoint"] = var_05;
          var_08["spawnCount"] = 1;
          var_08["spawnsSinceLastUsed"] = 0;
          var_06[var_06.size] = var_08;
        }
      }

      self.var_9070.var_3A5D = var_07;
    }
  }

  if(isDefined(level.var_A278)) {
    self[[level.var_A278]](var_08);
  }

  return var_08;
}

func_1786(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {}

func_991A() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    wait(10);
    var_00 = spawnStruct();
    var_00.var_9A2E = &"MP_CHALLENGE_COMPLETED";
    var_00.var_6811 = "wheee";
    var_00.var_8F2C = "mp_challenge_complete";
    thread maps\mp\gametypes\_hud_message::func_680B(var_00);
  }
}

func_991C() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    wait(3);
    var_00 = randomint(6);
    for(var_01 = 0; var_01 < var_00; var_01++) {
      iprintlnbold(var_00);
      self shellshock("frag_grenade_mp", 0.2);
      wait(0.1);
    }
  }
}

func_6BCE(param_00) {
  level thread maps\mp\gametypes\_rank::func_1457(param_00, self);
}

func_2B57(param_00, param_01) {
  for(var_02 = 0; var_02 < 50; var_02++) {
    wait 0.05;
  }
}