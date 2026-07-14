/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\cover.gsc
*****************************************/

#using scripts\anim\notetracks;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\script_funcs;
#using scripts\engine\utility;
#namespace cover;

function shouldcoverexpose() {
  return asm_bb::bb_getrequestedcoverstate() == "\xff\xd5d'hTb" && isDefined(self.enemy) && isDefined(self.node);
}

function shouldcoverexposedreload(asmname, statename, tostatename, params) {
  if(isDefined(self.covernode) && self.balwayscoverexposed) {
    return asm_bb::bb_reloadrequested();
  }

  return 0;
}

function calcanimstartpos(stoppos, stopangle, animdelta, animangledelta) {
  dangle = stopangle - animangledelta;
  angles = (0, dangle, 0);
  worlddelta = rotatevector(animdelta, angles);
  return stoppos - worlddelta;
}

function ishighnode(node) {
  if(!isDefined(node)) {
    return false;
  }

  if(node utility::isvalidpeekoutdir("W\x8eQ\xb7")) {
    return false;
  }

  return true;
}

function start_conceal_add(statename, anime, waittime) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  waittime = max(waittime, 0.05);
  wait waittime;
  self setanim(anime, 1, 0.4, 1, 1);
  thread conceal_add_cleanup(statename);
}

function transitionedfromrun(asmname) {
  prevstate = self asmgetstatetransitioningfrom(asmname);

  if(isDefined(prevstate)) {
    if(prevstate == "\x0f\x18~g\x8d#\x14t\xa4:R\xd6Yl") {
      return true;
    } else if(utility::actor_is3d() && prevstate == "o\xb0\xbf&\xb2\x12O\xccT\x1f\xf1U\xb1\xee\\\x11k>\xd0\xa3\xa4") {
      return true;
    }
  }

  return false;
}

function playcoveranimloop3d(asmname, statename, params) {
  if(!isDefined(self.asm.lastcovernode)) {
    var_5d5ba7cd0e3e1c4d = [asm_bb::bb_getcovernode(), self.node];

    for(i = 0; !isDefined(self.asm.lastcovernode) && i < var_5d5ba7cd0e3e1c4d.size; i++) {
      if(isDefined(var_5d5ba7cd0e3e1c4d[i]) && distancesquared(self.origin, var_5d5ba7cd0e3e1c4d[i].origin) < 256) {
        self.asm.lastcovernode = var_5d5ba7cd0e3e1c4d[i];
      }
    }
  }

  if(isDefined(self.asm.lastcovernode)) {
    if(statename == "<dev string:x24>" && !utility::nodeiscoverexposed3dtype(self.asm.lastcovernode)) {
      assertmsg("<dev string:x35>" + utility::getnodetypename(self.asm.lastcovernode));
    } else if(statename == "<dev string:x92>" && !utility::nodeiscoverstand3dtype(self.asm.lastcovernode)) {
      assertmsg("<dev string:xa1>" + utility::getnodetypename(self.asm.lastcovernode));
    }
  }

  playcoveranimloop(asmname, statename, params);
}

function playcoveranimloop(asmname, statename, params) {
  self.keepclaimednodeifvalid = 1;

  if(isDefined(params)) {
    if(params == "7\x8eZ\xb1\xadQ\xb7'o#\xb2") {
      covernode = asm_bb::bb_getcovernode();

      if(isDefined(covernode)) {
        if(distancesquared(covernode.origin, self.origin) < 16) {
          self safeteleport(covernode.origin);
        } else {
          thread lerpto(covernode, 4, statename + "\x1b\xe0K\x01;P\xfdf\x98");
        }
      }

      self.keepclaimednodeifvalid = 0;

      if(transitionedfromrun(asmname)) {
        self setuseanimgoalweight(0.2);
      }
    }
  }

  if(!isagent(self)) {
    animindex = archetypegetrandomalias(self.animsetname, statename, "k\x8b\xaf\xc7\xf3\xc0\x8a~\xd1{>", 0);
    covernode = asm_bb::bb_getcovernode();

    if(isDefined(animindex) && isDefined(covernode) && (covernode.type == "}\xdf+\xcd\xe0@_-\xa3q\xcfpq\xa2" || covernode.type == "\xff\x17\xedh\xdd\xef\xa2Y?\v\xc77\b")) {
      concealanim = asm::asm_getxanim(statename, animindex);
      self setanim(concealanim, 1, 0.2, 1, 1);
      thread conceal_add_cleanup(statename);
    }
  }

  asm::function_1be97a4513bb86d2(asmname, statename, 1);
}

