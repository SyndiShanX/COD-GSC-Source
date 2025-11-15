/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\oob.gsc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\hostmigration_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;

#namespace oob;

autoexec __init__system__() {
  system::register(#"out_of_bounds", &__init__, undefined, undefined);
}

__init__() {
  level.oob_triggers = [];

  if(sessionmodeismultiplayergame()) {
    level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
    level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 3000);
    level.oob_damage_interval_ms = getdvarint(#"oob_damage_interval_ms", 3000);
    level.oob_damage_per_interval = getdvarint(#"oob_damage_per_interval", 999);
    level.oob_max_distance_before_black = getdvarint(#"oob_max_distance_before_black", 100000);
    level.oob_time_remaining_before_black = getdvarint(#"oob_time_remaining_before_black", -1);
  } else if(sessionmodeiswarzonegame()) {
    level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
    level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 10000);
    level.oob_damage_interval_ms = getdvarint(#"oob_damage_interval_ms", 3000);
    level.oob_damage_per_interval = getdvarint(#"oob_damage_per_interval", 999);
    level.oob_max_distance_before_black = getdvarint(#"oob_max_distance_before_black", 100000);
    level.oob_time_remaining_before_black = getdvarint(#"oob_time_remaining_before_black", -1);
  } else {
    level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 6000);
    level.oob_damage_interval_ms = getdvarint(#"oob_damage_interval_ms", 1000);
    level.oob_damage_per_interval = getdvarint(#"oob_damage_per_interval", 5);
    level.oob_max_distance_before_black = getdvarint(#"oob_max_distance_before_black", 400);
    level.oob_time_remaining_before_black = getdvarint(#"oob_time_remaining_before_black", 1000);
  }

  level.oob_damage_interval_sec = float(level.oob_damage_interval_ms) / 1000;
  var_4eb37b66 = getEntArray("trigger_out_of_bounds", "classname");

  if(var_4eb37b66.size) {
    level thread function_e1076862();
  }

  var_ad08787d = getEntArray("trigger_out_of_bounds_new", "classname");
  var_4ed8e045 = arraycombine(var_4eb37b66, var_ad08787d, 1, 0);

  foreach(trigger in var_4ed8e045) {
    trigger thread run_oob_trigger();
  }

  val::register("disable_oob", 1, "$self", &disableplayeroob, "$value");
  val::default_value("disable_oob", 0);
  clientfield::register("toplayer", "out_of_bounds", 1, 5, "int");
  clientfield::register("toplayer", "nonplayer_oob_usage", 1, 1, "int");
}

function_e1076862() {
  level flagsys::wait_till("<dev string:x38>");
  iprintlnbold("<dev string:x4e>");
}

run_oob_trigger() {
  self.oob_players = [];

  if(!isDefined(level.oob_triggers)) {
    level.oob_triggers = [];
  } else if(!isarray(level.oob_triggers)) {
    level.oob_triggers = array(level.oob_triggers);
  }

  level.oob_triggers[level.oob_triggers.size] = self;
  self thread waitforplayertouch();
  self thread waitforclonetouch();
}

isoutofbounds() {
  if(!isDefined(self.oob_start_time)) {
    return false;
  }

  return self.oob_start_time != -1;
}

istouchinganyoobtrigger() {
  result = 0;

  if(isplayer(self) && function_65b20()) {
    return 0;
  }

  level.oob_triggers = array::remove_undefined(level.oob_triggers);

  foreach(trigger in level.oob_triggers) {
    if(!trigger istriggerenabled()) {
      continue;
    }

    n_flags = function_27f2ef17(trigger);

    if(trigger.classname == "trigger_out_of_bounds_new" && self.team == #"axis" && !(n_flags&1) || self.team == #"allies" && !(n_flags&2)) {
      continue;
    }

    if(self istouching(trigger)) {
      result = 1;
      break;
    }
  }

  if(result == 0 && self.var_8516173f === 1 && function_9fcf70e6()) {
    result = !self isinsideheightlock();
  }

  return result;
}

chr_party(point) {
  level.oob_triggers = array::remove_undefined(level.oob_triggers);

  foreach(trigger in level.oob_triggers) {
    if(!trigger istriggerenabled()) {
      continue;
    }

    if(istouching(point, trigger)) {
      return true;
    }
  }

  return false;
}

resetoobtimer(is_host_migrating, b_disable_timekeep) {
  self.oob_lastvalidplayerloc = undefined;
  self.oob_lastvalidplayerdir = undefined;
  self clientfield::set_to_player("out_of_bounds", 0);
  self val::reset(#"oob", "show_hud");
  self.oob_start_time = -1;

  if(isDefined(level.oob_timekeep_ms)) {
    if(isDefined(b_disable_timekeep) && b_disable_timekeep) {
      self.last_oob_timekeep_ms = undefined;
    } else {
      self.last_oob_timekeep_ms = gettime();
    }
  }

  if(!(isDefined(is_host_migrating) && is_host_migrating)) {
    self notify(#"oob_host_migration_exit");
  }

  self notify(#"oob_exit");
}

waitforclonetouch() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"trigger");
    clone = waitresult.activator;

    if(isactor(clone) && isDefined(clone.isaiclone) && clone.isaiclone && !clone isplayinganimscripted()) {
      clone notify(#"clone_shutdown");
    }
  }
}

getadjusedplayer(player) {
  if(isDefined(player.hijacked_vehicle_entity) && isalive(player.hijacked_vehicle_entity)) {
    return player.hijacked_vehicle_entity;
  }

  return player;
}

waitforplayertouch() {
  self endon(#"death");

  while(true) {
    if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
      hostmigration::waittillhostmigrationdone();
    }

    waitresult = self waittill(#"trigger");
    entity = waitresult.activator;

    if(isplayer(entity)) {
      player = entity;
    } else if(isvehicle(entity) && isalive(entity)) {
      player = entity getseatoccupant(0);

      if(!isDefined(player) || !isplayer(player)) {
        continue;
      }

      if(isDefined(entity.var_50e3187f) && entity.var_50e3187f) {
        continue;
      }
    } else {
      continue;
    }

    if(player function_65b20()) {
      continue;
    }

    if(player isoutofbounds()) {
      continue;
    }

    profilestart();
    player enter_oob(entity);
    profilestop();
  }
}

enter_oob(entity) {
  player = self;
  player notify(#"oob_enter");

  if(isDefined(level.oob_timekeep_ms) && isDefined(player.last_oob_timekeep_ms) && isDefined(player.last_oob_duration_ms) && gettime() - player.last_oob_timekeep_ms < level.oob_timekeep_ms) {
    player.oob_start_time = gettime() - level.oob_timelimit_ms - player.last_oob_duration_ms;
  } else {
    player.oob_start_time = gettime();
  }

  player.oob_lastvalidplayerloc = entity.origin;
  player.oob_lastvalidplayerdir = vectornormalize(entity getvelocity());
  player clientfield::set_to_player("nonplayer_oob_usage", 0);
  player val::set(#"oob", "show_hud", 0);
  player thread watchforleave(entity);
  player thread watchfordeath(entity);

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    player thread watchforhostmigration(entity);
  }
}

function_c5278cb0(vehicle) {
  self endon(#"disconnect");

  if(vehicle.var_8516173f !== 1) {
    return;
  }

  self notify("4986a6d17190ada9" + vehicle getentitynumber());
  self endon("4986a6d17190ada9" + vehicle getentitynumber());
  vehicle endon(#"death");

  while(true) {
    if(!vehicle isinsideheightlock()) {
      self enter_oob(vehicle);
      self waittill(#"oob_exit");
    }

    wait 0.1;
  }
}

function_65b20() {
  if(self scene::is_igc_active()) {
    return true;
  }

  if(isDefined(self.oobdisabled) && self.oobdisabled) {
    return true;
  }

  if(level flag::exists("draft_complete") && !level flag::get("draft_complete")) {
    return true;
  }

  return false;
}

getdistancefromlastvalidplayerloc(entity) {
  if(isDefined(self.oob_lastvalidplayerdir) && self.oob_lastvalidplayerdir != (0, 0, 0)) {
    vectoplayerlocfromorigin = entity.origin - self.oob_lastvalidplayerloc;
    distance = vectordot(vectoplayerlocfromorigin, self.oob_lastvalidplayerdir);
  } else {
    distance = distance(entity.origin, self.oob_lastvalidplayerloc);
  }

  if(distance < 0) {
    distance = 0;
  }

  if(distance > level.oob_max_distance_before_black) {
    distance = level.oob_max_distance_before_black;
  }

  return distance / level.oob_max_distance_before_black;
}

updatevisualeffects(entity) {
  timeremaining = 0;

  if(isDefined(level.oob_timelimit_ms) && isDefined(self.oob_start_time)) {
    timeremaining = level.oob_timelimit_ms - gettime() - self.oob_start_time;
  }

  if(entity.var_c5d65381 === 1 && isplayer(self) && !self isremotecontrolling() && isvehicle(entity)) {
    self clientfield::set_to_player("out_of_bounds", 0);
    self val::reset(#"oob", "show_hud");
    return;
  }

  if(isDefined(level.oob_timekeep_ms)) {
    self.last_oob_duration_ms = timeremaining;
  }

  oob_effectvalue = 0;

  if(timeremaining <= level.oob_time_remaining_before_black) {
    if(!isDefined(self.oob_lasteffectvalue)) {
      self.oob_lasteffectvalue = getdistancefromlastvalidplayerloc(entity);
    }

    time_val = 1 - timeremaining / level.oob_time_remaining_before_black;

    if(time_val > 1) {
      time_val = 1;
    }

    oob_effectvalue = self.oob_lasteffectvalue + (1 - self.oob_lasteffectvalue) * time_val;
  } else {
    oob_effectvalue = getdistancefromlastvalidplayerloc(entity);

    if(oob_effectvalue > 0.9) {
      oob_effectvalue = 0.9;
    } else if(oob_effectvalue < 0.05) {
      oob_effectvalue = 0.05;
    }

    self.oob_lasteffectvalue = oob_effectvalue;
  }

  oob_effectvalue = ceil(oob_effectvalue * 31);
  self clientfield::set_to_player("out_of_bounds", int(oob_effectvalue));
}

killentity(entity) {
  self resetoobtimer();

  if(isDefined(level.var_bde3d03)) {
    [[level.var_bde3d03]](entity);
    return;
  }

  entity val::set(#"oob", "takedamage", 1);

  if(isplayer(entity) && entity isinvehicle()) {
    vehicle = entity getvehicleoccupied();
    vehicle val::set(#"oob", "takedamage", 1);
    occupants = vehicle getvehoccupants();

    foreach(occupant in occupants) {
      occupant unlink();
    }

    if(!(isDefined(vehicle.allowdeath) && !vehicle.allowdeath)) {
      vehicle dodamage(vehicle.health + 10000, vehicle.origin, undefined, undefined, "none", "MOD_EXPLOSIVE", 8192);
    }
  }

  entity dodamage(entity.health + 10000, entity.origin, undefined, undefined, "none", "MOD_TRIGGER_HURT", 8192 | 16384);

  if(isplayer(entity)) {
    entity suicide();
  }
}

watchforleave(entity) {
  self endon(#"oob_exit");
  self endon(#"disconnect");
  entity endon(#"death");

  while(true) {
    if(entity istouchinganyoobtrigger() && (isplayer(entity) || isplayer(self) && self isremotecontrolling() || entity.var_c5d65381 === 1)) {
      updatevisualeffects(entity);
      cur_time = gettime();
      elapsed_time = cur_time - self.oob_start_time;

      if(elapsed_time > level.oob_timelimit_ms) {
        if(isplayer(entity)) {
          entity val::set(#"oob_touch", "ignoreme", 0);
          entity.laststand = undefined;

          if(isDefined(entity.revivetrigger)) {
            entity.revivetrigger delete();
          }
        }

        if(self !== entity) {
          self.last_oob_duration_ms = level.oob_timelimit_ms;
          self clientfield::set_to_player("nonplayer_oob_usage", 1);
        }

        self thread killentity(entity);
      }
    } else {
      self resetoobtimer();
    }

    wait 0.1;
  }
}

watchfordeath(entity) {
  self endon(#"disconnect", #"oob_exit");
  util::waittill_any_ents_two(self, "death", entity, "death");
  self resetoobtimer();
}

watchforhostmigration(entity) {
  self endon(#"oob_host_migration_exit");
  level waittill(#"host_migration_begin");
  self resetoobtimer(1, 1);
}

private disableplayeroob(disabled) {
  if(disabled) {
    self resetoobtimer();
    self.oobdisabled = 1;
    return;
  }

  self.oobdisabled = 0;
}