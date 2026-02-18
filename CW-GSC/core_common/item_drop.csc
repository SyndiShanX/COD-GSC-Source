/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\item_drop.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\item_inventory;
#using scripts\core_common\item_inventory_util;
#using scripts\core_common\item_world;
#using scripts\core_common\item_world_util;
#using scripts\core_common\system_shared;
#namespace item_drop;

function private autoexec __init__system__() {
  system::register(#"item_drop", &preinit, undefined, undefined, #"item_world");
}

function private preinit() {
  if(!item_world_util::use_item_spawns()) {
    return;
  }

  function_2777823f();
  level.item_spawn_drops = [];
  level.var_624588d5 = [];
  level.var_2b5a36e1 = [];
}

function private function_2777823f() {
  clientfield::register("missile", "dynamic_item_drop_falling", 1, 1, "int", undefined, 0, 0);
  clientfield::register("missile", "dynamic_item_drop_count", 1, 10, "int", &function_fd47982d, 0, 0);
  clientfield::register("missile", "dynamic_item_drop", 1, 4, "int", &function_a517a859, 0, 0);
  clientfield::register("missile", "dynamic_item_timing_out", 1, 1, "int", &function_45f94325, 0, 0);
  clientfield::register("scriptmover", "dynamic_item_drop_falling", 1, 1, "int", undefined, 0, 0);
  clientfield::register("scriptmover", "dynamic_item_drop_count", 1, 10, "int", &function_fd47982d, 0, 0);
  clientfield::register("scriptmover", "dynamic_item_drop", 1, 4, "int", &function_a517a859, 0, 0);
  clientfield::register("scriptmover", "dynamic_stash", 1, 2, "int", &function_e7bb925a, 0, 0);
  clientfield::register("scriptmover", "dynamic_stash_type", 1, 2, "int", &function_63226f88, 0, 0);
  clientfield::register("scriptmover", "dynamic_item_timing_out", 1, 1, "int", &function_45f94325, 0, 0);
}

function private function_67189b6b(localclientnum, newval) {
  if(self.id === 32767 && !(newval == 2 || newval == 3)) {
    return;
  }

  stashitem = (newval & 4) != 0;
  newval &= -5;
  self.falling = self clientfield::get("dynamic_item_drop_falling");

  if(newval == 0) {
    if(isDefined(self) && isDefined(self.networkid) && isDefined(level.item_spawn_drops[self.networkid])) {
      arrayremoveindex(level.item_spawn_drops, self.networkid, 1);
      arrayremoveindex(level.var_2b5a36e1, self.networkid, 1);
    }

    return;
  }

  if(newval == 1) {
    assert(self.id < 2048);

    if(self.id >= 2048) {
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
    }

    arrayremovevalue(level.item_spawn_drops, undefined, 1);
    level.item_spawn_drops[self.networkid] = self;
    item_world::function_b78a9820(localclientnum);
    player = function_5c10bd79(localclientnum);
    player item_world::show_item(localclientnum, self.networkid, !stashitem);

    if(isPlayer(player) && distance2dsquared(self.origin, player.origin) <= sqr(1350)) {
      player.var_506495f9 = 1;
      clientdata = item_world::function_a7e98a1a(localclientnum);
      model = self item_world::function_7731d23c(clientdata);

      if(isDefined(model)) {
        model show();
        item_world::function_84964a9e(localclientnum, self.itementry, model, self.networkid);
      }
    }

    item_inventory::function_b1136fc8(localclientnum, self);
    return;
  }

  if(newval == 2 || newval == 3) {
    self.hidetime = gettime();
    self.networkid = item_world_util::function_1f0def85(self);

    if(newval == 2) {
      item_world::play_pickup_fx(localclientnum, self);
      item_inventory::function_31868137(localclientnum, self);
    } else {
      item_inventory::function_d1da833d(localclientnum, self);
    }

    item_world::function_b78a9820(localclientnum);
    item_world::function_2990e5f(localclientnum, self);

    if(isDefined(self.networkid) && getdvarint(#"hash_99bb0233e482c77", 0)) {
      level.item_spawn_drops[self.networkid] = undefined;
    }

    player = function_5c10bd79(localclientnum);
    player item_world::hide_item(localclientnum, self.networkid);
  }
}

function private function_1a45bc2a(item) {
  if(!isDefined(item)) {
    return false;
  }

  if(!isDefined(item.type) || item.type != # "scriptmover" && item.type != # "missile") {
    return false;
  }

  return true;
}

function function_fd47982d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.id) || !isDefined(self.itementry)) {
    return;
  }

  self function_1fe1281(fieldname, bwastimejump);
}

function function_1fe1281(localclientnum, newval) {
  if(!isDefined(self)) {
    return;
  }

  assert(isDefined(self.id));
  assert(isDefined(self.itementry));

  if(!isDefined(self.id) || !isDefined(self.itementry)) {
    return;
  }

  if(self.itementry.itemtype === # "ammo" || self.itementry.itemtype === # "armor" || self.itementry.itemtype === # "weapon") {
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

function function_a517a859(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  self.id = self getitemindex();
  item_world::function_1b11e73c();

  if(!function_1a45bc2a(self)) {
    return;
  }

  self function_67189b6b(fieldname, bwastimejump);
}

function function_e7bb925a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  item_world::function_1b11e73c();

  if(bwastimejump == 1) {
    self.var_bad13452 = 0;
  } else if(bwastimejump == 2) {
    self.var_bad13452 = 2;
  }

  level.var_624588d5[level.var_624588d5.size] = self;
  player = function_5c10bd79(fieldname);

  if(isPlayer(player) && distance2dsquared(self.origin, player.origin) <= sqr(1350)) {
    item_world::function_a4886b1e(fieldname, undefined, self);
  }
}

function function_63226f88(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  item_world::function_1b11e73c();

  if(bwastimejump == 0) {
    self.stash_type = 0;
    return;
  }

  if(bwastimejump == 1) {
    self.stash_type = 1;
    return;
  }

  if(bwastimejump == 2) {
    self.stash_type = 2;
  }
}

function function_45f94325(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  item_world::function_1b11e73c();

  if(!isDefined(self.networkid)) {
    self.networkid = item_world_util::function_1f0def85(self);
  }

  level.var_2b5a36e1[self.networkid] = self;
  self.var_f4522f8c = getservertime(bwastimejump) + randomintrange(0, 500);
}