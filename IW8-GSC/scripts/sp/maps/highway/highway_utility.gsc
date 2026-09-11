/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\highway\highway_utility.gsc
*******************************************************/

function ai_setname(var0, var1) {
  var0.name = var1;
}

function ai_takecoveratnearestnodeinarray(var0) {
  var1 = sortbydistance(var0, self.origin)[0];
  self setgoalnode(var1);
  return var1;
}

function ai_resetstances() {
  self allowedstances("stand", "crouch", "prone");
}

function ai_isalive(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!isalive(var0)) {
    return false;
  }

  if(var0 scripts\engine\utility::doinglongdeath()) {
    return false;
  }

  return true;
}

function ai_getaliveaiarray(var0) {
  if(isDefined(var0)) {
    var1 = getaiarray(var0);
  } else {
    var1 = getaiarray();
  }

  var1 = array_removedeaddyingorundefined(var1);
  return var1;
}

function ai_getstance() {
  return self.currentpose;
}

function ai_waittillinstance(var0) {
  while(ai_getstance() != var0) {
    waitframe();
  }
}

function ai_instantlyremovefromvehicle(var0) {
  var0._blackboard.currentvehicle = undefined;
  var0.ridingvehicle = undefined;
  var0 unlink();
}

function ai_getanimationstartorigin(var0, var1, var2) {
  var3 = var0 scripts\engine\utility::getanim(var1);

  if(isarray(var3)) {
    var3 = var3[0];
  }

  var4 = getstartorigin(var2.origin, var2.angles, var3);
  return var4;
}

function ai_getanimationstartangles(var0, var1, var2) {
  var3 = var0 scripts\engine\utility::getanim(var1);

  if(isarray(var3)) {
    var3 = var3[0];
  }

  var4 = getstartangles(var2.origin, var2.angles, var3);
  return var4;
}

function ai_getanimationfinalorigin(var0, var1, var2) {
  var3 = spawn("script_model", var0.origin);
  var3.angles = var0.angles;
  var3.animname = var0.animname;
  var3 setModel(var0.model);
  var3 scripts\common\anim::setanimtree();
  var3 hide();
  var2 scripts\common\anim::anim_first_frame_solo(var3, var1);
  var2 scripts\common\anim::anim_set_time_solo(var3, var1, 1);
  var4 = var3 scripts\engine\utility::getanim(var1);
  var5 = getmovedelta(var4);
  var6 = getangledelta3d(var4);
  var7 = rotatevector(var5, var3.angles);
  var8 = var3.origin + var7;
  var3 delete();
  return var8;
}

function ai_getanimationfinalangles(var0, var1, var2) {
  var3 = spawn("script_model", var0.origin);
  var3.angles = var0.angles;
  var3.animname = var0.animname;
  var3 setModel(var0.model);
  var3 scripts\common\anim::setanimtree();
  var3 hide();
  var2 scripts\common\anim::anim_first_frame_solo(var3, var1);
  var2 scripts\common\anim::anim_set_time_solo(var3, var1, 1);
  var4 = var3 scripts\engine\utility::getanim(var1);

  if(isarray(var4)) {
    var4 = var4[0];
  }

  var5 = getmovedelta(var4);
  var6 = getangledelta3d(var4);
  var7 = combineangles(var3.angles, var6);
  var3 delete();
  return var7;
}

function ai_setaimassist(var0) {
  if(var0) {
    self actoraimassiston();
    return;
  }

  self actoraimassistoff();
}

function ai_attachhead(var0, var1) {
  if(isDefined(var0.headmodel)) {
    var0 detach(var0.headmodel);
  }

  var0.headmodel = var1;
  var0 attach(var0.headmodel, "", 1);
}

function ai_iscivilian(var0) {
  return var0.asmname == "civilian";
}

