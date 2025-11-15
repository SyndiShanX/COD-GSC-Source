/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\player.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\item_supply_drop;

#namespace wz_player;

autoexec __init__system__() {
  system::register(#"wz_player", &__init__, undefined, undefined);
}

__init__() {
  callback::on_spawned(&on_player_spawned);
}

on_player_spawned() {
  self callback::on_grenade_fired(&on_grenade_fired);
}

on_grenade_fired(params) {
  grenade = params.projectile;
  weapon = params.weapon;

  switch (weapon.name) {
    case #"flare_gun":
      grenade function_4861487f(weapon, self);
      grenade thread function_cd8ee3c5();
      break;
    case #"flare_gun_veh":
      grenade function_4861487f(weapon, self);
      grenade thread function_f3edce9a();
    default:
      break;
  }
}

function_4861487f(weapon, player) {
  if(!isDefined(self)) {
    return;
  }

  if(!self grenade_safe_to_throw(player, weapon)) {
    self thread makegrenadedudanddestroy();
    return;
  }
}

function_cd8ee3c5() {
  self endon(#"grenade_dud");
  waitresult = self waittill(#"explode", #"death");

  if(waitresult._notify == #"explode") {
    trace = groundtrace(waitresult.position, waitresult.position + (0, 0, -20000), 0, self, 0);

    if(isDefined(trace[#"position"]) && trace[#"surfacetype"] != #"none") {
      org = trace[#"position"];
      item_supply_drop::drop_supply_drop(org, 1);
    }
  }
}

function_f3edce9a() {
  self endon(#"grenade_dud");
  waitresult = self waittill(#"explode", #"death");

  if(waitresult._notify == #"explode") {
    position = isDefined(waitresult.position) ? waitresult.position : waitresult.attacker.origin;
    trace = groundtrace(position, position + (0, 0, -20000), 0, self, 0);

    if(isDefined(trace[#"position"]) && trace[#"surfacetype"] != #"none") {
      org = trace[#"position"];
      vehicletypes = array(#"vehicle_t8_mil_tank_wz_black", #"vehicle_t8_mil_tank_wz_green", #"vehicle_t8_mil_tank_wz_grey", #"vehicle_t8_mil_tank_wz_tan");
      item_supply_drop::drop_supply_drop(org, 1, 1, vehicletypes[randomint(vehicletypes.size)]);
    }
  }
}

grenade_safe_to_throw(player, weapon) {
  return true;
}

makegrenadedudanddestroy() {
  self endon(#"death");
  self notify(#"grenade_dud");
  self makegrenadedud();
  wait 3;

  if(isDefined(self)) {
    self delete();
  }
}

debug_star(origin, seconds, color) {
  if(!isDefined(seconds)) {
    seconds = 1;
  }

  if(!isDefined(color)) {
    color = (1, 0, 0);
  }

  frames = int(20 * seconds);
  debugstar(origin, frames, color);
}

