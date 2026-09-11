/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_elevator.gsc
***********************************************/

function init_elevator() {
  init_elevator_animations();
  var0 = getEntArray("lift_clip", "script_noteworthy");
  var1 = getEnt("lift_model", "script_noteworthy");
  var2 = getEnt("lift_doors", "script_noteworthy");

  if(isDefined(var2)) {
    var2 delete();
  }

  var3 = getEntArray("lift_interaction", "script_noteworthy");
  var4 = getEntArray("lift_floor", "script_noteworthy");
  var5 = getEnt("lift_model_anim", "script_noteworthy");

  if(isDefined(var5)) {
    var5 delete();
  }

  var1 setModel("lm_utility_elevator_02");
  var1 useanimtree(level.scr_animtree["elevator"]);
  var1.animname = "elevator";
  level.tower_elevator = var1;
  var6 = var3[0];
  level.tower_elevator.interactions = [];

  foreach(var8 in var3) {
    var8 setHintString(&"CP_STRIKE/DOOR_CLOSE");
    var8 setCursorHint("HINT_BUTTON");
    var8 sethintdisplayrange(300);
    var8 sethintdisplayfov(65);
    var8 setuserange(90);
    var8 setusefov(65);
    var8 sethintonobstruction("show");
    var8 setuseholdduration("duration_medium");
    var8 sethintrequiresholding(1);
    var8 makeusable();
    var8 linkTo(level.tower_elevator);
    level.tower_elevator.interactions = scripts\engine\utility::array_add(level.tower_elevator.interactions, var8);
  }

  scripts\engine\utility::array_call(var4, &solid);
  scripts\engine\utility::array_call(var4, &linkto, level.tower_elevator);
  scripts\engine\utility::array_call(var4, &delete);
  level.tower_elevator.clip = var0;
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

function use_elevator(var0) {
  self endon("death");
  self notify("use_elevator");
  self endon("use_elevator");

  for(;;) {
    self waittill("trigger", var1);
    self playSound("scn_cp_elevator_button_press");

    if(!isPlayer(var1)) {
      continue;
    }

    if(istrue(var0.locked)) {
      var1 iprintln("^2 Doors are locked ");
      continue;
    }

    if(istrue(var0.locked_behind_interaction)) {
      var1 iprintln("^2 Doors are locked; Activate the Switch to unlock the Elevator ");
      continue;
    }

    var0.user_triggered = 1;

    if(!istrue(var0.doors_opened)) {
      var0 = change_state(var0, 0);
      level.tower_elevator thread scripts\common\anim::anim_single_solo(level.tower_elevator, "elevator_open");
      self playSound("scn_cp_elevator_open");
      wait getanimlength(level.scr_anim["elevator"]["elevator_open"]);
      var0 = change_state(var0, 1);
      var1 iprintln("^2 you opened the elevator! ");
      continue;
    }

    thread push_players_out_of_the_way();
    var0 = change_state(var0, 2);
    level.tower_elevator thread scripts\common\anim::anim_single_solo(level.tower_elevator, "elevator_close");
    self playSound("scn_cp_elevator_close");
    wait getanimlength(level.scr_anim["elevator"]["elevator_close"]);
    var0 = change_state(var0, 3);
  }
}

function change_state(var0, var1) {
  var0.state = var1;
  var0 = set_properties_based_on_state(var0, var1, var0);
  return var0;
}

function set_properties_based_on_state(var0, var1) {
  if(!isDefined(var0) || !isint(var0) || var0 < 0 || var0 > 4) {
    return;
  }

  switch (var0) {
    case 0:
      break;
    case 1:
      self.doors_opened = 1;
      self.user_triggered = undefined;
      self.locked = undefined;

      foreach(var3 in var1.interactions) {
        var3 setHintString(&"CP_STRIKE/DOOR_CLOSE");
      }

      break;
    case 2:
      self.doors_opened = undefined;
      break;
    case 3:
      foreach(var3 in var1.interactions) {
        var3 setHintString(&"CP_STRIKE/DOOR_OPEN");
      }

      if(istrue(self.user_triggered)) {
        var1 = change_state(var1, 4);
        var1 = move_elevator(var1);
      }

      break;
    case 4:
      self.locked = 1;
      break;
    default:
      break;
  }

  return var1;
}

function push_players_out_of_the_way() {
  self notify("push_players_out_of_the_way");
  self endon("push_players_out_of_the_way");
}

function move_elevator() {
  var0 = self;
  var0 playSound("scn_cp_elevator_in_use_start");
  var0 playLoopSound("scn_cp_elevator_in_use_lp");

  if(var0.current_floor == 1) {
    var0.mover moveTo(var0.origin + (0, 0, -1448.01), 4);
  } else {
    var0.mover moveTo(var0.origin + (0, 0, 1448.01), 4);
  }

  wait 4;
  iprintln(" elevator travel done ");
  var0 playSound("scn_cp_elevator_in_use_stop");
  var0 stoploopsound("scn_cp_elevator_in_use_lp");

  if(var0.current_floor == 1) {
    var0.current_floor = 0;
  } else {
    var0.current_floor = 1;
  }

  var0 = change_state(var0, 0);
  var0 thread scripts\common\anim::anim_single_solo(var0, "elevator_open");
  var0 playSound("scn_cp_elevator_open");
  wait getanimlength(level.scr_anim["elevator"]["elevator_open"]);
  var0 = change_state(var0, 1);
  return var0;
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