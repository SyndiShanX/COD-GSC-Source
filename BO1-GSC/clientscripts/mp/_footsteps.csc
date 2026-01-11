/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_footsteps.csc
*******************************************/

playerFootstep(client_num, player, movementtype, ground_type, firstperson, quiet) {
  if(player underwater()) {
    return;
  }
  if(player HasPerk("specialty_quieter")) {
    return;
  }
  full_movement_type = "step_" + movementtype;
  sound_alias = buildMovementSoundAliasName(full_movement_type, ground_type, firstperson, quiet, player);
  player.movementtype = movementtype;
  if(getdvarint(#"debug_footsteps") > 0) {}
  player playSound(client_num, sound_alias);
  if(isDefined(player.step_sound) && (!quiet) && (player.step_sound) != "none") {
    volume = clientscripts\mp\_audio::get_vol_from_speed(player);
    if(getdvarint(#"debug_audio") > 0 && (firstperson)) {}
    player playSound(client_num, player.step_sound, player.origin, volume);
  }
}
playerJump(client_num, player, ground_type, firstperson, quiet) {
  if(player HasPerk("specialty_quieter")) {
    return;
  }
  sound_alias = buildMovementSoundAliasName("step_run", ground_type, firstperson, quiet, player);
  player playSound(client_num, sound_alias);
}
playerLand(client_num, player, ground_type, firstperson, quiet, damagePlayer) {
  if(player HasPerk("specialty_quieter")) {
    return;
  }
  sound_alias = buildMovementSoundAliasName("land", ground_type, firstperson, quiet, player);
  player playSound(client_num, sound_alias);
  if(isDefined(player.step_sound) && (!quiet) && (player.step_sound) != "none") {
    volume = clientscripts\mp\_audio::get_vol_from_speed(player);
    player playSound(client_num, player.step_sound, player.origin, volume);
  }
  if(damagePlayer) {
    sound_alias = "fly_land_damage_npc";
    if(firstperson) {
      sound_alias = "fly_land_damage_plr";
      player playSound(client_num, sound_alias);
    }
  }
}
playerFoliage(client_num, player, firstperson, quiet) {
  if(player IsPlayer() && player HasPerk("specialty_quieter")) {
    return;
  }
  sound_alias = "fly_movement_foliage_npc";
  if(firstperson) {
    sound_alias = "fly_movement_foliage_plr";
  }
  volume = clientscripts\mp\_audio::get_vol_from_speed(player);
  player playSound(client_num, sound_alias, player.origin, volume);
}
buildMovementSoundAliasName(movementtype, ground_type, firstperson, quiet, player) {
  sound_alias = "fly_";
  if(player.team != GetLocalPlayerTeam(0) && isDefined(level.loudenemies) && (level.loudenemies)) {
    sound_alias = sound_alias + "q";
  }
  sound_alias = sound_alias + movementtype;
  if(firstperson) {
    sound_alias = sound_alias + "_plr_";
  } else {
    sound_alias = sound_alias + "_npc_";
  }
  sound_alias = sound_alias + ground_type;
  return sound_alias;
}
do_foot_effect(client_num, ground_type, foot_pos, on_fire) {
  if(!isDefined(level._optionalStepEffects)) {
    return;
  }
  if(on_fire) {
    ground_type = "fire";
  }
  for(i = 0; i < level._optionalStepEffects.size; i++) {
    if(level._optionalStepEffects[i] == ground_type) {
      effect = "fly_step_" + ground_type;
      if(isDefined(level._effect[effect])) {
        playFX(client_num, level._effect[effect], foot_pos, foot_pos + (0, 0, 100));
        return;
      }
    }
  }
}