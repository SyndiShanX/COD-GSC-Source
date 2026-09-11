/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc
*************************************************************************/

function ai_setlookatentity(var_0) {
  if(isDefined(var_0)) {
    if(!isDefined(self.lookatentities)) {
      self.lookatentities = [];
    }

    self.lookatentities = scripts\engine\utility::array_add(self.lookatentities, var_0);
    scripts\common\utility::lookatentity(var_0);
    return;
  }

  if(isDefined(self.lookatentities) && isDefined(self.lookatentities.size)) {
    var_1 = self.lookatentities.size - 1;
    self.lookatentities = scripts\engine\utility::array_remove_index(self.lookatentities, var_1, 1);

    if(self.lookatentities.size) {
      var_2 = self.lookatentities[self.lookatentities.size - 1];
      scripts\common\utility::lookatentity(var_2);
      return;
    }

    scripts\common\utility::lookatentity();
    return;
  }

  scripts\common\utility::lookatentity();
}

function ai_takecoveratnearestnodeinarray(var_0) {
  var_1 = sortbydistance(var_0, self.origin)[0];
  self setgoalnode(var_1);
  return var_1;
}

function ai_resetstances() {
  self allowedstances("stand", "crouch", "prone");
}

function ai_instantlyremovefromvehicle(var_0) {
  var_0._blackboard.currentvehicle = undefined;
  var_0.ridingvehicle = undefined;
  var_0 unlink();
}

function ai_isalive(var_0) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!isalive(var_0)) {
    return false;
  }

  if(var_0 scripts\engine\utility::doinglongdeath()) {
    return false;
  }

  return true;
}

function ai_attachhead(var_0, var_1) {
  if(isDefined(var_0.headmodel)) {
    var_0 detach(var_0.headmodel);
  }

  var_0.headmodel = var_1;
  var_0 attach(var_0.headmodel, "", 1);
}

function ai_getaliveaiarray(var_0) {
  if(isDefined(var_0)) {
    var_1 = getaiarray(var_0);
  } else {
    var_1 = getaiarray();
  }

  var_1 = array_removedeaddyingorundefined(var_1);
  return var_1;
}

function ai_getstance() {
  return self.currentpose;
}

function ai_waittillinstance(var_0) {
  while(ai_getstance() != var_0) {
    waitframe();
  }
}

function ai_setaimassist(var_0) {
  if(var_0) {
    self actoraimassiston();
    return;
  }

  self actoraimassistoff();
}

function ai_iscivilian(var_0) {
  return var_0.asmname == "civilian";
}

function ai_movealongpath(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_0 endon("charge_clear_paths");

  if(istrue(var_2)) {
    var_3 = level_objectivegetindex();
    level_objectiveadd("Follow " + var_0.name, var_0.origin, "Follow");
    objective_onentity(var_3, var_0);
    objective_setzoffset(var_3, 75);
    thread ai_movealongpathcleanupobjectivelogic(var_0, var_3);
  } else {
    var_3 = undefined;
  }

  var_1 childthread scripts\sp\spawner::go_to_node(var_2);
  var_1 waittill("reached_path_end");

  if(istrue(var_3)) {
    objective_delete(var_3);
    return;
  }
}

function ai_movealongpathplayerproximitylogic(var_0) {}

function ai_movealongpathplayerproximityfocushintlogic(var_0) {
  var_1 = [var_0, level.player];
  var_2 = ["reached_path_end", "goal_changed", "death", "entitydeleted"];
}

function ai_endpathlogic(var_0) {
  var_0 notify("stop_going_to_node");
}

function ai_movealongpathcleanupobjectivelogic(var_0, var_1) {
  var_0 scripts\engine\utility::waittill_any("death", "entitydeleted");
  objective_delete(var_1);
}

function ai_isdog(var_0) {
  if(var_0.classname == "actor_enemy_dog") {
    return true;
  }

  return false;
}

function ai_dogforcegrowl(var_0, var_1) {
  var_0.forcegrowl = var_1;
}

function ai_dogforcebark(var_0, var_1) {
  var_0.forcebark = var_1;
}

function ai_dogfightbarklogic(var_0) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_1 = 0.4;
  var_2 = 0.8;

  for(;;) {
    var_3 = randomfloatrange(var_1, var_2);
    wait var_3;
    var_0 playSound("anml_dog_attack_jump", "sounddone");
    var_0 waittill("sounddone");
  }
}

function ai_isfemale(var_0) {
  if(issubstr(tolower(var_0.voice), "female")) {
    return true;
  }

  if(issubstr(tolower(var_0.model), "female")) {
    return true;
  }

  if(isDefined(var_0.headmodel) && issubstr(tolower(var_0.headmodel), "female")) {
    return true;
  }

  return false;
}

function ai_getanimationstartorigin(var_0, var_1, var_2) {
  var_3 = var_0 scripts\engine\utility::getanim(var_1);

  if(isarray(var_3)) {
    var_3 = var_3[0];
  }

  var_4 = getstartorigin(var_2.origin, var_2.angles, var_3);
  return var_4;
}

function ai_getanimationstartangles(var_0, var_1, var_2) {
  var_3 = var_0 scripts\engine\utility::getanim(var_1);

  if(isarray(var_3)) {
    var_3 = var_3[0];
  }

  var_4 = getstartangles(var_2.origin, var_2.angles, var_3);
  return var_4;
}

function ai_getanimationfinalorigin(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0.origin);
  var_3.angles = var_0.angles;
  var_3.animname = var_0.animname;
  var_3 setModel(var_0.model);
  var_3 scripts\common\anim::setanimtree();
  var_3 hide();
  var_2 scripts\common\anim::anim_first_frame_solo(var_3, var_1);
  var_2 scripts\common\anim::anim_set_time_solo(var_3, var_1, 1);
  var_4 = var_3 scripts\engine\utility::getanim(var_1);

  if(isarray(var_4)) {
    var_4 = var_4[0];
  }

  var_5 = getmovedelta(var_4);
  var_6 = getangledelta3d(var_4);
  var_7 = rotatevector(var_5, var_3.angles);
  var_8 = var_3.origin + var_7;
  var_3 delete();
  return var_8;
}

function ai_getanimationoriginattime(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0.origin);
  var_4.angles = var_0.angles;
  var_4.animname = var_0.animname;
  var_4 setModel(var_0.model);
  var_4 scripts\common\anim::setanimtree();
  var_4 hide();
  var_2 scripts\common\anim::anim_first_frame_solo(var_4, var_1);
  var_2 scripts\common\anim::anim_set_time_solo(var_4, var_1, var_3);
  var_5 = var_4 scripts\engine\utility::getanim(var_1);

  if(isarray(var_5)) {
    var_5 = var_5[0];
  }

  var_6 = getmovedelta(var_5);
  var_7 = getangledelta3d(var_5);
  var_8 = rotatevector(var_6, var_4.angles);
  var_9 = var_4.origin + var_8;
  var_4 delete();
  return var_9;
}

function ai_dieondamageduringanimation(var_0, var_1) {
  thread ai_dieondamageduringanimationnotifylogic(var_0, var_1);
  var_0 endon(var_1 + "End");
  ai_ragdolldeathondamage(var_0);
}

function ai_dieondamageduringanimationnotifylogic(var_0, var_1) {
  var_0 waittillmatch("single anim", "end");
  var_0 notify(var_1 + "End");
}

function ai_ragdolldeathondamage(var_0) {
  var_0.skipdeathanim = 1;
  var_0 waittill("damage");
  animation_stoploop(var_0);
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 scripts\engine\sp\utility::ai_ragdoll_immediate();
}

function animation_waittillend(var_0) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  scripts\engine\sp\utility::array_wait_match(var_0, "single anim", "end");
}

function animation_waittillnotetrack(var_0, var_1) {
  var_0 waittillmatch("single anim", var_1);
}

function animation_exists(var_0, var_1) {
  return isDefined(level.scr_anim[var_0][var_1]);
}

function animation_stoploop(var_0) {
  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  foreach(var_2 in var_0) {
    var_2 notify("single anim", "end");
    var_2 notify("looping anim", "end");
    var_2 notify("stop_animmode");
    var_2 notify("stop_first_frame");
    var_2 notify("stop_loop");

    if(isDefined(var_2.animname)) {
      var_2 notify("stop_loop" + var_2.animname);
    }

    var_3 = animation_getloopanimationentity(var_2);

    if(!isDefined(var_3)) {
      continue;
    }

    var_3 notify("stop_loop");

    if(isDefined(var_2.animname)) {
      var_3 notify("stop_loop" + var_2.animname);
    }
  }
}

function animation_getloopanimationentity(var_0) {
  return var_0.loopanimationentity;
}

function animation_stopreach(var_0, var_1) {
  var_0 notify("stop_reach" + var_1.animname);
}

function animation_reachtosingleintoidle(var_0, var_1, var_2, var_3) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_0 scripts\sp\anim::anim_reach_solo(var_1, var_2);
  animation_singleintoidle(var_0, var_1, var_2, var_3);
}

function animation_reachtosingle(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_0 scripts\sp\anim::anim_reach_solo(var_1, var_2);
  var_0 scripts\common\anim::anim_single_solo(var_1, var_2);
}

function animation_reachtosingleintolastframe(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_0 scripts\sp\anim::anim_reach_solo(var_1, var_2);
  var_0 scripts\common\anim::anim_single_solo(var_1, var_2);
  var_0 thread scripts\common\anim::anim_last_frame_solo(var_1, var_2);
}

function animation_singleintoidle(var_0, var_1, var_2, var_3) {
  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  var_4 = var_1;
  var_6 = getfirstarraykey(var_4);

  if(isDefined(var_6)) {
    var_5 = var_4[var_6];
    GscBinSkip4(0x35, var_0, var_5, var_2, var_3);
  }

  var_4 = undefined;
  var_6 = undefined;
  scripts\engine\sp\utility::array_wait_match(var_1, "single anim", "end");
}

function animation_singleintoidleproc(var_0, var_1, var_2, var_3) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 endon("stop_loop");
  var_0 endon("stop_loop" + var_1.animname);
  var_0 scripts\common\anim::anim_single_solo(var_1, var_2);
  animation_loop(var_0, var_1, var_3);
}

function animation_reachintofirstframe(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 endon("stop_reach" + var_1.animname);
  var_0 scripts\sp\anim::anim_reach_solo(var_1, var_2);
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_1, var_2);
}

function animation_singleintolastframe(var_0, var_1, var_2) {
  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  var_3 = var_1;
  var_5 = getfirstarraykey(var_3);

  if(isDefined(var_5)) {
    var_4 = var_3[var_5];
    GscBinSkip4(0x35, var_0, var_4, var_2);
  }

  var_3 = undefined;
  var_5 = undefined;
  scripts\engine\sp\utility::array_wait_match(var_1, "single anim", "end");
}

function animation_singleintolastframeproc(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 endon("stop_loop");
  var_0 endon("stop_loop" + var_1.animname);
  var_0 scripts\common\anim::anim_single_solo(var_1, var_2);
  var_0 thread scripts\common\anim::anim_last_frame_solo(var_1, var_2);
}

function animation_reachtoidle(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("entitydeleted");
  var_1 endon("stop_reach" + var_1.animname);
  var_0 scripts\sp\anim::anim_reach_solo(var_1, var_2);
  animation_loop(var_0, var_1, var_2);
}

function animation_loop(var_0, var_1, var_2) {
  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_4 in var_1) {
    var_0 thread scripts\common\anim::anim_loop_solo(var_4, var_2, "stop_loop" + var_4.animname);
    var_4.loopanimationentity = var_0;
  }
}

