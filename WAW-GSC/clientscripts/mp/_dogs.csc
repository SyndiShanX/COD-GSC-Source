/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_dogs.csc
*****************************************************/

init() {
  thread dog_dvar_updater();
  level.movementStateSound = [];
  level.maxStateSoundDistance = 99999999;
  level.movementStateSound["normal"] = spawnStruct();
  level.movementStateSound["normal"].sound = "anml_dog_bark";
  level.movementStateSound["normal"].waitMax = 4;
  level.movementStateSound["normal"].waitMin = 1;
  level.movementStateSound["normal"].enemyrange = level.maxStateSoundDistance;
  level.movementStateSound["normal"].localenemyonly = false;
  level.movementStateSound["attack_mid_everyone"] = spawnStruct();
  level.movementStateSound["attack_mid_everyone"].sound = "anml_dog_bark_attack_mid";
  level.movementStateSound["attack_mid_everyone"].waitMax = 2;
  level.movementStateSound["attack_mid_everyone"].waitMin = 0.5;
  level.movementStateSound["attack_mid_everyone"].enemyrange = 1500;
  level.movementStateSound["attack_mid_everyone"].localenemyonly = false;
  level.movementStateSound["attack_mid_enemy"] = spawnStruct();
  level.movementStateSound["attack_mid_enemy"].sound = "anml_dog_bark_attack_mid";
  level.movementStateSound["attack_mid_enemy"].waitMax = 0.5;
  level.movementStateSound["attack_mid_enemy"].waitMin = 0.01;
  level.movementStateSound["attack_mid_enemy"].enemyrange = 1500;
  level.movementStateSound["attack_mid_enemy"].localenemyonly = true;
  level.movementStateSound["attack_close_enemy"] = spawnStruct();
  level.movementStateSound["attack_close_enemy"].sound = "anml_dog_bark_attack_close";
  level.movementStateSound["attack_close_enemy"].waitMax = 0.1;
  level.movementStateSound["attack_close_enemy"].waitMin = 0.01;
  level.movementStateSound["attack_close_enemy"].enemyrange = 1000;
  level.movementStateSound["attack_close_enemy"].localenemyonly = true;
}

dog_dvar_updater() {
  while(1) {
    level.dog_debug_sound = dog_get_dvar_int("debug_dog_sound", "0");
    level.dog_debug = dog_get_dvar_int("debug_dogs", "0");
    wait(1);
  }
}

spawned(localClientNum) {
  self endon("entityshutdown");
  self thread animCategoryWatcher(localClientNum);
  self thread enemyWatcher(localClientNum);
  self thread shutdownWatcher(localClientNum);
}

shutdownWatcher(localClientNum) {
  if(!level.dog_debug) {
    return;
  }
  number = self getentnum();
  println("_+_+_+_+_+_+_+_+_+_+_NEWLY SPAWNED DOG" + number);
  self waittill("entityshutdown");
  println("_+_+_+_+_+_+_+_+_+_+_DOG SHUTDOWN" + number);
}

animCategoryChanged(localClientNum, animCategory) {
  self.animCategory = animCategory;
  self notify("killanimscripts");
  dog_print("anim category changed " + animCategory);
  switch (animCategory) {
    case "move":
      self thread playMovementSounds(localClientNum);
      break;
    case "pain":
      self thread playPainSounds(localClientNum);
      break;
    case "death":
      self thread playDeathSounds(localClientNum);
      break;
  };
}
animCategoryWatcher(localClientNum) {
  self endon("entityshutdown");
  if(!isDefined(self.animCategory)) {
    animCategoryChanged(localClientNum, self GetAnimStateCategory());
  }
  while(1) {
    animCategory = self GetAnimStateCategory();
    if(isDefined(animCategory) && self.animCategory != animCategory && animCategory != "traverse") {
      animCategoryChanged(localClientNum, animCategory);
    }
    wait(0.05);
  }
}

enemyWatcher(localClientNum) {
  self endon("entityshutdown");
  while(1) {
    self waittill("enemy");

    if(isDefined(self.enemy)) {
      dog_print("NEW ENEMY " + self.enemy getentnum());
      if(isLocalPlayerEnemy(self.enemy)) {
        self thread playLockOnSounds(localClientNum);
      }
    } else {
      dog_print("NEW ENEMY CLEARED");
    }
  }
}

getOtherTeam(team) {
  if(team == "allies") {
    return "axis";
  } else if(team == "axis") {
    return "allies";
  } else if(team == "free") {
    return "free";
  }
  assertMsg("getOtherTeam: invalid team " + team);
}

isLocalPlayerEnemy(enemy) {
  if(!isDefined(enemy)) {
    return false;
  }
  players = getlocalplayers();
  if(isDefined(players)) {
    for(i = 0; i < players.size; i++) {
      if(players[i] == enemy) {
        return true;
      }
    }
  }
  return false;
}

