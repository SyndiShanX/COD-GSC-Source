/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\_fish.gsc
*********************************************/

fish() {
  level waittill("load_finished");

  if(isDefined(level._interactive["fish_setup"])) {
    return;
  }
  level._interactive["fish_setup"] = 1;
  var_0 = getEntArray("interactive_fish", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(var_2.classname == "script_model") {
      var_2 thread single_fish_start();
    }
  }
}

single_fish_start() {
  if(isDefined(self.target)) {
    var_0 = getEntArray(self.target, "targetname");
  }
  else {
    var_0 = [];
  }

  if(var_0.size >= 1 && isDefined(var_0[0].script_noteworthy) && var_0[0].script_noteworthy == "interactive_fish") {
    self.following = var_0[0];

    if(!isDefined(var_0[0].followedby)) {
      var_0[0].followedby = [];
    }

    var_0[0].followedby[var_0[0].followedby.size] = self;
    var_0 = [];
  }

  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.script_radius = self.script_radius;
  var_0[var_0.size] = var_1;

  if(!isDefined(self.script_moveplaybackrate)) {
    self.script_moveplaybackrate = 1;
  }

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.script_radius)) {
      var_3.script_radius = level._interactive[self.interactive_type].default_wander_radius;
    }
  }

  thread single_fish_detectdamage("interrupted");
  thread single_fish_idle(self.interactive_type, var_0, var_1.origin, var_1.script_radius, 1);
  self removefrommovingplatformsystem(1);
}

single_fish_idle(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("interrupted");

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_5 = level._interactive[var_0];
  self useanimtree(var_5.animtree);
  thread maps\interactive_models\_interactive_utility::detect_people(var_5.people_react_distance, "interrupted", ["interrupted", "death", "damage"]);
  thread maps\interactive_models\_interactive_utility::detect_player_event(var_5.gunfire_react_distance, "interrupted", ["interrupted", "death", "damage"], "weapon_fired");
  thread single_fish_flee(var_0, var_1);

  for(;;) {
    var_6 = var_2 - self.origin;
    var_7 = length((var_6[0], var_6[1], 2 * var_6[2]));

    if(var_7 > var_3 * 2) {
      var_8 = maps\interactive_models\_interactive_utility::single_anim(var_5.anims, "flee_continue", "idle anim", 1, self.script_moveplaybackrate);
    }
    else {
      var_8 = maps\interactive_models\_interactive_utility::single_anim(var_5.anims, "idle", "idle anim", 1, self.script_moveplaybackrate);
    }

    var_9 = getanimlength(var_8) / self.script_moveplaybackrate;
    var_10 = length(getmovedelta(var_8)) / var_9;
    var_11 = 0;

    if(var_4) {
      wait 0.05;
      var_12 = randomfloatrange(0, 1);
      self setanimtime(var_8, var_12);
      var_11 = var_12 * var_9 + 0.05;
      var_4 = 0;
    }

    while(var_11 < var_9) {
      var_13 = var_5.wander_redirect_time * randomfloatrange(0.5, 1.5) / self.script_moveplaybackrate;

      if(var_11 + var_13 > var_9 - var_5.wander_redirect_time / 2) {
        var_13 = var_9 - var_11;
      }

      if(var_10 * var_13 > var_3) {
        var_13 = var_3 / (var_10 * 1.5);
      }

      var_14 = anglesToForward(self.angles);
      var_15 = self.origin + 0.5 * var_10 * var_14 * var_13;
      var_16 = var_2 - var_15;
      var_17 = length((var_16[0], var_16[1], 2 * var_16[2]));

      if(var_17 + var_10 * var_13 < var_3) {
        if(var_7 < var_3) {
          var_18 = randomfloatrange(-20, 20);
        }
        else {
          var_18 = randomfloatrange(-60, 60);
        }

        var_19 = randomfloatrange(-20, 20) - 0.5 * self.angles[0];
        maps\interactive_models\_interactive_utility::interactives_drawdebuglinefortime(self.origin, var_2, 0, 1, 0, var_13);
      } else {
        var_20 = anglestoright(self.angles);
        var_18 = randomfloatrange(60, 100);

        if(vectordot(var_16, var_14) > 0) {
          var_18 = var_18 - 60;

          if(var_7 < var_3) {
            var_18 = var_18 / 2;
          }
        }

        if(vectordot(var_16, var_20) > 0) {
          var_18 = var_18 * -1;
        }

        var_21 = var_3 / 2;

        if(var_16[2] < -1 * var_21) {
          var_19 = randomfloatrange(15, 30) - 0.5 * self.angles[0];
        }
        else if(var_16[2] > var_21) {
          var_19 = randomfloatrange(-30, -15) - 0.5 * self.angles[0];
        }
        else if(var_16[2] < -0.5 * var_21) {
          var_19 = randomfloatrange(0, 30) - 0.5 * self.angles[0];
        }
        else if(var_16[2] > 0.5 * var_21) {
          var_19 = randomfloatrange(-30, 0) - 0.5 * self.angles[0];
        }
        else {
          var_19 = randomfloatrange(-20, 20) - 0.5 * self.angles[0];
        }

        maps\interactive_models\_interactive_utility::interactives_drawdebuglinefortime(self.origin, var_2, 0.7, 0.7, 0, var_13);
      }

      clamp(var_19, -60 - self.angles[0], 60 - self.angles[0]);

      if(var_18 > 0) {
        self setanimlimitedrestart(var_5.anims["turn_left_child"], 1, 0);
        self setanim(var_5.anims["turn_left"], min(var_18 / 60, 1), 0);
      } else {
        self setanimlimitedrestart(var_5.anims["turn_right_child"], 1, 0, self.script_moveplaybackrate);
        self setanim(var_5.anims["turn_right"], min(var_18 / -60, 1), 0);
      }

      self rotateby((var_19, var_18, 0), 0.5 / self.script_moveplaybackrate, 0, 0.5 / self.script_moveplaybackrate);
      self.detect_people_trigger["interrupted"].origin = var_15 - (0, 0, 16);
      wait(var_13);
      var_11 = var_11 + var_13;
    }
  }
}

