/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\spy.gsc
*********************************************/

main() {
  maps\mp\gametypes\_globallogic::init();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::func_7BFA(level.gametype, 2.5);
    maps\mp\_utility::func_7BF9(level.gametype, 0);
    maps\mp\_utility::func_7BF7(level.gametype, 4);
    maps\mp\_utility::func_7C04(level.gametype, 0);
    maps\mp\_utility::func_7BF1(level.gametype, 1);
    maps\mp\_utility::func_7BE5(level.gametype, 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  level.var_5A74 = 1;
  level.killstreakrewards = 0;
  level.disabledivisionstats = 1;
  level.disabledivisionpassives = 1;
  level.disabledivisionskills = 1;
  level.mgnestsdisabled = 1;
  level.var_6BA7 = ::func_6BA7;
  level.var_6BAF = ::func_6BAF;
  level.var_6B7B = ::func_6B7B;
  level.onnormaldeath = ::onnormaldeath;
  level.var_6B7F = ::func_6B7F;
  level.var_6BB6 = ::func_6BB6;
  level.var_3FDD = ::applyspyperks;
  level.var_62AD = ::modifyplayerdamagespymode;
  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  level.roundbasedffa = 1;
  setteammode("ffa");
  maps\mp\_utility::func_873B(0);
  game["dialog"]["gametype"] = "spy_intro";
  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  level.spy_fx = [];
  level.spy_class_counts = [];
  for(var_00 = 0; var_00 < 3; var_00++) {
    level.spy_class_counts[var_00] = 0;
  }

  level.spy_class_maxs = [[0, 0, 0], [1, 0, 0], [1, 0, 1], [1, 1, 1], [2, 1, 1], [3, 1, 1], [3, 1, 2], [4, 1, 2], [4, 2, 2], [5, 2, 2], [6, 2, 2], [6, 2, 3], [7, 2, 3], [8, 2, 3], [8, 3, 3], [9, 3, 3], [9, 3, 4], [10, 3, 4], [11, 3, 4]];
  thread onplayerconnect();
  thread maps / mp / gametypes / _spy_loot::init();
}

func_5300() {
  maps\mp\_utility::func_8653(1);
  var_00 = getmatchrulesdata("commonOption", "timeLimit");
  setdynamicdvar("scr_spy_timelimit", var_00);
  maps\mp\_utility::func_7BFA("spy", var_00);
  var_01 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_spy_roundlimit", var_01);
  maps\mp\_utility::func_7BF7("spy", var_01);
  setdynamicdvar("scr_spy_winlimit", 0);
  maps\mp\_utility::func_7C04("spy", 0);
  setdynamicdvar("scr_spy_scorelimit", 0);
  maps\mp\_utility::func_7BF9("spy", 0);
}

func_6BB6() {
  spy_endgame(0, game["end_reason"]["time_limit_reached"]);
}

spy_endgame(param_00, param_01) {
  foreach(var_03 in level.players) {
    if(!isDefined(var_03.spyclass)) {
      return;
    }

    if(maps / mp / gametypes / _spy_util::spyclassfriendlycheck(param_00, var_03.spyclass)) {
      var_03.pers["score"] = var_03.pers["score"] + 1;
      var_03.extrascore0 = var_03.extrascore0 + var_03.pers["score"];
    }
  }

  var_05 = maps\mp\gametypes\_gamescore::func_450A();
  thread maps\mp\gametypes\_gamelogic::endgame(var_05, param_01);
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00.extrascore0 = var_00.pers["score"];
    var_00 thread playerassignspyclass();
    var_00 thread playerdisconnect();
    var_00 thread onplayerdeath();
  }
}

onplayerdeath() {
  for(;;) {
    self waittill("death");
    playercleanupheadicon();
  }
}

playerdisconnect() {
  self waittill("disconnect");
  thread playerremovespyclass();
  spycheckforwin();
}

