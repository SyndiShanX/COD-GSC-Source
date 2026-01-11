/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\_birds.gsc
**********************************************/

birds() {
  if(common_scripts\utility::issp()) {
    level waittill("load_finished");
  }
  else {
    level waittill("interactive_start");
  }

  if(!isDefined(level._interactive["birds_setup"])) {
    level._interactive["birds_setup"] = 1;
    level._interactive["bird_perches"] = [];
    var_0 = getEntArray("interactive_birds", "targetname");

    foreach(var_2 in var_0) {
    var_2 thread birds_setup();
    }
  }
}

birds_setup() {
  birds_finishbirdtypesetup(level._interactive[self.interactive_type]);
  birds_setupconnectedperches();

  if(isDefined(self.script_triggername)) {
    var_0 = birds_savetostruct();
    level waittill("start_" + self.script_triggername);
    var_0 birds_loadfromstruct();
  } else {
    birds_createents();
    thread birds_fly(self.target);
  }
}

birds_createents() {
  var_0 = level._interactive[self.interactive_type];

  if(!isDefined(self.interactive_number)) {
    self.interactive_number = var_0.rig_numtags;
  }

  self setModel(var_0.rig_model);

  if(common_scripts\utility::issp()) {
    self call[[level.func["useanimtree"]]](var_0.rig_animtree);
  }

  self hideallparts();
  self.birds = [];
  self.birdexists = [];
  self.numbirds = 0;

  for(var_1 = 1; var_1 <= self.interactive_number; var_1++) {
    self.birds[var_1] = spawn("script_model", self gettagorigin("tag_bird" + var_1));
    self.birds[var_1] setModel(var_0.bird_model["idle"]);
    self.birds[var_1] linkto(self, "tag_bird" + var_1);

    if(common_scripts\utility::issp()) {
      self.birds[var_1] call[[level.func["useanimtree"]]](var_0.bird_animtree);
    }

    var_2 = (var_1 - randomfloat(1)) / self.interactive_number;
    self.birds[var_1] thread maps\interactive_models\_interactive_utility::wait_then_fn(var_2, "Stop initial model setup", ::bird_sit, self, "tag_bird" + var_1, var_0.bird_model["idle"], var_0.birdmodel_anims);
    self.birdexists[var_1] = 1;
    self.numbirds++;

    if(isDefined(var_0.bird_health)) {
      self.birds[var_1].health = var_0.bird_health;
    }
    else {
      self.birds[var_1].health = 20;
    }

    self.birds[var_1] setCanDamage(1);
    self.birds[var_1] thread bird_waitfordamage(self, var_1);
  }

  if(isDefined(self.script_triggername)) {
    thread birds_waitfortriggerstop();
  }
}

birds_setupconnectedperches(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = getent(self.target, "targetname");
  }

  var_2 = spawnStruct();
  var_2.targetname = var_0.targetname;
  var_2.target = var_0.target;
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  var_2.interactive_takeoffanim = var_0.interactive_takeoffanim;
  var_2.interactive_landanim = var_0.interactive_landanim;
  var_2.script_radius = var_0.script_radius;
  var_2.script_noteworthy = var_0.script_noteworthy;
  var_2.script_triggername = var_0.script_triggername;

  if(isDefined(var_1)) {
    var_1[0] = var_2;
  }

  if(isDefined(var_0.incoming)) {
    foreach(var_4 in var_0.incoming) {
    var_4.endperch = var_2;
    }
  }

  var_0 delete();
  level._interactive["bird_perches"][var_2.targetname] = var_2;

  if(!isDefined(var_2.interactive_takeoffanim)) {
    var_2.interactive_takeoffanim = "flying";
  }

  if(!isDefined(var_2.interactive_landanim)) {
    var_2.interactive_landanim = "flying";
  }

  var_2.triggers = [];
  var_6 = getEntArray(var_2.targetname, "target");

  foreach(var_8 in var_6) {
    if(var_8.classname == "trigger_multiple") {
      var_2.triggers[var_2.triggers.size] = var_8;
    }
  }

  if(isDefined(var_2.target)) {
    var_6 = getEntArray(var_2.target, "targetname");

    foreach(var_8 in var_6) {
      if(var_8.classname == "trigger_multiple") {
        var_2.triggers[var_2.triggers.size] = var_8;
      }
    }
  }

  if(isDefined(var_2.script_triggername)) {
    var_6 = getEntArray(var_2.script_triggername, "target");

    foreach(var_8 in var_6) {
      if(var_8.classname == "trigger_multiple") {
        var_2.triggers[var_2.triggers.size] = var_8;
      }
    }
  }

  if(!isDefined(var_1)) {
    var_14 = getvehiclenodearray(var_2.target, "targetname");

    foreach(var_16 in var_14) {
      var_17 = [];
      var_17[0] = var_2;
      var_17[1] = var_16;

      for(var_18 = 1; !isDefined(var_17[var_18].script_noteworthy) || var_17[var_18].script_noteworthy != "bird_perch"; var_18++) {
        if(!isDefined(var_17[var_18].target)) {
          break;
        }

        var_19 = var_17[var_18].target;
        var_20 = getvehiclenode(var_19, "targetname");

        if(!isDefined(var_20)) {
          var_20 = getnode(var_19, "targetname");

          if(!isDefined(var_20)) {
            var_20 = getent(var_19, "targetname");

            if(isDefined(var_20)) {
              var_20 = birds_setupconnectedperches(var_20);
            }
            else {
              var_20 = level._interactive["bird_perches"][var_2.targetname];
            }
          }
        }

        var_17[var_18 + 1] = var_20;
      }

      var_2 birds_perchsetuppath(var_17);
    }
  } else
    var_2 birds_perchsetuppath(var_1);

  return var_2;
}

