/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\equipment\advanced_supply_drop.gsc
************************************************************/

#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_gametype_truckwar;
#using scripts\mp\gametypes\br_rewards;
#using scripts\mp\hud_util;
#using scripts\mp\outofbounds;
#using scripts\mp\supers;
#using scripts\mp\utility\game;
#using scripts\mp\utility\script;
#namespace advanced_supply_drop;

function advanced_supply_drop_marker_used(grenade) {
  player = self;
  player endon("disconnect");
  grenade endon("explode_end");

  if(scripts\mp\utility\game::function_d75b73c443421047()) {
    if(!istrue(function_f3bb4f4911a1beb2("limbo", "checkCanTriggerSuper", self, "advanced_supply_drop"))) {
      player scripts\mp\supers::superusefinished(1);
      grenade delete();
      return;
    }
  }

  grenade thread notifyafterframeend("death", "explode_end");
  player thread advanced_supply_drop_refund_on_death(grenade);
  grenade waittill("explode", position);
  player notify("advanced_supply_drop_finished");
  thread advanced_supply_drop_marker_sfx(position);

  if(scripts\mp\outofbounds::ispointinoutofbounds(position)) {
    if(isDefined(grenade)) {
      grenade delete();
    }

    if(isDefined(player.super)) {
      player scripts\mp\supers::superusefinished(1);
    }

    return;
  }

  var_17b727cd5881efd8 = scripts\mp\gametypes\br_rewards::getdropbagspawntypeenum(0, 0, 1, 0, 0, 0);
  player scripts\mp\gametypes\br_rewards::spawndropbagatposition(position, var_17b727cd5881efd8);

  if(isDefined(player.super)) {
    player scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
  }
}

function function_f3e74468f0e5f521(grenade) {
  player = self;
  player endon("disconnect");
  grenade endon("explode_end");
  grenade thread notifyafterframeend("death", "explode_end");
  player thread advanced_supply_drop_refund_on_death(grenade);

  if(isDefined(level.var_e3ccf0898a949bec)) {
    level thread function_22740c19d22b8b6e(player, grenade);
  }

  grenade waittill("explode", position);
  player notify("advanced_supply_drop_finished");
  thread advanced_supply_drop_marker_sfx(position);

  if(scripts\mp\outofbounds::ispointinoutofbounds(position)) {
    if(isDefined(grenade)) {
      grenade delete();
    }

    if(isDefined(player.super)) {
      player scripts\mp\supers::superusefinished(1);
    }

    return;
  }

  spawnpoint = spawnStruct();
  tracecontents = scripts\engine\trace::create_default_contents(1);
  groundorigin = drop_to_ground(position, 10000, -20000, undefined, tracecontents);
  spawnpoint.origin = groundorigin + (0, 0, 50000);
  vehicle = undefined;

  if(isDefined(vehicle)) {
    scripts\mp\gametypes\br_gametype_truckwar::function_20b77fbf1af1a5d(vehicle, player.team, 1);
    level thread scripts\mp\gametypes\br_gametype_truckwar::truck_airdrop(vehicle, groundorigin, vehicle.angles, 1);
  }

  if(isDefined(player.super)) {
    player scripts\mp\supers::superusefinished(undefined, undefined, undefined, 1);
  }
}

function function_22740c19d22b8b6e(player, grenade) {
  player_team = player.team;
  level.var_e3ccf0898a949bec[player_team] = 1;
  scripts\engine\utility::waittill_any_ents(player, "disconnect", grenade, "explode_end", grenade, "explode", grenade, "death");
  level.var_e3ccf0898a949bec[player_team] = undefined;
}

function advanced_supply_drop_refund_on_death(grenade) {
  player = self;
  player endon("disconnect");
  player endon("advanced_supply_drop_finished");
  grenade waittill("death");
  waitframe();

  if(isDefined(player.super)) {
    player scripts\mp\supers::superusefinished(1);
  }
}

function advanced_supply_drop_marker_sfx(position) {
  smoke_sfx = spawn("script_origin", position);
  smoke_sfx playLoopSound("smoke_carepackage_smoke_lp");
  wait 21;
  smoke_sfx playSound("smoke_canister_tail_dissipate");
  smoke_sfx stoploopsound("smoke_carepackage_smoke_lp");
  wait 5;
  smoke_sfx delete();
}