/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_vision_pulse.gsc
*****************************************************/

#include scripts\abilities\ability_player;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\gestures;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\util_shared;
#include scripts\core_common\visionset_mgr_shared;

#namespace gadget_vision_pulse;

init_shared() {
  level.weaponvisionpulse = getweapon(#"gadget_vision_pulse");
  ability_player::register_gadget_activation_callbacks(4, &gadget_vision_pulse_on, &gadget_vision_pulse_off);
  ability_player::register_gadget_flicker_callbacks(4, &gadget_vision_pulse_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(4, &gadget_vision_pulse_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(4, &gadget_vision_pulse_is_flickering);
  ability_player::function_92292af6(4, undefined, &deployed_off);
  callback::on_spawned(&gadget_vision_pulse_on_spawn);
  clientfield::register("toplayer", "vision_pulse_active", 1, 1, "int");
  clientfield::register("toplayer", "toggle_postfx", 1, 1, "int");

  if(!isDefined(level.vsmgr_prio_visionset_visionpulse)) {
    level.vsmgr_prio_visionset_visionpulse = 61;
  }

  visionset_mgr::register_info("visionset", "vision_pulse", 1, level.vsmgr_prio_visionset_visionpulse, 12, 1, &visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
  globallogic_score::register_kill_callback(level.weaponvisionpulse, &is_pulsed);
  globallogic_score::function_86f90713(level.weaponvisionpulse, &is_pulsed);
  level.shutdown_vision_pulse = &shutdown_vision_pulse;
}

deployed_off(slot, weapon) {
  self gadgetpowerset(slot, 0);
}

is_pulsed(attacker, victim, weapon, attackerweapon, meansofdeath) {
  return isDefined(attacker._pulse_ent) && isDefined(victim.ispulsed) && victim.ispulsed;
}

function_f5632baf(func) {
  level.var_fc3478b7 = func;
}

gadget_vision_pulse_is_inuse(slot) {
  return self flagsys::get(#"gadget_vision_pulse_on");
}

gadget_vision_pulse_is_flickering(slot) {
  return self gadgetflickering(slot);
}

gadget_vision_pulse_on_flicker(slot, weapon) {
  self thread gadget_vision_pulse_flicker(slot, weapon);
}

gadget_vision_pulse_on_spawn() {
  self.visionpulseactivatetime = 0;
  self.visionpulsearray = [];
  self.visionpulseorigin = undefined;
  self.visionpulseoriginarray = [];

  if(isDefined(self._pulse_ent)) {
    self._pulse_ent delete();
  }
}

gadget_vision_pulse_ramp_hold_func() {
  self waittilltimeout(float(level.weaponvisionpulse.var_4d88a1ff) / 1000 - 0.35, #"ramp_out_visionset");
}

gadget_vision_pulse_watch_death(slot, weapon) {
  self notify(#"vision_pulse_watch_death");
  self endon(#"vision_pulse_watch_death", #"disconnect");
  self waittill(#"death");
  self endon(#"shutdown_vision_pulse");

  if(isDefined(self._pulse_ent)) {
    self._pulse_ent delete();
    self ability_player::function_f2250880(weapon, 0);
  }

  slot = self gadgetgetslot(getweapon(#"gadget_vision_pulse"));
  self gadgetcharging(slot, 1);
  self flagsys::clear(#"gadget_vision_pulse_on");
  self globallogic_score::function_d3ca3608(#"hash_32591f4be1bf4f22");
}

gadget_vision_pulse_watch_emp(slot, weapon) {
  self notify(#"vision_pulse_watch_emp");
  self endon(#"vision_pulse_watch_emp", #"disconnect", #"shutdown_vision_pulse");

  while(true) {
    if(self isempjammed()) {
      self notify(#"emp_vp_jammed");
      break;
    }

    waitframe(1);
  }

  if(isDefined(self._pulse_ent)) {
    self._pulse_ent delete();
  }

  self flagsys::clear(#"gadget_vision_pulse_on");
}

function_46f384d5() {
  self notify(#"remote_control");
  self endon(#"remote_control", #"disconnect", #"death", #"shutdown_vision_pulse");

  while(true) {
    if(self isremotecontrolling() || self clientfield::get_to_player("remote_missile_screenfx") != 0) {
      self clientfield::set_to_player("toggle_postfx", 1);

      while(self isremotecontrolling() || self clientfield::get_to_player("remote_missile_screenfx") != 0) {
        waitframe(1);
      }

      self clientfield::set_to_player("toggle_postfx", 0);
    }

    waitframe(1);
  }
}

gadget_vision_pulse_on(slot, weapon) {
  if(isDefined(self._pulse_ent)) {
    return;
  }

  self notify(#"vision_pulse_on");
  self flagsys::set(#"gadget_vision_pulse_on");
  self thread gadget_vision_pulse_start(slot, weapon);

  if(!(isDefined(level.var_e3049e92) && level.var_e3049e92)) {
    self thread function_46f384d5();
  }

  self thread gadget_vision_pulse_watch_death(slot, weapon);
  self thread gadget_vision_pulse_watch_emp(slot, weapon);
  self clientfield::set_to_player("vision_pulse_active", 1);
}

gadget_vision_pulse_off(slot, weapon) {
  self.visionpulsekill = 0;
}

gadget_vision_pulse_start(slot, weapon) {
  self endon(#"disconnect", #"death", #"emp_vp_jammed", #"shutdown_vision_pulse", #"hash_7e581b90612825f4");
  wait 0.1;

  if(isDefined(self._pulse_ent)) {
    return;
  }

  self ability_player::function_c22f319e(weapon);
  self._pulse_ent = spawn("script_model", self.origin);
  self._pulse_ent setModel(#"tag_origin");
  self gadgetsetentity(slot, self._pulse_ent);
  self gadgetsetactivatetime(slot, gettime());
  self set_gadget_vision_pulse_status("Activated");
  self.visionpulseactivatetime = gettime();
  enemyarray = level.players;
  visionpulsearray = arraysort(enemyarray, self._pulse_ent.origin, 1, undefined, weapon.gadget_pulse_max_range);
  self.var_1ad61d27 = weapon;
  self.visionpulseorigin = self._pulse_ent.origin;
  self.visionpulsearray = [];
  self.visionpulseoriginarray = [];
  spottedenemy = 0;
  self.visionpulsespottedenemy = [];
  self.visionpulsespottedenemytime = gettime();

  for(i = 0; i < visionpulsearray.size; i++) {
    self.visionpulsearray[self.visionpulsearray.size] = visionpulsearray[i];
    self.visionpulseoriginarray[self.visionpulseoriginarray.size] = visionpulsearray[i].origin;

    if(isalive(visionpulsearray[i]) && util::function_fbce7263(visionpulsearray[i].team, self.team)) {
      if(isDefined(level.var_fc3478b7)) {
        self[[level.var_fc3478b7]](visionpulsearray[i]);
      }

      spottedenemy = 1;
      self.visionpulsespottedenemy[self.visionpulsespottedenemy.size] = visionpulsearray[i];
      visionpulsearray[i].lastvisionpulsedby = self;
      visionpulsearray[i].lastvisionpulsedtime = self.visionpulsespottedenemytime;
    }
  }

  if(isDefined(level.var_392ddea)) {
    self thread[[level.var_392ddea]]();
  }

  self thread function_19bef771(weapon);
  self wait_until_is_done(slot, self._gadgets_player[slot].gadget_pulse_duration);
  self shutdown_vision_pulse(spottedenemy, 0, weapon);
}

shutdown_vision_pulse(spottedenemy, immediate, weapon) {
  self notify(#"vision_pulse_off");
  self.var_87b1ba00 = 0;

  if(!spottedenemy) {
    self playsoundtoplayer("gdt_vision_pulse_no_hits", self);
    self notify(#"ramp_out_visionset");
  }

  self set_gadget_vision_pulse_status("Done");
  self flagsys::clear(#"gadget_vision_pulse_on");
  self clientfield::set_to_player("vision_pulse_active", 0);
  self notify(#"remote_control");

  if(isDefined(self._pulse_ent)) {
    self._pulse_ent delete();
  }

  if(immediate) {
    self notify(#"hash_7e581b90612825f4");
    self ability_player::function_f2250880(weapon, 0);
  }
}

function_19bef771(weapon) {
  self endon(#"death", #"shutdown_vision_pulse", #"hash_7e581b90612825f4");
  wait float(weapon.var_4d88a1ff) / 1000;
  self disableoffhandweapons();
  self switchtooffhand(level.weaponvisionpulse);
  waitframe(1);
  self ability_player::function_f2250880(weapon, 0);
  played = 0;

  while(!played) {
    played = self gestures::function_b6cc48ed("ges_vision_pulse_deactivate", undefined, 1);
    waitframe(1);
  }

  self enableoffhandweapons();
}

wait_until_is_done(slot, timepulse) {
  self endon(#"hash_7e581b90612825f4", #"shutdown_vision_pulse", #"death");
  wait float(timepulse) / 1000;
  self globallogic_score::function_d3ca3608(#"hash_32591f4be1bf4f22");
}

gadget_vision_pulse_flicker(slot, weapon) {
  self endon(#"disconnect");
  time = gettime();

  if(!self gadget_vision_pulse_is_inuse(slot)) {
    return;
  }

  eventtime = self._gadgets_player[slot].gadget_flickertime;
  self set_gadget_vision_pulse_status("^1" + "Flickering.", eventtime);

  while(true) {
    if(!self gadgetflickering(slot)) {
      set_gadget_vision_pulse_status("^2" + "Normal");
      return;
    }

    wait 0.25;
  }
}

set_gadget_vision_pulse_status(status, time) {
  timestr = "";

  if(isDefined(time)) {
    timestr = "^3" + ", time: " + time;
  }

  if(getdvarint(#"scr_cpower_debug_prints", 0) > 0) {
    self iprintlnbold("Vision Pulse:" + status + timestr);
  }
}