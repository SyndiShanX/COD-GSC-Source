/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\smartobject.gsc
***********************************************/



#using scripts\anim\notetracks;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\move;
#using scripts\asm\soldier\pain;
#using scripts\asm\soldier\patrol;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;
#namespace smartobject;

function smartobjectinit(asmname, startname, params) {
  assert(!isDefined(self.asm.smartobject));
  self.asm.smartobject = bb_getrequestedsmartobject();
  assert(isDefined(self.asm.smartobject));
}

function smartobjectcomplete(asmname, statename, params) {
  self.asm.smartobject.lastusetime = gettime();
  self.asm.smartobject smartobject_setnextuse();
  self.asm.smartobject = undefined;
  bb_clearplaysmartobject();
  asm_fireephemeralevent("smartobject", "finished");
}

function getsmartobjectinfo() {
  type = getsmartobjecttype(self.asm.smartobject.script_smartobject);
  return [[type.fngetinfo]]();
}

function smartobjecthasintro(asmname, statename, tostatename, params) {
  info = getsmartobjectinfo();

  if(!isDefined(info.hasintro)) {
    return false;
  }

  return true;
}

function smartobjecthaslogic(asmname, statename, tostatename, params) {
  return true;
}

function smartobjecthasoutro(asmname, statename, tostatename, params) {
  info = getsmartobjectinfo();

  if(!isDefined(info.hasoutro)) {
    return false;
  }

  return true;
}

function smartobjecthasexits(asmname, statename, tostatename, params) {
  info = getsmartobjectinfo();
  return istrue(info.hasexits);
}

function shouldplaysmartobjectpain(asmname, statename, tostatename, params) {
  info = getsmartobjectinfo();
  return istrue(info.haspain);
}

function shouldplaysmartobjectdeath(asmname, statename, tostatename, params) {
  info = getsmartobjectinfo();
  return istrue(info.hasdeath);
}

function shouldplaysmartobjectreact(asmname, statename, tostatename, params) {
  info = getsmartobjectinfo();
  return istrue(info.hasreact);
}

function shouldsmartobjectreact(asmname, statename, tostatename, params) {
  info = getsmartobjectinfo();

  if(istrue(info.bdonotreact)) {
    return false;
  }

  if(self shouldpatrolreact()) {
    return true;
  }

  if(isDefined(info.fninterrupt) && self[[info.fninterrupt]]()) {
    if(!isDefined(self.var_fd01ad49b4e38ae8)) {
      self.var_fd01ad49b4e38ae8 = "med";
    }

    self.var_df902e311df99de7 = gettime();
    return true;
  }

  return false;
}

function playsmartobjectintro(asmname, statename, params) {
  smartobject = self.asm.smartobject;

  if(isDefined(smartobject.angles)) {
    self orientmode("face angle", smartobject.angles[1]);
  }

  playsmartobjectanim(asmname, statename);
}

function playsmartobjectlogic(asmname, statename, params) {
  self endon(statename + "_finished");
  smartobject = self.asm.smartobject;

  if(isDefined(smartobject.angles)) {
    self orientmode("face angle", smartobject.angles[1]);
  }

  info = getsmartobjectinfo();

  if(isDefined(info.fnonuse)) {
    self[[info.fnonuse]](smartobject);
  }

  playsmartobjectanim(asmname, statename, 0.1, "finished");
  self asmfireevent(asmname, "smartobject_finished");
}

function choosesmartobjectanim(asmname, statename, params) {
  info = getsmartobjectinfo();

  if(istrue(info.var_d0fc6475ed819558)) {
    return undefined;
  }

  animalias = info.animlist[statename];
  data = spawnStruct();
  data.animindex = asm_lookupanimfromalias(info.animstatename, animalias);
  data.statename = info.animstatename;
  return data;
}

function playsmartobjectanim(asmname, statename, earlytime, earlynotify) {
  self endon(statename + "_finished");
  animdata = asm_getanim(asmname, statename);

  if(!isDefined(animdata)) {
    self waittill("forever");
  }

  self aisetanim(animdata.statename, animdata.animindex);
  asm_playfacialanim(asmname, animdata.statename, asm_getxanim(animdata.statename, animdata.animindex));

  if(isDefined(earlytime) && isDefined(earlynotify)) {
    xanim = asm_getxanim(animdata.statename, animdata.animindex);
    waittime = getanimlength(xanim) - earlytime;
    childthread smartobject_earlynotifier(waittime, earlynotify);
  }

  endnote = asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename), undefined, animdata.statename);

  if(endnote == "code_move") {
    endnote = asm_donotetracks(asmname, statename, undefined, undefined, animdata.statename);
  }
}

function smartobject_earlynotifier(waittime, earlynotify) {
  wait waittime;
  asm_fireephemeralevent("smartobject", earlynotify);
}

