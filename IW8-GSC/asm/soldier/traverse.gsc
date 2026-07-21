/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\traverse.gsc
***********************************************/

playtraverseanim_deprecated(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  scripts\asm\traverse::checktraverse(var_1);
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  self.desired_anim_pose = "crouch";
  scripts\anim\utility.gsc::updateanimpose();
  self endon("killanimscript");
  self animmode("noclip");
  var_5 = self getnegotiationstartnode();
  self orientmode("face angle", var_5.angles[1]);
  var_5.traverse_height = var_5.origin[2] + var_5.traverse_height_delta;
  var_6 = var_5.traverse_height - var_5.origin[2];
  thread teleportthread(var_6 - var_2);
  var_7 = 0.15;
  self aisetanim(var_1, var_3);
  var_8 = 0.2;
  var_9 = 0.2;
  thread traverse_donotetracks(var_0, var_1);

  if(!animhasnotetrack(var_4, "gravity on")) {
    var_10 = 1.23;
    wait(var_10 - var_8);
    self animmode("gravity");
    wait(var_8);
  } else {
    self waittillmatch("traverse", "gravity on");
    self animmode("gravity");

    if(!animhasnotetrack(var_4, "blend"))
      wait(var_8);
    else
      self waittillmatch("traverse", "blend");
  }

  terminatetraverse(var_0, var_1);
}

handletraverselegacynotetracks(var_0) {
  if(var_0 == "traverse_death")
    return handletraversedeathnotetrack();
  else if(var_0 == "traverse_align")
    return handletraversealignment();
  else if(var_0 == "traverse_drop")
    return handletraversedrop();
}

handletraversedeathnotetrack() {
  if(isDefined(self.traversedeathanim)) {
    var_0 = self.traversedeathanim[self.traversedeathindex];
    self.deathanim = var_0[randomint(var_0.size)];
    self.traversedeathindex++;
  }
}

handletraversealignment() {
  self animmode("noclip");

  if(isDefined(self.traverseheight) && isDefined(self.traversestartnode.traverse_height)) {
    var_0 = self.traversestartnode.traverse_height - self.traversestartz;
    thread teleportthread(var_0 - self.traverseheight);
  }
}

handletraversedrop() {
  var_0 = self.origin + (0, 0, 32);
  var_1 = physicstrace(var_0, self.origin + (0, 0, -512));
  var_2 = distance(var_0, var_1);
  var_3 = var_2 - 32 - 0.5;
  var_4 = self aigetanimtime(self.traversexanim);
  var_5 = getmovedelta(self.traversexanim, var_4, 1.0);
  var_6 = getanimlength(self.traversexanim);
  var_7 = var_4 * var_6;
  var_8 = 0 - var_5[2];
  var_9 = var_8 - var_3;

  if(var_8 < var_3)
    var_10 = var_8 / var_3;
  else
    var_10 = 1;

  var_11 = (var_6 - var_4) / 3.0;
  var_12 = (var_6 - var_7) / 3.0;
  var_13 = ceil(var_12 * 20);
  thread teleportthreadex(var_9, 0, var_13, var_10);
  thread finishtraversedrop(var_1[2]);
}

finishtraversedrop(var_0) {
  self endon("killanimscript");
  self endon("death");
  var_0 = var_0 + 4.0;

  for(;;) {
    if(self.origin[2] < var_0) {
      self animmode("gravity");
      break;
    }

    waitframe();
  }
}

playtraverseanim(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  scripts\asm\traverse::checktraverse(var_1);
  self animmode("noclip");
  var_4 = self getnegotiationstartnode();
  self orientmode("face angle", var_4.angles[1]);
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_donotetracks(var_0, var_1);
  terminatetraverse(var_0, var_1);
}

teleportthread(var_0) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  var_1 = 5;
  var_2 = (0, 0, var_0 / var_1);

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self forceteleport(self.origin + var_2);
    waitframe();
  }
}

teleportthreadex(var_0, var_1, var_2, var_3) {
  self endon("killanimscript");
  self endon("death");
  self notify("endTeleportThread");
  self endon("endTeleportThread");

  if(var_0 == 0 || var_2 <= 0) {
    return;
  }
  if(var_1 > 0)
    wait(var_1);

  var_4 = (0, 0, var_0 / var_2);

  if(isDefined(var_3) && var_3 < 1.0)
    self aisetanimrate(self.traversexanim, var_3);

  for(var_5 = 0; var_5 < var_2; var_5++) {
    self forceteleport(self.origin + var_4);
    waitframe();
  }

  if(isDefined(var_3) && var_3 < 1.0)
    self aisetanimrate(self.traversexanim, 1.0);
}

