/************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_speed_burst.gsc
************************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace speedburst;

function autoexec __init__sytem__() {
  system::register("gadget_speed_burst", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "speed_burst", 1, 1, "int");
  ability_player::register_gadget_activation_callbacks(13, &gadget_speed_burst_on, &gadget_speed_burst_off);
  ability_player::register_gadget_possession_callbacks(13, &gadget_speed_burst_on_give, &gadget_speed_burst_on_take);
  ability_player::register_gadget_flicker_callbacks(13, &gadget_speed_burst_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(13, &gadget_speed_burst_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(13, &gadget_speed_burst_is_flickering);
  if(!isDefined(level.vsmgr_prio_visionset_speedburst)) {
    level.vsmgr_prio_visionset_speedburst = 60;
  }
  visionset_mgr::register_info("visionset", "speed_burst", 1, level.vsmgr_prio_visionset_speedburst, 9, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
  callback::on_connect(&gadget_speed_burst_on_connect);
}

function gadget_speed_burst_is_inuse(slot) {
  return self flagsys::get("gadget_speed_burst_on");
}

function gadget_speed_burst_is_flickering(slot) {
  return self gadgetflickering(slot);
}

function gadget_speed_burst_on_flicker(slot, weapon) {
  self thread gadget_speed_burst_flicker(slot, weapon);
}

function gadget_speed_burst_on_give(slot, weapon) {
  flagsys::set("speed_burst_on");
  self clientfield::set_to_player("speed_burst", 0);
}

function gadget_speed_burst_on_take(slot, weapon) {
  flagsys::clear("speed_burst_on");
  self clientfield::set_to_player("speed_burst", 0);
}

function gadget_speed_burst_on_connect() {}

function gadget_speed_burst_on(slot, weapon) {
  self flagsys::set("gadget_speed_burst_on");
  self gadgetsetactivatetime(slot, gettime());
  self clientfield::set_to_player("speed_burst", 1);
  visionset_mgr::activate("visionset", "speed_burst", self, 0.4, 0.1, 1.35);
  self.speedburstlastontime = gettime();
  self.speedburston = 1;
  self.speedburstkill = 0;
}

function gadget_speed_burst_off(slot, weapon) {
  self notify("gadget_speed_burst_off");
  self flagsys::clear("gadget_speed_burst_on");
  self clientfield::set_to_player("speed_burst", 0);
  self.speedburstlastontime = gettime();
  self.speedburston = 0;
  if(isalive(self) && (isDefined(self.speedburstkill) && self.speedburstkill) && isDefined(level.playgadgetsuccess)) {
    self[[level.playgadgetsuccess]](weapon);
  }
  self.speedburstkill = 0;
}

function gadget_speed_burst_flicker(slot, weapon) {
  self endon("disconnect");
  if(!self gadget_speed_burst_is_inuse(slot)) {
    return;
  }
  eventtime = self._gadgets_player[slot].gadget_flickertime;
  self set_gadget_status("Flickering", eventtime);
  while(true) {
    if(!self gadgetflickering(slot)) {
      self set_gadget_status("Normal");
      return;
    }
    wait(0.5);
  }
}

function set_gadget_status(status, time) {
  timestr = "";
  if(isDefined(time)) {
    timestr = (("^3") + ", time: ") + time;
  }
  if(getdvarint("scr_cpower_debug_prints") > 0) {
    self iprintlnbold(("Vision Speed burst: " + status) + timestr);
  }
}