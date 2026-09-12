/******************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\stpetersburg\stpetersburg_interrogation_escort.gsc
******************************************************************************/

function escort_init() {
  efsm_init();
  level.player.previdlerumbletime = gettime() - 5000;
  level.player.prevmoverumbletime = gettime() - 5000;
  level.escorttargets[0] = level.enforcerwife;
  level.escorttargets[1] = level.enforcerson;
  level.escorttargetanimnode = scripts\engine\utility::getStruct("escort_anim_node", "targetname");
}

function escort_engage() {
  if(!(isDefined(level.escorttargets) && isarray(level.escorttargets))) {
    return;
  }

  level notify("escort_engage");
  level.escortphase = 0;
  escort_drone_swap();
  escort_suit_toggle(1);
  escort_monitors();
}

function escort_drone_swap() {
  GscBinSkip1(0x45, 0, level.enforcerwife.model);
}

function escort_suit_toggle(var_0) {
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

function set_escort_player_pitch_bounds(var_0, var_1) {
  var_0 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 10);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_0), var_1, 30);
  setsaveddvar("player_view_pitch_up", var_0);
  setsaveddvar("player_view_pitch_down", var_1);
}

function set_escort_phase(var_0) {
  level.escortphase = var_0;

  if(var_0 == 1) {
    thread efsm_request_state(level.movementmachine, "react");
    return;
  }
}

function enable_escort_gesture(var_0) {
  level notify("escort_gesture_enabled");
  level endon("escort_gesture_enabled");

  if(isalive(level.player)) {
    var_1 = level.movementmachine.currentstatename == "idle";

    if(isDefined(level.groundrefent)) {
      if(!var_1) {
        level.groundrefent setanimknob(level.groundrefent scripts\engine\utility::getanim("escort_sway_in"), 1, 0.1);
        wait getanimlength(level.groundrefent scripts\engine\utility::getanim("escort_sway_in"));
        level.groundrefent setanimknob(level.groundrefent scripts\engine\utility::getanim("escort_sway")[0], 1, 0.1);
      } else {
        level.groundrefent setanimknob(level.groundrefent scripts\engine\utility::getanim("escort_sway_out"), 1, 0.1);
        wait getanimlength(level.groundrefent scripts\engine\utility::getanim("escort_sway_out"));
        level.groundrefent setanimknob(level.groundrefent scripts\engine\utility::getanim("escort_idle")[0], 1, 0.1);
      }
    }

    GscBinSkip4(0x35, var_1, var_0);
  }
}

function escort_gesture_rumble(var_0, var_1) {
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
      return;
    }

    return;
  }
}

function disable_escort_gesture() {
  if(isalive(level.player)) {
    level.player stopgestureviewmodel();
    return;
  }
}

function escort_monitors() {
  if(isalive(level.player)) {
    thread efsm_event_monitor();
    thread escort_disengage();
    return;
  }
}

function escort_disengage() {
  if(isalive(level.player)) {
    scripts\engine\utility::waittill_any_ents(level, "escort_disengage", level.player, "death");
  }

  GscBinSkip1(0x45, 0, getgroundposition(level.escortdrones[0].origin, 32));
}

function spawn_disengage_ai() {
  foreach(var_1 in level.escortspawners) {
    var_1.count = 1;
    var_2 = var_1 scripts\engine\sp\utility::spawn_ai(1);
    var_2 scripts\common\ai::gun_remove();
    var_2 scripts\common\ai::magic_bullet_shield(1);
    var_2 scripts\sp\utility::context_melee_allow(0);
    var_2 actoraimassistoff();
    var_2.ignoreme = 1;
    var_2.ignoreall = 1;
    var_2.allowdeath = 1;
    var_2 thread scripts\sp\maps\stpetersburg\stpetersburg_utility::breath_fx_thread();
    level.escorttargets[var_3] = var_2;
    level.escortdrones[var_3] delete();
  }
}

function trigger_escort_disengage(var_0, var_1) {
  if(!istrue(var_0)) {
    efsm_request_state(level.movementmachine, "disengage");

    if(isDefined(var_1)) {
      wait var_1;
    }
  }

  level notify("escort_disengage");
  level waittill("escort_ended");

  if(!istrue(var_0)) {
    scripts\engine\utility::flag_set("interrogation_escort_done");
  }

  return level.escorttargets;
}

