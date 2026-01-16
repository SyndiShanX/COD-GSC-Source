/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\_oob.gsc
*************************************************/

#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace oob;

function autoexec __init__sytem__() {
  system::register("out_of_bounds", & __init__, undefined, undefined);
}

function __init__() {
  level.oob_triggers = [];
  if(sessionmodeismultiplayergame()) {
    level.oob_timekeep_ms = getdvarint("oob_timekeep_ms", 3000);
    level.oob_timelimit_ms = getdvarint("oob_timelimit_ms", 3000);
    level.oob_damage_interval_ms = getdvarint("oob_damage_interval_ms", 3000);
    level.oob_damage_per_interval = getdvarint("oob_damage_per_interval", 999);
    level.oob_max_distance_before_black = getdvarint("oob_max_distance_before_black", 100000);
    level.oob_time_remaining_before_black = getdvarint("oob_time_remaining_before_black", -1);
  } else {
    level.oob_timelimit_ms = getdvarint("oob_timelimit_ms", 6000);
    level.oob_damage_interval_ms = getdvarint("oob_damage_interval_ms", 1000);
    level.oob_damage_per_interval = getdvarint("oob_damage_per_interval", 5);
    level.oob_max_distance_before_black = getdvarint("oob_max_distance_before_black", 400);
    level.oob_time_remaining_before_black = getdvarint("oob_time_remaining_before_black", 1000);
  }
  level.oob_damage_interval_sec = level.oob_damage_interval_ms / 1000;
  hurt_triggers = getentarray("trigger_out_of_bounds", "classname");
  foreach(trigger in hurt_triggers) {
    trigger thread run_oob_trigger();
  }
  clientfield::register("toplayer", "out_of_bounds", 1, 5, "int");
}

function run_oob_trigger() {
  self.oob_players = [];
  if(!isdefined(level.oob_triggers)) {
    level.oob_triggers = [];
  } else if(!isarray(level.oob_triggers)) {
    level.oob_triggers = array(level.oob_triggers);
  }
  level.oob_triggers[level.oob_triggers.size] = self;
  self thread waitforplayertouch();
  self thread waitforclonetouch();
}

function isoutofbounds() {
  if(!isdefined(self.oob_start_time)) {
    return 0;
  }
  return self.oob_start_time != -1;
}

function istouchinganyoobtrigger() {
  triggers_to_remove = [];
  result = 0;
  foreach(trigger in level.oob_triggers) {
    if(!isdefined(trigger)) {
      if(!isdefined(triggers_to_remove)) {
        triggers_to_remove = [];
      } else if(!isarray(triggers_to_remove)) {
        triggers_to_remove = array(triggers_to_remove);
      }
      triggers_to_remove[triggers_to_remove.size] = trigger;
      continue;
    }
    if(!trigger istriggerenabled()) {
      continue;
    }
    if(self istouching(trigger)) {
      result = 1;
      break;
    }
  }
  foreach(trigger in triggers_to_remove) {
    arrayremovevalue(level.oob_triggers, trigger);
  }
  triggers_to_remove = [];
  triggers_to_remove = undefined;
  return result;
}

function resetoobtimer(is_host_migrating, b_disable_timekeep) {
  self.oob_lastvalidplayerloc = undefined;
  self.oob_lastvalidplayerdir = undefined;
  self clientfield::set_to_player("out_of_bounds", 0);
  self util::show_hud(1);
  self.oob_start_time = -1;
  if(isdefined(level.oob_timekeep_ms)) {
    if(isdefined(b_disable_timekeep) && b_disable_timekeep) {
      self.last_oob_timekeep_ms = undefined;
    } else {
      self.last_oob_timekeep_ms = gettime();
    }
  }
  if(!(isdefined(is_host_migrating) && is_host_migrating)) {
    self notify("oob_host_migration_exit");
  }
  self notify("oob_exit");
}

function waitforclonetouch() {
  self endon("death");
  while (true) {
    self waittill("trigger", clone);
    if(isactor(clone) && isdefined(clone.isaiclone) && clone.isaiclone && !clone isplayinganimscripted()) {
      clone notify("clone_shutdown");
    }
  }
}

function getadjusedplayer(player) {
  if(isdefined(player.hijacked_vehicle_entity) && isalive(player.hijacked_vehicle_entity)) {
    return player.hijacked_vehicle_entity;
  }
  return player;
}

