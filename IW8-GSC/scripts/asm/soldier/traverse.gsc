/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\traverse.gsc
***********************************************/

function playtraverseanim_deprecated(var0, var1, var2) {
  self endon("death");
  self endon("terminate_ai_threads");
  scripts\asm\traverse::checktraverse(var1);
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  self.desired_anim_pose = "crouch";
  scripts\anim\utility::updateanimpose();
  self endon("killanimscript");
  self animmode("noclip");
  var5 = self getnegotiationstartnode();
  self orientmode("face angle", var5.angles[1]);
  var5.traverse_height = var5.origin[2] + var5.traverse_height_delta;
  var6 = var5.traverse_height - var5.origin[2];
  thread teleportthread(var6 - var2);
  var7 = 0.15;
  self aisetanim(var1, var3);
  var8 = 0.2;
  var9 = 0.2;
  thread traverse_donotetracks(var0, var1);

  if(!animhasnotetrack(var4, "gravity on")) {
    var10 = 1.23;
    wait var10 - var8;
    self animmode("gravity");
    wait var8;
  } else {
    self waittillmatch("traverse", "gravity on");
    self animmode("gravity");

    if(!animhasnotetrack(var4, "blend")) {
      wait var8;
    } else {
      self waittillmatch("traverse", "blend");
    }
  }

  terminatetraverse(var0, var1);
}

function handletraverselegacynotetracks(var0) {
  if(var0 == "traverse_death") {
    return handletraversedeathnotetrack();
  }

  if(var0 == "traverse_align") {
    return handletraversealignment();
  }

  if(var0 == "traverse_drop") {
    return handletraversedrop();
  }
}

function handletraversedeathnotetrack() {
  if(isDefined(self.traversedeathanim)) {
    var0 = self.traversedeathanim[self.traversedeathindex];
    self.deathanim = var0[randomint(var0.size)];
    self.traversedeathindex++;
    return;
  }
}

function handletraversealignment() {
  self animmode("noclip");

  if(isDefined(self.traverseheight) && isDefined(self.traversestartnode.traverse_height)) {
    var0 = self.traversestartnode.traverse_height - self.traversestartz;
    thread teleportthread(var0 - self.traverseheight);
    return;
  }
}

function handletraversedrop() {
  var0 = self.origin + (0, 0, 32);
  var1 = physicstrace(var0, self.origin + (0, 0, -512));
  var2 = distance(var0, var1);
  var3 = var2 - 32 - 0.5;
  var4 = self aigetanimtime(self.traversexanim);
  var5 = getmovedelta(self.traversexanim, var4, 1);
  var6 = getanimlength(self.traversexanim);
  var7 = var4 * var6;
  var8 = 0 - var5[2];
  var9 = var8 - var3;

  if(var8 < var3) {
    var10 = var8 / var3;
  } else {
    var10 = 1;
  }

  var11 = (var7 - var5) / 3;
  var12 = (var7 - var8) / 3;
  var13 = ceil(var12 * 20);
  thread teleportthreadex(var10, 0, var13, var10);
  thread finishtraversedrop(var2[2]);
}

function finishtraversedrop(var0) {
  self endon("killanimscript");
  self endon("death");
  var0 += 4;

  for(;;) {
    if(self.origin[2] < var0) {
      self animmode("gravity");
      break;
    }

    waitframe();
  }
}

function playtraverseanim(var0, var1, var2) {
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  scripts\asm\traverse::checktraverse(var1);
  self animmode("noclip");
  var4 = self getnegotiationstartnode();
  self orientmode("face angle", var4.angles[1]);
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_donotetracks(var0, var1);
  terminatetraverse(var0, var1);
}

function teleportthread(var0) {
  self endon("killanimscript");
  self notify("endTeleportThread");
  self endon("endTeleportThread");
  var1 = 5;
  var2 = (0, 0, var0 / var1);

  for(var3 = 0; var3 < var1; var3++) {
    self forceteleport(self.origin + var2);
    waitframe();
  }
}

function teleportthreadex(var0, var1, var2, var3) {
  self endon("killanimscript");
  self endon("death");
  self notify("endTeleportThread");
  self endon("endTeleportThread");

  if(var0 == 0 || var2 <= 0) {
    return;
  }

  if(var1 > 0) {
    wait var1;
  }

  var4 = (0, 0, var0 / var2);

  if(isDefined(var3) && var3 < 1) {
    self aisetanimrate(self.traversexanim, var3);
  }

  for(var5 = 0; var5 < var2; var5++) {
    self forceteleport(self.origin + var4);
    waitframe();
  }

  if(isDefined(var3) && var3 < 1) {
    self aisetanimrate(self.traversexanim, 1);
    return;
  }
}

