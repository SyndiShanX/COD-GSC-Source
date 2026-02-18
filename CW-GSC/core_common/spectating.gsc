/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\spectating.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\spectate_view;
#using scripts\core_common\system_shared;
#namespace spectating;

function private autoexec __init__system__() {
  system::register(#"spectating", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&init);
  callback::on_spawned(&set_permissions);
  callback::on_joined_team(&set_permissions_for_machine);
  callback::on_joined_spectate(&set_permissions_for_machine);
  callback::on_player_killed(&on_player_killed);
}

function init() {
  foreach(team, _ in level.teams) {
    level.spectateoverride[team] = spawnStruct();
  }
}

function update_settings() {
  level endon(#"game_ended");

  foreach(player in level.players) {
    player set_permissions();
  }
}

function get_splitscreen_team() {
  for(index = 0; index < level.players.size; index++) {
    if(!isDefined(level.players[index])) {
      continue;
    }

    if(level.players[index] == self) {
      continue;
    }

    if(!self isplayeronsamemachine(level.players[index])) {
      continue;
    }

    team = level.players[index].sessionteam;

    if(team != # "spectator") {
      return team;
    }
  }

  return self.sessionteam;
}

function other_local_player_still_alive() {
  for(index = 0; index < level.players.size; index++) {
    if(!isDefined(level.players[index])) {
      continue;
    }

    if(level.players[index] == self) {
      continue;
    }

    if(!self isplayeronsamemachine(level.players[index])) {
      continue;
    }

    if(isalive(level.players[index])) {
      return true;
    }
  }

  return false;
}

function set_permissions() {
  team = self.sessionteam;

  if(team == # "spectator") {
    if(self issplitscreen() && !level.splitscreen) {
      team = get_splitscreen_team();
    }

    if(team == # "spectator") {
      self.spectatorteam = # "invalid";
      self allowspectateallteams(1);
      self allowspectateteam("freelook", 0);
      self allowspectateteam(#"none", 1);
      self allowspectateteam("localplayers", 1);
      return;
    }
  }

  self allowspectateallteams(0);
  self allowspectateteam("localplayers", 1);
  self allowspectateteam("freelook", 0);

  switch (level.spectatetype) {
    case 0:
      self.spectatorteam = # "invalid";
      self allowspectateteam(#"none", 1);
      self allowspectateteam("localplayers", 0);
      break;
    case 3:
      self.spectatorteam = # "invalid";

      if(self issplitscreen() && self other_local_player_still_alive()) {
        self allowspectateteam(#"none", 0);
        break;
      }
    case 1:
      self.spectatorteam = # "invalid";

      if(!level.teambased) {
        self allowspectateallteams(1);
        self allowspectateteam(#"none", 1);
      } else if(isDefined(team) && isDefined(level.teams[team])) {
        self allowspectateteam(team, 1);
        self allowspectateteam(#"none", 0);
      } else {
        self allowspectateteam(#"none", 0);
      }

      break;
    case 6:
      self.spectatorteam = team;
      self allowspectateteam(#"none", 0);
      self allowspectateteam(team, 1);
      break;
    case 2:
      self.spectatorteam = # "invalid";
      self allowspectateteam(#"none", 1);
      self allowspectateallteams(1);

      foreach(team in level.teams) {
        if(self.team == team) {
          continue;
        }

        self allowspectateteam(team, 1);
      }

      break;
    case 4:
    case 5:
      if(spawning::function_29b859d1() || function_a1ef346b(team).size > 0) {
        self allowspectateteam(#"none", 0);
        self allowspectateteam(team, 1);
        return;
      }

      self allowspectateallteams(1);
      return;
  }

  if(isDefined(level.var_799cca7d)) {
    self[[level.var_799cca7d]]();
    return;
  }

  if(isDefined(team) && isDefined(level.teams[team])) {
    if(isDefined(level.spectateoverride[team].allowfreespectate)) {
      self allowspectateteam("freelook", 1);
    }

    if(isDefined(level.spectateoverride[team].allowenemyspectate)) {
      if(level.spectateoverride[team].allowenemyspectate == # "all") {
        self allowspectateallteams(1);
        return;
      }

      self allowspectateallteams(0);
      self allowspectateteam(level.spectateoverride[team].allowenemyspectate, 1);
    }
  }
}

function function_18b8b7e4(players, origin) {
  if(!isDefined(players) || players.size == 0) {
    return undefined;
  }

  sorted_players = arraysort(players, origin);

  foreach(player in sorted_players) {
    if(player == self) {
      continue;
    }

    if(!isalive(player)) {
      continue;
    }

    if(player laststand::player_is_in_laststand()) {
      continue;
    }

    return player;
  }

  return undefined;
}

function spectator_team(player) {
  return player.spectatorteam;
}

function function_44d43a69(player) {
  return player.var_ba35b2d2;
}

function function_9c5853f5(players, var_22b78352, var_89bd5332) {
  foreach(player in players) {
    if(player != self && [[var_22b78352]](player) != var_89bd5332) {
      return player;
    }
  }

  return undefined;
}

function function_327e6270(players, var_22b78352, var_89bd5332) {
  if(!isDefined(players) || players.size == 0) {
    return self;
  }

  player = function_18b8b7e4(players, self.origin);

  if(isDefined(player)) {
    println("<dev string:x38>" + [[var_22b78352]](player) + "<dev string:x51>" + self.name + "<dev string:x5a>" + [[var_22b78352]](self) + "<dev string:x68>" + player.name + "<dev string:x75>");
    return player;
  }

  player = function_9c5853f5(players, var_22b78352, var_89bd5332);

  if(isDefined(player)) {
    println("<dev string:x38>" + [[var_22b78352]](player) + "<dev string:x51>" + self.name + "<dev string:x5a>" + [[var_22b78352]](self) + "<dev string:x68>" + player.name + "<dev string:x82>");
    return player;
  }

  println("<dev string:x38>" + [[var_22b78352]](self) + "<dev string:x51>" + self.name + "<dev string:x9e>");
  return self;
}

function function_460b3788(players, var_22b78352, var_89bd5332, var_c9fe8766) {
  if(!isDefined(players) || players.size == 0) {
    return undefined;
  }

  var_156b3879 = self function_18b8b7e4(players, self.origin);

  if(isDefined(var_156b3879) && isPlayer(var_156b3879)) {
    return var_156b3879;
  }

  target = function_9c5853f5(players, var_22b78352, var_89bd5332);

  if(isDefined(target)) {
    return target;
  }

  if(var_c9fe8766) {
    teammates = function_a1ef346b(self.team);
    return self function_460b3788(teammates, &spectator_team, #"invalid", 0);
  }

  target = array::random(function_a1ef346b());

  if(isDefined(target)) {
    return target;
  }

  return undefined;
}

function function_4c37bb21() {
  players = undefined;

  if(self.team != # "spectator") {
    players = function_a1ef346b(self.team);
  }

  var_156b3879 = self function_460b3788(players, &spectator_team, #"invalid", 0);

  if(isDefined(var_156b3879) && isPlayer(var_156b3879)) {
    self.spectatorteam = var_156b3879.team;

    if(self.sessionstate !== "playing") {
      self setcurrentspectatorclient(var_156b3879);
    }

    return var_156b3879;
  }

  return undefined;
}

function function_10fbd7e5() {
  players = undefined;

  if(self.team != # "spectator") {
    players = function_a1cff525(self.squad);
  }

  var_156b3879 = self function_460b3788(players, &function_44d43a69, #"invalid", 1);

  if(isDefined(var_156b3879) && isPlayer(var_156b3879)) {
    self.spectatorteam = var_156b3879.team;

    if(self.sessionstate !== "playing") {
      self setcurrentspectatorclient(var_156b3879);
    }

    return var_156b3879;
  }

  return undefined;
}

function function_da128b1() {
  if(level.spectatetype === 5 && self.var_ba35b2d2 !== # "invalid") {
    return function_10fbd7e5();
  }

  if(level.spectatetype === 4 && self.spectatorteam !== # "invalid") {
    return function_4c37bb21();
  }

  return undefined;
}

function set_permissions_for_machine() {
  self function_da128b1();
  self set_permissions();

  if(!self issplitscreen()) {
    return;
  }

  for(index = 0; index < level.players.size; index++) {
    if(!isDefined(level.players[index])) {
      continue;
    }

    if(level.players[index] == self) {
      continue;
    }

    if(!self isplayeronsamemachine(level.players[index])) {
      continue;
    }

    level.players[index] set_permissions();
  }
}

function function_7d15f599() {
  livesleft = !(level.numlives && !self.pers[# "lives"]);

  if(!function_a1ef346b(self.team).size && !livesleft) {
    return false;
  }

  return true;
}

function function_23c5f4f2() {
  self endon(#"disconnect");
  waitframe(1);
  function_493d2e03(#"all");
}

function private function_493d2e03(team) {
  if(!self function_7d15f599()) {
    level.spectateoverride[self.team].allowenemyspectate = team;
    update_settings();
  }
}

function function_34460764(team) {
  players = getplayers(team);

  foreach(player in players) {
    player allowspectateallteams(1);
  }
}

function function_ef775048(team, spectate_team) {
  self endon(#"disconnect");
  waitframe(1);

  if(function_a1ef346b(team).size) {
    return;
  }

  players = getplayers(team);

  foreach(player in players) {
    player function_493d2e03(spectate_team);
  }
}

function follow_chain(var_41349818) {
  if(!isDefined(var_41349818)) {
    return;
  }

  var_932d1e24 = 0;

  while(isDefined(var_41349818) && var_41349818.spectatorclient != -1) {
    var_746bf89f = var_41349818;
    var_41349818 = getentbynum(var_41349818.spectatorclient);
    var_932d1e24++;

    if(var_41349818 === var_746bf89f || var_932d1e24 >= 40) {
      break;
    }
  }

  return var_41349818;
}

function function_93281015(players, attacker) {
  if(!isDefined(self) || !isDefined(self.team)) {
    return undefined;
  }

  var_1178af52 = isDefined(attacker) && isPlayer(attacker) && attacker != self && isalive(attacker);

  if(var_1178af52 && attacker.team == self.team) {
    return attacker;
  }

  friendly = function_18b8b7e4(players, self.origin);

  if(isDefined(friendly)) {
    return friendly;
  }

  foreach(player in players) {
    if(isalive(player) && player != self) {
      return player;
    }
  }

  return undefined;
}

function function_e34c084d(players, attacker) {
  var_1178af52 = isDefined(attacker) && isPlayer(attacker) && attacker != self && isalive(attacker);

  if(var_1178af52) {
    return attacker;
  }

  return undefined;
}

function private function_770d7902() {
  assert(level.spectatetype == 4 || level.spectatetype == 5);

  switch (level.spectatetype) {
    case 5:
      players = function_a1cff525(self.squad);

      if(players.size > 0) {
        return players;
      }
    case 4:
    default:
      return function_a1ef346b(self.team);
  }
}

function function_26c5324a(var_156b3879) {
  self.spectatorclient = -1;

  if(!self spawning::function_29b859d1()) {
    self.spectatorteam = var_156b3879.team;
  }

  self setcurrentspectatorclient(var_156b3879);
  self callback::callback(#"hash_37840d0d5a10e6b8", {
    #client: var_156b3879
  });
}

function function_2b728d67(attacker) {
  players = function_770d7902();
  var_8447710e = player::figure_out_attacker(attacker);
  var_156b3879 = self function_93281015(players, var_8447710e);

  if(isDefined(var_156b3879)) {
    function_836ee9ed(var_156b3879);
    return;
  }

  if(!isDefined(level.var_18c9a2d1)) {
    level.var_18c9a2d1 = &function_7fe9c0d1;
  }

  [[level.var_18c9a2d1]](players, attacker);
}

function function_836ee9ed(var_156b3879) {
  var_156b3879 = follow_chain(var_156b3879);

  if(isDefined(var_156b3879) && isPlayer(var_156b3879) && isalive(var_156b3879)) {
    function_26c5324a(var_156b3879);
    return var_156b3879;
  }

  players = function_a1ef346b(self.team);

  if(players.size > 0) {
    self.spectatorteam = self.team;
    return self;
  }

  players = getplayers(self.team);

  foreach(player in players) {
    var_156b3879 = follow_chain(player);

    if(isDefined(var_156b3879) && isPlayer(var_156b3879) && isalive(var_156b3879)) {
      function_26c5324a(var_156b3879);
      return var_156b3879;
    }
  }

  foreach(team in level.teams) {
    if(team == self.team) {
      continue;
    }

    players = function_a1ef346b(team);

    if(players.size > 0) {
      function_26c5324a(players[0]);
      return players[0];
    }
  }
}

function function_7fe9c0d1(players, attacker) {
  if(self spawning::function_29b859d1()) {
    return;
  }

  var_1178af52 = isDefined(attacker) && isPlayer(attacker) && attacker != self && isalive(attacker);

  if(var_1178af52) {
    var_156b3879 = attacker;
  }

  if(!isDefined(var_156b3879)) {
    var_156b3879 = self function_da128b1();
  }

  function_836ee9ed(var_156b3879);
}

function on_player_killed(params) {
  if(level.spectatetype == 4 || level.spectatetype == 5) {
    self thread function_2b728d67(params.eattacker);

    if(level.var_1ba484ad == 2 || self spectate_view::function_500047aa(1)) {
      self spectate_view::function_86df9236();
      return;
    }

    self spectate_view::function_888901cb();
  }
}