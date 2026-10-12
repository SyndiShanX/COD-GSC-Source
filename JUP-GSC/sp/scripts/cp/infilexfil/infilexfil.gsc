/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\infilexfil\infilexfil.gsc
************************************************/



#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\cp_infilexfil;
#using scripts\cp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace infilexfil;

function infil_add(type, subtype, seat_count, required_seats, fill_order, spawn_func, get_length_func, player_func) {
  if(getdvarint(@ "scr_skip_infils", 0) == 1) {
    if(flag_exist("infil_complete")) {
      flag_set("infil_complete");
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
    foreach(team in level.teamnamelist) {
      game["infil"][team] = [];
    }
  }

  if(!isDefined(game["infil"]["types"])) {
    game["infil"]["types"] = [];
  }

  if(isDefined(game["infil"]["types"][type]) && isDefined(game["infil"]["types"][type][subtype])) {
    if(isDefined(game["infil"]["types"][type][subtype]["persistentVehicle"])) {
      self[[game["infil"]["types"][type][subtype]["persistentVehicle"]]](type, subtype);
    }

    if(flag_exist("infil_complete")) {
      flag_set("infil_complete");
    }

    return;
  }

  game["infil"]["types"][type][subtype] = [];
  game["infil"]["types"][type][subtype]["spawn_func"] = spawn_func;
  game["infil"]["types"][type][subtype]["player_func"] = player_func;
  game["infil"]["types"][type][subtype]["get_length_func"] = get_length_func;
  game["infil"]["types"][type][subtype]["seats"] = seat_count;
  game["infil"]["types"][type][subtype]["required_seats"] = required_seats;
  game["infil"]["types"][type][subtype]["fill_order"] = fill_order;
  level thread infil_init(type, subtype);
}

function infil_init(type, subtype) {
  waittillframeend();

  if(!isDefined(level.prematchperiod) || level.prematchperiod == 0) {
    return;
  }

  gameflaginit("infil_started", 0);

  if(!flag_exist("infil_over")) {
    flag_init("infil_over");
  }

  setdevdvarifuninitialized(@ "hash_e6526b9ef05103ad", -1);
  setdevdvarifuninitialized(@ "hash_9d06e62e59d8f04a", 0);
  setdevdvarifuninitialized(@ "hash_f711f210f6ffd355", 0);
  setdevdvarifuninitialized(@ "hash_911d1dbce0b52bb1", 0);
  setdevdvarifuninitialized(@ "hash_4c2539684478a68e", "<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_1f7e93431ff79c39", "<dev string:x1c>");

  if(!isDefined(level.infilinitonce)) {
    level.infilinitonce = 1;
    level thread onplayerspawned();
    level thread onjoinedteam();
  }

  if(!isDefined(level.prematchallowfunc)) {
    level.prematchallowfunc = &infil_player_allow_cp;
  }

  var_d47ac5a6cbdc6dcf = undefined;
  teamindex = 0;

  foreach(infil_data in get_all_infils()) {
    if(!infil_data infil_is_gamemode()) {
      continue;
    }

    team = infil_data.script_team;

    if(infil_data infil_is_type(type) && infil_data infil_is_subtype(subtype) && isinfilgameplayteam(infil_data.script_team)) {
      infil_type = game["infil"]["types"][type][subtype];
      infil_ent = infil_data[[infil_type["spawn_func"]]](infil_data.script_team, infil_data.target, infil_data.name);
      infil_ent.players = [];
      infil_ent.type = infil_data.script_noteworthy;
      infil_ent.subtype = infil_data.name;
      team = infil_data.script_team;
      game["infil"][team]["lanes"][type][subtype] = infil_ent;
      register_infil_spots(team, infil_ent, infil_type["seats"], infil_type["required_seats"], infil_type["fill_order"], infil_type["player_func"]);
      infil_time = infil_ent[[infil_type["get_length_func"]]](subtype);

      if(!isDefined(var_d47ac5a6cbdc6dcf)) {
        if(isDefined(infil_time)) {
          infil_time += 1;
        } else {
          infil_time = 1;
        }

        var_d47ac5a6cbdc6dcf = infil_time;
        continue;
      }

      infil_time += 1;
    }
  }

  if(gamehasinfil() && isDefined(var_d47ac5a6cbdc6dcf)) {
    level.prematchperiod = 10;
    level.prematchperiodend = var_d47ac5a6cbdc6dcf + 1;
    level thread infil_setup_ui();
    level thread infil_wait_for_all_players();
  }
}

function onplayerspawned() {
  self endon("game_ended");
  self endon("prematch_over");

  while(true) {
    level waittill("trying_to_join_infil", player);

    if(playerinfildisabled(player)) {
      continue;
    }

    playerteams = getotherteam(player.team);

    if(isarray(playerteams)) {
      playerteam = playerteams[0];
    } else {
      playerteam = playerteams;
    }

    var_be4fbabeafb491a7 = get_spot_from_player(player, playerteam);

    if(isDefined(var_be4fbabeafb491a7)) {
      player_free_spot(player, getotherteam(playerteam));
    }

    if(!flag("infil_over")) {
      player player_join_infil_cp();
    }
  }
}

function playerinfildisabled(player) {
  return istrue(player.infil_disabled);
}

function disableplayerinfil(player) {
  player.infil_disabled = 1;
}

function onjoinedteam() {
  self endon("game_ended");
  self endon("prematch_over");

  while(true) {
    level waittill("joined_team", player);

    if(isDefined(player.team) && player.team == "spectator") {
      player thread infilspectatorview();
    }
  }
}

function infilspectatorview() {
  self endon("joined_team");
  self endon("disconnect");
  self notify("infilSpectatorView");
  self endon("infilSpectatorView");
  thread infil_scene_fade_in(0, 0.55, "fade_up");
  level waittill("start_scene");
  self notify("fade_up");
}

function onplayerdisconnectinfil() {
  self endon("prematch_over");
  team = self.team;
  self waittill("disconnect");
  player_free_spot(self, team);
}

function get_all_infils(infil_type) {
  if(isDefined(infil_type)) {
    return getStructArray("infil_type", "script_noteworthy");
  }

  return getStructArray("cp_infil", "targetname");
}

function infil_is_gamemode() {
  if(getdvarint(@ "hash_2bc5d2ec9043a3f5", 0) == 1) {
    return true;
  }

  type = self.script_noteworthy;
  team = self.script_team;
  allies = getDvar(@ "hash_4c2539684478a68e", "<dev string:x1c>");
  axis = getDvar(@ "hash_1f7e93431ff79c39", "<dev string:x1c>");

  if(team == "<dev string:x24>" && allies != "<dev string:x1c>") {
    return (allies == type);
  }

  if(team == "<dev string:x2b>" && axis != "<dev string:x1c>") {
    return (axis == type);
  }

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
      case #"hash_ca6516c10db2c95":
      case #"hash_7485fa6c474ec865":
      case #"hash_8c758b84936e8d42":
      case #"hash_c3668076a0827ce0":
      case #"hash_ea061d29bbd1f237":
      case #"hash_ec24570718a340f5":
        return true;
    }
  }

  if(self.spawnflags & 4) {
    switch (level.gametype) {
      case #"hash_fa0ed2f6bd4f4395":
      case #"hash_fa50b0f6bd82e972":
      case #"hash_fa50baf6bd82f930":
        return true;
    }
  }

  if(self.spawnflags & 8) {
    switch (level.gametype) {
      case #"hash_53825b446469ac4c":
      case #"hash_f4a9126c03d3385b":
        return true;
    }
  }

  if(self.spawnflags & 16) {
    switch (level.gametype) {
      case #"hash_6efb0f59a62300fb":
      case #"hash_dd5b900f435d3f36":
        return true;
    }
  }

  if(self.spawnflags & 32) {
    switch (level.gametype) {
      case #"hash_1a5d186c17c00d3c":
        return true;
    }
  }

  if(self.spawnflags & 64) {
    switch (level.gametype) {
      case #"hash_eb5e5f470e0c1dc2":
        return true;
    }
  }

  if(self.spawnflags & 128) {
    switch (level.gametype) {
      case #"hash_1aac086c17fe5ccb":
        return true;
    }
  }

  return false;
}

