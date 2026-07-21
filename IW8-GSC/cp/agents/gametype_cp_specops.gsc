/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\agents\gametype_cp_specops.gsc
***********************************************/

initmissilelauncherusage() {
  self.missilelauncherstage = undefined;
  self.missilelaunchertarget = undefined;
  self.missilelauncherlockstarttime = undefined;
  self.missilelauncherlostsightlinetime = undefined;
  thread resetmissilelauncherlockingondeath();
}

resetmissilelauncherlocking() {
  if(!isDefined(self.missilelauncheruseentered)) {
    return;
  }
  self.missilelauncheruseentered = undefined;
  self notify("_encstr_916C1EFB61F092EFA2B1C3FA380B7301802F637BF3409F275C29CAF281578FC4");
  self notify("_encstr_8E571DD00B95B1BEF3015CDD14274027BD42D888B2EFB7D1A72D6D46F127A8");
  self notify("_encstr_B4CF1ADAA59BE62DC6CA31B0AB9B6C0DCA9CBEB1BD8DB67D8DEDDCA3");
  self weaponlockfree();
  self stoplocalsound("_encstr_99DE1718F711838F91C2E5751C0AE98947DB68E057A3987DFA");
  self stoplocalsound("_encstr_812F156096B1686E292B23195F323930772DA839BC1DA8");

  if(isDefined(self.missilelaunchertarget))
    scripts\cp_mp\utility\weapon_utility::removelockedon(self.missilelaunchertarget, self);

  initmissilelauncherusage();
}

resetmissilelauncherlockingondeath() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_B6C623A4ACE6B2D19A969B37D28D953158AB37C61A564E26F61BB6B4E63BF4738859851DA1");
  self endon("_encstr_B6C623A4ACE6B2D19A969B37D28D953158AB37C61A564E26F61BB6B4E63BF4738859851DA1");

  for(;;) {
    self waittill("_encstr_AD75063D571AE108");
    resetmissilelauncherlocking();
  }
}

loopmissilelauncherlockingfeedback() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_916C1EFB61F092EFA2B1C3FA380B7301802F637BF3409F275C29CAF281578FC4");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.chopper.gunner)
      level.gunshipplayer playlocalsound("_encstr_AC50120AF16F3F3A11239663D778449384AE9263");

    if(isDefined(level.gunshipplayer) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.gunship.planemodel)
      level.gunshipplayer playlocalsound("_encstr_AC50120AF16F3F3A11239663D778449384AE9263");

    self playlocalsound("_encstr_99DE1718F711838F91C2E5751C0AE98947DB68E057A3987DFA");
    self playRumbleOnEntity("_encstr_BEE110E2996F36F2F96D2575FBD1AFE776F1");
    wait 0.6;
  }
}

loopmissilelauncherlockedfeedback() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8E571DD00B95B1BEF3015CDD14274027BD42D888B2EFB7D1A72D6D46F127A8");
  self playlocalsound("_encstr_812F156096B1686E292B23195F323930772DA839BC1DA8");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.chopper.gunner)
      level.gunshipplayer playlocalsound("_encstr_AC50120AF16F3F3A11239663D778449384AE9263");

    if(isDefined(level.gunshipplayer) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.gunship.planemodel)
      level.gunshipplayer playlocalsound("_encstr_AC50120AF16F3F3A11239663D778449384AE9263");

    self playRumbleOnEntity("_encstr_BEE110E2996F36F2F96D2575FBD1AFE776F1");
    wait 0.25;
  }
}

softsighttest(var_0) {
  var_1 = 500;

  if(var_0 stingtargstruct_isinlos()) {
    self.missilelauncherlostsightlinetime = 0;
    return 1;
  }

  if(self.missilelauncherlostsightlinetime == 0)
    self.missilelauncherlostsightlinetime = gettime();

  var_2 = gettime() - self.missilelauncherlostsightlinetime;

  if(var_2 >= var_1) {
    resetmissilelauncherlocking();
    return 0;
  }

  return 1;
}

