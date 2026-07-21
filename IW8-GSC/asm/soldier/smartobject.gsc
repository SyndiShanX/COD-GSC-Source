/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\smartobject.gsc
***********************************************/

smartobjectinit(var_0, var_1, var_2) {
  self.asm.smartobject = scripts\asm\asm_bb::bb_getrequestedsmartobject();
}

smartobjectcomplete(var_0, var_1, var_2) {
  self.asm.smartobject.lastusetime = gettime();
  self.asm.smartobject scripts\smartobjects\utility::smartobject_setnextuse();
  self.asm.smartobject = undefined;
  scripts\asm\asm_bb::bb_clearplaysmartobject();
  scripts\asm\asm::asm_fireephemeralevent("smartobject", "finished");
}

shouldplaysmartobjectanim(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_playsmartobjectrequested();
}

getsmartobjectinfo() {
  var_0 = scripts\smartobjects\utility::getsmartobjecttype(self.asm.smartobject.script_smartobject);
  return [[var_0.fngetinfo]]();
}

smartobjecthasintro(var_0, var_1, var_2, var_3) {
  var_4 = getsmartobjectinfo();

  if(!isDefined(var_4.hasintro))
    return 0;

  return 1;
}

smartobjecthaslogic(var_0, var_1, var_2, var_3) {
  return 1;
}

smartobjecthasoutro(var_0, var_1, var_2, var_3) {
  var_4 = getsmartobjectinfo();

  if(!isDefined(var_4.hasoutro))
    return 0;

  return 1;
}

smartobjecthasexits(var_0, var_1, var_2, var_3) {
  var_4 = getsmartobjectinfo();
  return istrue(var_4.hasexits);
}

shouldplaysmartobjectpain(var_0, var_1, var_2, var_3) {
  var_4 = getsmartobjectinfo();
  return istrue(var_4.haspain);
}

shouldplaysmartobjectdeath(var_0, var_1, var_2, var_3) {
  var_4 = getsmartobjectinfo();
  return istrue(var_4.hasdeath);
}

shouldplaysmartobjectreact(var_0, var_1, var_2, var_3) {
  var_4 = getsmartobjectinfo();
  return istrue(var_4.hasreact);
}

shouldsmartobjectreact(var_0, var_1, var_2, var_3) {
  var_4 = getsmartobjectinfo();

  if(istrue(var_4.bdonotreact))
    return 0;

  if(scripts\asm\soldier\patrol::patrol_shouldreact(var_0, var_1, var_2, var_3))
    return 1;

  if(isDefined(var_4.fninterrupt) && self[[var_4.fninterrupt]]()) {
    if(!isDefined(self.stealth.patrol_react_magnitude))
      self.stealth.patrol_react_magnitude = "smed";

    self.stealth.patrol_react_time = gettime();
    return 1;
  }

  return 0;
}

playsmartobjectintro(var_0, var_1, var_2) {
  var_3 = self.asm.smartobject;

  if(isDefined(var_3.angles))
    self orientmode("face angle", var_3.angles[1]);

  playsmartobjectanim(var_0, var_1);
}

playsmartobjectlogic(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = self.asm.smartobject;

  if(isDefined(var_3.angles))
    self orientmode("face angle", var_3.angles[1]);

  var_4 = getsmartobjectinfo();

  if(isDefined(var_4.fnonuse))
    self[[var_4.fnonuse]](var_3);

  playsmartobjectanim(var_0, var_1, 0.1, "finished");
  self asmfireevent(var_0, "smartobject_finished");
}

choosesmartobjectanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();
  var_4 = var_3.animlist[var_1];
  var_5 = spawnStruct();
  var_5.animindex = scripts\asm\asm::asm_lookupanimfromalias(var_3.animstatename, var_4);
  var_5.statename = var_3.animstatename;
  return var_5;
}

playsmartobjectanim(var_0, var_1, var_2, var_3) {
  self endon(var_1 + "_finished");
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);
  self aisetanim(var_4.statename, var_4.animindex);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, scripts\asm\asm::asm_getxanim(var_4.statename, var_4.animindex));

  if(isDefined(var_2) && isDefined(var_3)) {
    var_5 = scripts\asm\asm::asm_getxanim(var_4.statename, var_4.animindex);
    var_6 = getanimlength(var_5) - var_2;
    childthread smartobject_earlynotifier(var_6, var_3);
  }

  var_7 = scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1), undefined, var_4.statename);

  if(var_7 == "code_move")
    var_7 = scripts\asm\asm::asm_donotetracks(var_0, var_1, undefined, undefined, var_4.statename);
}