function efsm_init() {
  efsm_setup_movement_machine();
}

function efsm_setup_movement_machine() {
  level.movementmachine = efsm_spawn_machine();
  efsm_add_machine_state(level.movementmachine, "idle", &idle_enter);
  efsm_add_machine_state(level.movementmachine, "forward", [ &move_forward_enter, &move_forward_exit]);
  efsm_add_machine_state(level.movementmachine, "backward", [ &move_backward_enter, &move_backward_exit]);
  efsm_add_machine_state(level.movementmachine, "left", [ &move_left_enter, &move_left_exit]);
  efsm_add_machine_state(level.movementmachine, "right", [ &move_right_enter, &move_right_exit]);
  efsm_add_machine_state(level.movementmachine, "turn_left", [ &turn_left_enter, &turn_left_exit]);
  efsm_add_machine_state(level.movementmachine, "turn_right", [ &turn_right_enter, &turn_right_exit]);
  efsm_add_machine_state(level.movementmachine, "react", &react_enter, 1, 1);
  efsm_add_machine_state(level.movementmachine, "disengage", &disengage_enter, 1, 1);
  efsm_add_machine_transition(level.movementmachine, "idle", "all");
  efsm_add_machine_transition(level.movementmachine, "forward", "all");
  efsm_add_machine_transition(level.movementmachine, "backward", "all");
  efsm_add_machine_transition(level.movementmachine, "left", "all");
  efsm_add_machine_transition(level.movementmachine, "right", "all");
  efsm_add_machine_transition(level.movementmachine, "turn_left", "all");
  efsm_add_machine_transition(level.movementmachine, "turn_right", "all");
  efsm_add_machine_transition(level.movementmachine, "react", "all", ["turn_left", "turn_right"]);
  efsm_add_machine_transition(level.movementmachine, "disengage", undefined, "all");
}

function efsm_spawn_machine() {
  var_0 = spawnStruct();
  reset_machine_state(var_0);
  return var_0;
}

function reset_machine_state() {
  self.currentstatename = undefined;
  self.currentstate = undefined;
  self.previousstate = undefined;
  self.previousstatename = undefined;
  self.stateenterinprogress = 0;
}

function efsm_add_machine_state(var_0, var_1, var_2, var_3) {
  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  self.states[var_0] = var_1;
  self.states[var_0][2] = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 0);
  self.states[var_0][3] = scripts\engine\utility::ter_op(isDefined(var_3), var_3, 0);
}

function efsm_add_machine_transition(var_0, var_1, var_2) {
  self.transitions[var_0][0] = var_1;
  self.transitions[var_0][1] = var_2;
}

function efsm_request_state(var_0, var_1) {
  if(efsm_is_valid_transition(var_0, var_1) && efsm_can_interrupt(var_0)) {
    efsm_change_state(var_0, var_1);
    waitframe();
    return;
  }
}

function efsm_is_valid_transition(var_0, var_1) {
  if(!scripts\engine\utility::array_contains_key(var_0.states, var_1)) {
    return false;
  }

  var_2 = var_0.currentstatename;

  if(!isDefined(var_2)) {
    return true;
  }

  if(scripts\engine\utility::is_equal(var_2, var_1)) {
    return false;
  }

  var_3 = var_0.transitions[var_2][0];
  var_4 = var_0.transitions[var_2][1];
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_3)) {
    if(isarray(var_3)) {
      var_5 = scripts\engine\utility::array_contains(var_3, var_1);
    } else if(var_3 == "all") {
      var_5 = 1;
    }
  }

  if(isDefined(var_4)) {
    if(isarray(var_4)) {
      var_6 = scripts\engine\utility::array_contains(var_4, var_1);
    } else if(var_4 == "all") {
      var_6 = 1;
    }
  }

  return istrue(var_5) && !istrue(var_6);
}

function efsm_can_interrupt(var_0) {
  var_1 = isDefined(var_0.currentstate) && var_0.currentstate[2] && var_0.stateenterinprogress;
  return !var_1;
}

