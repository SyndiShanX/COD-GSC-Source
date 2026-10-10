/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\asm\soldier\cover.gsc
***********************************************/

#using scripts\anim\notetracks;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\script_funcs;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace cover;

function shouldcoverexpose() {
  return bb_getrequestedcoverstate() == "exposed" && isDefined(self.enemy) && isDefined(self.node);
}

function shouldcoverexposedreload(asmname, statename, tostatename, params) {
  if(isDefined(self.covernode) && self.balwayscoverexposed) {
    return bb_reloadrequested();
  }

  return 0;
}

function calcanimstartpos(stoppos, stopangle, animdelta, var_f73bea4534a3831f) {
  dangle = stopangle - var_f73bea4534a3831f;
  angles = (0, dangle, 0);
  worlddelta = rotatevector(animdelta, angles);
  return stoppos - worlddelta;
}

function ishighnode(node) {
  if(!isDefined(node)) {
    return false;
  }

  if(node isvalidpeekoutdir("over")) {
    return false;
  }

  return true;
}

function start_conceal_add(statename, anime, waittime) {
  self endon(statename + "_finished");
  waittime = max(waittime, 0.05);
  wait waittime;
  self setanim(anime, 1, 0.4, 1, 1);
  thread conceal_add_cleanup(statename);
}

function transitionedfromrun(asmname) {
  prevstate = self asmgetstatetransitioningfrom(asmname);

  if(isDefined(prevstate)) {
    if(prevstate == "stand_run_loop") {
      return true;
    } else if(actor_is3d() && prevstate == "stand_run_strafe_loop") {
      return true;
    }
  }

  return false;
}

function playcoveranimloop3d(asmname, statename, params) {
  if(!isDefined(self.asm.lastcovernode)) {
    var_9f34b86d9ac843f4 = [scripts\asm\asm_bb::bb_getcovernode(), self.node];

    for(i = 0; !isDefined(self.asm.lastcovernode) && i < var_9f34b86d9ac843f4.size; i++) {
      if(isDefined(var_9f34b86d9ac843f4[i]) && distancesquared(self.origin, var_9f34b86d9ac843f4[i].origin) < 256) {
        self.asm.lastcovernode = var_9f34b86d9ac843f4[i];
      }
    }
  }

  if(isDefined(self.asm.lastcovernode)) {
    if(statename == "<dev string:x1c>" && !nodeiscoverexposed3dtype(self.asm.lastcovernode)) {
      assertmsg("<dev string:x2d>" + getnodetypename(self.asm.lastcovernode));
    } else if(statename == "<dev string:x8a>" && !nodeiscoverstand3dtype(self.asm.lastcovernode)) {
      assertmsg("<dev string:x99>" + getnodetypename(self.asm.lastcovernode));
    }
  }

  playcoveranimloop(asmname, statename, params);
}

function playcoveranimloop(asmname, statename, params) {
  self.keepclaimednodeifvalid = 1;

  if(isDefined(params)) {
    if(params == "stickToNode") {
      covernode = scripts\asm\asm_bb::bb_getcovernode();

      if(isDefined(covernode)) {
        if(distancesquared(covernode.origin, self.origin) < 16) {
          self safeteleport(covernode.origin);
        } else {
          thread lerpto(covernode, 4, statename + "_finished");
        }
      }

      self.keepclaimednodeifvalid = 0;

      if(transitionedfromrun(asmname)) {
        self setuseanimgoalweight(0.2);
      }
    }
  }

  if(!isagent(self)) {
    animindex = archetypegetrandomalias(self.animsetname, statename, "conceal_add", 0);
    covernode = bb_getcovernode();

    if(isDefined(animindex) && isDefined(covernode) && (covernode.type == "Conceal Crouch" || covernode.type == "Conceal Stand")) {
      concealanim = asm_getxanim(statename, animindex);
      self setanim(concealanim, 1, 0.2, 1, 1);
      thread conceal_add_cleanup(statename);
    }
  }

  function_fb56c9527636713f(asmname, statename, 1);
}

function conceal_add_cleanup(statename) {
  self endon("death");
  self endon("entitydeleted");
  self notify("conceal_add_cleanup");
  self endon("conceal_add_cleanup");
  self waittill(statename + "_finished");

  if(archetypehasstate(self.animsetname, "knobs")) {
    anime = archetypegetalias(self.animsetname, "knobs", "conceal_add", 0);

    if(isDefined(anime)) {
      self clearanim(anime.anims, 0.4);
    }
  }
}