function ai_movealongpath(var0, var1, var2, var3) {
  ai_endpathlogic(var0);
  var0 endon("death");
  var0 endon("ai_pathEndLogic");

  if(istrue(var2)) {
    var4 = level_objectivegetindex();
    level_objectiveadd("Follow " + var0.name, var0.origin, "Follow");
    objective_onentity(var4, var0);
    objective_setzoffset(var4, 75);
    thread ai_movealongpathcleanupobjectivelogic(var0, var4);
  } else {
    var4 = undefined;
  }

  var5 = 0;
  jumpiffalse(istrue(var4)) LOC_00000072;
  GscBinSkip4(0x35, var1, var2);

  while(isDefined(var2)) {
    var6 = ai_pathgetnextnodesarray(var2);
    var1 setgoalpath(var6);

    foreach(var8 in var6) {
      var1 notify("ai_pathNextNode");

      if(isDefined(var8.script_radius)) {
        var1.goalradius = var8.script_radius;
      }

      if(isDefined(var8.script_do_arrivals)) {
        var1.disablearrivals = !var8.script_do_arrivals;
      }

      if(isDefined(var8.script_do_exits)) {
        var1.disableexits = !var8.script_do_exits;
      }

      var1 waittill("subgoal");

      if(isDefined(var8.script_demeanor)) {
        if(var8.script_demeanor == "clear") {
          var1 scripts\common\utility::clear_demeanor_override();
        } else {
          var1 scripts\common\utility::demeanor_override(var8.script_demeanor);
        }
      }

      if(isDefined(var8.script_civilian_state)) {
        var1 scripts\asm\asm_bb::bb_setcivilianstate(var8.script_civilian_state);
      }

      if(isDefined(var8.script_stance)) {
        if(var8.script_stance == "clear") {
          ai_resetstances(var1);
        } else {
          var1 allowedstances(var8.script_stance);

          while(ai_getstance(var1) != var8.script_stance) {
            waitframe();
          }
        }
      }

      if(isDefined(var8.script_moveplaybackrate)) {
        var1 scripts\engine\sp\utility::set_moveplaybackrate(var8.script_moveplaybackrate);
      }

      if(isDefined(var8.script_flag_wait)) {
        scripts\engine\utility::flag_wait(var8.script_flag_wait);
      }

      var8 scripts\engine\utility::script_delay();
      var9 = gettime() + 6000;

      while(isDefined(var8.radius)) {
        var10 = distancesquared(level.player.origin, var1.origin) < squared(var8.radius);

        if(var10) {
          break;
        }

        var11 = get_targetedentitiesinspline(var8, &getnode);
        var11 = scripts\engine\utility::array_remove(var11, var8);
        var12 = 0;
        var13 = distancesquared(level.player.origin, var8.origin);

        foreach(var15 in var11) {
          var16 = distancesquared(level.player.origin, var15.origin);
          var17 = sighttracepassed(level.player getEye(), var15.origin, 0, level.player);

          if(var17 && var16 < var13) {
            var12 = 1;
            break;
          }
        }

        if(var12) {
          break;
        }

        if(istrue(var3) && gettime() >= var9 && !var5) {
          var19 = [var1, level.player];
          var20 = ["ai_pathNextNode", "ai_pathFinished", "death"];
          level.player scripts\sp\player::focus_display_hint(undefined, undefined, var1, var20);
          var5 = 1;
        }

        waitframe();
      }

      var8 scripts\engine\utility::script_wait();

      if(isDefined(var8.script_parameters)) {
        thread dialogue(var1);
      }

      if(isDefined(var8.script_delete)) {
        var1 delete();
      }

      if(isDefined(var8.target)) {
        var21 = var22 == var6.size - 1;

        if(var21) {
          var2 = getnode(var8.target, "targetname");
        }

        continue;
      }

      var2 = undefined;
      break;
    }
  }

  if(istrue(var3)) {
    objective_delete(var4);
  }

  var1 notify("ai_pathFinished");
}

function ai_pathplayerfollowaispeedscaling(var0, var1) {
  level.player endon("death");
  var0 endon("ai_pathFinished");
  setdvarifuninitialized("ai_pathDebug", 0);
  var2 = [];

  for(var3 = var1;; var3 = var5) {
    var4 = spawnStruct();
    var4.start = var3.origin;

    if(!isDefined(var3.target)) {
      goto LOC_00000086;
    }

    var5 = getnode(var3.target, "targetname");

    if(!isDefined(var5)) {
      goto LOC_00000086;
    }

    var4.end = var5.origin;
    var2 = scripts\engine\utility::array_add(var2, var4);
  }

  for(;;) {
    var6 = undefined;
    var7 = 2147483647;
    var8 = undefined;
    var9 = undefined;
    var10 = 2147483647;
    var11 = undefined;

    foreach(var13 in var2) {
      var14 = pointonsegmentnearesttopoint(var13.start, var13.end, var0.origin);
      var15 = distance(var14, var0.origin);
      var16 = pointonsegmentnearesttopoint(var13.start, var13.end, level.player.origin);
      var17 = distance(var16, level.player.origin);

      if(var15 < var7) {
        var8 = var14;
        var6 = var13;
        var7 = var15;
      }

      if(var17 < var10) {
        var11 = var16;
        var9 = var13;
        var10 = var17;
      }

      if(ai_pathdebugenabled()) {}
    }

    if(ai_pathdebugenabled()) {}

    var19 = 0;
    var20 = 0;
    var21 = 0;
    var22 = 0;

    foreach(var13 in var2) {
      if(!var21 && scripts\engine\utility::is_equal(var13, var6)) {
        var21 = 1;
        var19 += distance(var8, var13.end);
      } else if(var21) {
        var19 += distance(var13.start, var13.end);
      }

      if(!var22 && scripts\engine\utility::is_equal(var13, var9)) {
        var22 = 1;
        var20 += distance(var11, var13.end);
        continue;
      }

      if(var22) {
        var20 += distance(var13.start, var13.end);
      }
    }

    var25 = var20 - var19;
    var26 = length(level.player getvelocity());
    var27 = length(var0.velocity);
    var28 = 53;
    var29 = 100;
    var30 = 75;
    var31 = var25 <= var30;

    if(var31) {
      var32 = 0;
      var33 = 15;
      var34 = 1 - scripts\engine\math::normalize_value(0, var30, var25);
      var35 = scripts\engine\math::factor_value(var32, var33, var34);
      var36 = max(var28, var26 + var35);
    } else {
      var37 = var30;
      var38 = 400;
      var39 = 1 - scripts\engine\math::normalize_value(var37, var38, var25);
      var36 = scripts\engine\math::factor_value(var28, var29, var39);
    }

    var0 scripts\engine\utility::set_movement_speed(var36);

    if(ai_pathdebugenabled()) {
      if(var25 > 0) {} else if(var25 < 0) {}
    }

    waitframe();
  }
}

