/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: wz_common\player.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\item_supply_drop;
#using scripts\core_common\system_shared;
#namespace wz_player;

function private autoexec __init__system__() {
  system::register(#"wz_player", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  callback::on_spawned(&on_player_spawned);
}

function on_player_spawned() {
  self callback::on_grenade_fired(&on_grenade_fired);
}

function on_grenade_fired(params) {
  grenade = params.projectile;
  weapon = params.weapon;

  switch (weapon.name) {
    case # "flare_gun":
      grenade function_4861487f(weapon, self);
      grenade thread function_cd8ee3c5();
      break;
    default:
      break;
  }
}

function function_4861487f(weapon, player) {
  if(!isDefined(self)) {
    return;
  }

  if(!self grenade_safe_to_throw(player, weapon)) {
    self thread makegrenadedudanddestroy();
    return;
  }
}

function function_cd8ee3c5() {
  self endon(#"grenade_dud");
  waitresult = self waittill(#"explode", #"death");

  if(waitresult._notify == # "explode") {
    trace = groundtrace(waitresult.position, waitresult.position + (0, 0, -20000), 0, self, 0);

    if(isDefined(trace[#"position"]) && trace[#"surfacetype"] != # "none") {
      org = trace[#"position"];
      item_supply_drop::drop_supply_drop(org, 1);
    }
  }
}

function grenade_safe_to_throw(player, weapon) {
  return true;
}

function makegrenadedudanddestroy() {
  self endon(#"death");
  self notify(#"grenade_dud");
  self makegrenadedud();
  wait 3;

  if(isDefined(self)) {
    self delete();
  }
}

function debug_star(origin, seconds, color) {
  if(!isDefined(seconds)) {
    seconds = 1;
  }

  if(!isDefined(color)) {
    color = (1, 0, 0);
  }

  frames = int(20 * seconds);
  debugstar(origin, frames, color);
}