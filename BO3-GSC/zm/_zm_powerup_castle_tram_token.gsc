/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_powerup_castle_tram_token.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_melee_weapon;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_powerup_castle_tram_token;

function autoexec __init__sytem__() {
  system::register("zm_powerup_castle_tram_token", & __init__, undefined, undefined);
}

function __init__() {
  register_clientfields();
  zm_powerups::register_powerup("castle_tram_token", & function_bcb6924e);
  if(tolower(getdvarstring("g_gametype")) != "zcleansed") {
    zm_powerups::add_zombie_powerup("castle_tram_token", "p7_zm_ctl_115_fuse_pickup", & "ZM_CASTLE_TRAM_TOKEN_POWERUP", & function_56739ab1, 1, 0, 0);
    zm_powerups::powerup_set_statless_powerup("castle_tram_token");
  }
  callback::on_connect( & on_player_connect);
  callback::on_spawned( & on_player_spawned);
  thread function_6dd86f90();
}

function register_clientfields() {
  clientfield::register("toplayer", "has_castle_tram_token", 1, 1, "int");
  clientfield::register("toplayer", "ZM_CASTLE_TRAM_TOKEN_ACQUIRED", 1, 1, "int");
  clientfield::register("scriptmover", "powerup_fuse_fx", 1, 1, "int");
  for(i = 0; i < 4; i++) {
    clientfield::register("world", ("player" + i) + "hasItem", 1, 1, "int");
  }
  clientfield::register("clientuimodel", "zmInventory.player_using_sprayer", 1, 1, "int");
  clientfield::register("clientuimodel", "zmInventory.widget_sprayer", 1, 1, "int");
}

function function_bcb6924e(player) {
  if(!player clientfield::get_to_player("has_castle_tram_token")) {
    player clientfield::set_to_player("has_castle_tram_token", 1);
    player thread show_infotext_for_duration("ZM_CASTLE_TRAM_TOKEN_ACQUIRED", 3.5);
    player thread function_1cb39173("zmInventory.player_using_sprayer", "zmInventory.widget_sprayer", 1);
    level thread function_a52da515(player);
    level clientfield::set(("player" + player.entity_num) + "hasItem", 1);
    level thread function_4c1f0ef2();
    if(!player.var_dc5e13e5) {
      player thread zm_equipment::show_hint_text(&"ZM_CASTLE_TRAM_TOKEN_HINT", 4);
      player.var_dc5e13e5 = 1;
    }
  }
}

function function_ed4d87a3(player) {
  if(player clientfield::get_to_player("has_castle_tram_token")) {
    player notify("tram_token_used");
    return true;
  }
  return false;
}

function function_83ef471e(player) {
  return player clientfield::get_to_player("has_castle_tram_token");
}

function function_56739ab1() {
  if(isDefined(level.var_6e2e91a0) && level.var_6e2e91a0) {
    return 0;
  }
  var_db175e = !level flag::get("tram_moving") && !level flag::get("tram_docked") && !level flag::get("tram_cooldown");
  return var_db175e;
}

function function_4c1f0ef2() {
  level.var_6e2e91a0 = 1;
  level waittill("between_round_over");
  level.var_6e2e91a0 = undefined;
}

function show_infotext_for_duration(str_infotext, n_duration) {
  self clientfield::set_to_player(str_infotext, 1);
  wait(n_duration);
  self clientfield::set_to_player(str_infotext, 0);
}

function private function_1cb39173(var_1d640f59, str_widget_clientuimodel, var_18bfcc38) {
  level notify("widget_ui_override");
  self endon("disconnect");
  if(var_18bfcc38) {
    if(isDefined(var_1d640f59)) {
      self thread clientfield::set_player_uimodel(var_1d640f59, 1);
    }
    n_show_ui_duration = 3.5;
  } else {
    n_show_ui_duration = 3.5;
  }
  self thread clientfield::set_player_uimodel(str_widget_clientuimodel, 1);
  level util::waittill_any_ex(n_show_ui_duration, "widget_ui_override", self, "disconnect");
  self thread clientfield::set_player_uimodel(str_widget_clientuimodel, 0);
}

function function_a52da515(player) {
  var_507b79e0 = player.entity_num;
  str_result = player util::waittill_any_return("tram_token_used", "bled_out", "death", "disconnect");
  if(str_result === "tram_token_used") {
    player clientfield::set_to_player("has_castle_tram_token", 0);
    player clientfield::set_player_uimodel("zmInventory.player_using_sprayer", 0);
  }
  level clientfield::set(("player" + var_507b79e0) + "hasItem", 0);
}

function on_player_connect() {
  self.var_dc5e13e5 = 0;
}

function on_player_spawned() {}

function function_6dd86f90() {
  level flagsys::wait_till("");
  wait(1);
  zm_devgui::add_custom_devgui_callback( & function_9293606a);
  adddebugcommand("");
  adddebugcommand("");
}

function function_9293606a(cmd) {
  players = getplayers();
  retval = 0;
  switch (cmd) {
    case "": {
      zm_devgui::zombie_devgui_give_powerup(cmd, 1);
      break;
    }
    case "": {
      zm_devgui::zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
      break;
    }
  }
  return retval;
}