smartobject_earlynotifier(var_0, var_1) {
  wait(var_0);
  scripts\asm\asm::asm_fireephemeralevent("smartobject", var_1);
}

smartobject_notetrackhandler(var_0) {
  if(scripts\anim\notetracks.gsc::notetrack_prefix_handler(var_0)) {
    return;
  }
  var_1 = getsmartobjectinfo();

  if(isDefined(var_1.fnnotetrackhandle))
    return self[[var_1.fnnotetrackhandle]](var_0);
}

smartobject_shouldexitintomove(var_0, var_1, var_2, var_3) {
  return isDefined(self.pathgoalpos) && length2dsquared(self.velocity) > 1;
}

playsmartobjectexit(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();
  var_4 = scripts\asm\asm::asm_getanim(var_0, var_1);

  if(!isDefined(var_4)) {
    scripts\asm\asm::asm_fireevent(var_0, "abort");
    return;
  }

  scripts\asm\soldier\move::playstartanim(var_0, var_3.animstatename, var_4, 0);
}

choosesmartobjectexitanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();
  return scripts\asm\soldier\move::chooseanim_exit(var_0, var_3.animstatename, var_2);
}

playsmartobjectreactanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();
  scripts\asm\soldier\patrol::playanim_patrolreact_internal(var_0, var_1, var_3.animstatename);
}

choosesmartobjectreactanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();

  if(isDefined(var_3.animlist) && isDefined(var_3.animlist[var_1]))
    return scripts\asm\asm::asm_lookupanimfromalias(var_3.animstatename, var_3.animlist[var_1]);

  var_4 = scripts\asm\soldier\patrol::getpatrolreactdirindex();
  var_5 = "react_med_" + var_4;
  return scripts\asm\asm::asm_lookupanimfromalias(var_3.animstatename, var_5);
}

playsmartobjectpainanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();
  scripts\asm\soldier\pain::playpainaniminternal(var_0, var_1, var_2, 0, 1, var_3.animstatename);
}

playsmartobjectdeathanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();
  self.deathstate = var_3.animstatename;
  self.deathalias = choosesmartobjectdeathalias(var_1);
  scripts\asm\soldier\death::playdeathanim(var_0, var_1);
}

choosesmartobjectpainanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();

  if(isDefined(var_3.animlist) && isDefined(var_3.animlist[var_1]))
    return scripts\asm\asm::asm_lookupanimfromalias(var_3.animstatename, var_3.animlist[var_1]);

  var_4 = "pain_" + smtobjgetdamagedir();
  return scripts\asm\asm::asm_lookupanimfromalias(var_3.animstatename, var_4);
}

smtobjgetdamagedir() {
  var_0 = angleclamp180(self.damageyaw - self.angles[1]);

  if(var_0 < -135)
    return "2";
  else if(var_0 < -45)
    return "4";
  else if(var_0 > 135)
    return "2";
  else if(var_0 > 45)
    return "6";
  else
    return "8";
}

choosesmartobjectdeathanim(var_0, var_1, var_2) {
  var_3 = getsmartobjectinfo();
  var_4 = choosesmartobjectdeathalias(var_1);
  return scripts\asm\asm::asm_lookupanimfromalias(var_3.animstatename, var_4);
}

choosesmartobjectdeathalias(var_0) {
  var_1 = getsmartobjectinfo();

  if(isDefined(var_1.animlist) && isDefined(var_1.animlist[var_0]))
    return var_1.animlist[var_0];

  var_2 = "death_" + smtobjgetdamagedir();
  return var_2;
}

needtoturntosmartobject(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(!isDefined(var_3))
    return 0;

  if(!isDefined(var_3.angles))
    return 0;

  var_4 = angleclamp180(var_3.angles[1] - self.angles[1]);

  if(-45 < var_4 && var_4 < 45)
    return 0;

  self.desiredturnyaw = var_4;
  return 1;
}