birds_perchsetuppath(var_0) {
  if(!isDefined(self.outgoing)) {
    self.outgoing = [];
  }

  var_1 = common_scripts\_csplines::cspline_makepath(var_0);
  var_2 = var_0[var_0.size - 1];

  if(isDefined(var_2.classname)) {
    if(!isDefined(var_2.incoming)) {
      var_2.incoming = [];
    }

    var_2.incoming[var_2.incoming.size] = var_1;
  }

  if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == "bird_perch") {
    var_1.endperch = var_2;
    var_1.landanim = var_2.interactive_landanim;
  }

  var_1.startorigin = self.origin;
  var_1.startangles = self.angles;
  var_1.takeoffanim = self.interactive_takeoffanim;
  var_1.endorigin = var_2.origin;
  var_1.endangles = var_2.angles;
  self.outgoing[self.outgoing.size] = var_1;
}

birds_fly(var_0) {
  self endon("death");
  self.perch = level._interactive["bird_perches"][var_0];
  var_1 = level._interactive[self.interactive_type];
  var_2 = self.perch.outgoing[randomint(self.perch.outgoing.size)];
  var_3 = common_scripts\_csplines::cspline_getpointatdistance(var_2, 0);
  self.origin = var_3["pos"];
  self.angles = var_2.startangles;

  if(common_scripts\utility::issp()) {
    self call[[level.func["setanimknob"]]](var_1.rigmodel_anims[var_2.takeoffanim], 1, 0, 0);
    self call[[level.func["setanimtime"]]](var_1.rigmodel_anims[var_2.takeoffanim], 0);
  } else
    self call[[level.func["scriptModelPlayAnim"]]](var_1.rigmodel_anims[var_2.takeoffanim + "mp"]);

  var_4 = 0;
  self.landed = 1;
  var_5 = var_1.scareradius;

  if(isDefined(self.perch.script_radius)) {
    var_5 = self.perch.script_radius;
  }

  if(var_5 > 0) {
    self.perch thread birds_perchdangertrigger(var_5, "triggered", "leaving perch");
  }

  for(;;) {
    var_6 = 0;
    var_7 = var_1.rigmodel_anims[var_2.takeoffanim];
    var_8 = var_1.rigmodel_anims[var_2.takeoffanim + "mp"];
    var_9 = var_1.rigmodel_anims["flying"];
    var_10 = var_1.rigmodel_anims["flyingmp"];

    if(isDefined(var_2.landanim)) {
      var_11 = var_1.rigmodel_anims[var_2.landanim];
      var_12 = var_1.rigmodel_anims[var_2.landanim + "mp"];
    } else {
      var_11 = undefined;
      var_12 = undefined;
    }

    if(isDefined(var_1.rigmodel_pausestart[var_2.takeoffanim])) {
      var_13 = var_1.rigmodel_pausestart[var_2.takeoffanim];
    }
    else {
      var_13 = 0;
    }

    var_14 = 0;

    if(!self.landed) {
      if(isDefined(var_11) && self.currentanim == var_11) {
        var_6 = 1 - self call[[level.func["getanimtime"]]](self.currentanim);
        var_14 = var_6 * getanimlength(var_7);
        var_13 = var_13 - var_14;
        var_13 = max(0, var_13);
      } else {
        var_7 = var_1.rigmodel_anims["flying"];
        var_8 = var_1.rigmodel_anims["flyingmp"];
        var_6 = self call[[level.func["getanimtime"]]](self.currentanim);
        var_14 = var_6 * getanimlength(var_7);
        var_13 = 0;
      }
    }

    if(isDefined(var_11) && isDefined(var_1.rigmodel_pauseend[var_2.landanim])) {
      var_15 = var_1.rigmodel_pauseend[var_2.landanim];
    }
    else {
      var_15 = 0;
    }

    var_16 = var_1.accn / 400;
    var_17 = var_2.segments[var_2.segments.size - 1].endat;
    var_18 = sqrt(var_16 * var_17 + var_4 * var_4 / 2);
    var_19 = var_1.topspeed / 20;

    if(var_18 < var_19) {
      var_19 = var_18;
    }

    var_20 = int((var_19 - var_4) / var_16);
    var_21 = var_16 * (var_20 / 2) * (var_20 + 1) + var_4 * var_20;

    if(isDefined(var_2.endperch)) {
      var_22 = int(var_19 / var_16);
      var_23 = var_16 * (var_22 / 2) * (var_22 + 1);
    } else {
      var_22 = 0;
      var_23 = 0;
    }

    var_24 = (var_17 - (var_21 + var_23)) / var_19;
    var_25 = (var_24 + (var_20 + var_22)) / 20;
    var_26 = getanimlength(var_9);

    if(isDefined(var_11)) {
      var_27 = getanimlength(var_7) + getanimlength(var_11) - (var_13 + var_14 + var_15);
    }
    else {
      var_27 = getanimlength(var_7) - (var_13 + var_14 + var_15);
    }

    var_28 = int((var_25 - var_27) / var_26 + 0.5);
    var_29 = (var_28 * var_26 + var_27) / var_25;
    var_30 = var_2.endangles - var_2.startangles;
    var_30 = (angleclamp180(var_30[0]), angleclamp180(var_30[1]), angleclamp180(var_30[2]));

    if(self.landed) {
      self.perch waittill("triggered");
      self.landed = 0;
      thread flock_fly_anim(var_7, 0, var_9, var_11, var_29, var_28, var_8, var_10, var_12);
      thread flock_playSound(var_1, "takeoff");
      var_31 = var_13 == 0;

      for(var_32 = 1; var_32 <= self.interactive_number; var_32++) {
        if(self.birdexists[var_32]) {
          self.birds[var_32] thread bird_flyfromperch(self, "tag_bird" + var_32, var_1.bird_model["fly"], var_1.bird_model["idle"], var_1.birdmodel_anims, "land_" + var_32, "takeoff_" + var_32, var_31);
        }
      }
    } else {
      self notify("stop_path");
      thread flock_fly_anim(var_7, var_6, var_9, var_11, var_29, var_28, var_8, var_10, var_12);

      for(var_32 = 1; var_32 <= self.interactive_number; var_32++) {
        if(self.birdexists[var_32]) {
          self.birds[var_32] thread bird_fly(self, "tag_bird" + var_32, var_1.bird_model["fly"], var_1.bird_model["idle"], var_1.birdmodel_anims, "land_" + var_32);
        }
      }
    }

    if(isDefined(self.perch)) {
      self.perch notify("leaving perch");
      self.perch = undefined;
    }

    wait(var_13);
    var_33 = 0;
    var_34 = 0.2;

    while(var_4 < var_19 - var_16) {
      var_4 = var_4 + var_16;
      var_33 = var_33 + var_4;
      var_3 = common_scripts\_csplines::cspline_getpointatdistance(var_2, var_33);
      self.origin = var_3["pos"];
      self.angles = var_2.startangles + var_30 * (var_33 / var_17);
      birds_set_flying_angles(self, var_3["vel"] * var_4, var_34, self.birds);
      wait 0.05;
    }

    var_4 = var_19;

    while(var_33 < var_17 - var_23) {
      var_33 = var_33 + var_4;
      var_3 = common_scripts\_csplines::cspline_getpointatdistance(var_2, var_33);
      self.origin = var_3["pos"];
      self.angles = var_2.startangles + var_30 * (var_33 / var_17);
      birds_set_flying_angles(self, var_3["vel"] * var_4, var_34, self.birds);
      wait 0.05;
    }

    if(!isDefined(var_2.endperch)) {
      birds_delete();
    }

    var_35 = var_17 - var_33;
    var_36 = var_35 / var_23;
    var_4 = var_16 * (int(var_4 / var_16) + 1);
    self.perch = var_2.endperch;
    self.perch thread birds_perchdangertrigger(var_5, "triggered", "leaving perch");

    while(var_4 > var_19 * 0.75 || var_4 > 0 && birds_isperchsafe(self.perch)) {
      var_4 = var_4 - var_16;
      var_33 = var_33 + var_4 * var_36;
      var_3 = common_scripts\_csplines::cspline_getpointatdistance(var_2, var_33);
      self.origin = var_3["pos"];
      self.angles = var_2.startangles + var_30 * (var_33 / var_17);
      birds_set_flying_angles(self, var_3["vel"] * var_4, var_34, self.birds);
      wait 0.05;
    }

    if(var_4 <= 0) {
      self.origin = self.perch.origin;
      self.angles = self.perch.angles;
      var_2 = self.perch.outgoing[randomint(self.perch.outgoing.size)];

      for(var_32 = 0; var_32 < 20 * var_15 && birds_isperchsafe(self.perch); var_32++) {
        wait 0.05;
      }

      if(birds_isperchsafe(self.perch)) {
        self.landed = 1;
      }

      continue;
    }

    var_37 = self.perch.outgoing[randomint(self.perch.outgoing.size)];
    var_2 = birds_path_move_first_point(var_37, var_3["pos"], var_3["vel"] * (var_4 / var_19));
    var_2.startangles = self.angles;
    self.perch notify("leaving perch");
    self.perch = undefined;
  }
}

