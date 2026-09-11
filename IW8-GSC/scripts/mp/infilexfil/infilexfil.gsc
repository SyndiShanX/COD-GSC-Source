/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\infilexfil.gsc
************************************************/

function infil_add(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("infil", "get_all_infils")) {
    scripts\cp_mp\utility\script_utility::registersharedfunc("infil", "get_all_infils", &get_all_infils);
  }

  while(!isDefined(level.teamnamelist)) {
    waitframe();
  }

  if(!isDefined(game["infil"])) {
    foreach(var_9 in level.teamnamelist) {
      game["infil"][var_9] = [];
    }

    game["infil"]["types"] = [];
  }

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    var_11 = get_all_infils(var_0);

    foreach(var_13 in var_11) {
      if(var_13.name == var_1) {
        if(isDefined(var_13.script_label) && var_13.script_label == level.localeid) {
          break;
        }
      }
    }
  }

  if(isDefined(game["infil"]["types"][var_0]) && isDefined(game["infil"]["types"][var_0][var_1])) {
    if(isDefined(game["infil"]["types"][var_0][var_1]["persistentVehicle"])) {
      self[[game["infil"]["types"][var_0][var_1]["persistentVehicle"]]](var_0, var_1);
    }

    return;
  }

  game["infil"]["types"][var_0][var_1] = [];
  game["infil"]["types"][var_0][var_1]["spawn_func"] = var_5;
  game["infil"]["types"][var_0][var_1]["player_func"] = var_7;
  game["infil"]["types"][var_0][var_1]["get_length_func"] = var_6;
  game["infil"]["types"][var_0][var_1]["seats"] = var_2;
  game["infil"]["types"][var_0][var_1]["required_seats"] = var_3;
  game["infil"]["types"][var_0][var_1]["fill_order"] = var_4;
}

function infil_is_interactive() {
  if(!isDefined(level.interactiveinfil)) {
    level.interactiveinfil = getdvarint("scr_infil_interactive", 0) == 1;
  }

  return level.interactiveinfil;
}

function infil_init() {
  if(level.rankedmatch && !isdedicatedserver()) {
    game["infil"] = undefined;
    scripts\mp\flags::gameflagset("infil_setup_complete");
    return;
  }

  if(game["roundsPlayed"] > 0 || getdvarint("scr_skip_infils", 0) == 1 || getdvarint("scr_game_infilSkip", 0) == 1 || scripts\mp\utility\game::getgametype() == "br" || getdvarint("scr_game_matchstarttime") < 15 || scripts\mp\utility\game::getgametype() == "war" && scripts\cp_mp\utility\game_utility::unlink_on_ai_death()) {
    game["infil"] = undefined;
    level.requiredplayercount["allies"] = 0;
    level.requiredplayercount["axis"] = 0;
    scripts\mp\flags::gameflagset("infil_setup_complete");
    return;
  }

  if(!isDefined(level.prematchperiodend) || level.prematchperiodend == 0) {
    game["infil"] = undefined;
    scripts\mp\flags::gameflagset("infil_setup_complete");
    return;
  }

  if(istrue(level.ref_133d5)) {
    game["infil"] = undefined;
    scripts\mp\flags::gameflagset("infil_setup_complete");
    return;
  }

  while(!isDefined(level.teamnamelist)) {
    waitframe();
  }

  if(scripts\mp\gamelogic::ref_1330a()) {
    logstring("IWH-315293: ALBACORE: level.teamNameList while finished");
  }

  waitframe();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(&onplayerdisconnect);
  level.prematchallowfunc = &infil_player_allow;
  var_0 = undefined;
  level.stop_station_closed_vo = 0;

  foreach(var_2 in get_all_infils()) {
    var_3 = var_2.script_noteworthy;
    var_4 = var_2.name;

    if(!infil_is_gamemode(var_2)) {
      continue;
    }

    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      if(var_2.name == var_4) {
        if(!isDefined(var_2.script_label) || var_2.script_label != level.localeid) {
          continue;
        }
      }
    }

    if(infil_has_map_config(var_2)) {
      infil_init_spawn_selection();
    }

    var_5 = var_2.script_team;

    if(infil_is_type(var_2, var_3) && infil_is_subtype(var_2, var_4) && scripts\mp\utility\teams::isgameplayteam(var_2.script_team)) {
      level.stop_station_closed_vo++;
      var_6 = game["infil"]["types"][var_3][var_4];
      var_7 = var_4;
      var_8 = var_4;

      if(issubstr(var_8, "alpha")) {
        var_8 = "alpha";
      }

      if(issubstr(var_8, "bravo")) {
        var_8 = "bravo";
      }

      if(!isDefined(var_6)) {
        var_6 = game["infil"]["types"][var_3][var_8];
      }

      var_9 = var_2[[var_6["spawn_func"]]](var_2.script_team, var_2.target, var_8, var_7);
      var_9.players = [];
      var_9.type = var_3;
      var_9.ref_1214c = var_7;
      var_9.subtype = var_8;
      var_9.infillength = var_9[[var_6["get_length_func"]]](var_8);

      if(!isDefined(var_0) || var_0 < var_9.infillength) {
        var_0 = var_9.infillength + 1;
      }

      var_5 = var_2.script_team;
      game["infil"][var_5]["lanes"][var_3][var_4] = var_9;
      register_infil_spots(var_5, var_9, var_6["seats"], var_6["required_seats"], var_6["fill_order"], var_6["player_func"]);

      if(infil_has_map_config(var_2)) {
        scripts\mp\tac_ops_map::adddynamicspawnarea("to_infil", var_9, var_5, var_2.script_label);
      }
    }
  }

  if(scripts\mp\utility\game::gamehasinfil() && isDefined(var_0)) {
    thread onplayerspawned();
    level.prematchperiod = getdvarint("scr_game_graceperiod", 15);
    level.matchcountdowntime = var_0 + 2;
    level.prematchperiodend = var_0 + 2;
    thread scripts\mp\gamelogic::matchstarttimer("match_starting_in", level.prematchperiod + level.prematchperiodend);
    thread infil_setup_ui();
    thread infil_wait_for_players();
    thread ref_14367();
    scripts\mp\flags::gameflagset("infil_will_run");
  }

  scripts\mp\flags::gameflagset("infil_setup_complete");
}