function ai_pathgetnextnodesarray(var0) {
  var1 = [var0];

  if(ai_pathdoesnodehaveaistop(var0)) {
    return var1;
  }

  for(var2 = 0; isDefined(var0.target); var2++) {
    var0 = getnode(var0.target, "targetname");
    var1 = scripts\engine\utility::array_add(var1, var0);

    if(ai_pathdoesnodehaveaistop(var0)) {
      break;
    }
  }

  return var1;
}

function ai_pathdoesnodehaveaistop(var0) {
  if(isDefined(var0.script_delay)) {
    return true;
  }

  if(isDefined(var0.script_delay_min)) {
    return true;
  }

  if(isDefined(var0.script_delay_max)) {
    return true;
  }

  if(isDefined(var0.script_wait)) {
    return true;
  }

  if(isDefined(var0.script_wait_add)) {
    return true;
  }

  if(isDefined(var0.script_wait_min)) {
    return true;
  }

  if(isDefined(var0.script_wait_max)) {
    return true;
  }

  if(isDefined(var0.script_flag_wait)) {
    return true;
  }

  if(isDefined(var0.radius)) {
    return true;
  }

  return false;
}

function ai_endpathlogic(var0) {
  var0 notify("ai_pathEndLogic");
}

function ai_movealongpathcleanupobjectivelogic(var0, var1) {
  var0 endon("ai_pathFinished");
  var0 waittill("ai_pathEndLogic");
  objective_delete(var1);
}

function ai_pathdebugenabled() {
  return getdvarint("ai_pathDebug");
}

function ai_setnoarmordrop(var0) {
  self.noarmor = var0;
}

function ai_setallowmelee(var0) {
  self.dontmelee = !var0;
}

function ai_shoot(var0) {
  var0 shoot();
  var0 notify("shooting");
}

function ai_takecoveratnodes(var0, var1) {
  foreach(var3 in var1) {
    if(!var0.size) {
      break;
    }

    var4 = sortbydistance(var0, var3.origin)[0];
    var5 = sortbydistance(var1, var4.origin)[0];

    if(var5 == var3) {
      var4 setgoalnode(var3);
      var1 = scripts\engine\utility::array_remove(var1, var5);
      var0 = scripts\engine\utility::array_remove(var0, var4);
    }
  }

  foreach(var3 in var1) {
    if(!var0.size) {
      break;
    }

    var4 = sortbydistance(var0, var3.origin)[0];
    var4 setgoalnode(var3);
    var0 = scripts\engine\utility::array_remove(var0, var4);
  }
}

function ai_isdog(var0) {
  if(var0.classname == "actor_enemy_dog") {
    return true;
  }

  return false;
}

function ai_dogforcegrowl(var0, var1) {
  var0.forcegrowl = var1;
}

function ai_dogforcebark(var0, var1) {
  var0.forcebark = var1;
}

function ai_isfemale(var0) {
  if(issubstr(tolower(var0.voice), "female")) {
    return true;
  }

  if(issubstr(tolower(var0.model), "female")) {
    return true;
  }

  if(isDefined(var0.headmodel) && issubstr(tolower(var0.headmodel), "female")) {
    return true;
  }

  return false;
}

function animation_exists(var0, var1) {
  return isDefined(level.scr_anim[var0][var1]);
}

function animation_stoploop(var0) {
  if(!isarray(var0)) {
    var0 = [var0];
  }

  foreach(var2 in var0) {
    var2 notify("single anim", "end");
    var2 notify("looping anim", "end");
    var2 notify("stop_animmode");
    var2 notify("stop_first_frame");
    var2 notify("stop_loop");

    if(isDefined(var2.animname)) {
      var2 notify("stop_loop" + var2.animname);
    }

    var3 = animation_getloopanimationentity(var2);

    if(!isDefined(var3)) {
      continue;
    }

    var3 notify("stop_loop");

    if(isDefined(var2.animname)) {
      var3 notify("stop_loop" + var2.animname);
    }
  }
}

function animation_getloopanimationentity(var0) {
  return var0.loopanimationentity;
}

function animation_stopreach(var0, var1) {
  var0 notify("stop_reach" + var1.animname);
}

function animation_reachtosingleintoloop(var0, var1, var2, var3) {
  if(!isarray(var1)) {
    var1 = [var1];
  }

  foreach(var5 in var1) {
    var5 endon("death");
    var5 endon("entitydeleted");
  }

  animation_reach(var0, var1, var2);
  animation_singleintoloop(var0, var1, var2, var3);
}

function animation_reach(var0, var1, var2) {
  if(!isarray(var1)) {
    var1 = [var1];
  }

  var0 childthread scripts\sp\anim::anim_reach(var1, var2);
  scripts\engine\utility::array_wait(var1, "anim_reach_complete");
}

function animation_single(var0, var1, var2) {
  if(!isarray(var1)) {
    var1 = [var1];
  }

  var0 childthread scripts\common\anim::anim_single(var1, var2);
  scripts\engine\sp\utility::array_wait_match(var1, "single anim", "end");
}

function animation_reachtosingle(var0, var1, var2) {
  if(!isarray(var1)) {
    var1 = [var1];
  }

  foreach(var4 in var1) {
    var4 endon("death");
    var4 endon("entitydeleted");
  }

  animation_reach(var0, var1, var2);
  animation_single(var0, var1, var2);
}