func_6BAF() {
  maps\mp\_utility::func_3FA3("spy_loot_done", 0);
  setclientnamemode("auto_change");
  maps\mp\_utility::func_86DC("allies", &"OBJECTIVES_DM");
  maps\mp\_utility::func_86DC("axis", &"OBJECTIVES_DM");
  if(level.splitscreen) {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_DM");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_DM");
  } else {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_DM_SCORE");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_DM_SCORE");
  }

  maps\mp\_utility::func_86D8("allies", &"OBJECTIVES_DM_HINT");
  maps\mp\_utility::func_86D8("axis", &"OBJECTIVES_DM_HINT");
  lib_050D::func_10E4();
  level.usestartspawns = 1;
  var_00[0] = "spy";
  var_00[1] = "blocker_spy";
  maps\mp\gametypes\_gameobjects::main(var_00);
  level.var_7895 = 1;
  level.var_90E2["none"].allownonespectate = 1;
  thread spylootphase();
  thread serverhud();
}

spylootphase() {
  var_00 = getdvarint("scr_spy_loot_phase_time", 30);
  var_01 = maps\mp\gametypes\_hud_util::createservertimer("default", 2);
  var_01 maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, -50);
  var_01.label = &"MP_SPY_LOOT_PHASE";
  var_01 settimer(var_00);
  wait(var_00);
  var_01 destroy();
  maps\mp\_utility::func_3FA4("spy_loot_done");
}

serverhud() {
  maps\mp\_utility::func_3FA5("spy_loot_done");
  var_00 = 32;
  var_01 = maps\mp\gametypes\_hud_util::createserverfontstring("default", 2);
  var_01 maps\mp\gametypes\_hud_util::setpoint("LEFT", "LEFT", var_00, -50);
  var_01.label = &"MP_SPY_NUM_CIVILIANS";
  var_02 = maps\mp\gametypes\_hud_util::createserverfontstring("default", 2);
  var_02 maps\mp\gametypes\_hud_util::setpoint("LEFT", "LEFT", var_00, -25);
  var_02.label = &"MP_SPY_NUM_DETECTIVES";
  var_03 = maps\mp\gametypes\_hud_util::createservericon("waypoint_background_shield", var_00, var_00);
  var_03 maps\mp\gametypes\_hud_util::setpoint("LEFT", "LEFT", 0, -25);
  var_04 = maps\mp\gametypes\_hud_util::createserverfontstring("default", 2);
  var_04 maps\mp\gametypes\_hud_util::setpoint("LEFT", "LEFT", var_00, 0);
  var_04.label = &"MP_SPY_NUM_TRAITORS";
  var_05 = maps\mp\gametypes\_hud_util::createservericon("waypoint_faction_axis_icon", var_00, var_00);
  var_05 maps\mp\gametypes\_hud_util::setpoint("LEFT", "LEFT", 0, 0);
  var_06 = [var_01, var_02, var_04];
  var_07 = getaliveclasscounts();
  foreach(var_0A, var_09 in var_06) {
    var_09 setvalue(var_07[var_0A]);
  }

  for(;;) {
    waitforspyplayerupdate();
    waittillframeend;
    var_0B = getaliveclasscounts();
    foreach(var_0A, var_09 in var_06) {
      var_0D = var_0B[var_0A] - var_07[var_0A];
      if(var_0D) {
        var_09 setvalue(var_0B[var_0A]);
        var_09 thread onserverhudchange(var_0D);
      }
    }

    var_07 = var_0B;
  }
}

onserverhudchange(param_00) {
  self endon("death");
  self notify("onServerHudChange");
  self endon("onServerHudChange");
  if(param_00 < 0) {
    self.color = (1, 0, 0);
  } else {
    self.color = (0, 1, 0);
  }

  wait(0.75);
  self.color = (1, 1, 1);
}

playerassignspyclass() {
  self endon("disconnect");
  maps\mp\_utility::func_3FA5("prematch_done");
  if(!self.hasspawned) {
    self waittill("spawned_player");
  }

  var_00 = level.players.size + level.var_596C.size;
  var_01 = [];
  for(var_02 = 0; var_02 < 3; var_02++) {
    var_03 = level.spy_class_maxs[var_00][var_02] - level.spy_class_counts[var_02];
    for(var_04 = 0; var_04 < var_03; var_04++) {
      var_01[var_01.size] = var_02;
    }
  }

  self.spyclass = common_scripts\utility::func_7A33(var_01);
  level.spy_class_counts[self.spyclass]++;
  self.spyhudclass = maps\mp\gametypes\_hud_util::createfontstring("default", 1.5);
  self.spyhudclass maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, 0);
  self.spyhudclass.label = &"MP_SPY_HUD_CLASS";
  self.spyhudclass settext(maps / mp / gametypes / _spy_util::spyclasstolocstring(self.spyclass));
  self.spyhudclass maps\mp\gametypes\_hud_util::setpoint("BOTTOM", "BOTTOM", 0, -10, 2);
  self setclientomnvar("ui_spy_player_class", self.spyclass);
  playersetheadicon();
  switch (self.spyclass) {
    case 0:
      thread playercivilianthink();
      break;

    case 1:
      thread playerdetectivethink();
      break;

    case 2:
      thread playertraitorthink();
      break;
  }

  level notify("spyClassSet", self);
}

