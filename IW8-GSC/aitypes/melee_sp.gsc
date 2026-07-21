/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\melee_sp.gsc
***********************************************/

initmeleefunctions(var_0) {
  self.meleerangesq = 6724;
  self.meleechargedist = 160;
  self.meleechargedistvsplayer = 200;
  self.meleechargedistreloadmultiplier = 1;
  self.meleemaxzdiff = 36;
  self.meleeactorboundsradius = 32;
  self.acceptablemeleefraction = 0.98;
  self.fnismeleevalid = scripts\aitypes\melee::ismeleevalid;
  self.fncanmovefrompointtopoint = ::canmovefrompointtopoint;
  return anim.success;
}

c6_initmelee(var_0) {
  self.meleerangesq = 5184;
  self.meleechargedist = 160;
  self.meleechargedistvsplayer = 200;
  self.meleechargedistreloadmultiplier = 1;
  self.meleemaxzdiff = 36;
  self.meleeactorboundsradius = 40;
  self.acceptablemeleefraction = 0.98;
  self.fnismeleevalid = ::c6_ismeleevalid;
  self.fncanmovefrompointtopoint = ::canmovefrompointtopoint;
  return anim.success;
}

seeker_initmelee(var_0) {
  self.meleerangesq = 5184;
  self.meleechargedist = 256;
  self.meleechargedistvsplayer = 512;
  self.meleechargedistreloadmultiplier = 1;
  self.meleemaxzdiff = 36;
  self.meleeactorboundsradius = 40;
  self.acceptablemeleefraction = 0.98;
  self.fnismeleevalid = scripts\aitypes\melee::ismeleevalid;
  self.fncanmovefrompointtopoint = ::canmovefrompointtopoint;
  return anim.success;
}

canmovefrompointtopoint(var_0, var_1) {
  return self maymovefrompointtopoint(var_0, var_1, 0, 1);
}

c6_ismeleevalid(var_0, var_1) {
  if(isai(var_0)) {
    if(var_0.unittype != "soldier" && var_0.unittype != "juggernaut")
      return 0;
  }

  return scripts\aitypes\melee::ismeleevalid(var_0, var_1);
}