playtraverseanim_doublejump(var_0, var_1, var_2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");
  var_3 = getdvarint("ai_debug_doublejump", 0);

  if(var_3 != 3 && var_3 != 4)
    scripts\asm\traverse::checktraverse(var_1);

  self.ragdoll_immediate = 1;
  var_4 = self getnegotiationstartnode();
  var_5 = self getnegotiationendpos();
  var_4.traverse_height = var_4.origin[2] + var_4.traverse_height_delta - 44;
  var_6 = [];

  if(var_4.traverse_height > var_5[2]) {
    var_7 = (var_4.origin[0] + var_5[0]) * 0.5;
    var_8 = (var_4.origin[1] + var_5[1]) * 0.5;
    var_6[var_6.size] = (var_7, var_8, var_4.traverse_height);
  }

  var_6[var_6.size] = var_5;
  var_10 = spawn("script_model", var_4.origin);
  var_10 setModel("tag_origin");
  var_10.angles = var_4.angles;
  thread scripts\engine\utility::delete_on_death(var_10);
  self orientmode("face angle", var_4.angles[1]);
  var_11 = 1.63;
  self linkTo(var_10);
  var_12 = scripts\asm\asm::asm_getanim(var_0, var_1);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, scripts\asm\asm::asm_getxanim(var_12));
  self aisetanim(var_1, var_12);
  thread traverse_donotetracks(var_0, var_1);

  foreach(var_14 in var_6) {
    var_15 = var_11 / var_6.size;
    var_10 moveTo(var_14, var_15);
    var_10 waittill("movedone");
  }

  self notify("double_jumped");
  self unlink();
  self.ragdoll_immediate = undefined;
  var_10 delete();
  thread terminatetraverse(var_0, var_1);
}

traverse_doublejump_cleanup(var_0, var_1, var_2) {
  self unlink();
  self.ragdoll_immediate = undefined;
}

traverse_donotetracks(var_0, var_1) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var_1 + "_finished");
  self endon("double_jumped");
  scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

getexternaltraverseinfo(var_0) {
  return level.scr_traverse[var_0];
}

playtraverseanim_external(var_0, var_1, var_2) {
  scripts\asm\traverse::playtraverseanim_scaled(var_0, var_1);
}

choosetraverseanim_external(var_0, var_1, var_2) {
  var_3 = self getnegotiationstartnode();
  var_4 = var_3.animscript;
  var_5 = getexternaltraverseinfo(var_4);
  return var_5;
}

playdoublejumpfinishanim(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  self.useanimgoalweight = 1;
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self aisetanim(var_1, var_3);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  scripts\asm\asm::asm_donotetracks(var_0, var_1);
  thread terminatetraverse(var_0, var_1);
}

getdoublejumpoffsetposition(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\asm\asm::asm_chooseanim(var_0, var_1);
  var_6 = scripts\asm\asm::asm_getxanim(var_1, var_5);
  var_7 = getnotetracktimes(var_6, var_4);
  var_8 = var_7[0];
  var_9 = getmovedelta(var_6, 0, var_8);
  var_10 = getangledelta(var_6, 0, var_8);
  return scripts\asm\soldier\cover::calcanimstartpos(var_2, var_3[1], var_9, var_10);
}

doublejumpneedsfinishanim(var_0, var_1, var_2, var_3) {
  var_4 = var_3[2] - var_2.origin[2];

  if(var_4 < 0)
    return 0;

  if(isDefined(var_2.jump_over_offset) && getdvarint("ai_debug_doublejump", 0) != 2) {
    var_5 = var_2.jump_over_offset;
    var_6 = var_2.angles - var_2.startnodeoriginalangles;

    if(var_6 != (0, 0, 0))
      var_5 = rotatevector(var_5, var_6);

    var_7 = var_2.origin + var_5;
    var_8 = var_7[2];
    var_8 = var_8 - 44;

    if(var_3[2] < var_8)
      return 0;
  }

  var_9 = var_3 - var_2.origin;
  var_9 = (var_9[0], var_9[1], 0);
  var_10 = vectortoangles(var_9);
  var_11 = getdoublejumpoffsetposition(var_0, var_1, var_3, var_10, "footstep_left_small");
  var_12 = var_11 - var_2.origin;

  if(vectordot(var_12, var_9) < 0)
    return 0;

  return 1;
}

checkdoublejumpfinish(var_0, var_1, var_2, var_3) {
  var_4 = gettraversalstartnode();

  if(!isDefined(var_4)) {
    thread terminatetraverse(var_0, "double_jump");
    return 0;
  }

  var_5 = gettraversalendpos();

  if(!doublejumpneedsfinishanim(var_0, var_2, var_4, var_5)) {
    thread terminatetraverse(var_0, "double_jump");
    return 0;
  }

  return 1;
}

gettraversalstartnode() {
  if(isDefined(self.traversal_start_node))
    return self.traversal_start_node;

  return self getnegotiationstartnode();
}

gettraversalendpos() {
  if(isDefined(self.traversal_end_pos))
    return self.traversal_end_pos;

  return self getnegotiationendpos();
}

playdoublejumpmantleorvault(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = gettraversalstartnode();
  var_4 = var_3.doublejumpmantlepos;
  var_5 = var_4 - var_3.origin;
  var_5 = (var_5[0], var_5[1], 0);
  var_6 = vectortoangles(var_5);
  var_7 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_8 = var_1 + "_finish";
  var_9 = getdoublejumpoffsetposition(var_0, var_8, var_4, var_6, "mantle_align");
  var_9 = (var_9[0], var_9[1], var_9[2] + var_2);
  playscaledjump(var_0, var_1, var_7, var_9, var_6, 1, 0, 1);
}

playdoublejumpmantle(var_0, var_1, var_2) {
  playdoublejumpmantleorvault(var_0, var_1, -8);
}

playdoublejumpvault(var_0, var_1, var_2) {
  playdoublejumpmantleorvault(var_0, var_1, -42);
}

