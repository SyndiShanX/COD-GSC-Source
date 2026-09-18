/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\br.gsc
*********************************************/

main() {
  maps\mp\gametypes\_globallogic::init();
  lib_01DD::setupcallbacks();
  maps\mp\gametypes\_globallogic::setupcallbacks();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::registertimelimitdvar(level.gametype, 0);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 1);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 0);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 3);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 1);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  level.var_5A74 = 1;
  level.killstreakrewards = 0;
  level.disabledivisionstats = 1;
  level.disabledivisionpassives = 1;
  level.disabledivisionskills = 1;
  level.firstplayerspawned = 0;
  level.mgnestsdisabled = 1;
  level.partners = 0;
  level.var_6BA7 = ::func_6BA7;
  level.var_6B7B = ::func_6B7B;
  level.var_6BAF = ::func_6BAF;
  level.onnormaldeath = ::onnormaldeath;
  level.var_6B7F = ::func_6B7F;
  level.var_62AD = ::modifyplayerdamagebattleroyale;
  level.var_3FC7 = ::maydropweaponbattleroyale;
  level.var_3FDD = ::applybattleroyaleperks;
  setdynamicdvar("scr_player_healthregentime", 0);
  setdynamicdvar("1605", maxspawnedlootitems());
  setdvarifuninitialized("scr_br_loot_density", 0.6);
  setdvarifuninitialized("scr_br_loot_drop_to_ground", 1);
  setdvarifuninitialized("scr_br_loot_ground_offset", 10);
  setdvarifuninitialized("scr_br_loot_path_nodes_outside", 0.02);
  setdvarifuninitialized("scr_br_loot_path_nodes_inside_partial", 0);
  setdvarifuninitialized("scr_br_loot_path_nodes_inside_complete", 1);
  setdvarifuninitialized("scr_br_loot_path_nodes_min_dist", 100);
  setdvarifuninitialized("scr_br_insertion_delay", 3);
  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  setteammode("ffa");
  level.objectivebased = 1;
  maps\mp\_utility::func_873B(0);
  game["dialog"]["gametype"] = "br_intro";
  game["dialog"]["defense_obj"] = "gbl_start";
  game["dialog"]["offense_obj"] = "gbl_start";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  level.br_fx["weapon_pickup_red"] = loadfx("vfx/test/br/weapon_pickup_red");
  level.br_fx["weapon_pickup_orange"] = loadfx("vfx/test/br/weapon_pickup_orange");
  level.br_fx["weapon_pickup_yellow"] = loadfx("vfx/test/br/weapon_pickup_yellow");
  level.br_fx["weapon_pickup_green"] = loadfx("vfx/test/br/weapon_pickup_green");
  level.br_fx["weapon_pickup_blue"] = loadfx("vfx/test/br/weapon_pickup_blue");
  thread initloot();
}

func_5300() {
  maps\mp\_utility::func_8653(1);
  var_00 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_br_winlimit", var_00);
  maps\mp\_utility::registerwinlimitdvar("br", var_00);
  setdynamicdvar("scr_br_roundlimit", 0);
  maps\mp\_utility::registerroundlimitdvar("br", 0);
  setdynamicdvar("scr_br_scorelimit", 0);
  maps\mp\_utility::registerscorelimitdvar("br", 1);
  setdynamicdvar("scr_br_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("br", 0);
  setdynamicdvar("scr_br_numlives", 1);
  maps\mp\_utility::registernumlivesdvar("br", 1);
}

func_6BAF() {
  setclientnamemode("auto_change");
  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_BR");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_BR");
  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_BR");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_BR");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_BR_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_BR_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_BR_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_BR_HINT");
  lib_050D::func_10E4();
  level.usestartspawns = 1;
  var_00[0] = "br";
  maps\mp\gametypes\_gameobjects::main(var_00);
  level.var_7895 = 1;
  level.claimednodes = [];
  maps\mp\_utility::gameflaginit("players_deployed", 0);
  level thread onplayerconnect();
  level thread waittospawnplayers();
  level thread runshrinkingcircle();
}

onplayerconnect() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    var_00.var_3C6F = 1;
    var_00.prekilledfunc = ::playerprekillbattleroyale;
    if(!isbot(var_00)) {
      if(level.console) {
        var_00 notifyonplayercommand("tryUseMedkit", "+actionslot 4");
      } else {
        var_00 notifyonplayercommand("tryUseMedkit", "+actionslot 5");
      }
    }

    var_00 thread playerhideteamchoiceonselect();
    setDvar("1979", 0);
    level thread onplayerspawned(var_00);
  }
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
  param_00.class = param_00.pers["class"];
  param_00.lastclass = param_00.pers["lastClass"];
  param_00 maps\mp\gametypes\_class::func_4790(param_00.team, param_00.class);
}

onplayerspawned(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  for(;;) {
    param_00 waittill("spawned_player");
    param_00 setclientomnvar("ui_hide_minimap", 1);
    if(common_scripts\utility::func_562E(param_00.var_3C6F)) {
      param_00.var_3C6F = 0;
      var_01 = getrandomspawnnodeforplayer(param_00);
      param_00 playerclaimspawnnode(var_01);
      if(!maps\mp\_utility::gameflag("prematch_done")) {
        param_00 thread playertargetedspawn();
      }
    }

    param_00 thread playercircleaudio();
    param_00 thread playermonitorcircle();
    param_00 playerpartnersetup();
    param_00 playermedkitinit();
    param_00 thread playermedkitusemonitor();
    param_00 thread playermedkithud();
    level.firstplayerspawned = 1;
  }
}

checkendgamepartnermodeonkill() {
  wait 0.05;
  var_00 = [];
  foreach(var_02 in level.players) {
    if(var_02 maps\mp\gametypes\_playerlogic::mayspawn()) {
      return;
    }

    if(maps\mp\_utility::isreallyalive(var_02)) {
      var_00[var_00.size] = var_02;
    }
  }

  if(var_00.size == 2 && isDefined(var_00[0].var_6E9C) && var_00[0].var_6E9C == var_00[1]) {
    level thread maps\mp\gametypes\_gamelogic::endgame(var_00[0], game["end_reason"]["enemies_eliminated"]);
  }
}

func_6B7B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(common_scripts\utility::func_562E(level.partners)) {
    level thread checkendgamepartnermodeonkill();
  }

  var_0A = [];
  if(self.nummedkits > 0) {
    var_0A[var_0A.size] = "medkit";
  }

  level thread playdeathstingersforteams(self);
  if(isDefined(self.victimcurrentlethal) && self.victimcurrentlethal != "none" && self.victimcurrentlethal != "") {
    var_0A[var_0A.size] = self.victimcurrentlethal;
  }

  if(isDefined(self.victimcurrenttactical) && self.victimcurrenttactical != "none" && self.victimcurrenttactical != "") {
    var_0A[var_0A.size] = self.victimcurrenttactical;
  }

  if(var_0A.size > 0) {
    var_0B = 40;
    var_0C = 10;
    var_0D = lootgetgroundpos(self.origin);
    var_0E = randomfloatrange(0, 360);
    var_0F = [];
    foreach(var_1A, var_11 in var_0A) {
      var_12 = anglesToForward((0, var_0E + var_1A / var_0A.size * 360, 0));
      var_13 = var_0D + (0, 0, 50);
      var_14 = var_0B + var_0C;
      var_15 = var_13 + var_12 * var_14;
      var_16 = bulletTrace(var_13, var_15, 0, self.var_18A8);
      var_17 = var_16["fraction"] * var_14;
      var_18 = var_17 - var_0C;
      if(var_18 > 0) {
        var_19 = var_13 + var_12 * var_18;
        var_19 = lootgetgroundpos(var_19);
      } else {
        var_19 = var_0D;
      }

      var_0F[var_1A] = var_19;
    }

    foreach(var_1A, var_11 in var_0A) {
      var_1C = level.brloot[0][var_11];
      var_1D = (0, randomfloatrange(0, 360), 0);
      var_1E = lootlocationcreate(var_0F[var_1A], var_1D);
      var_1E lootlocationinit(0);
      spawnloot(var_1C, var_1E);
    }
  }
}

onnormaldeath(param_00, param_01, param_02) {
  if(!func_A870(param_00, param_01)) {
    return;
  }

  if(param_01 == self) {
    return;
  }

  var_03 = func_5742(param_01);
  if(var_03) {
    param_01.finalkill = 1;
  }

  param_01 thread maps\mp\_events::func_35D2(var_03, param_00);
}

func_A870(param_00, param_01) {
  if(maps\mp\gametypes\_damage::isfriendlyfire(param_00, param_01)) {
    return 0;
  }

  if(param_00 maps\mp\gametypes\_playerlogic::mayspawn()) {
    return 0;
  }

  return 1;
}

func_5742(param_00) {
  foreach(var_02 in level.players) {
    if(var_02 == param_00) {
      continue;
    }

    if(var_02 maps\mp\gametypes\_playerlogic::mayspawn()) {
      return 0;
    }

    if(maps\mp\_utility::isreallyalive(var_02)) {
      return 0;
    }
  }

  return 1;
}

