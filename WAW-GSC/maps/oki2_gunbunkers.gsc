/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oki2_gunbunkers.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\oki2_util;
#include maps\_music;

bunker_wait_for_flame(bnkr, fire_fx, flame_guys, flame_guys_func, exploderID) {
  level endon(bnkr + "_destroyed");
  trig = getent("bunker" + bnkr + "_dmg_trig", "targetname");
  dmg = 0;
  level thread bunker_wait_for_explosives(bnkr, trig, exploderID);
  support_trigs = getentarray("bunker_" + bnkr + "_support", "script_noteworthy");
  if(isDefined(support_trigs)) {
    array_thread(support_trigs, ::add_support_spawn_functions);
  }
  strNotify = bnkr + "_flamed";
  while (dmg < 500) {
    trig waittill("damage", amount, attacker, direction_vec, P, type);
    if(type != "MOD_BURNED") {
      continue;
    } else {
      dmg = dmg + amount;
    }
  }
  if(isDefined(support_trigs)) {
    for (i = 0; i < support_trigs.size; i++) {
      if(isDefined(support_trigs[i])) {
        support_trigs[i] trigger_off();
      }
    }
  }
  kill_guys_in_bunker(bnkr);
  if(isDefined(flame_guys)) {
    flamers = getentarray(flame_guys, "targetname");
    array_thread(flamers, flame_guys_func);
  }
  level notify(strNotify);
  level notify(bnkr + "_cleared");
}

bunker_wait_for_explosives(bnkr, trig, exploderID) {
  trig waittill("satchel_exploded");
  exploder(exploderID);
  if(bnkr == 1) {
    level.gun1 notify("trigger");
    if(!level.gun2_destroyed) {
      alliestrig = getent("e2_linefight_a_allies", "targetname");
      if(isDefined(alliestrig)) {
        alliestrig notify("trigger");
      }
      enemytrig = getent("e2_linefight_a_start", "targetname");
      if(isDefined(enemytrig)) {
        enemytrig notify("trigger");
      }
    }
  }
  if(bnkr == 2) {
    level.gun2 notify("trigger");
    alliestrig = getent("goto_bunker4", "targetname");
    if(isDefined(alliestrig)) {
      alliestrig notify("trigger");
    }
    enemytrig = getent("e2_bunker4_firstspawn", "targetname");
    if(isDefined(enemytrig)) {
      enemytrig notify("trigger");
    }
  }
  if(bnkr == 4) {
    level.gun4 notify("trigger");
  }
  thread kill_guys_in_bunker(bnkr);
  xtra = getent("bunker_" + bnkr + "_extra", "targetname");
  if(isDefined(xtra)) {
    xtra trigger_off();
  }
  wait(1);
  spots = getstructarray("bunker_" + bnkr + "_fire", "targetname");
  x1 = spots[randomint(spots.size)];
  array_remove(spots, x1);
  x2 = spots[randomint(spots.size)];
  level notify(bnkr + "_destroyed");
  level notify("stop_" + bnkr);
  level notify(bnkr + "_cleared");
  support_trigs = getentarray("bunker_" + bnkr + "_support", "script_noteworthy");
  if(isDefined(support_trigs)) {
    for (i = 0; i < support_trigs.size; i++) {
      support_trigs[i] trigger_off();
    }
  }
}

add_support_spawn_functions() {
  target = self.target;
  spawners = getentarray(target, "targetname");
  for (i = 0; i < spawners.size; i++) {
    spawners[i] add_spawn_function(::guy_to_goal_blind);
  }
}

kill_guys_in_bunker(bnkr) {
  trig = getent("bunker_" + bnkr + "_radius", "targetname");
  bunker_guys = getaiarray("axis");
  for (i = 0; i < bunker_guys.size; i++) {
    if(bunker_guys[i] istouching(trig)) {
      bunker_guys[i] thread flamedeath();
    }
  }
}

bunker_interior_fire(bnkr, fx) {
  spots = getstructarray("bunker_" + bnkr + "_fire", "targetname");
  for (i = 0; i < spots.size; i++) {
    playfx(level._effect[fx], spots[i].origin);
  }
}

