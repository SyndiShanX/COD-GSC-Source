/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombietron_ai_buffalo.gsc
*******************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombietron_utility;
#using_animtree("critter");
cow_run() {
  self endon("death");
  self UseAnimTree(#animtree);
  if(RandomInt(2) == 1) {
    curAnim = % a_water_buffalo_run_a;
  } else {
    curAnim = % a_water_buffalo_run_b;
  }
  self SetAnim(curAnim);
}
cow_deleter_level_sniff() {
  level waittill("exit_taken_fadeout");
  self notify("medium_rare");
}
cow_deleter() {
  self thread cow_deleter_level_sniff();
  self waittill_any("death", "medium_rare");
  self notify("stop_sounds");
  if(isDefined(self.trigger)) {
    self.trigger delete();
  }
  if(isDefined(self)) {
    self delete();
  }
}
run_cow_run(dest) {
  self endon("death");
  self thread cow_run();
  self thread cow_audio();
  self thread cow_damage_watch();
  self moveTo(dest, 10, 0, 0);
  wait 10;
  self notify("medium_rare");
}
cow_damage_trigger(cow) {
  cow endon("death");
  while (1) {
    self waittill("trigger", guy);
    if(!isDefined(guy.boss) || guy.boss == false) {
      guy PlaySound("zmb_buffalo_impact");
      guy SetPlayerCollision(0);
      guy DoDamage(guy.health + 1000, guy.origin, undefined, undefined, "explosive");
      if(!isPlayer(guy)) {
        guy StartRagdoll(1);
        guy LaunchRagdoll(200 * get_camera_launch_direction());
        guy.launched = true;
        guy PlaySound("zmb_ragdoll_launched");
      }
    }
  }
}
drawDebug(radius, height) {
  while (isDefined(self)) {
    drawcylinder(self.origin, radius, height);
    wait 0.05;
  }
}
cow_damage_watch() {
  self endon("death");
  while (1) {
    self waittill("damage", damagetaken, attacker, dir, point, dmg_type);
    if(dmg_type == "MOD_PROJECTILE" || dmg_type == "MOD_GRENADE" || dmg_type == "MOD_CRUSH") {
      playfx(level._effect["cow_explode"], self.origin, (0, 0, 1));
      self PlaySound("zmb_buffalo_explode");
      self notify("medium_rare");
      if(isDefined(self.sacred)) {
        self PlaySound("zmb_buffalo_explode_gold");
        level thread maps\_zombietron_pickups::spawn_treasures(self.origin, 5 + RandomInt(5));
        level thread maps\_zombietron_pickups::spawn_uber_prizes(RandomFloatRange(1, 3) * level.zombie_vars["max_prize_inc_range"], self.origin, true);
        self.sacred = undefined;
      }
    } else {
      self.health += damagetaken;
    }
  }
}
spawn_a_cow_burst(number, startSide) {
  level endon("exit_taken");
  spawn_locations = level.current_spawners[startSide];
  dest_locations = level.current_spawners[maps\_zombietron_main::get_opposite_side(startSide)];
  yaw = 0;
  switch (startSide) {
    case "top":
      yaw = 0;
      break;
    case "bottom":
      yaw = 180;
      break;
    case "left":
      yaw = 90;
      break;
    case "right":
      yaw = 270;
      break;
  }
  while (number > 0) {
    spawn_point = spawn_locations[RandomInt(spawn_locations.size)];
    dest_point = dest_locations[RandomInt(dest_locations.size)];
    trace = bullettrace(spawn_point.origin, spawn_point.origin + (0, 0, -500), false, undefined);
    spawn_point = (spawn_point.origin[0], spawn_point.origin[1], trace["position"][2]);
    trace = bullettrace(dest_point.origin, dest_point.origin + (0, 0, -500), false, undefined);
    dest_point = (dest_point.origin[0], dest_point.origin[1], trace["position"][2]);
    cow = Spawn("script_model", spawn_point);
    cow.angles = (0, yaw, 0);
    cow SetModel(level.cow_model);
    cow MakeFakeAI();
    cow setcandamage(true);
    cow.health = 3999999;
    cow.team = "axis";
    cow.script_noteworthy = "cow";
    if(RandomInt(100) < level.zombie_vars["sacred_cow_chance"]) {
      cow.sacred = true;
      wait_network_frame();
      cow setclientflag(level._ZT_SCRIPTMOVER_CF_SACRED_COW);
    }
    trigger = spawn("trigger_radius", cow.origin + (0, 0, -10), level.SPAWNFLAG_TRIGGER_AI_AXIS + level.SPAWNFLAG_TRIGGER_AI_ALLIES, 34, 100);
    trigger EnableLinkTo();
    trigger LinkTo(cow);
    trigger thread cow_damage_trigger(cow);
    cow.trigger = trigger;
    cow thread run_cow_run(dest_point);
    cow thread cow_deleter();
    wait(RandomFloatRange(1, 2.5));
    number--;
  }
}
random_cow_stampede() {
  level endon("exit_taken");
  while (level.arenas[level.current_arena] == "factory") {
    side = maps\_zombietron_main::get_random_side();
    while (maps\_zombietron_main::is_exit_open(side)) {
      side = maps\_zombietron_main::get_random_side();
      wait 0.05;
    }
    spawn_a_cow_burst(RandomIntRange(2, 6), side);
    wait RandomIntRange(10, 30);
  }
}
buffalo_stampede_monitor() {
  while (1) {
    level waittill("exit_taken_fadeout");
    if(level.arenas[level.current_arena] != "factory") {
      continue;
    }
    if(maps\_zombietron_challenges::is_this_a_challenge_round(level.round_number)) {
      continue;
    }
    cows = getEntArray("cow", "script_noteworthy");
    for (i = 0; i < cows.size; i++) {
      cows[i] notify("medium_rare");
    }
    wait 10;
    level thread random_cow_stampede();
  }
}
challenge_init() {
  level endon("all_zombies_dead");
  level endon("exit_taken");
  wait 7;
  lastSide = maps\_zombietron_main::get_random_side();
  lastlastSide = lastSide;
  while (1) {
    side = maps\_zombietron_main::get_random_side();
    if(side == lastSide || side == lastlastSide) {
      wait 0.05;
      continue;
    }
    lastlastSide = lastSide;
    lastSide = side;
    level spawn_a_cow_burst(RandomIntRange(5, 10), side);
    wait RandomIntRange(1, 3);
  }
}
cow_audio() {
  sound_ent = Spawn("script_origin", self.origin);
  sound_ent LinkTo(self);
  sound_ent PlayLoopSound("zmb_buffalo_run_loop", 1);
  self thread delete_sound_ent(sound_ent);
  self thread play_random_roars();
  self waittill("stop_sounds");
  if(isDefineD(sound_ent)) {
    sound_ent StopLoopSound(1);
    wait(1);
    sound_ent Delete();
  }
}
play_random_roars() {
  self endon("stop_sounds");
  self endon("death");
  level endon("exit_taken");
  level endon("exit_taken_fadeout");
  while (1) {
    self PlaySound("zmb_buffalo_roar", "sounddone");
    self waittill("sounddone");
    wait(RandomFloatRange(1, 4.5));
  }
}
delete_sound_ent(ent) {
  self endon("stop_sounds");
  level waittill_any("exit_taken_fadeout", "exit_taken", "death");
  ent Delete();
}
