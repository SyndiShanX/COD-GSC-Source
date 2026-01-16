/**********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_flashback.gsc
**********************************************************/

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
#namespace flashback;

function autoexec __init__sytem__() {
  system::register("gadget_flashback", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "flashback_trail_fx", 1, 1, "int");
  clientfield::register("playercorpse", "flashback_clone", 1, 1, "int");
  clientfield::register("allplayers", "flashback_activated", 1, 1, "int");
  ability_player::register_gadget_activation_callbacks(16, & gadget_flashback_on, & gadget_flashback_off);
  ability_player::register_gadget_possession_callbacks(16, & gadget_flashback_on_give, & gadget_flashback_on_take);
  ability_player::register_gadget_flicker_callbacks(16, & gadget_flashback_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(16, & gadget_flashback_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(16, & gadget_flashback_is_flickering);
  ability_player::register_gadget_primed_callbacks(16, & gadget_flashback_is_primed);
  callback::on_connect( & gadget_flashback_on_connect);
  callback::on_spawned( & gadget_flashback_spawned);
  if(!isdefined(level.vsmgr_prio_overlay_flashback_warp)) {
    level.vsmgr_prio_overlay_flashback_warp = 27;
  }
  visionset_mgr::register_info("overlay", "flashback_warp", 1, level.vsmgr_prio_overlay_flashback_warp, 1, 1, & visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
}

function gadget_flashback_spawned() {
  self clientfield::set("flashback_activated", 0);
}

function gadget_flashback_is_inuse(slot) {
  return self flagsys::get("gadget_flashback_on");
}

function gadget_flashback_is_flickering(slot) {
  return self gadgetflickering(slot);
}

function gadget_flashback_on_flicker(slot, weapon) {}

function gadget_flashback_on_give(slot, weapon) {}

function gadget_flashback_on_take(slot, weapon) {}

function gadget_flashback_on_connect() {}

function clone_watch_death() {
  self endon("death");
  wait(1);
  self clientfield::set("flashback_clone", 0);
  self ghost();
}

function debug_star(origin, seconds, color) {
  if(!isdefined(seconds)) {
    seconds = 1;
  }
  if(!isdefined(color)) {
    color = (1, 0, 0);
  }
  frames = int(20 * seconds);
  debugstar(origin, frames, color);
}

function drop_unlinked_grenades(linkedgrenades) {
  waittillframeend();
  foreach(grenade in linkedgrenades) {
    grenade launch((randomfloatrange(-5, 5), randomfloatrange(-5, 5), 5));
  }
}

function unlink_grenades(oldpos) {
  radius = 32;
  origin = oldpos;
  grenades = getentarray("grenade", "classname");
  radiussq = radius * radius;
  linkedgrenades = [];
  foreach(grenade in grenades) {
    if(distancesquared(origin, grenade.origin) < radiussq) {
      if(isdefined(grenade.stucktoplayer) && grenade.stucktoplayer == self) {
        grenade unlink();
        linkedgrenades[linkedgrenades.size] = grenade;
      }
    }
  }
  thread drop_unlinked_grenades(linkedgrenades);
}

function gadget_flashback_on(slot, weapon) {
  self flagsys::set("gadget_flashback_on");
  self gadgetsetactivatetime(slot, gettime());
  visionset_mgr::activate("overlay", "flashback_warp", self, 0.8, 0.8);
  self.flashbacktime = gettime();
  self notify("flashback");
  clone = self createflashbackclone();
  clone thread clone_watch_death();
  clone clientfield::set("flashback_clone", 1);
  self thread watchclientfields();
  oldpos = self gettagorigin("j_spineupper");
  offset = oldpos - self.origin;
  self unlink_grenades(oldpos);
  newpos = self flashbackstart(weapon) + offset;
  self notsolid();
  if(isdefined(newpos) && isdefined(oldpos)) {
    self thread flashbacktrailfx(slot, weapon, oldpos, newpos);
    flashbacktrailimpact(newpos, oldpos, 8);
    flashbacktrailimpact(oldpos, newpos, 8);
    if(isdefined(level.playgadgetsuccess)) {
      self[[level.playgadgetsuccess]](weapon, "flashbackSuccessDelay");
    }
  }
  self thread deactivateflashbackwarpaftertime(0.8);
}

function watchclientfields() {
  self endon("death");
  self endon("disconnect");
  util::wait_network_frame();
  self clientfield::set("flashback_activated", 1);
  util::wait_network_frame();
  self clientfield::set("flashback_activated", 0);
}

function flashbacktrailimpact(startpos, endpos, recursiondepth) {
  recursiondepth--;
  if(recursiondepth <= 0) {
    return;
  }
  trace = bullettrace(startpos, endpos, 0, self);
  if(trace["fraction"] < 1 && trace["normal"] != (0, 0, 0)) {
    playfx("player/fx_plyr_flashback_trail_impact", trace["position"], trace["normal"]);
    newstartpos = trace["position"] - trace["normal"];
    flashbacktrailimpact(newstartpos, endpos, recursiondepth);
  }
}

function deactivateflashbackwarpaftertime(time) {
  self endon("disconnect");
  self util::waittill_any_timeout(time, "death");
  visionset_mgr::deactivate("overlay", "flashback_warp", self);
}

function flashbacktrailfx(slot, weapon, oldpos, newpos) {
  dirvec = newpos - oldpos;
  if(dirvec == (0, 0, 0)) {
    dirvec = (0, 0, 1);
  }
  dirvec = vectornormalize(dirvec);
  angles = vectortoangles(dirvec);
  fxorg = spawn("script_model", oldpos, 0, angles);
  fxorg.angles = angles;
  fxorg setowner(self);
  fxorg setmodel("tag_origin");
  fxorg clientfield::set("flashback_trail_fx", 1);
  util::wait_network_frame();
  tagpos = self gettagorigin("j_spineupper");
  fxorg moveto(tagpos, 0.1);
  fxorg waittill("movedone");
  wait(1);
  fxorg clientfield::set("flashback_trail_fx", 0);
  util::wait_network_frame();
  fxorg delete();
}

function gadget_flashback_is_primed(slot, weapon) {}

function gadget_flashback_off(slot, weapon) {
  self flagsys::clear("gadget_flashback_on");
  self solid();
  self flashbackfinish();
  if(level.gameended) {
    self freezecontrols(1);
  }
}