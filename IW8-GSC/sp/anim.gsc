/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\anim.gsc
***********************************************/

init() {
  setdvarifuninitialized("scr_anim_react_debug", "0");
  scripts\common\anim::initanim();
  scripts\anim\notetracks_sp.gsc::registernotetracksifnot();
  scripts\anim\pain.gsc::initpainfx();
  scripts\anim\death.gsc::init_deathfx();
  anim.callbacks["PlaySoundAtViewHeight"] = ::play_sound_at_viewheight;
  anim.callbacks["TeleportEnt"] = ::teleport_entity;
  anim.callbacks["ShouldDoAnim"] = ::should_do_anim;
  anim.callbacks["DoAnimation"] = ::do_animation;
  anim.callbacks["DoFacialAnim"] = ::do_facial_anim;
  anim.callbacks["StopAnimscripted"] = scripts\engine\sp\utility::anim_stopanimscripted;
  anim.callbacks["AnimHandleNotetrack"] = scripts\sp\anim_notetrack::sp_anim_handle_notetrack;
  anim.callbacks["EntityHandleNotetrack"] = scripts\sp\anim_notetrack::entity_handle_notetrack;
  anim.callbacks["AIAnimFirstFrame"] = ::ai_anim_first_frame;
  scripts\asm\asm::asm_globalinit();
  scripts\aitypes\bt_util::init();
  scripts\asm\asm::setup_level_ents();
  scripts\anim\animselector.gsc::init();

  if(!isDefined(level.notetrackmissionfailedvo))
    level.notetrackmissionfailedvo = 1;

  if(!isDefined(level.notetrackvo))
    level.notetrackvo = 1;
}

anim_generic_gravity(var_0, var_1, var_2) {
  var_3 = var_0.allowpain;
  var_0 scripts\engine\utility::disable_pain();
  anim_generic_custom_animmode(var_0, "gravity", var_1, var_2);

  if(var_3)
    var_0 scripts\engine\utility::enable_pain();
}

anim_generic_reach(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  anim_reach(var_3, var_1, var_2, "generic");
}

anim_generic_reach_and_arrive(var_0, var_1, var_2, var_3) {
  reach_and_arrive_internal(var_0, var_1, var_2, var_3, "generic");
}

anim_reach_and_arrive(var_0, var_1, var_2, var_3) {
  reach_and_arrive_internal(var_0, var_1, var_2, var_3, var_0.animname);
}

reach_and_arrive_internal(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\sp\interaction::is_interact_struct(self) || scripts\sp\interaction::is_state_interact_struct(self)) {
    if(isDefined(self.script_reaction))
      var_0.asm.customdata.interaction = self.script_reaction;
    else
      var_0.asm.customdata.interaction = self.script_noteworthy;

    var_5 = scripts\sp\interaction::get_interaction(var_0.asm.customdata.interaction);

    if(!isDefined(var_5))
      var_5 = scripts\sp\interaction::get_state_interaction(var_0.asm.customdata.interaction);

    var_0.asm.customdata.arrivalstate = undefined;

    if(isDefined(var_5))
      var_0.asm.customdata.arrivalstate = var_0 scripts\sp\interaction::get_arrivalstate_from_interaction(var_5);

    if(isDefined(var_0.asm.customdata.arrivalstate)) {
      anim_reach_with_funcs([var_0], var_1, var_2, var_4, ::reach_to_interact_begin, ::reach_to_interact_end, var_3);
      return;
    }

    anim_reach_with_funcs([var_0], var_1, var_2, var_4, ::reach_with_arrivals_begin, ::reach_with_standard_adjustments_end, var_3);
    return;
  } else
    anim_reach_with_funcs([var_0], var_1, var_2, var_4, ::reach_with_arrivals_begin, ::reach_with_standard_adjustments_end, var_3);
}

anim_reach_and_plant(var_0, var_1, var_2) {
  anim_reach_with_funcs(var_0, var_1, var_2, undefined, ::reach_with_planting, ::reach_with_standard_adjustments_end);
}

anim_reach_and_plant_and_arrive(var_0, var_1, var_2) {
  anim_reach_with_funcs(var_0, var_1, var_2, undefined, ::reach_with_planting_and_arrivals, ::reach_with_standard_adjustments_end);
}

anim_custom_animmode(var_0, var_1, var_2, var_3) {
  var_4 = scripts\common\anim::get_anim_position(var_3);
  var_5 = var_4["origin"];
  var_6 = var_4["angles"];
  var_7 = undefined;

  foreach(var_9 in var_0) {
    var_7 = var_9;
    thread anim_custom_animmode_on_guy(var_9, var_1, var_2, var_5, var_6, var_9.animname, 0);
  }

  var_7 wait_until_anim_finishes(var_2);
  self notify(var_2);
}

anim_custom_animmode_loop(var_0, var_1, var_2, var_3) {
  var_4 = scripts\common\anim::get_anim_position(var_3);
  var_5 = var_4["origin"];
  var_6 = var_4["angles"];

  foreach(var_8 in var_0)
  thread anim_custom_animmode_on_guy(var_8, var_1, var_2, var_5, var_6, var_8.animname, 1);

  var_0[0] wait_until_anim_finishes(var_2);
  self notify(var_2);
}

wait_until_anim_finishes(var_0) {
  self endon("finished_custom_animmode" + var_0);
  self waittill("death");
}

anim_generic_custom_animmode(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\common\anim::get_anim_position(var_3);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];
  thread anim_custom_animmode_on_guy(var_0, var_1, var_2, var_7, var_8, "generic", 0, var_4, var_5);
  var_0 wait_until_anim_finishes(var_2);
  self notify(var_2);
}

anim_generic_custom_animmode_loop(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\common\anim::get_anim_position(var_3);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];
  thread anim_custom_animmode_on_guy(var_0, var_1, var_2, var_7, var_8, "generic", 1, var_4, var_5);
  var_0 wait_until_anim_finishes(var_2);
  self notify(var_2);
}

anim_custom_animmode_solo(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = var_0;
  anim_custom_animmode(var_4, var_1, var_2, var_3);
}

anim_custom_animmode_loop_solo(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = var_0;
  anim_custom_animmode_loop(var_4, var_1, var_2, var_3);
}

