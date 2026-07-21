/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\highway\highway_utility.gsc
***********************************************/

ai_setname(var_0, var_1) {
  var_0.name = var_1;
}

ai_takecoveratnearestnodeinarray(var_0) {
  var_1 = sortbydistance(var_0, self.origin)[0];
  self setgoalnode(var_1);
  return var_1;
}

ai_resetstances() {
  self allowedstances("stand", "crouch", "prone");
}

ai_isalive(var_0) {
  if(!isDefined(var_0))
    return 0;

  if(!isalive(var_0))
    return 0;

  if(var_0 scripts\engine\utility::doinglongdeath())
    return 0;

  return 1;
}

ai_getaliveaiarray(var_0) {
  if(isDefined(var_0))
    var_1 = getaiarray(var_0);
  else
    var_1 = getaiarray();

  var_1 = array_removedeaddyingorundefined(var_1);
  return var_1;
}

ai_getstance() {
  return self.currentpose;
}

ai_waittillinstance(var_0) {
  while(ai_getstance() != var_0)
    waitframe();
}

ai_instantlyremovefromvehicle(var_0) {
  var_0._blackboard.currentvehicle = undefined;
  var_0.ridingvehicle = undefined;
  var_0 unlink();
}

ai_getanimationstartorigin(var_0, var_1, var_2) {
  var_3 = var_0 scripts\engine\utility::getanim(var_1);

  if(isarray(var_3))
    var_3 = var_3[0];

  var_4 = getstartorigin(var_2.origin, var_2.angles, var_3);
  return var_4;
}

ai_getanimationstartangles(var_0, var_1, var_2) {
  var_3 = var_0 scripts\engine\utility::getanim(var_1);

  if(isarray(var_3))
    var_3 = var_3[0];

  var_4 = getstartangles(var_2.origin, var_2.angles, var_3);
  return var_4;
}

ai_getanimationfinalorigin(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0.origin);
  var_3.angles = var_0.angles;
  var_3.animname = var_0.animname;
  var_3 setModel(var_0.model);
  var_3 scripts\common\anim::setanimtree();
  var_3 hide();
  var_2 scripts\common\anim::anim_first_frame_solo(var_3, var_1);
  var_2 scripts\common\anim::anim_set_time_solo(var_3, var_1, 1.0);
  var_4 = var_3 scripts\engine\utility::getanim(var_1);
  var_5 = getmovedelta(var_4);
  var_6 = getangledelta3d(var_4);
  var_7 = rotatevector(var_5, var_3.angles);
  var_8 = var_3.origin + var_7;
  var_3 delete();
  return var_8;
}

ai_getanimationfinalangles(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0.origin);
  var_3.angles = var_0.angles;
  var_3.animname = var_0.animname;
  var_3 setModel(var_0.model);
  var_3 scripts\common\anim::setanimtree();
  var_3 hide();
  var_2 scripts\common\anim::anim_first_frame_solo(var_3, var_1);
  var_2 scripts\common\anim::anim_set_time_solo(var_3, var_1, 1.0);
  var_4 = var_3 scripts\engine\utility::getanim(var_1);

  if(isarray(var_4))
    var_4 = var_4[0];

  var_5 = getmovedelta(var_4);
  var_6 = getangledelta3d(var_4);
  var_7 = combineangles(var_3.angles, var_6);
  var_3 delete();
  return var_7;
}

ai_setaimassist(var_0) {
  if(var_0)
    self actoraimassiston();
  else
    self actoraimassistoff();
}

ai_attachhead(var_0, var_1) {
  if(isDefined(var_0.headmodel))
    var_0 detach(var_0.headmodel);

  var_0.headmodel = var_1;
  var_0 attach(var_0.headmodel, "", 1);
}

ai_iscivilian(var_0) {
  return var_0.asmname == "civilian";
}