function efsm_change_state(var_0, var_1, var_2) {
  level notify("efsm_state_change");
  level endon("efsm_state_change");
  level endon("escort_disengage");
  level.player endon("death");
  var_0.previousstate = var_0.currentstate;
  var_0.previousstatename = var_0.currentstatename;
  var_0.currentstate = efsm_get_state(var_0, var_1);
  var_0.currentstatename = var_1;

  if(isDefined(var_0.previousstate) && isDefined(var_0.previousstate[1]) && !var_0.currentstate[3]) {
    [[var_0.previousstate[1]]]();
  }

  if(isDefined(var_0.currentstate[0])) {
    var_0.stateenterinprogress = 1;
    [[var_0.currentstate[0]]]();
    var_0.stateenterinprogress = 0;
    return;
  }
}

function efsm_get_state(var_0, var_1) {
  if(scripts\engine\utility::array_contains_key(var_0.states, var_1)) {
    return var_0.states[var_1];
  }

  return undefined;
}

function idle_enter() {
  var_0 = get_phase_anim("idle_loop");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode thread scripts\common\anim::anim_loop(level.escortdrones, var_0, "escort_loop_end");
  thread enable_escort_gesture();
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.2, 0.2);
}

function move_forward_enter() {
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
  level.player scripts\engine\utility::delaythread(0.2, &scripts\engine\sp\utility::blend_movespeedscale, var_2, var_3);

  if(level.movementmachine.previousstatename == "idle") {
    wait 0.15;
  }

  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_2);
  level.escorttargetanimnode thread scripts\common\anim::anim_loop(level.escortdrones, var_3, "escort_loop_end");
}

function move_forward_exit() {
  var_0 = get_phase_anim("forward_stop");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
}

function move_backward_enter() {
  var_0 = get_phase_anim("backward_start");
  var_1 = get_phase_anim("backward_loop");
  thread enable_escort_gesture();
  level.player scripts\engine\utility::delaythread(0.2, &scripts\engine\sp\utility::blend_movespeedscale, 0.3, 0.2);

  if(level.movementmachine.previousstatename == "idle") {
    wait 0.1;
  }

  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
  level.escorttargetanimnode thread scripts\common\anim::anim_loop(level.escortdrones, var_1, "escort_loop_end");
}

function move_backward_exit() {
  var_0 = get_phase_anim("backward_stop");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
}

function move_left_enter() {
  var_0 = get_phase_anim("left_start");
  var_1 = get_phase_anim("left_loop");
  thread enable_escort_gesture();
  level.player scripts\engine\utility::delaythread(0.2, &scripts\engine\sp\utility::blend_movespeedscale, 0.6, 0.2);

  if(level.movementmachine.previousstatename == "idle") {
    wait 0.1;
  }

  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
  level.escorttargetanimnode thread scripts\common\anim::anim_loop(level.escortdrones, var_1, "escort_loop_end");
}

function move_left_exit() {
  var_0 = get_phase_anim("left_stop");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
}

function move_right_enter() {
  var_0 = get_phase_anim("right_start");
  var_1 = get_phase_anim("right_loop");
  thread enable_escort_gesture();
  level.player scripts\engine\utility::delaythread(0.2, &scripts\engine\sp\utility::blend_movespeedscale, 0.6, 0.2);

  if(level.movementmachine.previousstatename == "idle") {
    wait 0.1;
  }

  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
  level.escorttargetanimnode thread scripts\common\anim::anim_loop(level.escortdrones, var_1, "escort_loop_end");
}

function move_right_exit() {
  var_0 = get_phase_anim("right_stop");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
}

function turn_left_enter() {
  var_0 = get_phase_anim("turn_left_start");
  var_1 = get_phase_anim("turn_left");
  thread enable_escort_gesture(1);
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
  level.escorttargetanimnode thread scripts\common\anim::anim_loop(level.escortdrones, var_1, "escort_loop_end");
}

function turn_left_exit() {
  var_0 = get_phase_anim("turn_left_stop");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
}

function turn_right_enter() {
  var_0 = get_phase_anim("turn_right_start");
  var_1 = get_phase_anim("turn_right");
  thread enable_escort_gesture(1);
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
  level.escorttargetanimnode thread scripts\common\anim::anim_loop(level.escortdrones, var_1, "escort_loop_end");
}

function turn_right_exit() {
  var_0 = get_phase_anim("turn_right_stop");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode scripts\common\anim::anim_single(level.escortdrones, var_0);
}

