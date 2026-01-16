/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\killstreaks\_killstreak_detect.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\filter_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace killstreak_detect;

function autoexec __init__sytem__() {
  system::register("killstreak_detect", & __init__, undefined, undefined);
}

function __init__() {
  callback::on_localplayer_spawned( & watch_killstreak_detect_perks_changed);
  clientfield::register("scriptmover", "enemyvehicle", 1, 2, "int", & enemyscriptmovervehicle_changed, 0, 0);
  clientfield::register("vehicle", "enemyvehicle", 1, 2, "int", & enemyvehicle_changed, 0, 1);
  clientfield::register("helicopter", "enemyvehicle", 1, 2, "int", & enemyvehicle_changed, 0, 1);
  clientfield::register("missile", "enemyvehicle", 1, 2, "int", & enemymissilevehicle_changed, 0, 1);
  clientfield::register("actor", "enemyvehicle", 1, 2, "int", & enemyvehicle_changed, 0, 1);
  clientfield::register("vehicle", "vehicletransition", 1, 1, "int", & vehicle_transition, 0, 1);
  if(!isdefined(level.enemyvehicles)) {
    level.enemyvehicles = [];
  }
  if(!isdefined(level.enemymissiles)) {
    level.enemymissiles = [];
  }
  level.emp_killstreaks = [];
}

function vehicle_transition(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player = getlocalplayer(local_client_num);
  friend = self util::friend_not_foe(local_client_num, 1);
  if(friend && isdefined(player) && player duplicate_render::show_friendly_outlines(local_client_num)) {
    showoutlines = !self islocalclientdriver(local_client_num);
    self duplicate_render::set_item_friendly_vehicle(local_client_num, showoutlines);
  }
}

function should_set_compass_icon(local_client_num) {
  local_player = getlocalplayer(local_client_num);
  return isdefined(local_player) && isdefined(self.team) && (local_player.team === self.team || local_player hasperk(local_client_num, "specialty_showenemyvehicles"));
}

function enemyscriptmovervehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isdefined(level.scriptmovercompassicons) && isdefined(self.model)) {
    if(isdefined(level.scriptmovercompassicons[self.model])) {
      if(self should_set_compass_icon(local_client_num)) {
        self setcompassicon(level.scriptmovercompassicons[self.model]);
      }
    }
  }
  enemyvehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

function enemymissilevehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isdefined(level.missilecompassicons) && isdefined(self.weapon)) {
    if(isdefined(level.missilecompassicons[self.weapon])) {
      if(self should_set_compass_icon(local_client_num)) {
        self setcompassicon(level.missilecompassicons[self.weapon]);
      }
    }
  }
  enemymissile_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

function enemymissile_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self updateteammissiles(local_client_num, newval);
  self util::add_remove_list(level.enemymissiles, newval);
  self updateenemymissiles(local_client_num, newval);
}

function enemyvehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self updateteamvehicles(local_client_num, newval);
  self util::add_remove_list(level.enemyvehicles, newval);
  self updateenemyvehicles(local_client_num, newval);
  if(isdefined(self.model) && self.model == "wpn_t7_turret_emp_core" && self.type === "vehicle") {
    if(!isdefined(level.emp_killstreaks)) {
      level.emp_killstreaks = [];
    } else if(!isarray(level.emp_killstreaks)) {
      level.emp_killstreaks = array(level.emp_killstreaks);
    }
    level.emp_killstreaks[level.emp_killstreaks.size] = self;
  }
}

function updateteamvehicles(local_client_num, newval) {
  self checkteamvehicles(local_client_num);
}

function updateteammissiles(local_client_num, newval) {
  self checkteammissiles(local_client_num);
}

function updateenemyvehicles(local_client_num, newval) {
  if(!isdefined(self)) {
    return;
  }
  watcher = getlocalplayer(local_client_num);
  friend = self util::friend_not_foe(local_client_num, 1);
  self duplicate_render::set_dr_flag("enemyvehicle_fb", !friend);
  self duplicate_render::set_item_enemy_vehicle(local_client_num, 0);
  self duplicate_render::set_item_friendly_vehicle(local_client_num, 0);
  self.isenemyvehicle = 0;
  if(!friend && isdefined(watcher) && watcher hasperk(local_client_num, "specialty_showenemyvehicles")) {
    if(!isdefined(self.isbreachingfirewall) || self.isbreachingfirewall == 0) {
      self duplicate_render::set_item_enemy_vehicle(local_client_num, newval);
    }
    self.isenemyvehicle = 1;
    self duplicate_render::set_item_friendly_vehicle(local_client_num, 0);
  } else {
    if(friend === 1 && isdefined(watcher) && watcher duplicate_render::show_friendly_outlines(local_client_num)) {
      driver = self.type === "vehicle" && self islocalclientdriver(local_client_num);
      showoutlines = driver === 0 && (newval === 1 || newval === 2);
      self duplicate_render::set_item_friendly_vehicle(local_client_num, showoutlines);
    } else {
      self duplicate_render::set_item_friendly_vehicle(local_client_num, 0);
    }
  }
  if(newval == 2) {
    self.killstreakishacked = 1;
  }
  self duplicate_render::update_dr_filters(local_client_num);
}

