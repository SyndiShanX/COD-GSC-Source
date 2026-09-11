/*************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\safehouse_finale\safehouse_finale_utility.gsc
*************************************************************************/

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

function ai_movealongpath(var0, var1, var2) {
  var0 endon("death");
  var0 endon("entitydeleted");
  var0 endon("charge_clear_paths");

  if(istrue(var2)) {
    var3 = level_objectivegetindex();
    level_objectiveadd("Follow " + var0.name, var0.origin, "Follow");
    objective_onentity(var3, var0);
    objective_setzoffset(var3, 75);
    thread ai_movealongpathcleanupobjectivelogic(var0, var3);
  } else {
    var3 = undefined;
  }

  var1 childthread scripts\sp\spawner::go_to_node(var2);
  var1 waittill("reached_path_end");

  if(istrue(var3)) {
    objective_delete(var3);
    return;
  }
}

function ai_movealongpathplayerproximitylogic(var0) {}

function ai_movealongpathplayerproximityfocushintlogic(var0) {
  var1 = [var0, level.player];
  var2 = ["reached_path_end", "goal_changed", "death", "entitydeleted"];
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
  var1 = 0.4;
  var2 = 0.8;

  for(;;) {
    var3 = randomfloatrange(var1, var2);
    wait var3;
    var0 playSound("anml_dog_attack_jump", "sounddone");
    var0 waittill("sounddone");
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

function ai_getanimationoriginattime(var0, var1, var2, var3) {
  var4 = spawn("script_model", var0.origin);
  var4.angles = var0.angles;
  var4.animname = var0.animname;
  var4 setModel(var0.model);
  var4 scripts\common\anim::setanimtree();
  var4 hide();
  var2 scripts\common\anim::anim_first_frame_solo(var4, var1);
  var2 scripts\common\anim::anim_set_time_solo(var4, var1, var3);
  var5 = var4 scripts\engine\utility::getanim(var1);

  if(isarray(var5)) {
    var5 = var5[0];
  }

  var6 = getmovedelta(var5);
  var7 = getangledelta3d(var5);
  var8 = rotatevector(var6, var4.angles);
  var9 = var4.origin + var8;
  var4 delete();
  return var9;
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
  var0.skipdeathanim = 1;
  var0 waittill("damage");
  animation_stoploop(var0);
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  var0 scripts\engine\sp\utility::ai_ragdoll_immediate();
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

function animation_reachtosingleintoidle(var0, var1, var2, var3) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var0 scripts\sp\anim::anim_reach_solo(var1, var2);
  animation_singleintoidle(var0, var1, var2, var3);
}

function animation_reachtosingle(var0, var1, var2) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var0 scripts\sp\anim::anim_reach_solo(var1, var2);
  var0 scripts\common\anim::anim_single_solo(var1, var2);
}

function animation_reachtosingleintolastframe(var0, var1, var2) {
  var1 endon("death");
  var1 endon("entitydeleted");
  var0 scripts\sp\anim::anim_reach_solo(var1, var2);
  var0 scripts\common\anim::anim_single_solo(var1, var2);
  var0 thread scripts\common\anim::anim_last_frame_solo(var1, var2);
}

function animation_singleintoidle(var0, var1, var2, var3) {
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

function animation_singleintoidleproc(var0, var1, var2, var3) {
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
    var12 = var11 + self.name + " Over Radio" + ": " + "^7" + var1;
    return;
  }

  var12 = var12 + self.name + ": " + "^7" + var2;
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
  thread dialogue_nagendonlogic(var9, var2, var3);
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
    foreach(var5 in var3) {
      animation_stoploop(var5);
      thread animation_singleintoidle(var2, var5, var0, var1);
    }
  }

  animation_stoploop(self);
  animation_singleintoidle(var2, self, var0, var1);
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
}

function level_objectivegetindex() {
  return level.objectiveindex;
}

function level_objectiveincrementindex() {
  var0 = level_objectivegetindex();
  level_objectivesetindex(var0 + 1);
}

function level_objectivesetindex(var0) {
  level.objectiveindex = var0;
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
  var0 = undefined;
  init_drone_vo();
  GscBinSkip4(0x35);
}

