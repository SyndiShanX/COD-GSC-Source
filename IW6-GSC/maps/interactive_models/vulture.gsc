/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\interactive_models\vulture.gsc
***********************************************/

#using_animtree("animals");

main() {
  var_0 = spawnStruct();
  var_0.interactive_type = "vulture";
  var_0.react_distance = 700;
  var_0.fly_distance = 350;
  var_0.damage_effect = loadfx("fx/props/feathers_black_exp");
  var_0.death_effect = loadfx("fx/props/vulture_exp");
  var_0.health = 100;
  var_0.anims = [];
  var_0.anims["fly_away"] = % vulture_fly_away;
  var_0.anims["fly_loop"][0] = % vulture_fly_loop;
  var_0.anims["fly_loopweight"][0] = 1;
  var_0.anims["fly_loop"][1] = % vulture_fly_loop2;
  var_0.anims["fly_loopweight"][1] = 0.3;
  var_0.anims["fly_loop"][2] = % vulture_fly_loop3;
  var_0.anims["fly_loopweight"][2] = 0.3;
  var_0.anims["idle"] = % vulture_idle;
  var_0.anims["idle_body"] = % vulture_idle_body;
  var_0.anims["idle_body_pose"] = % vulture_idle_body_pose;
  var_0.anims["react"] = % vulture_twitch;
  var_0.circle_radius = 350;
  var_0.circle_time = 250;
  var_0.circle_large_variance_amt = 150;
  var_0.circle_large_variance_time = 250;
  var_0.savetostructfn = ::vulture_savetostruct;
  var_0.loadfromstructfn = ::vulture_loadfromstruct;

  if(!isDefined(level._interactive)) {
    level._interactive = [];
  }

  level._interactive[var_0.interactive_type] = var_0;
  thread vultures();
}

vultures() {
  level waittill("load_finished");

  if(!isDefined(level._interactive["vultures_setup"])) {
    level._interactive["vultures_setup"] = 1;
    var_0 = getEntArray("interactive_vulture", "targetname");

    foreach(var_2 in var_0) {
    var_2 thread vulture_waitforstart();
    }

    var_0 = getEntArray("interactive_vulture_circling", "targetname");

    foreach(var_2 in var_0) {
    var_2 thread vulture_waitforstart();
    }
  }
}

vulture_waitforstart() {
  if(isDefined(self.script_triggername)) {
    var_0 = vulture_savetostruct();
    level waittill("start_" + self.script_triggername);
    var_0 vulture_loadfromstruct();
  } else if(self.targetname == "interactive_vulture")
    thread vulture();
  else if(self.targetname == "interactive_vulture_circling") {
    thread vulture_circle(1);
  }
}

