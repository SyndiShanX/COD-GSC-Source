/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\infilexfil.gsc
************************************************/

function infil_add(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("infil", "get_all_infils")) {
    scripts\cp_mp\utility\script_utility::registersharedfunc("infil", "get_all_infils", &get_all_infils);
  }

  while(!isDefined(level.teamnamelist)) {
    waitframe();
  }

  if(!isDefined(game["infil"])) {
    foreach(var9 in level.teamnamelist) {
      game["infil"][var9] = [];
    }

    game["infil"]["types"] = [];
  }

  if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
    var11 = get_all_infils(var0);

    foreach(var13 in var11) {
      if(var13.name == var1) {
        if(isDefined(var13.script_label) && var13.script_label == level.localeid) {
          break;
        }
      }
    }
  }

  if(isDefined(game["infil"]["types"][var0]) && isDefined(game["infil"]["types"][var0][var1])) {
    if(isDefined(game["infil"]["types"][var0][var1]["persistentVehicle"])) {
      self[[game["infil"]["types"][var0][var1]["persistentVehicle"]]](var0, var1);
    }

    return;
  }

  game["infil"]["types"][var0][var1] = [];
  game["infil"]["types"][var0][var1]["spawn_func"] = var5;
  game["infil"]["types"][var0][var1]["player_func"] = var7;
  game["infil"]["types"][var0][var1]["get_length_func"] = var6;
  game["infil"]["types"][var0][var1]["seats"] = var2;
  game["infil"]["types"][var0][var1]["required_seats"] = var3;
  game["infil"]["types"][var0][var1]["fill_order"] = var4;
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
  var0 = undefined;
  level.stop_station_closed_vo = 0;

  foreach(var2 in get_all_infils()) {
    var3 = var2.script_noteworthy;
    var4 = var2.name;

    if(!infil_is_gamemode(var2)) {
      continue;
    }

    if(isDefined(scripts\cp_mp\utility\game_utility::getlocaleid())) {
      if(var2.name == var4) {
        if(!isDefined(var2.script_label) || var2.script_label != level.localeid) {
          continue;
        }
      }
    }

    if(infil_has_map_config(var2)) {
      infil_init_spawn_selection();
    }

    var5 = var2.script_team;

    if(infil_is_type(var2, var3) && infil_is_subtype(var2, var4) && scripts\mp\utility\teams::isgameplayteam(var2.script_team)) {
      level.stop_station_closed_vo++;
      var6 = game["infil"]["types"][var3][var4];
      var7 = var4;
      var8 = var4;

      if(issubstr(var8, "alpha")) {
        var8 = "alpha";
      }

      if(issubstr(var8, "bravo")) {
        var8 = "bravo";
      }

      if(!isDefined(var6)) {
        var6 = game["infil"]["types"][var3][var8];
      }

      var9 = var2[[var6["spawn_func"]]](var2.script_team, var2.target, var8, var7);
      var9.players = [];
      var9.type = var3;
      var9.ref_1214c = var7;
      var9.subtype = var8;
      var9.infillength = var9[[var6["get_length_func"]]](var8);

      if(!isDefined(var0) || var0 < var9.infillength) {
        var0 = var9.infillength + 1;
      }

      var5 = var2.script_team;
      game["infil"][var5]["lanes"][var3][var4] = var9;
      register_infil_spots(var5, var9, var6["seats"], var6["required_seats"], var6["fill_order"], var6["player_func"]);

      if(infil_has_map_config(var2)) {
        scripts\mp\tac_ops_map::adddynamicspawnarea("to_infil", var9, var5, var2.script_label);
      }
    }
  }

  if(scripts\mp\utility\game::gamehasinfil() && isDefined(var0)) {
    thread onplayerspawned();
    level.prematchperiod = getdvarint("scr_game_graceperiod", 15);
    level.matchcountdowntime = var0 + 2;
    level.prematchperiodend = var0 + 2;
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
    level waittill("player_spawned", var0);
    thread ref_1437e();
  }
}