function updateenemymissiles(local_client_num, newval) {
  if(!isdefined(self)) {
    return;
  }
  watcher = getlocalplayer(local_client_num);
  friend = self util::friend_not_foe(local_client_num, 1);
  self duplicate_render::set_dr_flag("enemyvehicle_fb", !friend);
  self duplicate_render::set_item_enemy_explosive(local_client_num, 0);
  self duplicate_render::set_item_friendly_explosive(local_client_num, 0);
  self.isenemyvehicle = 0;
  if(!friend && isdefined(watcher) && watcher hasperk(local_client_num, "specialty_showenemyvehicles")) {
    if(!isdefined(self.isbreachingfirewall) || self.isbreachingfirewall == 0) {
      self duplicate_render::set_item_enemy_explosive(local_client_num, newval);
    }
    self.isenemyvehicle = 1;
    self duplicate_render::set_item_friendly_explosive(local_client_num, 0);
  } else {
    if(friend === 1 && isdefined(watcher) && watcher duplicate_render::show_friendly_outlines(local_client_num)) {
      showoutlines = newval === 1 || newval === 2;
      self duplicate_render::set_item_friendly_explosive(local_client_num, showoutlines);
    } else {
      self duplicate_render::set_item_friendly_explosive(local_client_num, 0);
    }
  }
  if(newval == 2) {
    self.killstreakishacked = 1;
  }
  self duplicate_render::update_dr_filters(local_client_num);
}

function watch_killstreak_detect_perks_changed(local_client_num) {
  if(self != getlocalplayer(local_client_num)) {
    return;
  }
  self notify("watch_killstreak_detect_perks_changed");
  self endon("watch_killstreak_detect_perks_changed");
  self endon("death");
  self endon("disconnect");
  self endon("entityshutdown");
  while (isdefined(self)) {
    wait(0.016);
    util::clean_deleted(level.enemyvehicles);
    util::clean_deleted(level.enemymissiles);
    array::thread_all(level.enemyvehicles, & updateenemyvehicles, local_client_num, 1);
    array::thread_all(level.enemymissiles, & updateenemymissiles, local_client_num, 1);
    self waittill("perks_changed");
  }
}

function checkteamvehicles(localclientnum) {
  if(!isdefined(self.owner) || !isdefined(self.owner.team)) {
    return;
  }
  if(!isdefined(self.vehicleoldteam)) {
    self.vehicleoldteam = self.team;
  }
  if(!isdefined(self.vehicleoldownerteam)) {
    self.vehicleoldownerteam = self.owner.team;
  }
  watcher = getlocalplayer(localclientnum);
  if(!isdefined(self.vehicleoldwatcherteam)) {
    self.vehicleoldwatcherteam = watcher.team;
  }
  if(self.vehicleoldteam != self.team || self.vehicleoldownerteam != self.owner.team || self.vehicleoldwatcherteam != watcher.team) {
    self.vehicleoldteam = self.team;
    self.vehicleoldownerteam = self.owner.team;
    self.vehicleoldwatcherteam = watcher.team;
    self notify("team_changed");
  }
}

function checkteammissiles(localclientnum) {
  if(!isdefined(self.owner) || !isdefined(self.owner.team)) {
    return;
  }
  if(!isdefined(self.missileoldteam)) {
    self.missileoldteam = self.team;
  }
  if(!isdefined(self.missileoldownerteam)) {
    self.missileoldownerteam = self.owner.team;
  }
  watcher = getlocalplayer(localclientnum);
  if(!isdefined(self.missileoldwatcherteam)) {
    self.missileoldwatcherteam = watcher.team;
  }
  if(self.missileoldteam != self.team || self.missileoldownerteam != self.owner.team || self.missileoldwatcherteam != watcher.team) {
    self.missileoldteam = self.team;
    self.missileoldownerteam = self.owner.team;
    self.missileoldwatcherteam = watcher.team;
    self notify("team_changed");
  }
}