anim_custom_animmode_on_guy(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isai(var_0) && var_0 scripts\engine\utility::doinglongdeath()) {
    return;
  }
  var_9 = undefined;

  if(isDefined(var_5))
    var_9 = var_5;
  else
    var_9 = var_0.animname;

  if(!isDefined(var_8) || !var_8)
    var_0 scripts\common\anim::set_start_pos(var_2, var_3, var_4, var_5, var_6);

  var_0._animmode = var_1;
  var_0._custom_anim = var_2;
  var_0._tag_entity = self;
  var_0._anime = var_2;
  var_0._animname = var_9;
  var_0._custom_anim_loop = var_6;
  var_0._custom_anim_thread = var_7;

  if(getdvarint("LPNQTQRRP", 0) == 1) {
    var_0 scripts\asm\asm_sp::asm_animcustom(scripts\anim\animmode.gsc::main, scripts\asm\asm_sp::asm_stopanimcustom);
    return;
  }

  var_0 animcustom(scripts\anim\animmode.gsc::main);
}

anim_single_gravity(var_0, var_1, var_2) {
  foreach(var_4 in var_0)
  var_4 scripts\engine\utility::disable_pain();

  anim_custom_animmode(var_0, "gravity", var_1, var_2);

  foreach(var_4 in var_0) {
    if(isDefined(var_4) && isalive(var_4))
      var_4 scripts\engine\utility::enable_pain();
  }
}

anim_single_run(var_0, var_1, var_2, var_3) {
  scripts\common\anim::anim_single_internal(var_0, var_1, var_2, 0.25, var_3);
}

anim_reach_and_idle(var_0, var_1, var_2, var_3, var_4) {
  thread anim_reach(var_0, var_1, var_4);
  var_5 = spawnStruct();
  var_5.reachers = 0;

  foreach(var_7 in var_0) {
    var_5.reachers++;
    thread idle_on_reach(var_7, var_2, var_3, var_4, var_5);
  }

  for(;;) {
    var_5 waittill("reached_position");

    if(var_5.reachers <= 0)
      return;
  }
}

wait_for_guy_to_die_or_get_in_position() {
  self endon("death");
  self waittill("anim_reach_complete");
}

idle_on_reach(var_0, var_1, var_2, var_3, var_4) {
  var_0 wait_for_guy_to_die_or_get_in_position();
  var_4.reachers--;
  var_4 notify("reached_position");

  if(isalive(var_0))
    scripts\common\anim::anim_loop_solo(var_0, var_1, var_2, var_3);
}

anim_reach_together(var_0, var_1, var_2, var_3) {
  thread modify_moveplaybackrate_together(var_0);
  anim_reach_with_funcs(var_0, var_1, var_2, var_3, ::reach_with_standard_adjustments_begin, ::reach_with_standard_adjustments_end);
}

modify_moveplaybackrate_together(var_0) {
  var_1 = 0.3;
  waittillframeend;

  for(;;) {
    var_0 = scripts\engine\utility::array_removedead(var_0);
    var_2 = [];
    var_3 = 0;

    foreach(var_8, var_5 in var_0) {
      var_6 = var_5.goalpos;

      if(isDefined(var_5.reach_goal_pos))
        var_6 = var_5.reach_goal_pos;

      var_7 = distance(var_5.origin, var_6);
      var_2[var_5.unique_id] = var_7;

      if(var_7 <= 4) {
        var_0[var_8] = undefined;
        continue;
      }

      var_3 = var_3 + var_7;
    }

    if(var_0.size <= 1) {
      break;
    }

    var_3 = var_3 / var_0.size;

    foreach(var_5 in var_0) {
      var_10 = var_2[var_5.unique_id] - var_3;
      var_11 = var_10 * 0.003;

      if(var_11 > var_1)
        var_11 = var_1;
      else if(var_11 < var_1 * -1)
        var_11 = var_1 * -1;

      var_5 scripts\asm\asm::asm_setmoveplaybackrate(1 + var_11);
    }

    wait 0.05;
  }

  foreach(var_5 in var_0) {
    if(isalive(var_5))
      var_5 scripts\asm\asm::asm_setmoveplaybackrate(1);
  }
}

anim_reach_failsafe(var_0, var_1) {
  if(isarray(var_0)) {
    foreach(var_3 in var_0)
    thread anim_reach_failsafe(var_3, var_1);

    return;
  }

  var_3 = var_0;
  var_3 endon("new_anim_reach");
  wait(var_1);
  var_3 notify("goal");
}

anim_reach(var_0, var_1, var_2, var_3) {
  if(scripts\sp\interaction::is_interact_struct(self)) {
    foreach(var_5 in var_0) {
      if(isDefined(self.script_reaction)) {
        var_5.asm.customdata.interaction = self.script_reaction;
        continue;
      }

      var_5.asm.customdata.interaction = self.script_noteworthy;
    }

    anim_reach_with_funcs(var_0, var_1, var_2, var_3, ::reach_to_interact_begin, ::reach_to_interact_end);
  } else
    anim_reach_with_funcs(var_0, var_1, var_2, var_3, ::reach_with_standard_adjustments_begin, ::reach_with_standard_adjustments_end);
}

anim_reach_with_funcs(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\common\anim::get_anim_position(var_2);
  var_8 = var_7["origin"];
  var_9 = var_7["angles"];
  var_10 = spawnStruct();
  var_11 = 0;
  var_12 = 0;

  foreach(var_14 in var_0) {
    if(isDefined(var_3))
      var_15 = var_3;
    else
      var_15 = var_14.animname;

    if(isDefined(level.scr_anim[var_15][var_1])) {
      if(isarray(level.scr_anim[var_15][var_1])) {
        var_16 = getstartorigin(var_8, var_9, level.scr_anim[var_15][var_1][0]);
        var_17 = getstartangles(var_8, var_9, level.scr_anim[var_15][var_1][0]);
      } else {
        var_16 = getstartorigin(var_8, var_9, level.scr_anim[var_15][var_1]);
        var_17 = getstartangles(var_8, var_9, level.scr_anim[var_15][var_1]);
      }
    } else {
      var_16 = var_8;
      var_17 = var_9;
    }

    if(isDefined(var_6)) {
      var_14.scriptedarrivalent = spawn("script_origin", var_16);
      var_14.scriptedarrivalent.angles = var_17;
      var_14.scriptedarrivalent.type = var_6;
      var_14.scriptedarrivalent.arrivalstance = "stand";
      var_14.forcenextpathfindimmediate = 1;
      var_18 = var_14 getmovingplatformparent();

      if(isDefined(var_18))
        var_14.scriptedarrivalent linkTo(var_18);
    }

    var_12++;
    var_14 thread begin_anim_reach(var_10, var_16, var_17, var_4, var_5);
  }

  while(var_12) {
    var_10 waittill("reach_notify");
    var_12--;
  }

  foreach(var_14 in var_0) {
    if(!isalive(var_14)) {
      continue;
    }
    var_14.goalradius = var_14.oldgoalradius;

    if(isDefined(var_14.scriptedarrivalent))
      var_14.scriptedarrivalent delete();

    var_14.stopanimdistsq = 0;
  }
}

