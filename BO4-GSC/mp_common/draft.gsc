/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\draft.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\player\player_role;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\rat_shared;
#include scripts\core_common\serverfield_shared;
#include scripts\core_common\spectating;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\player\player_loadout;

#namespace draft;

autoexec __init__system__() {
  system::register(#"draft", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("world", "draft", 1, 3, "int");
  clientfield::register("clientuimodel", "PositionDraft.stage", 1, 4, "int");
  clientfield::register("clientuimodel", "PositionDraft.autoSelected", 1, 1, "int");
  clientfield::register("clientuimodel", "PositionDraft.cooldown", 1, 5, "int");
  clientfield::register("worlduimodel", "PositionDraft.timeRemaining", 1, 7, "int");
  clientfield::register("worlduimodel", "PositionDraft.waitingForPlayers", 1, 1, "int");
  serverfield::register("PositionDraft.uiLoaded", 1, 1, "int", &function_9f408cf7);
  level.var_5be52892 = 0;
  level.draftstage = 0;

  level.var_5fa54158 = "<dev string:x38>";

  level thread function_e8a5f9ba();

}

function_6bea5139() {
  self notify("<dev string:x3b>");
  self endon("<dev string:x3b>");
  wait 5;
  level.var_5fa54158 = "<dev string:x38>";
}

function_95c03d66(message) {
  if(message == level.var_5fa54158) {
    return;
  }

  level.var_5fa54158 = message;
  println(message);
  level thread function_6bea5139();
}

function_947fe5c4(character) {
  if(character != "<dev string:x38>") {
    var_44dd7e5d = hash(character);
    playerroletemplatecount = getplayerroletemplatecount(currentsessionmode());

    for(i = 0; i < playerroletemplatecount; i++) {
      prtname = function_b14806c6(i, currentsessionmode());

      if(prtname == var_44dd7e5d) {
        self select_character(i, 1);
        return;
      }
    }
  }
}

function_e8a5f9ba() {
  current = getdvarstring(#"character", "<dev string:x38>");

  if(current != "<dev string:x38>") {
    while(true) {
      autoselection = getdvarstring(#"character");

      if(autoselection != "<dev string:x38>" && autoselection != current) {
        foreach(player in level.players) {
          player function_947fe5c4(autoselection);
        }
      }

      wait 1;
    }
  }
}

  function is_enabled() {
    autoselectcharacter = getdvarint(#"auto_select_character", -1);

    if(player_role::is_valid(autoselectcharacter)) {
      return 0;
    }

    if(level.disableclassselection) {
      return 0;
    }

    if(isDefined(level.var_b3c4b7b7) && level.var_b3c4b7b7) {
      return 0;
    }

    if(util::function_8570168d()) {
      return 0;
    }

    return getgametypesetting(#"draftenabled");
  }

is_draft_this_round() {
  if(!is_enabled()) {
    return false;
  }

  if(getgametypesetting(#"drafteveryround") == 1) {
    return true;
  }

  if(util::isoneround()) {
    return true;
  }

  return util::isfirstround();
}

function_2c7b2ff() {
  player = self;
  return isDefined(player.var_7d68fce3) && player.var_7d68fce3 > 0;
}

start_cooldown() {
  player = self;
  assert(isplayer(player));
  player endon(#"disconnect", #"hash_7fa9c275efb510e2");
  cooldowntime = getgametypesetting(#"hash_2b88c6ac064e9c59");
  cooldownendtime = cooldowntime * 1000 + gettime();

  while(gettime() < cooldownendtime) {
    timeleft = (cooldownendtime - gettime()) / 1000;
    player clientfield::set_player_uimodel("PositionDraft.cooldown", int(timeleft));
    player.var_7d68fce3 = timeleft;
    wait 1;
  }

  player.var_7d68fce3 = 0;
  player clientfield::set_player_uimodel("PositionDraft.cooldown", 0);
}

clear_cooldown() {
  player = self;
  assert(isplayer(player));
  player notify(#"hash_7fa9c275efb510e2");
  player.var_7d68fce3 = 0;
  player clientfield::set_player_uimodel("PositionDraft.cooldown", 0);
}

function_904deeb2() {
  player = self;

  if(player function_2c7b2ff()) {
    return false;
  }

  if(level.draftstage == 0) {
    return true;
  }

  if(level.draftstage == 3 && !player isready()) {
    return true;
  }

  return false;
}

can_select_character(characterindex) {
  if(!function_904deeb2()) {
    return false;
  }

  maxuniqueroles = getgametypesetting(#"maxuniquerolesperteam", characterindex);

  if(maxuniqueroles == 0) {
    return false;
  }

  rolecount = 0;

  foreach(player in level.players) {
    if(player == self) {
      continue;
    }

    playercharacterindex = player player_role::get();

    if(isDefined(player.pers[#"team"]) && player.pers[#"team"] == self.pers[#"team"] && playercharacterindex == characterindex) {
      rolecount++;

      if(rolecount >= maxuniqueroles) {
        return false;
      }
    }
  }

  return true;
}

select_character(characterindex, forceselection, var_8a239568) {
  if(!player_role::is_valid(characterindex)) {
    return false;
  }

  assert(player_role::is_valid(characterindex));

  if(!(isDefined(forceselection) && forceselection) && !can_select_character(characterindex)) {
    return false;
  }

  if(self player_role::set(characterindex)) {
    if(level.draftstage == 0) {
      self thread start_cooldown();
      self close();
    } else if(isDefined(level.var_9205f2e8)) {
      game_time = gettime();
      var_891e514a = {
        #xuid: self getxuid(), 
        #character_index: characterindex, 
        #game_time: game_time, 
        #var_6fa2fd60: game_time - level.var_9205f2e8, 
        #var_b53f57e1: var_8a239568
      };
      function_92d1707f(#"hash_3a95edd667fd3e7d", var_891e514a);
    }

    return true;
  } else if(!util::function_8570168d()) {
    self player_role::clear();
    self util::clientnotify("PositionDraft_Reject");
  }

  return false;
}

function_ca33311e() {
  level endon(#"game_ended", #"draft_complete");

  while(true) {
    foreach(player in level.players) {
      player resetinactivitytimer();
    }

    wait 5;
  }
}

function_9f408cf7(oldval, newval) {
  player = self;

  function_95c03d66("<dev string:x4e>" + player.name + "<dev string:x58>");

    player function_4b8d2217(newval);
}

client_ready() {
  player = self;
  player setisready(1);
}

draft_initialize() {
  level.inprematchperiod = 1;

  foreach(player in level.players) {
    player clientfield::set_player_uimodel("PositionDraft.autoSelected", 0);
  }

  level.var_b318d3d1 = getgametypesetting(#"drafttime") + getgametypesetting(#"hash_4e4352bd1aaeedfe");
  function_ee80d2e8(int(max(0, level.var_b318d3d1)));
}

function_c5394b83(starttime, seconds) {
  if(gettime() - starttime > int(seconds * 1000)) {
    println("<dev string:x66>");
    return true;
  }

  return false;
}

all_players_connected() {
  var_5c6783e9 = getnumexpectedplayers(0);

  if(level.players.size < var_5c6783e9) {

    function_95c03d66("<dev string:x9d>" + var_5c6783e9 + "<dev string:xc6>" + level.players.size);

      return false;
  }

  foreach(player in level.players) {
    if(!player function_9b95ed9f() && !isbot(player)) {

      function_95c03d66("<dev string:xde>" + player.name + "<dev string:xfd>");

        return false;
    }
  }

  return true;
}

function_d255fb3e() {
  foreach(player in level.players) {
    if(player function_9b95ed9f()) {
      return true;
    }
  }

  return false;
}

function_21f5a2c1() {
  var_e8cb777 = getgametypesetting(#"draftrequiredclients");

  if(var_e8cb777 <= 0) {
    return true;
  }

  foreach(team, _ in level.teams) {
    teamcount[team] = 0;
  }

  foreach(player in level.players) {
    if(isDefined(level.teams[player.team])) {
      teamcount[player.team]++;
    }
  }

  foreach(team, _ in level.teams) {
    if(teamcount[team] < var_e8cb777) {

      function_95c03d66("<dev string:x113>" + var_e8cb777 + "<dev string:x14d>" + team + "<dev string:x152>" + teamcount[team]);

        return false;
    }
  }

  return true;
}

wait_for_players() {
  while(!function_d255fb3e()) {
    wait 0.2;
  }

  level.var_b318d3d1 = getgametypesetting(#"drafttime") + getgametypesetting(#"hash_4e4352bd1aaeedfe") + 20;
  function_ee80d2e8(int(max(0, level.var_b318d3d1)));
  starttime = gettime();

  while(!all_players_connected()) {
    wait 0.2;

    if(function_c5394b83(starttime, 20)) {
      break;
    }
  }

  level.var_b318d3d1 = getgametypesetting(#"drafttime") + getgametypesetting(#"hash_4e4352bd1aaeedfe");
  function_ee80d2e8(int(max(0, level.var_b318d3d1)));
}

decrement(timeremaining) {

  if(level.draftstage == 3 && getdvarint(#"draft_pause", 0) != 0) {
    return timeremaining;
  }

    level.var_b318d3d1 -= 1;
  function_ee80d2e8(int(max(0, level.var_b318d3d1)));
  return timeremaining - 1;
}

pause_draft() {
  level.var_297320a8 = 1;
}

function_3e648d9b() {
  level.var_297320a8 = 0;
}

draft_run() {

  rat::function_b4f2a076();

    timeremaining = getgametypesetting(#"drafttime");
  function_ee80d2e8(int(max(0, level.var_b318d3d1)));

  foreach(player in level.players) {
    if(isbot(player)) {
      player player_role::clear();
    }

    class_num = player stats::get_stat(#"selectedcustomclass");
    player setplayerstateloadoutweapons(class_num);
  }

  if(timeremaining == 0) {
    level.var_9205f2e8 = gettime();
    level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
    ready = 0;

    while(!ready) {
      ready = 1;

      foreach(player in level.players) {
        if(player.pers[#"team"] == #"spectator" || isbot(player)) {
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
    while(!function_d255fb3e()) {
      wait 1;
    }

    level.var_9205f2e8 = gettime();

    while(timeremaining > 0 && !level.gameended) {
      level clientfield::set_world_uimodel("PositionDraft.timeRemaining", timeremaining);
      timeremaining = decrement(timeremaining);
      level.var_5be52892 = 1;
      var_97286e53 = 1;

      foreach(player in level.players) {
        if(player.pers[#"team"] == #"spectator") {
          continue;
        }

        var_97286e53 = 0;

        if(isbot(player)) {
          continue;
        }

        if(!player isready()) {
          level.var_5be52892 = 0;
          break;
        }
      }

      if(level.var_5be52892 && !var_97286e53 && all_players_connected()) {
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
    }

    player client_ready();
  }
}

function_404f08f3() {
  level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
  wait 2;
}

sort_categories(left, right, param) {
  return left.size > right.size;
}

assign_remaining_players(only_assign_player) {
  teams = [];
  characters = [];
  validcharacters = [];
  categorymap = [];
  playerroletemplatecount = getplayerroletemplatecount(currentsessionmode());

  for(i = 0; i < playerroletemplatecount; i++) {
    playerrolefields = getplayerrolefields(i, currentsessionmode());
    characterfields = getcharacterfields(i, currentsessionmode());
    characters[i] = spawnStruct();
    characters[i].index = i;
    characters[i].available = 0;
    characters[i].enabled = function_f4bf7e3f(i) && isDefined(playerrolefields.var_422e172f) && playerrolefields.var_422e172f && (!util::function_8570168d() || isDefined(characterfields.var_49a55967) && characterfields.var_49a55967) && !isDefined(characterfields.requireddvar);
    characters[i].category = player_role::get_category_for_index(i);
    characters[i].var_9a6db9eb = getgametypesetting(#"maxuniquerolesperteam", i);

    if(characters[i].enabled && player_role::is_valid(i) && characters[i].category != "default" && characters[i].var_9a6db9eb != 0) {
      characters[i].available = 1;

      if(!isDefined(validcharacters)) {
        validcharacters = [];
      } else if(!isarray(validcharacters)) {
        validcharacters = array(validcharacters);
      }

      validcharacters[validcharacters.size] = characters[i];

      if(!isDefined(categorymap[characters[i].category])) {
        categorymap[characters[i].category] = categorymap.size;
      }
    }
  }

  if(getdvarint(#"hash_595a93ece672a7da", -1) == 1) {
    foreach(player in level.players) {
      if(!isDefined(only_assign_player)) {
        validcharacters = array::randomize(validcharacters);
        player select_character(validcharacters[0].index, 1, 0);
        continue;
      }

      if(only_assign_player == player) {
        validcharacters = array::randomize(validcharacters);
        player select_character(validcharacters[0].index, 1, 0);
        break;
      }
    }

    return;
  }

  foreach(player in level.players) {
    if(player.pers[#"team"] == #"spectator") {
      continue;
    }

    if(!isDefined(teams[player.team])) {
      teams[player.team] = [];
    }

    if(!isDefined(teams[player.team])) {
      teams[player.team] = [];
    } else if(!isarray(teams[player.team])) {
      teams[player.team] = array(teams[player.team]);
    }

    teams[player.team][teams[player.team].size] = player;
  }

  foreach(team in teams) {
    println("<dev string:x15d>" + team[0].team);
    playersneedingassignment = [];

    foreach(character in validcharacters) {
      character.available = 0;

      if(character.var_9a6db9eb > 0) {
        character.available = 1;
      }
    }

    println("<dev string:x18d>");

    foreach(player in team) {
      characterindex = player player_role::get();
      println("<dev string:x1aa>" + player.name + "<dev string:x1bc>" + characterindex);
    }

      foreach(player in team) {
        characterindex = player player_role::get();

        if(player_role::is_valid(characterindex)) {
          characters[characterindex].available = 0;
          continue;
        }

        if(!isDefined(only_assign_player)) {
          player player_role::clear();

          if(!isDefined(playersneedingassignment)) {
            playersneedingassignment = [];
          } else if(!isarray(playersneedingassignment)) {
            playersneedingassignment = array(playersneedingassignment);
          }

          playersneedingassignment[playersneedingassignment.size] = player;
          player clientfield::set_player_uimodel("PositionDraft.autoSelected", 1);
          continue;
        }

        if(only_assign_player == player) {
          player player_role::clear();

          if(!isDefined(playersneedingassignment)) {
            playersneedingassignment = [];
          } else if(!isarray(playersneedingassignment)) {
            playersneedingassignment = array(playersneedingassignment);
          }

          playersneedingassignment[playersneedingassignment.size] = player;
        }
      }

    println("<dev string:x1d1>");

    foreach(player in playersneedingassignment) {
      categories = [];
      categorynames = getarraykeys(categorymap);

      for(i = 0; i < categorymap.size; i++) {
        categories[i] = [];
      }

      foreach(character in characters) {
        if(character.category == "default") {
          continue;
        }

        if(character.available == 1) {
          categoryindex = categorymap[character.category];

          if(!isDefined(categories[categoryindex])) {
            categories[categoryindex] = [];
          } else if(!isarray(categories[categoryindex])) {
            categories[categoryindex] = array(categories[categoryindex]);
          }

          categories[categoryindex][categories[categoryindex].size] = character.index;
        }
      }

      categories = array::randomize(categories);
      categories = array::merge_sort(categories, &sort_categories);
      selectedcharacter = 0;

      if(categories.size > 0) {
        selectedcategory = categories[0];
        selectedcharacter = array::random(selectedcategory);
      }

      if(validcharacters.size == 0) {
        println("<dev string:x1f4>");
        globallogic::exit_level();

        while(true) {
          wait 10;
        }
      }

      if(!isDefined(selectedcharacter) || selectedcharacter == 0) {
        randomcharacter = array::random(validcharacters);
        selectedcharacter = randomcharacter.index;
      }

      oldspecialistindex = player getspecialistindex();

      if(isDefined(oldspecialistindex) && oldspecialistindex != selectedcharacter) {
        player.pers[#"class"] = undefined;
      }

      println("<dev string:x227>" + player.name + "<dev string:x243>" + selectedcharacter);

      if(player select_character(selectedcharacter, 1, 1)) {
        characters[selectedcharacter].available = 0;
      }
    }
  }
}

game_start() {
  timeremaining = getgametypesetting(#"hash_4e4352bd1aaeedfe");
  starttime = gettime();

  if(level.var_5be52892 == 1) {
    timeremaining++;
  }

  if(level.gametype !== "bounty") {
    foreach(player in level.players) {
      if(player.hasspawned || player.pers[#"team"] == #"spectator") {
        player globallogic_audio::set_music_on_player("spawnPreRise");
      }
    }
  }

  level thread globallogic::sndsetmatchsnapshot(0);

  while(timeremaining > 0 && !level.gameended) {
    level clientfield::set_world_uimodel("PositionDraft.timeRemaining", int(timeremaining));

    if(timeremaining == 2) {
      globallogic::mpintro_visionset_deactivate_func();
    }

    timeremaining = decrement(timeremaining);

    if(timeremaining == 0) {
      wait 0.75;
      luinotifyevent(#"quick_fade", 0);
      wait 0.25;
      continue;
    }

    wait 1;
  }

  level notify(#"hash_4c62fe02843b1a98");
  level thread globallogic::sndsetmatchsnapshot(0);
}

draft_finalize() {
  level.inprematchperiod = 0;

  foreach(player in level.players) {
    if(player.sessionstate == "spectator" && player.team != #"spectator") {
      assign_remaining_players(player);
    }

    if(player.sessionstate == "playing") {
      println("<dev string:x24b>" + player.name + "<dev string:x266>" + player.curclass + "<dev string:x271>" + player getspecialistindex());
      player loadout::give_loadout(player.team, player.curclass);
      player.pers[#"lastcurclass"] = player.curclass;
      player.pers[#"lastspecialistindex"] = player.curclass;
      player enableweapons();
      player val::reset(#"spawn_player", "freezecontrols");
      player val::reset(#"spawn_player", "disablegadgets");
      player callback::callback(#"prematch_end");
    }
  }

  level callback::callback(#"prematch_end");

  foreach(player in level.players) {
    player clientfield::set_player_uimodel("PositionDraft.autoSelected", 0);
    player clientfield::set_player_uimodel("PositionDraft.stage", 0);
  }

  luinotifyevent(#"draft_complete", 2, 1, 0);
  level notify(#"draft_complete");
  set_draft_stage(0);

  rat::function_6aa20375();

}

set_draft_stage(draftstage) {
  level.draftstage = draftstage;
  level clientfield::set("draft", level.draftstage);
  waitframe(1);

  if(draftstage == 0) {
    println("<dev string:x285>");
  } else if(draftstage == 1) {
    println("<dev string:x29a>");
  } else if(draftstage == 2) {
    println("<dev string:x2b5>");
  } else if(draftstage == 3) {
    println("<dev string:x2d9>");
  } else if(draftstage == 5) {
    println("<dev string:x2ef>");
  } else if(draftstage == 6) {
    println("<dev string:x30a>");
  } else if(draftstage == 7) {
    println("<dev string:x325>");
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
    function_404f08f3();
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
  level thread function_ca33311e();
  waitframe(1);
  println("<dev string:x33e>");
  set_draft_stage(1);
  set_draft_stage(3);

  if(level.var_5be52892 == 1) {
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

  if(isDefined(level.var_edd52efc)) {
    self[[level.var_edd52efc]]();
    return;
  }

  autoselection = getdvarint(#"auto_select_character", -1);

  if(player_role::is_valid(autoselection)) {
    player player_role::set(autoselection);
    return;
  }

    player allowspectateallteams(0);
  player allowspectateteam("freelook", 0);
  player allowspectateteam(#"none", 1);
  player allowspectateteam("localplayers", 0);
  player player_role::clear();
  level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
  player clientfield::set_player_uimodel("PositionDraft.stage", 8);
}

close() {
  player = self;
  player spectating::set_permissions();
  self clientfield::set_player_uimodel("PositionDraft.stage", 0);
}