function array_removedeaddyingorundefined(var_0) {
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_0 = scripts\engine\utility::array_removedead(var_0);
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isai(var_3) && var_3 scripts\engine\utility::doinglongdeath()) {
      continue;
    }

    var_1 = var_3;
  }

  return var_1;
}

function array_removedeadvehicles(var_0) {
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

    var_1 = var_3;
  }

  return var_1;
}

function array_sortbyscriptindex(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    foreach(var_4 in var_0) {
      if(scripts\engine\utility::is_equal(var_4.script_index, var_2)) {
        var_1 = scripts\engine\utility::array_add(var_1, var_4);
      }
    }
  }

  var_6 = scripts\engine\utility::array_remove_array(var_0, var_1);
  var_1 = scripts\engine\sp\utility::array_merge(var_1, var_6);
  return var_1;
}

function array_to_vector(var_0) {
  return (var_0[0], var_0[1], var_0[2]);
}

function dialogue(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");

  if(isDefined(var_2) && isDefined(var_3)) {
    if(!isarray(var_2)) {
      var_2 = [var_2];
    }

    if(!isarray(var_3)) {
      var_3 = [var_3];
    }

    foreach(var_6 in var_2) {
      foreach(var_8 in var_3) {
        var_6 endon(var_8);
      }
    }
  }

  if(isDefined(var_1) && var_1) {
    wait var_1;
  }

  if(soundexists(var_0)) {
    if(isPlayer(self)) {
      scripts\engine\sp\utility::smart_player_dialogue(var_0);
    } else if(istrue(var_4)) {
      scripts\engine\sp\utility::smart_radio_dialogue(var_0);
    } else {
      scripts\engine\sp\utility::smart_dialogue(var_0);
    }

    self notify("dialogue_finished");
    return;
  }

  if(scripts\engine\utility::is_equal(self.team, "axis")) {
    var_11 = "^1";
  } else {
    var_11 = "^2";
  }

  if(istrue(var_11)) {
    var_12 = var_11 + self.name + " Over Radio" + ": " + "^7" + var_1;
    return;
  }

  var_12 = var_12 + self.name + ": " + "^7" + var_2;
}

function dialogue_proc(var_0, var_1) {
  level notify("new_dialogue");
  level endon("new_dialogue");
  var_2 = 0.3;
  var_3 = 8;
  var_4 = 2;
  var_5 = 1.2;
  var_6 = int(5.9 * var_5);
  var_7 = int(24 * var_5);
  var_8 = 300;

  if(isDefined(level.dialoguehud)) {
    foreach(var_10 in level.dialoguehud) {
      var_10 fadeovertime(var_2);
      var_10.alpha = 0;
      var_10 scripts\engine\utility::delaycall(var_2, &destroy);
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

  wait var_2 + var_3;

  foreach(var_10 in var_16) {
    var_10 fadeovertime(var_4);
    var_10.alpha = 0;
  }

  wait var_4;

  foreach(var_10 in var_16) {
    var_10 destroy();
  }

  level.dialoguehud = undefined;
}

function dialogue_naglogic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  var_9 = spawnStruct();
  var_9 endon("dialogue_endNag");
  thread dialogue_nagendonlogic(var_9, var_2, var_3);
  GscBinSkip4(0x35, var_9, var_4, var_0, var_1, var_5, var_6, var_7, var_8);
}

function dialogue_naglogic_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(istrue(var_1)) {
    wait var_1;
  }

  var_8 = 0;

  for(;;) {
    if(isDefined(var_4) && isDefined(var_5) && isDefined(var_6)) {
      GscBinSkip4(0x35, var_4, var_5, var_6, var_7);
    }

    var_9 = 0;
    var_10 = var_2[var_8];
    var_8++;
    var_9 = var_8 >= var_2.size;
    thread dialogue(var_10);

    if(soundexists(var_10)) {
      var_11 = lookupsoundlength(var_10) * 0.001;
      wait var_11;
    }

    if(var_9) {
      break;
    }

    wait var_3;
  }
}

function dialogue_naganimationlogic(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      animation_stoploop(var_5);
      thread animation_singleintoidle(var_2, var_5, var_0, var_1);
    }
  }

  animation_stoploop(self);
  animation_singleintoidle(var_2, self, var_0, var_1);
}

function dialogue_nagendonlogic(var_0, var_1, var_2) {
  var_0 endon("dialogue_endNag");

  if(isarray(var_1)) {
    if(isarray(var_2)) {
      var_3 = var_2;
      var_5 = getfirstarraykey(var_3);

      if(isDefined(var_5)) {
        var_4 = var_3[var_5];
        GscBinSkip4(0x35, var_0, var_1, var_4);
      }

      var_3 = undefined;
      var_5 = undefined;
      return;
    }

    scripts\engine\utility::array_any_wait(var_1, var_2);
    var_0 notify("dialogue_endNag");
    return;
  }

  if(isarray(var_2)) {
    var_6 = var_2;
    var_7 = getfirstarraykey(var_6);

    if(isDefined(var_7)) {
      var_4 = var_6[var_7];
      GscBinSkip4(0x35, var_0, var_1, var_4);
    }

    var_6 = undefined;
    var_7 = undefined;
    return;
  }

  var_1 waittill(var_2);
  var_0 notify("dialogue_endNag");
}

function dialogue_nagendonnotifies_proc(var_0, var_1, var_2) {
  if(isarray(var_1)) {
    scripts\engine\utility::array_any_wait(var_1, var_2);
  } else {
    var_1 waittill(var_2);
  }

  var_0 notify("dialogue_endNag");
}

function get_targetedentitiesinspline(var_0, var_1) {
  var_2 = [var_0];

  for(var_3 = 0; isDefined(var_0.target); var_3++) {
    var_0 = builtin[[var_1]](var_0.target, "targetname");
    var_2 = scripts\engine\utility::array_add(var_2, var_0);
  }

  return var_2;
}

function get_linkedentitiesinspline(var_0, var_1) {
  var_2 = [var_0];

  for(var_3 = 0; isDefined(var_0.script_linkto); var_3++) {
    var_0 = var_0[[var_1]]();
    var_2 = scripts\engine\utility::array_add(var_2, var_0);
  }

  return var_2;
}

function get_linked_vehicle_node() {
  return scripts\engine\sp\utility::get_linked_vehicle_nodes()[0];
}

function get_radius(var_0) {
  return var_0.radius;
}

function get_script_radius(var_0) {
  return var_0.script_radius;
}

function get_script_noteworthy(var_0) {
  return var_0.script_noteworthy;
}

function get_targetname(var_0) {
  return var_0.targetname;
}

function get_script_team(var_0) {
  return var_0.script_team;
}

function get_targetedentwithcallinsplinewithkvp(var_0, var_1, var_2, var_3) {
  for(var_4 = 0; isDefined(var_0.target); var_4++) {
    if(scripts\engine\utility::is_equal([[var_2]](var_0), var_3)) {
      break;
    }

    var_0 = builtin[[var_1]](var_0.target, "targetname");
  }

  return var_0;
}

function get_nexttargetedpathgoal(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = getnode(var_0.target, "targetname");

  if(isDefined(var_1)) {
    return var_1;
  }

  if(isDefined(var_2)) {
    return var_2;
  }

  return undefined;
}

function get_lastentinspline(var_0, var_1) {
  for(var_2 = 0; isDefined(var_0.target); var_2++) {
    var_0 = builtin[[var_1]](var_0.target, "targetname");
  }

  return var_0;
}

function get_lastentinsplinefunction(var_0, var_1) {
  for(var_2 = 0; isDefined(var_0.target); var_2++) {
    var_0 = [[var_1]](var_0.target, "targetname");
  }

  return var_0;
}

function level_objectiveadd(var_0, var_1, var_2) {
  var_3 = level_objectivegetindex();
  objective_addalltomask(var_3);
  objective_state(var_3, "current");
  objective_setdescription(var_3, var_0);

  if(isDefined(var_1)) {
    objective_position(var_3, var_1);
  }

  if(isDefined(var_2)) {
    objective_setlabel(var_3, var_2);
  }

  level_objectiveincrementindex();
}

function level_objectivegetindex() {
  return level.objectiveindex;
}

function level_objectiveincrementindex() {
  var_0 = level_objectivegetindex();
  level_objectivesetindex(var_0 + 1);
}

function level_objectivesetindex(var_0) {
  level.objectiveindex = var_0;
}

function player_isprone() {
  return level.player getstance() == "prone";
}

function player_droneinit() {
  precachemodel("veh8_ind_air_bombing_drone");
  precachemodel("veh8_ind_air_bombing_drone");
  precacheshader("ui_bomber_drone_overlay");
  setdvarifuninitialized("player_droneDebug", 1);
  setdvarifuninitialized("scr_thrid_person_rc_plane", 0);
  level.player notifyonplayercommand("invert_pressed", "+weapnext");
}

function player_startallowdrones() {
  level.drone_control = 1;
  scripts\engine\utility::flag_set("drone_allowed");
  thread player_dronecontrolmanager();
  level.player notifyonplayercommand("player_droneControl", "+actionslot 1");
}

function player_pauseallowdrones() {
  scripts\engine\utility::flag_clear("drone_allowed");
}

function player_resumeallowdrones() {
  if(!isDefined(level.drone_control)) {
    player_startallowdrones();
    return;
  }

  scripts\engine\utility::flag_set("drone_allowed");
}

function player_stopallowdrones() {
  level.drone_control = undefined;
  scripts\engine\utility::flag_clear("drone_allowed");
  level notify("stop_drone_cooldown");
  level.drone_vo = undefined;
  scripts\engine\utility::flag_wait("hangar_interior");
  level notify("stop_drone_control");
  level.player notifyonplayercommandremove("player_droneControl", "+actionslot 1");
}

function player_dronecontrolmanager() {
  level.player endon("death");
  level endon("stop_drone_control");
  level.drone_counter = 0;
  var_0 = undefined;
  init_drone_vo();
  GscBinSkip4(0x35);
}

function init_drone_vo() {
  level.drone_vo = spawnStruct();
  var_0 = ["dx_vom_yas_fob_center_planelast_10", "dx_vom_yas_fob_center_planelast_20", "dx_vom_yas_fob_center_planelast_30"];
  level.drone_vo.last_plane = scripts\engine\sp\utility::create_deck(var_0, 0);
  level.drone_vo.last_plane.autoshuffle = 1;
  var_0 = ["dx_vom_yas_fob_center_planeready_10", "dx_vom_yas_fob_center_planeready_20", "dx_vom_yas_fob_center_planeready_30"];
  level.drone_vo.planes_ready = scripts\engine\sp\utility::create_deck(var_0, 0);
  level.drone_vo.planes_ready.autoshuffle = 1;
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, "dx_vom_had_fob_center_helos_40");
}

function player_dronecooldown() {
  level endon("stop_drone_cooldown");

  if(istrue(level.infinite_drones)) {
    return;
  }

  for(;;) {
    player_dodronecooldown();

    if(scripts\engine\utility::flag("drone_allowed")) {
      thread say_as_chatter(level, level.drone_vo.last_plane scripts\engine\sp\utility::deck_draw(), 0);
      player_pauseallowdrones();
      player_waitdronecooldown();
    }

    scripts\engine\utility::flag_wait("drone_allowed");
    thread say_as_chatter(level, level.drone_vo.planes_ready scripts\engine\sp\utility::deck_draw(), 0);
  }
}