ai_movealongpath(var_0, var_1, var_2, var_3) {
  ai_endpathlogic(var_0);
  var_0 endon("death");
  var_0 endon("ai_pathEndLogic");

  if(istrue(var_2)) {
    var_4 = level_objectivegetindex();
    level_objectiveadd("Follow " + var_0.name, var_0.origin, "Follow");
    objective_onentity(var_4, var_0);
    objective_setzoffset(var_4, 75);
    thread ai_movealongpathcleanupobjectivelogic(var_0, var_4);
  } else
    var_4 = undefined;

  var_5 = 0;

  if(istrue(var_3))
    childthread ai_pathplayerfollowaispeedscaling(var_0, var_1);

  while(isDefined(var_1)) {
    var_6 = ai_pathgetnextnodesarray(var_1);
    var_0 setgoalpath(var_6);

    foreach(var_22, var_8 in var_6) {
      var_0 notify("ai_pathNextNode");

      if(isDefined(var_8.script_radius))
        var_0.goalradius = var_8.script_radius;

      if(isDefined(var_8.script_do_arrivals))
        var_0.disablearrivals = !var_8.script_do_arrivals;

      if(isDefined(var_8.script_do_exits))
        var_0.disableexits = !var_8.script_do_exits;

      var_0 waittill("subgoal");

      if(isDefined(var_8.script_demeanor)) {
        if(var_8.script_demeanor == "clear")
          var_0 scripts\common\utility::clear_demeanor_override();
        else
          var_0 scripts\common\utility::demeanor_override(var_8.script_demeanor);
      }

      if(isDefined(var_8.script_civilian_state))
        var_0 scripts\asm\asm_bb::bb_setcivilianstate(var_8.script_civilian_state);

      if(isDefined(var_8.script_stance)) {
        if(var_8.script_stance == "clear")
          var_0 ai_resetstances();
        else {
          var_0 allowedstances(var_8.script_stance);

          while(var_0 ai_getstance() != var_8.script_stance)
            waitframe();
        }
      }

      if(isDefined(var_8.script_moveplaybackrate))
        var_0 scripts\engine\sp\utility::set_moveplaybackrate(var_8.script_moveplaybackrate);

      if(isDefined(var_8.script_flag_wait))
        scripts\engine\utility::flag_wait(var_8.script_flag_wait);

      var_8 scripts\engine\utility::script_delay();
      var_9 = gettime() + 6000;

      while(isDefined(var_8.radius)) {
        var_10 = distancesquared(level.player.origin, var_0.origin) < squared(var_8.radius);

        if(var_10) {
          break;
        }

        var_11 = get_targetedentitiesinspline(var_8, ::getnode);
        var_11 = scripts\engine\utility::array_remove(var_11, var_8);
        var_12 = 0;
        var_13 = distancesquared(level.player.origin, var_8.origin);

        foreach(var_15 in var_11) {
          var_16 = distancesquared(level.player.origin, var_15.origin);
          var_17 = sighttracepassed(level.player getEye(), var_15.origin, 0, level.player);

          if(var_17 && var_16 < var_13) {
            var_12 = 1;
            break;
          }
        }

        if(var_12) {
          break;
        }

        if(istrue(var_2) && gettime() >= var_9 && !var_5) {
          var_19 = [var_0, level.player];
          var_20 = ["ai_pathNextNode", "ai_pathFinished", "death"];
          level.player scripts\sp\player::focus_display_hint(undefined, undefined, var_0, var_20);
          var_5 = 1;
        }

        waitframe();
      }

      var_8 scripts\engine\utility::script_wait();

      if(isDefined(var_8.script_parameters))
        var_0 thread dialogue(var_8.script_parameters);

      if(isDefined(var_8.script_delete))
        var_0 delete();

      if(isDefined(var_8.target)) {
        var_21 = var_22 == var_6.size - 1;

        if(var_21)
          var_1 = getnode(var_8.target, "targetname");

        continue;
      }

      var_1 = undefined;
      break;
    }
  }

  if(istrue(var_2))
    objective_delete(var_4);

  var_0 notify("ai_pathFinished");
}

ai_pathplayerfollowaispeedscaling(var_0, var_1) {
  level.player endon("death");
  var_0 endon("ai_pathFinished");
  setdvarifuninitialized("ai_pathDebug", 0);
  var_2 = [];
  var_3 = var_1;

  for(;;) {
    var_4 = spawnStruct();
    var_4.start = var_3.origin;

    if(!isDefined(var_3.target)) {
      break;
    }

    var_5 = getnode(var_3.target, "targetname");

    if(!isDefined(var_5)) {
      break;
    }

    var_4.end = var_5.origin;
    var_2 = scripts\engine\utility::array_add(var_2, var_4);
    var_3 = var_5;
  }

  for(;;) {
    var_6 = undefined;
    var_7 = 2147483647;
    var_8 = undefined;
    var_9 = undefined;
    var_10 = 2147483647;
    var_11 = undefined;

    foreach(var_13 in var_2) {
      var_14 = pointonsegmentnearesttopoint(var_13.start, var_13.end, var_0.origin);
      var_15 = distance(var_14, var_0.origin);
      var_16 = pointonsegmentnearesttopoint(var_13.start, var_13.end, level.player.origin);
      var_17 = distance(var_16, level.player.origin);

      if(var_15 < var_7) {
        var_8 = var_14;
        var_6 = var_13;
        var_7 = var_15;
      }

      if(var_17 < var_10) {
        var_11 = var_16;
        var_9 = var_13;
        var_10 = var_17;
      }

      if(ai_pathdebugenabled()) {}
    }

    if(ai_pathdebugenabled()) {}

    var_19 = 0;
    var_20 = 0;
    var_21 = 0;
    var_22 = 0;

    foreach(var_13 in var_2) {
      if(!var_21 && scripts\engine\utility::is_equal(var_13, var_6)) {
        var_21 = 1;
        var_19 = var_19 + distance(var_8, var_13.end);
      } else if(var_21)
        var_19 = var_19 + distance(var_13.start, var_13.end);

      if(!var_22 && scripts\engine\utility::is_equal(var_13, var_9)) {
        var_22 = 1;
        var_20 = var_20 + distance(var_11, var_13.end);
        continue;
      }

      if(var_22)
        var_20 = var_20 + distance(var_13.start, var_13.end);
    }

    var_25 = var_20 - var_19;
    var_26 = length(level.player getvelocity());
    var_27 = length(var_0.velocity);
    var_28 = 53;
    var_29 = 100;
    var_30 = 75;
    var_31 = var_25 <= var_30;

    if(var_31) {
      var_32 = 0;
      var_33 = 15;
      var_34 = 1 - scripts\engine\math::normalize_value(0, var_30, var_25);
      var_35 = scripts\engine\math::factor_value(var_32, var_33, var_34);
      var_36 = max(var_28, var_26 + var_35);
    } else {
      var_37 = var_30;
      var_38 = 400;
      var_39 = 1 - scripts\engine\math::normalize_value(var_37, var_38, var_25);
      var_36 = scripts\engine\math::factor_value(var_28, var_29, var_39);
    }

    var_0 scripts\engine\utility::set_movement_speed(var_36);

    if(ai_pathdebugenabled()) {
      if(var_25 > 0) {} else if(var_25 < 0) {} else {}
    }

    waitframe();
  }
}

