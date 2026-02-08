/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_squad_manager.gsc
**************************************/

alive_array(strSquadName) {
  aSquad = [];
  aRoster = getaiarray();
  for(i = 0; i < aRoster.size; i++) {
    if(isDefined(aRoster[i].script_squadname)) {
      if(aRoster[i].script_squadname == strSquadName) {
        aSquad[aSquad.size] = aRoster[i];
      }
    }
  }
  return (aSquad);
}

spawn_array(strSquadName) {
  squad_spawn = [];
  aSpawner = getspawnerarray();

  for(i = 0; i < aSpawner.size; i++) {
    if(isDefined(aSpawner[i].script_squadname)) {
      if(aSpawner[i].script_squadname == strSquadName) {
        squad_spawn[squad_spawn.size] = aSpawner[i];
      }
    }
  }
  return (squad_spawn);
}

set_goals(squad_array, targets) {
  for(i = 0; i < squad_array.size; i++) {
    rr = randomint(targets.size);
    squad_array[i] setgoalpos(targets[rr].origin);
  }
}
manage_spawners(strSquadName, mincount, maxcount, ender, spawntime, spawnfunction, wave_delay_min, wave_delay_max) {
  println("********************************");
  println("SQUAD ", strSquadName);
  println("must have ", mincount, " alive until we hit we get this \"", ender, "\" message");
  println("spawning every ", spawntime, " seconds");
  println("********************************");

  self endon(ender);

  spawn_index = 0;
  goal_index = 0;

  squad_targets = getnodearray(strSquadName, "targetname");
  squad_spawn = spawn_array(strSquadName);

  if(squad_spawn.size == 0) {
    maps\_utility::error("SQUAD MANAGER:Could not find spawners for squad " + strSquadName);
    return;
  }
  if(squad_targets.size == 0) {
    maps\_utility::error("SQUAD MANAGER:Could not find target nodes for squad " + strSquadName);
    return;
  }

  if(!isDefined(spawntime))
    spawntime = 0.05;

  while(1) {
    aSquad = alive_array(strSquadName);

    if(aSquad.size < mincount) {
      level notify(strSquadName + " min threshold reached");

      while(aSquad.size < maxcount) {
        if(isDefined(squad_spawn[spawn_index].script_forcespawn) &&
          squad_spawn[spawn_index].script_forcespawn) {
          spawned = squad_spawn[spawn_index] stalingradspawn();
        } else {
          spawned = squad_spawn[spawn_index] dospawn();
        }

        if(isDefined(spawned)) {
          spawned setgoalnode(squad_targets[goal_index]);
          spawned.sm_goalnode = squad_targets[goal_index];

          goal_index = goal_index + 1;
          if(goal_index >= squad_targets.size)
            goal_index = 0;

          wait(0.01);

          aSquad[aSquad.size] = spawned;

          if(isDefined(spawnfunction)) {
            spawned thread[[spawnfunction]]();
          } else {
            spawned thread advance();
          }
        }

        spawn_index = spawn_index + 1;
        if(spawn_index >= squad_spawn.size)
          spawn_index = 0;

        wait(spawntime);
      }
    }
    wave_delay = .05;
    if(isDefined(wave_delay_min)) {
      min = wave_delay_min;
      max = wave_delay_min + .05;
      if(isDefined(wave_delay_max)) {
        max = wave_delay_max;
      }
      wave_delay = randomfloatrange(min, max);
    }
    wait(wave_delay);
  }
}

advance() {
  self endon("death");

  if(!isDefined(self.sm_goalnode)) {
    println("AI does not have sm_goalnode set.Can not advance.");
    return;
  }

  if(!isDefined(self.sm_goalnode.target)) {
    return;
  }

  if(!isDefined(self.sm_advance_wait_min))
    self.sm_advance_wait_min = 5;

  if(!isDefined(self.sm_advance_wait_max))
    self.sm_advance_wait_max = 15;

  self waittill("goal");

  wait(randomint(self.sm_advance_wait_min, self.sm_advance_wait_max));

  self pick_random_goal_node();

  self thread advance();
}

advance_on_notify(advancenotifystring) {
  self endon("death");

  if(!isDefined(self.sm_goalnode)) {
    println("AI does not have sm_goalnode set.Can not advance.");
    return;
  }

  if(!isDefined(self.sm_goalnode.target)) {
    return;
  }

  self waittill(advancenotifystring);

  self pick_random_goal_node();

  if(isDefined(self.sm_goalnode)) {
    self thread advance_on_notify(advancenotifystring);
  }
}

pick_random_goal_node() {
  targets = getnodearray(self.sm_goalnode.target, "targetname");

  if(targets.size == 0) {
    self.sm_goalnode = undefined;
    return;
  }

  index = randomint(targets.size);
  self setgoalnode(targets[index]);

  self.sm_goalnode = targets[index];
}