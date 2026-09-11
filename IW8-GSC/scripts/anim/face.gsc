/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\face.gsc
***********************************************/

function saygenericdialogue(var_0) {
  if(self.unittype != "soldier" && self.unittype != "civilian" && self.unittype != "juggernaut" && self.unittype != "suicidebomber") {
    return;
  }

  var_1 = undefined;

  switch (var_0) {
    case "meleeattack":
    case "meleecharge":
      var_2 = 0.5;
      break;
    case "flashbang":
      var_2 = 0.7;
      var_2 = 50;
      break;
    case "pain":
      var_2 = 0.9;
      var_2 = 98;
      break;
    case "seekerattack":
    case "flamedeath":
    case "explodeath":
    case "falldeath":
    case "incendeath":
    case "death":
      var_2 = 1;
      break;
    default:
      var_2 = 0.3;
      break;
  }

  if(isDefined(var_2) && randomint(100) > var_2) {
    return;
  }

  var_3 = undefined;
  var_4 = "generic_";
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(self.battlechatter) && isDefined(self.battlechatter.npcid)) {
    switch (self.battlechatter.npcid) {
      case "adm":
      case "mac":
      case "omr":
      case "ksh":
      case "brk":
      case "slt":
      case "eth":
        var_5 = self.battlechatter.npcid;
        var_4 = "hero_";
        var_6 = 1;
        break;
    }
  }

  if(!isDefined(var_5)) {
    switch (self.voice) {
      case "fsa":
      case "sas":
      case "unitedstates":
      case "unitednationshelmet":
      case "unitednations":
        var_5 = "friendly";
        var_6 = anim.numfriendlyvoices;
        break;
      case "alqatalafemale":
      case "russianfemale":
      case "fsafemale":
      case "sasfemale":
      case "unitedstatesfemale":
      case "unitednationsfemale":
        var_5 = "friendly";
        var_4 = "woman_";
        var_6 = anim.numfriendlyfemalevoices;
        break;
      case "c6":
        var_5 = "c6";
        var_6 = 1;
        break;
      default:
        var_5 = "enemy";
        var_6 = anim.numenemyvoices;
        break;
    }
  }

  var_3 = 1 + self getentitynumber() % var_6;
  var_5 = var_5 + "_" + var_3;
  var_7 = undefined;

  if(!isDefined(var_7)) {
    if(isDefined(self.generic_voice_override)) {
      var_7 = self.generic_voice_override + "_" + var_2 + "_" + var_5;
    } else {
      var_7 = var_4 + var_2 + "_" + var_5;
    }

    if(!soundexists(var_7)) {
      var_7 = "generic_" + var_2 + "_" + var_5;
    }
  }

  if(getdvarint("scr_print_dialogue_alias", 1)) {}

  thread playfacethread(var_7, undefined);
}

function sayspecificdialogue(var_0, var_1) {
  thread playfacethread(var_0, var_1);
}

function playfacethread(var_0, var_1) {
  if(isai(self)) {
    self.a.facialanimdone = 1;
    self.a.facialsounddone = 1;
  }

  if(isDefined(var_1)) {
    if(isDefined(var_0)) {
      playfacesound(var_0, "animscript facesound" + var_1, 1);
      thread waitforfacesound(var_1);
      return;
    }

    return;
  }

  playfacesound(var_0);
}

function playfacesound(var_0, var_1, var_2) {
  if(isai(self)) {
    self[[anim.callbacks["PlaySoundAtViewHeight"]]](var_0, var_1, var_2);
    return;
  }

  if(isDefined(var_1) && isDefined(var_2)) {
    self playSound(var_0, var_1, var_2);
    return;
  }

  if(isDefined(var_1)) {
    self playSound(var_0, var_1);
    return;
  }

  self playSound(var_0);
}

function waitforfacesound(var_0) {
  self endon("death");
  self waittill("animscript facesound" + var_0);
  self notify(var_0);
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

function animhasfacialoverride(var_0) {
  return animhasnotetrack(var_0, "facial_override");
}

#using_animtree("");

function playfacialanim(var_0, var_1, var_2) {
  if(isDefined(self.bdisabledefaultfacialanims) && self.bdisabledefaultfacialanims) {
    self aiclearanim(%head, 0.2);
    return;
  }

  if(isDefined(var_0) && animhasfacialoverride(var_0)) {
    self aiclearanim($head, 0.2);
    return;
  }

  if(!isDefined(anim.facial[var_1])) {
    return;
  }

  if(isDefined(var_2) && var_2 >= 0 && var_2 < anim.facial[var_1].size) {
    var_3 = var_2;
  } else {
    var_3 = randomint(anim.facial[var_2].size);
  }

  var_4 = anim.facial[var_2][var_3];
  self setanimknob(var_4);
  return var_3;
}