anim_reach_cleanup_solo(var_0) {
  if(!isalive(var_0)) {
    return;
  }
  if(isDefined(var_0.oldgoalradius))
    var_0.goalradius = var_0.oldgoalradius;

  if(isDefined(var_0.scriptedarrivalent))
    var_0.scriptedarrivalent delete();

  var_0.disablearrivals = undefined;
  var_0.stopanimdistsq = 0;
}

anim_spawner_teleport(var_0, var_1, var_2) {
  var_3 = scripts\common\anim::get_anim_position(var_2);
  var_4 = var_3["origin"];
  var_5 = var_3["angles"];
  var_6 = spawnStruct();

  foreach(var_8 in var_0) {
    var_9 = getstartorigin(var_4, var_5, level.scr_anim[var_8.animname][var_1]);
    var_8.origin = var_9;
  }
}

reach_death_notify(var_0) {
  scripts\engine\utility::waittill_either("death", "goal");

  while(isalive(self) && isDefined(self.asm) && isDefined(self.asm.arriving))
    wait 0.05;

  var_0 notify("reach_notify");
}

begin_anim_reach(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("new_anim_reach");
  thread reach_death_notify(var_0);
  var_1 = [[var_3]](var_1, var_2);
  scripts\engine\sp\utility::set_goal_pos(var_1);
  self.reach_goal_pos = var_1;
  self.goalradius = 0;
  self.stopanimdistsq = squared(120);
  self waittill("goal");
  self notify("anim_reach_complete");
  [[var_4]]();
  self notify("new_anim_reach");
}

reach_to_interact_begin(var_0, var_1) {
  self.oldgoalradius = self.goalradius;
  self.oldpathenemyfightdist = self.pathenemyfightdist;
  self.oldpathenemylookahead = self.pathenemylookahead;
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  scripts\engine\sp\utility::disable_ai_color();
  anim_changes_pushplayer(1);
  self.nododgemove = 1;
  self.doavoidanceblocking = 0;
  self.fixednodewason = self.fixednode;
  self.fixednode = 0;
  self.old_disablearrivals = self.disablearrivals;
  self.disablearrivals = 0;
  self.reach_goal_pos = undefined;
  var_2 = scripts\sp\interaction::get_interaction(self.asm.customdata.interaction);

  if(!isDefined(var_2))
    var_2 = scripts\sp\interaction::get_state_interaction(self.asm.customdata.interaction);

  self.asm.customdata.arrivalstate = scripts\sp\interaction::get_arrivalstate_from_interaction(var_2);
  self.asm.customdata.arrivalangles = var_1;
  self.asm.customdata.idlestate = scripts\sp\interaction::get_idlestate_from_interaction(var_2);
  self.asm.customdata.arrivalusefootdown = 1;

  if(isDefined(var_2.arrival_animmode))
    self.asm.customdata.custom_arrival_animmode = var_2.arrival_animmode;

  return var_0;
}

reach_with_standard_adjustments_begin(var_0, var_1) {
  self.oldgoalradius = self.goalradius;
  self.oldpathenemyfightdist = self.pathenemyfightdist;
  self.oldpathenemylookahead = self.pathenemylookahead;
  self.pathenemyfightdist = 128;
  self.pathenemylookahead = 128;
  scripts\engine\sp\utility::disable_ai_color();
  anim_changes_pushplayer(1);
  self.nododgemove = 1;
  self.doavoidanceblocking = 0;
  self.fixednodewason = self.fixednode;
  self.fixednode = 0;

  if(!isDefined(self.scriptedarrivalent)) {
    self.old_disablearrivals = self.disablearrivals;
    self.disablearrivals = 1;
  } else {
    self.scriptedarrivalent.angles = var_1;
    self.scriptedarrivalent.origin = var_0;
  }

  self.reach_goal_pos = undefined;
  return var_0;
}

reach_to_interact_end() {
  anim_changes_pushplayer(0);
  self.nododgemove = 0;
  self.doavoidanceblocking = 1;
  self.fixednode = self.fixednodewason;
  self.fixednodewason = undefined;
  self.pathenemyfightdist = self.oldpathenemyfightdist;
  self.pathenemylookahead = self.oldpathenemylookahead;
  self.disablearrivals = self.old_disablearrivals;
  var_0 = scripts\sp\interaction::get_interaction(self.asm.customdata.interaction);

  if(!isDefined(var_0))
    var_0 = scripts\sp\interaction::get_state_interaction(self.asm.customdata.interaction);

  self.asm.customdata.exitstate = scripts\sp\interaction::get_exitstate_from_interaction(var_0);
  self.asm.customdata.interaction = undefined;
  self.asm.customdata.arrivalstate = undefined;
  self.asm.customdata.arrivalangles = undefined;
}

reach_with_standard_adjustments_end() {
  anim_changes_pushplayer(0);
  self.nododgemove = 0;
  self.doavoidanceblocking = 1;
  self.fixednode = self.fixednodewason;
  self.fixednodewason = undefined;
  self.pathenemyfightdist = self.oldpathenemyfightdist;
  self.pathenemylookahead = self.oldpathenemylookahead;
  self.disablearrivals = self.old_disablearrivals;
}

anim_changes_pushplayer(var_0) {
  if(isDefined(self.dontchangepushplayer)) {
    return;
  }
  self pushplayer(var_0);
  return;
}

reach_with_arrivals_begin(var_0, var_1) {
  var_0 = reach_with_standard_adjustments_begin(var_0, var_1);
  self.disablearrivals = 0;
  return var_0;
}

reach_with_planting(var_0, var_1) {
  var_2 = self getdroptofloorposition(var_0);
  var_0 = var_2;
  var_0 = reach_with_standard_adjustments_begin(var_0, var_1);
  self.disablearrivals = 1;
  return var_0;
}