function conceal_add_cleanup(statename) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self notify("%\xde\x1e\x96\x10=0y?\xc9}\xac\xcb\xd9`\x05|h0");
  self endon("%\xde\x1e\x96\x10=0y?\xc9}\xac\xcb\xd9`\x05|h0");
  self waittill(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  if(archetypehasstate(self.animsetname, "?\xd3b\x8e/")) {
    anime = archetypegetalias(self.animsetname, "?\xd3b\x8e/", "k\x8b\xaf\xc7\xf3\xc0\x8a~\xd1{>", 0);

    if(isDefined(anime)) {
      self clearanim(anime.anims, 0.4);
    }
  }
}

function lerpto(covernode, var_3f4472028d80adf8, endonstr) {
  self endon(endonstr);

  while(true) {
    metodest = covernode.origin - self.origin;
    distmetodest = length(metodest);

    if(distmetodest < var_3f4472028d80adf8) {
      self safeteleport(covernode.origin);
      break;
    }

    metodest /= distmetodest;
    dest = self.origin + metodest * var_3f4472028d80adf8;
    self safeteleport(dest);
    wait 0.05;
  }
}

function terminatecoverreload(asmname, statename, params) {
  asm::asm_fireephemeralevent("\xc9\xca\x1boX\x8c", "8\xdb\x90");
  self function_f236fce679635a48();
  namespace_ad29b7c653247c74::reload_cleanup(asmname, statename, params);
}

function playcoveranim_droprpg(asmname, statename, params) {
  self.keepclaimednodeifvalid = 1;
  myanim = asm::asm_getanim(asmname, statename);
  myxanim = asm::asm_getxanim(statename, myanim);
  self orientmode("\x99\xc2l\xb2\x806\xbaNN\x95\xb9\xa3");
  self aisetanim(statename, myanim);
  asm::asm_playfacialanim(asmname, statename, myxanim);
  asm::asm_donotetracks(asmname, statename, asm::asm_getnotehandler(asmname, statename));
}

function playshuffleloop(asmname, statename, params) {
  var_6510a07a5e5b45ac = [];
  var_6510a07a5e5b45ac["\xdf\xf6\x96\xb4\"U\xdfWa\x8bH(\xe6\xb2\xa0\xfd\xcb\xd8\x88\x96"] = -90;
  var_6510a07a5e5b45ac["\x1b9\xbd\xab\xd8\r\xeb\xdc\r]3f\xc6\xca\xd7\xc6V\xcc\xd1"] = 90;
  var_6510a07a5e5b45ac["`P\xf6\x1f\xe9\x84\xa2\xf5\x1d\n\r\xd9\xc7\x170P \xf0F"] = -90;
  var_6510a07a5e5b45ac["\x87\xb9\xb0\xac\xed\xf3\x93\x8c\x929\xc3]8\xfb\x1e\xfa\x1cQ"] = 90;
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  shuffleanim = asm::asm_getanim(asmname, statename);
  shufflexanim = asm::asm_getxanim(statename, shuffleanim);
  self aisetanim(statename, shuffleanim);
  asm::asm_playfacialanim(asmname, statename, shufflexanim);

  if(isDefined(self._blackboard.shufflenode)) {
    faceangle = self._blackboard.shufflenode.angles[1];
  } else if(isDefined(self.node)) {
    faceangle = self.node.angles[1];
  } else {
    faceangle = self.angles[1];
  }

  if(self.unittype != "\xdf~" && isDefined(var_6510a07a5e5b45ac[statename])) {
    faceangle += var_6510a07a5e5b45ac[statename];
  }

  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", faceangle);
  asm::asm_donotetracks(asmname, statename);
}

