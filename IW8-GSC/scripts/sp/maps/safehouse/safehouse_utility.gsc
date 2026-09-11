/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\safehouse\safehouse_utility.gsc
***********************************************************/

function ai_setname(var0, var1) {
  var0.name = var1;
}

function ai_sethackedname(var0, var1) {
  var0.hackedname = var1;
}

function ai_isridingvehicle(var0) {
  return isDefined(var0.ridingvehicle);
}

function ai_shoot(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(!isalive(var0)) {
    return;
  }

  var0 notify("shooting");
  var0 shoot();
}

function ai_removesidearm(var0) {
  var0.sidearm = isundefinedweapon();
}

function ai_isvehicledriver(var0, var1) {
  if(!scripts\engine\utility::is_equal(var0.ridingvehicle, var1)) {
    return false;
  }

  if(!scripts\engine\utility::is_equal(var0.vehicle_position, 0)) {
    return false;
  }

  return true;
}

function ai_setlookatentity(var0) {
  if(isDefined(var0)) {
    if(!isDefined(self.lookatentities)) {
      self.lookatentities = [];
    }

    self.lookatentities = scripts\engine\utility::array_add(self.lookatentities, var0);
    scripts\common\utility::lookatentity(var0);
    return;
  }

  if(isDefined(self.lookatentities) && isDefined(self.lookatentities.size)) {
    var1 = self.lookatentities.size - 1;
    self.lookatentities = scripts\engine\utility::array_remove_index(self.lookatentities, var1, 1);

    if(self.lookatentities.size) {
      var2 = self.lookatentities[self.lookatentities.size - 1];
      scripts\common\utility::lookatentity(var2);
      return;
    }

    scripts\common\utility::lookatentity();
    return;
  }

  scripts\common\utility::lookatentity();
}

function ai_takecoveratnearestnodeinarray(var0) {
  var1 = sortbydistance(var0, self.origin)[0];
  self setgoalnode(var1);
  return var1;
}

function ai_resetstances() {
  self allowedstances("stand", "crouch", "prone");
}

