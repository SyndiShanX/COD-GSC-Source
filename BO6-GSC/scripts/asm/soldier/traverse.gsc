/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\traverse.gsc
********************************************/

#using scripts\anim\utility;
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\arrival;
#using scripts\asm\soldier\cover;
#using scripts\asm\traverse;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace traverse;

function playtraverseanim_deprecated(asmname, statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("b\xf7PR\xf8L\xaf8\xf4\xdd\x97\x1f\xe8\xcb7\x1dUG\x02\xba");
  checktraverse(statename);
  traverseanim = asm::asm_getanim(asmname, statename);
  traversexanim = asm::asm_getxanim(statename, traverseanim);
  self.desired_anim_pose = "1x\xc5\xb4\xabx";
  utility::updateanimpose();
  self endon("\xbb\x91a^\xe9\x1dr\x1e\x1cks\xf5y@");
  self animmode("b\xf21\xbc\xeb{");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", startnode.angles[1]);
  startnode.traverse_height = startnode.origin[2] + startnode.traverse_height_delta;
  realheight = startnode.traverse_height - startnode.origin[2];
  thread teleportthread(realheight - params);
  blendtime = 0.15;
  self aisetanim(statename, traverseanim);
  var_d5236b0bdab3e763 = 0.2;
  endblendtime = 0.2;
  thread traverse_donotetracks(asmname, statename);

  if(!animhasnotetrack(traversexanim, "\xc7\x1f=\xa4\xc1\x06\r\xf9\x14\xe9")) {
    var_16e80d9b388c39c9 = 1.23;
    wait var_16e80d9b388c39c9 - var_d5236b0bdab3e763;
    self animmode("\x1b\x9e\x86\xecr\x97\xa2");
    wait var_d5236b0bdab3e763;
  } else {
    self waittillmatch("\x0eq\x9e\b\xf4\xd9*Y", "\xc7\x1f=\xa4\xc1\x06\r\xf9\x14\xe9");
    self animmode("\x1b\x9e\x86\xecr\x97\xa2");

    if(!animhasnotetrack(traversexanim, "\xfa\xdf\x11xQ")) {
      wait var_d5236b0bdab3e763;
    } else {
      self waittillmatch("\x0eq\x9e\b\xf4\xd9*Y", "\xfa\xdf\x11xQ");
    }
  }

  terminatetraverse(asmname, statename);
}

function playtraverseanim(asmname, statename, params) {
  traverseanim = asm::asm_getanim(asmname, statename);
  checktraverse(statename);
  self animmode("b\xf21\xbc\xeb{");
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", startnode.angles[1]);
  self aisetanim(statename, traverseanim);
  asm::asm_donotetracks(asmname, statename);
  terminatetraverse(asmname, statename);
}

function playtraverseanim_doublejump(asmname, statename, params) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("b\xf7PR\xf8L\xaf8\xf4\xdd\x97\x1f\xe8\xcb7\x1dUG\x02\xba");
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  var_7a0805f325238de0 = getdvarint(@ "hash_db3bdaface7c82ec", 0);

  if(var_7a0805f325238de0 != 3 && var_7a0805f325238de0 != 4) {
    checktraverse(statename);
  }

  self.ragdoll_immediate = 1;
  start_node = self getnegotiationstartnode();
  var_d71721d4821e4ac3 = self getnegotiationendpos();
  start_node.traverse_height = start_node.origin[2] + start_node.traverse_height_delta - 44;
  var_b8df83d4aebca8af = [];

  if(start_node.traverse_height > var_d71721d4821e4ac3[2]) {
    halfway_x = (start_node.origin[0] + var_d71721d4821e4ac3[0]) * 0.5;
    halfway_y = (start_node.origin[1] + var_d71721d4821e4ac3[1]) * 0.5;
    var_b8df83d4aebca8af[var_b8df83d4aebca8af.size] = (halfway_x, halfway_y, start_node.traverse_height);

    if(var_7a0805f325238de0 != 0) {
      jump_over_position = var_b8df83d4aebca8af[0];
      function_6303270466e7657c(self.origin, jump_over_position, (128, 0, 255), 100);
      function_6303270466e7657c(self.origin, var_d71721d4821e4ac3, (128, 0, 255), 100);
    }
  }

  var_b8df83d4aebca8af[var_b8df83d4aebca8af.size] = var_d71721d4821e4ac3;
  var_96c1db0f00bccbef = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", start_node.origin);
  var_96c1db0f00bccbef setModel("\xec\xbfK|\au\xcd\xc2\x19<");
  var_96c1db0f00bccbef.angles = start_node.angles;
  thread utility::delete_on_death(var_96c1db0f00bccbef);
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", start_node.angles[1]);
  max_time = 1.63;

  if(var_7a0805f325238de0 == 3) {
    max_time = 0.9;
  }

  self linkTo(var_96c1db0f00bccbef);
  jumpanim = asm::asm_getanim(asmname, statename);
  asm::asm_playfacialanim(asmname, statename, asm::asm_getxanim(jumpanim));
  self aisetanim(statename, jumpanim);
  thread traverse_donotetracks(asmname, statename);

  foreach(org in var_b8df83d4aebca8af) {
    move_time = max_time / var_b8df83d4aebca8af.size;
    var_96c1db0f00bccbef moveTo(org, move_time);
    var_96c1db0f00bccbef waittill("\xd4E\xa7\xc7\x1e\xf9\x87%");
  }

  self notify("\x1c\x85t]eA\xa6V\xf1\x91y\x8d\xdc");
  self unlink();
  self.ragdoll_immediate = undefined;
  var_96c1db0f00bccbef delete();
  thread terminatetraverse(asmname, statename);
}

