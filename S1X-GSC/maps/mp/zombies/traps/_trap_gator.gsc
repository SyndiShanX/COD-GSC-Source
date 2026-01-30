/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\traps\_trap_gator.gsc
*************************************************/

trap_gator_enter(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  self.water_level = undefined;
  var_3 = common_scripts\utility::getstructarray(self.target, "targetname");

  foreach(var_5 in var_3) {
    if(!isDefined(var_5.script_noteworthy)) {
      continue;
    }
    if(var_5.script_noteworthy == "gator_enter") {
      var_1 = var_5;
    }

    if(var_5.script_noteworthy == "gator_water_level") {
      var_2 = var_5;
    }
  }

  self.water_level = var_2.origin[2];
  var_7 = (var_1.origin[0], var_1.origin[1], var_1.origin[2]);
  var_8 = spawn("script_model", var_7);
  var_8.angles = var_1.angles;
  var_8 setModel("zom_king_croc_albino");

  if(isDefined(level.gator_kills_active) && level.gator_kills_active == 1) {
    var_8 thread trap_gator_gib_death();
    var_8 thread gator_collision_attach(var_0, 0);
  }

  var_8 notsolid();
  var_8 playsoundonmovingent("gator_spawn_vox");
  var_8 scriptmodelplayanim("zom_alligator_trap_spawn");
  var_9 = var_2.origin;
  var_10 = (0, 0, 90);
  playFX(common_scripts\utility::getfx("trap_gator_enter_splash"), var_9, var_10);
  playsoundatpos(var_9, "gator_spawn_splash");
  thread trap_gator_radius_damage(var_9);

  if(isDefined(self.usepitfallaudio) && self.usepitfallaudio == 1) {
    playsoundatpos(var_9, "ee_pitfall_swing");
  }

  earthquake(0.4, 1.0, var_9, 800);
  playrumbleonposition("artillery_rumble", var_9);
  wait 3.0;
  var_8 notify("delete");
  var_8 delete();
  var_8 thread gator_collision_reset(var_0);
  wait(randomfloatrange(3.0, 5.0));
}

trap_gator_trigger_watch(var_0, var_1) {
  self endon("cooldown");
  self endon("no_power");
  self endon("deactivate");
  self endon("ready");

  if(isDefined(var_1.gator_killed) && var_1.gator_killed) {
    self notify("deactivate");
  }

  self.gatorisattacking = 0;

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isplayer(var_2)) {
      continue;
    } else if(isDefined(var_2.inspawnanim) && var_2.inspawnanim == 1) {
      continue;
    } else if(isDefined(var_2.dismember_crawl) && var_2.dismember_crawl == 1) {
      continue;
    } else if(isDefined(var_2.agentteam) && var_2.agentteam == level.playerteam) {
      continue;
    } else if(var_2 maps\mp\zombies\_util::istrapresistant()) {
      continue;
    } else if(var_2 isanyplayerinrange()) {
      continue;
    } else if(self.gatorisattacking == 1) {
      continue;
    } else if(isDefined(var_2.gatorclaimed) && var_2.gatorclaimed == 1) {
      continue;
    } else {
      self.gatorisattacking = 1;
      var_2.gatorclaimed = 1;
      var_3 = trap_gator_spawn(var_2, var_1);
      trap_gator_attack(var_3, var_2, var_1);
      wait(randomfloatrange(3.0, 5.0));
      self.gatorisattacking = 0;
    }
  }
}

isanyplayerinrange() {
  var_0 = 4096;

  foreach(var_2 in level.players) {
    if(distance2dsquared(self.origin, var_2.origin) < var_0) {
      return 1;
    }
  }

  return 0;
}

trap_gator_spawn(var_0, var_1) {
  var_2 = (var_0.origin[0], var_0.origin[1], self.water_level - 28);
  var_3 = (0, randomfloat(360), 0);
  var_4 = spawn("script_model", var_2);
  var_4.angles = var_3;
  var_4 setModel("zom_king_croc_albino");

  if(isDefined(level.gator_kills_active) && level.gator_kills_active == 1) {
    var_4 thread trap_gator_gib_death();
    var_4 thread gator_collision_attach(var_1, 1);
  }

  return var_4;
}

gator_collision_attach(var_0, var_1) {
  var_0.origin = self.origin;
  var_0.angles = self.angles + (0, 90, 0);
  var_0 linkto(self, "J_MainRoot");

  if(var_1) {
    var_2 = "J_Head";
    var_3 = self gettagorigin(var_2);
    var_4 = self gettagangles(var_2);
    var_5 = spawn("script_model", var_3);
    var_5.angles = var_4;
    var_5 setModel("dlc2_zom_gib_arm_pickup");
    var_5 linkto(self, var_2, (14, -20, -7), (0, 0, 0));
    waittill_gator_death();
    var_5 delete();
  }
}

gator_collision_reset(var_0) {
  if(isDefined(var_0.start_origin) && isDefined(var_0.start_angles)) {
    var_0.origin = var_0.start_origin;
    var_0.angles = var_0.start_angles;
  }
}

waittill_gator_death() {
  self endon("delete");
  level waittill("gator_killed");
}

arm_debug_draw() {
  self endon("delete");

  while(isDefined(self)) {
    thread maps\mp\_utility::drawsphere(self.origin, 16, 1, (1, 0, 0));
    wait 0.1;
  }
}