ai_pathgetnextnodesarray(var_0) {
  var_1 = [var_0];

  if(ai_pathdoesnodehaveaistop(var_0))
    return var_1;

  for(var_2 = 0; isDefined(var_0.target); var_2++) {
    var_0 = getnode(var_0.target, "targetname");
    var_1 = scripts\engine\utility::array_add(var_1, var_0);

    if(ai_pathdoesnodehaveaistop(var_0)) {
      break;
    }
  }

  return var_1;
}

ai_pathdoesnodehaveaistop(var_0) {
  if(isDefined(var_0.script_delay))
    return 1;

  if(isDefined(var_0.script_delay_min))
    return 1;

  if(isDefined(var_0.script_delay_max))
    return 1;

  if(isDefined(var_0.script_wait))
    return 1;

  if(isDefined(var_0.script_wait_add))
    return 1;

  if(isDefined(var_0.script_wait_min))
    return 1;

  if(isDefined(var_0.script_wait_max))
    return 1;

  if(isDefined(var_0.script_flag_wait))
    return 1;

  if(isDefined(var_0.radius))
    return 1;

  return 0;
}

ai_endpathlogic(var_0) {
  var_0 notify("ai_pathEndLogic");
}

ai_movealongpathcleanupobjectivelogic(var_0, var_1) {
  var_0 endon("ai_pathFinished");
  var_0 waittill("ai_pathEndLogic");
  objective_delete(var_1);
}

ai_pathdebugenabled() {
  return getdvarint("ai_pathDebug");
}

ai_setnoarmordrop(var_0) {
  self.noarmor = var_0;
}

ai_setallowmelee(var_0) {
  self.dontmelee = !var_0;
}

ai_shoot(var_0) {
  var_0 shoot();
  var_0 notify("shooting");
}

ai_takecoveratnodes(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(!var_0.size) {
      break;
    }

    var_4 = sortbydistance(var_0, var_3.origin)[0];
    var_5 = sortbydistance(var_1, var_4.origin)[0];

    if(var_5 == var_3) {
      var_4 setgoalnode(var_3);
      var_1 = scripts\engine\utility::array_remove(var_1, var_5);
      var_0 = scripts\engine\utility::array_remove(var_0, var_4);
    }
  }

  foreach(var_3 in var_1) {
    if(!var_0.size) {
      break;
    }

    var_4 = sortbydistance(var_0, var_3.origin)[0];
    var_4 setgoalnode(var_3);
    var_0 = scripts\engine\utility::array_remove(var_0, var_4);
  }
}

ai_isdog(var_0) {
  if(var_0.classname == "actor_enemy_dog")
    return 1;

  return 0;
}

ai_dogforcegrowl(var_0, var_1) {
  var_0.forcegrowl = var_1;
}

ai_dogforcebark(var_0, var_1) {
  var_0.forcebark = var_1;
}

ai_isfemale(var_0) {
  if(issubstr(tolower(var_0.voice), "female"))
    return 1;

  if(issubstr(tolower(var_0.model), "female"))
    return 1;

  if(isDefined(var_0.headmodel) && issubstr(tolower(var_0.headmodel), "female"))
    return 1;

  return 0;
}

animation_exists(var_0, var_1) {
  return isDefined(level.scr_anim[var_0][var_1]);
}

animation_stoploop(var_0) {
  if(!isarray(var_0))
    var_0 = [var_0];

  foreach(var_2 in var_0) {
    var_2 notify("single anim", "end");
    var_2 notify("looping anim", "end");
    var_2 notify("stop_animmode");
    var_2 notify("stop_first_frame");
    var_2 notify("stop_loop");

    if(isDefined(var_2.animname))
      var_2 notify("stop_loop" + var_2.animname);

    var_3 = animation_getloopanimationentity(var_2);

    if(!isDefined(var_3)) {
      continue;
    }
    var_3 notify("stop_loop");

    if(isDefined(var_2.animname))
      var_3 notify("stop_loop" + var_2.animname);
  }
}

animation_getloopanimationentity(var_0) {
  return var_0.loopanimationentity;
}

animation_stopreach(var_0, var_1) {
  var_0 notify("stop_reach" + var_1.animname);
}

animation_reachtosingleintoloop(var_0, var_1, var_2, var_3) {
  if(!isarray(var_1))
    var_1 = [var_1];

  foreach(var_5 in var_1) {
    var_5 endon("death");
    var_5 endon("entitydeleted");
  }

  animation_reach(var_0, var_1, var_2);
  animation_singleintoloop(var_0, var_1, var_2, var_3);
}

animation_reach(var_0, var_1, var_2) {
  if(!isarray(var_1))
    var_1 = [var_1];

  var_0 childthread scripts\sp\anim::anim_reach(var_1, var_2);
  scripts\engine\utility::array_wait(var_1, "anim_reach_complete");
}