func_6B7F(param_00, param_01, param_02, param_03, param_04) {
  var_05 = maps\mp\gametypes\_rank::getscoreinfovalue(param_00);
  param_01 maps\mp\_utility::func_867B(param_01.extrascore0 + var_05);
  param_01 maps\mp\gametypes\_gamescore::func_A161(param_01, var_05);
  if(func_57BF(param_00)) {
    return 1;
  }

  return 0;
}

func_57BF(param_00) {
  switch (param_00) {
    case "kill":
    case "mg_nest_kill":
      return 1;
  }

  return 0;
}

applybattleroyaleperks() {}

maydropweaponbattleroyale(param_00) {
  if(param_00 == "shovel_mp") {
    return 0;
  }

  dropweaponbattleroyale(param_00);
  return 0;
}

dropweaponbattleroyale(param_00) {
  var_01 = maps\mp\_utility::func_4738(param_00);
  if(var_01[0] == "alt") {
    param_00 = var_01[1];
    for(var_02 = 2; var_02 < var_01.size; var_02++) {
      param_00 = param_00 + "_" + var_01[var_02];
    }
  }

  var_03 = maps\mp\_utility::getbaseweaponname(param_00);
  var_04 = level.brloot[0][var_03];
  var_05 = lootgetgroundpos(self.origin);
  var_05 = var_05 + (0, 0, lootgroundoffset());
  var_06 = self.angles;
  var_07 = lootlocationcreate(var_05, var_06);
  return spawnweaponitem(param_00, var_04, var_07);
}

modifyplayerdamagebattleroyale(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(!maps\mp\_utility::gameflag("prematch_done")) {
    return 0;
  }

  if(!isPlayer(param_00)) {
    return param_03;
  }

  if(isDefined(param_00.var_6E9C) && isDefined(param_02) && param_02 == param_00.var_6E9C) {
    return 0;
  }

  if(param_04 == "MOD_FALLING") {
    return 0;
  }

  if(param_04 == "MOD_IMPACT") {
    return param_03;
  }

  if(param_04 == "MOD_TRIGGER_HURT") {
    return param_03;
  }

  if(param_04 == "MOD_GRENADE_SPLASH") {
    return param_03;
  }

  if(issniperheadshot(param_03, param_05, param_08, param_04, param_02)) {
    return param_03;
  }

  if(hasshotgunequipped(param_02)) {
    return param_03;
  }

  if(maps\mp\_utility::ismeleemod(param_04)) {
    var_0A = maps\mp\_utility::getbaseweaponname(param_05);
    if(maps\mp\gametypes\_weapons::func_5756(param_05) && var_0A != "shovel_mp") {
      return 50;
    } else {
      return 32;
    }
  }

  return int(param_03);
}

issniperheadshot(param_00, param_01, param_02, param_03, param_04) {
  if(!maps\mp\_utility::isbulletdamage(param_03)) {
    return 0;
  }

  if(!maps\mp\_utility::isheadshot(param_01, param_02, param_03, param_04)) {
    return 0;
  }

  if(param_00 < 100) {
    return 0;
  }

  return 1;
}

hasshotgunequipped(param_00) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_01 = param_00 getcurrentweapon();
  if(!isDefined(var_01)) {
    return 0;
  }

  var_02 = function_01AA(var_01);
  if(isDefined(var_02) && var_02 == "spread") {
    return 1;
  }

  return 0;
}

getparachuteinsertiondelay() {
  return getdvarint("scr_br_insertion_delay");
}

waittospawnplayers() {
  level endon("game_ended");
  maps\mp\_utility::gameflagwait("prematch_done");
  var_00 = maps\mp\_utility::getpotentiallivingplayers();
  var_01 = common_scripts\utility::array_randomize(var_00);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    var_03 = var_01[var_02];
    if(!isDefined(var_03.selectedspawnnode)) {
      var_04 = getrandomspawnnodeforplayer(var_03);
      var_03 playerclaimspawnnode(var_04);
    }
  }

  if(level.prematchperiod > 0) {
    var_05 = getparachuteinsertiondelay();
    if(var_05 > 0) {
      wait(var_05);
    }
  }

  foreach(var_03 in var_00) {
    var_03.selectedspawnnode = undefined;
    var_03 notify("start_insertion");
  }

  foreach(var_09 in level.claimednodes) {
    var_09.var_230E = undefined;
  }

  level.claimednodes = [];
  maps\mp\_utility::gameflagset("players_deployed");
}

playerhideteamchoiceonselect() {
  self endon("disconnect");
  self waittill("joined_team");
  thread maps\mp\gametypes\_playerlogic::func_8753(-1);
}

playerpartnerthink() {
  if(!isDefined(self.var_6E9C)) {
    return;
  }

  self endon("disconnect");
  self endon("death");
  self.var_6E9C endon("disconnect");
  if(isDefined(self.var_3EDE)) {
    self.var_3EDE destroy();
  }

  self.game_extrainfo = self.var_6E9C getentitynumber();
  self.var_6E9C hudoutlineenableforclient(self, 2, 1);
  self.var_3EDE = newclienthudelem(self);
  self.var_3EDE setshader("waypoint_escort", 1, 1);
  self.var_3EDE setwaypoint(1, 1, 0);
  self.var_3EDE settargetEnt(self.var_6E9C);
  self.var_3EDE.hidewheninmenu = 1;
  self.var_3EDE.alpha = 1;
}

playerpartnerpick() {
  foreach(var_01 in level.players) {
    if(var_01 == self) {
      continue;
    }

    if(isDefined(var_01.var_6E9C)) {
      continue;
    }

    return var_01;
  }

  return undefined;
}

playerpartnersetup() {
  if(!common_scripts\utility::func_562E(level.partners)) {
    return;
  }

  if(!isDefined(self.var_6E9C)) {
    var_00 = playerpartnerpick();
    if(isDefined(var_00)) {
      self.var_6E9C = var_00;
      var_00.var_6E9C = self;
      var_00 thread playerpartnerthink();
    }
  }

  if(isDefined(self.var_6E9C)) {
    thread playerpartnerthink();
  }
}

playertargetedspawn() {
  self endon("disconnect");
  if(getdvarint("scr_br_showPlayersOnMap", 1)) {
    self setperk("specialty_radarblip", 1, 0);
  }

  self nametagvisibleto("none");
  maps\mp\_utility::freezecontrolswrapper(1);
  spawnselectioncreateoverlay();
  self setaltsceneobj("mute_all");
  thread playersetupparachute();
  thread playerselectspawnlocation();
  level waittill("prematch_done");
  self notify("stop_location_selection");
  thread playerparachutecountdown();
  self waittill("start_insertion");
  self setclientomnvar("ui_map_location_selector", 0);
  self method_8627("mute_all");
  thread spawnselectionremoveoverlay();
  maps\mp\_utility::freezecontrolswrapper(0);
  self nametagvisibleto("all");
  self unsetperk("specialty_radarblip", 1);
  playerparachuteinsertion();
  self luinotifyevent(&"ui_init_round", 0);
}

playerparachutecountdown() {
  var_00 = getparachuteinsertiondelay();
  for(var_01 = int(var_00); var_01 > 0; var_01--) {
    self iprintlnbold(&"MPUI_MTX1_BR_DEPLOYING_IN_X", var_01);
    wait(1);
  }

  self iprintlnbold("");
}

spawnselectioncreateoverlay() {
  if(!isPlayer(self)) {
    return;
  }

  var_00 = newclienthudelem(self);
  var_00 setshader("black", 640, 480);
  var_00.sort = 1;
  var_00.horzalign = "fullscreen";
  var_00.vertalign = "fullscreen";
  var_00.alpha = 1;
  var_00.foreground = 0;
  self.spawnselectionoverlay = var_00;
}

spawnselectionremoveoverlay() {
  var_00 = self.spawnselectionoverlay;
  if(isDefined(var_00)) {
    var_00 endon("death");
    var_00 fadeovertime(0.5);
    var_00.alpha = 0;
    wait(1);
    var_00 destroy();
  }
}

playerselectspawnlocation() {
  self endon("disconnect");
  var_00 = 2;
  var_01 = 0;
  var_02 = 0.05;
  if(!isDefined(level.mapsize)) {
    level.mapsize = 1024;
  }

  var_03 = level.mapsize * var_02;
  self setclientomnvar("ui_map_location_selector", var_00);
  self method_8320("map_artillery_selector", var_01, var_03);
  playermonitorspawnselections();
  self method_8321();
}

isvalidspawnnode(param_00) {
  if(!nodeexposedtosky(param_00, 1)) {
    return 0;
  }

  var_01 = param_00.origin + (0, 0, 3000);
  if(!capsuletracepassed(param_00.origin, 15, 70, self, 0, 0, 0, var_01)) {
    return 0;
  }

  return 1;
}

