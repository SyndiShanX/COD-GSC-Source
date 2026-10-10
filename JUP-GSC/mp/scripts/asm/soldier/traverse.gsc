/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\asm\soldier\traverse.gsc
***********************************************/

#using scripts\anim\animselector;
#using scripts\anim\utility;
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\arrival;
#using scripts\asm\soldier\cover;
#using scripts\asm\soldier\move;
#using scripts\asm\traverse;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace traverse;

function playtraverseanim_deprecated(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  checktraverse(statename);
  traverseanim = asm_getanim(asmname, statename);
  traversexanim = asm_getxanim(statename, traverseanim);
  self.desired_anim_pose = "crouch";
  scripts\anim\utility::updateanimpose();
  self endon("killanimscript");
  self animmode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self orientmode("face angle", startnode.angles[1]);
  startnode.traverse_height = startnode.origin[2] + startnode.traverse_height_delta;
  realheight = startnode.traverse_height - startnode.origin[2];
  thread teleportthread(realheight - params);
  blendtime = 0.15;
  self aisetanim(statename, traverseanim);
  var_22943623b8e97c62 = 0.2;
  endblendtime = 0.2;
  thread traverse_donotetracks(asmname, statename);

  if(!animhasnotetrack(traversexanim, "gravity on")) {
    var_cc694b7fbbf6503c = 1.23;
    wait var_cc694b7fbbf6503c - var_22943623b8e97c62;
    self animmode("gravity");
    wait var_22943623b8e97c62;
  } else {
    self waittillmatch("traverse", "gravity on");
    self animmode("gravity");

    if(!animhasnotetrack(traversexanim, "blend")) {
      wait var_22943623b8e97c62;
    } else {
      self waittillmatch("traverse", "blend");
    }
  }

  terminatetraverse(asmname, statename);
}

function playtraverseanim(asmname, statename, params) {
  traverseanim = asm_getanim(asmname, statename);
  checktraverse(statename);
  self animmode("noclip");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self orientmode("face angle", startnode.angles[1]);
  self aisetanim(statename, traverseanim);
  asm_donotetracks(asmname, statename);
  terminatetraverse(asmname, statename);
}

function playtraverseanim_doublejump(asmname, statename, params) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(statename + "_finished");
  var_3016b22139446579 = getdvarint(@ "hash_db3bdaface7c82ec", 0);

  if(var_3016b22139446579 != 3 && var_3016b22139446579 != 4) {
    checktraverse(statename);
  }

  self.ragdoll_immediate = 1;
  start_node = self getnegotiationstartnode();
  var_e14ac44f6f147496 = self getnegotiationendpos();
  start_node.traverse_height = start_node.origin[2] + start_node.traverse_height_delta - 44;
  var_559df5f9875a294e = [];

  if(start_node.traverse_height > var_e14ac44f6f147496[2]) {
    halfway_x = (start_node.origin[0] + var_e14ac44f6f147496[0]) * 0.5;
    halfway_y = (start_node.origin[1] + var_e14ac44f6f147496[1]) * 0.5;
    var_559df5f9875a294e[var_559df5f9875a294e.size] = (halfway_x, halfway_y, start_node.traverse_height);

    if(var_3016b22139446579 != 0) {
      jump_over_position = var_559df5f9875a294e[0];
      function_52e0db833127ec95(self.origin, jump_over_position, (128, 0, 255), 100);
      function_52e0db833127ec95(self.origin, var_e14ac44f6f147496, (128, 0, 255), 100);
    }
  }

  var_559df5f9875a294e[var_559df5f9875a294e.size] = var_e14ac44f6f147496;
  var_4c5664c0523213f2 = spawn("script_model", start_node.origin);
  var_4c5664c0523213f2 setModel("tag_origin");
  var_4c5664c0523213f2.angles = start_node.angles;
  thread delete_on_death(var_4c5664c0523213f2);
  self orientmode("face angle", start_node.angles[1]);
  max_time = 1.63;

  if(var_3016b22139446579 == 3) {
    max_time = 0.9;
  }

  self linkTo(var_4c5664c0523213f2);
  jumpanim = asm_getanim(asmname, statename);
  asm_playfacialanim(asmname, statename, asm_getxanim(jumpanim));
  self aisetanim(statename, jumpanim);
  thread traverse_donotetracks(asmname, statename);

  foreach(org in var_559df5f9875a294e) {
    move_time = max_time / var_559df5f9875a294e.size;
    var_4c5664c0523213f2 moveTo(org, move_time);
    var_4c5664c0523213f2 waittill("movedone");
  }

  self notify("double_jumped");
  self unlink();
  self.ragdoll_immediate = undefined;
  var_4c5664c0523213f2 delete();
  thread terminatetraverse(asmname, statename);
}

function traverse_doublejump_cleanup(asmname, statename, params) {
  self unlink();
  self.ragdoll_immediate = undefined;
}

function traverse_donotetracks(asmname, statename) {
  self endon("death");
  self endon("terminate_ai_threads");
  self endon(statename + "_finished");
  self endon("double_jumped");
  asm_donotetracks(asmname, statename);
}

function getexternaltraverseinfo(traversename) {
  assertex(isDefined(level.scr_traverse), "<dev string:x1c>");
  assertex(isDefined(level.scr_traverse[traversename]), "<dev string:x61>" + traversename + "<dev string:x79>");

  if(isDefined(level.scr_traverse) && isDefined(level.scr_traverse[traversename])) {
    return level.scr_traverse[traversename];
  }

  return undefined;
}

function playtraverseanim_external(asmname, statename, params) {
  assertex(utility::issp(), "<dev string:x92>" + asmname + "<dev string:xb6>" + statename + "<dev string:xc4>");
  playtraverseanim_scaled(asmname, statename);
}

function choosetraverseanim_external(asmname, statename, params) {
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  traversename = startnode.animscript;

  if(isDefined(level.var_2a12779877c8c257) && isDefined(level.var_2a12779877c8c257[traversename])) {
    xanim = [[level.var_2a12779877c8c257[traversename]]](asmname, statename, params);
    assert(isanimation(xanim));
    return xanim;
  }

  animinfo = getexternaltraverseinfo(traversename);
  assert(isanimation(animinfo));
  return animinfo;
}

function playdoublejumpfinishanim(asmname, statename, params) {
  self endon(statename + "_finished");
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  self.useanimgoalweight = 1;
  animid = asm_getanim(asmname, statename);
  self aisetanim(statename, animid);
  xanim = asm_getxanim(statename, animid);
  asm_playfacialanim(asmname, statename, xanim);
  asm_donotetracks(asmname, statename);
  thread terminatetraverse(asmname, statename);
}

function getdoublejumpoffsetposition(asmname, var_223efa34c2b82dc8, endpos, endangles, notetrackname) {
  animid = asm_chooseanim(asmname, var_223efa34c2b82dc8);
  assert(isDefined(animid));
  xanim = asm_getxanim(var_223efa34c2b82dc8, animid);
  aligntime = getnotetracktimes(xanim, notetrackname);
  assert(isDefined(aligntime) && aligntime.size > 0);
  time = aligntime[0];
  animdelta = getmovedelta(xanim, 0, time);
  var_f73bea4534a3831f = getangledelta(xanim, 0, time);
  return scripts\asm\soldier\cover::calcanimstartpos(endpos, endangles[1], animdelta, var_f73bea4534a3831f);
}