doublejumpterminate(var_0, var_1, var_2) {
  self.useanimgoalweight = 0;
  self.jump_over_position = undefined;
  self.traversal_start_node = undefined;
  self.traversal_end_pos = undefined;
}

doublejumpearlyterminate(var_0, var_1, var_2) {
  if(!scripts\asm\asm::asm_eventfired(var_0, "end"))
    doublejumpterminate(var_0, var_1, var_2);
}

isdoublejumpanimdone(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::asm_eventfired(var_0, "end");
}

playdoublejumptraversal(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = gettraversalstartnode();
  var_4 = gettraversalendpos();

  if(!isDefined(var_3.startnodeoriginalangles))
    var_3.startnodeoriginalangles = var_3.angles;

  var_5 = var_3.angles - var_3.startnodeoriginalangles;

  if(var_5 != (0, 0, 0))
    var_4 = rotatevector(var_4, var_5);

  var_6 = undefined;
  var_7 = getdvarint("ai_debug_doublejump", 0);

  if(var_7 != 2) {
    if(isDefined(var_3.jump_over_offset)) {
      var_8 = var_3.jump_over_offset;

      if(var_5 != (0, 0, 0))
        var_8 = rotatevector(var_8, var_5);

      var_6 = var_3.origin + var_8;
      var_9 = var_6[2];
      var_9 = var_9 - 44;

      if(var_9 > var_4[2]) {
        var_10 = (var_3.origin[0] + var_4[0]) * 0.5;
        var_11 = (var_3.origin[1] + var_4[1]) * 0.5;
        var_6 = (var_10, var_11, var_6[2]);
      } else
        var_6 = undefined;
    }
  }

  var_12 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self.jump_over_position = var_6;
  var_13 = var_1 + "_finish";

  if(doublejumpneedsfinishanim(var_0, var_13, var_3, var_4)) {
    var_14 = var_4 - var_3.origin;
    var_14 = (var_14[0], var_14[1], 0);
    var_15 = vectortoangles(var_14);
    var_13 = var_1 + "_finish";
    var_16 = getdoublejumpoffsetposition(var_0, var_13, var_4, var_15, "footstep_left_small");
    var_4 = var_16;
  }

  var_14 = var_4 - var_3.origin;
  var_17 = 0;
  var_18 = 1.0;

  if(var_14[2] < 0) {
    var_17 = 1;
    var_19 = getnotetracktimes(scripts\asm\asm::asm_getxanim(var_1, var_12), "gravity on");

    if(isDefined(var_19) && var_19.size > 0)
      var_18 = var_19[0];
  }

  var_14 = (var_14[0], var_14[1], 0);
  var_15 = vectortoangles(var_14);
  playscaledjump(var_0, var_1, var_12, var_4, var_15, var_18, var_17, 1);
}

choosedoublejumpanim(var_0, var_1, var_2) {
  var_3 = gettraversalendpos();
  var_4 = "double_jump_up";

  if(isDefined(var_2))
    var_4 = "double_jump_" + var_2;
  else if(var_3[2] < self.origin[2])
    var_4 = "double_jump_down";

  if(self.asm.footsteps.foot == "right")
    var_5 = "right_";
  else
    var_5 = "left_";

  var_4 = var_5 + var_4;
  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_4);
  return var_6;
}

getwallnodeposition(var_0, var_1) {
  var_2 = var_0.angles - var_0.wall_info.startnodeoriginalangles;

  if(var_2 != (0, 0, 0)) {
    var_3 = rotatevector(var_0.wall_info.nodeoffsets[var_1], var_2);
    var_4 = var_0.origin + var_3;
  } else
    var_4 = var_0.origin + var_0.wall_info.nodeoffsets[var_1];

  return var_4;
}

shouldwallrunshoot(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.enemy))
    return 0;

  var_4 = self.enemy.origin;
  var_5 = self.traversal_start_node;
  var_6 = getwallnodeposition(var_5, self.wall_run_current_node_index);
  var_7 = getwallnodeposition(var_5, self.wall_run_current_node_index + 1);
  var_7 = (var_7[0], var_7[1], var_6[2]);
  var_4 = (var_4[0], var_4[1], var_6[2]);
  var_8 = vectorNormalize(var_7 - var_6);
  var_9 = vectorNormalize(var_4 - var_6);
  var_10 = vectordot(var_8, var_9);

  if(var_10 < 0.2588)
    return 0;

  return 1;
}

choosewallrunanim(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, self.wall_run_direction);
  return var_3;
}

getsmoothstep(var_0) {
  return var_0 * var_0 * (3 - 2 * var_0);
}

teleportdeltaovernumframes(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon(var_0 + "_finished");

  if(var_1 > 0)
    wait(var_1);

  var_6 = var_2 / var_3;
  var_7 = self.origin[2];
  var_8 = var_7 + var_2[2];
  var_9 = self.origin[2];
  self setanimrate(var_4, var_5);

  for(var_10 = 0; var_10 < var_3; var_10++) {
    var_11 = 1;

    if(var_11) {
      var_12 = var_10 / (var_3 - 1);
      var_13 = getsmoothstep(var_12);
      var_14 = var_8 * var_13 + var_7 * (1 - var_13);
      var_15 = var_14 - var_9;
      var_6 = (var_6[0], var_6[1], var_15);
      var_9 = var_14;
    }

    var_16 = self.origin + var_6;
    self forceteleport(var_16);

    if(var_10 + 1 < var_3)
      waitframe();
  }

  self setanimrate(var_4, 1);
}