getnodeclearanceforplayer(param_00, param_01) {
  if(!isDefined(param_00.var_230E) || param_00.var_230E == param_01) {
    return 0;
  }

  var_02 = param_00.var_230E.team;
  if(isDefined(var_02) && isDefined(param_01.team)) {
    if(var_02 == param_01.team) {
      return 1024;
    } else {
      return 16384;
    }
  }

  return 0;
}

nodecanbeclaimedbyplayer(param_00, param_01) {
  foreach(var_03 in level.claimednodes) {
    var_04 = getnodeclearanceforplayer(var_03, param_01);
    if(distance2dsquared(param_00.origin, var_03.origin) < var_04) {
      return 0;
    }
  }

  return 1;
}

getalternatespawnnode(param_00, param_01) {
  var_02 = 1;
  var_03 = 1024;
  var_04 = 1024;
  for(var_05 = 0; var_05 < 10; var_05++) {
    var_06 = getnodesinradiussorted(param_00.origin, var_03, var_02, 10000, "path");
    foreach(param_00 in var_06) {
      if(!isvalidspawnnode(param_00)) {
        continue;
      }

      if(!nodecanbeclaimedbyplayer(param_00, param_01)) {
        continue;
      }

      return param_00;
    }

    var_02 = var_03;
    var_03 = var_03 + var_04;
  }

  return undefined;
}

getrandomspawnnodeforplayer(param_00) {
  var_01 = [];
  var_02 = getallnodes();
  foreach(var_04 in var_02) {
    if(common_scripts\utility::func_562E(var_04.var_2307)) {
      continue;
    }

    if(!isvalidspawnnode(var_04)) {
      continue;
    }

    if(!nodecanbeclaimedbyplayer(var_04, param_00)) {
      continue;
    }

    var_01[var_01.size] = var_04;
  }

  var_06 = common_scripts\utility::random(var_01);
  return var_06;
}

playermonitorspawnselections() {
  self endon("stop_location_selection");
  var_00 = undefined;
  for(;;) {
    if(isDefined(var_00)) {
      self iprintlnbold(var_00);
      var_00 = undefined;
    }

    self waittill("confirm_location", var_01, var_02);
    var_03 = getgroundposition(var_01, 15, 0, 30000);
    if(!isDefined(var_03)) {
      var_00 = &"MPUI_MTX1_BR_SPAWN_ERROR_GROUND";
      continue;
    }

    var_04 = getnodesinradiussorted(var_03, 128, 0, 10000, "path");
    if(var_04.size < 1) {
      var_00 = &"MPUI_MTX1_BR_SPAWN_ERROR_PATH";
      continue;
    }

    var_05 = undefined;
    for(var_06 = 0; var_06 < var_04.size; var_06++) {
      var_07 = var_04[var_06];
      if(!isvalidspawnnode(var_07)) {
        var_00 = &"MPUI_MTX1_BR_SPAWN_ERROR_SKY";
        continue;
      }

      var_05 = var_07;
      break;
    }

    if(isDefined(var_05)) {
      var_00 = undefined;
      if(!nodecanbeclaimedbyplayer(var_05, self)) {
        var_00 = &"MPUI_MTX1_BR_SPAWN_ERROR_PROXIMITY";
        continue;
      }

      playerclaimspawnnode(var_05);
    }
  }
}

playerunclaimcurrentnode() {
  if(isDefined(self.selectedspawnnode)) {
    self.selectedspawnnode.var_230E = undefined;
    level.claimednodes = common_scripts\utility::func_F93(level.claimednodes, self.selectedspawnnode);
    self.selectedspawnnode = undefined;
  }
}

playerclaimspawnnode(param_00) {
  playerunclaimcurrentnode();
  self.selectedspawnnode = param_00;
  param_00.var_230E = self;
  level.claimednodes[level.claimednodes.size] = param_00;
  self setOrigin(param_00.origin, 1);
  var_01 = level.var_5FEB - param_00.origin;
  self setplayerangles((0, vectortoyaw(var_01), 0));
}

playersetupparachute() {
  level endon("game_ended");
  self endon("disconnect");
  wait(0.5);
  self disableweaponswitch();
  self method_812A(0);
  if(!isbot(self)) {
    self giveweapon("br_parachute_mp");
    self switchtoweaponimmediate("br_parachute_mp");
    return;
  }

  self disableweapons();
}

playerteardownparachute() {
  self method_812A(1);
  if(!isbot(self)) {
    thread playerswitchtodefaultweapon();
    return;
  }

  self enableweapons();
}

playerswitchtodefaultweapon() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self switchtoweapon("shovel_mp");
  wait(1);
  self takeweapon("br_parachute_mp");
  self enableweaponswitch();
}

playerparachuteinsertion() {
  self endon("disconnect");
  var_00 = self.origin;
  var_01 = var_00 + (0, 0, 3000);
  var_02 = spawn("script_model", var_01);
  var_02 setModel("tag_origin");
  var_02.origin = var_01;
  var_02.angles = self.angles;
  var_02 method_808C();
  var_03 = var_02 gettagorigin("tag_origin");
  self setOrigin(var_03);
  self playerlinkTo(var_02, "tag_origin", 0, 180, 180, 0, 60, 0);
  self method_808C();
  var_04 = spawn("script_model", var_02.origin);
  var_04 setModel("usa_human_parachute");
  var_04.var_62A0 = 0.5;
  var_04.origin = self.origin;
  var_04.angles = self.angles;
  var_04 linkTo(self, "tag_origin", (0, 3, 20), (0, 90, 0));
  var_04 method_808C();
  wait 0.05;
  thread playerparachutedrop(var_00[2]);
  thread playerparachutecleanup(var_04, var_02);
  self playerparachutestartdeploy();
  var_02 moveTo(var_00, 7);
}

playerparachutedrop(param_00) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  for(;;) {
    if(self.origin[2] < param_00 + 100) {
      break;
    }

    wait(0.1);
  }

  self notify("parachute_detach");
}

playerparachutecleanup(param_00, param_01) {
  level endon("game_ended");
  common_scripts\utility::waittill_any("disconnect", "death", "parachute_detach");
  if(isDefined(self) && isalive(self)) {
    self playerparachutesetactive(0);
    self unlink();
    playerteardownparachute();
  }

  param_00 method_8278("human_parachute_detach_d", "finished_parachute_detach");
  param_00 setmaterialscriptparam(1, 1, 0);
  param_00 setModel("usa_human_parachute_fade");
  var_02 = 1;
  param_00 setmaterialscriptparam(1, 0, var_02);
  param_00 common_scripts\utility::func_2CBE(1.25, ::delete);
  param_01 common_scripts\utility::func_2CBE(3, ::delete);
}

runshrinkingcircle() {
  level.circleobjective = initshrinkingcircle();
  level.circleobjective circlepauseatradius(level.circleobjective.var_78CA);
  if(level.prematchperiod > 0) {
    maps\mp\_utility::gameflagwait("players_deployed");
  } else {
    while(!level.firstplayerspawned) {
      wait 0.05;
    }
  }

  wait(7);
  wait(5);
  level.circleobjective thread movecircle();
}

initshrinkingcircle() {
  precachempanim("mp_br_pubg_circle_shrink");
  var_00 = spawnStruct();
  var_00 = initstartlocation(var_00);
  var_00 = circleobjectivebuildpath(var_00);
  var_00.centerent = spawn("script_model", var_00.var_6EB7[0]);
  var_00.centerent setModel("tag_origin");
  var_00.visualents = [];
  for(var_01 = 0; var_01 <= 3; var_01++) {
    var_00.visualents[var_01] = spawn("script_model", var_00.var_9255);
    var_00.visualents[var_01] setModel("br_dome_barrier_01");
    var_00.visualents[var_01].angles = (0, var_01 * 90, 0);
    var_00.visualents[var_01] linkTo(var_00.centerent);
  }

  var_02 = var_00.visualents[0] gettagorigin("tag_circle_01");
  var_00.radiusent = spawn("script_model", var_02);
  var_00.radiusent setModel("tag_origin");
  var_00.radiusent linkTo(var_00.visualents[0], "tag_circle_01");
  setomnvar("ui_br_circle_ent", var_00.visualents[0] getentitynumber());
  var_00.var_8BE = 0;
  return var_00;
}

