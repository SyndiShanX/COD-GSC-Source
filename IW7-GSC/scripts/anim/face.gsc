/*********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\face.gsc
*********************************/

saygenericdialogue(param_00) {
  if(self.unittype != "soldier" && self.unittype != "c6") {
    return;
  }

  var_01 = undefined;
  switch (param_00) {
    case "meleeattack":
    case "meleecharge":
      var_02 = 0.5;
      break;

    case "flashbang":
      var_02 = 0.7;
      var_01 = 50;
      break;

    case "pain":
      var_02 = 0.9;
      var_01 = 98;
      break;

    case "seekerattack":
    case "explodeath":
    case "death":
      var_02 = 1;
      break;

    default:
      var_02 = 0.3;
      break;
  }

  if(isDefined(var_01) && randomint(100) > var_01) {
    return;
  }

  var_03 = undefined;
  var_04 = "generic_";
  var_05 = undefined;
  var_06 = undefined;
  if(isDefined(self.npcid)) {
    switch (self.npcid) {
      case "adm":
      case "mac":
      case "omr":
      case "ksh":
      case "brk":
      case "slt":
      case "eth":
        var_05 = self.npcid;
        var_04 = "hero_";
        var_06 = 1;
        break;
    }
  }

  if(!isDefined(var_05)) {
    switch (self.voice) {
      case "unitednationshelmet":
      case "unitednations":
        var_05 = "friendly";
        var_06 = level.numfriendlyvoices;
        break;

      case "unitednationsfemale":
        var_05 = "friendly";
        var_04 = "woman_";
        var_06 = level.numfriendlyfemalevoices;
        break;

      case "c6":
        var_05 = "c6";
        var_06 = 1;
        break;

      default:
        var_05 = "enemy";
        var_06 = level.numenemyvoices;
        break;
    }
  }

  var_03 = 1 + self getentitynumber() % var_06;
  var_05 = var_05 + "_" + var_03;
  var_07 = undefined;
  if(!isDefined(var_07)) {
    if(isDefined(self.generic_voice_override)) {
      var_07 = self.generic_voice_override + "_" + param_00 + "_" + var_05;
    } else {
      var_07 = var_04 + param_00 + "_" + var_05;
    }

    if(!soundexists(var_07)) {
      var_07 = "generic_" + param_00 + "_" + var_05;
    }
  }

  thread playfacethread(var_07, undefined);
}

sayspecificdialogue(param_00, param_01) {
  thread playfacethread(param_00, param_01);
}

playfacethread(param_00, param_01) {
  if(isai(self)) {
    self.a.facialanimdone = 1;
    self.a.facialsounddone = 1;
  }

  if(isDefined(param_01)) {
    if(isDefined(param_00)) {
      playfacesound(param_00, "animscript facesound" + param_01, 1);
      thread waitforfacesound(param_01);
      return;
    }

    return;
  }

  playfacesound(param_00);
}

playfacesound(param_00, param_01, param_02) {
  if(isai(self)) {
    if(isDefined(param_01) && isDefined(param_02)) {
      self getyawtoenemy(param_00, param_01, param_02);
      return;
    }

    if(isDefined(param_01)) {
      self getyawtoenemy(param_00, param_01);
      return;
    }

    self getyawtoenemy(param_00);
    return;
  }

  if(isDefined(param_01) && isDefined(param_02)) {
    self playSound(param_00, param_01, param_02);
    return;
  }

  if(isDefined(param_01)) {
    self playSound(param_00, param_01);
    return;
  }

  self playSound(param_00);
}

waitforfacesound(param_00) {
  self endon("death");
  self waittill("animscript facesound" + param_00);
  self notify(param_00);
}

initlevelface() {
  anim.numenemyvoices = 7;
  anim.numfriendlyvoices = 7;
  anim.numfriendlyfemalevoices = 3;
  initfacialanims();
}

initfacialanims() {
  anim.facial = [];
}

animhasfacialoverride(param_00) {
  return animhasnotetrack(param_00, "facial_override");
}

playfacialanim(param_00, param_01, param_02) {
  if(isDefined(self.bdisabledefaultfacialanims) && self.bdisabledefaultfacialanims) {
    self clearanim( % head, 0.2);
    return;
  }

  if(isDefined(param_00) && animhasfacialoverride(param_00)) {
    self clearanim( % head, 0.2);
    return;
  }

  if(!isDefined(level.facial[param_01])) {
    return;
  }

  if(isDefined(param_02) && param_02 >= 0 && param_02 < level.facial[param_01].size) {
    var_03 = param_02;
  } else {
    var_03 = randomint(level.facial[param_02].size);
  }

  var_04 = level.facial[param_01][var_03];
  self setanimknob(var_04);
  return var_03;
}