function ref_1437e() {
  level endon("infil_started");
  self endon("death_or_disconnect");

  if(isDefined(self.team)) {
    scripts\mp\flags::gameflagwait("infil_setup_complete");

    if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("prematch_done")) {
      var0 = (0, 0, 0);
      var1 = 0;

      if(isDefined(game["infil"]) && isDefined(game["infil"][self.team]) && isDefined(game["infil"][self.team]["lanes"])) {
        foreach(var3 in game["infil"][self.team]["lanes"]) {
          foreach(var5 in var3) {
            var0 += var5.origin;
            var1++;
          }
        }
      }

      if(var1 > 0) {
        var0 /= var1;
      }

      self predictstreampos(var0);
    }
  }

  while(!istrue(self.pers["streamSyncComplete"])) {
    waitframe();
  }

  var8 = get_spot_from_player(self, scripts\mp\utility\game::getotherteam(self.team)[0]);

  if(isDefined(var8)) {
    player_free_spot(self, scripts\mp\utility\game::getotherteam(self.team)[0]);
  }

  player_join_infil();
}

function onjoinedteam(var0) {
  if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("infil_started")) {
    if(isDefined(var0.team) && var0.team == "spectator") {
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

function onplayerdisconnect(var0) {
  if(!isDefined(var0.infil)) {
    return;
  }

  if(scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  player_free_spot(var0, var0.team);
}

function onplayerchangeteams() {
  level endon("prematch_over");
  self endon("player_free_spot");
  var0 = self.team;
  scripts\engine\utility::ref_143a5("joined_team", "joined_spectators");
  player_free_spot(self, var0);
}

function get_all_infils(var0) {
  if(isDefined(var0)) {
    return scripts\engine\utility::getStructArray(var0, "script_noteworthy");
  }

  return scripts\engine\utility::getStructArray("mp_infil", "targetname");
}

function infil_is_type(var0) {
  return self.script_noteworthy == var0;
}

function infil_is_subtype(var0) {
  return self.name == var0;
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

function infil_player_allow(var0, var1) {
  if(self ishost() && getdvarint("scr_infil_spectator") == 1) {
    scripts\common\utility::allow_weapon(var0);
    return;
  }

  if(!scripts\mp\utility\game::teamhasinfil(self.team) && !istrue(var1)) {
    scripts\mp\playerlogic::playerprematchallow(var0);
    return;
  }

  self allowmovement(var0);
  scripts\common\utility::allow_prone(var0);
  scripts\common\utility::allow_crouch(var0);
  scripts\common\utility::allow_jump(var0);
  scripts\common\utility::allow_fire(var0);
  scripts\common\utility::allow_ads(var0);
  scripts\common\utility::allow_sprint(var0);
  scripts\common\utility::allow_melee(var0);
  scripts\common\utility::allow_lean(var0);
  scripts\common\utility::allow_slide(var0);
  scripts\common\utility::allow_offhand_weapons(var0);
  scripts\common\utility::allow_weapon_switch(var0);
  scripts\common\utility::allow_usability(var0);
}

function register_infil_spots(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(game["infil"][var0]["spots"])) {
    game["infil"][var0]["spots"] = [];
  }

  var6 = game["infil"][var0]["spots"].size;

  for(var7 = 0; var7 < var2; var7++) {
    var8 = game["infil"][var0]["spots"].size;

    if(isDefined(var4)) {
      var9 = 0;

      foreach(var11 in var4) {
        foreach(var13 in var11) {
          if(var13 == var8 - var6) {
            game["infil"][var0]["spots"][var8]["priority"] = var15;
            var9 = 1;
            break;
          }
        }

        if(var9) {
          break;
        }
      }
    } else {
      game["infil"][var0]["spots"][var8]["priority"] = -1;
    }

    game["infil"][var0]["spots"][var8]["seat"] = var7;
    game["infil"][var0]["spots"][var8]["infil"] = var1;
    game["infil"][var0]["spots"][var8]["callback"] = var5;
  }

  if(!istrue(level.ref_12c49)) {
    level.requiredplayercount[var0] += var3;
    return;
  }
}

function player_on_spot(var0, var1) {
  if(isDefined(game["infil"][var0.team]["spots"])) {}

  if(isDefined(game["infil"][var0.team]["spots"][var1])) {}

  if(isDefined(game["infil"][var0.team]["spots"][var1]["player"])) {}

  game["infil"][var0.team]["spots"][var1]["player"] = var0;
  return game["infil"][var0.team]["spots"][var1];
}

function player_free_spot(var0, var1) {
  var0 setclientomnvar("ui_player_in_infil", 0);

  if(!isDefined(var1)) {
    var1 = var0.team;
  }

  if(isDefined(game["infil"][var1]["spots"])) {}

  foreach(var3 in game["infil"][var1]["spots"]) {
    if(is_spot_taken(var1, var4) && var3["player"] == var0) {
      game["infil"][var1]["spots"][var4]["player"] = undefined;
      var0 notify("player_free_spot");
      return;
    }
  }
}

function get_player_at_spot(var0, var1) {
  return game["infil"][var0]["spots"][var1]["player"];
}

function get_spot_from_player(var0, var1) {
  if(!isDefined(var1)) {
    var1 = var0.team;
  }

  if(!isDefined(game["infil"][var1]["spots"])) {
    return undefined;
  }

  foreach(var3 in game["infil"][var1]["spots"]) {
    if(isDefined(var3["player"]) && var3["player"] == var0) {
      return var4;
    }
  }

  return undefined;
}

function is_spot_taken(var0, var1) {
  if(isDefined(game["infil"][var0]["spots"])) {}

  if(isDefined(game["infil"][var0]["spots"][var1])) {}

  return isDefined(game["infil"][var0]["spots"][var1]["player"]);
}

function get_spot_taken_count(var0) {
  if(isDefined(game["infil"][var0]["spots"])) {}

  var1 = 0;

  foreach(var3 in game["infil"][var0]["spots"]) {
    if(is_spot_taken(var0, var4)) {
      var1++;
    }
  }

  return var1;
}

function get_spot_by_priority(var0) {
  var1 = [];

  foreach(var3 in game["infil"][var0]["spots"]) {
    if(!is_spot_taken(var0, var4)) {
      var1 = var4;
    }
  }

  if(var1.size == 0) {
    return undefined;
  }

  var5 = getdvarint("scr_infil_force_seat", -1);

  if(scripts\engine\utility::array_contains(var1, var5)) {
    return var5;
  }

  var6 = [];
  var7 = -1;

  foreach(var3 in var1) {
    var9 = game["infil"][var0]["spots"][var3]["priority"];

    if(var6.size == 0 || var9 < var7) {
      var6 = [];
      var6 = var3;
      var7 = var9;
      continue;
    }

    if(var9 == var7) {
      var6 = var3;
    }
  }

  return var6[randomint(var6.size)];
}

function get_spot_in_lane(var0) {
  while(!isDefined(self.forcedavailablespawnlocation)) {
    waitframe();
  }

  var1 = scripts\engine\utility::ter_op(var0 == "allies", "a", "b") + getsubstr(self.forcedavailablespawnlocation, 5, 6);
  var2 = [];

  foreach(var4 in game["infil"][var0]["spots"]) {
    if(issubstr(var4["infil"].lane, var1) && !is_spot_taken(var0, var5)) {
      var2 = var5;
    }
  }

  if(var2.size == 0) {
    return undefined;
  }

  var6 = [];
  var7 = -1;

  foreach(var4 in var2) {
    var9 = game["infil"][var0]["spots"][var4]["priority"];

    if(var6.size == 0 || var9 < var7) {
      var6 = [];
      var6 = var4;
      var7 = var9;
      continue;
    }

    if(var9 == var7) {
      var6 = var4;
    }
  }

  return var6[randomint(var6.size)];
}

function get_random_spot(var0) {
  var1 = [];

  foreach(var3 in game["infil"][var0]["spots"]) {
    if(!is_spot_taken(var0, var4)) {
      var1 = var4;
    }
  }

  if(var1.size == 0) {
    return undefined;
  }

  var3 = scripts\engine\utility::random(var1);
  return var3;
}

function get_taken_spot_count(var0) {
  if(!isDefined(game["infil"][var0]["spots"])) {
    return 0;
  }

  var1 = 0;

  foreach(var3 in game["infil"][var0]["spots"]) {
    if(is_spot_taken(var0, var4)) {
      var1++;
    }
  }

  return var1;
}

function get_taken_spot_percent(var0) {
  if(!isDefined(game["infil"][var0]["spots"])) {
    return 0;
  }

  var1 = 0;
  var2 = 0;

  foreach(var4 in game["infil"][var0]["spots"]) {
    var1++;

    if(is_spot_taken(var0, var5)) {
      var2++;
    }
  }

  return var2 / var1;
}

function get_random_spot_in_infil(var0, var1) {
  var2 = [];

  foreach(var5, var4 in game["infil"][var0]["spots"]) {
    if(var5["infil"] != var1) {
      continue;
    }

    if(!is_spot_taken(var0, var5)) {
      var2 = var5;
    }
  }

  if(var2.size == 0) {
    return undefined;
  }

  var4 = scripts\engine\utility::random(var2);
  return var4;
}

function infil_player_array_handler(var0) {
  self endon("death");
  self.players = scripts\engine\utility::array_add(self.players, var0);
  var0 waittill("death_or_disconnect");
  self.players = scripts\engine\utility::array_remove(self.players, var0);
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

  var0 = 0;
  var1 = game["infil"][self.team]["spots"][0]["priority"] != -1;

  if(level.gametype == "tac_ops" && isDefined(self.tacopsmapselectedarea.dynamicent)) {
    var2 = get_random_spot_in_infil(self.team, self.tacopsmapselectedarea.dynamicent);
  } else if(var1) {
    var2 = get_spot_taken_count(self.team);
  } else if(var2) {
    var2 = get_spot_by_priority(self.team);
  } else {
    var2 = get_random_spot(self.team);
  }

  if(!isDefined(var2)) {
    return;
  }

  var3 = player_on_spot(self, var2);
  thread infil_player_array_handler(var3["infil"]);
  self notify("player_added_to_infil");
  self.infil = var3["infil"];
  self thread[[var3["callback"]]](var3["infil"], var3["seat"]);
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
  var0 = 0;

  while(!var0) {
    var0 = self setdemeanorviewmodel("normal");
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
  var0 = getomnvar("ui_always_show_nameplates");
  setomnvar("ui_always_show_nameplates", 1);

  if(!isDefined(level.bypassclasschoicefunc)) {
    setomnvarforallclients("ui_skip_loadout", 0);
    level.bypassclasschoicefunc = undefined;
  }

  thread infil_show_countdown();
  var1 = getdvarint("LOPKSRNTTS");
  var2 = getdvarint("LROTSRRQMQ");
  var3 = getdvarint("NKMOPQSPMO");
  setDvar("LOPKSRNTTS", 0);
  setDvar("LROTSRRQMQ", 1);
  setDvar("NKMOPQSPMO", 1);
  level waittill("prematch_done");
  var4 = scripts\mp\utility\player::alwaysshowminimap();

  foreach(var6 in level.players) {
    if(var4) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "showMiniMap")) {
        var6[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "showMiniMap")]]();
      }

      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "hideMiniMap")) {
      var6[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "hideMiniMap")]]();
    }
  }

  setomnvar("ui_in_infil", -1);
  setomnvar("ui_always_show_nameplates", var0);
  setDvar("LOPKSRNTTS", var1);
  setDvar("LROTSRRQMQ", var2);
  setDvar("NKMOPQSPMO", var3);
}