animation_single(var_0, var_1, var_2) {
  if(!isarray(var_1))
    var_1 = [var_1];

  var_0 childthread scripts\common\anim::anim_single(var_1, var_2);
  scripts\engine\sp\utility::array_wait_match(var_1, "single anim", "end");
}

animation_reachtosingle(var_0, var_1, var_2) {
  if(!isarray(var_1))
    var_1 = [var_1];

  foreach(var_4 in var_1) {
    var_4 endon("death");
    var_4 endon("entitydeleted");
  }

  animation_reach(var_0, var_1, var_2);
  animation_single(var_0, var_1, var_2);
}

animation_reachtosingleintolastframe(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_0 scripts\sp\anim::anim_reach_solo(var_1, var_2);
  var_0 scripts\common\anim::anim_single_solo(var_1, var_2);
  var_0 thread scripts\common\anim::anim_last_frame_solo(var_1, var_2);
}

animation_singleintoloop(var_0, var_1, var_2, var_3) {
  if(!isarray(var_1))
    var_1 = [var_1];

  foreach(var_5 in var_1)
  childthread animation_singleintoloopproc(var_0, var_5, var_2, var_3);

  scripts\engine\sp\utility::array_wait_match(var_1, "single anim", "end");
}

animation_singleintoloopproc(var_0, var_1, var_2, var_3) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 endon("stop_loop");
  var_0 endon("stop_loop" + var_1.animname);
  var_0 scripts\common\anim::anim_single_solo(var_1, var_2);
  animation_loop(var_0, var_1, var_3);
}

animation_reachintofirstframe(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 endon("stop_reach" + var_1.animname);
  var_0 scripts\sp\anim::anim_reach_solo(var_1, var_2);
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_1, var_2);
}

animation_singleintolastframe(var_0, var_1, var_2) {
  if(!isarray(var_1))
    var_1 = [var_1];

  foreach(var_4 in var_1)
  childthread animation_singleintolastframeproc(var_0, var_4, var_2);

  scripts\engine\sp\utility::array_wait_match(var_1, "single anim", "end");
}

animation_singleintolastframeproc(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 endon("stop_loop");
  var_0 endon("stop_loop" + var_1.animname);
  var_0 scripts\common\anim::anim_single_solo(var_1, var_2);
  var_0 thread scripts\common\anim::anim_last_frame_solo(var_1, var_2);
}

animation_reachtoidle(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 endon("stop_reach" + var_1.animname);
  var_0 scripts\sp\anim::anim_reach_solo(var_1, var_2);
  animation_loop(var_0, var_1, var_2);
}

animation_loop(var_0, var_1, var_2) {
  if(!isarray(var_1))
    var_1 = [var_1];

  foreach(var_4 in var_1) {
    var_0 thread scripts\common\anim::anim_loop_solo(var_4, var_2, "stop_loop" + var_4.animname);
    var_4.loopanimationentity = var_0;
  }
}

animation_notifyonnotetrack(var_0, var_1, var_2) {
  var_0 endon("entitydeleted");
  var_0 waittillmatch("single anim", var_1);

  if(isDefined(var_2))
    var_0 notify(var_2);
  else
    var_0 notify(var_1);
}

animation_waittillend(var_0) {
  if(!isarray(var_0))
    var_0 = [var_0];

  scripts\engine\sp\utility::array_wait_match(var_0, "single anim", "end");
}

animation_waittillnotetrack(var_0, var_1) {
  var_0 waittillmatch("single anim", var_1);
}

array_removedeaddyingorundefined(var_0) {
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_0 = scripts\engine\utility::array_removedead(var_0);
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isai(var_3) && var_3 scripts\engine\utility::doinglongdeath()) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