debugprint(var_0) {}

birds_set_flying_angles(var_0, var_1, var_2, var_3) {
  if(common_scripts\utility::issp()) {
    for(var_4 = 1; var_4 <= var_3.size; var_4++) {
      if(self.birdexists[var_4]) {
        var_5 = var_0 gettagangles("tag_bird" + var_4);
        var_6 = anglesToForward(var_5) / var_2;
        var_7 = var_6 + var_1;
        var_8 = vectortoangles(var_7);
        var_9 = var_8 - var_5;
        var_9 = (angleclamp180(var_9[0]) / 3, angleclamp180(var_9[1]), 0);
        var_3[var_4] linkto(var_0, "tag_bird" + var_4, (0, 0, 0), var_9);
      }
    }
  }
}

flock_playSound(var_0, var_1) {
  if(isDefined(var_0.sounds) && isDefined(var_0.sounds[var_1])) {
    self playSound(var_0.sounds[var_1]);
  }
}

flock_fly_anim(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  self endon("stop_path");

  if(common_scripts\utility::issp()) {
    var_9 = 0;

    if(getanimlength(var_0) == 0) {} else {
      var_10 = var_4 / (getanimlength(var_0) * 20);
      var_1 = var_1 - 2 * var_10;

      if(var_1 > var_10) {
        var_9 = 0.3;
      }

      self call[[level.func["setflaggedanimknob"]]]("bird_rig_takeoff_anim", var_0, 1, var_9, var_4);
      self.currentanim = var_0;

      if(var_1 > var_10) {
        common_scripts\utility::waitframe();
        self call[[level.func["setanimtime"]]](var_0, var_1);
        self waittillmatch("bird_rig_takeoff_anim", "end");
      } else
        self waittillmatch("bird_rig_takeoff_anim", "end");
    }

    self call[[level.func["setflaggedanimknobrestart"]]]("bird_rig_loop_anim", var_2, 1, 0, var_4);
    self.currentanim = var_2;

    for(var_11 = 0; var_11 < var_5; var_11++) {
      self waittillmatch("bird_rig_loop_anim", "end");
    }

    if(isDefined(var_3)) {
      self call[[level.func["setflaggedanimknobrestart"]]]("bird_rig_land_anim", var_3, 1, 0.05, var_4);
      self.currentanim = var_3;
      self waittillmatch("bird_rig_land_anim", "end");
      return;
    }
  } else {
    if(getanimlength(var_0) == 0) {} else if(var_1 < 0.2) {
      self call[[level.func["scriptModelPlayAnim"]]](var_6);
      self.currentanim = var_0;
      wait(getanimlength(var_0));
    }

    self call[[level.func["scriptModelPlayAnim"]]](var_7);
    self.currentanim = var_2;

    for(var_11 = 0; var_11 < var_5; var_11++) {
      wait(getanimlength(var_2));
    }

    if(isDefined(var_3)) {
      self call[[level.func["scriptModelPlayAnim"]]](var_8);
      self.currentanim = var_3;
      wait(getanimlength(var_3));
    }
  }
}