missilelauncherusage() {
  var_0 = 0;

  if(self playerads() < 0.95) {
    resetmissilelauncherlocking();
    return;
  }

  self.missilelauncheruseentered = 1;

  if(!isDefined(self.missilelauncherstage))
    self.missilelauncherstage = 0;

  if(self.missilelauncherstage == 0) {
    var_1 = scripts\cp\cp_weapon::lockonlaunchers_gettargetarray(0);

    if(var_1.size == 0) {
      return;
    }
    var_1 = sortbydistance(var_1, self.origin);
    var_2 = undefined;
    var_3 = 0;

    foreach(var_5 in var_1) {
      if(!isDefined(var_5)) {
        continue;
      }
      var_2 = stingtargstruct_create(self, var_5);
      var_2 stingtargstruct_getoffsets();
      var_2 stingtargstruct_getorigins();
      var_2 stingtargstruct_getinreticle();

      if(var_2 stingtargstruct_isinreticle()) {
        var_3 = 1;
        break;
      }
    }

    if(!var_3) {
      return;
    }
    var_2 stingtargstruct_getinlos();

    if(!var_2 stingtargstruct_isinlos()) {
      return;
    }
    self.missilelaunchertarget = var_2.target;
    self.missilelauncherlockstarttime = gettime();
    self.missilelauncherstage = 1;
    self.missilelauncherlostsightlinetime = 0;

    if(isDefined(self.missilelaunchertarget))
      scripts\cp_mp\utility\weapon_utility::addlockedon(self.missilelaunchertarget, self);

    thread loopmissilelauncherlockingfeedback();
  }

  if(self.missilelauncherstage == 1) {
    if(!isDefined(self.missilelaunchertarget)) {
      resetmissilelauncherlocking();
      return;
    }

    if(!var_0 && (self.missilelaunchertarget scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::_id_141B9(self.missilelaunchertarget, self))) {
      resetmissilelauncherlocking();
      return;
    }

    var_2 = stingtargstruct_create(self, self.missilelaunchertarget);
    var_2 stingtargstruct_getoffsets();
    var_2 stingtargstruct_getorigins();
    var_2 stingtargstruct_getinreticle();

    if(!var_2 stingtargstruct_isinreticle()) {
      resetmissilelauncherlocking();
      return;
    }

    var_2 stingtargstruct_getinlos();

    if(!softsighttest(var_2)) {
      return;
    }
    var_7 = gettime() - self.missilelauncherlockstarttime;

    if(scripts\cp\utility::_hasperk("_encstr_ABED1773C08BE69F19195C59B8C1872A01F0EB7AD05F5CCF90")) {
      if(var_7 < 250.0)
        return;
    } else if(var_7 < 500) {
      return;
    }
    self notify("_encstr_916C1EFB61F092EFA2B1C3FA380B7301802F637BF3409F275C29CAF281578FC4");
    thread loopmissilelauncherlockedfeedback();
    var_8 = undefined;
    missilelauncher_finalizelock(var_2);

    if(isDefined(level.activekillstreaks)) {
      if(scripts\engine\utility::array_contains(level.activekillstreaks, self.missilelaunchertarget))
        thread scripts\cp\cp_player_battlechatter::killstreaklockedon(self.missilelaunchertarget.streakname);
    }

    self.missilelauncherstage = 2;
  }

  if(self.missilelauncherstage == 2) {
    if(!isDefined(self.missilelaunchertarget)) {
      resetmissilelauncherlocking();
      return;
    }

    if(!var_0 && (self.missilelaunchertarget scripts\cp_mp\vehicles\vehicle::isvehicle() && scripts\cp_mp\vehicles\vehicle::_id_141B9(self.missilelaunchertarget, self))) {
      resetmissilelauncherlocking();
      return;
    }

    var_2 = stingtargstruct_create(self, self.missilelaunchertarget);
    var_2 stingtargstruct_getoffsets();
    var_2 stingtargstruct_getorigins();
    var_2 stingtargstruct_getinreticle();
    var_2 stingtargstruct_getinlos();

    if(!softsighttest(var_2))
      return;
    else
      missilelauncher_finalizelock(var_2);

    if(!var_2 stingtargstruct_isinreticle()) {
      resetmissilelauncherlocking();
      return;
    }
  }
}

missilelauncherusageloop() {
  if(!isPlayer(self)) {
    return;
  }
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_B1C80D5D9E631E21A65378089A7FD5");
  initmissilelauncherusage();

  for(;;) {
    wait 0.05;
    missilelauncherusage();
  }
}

missilelauncher_finalizelock(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.inlosid)) {
    var_1 = var_0.offsets[var_0.inlosid];
    var_1 = (var_1[1], -1 * var_1[0], var_1[2]);
  } else
    var_1 = (0, 0, 0);

  self weaponlockfinalize(self.missilelaunchertarget, var_1);
}

addhudincoming_attacker(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0;

  if(isDefined(var_0.owner))
    var_1 = var_0.owner;

  if(!isDefined(var_1) || !isPlayer(var_1))
    return;
}

removehudincoming_attacker(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0;

  if(!isDefined(var_0.owner)) {
    return;
  }
  var_1 = var_0.owner;

  if(!isDefined(var_1) || !isPlayer(var_1))
    return;
}