function traverse_doublejump_cleanup(asmname, statename, params) {
  self unlink();
  self.ragdoll_immediate = undefined;
}

function traverse_donotetracks(asmname, statename) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("b\xf7PR\xf8L\xaf8\xf4\xdd\x97\x1f\xe8\xcb7\x1dUG\x02\xba");
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self endon("\x1c\x85t]eA\xa6V\xf1\x91y\x8d\xdc");
  asm::asm_donotetracks(asmname, statename);
}

function getexternaltraverseinfo(traversename) {
  assert(isDefined(level.scr_traverse), "<dev string:x24>");
  assert(isDefined(level.scr_traverse[traversename]), "<dev string:x69>" + traversename + "<dev string:x81>");

  if(isDefined(level.scr_traverse) && isDefined(level.scr_traverse[traversename])) {
    return level.scr_traverse[traversename];
  }

  return undefined;
}

function playtraverseanim_external(asmname, statename, params) {
  assert(utility::issp(), "<dev string:x9a>" + asmname + "<dev string:xbe>" + statename + "<dev string:xcc>");
  playtraverseanim_scaled(asmname, statename);
}

function choosetraverseanim_external(asmname, statename, params) {
  startnode = self getnegotiationstartnode();
  assert(isDefined(startnode));
  traversename = startnode.animscript;

  if(isDefined(level.var_d0d1d5b3dc96879e) && isDefined(level.var_d0d1d5b3dc96879e[traversename])) {
    xanim = [[level.var_d0d1d5b3dc96879e[traversename]]](asmname, statename, params);
    assert(isanimation(xanim));
    return xanim;
  }

  animinfo = getexternaltraverseinfo(traversename);
  assert(isanimation(animinfo));
  return animinfo;
}

function playdoublejumpfinishanim(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self animmode("b\xf21\xbc\xeb{");
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1]);
  self.useanimgoalweight = 1;
  animid = asm::asm_getanim(asmname, statename);
  self aisetanim(statename, animid);
  xanim = asm::asm_getxanim(statename, animid);
  asm::asm_playfacialanim(asmname, statename, xanim);
  asm::asm_donotetracks(asmname, statename);
  thread terminatetraverse(asmname, statename);
}

function getdoublejumpoffsetposition(asmname, var_fd7702f40aba1e8d, endpos, endangles, notetrackname) {
  animid = asm::asm_chooseanim(asmname, var_fd7702f40aba1e8d);
  assert(isDefined(animid));
  xanim = asm::asm_getxanim(var_fd7702f40aba1e8d, animid);
  aligntime = getnotetracktimes(xanim, notetrackname);
  assert(isDefined(aligntime) && aligntime.size > 0);
  time = aligntime[0];
  animdelta = getmovedelta(xanim, 0, time);
  animangledelta = getangledelta(xanim, 0, time);
  return cover::calcanimstartpos(endpos, endangles[1], animdelta, animangledelta);
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
    var_c66300c44b8c0edc = jump_over_position[2];
    var_c66300c44b8c0edc -= 44;

    if(endpos[2] < var_c66300c44b8c0edc) {
      return false;
    }
  }

  delta = endpos - startnode.origin;
  delta = (delta[0], delta[1], 0);
  desiredangles = vectortoangles(delta);
  offsetpos = getdoublejumpoffsetposition(asmname, nextstatename, endpos, desiredangles, "\xe0egh2\x0e\xd3;\x19p\x7f\x92\xcbI\x9b\r\x81C}");
  newdelta = offsetpos - startnode.origin;

  if(vectordot(newdelta, delta) < 0) {
    return false;
  }

  return true;
}