function smartobject_notetrackhandler(note) {
  if(scripts\anim\notetracks::notetrack_prefix_handler(note)) {
    return;
  }

  info = getsmartobjectinfo();

  if(isDefined(info.fnnotetrackhandle)) {
    return self[[info.fnnotetrackhandle]](note);
  }
}

function smartobject_shouldexitintomove(asmname, statename, tostatename, params) {
  return isDefined(self.pathgoalpos) && length2dsquared(self.velocity) > 1;
}

function playsmartobjectexit(asmname, statename, params) {
  info = getsmartobjectinfo();
  exitanim = asm_getanim(asmname, statename);

  if(!isDefined(exitanim)) {
    asm_fireevent(asmname, "abort");
    return;
  }

  scripts\asm\soldier\move::playstartanim(asmname, info.animstatename, exitanim, 0);
}

function choosesmartobjectexitanim(asmname, statename, params) {
  info = getsmartobjectinfo();
  return scripts\asm\soldier\move::chooseanim_exit(asmname, info.animstatename, params);
}

function playsmartobjectreactanim(asmname, statename, params) {
  info = getsmartobjectinfo();
  scripts\asm\soldier\patrol::playanim_patrolreact_internal(asmname, statename, info.animstatename);
}

function choosesmartobjectreactanim(asmname, statename, params) {
  info = getsmartobjectinfo();

  if(isDefined(info.animlist) && isDefined(info.animlist[statename])) {
    assert(asm_hasalias(info.animstatename, info.animlist[statename]));
    return asm_lookupanimfromalias(info.animstatename, info.animlist[statename]);
  }

  directionindex = scripts\asm\soldier\patrol::getpatrolreactdirindex();
  alias = "react_med_" + directionindex;
  assertex(asm_hasalias(info.animstatename, alias), "Smart object reaction aliases for " + info.animstatename + " set up incorrectly.Unable to find alias " + alias);
  return asm_lookupanimfromalias(info.animstatename, alias);
}

function playsmartobjectpainanim(asmname, statename, params) {
  info = getsmartobjectinfo();
  scripts\asm\soldier\pain::playpainaniminternal(asmname, statename, params, 0, 1, info.animstatename);
}

function playsmartobjectdeathanim(asmname, statename, params) {
  info = getsmartobjectinfo();
  self.deathstate = info.animstatename;
  self.deathalias = choosesmartobjectdeathalias(statename);
  scripts\asm\soldier\death::playdeathanim(asmname, statename);
}

function choosesmartobjectpainanim(asmname, statename, params) {
  info = getsmartobjectinfo();

  if(isDefined(info.animlist) && isDefined(info.animlist[statename])) {
    assert(asm_hasalias(info.animstatename, info.animlist[statename]));
    return asm_lookupanimfromalias(info.animstatename, info.animlist[statename]);
  }

  painalias = "pain_" + smtobjgetdamagedir();
  assertex(asm_hasalias(info.animstatename, painalias), "Smart object pain aliases for " + info.animstatename + " set up incorrectly.Unable to find alias " + painalias);
  return asm_lookupanimfromalias(info.animstatename, painalias);
}

function smtobjgetdamagedir() {
  anglediff = angleclamp180(self.damageyaw - self.angles[1]);

  if(anglediff < -135) {
    return "2";
  }

  if(anglediff < -45) {
    return "4";
  }

  if(anglediff > 135) {
    return "2";
  }

  if(anglediff > 45) {
    return "6";
  }

  return "8";
}

function choosesmartobjectdeathanim(asmname, statename, params) {
  info = getsmartobjectinfo();
  deathalias = choosesmartobjectdeathalias(statename);
  return asm_lookupanimfromalias(info.animstatename, deathalias);
}

function choosesmartobjectdeathalias(statename) {
  info = getsmartobjectinfo();

  if(isDefined(info.animlist) && isDefined(info.animlist[statename])) {
    assert(asm_hasalias(info.animstatename, info.animlist[statename]));
    return info.animlist[statename];
  }

  deathalias = "death_" + smtobjgetdamagedir();
  assertex(asm_hasalias(info.animstatename, deathalias), "Smart object death aliases for " + info.animstatename + " set up incorrectly. Unable to find alias " + deathalias);
  return deathalias;
}

function needtoturntosmartobject(asmname, statename, params) {
  smartobj = bb_getrequestedsmartobject();

  if(!isDefined(smartobj)) {
    return false;
  }

  if(!isDefined(smartobj.angles)) {
    return false;
  }

  anglediff = angleclamp180(smartobj.angles[1] - self.angles[1]);

  if(-45 < anglediff && anglediff < 45) {
    return false;
  }

  self.desiredturnyaw = anglediff;
  return true;
}