array_removedeadvehicles(var_0) {
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_0 = scripts\engine\utility::array_removedead(var_0);
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = scripts\engine\utility::array_contains(vehicle_getarray(), var_3);

    if(!var_4) {
      continue;
    }
    if(!isDefined(var_3.vehicletype)) {
      continue;
    }
    if(istrue(var_3.deaddriver)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

array_sortbyscriptindex(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    foreach(var_4 in var_0) {
      if(scripts\engine\utility::is_equal(var_4.script_index, var_2))
        var_1 = scripts\engine\utility::array_add(var_1, var_4);
    }
  }

  var_6 = scripts\engine\utility::array_remove_array(var_0, var_1);
  var_1 = scripts\engine\sp\utility::array_merge(var_1, var_6);
  return var_1;
}

array_to_vector(var_0) {
  return (var_0[0], var_0[1], var_0[2]);
}

array_waittill_ballisticdeath(var_0) {
  var_1 = spawnStruct();

  foreach(var_3 in var_0)
  thread array_waittill_ballisticdeath_proc(var_1, var_3);

  var_1 waittill("array_wait_proc");
}

array_waittill_ballisticdeath_proc(var_0, var_1) {
  var_1 waittill("ballistics_bulletDamage");
  var_0 notify("array_wait_proc");
}

call_on_notify_no_self(var_0, var_1, var_2, var_3) {
  self waittill(var_0);

  if(isDefined(var_3))
    call[[var_1]](var_2, var_3);
  else if(isDefined(var_2))
    call[[var_1]](var_2);
  else
    call[[var_1]]();
}

dialogue(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(isDefined(var_2) && isDefined(var_3)) {
    if(!isarray(var_2))
      var_2 = [var_2];

    if(!isarray(var_3))
      var_3 = [var_3];

    foreach(var_6 in var_2) {
      foreach(var_8 in var_3)
      var_6 endon(var_8);
    }
  }

  if(isDefined(var_1) && var_1)
    wait(var_1);

  scripts\engine\utility::flag_set("level_dialoguePlaying");

  if(soundexists(var_0)) {
    var_11 = lookupsoundlength(var_0) * 0.001;
    scripts\engine\utility::delaythread(var_11, scripts\engine\utility::flag_clear, "level_dialoguePlaying");

    if(isPlayer(self))
      scripts\engine\sp\utility::smart_player_dialogue(var_0);
    else if(istrue(var_4))
      scripts\engine\sp\utility::smart_radio_dialogue(var_0);
    else
      scripts\engine\sp\utility::smart_dialogue(var_0);

    self notify("dialogue_finished");
  } else {
    if(scripts\engine\utility::is_equal(self.team, "axis"))
      var_12 = "^1";
    else
      var_12 = "^2";

    if(istrue(var_4))
      var_13 = var_12 + self.name + " Over Radio" + ": " + "^7" + var_0;
    else
      var_13 = var_12 + self.name + ": " + "^7" + var_0;

    thread dialogue_proc(var_13, var_1);
  }
}

dialogue_proc(var_0, var_1) {
  level notify("new_dialogue");
  level endon("new_dialogue");
  var_2 = 0.3;
  var_3 = 8.0;
  var_4 = 2.0;
  var_5 = 1.2;
  var_6 = int(5.9 * var_5);
  var_7 = int(24 * var_5);
  var_8 = 300;

  if(isDefined(level.dialoguehud)) {
    foreach(var_10 in level.dialoguehud) {
      var_10 fadeovertime(var_2);
      var_10.alpha = 0;
      var_10 scripts\engine\utility::delaycall(var_2, ::destroy);
    }
  }

  var_12 = newhudelem();
  var_13 = newhudelem();
  var_14 = 350;
  var_15 = int(max(var_0.size * var_6, var_14));
  var_16 = [var_12, var_13];
  level.dialoguehud = var_16;

  foreach(var_10 in var_16) {
    var_10.alignx = "center";
    var_10.aligny = "middle";
    var_10.x = 320;
    var_10.y = var_7 * -1;
    var_10.sort = 5;
  }

  var_12.alpha = 0.5;
  var_12 setshader("black", var_15, var_7);
  var_13 settext(var_0);
  var_13.fontscale = var_5;

  foreach(var_10 in var_16) {
    var_10 moveovertime(var_2);
    var_10.y = var_8;
  }

  wait(var_2 + var_3);

  foreach(var_10 in var_16) {
    var_10 fadeovertime(var_4);
    var_10.alpha = 0;
  }

  wait(var_4);

  foreach(var_10 in var_16)
  var_10 destroy();

  level.dialoguehud = undefined;
}

dialogue_naglogic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self endon("death");
  var_10 = spawnStruct();
  var_10 endon("dialogue_endNag");
  thread dialogue_nagendonlogic(var_10, var_2, var_3);
  childthread dialogue_naglogic_proc(var_10, var_4, var_0, var_1, var_5, var_6, var_7, var_8, var_9);
}

dialogue_naglogic_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(istrue(var_1))
    wait(var_1);

  var_9 = 0;
  var_10 = 0;

  for(;;) {
    if(isDefined(var_6) && isDefined(var_7) && isDefined(var_8))
      childthread dialogue_naganimationlogic(var_6, var_7, var_8);

    var_11 = 0;

    if(isDefined(var_5) && ![[var_5]]()) {
      var_12 = var_4[var_10];
      var_10++;
      var_11 = var_10 >= var_4.size;
    } else {
      var_12 = var_2[var_9];
      var_9++;
      var_11 = var_9 >= var_2.size;
    }

    thread dialogue(var_12);

    if(soundexists(var_12)) {
      var_13 = lookupsoundlength(var_12) * 0.001;
      thread dialogue_nagflaglogic(var_0, var_13);
      wait(var_13);
    }

    if(var_11) {
      break;
    }

    wait(var_3);
  }
}

dialogue_nagflaglogic(var_0, var_1) {
  level_setflag(256, 1);
  var_2 = gettime() + var_1 * 0.001;
  var_3 = scripts\engine\utility::waittill_any_ents_or_timeout_return(var_1, self, "death", var_0, "dialogue_endNag");

  if(var_3 == "death")
    dialogue_stop();
  else if(var_3 == "dialogue_endNag")
    waittill_time(var_2);

  level_setflag(256, 0);
}

dialogue_naganimationlogic(var_0, var_1, var_2) {
  animation_stoploop(self);
  animation_singleintoloop(var_2, self, var_0, var_1);
}