function playtraverseanim_doublejump(var0, var1, var2) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var1 + "_finished");
  var3 = getdvarint("ai_debug_doublejump", 0);

  if(var3 != 3 && var3 != 4) {
    scripts\asm\traverse::checktraverse(var1);
  }

  self.ragdoll_immediate = 1;
  var4 = self getnegotiationstartnode();
  var5 = self getnegotiationendpos();
  var4.traverse_height = var4.origin[2] + var4.traverse_height_delta - 44;
  var6 = [];

  if(var4.traverse_height > var5[2]) {
    var7 = (var4.origin[0] + var5[0]) * 0.5;
    var8 = (var4.origin[1] + var5[1]) * 0.5;
    var6 = (var7, var8, var4.traverse_height);
  }

  GscBinSkip0(0x2e, var6.size, var5);
}

function traverse_doublejump_cleanup(var0, var1, var2) {
  self unlink();
  self.ragdoll_immediate = undefined;
}

function traverse_donotetracks(var0, var1) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(var1 + "_finished");
  self endon("double_jumped");
  scripts\asm\asm::asm_donotetracks(var0, var1);
}

function getexternaltraverseinfo(var0) {
  return level.scr_traverse[var0];
}

function playtraverseanim_external(var0, var1, var2) {
  scripts\asm\traverse::playtraverseanim_scaled(var0, var1);
}

function choosetraverseanim_external(var0, var1, var2) {
  var3 = self getnegotiationstartnode();
  var4 = var3.animscript;
  var5 = getexternaltraverseinfo(var4);
  return var5;
}

function playdoublejumpfinishanim(var0, var1, var2) {
  self endon(var1 + "_finished");
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  self.useanimgoalweight = 1;
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  self aisetanim(var1, var3);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  scripts\asm\asm::asm_donotetracks(var0, var1);
  thread terminatetraverse(var0, var1);
}

function getdoublejumpoffsetposition(var0, var1, var2, var3, var4) {
  var5 = scripts\asm\asm::asm_chooseanim(var0, var1);
  var6 = scripts\asm\asm::asm_getxanim(var1, var5);
  var7 = getnotetracktimes(var6, var4);
  var8 = var7[0];
  var9 = getmovedelta(var6, 0, var8);
  var10 = getangledelta(var6, 0, var8);
  return scripts\asm\soldier\cover::calcanimstartpos(var2, var3[1], var9, var10);
}

function doublejumpneedsfinishanim(var0, var1, var2, var3) {
  var4 = var3[2] - var2.origin[2];

  if(var4 < 0) {
    return false;
  }

  if(isDefined(var2.jump_over_offset) && getdvarint("ai_debug_doublejump", 0) != 2) {
    var5 = var2.jump_over_offset;
    var6 = var2.angles - var2.startnodeoriginalangles;

    if(var6 != (0, 0, 0)) {
      var5 = rotatevector(var5, var6);
    }

    var7 = var2.origin + var5;
    var8 = var7[2];
    var8 -= 44;

    if(var3[2] < var8) {
      return false;
    }
  }

  var9 = var3 - var2.origin;
  var9 = (var9[0], var9[1], 0);
  var10 = vectortoangles(var9);
  var11 = getdoublejumpoffsetposition(var0, var1, var3, var10, "footstep_left_small");
  var12 = var11 - var2.origin;

  if(vectordot(var12, var9) < 0) {
    return false;
  }

  return true;
}

function checkdoublejumpfinish(var0, var1, var2, var3) {
  var4 = gettraversalstartnode();

  if(!isDefined(var4)) {
    thread terminatetraverse(var0, "double_jump");
    return false;
  }

  var5 = gettraversalendpos();

  if(!doublejumpneedsfinishanim(var0, var2, var4, var5)) {
    thread terminatetraverse(var0, "double_jump");
    return false;
  }

  return true;
}

function gettraversalstartnode() {
  if(isDefined(self.traversal_start_node)) {
    return self.traversal_start_node;
  }

  return self getnegotiationstartnode();
}

function gettraversalendpos() {
  if(isDefined(self.traversal_end_pos)) {
    return self.traversal_end_pos;
  }

  return self getnegotiationendpos();
}

function playdoublejumpmantleorvault(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = gettraversalstartnode();
  var4 = var3.doublejumpmantlepos;
  var5 = var4 - var3.origin;
  var5 = (var5[0], var5[1], 0);
  var6 = vectortoangles(var5);
  var7 = scripts\asm\asm::asm_getanim(var0, var1);
  var8 = var1 + "_finish";
  var9 = getdoublejumpoffsetposition(var0, var8, var4, var6, "mantle_align");
  var9 = (var9[0], var9[1], var9[2] + var2);
  playscaledjump(var0, var1, var7, var9, var6, 1, 0, 1);
}

function playdoublejumpmantle(var0, var1, var2) {
  playdoublejumpmantleorvault(var0, var1, -8);
}

function playdoublejumpvault(var0, var1, var2) {
  playdoublejumpmantleorvault(var0, var1, -42);
}

function doublejumpterminate(var0, var1, var2) {
  self.useanimgoalweight = 0;
  self.jump_over_position = undefined;
  self.traversal_start_node = undefined;
  self.traversal_end_pos = undefined;
}

