/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\stpetersburg\stpetersburg_interrogation_escort.gsc
**********************************************************************/

escort_init() {
  efsm_init();
  level.player.previdlerumbletime = gettime() - 5000;
  level.player.prevmoverumbletime = gettime() - 5000;
  level.escorttargets[0] = level.enforcerwife;
  level.escorttargets[1] = level.enforcerson;
  level.escorttargetanimnode = scripts\engine\utility::getStruct("escort_anim_node", "targetname");
}

escort_engage() {
  if(!(isDefined(level.escorttargets) && isarray(level.escorttargets))) {
    return;
  }
  level notify("escort_engage");
  level.escortphase = 0;
  escort_drone_swap();
  escort_suit_toggle(1);
  escort_monitors();
}

escort_drone_swap() {
  var_0[0] = level.enforcerwife.model;
  var_0[1] = level.enforcerson.model;
  var_1[0] = "escort_intrg_mother";
  var_1[1] = "escort_intrg_son";
  var_2[0] = "Ousa";
  var_2[1] = "Amon";
  level.escortspawners[0] = getspawner("enforcer_wife", "targetname");
  level.escortspawners[1] = getspawner("enforcer_son", "targetname");

  foreach(var_5, var_4 in level.escortspawners) {
    level.escortdrones[var_5] = var_4 scripts\engine\sp\utility::fakeactorspawn();
    level.escortdrones[var_5].origin = level.escorttargets[var_5].origin;
    level.escortdrones[var_5].angles = level.escorttargets[var_5].angles;
    level.escortdrones[var_5].animname = var_1[var_5];
    level.escortdrones[var_5].name = var_2[var_5];
    level.escortdrones[var_5] scripts\sp\utility::enable_procedural_bones();
    level.escortdrones[var_5] setModel(var_0[var_5]);
    level.escortdrones[var_5] scripts\sp\fakeactor::take_control();
    level.escortdrones[var_5].fakeactor_face_anim = 1;
  }

  scripts\engine\utility::delaythread(0.05, scripts\engine\utility::array_call, level.escorttargets, ::hide);
  scripts\engine\utility::delaythread(2.5, scripts\engine\utility::array_call, level.escorttargets, ::delete);
  level.escortdrones[0] scripts\sp\maps\stpetersburg\stpetersburg_interrogation.gsc::blendshape_enable();

  if(isalive(level.player)) {
    level.escortdrones[0] linktoplayerviewignoreparentrot(level.player, "tag_origin", (50, 22, -64), (0, 0, 0), 1, 0, 1, 1);
    level.escortdrones[1] linktoplayerviewignoreparentrot(level.player, "tag_origin", (50, -18, -64), (0, 0, 0), 1, 0, 1, 1);
  }

  efsm_request_state(level.movementmachine, "idle");
}

escort_suit_toggle(var_0) {
  if(var_0) {
    level.player setsuit("iw8_escort_sp");
    level.player capturnrate(60, 45);
    set_escort_player_pitch_bounds(10, 30);
    level.groundrefent = scripts\engine\utility::spawn_tag_origin(level.player.origin, (0, 0, 0));
    level.groundrefent.animname = "escort_ref";
    level.groundrefent useanimtree(level.scr_animtree["escort_ref"]);
    level.player playersetgroundreferenceent(level.groundrefent);
    level.player forceplaygestureviewmodel("stp_wh_010_escort_mech_vm_idle", level.escortdrones[0], 0.5);
    thread enable_escort_gesture();
  } else {
    level.player setsuit("iw8_defaultsuit");
    level.player capturnrate(0, 0);
    set_escort_player_pitch_bounds(85, 85);
    disable_escort_gesture();
    level.player scripts\engine\sp\utility::blend_movespeedscale_default(0.25);
    level.player playersetgroundreferenceent(undefined);
    level.groundrefent delete();
  }

  level.player scripts\common\utility::allow_jump(!var_0, "escort");
  level.player scripts\common\utility::allow_crouch(!var_0, "escort");
  level.player scripts\common\utility::allow_prone(!var_0, "escort");
  level.player scripts\common\utility::allow_slide(!var_0, "escort");
  level.player scripts\common\utility::allow_mantle(!var_0, "escort");
  level.player scripts\common\utility::allow_offhand_weapons(!var_0, "escort");
  level.player scripts\common\utility::allow_sprint(!var_0, "escort");
  level.player scripts\common\utility::allow_weapon_pickup(!var_0, "escort");
  level.player scripts\sp\utility::allow_cg_drawcrosshair(!var_0, "escort");
  level.player disableemptyclipweaponswitch(var_0);
  level.player allowmountside(!var_0);
  level.player allowmounttop(!var_0);
  level thread scripts\sp\utility::context_melee_enable(!var_0);
}