reach_with_planting_and_arrivals(var_0, var_1) {
  var_2 = self getdroptofloorposition(var_0);
  var_0 = var_2;
  var_0 = reach_with_standard_adjustments_begin(var_0, var_1);
  self.disablearrivals = 0;
  return var_0;
}

anim_reach_and_idle_solo(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5[0] = var_0;
  anim_reach_and_idle(var_5, var_1, var_2, var_3, var_4);
}

anim_reach_solo(var_0, var_1, var_2) {
  self endon("death");
  var_3[0] = var_0;
  anim_reach(var_3, var_1, var_2);
}

anim_reach_and_approach_solo(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4[0] = var_0;
  anim_reach_and_approach(var_4, var_1, var_2, var_3);
}

anim_reach_and_approach_node_solo(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5[0] = var_0;
  var_6 = scripts\common\anim::get_anim_position(var_2);
  var_7 = var_6["origin"];
  var_8 = var_6["angles"];
  var_9 = var_0.animname;

  if(isDefined(level.scr_anim[var_9][var_1])) {
    if(isarray(level.scr_anim[var_9][var_1]))
      var_10 = level.scr_anim[var_9][var_1][0];
    else
      var_10 = level.scr_anim[var_9][var_1];

    var_7 = getstartorigin(var_7, var_8, var_10);
    var_8 = getstartorigin(var_7, var_8, var_10);
  }

  var_11 = spawn("script_origin", var_7);
  var_11.angles = var_8;

  if(isDefined(var_3))
    var_11.type = var_3;
  else
    var_11.type = self.type;

  if(isDefined(var_4))
    var_11.arrivalstance = var_4;
  else
    var_11.arrivalstance = self gethighestnodestance();

  var_0.scriptedarrivalent = var_11;
  anim_reach_and_approach(var_5, var_1, var_2);
  var_0.scriptedarrivalent = undefined;
  var_11 delete();

  while(var_0.a.movement != "stop")
    wait 0.05;
}

anim_reach_and_approach(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(scripts\sp\interaction::is_interact_struct(self)) {
    foreach(var_5 in var_0) {
      if(isDefined(self.script_noteworthy)) {
        var_5.asm.customdata.interaction = self.script_noteworthy;
        continue;
      }

      var_5.asm.customdata.interaction = self.script_reaction;
    }

    anim_reach_with_funcs(var_0, var_1, var_2, undefined, ::reach_to_interact_begin, ::reach_to_interact_end, var_3);
  } else {
    if(!isDefined(var_3))
      var_3 = "Exposed";

    anim_reach_with_funcs(var_0, var_1, var_2, undefined, ::reach_with_arrivals_begin, ::reach_with_standard_adjustments_end, var_3);
  }
}

add_animation(var_0, var_1) {
  if(!isDefined(level.completedanims))
    level.completedanims[var_0][0] = var_1;
  else if(!isDefined(level.completedanims[var_0]))
    level.completedanims[var_0][0] = var_1;
  else {
    for(var_2 = 0; var_2 < level.completedanims[var_0].size; var_2++) {
      if(level.completedanims[var_0][var_2] == var_1)
        return;
    }

    level.completedanims[var_0][level.completedanims[var_0].size] = var_1;
  }
}

anim_single_queue(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3))
    var_3 = 0;

  if(isDefined(var_0.last_queue_time))
    scripts\engine\sp\utility::wait_for_buffer_time_to_pass(var_0.last_queue_time, 0.5);

  scripts\engine\sp\utility::function_stack(scripts\common\anim::anim_single_solo, var_0, var_1, var_2, var_3);

  if(isalive(var_0))
    var_0.last_queue_time = gettime();
}

anim_generic_queue(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");

  if(!isDefined(var_3))
    var_3 = 0;

  if(isDefined(var_0.last_queue_time))
    scripts\engine\sp\utility::wait_for_buffer_time_to_pass(var_0.last_queue_time, 0.5);

  if(isDefined(var_4))
    scripts\engine\sp\utility::function_stack_timeout(var_4, scripts\common\anim::anim_single_solo, var_0, var_1, var_2, var_3, "generic");
  else
    scripts\engine\sp\utility::function_stack(scripts\common\anim::anim_single_solo, var_0, var_1, var_2, var_3, "generic");

  if(isalive(var_0))
    var_0.last_queue_time = gettime();
}

anim_dontpushplayer(var_0) {
  foreach(var_2 in var_0)
  var_2 pushplayer(0);
}

anim_pushplayer(var_0) {
  foreach(var_2 in var_0)
  var_2 pushplayer(1);
}

anim_facialanim(var_0, var_1, var_2) {
  var_0 endon("death");
  self endon(var_1);
  var_3 = 0.05;
  var_0 notify("newLookTarget");
  scripts\asm\shared\utility::disabledefaultfacialanims();
  waittillframeend;

  if(!isDefined(self.scriptedtalkingknob))
    self.scriptedtalkingknob = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "scripted_talking"));

  var_4 = "scripted_face_" + var_1;
  var_0 setanim(self.scriptedtalkingknob, 1, 0.2);
  var_0 setflaggedanimknobrestart(var_4, var_2, 1, 0, 1);
  thread facial_notetrack_handler(var_0, var_4, var_1);
  thread clearfaceanimonanimdone(var_0, var_4, var_1);
}

facial_notetrack_handler(var_0, var_1, var_2) {
  self endon(var_2);
  var_0 endon("death");
  var_0 endon("stop_loop");
  var_0 endon("scripted_face_done");

  for(;;) {
    self waittill(var_1, var_3);

    foreach(var_5 in var_3) {
      var_6 = getsubstr(var_5, 0, 3);

      if(var_6 == "vo_") {
        var_7 = getsubstr(var_5, 3);

        if(!issentient(self))
          thread scripts\engine\sp\utility::play_sound_on_tag(var_7, "j_head", 1, var_7);
        else
          play_sound_at_viewheight(var_7, "face_sounddone", 1);

        continue;
      }

      if(var_6 == "pvo") {
        var_7 = getsubstr(var_5, 4);
        thread scripts\engine\sp\utility::smart_player_dialogue(var_7);
      }
    }
  }
}