function doublejumpearlyterminate(var0, var1, var2) {
  if(!scripts\asm\asm::asm_eventfired(var0, "end")) {
    doublejumpterminate(var0, var1, var2);
    return;
  }
}

function isdoublejumpanimdone(var0, var1, var2, var3) {
  return scripts\asm\asm::asm_eventfired(var0, "end");
}

function playdoublejumptraversal(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = gettraversalstartnode();
  var4 = gettraversalendpos();

  if(!isDefined(var3.startnodeoriginalangles)) {
    var3.startnodeoriginalangles = var3.angles;
  }

  var5 = var3.angles - var3.startnodeoriginalangles;

  if(var5 != (0, 0, 0)) {
    var4 = rotatevector(var4, var5);
  }

  var6 = undefined;
  var7 = getdvarint("ai_debug_doublejump", 0);

  if(var7 != 2) {
    if(isDefined(var3.jump_over_offset)) {
      var8 = var3.jump_over_offset;

      if(var5 != (0, 0, 0)) {
        var8 = rotatevector(var8, var5);
      }

      var6 = var3.origin + var8;
      var9 = var6[2];
      var9 -= 44;

      if(var9 > var4[2]) {
        var10 = (var3.origin[0] + var4[0]) * 0.5;
        var11 = (var3.origin[1] + var4[1]) * 0.5;
        var6 = (var10, var11, var6[2]);
      } else {
        var6 = undefined;
      }
    }
  }

  var12 = scripts\asm\asm::asm_getanim(var0, var1);
  self.jump_over_position = var6;
  var13 = var1 + "_finish";

  if(doublejumpneedsfinishanim(var0, var13, var3, var4)) {
    var14 = var4 - var3.origin;
    var14 = (var14[0], var14[1], 0);
    var15 = vectortoangles(var14);
    var13 = var1 + "_finish";
    var16 = getdoublejumpoffsetposition(var0, var13, var4, var15, "footstep_left_small");
    var4 = var16;
  }

  var14 = var4 - var3.origin;
  var17 = 0;
  var18 = 1;

  if(var14[2] < 0) {
    var17 = 1;
    var19 = getnotetracktimes(scripts\asm\asm::asm_getxanim(var1, var12), "gravity on");

    if(isDefined(var19) && var19.size > 0) {
      var18 = var19[0];
    }
  }

  var14 = (var14[0], var14[1], 0);
  var15 = vectortoangles(var14);
  playscaledjump(var0, var1, var12, var4, var15, var18, var17, 1);
}

function choosedoublejumpanim(var0, var1, var2) {
  var3 = gettraversalendpos();
  var4 = "double_jump_up";

  if(isDefined(var2)) {
    var4 = "double_jump_" + var2;
  } else if(var3[2] < self.origin[2]) {
    var4 = "double_jump_down";
  }

  if(self.asm.footsteps.foot == "right") {
    var5 = "right_";
  } else {
    var5 = "left_";
  }

  var5 += var5;
  var6 = scripts\asm\asm::asm_lookupanimfromalias(var2, var5);
  return var6;
}

function getwallnodeposition(var0, var1) {
  var2 = var0.angles - var0.wall_info.startnodeoriginalangles;

  if(var2 != (0, 0, 0)) {
    var3 = rotatevector(var0.wall_info.nodeoffsets[var1], var2);
    var4 = var0.origin + var3;
  } else {
    var4 = var1.origin + var1.wall_info.nodeoffsets[var2];
  }

  return var4;
}

function shouldwallrunshoot(var0, var1, var2, var3) {
  if(!isDefined(self.enemy)) {
    return false;
  }

  var4 = self.enemy.origin;
  var5 = self.traversal_start_node;
  var6 = getwallnodeposition(var5, self.wall_run_current_node_index);
  var7 = getwallnodeposition(var5, self.wall_run_current_node_index + 1);
  var7 = (var7[0], var7[1], var6[2]);
  var4 = (var4[0], var4[1], var6[2]);
  var8 = vectorNormalize(var7 - var6);
  var9 = vectorNormalize(var4 - var6);
  var10 = vectordot(var8, var9);

  if(var10 < 0.2588) {
    return false;
  }

  return true;
}

function choosewallrunanim(var0, var1, var2) {
  var3 = scripts\asm\asm::asm_lookupanimfromalias(var1, self.wall_run_direction);
  return var3;
}

function getsmoothstep(var0) {
  return var0 * var0 * (3 - 2 * var0);
}

function teleportdeltaovernumframes(var0, var1, var2, var3, var4, var5) {
  self endon(var0 + "_finished");

  if(var1 > 0) {
    wait var1;
  }

  var6 = var2 / var3;
  var7 = self.origin[2];
  var8 = var7 + var2[2];
  var9 = self.origin[2];
  self setanimrate(var4, var5);

  for(var10 = 0; var10 < var3; var10++) {
    var11 = 1;

    if(var11) {
      var12 = var10 / (var3 - 1);
      var13 = getsmoothstep(var12);
      var14 = var8 * var13 + var7 * (1 - var13);
      var15 = var14 - var9;
      var6 = (var6[0], var6[1], var15);
      var9 = var14;
    }

    var16 = self.origin + var6;
    self forceteleport(var16);

    if(var10 + 1 < var3) {
      waitframe();
    }
  }

  self setanimrate(var4, 1);
}