function init_drone_vo() {
  level.drone_vo = spawnStruct();
  var0 = ["dx_vom_yas_fob_center_planelast_10", "dx_vom_yas_fob_center_planelast_20", "dx_vom_yas_fob_center_planelast_30"];
  level.drone_vo.last_plane = scripts\engine\sp\utility::create_deck(var0, 0);
  level.drone_vo.last_plane.autoshuffle = 1;
  var0 = ["dx_vom_yas_fob_center_planeready_10", "dx_vom_yas_fob_center_planeready_20", "dx_vom_yas_fob_center_planeready_30"];
  level.drone_vo.planes_ready = scripts\engine\sp\utility::create_deck(var0, 0);
  level.drone_vo.planes_ready.autoshuffle = 1;
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_had_fob_center_helos_40");
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

function player_dodronecooldown(var0) {
  if(!scripts\engine\utility::flag("drone_allowed")) {
    return;
  }

  level endon("drone_allowed");
  var1 = 3;

  if(level.gameskill > 1) {
    var1 -= 1;
  }

  var2 = 0;

  if(var2 < var1) {
    if(level.drone_counter == 0) {
      GscBinSkip4(0x35);
    }

    if(var2 == 0) {
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
  var0 = gettime();

  for(var1 = 0; var1 < 3; var1++) {
    level waittill("ai_killed");

    if(getaiarray("axis").size == 0) {
      break;
    }
  }

  wait randomfloatrange(1, 3);
  var2 = (gettime() - var0) / 1000;

  if(var2 < 20) {
    wait 20 - var2;
  }

  wait wait_combat_cooldown(1.5, 5);
  player_resumeallowdrones();
}

function player_droneusereminder(var0, var1) {
  if(scripts\engine\utility::flag("dont_drone_nag")) {
    return;
  }

  level endon("dont_drone_nag");
  level endon("player_in_drone");
  level endon("pause_drone_control");
  level endon("stop_drone_control");

  if(isDefined(var1)) {
    wait var1;
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
  var0 = player_dronespawnlogic();

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
  var0 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var0 fadeovertime(0.25);
  var0.alpha = 1;
  thread player_dronespawnoverlaycancellogic(var0);
  wait 0.25;
  var0 fadeovertime(0.25);
  var0.alpha = 0;
  var0 scripts\engine\utility::delaycall(0.25, &destroy);
  scripts\engine\utility::flag_set("player_in_drone");
  jumpiffalse(isDefined(level.drone_start_position)) LOC_0000008a;
  var1 = level.drone_start_position.origin;
  var2 = level.drone_start_position.angles;
  goto LOC_00000142;
}

function player_trackdronekills() {
  scripts\engine\utility::flag_wait("player_in_drone");
  level endon("player_in_drone");
  var0 = 0;

  for(;;) {
    level waittill("ai_killed", var1, var2, var3, var4);

    if(isDefined(var1.team) && var1.team != "axis") {
      continue;
    }

    if(!isDefined(var2)) {
      continue;
    }

    if(var2.classname == "player") {
      break;
    }
  }

  wait 0.85;

  if(!isDefined(level.drone_vo) || !isDefined(level.drone_vo.good_hit)) {
    return;
  }

  say_as_chatter(level.hadir, level.drone_vo.good_hit scripts\engine\sp\utility::deck_draw(), 0, 2);
}

function dummy_player(var0) {
  var1 = getspawner("alex", "targetname");
  var2 = scripts\engine\sp\utility::bodyonlyspawn(var1);
  var1.count = 1;
  var2.origin = level.player.origin;
  var2.angles = level.player.angles;
  var2.animname = "alex";
  var2 setCanDamage(1);
  thread dummy_damage_watcher(var0);
  var3 = scripts\engine\sp\utility::spawn_anim_model("tablet_1");
  var3.origin = var2 gettagorigin("tag_accessory_right");
  var3.angles = var2 gettagangles("tag_accessory_right");
  var3 linkTo(var2, "tag_accessory_right");
  var2 thread scripts\common\anim::anim_loop_solo(var2, "drone_idle");
  var4 = createnavbadplacebybounds(var2.origin, (200, 200, 400), var2.angles, "axis");
  level.player waittill("player_exitDrone");
  var2 delete();
  var3 delete();
  destroynavobstacle(var4);
}

function dummy_damage_watcher(var0) {
  level.player endon("player_exitDrone");
  scripts\engine\utility::waittill_any("missile_stuck", "death", "entitydeleted");
  var1 = level.impactinfo.crashorigin;
  var2 = 200;

  if(distance(var1, var0.origin) < var2) {
    scripts\sp\friendlyfire::missionfail();
    return;
  }
}

function player_dronevisionsetfade() {
  wait 1;
  level notify("stop_drone_cancel_logic");
  visionsetnaked("safehouse_finale_fob_missilecam_noise", 0.1);
}

function player_usedrone(var0, var1, var2, var3, var4) {
  var5 = player_dronespawn(var0, var1);
  thread player_dronecontrollogic(var5, var2, var3, var4);
  return var5;
}

function player_dronespawnoverlaycancellogic(var0) {
  var1 = level.player scripts\engine\utility::waittill_notify_or_timeout_return("player_droneCancel", 0.25);

  if(var1 == "timeout") {
    return;
  }

  var0 fadeovertime(0.25);
  var0.alpha = 0;
  var0 scripts\engine\utility::delaycall(0.25, &destroy);
}

function player_dronecontrollogic(var0, var1, var2, var3) {
  dronesetvehspeed(var0, var1, var2, var3);
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
  thread dummy_player(var0);
  var4 = droneplayersetup(var0);
  level.impactinfo = undefined;
  level.impactinfo = dronegetimpactinfoondeath(var0);
  playrumbleonposition("damage_heavy", level.player.origin);
  removedronescreeneffects();
  var5 = droneimpactexplosion(level.impactinfo);
  dronekillcamlogic(level.impactinfo, var5);
  droneplayerrestore(var4, level.impactinfo, var0);
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
      var0 = "invertPitchFlyingGamepad";
      var1 = level.player getlocalplayerprofiledata("invertPitchGamepad") || level.player getlocalplayerprofiledata(var0);
      level.player setlocalplayerprofiledata("invertPitchGamepad", 0);
    } else {
      var0 = "invertPitchKBM";
      var1 = level.player getlocalplayerprofiledata(var0);
    }

    if(var1 >= 1) {
      var1 = 0;
    } else {
      var1 = 1;
    }

    level.player setlocalplayerprofiledata(var0, var1);
    waitframe();
  }
}

function droneplayersetup(var0) {
  level.player disableweaponswitch();
  level.player enableinvulnerability();
  level.player painvisionoff();
  level.player disableweapons();
  setomnvar("ui_hide_hud", 1);
  level.player enableplayerbreathsystem(0);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  var1 = level.player.origin;
  level.player playerdisabletriggers();
  level.player enableinvulnerability();
  level.player hidelegsandshadow();
  level.player hideviewmodel();
  var0 setotherent(level.player);
  var0 setentityowner(level.player);
  controls_linkto_safe(level.player, var0);
  return var1;
}

function droneplayerrestore(var0, var1, var2) {
  level.player modifybasefov(65, 0.05);
  wait 0.15;
  level.player enableweaponswitch();
  level.player enableweapons();
  var3 = var1.crashorigin;
  level.player scripts\engine\utility::delaycall(1, &disableinvulnerability);
  level.player showlegsandshadow();
  level.player showviewmodel();
  level.player enableplayerbreathsystem(1);
  controls_unlink_safe(level.player);
  level.player cameraunlink();

  if(isDefined(var2)) {
    var2 setotherent(undefined);
    var2 setentityowner(undefined);
    var2 delete();
  }

  level.player setOrigin(var0);
  level.player playerenabletriggers();
  setomnvar("ui_hide_hud", 0);
  var4 = var3 - level.player.origin;
  level.player setplayerangles(vectortoangles(var4));
  level.player scripts\sp\utility::allow_cg_drawcrosshair(1);
  level.player notify("player_exitDrone", var3);
}

function droneimpactexplosion(var0) {
  thread drone_friendly_fire_watcher();
  var1 = var0.crashorigin;
  level.player radiusdamage(var1 + (0, 0, 10), 250, 500, 500, level.player, "MOD_PROJECTILE", undefined, 0, 0);
  level.player radiusdamage(var1 + (0, 0, 10), 250, 500, 500, level.player, "MOD_EXPLOSIVE", undefined, 0, 0);
  radiusdamage(var1 + (0, 0, 10), 500, 500, 500, undefined, "MOD_PROJECTILE", "apache_proj_sp", 0, 0);
  var2 = 0;
  var2 = chopper_check(var1);
  tromeo_check(var1);
  playFX(level._effect["vfx_drone_impact"], var1);
  earthquake(0.6, 0.15, var1, 9999);
  thread scripts\engine\utility::play_sound_in_space("scn_safehouse_rc_plane_death_plr", var1);
  thread scripts\engine\utility::play_sound_in_space("iw8_cruise_missile_exp", var1);
  return var2;
}

function drone_friendly_fire_watcher() {
  level endon("player_in_drone");
  level waittill("friendlyfire_mission_fail");
  setomnvar("ui_hide_hud", 0);
}

function dronesetvehspeed(var0, var1, var2, var3) {
  thread dronesetvehspeedthreaded(var0, var1, var2, var3);
}

function dronesetvehspeedthreaded(var0, var1, var2, var3) {
  self notify("new_rc_plane_speed");
  self endon("death");
  self endon("entitydeleted");
  self endon("new_rc_plane_speed");

  if(!isDefined(var3)) {
    var3 = 0;
  }

  if(isDefined(self.minspeed) && var3 > 0) {
    var4 = 0.05;
    var5 = int(var3 / var4);
    var6 = var0 - self.minspeed;
    var7 = var1 - self.maxspeed;
    var8 = var2 - self.boostspeed;
    var9 = var6 / var5;
    var10 = var7 / var5;
    var11 = var8 / var5;

    while(var5) {
      self.minspeed += var9;
      self.maxspeed += var10;
      self.boostspeed += var11;
      setstoredvehspeeds();
      wait var4;
      var5--;
    }
  }

  self.minspeed = var0;
  self.maxspeed = var1;
  self.boostspeed = var2;
  setstoredvehspeeds();
}

function setstoredvehspeeds() {
  self rcplane_setminspeed(self.minspeed);
  self rcplane_settopspeed(self.maxspeed);
  self rcplane_settopspeedboost(self.boostspeed);
}

function mphtoips(var0) {
  return var0 * 17.6;
}

function droneoutofboundslogic() {
  self endon("missile_stuck");
  self endon("entitydeleted");
  var0 = getEnt("out_of_bounds_01", "targetname");
  var1 = getEnt("out_of_bounds_02", "targetname");
  var2 = var0;

  if(scripts\engine\utility::flag("fob_center")) {
    var2 = var1;
  }

  level.inbounds = 1;
  wait 1;

  for(;;) {
    if(self istouching(var2)) {
      level.inbounds = 1;
      waitframe();
      continue;
    }

    level.inbounds = 0;
    thread kill_drone_out_of_bounds(level.inbounds);
    thread droneoutofboundsvisionlogic();

    while(!self istouching(var2)) {
      waitframe();
    }

    level notify("in_bounds");
    level.inbounds = 1;
    visionsetfadetoblack(level.current_visionset, 0.5);
    wait 0.5;
  }
}

function kill_drone_out_of_bounds(var0) {
  self endon("missile_stuck");
  self endon("entitydeleted");
  level endon("in_bounds");
  wait 3;
  self delete();
}

function player_dronedebugenabled() {
  return getdvarint("player_droneDebug");
}

function player_dronedebugline(var0) {
  if(player_dronedebugenabled()) {
    iprintln(var0);
    return;
  }
}

function droneenemieslogic() {
  wait 2;

  if(!isalive(self)) {
    return;
  }

  level.chopper_turret_target = self;
  var0 = scripts\engine\utility::spawn_script_origin();
  var0 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var1 = droneenemiestargetlogic(var0);

  if(scripts\engine\utility::flag("player_in_drone")) {
    scripts\engine\utility::flag_waitopen("player_in_drone");
  }

  var1 = array_removedeaddyingorundefined(var1);

  foreach(var3 in var1) {
    var3 clearentitytarget();
  }

  var0 delete();
}

function droneenemiestargetlogic(var0) {
  var1 = 0.2;
  var2 = [];

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    var3 = ai_getaliveaiarray("axis");

    foreach(var5 in var3) {
      if(droneenemyvalid(var5)) {
        continue;
      }

      var3 = scripts\engine\utility::array_remove(var3, var5);
    }

    if(!var3.size) {
      waitframe();
      continue;
    }

    var7 = var3[0];
    var8 = -9999999;
    var9 = anglesToForward(self.angles);

    foreach(var5 in var3) {
      var11 = vectorNormalize(var5 getEye() - self.origin);
      var12 = vectordot(var9, var11);

      if(var12 > var8) {
        var8 = var12;
        var7 = var5;
      }
    }

    var7 setentitytarget(var0);
    thread droneenemyshootvfxlogic(var7);

    if(!scripts\engine\utility::array_contains(var2, var7)) {
      var2 = scripts\engine\utility::array_add(var2, var7);
    }

    wait var1;
  }

  return var2;
}

function droneenemyshootvfxlogic(var0) {
  var0 endon("death");
  self endon("missile_stuck");
  self endon("entitydeleted");

  for(;;) {
    var0 waittill("shooting");
    playFXOnTag(level._effect["vfx_muzzle_flash_ar_no_cull"], var0, "TAG_FLASH");
  }
}

function droneenemyvalid(var0) {
  if(scripts\engine\utility::is_equal(var0.code_classname, "actor_enemy_rus_desert_rpg")) {
    return false;
  }

  var1 = sighttracepassed(self.origin, var0 getEye(), 0, self, 1);

  if(!var1) {
    return false;
  }

  return true;
}

function player_dronegetstartstructs() {
  return scripts\engine\utility::getStructArray("player_droneStartStruct", "targetname");
}

#using_animtree("vehicles");

function player_dronespawn(var0, var1) {
  if(getdvarint("scr_thrid_person_rc_plane")) {
    var2 = "rcplane_physics_tp";
  } else {
    var2 = "rcplane_physics";
  }

  var3 = spawnVehicle("veh8_ind_air_bombing_drone", "rcplane", var2, var1, var2);
  var3 vehphys_enablecollisioncallback(1);
  var3 vehicle_teleport(var1, var2);
  var3 hidepart("j_propeller");
  var3 useanimtree(#animtree);
  level.player_dronemodel = var3;
  thread player_dronecleanuplogic();
  return var3;
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
  var0 = 1.2;
  var1 = 0.8;
  var2 = 1.15;
  var3 = 0.85;
  var4 = 0.25;
  var5 = 0;
  var6 = 0.5;

  for(;;) {
    var7 = self vehicle_getspeed();
    var7 = scripts\engine\utility::mph_to_ips(var7);
    var8 = scripts\engine\math::normalize_value(self.minspeed, self.maxspeed, var7);
    var6 = scripts\engine\math::lerp(var6, var8, var4);
    var9 = scripts\engine\math::factor_value(var1, var0, var6);
    var10 = scripts\engine\math::factor_value(var3, var2, var6);

    if(self.sprinting) {
      if(!var5) {
        var5 = 1;
        self.enginesfxtag scalevolume(1.4, 1);
        self.enginesfxtag scalepitch(1.4, 1.5);
        self.sprintsfxtag scalevolume(1.4, 1);
      }
    } else {
      if(var5) {
        self.sprintsfxtag scalevolume(0.25, 1);
        var5 = 0;
      }

      self.enginesfxtag scalevolume(var9, 0.05);
      self.enginesfxtag scalepitch(var10, 1);
    }

    waitframe();
  }
}

function dronebankeffects() {
  self endon("missile_stuck");
  self endon("entitydeleted");
  level.pitchdelta = undefined;
  var0 = 0;
  var1 = 0.083;
  var2 = 0.06;
  var3 = 0;
  var4 = 0.1;
  var5 = 0.501;
  var6 = 1;
  var7 = 0.8;
  var8 = 1.2;
  self.rumbleent = scripts\engine\utility::spawn_script_origin(level.player.origin);
  self.enginebanksfxtag = scripts\engine\utility::spawn_tag_origin();
  self.enginebanksfxtag linkTo(self);
  self.enginebanksfxtag playLoopSound("scn_safehouse_rc_plane_plr_bank_lp");
  var9 = 0;
  var10 = anglesToForward(self.angles);
  var11 = angleclamp180(self.angles[0]);

  for(;;) {
    var12 = anglesToForward(self.angles);
    var13 = 1 - vectordot(var10, var12);
    var14 = angleclamp180(self.angles[0]);
    level.pitchdelta = var11 - var14;
    var10 = var12;
    var11 = var14;
    var15 = abs(self.angles[2]);
    var0 = scripts\engine\math::lerp(var0, var15, 0.08);
    var16 = scripts\engine\math::normalize_value(0, 50, var15);
    var16 = scripts\engine\math::normalized_float_smooth_out(var16);
    var17 = scripts\engine\math::normalize_value(0, 0.0064, var13);
    var17 = scripts\engine\math::normalized_float_smooth_out(var17);
    var18 = max(var16, var17);
    var19 = scripts\engine\math::factor_value(var2, var1, var18);
    var20 = scripts\engine\math::factor_value(var3, var4, var18);
    var21 = scripts\engine\math::factor_value(var5, var6, var18);
    var22 = scripts\engine\math::factor_value(var7, var8, var18);

    if(var20 > 0.0001) {
      if(!var9) {
        self.rumbleent playrumblelooponentity("steady_rumble");
        var9 = 1;
      }
    } else if(var9) {
      self.rumbleent stoprumble("steady_rumble");
      var9 = 0;
    }

    var23 = 1 - var20;
    var23 *= 1000;
    self.rumbleent.origin = self.origin + (0, 0, var23);
    self.enginebanksfxtag scalevolume(var21, 0.05);
    self.enginebanksfxtag scalepitch(var22, 0.05);
    earthquake(var19, 0.2, self.origin, 5000);
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

function dronestaticmbscreenfx(var0) {
  thread scripts\engine\sp\utility::lerp_saveddvar("MLTTMLTKOR", 0.1585, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("NKTRSSTMRQ", -0.478, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("LSOPQMRPNR", 0.00389, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("OMRQKMSSPP", 1, var0);
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
  var0 = 6;
  var1 = 6;
  level scripts\engine\sp\utility::dof_enable(5.2, 0.01, 10, 10);
  wait 0.5;
  level scripts\engine\sp\utility::dof_enable(5.2, 17, var0, var1);
  wait 0.6;
  level scripts\engine\sp\utility::dof_enable(5.2, 0.01, var0, var1);
  wait 0.5;
  level scripts\engine\sp\utility::dof_enable(25, 49, var0, var1);
}

function droneimpactwatcher() {
  thread droneheliimpactwatcher();
  self waittill("collision", var0, var1, var2, var3, var4, var5, var6, var7);
  self notify("missile_stuck");
}

function droneheliimpactwatcher() {
  var0 = 0;
  var1 = ["TAG_TAIL_ROTOR_MOTION"];

  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    foreach(var3 in level.choppers) {
      if(!isDefined(var3)) {
        continue;
      }

      if(var3.classname == "script_vehicle_iw8_mindia8_closed") {
        var4 = 300;
      } else {
        var4 = 180;
      }

      var5 = [var3.origin];

      foreach(var7 in var1) {
        if(scripts\engine\utility::hastag(var3.model, var7)) {
          var5 = scripts\engine\utility::array_add(var5, var3 gettagorigin(var7));
        }
      }

      foreach(var10 in var5) {
        var11 = anglesToForward(self.angles);
        var12 = var10 - self.origin;
        var13 = vectordot(var11, vectorNormalize(var12));
        var14 = length(var12);

        if(var14 < var4 && var13 > 0) {
          var0 = 1;
        }

        if(var0) {
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
  var0 = spawnStruct();
  droneupdateoriginandanglestildeath(var0);
  return var0;
}

function droneupdateoriginandanglestildeath(var0) {
  self endon("missile_stuck");
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    var0.crashforward = anglesToForward(self gettagangles("tag_origin"));
    var0.crashorigin = self.origin;
    waitframe();
  }
}

function dronekillcamlogic(var0, var1) {
  var2 = var0.crashorigin;
  var3 = var0.crashforward;
  var4 = (0, 0, 1);
  var3 = scripts\engine\utility::flatten_vector(var3);
  var5 = var3 * -1;
  var6 = randomintrange(1, 4);

  if(scripts\engine\utility::flag_exist("fly_attack_done") && !scripts\engine\utility::flag("fly_attack_done")) {
    var6 = 1;
  }

  var7 = [];

  if(level.inbounds) {
    switch (var6) {
      case 3:
      case 2:
      case 1:
        var7 = kill_cam_behavior_spin(var4, var3, var5, var2, var1);
        break;
      case 4:
        var7 = kill_cam_behavior_default(var4, var3, var5, var2);
        break;
      default:
        var7 = kill_cam_behavior_default(var4, var3, var5, var2);
        break;
    }
  } else {
    level.player cameraunlink();
    controls_unlink_safe(level.player);
  }

  var8 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var8 fadeovertime(0.2);
  var8.alpha = 1;
  wait 0.2;
  thread cleanupkillcamlogic(var7, var8);
}

function cleanupkillcamlogic(var0, var1) {
  wait 0.2;
  scripts\engine\utility::array_delete(var0);
  level scripts\engine\sp\utility::dof_disable();
  var1 fadeovertime(0.2);
  var1.alpha = 0;
  var1 scripts\engine\utility::delaycall(0.2, &destroy);
}

function kill_cam_behavior_spin(var0, var1, var2, var3, var4) {
  var5 = 0.3;
  var6 = vectorlerp(var2, var0, var5);
  var7 = vectortoangles(var6 * -1);
  var8 = scripts\engine\utility::spawn_tag_origin(var3, var7);
  var9 = scripts\engine\utility::spawn_tag_origin(var3, var7);
  var10 = 1100;

  if(istrue(var4)) {
    var10 = 2000;
  }

  var11 = var3 + var6 * var10;
  var12 = sighttracepassed(var3, var11, 0, level.player, 1);

  if(!var12) {
    var13 = kill_cam_behavior_default(var0, var1, var2, var3);
    return var13;
  }

  level.player cameraunlink();
  controls_unlink_safe(level.player);
  level.player cameralinkTo(var9, "tag_origin", 1, 1);
  level.player modifybasefov(45, 0.05);
  var14 = 1.7;
  screenshake(var9.origin, 0.5, 0.2, 0.3, 3);
  var15 = scripts\engine\utility::spawn_tag_origin(var4, (0, 0, 0));
  var15 scripts\engine\sp\utility::dof_enable_autofocus(1.4, 10, undefined, undefined, "tag_origin");
  var9.origin = var12;
  var9 linkTo(var10);
  wait 0.1;
  var10 rotateYaw(5, var14);
  wait var14;
  var9 notify("kill_lookat");
  var13 = [var9, var10];
  var15 delete();
  return var13;
}

function kill_cam_behavior_low(var0, var1, var2, var3) {
  var4 = 0.15;
  var5 = vectorlerp(var2, var0, var4);
  var6 = vectortoangles(var5 * -1);
  var7 = scripts\engine\utility::spawn_tag_origin(var3, var6);
  var8 = scripts\engine\utility::spawn_tag_origin(var3, var6);
  var9 = 200;
  var10 = var3 + var5 * var9;
  var11 = sighttracepassed(var3, var10, 0, level.player, 1);

  if(!var11) {
    var12 = kill_cam_behavior_default(var0, var1, var2, var3);
    return var12;
  }

  var8.angles = var9.angles + (-10, -10, 0);
  level.player cameraunlink();
  controls_unlink_safe(level.player);
  level.player cameralinkTo(var8, "tag_origin", 1, 1);
  level.player modifybasefov(80, 0.05);
  var13 = 1.7;
  screenshake(var8.origin, 1, 0.5, 0.5, 3);
  level scripts\engine\sp\utility::dof_enable(0.572089, 850.852, 0, 0);
  var8.origin = var11;
  var8 linkTo(var9);
  wait 0.1;
  var9 rotateYaw(5, var13 + 0.5);
  wait var13;
  var8 notify("kill_lookat");
  var12 = [var8, var9];
  return var12;
}

function kill_cam_behavior_default(var0, var1, var2, var3) {
  var4 = 0.9;
  var5 = vectorlerp(var2, var0, var4);
  var6 = vectortoangles(var5 * -1);
  var7 = scripts\engine\utility::spawn_tag_origin(var3, var6);
  var8 = scripts\engine\utility::spawn_tag_origin(var3, var6);
  var9 = 1200;
  var10 = var3 + var5 * var9;
  var11 = sighttracepassed(var3, var10, 0, level.player, 1);
  level.player cameraunlink();
  controls_unlink_safe(level.player);
  level.player cameralinkTo(var7, "tag_origin", 1, 1);
  level.player modifybasefov(35, 0.05);
  var12 = 1.7;
  screenshake(var7.origin, 0.5, 0.2, 0.3, 3);
  level scripts\engine\sp\utility::dof_enable(0.572089, 850.852, 0, 0);
  var7.origin = var10;
  var7 linkTo(var8);
  wait 0.1;
  var8 rotateYaw(35, var12 + 0.5);
  var8 movez(200, var12 + 0.5);
  wait var12;
  var7 notify("kill_lookat");
  var13 = [var7, var8];
  return var13;
}

function camera_move(var0, var1) {
  self endon("kill_lookat");
  var2 = 30;
  var3 = 0;
  var4 = 360;
  var5 = 0;
  var6 = 1;
  var5 = scripts\engine\math::anglebetweenvectors(scripts\engine\utility::flatten_vector(self.origin - var0), (-1, 0, 0));
  iprintlnbold(var5);

  for(;;) {
    var7 = math_pointoncircle(var1, var5);
    var8 = var0 + var7;
    var9 = (var8[0], var8[1], self.origin[2]);
    self moveTo(var9, 0.25);
    var5 = scripts\engine\math::wrap(0, 360, var5 + var6);
    wait 0.25;
  }
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

function camera_lookat(var0) {
  self endon("kill_lookat");

  for(;;) {
    var1 = vectortoangles(var0 - self.origin);
    self.angles = var1;
    waitframe();
  }
}

function dronedamagelogic() {
  self endon("missile_stuck");
  self endon("entitydeleted");
  self.health = 99999;
  var0 = 1.5;
  wait var0;
  self setCanDamage(1);
  var1 = 6;
  var2 = 1500;
  var3 = gettime();

  for(;;) {
    self waittill("damage", var4, var5);
    var6 = gettime() - var3;

    if(var6 < var2) {
      continue;
    }

    thread dronedamagevisionlogic();
    thread dronedamageeffectslogic();
    dronedamagerotatelogic(var5);
    var3 = gettime();
    var1--;

    if(!var1) {
      break;
    }
  }

  self delete();
}

function dronetimeoutlogic() {
  self endon("missile_stuck");
  self endon("entitydeleted");
  scripts\engine\utility::flag_wait("start_fly_countdown");
  var0 = gettime();

  while(var0 + 15000 > gettime()) {
    waitframe();
  }

  self delete();
}

function dronedamagevisionlogic() {
  var0 = "ac130_color_glitch";
  var1 = "";
  visionsetfadetoblack(var0, 0);
  wait 0.1;
  visionsetfadetoblack(var1, 0.4);
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

function dronedamagerotatelogic(var0) {
  if(!isDefined(var0)) {
    return;
  }

  self endon("missile_stuck");
  self endon("entitydeleted");
  var1 = randomfloatrange(8, 12);
  var2 = !scripts\engine\math::is_point_on_right(var0.origin);

  if(var2) {
    var1 *= -1;
  }

  var3 = self.angles;
  var4 = var3 + (0, var1, 0);
  var5 = 0.5;
  var6 = 0;

  while(var6 < 1) {
    var6 += var5;
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

function controls_linkto_safe(var0) {
  self controlslinkTo(var0);
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
  var0 = 0.35;
  self.sprinting = 1;
  level.player setcinematicmotionoverride("iw8_rcplane_sprint");
  thread scripts\engine\sp\utility::lerp_saveddvar("LSOPQMRPNR", 0.08, var0);
  thread scripts\engine\sp\utility::lerp_saveddvar("NKTRSSTMRQ", 0.4, var0);
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
  var0 = 0.2;
  level.player setcinematicmotionoverride("iw8_rcplane");
  earthquake(0.17, 0.5, self.origin, 5000);
  self.sprintinitsfxtag scalevolume(1, 1);
  self.sprintinitsfxtag scalepitch(1, 1);
  dronestaticmbscreenfx(var0);
  self.sprintsfxtag scalevolume(0, 1);
  self.enginesfxtag scalevolume(1, 1);
  self.sprinting = 0;
}

function player_waittillnearai(var0, var1, var2, var3, var4, var5) {
  var6 = isDefined(var3) && isDefined(var4);

  if(istrue(var5)) {
    var7 = gettime() + var5 * 1000;
  } else {
    var7 = gettime();
  }

  var8 = 0;
  var9 = undefined;
  var10 = var2 * var2;

  for(;;) {
    if(isDefined(var3)) {
      var11 = distancesquared(level.player.origin, var3);
      var12 = distancesquared(var1.origin, var3);
      var13 = var11 < var12;

      if(var13) {
        break;
      }
    }

    var8 = distancesquared(level.player.origin, < error > .origin);

    if(var8 <= var7) {
      break;
    }

    if(var4 && !var6 && gettime() >= var5) {
      var15 = < error > getEye() + (0, 0, 30);
      var7 = level_objectivegetindex();
      level_objectiveadd(var1, var15, var2);
      var6 = 1;
    }

    waitframe();
  }

  if(var6) {
    objective_delete(var7);
  }

  level notify("player_nearAI", < error > );
}

function player_waittilllookingatai(var0, var1) {
  var0 endon("death");
  var0 endon("entitydeleted");
  level.player endon("death");

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

function level_droneambientmovementlogic(var0, var1, var2, var3) {
  var4 = var0.origin;
  var5 = 0;
  var6 = 360;
  var7 = randomintrange(var5, var6);
  var8 = var4;

  for(;;) {
    var9 = [[var3]](var1, var7);
    var10 = (0, 0, 100 * sin(var7));
    var11 = var4 + var9 + var10;
    var0.origin = var11;
    var0.angles = vectortoangles(var11 - var8);
    var0 vibrate(var0.angles, 10, 40, 0.05);
    var7 = scripts\engine\math::wrap(0, 360, var7 + var2);
    var8 = var11;
    waitframe();
  }
}

function level_dronespawnVehicle(var0, var1) {
  var2 = spawnVehicle("veh8_ind_air_bombing_drone", "level_droneVehicle", "drone_improvised", var0, var1);
  var2.dontunloadonend = 1;
  var2 playLoopSound("scn_safehouse_rc_plane_lp");
  return var2;
}

function level_dronespawn(var0, var1) {
  var2 = spawn("script_model", var0);
  var2.angles = var1;
  var2 setModel("veh8_ind_air_bombing_drone");
  var2 notsolid();
  var2 hidepart("j_propeller");
  var3 = "scn_safehouse_rc_plane_lp";

  if(scripts\engine\utility::flag("fob_center")) {
    var3 = "scn_safehouse_rc_plane_lp_wide_falloff";
  }

  var2 playLoopSound(var3);
  playFXOnTag(level._effect["vfx_rc_plane_rotor"], var2, "j_propeller");
  return var2;
}

function level_dronevehiclepropellerlogic(var0, var1) {
  var2 = 55;
  var3 = (0, 0, 0);

  for(;;) {
    if(!isalive(var0)) {
      break;
    }

    if(!isDefined(var0)) {
      break;
    }

    var1 unlink();
    var3 += (0, 0, var2);
    var1 linkTo(var0, "tag_origin", (10, 0, 3), var3);
    waitframe();
  }

  var1 delete();
}

function level_setcustomdeathhintindex(var0) {
  level.custom_death_quote = var0;
  setDvar("safehouse_deathHintIndex", var0);
}

function level_getcustomdeathhintindex(var0) {
  return getdvarint("safehouse_deathHintIndex");
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

function enemy_alive_counter_gate(var0) {
  wait 0.2;
  var1 = getaiarray("axis");

  while(var1.size > var0) {
    var1 = getaiarray("axis");
    wait 0.1;
  }

  return false;
}

function chopper_check() {
  var1 = 0;

  if(isDefined(level.choppers) && level.choppers.size != 0) {
    foreach(var3 in level.choppers) {
      if(isDefined(var3)) {
        var4 = distance(var3.origin, var0);

        if(var4 < 500) {
          var1 = 1;

          if(scripts\engine\utility::is_equal(var3, level.boss_chopper)) {
            break;
          }

          var2 scripts\sp\utility::do_damage(var2.health + 500, < error > , level.player, undefined, "MOD_PROJECTILE");
          break;
        }
      }
    }

    var0 = undefined;
    var2 = undefined;
  }

  return < error > ;
}

function tromeo_check(var0) {
  if(isDefined(level.tromeos) && level.tromeos.size != 0) {
    foreach(var2 in level.tromeos) {
      if(isDefined(var2)) {
        var3 = distance(var2.origin, var0);

        if(var3 < 300) {
          var2 scripts\sp\utility::do_damage(var2.health + 200, var0);
        }
      }
    }

    return;
  }
}

function put_player_into_rig(var0, var1, var2, var3, var4, var5) {
  level.player hidelegsandshadow();
  level.player freezecontrols(0);
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();

  if(var1 > 0) {
    level.player playerlinktoblend(var0, "tag_player", var1, 0, 0);
    wait var1;
  }

  level.player playerlinktodelta(var0, "tag_player", 1, var2, var3, var4, var5, 1);
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  var0 show();
  var0 castshadows();
}

function pull_player_out_of_rig_hide_rig(var0) {
  level.player showlegsandshadow();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  var0 hide();
  var0 dontcastshadows();
  level.player enableweapons();
  level.player unlink();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

function focus_reminder(var0, var1) {
  if(!scripts\engine\utility::flag(var0)) {
    level.player thread scripts\sp\player::focus_display_hint(undefined, var1);
    return;
  }
}

function remove_corpses_away_from_player_pos(var0) {
  var1 = getcorpsearray();

  foreach(var3 in var1) {
    var4 = var3 scripts\engine\sp\utility::get_corpse_origin();

    if(distance(level.player.origin, var4) > var0) {
      scripts\engine\utility::array_remove(var1, var3);
      var3 delete();
    }
  }

  var1 = getcorpsearray();
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

function get_closest_male_redshirt() {
  var0 = scripts\sp\maps\safehouse_finale\safehouse_finale_fob::charge_getredshirts();
  var1 = undefined;
  var2 = undefined;

  foreach(var4 in var0) {
    if(issubstr(var4.voice, "female")) {
      continue;
    }

    var5 = distance2dsquared(self.origin, var4.origin);

    if(!isDefined(var1) || var5 < var1) {
      var1 = var5;
      var2 = var4;
    }
  }

  return var2;
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
  self waittill("death", var0);
  level.fob_helo_count--;

  if(level.fob_helo_count == 1) {
    scripts\engine\utility::flag_set("one_fob_helo_left");
    return;
  }

  if(level.fob_helo_count == 0) {
    scripts\engine\utility::flag_set("no_fob_helos_left");
    wait 1;

    if(scripts\engine\utility::flag("boss_chopper_dead") || !scripts\engine\utility::is_equal(var0, level.player)) {
      return;
    }

    say_as_chatter(level.player, "dx_vom_alx_fob_center_helos_300", 1, 3);
    return;
  }
}

function say(var0, var1, var2, var3, var4) {
  if(!soundexists(var0)) {
    return false;
  }

  if(is_dead_or_dying(self)) {
    return false;
  }

  self notify("started_speaking", var0);
  self.lastspoketime = gettime();
  self.lastaliassaid = var0;

  if(isPlayer(self) && isDefined(var2) && !level.player issprinting()) {
    scripts\engine\sp\utility::player_gesture_force(var2);

    if(isDefined(var3)) {
      wait var3;
    }

    if(!isDefined(var4)) {
      var4 = 0;
    }

    var5 = lookupsoundlength(var0) / 1000;
    thread stop_gesture_on_notify_or_timeout("sprint_pressed", var5 + var4);
  }

  if(istrue(var1)) {
    if(isstruct(self)) {
      scripts\engine\sp\utility::smart_radio_dialogue_interrupt(var0);
    } else if(isPlayer(self)) {
      scripts\engine\sp\utility::smart_player_dialogue_interrupt(var0);
    } else if(isDefined(self.animname)) {
      self stopsounds();
      waitframe();
      scripts\engine\sp\utility::smart_dialogue(var0);
    } else {
      if(issentient(self)) {
        self playsoundatviewheight(var0);
      } else {
        self playSound(var0);
      }

      wait lookupsoundlength(var0) / 1000;
    }
  } else if(isstruct(self)) {
    scripts\engine\sp\utility::smart_radio_dialogue(var0);
  } else if(isPlayer(self)) {
    scripts\engine\sp\utility::smart_player_dialogue(var0);
  } else if(isDefined(self.animname)) {
    scripts\engine\sp\utility::smart_dialogue(var0);
  } else {
    if(issentient(self)) {
      self playsoundatviewheight(var0);
    } else {
      self playSound(var0);
    }

    wait lookupsoundlength(var0) / 1000;
  }

  self notify("finished_speaking", var0);
  return true;
}

function stop_gesture_on_notify_or_timeout(var0, var1) {
  scripts\engine\utility::waittill_notify_or_timeout(var0, var1);
  self stopgestureviewmodel();
}

function is_dead_or_dying(var0) {
  if(!isDefined(var0)) {
    return true;
  }

  if(isai(var0)) {
    return (!isalive(var0) || var0 scripts\engine\utility::doinglongdeath());
  } else if(issentient(var0)) {
    return !isalive(var0);
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

  var0 = (gettime() - self.lastspoketime) / 1000;
  var1 = lookupsoundlength(self.lastaliassaid) / 1000;

  if(var0 < var1) {
    wait var1 - var0;
  }

  return true;
}

function time_since_spoke() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return undefined;
  }

  var0 = self.lastspoketime + lookupsoundlength(self.lastaliassaid);
  return (gettime() - var0) / 1000;
}

function say_sequence(var0, var1) {
  var2 = self;

  if(!isarray(var0)) {
    var0 = [var0];
  }

  foreach(var4 in var0) {
    var2 = say_vo_item(var2, var4, var1);
  }
}

function say_vo_item(var0, var1) {
  var2 = self;

  if(isarray(var0)) {
    if((isint(var0[0]) || isfloat(var0[0])) && isint(var0[1]) || isfloat(var0[1])) {
      wait randomfloatrange(var0[0], var0[1]);
    } else if(isbuiltinfunction(var0[0]) || isbuiltinmethod(var0[0]) || isanimation(var0[0])) {
      call_with_params(var2, var0[0], var0[1]);
    }

    return var2;
  }

  if(isent(var0) || isstruct(var0)) {
    var2 = var0;
  } else if(isstring(var0)) {
    say(var2, var0, var1);
  } else if(isint(var0) || isfloat(var0)) {
    wait var0;
  } else if(isbuiltinfunction(var0) || isbuiltinmethod(var0) || isanimation(var0)) {
    call_with_params(var2, var0);
  } else if(scripts\engine\sp\utility::is_deck(var0)) {
    var2 = say_vo_item(var2, var0 scripts\engine\sp\utility::deck_draw(), var1);
  }

  return var2;
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

function say_as_chatter(var0, var1, var2) {
  return do_as_chatter(&say, [var0, var1], var1, var2);
}

function say_as_chatter_with_gesture(var0, var1, var2, var3, var4, var5) {
  return do_as_chatter(&say, [var1, var4, var0, var2, var3], var4, var5);
}

function say_sequence_as_chatter(var0, var1, var2) {
  return do_as_chatter(&say_sequence, [var0], var1, var2);
}

function wait_for_break_in_chatter(var0) {
  var1 = spawnStruct();
  var2 = 0;

  if(!level.vo_chatter.speaking) {
    return 1;
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var1);

  if(isDefined(var0) && isstring(var0)) {
    var2 = scripts\engine\utility::waittill_any_ents_return(var1, "proceed", self, var0, level, var0) == var0;
  } else if(isDefined(var0)) {
    var2 = var1 scripts\engine\utility::waittill_notify_or_timeout_return("proceed", var0) == "timeout";
  } else {
    var1 waittill("proceed");
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_remove(level.vo_chatter.waiting, var1);
  return var2;
}

function do_as_chatter(var0, var1, var2, var3) {
  if(!isDefined(level.vo_chatter)) {
    thread init_chatter();
  }

  level.vo_chatter endon("terminate_chatter");
  var4 = spawnStruct();
  thread do_as_chatter_internal(var0, var1, var2, var3, var4);
  var4 waittill("done", var5);
  return var5;
}

function do_as_chatter_internal(var0, var1, var2, var3, var4) {
  level.vo_chatter endon("terminate_chatter");

  if(level.vo_chatter.speaking && (!istrue(var2) || isDefined(var3))) {
    var5 = wait_for_break_in_chatter(var3);
  } else {
    var5 = 0;
  }

  var6 = undefined;

  if(!level.vo_chatter.speaking || !var5 || istrue(var3)) {
    level.vo_chatter notify("started_speaking", self, var1, var2);
    level.vo_chatter.speaking++;
    var6 = call_with_params(var1, var2);
    level.vo_chatter.speaking--;
    level.vo_chatter notify("done_speaking", self, var1, var2);
  }

  if(!level.vo_chatter.speaking && isDefined(level.vo_chatter.waiting[0])) {
    level.vo_chatter.waiting[0] notify("proceed");
  }

  var5 notify("done", var6);
}

function call_with_params(var0, var1) {
  if(isbuiltinfunction(var0)) {
    return call_with_params_script(var0, var1);
  }

  if(isbuiltinmethod(var0) || isanimation(var0)) {
    return call_with_params_builtin(var0, var1);
  }
}

function call_with_params_script(var0, var1) {
  if(!isDefined(var1)) {
    return self[[var0]]();
  }

  if(!isarray(var1)) {
    return self[[var0]](var1);
  }

  switch (var1.size) {
    case 0:
      return self[[var0]]();
    case 1:
      return self[[var0]](var1[0]);
    case 2:
      return self[[var0]](var1[0], var1[1]);
    case 3:
      return self[[var0]](var1[0], var1[1], var1[2]);
    case 4:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3]);
    case 5:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4]);
    case 6:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5]);
    case 7:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6]);
    case 8:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7]);
    case 9:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7], var1[8]);
    default:
      break;
  }
}

function call_with_params_builtin(var0, var1) {
  if(!isDefined(var1)) {
    return self[[var0]]();
  }

  if(!isarray(var1)) {
    return self builtin[[var0]](var1);
  }

  switch (var1.size) {
    case 0:
      return self builtin[[var0]]();
    case 1:
      return self builtin[[var0]](var1[0]);
    case 2:
      return self builtin[[var0]](var1[0], var1[1]);
    case 3:
      return self builtin[[var0]](var1[0], var1[1], var1[2]);
    case 4:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3]);
    case 5:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4]);
    case 6:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5]);
    case 7:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6]);
    case 8:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7]);
    case 9:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7], var1[8]);
    default:
      break;
  }
}

