/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\equipment\cp_stinger.gsc
***********************************************/

initstingerusage() {
  self.stingerstage = undefined;
  self.stingertarget = undefined;
  self.stingerlockstarttime = undefined;
  self.stingerlostsightlinetime = undefined;
  thread resetstingerlockingondeath();
}

resetstingerlocking() {
  if(!isDefined(self.stingeruseentered)) {
    return;
  }
  self.stingeruseentered = undefined;
  self notify("_encstr_916C1EFB61F092EFA2B1C3FA380B7301802F637BF3409F275C29CAF281578FC4");
  self notify("_encstr_8E571DD00B95B1BEF3015CDD14274027BD42D888B2EFB7D1A72D6D46F127A8");
  self notify("_encstr_93B4125763228080A55A2658058BA850CAA7CFD1");
  self weaponlockfree();
  self stoplocalsound("_encstr_99DE1718F711838F91C2E5751C0AE98947DB68E057A3987DFA");
  self stoplocalsound("_encstr_812F156096B1686E292B23195F323930772DA839BC1DA8");
  removehudincoming_attacker(self.stingertarget);
  initstingerusage();
}

resetstingerlockingondeath() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_8BFB1BCF8930D750CB686F36E275B83920C632ABE31AB0B5DFDBC79CAA");
  self endon("_encstr_8BFB1BCF8930D750CB686F36E275B83920C632ABE31AB0B5DFDBC79CAA");

  for(;;) {
    self waittill("_encstr_AD75063D571AE108");
    resetstingerlocking();
  }
}

watchlauncherusage() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  for(;;) {
    var_0 = self getcurrentweapon();
    runlauncherlogic(var_0.basename);

    switch (var_0.basename) {
      case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
      case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
        thread initstingerusage();
        break;
      case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
        break;
    }
  }
}

runlauncherlogic(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  switch (var_0) {
    case "_encstr_AD5210B0D388CF9573E1A8CF58B33C4120CA":
    case "_encstr_9B69114A571F8EBD17484FBA87220987C71A97":
      thread stingerusageloop();
      break;
    case "_encstr_AF2311A17CC2BFA57B490AF3F843DFAB86E920":
      break;
  }

  self waittill("_encstr_8A390E27D0D170F2D5A0CE0497ED4A2D");
}

loopstingerlockingfeedback() {
  self endon("_encstr_916C1EFB61F092EFA2B1C3FA380B7301802F637BF3409F275C29CAF281578FC4");
  self endon("_encstr_B1C80D5D9E631E21A65378089A7FD5");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.stingertarget) && self.stingertarget == level.chopper.gunner)
      level.ac130player playlocalsound("_encstr_AC50120AF16F3F3A11239663D778449384AE9263");

    if(isDefined(level.ac130player) && isDefined(self.stingertarget) && self.stingertarget == level.ac130.planemodel)
      level.ac130player playlocalsound("_encstr_AC50120AF16F3F3A11239663D778449384AE9263");

    self playlocalsound("_encstr_99DE1718F711838F91C2E5751C0AE98947DB68E057A3987DFA");
    self playRumbleOnEntity("_encstr_BEE110E2996F36F2F96D2575FBD1AFE776F1");
    wait 0.6;
  }
}

loopstingerlockedfeedback() {
  self endon("_encstr_8E571DD00B95B1BEF3015CDD14274027BD42D888B2EFB7D1A72D6D46F127A8");
  self endon("_encstr_B1C80D5D9E631E21A65378089A7FD5");
  self playlocalsound("_encstr_812F156096B1686E292B23195F323930772DA839BC1DA8");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.stingertarget) && self.stingertarget == level.chopper.gunner)
      level.ac130player playlocalsound("_encstr_AC50120AF16F3F3A11239663D778449384AE9263");

    if(isDefined(level.ac130player) && isDefined(self.stingertarget) && self.stingertarget == level.ac130.planemodel)
      level.ac130player playlocalsound("_encstr_AC50120AF16F3F3A11239663D778449384AE9263");

    self playRumbleOnEntity("_encstr_BEE110E2996F36F2F96D2575FBD1AFE776F1");
    wait 0.25;
  }
}