function ai_instantlyremovefromvehicle(var0) {
  var0._blackboard.currentvehicle = undefined;
  var0.ridingvehicle = undefined;
  var0 unlink();
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

function ai_attachhead(var0, var1) {
  if(isDefined(var0.headmodel)) {
    var0 detach(var0.headmodel);
  }

  var0.headmodel = var1;
  var0 attach(var0.headmodel, "", 1);
}

function ai_attachhat(var0, var1) {
  ai_detachhat(var0);
  var0.hatmodel = var1;
  var0 attach(var0.hatmodel, "", 1);
}

function ai_detachhat(var0) {
  if(isDefined(var0.hatmodel)) {
    var0 detach(var0.hatmodel);
  }

  var0.hatmodel = undefined;
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

function ai_setaimassist(var0) {
  if(var0) {
    self actoraimassiston();
    return;
  }

  self actoraimassistoff();
}

function ai_iscivilian(var0) {
  return var0.asmname == "civilian";
}

function ai_movealongpath(var0, var1, var2, var3, var4) {
  var0 endon("death");
  var0 endon("entitydeleted");

  if(isDefined(var2)) {
    var5 = level_objectivegetindex();
    level_objectiveadd(var2, var0.origin, &"SAFEHOUSE/FOLLOW");
    objective_onentity(var5, var0);
    objective_setzoffset(var5, 75);
    thread ai_movealongpathcleanupobjectivelogic(var0, var5);
  } else {
    var5 = undefined;
  }

  var1 childthread scripts\sp\spawner::go_to_node(var2, var4, var5);
  var1 waittill("reached_path_end");

  if(isDefined(var3)) {
    objective_delete(var5);
    return;
  }
}

function ai_endpathlogic(var0) {
  var0 notify("stop_going_to_node");
}

function ai_movealongpathcleanupobjectivelogic(var0, var1) {
  var0 scripts\engine\utility::waittill_any("death", "entitydeleted");
  objective_delete(var1);
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

function ai_dogfightbarklogic(var0) {
  var0 endon("death");
  var0 endon("entitydeleted");
  var1 = 1.75;
  wait var1;
  var2 = 0.8;
  var3 = 1.5;

  for(;;) {
    var0 scripts\engine\sp\utility::play_sound_on_entity("anml_dog_attack_jump");
    var4 = randomfloatrange(var2, var3);
    wait var4;
  }
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

  if(isarray(var4)) {
    var4 = var4[0];
  }

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

function ai_getanimationoriginattimeoverframe(var0, var1, var2, var3) {
  var4 = spawn("script_model", var0.origin);
  var4.angles = var0.angles;
  var4.animname = var0.animname;
  var4 setModel(var0.model);
  var4 scripts\common\anim::setanimtree();
  var4 hide();
  var2 thread scripts\common\anim::anim_single_solo(var4, var1);
  var2 scripts\common\anim::anim_set_time_solo(var4, var1, var3);
  waitframe();
  var5 = var4 gettagorigin("tag_origin");
  var4 delete();
  return var5;
}

function ai_dieondamageduringanimation(var0, var1) {
  thread ai_dieondamageduringanimationnotifylogic(var0, var1);
  var0 endon(var1 + "End");
  ai_ragdolldeathondamage(var0);
}

function ai_dieondamageduringanimationnotifylogic(var0, var1) {
  var0 waittillmatch("single anim", "end");
  var0 notify(var1 + "End");
}

function ai_ragdolldeathondamage(var0) {
  var0 waittill("damage", var1, var2, var3, var4, var5);
  animation_stoploop(var0);
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  var0.skipdeathanim = 1;

  if(isPlayer(var2)) {
    var6 = var2.currentweapon;
  } else {
    var6 = undefined;
  }

  var1 scripts\sp\utility::do_damage(var1.health + 999999, var5, var3, var3, var6, var6);
}

function ai_killondamage(var0) {
  var0 waittill("damage", var1, var2, var3, var4, var5, var6, var6, var6, var6, var7);
  var0 scripts\sp\utility::do_damage(var0.health + 999999, var4, var2, var2, var5, var7);
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

function call_on_notetrack(var0, var1) {
  animation_waittillnotetrack(self, var0);
  self builtin[[var1]]();
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

  if(soundexists(var0)) {
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
    var11 = "^1";
  } else {
    var11 = "^2";
  }

  if(istrue(var11)) {
    if(isDefined(self.name)) {
      var12 = var11 + self.name + " Over Radio" + ": " + "^7" + var1;
    } else {
      var12 = "Over Radio: " + var2;
    }
  } else if(isDefined(self.name)) {
    var12 = var12 + self.name + ": " + "^7" + var3;
  } else {
    var12 = var4;
  }

  thread dialogue_proc(var12, var11);
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

function dialogue_naglogic(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  self endon("death");
  var9 = spawnStruct();
  var9 endon("dialogue_endNag");

  if(isDefined(var2) && isDefined(var3)) {
    thread dialogue_nagendonlogic(var9, var2, var3);
  }

  GscBinSkip4(0x35, var9, var4, var0, var1, var5, var6, var7, var8);
}

function dialogue_naglogic_proc(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(istrue(var1)) {
    wait var1;
  }

  var8 = 0;

  for(;;) {
    if(isDefined(var4) && isDefined(var5) && isDefined(var6)) {
      GscBinSkip4(0x35, var4, var5, var6, var7);
    }

    var9 = 0;
    var10 = var2[var8];
    var8++;
    var9 = var8 >= var2.size;
    thread dialogue(var10);

    if(soundexists(var10)) {
      var11 = lookupsoundlength(var10) * 0.001;
      wait var11;
    }

    if(var9) {
      break;
    }

    wait var3;
  }
}

function dialogue_naganimationlogic(var0, var1, var2, var3) {
  if(isDefined(var3)) {
    var4 = var3;
    var6 = getfirstarraykey(var4);

    if(isDefined(var6)) {
      var5 = var4[var6];
      animation_stoploop(var5);
      GscBinSkip4(0x35, var2, var5, var0, var1);
    }

    var4 = undefined;
    var6 = undefined;
  }

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

    scripts\engine\utility::array_any_wait(var1, var2);
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
    scripts\engine\utility::array_any_wait(var1, var2);
  } else {
    var1 waittill(var2);
  }

  var0 notify("dialogue_endNag");
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

function get_cursorhintent(var0) {
  return var0.cursor_hint_ent;
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

function get_nexttargetedpathgoal(var0) {
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var2 = getnode(var0.target, "targetname");

  if(isDefined(var1)) {
    return var1;
  }

  if(isDefined(var2)) {
    return var2;
  }

  return undefined;
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

function level_objectiveadd(var0, var1, var2) {
  var3 = level_objectivegetindex();
  objective_addalltomask(var3);
  objective_state(var3, "current");
  objective_setdescription(var3, var0);

  if(isDefined(var1)) {
    objective_position(var3, var1);
  }

  if(isDefined(var2)) {
    objective_setlabel(var3, var2);
  }

  level_objectiveincrementindex();
  return var3;
}

function level_objectivegetindex() {
  return level.objectiveindex;
}

function level_objectivegetpreviousindex() {
  return int(max(level.objectiveindex - 1, 0));
}

function level_objectivecreatefollowai(var0, var1, var2) {
  if(!isDefined(var1)) {
    var1 = 72;
  }

  var3 = level_objectivegetindex();
  level_objectiveadd(var2, var0.origin, &"SAFEHOUSE/LABEL_FOLLOW");
  objective_onentity(var3, var0);
  objective_setzoffset(var3, var1);
  return var3;
}

function level_deletepreviousobjective() {
  var0 = level_objectivegetpreviousindex();
  objective_delete(var0);
}

function level_objectiveincrementindex() {
  var0 = level_objectivegetindex();
  var1 = scripts\engine\math::wrap(0, 31, var0 + 1);
  level_objectivesetindex(var1);
}

function level_objectivesetindex(var0) {
  level.objectiveindex = var0;
}

function player_isprone() {
  return level.player getstance() == "prone";
}

function player_waittillnearai(var0, var1, var2, var3, var4, var5, var6, var7) {
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

  foreach(var13, var9 in var6) {
    foreach(var11 in var7) {
      var9 endon(var11);
    }
  }

  var14 = isDefined(var3) && isDefined(var4);

  if(var14) {
    var15 = level_objectivecreatefollowai(var0, undefined, var3);
  } else {
    var15 = undefined;
  }

  if(istrue(var6)) {
    level.player scripts\sp\player::focus_display_hint(var6, undefined, var7, var8);
  }

  var16 = var2 * var2;

  for(;;) {
    if(isDefined(var3)) {
      var17 = distancesquared(level.player.origin, var3);
      var18 = distancesquared(var1.origin, var3);
      var19 = var17 < var18;

      if(var19) {
        break;
      }
    }

    var15 = distancesquared(level.player.origin, < error > .origin);

    if(var15 <= var14) {
      break;
    }

    waitframe();
  }

  if(isDefined(var13)) {
    objective_delete(var13);
  }

  level notify("player_nearAI", < error > );
}

function player_waittilllookingatai(var0, var1, var2, var3, var4) {
  if(isDefined(var3)) {
    if(!isarray(var3)) {
      var3 = [var3];
    }
  } else {
    var3 = [];
  }

  if(isDefined(var4)) {
    if(!isarray(var4)) {
      var4 = [var4];
    }
  } else {
    var4 = [];
  }

  var3 = scripts\engine\sp\utility::array_merge(var3, [var0, level, level.player]);
  var4 = scripts\engine\sp\utility::array_merge(var4, ["death", "entitydeleted", "player_nearAI"]);

  foreach(var6 in var3) {
    foreach(var8 in var4) {
      var6 endon(var8);
    }
  }

  if(isDefined(var2)) {
    var11 = gettime() + var2 * 1000;
    goto LOC_000000ca;
  }

  var11 = undefined;

  for(;;) {
    if(isDefined(var11) && gettime() >= var11) {
      break;
    }

    var12 = level.player getEye();
    var13 = var1 getEye();
    var14 = anglesToForward(level.player getplayerangles());
    var15 = vectorNormalize(var13 - var12);
    var16 = vectordot(var14, var15);
    var17 = var16 >= var2;
    var18 = sighttracepassed(var12, var13, 0, level.player, 1);

    if(var17 && var18) {
      break;
    }

    waitframe();
  }
}

function thread_on_notetrack(var0, var1) {
  animation_waittillnotetrack(self, var0);
  self thread[[var1]]();
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

function entity_getnextclosestgoalinpath(var0, var1) {
  var2 = var1;
  var3 = distance(var0.origin, var2.origin);
  var4 = var2;

  while(isDefined(var2.target)) {
    var5 = get_nexttargetedpathgoal(var2);
    var6 = var5.origin - var2.origin;
    var7 = distance(pointonsegmentnearesttopoint(var2.origin, var5.origin, var0.origin), var0.origin);

    if(var7 < var3) {
      var3 = var7;
      var4 = var5;
    }

    var2 = var5;
  }

  return var4;
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

function waittill_time(var0) {
  while(gettime() < var0) {
    waitframe();
  }
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

function level_setcustomdeathhintindex(var0) {
  if(isDefined(level_getcustomoverridedeathhintindex())) {
    return;
  }

  level.custom_death_quote = var0;

  if(!isDefined(var0)) {
    return;
  }

  setDvar("safehouse_deathHintIndex", var0);
}

function level_getsafehousecustomdeathhintindex(var0) {
  return getdvarint("safehouse_deathHintIndex");
}

function level_setcustomoverridedeathhintindex(var0) {
  level.custom_death_override_quote = var0;
  level.custom_death_quote = var0;
}

function level_getcustomoverridedeathhintindex(var0) {
  return level.custom_death_override_quote;
}

function level_getcivilians() {
  var0 = getaiarray("neutral");

  if(isDefined(level.drones) && isDefined(level.drones["neutral"]) && isDefined(level.drones["neutral"].array)) {
    var0 = scripts\engine\sp\utility::array_merge(var0, level.drones["neutral"].array);
  }

  return var0;
}

function level_getdrones() {
  var0 = scripts\engine\sp\utility::array_merge(level.drones["allies"].array, level.drones["axis"].array);
  var0 = scripts\engine\sp\utility::array_merge(var0, level.drones["neutral"].array);
  return var0;
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

function level_disablefriendlyfire() {
  setDvar("friendlyfire_dev_disabled", 1);
}

function level_enablefriendlyfire() {
  setDvar("friendlyfire_dev_disabled", 0);
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

function vehicle_maketurretsunusable(var0) {
  if(isDefined(var0.mainturret)) {
    var0.mainturret makeunusable();
  }

  if(isDefined(var0.mgturret)) {
    foreach(var2 in var0.mgturret) {
      var2 makeunusable();
    }

    return;
  }
}

function vehicle_getdriver(var0) {
  if(!isDefined(var0.riders)) {
    return;
  }

  if(!var0.riders.size) {
    return;
  }

  foreach(var2 in var0.riders) {
    if(!ai_isvehicledriver(var2, var0)) {
      continue;
    }

    return var2;
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

function vehicle_suspenddriveanimations(var0) {
  var0 notify("suspend_drive_anims");

  if(isDefined(level.vehicle.templates.driveidle[var0.model])) {
    var0 clearanim(level.vehicle.templates.driveidle[var0.model], 0);
  }

  if(isDefined(level.vehicle.templates.driveidle_r[var0.model])) {
    var0 clearanim(level.vehicle.templates.driveidle_r[var0.model], 0);
    return;
  }
}

function weapon_empty(var0) {
  if(!isDefined(var0)) {
    return 1;
  }

  return scripts\engine\utility::is_equal(var0.basename, "none");
}

function weapon_issilenced(var0) {
  foreach(var2 in var0.attachments) {
    if(issubstr(var2, "silencer")) {
      return true;
    }
  }

  return false;
}

function weapon_hassight(var0) {
  var1 = ["reflex", "holo", "acog", "thermal", "hybrid", "reddot"];

  foreach(var3 in var0.attachments) {
    foreach(var5 in var1) {
      if(issubstr(var3, var5)) {
        return true;
      }
    }
  }

  return false;
}