bird_flyfromperch(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("death");
  var_0 endon("stop_path");

  if(isDefined(var_6) && !var_7 && common_scripts\utility::issp()) {
    var_0 waittillmatch("bird_rig_takeoff_anim", var_6);
  }

  self notify("Stop initial model setup");
  self setModel(var_2);
  self notify("stop_loop");

  if(var_7) {
    var_8 = maps\interactive_models\_interactive_utility::single_anim(var_4, "flying", undefined, 0);

    if(common_scripts\utility::issp()) {
      common_scripts\utility::waitframe();
      self call[[level.func["setanimtime"]]](var_8, randomfloat(1));
    }
  } else if(isDefined(var_4["takeoff"])) {
    var_9 = maps\interactive_models\_interactive_utility::single_anim(var_4, "takeoff", "takeoff_anim", 1);

    if(common_scripts\utility::issp()) {
      self waittillmatch("takeoff_anim", "end");
    }
    else {
      wait(getanimlength(var_9));
    }
  }

  bird_fly(var_0, var_1, var_2, var_3, var_4, var_5);
}

bird_fly(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  var_0 endon("stop_path");
  self setModel(var_2);
  self notify("stop_loop");
  thread maps\interactive_models\_interactive_utility::loop_anim(var_4, "flying", "stop_loop");
  var_0 waittillmatch("bird_rig_land_anim", var_5);

  if(isDefined(var_4["land"])) {
    self notify("stop_loop");
    self endon("stop_loop");
    maps\interactive_models\_interactive_utility::single_anim(var_4, "land", undefined, 1);
  }

  thread bird_sit(var_0, var_1, var_3, var_4);
}