softsighttest(var_0) {
  var_1 = 500;

  if(var_0 stingtargstruct_isinlos()) {
    self.stingerlostsightlinetime = 0;
    return 1;
  }

  if(self.stingerlostsightlinetime == 0)
    self.stingerlostsightlinetime = gettime();

  var_2 = gettime() - self.stingerlostsightlinetime;

  if(var_2 >= var_1) {
    resetstingerlocking();
    return 0;
  }

  return 1;
}

stingerusage() {
  if(self playerads() < 0.95) {
    resetstingerlocking();
    return;
  }

  self.stingeruseentered = 1;

  if(!isDefined(self.stingerstage))
    self.stingerstage = 0;

  if(self.stingerstage == 0) {
    var_0 = lockonlaunchers_gettargetarray(0);

    if(var_0.size == 0) {
      return;
    }
    var_1 = self.origin;
    var_0 = sortbydistance(var_0, var_1);
    var_2 = undefined;
    var_3 = 0;

    foreach(var_5 in var_0) {
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
    self.stingertarget = var_2.target;
    self.stingerlockstarttime = gettime();
    self.stingerstage = 1;
    self.stingerlostsightlinetime = 0;
    addhudincoming_attacker(self.stingertarget);
    thread loopstingerlockingfeedback();
  }

  if(self.stingerstage == 1) {
    if(!isDefined(self.stingertarget)) {
      resetstingerlocking();
      return;
    }

    var_2 = stingtargstruct_create(self, self.stingertarget);
    var_2 stingtargstruct_getoffsets();
    var_2 stingtargstruct_getorigins();
    var_2 stingtargstruct_getinreticle();

    if(!var_2 stingtargstruct_isinreticle()) {
      resetstingerlocking();
      return;
    }

    var_2 stingtargstruct_getinlos();

    if(!softsighttest(var_2)) {
      return;
    }
    var_7 = gettime() - self.stingerlockstarttime;

    if(var_7 < 500) {
      return;
    }
    self notify("_encstr_916C1EFB61F092EFA2B1C3FA380B7301802F637BF3409F275C29CAF281578FC4");
    thread loopstingerlockedfeedback();
    var_8 = undefined;
    stinger_finalizelock(var_2);

    if(isDefined(level.activekillstreaks)) {}

    self.stingerstage = 2;
  }

  if(self.stingerstage == 2) {
    if(!isDefined(self.stingertarget)) {
      resetstingerlocking();
      return;
    }

    var_2 = stingtargstruct_create(self, self.stingertarget);
    var_2 stingtargstruct_getoffsets();
    var_2 stingtargstruct_getorigins();
    var_2 stingtargstruct_getinreticle();
    var_2 stingtargstruct_getinlos();

    if(!softsighttest(var_2))
      return;
    else
      stinger_finalizelock(var_2);

    if(!var_2 stingtargstruct_isinreticle()) {
      resetstingerlocking();
      return;
    }
  }
}

lockonlaunchers_gettargetarray(var_0) {
  var_1 = [];
  var_2 = 0;

  if(level.teambased) {
    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_4 in level.characters) {
        if(isDefined(var_4) && isalive(var_4) && (var_4.team != self.team || var_2))
          var_1[var_1.size] = var_4;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var_7 in level.activekillstreaks) {
        if(isDefined(var_7.affectedbylockon) && (var_7.team != self.team || var_2))
          var_1[var_1.size] = var_7;
      }
    }

    if(isDefined(level.all_spawned_vehicles)) {
      foreach(var_7 in level.all_spawned_vehicles)
      var_1[var_1.size] = var_7;
    }

    if(isDefined(level.remote_tanks)) {
      foreach(var_7 in level.remote_tanks)
      var_1[var_1.size] = var_7;
    }

    var_13 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_AF390B295782C3585F1B21D8C4");

    foreach(var_15 in var_13) {
      if(var_15.team != self.team || var_2)
        var_1[var_1.size] = var_15;
    }

    var_17 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_84D70A6B2BEF3C9B30A67164");

    foreach(var_19 in var_17) {
      if(isDefined(var_19.team) && var_19.team != self.team || var_2)
        var_1[var_1.size] = var_19;
    }

    var_21 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_9A8F0CB1A5E8471BB2EB894B39C8");

    foreach(var_23 in var_21) {
      if(var_23.team != self.team || var_2)
        var_1[var_1.size] = var_23;
    }

    var_25 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_9A120A1D8536F5E4ED3BB293");

    foreach(var_27 in var_25) {
      if(var_27.team != self.team || var_2)
        var_1[var_1.size] = var_27;
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(var_30 in level.cratedropdata.ac130s) {
          if(var_30.team != self.team || var_2)
            var_1[var_1.size] = var_30;
        }
      }
    }
  } else {
    if(isDefined(var_0) && var_0 == 1) {
      foreach(var_4 in level.characters) {
        if((!isDefined(var_4) || !isalive(var_4)) && !var_2) {
          continue;
        }
        var_1[var_1.size] = var_4;
      }
    }

    if(isDefined(level.activekillstreaks)) {
      foreach(var_7 in level.activekillstreaks) {
        if(isDefined(var_7.affectedbylockon) && (isDefined(var_7.owner) && var_7.owner != self || var_2))
          var_1[var_1.size] = var_7;
      }
    }

    if(isDefined(level.all_spawned_vehicles)) {
      foreach(var_7 in level.all_spawned_vehicles)
      var_1[var_1.size] = var_7;
    }

    if(isDefined(level.remote_tanks)) {
      foreach(var_7 in level.remote_tanks)
      var_1[var_1.size] = var_7;
    }

    if(isDefined(level.technicals)) {
      foreach(var_19 in level.technicals) {
        if(isDefined(var_19.owner) && var_19.owner != self || var_2)
          var_1[var_1.size] = var_19;
      }
    }

    var_13 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_AF390B295782C3585F1B21D8C4");

    foreach(var_15 in var_13) {
      if(var_15.owner != self || var_2)
        var_1[var_1.size] = var_15;
    }

    var_17 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_84D70A6B2BEF3C9B30A67164");

    foreach(var_19 in var_17) {
      if(var_19.owner != self || var_2)
        var_1[var_1.size] = var_19;
    }

    var_21 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_9A8F0CB1A5E8471BB2EB894B39C8");

    foreach(var_23 in var_21) {
      if(var_23.owner != self || var_2)
        var_1[var_1.size] = var_23;
    }

    var_25 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("_encstr_9A120A1D8536F5E4ED3BB293");

    foreach(var_27 in var_25) {
      if(var_27.owner != self || var_2)
        var_1[var_1.size] = var_27;
    }

    if(isDefined(level.cratedropdata)) {
      if(isDefined(level.cratedropdata.ac130s)) {
        foreach(var_30 in level.cratedropdata.ac130s) {
          if(var_30.owner != self || var_2)
            var_1[var_1.size] = var_30;
        }
      }
    }
  }

  var_52 = [];

  foreach(var_54 in var_1) {
    if(isDefined(var_54))
      var_52[var_52.size] = var_54;
  }

  var_1 = var_52;
  return var_1;
}

