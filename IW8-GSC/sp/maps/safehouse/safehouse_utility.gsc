/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\safehouse\safehouse_utility.gsc
***************************************************/

ai_setname(var_0, var_1) {
  var_0.name = var_1;
}

ai_sethackedname(var_0, var_1) {
  var_0.hackedname = var_1;
}

ai_isridingvehicle(var_0) {
  return isDefined(var_0.ridingvehicle);
}

ai_shoot(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  var_0 notify("shooting");
  var_0 shoot();
}

ai_removesidearm(var_0) {
  var_0.sidearm = isundefinedweapon();
}

ai_isvehicledriver(var_0, var_1) {
  if(!scripts\engine\utility::is_equal(var_0.ridingvehicle, var_1))
    return 0;

  if(!scripts\engine\utility::is_equal(var_0.vehicle_position, 0))
    return 0;

  return 1;
}

ai_setlookatentity(var_0) {
  if(isDefined(var_0)) {
    if(!isDefined(self.lookatentities))
      self.lookatentities = [];

    self.lookatentities = scripts\engine\utility::array_add(self.lookatentities, var_0);
    scripts\common\utility::lookatentity(var_0);
  } else if(isDefined(self.lookatentities) && isDefined(self.lookatentities.size)) {
    var_1 = self.lookatentities.size - 1;
    self.lookatentities = scripts\engine\utility::array_remove_index(self.lookatentities, var_1, 1);

    if(self.lookatentities.size) {
      var_2 = self.lookatentities[self.lookatentities.size - 1];
      scripts\common\utility::lookatentity(var_2);
      return;
    }

    scripts\common\utility::lookatentity();
    return;
  } else
    scripts\common\utility::lookatentity();
}

ai_takecoveratnearestnodeinarray(var_0) {
  var_1 = sortbydistance(var_0, self.origin)[0];
  self setgoalnode(var_1);
  return var_1;
}

ai_resetstances() {
  self allowedstances("stand", "crouch", "prone");
}