dialogue_nagendonlogic(var_0, var_1, var_2) {
  var_0 endon("dialogue_endNag");

  if(isarray(var_1)) {
    if(isarray(var_2)) {
      foreach(var_4 in var_2)
      childthread dialogue_nagendonnotifies_proc(var_0, var_1, var_4);
    } else {
      scripts\engine\utility::array_wait(var_1, var_2);
      var_0 notify("dialogue_endNag");
    }
  } else if(isarray(var_2)) {
    foreach(var_4 in var_2)
    childthread dialogue_nagendonnotifies_proc(var_0, var_1, var_4);
  } else {
    var_1 waittill(var_2);
    var_0 notify("dialogue_endNag");
  }
}

dialogue_nagendonnotifies_proc(var_0, var_1, var_2) {
  if(isarray(var_1))
    scripts\engine\utility::array_wait(var_1, var_2);
  else
    var_1 waittill(var_2);

  var_0 notify("dialogue_endNag");
}

dialogue_stop() {
  self stopsounds();
}

get_targetedentitiesinspline(var_0, var_1) {
  var_2 = [var_0];

  for(var_3 = 0; isDefined(var_0.target); var_3++) {
    var_0 = call[[var_1]](var_0.target, "targetname");
    var_2 = scripts\engine\utility::array_add(var_2, var_0);
  }

  return var_2;
}

get_linkedentitiesinspline(var_0, var_1) {
  var_2 = [var_0];

  for(var_3 = 0; isDefined(var_0.script_linkto); var_3++) {
    var_0 = var_0[[var_1]]();
    var_2 = scripts\engine\utility::array_add(var_2, var_0);
  }

  return var_2;
}

get_linked_vehicle_node() {
  return scripts\engine\sp\utility::get_linked_vehicle_nodes()[0];
}

get_radius(var_0) {
  return var_0.radius;
}

get_script_radius(var_0) {
  return var_0.script_radius;
}

get_script_noteworthy(var_0) {
  return var_0.script_noteworthy;
}

get_targetname(var_0) {
  return var_0.targetname;
}

get_script_team(var_0) {
  return var_0.script_team;
}

get_targetedentwithcallinsplinewithkvp(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; isDefined(var_0.target); var_4++) {
    if(scripts\engine\utility::is_equal([[var_2]](var_0), var_3)) {
      break;
    }

    var_0 = call[[var_1]](var_0.target, "targetname");
  }

  return var_0;
}

get_lastentinspline(var_0, var_1) {
  for(var_2 = 0; isDefined(var_0.target); var_2++)
    var_0 = call[[var_1]](var_0.target, "targetname");

  return var_0;
}

get_lastentinsplinefunction(var_0, var_1) {
  for(var_2 = 0; isDefined(var_0.target); var_2++)
    var_0 = [[var_1]](var_0.target, "targetname");

  return var_0;
}

level_objectiveinit() {
  level.objective = spawnStruct();
  level_objectivesetindex(0);
  level.objective.currentreservedindex = level_objectivegetreservedstartindex();
}

level_objectiveadd(var_0, var_1, var_2, var_3) {
  if(istrue(var_3)) {
    var_4 = level.objective.currentreservedindex;
    var_5 = level_objectivegetreservedstartindex();
    var_6 = scripts\engine\math::wrap(var_5, 31, var_4 + 1);
    level.objective.currentreservedindex = var_6;
  } else {
    var_4 = level_objectivegetindex();
    level_objectiveincrementindex();
  }

  objective_addalltomask(var_4);
  objective_state(var_4, "current");
  objective_setdescription(var_4, var_0);

  if(isDefined(var_1))
    objective_position(var_4, var_1);

  if(isDefined(var_2))
    objective_setlabel(var_4, var_2);

  return var_4;
}

level_objectivegetindex() {
  return level.objective.index;
}

level_objectivegetpreviousindex() {
  return int(max(level.objective.index - 1, 0));
}

level_objectivecreatefollowai(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 72;

  var_3 = level_objectivegetindex();
  level_objectiveadd(var_2, var_0.origin, &"HIGHWAY/LABEL_FOLLOW");
  objective_onentity(var_3, var_0);
  objective_setzoffset(var_3, var_1);
  return var_3;
}

level_deletepreviousobjective() {
  var_0 = level_objectivegetpreviousindex();
  objective_delete(var_0);
}

level_deletereservedobjectives() {
  var_0 = level_objectivegetreservedstartindex();

  for(var_1 = var_0; var_1 <= 31; var_1++)
    objective_delete(var_1);
}

level_objectivegetreservedstartindex() {
  return 27;
}

level_objectiveincrementindex() {
  var_0 = 26;
  var_1 = level_objectivegetindex();
  var_2 = scripts\engine\math::wrap(0, var_0, var_1 + 1);
  level_objectivesetindex(var_2);
}

level_objectivesetindex(var_0) {
  level.objective.index = var_0;
}

player_waittilllookingatai(var_0, var_1) {
  for(;;) {
    var_2 = level.player getEye();
    var_3 = var_0 getEye();
    var_4 = anglesToForward(level.player getplayerangles());
    var_5 = vectorNormalize(var_3 - var_2);
    var_6 = vectordot(var_4, var_5);
    var_7 = var_6 >= var_1;
    var_8 = sighttracepassed(var_2, var_3, 0, level.player, 1);

    if(var_7 && var_8) {
      break;
    }

    waitframe();
  }
}

