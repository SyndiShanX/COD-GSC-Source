/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\anim.gsc
***********************************************/

function init() {
  setdvarifuninitialized("scr_anim_react_debug", "0");
  scripts\common\anim::initanim();
  scripts\anim\notetracks_sp::registernotetracksifnot();
  scripts\anim\pain::initpainfx();
  scripts\anim\death::init_deathfx();
  anim.callbacks["PlaySoundAtViewHeight"] = &play_sound_at_viewheight;
  anim.callbacks["TeleportEnt"] = &teleport_entity;
  anim.callbacks["ShouldDoAnim"] = &should_do_anim;
  anim.callbacks["DoAnimation"] = &do_animation;
  anim.callbacks["DoFacialAnim"] = &do_facial_anim;
  anim.callbacks["StopAnimscripted"] = &scripts\engine\sp\utility::anim_stopanimscripted;
  anim.callbacks["AnimHandleNotetrack"] = &scripts\sp\anim_notetrack::sp_anim_handle_notetrack;
  anim.callbacks["EntityHandleNotetrack"] = &scripts\sp\anim_notetrack::entity_handle_notetrack;
  anim.callbacks["AIAnimFirstFrame"] = &ai_anim_first_frame;
  scripts\asm\asm::asm_globalinit();
  scripts\aitypes\bt_util::init();
  scripts\asm\asm::setup_level_ents();
  scripts\anim\animselector::init();

  if(!isDefined(level.notetrackmissionfailedvo)) {
    level.notetrackmissionfailedvo = 1;
  }

  if(!isDefined(level.notetrackvo)) {
    level.notetrackvo = 1;
    return;
  }
}

function anim_generic_gravity(var0, var1, var2) {
  var3 = var0.allowpain;
  var0 scripts\engine\utility::disable_pain();
  anim_generic_custom_animmode(var0, "gravity", var1, var2);

  if(var3) {
    var0 scripts\engine\utility::enable_pain();
    return;
  }
}

function anim_generic_reach(var0, var1, var2) {
  var3 = [];
  GscBinSkip0(0x2e, 0, var0);
}

function anim_generic_reach_and_arrive(var0, var1, var2, var3) {
  reach_and_arrive_internal(var0, var1, var2, var3, "generic");
}

function anim_reach_and_arrive(var0, var1, var2, var3) {
  reach_and_arrive_internal(var0, var1, var2, var3, var0.animname);
}

function reach_and_arrive_internal(var0, var1, var2, var3, var4) {
  if(scripts\sp\interaction::is_interact_struct(self) || scripts\sp\interaction::is_state_interact_struct(self)) {
    if(isDefined(self.script_reaction)) {
      var0.asm.customdata.interaction = self.script_reaction;
    } else {
      var0.asm.customdata.interaction = self.script_noteworthy;
    }

    var5 = scripts\sp\interaction::get_interaction(var0.asm.customdata.interaction);

    if(!isDefined(var5)) {
      var5 = scripts\sp\interaction::get_state_interaction(var0.asm.customdata.interaction);
    }

    var0.asm.customdata.arrivalstate = undefined;

    if(isDefined(var5)) {
      var0.asm.customdata.arrivalstate = var0 scripts\sp\interaction::get_arrivalstate_from_interaction(var5);
    }

    if(isDefined(var0.asm.customdata.arrivalstate)) {
      anim_reach_with_funcs([var0], var1, var2, var4, &reach_to_interact_begin, &reach_to_interact_end, var3);
      return;
    }

    anim_reach_with_funcs([var0], var1, var2, var4, &reach_with_arrivals_begin, &reach_with_standard_adjustments_end, var3);
    return;
  }

  anim_reach_with_funcs([var0], var1, var2, var4, &reach_with_arrivals_begin, &reach_with_standard_adjustments_end, var3);
}

function anim_reach_and_plant(var0, var1, var2) {
  anim_reach_with_funcs(var0, var1, var2, undefined, &reach_with_planting, &reach_with_standard_adjustments_end);
}

function anim_reach_and_plant_and_arrive(var0, var1, var2) {
  anim_reach_with_funcs(var0, var1, var2, undefined, &reach_with_planting_and_arrivals, &reach_with_standard_adjustments_end);
}

function anim_custom_animmode(var0, var1, var2, var3) {
  var4 = scripts\common\anim::get_anim_position(var3);
  var5 = var4["origin"];
  var6 = var4["angles"];
  var7 = undefined;

  foreach(var9 in var0) {
    var7 = var9;
    thread anim_custom_animmode_on_guy(var9, var1, var2, var5, var6, var9.animname, 0);
  }

  wait_until_anim_finishes(var7, var2);
  self notify(var2);
}

function anim_custom_animmode_loop(var0, var1, var2, var3) {
  var4 = scripts\common\anim::get_anim_position(var3);
  var5 = var4["origin"];
  var6 = var4["angles"];

  foreach(var8 in var0) {
    thread anim_custom_animmode_on_guy(var8, var1, var2, var5, var6, var8.animname, 1);
  }

  wait_until_anim_finishes(var0[0], var2);
  self notify(var2);
}

function wait_until_anim_finishes(var0) {
  self endon("finished_custom_animmode" + var0);
  self waittill("death");
}

function anim_generic_custom_animmode(var0, var1, var2, var3, var4, var5) {
  var6 = scripts\common\anim::get_anim_position(var3);
  var7 = var6["origin"];
  var8 = var6["angles"];
  thread anim_custom_animmode_on_guy(var0, var1, var2, var7, var8, "generic", 0, var4, var5);
  wait_until_anim_finishes(var0, var2);
  self notify(var2);
}

function anim_generic_custom_animmode_loop(var0, var1, var2, var3, var4, var5) {
  var6 = scripts\common\anim::get_anim_position(var3);
  var7 = var6["origin"];
  var8 = var6["angles"];
  thread anim_custom_animmode_on_guy(var0, var1, var2, var7, var8, "generic", 1, var4, var5);
  wait_until_anim_finishes(var0, var2);
  self notify(var2);
}

