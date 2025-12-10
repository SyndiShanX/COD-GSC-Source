/*****************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_camo.gsc
*****************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_gadgets;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\system_shared;
#namespace _gadget_camo;

function autoexec __init__sytem__() {
  system::register("gadget_camo", &__init__, undefined, undefined);
}

function __init__() {
  ability_player::register_gadget_activation_callbacks(2, &camo_gadget_on, &camo_gadget_off);
  ability_player::register_gadget_possession_callbacks(2, &camo_on_give, &camo_on_take);
  ability_player::register_gadget_flicker_callbacks(2, &camo_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(2, &camo_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(2, &camo_is_flickering);
  clientfield::register("allplayers", "camo_shader", 1, 3, "int");
  callback::on_connect(&camo_on_connect);
  callback::on_spawned(&camo_on_spawn);
  callback::on_disconnect(&camo_on_disconnect);
}

function camo_is_inuse(slot) {
  return self flagsys::get("camo_suit_on");
}

function camo_is_flickering(slot) {
  return self gadgetflickering(slot);
}

function camo_on_connect() {
  if(isDefined(level.cybercom) && isDefined(level.cybercom.active_camo)) {
    self[[level.cybercom.active_camo._on_connect]]();
  }
}

function camo_on_disconnect() {
  if(isDefined(self.sound_ent)) {
    self.sound_ent stoploopsound(0.05);
    self.sound_ent delete();
  }
}

function camo_on_spawn() {
  self flagsys::clear("camo_suit_on");
  self notify("camo_off");
  self camo_bread_crumb_delete();
  self clientfield::set("camo_shader", 0);
  if(isDefined(self.sound_ent)) {
    self.sound_ent stoploopsound(0.05);
    self.sound_ent delete();
  }
}

function suspend_camo_suit(slot, weapon) {
  self endon("disconnect");
  self endon("camo_off");
  self clientfield::set("camo_shader", 2);
  suspend_camo_suit_wait(slot, weapon);
  if(self camo_is_inuse(slot)) {
    self clientfield::set("camo_shader", 1);
  }
}

function suspend_camo_suit_wait(slot, weapon) {
  self endon("death");
  self endon("camo_off");
  while(self camo_is_flickering(slot)) {
    wait(0.5);
  }
}

function camo_on_give(slot, weapon) {
  if(isDefined(level.cybercom) && isDefined(level.cybercom.active_camo)) {
    self[[level.cybercom.active_camo._on_give]](slot, weapon);
  }
}

function camo_on_take(slot, weapon) {
  self notify("camo_removed");
  if(isDefined(level.cybercom) && isDefined(level.cybercom.active_camo)) {
    self[[level.cybercom.active_camo._on_take]](slot, weapon);
  }
}

function camo_on_flicker(slot, weapon) {
  self thread camo_suit_flicker(slot, weapon);
  if(isDefined(level.cybercom) && isDefined(level.cybercom.active_camo)) {
    self thread[[level.cybercom.active_camo._on_flicker]](slot, weapon);
  }
}

function camo_all_actors(value) {
  str_opposite_team = "axis";
  if(self.team == "axis") {
    str_opposite_team = "allies";
  }
  aitargets = getaiarray(str_opposite_team);
  for(i = 0; i < aitargets.size; i++) {
    testtarget = aitargets[i];
    if(!isDefined(testtarget) || !isalive(testtarget)) {
      continue;
    }
  }
}

function camo_gadget_on(slot, weapon) {
  if(isDefined(level.cybercom) && isDefined(level.cybercom.active_camo)) {
    self thread[[level.cybercom.active_camo._on]](slot, weapon);
  }
  self thread camo_takedown_watch(slot, weapon);
  self._gadget_camo_oldignoreme = self.ignoreme;
  self.ignoreme = 1;
  self clientfield::set("camo_shader", 1);
  self flagsys::set("camo_suit_on");
  self thread camo_bread_crumb(slot, weapon);
}

function camo_gadget_off(slot, weapon) {
  self flagsys::clear("camo_suit_on");
  if(isDefined(level.cybercom) && isDefined(level.cybercom.active_camo)) {
    self thread[[level.cybercom.active_camo._off]](slot, weapon);
  }
  self notify("camo_off", isDefined(self.sound_ent));
  if(isDefined(self._gadget_camo_oldignoreme)) {
    self.ignoreme = self._gadget_camo_oldignoreme;
    self._gadget_camo_oldignoreme = undefined;
  } else {
    self.ignoreme = 0;
  }
  self camo_bread_crumb_delete();
  self.gadget_camo_off_time = gettime();
  self clientfield::set("camo_shader", 0);
}

function camo_bread_crumb(slot, weapon) {
  self notify("camo_bread_crumb");
  self endon("camo_bread_crumb");
  self camo_bread_crumb_delete();
  if(!self camo_is_inuse()) {
    return;
  }
  self._camo_crumb = spawn("script_model", self.origin);
  self._camo_crumb setModel("tag_origin");
  self camo_bread_crumb_wait(slot, weapon);
  self camo_bread_crumb_delete();
}

function camo_bread_crumb_wait(slot, weapon) {
  self endon("disconnect");
  self endon("death");
  self endon("camo_off");
  self endon("camo_bread_crumb");
  starttime = gettime();
  while(true) {
    currenttime = gettime();
    if((currenttime - starttime) > self._gadgets_player[slot].gadget_breadcrumbduration) {
      return;
    }
    wait(0.5);
  }
}

function camo_bread_crumb_delete() {
  if(isDefined(self._camo_crumb)) {
    self._camo_crumb delete();
    self._camo_crumb = undefined;
  }
}

function camo_takedown_watch(slot, weapon) {
  self endon("disconnect");
  self endon("camo_off");
  while(true) {
    self waittill("weapon_assassination");
    if(self camo_is_inuse()) {
      if(self._gadgets_player[slot].gadget_takedownrevealtime > 0) {
        self ability_gadgets::setflickering(slot, self._gadgets_player[slot].gadget_takedownrevealtime);
      }
    }
  }
}

function camo_temporary_dont_ignore(slot) {
  self endon("disconnect");
  if(!self camo_is_inuse()) {
    return;
  }
  self notify("temporary_dont_ignore");
  wait(0.1);
  old_ignoreme = 0;
  if(isDefined(self._gadget_camo_oldignoreme)) {
    old_ignoreme = self._gadget_camo_oldignoreme;
  }
  self.ignoreme = old_ignoreme;
  camo_temporary_dont_ignore_wait(slot);
  self.ignoreme = self camo_is_inuse() || old_ignoreme;
}

function camo_temporary_dont_ignore_wait(slot) {
  self endon("disconnect");
  self endon("death");
  self endon("camo_off");
  self endon("temporary_dont_ignore");
  while(true) {
    if(!self camo_is_flickering(slot)) {
      return;
    }
    wait(0.25);
  }
}

function camo_suit_flicker(slot, weapon) {
  self endon("disconnect");
  self endon("death");
  self endon("camo_off");
  if(!self camo_is_inuse()) {
    return;
  }
  self thread camo_temporary_dont_ignore(slot);
  self thread suspend_camo_suit(slot, weapon);
  while(true) {
    if(!self camo_is_flickering(slot)) {
      self thread camo_bread_crumb(slot);
      return;
    }
    wait(0.25);
  }
}

function set_camo_reveal_status(status, time) {
  timestr = "";
  self._gadget_camo_reveal_status = undefined;
  if(isDefined(time)) {
    timestr = (", ^3time: ") + time;
    self._gadget_camo_reveal_status = status;
  }
  if(getdvarint("scr_cpower_debug_prints") > 0) {
    self iprintlnbold(("Camo Reveal: " + status) + timestr);
  }
}