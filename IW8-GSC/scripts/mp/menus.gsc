/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\menus.gsc
***********************************************/

function init() {
  if(!isDefined(game["gamestarted"])) {
    game["menu_team"] = "team_marinesopfor";

    if(level.multiteambased) {
      game["menu_team"] = "team_mt_options";
    }

    game["menu_class"] = "class";
    game["menu_class_allies"] = "class_marines";
    game["menu_class_axis"] = "class_opfor";
    game["menu_changeclass_allies"] = "changeclass_marines";
    game["menu_changeclass_axis"] = "changeclass_opfor";

    if(level.multiteambased) {
      for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
        var_1 = "menu_class_" + level.teamnamelist[var_0];
        var_2 = "menu_changeclass_" + level.teamnamelist[var_0];
        game[var_1] = game["menu_class_allies"];
        game[var_2] = "changeclass_marines";
      }
    }

    game["menu_changeclass"] = "changeclass";
    game["menu_controls"] = "ingame_controls";

    if(level.splitscreen) {
      if(level.multiteambased) {
        for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
          var_1 = "menu_class_" + level.teamnamelist[var_0];
          var_2 = "menu_changeclass_" + level.teamnamelist[var_0];
          game[var_1] += "_splitscreen";
          game[var_2] += "_splitscreen";
        }
      }

      game["menu_team"] = game["menu_team"] + "_splitscreen";
      game["menu_class_allies"] = game["menu_class_allies"] + "_splitscreen";
      game["menu_class_axis"] = game["menu_class_axis"] + "_splitscreen";
      game["menu_changeclass_allies"] = game["menu_changeclass_allies"] + "_splitscreen";
      game["menu_changeclass_axis"] = game["menu_changeclass_axis"] + "_splitscreen";
      game["menu_controls"] = game["menu_controls"] + "_splitscreen";
      game["menu_changeclass_defaults_splitscreen"] = "changeclass_splitscreen_defaults";
      game["menu_changeclass_custom_splitscreen"] = "changeclass_splitscreen_custom";
    }

    precachestring(&"MP/HOST_ENDED_GAME");
    precachestring(&"MP/HOST_ENDGAME_RESPONSE");
  }

  level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&onleavegamecallback);
  level scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(&onteamchangecallback);
  level scripts\common\ui::lui_registercallback("class_edit", &onclasseditcallback);
  level scripts\common\ui::lui_registercallback("class_select", &onclasschoicecallback);
  thread setintrocamnetworkmodel();
}

function onteamchangecallback(var_0, var_1) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    if(var_0 != "team_select") {
      return;
    }

    if(scripts\mp\utility\game::matchmakinggame()) {
      return;
    }

    handleteamchange(var_0, var_1);
    return;
  }
}

function setintrocamnetworkmodel() {
  setintrocameraactive(1);
  level waittill("prematch_over");
  setintrocameraactive(0);
}

function update_enemies_remaining(var_0) {
  return var_0 >= 100;
}

function getclasschoice(var_0) {
  var_0++;
  var_1 = undefined;

  if(isDefined(level.set_systems_init_flag) && level.set_systems_init_flag > 0) {
    if(scripts\mp\utility\game::matchmakinggame()) {
      var_2 = scripts\mp\rank::getrank() >= 4;
    } else {
      var_2 = 1;
    }

    if(var_1 > 100) {
      var_3 = var_1 - 100;
      var_2 = "custgamemode_d" + var_3;
    } else if(!var_2) {
      var_2 = "custgamemode_d1";
    } else {
      var_2 = "custgamemode" + var_1;
    }
  } else if(var_1 > 100) {
    var_3 = var_1 - 100;
    var_2 = "default" + var_3;
  } else {
    var_2 = "custom" + var_1;
  }

  return var_2;
}

function updateloadoutselect(var_0) {
  var_1 = isai(self) || issubstr(self.name, "tcBot");

  if(!var_1) {
    return;
  }
}