function nagtill_or_timeout(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = spawnStruct();
  var9 endon("stop");
  var9 scripts\engine\utility::delaythread(var0, &scripts\engine\utility::send_notify, "stop");
  nagtill(var1, var2, var3, var4, var5, var6, var7, var8);
}

function nagtill_delayed(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var1)) {
    if(!isarray(var1)) {
      var1 = [var1];
    }

    foreach(var11 in var1) {
      var12 = scripts\engine\utility::flag_exist(var11) && scripts\engine\utility::ter_op(istrue(var9), !scripts\engine\utility::flag(var11), scripts\engine\utility::flag(var11));

      if(var12) {
        return;
      }

      level endon(var11);
      self endon(var11);
    }
  }

  wait var0;
  nagtill(var1, var2, var3, var4, var5, var6, var7, var8, var9);
}

function nagtill_open(var0, var1, var2, var3, var4, var5, var6, var7) {
  return nagtill(var0, var1, var2, var3, var4, var5, var6, var7, 1);
}

function nagtill(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var2 = default_if_undefined(var2, 8);
  var3 = default_if_undefined(var3, 1.5);
  var4 = default_if_undefined(var4, 20);
  var5 = default_if_undefined(var5, 2);
  var6 = default_if_undefined(var6, 1.2);
  var7 = default_if_undefined(var7, 5);
  var9 = isnumber(var2) && var4 > var2;
  var10 = var7 > var5;

  if(isDefined(var0)) {
    if(!isarray(var0)) {
      var0 = [var0];
    }

    foreach(var12 in var0) {
      var13 = scripts\engine\utility::flag_exist(var12) && scripts\engine\utility::ter_op(istrue(var8), !scripts\engine\utility::flag(var12), scripts\engine\utility::flag(var12));

      if(var13) {
        return;
      }

      level endon(var12);
    }
  }

  jumpiffalse(isarray(var1)) LOC_000000e0;
  var1 = scripts\engine\sp\utility::create_deck(var1, 0);
  var1.autoshuffle = 1;

  for(;;) {
    if(var1 scripts\engine\sp\utility::deck_is_empty()) {
      array_deck_shuffle(var1);
    }

    var15 = self;
    var16 = var1 scripts\engine\sp\utility::deck_draw();

    if(isarray(var16)) {
      var15 = var16[0];
      var16 = var16[1];
    }

    thread notify_started_nag(var15);
    say_as_chatter(var15, var16);
    level notify("said_nag", var15, var16);

    if(isnumber(var2)) {
      wait randomfloatrange(var2 - var5, var2 + var5);

      if(var9) {
        var2 = min(var2 * var3, var4);
      } else {
        var2 = max(var2 * var3, var4);
      }

      if(var10) {
        var5 = min(var5 * var6, var7);
      } else {
        var5 = max(var5 * var6, var7);
      }

      continue;
    }

    scripts\engine\utility::waittill_any_ents(level, var2, self, var2);
  }
}