anim_facialfiller(var_0, var_1) {
  self endon("death");

  if(isai(self) && !isalive(self)) {
    return;
  }
  if(!isai(self)) {
    if(!isDefined(self.fakeactor_face_anim))
      return;
    else if(!self.fakeactor_face_anim || !isalive(self))
      return;
  }

  if(istrue(self.nofacialfiller)) {
    return;
  }
  if(!scripts\asm\shared\utility::isfacialstateallowed("filler")) {
    return;
  }
  if(isDefined(self.unittype) && (self.unittype == "c6" || self.unittype == "c8" || self.unittype == "c12")) {
    return;
  }
  var_2 = 0.05;
  self notify("newLookTarget");
  self endon("newLookTarget");
  waittillframeend;

  if(!isDefined(var_1) && isDefined(self.bc_looktarget))
    var_1 = self.bc_looktarget;

  var_3 = "";

  if(isDefined(self.asm))
    var_3 = self.asm.archetype;

  if(isDefined(self.animationarchetype))
    var_3 = self.animationarchetype;

  var_4 = self.defaulttalk;
  var_5 = self.scriptedtalkingknob;
  scripts\asm\shared\utility::setfacialstate("filler");

  if(var_3 != "") {
    if(isai(self))
      self setfacialindex("talk");
    else
      scripts\asm\shared\utility::setfacialindexfornonai("talk");
  } else {
    self setanimknoblimitedrestart(var_4, 1, 0, 1);
    self setanim(var_5, 5, 0.267);
  }

  set_talker_until_msg(var_0);
  var_2 = 0.3;

  if(var_3 != "" && isai(self))
    self setfacialindex("none");
  else
    scripts\asm\shared\utility::setfacialindexfornonai("none");

  scripts\asm\shared\utility::clearfacialstate("filler");
}

set_talker_until_msg(var_0) {
  self waittill(var_0);
}

talk_for_time(var_0) {
  self endon("death");
  var_1 = self.defaulttalk;
  self setanimknoblimitedrestart(var_1, 1, 0, 1);
  self setanim(self.scriptedtalkingknob, 5, 0.4);
  scripts\asm\shared\utility::disabledefaultfacialanims();
  wait(var_0);
  var_2 = 0.3;
  self clearanim(self.scriptedtalkingknob, 0.2);
  scripts\asm\shared\utility::disabledefaultfacialanims(0);
}

anim_reach_idle(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.count = var_0.size;

  foreach(var_5 in var_0)
  thread reachidle(var_5, var_1, var_2, var_3);

  while(var_3.count)
    var_3 waittill("reached_goal");

  self notify("stopReachIdle");
}

reachidle(var_0, var_1, var_2, var_3) {
  anim_reach_solo(var_0, var_1);
  var_3.count--;
  var_3 notify("reached_goal");

  if(var_3.count > 0)
    scripts\common\anim::anim_loop_solo(var_0, var_2, "stopReachIdle");
}

clearfaceanimonanimdone(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 waittillmatch(var_1, "end");
  var_0 notify("scripted_face_done");
  var_3 = 0.3;
  var_0 clearanim(self.scriptedtalkingknob, 0.2);
  scripts\asm\shared\utility::disabledefaultfacialanims(0);
}

anim_set_rate_single(var_0, var_1, var_2) {
  var_0 thread anim_set_rate_internal(var_1, var_2);
}

anim_set_rate(var_0, var_1, var_2) {
  scripts\engine\utility::array_thread(var_0, ::anim_set_rate_internal, var_1, var_2);
}

anim_set_rate_internal(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2))
    var_3 = var_2;
  else
    var_3 = self.animname;

  self setflaggedanim("single anim", scripts\engine\utility::getanim_from_animname(var_0, var_3), 1, 0, var_1);
}

create_anim_scene(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    var_3 = "generic";
  else
    level.scr_animtree[var_3] = var_0;

  var_5 = spawnStruct();
  var_5.animtree = var_0;
  var_5.model = var_4;

  if(isDefined(var_4))
    level.scr_model[var_3] = var_4;

  if(isDefined(var_2))
    level.scr_anim[var_3][var_1] = var_2;

  var_5.animname = var_3;
  var_5.anim_sequence = var_1;
  level.current_anim_data_scene = var_5;
}

blended_loop_solo(var_0, var_1, var_2, var_3) {
  var_0.anim_array = var_2;
  var_0.ender = var_3;
  var_0.gesture_lookat = var_1;
  var_0.animnode = self;
  var_0 scripts\asm\asm_sp::asm_animcustom(scripts\asm\gesture\script_funcs::blended_loop_anim, scripts\asm\gesture\script_funcs::blended_loop_cleanup);
}

blended_anim_solo(var_0, var_1, var_2) {
  while(isDefined(var_0.anim_array))
    wait 0.05;

  var_0.anim_array = var_2;
  var_0.gesture_lookat = var_1;
  var_0.animnode = self;
  var_0 scripts\asm\asm_sp::asm_animcustom(scripts\asm\gesture\script_funcs::blended_anim);
}

anim_block_in_single(var_0, var_1, var_2) {
  foreach(var_4 in var_0)
  thread anim_block_in_internal(var_4, var_1, var_2);
}

anim_block_in_solo(var_0, var_1, var_2) {
  thread anim_block_in_internal(var_0, var_1, var_2);
}