function animation_reachtosingleintolastframe(var0, var1, var2) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var0 scripts\sp\anim::anim_reach_solo(var1, var2);
  var0 scripts\common\anim::anim_single_solo(var1, var2);
  var0 thread scripts\common\anim::anim_last_frame_solo(var1, var2);
}

function animation_singleintoloop(var0, var1, var2, var3) {
  if(!isarray(var1)) {
    var1 = [var1];
  }

  var4 = var1;
  var6 = getfirstarraykey(var4);

  if(isDefined(var6)) {
    var5 = var4[var6];
    GscBinSkip4(0x35, var0, var5, var2, var3);
  }

  var4 = undefined;
  var6 = undefined;
  scripts\engine\sp\utility::array_wait_match(var1, "single anim", "end");
}

function animation_singleintoloopproc(var0, var1, var2, var3) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var1 endon("stop_loop");
  var0 endon("stop_loop" + var1.animname);
  var0 scripts\common\anim::anim_single_solo(var1, var2);
  animation_loop(var0, var1, var3);
}

function animation_reachintofirstframe(var0, var1, var2) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var1 endon("stop_reach" + var1.animname);
  var0 scripts\sp\anim::anim_reach_solo(var1, var2);
  var0 thread scripts\common\anim::anim_first_frame_solo(var1, var2);
}

function animation_singleintolastframe(var0, var1, var2) {
  if(!isarray(var1)) {
    var1 = [var1];
  }

  var3 = var1;
  var5 = getfirstarraykey(var3);

  if(isDefined(var5)) {
    var4 = var3[var5];
    GscBinSkip4(0x35, var0, var4, var2);
  }

  var3 = undefined;
  var5 = undefined;
  scripts\engine\sp\utility::array_wait_match(var1, "single anim", "end");
}

function animation_singleintolastframeproc(var0, var1, var2) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var1 endon("stop_loop");
  var0 endon("stop_loop" + var1.animname);
  var0 scripts\common\anim::anim_single_solo(var1, var2);
  var0 thread scripts\common\anim::anim_last_frame_solo(var1, var2);
}

function animation_reachtoidle(var0, var1, var2) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var1 endon("stop_reach" + var1.animname);
  var0 scripts\sp\anim::anim_reach_solo(var1, var2);
  animation_loop(var0, var1, var2);
}

function animation_loop(var0, var1, var2) {
  if(!isarray(var1)) {
    var1 = [var1];
  }

  foreach(var4 in var1) {
    var0 thread scripts\common\anim::anim_loop_solo(var4, var2, "stop_loop" + var4.animname);
    var4.loopanimationentity = var0;
  }
}

function animation_notifyonnotetrack(var0, var1, var2) {
  var0 endon("entitydeleted");
  var0 waittillmatch("single anim", var1);

  if(isDefined(var2)) {
    var0 notify(var2);
    return;
  }

  var0 notify(var1);
}

function animation_waittillend(var0) {
  if(!isarray(var0)) {
    var0 = [var0];
  }

  scripts\engine\sp\utility::array_wait_match(var0, "single anim", "end");
}

function animation_waittillnotetrack(var0, var1) {
  var0 waittillmatch("single anim", var1);
}

function array_removedeaddyingorundefined(var0) {
  var0 = scripts\engine\utility::array_removeundefined(var0);
  var0 = scripts\engine\utility::array_removedead(var0);
  var1 = [];

  foreach(var3 in var0) {
    if(isai(var3) && var3 scripts\engine\utility::doinglongdeath()) {
      continue;
    }

    var1 = var3;
  }

  return var1;
}

function array_removedeadvehicles(var0) {
  var0 = scripts\engine\utility::array_removeundefined(var0);
  var0 = scripts\engine\utility::array_removedead(var0);
  var1 = [];

  foreach(var3 in var0) {
    var4 = scripts\engine\utility::array_contains(vehicle_getarray(), var3);

    if(!var4) {
      continue;
    }

    if(!isDefined(var3.vehicletype)) {
      continue;
    }

    if(istrue(var3.deaddriver)) {
      continue;
    }

    var1 = var3;
  }

  return var1;
}

function array_sortbyscriptindex(var0) {
  var1 = [];

  for(var2 = 0; var2 < var0.size; var2++) {
    foreach(var4 in var0) {
      if(scripts\engine\utility::is_equal(var4.script_index, var2)) {
        var1 = scripts\engine\utility::array_add(var1, var4);
      }
    }
  }

  var6 = scripts\engine\utility::array_remove_array(var0, var1);
  var1 = scripts\engine\sp\utility::array_merge(var1, var6);
  return var1;
}

function array_to_vector(var0) {
  return (var0[0], var0[1], var0[2]);
}

function array_waittill_ballisticdeath(var0) {
  var1 = spawnStruct();

  foreach(var3 in var0) {
    thread array_waittill_ballisticdeath_proc(var1, var3);
  }

  var1 waittill("array_wait_proc");
}

function array_waittill_ballisticdeath_proc(var0, var1) {
  var1 waittill("ballistics_bulletDamage");
  var0 notify("array_wait_proc");
}

