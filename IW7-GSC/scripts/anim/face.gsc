/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\face.gsc
*********************************************/

saygenericdialogue(var_0) {
  if(self.unittype != "soldier" && self.unittype != "c6") {
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
      var_1 = 50;
      break;

    case "pain":
      var_2 = 0.9;
      var_1 = 98;
      break;

    case "seekerattack":
    case "explodeath":
    case "death":
      var_2 = 1;
      break;

    default:
      var_2 = 0.3;
      break;
  }

  if(isDefined(var_1) && randomint(100) > var_1) {
    return;
  }

  var_3 = undefined;
  var_4 = "generic_";
  var_5 = undefined;
  var_6 = undefined;
  if(isDefined(self.npcid)) {
    switch (self.npcid) {
      case "adm":
      case "mac":
      case "omr":
      case "ksh":
      case "brk":
      case "slt":
      case "eth":
        var_5 = self.npcid;
        var_4 = "hero_";
        var_6 = 1;
        break;
    }
  }

  if(!isDefined(var_5)) {
    switch (self.voice) {
      case "unitednationshelmet":
      case "unitednations":
        var_5 = "friendly";
        var_6 = level.numfriendlyvoices;
        break;

      case "unitednationsfemale":
        var_5 = "friendly";
        var_4 = "woman_";
        var_6 = level.numfriendlyfemalevoices;
        break;

      case "c6":
        var_5 = "c6";
        var_6 = 1;
        break;

      default:
        var_5 = "enemy";
        var_6 = level.numenemyvoices;
        break;
    }
  }

  var_3 = 1 + self getentitynumber() % var_6;
  var_5 = var_5 + "_" + var_3;
  var_7 = undefined;
  if(!isDefined(var_7)) {
    if(isDefined(self.generic_voice_override)) {
      var_7 = self.generic_voice_override + "_" + var_0 + "_" + var_5;
    } else {
      var_7 = var_4 + var_0 + "_" + var_5;
    }

    if(!soundexists(var_7)) {
      var_7 = "generic_" + var_0 + "_" + var_5;
    }
  }

  thread playfacethread(var_7, undefined);
}

sayspecificdialogue(var_0, var_1) {
  thread playfacethread(var_0, var_1);
}

playfacethread(var_0, var_1) {
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

playfacesound(var_0, var_1, var_2) {
  if(isai(self)) {
    if(isDefined(var_1) && isDefined(var_2)) {
      self getyawtoenemy(var_0, var_1, var_2);
      return;
    }

    if(isDefined(var_1)) {
      self getyawtoenemy(var_0, var_1);
      return;
    }

    self getyawtoenemy(var_0);
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

waitforfacesound(var_0) {
  self endon("death");
  self waittill("animscript facesound" + var_0);
  self notify(var_0);
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

animhasfacialoverride(var_0) {
  return animhasnotetrack(var_0, "facial_override");
}

playfacialanim(var_0, var_1, var_2) {
  if(isDefined(self.bdisabledefaultfacialanims) && self.bdisabledefaultfacialanims) {
    self clearanim(%head, 0.2);
    return;
  }

  if(isDefined(var_0) && animhasfacialoverride(var_0)) {
    self clearanim(%head, 0.2);
    return;
  }

  if(!isDefined(level.facial[var_1])) {
    return;
  }

  if(isDefined(var_2) && var_2 >= 0 && var_2 < level.facial[var_1].size) {
    var_3 = var_2;
  } else {
    var_3 = randomint(level.facial[var_2].size);
  }

  var_4 = level.facial[var_1][var_3];
  self setanimknob(var_4);
  return var_3;
}