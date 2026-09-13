/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\smartobject.gsc
***********************************************/

smartobjectinit(asmname, _id_9B08CC0CA316E788, params) {
  self.asm.smartobject = scripts\asm\asm_bb::bb_getrequestedsmartobject();
}

smartobjectcomplete(asmname, statename, params) {
  self.asm.smartobject.lastusetime = gettime();
  self.asm.smartobject scripts\smartobjects\utility::smartobject_setnextuse();
  self.asm.smartobject = undefined;
  scripts\asm\asm_bb::bb_clearplaysmartobject();
  scripts\asm\asm::asm_fireephemeralevent("smartobject", "finished");
}

getsmartobjectinfo() {
  type = scripts\smartobjects\utility::getsmartobjecttype(self.asm.smartobject.script_smartobject);
  return [[type.fngetinfo]]();
}

smartobjecthasintro(asmname, statename, _id_F2B19B25D457C2A6, params) {
  info = getsmartobjectinfo();

  if(!isDefined(info.hasintro))
    return 0;

  return 1;
}

smartobjecthaslogic(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return 1;
}

smartobjecthasoutro(asmname, statename, _id_F2B19B25D457C2A6, params) {
  info = getsmartobjectinfo();

  if(!isDefined(info.hasoutro))
    return 0;

  return 1;
}

smartobjecthasexits(asmname, statename, _id_F2B19B25D457C2A6, params) {
  info = getsmartobjectinfo();
  return istrue(info.hasexits);
}

shouldplaysmartobjectpain(asmname, statename, _id_F2B19B25D457C2A6, params) {
  info = getsmartobjectinfo();
  return istrue(info.haspain);
}

shouldplaysmartobjectdeath(asmname, statename, _id_F2B19B25D457C2A6, params) {
  info = getsmartobjectinfo();
  return istrue(info.hasdeath);
}

shouldplaysmartobjectreact(asmname, statename, _id_F2B19B25D457C2A6, params) {
  info = getsmartobjectinfo();
  return istrue(info.hasreact);
}

shouldsmartobjectreact(asmname, statename, _id_F2B19B25D457C2A6, params) {
  info = getsmartobjectinfo();

  if(istrue(info.bdonotreact))
    return 0;

  if(self _meth_A4A9E73B2D25FF8B())
    return 1;

  if(isDefined(info.fninterrupt) && self[[info.fninterrupt]]()) {
    if(!isDefined(self._id_FD01AD49B4E38AE8))
      self._id_FD01AD49B4E38AE8 = "med";

    self._id_DF902E311DF99DE7 = gettime();
    return 1;
  }

  return 0;
}

playsmartobjectintro(asmname, statename, params) {
  smartobject = self.asm.smartobject;

  if(isDefined(smartobject.angles))
    self orientmode("face angle", smartobject.angles[1]);

  playsmartobjectanim(asmname, statename);
}

playsmartobjectlogic(asmname, statename, params) {
  self endon(statename + "_finished");
  smartobject = self.asm.smartobject;

  if(isDefined(smartobject.angles))
    self orientmode("face angle", smartobject.angles[1]);

  info = getsmartobjectinfo();

  if(isDefined(info.fnonuse))
    self[[info.fnonuse]](smartobject);

  playsmartobjectanim(asmname, statename, 0.1, "finished");
  self asmfireevent(asmname, "smartobject_finished");
}

choosesmartobjectanim(asmname, statename, params) {
  info = getsmartobjectinfo();

  if(istrue(info._id_D0FC6475ED819558))
    return undefined;

  animalias = info.animlist[statename];
  data = spawnStruct();
  data.animindex = scripts\asm\asm::asm_lookupanimfromalias(info.animstatename, animalias);
  data.statename = info.animstatename;
  return data;
}

playsmartobjectanim(asmname, statename, _id_8352485F68C78819, _id_6C79D6772822F969) {
  self endon(statename + "_finished");
  _id_5EC185BB9E766D14 = scripts\asm\asm::asm_getanim(asmname, statename);

  if(!isDefined(_id_5EC185BB9E766D14))
    self waittill("forever");

  self aisetanim(_id_5EC185BB9E766D14.statename, _id_5EC185BB9E766D14.animindex);
  scripts\asm\asm::asm_playfacialanim(asmname, _id_5EC185BB9E766D14.statename, scripts\asm\asm::asm_getxanim(_id_5EC185BB9E766D14.statename, _id_5EC185BB9E766D14.animindex));

  if(isDefined(_id_8352485F68C78819) && isDefined(_id_6C79D6772822F969)) {
    xanim = scripts\asm\asm::asm_getxanim(_id_5EC185BB9E766D14.statename, _id_5EC185BB9E766D14.animindex);
    waittime = getanimlength(xanim) - _id_8352485F68C78819;
    childthread smartobject_earlynotifier(waittime, _id_6C79D6772822F969);
  }

  endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename), undefined, _id_5EC185BB9E766D14.statename);

  if(endnote == "code_move")
    endnote = scripts\asm\asm::asm_donotetracks(asmname, statename, undefined, undefined, _id_5EC185BB9E766D14.statename);
}

