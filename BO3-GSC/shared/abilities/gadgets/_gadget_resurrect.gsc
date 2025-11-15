/**********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_resurrect.gsc
**********************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\_oob;
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
#using scripts\shared\weapons\_smokegrenade;
#namespace resurrect;

function autoexec __init__sytem__() {
  system::register("gadget_resurrect", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("allplayers", "resurrecting", 1, 1, "int");
  clientfield::register("toplayer", "resurrect_state", 1, 2, "int");
  clientfield::register("clientuimodel", "hudItems.rejack.activationWindowEntered", 1, 1, "int");
  clientfield::register("clientuimodel", "hudItems.rejack.rejackActivated", 1, 1, "int");
  ability_player::register_gadget_activation_callbacks(40, & gadget_resurrect_on, & gadget_resurrect_off);
  ability_player::register_gadget_possession_callbacks(40, & gadget_resurrect_on_give, & gadget_resurrect_on_take);
  ability_player::register_gadget_flicker_callbacks(40, & gadget_resurrect_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(40, & gadget_resurrect_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(40, & gadget_resurrect_is_flickering);
  ability_player::register_gadget_primed_callbacks(40, & gadget_resurrect_is_primed);
  ability_player::register_gadget_ready_callbacks(40, & gadget_resurrect_is_ready);
  callback::on_connect( & gadget_resurrect_on_connect);
  callback::on_spawned( & gadget_resurrect_on_spawned);
  if(!isDefined(level.vsmgr_prio_visionset_resurrect)) {
    level.vsmgr_prio_visionset_resurrect = 62;
  }
  if(!isDefined(level.vsmgr_prio_visionset_resurrect_up)) {
    level.vsmgr_prio_visionset_resurrect_up = 63;
  }
  visionset_mgr::register_info("visionset", "resurrect", 1, level.vsmgr_prio_visionset_resurrect, 16, 1, & visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
  visionset_mgr::register_info("visionset", "resurrect_up", 1, level.vsmgr_prio_visionset_resurrect_up, 16, 1, & visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
}

function gadget_resurrect_is_inuse(slot) {
  return self gadgetisactive(slot);
}

function gadget_resurrect_is_flickering(slot) {
  return self gadgetflickering(slot);
}

function gadget_resurrect_on_flicker(slot, weapon) {}

function gadget_resurrect_on_give(slot, weapon) {
  self.usedresurrect = 0;
  self.resurrect_weapon = weapon;
}

function gadget_resurrect_on_take(slot, weapon) {
  self.overrideplayerdeadstatus = undefined;
  self.resurrect_weapon = undefined;
  self.secondarydeathcamtime = undefined;
  self notify("resurrect_taken");
}

function gadget_resurrect_on_spawned() {
  self clientfield::set_player_uimodel("hudItems.rejack.activationWindowEntered", 0);
  self util::show_hud(1);
  self._disable_proximity_alarms = 0;
  self flagsys::clear("gadget_resurrect_ready");
  self flagsys::clear("gadget_resurrect_pending");
  if(self flagsys::get("gadget_resurrect_activated")) {
    self thread do_resurrected_on_spawned_player_fx();
    self thread resurrect_drain_power();
    self flagsys::clear("gadget_resurrect_activated");
  }
}

function resurrect_drain_power(amount) {
  if(isDefined(self.resurrect_weapon)) {
    slot = self gadgetgetslot(self.resurrect_weapon);
    if(slot >= 0 && slot < 3) {
      if(isDefined(amount)) {
        self gadgetpowerchange(slot, amount);
      } else {
        self gadgetstatechange(slot, self.resurrect_weapon, 3);
      }
    }
  }
}

function gadget_resurrect_on_connect() {}

function gadget_resurrect_on(slot, weapon) {}

function watch_smoke_detonate() {
  self endon("player_input_suicide");
  self endon("player_input_revive");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  while(true) {
    if(self isplayerswimming() || self isonground() && !self iswallrunning() && !self istraversing()) {
      smoke_weapon = getweapon("gadget_resurrect_smoke_grenade");
      stat_weapon = getweapon("gadget_resurrect");
      smokeeffect = smokegrenade::smokedetonate(self, stat_weapon, smoke_weapon, self.origin, 128, 5, 4);
      smokeeffect thread watch_smoke_effect_watch_suicide(self);
      smokeeffect thread watch_smoke_effect_watch_resurrect(self);
      smokeeffect thread watch_smoke_death(self);
      return;
    }
    wait(0.05);
  }
}

function watch_smoke_death(player) {
  self endon("death");
  player util::waittill_any_timeout(5, "disconnect", "death");
  self delete();
}

function watch_smoke_effect_watch_suicide(player) {
  self endon("death");
  player waittill("player_input_suicide");
  self delete();
}

function watch_smoke_effect_watch_resurrect(player) {
  self endon("death");
  player waittill("player_input_revive");
  wait(0.5);
  self delete();
}

function gadget_resurrect_is_primed(slot, weapon) {
  if(isDefined(self.resurrect_not_allowed_by)) {
    return;
  }
  self startresurrectviewangletransition();
  self.lastwaterdamagetime = gettime();
  self._disable_proximity_alarms = 1;
  self thread watch_smoke_detonate();
  self util::show_hud(0);
  visionset_mgr::activate("visionset", "resurrect", self, 1.4, 4, 0.25);
  self clientfield::set_to_player("resurrect_state", 1);
  self shellshock("resurrect", 5.4, 0);
}

function gadget_resurrect_is_ready(slot, weapon) {}

function gadget_resurrect_start(slot, weapon) {
  wait(0.1);
  self gadgetsetactivatetime(slot, gettime());
  self thread resurrect_delay(weapon);
}

function gadget_resurrect_off(slot, weapon) {
  self notify("gadget_resurrect_off");
}

function resurrect_delay(weapon) {
  self endon("disconnect");
  self endon("game_ended");
  self endon("death");
  self notify("resurrect_delay");
  self endon("resurrect_delay");
}

function overridespawn(ispredictedspawn) {
  if(!self flagsys::get("gadget_resurrect_ready")) {
    return false;
  }
  if(!self flagsys::get("gadget_resurrect_activated")) {
    return false;
  }
  if(!isDefined(self.resurrect_origin)) {
    self.resurrect_origin = self.origin;
    self.resurrect_angles = self.angles;
  }
  return true;
}

function is_jumping() {
  ground_ent = self getgroundent();
  return !isDefined(ground_ent);
}

function player_position_valid() {
  if(self clientfield::get_to_player("out_of_bounds")) {
    return false;
  }
  return true;
}

function resurrect_breadcrumbs(slot) {
  self endon("disconnect");
  self endon("game_ended");
  self endon("resurrect_taken");
  self.resurrect_slot = slot;
  while(true) {
    if(isalive(self) && self player_position_valid()) {
      self.resurrect_origin = self.origin;
      self.resurrect_angles = self.angles;
    }
    wait(1);
  }
}

function glow_for_time(time) {
  self endon("disconnect");
  self clientfield::set("resurrecting", 1);
  wait(time);
  self clientfield::set("resurrecting", 0);
}

function wait_for_time(time, msg) {
  self endon("disconnect");
  self endon("game_ended");
  self endon(msg);
  wait(time);
  self notify(msg);
}

function wait_for_activate(msg) {
  self endon("disconnect");
  self endon("game_ended");
  self endon(msg);
  while(true) {
    if(self offhandspecialbuttonpressed()) {
      self flagsys::set("gadget_resurrect_activated");
      self notify(msg);
    }
    wait(0.05);
  }
}

function bot_wait_for_activate(msg, time) {
  self endon("disconnect");
  self endon("game_ended");
  self endon(msg);
  if(!self util::is_bot()) {
    return;
  }
  time = int(time + 1);
  randwait = randomint(time);
  wait(randwait);
  self flagsys::set("gadget_resurrect_activated");
  self notify(msg);
}

function do_resurrect_hint_fx() {
  offset = vectorscale((0, 0, 1), 40);
  fxorg = spawn("script_model", self.resurrect_origin + offset);
  fxorg setModel("tag_origin");
  fx = playFXOnTag("player/fx_plyr_revive", fxorg, "tag_origin");
  self waittill("resurrect_time_or_activate");
  fxorg delete();
}

function do_resurrected_on_dead_body_fx() {
  if(isDefined(self.body)) {
    fx = playFX("player/fx_plyr_revive_demat", self.body.origin);
    self.body notsolid();
    self.body ghost();
  }
}

function do_resurrected_on_spawned_player_fx() {
  playsoundatposition("mpl_resurrect_npc", self.origin);
  fx = playFX("player/fx_plyr_rejack_light", self.origin);
}

function resurrect_watch_for_death(slot, weapon) {
  self endon("disconnect");
  self endon("game_ended");
  self waittill("death");
  resurrect_time = 3;
  if(isDefined(weapon.gadget_resurrect_duration)) {
    resurrect_time = weapon.gadget_resurrect_duration / 1000;
  }
  self.usedresurrect = 0;
  self flagsys::clear("gadget_resurrect_activated");
  self flagsys::set("gadget_resurrect_pending");
  self.resurrect_available_time = gettime();
  self thread wait_for_time(resurrect_time, "resurrect_time_or_activate");
  self thread wait_for_activate("resurrect_time_or_activate");
  self thread bot_wait_for_activate("resurrect_time_or_activate", resurrect_time);
  self thread do_resurrect_hint_fx();
  self waittill("resurrect_time_or_activate");
  self flagsys::clear("gadget_resurrect_pending");
  if(self flagsys::get("gadget_resurrect_activated")) {
    self thread do_resurrected_on_dead_body_fx();
    self notify("end_death_delay");
    self notify("end_killcam");
    self.cancelkillcam = 1;
    self.usedresurrect = 1;
    self notify("end_death_delay");
    self notify("force_spawn");
    if(!(isDefined(1) && 1)) {
      self.pers["resetMomentumOnSpawn"] = 0;
    }
    if(isDefined(level.playgadgetsuccess)) {
      self[[level.playgadgetsuccess]](weapon, "resurrectSuccessDelay");
    }
  }
}

function gadget_resurrect_delay_updateteamstatus() {
  if(self flagsys::get("gadget_resurrect_ready")) {
    return true;
  }
  return false;
}

function gadget_resurrect_is_player_predead() {
  should_not_be_dead = 0;
  if(self.sessionstate == "playing" && isalive(self)) {
    should_not_be_dead = 1;
  }
  if(self flagsys::get("gadget_resurrect_pending")) {
    return 1;
  }
  return should_not_be_dead;
}

function gadget_resurrect_secondary_deathcam_time() {
  if(self flagsys::get("gadget_resurrect_pending") && isDefined(self.resurrect_available_time)) {
    resurrect_time = 3000;
    weapon = self.resurrect_weapon;
    if(isDefined(weapon.gadget_resurrect_duration)) {
      resurrect_time = weapon.gadget_resurrect_duration;
    }
    time_left = resurrect_time - (gettime() - self.resurrect_available_time);
    if(time_left > 0) {
      return time_left / 1000;
    }
  }
  return 0;
}

function enter_rejack_standby() {
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  self.rejack_activate_requested = 0;
  if(isDefined(level.resetplayerscorestreaks)) {
    [[level.resetplayerscorestreaks]](self);
  }
  self init_rejack_ui();
  self thread watch_rejack_activate_requested();
  self thread watch_rejack_suicide();
  wait(1.4);
  self thread watch_rejack_activate();
  self thread watch_rejack_timeout();
  self thread watch_bad_trigger_touch();
}

function rejack_suicide() {
  self notify("heroability_off");
  visionset_mgr::deactivate("visionset", "resurrect", self);
  self thread remove_rejack_ui();
  self util::show_hud(1);
  player_suicide();
}

function watch_bad_trigger_touch() {
  self endon("player_input_revive");
  self endon("player_input_suicide");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  a_killbrushes = getEntArray("trigger_hurt", "classname");
  while(true) {
    a_killbrushes = getEntArray("trigger_hurt", "classname");
    for(i = 0; i < a_killbrushes.size; i++) {
      if(self istouching(a_killbrushes[i])) {
        if(!a_killbrushes[i] istriggerenabled()) {
          continue;
        }
        self rejack_suicide();
      }
    }
    if(self oob::istouchinganyoobtrigger()) {
      self rejack_suicide();
    }
    wait(0.05);
  }
}

function watch_rejack_timeout() {
  self endon("player_input_revive");
  self endon("player_input_suicide");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  wait(4);
  self playSound("mpl_rejack_suicide_timeout");
  self thread resurrect_drain_power(-30);
  self rejack_suicide();
}

function watch_rejack_suicide() {
  self endon("player_input_revive");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  while(self usebuttonpressed()) {
    wait(1);
  }
  if(isDefined(self.laststand) && self.laststand) {
    starttime = gettime();
    while(true) {
      if(!self usebuttonpressed()) {
        starttime = gettime();
      }
      if((starttime + 500) < gettime()) {
        self rejack_suicide();
        self playSound("mpl_rejack_suicide");
        return;
      }
      wait(0.01);
    }
  }
}

function reload_clip_on_stand() {
  weapons = self getweaponslistprimaries();
  for(i = 0; i < weapons.size; i++) {
    self reloadweaponammo(weapons[i]);
  }
}

function watch_rejack_activate_requested() {
  self endon("player_input_suicide");
  self endon("player_input_revive");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  while(self offhandspecialbuttonpressed()) {
    wait(0.05);
  }
  self.rejack_activate_requested = 0;
  while(!self.rejack_activate_requested) {
    if(self offhandspecialbuttonpressed()) {
      self.rejack_activate_requested = 1;
    }
    wait(0.05);
  }
}

function watch_rejack_activate() {
  self endon("player_input_suicide");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");
  if(isDefined(self.laststand) && self.laststand) {
    while(true) {
      wait(0.05);
      if(isDefined(self.rejack_activate_requested) && self.rejack_activate_requested) {
        self notify("player_input_revive");
        if(isDefined(level.start_player_health_regen)) {
          self thread[[level.start_player_health_regen]]();
        }
        self._disable_proximity_alarms = 0;
        self thread do_resurrected_on_spawned_player_fx();
        self thread resurrect_drain_power();
        self thread rejack_ui_activate();
        visionset_mgr::deactivate("visionset", "resurrect", self);
        visionset_mgr::activate("visionset", "resurrect_up", self, 0.35, 0.1, 0.2);
        self clientfield::set_to_player("resurrect_state", 2);
        self stopshellshock();
        self reload_clip_on_stand();
        level notify("hero_gadget_activated", self);
        self notify("hero_gadget_activated");
        return;
      }
    }
  }
}

function init_rejack_ui() {
  self clientfield::set_player_uimodel("hudItems.rejack.activationWindowEntered", 1);
  self luinotifyevent(&"create_rejack_timer", 1, gettime() + int(4000));
  self clientfield::set_player_uimodel("hudItems.rejack.rejackActivated", 0);
}

function remove_rejack_ui() {
  self endon("disconnect");
  wait(1.5);
  self clientfield::set_player_uimodel("hudItems.rejack.activationWindowEntered", 0);
  self util::show_hud(1);
}

function rejack_ui_activate() {
  self clientfield::set_player_uimodel("hudItems.rejack.rejackActivated", 1);
  self thread remove_rejack_ui();
}

function player_suicide() {
  self._disable_proximity_alarms = 0;
  self notify("player_input_suicide");
  self clientfield::set_to_player("resurrect_state", 0);
  self thread resurrect_drain_power(-30);
}