function infil_has_map_config() {}

function infil_init_spawn_selection() {}

function infil_player_allow_cp(allow, bypass) {
  if(self ishost() && getdvarint(@ "hash_f711f210f6ffd355") == 1) {
    if(!allow) {
      val::set("infil_player", "weapon", 0);
      return;
    }

    val::reset_all("infil_player");
    return;
  }

  if(!allow) {
    val::set("infil_player", "allow_movement", 0);
    val::set("infil_player", "prone", 0);
    val::set("infil_player", "crouch", 0);
    val::set("infil_player", "allow_jump", 0);
    val::set("infil_player", "fire", 0);
    val::set("infil_player", "ads", 0);
    val::set("infil_player", "sprint", 0);
    val::set("infil_player", "melee", 0);
    val::set("infil_player", "reload", 0);
    val::set("infil_player", "lean", 0);
    val::set("infil_player", "slide", 0);
    val::set("infil_player", "offhand_weapons", 0);
    val::set("infil_player", "weapon_switch", 0);
    val::set("infil_player", "usability", 0);
    val::set("infil_player", "script_weapon_switch", 0);
    return;
  }

  val::reset_all("infil_player");
}

function function_3b61547adaff3b7e(allow, bypass) {
  if(self ishost() && getdvarint(@ "hash_f711f210f6ffd355") == 1) {
    if(!allow) {
      val::set("infil_player", "weapon", 0);
      return;
    }

    val::reset_all("infil_player");
    return;
  }

  if(!allow) {
    val::set("infil_player", "allow_movement", 0);
    val::set("infil_player", "prone", 0);
    val::set("infil_player", "crouch", 0);
    val::set("infil_player", "allow_jump", 0);
    val::set("infil_player", "sprint", 0);
    val::set("infil_player", "melee", 0);
    val::set("infil_player", "lean", 0);
    val::set("infil_player", "slide", 0);
    val::set("infil_player", "offhand_weapons", 0);
    val::set("infil_player", "weapon_switch", 0);
    val::set("infil_player", "usability", 0);
    val::set("infil_player", "script_weapon_switch", 0);
    return;
  }

  val::reset_all("infil_player");
}