function executeclasschange(var_0, var_1) {
  self endon("disconnect");

  if(isbot(self) || initmaxspeedforpathlengthtable(self)) {
    self.pers["class"] = var_0;
    self.class = var_0;
    return;
  }

  var_2 = getclasschoice(var_0);

  if(!isDefined(self.pers["class"]) || var_2 != self.pers["class"] || var_1) {
    self.pers["class"] = var_2;
    self.class = var_2;
    scripts\mp\class::preloadandqueueclass(var_2);
  }

  var_3 = 1;
  var_4 = scripts\mp\gamelogic::generate_randomized_primary_weapon_objs(scripts\mp\utility\game::round_vehicle_logic());

  if(scripts\mp\utility\game::getgametype() == "br" && !var_4) {
    var_3 = 0;
  }

  if(scripts\mp\class::shouldallowinstantclassswap() && var_3) {
    scripts\cp_mp\utility\inventory_utility::getridofweapon("iw8_fists_mp");
    thread scripts\mp\class::swaploadout();
    return;
  }

  var_5 = scripts\mp\utility\game::unset_relic_grounded() && self calloutmarkerping_entityzoffset("ui_open_loadout_bag");

  if(isalive(self) && !var_5) {
    self iprintlnbold(game["strings"]["change_class"]);
  }

  if(var_0 < 100) {
    self setclientomnvar("ui_loadout_changed", scripts\mp\class::getclassindex(self.pers["class"]));
    return;
  }
}

function setnextroundclass(var_0) {
  var_1 = var_0;

  if(!isbot(self)) {
    if(isalive(self)) {
      self iprintlnbold(game["strings"]["revive_class"]);
    }

    var_1 = getclasschoice(var_0);
  }

  self.pers["next_round_class"] = var_1;
}

function onleavegamecallback(var_0, var_1) {
  if(var_0 != "end_game") {
    return;
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    return;
  }

  if(isdedicatedserver()) {
    return;
  }

  level thread scripts\mp\gamelogic::forceend(var_1);
}

function onclasseditcallback(var_0) {
  self endon("disconnect");
  waittillframeend();
  handleclassedit(var_0);

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_public::playerloadoutsaveselected(getclasschoice(var_0));
    return;
  }
}

function onclasschoicecallback(var_0, var_1) {
  if(scripts\mp\utility\game::usefloorrocks()) {
    if(var_0 < 100) {
      var_0 += 100;
    }
  }

  if(scripts\mp\utility\game::getgametype() == "br" && var_0 == -1 && getdvarint("scr_br_newClass_killswitch", 0) == 0) {
    return;
  }

  self notify("loadout_class_selected", var_0);

  if(level.systemlink && getdvarint("xblive_competitionmatch") && self ismlgspectator()) {
    self setclientomnvar("ui_options_menu", 0);
    return;
  }

  updateloadoutselect(var_0);

  if(istrue(self.waitingtoselectclass)) {
    if(isDefined(self.revive_chosenclass)) {
      setnextroundclass(var_0);
    }

    self setclientomnvar("ui_options_menu", 0);
    return;
  }

  if(!scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout()) {
    return;
  }

  if(isDefined(self.revive_chosenclass) && isDefined(self.instantclassswapallowed) && !scripts\mp\class::shouldallowinstantclassswap()) {
    setnextroundclass(var_0);
    return;
  }

  if("" + var_0 != "callback") {
    executeclasschange(var_0, istrue(var_1));
    return;
  }

  menuclass("callback");
}

function handleteamchange(var_0, var_1) {
  var_2 = 0;

  if(var_1 >= 3) {
    var_2 = 1;
  }

  if(var_2) {
    self setclientomnvar("ui_spectator_selected", 1);
    self.spectating_actively = 1;
  } else {
    self setclientomnvar("ui_spectator_selected", -1);
    self.spectating_actively = 0;
  }

  var_3 = self ismlgspectator();
  var_4 = !var_3 && isDefined(self.team) && (self.team == "spectator" || self.team == "follower");
  var_5 = var_3 && var_1 == 3 || var_4 && (var_1 == 4 || var_1 == 5);

  if(var_1 == 4 || var_1 == 5) {
    var_1 = 3;
    self setmlgspectator(1);
  } else {
    self setmlgspectator(0);
  }

  if(var_1 == 0) {
    var_1 = "axis";
  } else if(var_1 == 1) {
    var_1 = "allies";
  } else if(var_1 == 2) {
    var_1 = "random";
  } else {
    var_1 = "spectator";
  }

  if(!var_5 && isDefined(self.pers["team"]) && var_1 == self.pers["team"]) {
    return;
  }

  if(isDefined(self.operatorcustomization)) {
    self.operatorcustomization.rebuild = 1;
  }

  thread logteamselection(var_1);

  if(var_1 != "spectator") {
    self.pers["playerChoseSpectatorTeam"] = undefined;
  } else {
    self.pers["playerChoseSpectatorTeam"] = 1;
  }

  if(var_1 == "axis") {
    thread setteam("axis");
    return;
  }

  if(var_1 == "allies") {
    thread setteam("allies");
    return;
  }

  if(var_1 == "random") {
    thread autoassign();
    return;
  }

  if(var_1 == "spectator") {
    thread setspectator(var_5);
    return;
  }
}

