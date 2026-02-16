/************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\cp_rave_doors.gsc
************************************************/

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

func_102F3(var_0, var_1) {
  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(var_0);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_0.script_area);
  playsoundatpos(var_0.origin, "zmb_sliding_door_open");
  var_2 = getEntArray(var_0.target, "targetname");
  foreach(var_4 in var_2) {
    var_4 connectpaths();
    var_5 = scripts\engine\utility::getstruct(var_4.target, "targetname");
    var_4 moveto(var_5.origin, 1);
  }

  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  if(level.players.size > 1) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
    return;
  }

  level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 1, 1, 40);
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
  playsoundatpos(self.origin, "zmb_sliding_door_open");
  var_0 = getEntArray(self.target, "targetname");
  foreach(var_2 in var_0) {
    var_2 connectpaths();
    var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    var_2 moveto(var_3.origin, 1);
  }

  scripts\cp\cp_interaction::disable_linked_interactions(self);
  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(self);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(self.script_area);
}

func_8FDE(var_0, var_1) {
  playsoundatpos(var_0.origin, "zmb_gate_open");
  var_2 = getent(var_0.target, "targetname");
  var_2 rotateyaw(160, 1);
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
}

clear_debris(var_0, var_1) {
  scripts\engine\utility::flag_set("can_drop_coins");
  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  if(isPlayer(var_1)) {
    playsoundatpos((var_0.origin[0], var_0.origin[1], var_1.origin[2] + 40), "rave_doorbuy_med");
    var_1 playlocalsound("purchase_generic");
  } else {
    playsoundatpos(var_0.origin, "rave_doorbuy_med");
  }

  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(var_0);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_0.script_area);
  var_2 = getEntArray(var_0.target, "targetname");
  foreach(var_4 in var_2) {
    if(var_4.classname == "script_brushmodel") {
      var_4 connectpaths();
      var_4 notsolid();
      continue;
    }

    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "rave_objects") {
      if(isDefined(var_4.spawnedfx)) {
        foreach(var_6 in var_4.spawnedfx) {
          var_6 delete();
        }
      }

      var_4 delete();
      continue;
    }

    var_4 setscriptablepartstate("default", "hide");
  }

  if(isDefined(level.purchase_area_vo)) {
    thread[[level.purchase_area_vo]](var_0.script_area, var_1);
  }
}

rave_trap_door() {
  level thread init_rave_door_buys();
  level waittill("activate_power");
  var_0 = getent("trap_door_clip", "targetname");
  var_1 = getent("cellar_door", "targetname");
  var_2 = getent("cellar_door_rope", "targetname");
  var_3 = scripts\engine\utility::getstruct("trap_door_struct_1", "targetname");
  var_4 = scripts\engine\utility::getstruct("trap_door_struct_2", "targetname");
  var_1 connectpaths();
  var_1 playSound("powerdoor_cellar");
  var_1 rotatepitch(92, 1);
  wait(1);
  var_2 delete();
  var_0 connectpaths();
  var_0 notsolid();
  scripts\cp\zombies\zombies_spawning::func_1751(var_3, var_4);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name("attic_space");
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name("front_gate");
}

init_rave_door_buys() {
  var_0 = getEntArray("rave_door_buy", "targetname");
  foreach(var_2 in var_0) {
    var_2 thread rave_door_buy();
  }
}

show_fail_hint() {
  self endon("disconnect");
  self forceusehinton(&"COOP_INTERACTIONS_NEED_MONEY");
  wait(1);
  self getrigindexfromarchetyperef();
}

rave_door_buy() {
  self sethintstring(&"CP_RAVE_PURCHASE_AREA");
  self sethintstringparams(level.enter_area_hint, 350);
  for(;;) {
    self waittill("trigger", var_0);
    if(!var_0 scripts\cp\cp_persistence::player_has_enough_currency(350, "door_buy")) {
      var_0 playlocalsound("purchase_deny");
      var_0 thread show_fail_hint();
      continue;
    }

    playFX(level._effect["vfx_rave_doorbuy"], (self.origin[0], self.origin[1], var_0.origin[2]));
    break;
  }

  var_1 = getEntArray(self.target, "targetname");
  foreach(var_3 in var_1) {
    if(!isDefined(var_3.script_noteworthy)) {
      var_3 connectpaths();
      var_3 notsolid();
      continue;
    }

    var_3 delete();
  }

  var_5 = scripts\engine\utility::getStructArray(self.target, "targetname");
  scripts\cp\zombies\zombies_spawning::func_1751(var_5[0], var_5[1]);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_5[0].script_area);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_5[1].script_area);
  self delete();
  var_0 scripts\cp\cp_persistence::take_player_currency(350, 1, "door_buy");
  wait(0.05);
  var_0 playlocalsound("purchase_generic");
  var_0 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area_rave", "rave_comment_vo");
}