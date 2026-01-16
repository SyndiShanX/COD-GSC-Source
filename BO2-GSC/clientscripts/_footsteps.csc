/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_footsteps.csc
****************************************/

#include clientscripts\_audio;
#include clientscripts\_utility;

init() {
  setaifootstepprepend("fly_step_run_npc_");
  level.vehiclefootstepcallbacks = [];
}

playerjump(client_num, player, ground_type, firstperson, quiet) {
  sound_alias = buildmovementsoundaliasname("step_run", ground_type, firstperson, quiet);
  player playsound(client_num, sound_alias);
}

playerland(client_num, player, ground_type, firstperson, quiet, damageplayer) {
  sound_alias = buildmovementsoundaliasname("land", ground_type, firstperson, quiet);
  player playsound(client_num, sound_alias);

  if(isDefined(player.step_sound) && !quiet && player.step_sound != "none") {
    volume = clientscripts\_audio::get_vol_from_speed(player);
    player playsound(client_num, player.step_sound, player.origin, volume);
  }

  if(damageplayer) {
    sound_alias = "fly_land_damage_npc";

    if(firstperson) {
      sound_alias = "fly_land_damage_plr";
      player playsound(client_num, sound_alias);
    }
  }
}

playerfoliage(client_num, player, firstperson, quiet) {
  sound_alias = "fly_movement_foliage_npc";

  if(firstperson)
    sound_alias = "fly_movement_foliage_plr";

  player playsound(client_num, sound_alias);
}

setaifootstepprepend(prepend) {
  level.footstepprepend = prepend;
}

getaiboneorigin(note) {
  assert(isDefined(level.footstepbones));
  boneorigin = (0, 0, 0);
  bonename = level.footstepbones[note];

  if(isDefined(bonename))
    boneorigin = self gettagorigin(bonename);

  if(!isDefined(boneorigin))
    boneorigin = self.origin;

  return boneorigin;
}

missing_ai_footstep_callback() {
  type = self._aitype;

  if(!isDefined(type))
    type = "unknown";

  println("*** Ai type : " + type + " has a client-script footstep script callback specified, but has no callback specified.Call _footsteps::RegisterAITypeFootstepCB(\"" + self._aitype + "\", ::yourcbfunc); in your level main .csc file.");
}

registeraitypefootstepcb(aitype, func) {
  if(!isDefined(level._footstepcbfuncs))
    level._footstepcbfuncs = [];

  if(isDefined(level._footstepcbfuncs[aitype])) {
    println("Attempting to register footstep callback function for ai type " + aitype + " multiple times.");

    return;
  }

  level._footstepcbfuncs[aitype] = func;
}

bigdogfootstepcbfunc(client_num, pos, surface, notetrack, bone) {
  sound_alias = undefined;

  if(issubstr(notetrack, "small"))
    sound_alias = "fly_step_walk_bigdog_" + surface;
  else if(issubstr(notetrack, "shuffle"))
    sound_alias = "fly_step_turn_bigdog_" + surface;
  else if(issubstr(notetrack, "scrape")) {
    sound_alias = "fly_step_scrape_bigdog_" + surface;

    if(!isDefined(level._effect[self.species]) || !isDefined(level._effect[self.species]["step_sparks"]))
      clientscripts\_utility::setfootstepeffect("sparks", loadfx("destructibles/fx_claw_metal_scrape_sparks"), "bigdog");

    if(isDefined(level._effect[self.species]["step_sparks"]))
      self thread playscrapeforframes(client_num, level._effect[self.species]["step_sparks"], bone, 15);
  } else
    sound_alias = "fly_step_run_bigdog_" + surface;

  if(isDefined(sound_alias))
    playsound(client_num, sound_alias, pos);

  footstepdofootstepfx();
}

playaifootstep(client_num, pos, surface, notetrack, bone) {
  if(!isDefined(self._aitype)) {
    println("*** Client script footstep callback on an entity that doesn't have an _aitype defined.Ignoring.");

    footstepdoeverything();
    return;
  }

  if(!isDefined(level._footstepcbfuncs) || !isDefined(level._footstepcbfuncs[self._aitype])) {
    self missing_ai_footstep_callback();
    footstepdoeverything();
    return;
  }

  [[level._footstepcbfuncs[self._aitype]]](client_num, pos, surface, notetrack, bone);
}

playscrapeforframes(client_num, effect, tag, frames) {
  self endon("death");
  offsetvec = vectorscale((0, 0, 1), 30.0);
  prevorigin = self.origin;
  forward = anglestoforward(self.angles);
  forward = vectorscale(forward, -1);

  for(i = 0; isDefined(self) && i < frames; i++) {
    boneorigin = self gettagorigin(tag);
    surfacetrace = tracepoint(boneorigin, boneorigin - offsetvec);
    groundpos = surfacetrace["position"];
    playfx(client_num, effect, groundpos, forward, (0, 0, 1));
    wait 0.01;

    if(isDefined(self) && distancesquared(self.origin, prevorigin) > 1) {
      forward = vectornormalize(self.origin - prevorigin);
      forward = vectorscale(forward, -1);
      prevorigin = self.origin;
    }
  }
}

buildmovementsoundaliasname(movementtype, ground_type, firstperson, quiet) {
  if(firstperson && isDefined(level.snd_footstep_override_plr) && level.snd_footstep_override_plr != "")
    return level.snd_footstep_override_plr;

  if(!firstperson && isDefined(level.snd_footstep_override_npc) && level.snd_footstep_override_npc != "")
    return level.snd_footstep_override_npc;

  sound_alias = "fly_";

  if(quiet)
    sound_alias = sound_alias + "q";

  sound_alias = sound_alias + movementtype;

  if(firstperson)
    sound_alias = sound_alias + "_plr_";
  else
    sound_alias = sound_alias + "_npc_";

  sound_alias = sound_alias + ground_type;
  return sound_alias;
}

do_foot_effect(client_num, ground_type, foot_pos, on_fire) {
  if(on_fire)
    ground_type = "fire";

  if(getdvarint(#"_id_49A098B5"))
    print3d(foot_pos, ground_type, (0.5, 0.5, 0.8), 1, 3, 30);

  effectname = "step_" + ground_type;

  if(isDefined(level._effect)) {
    effect = undefined;

    if(self.type == "actor" && isDefined(level._effect[self.species]) && isDefined(level._effect[self.species][effectname]))
      effect = level._effect[self.species][effectname];
    else if(isDefined(level._effect["human"]) && isDefined(level._effect["human"][effectname]))
      effect = level._effect["human"][effectname];

    if(isDefined(effect))
      playfx(client_num, effect, foot_pos, foot_pos + vectorscale((0, 0, 1), 100.0));
  }
}

registervehiclefootstepcallback(type, callback) {
  level.vehiclefootstepcallbacks[type] = callback;
}

playvehiclefootstep(client_num, note, ground_type) {
  if(isDefined(level.vehiclefootstepcallbacks[self.vehicletype]))
    self thread[[level.vehiclefootstepcallbacks[self.vehicletype]]](client_num, note, ground_type);
}