function handleclassedit(var_0) {
  var_1 = getclasschoice(var_0);
  var_2 = scripts\mp\class::loadout_editcachedclassstruct(var_1);
  var_3 = scripts\mp\class::zombieregenratescaleoutgas();
  var_4 = var_2 || var_3;

  if(isDefined(self.pers["class"]) && var_1 == self.pers["class"] && var_4) {
    onclasschoicecallback(var_0, 1);
    return;
  }
}

function autoassign() {
  if(scripts\mp\utility\game::getgametype() == "infect") {
    thread setteam("allies");
    return;
  }

  if(getdvarint("scr_useProfileSpawn", 0) != 0) {
    thread setteam("allies");
    return;
  }

  if(brking_updateteamscore()) {
    thread setteam("allies");
    return;
  }

  if(isbot(self) && isDefined(self.bot_team) && self.bot_team != "autoassign") {
    thread setteam(self.bot_team);
    return;
  }

  if(self ismlgspectator()) {
    thread setspectator();
    return;
  }

  jumpiffalse(istrue(level.teammaxfill)) LOC_000000f5;

  foreach(var_1 in level.teamnamelist) {
    if(scripts\mp\teams::ref_132E6() && var_1 == "team_two_hundred") {
      continue;
    }

    var_2 = scripts\mp\utility\teams::getteamdata(var_1, "teamCount");

    if(level.maxteamsize == 0 || var_2 < level.maxteamsize) {
      thread setteam(var_1);
      break;
    }
  }

  return;
}

function setteam(var_0) {
  self endon("disconnect");

  if(!isai(self) && level.teambased && !scripts\mp\teams::getjointeampermissions(var_0) && !scripts\mp\utility\game::lobbyteamselectenabled()) {
    return;
  }

  if(level.ingraceperiod && !self.hasdonecombat) {
    self.hasspawned = 0;
    self.pers["lives"] = scripts\mp\utility\game::getgametypenumlives();
  }

  if(self.sessionstate == "playing") {
    self.switching_teams = 1;
    self.joining_team = var_0;
    self.leaving_team = self.pers["team"];

    if(scripts\mp\utility\game::getgametype() == "arena") {
      self.switching_teams_arena = 1;
    }
  }

  if(istrue(game["isLaunchChunk"]) && isbot(self) == 0) {
    var_0 = "allies";
  }

  addtoteam(var_0);

  if(shouldmodesetsquads()) {
    thread setsquad(var_0);
  }

  if(scripts\mp\utility\player::isragdollzerog()) {
    self lockdeathcamera(1);
  }

  if(self.sessionstate == "playing") {
    self suicide();
    scripts\mp\utility\player::updatesessionstate("spectator");
    self.suicideswitched = 1;
  }

  if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
    if(getdvarint("scr_force_cac_sre_callstack", 0) == 1 && scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "sandbox" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war") {
      var_1 = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
      scripts\mp\utility\script::laststand_dogtags("setTeam() " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + var_1);
    }

    self setclientomnvar("ui_options_menu", 2);
  }

  if(isDefined(level.ref_12065)) {
    self thread[[level.ref_12065]]();
  }

  waitforclassselect();
  endrespawnnotify();

  if((self.sessionstate == "spectator" || ref_125F1()) && !istrue(self.suicideswitched)) {
    if(game["state"] == "postgame") {
      return;
    }

    if(game["state"] == "playing" && !scripts\mp\utility\player::isinkillcam()) {
      if(isDefined(self.waitingtospawnamortize) && self.waitingtospawnamortize) {
        return;
      }

      thread scripts\mp\playerlogic::spawnclient();
    }

    thread scripts\mp\spectating::setspectatepermissions();
  }

  self.suicideswitched = undefined;
  self notify("okToSpawn");
}

function ref_125F1() {
  return isDefined(level.ref_125F1) && self[[level.ref_125F1]]();
}