function onplayerspawned() {
  level endon("infil_started");

  for(;;) {
    level waittill("player_spawned", var_0);
    thread ref_1437e();
  }
}

function ref_1437e() {
  level endon("infil_started");
  self endon("death_or_disconnect");

  if(isDefined(self.team)) {
    scripts\mp\flags::gameflagwait("infil_setup_complete");

    if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("prematch_done")) {
      var_0 = (0, 0, 0);
      var_1 = 0;

      if(isDefined(game["infil"]) && isDefined(game["infil"][self.team]) && isDefined(game["infil"][self.team]["lanes"])) {
        foreach(var_3 in game["infil"][self.team]["lanes"]) {
          foreach(var_5 in var_3) {
            var_0 += var_5.origin;
            var_1++;
          }
        }
      }

      if(var_1 > 0) {
        var_0 /= var_1;
      }

      self predictstreampos(var_0);
    }
  }

  while(!istrue(self.pers["streamSyncComplete"])) {
    waitframe();
  }

  var_8 = get_spot_from_player(self, scripts\mp\utility\game::getotherteam(self.team)[0]);

  if(isDefined(var_8)) {
    player_free_spot(self, scripts\mp\utility\game::getotherteam(self.team)[0]);
  }

  player_join_infil();
}

function onjoinedteam(var_0) {
  if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("infil_started")) {
    if(isDefined(var_0.team) && var_0.team == "spectator") {
      thread infilspectatorview();
      return;
    }

    return;
  }
}

function infilspectatorview() {
  self endon("joined_team");
  self endon("disconnect");
  self notify("infilSpectatorView");
  self endon("infilSpectatorView");
  thread infil_scene_fade_in(0, 0.55);
}

