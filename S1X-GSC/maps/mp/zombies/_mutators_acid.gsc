/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_mutators_acid.gsc
**********************************************/

initacidmutator() {
  level.activeacidzombies = 0;

  if(level.nextgen) {
    level.maxacidzombies = 4;
  } else {
    level.maxacidzombies = 2;
  }

  level._effect["mut_acid_pool"] = loadfx("vfx/blood/dlc_mutator_acid_pool_yllw_sm");
  level._effect["mut_acid_head"] = loadfx("vfx/blood/dlc_mutator_ooze_drip_yllw");
  level._effect["mut_acid_arm_l"] = loadfx("vfx/blood/dlc_mutator_ooze_drip_yllw");
  level._effect["mut_acid_arm_r"] = loadfx("vfx/blood/dlc_mutator_ooze_drip_yllw");
  level._effect["mut_acid_back"] = loadfx("vfx/blood/dlc_mutator_ooze_drip_yllw");
  level._effect["mut_acid_eye"] = loadfx("vfx/gameplay/mp/zombie/zombie_eye_acid");
  maps\mp\zombies\_mutators::addmutatortotable("acid", ::mutatoracid, "zmb_mut_acid_spawn");
  maps\mp\zombies\_mutators::disablemutatorfortypes("acid", ["zombie_dog", "zombie_melee_goliath", "zombie_ranged_goliath"]);
  precacheshader("screen_blood_directional_center_yellow");
  precacheshader("screen_blood_directional_right_yellow");
  precacheshader("screen_blood_directional_left_yellow");
  level.acidscreenoverlayshaders = ["center", "right", "left"];
}

mutatoracid() {
  level.activeacidzombies++;
  maps\mp\agents\humanoid\_humanoid_util::enable_humanoid_exo_abilities();
  self.boostfxtag = "tag_jetpack";
  thread maps\mp\zombies\_mutators::mutatorspawnsound("acid");
  self.acidpools = 0;
  maps\mp\zombies\_util::zombie_set_eyes("mut_acid_eye");
  maps\mp\zombies\_mutators::torso_effects_apply("mut_acid");
  self playLoopSound("zmb_mut_acid_drip_loop");
  thread mutatoraciddotzonespawner();
  self waittill("death");
  level.activeacidzombies--;
}

mutatoraciddotzonespawner() {
  self endon("death");

  for(;;) {
    wait(randomfloatrange(1.5, 2));

    if(self.aistate == "traverse" || !isDefined(self.ismoving) || isDefined(self.inwater) && self.acidpools < 10) {
      continue;
    }
    var_0 = bulletTrace(self.origin, self.origin - (0, 0, 32), 0, self);

    if(!isDefined(var_0["normal"])) {
      continue;
    }
    if(common_scripts\utility::cointoss()) {
      continue;
    }
    self.acidpools++;
    var_1 = spawn("script_model", var_0["position"] + (0, 0, 8));
    var_1 setModel("tag_origin");
    var_1.angles = vectortoangles(var_0["normal"]);
    maps\mp\zombies\_util::playfxontagnetwork(common_scripts\utility::getfx("mut_acid_pool"), var_1, "tag_origin");

    if(level.nextgen) {
      var_2 = spawn("trigger_radius", var_0["position"], 0, 48, 16);
      thread mutatoracidtriggerthink(var_2);
      thread mutatoracidzonecleanup(var_2, var_1);
      level notify("acid_zone_created", var_2);
      continue;
    }

    thread mutatoracidtriggerthink_cg(var_0["position"]);
    thread mutatoracidzonecleanup_cg(var_1);
    level notify("acid_zone_created", var_0["position"]);
  }
}

mutatoracidtriggerthink(var_0) {
  var_0 endon("death");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isplayer(var_1) && !maps\mp\zombies\_util::isplayerinlaststand(var_1)) {
      var_1 thread mutatoracidplayereffects();
      var_1 dodamage(clamp(20 * (level.wavecounter / 6), 20, 60), var_1.origin);
      var_1 playlocalsound("zmb_mut_acid_damage");
      wait 1;
    }
  }
}

mutatoracidtriggerthink_cg(var_0) {
  var_1 = 0;

  for(;;) {
    if(var_1 >= 15) {
      return;
    }
    foreach(var_3 in level.players) {
      if(!maps\mp\zombies\_util::isplayerinlaststand(var_3) && distance(var_3.origin, var_0) < 48) {
        var_3 thread mutatoracidplayereffects();
        var_3 dodamage(clamp(20 * (level.wavecounter / 6), 20, 60), var_3.origin);
        var_3 playlocalsound("zmb_mut_acid_damage");
        var_1 = var_1 + 0.8;
        wait 0.8;
        break;
      }
    }

    var_1 = var_1 + 0.2;
    wait 0.2;
  }
}

mutatoracidplayereffects() {
  self endon("death");
  self notify("remove_acid_debuff");
  self endon("remove_acid_debuff");
  self allowsprint(0);

  foreach(var_1 in level.acidscreenoverlayshaders) {
    thread mutatoracidoverlay(var_1);
  }

  wait 1.25;

  if(!maps\mp\zombies\_util::isplayerinlaststand(self)) {
    self allowsprint(1);
  }

  self notify("remove_acid_overlay");
}

mutatoracidzonecleanup(var_0, var_1) {
  wait 15;

  if(isDefined(self) && isalive(self) && isDefined(self.acidpools)) {
    self.acidpools--;
  }

  var_0 delete();
  var_1 delete();
}

mutatoracidzonecleanup_cg(var_0) {
  wait 15;

  if(isDefined(self) && isalive(self) && isDefined(self.acidpools)) {
    self.acidpools--;
  }

  var_0 delete();
}

mutatoracidoverlay(var_0) {
  var_1 = newclienthudelem(self);
  var_1.x = 0;
  var_1.y = 0;
  var_1.alignx = "left";
  var_1.aligny = "top";
  var_1.horzalign = "fullscreen";
  var_1.vertalign = "fullscreen";
  var_1 setshader("screen_blood_directional_" + var_0 + "_yellow", 640, 480);
  var_1.sort = -10;
  var_1.archived = 1;
  var_1.hidein3rdperson = 1;
  var_1.alpha = 0;
  _fadehudalpha(var_1, 1, 1);
  self waittill("remove_acid_overlay");
  _fadehudalpha(var_1, 0, 1);
  wait 1;
  var_1 destroy();
}

_fadehudalpha(var_0, var_1, var_2) {
  var_0 fadeovertime(var_2);
  var_0.alpha = var_1;
}