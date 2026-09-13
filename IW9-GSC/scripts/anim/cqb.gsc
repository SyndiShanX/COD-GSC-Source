/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\cqb.gsc
***********************************************/

setupcqbpointsofinterest() {
  level.cqbpointsofinterest = [];
  level.fnfindcqbpointsofinterest = ::findcqbpointsofinterest;
  thread gatherdynamiccqbstructs();
}

gatherdynamiccqbstructs() {
  waittillframeend;
  targetname = "poi";
  _id_41004A11197B9881 = scripts\engine\utility::getStructArray(targetname, "targetname");

  foreach(point in _id_41004A11197B9881)
  level.cqbpointsofinterest[level.cqbpointsofinterest.size] = point;
}

_id_50FB5EFA67518B10(_id_B205D90302DA2F07) {
  if(!isDefined(_id_B205D90302DA2F07)) {
    if(isDefined(self.cqb_point_of_interest)) {
      self.cqb_point_of_interest = undefined;
      self _meth_F7D83C92F61DCC31(0);
    }
  } else if(!scripts\engine\utility::is_equal(self.cqb_point_of_interest, _id_B205D90302DA2F07)) {
    self.cqb_point_of_interest = _id_B205D90302DA2F07;
    self _meth_F7D83C92F61DCC31(1, _id_B205D90302DA2F07.origin, istrue(_id_B205D90302DA2F07.script_poi_forcestrafe), istrue(_id_B205D90302DA2F07.islookatonly), _id_B205D90302DA2F07.lookatduration);
  }
}

findcqbpointsofinterest() {
  if(isDefined(anim.findingcqbpointsofinterest)) {
    return;
  }
  anim.findingcqbpointsofinterest = 1;
  waitframe();

  for(;;) {
    ai = level.poi_activeai;

    if(!isDefined(ai)) {
      waitframe();
      continue;
    }

    _id_C747600BDDC1C484 = [];
    _id_897C2BAC1E48E4CD = 0;

    foreach(guy in ai) {
      if(isalive(guy)) {
        guy _id_50FB5EFA67518B10(guy findbestpoi());
        wait 0.05;
        _id_897C2BAC1E48E4CD = 1;
        continue;
      }

      _id_C747600BDDC1C484[_id_C747600BDDC1C484.size] = guy;
    }

    foreach(guy in _id_C747600BDDC1C484)
    level.poi_activeai = scripts\engine\utility::array_remove(level.poi_activeai, guy);

    if(!_id_897C2BAC1E48E4CD)
      wait 0.25;
  }
}

findbestpoi() {
  _id_52690D5D67A35644 = 5000;
  ismoving = isDefined(self.pathgoalpos);
  currentpoi = scripts\asm\track::_id_CB9CC0BF8A48E338();
  _id_DEBE466945CEE3C5 = isDefined(currentpoi);

  if(!_id_DEBE466945CEE3C5 && isDefined(self.poi_firstpoint))
    return findfirstpoiinlink();

  if(_id_DEBE466945CEE3C5 && isDefined(currentpoi.target) || isDefined(self.nextpoi))
    return findnextpoiinlink(_id_DEBE466945CEE3C5);
}

findfirstpoiinlink() {
  if(sighttracepassed(self getEye(), self.poi_firstpoint.origin, 0, undefined)) {
    _id_B205D90302DA2F07 = self.poi_firstpoint;

    if(isDefined(_id_B205D90302DA2F07.target))
      self.nextpoi = scripts\engine\utility::getStruct(_id_B205D90302DA2F07.target, "targetname");

    if(iswithinfov(_id_B205D90302DA2F07)) {
      return _id_B205D90302DA2F07;
      return;
    }

    return undefined;
    return;
  } else
    return undefined;
}

findnextpoiinlink(_id_DEBE466945CEE3C5) {
  min_time = undefined;
  currentpoi = scripts\asm\track::_id_CB9CC0BF8A48E338();

  if(_id_DEBE466945CEE3C5) {
    if(isDefined(currentpoi.target))
      self.nextpoi = scripts\engine\utility::getStruct(currentpoi.target, "targetname");
    else
      self.nextpoi = undefined;
  }

  if(isDefined(self.poi_firstpoint))
    self.poi_firstpoint = undefined;

  if(_id_DEBE466945CEE3C5 && isDefined(currentpoi.script_time_min))
    min_time = currentpoi.script_time_min * 1000;
  else
    min_time = 1200;

  if(!isDefined(self.nextpoi)) {
    if(gettime() < self.poi_starttime + min_time && iswithinfov(currentpoi))
      return currentpoi;
    else {
      scripts\common\ai::poi_enable(0);
      return undefined;
    }
  }

  if(_id_DEBE466945CEE3C5 && gettime() < self.poi_starttime + min_time && iswithinfov(currentpoi))
    return currentpoi;
  else if(!sighttracepassed(self getEye(), self.nextpoi.origin, 0, undefined))
    return undefined;
  else {
    if(!iswithinfov(self.nextpoi)) {
      if(isDefined(self.nextpoi.target))
        self.nextpoi = scripts\engine\utility::getStruct(self.nextpoi.target, "targetname");
      else
        scripts\common\ai::poi_enable(0);

      return undefined;
    }

    return self.nextpoi;
  }
}

iswithinfov(_id_B205D90302DA2F07) {
  if(istrue(self.poi_disablefov))
    return 1;

  _id_8D39B8AD31508804 = anglesToForward(self.angles);
  _id_34907596D27333C2 = acos(vectordot(_id_8D39B8AD31508804, vectorNormalize(_id_B205D90302DA2F07.origin - self getEye())));
  return _id_34907596D27333C2 < scripts\engine\utility::ter_op(isDefined(self.poi_fovlimit), self.poi_fovlimit, 90);
}