function onplayerdisconnect(var_0) {
  if(!isDefined(var_0.infil)) {
    return;
  }

  if(scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  player_free_spot(var_0, var_0.team);
}

function onplayerchangeteams() {
  level endon("prematch_over");
  self endon("player_free_spot");
  var_0 = self.team;
  scripts\engine\utility::ref_143a5("joined_team", "joined_spectators");
  player_free_spot(self, var_0);
}

function get_all_infils(var_0) {
  if(isDefined(var_0)) {
    return scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  }

  return scripts\engine\utility::getStructArray("mp_infil", "targetname");
}

function infil_is_type(var_0) {
  return self.script_noteworthy == var_0;
}

function infil_is_subtype(var_0) {
  return self.name == var_0;
}

function infil_is_gamemode() {
  if(!isDefined(self.spawnflags) || self.spawnflags == 0) {
    return false;
  }

  if(!level.teambased) {
    return false;
  }

  if(self.spawnflags & 1) {
    if(level.gametype == "sd" && level.mapname == "mp_petrograd" || level.gametype == "sd" && level.mapname == "mp_piccadilly" || level.gametype == "dd" && level.mapname == "mp_crash2") {
      return false;
    } else {
      return true;
    }
  }

  if(self.spawnflags & 2) {
    switch (level.gametype) {
      case "grind":
      case "war":
      case "tjugg":
      case "pill":
      case "conf":
        return true;
    }
  }

  if(self.spawnflags & 4) {
    switch (level.gametype) {
      case "dd":
      case "sr":
      case "sd":
        if(level.mapname == "mp_petrograd" || level.mapname == "mp_piccadilly") {
          return false;
        } else {
          return true;
        }

        break;
    }
  }

  if(self.spawnflags & 8) {
    switch (level.gametype) {
      case "siege":
      case "dom":
        return true;
    }
  }

  if(self.spawnflags & 16) {
    switch (level.gametype) {
      case "grnd":
      case "koth":
      case "hq":
        return true;
    }
  }

  if(self.spawnflags & 32) {
    switch (level.gametype) {
      case "ctf":
        return true;
    }
  }

  if(self.spawnflags & 64) {
    switch (level.gametype) {
      case "cyber":
        return true;
    }
  }

  if(self.spawnflags & 128) {
    switch (level.gametype) {
      case "cmd":
      case "arm":
        return true;
    }
  }

  return false;
}

function infil_has_map_config() {
  return isDefined(self.script_label) && level.gametype == "tac_ops";
}

function infil_init_spawn_selection() {
  if(level.gametype == "tac_ops" && !isDefined(game["infil"]["map_config"])) {
    scripts\mp\tac_ops_map::init();
    scripts\mp\tac_ops_map::setactivemapconfig("to_infil", "allies");
    scripts\mp\tac_ops_map::setactivemapconfig("to_infil", "axis");
    game["infil"]["map_config"] = 1;
    return;
  }
}

function infil_player_allow(var_0, var_1) {
  if(self ishost() && getdvarint("scr_infil_spectator") == 1) {
    scripts\common\utility::allow_weapon(var_0);
    return;
  }

  if(!scripts\mp\utility\game::teamhasinfil(self.team) && !istrue(var_1)) {
    scripts\mp\playerlogic::playerprematchallow(var_0);
    return;
  }

  self allowmovement(var_0);
  scripts\common\utility::allow_prone(var_0);
  scripts\common\utility::allow_crouch(var_0);
  scripts\common\utility::allow_jump(var_0);
  scripts\common\utility::allow_fire(var_0);
  scripts\common\utility::allow_ads(var_0);
  scripts\common\utility::allow_sprint(var_0);
  scripts\common\utility::allow_melee(var_0);
  scripts\common\utility::allow_lean(var_0);
  scripts\common\utility::allow_slide(var_0);
  scripts\common\utility::allow_offhand_weapons(var_0);
  scripts\common\utility::allow_weapon_switch(var_0);
  scripts\common\utility::allow_usability(var_0);
}

function register_infil_spots(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(game["infil"][var_0]["spots"])) {
    game["infil"][var_0]["spots"] = [];
  }

  var_6 = game["infil"][var_0]["spots"].size;

  for(var_7 = 0; var_7 < var_2; var_7++) {
    var_8 = game["infil"][var_0]["spots"].size;

    if(isDefined(var_4)) {
      var_9 = 0;

      foreach(var_11 in var_4) {
        foreach(var_13 in var_11) {
          if(var_13 == var_8 - var_6) {
            game["infil"][var_0]["spots"][var_8]["priority"] = var_15;
            var_9 = 1;
            break;
          }
        }

        if(var_9) {
          break;
        }
      }
    } else {
      game["infil"][var_0]["spots"][var_8]["priority"] = -1;
    }

    game["infil"][var_0]["spots"][var_8]["seat"] = var_7;
    game["infil"][var_0]["spots"][var_8]["infil"] = var_1;
    game["infil"][var_0]["spots"][var_8]["callback"] = var_5;
  }

  if(!istrue(level.ref_12c49)) {
    level.requiredplayercount[var_0] += var_3;
    return;
  }
}