wallrunnotehandler(var_0, var_1) {
  if(var_0 == "start_jump")
    thread handlejumpteleports(var_1);
  else if(var_0 == "end_mantle")
    self animmode("gravity");
}

handlejumpteleports(var_0, var_1, var_2) {
  var_3 = var_0[0];
  var_4 = var_0[1];
  var_5 = var_0[2];
  var_6 = var_0[3];
  var_7 = var_0[4];
  var_8 = var_0[5];
  var_9 = var_0[6];
  self endon(var_3 + "_finished");
  var_10 = getanimlength(var_4);

  if(!isDefined(var_1))
    var_1 = (gettime() - var_6) * 0.001;

  var_11 = var_1 / var_10;
  var_12 = getnotetracktimes(var_4, "end_jump");
  var_13 = getnotetracktimes(var_4, "end_double_jump");

  if(var_13.size > 0) {
    self.wall_run_double_jumping = 1;
    var_12 = var_13;
  } else
    self.wall_run_double_jumping = 0;

  if(isDefined(self.jump_over_position)) {
    var_7 = (var_12[0] - var_11) / 2 + var_11;
    var_12[0] = var_7;
    var_5 = self.jump_over_position;
  }

  var_14 = getmovedelta(var_4, var_11, var_7);
  var_15 = self localtoworldcoords(var_14);

  if(!isDefined(var_2))
    var_2 = 1;

  if(var_9) {
    var_16 = distance(self.origin, var_15);
    var_17 = distance(self.origin, var_5);
    var_2 = var_16 / var_17;

    if(var_2 < 0.7)
      var_2 = 0.7;
    else if(var_2 > 1.3)
      var_2 = 1.3;
  }

  var_19 = var_5 - var_15;
  var_20 = var_12[0] * var_10;
  var_21 = var_20 - var_11 * var_10;
  var_21 = var_21 * (1 / var_2);
  var_22 = var_21 * 20;
  var_22 = ceil(var_22);
  var_23 = gettime();
  teleportdeltaovernumframes(var_3, 0, var_19, var_22, var_4, var_2);

  if(isDefined(self.jump_over_position)) {
    var_24 = (gettime() - var_23) * var_2;
    var_25 = var_1 + var_24 * 0.001;
    self.jump_over_position = undefined;
    var_0[6] = 0;
    handlejumpteleports(var_0, var_25, var_2);
  }
}

getwallrunyawfromstartnode(var_0) {
  var_1 = getwallnodeposition(var_0, 1) - getwallnodeposition(var_0, 0);
  var_2 = vectortoangles(var_1);
  return var_2[1];
}

getwallrundirectionfromstartnode(var_0) {
  self.wall_run_current_node_index = 0;
  var_1 = getwallnodeposition(var_0, 1) - getwallnodeposition(var_0, 0);
  var_2 = vectortoangles(var_1);
  self.wall_run_yaw = var_2[1];
  var_3 = getwallnodeposition(var_0, self.wall_run_current_node_index);
  var_4 = anglestoright(var_2);
  var_5 = var_3 - var_0.origin;
  var_6 = vectordot(var_4, var_5);

  if(var_6 > 0)
    return "right";

  return "left";
}

setupwallrunifneeded() {
  if(isDefined(self.wall_run_direction)) {
    return;
  }
  if(!isDefined(self.traversal_start_node)) {
    self.traversal_start_node = self getnegotiationstartnode();
    self.traversal_end_pos = self getnegotiationendpos();
  }

  var_0 = self.traversal_start_node;
  self.wall_run_direction = getwallrundirectionfromstartnode(var_0);
}

getwallrundirection() {
  setupwallrunifneeded();
  return self.wall_run_direction;
}

wallrunterminate(var_0, var_1, var_2) {
  self.wall_run_current_node_index = undefined;
  self.wall_run_direction = undefined;
  self.wall_run_double_jumping = undefined;
  self.wall_run_yaw = undefined;
  self.wall_run_attach_anim = undefined;
  self setdefaultaimlimits();
  self.useanimgoalweight = 0;
  self.jump_over_position = undefined;
  self.traversal_start_node = undefined;
  self.traversal_end_pos = undefined;
}

traversalorientearlyterminate(var_0, var_1, var_2) {
  if(!scripts\asm\asm::asm_eventfired(var_0, "end") && !scripts\asm\asm::asm_eventfired(var_0, "code_move"))
    cleanupwallruntransitioncheck(var_0, var_1, var_2);
}

playwallrunattach(var_0, var_1, var_2) {
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  self.useanimgoalweight = 1;

  if(isDefined(var_2) && var_2 == "shoot")
    setupwallrunaimlimits();

  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  var_5 = getnotetracktimes(var_4, "wall_contact");
  var_6 = var_5[0];
  var_7 = getangledelta(var_4, 0, var_6);
  var_8 = self.wall_run_yaw - var_7;
  var_9 = (0, var_8, 0);
  self forceteleport(self.origin, var_9);
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  var_10 = scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
}

getwallattachoffsetposition(var_0) {
  var_1 = choosewallattachanim(var_0, "wall_run_attach");
  var_2 = getnotetracktimes(var_1, "wall_contact");
  var_3 = var_2[0];
  var_4 = getmovedelta(var_1, 0, var_3);
  var_5 = getangledelta(var_1, 0, var_3);
  return scripts\asm\soldier\cover::calcanimstartpos(getwallnodeposition(self.traversal_start_node, 0), self.wall_run_yaw, var_4, var_5);
}