function player_dodronecooldown(var_0) {
  if(!scripts\engine\utility::flag("drone_allowed")) {
    return;
  }

  level endon("drone_allowed");
  var_1 = 3;

  if(level.gameskill > 1) {
    var_1 -= 1;
  }

  var_2 = 0;

  if(var_2 < var_1) {
    if(level.drone_counter == 0) {
      GscBinSkip4(0x35);
    }

    if(var_2 == 0) {
      GscBinSkip4(0x35, 1, 5);
    }

    GscBinSkip4(0x35, 1, 10);
  }
}

function player_waitdronecooldown() {
  if(scripts\engine\utility::flag("drone_allowed")) {
    return;
  }

  level endon("drone_allowed");
  var_0 = gettime();

  for(var_1 = 0; var_1 < 3; var_1++) {
    level waittill("ai_killed");

    if(getaiarray("axis").size == 0) {
      break;
    }
  }

  wait randomfloatrange(1, 3);
  var_2 = (gettime() - var_0) / 1000;

  if(var_2 < 20) {
    wait 20 - var_2;
  }

  wait wait_combat_cooldown(1.5, 5);
  player_resumeallowdrones();
}

function player_droneusereminder(var_0, var_1) {
  if(scripts\engine\utility::flag("dont_drone_nag")) {
    return;
  }

  level endon("dont_drone_nag");
  level endon("player_in_drone");
  level endon("pause_drone_control");
  level endon("stop_drone_control");

  if(isDefined(var_1)) {
    wait var_1;
  }

  GscBinSkip4(0x35);
}

function player_droneusenags() {
  nagtill(level.hadir, "one_fob_helo_left", level.drone_vo.multiple_helis, 21, 1.6, 60);
  wait_combat_cooldown(0.6, 1.2);
  nagtill(level.hadir, "no_fob_helos_left", level.drone_vo.single_heli, 21, 1.6, 60);
  wait_combat_cooldown(0.6, 1.2);
  nagtill(level.hadir, "player_in_drone", level.drone_vo.planes_ready, 21, 1.6, 60);
}

function player_dronelogic() {
  level.player endon("player_droneCancel");
  thread player_dronecancellogic();
  thread drone_cancel_notify_delay();
  var_0 = player_dronespawnlogic();

  if(level.drone_counter == 0) {}

  level.player waittill("player_exitDrone");
}

function drone_cancel_notify_delay() {
  wait 0.75;
  level notify("stop_drone_cancel_logic");
}

function player_dronecancellogic() {
  level.player endon("death");
  level endon("stop_drone_cancel_logic");
  level.player scripts\engine\utility::waittill_any("attack_pressed", "melee_pressed", "ads_pressed", "weapon_switch_pressed");
  level.player notify("player_droneCancel");
}

function player_dronespawnlogic() {
  wait 1.1;
  var_0 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_0 fadeovertime(0.25);
  var_0.alpha = 1;
  thread player_dronespawnoverlaycancellogic(var_0);
  wait 0.25;
  var_0 fadeovertime(0.25);
  var_0.alpha = 0;
  var_0 scripts\engine\utility::delaycall(0.25, &destroy);
  scripts\engine\utility::flag_set("player_in_drone");
  jumpiffalse(isDefined(level.drone_start_position)) LOC_0000008a;
  var_1 = level.drone_start_position.origin;
  var_2 = level.drone_start_position.angles;
  goto LOC_00000142;
}

function player_trackdronekills() {
  scripts\engine\utility::flag_wait("player_in_drone");
  level endon("player_in_drone");
  var_0 = 0;

  for(;;) {
    level waittill("ai_killed", var_1, var_2, var_3, var_4);

    if(isDefined(var_1.team) && var_1.team != "axis") {
      continue;
    }

    if(!isDefined(var_2)) {
      continue;
    }

    if(var_2.classname == "player") {
      break;
    }
  }

  wait 0.85;

  if(!isDefined(level.drone_vo) || !isDefined(level.drone_vo.good_hit)) {
    return;
  }

  say_as_chatter(level.hadir, level.drone_vo.good_hit scripts\engine\sp\utility::deck_draw(), 0, 2);
}

function dummy_player(var_0) {
  var_1 = getspawner("alex", "targetname");
  var_2 = scripts\engine\sp\utility::bodyonlyspawn(var_1);
  var_1.count = 1;
  var_2.origin = level.player.origin;
  var_2.angles = level.player.angles;
  var_2.animname = "alex";
  var_2 setCanDamage(1);
  thread dummy_damage_watcher(var_0);
  var_3 = scripts\engine\sp\utility::spawn_anim_model("tablet_1");
  var_3.origin = var_2 gettagorigin("tag_accessory_right");
  var_3.angles = var_2 gettagangles("tag_accessory_right");
  var_3 linkTo(var_2, "tag_accessory_right");
  var_2 thread scripts\common\anim::anim_loop_solo(var_2, "drone_idle");
  var_4 = createnavbadplacebybounds(var_2.origin, (200, 200, 400), var_2.angles, "axis");
  level.player waittill("player_exitDrone");
  var_2 delete();
  var_3 delete();
  destroynavobstacle(var_4);
}

function dummy_damage_watcher(var_0) {
  level.player endon("player_exitDrone");
  scripts\engine\utility::waittill_any("missile_stuck", "death", "entitydeleted");
  var_1 = level.impactinfo.crashorigin;
  var_2 = 200;

  if(distance(var_1, var_0.origin) < var_2) {
    scripts\sp\friendlyfire::missionfail();
    return;
  }
}

function player_dronevisionsetfade() {
  wait 1;
  level notify("stop_drone_cancel_logic");
  visionsetnaked("safehouse_finale_fob_missilecam_noise", 0.1);
}

function player_usedrone(var_0, var_1, var_2, var_3, var_4) {
  var_5 = player_dronespawn(var_0, var_1);
  thread player_dronecontrollogic(var_5, var_2, var_3, var_4);
  return var_5;
}

function player_dronespawnoverlaycancellogic(var_0) {
  var_1 = level.player scripts\engine\utility::waittill_notify_or_timeout_return("player_droneCancel", 0.25);

  if(var_1 == "timeout") {
    return;
  }

  var_0 fadeovertime(0.25);
  var_0.alpha = 0;
  var_0 scripts\engine\utility::delaycall(0.25, &destroy);
}

function player_dronecontrollogic(var_0, var_1, var_2, var_3) {
  dronesetvehspeed(var_0, var_1, var_2, var_3);
  thread drone_controls_hints();
  thread drone_inverted_controls_swap();
  thread droneimpactwatcher();
  thread dronedetonatewatcher();
  thread dronepropellerfx();
  thread droneanims();
  thread dronesprintlogic();
  thread droneenginesfx();
  thread dronebankeffects();
  thread dronescreenfx();
  thread dronedamagelogic();
  thread dronetimeoutlogic();
  thread droneoutofboundslogic();
  thread droneenemieslogic();
  thread dummy_player(var_0);
  var_4 = droneplayersetup(var_0);
  level.impactinfo = undefined;
  level.impactinfo = dronegetimpactinfoondeath(var_0);
  playrumbleonposition("damage_heavy", level.player.origin);
  removedronescreeneffects();
  var_5 = droneimpactexplosion(level.impactinfo);
  dronekillcamlogic(level.impactinfo, var_5);
  droneplayerrestore(var_4, level.impactinfo, var_0);
}

function drone_controls_hints() {
  level.player endon("player_exitDrone");

  if(!scripts\engine\utility::flag("fob_center") || scripts\engine\utility::flag("drone_detonated")) {
    return;
  }

  if(!scripts\engine\utility::flag("drone_sprinted")) {
    thread sprint_watcher();
    scripts\engine\sp\utility::display_hint_forced("drone_sprint", undefined, 1, [self, level.player], ["missile_stuck", "attack_pressed", "death", "entitydeleted"]);
  }

  scripts\engine\utility::flag_wait("drone_sprinted");

  if(!scripts\engine\utility::flag("drone_detonated")) {
    scripts\engine\sp\utility::display_hint_forced("drone_detonate", undefined, 1, [self, level.player], ["missile_stuck", "use_pressed", "death", "entitydeleted", "player_in_drone"]);
    return;
  }
}

function sprint_watcher() {
  self endon("entitydeleted");
  level.player endon("player_exitDrone");

  while(!level.player attackButtonPressed()) {
    waitframe();
  }

  scripts\engine\utility::flag_set("drone_sprinted");
}

function drone_inverted_controls_swap() {
  self endon("missile_stuck");
  self endon("entitydeleted");

  for(;;) {
    level.player scripts\engine\utility::waittill_any("invert_pressed");
    level.player playRumbleOnEntity("damage_heavy");

    if(level.player usinggamepad()) {
      var_0 = "invertPitchFlyingGamepad";
      var_1 = level.player getlocalplayerprofiledata("invertPitchGamepad") || level.player getlocalplayerprofiledata(var_0);
      level.player setlocalplayerprofiledata("invertPitchGamepad", 0);
    } else {
      var_0 = "invertPitchKBM";
      var_1 = level.player getlocalplayerprofiledata(var_0);
    }

    if(var_1 >= 1) {
      var_1 = 0;
    } else {
      var_1 = 1;
    }

    level.player setlocalplayerprofiledata(var_0, var_1);
    waitframe();
  }
}

function droneplayersetup(var_0) {
  level.player disableweaponswitch();
  level.player enableinvulnerability();
  level.player painvisionoff();
  level.player disableweapons();
  setomnvar("ui_hide_hud", 1);
  level.player enableplayerbreathsystem(0);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  var_1 = level.player.origin;
  level.player playerdisabletriggers();
  level.player enableinvulnerability();
  level.player hidelegsandshadow();
  level.player hideviewmodel();
  var_0 setotherent(level.player);
  var_0 setentityowner(level.player);
  controls_linkto_safe(level.player, var_0);
  return var_1;
}

function droneplayerrestore(var_0, var_1, var_2) {
  level.player modifybasefov(65, 0.05);
  wait 0.15;
  level.player enableweaponswitch();
  level.player enableweapons();
  var_3 = var_1.crashorigin;
  level.player scripts\engine\utility::delaycall(1, &disableinvulnerability);
  level.player showlegsandshadow();
  level.player showviewmodel();
  level.player enableplayerbreathsystem(1);
  controls_unlink_safe(level.player);
  level.player cameraunlink();

  if(isDefined(var_2)) {
    var_2 setotherent(undefined);
    var_2 setentityowner(undefined);
    var_2 delete();
  }

  level.player setOrigin(var_0);
  level.player playerenabletriggers();
  setomnvar("ui_hide_hud", 0);
  var_4 = var_3 - level.player.origin;
  level.player setplayerangles(vectortoangles(var_4));
  level.player scripts\sp\utility::allow_cg_drawcrosshair(1);
  level.player notify("player_exitDrone", var_3);
}

function droneimpactexplosion(var_0) {
  thread drone_friendly_fire_watcher();
  var_1 = var_0.crashorigin;
  level.player radiusdamage(var_1 + (0, 0, 10), 250, 500, 500, level.player, "MOD_PROJECTILE", undefined, 0, 0);
  level.player radiusdamage(var_1 + (0, 0, 10), 250, 500, 500, level.player, "MOD_EXPLOSIVE", undefined, 0, 0);
  radiusdamage(var_1 + (0, 0, 10), 500, 500, 500, undefined, "MOD_PROJECTILE", "apache_proj_sp", 0, 0);
  var_2 = 0;
  var_2 = chopper_check(var_1);
  tromeo_check(var_1);
  playFX(level._effect["vfx_drone_impact"], var_1);
  earthquake(0.6, 0.15, var_1, 9999);
  thread scripts\engine\utility::play_sound_in_space("scn_safehouse_rc_plane_death_plr", var_1);
  thread scripts\engine\utility::play_sound_in_space("iw8_cruise_missile_exp", var_1);
  return var_2;
}