initstartlocation(param_00) {
  level.brlevelmins = (99999, 99999, 99999);
  level.brlevelmaxs = (-99999, -99999, -99999);
  var_01 = 10;
  var_02 = 15;
  var_03 = getallnodes();
  foreach(var_05 in var_03) {
    level.brlevelmins = lib_050D::func_3915(level.brlevelmins, var_05.origin);
    level.brlevelmaxs = lib_050D::func_3914(level.brlevelmaxs, var_05.origin);
  }

  var_07 = level.brlevelmaxs + level.brlevelmins / 2;
  var_08 = 0;
  foreach(var_05 in var_03) {
    var_0A = distance2d(var_07, var_05.origin);
    if(var_0A > var_08) {
      var_08 = var_0A;
    }
  }

  var_0C = var_08;
  var_0D = getnodesinradiussorted(var_07, 512, 0);
  if(var_0D.size) {
    param_00.start_node = var_0D[0];
    var_07 = (param_00.start_node.origin[0], param_00.start_node.origin[1], var_07[2]);
    var_0E = distance2d(param_00.start_node.origin, var_07);
    var_0C = var_0C + var_0E;
  }

  if(var_0C > 9980.87) {
    var_0C = 9980.87;
    var_0F = 9980.87;
  }

  var_10 = 400;
  if(var_10 < 94.21683) {
    var_10 = 94.21683;
  }

  param_00.touching = [];
  param_00.var_9255 = var_07;
  param_00.var_78CA = var_0C;
  param_00.radius_end = var_10;
  param_00.radius_speed = var_01;
  param_00.move_speed = var_02;
  param_00.move_time = param_00.var_78CA - param_00.radius_end / param_00.radius_speed;
  return param_00;
}

circleobjectivebuildpath(param_00) {
  param_00.var_6EB7 = [];
  if(isDefined(param_00.start_node)) {
    var_01 = getallnodes();
    param_00.var_6EB7[0] = param_00.start_node.origin;
    var_02 = param_00.start_node;
    var_03 = param_00.move_time * param_00.move_speed;
    var_04 = 0;
    while(!var_04) {
      for(;;) {
        var_05 = var_01[randomint(var_01.size)];
        var_06 = getnodesonpath(var_02.origin, var_05.origin, 1, var_02, var_05);
        if(isDefined(var_06)) {
          break;
        }
      }

      for(var_07 = 1; var_07 < var_06.size; var_07++) {
        var_08 = distance2d(var_02.origin, var_06[var_07].origin);
        if(var_08 < var_03) {
          var_03 = var_03 - var_08;
          param_00.var_6EB7[param_00.var_6EB7.size] = (var_06[var_07].origin[0], var_06[var_07].origin[1], param_00.var_6EB7[0][2]);
          var_02 = var_06[var_07];
          continue;
        }

        var_04 = 1;
        break;
      }
    }
  } else {
    param_00.var_6EB7[0] = param_00.var_9255 + (0, 0, 64);
  }

  return param_00;
}

circlepauseatradius(param_00) {
  var_01 = circleanimstartoffset(param_00);
  circleplayanim(var_01, 1);
  circlepauseanim();
}

circleanimstartoffset(param_00) {
  var_01 = 164.7776;
  var_02 = 9980.87 - param_00 / var_01;
  return var_02;
}

circleplayanim(param_00, param_01) {
  foreach(var_03 in self.visualents) {
    var_03 scriptmodelplayanim("mp_br_pubg_circle_shrink", "br_circle", param_00, param_01);
  }
}

circlepauseanim() {
  foreach(var_01 in self.visualents) {
    var_01 scriptmodelpauseanim(1);
  }
}

movecircle() {
  level endon("game_ended");
  self.centerent.origin = self.var_6EB7[0];
  self.var_9297 = gettime();
  self.var_36AD = self.var_9297 + self.move_time * 1000;
  var_00 = self.var_36AD - self.var_9297 / 1000;
  var_01 = self.var_78CA - self.radius_end;
  var_02 = 164.7776;
  var_03 = var_01 / var_00;
  var_04 = var_03 / var_02;
  var_05 = circleanimstartoffset(self.var_78CA);
  circleplayanim(var_05, var_04);
  level thread stopanimationatradius(self);
  self.var_8BE = 1;
  for(var_06 = 1; var_06 < self.var_6EB7.size; var_06++) {
    var_07 = distance2d(self.var_6EB7[var_06 - 1], self.var_6EB7[var_06]);
    var_08 = var_07 / self.move_speed;
    self.centerent moveTo(self.var_6EB7[var_06], var_08);
    self.centerent waittill("movedone");
  }
}

stopanimationatradius(param_00) {
  level endon("game_ended");
  var_01 = param_00.var_36AD - gettime() / 1000;
  wait(var_01);
  param_00 circlepauseanim();
}

playercircleaudio() {
  var_00 = self;
  var_00 endon("death");
  var_00 endon("disconnect");
  while(!level.circleobjective.var_8BE) {
    wait 0.05;
  }

  var_01 = level.circleobjective.centerent getentitynumber();
  var_02 = level.circleobjective.radiusent getentitynumber();
  var_00 method_85A7("BRModeInit", var_01, var_02);
}

playermonitorcircle() {
  self endon("death");
  self endon("disconnect");
  var_00 = 1000;
  var_01 = 10;
  var_02 = 500;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  while(!level.circleobjective.var_8BE) {
    wait 0.05;
  }

  for(;;) {
    var_06 = level.circleobjective circleobjectivecurretradius();
    var_07 = var_06 * var_06;
    var_08 = distance2dsquared(self.origin, level.circleobjective.centerent.origin);
    var_09 = var_08 > var_07;
    if(var_09) {
      if(!var_03) {
        self setclientomnvar("ui_br_is_out_of_bounds", 1);
        var_04 = gettime();
        var_05 = gettime() + var_00;
      }

      if(gettime() >= var_05) {
        self dodamage(var_01, level.circleobjective.centerent.origin);
        var_05 = var_05 + var_02;
      }
    } else if(!var_03) {
      self setclientomnvar("ui_br_is_out_of_bounds", 0);
    }

    wait 0.05;
    var_03 = var_09;
  }
}

circleobjectivecurretradius() {
  var_00 = gettime() - self.var_9297;
  var_01 = self.var_36AD - self.var_9297;
  var_02 = min(var_00 / var_01, 1);
  var_03 = self.var_78CA - self.radius_end;
  var_04 = self.var_78CA - var_02 * var_03;
  return max(var_04, self.radius_end);
}

weaponenumtostring(param_00) {
  switch (param_00) {
    case 0:
      return "AR";

    case 1:
      return "AR Semi";

    case 2:
      return "SMG";

    case 3:
      return "LMG";

    case 4:
      return "Sniper";

    case 5:
      return "Shotgun";

    case 6:
      return "Pistol";

    case 7:
      return "Launcher";

    case 8:
      return "Melee";

    default:
      return "Unknown";
  }
}

