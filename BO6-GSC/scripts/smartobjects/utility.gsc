/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\smartobjects\utility.gsc
********************************************/

#using scripts\asm\asm_bb;
#namespace utility;

function init_smartobjects() {
  if(isDefined(anim.smartobjects)) {
    return;
  }

  anim.smartobjects = [];
}

function validate() {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }

  foreach(point in anim.smartobjectpoints) {
    assert(isDefined(anim.smartobjects[point.script_smartobject]), "<dev string:x24>" + point.script_smartobject + "<dev string:x35>" + point.origin + "<dev string:x3e>");
  }
}

function add_smartobject_type(name, fngetinfo, fnusecondition) {
  init_smartobjects();
  assert(!isDefined(anim.smartobjects[name]));
  struct = spawnStruct();
  struct.fngetinfo = fngetinfo;
  struct.fnusecondition = fnusecondition;
  anim.smartobjects[name] = struct;
}

function createsmartobjectinfo() {
  info = spawnStruct();
  info.animlist = [];
  return info;
}

function addsmartobjectanim_internal(statename, alias) {
  if(!isDefined(self.animlist[statename])) {
    self.animlist[statename] = [];
  }

  self.animlist[statename] = alias;
}

function addsmartobjectintroanim(alias) {
  addsmartobjectanim_internal("j\x01{\x9b\xb4(\xd8{O\xf8c\xa7\x92\xcd%\xb2\xe5", alias);
  self.hasintro = 1;
}

function addsmartobjectanim(alias) {
  addsmartobjectanim_internal("\x05\x1cG\xf1\xa0J\x18E\xd3y\xec\xcf:n\xbe\xc1\x03", alias);
}

function addsmartobjectreactanim(alias) {
  if(isDefined(alias)) {
    addsmartobjectanim_internal("\x9602\xfdf\xef\x18\xd5\x84 O\t\x91\xb8\xfe:&", alias);
  }

  self.hasreact = 1;
}

function addsmartobjectoutroanim(alias) {
  addsmartobjectanim_internal("3\x97Q\xb7\xdeu\x06\xcbLx\x8e\xdd\x06\f\xd4\xe1\xce", alias);
  self.hasoutro = 1;
}

function addsmartobjectarrivalanims() {
  self.hasarrivals = 1;
}

function addsmartobjectexitanims() {
  self.hasexits = 1;
}

function addsmartobjectpainanim(alias) {
  if(isDefined(alias)) {
    addsmartobjectanim_internal("Y\xf5\x9c\x04zYI\x0e8\xac\x97\x9e+\x0e#o", alias);
  }

  self.haspain = 1;
}

function addsmartobjectdeathanim(alias) {
  if(isDefined(alias)) {
    addsmartobjectanim_internal("\\\x06\xce\x9fJX\x13\x84\x7f\x83G|en;\xd9\xcf", alias);
  }

  self.hasdeath = 1;
}

function getsmartobjecttype(name) {
  return anim.smartobjects[name];
}

function smartobject_setnextuse() {
  objtype = getsmartobjecttype(self.script_smartobject);
  info = self[[objtype.fngetinfo]]();

  if(isDefined(info.useonce)) {
    self.neveruseagain = 1;
    return;
  }

  nextusetime = gettime() + info.nextusetime * 1000;
  self.nextusetime = nextusetime;

  if(isDefined(self.linkedsmartobjects)) {
    foreach(obj in self.linkedsmartobjects) {
      if(isDefined(obj.nextusetime)) {
        obj.nextusetime = max(obj.nextusetime, nextusetime);
        continue;
      }

      obj.nextusetime = nextusetime;
    }
  }
}

function claimsmartobject(obj) {
  assert(!isDefined(obj.claimer) || obj.claimer == self, "<dev string:x53>");
  obj.claimer = self;
}

function unclaimsmartobject(obj) {
  assert(!isDefined(obj.claimer) || obj.claimer == self, "<dev string:x83>");
  obj.claimer = undefined;
}

function canclaimsmartobject(obj) {
  return !isDefined(obj.claimer);
}

function canusesmartobject(obj) {
  if(istrue(obj.donotuse)) {
    return 0;
  }

  if(isDefined(obj.neveruseagain)) {
    return 0;
  }

  if(isDefined(obj.nextusetime) && gettime() < obj.nextusetime) {
    return 0;
  }

  objbp = getsmartobjecttype(obj.script_smartobject);
  result = [[objbp.fnusecondition]](obj);
  return result;
}