cave_flamers() {
  guy = self stalingradspawn();
  if(isDefined(guy)) {
    guy waittill("finished spawning");
    guy thread flamedeath(true);
  }
}

#using_animtree("generic_human");

flamedeath(wait_for_goal) {
  anima[0] = % ai_flame_death_a;
  anima[1] = % ai_flame_death_b;
  anima[2] = % ai_flame_death_c;
  anima[3] = % ai_flame_death_d;
  self.deathanim = anima[randomint(anima.size)];
  self death_flame_fx();
  if(isDefined(wait_for_goal)) {
    self waittill("goal");
  }
  self dodamage(self.health + 100, self.origin);
}

death_flame_fx() {
  tagArray = [];
  tagArray[tagArray.size] = "J_Wrist_RI";
  tagArray[tagArray.size] = "J_Wrist_LE";
  tagArray[tagArray.size] = "J_Elbow_LE";
  tagArray[tagArray.size] = "J_Elbow_RI";
  tagArray[tagArray.size] = "J_Knee_RI";
  tagArray[tagArray.size] = "J_Knee_LE";
  tagArray[tagArray.size] = "J_Ankle_RI";
  tagArray[tagArray.size] = "J_Ankle_LE";
  for (i = 0; i < 3; i++) {
    PlayFxOnTag(level._effect["flame_death1"], self, tagArray[randomint(tagArray.size)]);
    PlayFxOnTag(level._effect["flame_death2"], self, "J_SpineLower");
  }
}

bunker_dialogue() {
  thread bunker1_dialogue_begin();
  thread bunker_dialogue_clearbunker(1);
  thread bunker_dialogue_explosives_thrown(1);
  thread bunker_dialogue_clearbunker(2);
  thread bunker_dialogue_explosives_thrown(2);
  thread bunker_dialogue_clearbunker(4);
  thread bunker_dialogue_explosives_thrown(4);
}

bunker1_dialogue_begin() {
  trig1 = getent("bunker1_dialogue", "script_noteworthy");
  trig1 waittill("trigger");
  level notify("stop_cave_mg");
  wait(5);
  battlechatter_off("allies");
  maps\oki2::e2_showsatchels();
  level.sarge dialogue("threeactive");
  wait(1);
  level.sarge dialogue("flankround");
  battlechatter_on("allies");
  level thread players_satchel_hint();
  level notify("OBJ_1_COMPLETE");
  setmusicstate("BUNKERS");
}

bunker_dialogue_clearbunker(bnkr) {
  level endon(bnkr + "_destroyed");
  trig1 = getent("bunker_" + bnkr + "_dialogue_clearbunker", "script_noteworthy");
  trig1 waittill("trigger");
  level.sarge thread nag_clear_bunker(bnkr);
  wait(1);
  level thread bunker_waitfor_cleared(bnkr);
  level waittill(bnkr + "_cleared");
  wait(2);
  level.sarge dialogue("satchelnag1");
  level.sarge thread nag_throw_satchel(bnkr);
}

bunker_dialogue_explosives_thrown(bnkr) {
  level waittill(bnkr + "_destroyed");
  remaining = guns_remaining();
  switch (remaining) {
    case 1:
      level endon("bunker_noneleft");
      level notify("bunker_oneleft");
      setmusicstate("FUBAR");
      wait(4);
      level.sarge dialogue("twodown");
      wait(0.5);
      level.sarge dialogue("finishjob");
      break;
    case 2:
      level endon("bunker_oneleft");
      wait(4);
      level.sarge dialogue("onedown");
      break;
  }
}

nag_throw_satchel(bnkr) {
  level endon(bnkr + "_destroyed");
  while (1) {
    for (i = 1; i < 4; i++) {
      wait(10);
      if(i == 1) {
        level.polonsky dialogue("hurryitup");
      } else {
        level.sarge dialogue("satchelnag" + i);
      }
    }
  }
}