set_escort_player_pitch_bounds(var_0, var_1) {
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 10);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_1, 30);
  setsaveddvar("NNSNKNRTPL", var_0);
  setsaveddvar("LOMLPPTKO", var_1);
}

set_escort_phase(var_0) {
  level.escortphase = var_0;

  if(var_0 == 1)
    thread efsm_request_state(level.movementmachine, "react");
}

enable_escort_gesture(var_0) {
  level notify("escort_gesture_enabled");
  level endon("escort_gesture_enabled");

  if(isalive(level.player)) {
    var_1 = level.movementmachine.currentstatename == "idle";

    if(isDefined(level.groundrefent)) {
      if(!var_1) {
        level.groundrefent setanimknob(level.groundrefent scripts\engine\utility::getanim("escort_sway_in"), 1, 0.1);
        wait(getanimlength(level.groundrefent scripts\engine\utility::getanim("escort_sway_in")));
        level.groundrefent setanimknob(level.groundrefent scripts\engine\utility::getanim("escort_sway")[0], 1, 0.1);
      } else {
        level.groundrefent setanimknob(level.groundrefent scripts\engine\utility::getanim("escort_sway_out"), 1, 0.1);
        wait(getanimlength(level.groundrefent scripts\engine\utility::getanim("escort_sway_out")));
        level.groundrefent setanimknob(level.groundrefent scripts\engine\utility::getanim("escort_idle")[0], 1, 0.1);
      }
    }

    childthread escort_gesture_rumble(var_1, var_0);
  }
}

escort_gesture_rumble(var_0, var_1) {
  if(var_0) {
    var_2 = (gettime() - level.player.previdlerumbletime) * 0.001;

    if(var_2 < 2.5) {
      return;
    }
    level.player.previdlerumbletime = gettime();
    level.player playRumbleOnEntity("viewmodel_small");
  }

  if(!var_0) {
    var_2 = (gettime() - level.player.prevmoverumbletime) * 0.001;

    if(var_2 < 0.5) {
      return;
    }
    level.player.prevmoverumbletime = gettime();
    level.player playRumbleOnEntity("viewmodel_small");

    if(!istrue(var_1)) {
      wait 0.8;
      level.player playRumbleOnEntity("viewmodel_medium");
    }
  }
}

disable_escort_gesture() {
  if(isalive(level.player))
    level.player stopgestureviewmodel();
}

escort_monitors() {
  if(isalive(level.player)) {
    thread efsm_event_monitor();
    thread escort_disengage();
  }
}

escort_disengage() {
  if(isalive(level.player))
    scripts\engine\utility::waittill_any_ents(level, "escort_disengage", level.player, "death");

  var_0[0] = getgroundposition(level.escortdrones[0].origin, 32);
  var_0[1] = getgroundposition(level.escortdrones[1].origin, 32);
  level.escortspawners[0].origin = var_0[0];
  level.escortspawners[0].angles = (0, level.player.angles[1], 0);
  level.escortspawners[1].origin = var_0[1];
  level.escortspawners[1].angles = (0, level.player.angles[1], 0);

  foreach(var_2 in level.escortdrones)
  var_2 unlinkfromplayerview(level.player);

  spawn_disengage_ai();
  escort_suit_toggle(0);
  level notify("escort_ended");
}

spawn_disengage_ai() {
  foreach(var_3, var_1 in level.escortspawners) {
    var_1.count = 1;
    var_2 = var_1 scripts\engine\sp\utility::spawn_ai(1);
    var_2 scripts\common\ai::gun_remove();
    var_2 scripts\common\ai::magic_bullet_shield(1);
    var_2 scripts\sp\utility::context_melee_allow(0);
    var_2 actoraimassistoff();
    var_2.ignoreme = 1;
    var_2.ignoreall = 1;
    var_2.allowdeath = 1;
    var_2 thread scripts\sp\maps\stpetersburg\stpetersburg_utility.gsc::breath_fx_thread();
    level.escorttargets[var_3] = var_2;
    level.escortdrones[var_3] delete();
  }
}

trigger_escort_disengage(var_0, var_1) {
  if(!istrue(var_0)) {
    efsm_request_state(level.movementmachine, "disengage");

    if(isDefined(var_1))
      wait(var_1);
  }

  level notify("escort_disengage");
  level waittill("escort_ended");

  if(!istrue(var_0))
    scripts\engine\utility::flag_set("interrogation_escort_done");

  return level.escorttargets;
}

