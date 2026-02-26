/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\menus.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\rank_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\globallogic;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\load;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace menus;

function private autoexec __init__system__() {
  system::register(#"menus", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_start_gametype(&init);
  callback::on_connect(&on_player_connect);
}

function init() {
  game.menu = [];
  game.menu[#"menu_team"] = "ChangeTeam";
  game.menu[#"menu_start_menu"] = "StartMenu_Main";
  game.menu[#"menu_class"] = "class";
  game.menu[#"menu_changeclass"] = "mobile_armory_loadout";
  game.menu[#"menu_changeclass_offline"] = "mobile_armory_loadout";
  game.menu[#"menu_draft"] = "PositionDraft";

  foreach(str_team in level.teams) {
    game.menu["menu_changeclass_" + str_team] = "mobile_armory_loadout";
  }

  game.menu[#"menu_controls"] = "ingame_controls";
  game.menu[#"menu_options"] = "ingame_options";
  game.menu[#"menu_leavegame"] = "popup_leavegame";
}

function on_player_connect() {
  self thread on_menu_response();
}

function on_menu_response() {
  self endon(#"disconnect");

  for(;;) {
    waitresult = self waittill(#"menuresponse");
    menu = waitresult.menu;
    response = waitresult.response;
    intpayload = waitresult.intpayload;

    if(response == "menu_opened") {
      if(menu == "StartMenu_Main") {
        util::function_62e48a();
      }
    }

    if(response == "back") {
      self closeingamemenu();

      if(level.console) {
        if(menu == game.menu[#"menu_changeclass"] || menu == game.menu[#"menu_changeclass_offline"] || menu == game.menu[#"menu_team"] || menu == game.menu[#"menu_controls"]) {
          if(isDefined(level.teams[self.pers[#"team"]])) {
            self openmenu(game.menu_start_menu);
          }
        }
      }

      continue;
    }

    if(response == "changeteam" && level.allow_teamchange) {
      self closeingamemenu();
      self openmenu(game.menu[#"menu_team"]);
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
        self closeingamemenu();
        uploadstats();
        level thread globallogic::forceend();
      } else {
        self closeingamemenu();
        self iprintln(#"mp/host_endgame_response");
      }

      continue;
    }

    if(response == # "first_snapshot") {
      if(level flag::get(#"hud_initialized")) {
        globallogic_ui::function_3f278444();
      }

      level flag::set(#"hud_initialized");
      continue;
    }

    if(response == # "restartmission") {
      level function_c35a1bfc();
      continue;
    }

    if(response == # "restartcheckpoint") {
      level function_d7c2965();
      continue;
    }

    if(response == # "hash_30abbfec4597c191") {
      skipto::function_cfb483b7();
      continue;
    }

    if(response == "autocontrol") {
      self[[level.autocontrolplayer]]();
      continue;
    }

    if(response == "typing_complete") {
      level notify(#"typing_complete", {
        #line: intpayload
      });
      continue;
    }

    if(response == "personnel_profile_closed") {
      level notify(#"personnel_profile_closed", {
        #isconfirmed: intpayload
      });
      continue;
    }

    if(response == "note_closed") {
      level notify(#"note_closed");
      continue;
    }

    if(response == "evidence_board_option_selected") {
      level notify(#"evidence_board_option_selected", {
        #optindex: intpayload
      });
      continue;
    }

    if(response == "mission_option_selected") {
      level notify(#"mission_option_selected", {
        #optindex: intpayload
      });
      continue;
    }

    if(response == "dialog_tree_option_selected") {
      level notify(#"dialog_tree_option_selected", {
        #optindex: intpayload
      });
      continue;
    }

    if(response == "dialog_tree_kbm_key_selected") {
      level notify(#"dialog_tree_kbm_key_selected", {
        #optindex: intpayload
      });
      continue;
    }

    if(response == "lui_unpause_game") {
      level notify(#"lui_unpause_game", {
        #success: intpayload == 1
      });
      continue;
    }

    if(response == "objective_splash" && intpayload === 0) {
      level notify(#"objectives_shown");
      continue;
    }

    if(response == # "lui_button") {
      level notify(#"lui_button", {
        #button: "" + intpayload
      });
      continue;
    }

    if(menu == game.menu[#"menu_team"] && level.allow_teamchange) {
      switch (response) {
        case # "autoassign":
          self[[level.autoassign]](1);
          break;
        case # "spectator":
          self[[level.spectator]]();
          break;
        default:
          self[[level.teammenu]](response);
          break;
      }

      continue;
    }

    if(menu == game.menu[#"menu_draft"]) {
      self[[level.draftmenu]](response, intpayload);
      continue;
    }

    if(menu == game.menu[#"menu_changeclass"] || menu == game.menu[#"menu_changeclass_offline"]) {
      if(response != "back" && response != "cancel" && (!isDefined(self.var_efc9bc54) || !self.var_efc9bc54)) {
        self closeingamemenu();
        self.selectedclass = 1;
        self[[level.curclass]](response);
      } else {
        self[[level.curclass]](response);
      }

      continue;
    }

    if(menu == "spectate") {
      player = util::getplayerfromclientnum(waitresult.intpayload);

      if(isDefined(player)) {
        self setcurrentspectatorclient(player);
      }
    }
  }
}

function private function_c35a1bfc() {
  self notify("6dfd273785998fbf");
  self endon("6dfd273785998fbf");
  level flag::set("restart_mission");
  player = getplayers()[0];
  player endon(#"disconnect");
  globallogic_ui::function_cdbb5c49(1, 1);
  player = getplayers()[0];
  player val::set(#"hash_1828a61368b4014c", "show_crosshair", 0);
  player val::set(#"hash_1828a61368b4014c", "freezecontrols", 1);
  player val::set(#"hash_1828a61368b4014c", "takedamage", 0);
  player val::set(#"hash_1828a61368b4014c", "allowdeath", 0);
  player val::set(#"hash_1828a61368b4014c", "pre_load_ghost", 1);
  util::wait_network_frame(1);

  if(is_true(level.level_ending)) {
    return;
  }

  player savegame::set_player_data("saved_weapon", undefined);
  player savegame::set_player_data("saved_weapon_attachemnts", undefined);
  player savegame::set_player_data("saved_weapondata", undefined);
  player savegame::set_player_data("lives", undefined);
  player savegame::set_player_data("savegame_score", undefined);
  player savegame::set_player_data("savegame_kills", undefined);
  player savegame::set_player_data("savegame_assists", undefined);
  player savegame::set_player_data("savegame_incaps", undefined);
  player savegame::set_player_data("savegame_revives", undefined);
  player savegame::function_81534803(#"transient");
  player clearallnoncheckpointdata();
  world.var_b86bf11e = undefined;
  globallogic_ui::function_760546ce();
  missionname = savegame::function_8136eb5a();
  mapbundle = function_2717b55f(missionname);

  if(isDefined(mapbundle) && isDefined(mapbundle.var_a04dfce6)) {
    var_a04dfce6 = mapbundle.var_a04dfce6;

    if(var_a04dfce6 != "") {
      skipto::function_8722a51a(var_a04dfce6, 1);
      map_restart();
    }

    return;
  }

  missionrestart();
}

function private function_d7c2965() {
  self notify("7d026682bb29f30d");
  self endon("7d026682bb29f30d");
  level flag::set("restart_checkpoint");
  player = getplayers()[0];
  player endon(#"death");
  globallogic_ui::function_cdbb5c49(1, 1);
  level.var_5be43b2d = 1;
  player val::set(#"hash_69a35e48bb13280c", "show_crosshair", 0);
  player val::set(#"hash_69a35e48bb13280c", "freezecontrols", 1);
  player val::set(#"hash_69a35e48bb13280c", "takedamage", 0);
  player val::set(#"hash_69a35e48bb13280c", "allowdeath", 0);
  player val::set(#"hash_69a35e48bb13280c", "pre_load_ghost", 1);

  if(gettime() - (isDefined(level.var_6ca9b5fe) ? level.var_6ca9b5fe : 0) < 3000) {
    wait 0.33;
  }

  globallogic_ui::function_760546ce();

  if(isDefined(player) && player isplayinganimscripted()) {
    player stopanimscripted(undefined, 1);
    waitframe(1);
  }

  if(is_true(level.level_ending)) {
    return;
  }

  function_f31af5ab();
}