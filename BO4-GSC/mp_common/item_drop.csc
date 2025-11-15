/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\item_drop.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\item_inventory;
#include scripts\mp_common\item_inventory_util;
#include scripts\mp_common\item_world;
#include scripts\mp_common\item_world_util;

#namespace item_drop;

autoexec __init__system__() {
  system::register(#"item_drop", &__init__, undefined, undefined);
}

__init__() {
  if(getgametypesetting(#"useitemspawns") == 0) {
    return;
  }

  clientfield::register("missile", "dynamic_item_drop", 1, 2, "int", &function_a517a859, 0, 0);
  clientfield::register("missile", "dynamic_item_drop_count", 11000, 10, "int", &function_fd47982d, 0, 0);
  clientfield::register("scriptmover", "dynamic_item_drop", 1, 2, "int", &function_a517a859, 0, 0);
  clientfield::register("scriptmover", "dynamic_item_drop_count", 11000, 10, "int", &function_fd47982d, 0, 0);
  clientfield::register("missile", "dynamic_item_drop", 10000, 3, "int", &function_a517a859, 0, 0);
  clientfield::register("scriptmover", "dynamic_item_drop", 10000, 3, "int", &function_a517a859, 0, 0);
  clientfield::register("scriptmover", "dynamic_stash", 1, 2, "int", &function_e7bb925a, 0, 0);
  clientfield::register("scriptmover", "dynamic_stash_type", 1, 2, "int", &function_63226f88, 0, 0);
  level.item_spawn_drops = [];
  level.var_624588d5 = [];
  level.var_d49a1a10 = [];
  level thread function_b8f6e02f();
}

private function_b8f6e02f() {
  while(true) {
    item_world::function_1b11e73c();
    reset = isDefined(level flagsys::get(#"item_world_reset")) && level flagsys::get(#"item_world_reset");
    var_d68d9a4d = level.var_d49a1a10.size;

    for(index = 0; index < var_d68d9a4d; index++) {
      var_5c6af5cf = level.var_d49a1a10[index];
      level.var_d49a1a10[index] = undefined;

      if(!isDefined(var_5c6af5cf) || !isDefined(var_5c6af5cf.item)) {
        continue;
      }

      if(var_5c6af5cf.reset !== reset) {
        continue;
      }

      profilestart();
      var_5c6af5cf.item function_67189b6b(var_5c6af5cf.localclientnum, var_5c6af5cf.newval);
      profilestop();
    }

    level.var_d49a1a10 = [];

    if(reset) {
      break;
    }

    waitframe(1);
  }
}

private function_67189b6b(localclientnum, newval) {
  stashitem = (newval&4) != 0;
  newval &= -5;

  if(newval == 0) {
    if(isDefined(self) && isDefined(self.networkid) && isDefined(level.item_spawn_drops[self.networkid])) {
      arrayremoveindex(level.item_spawn_drops, self.networkid, 1);
    }

    if(isDefined(self) && isDefined(self.networkid) && isDefined(level.var_5b2a8d88[self.networkid])) {
      level.var_5b2a8d88[self.networkid] = 0;
    }

    return;
  }

  if(newval == 1) {
    assert(self.id < 1024);

    if(self.id >= 1024) {
      return;
    }

    self.networkid = item_world_util::function_1f0def85(self);
    self.hidetime = 0;

    if(stashitem) {
      self.hidetime = -1;
    }

    if(self.id != 32767 && self.id < function_8322cf16()) {
      self.itementry = function_b1702735(self.id).itementry;
      self function_1fe1281(localclientnum, clientfield::get("dynamic_item_drop_count"));

      if(self.itementry.name == #"sig_blade_wz_item" && isDefined(level.var_5b2a8d88)) {
        level.var_5b2a8d88[self.networkid] = 1;
      }
    }

    arrayremovevalue(level.item_spawn_drops, undefined, 1);
    level.item_spawn_drops[self.networkid] = self;
    item_world::function_b78a9820(localclientnum);
    player = function_5c10bd79(localclientnum);

    if(isplayer(player) && distance2dsquared(self.origin, player.origin) <= 1350 * 1350) {
      player.var_506495f9 = 1;
    }

    item_inventory::function_b1136fc8(localclientnum, self);
    player item_world::show_item(localclientnum, self.networkid, !stashitem);
    return;
  }

  if(newval == 2) {
    self.hidetime = gettime();
    self.networkid = item_world_util::function_1f0def85(self);
    item_inventory::function_31868137(localclientnum, self);
    item_world::function_b78a9820(localclientnum);
    item_world::function_2990e5f(localclientnum, self);

    if(isDefined(self.networkid) && getdvarint(#"hash_99bb0233e482c77", 0)) {
      level.item_spawn_drops[self.networkid] = undefined;
    }

    player = function_5c10bd79(localclientnum);
    player item_world::hide_item(localclientnum, self.networkid);
  }
}

private function_1a45bc2a(item) {
  if(!isDefined(item)) {
    return false;
  }

  if(!isDefined(item.type) || item.type != #"scriptmover" && item.type != #"missile") {
    return false;
  }

  return true;
}

function_fd47982d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.id) || !isDefined(self.itementry)) {
    return;
  }

  self function_1fe1281(localclientnum, newval);
}

function_1fe1281(localclientnum, newval) {
  if(!isDefined(self)) {
    return;
  }

  assert(isDefined(self.id));
  assert(isDefined(self.itementry));

  if(!isDefined(self.id) || !isDefined(self.itementry)) {
    return;
  }

  if(self.itementry.itemtype === #"ammo" || self.itementry.itemtype === #"armor" || self.itementry.itemtype === #"weapon") {
    if(isDefined(self.amount) && newval !== self.amount) {
      item_inventory::function_31868137(localclientnum, self);
    }

    self.amount = newval;
    self.count = 1;
  } else {
    if(isDefined(self.count) && newval !== self.count) {
      item_inventory::function_31868137(localclientnum, self);
    }

    self.amount = 0;
    self.count = newval;
  }

  item_world::function_b78a9820(localclientnum);
}

function_a517a859(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self.id = self getitemindex();

  if(!item_world::function_1b11e73c()) {
    return;
  }

  if(!function_1a45bc2a(self)) {
    return;
  }

  self function_67189b6b(localclientnum, newval);
}

function_e7bb925a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(!item_world::function_1b11e73c()) {
    return;
  }

  if(newval == 1) {
    self.var_bad13452 = 0;
  } else if(newval == 2) {
    self.var_bad13452 = 2;
  }

  level.var_624588d5[level.var_624588d5.size] = self;
  player = function_5c10bd79(localclientnum);

  if(isplayer(player) && distance2dsquared(self.origin, player.origin) <= 1350 * 1350) {
    item_world::function_a4886b1e(localclientnum, undefined, self);
  }
}

function_63226f88(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");

  if(!item_world::function_1b11e73c()) {
    return;
  }

  if(newval == 0) {
    self.stash_type = 0;
    return;
  }

  if(newval == 1) {
    self.stash_type = 1;
    return;
  }

  if(newval == 2) {
    self.stash_type = 2;
  }
}