function react_enter() {
  level.escortdrones[0] stopsounds();
  level.player scripts\engine\sp\utility::blend_movespeedscale(0.3, 0.2);
  thread enable_escort_gesture();
  level.player playRumbleOnEntity("heavy_3s");
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode thread scripts\common\anim::anim_single(level.escortdrones, "react_hallway");
  var_0 = getanimlength(level.escortdrones[0] scripts\engine\utility::getanim("react_hallway"));
  wait var_0 - 0.2;

  if(!level.player.escortidle) {
    level.escortdrones[0] notify("single anim", "end");
    level.escortdrones[1] notify("single anim", "end");
  } else {
    wait 0.2;
  }

  thread remove_wife_blendshape_in_hallway();
}

function disengage_enter() {
  level.escorttargetanimnode notify("escort_loop_end");
  level.escorttargetanimnode thread scripts\common\anim::anim_single(level.escortdrones, "handoff_disengage");
}

function efsm_event_monitor() {
  level endon("escort_disengage");
  level.player endon("death");
  GscBinSkip4(0x35);
}

function efsm_stick_input() {
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

    if(issaverecentlyloaded()) {
      level.player capturnrate(60, 45);
    }

    var_4 = left_stick_movement(var_0);

    if(isDefined(level.escortdrones)) {
      switch (var_4) {
        case 0:
          var_2 = 1;
          break;
        case 1:
          GscBinSkip4(0x35, level.movementmachine, "forward");

        case 2:
          GscBinSkip4(0x35, level.movementmachine, "backward");

        case 4:
          GscBinSkip4(0x35, level.movementmachine, "right");

        case 3:
          GscBinSkip4(0x35, level.movementmachine, "left");
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
          GscBinSkip4(0x35, level.movementmachine, "turn_right");

        case 5:
          GscBinSkip4(0x35, level.movementmachine, "turn_left");
      }

      if(var_2 && var_3) {
        GscBinSkip4(0x35, level.movementmachine, "idle");
      }

      level.player.escortidle = 0;
    }

    waitframe();
  }
}

function efsm_idle_check() {
  var_0 = 0;
  var_1 = 3;

  for(;;) {
    wait 1;

    if(level.movementmachine.currentstatename == "idle" || level.movementmachine.currentstatename == "turn_left" || level.movementmachine.currentstatename == "turn_right") {
      var_0++;
    } else {
      var_0 = 0;
      scripts\engine\utility::flag_clear("interrogation_escort_idle");
    }

    if(var_0 >= var_1) {
      scripts\engine\utility::flag_set("interrogation_escort_idle");
    }
  }
}

function left_stick_movement(var_0) {
  var_1 = 0;
  var_2 = 0;

  if(abs(var_0[0]) > abs(var_0[1])) {
    level.timerleft = 0;
    level.timerright = 0;

    if(var_0[0] > 0.5) {
      level.timerforward += 1;

      if(level.timerforward > 0) {
        return 1;
      }
    } else if(var_0[0] < -0.5) {
      level.timerbackward += 1;

      if(level.timerbackward > 0) {
        return 2;
      }
    }
  } else if(abs(var_0[1]) > abs(var_0[0])) {
    level.timerforward = 0;
    level.timerbackward = 0;

    if(var_0[1] > 0.5) {
      level.timerright += 1;

      if(level.timerright > 0) {
        return 4;
      }
    } else if(var_0[1] < -0.5) {
      level.timerleft += 1;

      if(level.timerleft > 0) {
        return 3;
      }
    }
  } else {
    level.timerforward = 0;
    level.timerbackward = 0;
    level.timerleft = 0;
    level.timerright = 0;
  }

  return 0;
}

function right_stick_movement(var_0) {
  var_1 = 0;

  if(var_0[1] > 0.5) {
    level.timerlookright += 1;

    if(level.timerlookright > 0) {
      return 6;
    }
  } else if(var_0[1] < -0.5) {
    level.timerlookleft += 1;

    if(level.timerlookleft > 0) {
      return 5;
    }
  } else {
    level.timerlookright = 0;
    level.timerlookleft = 0;
  }

  return 0;
}

function get_phase_anim(var_0) {
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

function remove_wife_blendshape_in_hallway() {
  while(distance2d(level.player.origin, level.price.origin) > 120) {
    waitframe();
  }

  level.escortdrones[0] scripts\sp\maps\stpetersburg\stpetersburg_interrogation::blendshape_disable();
}