function wallrunnotehandler(var0, var1) {
  if(var0 == "start_jump") {
    thread handlejumpteleports(var1);
    return;
  }

  if(var0 == "end_mantle") {
    self animmode("gravity");
    return;
  }
}

function handlejumpteleports(var0, var1, var2) {
  var3 = var0[0];
  var4 = var0[1];
  var5 = var0[2];
  var6 = var0[3];
  var7 = var0[4];
  var8 = var0[5];
  var9 = var0[6];
  self endon(var3 + "_finished");
  var10 = getanimlength(var4);

  if(!isDefined(var1)) {
    var1 = (gettime() - var6) * 0.001;
  }

  var11 = var1 / var10;
  var12 = getnotetracktimes(var4, "end_jump");
  var13 = getnotetracktimes(var4, "end_double_jump");

  if(var13.size > 0) {
    self.wall_run_double_jumping = 1;
    var12 = var13;
  } else {
    self.wall_run_double_jumping = 0;
  }

  if(isDefined(self.jump_over_position)) {
    var7 = (var12[0] - var11) / 2 + var11;
    var12 = var7;
    var5 = self.jump_over_position;
  }

  var14 = getmovedelta(var4, var11, var7);
  var15 = self localtoworldcoords(var14);

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(var9) {
    var16 = distance(self.origin, var15);
    var17 = distance(self.origin, var5);
    var2 = var16 / var17;

    if(var2 < 0.7) {
      var2 = 0.7;
    } else if(var2 > 1.3) {
      var2 = 1.3;
    }
  }

  var19 = var5 - var15;
  var20 = var12[0] * var10;
  var21 = var20 - var11 * var10;
  var21 *= 1 / var2;
  var22 = var21 * 20;
  var22 = ceil(var22);
  var23 = gettime();
  teleportdeltaovernumframes(var3, 0, var19, var22, var4, var2);

  if(isDefined(self.jump_over_position)) {
    var24 = (gettime() - var23) * var2;
    var25 = var1 + var24 * 0.001;
    self.jump_over_position = undefined;
    var0 = 0;
    handlejumpteleports(var0, var25, var2);
    return;
  }
}

function getwallrunyawfromstartnode(var0) {
  var1 = getwallnodeposition(var0, 1) - getwallnodeposition(var0, 0);
  var2 = vectortoangles(var1);
  return var2[1];
}

function getwallrundirectionfromstartnode(var0) {
  self.wall_run_current_node_index = 0;
  var1 = getwallnodeposition(var0, 1) - getwallnodeposition(var0, 0);
  var2 = vectortoangles(var1);
  self.wall_run_yaw = var2[1];
  var3 = getwallnodeposition(var0, self.wall_run_current_node_index);
  var4 = anglestoright(var2);
  var5 = var3 - var0.origin;
  var6 = vectordot(var4, var5);

  if(var6 > 0) {
    return "right";
  }

  return "left";
}

function setupwallrunifneeded() {
  if(isDefined(self.wall_run_direction)) {
    return;
  }

  if(!isDefined(self.traversal_start_node)) {
    self.traversal_start_node = self getnegotiationstartnode();
    self.traversal_end_pos = self getnegotiationendpos();
  }

  var0 = self.traversal_start_node;
  self.wall_run_direction = getwallrundirectionfromstartnode(var0);
}

function getwallrundirection() {
  setupwallrunifneeded();
  return self.wall_run_direction;
}

function wallrunterminate(var0, var1, var2) {
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

function traversalorientearlyterminate(var0, var1, var2) {
  if(!scripts\asm\asm::asm_eventfired(var0, "end") && !scripts\asm\asm::asm_eventfired(var0, "code_move")) {
    cleanupwallruntransitioncheck(var0, var1, var2);
    return;
  }
}

function playwallrunattach(var0, var1, var2) {
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  self.useanimgoalweight = 1;

  if(isDefined(var2) && var2 == "shoot") {
    setupwallrunaimlimits();
  }

  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  var5 = getnotetracktimes(var4, "wall_contact");
  var6 = var5[0];
  var7 = getangledelta(var4, 0, var6);
  var8 = self.wall_run_yaw - var7;
  var9 = (0, var8, 0);
  self forceteleport(self.origin, var9);
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var4);
  var10 = scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
}

function getwallattachoffsetposition(var0) {
  var1 = choosewallattachanim(var0, "wall_run_attach");
  var2 = getnotetracktimes(var1, "wall_contact");
  var3 = var2[0];
  var4 = getmovedelta(var1, 0, var3);
  var5 = getangledelta(var1, 0, var3);
  return scripts\asm\soldier\cover::calcanimstartpos(getwallnodeposition(self.traversal_start_node, 0), self.wall_run_yaw, var4, var5);
}