function drone_friendly_fire_watcher() {
  level endon("player_in_drone");
  level waittill("friendlyfire_mission_fail");
  setomnvar("ui_hide_hud", 0);
}

function dronesetvehspeed(var_0, var_1, var_2, var_3) {
  thread dronesetvehspeedthreaded(var_0, var_1, var_2, var_3);
}

function dronesetvehspeedthreaded(var_0, var_1, var_2, var_3) {
  self notify("new_rc_plane_speed");
  self endon("death");
  self endon("entitydeleted");
  self endon("new_rc_plane_speed");

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(isDefined(self.minspeed) && var_3 > 0) {
    var_4 = 0.05;
    var_5 = int(var_3 / var_4);
    var_6 = var_0 - self.minspeed;
    var_7 = var_1 - self.maxspeed;
    var_8 = var_2 - self.boostspeed;
    var_9 = var_6 / var_5;
    var_10 = var_7 / var_5;
    var_11 = var_8 / var_5;

    while(var_5) {
      self.minspeed += var_9;
      self.maxspeed += var_10;
      self.boostspeed += var_11;
      setstoredvehspeeds();
      wait var_4;
      var_5--;
    }
  }

  self.minspeed = var_0;
  self.maxspeed = var_1;
  self.boostspeed = var_2;
  setstoredvehspeeds();
}

function setstoredvehspeeds() {
  self rcplane_setminspeed(self.minspeed);
  self rcplane_settopspeed(self.maxspeed);
  self rcplane_settopspeedboost(self.boostspeed);
}

function mphtoips(var_0) {
  return var_0 * 17.6;
}

function droneoutofboundslogic() {
  self endon("missile_stuck");
  self endon("entitydeleted");
  var_0 = getEnt("out_of_bounds_01", "targetname");
  var_1 = getEnt("out_of_bounds_02", "targetname");
  var_2 = var_0;

  if(scripts\engine\utility::flag("fob_center")) {
    var_2 = var_1;
  }

  level.inbounds = 1;
  wait 1;

  for(;;) {
    if(self istouching(var_2)) {
      level.inbounds = 1;
      waitframe();
      continue;
    }

    level.inbounds = 0;
    thread kill_drone_out_of_bounds(level.inbounds);
    thread droneoutofboundsvisionlogic();

    while(!self istouching(var_2)) {
      waitframe();
    }

    level notify("in_bounds");
    level.inbounds = 1;
    visionsetfadetoblack(level.current_visionset, 0.5);
    wait 0.5;
  }
}

function kill_drone_out_of_bounds(var_0) {
  self endon("missile_stuck");
  self endon("entitydeleted");
  level endon("in_bounds");
  wait 3;
  self delete();
}

function player_dronedebugenabled() {
  return getdvarint("player_droneDebug");
}

function player_dronedebugline(var_0) {
  if(player_dronedebugenabled()) {
    iprintln(var_0);
    return;
  }
}

function droneenemieslogic() {
  wait 2;

  if(!isalive(self)) {
    return;
  }

  level.chopper_turret_target = self;
  var_0 = scripts\engine\utility::spawn_script_origin();
  var_0 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1 = droneenemiestargetlogic(var_0);

  if(scripts\engine\utility::flag("player_in_drone")) {
    scripts\engine\utility::flag_waitopen("player_in_drone");
  }

  var_1 = array_removedeaddyingorundefined(var_1);

  foreach(var_3 in var_1) {
    var_3 clearentitytarget();
  }

  var_0 delete();
}

function droneenemiestargetlogic(var_0) {
  var_1 = 0.2;
  var_2 = [];

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    var_3 = ai_getaliveaiarray("axis");

    foreach(var_5 in var_3) {
      if(droneenemyvalid(var_5)) {
        continue;
      }

      var_3 = scripts\engine\utility::array_remove(var_3, var_5);
    }

    if(!var_3.size) {
      waitframe();
      continue;
    }

    var_7 = var_3[0];
    var_8 = -9999999;
    var_9 = anglesToForward(self.angles);

    foreach(var_5 in var_3) {
      var_11 = vectorNormalize(var_5 getEye() - self.origin);
      var_12 = vectordot(var_9, var_11);

      if(var_12 > var_8) {
        var_8 = var_12;
        var_7 = var_5;
      }
    }

    var_7 setentitytarget(var_0);
    thread droneenemyshootvfxlogic(var_7);

    if(!scripts\engine\utility::array_contains(var_2, var_7)) {
      var_2 = scripts\engine\utility::array_add(var_2, var_7);
    }

    wait var_1;
  }

  return var_2;
}

function droneenemyshootvfxlogic(var_0) {
  var_0 endon("death");
  self endon("missile_stuck");
  self endon("entitydeleted");

  for(;;) {
    var_0 waittill("shooting");
    playFXOnTag(level._effect["vfx_muzzle_flash_ar_no_cull"], var_0, "TAG_FLASH");
  }
}

function droneenemyvalid(var_0) {
  if(scripts\engine\utility::is_equal(var_0.code_classname, "actor_enemy_rus_desert_rpg")) {
    return false;
  }

  var_1 = sighttracepassed(self.origin, var_0 getEye(), 0, self, 1);

  if(!var_1) {
    return false;
  }

  return true;
}

function player_dronegetstartstructs() {
  return scripts\engine\utility::getStructArray("player_droneStartStruct", "targetname");
}

#using_animtree("vehicles");