vulture() {
  self endon("death");
  self useanimtree(#animtree);
  var_0 = level._interactive["vulture"];
  var_1 = undefined;

  if(isDefined(self.target)) {
    var_1 = getent(self.target, "targetname");
  }

  if(isDefined(var_1)) {
    var_1 useanimtree(#animtree);
    var_2 = var_1.origin;
    var_3 = var_1.angles;
  } else {
    var_2 = self.origin;
    var_3 = self.angles;
  }

  thread maps\interactive_models\_interactive_utility::detect_events("interrupted");
  thread maps\interactive_models\_interactive_utility::detect_people(var_0.react_distance, "interrupted", ["death", "damage"]);
  thread maps\interactive_models\_interactive_utility::detect_people(var_0.fly_distance, "damage", ["death", "damage"]);
  thread vulture_detect_damage(var_0.health, var_0.damage_effect, var_0.death_effect, var_1, var_0.anims["idle_body_pose"]);

  if(isDefined(self.script_triggername)) {
    thread vulture_waitfortriggerstop();
  }

  var_4 = 1;
  self.interrupted = 0;
  var_5 = "";

  while(var_5 != "damage") {
    if(var_5 == "interrupted" || self.interrupted) {
      thread vulture_react(var_1, var_0.anims, var_2, var_3);
      var_5 = common_scripts\utility::waittill_any_return("damage", "finished_react");
      self notify("stop_idle");
      continue;
    }

    thread vulture_idle(var_1, var_0.anims, var_2, var_3);
    var_5 = common_scripts\utility::waittill_any_return("interrupted", "damage", "finished_react");
    self notify("stop_idle");
  }

  self animscripted("fly_anim", var_2, var_3, var_0.anims["fly_away"]);

  if(isDefined(var_1)) {
    var_1 setanimknobrestart(var_0.anims["idle_body_pose"], 1, 0.2);
  }

  self waittillmatch("fly_anim", "end");
  thread vulture_circle();
}

vulture_circle(var_0) {
  self endon("death");

  if(isDefined(self.script_triggername)) {
    thread vulture_waitfortriggerstop();
  }

  self useanimtree(#animtree);
  var_1 = level._interactive["vulture"];
  thread vulture_detect_damage(var_1.health, var_1.damage_effect, var_1.death_effect);
  self.angles = (0, self.angles[1], self.angles[2]);

  if(isDefined(var_0) && var_0) {
    var_2 = self.origin;
  }
  else {
    var_3 = anglestoright(self.angles);
    var_2 = self.origin - var_3 * var_1.circle_radius;
  }

  if(isDefined(self.script_radius)) {
    var_4 = var_2 + (0, 0, self.script_radius);
    var_5 = common_scripts\_csplines::cspline_initnoise(var_4, self.script_radius, var_1.circle_large_variance_time, var_2);
  } else {
    var_4 = var_2 + (0, 0, var_1.circle_large_variance_amt);
    var_5 = common_scripts\_csplines::cspline_initnoise(var_4, var_1.circle_large_variance_amt, var_1.circle_large_variance_time, var_2);
  }

  var_6 = self.angles[1] - 90;
  var_7 = 0;
  self stopanimscripted();
  thread maps\interactive_models\_interactive_utility::loop_anim(var_1.anims, "fly_loop");

  for(;;) {
    var_8 = common_scripts\_csplines::cspline_noise(var_5, var_7);
    self.origin = maps\interactive_models\_interactive_utility::pointoncircle(var_8, var_1.circle_radius, var_6);
    self.angles = (0, var_6 + 90, -5);
    var_6 = var_6 + 360 / var_1.circle_time;
    var_7++;
    wait 0.05;
  }
}

vulture_detect_damage(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(self.health) || self.health == 0) {
    self.health = var_0;
  }

  self setCanDamage(1);

  for(;;) {
    self waittill("damage");

    if(isDefined(self)) {
      if(self.health > 0) {
        if(isDefined(var_1)) {
          playFX(var_1, self.origin + (0, 0, 15));
        }
      } else {
        playFX(var_2, self.origin + (0, 0, 15));

        if(isDefined(var_3)) {
          var_3 setanimknobrestart(var_4, 1, 0.2);
        }

        self delete();
      }

      continue;
    }

    break;
  }
}

vulture_idle(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("stop_idle");

  for(;;) {
    self animscripted("idle_anim", var_2, var_3, var_1["idle"]);

    if(isDefined(var_0)) {
      var_0 setanimknobrestart(var_1["idle_body"], 1);
    }

    self waittillmatch("idle_anim", "end");
  }
}

vulture_react(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("stop_idle");
  self animscripted("react_anim", var_2, var_3, var_1["react"]);

  if(isDefined(var_0)) {
    var_0 setanimknobrestart(var_1["idle_body_pose"], 1, 0.2);
  }

  self waittillmatch("react_anim", "end");
  self notify("finished_react");
}

vulture_waitfortriggerstop() {
  self endon("death");
  level waittill("stop_" + self.script_triggername);
  thread vulture_savetostructandwaitfortriggerstart();
}

vulture_savetostructandwaitfortriggerstart() {
  var_0 = vulture_savetostruct();
  level waittill("start_" + self.script_triggername);
  var_0 vulture_loadfromstruct();
}

vulture_deletewithbody() {
  if(isDefined(self.target)) {
    var_0 = getent(self.target, "targetname");

    if(isDefined(var_0)) {
      var_0 delete();
    }
  }

  self delete();
}

vulture_savetostruct() {
  var_0 = spawnStruct();
  var_0.model = self.model;
  var_0.interactive_type = self.interactive_type;
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  var_0.targetname = self.targetname;
  var_0.target = self.target;

  if(isDefined(self.target)) {
    var_1 = getent(self.target, "targetname");

    if(isDefined(var_1)) {
      var_0.body = spawnStruct();
      var_0.body.origin = var_1.origin;
      var_0.body.angles = var_1.angles;
      var_0.body.model = var_1.model;
      var_1 delete();
    }
  }

  var_0.script_noteworthy = self.script_noteworthy;
  var_0.script_triggername = self.script_triggername;
  var_0.script_radius = self.script_radius;
  self delete();
  return var_0;
}

vulture_loadfromstruct() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel(self.model);
  var_0.interactive_type = self.interactive_type;
  var_0.origin = self.origin;
  var_0.angles = self.angles;
  var_0.target = self.target;
  var_0.targetname = self.targetname;

  if(isDefined(self.body)) {
    var_1 = spawn("script_model", self.body.origin);
    var_1 setModel(self.body.model);
    var_1.angles = self.body.angles;
    var_1.targetname = self.target;
  }

  var_0.script_noteworthy = self.script_noteworthy;
  var_0.script_triggername = self.script_triggername;
  var_0.script_radius = self.script_radius;

  if(var_0.targetname == "interactive_vulture") {
    var_0 thread vulture();
  }
  else if(var_0.targetname == "interactive_vulture_circling") {
    var_0 thread vulture_circle(1);
  }
}