function player_on_spot(var_0, var_1) {
  if(isDefined(game["infil"][var_0.team]["spots"])) {}

  if(isDefined(game["infil"][var_0.team]["spots"][var_1])) {}

  if(isDefined(game["infil"][var_0.team]["spots"][var_1]["player"])) {}

  game["infil"][var_0.team]["spots"][var_1]["player"] = var_0;
  return game["infil"][var_0.team]["spots"][var_1];
}

function player_free_spot(var_0, var_1) {
  var_0 setclientomnvar("ui_player_in_infil", 0);

  if(!isDefined(var_1)) {
    var_1 = var_0.team;
  }

  if(isDefined(game["infil"][var_1]["spots"])) {}

  foreach(var_3 in game["infil"][var_1]["spots"]) {
    if(is_spot_taken(var_1, var_4) && var_3["player"] == var_0) {
      game["infil"][var_1]["spots"][var_4]["player"] = undefined;
      var_0 notify("player_free_spot");
      return;
    }
  }
}

function get_player_at_spot(var_0, var_1) {
  return game["infil"][var_0]["spots"][var_1]["player"];
}

function get_spot_from_player(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0.team;
  }

  if(!isDefined(game["infil"][var_1]["spots"])) {
    return undefined;
  }

  foreach(var_3 in game["infil"][var_1]["spots"]) {
    if(isDefined(var_3["player"]) && var_3["player"] == var_0) {
      return var_4;
    }
  }

  return undefined;
}

function is_spot_taken(var_0, var_1) {
  if(isDefined(game["infil"][var_0]["spots"])) {}

  if(isDefined(game["infil"][var_0]["spots"][var_1])) {}

  return isDefined(game["infil"][var_0]["spots"][var_1]["player"]);
}

function get_spot_taken_count(var_0) {
  if(isDefined(game["infil"][var_0]["spots"])) {}

  var_1 = 0;

  foreach(var_3 in game["infil"][var_0]["spots"]) {
    if(is_spot_taken(var_0, var_4)) {
      var_1++;
    }
  }

  return var_1;
}