goto_next_bunker() {
  if(level.gun1_destroyed && !level.gun2_destroyed) {
    trig = getent("goto_bunker2", "targetname");
    trig notify("trigger");
  }
  if(level.gun1_destroyed && level.gun2_destroyed) {
    trig = getent("goto_bunker4", "targetname");
    trig notify("trigger");
  }
  if((!level.gun1_destroyed) && (level.gun2_destroyed) && (level.gun4_destroyed)) {
    trig = getent("goto_bunker1", "targetname");
    trig notify("trigger");
  }
}

nag_clear_bunker(bnkr) {
  level endon(bnkr + "_destroyed");
  level endon(bnkr + "_flamed");
  players = get_players();
  p1 = players[0];
  while (1) {
    wait(10);
    if(p1 hasWeapon("m2_flamethrower_wet")) {
      switch (randomint(8)) {
        case 0:
          level.sarge dialogue("flamenag");
          break;
        case 1:
          level.sarge dialogue("burnthose");
          break;
        case 2:
          level.sarge dialogue("goddamnflames");
          break;
        case 3:
          level.polonsky dialogue("burnem");
          break;
        case 4:
          level.polonsky dialogue("flamethose");
          break;
        case 5:
          level.sarge dialogue("satchelnag1");
          break;
        case 6:
          level.sarge dialogue("satchelnag2");
          break;
        case 7:
          level.sarge dialogue("satchelnag3");
          break;
        default:
          level.polonsky dialogue("hurryitup");
      }
    } else {
      switch (randomint(4)) {
        case 0:
          level.sarge dialogue("satchelnag1");
          break;
        case 1:
          level.sarge dialogue("satchelnag2");
          break;
        case 2:
          level.sarge dialogue("satchelnag3");
          break;
        default:
          level.polonsky dialogue("hurryitup");
      }
    }
  }
}

monitor_gun(num) {
  switch (num) {
    case 1:
      level.gun1 waittill("trigger");
      level.gun1_destroyed = true;
      destroy_gun(1);
      break;
    case 2:
      level.gun2 waittill("trigger");
      level.gun2_destroyed = true;
      destroy_gun(2);
      break;
    case 4:
      level.gun4 waittill("trigger");
      level.gun4_destroyed = true;
      destroy_gun(4);
      break;
  }
}

destroy_gun(gun_num) {
  gun = getent("gun_" + gun_num, "targetname");
  gun notify("death");
  update_gun_objectives();
}

update_gun_objectives() {
  guns = 3;
  if(level.gun1_destroyed) {
    objective_position(1, get_position());
    guns--;
  }
  if(level.gun2_destroyed) {
    objective_additionalposition(1, 1, get_position());
    guns--;
  }
  if(level.gun4_destroyed) {
    objective_additionalposition(1, 2, get_position());
    guns--;
  }
  if(guns == 0) {
    level.all_guns_destroyed = true;
  }
  switch (guns) {
    case 1:
      objective_string(1, & "OKI2_OBJ_2_1");
      break;
    case 2:
      objective_string(1, & "OKI2_OBJ_2_2");
      break;
    case 3:
      objective_string(1, & "OKI2_OBJ_2_3");
      break;
    case 4:
      objective_string(1, & "OKI2_OBJ_2_4");
      break;
  }
  autosave_by_name(guns + " guns remaining");
  objective_ring(1);
}

get_position() {
  if(!level.gun1_destroyed) {
    return level.gun1_org;
  }
  if(!level.gun2_destroyed) {
    return level.gun2_org;
  }
  if(!level.gun4_destroyed) {
    return level.gun4_org;
  }
  return level.gun1_org;
}

guns_remaining() {
  guns = 3;
  if(level.gun1_destroyed) {
    guns--;
  }
  if(level.gun2_destroyed) {
    guns--;
  }
  if(level.gun4_destroyed) {
    guns--;
  }
  return guns;
}

bunker_waitfor_cleared(bnkr) {
  trig = getent("bunker_" + bnkr + "_radius", "targetname");
  bunker_cleared = false;
  while (!bunker_cleared) {
    guys = 0;
    enemies = getaiarray("axis");
    for (i = 0; i < enemies.size; i++) {
      if(enemies[i] istouching(trig)) {
        guys++;
      }
    }
    if(guys == 0) {
      bunker_cleared = true;
      level notify(bnkr + "_cleared");
    }
    wait(1);
  }
}