bird_sit(var_0, var_1, var_2, var_3) {
  self endon("death");
  self setModel(var_2);
  self notify("stop_loop");
  maps\interactive_models\_interactive_utility::loop_anim(var_3, "idle", "stop_loop");
}

bird_waitfordamage(var_0, var_1) {
  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6);

    if(isDefined(self.origin)) {
      if(var_6 == "MOD_GRENADE_SPLASH") {
        var_5 = self.origin + (0, 0, 5);
      }

      playFX(level._interactive[var_0.interactive_type].death_effect, var_5);

      if(self.health <= 0) {
        var_0.birdexists[var_1] = 0;
        var_0.numbirds--;

        if(var_0.numbirds == 0) {
          var_0 delete();
        }

        self delete();
        continue;
      }

      if(isDefined(var_0.perch)) {
        var_0.perch notify("triggered");
      }
    }
  }
}

birds_finishbirdtypesetup(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  precachemodel(var_0.rig_model);

  foreach(var_3 in var_0.bird_model) {
  precachemodel(var_3);
  }

  if(!common_scripts\utility::issp()) {
    foreach(var_6 in var_0.sounds) {
    precachesound(var_6);
    }

    for(var_8 = 1; var_8 <= 12; var_8++) {
      precachestring("tag_bird" + var_8);
    }

    foreach(var_10 in getarraykeys(level._interactive[self.interactive_type].rigmodel_anims)) {
      if(isendstr(var_10, "mp")) {
        var_11 = level._interactive[self.interactive_type].rigmodel_anims[var_10];

        if(isarray(var_11)) {
          foreach(var_13 in var_11) {
          call[[level.func["precacheMpAnim"]]](var_13);
          }
        } else
          call[[level.func["precacheMpAnim"]]](var_11);
      }
    }

    foreach(var_10 in getarraykeys(level._interactive[self.interactive_type].birdmodel_anims)) {
      if(isendstr(var_10, "mp")) {
        var_11 = level._interactive[self.interactive_type].birdmodel_anims[var_10];

        if(isarray(var_11)) {
          foreach(var_13 in var_11) {
          call[[level.func["precacheMpAnim"]]](var_13);
          }
        } else
          call[[level.func["precacheMpAnim"]]](var_11);
      }
    }
  }

  var_0.savetostructfn = ::birds_savetostruct;
  var_0.loadfromstructfn = ::birds_loadfromstruct;
  var_0.rigmodel_pausestart = [];
  var_0.rigmodel_pauseend = [];
  var_20 = getarraykeys(var_0.rigmodel_anims);

  foreach(var_22 in var_20) {
    if(!isendstr(var_22, "mp")) {
      if(common_scripts\utility::string_starts_with(var_22, "takeoff_")) {
        if(getanimlength(var_0.rigmodel_anims[var_22]) == 0) {
          var_0.rigmodel_anims[var_22] = var_0.rigmodel_anims["fly"];
          var_0.rigmodel_pausestart[var_22] = 0;
        } else
          var_0.rigmodel_pausestart[var_22] = birds_get_last_takeoff(var_0, var_22, var_0.rig_numtags) + var_1;

        continue;
      }

      if(common_scripts\utility::string_starts_with(var_22, "land_")) {
        if(getanimlength(var_0.rigmodel_anims[var_22]) == 0) {
          var_0.rigmodel_anims[var_22] = var_0.rigmodel_anims["fly"];
          var_0.rigmodel_pauseend[var_22] = 0;
          continue;
        }

        var_0.rigmodel_pauseend[var_22] = birds_get_first_land(var_0, var_22, var_0.rig_numtags);
      }
    }
  }
}