function player_dronespawn(var_0, var_1) {
  if(getdvarint("scr_thrid_person_rc_plane")) {
    var_2 = "rcplane_physics_tp";
  } else {
    var_2 = "rcplane_physics";
  }

  var_3 = spawnVehicle("veh8_ind_air_bombing_drone", "rcplane", var_2, var_1, var_2);
  var_3 vehphys_enablecollisioncallback(1);
  var_3 vehicle_teleport(var_1, var_2);
  var_3 hidepart("j_propeller");
  var_3 useanimtree(#animtree);
  level.player_dronemodel = var_3;
  thread player_dronecleanuplogic();
  return var_3;
}

function droneenginesfx() {
  self endon("missile_stuck");
  self endon("entitydeleted");
  self.enginesfxtag = scripts\engine\utility::spawn_tag_origin();
  self.enginesfxtag linkTo(self);
  self.enginesfxtag playLoopSound("scn_safehouse_rc_plane_plr_main_lp");
  self.sprintsfxtag = scripts\engine\utility::spawn_tag_origin();
  self.sprintsfxtag linkTo(self);
  self.sprintsfxtag playLoopSound("scn_safehouse_rc_plane_plr_thrust_lp");
  self.sprintsfxtag scalevolume(0.25);
  self.sprintsfxtag scalepitch(1, 0);
  var_0 = 1.2;
  var_1 = 0.8;
  var_2 = 1.15;
  var_3 = 0.85;
  var_4 = 0.25;
  var_5 = 0;
  var_6 = 0.5;

  for(;;) {
    var_7 = self vehicle_getspeed();
    var_7 = scripts\engine\utility::mph_to_ips(var_7);
    var_8 = scripts\engine\math::normalize_value(self.minspeed, self.maxspeed, var_7);
    var_6 = scripts\engine\math::lerp(var_6, var_8, var_4);
    var_9 = scripts\engine\math::factor_value(var_1, var_0, var_6);
    var_10 = scripts\engine\math::factor_value(var_3, var_2, var_6);

    if(self.sprinting) {
      if(!var_5) {
        var_5 = 1;
        self.enginesfxtag scalevolume(1.4, 1);
        self.enginesfxtag scalepitch(1.4, 1.5);
        self.sprintsfxtag scalevolume(1.4, 1);
      }
    } else {
      if(var_5) {
        self.sprintsfxtag scalevolume(0.25, 1);
        var_5 = 0;
      }

      self.enginesfxtag scalevolume(var_9, 0.05);
      self.enginesfxtag scalepitch(var_10, 1);
    }

    waitframe();
  }
}

function dronebankeffects() {
  self endon("missile_stuck");
  self endon("entitydeleted");
  level.pitchdelta = undefined;
  var_0 = 0;
  var_1 = 0.083;
  var_2 = 0.06;
  var_3 = 0;
  var_4 = 0.1;
  var_5 = 0.501;
  var_6 = 1;
  var_7 = 0.8;
  var_8 = 1.2;
  self.rumbleent = scripts\engine\utility::spawn_script_origin(level.player.origin);
  self.enginebanksfxtag = scripts\engine\utility::spawn_tag_origin();
  self.enginebanksfxtag linkTo(self);
  self.enginebanksfxtag playLoopSound("scn_safehouse_rc_plane_plr_bank_lp");
  var_9 = 0;
  var_10 = anglesToForward(self.angles);
  var_11 = angleclamp180(self.angles[0]);

  for(;;) {
    var_12 = anglesToForward(self.angles);
    var_13 = 1 - vectordot(var_10, var_12);
    var_14 = angleclamp180(self.angles[0]);
    level.pitchdelta = var_11 - var_14;
    var_10 = var_12;
    var_11 = var_14;
    var_15 = abs(self.angles[2]);
    var_0 = scripts\engine\math::lerp(var_0, var_15, 0.08);
    var_16 = scripts\engine\math::normalize_value(0, 50, var_15);
    var_16 = scripts\engine\math::normalized_float_smooth_out(var_16);
    var_17 = scripts\engine\math::normalize_value(0, 0.0064, var_13);
    var_17 = scripts\engine\math::normalized_float_smooth_out(var_17);
    var_18 = max(var_16, var_17);
    var_19 = scripts\engine\math::factor_value(var_2, var_1, var_18);
    var_20 = scripts\engine\math::factor_value(var_3, var_4, var_18);
    var_21 = scripts\engine\math::factor_value(var_5, var_6, var_18);
    var_22 = scripts\engine\math::factor_value(var_7, var_8, var_18);

    if(var_20 > 0.0001) {
      if(!var_9) {
        self.rumbleent playrumblelooponentity("steady_rumble");
        var_9 = 1;
      }
    } else if(var_9) {
      self.rumbleent stoprumble("steady_rumble");
      var_9 = 0;
    }

    var_23 = 1 - var_20;
    var_23 *= 1000;
    self.rumbleent.origin = self.origin + (0, 0, var_23);
    self.enginebanksfxtag scalevolume(var_21, 0.05);
    self.enginebanksfxtag scalepitch(var_22, 0.05);
    earthquake(var_19, 0.2, self.origin, 5000);
    waitframe();
  }
}

function dronescreenfx() {
  level scripts\engine\sp\utility::dof_enable(25, 49, 0, 0);
  dronestaticmbscreenfx(0);
  level.player setcinematicmotionoverride("iw8_rcplane");
  self.overlay = newclienthudelem(level.player);
  self.overlay.sort = 0;
  self.overlay.foreground = 0;
  self.overlay.horzalign = "fullscreen";
  self.overlay.vertalign = "fullscreen";
  self.overlay.alpha = 1;
  self.overlay.enablehudlighting = 1;
  self.overlay setshader("ui_bomber_drone_overlay", 640, 480);

  if(istrue(level.player.fly_start)) {
    visionsetnaked("rc_plane_intro", 0);
    wait 4;
    visionsetnaked("rc_plane", 10);
    return;
  }

  visionsetnaked("rc_plane", 0);
}

function dronestaticmbscreenfx(var_0) {
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0.1585, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("NKTRSSTMRQ", -0.478, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("LSOPQMRPNR", 0.00389, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("OMRQKMSSPP", 1, var_0);
}

function removedronescreeneffects() {
  level scripts\engine\sp\utility::dof_disable();
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0, 0);
  thread scripts\engine\sp\utility::lerp_saveddvar("NKTRSSTMRQ", 0, 0);
  thread scripts\engine\sp\utility::lerp_saveddvar("LSOPQMRPNR", 0, 0);
  thread scripts\engine\sp\utility::lerp_saveddvar("OMRQKMSSPP", 0, 0);
  visionsetfadetoblack("", 0);
  visionsetnaked("", 0);
  level.player clearcinematicmotionoverride();
}

function playerdroneintrodof() {
  var_0 = 6;
  var_1 = 6;
  level scripts\engine\sp\utility::dof_enable(5.2, 0.01, 10, 10);
  wait 0.5;
  level scripts\engine\sp\utility::dof_enable(5.2, 17, var_0, var_1);
  wait 0.6;
  level scripts\engine\sp\utility::dof_enable(5.2, 0.01, var_0, var_1);
  wait 0.5;
  level scripts\engine\sp\utility::dof_enable(25, 49, var_0, var_1);
}

function droneimpactwatcher() {
  thread droneheliimpactwatcher();
  self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  self notify("missile_stuck");
}

function droneheliimpactwatcher() {
  var_0 = 0;
  var_1 = ["TAG_TAIL_ROTOR_MOTION"];

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    foreach(var_3 in level.choppers) {
      if(!isDefined(var_3)) {
        continue;
      }

      if(var_3.classname == "script_vehicle_iw8_mindia8_closed") {
        var_4 = 300;
      } else {
        var_4 = 180;
      }

      var_5 = [var_3.origin];

      foreach(var_7 in var_1) {
        if(scripts\engine\utility::hastag(var_3.model, var_7)) {
          var_5 = scripts\engine\utility::array_add(var_5, var_3 gettagorigin(var_7));
        }
      }

      foreach(var_10 in var_5) {
        var_11 = anglesToForward(self.angles);
        var_12 = var_10 - self.origin;
        var_13 = vectordot(var_11, vectorNormalize(var_12));
        var_14 = length(var_12);

        if(var_14 < var_4 && var_13 > 0) {
          var_0 = 1;
        }

        if(var_0) {
          self notify("missile_stuck");
          return;
        }
      }
    }

    waitframe();
  }
}

function dronedetonatewatcher() {
  level.player endon("player_exitDrone");
  scripts\engine\utility::flag_wait("fob_center");
  level.player waittill("use_pressed");
  scripts\engine\utility::flag_set("drone_detonated");
  self notify("missile_stuck");
}

function dronepropellerfx() {
  wait 0.3;

  if(!isalive(self)) {
    return;
  }

  playFXOnTag(level._effect["vfx_rc_plane_rotor"], self, "j_propeller");
  playFXOnTag(level._effect["vfx_rc_plane_light_plr"], self, "tag_origin");
}

#using_animtree("");

function droneanims() {
  self useanimtree(#animtree);
  self setanim(%veh8_ind_air_bomber_fly_base);
  self setanim(%veh8_ind_air_bomber_fly_noise);
}

function player_dronecleanuplogic() {
  scripts\engine\utility::waittill_any("missile_stuck", "entitydeleted");
  self.enginesfxtag delete();
  self.enginebanksfxtag delete();
  self.sprintsfxtag delete();
  self.sprintinitsfxtag delete();
  self.rumbleent delete();

  if(isDefined(self.overlay)) {
    self.overlay destroy();
  }

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function dronegetimpactinfoondeath() {
  var_0 = spawnStruct();
  droneupdateoriginandanglestildeath(var_0);
  return var_0;
}

function droneupdateoriginandanglestildeath(var_0) {
  self endon("missile_stuck");
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    var_0.crashforward = anglesToForward(self gettagangles("tag_origin"));
    var_0.crashorigin = self.origin;
    waitframe();
  }
}

function dronekillcamlogic(var_0, var_1) {
  var_2 = var_0.crashorigin;
  var_3 = var_0.crashforward;
  var_4 = (0, 0, 1);
  var_3 = scripts\engine\utility::flatten_vector(var_3);
  var_5 = var_3 * -1;
  var_6 = randomintrange(1, 4);

  if(scripts\engine\utility::flag_exist("fly_attack_done") && !scripts\engine\utility::flag("fly_attack_done")) {
    var_6 = 1;
  }

  var_7 = [];

  if(level.inbounds) {
    switch (var_6) {
      case 3:
      case 2:
      case 1:
        var_7 = kill_cam_behavior_spin(var_4, var_3, var_5, var_2, var_1);
        break;
      case 4:
        var_7 = kill_cam_behavior_default(var_4, var_3, var_5, var_2);
        break;
      default:
        var_7 = kill_cam_behavior_default(var_4, var_3, var_5, var_2);
        break;
    }
  } else {
    level.player cameraunlink();
    controls_unlink_safe(level.player);
  }

  var_8 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_8 fadeovertime(0.2);
  var_8.alpha = 1;
  wait 0.2;
  thread cleanupkillcamlogic(var_7, var_8);
}

function cleanupkillcamlogic(var_0, var_1) {
  wait 0.2;
  scripts\engine\utility::array_delete(var_0);
  level scripts\engine\sp\utility::dof_disable();
  var_1 fadeovertime(0.2);
  var_1.alpha = 0;
  var_1 scripts\engine\utility::delaycall(0.2, &destroy);
}

function kill_cam_behavior_spin(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0.3;
  var_6 = vectorlerp(var_2, var_0, var_5);
  var_7 = vectortoangles(var_6 * -1);
  var_8 = scripts\engine\utility::spawn_tag_origin(var_3, var_7);
  var_9 = scripts\engine\utility::spawn_tag_origin(var_3, var_7);
  var_10 = 1100;

  if(istrue(var_4)) {
    var_10 = 2000;
  }

  var_11 = var_3 + var_6 * var_10;
  var_12 = sighttracepassed(var_3, var_11, 0, level.player, 1);

  if(!var_12) {
    var_13 = kill_cam_behavior_default(var_0, var_1, var_2, var_3);
    return var_13;
  }

  level.player cameraunlink();
  controls_unlink_safe(level.player);
  level.player cameralinkTo(var_9, "tag_origin", 1, 1);
  level.player modifybasefov(45, 0.05);
  var_14 = 1.7;
  screenshake(var_9.origin, 0.5, 0.2, 0.3, 3);
  var_15 = scripts\engine\utility::spawn_tag_origin(var_4, (0, 0, 0));
  var_15 scripts\engine\sp\utility::dof_enable_autofocus(1.4, 10, undefined, undefined, "tag_origin");
  var_9.origin = var_12;
  var_9 linkTo(var_10);
  wait 0.1;
  var_10 rotateYaw(5, var_14);
  wait var_14;
  var_9 notify("kill_lookat");
  var_13 = [var_9, var_10];
  var_15 delete();
  return var_13;
}

function kill_cam_behavior_low(var_0, var_1, var_2, var_3) {
  var_4 = 0.15;
  var_5 = vectorlerp(var_2, var_0, var_4);
  var_6 = vectortoangles(var_5 * -1);
  var_7 = scripts\engine\utility::spawn_tag_origin(var_3, var_6);
  var_8 = scripts\engine\utility::spawn_tag_origin(var_3, var_6);
  var_9 = 200;
  var_10 = var_3 + var_5 * var_9;
  var_11 = sighttracepassed(var_3, var_10, 0, level.player, 1);

  if(!var_11) {
    var_12 = kill_cam_behavior_default(var_0, var_1, var_2, var_3);
    return var_12;
  }

  var_8.angles = var_9.angles + (-10, -10, 0);
  level.player cameraunlink();
  controls_unlink_safe(level.player);
  level.player cameralinkTo(var_8, "tag_origin", 1, 1);
  level.player modifybasefov(80, 0.05);
  var_13 = 1.7;
  screenshake(var_8.origin, 1, 0.5, 0.5, 3);
  level scripts\engine\sp\utility::dof_enable(0.572089, 850.852, 0, 0);
  var_8.origin = var_11;
  var_8 linkTo(var_9);
  wait 0.1;
  var_9 rotateYaw(5, var_13 + 0.5);
  wait var_13;
  var_8 notify("kill_lookat");
  var_12 = [var_8, var_9];
  return var_12;
}

function kill_cam_behavior_default(var_0, var_1, var_2, var_3) {
  var_4 = 0.9;
  var_5 = vectorlerp(var_2, var_0, var_4);
  var_6 = vectortoangles(var_5 * -1);
  var_7 = scripts\engine\utility::spawn_tag_origin(var_3, var_6);
  var_8 = scripts\engine\utility::spawn_tag_origin(var_3, var_6);
  var_9 = 1200;
  var_10 = var_3 + var_5 * var_9;
  var_11 = sighttracepassed(var_3, var_10, 0, level.player, 1);
  level.player cameraunlink();
  controls_unlink_safe(level.player);
  level.player cameralinkTo(var_7, "tag_origin", 1, 1);
  level.player modifybasefov(35, 0.05);
  var_12 = 1.7;
  screenshake(var_7.origin, 0.5, 0.2, 0.3, 3);
  level scripts\engine\sp\utility::dof_enable(0.572089, 850.852, 0, 0);
  var_7.origin = var_10;
  var_7 linkTo(var_8);
  wait 0.1;
  var_8 rotateYaw(35, var_12 + 0.5);
  var_8 movez(200, var_12 + 0.5);
  wait var_12;
  var_7 notify("kill_lookat");
  var_13 = [var_7, var_8];
  return var_13;
}

function camera_move(var_0, var_1) {
  self endon("kill_lookat");
  var_2 = 30;
  var_3 = 0;
  var_4 = 360;
  var_5 = 0;
  var_6 = 1;
  var_5 = scripts\engine\math::anglebetweenvectors(scripts\engine\utility::flatten_vector(self.origin - var_0), (-1, 0, 0));
  iprintlnbold(var_5);

  for(;;) {
    var_7 = math_pointoncircle(var_1, var_5);
    var_8 = var_0 + var_7;
    var_9 = (var_8[0], var_8[1], self.origin[2]);
    self moveTo(var_9, 0.25);
    var_5 = scripts\engine\math::wrap(0, 360, var_5 + var_6);
    wait 0.25;
  }
}

function call_on_notify_no_self(var_0, var_1, var_2, var_3) {
  self waittill(var_0);

  if(isDefined(var_3)) {
    builtin[[var_1]](var_2, var_3);
    return;
  }

  if(isDefined(var_2)) {
    builtin[[var_1]](var_2);
    return;
  }

  builtin[[var_1]]();
}

function call_on_notetrack(var_0, var_1) {
  animation_waittillnotetrack(self, var_0);
  self builtin[[var_1]]();
}

function camera_lookat(var_0) {
  self endon("kill_lookat");

  for(;;) {
    var_1 = vectortoangles(var_0 - self.origin);
    self.angles = var_1;
    waitframe();
  }
}

function dronedamagelogic() {
  self endon("missile_stuck");
  self endon("entitydeleted");
  self.health = 99999;
  var_0 = 1.5;
  wait var_0;
  self setCanDamage(1);
  var_1 = 6;
  var_2 = 1500;
  var_3 = gettime();

  for(;;) {
    self waittill("damage", var_4, var_5);
    var_6 = gettime() - var_3;

    if(var_6 < var_2) {
      continue;
    }

    thread dronedamagevisionlogic();
    thread dronedamageeffectslogic();
    dronedamagerotatelogic(var_5);
    var_3 = gettime();
    var_1--;

    if(!var_1) {
      break;
    }
  }

  self delete();
}

function dronetimeoutlogic() {
  self endon("missile_stuck");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait("start_fly_countdown");
  var_0 = gettime();

  while(var_0 + 15000 > gettime()) {
    waitframe();
  }

  self delete();
}

function dronedamagevisionlogic() {
  var_0 = "ac130_color_glitch";
  var_1 = "";
  visionsetfadetoblack(var_0, 0);
  wait 0.1;
  visionsetfadetoblack(var_1, 0.4);
}

function droneoutofboundsvisionlogic() {
  self endon("missile_stuck");
  self endon("entitydeleted");
  visionsetfadetoblack("rc_color_glitch", 1);
}

function dronedamageeffectslogic() {
  earthquake(0.23, 0.2, self.origin, 5000);
  level.player playRumbleOnEntity("damage_heavy");
  thread scripts\engine\sp\utility::play_sound_on_entity("drone_ricochet");
}

function dronedamagerotatelogic(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  self endon("missile_stuck");
  self endon("entitydeleted");
  var_1 = randomfloatrange(8, 12);
  var_2 = !scripts\engine\math::is_point_on_right(var_0.origin);

  if(var_2) {
    var_1 *= -1;
  }

  var_3 = self.angles;
  var_4 = var_3 + (0, var_1, 0);
  var_5 = 0.5;
  var_6 = 0;

  while(var_6 < 1) {
    var_6 += var_5;
    waitframe();
  }
}

function controls_unlink_safe() {
  if(isDefined(self.controlslinked) && self.controlslinked) {
    self controlsunlink();
    self.controlslinked = 0;
    return;
  }
}

function controls_linkto_safe(var_0) {
  self controlslinkTo(var_0);
  self.controlslinked = 1;
}

function dronesprintlogic() {
  self endon("missile_stuck");
  self endon("entitydeleted");
  self.sprintinitsfxtag = scripts\engine\utility::spawn_tag_origin();
  self.sprintinitsfxtag linkTo(self);
  self.sprintinitsfxtag scalevolume(0, 0);
  self.sprintinitsfxtag scalepitch(0, 0);
  self.sprinting = 0;
  level.player waittill("attack_pressed");
  GscBinSkip4(0x35);
}

function dronesprinteffectsinlogic() {
  level.player endon("attack_released");
  var_0 = 0.35;
  self.sprinting = 1;
  level.player setcinematicmotionoverride("iw8_rcplane_sprint");
  thread scripts\engine\sp\utility::lerp_saveddvar("LSOPQMRPNR", 0.08, var_0);
  thread scripts\engine\sp\utility::lerp_saveddvar("NKTRSSTMRQ", 0.4, var_0);
  earthquake(0.23, 0.5, self.origin, 5000);
  self.sprintinitsfxtag playSound("scn_safehouse_rc_plane_plr_thrust_in");
  self.sprintinitsfxtag scalevolume(1, 1);
  self.sprintinitsfxtag scalepitch(1, 1);

  for(;;) {
    earthquake(0.12, 0.15, self.origin, 2000);
    wait 0.1;
  }
}

function dronesprinteffectsoutlogic() {
  var_0 = 0.2;
  level.player setcinematicmotionoverride("iw8_rcplane");
  earthquake(0.17, 0.5, self.origin, 5000);
  self.sprintinitsfxtag scalevolume(1, 1);
  self.sprintinitsfxtag scalepitch(1, 1);
  dronestaticmbscreenfx(var_0);
  self.sprintsfxtag scalevolume(0, 1);
  self.enginesfxtag scalevolume(1, 1);
  self.sprinting = 0;
}

function player_waittillnearai(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = isDefined(var_3) && isDefined(var_4);

  if(istrue(var_5)) {
    var_7 = gettime() + var_5 * 1000;
  } else {
    var_7 = gettime();
  }

  var_8 = 0;
  var_9 = undefined;
  var_10 = var_2 * var_2;

  for(;;) {
    if(isDefined(var_3)) {
      var_11 = distancesquared(level.player.origin, var_3);
      var_12 = distancesquared(var_1.origin, var_3);
      var_13 = var_11 < var_12;

      if(var_13) {
        break;
      }
    }

    var_8 = distancesquared(level.player.origin, < error > .origin);

    if(var_8 <= var_7) {
      break;
    }

    if(var_4 && !var_6 && gettime() >= var_5) {
      var_15 = < error > getEye() + (0, 0, 30);
      var_7 = level_objectivegetindex();
      level_objectiveadd(var_1, var_15, var_2);
      var_6 = 1;
    }

    waitframe();
  }

  if(var_6) {
    objective_delete(var_7);
  }

  level notify("player_nearAI", < error > );
}

function player_waittilllookingatai(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  level.player endon("death");

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

function waittill_entitiesarewithindistance(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3) && isDefined(var_4)) {
    var_3 endon(var_4);
  }

  while(distancesquared(var_0.origin, var_1.origin) > squared(var_2)) {
    waitframe();
  }
}

function waittill_entitiesarewithindistancesquared(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3) && isDefined(var_4)) {
    var_3 endon(var_4);
  }

  while(distancesquared(var_0.origin, var_1.origin) > var_2) {
    waitframe();
  }
}