function anim_custom_animmode_solo(var0, var1, var2, var3) {
  var4 = [];
  GscBinSkip0(0x2e, 0, var0);
}

function anim_custom_animmode_loop_solo(var0, var1, var2, var3) {
  var4 = [];
  GscBinSkip0(0x2e, 0, var0);
}

function anim_custom_animmode_on_guy(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(isai(var0) && var0 scripts\engine\utility::doinglongdeath()) {
    return;
  }

  var9 = undefined;

  if(isDefined(var5)) {
    var9 = var5;
  } else {
    var9 = var0.animname;
  }

  if(!isDefined(var8) || !var8) {
    var0 scripts\common\anim::set_start_pos(var2, var3, var4, var5, var6);
  }

  var0._animmode = var1;
  var0._custom_anim = var2;
  var0._tag_entity = self;
  var0._anime = var2;
  var0._animname = var9;
  var0._custom_anim_loop = var6;
  var0._custom_anim_thread = var7;

  if(getdvarint("LPNQTQRRP", 0) == 1) {
    var0 scripts\asm\asm_sp::asm_animcustom(&scripts\anim\animmode::main, &scripts\asm\asm_sp::asm_stopanimcustom);
    return;
  }

  var0 animcustom(&scripts\anim\animmode::main);
}

function anim_single_gravity(var0, var1, var2) {
  foreach(var4 in var0) {
    var4 scripts\engine\utility::disable_pain();
  }

  anim_custom_animmode(var0, "gravity", var1, var2);

  foreach(var4 in var0) {
    if(isDefined(var4) && isalive(var4)) {
      var4 scripts\engine\utility::enable_pain();
    }
  }
}

function anim_single_run(var0, var1, var2, var3) {
  scripts\common\anim::anim_single_internal(var0, var1, var2, 0.25, var3);
}

function anim_reach_and_idle(var0, var1, var2, var3, var4) {
  thread anim_reach(var0, var1, var4);
  var5 = spawnStruct();
  var5.reachers = 0;

  foreach(var7 in var0) {
    var5.reachers++;
    thread idle_on_reach(var7, var2, var3, var4, var5);
  }

  for(;;) {
    var5 waittill("reached_position");

    if(var5.reachers <= 0) {
      return;
    }
  }
}

function wait_for_guy_to_die_or_get_in_position() {
  self endon("death");
  self waittill("anim_reach_complete");
}

function idle_on_reach(var0, var1, var2, var3, var4) {
  wait_for_guy_to_die_or_get_in_position(var0);
  var4.reachers--;
  var4 notify("reached_position");

  if(isalive(var0)) {
    scripts\common\anim::anim_loop_solo(var0, var1, var2, var3);
    return;
  }
}

function anim_reach_together(var0, var1, var2, var3) {
  thread modify_moveplaybackrate_together(var0);
  anim_reach_with_funcs(var0, var1, var2, var3, &reach_with_standard_adjustments_begin, &reach_with_standard_adjustments_end);
}

function modify_moveplaybackrate_together(var0) {
  var1 = 0.3;
  waittillframeend();

  for(;;) {
    var0 = scripts\engine\utility::array_removedead(var0);
    var2 = [];
    var3 = 0;

    foreach(var5 in var0) {
      var6 = var5.goalpos;

      if(isDefined(var5.reach_goal_pos)) {
        var6 = var5.reach_goal_pos;
      }

      var7 = distance(var5.origin, var6);
      var2 = var7;

      if(var7 <= 4) {
        var0[var8] = undefined;
        continue;
      }

      var3 += var7;
    }

    if(var0.size <= 1) {
      break;
    }

    var3 /= var0.size;

    foreach(var5 in var0) {
      var10 = var2[var5.unique_id] - var3;
      var11 = var10 * 0.003;

      if(var11 > var1) {
        var11 = var1;
      } else if(var11 < var1 * -1) {
        var11 = var1 * -1;
      }

      var5 scripts\asm\asm::asm_setmoveplaybackrate(1 + var11);
    }

    wait 0.05;
  }

  foreach(var5 in var0) {
    if(isalive(var5)) {
      var5 scripts\asm\asm::asm_setmoveplaybackrate(1);
    }
  }
}

function anim_reach_failsafe(var0, var1) {
  if(isarray(var0)) {
    foreach(var3 in var0) {
      thread anim_reach_failsafe(var3, var1);
    }

    return;
  }

  var3 = var3;
  var3 endon("new_anim_reach");
  wait var4;
  var3 notify("goal");
}

function anim_reach(var0, var1, var2, var3) {
  if(scripts\sp\interaction::is_interact_struct(self)) {
    foreach(var5 in var0) {
      if(isDefined(self.script_reaction)) {
        var5.asm.customdata.interaction = self.script_reaction;
        continue;
      }

      var5.asm.customdata.interaction = self.script_noteworthy;
    }

    anim_reach_with_funcs(var0, var1, var2, var3, &reach_to_interact_begin, &reach_to_interact_end);
    return;
  }

  anim_reach_with_funcs(var0, var1, var2, var3, &reach_with_standard_adjustments_begin, &reach_with_standard_adjustments_end);
}

