/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\missilelauncher.gsc
**********************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\vehicle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace missilelauncher;

function initmissilelauncherusage() {
  resetmissilelaunchertargets();
}

function resetmissilelaunchertargets() {
  self.missilelauncherstage = undefined;
  self.missilelaunchertarget = undefined;
  self.missilelauncherlockstarttime = undefined;
  self.missilelauncherlostsightlinetime = undefined;
}

function resetmissilelauncherlocking() {
  if(!isDefined(self.missilelauncheruseentered)) {
    return;
  }

  self.missilelauncheruseentered = undefined;
  self notify("7\x1d\xb7\x0e\xd7\xd4,\x9d+6Z\x9b\xbe\xb1\xdec\xadZ\xdc\xce_3Y\xac\x19&,\xc6\xb5");
  self notify("\x1f\x99\xf4\xb9\xd2\xb8w\xdf\xdb_\x9a\xf5o\x9c\xea5\b\xd4\x93\xae+E\v\x88\xda\x03\xaa$");
  self notify("o\xb1\x8f\xab_\xde\xf8zW\xb8\xbf\xf7\x9a\x02_\x1d.+\x83\xaa8\xbe\xf0EB");
  self weaponlockfree();
  self stoplocalsound("\x0e\xd0@\x97\x1fO\xd4/N\r#\xed\xed\xfe\x1b\x8d\x17\xed{\xbc\x9al");
  self stoplocalsound("\xc2D\x90\x02\xe6Lsy\xaf^K\xc7\x19\x18E5]h\xc4\xff");

  if(isDefined(self.missilelaunchertarget)) {
    namespace_bc7cdace2d7445a5::removelockedonsharedfunc(self.missilelaunchertarget, self);
  }

  resetmissilelaunchertargets();
}

function resetmissilelauncherlockingondeath() {
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self notify("\a\x17#xm\x88\xc7\x8f\x97\xdfB=\xf9\xc9\xeb\b\xb9\xfc\x9d\x989\xc2\xc7\xb7\xab+\xda`\x90DG\x11\xd3d");
  self endon("\a\x17#xm\x88\xc7\x8f\x97\xdfB=\xf9\xc9\xeb\b\xb9\xfc\x9d\x989\xc2\xc7\xb7\xab+\xda`\x90DG\x11\xd3d");
  self endon("\xac\f\xe9\xe5\x89\x0ev.H\x12u\x05");

  for(;;) {
    self waittill("\x1e\xfd\xd1\xa2\a");
    resetmissilelauncherlocking();
  }
}

function loopmissilelauncherlockingfeedback() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("7\x1d\xb7\x0e\xd7\xd4,\x9d+6Z\x9b\xbe\xb1\xdec\xadZ\xdc\xce_3Y\xac\x19&,\xc6\xb5");

  for(;;) {
    if(isDefined(level.chopper.gunner) && isDefined(level.chopper) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.chopper.gunner) {
      level.gunshipplayer playlocalsound("\xb2H\x9b\xf5\x12\xa8\xf8\xa0\xb7\n\x02\xe5{cl\x84\xf1");
    }

    if(isDefined(level.gunshipplayer) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.gunship.planemodel) {
      level.gunshipplayer playlocalsound("\xb2H\x9b\xf5\x12\xa8\xf8\xa0\xb7\n\x02\xe5{cl\x84\xf1");
    }

    self playlocalsound("\x0e\xd0@\x97\x1fO\xd4/N\r#\xed\xed\xfe\x1b\x8d\x17\xed{\xbc\x9al");
    self playRumbleOnEntity("\xd0\xa9\xb6\xda\x92\xbb]s\x12jE\x8f\xb7w\xd9");
    wait 0.6;
  }
}