function call_on_notify_no_self(var0, var1, var2, var3) {
  self waittill(var0);

  if(isDefined(var3)) {
    builtin[[var1]](var2, var3);
    return;
  }

  if(isDefined(var2)) {
    builtin[[var1]](var2);
    return;
  }

  builtin[[var1]]();
}

function dialogue(var0, var1, var2, var3, var4) {
  self endon("death");

  if(isDefined(var2) && isDefined(var3)) {
    if(!isarray(var2)) {
      var2 = [var2];
    }

    if(!isarray(var3)) {
      var3 = [var3];
    }

    foreach(var6 in var2) {
      foreach(var8 in var3) {
        var6 endon(var8);
      }
    }
  }

  if(isDefined(var1) && var1) {
    wait var1;
  }

  scripts\engine\utility::flag_set("level_dialoguePlaying");

  if(soundexists(var0)) {
    var11 = lookupsoundlength(var0) * 0.001;
    scripts\engine\utility::delaythread(var11, &scripts\engine\utility::flag_clear, "level_dialoguePlaying");

    if(isPlayer(self)) {
      scripts\engine\sp\utility::smart_player_dialogue(var0);
    } else if(istrue(var4)) {
      scripts\engine\sp\utility::smart_radio_dialogue(var0);
    } else {
      scripts\engine\sp\utility::smart_dialogue(var0);
    }

    self notify("dialogue_finished");
    return;
  }

  if(scripts\engine\utility::is_equal(self.team, "axis")) {
    var12 = "^1";
  } else {
    var12 = "^2";
  }

  if(istrue(var12)) {
    var13 = var12 + self.name + " Over Radio" + ": " + "^7" + var1;
  } else {
    var13 = var13 + self.name + ": " + "^7" + var2;
  }

  thread dialogue_proc(var13, var3);
}

function dialogue_proc(var0, var1) {
  level notify("new_dialogue");
  level endon("new_dialogue");
  var2 = 0.3;
  var3 = 8;
  var4 = 2;
  var5 = 1.2;
  var6 = int(5.9 * var5);
  var7 = int(24 * var5);
  var8 = 300;

  if(isDefined(level.dialoguehud)) {
    foreach(var10 in level.dialoguehud) {
      var10 fadeovertime(var2);
      var10.alpha = 0;
      var10 scripts\engine\utility::delaycall(var2, &destroy);
    }
  }

  var12 = newhudelem();
  var13 = newhudelem();
  var14 = 350;
  var15 = int(max(var0.size * var6, var14));
  var16 = [var12, var13];
  level.dialoguehud = var16;

  foreach(var10 in var16) {
    var10.alignx = "center";
    var10.aligny = "middle";
    var10.x = 320;
    var10.y = var7 * -1;
    var10.sort = 5;
  }

  var12.alpha = 0.5;
  var12 setshader("black", var15, var7);
  var13 settext(var0);
  var13.fontscale = var5;

  foreach(var10 in var16) {
    var10 moveovertime(var2);
    var10.y = var8;
  }

  wait var2 + var3;

  foreach(var10 in var16) {
    var10 fadeovertime(var4);
    var10.alpha = 0;
  }

  wait var4;

  foreach(var10 in var16) {
    var10 destroy();
  }

  level.dialoguehud = undefined;
}

function dialogue_naglogic(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  self endon("death");
  var10 = spawnStruct();
  var10 endon("dialogue_endNag");
  thread dialogue_nagendonlogic(var10, var2, var3);
  GscBinSkip4(0x35, var10, var4, var0, var1, var5, var6, var7, var8, var9);
}

function dialogue_naglogic_proc(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(istrue(var1)) {
    wait var1;
  }

  var9 = 0;
  var10 = 0;

  for(;;) {
    if(isDefined(var6) && isDefined(var7) && isDefined(var8)) {
      GscBinSkip4(0x35, var6, var7, var8);
    }

    var11 = 0;

    if(isDefined(var5) && ![[var5]]()) {
      var12 = var4[var10];
      var10++;
      var11 = var10 >= var4.size;
    } else {
      var12 = var2[var9];
      var9++;
      var11 = var9 >= var2.size;
    }

    thread dialogue(var12);

    if(soundexists(var12)) {
      var13 = lookupsoundlength(var12) * 0.001;
      thread dialogue_nagflaglogic(var0, var13);
      wait var13;
    }

    if(var11) {
      break;
    }

    wait var3;
  }
}

function dialogue_nagflaglogic(var0, var1) {
  level_setflag(256, 1);
  var2 = gettime() + var1 * 0.001;
  var3 = scripts\engine\utility::waittill_any_ents_or_timeout_return(var1, self, "death", var0, "dialogue_endNag");

  if(var3 == "death") {
    dialogue_stop();
  } else if(var3 == "dialogue_endNag") {
    waittill_time(var2);
  }

  level_setflag(256, 0);
}

function dialogue_naganimationlogic(var0, var1, var2) {
  animation_stoploop(self);
  animation_singleintoloop(var2, self, var0, var1);
}