stingerusageloop() {
  if(!isPlayer(self)) {
    return;
  }
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91D70BC8AF032B0F1B734F731A");
  self endon("_encstr_B1C80D5D9E631E21A65378089A7FD5");
  initstingerusage();

  for(;;) {
    wait 0.05;
    stingerusage();
  }
}

stinger_finalizelock(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.inlosid)) {
    var_1 = var_0.offsets[var_0.inlosid];
    var_1 = (var_1[1], -1 * var_1[0], var_1[2]);
  } else
    var_1 = (0, 0, 0);

  self weaponlockfinalize(self.stingertarget, var_1);
}

addhudincoming_attacker(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0;

  if(isDefined(var_0.owner) && !isplayerkillstreak(var_0))
    var_1 = var_0.owner;

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  var_1 setclientomnvar("_encstr_ADF51BA0AF5768D33AED56DD42820BD0EF17D818BF09C0F3D1D347E65D", 1);
}

removehudincoming_attacker(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0;

  if(!isplayerkillstreak(var_0)) {
    if(!isDefined(var_0.owner)) {
      return;
    }
    var_1 = var_0.owner;
  }

  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  var_1 setclientomnvar("_encstr_ADF51BA0AF5768D33AED56DD42820BD0EF17D818BF09C0F3D1D347E65D", 0);
}

