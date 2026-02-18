/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\bots\zm_bot.gsc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\bots\bot;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\ai\zm_ai_utility;
#using scripts\zm_common\zm_utility;
#namespace zm_bot;

function private autoexec __init__system__() {
  system::register(#"zm_bot", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_connect(&on_player_connect);
  level.var_df0a0911 = "bot_tacstate_zm_default";
  level.var_258cdebb = "bot_tacstate_zm_laststand";
  level.var_34eb792d = &handleplayerfasttravel;
  level.zm_bots_scale = getdvarint(#"zm_bots_scale", 1);
}

function on_player_connect() {
  if(isbot(self)) {}
}

function function_e16b5033(actor) {
  base_health = isDefined(actor.basehealth) ? actor.basehealth : 99;
  max_health = actor zm_ai_utility::function_f7014c3d(base_health);
  return max_health / base_health * 1;
}

function function_1f9de69d(var_40b86c4b) {
  if(!isDefined(var_40b86c4b)) {
    return false;
  }

  players = getplayers();

  foreach(player in players) {
    if(isbot(player)) {
      continue;
    }

    currentzone = player zm_utility::get_current_zone();

    if(currentzone === var_40b86c4b) {
      return true;
    }
  }

  return false;
}

function handleplayerfasttravel(player, var_12230d08) {
  player endon(#"death");
  level notify(#"handleplayerfasttravel");
  level endon(#"handleplayerfasttravel");

  if(!isDefined(var_12230d08)) {
    return;
  }

  wait 3;
  currentzone = player zm_utility::get_current_zone();
  currentorigin = player.origin;

  if(!isDefined(currentzone)) {
    return;
  }

  players = getplayers();

  foreach(player in players) {
    if(!isbot(player)) {
      continue;
    }

    var_40b86c4b = player zm_utility::get_current_zone();

    if(var_40b86c4b === currentzone) {
      continue;
    }

    if(function_1f9de69d(var_40b86c4b)) {
      continue;
    }

    if(isDefined(level.var_1dbf5163) && ![[level.var_1dbf5163]](player)) {
      continue;
    }

    if(isDefined(level.var_3c84697b)) {
      player thread[[level.var_3c84697b]](var_12230d08);
      continue;
    }

    player setorigin(currentorigin);
    player dontinterpolate();
  }
}