player_waittillnearai(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(var_6)) {
    if(!isarray(var_6))
      var_6 = [var_6];
  } else
    var_6 = [];

  if(isDefined(var_7)) {
    if(!isarray(var_7))
      var_7 = [var_7];
  } else
    var_7 = [];

  var_6 = scripts\engine\sp\utility::array_merge(var_6, [var_0, level, level.player]);
  var_7 = scripts\engine\sp\utility::array_merge(var_7, ["death", "entitydeleted", "player_nearAI"]);

  foreach(var_10 in var_6) {
    foreach(var_12 in var_7)
    var_10 endon(var_12);
  }

  var_15 = isDefined(var_3) && isDefined(var_4);

  if(var_15)
    var_16 = level_objectivecreatefollowai(var_0, undefined, var_3);
  else
    var_16 = undefined;

  if(istrue(var_5))
    level.player scripts\sp\player::focus_display_hint(var_5, undefined, var_6, var_7);

  var_17 = var_1 * var_1;

  for(;;) {
    if(isDefined(var_2)) {
      var_18 = distancesquared(level.player.origin, var_2);
      var_19 = distancesquared(var_0.origin, var_2);
      var_20 = var_18 < var_19;

      if(isDefined(var_8)) {
        var_21 = abs(var_2[2] - level.player.origin[2]);
        var_22 = var_21 <= var_8;

        if(var_20 && var_22) {
          break;
        }
      } else if(var_20) {
        break;
      }
    }

    var_23 = distancesquared(level.player.origin, var_0.origin);
    var_24 = var_23 <= var_17;

    if(isDefined(var_8)) {
      var_25 = abs(var_0.origin[2] - level.player.origin[2]);
      var_22 = var_25 <= var_8;

      if(var_24 && var_22) {
        break;
      }
    } else if(var_24) {
      break;
    }

    waitframe();
  }

  if(isDefined(var_16))
    objective_delete(var_16);

  level notify("player_nearAI", var_0);
}

player_startpronehack() {
  level.player scripts\common\utility::allow_crouch(0);
  level.player scripts\common\utility::allow_stand(0);

  while(level.player getstance() != "prone")
    waitframe();

  wait 0.5;
  var_0 = scripts\common\utility::groundpos(level.player.origin, (0, 0, 1));
  level.player setOrigin(var_0);
  level.player scripts\common\utility::allow_crouch(1);
  level.player scripts\common\utility::allow_stand(1);
}

player_waittillmaxhealth() {
  while(level.player.health != level.player.maxhealth)
    waitframe();
}

player_rigenter(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level.player hidelegsandshadow();
  level.player scripts\common\utility::allow_prone(0);
  level.player scripts\common\utility::allow_crouch(0);
  level.player scripts\common\utility::allow_weapon(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  level.player scripts\common\utility::allow_melee(0);

  if(istrue(var_1)) {
    level.player playerlinktoblend(var_0, "tag_player", var_1);
    wait(var_1);
  }

  if(isDefined(var_6)) {
    level.player playerlinktodelta(var_0, "tag_player", 1.0, 0, 0, 0, 0, 1);
    level.player lerpviewangleclamp(var_6, 0, 1, var_2, var_3, var_4, var_5);
  } else
    level.player playerlinktodelta(var_0, "tag_player", 1.0, var_2, var_3, var_4, var_5, 1);

  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var_0 show();
}

player_rigenterabsolute(var_0, var_1) {
  level.player hidelegsandshadow();
  level.player scripts\common\utility::allow_prone(0);
  level.player scripts\common\utility::allow_crouch(0);
  level.player scripts\common\utility::allow_weapon(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  level.player scripts\common\utility::allow_melee(0);

  if(istrue(var_1)) {
    level.player playerlinktoblend(var_0, "tag_player", var_1);
    wait(var_1);
  }

  level.player playerlinktoabsolute(var_0, "tag_player");
  var_0 show();
}

player_rigexit(var_0, var_1) {
  level.player showlegsandshadow();
  level.player scripts\common\utility::allow_prone(1);
  level.player scripts\common\utility::allow_crouch(1);
  level.player scripts\common\utility::allow_weapon(1);
  level.player scripts\common\utility::allow_offhand_weapons(1);
  level.player scripts\common\utility::allow_melee(1);
  level.player unlink();

  if(istrue(var_1)) {
    return;
  }
  var_0 delete();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

waittill_entitiesarewithindistance(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3) && isDefined(var_4))
    var_3 endon(var_4);

  while(distancesquared(var_0.origin, var_1.origin) > squared(var_2))
    waitframe();
}

waittill_entitiesarewithindistancesquared(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3) && isDefined(var_4))
    var_3 endon(var_4);

  while(distancesquared(var_0.origin, var_1.origin) > var_2)
    waitframe();
}

waittill_entityisbehindentitydistance(var_0, var_1, var_2) {
  var_0 endon("death");
  var_1 endon("death");
  var_0 endon("entitydeleted");
  var_1 endon("entitydeleted");

  for(;;) {
    if(entity_isbehindentitydistance(var_0, var_1, var_2)) {
      break;
    }

    waitframe();
  }
}

entity_isbehindentitydistance(var_0, var_1, var_2) {
  var_3 = entity_getbehindentitydistance(var_0, var_1);
  return var_3 < var_2;
}

entity_isbesideentitydistance(var_0, var_1, var_2) {
  var_3 = entity_getlateralentitydistance(var_0, var_1);
  return var_3 < var_2;
}