birds_get_last_takeoff(var_0, var_1, var_2) {
  var_3 = var_0.rigmodel_anims[var_1];
  var_4 = 0;

  for(var_5 = 1; var_5 <= var_2; var_5++) {
    var_6 = getnotetracktimes(var_3, "takeoff_" + var_5);

    if(var_6.size <= 0) {
      continue;
    }
    if(var_6.size > 1) {
      continue;
    }
    if(var_6[0] > var_4) {
      var_4 = var_6[0];
    }
  }

  return getanimlength(var_0.rigmodel_anims[var_1]) * var_4;
}

birds_get_first_land(var_0, var_1, var_2) {
  var_3 = var_0.rigmodel_anims[var_1];
  var_4 = 1;

  for(var_5 = 1; var_5 <= var_2; var_5++) {
    var_6 = getnotetracktimes(var_3, "land_" + var_5);

    if(var_6.size <= 0) {
      continue;
    }
    if(var_6.size > 1) {
      continue;
    }
    if(var_6[0] < var_4) {
      var_4 = var_6[0];
    }
  }

  return getanimlength(var_0.rigmodel_anims[var_1]) * (1 - var_4);
}

birds_perchdangertrigger(var_0, var_1, var_2) {
  self.trigger = spawn("trigger_radius", self.origin - (0, 0, var_0), 23, var_0, 2 * var_0);
  thread maps\interactive_models\_interactive_utility::delete_on_notify(self.trigger, "death", var_2);
  thread birds_perchtouchtrigger(self.trigger, var_1, var_2);
  thread birds_percheventtrigger(var_0, var_1, var_2);

  foreach(var_4 in self.triggers) {
  thread birds_perchtouchtrigger(var_4, var_1, var_2);
  }
}

birds_perchtouchtrigger(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_2);

  for(;;) {
    var_0.anythingtouchingtrigger = 0;
    var_0 waittill("trigger");
    self notify(var_1);
    var_0.anythingtouchingtrigger = 1;
    wait 1;
  }
}

birds_percheventtrigger(var_0, var_1, var_2) {
  if(common_scripts\utility::issp()) {
    self endon("death");
    self endon(var_2);
    self.sentient = spawn("script_origin", self.origin);
    self.sentient call[[level.makeentitysentient_func]]("neutral");
    thread maps\interactive_models\_interactive_utility::wait_then_fn(var_2, "death", ::birds_deleteperchsentient);
    self.sentient call[[level.addaieventlistener_func]]("projectile_impact");
    self.sentient call[[level.addaieventlistener_func]]("bulletwhizby");
    self.sentient call[[level.addaieventlistener_func]]("explode");
    self.lastaieventtrigger = gettime() - 500;

    for(;;) {
      self.sentient waittill("ai_event", var_3, var_4, var_5);

      if(var_3 != "explode" && var_3 != "gunshot" || distancesquared(self.origin, var_5) < 2 * var_0) {
        self notify(var_1);
        self.lastaieventtrigger = gettime();
      }
    }
  }
}

