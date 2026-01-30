/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\traps\_trap_sniper.gsc
**************************************************/

init() {
  precachelaser("trap_zm");
  level._effect["trap_sniper_tracer"] = loadfx("vfx/map/mp_zombie_brg/brg_sniper_tracer");
  level.sniperzombietargetlocations = ["J_Shoulder_RI", "J_Shoulder_LE", "J_Hip_LE", "J_Hip_RI", "J_Head"];
  level.sniperdogtargetlocations = ["r_frontLeg0_JNT", "r_frontLeg1_JNT", "l_backLeg0_JNT", "l_backLeg1_JNT", "J_Spine4", "J_Head"];
}

spawnsniperent(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2.start_origin = var_0.origin;
  var_2.start_angles = var_0.angles;
  var_2 setModel("tag_laser");
  var_2 laseron("trap_zm");
  var_3 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_2.lasertargetent = var_3;
  var_2 thread lerplasertotarget(var_1);
  var_2 thread findvalidtargets(var_3, var_1);
  var_2 thread sniper_trap_audio(var_1);
  return var_2;
}

findvalidtargets(var_0, var_1) {
  self endon("death");

  for(;;) {
    wait 0.05;
    var_2 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
    var_2 = sortbydistance(var_2, self.origin, 2048);

    foreach(var_4 in var_2) {
      if(var_4.agentteam == level.playerteam || maps\mp\zombies\_util::is_true(var_4.inspawnanim)) {
        var_2 = common_scripts\utility::array_remove(var_2, var_4);
      }

      if(isDefined(var_4.sniperclaimed) && var_4.sniperclaimed == 1) {
        var_2 = common_scripts\utility::array_remove(var_2, var_4);
      }
    }

    if(isDefined(var_2[0]) && isalive(var_2[0])) {
      self.lasertargetent = var_2[0];
      self.lasertargetent.sniperclaimed = 1;
      sniperthink(self.lasertargetent, var_1);
      continue;
    }

    self.lasertargetent = var_0;
  }
}

lerplasertotarget(var_0) {
  self endon("death");

  for(;;) {
    while(isDefined(self.lasertargetent)) {
      if(isai(self.lasertargetent) && isalive(self.lasertargetent)) {
        var_1 = snipercheckaitype(self.lasertargetent);
        var_2 = self.lasertargetent gettagorigin(common_scripts\utility::random(var_1));
      } else {
        var_2 = self.lasertargetent.origin + common_scripts\utility::randomvectorrange(-50, 50);
      }

      var_3 = vectortoangles(var_2 - self.origin);
      var_4 = 0;
      var_5 = 1000;
      var_6 = gettime();

      while(var_4 < 1) {
        var_4 = clamp((gettime() - var_6) / var_5, 0, 1);
        self.angles = vectorlerp(self.angles, var_3, var_4);
        wait 0.05;
      }

      wait 0.05;
    }

    wait 0.05;
  }
}

snipercheckaitype(var_0) {
  if(isDefined(var_0.agent_type) && var_0.agent_type == "zombie_dog") {
    return level.sniperdogtargetlocations;
  } else {
    return level.sniperzombietargetlocations;
  }
}

sniperthink(var_0, var_1) {
  var_1 endon("snipers_off");
  var_0 endon("death");
  var_2 = self.origin;

  for(;;) {
    var_3 = randomfloatrange(1.5, 5.0);
    var_0 common_scripts\utility::waittill_any_timeout(var_3, "death");
    var_4 = var_0 gettagorigin(common_scripts\utility::random(snipercheckaitype(var_0))) + common_scripts\utility::randomvectorrange(-5, 5);
    var_5 = vectornormalize(var_4 - var_2);
    playFX(common_scripts\utility::getfx("trap_sniper_tracer"), var_2, var_5, (0, 0, 1));
    magicbullet("trap_sniper_zm_mp", var_2, var_4, var_1.owner);
    playsoundatpos(self.origin, "sniper_shot_extra_report");
  }
}

sniper_trap_audio(var_0) {
  var_1 = spawn("script_origin", var_0.origin);
  playsoundatpos(var_0.origin, "sniper_start_front");
  playsoundatpos((2508, -514, 555), "sniper_servo_start_left");
  playsoundatpos((3779, -2179, 555), "sniper_servo_start_right");
  var_0 waittill("snipers_off");
  playsoundatpos(var_0.origin, "sniper_stop_front");
  playsoundatpos((2508, -514, 555), "sniper_servo_stop_left");
  playsoundatpos((3779, -2179, 555), "sniper_servo_stop_right");
  waitframe();
  var_1 delete();
}