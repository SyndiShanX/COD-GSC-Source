/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicles\_quadtank.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#namespace quadtank;

function autoexec __init__sytem__() {
  system::register("quadtank", &__init__, undefined, undefined);
}

function __init__() {
  vehicle::add_vehicletype_callback("quadtank", &_setup_);
  clientfield::register("toplayer", "player_shock_fx", 1, 1, "int", &player_shock_fx_handler, 0, 0);
  clientfield::register("vehicle", "quadtank_trophy_state", 1, 1, "int", &update_trophy_system_state, 0, 0);
}

function _setup_(localclientnum) {
  player = getlocalplayer(localclientnum);
  if(isDefined(player)) {
    filter::init_filter_ev_interference(player);
  }
  self.notifyonbulletimpact = 1;
  self thread wait_for_bullet_impact(localclientnum);
  self.trophy_on = 0;
}

function player_shock_fx_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    self thread player_shock_fx_fade_off(localclientnum, 1, 1);
  }
}

function player_shock_fx_fade_off(localclientnum, amount, fadeouttime) {
  self endon("disconnect");
  self notify("player_shock_fx_fade_off_end");
  self endon("player_shock_fx_fade_off_end");
  if(!isalive(self)) {
    return;
  }
  starttime = gettime();
  filter::set_filter_ev_interference_amount(self, 4, amount);
  filter::enable_filter_ev_interference(self, 4);
  while(gettime() <= (starttime + (fadeouttime * 1000)) && isalive(self)) {
    ratio = (gettime() - starttime) / (fadeouttime * 1000);
    currentvalue = lerpfloat(amount, 0, ratio);
    setfilterpassconstant(localclientnum, 4, 0, 0, currentvalue);
    wait(0.016);
  }
  setfilterpassenabled(localclientnum, 4, 0, 0);
}

function update_trophy_system_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread set_trophy_state(localclientnum, newval === 1);
}

function set_trophy_state(localclientnum, ison) {
  self endon("entityshutdown");
  self notify("stop_set_trophy_state");
  self endon("stop_set_trophy_state");
  if(isDefined(self.trophydestroy_fx_handle)) {
    stopfx(localclientnum, self.trophydestroy_fx_handle);
  }
  if(isDefined(self.trophylight_fx_handle)) {
    stopfx(localclientnum, self.trophylight_fx_handle);
  }
  vehicle::wait_for_dobj(localclientnum);
  if(isDefined(self.scriptbundlesettings)) {
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  }
  if(!isDefined(settings)) {
    return;
  }
  if(ison === 1) {
    warmuptime = (isDefined(settings.trophywarmup) ? settings.trophywarmup : 0.1);
    start = gettime();
    interval = 0.3;
    while(gettime() <= (start + (warmuptime * 1000))) {
      if(isDefined(settings.trophylight_fx_1) && isDefined(settings.trophylight_tag_1)) {
        self.trophylight_fx_handle = playFXOnTag(localclientnum, settings.trophylight_fx_1, self, settings.trophylight_tag_1);
      }
      wait(0.05);
      if(isDefined(self.trophylight_fx_handle)) {
        stopfx(localclientnum, self.trophylight_fx_handle);
      }
      wait(max(interval, 0.05));
      interval = interval * 0.8;
    }
    if(isDefined(settings.trophylight_fx_1) && isDefined(settings.trophylight_tag_1)) {
      self.trophylight_fx_handle = playFXOnTag(localclientnum, settings.trophylight_fx_1, self, settings.trophylight_tag_1);
    }
    self.trophy_on = 1;
    self playLoopSound("wpn_trophy_spin_loop");
    rate = 0;
    while(isDefined(settings.trophyanim) && rate < 1) {
      rate = rate + 0.02;
      self setanim(settings.trophyanim, 1, 0.1, rate);
      wait(0.016);
    }
    self setanim(settings.trophyanim, 1, 0.1, 1);
  } else {
    self.trophy_on = 0;
    self stopallloopsounds();
    if(isDefined(settings.trophyanim)) {
      self setanim(settings.trophyanim, 0, 0.2, 1);
    }
    if(isDefined(settings.trophydestroyfx)) {
      self.trophydestroy_fx_handle = playFXOnTag(localclientnum, settings.trophydestroyfx, self, "tag_target_lower");
    }
  }
}

function wait_for_bullet_impact(localclientnum) {
  self endon("entityshutdown");
  if(isDefined(self.scriptbundlesettings)) {
    settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  } else {
    return;
  }
  while(true) {
    self waittill("damage", attacker, impactpos, effectdir, partname);
    if(partname == "tag_target_lower" || partname == "tag_target_upper" || partname == "tag_defense_active" || partname == "tag_body_animate") {
      if(self.trophy_on) {
        if(isDefined(attacker) && attacker isplayer() && attacker.team != self.team) {
          playFX(localclientnum, settings.weakspotfx, impactpos, effectdir);
          self playSound(0, "veh_quadtank_panel_hit");
        }
      }
    }
  }
}