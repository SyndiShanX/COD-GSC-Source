/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1abf3c209bb616b2.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#namespace stealth_alarm;

function init() {
  level.var_9a798a88 = spawnStruct();
  level.var_9a798a88.alarms = struct::get_array("stealth_alarm", "script_noteworthy");
  level.g_effect[#"alarm_red"] = "vfx/iw7/levels/europa/vfx_eu_bfg_light_redblink.vfx";
  level.g_effect[#"alarm_idle"] = "vfx/core/vehicles/aircraft_light_white_blink.vfx";
  array::thread_all(level.var_9a798a88.alarms, &function_a8f7fa5b);
}

function function_ea8a5678(targetname, func) {
  foreach(alarm in level.var_9a798a88.alarms) {
    if(isDefined(alarm.targetname) && alarm.targetname == targetname) {
      alarm.on_func = func;
    }
  }
}

function function_a8f7fa5b() {
  ents = struct::get_array(self.script_linkto, "script_linkname");
  self.lights = [];
  self.trigs = [];
  self.active = 1;
  self.state = "idle";

  foreach(ent in ents) {
    if(!isDefined(ent.script_noteworthy)) {
      continue;
    }

    switch (ent.script_noteworthy) {
      case # "trigger_disable":
        self.trigs[#"hack"] = ent;
        self thread function_2dc6261d();
        break;
      case # "trigger_damage":
        self.trigs[#"dmg"] = ent;
        self thread function_47de2d14();
        break;
      case # "light":
        self.lights[self.lights.size] = ent;
        self.var_bb4a3b9 = ent.model;
        ent.idle_fx = spawnfx(level.g_effect[#"alarm_idle"], ent.origin);
        triggerfx(ent.idle_fx);

        if(isDefined(ent.script_wtf)) {
          self.var_c0effb5a = ent.script_wtf;
        }

        break;
      default:
        break;
    }
  }

  self thread function_7e4779a4();
}

function function_2dc6261d() {
  self endon(#"death");
  self.trigs[#"hack"] endon(#"death");
  waitresult = self.trigs[#"hack"] waittill(#"trigger");
  whom = waitresult.activator;
  self notify(#"state_change", {
    #state: "disabled"});

  if(soundexists(#"fuse_switch")) {
    playsoundatposition(#"fuse_switch", getplayers()[0].origin);
  }
}

function function_47de2d14() {
  self endon(#"death");
  self.trigs[#"dmg"] endon(#"death");
  waitresult = self.trigs[#"dmg"] waittill(#"trigger");
  whom = waitresult.activator;
  self notify(#"state_change", {
    #state: "destroyed"});
}

function function_7e4779a4() {
  self endon(#"death");

  while(true) {
    waitresult = self waittill(#"state_change");
    state = waitresult.state;
    self notify(state);

    switch (state) {
      case # "disabled":
        if(self.state == "alarm_on") {
          self thread function_fc2bc4ba();
        }

        function_bb67aeb1();
        self.state = state;
        self.active = 0;
        self.trigs[#"hack"] delete();
        break;
      case # "destroyed":
        if(self.state == "alarm_on") {
          self thread function_fc2bc4ba();
        }

        function_bb67aeb1();
        self.state = state;
        self.active = 0;
        self.trigs[#"hack"] delete();
        break;
      case # "alarm_on":
        if(self.state == "alarm_on") {
          break;
        }

        self.state = state;
        self thread alarm_on();
        break;
      case # "idle":
        if(self.state == "idle") {
          break;
        }

        self.state = state;
        self thread function_fc2bc4ba();
        break;
      default:

        iprintln("<dev string:x38>" + state);

        break;
    }
  }
}

function function_bb67aeb1() {
  foreach(light in self.lights) {
    if(isDefined(light.idle_fx)) {
      light.idle_fx delete();
    }
  }
}

function alarm_on() {
  if(!self.active) {
    return;
  }

  foreach(light in self.lights) {
    light.idle_fx delete();

    if(isDefined(self.var_c0effb5a)) {
      light setModel(self.var_c0effb5a);
    }

    light.var_5131ddae = spawnfx(level.g_effect[#"alarm_red"], light.origin);
    triggerfx(light.var_5131ddae);
  }

  if(isDefined(self.on_func)) {
    self thread[[self.on_func]]();
  }
}

function function_fc2bc4ba() {
  foreach(light in self.lights) {
    if(isDefined(self.var_bb4a3b9)) {
      light setModel(self.var_bb4a3b9);
    }

    if(isDefined(light.var_5131ddae)) {
      light.var_5131ddae delete();
    }
  }
}

function function_f8788a08(alarm) {
  if(!alarm.active) {
    return;
  }

  self endon(#"death");
  self.og_goalradius = self.goalradius;
  self namespace_979752dc::set_goal_radius(32);
  self namespace_979752dc::set_goal(alarm);
  self waittill(#"goal");
  self orientmode("face angle", alarm.angles[1]);
  wait 1.5;
  alarm notify(#"state_change", {
    #state: "alarm_on"
  });
  self namespace_979752dc::set_goal_radius(self.og_goalradius);
}