function notify_started_nag(var0) {
  if(!isDefined(self) || !isDefined(var0)) {
    return;
  }

  self waittillmatch("started_speaking", var0);
  level notify("started_nag", self, var0);
}

function compare(var0, var1) {
  if(isarray(var0)) {
    if(isarray(var1)) {
      return compare_arrays(var0, var1);
    }

    return 0;
  }

  if(isarray(var1)) {
    return 0;
  }

  return var0 == var1;
}

function compare_arrays(var0, var1) {
  if(var0.size != var1.size) {
    return false;
  }

  foreach(var3 in var0) {
    if(!isDefined(var1[var5])) {
      return false;
    }

    var4 = var1[var5];

    if(compare(var4, var3)) {
      return false;
    }
  }

  return true;
}

function array_deck_shuffle() {
  var0 = self;
  var0.index = 0;
  var0.items = scripts\engine\utility::array_randomize(var0.items);

  if(!var0.prevent_redraw || !isDefined(var0.last_drawn) || var0.items.size <= 1) {
    return;
  }

  var1 = compare(var0.items[0], var0.last_drawn);

  if(var1) {
    var2 = randomintrange(1, var0.items.size);
    var3 = var0.items[0];
    var0.items[0] = var0.items[var2];
    var0.items[var2] = var3;
    return;
  }
}

