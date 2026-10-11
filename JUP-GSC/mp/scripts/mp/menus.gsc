/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\menus.gsc
***********************************************/

#using script_3f8889c16399185c;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\cp_mp\pet_watch;
#using scripts\cp_mp\squads;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\utility;
#using scripts\mp\bounty;
#using scripts\mp\class;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\br;
#using scripts\mp\hud_message;
#using scripts\mp\playerlogic;
#using scripts\mp\spectating;
#using scripts\mp\teams;
#using scripts\mp\utility\game;
#using scripts\mp\utility\join_team_aggregator;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\lui_game_event_aggregator;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\teams;
#namespace menus;

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
      for(i = 0; i < level.teamnamelist.size; i++) {
        var_62890c80c835c4a5 = "menu_class_" + level.teamnamelist[i];
        var_90e671d45a71be99 = "menu_changeclass_" + level.teamnamelist[i];
        game[var_62890c80c835c4a5] = game["menu_class_allies"];
        game[var_90e671d45a71be99] = "changeclass_marines";
      }
    }

    game["menu_changeclass"] = "changeclass";
    game["menu_controls"] = "ingame_controls";

    if(level.splitscreen) {
      if(level.multiteambased) {
        for(i = 0; i < level.teamnamelist.size; i++) {
          var_62890c80c835c4a5 = "menu_class_" + level.teamnamelist[i];
          var_90e671d45a71be99 = "menu_changeclass_" + level.teamnamelist[i];
          game[var_62890c80c835c4a5] += "_splitscreen";
          game[var_90e671d45a71be99] += "_splitscreen";
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
  level.var_ce4945d1893fbaca = getdvarint(@ "hash_6cb6994f3a89112c", 0);
  level thread setintrocamnetworkmodel();
}

function onteamchangecallback(channel, teamselected) {
  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    println("<dev string:x1c>" + self getentitynumber() + "<dev string:x28>" + self.name + "<dev string:x36>" + channel);

    if(channel != "team_select") {
      return;
    }

    if(matchmakinggame()) {
      return;
    }

    handleteamchange(channel, teamselected);
  }
}

function setintrocamnetworkmodel() {
  setintrocameraactive(1);
  level waittill("prematch_over");
  setintrocameraactive(0);
}

function isloadoutindexdefault(index) {
  return index >= 100;
}

function getclasschoice(menuindex) {
  menuindex++;
  newclasschoice = undefined;

  if(menuindex > 100) {
    classindex = menuindex - 100;
    newclasschoice = "default" + classindex;
  } else if(function_788bcfab4101649a(self)) {
    newclasschoice = "custom" + menuindex;
  } else {
    newclasschoice = "default1";
  }

  return newclasschoice;
}

function executeclasschange(newclass, var_fda7f7e8fc307aba) {
  if(isbot(self) || istestclient(self)) {
    self.pers["class"] = newclass;
    self.class = newclass;
    return;
  }

  newclasschoice = getclasschoice(newclass);

  if(!isDefined(self.pers["class"]) || newclasschoice != self.pers["class"] || var_fda7f7e8fc307aba) {
    self.pers["class"] = newclasschoice;
    self.class = newclasschoice;
    scripts\mp\class::preloadandqueueclass(newclasschoice);
  }

  var_cd83a28652a3f837 = 1;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && !scripts\mp\gamelogic::function_20fcd7762daec487()) {
    var_cd83a28652a3f837 = 0;
  }

  error = spawnStruct();

  if(scripts\mp\class::shouldallowinstantclassswap(error) && var_cd83a28652a3f837) {
    thread scripts\mp\class::swaploadout();
    return;
  }

  var_5e6a291a22a0d249 = scripts\cp_mp\utility\game_utility::isbrstylegametype() && self getclientomnvar("ui_open_loadout_bag");

  if(isalive(self) && !var_5e6a291a22a0d249 && isDefined(error.string)) {
    scripts\mp\hud_message::showerrormessage(error.string, error.param);
  }

  if(newclass < 100) {
    self setclientomnvar("ui_loadout_changed", scripts\mp\class::getclassindex(self.pers["class"]));
  }
}

