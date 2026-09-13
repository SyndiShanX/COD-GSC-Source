/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_elevator.gsc
***********************************************/

init_elevator() {
  init_elevator_animations();
  _id_B8D865E526028EC2 = getEntArray("lift_clip", "script_noteworthy");
  elevator_model = getEnt("lift_model", "script_noteworthy");
  _id_3F01056740AE0E4D = getEnt("lift_doors", "script_noteworthy");

  if(isDefined(_id_3F01056740AE0E4D))
    _id_3F01056740AE0E4D delete();

  _id_7CCE4C5CBE847855 = getEntArray("lift_interaction", "script_noteworthy");
  _id_87094FB13853F344 = getEntArray("lift_floor", "script_noteworthy");
  _id_A146A0B16D25DD9F = getEnt("lift_model_anim", "script_noteworthy");

  if(isDefined(_id_A146A0B16D25DD9F))
    _id_A146A0B16D25DD9F delete();

  elevator_model setModel("lm_utility_elevator_02");
  elevator_model useanimtree(level.scr_animtree["elevator"]);
  elevator_model.animname = "elevator";
  level.tower_elevator = elevator_model;
  _id_CECDB7AEC5AE6324 = _id_7CCE4C5CBE847855[0];
  level.tower_elevator.interactions = [];

  foreach(interaction in _id_7CCE4C5CBE847855) {
    interaction setHintString(&"CP_STRIKE/DOOR_CLOSE");
    interaction setCursorHint("HINT_BUTTON");
    interaction sethintdisplayrange(300);
    interaction sethintdisplayfov(65);
    interaction setuserange(90);
    interaction setusefov(65);
    interaction sethintonobstruction("show");
    interaction setuseholdduration("duration_medium");
    interaction sethintrequiresholding(1);
    interaction makeusable();
    interaction linkTo(level.tower_elevator);
    level.tower_elevator.interactions = scripts\engine\utility::array_add(level.tower_elevator.interactions, interaction);
  }

  scripts\engine\utility::array_call(_id_87094FB13853F344, ::solid);
  scripts\engine\utility::array_call(_id_87094FB13853F344, ::linkto, level.tower_elevator);
  scripts\engine\utility::array_call(_id_87094FB13853F344, ::delete);
  level.tower_elevator.clip = _id_B8D865E526028EC2;
  scripts\engine\utility::array_call(level.tower_elevator.clip, ::solid);
  scripts\engine\utility::array_call(level.tower_elevator.clip, ::linkto, level.tower_elevator);
  level.tower_elevator.state = 1;
  level.tower_elevator.current_floor = 0;
  level.tower_elevator.doors_opened = 1;
  level.tower_elevator.user_triggered = undefined;
  level.tower_elevator.locked = undefined;
  level.tower_elevator.locked_behind_interaction = undefined;
  scripts\engine\utility::array_thread(level.tower_elevator.interactions, ::use_elevator, level.tower_elevator);
  level.tower_elevator.mover = spawn("script_model", level.tower_elevator.origin);
  level.tower_elevator.mover setModel("tag_origin");
  level.tower_elevator linkTo(level.tower_elevator.mover);
  level.tower_elevator thread scripts\common\anim::anim_single_solo(level.tower_elevator, "elevator_open");
  wait(getanimlength(level.scr_anim["elevator"]["elevator_open"]));
}

anim_check_loop() {
  for(;;) {
    scripts\common\anim::anim_single_solo(self, "elevator_open");
    wait(getanimlength(level.scr_anim["elevator"]["elevator_open"]));
    scripts\common\anim::anim_single_solo(self, "elevator_close");
    wait(getanimlength(level.scr_anim["elevator"]["elevator_close"]));
  }
}

use_elevator(_id_EEC55FABA21F3653) {
  self endon("death");
  self notify("use_elevator");
  self endon("use_elevator");

  for(;;) {
    self waittill("trigger", player);
    self playSound("scn_cp_elevator_button_press");

    if(!isPlayer(player)) {
      continue;
    }
    if(istrue(_id_EEC55FABA21F3653.locked)) {
      player iprintln("^2 Doors are locked ");
      continue;
    }

    if(istrue(_id_EEC55FABA21F3653.locked_behind_interaction)) {
      player iprintln("^2 Doors are locked; Activate the Switch to unlock the Elevator ");
      continue;
    }

    _id_EEC55FABA21F3653.user_triggered = 1;

    if(!istrue(_id_EEC55FABA21F3653.doors_opened)) {
      _id_EEC55FABA21F3653 = change_state(_id_EEC55FABA21F3653, 0);
      level.tower_elevator thread scripts\common\anim::anim_single_solo(level.tower_elevator, "elevator_open");
      self playSound("scn_cp_elevator_open");
      wait(getanimlength(level.scr_anim["elevator"]["elevator_open"]));
      _id_EEC55FABA21F3653 = change_state(_id_EEC55FABA21F3653, 1);
      player iprintln("^2 you opened the elevator! ");
      continue;
    }

    _id_EEC55FABA21F3653 thread push_players_out_of_the_way();
    _id_EEC55FABA21F3653 = change_state(_id_EEC55FABA21F3653, 2);
    level.tower_elevator thread scripts\common\anim::anim_single_solo(level.tower_elevator, "elevator_close");
    self playSound("scn_cp_elevator_close");
    wait(getanimlength(level.scr_anim["elevator"]["elevator_close"]));
    _id_EEC55FABA21F3653 = change_state(_id_EEC55FABA21F3653, 3);
  }
}