function checkdoublejumpfinish(asmname, statename, tostatename, params) {
  startnode = gettraversalstartnode();

  if(!isDefined(startnode)) {
    thread terminatetraverse(asmname, "\x91\xf6\xae\xc4\xb1V\xebMu\xad\a");
    return false;
  }

  endpos = self getnegotiationendpos();
  assert(isDefined(endpos));

  if(!doublejumpneedsfinishanim(asmname, tostatename, startnode, endpos)) {
    thread terminatetraverse(asmname, "\x91\xf6\xae\xc4\xb1V\xebMu\xad\a");
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
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  startnode = gettraversalstartnode();
  assert(isDefined(startnode.doublejumpmantlepos));
  assert(isDefined(startnode));
  endpos = startnode.doublejumpmantlepos;

  delta = endpos - startnode.origin;
  delta = (delta[0], delta[1], 0);
  desiredangles = vectortoangles(delta);
  jumpanim = asm::asm_getanim(asmname, statename);
  assert(isDefined(jumpanim));
  nextstatename = statename + "\xde\xa6YlItl";
  mantlestartpos = getdoublejumpoffsetposition(asmname, nextstatename, endpos, desiredangles, "\x14\xef\xe3\xb0\xae~\xdc\x8a\f\xcb|\xdf");
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
  if(!asm::asm_eventfired(asmname, "8\xdb\x90")) {
    doublejumpterminate(asmname, statename, params);
  }
}

function isdoublejumpanimdone(asmname, statename, tostatename, params) {
  if(getdvarint(@ "hash_db3bdaface7c82ec", 0) == 3) {
    return 0;
  }

  return asm::asm_eventfired(asmname, "8\xdb\x90");
}

function playdoublejumptraversal(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  if(getdvarint(@ "hash_db3bdaface7c82ec", 0) == 4) {
    playtraverseanim_doublejump(asmname, "<dev string:xfb>", params);
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
  var_7a0805f325238de0 = getdvarint(@ "hash_db3bdaface7c82ec", 0);

  if(var_7a0805f325238de0 != 2) {
    if(isDefined(startnode.jump_over_offset)) {
      jump_over_offset = startnode.jump_over_offset;

      if(angleoffset != (0, 0, 0)) {
        jump_over_offset = rotatevector(jump_over_offset, angleoffset);
      }

      jump_over_position = startnode.origin + jump_over_offset;
      var_c66300c44b8c0edc = jump_over_position[2];
      var_c66300c44b8c0edc -= 44;

      if(var_c66300c44b8c0edc > endpos[2]) {
        halfway_x = (startnode.origin[0] + endpos[0]) * 0.5;
        halfway_y = (startnode.origin[1] + endpos[1]) * 0.5;
        jump_over_position = (halfway_x, halfway_y, jump_over_position[2]);
      } else {
        jump_over_position = undefined;
      }
    }
  }

  jumpanim = asm::asm_getanim(asmname, statename);
  assert(isDefined(jumpanim));
  self.jump_over_position = jump_over_position;

  if(getdvarint(@ "hash_db3bdaface7c82ec", 0) != 0) {
    if(isDefined(jump_over_position)) {
      function_6303270466e7657c(self.origin, jump_over_position, (128, 0, 255), 100);
      function_6303270466e7657c(self.origin, endpos, (128, 0, 255), 100);
    } else {
      function_6303270466e7657c(self.origin, endpos, (128, 255, 0), 100);
    }
  }

  nextstatename = statename + "\xde\xa6YlItl";

  if(doublejumpneedsfinishanim(asmname, nextstatename, startnode, endpos)) {
    delta = endpos - startnode.origin;
    delta = (delta[0], delta[1], 0);
    desiredangles = vectortoangles(delta);
    nextstatename = statename + "\xde\xa6YlItl";
    offsetpos = getdoublejumpoffsetposition(asmname, nextstatename, endpos, desiredangles, "\xe0egh2\x0e\xd3;\x19p\x7f\x92\xcbI\x9b\r\x81C}");
    endpos = offsetpos;
  }

  delta = endpos - startnode.origin;
  var_83fe5be4489d8042 = 0;
  animendtime = 1;

  if(delta[2] < 0) {
    var_83fe5be4489d8042 = 1;
    touchgroundtime = getnotetracktimes(asm::asm_getxanim(statename, jumpanim), "\xc7\x1f=\xa4\xc1\x06\r\xf9\x14\xe9");

    if(isDefined(touchgroundtime) && touchgroundtime.size > 0) {
      animendtime = touchgroundtime[0];
    }
  }

  delta = (delta[0], delta[1], 0);
  desiredangles = vectortoangles(delta);
  playscaledjump(asmname, statename, jumpanim, endpos, desiredangles, animendtime, var_83fe5be4489d8042, 1);
}

function choosedoublejumpanim(asmname, statename, params) {
  endpos = self getnegotiationendpos();
  assert(isDefined(endpos));
  alias = "T\x10\xba\xfd\xb6A\x9fq\xf2h@/\xdb\xff";

  if(isDefined(params)) {
    assert(params == "<dev string:x10f>" || params == "<dev string:x115>");
    alias = "Q\x80\xd5\xad\xe6\x1e}\x05X\x8c\x02\xd9" + params;
  } else if(endpos[2] < self.origin[2]) {
    alias = "l.e\x06\xac\xff\x8c\b\x7f\xd481@\xb8;\xdd";
  }

  if(self.asm.footsteps.foot == "o0\xee\xc1\x8c") {
    prefix = "\xfa\xe9\xf2\xc9`.";
  } else {
    prefix = "x\x89G\xdd\x05";
  }

  alias = prefix + alias;
  animname = asm::asm_lookupanimfromalias(statename, alias);
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
  jumpanim = asm::asm_lookupanimfromalias(statename, self.wall_run_direction);
  return jumpanim;
}

function getsmoothstep(delta) {
  if(getdvarint(@ "hash_dd616d5851bec943", 1) == 2) {
    return (delta * delta * delta * (delta * (delta * 6 - 15) + 10));
  }

  return delta * delta * (3 - 2 * delta);
}

function teleportdeltaovernumframes(statename, waittime, delta, numframes, animname, playbackrate) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  if(waittime > 0) {
    wait waittime;
  }

  framedelta = delta / numframes;
  startpos = self.origin[2];
  endpos = startpos + delta[2];
  lastz = self.origin[2];
  self setanimrate(animname, playbackrate);

  for(i = 0; i < numframes; i++) {
    var_e4d769bc2190b295 = 1;

    if(getdvarint(@ "hash_dd616d5851bec943", 1) == 0) {
      var_e4d769bc2190b295 = 0;
    }

    if(var_e4d769bc2190b295) {
      pct = i / (numframes - 1);
      smoothstep = getsmoothstep(pct);
      newz = endpos * smoothstep + startpos * (1 - smoothstep);
      newdeltaz = newz - lastz;
      framedelta = (framedelta[0], framedelta[1], newdeltaz);
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
  self notify("<dev string:x11d>");
  self endon("<dev string:x11d>");
  self endon(statename + "<dev string:x12f>");

  while(true) {
    line(self.origin, dest, (0, 255, 0));
    waitframe();
  }
}

function wallrunnotehandler(note, params) {
  if(note == "q\x15Ktr\xe1\x04\xad\xf5\xcc") {
    thread handlejumpteleports(params);
    return;
  }

  if(note == "\xc9\x82\x9e'\xfa\x9c\a\xc7\xd8Q") {
    self animmode("\x1b\x9e\x86\xecr\x97\xa2");
  }
}

function handlejumpteleports(params, animtime, playbackrate) {
  assert(isarray(params));
  assert(params.size == 7);
  statename = params[0];
  animname = params[1];
  desiredendpos = params[2];
  starttime = params[3];
  var_4bc650a9f430ce51 = params[4];
  var_83fe5be4489d8042 = params[5];
  var_f14b5cfeb08942cc = params[6];
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  animlength = getanimlength(animname);

  if(!isDefined(animtime)) {
    animtime = (gettime() - starttime) * 0.001;
  }

  animtimepct = animtime / animlength;
  endjumptime = getnotetracktimes(animname, "\xf5\xfc\f\xafb\f-5");
  var_1ee04b7dc120ef3 = getnotetracktimes(animname, "{W\x8b*m\xfc\x14$\x88\x9f\x1af\v\xad\xd8");

  if(var_1ee04b7dc120ef3.size > 0) {
    self.wall_run_double_jumping = 1;
    endjumptime = var_1ee04b7dc120ef3;
  } else {
    self.wall_run_double_jumping = 0;
  }

  assert(endjumptime.size > 0);

  if(isDefined(self.jump_over_position)) {
    var_4bc650a9f430ce51 = (endjumptime[0] - animtimepct) / 2 + animtimepct;
    endjumptime[0] = var_4bc650a9f430ce51;
    desiredendpos = self.jump_over_position;
  }

  movedelta = getmovedelta(animname, animtimepct, var_4bc650a9f430ce51);
  animendpos = self localtoworldcoords(movedelta);

  if(getdvarint(@ "ai_debugwallrun", 0) != 0 && isDefined(self.traversal_start_node)) {
    disttoanimend = distance(self.origin, animendpos);
    disttodesiredpos = distance(self.origin, desiredendpos);
    var_85704402f8a5083c = disttodesiredpos / disttoanimend;

    if(var_85704402f8a5083c < 0.8 || var_85704402f8a5083c > 1.2) {
      println("<dev string:x13c>" + self.traversal_start_node.origin + "<dev string:x168>" + animname + "<dev string:x180>" + var_85704402f8a5083c);
      println("<dev string:x188>" + disttoanimend + "<dev string:x199>" + disttodesiredpos);
    }
  }

  if(!isDefined(playbackrate)) {
    playbackrate = 1;
  }

  if(var_f14b5cfeb08942cc) {
    disttoanimend = distance(self.origin, animendpos);
    disttodesiredpos = distance(self.origin, desiredendpos);
    playbackrate = disttoanimend / disttodesiredpos;

    if(playbackrate < 0.7) {
      playbackrate = 0.7;
    } else if(playbackrate > 1.3) {
      playbackrate = 1.3;
    }
  }

  scaledelta = desiredendpos - animendpos;
  var_8a11ef1d7c5a2962 = endjumptime[0] * animlength;
  jumpduration = var_8a11ef1d7c5a2962 - animtimepct * animlength;
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
    return "o0\xee\xc1\x8c";
  }

  return "=\xff0b";
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
  if(!asm::asm_eventfired(asmname, "8\xdb\x90") && !asm::asm_eventfired(asmname, "f\x97\xb9`\xd1~\x80(\xca")) {
    self.traversal_start_node = undefined;
    self.wall_run_direction = undefined;
  }
}

function playwallrunattach(asmname, statename, params) {
  self animmode("b\xf21\xbc\xeb{");
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1]);
  self.useanimgoalweight = 1;

  if(isDefined(params) && params == "7\r\xdb\xb7\xd1") {
    setupwallrunaimlimits();
  }

  animid = asm::asm_getanim(asmname, statename);
  xanim = asm::asm_getxanim(statename, animid);
  var_d2eaabe545f0fbbf = getnotetracktimes(xanim, "KZY\x8c4\xeb\x8d\x91\xb8\xc8Q\xce");
  assert(isDefined(var_d2eaabe545f0fbbf) && var_d2eaabe545f0fbbf.size > 0);
  time = var_d2eaabe545f0fbbf[0];
  angledelta = getangledelta(xanim, 0, time);
  faceyaw = self.wall_run_yaw - angledelta;
  forceangles = (0, faceyaw, 0);
  self forceteleport(self.origin, forceangles);
  self aisetanim(statename, animid);
  asm::asm_playfacialanim(asmname, statename, xanim);
  endnote = asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
}