playercivilianthink() {
  self endon("death");
  for(;;) {
    updatelastseenplayer();
    wait 0.05;
  }
}

playerdetectivethink() {
  self endon("death");
  for(;;) {
    updatelastseenplayer();
    wait 0.05;
  }
}

playertraitorthink() {
  self endon("death");
  wait 0.05;
}

playersetheadicon() {
  if(self.spyclass == 1) {
    setheadiconspymode(self, "waypoint_background_shield");
    return;
  }

  if(self.spyclass == 2) {
    setheadiconspymode(self, "waypoint_faction_axis_icon", [2]);
  }
}

setheadiconspymode(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_00.origin);
  var_03 linkTo(param_00, "tag_origin");
  var_03 setModel("tag_origin");
  param_00.spyheadiconent = var_03;
  var_04 = newhudelem();
  var_04.archived = 1;
  var_04.alpha = 1;
  var_04 setshader(param_01, 30, 30);
  var_04 setwaypoint(0, 0, 0, 0);
  var_04.x = 0;
  var_04.y = 0;
  var_04.z = 70;
  var_04 settargetEnt(var_03, "tag_origin");
  param_00.spyheadicon = var_04;
  if(isDefined(param_02)) {
    thread updateheadiconvisible(var_03, param_02);
  }
}

updateheadiconvisible(param_00, param_01) {
  param_00 endon("death");
  param_00 hide();
  for(;;) {
    foreach(var_03 in param_01) {
      foreach(var_05 in level.players) {
        if(isDefined(var_05.spyclass) && var_05.spyclass == var_03) {
          param_00 showtoclient(var_05);
        }
      }
    }

    waitforspyplayerupdate();
  }
}

playerremovespyclass() {
  if(isDefined(self.spyclass)) {
    level.spy_class_counts[self.spyclass]--;
    self.spyclass = undefined;
  }

  playercleanupspyhud();
  playercleanupheadicon();
}

playercleanupspyhud() {
  if(isDefined(self.spyhudclass)) {
    self.spyhudclass destroy();
  }
}

playercleanupheadicon() {
  if(isDefined(self.spyheadicon)) {
    self.spyheadicon destroy();
  }

  if(isDefined(self.spyheadiconent)) {
    self.spyheadiconent delete();
  }
}

func_6B7B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  level notify("player_killed", self);
  playercleanupspyhud();
  spycheckforwin();
  spawntombstone(param_01, self);
  if(isPlayer(param_01) && isDefined(param_01.spyclass) && isDefined(self.spyclass)) {
    if(maps / mp / gametypes / _spy_util::spyclassfriendlycheck(param_01.spyclass, self.spyclass)) {
      param_01 iprintlnbold(&"MP_FRIENDLY_FIRE_WILL_NOT");
      var_0A = 1;
      if(var_0A) {
        param_01 maps\mp\_utility::_suicide();
        return;
      }
    }
  }
}

onnormaldeath(param_00, param_01, param_02) {}

getaliveclasscounts() {
  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  foreach(var_04 in level.players) {
    if(!maps\mp\_utility::func_57A0(var_04)) {
      continue;
    }

    if(!isDefined(var_04.spyclass)) {
      continue;
    }

    if(var_04.spyclass == 0) {
      var_00++;
      continue;
    }

    if(var_04.spyclass == 1) {
      var_01++;
      continue;
    }

    if(var_04.spyclass == 2) {
      var_02++;
    }
  }

  return [var_00, var_01, var_02];
}

spycheckforwin() {
  var_00 = getaliveclasscounts();
  var_01 = var_00[0];
  var_02 = var_00[1];
  var_03 = var_00[2];
  var_04 = var_01 + var_02;
  if(!var_03 && var_04) {
    spy_endgame(0, game["end_reason"]["axis_eliminated"]);
    return;
  }

  if(var_03 && !var_04) {
    spy_endgame(2, game["end_reason"]["allies_eliminated"]);
  }
}

