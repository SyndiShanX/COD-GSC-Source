/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\face.gsc
***********************************************/

function saygenericdialogue(var0) {
  if(self.unittype != "soldier" && self.unittype != "civilian" && self.unittype != "juggernaut" && self.unittype != "suicidebomber") {
    return;
  }

  var1 = undefined;

  switch (var0) {
    case "meleeattack":
    case "meleecharge":
      var2 = 0.5;
      break;
    case "flashbang":
      var2 = 0.7;
      var2 = 50;
      break;
    case "pain":
      var2 = 0.9;
      var2 = 98;
      break;
    case "seekerattack":
    case "flamedeath":
    case "explodeath":
    case "falldeath":
    case "incendeath":
    case "death":
      var2 = 1;
      break;
    default:
      var2 = 0.3;
      break;
  }

  if(isDefined(var2) && randomint(100) > var2) {
    return;
  }

  var3 = undefined;
  var4 = "generic_";
  var5 = undefined;
  var6 = undefined;

  if(isDefined(self.battlechatter) && isDefined(self.battlechatter.npcid)) {
    switch (self.battlechatter.npcid) {
      case "adm":
      case "mac":
      case "omr":
      case "ksh":
      case "brk":
      case "slt":
      case "eth":
        var5 = self.battlechatter.npcid;
        var4 = "hero_";
        var6 = 1;
        break;
    }
  }

  if(!isDefined(var5)) {
    switch (self.voice) {
      case "fsa":
      case "sas":
      case "unitedstates":
      case "unitednationshelmet":
      case "unitednations":
        var5 = "friendly";
        var6 = anim.numfriendlyvoices;
        break;
      case "alqatalafemale":
      case "russianfemale":
      case "fsafemale":
      case "sasfemale":
      case "unitedstatesfemale":
      case "unitednationsfemale":
        var5 = "friendly";
        var4 = "woman_";
        var6 = anim.numfriendlyfemalevoices;
        break;
      case "c6":
        var5 = "c6";
        var6 = 1;
        break;
      default:
        var5 = "enemy";
        var6 = anim.numenemyvoices;
        break;
    }
  }

  var3 = 1 + self getentitynumber() % var6;
  var5 = var5 + "_" + var3;
  var7 = undefined;

  if(!isDefined(var7)) {
    if(isDefined(self.generic_voice_override)) {
      var7 = self.generic_voice_override + "_" + var2 + "_" + var5;
    } else {
      var7 = var4 + var2 + "_" + var5;
    }

    if(!soundexists(var7)) {
      var7 = "generic_" + var2 + "_" + var5;
    }
  }

  if(getdvarint("scr_print_dialogue_alias", 1)) {}

  thread playfacethread(var7, undefined);
}

function sayspecificdialogue(var0, var1) {
  thread playfacethread(var0, var1);
}

function playfacethread(var0, var1) {
  if(isai(self)) {
    self.a.facialanimdone = 1;
    self.a.facialsounddone = 1;
  }

  if(isDefined(var1)) {
    if(isDefined(var0)) {
      playfacesound(var0, "animscript facesound" + var1, 1);
      thread waitforfacesound(var1);
      return;
    }

    return;
  }

  playfacesound(var0);
}

function playfacesound(var0, var1, var2) {
  if(isai(self)) {
    self[[anim.callbacks["PlaySoundAtViewHeight"]]](var0, var1, var2);
    return;
  }

  if(isDefined(var1) && isDefined(var2)) {
    self playSound(var0, var1, var2);
    return;
  }

  if(isDefined(var1)) {
    self playSound(var0, var1);
    return;
  }

  self playSound(var0);
}

function waitforfacesound(var0) {
  self endon("death");
  self waittill("animscript facesound" + var0);
  self notify(var0);
}

function initlevelface() {
  anim.numenemyvoices = 7;
  anim.numfriendlyvoices = 7;
  anim.numfriendlyfemalevoices = 3;
  initfacialanims();
}

function initfacialanims() {
  anim.facial = [];
}

function animhasfacialoverride(var0) {
  return animhasnotetrack(var0, "facial_override");
}

#using_animtree("");

function playfacialanim(var0, var1, var2) {
  if(isDefined(self.bdisabledefaultfacialanims) && self.bdisabledefaultfacialanims) {
    self aiclearanim(%head, 0.2);
    return;
  }

  if(isDefined(var0) && animhasfacialoverride(var0)) {
    self aiclearanim($head, 0.2);
    return;
  }

  if(!isDefined(anim.facial[var1])) {
    return;
  }

  if(isDefined(var2) && var2 >= 0 && var2 < anim.facial[var1].size) {
    var3 = var2;
  } else {
    var3 = randomint(anim.facial[var2].size);
  }

  var4 = anim.facial[var2][var3];
  self setanimknob(var4);
  return var3;
}