function lerpto(covernode, var_2f841227a5cdde35, endonstr) {
  self endon(endonstr);

  while(true) {
    metodest = covernode.origin - self.origin;
    var_28660e5725a496a2 = length(metodest);

    if(var_28660e5725a496a2 < var_2f841227a5cdde35) {
      self safeteleport(covernode.origin);
      break;
    }

    metodest /= var_28660e5725a496a2;
    dest = self.origin + metodest * var_2f841227a5cdde35;
    self safeteleport(dest);
    wait 0.05;
  }
}

function terminatecoverreload(asmname, statename, params) {
  asm_fireephemeralevent("reload", "end");
  self function_4ea7891f787c6725();
  scripts\asm\soldier\script_funcs::reload_cleanup(asmname, statename, params);
}

function playcoveranim_droprpg(asmname, statename, params) {
  self.keepclaimednodeifvalid = 1;
  myanim = asm_getanim(asmname, statename);
  myxanim = asm_getxanim(statename, myanim);
  self orientmode("face current");
  self aisetanim(statename, myanim);
  asm_playfacialanim(asmname, statename, myxanim);
  asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename));
}

function playshuffleloop(asmname, statename, params) {
  var_946cbac627c6d79d = [];
  var_946cbac627c6d79d["crouch_shuffle_right"] = -90;
  var_946cbac627c6d79d["crouch_shuffle_left"] = 90;
  var_946cbac627c6d79d["stand_shuffle_right"] = -90;
  var_946cbac627c6d79d["stand_shuffle_left"] = 90;
  self endon(statename + "_finished");
  shuffleanim = asm_getanim(asmname, statename);
  shufflexanim = asm_getxanim(statename, shuffleanim);
  self aisetanim(statename, shuffleanim);
  asm_playfacialanim(asmname, statename, shufflexanim);

  if(isDefined(self._blackboard.shufflenode)) {
    faceangle = self._blackboard.shufflenode.angles[1];
  } else if(isDefined(self.node)) {
    faceangle = self.node.angles[1];
  } else {
    faceangle = self.angles[1];
  }

  if(self.unittype != "c6" && isDefined(var_946cbac627c6d79d[statename])) {
    faceangle += var_946cbac627c6d79d[statename];
  }

  self orientmode("face angle", faceangle);
  asm_donotetracks(asmname, statename);
}

function shouldplayshuffleenter(asmname, statename, tostatename, params) {
  assert(isDefined(self._blackboard.shufflenode));
  enteranim = asm_getrandomanim(asmname, tostatename);
  enterxanim = asm_getxanim(tostatename, enteranim);
  entertranslation = getmovedelta(enterxanim);
  enterdistsq = lengthsquared(entertranslation);
  disttogoalsq = distancesquared(self.origin, self._blackboard.shufflenode.origin);
  return enterdistsq <= disttogoalsq + 1;
}

function abortshufflecleanup(asmname, statename, params) {
  self._blackboard.shufflenode = undefined;
}

function shouldbeginshuffleexit(asmname, statename, tostatename, params) {
  assert(isDefined(self._blackboard.shufflenode));
  assert(isDefined(self.node));
  assert(self.node == self._blackboard.shufflenode);
  shufflefromnode = self.prevcovernode;

  if(!isDefined(shufflefromnode)) {
    shufflefromnode = self.covernode;
  }

  assert(isDefined(shufflefromnode));
  nodetype = self._blackboard.shufflenode.type;

  if(isDefined(nodetype) && (nodetype == "Cover Crouch" || nodetype == "Cover Crouch Window" || nodetype == "Conceal Crouch")) {
    dvarvalue = getDvar(@ "hash_f72dde9792b94cc9");

    if(isDefined(self.node.covercrouchtype)) {
      nodetype = self.node.covercrouchtype;
    } else if(dvarvalue != "") {
      nodetype = dvarvalue;
    }
  }

  if(isDefined(params) && nodetype != params) {
    return false;
  }

  exitanim = asm_getrandomanim(asmname, tostatename);
  exitxanim = asm_getxanim(statename, exitanim);
  goaldelta = self._blackboard.shufflenode.origin - self.origin;
  goaldir = vectorNormalize(goaldelta);
  exitmovedelta = getmovedelta(exitxanim, 0, 1);
  exitdist = length(exitmovedelta);
  goalpos = self._blackboard.shufflenode.origin - goaldir * exitdist;
  goaldelta = goalpos - self.origin;
  shuffledelta = self._blackboard.shufflenode.origin - shufflefromnode.origin;
  shuffledelta = (shuffledelta[0], shuffledelta[1], 0);

  if(vectordot(shuffledelta, goaldelta) <= 0) {
    return true;
  }

  if(length2dsquared(self.velocity) > 1 && vectordot(goaldir, self.velocity) <= 0) {
    return true;
  }

  return false;
}