single_fish_flee(var_0, var_1) {
  self endon("death");
  var_2 = level._interactive[var_0];
  var_3 = randomint(var_1.size);
  self.nextorigin = var_1[var_3].origin;
  var_4 = var_1[var_3].script_radius;
  self waittill("interrupted");
  var_5 = undefined;

  if(isDefined(self.interruptedent)) {
    if(issentient(self.interruptedent)) {
      var_6 = self.interruptedent getEye();
    }
    else {
      var_6 = self.interruptedent.origin;
    }

    var_5 = vectornormalize(var_6 - self.origin);
  }

  thread single_fish_interruptfollowers();
  self.nextorigin = single_fish_getnextorigin();
  var_7 = self.nextorigin - self.origin;
  var_8 = vectornormalize(var_7);

  if(isDefined(var_5) && vectordot(var_5, var_8) > 0.7) {
    var_8 = var_5 + vectornormalize(var_8 - var_5);
  }

  var_9 = anglesToForward(self.angles);

  if(vectordot(var_8, var_9) > 0.7) {
    var_10 = "flee_straight";
  }
  else {
    var_11 = anglestoright(self.angles);

    if(vectordot(var_8, var_11) > 0) {
      var_10 = "flee_right";
    }
    else {
      var_10 = "flee_left";
    }
  }

  var_12 = vectortoangles(var_8);
  var_13 = randomfloatrange(0.8, 1.2);
  var_14 = maps\interactive_models\_interactive_utility::single_anim(var_2.anims, var_10, "flee anim", 1, self.script_moveplaybackrate * var_13);
  self rotateto(var_12, 0.2 / self.script_moveplaybackrate, 0, 0.2 / self.script_moveplaybackrate);
  var_15 = getanimlength(var_14) / (self.script_moveplaybackrate * var_13);
  var_15 = var_15 - 0.5;
  var_15 = var_15 - randomfloat(2);
  wait 0.5;

  while(var_15 > 0.3) {
    var_7 = self.nextorigin - self.origin;
    var_8 = vectornormalize(var_7);
    var_12 = vectortoangles(var_8);
    self rotateto(var_12, 1, 0.1, 0.3);
    wait 0.3;
    var_15 = var_15 - 0.3;
  }

  self waittillmatch("flee anim", "end");
  thread single_fish_idle(var_0, var_1, self.nextorigin, var_4);
}

single_fish_getnextorigin() {
  if(isDefined(self.following)) {
    return self.following single_fish_getnextorigin();
  }
  else {
    return self.nextorigin;
  }
}

single_fish_interruptfollowers() {
  self endon("death");
  wait(0.05 * randomint(3));

  if(isDefined(self.following)) {
    self.following.interruptedent = self.interruptedent;
    self.following notify("interrupted");
  }

  if(isDefined(self.followedby)) {
    var_0 = self.followedby.size;

    foreach(var_2 in self.followedby) {
      wait(0.05 * randomintrange(5, 10) / var_0);
      var_2.interruptedent = self.interruptedent;
      var_2 notify("interrupted");
    }
  }
}

single_fish_detectdamage(var_0) {
  self endon("death");
  self setCanDamage(1);

  for(;;) {
    self.health = 1000000;
    self waittill("damage");
    self notify(var_0);
  }
}

single_fish_savetostruct() {
  var_0 = spawnStruct();
  var_0.model = self.model;
  var_0.interactive_type = self.interactive_type;
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  var_0.target = self.target;
  var_0.targetname = self.targetname;
  var_0.script_noteworthy = self.script_noteworthy;
  var_0.script_radius = self.script_radius;
  self delete();
  return var_0;
}

single_fish_loadfromstruct() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel(self.model);
  var_0.interactive_type = self.interactive_type;
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  var_0.target = self.target;
  var_0.targetname = self.targetname;
  var_0.script_noteworthy = self.script_noteworthy;
  var_0.script_radius = self.script_radius;
  var_0 thread single_fish_start_after_frameend();
}

single_fish_start_after_frameend() {
  waittillframeend;
  single_fish_start();
}