function anim_reach_with_funcs(var0, var1, var2, var3, var4, var5, var6) {
  var7 = scripts\common\anim::get_anim_position(var2);
  var8 = var7["origin"];
  var9 = var7["angles"];
  var10 = spawnStruct();
  var11 = 0;
  var12 = 0;

  foreach(var14 in var0) {
    if(isDefined(var3)) {
      var15 = var3;
    } else {
      var15 = var14.animname;
    }

    if(isDefined(level.scr_anim[var15][var1])) {
      if(isarray(level.scr_anim[var15][var1])) {
        var16 = getstartorigin(var8, var9, level.scr_anim[var15][var1][0]);
        var17 = getstartangles(var8, var9, level.scr_anim[var15][var1][0]);
      } else {
        var16 = getstartorigin(var8, var9, level.scr_anim[var15][var1]);
        var17 = getstartangles(var8, var9, level.scr_anim[var15][var1]);
      }
    } else {
      var16 = var8;
      var17 = var9;
    }

    if(isDefined(var6)) {
      var14.scriptedarrivalent = spawn("script_origin", var16);
      var14.scriptedarrivalent.angles = var17;
      var14.scriptedarrivalent.type = var6;
      var14.scriptedarrivalent.arrivalstance = "stand";
      var14.forcenextpathfindimmediate = 1;
      var18 = var14 getmovingplatformparent();

      if(isDefined(var18)) {
        var14.scriptedarrivalent linkTo(var18);
      }
    }

    var12++;
    thread begin_anim_reach(var14, var10, var16, var17, var4);
  }

  while(var12) {
    var10 waittill("reach_notify");
    var12--;
  }

  foreach(var14 in var0) {
    var14.goalradius = var14.oldgoalradius;

    if(isDefined(var14.scriptedarrivalent)) {
      var14.scriptedarrivalent delete();
    }

    var14.stopanimdistsq = 0;
    LOC_000001d1:
  }
}

function anim_reach_cleanup_solo(var0) {
  if(!isalive(var0)) {
    return;
  }

  if(isDefined(var0.oldgoalradius)) {
    var0.goalradius = var0.oldgoalradius;
  }

  if(isDefined(var0.scriptedarrivalent)) {
    var0.scriptedarrivalent delete();
  }

  var0.disablearrivals = undefined;
  var0.stopanimdistsq = 0;
}

function anim_spawner_teleport(var0, var1, var2) {
  var3 = scripts\common\anim::get_anim_position(var2);
  var4 = var3["origin"];
  var5 = var3["angles"];
  var6 = spawnStruct();

  foreach(var8 in var0) {
    var9 = getstartorigin(var4, var5, level.scr_anim[var8.animname][var1]);
    var8.origin = var9;
  }
}

function reach_death_notify(var0) {
  scripts\engine\utility::waittill_either("death", "goal");

  while(isalive(self) && isDefined(self.asm) && isDefined(self.asm.arriving)) {
    wait 0.05;
  }

  var0 notify("reach_notify");
}

function begin_anim_reach(var0, var1, var2, var3, var4) {
  self endon("death");
  self endon("new_anim_reach");
  thread reach_death_notify(var0);
  var1 = [[var3]](var1, var2);
  scripts\engine\sp\utility::set_goal_pos(var1);
  self.reach_goal_pos = var1;
  self.goalradius = 0;
  self.stopanimdistsq = squared(120);
  self waittill("goal");
  self notify("anim_reach_complete");
  [[var4]]();
  self notify("new_anim_reach");
}

function reach_to_interact_begin(var0, var1) {
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
  var2 = scripts\sp\interaction::get_interaction(self.asm.customdata.interaction);

  if(!isDefined(var2)) {
    var2 = scripts\sp\interaction::get_state_interaction(self.asm.customdata.interaction);
  }

  self.asm.customdata.arrivalstate = scripts\sp\interaction::get_arrivalstate_from_interaction(var2);
  self.asm.customdata.arrivalangles = var1;
  self.asm.customdata.idlestate = scripts\sp\interaction::get_idlestate_from_interaction(var2);
  self.asm.customdata.arrivalusefootdown = 1;

  if(isDefined(var2.arrival_animmode)) {
    self.asm.customdata.custom_arrival_animmode = var2.arrival_animmode;
  }

  return var0;
}

function reach_with_standard_adjustments_begin(var0, var1) {
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
    self.scriptedarrivalent.angles = var1;
    self.scriptedarrivalent.origin = var0;
  }

  self.reach_goal_pos = undefined;
  return var0;
}

function reach_to_interact_end() {
  anim_changes_pushplayer(0);
  self.nododgemove = 0;
  self.doavoidanceblocking = 1;
  self.fixednode = self.fixednodewason;
  self.fixednodewason = undefined;
  self.pathenemyfightdist = self.oldpathenemyfightdist;
  self.pathenemylookahead = self.oldpathenemylookahead;
  self.disablearrivals = self.old_disablearrivals;
  var0 = scripts\sp\interaction::get_interaction(self.asm.customdata.interaction);

  if(!isDefined(var0)) {
    var0 = scripts\sp\interaction::get_state_interaction(self.asm.customdata.interaction);
  }

  self.asm.customdata.exitstate = scripts\sp\interaction::get_exitstate_from_interaction(var0);
  self.asm.customdata.interaction = undefined;
  self.asm.customdata.arrivalstate = undefined;
  self.asm.customdata.arrivalangles = undefined;
}

function reach_with_standard_adjustments_end() {
  anim_changes_pushplayer(0);
  self.nododgemove = 0;
  self.doavoidanceblocking = 1;
  self.fixednode = self.fixednodewason;
  self.fixednodewason = undefined;
  self.pathenemyfightdist = self.oldpathenemyfightdist;
  self.pathenemylookahead = self.oldpathenemylookahead;
  self.disablearrivals = self.old_disablearrivals;
}

function anim_changes_pushplayer(var0) {
  if(isDefined(self.dontchangepushplayer)) {
    return;
  }

  self pushplayer(var0);
}

function reach_with_arrivals_begin(var0, var1) {
  var0 = reach_with_standard_adjustments_begin(var0, var1);
  self.disablearrivals = 0;
  return var0;
}

function reach_with_planting(var0, var1) {
  var2 = self getdroptofloorposition(var0);
  var0 = var2;
  var0 = reach_with_standard_adjustments_begin(var0, var1);
  self.disablearrivals = 1;
  return var0;
}

function reach_with_planting_and_arrivals(var0, var1) {
  var2 = self getdroptofloorposition(var0);
  var0 = var2;
  var0 = reach_with_standard_adjustments_begin(var0, var1);
  self.disablearrivals = 0;
  return var0;
}

