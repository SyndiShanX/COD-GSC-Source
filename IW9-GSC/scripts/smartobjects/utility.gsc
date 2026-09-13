/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\smartobjects\utility.gsc
***********************************************/

init_smartobjects() {
  if(isDefined(anim.smartobjects)) {
    return;
  }
  anim.smartobjects = [];
}

validate() {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }
  foreach(point in anim.smartobjectpoints) {}
}

add_smartobject_type(name, fngetinfo, fnusecondition) {
  init_smartobjects();
  struct = spawnStruct();
  struct.fngetinfo = fngetinfo;
  struct.fnusecondition = fnusecondition;
  anim.smartobjects[name] = struct;
}

createsmartobjectinfo() {
  info = spawnStruct();
  info.animlist = [];
  return info;
}

addsmartobjectanim_internal(statename, alias) {
  if(!isDefined(self.animlist[statename]))
    self.animlist[statename] = [];

  self.animlist[statename] = alias;
}

addsmartobjectintroanim(alias) {
  addsmartobjectanim_internal("smartobject_intro", alias);
  self.hasintro = 1;
}

addsmartobjectanim(alias) {
  addsmartobjectanim_internal("smartobject_logic", alias);
}

addsmartobjectreactanim(alias) {
  if(isDefined(alias))
    addsmartobjectanim_internal("smartobject_react", alias);

  self.hasreact = 1;
}

addsmartobjectoutroanim(alias) {
  addsmartobjectanim_internal("smartobject_outro", alias);
  self.hasoutro = 1;
}

addsmartobjectarrivalanims() {
  self.hasarrivals = 1;
}

addsmartobjectexitanims() {
  self.hasexits = 1;
}

addsmartobjectpainanim(alias) {
  if(isDefined(alias))
    addsmartobjectanim_internal("smartobject_pain", alias);

  self.haspain = 1;
}

addsmartobjectdeathanim(alias) {
  if(isDefined(alias))
    addsmartobjectanim_internal("smartobject_death", alias);

  self.hasdeath = 1;
}

getsmartobjecttype(name) {
  return anim.smartobjects[name];
}