stingtargstruct_create(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.player = var_0;
  var_2.target = var_1;
  var_2.offsets = [];
  var_2.origins = [];
  var_2.inreticledistssqr = [];
  var_2.inreticlesortedids = [];
  var_2.inlosid = undefined;
  var_2.useoldlosverification = 1;
  return var_2;
}

stingtargstruct_getoffsets() {
  self.offsets = [];

  if(scripts\cp\utility\entity::ischoppergunner(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -50);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::tutorial_jumpfromplane(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -50);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::issupporthelo(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -100);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::isgunship(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 50);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::isclusterstrike(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 40);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::isturret(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 42);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::isradardrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 10);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::isscramblerdrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 10);
    self.useoldlosverification = 0;
  } else if(scripts\cp\utility\entity::isradarhelicopter(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -30);
    self.useoldlosverification = 0;
  } else if(isDefined(self.target.vehiclename) && self.target.vehiclename == "_encstr_AF390B295782C3585F1B21D8C4") {
    self.offsets[self.offsets.size] = (0, 0, 72);
    self.useoldlosverification = 0;
  } else
    self.offsets[self.offsets.size] = (0, 0, 0);
}

stingtargstruct_getorigins() {
  var_0 = self.target.origin;
  var_1 = self.target.angles;
  var_2 = anglesToForward(var_1);
  var_3 = anglestoright(var_1);
  var_4 = anglestoup(var_1);

  for(var_5 = 0; var_5 < self.offsets.size; var_5++) {
    var_6 = self.offsets[var_5];
    self.origins[var_5] = var_0 + var_3 * var_6[0] + var_2 * var_6[1] + var_4 * var_6[2];
  }
}

stingtargstruct_getinreticle() {
  foreach(var_5, var_1 in self.origins) {
    for(var_2 = 0; var_2 < self.origins.size; var_2++) {
      var_3 = self.player worldpointtoscreenpos(self.origins[var_2], 65);

      if(isDefined(var_3)) {
        var_4 = length2dsquared(var_3);

        if(var_4 <= 7225) {
          self.inreticlesortedids[self.inreticlesortedids.size] = var_2;
          self.inreticledistssqr[var_2] = var_4;
        }
      }
    }
  }

  if(self.inreticlesortedids.size > 1) {
    for(var_2 = 0; var_2 < self.inreticlesortedids.size; var_2++) {
      for(var_6 = var_2 + 1; var_6 < self.inreticlesortedids.size; var_6++) {
        var_7 = self.inreticlesortedids[var_2];
        var_8 = self.inreticlesortedids[var_6];
        var_9 = self.inreticledistssqr[var_7];
        var_10 = self.inreticledistssqr[var_8];

        if(var_10 < var_9) {
          var_11 = var_7;
          self.inreticlesortedids[var_2] = var_8;
          self.inreticlesortedids[var_6] = var_11;
        }
      }
    }
  }
}

stingtargstruct_getinlos() {
  var_0 = self.player getEye();
  var_1 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);
  var_2 = [self.player, self.target];
  var_3 = self.target getlinkedchildren();

  if(isDefined(var_3) && var_3.size > 0)
    var_2 = scripts\engine\utility::array_combine(var_2, var_3);

  if(!self.useoldlosverification) {
    for(var_4 = 0; var_4 < self.inreticlesortedids.size; var_4++) {
      var_5 = self.inreticlesortedids[var_4];
      var_6 = self.origins[var_5];
      var_7 = physics_raycast(var_0, var_6, var_1, var_2, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

      if(!isDefined(var_7) || var_7.size == 0) {
        self.inlosid = var_5;
        return;
      }
    }
  } else {
    var_8 = self.target getpointinbounds(0, 0, 1);
    var_9 = scripts\engine\trace::ray_trace(var_0, var_8, var_2, var_1, 0);

    if(var_9["_encstr_A53009A25003666B9818C6"] == 1) {
      self.inlosid = 0;
      return;
    }

    var_10 = self.target getpointinbounds(1, 0, 0);
    var_9 = scripts\engine\trace::ray_trace(var_0, var_10, var_2, var_1, 0);

    if(var_9["_encstr_A53009A25003666B9818C6"] == 1) {
      self.inlosid = 0;
      return;
    }

    var_11 = self.target getpointinbounds(-1, 0, 0);
    var_9 = scripts\engine\trace::ray_trace(var_0, var_11, var_2, var_1, 0);

    if(var_9["_encstr_A53009A25003666B9818C6"] == 1) {
      self.inlosid = 0;
      return;
    }
  }
}

stingtargstruct_isinreticle() {
  return self.inreticlesortedids.size > 0;
}

stingtargstruct_isinlos() {
  return isDefined(self.inlosid);
}