anim_block_in_internal(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("stop_blockin");
  var_3 = var_0.animname;
  var_0 scripts\common\anim::assert_existance_of_anim(var_1, var_3);

  if(isDefined(level.scr_blockin[var_3]) && isDefined(level.scr_blockin[var_3][var_1]))
    var_4 = scripts\engine\utility::getStruct(level.scr_blockin[var_3][var_1], "targetname");
  else
    return;

  if(!isDefined(var_2))
    var_2 = 50;

  var_5 = spawn("script_model", var_0.origin);
  var_5.angles = var_0.angles;
  var_5 setModel("tag_origin");
  var_6 = var_0.ignoreall;
  var_7 = var_0.ignoreme;
  var_0 thread anim_block_in_cleanup_internal(var_5, var_6, var_7);
  var_8 = distance(var_0.origin, var_4.origin);
  var_9 = var_8 / var_2;

  if(isPlayer(var_0))
    var_0 playerlinktoabsolute(var_5);
  else if(isai(var_0)) {
    var_0 animcustom(::t_poser);
    var_0 linkTo(var_5, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_0.ignoreall = 1;
  } else {
    var_0 linkTo(var_5, "tag_origin", (0, 0, 0), (0, 0, 0));
    var_0.ignoreall = 1;
  }

  var_0.ignoreme = 1;
  var_9 = scripts\engine\utility::ter_op(var_9 == 0, 0.05, var_9);
  var_10 = 0.05;
  var_5 moveTo(var_4.origin, var_10);
  var_5 rotateTo(vectortoangles(var_4.origin - var_5.origin), var_10);

  if(isai(var_0)) {
    if(!isDefined(var_4.angles))
      var_0 orientmode("face point", var_4.origin);
    else
      var_0 orientmode("face angle", var_4.angles[1]);
  }

  var_5 waittill("movedone");
  var_4 scripts\engine\utility::script_wait();

  while(isDefined(var_4.target)) {
    var_11 = scripts\engine\utility::getStruct(var_4.target, "targetname");

    if(isDefined(var_4.script_speed))
      var_2 = var_4.script_speed;

    var_4 scripts\engine\utility::script_delay();
    var_4 = var_11;
    var_8 = distance(var_0.origin, var_4.origin);
    var_9 = var_8 / var_2;
    var_5 moveTo(var_4.origin, var_9);

    if(isDefined(var_4.angles)) {
      var_5 rotateTo(var_4.angles, var_9);

      if(isai(var_0))
        var_0 orientmode("face angle", var_4.angles[1]);
    } else {
      var_5 rotateTo(vectortoangles(var_11.origin - var_5.origin), var_9);

      if(isai(var_0))
        var_0 orientmode("face point", var_11.origin);
    }

    var_5 waittill("movedone");
    var_4 scripts\engine\utility::script_wait();
  }

  var_0 notify("tposer done");
}

t_poser() {
  self animmode("noclip");
  scripts\engine\utility::waittill_any("tposer done", "stop_blockin");
}

anim_block_in_cleanup_internal(var_0, var_1, var_2) {
  scripts\engine\utility::waittill_any("tposer done", "stop_blockin", "death");
  self unlink();

  if(isai(self))
    self.ignoreall = var_1;

  self.ignoreme = var_2;
  var_0 delete();
}

should_do_anim() {
  return !isai(self) || !scripts\engine\utility::doinglongdeath();
}

teleport_entity(var_0, var_1) {
  if(isai(self)) {
    if(isDefined(self.anim_start_at_groundpos))
      var_0 = scripts\engine\utility::drop_to_ground(var_0);

    self forceteleport(var_0, var_1, 9999);
  } else if(isDefined(self.vehicletype)) {
    self vehicle_teleport(var_0, var_1);
    self dontinterpolate();
  } else {
    self.origin = var_0;
    self.angles = var_1;
    self dontinterpolate();
  }
}

play_sound_at_viewheight(var_0, var_1, var_2) {
  if(isDefined(var_1) && isDefined(var_2))
    self playsoundatviewheight(var_0, var_1, var_2);
  else if(isDefined(var_1))
    self playsoundatviewheight(var_0, var_1);
  else
    self playsoundatviewheight(var_0);

  if(isDefined(var_1))
    self.scripteddialoguenotify = gettime();
  else
    self.scripteddialoguenonotify = gettime();

  thread bcs_scripted_dialog_clear(var_0, var_1);
}

bcs_scripted_dialog_clear(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1)) {
    self waittill(var_1);
    self.scripteddialoguenotify = undefined;
  } else {
    var_2 = lookupsoundlength(var_0) * 0.001;
    wait(var_2);
    self.scripteddialoguenonotify = undefined;
  }
}

do_facial_anim(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_0 && !var_6) {
    if(var_1)
      thread scripts\anim\face.gsc::sayspecificdialogue(var_5);

    thread anim_facialanim(self, var_3, level.scr_face[var_4][var_3]);
    return 1;
  } else if(isai(self) || isDefined(self.fakeactor_face_anim) && self.fakeactor_face_anim) {
    if(var_2)
      scripts\anim\face.gsc::sayspecificdialogue(var_5);
    else {
      if(!var_6)
        thread anim_facialfiller("single dialogue");

      scripts\anim\face.gsc::sayspecificdialogue(var_5, "single dialogue");
    }
  } else
    thread scripts\engine\sp\utility::play_sound_on_entity(var_5, "single dialogue");

  return 0;
}

#using_animtree("animscripted_default_headlook");

do_animation(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(isDefined(var_5))
    var_6 = level.scr_anim[var_2][var_3][var_5];
  else
    var_6 = level.scr_anim[var_2][var_3];

  var_7 = scripts\common\anim::anim_get_goal_time(var_2, var_3);
  scripts\common\anim::last_anim_time_check();

  if(!isDefined(var_5))
    self._lastanime = var_3;

  if(self.code_classname == "misc_turret" && !isDefined(var_5))
    self setflaggedanim(var_4, var_6, 1, var_7);
  else {
    var_8 = undefined;

    if(isai(self) || scripts\sp\fakeactor::is_fakeactor())
      var_8 = scripts\asm\asm::asm_getbodyknob();
    else if(isDefined(self.anim_getrootfunc))
      var_8 = [[self.anim_getrootfunc]]();

    if(isDefined(self.asm) && !isai(self))
      scripts\asm\asm_sp::asm_animScripted();

    var_9 = [-90, 90, -60, 60];
    var_10 = % lookatpos_animscripted_default;

    if(isDefined(level.scr_lookat) && isDefined(level.scr_lookat[var_2]) && isDefined(level.scr_lookat[var_2][var_3])) {
      var_9 = level.scr_lookat[var_2][var_3].ranges;
      var_10 = level.scr_lookat[var_2][var_3].atr_node;
    }

    self animScripted(var_4, var_0, var_1, var_6, undefined, var_8, var_7, 1.0, var_9[0], var_9[1], var_9[2], var_9[3], var_10);
  }

  thread scripts\common\notetrack::start_notetrack_wait(self, var_4, var_3, var_2, var_6);
  thread animscriptdonotetracksthread(self, var_4, var_3);
  return getanimlength(var_6);
}

animscriptdonotetracksthread(var_0, var_1, var_2) {
  if(isDefined(var_0.dontdonotetracks) && var_0.dontdonotetracks) {
    return;
  }
  var_0 endon("stop_sequencing_notetracks");
  var_0 endon("death");
  var_0 scripts\anim\notetracks.gsc::donotetracks(var_1);
}

ai_anim_first_frame(var_0, var_1) {
  self._first_frame_anim = var_0;
  self._animname = var_1;
  scripts\asm\asm_sp::asm_animcustom(scripts\anim\first_frame.gsc::main);
}