function get_spot_by_priority(var_0) {
  var_1 = [];

  foreach(var_3 in game["infil"][var_0]["spots"]) {
    if(!is_spot_taken(var_0, var_4)) {
      var_1 = var_4;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_5 = getdvarint("scr_infil_force_seat", -1);

  if(scripts\engine\utility::array_contains(var_1, var_5)) {
    return var_5;
  }

  var_6 = [];
  var_7 = -1;

  foreach(var_3 in var_1) {
    var_9 = game["infil"][var_0]["spots"][var_3]["priority"];

    if(var_6.size == 0 || var_9 < var_7) {
      var_6 = [];
      var_6 = var_3;
      var_7 = var_9;
      continue;
    }

    if(var_9 == var_7) {
      var_6 = var_3;
    }
  }

  return var_6[randomint(var_6.size)];
}

function get_spot_in_lane(var_0) {
  while(!isDefined(self.forcedavailablespawnlocation)) {
    waitframe();
  }

  var_1 = scripts\engine\utility::ter_op(var_0 == "allies", "a", "b") + getsubstr(self.forcedavailablespawnlocation, 5, 6);
  var_2 = [];

  foreach(var_4 in game["infil"][var_0]["spots"]) {
    if(issubstr(var_4["infil"].lane, var_1) && !is_spot_taken(var_0, var_5)) {
      var_2 = var_5;
    }
  }

  if(var_2.size == 0) {
    return undefined;
  }

  var_6 = [];
  var_7 = -1;

  foreach(var_4 in var_2) {
    var_9 = game["infil"][var_0]["spots"][var_4]["priority"];

    if(var_6.size == 0 || var_9 < var_7) {
      var_6 = [];
      var_6 = var_4;
      var_7 = var_9;
      continue;
    }

    if(var_9 == var_7) {
      var_6 = var_4;
    }
  }

  return var_6[randomint(var_6.size)];
}

function get_random_spot(var_0) {
  var_1 = [];

  foreach(var_3 in game["infil"][var_0]["spots"]) {
    if(!is_spot_taken(var_0, var_4)) {
      var_1 = var_4;
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_3 = scripts\engine\utility::random(var_1);
  return var_3;
}

function get_taken_spot_count(var_0) {
  if(!isDefined(game["infil"][var_0]["spots"])) {
    return 0;
  }

  var_1 = 0;

  foreach(var_3 in game["infil"][var_0]["spots"]) {
    if(is_spot_taken(var_0, var_4)) {
      var_1++;
    }
  }

  return var_1;
}

function get_taken_spot_percent(var_0) {
  if(!isDefined(game["infil"][var_0]["spots"])) {
    return 0;
  }

  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in game["infil"][var_0]["spots"]) {
    var_1++;

    if(is_spot_taken(var_0, var_5)) {
      var_2++;
    }
  }

  return var_2 / var_1;
}

function get_random_spot_in_infil(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in game["infil"][var_0]["spots"]) {
    if(var_5["infil"] != var_1) {
      continue;
    }

    if(!is_spot_taken(var_0, var_5)) {
      var_2 = var_5;
    }
  }

  if(var_2.size == 0) {
    return undefined;
  }

  var_4 = scripts\engine\utility::random(var_2);
  return var_4;
}

function infil_player_array_handler(var_0) {
  self endon("death");
  self.players = scripts\engine\utility::array_add(self.players, var_0);
  var_0 waittill("death_or_disconnect");
  self.players = scripts\engine\utility::array_remove(self.players, var_0);
}

function player_join_infil() {
  if(scripts\mp\flags::gameflag("infil_started")) {
    return;
  }

  if(game["infil"][self.team].size == 0) {
    return;
  }

  if(self ishost() && getdvarint("scr_infil_spectator") == 1) {
    player_ai_fill();
    return;
  }

  var_0 = 0;
  var_1 = game["infil"][self.team]["spots"][0]["priority"] != -1;

  if(level.gametype == "tac_ops" && isDefined(self.tacopsmapselectedarea.dynamicent)) {
    var_2 = get_random_spot_in_infil(self.team, self.tacopsmapselectedarea.dynamicent);
  } else if(var_1) {
    var_2 = get_spot_taken_count(self.team);
  } else if(var_2) {
    var_2 = get_spot_by_priority(self.team);
  } else {
    var_2 = get_random_spot(self.team);
  }

  if(!isDefined(var_2)) {
    return;
  }

  var_3 = player_on_spot(self, var_2);
  thread infil_player_array_handler(var_3["infil"]);
  self notify("player_added_to_infil");
  self.infil = var_3["infil"];
  self thread[[var_3["callback"]]](var_3["infil"], var_3["seat"]);
  self setclientomnvar("ui_player_in_infil", 1);
  thread onplayerchangeteams();
  thread headlessopindex();
  player_ai_fill();
}

function headlessopindex() {
  self endon("disconnect");
  level waittill("prematch_done");
  self setcinematicmotionoverride("iw8_playermotion_mp");
  self endon("death");
  var_0 = 0;

  while(!var_0) {
    var_0 = self setdemeanorviewmodel("normal");
    waitframe();
  }
}

function blockswaploadouts() {
  self endon("disconnect");
  self.delayswaploadout = 1;
  level waittill("prematch_over");
  self.delayswaploadout = 0;
}

function player_ai_fill() {}

function infil_setup_ui() {
  setomnvar("ui_in_infil", 3);
  level waittill("infil_started");
  var_0 = getomnvar("ui_always_show_nameplates");
  setomnvar("ui_always_show_nameplates", 1);

  if(!isDefined(level.bypassclasschoicefunc)) {
    setomnvarforallclients("ui_skip_loadout", 0);
    level.bypassclasschoicefunc = undefined;
  }

  thread infil_show_countdown();
  var_1 = getdvarint("LOPKSRNTTS");
  var_2 = getdvarint("LROTSRRQMQ");
  var_3 = getdvarint("NKMOPQSPMO");
  setDvar("LOPKSRNTTS", 0);
  setDvar("LROTSRRQMQ", 1);
  setDvar("NKMOPQSPMO", 1);
  level waittill("prematch_done");
  var_4 = scripts\mp\utility\player::alwaysshowminimap();

  foreach(var_6 in level.players) {
    if(var_4) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
        var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
      }

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap")) {
      var_6[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
    }
  }

  setomnvar("ui_in_infil", -1);
  setomnvar("ui_always_show_nameplates", var_0);
  setDvar("LOPKSRNTTS", var_1);
  setDvar("LROTSRRQMQ", var_2);
  setDvar("NKMOPQSPMO", var_3);
}

function infil_show_countdown() {
  wait level.prematchperiodend - 5;
  setomnvar("ui_in_infil", 2);
}

function alwaysgamemodeclass() {
  var_0 = self getclantag();

  if(var_0 == "AR") {
    var_1 = "default1";
  } else if(var_1 == "SMG") {
    var_1 = "default2";
  } else {
    jumpiffalse(var_1 == "LMG") LOC_00000049;
    var_1 = "default3";
    goto LOC_00000072;
  }

  LOC_00000072:
    self.pers["class"] = var_2;
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  return var_2;
}

#using_animtree("script_model");

function infil_player_rig(var_0, var_1, var_2) {
  self.animname = var_0;
  var_3 = spawn("script_model", (0, 0, 0));
  var_3.player = self;
  self.player_rig = var_3;
  self.player_rig setModel(var_1);
  self.player_rig hide();
  self.player_rig.animname = var_0;
  self.player_rig useanimtree(#animtree);
  self.player_rig.weapon_state_func = &scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  self.player_rig.cinematic_motion_override = &scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
  self.player_rig.dof_func = &scripts\mp\utility\infilexfil::handledofnotetrack;
  self playerlinktodelta(self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);

  if(isDefined(var_2) && var_2) {
    self playersetgroundreferenceent(self.player_rig);
  }

  self notify("rig_created");
  scripts\engine\utility::ref_143a5("remove_rig", "player_free_spot");

  if(isDefined(self)) {
    if(isDefined(var_2) && var_2) {
      self playersetgroundreferenceent(undefined);
    }

    self unlink();
  }

  if(isDefined(var_3)) {
    var_3 delete();
    return;
  }
}

function infil_play_sound_func(var_0, var_1, var_2) {
  foreach(var_4 in self.players) {
    var_4 playsoundtoplayer(var_0, var_4);
  }
}

function infil_wait_for_players() {
  level endon("game_ended");
  level endon("force_end");
  level waittill("match_start_real_countdown");
  setomnvar("ui_in_infil", 1);
  wait 2;
  scripts\mp\flags::gameflagset("infil_started");

  if(getdvarint("scr_infil_interactive_slowmo", 0) == 1) {
    thread manageinteractiveslowmo();
  }

  if(getdvarint("scr_infil_print_start", 0) == 1) {
    foreach(var_1 in level.players) {
      iprintlnbold("!-!-!-!-!-INFIL BEGIN-!-!-!-!-!");
    }

    return;
  }
}

function infil_scene_fade_in(var_0, var_1) {
  if(scripts\mp\flags::gameflag("infil_started")) {
    return;
  }

  self notify("infil_scene_fade_in");
  self endon("infil_scene_fade_in");
  self setclientomnvar("ui_world_fade", 1);
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("infil_started");
  var_2 = gettime();
  var_3 = 1;

  while(var_3 > 0) {
    var_3 -= level.framedurationseconds;
    var_3 = max(var_3, 0);
    self setclientomnvar("ui_world_fade", var_3);
    waitframe();
  }
}

function heli_path(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_0 endon("death");

  if(isDefined(var_0.hasstarted)) {
    return;
  } else {
    var_0.hasstarted = 1;
  }

  var_0 scripts\engine\utility::script_delay();
  var_0 notify("start_vehiclepath");
  var_0 notify("start_dynamicpath");
}

function vehicle_paths_helicopter(var_0, var_1, var_2) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_0)) {
    self.attachedpath = var_0;
  }

  var_3 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(var_3)) {
    return;
  }

  var_4 = var_3;

  if(var_1) {
    self waittill("start_dynamicpath");
  }

  if(isDefined(var_2)) {
    var_5 = spawnStruct();
    var_5.origin = (self.origin[0], self.origin[1], self.origin[2] + var_2);
    heli_wait_node(var_5, undefined);
  }

  var_6 = undefined;
  var_7 = var_3;
  var_8 = get_path_getfunc(var_3);

  while(isDefined(var_7)) {
    if(isDefined(var_7.script_parameters)) {
      readnodeevents(var_7);
    }

    if(isDefined(var_7.script_linkto)) {
      set_lookat_from_dest(var_7);
    }

    heli_wait_node(var_7, var_6, var_2);

    if(!isDefined(self)) {
      return;
    }

    self.currentnode = var_7;
    var_7 notify("trigger", self);

    if(isDefined(var_7.script_helimove)) {
      self setyawspeedbyname(var_7.script_helimove);

      if(var_7.script_helimove == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_7.script_team)) {
      self.script_team = var_7.script_team;
    }

    if(isDefined(var_7.script_unload)) {
      self notify("unload");
      scripts\engine\utility::waittill_notify_or_timeout("unloaded", self.unload_time);
    }

    if(self vehicle_isphysveh()) {
      if(isDefined(var_7.script_pathtype)) {
        self.veh_pathtype = var_7.script_pathtype;
      }
    }

    if(isDefined(var_7.script_flag_wait)) {
      scripts\engine\utility::flag_wait(var_7.script_flag_wait);

      if(isDefined(var_7.script_delay_post)) {
        wait var_7.script_delay_post;
      }

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    var_6 = var_7;

    if(!isDefined(var_7.target)) {
      break;
    }

    var_7 = [[var_8]](var_7.target);

    if(!isDefined(var_7)) {
      var_7 = var_6;
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    self delete();
    return;
  }
}

function heli_wait_node(var_0, var_1, var_2) {
  self endon("newpath");

  if(isDefined(var_0.script_unload) || isDefined(var_0.script_land)) {
    var_3 = 0;

    if(isDefined(var_0.script_land)) {
      scripts\engine\utility::ent_flag_set("landed");

      if(isDefined(self.unload_land_offset)) {
        var_3 = self.unload_land_offset;
      }
    } else if(isDefined(var_0.script_unload) && isDefined(self.unload_hover_offset)) {
      var_3 = self.unload_hover_offset;
    } else if(isDefined(var_0.script_unload) && isDefined(self.unload_hover_offset_max)) {
      var_4 = scripts\common\utility::groundpos(var_0.origin);
      var_3 = var_0.origin[2] - var_4[2];

      if(var_3 >= self.unload_hover_offset_max) {
        var_3 = self.unload_hover_offset_max;
      } else if(isDefined(self.unload_hover_land_height) && var_3 < self.unload_hover_land_height) {
        var_3 = self.unload_hover_land_height;
      }
    }

    var_0.radius = 2;

    if(isDefined(var_0.ground_pos)) {
      var_0.origin = var_0.ground_pos + (0, 0, var_3);
    } else {
      var_5 = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);

      if(var_5[2] > var_0.origin[2] - 2000) {
        var_0.origin = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var_1)) {
    var_6 = var_1.script_airresistance;
    var_7 = var_1.speed;
    var_8 = var_1.script_accel;
    var_9 = var_1.script_decel;
  } else {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
  }

  var_10 = isDefined(var_7.script_stopnode) && var_7.script_stopnode;
  var_11 = isDefined(var_7.script_unload);
  var_12 = isDefined(var_7.script_flag_wait) && !scripts\engine\utility::flag(var_7.script_flag_wait);
  var_13 = !isDefined(var_7.target);
  var_14 = isDefined(var_7.script_delay);

  if(isDefined(var_7.angles)) {
    var_15 = var_7.angles[1];
  } else {
    var_15 = 0;
  }

  if(self.health <= 0) {
    return;
  }

  var_16 = var_8.origin;

  if(isDefined(var_6)) {
    var_16 = (var_16[0], var_16[1], var_16[2] + var_6);
  }

  if(isDefined(self.heliheightoverride)) {
    var_16 = (var_16[0], var_16[1], self.heliheightoverride);
  }

  self vehicle_helisetai(var_16, var_8, var_9, var_10, var_8.script_goalyaw, var_8.script_anglevehicle, var_15, var_7, var_15, var_11, var_12, var_13, var_14);

  if(isDefined(var_8.radius)) {
    self setneargoalnotifydist(var_8.radius);
    scripts\engine\utility::ref_143a5("near_goal", "goal");
  } else {
    self waittill("goal");
  }

  if(isDefined(var_8.script_firelink)) {
    if(isDefined(level.helicopter_firelinkfunk)) {}

    GscBinSkip1(0x74, level.helicopter_firelinkfunk, var_8);
  }

  var_8 scripts\engine\utility::script_delay();

  if(isDefined(self.path_gobbler)) {
    scripts\engine\utility::deletestruct_ref(var_8);
  }

  self notify("continuepath");
}

function get_path_getfunc(var_0) {
  var_1 = &get_from_vehicle_node;

  if(isDefined(var_0.target)) {
    if(isDefined(get_from_entity(var_0.target))) {
      var_1 = &get_from_entity;
    }

    if(isDefined(get_from_spawnStruct(var_0.target))) {
      var_1 = &get_from_spawnstruct;
    }
  }

  return var_1;
}

function get_from_vehicle_node(var_0) {
  return getvehiclenode(var_0, "targetname");
}

function get_from_spawnStruct(var_0) {
  return scripts\engine\utility::getStruct(var_0, "targetname");
}

function get_from_entity(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(isDefined(var_1) && var_1.size > 0) {
    return var_1[randomint(var_1.size)];
  }

  return undefined;
}

function set_lookat_from_dest(var_0) {
  var_1 = getEnt(var_0.script_linkto, "script_linkname");

  if(!isDefined(var_1)) {
    return;
  }

  self setlookatent(var_1);
  self.set_lookat_point = 1;
}

function parsehelipathlength() {
  if(!isDefined(self.path)) {
    return 0;
  }

  if(isDefined(self.pathduration)) {
    return self.pathduration;
  }

  self.pathduration = 0;
  var_0 = self.path;
  var_1 = var_0.speed;

  for(;;) {
    if(isDefined(var_0.script_unload)) {
      break;
    }

    if(!isDefined(var_0.target)) {
      break;
    }

    var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");

    if(!isDefined(var_2)) {
      break;
    }

    var_3 = distance(var_0.origin, var_2.origin);

    if(isDefined(var_0.speed)) {
      var_1 = var_0.speed;
    }

    var_4 = 17.6;
    var_5 = 1.1;
    self.pathduration += var_3 * var_5 / var_1 * var_4;
    var_0 = var_2;
  }

  return self.pathduration;
}

function readnodeevents(var_0) {
  var_1 = strtok(var_0.script_parameters, ",");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, ":");

    if(!isDefined(var_4)) {
      return;
    }

    if(var_4.size != 2) {
      return;
    }

    thread processtimelineevent(var_4[0], float(var_4[1]));
  }
}

