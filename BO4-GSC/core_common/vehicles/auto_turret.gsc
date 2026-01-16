/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\vehicles\auto_turret.gsc
************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\influencers_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\turret_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_ai_shared;
#include scripts\core_common\vehicle_shared;

#namespace auto_turret;

autoexec __init__system__() {
  system::register(#"auto_turret", &__init__, undefined, undefined);
}

__init__() {
  vehicle::add_main_callback("auto_turret", &function_f17009ff);
}

function_b07539aa() {
  self.health = self.healthdefault;

  if(isDefined(self.scriptbundlesettings)) {
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  } else {
    self.settings = struct::get_script_bundle("vehiclecustomsettings", "artillerysettings");
  }

  targetoffset = (isDefined(self.settings.lockon_offsetx) ? self.settings.lockon_offsetx : 0, isDefined(self.settings.lockon_offsety) ? self.settings.lockon_offsety : 0, isDefined(self.settings.lockon_offsetz) ? self.settings.lockon_offsetz : 0);
  vehicle::make_targetable(self, targetoffset);
  sightfov = self.settings.sightfov;

  if(!isDefined(sightfov)) {
    sightfov = 0;
  }

  if(sightfov == 0) {
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
  } else {
    self.fovcosine = cos(sightfov - 0.1);
    self.fovcosinebusy = cos(sightfov - 0.1);
  }

  if(self.settings.disconnectpaths === 1) {
    self disconnectpaths(1);
  }

  if(self.settings.ignoreme === 1) {
    self val::set(#"auto_turret", "ignoreme", 1);
  }

  if(self.settings.laseron === 1) {
    self laseron();
  }

  if(self.settings.disablefiring !== 1) {
    self enableaimassist();
  } else {
    self.nocybercom = 1;
  }

  self.overridevehicledamage = &turretcallback_vehicledamage;
  self.allowfriendlyfiredamageoverride = &turretallowfriendlyfiredamage;

  if(isDefined(self.var_37e3fb9c) && self.var_37e3fb9c) {
    self influencers::create_influencer_generic("enemy", self.origin, self.team, 1);
  }

  if(isDefined(self.settings.keylinerender) && self.settings.keylinerender) {
    self clientfield::set("turret_keyline_render", 1);
  }

  if(isDefined(level.vehicle_initializer_cb)) {
    [[level.vehicle_initializer_cb]](self);
  }

  if(isDefined(self.settings.var_d3cc01c7) && self.settings.var_d3cc01c7 && !(isDefined(self.has_bad_place) && self.has_bad_place)) {
    if(!isDefined(level.var_c70c6768)) {
      level.var_c70c6768 = 0;
    } else {
      level.var_c70c6768 += 1;
    }

    self.turret_id = string(level.var_c70c6768);
    badplace_cylinder("turret_bad_place_" + self.turret_id, 0, self.origin, self.settings.var_9493f6dc, self.settings.var_c9c01aa4, #"axis", #"allies", #"neutral");
    self.has_bad_place = 1;
  }

  if(isDefined(self.settings.cleanup_after_time) && self.settings.cleanup_after_time > 0) {
    self.cleanup_after_time = self.settings.cleanup_after_time;
  }

  self callback::function_d8abfc3d(#"on_vehicle_killed", &function_3dda565d);
}

function_f17009ff() {
  function_b07539aa();
  function_bc23ad6e();
}

function_bc23ad6e() {
  self vehicle_ai::init_state_machine_for_role("default");
  self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
  self vehicle_ai::get_state_callbacks("combat").update_func = &function_f2d20a04;
  self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
  self vehicle_ai::get_state_callbacks("off").enter_func = &state_off_enter;
  self vehicle_ai::get_state_callbacks("off").exit_func = &state_off_exit;
  self vehicle_ai::get_state_callbacks("emped").enter_func = &state_emped_enter;
  self vehicle_ai::get_state_callbacks("emped").update_func = &state_emped_update;
  self vehicle_ai::get_state_callbacks("emped").exit_func = &state_emped_exit;
  self vehicle_ai::add_state("unaware", undefined, &state_unaware_update, undefined);
  vehicle_ai::add_interrupt_connection("unaware", "scripted", "enter_scripted");
  vehicle_ai::add_interrupt_connection("unaware", "emped", "emped");
  vehicle_ai::add_interrupt_connection("unaware", "off", "shut_off");
  vehicle_ai::add_interrupt_connection("unaware", "driving", "enter_vehicle");
  vehicle_ai::add_interrupt_connection("unaware", "pain", "pain");
  vehicle_ai::add_utility_connection("unaware", "combat", &should_switch_to_combat);
  vehicle_ai::add_utility_connection("combat", "unaware", &should_switch_to_unaware);
  vehicle_ai::startinitialstate("unaware");
}

state_death_update(params) {
  self endon(#"death");
  owner = self getvehicleowner();

  if(isDefined(owner)) {
    self waittill(#"exit_vehicle");
  }

  self setturretspinning(0);
  self turret::toggle_lensflare(0);

  if(isDefined(self.has_bad_place) && self.has_bad_place) {
    badplace_delete("turret_bad_place_" + self.turret_id);
    self.has_bad_place = 0;
  }

  if(target_istarget(self)) {
    target_remove(self);
  }

  self thread turret_idle_sound_stop();
  self playSound(#"veh_sentry_turret_dmg_hit");
  self.turretrotscale = 2;
  self rest_turret(params.resting_pitch);
  self vehicle_ai::defaultstate_death_update(params);

  if(isDefined(self.settings.keylinerender) && self.settings.keylinerender) {
    self clientfield::set("turret_keyline_render", 0);
  }
}

should_switch_to_unaware(current_state, to_state, connection) {
  if(!isDefined(self.enemy) || !self seerecently(self.enemy, 1.5)) {
    return 100;
  }

  return 0;
}

state_unaware_update(params) {
  self endon(#"death");
  self endon(#"change_state");
  turret_left = 1;
  relativeangle = 0;
  self thread turret_idle_sound();
  self playSound(#"mpl_turret_startup");
  self turretcleartarget(0);

  while(true) {
    rotscale = self.settings.scanning_speedscale;

    if(!isDefined(rotscale)) {
      rotscale = 0.01;
    }

    self.turretrotscale = rotscale;
    scanning_arc = self.settings.scanning_arc;

    if(!isDefined(scanning_arc)) {
      scanning_arc = 0;
    }

    limits = self getturretlimitsyaw();
    scanning_arc = min(scanning_arc, limits[0] - 0.1);
    scanning_arc = min(scanning_arc, limits[1] - 0.1);

    if(scanning_arc > 179) {
      if(self.turretontarget) {
        relativeangle += 90;

        if(relativeangle > 180) {
          relativeangle -= 360;
        }
      }

      scanning_arc = relativeangle;
    } else {
      if(self.turretontarget) {
        turret_left = !turret_left;
      }

      if(!turret_left) {
        scanning_arc *= -1;
      }
    }

    scanning_pitch = self.settings.scanning_pitch;

    if(!isDefined(scanning_pitch)) {
      scanning_pitch = 0;
    }

    self turretsettargetangles(0, (scanning_pitch, scanning_arc, 0));
    self vehicle_ai::evaluate_connections();
    wait 0.5;
  }
}

should_switch_to_combat(current_state, to_state, connection) {
  if(isDefined(self.enemy) && isalive(self.enemy) && self cansee(self.enemy)) {
    return 100;
  }

  return 0;
}

function_f2d20a04(params) {
  self endon(#"death");
  self endon(#"change_state");

  if(isDefined(self.enemy)) {
    sentry_turret_alert_sound();
    wait 0.5;
  }

  while(true) {
    if(isDefined(self.enemy) && self cansee(self.enemy)) {
      self.turretrotscale = 1;

      if(isDefined(self.enemy) && self haspart("tag_minigun_spin")) {
        self turretsettarget(0, self.enemy);
        self setturretspinning(1);
        wait 0.5;
      }

      for(i = 0; i < 3; i++) {
        if(isDefined(self.enemy) && isalive(self.enemy) && self cansee(self.enemy)) {
          self turretsettarget(0, self.enemy);
          wait 0.1;
          waittime = randomfloatrange(self.settings.var_ddd34f14, self.settings.var_80f38c52);

          if(self.settings.disablefiring !== 1) {
            self sentry_turret_fire_for_time(waittime, self.enemy);
          } else {
            wait waittime;
          }
        }

        if(isDefined(self.enemy) && isplayer(self.enemy)) {
          wait randomfloatrange(self.settings.var_77e64d20, self.settings.var_d4e8eb34);
          continue;
        }

        wait randomfloatrange(self.settings.var_dd6ae92f, self.settings.var_be5db78d);
      }

      self setturretspinning(0);

      if(isDefined(self.enemy) && isalive(self.enemy) && self cansee(self.enemy)) {
        if(isplayer(self.enemy)) {
          wait randomfloatrange(0.5, 1.3);
        } else {
          wait randomfloatrange(0.5, 1.3) * 2;
        }
      }
    }

    self vehicle_ai::evaluate_connections();

    if(isDefined(self.var_4578b9df) && isDefined(self.var_b7bc4c2f)) {
      n_cooldown_time = randomfloatrange(self.var_4578b9df, self.var_b7bc4c2f);
    } else {
      n_cooldown_time = 0.5;
    }

    wait n_cooldown_time;
  }
}

state_combat_exit(params) {
  self setturretspinning(0);
}

sentry_turret_fire_for_time(totalfiretime, enemy) {
  self endon(#"death");
  self endon(#"change_state");
  sentry_turret_alert_sound();
  wait 0.1;
  weapon = self seatgetweapon(0);
  firetime = weapon.firetime;
  time = 0;
  is_minigun = 0;

  while(time < totalfiretime) {
    self fireweapon(0, enemy);
    wait firetime;
    time += firetime;
  }

  if(is_minigun) {
    self setturretspinning(0);
  }
}

state_off_enter(params) {
  self vehicle_ai::defaultstate_off_enter(params);
  self.turretrotscale = 0.5;
  self rest_turret(params.resting_pitch);
}

state_off_exit(params) {
  self vehicle_ai::defaultstate_off_exit(params);
  self.turretrotscale = 1;
  self playSound(#"mpl_turret_startup");
}

rest_turret(resting_pitch = self.settings.resting_pitch) {
  if(!isDefined(resting_pitch)) {
    resting_pitch = 0;
  }

  angles = self gettagangles("tag_turret") - self.angles;
  self turretsettargetangles(0, (resting_pitch, angles[1], 0));
}

state_emped_enter(params) {
  self vehicle_ai::defaultstate_emped_enter(params);
  playsoundatposition(#"veh_sentry_turret_emp_down", self.origin);
  self.turretrotscale = 0.5;
  self rest_turret(params.resting_pitch);
  params.laseron = islaseron(self);
  self laseroff();
  self vehicle::lights_off();

  if(!isDefined(self.abnormal_status)) {
    self.abnormal_status = spawnStruct();
  }

  self.abnormal_status.emped = 1;
  self.abnormal_status.attacker = params.param1;
  self.abnormal_status.inflictor = params.param2;
  self vehicle::toggle_emp_fx(1);
}

state_emped_update(params) {
  self endon(#"death");
  self endon(#"change_state");
  time = params.param0;
  assert(isDefined(time));
  util::cooldown("emped_timer", time);

  while(!util::iscooldownready("emped_timer")) {
    timeleft = max(util::getcooldownleft("emped_timer"), 0.5);
    wait timeleft;
  }

  self.abnormal_status.emped = 0;
  self vehicle::toggle_emp_fx(0);
  self vehicle_ai::emp_startup_fx();
  self rest_turret(0);
  wait 1;
  self vehicle_ai::evaluate_connections();
}

state_emped_exit(params) {
  self vehicle_ai::defaultstate_emped_exit(params);
  self.turretrotscale = 1;
  self playSound(#"mpl_turret_startup");
}

state_scripted_update(params) {
  self.turretrotscale = 1;
}

turretallowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
  if(isDefined(self.owner) && eattacker == self.owner && isDefined(self.settings.friendly_fire) && int(self.settings.friendly_fire) && !weapon.isemp) {
    return true;
  }

  if(isDefined(eattacker) && isDefined(eattacker.archetype) && isDefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE") {
    return true;
  }

  return false;
}

turretcallback_vehicledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
  return idamage;
}

sentry_turret_alert_sound() {
  self playSound(#"veh_turret_alert");
}

turret_idle_sound() {
  if(!isDefined(self.sndloop_ent)) {
    self.sndloop_ent = spawn("script_origin", self.origin);
    self.sndloop_ent linkto(self);
    self.sndloop_ent playLoopSound(#"veh_turret_idle");
    self.sndloop_ent thread function_5d665d67(self);
  }
}

function_862359b8() {
  self endon(#"death");

  if(isDefined(self)) {
    self stoploopsound(0.5);
    wait 2;

    if(isDefined(self)) {
      self delete();
    }
  }
}

function_5d665d67(turret) {
  self endon(#"death");
  turret waittill(#"death");
  self function_862359b8();
}

turret_idle_sound_stop() {
  self endon(#"death");

  if(isDefined(self.sndloop_ent)) {
    self.sndloop_ent function_862359b8();
  }
}

function_3dda565d(params) {
  if(isDefined(self.vehicletype) && isDefined(self.var_37e3fb9c) && self.var_37e3fb9c) {
    self influencers::remove_influencers();
  }
}