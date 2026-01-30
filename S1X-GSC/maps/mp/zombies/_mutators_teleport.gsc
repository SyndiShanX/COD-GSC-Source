/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_mutators_teleport.gsc
**************************************************/

initteleportmutator() {
  level._effect["teleport_pre_fx"] = loadfx("vfx/unique/dlc_teleport_zm_start");
  level._effect["teleport_post_fx"] = loadfx("vfx/unique/dlc_teleport_zombie");
  maps\mp\zombies\_mutators::addmutatortotable("teleport", ::mutatorteleport, "zmb_mut_emz_spawn");
  maps\mp\zombies\_mutators::disablemutatorfortypes("teleport", ["zombie_ranged_goliath"]);
}

mutatorteleport() {
  if(self.agent_type == "zombie_dog") {
    mutatorteleport_base();
    return;
  }

  if(!maps\mp\zombies\_util::is_true(self.nomutatormodelswap)) {
    var_0 = ["zom_blink_torso_a_slice"];
    var_1 = ["zom_blink_torso_a_slice"];
    var_2 = ["zom_blink_head_a"];
    var_3 = ["zom_blink_r_leg_a_slice"];
    var_4 = ["zom_blink_r_leg_a_slice"];
    var_5 = ["zom_blink_l_leg_a_slice"];
    var_6 = ["zom_blink_l_leg_a_slice"];
    var_7 = ["zom_blink_r_arm_a_slice"];
    var_8 = ["zom_blink_r_arm_a_slice"];
    var_9 = ["zom_blink_l_arm_a_slice"];
    var_10 = ["zom_blink_l_arm_a_slice"];
    var_11 = randomint(var_0.size);
    var_12 = randomint(var_2.size);
    var_13 = randomint(var_3.size);
    var_14 = randomint(var_5.size);
    var_15 = randomint(var_7.size);
    var_16 = randomint(var_9.size);
    self.precloneswapfunc = maps\mp\zombies\_mutators::mutator_precloneswap;
    self detachall();
    self setModel(var_0[var_11]);
    self.swapbody = var_1[var_11];
    self attach(var_2[var_12]);
    self.headmodel = var_2[var_12];
    self attach(var_3[var_13]);
    self attach(var_5[var_14]);
    self attach(var_7[var_15]);
    self attach(var_9[var_16]);
    self.limbmodels["right_leg"] = var_3[var_13];
    self.limbmodels["left_leg"] = var_5[var_14];
    self.limbmodels["right_arm"] = var_7[var_15];
    self.limbmodels["left_arm"] = var_9[var_16];
    self.swaplimbmodels["right_leg"] = var_4[var_13];
    self.swaplimbmodels["left_leg"] = var_6[var_14];
    self.swaplimbmodels["right_arm"] = var_8[var_15];
    self.swaplimbmodels["left_arm"] = var_10[var_16];
  }

  mutatorteleport_base();
}

mutatorteleport_base() {
  thread maps\mp\zombies\_mutators::mutatorspawnsound("teleport");
  mutatorteleport_startfx();
  thread mutatorteleport_handleteleport();
  self waittill("death");
}

mutatorteleport_startfx() {
  mutatorteleport_starteyefx();
  mutatorteleport_startbodyfx();
}

mutatorteleport_starteyefx() {
  if(self.agent_type == "zombie_dog") {
    maps\mp\zombies\_util::zombie_set_eyes("zombie_dog_eye_emp");
  } else if(isDefined(self.eyefxfunc)) {
    self[[self.eyefxfunc]]();
  } else {
    maps\mp\zombies\_util::zombie_set_eyes("zombie_eye_emp");
  }
}

mutatorteleport_startbodyfx() {}

mutatorteleport_handleteleport() {
  self endon("death");
  maps\mp\zombies\_util::waittill_enter_game();

  for(;;) {
    self.teleport_min_time_between = 0.5 / self.generalspeedratescale;
    self.teleport_max_time_between = 3.2 / self.generalspeedratescale;
    wait(randomfloatrange(self.teleport_min_time_between, self.teleport_max_time_between));

    if(!isalive(self)) {
      continue;
    }
    if(self.aistate != "move") {
      continue;
    }
    if(maps\mp\agents\_scripted_agent_anim_util::isstatelocked() || maps\mp\zombies\_util::is_true(self.inturnanim)) {
      continue;
    }
    if(maps\mp\zombies\_util::is_true(self.hasexploded)) {
      continue;
    }
    if(isDefined(self.spikeblastready)) {
      continue;
    }
    var_0 = anglesToForward(self.angles);
    var_1 = self scragentgetnodesonpath();
    var_2 = self getpathgoalpos();
    var_3 = distancesquared(self.origin, var_2);
    var_4 = [];
    self.teleport_min_dist_sq = squared(50 * self.generalspeedratescale);
    self.teleport_max_dist_sq = squared(450 * self.generalspeedratescale);

    for(var_5 = 0; var_5 < var_1.size; var_5++) {
      var_6 = var_1[var_5];
      var_7 = distancesquared(self.origin, var_6.origin);

      if(var_7 < self.teleport_min_dist_sq) {
        continue;
      }
      if(var_7 > self.teleport_max_dist_sq) {
        continue;
      }
      if(var_7 > var_3) {
        continue;
      }
      var_8 = vectornormalize(var_6.origin - self.origin);
      var_9 = vectordot(var_8, var_0);

      if(var_9 < 0) {
        continue;
      }
      var_4[var_4.size] = [var_6, var_5];
    }

    if(var_4.size > 0) {
      var_10 = common_scripts\utility::random(var_4);
      var_11 = var_10[0];
      var_12 = var_10[1];

      if(var_12 + 1 < var_1.size) {
        var_13 = var_1[var_12 + 1].origin - var_11.origin;
      } else {
        var_13 = var_2 - var_11.origin;
      }

      var_14 = vectortoangles(var_13 * (1, 1, 0));

      if(isDefined(self.teleportprefxoverride)) {
        playFX(self.teleportprefxoverride, self.origin, (1, 0, 0), (0, 0, 1));
      } else {
        playFX(level._effect["teleport_pre_fx"], self.origin, (1, 0, 0), (0, 0, 1));
      }

      if(isDefined(self.teleportpostfxoverride)) {
        playFX(self.teleportpostfxoverride, var_11.origin, (1, 0, 0), (0, 0, 1));
      } else {
        playFX(level._effect["teleport_post_fx"], var_11.origin, (1, 0, 0), (0, 0, 1));
      }

      thread play_zombie_teleport_sound();
      var_15 = self getvelocity();
      self setorigin(var_11.origin, 1);
      self setangles(var_14);
      self setvelocity(anglesToForward(var_14) * length(var_15));
      self scragenttrimpath(var_11);
      wait 0.05;
      mutatorteleport_startfx();
    }
  }
}

play_zombie_teleport_sound() {
  if(self.agent_type == "zombie_generic") {
    self playsoundonmovingent("teleport_blink_zombie");
  } else if(self.agent_type == "zombie_dog") {
    self playsoundonmovingent("teleport_dog_zombie");
  } else if(self.agent_type == "zombie_melee_goliath") {
    self playsoundonmovingent("teleport_goliath_zombie");
  } else {
    self playsoundonmovingent("teleport_blink_zombie");
  }
}