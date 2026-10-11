/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\smartobjects\utility.gsc
***********************************************/

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
    assertex(isDefined(anim.smartobjects[point.script_smartobject]), "SmartObject \"" + point.script_smartobject + "\" at " + point.origin + " is not precached");
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
  addsmartobjectanim_internal("smartobject_intro", alias);
  self.hasintro = 1;
}

function addsmartobjectanim(alias) {
  addsmartobjectanim_internal("smartobject_logic", alias);
}

function addsmartobjectreactanim(alias) {
  if(isDefined(alias)) {
    addsmartobjectanim_internal("smartobject_react", alias);
  }

  self.hasreact = 1;
}

function addsmartobjectoutroanim(alias) {
  addsmartobjectanim_internal("smartobject_outro", alias);
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
    addsmartobjectanim_internal("smartobject_pain", alias);
  }

  self.haspain = 1;
}

function addsmartobjectdeathanim(alias) {
  if(isDefined(alias)) {
    addsmartobjectanim_internal("smartobject_death", alias);
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
  assertex(!isDefined(obj.claimer) || obj.claimer == self, "smartobject already claimed by someone else.");
  obj.claimer = self;
}

function unclaimsmartobject(obj) {
  assertex(!isDefined(obj.claimer) || obj.claimer == self, "cannot clear claim on someone else's smartobject.");
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

function getbestsmartobject(desiredpos, volume, var_f34327e65116baaa) {
  if(!isDefined(anim.smartobjectpoints)) {
    return undefined;
  }

  var_b28bb506e83973be = var_f34327e65116baaa * var_f34327e65116baaa;
  allsmartobjects = sortbydistance(anim.smartobjectpoints, desiredpos);
  numsmartobjects = allsmartobjects.size;

  for(iobj = 0; iobj < numsmartobjects; iobj++) {
    object = allsmartobjects[iobj];

    if(distancesquared(object.origin, desiredpos) > var_b28bb506e83973be) {
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

function getbestsmartobjectalongline(startpos, endpos, region, volume, var_a0c8823e405a381f, var_7975c128a04cff8c, var_188936ff4f82c5c) {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }

  var_1d73dedf4c253ef9 = 60;
  clineheight = 60;
  var_8b8967d098e7c16e = 5184;
  var_79fa165ae4fcd077 = 48;

  if(isDefined(region.volume.script_radius)) {
    var_79fa165ae4fcd077 = region.volume.script_radius;
  }

  var_db6950e933ba5ea4 = 128;

  if(isDefined(region.volume.script_maxdist)) {
    var_db6950e933ba5ea4 = region.volume.script_maxdist;
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

  var_42737f8f4a46a4b4 = 60;
  var_56aad2fdc4c529d9 = 5;
  var_ff6725f929e35fcd = 0.33;
  var_259bd6e47136a920 = 1.5;
  var_321115db75019eda = 300000;
  var_c92fd93ef32888fd = 0.001;
  bestobj = undefined;
  bestobjscore = -9999;

  foreach(obj in region.smart_objects) {
    if(distancesquared(obj.origin, self.origin) < var_8b8967d098e7c16e) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:x1c>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    if(!canclaimsmartobject(obj)) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:x20>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    if(!istrue(var_188936ff4f82c5c) && !canusesmartobject(obj)) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:x24>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    var_9515fec383bd148b = obj.origin - startpos;
    distdownline = vectordot(starttoenddir, var_9515fec383bd148b);

    if(distdownline < var_a0c8823e405a381f) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:x29>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    if(distdownline > linelen + var_1d73dedf4c253ef9) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:x2d>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    distfromline = abs(vectordot(starttoendnormal, var_9515fec383bd148b));
    objradiussq = getsmartobjectradiussq(obj);

    if(distfromline * distfromline > objradiussq) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:x31>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    var_6f4072292388afb1 = var_db6950e933ba5ea4;

    if(linelen - distfromline < 60) {
      var_6f4072292388afb1 *= 0.5;
    }

    if(distfromline > var_6f4072292388afb1) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:x33>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    if(isDefined(volume) && !ispointinvolume(obj.origin, volume)) {
      if(bdrawdebug) {
        orientedbox(obj.origin + (0, 0, 32), (12, 12, 12), obj.angles, (0.9, 0.4, 0), 0, drawtime);
        print3d(obj.origin + (0, 0, 24), "<dev string:x37>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }

      continue;
    }

    objbp = getsmartobjecttype(obj.script_smartobject);
    adjustedlinelen = linelen - var_a0c8823e405a381f;
    var_18c156b57d0acfed = distdownline - var_a0c8823e405a381f;
    var_3544e1d5d0bf7496 = var_7975c128a04cff8c - var_a0c8823e405a381f;

    if(var_18c156b57d0acfed < var_3544e1d5d0bf7496) {
      score = var_56aad2fdc4c529d9 + var_42737f8f4a46a4b4 * (1 - (var_3544e1d5d0bf7496 - var_18c156b57d0acfed) / var_3544e1d5d0bf7496);
    } else {
      adjustedlinelen = linelen - var_7975c128a04cff8c + var_1d73dedf4c253ef9;
      var_18c156b57d0acfed = distdownline - var_7975c128a04cff8c;
      score = var_56aad2fdc4c529d9 + var_42737f8f4a46a4b4 * (adjustedlinelen - var_18c156b57d0acfed) / adjustedlinelen;
    }

    if(distfromline > var_79fa165ae4fcd077) {
      distfrompreferred = distfromline - var_79fa165ae4fcd077;
      score *= var_ff6725f929e35fcd + (1 - distfrompreferred / (var_6f4072292388afb1 - var_79fa165ae4fcd077)) * (1 - var_ff6725f929e35fcd);
    }

    if(isplayernearsmartobject(obj)) {
      score *= var_259bd6e47136a920;

      if(bdrawdebug) {
        print3d(obj.origin + (0, 0, 20), "<dev string:x3c>", (0.5, 0.5, 0.5), 1, 0.2, drawtime);
      }
    }

    objinfo = obj[[objbp.fngetinfo]]();

    if(isDefined(objinfo.fngetprioritymultiplier)) {
      score *= self[[objinfo.fngetprioritymultiplier]](obj);
    }

    if(isDefined(obj.lastusetime)) {
      if(gettime() - obj.lastusetime < var_321115db75019eda) {
        score *= var_c92fd93ef32888fd;
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
      print3d(obj.origin + (0, 0, 24), "<dev string:x3e>" + score, (0.5, 0.5, 0.5), 1, 0.2, drawtime);
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
  self.var_171120e99df3e286 = 1;
  self.customarrivaloptionalprefix = "arrival";
}

function setsmartobject(smartobj) {
  prevsmartobj = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(isDefined(prevsmartobj)) {
    clearsmartobject(prevsmartobj);
  }

  claimsmartobject(smartobj);
  scripts\asm\asm_bb::bb_requestsmartobject(smartobj);
}

function clearsmartobject(smartobj) {
  if(isDefined(smartobj)) {
    unclaimsmartobject(smartobj);
  }

  scripts\asm\asm_bb::bb_clearsmartobject();
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