function dialogue_nagendonlogic(var0, var1, var2) {
  var0 endon("dialogue_endNag");

  if(isarray(var1)) {
    if(isarray(var2)) {
      var3 = var2;
      var5 = getfirstarraykey(var3);

      if(isDefined(var5)) {
        var4 = var3[var5];
        GscBinSkip4(0x35, var0, var1, var4);
      }

      var3 = undefined;
      var5 = undefined;
      return;
    }

    scripts\engine\utility::array_wait(var1, var2);
    var0 notify("dialogue_endNag");
    return;
  }

  if(isarray(var2)) {
    var6 = var2;
    var7 = getfirstarraykey(var6);

    if(isDefined(var7)) {
      var4 = var6[var7];
      GscBinSkip4(0x35, var0, var1, var4);
    }

    var6 = undefined;
    var7 = undefined;
    return;
  }

  var1 waittill(var2);
  var0 notify("dialogue_endNag");
}

function dialogue_nagendonnotifies_proc(var0, var1, var2) {
  if(isarray(var1)) {
    scripts\engine\utility::array_wait(var1, var2);
  } else {
    var1 waittill(var2);
  }

  var0 notify("dialogue_endNag");
}

function dialogue_stop() {
  self stopsounds();
}

function get_targetedentitiesinspline(var0, var1) {
  var2 = [var0];

  for(var3 = 0; isDefined(var0.target); var3++) {
    var0 = builtin[[var1]](var0.target, "targetname");
    var2 = scripts\engine\utility::array_add(var2, var0);
  }

  return var2;
}

function get_linkedentitiesinspline(var0, var1) {
  var2 = [var0];

  for(var3 = 0; isDefined(var0.script_linkto); var3++) {
    var0 = var0[[var1]]();
    var2 = scripts\engine\utility::array_add(var2, var0);
  }

  return var2;
}

function get_linked_vehicle_node() {
  return scripts\engine\sp\utility::get_linked_vehicle_nodes()[0];
}

function get_radius(var0) {
  return var0.radius;
}

function get_script_radius(var0) {
  return var0.script_radius;
}

function get_script_noteworthy(var0) {
  return var0.script_noteworthy;
}

function get_targetname(var0) {
  return var0.targetname;
}

function get_script_team(var0) {
  return var0.script_team;
}

function get_targetedentwithcallinsplinewithkvp(var0, var1, var2, var3) {
  for(var4 = 0; isDefined(var0.target); var4++) {
    if(scripts\engine\utility::is_equal([[var2]](var0), var3)) {
      break;
    }

    var0 = builtin[[var1]](var0.target, "targetname");
  }

  return var0;
}

function get_lastentinspline(var0, var1) {
  for(var2 = 0; isDefined(var0.target); var2++) {
    var0 = builtin[[var1]](var0.target, "targetname");
  }

  return var0;
}

function get_lastentinsplinefunction(var0, var1) {
  for(var2 = 0; isDefined(var0.target); var2++) {
    var0 = [[var1]](var0.target, "targetname");
  }

  return var0;
}

function level_objectiveinit() {
  level.objective = spawnStruct();
  level_objectivesetindex(0);
  level.objective.currentreservedindex = level_objectivegetreservedstartindex();
}

function level_objectiveadd(var0, var1, var2, var3) {
  if(istrue(var3)) {
    var4 = level.objective.currentreservedindex;
    var5 = level_objectivegetreservedstartindex();
    var6 = scripts\engine\math::wrap(var5, 31, var4 + 1);
    level.objective.currentreservedindex = var6;
  } else {
    var4 = level_objectivegetindex();
    level_objectiveincrementindex();
  }

  objective_addalltomask(var4);
  objective_state(var4, "current");
  objective_setdescription(var4, var1);

  if(isDefined(var2)) {
    objective_position(var4, var2);
  }

  if(isDefined(var3)) {
    objective_setlabel(var4, var3);
  }

  return var4;
}

function level_objectivegetindex() {
  return level.objective.index;
}

function level_objectivegetpreviousindex() {
  return int(max(level.objective.index - 1, 0));
}

function level_objectivecreatefollowai(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = 72;
  }

  var3 = level_objectivegetindex();
  level_objectiveadd(var2, var0.origin, &"HIGHWAY/LABEL_FOLLOW");
  objective_onentity(var3, var0);
  objective_setzoffset(var3, var1);
  return var3;
}

function level_deletepreviousobjective() {
  var0 = level_objectivegetpreviousindex();
  objective_delete(var0);
}

function level_deletereservedobjectives() {
  var0 = level_objectivegetreservedstartindex();

  for(var1 = var0; var1 <= 31; var1++) {
    objective_delete(var1);
  }
}

function level_objectivegetreservedstartindex() {
  return 27;
}

function level_objectiveincrementindex() {
  var0 = 26;
  var1 = level_objectivegetindex();
  var2 = scripts\engine\math::wrap(0, var0, var1 + 1);
  level_objectivesetindex(var2);
}

function level_objectivesetindex(var0) {
  level.objective.index = var0;
}

function player_waittilllookingatai(var0, var1) {
  for(;;) {
    var2 = level.player getEye();
    var3 = var0 getEye();
    var4 = anglesToForward(level.player getplayerangles());
    var5 = vectorNormalize(var3 - var2);
    var6 = vectordot(var4, var5);
    var7 = var6 >= var1;
    var8 = sighttracepassed(var2, var3, 0, level.player, 1);

    if(var7 && var8) {
      break;
    }

    waitframe();
  }
}