trap_gator_gib_death() {
  self endon("delete");
  level endon("arm_spawned");

  if(isDefined(level.sqarmspawned)) {
    return;
  }
  var_0 = spawn("script_origin", self.origin);
  var_0 linkto(self, "J_MainRoot");
  level waittill("gator_killed");
  self hide();
  playFX(common_scripts\utility::getfx("dlc_gator_death"), var_0.origin + (0, 0, 32));
  playsoundatpos(var_0.origin, "sq_gator_death");
  var_0 thread maps\mp\mp_zombie_brg_sq::stage13_spawn_arm();
}

trap_gator_attack(var_0, var_1, var_2) {
  var_3 = randomint(2);

  if(isDefined(var_1.agent_type) && var_1.agent_type == "zombie_dog") {
    var_4 = "tag_mouth_fx";
    var_5 = "spine4_jnt";
  } else {
    var_4 = "jaw_jnt";
    var_5 = "j_mainroot";
  }

  var_6 = "zom_alligator_trap_attack_0" + (var_3 + 1);
  var_1 scragentsetscripted(1);
  var_1 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "SynchronizedAnim");
  var_1 scragentsetphysicsmode("noclip");
  thread playsplash(var_0, var_1);
  var_0 scriptmodelplayanim(var_6, "dummy");
  var_1 scragentsynchronizeanims(0.2, 0.1, var_0, var_4, var_5);
  var_1 maps\mp\agents\_scripted_agent_anim_util::playanimnuntilnotetrack_safe("alligator_trap_victim", var_3, "scripted_anim");
  var_1 maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "SynchronizedAnim");

  if(isDefined(var_1)) {
    var_7 = var_1.health * 10;

    if(isDefined(var_1.maxhealth)) {
      var_7 = var_1.maxhealth * 10;
    }

    var_1 dodamage(var_7, var_0.origin, self.owner, self.owner, "MOD_EXPLOSIVE", "trap_zm_mp");
  }

  wait 1.0;
  var_0 notify("delete");
  var_0 delete();
  var_0 thread gator_collision_reset(var_2);
}

playsplash(var_0, var_1) {
  level endon("gator_killed");
  var_2 = (var_0.origin[0], var_0.origin[1], self.water_level);
  var_3 = (0, 0, 90);
  wait 0.1;
  thread trap_gator_radius_damage(var_2);
  earthquake(0.3, 0.75, var_2, 400);
  playrumbleonposition("artillery_rumble", var_2);
  playFX(common_scripts\utility::getfx("trap_gator_emerge_splash"), var_2, var_3);
  var_0 playsoundonmovingent("gator_attack_vox");
  wait 0.2;

  if(isDefined(var_1) && isalive(var_1)) {
    var_4 = var_1 gettagorigin("J_Spine4");

    if(isDefined(var_4)) {
      playFX(common_scripts\utility::getfx("trap_gator_blood_splat"), var_4);
    }
  }

  wait 0.5;
  playFX(common_scripts\utility::getfx("trap_gator_attack_splash"), var_2, var_3);
}

trap_gator_radius_damage(var_0) {
  wait 0.05;
  var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
  var_1 = sortbydistance(var_1, var_0, 128);

  foreach(var_3 in var_1) {
    if(isplayer(var_3)) {
      if(!maps\mp\zombies\_util::isplayerinlaststand(var_3)) {
        var_3 thread trap_gator_push_players(var_0);
      }

      continue;
    } else if(isDefined(var_3.gatorclaimed) && var_3.gatorclaimed == 1) {
      continue;
    } else if(isDefined(var_3.agentteam) && var_3.agentteam == level.playerteam) {
      continue;
    } else if(var_3 maps\mp\zombies\_util::istrapresistant()) {
      continue;
    }
    if(common_scripts\utility::cointoss()) {
      var_4 = var_3.health * 10;

      if(isDefined(var_3.maxhealth)) {
        var_4 = var_3.maxhealth * 10;
      }
    } else {
      var_4 = var_3.health * 0.5;

      if(isDefined(var_3.maxhealth)) {
        var_4 = var_3.maxhealth * 0.5;
      }
    }

    var_3 dodamage(var_4, var_0, self.owner, self.owner, "MOD_EXPLOSIVE", "trap_zm_mp");
  }
}

trap_gator_push_players(var_0) {
  waitframe();
  var_1 = vectornormalize((self.origin - var_0) * (1, 1, 0));
  self setvelocity(var_1 * 100);
}

trap_gator_pitfall_audio() {
  self.usepitfallaudio = 1;

  foreach(var_1 in level.players) {
    thread trap_gator_pitfall_player_audio(var_1, "exo_boost", "ee_pitfall_jump");
    thread trap_gator_pitfall_player_audio(var_1, "begin_last_stand", "ee_pitfall_downed");
    thread trap_gator_pitfall_player_audio(var_1, "death", "ee_pitfall_death");
  }
}

trap_gator_pitfall_player_audio(var_0, var_1, var_2) {
  self endon("cooldown");
  self endon("no_power");
  self endon("deactivate");
  self endon("ready");
  var_0 endon("disconnect");

  if(var_1 != "death") {
    var_0 endon("death");
  }

  for(;;) {
    var_0 waittill(var_1);
    var_0 playsoundonmovingent(var_2);

    if(var_1 == "death") {
      break;
    }
  }
}