ai_instantlyremovefromvehicle(var_0) {
  var_0._blackboard.currentvehicle = undefined;
  var_0.ridingvehicle = undefined;
  var_0 unlink();
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

ai_attachhead(var_0, var_1) {
  if(isDefined(var_0.headmodel))
    var_0 detach(var_0.headmodel);

  var_0.headmodel = var_1;
  var_0 attach(var_0.headmodel, "", 1);
}

ai_attachhat(var_0, var_1) {
  ai_detachhat(var_0);
  var_0.hatmodel = var_1;
  var_0 attach(var_0.hatmodel, "", 1);
}

ai_detachhat(var_0) {
  if(isDefined(var_0.hatmodel))
    var_0 detach(var_0.hatmodel);

  var_0.hatmodel = undefined;
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

ai_setaimassist(var_0) {
  if(var_0)
    self actoraimassiston();
  else
    self actoraimassistoff();
}

ai_iscivilian(var_0) {
  return var_0.asmname == "civilian";
}

ai_movealongpath(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_0 endon("entitydeleted");

  if(isDefined(var_2)) {
    var_5 = level_objectivegetindex();
    level_objectiveadd(var_2, var_0.origin, &"SAFEHOUSE/FOLLOW");
    objective_onentity(var_5, var_0);
    objective_setzoffset(var_5, 75);
    thread ai_movealongpathcleanupobjectivelogic(var_0, var_5);
  } else
    var_5 = undefined;

  var_0 childthread scripts\sp\spawner::go_to_node(var_1, var_3, var_4);
  var_0 waittill("reached_path_end");

  if(isDefined(var_2))
    objective_delete(var_5);
}

ai_endpathlogic(var_0) {
  var_0 notify("stop_going_to_node");
}

ai_movealongpathcleanupobjectivelogic(var_0, var_1) {
  var_0 scripts\engine\utility::waittill_any("death", "entitydeleted");
  objective_delete(var_1);
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

ai_dogfightbarklogic(var_0) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_1 = 1.75;
  wait(var_1);
  var_2 = 0.8;
  var_3 = 1.5;

  for(;;) {
    var_0 scripts\engine\sp\utility::play_sound_on_entity("anml_dog_attack_jump");
    var_4 = randomfloatrange(var_2, var_3);
    wait(var_4);
  }
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

  if(isarray(var_4))
    var_4 = var_4[0];

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

ai_getanimationoriginattimeoverframe(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_0.origin);
  var_4.angles = var_0.angles;
  var_4.animname = var_0.animname;
  var_4 setModel(var_0.model);
  var_4 scripts\common\anim::setanimtree();
  var_4 hide();
  var_2 thread scripts\common\anim::anim_single_solo(var_4, var_1);
  var_2 scripts\common\anim::anim_set_time_solo(var_4, var_1, var_3);
  waitframe();
  var_5 = var_4 gettagorigin("tag_origin");
  var_4 delete();
  return var_5;
}

ai_dieondamageduringanimation(var_0, var_1) {
  thread ai_dieondamageduringanimationnotifylogic(var_0, var_1);
  var_0 endon(var_1 + "End");
  ai_ragdolldeathondamage(var_0);
}

ai_dieondamageduringanimationnotifylogic(var_0, var_1) {
  var_0 waittillmatch("single anim", "end");
  var_0 notify(var_1 + "End");
}

ai_ragdolldeathondamage(var_0) {
  var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5);
  animation_stoploop(var_0);
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_0.skipdeathanim = 1;

  if(isPlayer(var_2))
    var_6 = var_2.currentweapon;
  else
    var_6 = undefined;

  var_0 scripts\sp\utility::do_damage(var_0.health + 999999, var_4, var_2, var_2, var_5, var_6);
}

ai_killondamage(var_0) {
  var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  var_0 scripts\sp\utility::do_damage(var_0.health + 999999, var_4, var_2, var_2, var_5, var_7);
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

call_on_notify_no_self(var_0, var_1, var_2, var_3) {
  self waittill(var_0);

  if(isDefined(var_3))
    call[[var_1]](var_2, var_3);
  else if(isDefined(var_2))
    call[[var_1]](var_2);
  else
    call[[var_1]]();
}

call_on_notetrack(var_0, var_1) {
  animation_waittillnotetrack(self, var_0);
  self call[[var_1]]();
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

  if(soundexists(var_0)) {
    if(isPlayer(self))
      scripts\engine\sp\utility::smart_player_dialogue(var_0);
    else if(istrue(var_4))
      scripts\engine\sp\utility::smart_radio_dialogue(var_0);
    else
      scripts\engine\sp\utility::smart_dialogue(var_0);

    self notify("dialogue_finished");
  } else {
    if(scripts\engine\utility::is_equal(self.team, "axis"))
      var_11 = "^1";
    else
      var_11 = "^2";

    if(istrue(var_4)) {
      if(isDefined(self.name))
        var_12 = var_11 + self.name + " Over Radio" + ": " + "^7" + var_0;
      else
        var_12 = "Over Radio: " + var_0;
    } else if(isDefined(self.name))
      var_12 = var_11 + self.name + ": " + "^7" + var_0;
    else
      var_12 = var_0;

    thread dialogue_proc(var_12, var_1);
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

dialogue_naglogic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("death");
  var_9 = spawnStruct();
  var_9 endon("dialogue_endNag");

  if(isDefined(var_2) && isDefined(var_3))
    thread dialogue_nagendonlogic(var_9, var_2, var_3);

  childthread dialogue_naglogic_proc(var_9, var_4, var_0, var_1, var_5, var_6, var_7, var_8);
}

dialogue_naglogic_proc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(istrue(var_1))
    wait(var_1);

  var_8 = 0;

  for(;;) {
    if(isDefined(var_4) && isDefined(var_5) && isDefined(var_6))
      childthread dialogue_naganimationlogic(var_4, var_5, var_6, var_7);

    var_9 = 0;
    var_10 = var_2[var_8];
    var_8++;
    var_9 = var_8 >= var_2.size;
    thread dialogue(var_10);

    if(soundexists(var_10)) {
      var_11 = lookupsoundlength(var_10) * 0.001;
      wait(var_11);
    }

    if(var_9) {
      break;
    }

    wait(var_3);
  }
}

dialogue_naganimationlogic(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      animation_stoploop(var_5);
      childthread animation_singleintoloop(var_2, var_5, var_0, var_1);
    }
  }

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
      scripts\engine\utility::array_any_wait(var_1, var_2);
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
    scripts\engine\utility::array_any_wait(var_1, var_2);
  else
    var_1 waittill(var_2);

  var_0 notify("dialogue_endNag");
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

get_cursorhintent(var_0) {
  return var_0.cursor_hint_ent;
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

get_nexttargetedpathgoal(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = getnode(var_0.target, "targetname");

  if(isDefined(var_1))
    return var_1;

  if(isDefined(var_2))
    return var_2;

  return undefined;
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

level_objectiveadd(var_0, var_1, var_2) {
  var_3 = level_objectivegetindex();
  objective_addalltomask(var_3);
  objective_state(var_3, "current");
  objective_setdescription(var_3, var_0);

  if(isDefined(var_1))
    objective_position(var_3, var_1);

  if(isDefined(var_2))
    objective_setlabel(var_3, var_2);

  level_objectiveincrementindex();
  return var_3;
}

level_objectivegetindex() {
  return level.objectiveindex;
}

level_objectivegetpreviousindex() {
  return int(max(level.objectiveindex - 1, 0));
}

level_objectivecreatefollowai(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    var_1 = 72;

  var_3 = level_objectivegetindex();
  level_objectiveadd(var_2, var_0.origin, &"SAFEHOUSE/LABEL_FOLLOW");
  objective_onentity(var_3, var_0);
  objective_setzoffset(var_3, var_1);
  return var_3;
}

level_deletepreviousobjective() {
  var_0 = level_objectivegetpreviousindex();
  objective_delete(var_0);
}

level_objectiveincrementindex() {
  var_0 = level_objectivegetindex();
  var_1 = scripts\engine\math::wrap(0, 31, var_0 + 1);
  level_objectivesetindex(var_1);
}

level_objectivesetindex(var_0) {
  level.objectiveindex = var_0;
}

player_isprone() {
  return level.player getstance() == "prone";
}

player_waittillnearai(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
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

  foreach(var_9 in var_6) {
    foreach(var_11 in var_7)
    var_9 endon(var_11);
  }

  var_14 = isDefined(var_3) && isDefined(var_4);

  if(var_14)
    var_15 = level_objectivecreatefollowai(var_0, undefined, var_3);
  else
    var_15 = undefined;

  if(istrue(var_5))
    level.player scripts\sp\player::focus_display_hint(var_5, undefined, var_6, var_7);

  var_16 = var_1 * var_1;

  for(;;) {
    if(isDefined(var_2)) {
      var_17 = distancesquared(level.player.origin, var_2);
      var_18 = distancesquared(var_0.origin, var_2);
      var_19 = var_17 < var_18;

      if(var_19) {
        break;
      }
    }

    var_20 = distancesquared(level.player.origin, var_0.origin);

    if(var_20 <= var_16) {
      break;
    }

    waitframe();
  }

  if(isDefined(var_15))
    objective_delete(var_15);

  level notify("player_nearAI", var_0);
}

player_waittilllookingatai(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_3)) {
    if(!isarray(var_3))
      var_3 = [var_3];
  } else
    var_3 = [];

  if(isDefined(var_4)) {
    if(!isarray(var_4))
      var_4 = [var_4];
  } else
    var_4 = [];

  var_3 = scripts\engine\sp\utility::array_merge(var_3, [var_0, level, level.player]);
  var_4 = scripts\engine\sp\utility::array_merge(var_4, ["death", "entitydeleted", "player_nearAI"]);

  foreach(var_6 in var_3) {
    foreach(var_8 in var_4)
    var_6 endon(var_8);
  }

  if(isDefined(var_2))
    var_11 = gettime() + var_2 * 1000;
  else
    var_11 = undefined;

  for(;;) {
    if(isDefined(var_11) && gettime() >= var_11) {
      break;
    }

    var_12 = level.player getEye();
    var_13 = var_0 getEye();
    var_14 = anglesToForward(level.player getplayerangles());
    var_15 = vectorNormalize(var_13 - var_12);
    var_16 = vectordot(var_14, var_15);
    var_17 = var_16 >= var_1;
    var_18 = sighttracepassed(var_12, var_13, 0, level.player, 1);

    if(var_17 && var_18) {
      break;
    }

    waitframe();
  }
}

thread_on_notetrack(var_0, var_1) {
  animation_waittillnotetrack(self, var_0);
  self thread[[var_1]]();
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

entity_getnextclosestgoalinpath(var_0, var_1) {
  var_2 = var_1;
  var_3 = distance(var_0.origin, var_2.origin);

  for(var_4 = var_2; isDefined(var_2.target); var_2 = var_5) {
    var_5 = get_nexttargetedpathgoal(var_2);
    var_6 = var_5.origin - var_2.origin;
    var_7 = distance(pointonsegmentnearesttopoint(var_2.origin, var_5.origin, var_0.origin), var_0.origin);

    if(var_7 < var_3) {
      var_3 = var_7;
      var_4 = var_5;
    }
  }

  return var_4;
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

waittill_time(var_0) {
  while(gettime() < var_0)
    waitframe();
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

level_setcustomdeathhintindex(var_0) {
  if(isDefined(level_getcustomoverridedeathhintindex())) {
    return;
  }
  level.custom_death_quote = var_0;

  if(!isDefined(var_0)) {
    return;
  }
  setDvar("safehouse_deathHintIndex", var_0);
}

level_getsafehousecustomdeathhintindex(var_0) {
  return getdvarint("safehouse_deathHintIndex");
}

level_setcustomoverridedeathhintindex(var_0) {
  level.custom_death_override_quote = var_0;
  level.custom_death_quote = var_0;
}

level_getcustomoverridedeathhintindex(var_0) {
  return level.custom_death_override_quote;
}

level_getcivilians() {
  var_0 = getaiarray("neutral");

  if(isDefined(level.drones) && isDefined(level.drones["neutral"]) && isDefined(level.drones["neutral"].array))
    var_0 = scripts\engine\sp\utility::array_merge(var_0, level.drones["neutral"].array);

  return var_0;
}

level_getdrones() {
  var_0 = scripts\engine\sp\utility::array_merge(level.drones["allies"].array, level.drones["axis"].array);
  var_0 = scripts\engine\sp\utility::array_merge(var_0, level.drones["neutral"].array);
  return var_0;
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

level_disablefriendlyfire() {
  setDvar("friendlyfire_dev_disabled", 1);
}

level_enablefriendlyfire() {
  setDvar("friendlyfire_dev_disabled", 0);
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

vehicle_maketurretsunusable(var_0) {
  if(isDefined(var_0.mainturret))
    var_0.mainturret makeunusable();

  if(isDefined(var_0.mgturret)) {
    foreach(var_2 in var_0.mgturret)
    var_2 makeunusable();
  }
}

vehicle_getdriver(var_0) {
  if(!isDefined(var_0.riders)) {
    return;
  }
  if(!var_0.riders.size) {
    return;
  }
  foreach(var_2 in var_0.riders) {
    if(!ai_isvehicledriver(var_2, var_0)) {
      continue;
    }
    return var_2;
  }

  return;
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

vehicle_suspenddriveanimations(var_0) {
  var_0 notify("suspend_drive_anims");

  if(isDefined(level.vehicle.templates.driveidle[var_0.model]))
    var_0 clearanim(level.vehicle.templates.driveidle[var_0.model], 0);

  if(isDefined(level.vehicle.templates.driveidle_r[var_0.model]))
    var_0 clearanim(level.vehicle.templates.driveidle_r[var_0.model], 0);
}

weapon_empty(var_0) {
  if(!isDefined(var_0))
    return 1;

  return scripts\engine\utility::is_equal(var_0.basename, "none");
}

weapon_issilenced(var_0) {
  foreach(var_2 in var_0.attachments) {
    if(issubstr(var_2, "silencer"))
      return 1;
  }

  return 0;
}

weapon_hassight(var_0) {
  var_1 = ["reflex", "holo", "acog", "thermal", "hybrid", "reddot"];

  foreach(var_3 in var_0.attachments) {
    foreach(var_5 in var_1) {
      if(issubstr(var_3, var_5))
        return 1;
    }
  }

  return 0;
}