function register_infil_spots(team, infil, amount, required, fillorder, think_func) {
  if(!isDefined(game["infil"][team]["spots"])) {
    game["infil"][team]["spots"] = [];
  }

  startindex = game["infil"][team]["spots"].size;

  for(i = 0; i < amount; i++) {
    index = game["infil"][team]["spots"].size;

    if(isDefined(fillorder)) {
      seatfound = 0;

      foreach(seats in fillorder) {
        foreach(seat in seats) {
          if(seat == index - startindex) {
            game["infil"][team]["spots"][index]["priority"] = priority;
            seatfound = 1;
            break;
          }
        }

        if(seatfound) {
          break;
        }
      }
    } else {
      game["infil"][team]["spots"][index]["priority"] = -1;
    }

    game["infil"][team]["spots"][index]["seat"] = i;
    game["infil"][team]["spots"][index]["infil"] = infil;
    game["infil"][team]["spots"][index]["callback"] = think_func;
  }

  if(required > level.requiredplayercount[team]) {
    level.requiredplayercount[team] = required;
  }

  if(getdvarint(@ "hash_911d1dbce0b52bb1") > 0) {
    level.requiredplayercount[team] = getdvarint(@ "hash_911d1dbce0b52bb1");
  }
}

function player_on_spot(player, spot_index) {
  if(!isDefined(game["infil"][player.team]["spots"])) {
    assertmsg("Trying to take a spot when there are no spots in existence!");
  }

  if(!isDefined(game["infil"][player.team]["spots"][spot_index])) {
    assertmsg("Trying to take a spot that is outside of the range of spots we can offer!");
  }

  if(isDefined(game["infil"][player.team]["spots"][spot_index]["player"])) {
    assertmsg("You are placing a SECOND player in the same spot! BAD!");
  }

  game["infil"][player.team]["spots"][spot_index]["player"] = player;
  return game["infil"][player.team]["spots"][spot_index];
}

function player_free_spot(player, team) {
  if(!isDefined(team)) {
    team = player.team;
  }

  if(!isDefined(game["infil"][team]["spots"])) {
    assertmsg("Trying to free a spot when there are no spots in existence!");
  }

  foreach(key, spot in game["infil"][team]["spots"]) {
    if(is_spot_taken(team, key) && spot["player"] == player) {
      game["infil"][team]["spots"][key]["player"] = undefined;
      player notify("player_free_spot");
      return;
    }
  }
}

function get_player_at_spot(team, spot_index) {
  return game["infil"][team]["spots"][spot_index]["player"];
}