change_state(_id_EEC55FABA21F3653, state) {
  _id_EEC55FABA21F3653.state = state;
  _id_EEC55FABA21F3653 = _id_EEC55FABA21F3653 set_properties_based_on_state(state, _id_EEC55FABA21F3653);
  return _id_EEC55FABA21F3653;
}

set_properties_based_on_state(state, _id_EEC55FABA21F3653) {
  if(!isDefined(state) || !isint(state) || (state < 0 || state > 4)) {
    return;
  }
  switch (state) {
    case 0:
      break;
    case 1:
      self.doors_opened = 1;
      self.user_triggered = undefined;
      self.locked = undefined;

      foreach(interaction in _id_EEC55FABA21F3653.interactions)
      interaction setHintString(&"CP_STRIKE/DOOR_CLOSE");

      break;
    case 2:
      self.doors_opened = undefined;
      break;
    case 3:
      foreach(interaction in _id_EEC55FABA21F3653.interactions)
      interaction setHintString(&"CP_STRIKE/DOOR_OPEN");

      if(istrue(self.user_triggered)) {
        _id_EEC55FABA21F3653 = change_state(_id_EEC55FABA21F3653, 4);
        _id_EEC55FABA21F3653 = _id_EEC55FABA21F3653 move_elevator();
      }

      break;
    case 4:
      self.locked = 1;
      break;
    default:
      break;
  }

  return _id_EEC55FABA21F3653;
}

push_players_out_of_the_way() {
  self notify("push_players_out_of_the_way");
  self endon("push_players_out_of_the_way");
}

move_elevator() {
  _id_EEC55FABA21F3653 = self;
  _id_EEC55FABA21F3653 playSound("scn_cp_elevator_in_use_start");
  _id_EEC55FABA21F3653 playLoopSound("scn_cp_elevator_in_use_lp");

  if(_id_EEC55FABA21F3653.current_floor == 1)
    _id_EEC55FABA21F3653.mover moveTo(_id_EEC55FABA21F3653.origin + (0, 0, -1448.01), 4);
  else
    _id_EEC55FABA21F3653.mover moveTo(_id_EEC55FABA21F3653.origin + (0, 0, 1448.01), 4);

  wait 4;
  iprintln(" elevator travel done ");
  _id_EEC55FABA21F3653 playSound("scn_cp_elevator_in_use_stop");
  _id_EEC55FABA21F3653 stoploopsound("scn_cp_elevator_in_use_lp");

  if(_id_EEC55FABA21F3653.current_floor == 1)
    _id_EEC55FABA21F3653.current_floor = 0;
  else
    _id_EEC55FABA21F3653.current_floor = 1;

  _id_EEC55FABA21F3653 = change_state(_id_EEC55FABA21F3653, 0);
  _id_EEC55FABA21F3653 thread scripts\common\anim::anim_single_solo(_id_EEC55FABA21F3653, "elevator_open");
  _id_EEC55FABA21F3653 playSound("scn_cp_elevator_open");
  wait(getanimlength(level.scr_anim["elevator"]["elevator_open"]));
  _id_EEC55FABA21F3653 = change_state(_id_EEC55FABA21F3653, 1);
  return _id_EEC55FABA21F3653;
}

#using_animtree("script_model");

init_elevator_animations() {
  level.scr_animtree["elevator"] = #animtree;
  level.scr_model["elevator"] = "lm_utility_elevator_02";
  level.scr_anim["elevator"]["elevator_open"] = % cp_prop_elevatordoor_open;
  level.scr_animname["elevator"]["elevator_open"] = "cp_prop_elevatordoor_open";
  level.scr_anim["elevator"]["elevator_close"] = % cp_prop_elevatordoor_close;
  level.scr_animname["elevator"]["elevator_close"] = "cp_prop_elevatordoor_close";
}