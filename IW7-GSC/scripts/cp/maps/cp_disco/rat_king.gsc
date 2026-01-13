/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\rat_king.gsc
*************************************************/

rat_king_init() {
  var_0 = scripts\engine\utility::getstructarray("rat_king_spawner", "targetname");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy)) {
      continue;
    }

    level.rat_king_spawn_loc = var_2.origin;
    level.rat_king_spawn_angles = var_2.angles;
  }

  level.rat_king_vo_prefix = "disco_ratking_";
  setuprkbouncestructs();
}

setuprkbouncestructs() {
  level.rat_king_bounce_structs = scripts\engine\utility::getstructarray("shield_bounce_loc", "targetname");
}

spawn_rat_king(var_0, var_1, var_2) {
  level notify("spawn_rat_king");
  level endon("spawn_rat_king");
  scripts\engine\utility::flag_wait("interactions_initialized");
  if(isDefined(level.rat_king)) {
    if(scripts\engine\utility::istrue(var_2)) {
      level.rat_king suicide();
    } else {
      return;
    }
  }

  if(!isDefined(var_0)) {
    var_0 = level.rat_king_spawn_loc;
  }

  if(!isDefined(var_1)) {
    var_1 = level.rat_king_spawn_angles;
  }

  for(;;) {
    level.rat_king = scripts\mp\mp_agent::spawnnewagent("ratking", "axis", var_0, var_1);
    if(isDefined(level.rat_king)) {
      level.rat_king.voprefix = level.rat_king_vo_prefix;
      level.rat_king thread setrkscriptablestates();
      level.rat_king thread rkaudiomonitor();
      level.spawned_enemies[level.spawned_enemies.size] = level.rat_king;
      if(scripts\engine\utility::flag("rk_fight_started")) {
        playsoundatpos(level.rat_king_spawn_loc + (0, 0, 100), "rk_spawn_in_lr");
      }

      level.rat_king thread runspawnlogic();
      break;
    } else {
      scripts\engine\utility::waitframe();
    }
  }
}

setrkscriptablestates() {
  wait(2);
  if(scripts\aitypes\ratking\behaviors::rk_isonplatform()) {
    self setscriptablepartstate("movement", "neutral");
    self setscriptablepartstate("rat_skirt", "platform");
  }
}

runspawnlogic() {
  self.precacheleaderboards = 1;
  self.scripted_mode = 1;
  self.outofplayspace = 1;
  self notify("spawn");
  self setscriptablepartstate("movement", "materialize");
  wait(2);
  self.outofplayspace = undefined;
  self.precacheleaderboards = 0;
  self.scripted_mode = 0;
}

rkaudiomonitor() {
  level endon("game_ended");
  self endon("death");
  var_0 = 10;
  self.playing_stumble = 0;
  for(;;) {
    var_1 = scripts\engine\utility::waittill_any_in_array_or_timeout(["spawn", "summon", "pain", "melee", "shield_throw", "over", "under", "stomp"], var_0);
    var_0 = randomintrange(4, 10);
    switch (var_1) {
      case "spawn":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "spawn", 0);
        break;

      case "summon":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "summon", 0);
        break;

      case "pain":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "pain", 0);
        break;

      case "under":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "melee", 0);
        break;

      case "shield_throw":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "shield_throw", 0);
        break;

      case "stomp":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "staff_stomp", 0);
        break;

      case "timeout":
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "staff_over", 0);
        level thread scripts\cp\zombies\zombies_vo::play_zombie_vo(self, "staff_under", 0);
        break;
    }
  }
}