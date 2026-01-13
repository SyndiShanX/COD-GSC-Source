/********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_waterfall.gsc
********************************************************/

init_waterfall_trap() {
  var_0 = scripts\engine\utility::getstruct("trap_waterfall", "script_noteworthy");
  var_1 = getEntArray(var_0.target, "targetname");
  foreach(var_3 in var_1) {
    if(var_3.classname == "script_model") {
      var_0.valve = var_3;
    }

    if(var_3.classname == "physicsvolume") {
      var_0.physvolume = var_3;
    }

    if(var_3.classname == "trigger_multiple") {
      var_0.trigger = var_3;
    }
  }
}

use_waterfall_trap(var_0, var_1) {
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  var_0.trap_kills = 0;
  var_0.valve rotateroll(-180, 1);
  var_0.valve playSound("trap_waterfall_valve");
  thread waterfall_trap_sfx();
  var_2 = gettime() + 2000;
  playrumbleonposition("light_3s", var_0.valve.origin + (0, 0, 50));
  while(gettime() < var_2) {
    earthquake(0.2, 2, var_0.origin + (0, 0, 100), 500);
    wait(1);
  }

  scripts\engine\utility::exploder(20);
  var_0.physvolume physics_volumesetasdirectionalforce(1, anglesToForward(var_0.angles + (0, 0, 5)), 2500);
  var_0.physvolume physics_volumesetactivator(1);
  var_0.physvolume physics_volumeenable(1);
  level thread kill_zombies(var_0, var_1);
  var_2 = gettime() + 25000;
  while(gettime() < var_2) {
    playrumbleonposition("heavy_3s", var_0.valve.origin + (0, 0, 50));
    earthquake(0.2, 3, var_0.origin + (0, 0, 100), 500);
    wait(1);
  }

  level notify("stop_waterfall_trap");
  level notify("waterfall_trap_kills", var_0.trap_kills);
  var_0.physvolume physics_volumeenable(0);
  var_0.physvolume physics_volumesetactivator(0);
  scripts\cp\cp_interaction::enable_linked_interactions(var_0);
  var_0.cooling_down = 1;
  wait(30);
  var_0.cooling_down = undefined;
}

waterfall_trap_sfx() {
  wait(0.65);
  playsoundatpos((-1714, -2031, 248), "trap_waterfall_start");
  var_0 = scripts\engine\utility::play_loopsound_in_space("trap_waterfall_rushing_lp", (-1717, -2013, 189));
  wait(4);
  var_1 = scripts\engine\utility::play_loopsound_in_space("trap_waterfall_splashing_lp", (-1702, -1824, 101));
  level waittill("stop_waterfall_trap");
  playsoundatpos((-1714, -2031, 248), "trap_waterfall_end");
  wait(0.2);
  var_0 stoploopsound();
  var_0 delete();
  var_1 stoploopsound();
  var_1 delete();
}

kill_zombies(var_0, var_1) {
  level endon("stop_waterfall_trap");
  for(;;) {
    var_0.trigger waittill("trigger", var_2);
    if(isplayer(var_2)) {
      var_3 = var_2 getvelocity();
      var_2 setvelocity(var_3 + (0, 35, 0));
      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_2, undefined, 1)) {
      continue;
    }

    var_0.trap_kills++;
    var_2 thread fling_zombie(var_0, var_1);
  }
}

fling_zombie(var_0, var_1) {
  self endon("death");
  self.flung = 1;
  self.marked_for_death = 1;
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  wait(randomfloatrange(0.5, 1.5));
  if(var_1 scripts\cp\utility::is_valid_player()) {
    var_2 = var_1;
  } else {
    var_2 = undefined;
  }

  self dodamage(self.health + 100, var_0.trigger.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_discotrap_zm");
}