function player_waittillnearai(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  if(isDefined(var6)) {
    if(!isarray(var6)) {
      var6 = [var6];
    }
  } else {
    var6 = [];
  }

  if(isDefined(var7)) {
    if(!isarray(var7)) {
      var7 = [var7];
    }
  } else {
    var7 = [];
  }

  var6 = scripts\engine\sp\utility::array_merge(var6, [var0, level, level.player]);
  var7 = scripts\engine\sp\utility::array_merge(var7, ["death", "entitydeleted", "player_nearAI"]);

  foreach(var10 in var6) {
    foreach(var12 in var7) {
      var10 endon(var12);
    }
  }

  var15 = isDefined(var3) && isDefined(var4);

  if(var15) {
    var16 = level_objectivecreatefollowai(var0, undefined, var3);
  } else {
    var16 = undefined;
  }

  if(istrue(var6)) {
    level.player scripts\sp\player::focus_display_hint(var6, undefined, var7, var8);
  }

  var17 = var2 * var2;

  for(;;) {
    if(isDefined(var3)) {
      var18 = distancesquared(level.player.origin, var3);
      var19 = distancesquared(var1.origin, var3);
      var20 = var18 < var19;

      if(isDefined(var9)) {
        var21 = abs(var3[2] - level.player.origin[2]);
        var22 = var21 <= var9;

        if(var20 && var22) {
          break;
        }
      } else if(var17) {
        break;
      }
    }

    var11 = distancesquared(level.player.origin, < error > .origin);
    var12 = var11 <= var10;

    if(isDefined(var1)) {
      var25 = abs( < error > .origin[2] - level.player.origin[2]);
      var22 = var25 <= var1;

      if(var12 && var22) {
        break;
      }
    } else if(var10) {
      break;
    }

    waitframe();
  }

  if(isDefined(var7)) {
    objective_delete(var7);
  }

  level notify("player_nearAI", < error > );
}

function player_startpronehack() {
  level.player scripts\common\utility::allow_crouch(0);
  level.player scripts\common\utility::allow_stand(0);

  while(level.player getstance() != "prone") {
    waitframe();
  }

  wait 0.5;
  var0 = scripts\common\utility::groundpos(level.player.origin, (0, 0, 1));
  level.player setOrigin(var0);
  level.player scripts\common\utility::allow_crouch(1);
  level.player scripts\common\utility::allow_stand(1);
}

function player_waittillmaxhealth() {
  while(level.player.health != level.player.maxhealth) {
    waitframe();
  }
}

