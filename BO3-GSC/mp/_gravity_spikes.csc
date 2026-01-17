/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\_gravity_spikes.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\_explode;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace gravity_spikes;

function autoexec __init__sytem__() {
  system::register("gravity_spikes", &__init__, undefined, undefined);
}

function __init__() {
  level._effect["gravity_spike_dust"] = "weapon/fx_hero_grvity_spk_grnd_hit_dust";
  level.gravity_spike_table = "surface_explosion_gravityspikes";
  level thread watchforgravityspikeexplosion();
  level.dirt_enable_gravity_spikes = getdvarint("scr_dirt_enable_gravity_spikes", 0);
  level thread updatedvars();
}

function updatedvars() {
  while(true) {
    level.dirt_enable_gravity_spikes = getdvarint("", level.dirt_enable_gravity_spikes);
    wait(1);
  }
}

function watchforgravityspikeexplosion() {
  if(getactivelocalclients() > 1) {
    return;
  }
  weapon_proximity = getweapon("hero_gravityspikes");
  while(true) {
    level waittill("explode", localclientnum, position, mod, weapon, owner_cent);
    if(weapon.rootweapon != weapon_proximity) {
      continue;
    }
    if(isDefined(owner_cent) && getlocalplayer(localclientnum) == owner_cent && level.dirt_enable_gravity_spikes) {
      owner_cent thread explode::dothedirty(localclientnum, 0, 1, 0, 1000, 500);
    }
    thread do_gravity_spike_fx(localclientnum, owner_cent, weapon, position);
    thread audio::dorattle(position, 200, 700);
  }
}

function do_gravity_spike_fx(localclientnum, owner, weapon, position) {
  radius_of_effect = 40;
  number_of_circles = 3;
  base_number_of_effects = 3;
  additional_number_of_effects_per_circle = 7;
  explosion_radius = weapon.explosionradius;
  radius_per_circle = (explosion_radius - radius_of_effect) / number_of_circles;
  for(circle = 0; circle < number_of_circles; circle++) {
    wait(0.1);
    radius_for_this_circle = radius_per_circle * (circle + 1);
    number_for_this_circle = base_number_of_effects + (additional_number_of_effects_per_circle * circle);
    thread do_gravity_spike_fx_circle(localclientnum, owner, position, radius_for_this_circle, number_for_this_circle);
  }
}

function getideallocationforfx(startpos, fxindex, fxcount, defaultdistance, rotation) {
  currentangle = (360 / fxcount) * fxindex;
  coscurrent = cos(currentangle + rotation);
  sincurrent = sin(currentangle + rotation);
  return startpos + (defaultdistance * coscurrent, defaultdistance * sincurrent, 0);
}

function randomizelocation(startpos, max_x_offset, max_y_offset) {
  half_x = int(max_x_offset / 2);
  half_y = int(max_y_offset / 2);
  rand_x = randomintrange(half_x * -1, half_x);
  rand_y = randomintrange(half_y * -1, half_y);
  return startpos + (rand_x, rand_y, 0);
}

function ground_trace(startpos, owner) {
  trace_height = 50;
  trace_depth = 100;
  return bulletTrace(startpos + (0, 0, trace_height), startpos - (0, 0, trace_depth), 0, owner);
}

function do_gravity_spike_fx_circle(localclientnum, owner, center, radius, count) {
  segment = 360 / count;
  up = (0, 0, 1);
  randomization = 40;
  sphere_size = 5;
  for(i = 0; i < count; i++) {
    fx_position = getideallocationforfx(center, i, count, radius, 0);
    fx_position = randomizelocation(fx_position, randomization, randomization);
    trace = ground_trace(fx_position, owner);
    if(trace["fraction"] < 1) {
      fx = getfxfromsurfacetable(level.gravity_spike_table, trace["surfacetype"]);
      if(isDefined(fx)) {
        angles = (0, randomintrange(0, 359), 0);
        forward = anglesToForward(angles);
        normal = trace["normal"];
        if(lengthsquared(normal) == 0) {
          normal = (1, 0, 0);
        }
        playFX(localclientnum, fx, trace["position"], normal, forward);
      }
    } else {}
    wait(0.016);
  }
}