function doublejumpneedsfinishanim(asmname, nextstatename, startnode, endpos) {
  assert(isDefined(startnode));
  assert(isDefined(endpos));

  if(getdvarint(@ "hash_db3bdaface7c82ec", 0) == 3) {
    return false;
  }

  deltaz = endpos[2] - startnode.origin[2];

  if(deltaz < 0) {
    return false;
  }

  if(isDefined(startnode.jump_over_offset) && getdvarint(@ "hash_db3bdaface7c82ec", 0) != 2) {
    jump_over_offset = startnode.jump_over_offset;
    angleoffset = startnode.angles - startnode.startnodeoriginalangles;

    if(angleoffset != (0, 0, 0)) {
      jump_over_offset = rotatevector(jump_over_offset, angleoffset);
    }

    jump_over_position = startnode.origin + jump_over_offset;
    var_e5e2b98a87142185 = jump_over_position[2];
    var_e5e2b98a87142185 -= 44;

    if(endpos[2] < var_e5e2b98a87142185) {
      return false;
    }
  }

  delta = endpos - startnode.origin;
  delta = (delta[0], delta[1], 0);
  desiredangles = vectortoangles(delta);
  offsetpos = getdoublejumpoffsetposition(asmname, nextstatename, endpos, desiredangles, "footstep_left_small");
  newdelta = offsetpos - startnode.origin;

  if(vectordot(newdelta, delta) < 0) {
    return false;
  }

  return true;
}

