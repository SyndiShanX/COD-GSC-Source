/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_menus.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_globallogic;
#using scripts\cp\gametypes\_save;
#using scripts\shared\callbacks_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\system_shared;
#namespace menus;

function autoexec __init__sytem__() {
  system::register("menus", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype(&init);
  callback::on_connect(&on_player_connect);
}

function init() {
  game["menu_team"] = "ChangeTeam";
  game["menu_start_menu"] = "StartMenu_Main";
  game["menu_class"] = "class";
  game["menu_changeclass"] = "ChooseClass_InGame";
  game["menu_changeclass_offline"] = "ChooseClass_InGame";
  foreach(team in level.teams) {
    game["menu_changeclass_" + team] = "ChooseClass_InGame";
  }
  game["menu_controls"] = "ingame_controls";
  game["menu_options"] = "ingame_options";
  game["menu_leavegame"] = "popup_leavegame";
}

function on_player_connect() {
  self thread on_menu_response();
  self setdstat("completedFirstTimeFlow", 1);
}

function function_521a4b1f(player) {
  if(!isDefined(player)) {
    return;
  }
  player setcontrolleruimodelvalue("MusicPlayer.state", "stop");
  player notify("music_stop");
  player.musicplaying = 0;
  if(isDefined(player.var_c6ff6155)) {
    alias = tablelookupcolumnforrow("gamedata/tables/common/music_player.csv", player.var_c6ff6155, 1);
    player stopsound(alias);
  }
}

function on_menu_response() {
  self endon("disconnect");
  for(;;) {
    self waittill("menuresponse", menu, response);
    if(response == "back") {
      self closeingamemenu();
      if(level.console) {
        if(menu == game["menu_changeclass"] || menu == game["menu_changeclass_offline"] || menu == game["menu_team"] || menu == game["menu_controls"]) {
          if(isDefined(level.teams[self.pers["team"]])) {
            self openmenu(game["menu_start_menu"]);
          }
        }
      }
      continue;
    }
    if(response == "changeteam" && level.allow_teamchange == "1") {
      self closeingamemenu();
      self openmenu(game["menu_team"]);
    }
    if(response == "endgame") {
      if(level.splitscreen) {
        level.skipvote = 1;
        if(!level.gameended) {
          level thread globallogic::forceend();
        }
      }
      continue;
    }
    if(response == "killserverpc") {
      level thread globallogic::killserverpc();
      continue;
    }
    if(response == "endround") {
      if(!level.gameended) {
        self globallogic::gamehistoryplayerquit();
        self closeingamemenu();
        if(self ishost()) {
          foreach(player in getplayers()) {
            player givemissingunlocktokens();
            var_62f6e136 = player getdstat("unlocks", 0);
            var_7f6b97ce = player getdstat("PlayerStatsList", "CAREER_TOKENS", "statValue");
            if(var_62f6e136 > var_7f6b97ce) {
              player addplayerstat("career_tokens", var_62f6e136 - var_7f6b97ce);
            }
          }
          uploadstats();
          level thread globallogic::forceend();
        }
      } else {
        self closeingamemenu();
        self iprintln(&"MP_HOST_ENDGAME_RESPONSE");
      }
      foreach(player in getplayers()) {
        if(player.musicplaying === 1) {
          function_521a4b1f(player);
        }
      }
      continue;
    }
    if(response == "restartmission") {
      var_c722c1b3 = [];
      var_c722c1b3[0] = "KILLS";
      var_c722c1b3[1] = "SCORE";
      var_c722c1b3[2] = "ASSISTS";
      var_c722c1b3[3] = "INCAPS";
      var_c722c1b3[4] = "REVIVES";
      foreach(player in level.players) {
        player savegame::set_player_data("saved_weapon", undefined);
        player savegame::set_player_data("saved_weapondata", undefined);
        player savegame::set_player_data("lives", undefined);
        player savegame::set_player_data("savegame_score", undefined);
        player savegame::set_player_data("savegame_kills", undefined);
        player savegame::set_player_data("savegame_assists", undefined);
        player savegame::set_player_data("savegame_incaps", undefined);
        player savegame::set_player_data("savegame_revives", undefined);
        if(!isDefined(getrootmapname())) {
          continue;
        }
        foreach(stat in var_c722c1b3) {
          statvalue = player getdstat("PlayerStatsList", stat, "statValue");
          player setdstat("PlayerStatsByMap", getrootmapname(), "currentStats", stat, statvalue);
        }
        player clearallnoncheckpointdata();
      }
      world.var_bf966ebd = undefined;
      missionrestart();
      continue;
    }
    if(menu == game["menu_team"] && level.allow_teamchange == "1") {
      switch (response) {
        case "autoassign": {
          self[[level.autoassign]](1);
          break;
        }
        case "spectator": {
          self[[level.spectator]]();
          break;
        }
        default: {
          self[[level.teammenu]](response);
          break;
        }
      }
      continue;
    }
    if(menu == game["menu_changeclass"] || menu == game["menu_changeclass_offline"]) {
      if(response != "back" && response != "cancel" && (!isDefined(self.disableclasscallback) || !self.disableclasscallback)) {
        self closeingamemenu();
        self.selectedclass = 1;
        self[[level.curclass]](response);
      } else {
        self[[level.curclass]](response);
      }
      continue;
    }
    if(menu == "spectate") {
      player = util::getplayerfromclientnum(int(response));
      if(isDefined(player)) {
        self setcurrentspectatorclient(player);
      }
    }
  }
}