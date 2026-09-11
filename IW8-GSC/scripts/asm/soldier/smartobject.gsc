/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\smartobject.gsc
***********************************************/

function smartobjectinit(var0, var1, var2) {
  self.asm.smartobject = scripts\asm\asm_bb::bb_getrequestedsmartobject();
}

function smartobjectcomplete(var0, var1, var2) {
  self.asm.smartobject.lastusetime = gettime();
  self.asm.smartobject scripts\smartobjects\utility::smartobject_setnextuse();
  self.asm.smartobject = undefined;
  scripts\asm\asm_bb::bb_clearplaysmartobject();
  scripts\asm\asm::asm_fireephemeralevent("smartobject", "finished");
}

function shouldplaysmartobjectanim(var0, var1, var2, var3) {
  return scripts\asm\asm_bb::bb_playsmartobjectrequested();
}

function getsmartobjectinfo() {
  var0 = scripts\smartobjects\utility::getsmartobjecttype(self.asm.smartobject.script_smartobject);
  return [[var0.fngetinfo]]();
}

function smartobjecthasintro(var0, var1, var2, var3) {
  var4 = getsmartobjectinfo();

  if(!isDefined(var4.hasintro)) {
    return false;
  }

  return true;
}

function smartobjecthaslogic(var0, var1, var2, var3) {
  return true;
}

function smartobjecthasoutro(var0, var1, var2, var3) {
  var4 = getsmartobjectinfo();

  if(!isDefined(var4.hasoutro)) {
    return false;
  }

  return true;
}

function smartobjecthasexits(var0, var1, var2, var3) {
  var4 = getsmartobjectinfo();
  return istrue(var4.hasexits);
}

function shouldplaysmartobjectpain(var0, var1, var2, var3) {
  var4 = getsmartobjectinfo();
  return istrue(var4.haspain);
}

function shouldplaysmartobjectdeath(var0, var1, var2, var3) {
  var4 = getsmartobjectinfo();
  return istrue(var4.hasdeath);
}

function shouldplaysmartobjectreact(var0, var1, var2, var3) {
  var4 = getsmartobjectinfo();
  return istrue(var4.hasreact);
}

function shouldsmartobjectreact(var0, var1, var2, var3) {
  var4 = getsmartobjectinfo();

  if(istrue(var4.bdonotreact)) {
    return false;
  }

  if(scripts\asm\soldier\patrol::patrol_shouldreact(var0, var1, var2, var3)) {
    return true;
  }

  if(isDefined(var4.fninterrupt) && self[[var4.fninterrupt]]()) {
    if(!isDefined(self.stealth.patrol_react_magnitude)) {
      self.stealth.patrol_react_magnitude = "smed";
    }

    self.stealth.patrol_react_time = gettime();
    return true;
  }

  return false;
}

function playsmartobjectintro(var0, var1, var2) {
  var3 = self.asm.smartobject;

  if(isDefined(var3.angles)) {
    self orientmode("face angle", var3.angles[1]);
  }

  playsmartobjectanim(var0, var1);
}

function playsmartobjectlogic(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = self.asm.smartobject;

  if(isDefined(var3.angles)) {
    self orientmode("face angle", var3.angles[1]);
  }

  var4 = getsmartobjectinfo();

  if(isDefined(var4.fnonuse)) {
    self[[var4.fnonuse]](var3);
  }

  playsmartobjectanim(var0, var1, 0.1, "finished");
  self asmfireevent(var0, "smartobject_finished");
}

function choosesmartobjectanim(var0, var1, var2) {
  var3 = getsmartobjectinfo();
  var4 = var3.animlist[var1];
  var5 = spawnStruct();
  var5.animindex = scripts\asm\asm::asm_lookupanimfromalias(var3.animstatename, var4);
  var5.statename = var3.animstatename;
  return var5;
}

function playsmartobjectanim(var0, var1, var2, var3) {
  self endon(var1 + "_finished");
  var4 = scripts\asm\asm::asm_getanim(var0, var1);
  self aisetanim(var4.statename, var4.animindex);
  scripts\asm\asm::asm_playfacialanim(var0, var1, scripts\asm\asm::asm_getxanim(var4.statename, var4.animindex));

  if(isDefined(var2) && isDefined(var3)) {
    var5 = scripts\asm\asm::asm_getxanim(var4.statename, var4.animindex);
    var6 = getanimlength(var5) - var2;
    GscBinSkip4(0x35, var6, var3);
  }

  var7 = scripts\asm\asm::asm_donotetracks(var2, var3, scripts\asm\asm::asm_getnotehandler(var2, var3), undefined, var6.statename);

  if(var7 == "code_move") {
    var7 = scripts\asm\asm::asm_donotetracks(var2, var3, undefined, undefined, var6.statename);
    return;
  }
}

