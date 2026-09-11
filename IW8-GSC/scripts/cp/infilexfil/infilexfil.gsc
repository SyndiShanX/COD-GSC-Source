/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\infilexfil\infilexfil.gsc
************************************************/

function infil_add(var0, var1, var2, var3, var4, var5, var6, var7) {
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
    foreach(var9 in level.teamnamelist) {
      game["infil"][var9] = [];
    }

    game["infil"]["types"] = [];
  }

  if(isDefined(game["infil"]["types"][var0]) && isDefined(game["infil"]["types"][var0][var1])) {
    if(isDefined(game["infil"]["types"][var0][var1]["persistentVehicle"])) {
      self[[game["infil"]["types"][var0][var1]["persistentVehicle"]]](var0, var1);
    }

    if(scripts\engine\utility::flag_exist("infil_complete")) {
      scripts\engine\utility::flag_set("infil_complete");
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
  thread infil_init(level, var0);
}

function infil_init(var0, var1) {
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
  var2 = undefined;
  var3 = 0;

  foreach(var5 in get_all_infils()) {
    if(infil_has_map_config(var5)) {
      infil_init_spawn_selection();
    }

    var6 = var5.script_team;

    if(var5 scripts\cp\cp_infilexfil::infil_is_type(var0) && var5 scripts\cp\cp_infilexfil::infil_is_subtype(var1) && isinfilgameplayteam(var5.script_team)) {
      var7 = game["infil"]["types"][var0][var1];
      var8 = var5[[var7["spawn_func"]]](var5.script_team, var5.target, var5.name);
      var8.players = [];
      var8.type = var5.script_noteworthy;
      var8.subtype = var5.name;
      var6 = var5.script_team;
      game["infil"][var6]["lanes"][var0][var1] = var8;
      register_infil_spots(var6, var8, var7["seats"], var7["required_seats"], var7["fill_order"], var7["player_func"]);
      var9 = var8[[var7["get_length_func"]]](var1);

      if(!isDefined(var2)) {
        var9 += 1;
        var2 = var9;
      } else {
        var9 += 1;
      }
      LOC_00000187:
    }
    LOC_00000187:
  }

  if(gamehasinfil() && isDefined(var2)) {
    level.prematchperiod = 10;
    level.prematchperiodend = var2 + 1;
    thread infil_setup_ui();
    thread infil_wait_for_all_players();
    return;
  }
}

function onplayerspawned() {
  self endon("game_ended");
  self endon("prematch_over");

  for(;;) {
    level waittill("trying_to_join_infil", var0);

    if(playerinfildisabled(var0)) {
      continue;
    }

    var1 = scripts\cp\utility::getotherteam(var0.team);

    if(isarray(var1)) {
      var2 = var1[0];
    } else {
      var2 = var1;
    }

    var3 = get_spot_from_player(var0, var2);

    if(isDefined(var3)) {
      player_free_spot(var0, scripts\cp\utility::getotherteam(var2));
    }

    if(!scripts\cp\utility::gameflag("infil_started")) {
      player_join_infil_cp(var0);
    }
  }
}

function playerinfildisabled(var0) {
  return istrue(var0.infil_disabled);
}

function disableplayerinfil(var0) {
  var0.infil_disabled = 1;
}

function onjoinedteam() {
  self endon("game_ended");
  self endon("prematch_over");

  for(;;) {
    level waittill("joined_team", var0);

    if(isDefined(var0.team) && var0.team == "spectator") {
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
  var0 = self.team;
  self waittill("disconnect");
  player_free_spot(self, var0);
}

function get_all_infils(var0) {
  if(isDefined(var0)) {
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

function infil_player_allow_cp(var0, var1) {
  if(self ishost() && getdvarint("scr_infil_spectator") == 1) {
    scripts\common\utility::allow_weapon(var0);
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
  scripts\common\utility::allow_reload(var0);
  scripts\common\utility::allow_lean(var0);
  scripts\common\utility::allow_slide(var0);
  scripts\common\utility::allow_offhand_weapons(var0);
  scripts\common\utility::allow_weapon_switch(var0);
  scripts\common\utility::allow_usability(var0);
  scripts\common\utility::allow_script_weapon_switch(var0);
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

  if(var3 > level.requiredplayercount[var0]) {
    level.requiredplayercount[var0] = var3;
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

function player_join_infil_cp() {
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
    var2 = scripts\cp\cp_infilexfil::get_random_spot_in_infil(self.team, self.tacopsmapselectedarea.dynamicent);
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
  var3["infil"] thread scripts\cp\cp_infilexfil::infil_player_array_handler(self);
  self notify("player_added_to_infil");
  self thread[[var3["callback"]]](var3["infil"], var3["seat"]);
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
  foreach(var1 in level.players) {
    var1 setclientomnvar("ui_hide_hud", 1);
  }

  level.bypassclasschoicefunc = &scripts\cp\cp_infilexfil::alwaysgamemodeclass;
  level.infil_in_progress_buffer = 1;
  level waittill("infil_started");

  foreach(var1 in level.players) {
    var1 setclientomnvar("ui_hide_hud", 1);
  }

  var5 = getomnvar("ui_always_show_nameplates");
  setomnvar("ui_always_show_nameplates", 1);
  level.bypassclasschoicefunc = undefined;
  level.infil_in_progress = 1;
  var6 = getdvarint("LOPKSRNTTS");
  var7 = getdvarint("LROTSRRQMQ");
  var8 = getdvarint("NKMOPQSPMO");
  setDvar("LOPKSRNTTS", 0);
  setDvar("LROTSRRQMQ", 1);
  setDvar("NKMOPQSPMO", 1);
  level waittill("prematch_over");

  foreach(var1 in level.players) {
    var1 setclientomnvar("ui_hide_hud", 0);
    var1 setclientomnvar("ui_hide_minimap", 1);
  }

  setomnvar("ui_always_show_nameplates", var5);
  setDvar("LOPKSRNTTS", var6);
  setDvar("LROTSRRQMQ", var7);
  setDvar("NKMOPQSPMO", var8);
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
  level waittill("trying_to_join_infil", var0);
  level.num_of_player_ready_to_infil = 1;
  wait_for_all_players_or_timeout();
  scripts\cp\utility::gameflagset("infil_started");

  if(getdvarint("scr_infil_print_start", 0) == 1) {
    foreach(var0 in level.players) {
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
    level waittill("trying_to_join_infil", var0);
    level.num_of_player_ready_to_infil++;

    if(level.num_of_player_ready_to_infil == 4) {
      level notify("ready_to_start_infil");
    }
  }
}

function max_wait_for_infil_to_start() {
  level endon("ready_to_start_infil");
  var0 = 5;
  wait var0;
  level notify("ready_to_start_infil");
}

function gamehasinfil() {
  if(!isDefined(game["infil"])) {
    return false;
  }

  return true;
}

function isinfilgameplayteam(var0) {
  return isDefined(var0) && scripts\engine\utility::array_contains(level.teamnamelist, var0);
}