function waittill_entityisbehindentitydistance(var_0, var_1, var_2) {
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

function entity_isbehindentitydistance(var_0, var_1, var_2) {
  var_3 = entity_getbehindentitydistance(var_0, var_1);
  return var_3 < var_2;
}

function entity_isbesideentitydistance(var_0, var_1, var_2) {
  var_3 = entity_getlateralentitydistance(var_0, var_1);
  return var_3 < var_2;
}

function entity_getbehindentitydistance(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles) * -1;
  var_3 = var_1.origin - var_0.origin;
  var_4 = scripts\engine\math::scalar_projection(var_2, var_3);
  return var_4;
}

function entity_getbehindforwarddistance(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = var_1.origin - var_0.origin;
  var_4 = scripts\engine\math::scalar_projection(var_2, var_3);
  return var_4;
}

function entity_getlateralentitydistance(var_0, var_1) {
  var_2 = anglestoright(var_0.angles);
  var_3 = var_1.origin - var_0.origin;
  var_4 = scripts\engine\math::scalar_projection(var_2, var_3);
  return abs(var_4);
}

function entity_getnextclosestgoalinpath(var_0, var_1) {
  var_2 = var_1;
  var_3 = distance(var_0.origin, var_2.origin);
  var_4 = var_2;

  while(isDefined(var_2.target)) {
    var_5 = get_nexttargetedpathgoal(var_2);
    var_6 = var_5.origin - var_2.origin;
    var_7 = distance(pointonsegmentnearesttopoint(var_2.origin, var_5.origin, var_0.origin), var_0.origin);

    if(var_7 < var_3) {
      var_3 = var_7;
      var_4 = var_5;
    }

    var_2 = var_5;
  }

  return var_4;
}

function waittill_entityislateralentitydistance(var_0, var_1, var_2) {
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

function math_pointoncircle(var_0, var_1) {
  var_2 = var_0 * cos(var_1);
  var_3 = var_0 * sin(var_1);
  return (var_2, var_3, 0);
}

function math_pointonellipse(var_0, var_1) {
  var_2 = var_0 * cos(var_1);
  var_3 = var_0 * sin(var_1) * 0.5;
  return (var_2, var_3, 0);
}

function math_pointonlemniscate(var_0, var_1) {
  var_2 = var_0 * sqrt(2) * cos(var_1) / (squared(sin(var_1)) + 1);
  var_3 = var_0 * sqrt(2) * cos(var_1) * sin(var_1) / (squared(sin(var_1)) + 1);
  return (var_2, var_3, 0);
}

function level_droneambientmovementlogic(var_0, var_1, var_2, var_3) {
  var_4 = var_0.origin;
  var_5 = 0;
  var_6 = 360;
  var_7 = randomintrange(var_5, var_6);
  var_8 = var_4;

  for(;;) {
    var_9 = [[var_3]](var_1, var_7);
    var_10 = (0, 0, 100 * sin(var_7));
    var_11 = var_4 + var_9 + var_10;
    var_0.origin = var_11;
    var_0.angles = vectortoangles(var_11 - var_8);
    var_0 vibrate(var_0.angles, 10, 40, 0.05);
    var_7 = scripts\engine\math::wrap(0, 360, var_7 + var_2);
    var_8 = var_11;
    waitframe();
  }
}

function level_dronespawnVehicle(var_0, var_1) {
  var_2 = spawnVehicle("veh8_ind_air_bombing_drone", "level_droneVehicle", "drone_improvised", var_0, var_1);
  var_2.dontunloadonend = 1;
  var_2 playLoopSound("scn_safehouse_rc_plane_lp");
  return var_2;
}

function level_dronespawn(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("veh8_ind_air_bombing_drone");
  var_2 notsolid();
  var_2 hidepart("j_propeller");
  var_3 = "scn_safehouse_rc_plane_lp";

  if(scripts\engine\utility::flag("fob_center")) {
    var_3 = "scn_safehouse_rc_plane_lp_wide_falloff";
  }

  var_2 playLoopSound(var_3);
  playFXOnTag(level._effect["vfx_rc_plane_rotor"], var_2, "j_propeller");
  return var_2;
}

function level_dronevehiclepropellerlogic(var_0, var_1) {
  var_2 = 55;
  var_3 = (0, 0, 0);

  for(;;) {
    if(!isalive(var_0)) {
      break;
    }

    if(!isDefined(var_0)) {
      break;
    }

    var_1 unlink();
    var_3 += (0, 0, var_2);
    var_1 linkTo(var_0, "tag_origin", (10, 0, 3), var_3);
    waitframe();
  }

  var_1 delete();
}

function level_setcustomdeathhintindex(var_0) {
  level.custom_death_quote = var_0;
  setDvar("safehouse_deathHintIndex", var_0);
}

function level_getcustomdeathhintindex(var_0) {
  return getdvarint("safehouse_deathHintIndex");
}

function level_getcivilians() {
  var_0 = getaiarray("neutral");

  if(isDefined(level.drones) && isDefined(level.drones["neutral"]) && isDefined(level.drones["neutral"].array)) {
    var_0 = scripts\engine\sp\utility::array_merge(var_0, level.drones["neutral"].array);
  }

  return var_0;
}

function level_getdrones() {
  var_0 = scripts\engine\sp\utility::array_merge(level.drones["allies"].array, level.drones["axis"].array);
  var_0 = scripts\engine\sp\utility::array_merge(var_0, level.drones["neutral"].array);
  return var_0;
}

function level_setendofscripting() {
  iprintlnbold("End of Scripting");
  var_0 = 3;
  var_1 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_1 fadeovertime(var_0);
  var_1.alpha = 1;
  wait var_0;
  scripts\engine\sp\utility::nextmission();
}

function level_disablefriendlyfire() {
  setDvar("friendlyfire_dev_disabled", 1);
}

function level_enablefriendlyfire() {
  setDvar("friendlyfire_dev_disabled", 0);
}

function vehicle_getvehiclearray(var_0, var_1) {
  var_2 = vehicle_getarray();

  foreach(var_4 in var_2) {
    if(!scripts\engine\utility::is_equal([[var_1]](var_4), var_0)) {
      var_2 = scripts\engine\utility::array_remove(var_2, var_4);
    }
  }

  var_2 = array_removedeadvehicles(var_2);
  return var_2;
}

function vehicle_getvehicle(var_0, var_1) {
  var_2 = vehicle_getarray();

  foreach(var_4 in var_2) {
    if(!scripts\engine\utility::is_equal([[var_1]](var_4), var_0)) {
      var_2 = scripts\engine\utility::array_remove(var_2, var_4);
    }
  }

  var_2 = array_removedeadvehicles(var_2);
  return var_2[0];
}

function vehicles_turnonlights(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_5 scripts\common\vehicle::vehicle_lights_on(var_1);

    if(isDefined(var_2) && isDefined(var_3)) {
      var_6 = randomfloatrange(var_2, var_3);
      wait var_6;
    }
  }
}