function get_spot_from_player(player, team) {
  if(!isDefined(team)) {
    if(isDefined(player.team)) {
      team = player.team;
    } else {
      team = "allies";
    }
  }

  if(!isDefined(game["infil"][team]["spots"])) {
    return undefined;
  }

  foreach(spot in game["infil"][team]["spots"]) {
    if(isDefined(spot["player"]) && spot["player"] == player) {
      return i;
    }
  }

  return undefined;
}

function is_spot_taken(team, spot_index) {
  if(!isDefined(game["infil"][team]["spots"])) {
    assertmsg("Trying to take a spot when there are no spots in existence!");
  }

  if(!isDefined(game["infil"][team]["spots"][spot_index])) {
    assertmsg("Trying to take a spot that is outside of the range of spots we can offer!");
  }

  return isDefined(game["infil"][team]["spots"][spot_index]["player"]);
}

function get_spot_taken_count(team) {
  if(!isDefined(game["infil"][team]["spots"])) {
    assertmsg("Trying to count spots when there are no spots in existence!");
  }

  count = 0;

  foreach(spot in game["infil"][team]["spots"]) {
    if(is_spot_taken(team, key)) {
      count++;
    }
  }

  return count;
}

function get_spot_by_priority(team) {
  available_spots = [];

  foreach(key, spot in game["infil"][team]["spots"]) {
    if(!is_spot_taken(team, key)) {
      available_spots[available_spots.size] = key;
    }
  }

  if(available_spots.size == 0) {
    return undefined;
  }

  force_seat = getdvarint(@ "hash_e6526b9ef05103ad", -1);

  if(array_contains(available_spots, force_seat)) {
    return force_seat;
  }

  spots = [];
  bestpriority = -1;

  foreach(spot in available_spots) {
    priority = game["infil"][team]["spots"][spot]["priority"];

    if(spots.size == 0 || priority < bestpriority) {
      spots = [];
      spots[spots.size] = spot;
      bestpriority = priority;
      continue;
    }

    if(priority == bestpriority) {
      spots[spots.size] = spot;
    }
  }

  return spots[randomint(spots.size)];
}

function get_random_spot(team) {
  available_spots = [];

  foreach(key, spot in game["infil"][team]["spots"]) {
    if(!is_spot_taken(team, key)) {
      available_spots[available_spots.size] = key;
    }
  }

  if(available_spots.size == 0) {
    return undefined;
  }

  spot = random(available_spots);

  force_seat = getdvarint(@ "hash_e6526b9ef05103ad", -1);

  if(force_seat == -2) {
    if(array_contains(available_spots, 0)) {
      return 0;
    } else if(array_contains(available_spots, 2)) {
      return 2;
    } else {
      return spot;
    }
  } else if(array_contains(available_spots, force_seat)) {
    spot = force_seat;
  }

  return spot;
}

function get_taken_spot_count(team) {
  if(!isDefined(game["infil"][team]["spots"])) {
    return 0;
  }

  count = 0;

  foreach(spot in game["infil"][team]["spots"]) {
    if(is_spot_taken(team, key)) {
      count++;
    }
  }

  return count;
}

function get_taken_spot_percent(team) {
  if(!isDefined(game["infil"][team]["spots"])) {
    return 0;
  }

  total = 0;
  count = 0;

  foreach(spot in game["infil"][team]["spots"]) {
    total++;

    if(is_spot_taken(team, key)) {
      count++;
    }
  }

  return count / total;
}

