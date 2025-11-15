/************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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

func_F945(param_00) {
  var_01 = scripts\engine\utility::getstructarray(param_00, "script_noteworthy");
  foreach(var_03 in var_01) {
    set_nonstick(var_03);
  }
}

set_nonstick(param_00) {
  var_01 = getEntArray(param_00.target, "targetname");
  foreach(var_03 in var_01) {
    var_03 setnonstick(1);
    wait(0.1);
  }
}

func_102F3(param_00, param_01) {
  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(param_00);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(param_00.script_area);
  playsoundatpos(param_00.origin, "zmb_sliding_door_open");
  var_02 = getEntArray(param_00.target, "targetname");
  foreach(var_04 in var_02) {
    var_04 connectpaths();
    var_05 = scripts\engine\utility::getstruct(var_04.target, "targetname");
    var_04 moveto(var_05.origin, 1);
  }

  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  if(level.players.size > 1) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
    return;
  }

  level.players[0] thread scripts\cp\cp_vo::try_to_play_vo("purchase_area", "zmb_comment_vo", "low", 10, 0, 1, 1, 40);
}

init_sliding_power_doors() {
  var_00 = scripts\engine\utility::getstructarray("power_door_sliding", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_02 thread sliding_power_door();
  }
}

sliding_power_door() {
  if(scripts\engine\utility::istrue(self.requires_power)) {
    level scripts\engine\utility::waittill_any_3("power_on", self.power_area + " power_on");
  }

  self.powered_on = 1;
  playsoundatpos(self.origin, "zmb_sliding_door_open");
  var_00 = getEntArray(self.target, "targetname");
  foreach(var_02 in var_00) {
    var_02 connectpaths();
    var_03 = scripts\engine\utility::getstruct(var_02.target, "targetname");
    var_02 moveto(var_03.origin, 1);
  }

  scripts\cp\cp_interaction::disable_linked_interactions(self);
  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(self);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(self.script_area);
}

func_8FDE(param_00, param_01) {
  playsoundatpos(param_00.origin, "zmb_gate_open");
  var_02 = getent(param_00.target, "targetname");
  var_02 rotateyaw(160, 1);
  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
}

clear_debris(param_00, param_01) {
  scripts\engine\utility::flag_set("can_drop_coins");
  scripts\cp\cp_interaction::disable_linked_interactions(param_00);
  if(isplayer(param_01)) {
    playsoundatpos((param_00.origin[0], param_00.origin[1], param_01.origin[2] + 40), "rave_doorbuy_med");
    param_01 playlocalsound("purchase_generic");
  } else {
    playsoundatpos(param_00.origin, "rave_doorbuy_med");
  }

  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(param_00);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(param_00.script_area);
  var_02 = getEntArray(param_00.target, "targetname");
  foreach(var_04 in var_02) {
    if(var_04.classname == "script_brushmodel") {
      var_04 connectpaths();
      var_04 notsolid();
      continue;
    }

    if(isDefined(var_04.script_noteworthy) && var_04.script_noteworthy == "rave_objects") {
      if(isDefined(var_04.spawnedfx)) {
        foreach(var_06 in var_04.spawnedfx) {
          var_06 delete();
        }
      }

      var_04 delete();
      continue;
    }

    var_04 setscriptablepartstate("default", "hide");
  }

  if(isDefined(level.purchase_area_vo)) {
    thread[[level.purchase_area_vo]](param_00.script_area, param_01);
  }
}

rave_trap_door() {
  level thread init_rave_door_buys();
  level waittill("activate_power");
  var_00 = getent("trap_door_clip", "targetname");
  var_01 = getent("cellar_door", "targetname");
  var_02 = getent("cellar_door_rope", "targetname");
  var_03 = scripts\engine\utility::getstruct("trap_door_struct_1", "targetname");
  var_04 = scripts\engine\utility::getstruct("trap_door_struct_2", "targetname");
  var_01 connectpaths();
  var_01 playSound("powerdoor_cellar");
  var_01 rotatepitch(92, 1);
  wait(1);
  var_02 delete();
  var_00 connectpaths();
  var_00 notsolid();
  scripts\cp\zombies\zombies_spawning::func_1751(var_03, var_04);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name("attic_space");
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name("front_gate");
}

init_rave_door_buys() {
  var_00 = getEntArray("rave_door_buy", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread rave_door_buy();
  }
}

show_fail_hint() {
  self endon("disconnect");
  self forceusehinton( & "COOP_INTERACTIONS_NEED_MONEY");
  wait(1);
  self getrigindexfromarchetyperef();
}

rave_door_buy() {
  self sethintstring( & "CP_RAVE_PURCHASE_AREA");
  self sethintstringparams(level.enter_area_hint, 350);
  for(;;) {
    self waittill("trigger", var_00);
    if(!var_00 scripts\cp\cp_persistence::player_has_enough_currency(350, "door_buy")) {
      var_00 playlocalsound("purchase_deny");
      var_00 thread show_fail_hint();
      continue;
    }

    playFX(level._effect["vfx_rave_doorbuy"], (self.origin[0], self.origin[1], var_00.origin[2]));
    break;
  }

  var_01 = getEntArray(self.target, "targetname");
  foreach(var_03 in var_01) {
    if(!isDefined(var_03.script_noteworthy)) {
      var_03 connectpaths();
      var_03 notsolid();
      continue;
    }

    var_03 delete();
  }

  var_05 = scripts\engine\utility::getstructarray(self.target, "targetname");
  scripts\cp\zombies\zombies_spawning::func_1751(var_05[0], var_05[1]);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_05[0].script_area);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(var_05[1].script_area);
  self delete();
  var_00 scripts\cp\cp_persistence::take_player_currency(350, 1, "door_buy");
  wait(0.05);
  var_00 playlocalsound("purchase_generic");
  var_00 thread scripts\cp\cp_vo::try_to_play_vo("purchase_area_rave", "rave_comment_vo");
}