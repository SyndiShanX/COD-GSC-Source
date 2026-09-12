/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\infilexfil\infilexfil.gsc
************************************************/

function infil_add(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(getdvarint("scr_skip_infils", 0) == 1) {
    if(scripts\engine\utility::flag_exist("infil_complete")) {
      scripts\engine\utility::flag_set("infil_complete");
    }

    return;
  }

  level.prematchperiod = 10;

  while(!isDefined(level.teamnamelist)) {
    waitframe();
  }

  level.requiredplayercount["allies"] = 0;
  level.requiredplayercount["axis"] = 0;

  if(!isDefined(game["infil"])) {
    foreach(var_9 in level.teamnamelist) {
      game["infil"][var_9] = [];
    }

    game["infil"]["types"] = [];
  }

  if(isDefined(game["infil"]["types"][var_0]) && isDefined(game["infil"]["types"][var_0][var_1])) {
    if(isDefined(game["infil"]["types"][var_0][var_1]["persistentVehicle"])) {
      self[[game["infil"]["types"][var_0][var_1]["persistentVehicle"]]](var_0, var_1);
    }

    if(scripts\engine\utility::flag_exist("infil_complete")) {
      scripts\engine\utility::flag_set("infil_complete");
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
  thread infil_init(level, var_0);
}

function infil_init(var_0, var_1) {
  waittillframeend();

  if(!isDefined(level.prematchperiod) || level.prematchperiod == 0) {
    return;
  }

  scripts\cp\utility::gameflaginit("infil_started", 0);

  if(!isDefined(level.infilinitonce)) {
    level.infilinitonce = 1;
    thread onplayerspawned();
    thread onjoinedteam();
  }

  level.prematchallowfunc = &infil_player_allow_cp;
  var_2 = undefined;
  var_3 = 0;

  foreach(var_5 in get_all_infils()) {
    if(infil_has_map_config(var_5)) {
      infil_init_spawn_selection();
    }

    var_6 = var_5.script_team;

    if(var_5 scripts\cp\cp_infilexfil::infil_is_type(var_0) && var_5 scripts\cp\cp_infilexfil::infil_is_subtype(var_1) && isinfilgameplayteam(var_5.script_team)) {
      var_7 = game["infil"]["types"][var_0][var_1];
      var_8 = var_5[[var_7["spawn_func"]]](var_5.script_team, var_5.target, var_5.name);
      var_8.players = [];
      var_8.type = var_5.script_noteworthy;
      var_8.subtype = var_5.name;
      var_6 = var_5.script_team;
      game["infil"][var_6]["lanes"][var_0][var_1] = var_8;
      register_infil_spots(var_6, var_8, var_7["seats"], var_7["required_seats"], var_7["fill_order"], var_7["player_func"]);
      var_9 = var_8[[var_7["get_length_func"]]](var_1);

      if(!isDefined(var_2)) {
        var_9 += 1;
        var_2 = var_9;
      } else {
        var_9 += 1;
      }
      LOC_00000187:
    }
    LOC_00000187:
  }

  if(gamehasinfil() && isDefined(var_2)) {
    level.prematchperiod = 10;
    level.prematchperiodend = var_2 + 1;
    thread infil_setup_ui();
    thread infil_wait_for_all_players();
    return;
  }
}

function onplayerspawned() {
  self endon("game_ended");
  self endon("prematch_over");

  for(;;) {
    level waittill("trying_to_join_infil", var_0);

    if(playerinfildisabled(var_0)) {
      continue;
    }

    var_1 = scripts\cp\utility::getotherteam(var_0.team);

    if(isarray(var_1)) {
      var_2 = var_1[0];
    } else {
      var_2 = var_1;
    }

    var_3 = get_spot_from_player(var_0, var_2);

    if(isDefined(var_3)) {
      player_free_spot(var_0, scripts\cp\utility::getotherteam(var_2));
    }

    if(!scripts\cp\utility::gameflag("infil_started")) {
      player_join_infil_cp(var_0);
    }
  }
}

function playerinfildisabled(var_0) {
  return istrue(var_0.infil_disabled);
}

function disableplayerinfil(var_0) {
  var_0.infil_disabled = 1;
}

function onjoinedteam() {
  self endon("game_ended");
  self endon("prematch_over");

  for(;;) {
    level waittill("joined_team", var_0);

    if(isDefined(var_0.team) && var_0.team == "spectator") {
      thread infilspectatorview();
    }
  }
}

function infilspectatorview() {
  self endon("joined_team");
  self endon("disconnect");
  self notify("infilSpectatorView");
  self endon("infilSpectatorView");
  thread scripts\cp\cp_infilexfil::infil_scene_fade_in(0, 0.55, "fade_up");
  level waittill("start_scene");
  self notify("fade_up");
}

function onplayerdisconnectinfil() {
  self endon("prematch_over");
  var_0 = self.team;
  self waittill("disconnect");
  player_free_spot(self, var_0);
}

function get_all_infils(var_0) {
  if(isDefined(var_0)) {
    return scripts\engine\utility::getStructArray("infil_type", "script_noteworthy");
  }

  return scripts\engine\utility::getStructArray("cp_infil", "targetname");
}

function infil_is_gamemode() {
  self.spawnflags = int(self.spawnflags);

  if(!isDefined(self.spawnflags) || self.spawnflags == 0) {
    return false;
  }

  if(!level.teambased) {
    return false;
  }

  if(self.spawnflags & 1) {
    return true;
  }

  if(self.spawnflags & 2) {
    switch (level.gametype) {
      case "pill":
      case "tjugg":
      case "grind":
      case "conf":
      case "war":
      case "arm":
        return true;
    }
  }

  if(self.spawnflags & 4) {
    switch (level.gametype) {
      case "dd":
      case "sr":
      case "sd":
        return true;
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
      case "koth":
      case "grnd":
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
        return true;
    }
  }

  return false;
}

function infil_has_map_config() {
  return isDefined(self.script_label) && level.gametype == "tac_ops";
}

function infil_init_spawn_selection() {}

function infil_player_allow_cp(var_0, var_1) {
  if(self ishost() && getdvarint("scr_infil_spectator") == 1) {
    scripts\common\utility::allow_weapon(var_0);
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
  scripts\common\utility::allow_reload(var_0);
  scripts\common\utility::allow_lean(var_0);
  scripts\common\utility::allow_slide(var_0);
  scripts\common\utility::allow_offhand_weapons(var_0);
  scripts\common\utility::allow_weapon_switch(var_0);
  scripts\common\utility::allow_usability(var_0);
  scripts\common\utility::allow_script_weapon_switch(var_0);
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

  if(var_3 > level.requiredplayercount[var_0]) {
    level.requiredplayercount[var_0] = var_3;
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

function player_join_infil_cp() {
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
    var_2 = scripts\cp\cp_infilexfil::get_random_spot_in_infil(self.team, self.tacopsmapselectedarea.dynamicent);
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
  var_3["infil"] thread scripts\cp\cp_infilexfil::infil_player_array_handler(self);
  self notify("player_added_to_infil");
  self thread[[var_3["callback"]]](var_3["infil"], var_3["seat"]);
  thread blockswaploadouts();
  thread onplayerdisconnectinfil();
  player_ai_fill();
}

function blockswaploadouts() {
  self endon("disconnect");
  self.delayswaploadout = 1;
  level waittill("prematch_over");
  self.delayswaploadout = 0;
}

function player_ai_fill() {}

function infil_setup_ui() {
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_hide_hud", 1);
  }

  level.bypassclasschoicefunc = &scripts\cp\cp_infilexfil::alwaysgamemodeclass;
  level.infil_in_progress_buffer = 1;
  level waittill("infil_started");

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_hide_hud", 1);
  }

  var_5 = getomnvar("ui_always_show_nameplates");
  setomnvar("ui_always_show_nameplates", 1);
  level.bypassclasschoicefunc = undefined;
  level.infil_in_progress = 1;
  var_6 = getdvarint("cg_drawCrosshair");
  var_7 = getdvarint("cg_drawCrosshairNames");
  var_8 = getdvarint("cg_drawFriendlyNamesAlways");
  setDvar("cg_drawCrosshair", 0);
  setDvar("cg_drawCrosshairNames", 1);
  setDvar("cg_drawFriendlyNamesAlways", 1);
  level waittill("prematch_over");

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_hide_hud", 0);
    var_1 setclientomnvar("ui_hide_minimap", 1);
  }

  setomnvar("ui_always_show_nameplates", var_5);
  setDvar("cg_drawCrosshair", var_6);
  setDvar("cg_drawCrosshairNames", var_7);
  setDvar("cg_drawFriendlyNamesAlways", var_8);
  level.infil_in_progress = undefined;
  wait 2;
  level.infil_in_progress_buffer = undefined;

  if(scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_set("infil_complete");
    return;
  }
}

function infil_show_countdown() {
  wait level.prematchperiodend - 5;
  setomnvar("ui_in_infil", 2);
}

function infil_wait_for_all_players() {
  level waittill("trying_to_join_infil", var_0);
  level.num_of_player_ready_to_infil = 1;
  wait_for_all_players_or_timeout();
  scripts\cp\utility::gameflagset("infil_started");

  if(getdvarint("scr_infil_print_start", 0) == 1) {
    foreach(var_0 in level.players) {
      iprintlnbold("!-!-!-!-!-INFIL BEGIN-!-!-!-!-!");
    }

    return;
  }
}

function wait_for_all_players_or_timeout() {
  thread player_trying_to_join_infil_monitor();
  thread max_wait_for_infil_to_start();
  level waittill("ready_to_start_infil");
}

function player_trying_to_join_infil_monitor() {
  level endon("ready_to_start_infil");

  for(;;) {
    level waittill("trying_to_join_infil", var_0);
    level.num_of_player_ready_to_infil++;

    if(level.num_of_player_ready_to_infil == 4) {
      level notify("ready_to_start_infil");
    }
  }
}

function max_wait_for_infil_to_start() {
  level endon("ready_to_start_infil");
  var_0 = 5;
  wait var_0;
  level notify("ready_to_start_infil");
}

function gamehasinfil() {
  if(!isDefined(game["infil"])) {
    return false;
  }

  return true;
}

function isinfilgameplayteam(var_0) {
  return isDefined(var_0) && scripts\engine\utility::array_contains(level.teamnamelist, var_0);
}