function infil_show_countdown() {
  wait level.prematchperiodend - 5;
  setomnvar("ui_in_infil", 2);
}

function alwaysgamemodeclass() {
  var0 = self getclantag();

  if(var0 == "AR") {
    var1 = "default1";
  } else if(var1 == "SMG") {
    var1 = "default2";
  } else {
    jumpiffalse(var1 == "LMG") LOC_00000049;
    var1 = "default3";
    goto LOC_00000072;
  }

  LOC_00000072:
    self.pers["class"] = var2;
  self.pers["lastClass"] = "";
  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  return var2;
}

#using_animtree("script_model");

function infil_player_rig(var0, var1, var2) {
  self.animname = var0;
  var3 = spawn("script_model", (0, 0, 0));
  var3.player = self;
  self.player_rig = var3;
  self.player_rig setModel(var1);
  self.player_rig hide();
  self.player_rig.animname = var0;
  self.player_rig useanimtree(#animtree);
  self.player_rig.weapon_state_func = &scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  self.player_rig.cinematic_motion_override = &scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
  self.player_rig.dof_func = &scripts\mp\utility\infilexfil::handledofnotetrack;
  self playerlinktodelta(self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);

  if(isDefined(var2) && var2) {
    self playersetgroundreferenceent(self.player_rig);
  }

  self notify("rig_created");
  scripts\engine\utility::ref_143a5("remove_rig", "player_free_spot");

  if(isDefined(self)) {
    if(isDefined(var2) && var2) {
      self playersetgroundreferenceent(undefined);
    }

    self unlink();
  }

  if(isDefined(var3)) {
    var3 delete();
    return;
  }
}

function infil_play_sound_func(var0, var1, var2) {
  foreach(var4 in self.players) {
    var4 playsoundtoplayer(var0, var4);
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
    foreach(var1 in level.players) {
      iprintlnbold("!-!-!-!-!-INFIL BEGIN-!-!-!-!-!");
    }

    return;
  }
}

function infil_scene_fade_in(var0, var1) {
  if(scripts\mp\flags::gameflag("infil_started")) {
    return;
  }

  self notify("infil_scene_fade_in");
  self endon("infil_scene_fade_in");
  self setclientomnvar("ui_world_fade", 1);
  self endon("disconnect");
  scripts\mp\flags::gameflagwait("infil_started");
  var2 = gettime();
  var3 = 1;

  while(var3 > 0) {
    var3 -= level.framedurationseconds;
    var3 = max(var3, 0);
    self setclientomnvar("ui_world_fade", var3);
    waitframe();
  }
}

function heli_path(var0) {
  if(!isDefined(var0)) {
    var0 = self;
  }

  var0 endon("death");

  if(isDefined(var0.hasstarted)) {
    return;
  } else {
    var0.hasstarted = 1;
  }

  var0 scripts\engine\utility::script_delay();
  var0 notify("start_vehiclepath");
  var0 notify("start_dynamicpath");
}

function vehicle_paths_helicopter(var0, var1, var2) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(isDefined(var0)) {
    self.attachedpath = var0;
  }

  var3 = self.attachedpath;
  self.currentnode = self.attachedpath;

  if(!isDefined(var3)) {
    return;
  }

  var4 = var3;

  if(var1) {
    self waittill("start_dynamicpath");
  }

  if(isDefined(var2)) {
    var5 = spawnStruct();
    var5.origin = (self.origin[0], self.origin[1], self.origin[2] + var2);
    heli_wait_node(var5, undefined);
  }

  var6 = undefined;
  var7 = var3;
  var8 = get_path_getfunc(var3);

  while(isDefined(var7)) {
    if(isDefined(var7.script_parameters)) {
      readnodeevents(var7);
    }

    if(isDefined(var7.script_linkto)) {
      set_lookat_from_dest(var7);
    }

    heli_wait_node(var7, var6, var2);

    if(!isDefined(self)) {
      return;
    }

    self.currentnode = var7;
    var7 notify("trigger", self);

    if(isDefined(var7.script_helimove)) {
      self setyawspeedbyname(var7.script_helimove);

      if(var7.script_helimove == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var7.script_team)) {
      self.script_team = var7.script_team;
    }

    if(isDefined(var7.script_unload)) {
      self notify("unload");
      scripts\engine\utility::waittill_notify_or_timeout("unloaded", self.unload_time);
    }

    if(self vehicle_isphysveh()) {
      if(isDefined(var7.script_pathtype)) {
        self.veh_pathtype = var7.script_pathtype;
      }
    }

    if(isDefined(var7.script_flag_wait)) {
      scripts\engine\utility::flag_wait(var7.script_flag_wait);

      if(isDefined(var7.script_delay_post)) {
        wait var7.script_delay_post;
      }

      self notify("delay_passed");
    }

    if(isDefined(self.set_lookat_point)) {
      self.set_lookat_point = undefined;
      self clearlookatent();
    }

    var6 = var7;

    if(!isDefined(var7.target)) {
      break;
    }

    var7 = [[var8]](var7.target);

    if(!isDefined(var7)) {
      var7 = var6;
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self.script_vehicle_selfremove)) {
    self delete();
    return;
  }
}