function shouldmodesetsquads() {
  switch (scripts\mp\utility\game::getgametype()) {
    case "defcon":
    case "pill":
    case "brtdm":
    case "arena":
    case "arm":
      return 1;
    case "br":
      return ref_13733();
    default:
      return 0;
  }
}

function setsquad(var_0) {
  if(!level.teambased) {
    return;
  }

  if(!isDefined(level.squaddata)) {
    initsquaddata(level);
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    var_1 = self getsquadindex();
    joinsquad(var_0, var_1);
    return;
  }

  var_2 = issubstr(self.name, "tcBot") || issubstr(self.name, "_hl_");

  if(!isai(self) && !var_2) {
    var_3 = self getlobbysquadindex();

    if(var_3 != -1) {
      self.squadassignedfromlobby = 1;
      joinsquad(var_1, var_3);
      return;
    }
  }

  if(istrue(scripts\mp\utility\game::matchmakinggame())) {
    var_4 = self getfireteammembers();

    if(isDefined(var_4) && var_4.size > 0) {
      var_1 = undefined;

      foreach(var_6 in var_4) {
        if(isDefined(var_6) && isDefined(var_6.squadindex)) {
          var_1 = var_6.squadindex;
          break;
        }
      }

      if(isDefined(var_1)) {
        joinsquad(var_1, var_1);
        return;
      } else {
        requestnewsquad(var_1, 1);
        return;
      }
    }
  }

  if(var_1 != "spectator") {
    foreach(var_9 in level.squaddata[var_1]) {
      var_9.isfull = var_9.players.size == level.maxsquadsize;

      if(var_9.inuse && !var_9.isfireteam && !var_9.isfull) {
        joinsquad(var_1, var_9.index);
        return;
      }
    }

    requestnewsquad(var_1, 0);
    return;
  }
}

function initsquaddata() {
  if(!isDefined(level.maxsquadsize)) {
    level.maxsquadsize = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_squadsize", 4);
  }

  level.maxsquadwait = getdvarint("scr_squad_max_wait", 15);
  level.squaddata = [];

  foreach(var_1 in level.teamnamelist) {
    level.squaddata[var_1] = [];
  }

  thread monitorsquads();

  if(getdvarint("scr_debug_squads", 0) == 1) {
    thread debugprintsquads();
    return;
  }
}

function createsquad(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level.squaddata[var_0].size;
  }

  var_2 = spawnStruct();
  var_2.index = var_1;
  var_2.formedtime = undefined;
  var_2.isfireteam = 0;
  var_2.isstale = 0;
  var_2.isfull = 0;
  var_2.inuse = 0;
  var_2.players = [];
  var_2.spawnpoint = undefined;
  level.squaddata[var_0][var_1] = var_2;
  return var_1;
}

function checksquads() {
  foreach(var_1 in level.teamnamelist) {
    if(!isDefined(level.squaddata[var_1])) {
      continue;
    }

    foreach(var_3 in level.squaddata[var_1]) {
      if(!var_3.inuse) {
        continue;
      }

      if(!var_3.isstale && gettime() > var_3.formedtime + level.maxsquadwait * 1000) {
        var_3.isstale = 1;
      }

      var_3.isfull = var_3.players.size == level.maxsquadsize;
      var_4 = 0;

      foreach(var_6 in var_3.players) {
        if(isDefined(var_6)) {
          var_4 = 1;
        }
      }

      if(!var_4) {
        freesquadindex(var_1, var_3.index);
      }
    }
  }
}

function monitorsquads() {
  for(;;) {
    checksquads();
    waitframe();
  }
}

function requestnewsquad(var_0, var_1) {
  var_2 = getavailablesquadindex(var_0);
  var_3 = level.squaddata[var_0][var_2];
  var_3.index = var_2;
  var_3.formedtime = gettime();
  var_3.isfireteam = var_1;
  var_3.isstale = 0;
  var_3.isfull = 0;
  var_3.inuse = 1;
  var_3.players = [];
  var_3.squadstartlocationkey = undefined;
  var_3.infil = undefined;
  joinsquad(var_0, var_2);
}

