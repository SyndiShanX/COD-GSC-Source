/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_zombie_dog_think.gsc
****************************************************/

main() {
  setupdogstate();
  thread think();
  thread maps\mp\zombies\_util::waitforbadpath();
  thread waitforpathset();
}

setupdogstate() {
  self.attackoffset = 40 + self.radius;
  self.meleesectortype = "normal";
  self.meleesectorupdatetime = 50;
  self.attackzheight = 54;
  self.attackzheightdown = -64;
  self.damagedradiussq = 2250000;
  self.ignoreclosefoliage = 1;
  self.moveratescale = 1.0;
  self.nonmoveratescale = 1.0;
  self.traverseratescale = 1.0;
  self.generalspeedratescale = 1.0;
  self.bhasbadpath = 0;
  self.bhasnopath = 0;
  self.timeoflastdamage = 0;
  self.allowcrouch = 1;
  self.meleecheckheight = 30;
  self.meleeradiusbase = 80;
  self.meleeradiusbasesq = squared(self.meleeradiusbase);
  maps\mp\zombies\_util::setmeleeradius(self.meleeradiusbase);
  self.defaultgoalradius = self.radius + 5;
  self scragentsetgoalradius(self.defaultgoalradius);
  self.meleedot = 0.85;
  self.lastmeleefinishtime = 0;
  self.meleedebouncetime = 1.0;
  self.played_damage_for_threshold = [];
}

init() {
  self.animcbs = spawnStruct();
  self.animcbs.onenter = [];
  self.animcbs.onenter["idle"] = maps\mp\agents\dog\_zombie_dog_idle::main;
  self.animcbs.onenter["move"] = maps\mp\agents\dog\_zombie_dog_move::main;
  self.animcbs.onenter["traverse"] = maps\mp\agents\dog\_zombie_dog_traverse::main;
  self.animcbs.onenter["melee"] = maps\mp\agents\dog\_zombie_dog_melee::main;
  self.animcbs.onexit = [];
  self.animcbs.onexit["idle"] = maps\mp\agents\dog\_zombie_dog_idle::end_script;
  self.animcbs.onexit["move"] = maps\mp\agents\dog\_zombie_dog_move::end_script;
  self.animcbs.onexit["melee"] = maps\mp\agents\dog\_zombie_dog_melee::end_script;
  self.animcbs.onexit["traverse"] = maps\mp\agents\dog\_zombie_dog_traverse::end_script;
  self.animcbs.ondamage = [];
  self.animcbs.ondamage["move"] = maps\mp\agents\dog\_zombie_dog_move::ondamage;
  self.aistate = "idle";
  self.movemode = "run";
  self.radius = 18;

  if(maps\mp\zombies\_util::getzombieslevelnum() >= 3) {
    self.radius = 17;
  }

  self.height = 41;
}

think() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  thread maps\mp\zombies\_zombies::zombieaimonitorthreads();
  thread zombie_dog_moan();
  thread zombie_dog_audio_monitor();
  thread maps\mp\zombies\_zombies::updatebuffs();
  self.sharpturnnotifydist = 125;

  for(;;) {
    wait 0.05;

    if(maps\mp\zombies\_behavior::humanoid_begin_melee()) {
      continue;
    }
    if(maps\mp\zombies\_behavior::humanoid_seek_enemy_melee()) {
      continue;
    }
    if(maps\mp\zombies\_behavior::humanoid_seek_enemies_all_known()) {
      continue;
    }
    if(maps\mp\zombies\_behavior::humanoid_seek_random_loc()) {
      continue;
    }
  }
}

zombie_dog_moan() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    while(!isDefined(self.curmeleetarget)) {
      wait 0.25;
    }

    while(isDefined(self.curmeleetarget) && distancesquared(self.origin, self.curmeleetarget.origin) > 40000) {
      wait(randomfloatrange(0, 2));
      maps\mp\zombies\_zombies_audio::do_zombies_playvocals("idle", self.agent_type);
    }

    wait 0.05;
  }
}

zombie_dog_audio_monitor() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return_parms("attack_hit", "attack_miss");

    switch (var_0[0]) {
      case "attack_hit":
        var_1 = var_0[1];

        if(isDefined(var_1) && isplayer(var_1)) {
          if(isalive(var_1)) {
            var_1 playlocalsound("zmb_dog_bite_wound");
          } else {
            var_1 playsoundtoplayer("zmb_dog_bite_wound", var_1);
          }
        }

        break;
      case "attack_miss":
        maps\mp\zombies\_zombies_audio::do_zombies_playvocals("attack", self.agent_type);
        break;
    }
  }
}

waitforpathset() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("path_set");
    self.bhasbadpath = 0;
  }
}

ondamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self.timeoflastdamage = gettime();

  if(isDefined(self.owner)) {
    self.damagedownertome = vectornormalize(self.origin - self.owner.origin);
  }

  if(isDefined(self.animcbs.ondamage[self.aistate]) && shouldplaystophitreaction(var_2, var_5, var_4, var_8)) {
    self[[self.animcbs.ondamage[self.aistate]]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }
}

shouldplaystophitreaction(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && maps\mp\zombies\_util::iszombiednagrenade(var_1)) {
    return 0;
  }

  if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
    return 0;
  }

  if(isDefined(var_1) && var_1 == "zombie_water_trap_mp") {
    return 1;
  }

  var_4 = self.health - var_0;
  var_5 = [self.maxhealth * 0.6];

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(!isDefined(self.played_damage_for_threshold[var_6]) && var_4 < var_5[var_6]) {
      self.played_damage_for_threshold[var_6] = 1;
      return 1;
    }
  }

  return 0;
}

monitorflash() {
  self endon("death");

  for(;;) {
    self waittill("flashbang", var_0, var_1, var_2, var_3, var_4, var_5);

    if(isDefined(var_3) && var_3 == self.owner) {
      continue;
    }
    if(!maps\mp\agents\_scripted_agent_anim_util::isstatelocked()) {
      maps\mp\agents\dog\_zombie_dog_move::onflashbanged();
    }
  }
}