function getwallattachoffsetposition(asmname) {
  animname = choosewallattachanim(asmname, "\x9e\xa2\xe2\r\xd8\x9f\xfd]\xd3\x06\xbb\x97Z\xd4\x0e");
  assert(isDefined(animname));
  var_d2eaabe545f0fbbf = getnotetracktimes(animname, "KZY\x8c4\xeb\x8d\x91\xb8\xc8Q\xce");
  assert(isDefined(var_d2eaabe545f0fbbf) && var_d2eaabe545f0fbbf.size > 0);
  time = var_d2eaabe545f0fbbf[0];
  animdelta = getmovedelta(animname, 0, time);
  animangledelta = getangledelta(animname, 0, time);
  return cover::calcanimstartpos(getwallnodeposition(self.traversal_start_node, 0), self.wall_run_yaw, animdelta, animangledelta);
}

function playwallrunenter(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  animid = asm::asm_getanim(asmname, statename);
  xanim = asm::asm_getxanim(statename, animid);
  startnode = self.traversal_start_node;
  assert(isDefined(startnode));
  assert(isDefined(startnode.wall_info));
  assert(startnode.wall_info.nodeoffsets.size >= 2);
  self.wall_run_current_node_index = 0;
  wallnodepos = getwallnodeposition(startnode, 0);
  delta = wallnodepos - self.origin;
  delta = (delta[0], delta[1], 0);
  desiredangles = vectortoangles(delta);
  jumpdestination = getwallattachoffsetposition();
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", desiredangles[1]);
  assert(isDefined(self.wall_run_direction));

  if(getdvarint(@ "ai_debugwallrun", 0) != 0) {
    function_6303270466e7657c(self.origin, jumpdestination, (128, 0, 255), 100);
  }

  animendtime = 1;
  codemovetime = getnotetracktimes(xanim, "f\x97\xb9`\xd1~\x80(\xca");

  if(isDefined(codemovetime) && codemovetime.size > 0) {
    animendtime = codemovetime[0];
  }

  playscaledjump(asmname, statename, animid, jumpdestination, desiredangles, animendtime, 0, 1);
  self forceteleport(jumpdestination, desiredangles);
}