function shouldplayshuffleenter(asmname, statename, tostatename, params) {
  assert(isDefined(self._blackboard.shufflenode));
  enteranim = asm::asm_getrandomanim(asmname, tostatename);
  enterxanim = asm::asm_getxanim(tostatename, enteranim);
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

  if(isDefined(nodetype) && (nodetype == "\xd2\xc8\xaf/\xf5\x1c\xdfs\xfes\x06\xce" || nodetype == "C\xed;\xcar\b\xa1r\xdb\xael\x1a\x04Wi\xcd2\xedw" || nodetype == "}\xdf+\xcd\xe0@_-\xa3q\xcfpq\xa2")) {
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

  exitanim = asm::asm_getrandomanim(asmname, tostatename);
  exitxanim = asm::asm_getxanim(statename, exitanim);
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
  arrivalanim = asm::asm_getanim(asmname, statename);
  arrivalxanim = asm::asm_getxanim(statename, arrivalanim);
  self aisetanim(statename, arrivalanim);
  asm::asm_playfacialanim(asmname, statename, arrivalxanim);
  animtranslation = getmovedelta(arrivalxanim);
  animrotation = getangledelta3d(arrivalxanim);

  if(isDefined(self._blackboard.shufflenode)) {
    node = self._blackboard.shufflenode;
  } else {
    node = self.node;
  }

  if(isDefined(node)) {
    desiredendpos = node.origin;
    desiredendangles = (0, utility::getnodeforwardyaw(node), 0);
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
  asm::asm_donotetracks(asmname, statename);
}

function playshuffleanim_terminate(asmname, statename, params) {
  self._blackboard.shufflenode = undefined;
  self._blackboard.shufflefromnode = undefined;
  self finishcoverarrival();
}

function coverreloadnotetrackhandler(note) {
  notetracks::notetrack_prefix_handler(note);
  return undefined;
}

function cover3dpickexposedir(asmname, statename, tostatename, params) {
  assert(isDefined(self.enemy));
  assert(isDefined(self.node));
  assert(self.node.type == "<dev string:xfa>");
  self.bt.cover3dexposedirpicked = undefined;
  enemyeye = (self.enemy.origin + utility_common::getenemyeyepos()) / 2;
  current_state = anim.asm[asmname].states[tostatename];
  random_transitions = utility::array_randomize(current_state.transitions);
  dir_picked = undefined;

  foreach(transition in random_transitions) {
    assert(isDefined(transition.shouldtransitionparams));
    dir_picked = transition.shouldtransitionparams;

    if(dir_picked == "\xf3\xf2") {
      break;
    }

    nodeoffset = utility_common::getcover3dnodeoffset(self.node, dir_picked);
    nodelookfrompoint = self.node.origin + nodeoffset;

    if(sighttracepassed(nodelookfrompoint, enemyeye, 0, undefined)) {
      break;
    }
  }

  assert(isDefined(dir_picked));
  self.bt.cover3dexposedirpicked = asmname + "w" + tostatename + "w" + dir_picked;
  return true;
}

function cover3dcanexposedir(asmname, statename, tostatename, params) {
  var_a5cf1a76e7a85073 = asmname + "w" + statename + "w" + params;
  return var_a5cf1a76e7a85073 == self.bt.cover3dexposedirpicked;
}

function checkcovermultichangerequest(asmname, statename, tostatename, params) {
  if(!asm_bb::bb_iscovermultiswitchrequested()) {
    return false;
  }

  covernode = asm_bb::bb_getcovernode();
  assert(isDefined(covernode));
  requestednodetype = asm_bb::bb_getrequestedcovermultiswitchnodetype();

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
  self function_f236fce679635a48();
}

function function_b1ce353221146a21() {
  if(isDefined(self.covernode)) {
    if(self.covernode.type == "\xcalv\xe9\xf1\xb1\x89\x96\x9d^#") {
      self.coverposerequest = "L)\x81\xfbpg6\xbd\xe0\xb04";
      return;
    }

    if(self.covernode.type == "\xd2\xc8\xaf/\xf5\x1c\xdfs\xfes\x06\xce" || self.covernode.type == "C\xed;\xcar\b\xa1r\xdb\xael\x1a\x04Wi\xcd2\xedw") {
      self.coverposerequest = "\x01f\xf6\xa5\xff\xb80W\x86\xe9\xb7\xe5";
      return;
    }

    if(self.covernode.type == "c\xb0\x14\xd5\xd9\xe4\xaf\x8d\x91}\xc2") {
      if(self.currentpose == "\x8b\x90\xb5\xc4W") {
        self.coverposerequest = "M\xd5\xd0\xd2\xc4\x99\xe2c\xfe=\x80";
      } else if(self.currentpose == "1x\xc5\xb4\xabx") {
        self.coverposerequest = "\x16\xc5\x94;\xbbk\x90;;\x90\xca\xe1\x0f\x17\xbe\xd6\x10\xf3";
      }

      return;
    }

    if(self.covernode.type == "g\x1fWv\xec\xec@P(o") {
      if(self.currentpose == "\x8b\x90\xb5\xc4W") {
        self.coverposerequest = "}ET\xc9\xe8\xbc&\xe5xD";
        return;
      }

      if(self.currentpose == "1x\xc5\xb4\xabx") {
        self.coverposerequest = "B\xfd\xf0g\x1b\xd9#.\xd5~9\x1e\x80%&\x05\xcd";
      }
    }
  }
}