anim_react_new(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(!isarray(var_0))
    var_0 = [var_0];

  var_3.guys = var_0;
  var_3.node = var_1;
  var_3.anime = var_2;
  return var_3;
}

anim_react(var_0, var_1, var_2, var_3) {
  var_4 = anim_react_new(var_0, self, var_1);
  var_4.fnreact = var_2;
  var_4.gotocombatonly = var_3;
  anim_react_data(var_4);
}

anim_react_data(var_0) {
  scripts\engine\utility::array_thread(var_0.guys, ::anim_react_thread, var_0);
  var_1 = var_0.anime;

  foreach(var_3 in var_0.guys) {
    var_4 = var_1 + "_death";

    if(isDefined(level.scr_anim[var_3.animname][var_4]))
      var_3 scripts\engine\sp\utility::set_deathanim(var_4);

    if(isDefined(var_3.animents)) {
      foreach(var_6 in var_3.animents) {
        if(isDefined(level.scr_anim[var_6.animname][var_4]))
          var_6.deathanime = var_4;
      }
    }

    level thread anim_react_death(var_0.node, var_3, var_0.fnreact);
  }

  var_9 = var_1 + "_intro";

  if(isDefined(level.scr_anim[var_0.guys[0].animname][var_9]))
    var_0.node anim_single_with_props(var_0.guys, var_9);

  var_10 = var_1 + "_loop";
  var_11 = var_1 + "_outro";

  foreach(var_3 in var_0.guys) {
    if(!isalive(var_3)) {
      continue;
    }
    if(var_3 scripts\engine\utility::ent_flag("anim_reacted")) {
      continue;
    }
    if(isDefined(level.scr_anim[var_3.animname][var_10])) {
      var_0.node thread anim_loop_with_props(var_3, var_10, "stop_anim_loop_" + var_3.animname);
      continue;
    }

    if(isDefined(level.scr_anim[var_3.animname][var_11])) {
      var_0.node thread anim_single_with_props(var_3, var_11);
      var_3 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "outro_anim_end");
      var_3 scripts\engine\utility::thread_on_notify("outro_anim_end", scripts\engine\utility::send_notify, "stop_anim_react", undefined, undefined, var_3, "anim_react");
      continue;
    }

    var_3 notify("stop_anim_react");
    var_3 notify("stop_anim_react_death");
  }
}

anim_react_thread(var_0) {
  self endon("death");
  self notify("stop_anim_react");
  self endon("stop_anim_react");
  var_1 = anim_react_wait_thread();
  anim_react_alertgroup_msg("reacted", var_1);
  self notify("anim_react");
  var_0.node notify("anim_react");

  if(!istrue(self.anim_react_skip_stopanimscripted)) {
    var_0.node notify("stop_anim_loop_" + self.animname);
    scripts\engine\sp\utility::anim_stopanimScripted();
  }

  var_2 = 0;

  if(isDefined(var_0.fnreact)) {
    var_3 = self[[var_0.fnreact]](var_1);

    if(isDefined(var_3)) {
      if(var_3 == "skip_reaction")
        var_2 = 1;
      else
        var_1 = var_3;
    }
  }

  if(!var_2) {
    var_4 = get_react_type(var_1);
    var_5 = var_0.anime;
    var_6 = undefined;

    if(isDefined(var_0.fnreactanime))
      var_6 = [[var_0.fnreactanime]](var_1);

    if(var_1 == "pain") {
      var_6 = var_5 + "_react_pain";

      if(isDefined(level.scr_anim[self.animname][var_6])) {
        self.allowdeath = 1;

        if(!isDefined(self.animreactrelative))
          var_0.node anim_single_with_props(self, var_6);
        else
          anim_single_with_props(self, var_6);
      } else if(isDefined(self.script_stealthgroup))
        scripts\stealth\enemy::bt_set_stealth_state("combat");
    } else {
      level thread detach_linkedaniments(self);

      if(!isDefined(var_6))
        var_6 = var_5 + "_react_" + var_4;

      if(!isDefined(level.scr_anim[self.animname][var_6]))
        var_6 = var_5 + "_react";

      if(isDefined(level.scr_anim[self.animname][var_6])) {
        self.allowdeath = 1;

        if(!isDefined(self.animreactrelative))
          var_0.node anim_single_with_props(self, var_6);
        else
          anim_single_with_props(self, var_6);
      }

      var_7 = var_6 + "_loop";

      if(isDefined(level.scr_anim[self.animname][var_7])) {
        if(!isDefined(self.animreactrelative))
          var_0.node anim_loop_with_props(self, var_7);
        else
          anim_loop_with_props(self, var_7);
      }

      if(isDefined(self.script_stealthgroup) && istrue(var_0.gotocombatonly))
        scripts\stealth\enemy::bt_set_stealth_state("combat");
    }
  } else {}

  self notify("anim_react_done");

  if(isDefined(self.target))
    scripts\sp\spawner::go_to_node();

  if(!isDefined(self.script_forcegoal))
    self.goalradius = level.default_goalradius;
}

get_react_type(var_0) {
  switch (var_0) {
    case "ai_event_low":
      return "low";
    default:
      return "high";
  }
}

anim_react_wait_thread() {
  self endon("death");
  self endon("stop_anim_react");

  if(!scripts\engine\utility::ent_flag_exist("anim_reacted"))
    scripts\engine\utility::ent_flag_init("anim_reacted");

  scripts\engine\utility::ent_flag_clear("anim_reacted");
  childthread anim_react_damage();
  childthread anim_react_waittill("react");
  childthread anim_react_waittill("doFlashBanged");
  childthread anim_react_waittill("too_close");
  childthread anim_react_waittill("friend_died");
  childthread anim_react_waittill("friend_reacted");
  childthread anim_react_waittill("friend_pained");
  childthread anim_react_ai_events();
  childthread anim_react_radius();
  self waittill("anim_react_notify", var_0, var_1);

  if(isDefined(var_1))
    self.anim_react_event = var_1;

  scripts\engine\utility::ent_flag_set("anim_reacted");

  if(var_0 == "friend_died" || var_0 == "friend_pained")
    wait(randomfloatrange(0.2, 0.4));

  return var_0;
}

anim_react_damage() {
  self waittill("damage", var_0, var_1, var_2, var_3, var_4);
  self notify("anim_react_notify", "pain");
}