isplayerkillstreak(var_0) {
  if(!isDefined(var_0.activeplayerstreak))
    return 0;

  switch (var_0.activeplayerstreak) {
    default:
      return 0;
  }
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

  if(isapache(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -50);
    self.useoldlosverification = 0;
  } else if(isac130(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 50);
    self.useoldlosverification = 0;
  } else if(isclusterstrike(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 40);
    self.useoldlosverification = 0;
  } else if(isturret(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 42);
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
  } else if(isradardrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 10);
    self.useoldlosverification = 0;
  } else if(isscramblerdrone(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, 5);
    self.useoldlosverification = 0;
  } else if(isradarhelicopter(self.target)) {
    self.offsets[self.offsets.size] = (0, 0, -30);
    self.useoldlosverification = 0;
  } else if(isDefined(self.target.vehiclename) && self.target.vehiclename == "_encstr_8CC008133958C81BACCB") {
    self.offsets[self.offsets.size] = (0, 0, 72);
    self.useoldlosverification = 0;
  } else
    self.offsets[self.offsets.size] = (0, 0, 0);
}

isapache(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  var_1 = var_0.streakinfo.streakname == "_encstr_A3330F40DA85816BFF02D8CCFD2B50632A";
  var_2 = var_0.streakinfo.streakname == "_encstr_B88607820996877650";
  return var_1 || var_2;
}

isclusterstrike(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  var_1 = var_0.streakinfo.streakname == "_encstr_A2E60C6BC099B7E1A0A93A398F48";
  return var_1;
}

isuav(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  if(var_0.streakinfo.streakname == "_encstr_851904B59B34" || var_0.streakinfo.streakname == "_encstr_8C9D0C506F0B96A8F78B297BF313" || var_0.streakinfo.streakname == "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950")
    return 1;

  return 0;
}

isac130(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  var_1 = var_0.streakinfo.streakname == "_encstr_A937066AFF52FA4F";
  return var_1;
}

isradardrone(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  var_1 = var_0.streakinfo.streakname == "_encstr_81E01312A3403EA3C0F95B724025DFF7200FB79A11" || var_0.streakinfo.streakname == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC";
  return var_1;
}

isscramblerdrone(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  var_1 = var_0.streakinfo.streakname == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD";
  return var_1;
}

isradarhelicopter(var_0) {
  if(!isDefined(var_0.streakinfo))
    return 0;

  if(!isDefined(var_0.streakinfo.streakname))
    return 0;

  var_1 = var_0.streakinfo.streakname == "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60";
  return var_1;
}

isturret(var_0) {
  return isDefined(var_0.classname) && var_0.classname == "_encstr_97710C6B2DCD1BAF3AD54E4E598E";
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
    var_8 = scripts\engine\trace::ray_trace(var_0, self.origins[0], var_2, var_1, 0);

    if(var_8["_encstr_A53009A25003666B9818C6"] == 1) {
      self.inlosid = 0;
      return;
    }

    var_9 = self.target getpointinbounds(1, 0, 0);
    var_8 = scripts\engine\trace::ray_trace(var_0, var_9, var_2, var_1, 0);

    if(var_8["_encstr_A53009A25003666B9818C6"] == 1) {
      self.inlosid = 0;
      return;
    }

    var_10 = self.target getpointinbounds(-1, 0, 0);
    var_8 = scripts\engine\trace::ray_trace(var_0, var_10, var_2, var_1, 0);

    if(var_8["_encstr_A53009A25003666B9818C6"] == 1) {
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