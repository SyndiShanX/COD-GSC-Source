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
      for(var0 = 0; var0 < level.teamnamelist.size; var0++) {
        var1 = "menu_class_" + level.teamnamelist[var0];
        var2 = "menu_changeclass_" + level.teamnamelist[var0];
        game[var1] = game["menu_class_allies"];
        game[var2] = "changeclass_marines";
      }
    }

    game["menu_changeclass"] = "changeclass";
    game["menu_controls"] = "ingame_controls";

    if(level.splitscreen) {
      if(level.multiteambased) {
        for(var0 = 0; var0 < level.teamnamelist.size; var0++) {
          var1 = "menu_class_" + level.teamnamelist[var0];
          var2 = "menu_changeclass_" + level.teamnamelist[var0];
          game[var1] += "_splitscreen";
          game[var2] += "_splitscreen";
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

function onteamchangecallback(var0, var1) {
  if(scripts\mp\utility\game::getgametype() != "br") {
    if(var0 != "team_select") {
      return;
    }

    if(scripts\mp\utility\game::matchmakinggame()) {
      return;
    }

    handleteamchange(var0, var1);
    return;
  }
}

function setintrocamnetworkmodel() {
  setintrocameraactive(1);
  level waittill("prematch_over");
  setintrocameraactive(0);
}

function update_enemies_remaining(var0) {
  return var0 >= 100;
}

function getclasschoice(var0) {
  var0++;
  var1 = undefined;

  if(isDefined(level.set_systems_init_flag) && level.set_systems_init_flag > 0) {
    if(scripts\mp\utility\game::matchmakinggame()) {
      var2 = scripts\mp\rank::getrank() >= 4;
    } else {
      var2 = 1;
    }

    if(var1 > 100) {
      var3 = var1 - 100;
      var2 = "custgamemode_d" + var3;
    } else if(!var2) {
      var2 = "custgamemode_d1";
    } else {
      var2 = "custgamemode" + var1;
    }
  } else if(var1 > 100) {
    var3 = var1 - 100;
    var2 = "default" + var3;
  } else {
    var2 = "custom" + var1;
  }

  return var2;
}

function updateloadoutselect(var0) {
  var1 = isai(self) || issubstr(self.name, "tcBot");

  if(!var1) {
    return;
  }
}

function executeclasschange(var0, var1) {
  self endon("disconnect");

  if(isbot(self) || initmaxspeedforpathlengthtable(self)) {
    self.pers["class"] = var0;
    self.class = var0;
    return;
  }

  var2 = getclasschoice(var0);

  if(!isDefined(self.pers["class"]) || var2 != self.pers["class"] || var1) {
    self.pers["class"] = var2;
    self.class = var2;
    scripts\mp\class::preloadandqueueclass(var2);
  }

  var3 = 1;
  var4 = scripts\mp\gamelogic::generate_randomized_primary_weapon_objs(scripts\mp\utility\game::round_vehicle_logic());

  if(scripts\mp\utility\game::getgametype() == "br" && !var4) {
    var3 = 0;
  }

  if(scripts\mp\class::shouldallowinstantclassswap() && var3) {
    scripts\cp_mp\utility\inventory_utility::getridofweapon("iw8_fists_mp");
    thread scripts\mp\class::swaploadout();
    return;
  }

  var5 = scripts\mp\utility\game::unset_relic_grounded() && self calloutmarkerping_entityzoffset("ui_open_loadout_bag");

  if(isalive(self) && !var5) {
    self iprintlnbold(game["strings"]["change_class"]);
  }

  if(var0 < 100) {
    self setclientomnvar("ui_loadout_changed", scripts\mp\class::getclassindex(self.pers["class"]));
    return;
  }
}

function setnextroundclass(var0) {
  var1 = var0;

  if(!isbot(self)) {
    if(isalive(self)) {
      self iprintlnbold(game["strings"]["revive_class"]);
    }

    var1 = getclasschoice(var0);
  }

  self.pers["next_round_class"] = var1;
}

function onleavegamecallback(var0, var1) {
  if(var0 != "end_game") {
    return;
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    return;
  }

  if(isdedicatedserver()) {
    return;
  }

  level thread scripts\mp\gamelogic::forceend(var1);
}

function onclasseditcallback(var0) {
  self endon("disconnect");
  waittillframeend();
  handleclassedit(var0);

  if(scripts\mp\utility\game::getgametype() == "br") {
    scripts\mp\gametypes\br_public::playerloadoutsaveselected(getclasschoice(var0));
    return;
  }
}

function onclasschoicecallback(var0, var1) {
  if(scripts\mp\utility\game::usefloorrocks()) {
    if(var0 < 100) {
      var0 += 100;
    }
  }

  if(scripts\mp\utility\game::getgametype() == "br" && var0 == -1 && getdvarint("scr_br_newClass_killswitch", 0) == 0) {
    return;
  }

  self notify("loadout_class_selected", var0);

  if(level.systemlink && getdvarint("LOMTKQTRTM") && self ismlgspectator()) {
    self setclientomnvar("ui_options_menu", 0);
    return;
  }

  updateloadoutselect(var0);

  if(istrue(self.waitingtoselectclass)) {
    if(isDefined(self.revive_chosenclass)) {
      setnextroundclass(var0);
    }

    self setclientomnvar("ui_options_menu", 0);
    return;
  }

  if(!scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout()) {
    return;
  }

  if(isDefined(self.revive_chosenclass) && isDefined(self.instantclassswapallowed) && !scripts\mp\class::shouldallowinstantclassswap()) {
    setnextroundclass(var0);
    return;
  }

  if("" + var0 != "callback") {
    executeclasschange(var0, istrue(var1));
    return;
  }

  menuclass("callback");
}

function handleteamchange(var0, var1) {
  var2 = 0;

  if(var1 >= 3) {
    var2 = 1;
  }

  if(var2) {
    self setclientomnvar("ui_spectator_selected", 1);
    self.spectating_actively = 1;
  } else {
    self setclientomnvar("ui_spectator_selected", -1);
    self.spectating_actively = 0;
  }

  var3 = self ismlgspectator();
  var4 = !var3 && isDefined(self.team) && (self.team == "spectator" || self.team == "follower");
  var5 = var3 && var1 == 3 || var4 && (var1 == 4 || var1 == 5);

  if(var1 == 4 || var1 == 5) {
    var1 = 3;
    self setmlgspectator(1);
  } else {
    self setmlgspectator(0);
  }

  if(var1 == 0) {
    var1 = "axis";
  } else if(var1 == 1) {
    var1 = "allies";
  } else if(var1 == 2) {
    var1 = "random";
  } else {
    var1 = "spectator";
  }

  if(!var5 && isDefined(self.pers["team"]) && var1 == self.pers["team"]) {
    return;
  }

  if(isDefined(self.operatorcustomization)) {
    self.operatorcustomization.rebuild = 1;
  }

  thread logteamselection(var1);

  if(var1 != "spectator") {
    self.pers["playerChoseSpectatorTeam"] = undefined;
  } else {
    self.pers["playerChoseSpectatorTeam"] = 1;
  }

  if(var1 == "axis") {
    thread setteam("axis");
    return;
  }

  if(var1 == "allies") {
    thread setteam("allies");
    return;
  }

  if(var1 == "random") {
    thread autoassign();
    return;
  }

  if(var1 == "spectator") {
    thread setspectator(var5);
    return;
  }
}

function handleclassedit(var0) {
  var1 = getclasschoice(var0);
  var2 = scripts\mp\class::loadout_editcachedclassstruct(var1);
  var3 = scripts\mp\class::zombieregenratescaleoutgas();
  var4 = var2 || var3;

  if(isDefined(self.pers["class"]) && var1 == self.pers["class"] && var4) {
    onclasschoicecallback(var0, 1);
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

  foreach(var1 in level.teamnamelist) {
    if(scripts\mp\teams::ref_132e6() && var1 == "team_two_hundred") {
      continue;
    }

    var2 = scripts\mp\utility\teams::getteamdata(var1, "teamCount");

    if(level.maxteamsize == 0 || var2 < level.maxteamsize) {
      thread setteam(var1);
      break;
    }
  }

  return;
}

function setteam(var0) {
  self endon("disconnect");

  if(!isai(self) && level.teambased && !scripts\mp\teams::getjointeampermissions(var0) && !scripts\mp\utility\game::lobbyteamselectenabled()) {
    return;
  }

  if(level.ingraceperiod && !self.hasdonecombat) {
    self.hasspawned = 0;
    self.pers["lives"] = scripts\mp\utility\game::getgametypenumlives();
  }

  if(self.sessionstate == "playing") {
    self.switching_teams = 1;
    self.joining_team = var0;
    self.leaving_team = self.pers["team"];

    if(scripts\mp\utility\game::getgametype() == "arena") {
      self.switching_teams_arena = 1;
    }
  }

  if(istrue(game["isLaunchChunk"]) && isbot(self) == 0) {
    var0 = "allies";
  }

  addtoteam(var0);

  if(shouldmodesetsquads()) {
    thread setsquad(var0);
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
      var1 = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
      scripts\mp\utility\script::laststand_dogtags("setTeam() " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + var1);
    }

    self setclientomnvar("ui_options_menu", 2);
  }

  if(isDefined(level.ref_12065)) {
    self thread[[level.ref_12065]]();
  }

  waitforclassselect();
  endrespawnnotify();

  if((self.sessionstate == "spectator" || ref_125f1()) && !istrue(self.suicideswitched)) {
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

function ref_125f1() {
  return isDefined(level.ref_125f1) && self[[level.ref_125f1]]();
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

function setsquad(var0) {
  if(!level.teambased) {
    return;
  }

  if(!isDefined(level.squaddata)) {
    initsquaddata(level);
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    var1 = self getsquadindex();
    joinsquad(var0, var1);
    return;
  }

  var2 = issubstr(self.name, "tcBot") || issubstr(self.name, "_hl_");

  if(!isai(self) && !var2) {
    var3 = self getlobbysquadindex();

    if(var3 != -1) {
      self.squadassignedfromlobby = 1;
      joinsquad(var1, var3);
      return;
    }
  }

  if(istrue(scripts\mp\utility\game::matchmakinggame())) {
    var4 = self getfireteammembers();

    if(isDefined(var4) && var4.size > 0) {
      var1 = undefined;

      foreach(var6 in var4) {
        if(isDefined(var6) && isDefined(var6.squadindex)) {
          var1 = var6.squadindex;
          break;
        }
      }

      if(isDefined(var1)) {
        joinsquad(var1, var1);
        return;
      } else {
        requestnewsquad(var1, 1);
        return;
      }
    }
  }

  if(var1 != "spectator") {
    foreach(var9 in level.squaddata[var1]) {
      var9.isfull = var9.players.size == level.maxsquadsize;

      if(var9.inuse && !var9.isfireteam && !var9.isfull) {
        joinsquad(var1, var9.index);
        return;
      }
    }

    requestnewsquad(var1, 0);
    return;
  }
}

function initsquaddata() {
  if(!isDefined(level.maxsquadsize)) {
    level.maxsquadsize = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_squadsize", 4);
  }

  level.maxsquadwait = getdvarint("scr_squad_max_wait", 15);
  level.squaddata = [];

  foreach(var1 in level.teamnamelist) {
    level.squaddata[var1] = [];
  }

  thread monitorsquads();

  if(getdvarint("scr_debug_squads", 0) == 1) {
    thread debugprintsquads();
    return;
  }
}

function createsquad(var0, var1) {
  if(!isDefined(var1)) {
    var1 = level.squaddata[var0].size;
  }

  var2 = spawnStruct();
  var2.index = var1;
  var2.formedtime = undefined;
  var2.isfireteam = 0;
  var2.isstale = 0;
  var2.isfull = 0;
  var2.inuse = 0;
  var2.players = [];
  var2.spawnpoint = undefined;
  level.squaddata[var0][var1] = var2;
  return var1;
}

function checksquads() {
  foreach(var1 in level.teamnamelist) {
    if(!isDefined(level.squaddata[var1])) {
      continue;
    }

    foreach(var3 in level.squaddata[var1]) {
      if(!var3.inuse) {
        continue;
      }

      if(!var3.isstale && gettime() > var3.formedtime + level.maxsquadwait * 1000) {
        var3.isstale = 1;
      }

      var3.isfull = var3.players.size == level.maxsquadsize;
      var4 = 0;

      foreach(var6 in var3.players) {
        if(isDefined(var6)) {
          var4 = 1;
        }
      }

      if(!var4) {
        freesquadindex(var1, var3.index);
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

function requestnewsquad(var0, var1) {
  var2 = getavailablesquadindex(var0);
  var3 = level.squaddata[var0][var2];
  var3.index = var2;
  var3.formedtime = gettime();
  var3.isfireteam = var1;
  var3.isstale = 0;
  var3.isfull = 0;
  var3.inuse = 1;
  var3.players = [];
  var3.squadstartlocationkey = undefined;
  var3.infil = undefined;
  joinsquad(var0, var2);
}

function joinsquad(var0, var1) {
  if(!isDefined(level.squaddata[var0][var1])) {
    createsquad(var0, var1);
  }

  var2 = isDefined(self.pers["squadIndex"]) && self.pers["squadIndex"] == var1;

  if(isDefined(self.squadindex)) {
    var3 = 0;

    foreach(var5 in level.squaddata) {
      foreach(var7 in var5) {
        if(scripts\engine\utility::array_contains(var7.players, self)) {
          level.squaddata[var9][var8].players = scripts\engine\utility::array_remove(var7.players, self);
          var3 = 1;
          break;
        }
      }

      if(var3) {
        break;
      }
    }
  }

  self.squadindex = var1;
  self.pers["squadIndex"] = var1;

  if(!var2 || !isDefined(self.pers["squadMemberIndex"])) {
    self.pers["squadMemberIndex"] = level.squaddata[var0][var1].players.size;

    if(scripts\mp\utility\game::getgametype() == "br") {
      self.pers["squadMemberIndex"]++;
    }
  }

  if(!istrue(scripts\mp\utility\game::matchmakinggame())) {
    self setsquadindex(var1);
  }

  level.squaddata[var0][var1].players[level.squaddata[var0][var1].players.size] = self;
  scripts\mp\utility\join_squad_aggregator::onplayerjoinsquad(self);
  self notify("joined_squad");

  if(istrue(level.usesquadleader)) {
    choosesquadleader(var0, var1);
  }

  if(scripts\mp\utility\game::getgametype() != "br") {
    updatesquadomnvars(var0, var1);
    return;
  }
}

function leavesquad(var0, var1) {
  if(scripts\mp\utility\game::getgametype() == "br") {
    level.squaddata[var0][var1].players = scripts\engine\utility::array_remove(level.squaddata[var0][var1].players, self);
    return;
  }

  if(isDefined(var0) && isDefined(var1)) {
    thread scripts\mp\spawnselection::ref_12acb(var0, var1);
  }

  var2 = 0;
  var3 = getsquadleader(var0, var1);

  if(istrue(level.usesquadleader) && isDefined(var3) && var3 == self) {
    level.squaddata[var0][var1].squadleaderindex = undefined;
    var2 = 1;
  }

  level.squaddata[var0][var1].players = scripts\engine\utility::array_remove(level.squaddata[var0][var1].players, self);

  for(var4 = 0; var4 < level.squaddata[var0][var1].players.size; var4++) {
    level.squaddata[var0][var1].players[var4].pers["squadMemberIndex"] = var4;
  }

  if(istrue(var2)) {
    var5 = scripts\engine\utility::array_randomize(level.squaddata[var0][var1].players);

    foreach(var7 in var5) {
      if(isDefined(var7)) {
        choosesquadleader(var7, var0, var1);
        break;
      }
    }
  }

  updatesquadomnvars(var0, var1);
}

function updatesquadomnvars(var0, var1) {
  var2 = getsquadleader(var0, var1);

  foreach(var4 in level.squaddata[var0][var1].players) {
    var5 = var1;
    var5 += level.squaddata[var0][var1].players.size << 5;

    if(isDefined(var2) && var2 == var4) {
      var5 += 256;
    }

    var4 setclientomnvar("ui_squad_data", var5);

    if(scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "arena" || scripts\mp\utility\game::getgametype() == "brtdm") {
      var6 = var4.game_extrainfo & 65528;
      var4.game_extrainfo = var6 | var4.pers["squadMemberIndex"] + 1;

      if(isDefined(var2) && var2 == var4) {
        var4.game_extrainfo |= 64;
      } else {
        var4.game_extrainfo &= ~64;
      }

      var7 = var4 getentitynumber();

      if(isDefined(var2) && var2 == var4) {
        var7 += 2048;
      }

      if(isalive(var4)) {
        var7 += 4096;
      }

      var4 setclientomnvar("ui_arm_squadmember_0", var7);
      var8 = scripts\engine\utility::array_remove(level.squaddata[var0][var1].players, var4);

      for(var9 = 0; var9 < 3; var9++) {
        var10 = var8[var9];

        if(isDefined(var10)) {
          var7 = var10 getentitynumber();

          if(isDefined(var2) && var2 == var10) {
            var7 += 2048;
          }

          if(isalive(var10)) {
            var7 += 4096;
          }
        } else {
          var7 = -1;
        }

        var4 setclientomnvar("ui_arm_squadmember_" + var9 + 1, var7);
      }
    }
  }
}

function getavailablesquadindex(var0) {
  foreach(var2 in level.squaddata[var0]) {
    if(!var2.inuse) {
      return var2.index;
    }
  }

  return createsquad(var0);
}

function freesquadindex(var0, var1) {
  level.squaddata[var0][var1].formedtime = undefined;
  level.squaddata[var0][var1].isfireteam = 0;
  level.squaddata[var0][var1].isstale = 0;
  level.squaddata[var0][var1].isfull = 0;
  level.squaddata[var0][var1].inuse = 0;
  level.squaddata[var0][var1].players = [];
  level.squaddata[var0][var1].squadstartlocationkey = undefined;
  level.squaddata[var0][var1].infil = undefined;
}

function choosesquadleader(var0, var1) {
  if(isDefined(getsquadleader(var0, var1))) {
    return;
  }

  if(istrue(scripts\mp\utility\game::matchmakinggame())) {
    var2 = self getfireteammembers();

    if(isDefined(var2) && var2.size > 0) {
      if(self isfireteamleader()) {
        foreach(var5, var4 in level.squaddata[self.team][self.squadindex].players) {
          if(var4 == self) {
            level.squaddata[var0][var1].squadleaderindex = var5;
          }
        }
      } else {
        return;
      }
    }
  }

  foreach(var4 in level.squaddata[self.team][self.squadindex].players) {
    if(var4 == self) {
      level.squaddata[var0][var1].squadleaderindex = var5;
    }
  }
}

function getsquadleader(var0, var1) {
  var2 = level.squaddata[var0][var1].squadleaderindex;

  if(!isDefined(var2)) {
    return undefined;
  }

  return level.squaddata[var0][var1].players[var2];
}

function ref_13733() {
  return getdvarint("LNKKRLTPNS", 0) != 0;
}

function brking_updateteamscore() {
  return getdvarint("NPSRPPOSP", 0) != 0;
}

function setspectator(var0) {
  if((!isDefined(var0) || !var0) && isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
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

function setfollower(var0) {
  if((!isDefined(var0) || !var0) && isDefined(self.pers["team"]) && self.pers["team"] == "follower") {
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
    var0 = scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::allowclasschoice() && (!scripts\mp\flags::gameflag("prematch_done") || istrue(level.ref_133e0) || istrue(level.dmztut_endgametransition));
    var1 = scripts\mp\utility\game::teamhasinfil(self.team) && !scripts\mp\flags::gameflag("infil_started") && !isDefined(level.bypassclasschoicefunc);

    if(var0 || var1) {
      var2 = "class_select";

      if(!isai(self)) {
        var3 = scripts\mp\rank::getrank() >= 4;

        if(var3 && !scripts\mp\utility\game::tv_station_intro_camera()) {
          var4 = self getplayerdata(level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex");
        } else {
          var4 = 100;
        }
      } else {
        var4 = "callback";
      }
    } else if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
      if(!self ismlgspectator() && getdvarint("debug_GLSpectate", 0) == 0 && self.team != "spectator" && scripts\mp\utility\game::getgametype() != "arm") {
        scripts\mp\utility\lower_message::setlowermessageomnvar(15);
      }

      self waittill("loadout_class_selected", var4);
    } else {
      bypassclasschoice();
      break;
    }

    if(self.team == "spectator") {
      continue;
    }

    if("" + var4 != "callback") {
      if(isbot(self)) {
        self.pers["class"] = var4;
        self.class = var4;
      } else {
        var4 = var4;
        self.pers["class"] = getclasschoice(var4);
        self.class = getclasschoice(var4);
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

function beginclasschoice(var0) {
  var1 = self.pers["team"];

  if(scripts\mp\utility\game::allowclasschoice() || scripts\mp\utility\game::showfakeloadout() && !isai(self)) {
    if(getdvarint("scr_force_cac_sre_callstack", 0) == 1 && scripts\mp\utility\game::getgametype() == "br" && scripts\mp\utility\game::round_vehicle_logic() != "dmz" && scripts\mp\utility\game::round_vehicle_logic() != "rat_race" && scripts\mp\utility\game::round_vehicle_logic() != "risk" && scripts\mp\utility\game::round_vehicle_logic() != "sandbox" && scripts\mp\utility\game::round_vehicle_logic() != "rumble" && scripts\mp\utility\game::round_vehicle_logic() != "gold_war") {
      var2 = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
      scripts\mp\utility\script::laststand_dogtags("beginClassChoice() " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + var2);
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
    var0 = self[[level.bypassclasschoicefunc]]();
    self.class = var0;
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

function menuclass(var0) {
  var1 = self.pers["team"];
  var2 = scripts\mp\class::getclasschoice(var0);
  var3 = scripts\mp\class::getweaponchoice(var0);

  if(var2 == "restricted") {
    beginclasschoice();
    return;
  }

  if(isDefined(self.pers["class"]) && self.pers["class"] == var2 && isDefined(self.pers["primary"]) && self.pers["primary"] == var3) {
    return;
  }

  if(self.sessionstate == "playing") {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self.lastclass = self.pers["lastClass"];
    }

    self.pers["class"] = var2;
    self.class = var2;
    self.pers["primary"] = var3;

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

    self.pers["class"] = var2;
    self.class = var2;
    self.pers["primary"] = var3;

    if(game["state"] == "postgame") {
      return;
    }

    if(game["state"] == "playing" && !scripts\mp\utility\player::isinkillcam()) {
      thread scripts\mp\playerlogic::spawnclient();
    }
  }

  thread scripts\mp\spectating::setspectatepermissions();
}

function addtoteam(var0, var1, var2) {
  if(isDefined(self.team)) {
    scripts\mp\playerlogic::removefromteamcount();

    if(isDefined(var2) && var2) {
      scripts\mp\playerlogic::decrementalivecount(self.team, 0, "addToTeam");
    }

    if(shouldmodesetsquads() && isDefined(self.squadindex) && self.team != "spectator") {
      leavesquad(self.team, self.squadindex);
    }
  }

  if(isDefined(self.pers["team"]) && self.pers["team"] != "" && self.pers["team"] != "spectator") {
    self.pers["last_team"] = self.pers["team"];
  }

  self.changedteams = isDefined(self.pers["last_team"]) && self.pers["last_team"] != var0;
  self.pers["team"] = var0;
  self.team = var0;
  var3 = isbot(self) || initmaxspeedforpathlengthtable(self);

  if(var3) {
    setsessionteam(var0);
  } else if(!scripts\mp\utility\game::denysystemicteamchoice()) {
    if(scripts\mp\utility\game::matchmakinggame()) {
      if(!scripts\mp\utility\game::allowteamassignment()) {
        if(scripts\mp\utility\game::getgametype() == "infect") {
          setsessionteam(var0);
        } else {
          setemptysessionteam(var0);
        }
      }
    } else if(!function_0426()) {
      setsessionteam(var0);
    }
  }

  if(game["state"] != "postgame") {
    scripts\mp\playerlogic::addtoteamcount(istrue(var2));
  }

  scripts\mp\utility\game::updateobjectivetext();

  if(isDefined(var1) && var1) {
    waittillframeend();
  }

  if(var0 == "spectator" || var0 == "follower") {
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

function setsessionteam(var0) {
  if(level.teambased) {
    self.sessionteam = var0;
    return;
  }

  setemptysessionteam(var0);
}

function setemptysessionteam(var0) {
  if(var0 == "spectator") {
    self.sessionteam = "spectator";
    return;
  }

  if(var0 == "follower") {
    self.sessionteam = "follower";
    return;
  }

  self.sessionteam = "none";
}

function endrespawnnotify() {
  self.waitingtospawn = 0;
  self notify("end_respawn");
}

function logteamselection(var0) {
  if(getdvarint("scr_playtest", 0) == 0) {
    return;
  }

  if(var0 != "random") {
    iprintlnbold("" + self.name + " did not select auto-assign");
    return;
  }
}

function debugprintsquads() {
  var0 = 25;

  for(;;) {
    if(isDefined(level.squaddata)) {
      var1 = 800;
      var2 = 25;
      var3 = 1;

      foreach(var5 in level.squaddata) {
        var3 = 1;
        var3++;

        foreach(var7 in var5) {
          var8 = (1, 1, 1);

          if(isDefined(var7.activemission)) {
            var8 = (1, 1, 0);
          }

          var3++;

          foreach(var10 in var7.players) {
            var8 = (1, 1, 1);

            if(istrue(var10.squadassignedfromlobby)) {
              var8 = (0, 1, 0);
            }

            var3++;
          }
        }

        var1 += 200;
      }
    }

    waitframe();
  }
}