function joinsquad(var_0, var_1) {
  if(!isDefined(level.squaddata[var_0][var_1])) {
    createsquad(var_0, var_1);
  }

  var_2 = isDefined(self.pers["squadIndex"]) && self.pers["squadIndex"] == var_1;

  if(isDefined(self.squadindex)) {
    var_3 = 0;

    foreach(var_5 in level.squaddata) {
      foreach(var_7 in var_5) {
        if(scripts\engine\utility::array_contains(var_7.players, self)) {
          level.squaddata[var_9][var_8].players = scripts\engine\utility::array_remove(var_7.players, self);
          var_3 = 1;
          break;
        }
      }

      if(var_3) {
        break;
      }
    }
  }

  self.squadindex = var_1;
  self.pers["squadIndex"] = var_1;

  if(!var_2 || !isDefined(self.pers["squadMemberIndex"])) {
    self.pers["squadMemberIndex"] = level.squaddata[var_0][var_1].players.size;

    if(scripts\mp\utility\game::getgametype() == "br") {
      self.pers["squadMemberIndex"]++;
    }
  }

  if(!istrue(scripts\mp\utility\game::matchmakinggame())) {
    self setsquadindex(var_1);
  }

  level.squaddata[var_0][var_1].players[level.squaddata[var_0][var_1].players.size] = self;
  scripts\mp\utility\join_squad_aggregator::onplayerjoinsquad(self);
  self notify("joined_squad");

  if(istrue(level.usesquadleader)) {
    choosesquadleader(var_0, var_1);
  }

  if(scripts\mp\utility\game::getgametype() != "br") {
    updatesquadomnvars(var_0, var_1);
    return;
  }
}

function leavesquad(var_0, var_1) {
  if(scripts\mp\utility\game::getgametype() == "br") {
    level.squaddata[var_0][var_1].players = scripts\engine\utility::array_remove(level.squaddata[var_0][var_1].players, self);
    return;
  }

  if(isDefined(var_0) && isDefined(var_1)) {
    thread scripts\mp\spawnselection::ref_12ACB(var_0, var_1);
  }

  var_2 = 0;
  var_3 = getsquadleader(var_0, var_1);

  if(istrue(level.usesquadleader) && isDefined(var_3) && var_3 == self) {
    level.squaddata[var_0][var_1].squadleaderindex = undefined;
    var_2 = 1;
  }

  level.squaddata[var_0][var_1].players = scripts\engine\utility::array_remove(level.squaddata[var_0][var_1].players, self);

  for(var_4 = 0; var_4 < level.squaddata[var_0][var_1].players.size; var_4++) {
    level.squaddata[var_0][var_1].players[var_4].pers["squadMemberIndex"] = var_4;
  }

  if(istrue(var_2)) {
    var_5 = scripts\engine\utility::array_randomize(level.squaddata[var_0][var_1].players);

    foreach(var_7 in var_5) {
      if(isDefined(var_7)) {
        choosesquadleader(var_7, var_0, var_1);
        break;
      }
    }
  }

  updatesquadomnvars(var_0, var_1);
}

function updatesquadomnvars(var_0, var_1) {
  var_2 = getsquadleader(var_0, var_1);

  foreach(var_4 in level.squaddata[var_0][var_1].players) {
    var_5 = var_1;
    var_5 += level.squaddata[var_0][var_1].players.size << 5;

    if(isDefined(var_2) && var_2 == var_4) {
      var_5 += 256;
    }

    var_4 setclientomnvar("ui_squad_data", var_5);

    if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "arena" || scripts\mp\utility\game::getgametype() == "brtdm") {
      var_6 = var_4.game_extrainfo & 65528;
      var_4.game_extrainfo = var_6 | var_4.pers["squadMemberIndex"] + 1;

      if(isDefined(var_2) && var_2 == var_4) {
        var_4.game_extrainfo |= 64;
      } else {
        var_4.game_extrainfo &= ~64;
      }

      var_7 = var_4 getentitynumber();

      if(isDefined(var_2) && var_2 == var_4) {
        var_7 += 2048;
      }

      if(isalive(var_4)) {
        var_7 += 4096;
      }

      var_4 setclientomnvar("ui_arm_squadmember_0", var_7);
      var_8 = scripts\engine\utility::array_remove(level.squaddata[var_0][var_1].players, var_4);

      for(var_9 = 0; var_9 < 3; var_9++) {
        var_10 = var_8[var_9];

        if(isDefined(var_10)) {
          var_7 = var_10 getentitynumber();

          if(isDefined(var_2) && var_2 == var_10) {
            var_7 += 2048;
          }

          if(isalive(var_10)) {
            var_7 += 4096;
          }
        } else {
          var_7 = -1;
        }

        var_4 setclientomnvar("ui_arm_squadmember_" + var_9 + 1, var_7);
      }
    }
  }
}

