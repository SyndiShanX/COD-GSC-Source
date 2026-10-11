/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\item_drop.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#namespace item_drop;

function autoexec main() {
  if(!isDefined(level.item_drops)) {
    level.item_drops = [];
  }

  level thread watch_level_drops();
  waitframe(1);
  callback::on_actor_killed(&actor_killed_check_drops);
}

function add_drop(name, model, callback) {
  if(!isDefined(level.item_drops)) {
    level.item_drops = [];
  }

  if(!isDefined(level.item_drops[name])) {
    level.item_drops[name] = spawnStruct();
  }

  level.item_drops[name].name = name;
  level.item_drops[name].model = model;
  level.item_drops[name].callback = callback;
}

function add_drop_onaikilled(name, dropchance) {
  if(!isDefined(level.item_drops)) {
    level.item_drops = [];
  }

  if(!isDefined(level.item_drops[name])) {
    level.item_drops[name] = spawnStruct();
  }

  level.item_drops[name].name = name;
  level.item_drops[name].onaikilled = dropchance;
}

function add_drop_spawnpoints(name, spawnpoints) {
  if(!isDefined(level.item_drops)) {
    level.item_drops = [];
  }

  if(!isDefined(level.item_drops[name])) {
    level.item_drops[name] = spawnStruct();
  }

  level.item_drops[name].name = name;
  level.item_drops[name].spawnpoints = spawnpoints;
}

function actor_killed_check_drops(params) {
  if(level.script != "sp_proto_characters" && level.script != "challenge_bloodbath") {
    return;
  }

  if(is_true(self.item_drops_checked)) {
    return;
  }

  self.item_drops_checked = 1;
  drop = array::random(level.item_drops);

  if(isDefined(drop.onaikilled)) {
    drop.onaikilled = getdvarfloat("<dev string:x38>" + drop.name, 0);
  }

  if(getdvarint(#"scr_drop_autorecover", 0)) {
    killer = self.dds_dmg_attacker;

    if(isDefined(killer)) {
      if(isDefined(drop.callback)) {
        multiplier = self actor_drop_multiplier();

        if(!killer[[drop.callback]](multiplier)) {
          return;
        }
      }

      playSoundAtPosition(#"fly_supply_bag_pick_up", killer.origin);
    }

    return;
  }

  if(isDefined(drop.onaikilled) && randomfloat(1) < drop.onaikilled) {
    origin = self.origin + (0, 0, 30);
    newdrop = spawn_drop(drop, origin);
    newdrop.multiplier = self actor_drop_multiplier();
    level.item_drops_current[level.item_drops_current.size] = newdrop;
    newdrop thread watch_player_pickup();
  }
}

function actor_drop_multiplier() {
  min_mult = getdvarfloat(#"scr_drop_default_min", 0);

  if(isDefined(self.drop_min_multiplier)) {
    min_mult = self.drop_min_multiplier;
  }

  max_mult = getdvarfloat(#"scr_drop_default_max", 0);

  if(isDefined(self.drop_max_multiplier)) {
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

  while(true) {
    wait 15;

    if(level.item_drops_current.size < 1 && level.item_drops.size > 0) {
      drop = array::random(level.item_drops);

      if(isDefined(drop.spawnpoints)) {
        origin = array::random(drop.spawnpoints);
        newdrop = spawn_drop(drop, origin);
        level.item_drops_current[level.item_drops_current.size] = newdrop;
        newdrop thread watch_player_pickup();
      }
    }
  }
}

function spawn_drop(drop, origin) {
  nd = spawnStruct();
  nd.drop = drop;
  nd.origin = origin;
  nd.model = spawn("script_model", nd.origin);
  nd.model setModel(drop.model);
  nd.model thread spin_it();
  playSoundAtPosition(#"fly_supply_bag_drop", origin);
  return nd;
}

function spin_it() {
  angle = 0;
  time = 0;
  self endon(#"death");

  while(isDefined(self)) {
    angle = time * 90;
    self.angles = (0, angle, 0);
    waitframe(1);
    time += float(function_60d95f53()) / 1000;
  }
}

function watch_player_pickup() {
  trigger = spawn("trigger_radius", self.origin, 0, 60, 60);
  self.pickuptrigger = trigger;

  while(isDefined(self)) {
    waitresult = trigger waittill(#"trigger");

    if(waitresult.activator thread pickup(self)) {
      break;
    }
  }

  trigger delete();
}

function pickup(drop) {
  if(isDefined(drop.drop.callback)) {
    multiplier = 1;

    if(isDefined(drop.multiplier)) {
      multiplier = drop.multiplier;
    }

    if(!self[[drop.drop.callback]](multiplier)) {
      return false;
    }
  }

  playSoundAtPosition(#"fly_supply_bag_pick_up", self.origin);
  drop.model delete();
  arrayremovevalue(level.item_drops_current, drop);
  return true;
}