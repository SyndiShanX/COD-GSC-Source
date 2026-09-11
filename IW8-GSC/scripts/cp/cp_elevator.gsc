/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_elevator.gsc
***********************************************/

function init_elevator() {
  init_elevator_animations();
  var_0 = getEntArray("lift_clip", "script_noteworthy");
  var_1 = getEnt("lift_model", "script_noteworthy");
  var_2 = getEnt("lift_doors", "script_noteworthy");

  if(isDefined(var_2)) {
    var_2 delete();
  }

  var_3 = getEntArray("lift_interaction", "script_noteworthy");
  var_4 = getEntArray("lift_floor", "script_noteworthy");
  var_5 = getEnt("lift_model_anim", "script_noteworthy");

  if(isDefined(var_5)) {
    var_5 delete();
  }

  var_1 setModel("lm_utility_elevator_02");
  var_1 useanimtree(level.scr_animtree["elevator"]);
  var_1.animname = "elevator";
  level.tower_elevator = var_1;
  var_6 = var_3[0];
  level.tower_elevator.interactions = [];

  foreach(var_8 in var_3) {
    var_8 setHintString(&"CP_STRIKE/DOOR_CLOSE");
    var_8 setCursorHint("HINT_BUTTON");
    var_8 sethintdisplayrange(300);
    var_8 sethintdisplayfov(65);
    var_8 setuserange(90);
    var_8 setusefov(65);
    var_8 sethintonobstruction("show");
    var_8 setuseholdduration("duration_medium");
    var_8 sethintrequiresholding(1);
    var_8 makeusable();
    var_8 linkTo(level.tower_elevator);
    level.tower_elevator.interactions = scripts\engine\utility::array_add(level.tower_elevator.interactions, var_8);
  }

  scripts\engine\utility::array_call(var_4, &solid);
  scripts\engine\utility::array_call(var_4, &linkto, level.tower_elevator);
  scripts\engine\utility::array_call(var_4, &delete);
  level.tower_elevator.clip = var_0;
  scripts\engine\utility::array_call(level.tower_elevator.clip, &solid);
  scripts\engine\utility::array_call(level.tower_elevator.clip, &linkto, level.tower_elevator);
  level.tower_elevator.state = 1;
  level.tower_elevator.current_floor = 0;
  level.tower_elevator.doors_opened = 1;
  level.tower_elevator.user_triggered = undefined;
  level.tower_elevator.locked = undefined;
  level.tower_elevator.locked_behind_interaction = undefined;
  scripts\engine\utility::array_thread(level.tower_elevator.interactions, &use_elevator, level.tower_elevator);
  level.tower_elevator.mover = spawn("script_model", level.tower_elevator.origin);
  level.tower_elevator.mover setModel("tag_origin");
  level.tower_elevator linkTo(level.tower_elevator.mover);
  level.tower_elevator thread scripts\common\anim::anim_single_solo(level.tower_elevator, "elevator_open");
  wait getanimlength(level.scr_anim["elevator"]["elevator_open"]);
}

function anim_check_loop() {
  for(;;) {
    scripts\common\anim::anim_single_solo(self, "elevator_open");
    wait getanimlength(level.scr_anim["elevator"]["elevator_open"]);
    scripts\common\anim::anim_single_solo(self, "elevator_close");
    wait getanimlength(level.scr_anim["elevator"]["elevator_close"]);
  }
}

function use_elevator(var_0) {
  self endon("death");
  self notify("use_elevator");
  self endon("use_elevator");

  for(;;) {
    self waittill("trigger", var_1);
    self playSound("scn_cp_elevator_button_press");

    if(!isPlayer(var_1)) {
      continue;
    }

    if(istrue(var_0.locked)) {
      var_1 iprintln("^2 Doors are locked ");
      continue;
    }

    if(istrue(var_0.locked_behind_interaction)) {
      var_1 iprintln("^2 Doors are locked; Activate the Switch to unlock the Elevator ");
      continue;
    }

    var_0.user_triggered = 1;

    if(!istrue(var_0.doors_opened)) {
      var_0 = change_state(var_0, 0);
      level.tower_elevator thread scripts\common\anim::anim_single_solo(level.tower_elevator, "elevator_open");
      self playSound("scn_cp_elevator_open");
      wait getanimlength(level.scr_anim["elevator"]["elevator_open"]);
      var_0 = change_state(var_0, 1);
      var_1 iprintln("^2 you opened the elevator! ");
      continue;
    }

    thread push_players_out_of_the_way();
    var_0 = change_state(var_0, 2);
    level.tower_elevator thread scripts\common\anim::anim_single_solo(level.tower_elevator, "elevator_close");
    self playSound("scn_cp_elevator_close");
    wait getanimlength(level.scr_anim["elevator"]["elevator_close"]);
    var_0 = change_state(var_0, 3);
  }
}

function change_state(var_0, var_1) {
  var_0.state = var_1;
  var_0 = set_properties_based_on_state(var_0, var_1, var_0);
  return var_0;
}

function set_properties_based_on_state(var_0, var_1) {
  if(!isDefined(var_0) || !isint(var_0) || var_0 < 0 || var_0 > 4) {
    return;
  }

  switch (var_0) {
    case 0:
      break;
    case 1:
      self.doors_opened = 1;
      self.user_triggered = undefined;
      self.locked = undefined;

      foreach(var_3 in var_1.interactions) {
        var_3 setHintString(&"CP_STRIKE/DOOR_CLOSE");
      }

      break;
    case 2:
      self.doors_opened = undefined;
      break;
    case 3:
      foreach(var_3 in var_1.interactions) {
        var_3 setHintString(&"CP_STRIKE/DOOR_OPEN");
      }

      if(istrue(self.user_triggered)) {
        var_1 = change_state(var_1, 4);
        var_1 = move_elevator(var_1);
      }

      break;
    case 4:
      self.locked = 1;
      break;
    default:
      break;
  }

  return var_1;
}

function push_players_out_of_the_way() {
  self notify("push_players_out_of_the_way");
  self endon("push_players_out_of_the_way");
}

function move_elevator() {
  var_0 = self;
  var_0 playSound("scn_cp_elevator_in_use_start");
  var_0 playLoopSound("scn_cp_elevator_in_use_lp");

  if(var_0.current_floor == 1) {
    var_0.mover moveTo(var_0.origin + (0, 0, -1448.01), 4);
  } else {
    var_0.mover moveTo(var_0.origin + (0, 0, 1448.01), 4);
  }

  wait 4;
  iprintln(" elevator travel done ");
  var_0 playSound("scn_cp_elevator_in_use_stop");
  var_0 stoploopsound("scn_cp_elevator_in_use_lp");

  if(var_0.current_floor == 1) {
    var_0.current_floor = 0;
  } else {
    var_0.current_floor = 1;
  }

  var_0 = change_state(var_0, 0);
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "elevator_open");
  var_0 playSound("scn_cp_elevator_open");
  wait getanimlength(level.scr_anim["elevator"]["elevator_open"]);
  var_0 = change_state(var_0, 1);
  return var_0;
}

#using_animtree("");

function init_elevator_animations() {
  level.scr_animtree["elevator"] = #animtree;
  level.scr_model["elevator"] = "lm_utility_elevator_02";
  level.scr_anim["elevator"]["elevator_open"] = $cp_prop_elevatordoor_open;
  level.scr_animname["elevator"]["elevator_open"] = "cp_prop_elevatordoor_open";
  level.scr_anim["elevator"]["elevator_close"] = % cp_prop_elevatordoor_close;
  level.scr_animname["elevator"]["elevator_close"] = "cp_prop_elevatordoor_close";
}