function playwallrunenter(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  var5 = self.traversal_start_node;
  self.wall_run_current_node_index = 0;
  var6 = getwallnodeposition(var5, 0);
  var7 = var6 - self.origin;
  var7 = (var7[0], var7[1], 0);
  var8 = vectortoangles(var7);
  var9 = getwallattachoffsetposition();
  self orientmode("face angle", var8[1]);
  var10 = 1;
  var11 = getnotetracktimes(var4, "code_move");

  if(isDefined(var11) && var11.size > 0) {
    var10 = var11[0];
  }

  playscaledjump(var0, var1, var3, var9, var8, var10, 0, 1);
  self forceteleport(var9, var8);
}

function playscaledjump(var0, var1, var2, var3, var4, var5, var6, var7) {
  self endon(var1 + "_finished");

  if(!isDefined(var5)) {
    var5 = 1;
  }

  if(!isDefined(var6)) {
    var6 = 0;
  }

  if(!isDefined(var7)) {
    var7 = 0;
  }

  self forceteleport(self.origin, var4);
  self animmode("noclip");
  self orientmode("face angle", var4[1]);
  var8 = scripts\asm\asm::asm_getxanim(var1, var2);
  var9 = getanimlength(var8);
  var10 = int(var9 * 1000);
  self iw7shiphack_setmaymovetime(gettime() + var10 - 1000);
  self.useanimgoalweight = 1;
  self aisetanim(var1, var2);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var8);
  var11 = [var1, var8, var3, gettime(), var5, var6, var7];
  scripts\asm\asm::asm_donotetracks(var0, var1, &wallrunnotehandler, var11);
}

function choosewallattachanim(var0, var1, var2) {
  if(isDefined(self.wall_run_attach_anim)) {
    return self.wall_run_attach_anim;
  }

  var3 = self.wall_run_direction;
  var4 = angleclamp180(self.wall_run_yaw - self.angles[1]);
  var4 = abs(var4);

  if(var4 >= 22.5) {
    if(var4 > 67.5) {
      var3 += "_90";
    } else {
      var3 += "_45";
    }
  }

  self.wall_run_attach_anim = scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
  return self.wall_run_attach_anim;
}

function choosewallrunenteranim(var0, var1, var2) {
  setupwallrunifneeded();
  var3 = self.wall_run_direction;
  var4 = self.traversal_start_node;
  var5 = getwallnodeposition(var4, 0);
  var6 = var5[2] - self.origin[2];
  var7 = 0;

  if(var6 >= 0) {
    if(var6 > 120) {
      var7 = 1;
    }
  } else if(0 - var6 > 240) {
    var7 = 1;
  }

  if(var7 == 0) {
    var8 = distancesquared(self.origin, var5);

    if(var8 > 40000) {
      var7 = 1;
    }
  }

  var9 = "left_";

  if(self.asm.footsteps.foot == "right") {
    var9 = "right_";
  }

  if(var7) {
    var3 = var9 + "double_jump";
  } else {
    var3 = var9 + "single_jump";
  }

  var10 = scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
  return var10;
}

function senddelayedevent(var0, var1, var2, var3, var4) {
  self endon(var1 + "_finished");
  wait var2;
  scripts\asm\asm::asm_fireevent(var0, var3);

  if(var4) {
    self notify(var3);
    return;
  }
}

function hasanotherwallrun(var0, var1, var2, var3) {
  if(!isDefined(self.wall_run_current_node_index)) {
    return false;
  }

  var4 = self.traversal_start_node;

  if(!isDefined(var4)) {
    return false;
  }

  var5 = self.wall_run_current_node_index + 2;

  if(var4.wall_info.nodeoffsets.size <= var5) {
    return false;
  }

  return true;
}

function playwallruncontinue(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = self.traversal_start_node;
  scripts\asm\shared\utility::set_aim_and_turn_limits();
  self.wall_run_current_node_index += 2;
  var4 = getwallnodeposition(var3, self.wall_run_current_node_index);
  var5 = self.angles;

  if(self.wall_run_direction == "left") {
    self.wall_run_direction = "right";
  } else {
    self.wall_run_direction = "left";
  }

  var6 = scripts\asm\asm::asm_getanim(var0, var1);
  playscaledjump(var0, var1, var6, var4, var5);
}

function getwallrunmantleposition(var0) {
  var1 = var0.angles - var0.wall_info.startnodeoriginalangles;

  if(var1 == (0, 0, 0)) {
    return (var0.origin + var0.wall_info.mantleoffset);
  }

  var2 = rotatevector(var0.wall_info.mantleoffset, var1);
  return var0.origin + var2;
}

function getwallrunmantleangles(var0) {
  if(!isDefined(var0.wall_info.mantleangles)) {
    return undefined;
  }

  var1 = var0.angles[1] - var0.wall_info.startnodeoriginalangles[1];

  if(var1 == 0) {
    return var0.wall_info.mantleangles;
  }

  return (0, angleclamp180(var0.wall_info.mantleangles[1] + var1), 0);
}