function default_if_undefined(var0, var1) {
  if(!isDefined(var0)) {
    var0 = var1;
  }

  return var0;
}

function wait_combat_cooldown(var0, var1) {
  while(!isDefined(var1) || var1 > 0) {
    if(!recently_in_combat(var0)) {
      return false;
    }

    waitframe();

    if(isDefined(var1)) {
      var1 -= 0.05;
    }
  }

  return true;
}

function recently_in_combat(var0) {
  var1 = isDefined(level.player.last_weapon_fire_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var0);
  var2 = isDefined(level.player.last_damaged_time) && !scripts\engine\utility::time_has_passed(level.player.last_damaged_time, var0);
  return level.player isfiring() || var1 || var2;
}

function track_player_combat_time() {
  level.player endon("death");

  for(;;) {
    var0 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "damage") == "weapon_fired";

    if(var0) {
      level.player.last_weapon_fire_time = gettime();
      continue;
    }

    level.player.last_damaged_time = gettime();
  }
}

function wait_lookat_or_timeout(var0, var1, var2, var3, var4, var5, var6) {
  return wait_lookat(var0, var1, var3, var4, var5, var6, var2, 1);
}

function wait_lookat_ads_or_timeout(var0, var1, var2, var3, var4, var5, var6) {
  return wait_lookat_ads(var0, var1, var3, var4, var5, var6, var2);
}