function setnextroundclass(newclass) {
  newclasschoice = newclass;

  if(!isbot(self)) {
    if(isalive(self)) {
      self iprintlnbold(game["strings"]["revive_class"]);
    }

    newclasschoice = getclasschoice(newclass);
  }

  self.pers["next_round_class"] = newclasschoice;
}

function onleavegamecallback(channel, val) {
  if(channel != "end_game") {
    return;
  }

  if(matchmakinggame()) {
    return;
  }

  if(isdedicatedserver() && !function_d1e52856dc19c5d0(self)) {
    return;
  }

  if(isDefined(level.var_30c7107330cebcce)) {
    level thread[[level.var_30c7107330cebcce]](val);
    return;
  }

  level thread scripts\mp\gamelogic::forceend(val);
}

function onclasseditcallback(newclass) {
  self endon("disconnect");
  waittillframeend();
  handleclassedit(newclass);

  if(getgametype() == "br") {
    scripts\mp\gametypes\br::function_4043e420432f59f0(getclasschoice(newclass));
  }
}

function onclasschoicecallback(newclass, var_f01f8e178ff54eda) {
  self notify("loadout_class_selected", newclass);

  if(level.systemlink && getdvarint(@ "xblive_competitionmatch") && self iscodcaster()) {
    self setclientomnvar("ui_options_menu", 0);
    return;
  }

  if(istrue(self.waitingtoselectclass)) {
    if(isDefined(self.revive_chosenclass)) {
      setnextroundclass(newclass);
    }

    if(istrue(level.var_ce4945d1893fbaca)) {
      self.waitingtoselectclass = 0;
      self setclientomnvar("ui_options_menu", 4);
      self.var_48366f4aaeafcf5d = 1;
      return;
    }

    self setclientomnvar("ui_options_menu", 0);
    return;
  }

  self setclientomnvar("ui_options_menu", 0);

  if(!allowclasschoice() || showfakeloadout()) {
    return;
  }

  if(isDefined(self.revive_chosenclass) && isDefined(self.instantclassswapallowed) && !scripts\mp\class::shouldallowinstantclassswap()) {
    setnextroundclass(newclass);
    return;
  }

  if("" + newclass != "callback") {
    executeclasschange(newclass, istrue(var_f01f8e178ff54eda));

    if(istrue(self.var_48366f4aaeafcf5d)) {
      self setclientomnvar("ui_options_menu", 0);
      self.var_48366f4aaeafcf5d = 0;
      return;
    }

    return;
  }

  menuclass("callback");
}

function handleteamchange(channel, teamselected) {
  var_80b8e166e8e16ba6 = 0;

  if(teamselected >= 3) {
    var_80b8e166e8e16ba6 = 1;
  }

  if(var_80b8e166e8e16ba6) {
    self setclientomnvar("ui_spectator_selected", 1);
    self.spectating_actively = 1;
  } else {
    self setclientomnvar("ui_spectator_selected", -1);
    self.spectating_actively = 0;
  }

  var_fff3522de2da93f8 = self iscodcaster();
  wasspectator = !var_fff3522de2da93f8 && isDefined(self.team) && (self.team == "spectator" || self.team == "codcaster");
  needrespawn = var_fff3522de2da93f8 && teamselected == 3 || wasspectator && (teamselected == 4 || teamselected == 5);

  if(teamselected == 4 || teamselected == 5) {
    teamselected = 3;
    self function_7398d812fca0292f(1);
  } else {
    self function_7398d812fca0292f(0);
  }

  if(teamselected == 0) {
    teamselected = "axis";
  } else if(teamselected == 1) {
    teamselected = "allies";
  } else if(teamselected == 2) {
    teamselected = "random";
  } else if(teamselected == 4) {
    teamselected = "codcaster";
  } else {
    teamselected = "spectator";
  }

  if(!needrespawn && isDefined(self.pers["team"]) && teamselected == self.pers["team"]) {
    return;
  }

  if(isDefined(self.operatorcustomization)) {
    self.operatorcustomization.rebuild = 1;
  }

  thread logteamselection(teamselected);

  if(teamselected != "spectator") {
    self.pers["playerChoseSpectatorTeam"] = undefined;
  } else {
    self.pers["playerChoseSpectatorTeam"] = 1;
  }

  if(teamselected == "axis") {
    thread setteam("axis");
    return;
  }

  if(teamselected == "allies") {
    thread setteam("allies");
    return;
  }

  if(teamselected == "random") {
    thread autoassign();
    return;
  }

  if(teamselected == "codcaster") {
    thread function_9ff5c7531349cdfc(needrespawn);
    return;
  }

  if(teamselected == "spectator") {
    thread setspectator(needrespawn);
  }
}