playwallrunenter(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  var_5 = self.traversal_start_node;
  self.wall_run_current_node_index = 0;
  var_6 = getwallnodeposition(var_5, 0);
  var_7 = var_6 - self.origin;
  var_7 = (var_7[0], var_7[1], 0);
  var_8 = vectortoangles(var_7);
  var_9 = getwallattachoffsetposition();
  self orientmode("face angle", var_8[1]);
  var_10 = 1.0;
  var_11 = getnotetracktimes(var_4, "code_move");

  if(isDefined(var_11) && var_11.size > 0)
    var_10 = var_11[0];

  playscaledjump(var_0, var_1, var_3, var_9, var_8, var_10, 0, 1);
  self forceteleport(var_9, var_8);
}

playscaledjump(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon(var_1 + "_finished");

  if(!isDefined(var_5))
    var_5 = 1;

  if(!isDefined(var_6))
    var_6 = 0;

  if(!isDefined(var_7))
    var_7 = 0;

  self forceteleport(self.origin, var_4);
  self animmode("noclip");
  self orientmode("face angle", var_4[1]);
  var_8 = scripts\asm\asm::asm_getxanim(var_1, var_2);
  var_9 = getanimlength(var_8);
  var_10 = int(var_9 * 1000);
  self iw7shiphack_setmaymovetime(gettime() + var_10 - 1000);
  self.useanimgoalweight = 1;
  self aisetanim(var_1, var_2);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_8);
  var_11 = [var_1, var_8, var_3, gettime(), var_5, var_6, var_7];
  scripts\asm\asm::asm_donotetracks(var_0, var_1, ::wallrunnotehandler, var_11);
}

choosewallattachanim(var_0, var_1, var_2) {
  if(isDefined(self.wall_run_attach_anim))
    return self.wall_run_attach_anim;

  var_3 = self.wall_run_direction;
  var_4 = angleclamp180(self.wall_run_yaw - self.angles[1]);
  var_4 = abs(var_4);

  if(var_4 >= 22.5) {
    if(var_4 > 67.5)
      var_3 = var_3 + "_90";
    else
      var_3 = var_3 + "_45";
  }

  self.wall_run_attach_anim = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  return self.wall_run_attach_anim;
}

choosewallrunenteranim(var_0, var_1, var_2) {
  setupwallrunifneeded();
  var_3 = self.wall_run_direction;
  var_4 = self.traversal_start_node;
  var_5 = getwallnodeposition(var_4, 0);
  var_6 = var_5[2] - self.origin[2];
  var_7 = 0;

  if(var_6 >= 0) {
    if(var_6 > 120)
      var_7 = 1;
  } else if(0 - var_6 > 240)
    var_7 = 1;

  if(var_7 == 0) {
    var_8 = distancesquared(self.origin, var_5);

    if(var_8 > 40000)
      var_7 = 1;
  }

  var_9 = "left_";

  if(self.asm.footsteps.foot == "right")
    var_9 = "right_";

  if(var_7)
    var_3 = var_9 + "double_jump";
  else
    var_3 = var_9 + "single_jump";

  var_10 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  return var_10;
}

senddelayedevent(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  wait(var_2);
  scripts\asm\asm::asm_fireevent(var_0, var_3);

  if(var_4)
    self notify(var_3);
}

hasanotherwallrun(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.wall_run_current_node_index))
    return 0;

  var_4 = self.traversal_start_node;

  if(!isDefined(var_4))
    return 0;

  var_5 = self.wall_run_current_node_index + 2;

  if(var_4.wall_info.nodeoffsets.size <= var_5)
    return 0;

  return 1;
}

playwallruncontinue(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = self.traversal_start_node;
  scripts\asm\shared\utility::set_aim_and_turn_limits();
  self.wall_run_current_node_index = self.wall_run_current_node_index + 2;
  var_4 = getwallnodeposition(var_3, self.wall_run_current_node_index);
  var_5 = self.angles;

  if(self.wall_run_direction == "left")
    self.wall_run_direction = "right";
  else
    self.wall_run_direction = "left";

  var_6 = scripts\asm\asm::asm_getanim(var_0, var_1);
  playscaledjump(var_0, var_1, var_6, var_4, var_5);
}

getwallrunmantleposition(var_0) {
  var_1 = var_0.angles - var_0.wall_info.startnodeoriginalangles;

  if(var_1 == (0, 0, 0))
    return var_0.origin + var_0.wall_info.mantleoffset;

  var_2 = rotatevector(var_0.wall_info.mantleoffset, var_1);
  return var_0.origin + var_2;
}

getwallrunmantleangles(var_0) {
  if(!isDefined(var_0.wall_info.mantleangles))
    return undefined;

  var_1 = var_0.angles[1] - var_0.wall_info.startnodeoriginalangles[1];

  if(var_1 == 0)
    return var_0.wall_info.mantleangles;

  return (0, angleclamp180(var_0.wall_info.mantleangles[1] + var_1), 0);
}

getwallruntomantletype() {
  var_0 = self.traversal_start_node;

  if(!isDefined(var_0.wall_info.mantleoffset))
    return "none";

  var_1 = getwallrunmantleposition(var_0);

  if(var_1[2] >= self.origin[2])
    return "high";

  return "low";
}

