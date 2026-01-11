/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: script\script_3c51754cf708b246.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\rat_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_audio;
#using scripts\zm_common\gametypes\globallogic_spawn;
#namespace draft;

autoexec __init__system__() {
  system::register(#"draft", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("world", "draft", 1, 3, "int");
  clientfield::register("clientuimodel", "PositionDraft.stage", 1, 3, "int");
  clientfield::register("clientuimodel", "PositionDraft.autoSelected", 1, 1, "int");
  clientfield::register("clientuimodel", "PositionDraft.cooldown", 1, 5, "int");
  clientfield::register("worlduimodel", "PositionDraft.timeRemaining", 1, 7, "int");
  serverfield::register("PositionDraft.uiLoaded", 1, 1, "int", &function_c10691d1);
  level.var_95c2a39c = 0;
  level.draftstage = 0;
}

function_168be332(response, intval) {
  if(response == # "changecharacter") {
    if(self function_2cfc07fc()) {
      self player_role::clear();
    }
    return;
  }
  if(response == # "randomcharacter") {
    self player_role::clear();
    assign_remaining_players(self);
    if(!(isDefined(level.inprematchperiod) && level.inprematchperiod)) {
      self close();
      self closeingamemenu();
    }
    return;
  }
  if(response == # "ready") {
    self client_ready();
    return;
  }
  if(response == # "opendraft") {
    self open();
    return;
  }
  if(response == # "closedraft") {
    self close();
    return;
  }
  if(response == # "draft") {
    select_character(intval, 0);
  }
}

is_enabled() {
  if(getdvarint(#"art_review", 0) > 0) {
    return 0;
  }

  if(getdvarint(#"mp_prototype", 0) == 0) {
    return 0;
  }
  autoselectcharacter = getdvarint(#"force_char", -1);
  if(player_role::is_valid(autoselectcharacter)) {
    return 0;
  }
  if(isDefined(level.disableclassselection) && level.disableclassselection) {
    return 0;
  }
  return getgametypesetting(#"draftenabled");
}

is_draft_this_round() {
  if(!is_enabled()) {
    return 0;
  }
  if(getgametypesetting(#"drafteveryround") == 1) {
    return 1;
  }
  if(util::isoneround()) {
    return 1;
  }
  return util::isfirstround();
}

function_ca20e02d() {
  player = self;
  return isDefined(player.var_43a97b51) && player.var_43a97b51 > 0;
}

start_cooldown() {
  player = self;
  assert(isplayer(player));
  player endon(#"disconnect");
  cooldowntime = getgametypesetting(#"hash_2b88c6ac064e9c59");
  var_3e8a7d82 = cooldowntime * 1000 + gettime();
  while(gettime() < var_3e8a7d82) {
    timeleft = (var_3e8a7d82 - gettime()) / 1000;
    player clientfield::set_player_uimodel("PositionDraft.cooldown", int(timeleft));
    player.var_43a97b51 = timeleft;
    wait 1;
  }
  player.var_43a97b51 = 0;
  player clientfield::set_player_uimodel("PositionDraft.cooldown", 0);
}

function_2cfc07fc() {
  player = self;
  if(player function_ca20e02d()) {
    println("<dev string:x30>" + player.name);
    return false;
  }
  if(level.draftstage == 0) {
    return true;
  }
  if(level.draftstage == 3 && !player isready()) {
    return true;
  }

  if(level.draftstage != 3) {
    println("<dev string:x65>" + player.name + "<dev string:x9e>" + level.draftstage);
  }
  if(player isready()) {
    println("<dev string:xa7>" + player.name);
  }

  return false;
}

can_select_character(characterindex) {
  player = self;
  if(!function_2cfc07fc()) {
    return false;
  }
  maxuniqueroles = getgametypesetting(#"maxuniquerolesperteam", characterindex);
  if(maxuniqueroles == 0) {
    println("<dev string:xdb>" + player.name + "<dev string:x11b>" + characterindex);
    return false;
  }
  rolecount = 0;
  foreach(player in level.players) {
    if(player == self) {
      continue;
    }
    playercharacterindex = player player_role::get();
    if(isDefined(player.pers[# "team"]) && player.pers[# "team"] == self.pers[# "team"] && playercharacterindex == characterindex) {
      rolecount++;
      if(rolecount >= maxuniqueroles) {
        println("<dev string:x12e>" + player.name + "<dev string:x11b>" + characterindex);
        return false;
      }
    }
  }
  return true;
}

select_character(characterindex, forceselection) {
  player = self;
  assert(player_role::is_valid(characterindex));
  if(!(isDefined(forceselection) && forceselection) && !can_select_character(characterindex)) {
    return false;
  }
  if(self player_role::set(characterindex)) {
    self.characterindex = characterindex;
    if(isDefined(forceselection) && forceselection) {
      self player::spawn_player();
    }
    if(level.draftstage == 0) {
      self thread start_cooldown();
      self close();
    }
    println("<dev string:x16f>" + player.name + "<dev string:x11b>" + characterindex);
    return true;
  } else {
    self player_role::clear();
    println("<dev string:x189>" + self.name + "<dev string:x11b>" + characterindex);
    self util::clientnotify("PositionDraft_Reject");
  }
  return false;
}

function_c10691d1(oldval, newval) {
  player = self;
  player function_3cb7f9e6(newval);
}

client_ready() {
  player = self;
  player function_681d40bc(1);
}

draft_initialize() {
  foreach(player in level.players) {
    player clientfield::set_player_uimodel("PositionDraft.autoSelected", 0);
  }
  while(isloadingcinematicplaying()) {
    wait 1;
  }
}

function_8b9c6c29(starttime) {
  if(gettime() - starttime > int(120 * 1000)) {
    println("<dev string:x1ac>");
    while(true) {
      wait 10;
    }
  }
}

all_players_connected() {
  var_e38cd205 = getnumexpectedplayers(0);
  if(level.players.size < var_e38cd205) {
    return false;
  }
  foreach(player in level.players) {
    if(!player function_ed3756be() && !isbot(player)) {
      return false;
    }
  }
  if(level.players.size <= getgametypesetting(#"draftrequiredclients")) {
    return false;
  }
  return true;
}

wait_for_players() {
  starttime = gettime();
  while(!all_players_connected()) {
    wait 0.2;
    function_8b9c6c29(starttime);
  }
}

decrement(timeremaining) {
  if(level.draftstage == 3 && getdvarint(#"draft_pause", 0) != 0) {
    return timeremaining;
  }

  return timeremaining - 1;
}

draft_run() {
  rat::function_98499d2();

  timeremaining = getgametypesetting(#"drafttime");
  foreach(player in level.players) {
    if(isbot(player)) {
      player player_role::clear();
    }
  }
  if(timeremaining == 0) {
    level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
    ready = 0;
    while(!ready) {
      ready = 1;
      foreach(player in level.players) {
        if(player.pers[# "team"] == "spectator" || isbot(player)) {
          continue;
        }
        characterindex = player player_role::get();
        if(!player_role::is_valid(characterindex) || !player isready()) {
          ready = 0;
        }
      }
      wait 1;
    }
  } else {
    while(timeremaining > 0 && !level.gameended) {
      level clientfield::set_world_uimodel("PositionDraft.timeRemaining", timeremaining);
      timeremaining = decrement(timeremaining);
      level.var_95c2a39c = 1;
      foreach(player in level.players) {
        if(player.pers[# "team"] == "spectator" || isbot(player)) {
          continue;
        }
        if(!player isready()) {
          level.var_95c2a39c = 0;
          break;
        }
      }
      if(level.var_95c2a39c && all_players_connected()) {
        level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
        break;
      }
      wait 1;
    }
    level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
  }
  foreach(player in level.players) {
    if(isbot(player)) {
      assign_remaining_players(player);
      player client_ready();
    }
  }
}

function_61f6afb7() {
  level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
  wait 2;
}

sort_categories(left, right, param) {
  return left.size > right.size;
}

assign_remaining_players(only_assign_player) {
  roles = [];
  playerroletemplatecount = getplayerroletemplatecount(currentsessionmode());
  for(i = 0; i < playerroletemplatecount; i++) {
    fields = getplayerrolefields(i, currentsessionmode());
    if(isDefined(fields) && isDefined(fields.var_fac8128c) && fields.var_fac8128c == 1) {
      if(!isDefined(roles)) {
        roles = [];
      } else if(!isarray(roles)) {
        roles = array(roles);
      }
      roles[roles.size] = i;
    }
  }
  players = getplayers();
  foreach(player in players) {
    if(!isDefined(only_assign_player) || player === only_assign_player) {
      playerrole = player player_role::get();
      if(player_role::is_valid(playerrole)) {
        println("<dev string:x16f>" + player.name + "<dev string:x11b>" + playerrole);
        arrayremovevalue(roles, playerrole);
      }
    }
  }
  players = getplayers();
  foreach(player in players) {
    if(!isDefined(only_assign_player) || player === only_assign_player) {
      playerrole = player player_role::get();
      if(!player_role::is_valid(playerrole)) {
        var_bd84f6a1 = roles[randomint(roles.size)];
        println("<dev string:x1e1>" + player.name + "<dev string:x11b>" + playerrole);
        arrayremovevalue(roles, var_bd84f6a1);
        player select_character(var_bd84f6a1, 1);
      }
    }
  }
}

game_start() {
  timeremaining = getgametypesetting(#"hash_4e4352bd1aaeedfe");
  starttime = gettime();
  if(level.var_95c2a39c == 1) {
    timeremaining++;
  }
  while(timeremaining > 0 && !level.gameended) {
    level clientfield::set_world_uimodel("PositionDraft.timeRemaining", int(timeremaining));
    if(timeremaining == 3) {
      foreach(player in level.players) {
        if(player.hasspawned || player.pers[# "team"] == "spectator") {}
      }
    }
    if(timeremaining == 2) {}
    timeremaining = decrement(timeremaining);
    if(timeremaining == 0) {
      wait 0.75;
      luinotifyevent(#"quick_fade", 0);
      wait 0.25;
      continue;
    }
    wait 1;
  }
}

draft_finalize() {
  level.inprematchperiod = 0;
  foreach(player in level.players) {
    if(player.sessionstate == "playing") {
      player player::spawn_player();
      player[[level.givecustomcharacters]]();
    }
  }
  foreach(player in level.players) {
    player clientfield::set_player_uimodel("PositionDraft.autoSelected", 0);
  }
  luinotifyevent(#"draft_complete", 2, 1, 0);
  level notify(#"draft_complete");
  waitframe(1);
  set_draft_stage(0);

  rat::function_7f411587();
}

set_draft_stage(draftstage) {
  level.draftstage = draftstage;
  level clientfield::set("draft", level.draftstage);
  waitframe(1);

  if(draftstage == 0) {
    println("<dev string:x1fc>");
  } else if(draftstage == 1) {
    println("<dev string:x20f>");
  } else if(draftstage == 2) {
    println("<dev string:x228>");
  } else if(draftstage == 3) {
    println("<dev string:x24a>");
  } else if(draftstage == 5) {
    println("<dev string:x25e>");
  } else if(draftstage == 6) {
    println("<dev string:x277>");
  } else if(draftstage == 7) {
    println("<dev string:x290>");
  }

  if(draftstage == 1) {
    draft_initialize();
    return;
  }
  if(draftstage == 2) {
    wait_for_players();
    return;
  }
  if(draftstage == 3) {
    draft_run();
    return;
  }
  if(draftstage == 4) {
    function_61f6afb7();
    return;
  }
  if(draftstage == 5) {
    assign_remaining_players();
    return;
  }
  if(draftstage == 6) {
    game_start();
    return;
  }
  if(draftstage == 7) {
    draft_finalize();
  }
}

watch_game_ended() {
  level waittill(#"game_ended");
  set_draft_stage(0);
}

start() {
  level endon(#"game_ended");
  level thread watch_game_ended();
  waitframe(1);
  println("<dev string:x2a7>");
  set_draft_stage(1);
  if(!all_players_connected()) {
    set_draft_stage(2);
  }
  set_draft_stage(3);
  if(level.var_95c2a39c == 1) {
    set_draft_stage(4);
  } else {
    set_draft_stage(5);
  }
  set_draft_stage(6);
  set_draft_stage(7);
}

open() {
  player = self;
  assert(isplayer(self));

  autoselection = getdvarint(#"force_char", -1);
  if(player_role::is_valid(autoselection)) {
    player player_role::set(autoselection);
    return;
  }

  player player_role::clear();
  level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
  player clientfield::set_player_uimodel("PositionDraft.stage", 3);
}

close() {
  player = self;
  player spectating::set_permissions();
  self clientfield::set_player_uimodel("PositionDraft.stage", 0);
}