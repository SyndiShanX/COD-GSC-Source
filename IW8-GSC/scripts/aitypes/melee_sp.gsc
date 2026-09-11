/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\melee_sp.gsc
***********************************************/

function initmeleefunctions(var0) {
  self.meleerangesq = 6724;
  self.meleechargedist = 160;
  self.meleechargedistvsplayer = 200;
  self.meleechargedistreloadmultiplier = 1;
  self.meleemaxzdiff = 36;
  self.meleeactorboundsradius = 32;
  self.acceptablemeleefraction = 0.98;
  self.fnismeleevalid = &scripts\aitypes\melee::ismeleevalid;
  self.fncanmovefrompointtopoint = &canmovefrompointtopoint;
  return anim.success;
}

function c6_initmelee(var0) {
  self.meleerangesq = 5184;
  self.meleechargedist = 160;
  self.meleechargedistvsplayer = 200;
  self.meleechargedistreloadmultiplier = 1;
  self.meleemaxzdiff = 36;
  self.meleeactorboundsradius = 40;
  self.acceptablemeleefraction = 0.98;
  self.fnismeleevalid = &c6_ismeleevalid;
  self.fncanmovefrompointtopoint = &canmovefrompointtopoint;
  return anim.success;
}

function seeker_initmelee(var0) {
  self.meleerangesq = 5184;
  self.meleechargedist = 256;
  self.meleechargedistvsplayer = 512;
  self.meleechargedistreloadmultiplier = 1;
  self.meleemaxzdiff = 36;
  self.meleeactorboundsradius = 40;
  self.acceptablemeleefraction = 0.98;
  self.fnismeleevalid = &scripts\aitypes\melee::ismeleevalid;
  self.fncanmovefrompointtopoint = &canmovefrompointtopoint;
  return anim.success;
}

function canmovefrompointtopoint(var0, var1) {
  return self maymovefrompointtopoint(var0, var1, 0, 1);
}

function c6_ismeleevalid(var0, var1) {
  if(isai(var0)) {
    if(var0.unittype != "soldier" && var0.unittype != "juggernaut") {
      return 0;
    }
  }

  return scripts\aitypes\melee::ismeleevalid(var0, var1);
}