function wait_lookat_ads(var0, var1, var2, var3, var4, var5, var6) {
  if(!istrue(var5)) {
    var5 = 0;
  }

  return wait_lookat(var0, var1, var2, var3, var4, var5, var6, 1);
}

function wait_lookat(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isDefined(var3)) {
    var3 *= 1000;
  } else {
    var3 = 0;
  }

  var8 = undefined;

  while(!isDefined(var8) || gettime() - var8 <= var3) {
    if(!isDefined(var0)) {
      return;
    }

    if(isDefined(var4)) {
      wait_near(level.player, var0, var4);
    }

    var9 = is_looking_at(var0, var1, var2, var5);

    if(istrue(var7)) {
      var9 = var9 && level.player scripts\engine\sp\utility::isads();
    }

    if(var9 && !isDefined(var8)) {
      var8 = gettime();
    } else if(!var9) {
      var8 = undefined;
    }

    if(var9 && (!isDefined(var3) || var3 == 0)) {
      break;
    }

    waitframe();

    if(isDefined(var6)) {
      var6 -= 0.05;

      if(var6 <= 0) {
        return 0;
      }
    }
  }

  return 1;
}

function is_looking_at(var0, var1, var2, var3) {
  if(isent(var0) && isDefined(var2)) {
    var4 = var0 gettagorigin(var2);
  } else if((isent(var1) || isstruct(var1)) && isDefined(var1.origin)) {
    var4 = var1.origin;
  } else {
    var4 = var2;
  }

  var5 = level.player worldpointtoscreenpos(var4, getdvarint("MRNKTKLLKP"));

  if(!isDefined(var5)) {
    return 0;
  }

  if(isDefined(var3) && length2d(var5) > var3) {
    return 0;
  }

  if(!isDefined(var4) || var4) {
    jumpiffalse(isent(var2)) LOC_00000098;
    var6 = [level.player, var2];
    goto LOC_000000a3;
  } else {
    var7 = 1;
  }

  return var7;
}