function getbestsmartobject(desiredpos, volume, var_934e3269e9c2e413) {
  if(!isDefined(anim.smartobjectpoints)) {
    return undefined;
  }

  var_bac1158f986fb6bb = var_934e3269e9c2e413 * var_934e3269e9c2e413;
  allsmartobjects = sortbydistance(anim.smartobjectpoints, desiredpos);
  numsmartobjects = allsmartobjects.size;

  for(iobj = 0; iobj < numsmartobjects; iobj++) {
    object = allsmartobjects[iobj];

    if(distancesquared(object.origin, desiredpos) > var_bac1158f986fb6bb) {
      break;
    }

    if(!canclaimsmartobject(object)) {
      continue;
    }

    if(!canusesmartobject(object)) {
      continue;
    }

    if(!issmartobjectwithinrange(object, desiredpos, volume)) {
      continue;
    }

    objbp = getsmartobjecttype(object.script_smartobject);

    if([[objbp.fnusecondition]](object)) {
      return object;
    }
  }

  return undefined;
}

function isplayernearsmartobject(obj) {
  radiussq = 1600;
  zdiffsq = 4096;

  foreach(player in level.players) {
    if(distance2dsquared(obj.origin, player.origin) < radiussq && squared(obj.origin[2] - player.origin[2]) < zdiffsq) {
      objtoplayeryaw = vectortoyaw(player.origin - obj.origin);

      if(abs(angleclamp180(objtoplayeryaw - obj.angles[1])) < 90) {
        return true;
      }
    }
  }

  return false;
}

function getbestsmartobjectalongline(startpos, endpos, region, volume, var_db180d10e6b850c2, var_49e20a41eafac281, var_b5e139637404021) {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }

  var_46993686cedee9a0 = 60;
  clineheight = 60;
  var_611e667dbac289bb = 5184;
  var_c85d52cd81ec7302 = 48;

  if(isDefined(region.volume.script_radius)) {
    var_c85d52cd81ec7302 = region.volume.script_radius;
  }

  var_5a2532f938c04349 = 128;

  if(isDefined(region.volume.script_maxdist)) {
    var_5a2532f938c04349 = region.volume.script_maxdist;
  }

  starttoend = endpos - startpos;
  linelen = length(starttoend);
  starttoenddir = starttoend / linelen;
  starttoendnormal = vectorNormalize((starttoenddir[1], -1 * starttoenddir[0], 0));
  bdrawdebug = 0;
  drawtime = undefined;

  drawtime = 40;
  bdrawdebug = getdvarint(@ "hash_e24fb561372dfef1", -1) == self getentitynumber();

  if(bdrawdebug) {
    line(startpos + (0, 0, 6), endpos + (0, 0, 6), (0, 0.5, 0.7), 1, 0, drawtime);
  }

  var_5187ddf8db476ca5 = 60;
  var_77e45e8413841ff8 = 5;
  var_532c8402ee2cf6f4 = 0.33;
  var_c7c92d8342fc3b01 = 1.5;
  var_bc09a96376541cd7 = 300000;
  var_a034bc8b186c20c = 0.001;
  bestobj = undefined;
  bestobjscore = -9999;

  foreach(obj in region.smart_objects) {
    if(distancesquared(obj.origin, self.origin) < var_611e667dbac289bb) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xb8>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    if(!canclaimsmartobject(obj)) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xbf>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    if(!istrue(var_b5e139637404021) && !canusesmartobject(obj)) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xc6>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    var_40335c7353f1ca66 = obj.origin - startpos;
    distdownline = vectordot(starttoenddir, var_40335c7353f1ca66);

    if(distdownline < var_db180d10e6b850c2) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xce>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    if(distdownline > linelen + var_46993686cedee9a0) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xd5>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    distfromline = abs(vectordot(starttoendnormal, var_40335c7353f1ca66));
    objradiussq = getsmartobjectradiussq(obj);

    if(distfromline * distfromline > objradiussq) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xdc>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    var_67e9184cad4f3d5c = var_5a2532f938c04349;

    if(linelen - distfromline < 60) {
      var_67e9184cad4f3d5c *= 0.5;
    }

    if(distfromline > var_67e9184cad4f3d5c) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xe1>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    if(isDefined(volume) && !ispointinvolume(obj.origin, volume)) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:xe8>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    objbp = getsmartobjecttype(obj.script_smartobject);
    adjustedlinelen = linelen - var_db180d10e6b850c2;
    var_257cb35498a09d58 = distdownline - var_db180d10e6b850c2;
    var_820756cd53ccdc1f = var_49e20a41eafac281 - var_db180d10e6b850c2;

    if(var_257cb35498a09d58 < var_820756cd53ccdc1f) {
      score = var_77e45e8413841ff8 + var_5187ddf8db476ca5 * (1 - (var_820756cd53ccdc1f - var_257cb35498a09d58) / var_820756cd53ccdc1f);
    } else {
      adjustedlinelen = linelen - var_49e20a41eafac281 + var_46993686cedee9a0;
      var_257cb35498a09d58 = distdownline - var_49e20a41eafac281;
      score = var_77e45e8413841ff8 + var_5187ddf8db476ca5 * (adjustedlinelen - var_257cb35498a09d58) / adjustedlinelen;
    }

    if(distfromline > var_c85d52cd81ec7302) {
      distfrompreferred = distfromline - var_c85d52cd81ec7302;
      score *= var_532c8402ee2cf6f4 + (1 - distfrompreferred / (var_67e9184cad4f3d5c - var_c85d52cd81ec7302)) * (1 - var_532c8402ee2cf6f4);
    }

    if(isplayernearsmartobject(obj)) {
      score *= var_c7c92d8342fc3b01;

      if(bdrawdebug) {
        print3d(obj.origin + (0, 0, 20), "<dev string:xf0>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }
    }

    objinfo = obj[[objbp.fngetinfo]]();

    if(isDefined(objinfo.fngetprioritymultiplier)) {
      score *= self[[objinfo.fngetprioritymultiplier]](obj);
    }

    if(isDefined(obj.lastusetime)) {
      if(gettime() - obj.lastusetime < var_bc09a96376541cd7) {
        score *= var_a034bc8b186c20c;
      } else {
        obj.lastusetime = undefined;
      }
    }

    if(score > bestobjscore) {
      bestobjscore = score;
      bestobj = obj;
    }

    if(bdrawdebug) {
      orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.8, 0.8, 0), 0, drawtime);
      print3d(obj.origin + (0, 0, 24), "<dev string:xf5>" + score, (0.5, 0.5, 0.5), 1, 0.2, drawtime);
    }
  }

  return bestobj;
}