efsm_init() {
  efsm_setup_movement_machine();
}

efsm_setup_movement_machine() {
  level.movementmachine = efsm_spawn_machine();
  level.movementmachine efsm_add_machine_state("idle", ::idle_enter);
  level.movementmachine efsm_add_machine_state("forward", [::move_forward_enter, ::move_forward_exit]);
  level.movementmachine efsm_add_machine_state("backward", [::move_backward_enter, ::move_backward_exit]);
  level.movementmachine efsm_add_machine_state("left", [::move_left_enter, ::move_left_exit]);
  level.movementmachine efsm_add_machine_state("right", [::move_right_enter, ::move_right_exit]);
  level.movementmachine efsm_add_machine_state("turn_left", [::turn_left_enter, ::turn_left_exit]);
  level.movementmachine efsm_add_machine_state("turn_right", [::turn_right_enter, ::turn_right_exit]);
  level.movementmachine efsm_add_machine_state("react", ::react_enter, 1, 1);
  level.movementmachine efsm_add_machine_state("disengage", ::disengage_enter, 1, 1);
  level.movementmachine efsm_add_machine_transition("idle", "all");
  level.movementmachine efsm_add_machine_transition("forward", "all");
  level.movementmachine efsm_add_machine_transition("backward", "all");
  level.movementmachine efsm_add_machine_transition("left", "all");
  level.movementmachine efsm_add_machine_transition("right", "all");
  level.movementmachine efsm_add_machine_transition("turn_left", "all");
  level.movementmachine efsm_add_machine_transition("turn_right", "all");
  level.movementmachine efsm_add_machine_transition("react", "all", ["turn_left", "turn_right"]);
  level.movementmachine efsm_add_machine_transition("disengage", undefined, "all");
}

efsm_spawn_machine() {
  var_0 = spawnStruct();
  var_0 reset_machine_state();
  return var_0;
}

reset_machine_state() {
  self.currentstatename = undefined;
  self.currentstate = undefined;
  self.previousstate = undefined;
  self.previousstatename = undefined;
  self.stateenterinprogress = 0;
}

efsm_add_machine_state(var_0, var_1, var_2, var_3) {
  if(!isarray(var_1))
    var_1 = [var_1];

  self.states[var_0] = var_1;
  self.states[var_0][2] = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 0);
  self.states[var_0][3] = scripts\engine\utility::ter_op(isDefined(var_3), var_3, 0);
}

efsm_add_machine_transition(var_0, var_1, var_2) {
  self.transitions[var_0][0] = var_1;
  self.transitions[var_0][1] = var_2;
}

efsm_request_state(var_0, var_1) {
  if(efsm_is_valid_transition(var_0, var_1) && efsm_can_interrupt(var_0)) {
    efsm_change_state(var_0, var_1);
    waitframe();
  }
}

efsm_is_valid_transition(var_0, var_1) {
  if(!scripts\engine\utility::array_contains_key(var_0.states, var_1))
    return 0;

  var_2 = var_0.currentstatename;

  if(!isDefined(var_2))
    return 1;

  if(scripts\engine\utility::is_equal(var_2, var_1))
    return 0;

  var_3 = var_0.transitions[var_2][0];
  var_4 = var_0.transitions[var_2][1];
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_3)) {
    if(isarray(var_3))
      var_5 = scripts\engine\utility::array_contains(var_3, var_1);
    else if(var_3 == "all")
      var_5 = 1;
  }

  if(isDefined(var_4)) {
    if(isarray(var_4))
      var_6 = scripts\engine\utility::array_contains(var_4, var_1);
    else if(var_4 == "all")
      var_6 = 1;
  }

  return istrue(var_5) && !istrue(var_6);
}

efsm_can_interrupt(var_0) {
  var_1 = isDefined(var_0.currentstate) && var_0.currentstate[2] && var_0.stateenterinprogress;
  return !var_1;
}

efsm_change_state(var_0, var_1, var_2) {
  level notify("efsm_state_change");
  level endon("efsm_state_change");
  level endon("escort_disengage");
  level.player endon("death");
  var_0.previousstate = var_0.currentstate;
  var_0.previousstatename = var_0.currentstatename;
  var_0.currentstate = efsm_get_state(var_0, var_1);
  var_0.currentstatename = var_1;

  if(isDefined(var_0.previousstate) && isDefined(var_0.previousstate[1]) && !var_0.currentstate[3])
    [[var_0.previousstate[1]]]();

  if(isDefined(var_0.currentstate[0])) {
    var_0.stateenterinprogress = 1;
    [[var_0.currentstate[0]]]();
    var_0.stateenterinprogress = 0;
  }
}