function vehicle_lerpovertime(var_0, var_1, var_2, var_3) {
  var_4 = 1 / var_3 / 0.05;
  var_5 = 0;
  var_6 = var_0.origin;
  var_7 = var_0.angles;

  while(var_5 < 1) {
    var_8 = vectorlerp(var_6, var_1, var_5);
    var_9 = scripts\engine\math::fake_slerp(var_7, var_2, var_5);
    var_0 vehicle_teleport(var_8, var_9);
    var_5 += var_4;
    waitframe();
  }

  var_0 vehicle_teleport(var_1, var_2);
}

function enemy_alive_counter_gate(var_0) {
  wait 0.2;
  var_1 = getaiarray("axis");

  while(var_1.size > var_0) {
    var_1 = getaiarray("axis");
    wait 0.1;
  }

  return false;
}

function chopper_check() {
  var_1 = 0;

  if(isDefined(level.choppers) && level.choppers.size != 0) {
    foreach(var_3 in level.choppers) {
      if(isDefined(var_3)) {
        var_4 = distance(var_3.origin, var_0);

        if(var_4 < 500) {
          var_1 = 1;

          if(scripts\engine\utility::is_equal(var_3, level.boss_chopper)) {
            break;
          }

          var_2 scripts\sp\utility::do_damage(var_2.health + 500, < error > , level.player, undefined, "MOD_PROJECTILE");
          break;
        }
      }
    }

    var_0 = undefined;
    var_2 = undefined;
  }

  return < error > ;
}

function tromeo_check(var_0) {
  if(isDefined(level.tromeos) && level.tromeos.size != 0) {
    foreach(var_2 in level.tromeos) {
      if(isDefined(var_2)) {
        var_3 = distance(var_2.origin, var_0);

        if(var_3 < 300) {
          var_2 scripts\sp\utility::do_damage(var_2.health + 200, var_0);
        }
      }
    }

    return;
  }
}

function put_player_into_rig(var_0, var_1, var_2, var_3, var_4, var_5) {
  level.player hidelegsandshadow();
  level.player freezecontrols(0);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();

  if(var_1 > 0) {
    level.player playerlinktoblend(var_0, "tag_player", var_1, 0, 0);
    wait var_1;
  }

  level.player playerlinktodelta(var_0, "tag_player", 1, var_2, var_3, var_4, var_5, 1);
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var_0 show();
  var_0 castshadows();
}

function pull_player_out_of_rig_hide_rig(var_0) {
  level.player showlegsandshadow();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  var_0 hide();
  var_0 dontcastshadows();
  level.player enableweapons();
  level.player unlink();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

function focus_reminder(var_0, var_1) {
  if(!scripts\engine\utility::flag(var_0)) {
    level.player thread scripts\sp\player::focus_display_hint(undefined, var_1);
    return;
  }
}

function remove_corpses_away_from_player_pos(var_0) {
  var_1 = getcorpsearray();

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\engine\sp\utility::get_corpse_origin();

    if(distance(level.player.origin, var_4) > var_0) {
      scripts\engine\utility::array_remove(var_1, var_3);
      var_3 delete();
    }
  }

  var_1 = getcorpsearray();
}

function weapon_empty(var_0) {
  if(!isDefined(var_0)) {
    return 1;
  }

  return scripts\engine\utility::is_equal(var_0.basename, "none");
}

function weapon_issilenced(var_0) {
  foreach(var_2 in var_0.attachments) {
    if(issubstr(var_2, "silencer")) {
      return true;
    }
  }

  return false;
}

function get_closest_male_redshirt() {
  var_0 = scripts\sp\maps\safehouse_finale\safehouse_finale_fob::charge_getredshirts();
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(issubstr(var_4.voice, "female")) {
      continue;
    }

    var_5 = distance2dsquared(self.origin, var_4.origin);

    if(!isDefined(var_1) || var_5 < var_1) {
      var_1 = var_5;
      var_2 = var_4;
    }
  }

  return var_2;
}

function track_fob_helo_spawn() {
  if(!isDefined(level.fob_helo_count)) {
    level.fob_helo_count = 0;
  }

  level.fob_helo_count++;

  if(level.fob_helo_count > 0) {
    scripts\engine\utility::flag_clear("no_fob_helos_left");
    goto LOC_00000047;
  }

  jumpiffalse(level.fob_helo_count > 1) LOC_00000047;
  scripts\engine\utility::flag_clear("one_fob_helo_left");
  self waittill("death", var_0);
  level.fob_helo_count--;

  if(level.fob_helo_count == 1) {
    scripts\engine\utility::flag_set("one_fob_helo_left");
    return;
  }

  if(level.fob_helo_count == 0) {
    scripts\engine\utility::flag_set("no_fob_helos_left");
    wait 1;

    if(scripts\engine\utility::flag("boss_chopper_dead") || !scripts\engine\utility::is_equal(var_0, level.player)) {
      return;
    }

    say_as_chatter(level.player, "dx_vom_alx_fob_center_helos_300", 1, 3);
    return;
  }
}

function say(var_0, var_1, var_2, var_3, var_4) {
  if(!soundexists(var_0)) {
    return false;
  }

  if(is_dead_or_dying(self)) {
    return false;
  }

  self notify("started_speaking", var_0);
  self.lastspoketime = gettime();
  self.lastaliassaid = var_0;

  if(isPlayer(self) && isDefined(var_2) && !level.player issprinting()) {
    scripts\engine\sp\utility::player_gesture_force(var_2);

    if(isDefined(var_3)) {
      wait var_3;
    }

    if(!isDefined(var_4)) {
      var_4 = 0;
    }

    var_5 = lookupsoundlength(var_0) / 1000;
    thread stop_gesture_on_notify_or_timeout("sprint_pressed", var_5 + var_4);
  }

  if(istrue(var_1)) {
    if(isstruct(self)) {
      scripts\engine\sp\utility::smart_radio_dialogue_interrupt(var_0);
    } else if(isPlayer(self)) {
      scripts\engine\sp\utility::smart_player_dialogue_interrupt(var_0);
    } else if(isDefined(self.animname)) {
      self stopsounds();
      waitframe();
      scripts\engine\sp\utility::smart_dialogue(var_0);
    } else {
      if(issentient(self)) {
        self playsoundatviewheight(var_0);
      } else {
        self playSound(var_0);
      }

      wait lookupsoundlength(var_0) / 1000;
    }
  } else if(isstruct(self)) {
    scripts\engine\sp\utility::smart_radio_dialogue(var_0);
  } else if(isPlayer(self)) {
    scripts\engine\sp\utility::smart_player_dialogue(var_0);
  } else if(isDefined(self.animname)) {
    scripts\engine\sp\utility::smart_dialogue(var_0);
  } else {
    if(issentient(self)) {
      self playsoundatviewheight(var_0);
    } else {
      self playSound(var_0);
    }

    wait lookupsoundlength(var_0) / 1000;
  }

  self notify("finished_speaking", var_0);
  return true;
}

function stop_gesture_on_notify_or_timeout(var_0, var_1) {
  scripts\engine\utility::waittill_notify_or_timeout(var_0, var_1);
  self stopgestureviewmodel();
}

function is_dead_or_dying(var_0) {
  if(!isDefined(var_0)) {
    return true;
  }

  if(isai(var_0)) {
    return (!isalive(var_0) || var_0 scripts\engine\utility::doinglongdeath());
  } else if(issentient(var_0)) {
    return !isalive(var_0);
  }

  return false;
}

function is_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return 0;
  }

  return scripts\engine\utility::time_has_passed(self.lastspoketime, lookupsoundlength(self.lastaliassaid) / 1000);
}

function wait_finish_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return false;
  }

  var_0 = (gettime() - self.lastspoketime) / 1000;
  var_1 = lookupsoundlength(self.lastaliassaid) / 1000;

  if(var_0 < var_1) {
    wait var_1 - var_0;
  }

  return true;
}

function time_since_spoke() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return undefined;
  }

  var_0 = self.lastspoketime + lookupsoundlength(self.lastaliassaid);
  return (gettime() - var_0) / 1000;
}

function say_sequence(var_0, var_1) {
  var_2 = self;

  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  foreach(var_4 in var_0) {
    var_2 = say_vo_item(var_2, var_4, var_1);
  }
}

function say_vo_item(var_0, var_1) {
  var_2 = self;

  if(isarray(var_0)) {
    if((isint(var_0[0]) || isfloat(var_0[0])) && isint(var_0[1]) || isfloat(var_0[1])) {
      wait randomfloatrange(var_0[0], var_0[1]);
    } else if(isbuiltinfunction(var_0[0]) || isbuiltinmethod(var_0[0]) || isanimation(var_0[0])) {
      call_with_params(var_2, var_0[0], var_0[1]);
    }

    return var_2;
  }

  if(isent(var_0) || isstruct(var_0)) {
    var_2 = var_0;
  } else if(isstring(var_0)) {
    say(var_2, var_0, var_1);
  } else if(isint(var_0) || isfloat(var_0)) {
    wait var_0;
  } else if(isbuiltinfunction(var_0) || isbuiltinmethod(var_0) || isanimation(var_0)) {
    call_with_params(var_2, var_0);
  } else if(scripts\engine\sp\utility::is_deck(var_0)) {
    var_2 = say_vo_item(var_2, var_0 scripts\engine\sp\utility::deck_draw(), var_1);
  }

  return var_2;
}

function init_chatter() {
  level.vo_chatter = spawnStruct();
  level.vo_chatter.speaking = 0;
  level.vo_chatter.waiting = [];
}

function terminate_chatter() {
  level.vo_chatter notify("terminate_chatter");
  level.vo_chatter = undefined;
}

function say_as_chatter(var_0, var_1, var_2) {
  return do_as_chatter(&say, [var_0, var_1], var_1, var_2);
}

function say_as_chatter_with_gesture(var_0, var_1, var_2, var_3, var_4, var_5) {
  return do_as_chatter(&say, [var_1, var_4, var_0, var_2, var_3], var_4, var_5);
}

function say_sequence_as_chatter(var_0, var_1, var_2) {
  return do_as_chatter(&say_sequence, [var_0], var_1, var_2);
}

function wait_for_break_in_chatter(var_0) {
  var_1 = spawnStruct();
  var_2 = 0;

  if(!level.vo_chatter.speaking) {
    return 1;
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var_1);

  if(isDefined(var_0) && isstring(var_0)) {
    var_2 = scripts\engine\utility::waittill_any_ents_return(var_1, "proceed", self, var_0, level, var_0) == var_0;
  } else if(isDefined(var_0)) {
    var_2 = var_1 scripts\engine\utility::waittill_notify_or_timeout_return("proceed", var_0) == "timeout";
  } else {
    var_1 waittill("proceed");
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_remove(level.vo_chatter.waiting, var_1);
  return var_2;
}

function do_as_chatter(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vo_chatter)) {
    thread init_chatter();
  }

  level.vo_chatter endon("terminate_chatter");
  var_4 = spawnStruct();
  thread do_as_chatter_internal(var_0, var_1, var_2, var_3, var_4);
  var_4 waittill("done", var_5);
  return var_5;
}