anim_react_waittill(var_0) {
  self waittill(var_0, var_1);
  self notify("anim_react_notify", var_0, var_1);
}

anim_react_radius() {
  self endon("anim_reacted");

  if(!isDefined(self.radius))
    self.radius = 72;

  var_0 = undefined;

  if(isDefined(self.target)) {
    var_1 = getEnt(self.target, "targetname");

    if(isDefined(var_1)) {
      if(var_1.code_classname == "trigger_multiple")
        var_0 = var_1;
    }
  }

  for(;;) {
    waitframe();

    if(distancesquared(level.player.origin, self.origin) < squared(self.radius)) {
      break;
    }

    if(!isDefined(var_0)) {
      continue;
    }
    if(level.player istouching(var_0)) {
      break;
    }
  }

  self notify("too_close");
}

force_high_reaction() {
  self aieventlistenerevent("cover_blown", self, self.origin);
}

force_low_reaction() {
  self aieventlistenerevent("investigate", self, self.origin);
}

anim_react_ai_events() {
  self endon("death");
  self endon("anim_reacted");

  for(;;) {
    level waittill("stealth_event", var_0, var_1);

    if(var_1 != self) {
      continue;
    }
    switch (var_0.type) {
      case "cover_blown":
      case "combat":
        self notify("anim_react_notify", "ai_event_high", var_0);
        return;
      case "investigate":
        self notify("anim_react_notify", "ai_event_low", var_0);
        return;
    }
  }
}

anim_react_alertgroup_msg(var_0, var_1) {
  if(!isDefined(self.alertgroupnames)) {
    return;
  }
  var_2 = undefined;

  if(isDefined(self.anim_react_event))
    var_2 = self.anim_react_event;

  if(var_1 == "pain")
    var_0 = "pained";
  else if(var_1 == "death")
    var_0 = "died";

  foreach(var_4 in self.alertgroupnames) {
    level.alertgroup[var_4] = scripts\engine\utility::array_removeundefined(level.alertgroup[var_4]);

    foreach(var_6 in level.alertgroup[var_4])
    var_6 notify("friend_" + var_0, var_2);
  }
}

anim_react_add_to_alertgroup(var_0) {
  if(!isDefined(level.alertgroup))
    level.alertgroup = [];

  if(!isDefined(level.alertgroup[var_0]))
    level.alertgroup[var_0] = [];

  level.alertgroup[var_0][level.alertgroup[var_0].size] = self;

  if(!isDefined(self.alertgroupnames))
    self.alertgroupnames = [];

  self.alertgroupnames[self.alertgroupnames.size] = var_0;
}

add_animents(var_0, var_1) {
  var_2 = var_0;

  foreach(var_4 in var_0) {
    if(!isDefined(var_4.animents)) {
      continue;
    }
    foreach(var_6 in var_4.animents) {
      if(!isDefined(level.scr_anim[var_6.animname])) {
        continue;
      }
      if(!isDefined(level.scr_anim[var_6.animname][var_1])) {
        continue;
      }
      var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

anim_single_with_props(var_0, var_1, var_2, var_3, var_4) {
  if(!isarray(var_0))
    var_0 = [var_0];

  var_0 = add_animents(var_0, var_1);
  scripts\common\anim::anim_single(var_0, var_1, var_2, var_3, var_4);
}

anim_loop_with_props(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isarray(var_0))
    var_0 = [var_0];

  var_0 = add_animents(var_0, var_1);
  scripts\common\anim::anim_loop(var_0, var_1, var_2, var_3, var_4, var_5);
}

anim_react_death(var_0, var_1, var_2) {
  var_1 endon("entitydeleted");
  var_1 endon("anim_react_done");
  var_1 endon("stop_anim_react_death");
  var_1 waittill("death");

  if(isDefined(var_2))
    var_1 thread[[var_2]]("death");

  if(isDefined(var_1.animents)) {
    foreach(var_4 in var_1.animents)
    var_4 thread prop_deathanim(var_0);
  }

  level thread detach_linkedaniments(var_1);
}

prop_deathanim(var_0) {
  self endon("death");

  if(!isDefined(self.deathanime)) {
    return;
  }
  if(!isDefined(level.scr_anim[self.animname][self.deathanime])) {
    return;
  }
  var_0 scripts\common\anim::anim_single_solo(self, self.deathanime);
}

detach_linkedaniments(var_0) {
  if(!isDefined(var_0.linkedaniments)) {
    return;
  }
  foreach(var_2 in var_0.linkedaniments)
  var_2 thread detach_linkedaniment(var_0);

  var_0.linkedaniments = undefined;
}

detach_linkedaniment(var_0) {
  var_1 = var_0 gettagorigin(self.parenttag);
  waitframe();

  if(!isDefined(var_0))
    var_2 = var_1 + (0, 0, 10);
  else
    var_2 = var_0 gettagorigin(self.parenttag);

  var_3 = vectorNormalize(var_2 - var_1);
  var_4 = var_3 * randomfloatrange(1, 2);
  self unlink();

  if(isDefined(self.nophysics)) {
    var_5 = scripts\engine\utility::drop_to_ground(self.origin, 16, -500);
    var_6 = distance(var_5, self.origin);
    var_7 = var_6 / 120;
    var_7 = max(var_7, 0.05);
    self moveTo(var_5, var_7, 0, var_7 - 0.05);
  } else {
    if(isDefined(self.children)) {
      foreach(var_9 in self.children) {
        var_9 unlink();
        var_10 = (0, 0, 1) * randomfloatrange(25, 60) + var_4;
        var_9 physicslaunchclient(var_9.origin + (0, 0, 1), var_10);
      }
    }

    if(isDefined(self.overridevelocity))
      var_4 = self.overridevelocity;

    self physicslaunchclient(var_2, var_4);
  }
}

primaryweapon_leave_behind(var_0, var_1) {
  var_2 = self gettagorigin(var_0);
  var_3 = self gettagangles(var_0);
  primaryweapon_leave_behind_internal(var_2, var_3, var_1);
}

primaryweapon_leave_behind_internal(var_0, var_1, var_2) {
  if(isDefined(self.gun_on_ground)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = spawn("weapon_" + createheadicon(self.weapon), var_0, var_2);
  var_3.angles = var_1;
  self.gun_on_ground = var_3;
  scripts\anim\shared.gsc::placeweaponon(self.weapon, "none");
  self.dropweapon = 0;
}