birds_deleteperchsentient() {
  self.sentient delete();
}

birds_isperchsafe(var_0) {
  var_1 = 0;
  var_2 = !var_0.trigger.anythingtouchingtrigger;

  if(var_2) {
    foreach(var_4 in var_0.triggers) {
      if(var_4.anythingtouchingtrigger) {
        var_2 = 0;
        continue;
      }
    }

    if(var_0.lastaieventtrigger > gettime()) {
      var_0.lastaieventtrigger = gettime() - 500;
    }

    if(gettime() - var_0.lastaieventtrigger >= 500) {
      var_1 = 1;
    }
  }

  return var_2 && var_1;
}

birds_path_move_first_point(var_0, var_1, var_2) {
  var_3 = common_scripts\_csplines::cspline_movefirstpoint(var_0, var_1, var_2);
  var_3.startorigin = var_1;

  if(isDefined(var_0.startangles)) {
    var_3.startangles = var_0.startangles;
  }

  if(isDefined(var_0.endorigin)) {
    var_3.endorigin = var_0.endorigin;
  }

  if(isDefined(var_0.endangles)) {
    var_3.endangles = var_0.endangles;
  }

  if(isDefined(var_0.endperch)) {
    var_3.endperch = var_0.endperch;
  }

  if(isDefined(var_0.takeoffanim)) {
    var_3.takeoffanim = var_0.takeoffanim;
  }

  if(isDefined(var_0.landanim)) {
    var_3.landanim = var_0.landanim;
  }

  return var_3;
}

birds_spawnandflyaway(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._interactive["scriptSpawnedCount"])) {
    level._interactive["scriptSpawnedCount"] = 0;
  }

  level._interactive["scriptSpawnedCount"]++;
  var_4 = spawn("script_model", var_1);
  var_4.angles = vectortoangles(var_2);
  var_4.targetname = "scriptSpawned_" + level._interactive["scriptSpawnedCount"];
  var_4.script_noteworthy = "bird_perch";
  var_5 = [];
  var_5[0] = var_4;
  var_5[1] = spawnStruct();
  var_5[1].origin = var_1 + var_2;
  var_5[1].angles = var_4.angles;
  var_4 = birds_setupconnectedperches(var_4, var_5);
  var_6 = spawnStruct();
  var_6.interactive_type = var_0;
  var_6.target = var_4.targetname;
  var_6.origin = var_1;
  var_6.interactive_number = var_3;
  var_6 birds_loadfromstruct();
  var_4 notify("triggered");
  common_scripts\utility::waitframe();
  level._interactive["bird_perches"][var_4.targetname] = undefined;
}

birds_waitfortriggerstop() {
  self endon("death");
  level waittill("stop_" + self.script_triggername);
  thread birds_savetostructandwaitfortriggerstart();
}

birds_savetostructandwaitfortriggerstart() {
  var_0 = birds_savetostruct();
  level waittill("start_" + self.script_triggername);
  var_0 birds_loadfromstruct();
}

birds_savetostruct() {
  var_0 = spawnStruct();
  var_0.interactive_type = self.interactive_type;
  var_0.target = self.target;
  var_0.origin = self.origin;
  var_0.targetname = self.targetname;

  if(isDefined(self.interactive_number)) {
    var_0.interactive_number = self.interactive_number;
  }

  var_0.script_triggername = self.script_triggername;
  birds_delete();
  return var_0;
}

birds_loadfromstruct() {
  var_0 = spawn("script_model", self.origin);
  var_0.interactive_type = self.interactive_type;
  var_0.target = self.target;
  var_0.origin = self.origin;

  if(isDefined(self.interactive_number)) {
    var_0.interactive_number = self.interactive_number;
  }

  var_0.script_triggername = self.script_triggername;
  var_0.targetname = "interactive_birds";

  if(!isDefined(level._interactive["bird_perches"][self.target])) {
    var_0 birds_setupconnectedperches();
  }

  var_0 birds_createents();
  var_0 thread birds_fly(var_0.target);
}

birds_delete() {
  if(isDefined(self.birds)) {
    for(var_0 = 1; var_0 <= self.birds.size; var_0++) {
      if(self.birdexists[var_0]) {
        self.birds[var_0] delete();
      }
    }
  }

  if(isDefined(self.perch)) {
    self.perch notify("leaving perch");
  }

  self delete();
}