function do_as_chatter_internal(var_0, var_1, var_2, var_3, var_4) {
  level.vo_chatter endon("terminate_chatter");

  if(level.vo_chatter.speaking && (!istrue(var_2) || isDefined(var_3))) {
    var_5 = wait_for_break_in_chatter(var_3);
  } else {
    var_5 = 0;
  }

  var_6 = undefined;

  if(!level.vo_chatter.speaking || !var_5 || istrue(var_3)) {
    level.vo_chatter notify("started_speaking", self, var_1, var_2);
    level.vo_chatter.speaking++;
    var_6 = call_with_params(var_1, var_2);
    level.vo_chatter.speaking--;
    level.vo_chatter notify("done_speaking", self, var_1, var_2);
  }

  if(!level.vo_chatter.speaking && isDefined(level.vo_chatter.waiting[0])) {
    level.vo_chatter.waiting[0] notify("proceed");
  }

  var_5 notify("done", var_6);
}

function call_with_params(var_0, var_1) {
  if(isbuiltinfunction(var_0)) {
    return call_with_params_script(var_0, var_1);
  }

  if(isbuiltinmethod(var_0) || isanimation(var_0)) {
    return call_with_params_builtin(var_0, var_1);
  }
}

function call_with_params_script(var_0, var_1) {
  if(!isDefined(var_1)) {
    return self[[var_0]]();
  }

  if(!isarray(var_1)) {
    return self[[var_0]](var_1);
  }

  switch (var_1.size) {
    case 0:
      return self[[var_0]]();
    case 1:
      return self[[var_0]](var_1[0]);
    case 2:
      return self[[var_0]](var_1[0], var_1[1]);
    case 3:
      return self[[var_0]](var_1[0], var_1[1], var_1[2]);
    case 4:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
    case 5:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
    case 6:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
    case 7:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
    case 8:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
    case 9:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8]);
    default:
      break;
  }
}

function call_with_params_builtin(var_0, var_1) {
  if(!isDefined(var_1)) {
    return self[[var_0]]();
  }

  if(!isarray(var_1)) {
    return self builtin[[var_0]](var_1);
  }

  switch (var_1.size) {
    case 0:
      return self builtin[[var_0]]();
    case 1:
      return self builtin[[var_0]](var_1[0]);
    case 2:
      return self builtin[[var_0]](var_1[0], var_1[1]);
    case 3:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2]);
    case 4:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
    case 5:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
    case 6:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
    case 7:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
    case 8:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
    case 9:
      return self builtin[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8]);
    default:
      break;
  }
}

function nagtill_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = spawnStruct();
  var_9 endon("stop");
  var_9 scripts\engine\utility::delaythread(var_0, &scripts\engine\utility::send_notify, "stop");
  nagtill(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

function nagtill_delayed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1)) {
    if(!isarray(var_1)) {
      var_1 = [var_1];
    }

    foreach(var_11 in var_1) {
      var_12 = scripts\engine\utility::flag_exist(var_11) && scripts\engine\utility::ter_op(istrue(var_9), !scripts\engine\utility::flag(var_11), scripts\engine\utility::flag(var_11));

      if(var_12) {
        return;
      }

      level endon(var_11);
      self endon(var_11);
    }
  }

  wait var_0;
  nagtill(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

function nagtill_open(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1);
}

function nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_2 = default_if_undefined(var_2, 8);
  var_3 = default_if_undefined(var_3, 1.5);
  var_4 = default_if_undefined(var_4, 20);
  var_5 = default_if_undefined(var_5, 2);
  var_6 = default_if_undefined(var_6, 1.2);
  var_7 = default_if_undefined(var_7, 5);
  var_9 = isnumber(var_2) && var_4 > var_2;
  var_10 = var_7 > var_5;

  if(isDefined(var_0)) {
    if(!isarray(var_0)) {
      var_0 = [var_0];
    }

    foreach(var_12 in var_0) {
      var_13 = scripts\engine\utility::flag_exist(var_12) && scripts\engine\utility::ter_op(istrue(var_8), !scripts\engine\utility::flag(var_12), scripts\engine\utility::flag(var_12));

      if(var_13) {
        return;
      }

      level endon(var_12);
    }
  }

  jumpiffalse(isarray(var_1)) LOC_000000e0;
  var_1 = scripts\engine\sp\utility::create_deck(var_1, 0);
  var_1.autoshuffle = 1;

  for(;;) {
    if(var_1 scripts\engine\sp\utility::deck_is_empty()) {
      array_deck_shuffle(var_1);
    }

    var_15 = self;
    var_16 = var_1 scripts\engine\sp\utility::deck_draw();

    if(isarray(var_16)) {
      var_15 = var_16[0];
      var_16 = var_16[1];
    }

    thread notify_started_nag(var_15);
    say_as_chatter(var_15, var_16);
    level notify("said_nag", var_15, var_16);

    if(isnumber(var_2)) {
      wait randomfloatrange(var_2 - var_5, var_2 + var_5);

      if(var_9) {
        var_2 = min(var_2 * var_3, var_4);
      } else {
        var_2 = max(var_2 * var_3, var_4);
      }

      if(var_10) {
        var_5 = min(var_5 * var_6, var_7);
      } else {
        var_5 = max(var_5 * var_6, var_7);
      }

      continue;
    }

    scripts\engine\utility::waittill_any_ents(level, var_2, self, var_2);
  }
}

function notify_started_nag(var_0) {
  if(!isDefined(self) || !isDefined(var_0)) {
    return;
  }

  self waittillmatch("started_speaking", var_0);
  level notify("started_nag", self, var_0);
}

function compare(var_0, var_1) {
  if(isarray(var_0)) {
    if(isarray(var_1)) {
      return compare_arrays(var_0, var_1);
    }

    return 0;
  }

  if(isarray(var_1)) {
    return 0;
  }

  return var_0 == var_1;
}

function compare_arrays(var_0, var_1) {
  if(var_0.size != var_1.size) {
    return false;
  }

  foreach(var_3 in var_0) {
    if(!isDefined(var_1[var_5])) {
      return false;
    }

    var_4 = var_1[var_5];

    if(compare(var_4, var_3)) {
      return false;
    }
  }

  return true;
}

function array_deck_shuffle() {
  var_0 = self;
  var_0.index = 0;
  var_0.items = scripts\engine\utility::array_randomize(var_0.items);

  if(!var_0.prevent_redraw || !isDefined(var_0.last_drawn) || var_0.items.size <= 1) {
    return;
  }

  var_1 = compare(var_0.items[0], var_0.last_drawn);

  if(var_1) {
    var_2 = randomintrange(1, var_0.items.size);
    var_3 = var_0.items[0];
    var_0.items[0] = var_0.items[var_2];
    var_0.items[var_2] = var_3;
    return;
  }
}

function default_if_undefined(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = var_1;
  }

  return var_0;
}

function wait_combat_cooldown(var_0, var_1) {
  while(!isDefined(var_1) || var_1 > 0) {
    if(!recently_in_combat(var_0)) {
      return false;
    }

    waitframe();

    if(isDefined(var_1)) {
      var_1 -= 0.05;
    }
  }

  return true;
}

function recently_in_combat(var_0) {
  var_1 = isDefined(level.player.last_weapon_fire_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var_0);
  var_2 = isDefined(level.player.last_damaged_time) && !scripts\engine\utility::time_has_passed(level.player.last_damaged_time, var_0);
  return level.player isfiring() || var_1 || var_2;
}

function track_player_combat_time() {
  level.player endon("death");

  for(;;) {
    var_0 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "damage") == "weapon_fired";

    if(var_0) {
      level.player.last_weapon_fire_time = gettime();
      continue;
    }

    level.player.last_damaged_time = gettime();
  }
}

function wait_lookat_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return wait_lookat(var_0, var_1, var_3, var_4, var_5, var_6, var_2, 1);
}

function wait_lookat_ads_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return wait_lookat_ads(var_0, var_1, var_3, var_4, var_5, var_6, var_2);
}

function wait_lookat_ads(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!istrue(var_5)) {
    var_5 = 0;
  }

  return wait_lookat(var_0, var_1, var_2, var_3, var_4, var_5, var_6, 1);
}

function wait_lookat(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_3)) {
    var_3 *= 1000;
  } else {
    var_3 = 0;
  }

  var_8 = undefined;

  while(!isDefined(var_8) || gettime() - var_8 <= var_3) {
    if(!isDefined(var_0)) {
      return;
    }

    if(isDefined(var_4)) {
      wait_near(level.player, var_0, var_4);
    }

    var_9 = is_looking_at(var_0, var_1, var_2, var_5);

    if(istrue(var_7)) {
      var_9 = var_9 && level.player scripts\engine\sp\utility::isads();
    }

    if(var_9 && !isDefined(var_8)) {
      var_8 = gettime();
    } else if(!var_9) {
      var_8 = undefined;
    }

    if(var_9 && (!isDefined(var_3) || var_3 == 0)) {
      break;
    }

    waitframe();

    if(isDefined(var_6)) {
      var_6 -= 0.05;

      if(var_6 <= 0) {
        return 0;
      }
    }
  }

  return 1;
}

function is_looking_at(var_0, var_1, var_2, var_3) {
  if(isent(var_0) && isDefined(var_2)) {
    var_4 = var_0 gettagorigin(var_2);
  } else if((isent(var_1) || isstruct(var_1)) && isDefined(var_1.origin)) {
    var_4 = var_1.origin;
  } else {
    var_4 = var_2;
  }

  var_5 = level.player worldpointtoscreenpos(var_4, getdvarint("MRNKTKLLKP"));

  if(!isDefined(var_5)) {
    return 0;
  }

  if(isDefined(var_3) && length2d(var_5) > var_3) {
    return 0;
  }

  if(!isDefined(var_4) || var_4) {
    jumpiffalse(isent(var_2)) LOC_00000098;
    var_6 = [level.player, var_2];
    goto LOC_000000a3;
  } else {
    var_7 = 1;
  }

  return var_7;
}

function wait_near(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = var_0;

  for(;;) {
    if(isent(var_0)) {
      var_3 = var_0.origin;
    }

    if(distance2dsquared(self.origin, var_3) < var_2) {
      break;
    }

    waitframe();
  }
}

function say_line_on_enemy_radio(var_0, var_1, var_2, var_3) {
  var_1 = default_if_undefined(var_1, 2);
  var_2 = default_if_undefined(var_2, 3);
  var_3 = default_if_undefined(var_3, 0.8);
  wait_combat_cooldown(var_3, var_2);

  for(;;) {
    var_4 = getcorpsearrayinradius(level.player.origin, 300);

    if(var_4.size == 0) {} else {
      var_5 = undefined;
      var_6 = undefined;

      foreach(var_8 in var_4) {
        if(getsubstr(var_8.classname, 0, 11) != "actor_enemy") {
          continue;
        }

        var_9 = distance2dsquared(level.player.origin, var_8 gettagorigin("j_chest"));

        if(!isDefined(var_6) || var_9 < var_6) {
          var_5 = var_8;
          var_6 = var_9;
        }
      }

      if(!isDefined(var_5)) {} else {
        var_11 = var_5 gettagorigin("j_chest");
        var_12 = var_5 gettagangles("j_chest");
        var_13 = scripts\engine\utility::spawn_script_origin(var_11, var_12);
        var_13 linkTo(var_5, "j_chest");
        wait_for_break_in_chatter(var_1);
        say(var_13, var_0, 1);
        return;
      }
    }

    waitframe();
  }
}