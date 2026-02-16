/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_footsteps.csc
*******************************************/

playFootstep(client_num, pos, ground_type, on_fire) {
  if(ground_type != "default") {
    sound_alias = "step_run_" + ground_type;
  } else {
    sound_alias = "step_run_dirt";
  }

  playSound(client_num, sound_alias, pos);

  playSound(client_num, "gear_rattle_run", pos);

  do_foot_effect(client_num, ground_type, pos, on_fire);
}

do_foot_effect(client_num, ground_type, foot_pos, on_fire) {
  if(!isDefined(level._optionalStepEffects)) {
    return;
  }

  if(on_fire) {
    ground_type = "fire";
  }

  if(GetDvarInt("debug_surface_type")) {
    print3d(foot_pos, ground_type, (0.5, 0.5, 0.8), 1, 3, 30);
  }

  for(i = 0; i < level._optionalStepEffects.size; i++) {
    if(level._optionalStepEffects[i] == ground_type) {
      effect = "step_" + ground_type;

      if(isDefined(level._effect[effect])) {
        playFX(client_num, level._effect[effect], foot_pos, foot_pos + (0, 0, 100));
        return;
      }
    }
  }
}