function heli_wait_node(var0, var1, var2) {
  self endon("newpath");

  if(isDefined(var0.script_unload) || isDefined(var0.script_land)) {
    var3 = 0;

    if(isDefined(var0.script_land)) {
      scripts\engine\utility::ent_flag_set("landed");

      if(isDefined(self.unload_land_offset)) {
        var3 = self.unload_land_offset;
      }
    } else if(isDefined(var0.script_unload) && isDefined(self.unload_hover_offset)) {
      var3 = self.unload_hover_offset;
    } else if(isDefined(var0.script_unload) && isDefined(self.unload_hover_offset_max)) {
      var4 = scripts\common\utility::groundpos(var0.origin);
      var3 = var0.origin[2] - var4[2];

      if(var3 >= self.unload_hover_offset_max) {
        var3 = self.unload_hover_offset_max;
      } else if(isDefined(self.unload_hover_land_height) && var3 < self.unload_hover_land_height) {
        var3 = self.unload_hover_land_height;
      }
    }

    var0.radius = 2;

    if(isDefined(var0.ground_pos)) {
      var0.origin = var0.ground_pos + (0, 0, var3);
    } else {
      var5 = scripts\common\utility::groundpos(var0.origin) + (0, 0, var3);

      if(var5[2] > var0.origin[2] - 2000) {
        var0.origin = scripts\common\utility::groundpos(var0.origin) + (0, 0, var3);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var1)) {
    var6 = var1.script_airresistance;
    var7 = var1.speed;
    var8 = var1.script_accel;
    var9 = var1.script_decel;
  } else {
    var6 = undefined;
    var7 = undefined;
    var8 = undefined;
    var9 = undefined;
  }

  var10 = isDefined(var7.script_stopnode) && var7.script_stopnode;
  var11 = isDefined(var7.script_unload);
  var12 = isDefined(var7.script_flag_wait) && !scripts\engine\utility::flag(var7.script_flag_wait);
  var13 = !isDefined(var7.target);
  var14 = isDefined(var7.script_delay);

  if(isDefined(var7.angles)) {
    var15 = var7.angles[1];
  } else {
    var15 = 0;
  }

  if(self.health <= 0) {
    return;
  }

  var16 = var8.origin;

  if(isDefined(var6)) {
    var16 = (var16[0], var16[1], var16[2] + var6);
  }

  if(isDefined(self.heliheightoverride)) {
    var16 = (var16[0], var16[1], self.heliheightoverride);
  }

  self vehicle_helisetai(var16, var8, var9, var10, var8.script_goalyaw, var8.script_anglevehicle, var15, var7, var15, var11, var12, var13, var14);

  if(isDefined(var8.radius)) {
    self setneargoalnotifydist(var8.radius);
    scripts\engine\utility::ref_143a5("near_goal", "goal");
  } else {
    self waittill("goal");
  }

  if(isDefined(var8.script_firelink)) {
    if(isDefined(level.helicopter_firelinkfunk)) {}

    GscBinSkip1(0x74, level.helicopter_firelinkfunk, var8);
  }

  var8 scripts\engine\utility::script_delay();

  if(isDefined(self.path_gobbler)) {
    scripts\engine\utility::deletestruct_ref(var8);
  }

  self notify("continuepath");
}

function get_path_getfunc(var0) {
  var1 = &get_from_vehicle_node;

  if(isDefined(var0.target)) {
    if(isDefined(get_from_entity(var0.target))) {
      var1 = &get_from_entity;
    }

    if(isDefined(get_from_spawnStruct(var0.target))) {
      var1 = &get_from_spawnstruct;
    }
  }

  return var1;
}

function get_from_vehicle_node(var0) {
  return getvehiclenode(var0, "targetname");
}

function get_from_spawnStruct(var0) {
  return scripts\engine\utility::getStruct(var0, "targetname");
}

function get_from_entity(var0) {
  var1 = getEntArray(var0, "targetname");

  if(isDefined(var1) && var1.size > 0) {
    return var1[randomint(var1.size)];
  }

  return undefined;
}

function set_lookat_from_dest(var0) {
  var1 = getEnt(var0.script_linkto, "script_linkname");

  if(!isDefined(var1)) {
    return;
  }

  self setlookatent(var1);
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
  var0 = self.path;
  var1 = var0.speed;

  for(;;) {
    if(isDefined(var0.script_unload)) {
      break;
    }

    if(!isDefined(var0.target)) {
      break;
    }

    var2 = scripts\engine\utility::getStruct(var0.target, "targetname");

    if(!isDefined(var2)) {
      break;
    }

    var3 = distance(var0.origin, var2.origin);

    if(isDefined(var0.speed)) {
      var1 = var0.speed;
    }

    var4 = 17.6;
    var5 = 1.1;
    self.pathduration += var3 * var5 / var1 * var4;
    var0 = var2;
  }

  return self.pathduration;
}

function readnodeevents(var0) {
  var1 = strtok(var0.script_parameters, ",");

  foreach(var3 in var1) {
    var4 = strtok(var3, ":");

    if(!isDefined(var4)) {
      return;
    }

    if(var4.size != 2) {
      return;
    }

    thread processtimelineevent(var4[0], float(var4[1]));
  }
}

function processtimelineevent(var0, var1) {
  if(!isDefined(self.timelineevents)) {
    self.timelineevents = [];
  }

  if(var1 > 0) {
    wait var1;
  }

  switch (var0) {
    case "shake_low":
      self.timelineevents["shake"] = "low";

      foreach(var3 in self.infil.players) {
        scripts\mp\utility\infilexfil::cam_shake_low(var3);
      }

      break;
    case "shake_off":
      self.timelineevents["shake"] = "off";

      foreach(var3 in self.infil.players) {
        scripts\mp\utility\infilexfil::cam_shake_off(var3);
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