smartobject_setnextuse() {
  _id_96A0415ACD878096 = getsmartobjecttype(self.script_smartobject);
  info = self[[_id_96A0415ACD878096.fngetinfo]]();

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

claimsmartobject(obj) {
  obj.claimer = self;
}

unclaimsmartobject(obj) {
  obj.claimer = undefined;
}

canclaimsmartobject(obj) {
  return !isDefined(obj.claimer);
}

canusesmartobject(obj) {
  if(istrue(obj.donotuse))
    return 0;

  if(isDefined(obj.neveruseagain))
    return 0;

  if(isDefined(obj.nextusetime) && gettime() < obj.nextusetime)
    return 0;

  _id_6378CE7933D6B3B4 = getsmartobjecttype(obj.script_smartobject);
  result = [[_id_6378CE7933D6B3B4.fnusecondition]](obj);
  return result;
}

getbestsmartobject(_id_B25886E4707AC7CD, volume, _id_F34327E65116BAAA) {
  if(!isDefined(anim.smartobjectpoints))
    return undefined;

  _id_B28BB506E83973BE = _id_F34327E65116BAAA * _id_F34327E65116BAAA;
  _id_35A90566147AFC1F = sortbydistance(anim.smartobjectpoints, _id_B25886E4707AC7CD);
  _id_FF20FABD45AB91FC = _id_35A90566147AFC1F.size;

  for(_id_BDD490B638B4343D = 0; _id_BDD490B638B4343D < _id_FF20FABD45AB91FC; _id_BDD490B638B4343D++) {
    object = _id_35A90566147AFC1F[_id_BDD490B638B4343D];

    if(distancesquared(object.origin, _id_B25886E4707AC7CD) > _id_B28BB506E83973BE) {
      break;
    }

    if(!canclaimsmartobject(object)) {
      continue;
    }
    if(!canusesmartobject(object)) {
      continue;
    }
    if(!issmartobjectwithinrange(object, _id_B25886E4707AC7CD, volume)) {
      continue;
    }
    _id_6378CE7933D6B3B4 = getsmartobjecttype(object.script_smartobject);

    if([[_id_6378CE7933D6B3B4.fnusecondition]](object))
      return object;
  }

  return undefined;
}

isplayernearsmartobject(obj) {
  radiussq = 1600;
  _id_4124119064906DA2 = 4096;

  foreach(player in level.players) {
    if(distance2dsquared(obj.origin, player.origin) < radiussq && squared(obj.origin[2] - player.origin[2]) < _id_4124119064906DA2) {
      _id_2CF6A0823B4BAB5D = vectortoyaw(player.origin - obj.origin);

      if(abs(angleclamp180(_id_2CF6A0823B4BAB5D - obj.angles[1])) < 90)
        return 1;
    }
  }

  return 0;
}

getbestsmartobjectalongline(startpos, endpos, region, volume, _id_A0C8823E405A381F, _id_7975C128A04CFF8C, _id_0188936FF4F82C5C) {
  if(!isDefined(anim.smartobjectpoints)) {
    return;
  }
  _id_1D73DEDF4C253EF9 = 60;
  _id_7B5554090818485F = 60;
  _id_8B8967D098E7C16E = 5184;
  _id_79FA165AE4FCD077 = 48;

  if(isDefined(region.volume.script_radius))
    _id_79FA165AE4FCD077 = region.volume.script_radius;

  _id_DB6950E933BA5EA4 = 128;

  if(isDefined(region.volume.script_maxdist))
    _id_DB6950E933BA5EA4 = region.volume.script_maxdist;

  _id_2674A2C3EE67214B = endpos - startpos;
  _id_1E0E1311A3E9C94A = length(_id_2674A2C3EE67214B);
  _id_E5382B2564F4252A = _id_2674A2C3EE67214B / _id_1E0E1311A3E9C94A;
  _id_3773B7FBBA8ED834 = vectorNormalize((_id_E5382B2564F4252A[1], -1 * _id_E5382B2564F4252A[0], 0));
  _id_0E4BB5EA6B1AD286 = 0;
  _id_47D735016BAE708E = undefined;
  _id_42737F8F4A46A4B4 = 60;
  _id_56AAD2FDC4C529D9 = 5;
  _id_FF6725F929E35FCD = 0.33;
  _id_259BD6E47136A920 = 1.5;
  _id_321115DB75019EDA = 300000;
  _id_C92FD93EF32888FD = 0.001;
  _id_8CDA798C61B6CFD8 = undefined;
  _id_E964AB4B34F8D36A = -9999;

  foreach(obj in region.smart_objects) {
    if(distancesquared(obj.origin, self.origin) < _id_8B8967D098E7C16E) {
      continue;
    }
    if(!canclaimsmartobject(obj)) {
      continue;
    }
    if(!istrue(_id_0188936FF4F82C5C) && !canusesmartobject(obj)) {
      continue;
    }
    _id_9515FEC383BD148B = obj.origin - startpos;
    _id_79850CE546522757 = vectordot(_id_E5382B2564F4252A, _id_9515FEC383BD148B);

    if(_id_79850CE546522757 < _id_A0C8823E405A381F) {
      continue;
    }
    if(_id_79850CE546522757 > _id_1E0E1311A3E9C94A + _id_1D73DEDF4C253EF9) {
      continue;
    }
    _id_FA8B7A4393C95BB7 = abs(vectordot(_id_3773B7FBBA8ED834, _id_9515FEC383BD148B));
    _id_9ADA8E56E572E16C = getsmartobjectradiussq(obj);

    if(_id_FA8B7A4393C95BB7 * _id_FA8B7A4393C95BB7 > _id_9ADA8E56E572E16C) {
      continue;
    }
    _id_6F4072292388AFB1 = _id_DB6950E933BA5EA4;

    if(_id_1E0E1311A3E9C94A - _id_FA8B7A4393C95BB7 < 60)
      _id_6F4072292388AFB1 = _id_6F4072292388AFB1 * 0.5;

    if(_id_FA8B7A4393C95BB7 > _id_6F4072292388AFB1) {
      continue;
    }
    if(isDefined(volume) && !ispointinvolume(obj.origin, volume)) {
      continue;
    }
    _id_6378CE7933D6B3B4 = getsmartobjecttype(obj.script_smartobject);
    _id_C76F1C2B08872EA0 = _id_1E0E1311A3E9C94A - _id_A0C8823E405A381F;
    _id_18C156B57D0ACFED = _id_79850CE546522757 - _id_A0C8823E405A381F;
    _id_3544E1D5D0BF7496 = _id_7975C128A04CFF8C - _id_A0C8823E405A381F;

    if(_id_18C156B57D0ACFED < _id_3544E1D5D0BF7496)
      score = _id_56AAD2FDC4C529D9 + _id_42737F8F4A46A4B4 * (1 - (_id_3544E1D5D0BF7496 - _id_18C156B57D0ACFED) / _id_3544E1D5D0BF7496);
    else {
      _id_C76F1C2B08872EA0 = _id_1E0E1311A3E9C94A - _id_7975C128A04CFF8C + _id_1D73DEDF4C253EF9;
      _id_18C156B57D0ACFED = _id_79850CE546522757 - _id_7975C128A04CFF8C;
      score = _id_56AAD2FDC4C529D9 + _id_42737F8F4A46A4B4 * (_id_C76F1C2B08872EA0 - _id_18C156B57D0ACFED) / _id_C76F1C2B08872EA0;
    }

    if(_id_FA8B7A4393C95BB7 > _id_79FA165AE4FCD077) {
      _id_803EBB87020CAD2E = _id_FA8B7A4393C95BB7 - _id_79FA165AE4FCD077;
      score = score * (_id_FF6725F929E35FCD + (1 - _id_803EBB87020CAD2E / (_id_6F4072292388AFB1 - _id_79FA165AE4FCD077)) * (1 - _id_FF6725F929E35FCD));
    }

    if(isplayernearsmartobject(obj))
      score = score * _id_259BD6E47136A920;

    _id_6A7A0A172BE2F436 = obj[[_id_6378CE7933D6B3B4.fngetinfo]]();

    if(isDefined(_id_6A7A0A172BE2F436.fngetprioritymultiplier))
      score = score * self[[_id_6A7A0A172BE2F436.fngetprioritymultiplier]](obj);

    if(isDefined(obj.lastusetime)) {
      if(gettime() - obj.lastusetime < _id_321115DB75019EDA)
        score = score * _id_C92FD93EF32888FD;
      else
        obj.lastusetime = undefined;
    }

    if(score > _id_E964AB4B34F8D36A) {
      _id_E964AB4B34F8D36A = score;
      _id_8CDA798C61B6CFD8 = obj;
    }
  }

  return _id_8CDA798C61B6CFD8;
}

getsmartobjectradiussq(obj) {
  if(isDefined(obj.radius))
    return obj.radius * obj.radius;

  _id_96A0415ACD878096 = anim.smartobjects[obj.script_smartobject];
  _id_6A7A0A172BE2F436 = [[_id_96A0415ACD878096.fngetinfo]]();

  if(isDefined(_id_6A7A0A172BE2F436.radius))
    return _id_6A7A0A172BE2F436.radius * _id_6A7A0A172BE2F436.radius;

  return _id_6A7A0A172BE2F436.radiussqrd;
}

issmartobjectwithinrange(object, _id_C5BFBA134880A4C8, volume) {
  if(isDefined(_id_C5BFBA134880A4C8))
    pos = _id_C5BFBA134880A4C8;
  else
    pos = self.origin;

  distsqrd = distancesquared(pos, object.origin);

  if(isDefined(object.radius)) {
    if(distsqrd > squared(object.radius))
      return 0;
  } else {
    type = anim.smartobjects[object.script_smartobject];
    info = [[type.fngetinfo]]();

    if(distsqrd > info.radiussqrd)
      return 0;
  }

  if(isDefined(volume) && !ispointinvolume(object.origin, volume))
    return 0;

  return 1;
}

setcustomsmartobjectarrivaldata(obj) {
  _id_6378CE7933D6B3B4 = getsmartobjecttype(obj.script_smartobject);
  info = [[_id_6378CE7933D6B3B4.fngetinfo]]();

  if(!istrue(info.hasarrivals)) {
    return;
  }
  self._id_0A41EDF45BB0FF97 = obj.angles;
  self._id_A57082FDF62BC898 = info.animstatename;
  self._id_171120E99DF3E286 = 1;
  self._id_8C4D2D1D8377F643 = "arrival";
}

setsmartobject(_id_6C66DE307018DFE3) {
  _id_47B56F47CD0464CA = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(isDefined(_id_47B56F47CD0464CA))
    clearsmartobject(_id_47B56F47CD0464CA);

  claimsmartobject(_id_6C66DE307018DFE3);
  scripts\asm\asm_bb::bb_requestsmartobject(_id_6C66DE307018DFE3);
}

clearsmartobject(_id_6C66DE307018DFE3) {
  if(isDefined(_id_6C66DE307018DFE3))
    unclaimsmartobject(_id_6C66DE307018DFE3);

  scripts\asm\asm_bb::bb_clearsmartobject();
}

canusesmartobject_stealth(_id_6C66DE307018DFE3) {
  if(!isDefined(self.script_stealthgroup))
    return 0;

  if(![[self.fnisinstealthinvestigate]]() && ![[self.fnisinstealthhunt]]())
    return 0;

  if(isDefined(self.enemy))
    return 0;

  return 1;
}

canusesmartobject_nostrafenoturn(_id_6C66DE307018DFE3) {
  forward = anglesToForward(self.angles);
  normal = vectorNormalize(_id_6C66DE307018DFE3.origin - self.origin);

  if(vectordot(forward, normal) >= cos(60))
    _id_A5BD60698EF8D196 = 64;
  else
    _id_A5BD60698EF8D196 = 100;

  if(distancesquared(self.origin, _id_6C66DE307018DFE3.origin) <= _id_A5BD60698EF8D196 * _id_A5BD60698EF8D196)
    return 0;

  forward = anglesToForward(_id_6C66DE307018DFE3.angles);

  if(vectordot(forward, normal) < cos(45))
    return 0;

  return 1;
}