function smartobject_earlynotifier(var0, var1) {
  wait var0;
  scripts\asm\asm::asm_fireephemeralevent("smartobject", var1);
}

function smartobject_notetrackhandler(var0) {
  if(scripts\anim\notetracks::notetrack_prefix_handler(var0)) {
    return;
  }

  var1 = getsmartobjectinfo();

  if(isDefined(var1.fnnotetrackhandle)) {
    return self[[var1.fnnotetrackhandle]](var0);
  }
}

function smartobject_shouldexitintomove(var0, var1, var2, var3) {
  return isDefined(self.pathgoalpos) && length2dsquared(self.velocity) > 1;
}

function playsmartobjectexit(var0, var1, var2) {
  var3 = getsmartobjectinfo();
  var4 = scripts\asm\asm::asm_getanim(var0, var1);

  if(!isDefined(var4)) {
    scripts\asm\asm::asm_fireevent(var0, "abort");
    return;
  }

  scripts\asm\soldier\move::playstartanim(var0, var3.animstatename, var4, 0);
}

function choosesmartobjectexitanim(var0, var1, var2) {
  var3 = getsmartobjectinfo();
  return scripts\asm\soldier\move::chooseanim_exit(var0, var3.animstatename, var2);
}

function playsmartobjectreactanim(var0, var1, var2) {
  var3 = getsmartobjectinfo();
  scripts\asm\soldier\patrol::playanim_patrolreact_internal(var0, var1, var3.animstatename);
}

function choosesmartobjectreactanim(var0, var1, var2) {
  var3 = getsmartobjectinfo();

  if(isDefined(var3.animlist) && isDefined(var3.animlist[var1])) {
    return scripts\asm\asm::asm_lookupanimfromalias(var3.animstatename, var3.animlist[var1]);
  }

  var4 = scripts\asm\soldier\patrol::getpatrolreactdirindex();
  var5 = "react_med_" + var4;
  return scripts\asm\asm::asm_lookupanimfromalias(var3.animstatename, var5);
}

function playsmartobjectpainanim(var0, var1, var2) {
  var3 = getsmartobjectinfo();
  scripts\asm\soldier\pain::playpainaniminternal(var0, var1, var2, 0, 1, var3.animstatename);
}

function playsmartobjectdeathanim(var0, var1, var2) {
  var3 = getsmartobjectinfo();
  self.deathstate = var3.animstatename;
  self.deathalias = choosesmartobjectdeathalias(var1);
  scripts\asm\soldier\death::playdeathanim(var0, var1);
}

function choosesmartobjectpainanim(var0, var1, var2) {
  var3 = getsmartobjectinfo();

  if(isDefined(var3.animlist) && isDefined(var3.animlist[var1])) {
    return scripts\asm\asm::asm_lookupanimfromalias(var3.animstatename, var3.animlist[var1]);
  }

  var4 = "pain_" + smtobjgetdamagedir();
  return scripts\asm\asm::asm_lookupanimfromalias(var3.animstatename, var4);
}

function smtobjgetdamagedir() {
  var0 = angleclamp180(self.damageyaw - self.angles[1]);

  if(var0 < -135) {
    return "2";
  }

  if(var0 < -45) {
    return "4";
  }

  if(var0 > 135) {
    return "2";
  }

  if(var0 > 45) {
    return "6";
  }

  return "8";
}

function choosesmartobjectdeathanim(var0, var1, var2) {
  var3 = getsmartobjectinfo();
  var4 = choosesmartobjectdeathalias(var1);
  return scripts\asm\asm::asm_lookupanimfromalias(var3.animstatename, var4);
}

function choosesmartobjectdeathalias(var0) {
  var1 = getsmartobjectinfo();

  if(isDefined(var1.animlist) && isDefined(var1.animlist[var0])) {
    return var1.animlist[var0];
  }

  var2 = "death_" + smtobjgetdamagedir();
  return var2;
}

function needtoturntosmartobject(var0, var1, var2) {
  var3 = scripts\asm\asm_bb::bb_getrequestedsmartobject();

  if(!isDefined(var3)) {
    return false;
  }

  if(!isDefined(var3.angles)) {
    return false;
  }

  var4 = angleclamp180(var3.angles[1] - self.angles[1]);

  if(-45 < var4 && var4 < 45) {
    return false;
  }

  self.desiredturnyaw = var4;
  return true;
}