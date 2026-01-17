/*************************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_vision_pulse.csc
*************************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\filter_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace gadget_vision_pulse;

function autoexec __init__sytem__() {
  system::register("gadget_vision_pulse", &__init__, undefined, undefined);
}

function __init__() {
  if(!sessionmodeiscampaigngame()) {
    callback::on_localplayer_spawned(&on_localplayer_spawned);
    duplicate_render::set_dr_filter_offscreen("reveal_en", 50, "reveal_enemy", undefined, 2, "mc/hud_outline_model_z_red", 1);
    duplicate_render::set_dr_filter_offscreen("reveal_self", 50, "reveal_self", undefined, 2, "mc/hud_outline_model_z_red_alpha", 1);
  }
  clientfield::register("toplayer", "vision_pulse_active", 1, 1, "int", &vision_pulse_changed, 0, 1);
  visionset_mgr::register_visionset_info("vision_pulse", 1, 12, undefined, "vision_puls_bw");
}

function on_localplayer_spawned(localclientnum) {
  if(self == getlocalplayer(localclientnum)) {
    self.vision_pulse_owner = undefined;
    filter::init_filter_vision_pulse(localclientnum);
    self gadgetpulseresetreveal();
    self set_reveal_self(localclientnum, 0);
    self set_reveal_enemy(localclientnum, 0);
    self thread watch_emped(localclientnum);
  }
}

function watch_emped(localclientnum) {
  self endon("entityshutdown");
  while(true) {
    if(self isempjammed()) {
      self thread disableshader(localclientnum, 0);
      self notify("emp_jammed_vp");
      break;
    }
    wait(0.016);
  }
}

function disableshader(localclientnum, duration) {
  self endon("startvpshader");
  self endon("death");
  self endon("entityshutdown");
  self notify("disablevpshader");
  self endon("disablevpshader");
  wait(duration);
  filter::disable_filter_vision_pulse(localclientnum, 3);
}

function watch_world_pulse_end(localclientnum) {
  self notify("watchworldpulseend");
  self endon("watchworldpulseend");
  self util::waittill_any("entityshutdown", "death", "emp_jammed_vp");
  filter::set_filter_vision_pulse_constant(localclientnum, 3, 0, getvisionpulsemaxradius(localclientnum) + 1);
}

function do_vision_world_pulse(localclientnum) {
  self endon("entityshutdown");
  self endon("death");
  self notify("startvpshader");
  self thread watch_world_pulse_end(localclientnum);
  filter::enable_filter_vision_pulse(localclientnum, 3);
  filter::set_filter_vision_pulse_constant(localclientnum, 3, 1, 1);
  filter::set_filter_vision_pulse_constant(localclientnum, 3, 2, 0.08);
  filter::set_filter_vision_pulse_constant(localclientnum, 3, 3, 0);
  filter::set_filter_vision_pulse_constant(localclientnum, 3, 4, 1);
  starttime = getservertime(localclientnum);
  wait(0.016);
  amount = 1;
  irisamount = 0;
  pulsemaxradius = 0;
  while((getservertime(localclientnum) - starttime) < 2000) {
    elapsedtime = (getservertime(localclientnum) - starttime) * 1;
    if(elapsedtime < 200) {
      irisamount = elapsedtime / 200;
    } else {
      if(elapsedtime < (2000 * 0.6)) {
        irisamount = 1 - (elapsedtime / 1000);
      } else {
        irisamount = 0;
      }
    }
    amount = 1 - (elapsedtime / 2000);
    pulseradius = getvisionpulseradius(localclientnum);
    pulsemaxradius = getvisionpulsemaxradius(localclientnum);
    filter::set_filter_vision_pulse_constant(localclientnum, 3, 0, pulseradius);
    filter::set_filter_vision_pulse_constant(localclientnum, 3, 3, irisamount);
    filter::set_filter_vision_pulse_constant(localclientnum, 3, 11, pulsemaxradius);
    wait(0.016);
  }
  filter::set_filter_vision_pulse_constant(localclientnum, 3, 0, pulsemaxradius + 1);
  self thread disableshader(localclientnum, 4);
}

function vision_pulse_owner_valid(owner) {
  if(isDefined(owner) && owner isplayer() && isalive(owner)) {
    return true;
  }
  return false;
}

function watch_vision_pulse_owner_death(localclientnum) {
  self endon("entityshutdown");
  self endon("death");
  self endon("finished_local_pulse");
  self notify("watch_vision_pulse_owner_death");
  self endon("watch_vision_pulse_owner_death");
  owner = self.vision_pulse_owner;
  if(vision_pulse_owner_valid(owner)) {
    owner util::waittill_any("entityshutdown", "death");
  }
  self notify("vision_pulse_owner_death");
  filter::set_filter_vision_pulse_constant(localclientnum, 3, 7, 0);
  self thread disableshader(localclientnum, 4);
  self.vision_pulse_owner = undefined;
}

function do_vision_local_pulse(localclientnum) {
  self endon("entityshutdown");
  self endon("death");
  self endon("vision_pulse_owner_death");
  self notify("startvpshader");
  self notify("startlocalpulse");
  self endon("startlocalpulse");
  self thread watch_vision_pulse_owner_death(localclientnum);
  origin = getrevealpulseorigin(localclientnum);
  filter::enable_filter_vision_pulse(localclientnum, 3);
  filter::set_filter_vision_pulse_constant(localclientnum, 3, 5, 0.4);
  filter::set_filter_vision_pulse_constant(localclientnum, 3, 6, 0.0001);
  filter::set_filter_vision_pulse_constant(localclientnum, 3, 8, origin[0]);
  filter::set_filter_vision_pulse_constant(localclientnum, 3, 9, origin[1]);
  filter::set_filter_vision_pulse_constant(localclientnum, 3, 7, 1);
  starttime = getservertime(localclientnum);
  while((getservertime(localclientnum) - starttime) < 4000) {
    if((getservertime(localclientnum) - starttime) < 2000) {
      pulseradius = ((getservertime(localclientnum) - starttime) / 2000) * 2000;
    }
    filter::set_filter_vision_pulse_constant(localclientnum, 3, 10, pulseradius);
    wait(0.016);
  }
  filter::set_filter_vision_pulse_constant(localclientnum, 3, 7, 0);
  self thread disableshader(localclientnum, 4);
  self notify("finished_local_pulse");
  self.vision_pulse_owner = undefined;
}

function vision_pulse_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(self == getlocalplayer(localclientnum)) {
      if(isdemoplaying() && (bnewent || oldval == newval)) {
        return;
      }
      self thread do_vision_world_pulse(localclientnum);
    }
  }
}

function do_reveal_enemy_pulse(localclientnum) {
  self endon("entityshutdown");
  self endon("death");
  self notify("startenemypulse");
  self endon("startenemypulse");
  starttime = getservertime(localclientnum);
  currtime = starttime;
  self mapshaderconstant(localclientnum, 0, "scriptVector7", 0, 0, 0, 0);
  while((currtime - starttime) < 4000) {
    if((currtime - starttime) > 3500) {
      value = float(((currtime - starttime) - 3500) / 500);
      self mapshaderconstant(localclientnum, 0, "scriptVector7", value, 0, 0, 0);
    }
    wait(0.016);
    currtime = getservertime(localclientnum);
  }
}

function set_reveal_enemy(localclientnum, on_off) {
  if(on_off) {
    self thread do_reveal_enemy_pulse(localclientnum);
  }
  self duplicate_render::update_dr_flag(localclientnum, "reveal_enemy", on_off);
}

function set_reveal_self(localclientnum, on_off) {
  if(on_off && self == getlocalplayer(localclientnum)) {
    self thread do_vision_local_pulse(localclientnum);
  } else if(!on_off) {
    filter::set_filter_vision_pulse_constant(localclientnum, 3, 7, 0);
  }
}

function gadget_visionpulse_reveal(localclientnum, breveal) {
  self notify("gadget_visionpulse_changed");
  player = getlocalplayer(localclientnum);
  if(!isDefined(self.visionpulserevealself) && player == self) {
    self.visionpulserevealself = 0;
  }
  if(!isDefined(self.visionpulsereveal)) {
    self.visionpulsereveal = 0;
  }
  if(player == self) {
    owner = self gadgetpulsegetowner(localclientnum);
    if(self.visionpulserevealself != breveal || (isDefined(self.vision_pulse_owner) && isDefined(owner) && self.vision_pulse_owner != owner)) {
      self.vision_pulse_owner = owner;
      self.visionpulserevealself = breveal;
      self set_reveal_self(localclientnum, breveal);
    }
  } else if(self.visionpulsereveal != breveal) {
    self.visionpulsereveal = breveal;
    self set_reveal_enemy(localclientnum, breveal);
  }
}