isLocalPlayerEnemyTeam(team) {
  otherteam = getOtherTeam(team);
  players = getlocalplayers();
  if(isDefined(players)) {
    for(i = 0; i < players.size; i++) {}
  }
  return false;
}

hasEnemyChanged(last_enemy) {
  if(!isDefined(last_enemy) && isDefined(self.enemy)) {
    return true;
  }
  if(isDefined(last_enemy) && !isDefined(self.enemy)) {
    return true;
  }
  if(last_enemy != self.enemy) {
    return true;
  }
  return false;
}

getMovementSoundState() {
  localPlayer = isLocalPlayerEnemy(self.enemy);
  closest_dist = level.maxStateSoundDistance * level.maxStateSoundDistance;
  closest_key = "normal";
  has_enemy = isDefined(self.enemy);
  if(has_enemy) {
    enemy_distance = distancesquared(self.origin, self.enemy.origin);
  } else {
    return "normal";
  }
  stateArray = getArrayKeys(level.movementStateSound);
  for(i = 0; i < stateArray.size; i++) {
    if(level.movementStateSound[stateArray[i]].localenemyonly && !localPlayer) {
      continue;
    }
    state_dist = level.movementStateSound[stateArray[i]].enemyrange;
    state_dist *= state_dist;
    if(state_dist < enemy_distance) {
      continue;
    }
    if(state_dist < closest_dist) {
      closest_dist = state_dist;
      closest_key = stateArray[i];
    }
  }
  return closest_key;
}

playMovementSounds(localClientNum) {
  self endon("entityshutdown");
  self endon("killanimscripts");
  last_state = "normal";
  last_time = 0;
  wait_time = 0;
  while(1) {
    state = getMovementSoundState();
    next_sound = false;
    if(state != last_state && level.movementStateSound[state].waitMax < wait_time) {
      dog_sound_print("New State forcing next sound");
      next_sound = true;
    }
    if(next_sound || ((last_time + wait_time) < GetRealTime())) {
      if(isDefined(self.enemy)) {
        dog_sound_print("enemy distance: " + distance(self.origin, self.enemy.origin));
      }
      soundId = self play_dog_sound(localClientNum, level.movementStateSound[state].sound);
      last_state = state;
      if(soundId >= 0) {
        while(soundplaying(soundId)) {
          wait(0.05);
        }
        last_time = GetRealTime();
        wait_time = 1000 * randomfloatrange(level.movementStateSound[state].waitMin, level.movementStateSound[state].waitMax);
        dog_sound_print("wait_time: " + wait_time);
      } else {
        wait(0.5);
      }
    }
    wait(0.05);
  }
}

playPainSounds(localClientNum) {
  self endon("entityshutdown");
  self endon("killanimscripts");
  soundId = self play_dog_sound(localClientNum, "anml_dog_pain");
}

playDeathSounds(localClientNum) {
  self endon("entityshutdown");
  self endon("killanimscripts");
  soundId = self play_dog_sound(localClientNum, "anml_dog_death");
}

playLockOnSounds(localClientNum) {
  self endon("entityshutdown");
  soundId = self play_dog_sound(localClientNum, "anml_dog_lock");
}

playDogstep(client_num, dog, pos, ground_type, on_fire) {
  if(ground_type != "default") {
    sound_alias = "dogstep_run_" + ground_type;
  } else {
    sound_alias = "dogstep_run_dirt";
  }
  dog playSound(client_num, sound_alias, pos);
  if(isDefined(self.enemy) && isLocalPlayerEnemy(self.enemy)) {
    dog playSound(client_num, "dog_gear_rattle_run_enemy", pos);
  } else {
    dog playSound(client_num, "dog_gear_rattle_run", pos);
  }
  dog do_foot_effect(client_num, ground_type, pos, on_fire);
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

soundNotify(client_num, entity, note) {
  if(note == "sound_dogstep_run_default") {
    entity playSound(client_num, "dogstep_run_default");
    return true;
  }
  prefix = getsubstr(note, 0, 5);
  if(prefix != "sound") {
    return false;
  }
  alias = "anml" + getsubstr(note, 5);
  entity play_dog_sound(client_num, alias);
}

dog_get_dvar_int(dvar, def) {
  return int(dog_get_dvar(dvar, def));
}

dog_get_dvar(dvar, def) {
  if(getdvar(dvar) != "") {
    return getdvarfloat(dvar);
  } else {
    return def;
  }
}

dog_sound_print(message) {
  if(!level.dog_debug_sound) {
    return;
  }
  println("CLIENT DOG SOUND(" + self getentnum() + "," + GetRealTime() + "): " + message);
}

dog_print(message) {
  if(!level.dog_debug) {
    return;
  }
  println("CLIENT DOG DEBUG(" + self getentnum() + "): " + message);
}

play_dog_sound(localClientNum, sound, position) {
  dog_sound_print("SOUND " + sound);
  if(isDefined(position)) {
    return self playSound(localClientNum, sound, position);
  }
  return self playSound(localClientNum, sound);
}