function loopmissilelauncherlockedfeedback() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\x1f\x99\xf4\xb9\xd2\xb8w\xdf\xdb_\x9a\xf5o\x9c\xea5\b\xd4\x93\xae+E\v\x88\xda\x03\xaa$");
  self playlocalsound("\xc2D\x90\x02\xe6Lsy\xaf^K\xc7\x19\x18E5]h\xc4\xff");

  for(;;) {
    if(isDefined(level.chopper.gunner) && isDefined(level.chopper) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.chopper.gunner) {
      level.gunshipplayer playlocalsound("\xb2H\x9b\xf5\x12\xa8\xf8\xa0\xb7\n\x02\xe5{cl\x84\xf1");
    }

    if(isDefined(level.gunshipplayer) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.gunship.planemodel) {
      level.gunshipplayer playlocalsound("\xb2H\x9b\xf5\x12\xa8\xf8\xa0\xb7\n\x02\xe5{cl\x84\xf1");
    }

    self playRumbleOnEntity("\xd0\xa9\xb6\xda\x92\xbb]s\x12jE\x8f\xb7w\xd9");
    wait 0.25;
  }
}

function softsighttest(stingtargstruct) {
  lost_sight_limit = 500;

  if(stingtargstruct stingtargstruct_isinlos()) {
    self.missilelauncherlostsightlinetime = 0;
    return true;
  }

  if(self.missilelauncherlostsightlinetime == 0) {
    self.missilelauncherlostsightlinetime = gettime();
  }

  timepassed = gettime() - self.missilelauncherlostsightlinetime;

  if(timepassed >= lost_sight_limit) {
    resetmissilelauncherlocking();
    return false;
  }

  return true;
}