function getavailablesquadindex(var_0) {
  foreach(var_2 in level.squaddata[var_0]) {
    if(!var_2.inuse) {
      return var_2.index;
    }
  }

  return createsquad(var_0);
}

function freesquadindex(var_0, var_1) {
  level.squaddata[var_0][var_1].formedtime = undefined;
  level.squaddata[var_0][var_1].isfireteam = 0;
  level.squaddata[var_0][var_1].isstale = 0;
  level.squaddata[var_0][var_1].isfull = 0;
  level.squaddata[var_0][var_1].inuse = 0;
  level.squaddata[var_0][var_1].players = [];
  level.squaddata[var_0][var_1].squadstartlocationkey = undefined;
  level.squaddata[var_0][var_1].infil = undefined;
}

function choosesquadleader(var_0, var_1) {
  if(isDefined(getsquadleader(var_0, var_1))) {
    return;
  }

  if(istrue(scripts\mp\utility\game::matchmakinggame())) {
    var_2 = self getfireteammembers();

    if(isDefined(var_2) && var_2.size > 0) {
      if(self isfireteamleader()) {
        foreach(var_5, var_4 in level.squaddata[self.team][self.squadindex].players) {
          if(var_4 == self) {
            level.squaddata[var_0][var_1].squadleaderindex = var_5;
          }
        }
      } else {
        return;
      }
    }
  }

  foreach(var_4 in level.squaddata[self.team][self.squadindex].players) {
    if(var_4 == self) {
      level.squaddata[var_0][var_1].squadleaderindex = var_5;
    }
  }
}

function getsquadleader(var_0, var_1) {
  var_2 = level.squaddata[var_0][var_1].squadleaderindex;

  if(!isDefined(var_2)) {
    return undefined;
  }

  return level.squaddata[var_0][var_1].players[var_2];
}

function ref_13733() {
  return getdvarint("LNKKRLTPNS", 0) != 0;
}

function brking_updateteamscore() {
  return getdvarint("NPSRPPOSP", 0) != 0;
}

function setspectator(var_0) {
  if((!isDefined(var_0) || !var_0) && isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }

  if(isalive(self)) {
    self.switching_teams = 1;
    self.joining_team = "spectator";
    self.leaving_team = self.pers["team"];

    if(self.sessionstate == "playing") {
      self suicide();
    }
  }

  self notify("becameSpectator");
  addtoteam("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;
  thread scripts\mp\playerlogic::spawnspectator();
}

function setfollower(var_0) {
  if((!isDefined(var_0) || !var_0) && isDefined(self.pers["team"]) && self.pers["team"] == "follower") {
    return;
  }

  if(isalive(self)) {
    self.switching_teams = 1;
    self.joining_team = "follower";
    self.leaving_team = self.pers["team"];
    self suicide();
  }

  self notify("becameSpectator");
  addtoteam("follower");
  self.pers["class"] = undefined;
  self.class = undefined;
  thread scripts\mp\playerlogic::spawnspectator();
}

function waitforclassselect() {
  self endon("disconnect");
  level endon("game_ended");
  self.waitingtoselectclass = 1;
  jumpiffalse(scripts\mp\flags::gameflag("prematch_done") && istrue(level.usespawnselection) && !istrue(self.hasspawned)) LOC_0000005d;
  self setclientomnvar("ui_world_fade", 1);
  self setclientomnvar("ui_hide_objectives", 1);
  self setclientomnvar("ui_in_spawn_camera", 1);

  for(;;) {
    var_0 = scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::allowclasschoice() && (!scripts\mp\flags::gameflag("prematch_done") || istrue(level.ref_133E0) || istrue(level.dmztut_endgametransition));
    var_1 = scripts\mp\utility\game::teamhasinfil(self.team) && !scripts\mp\flags::gameflag("infil_started") && !isDefined(level.bypassclasschoicefunc);

    if(var_0 || var_1) {
      var_2 = "class_select";

      if(!isai(self)) {
        var_3 = scripts\mp\rank::getrank() >= 4;

        if(var_3 && !scripts\mp\utility\game::tv_station_intro_camera()) {
          var_4 = self getplayerdata(level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex");
        } else {
          var_4 = 100;
        }
      } else {
        var_4 = "callback";
      }
    } else if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
      if(!self ismlgspectator() && getdvarint("debug_GLSpectate", 0) == 0 && self.team != "spectator" && scripts\mp\utility\game::getgametype() != "arm") {
        scripts\mp\utility\lower_message::setlowermessageomnvar(15);
      }

      self waittill("loadout_class_selected", var_4);
    } else {
      bypassclasschoice();
      break;
    }

    if(self.team == "spectator") {
      continue;
    }

    if("" + var_4 != "callback") {
      if(isbot(self)) {
        self.pers["class"] = var_4;
        self.class = var_4;
      } else {
        var_4 = var_4;
        self.pers["class"] = getclasschoice(var_4);
        self.class = getclasschoice(var_4);
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar(0);
      self.waitingtoselectclass = 0;
    } else {
      self.waitingtoselectclass = 0;
      menuclass("callback");
    }

    break;
  }
}

function beginclasschoice(var_0) {
  var_1 = self.pers["team"];

  if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
    if(getdvarint("scr_force_cac_sre_callstack", 0) == 1 && scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "sandbox" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war") {
      var_2 = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
      scripts\mp\utility\script::laststand_dogtags("beginClassChoice() " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + var_2);
    }

    self setclientomnvar("ui_options_menu", 2);

    if(!self ismlgspectator()) {
      waitforclassselect();
    }

    endrespawnnotify();

    if(self.sessionstate == "spectator") {
      if(game["state"] == "postgame") {
        return;
      }

      if(game["state"] == "playing" && !scripts\mp\utility\player::isinkillcam()) {
        if(isDefined(self.waitingtospawnamortize) && self.waitingtospawnamortize) {
          return;
        }

        thread scripts\mp\playerlogic::spawnclient();
      }

      thread scripts\mp\spectating::setspectatepermissions();
    }

    self.connecttime = gettime();
    self notify("okToSpawn");
    return;
  }

  thread bypassclasschoice();
}

function bypassclasschoice() {
  self.selectedclass = 1;
  self.waitingtoselectclass = 0;

  if(updatetimedrunhud() && level.enforceantiboosting && !isbot(self)) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(1);
    self notifyonplayercommand("pressToSpawn", "+usereload");
    self notifyonplayercommand("pressToSpawn", "+activate");
    thread waitthensetspawnomnvar();
    self waittill("pressToSpawn");
  }

  if(isDefined(level.bypassclasschoicefunc)) {
    var_0 = self[[level.bypassclasschoicefunc]]();
    self.class = var_0;
    return;
  }

  self.class = "class0";
}