function getwallruntomantletype() {
  var0 = self.traversal_start_node;

  if(!isDefined(var0.wall_info.mantleoffset)) {
    return "none";
  }

  var1 = getwallrunmantleposition(var0);

  if(var1[2] >= self.origin[2]) {
    return "high";
  }

  return "low";
}

function shouldwallruntovault(var0, var1, var2, var3) {
  var4 = self.traversal_start_node;

  if(!isDefined(var4.wall_info.bvaultover)) {
    return 0;
  }

  return var4.wall_info.bvaultover;
}

function playwallrunloop(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = self.traversal_start_node;
  setupwallrunaimlimits();
  var4 = scripts\asm\asm::asm_getanim(var0, var1);
  var5 = scripts\asm\asm::asm_getxanim(var1, var4);
  var6 = getmovedelta(var5);
  var7 = length2d(var6);

  if(!isDefined(var3.wall_info.mantleoffset) && self.wall_run_current_node_index == var3.wall_info.nodeoffsets.size - 2) {
    var8 = scripts\asm\asm::asm_getanim(var0, "wall_run_exit");
    var9 = scripts\asm\asm::asm_getxanim("wall_run_exit", var8);
    var10 = getnotetracktimes(var9, "start_jump");
    var11 = getanimlength(var9);
    var12 = getmovedelta(var9, 0, var10[0]);
    var13 = length2d(var12);
  } else {
    var13 = 0;
  }

  var14 = getwallnodeposition(var4, self.wall_run_current_node_index + 1) - self.origin;
  var15 = length(var14);
  var15 -= var13;

  if(var15 < 0) {
    var15 = 0;
  }

  var16 = var15 / var13;
  var17 = getanimlength(var6);
  var18 = var17 * var16;
  thread senddelayedevent(var1, var2, var18, "wall_run_loop_done", 1);
  var19 = vectorNormalize(var14);
  self orientmode("face direction", var19);
  thread playwallrunendsound(var2);
  self animmode("noclip");
  self aisetanim(var2, var5);
  scripts\asm\asm::asm_playfacialanim(var1, var2, var6);
  scripts\asm\asm::asm_donotetracks(var1, var2);
}

function playwallrunendsound(var0) {
  self endon("death");

  if(soundexists("wallrun_end_npc")) {
    self waittill("wall_run_loop_done");
    self playSound("wallrun_end_npc");
    return;
  }
}

function choosewallrunexitanim(var0, var1, var2) {
  var3 = self.wall_run_direction;
  var4 = self.traversal_end_pos;
  var5 = var4[2] - self.origin[2];
  var6 = 0;

  if(var5 >= 0) {
    if(var5 > 120) {
      var6 = 1;
    }
  } else if(0 - var5 > 240) {
    var6 = 1;
  }

  if(var6 == 0) {
    var7 = distancesquared(self.origin, var4);

    if(var7 > 46225) {
      var6 = 1;
    }
  }

  if(var6) {
    var3 += "_double";
  }

  var4 = self.traversal_end_pos;
  var8 = self.traversal_start_node;
  var9 = self.traversal_end_pos - getwallnodeposition(var8, var8.wall_info.nodeoffsets.size - 1);
  var9 = (var9[0], var9[1], 0);
  var9 = vectorNormalize(var9);
  var10 = vectortoangles(var9);
  var11 = angleclamp180(var10[1] - self.angles[1]);
  var11 = abs(var11);

  if(var11 >= 22.5) {
    if(var11 > 67.5) {
      var3 += "_90";
    } else {
      var3 += "_45";
    }
  }

  var12 = scripts\asm\asm::asm_lookupanimfromalias(var1, var3);
  return var12;
}

function playwallrunexit(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = self.traversal_start_node;
  var4 = self.traversal_end_pos;
  var5 = self.angles;
  var6 = 1;
  var7 = scripts\asm\asm::asm_getanim(var0, var1);
  var8 = getnotetracktimes(var7, "ground");
  scripts\asm\shared\utility::set_aim_and_turn_limits();

  if(isDefined(var8) && var8.size > 0) {
    var6 = var8[0];
  } else {
    var9 = getnotetracktimes(var7, "end_double_jump");

    if(isDefined(var9) && var9.size > 0) {
      var6 = var9[0];
    } else {
      var10 = getnotetracktimes(var7, "end_jump");

      if(isDefined(var10) && var10.size > 0) {
        var6 = var10[0];
      }
    }
  }

  if(soundexists("wallrun_end_npc")) {
    self playSound("wallrun_end_npc");
  }

  playscaledjump(var0, var1, var7, var4, var5, var6, 1, 1);
  thread terminatewallruntraverse(var0, var1);
}

function isnotdoingwallruntransition(var0, var1, var2, var3) {
  if(isDefined(self.traversal_start_node)) {
    return false;
  }

  return true;
}

