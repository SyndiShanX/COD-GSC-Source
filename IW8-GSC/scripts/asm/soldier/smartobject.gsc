/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\smartobject.gsc
***********************************************/

function smartobjectinit(var_0, var_1, var_2) {
  self.asm.smartobject = scripts\asm\asm_bb::bb_getrequestedsmartobject();
}

function smartobjectcomplete(var_0, var_1, var_2) {
  self.asm.smartobject.lastusetime = gettime();
  self.asm.smartobject scripts\smartobjects\utility::smartobject_setnextuse();
  self.asm.smartobject = undefined;
  scripts\asm\asm_bb::bb_clearplaysmartobject();
  scripts\asm\asm::asm_fireephemeralevent("smartobject", "finished");
}

function shouldplaysmartobjectanim(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_playsmartobjectrequested();
}

function getsmartobjectinfo() {
  var_0 = scripts\smartobjects\utility::getsmartobjecttype(self.asm.smartobject.script_smartobject);
  return [[var_0.fngetinfo]]();
}

function smartobjecthasintro(var_0, var_1, var_2, var_3) {
  var_4 = getsmartobjectinfo();

  if(!isDefined(var_4.hasintro)) {
    return false;
  }

  return true;
}

function smartobjecthaslogic(var_0, var_1, var_2, var_3) {
  return true;
}

function smartobjecthasoutro(var_0, var_1, var_2, var_3) {
  var_4 = getsmartobjectinfo();

  if(!isDefined(var_4.hasoutro)) {
    return false;
  }

  return true;
}

function smartobjecthasexits(var_0, var_1, var_2, var_3) {
  var_4 = getsmartobjectinfo();
  return istrue(var_4.hasexits);
}

function shouldplaysmartobjectpain(var_0, var_1, var_2, var_3) {
  var_4 = getsmartobjectinfo();
  return istrue(var_4.haspain);
}

function shouldplaysmartobjectdeath(var_0, var_1, var_2, var_3) {
  var_4 = getsmartobjectinfo();
  return istrue(var_4.hasdeath);
}

function shouldplaysmartobjectreact(var_0, var_1, var_2, var_3) {
  var_4 = getsmartobjectinfo();
  return istrue(var_4.hasreact);
}

function shouldsmartobjectreact(var_0, var_1, var_2, var_3) {
  var_4 = getsmartobjectinfo();

  if(istrue(var_4.bdonotreact)) {
    return false;
  }

  if(scripts\asm\soldier\patrol::patrol_shouldreact(var_0, var_1, var_2, var_3)) {
    return true;
  }

  if(isDefined(var_4.fninterrupt) && self[[var_4.fninterrupt]]()) {
    if(!isDefined(self.stealth.patrol_react_magnitude)) {
      self.stealth.patrol_react_magnitude = "smed";
    }

    self.stealth.patrol_react_time = gettime();
    return true;
  }

  return false;
}

function playsmartobjectintro(var_0, var_1, var_2) {
  var_3 = self.asm.smartobject;

  if(isDefined(var_3.angles)) {
    self orientmode("face angle", var_3.angles[1]);
  }

  playsmartobjectanim(var_0, var_1);
}

function playsmartobjectlogic(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = self.asm.smartobject;

  if(isDefined(var_3.angles)) {
    self orientmode("face angle", var_3.angles[1]);
  }

  var_4 = getsmartobjectinfo();

  if(isDefined(var_4.fnonuse)) {
    self[[var_4.fnonuse]](var_3);
  }

  playsmartobjectanim(var_0, var_1, 0.1, "finished");
  self asmfireevent(var_0, "smartobject_finished");
}

function choosesmartobjectanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();
  var_4 = var_3.animlist[var_1];
  var_5 = spawnStruct();
  var_5.animindex = scripts\asm\asm::asm_lookupanimfromalias(var_3.animstatename, var_4);
  var_5.statename = var_3.animstatename;
  return var_5;
}

function playsmartobjectanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self aisetanim(var_4.statename, var_4.animindex);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, scripts\asm\asm::asm_getxanim(var_4.statename, var_4.animindex));

  if(isDefined(var_2) && isDefined(var_3)) {
    var_5 = scripts\asm\asm::asm_getxanim(var_4.statename, var_4.animindex);
    var_6 = getanimlength(var_5) - var_2;
    GscBinSkip4(0x35, var_6, var_3);
  }

  var_7 = scripts\asm\asm::asm_donotetracks(var_2, var_3, scripts\asm\asm::asm_getnotehandler(var_2, var_3), undefined, var_6.statename);

  if(var_7 == "code_move") {
    var_7 = scripts\asm\asm::asm_donotetracks(var_2, var_3, undefined, undefined, var_6.statename);
    return;
  }
}

function smartobject_earlynotifier(var_0, var_1) {
  wait var_0;
  scripts\asm\asm::asm_fireephemeralevent("smartobject", var_1);
}

function smartobject_notetrackhandler(var_0) {
  if(scripts\anim\notetracks::notetrack_prefix_handler(var_0)) {
    return;
  }

  var_1 = getsmartobjectinfo();

  if(isDefined(var_1.fnnotetrackhandle)) {
    return self[[var_1.fnnotetrackhandle]](var_0);
  }
}

function smartobject_shouldexitintomove(var_0, var_1, var_2, var_3) {
  return isDefined(self.pathgoalpos) && length2dsquared(self.velocity) > 1;
}

function playsmartobjectexit(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);

  if(!isDefined(var_4)) {
    scripts\asm\asm::asm_fireevent(var_0, "abort");
    return;
  }

  scripts\asm\soldier\move::playstartanim(var_0, var_3.animstatename, var_4, 0);
}

function choosesmartobjectexitanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();
  return scripts\asm\soldier\move::chooseanim_exit(var_0, var_3.animstatename, var_2);
}

function playsmartobjectreactanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();
  scripts\asm\soldier\patrol::playanim_patrolreact_internal(var_0, var_1, var_3.animstatename);
}

function choosesmartobjectreactanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();

  if(isDefined(var_3.animlist) && isDefined(var_3.animlist[var_1])) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_3.animstatename, var_3.animlist[var_1]);
  }

  var_4 = scripts\asm\soldier\patrol::getpatrolreactdirindex();
  var_5 = "react_med_" + var_4;
  return scripts\asm\asm::asm_lookupanimfromalias(var_3.animstatename, var_5);
}

function playsmartobjectpainanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();
  scripts\asm\soldier\pain::playpainaniminternal(var_0, var_1, var_2, 0, 1, var_3.animstatename);
}

function playsmartobjectdeathanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();
  self.deathstate = var_3.animstatename;
  self.deathalias = choosesmartobjectdeathalias(var_1);
  scripts\asm\soldier\death::playdeathanim(var_0, var_1);
}

function choosesmartobjectpainanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();

  if(isDefined(var_3.animlist) && isDefined(var_3.animlist[var_1])) {
    return scripts\asm\asm::asm_lookupanimfromalias(var_3.animstatename, var_3.animlist[var_1]);
  }

  var_4 = "pain_" + smtobjgetdamagedir();
  return scripts\asm\asm::asm_lookupanimfromalias(var_3.animstatename, var_4);
}

function smtobjgetdamagedir() {
  var_0 = angleclamp180(self.damageyaw - self.angles[1]);

  if(var_0 < -135) {
    return "2";
  }

  if(var_0 < -45) {
    return "4";
  }

  if(var_0 > 135) {
    return "2";
  }

  if(var_0 > 45) {
    return "6";
  }

  return "8";
}

function choosesmartobjectdeathanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();
  var_4 = choosesmartobjectdeathalias(var_1);
  return scripts\asm\asm::asm_lookupanimfromalias(var_3.animstatename, var_4);
}

function choosesmartobjectdeathalias(var_0) {
  var_1 = getsmartobjectinfo();

  if(isDefined(var_1.animlist) && isDefined(var_1.animlist[var_0])) {
    return var_1.animlist[var_0];
  }

  var_2 = "death_" + smtobjgetdamagedir();
  return var_2;
}

function needtoturntosmartobject(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(!isDefined(var_3)) {
    return false;
  }

  if(!isDefined(var_3.angles)) {
    return false;
  }

  var_4 = angleclamp180(var_3.angles[1] - self.angles[1]);

  if(-45 < var_4 && var_4 < 45) {
    return false;
  }

  self.desiredturnyaw = var_4;
  return true;
}