function updatetimedrunhud() {
  if(scripts\mp\utility\game::getgametype() == "infect") {
    return true;
  } else if(scripts\mp\utility\game::getgametype() == "dm" && istrue(level.aonrules)) {
    return true;
  } else if(scripts\mp\utility\game::getgametype() == "gun") {
    return true;
  } else if(scripts\mp\utility\game::getgametype() == "arena") {
    return true;
  }

  return false;
}

function waitthensetspawnomnvar() {
  self endon("pressToSpawn");
  wait 1;

  if(isDefined(self)) {
    scripts\mp\utility\lower_message::setlowermessageomnvar(1);
    return;
  }
}

function beginteamchoice() {
  self setclientomnvar("ui_options_menu", 1);
}

function menuspectator() {
  if(isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }

  if(isalive(self)) {
    self.switching_teams = 1;
    self.joining_team = "spectator";
    self.leaving_team = self.pers["team"];
    self suicide();
  }

  addtoteam("spectator");
  self.pers["class"] = undefined;
  self.class = undefined;
  thread scripts\mp\playerlogic::spawnspectator();
}

function menuclass(var_0) {
  var_1 = self.pers["team"];
  var_2 = scripts\mp\class::getclasschoice(var_0);
  var_3 = scripts\mp\class::getweaponchoice(var_0);

  if(var_2 == "restricted") {
    beginclasschoice();
    return;
  }

  if(isDefined(self.pers["class"]) && self.pers["class"] == var_2 && isDefined(self.pers["primary"]) && self.pers["primary"] == var_3) {
    return;
  }

  if(self.sessionstate == "playing") {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self.lastclass = self.pers["lastClass"];
    }

    self.pers["class"] = var_2;
    self.class = var_2;
    self.pers["primary"] = var_3;

    if(game["state"] == "postgame") {
      return;
    }

    if(level.ingraceperiod && !self.hasdonecombat) {
      scripts\mp\class::setclass(self.pers["class"]);
      self.tag_stowed_back = undefined;
      self.tag_stowed_hip = undefined;
      scripts\mp\class::giveloadout(self.pers["team"], self.pers["class"]);
    } else {
      self iprintlnbold(game["strings"]["change_class"]);
    }
  } else {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self.lastclass = self.pers["lastClass"];
    }

    self.pers["class"] = var_2;
    self.class = var_2;
    self.pers["primary"] = var_3;

    if(game["state"] == "postgame") {
      return;
    }

    if(game["state"] == "playing" && !scripts\mp\utility\player::isinkillcam()) {
      thread scripts\mp\playerlogic::spawnclient();
    }
  }

  thread scripts\mp\spectating::setspectatepermissions();
}

