/********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_waterfall.gsc
********************************************************/

init_waterfall_trap() {
  var_00 = scripts\engine\utility::getstruct("trap_waterfall", "script_noteworthy");
  var_01 = getEntArray(var_00.target, "targetname");
  foreach(var_03 in var_01) {
    if(var_03.classname == "script_model") {
      var_00.valve = var_03;
    }

    if(var_03.classname == "physicsvolume") {
      var_00.physvolume = var_03;
    }

    if(var_03.classname == "trigger_multiple") {
      var_00.trigger = var_03;
    }
  }
}

use_waterfall_trap(param_00, param_01) {
  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  param_00.trap_kills = 0;
  param_00.valve rotateroll(-180, 1);
  param_00.valve playSound("trap_waterfall_valve");
  thread waterfall_trap_sfx();
  var_02 = gettime() + 2000;
  playrumbleonposition("light_3s", param_00.valve.origin + (0, 0, 50));
  while(gettime() < var_02) {
    earthquake(0.2, 2, param_00.origin + (0, 0, 100), 500);
    wait(1);
  }

  scripts\engine\utility::exploder(20);
  param_00.physvolume physics_volumesetasdirectionalforce(1, anglesToForward(param_00.angles + (0, 0, 5)), 2500);
  param_00.physvolume physics_volumesetactivator(1);
  param_00.physvolume physics_volumeenable(1);
  level thread kill_zombies(param_00, param_01);
  var_02 = gettime() + 25000;
  while(gettime() < var_02) {
    playrumbleonposition("heavy_3s", param_00.valve.origin + (0, 0, 50));
    earthquake(0.2, 3, param_00.origin + (0, 0, 100), 500);
    wait(1);
  }

  level notify("stop_waterfall_trap");
  level notify("waterfall_trap_kills", param_00.trap_kills);
  param_00.physvolume physics_volumeenable(0);
  param_00.physvolume physics_volumesetactivator(0);
  scripts\cp\cp_interaction::enable_linked_interactions(param_00);
  param_00.cooling_down = 1;
  wait(30);
  param_00.cooling_down = undefined;
}

waterfall_trap_sfx() {
  wait(0.65);
  playsoundatpos((-1714, -2031, 248), "trap_waterfall_start");
  var_00 = scripts\engine\utility::play_loopsound_in_space("trap_waterfall_rushing_lp", (-1717, -2013, 189));
  wait(4);
  var_01 = scripts\engine\utility::play_loopsound_in_space("trap_waterfall_splashing_lp", (-1702, -1824, 101));
  level waittill("stop_waterfall_trap");
  playsoundatpos((-1714, -2031, 248), "trap_waterfall_end");
  wait(0.2);
  var_00 stoploopsound();
  var_00 delete();
  var_01 stoploopsound();
  var_01 delete();
}

kill_zombies(param_00, param_01) {
  level endon("stop_waterfall_trap");
  for(;;) {
    param_00.trigger waittill("trigger", var_02);
    if(isplayer(var_02)) {
      var_03 = var_02 getvelocity();
      var_02 setvelocity(var_03 + (0, 35, 0));
      continue;
    }

    if(!scripts\cp\utility::should_be_affected_by_trap(var_02, undefined, 1)) {
      continue;
    }

    param_00.trap_kills++;
    var_02 thread fling_zombie(param_00, param_01);
  }
}

fling_zombie(param_00, param_01) {
  self endon("death");
  self.flung = 1;
  self.marked_for_death = 1;
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  wait(randomfloatrange(0.5, 1.5));
  if(param_01 scripts\cp\utility::is_valid_player()) {
    var_02 = param_01;
  } else {
    var_02 = undefined;
  }

  self dodamage(self.health + 100, param_00.trigger.origin, var_02, var_02, "MOD_UNKNOWN", "iw7_discotrap_zm");
}