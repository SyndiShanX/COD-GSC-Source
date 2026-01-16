/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\footsteps_shared.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\system_shared;
#namespace footsteps;

function autoexec __init__sytem__() {
  system::register("footsteps", & __init__, undefined, undefined);
}

function __init__() {
  surfacearray = getsurfacestrings();
  movementarray = [];
  movementarray[movementarray.size] = "step_run";
  movementarray[movementarray.size] = "land";
  level.playerfootsounds = [];
  for (movementarrayindex = 0; movementarrayindex < movementarray.size; movementarrayindex++) {
    movementtype = movementarray[movementarrayindex];
    for (surfacearrayindex = 0; surfacearrayindex < surfacearray.size; surfacearrayindex++) {
      surfacetype = surfacearray[surfacearrayindex];
      for (index = 0; index < 4; index++) {
        if(index < 2) {
          firstperson = 0;
        } else {
          firstperson = 1;
        }
        if((index % 2) == 0) {
          islouder = 0;
        } else {
          islouder = 1;
        }
        snd = buildandcachesoundalias(movementtype, surfacetype, firstperson, islouder);
      }
    }
  }
}

function checksurfacetypeiscorrect(movetype, surfacetype) {
  if(!isdefined(level.playerfootsounds[movetype][surfacetype])) {
    println(("" + surfacetype) + "");
    println("");
    println("");
    arraykeys = getarraykeys(level.playerfootsounds[movetype]);
    for (i = 0; i < arraykeys.size; i++) {
      println(arraykeys[i]);
    }
    println("");
  }
}

function playerjump(client_num, player, surfacetype, firstperson, quiet, islouder) {
  if(isdefined(player.audiomaterialoverride)) {
    surfacetype = player.audiomaterialoverride;
    checksurfacetypeiscorrect("", surfacetype);
  }
  sound_alias = level.playerfootsounds["step_run"][surfacetype][firstperson][islouder];
  player playsound(client_num, sound_alias);
}

function playerland(client_num, player, surfacetype, firstperson, quiet, damageplayer, islouder) {
  if(isdefined(player.audiomaterialoverride)) {
    surfacetype = player.audiomaterialoverride;
    checksurfacetypeiscorrect("", surfacetype);
  }
  sound_alias = level.playerfootsounds["land"][surfacetype][firstperson][islouder];
  player playsound(client_num, sound_alias);
  if(isdefined(player.step_sound) && !quiet && player.step_sound != "none") {
    volume = audio::get_vol_from_speed(player);
    player playsound(client_num, player.step_sound, player.origin, volume);
  }
  if(damageplayer) {
    if(isdefined(level.playerfalldamagesound)) {
      player[[level.playerfalldamagesound]](client_num, firstperson);
    } else {
      sound_alias = "fly_land_damage_npc";
      if(firstperson) {
        sound_alias = "fly_land_damage_plr";
        player playsound(client_num, sound_alias);
      }
    }
  }
}

function playerfoliage(client_num, player, firstperson, quiet) {
  sound_alias = "fly_movement_foliage_npc";
  if(firstperson) {
    sound_alias = "fly_movement_foliage_plr";
  }
  volume = audio::get_vol_from_speed(player);
  player playsound(client_num, sound_alias, player.origin, volume);
}

function buildandcachesoundalias(movementtype, surfacetype, firstperson, islouder) {
  sound_alias = "fly_" + movementtype;
  if(firstperson) {
    sound_alias = sound_alias + "_plr_";
  } else {
    sound_alias = sound_alias + "_npc_";
  }
  sound_alias = sound_alias + surfacetype;
  if(!isdefined(level.playerfootsounds)) {
    level.playerfootsounds = [];
  }
  if(!isdefined(level.playerfootsounds[movementtype])) {
    level.playerfootsounds[movementtype] = [];
  }
  if(!isdefined(level.playerfootsounds[movementtype][surfacetype])) {
    level.playerfootsounds[movementtype][surfacetype] = [];
  }
  if(!isdefined(level.playerfootsounds[movementtype][surfacetype][firstperson])) {
    level.playerfootsounds[movementtype][surfacetype][firstperson] = [];
  }
  assert(isarray(level.playerfootsounds));
  assert(isarray(level.playerfootsounds[movementtype]));
  assert(isarray(level.playerfootsounds[movementtype][surfacetype]));
  assert(isarray(level.playerfootsounds[movementtype][surfacetype][firstperson]));
  level.playerfootsounds[movementtype][surfacetype][firstperson][islouder] = sound_alias;
  return sound_alias;
}

function do_foot_effect(client_num, ground_type, foot_pos, on_fire) {
  if(!isdefined(level._optionalstepeffects)) {
    return;
  }
  if(on_fire) {
    ground_type = "fire";
  }
  if(getdvarint("")) {
    print3d(foot_pos, ground_type, (0.5, 0.5, 0.8), 1, 3, 30);
  }
  for (i = 0; i < level._optionalstepeffects.size; i++) {
    if(level._optionalstepeffects[i] == ground_type) {
      effect = "fly_step_" + ground_type;
      if(isdefined(level._effect[effect])) {
        playfx(client_num, level._effect[effect], foot_pos, foot_pos + vectorscale((0, 0, 1), 100));
        return;
      }
    }
  }
}

function missing_ai_footstep_callback() {
  type = self.archetype;
  if(!isdefined(type)) {
    type = "";
  }
  println(((("" + type) + "") + self._aitype) + "");
}

function playaifootstep(client_num, pos, surface, notetrack, bone) {
  if(!isdefined(self.archetype)) {
    println("");
    footstepdoeverything();
    return;
  }
  if(!isdefined(level._footstepcbfuncs) || !isdefined(level._footstepcbfuncs[self.archetype])) {
    self missing_ai_footstep_callback();
    footstepdoeverything();
    return;
  }
  [[level._footstepcbfuncs[self.archetype]]](client_num, pos, surface, notetrack, bone);
}