function handleclassedit(newclass) {
  classname = getclasschoice(newclass);
  var_a022fbcafc053c4a = scripts\mp\class::loadout_editcachedclassstruct(classname);
  var_5410628ddd8dfd8a = scripts\mp\class::loadout_editglobalclassstruct();
  anydifference = var_a022fbcafc053c4a || var_5410628ddd8dfd8a;

  if(isDefined(self.pers["class"]) && classname == self.pers["class"] && anydifference) {
    onclasschoicecallback(newclass, 1);
  }
}

function function_c69c22ef9e1e92a0(var_f0c136ca13f8bc76) {
  for(teamindex = level.teamnamelist.size - 1; teamindex >= 0; teamindex--) {
    candidate = level.teamnamelist[teamindex];
    teamplayers = getteamdata(candidate, "players");
    hashuman = 0;

    foreach(player in teamplayers) {
      if(!isbot(player)) {
        hashuman = 1;
        break;
      }
    }

    count = teamplayers.size;

    if(var_f0c136ca13f8bc76) {
      count += getteamdata(candidate, "UnlockedUIBotCount");
    }

    if(!hashuman && (level.maxteamsize == 0 || count < level.maxteamsize)) {
      thread setteam(candidate);
      return true;
    }
  }

  return false;
}

function autoassign(firstconnect) {
  if(scripts\cp_mp\utility\game_utility::isinfectedgametype()) {
    thread setteam("allies");
    return;
  }

  forceteam = getDvar(@ "scr_force_team", "");

  if(isgameplayteam(forceteam)) {
    setsessionteam(forceteam);
    thread setteam(forceteam, firstconnect);
    return;
  }

  if(getdvarint(@ "hash_3f36284b49b3d7a", 0) != 0) {
    thread setteam("allies");
    return;
  }

  var_f0c136ca13f8bc76 = level.maxteamsize > 0 && isDefined(level.var_7b37b2193f163b9b);

  if(isbot(self) && isDefined(self.bot_team) && self.bot_team != "autoassign") {
    thread setteam(self.bot_team);

    if(var_f0c136ca13f8bc76) {
      function_e9a6fdc468a5fa73(self.bot_team);
    }

    return;
  }

  if(self iscodcaster()) {
    thread function_9ff5c7531349cdfc();
    return;
  }

  if(self.sessionteam == "spectator") {
    thread setspectator();
    return;
  }

  if(istrue(level.teammaxfill)) {
    println("<dev string:x47>");
    var_cf36f495aef1cf75 = isbot(self) && getdvarint(@ "hash_d356a7876f773136", 0) != 0;

    if(var_cf36f495aef1cf75 && function_c69c22ef9e1e92a0(var_f0c136ca13f8bc76)) {
      return;
    }

    for(teamindex = 0; teamindex < level.teamnamelist.size; teamindex++) {
      entry = level.teamnamelist[teamindex];

      if(var_f0c136ca13f8bc76) {
        function_e9a6fdc468a5fa73(entry);
      }

      count = getteamdata(entry, "teamCount");

      if(var_f0c136ca13f8bc76) {
        count += getteamdata(entry, "UnlockedUIBotCount");
      }

      if(level.maxteamsize == 0 || count < level.maxteamsize) {
        thread setteam(entry);
        break;
      }
    }

    if(!isDefined(self.team)) {
      assertmsg("<dev string:x6f>");
      kick(self getentitynumber());
    }

    return;
  }

  lowestcount = 0;
  lowestteams = [];

  foreach(entry in level.teamnamelist) {
    count = getteamdata(entry, "teamCount");

    if(isDefined(self.team) && self.team == entry) {
      count--;
    }

    if(!lowestteams.size || count < lowestcount) {
      lowestcount = count;
      lowestteams = [];
      lowestteams[lowestteams.size] = entry;
      continue;
    }

    if(count == lowestcount) {
      lowestteams[lowestteams.size] = entry;
    }
  }

  if(lowestteams.size == 1) {
    if(!isDefined(self.team) || self.team != lowestteams[0]) {
      thread setteam(lowestteams[0]);
    }

    return;
  }

  if(level.teambased) {
    bestteam = scripts\mp\gamescore::gethighestscoringteam();

    if(array_contains(lowestteams, bestteam)) {
      lowestteams = array_remove(lowestteams, bestteam);
    }
  }

  if(isDefined(self.team) && array_contains(lowestteams, self.team)) {
    lowestteams = array_remove(lowestteams, self.team);
  }

  if(lowestteams.size > 0) {
    randidx = randomint(lowestteams.size);

    if(istrue(level.autoassignlowteamconsistent)) {
      randidx = 0;
    }

    thread setteam(lowestteams[randidx]);
  }
}