function playscaledjump(asmname, statename, animid, desiredposition, desiredangles, var_4bc650a9f430ce51, var_83fe5be4489d8042, var_f14b5cfeb08942cc) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  if(!isDefined(var_4bc650a9f430ce51)) {
    var_4bc650a9f430ce51 = 1;
  }

  if(!isDefined(var_83fe5be4489d8042)) {
    var_83fe5be4489d8042 = 0;
  }

  if(!isDefined(var_f14b5cfeb08942cc)) {
    var_f14b5cfeb08942cc = 0;
  }

  self forceteleport(self.origin, desiredangles);
  self animmode("b\xf21\xbc\xeb{");
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", desiredangles[1]);
  xanim = asm::asm_getxanim(statename, animid);
  self.useanimgoalweight = 1;
  self aisetanim(statename, animid);
  asm::asm_playfacialanim(asmname, statename, xanim);
  notetrackparams = [statename, xanim, desiredposition, gettime(), var_4bc650a9f430ce51, var_83fe5be4489d8042, var_f14b5cfeb08942cc];
  asm::asm_donotetracks(asmname, statename, &wallrunnotehandler, notetrackparams);
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
      aliasname += "\xac\xfa\xd4";
    } else {
      aliasname += "\xff\x112";
    }
  }

  self.wall_run_attach_anim = asm::asm_lookupanimfromalias(statename, aliasname);
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
  jumptopos = getwallnodeposition(startnode, 0);
  zdelta = jumptopos[2] - self.origin[2];
  bdoublejump = 0;

  if(zdelta >= 0) {
    if(zdelta > 120) {
      bdoublejump = 1;
    }
  } else if(0 - zdelta > 240) {
    bdoublejump = 1;
  }

  if(bdoublejump == 0) {
    distsq = distancesquared(self.origin, jumptopos);

    if(distsq > 40000) {
      bdoublejump = 1;
    }
  }

  prefix = "x\x89G\xdd\x05";

  if(self.asm.footsteps.foot == "o0\xee\xc1\x8c") {
    prefix = "\xfa\xe9\xf2\xc9`.";
  }

  if(bdoublejump) {
    alias = prefix + "\x91\xf6\xae\xc4\xb1V\xebMu\xad\a";
  } else {
    alias = prefix + "\x16\xcd\x91\xd3\xdf\x9e\x0e\xa3\x03|\xbc";
  }

  jumpanim = asm::asm_lookupanimfromalias(statename, alias);
  return jumpanim;
}

function senddelayedevent(asmname, statename, time, event, var_b6fb5c46104d2b8b) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  wait time;
  asm::asm_fireevent(asmname, event);

  if(var_b6fb5c46104d2b8b) {
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
  var_84871b471a730aa9 = self.wall_run_current_node_index + 2;

  if(startnode.wall_info.nodeoffsets.size <= var_84871b471a730aa9) {
    return false;
  }

  assert(startnode.wall_info.nodeoffsets.size > var_84871b471a730aa9 + 1);
  return true;
}

function playwallruncontinue(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  startnode = self.traversal_start_node;
  self function_fc623e800cdeade7();
  assert(isDefined(startnode));
  self.wall_run_current_node_index += 2;
  assert(startnode.wall_info.nodeoffsets.size > self.wall_run_current_node_index + 1);
  endpos = getwallnodeposition(startnode, self.wall_run_current_node_index);
  desiredangles = self.angles;

  if(self.wall_run_direction == "=\xff0b") {
    self.wall_run_direction = "o0\xee\xc1\x8c";
  } else {
    self.wall_run_direction = "=\xff0b";
  }

  animid = asm::asm_getanim(asmname, statename);
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
    return "\r+x5";
  }

  mantlepos = getwallrunmantleposition(startnode);

  if(mantlepos[2] >= self.origin[2]) {
    return ":\xbfa^";
  }

  return "4\xa9\xc7";
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
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  startnode = self.traversal_start_node;
  assert(isDefined(startnode));
  assert(isDefined(startnode.wall_info));
  setupwallrunaimlimits();
  loopanim = asm::asm_getanim(asmname, statename);
  assert(isDefined(loopanim));
  loopxanim = asm::asm_getxanim(statename, loopanim);
  movedelta = getmovedelta(loopxanim);
  animmovedist = length2d(movedelta);
  assert(animmovedist > 0);

  if(!isDefined(startnode.wall_info.mantleoffset) && self.wall_run_current_node_index == startnode.wall_info.nodeoffsets.size - 2) {
    exitanim = asm::asm_getanim(asmname, "\xb4)\xc3H\x1f\x93\x15'3~9\x0e\xeb");
    assert(isDefined(exitanim));
    exitxanim = asm::asm_getxanim("\xb4)\xc3H\x1f\x93\x15'3~9\x0e\xeb", exitanim);
    var_8375e71dcadc5438 = getnotetracktimes(exitxanim, "q\x15Ktr\xe1\x04\xad\xf5\xcc");
    assert(isDefined(var_8375e71dcadc5438) && var_8375e71dcadc5438.size > 0);
    exitanimlength = getanimlength(exitxanim);
    exitmovedelta = getmovedelta(exitxanim, 0, var_8375e71dcadc5438[0]);
    exitmovedist = length2d(exitmovedelta);
  } else {
    exitmovedist = 0;
  }

  assert(startnode.wall_info.nodeoffsets.size > self.wall_run_current_node_index + 1);
  delta = getwallnodeposition(startnode, self.wall_run_current_node_index + 1) - self.origin;
  desiredmovedist = length(delta);
  desiredmovedist -= exitmovedist;

  if(desiredmovedist < 0) {
    desiredmovedist = 0;
  }

  var_bca4e62504028814 = desiredmovedist / animmovedist;
  animlength = getanimlength(loopxanim);
  animtimeneeded = animlength * var_bca4e62504028814;
  thread senddelayedevent(asmname, statename, animtimeneeded, "\xb5\xbdj\x1e`\x95\xf0\n{8\x193,\xd0},\xea\xed", 1);
  desiredmovedir = vectorNormalize(delta);
  self orientmode("\x99\xb0\x1bV\x80\x19K'\xac\xc6:K\xdb\xdc", desiredmovedir);
  thread playwallrunendsound(statename);
  self animmode("b\xf21\xbc\xeb{");
  self aisetanim(statename, loopanim);
  asm::asm_playfacialanim(asmname, statename, loopxanim);
  asm::asm_donotetracks(asmname, statename);
}