smartobject_earlynotifier(waittime, _id_6C79D6772822F969) {
  wait(waittime);
  scripts\asm\asm::asm_fireephemeralevent("smartobject", _id_6C79D6772822F969);
}

smartobject_notetrackhandler(_id_A234A65C378F3289) {
  if(_id_357B9A54DFEDBD4A::notetrack_prefix_handler(_id_A234A65C378F3289)) {
    return;
  }
  info = getsmartobjectinfo();

  if(isDefined(info.fnnotetrackhandle))
    return self[[info.fnnotetrackhandle]](_id_A234A65C378F3289);
}

smartobject_shouldexitintomove(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(self.pathgoalpos) && length2dsquared(self.velocity) > 1;
}

playsmartobjectexit(asmname, statename, params) {
  info = getsmartobjectinfo();
  _id_457A0F528BFF306C = scripts\asm\asm::asm_getanim(asmname, statename);

  if(!isDefined(_id_457A0F528BFF306C)) {
    scripts\asm\asm::asm_fireevent(asmname, "abort");
    return;
  }

  scripts\asm\soldier\move::playstartanim(asmname, info.animstatename, _id_457A0F528BFF306C, 0);
}

choosesmartobjectexitanim(asmname, statename, params) {
  info = getsmartobjectinfo();
  return scripts\asm\soldier\move::chooseanim_exit(asmname, info.animstatename, params);
}

playsmartobjectreactanim(asmname, statename, params) {
  info = getsmartobjectinfo();
  scripts\asm\soldier\patrol::playanim_patrolreact_internal(asmname, statename, info.animstatename);
}

choosesmartobjectreactanim(asmname, statename, params) {
  info = getsmartobjectinfo();

  if(isDefined(info.animlist) && isDefined(info.animlist[statename]))
    return scripts\asm\asm::asm_lookupanimfromalias(info.animstatename, info.animlist[statename]);

  _id_394EFCEF72C7EBEA = scripts\asm\soldier\patrol::getpatrolreactdirindex();
  alias = "react_med_" + _id_394EFCEF72C7EBEA;
  return scripts\asm\asm::asm_lookupanimfromalias(info.animstatename, alias);
}

playsmartobjectpainanim(asmname, statename, params) {
  info = getsmartobjectinfo();
  scripts\asm\soldier\pain::playpainaniminternal(asmname, statename, params, 0, 1, info.animstatename);
}

playsmartobjectdeathanim(asmname, statename, params) {
  info = getsmartobjectinfo();
  self.deathstate = info.animstatename;
  self.deathalias = choosesmartobjectdeathalias(statename);
  scripts\asm\soldier\death::playdeathanim(asmname, statename);
}

choosesmartobjectpainanim(asmname, statename, params) {
  info = getsmartobjectinfo();

  if(isDefined(info.animlist) && isDefined(info.animlist[statename]))
    return scripts\asm\asm::asm_lookupanimfromalias(info.animstatename, info.animlist[statename]);

  _id_7B9FB896860064AB = "pain_" + smtobjgetdamagedir();
  return scripts\asm\asm::asm_lookupanimfromalias(info.animstatename, _id_7B9FB896860064AB);
}

smtobjgetdamagedir() {
  _id_077B9E4B599269EB = angleclamp180(self.damageyaw - self.angles[1]);

  if(_id_077B9E4B599269EB < -135)
    return "2";
  else if(_id_077B9E4B599269EB < -45)
    return "4";
  else if(_id_077B9E4B599269EB > 135)
    return "2";
  else if(_id_077B9E4B599269EB > 45)
    return "6";
  else
    return "8";
}

choosesmartobjectdeathanim(asmname, statename, params) {
  info = getsmartobjectinfo();
  deathalias = choosesmartobjectdeathalias(statename);
  return scripts\asm\asm::asm_lookupanimfromalias(info.animstatename, deathalias);
}

choosesmartobjectdeathalias(statename) {
  info = getsmartobjectinfo();

  if(isDefined(info.animlist) && isDefined(info.animlist[statename]))
    return info.animlist[statename];

  deathalias = "death_" + smtobjgetdamagedir();
  return deathalias;
}

needtoturntosmartobject(asmname, statename, params) {
  _id_6C66DE307018DFE3 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(!isDefined(_id_6C66DE307018DFE3))
    return 0;

  if(!isDefined(_id_6C66DE307018DFE3.angles))
    return 0;

  _id_077B9E4B599269EB = angleclamp180(_id_6C66DE307018DFE3.angles[1] - self.angles[1]);

  if(-45 < _id_077B9E4B599269EB && _id_077B9E4B599269EB < 45)
    return 0;

  self.desiredturnyaw = _id_077B9E4B599269EB;
  return 1;
}