function addtoteam(var_0, var_1, var_2) {
  if(isDefined(self.team)) {
    scripts\mp\playerlogic::removefromteamcount();

    if(isDefined(var_2) && var_2) {
      scripts\mp\playerlogic::decrementalivecount(self.team, 0, "addToTeam");
    }

    if(shouldmodesetsquads() && isDefined(self.squadindex) && self.team != "spectator") {
      leavesquad(self.team, self.squadindex);
    }
  }

  if(isDefined(self.pers["team"]) && self.pers["team"] != "" && self.pers["team"] != "spectator") {
    self.pers["last_team"] = self.pers["team"];
  }

  self.changedteams = isDefined(self.pers["last_team"]) && self.pers["last_team"] != var_0;
  self.pers["team"] = var_0;
  self.team = var_0;
  var_3 = isbot(self) || initmaxspeedforpathlengthtable(self);

  if(var_3) {
    setsessionteam(var_0);
  } else if(!scripts\mp\utility\game::denysystemicteamchoice()) {
    if(scripts\mp\utility\game::matchmakinggame()) {
      if(!scripts\mp\utility\game::allowteamassignment()) {
        if(scripts\mp\utility\game::getgametype() == "infect") {
          setsessionteam(var_0);
        } else {
          setemptysessionteam(var_0);
        }
      }
    } else if(!function_0426()) {
      setsessionteam(var_0);
    }
  }

  if(game["state"] != "postgame") {
    scripts\mp\playerlogic::addtoteamcount(istrue(var_2));
  }

  scripts\mp\utility\game::updateobjectivetext();

  if(isDefined(var_1) && var_1) {
    waittillframeend();
  }

  if(var_0 == "spectator" || var_0 == "follower") {
    self notify("joined_spectators");
    scripts\mp\teams::onjoinedspectators(self);
    scripts\mp\spectating::onjoinedspectators(self);
    scripts\mp\bounty::onplayerjoinedspectators(self);
    scripts\cp_mp\pet_watch::ref_12044();
  } else {
    self notify("joined_team");
  }

  scripts\mp\utility\join_team_aggregator::onplayerjointeam(self);
  scripts\mp\infilexfil\infilexfil::onjoinedteam(self);
  level notify("add_to_team", self);
}

function setsessionteam(var_0) {
  if(level.teambased) {
    self.sessionteam = var_0;
    return;
  }

  setemptysessionteam(var_0);
}

function setemptysessionteam(var_0) {
  if(var_0 == "spectator") {
    self.sessionteam = "spectator";
    return;
  }

  if(var_0 == "follower") {
    self.sessionteam = "follower";
    return;
  }

  self.sessionteam = "none";
}

function endrespawnnotify() {
  self.waitingtospawn = 0;
  self notify("end_respawn");
}

function logteamselection(var_0) {
  if(getdvarint("scr_playtest", 0) == 0) {
    return;
  }

  if(var_0 != "random") {
    iprintlnbold("" + self.name + " did not select auto-assign");
    return;
  }
}

function debugprintsquads() {
  var_0 = 25;

  for(;;) {
    if(isDefined(level.squaddata)) {
      var_1 = 800;
      var_2 = 25;
      var_3 = 1;

      foreach(var_5 in level.squaddata) {
        var_3 = 1;
        var_3++;

        foreach(var_7 in var_5) {
          var_8 = (1, 1, 1);

          if(isDefined(var_7.activemission)) {
            var_8 = (1, 1, 0);
          }

          var_3++;

          foreach(var_10 in var_7.players) {
            var_8 = (1, 1, 1);

            if(istrue(var_10.squadassignedfromlobby)) {
              var_8 = (0, 1, 0);
            }

            var_3++;
          }
        }

        var_1 += 200;
      }
    }

    waitframe();
  }
}