function getsmartobjectradiussq(obj) {
  if(isDefined(obj.radius)) {
    return (obj.radius * obj.radius);
  }

  objtype = anim.smartobjects[obj.script_smartobject];
  objinfo = [[objtype.fngetinfo]]();

  if(isDefined(objinfo.radius)) {
    return (objinfo.radius * objinfo.radius);
  }

  assert(isDefined(objinfo.radiussqrd));
  return objinfo.radiussqrd;
}

function issmartobjectwithinrange(object, optorigin, volume) {
  if(isDefined(optorigin)) {
    pos = optorigin;
  } else {
    pos = self.origin;
  }

  distsqrd = distancesquared(pos, object.origin);

  if(isDefined(object.radius)) {
    if(distsqrd > squared(object.radius)) {
      return false;
    }
  } else {
    type = anim.smartobjects[object.script_smartobject];
    info = [[type.fngetinfo]]();

    if(distsqrd > info.radiussqrd) {
      return false;
    }
  }

  if(isDefined(volume) && !ispointinvolume(object.origin, volume)) {
    return false;
  }

  return true;
}

function setcustomsmartobjectarrivaldata(obj) {
  objbp = getsmartobjecttype(obj.script_smartobject);
  info = [[objbp.fngetinfo]]();

  if(!istrue(info.hasarrivals)) {
    return;
  }

  self.customarrivalangles = obj.angles;
  self.customarrivalstate = info.animstatename;
  self.var_ae2790476708dfb3 = 1;
  self.customarrivaloptionalprefix = "aN9\xd2vX6";
}

function setsmartobject(smartobj) {
  prevsmartobj = asm_bb::bb_getrequestedsmartobject();

  if(isDefined(prevsmartobj)) {
    clearsmartobject(prevsmartobj);
  }

  claimsmartobject(smartobj);
  asm_bb::bb_requestsmartobject(smartobj);
}

function clearsmartobject(smartobj) {
  if(isDefined(smartobj)) {
    unclaimsmartobject(smartobj);
  }

  asm_bb::bb_clearsmartobject();
}

function canusesmartobject_stealth(smartobj) {
  if(!isDefined(self.script_stealthgroup)) {
    return false;
  }

  if(![[self.fnisinstealthinvestigate]]() && ![[self.fnisinstealthhunt]]()) {
    return false;
  }

  if(isDefined(self.enemy)) {
    return false;
  }

  return true;
}

function canusesmartobject_nostrafenoturn(smartobj) {
  forward = anglesToForward(self.angles);
  normal = vectorNormalize(smartobj.origin - self.origin);

  if(vectordot(forward, normal) >= cos(60)) {
    strafedist = 64;
  } else {
    strafedist = 100;
  }

  if(distancesquared(self.origin, smartobj.origin) <= strafedist * strafedist) {
    return false;
  }

  forward = anglesToForward(smartobj.angles);

  if(vectordot(forward, normal) < cos(45)) {
    return false;
  }

  return true;
}