/**********************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\abilities\gadgets\_gadget_heat_wave.gsc
**********************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\_burnplayer;
#using scripts\shared\abilities\_ability_gadgets;
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
#using scripts\shared\weapons\_weaponobjects;
#namespace heat_wave;

function autoexec __init__sytem__() {
  system::register("gadget_heat_wave", & __init__, undefined, undefined);
}

function __init__() {
  ability_player::register_gadget_activation_callbacks(41, & gadget_heat_wave_on_activate, & gadget_heat_wave_on_deactivate);
  ability_player::register_gadget_possession_callbacks(41, & gadget_heat_wave_on_give, & gadget_heat_wave_on_take);
  ability_player::register_gadget_flicker_callbacks(41, & gadget_heat_wave_on_flicker);
  ability_player::register_gadget_is_inuse_callbacks(41, & gadget_heat_wave_is_inuse);
  ability_player::register_gadget_is_flickering_callbacks(41, & gadget_heat_wave_is_flickering);
  callback::on_connect( & gadget_heat_wave_on_connect);
  callback::on_spawned( & gadget_heat_wave_on_player_spawn);
  clientfield::register("scriptmover", "heatwave_fx", 1, 1, "int");
  clientfield::register("allplayers", "heatwave_victim", 1, 1, "int");
  clientfield::register("toplayer", "heatwave_activate", 1, 1, "int");
  if(!isDefined(level.vsmgr_prio_visionset_heatwave_activate)) {
    level.vsmgr_prio_visionset_heatwave_activate = 52;
  }
  if(!isDefined(level.vsmgr_prio_visionset_heatwave_charred)) {
    level.vsmgr_prio_visionset_heatwave_charred = 53;
  }
  visionset_mgr::register_info("visionset", "heatwave", 1, level.vsmgr_prio_visionset_heatwave_activate, 16, 1, & visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
  visionset_mgr::register_info("visionset", "charred", 1, level.vsmgr_prio_visionset_heatwave_charred, 16, 1, & visionset_mgr::ramp_in_out_thread_per_player_death_shutdown, 0);
}

function updatedvars() {
  while(true) {
    wait(1);
  }
}

function gadget_heat_wave_is_inuse(slot) {
  return self gadgetisactive(slot);
}

function gadget_heat_wave_is_flickering(slot) {
  return self gadgetflickering(slot);
}

function gadget_heat_wave_on_flicker(slot, weapon) {
  self thread gadget_heat_wave_flicker(slot, weapon);
}

function gadget_heat_wave_on_give(slot, weapon) {}

function gadget_heat_wave_on_take(slot, weapon) {
  self clientfield::set_to_player("heatwave_activate", 0);
}

function gadget_heat_wave_on_connect() {}

function gadget_heat_wave_on_player_spawn() {
  self clientfield::set("heatwave_victim", 0);
  self._heat_wave_stuned_end = 0;
  self._heat_wave_stunned_by = undefined;
  self thread watch_entity_shutdown();
}

function watch_entity_shutdown() {
  self endon("disconnect");
  self waittill("death");
  if(self isremotecontrolling() == 0) {
    visionset_mgr::deactivate("visionset", "charred", self);
    visionset_mgr::deactivate("visionset", "heatwave", self);
  }
}

function gadget_heat_wave_on_activate(slot, weapon) {
  self playrumbleonentity("heat_wave_activate");
  self thread toggle_activate_clientfields();
  visionset_mgr::activate("visionset", "heatwave", self, 0.01, 0.1, 1.1);
  self thread heat_wave_think(slot, weapon);
}

function toggle_activate_clientfields() {
  self endon("death");
  self endon("disconnect");
  self clientfield::set_to_player("heatwave_activate", 1);
  util::wait_network_frame();
  self clientfield::set_to_player("heatwave_activate", 0);
}

function gadget_heat_wave_on_deactivate(slot, weapon) {}

function gadget_heat_wave_flicker(slot, weapon) {}

function set_gadget_status(status, time) {
  timestr = "";
  if(isDefined(time)) {
    timestr = (("^3") + ", time: ") + time;
  }
  if(getdvarint("scr_cpower_debug_prints") > 0) {
    self iprintlnbold(("Gadget Heat Wave: " + status) + timestr);
  }
}

function is_entity_valid(entity, heatwave) {
  if(!isplayer(entity)) {
    return false;
  }
  if(self getentitynumber() == entity getentitynumber()) {
    return false;
  }
  if(!isalive(entity)) {
    return false;
  }
  if(!entity util::mayapplyscreeneffect()) {
    return false;
  }
  if(!heat_wave_trace_entity(entity, heatwave)) {
    return false;
  }
  return true;
}

function heat_wave_trace_entity(entity, heatwave) {
  entitypoint = entity.origin + vectorscale((0, 0, 1), 50);
  if(!bullettracepassed(heatwave.origin, entitypoint, 1, self, undefined, 0, 1)) {
    return false;
  }
  thread util::draw_debug_line(heatwave.origin, entitypoint, 1);
  return true;
}

function heat_wave_fx_cleanup(fxorg, direction) {
  self util::waittill_any("heat_wave_think", "heat_wave_think_finished");
  if(isDefined(fxorg)) {
    fxorg stoploopsound();
    fxorg playSound("gdt_heatwave_dissipate");
    fxorg clientfield::set("heatwave_fx", 0);
    fxorg delete();
  }
}

function heat_wave_fx(origin, direction) {
  if(direction == (0, 0, 0)) {
    direction = (0, 0, 1);
  }
  dirvec = vectornormalize(direction);
  angles = vectortoangles(dirvec);
  fxorg = spawn("script_model", origin + (vectorscale((0, 0, -1), 30)), 0, angles);
  fxorg.angles = angles;
  fxorg setowner(self);
  fxorg setModel("tag_origin");
  fxorg clientfield::set("heatwave_fx", 1);
  fxorg playLoopSound("gdt_heatwave_3p_loop");
  fxorg.soundmod = "heatwave";
  fxorg.hitsomething = 0;
  self thread heat_wave_fx_cleanup(fxorg, direction);
  return fxorg;
}

function heat_wave_setup(weapon) {
  heatwave = spawnStruct();
  heatwave.radius = weapon.gadget_shockfield_radius;
  heatwave.origin = self getEye();
  heatwave.direction = anglesToForward(self getplayerangles());
  heatwave.up = anglestoup(self getplayerangles());
  heatwave.fxorg = heat_wave_fx(heatwave.origin, heatwave.direction);
  return heatwave;
}

function heat_wave_think(slot, weapon) {
  self endon("disconnect");
  self notify("heat_wave_think");
  self endon("heat_wave_think");
  self.heroabilityactive = 1;
  heatwave = heat_wave_setup(weapon);
  glassradiusdamage(heatwave.origin, heatwave.radius, 400, 400, "MOD_BURNED");
  self thread heat_wave_damage_entities(weapon, heatwave);
  self thread heat_wave_damage_projectiles(weapon, heatwave);
  wait(0.25);
  self.heroabilityactive = 0;
  self notify("heat_wave_think_finished");
}

function heat_wave_damage_entities(weapon, heatwave) {
  self endon("disconnect");
  self endon("heat_wave_think");
  starttime = gettime();
  burnedenemy = 0;
  while((250 + starttime) > gettime()) {
    entities = getdamageableentarray(heatwave.origin, heatwave.radius, 1);
    foreach(entity in entities) {
      if(isDefined(entity._heat_wave_damaged_time) && ((entity._heat_wave_damaged_time + 250) + 1) > gettime()) {
        continue;
      }
      if(is_entity_valid(entity, heatwave)) {
        burnedenemy = burnedenemy | heat_wave_burn_entities(weapon, entity, heatwave);
        continue;
      }
      if(!isplayer(entity)) {
        entity dodamage(1, heatwave.origin, self, self, "none", "MOD_BURNED", 0, weapon);
        entity thread update_last_burned_by(heatwave);
      }
    }
    wait(0.05);
  }
  if(isalive(self) && (isDefined(burnedenemy) && burnedenemy) && isDefined(level.playgadgetsuccess)) {
    self[[level.playgadgetsuccess]](weapon, "heatwaveSuccessDelay");
  }
}

function heat_wave_burn_entities(weapon, entity, heatwave) {
  burn_self = 0;
  burn_entity = 1;
  burned_enemy = 1;
  if(self.team == entity.team) {
    burned_enemy = 0;
    switch (level.friendlyfire) {
      case 0: {
        burn_entity = 0;
        break;
      }
      case 1: {
        break;
      }
      case 2: {
        burn_entity = 0;
        burn_self = 1;
        break;
      }
      case 3: {
        burn_self = 1;
        break;
      }
    }
  }
  if(burn_entity) {
    apply_burn(weapon, entity, heatwave);
    entity thread update_last_burned_by(heatwave);
  }
  if(burn_self) {
    apply_burn(weapon, self, heatwave);
    self thread update_last_burned_by(heatwave);
  }
  return burned_enemy;
}

function heat_wave_damage_projectiles(weapon, heatwave) {
  self endon("disconnect");
  self endon("heat_wave_think");
  owner = self;
  starttime = gettime();
  while((250 + starttime) > gettime()) {
    if(level.missileentities.size < 1) {
      wait(0.05);
      continue;
    }
    for(index = 0; index < level.missileentities.size; index++) {
      wait(0.05);
      grenade = level.missileentities[index];
      if(!isDefined(grenade)) {
        continue;
      }
      if(grenade.weapon.istacticalinsertion) {
        continue;
      }
      switch (grenade.model) {
        case "t6_wpn_grenade_supply_projectile": {
          continue;
        }
      }
      if(!isDefined(grenade.owner)) {
        grenade.owner = getmissileowner(grenade);
      }
      if(isDefined(grenade.owner)) {
        if(level.teambased) {
          if(grenade.owner.team == owner.team) {
            continue;
          }
        } else if(grenade.owner == owner) {
          continue;
        }
        grenadedistancesquared = distancesquared(grenade.origin, heatwave.origin);
        if(grenadedistancesquared < (heatwave.radius * heatwave.radius)) {
          if(bullettracepassed(grenade.origin, heatwave.origin + vectorscale((0, 0, 1), 29), 0, owner, grenade, 0, 1)) {
            owner projectileexplode(grenade, heatwave, weapon);
            index--;
          }
        }
      }
    }
  }
}

function projectileexplode(projectile, heatwave, weapon) {
  projposition = projectile.origin;
  playFX(level.trophydetonationfx, projposition);
  projectile notify("trophy_destroyed");
  self radiusdamage(projposition, 128, 105, 10, self, "MOD_BURNED", weapon);
  projectile delete();
}

function apply_burn(weapon, entity, heatwave) {
  damage = floor(entity.health * 0.2);
  entity dodamage(damage, self.origin + vectorscale((0, 0, 1), 30), self, heatwave.fxorg, 0, "MOD_BURNED", 0, weapon);
  entity setdoublejumpenergy(0);
  entity clientfield::set("heatwave_victim", 1);
  visionset_mgr::activate("visionset", "charred", entity, 0.01, 2, 1.5);
  entity thread watch_burn_clear();
  entity resetdoublejumprechargetime();
  shellshock_duration = 2.5;
  entity._heat_wave_stuned_end = gettime() + (shellshock_duration * 1000);
  if(!isDefined(entity._heat_wave_stunned_by)) {
    entity._heat_wave_stunned_by = [];
  }
  entity._heat_wave_stunned_by[self.clientid] = entity._heat_wave_stuned_end;
  entity shellshock("heat_wave", shellshock_duration, 1);
  entity thread heat_wave_burn_sound(shellshock_duration);
  burned = 1;
}

function watch_burn_clear() {
  self endon("disconnect");
  self endon("death");
  util::wait_network_frame();
  self clientfield::set("heatwave_victim", 0);
}

function update_last_burned_by(heatwave) {
  self endon("disconnect");
  self endon("death");
  self._heat_wave_damaged_time = gettime();
  wait(250);
}

function heat_wave_burn_sound(shellshock_duration) {
  fire_sound_ent = spawn("script_origin", self.origin);
  fire_sound_ent linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  fire_sound_ent playLoopSound("mpl_heatwave_burn_loop");
  wait(shellshock_duration);
  if(isDefined(fire_sound_ent)) {
    fire_sound_ent stoploopsound(0.5);
    util::wait_network_frame();
    fire_sound_ent delete();
  }
}