function playwallrunendsound(statename) {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(soundexists("\x1c{\r\x90\xf6\xc8J\x06\x9ax\xeab\xc0\x90\"")) {
    self waittill("\xb5\xbdj\x1e`\x95\xf0\n{8\x193,\xd0},\xea\xed");
    self playSound("\x1c{\r\x90\xf6\xc8J\x06\x9ax\xeab\xc0\x90\"");
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
    alias += "\xaf\xc9\xd4\x86\xff\xea\x1b";
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
      alias += "\xac\xfa\xd4";
    } else {
      alias += "\xff\x112";
    }
  }

  jumpanim = asm::asm_lookupanimfromalias(statename, alias);
  return jumpanim;
}

function playwallrunexit(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  startnode = self.traversal_start_node;
  endpos = self getnegotiationendpos();
  assert(isDefined(startnode));
  assert(isDefined(endpos));
  assert(isDefined(startnode.wall_info));
  desiredangles = self.angles;
  var_4bc650a9f430ce51 = 1;
  animname = asm::asm_getanim(asmname, statename);
  groundtime = getnotetracktimes(animname, "<\x1cu\xbe@x");
  self function_fc623e800cdeade7();

  if(isDefined(groundtime) && groundtime.size > 0) {
    var_4bc650a9f430ce51 = groundtime[0];
  } else {
    var_1ee04b7dc120ef3 = getnotetracktimes(animname, "{W\x8b*m\xfc\x14$\x88\x9f\x1af\v\xad\xd8");

    if(isDefined(var_1ee04b7dc120ef3) && var_1ee04b7dc120ef3.size > 0) {
      var_4bc650a9f430ce51 = var_1ee04b7dc120ef3[0];
    } else {
      endjumptime = getnotetracktimes(animname, "\xf5\xfc\f\xafb\f-5");

      if(isDefined(endjumptime) && endjumptime.size > 0) {
        var_4bc650a9f430ce51 = endjumptime[0];
      }
    }
  }

  if(soundexists("\x1c{\r\x90\xf6\xc8J\x06\x9ax\xeab\xc0\x90\"")) {
    self playSound("\x1c{\r\x90\xf6\xc8J\x06\x9ax\xeab\xc0\x90\"");
  }

  playscaledjump(asmname, statename, animname, endpos, desiredangles, var_4bc650a9f430ce51, 1, 1);
  thread terminatewallruntraverse(asmname, statename);
}