function anim_reach_and_idle_solo(var0, var1, var2, var3, var4) {
  self endon("death");
  GscBinSkip1(0x45, 0, var0);
}

function anim_reach_solo(var0, var1, var2) {
  self endon("death");
  GscBinSkip1(0x45, 0, var0);
}

function anim_reach_and_approach_solo(var0, var1, var2, var3) {
  self endon("death");
  GscBinSkip1(0x45, 0, var0);
}

function anim_reach_and_approach_node_solo(var0, var1, var2, var3, var4) {
  self endon("death");
  GscBinSkip1(0x45, 0, var0);
}

function anim_reach_and_approach(var0, var1, var2, var3) {
  self endon("death");

  if(scripts\sp\interaction::is_interact_struct(self)) {
    foreach(var5 in var0) {
      if(isDefined(self.script_noteworthy)) {
        var5.asm.customdata.interaction = self.script_noteworthy;
        continue;
      }

      var5.asm.customdata.interaction = self.script_reaction;
    }

    anim_reach_with_funcs(var0, var1, var2, undefined, &reach_to_interact_begin, &reach_to_interact_end, var3);
    return;
  }

  if(!isDefined(var3)) {
    var3 = "Exposed";
  }

  anim_reach_with_funcs(var0, var1, var2, undefined, &reach_with_arrivals_begin, &reach_with_standard_adjustments_end, var3);
}

function add_animation(var0, var1) {
  if(!isDefined(level.completedanims)) {
    level.completedanims[var0][0] = var1;
    return;
  }

  if(!isDefined(level.completedanims[var0])) {
    level.completedanims[var0][0] = var1;
    return;
  }

  for(var2 = 0; var2 < level.completedanims[var0].size; var2++) {
    if(level.completedanims[var0][var2] == var1) {
      return;
    }
  }

  level.completedanims[var0][level.completedanims[var0].size] = var1;
}

function anim_single_queue(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(isDefined(var0.last_queue_time)) {
    scripts\engine\sp\utility::wait_for_buffer_time_to_pass(var0.last_queue_time, 0.5);
  }

  scripts\engine\sp\utility::function_stack(&scripts\common\anim::anim_single_solo, var0, var1, var2, var3);

  if(isalive(var0)) {
    var0.last_queue_time = gettime();
    return;
  }
}

function anim_generic_queue(var0, var1, var2, var3, var4) {
  var0 endon("death");

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(isDefined(var0.last_queue_time)) {
    scripts\engine\sp\utility::wait_for_buffer_time_to_pass(var0.last_queue_time, 0.5);
  }

  if(isDefined(var4)) {
    scripts\engine\sp\utility::function_stack_timeout(var4, &scripts\common\anim::anim_single_solo, var0, var1, var2, var3, "generic");
  } else {
    scripts\engine\sp\utility::function_stack(&scripts\common\anim::anim_single_solo, var0, var1, var2, var3, "generic");
  }

  if(isalive(var0)) {
    var0.last_queue_time = gettime();
    return;
  }
}

function anim_dontpushplayer(var0) {
  foreach(var2 in var0) {
    var2 pushplayer(0);
  }
}

function anim_pushplayer(var0) {
  foreach(var2 in var0) {
    var2 pushplayer(1);
  }
}

function anim_facialanim(var0, var1, var2) {
  var0 endon("death");
  self endon(var1);
  var3 = 0.05;
  var0 notify("newLookTarget");
  scripts\asm\shared\utility::disabledefaultfacialanims();
  waittillframeend();

  if(!isDefined(self.scriptedtalkingknob)) {
    self.scriptedtalkingknob = scripts\asm\asm::asm_getxanim("knobs", scripts\asm\asm::asm_lookupanimfromalias("knobs", "scripted_talking"));
  }

  var4 = "scripted_face_" + var1;
  var0 setanim(self.scriptedtalkingknob, 1, 0.2);
  var0 setflaggedanimknobrestart(var4, var2, 1, 0, 1);
  thread facial_notetrack_handler(var0, var4, var1);
  thread clearfaceanimonanimdone(var0, var4, var1);
}

function facial_notetrack_handler(var0, var1, var2) {
  self endon(var2);
  var0 endon("death");
  var0 endon("stop_loop");
  var0 endon("scripted_face_done");

  for(;;) {
    self waittill(var1, var3);

    foreach(var5 in var3) {
      var6 = getsubstr(var5, 0, 3);

      if(var6 == "vo_") {
        var7 = getsubstr(var5, 3);

        if(!issentient(self)) {
          thread scripts\engine\sp\utility::play_sound_on_tag(var7, "j_head", 1, var7);
        } else {
          play_sound_at_viewheight(var7, "face_sounddone", 1);
        }

        continue;
      }

      if(var6 == "pvo") {
        var7 = getsubstr(var5, 4);
        thread scripts\engine\sp\utility::smart_player_dialogue(var7);
      }
    }
  }
}