function terminatewallruntraverse(var0, var1) {
  self.wall_run_current_node_index = undefined;
  self.wall_run_direction = undefined;
  self.wall_run_double_jumping = undefined;
  self.wall_run_yaw = undefined;
  self.wall_run_attach_anim = undefined;
  self setdefaultaimlimits();
  terminatetraverse(var0, var1);
}

function playwallruntomantle(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = self.traversal_start_node;
  var4 = self.traversal_end_pos;
  var5 = getwallrunmantleposition(var3);
  jumpiffalse(isDefined(var3.wall_info.bvaultover) || getwallruntomantletype() == "high") LOC_0000006b;
  var6 = getwallrunmantleangles(var3);

  if(!isDefined(var6)) {
    var7 = var4 - var5;
    var7 = (var7[0], var7[1], 0);
    var6 = vectortoangles(var7);
  }

  goto LOC_00000088;
}

function playtraversaltransition(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);

  if(!isDefined(var3)) {
    scripts\asm\asm::asm_fireevent(var0, "code_move");
    return;
  }

  var4 = scripts\asm\asm::asm_getxanim(var1, var3);
  var5 = 1;
  var6 = undefined;

  if(getdvarint("ai_wall_run_use_align_notetrack", 1) == 1) {
    var6 = getnotetracktimes(var4, "align");
  }

  if(!isDefined(var6) || var6.size == 0) {
    var6 = getnotetracktimes(var4, "code_move");
  }

  if(isDefined(var6) && var6.size > 0) {
    var5 = var6[0];
  }

  var7 = getmovedelta(var4, 0, var5);
  var8 = getangledelta(var4, 0, var5);
  var9 = self.traversal_start_node;
  var10 = getanimlength(var4) * var5;
  var11 = int(ceil(var10 * 20));
  jumpiffalse(self.traversal_start_node.animscript == "wall_run") LOC_000000e5;
  var12 = getwallnodeposition(self.traversal_start_node, 0) - self.origin;
  var13 = vectortoangles(var12);
  var14 = var13[1];
  goto LOC_00000112;
}

function choosewallrunturn(var0, var1, var2) {
  return scripts\asm\soldier\move::choosesharpturnanim(var0, var1, var2);
}

function choosetraversaltransition(var0, var1, var2) {
  var3 = anglesToForward(self.angles);
  var4 = vectortoangles(var3);
  jumpiffalse(self.traversal_start_node.animscript == "wall_run") LOC_00000044;
  var5 = vectortoangles(getwallnodeposition(self.traversal_start_node, 0) - self.origin);
  goto LOC_0000006b;
}

function cleanupwallruntransitioncheck(var0, var1, var2, var3) {
  self.traversal_start_node = undefined;
  self.traversal_end_pos = undefined;
  self.wall_run_direction = undefined;
  return false;
}

function shouldabortwallrunattach(var0, var1, var2, var3) {
  var4 = distance2dsquared(self.origin, getwallnodeposition(self.traversal_start_node, 1));

  if(var4 < 144) {
    return true;
  }

  return false;
}

function shoulddowallrunsharpturn(var0, var1, var2, var3) {
  if(isnotdoingwallruntransition(var0, var1, var2, var3)) {
    scripts\asm\traverse::setuptraversaltransitioncheck(var0, var1, var2, var3);

    if(!isDefined(self.traversal_start_node)) {
      return false;
    }

    if(self.traversal_start_node.animscript != "wall_run") {
      return false;
    }

    var4 = self.traversal_start_node;
    var5 = vectorNormalize(getwallnodeposition(var4, 0) - self.origin);
    var6 = scripts\asm\soldier\move::calculatesharpturnanim(var0, var1, var2, var5, 0, 1);

    if(!isDefined(var6)) {
      return false;
    }

    self.a.sharpturnindex = var6;
    self.wall_run_direction = getwallrundirectionfromstartnode(self.traversal_start_node);
    return true;
  }

  return false;
}

function shouldtraversetransitionto(var0, var1, var2, var3) {
  if(var2 == self.traversal_start_node.animscript) {
    return true;
  }

  return false;
}

function istraversaltransitionsupported(var0) {
  switch (var0) {
    case "rail_hop_double_jump_down":
    case "double_jump":
    case "double_jump_mantle":
    case "double_jump_vault":
    case "wall_run":
      return true;
  }

  return false;
}