function isnotdoingwallruntransition(asmname, statename, tostatename, params) {
  if(isDefined(self.traversal_start_node)) {
    return false;
  }

  if(getdvarint(@ "ai_debugwallrun", 0) != 0) {
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
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  startnode = self.traversal_start_node;
  endnodepos = self getnegotiationendpos();
  assert(isDefined(startnode));
  assert(isDefined(endnodepos));
  mantleendpos = getwallrunmantleposition(startnode);

  if(isDefined(startnode.wall_info.bvaultover) || getwallruntomantletype() == ":\xbfa^") {
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

  mantleanim = asm::asm_getanim(asmname, statename);
  assert(isDefined(mantleanim));
  animlength = getanimlength(mantleanim);
  var_810921b1b5b372af = getnotetracktimes(mantleanim, "\xe3@X\xbdxM\"\xdc\xe1/Z\x98");
  assert(var_810921b1b5b372af.size > 0);
  var_3c2e709385a4a006 = var_810921b1b5b372af[0];
  var_64916cc80b1fe9b0 = getnotetracktimes(mantleanim, "\xc9\x82\x9e'\xfa\x9c\a\xc7\xd8Q");
  assert(var_64916cc80b1fe9b0.size > 0);
  var_3bf453259c01054f = var_64916cc80b1fe9b0[0];
  var_2c71ac4f6b49ccb5 = getmovedelta(mantleanim, var_3c2e709385a4a006, var_3bf453259c01054f);
  self forceteleport(self.origin, mantleangles);
  var_7c17ce292168a15c = self localtoworldcoords(var_2c71ac4f6b49ccb5);
  actualdelta = var_7c17ce292168a15c - self.origin;
  mantlestartpos = mantleendpos - actualdelta;

  if(getdvarint(@ "ai_debugwallrun", 0) != 0) {
    function_6303270466e7657c(self.origin, mantlestartpos, (255, 0, 0), 100);
  }

  playscaledjump(asmname, statename, mantleanim, mantlestartpos, mantleangles, var_3c2e709385a4a006, 0, 1);
  thread terminatewallruntraverse(asmname, statename);
}

function playtraversaltransition(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  animid = asm::asm_getanim(asmname, statename);

  if(!isDefined(animid)) {
    asm::asm_fireevent(asmname, "f\x97\xb9`\xd1~\x80(\xca");
    return;
  }

  xanim = asm::asm_getxanim(statename, animid);
  animendtime = 1;
  notetracktimes = undefined;

  if(getdvarint(@ "hash_f13997d88562c7b5", 1) == 1) {
    notetracktimes = getnotetracktimes(xanim, "\tXd\xc6p");
  }

  if(!isDefined(notetracktimes) || notetracktimes.size == 0) {
    notetracktimes = getnotetracktimes(xanim, "f\x97\xb9`\xd1~\x80(\xca");
  }

  if(isDefined(notetracktimes) && notetracktimes.size > 0) {
    animendtime = notetracktimes[0];
  }

  stopdelta = getmovedelta(xanim, 0, animendtime);
  stopangledelta = getangledelta(xanim, 0, animendtime);
  negotiationnode = self.traversal_start_node;
  assert(isDefined(negotiationnode));

  if(getdvarint(@ "ai_debugwallrun", 0) != 0 && self.traversal_start_node.animscript == "<dev string:x1ab>") {
    thread draworigin();
    thread drawdebugline(negotiationnode.origin, (0, 0, 1), (1, 0, 0));
    thread debugwallrun(statename, self.traversal_start_node, self getnegotiationendpos());
  }

  anim_length = getanimlength(xanim) * animendtime;
  var_e8103c56b4dfc210 = int(ceil(anim_length * 20));

  if(self.traversal_start_node.animscript == "\xc1\xd5a\xe3Z\x85T\x01") {
    var_d4dc4d2fd0e078e7 = getwallnodeposition(self.traversal_start_node, 0) - self.origin;
    var_1084b4c0497f2c00 = vectortoangles(var_d4dc4d2fd0e078e7);
    desiredyaw = var_1084b4c0497f2c00[1];
  } else {
    desireddelta = self getnegotiationendpos() - self.traversal_start_node.origin;
    desireddelta = (desireddelta[0], desireddelta[1], 0);
    desiredangles = vectortoangles(desireddelta);
    desiredyaw = desiredangles[1];
  }

  stopstartpos = cover::calcanimstartpos(negotiationnode.origin, desiredyaw, stopdelta, stopangledelta);
  arrivalyaw = desiredyaw - stopangledelta;
  self.a.arrivalasmstatename = statename;
  self.useanimgoalweight = 1;
  self startcoverarrival(stopstartpos, arrivalyaw, var_e8103c56b4dfc210);
  self aisetanim(statename, animid);
  asm::asm_playfacialanim(asmname, statename, xanim);
  asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
}

function choosetraversaltransition(asmname, statename, params) {
  approachdir = anglesToForward(self.angles);
  approachangles = vectortoangles(approachdir);

  if(self.traversal_start_node.animscript == "\xc1\xd5a\xe3Z\x85T\x01") {
    desiredangles = vectortoangles(getwallnodeposition(self.traversal_start_node, 0) - self.origin);
  } else {
    desireddelta = self getnegotiationendpos() - self.traversal_start_node.origin;
    desireddelta = (desireddelta[0], desireddelta[1], 0);
    desiredangles = vectortoangles(desireddelta);
  }

  desiredyaw = desiredangles[1];
  anglediff = angleclamp180(desiredyaw - approachangles[1]);
  angleindex = getangleindex(anglediff, 22.5);
  stopanims = arrival::getstopanims(asmname, statename, undefined, 1);

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

  if(self.traversal_start_node.animscript == "\xc1\xd5a\xe3Z\x85T\x01") {
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
  stopanims = arrival::getstopanims(asmname, tostatename, undefined, 1);
  stopanim = stopanims[angleindex];

  if(!isDefined(stopanim)) {
    return false;
  }

  animendtime = 1;
  notetracktimes = undefined;

  if(getdvarint(@ "hash_f13997d88562c7b5", 1) == 1) {
    notetracktimes = getnotetracktimes(stopanim, "\tXd\xc6p");
  }

  if(!isDefined(notetracktimes) || notetracktimes.size == 0) {
    notetracktimes = getnotetracktimes(stopanim, "f\x97\xb9`\xd1~\x80(\xca");
  }

  if(isDefined(notetracktimes) && notetracktimes.size > 0) {
    animendtime = notetracktimes[0];
  }

  stopdelta = getmovedelta(stopanim, 0, animendtime);
  stopangledelta = getangledelta(stopanim, 0, animendtime);
  disttonode = distance2d(self.origin, self.traversal_start_node.origin);
  animstopdist = length(stopdelta);
  delta = disttonode - animstopdist;

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

  if(self.traversal_start_node.animscript == "\xc1\xd5a\xe3Z\x85T\x01") {
    self.wall_run_direction = traversal_direction;
  }

  return true;
}

function handlewallrunattachnotetrack(note) {
  if(note == "KZY\x8c4\xeb\x8d\x91\xb8\xc8Q\xce") {
    if(soundexists("\xc1\xfdsQ\x86\x87\xdc\xc1\xf4An\xb4\xbepxV\xe3")) {
      self playSound("\xc1\xfdsQ\x86\x87\xdc\xc1\xf4An\xb4\xbepxV\xe3");
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
  self notify("<dev string:x1b7>");
  level endon("<dev string:x1cd>");
  self endon("<dev string:x1db>");
  level endon("<dev string:x1e4>");
  self endon("<dev string:x1b7>");
  lineend = pos + normal * 100;

  while(true) {
    line(pos, lineend, color, 1, 1, 1);
    wait 0.05;
  }
}

function function_6303270466e7657c(from, to, color, duration) {
  if(!isDefined(duration)) {
    duration = 5;
  }

  line(from, to, color, 1, 1, duration);
}

function draworigin() {
  self notify("<dev string:x1f4>");
  level endon("<dev string:x1cd>");
  self endon("<dev string:x1db>");
  level endon("<dev string:x1e4>");
  self endon("<dev string:x1f4>");
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
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self aisetisonladder(1);
  startnode = self getnegotiationstartnode();
  endpos = self getnegotiationendpos();
  assert(isDefined(startnode));
  self animmode("b\xf21\xbc\xeb{", 0);
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", startnode.angles[1]);
  starttoend = endpos - startnode.origin;
  demeanor = asm::asm_getdemeanor();
  climbanim = undefined;
  mountanim = undefined;
  dismountanim = undefined;
  dropdownanim = 0;

  if(starttoend[2] > 0) {
    offalias = "z<\xfd'" + demeanor;
    dismountanim = asm::asm_lookupanimfromaliasifexists(statename, offalias);

    if(!isDefined(dismountanim)) {
      if(!isDefined(startnode.traverse_drop_height_delta) || startnode.traverse_drop_height_delta < 6) {
        dismountanim = asm::asm_lookupanimfromalias(statename, "\xf8\x88m");
      } else if(startnode.traverse_drop_height_delta < 36) {
        dismountanim = asm::asm_lookupanimfromalias(statename, "\xde\x99f\xfal{\xdd");
        dropdownanim = 1;
      } else if(startnode.traverse_drop_height_delta < 60) {
        dismountanim = asm::asm_lookupanimfromalias(statename, "7\xcbs\x9dX\xe9\x05");
        dropdownanim = 1;
      } else {
        dismountanim = asm::asm_lookupanimfromalias(statename, "\r\\c\x1a\x83\x16\\s");
        dropdownanim = 1;
      }
    }

    climbanim = asm::asm_lookupanimfromalias(statename, "\xf3\xf2");
  } else {
    onalias = "q@\r" + demeanor;
    dismountanim = asm::asm_lookupanimfromaliasifexists(statename, onalias);

    if(!isDefined(dismountanim)) {
      mountanim = asm::asm_lookupanimfromalias(statename, "\xb8\"");
    }

    climbanim = asm::asm_lookupanimfromalias(statename, "\x7f5\xe8e");
  }

  rate = 1;

  if(isDefined(self.moveplaybackrate)) {
    rate = self.moveplaybackrate;
  }

  if(isDefined(mountanim)) {
    self aisetanim(statename, mountanim, rate);
    asm::asm_donotetracks(asmname, statename);
  }

  loopendpos = endpos;

  if(isDefined(dismountanim)) {
    dismountxanim = asm::asm_getxanim(statename, dismountanim);
    dismounttranslation = getmovedelta(dismountxanim);

    if(dropdownanim) {
      loopendpos = startnode.traverse_height - (0, 0, 48);
    } else {
      loopendpos = endpos - dismounttranslation + (0, 0, 1);
    }
  }

  assert(isDefined(climbanim));
  var_686500c85ed80f58 = loopendpos - self.origin;

  if(var_686500c85ed80f58[2] * starttoend[2] > 0) {
    climbxanim = asm::asm_getxanim(statename, climbanim);
    climbanimtranslation = getmovedelta(climbxanim);
    var_12e3e2c096eb7547 = climbanimtranslation[2] * rate / getanimlength(climbxanim);
    climbtime = var_686500c85ed80f58[2] / var_12e3e2c096eb7547;
    assert(climbtime > 0);

    if(!(isDefined(var_12e3e2c096eb7547) && isDefined(climbanimtranslation) && isDefined(climbxanim) && isDefined(climbtime))) {
      arcname = utility::function_bc2028f16daab4cc();
      basearcname = self.basearchetype;
      println("<dev string:x20a>" + climbanim + "<dev string:x231>" + arcname + "<dev string:x245>" + statename + "<dev string:x253>" + basearcname + "<dev string:x276>");
    }

    self aisetanim(statename, climbanim, rate);
    asm::asm_donotetracksfortime(asmname, statename, climbtime);
  }

  if(isDefined(dismountanim)) {
    self aisetanim(statename, dismountanim, rate);
    waitframe();
    notetrackhandle = &handletraversewarpnotetracks;
    self.traversestartnode = startnode;
    self.traverseendnode = self getnegotiationendnode();
    self.var_cc8e422b7d399125 = endpos;
    self.traversexanim = asm::asm_getxanim(statename, dismountanim);
    asm::asm_donotetracks(asmname, statename, notetrackhandle);
    self.var_cc8e422b7d399125 = undefined;
  }

  terminatetraverse(asmname, statename);
}

function terminate_ladder(asmname, statename, params) {
  bisdead = !isalive(self);
  self.nogravityragdoll = bisdead;
  self aisetisonladder(0);
  self.var_cc8e422b7d399125 = undefined;

  if(bisdead) {
    self.forceragdollimmediate = 0;
  }
}

function traverse_basic(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  traverseanim = asm::asm_getanim(asmname, statename);
  self animmode("b\xf21\xbc\xeb{", 0);
  startnode = self getnegotiationstartnode();
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", startnode.angles[1]);
  self aisetanim(statename, traverseanim);
  asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
  terminatetraverse(asmname, statename);
}