function playshuffleanim_arrival(asmname, statename, params) {
  self.a.arrivalasmstatename = statename;
  arrivalanim = asm_getanim(asmname, statename);
  arrivalxanim = asm_getxanim(statename, arrivalanim);
  self aisetanim(statename, arrivalanim);
  asm_playfacialanim(asmname, statename, arrivalxanim);
  animtranslation = getmovedelta(arrivalxanim);
  animrotation = getangledelta3d(arrivalxanim);

  if(isDefined(self._blackboard.shufflenode)) {
    node = self._blackboard.shufflenode;
  } else {
    node = self.node;
  }

  if(isDefined(node)) {
    desiredendpos = node.origin;
    desiredendangles = (0, getnodeforwardyaw(node), 0);
    desiredstartangles = combineangles(desiredendangles, invertangles(animrotation));
    desiredstartpos = node.origin - rotatevector(animtranslation, desiredstartangles);
  } else {
    desiredendpos = self.origin + animtranslation;
    desiredendangles = combineangles(self.angles, animrotation);
    desiredstartpos = self.origin;
    desiredstartangles = self.angles;
  }

  warpduration = int(1000 * getanimlength(arrivalxanim) - 200);
  self startcoverarrival();
  self motionwarpwithanim(desiredstartpos, desiredstartangles, desiredendpos, desiredendangles, warpduration);
  asm_donotetracks(asmname, statename);
}

function playshuffleanim_terminate(asmname, statename, params) {
  self._blackboard.shufflenode = undefined;
  self._blackboard.shufflefromnode = undefined;
  self finishcoverarrival();
}

function coverreloadnotetrackhandler(note) {
  scripts\anim\notetracks::notetrack_prefix_handler(note);
  return undefined;
}

function cover3dpickexposedir(asmname, statename, tostatename, params) {
  assert(isDefined(self.enemy));
  assert(isDefined(self.node));
  assert(self.node.type == "<dev string:xf2>");
  self.bt.cover3dexposedirpicked = undefined;
  enemyeye = (self.enemy.origin + getenemyeyepos()) / 2;
  current_state = anim.asm[asmname].states[tostatename];
  random_transitions = array_randomize(current_state.transitions);
  dir_picked = undefined;

  foreach(transition in random_transitions) {
    assert(isDefined(transition.shouldtransitionparams));
    dir_picked = transition.shouldtransitionparams;

    if(dir_picked == "up") {
      break;
    }

    nodeoffset = getcover3dnodeoffset(self.node, dir_picked);
    nodelookfrompoint = self.node.origin + nodeoffset;

    if(sighttracepassed(nodelookfrompoint, enemyeye, 0, undefined)) {
      break;
    }
  }

  assert(isDefined(dir_picked));
  self.bt.cover3dexposedirpicked = asmname + "_" + tostatename + "_" + dir_picked;
  return true;
}

function cover3dcanexposedir(asmname, statename, tostatename, params) {
  var_b045478fad8648fe = asmname + "_" + statename + "_" + params;
  return var_b045478fad8648fe == self.bt.cover3dexposedirpicked;
}

function checkcovermultichangerequest(asmname, statename, tostatename, params) {
  if(!bb_iscovermultiswitchrequested()) {
    return false;
  }

  covernode = scripts\asm\asm_bb::bb_getcovernode();
  assert(isDefined(covernode));
  requestednodetype = bb_getrequestedcovermultiswitchnodetype();

  if(requestednodetype != params) {
    return false;
  }

  assert(!isDefined(self.asm.covermultiswitchdata));
  self.asm.covermultiswitchdata = spawnStruct();
  self.asm.covermultiswitchdata.requestednode = covernode;
  self.asm.covermultiswitchdata.requestednodetype = requestednodetype;
  return true;
}

function finishcovermultichangerequest(asmname, statename, params) {
  assert(isDefined(self.asm.covermultiswitchdata));
  requestednodetype = self.asm.covermultiswitchdata.requestednodetype;
  self.asm.covermultiswitchdata.requestednode setcovermultinodetype(requestednodetype);
  self.asm.covermultiswitchdata = undefined;
  self function_4ea7891f787c6725();
}