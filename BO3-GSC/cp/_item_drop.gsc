/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_item_drop.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\util_shared;
#namespace item_drop;

function autoexec main() {
  if(!isdefined(level.item_drops)) {
    level.item_drops = [];
  }
  level thread watch_level_drops();
  wait(0.05);
  callback::on_actor_killed( & actor_killed_check_drops);
}

function add_drop(name, model, callback) {
  if(!isdefined(level.item_drops)) {
    level.item_drops = [];
  }
  if(!isdefined(level.item_drops[name])) {
    level.item_drops[name] = spawnstruct();
  }
  level.item_drops[name].name = name;
  level.item_drops[name].model = model;
  level.item_drops[name].callback = callback;
}

function add_drop_onaikilled(name, dropchance) {
  if(!isdefined(level.item_drops)) {
    level.item_drops = [];
  }
  if(!isdefined(level.item_drops[name])) {
    level.item_drops[name] = spawnstruct();
  }
  level.item_drops[name].name = name;
  level.item_drops[name].onaikilled = dropchance;
}

function add_drop_spawnpoints(name, spawnpoints) {
  if(!isdefined(level.item_drops)) {
    level.item_drops = [];
  }
  if(!isdefined(level.item_drops[name])) {
    level.item_drops[name] = spawnstruct();
  }
  level.item_drops[name].name = name;
  level.item_drops[name].spawnpoints = spawnpoints;
}

function actor_killed_check_drops(params) {
  if(level.script != "sp_proto_characters" && level.script != "challenge_bloodbath") {
    return;
  }
  if(isdefined(self.item_drops_checked) && self.item_drops_checked) {
    return;
  }
  self.item_drops_checked = 1;
  drop = array::random(level.item_drops);
  if(isdefined(drop.onaikilled)) {
    drop.onaikilled = getdvarfloat("" + drop.name);
  }
  if(getdvarint("scr_drop_autorecover")) {
    killer = self.dds_dmg_attacker;
    if(isdefined(killer)) {
      if(isdefined(drop.callback)) {
        multiplier = self actor_drop_multiplier();
        if(!killer[[drop.callback]](multiplier)) {
          return;
        }
      }
      playsoundatposition("fly_supply_bag_pick_up", killer.origin);
    }
  } else if(isdefined(drop.onaikilled) && randomfloat(1) < drop.onaikilled) {
    origin = self.origin + vectorscale((0, 0, 1), 30);
    newdrop = spawn_drop(drop, origin);
    newdrop.multiplier = self actor_drop_multiplier();
    level.item_drops_current[level.item_drops_current.size] = newdrop;
    newdrop thread watch_player_pickup();
  }
}

function actor_drop_multiplier() {
  min_mult = getdvarfloat("scr_drop_default_min");
  if(isdefined(self.drop_min_multiplier)) {
    min_mult = self.drop_min_multiplier;
  }
  max_mult = getdvarfloat("scr_drop_default_max");
  if(isdefined(self.drop_max_multiplier)) {
    max_mult = self.drop_max_multiplier;
  }
  if(min_mult < max_mult) {
    return randomfloatrange(min_mult, max_mult);
  }
  return min_mult;
}

function watch_level_drops() {
  level.item_drops_current = [];
  level flag::wait_till("all_players_spawned");
  while (true) {
    wait(15);
    if(level.item_drops_current.size < 1 && level.item_drops.size > 0) {
      drop = array::random(level.item_drops);
      if(isdefined(drop.spawnpoints)) {
        origin = array::random(drop.spawnpoints);
        newdrop = spawn_drop(drop, origin);
        level.item_drops_current[level.item_drops_current.size] = newdrop;
        newdrop thread watch_player_pickup();
      }
    }
  }
}

function spawn_drop(drop, origin) {
  nd = spawnstruct();
  nd.drop = drop;
  nd.origin = origin;
  nd.model = spawn("script_model", nd.origin);
  nd.model setmodel(drop.model);
  nd.model thread spin_it();
  playsoundatposition("fly_supply_bag_drop", origin);
  return nd;
}

function spin_it() {
  angle = 0;
  time = 0;
  self endon("death");
  while (isdefined(self)) {
    angle = time * 90;
    self.angles = (0, angle, 0);
    wait(0.05);
    time = time + 0.05;
  }
}

function watch_player_pickup() {
  trigger = spawn("trigger_radius", self.origin, 0, 60, 60);
  self.pickuptrigger = trigger;
  while (isdefined(self)) {
    trigger waittill("trigger", player);
    if(player thread pickup(self)) {
      break;
    }
  }
  trigger delete();
}

function pickup(drop) {
  if(isdefined(drop.drop.callback)) {
    multiplier = 1;
    if(isdefined(drop.multiplier)) {
      multiplier = drop.multiplier;
    }
    if(!self[[drop.drop.callback]](multiplier)) {
      return false;
    }
  }
  playsoundatposition("fly_supply_bag_pick_up", self.origin);
  drop.model delete();
  arrayremovevalue(level.item_drops_current, drop);
  return true;
}