shouldwallruntovault(var_0, var_1, var_2, var_3) {
  var_4 = self.traversal_start_node;

  if(!isDefined(var_4.wall_info.bvaultover))
    return 0;

  return var_4.wall_info.bvaultover;
}

playwallrunloop(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = self.traversal_start_node;
  setupwallrunaimlimits();
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_5 = scripts\asm\asm::asm_getxanim(var_1, var_4);
  var_6 = getmovedelta(var_5);
  var_7 = length2d(var_6);

  if(!isDefined(var_3.wall_info.mantleoffset) && self.wall_run_current_node_index == var_3.wall_info.nodeoffsets.size - 2) {
    var_8 = scripts\asm\asm::asm_getanim(var_0, "wall_run_exit");
    var_9 = scripts\asm\asm::asm_getxanim("wall_run_exit", var_8);
    var_10 = getnotetracktimes(var_9, "start_jump");
    var_11 = getanimlength(var_9);
    var_12 = getmovedelta(var_9, 0, var_10[0]);
    var_13 = length2d(var_12);
  } else
    var_13 = 0;

  var_14 = getwallnodeposition(var_3, self.wall_run_current_node_index + 1) - self.origin;
  var_15 = length(var_14);
  var_15 = var_15 - var_13;

  if(var_15 < 0)
    var_15 = 0;

  var_16 = var_15 / var_7;
  var_17 = getanimlength(var_5);
  var_18 = var_17 * var_16;
  thread senddelayedevent(var_0, var_1, var_18, "wall_run_loop_done", 1);
  var_19 = vectorNormalize(var_14);
  self orientmode("face direction", var_19);
  thread playwallrunendsound(var_1);
  self animmode("noclip");
  self aisetanim(var_1, var_4);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_5);
  scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

playwallrunendsound(var_0) {
  self endon("death");

  if(soundexists("wallrun_end_npc")) {
    self waittill("wall_run_loop_done");
    self playSound("wallrun_end_npc");
  }
}

choosewallrunexitanim(var_0, var_1, var_2) {
  var_3 = self.wall_run_direction;
  var_4 = self.traversal_end_pos;
  var_5 = var_4[2] - self.origin[2];
  var_6 = 0;

  if(var_5 >= 0) {
    if(var_5 > 120)
      var_6 = 1;
  } else if(0 - var_5 > 240)
    var_6 = 1;

  if(var_6 == 0) {
    var_7 = distancesquared(self.origin, var_4);

    if(var_7 > 46225)
      var_6 = 1;
  }

  if(var_6)
    var_3 = var_3 + "_double";

  var_4 = self.traversal_end_pos;
  var_8 = self.traversal_start_node;
  var_9 = self.traversal_end_pos - getwallnodeposition(var_8, var_8.wall_info.nodeoffsets.size - 1);
  var_9 = (var_9[0], var_9[1], 0);
  var_9 = vectorNormalize(var_9);
  var_10 = vectortoangles(var_9);
  var_11 = angleclamp180(var_10[1] - self.angles[1]);
  var_11 = abs(var_11);

  if(var_11 >= 22.5) {
    if(var_11 > 67.5)
      var_3 = var_3 + "_90";
    else
      var_3 = var_3 + "_45";
  }

  var_12 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  return var_12;
}

playwallrunexit(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = self.traversal_start_node;
  var_4 = self.traversal_end_pos;
  var_5 = self.angles;
  var_6 = 1.0;
  var_7 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_8 = getnotetracktimes(var_7, "ground");
  scripts\asm\shared\utility::set_aim_and_turn_limits();

  if(isDefined(var_8) && var_8.size > 0)
    var_6 = var_8[0];
  else {
    var_9 = getnotetracktimes(var_7, "end_double_jump");

    if(isDefined(var_9) && var_9.size > 0)
      var_6 = var_9[0];
    else {
      var_10 = getnotetracktimes(var_7, "end_jump");

      if(isDefined(var_10) && var_10.size > 0)
        var_6 = var_10[0];
    }
  }

  if(soundexists("wallrun_end_npc"))
    self playSound("wallrun_end_npc");

  playscaledjump(var_0, var_1, var_7, var_4, var_5, var_6, 1, 1);
  thread terminatewallruntraverse(var_0, var_1);
}

isnotdoingwallruntransition(var_0, var_1, var_2, var_3) {
  if(isDefined(self.traversal_start_node))
    return 0;

  return 1;
}

terminatewallruntraverse(var_0, var_1) {
  self.wall_run_current_node_index = undefined;
  self.wall_run_direction = undefined;
  self.wall_run_double_jumping = undefined;
  self.wall_run_yaw = undefined;
  self.wall_run_attach_anim = undefined;
  self setdefaultaimlimits();
  terminatetraverse(var_0, var_1);
}