efsm_get_state(var_0, var_1) {
  if(scripts\engine\utility::array_contains_key(var_0.states, var_1))
    return var_0.states[var_1];
  else
    return undefined;
}

idle_enter() {
  var_0 = get_phase_anim("idle_loop");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode thread scripts\common\anim::anim_loop(level.escortdrones, var_0, "escort_loop_end");
  thread enable_escort_gesture();
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.2, 0.2);
}

move_forward_enter() {
  var_0 = get_phase_anim("forward_start");
  var_1 = get_phase_anim("forward_loop");

  switch (level.escortphase) {
    case 2:
    case 1:
      var_2 = 0.4;
      var_3 = 0.2;
      break;
    case 0:
    default:
      var_2 = 0.75;
      var_3 = 1.5;
      break;
  }

  thread enable_escort_gesture();
  level.player scripts\engine\utility::delaythread(0.2, scripts\engine\sp\utility::blend_movespeedscale, var_2, var_3);

  if(level.movementmachine.previousstatename == "idle")
    wait 0.15;

  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
  level.escorttargetanimnode thread scripts\common\anim::anim_loop(level.escortdrones, var_1, "escort_loop_end");
}

move_forward_exit() {
  var_0 = get_phase_anim("forward_stop");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
}

move_backward_enter() {
  var_0 = get_phase_anim("backward_start");
  var_1 = get_phase_anim("backward_loop");
  thread enable_escort_gesture();
  level.player scripts\engine\utility::delaythread(0.2, scripts\engine\sp\utility::blend_movespeedscale, 0.3, 0.2);

  if(level.movementmachine.previousstatename == "idle")
    wait 0.1;

  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
  level.escorttargetanimnode thread scripts\common\anim::anim_loop(level.escortdrones, var_1, "escort_loop_end");
}

move_backward_exit() {
  var_0 = get_phase_anim("backward_stop");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
}

move_left_enter() {
  var_0 = get_phase_anim("left_start");
  var_1 = get_phase_anim("left_loop");
  thread enable_escort_gesture();
  level.player scripts\engine\utility::delaythread(0.2, scripts\engine\sp\utility::blend_movespeedscale, 0.6, 0.2);

  if(level.movementmachine.previousstatename == "idle")
    wait 0.1;

  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
  level.escorttargetanimnode thread scripts\common\anim::anim_loop(level.escortdrones, var_1, "escort_loop_end");
}

move_left_exit() {
  var_0 = get_phase_anim("left_stop");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
}

move_right_enter() {
  var_0 = get_phase_anim("right_start");
  var_1 = get_phase_anim("right_loop");
  thread enable_escort_gesture();
  level.player scripts\engine\utility::delaythread(0.2, scripts\engine\sp\utility::blend_movespeedscale, 0.6, 0.2);

  if(level.movementmachine.previousstatename == "idle")
    wait 0.1;

  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
  level.escorttargetanimnode thread scripts\common\anim::anim_loop(level.escortdrones, var_1, "escort_loop_end");
}

move_right_exit() {
  var_0 = get_phase_anim("right_stop");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
}

turn_left_enter() {
  var_0 = get_phase_anim("turn_left_start");
  var_1 = get_phase_anim("turn_left");
  thread enable_escort_gesture(1);
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
  level.escorttargetanimnode thread scripts\common\anim::anim_loop(level.escortdrones, var_1, "escort_loop_end");
}

turn_left_exit() {
  var_0 = get_phase_anim("turn_left_stop");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
}

turn_right_enter() {
  var_0 = get_phase_anim("turn_right_start");
  var_1 = get_phase_anim("turn_right");
  thread enable_escort_gesture(1);
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
  level.escorttargetanimnode thread scripts\common\anim::anim_loop(level.escortdrones, var_1, "escort_loop_end");
}

turn_right_exit() {
  var_0 = get_phase_anim("turn_right_stop");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
}

react_enter() {
  level.escortdrones[0] stopsounds();
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.3, 0.2);
  thread enable_escort_gesture();
  level.player playRumbleOnEntity("heavy_3s");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode thread scripts\common\anim::anim_single(level.escortdrones, "react_hallway");
  var_0 = getanimlength(level.escortdrones[0] scripts\engine\utility::getanim("react_hallway"));
  wait(var_0 - 0.2);

  if(!level.player.escortidle) {
    level.escortdrones[0] notify("single anim", "end");
    level.escortdrones[1] notify("single anim", "end");
  } else
    wait 0.2;

  thread remove_wife_blendshape_in_hallway();
}