entity_getbehindentitydistance(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles) * -1;
  var_3 = var_1.origin - var_0.origin;
  var_4 = scripts\engine\math::scalar_projection(var_2, var_3);
  return var_4;
}

entity_getbehindforwarddistance(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = var_1.origin - var_0.origin;
  var_4 = scripts\engine\math::scalar_projection(var_2, var_3);
  return var_4;
}

entity_getlateralentitydistance(var_0, var_1) {
  var_2 = anglestoright(var_0.angles);
  var_3 = var_1.origin - var_0.origin;
  var_4 = scripts\engine\math::scalar_projection(var_2, var_3);
  return abs(var_4);
}

waittill_entityislateralentitydistance(var_0, var_1, var_2) {
  var_0 endon("death");
  var_1 endon("death");
  var_0 endon("entitydeleted");
  var_1 endon("entitydeleted");

  for(;;) {
    var_3 = entity_getlateralentitydistance(var_0, var_1);

    if(var_3 < var_2) {
      break;
    }

    waitframe();
  }
}

waittill_remainingenemycountortimeout(var_0, var_1) {
  var_2 = gettime() + var_1 * 1000;
  var_3 = 0;

  for(;;) {
    if(!var_3 && ai_getaliveaiarray("axis").size > var_0)
      var_3 = 1;

    if(var_3 && ai_getaliveaiarray("axis").size <= var_0) {
      break;
    }

    if(gettime() >= var_2) {
      break;
    }

    waitframe();
  }
}

waittill_remainingenemycount(var_0) {
  while(ai_getaliveaiarray("axis").size > var_0)
    waitframe();
}

waittill_time(var_0) {
  while(gettime() < var_0)
    waitframe();
}

waittill_nonagsplaying() {
  while(level_getflag(256))
    waitframe();
}

waittill_nodialogueplaying() {
  scripts\engine\utility::flag_waitopen("level_dialoguePlaying");
}

math_pointoncircle(var_0, var_1) {
  var_2 = var_0 * cos(var_1);
  var_3 = var_0 * sin(var_1);
  return (var_2, var_3, 0);
}

math_pointonellipse(var_0, var_1) {
  var_2 = var_0 * cos(var_1);
  var_3 = var_0 * sin(var_1) * 0.5;
  return (var_2, var_3, 0);
}

math_pointonlemniscate(var_0, var_1) {
  var_2 = var_0 * sqrt(2) * cos(var_1) / (squared(sin(var_1)) + 1);
  var_3 = var_0 * sqrt(2) * cos(var_1) * sin(var_1) / (squared(sin(var_1)) + 1);
  return (var_2, var_3, 0);
}

math_getchance(var_0) {
  return randomint(100) < var_0;
}

weapon_empty(var_0) {
  if(!isDefined(var_0))
    return 0;

  return scripts\engine\utility::is_equal(var_0.basename, "none");
}

level_setendofscripting() {
  iprintlnbold("End of Scripting");
  var_0 = 3.0;
  var_1 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_1 fadeovertime(var_0);
  var_1.alpha = 1.0;
  wait(var_0);
  scripts\engine\sp\utility::nextmission();
}

level_spawnalexstruct() {
  var_0 = spawnStruct();
  var_0.name = "Alex";
  var_0.animname = "Alex";
  return var_0;
}

level_getflag(var_0) {
  return level.flags &var_0;
}

level_setflag(var_0, var_1) {
  if(var_1)
    level.flags = level.flags | var_0;
  else
    level.flags = level.flags &~var_0;
}

level_setfailonfriendlyfire(var_0) {
  level.failonfriendlyfire = var_0;
}

vehicle_getvehiclearray(var_0, var_1) {
  var_2 = vehicle_getarray();

  foreach(var_4 in var_2) {
    if(!scripts\engine\utility::is_equal([[var_1]](var_4), var_0))
      var_2 = scripts\engine\utility::array_remove(var_2, var_4);
  }

  var_2 = array_removedeadvehicles(var_2);
  return var_2;
}

vehicle_getvehicle(var_0, var_1) {
  var_2 = vehicle_getarray();

  foreach(var_4 in var_2) {
    if(!scripts\engine\utility::is_equal([[var_1]](var_4), var_0))
      var_2 = scripts\engine\utility::array_remove(var_2, var_4);
  }

  var_2 = array_removedeadvehicles(var_2);
  return var_2[0];
}

vehicles_turnonlights(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_5 scripts\common\vehicle::vehicle_lights_on(var_1);

    if(isDefined(var_2) && isDefined(var_3)) {
      var_6 = randomfloatrange(var_2, var_3);
      wait(var_6);
    }
  }
}

vehicle_lerpovertime(var_0, var_1, var_2, var_3) {
  var_4 = 1.0 / (var_3 / 0.05);
  var_5 = 0;
  var_6 = var_0.origin;
  var_7 = var_0.angles;

  while(var_5 < 1.0) {
    var_8 = vectorlerp(var_6, var_1, var_5);
    var_9 = scripts\engine\math::fake_slerp(var_7, var_2, var_5);
    var_0 vehicle_teleport(var_8, var_9);
    var_5 = var_5 + var_4;
    waitframe();
  }

  var_0 vehicle_teleport(var_1, var_2);
}