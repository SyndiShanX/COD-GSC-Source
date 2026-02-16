/*************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\interaction_rave_openareas.gsc
*************************************************************/

init_all_debris_and_door_positions() {
  func_F945("debris_350");
  func_F945("debris_1000");
  func_F945("debris_1500");
  func_F945("debris_2000");
  func_F945("debris_1250");
  func_F945("debris_750");
}

func_F945(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  foreach(var_3 in var_1) {
    set_nonstick(var_3);
  }
}

set_nonstick(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");
  foreach(var_3 in var_1) {
    var_3 setnonstick(1);
    wait(0.1);
  }
}

init_sliding_power_doors() {
  var_0 = scripts\engine\utility::getStructArray("power_door_sliding", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread sliding_power_door();
  }
}

sliding_power_door() {
  if(scripts\engine\utility::istrue(self.requires_power)) {
    level scripts\engine\utility::waittill_any("power_on", self.power_area + " power_on");
  }

  self.powered_on = 1;
  if(isDefined(self.script_sound)) {
    playsoundatpos(self.origin, self.script_sound);
  }

  var_0 = getEntArray(self.target, "targetname");
  foreach(var_2 in var_0) {
    if(isDefined(var_2.moved)) {
      continue;
    }

    if(var_2.classname == "script_brushmodel") {
      var_2.moved = 1;
      var_2 connectpaths();
      var_2 notsolid();
    }

    if(var_2.classname == "script_model") {
      var_2.moved = 1;
      var_2 moveto(var_2.origin + var_2.script_angles, 0.5);
    }
  }

  scripts\cp\cp_interaction::disable_linked_interactions(self);
  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(self);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(self.script_area);
}