function waitforplayertouch() {
  self endon("death");
  while (true) {
    if(sessionmodeismultiplayergame()) {
      hostmigration::waittillhostmigrationdone();
    }
    self waittill("trigger", entity);
    if(!isplayer(entity) && (!(isvehicle(entity) && (isdefined(entity.hijacked) && entity.hijacked) && isdefined(entity.owner) && isalive(entity)))) {
      continue;
    }
    if(isplayer(entity)) {
      player = entity;
    } else {
      vehicle = entity;
      player = vehicle.owner;
    }
    if(!player isoutofbounds() && !player isplayinganimscripted() && (!(isdefined(player.oobdisabled) && player.oobdisabled))) {
      player notify("oob_enter");
      if(isdefined(level.oob_timekeep_ms) && isdefined(player.last_oob_timekeep_ms) && isdefined(player.last_oob_duration_ms) && (gettime() - player.last_oob_timekeep_ms) < level.oob_timekeep_ms) {
        player.oob_start_time = gettime() - (level.oob_timelimit_ms - player.last_oob_duration_ms);
      } else {
        player.oob_start_time = gettime();
      }
      player.oob_lastvalidplayerloc = entity.origin;
      player.oob_lastvalidplayerdir = vectornormalize(entity getvelocity());
      player util::show_hud(0);
      player thread watchforleave(self, entity);
      player thread watchfordeath(self, entity);
      if(sessionmodeismultiplayergame()) {
        player thread watchforhostmigration(self, entity);
      }
    }
  }
}

function getdistancefromlastvalidplayerloc(trigger, entity) {
  if(isdefined(self.oob_lastvalidplayerdir) && self.oob_lastvalidplayerdir != (0, 0, 0)) {
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

function updatevisualeffects(trigger, entity) {
  timeremaining = level.oob_timelimit_ms - (gettime() - self.oob_start_time);
  if(isdefined(level.oob_timekeep_ms)) {
    self.last_oob_duration_ms = timeremaining;
  }
  oob_effectvalue = 0;
  if(timeremaining <= level.oob_time_remaining_before_black) {
    if(!isdefined(self.oob_lasteffectvalue)) {
      self.oob_lasteffectvalue = getdistancefromlastvalidplayerloc(trigger, entity);
    }
    time_val = 1 - (timeremaining / level.oob_time_remaining_before_black);
    if(time_val > 1) {
      time_val = 1;
    }
    oob_effectvalue = self.oob_lasteffectvalue + ((1 - self.oob_lasteffectvalue) * time_val);
  } else {
    oob_effectvalue = getdistancefromlastvalidplayerloc(trigger, entity);
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

function killentity(entity) {
  entity_to_kill = entity;
  if(isplayer(entity) && entity isinvehicle()) {
    vehicle = entity getvehicleoccupied();
    if(isdefined(vehicle) && vehicle.is_oob_kill_target === 1) {
      entity_to_kill = vehicle;
    }
  }
  self resetoobtimer();
  entity_to_kill dodamage(entity_to_kill.health + 10000, entity_to_kill.origin, undefined, undefined, "none", "MOD_TRIGGER_HURT");
}

function watchforleave(trigger, entity) {
  self endon("oob_exit");
  entity endon("death");
  while (true) {
    if(entity istouchinganyoobtrigger()) {
      updatevisualeffects(trigger, entity);
      if((level.oob_timelimit_ms - (gettime() - self.oob_start_time)) <= 0) {
        if(isplayer(entity)) {
          entity disableinvulnerability();
          entity.ignoreme = 0;
          entity.laststand = undefined;
          if(isdefined(entity.revivetrigger)) {
            entity.revivetrigger delete();
          }
        }
        self thread killentity(entity);
      }
    } else {
      self resetoobtimer();
    }
    wait(0.1);
  }
}

function watchfordeath(trigger, entity) {
  self endon("disconnect");
  self endon("oob_exit");
  util::waittill_any_ents_two(self, "death", entity, "death");
  self resetoobtimer();
}

function watchforhostmigration(trigger, entity) {
  self endon("oob_host_migration_exit");
  level waittill("host_migration_begin");
  self resetoobtimer(1, 1);
}

function disableplayeroob(disabled) {
  if(disabled) {
    self resetoobtimer();
    self.oobdisabled = 1;
  } else {
    self.oobdisabled = 0;
  }
}