function player_join_infil_cp() {
  if(game["infil"][self.team].size == 0) {
    return;
  }

  if(isPlayer(self) && self ishost() && getdvarint(@ "hash_f711f210f6ffd355") == 1) {
    player_ai_fill();
    return;
  }

  var_ad497b2f2391dfe1 = 0;
  var_47691436552ac69 = game["infil"][self.team]["spots"][0]["priority"] != -1;

  if(var_ad497b2f2391dfe1) {
    spot_index = get_spot_taken_count(self.team);
  } else if(var_47691436552ac69) {
    spot_index = get_spot_by_priority(self.team);
  } else {
    spot_index = get_random_spot(self.team);
  }

  if(!isDefined(spot_index)) {
    assertmsg("Player " + self.name + " unable to find an available spot! Ent " + self.entity_number);
    return;
  }

  spot = player_on_spot(self, spot_index);
  spot["infil"] thread infil_player_array_handler(self);
  self notify("player_added_to_infil");
  self thread[[spot["callback"]]](spot["infil"], spot["seat"]);
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

function player_ai_fill() {
  if(isPlayer(self) && self ishost() && getdvarint(@ "hash_9d06e62e59d8f04a") == 1) {
    var_734654199c0e8131 = level.requiredplayercount[self.team] - 1;

    if(getdvarint(@ "hash_f711f210f6ffd355") == 1) {
      var_734654199c0e8131 = level.requiredplayercount[self.team];
    }

    if(var_734654199c0e8131 > 0) {
      level thread[[level.bot_funcs["<dev string:x30>"]]](var_734654199c0e8131, self.team);
    }

    other_team = getotherteam(self.team)[0];

    if(level.requiredplayercount[other_team] > 0) {
      level thread[[level.bot_funcs["<dev string:x30>"]]](level.requiredplayercount[other_team], other_team);
    }
  }

}

function infil_setup_ui() {
  foreach(player in level.players) {
    player setclientomnvar("ui_hide_hud", 1);
  }

  level.bypassclasschoicefunc = &alwaysgamemodeclass;
  level.infil_in_progress_buffer = 1;
  level waittill("infil_started");

  foreach(player in level.players) {
    player setclientomnvar("ui_hide_hud", 1);
  }

  ui_always_show_nameplates = getomnvar("ui_always_show_nameplates");
  setomnvar("ui_always_show_nameplates", 1);
  level.bypassclasschoicefunc = undefined;
  level.infil_in_progress = 1;
  cg_drawcrosshair = getdvarint(@ "cg_drawcrosshair");
  cg_drawcrosshairnames = getdvarint(@ "cg_drawcrosshairnames");
  cg_drawfriendlynamesalways = getdvarint(@ "hash_721a6fa1822b17d9");
  setDvar(@ "cg_drawcrosshair", 0);
  setDvar(@ "cg_drawcrosshairnames", 1);
  setDvar(@ "hash_721a6fa1822b17d9", 1);
  level waittill("prematch_over");

  foreach(player in level.players) {
    player setclientomnvar("ui_hide_hud", 0);
    player setclientomnvar("ui_hide_minimap", 1);
  }

  setomnvar("ui_always_show_nameplates", ui_always_show_nameplates);
  setDvar(@ "cg_drawcrosshair", cg_drawcrosshair);
  setDvar(@ "cg_drawcrosshairnames", cg_drawcrosshairnames);
  setDvar(@ "hash_721a6fa1822b17d9", cg_drawfriendlynamesalways);
  level.infil_in_progress = undefined;
  wait 2;
  level.infil_in_progress_buffer = undefined;

  if(flag_exist("infil_complete")) {
    flag_set("infil_complete");
  }
}

function infil_show_countdown() {
  wait level.prematchperiodend - 5;
  setomnvar("ui_in_infil", 2);
}

function infil_wait_for_all_players() {
  level waittill("trying_to_join_infil", player);
  level.num_of_player_ready_to_infil = 1;
  wait_for_all_players_or_timeout();
  gameflagset("infil_started");

  if(getdvarint(@ "hash_f84371d2f3a2a3ac", 0) == 1) {
    foreach(player in level.players) {
      iprintlnbold("!-!-!-!-!-INFIL BEGIN-!-!-!-!-!");
    }
  }
}

function wait_for_all_players_or_timeout() {
  level thread player_trying_to_join_infil_monitor();
  level thread max_wait_for_infil_to_start();
  level waittill("ready_to_start_infil");
}

function player_trying_to_join_infil_monitor() {
  level endon("ready_to_start_infil");

  while(true) {
    level waittill("trying_to_join_infil", player);
    level.num_of_player_ready_to_infil++;

    if(level.num_of_player_ready_to_infil == 2) {
      level notify("ready_to_start_infil");
    }
  }
}

function max_wait_for_infil_to_start() {
  level endon("ready_to_start_infil");
  var_95bd6ec3d906b671 = 5;
  wait var_95bd6ec3d906b671;
  level notify("ready_to_start_infil");
}

function gamehasinfil() {
  if(!isDefined(game["infil"])) {
    return false;
  }

  return true;
}

function isinfilgameplayteam(team) {
  return isDefined(team) && array_contains(level.teamnamelist, team);
}