function missilelauncherusage() {
  var_10c54d95c082aad6 = getdvarint(@ "hash_eb7d16d9fa10a208", 625000000);
  var_e6dcf7f592b648ee = 0;

  var_e6dcf7f592b648ee = getdvarint(@ "hash_10368af4dee3ba2c", 0);

  if(!istrue(namespace_bc7cdace2d7445a5::ismissilelauncherlockonallowedsharedfunc())) {
    return;
  }

  if(self playerads() < 0.95) {
    resetmissilelauncherlocking();
    return;
  }

  self.missilelauncheruseentered = 1;

  if(!isDefined(self.missilelauncherstage)) {
    self.missilelauncherstage = 0;
  }

  missilelauncherdebugdraw(self.missilelaunchertarget);

  if(self.missilelauncherstage == 0) {
    targets = namespace_bc7cdace2d7445a5::lockonlaunchergettargetarraysharedfunc(0);

    if(targets.size == 0) {
      return;
    }

    targets = sortbydistance(targets, self.origin);
    stingtargstruct = undefined;
    var_65b08faab8302eae = 0;
    var_2550ac8a6a23e520 = level.sharedfuncs[#"flare_system"][#"hash_bb66c31dec02b91a"];

    foreach(target in targets) {
      if(!isDefined(target)) {
        continue;
      }

      if(isDefined(var_2550ac8a6a23e520)) {
        flaresystemresult = self[[var_2550ac8a6a23e520]](target);

        if(flaresystemresult != "|'\xf7>z\xd4Qcs\xda\x929#3") {
          continue;
        }
      }

      stingtargstruct = stingtargstruct_create(self, target);
      stingtargstruct stingtargstruct_getoffsets();
      stingtargstruct stingtargstruct_getorigins();
      stingtargstruct stingtargstruct_getinreticle();

      if(stingtargstruct stingtargstruct_isinreticle()) {
        if(distancesquared(target.origin, self.origin) > var_10c54d95c082aad6) {
          break;
        }

        var_65b08faab8302eae = 1;
        break;
      }
    }

    if(!var_65b08faab8302eae) {
      return;
    }

    stingtargstruct stingtargstruct_getinlos();

    if(!stingtargstruct stingtargstruct_isinlos()) {
      return;
    }

    self.missilelaunchertarget = stingtargstruct.target;
    self.missilelauncherlockstarttime = gettime();
    self.missilelauncherstage = 1;
    self.missilelauncherlostsightlinetime = 0;

    if(isDefined(self.missilelaunchertarget)) {
      namespace_bc7cdace2d7445a5::addlockedonsharedfunc(self.missilelaunchertarget, self);
    }

    thread loopmissilelauncherlockingfeedback();
  }

  if(self.missilelauncherstage == 1) {
    if(!isDefined(self.missilelaunchertarget)) {
      resetmissilelauncherlocking();
      return;
    }

    if(!var_e6dcf7f592b648ee && self.missilelaunchertarget vehicle::is_vehicle() && vehicle::function_32cf43628836dc68(self.missilelaunchertarget, self)) {
      resetmissilelauncherlocking();
      return;
    }

    stingtargstruct = stingtargstruct_create(self, self.missilelaunchertarget);
    stingtargstruct stingtargstruct_getoffsets();
    stingtargstruct stingtargstruct_getorigins();
    stingtargstruct stingtargstruct_getinreticle();

    if(!stingtargstruct stingtargstruct_isinreticle()) {
      resetmissilelauncherlocking();
      return;
    }

    stingtargstruct stingtargstruct_getinlos();

    if(!softsighttest(stingtargstruct)) {
      return;
    }

    utility::callsharedfunc(#"flare_system", #"hash_c402efcb2b8bce33", stingtargstruct.target);
    timepassed = gettime() - self.missilelauncherlockstarttime;
    locklength = level.missilelauncherlocklength ?? 500;

    if(namespace_bc7cdace2d7445a5::hasperksharedfunc("}p\xe2\xd9\x03\x17p\x03'\x0e\xbe\x84G\xfd\xa44\xe0\r\xd5\x93dA")) {
      if(timepassed < locklength * 0.5) {
        return;
      }
    } else if(timepassed < locklength) {
      return;
    }

    self notify("7\x1d\xb7\x0e\xd7\xd4,\x9d+6Z\x9b\xbe\xb1\xdec\xadZ\xdc\xce_3Y\xac\x19&,\xc6\xb5");
    thread loopmissilelauncherlockedfeedback();
    offset = undefined;
    missilelauncher_finalizelock(stingtargstruct);
    self.missilelauncherstage = 2;
  }

  if(self.missilelauncherstage == 2) {
    if(!isDefined(self.missilelaunchertarget)) {
      resetmissilelauncherlocking();
      return;
    }

    if(!var_e6dcf7f592b648ee && self.missilelaunchertarget vehicle::is_vehicle() && vehicle::function_32cf43628836dc68(self.missilelaunchertarget, self)) {
      resetmissilelauncherlocking();
      return;
    }

    stingtargstruct = stingtargstruct_create(self, self.missilelaunchertarget);
    stingtargstruct stingtargstruct_getoffsets();
    stingtargstruct stingtargstruct_getorigins();
    stingtargstruct stingtargstruct_getinreticle();
    stingtargstruct stingtargstruct_getinlos();

    if(!softsighttest(stingtargstruct)) {
      return;
    } else {
      missilelauncher_finalizelock(stingtargstruct);
    }

    if(!stingtargstruct stingtargstruct_isinreticle()) {
      resetmissilelauncherlocking();
      return;
    }

    utility::callsharedfunc(#"flare_system", #"hash_c402efcb2b8bce33", stingtargstruct.target);
  }
}

function missilelauncherusageloop() {
  if(!isPlayer(self)) {
    return;
  }

  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("1\x1b\xb1\x88\xd8\xf6x<y\xfb");
  self endon("\xac\f\xe9\xe5\x89\x0ev.H\x12u\x05");
  thread resetmissilelauncherlockingondeath();

  for(;;) {
    wait 0.05;
    missilelauncherusage();
  }
}

function missilelauncher_finalizelock(stingtargstruct) {
  offset = undefined;

  if(isDefined(stingtargstruct.target) && isDefined(stingtargstruct.target.vehiclename) && stingtargstruct.target.vehiclename == "\x85\x15\x9e\x937\xae\xd8\xebKy") {
    offset = (0, 0, 75);
  } else if(isDefined(stingtargstruct.inlosid)) {
    offset = stingtargstruct.offsets[stingtargstruct.inlosid];
    offset = (offset[1], -1 * offset[0], offset[2]);
  } else {
    offset = (0, 0, 0);
  }

  if(!isent(self.missilelaunchertarget)) {
    self weaponlockfinalize(self.missilelaunchertarget.origin, offset);
    return;
  }

  self weaponlockfinalize(self.missilelaunchertarget, offset);
  thread function_4997aa46a3d7afb1(stingtargstruct);
}

function function_4997aa46a3d7afb1(stingtargstruct) {
  self notify("\x9c\xdf\x90\xfd\x8b\x16\xe6\x16\x1e\xbeTY\x99\n\x91(");
  self endon("\x9c\xdf\x90\xfd\x8b\x16\xe6\x16\x1e\xbeTY\x99\n\x91(");
  self waittill("?\x80\x96\x17\xba\xc2\x16\xe1\x93u\xc1{", missile);

  if(isDefined(self) && isDefined(missile)) {
    utility::callsharedfunc(#"flare_system", #"attacker_fire_missile", missile, stingtargstruct.target);
    utility::callsharedfunc(#"missile_launcher", #"lockedon_missile_fired", self.missilelaunchertarget);
  }
}

function stingtargstruct_create(player, target) {
  struct = spawnStruct();
  struct.player = player;
  struct.target = target;
  struct.offsets = [];
  struct.origins = [];
  struct.inreticledistssqr = [];
  struct.inreticlesortedids = [];
  struct.inlosid = undefined;
  struct.useoldlosverification = 1;
  return struct;
}

function stingtargstruct_getoffsets() {
  self.offsets = [];

  if(utility::issharedfuncdefined(#"missile_launcher", #"stingOffsetsGameModeSpecific") && [[utility::getsharedfunc(#"missile_launcher", #"stingOffsetsGameModeSpecific")]]()) {
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "\x85\x15\x9e\x937\xae\xd8\xebKy") {
    self.offsets[self.offsets.size] = (0, 0, 72);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "z]BY\n\fY\xd7U\xe0\x03") {
    self.offsets[self.offsets.size] = (0, 0, 60);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && (self.target.vehiclename == "t$\xf4v}1J\x81q\xd6\xcc" || self.target.vehiclename == "P\xf3\xaaE^.\xebW\x14\xed,\x15\x16\x89")) {
    self.offsets[self.offsets.size] = (0, 0, 60);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "\xf1r\xd9\x13\x93\x90S\bj\xe095Z\xda\xdc") {
    self.offsets[self.offsets.size] = (0, 0, 65);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "\x10\xaa\xc3\xc7<kz-m\x9d|\xb5\x8f\xdf\r\x9e") {
    self.offsets[self.offsets.size] = (0, 0, 60);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && (self.target.vehiclename == "4\xff=+\x1e\xb9_)\xe1\v\xd1\x85" || self.target.vehiclename == "g\xc4\aB\xbe\x1d\xfa\xf1\xd9")) {
    self.offsets[self.offsets.size] = (0, 0, 55);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && (self.target.vehiclename == "O\xd1E`" || self.target.vehiclename == "\t\xfeA\xf3\xe4\\\x1bl\x9f")) {
    self.offsets[self.offsets.size] = (0, 0, 50);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && (self.target.vehiclename == "\a[|\xedw\x8d\a\xfcy" || self.target.vehiclename == "\xea.\t\xa8\xa1\xa2\x9b\xa7k\xa6\x85\xb9\xbe")) {
    self.offsets[self.offsets.size] = (0, 0, 20);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "7\x03\x1c\xcd\xfe\x13T\xd3\x9d\b\x86S") {
    self.offsets[self.offsets.size] = (0, 0, -100);
    self.useoldlosverification = 0;
    return;
  }

  self.offsets[self.offsets.size] = (0, 0, 0);
}

function stingtargstruct_getorigins() {
  origin = self.target.origin;
  angles = self.target.angles;
  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);

  for(i = 0; i < self.offsets.size; i++) {
    offset = self.offsets[i];
    self.origins[i] = origin + right * offset[0] + forward * offset[1] + up * offset[2];
  }
}

function stingtargstruct_getinreticle() {
  foreach(origin in self.origins) {
    for(i = 0; i < self.origins.size; i++) {
      screenpos = self.player worldpointtoscreenpos(self.origins[i], 65);

      if(isDefined(screenpos)) {
        distsqr = length2dsquared(screenpos);

        if(distsqr <= (level.var_d2f2cb73a0fef22c ?? 576)) {
          self.inreticlesortedids[self.inreticlesortedids.size] = i;
          self.inreticledistssqr[i] = distsqr;
        }
      }
    }
  }

  if(self.inreticlesortedids.size > 1) {
    for(i = 0; i < self.inreticlesortedids.size; i++) {
      for(j = i + 1; j < self.inreticlesortedids.size; j++) {
        i_id = self.inreticlesortedids[i];
        j_id = self.inreticlesortedids[j];
        var_c58d7dde6f472abc = self.inreticledistssqr[i_id];
        var_ca200a486cdecd21 = self.inreticledistssqr[j_id];

        if(var_ca200a486cdecd21 < var_c58d7dde6f472abc) {
          tempid = i_id;
          self.inreticlesortedids[i] = j_id;
          self.inreticlesortedids[j] = tempid;
        }
      }
    }
  }
}

function stingtargstruct_getinlos() {
  caststart = self.player getEye();
  contents = physics_createcontents(["\xb3 c1\xa3\xab\x05/\x96c\xec\x02~5\a\xadz\xb9\xe6\xd8B", "\xce\xd8oGC\x8e\xf6\xde\x1b\xfe\x1f\xe5\xc0\x88-eADHGN", "\x96)?\xdbyq7\xde\x80 \x99\xfc\x9e-\xfe\xa7\xcd\r\x13\xba", "\xc1\xa1^s\xd2c\x9b\xb1\xed\xdc\xe8+s\x8es\xd7\xe0\xb1X^Y9sosK\xb3\x86\x1d"]);

  if(!isent(self.target)) {
    ignorearr = [self.player];

    for(i = 0; i < self.inreticlesortedids.size; i++) {
      id = self.inreticlesortedids[i];
      castend = self.origins[id];
      castresults = physics_raycast(caststart, castend, contents, ignorearr, 0, "\x15\xac\x15z\xf1\xed\a\x06BQ,a]\xfb\x1d\xa4e9\xcft", 1);

      if(!isDefined(castresults) || castresults.size == 0) {
        self.inlosid = id;
        return;
      }
    }

    return;
  }

  ignorearr = [self.player, self.target];
  var_9874a57e99f9e9c9 = self.target getlinkedchildren();

  if(isDefined(var_9874a57e99f9e9c9) && var_9874a57e99f9e9c9.size > 0) {
    ignorearr = utility::array_combine(ignorearr, var_9874a57e99f9e9c9);
  }

  if(!self.useoldlosverification) {
    for(i = 0; i < self.inreticlesortedids.size; i++) {
      id = self.inreticlesortedids[i];
      castend = self.origins[id];
      castresults = physics_raycast(caststart, castend, contents, ignorearr, 0, "\x15\xac\x15z\xf1\xed\a\x06BQ,a]\xfb\x1d\xa4e9\xcft", 1);

      if(!isDefined(castresults) || castresults.size == 0) {
        self.inlosid = id;
        return;
      }
    }

    return;
  }

  top = self.target getpointinbounds(0, 0, 1);
  trace = trace::ray_trace(caststart, top, ignorearr, contents, 0);

  if(getDvar(@ "missiledebugdraw") == "<dev string:x24>") {
    playerangles = self.player getplayerangles();
    forward = anglesToForward(playerangles);
    left = anglestoleft(playerangles);
    hitpos = trace["<dev string:x29>"];
    sphere(hitpos, 10, (1, 0, 0), 0, 1);
    sphere(hitpos, 10, (0, 1, 0), 1, 1);
    disttohit = distance(caststart, hitpos);
    print3d(hitpos + left * -20, "<dev string:x35>" + disttohit, (1, 1, 1), 1, 1, 1);
    wingbasepos = self.player.origin;
    var_70b665e138bd8d46 = wingbasepos + left * 50;
    line(var_70b665e138bd8d46, hitpos, (0, 1, 0), 1, 1, 1);
    var_fa44e4f50bc2c0b5 = wingbasepos + left * -50;
    line(var_fa44e4f50bc2c0b5, hitpos, (0, 1, 0), 1, 1, 1);
    var_70b665e138bd8d46 += (0, 0, 100);
    line(var_70b665e138bd8d46, hitpos, (0, 1, 0), 1, 1, 1);
    var_fa44e4f50bc2c0b5 += (0, 0, 100);
    line(var_fa44e4f50bc2c0b5, hitpos, (0, 1, 0), 1, 1, 1);
  }

  if(trace["\xda\x16\x81\aw}^i"] == 1) {
    self.inlosid = 0;
    return;
  }

  front = self.target getpointinbounds(1, 0, 0);
  trace = trace::ray_trace(caststart, front, ignorearr, contents, 0);

  if(trace["\xda\x16\x81\aw}^i"] == 1) {
    self.inlosid = 0;
    return;
  }

  back = self.target getpointinbounds(-1, 0, 0);
  trace = trace::ray_trace(caststart, back, ignorearr, contents, 0);

  if(trace["\xda\x16\x81\aw}^i"] == 1) {
    self.inlosid = 0;
    return;
  }
}

function stingtargstruct_isinreticle() {
  return self.inreticlesortedids.size > 0;
}

function stingtargstruct_isinlos() {
  return isDefined(self.inlosid);
}

function debug_init() {
  setdevdvarifuninitialized(@ "hash_ad918199a0825d3a", 125);
  setdevdvarifuninitialized(@ "jackal_f", 250);
  setdevdvarifuninitialized(@ "jackal_f_up", 125);
  setdevdvarifuninitialized(@ "jackal_b", 425);
  setdevdvarifuninitialized(@ "jackal_b_up", 125);
  setdevdvarifuninitialized(@ "jackal_lr", 250);
  setdevdvarifuninitialized(@ "jackal_lr_up", 140);
  setdevdvarifuninitialized(@ "jackal_lr_back", 215);
  setdevdvarifuninitialized(@ "hash_9b2345c5373f7e68", 30);
  setdevdvarifuninitialized(@ "hash_a6d283ccfd72e0d2", 5);
  setdevdvarifuninitialized(@ "hash_c3840a33843aa1f2", 15);
  setdevdvarifuninitialized(@ "hash_5a2bc3bd648b860c", 42);
  setdevdvarifuninitialized(@ "hash_9bb2d0feba0e1fde", 5);
}

function missilelauncherdebugdraw(target) {
  if(getDvar(@ "missiledebugdraw") != "<dev string:x39>") {
    return;
  }

  if(!isDefined(target)) {
    return;
  }

  org = target.origin;
  drawstar(org);
  org = target getpointinbounds(1, 0, 0);
  drawstar(org);
  org = target getpointinbounds(-1, 0, 0);
  drawstar(org);
}

function drawstar(point) {
  line(point + (10, 0, 0), point - (10, 0, 0));
  line(point + (0, 10, 0), point - (0, 10, 0));
  line(point + (0, 0, 10), point - (0, 0, 10));
}

# /