function player_rigenter(var0, var1, var2, var3, var4, var5, var6) {
  level.player hidelegsandshadow();
  level.player scripts\common\utility::allow_prone(0);
  level.player scripts\common\utility::allow_crouch(0);
  level.player scripts\common\utility::allow_weapon(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  level.player scripts\common\utility::allow_melee(0);

  if(istrue(var1)) {
    level.player playerlinktoblend(var0, "tag_player", var1);
    wait var1;
  }

  if(isDefined(var6)) {
    level.player playerlinktodelta(var0, "tag_player", 1, 0, 0, 0, 0, 1);
    level.player lerpviewangleclamp(var6, 0, 1, var2, var3, var4, var5);
  } else {
    level.player playerlinktodelta(var0, "tag_player", 1, var2, var3, var4, var5, 1);
  }

  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var0 show();
}

function player_rigenterabsolute(var0, var1) {
  level.player hidelegsandshadow();
  level.player scripts\common\utility::allow_prone(0);
  level.player scripts\common\utility::allow_crouch(0);
  level.player scripts\common\utility::allow_weapon(0);
  level.player scripts\common\utility::allow_offhand_weapons(0);
  level.player scripts\common\utility::allow_melee(0);

  if(istrue(var1)) {
    level.player playerlinktoblend(var0, "tag_player", var1);
    wait var1;
  }

  level.player playerlinktoabsolute(var0, "tag_player");
  var0 show();
}

function player_rigexit(var0, var1) {
  level.player showlegsandshadow();
  level.player scripts\common\utility::allow_prone(1);
  level.player scripts\common\utility::allow_crouch(1);
  level.player scripts\common\utility::allow_weapon(1);
  level.player scripts\common\utility::allow_offhand_weapons(1);
  level.player scripts\common\utility::allow_melee(1);
  level.player unlink();

  if(istrue(var1)) {
    return;
  }

  var0 delete();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

function waittill_entitiesarewithindistance(var0, var1, var2, var3, var4) {
  if(isDefined(var3) && isDefined(var4)) {
    var3 endon(var4);
  }

  while(distancesquared(var0.origin, var1.origin) > squared(var2)) {
    waitframe();
  }
}

function waittill_entitiesarewithindistancesquared(var0, var1, var2, var3, var4) {
  if(isDefined(var3) && isDefined(var4)) {
    var3 endon(var4);
  }

  while(distancesquared(var0.origin, var1.origin) > var2) {
    waitframe();
  }
}

function waittill_entityisbehindentitydistance(var0, var1, var2) {
  var0 endon("death");
  var1 endon("death");
  var0 endon("entitydeleted");
  var1 endon("entitydeleted");

  for(;;) {
    if(entity_isbehindentitydistance(var0, var1, var2)) {
      break;
    }

    waitframe();
  }
}

function entity_isbehindentitydistance(var0, var1, var2) {
  var3 = entity_getbehindentitydistance(var0, var1);
  return var3 < var2;
}

function entity_isbesideentitydistance(var0, var1, var2) {
  var3 = entity_getlateralentitydistance(var0, var1);
  return var3 < var2;
}

function entity_getbehindentitydistance(var0, var1) {
  var2 = anglesToForward(var0.angles) * -1;
  var3 = var1.origin - var0.origin;
  var4 = scripts\engine\math::scalar_projection(var2, var3);
  return var4;
}

function entity_getbehindforwarddistance(var0, var1) {
  var2 = anglesToForward(var0.angles);
  var3 = var1.origin - var0.origin;
  var4 = scripts\engine\math::scalar_projection(var2, var3);
  return var4;
}

function entity_getlateralentitydistance(var0, var1) {
  var2 = anglestoright(var0.angles);
  var3 = var1.origin - var0.origin;
  var4 = scripts\engine\math::scalar_projection(var2, var3);
  return abs(var4);
}

function waittill_entityislateralentitydistance(var0, var1, var2) {
  var0 endon("death");
  var1 endon("death");
  var0 endon("entitydeleted");
  var1 endon("entitydeleted");

  for(;;) {
    var3 = entity_getlateralentitydistance(var0, var1);

    if(var3 < var2) {
      break;
    }

    waitframe();
  }
}

function waittill_remainingenemycountortimeout(var0, var1) {
  var2 = gettime() + var1 * 1000;
  var3 = 0;

  for(;;) {
    if(!var3 && ai_getaliveaiarray("axis").size > var0) {
      var3 = 1;
    }

    if(var3 && ai_getaliveaiarray("axis").size <= var0) {
      break;
    }

    if(gettime() >= var2) {
      break;
    }

    waitframe();
  }
}

function waittill_remainingenemycount(var0) {
  while(ai_getaliveaiarray("axis").size > var0) {
    waitframe();
  }
}

function waittill_time(var0) {
  while(gettime() < var0) {
    waitframe();
  }
}

function waittill_nonagsplaying() {
  while(level_getflag(256)) {
    waitframe();
  }
}

function waittill_nodialogueplaying() {
  scripts\engine\utility::flag_waitopen("level_dialoguePlaying");
}

function math_pointoncircle(var0, var1) {
  var2 = var0 * cos(var1);
  var3 = var0 * sin(var1);
  return (var2, var3, 0);
}

function math_pointonellipse(var0, var1) {
  var2 = var0 * cos(var1);
  var3 = var0 * sin(var1) * 0.5;
  return (var2, var3, 0);
}

function math_pointonlemniscate(var0, var1) {
  var2 = var0 * sqrt(2) * cos(var1) / (squared(sin(var1)) + 1);
  var3 = var0 * sqrt(2) * cos(var1) * sin(var1) / (squared(sin(var1)) + 1);
  return (var2, var3, 0);
}

function math_getchance(var0) {
  return randomint(100) < var0;
}

function weapon_empty(var0) {
  if(!isDefined(var0)) {
    return 0;
  }

  return scripts\engine\utility::is_equal(var0.basename, "none");
}

function level_setendofscripting() {
  iprintlnbold("End of Scripting");
  var0 = 3;
  var1 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var1 fadeovertime(var0);
  var1.alpha = 1;
  wait var0;
  scripts\engine\sp\utility::nextmission();
}

function level_spawnalexstruct() {
  var0 = spawnStruct();
  var0.name = "Alex";
  var0.animname = "Alex";
  return var0;
}

function level_getflag(var0) {
  return level.flags &var0;
}

function level_setflag(var0, var1) {
  if(var1) {
    level.flags |= var0;
    return;
  }

  level.flags &= ~var0;
}

function level_setfailonfriendlyfire(var0) {
  level.failonfriendlyfire = var0;
}

function vehicle_getvehiclearray(var0, var1) {
  var2 = vehicle_getarray();

  foreach(var4 in var2) {
    if(!scripts\engine\utility::is_equal([[var1]](var4), var0)) {
      var2 = scripts\engine\utility::array_remove(var2, var4);
    }
  }

  var2 = array_removedeadvehicles(var2);
  return var2;
}

function vehicle_getvehicle(var0, var1) {
  var2 = vehicle_getarray();

  foreach(var4 in var2) {
    if(!scripts\engine\utility::is_equal([[var1]](var4), var0)) {
      var2 = scripts\engine\utility::array_remove(var2, var4);
    }
  }

  var2 = array_removedeadvehicles(var2);
  return var2[0];
}

function vehicles_turnonlights(var0, var1, var2, var3) {
  foreach(var5 in var0) {
    var5 scripts\common\vehicle::vehicle_lights_on(var1);

    if(isDefined(var2) && isDefined(var3)) {
      var6 = randomfloatrange(var2, var3);
      wait var6;
    }
  }
}

function vehicle_lerpovertime(var0, var1, var2, var3) {
  var4 = 1 / var3 / 0.05;
  var5 = 0;
  var6 = var0.origin;
  var7 = var0.angles;

  while(var5 < 1) {
    var8 = vectorlerp(var6, var1, var5);
    var9 = scripts\engine\math::fake_slerp(var7, var2, var5);
    var0 vehicle_teleport(var8, var9);
    var5 += var4;
    waitframe();
  }

  var0 vehicle_teleport(var1, var2);
}