playwallruntomantle(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = self.traversal_start_node;
  var_4 = self.traversal_end_pos;
  var_5 = getwallrunmantleposition(var_3);

  if(isDefined(var_3.wall_info.bvaultover) || getwallruntomantletype() == "high") {
    var_6 = getwallrunmantleangles(var_3);

    if(!isDefined(var_6)) {
      var_7 = var_4 - var_5;
      var_7 = (var_7[0], var_7[1], 0);
      var_6 = vectortoangles(var_7);
    }
  } else {
    var_7 = var_5 - self.origin;
    var_7 = (var_7[0], var_7[1], 0);
    var_6 = vectortoangles(var_7);
  }

  var_8 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_9 = getanimlength(var_8);
  var_10 = getnotetracktimes(var_8, "start_mantle");
  var_11 = var_10[0];
  var_12 = getnotetracktimes(var_8, "end_mantle");
  var_13 = var_12[0];
  var_14 = getmovedelta(var_8, var_11, var_13);
  self forceteleport(self.origin, var_6);
  var_15 = self localtoworldcoords(var_14);
  var_16 = var_15 - self.origin;
  var_17 = var_5 - var_16;
  playscaledjump(var_0, var_1, var_8, var_17, var_6, var_11, 0, 1);
  thread terminatewallruntraverse(var_0, var_1);
}

playtraversaltransition(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);

  if(!isDefined(var_3)) {
    scripts\asm\asm::asm_fireevent(var_0, "code_move");
    return;
  }

  var_4 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  var_5 = 1.0;
  var_6 = undefined;

  if(getdvarint("ai_wall_run_use_align_notetrack", 1) == 1)
    var_6 = getnotetracktimes(var_4, "align");

  if(!isDefined(var_6) || var_6.size == 0)
    var_6 = getnotetracktimes(var_4, "code_move");

  if(isDefined(var_6) && var_6.size > 0)
    var_5 = var_6[0];

  var_7 = getmovedelta(var_4, 0, var_5);
  var_8 = getangledelta(var_4, 0, var_5);
  var_9 = self.traversal_start_node;
  var_10 = getanimlength(var_4) * var_5;
  var_11 = int(ceil(var_10 * 20));

  if(self.traversal_start_node.animscript == "wall_run") {
    var_12 = getwallnodeposition(self.traversal_start_node, 0) - self.origin;
    var_13 = vectortoangles(var_12);
    var_14 = var_13[1];
  } else {
    var_15 = self.traversal_end_pos - self.traversal_start_node.origin;
    var_15 = (var_15[0], var_15[1], 0);
    var_16 = vectortoangles(var_15);
    var_14 = var_16[1];
  }

  var_17 = scripts\asm\soldier\cover::calcanimstartpos(var_9.origin, var_14, var_7, var_8);
  var_18 = var_14 - var_8;
  self.a.arrivalasmstatename = var_1;
  self.useanimgoalweight = 1;
  self startcoverarrival(var_17, var_18, var_11);
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_4);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
}

choosewallrunturn(var_0, var_1, var_2) {
  return scripts\asm\soldier\move::choosesharpturnanim(var_0, var_1, var_2);
}

choosetraversaltransition(var_0, var_1, var_2) {
  var_3 = anglesToForward(self.angles);
  var_4 = vectortoangles(var_3);

  if(self.traversal_start_node.animscript == "wall_run")
    var_5 = vectortoangles(getwallnodeposition(self.traversal_start_node, 0) - self.origin);
  else {
    var_6 = self.traversal_end_pos - self.traversal_start_node.origin;
    var_6 = (var_6[0], var_6[1], 0);
    var_5 = vectortoangles(var_6);
  }

  var_7 = var_5[1];
  var_8 = angleclamp180(var_7 - var_4[1]);
  var_9 = getangleindex(var_8, 22.5);
  var_10 = scripts\asm\soldier\arrival::getstopanims(var_0, var_1, undefined, 1);

  if(!isDefined(var_10[var_9]))
    return undefined;

  return var_10[var_9];
}

cleanupwallruntransitioncheck(var_0, var_1, var_2, var_3) {
  self.traversal_start_node = undefined;
  self.traversal_end_pos = undefined;
  self.wall_run_direction = undefined;
  return 0;
}

shouldabortwallrunattach(var_0, var_1, var_2, var_3) {
  var_4 = distance2dsquared(self.origin, getwallnodeposition(self.traversal_start_node, 1));

  if(var_4 < 144)
    return 1;

  return 0;
}

shoulddowallrunsharpturn(var_0, var_1, var_2, var_3) {
  if(isnotdoingwallruntransition(var_0, var_1, var_2, var_3)) {
    scripts\asm\traverse::setuptraversaltransitioncheck(var_0, var_1, var_2, var_3);

    if(!isDefined(self.traversal_start_node))
      return 0;

    if(self.traversal_start_node.animscript != "wall_run")
      return 0;

    var_4 = self.traversal_start_node;
    var_5 = vectorNormalize(getwallnodeposition(var_4, 0) - self.origin);
    var_6 = scripts\asm\soldier\move::calculatesharpturnanim(var_0, var_1, var_2, var_5, 0, 1);

    if(!isDefined(var_6))
      return 0;

    self.a.sharpturnindex = var_6;
    self.wall_run_direction = getwallrundirectionfromstartnode(self.traversal_start_node);
    return 1;
  }

  return 0;
}

shouldtraversetransitionto(var_0, var_1, var_2, var_3) {
  if(var_2 == self.traversal_start_node.animscript)
    return 1;

  return 0;
}

istraversaltransitionsupported(var_0) {
  switch (var_0) {
    case "rail_hop_double_jump_down":
    case "double_jump":
    case "double_jump_mantle":
    case "double_jump_vault":
    case "wall_run":
      return 1;
  }

  return 0;
}