function checkdoublejumpfinish(asmname, statename, tostatename, params) {
  startnode = gettraversalstartnode();

  if(!isDefined(startnode)) {
    thread terminatetraverse(asmname, "double_jump");
    return false;
  }

  endpos = self getnegotiationendpos();
  assert(isDefined(endpos));

  if(!doublejumpneedsfinishanim(asmname, tostatename, startnode, endpos)) {
    thread terminatetraverse(asmname, "double_jump");
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

function playdoublejumpmantleorvault(asmname, statename, zoffset) {
  self endon(statename + "_finished");
  startnode = gettraversalstartnode();
  assert(isDefined(startnode.doublejumpmantlepos));
  assert(isDefined(startnode));
  endpos = startnode.doublejumpmantlepos;

  delta = endpos - startnode.origin;
  delta = (delta[0], delta[1], 0);
  desiredangles = vectortoangles(delta);
  jumpanim = asm_getanim(asmname, statename);
  assert(isDefined(jumpanim));
  nextstatename = statename + "_finish";
  mantlestartpos = getdoublejumpoffsetposition(asmname, nextstatename, endpos, desiredangles, "mantle_align");
  mantlestartpos = (mantlestartpos[0], mantlestartpos[1], mantlestartpos[2] + zoffset);
  playscaledjump(asmname, statename, jumpanim, mantlestartpos, desiredangles, 1, 0, 1);
}

function playdoublejumpmantle(asmname, statename, params) {
  playdoublejumpmantleorvault(asmname, statename, -8);
}

function playdoublejumpvault(asmname, statename, params) {
  playdoublejumpmantleorvault(asmname, statename, -42);
}

function doublejumpterminate(asmname, statename, params) {
  self.useanimgoalweight = 0;
  self.jump_over_position = undefined;
  self.traversal_start_node = undefined;
}

function doublejumpearlyterminate(asmname, statename, params) {
  if(!asm_eventfired(asmname, "end")) {
    doublejumpterminate(asmname, statename, params);
  }
}

function isdoublejumpanimdone(asmname, statename, tostatename, params) {
  if(getdvarint(@ "hash_db3bdaface7c82ec", 0) == 3) {
    return 0;
  }

  return asm_eventfired(asmname, "end");
}

function playdoublejumptraversal(asmname, statename, params) {
  self endon(statename + "_finished");

  if(getdvarint(@ "hash_db3bdaface7c82ec", 0) == 4) {
    playtraverseanim_doublejump(asmname, "<dev string:xf3>", params);
    return;
  }

  if(getdvarint(@ "hash_db3bdaface7c82ec", 0) == 3) {
    playtraverseanim_doublejump(asmname, statename, params);
    return;
  }

  startnode = gettraversalstartnode();
  endpos = self getnegotiationendpos();
  assert(isDefined(startnode));
  assert(isDefined(endpos));

  if(!isDefined(startnode.startnodeoriginalangles)) {
    startnode.startnodeoriginalangles = startnode.angles;
  }

  angleoffset = startnode.angles - startnode.startnodeoriginalangles;

  if(angleoffset != (0, 0, 0)) {
    endpos = rotatevector(endpos, angleoffset);
  }

  jump_over_position = undefined;
  var_3016b22139446579 = getdvarint(@ "hash_db3bdaface7c82ec", 0);

  if(var_3016b22139446579 != 2) {
    if(isDefined(startnode.jump_over_offset)) {
      jump_over_offset = startnode.jump_over_offset;

      if(angleoffset != (0, 0, 0)) {
        jump_over_offset = rotatevector(jump_over_offset, angleoffset);
      }

      jump_over_position = startnode.origin + jump_over_offset;
      var_e5e2b98a87142185 = jump_over_position[2];
      var_e5e2b98a87142185 -= 44;

      if(var_e5e2b98a87142185 > endpos[2]) {
        halfway_x = (startnode.origin[0] + endpos[0]) * 0.5;
        halfway_y = (startnode.origin[1] + endpos[1]) * 0.5;
        jump_over_position = (halfway_x, halfway_y, jump_over_position[2]);
      } else {
        jump_over_position = undefined;
      }
    }
  }

  jumpanim = asm_getanim(asmname, statename);
  assert(isDefined(jumpanim));
  self.jump_over_position = jump_over_position;

  if(getdvarint(@ "hash_db3bdaface7c82ec", 0) != 0) {
    if(isDefined(jump_over_position)) {
      function_52e0db833127ec95(self.origin, jump_over_position, (128, 0, 255), 100);
      function_52e0db833127ec95(self.origin, endpos, (128, 0, 255), 100);
    } else {
      function_52e0db833127ec95(self.origin, endpos, (128, 255, 0), 100);
    }
  }

  nextstatename = statename + "_finish";

  if(doublejumpneedsfinishanim(asmname, nextstatename, startnode, endpos)) {
    delta = endpos - startnode.origin;
    delta = (delta[0], delta[1], 0);
    desiredangles = vectortoangles(delta);
    nextstatename = statename + "_finish";
    offsetpos = getdoublejumpoffsetposition(asmname, nextstatename, endpos, desiredangles, "footstep_left_small");
    endpos = offsetpos;
  }

  delta = endpos - startnode.origin;
  var_4c4c6c6d3c2b086b = 0;
  animendtime = 1;

  if(delta[2] < 0) {
    var_4c4c6c6d3c2b086b = 1;
    var_c4d9c443202bf996 = getnotetracktimes(asm_getxanim(statename, jumpanim), "gravity on");

    if(isDefined(var_c4d9c443202bf996) && var_c4d9c443202bf996.size > 0) {
      animendtime = var_c4d9c443202bf996[0];
    }
  }

  delta = (delta[0], delta[1], 0);
  desiredangles = vectortoangles(delta);
  playscaledjump(asmname, statename, jumpanim, endpos, desiredangles, animendtime, var_4c4c6c6d3c2b086b, 1);
}

function choosedoublejumpanim(asmname, statename, params) {
  endpos = self getnegotiationendpos();
  assert(isDefined(endpos));
  alias = "double_jump_up";

  if(isDefined(params)) {
    assert(params == "<dev string:x107>" || params == "<dev string:x10d>");
    alias = "double_jump_" + params;
  } else if(endpos[2] < self.origin[2]) {
    alias = "double_jump_down";
  }

  if(self.asm.footsteps.foot == "right") {
    prefix = "right_";
  } else {
    prefix = "left_";
  }

  alias = prefix + alias;
  animname = asm_lookupanimfromalias(statename, alias);
  return animname;
}

function getwallnodeposition(startnode, index) {
  assert(index >= 0);
  assert(isDefined(startnode));
  assert(isDefined(startnode.wall_info));
  assert(isDefined(startnode.wall_info.nodeoffsets));
  assert(startnode.wall_info.nodeoffsets.size > index);
  angleoffset = startnode.angles - startnode.wall_info.startnodeoriginalangles;

  if(angleoffset != (0, 0, 0)) {
    worlddelta = rotatevector(startnode.wall_info.nodeoffsets[index], angleoffset);
    nodeposition = startnode.origin + worlddelta;
  } else {
    nodeposition = startnode.origin + startnode.wall_info.nodeoffsets[index];
  }

  return nodeposition;
}

function shouldwallrunshoot(asmname, statename, tostatename, params) {
  if(!isDefined(self.enemy)) {
    return false;
  }

  enemypos = self.enemy.origin;
  startnode = self.traversal_start_node;
  assert(isDefined(startnode));
  assert(isDefined(startnode.wall_info));
  assert(isDefined(self.wall_run_current_node_index));
  assert(startnode.wall_info.nodeoffsets.size > self.wall_run_current_node_index + 1);
  wallstartpos = getwallnodeposition(startnode, self.wall_run_current_node_index);
  wallendpos = getwallnodeposition(startnode, self.wall_run_current_node_index + 1);
  wallendpos = (wallendpos[0], wallendpos[1], wallstartpos[2]);
  enemypos = (enemypos[0], enemypos[1], wallstartpos[2]);
  walldir = vectorNormalize(wallendpos - wallstartpos);
  enemydir = vectorNormalize(enemypos - wallstartpos);
  dot = vectordot(walldir, enemydir);

  if(dot < 0.2588) {
    return false;
  }

  return true;
}

function choosewallrunanim(asmname, statename, params) {
  assert(isDefined(self.wall_run_direction));
  jumpanim = asm_lookupanimfromalias(statename, self.wall_run_direction);
  return jumpanim;
}

function getsmoothstep(delta) {
  if(getdvarint(@ "hash_dd616d5851bec943", 1) == 2) {
    return (delta * delta * delta * (delta * (delta * 6 - 15) + 10));
  }

  return delta * delta * (3 - 2 * delta);
}

function teleportdeltaovernumframes(statename, waittime, delta, numframes, animname, playbackrate) {
  self endon(statename + "_finished");

  if(waittime > 0) {
    wait waittime;
  }

  framedelta = delta / numframes;
  startpos = self.origin[2];
  endpos = startpos + delta[2];
  lastz = self.origin[2];
  self setanimrate(animname, playbackrate);

  for(i = 0; i < numframes; i++) {
    var_3897e5e4048f4e94 = 1;

    if(getdvarint(@ "hash_dd616d5851bec943", 1) == 0) {
      var_3897e5e4048f4e94 = 0;
    }

    if(var_3897e5e4048f4e94) {
      pct = i / (numframes - 1);
      smoothstep = getsmoothstep(pct);
      newz = endpos * smoothstep + startpos * (1 - smoothstep);
      var_bc77fc372e8358f9 = newz - lastz;
      framedelta = (framedelta[0], framedelta[1], var_bc77fc372e8358f9);
      lastz = newz;
    }

    neworigin = self.origin + framedelta;
    self forceteleport(neworigin);

    if(i + 1 < numframes) {
      waitframe();
    }
  }

  self setanimrate(animname, 1);
}

function debugdest(dest, statename) {
  self notify("<dev string:x115>");
  self endon("<dev string:x115>");
  self endon(statename + "<dev string:x127>");

  while(true) {
    line(self.origin, dest, (0, 255, 0));
    waitframe();
  }
}

function wallrunnotehandler(note, params) {
  if(note == "start_jump") {
    thread handlejumpteleports(params);
    return;
  }

  if(note == "end_mantle") {
    self animmode("gravity");
  }
}

function handlejumpteleports(params, animtime, playbackrate) {
  assert(isarray(params));
  assert(params.size == 7);
  statename = params[0];
  animname = params[1];
  desiredendpos = params[2];
  starttime = params[3];
  var_8c2c7ea3bd382df4 = params[4];
  var_4c4c6c6d3c2b086b = params[5];
  var_87ef9fdeb401c595 = params[6];
  self endon(statename + "_finished");
  animlength = getanimlength(animname);

  if(!isDefined(animtime)) {
    animtime = (gettime() - starttime) * 0.001;
  }

  animtimepct = animtime / animlength;
  var_cab4a622d5af2e97 = getnotetracktimes(animname, "end_jump");
  var_930caef7352c0f86 = getnotetracktimes(animname, "end_double_jump");

  if(var_930caef7352c0f86.size > 0) {
    self.wall_run_double_jumping = 1;
    var_cab4a622d5af2e97 = var_930caef7352c0f86;
  } else {
    self.wall_run_double_jumping = 0;
  }

  assert(var_cab4a622d5af2e97.size > 0);

  if(isDefined(self.jump_over_position)) {
    var_8c2c7ea3bd382df4 = (var_cab4a622d5af2e97[0] - animtimepct) / 2 + animtimepct;
    var_cab4a622d5af2e97[0] = var_8c2c7ea3bd382df4;
    desiredendpos = self.jump_over_position;
  }

  movedelta = getmovedelta(animname, animtimepct, var_8c2c7ea3bd382df4);
  animendpos = self localtoworldcoords(movedelta);

  if(getdvarint(@ "hash_df899f2d04257001", 0) != 0 && isDefined(self.traversal_start_node)) {
    var_44a93f09b80b3ae = distance(self.origin, animendpos);
    var_3d5c613a9500564 = distance(self.origin, desiredendpos);
    var_e37286be71cbc5cd = var_3d5c613a9500564 / var_44a93f09b80b3ae;

    if(var_e37286be71cbc5cd < 0.8 || var_e37286be71cbc5cd > 1.2) {
      println("<dev string:x134>" + self.traversal_start_node.origin + "<dev string:x160>" + animname + "<dev string:x178>" + var_e37286be71cbc5cd);
      println("<dev string:x180>" + var_44a93f09b80b3ae + "<dev string:x191>" + var_3d5c613a9500564);
    }
  }

  if(!isDefined(playbackrate)) {
    playbackrate = 1;
  }

  if(var_87ef9fdeb401c595) {
    var_44a93f09b80b3ae = distance(self.origin, animendpos);
    var_3d5c613a9500564 = distance(self.origin, desiredendpos);
    playbackrate = var_44a93f09b80b3ae / var_3d5c613a9500564;

    if(playbackrate < 0.7) {
      playbackrate = 0.7;
    } else if(playbackrate > 1.3) {
      playbackrate = 1.3;
    }
  }

  scaledelta = desiredendpos - animendpos;
  var_e7f1395489e50fc7 = var_cab4a622d5af2e97[0] * animlength;
  jumpduration = var_e7f1395489e50fc7 - animtimepct * animlength;
  jumpduration *= 1 / playbackrate;
  numframes = jumpduration * 20;
  numframes = ceil(numframes);
  teleportstarttime = gettime();
  teleportdeltaovernumframes(statename, 0, scaledelta, numframes, animname, playbackrate);

  if(isDefined(self.jump_over_position)) {
    animtimedelta = (gettime() - teleportstarttime) * playbackrate;
    realanimtime = animtime + animtimedelta * 0.001;
    self.jump_over_position = undefined;
    params[6] = 0;
    handlejumpteleports(params, realanimtime, playbackrate);
  }
}

function getwallrunyawfromstartnode(startnode) {
  assert(isDefined(startnode.wall_info));
  assert(startnode.wall_info.nodeoffsets.size >= 2);
  delta = getwallnodeposition(startnode, 1) - getwallnodeposition(startnode, 0);
  desiredangles = vectortoangles(delta);
  return desiredangles[1];
}

function getwallrundirectionfromstartnode(startnode) {
  assert(isDefined(startnode));
  assert(isDefined(startnode.wall_info));
  assert(startnode.wall_info.nodeoffsets.size >= 2);
  self.wall_run_current_node_index = 0;
  delta = getwallnodeposition(startnode, 1) - getwallnodeposition(startnode, 0);
  desiredangles = vectortoangles(delta);
  self.wall_run_yaw = desiredangles[1];
  startposition = getwallnodeposition(startnode, self.wall_run_current_node_index);
  right = anglestoright(desiredangles);
  dir = startposition - startnode.origin;
  dot = vectordot(right, dir);

  if(dot > 0) {
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
  }

  assert(isDefined(self.traversal_start_node));
  startnode = self.traversal_start_node;
  self.wall_run_direction = getwallrundirectionfromstartnode(startnode);
}

function getwallrundirection() {
  setupwallrunifneeded();
  return self.wall_run_direction;
}

function wallrunterminate(asmname, statename, params) {
  self.wall_run_current_node_index = undefined;
  self.wall_run_direction = undefined;
  self.wall_run_double_jumping = undefined;
  self.wall_run_yaw = undefined;
  self.wall_run_attach_anim = undefined;
  self setdefaultaimlimits();
  self.useanimgoalweight = 0;
  self.jump_over_position = undefined;
  self.traversal_start_node = undefined;
}

function traversalorientearlyterminate(asmname, statename, params) {
  if(!asm_eventfired(asmname, "end") && !asm_eventfired(asmname, "code_move")) {
    self.traversal_start_node = undefined;
    self.wall_run_direction = undefined;
  }
}

function playwallrunattach(asmname, statename, params) {
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  self.useanimgoalweight = 1;

  if(isDefined(params) && params == "shoot") {
    setupwallrunaimlimits();
  }

  animid = asm_getanim(asmname, statename);
  xanim = asm_getxanim(statename, animid);
  var_bf02a06228e2e48e = getnotetracktimes(xanim, "wall_contact");
  assert(isDefined(var_bf02a06228e2e48e) && var_bf02a06228e2e48e.size > 0);
  time = var_bf02a06228e2e48e[0];
  angledelta = getangledelta(xanim, 0, time);
  faceyaw = self.wall_run_yaw - angledelta;
  forceangles = (0, faceyaw, 0);
  self forceteleport(self.origin, forceangles);
  self aisetanim(statename, animid);
  asm_playfacialanim(asmname, statename, xanim);
  endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
}

function getwallattachoffsetposition(asmname) {
  animname = choosewallattachanim(asmname, "wall_run_attach");
  assert(isDefined(animname));
  var_bf02a06228e2e48e = getnotetracktimes(animname, "wall_contact");
  assert(isDefined(var_bf02a06228e2e48e) && var_bf02a06228e2e48e.size > 0);
  time = var_bf02a06228e2e48e[0];
  animdelta = getmovedelta(animname, 0, time);
  var_f73bea4534a3831f = getangledelta(animname, 0, time);
  return scripts\asm\soldier\cover::calcanimstartpos(getwallnodeposition(self.traversal_start_node, 0), self.wall_run_yaw, animdelta, var_f73bea4534a3831f);
}

function playwallrunenter(asmname, statename, params) {
  self endon(statename + "_finished");
  animid = asm_getanim(asmname, statename);
  xanim = asm_getxanim(statename, animid);
  startnode = self.traversal_start_node;
  assert(isDefined(startnode));
  assert(isDefined(startnode.wall_info));
  assert(startnode.wall_info.nodeoffsets.size >= 2);
  self.wall_run_current_node_index = 0;
  var_86fca619ba5c4a5 = getwallnodeposition(startnode, 0);
  delta = var_86fca619ba5c4a5 - self.origin;
  delta = (delta[0], delta[1], 0);
  desiredangles = vectortoangles(delta);
  jumpdestination = getwallattachoffsetposition();
  self orientmode("face angle", desiredangles[1]);
  assert(isDefined(self.wall_run_direction));

  if(getdvarint(@ "hash_df899f2d04257001", 0) != 0) {
    function_52e0db833127ec95(self.origin, jumpdestination, (128, 0, 255), 100);
  }

  animendtime = 1;
  codemovetime = getnotetracktimes(xanim, "code_move");

  if(isDefined(codemovetime) && codemovetime.size > 0) {
    animendtime = codemovetime[0];
  }

  playscaledjump(asmname, statename, animid, jumpdestination, desiredangles, animendtime, 0, 1);
  self forceteleport(jumpdestination, desiredangles);
}

function playscaledjump(asmname, statename, animid, desiredposition, desiredangles, var_8c2c7ea3bd382df4, var_4c4c6c6d3c2b086b, var_87ef9fdeb401c595) {
  self endon(statename + "_finished");

  if(!isDefined(var_8c2c7ea3bd382df4)) {
    var_8c2c7ea3bd382df4 = 1;
  }

  if(!isDefined(var_4c4c6c6d3c2b086b)) {
    var_4c4c6c6d3c2b086b = 0;
  }

  if(!isDefined(var_87ef9fdeb401c595)) {
    var_87ef9fdeb401c595 = 0;
  }

  self forceteleport(self.origin, desiredangles);
  self animmode("noclip");
  self orientmode("face angle", desiredangles[1]);
  xanim = asm_getxanim(statename, animid);
  self.useanimgoalweight = 1;
  self aisetanim(statename, animid);
  asm_playfacialanim(asmname, statename, xanim);
  notetrackparams = [statename, xanim, desiredposition, gettime(), var_8c2c7ea3bd382df4, var_4c4c6c6d3c2b086b, var_87ef9fdeb401c595];
  asm_donotetracks(asmname, statename, &wallrunnotehandler, notetrackparams);
}

function choosewallattachanim(asmname, statename, params) {
  if(isDefined(self.wall_run_attach_anim)) {
    return self.wall_run_attach_anim;
  }

  aliasname = self.wall_run_direction;
  yawdelta = angleclamp180(self.wall_run_yaw - self.angles[1]);
  yawdelta = abs(yawdelta);

  if(yawdelta >= 22.5) {
    if(yawdelta > 67.5) {
      aliasname += "_90";
    } else {
      aliasname += "_45";
    }
  }

  self.wall_run_attach_anim = asm_lookupanimfromalias(statename, aliasname);
  return self.wall_run_attach_anim;
}

function choosewallrunenteranim(asmname, statename, params) {
  setupwallrunifneeded();
  assert(isDefined(self.wall_run_direction));
  assert(isDefined(self.traversal_start_node));
  alias = self.wall_run_direction;
  startnode = self.traversal_start_node;
  assert(isDefined(startnode));
  assert(isDefined(startnode.wall_info));
  assert(startnode.wall_info.nodeoffsets.size >= 2);
  var_15e16054caefc232 = getwallnodeposition(startnode, 0);
  zdelta = var_15e16054caefc232[2] - self.origin[2];
  bdoublejump = 0;

  if(zdelta >= 0) {
    if(zdelta > 120) {
      bdoublejump = 1;
    }
  } else if(0 - zdelta > 240) {
    bdoublejump = 1;
  }

  if(bdoublejump == 0) {
    distsq = distancesquared(self.origin, var_15e16054caefc232);

    if(distsq > 40000) {
      bdoublejump = 1;
    }
  }

  prefix = "left_";

  if(self.asm.footsteps.foot == "right") {
    prefix = "right_";
  }

  if(bdoublejump) {
    alias = prefix + "double_jump";
  } else {
    alias = prefix + "single_jump";
  }

  jumpanim = asm_lookupanimfromalias(statename, alias);
  return jumpanim;
}

function senddelayedevent(asmname, statename, time, event, var_775aaa9fdd143162) {
  self endon(statename + "_finished");
  wait time;
  asm_fireevent(asmname, event);

  if(var_775aaa9fdd143162) {
    self notify(event);
  }
}

function hasanotherwallrun(asmname, statename, tostatename, params) {
  if(!isDefined(self.wall_run_current_node_index)) {
    return false;
  }

  startnode = self.traversal_start_node;

  if(!isDefined(startnode)) {
    return false;
  }

  assert(isDefined(startnode.wall_info));
  var_a3e2cf82e6f677a4 = self.wall_run_current_node_index + 2;

  if(startnode.wall_info.nodeoffsets.size <= var_a3e2cf82e6f677a4) {
    return false;
  }

  assert(startnode.wall_info.nodeoffsets.size > var_a3e2cf82e6f677a4 + 1);
  return true;
}

function playwallruncontinue(asmname, statename, params) {
  self endon(statename + "_finished");
  startnode = self.traversal_start_node;
  self function_62004d7561fd321e();
  assert(isDefined(startnode));
  self.wall_run_current_node_index += 2;
  assert(startnode.wall_info.nodeoffsets.size > self.wall_run_current_node_index + 1);
  endpos = getwallnodeposition(startnode, self.wall_run_current_node_index);
  desiredangles = self.angles;

  if(self.wall_run_direction == "left") {
    self.wall_run_direction = "right";
  } else {
    self.wall_run_direction = "left";
  }

  animid = asm_getanim(asmname, statename);
  playscaledjump(asmname, statename, animid, endpos, desiredangles);
}

function getwallrunmantleposition(startnode) {
  assert(isDefined(startnode));
  assert(isDefined(startnode.wall_info));
  assert(isDefined(startnode.wall_info.mantleoffset));
  angleoffset = startnode.angles - startnode.wall_info.startnodeoriginalangles;

  if(angleoffset == (0, 0, 0)) {
    return (startnode.origin + startnode.wall_info.mantleoffset);
  }

  worlddelta = rotatevector(startnode.wall_info.mantleoffset, angleoffset);
  return startnode.origin + worlddelta;
}

function getwallrunmantleangles(startnode) {
  assert(isDefined(startnode));
  assert(isDefined(startnode.wall_info));

  if(!isDefined(startnode.wall_info.mantleangles)) {
    return undefined;
  }

  angleoffset = startnode.angles[1] - startnode.wall_info.startnodeoriginalangles[1];

  if(angleoffset == 0) {
    return startnode.wall_info.mantleangles;
  }

  return (0, angleclamp180(startnode.wall_info.mantleangles[1] + angleoffset), 0);
}

function getwallruntomantletype() {
  startnode = self.traversal_start_node;
  assert(isDefined(startnode));

  if(!isDefined(startnode.wall_info.mantleoffset)) {
    return "none";
  }

  mantlepos = getwallrunmantleposition(startnode);

  if(mantlepos[2] >= self.origin[2]) {
    return "high";
  }

  return "low";
}

function shouldwallruntovault(asmname, statename, tostatename, params) {
  startnode = self.traversal_start_node;
  assert(isDefined(startnode));

  if(!isDefined(startnode.wall_info.bvaultover)) {
    return 0;
  }

  return startnode.wall_info.bvaultover;
}

function playwallrunloop(asmname, statename, params) {
  self endon(statename + "_finished");
  startnode = self.traversal_start_node;
  assert(isDefined(startnode));
  assert(isDefined(startnode.wall_info));
  setupwallrunaimlimits();
  loopanim = asm_getanim(asmname, statename);
  assert(isDefined(loopanim));
  loopxanim = asm_getxanim(statename, loopanim);
  movedelta = getmovedelta(loopxanim);
  var_c1c17849832b0c9d = length2d(movedelta);
  assert(var_c1c17849832b0c9d > 0);

  if(!isDefined(startnode.wall_info.mantleoffset) && self.wall_run_current_node_index == startnode.wall_info.nodeoffsets.size - 2) {
    exitanim = asm_getanim(asmname, "wall_run_exit");
    assert(isDefined(exitanim));
    exitxanim = asm_getxanim("wall_run_exit", exitanim);
    var_7a01b5ed5ca503cd = getnotetracktimes(exitxanim, "start_jump");
    assert(isDefined(var_7a01b5ed5ca503cd) && var_7a01b5ed5ca503cd.size > 0);
    exitanimlength = getanimlength(exitxanim);
    exitmovedelta = getmovedelta(exitxanim, 0, var_7a01b5ed5ca503cd[0]);
    var_d72c308d5da52d60 = length2d(exitmovedelta);
  } else {
    var_d72c308d5da52d60 = 0;
  }

  assert(startnode.wall_info.nodeoffsets.size > self.wall_run_current_node_index + 1);
  delta = getwallnodeposition(startnode, self.wall_run_current_node_index + 1) - self.origin;
  var_bb633c459e7832b8 = length(delta);
  var_bb633c459e7832b8 -= var_d72c308d5da52d60;

  if(var_bb633c459e7832b8 < 0) {
    var_bb633c459e7832b8 = 0;
  }

  var_aeb58353cbdd1e6d = var_bb633c459e7832b8 / var_c1c17849832b0c9d;
  animlength = getanimlength(loopxanim);
  animtimeneeded = animlength * var_aeb58353cbdd1e6d;
  thread senddelayedevent(asmname, statename, animtimeneeded, "wall_run_loop_done", 1);
  desiredmovedir = vectorNormalize(delta);
  self orientmode("face direction", desiredmovedir);
  thread playwallrunendsound(statename);
  self animmode("noclip");
  self aisetanim(statename, loopanim);
  asm_playfacialanim(asmname, statename, loopxanim);
  asm_donotetracks(asmname, statename);
}

function playwallrunendsound(statename) {
  self endon("death");

  if(soundexists("wallrun_end_npc")) {
    self waittill("wall_run_loop_done");
    self playSound("wallrun_end_npc");
  }
}

function choosewallrunexitanim(asmname, statename, params) {
  alias = self.wall_run_direction;
  endpos = self getnegotiationendpos();
  zdelta = endpos[2] - self.origin[2];
  bdoublejump = 0;

  if(zdelta >= 0) {
    if(zdelta > 120) {
      bdoublejump = 1;
    }
  } else if(0 - zdelta > 240) {
    bdoublejump = 1;
  }

  if(bdoublejump == 0) {
    distsq = distancesquared(self.origin, endpos);

    if(distsq > 46225) {
      bdoublejump = 1;
    }
  }

  if(bdoublejump) {
    alias += "_double";
  }

  endpos = self getnegotiationendpos();
  startnode = self.traversal_start_node;
  assert(isDefined(startnode.wall_info.nodeoffsets[startnode.wall_info.nodeoffsets.size - 1]));
  dir = self getnegotiationendpos() - getwallnodeposition(startnode, startnode.wall_info.nodeoffsets.size - 1);
  dir = (dir[0], dir[1], 0);
  dir = vectorNormalize(dir);
  desiredangles = vectortoangles(dir);
  yawdelta = angleclamp180(desiredangles[1] - self.angles[1]);
  yawdelta = abs(yawdelta);

  if(yawdelta >= 22.5) {
    if(yawdelta > 67.5) {
      alias += "_90";
    } else {
      alias += "_45";
    }
  }

  jumpanim = asm_lookupanimfromalias(statename, alias);
  return jumpanim;
}

function playwallrunexit(asmname, statename, params) {
  self endon(statename + "_finished");
  startnode = self.traversal_start_node;
  endpos = self getnegotiationendpos();
  assert(isDefined(startnode));
  assert(isDefined(endpos));
  assert(isDefined(startnode.wall_info));
  desiredangles = self.angles;
  var_8c2c7ea3bd382df4 = 1;
  animname = asm_getanim(asmname, statename);
  groundtime = getnotetracktimes(animname, "ground");
  self function_62004d7561fd321e();

  if(isDefined(groundtime) && groundtime.size > 0) {
    var_8c2c7ea3bd382df4 = groundtime[0];
  } else {
    var_930caef7352c0f86 = getnotetracktimes(animname, "end_double_jump");

    if(isDefined(var_930caef7352c0f86) && var_930caef7352c0f86.size > 0) {
      var_8c2c7ea3bd382df4 = var_930caef7352c0f86[0];
    } else {
      var_cab4a622d5af2e97 = getnotetracktimes(animname, "end_jump");

      if(isDefined(var_cab4a622d5af2e97) && var_cab4a622d5af2e97.size > 0) {
        var_8c2c7ea3bd382df4 = var_cab4a622d5af2e97[0];
      }
    }
  }

  if(soundexists("wallrun_end_npc")) {
    self playSound("wallrun_end_npc");
  }

  playscaledjump(asmname, statename, animname, endpos, desiredangles, var_8c2c7ea3bd382df4, 1, 1);
  thread terminatewallruntraverse(asmname, statename);
}

function isnotdoingwallruntransition(asmname, statename, tostatename, params) {
  if(isDefined(self.traversal_start_node)) {
    return false;
  }

  if(getdvarint(@ "hash_df899f2d04257001", 0) != 0) {
    if(self setuptraversaltransitioncheck(asmname, statename, tostatename, params)) {
      thread draworigin();
      thread drawdebugline(self.traversal_start_node.origin, (0, 0, 1), (1, 0, 0));
      thread debugwallrun(statename, self.traversal_start_node, self getnegotiationendpos());
      self.traversal_start_node = undefined;
      self.wall_run_direction = undefined;
    }
  }

  return true;
}

function terminatewallruntraverse(asmname, statename) {
  self.wall_run_current_node_index = undefined;
  self.wall_run_direction = undefined;
  self.wall_run_double_jumping = undefined;
  self.wall_run_yaw = undefined;
  self.wall_run_attach_anim = undefined;
  self setdefaultaimlimits();
  terminatetraverse(asmname, statename);
}

function playwallruntomantle(asmname, statename, params) {
  self endon(statename + "_finished");
  startnode = self.traversal_start_node;
  endnodepos = self getnegotiationendpos();
  assert(isDefined(startnode));
  assert(isDefined(endnodepos));
  mantleendpos = getwallrunmantleposition(startnode);

  if(isDefined(startnode.wall_info.bvaultover) || getwallruntomantletype() == "high") {
    mantleangles = getwallrunmantleangles(startnode);

    if(!isDefined(mantleangles)) {
      delta = endnodepos - mantleendpos;
      delta = (delta[0], delta[1], 0);
      mantleangles = vectortoangles(delta);
    }
  } else {
    delta = mantleendpos - self.origin;
    delta = (delta[0], delta[1], 0);
    mantleangles = vectortoangles(delta);
  }

  mantleanim = asm_getanim(asmname, statename);
  assert(isDefined(mantleanim));
  animlength = getanimlength(mantleanim);
  var_fa917664aea6e292 = getnotetracktimes(mantleanim, "start_mantle");
  assert(var_fa917664aea6e292.size > 0);
  var_40d329cf034e4307 = var_fa917664aea6e292[0];
  var_4f0ca52986969139 = getnotetracktimes(mantleanim, "end_mantle");
  assert(var_4f0ca52986969139.size > 0);
  var_45d80567424231ae = var_4f0ca52986969139[0];
  var_99b01baf607ed310 = getmovedelta(mantleanim, var_40d329cf034e4307, var_45d80567424231ae);
  self forceteleport(self.origin, mantleangles);
  var_6f31e626554d6ab9 = self localtoworldcoords(var_99b01baf607ed310);
  actualdelta = var_6f31e626554d6ab9 - self.origin;
  mantlestartpos = mantleendpos - actualdelta;

  if(getdvarint(@ "hash_df899f2d04257001", 0) != 0) {
    function_52e0db833127ec95(self.origin, mantlestartpos, (255, 0, 0), 100);
  }

  playscaledjump(asmname, statename, mantleanim, mantlestartpos, mantleangles, var_40d329cf034e4307, 0, 1);
  thread terminatewallruntraverse(asmname, statename);
}

function playtraversaltransition(asmname, statename, params) {
  self endon(statename + "_finished");
  animid = asm_getanim(asmname, statename);

  if(!isDefined(animid)) {
    asm_fireevent(asmname, "code_move");
    return;
  }

  xanim = asm_getxanim(statename, animid);
  animendtime = 1;
  notetracktimes = undefined;

  if(getdvarint(@ "hash_f13997d88562c7b5", 1) == 1) {
    notetracktimes = getnotetracktimes(xanim, "align");
  }

  if(!isDefined(notetracktimes) || notetracktimes.size == 0) {
    notetracktimes = getnotetracktimes(xanim, "code_move");
  }

  if(isDefined(notetracktimes) && notetracktimes.size > 0) {
    animendtime = notetracktimes[0];
  }

  stopdelta = getmovedelta(xanim, 0, animendtime);
  var_fd7c686cead623aa = getangledelta(xanim, 0, animendtime);
  negotiationnode = self.traversal_start_node;
  assert(isDefined(negotiationnode));

  if(getdvarint(@ "hash_df899f2d04257001", 0) != 0 && self.traversal_start_node.animscript == "<dev string:x1a3>") {
    thread draworigin();
    thread drawdebugline(negotiationnode.origin, (0, 0, 1), (1, 0, 0));
    thread debugwallrun(statename, self.traversal_start_node, self getnegotiationendpos());
  }

  anim_length = getanimlength(xanim) * animendtime;
  var_64366dd6eea5221d = int(ceil(anim_length * 20));

  if(self.traversal_start_node.animscript == "wall_run") {
    var_7fe6f6537340df66 = getwallnodeposition(self.traversal_start_node, 0) - self.origin;
    var_71ab5f95b941ad8d = vectortoangles(var_7fe6f6537340df66);
    desiredyaw = var_71ab5f95b941ad8d[1];
  } else {
    desireddelta = self getnegotiationendpos() - self.traversal_start_node.origin;
    desireddelta = (desireddelta[0], desireddelta[1], 0);
    desiredangles = vectortoangles(desireddelta);
    desiredyaw = desiredangles[1];
  }

  stopstartpos = scripts\asm\soldier\cover::calcanimstartpos(negotiationnode.origin, desiredyaw, stopdelta, var_fd7c686cead623aa);
  arrivalyaw = desiredyaw - var_fd7c686cead623aa;
  self.a.arrivalasmstatename = statename;
  self.useanimgoalweight = 1;
  self startcoverarrival(stopstartpos, arrivalyaw, var_64366dd6eea5221d);
  self aisetanim(statename, animid);
  asm_playfacialanim(asmname, statename, xanim);
  asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
}

function choosetraversaltransition(asmname, statename, params) {
  approachdir = anglesToForward(self.angles);
  approachangles = vectortoangles(approachdir);

  if(self.traversal_start_node.animscript == "wall_run") {
    desiredangles = vectortoangles(getwallnodeposition(self.traversal_start_node, 0) - self.origin);
  } else {
    desireddelta = self getnegotiationendpos() - self.traversal_start_node.origin;
    desireddelta = (desireddelta[0], desireddelta[1], 0);
    desiredangles = vectortoangles(desireddelta);
  }

  desiredyaw = desiredangles[1];
  anglediff = angleclamp180(desiredyaw - approachangles[1]);
  angleindex = getangleindex(anglediff, 22.5);
  stopanims = getstopanims(asmname, statename, undefined, 1);

  if(!isDefined(stopanims[angleindex])) {
    return undefined;
  }

  return stopanims[angleindex];
}

function shouldabortwallrunattach(asmname, statename, tostatename, params) {
  distsq = distance2dsquared(self.origin, getwallnodeposition(self.traversal_start_node, 1));

  if(distsq < 144) {
    return true;
  }

  return false;
}

function shouldtraversetransitionto(asmname, statename, tostatename, params) {
  if(tostatename == self.traversal_start_node.animscript) {
    return true;
  }

  return false;
}

function istraversaltransitionsupported(animscript) {
  switch (animscript) {
    case #"hash_3083e73248cdb399":
    case #"hash_5f054fa72e77b8dd":
    case #"hash_6fc6878fd3fd1e7a":
    case #"hash_8f681d217a32aef7":
    case #"hash_d14662a6eb371af5":
      return true;
  }

  return false;
}

function shoulddotraversaltransition(asmname, statename, tostatename, params) {
  if(!isDefined(self.traversal_start_node)) {
    return false;
  }

  if(!istraversaltransitionsupported(self.traversal_start_node.animscript)) {
    return false;
  }

  if(!self.facemotion) {
    return false;
  }

  traversal_direction = undefined;

  if(self.traversal_start_node.animscript == "wall_run") {
    traversal_direction = getwallrundirectionfromstartnode(self.traversal_start_node);
    desireddelta = getwallnodeposition(self.traversal_start_node, 0) - self.origin;
    desiredangles = vectortoangles(desireddelta);
  } else {
    desireddelta = self getnegotiationendpos() - self.traversal_start_node.origin;
    desireddelta = (desireddelta[0], desireddelta[1], 0);
    traversal_direction = vectorNormalize(desireddelta);
    desiredangles = vectortoangles(traversal_direction);
  }

  traversalyaw = desiredangles[1];
  approachdir = anglesToForward(self.angles);
  approachangles = vectortoangles(approachdir);
  anglediff = angleclamp180(traversalyaw - approachangles[1]);
  angleindex = getangleindex(anglediff, 22.5);
  stopanims = getstopanims(asmname, tostatename, undefined, 1);
  stopanim = stopanims[angleindex];

  if(!isDefined(stopanim)) {
    return false;
  }

  animendtime = 1;
  notetracktimes = undefined;

  if(getdvarint(@ "hash_f13997d88562c7b5", 1) == 1) {
    notetracktimes = getnotetracktimes(stopanim, "align");
  }

  if(!isDefined(notetracktimes) || notetracktimes.size == 0) {
    notetracktimes = getnotetracktimes(stopanim, "code_move");
  }

  if(isDefined(notetracktimes) && notetracktimes.size > 0) {
    animendtime = notetracktimes[0];
  }

  stopdelta = getmovedelta(stopanim, 0, animendtime);
  var_fd7c686cead623aa = getangledelta(stopanim, 0, animendtime);
  disttonode = distance2d(self.origin, self.traversal_start_node.origin);
  var_4e851016ecec5294 = length(stopdelta);
  delta = disttonode - var_4e851016ecec5294;

  if(delta < 0) {
    traversedir = anglesToForward(desiredangles);
    dot = vectordot(approachdir, traversedir);

    if(dot > 0.707) {
      if(abs(delta) > 10) {
        return false;
      }
    } else if(abs(delta) > 64) {
      return false;
    }
  } else if(delta > 10) {
    return false;
  }

  if(self.traversal_start_node.animscript == "wall_run") {
    self.wall_run_direction = traversal_direction;
  }

  return true;
}

function handlewallrunattachnotetrack(note) {
  if(note == "wall_contact") {
    if(soundexists("wallrun_start_npc")) {
      self playSound("wallrun_start_npc");
    }
  }
}

function setupwallrunaimlimits() {
  self.upaimlimit = -89;
  self.downaimlimit = 45;
  self.rightaimlimit = -90;
  self.leftaimlimit = 90;
}

function drawdebugline(pos, normal, color) {
  self notify("<dev string:x1af>");
  level endon("<dev string:x1c5>");
  self endon("<dev string:x1d3>");
  level endon("<dev string:x1dc>");
  self endon("<dev string:x1af>");
  lineend = pos + normal * 100;

  while(true) {
    line(pos, lineend, color, 1, 1, 1);
    wait 0.05;
  }
}

function function_52e0db833127ec95(from, to, color, duration) {
  if(!isDefined(duration)) {
    duration = 5;
  }

  line(from, to, color, 1, 1, duration);
}

function draworigin() {
  self notify("<dev string:x1ec>");
  level endon("<dev string:x1c5>");
  self endon("<dev string:x1d3>");
  level endon("<dev string:x1dc>");
  self endon("<dev string:x1ec>");
  color = (0, 0, 1);
  normal = (0, 0, 1);

  while(true) {
    pos = self.origin;
    lineend = pos + normal * 100;
    line(pos, lineend, color, 1, 1, 1);
    wait 0.05;
  }
}

function debugwallrun(statename, startnode, endpos) {
  color1 = (0, 1, 0);
  color2 = (0, 0, 1);
  color = color1;
  line(startnode.origin, getwallnodeposition(startnode, 0), color, 1, 1, 300);
  currentpos = startnode.origin;

  for(i = 0; i < startnode.wall_info.nodeoffsets.size - 1; i++) {
    if(i % 2 == 0) {
      color = color2;
    } else {
      color = color1;
    }

    currentpos = getwallnodeposition(startnode, i);
    line(currentpos, getwallnodeposition(startnode, i + 1), color, 1, 1, 300);
    currentpos = getwallnodeposition(startnode, i + 1);

    if(i % 2 == 0) {
      color = color1;
      continue;
    }

    color = color2;
  }

  line(currentpos, endpos, color, 1, 1, 300);
}

function playtraverseanim_ladder(asmname, statename, params) {
  self endon(statename + "_finished");
  self aisetisonladder(1);
  startnode = self getnegotiationstartnode();
  endpos = self getnegotiationendpos();
  assert(isDefined(startnode));
  self animmode("noclip", 0);
  self orientmode("face angle", startnode.angles[1]);
  starttoend = endpos - startnode.origin;
  demeanor = asm_getdemeanor();
  climbanim = undefined;
  mountanim = undefined;
  var_5af16561805a75b1 = undefined;
  dropdownanim = 0;

  if(starttoend[2] > 0) {
    offalias = "off_" + demeanor;
    var_5af16561805a75b1 = asm_lookupanimfromaliasifexists(statename, offalias);

    if(!isDefined(var_5af16561805a75b1)) {
      if(!isDefined(startnode.traverse_drop_height_delta) || startnode.traverse_drop_height_delta < 6) {
        var_5af16561805a75b1 = asm_lookupanimfromalias(statename, "off");
      } else if(startnode.traverse_drop_height_delta < 36) {
        var_5af16561805a75b1 = asm_lookupanimfromalias(statename, "off_low");
        dropdownanim = 1;
      } else if(startnode.traverse_drop_height_delta < 60) {
        var_5af16561805a75b1 = asm_lookupanimfromalias(statename, "off_mid");
        dropdownanim = 1;
      } else {
        var_5af16561805a75b1 = asm_lookupanimfromalias(statename, "off_high");
        dropdownanim = 1;
      }
    }

    climbanim = asm_lookupanimfromalias(statename, "up");
  } else {
    onalias = "on_" + demeanor;
    var_5af16561805a75b1 = asm_lookupanimfromaliasifexists(statename, onalias);

    if(!isDefined(var_5af16561805a75b1)) {
      mountanim = asm_lookupanimfromalias(statename, "on");
    }

    climbanim = asm_lookupanimfromalias(statename, "down");
  }

  rate = 1;

  if(isDefined(self.moveplaybackrate)) {
    rate = self.moveplaybackrate;
  }

  if(isDefined(mountanim)) {
    self aisetanim(statename, mountanim, rate);
    asm_donotetracks(asmname, statename);
  }

  loopendpos = endpos;

  if(isDefined(var_5af16561805a75b1)) {
    var_ba9f413c71dc05c1 = asm_getxanim(statename, var_5af16561805a75b1);
    var_7e1ef9266bfb4e87 = getmovedelta(var_ba9f413c71dc05c1);

    if(dropdownanim) {
      loopendpos = startnode.traverse_height - (0, 0, 48);
    } else {
      loopendpos = endpos - var_7e1ef9266bfb4e87 + (0, 0, 1);
    }
  }

  assert(isDefined(climbanim));
  var_29dc8002ce343a5d = loopendpos - self.origin;

  if(var_29dc8002ce343a5d[2] * starttoend[2] > 0) {
    climbxanim = asm_getxanim(statename, climbanim);
    var_4badba7b39f1758e = getmovedelta(climbxanim);
    var_2f9556e4b32808e = var_4badba7b39f1758e[2] * rate / getanimlength(climbxanim);
    climbtime = var_29dc8002ce343a5d[2] / var_2f9556e4b32808e;
    assert(climbtime > 0);

    if(!isDefined(climbxanim) || !isDefined(var_4badba7b39f1758e) || !isDefined(var_2f9556e4b32808e) || !isDefined(climbtime)) {
      arcname = function_2285421dfc79c4d5();
      var_6af018c22f5f179f = self.basearchetype;
      println("<dev string:x202>" + climbanim + "<dev string:x229>" + arcname + "<dev string:x23d>" + statename + "<dev string:x24b>" + var_6af018c22f5f179f + "<dev string:x26e>");
    }

    self aisetanim(statename, climbanim, rate);
    asm_donotetracksfortime(asmname, statename, climbtime);
  }

  if(isDefined(var_5af16561805a75b1)) {
    self aisetanim(statename, var_5af16561805a75b1, rate);
    waitframe();
    notetrackhandle = &scripts\asm\traverse::handletraversewarpnotetracks;
    self.traversestartnode = startnode;
    self.traverseendnode = self getnegotiationendnode();
    self.var_70a168924eccff58 = endpos;
    self.traversexanim = asm_getxanim(statename, var_5af16561805a75b1);
    asm_donotetracks(asmname, statename, notetrackhandle);
    self.var_70a168924eccff58 = undefined;
  }

  terminatetraverse(asmname, statename);
}

function terminate_ladder(asmname, statename, params) {
  var_b48e997e59346e83 = !isalive(self);
  self.nogravityragdoll = var_b48e997e59346e83;
  self aisetisonladder(0);
  self.var_70a168924eccff58 = undefined;

  if(var_b48e997e59346e83) {
    self.forceragdollimmediate = 0;
  }
}

function traverse_basic(asmname, statename, params) {
  self endon(statename + "_finished");
  traverseanim = asm_getanim(asmname, statename);
  self animmode("noclip", 0);
  startnode = self getnegotiationstartnode();
  self orientmode("face angle", startnode.angles[1]);
  self aisetanim(statename, traverseanim);
  asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename));
  terminatetraverse(asmname, statename);
}