modifyplayerdamagespymode(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isPlayer(param_02) && !maps\mp\_utility::func_3FA0("spy_loot_done")) {
    param_02 iprintlnbold(&"MP_SPY_NO_DAMAGE");
    return 0;
  }

  return param_03;
}

func_6B7F(param_00, param_01, param_02, param_03, param_04) {
  var_05 = maps\mp\gametypes\_rank::getscoreinfovalue(param_00);
  param_01 maps\mp\_utility::func_867B(param_01.extrascore0 + var_05);
  param_01 maps\mp\gametypes\_gamescore::func_A161(param_01, var_05);
  return 0;
}

func_6BA7() {
  setplayerclass(self);
}

setplayerclass(param_00) {
  var_01 = maps\mp\gametypes\_class::func_44B4();
  var_01["loadoutDivision"] = randomint(5);
  var_01["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(17113088, 0);
  param_00.pers["class"] = "gamemode";
  param_00.pers["lastClass"] = "";
  param_00.pers["gamemodeLoadout"] = var_01;
  param_00.var_2319 = param_00.pers["class"];
  param_00.var_5B84 = param_00.pers["lastClass"];
  param_00 maps\mp\gametypes\_class::func_4790(param_00.team, param_00.var_2319);
}

maydropweaponspymode(param_00) {
  if(param_00 == "shovel_mp") {
    return 0;
  }

  maps / mp / gametypes / _spy_loot::lootdropweapon(param_00);
  return 0;
}

applyspyperks() {}

spawntombstone(param_00, param_01) {
  var_02 = spawn("script_model", (0, 0, 0));
  var_02 setModel("prop_ger_kc_dogtags");
  var_02.origin = param_01.origin;
  var_02 makeusable();
  var_02 setHintString(&"MP_SPY_INVESTIGATE_CORPSE");
  var_02 setCursorHint("HINT_NOICON");
  var_02.victim = param_01;
  var_02.victimspyclass = param_01.spyclass;
  var_02.victimlastplayerseen = param_01.lastplayerseen;
  var_02 thread tombstoneupdate();
  var_02 thread tombstoneuse();
}

tombstoneupdate() {
  self endon("death");
  for(;;) {
    self hudoutlinedisable();
    var_00 = [];
    foreach(var_02 in level.players) {
      if(isDefined(var_02.spyclass) && var_02.spyclass == 1) {
        var_00[var_00.size] = var_02;
        self enableplayeruse(var_02);
        continue;
      }

      self disableplayeruse(var_02);
    }

    if(var_00.size) {
      self hudoutlineenableforclients(var_00, 0, 1);
    }

    waitforspyplayerupdate();
  }
}

tombstoneuse() {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_00);
    if(self.victimspyclass == 2) {
      var_00 thread detectivetombstonehud(&"MP_SPY_VICTIM_WAS_TRAITOR");
      continue;
    }

    var_01 = self.victimlastplayerseen;
    if(!isDefined(var_01)) {
      var_01 = "unknown";
    }

    var_00 thread detectivetombstonehud(&"MP_SPY_VICTIM_WAS_NOT_TRAITOR", var_01);
  }
}

detectivetombstonehud(param_00, param_01) {
  self notify("dectiveTombstoneHud");
  var_02 = maps\mp\gametypes\_hud_util::createfontstring("default", 1.5);
  var_02 maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, 0);
  var_02.label = param_00;
  if(isDefined(param_01)) {
    if(isPlayer(param_01)) {
      var_02 setplayernamestring(param_01);
    } else if(param_01 == "unknown") {
      var_02 settext(&"MP_SPY_LAST_SEEN_UNKNOWN");
    }
  }

  common_scripts\utility::waittill_notify_or_timeout("dectiveTombstoneHud", 4);
  if(isDefined(var_02)) {
    var_02 destroy();
  }
}

updatelastseenplayer() {
  var_00 = self method_82F0();
  if(!var_00.size) {
    return;
  }

  var_00 = function_01AC(var_00, self.origin);
  self.lastplayerseen = var_00[0];
}

waitforspyplayerupdate() {
  level common_scripts\utility::waittill_any("spyClassSet", "joined_team", "joined_spectators", "player_killed");
}