initloot() {
  level.brloot = [];
  level.brloot[0] = [];
  level.brloot[1] = [];
  level.brlootchancetotal = [];
  level.brlootchancetotal[0] = 0;
  level.brlootchancetotal[1] = 0;
  addlootweapon("m1941_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 0);
  addlootweapon("stg44_mp", 3, 1, (5, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 0);
  addlootweapon("fg42_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 0);
  addlootweapon("bar_mp", 1, 1, (0, 0, 0), (0, 0, 0), "orange", 1, 1, 1, 0);
  addlootweapon("svt40_mp", 5, 1, (0, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 1);
  addlootweapon("m1a1_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 1);
  addlootweapon("m1garand_mp", 0, 1, (0, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 1);
  addlootweapon("greasegun_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 2);
  addlootweapon("ppsh41_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 2);
  addlootweapon("type100_mp", 4, 1, (3, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 2);
  addlootweapon("mp28_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 2);
  addlootweapon("thompson_mp", 0, 1, (10, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 2);
  addlootweapon("mp40_mp", 1, 1, (3, 0, 0), (0, 0, 0), "orange", 3, 1, 1, 2);
  addlootweapon("lewis_mp", 0, 1, (0, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 3);
  addlootweapon("mg15_mp", 4, 1, (0, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 3);
  addlootweapon("bren_mp", 0, 1, (0, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 3);
  addlootweapon("mg42_mp", 1, 1, (0, 0, 0), (0, 0, 0), "orange", 3, 1, 1, 3);
  addlootweapon("karabin_mp", 0, 1, (0, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 4);
  addlootweapon("leeenfield_mp", 3, 1, (0, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 4);
  addlootweapon("springfield_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 4);
  addlootweapon("kar98_mp", 1, 1, (0, 0, 0), (0, 0, 0), "orange", 1, 1, 1, 4);
  addlootweapon("winchester1897_mp", 4, 1, (3, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 5);
  addlootweapon("m30_mp", 0, 1, (0, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 5);
  addlootweapon("walther_mp", 1, 1, (0, 0, 0), (0, 0, 0), "orange", 3, 1, 1, 5);
  addlootweapon("model21_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 5);
  addlootweapon("luger_mp", 15, 1, (10, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 6);
  addlootweapon("m1911_mp", 0, 1, (10, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 6);
  addlootweapon("m712_mp", 15, 1, (10, 0, 0), (0, 0, 0), "orange", 1, 0, 0, 6);
  addlootweapon("panzerschreck_mp", 0, 1, (5, 0, 0), (0, 0, 0), "orange", 2, 0, 0, 7);
  addlootweapon("bazooka_mp", 1, 1, (12, 0, 0), (0, 0, 0), "orange", 2, 0, 0, 7);
  addlootpickup("ammo", 10, 0, (0, 0, -10), (0, 0, 0), "blue", "usa_foragepack_org1", &"MPUI_MTX1_BR_PICKUP_AMMO", ::onpickupammo);
  addlootpickup("armor", 10, 0, (0, 0, 0), (0, 0, 0), "blue", "raid_deployable_armor", &"MPUI_MTX1_BR_PICKUP_ARMOR", ::onpickuparmor, ::canpickuparmor);
  addlootpickup("medkit", 10, 0, (0, 0, 0), (90, 0, 0), "red", "npc_throwable_usa_morale_health", &"MPUI_MTX1_BR_PICKUP_MEDKIT", ::onpickupmedkit, ::canpickupmedkit);
  addlootpickup("frag_grenade_mp", 10, 0, (0, 0, 0), (0, 0, 0), "yellow", "npc_usa_frag", &"MPUI_MTX1_BR_PICKUP_FRAG", ::onpickuplethal);
  addlootpickup("semtex_mp", 3, 0, (0, 0, 0), (0, 0, 0), "yellow", "npc_eng_n74_mk1_sticky", &"MPUI_MTX1_BR_PICKUP_STICKY", ::onpickuplethal);
  addlootpickup("smoke_grenade_mp", 10, 0, (0, 0, 0), (0, 0, 0), "green", "npc_usa_m18_smoke", &"MPUI_MTX1_BR_PICKUP_SMOKE", ::onpickuptactical);
  addlootpickup("stun_grenade_mp", 10, 0, (0, 0, 0), (0, 0, 0), "green", "npc_eng_no69_stun", &"MPUI_MTX1_BR_PICKUP_STUN", ::onpickuptactical);
  addlootpickup("perk_agility", 10, 0, (0, 0, 0), (0, 0, 0), "green", "perk_agility_3d", &"MP_PERK_PICKUP_FASTHANDS", ::onpickupperk, ::canpickupperk);
  addlootpickup("perk_anteup", 10, 0, (0, 0, 0), (0, 0, 0), "green", "perk_anteup_3d", &"MP_PERK_PICKUP_GENERIC", ::onpickupperk, ::canpickupperk);
  addlootpickup("perk_deadsilence", 10, 0, (0, 0, 0), (0, 0, 0), "green", "perk_deadsilence_3d", &"MP_PERK_PICKUP_LOWPROFILE", ::onpickupperk, ::canpickupperk);
  addlootpickup("perk_doubleagent", 10, 0, (0, 0, 0), (0, 0, 0), "green", "perk_doubleagent_3d", &"MP_PERK_PICKUP_GENERIC", ::onpickupperk, ::canpickupperk);
  addlootpickup("perk_flakjacket", 10, 0, (0, 0, 0), (0, 0, 0), "green", "perk_flakjacket_3d", &"MP_PERK_PICKUP_FLAKJACKET", ::onpickupperk, ::canpickupperk);
  addlootpickup("perk_gunslinger", 10, 0, (0, 0, 0), (0, 0, 0), "green", "perk_gunslinger_3d", &"MP_PERK_PICKUP_GUNHO", ::onpickupperk, ::canpickupperk);
  addlootpickup("perk_lightweight", 10, 0, (0, 0, 0), (0, 0, 0), "green", "perk_lightweight_3d", &"MP_PERK_PICKUP_LIGHTWEIGHT", ::onpickupperk, ::canpickupperk);
  addlootpickup("perk_marathon", 10, 0, (0, 0, 0), (0, 0, 0), "green", "perk_marathon_3d", &"MP_PERK_PICKUP_GENERIC", ::onpickupperk, ::canpickupperk);
  addlootpickup("perk_marksman", 10, 0, (0, 0, 0), (0, 0, 0), "green", "perk_marksman_3d", &"MP_PERK_PICKUP_GENERIC", ::onpickupperk, ::canpickupperk);
  addlootpickup("perk_perception", 10, 0, (0, 0, 0), (0, 0, 0), "green", "perk_perception_3d", &"MP_PERK_PICKUP_PERIPHERALS", ::onpickupperk, ::canpickupperk);
  addlootpickup("perk_scavenger", 10, 0, (0, 0, 0), (0, 0, 0), "green", "perk_scavenger_3d", &"MP_PERK_PICKUP_SCAVENGER", ::onpickupperk, ::canpickupperk);
  addlootpickup("perk_dexterity", 10, 0, (0, 0, 0), (0, 0, 0), "green", "perk_shieldofhand_3d", &"MP_PERK_PICKUP_DEXTERITY", ::onpickupperk, ::canpickupperk);
  addlootpickup("perk_strongarm", 10, 0, (0, 0, 0), (0, 0, 0), "green", "perk_strongarm_3d", &"MP_PERK_PICKUP_GENERIC", ::onpickupperk, ::canpickupperk);
  addlootpickup("perk_tacticalmask", 10, 0, (0, 0, 0), (0, 0, 0), "green", "perk_tacticalmask_3d", &"MP_PERK_PICKUP_TOUGHNESS", ::onpickupperk, ::canpickupperk);
  waittillframeend;
  initlootlocations();
  level.brlootlocationnext = 0;
  level.brlootlocationnum = level.brlootlocations[0].size;
  level.brlootlocations[0] = common_scripts\utility::array_randomize(level.brlootlocations[0]);
  spawnlootset("luger_mp", 20);
  spawnlootset("m712_mp", 20);
  spawnlootset("winchester1897_mp", 4);
  spawnlootset("walther_mp", 1);
  spawnlootset("leeenfield_mp", 4);
  spawnlootset("kar98_mp", 1);
  spawnlootset("mg15_mp", 4);
  spawnlootset("mg42_mp", 1);
  spawnlootset("type100_mp", 4);
  spawnlootset("mp40_mp", 2);
  spawnlootset("svt40_mp", 4);
  spawnlootset("stg44_mp", 2);
  spawnlootset("bar_mp", 1);
  spawnlootset("armor", 30);
  spawnlootset("ammo", 30);
  spawnlootset("medkit", 20);
  spawnlootset("frag_grenade_mp", 10);
  spawnlootset("semtex_mp", 10);
  spawnlootset("smoke_grenade_mp", 10);
  spawnlootset("stun_grenade_mp", 10);
  spawnlootset("perk_agility", 5);
  spawnlootset("perk_anteup", 5);
  spawnlootset("perk_deadsilence", 5);
  spawnlootset("perk_doubleagent", 5);
  spawnlootset("perk_flakjacket", 5);
  spawnlootset("perk_gunslinger", 5);
  spawnlootset("perk_lightweight", 5);
  spawnlootset("perk_marathon", 5);
  spawnlootset("perk_marksman", 5);
  spawnlootset("perk_perception", 5);
  spawnlootset("perk_scavenger", 5);
  spawnlootset("perk_dexterity", 5);
  spawnlootset("perk_strongarm", 5);
  spawnlootset("perk_tacticalmask", 5);
}

addlootcommon(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(isDefined(level.brloot[0][param_00])) {
    return;
  }

  var_06 = spawnStruct();
  var_06.name = param_00;
  var_06.originoffset = param_03;
  var_06.anglesoffset = param_04;
  var_06.var_3F74 = param_05;
  var_06.loottype = 0;
  var_06.var_9040 = 0;
  var_06.chancerangestart = [];
  var_06.chancerangeend = [];
  var_07 = [];
  var_07[0] = param_01;
  var_07[1] = common_scripts\utility::func_98E7(param_02, param_01, 0);
  for(var_08 = 0; var_08 < 2; var_08++) {
    var_06.chancerangestart[var_08] = level.brlootchancetotal[var_08];
    level.brlootchancetotal[var_08] = level.brlootchancetotal[var_08] + var_07[var_08];
    var_06.chancerangeend[var_08] = level.brlootchancetotal[var_08];
    level.brloot[var_08][param_00] = var_06;
  }

  return var_06;
}

addlootpickup(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = addlootcommon(param_00, param_01, param_02, param_03, param_04, param_05);
  var_0A.loottype = 2;
  var_0A.model = param_06;
  var_0A.var_C5 = param_07;
  var_0A.onpickupfunc = param_08;
  var_0A.canpickupfunc = param_09;
}

addlootweapon(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  var_0A = addlootcommon(param_00, param_01, param_02, param_03, param_04, param_05);
  var_0A.loottype = 1;
  var_0A.startclips = param_06;
  var_0A.attachment1chance = param_07;
  var_0A.attachment2chance = param_08;
  var_0A.weapontypeenum = param_09;
}

initlootlocations() {
  level.brlootlocations = [];
  for(var_00 = 0; var_00 < 3; var_00++) {
    level.brlootlocations[var_00] = [];
  }

  var_01 = common_scripts\utility::func_46B7("br_loot_location", "targetname");
  common_scripts\utility::array_thread(var_01, ::lootlocationinit, 0);
  var_01 = common_scripts\utility::func_46B7("br_loot_location_force_use", "targetname");
  common_scripts\utility::array_thread(var_01, ::lootlocationinit, 1);
  if(!var_01.size) {
    addpathnodelootlocations();
  }
}

lootlocationinit(param_00) {
  self.origin = self.origin + (0, 0, lootgroundoffset());
  self.forceuse = param_00;
  level.brlootlocations[0][level.brlootlocations[0].size] = self;
  if(param_00) {
    level.brlootlocations[1][level.brlootlocations[1].size] = self;
    return;
  }

  level.brlootlocations[2][level.brlootlocations[2].size] = self;
}

addpathnodelootlocations() {
  var_00 = 2;
  var_01 = 25;
  var_02 = lootpathnodesoutside();
  var_03 = lootpathnodesinsideparial();
  var_04 = lootpathnodesinsidecomplete();
  level.brinteriors = [];
  var_05 = getallnodes();
  var_05 = common_scripts\utility::array_randomize(var_05);
  foreach(var_07 in var_05) {
    if(var_07.type != "Path") {
      continue;
    }

    updateinteriorlocations(var_07);
  }

  var_09 = [];
  foreach(var_0C, var_0B in level.brinteriors) {
    var_09[var_0C] = level.brinteriors[var_0C].size;
  }

  foreach(var_07 in var_05) {
    var_0E = 0;
    if(common_scripts\utility::func_562E(var_07.noloot)) {
      continue;
    }

    if(var_07.type != "Path") {
      continue;
    }

    if(nodeexposedtosky(var_07, 1)) {
      if(randomfloat(1) > var_02) {
        continue;
      }
    } else if(nodeexposedtosky(var_07, 0)) {
      if(randomfloat(1) > var_03) {
        continue;
      }
    } else {
      if(isDefined(var_07.interiorindex)) {
        if(level.brinteriors[var_07.interiorindex].size <= var_00) {
          continue;
        }

        if(var_09[var_07.interiorindex] > 0) {
          var_09[var_07.interiorindex] = var_09[var_07.interiorindex] - var_01;
        }
      }

      if(!var_0E && randomfloat(1) > var_04) {
        continue;
      }
    }

    var_0F = (0, randomfloatrange(0, 360), 0);
    var_10 = addlootlocation(var_07.origin, var_0F, var_0E);
    var_10.node = var_07;
    setnolootonconenctednodes(var_07, var_07, 0, lootpathnodesmindist());
  }
}

updateinteriorlocations(param_00) {
  if(!nodeneedsinteriorindex(param_00)) {
    return;
  }

  var_01 = level.brinteriors.size;
  level.brinteriors[var_01] = [];
  param_00.interiorindex = var_01;
  level.brinteriors[var_01][0] = param_00;
  for(var_02 = 0; var_02 < level.brinteriors[var_01].size; var_02++) {
    var_03 = level.brinteriors[var_01][var_02];
    var_04 = function_0204(var_03);
    foreach(var_06 in var_04) {
      if(nodeneedsinteriorindex(var_06)) {
        var_06.interiorindex = var_01;
        var_07 = level.brinteriors[var_01].size;
        level.brinteriors[var_01][var_07] = var_06;
      }
    }
  }
}

nodeneedsinteriorindex(param_00) {
  return !isDefined(param_00.interiorindex) && !nodeexposedtosky(param_00, 0);
}

setinteriorindex(param_00, param_01) {
  if(isDefined(param_00.interiorindex)) {
    return;
  }

  if(nodeexposedtosky(param_00, 0)) {
    return;
  }

  param_00.interiorindex = param_01;
  var_02 = level.brinteriors[param_01].size;
  level.brinteriors[param_01][var_02] = param_00;
  var_03 = function_0204(param_00);
  foreach(var_05 in var_03) {
    setinteriorindex(var_05, param_01);
  }
}

setnolootonconenctednodes(param_00, param_01, param_02, param_03) {
  param_01.loopcheck = param_00;
  var_04 = function_0204(param_01);
  foreach(var_06 in var_04) {
    if(isDefined(var_06.loopcheck) && var_06.loopcheck == param_00) {
      continue;
    }

    var_07 = distance(param_01.origin, var_06.origin);
    if(param_02 + var_07 < param_03) {
      var_06.noloot = 1;
      if(!isDefined(param_00.nolootnodes)) {
        param_00.nolootnodes = [];
      }

      param_00.nolootnodes[param_00.nolootnodes.size] = var_06;
      setnolootonconenctednodes(param_00, var_06, param_02 + var_07, param_03);
    }
  }
}

lootlocationcreate(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_03.origin = param_00;
  var_03.angles = param_01;
  if(common_scripts\utility::func_562E(param_02)) {
    var_03.targetname = "br_loot_location_force_use";
  } else {
    var_03.targetname = "br_loot_location";
  }

  return var_03;
}

addlootlocation(param_00, param_01, param_02) {
  var_03 = lootlocationcreate(param_00, param_01, param_02);
  common_scripts\utility::func_96C(var_03);
  return var_03;
}

spawnloot(param_00, param_01) {
  switch (param_00.loottype) {
    case 1:
      spawnlootweapon(param_00, param_01);
      break;

    case 2:
      spawnlootpickup(param_00, param_01);
      break;

    case 0:
    default:
      break;
  }
}

spawnlootset(param_00, param_01) {
  var_02 = level.brloot[0][param_00];
  for(var_03 = 0; var_03 < param_01 && level.brlootlocationnext < level.brlootlocationnum; var_03++) {
    spawnloot(var_02, level.brlootlocations[0][level.brlootlocationnext]);
    level.brlootlocationnext++;
  }
}

canpickuparmor(param_00, param_01) {
  if(isDefined(param_01.var_5D2E) && isDefined(param_01.var_6089) && param_01.var_5D2E >= param_01.var_6089) {
    param_01 iprintlnbold(&"MPUI_MTX1_BR_MAX_ARMOR");
    return 0;
  }

  return 1;
}

onpickuparmor(param_00, param_01) {
  param_01 notify("give_light_armor");
  if(!isDefined(param_01.var_5D2E)) {
    param_01.var_5D2E = 0;
    param_01 thread maps\mp\perks\_perkfunctions::func_7CE7();
    param_01 thread maps\mp\perks\_perkfunctions::func_7CE8();
  }

  param_01.var_6089 = 150;
  if(param_01.var_5D2E >= param_01.var_6089) {
    return;
  }

  param_01.var_5D2E = param_01.var_5D2E + 50;
  if(param_01.var_5D2E >= param_01.var_6089) {
    param_01.var_5D2E = param_01.var_6089;
  }

  param_01 maps\mp\perks\_perkfunctions::func_86BC(param_01.var_5D2E);
}

getlootspecialty(param_00) {
  if(param_00 == "perk_agility") {
    return "specialty_sprintreload";
  }

  if(param_00 == "perk_anteup") {
    return "specialty_unwrapper";
  }

  if(param_00 == "perk_deadsilence") {
    return "specialty_quieter";
  }

  if(param_00 == "perk_doubleagent") {
    return "specialty_silentmovement";
  }

  if(param_00 == "perk_flakjacket") {
    return "specialty_blastshield2";
  }

  if(param_00 == "perk_gunslinger") {
    return "specialty_sprintfire";
  }

  if(param_00 == "perk_lightweight") {
    return "specialty_lightweight";
  }

  if(param_00 == "perk_marathon") {
    return "specialty_marathon";
  }

  if(param_00 == "perk_marksman") {
    return "specialty_marksman";
  }

  if(param_00 == "perk_perception") {
    return "specialty_perception";
  }

  if(param_00 == "perk_savenger") {
    return "specialty_quickswap";
  }

  if(param_00 == "perk_dexterity") {
    return "specialty_fastreload";
  }

  if(param_00 == "perk_strongarm") {
    return "specialty_stalker";
  }

  if(param_00 == "perk_tacticalmask") {
    return "specialty_stun_resistance";
  }
}

getlootspecialty2(param_00) {
  if(param_00 == "perk_tacticalmask") {
    return "specialty_immunesmoke";
  }
}

canpickupperk(param_00, param_01) {
  return 1;
}

onpickupperk(param_00, param_01) {}

onpickupammo(param_00, param_01) {
  var_02 = param_01 getweaponslistprimaries();
  foreach(var_04 in var_02) {
    if(maps\mp\_utility::iscacprimaryweapon(var_04) || level.var_808C && maps\mp\_utility::iscacsecondaryweapon(var_04)) {
      var_05 = param_01 getweaponammostock(var_04);
      var_06 = 0;
      var_07 = maps\mp\_utility::getweaponclass(var_04);
      if(maps\mp\gametypes\_weapons::func_5684(var_04) || var_07 == "weapon_riot" || issubstr(var_04, "riotshield")) {} else if(var_07 == "weapon_projectile" || issubstr(var_04, "exocrossbow") || issubstr(var_04, "microdronelauncher")) {
        var_06 = weaponclipsize(var_04);
      } else if(maps\mp\_utility::func_5670(var_04) && issubstr(var_04, "grenade_launcher")) {
        var_06 = weaponclipsize(var_04);
      } else if(maps\mp\_utility::func_5670(var_04) && issubstr(var_04, "dragon_breath")) {} else if(maps\mp\gametypes\_weapons::func_5696(var_04)) {
        var_06 = weaponclipsize(var_04);
      }

      if(var_06 > 0) {
        param_01 setweaponammostock(var_04, var_05 + var_06);
      }
    }
  }
}

onpickuplethal(param_00, param_01) {
  var_02 = param_00;
  var_03 = param_01 getweaponammoclip(var_02);
  param_01 giveweapon(var_02);
  param_01 method_8349(var_02);
  param_01 setweaponammoclip(var_02, var_03 + 1);
}

onpickuptactical(param_00, param_01) {
  var_02 = param_00;
  var_03 = param_01 getweaponammoclip(var_02);
  param_01 giveweapon(var_02);
  param_01 setoffhandsecondaryclass(var_02);
  param_01 setweaponammoclip(var_02, var_03 + 1);
}

pickuponused() {
  self endon("death");
  for(;;) {
    self waittill("trigger", var_00);
    if(!maps\mp\_utility::isreallyalive(var_00)) {
      continue;
    }

    if(isDefined(self.canpickupfunc) && !self[[self.canpickupfunc]](self.lootname, var_00)) {
      continue;
    }

    self[[self.onpickupfunc]](self.lootname, var_00);
    break;
  }

  waittillframeend;
  self delete();
}

spawnlootinitent(param_00, param_01, param_02) {
  var_03 = rotatevector(param_01.originoffset, param_02.angles);
  param_00.origin = param_02.origin + var_03;
  param_00.angles = param_02.angles + param_01.anglesoffset;
  param_00.targetname = "br_loot";
  param_00.loottype = param_01.loottype;
  param_00.lootname = param_01.name;
  param_00.var_3F77 = param_02.origin;
  param_01.var_9040++;
  param_00 hudoutlineenable(0, 1);
}

spawnlootpickup(param_00, param_01) {
  var_02 = spawn("script_model", (0, 0, 0), lootpickupscriptmoverflags());
  var_02 setModel(param_00.model);
  var_02.onpickupfunc = param_00.onpickupfunc;
  var_02.canpickupfunc = param_00.canpickupfunc;
  spawnlootinitent(var_02, param_00, param_01);
  var_02 makeusable();
  var_02 setHintString(param_00.var_C5);
  var_02 thread pickuponused();
}

lootpickupscriptmoverflags() {
  return scriptmoverspawnflagsprintuse();
}

lootweaponitemflags(param_00) {
  var_01 = 0;
  if(lootdroptoground()) {
    var_01 = var_01 | itemspawnflagsuspended();
  }

  if(weaponisakimbo(param_00)) {
    var_01 = var_01 | itemspawnflagakimbo();
  }

  var_01 = var_01 | itemspawnflagsprintuse();
  return var_01;
}

weaponisakimbo(param_00) {
  var_01 = function_0061(param_00, 1);
  foreach(var_03 in var_01) {
    if(issubstr(var_03, "akimbo")) {
      return 1;
    }
  }

  return 0;
}

lootweaponsetstartammo(param_00, param_01, param_02) {
  var_03 = weaponclipsize(param_02);
  var_04 = int(param_01.startclips * var_03);
  if(var_04 > var_03) {
    var_05 = var_03;
    var_06 = var_04 - var_03;
  } else {
    var_05 = var_06;
    var_06 = 0;
  }

  if(weaponisakimbo(param_02)) {
    param_00 method_817E(var_05, var_06 * 2, var_05);
  } else {
    param_00 method_817E(var_05, var_06);
  }

  param_00 method_86B3(0);
}

spawnlootweapon(param_00, param_01) {
  var_02 = param_00.name;
  var_03 = function_0372(param_00.name);
  var_04 = [];
  foreach(var_06 in var_03) {
    if(var_06.size > 2) {
      var_07 = getsubstr(var_06, var_06.size - 2, var_06.size);
      if(var_07 == "_1" || var_07 == "_2") {
        var_04[var_04.size] = var_06;
      }
    }
  }

  foreach(var_0A in var_04) {
    var_03 = common_scripts\utility::func_F93(var_03, var_0A);
  }

  var_0C = function_03A1(param_00.name);
  foreach(var_0E in var_0C) {
    var_03 = common_scripts\utility::func_F93(var_03, var_0E);
  }

  var_10 = ["extended_mag", "telescopic_sight"];
  foreach(var_12 in var_10) {
    var_13 = [];
    foreach(var_06 in var_03) {
      if(issubstr(var_06, var_12)) {
        var_13[var_13.size] = var_06;
      }
    }

    foreach(var_17 in var_13) {
      var_03 = common_scripts\utility::func_F93(var_03, var_17);
    }
  }

  var_1A = undefined;
  var_1B = undefined;
  if(randomfloat(1) < param_00.attachment1chance && var_03.size > 0) {
    var_1A = common_scripts\utility::random(var_03);
    if(randomfloat(1) < param_00.attachment2chance) {
      var_1C = tablelookuprownum("mp/attachmentcombos_mtx12.csv", 0, var_1A);
      var_1D = function_027B("mp/attachmentcombos_mtx12.csv");
      for(var_1E = 0; var_1E < var_1D; var_1E++) {
        var_1F = tablelookupbyrow("mp/attachmentcombos_mtx12.csv", var_1C, var_1E);
        if(var_1F == "no") {
          var_20 = tablelookupbyrow("mp/attachmentcombos_mtx12.csv", 0, var_1E);
          var_03 = common_scripts\utility::func_F93(var_03, var_20);
        }
      }

      if(var_03.size > 0) {
        var_1B = common_scripts\utility::random(var_03);
      }
    }
  }

  if(param_00.weapontypeenum == 4) {
    if(!isDefined(var_1A) || var_1A == "hold_breath_1") {
      var_1A = "hold_breath_3";
    } else if(var_1A != "hold_breath_3") {
      var_1B = "hold_breath_3";
    }
  }

  if(isDefined(var_1A) && isDefined(var_1B)) {
    if(stricmp(var_1A, var_1B) > 0) {
      var_21 = var_1A;
      var_1A = var_1B;
      var_1B = var_21;
    }
  }

  if(isDefined(var_1A)) {
    var_02 = var_02 + "+" + var_1A;
    if(isDefined(var_1B)) {
      var_02 = var_02 + "+" + var_1B;
    }
  }

  spawnweaponitem(var_02, param_00, param_01);
}

spawnweaponitem(param_00, param_01, param_02) {
  var_03 = "weapon_" + param_00;
  var_04 = spawn(var_03, (0, 0, 0), lootweaponitemflags(param_00));
  spawnlootinitent(var_04, param_01, param_02);
  lootweaponsetstartammo(var_04, param_01, param_00);
  var_04 thread maps\mp\gametypes\_weapons::func_A934();
  var_04 thread lootweaponwatchpickup();
  return var_04;
}

lootweaponwatchpickup() {
  self endon("death");
  var_00 = maps\mp\gametypes\_weapons::func_452C();
  for(;;) {
    self waittill("trigger", var_01, var_02, var_03, var_04, var_05);
    if(!isDefined(var_03) || !isDefined(var_04)) {
      continue;
    }

    if(var_03 == var_04) {
      if(var_03) {
        return;
      }

      continue;
    }

    break;
  }

  if(isDefined(var_00) && var_00 == var_01.primaryweapon) {
    return;
  }

  if(isDefined(var_00) && var_00 == var_01.var_835A) {
    return;
  }

  var_06 = 0;
  var_07 = var_01 getweaponslistprimaries();
  foreach(var_09 in var_07) {
    if(isDefined(var_09) && var_09 == "shovel_mp") {
      var_06 = 1;
      break;
    }
  }

  if(var_06) {
    if(isDefined(var_02)) {
      var_01 takeweapon("shovel_mp");
      maps\mp\gametypes\_weapons::updateplayervariablesforweaponexchange(var_01, "shovel_mp", var_00);
      var_0B = var_02 maps\mp\gametypes\_weapons::func_452C();
      var_01 giveweapon(var_0B);
      var_0C = var_02 method_85F2();
      var_01 setweaponammoclip(var_0B, var_0C["clip_ammo"]);
      var_01 setweaponammostock(var_0B, var_0C["stock_ammo"]);
      var_02 delete();
      return;
    }

    var_0D = var_01.currentweapon;
    if(shouldrestoreweapontoplayer(var_0D, var_01)) {
      var_01 takeweapon("shovel_mp");
      maps\mp\gametypes\_weapons::updateplayervariablesforweaponexchange(var_01, "shovel_mp", var_00);
      var_01 giveweapon(var_0D);
      var_01 setweaponammoclip(var_0D, 0);
      var_01 setweaponammostock(var_0D, 0);
      return;
    }

    return;
  }

  if(isDefined(var_03)) {
    var_0B = var_03 maps\mp\gametypes\_weapons::func_452C();
    var_0E = var_02 dropweaponbattleroyale(var_0B);
    var_0F = var_03 method_85F2();
    var_10 = var_0F["clip_ammo"];
    var_11 = var_0F["stock_ammo"];
    var_12 = var_0F["clip_ammo_left"];
    if(!isDefined(var_12)) {
      var_12 = 0;
    }

    var_0E method_817E(var_10, var_11, var_12);
    maps\mp\gametypes\_weapons::updateplayervariablesforweaponexchange(var_02, var_0B, var_01);
    var_03 delete();
  }
}

shouldrestoreweapontoplayer(param_00, param_01) {
  if(!isDefined(param_00)) {
    return 0;
  }

  if(param_00 == "shovel_mp") {
    return 0;
  }

  if(param_01 hasweapon(param_00)) {
    return 0;
  }

  var_02 = maps\mp\_utility::getbaseweaponname(param_00);
  if(!isDefined(level.brloot[0][var_02])) {
    return 0;
  }

  if(level.brloot[0][var_02].loottype != 1) {
    return 0;
  }

  return 1;
}

spawnlootfx(param_00, param_01) {
  param_00 endon("death");
  if(param_00.loottype == 1) {
    if(!param_00.spawnflags &itemspawnflagsuspended()) {
      var_02 = param_00.origin + (0, 0, 1);
      while(var_02 != param_00.origin) {
        var_02 = param_00.origin;
        wait 0.05;
      }
    }
  }

  var_03 = spawnfx(level.br_fx["weapon_pickup_" + param_01], param_00.var_3F77);
  triggerfx(var_03);
  param_00 waittill("trigger");
  var_03 delete();
}

lootdensity() {
  return getdvarfloat("scr_br_loot_density", 0.6);
}

lootdroptoground() {
  return getdvarint("scr_br_loot_drop_to_ground", 1);
}

lootgroundoffset() {
  return getdvarfloat("scr_br_loot_ground_offset", 10);
}

itemspawnflagsuspended() {
  return 1;
}

itemspawnflagakimbo() {
  return 4;
}

itemspawnflagsprintuse() {
  return 16;
}

scriptmoverspawnflagsprintuse() {
  return 16;
}

maxspawnedlootitems() {
  return 100;
}

lootpathnodesoutside() {
  return getdvarfloat("scr_br_loot_path_nodes_outside", 0.02);
}

lootpathnodesinsideparial() {
  return getdvarfloat("scr_br_loot_path_nodes_inside_partial", 0);
}

lootpathnodesinsidecomplete() {
  return getdvarfloat("scr_br_loot_path_nodes_inside_complete", 1);
}

lootpathnodesmindist() {
  return getdvarint("scr_br_loot_path_nodes_min_dist", 100);
}

lootgetgroundpos(param_00) {
  return bulletTrace(param_00 + (0, 0, 10), param_00 + (0, 0, -1000), 0, self, 0, 0, 0, 0, 1, 1, 0)["position"];
}

playergetcurrentweapon() {
  var_00 = self getcurrentweapon();
  if(var_00 == "none") {
    foreach(var_02 in self getweaponslistprimaries()) {
      if(self getammocount(var_02) != 0) {
        var_00 = var_02;
        break;
      }
    }
  }

  if(var_00 == "none") {
    var_00 = self getweaponslistprimaries()[0];
  }

  if(common_scripts\_plant_weapon::func_5855()) {
    if(isDefined(self.var_A99F)) {
      var_00 = self.var_A99F;
    }
  }

  if(!isDefined(var_00)) {
    var_00 = "none";
  }

  return var_00;
}

playermedkitinit() {
  self.usingmedkit = 0;
  self.nummedkits = 0;
}

canpickupmedkit(param_00, param_01) {
  if(isDefined(param_01.nummedkits) && param_01.nummedkits >= 3) {
    param_01 iprintlnbold(&"MPUI_MTX1_BR_MAX_MEDKITS");
    return 0;
  }

  return 1;
}

onpickupmedkit(param_00, param_01) {
  param_01.nummedkits++;
}

playermedkithud() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  waittillframeend;
  var_00 = 9999;
  for(;;) {
    if(self.nummedkits != var_00) {
      self setclientomnvar("ks_icon" + common_scripts\utility::func_9AAD(1), 7);
      self setclientomnvar("ks_selectedIndex", 1);
      self setclientomnvar("ks_count" + common_scripts\utility::func_9AAD(1), self.nummedkits);
      self setclientomnvar("ks_hasStreak", common_scripts\utility::func_98E7(self.nummedkits > 0, 2, 0));
      var_00 = self.nummedkits;
    }

    wait 0.05;
  }
}

playermedkitusemonitor() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  for(;;) {
    self waittill("tryUseMedkit");
    if(!self method_8648()) {
      continue;
    }

    if(self.health >= self.maxhealth) {
      self iprintlnbold(&"MPUI_MTX1_BR_FULL_HEALTH");
      continue;
    }

    if(common_scripts\utility::func_562E(self.usingmedkit)) {
      continue;
    }

    if(self.nummedkits > 0) {
      thread playermedkitinterruptwatcher();
      playermedkitusebegin();
      playermedkituseend();
      continue;
    }

    self iprintlnbold(&"MPUI_MTX1_BR_NO_MEDKITS");
  }
}

playermedkitusebegin() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("medkit_cancel");
  self.usingmedkit = 1;
  self allowads(0);
  self method_8308(0);
  self method_8307(0);
  self method_812B(0);
  self disableusability();
  var_00 = playergetcurrentweapon();
  self giveweapon("medkit_mp");
  self switchtoweapon("medkit_mp");
  wait(2);
  while(isDefined(self method_85C2())) {
    wait 0.05;
  }

  if(isDefined(var_00) && var_00 != "none") {
    self switchtoweapon(var_00);
  }

  self.nummedkits--;
  var_01 = self.health + 100;
  var_02 = min(1, var_01 / self.maxhealth);
  self setnormalhealth(var_02);
  thread playerhealoverlay();
}

playermedkitinterruptwatcher() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("medkit_end");
  for(;;) {
    self waittill("weapon_switch_started", var_00);
    if(var_00 == "medkit_mp") {
      continue;
    }

    self notify("medkit_cancel");
    break;
  }
}

playermedkituseend() {
  self notify("medkit_end");
  self takeweapon("medkit_mp");
  self allowads(1);
  self method_8308(1);
  self method_8307(1);
  self method_812B(1);
  self enableusability();
  self.usingmedkit = 0;
}

playerprekillbattleroyale(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A) {
  self.victimcurrentlethal = param_02 getplayersequipment();
  self.victimcurrenttactical = param_02 getplayersoffhands();
  self.victimcurrentweapon = param_02 getcurrentweapon();
  if(self.victimcurrentweapon == "medkit_mp") {
    param_02 takeweapon("medkit_mp");
  }
}

playerhealoverlay() {
  self endon("disconnect");
  var_00 = 1;
  var_01 = newclienthudelem(self);
  var_01.x = 0;
  var_01.y = 0;
  var_01.horzalign = "fullscreen";
  var_01.vertalign = "fullscreen";
  var_01 setshader("combathigh_overlay", 640, 480);
  var_01.alpha = 1;
  var_01 fadeovertime(var_00);
  var_01.alpha = 0;
  common_scripts\utility::func_A71A(var_00, "death");
  var_01 destroy();
}

playdeathstingersforteams(param_00) {
  if(!isPlayer(param_00)) {
    return;
  }

  var_01 = param_00.team;
  var_02 = maps\mp\_utility::getotherteam(var_01);
  level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_med", var_02);
  level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_med", var_01);
}

callincarepackage(param_00, param_01, param_02) {
  if(isDefined(param_00)) {
    if(!function_030D(param_00)) {
      param_00 = 0;
    }

    wait(param_00);
  }

  var_03 = undefined;
  var_04 = common_scripts\utility::array_randomize(level.players);
  var_03 = var_04[0];
  if(!isDefined(var_03)) {
    return;
  }

  if(!isDefined(param_01)) {
    param_01 = var_03.pers["team"];
  }

  if(!isDefined(param_02)) {
    param_02 = "v2_rocket";
  }

  var_05 = self.circleobjective.var_6EB7[self.circleobjective.var_6EB7.size - 1];
  if(!isDefined(var_05)) {
    return;
  }

  var_06 = lib_0527::func_4570();
  var_03 thread lib_0527::func_9302(var_03.var_5CC6, [var_05], [var_06], "carepackage", undefined, param_01, param_02);
  var_07 = level common_scripts\utility::func_A74D("airdropInbound", 20);
  if(isDefined(var_07) && var_07 == "timeout") {
    return;
  }

  thread maps\mp\_utility::teamplayercardsplash("raids_airdrop_incoming", var_03, param_01);
}