function wait_near(var0, var1) {
  var2 = var1 * var1;
  var3 = var0;

  for(;;) {
    if(isent(var0)) {
      var3 = var0.origin;
    }

    if(distance2dsquared(self.origin, var3) < var2) {
      break;
    }

    waitframe();
  }
}

function say_line_on_enemy_radio(var0, var1, var2, var3) {
  var1 = default_if_undefined(var1, 2);
  var2 = default_if_undefined(var2, 3);
  var3 = default_if_undefined(var3, 0.8);
  wait_combat_cooldown(var3, var2);

  for(;;) {
    var4 = getcorpsearrayinradius(level.player.origin, 300);

    if(var4.size == 0) {} else {
      var5 = undefined;
      var6 = undefined;

      foreach(var8 in var4) {
        if(getsubstr(var8.classname, 0, 11) != "actor_enemy") {
          continue;
        }

        var9 = distance2dsquared(level.player.origin, var8 gettagorigin("j_chest"));

        if(!isDefined(var6) || var9 < var6) {
          var5 = var8;
          var6 = var9;
        }
      }

      if(!isDefined(var5)) {} else {
        var11 = var5 gettagorigin("j_chest");
        var12 = var5 gettagangles("j_chest");
        var13 = scripts\engine\utility::spawn_script_origin(var11, var12);
        var13 linkTo(var5, "j_chest");
        wait_for_break_in_chatter(var1);
        say(var13, var0, 1);
        return;
      }
    }

    waitframe();
  }
}