disengage_enter() {
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode thread scripts\common\anim::anim_single(level.escortdrones, "handoff_disengage");
}

efsm_event_monitor() {
  level endon("escort_disengage");
  level.player endon("death");
  childthread efsm_stick_input();
  childthread efsm_idle_check();
}

efsm_stick_input() {
  level.timerforward = 0;
  level.timerbackward = 0;
  level.timerright = 0;
  level.timerleft = 0;
  level.timerlookright = 0;
  level.timerlookleft = 0;
  level.player.escortidle = 0;

  for(;;) {
    var_0 = level.player getnormalizedmovement();
    var_1 = level.player getnormalizedcameramovement();
    var_2 = 0;
    var_3 = 0;

    if(issaverecentlyloaded())
      level.player capturnrate(60, 45);

    var_4 = left_stick_movement(var_0);

    if(isDefined(level.escortdrones)) {
      switch (var_4) {
        case 0:
          var_2 = 1;
          break;
        case 1:
          childthread efsm_request_state(level.movementmachine, "forward");
          break;
        case 2:
          childthread efsm_request_state(level.movementmachine, "backward");
          break;
        case 4:
          childthread efsm_request_state(level.movementmachine, "right");
          break;
        case 3:
          childthread efsm_request_state(level.movementmachine, "left");
          break;
      }

      if(var_4 != 0) {
        level.player.escortidle = 0;
        waitframe();
        continue;
      }

      var_5 = right_stick_movement(var_1);

      switch (var_5) {
        case 0:
          var_3 = 1;
          break;
        case 6:
          childthread efsm_request_state(level.movementmachine, "turn_right");
          break;
        case 5:
          childthread efsm_request_state(level.movementmachine, "turn_left");
          break;
      }

      if(var_2 && var_3) {
        childthread efsm_request_state(level.movementmachine, "idle");
        level.player.escortidle = 1;
      } else
        level.player.escortidle = 0;
    }

    waitframe();
  }
}

efsm_idle_check() {
  var_0 = 0;
  var_1 = 3;

  for(;;) {
    wait 1;

    if(level.movementmachine.currentstatename == "idle" || level.movementmachine.currentstatename == "turn_left" || level.movementmachine.currentstatename == "turn_right")
      var_0++;
    else {
      var_0 = 0;
      scripts\engine\utility::flag_clear("interrogation_escort_idle");
    }

    if(var_0 >= var_1)
      scripts\engine\utility::flag_set("interrogation_escort_idle");
  }
}

left_stick_movement(var_0) {
  var_1 = 0;
  var_2 = 0;

  if(abs(var_0[0]) > abs(var_0[1])) {
    level.timerleft = 0;
    level.timerright = 0;

    if(var_0[0] > 0.5) {
      level.timerforward = level.timerforward + 1;

      if(level.timerforward > 0.0)
        return 1;
    } else if(var_0[0] < -0.5) {
      level.timerbackward = level.timerbackward + 1;

      if(level.timerbackward > 0.0)
        return 2;
    }
  } else if(abs(var_0[1]) > abs(var_0[0])) {
    level.timerforward = 0;
    level.timerbackward = 0;

    if(var_0[1] > 0.5) {
      level.timerright = level.timerright + 1;

      if(level.timerright > 0)
        return 4;
    } else if(var_0[1] < -0.5) {
      level.timerleft = level.timerleft + 1;

      if(level.timerleft > 0)
        return 3;
    }
  } else {
    level.timerforward = 0;
    level.timerbackward = 0;
    level.timerleft = 0;
    level.timerright = 0;
  }

  return 0;
}

right_stick_movement(var_0) {
  var_1 = 0;

  if(var_0[1] > 0.5) {
    level.timerlookright = level.timerlookright + 1;

    if(level.timerlookright > 0)
      return 6;
  } else if(var_0[1] < -0.5) {
    level.timerlookleft = level.timerlookleft + 1;

    if(level.timerlookleft > 0)
      return 5;
  } else {
    level.timerlookright = 0;
    level.timerlookleft = 0;
  }

  return 0;
}

get_phase_anim(var_0) {
  var_1 = var_0;

  switch (level.escortphase) {
    case 1:
      var_1 = var_0 + "_hallway";
      break;
    case 0:
    default:
      break;
  }

  return var_1;
}

remove_wife_blendshape_in_hallway() {
  while(distance2d(level.player.origin, level.price.origin) > 120)
    waitframe();

  level.escortdrones[0] scripts\sp\maps\stpetersburg\stpetersburg_interrogation.gsc::blendshape_disable();
}