function anim_facialfiller(var0, var1) {
  self endon("death");

  if(isai(self) && !isalive(self)) {
    return;
  }

  if(!isai(self)) {
    if(!isDefined(self.fakeactor_face_anim)) {
      return;
    } else if(!self.fakeactor_face_anim || !isalive(self)) {
      return;
    }
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

  var2 = 0.05;
  self notify("newLookTarget");
  self endon("newLookTarget");
  waittillframeend();

  if(!isDefined(var1) && isDefined(self.bc_looktarget)) {
    var1 = self.bc_looktarget;
  }

  var3 = "";

  if(isDefined(self.asm)) {
    var3 = self.asm.archetype;
  }

  if(isDefined(self.animationarchetype)) {
    var3 = self.animationarchetype;
  }

  var4 = self.defaulttalk;
  var5 = self.scriptedtalkingknob;
  scripts\asm\shared\utility::setfacialstate("filler");

  if(var3 != "") {
    if(isai(self)) {
      self setfacialindex("talk");
    } else {
      scripts\asm\shared\utility::setfacialindexfornonai("talk");
    }
  } else {
    self setanimknoblimitedrestart(var4, 1, 0, 1);
    self setanim(var5, 5, 0.267);
  }

  set_talker_until_msg(var0);
  var2 = 0.3;

  if(var3 != "" && isai(self)) {
    self setfacialindex("none");
  } else {
    scripts\asm\shared\utility::setfacialindexfornonai("none");
  }

  scripts\asm\shared\utility::clearfacialstate("filler");
}

function set_talker_until_msg(var0) {
  self waittill(var0);
}

function talk_for_time(var0) {
  self endon("death");
  var1 = self.defaulttalk;
  self setanimknoblimitedrestart(var1, 1, 0, 1);
  self setanim(self.scriptedtalkingknob, 5, 0.4);
  scripts\asm\shared\utility::disabledefaultfacialanims();
  wait var0;
  var2 = 0.3;
  self clearanim(self.scriptedtalkingknob, 0.2);
  scripts\asm\shared\utility::disabledefaultfacialanims(0);
}

function anim_reach_idle(var0, var1, var2) {
  var3 = spawnStruct();
  var3.count = var0.size;

  foreach(var5 in var0) {
    thread reachidle(var5, var1, var2, var3);
  }

  while(var3.count) {
    var3 waittill("reached_goal");
  }

  self notify("stopReachIdle");
}

function reachidle(var0, var1, var2, var3) {
  anim_reach_solo(var0, var1);
  var3.count--;
  var3 notify("reached_goal");

  if(var3.count > 0) {
    scripts\common\anim::anim_loop_solo(var0, var2, "stopReachIdle");
    return;
  }
}

function clearfaceanimonanimdone(var0, var1, var2) {
  var0 endon("death");
  var0 waittillmatch(var1, "end");
  var0 notify("scripted_face_done");
  var3 = 0.3;
  var0 clearanim(self.scriptedtalkingknob, 0.2);
  scripts\asm\shared\utility::disabledefaultfacialanims(0);
}

function anim_set_rate_single(var0, var1, var2) {
  thread anim_set_rate_internal(var0, var1);
}

function anim_set_rate(var0, var1, var2) {
  scripts\engine\utility::array_thread(var0, &anim_set_rate_internal, var1, var2);
}

function anim_set_rate_internal(var0, var1, var2) {
  var3 = undefined;

  if(isDefined(var2)) {
    var3 = var2;
  } else {
    var3 = self.animname;
  }

  self setflaggedanim("single anim", scripts\engine\utility::getanim_from_animname(var0, var3), 1, 0, var1);
}

function create_anim_scene(var0, var1, var2, var3, var4) {
  if(!isDefined(var3)) {
    var3 = "generic";
  } else {
    level.scr_animtree[var3] = var0;
  }

  var5 = spawnStruct();
  var5.animtree = var0;
  var5.model = var4;

  if(isDefined(var4)) {
    level.scr_model[var3] = var4;
  }

  if(isDefined(var2)) {
    level.scr_anim[var3][var1] = var2;
  }

  var5.animname = var3;
  var5.anim_sequence = var1;
  level.current_anim_data_scene = var5;
}

function blended_loop_solo(var0, var1, var2, var3) {
  var0.anim_array = var2;
  var0.ender = var3;
  var0.gesture_lookat = var1;
  var0.animnode = self;
  var0 scripts\asm\asm_sp::asm_animcustom(&scripts\asm\gesture\script_funcs::blended_loop_anim, &scripts\asm\gesture\script_funcs::blended_loop_cleanup);
}

function blended_anim_solo(var0, var1, var2) {
  while(isDefined(var0.anim_array)) {
    wait 0.05;
  }

  var0.anim_array = var2;
  var0.gesture_lookat = var1;
  var0.animnode = self;
  var0 scripts\asm\asm_sp::asm_animcustom(&scripts\asm\gesture\script_funcs::blended_anim);
}

function anim_block_in_single(var0, var1, var2) {
  foreach(var4 in var0) {
    thread anim_block_in_internal(var4, var1, var2);
  }
}

function anim_block_in_solo(var0, var1, var2) {
  thread anim_block_in_internal(var0, var1, var2);
}

function anim_block_in_internal(var0, var1, var2) {
  var0 endon("death");
  var0 endon("stop_blockin");
  var3 = var0.animname;
  var0 scripts\common\anim::assert_existance_of_anim(var1, var3);

  if(isDefined(level.scr_blockin[var3]) && isDefined(level.scr_blockin[var3][var1])) {
    var4 = scripts\engine\utility::getStruct(level.scr_blockin[var3][var1], "targetname");
  } else {
    return;
  }

  if(!isDefined(var2)) {
    var2 = 50;
  }

  var5 = spawn("script_model", var0.origin);
  var5.angles = var0.angles;
  var5 setModel("tag_origin");
  var6 = var0.ignoreall;
  var7 = var0.ignoreme;
  thread anim_block_in_cleanup_internal(var0, var5, var6);
  var8 = distance(var0.origin, var4.origin);
  var9 = var8 / var2;

  if(isPlayer(var0)) {
    var0 playerlinktoabsolute(var5);
  } else if(isai(var0)) {
    var0 animcustom(&t_poser);
    var0 linkTo(var5, "tag_origin", (0, 0, 0), (0, 0, 0));
    var0.ignoreall = 1;
  } else {
    var0 linkTo(var5, "tag_origin", (0, 0, 0), (0, 0, 0));
    var0.ignoreall = 1;
  }

  var0.ignoreme = 1;
  var9 = scripts\engine\utility::ter_op(var9 == 0, 0.05, var9);
  var10 = 0.05;
  var5 moveTo(var4.origin, var10);
  var5 rotateTo(vectortoangles(var4.origin - var5.origin), var10);

  if(isai(var0)) {
    if(!isDefined(var4.angles)) {
      var0 orientmode("face point", var4.origin);
    } else {
      var0 orientmode("face angle", var4.angles[1]);
    }
  }

  var5 waittill("movedone");
  var4 scripts\engine\utility::script_wait();

  while(isDefined(var4.target)) {
    var11 = scripts\engine\utility::getStruct(var4.target, "targetname");

    if(isDefined(var4.script_speed)) {
      var2 = var4.script_speed;
    }

    var4 scripts\engine\utility::script_delay();
    var4 = var11;
    var8 = distance(var0.origin, var4.origin);
    var9 = var8 / var2;
    var5 moveTo(var4.origin, var9);

    if(isDefined(var4.angles)) {
      var5 rotateTo(var4.angles, var9);

      if(isai(var0)) {
        var0 orientmode("face angle", var4.angles[1]);
      }
    } else {
      var5 rotateTo(vectortoangles(var11.origin - var5.origin), var9);

      if(isai(var0)) {
        var0 orientmode("face point", var11.origin);
      }
    }

    var5 waittill("movedone");
    var4 scripts\engine\utility::script_wait();
  }

  var0 notify("tposer done");
}

function t_poser() {
  self animmode("noclip");
  scripts\engine\utility::waittill_any("tposer done", "stop_blockin");
}

function anim_block_in_cleanup_internal(var0, var1, var2) {
  scripts\engine\utility::waittill_any("tposer done", "stop_blockin", "death");
  self unlink();

  if(isai(self)) {
    self.ignoreall = var1;
  }

  self.ignoreme = var2;
  var0 delete();
}

function should_do_anim() {
  return !isai(self) || !scripts\engine\utility::doinglongdeath();
}

function teleport_entity(var0, var1) {
  if(isai(self)) {
    if(isDefined(self.anim_start_at_groundpos)) {
      var0 = scripts\engine\utility::drop_to_ground(var0);
    }

    self forceteleport(var0, var1, 9999);
    return;
  }

  if(isDefined(self.vehicletype)) {
    self vehicle_teleport(var0, var1);
    self dontinterpolate();
    return;
  }

  self.origin = var0;
  self.angles = var1;
  self dontinterpolate();
}

function play_sound_at_viewheight(var0, var1, var2) {
  if(isDefined(var1) && isDefined(var2)) {
    self playsoundatviewheight(var0, var1, var2);
  } else if(isDefined(var1)) {
    self playsoundatviewheight(var0, var1);
  } else {
    self playsoundatviewheight(var0);
  }

  if(isDefined(var1)) {
    self.scripteddialoguenotify = gettime();
  } else {
    self.scripteddialoguenonotify = gettime();
  }

  thread bcs_scripted_dialog_clear(var0, var1);
}

function bcs_scripted_dialog_clear(var0, var1) {
  self endon("death");

  if(isDefined(var1)) {
    self waittill(var1);
    self.scripteddialoguenotify = undefined;
    return;
  }

  var2 = lookupsoundlength(var0) * 0.001;
  wait var2;
  self.scripteddialoguenonotify = undefined;
}

function do_facial_anim(var0, var1, var2, var3, var4, var5, var6) {
  if(var0 && !var6) {
    if(var1) {
      thread scripts\anim\face::sayspecificdialogue(var5);
    }

    thread anim_facialanim(self, var3, level.scr_face[var4][var3]);
    return true;
  } else if(isai(self) || isDefined(self.fakeactor_face_anim) && self.fakeactor_face_anim) {
    if(var2) {
      scripts\anim\face::sayspecificdialogue(var5);
    } else {
      if(!var6) {
        thread anim_facialfiller("single dialogue");
      }

      scripts\anim\face::sayspecificdialogue(var5, "single dialogue");
    }
  } else {
    thread scripts\engine\sp\utility::play_sound_on_entity(var5, "single dialogue");
  }

  return false;
}

#using_animtree("animscripted_default_headlook");

function do_animation(var0, var1, var2, var3, var4, var5) {
  var6 = undefined;

  if(isDefined(var5)) {
    var6 = level.scr_anim[var2][var3][var5];
  } else {
    var6 = level.scr_anim[var2][var3];
  }

  var7 = scripts\common\anim::anim_get_goal_time(var2, var3);
  scripts\common\anim::last_anim_time_check();

  if(!isDefined(var5)) {
    self._lastanime = var3;
  }

  if(self.code_classname == "misc_turret" && !isDefined(var5)) {
    self setflaggedanim(var4, var6, 1, var7);
  } else {
    var8 = undefined;

    if(isai(self) || scripts\sp\fakeactor::is_fakeactor()) {
      var8 = scripts\asm\asm::asm_getbodyknob();
    } else if(isDefined(self.anim_getrootfunc)) {
      var8 = [[self.anim_getrootfunc]]();
    }

    if(isDefined(self.asm) && !isai(self)) {
      scripts\asm\asm_sp::asm_animScripted();
    }

    var9 = [-90, 90, -60, 60];
    var10 = % lookatpos_animscripted_default;

    if(isDefined(level.scr_lookat) && isDefined(level.scr_lookat[var2]) && isDefined(level.scr_lookat[var2][var3])) {
      var9 = level.scr_lookat[var2][var3].ranges;
      var10 = level.scr_lookat[var2][var3].atr_node;
    }

    self animScripted(var4, var0, var1, var6, undefined, var8, var7, 1, var9[0], var9[1], var9[2], var9[3], var10);
  }

  thread scripts\common\notetrack::start_notetrack_wait(self, var4, var3, var2, var6);
  thread animscriptdonotetracksthread(self, var4, var3);
  return getanimlength(var6);
}

function animscriptdonotetracksthread(var0, var1, var2) {
  if(isDefined(var0.dontdonotetracks) && var0.dontdonotetracks) {
    return;
  }

  var0 endon("stop_sequencing_notetracks");
  var0 endon("death");
  var0 scripts\anim\notetracks::donotetracks(var1);
}

function ai_anim_first_frame(var0, var1) {
  self._first_frame_anim = var0;
  self._animname = var1;
  scripts\asm\asm_sp::asm_animcustom(&scripts\anim\first_frame::main);
}

function anim_react_new(var0, var1, var2) {
  var3 = spawnStruct();

  if(!isarray(var0)) {
    var0 = [var0];
  }

  var3.guys = var0;
  var3.node = var1;
  var3.anime = var2;
  return var3;
}

function anim_react(var0, var1, var2, var3) {
  var4 = anim_react_new(var0, self, var1);
  var4.fnreact = var2;
  var4.gotocombatonly = var3;
  anim_react_data(var4);
}

function anim_react_data(var0) {
  scripts\engine\utility::array_thread(var0.guys, &anim_react_thread, var0);
  var1 = var0.anime;

  foreach(var3 in var0.guys) {
    var4 = var1 + "_death";

    if(isDefined(level.scr_anim[var3.animname][var4])) {
      var3 scripts\engine\sp\utility::set_deathanim(var4);
    }

    if(isDefined(var3.animents)) {
      foreach(var6 in var3.animents) {
        if(isDefined(level.scr_anim[var6.animname][var4])) {
          var6.deathanime = var4;
        }
      }
    }

    thread anim_react_death(level, var0.node, var3);
  }

  var9 = var1 + "_intro";

  if(isDefined(level.scr_anim[var0.guys[0].animname][var9])) {
    anim_single_with_props(var0.node, var0.guys, var9);
  }

  var10 = var1 + "_loop";
  var11 = var1 + "_outro";

  foreach(var3 in var0.guys) {
    if(var3 scripts\engine\utility::ent_flag("anim_reacted")) {
      continue;
    }

    if(isDefined(level.scr_anim[var3.animname][var10])) {
      thread anim_loop_with_props(var0.node, var3, var10);
      continue;
    }

    if(isDefined(level.scr_anim[var3.animname][var11])) {
      thread anim_single_with_props(var0.node, var3);
      var3 thread scripts\engine\utility::waittillmatch_notify("single anim", "end", "outro_anim_end");
      var3 scripts\engine\utility::thread_on_notify("outro_anim_end", &scripts\engine\utility::send_notify, "stop_anim_react", undefined, undefined, var3, "anim_react");
      continue;
    }

    var3 notify("stop_anim_react");
    var3 notify("stop_anim_react_death");
    LOC_000001fc:
  }
}

function anim_react_thread(var0) {
  self endon("death");
  self notify("stop_anim_react");
  self endon("stop_anim_react");
  var1 = anim_react_wait_thread();
  anim_react_alertgroup_msg("reacted", var1);
  self notify("anim_react");
  var0.node notify("anim_react");

  if(!istrue(self.anim_react_skip_stopanimscripted)) {
    var0.node notify("stop_anim_loop_" + self.animname);
    scripts\engine\sp\utility::anim_stopanimScripted();
  }

  var2 = 0;

  if(isDefined(var0.fnreact)) {
    var3 = self[[var0.fnreact]](var1);

    if(isDefined(var3)) {
      if(var3 == "skip_reaction") {
        var2 = 1;
      } else {
        var1 = var3;
      }
    }
  }

  if(!var2) {
    var4 = get_react_type(var1);
    var5 = var0.anime;
    var6 = undefined;

    if(isDefined(var0.fnreactanime)) {
      var6 = [[var0.fnreactanime]](var1);
    }

    if(var1 == "pain") {
      var6 = var5 + "_react_pain";

      if(isDefined(level.scr_anim[self.animname][var6])) {
        self.allowdeath = 1;

        if(!isDefined(self.animreactrelative)) {
          anim_single_with_props(var0.node, self, var6);
        } else {
          anim_single_with_props(self, var6);
        }
      } else if(isDefined(self.script_stealthgroup)) {
        scripts\stealth\enemy::bt_set_stealth_state("combat");
      }
    } else {
      thread detach_linkedaniments(level);

      if(!isDefined(var6)) {
        var6 = var5 + "_react_" + var4;
      }

      if(!isDefined(level.scr_anim[self.animname][var6])) {
        var6 = var5 + "_react";
      }

      if(isDefined(level.scr_anim[self.animname][var6])) {
        self.allowdeath = 1;

        if(!isDefined(self.animreactrelative)) {
          anim_single_with_props(var0.node, self, var6);
        } else {
          anim_single_with_props(self, var6);
        }
      }

      var7 = var6 + "_loop";

      if(isDefined(level.scr_anim[self.animname][var7])) {
        if(!isDefined(self.animreactrelative)) {
          anim_loop_with_props(var0.node, self, var7);
        } else {
          anim_loop_with_props(self, var7);
        }
      }

      if(isDefined(self.script_stealthgroup) && istrue(var0.gotocombatonly)) {
        scripts\stealth\enemy::bt_set_stealth_state("combat");
      }
    }
  }

  self notify("anim_react_done");

  if(isDefined(self.target)) {
    scripts\sp\spawner::go_to_node();
  }

  if(!isDefined(self.script_forcegoal)) {
    self.goalradius = level.default_goalradius;
    return;
  }
}

function get_react_type(var0) {
  switch (var0) {
    case "ai_event_low":
      return "low";
    default:
      return "high";
  }
}

function anim_react_wait_thread() {
  self endon("death");
  self endon("stop_anim_react");

  if(!scripts\engine\utility::ent_flag_exist("anim_reacted")) {
    scripts\engine\utility::ent_flag_init("anim_reacted");
  }

  scripts\engine\utility::ent_flag_clear("anim_reacted");
  GscBinSkip4(0x35);
}

function anim_react_damage() {
  self waittill("damage", var0, var1, var2, var3, var4);
  self notify("anim_react_notify", "pain");
}

function anim_react_waittill(var0) {
  self waittill(var0, var1);
  self notify("anim_react_notify", var0, var1);
}

function anim_react_radius() {
  self endon("anim_reacted");

  if(!isDefined(self.radius)) {
    self.radius = 72;
  }

  var0 = undefined;

  if(isDefined(self.target)) {
    var1 = getEnt(self.target, "targetname");

    if(isDefined(var1)) {
      if(var1.code_classname == "trigger_multiple") {
        var0 = var1;
      }
    }
  }

  for(;;) {
    waitframe();

    if(distancesquared(level.player.origin, self.origin) < squared(self.radius)) {
      break;
    }

    if(!isDefined(var0)) {
      continue;
    }

    if(level.player istouching(var0)) {
      break;
    }
  }

  self notify("too_close");
}

function force_high_reaction() {
  self aieventlistenerevent("cover_blown", self, self.origin);
}

function force_low_reaction() {
  self aieventlistenerevent("investigate", self, self.origin);
}

function anim_react_ai_events() {
  self endon("death");
  self endon("anim_reacted");

  for(;;) {
    level waittill("stealth_event", var0, var1);

    if(var1 != self) {
      continue;
    }

    switch (var0.type) {
      case "cover_blown":
      case "combat":
        self notify("anim_react_notify", "ai_event_high", var0);
        return;
      case "investigate":
        self notify("anim_react_notify", "ai_event_low", var0);
        return;
    }
  }
}

function anim_react_alertgroup_msg(var0, var1) {
  if(!isDefined(self.alertgroupnames)) {
    return;
  }

  var2 = undefined;

  if(isDefined(self.anim_react_event)) {
    var2 = self.anim_react_event;
  }

  if(var1 == "pain") {
    var0 = "pained";
  } else if(var1 == "death") {
    var0 = "died";
  }

  foreach(var4 in self.alertgroupnames) {
    level.alertgroup[var4] = scripts\engine\utility::array_removeundefined(level.alertgroup[var4]);

    foreach(var6 in level.alertgroup[var4]) {
      var6 notify("friend_" + var0, var2);
    }
  }
}

function anim_react_add_to_alertgroup(var0) {
  if(!isDefined(level.alertgroup)) {
    level.alertgroup = [];
  }

  if(!isDefined(level.alertgroup[var0])) {
    level.alertgroup[var0] = [];
  }

  level.alertgroup[var0][level.alertgroup[var0].size] = self;

  if(!isDefined(self.alertgroupnames)) {
    self.alertgroupnames = [];
  }

  self.alertgroupnames[self.alertgroupnames.size] = var0;
}

function add_animents(var0, var1) {
  var2 = var0;

  foreach(var4 in var0) {
    if(!isDefined(var4.animents)) {
      continue;
    }

    foreach(var6 in var4.animents) {
      if(!isDefined(level.scr_anim[var6.animname])) {
        continue;
      }

      if(!isDefined(level.scr_anim[var6.animname][var1])) {
        continue;
      }

      var2 = var6;
    }
  }

  return var2;
}

function anim_single_with_props(var0, var1, var2, var3, var4) {
  if(!isarray(var0)) {
    var0 = [var0];
  }

  var0 = add_animents(var0, var1);
  scripts\common\anim::anim_single(var0, var1, var2, var3, var4);
}

function anim_loop_with_props(var0, var1, var2, var3, var4, var5) {
  if(!isarray(var0)) {
    var0 = [var0];
  }

  var0 = add_animents(var0, var1);
  scripts\common\anim::anim_loop(var0, var1, var2, var3, var4, var5);
}

function anim_react_death(var0, var1, var2) {
  var1 endon("entitydeleted");
  var1 endon("anim_react_done");
  var1 endon("stop_anim_react_death");
  var1 waittill("death");

  if(isDefined(var2)) {
    var1 thread[[var2]]("death");
  }

  if(isDefined(var1.animents)) {
    foreach(var4 in var1.animents) {
      thread prop_deathanim(var4);
    }
  }

  thread detach_linkedaniments(level);
}

function prop_deathanim(var0) {
  self endon("death");

  if(!isDefined(self.deathanime)) {
    return;
  }

  if(!isDefined(level.scr_anim[self.animname][self.deathanime])) {
    return;
  }

  var0 scripts\common\anim::anim_single_solo(self, self.deathanime);
}

function detach_linkedaniments(var0) {
  if(!isDefined(var0.linkedaniments)) {
    return;
  }

  foreach(var2 in var0.linkedaniments) {
    thread detach_linkedaniment(var2);
  }

  var0.linkedaniments = undefined;
}

function detach_linkedaniment(var0) {
  var1 = var0 gettagorigin(self.parenttag);
  waitframe();

  if(!isDefined(var0)) {
    var2 = var1 + (0, 0, 10);
  } else {
    var2 = var1 gettagorigin(self.parenttag);
  }

  var3 = vectorNormalize(var2 - var2);
  var4 = var3 * randomfloatrange(1, 2);
  self unlink();

  if(isDefined(self.nophysics)) {
    var5 = scripts\engine\utility::drop_to_ground(self.origin, 16, -500);
    var6 = distance(var5, self.origin);
    var7 = var6 / 120;
    var7 = max(var7, 0.05);
    self moveTo(var5, var7, 0, var7 - 0.05);
    return;
  }

  if(isDefined(self.children)) {
    foreach(var9 in self.children) {
      var9 unlink();
      var10 = (0, 0, 1) * randomfloatrange(25, 60) + var4;
      var9 physicslaunchclient(var9.origin + (0, 0, 1), var10);
    }
  }

  if(isDefined(self.overridevelocity)) {
    var4 = self.overridevelocity;
  }

  self physicslaunchclient(var2, var4);
}

function primaryweapon_leave_behind(var0, var1) {
  var2 = self gettagorigin(var0);
  var3 = self gettagangles(var0);
  primaryweapon_leave_behind_internal(var2, var3, var1);
}

function primaryweapon_leave_behind_internal(var0, var1, var2) {
  if(isDefined(self.gun_on_ground)) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var3 = spawn("weapon_" + createheadicon(self.weapon), var0, var2);
  var3.angles = var1;
  self.gun_on_ground = var3;
  scripts\anim\shared::placeweaponon(self.weapon, "none");
  self.dropweapon = 0;
}