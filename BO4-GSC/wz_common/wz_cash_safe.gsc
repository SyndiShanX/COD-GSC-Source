/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\wz_cash_safe.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\system_shared;
#include scripts\mp_common\dynent_world;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\item_drop;
#include scripts\mp_common\item_inventory;
#include scripts\mp_common\item_world;

#namespace wz_cash_safe;

autoexec __init__system__() {
  system::register(#"wz_cash_safe", &__init__, undefined, undefined);
}

__init__() {
  level.var_a6a3e12a = [];
  clientfield::register_clientuimodel("hudItems.depositing", 13000, 1, "int", 0);

  if(getdvarint(#"hash_7074ed0f04816b75", 0)) {
    clientfield::register("allplayers", "wz_cash_carrying", 13000, 1, "int");
  }

  level thread setup_safes();
  callback::on_player_killed(&on_player_killed);

  callback::on_game_playing(&function_a6eac3b7);

}

private on_player_killed() {
  self clientfield::set_player_uimodel("hudItems.depositing", 0);
}

function_ed66923(targetname, count) {
  if(isDefined(level.var_a6a3e12a[targetname])) {
    return;
  }

  level.var_a6a3e12a[targetname] = count;
}

private setup_safes() {
  item_world::function_1b11e73c();

  foreach(targetname, count in level.var_a6a3e12a) {
    function_189f45d2(targetname);
  }

  item_world::function_4de3ca98();

  if(getdvarint(#"hash_7074ed0f04816b75", 0)) {
    item_drop::function_f3f9788a(#"cash_item_500", 1);
    level.var_590e0497 = [];

    foreach(targetname, count in level.var_a6a3e12a) {
      activate_safes(targetname, count);
    }

    level thread function_fb346efb();
    return;
  }

  foreach(targetname, count in level.var_a6a3e12a) {
    function_189f45d2(targetname);
  }
}

private function_189f45d2(targetname) {
  safes = getdynentarray(targetname);

  foreach(safe in safes) {
    setdynentstate(safe, 1);
  }
}

private activate_safes(targetname, count) {
  safes = getdynentarray(targetname);

  while(safes.size > count) {
    i = randomint(safes.size);
    safes[i] hide_safe();
    arrayremoveindex(safes, i);
  }

  foreach(safe in safes) {
    safe activate_safe();
  }
}

private function_fb346efb() {
  level flagsys::wait_till(#"hash_405e46788e83af41");
  lastcircleindex = level.deathcircles.size - 1;

  while(level.deathcircleindex < lastcircleindex) {
    wait 1;
  }

  finalcircle = level.deathcircles[level.deathcircleindex];
  level.var_590e0497 = [];

  foreach(targetname, count in level.var_a6a3e12a) {
    function_3387f756(targetname, finalcircle.origin, finalcircle.radius);
  }
}

private function_3387f756(targetname, origin, radius) {
  safes = getdynentarray(targetname);
  radiussq = radius * radius;

  foreach(safe in safes) {
    if(distance2dsquared(origin, safe.origin) <= radiussq) {
      safe activate_safe();
      continue;
    }

    safe hide_safe();
  }
}

private activate_safe() {
  setdynentstate(self, 0);
  self.var_e7823894 = 1;
  self.canuse = &function_c92a5584;
  self.onbeginuse = &function_97eb71f0;
  self.var_263c4ded = &function_3d49217f;
  self.onuse = &function_7c5a1e82;
  self.onusecancel = &function_368adf4f;
  level.var_590e0497[level.var_590e0497.size] = self;
}

private hide_safe() {
  setdynentstate(self, 2);
}

private function_c92a5584(activator) {
  if(!isDefined(activator) || !isstruct(activator.inventory) || !isarray(activator.inventory.items)) {
    return false;
  }

  foreach(item in activator.inventory.items) {
    if(!isDefined(item) || !isstruct(item.itementry) || item.itementry.itemtype !== #"cash") {
      continue;
    }

    return true;
  }

  return false;
}

private function_97eb71f0(activator) {
  if(isDefined(activator.var_8a022726)) {
    activator.var_8a022726 sethintstring(#"");
  }

  activator clientfield::set_player_uimodel("hudItems.depositing", 1);
}

private function_3d49217f(activator) {
  var_22aec194 = activator function_2cef7d98();

  if(isDefined(var_22aec194)) {
    return var_22aec194.itementry.casttime;
  }

  return undefined;
}

private function_7c5a1e82(activator, stateindex, var_9bdcfcd8) {
  self clear_prompts(activator);

  if(!isDefined(activator) || !isstruct(activator.inventory) || !isarray(activator.inventory.items)) {
    return false;
  }

  var_22aec194 = activator function_2cef7d98();

  if(isDefined(var_22aec194)) {
    scoreamount = var_22aec194.itementry.amount;
    initialcount = var_22aec194.count;
    activator item_inventory::use_inventory_item(var_22aec194.networkid, 1);

    if(var_22aec194.count < initialcount) {
      [
        [level._setteamscore]
      ](activator.team, [
        [level._getteamscore]
      ](activator.team) + scoreamount);
      playsoundatposition(#"hash_2b58f77dbea4ade1", self.origin);
      globallogic_score::function_889ed975(activator, scoreamount, 0, 0);
      activator stats::function_bb7eedf0(#"score", scoreamount);
      activator stats::function_b7f80d87(#"score", scoreamount);
      return true;
    }
  }

  return false;
}

private function_2cef7d98() {
  var_22aec194 = undefined;

  foreach(item in self.inventory.items) {
    if(!isDefined(item) || !isstruct(item.itementry) || item.itementry.itemtype !== #"cash") {
      continue;
    }

    if(!isDefined(var_22aec194) || var_22aec194.itementry.amount < item.itementry.amount) {
      var_22aec194 = item;
    }
  }

  return var_22aec194;
}

private function_368adf4f(activator) {
  self clear_prompts(activator);
}

private clear_prompts(activator) {
  bundle = function_489009c1(self);
  state = function_ffdbe8c2(self);
  activator.var_8a022726 dynent_world::function_836af3b3(bundle, state);
  activator clientfield::set_player_uimodel("hudItems.depositing", 0);
}

private function_a6eac3b7() {
  while(true) {
    wait 0.25;
    dvarstr = getdvarstring(#"scr_give_player_score", "<dev string:x38>");

    if(dvarstr == "<dev string:x38>") {
      continue;
    }

    setdvar(#"devgui_deathcircle", "<dev string:x38>");
    args = strtok(dvarstr, "<dev string:x3b>");

    if(args.size == 2) {
      player = getentbynum(int(args[0]));

      if(isplayer(player)) {
        [
          [level._setteamscore]
        ](player.team, [
          [level._getteamscore]
        ](player.team) + int(args[1]));
      }
    }
  }
}