function function_e9a6fdc468a5fa73(team) {
  var_3232b53ef5690097 = getteamdata(team, "teamCount");
  var_2b68f240fb19593d = getteamdata(team, "UnlockedUIBotCount");

  if(var_3232b53ef5690097 + var_2b68f240fb19593d > level.maxteamsize) {
    assertmsg("<dev string:xd4>" + level.maxteamsize + "<dev string:x11a>" + team + "<dev string:x124>" + var_3232b53ef5690097 + "<dev string:x136>" + var_2b68f240fb19593d);
  }
}

function setteam(selection, firstconnect) {
  self endon("disconnect");

  if(!isai(self) && level.teambased && !scripts\mp\teams::getjointeampermissions(selection) && !lobbyteamselectenabled()) {
    return;
  }

  if(level.ingraceperiod && !istrue(self.hasdonecombat)) {
    self.hasspawned = 0;
    self.pers["lives"] = getgametypenumlives();
  }

  if(self.sessionstate == "playing") {
    self.switching_teams = 1;
    self.joining_team = selection;
    self.leaving_team = self.pers["team"];

    if(getgametype() == "arena") {
      self.switching_teams_arena = 1;
    }
  } else if(istrue(firstconnect) && isDefined(level.var_d37d95ac1717903c)) {
    selection = self[[level.var_d37d95ac1717903c]]();
  }

  if(istrue(game["isLaunchChunk"]) && isbot(self) == 0) {
    selection = "allies";
  }

  addtoteam(selection);
  thread scripts\cp_mp\squads::setsquad(selection);

  if(isragdollzerog()) {
    self lockdeathcamera(1);
  }

  if(self.sessionstate == "playing") {
    self suicide();
    updatesessionstate("spectator");
    self.suicideswitched = 1;
  }

  if(allowclasschoice() || showfakeloadout() && !isai(self)) {
    if(getdvarint(@ "hash_206a763969420ce0", 0) == 1 && scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "dmz" && getsubgametype() != "exgm" && getsubgametype() != "plunder" && getsubgametype() != "risk" && getsubgametype() != "sandbox" && getsubgametype() != "rumble_mgl") {
      classchoicefunc = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
      scripts\mp\utility\script::demoforcesre("setTeam() " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + classchoicefunc);
    }

    if(!istrue(self.var_5354295b99468cef) && !istrue(self.var_10844ddcb34694ee) && getdvarint(@ "hash_89556297eaab6b6a", 0) == 0) {
      self setclientomnvar("ui_options_menu", 2);
    }
  }

  if(isDefined(level.onplayerconnectstream)) {
    self thread[[level.onplayerconnectstream]]();
  }

  if(!istrue(self.var_5354295b99468cef)) {
    waitforclassselect();
  }

  endrespawnnotify();

  if((self.sessionstate == "spectator" || playerisstreaming()) && !istrue(self.suicideswitched)) {
    if(game["state"] == "postgame") {
      return;
    }

    if(game["state"] == "playing" && !isinkillcam()) {
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

function playerisstreaming() {
  return isDefined(level.playerisstreaming) && self[[level.playerisstreaming]]();
}

function squadasteamenabled() {
  return getdvarint(@ "hash_61be9f6a05f64523", 0) != 0;
}

function function_2c0eb018b319f66() {
  return getdvarint(@ "hash_a9194b992d1058d6", 0) != 0;
}

function setspectator(needrespawn) {
  if((!isDefined(needrespawn) || !needrespawn) && isDefined(self.pers["team"]) && self.pers["team"] == "spectator") {
    return;
  }

  if(isalive(self)) {
    assert(isDefined(self.pers["<dev string:x191>"]));
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

function function_9ff5c7531349cdfc(needrespawn) {
  if((!isDefined(needrespawn) || !needrespawn) && isDefined(self.pers["team"]) && self.pers["team"] == "codcaster") {
    return;
  }

  if(isalive(self)) {
    assert(isDefined(self.pers["<dev string:x191>"]));
    self.switching_teams = 1;
    self.joining_team = "codcaster";
    self.leaving_team = self.pers["team"];
    self suicide();
  }

  self notify("becameSpectator");
  addtoteam("codcaster");
  self.pers["class"] = undefined;
  self.class = undefined;
  thread scripts\mp\playerlogic::spawnspectator();
}

function function_788bcfab4101649a(player) {
  if(!isDefined(player)) {
    return false;
  }

  if(getdvarint(@ "hash_6fbfdde9fc5d2964", 0) != 0) {
    return true;
  }

  if(getdvarint(@ "hash_955ca650f9a9bdef") != 0) {
    return true;
  }

  if(scripts\mp\utility\game::privatematch()) {
    return true;
  }

  if(istrue(level.systemlink)) {
    return true;
  }

  if(istrue(level.leagueplaymatch) && getdvarint(@ "hash_48d877b577f2565b", 1) != 0) {
    return true;
  }

  if(getrank() >= 4) {
    return true;
  }

  return false;
}

function waitforclassselect() {
  self endon("disconnect");
  level endon("game_ended");
  self.waitingtoselectclass = 1;

  if(gameflag("prematch_done") && istrue(level.usespawnselection) && !istrue(self.hasspawned)) {
    self setclientomnvar("ui_world_fade", 1);
    self setclientomnvar("ui_hide_objectives", 1);
    self setclientomnvar("ui_in_spawn_camera", 1);
  }

  for(;;) {
    var_40645c66e8a85816 = scripts\cp_mp\utility\game_utility::isbrstylegametype() && allowclasschoice() && (!gameflag("prematch_done") || istrue(level.skipprematch));
    var_7e61909352db412d = teamhasinfil(self.team) && !gameflag("infil_started") && !isDefined(level.bypassclasschoicefunc);
    var_9cfda0afbbf50688 = islifelimited() && !isDefined(level.bypassclasschoicefunc) && isgameplayteam(self.team);

    if(scripts\cp_mp\utility\game_utility::isbrstylegametype() && (getsubgametype() == "dmz" || getsubgametype() == "exgm") && !istrue(level.br_allowloadout)) {
      newclass = 0;
    } else if(var_40645c66e8a85816 || var_7e61909352db412d || var_9cfda0afbbf50688) {
      channel = "class_select";

      if(istestclient(self)) {
        newclass = "default1";
      } else if(!isai(self)) {
        var_788bcfab4101649a = function_788bcfab4101649a(self);

        if(var_788bcfab4101649a && !function_1e098780c33853f2() || getdvarint(@ "hash_89556297eaab6b6a", 0)) {
          newclass = self getplayerdata(level.loadoutsgroup, "customizationFavorites", "favoriteLoadoutIndex");
        } else {
          newclass = 100;
        }
      } else {
        newclass = "callback";
      }
    } else if(allowclasschoice() || showfakeloadout() && !isai(self)) {
      if(scripts\cp_mp\utility\game_utility::function_fa7bfcc1d68b7b73()) {
        if(gameflag("prematch_done") && (!isDefined(level.infilcinematicactive) || level.infilcinematicactive)) {
          bypassclasschoice();
          break;
        }
      }

      if(!self iscodcaster() && getdvarint(@ "hash_e32ebdbb97a1ec4e", 0) == 0 && self.team != "spectator" && getgametype() != "arm" && getgametype() != "conflict") {
        scripts\mp\utility\lower_message::setlowermessageomnvar("must_select_loadout_to_spawn");
      }

      var_3c8dceee54a35f62 = getdvarint(@ "hash_d831c84920a830ff", 0);

      if(var_3c8dceee54a35f62 > 0) {
        thread function_941a6cafc9c004e4(var_3c8dceee54a35f62);
      }

      self waittill("loadout_class_selected", newclass);
    } else {
      bypassclasschoice();
      break;
    }

    if(self.team == "spectator") {
      waitframe();
      continue;
    }

    if((isjuggermoshgamemode() || ismutationgamemodezombie()) && !isbot(self) && !isloadoutindexdefault(newclass)) {
      newclass = 100;
    }

    if("" + newclass != "callback") {
      if(isbot(self) || istestclient(self)) {
        self.pers["class"] = newclass;
        self.class = newclass;
      } else {
        newclass = newclass;
        self.pers["class"] = getclasschoice(newclass);
        self.class = getclasschoice(newclass);
      }

      scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");
      self.waitingtoselectclass = 0;
    } else {
      self.waitingtoselectclass = 0;
      menuclass("callback");
    }

    break;
  }
}

function function_941a6cafc9c004e4(var_3c8dceee54a35f62) {
  self endon("disconnect");
  self endon("loadout_class_selected");
  wait var_3c8dceee54a35f62;
  thread onclasschoicecallback(randomintrange(100, 110));
}

function beginclasschoice(forcenewchoice) {
  team = self.pers["team"];
  assert(team == "<dev string:x199>" || team == "<dev string:x1a1>" || issubstr(team, "<dev string:x1ab>"));

  if(allowclasschoice() || showfakeloadout() && !isai(self)) {
    if(getdvarint(@ "hash_206a763969420ce0", 0) == 1 && scripts\cp_mp\utility\game_utility::isbrstylegametype() && getsubgametype() != "dmz" && getsubgametype() != "exgm" && getsubgametype() != "plunder" && getsubgametype() != "risk" && getsubgametype() != "sandbox" && getsubgametype() != "rumble_mgl") {
      classchoicefunc = isDefined(level.allowclasschoicefunc) && istrue(self[[level.allowclasschoicefunc]]());
      scripts\mp\utility\script::demoforcesre("beginClassChoice() " + self.name + " ui_options_menu = 2, allowClassChoiceFunc = " + classchoicefunc);
    }

    if(!istrue(self.var_10844ddcb34694ee)) {
      self setclientomnvar("ui_options_menu", 2);
    }

    if(!self iscodcaster()) {
      waitforclassselect();
    }

    endrespawnnotify();

    if(self.sessionstate == "spectator") {
      if(game["state"] == "postgame") {
        return;
      }

      if(game["state"] == "playing" && !isinkillcam()) {
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

  if(ispresstofirstspawnmode() && level.enforceantiboosting && !isbot(self)) {
    scripts\mp\utility\lower_message::setlowermessageomnvar("press_to_spawn");
    self notifyonplayercommand("pressToSpawn", "+usereload");
    self notifyonplayercommand("pressToSpawn", "+activate");
    thread waitthensetspawnomnvar();
    self waittill("pressToSpawn");
  }

  if(isDefined(level.bypassclasschoicefunc)) {
    class_choice = self[[level.bypassclasschoicefunc]]();
    self.class = class_choice;
    return;
  }

  self.class = "class0";

  if(isDefined(level.gametypebundle) && isDefined(level.gametypebundle.namekey)) {
    namekey = getxhash(level.gametypebundle.namekey);

    if(namekey == #"zm_rb" || namekey == #"zm_turned") {
      self.class = "default1";
    }
  }
}

function ispresstofirstspawnmode() {
  if(getdvarint(@ "hash_eeaebebf98d1e9e7", 0) == 0) {
    return false;
  }

  if(scripts\cp_mp\utility\game_utility::isinfectedgametype()) {
    return true;
  } else if(getgametype() == "dm" && istrue(level.aonrules)) {
    return true;
  } else if(getgametype() == "gun") {
    return true;
  }

  return false;
}

function waitthensetspawnomnvar() {
  self endon("pressToSpawn");
  wait 1;

  if(isDefined(self)) {
    scripts\mp\utility\lower_message::setlowermessageomnvar("press_to_spawn");
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
    assert(isDefined(self.pers["<dev string:x191>"]));
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

function menuclass(response) {
  assert(isDefined(self.pers["<dev string:x191>"]));
  team = self.pers["team"];
  assert(team == "<dev string:x1a1>" || team == "<dev string:x199>" || issubstr(team, "<dev string:x1ab>"));
  class = scripts\mp\class::getclasschoice(response);
  primary = scripts\mp\class::getweaponchoice(response);

  if(class == "restricted") {
    beginclasschoice();
    return;
  }

  if(isDefined(self.pers["class"]) && self.pers["class"] == class && isDefined(self.pers["primary"]) && self.pers["primary"] == primary) {
    return;
  }

  if(self.sessionstate == "playing") {
    if(isDefined(self.pers["lastClass"]) && isDefined(self.pers["class"])) {
      self.pers["lastClass"] = self.pers["class"];
      self.lastclass = self.pers["lastClass"];
    }

    self.pers["class"] = class;
    self.class = class;
    self.pers["primary"] = primary;

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

    self.pers["class"] = class;
    self.class = class;
    self.pers["primary"] = primary;

    if(game["state"] == "postgame") {
      return;
    }

    if(game["state"] == "playing" && !isinkillcam() && !scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
      thread scripts\mp\playerlogic::spawnclient();
    }
  }

  thread scripts\mp\spectating::setspectatepermissions();
}

function addtoteam(team, firstconnect, var_67d0631ad9027f83, var_26c802633f90a05c) {
  if(isDefined(self.team)) {
    scripts\mp\playerlogic::removefromteamcount();

    if(isDefined(var_67d0631ad9027f83) && var_67d0631ad9027f83) {
      scripts\mp\playerlogic::decrementalivecount(self.team, undefined, "addToTeam");
    }

    scripts\cp_mp\squads::leavesquad(self.team, self.sessionsquadid);
  }

  if(isDefined(self.pers["team"]) && self.pers["team"] != "" && self.pers["team"] != "spectator" && self.pers["team"] != "codcaster") {
    self.pers["last_team"] = self.pers["team"];
  }

  self.changedteams = isDefined(self.pers["last_team"]) && self.pers["last_team"] != team;

  if(!level.teambased) {
    if(isbot(self) && team != "allies" && team != "axis") {
      self.pers["team"] = ter_op(cointoss(), "allies", "axis");
      self.team = "allies";
    } else {
      self.pers["team"] = team;
      self.team = team;
    }
  } else {
    self.pers["team"] = team;
    self.team = team;
  }

  isbotplayer = isbot(self) || istestclient(self);

  if(isbotplayer || function_d7ec918e29c0b2f4()) {
    setsessionteam(team);
  } else if(!denysystemicteamchoice()) {
    if(matchmakinggame() && !istrue(var_26c802633f90a05c)) {
      if(!allowteamassignment()) {
        if(scripts\cp_mp\utility\game_utility::isinfectedgametype()) {
          setsessionteam(team);
        }
      }
    } else if(!function_1eb7d2791d3c536f()) {
      setsessionteam(team);
    }
  } else if(getdvarint(@ "hash_c11db9baa9e5bc9b", 0) > 0) {
    if(!level.matchmakingmatch) {
      setsessionteam(team);
    }
  }

  if(game["state"] != "postgame") {
    scripts\mp\playerlogic::addtoteamcount(istrue(var_67d0631ad9027f83));
  }

  updateobjectivetext();

  if(isDefined(firstconnect) && firstconnect) {
    waittillframeend();
  }

  if(team == "spectator" || team == "codcaster") {
    self notify("joined_spectators");
    scripts\mp\teams::onjoinedspectators(self);
    scripts\mp\spectating::onjoinedspectators(self);
    scripts\mp\bounty::onplayerjoinedspectators(self);
    scripts\cp_mp\pet_watch::onjoinspectators();
  } else {
    self notify("joined_team");
  }

  scripts\mp\utility\join_team_aggregator::onplayerjointeam(self);
  level notify("add_to_team", self);
}

function setsessionteam(teamset) {
  if(level.teambased) {
    self.sessionteam = teamset;
    return;
  }

  setemptysessionteam(teamset);
}

function setemptysessionteam(teamset) {
  if(teamset == "spectator") {
    self.sessionteam = "spectator";
    return;
  }

  if(teamset == "codcaster") {
    self.sessionteam = "codcaster";
    return;
  }

  self.sessionteam = "none";
}

function endrespawnnotify() {
  self.waitingtospawn = 0;
  self notify("end_respawn");
}

function logteamselection(teamselection) {
  if(getdvarint(@ "hash_ff689af941dd10a1", 0) == 0) {
    return;
  }

  if(teamselection != "random") {
    iprintlnbold("" + self.name + " did not select auto-assign");
  }
}

function debugprintsquads() {
  stepy = 25;

  while(true) {
    if(isDefined(level.squaddata)) {
      startx = 800;
      starty = 25;
      linecount = 1;

      printtoscreen2d(startx + 250, starty, "<dev string:x1b4>", (1, 1, 1), 1);

      foreach(team, squadarray in level.squaddata) {
        linecount = 1;

        printtoscreen2d(startx, starty + stepy * linecount, "<dev string:x1c2>" + team, (1, 1, 1), 1);

        linecount++;

        foreach(squad in squadarray) {
          color = (1, 1, 1);

          if(isDefined(squad.activemission)) {
            color = (1, 1, 0);
          }

          printtoscreen2d(startx + 25, starty + stepy * linecount, "<dev string:x1cc>" + squad.index, color, 1);

          linecount++;

          foreach(player in squad.players) {
            color = (1, 1, 1);

            if(istrue(player.squadassignedfromlobby)) {
              color = (0, 1, 0);
            }

            printtoscreen2d(startx + 50, starty + stepy * linecount, player.name, color, 1);

            linecount++;
          }
        }

        startx += 200;
      }
    }

    waitframe();
  }
}