function processtimelineevent(var_0, var_1) {
  if(!isDefined(self.timelineevents)) {
    self.timelineevents = [];
  }

  if(var_1 > 0) {
    wait var_1;
  }

  switch (var_0) {
    case "shake_low":
      self.timelineevents["shake"] = "low";

      foreach(var_3 in self.infil.players) {
        scripts\mp\utility\infilexfil::cam_shake_low(var_3);
      }

      break;
    case "shake_off":
      self.timelineevents["shake"] = "off";

      foreach(var_3 in self.infil.players) {
        scripts\mp\utility\infilexfil::cam_shake_off(var_3);
      }

      break;
    case "event_intro":
      self.infil notify("event_intro");
      break;
    case "event_shootingWindow_open":
      self.infil notify("event_shootingWindow_open");
      break;
    case "event_shootingWindow_closed":
      self.infil notify("event_shootingWindow_closed");
      break;
  }
}

function manageinteractiveslowmo() {
  if(!isDefined(level.interactiveinfilstart) || !isDefined(level.interactiveinfilwindow)) {
    return;
  }

  wait level.interactiveinfilstart;
  setslowmotion(1, 0.5, 1);
  wait level.interactiveinfilwindow;
  setslowmotion(0.5, 1, 0.5);
}

function ref_14367() {
  scripts\mp\flags::gameflagwait("prematch_done");

  while(level.stop_station_closed_vo != 0) {
    waitframe();
  }

  setspeedthreshold();
}