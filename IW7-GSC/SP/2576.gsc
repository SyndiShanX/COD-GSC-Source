/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\2576.gsc
*********************************************/

func_9898(var_0) {
  self.meleerangesq = 12100;
  self.meleechargedist = 160;
  self.meleechargedistvsplayer = 200;
  self.meleechargedistreloadmultiplier = 1;
  self.var_B627 = 36;
  self.meleeactorboundsradius = 32;
  self.acceptablemeleefraction = 0.98;
  self.fnismeleevalid = ::ismeleevalid;
  self.fncanmovefrompointtopoint = ::canmovefrompointtopoint;
  return level.success;
}

func_3376(var_0) {
  self.meleerangesq = 5184;
  self.meleechargedist = 160;
  self.meleechargedistvsplayer = 200;
  self.meleechargedistreloadmultiplier = 1;
  self.var_B627 = 36;
  self.meleeactorboundsradius = 40;
  self.acceptablemeleefraction = 0.98;
  self.fnismeleevalid = ::func_3381;
  self.fncanmovefrompointtopoint = ::canmovefrompointtopoint;
  return level.success;
}

func_F13B(var_0) {
  self.meleerangesq = 5184;
  self.meleechargedist = 256;
  self.meleechargedistvsplayer = 512;
  self.meleechargedistreloadmultiplier = 1;
  self.var_B627 = 36;
  self.meleeactorboundsradius = 40;
  self.acceptablemeleefraction = 0.98;
  self.fnismeleevalid = ::ismeleevalid;
  self.fncanmovefrompointtopoint = ::canmovefrompointtopoint;
  return level.success;
}

canmovefrompointtopoint(var_0, var_1) {
  return self maymovefrompointtopoint(var_0, var_1, 0, 1);
}

func_3381(var_0, var_1) {
  if(isai(var_0)) {
    if(var_0.unittype != "soldier") {
      return 0;
    }
  }

  return ismeleevalid(var_0, var_1);
}

ismeleevalid(var_0, var_1) {
  if(!scripts\aitypes\melee::ismeleevalid_common(var_0, var_1)) {
    return 0;
  }

  if(var_1) {
    if(isDefined(self.a.onback) || self.a.pose == "prone") {
      return 0;
    }

    if(isDefined(self.unittype) && self.unittype == "seeker") {
      if(!isplayer(self.triggerportableradarping) && !lib_0F3D::func_B575(self.unittype)) {
        return 0;
      }
    } else {
      if(scripts\anim\utility_common::isusingsidearm() && !isplayer(var_0)) {
        return 0;
      }

      if(!lib_0F3D::func_B575(self.unittype, 1)) {
        return 0;
      }
    }
  }

  if(isDefined(self.objective_position) && self.objective_additionalcurrent == 1) {
    return 0;
  }

  if(isDefined(self.var_A985) && self.isnodeoccupied == self.var_A985 && gettime() <= self.var_BF90) {
    return 0;
  }

  if(isDefined(var_0.var_5951) || isDefined(var_0.ignoreme) && var_0.ignoreme) {
    return 0;
  }

  if(!isai(var_0) && !isplayer(var_0)) {
    return 0;
  }

  if(isDefined(self.var_B5DD) && isDefined(var_0.var_B5DD)) {
    return 0;
  }

  if((isDefined(self.var_B5DD) && isDefined(var_0.var_B14F)) || isDefined(var_0.var_B5DD) && isDefined(self.var_B14F)) {
    return 0;
  }

  if(isai(var_0)) {
    if(var_0 _meth_81A6()) {
      return 0;
    }

    if(var_0 scripts\sp\utility::func_58DA() || var_0.var_EB) {
      return 0;
    }

    if(self.getcsplinepointtargetname != "none" || var_0.getcsplinepointtargetname != "none") {
      return 0;
    }

    if(self.unittype == "soldier" && var_0.unittype == "c6") {
      return 0;
    }

    if(self.unittype == "c6" && var_0.unittype == "c6i") {
      return 0;
    }

    if(var_0.unittype != "soldier" && var_0.unittype != "c6" && var_0.unittype != "c6i" && var_0.unittype != "civilian") {
      return 0;
    }
  }

  if(!isDefined(self.var_B622) || !self.var_B622 || !isplayer(var_0)) {
    if(isplayer(var_0)) {
      var_2 = var_0 getstance();
    } else {
      var_2 = var_1.a.pose;
    }

    if(var_2 != "stand" && var_2 != "crouch") {
      return 0;
    }
  }

  if(isDefined(self.var_B14F) && isDefined(var_0.var_B14F)) {
    return 0;
  }

  if(isDefined(var_0.objective_position)) {
    return 0;
  }

  return 1;
}