shoulddotraversaltransition(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.traversal_start_node))
    return 0;

  if(!istraversaltransitionsupported(self.traversal_start_node.animscript))
    return 0;

  if(!self.facemotion)
    return 0;

  var_4 = undefined;

  if(self.traversal_start_node.animscript == "wall_run") {
    var_4 = getwallrundirectionfromstartnode(self.traversal_start_node);
    var_5 = getwallnodeposition(self.traversal_start_node, 0) - self.origin;
    var_6 = vectortoangles(var_5);
  } else {
    var_5 = self.traversal_end_pos - self.traversal_start_node.origin;
    var_5 = (var_5[0], var_5[1], 0);
    var_4 = vectorNormalize(var_5);
    var_6 = vectortoangles(var_4);
  }

  var_7 = var_6[1];
  var_8 = anglesToForward(self.angles);
  var_9 = vectortoangles(var_8);
  var_10 = angleclamp180(var_7 - var_9[1]);
  var_11 = getangleindex(var_10, 22.5);
  var_12 = scripts\asm\soldier\arrival::getstopanims(var_0, var_2, undefined, 1);
  var_13 = var_12[var_11];

  if(!isDefined(var_13))
    return 0;

  var_14 = 1.0;
  var_15 = undefined;

  if(getdvarint("ai_wall_run_use_align_notetrack", 1) == 1)
    var_15 = getnotetracktimes(var_13, "align");

  if(!isDefined(var_15) || var_15.size == 0)
    var_15 = getnotetracktimes(var_13, "code_move");

  if(isDefined(var_15) && var_15.size > 0)
    var_14 = var_15[0];

  var_16 = getmovedelta(var_13, 0, var_14);
  var_17 = getangledelta(var_13, 0, var_14);
  var_18 = distance2d(self.origin, self.traversal_start_node.origin);
  var_19 = length(var_16);
  var_20 = var_18 - var_19;

  if(var_20 < 0) {
    var_21 = anglesToForward(var_6);
    var_22 = vectordot(var_8, var_21);

    if(var_22 > 0.707) {
      if(abs(var_20) > 10)
        return 0;
    } else if(abs(var_20) > 64)
      return 0;
  } else if(var_20 > 10)
    return 0;

  if(self.traversal_start_node.animscript == "wall_run")
    self.wall_run_direction = var_4;

  return 1;
}

handlewallrunattachnotetrack(var_0) {
  if(var_0 == "wall_contact") {
    if(soundexists("wallrun_start_npc"))
      self playSound("wallrun_start_npc");
  }
}

setupwallrunaimlimits() {
  self.upaimlimit = -45;
  self.downaimlimit = 45;
  self.rightaimlimit = -90;
  self.leftaimlimit = 90;
}

playtraverseanim_ladder(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = self getnegotiationstartnode();
  var_4 = self getnegotiationendpos();
  self animmode("noclip", 0);
  self orientmode("face angle", var_3.angles[1]);
  var_5 = var_4 - var_3.origin;
  var_6 = scripts\asm\asm::asm_getdemeanor();
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  if(var_5[2] > 0) {
    var_10 = "off_" + var_6;
    var_9 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var_1, var_10);

    if(!isDefined(var_9))
      var_9 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "off");

    var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "up");
  } else {
    var_11 = "on_" + var_6;
    var_9 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var_1, var_11);

    if(!isDefined(var_9))
      var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "on");

    var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "down");
  }

  var_12 = 1;

  if(isDefined(self.moveplaybackrate))
    var_12 = self.moveplaybackrate;

  if(isDefined(var_8)) {
    self aisetanim(var_1, var_8, var_12);
    scripts\asm\asm::asm_donotetracks(var_0, var_1);
  }

  var_13 = var_4;

  if(isDefined(var_9)) {
    var_14 = scripts\asm\asm::asm_getxanim(var_1, var_9);
    var_15 = getmovedelta(var_14);
    var_13 = var_4 - var_15 + (0, 0, 1);
  }

  var_16 = var_13 - self.origin;

  if(var_16[2] * var_5[2] > 0) {
    var_17 = scripts\asm\asm::asm_getxanim(var_1, var_7);
    var_18 = getmovedelta(var_17);
    var_19 = var_18[2] * var_12 / getanimlength(var_17);
    var_20 = var_16[2] / var_19;
    self aisetanim(var_1, var_7, var_12);
    scripts\asm\asm::asm_donotetracksfortime(var_0, var_1, var_20);
  }

  if(isDefined(var_9)) {
    self aisetanim(var_1, var_9, var_12);
    scripts\asm\asm::asm_donotetracks(var_0, var_1);
  }

  terminatetraverse(var_0, var_1);
}

terminate_ladder(var_0, var_1, var_2) {
  self.nogravityragdoll = !isalive(self);
}

traverse_basic(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self animmode("noclip", 0);
  var_4 = self getnegotiationstartnode();
  self orientmode("face angle", var_4.angles[1]);
  self aisetanim(var_1, var_3);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1));
  terminatetraverse(var_0, var_1);
}

terminatetraverse(var_0, var_1) {
  self.useanimgoalweight = 0;
  self.istraversing = 0;
  self.jump_over_position = undefined;
  self.traversal_start_node = undefined;
  self.traversal_end_pos = undefined;
  scripts\asm\asm::asm_fireevent(var_0, "traverse_end");
  self finishtraverse();
  self motionwarpcancel();
}