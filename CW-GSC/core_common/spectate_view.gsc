/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\spectate_view.gsc
***********************************************/

#using script_306215d6cfd5f1f4;
#using scripts\core_common\spawning_squad;
#using scripts\core_common\spectating;
#using scripts\core_common\system_shared;
#using scripts\core_common\territory_util;
#namespace spectate_view;

function private autoexec __init__system__() {
  system::register(#"spectate_view", &preinit, undefined, undefined, #"spectating");
}

function event_handler[ui_menuresponse] codecallback_menuresponse(eventstruct) {
  spawningplayer = self;
  menu = eventstruct.menu;
  response = eventstruct.response;
  targetclientnum = eventstruct.intpayload;

  if(!isDefined(menu)) {
    menu = "";
  }

  if(!isDefined(response)) {
    response = "";
  }

  if(!isDefined(targetclientnum)) {
    targetclientnum = 0;
  }

  if(menu == "Hud_NavigableUI") {
    if(self.sessionstate === "playing") {
      return;
    }

    if(response == "set_spawn_view_overhead" && !level.var_1c15a724) {
      self function_86df9236();
      return;
    }

    if(response == "set_spawn_view_squad" && level.var_1ba484ad == 2 && !level.var_1c15a724) {
      self function_86df9236();
      return;
    }

    if(response == "set_spawn_view_squad" && !level.var_8bace951) {
      self function_888901cb();
    }
  }
}

function private preinit() {
  level.var_5d013349 = currentsessionmode() != 4 && (isDefined(getgametypesetting(#"hash_2c55a3723cd9fdf9")) ? getgametypesetting(#"hash_2c55a3723cd9fdf9") : 0);

  if(level.var_5d013349) {
    level.var_18c9a2d1 = &function_363802ea;
  }
}

function function_500047aa(view) {
  if(self.spectate_view === view) {
    return true;
  }

  return false;
}

function function_363802ea(players, attacker) {
  self function_86df9236();
  self squad_spawn::function_e2ec8e07(1);
}

function function_86df9236() {
  self.spectate_view = 1;
  self squad_spawn::function_a0bd2fd6(1);
}

function function_888901cb() {
  self.spectate_view = 0;
  self squad_spawn::function_a0bd2fd6(0);
}