function shoulddotraversaltransition(var0, var1, var2, var3) {
  if(!isDefined(self.traversal_start_node)) {
    return false;
  }

  if(!istraversaltransitionsupported(self.traversal_start_node.animscript)) {
    return false;
  }

  if(!self.facemotion) {
    return false;
  }

  var4 = undefined;

  if(self.traversal_start_node.animscript == "wall_run") {
    var4 = getwallrundirectionfromstartnode(self.traversal_start_node);
    var5 = getwallnodeposition(self.traversal_start_node, 0) - self.origin;
    var6 = vectortoangles(var5);
  } else {
    var5 = self.traversal_end_pos - self.traversal_start_node.origin;
    var5 = (var5[0], var5[1], 0);
    var6 = vectorNormalize(var5);
    var6 = vectortoangles(var6);
  }

  var7 = var6[1];
  var8 = anglesToForward(self.angles);
  var9 = vectortoangles(var8);
  var10 = angleclamp180(var7 - var9[1]);
  var11 = getangleindex(var10, 22.5);
  var12 = scripts\asm\soldier\arrival::getstopanims(var2, var4, undefined, 1);
  var13 = var12[var11];

  if(!isDefined(var13)) {
    return false;
  }

  var14 = 1;
  var15 = undefined;

  if(getdvarint("ai_wall_run_use_align_notetrack", 1) == 1) {
    var15 = getnotetracktimes(var13, "align");
  }

  if(!isDefined(var15) || var15.size == 0) {
    var15 = getnotetracktimes(var13, "code_move");
  }

  if(isDefined(var15) && var15.size > 0) {
    var14 = var15[0];
  }

  var16 = getmovedelta(var13, 0, var14);
  var17 = getangledelta(var13, 0, var14);
  var18 = distance2d(self.origin, self.traversal_start_node.origin);
  var19 = length(var16);
  var20 = var18 - var19;

  if(var20 < 0) {
    var21 = anglesToForward(var6);
    var22 = vectordot(var8, var21);

    if(var22 > 0.707) {
      if(abs(var20) > 10) {
        return false;
      }
    } else if(abs(var20) > 64) {
      return false;
    }
  } else if(var20 > 10) {
    return false;
  }

  if(self.traversal_start_node.animscript == "wall_run") {
    self.wall_run_direction = var6;
  }

  return true;
}

function handlewallrunattachnotetrack(var0) {
  if(var0 == "wall_contact") {
    if(soundexists("wallrun_start_npc")) {
      self playSound("wallrun_start_npc");
      return;
    }

    return;
  }
}

function setupwallrunaimlimits() {
  self.upaimlimit = -45;
  self.downaimlimit = 45;
  self.rightaimlimit = -90;
  self.leftaimlimit = 90;
}

function playtraverseanim_ladder(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = self getnegotiationstartnode();
  var4 = self getnegotiationendpos();
  self animmode("noclip", 0);
  self orientmode("face angle", var3.angles[1]);
  var5 = var4 - var3.origin;
  var6 = scripts\asm\asm::asm_getdemeanor();
  var7 = undefined;
  var8 = undefined;
  var9 = undefined;

  if(var5[2] > 0) {
    var10 = "off_" + var6;
    var9 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var1, var10);

    if(!isDefined(var9)) {
      var9 = scripts\asm\asm::asm_lookupanimfromalias(var1, "off");
    }

    var7 = scripts\asm\asm::asm_lookupanimfromalias(var1, "up");
  } else {
    var11 = "on_" + var6;
    var9 = scripts\asm\asm::asm_lookupanimfromaliasifexists(var1, var11);

    if(!isDefined(var9)) {
      var8 = scripts\asm\asm::asm_lookupanimfromalias(var1, "on");
    }

    var7 = scripts\asm\asm::asm_lookupanimfromalias(var1, "down");
  }

  var12 = 1;

  if(isDefined(self.moveplaybackrate)) {
    var12 = self.moveplaybackrate;
  }

  if(isDefined(var8)) {
    self aisetanim(var1, var8, var12);
    scripts\asm\asm::asm_donotetracks(var0, var1);
  }

  var13 = var4;

  if(isDefined(var9)) {
    var14 = scripts\asm\asm::asm_getxanim(var1, var9);
    var15 = getmovedelta(var14);
    var13 = var4 - var15 + (0, 0, 1);
  }

  var16 = var13 - self.origin;

  if(var16[2] * var5[2] > 0) {
    var17 = scripts\asm\asm::asm_getxanim(var1, var7);
    var18 = getmovedelta(var17);
    var19 = var18[2] * var12 / getanimlength(var17);
    var20 = var16[2] / var19;
    self aisetanim(var1, var7, var12);
    scripts\asm\asm::asm_donotetracksfortime(var0, var1, var20);
  }

  if(isDefined(var9)) {
    self aisetanim(var1, var9, var12);
    scripts\asm\asm::asm_donotetracks(var0, var1);
  }

  terminatetraverse(var0, var1);
}

function terminate_ladder(var0, var1, var2) {
  self.nogravityragdoll = !isalive(self);
}

function traverse_basic(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  self animmode("noclip", 0);
  var4 = self getnegotiationstartnode();
  self orientmode("face angle", var4.angles[1]);
  self aisetanim(var1, var3);
  scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1));
  terminatetraverse(var0, var1);
}

function terminatetraverse(var0, var1) {
  self.useanimgoalweight = 0;
  self.istraversing = 0;
  self.jump_over_position = undefined;
  self.traversal_start_node = undefined;
  self.traversal_end_pos = undefined;
  scripts\asm\asm::asm_fireevent(var0, "traverse_end");
  self finishtraverse();
  self motionwarpcancel();
}