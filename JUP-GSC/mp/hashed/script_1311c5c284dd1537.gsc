/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1311c5c284dd1537.gsc
*************************************************/

#using script_1311c5c284dd1537;
#using scripts\common\interactive;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\scriptable_door_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\callouts;
#using scripts\mp\damage;
#using scripts\mp\equipment;
#using scripts\mp\equipment\nvg;
#using scripts\mp\hostmigration;
#using scripts\mp\movers;
#using scripts\mp\outofbounds;
#using scripts\mp\supers;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\teams;
#namespace namespace_ff6dd778c8d54dc8;

function function_e24031140ed11f4f() {
  level.var_3e2a48a1c201b444 = [];
  scripts\engine\utility::registersharedfunc("deployable_camera", "attachXRays", &function_e4d938ad226591fd);
  level.var_bb0266f422d9afa3 = [];
}

function function_f0698aee89c18210(cameratype) {
  params = level.var_bb0266f422d9afa3[cameratype];
  assertex(isDefined(params), "<dev string:x1c>" + cameratype);
  return params;
}

function function_7c5e1578b6fc9166(grenade) {
  stuckdata = spawnStruct();
  childthread function_4ad19757691771f4(grenade, stuckdata);
  childthread function_dbd4125446485a2c(grenade, stuckdata);
  childthread function_7a1589c1a8d2cd25(grenade, stuckdata);
  grenade waittill("deployableCamera_returnStuck");
  return stuckdata;
}

function function_7a1589c1a8d2cd25(grenade, stuckdata) {
  grenade endon("deployableCamera_returnStuck");
  grenade waittill("missile_water_impact");
  stuckdata.isunderwater = 1;
}

function function_4ad19757691771f4(grenade, stuckdata) {
  grenade endon("deployableCamera_returnStuck");
  grenade waittill("missile_door_stuck", var_c1d84ab4c521636d);
  stuckdata.var_972c39a514f196d1 = var_c1d84ab4c521636d;
  grenade notify("deployableCamera_returnStuck");
}

function function_dbd4125446485a2c(grenade, stuckdata) {
  grenade endon("deployableCamera_returnStuck");
  grenade waittill("missile_stuck", stuckto);
  stuckdata.var_82d5e3b42d0191c9 = stuckto;
  waitframe();
  grenade notify("deployableCamera_returnStuck");
}

function function_ee24b83d39692536(vectorentity, stuckto, position, turret_name, turret_model, cameratype, var_d20dfbbbcd940269) {
  worldup = (0, 0, 1);
  grenadeup = anglestoup(vectorentity.angles);
  dotresult = vectordot(worldup, grenadeup);
  var_9745168c66baba25 = dotresult <= -0.707;
  var_9ffcc6e392e7660e = dotresult > -0.707 && dotresult <= 0.707;
  turretonground = dotresult > 0.707;
  mode = "";
  desiredpitch = 0;

  if(var_9745168c66baba25) {
    mode = "ceiling";
  } else if(var_9ffcc6e392e7660e) {
    desiredpitch = -90;
    mode = "wall";
  } else {
    mode = "ground";
  }

  turret = spawnturret("misc_turret", position, turret_name, 1, 1, desiredpitch);
  turret.mode = mode;
  turret setModel(turret_model);
  turret.team = self.team;

  if(!istrue(var_d20dfbbbcd940269)) {
    turret setturretowner(self);
    turret.owner = self;
    turret setotherent(self);
  }

  turret.origin = vectorentity.origin;
  turret.angles = vectorentity.angles;
  turret disableplayeruseforallplayers();
  turret setmode("sentry_offline");
  turret.cameratype = cameratype;
  destroyfunc = function_f0698aee89c18210(turret.cameratype).destroyfunc;

  level thread draw_angles(turret.angles, turret.origin, (1, 0, 0), 5000, 100);

  if(isDefined(stuckto)) {
    turret linkTo(stuckto);
    turret thread scripts\mp\equipment::function_4af015619e2534ba(stuckto, destroyfunc, 0);
    turret.moving_platform = stuckto;
    data = spawnStruct();
    data.linkparent = turret.moving_platform;
    data.deathoverridecallback = destroyfunc;
    data.validateaccuratetouching = 1;
    turret thread scripts\mp\movers::handle_moving_platforms(data);
    turret thread function_15380cdf3e4666e6(destroyfunc);
  } else if(isDefined(level.wztrain_info)) {
    data = spawnStruct();
    data.deathoverridecallback = destroyfunc;
    turret thread scripts\mp\movers::handle_moving_platforms(data);
  }

  return turret;
}

function function_15380cdf3e4666e6(destroyfunc) {
  self endon("death");

  while(isDefined(self getlinkedparent())) {
    waitframe();
  }

  self[[destroyfunc]]();
}

function function_5d36462331845d5f(var_4664ee07ad6b2cbd) {
  if(!isDefined(level.var_d381da74cc527ec5)) {
    level.var_d381da74cc527ec5 = [];
  }

  level.var_d381da74cc527ec5[var_4664ee07ad6b2cbd] = [];

  foreach(team in level.teamnamelist) {
    level.var_d381da74cc527ec5[var_4664ee07ad6b2cbd][team] = [];
  }
}

function function_b1d73dd45d89a318(cameratype) {
  params = function_f0698aee89c18210(cameratype);

  if(!isDefined(self.var_d381da74cc527ec5)) {
    self.var_d381da74cc527ec5 = [];
  }

  if(!isDefined(self.var_d381da74cc527ec5[params.groupnameplayer])) {
    self.var_d381da74cc527ec5[params.groupnameplayer] = [];
  }
}

function function_c827c58258222d48(cameratype) {
  params = function_f0698aee89c18210(cameratype);

  if(level.teambased) {
    return function_78871160104c5295(params.groupnameteams);
  }

  return self.var_d381da74cc527ec5[params.groupnameplayer];
}

function function_e60e9ce3b6484e52(cameratype) {
  params = function_f0698aee89c18210(cameratype);

  if(isDefined(params)) {
    var_494d71491a409c84 = function_78871160104c5295(params.groupnameteams);

    if(isDefined(var_494d71491a409c84) && var_494d71491a409c84.size > 0) {
      if(isDefined(params.var_5b125df6b587a5c2) && var_494d71491a409c84.size >= params.var_5b125df6b587a5c2) {
        return true;
      }
    }
  }

  return false;
}

function private function_78871160104c5295(var_4664ee07ad6b2cbd) {
  if(!isDefined(level.var_d381da74cc527ec5[var_4664ee07ad6b2cbd])) {
    level.var_d381da74cc527ec5[var_4664ee07ad6b2cbd] = [];
  }

  if(!isDefined(level.var_d381da74cc527ec5[var_4664ee07ad6b2cbd][self.team])) {
    level.var_d381da74cc527ec5[var_4664ee07ad6b2cbd][self.team] = [];
  }

  if(shouldmodesetsquads() && !isDefined(level.var_d381da74cc527ec5[var_4664ee07ad6b2cbd][self.team][self.sessionsquadid])) {
    level.var_d381da74cc527ec5[var_4664ee07ad6b2cbd][self.team][self.sessionsquadid] = [];
  }

  if(shouldmodesetsquads()) {
    return level.var_d381da74cc527ec5[var_4664ee07ad6b2cbd][self.team][self.sessionsquadid];
  }

  return level.var_d381da74cc527ec5[var_4664ee07ad6b2cbd][self.team];
}

function private function_b785abae83e23e41(var_4664ee07ad6b2cbd, val) {
  if(shouldmodesetsquads()) {
    level.var_d381da74cc527ec5[var_4664ee07ad6b2cbd][self.team][self.sessionsquadid] = val;
    return;
  }

  level.var_d381da74cc527ec5[var_4664ee07ad6b2cbd][self.team] = val;
}

function function_9c46884fe9337fa7(camera) {
  params = function_f0698aee89c18210(camera.cameratype);
  teamref = camera.owner.team;

  if(!isDefined(level.var_d381da74cc527ec5)) {
    level.var_d381da74cc527ec5 = [];
  }

  if(!isDefined(level.var_d381da74cc527ec5[params.groupnameteams])) {
    level.var_d381da74cc527ec5[params.groupnameteams] = [];
  }

  if(!isDefined(level.var_d381da74cc527ec5[params.groupnameteams][teamref])) {
    level.var_d381da74cc527ec5[params.groupnameteams][teamref] = [];
  }

  if(shouldmodesetsquads() && !isDefined(function_78871160104c5295(params.groupnameteams))) {
    level.var_d381da74cc527ec5[params.groupnameteams][teamref][self.sessionsquadid] = [];
  }

  foundindex = undefined;
  var_494d71491a409c84 = function_78871160104c5295(params.groupnameteams);
  arraysize = var_494d71491a409c84.size;
  var_6de7667c11dfc31a = 0;

  while(true) {
    for(i = 0; i <= arraysize; i++) {
      if(i == arraysize) {
        foundindex = i;
        var_6de7667c11dfc31a = 1;
        break;
      }

      currentcam = var_494d71491a409c84[i];

      if(!isDefined(currentcam.cameraindex) || istrue(currentcam.isdestroyed)) {
        break;
      }

      if(currentcam.cameraindex != i) {
        foundindex = i;
        var_6de7667c11dfc31a = 1;
        break;
      }
    }

    if(var_6de7667c11dfc31a) {
      break;
    }

    waitframe();
  }

  var_494d71491a409c84 = array_add(var_494d71491a409c84, camera);
  camera.cameraindex = foundindex;
  function_b785abae83e23e41(params.groupnameteams, array_sort_with_func(var_494d71491a409c84, &function_15a4c63a63af8b6b));
  level notify(params.additionnotification, camera, camera.cameraindex);
}

function function_e5a484f7c5faf5b(camera) {
  if(!isDefined(self) || !isalive(self) || !isDefined(camera) || istrue(camera.isdestroyed)) {
    return 0;
  }

  return 1;
}

function function_f5cda4da64c5c579(camera) {
  level endon("game_ended");
  params = function_f0698aee89c18210(camera.cameratype);
  teamref = self.team;
  level notify(params.removalnotification, camera, camera.cameraindex);

  if(shouldmodesetsquads()) {
    if(isDefined(level.var_d381da74cc527ec5[params.groupnameteams][teamref][self.sessionsquadid])) {
      level.var_d381da74cc527ec5[params.groupnameteams][teamref][self.sessionsquadid] = array_remove(level.var_d381da74cc527ec5[params.groupnameteams][teamref][self.sessionsquadid], camera);

      if(level.var_d381da74cc527ec5[params.groupnameteams][teamref][self.sessionsquadid].size == 0) {
        level.var_d381da74cc527ec5[params.groupnameteams][teamref][self.sessionsquadid] = undefined;
      }
    } else {
      assertmsg("<dev string:x4e>" + params.groupnameteams + "<dev string:x6c>" + teamref + "<dev string:x74>" + self.sessionsquadid + "<dev string:x7b>");
    }
  } else if(isDefined(level.var_d381da74cc527ec5[params.groupnameteams][teamref])) {
    level.var_d381da74cc527ec5[params.groupnameteams][teamref] = array_remove(level.var_d381da74cc527ec5[params.groupnameteams][teamref], camera);

    if(level.var_d381da74cc527ec5[params.groupnameteams][teamref].size == 0) {
      level.var_d381da74cc527ec5[params.groupnameteams][teamref] = undefined;
    }
  } else {
    assertmsg("<dev string:x4e>" + params.groupnameteams + "<dev string:x6c>" + teamref + "<dev string:x7b>");
  }

  camera.cameraindex = undefined;
}

function function_8e7c5f27949002c7() {
  if(level.teambased) {
    squadsenabled = shouldmodesetsquads();

    if(squadsenabled) {
      return scripts\mp\utility\teams::getsquadmates(self.owner.team, self.owner.squadindex, 0);
    } else {
      return getteamdata(self.ownerteam, "players");
    }

    return;
  }

  return self.owner;
}

function function_86b60845e9a3d301(camtype) {
  params = function_f0698aee89c18210(camtype);
  self.var_d381da74cc527ec5[params.groupnameplayer] = undefined;
}

function private function_cf9aa20eb9489de5(var_d2eee016e3820550) {
  return isDefined(self.var_d381da74cc527ec5) && isDefined(self.var_d381da74cc527ec5[var_d2eee016e3820550]);
}

function function_3265a4a8a3bdb477(camtype) {
  params = function_f0698aee89c18210(camtype);
  return isDefined(self.var_d381da74cc527ec5) && isDefined(self.var_d381da74cc527ec5[params.groupnameplayer]) && self.var_d381da74cc527ec5[params.groupnameplayer].size > 0;
}

function function_f7a32619bba6e450(camtype) {
  params = function_f0698aee89c18210(camtype);

  if(function_cf9aa20eb9489de5(params.groupnameplayer)) {
    foreach(camera in self.var_d381da74cc527ec5[params.groupnameplayer]) {
      camera thread[[params.destroyfunc]](1);
    }
  }
}

function function_99f14479415346e9(camera) {
  params = function_f0698aee89c18210(camera.cameratype);

  if(!isDefined(self.var_d381da74cc527ec5)) {
    self.var_d381da74cc527ec5 = [];
  }

  if(!isDefined(self.var_d381da74cc527ec5[params.groupnameplayer])) {
    self.var_d381da74cc527ec5[params.groupnameplayer] = [];
  }

  cameralist = self.var_d381da74cc527ec5[params.groupnameplayer];
  cameralist[cameralist.size] = camera;
  cameralist = array_sort_with_func(cameralist, &function_945c96ad7442451f);

  if(cameralist.size > params.var_1790d4c69d5f45a4) {
    var_e297b70980f770a3 = cameralist[cameralist.size - 1];
    var_e10e5a74d99b447a = cameralist[0];

    if(isDefined(var_e297b70980f770a3.ownerindex)) {
      var_e10e5a74d99b447a.ownerindex = var_e297b70980f770a3.ownerindex;

      if(!level.teambased) {
        camera.cameraindex = var_e10e5a74d99b447a.ownerindex;
      }
    }

    cameralist[cameralist.size - 1][[params.destroyfunc]](1, 1);
    cameralist = array_remove(cameralist, cameralist[cameralist.size - 1]);
  } else {
    if(isDefined(cameralist[1])) {
      camera.ownerindex = ter_op(cameralist[1].ownerindex == 0, 1, 0);
    } else {
      camera.ownerindex = 0;
    }

    if(!level.teambased) {
      camera.cameraindex = camera.ownerindex;
    }
  }

  self.var_d381da74cc527ec5[params.groupnameplayer] = cameralist;
}

function function_4be323b74b86dbc9(camera) {
  params = function_f0698aee89c18210(camera.cameratype);

  if(!isDefined(self.owner.var_d381da74cc527ec5) || !isDefined(self.owner.var_d381da74cc527ec5[params.groupnameplayer])) {
    return;
  }

  self.owner.var_d381da74cc527ec5[params.groupnameplayer] = array_remove(self.owner.var_d381da74cc527ec5[params.groupnameplayer], self);
}

function function_cef7db6abfe1ceeb(camera) {
  self endon("disconnect");
  camera endon("death");

  if(!isDefined(camera.ownerindex)) {
    return;
  }

  while(!istrue(camera.isdestroyed)) {
    var_5f04179f0ece1fa3 = distance(self.origin, camera.origin);
    var_5f04179f0ece1fa3 = int(floor(var_5f04179f0ece1fa3 * 0.0254));
    self setclientomnvar("ui_tactical_camera_cam_" + camera.ownerindex + "_distance", var_5f04179f0ece1fa3);
    wait 0.2;
  }
}

function private function_945c96ad7442451f(a, b) {
  if(a.creationtime > b.creationtime) {
    return 1;
  }

  return 0;
}

function private function_15a4c63a63af8b6b(a, b) {
  if(a.cameraindex < b.cameraindex) {
    return 1;
  }

  return 0;
}

function private function_583884ac581c52a4() {
  return scripts\mp\callouts::function_45d5ee5f369ad604(self);
}

function function_45a7e0edc973d037() {
  level endon("game_ended");
  self endon("explode");
  self endon("death");
  self.areaid = -1;
  notif = function_f0698aee89c18210(self.cameratype).var_315c43d476bb095;

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return;
  }

  while(true) {
    var_a69d4e3f623c9031 = function_583884ac581c52a4();

    if(isDefined(var_a69d4e3f623c9031) && self.areaid != var_a69d4e3f623c9031) {
      self.areaid = var_a69d4e3f623c9031;
      level notify(notif, self);
    }

    wait 0.1;
  }
}

function function_23cf186c8b512748() {
  self endon("death");
  self.madedamageable = 1;
  params = function_f0698aee89c18210(self.cameratype);
  thread scripts\mp\damage::monitordamage(params.maxhealth, "hitequip", params.var_604c545b594e97ec, params.damagehandler);
}

function function_da29e274cc4a86f4(camera) {
  camera endon("death");
  self endon("disconnect");
  level endon("game_ended");
  timeoutduration = function_f0698aee89c18210(camera.cameratype).lifetime;
  timeelapsed = 0;

  while(timeelapsed < timeoutduration) {
    timepercent = (timeoutduration - timeelapsed) / timeoutduration;
    timepercent = int(ceil(clamp(timepercent, 0, 1) * 100));
    camera.batterytime = timepercent;
    timeelapsed += level.framedurationseconds;
    waitframe();
  }
}

function function_b0210563a392f1a1(camera) {
  camera endon("death");
  self endon("stopMonitoringReticleState");
  self endon("disconnect");
  reticlestate = 0;

  while(true) {
    if(istrue(camera.markingtarget) && reticlestate == 0) {
      self setclientomnvar("ui_rcd_outer_ring", 1);
      reticlestate = 1;
    } else if(!istrue(camera.markingtarget) && reticlestate == 1) {
      self setclientomnvar("ui_rcd_outer_ring", 0);
      reticlestate = 0;
    }

    waitframe();
  }
}

function private function_d506961e2710d1e1() {
  if(!isDefined(self.var_dae7e92e87a31e4)) {
    return false;
  }

  if(self.var_dae7e92e87a31e4.size > 0) {
    return true;
  }

  return false;
}

function function_d103dc61e5b6abc3(player) {
  if(!isDefined(player)) {
    return;
  }

  if(level.teambased) {
    if(!isDefined(level.teammarkedents) || !isDefined(level.teammarkedents[player.team])) {
      return;
    }

    if(shouldmodesetsquads()) {
      if(isDefined(level.teammarkedents[player.team][player.sessionsquadid])) {
        return level.teammarkedents[player.team][player.sessionsquadid];
      } else {
        return;
      }
    } else {
      return level.teammarkedents[player.team];
    }

    return;
  }

  return player.markedents;
}

function private function_f91c0feb9232b257(target) {
  if(!isDefined(target)) {
    return false;
  }

  markcluster = function_d103dc61e5b6abc3(self);

  if(!isDefined(markcluster)) {
    return false;
  }

  markdata = markcluster[target getentitynumber()];

  if(!isDefined(markdata)) {
    return false;
  }

  return istrue(markdata.reconmarked);
}

function private function_74598558cd270375(defaulticon, defaultoffset, target) {
  weaponicon = defaulticon;
  weaponoffset = defaultoffset;
  weaponstruct = spawnStruct();

  if(isDefined(target.weapon_name)) {
    weaponref = undefined;

    if(issubstr(target.weapon_name, "claymore")) {
      weaponref = "equip_claymore";
    } else if(issubstr(target.weapon_name, "c4")) {
      weaponref = "equip_c4";
    } else if(issubstr(target.weapon_name, "atMine")) {
      weaponref = "equip_at_mine";
    } else if(issubstr(target.weapon_name, "trophy")) {
      weaponref = "equip_trophy";
    }

    if(isDefined(weaponref)) {
      equipinfo = undefined;

      if(issharedfuncdefined("equipment", "getEquipmentTableInfo")) {
        equipinfo = [[getsharedfunc("equipment", "getEquipmentTableInfo")]](weaponref);
      }

      weaponicon = equipinfo.image;
    }
  } else if(isDefined(target.streakinfo)) {
    streakref = target.streakinfo.streakname;
    bundle = level.streakglobals.streakbundles[streakref];
    weaponicon = ter_op(isDefined(bundle) && isDefined(bundle.overheadicon), bundle.overheadicon, "");
    weaponoffset = 75;
  }

  weaponstruct.weaponicon = weaponicon;
  weaponstruct.weaponoffset = weaponoffset;
  return weaponstruct;
}

function private function_c2c3f444cfeb61ca(markdata, player) {
  markingplayer = undefined;

  if(isDefined(markdata.markingent.pilot)) {
    markingplayer = markdata.markingent.pilot;
  } else {
    markingplayer = markdata.markingent.owner;
  }

  if(level.teambased) {
    if(shouldmodesetsquads()) {
      ownersquad = getsquadmates(markingplayer.team, markingplayer.sessionsquadid, 0);
      return array_contains(ownersquad, player);
    } else {
      return scripts\cp_mp\utility\player_utility::isfriendly(markingplayer.team, player);
    }

    return;
  }

  return player == markingplayer;
}

function function_7d61d7b52c318d47() {
  self endon("disconnect");

  if(istrue(isusingremote())) {
    return;
  }

  visionset = "recon_drone_flash";

  if(istrue(self.pers["useNVG"])) {
    visionset = "recon_drone_flash_nvg";
  }

  self visionsetfadetoblackforplayer(visionset, 0.05);
  wait 0.08;
  self visionsetfadetoblackforplayer("", 1.2);
}

function function_748f3520a7e525a9() {
  if(!isDefined(self.markedomnvar)) {
    self.markedomnvar = 1;
    self setclientomnvar("ui_rcd_target_notify", self.markedomnvar);
    thread function_bebd32f6bc2a781f();
    return;
  }

  if(self.markedomnvar == 1) {
    self.markedomnvar = 2;
  } else {
    self.markedomnvar = 1;
  }

  self setclientomnvar("ui_rcd_target_notify", self.markedomnvar);
}

function private function_bebd32f6bc2a781f() {
  self endon("disconnect");
  self notify("markedUIUpdate");
  self endon("markedUIUpdate");

  if(issharedfuncdefined("helper_drone", "get_mark_ui_duration")) {
    wait self[[getsharedfunc("helper_drone", "get_mark_ui_duration")]]();
  } else {
    wait 3;
  }

  thread function_3c3a95d13d184ac5();
}

function private function_3c3a95d13d184ac5() {
  self notify("markedUIUpdate");
  self.markedomnvar = undefined;
  self setclientomnvar("ui_rcd_target_notify", 0);
}

function private function_29e7d04cb1f3e556(player) {
  scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headiconbox, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconfaction, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconalert, player);
}

function private function_bf967bc1ac455bdf(player) {
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconbox, player);
  scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headiconfaction, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconalert, player);
}

function private function_7254a960f447a69b(player) {
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconbox, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconfaction, player);
  scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headiconalert, player);
}

function private function_2f6abcf7fcc02f(player) {
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconbox, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconfaction, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconalert, player);
}

function function_67240db2bf930ccd() {
  if(isDefined(self.headiconbox)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconbox);
    self.headiconbox = undefined;
  }

  if(isDefined(self.headiconfaction)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconfaction);
    self.headiconfaction = undefined;
  }

  if(isDefined(self.headiconalert)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconalert);
    self.headiconalert = undefined;
  }
}

function private function_686c35e781f41189(supername) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      return;
    }

    function_ea3e848c25e3c926(player, undefined, supername);
  }
}

function private function_49aabe4cb7c4c0a4(player, supername) {
  if(isDefined(player.super) && player.super.staticdata.ref == supername) {
    return 1;
  }

  return 0;
}

function function_ea3e848c25e3c926(player, unset, supername) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.owner)) {
    return;
  }

  if(!isDefined(player)) {
    return;
  }

  idbox = self.headiconbox;

  if(!isDefined(idbox)) {
    return;
  }

  idfaction = self.headiconfaction;

  if(!isDefined(idfaction)) {
    return;
  }

  idalert = self.headiconalert;

  if(!isDefined(idalert)) {
    return;
  }

  isfriendly = scripts\cp_mp\utility\player_utility::isfriendly(self.owner.team, player);
  usingcamerasuper = function_49aabe4cb7c4c0a4(player, supername);

  if(isfriendly) {
    if(istrue(unset)) {
      function_bf967bc1ac455bdf(player);
      return;
    }

    if(function_d506961e2710d1e1()) {
      function_7254a960f447a69b(player);
      return;
    }

    if(usingcamerasuper) {
      if(istrue(player.isusingcamera)) {
        function_2f6abcf7fcc02f(player);
        return;
      }

      function_29e7d04cb1f3e556(player);
      return;
    } else {
      function_bf967bc1ac455bdf(player);
    }

    return;
  }

  function_2f6abcf7fcc02f(player);
}

function function_8b5781dd2d18a300(player) {
  var_c1a442604b2c5e96 = player function_eaf65bb46d1bd1a8();

  if(!isDefined(var_c1a442604b2c5e96)) {
    return undefined;
  }

  if(!level.teambased) {
    return undefined;
  }

  teammates = undefined;
  squadsenabled = shouldmodesetsquads();

  if(var_c1a442604b2c5e96 == self) {
    if(squadsenabled) {
      teammates = scripts\mp\utility\teams::getsquadmates(player.team, player.sessionsquadid, 1);
    } else {
      teammates = getteamdata(player.team, "players");
    }

    foreach(teammate in teammates) {
      if(teammate == player) {
        continue;
      }

      if(!istrue(teammate.isusingcamera)) {
        continue;
      }

      scripts\cp_mp\targetmarkergroups::setnewowner(player.var_8cc5d2e4cfbf42b0, teammate);

      if(squadsenabled) {
        level.var_8cc5d2e4cfbf42b0[player.team][player.sessionsquadid] = teammate;
        level.var_8cc5d2e4cfbf42b0[player.team][player.sessionsquadid].var_8cc5d2e4cfbf42b0 = player.var_8cc5d2e4cfbf42b0;
      } else {
        level.var_8cc5d2e4cfbf42b0[player.team] = teammate;
        level.var_8cc5d2e4cfbf42b0[player.team].var_8cc5d2e4cfbf42b0 = player.var_8cc5d2e4cfbf42b0;
      }

      player.var_8cc5d2e4cfbf42b0 = undefined;
      scripts\cp_mp\targetmarkergroups::function_fd770a1099036688(level.var_8cc5d2e4cfbf42b0[player.team].var_8cc5d2e4cfbf42b0, player);
      return teammate;
    }

    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_c1a442604b2c5e96.var_8cc5d2e4cfbf42b0);

    if(squadsenabled) {
      level.var_8cc5d2e4cfbf42b0[player.team][player.sessionsquadid] = undefined;
    } else {
      level.var_8cc5d2e4cfbf42b0[player.team] = undefined;
    }
  }

  return undefined;
}

function private function_eaf65bb46d1bd1a8() {
  var_e1c6011321fd25b9 = undefined;
  team = self.team;

  if(level.teambased) {
    if(!isDefined(level.var_8cc5d2e4cfbf42b0) || !isDefined(level.var_8cc5d2e4cfbf42b0[team])) {
      return undefined;
    }

    if(shouldmodesetsquads()) {
      if(!isDefined(level.var_8cc5d2e4cfbf42b0[team][self.sessionsquadid])) {
        return undefined;
      } else {
        return level.var_8cc5d2e4cfbf42b0[team][self.sessionsquadid];
      }
    } else {
      return level.var_8cc5d2e4cfbf42b0[team];
    }

    return;
  }

  if(isDefined(self.var_8cc5d2e4cfbf42b0)) {
    return self;
  }
}

function function_bfcdb898d70f248c() {
  team = self.team;
  var_e1c6011321fd25b9 = function_eaf65bb46d1bd1a8();

  if(!isDefined(var_e1c6011321fd25b9) || !isDefined(var_e1c6011321fd25b9.var_8cc5d2e4cfbf42b0)) {
    return;
  }

  if(level.teambased) {
    newowner = undefined;

    if(var_e1c6011321fd25b9 == self) {
      newowner = function_8b5781dd2d18a300(self);

      if(isDefined(newowner)) {
        scripts\cp_mp\targetmarkergroups::function_fd770a1099036688(newowner.var_8cc5d2e4cfbf42b0, self);
      }
    } else {
      scripts\cp_mp\targetmarkergroups::function_fd770a1099036688(var_e1c6011321fd25b9.var_8cc5d2e4cfbf42b0, self);
    }

    return;
  }

  scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(var_e1c6011321fd25b9.var_8cc5d2e4cfbf42b0);
  var_e1c6011321fd25b9.var_8cc5d2e4cfbf42b0 = undefined;
}

function function_ec57e0acbc6c6879(markergroup, target, state) {
  firstbit = (state >> 0) % 2 == 1;
  secondbit = (state >> 1) % 2 == 1;
  targetmarkergroupsetentitystate(markergroup, target, firstbit);
  targetmarkergroupsetextrastate(markergroup, target, secondbit);
}

function function_c9ad5aaf3183b83c() {
  markedents = function_d103dc61e5b6abc3(self);

  if(!isDefined(self)) {
    return;
  }

  if(level.teambased) {
    if(!isDefined(level.var_8cc5d2e4cfbf42b0)) {
      level.var_8cc5d2e4cfbf42b0 = [];
    }

    if(shouldmodesetsquads()) {
      if(!isDefined(level.var_8cc5d2e4cfbf42b0[self.team])) {
        level.var_8cc5d2e4cfbf42b0[self.team] = [];
      }

      if(!isDefined(level.var_8cc5d2e4cfbf42b0[self.team][self.sessionsquadid])) {
        level.var_8cc5d2e4cfbf42b0[self.team][self.sessionsquadid] = self;
        self.var_8cc5d2e4cfbf42b0 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self, undefined, self, 0, 0, 0);

        if(isDefined(markedents)) {
          foreach(ent in markedents) {
            if(isDefined(ent) && istrue(ent.reconmarked)) {
              scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(ent.target, self.var_8cc5d2e4cfbf42b0, 0);
              function_ec57e0acbc6c6879(self.var_8cc5d2e4cfbf42b0, ent.target, 2);
            }
          }
        }
      } else {
        tmg = level.var_8cc5d2e4cfbf42b0[self.team][self.sessionsquadid].var_8cc5d2e4cfbf42b0;
        scripts\cp_mp\targetmarkergroups::function_b76f204edb67efc7(tmg, self);
      }
    } else if(!isDefined(level.var_8cc5d2e4cfbf42b0[self.team])) {
      level.var_8cc5d2e4cfbf42b0[self.team] = self;
      self.var_8cc5d2e4cfbf42b0 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self, undefined, self, 0, 0, 0);

      if(isDefined(markedents)) {
        foreach(ent in markedents) {
          if(istrue(ent.reconmarked)) {
            scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(ent.target, self.var_8cc5d2e4cfbf42b0, 0);
            function_ec57e0acbc6c6879(self.var_8cc5d2e4cfbf42b0, ent.target, 2);
          }
        }
      }
    } else {
      var_e1c6011321fd25b9 = level.var_8cc5d2e4cfbf42b0[self.team];
      scripts\cp_mp\targetmarkergroups::function_b76f204edb67efc7(var_e1c6011321fd25b9.var_8cc5d2e4cfbf42b0, self);
    }

    return;
  }

  if(!isDefined(self.var_8cc5d2e4cfbf42b0)) {
    self.var_8cc5d2e4cfbf42b0 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self, undefined, self, 0, 0, 0);

    if(isDefined(markedents)) {
      foreach(ent in markedents) {
        if(istrue(ent.reconmarked)) {
          scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(ent.target, self.var_8cc5d2e4cfbf42b0, 0);
          function_ec57e0acbc6c6879(self.var_8cc5d2e4cfbf42b0, ent.target, 2);
        }
      }
    }
  }
}

function function_89b59bedb3802e41() {
  var_e1c6011321fd25b9 = function_eaf65bb46d1bd1a8();

  if(isDefined(var_e1c6011321fd25b9)) {
    markergroup = var_e1c6011321fd25b9.var_8cc5d2e4cfbf42b0;
    return markergroup;
  }
}

function function_fe1cd71ed406a649() {
  params = function_f0698aee89c18210(self.cameratype);
  self.headiconbox = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], params.headiconname, 5, 1, 1000, 100, undefined, 1);
  self.headiconfaction = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, undefined, 1);
  self.headiconalert = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], "icon_ping_warning", 5, 1, 1000, 100, undefined, 1);
  function_686c35e781f41189(params.supername);
}

function private function_b3d22408d6a4c7ac() {
  if(isDefined(self.watchers) && self.watchers.size > 0) {
    var_7d4ca51d82f94be6 = getfirstarraykey(self.watchers);
    var_298f2cf18f67224a = self.var_1b381f3aa944d595[var_7d4ca51d82f94be6];

    foreach(player in self.watchers) {
      entnum = player getentitynumber();
      timestamp = self.var_1b381f3aa944d595[entnum];

      if(timestamp < var_298f2cf18f67224a) {
        var_7d4ca51d82f94be6 = entnum;
      }
    }

    return var_7d4ca51d82f94be6;
  }
}

function function_3098442b001f283a(player) {
  iswatcher = 0;

  if(isDefined(self.watchers)) {
    iswatcher = array_contains(self.watchers, player);
  }
}

function function_a96f380b39543647(camera) {
  level endon("game_ended");
  camera endon("death");
  camera endon("explode");
  camera notify("updateTag");
  camera endon("updateTag");
  self endon("disconnect");

  while(isDefined(camera.pilot)) {
    camera.watcher_tag.angles = camera.pilot getplayerangles();
    waitframe();
  }
}

function function_ca19a92a4f9d5c3d(cameratype) {
  self endon("death");
  level endon("game_ended");
  self endon("disconnect");
  self notify("monitoringPlayerExit");
  self endon("monitoringPlayerExit");
  self.pilot waittill("playerLeavingCurrentCamera");
  params = function_f0698aee89c18210(cameratype);

  if(isDefined(self.watchers) && self.watchers.size > 0) {
    idx = function_b3d22408d6a4c7ac();
    newpilot = self.watchers[idx];
    timestamp = self.var_1b381f3aa944d595[idx];

    if(!isDefined(self.pilot)) {
      newpilot[[params.exitfunc]](self, 1);
      waitframe();

      if(isDefined(newpilot) && isDefined(self)) {
        newpilot thread[[params.startfunc]](self);
      }
    }
  }
}

function function_e910b2eba1af834c() {
  var_fc36664f5893d75d = 1000;
  starttime = gettime();

  while(gettime() - starttime < var_fc36664f5893d75d) {
    self disablephysicaldepthoffieldscripting();
    waitframe();
  }
}

function function_6976f2b3945c32f(cameratype) {
  exitfunc = function_f0698aee89c18210(cameratype).exitfunc;

  if(isDefined(self.pilot)) {
    self.pilot function_cdb15c1f9cab7852(self, cameratype);
  }

  if(isDefined(self.watchers) && self.watchers.size > 0) {
    foreach(watcher in self.watchers) {
      watcher[[exitfunc]](self, 0);
    }
  }
}

function function_3ecfbd63a3e3bed3(player) {
  if(!isDefined(self)) {
    return 0;
  }

  status = 0;
  distsq = distancesquared(self.origin, player.origin);

  if(self.hasexploded) {
    status = 3;
  } else if(distsq > function_f0698aee89c18210(self.cameratype).var_eff1ab975c47fe2) {
    status = 2;
  } else if(scripts\cp_mp\emp_debuff::is_empd()) {
    status = 4;
  } else {
    status = 1;
  }

  return status;
}

function private function_9b4db9a4213984ce(camera, index, state, time) {
  camera notify("cameraStatusWait");
  camera endon("cameraStatusWait");
  wait time;

  if(state == 3 || !isDefined(camera)) {
    thread function_45556aa41f4f9ae8(camera, index, 0);
    return;
  }

  if(function_309c31383efd7d3(camera)) {
    thread function_45556aa41f4f9ae8(camera, index, 5);
    return;
  }

  thread function_45556aa41f4f9ae8(camera, index, 1);
}

function function_81fb12166c3c0c2(player, unset, var_c380eb54a8adb38c, supername) {
  camlist = player[[var_c380eb54a8adb38c]]();

  if(!isDefined(camlist)) {
    return;
  }

  foreach(camera in camlist) {
    camera function_ea3e848c25e3c926(player, unset, supername);
  }
}

function function_b3b59c099f93a503(var_d20dfbbbcd940269) {
  self endon("death");
  params = function_f0698aee89c18210(self.cameratype);
  lifetime = getdvarint(@ "hash_13717e6e87cb530f", 120);
  function_8578449c3bec6372(lifetime, var_d20dfbbbcd940269);

  if(isDefined(self) && !istrue(self.isdestroyed)) {
    self thread[[params.destroyfunc]]();
  }
}

function private function_8578449c3bec6372(cam_life, var_d20dfbbbcd940269) {
  if(!istrue(var_d20dfbbbcd940269)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(cam_life);
}

function function_57b6e09eda0090d6(ison, keepwidget) {
  if(ison) {
    function_7203e7aa96ff0ba9(27);
    thread function_16fc807677a307be();
    return;
  }

  function_7203e7aa96ff0ba9(0, keepwidget);
}

function function_16fc807677a307be() {
  if(!isDefined(level.gametypebundle) || !istrue(level.gametypebundle.var_5b66ed80c98f795b)) {
    return;
  }

  self notify("decoy_monitor_death");
  level endon("game_ended");
  self endon("camera_destoyed");
  self waittill("death");
  function_57b6e09eda0090d6(0);
  function_86b60845e9a3d301("tacCam");
  self notify("tacticalCamera_allCamerasRemoved");
}

function function_4e3aa9d829b3e164(target) {
  if(!isDefined(target)) {
    return 0;
  }

  icansee = 0;
  tracecontents = physics_createcontents(["physicscontents_itemclip", "physicscontents_item", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_ainosight"]);
  camorigin = undefined;

  if(isDefined(self.pilot)) {
    camorigin = self.pilot getvieworigin();
  } else {
    camorigin = self.origin + anglestoup(self.angles) * 3.5;
  }

  defaultorigin = target.origin;
  tracepoints = [defaultorigin];

  if(isPlayer(target)) {
    headpos = (0, 0, 0);

    if(issharedfuncdefined("player", "isReallyAlive")) {
      headpos = target[[getsharedfunc("player", "getStanceTop")]]();
    }

    centerpos = (0, 0, 0);

    if(issharedfuncdefined("player", "isReallyAlive")) {
      centerpos = target[[getsharedfunc("player", "getStanceCenter")]]();
    }

    tracepoints = [headpos, centerpos, defaultorigin];
  } else if(isagent(target)) {
    tracepoints = [defaultorigin + (0, 0, 1)];
  }

  ignorelist = [self, target];
  vehicle = target getvehicle();

  if(isDefined(vehicle)) {
    ignorelist[ignorelist.size] = vehicle;
    vehiclechildren = vehicle getlinkedchildren(1);

    foreach(child in vehiclechildren) {
      ignorelist[ignorelist.size] = vehicle;
    }
  }

  icansee = 0;

  for(i = 0; i < tracepoints.size; i++) {
    trace = scripts\engine\trace::sphere_trace(camorigin, tracepoints[i], 0.01, ignorelist, tracecontents, undefined, 1);

    if(trace["hittype"] == "hittype_none") {
      icansee = 1;
      break;
    }
  }

  return icansee;
}

function private function_f597ec02db6aa057(markdata, timeout) {
  self.owner endon("disconnect");

  if(isDefined(self.pilot)) {
    self.pilot endon("disconnect");
  }

  target = markdata.target;
  target endon("death");

  for(starttime = gettime(); timeout * 1000 + starttime >= gettime(); starttime = gettime()) {
    wait 0.05;
    var_192cc07924877d71 = 0;

    if(scripts\cp_mp\emp_debuff::is_empd()) {
      break;
    }

    targetinfo = function_9d2bec87e0754872(target);

    if(isDefined(self.pilot) && isDefined(self) && isDefined(self.owner) && targetinfo.isinreticle && targetinfo.isinrange && targetinfo.isvisible) {
      var_192cc07924877d71 = 1;
    }

    if(var_192cc07924877d71) {}
  }
}

function function_54dea0f6292103cb() {
  pilot = self.pilot;
  pilot endon("disconnect");
  self endon("death");
  pilot endon("playerLeavingCurrentCamera");
  var_820e590cb5620371 = 0;
  self.markingtarget = undefined;

  while(true) {
    if(!isDefined(pilot)) {
      return;
    }

    self.targethascoldblooded = 0;
    targets = self.pilot.targetsinouterradius;
    markergroup = self.pilot function_89b59bedb3802e41();

    foreach(player in targets) {
      if(var_820e590cb5620371 >= 3) {
        var_820e590cb5620371 = 0;
        waitframe();
      }

      if(isPlayer(player) && issharedfuncdefined("player", "isReallyAlive")) {
        if(![[getsharedfunc("player", "isReallyAlive")]](player)) {
          continue;
        }
      }

      if(isagent(player) && !isalive(player)) {
        continue;
      }

      if(!isDefined(player)) {
        continue;
      }

      if(scripts\cp_mp\emp_debuff::is_empd()) {
        continue;
      }

      if(pilot function_f91c0feb9232b257(player)) {
        continue;
      }

      var_820e590cb5620371++;
      function_ec57e0acbc6c6879(markergroup, player, 1);
      targetinfo = function_9d2bec87e0754872(player);
      hascoldblooded = 0;

      if(issharedfuncdefined("perk", "hasPerk")) {
        if(isPlayer(player) && player[[getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
          hascoldblooded = 1;
        }
      }

      if(targetinfo.isinreticle && hascoldblooded) {
        self.targethascoldblooded = 1;
      }

      if(hascoldblooded) {
        function_ec57e0acbc6c6879(markergroup, player, 3);
        continue;
      }

      if(!targetinfo.isinreticle) {
        continue;
      }

      if(istrue(self.markingtarget)) {
        continue;
      }

      thread function_a295dfcb64a39664(player, "enemy", 0, 1);
    }

    var_820e590cb5620371 = 0;
    waitframe();
  }
}

function private function_348f9aa9ccb88ffa(target) {
  if(!isDefined(self.var_dae7e92e87a31e4)) {
    self.var_dae7e92e87a31e4 = [];
  }

  if(isDefined(self.var_dae7e92e87a31e4[target getentitynumber()])) {
    return;
  }

  sensordata = spawnStruct();
  sensordata.target = target;
  sensordata.entnum = target getentitynumber();
  self.var_dae7e92e87a31e4[target getentitynumber()] = sensordata;
  return sensordata;
}

function private function_8b7c344955f8b4c5(sensordata, sensorduration, supername) {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  wait sensorduration;
  function_b61404171c7a024b(sensordata);
  function_686c35e781f41189(supername);
}

function private function_b61404171c7a024b(sensordata) {
  if(isDefined(self.var_dae7e92e87a31e4[sensordata.entnum])) {
    self.var_dae7e92e87a31e4[sensordata.entnum] = undefined;
  }
}

function private function_5a659105ba755498(target, sensorduration, supername) {
  sensordata = function_348f9aa9ccb88ffa(target);

  if(!isDefined(sensordata)) {
    return;
  }

  self playsoundtoplayer("ui_camera_proximity_alert", self.owner, self);
  function_686c35e781f41189(supername);
  self.owner thread function_45556aa41f4f9ae8(self, self.ownerindex, 2, undefined, 3.25);
  thread function_8b7c344955f8b4c5(sensordata, sensorduration, supername);
}

function function_ff216d4d2c47565c(state) {
  assertex(state == 0 || state == 5, "<dev string:xc2>");
  self setclientomnvar("ui_rcd_controls", state);
}

function private function_c9fce57d5da1f571(camera, overrideholdtime) {
  if(!isDefined(self) || !isDefined(camera)) {
    return;
  }

  level endon("game_ended");
  self endon("disconnect");
  self endon("end_remote");
  self endon("monitoringExit");
  camera endon("death");

  while(self useButtonPressed()) {
    waitframe();
  }

  holdtime = getdvarfloat(@ "hash_8720ead849d3fbc3", 0.25);

  if(isDefined(overrideholdtime)) {
    holdtime = overrideholdtime;
  }

  updaterate = level.framedurationseconds;
  timerdirty = 1;

  while(true) {
    timeused = 0;

    if(timerdirty == 1) {
      self setclientomnvar("ui_exit_progress", 0);
      timerdirty = 0;
    }

    while(self useButtonPressed()) {
      if(istrue(self.var_a7d181863f388645)) {
        break;
      }

      isgamepad = self usinggamepad();

      if(!isgamepad && camera.cameratype == "tacCam") {
        holdtime = 0.01;
      }

      timeused += updaterate;
      timerdirty = 1;
      self setclientomnvar("ui_exit_progress", timeused / holdtime);

      if(timeused > holdtime) {
        self notify("cameraExit");
        return;
      }

      wait updaterate;
    }

    wait updaterate;
  }
}

function function_9ac601e206d92def(camera, var_c748b31a33c02c14, cameratype) {
  level endon("game_ended");
  camera endon("death");
  self endon("death_or_disconnect");
  self endon("stopMonitoringCamera");

  if(!isDefined(var_c748b31a33c02c14)) {
    var_c748b31a33c02c14 = function_f0698aee89c18210(cameratype).exitfunc;
  }

  childthread function_c9fce57d5da1f571(camera);
  self waittill("cameraExit");
  self thread[[var_c748b31a33c02c14]](camera, 0);
}

function function_cdb15c1f9cab7852(camera, cameratype) {
  var_83049232bcf4e965 = function_367656975db3f139(camera);

  if(!istrue(var_83049232bcf4e965) && !istrue(self.var_a7d181863f388645)) {
    self thread[[function_f0698aee89c18210(cameratype).exitfunc]](camera, 0, 1);
  }
}

function function_73af051ec0973e1(camera, clustername, cameratype) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stopMonitoringCamera");
  camera endon("death");

  while(true) {
    var_c7aaf56ec881e7b1 = array_contains(self.var_7d73cbb5ca5d6e32[clustername], camera);

    if(!var_c7aaf56ec881e7b1) {
      break;
    }

    wait 0.25;
  }

  function_cdb15c1f9cab7852(camera, cameratype);
}

function private function_4842c3896892dc17(markdata, camuser) {
  teamref = camuser.team;

  if(level.teambased) {
    if(isDefined(level.teammarkedents)) {
      if(shouldmodesetsquads()) {
        if(isDefined(level.teammarkedents[teamref][camuser.sessionsquadid])) {
          level.teammarkedents[teamref][camuser.sessionsquadid] = array_remove_key(level.teammarkedents[teamref][camuser.sessionsquadid], markdata.targetnum);
        }
      } else if(isDefined(level.teammarkedents[teamref])) {
        level.teammarkedents[teamref] = array_remove_key(level.teammarkedents[teamref], markdata.targetnum);
      }
    }

    return;
  }

  if(isDefined(camuser.markedents)) {
    camuser.markedents = array_remove_key(camuser.markedents, markdata.targetnum);
  }
}

function private function_9921a8095e089065(markdata, camuser) {
  teamref = camuser.team;

  if(level.teambased) {
    if(!isDefined(level.teammarkedents)) {
      level.teammarkedents = [];
    }

    if(!isDefined(level.teammarkedents[teamref])) {
      level.teammarkedents[teamref] = [];
    }

    if(shouldmodesetsquads()) {
      if(!isDefined(level.teammarkedents[teamref][camuser.sessionsquadid])) {
        level.teammarkedents[teamref][camuser.sessionsquadid] = [];
      }

      level.teammarkedents[teamref][camuser.sessionsquadid][markdata.targetnum] = markdata;
    } else {
      level.teammarkedents[teamref][markdata.targetnum] = markdata;
    }

    return;
  }

  if(!isDefined(camuser.markedents)) {
    camuser.markedents = [];
  }

  camuser.markedents[markdata.targetnum] = markdata;
}

function function_47c44d1bf801b8f0(markdata, camuser, useoutline) {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(markdata.headicon);
  teamref = camuser.team;
  markergroup = camuser function_89b59bedb3802e41();
  function_4842c3896892dc17(markdata, camuser);

  if(isDefined(markdata.target)) {
    if(isDefined(markergroup) && scripts\cp_mp\targetmarkergroups::targetmarkergroupexists(markergroup)) {
      function_ec57e0acbc6c6879(markergroup, markdata.target, 0);
    }

    markdata.reconmarked = undefined;
    markdata.beingmarked = undefined;

    if(isPlayer(markdata.target) && useoutline) {
      if(issharedfuncdefined("outline", "outlineDisable")) {
        [[getsharedfunc("outline", "outlineDisable")]](markdata.outlineid, markdata.target);
      }

      if(issharedfuncdefined("outline", "hudOutlineViewmodelDisable")) {
        markdata.target[[getsharedfunc("outline", "hudOutlineViewmodelDisable")]]();
      }
    }

    markdata.target notify(markdata.notifytoendmark);
  }
}

function function_c84cfcb1299f9b39() {
  if(isDefined(self.pilot)) {
    return self.pilot;
  }

  return self.owner;
}

function function_362c9a13d18031b1(waitnotification, var_4df19ef5b565978e, var_9410874ee76bf58e) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(var_9410874ee76bf58e);
  laststate = [];

  while(true) {
    self waittill(waitnotification, camera, index, state, forcestate, time);

    if(isDefined(laststate[index])) {
      if(isDefined(laststate[index][0])) {
        if(laststate[index][0] != camera) {
          if(state == 0 || state == 3 || state == 5) {
            continue;
          }
        }
      }
    }

    print("<dev string:xfa>" + index + "<dev string:x105>" + state + "<dev string:x119>");

    self setclientomnvar(var_4df19ef5b565978e + index + "_status", state);

    if(state > 1 && state != 5) {
      childthread function_9b4db9a4213984ce(camera, index, state, time);
    }

    if(!isDefined(camera)) {
      laststate[index] = undefined;
      continue;
    }

    laststate[index] = [camera, state];
  }
}

function function_7858aa4f2bc91d80() {
  starttime = gettime();
  timeelapsed = starttime;

  while(timeelapsed < starttime + 10) {
    thread function_ff216d4d2c47565c(0);
    timeelapsed += gettime() - timeelapsed;
    waitframe();
  }
}

function function_b501ce7305720779(camera) {
  ingroup = 0;

  if(!isDefined(camera.owner)) {
    return 0;
  }

  if(level.teambased) {
    if(shouldmodesetsquads()) {
      if(camera.owner.sessionsquadid == self.sessionsquadid) {
        ingroup = 1;
      }
    } else if(camera.ownerteam == self.team) {
      ingroup = 1;
    }
  } else if(camera.owner == self) {
    ingroup = 1;
  }

  return ingroup;
}

function function_f6ba29efe27b0f81(target) {
  if(!isDefined(target)) {
    return 0;
  }

  camangles = self gettagangles("tag_player");
  var_51743d62f4cf524e = self gettagorigin("tag_player");

  if(isDefined(self.pilot)) {
    camangles = self.pilot getplayerangles();
    var_51743d62f4cf524e = self.pilot getvieworigin();
  }

  camfwdvec = anglesToForward(camangles);
  defaultorigin = target.origin;
  headpos = (0, 0, 0);

  if(issharedfuncdefined("player", "isReallyAlive")) {
    headpos = target[[getsharedfunc("player", "getStanceTop")]]();
  }

  centerpos = (0, 0, 0);

  if(issharedfuncdefined("player", "isReallyAlive")) {
    centerpos = target[[getsharedfunc("player", "getStanceCenter")]]();
  }

  tracepoints = [headpos, centerpos, defaultorigin];
  var_9ae205c4c40af967 = 0;

  foreach(point in tracepoints) {
    cam2targetvec = point - var_51743d62f4cf524e;
    dotangle = math::anglebetweenvectors(camfwdvec, cam2targetvec);
    var_878f0eb51ab6a646 = math::anglebetweenvectors(camfwdvec, (0, 0, 1));
    var_cea5805c08f245d2 = math::anglebetweenvectors(cam2targetvec, (0, 0, 1));

    if(isDefined(self.pilot)) {
      var_e077f4a68ed9a464 = distancesquared(var_51743d62f4cf524e, point);

      if(var_e077f4a68ed9a464 > 10000) {
        if(abs(abs(var_878f0eb51ab6a646) - abs(var_cea5805c08f245d2)) > getdvarfloat(@ "hash_77f60c1216fca977", 19)) {
          return var_9ae205c4c40af967;
        }
      }
    }

    if(dotangle <= getdvarfloat(@ "hash_a20d9fbeab627f6", 31)) {
      var_9ae205c4c40af967 = 1;
    }
  }

  return var_9ae205c4c40af967;
}

function private function_1b1409af5e47b098(scantarget, scanfov, var_5e43b44751d01b1a) {
  if(!isDefined(scantarget)) {
    return 0;
  }

  inreticle = 0;
  targetorigin = scantarget.origin;
  scanpoints = [targetorigin];
  var_c3d9e0b30c6f14a4 = distancesquared(self getvieworigin(), scantarget.origin);
  isusingextrapoints = 0;

  if(var_c3d9e0b30c6f14a4 <= 10000) {
    var_5e43b44751d01b1a *= getdvarfloat(@ "hash_20c9852b3129de04", 2.5);
    isusingextrapoints = 1;
  }

  if(isPlayer(scantarget)) {
    istargethanging = scantarget ishanging();
    headpos = scantarget scripts\mp\utility\player::getstancetop();
    centerpos = scantarget scripts\mp\utility\player::getstancecenter();
    scanpoints = [headpos, centerpos];

    if(!istargethanging) {
      scanpoints = array_add(scanpoints, targetorigin);
    }

    if(isusingextrapoints) {
      var_102502c44898b35c = (headpos + centerpos) / 2;
      extrapoints = [var_102502c44898b35c];

      if(!istargethanging) {
        var_264b006395220d6 = (centerpos + targetorigin) / 2;
        extrapoints = array_add(extrapoints, var_264b006395220d6);
      }

      scanpoints = array_combine(scanpoints, extrapoints);
    }
  } else if(isagent(scantarget)) {
    centerpos = scantarget scripts\mp\agents\agent_utility::function_b071e509c0fb69b0();
    headpos = scantarget scripts\mp\agents\agent_utility::function_2e1b23386b967c10();
    scanpoints = [targetorigin + (0, 0, 1), centerpos, headpos];

    if(isusingextrapoints) {
      var_264b006395220d6 = (centerpos + targetorigin) / 2;
      var_102502c44898b35c = (headpos + centerpos) / 2;
      extrapoints = [var_264b006395220d6, var_102502c44898b35c];
      scanpoints = array_combine(scanpoints, extrapoints);
    }
  }

  foreach(point in scanpoints) {
    if(self worldpointinreticle_circle(point, scanfov, var_5e43b44751d01b1a)) {
      inreticle = 1;
      break;
    }
  }

  return inreticle;
}

function function_f254912b43c0f30a(target) {
  if(!isDefined(target)) {
    return 0;
  }

  return array_contains(self.pilot.targetsinouterradius, target);
}

function function_58a0cad2aba60238(camera) {
  return isDefined(camera.pilot) && self == camera.pilot;
}

function function_fc9294ffbd3490f3() {
  self notify("supportBox_makeUnusable");
  scripts\common\interactive::interactive_removeusedcallbackfromentity();
  self makeunusable();
  self.playersused = undefined;
}

function function_88b3522bbdf2f7c1(ison) {
  partstate = "off";

  if(ison) {
    partstate = "on";
  }

  self setscriptablepartstate("target_marked", partstate, 0);
}

function function_e593b8f6770c67e(markdata) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      return;
    }

    function_f1493744aa061205(markdata, player);
  }
}

function function_f1493744aa061205(markdata, player) {
  if(!isDefined(markdata)) {
    return;
  }

  isfriendly = function_c2c3f444cfeb61ca(markdata, player);
  isusingcamera = isDefined(markdata.markingent) && istrue(player.isusingcamera);

  if(isDefined(markdata.headicon)) {
    if(isfriendly && !isusingcamera) {
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(markdata.headicon, player);
      return;
    }

    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(markdata.headicon, player);
  }
}

function function_57d6a393b90824dc(maxz) {
  level.var_e87db96e1a77a100 = maxz;
}

function function_6436809a4ed7e363() {
  if(function_2e2ac10bd717d529(self.cameratype, self.origin, self.owner.team)) {
    return false;
  }

  if(scripts\mp\outofbounds::ispointinoutofbounds(self.origin, self.owner.team)) {
    return false;
  }

  if(isDefined(level.var_ca4e08767cbdae12)) {
    canplant = self[[level.var_ca4e08767cbdae12]]();

    if(!canplant) {
      return false;
    }
  }

  if(!isDefined(level.var_e87db96e1a77a100)) {
    return true;
  }

  if(self.origin[2] > level.var_e87db96e1a77a100) {
    return false;
  }

  return true;
}

function function_5e8b74f5e3dc4c60() {
  self.owner endon("disconnect");
  self endon("death");
  cameradestroyfunc = function_f0698aee89c18210(self.cameratype).destroyfunc;

  while(true) {
    isoob = scripts\mp\outofbounds::ispointinoutofbounds(self.origin, self.owner.team);
    var_44ed718ee62282e1 = namespace_5633828963c62e57::function_6436809a4ed7e363();

    if(isoob || !var_44ed718ee62282e1) {
      if(istrue(self.isingraceperiod)) {
        self.owner refundsuper();
      }

      self thread[[cameradestroyfunc]]();
    }

    wait 0.1;
  }
}

function function_2e2ac10bd717d529(cameratype, pointtocheck, teamtocheck) {
  pointinoutofbounds = 0;
  var_ac939183eb3c79d8 = function_f0698aee89c18210(cameratype).var_106bf36856a998f;

  if(!isDefined(var_ac939183eb3c79d8)) {
    return pointinoutofbounds;
  } else {
    foreach(trigger in var_ac939183eb3c79d8) {
      if(ispointinvolume(pointtocheck, trigger)) {
        if(isDefined(trigger.script_team) && isDefined(teamtocheck) && trigger.script_team != teamtocheck) {
          continue;
        }

        pointinoutofbounds = 1;
        break;
      }
    }
  }

  return pointinoutofbounds;
}

function function_66758c7fff976896() {
  if(!isDefined(self.creationtime)) {
    return true;
  }

  if(self.creationtime + 50 >= gettime()) {
    return true;
  }

  if(istrue(self.var_86b37b7a946b6a67)) {
    return true;
  }

  return false;
}

function function_e170d8c3cacdbaf5(camera, unsetnotif, cameratype) {
  level endon("game_ended");
  self endon("disconnect");
  camera endon("entering");

  if(isDefined(unsetnotif)) {
    self endon(unsetnotif);
  }

  var_c748b31a33c02c14 = function_f0698aee89c18210(cameratype).exitfunc;
  waittill_any_4("death", "killed_player", "last_stand_start", "successful_exfil");

  if(istrue(self.isusingcamera)) {
    [[var_c748b31a33c02c14]](camera, 0);
  }
}

function function_3c4da29d1ed157c7(clustername, unsetnotif, var_83fa915761bef20, maxdistsq, var_c380eb54a8adb38c) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(unsetnotif);
  self notify("cameraClusterMonitored");
  self endon("cameraClusterMonitored");

  if(!isDefined(self.var_7d73cbb5ca5d6e32)) {
    self.var_7d73cbb5ca5d6e32 = [];
  }

  self.var_7d73cbb5ca5d6e32[clustername] = [];
  childthread function_e65f72cdec46d03e(clustername, var_83fa915761bef20);

  while(true) {
    waitframe();
    cameragroup = self[[var_c380eb54a8adb38c]]();

    if(!isDefined(cameragroup)) {
      continue;
    }

    foreach(camera in cameragroup) {
      var_c7aaf56ec881e7b1 = array_contains(self.var_7d73cbb5ca5d6e32[clustername], camera);

      if(!isDefined(camera) || istrue(camera.isdestroyed)) {
        if(var_c7aaf56ec881e7b1) {
          function_6afedddb11741fc9(camera, clustername);
        }

        continue;
      }

      if(distancesquared(self.origin, camera.origin) <= maxdistsq) {
        if(!var_c7aaf56ec881e7b1) {
          if(camera.owner == self) {
            function_32c845c60c4e4b37(camera, 0);
          }

          function_3fb26da0d61f648b(camera, clustername);
        }

        continue;
      }

      if(var_c7aaf56ec881e7b1) {
        if(camera.owner == self) {
          function_32c845c60c4e4b37(camera, 1);
        }

        function_6afedddb11741fc9(camera, clustername);
      }
    }
  }
}

function private function_32c845c60c4e4b37(camera, isoor) {
  camera.var_50aa75d01d4622bb = isoor;
  thread function_45556aa41f4f9ae8(camera, camera.ownerindex, ter_op(isoor, 5, 1));
}

function private function_309c31383efd7d3(camera) {
  return istrue(camera.var_50aa75d01d4622bb);
}

function private function_e65f72cdec46d03e(clustername, var_83fa915761bef20) {
  while(true) {
    level waittill(var_83fa915761bef20, camera);

    if(array_contains(self.var_7d73cbb5ca5d6e32[clustername], camera)) {
      function_6afedddb11741fc9(camera, clustername);
    }
  }
}

function private function_3fb26da0d61f648b(camera, clustername) {
  self.var_7d73cbb5ca5d6e32[clustername] = array_add(self.var_7d73cbb5ca5d6e32[clustername], camera);
}

function private function_6afedddb11741fc9(camera, clustername) {
  self.var_7d73cbb5ca5d6e32[clustername] = array_remove(self.var_7d73cbb5ca5d6e32[clustername], camera);
}

function private function_23643a7487214603(target, camera) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  camera endon("death");
  camera endon("emp_applied");
  markergroup = function_89b59bedb3802e41();

  if(!isDefined(markergroup)) {
    return;
  }

  self.targetsinouterradius[self.targetsinouterradius.size] = target;
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(target, markergroup, 0);
  function_ec57e0acbc6c6879(markergroup, target, 0);
  self playlocalsound("equip_tactical_cam_passive_marked");

  while(isDefined(target)) {
    if(isPlayer(target) && issharedfuncdefined("player", "isReallyAlive")) {
      if(![[getsharedfunc("player", "isReallyAlive")]](target)) {
        break;
      }
    }

    if(isagent(target) && !isalive(target)) {
      break;
    }

    targetinfo = camera function_9d2bec87e0754872(target);

    if(!function_f91c0feb9232b257(target)) {
      if(!istrue(targetinfo.isindetectrange) || !istrue(targetinfo.isvisible) || !istrue(targetinfo.var_9ae205c4c40af967)) {
        break;
      }
    }

    waitframe();
  }

  if(isDefined(target)) {
    markergroup = function_89b59bedb3802e41();

    if(isDefined(markergroup)) {
      if(scripts\cp_mp\targetmarkergroups::targetmarkergroupexists(markergroup) && !function_f91c0feb9232b257(target)) {
        scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(target, markergroup);
      }
    }

    if(array_contains(self.targetsinouterradius, target)) {
      self.targetsinouterradius = array_remove(self.targetsinouterradius, target);
    }

    return;
  }

  self.targetsinouterradius = array_removeundefined(self.targetsinouterradius);
}

function private function_2d3e2d45f75d7b9f(camera, ent) {
  if(!isDefined(ent)) {
    return false;
  }

  if(isPlayer(ent)) {
    if(issharedfuncdefined("player", "isReallyAlive")) {
      if(![[getsharedfunc("player", "isReallyAlive")]](ent)) {
        return false;
      }
    }
  }

  if(isagent(ent) && !isalive(ent)) {
    return false;
  }

  if(level.teambased) {
    if(isDefined(ent.team) && ent.team == self.team) {
      return false;
    }
  } else {
    if(isPlayer(ent) && ent == self) {
      return false;
    }

    if(isDefined(ent.owner) && ent.owner == self) {
      return false;
    }
  }

  if(!camera function_a268c4595bd106ff(ent)) {
    return false;
  }

  if(function_f91c0feb9232b257(ent)) {
    return false;
  }

  if(camera scripts\cp_mp\emp_debuff::is_empd()) {
    return false;
  }

  if(camera function_f254912b43c0f30a(ent)) {
    return false;
  }

  if(!camera function_f6ba29efe27b0f81(ent)) {
    return false;
  }

  if(!camera function_4e3aa9d829b3e164(ent)) {
    return false;
  }

  return true;
}

function function_fc89b224136fe202(camera) {
  level endon("game_ended");
  self endon("disconnect");
  camera endon("death");
  self endon("playerLeavingCurrentCamera");
  self.targetsinouterradius = [];
  entmask = createentitytypemask(["etype_player", "etype_ai"]);

  while(true) {
    targetarray = getentitiesinradiusfrompartitiongrid(camera.origin, 1575, entmask);

    foreach(ent in targetarray) {
      var_32608e38aa3071c4 = function_2d3e2d45f75d7b9f(camera, ent);

      if(var_32608e38aa3071c4) {
        thread function_23643a7487214603(ent, camera);
      }
    }

    wait 0.25;
  }
}

function function_c99b3a2b715c288b(duration, supername) {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("entering");
  entmask = createentitytypemask(["etype_player", "etype_ai"]);

  while(true) {
    targetarray = getentitiesinradiusfrompartitiongrid(self.origin, 1575, entmask);

    foreach(ent in targetarray) {
      if(!isDefined(ent)) {
        continue;
      }

      if(isPlayer(ent) || isbot(ent)) {
        if(issharedfuncdefined("player", "isReallyAlive")) {
          if(![[getsharedfunc("player", "isReallyAlive")]](ent)) {
            continue;
          }
        }
      }

      if(isagent(ent) && !isalive(ent)) {
        continue;
      }

      if(level.teambased) {
        if(isDefined(ent.team) && ent.team == self.ownerteam) {
          continue;
        }
      } else if(ent == self.owner) {
        continue;
      }

      if(scripts\cp_mp\emp_debuff::is_empd()) {
        continue;
      }

      targetinfo = function_9d2bec87e0754872(ent);

      if(!targetinfo.isinrange || !targetinfo.isvisible || !targetinfo.isindetectrange || !targetinfo.var_9ae205c4c40af967) {
        continue;
      }

      if(self.owner function_f91c0feb9232b257(ent)) {
        continue;
      }

      if(istrue(self.markingtarget)) {
        continue;
      }

      params = function_f0698aee89c18210(self.cameratype);
      function_5a659105ba755498(ent, params.sensorduration, params.supername);
    }

    wait 0.25;
  }
}

function function_ea702996ea718070() {
  self endon("death");
  level endon("game_ended");
  self setmode("manual");
  worldup = anglestoup((0, 0, 1));
  grenadeup = anglestoup(self.angles);
  dotresult = vectordot(worldup, grenadeup);
  var_9745168c66baba25 = dotresult < -0.001;
  var_9ffcc6e392e7660e = dotresult >= -0.001 && dotresult <= 0.001;
  turretonground = dotresult > 0.001;

  if(var_9ffcc6e392e7660e) {
    middlevec = anglestoup(self.angles);
    var_bebbfd784c183fdc = vectortoangles(middlevec);
  } else {
    middlevec = anglesToForward(self.angles);
    var_bebbfd784c183fdc = vectortoangles(middlevec);
  }

  direction = 1;
  destvec = anglestoright(var_bebbfd784c183fdc);
  destfwd = anglesToForward(var_bebbfd784c183fdc);
  destpos = self.origin + destvec * 100 * direction;
  destent = spawn_script_origin(destpos);
  level thread draw_angles(var_bebbfd784c183fdc, self.origin, (1, 0, 0), 1000, 50);

  while(true) {
    self settargetentity(destent);
    level thread draw_angles(var_bebbfd784c183fdc, destpos, (1, 0, 0), 1000, 50);
    anglediff = math::anglebetweenvectors(anglesToForward(self gettagangles("tag_player")), destvec);

    while(anglediff > 10 && anglediff < 170) {
      anglediff = math::anglebetweenvectors(anglesToForward(self gettagangles("tag_player")), destvec);
      waitframe();
    }

    direction *= -1;
    destpos = self.origin + destvec * 100 * direction;
    destent.origin = destpos;
    self cleartargetentity(destent);
    waitframe();
  }
}

function private function_a295dfcb64a39664(target, targettype, useheadicon, useoutline) {
  pilot = self.pilot;
  pilot endon("disconnect");
  self.owner endon("disconnect");
  level endon("game_ended");
  self endon("explode");
  pilot endon("playerLeavingCurrentCamera");
  params = function_f0698aee89c18210(self.cameratype);
  markdata = spawnStruct();
  markdata.target = target;
  markdata.targetnum = target getentitynumber();
  markdata.markingent = self;
  markdata.ownerteam = self.ownerteam;
  markdata.outlineid = undefined;
  markdata.headicon = undefined;
  markdata.beingmarked = undefined;
  markdata.reconmarked = undefined;
  markdata.notifytoendmark = "unmarked_" + markdata.targetnum;

  if(!isDefined(markdata.targetnum)) {
    return;
  }

  if(!isDefined(pilot)) {
    return;
  }

  markergroup = pilot function_89b59bedb3802e41();

  if(!isDefined(markergroup)) {
    return;
  }

  self.markingtarget = 1;
  pilot notify("marking_target");
  var_2095b8a1afaaf65e = self[[params.var_6e5f6320607eb69]](target);
  pilot playlocalsound(params.markingsfx);
  self setscriptablepartstate("marking_target", "on", 0);

  while(var_2095b8a1afaaf65e > 0) {
    markdata.beingmarked = 1;

    if(!isDefined(target)) {
      return;
    }

    if(!pilot function_1b1409af5e47b098(target, 80, 40)) {
      markdata.beingmarked = undefined;
      self.markingtarget = undefined;
      pilot stoplocalsound("equip_tactical_cam_marking");
      self setscriptablepartstate("marking_target", "off", 0);
      pilot function_ff216d4d2c47565c(5);
      return;
    }

    var_2095b8a1afaaf65e -= 0.05;
    wait 0.05;
  }

  self thread[[params.var_273f2a99f4833f00]](markdata, pilot, target, targettype, useheadicon, useoutline);
}

function private function_7853d0aadd9c1525(target) {
  return istrue(target.beingmarked);
}

function function_6643dd06cf63b76a(markdata, camuser, timeout, useoutline) {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("explode");
  target = markdata.target;
  target endon(markdata.notifytoendmark);
  function_f597ec02db6aa057(markdata, timeout);
  function_47c44d1bf801b8f0(markdata, camuser, useoutline);
}

function private function_b5be8b2f7743c406(delaytime, var_bc0df70f0a03d70b) {
  pilot = self.pilot;

  if(!isDefined(pilot)) {
    return;
  }

  level endon("game_ended");
  self endon("death");
  pilot endon("playerLeavingCurrentCamera");
  pilot endon("disconnect");
  pilot endon("marking_target");
  wait delaytime;

  if(pilot.isusingcamera && pilot.currentcamera == self) {
    pilot function_ff216d4d2c47565c(var_bc0df70f0a03d70b);
  }
}

function function_6f8fb8f7f63e5164(markdata, camerauser, useheadicon, useoutline) {
  target = markdata.target;
  params = function_f0698aee89c18210(self.cameratype);
  markedents = function_d103dc61e5b6abc3(camerauser);

  if(isDefined(markedents) && array_contains_key(markedents, markdata.targetnum)) {
    return false;
  }

  function_9921a8095e089065(markdata, camerauser);
  targettype = "player";

  if(isagent(target)) {
    targettype = "agent";
  }

  self[[params.var_547e8b267c03d017]](markdata.target, targettype);
  markicon = "hud_icon_new_marked";

  if(scripts\cp_mp\entityheadicons::function_6ede573723f08c0f()) {
    markicon = "hud_icon_head_marked";
  }

  var_f9cd7fda74e92e2a = 8;

  if(isPlayer(target)) {
    if(istrue(useoutline)) {
      if(level.teambased) {
        if(issharedfuncdefined("outline", "outlineEnableForTeam")) {
          markdata.outlineid = [[getsharedfunc("outline", "outlineEnableForTeam")]](target, "orange", self.owner.team, 0, 1, 0, "killstreak");
        }
      } else if(issharedfuncdefined("outline", "outlineEnableForPlayer")) {
        markdata.outlineid = [[getsharedfunc("outline", "outlineEnableForPlayer")]](target, "orange", self.owner, 0, 1, 0, "killstreak");
      }

      if(issharedfuncdefined("outline", "hudOutlineViewmodelEnable")) {
        target[[getsharedfunc("outline", "hudOutlineViewmodelEnable")]](5, 0, 1);
      }
    }

    target thread function_7d61d7b52c318d47();
    target function_748f3520a7e525a9();
    target playlocalsound("recon_drone_spotted_plr");
  } else {
    markstruct = function_74598558cd270375(markicon, var_f9cd7fda74e92e2a, target);
    markicon = markstruct.weaponicon;
    var_f9cd7fda74e92e2a = markstruct.weaponoffset;
  }

  if(istrue(useheadicon)) {
    markdata.headicon = target scripts\cp_mp\entityheadicons::setheadicon_singleimage([], markicon, var_f9cd7fda74e92e2a, 1, 4000, 500, undefined, 1, 1);
    function_e593b8f6770c67e(markdata);
  }

  if(issharedfuncdefined("helper_drone", "watchMarkingEntStatus")) {
    self thread[[getsharedfunc("helper_drone", "watchMarkingEntStatus")]](markdata);
  }

  thread function_b5be8b2f7743c406(self[[params.var_6e5f6320607eb69]](markdata.target), 5);
  return true;
}

function function_7abfae4e338cc940(player, func) {
  markcluster = function_d103dc61e5b6abc3(player);

  if(isDefined(markcluster)) {
    foreach(ent in markcluster) {
      if(istrue(ent.reconmarked)) {
        [[func]](markcluster[ent.targetnum], player);
      }
    }
  }
}

function function_1e34b5a5489be90(camera, isswitching, cameratype) {
  assertex(camera.pilot == self, "<dev string:x11e>");
  notification = function_f0698aee89c18210(cameratype).var_36411d05d3f1e503;
  level endon("game_ended");

  if(!isswitching) {
    function_7abfae4e338cc940(self, &function_f1493744aa061205);
    function_bfcdb898d70f248c();
  }

  camera.pilot = undefined;
  camera setscriptablepartstate("piloted", "off", 0);
  level notify(notification, camera);
  self remotecontrolturretoff(camera);
}

function function_b4e750dbd5734b12(camera, isswitching) {
  if(isDefined(camera.watchers) && isDefined(camera)) {
    watcheridx = array_find(camera.watchers, self);

    if(isDefined(watcheridx)) {
      camera.watchers = array_remove(camera.watchers, camera.watchers[watcheridx]);
      camera.var_1b381f3aa944d595 = array_remove(camera.var_1b381f3aa944d595, camera.var_1b381f3aa944d595[watcheridx]);

      if(!isswitching) {
        function_7abfae4e338cc940(self, &function_f1493744aa061205);
        function_bfcdb898d70f248c();
      }

      self cameraunlink();
      self lerpfovbypreset("default");
    }
  }
}

function function_81704d1224bd6fe0(usingcamera) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(usingcamera) {
    val::set("tactical_camera_actions", "weapon_switch", 0);
    val::set("tactical_camera_actions", "offhand_weapons", 0);
    val::set("tactical_camera_actions", "fire", 0);
    val::set("tactical_camera_actions", "killstreaks", 0);
    val::set("tactical_camera_actions", "allow_movement", 0);
    val::set("tactical_camera_actions", "armor", 0);

    if(scripts\mp\equipment\nvg::function_258c5e445c8b7f80()) {
      val::set("tactical_camera_actions", "nvg", 0);
    }

    function_7a22ab98be3d0849(1);
    return;
  }

  val::reset_all("tactical_camera_actions");
  function_7a22ab98be3d0849(0);
}

function private function_7a22ab98be3d0849(usingcamera) {
  stance = self getstance();

  if(usingcamera) {
    if(stance == "stand") {
      val::set("tactical_camera_stance", "crouch", 0);
      val::set("tactical_camera_stance", "prone", 0);
    } else if(stance == "crouch") {
      val::set("tactical_camera_stance", "stand", 0);
      val::set("tactical_camera_stance", "prone", 0);
    } else if(stance == "prone") {
      val::set("tactical_camera_stance", "crouch", 0);
      val::set("tactical_camera_stance", "stand", 0);
    }

    return;
  }

  val::reset_all("tactical_camera_stance");
}

function function_54e1472f61b86413(camera, destroyfunc, oninit) {
  if(istrue(camera.isingraceperiod)) {
    thread refundsuper();
  }

  camera[[destroyfunc]](1, undefined, oninit);
}

function function_9cd4393cac778989(camera, destroyfunc, oninit) {
  camera endon("death");
  debugshowlines = getdvarint(@ "hash_c57f2daebacd2a11", 0) > 0;
  var_c7c4cb56353a2626 = getdvarint(@ "hash_77164862b5dd9238", 1) > 0;
  shiphack = 0;

  if(getdvarint(@ "hash_5d72d66fef5f7d5", 0) == 1) {
    shiphack = 1;
  }

  if(shiphack && istrue(oninit)) {
    offset = getdvarfloat(@ "hash_a63eaacd700c5fe0", 0.75);
    camera.origin += anglestoup(camera.angles) * offset;
    wait 0.05;
  }

  oninit = istrue(oninit);

  if(!isDefined(destroyfunc)) {
    destroyfunc = function_f0698aee89c18210(camera.cameratype).destroyfunc;
  }

  if(oninit) {
    wait 0.05;
  }

  referenceloc = spawnStruct();
  tracestartoffset = getdvarfloat(@ "hash_ea48e956738a089c", 8);
  referenceloc.origin = camera.origin + anglestoup(camera.angles) * tracestartoffset;
  ignorearray = [camera, self];
  contents = function_f0698aee89c18210(camera.cameratype).orientationcontents;
  assertex(isDefined(contents), "<dev string:x173>");
  referenceloc.angles = camera gettagangles("tag_origin");

  if(camera.mode == "wall") {
    fwd = anglestoup(camera.angles);
    right = anglestoright(camera.angles);
    up = vectorcross(fwd, right);
    referenceloc.angles = axistoangles(fwd, right, up);
  }

  spheresize = getdvarfloat(@ "hash_71131deb09e9dcbf", 2.125);
  tracestart = referenceloc.origin + anglestoleft(referenceloc.angles) * 0.2;
  tracestart += anglesToForward(referenceloc.angles) * getdvarfloat(@ "hash_9837b8c055d50463", 1);
  fwdtraceend = tracestart + anglesToForward(referenceloc.angles) * 16.1;
  backtraceend = tracestart + anglesToForward(referenceloc.angles) * 16.1 * -1;
  fwdtrace = scripts\engine\trace::sphere_trace(tracestart, fwdtraceend, 2.125, ignorearray, contents, 0, 1);
  backtrace = scripts\engine\trace::sphere_trace(tracestart, backtraceend, 2.125, ignorearray, contents, 0, 1);

  if(isDefined(fwdtrace["position"])) {
    if(var_c7c4cb56353a2626) {
      level thread scripts\mp\utility\debug::drawsphere(fwdtrace["<dev string:x1cf>"], 0.5, 100, (1, 1, 1));
    }
  }

  if(isDefined(backtrace["position"])) {
    if(var_c7c4cb56353a2626) {
      level thread scripts\mp\utility\debug::drawsphere(backtrace["<dev string:x1cf>"], 0.5, 100, (0, 0, 0));
    }
  }

  var_21f7b8e410c6d2e0 = fwdtrace["hittype"] == "hittype_none";
  var_1515fef1b3851218 = backtrace["hittype"] == "hittype_none";
  hitdistancesq = distancesquared(fwdtrace["position"], backtrace["position"]);
  hitsunsafe = hitdistancesq <= 174.504;
  var_668318f72d08b88b = camera.origin + anglestoup(camera.angles) * -1.5;
  var_75728142e6146447 = camera gettagorigin("tag_player");
  var_f9f735a1790f607f = distancesquared(backtrace["position"], var_668318f72d08b88b);
  var_fe15317bedb99e47 = distancesquared(fwdtrace["position"], var_75728142e6146447);

  if(var_fe15317bedb99e47 < 3) {
    function_54e1472f61b86413(camera, destroyfunc, oninit);
    return false;
  }

  var_607a2501bce0189 = backtrace["position"] - var_668318f72d08b88b;
  var_8971b89742aa65e7 = fwdtrace["position"] - var_75728142e6146447;
  var_22515e1e2a9b9ecc = [180, 180];
  var_443e943cc3579457 = [85, 85];

  if(!var_21f7b8e410c6d2e0 && !var_1515fef1b3851218) {
    if(hitsunsafe) {
      function_54e1472f61b86413(camera, destroyfunc, oninit);
      return false;
    } else {
      tooclose = vectordot(anglesToForward(camera gettagangles("tag_player")), var_8971b89742aa65e7) < 1;

      if(tooclose) {
        function_54e1472f61b86413(camera, destroyfunc, oninit);
        return false;
      }

      var_21f7b8e410c6d2e0 = 1;
    }
  }

  if(var_21f7b8e410c6d2e0 || var_1515fef1b3851218) {
    if(!var_21f7b8e410c6d2e0 && camera.mode != "wall" && istrue(oninit)) {
      newfwd = fwdtrace["normal"];
      newup = anglestoup(camera.angles);
      newright = vectorcross(newfwd, newup);
      referenceloc.angles = axistoangles(newfwd, newright, newup);
      camera.angles = referenceloc.angles;
      wait 0.05;
    }

    if(!var_21f7b8e410c6d2e0 || !var_1515fef1b3851218) {
      if(!var_21f7b8e410c6d2e0) {
        insidegeo = scripts\engine\trace::ray_trace_detail_passed(tracestart, fwdtrace["position"] + fwdtrace["normal"] * -2, ignorearray, contents);

        if(insidegeo) {
          function_54e1472f61b86413(camera, destroyfunc, oninit);
          return false;
        }
      }

      if(!var_1515fef1b3851218) {
        insidegeo = scripts\engine\trace::ray_trace_detail_passed(tracestart, backtrace["position"] + backtrace["normal"] * -2, ignorearray, contents);

        if(insidegeo) {
          function_54e1472f61b86413(camera, destroyfunc, oninit);
          return false;
        }
      }

      if(var_f9f735a1790f607f < 174.504 || var_fe15317bedb99e47 < 174.504) {
        var_22515e1e2a9b9ecc[0] -= 70;
        var_22515e1e2a9b9ecc[1] -= 70;
      }
    }
  }

  if(camera.mode == "wall") {
    var_22515e1e2a9b9ecc[0] = 110;
    var_22515e1e2a9b9ecc[1] = 110;
  } else if(camera.mode == "ground") {
    var_443e943cc3579457[1] -= getdvarfloat(@ "hash_fb3d586e02f08fc9", 30);
  } else {
    var_443e943cc3579457[0] -= getdvarfloat(@ "hash_fb3d586e02f08fc9", 30);
  }

  if(oninit) {
    newfwd = flatten_vector(anglesToForward(camera gettagangles("tag_player")));
    worldup = (0, 0, 1);
    newright = vectorcross(newfwd, worldup);
    referenceloc.angles = axistoangles(newfwd, newright, worldup);
    var_a4b48904a62e6aee = getdvarfloat(@ "hash_630da9dbea450037", 5.5);
    camleftoffset = getdvarfloat(@ "hash_1ed9270646935e4f", 0.25);
    var_53f975d1bac9f666 = getdvarfloat(@ "hash_158dbc8dfe38250f", 0.05);
    referenceloc.origin = camera.origin + anglestoup(camera.angles) * var_a4b48904a62e6aee + anglestoleft(referenceloc.angles) * camleftoffset + anglesToForward(referenceloc.angles) * var_53f975d1bac9f666;
    camera.var_972db1e8c83af680 = referenceloc.angles;
    camera.var_61b4bf1265754402 = referenceloc.origin;
  } else {
    referenceloc.angles = camera.var_972db1e8c83af680;
    referenceloc.origin = camera.var_61b4bf1265754402;
  }

  if(camera.mode != "ground" && oninit) {
    tracetip = camera gettagorigin("tag_player");
    tracebase = camera gettagorigin("tag_origin");
    tracestarts = [tracetip, tracebase];
    var_c6ea0ec449c6e3f7 = tracetip + anglestoleft(referenceloc.angles) * 13.21;
    var_13a898e5c4b84ac4 = tracetip + anglestoright(referenceloc.angles) * 13.21;
    var_1e4cc740e1cd5cd3 = tracebase + anglestoleft(referenceloc.angles) * 13.21;
    var_4a90ce9b71e8f578 = tracebase + anglestoright(referenceloc.angles) * 13.21;
    var_2fe0ccf3c745186a = scripts\engine\trace::ray_trace(tracetip, var_c6ea0ec449c6e3f7, ignorearray, contents, 0, 0, 1);
    var_e9b3dcdc29694157 = scripts\engine\trace::ray_trace(tracetip, var_13a898e5c4b84ac4, ignorearray, contents, 0, 0, 1);
    var_7b8dbe0a384c48b6 = scripts\engine\trace::ray_trace(tracebase, var_1e4cc740e1cd5cd3, ignorearray, contents, 0, 0, 1);
    var_1163f374b636fb8b = scripts\engine\trace::ray_trace(tracebase, var_4a90ce9b71e8f578, ignorearray, contents, 0, 0, 1);
    var_7d1af73532ea6ca9 = var_2fe0ccf3c745186a["hittype"] != "hittype_none" && var_7b8dbe0a384c48b6["hittype"] != "hittype_none";
    var_31344ce38dec89fc = var_e9b3dcdc29694157["hittype"] != "hittype_none" && var_1163f374b636fb8b["hittype"] != "hittype_none";

    if(var_31344ce38dec89fc && var_7d1af73532ea6ca9) {
      function_54e1472f61b86413(camera, destroyfunc, oninit);
      return false;
    } else {
      offsetdistance = getdvarfloat(@ "hash_cb3fea1ca4b915e8", 6);

      if(var_31344ce38dec89fc) {
        camera.origin += anglestoleft(referenceloc.angles) * offsetdistance;
        referenceloc.origin += anglestoleft(referenceloc.angles) * offsetdistance;
        wait 0.05;
      } else if(var_7d1af73532ea6ca9) {
        camera.origin += anglestoright(referenceloc.angles) * offsetdistance;
        referenceloc.origin += anglestoright(referenceloc.angles) * offsetdistance;
        wait 0.05;
      }

      camera.var_61b4bf1265754402 = referenceloc.origin;
    }

    if(debugshowlines) {
      level thread draw_line_for_time(var_c6ea0ec449c6e3f7, var_13a898e5c4b84ac4, 0, 1, 0, 100);
      level thread draw_line_for_time(var_1e4cc740e1cd5cd3, var_4a90ce9b71e8f578, 0, 1, 0, 100);
    }
  }

  if(oninit && camera.mode == "wall") {
    lensposition = camera gettagorigin("tag_player");
    lensorientation = referenceloc.angles;
    traceoffset = getdvarfloat(@ "hash_bb708c290ae38743", 20);
    tracestart = lensposition + anglesToForward(lensorientation) * -1;
    righttraceend = lensposition + anglesToForward(lensorientation) * traceoffset + anglestoright(lensorientation) * traceoffset;
    lefttraceend = lensposition + anglesToForward(lensorientation) * traceoffset + anglestoleft(lensorientation) * traceoffset;
    uptraceend = lensposition + anglesToForward(lensorientation) * traceoffset + anglestoup(lensorientation) * traceoffset;
    downtraceend = lensposition + anglesToForward(lensorientation) * traceoffset + anglestoup(lensorientation) * traceoffset * -1;
    traceends = [righttraceend, lefttraceend, uptraceend, downtraceend];
    uptrace = scripts\engine\trace::sphere_trace(tracestart, uptraceend, 1, ignorearray, contents, 0, 1);
    downtrace = scripts\engine\trace::sphere_trace(tracestart, downtraceend, 1, ignorearray, contents, 0, 1);
    lefttrace = scripts\engine\trace::sphere_trace(tracestart, lefttraceend, 1, ignorearray, contents, 0, 1);
    righttrace = scripts\engine\trace::sphere_trace(tracestart, righttraceend, 1, ignorearray, contents, 0, 1);
    uphit = uptrace["hittype"] != "hittype_none";
    downhit = downtrace["hittype"] != "hittype_none";
    lefthit = lefttrace["hittype"] != "hittype_none";
    righthit = righttrace["hittype"] != "hittype_none";

    if(uphit && downhit || lefthit && righthit) {
      function_54e1472f61b86413(camera, destroyfunc, oninit);
      return false;
    }

    if(debugshowlines) {
      level thread draw_line_for_time(tracestart, uptraceend, 1, 0, 0, 100);
      level thread draw_line_for_time(tracestart, downtraceend, 1, 0, 0, 100);
      level thread draw_line_for_time(tracestart, lefttraceend, 1, 0, 0, 100);
      level thread draw_line_for_time(tracestart, righttraceend, 1, 0, 0, 100);
    }
  }

  var_b4fc3c0beaf3b0d8 = getdvarfloat(@ "hash_3c8365aa23c0a4e9", 8.5);
  tracestart = referenceloc.origin;
  var_f9fbca64918f0d03 = physics_spherecast(tracestart, tracestart, var_b4fc3c0beaf3b0d8, contents, ignorearray, "physicsquery_all", "physicsquery_all", 1);
  var_aa1b18a5eb18abf2 = 6.65;
  var_8a1427f1b510f82c = 2.4;

  if(camera.mode == "wall") {
    var_aa1b18a5eb18abf2 = 6.65;
    var_8a1427f1b510f82c = 1.5;
  }

  for(i = 0; i < var_f9fbca64918f0d03.size - 1; i++) {
    tracepoints = var_f9fbca64918f0d03[i];

    foreach(trace in tracepoints) {
      if(!isDefined(trace["position"])) {
        continue;
      }

      if(!isDefined(trace["normal"])) {
        continue;
      }

      if(trace["hittype"] == "hittype_none") {
        continue;
      }

      btwn = tracestart - trace["position"];
      dot = vectordot(anglesToForward(referenceloc.angles), btwn);

      if(dot > var_8a1427f1b510f82c || dot < var_aa1b18a5eb18abf2 * -1) {
        dot = vectordot(anglestoright(referenceloc.angles), btwn);

        if(dot < 0) {
          var_22515e1e2a9b9ecc[1] = min(var_22515e1e2a9b9ecc[1], 110);
        } else if(dot > 0) {
          var_22515e1e2a9b9ecc[0] = min(var_22515e1e2a9b9ecc[0], 110);
        }

        if(var_c7c4cb56353a2626) {
          level thread scripts\mp\utility\debug::drawsphere(trace["<dev string:x1cf>"], 0.5, 100, (1, 0, 0));
        }

        continue;
      }

      var_27cf81241a809664 = vectordot(anglestoright(referenceloc.angles), btwn);
      var_f5f0be1aae34652d = vectordot(anglestoup(referenceloc.angles), btwn);

      if(var_27cf81241a809664 <= 1.6 && var_27cf81241a809664 >= -1.6) {
        bounds = 2.25;

        if(var_f5f0be1aae34652d <= bounds && var_f5f0be1aae34652d >= bounds * -1) {
          if(var_c7c4cb56353a2626) {
            level thread scripts\mp\utility\debug::drawsphere(trace["<dev string:x1cf>"], 0.5, 100, (1, 1, 0));
          }

          continue;
        }

        if(camera.mode != "wall") {
          if(var_f5f0be1aae34652d < 0) {
            if(var_c7c4cb56353a2626) {
              level thread scripts\mp\utility\debug::drawsphere(trace["<dev string:x1cf>"], 0.5, 100, (1, 0, 1));
            }
          }
        }
      }

      if(var_27cf81241a809664 >= 6 || var_27cf81241a809664 <= -6) {
        if(var_c7c4cb56353a2626) {
          level thread scripts\mp\utility\debug::drawsphere(trace["<dev string:x1cf>"], 0.5, 100, (0, 1, 1));
        }

        continue;
      }

      if(var_f5f0be1aae34652d >= 6 || var_f5f0be1aae34652d < -6) {
        if(var_c7c4cb56353a2626) {
          level thread scripts\mp\utility\debug::drawsphere(trace["<dev string:x1cf>"], 0.5, 100, (0, 1, 1));
        }

        continue;
      }

      dot = vectordot(anglestoup(referenceloc.angles), btwn);

      if(dot > 2.25 || dot < -2.25) {
        if(var_c7c4cb56353a2626) {
          level thread scripts\mp\utility\debug::drawsphere(trace["<dev string:x1cf>"], 0.5, 100, (0, 0, 1));
        }

        var_54965e7ba439553d = ter_op(dot > 0, 1, 0);
        var_443e943cc3579457[var_54965e7ba439553d] = 1;
        continue;
      }

      camerafwd = anglesToForward(referenceloc.angles);
      var_5cc8d461e23b45ea = trace["position"] - tracestart;
      lefthit = 0;
      dotangle = math::anglebetweenvectorssigned(camerafwd, var_5cc8d461e23b45ea, (0, 0, 1));

      if(dotangle > 0) {
        lefthit = 1;
      }

      dotangle = abs(dotangle);
      var_100094a8f26da73d = ter_op(lefthit, 0, 1);
      var_22515e1e2a9b9ecc[var_100094a8f26da73d] = 1;

      if(var_c7c4cb56353a2626) {
        level thread scripts\mp\utility\debug::drawsphere(trace["<dev string:x1cf>"], 0.5, 100, (0, 1, 0));
      }
    }
  }

  if(oninit) {
    watcher_tag = spawn("script_model", camera.origin);
    watcher_tag setModel("tag_origin");
    watcher_tag.origin = camera gettagorigin("tag_player");
    watcher_tag.angles = camera gettagangles("tag_player");
    camera.watcher_tag = watcher_tag;
  }

  camera.var_df8eab23e5a5a0b7 = var_22515e1e2a9b9ecc;
  camera.var_3ebf8c1ae3acce22 = var_443e943cc3579457;
  return true;
}

function private function_736cf4e3ea65e3d0(currentcamera, reversesearch) {
  if(!isDefined(currentcamera)) {
    return;
  }

  cameracluster = self[[function_f0698aee89c18210(currentcamera.cameratype).var_1eb35a5a7992e498]]();
  assertex(isDefined(cameracluster), "<dev string:x1db>");

  if(cameracluster.size == 0) {
    return currentcamera;
  }

  teamref = currentcamera.owner.team;
  curidx = array_find(cameracluster, currentcamera);

  if(!isDefined(curidx)) {
    curidx = 0;
  }

  var_294ae6f4e7a2ece9 = 1;

  if(istrue(reversesearch)) {
    var_294ae6f4e7a2ece9 = -1;
  }

  newidx = curidx + var_294ae6f4e7a2ece9;

  if(newidx < 0) {
    newidx = cameracluster.size - 1;
  }

  newidx %= cameracluster.size;
  newcam = cameracluster[newidx];

  while(newidx != curidx) {
    if(isDefined(newcam) && !function_58a0cad2aba60238(newcam)) {
      break;
    }

    newidx = curidx + var_294ae6f4e7a2ece9;

    if(newidx < 0) {
      newidx = cameracluster.size - 1;
    }

    newidx %= cameracluster.size;
    newcam = cameracluster[newidx];
    waitframe();
  }

  return newcam;
}

function private function_aa1196b484e39eca(currentcamera, newcamera) {
  level endon("game_ended");
  self endon("disconnect");
  self.var_a7d181863f388645 = 1;
  exitfunc = function_f0698aee89c18210(currentcamera.cameratype).exitfunc;
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.25);
  canswitch = 1;

  if(!isDefined(newcamera) || istrue(newcamera.isdestroyed) || !isalive(self)) {
    canswitch = 0;
  }

  scripts\cp_mp\utility\player_utility::_freezelookcontrols(0);

  if(!canswitch) {
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.25);
    self thread[[exitfunc]](currentcamera, canswitch);
  } else {
    self[[exitfunc]](currentcamera, canswitch);
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.25);

    if(isDefined(newcamera)) {
      self[[function_f0698aee89c18210(newcamera.cameratype).startfunc]](newcamera);
    }
  }

  self.var_a7d181863f388645 = undefined;
  self notify("deployable_camera_switch_complete");
}

function function_ef76557bfc468ad7(var_91bf4c3aa63185a2, camera) {
  self endon("disconnect");
  self notify("cameraSwitchMonitored");
  self endon("cameraSwitchMonitored");
  self endon("playerExitingCameraMode");
  self endon(var_91bf4c3aa63185a2);
  self endon("death");

  while(true) {
    msg = function_537b1c669b864647();

    if(!isDefined(msg)) {
      continue;
    }

    var_234a04a66d98d450 = 0;

    if(msg == "cameraSwitchLeft") {
      var_234a04a66d98d450 = 1;
    }

    function_367656975db3f139(camera, var_234a04a66d98d450, var_91bf4c3aa63185a2);
  }
}

function function_367656975db3f139(camera, var_234a04a66d98d450, var_91bf4c3aa63185a2) {
  self endon("playerExitingCameraMode");
  self endon("death");

  if(!isDefined(var_91bf4c3aa63185a2)) {
    var_91bf4c3aa63185a2 = "tacticalCamera_allCamerasRemoved";
  }

  self endon(var_91bf4c3aa63185a2);

  if(istrue(self.var_a7d181863f388645)) {
    return 0;
  }

  newcam = function_736cf4e3ea65e3d0(camera, var_234a04a66d98d450);

  if(!isDefined(newcam)) {
    return 0;
  }

  if(newcam == camera) {
    return 0;
  }

  thread function_aa1196b484e39eca(camera, newcam);
  self waittill("deployable_camera_switch_complete");
  return 1;
}

function function_6ecb6c565c248e04(camera) {
  level endon("game_ended");
  camera endon("death");
  camera endon("explode");
  self endon("disconnect");

  if(!isDefined(camera) || camera.hasexploded == 1) {
    return;
  }

  currentorientation = camera gettagangles("tag_player");
  var_e80ee348f3979bf2 = anglesToForward(currentorientation);
  var_13cf1760124232f8 = anglestoup(currentorientation);
  var_4f6b26e67cbc1fd4 = flatten_vector(var_e80ee348f3979bf2, (0, 0, 1));
  initialorientation = camera.var_972db1e8c83af680;
  var_254b947358335ee3 = flatten_vector(anglesToForward(initialorientation), (0, 0, 1));
  var_75301576e282501b = anglestoup(initialorientation);
  camera.var_509338690aeb5fac = [];
  camera.var_f7e06e4a1de98489 = [];
  var_e04f1cbea4a658ea = 0;
  var_d11c3a1b9568cddb = 0;

  if(camera.var_df8eab23e5a5a0b7[0] != 180 || camera.var_df8eab23e5a5a0b7[1] != 180) {
    var_d11c3a1b9568cddb = math::anglebetweenvectorssigned(var_254b947358335ee3, var_4f6b26e67cbc1fd4, (0, 0, 1));

    if(var_d11c3a1b9568cddb <= 0) {
      var_e04f1cbea4a658ea = 1;
    }

    anglediff = abs(var_d11c3a1b9568cddb);

    if(var_e04f1cbea4a658ea) {
      camera.var_509338690aeb5fac[1] = anglediff * -1;
      camera.var_509338690aeb5fac[0] = anglediff;
    } else {
      camera.var_509338690aeb5fac[1] = anglediff;
      camera.var_509338690aeb5fac[0] = anglediff * -1;
    }
  }

  var_2f30d3353d5dd64d = 0;
  var_f73236f3c070ce6e = math::anglebetweenvectorssigned(var_75301576e282501b, var_13cf1760124232f8, (0, 1, 0));

  if(var_f73236f3c070ce6e <= 0) {
    var_2f30d3353d5dd64d = 1;
  }

  anglediff = abs(var_f73236f3c070ce6e);

  if(var_2f30d3353d5dd64d) {
    camera.var_f7e06e4a1de98489[0] = anglediff;
    camera.var_f7e06e4a1de98489[1] = anglediff * -1;
    return;
  }

  camera.var_f7e06e4a1de98489[0] = anglediff * -1;
  camera.var_f7e06e4a1de98489[1] = anglediff;
}

function function_5a7867448f866939(data, var_c0754ca9aa8976da) {
  if(!isDefined(self) || istrue(self.isdestroyed)) {
    return;
  }

  self setscriptablepartstate("ddos", "disabled", 0);
  self.owner thread function_45556aa41f4f9ae8(self, self.ownerindex, 4, undefined, 6);

  if(isDefined(self.pilot)) {
    var_e7c55e8864b07cca = [self.pilot];

    if(isDefined(self.watchers) && self.watchers.size > 0) {
      var_e7c55e8864b07cca = array_combine(var_e7c55e8864b07cca, self.watchers);
    }

    foreach(user in var_e7c55e8864b07cca) {
      user thread function_e0a9c9a0a70b1ee5(self, var_c0754ca9aa8976da);
    }
  }
}

function function_d0007d60d240b696(data) {
  self endon("death");

  if(!isDefined(self) || istrue(self.isdestroyed)) {
    return;
  }

  self setscriptablepartstate("ddos", "disabled", 0);
  self.owner thread function_45556aa41f4f9ae8(self, self.ownerindex, 0, undefined, 6);

  if(isDefined(self.pilot)) {
    var_e7c55e8864b07cca = [self.pilot];

    if(isDefined(self.watchers) && self.watchers.size > 0) {
      var_e7c55e8864b07cca = array_combine(var_e7c55e8864b07cca, self.watchers);
    }

    foreach(user in var_e7c55e8864b07cca) {
      user thread function_ffcd9ab398a2d1ab(self);
    }
  }
}

function function_43b972da103a0b1b(data) {
  self setscriptablepartstate("ddos", "neutral", 0);
}

function function_45556aa41f4f9ae8(camera, index, status, forcestate, var_be632e8c9259a360) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.var_2d5baa13a621c5eb)) {
    self.var_2d5baa13a621c5eb = [];
  }

  struct = spawnStruct();
  struct.camera = camera;
  struct.index = index;
  struct.status = status;
  struct.forcestate = istrue(forcestate);
  struct.var_be632e8c9259a360 = ter_op(isDefined(var_be632e8c9259a360), var_be632e8c9259a360, 0);
  self.var_2d5baa13a621c5eb[self.var_2d5baa13a621c5eb.size] = struct;
  thread function_797aa6baae156a75();
}

function function_797aa6baae156a75() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("tacticalCamera_allCamerasRemoved");
  self notify("deployableCamera_statusQueue");
  self endon("deployableCamera_statusQueue");

  if(istrue(level.gameended) || !isDefined(self)) {
    return;
  }

  while(isDefined(self.var_2d5baa13a621c5eb) && self.var_2d5baa13a621c5eb.size > 0) {
    waitframe();
    struct = array_get_first_item(self.var_2d5baa13a621c5eb);
    self notify("personal_camera_status_updated", struct.camera, struct.index, struct.status, struct.forcestate, struct.var_be632e8c9259a360);
    self.var_2d5baa13a621c5eb = array_remove(self.var_2d5baa13a621c5eb, struct);
  }
}

function private function_3f6b8f7cff6a2c37(camera, transitiontime) {
  camera endon("emp_cleared");
  self endon("playerLeavingCurrentCamera");
  halftime = transitiontime / 2;
  function_7abf9767930dca21(camera, "taccam_static_start", halftime);
  wait halftime;
  function_7abf9767930dca21(camera, "taccam_static_mid", halftime);
  wait halftime;
}

function private function_e0a9c9a0a70b1ee5(camera, var_c0754ca9aa8976da) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\cp_mp\emp_debuff::play_emp_scramble(1);
  returnmsg = function_47e6ed10be33fef1(camera, var_c0754ca9aa8976da);

  if(!isDefined(returnmsg) || returnmsg != "timeout") {
    scripts\cp_mp\emp_debuff::function_f7c6d776d032122f();
    function_eca023ad97260f51(camera);
    return;
  }

  thread function_9f25ae386db6338a(camera);
}

function private function_47e6ed10be33fef1(camera, var_33153258526a7b2) {
  childthread function_3f6b8f7cff6a2c37(camera, var_33153258526a7b2);
  msg = scripts\engine\utility::waittill_any_ents_or_timeout_return(var_33153258526a7b2, camera, "emp_cleared", self, "playerExitingCameraMode");
  return msg;
}

function function_ffcd9ab398a2d1ab(camera) {
  level endon("game_ended");
  self endon("disconnect");
  camera endon("death");
  self notify("deployableCamera_monitoringHaywire");
  self endon("deployableCamera_monitoringHaywire");
  self.targetsinouterradius = [];
  function_bfcdb898d70f248c();
  function_7abf9767930dca21(camera, "taccam_static_full");
  msg = camera waittill_any_ents_return(camera, "haywire_cleared", self, "playerLeavingCurrentCamera", self, "death", self, "playerExitingCameraMode");

  if(!isDefined(msg) || msg == "playerLeavingCurrentCamera" || msg == "death") {
    function_eca023ad97260f51(camera);
    return;
  }

  function_4789702c319cd7a7(camera);
  function_c9ad5aaf3183b83c();
}

function function_9f25ae386db6338a(camera) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("deployableCamera_monitoringEMP");
  self endon("deployableCamera_monitoringEMP");
  thread function_f238d4c7bab11c82(camera);
  self.targetsinouterradius = [];
  function_bfcdb898d70f248c();
  function_7abf9767930dca21(camera, "taccam_static_full");
  self setclientomnvar("ui_tactical_camera_ddos_on", 1);

  if(!isDefined(self.empscramblelevels) || self.empscramblelevels.size == 0) {
    scripts\cp_mp\emp_debuff::play_emp_scramble(3);
  }

  msg = camera waittill_any_ents_return(camera, "emp_cleared", self, "playerLeavingCurrentCamera", self, "death", self, "playerExitingCameraMode");

  if(!isDefined(msg) || msg == "playerLeavingCurrentCamera" || msg == "death") {
    function_eca023ad97260f51(camera);
  } else {
    function_4789702c319cd7a7(camera);
    function_c9ad5aaf3183b83c();
  }

  if(msg == "death" || msg == "playerExitingCameraMode" || msg == "emp_cleared" || msg == "playerLeavingCurrentCamera") {
    scripts\cp_mp\emp_debuff::function_f7c6d776d032122f();
  }
}

function function_f238d4c7bab11c82(camera) {
  level endon("game_ended");
  self endon("disconnect");
  camera notify("deployableCamera_monitoringEMPVFX");
  camera endon("deployableCamera_monitoringEMPVFX");
  camera waittill_any_2("death", "emp_cleared");
  camera setscriptablepartstate("ddos", "neutral", 0);
  self setclientomnvar("ui_tactical_camera_ddos_on", 0);
}

function function_652247ce1acb67c2(data) {
  attacker = data.attacker;
  self dodamage(self.maxhealth / 10, self.origin, attacker, data.inflictor);

  if(isDefined(self.damagetaken) && self.damagetaken >= 100) {
    if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
      attacker notify("destroyed_equipment");
      attacker thread scripts\mp\utility\points::doscoreevent(#"destroyed_equipment");
      attacker scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    }
  }
}

function function_c7dbea1f56df2b64(camera, cameratype) {
  var_c748b31a33c02c14 = function_f0698aee89c18210(cameratype).exitfunc;
  self endon("death");
  camera endon("entering");
  level waittill("game_ended");
  [[var_c748b31a33c02c14]](camera, 0);
}

function function_30dd206c5d9b45a7() {
  childthread function_d600a854b585442d();
  childthread function_de1222813ff9939b();
  childthread function_ab5da94d0c38ab3c();
  self waittill("activateCamera", msg);
  self notifyonplayercommandremove("tacButtonPress", "+smoke");
  self notifyonplayercommandremove("tacButtonPress", "+actionslot 1");
  self notifyonplayercommandremove("fragButtonPress", "+frag");
  self notifyonplayercommandremove("fragButtonPress", "+equip_toggle_throw");
  self notifyonplayercommandremove("cameraActive", "+special");
  return msg == "success";
}

function private function_537b1c669b864647() {
  childthread function_ce83a297e29bc7dd();
  childthread function_f981c735613b390b();
  self waittill("switchCamera", msg);
  function_13e2543cd1847ca6();
  return msg;
}

function function_13e2543cd1847ca6() {
  self notifyonplayercommandremove("camSwitchKBM", "+special");
  self notifyonplayercommandremove("cameraSwitchLeft", "+smoke");
  self notifyonplayercommandremove("cameraSwitchRight", "+frag");
}

function private function_f981c735613b390b() {
  self endon("switchCamera");
  self notifyonplayercommand("cameraSwitchLeftController", "+smoke");
  self notifyonplayercommand("cameraSwitchRightController", "+frag");
  msg = waittill_any_return_2("cameraSwitchLeftController", "cameraSwitchRightController");

  if(is_player_gamepad_enabled()) {
    msg = strtok(msg, "Controller");
    self notify("switchCamera", msg[0]);
  }
}

function private function_ce83a297e29bc7dd() {
  self endon("switchCamera");
  self notifyonplayercommand("cameraSwitchLeftKBM", "+moveleft");
  self notifyonplayercommand("cameraSwitchRightKBM", "+moveright");
  msg = waittill_any_return_2("cameraSwitchLeftKBM", "cameraSwitchRightKBM");

  if(!is_player_gamepad_enabled()) {
    msg = strtok(msg, "KBM");
    self notify("switchCamera", msg[0]);
  }
}

function function_eb1f8c19d4194ac3(var_b8f96bd12748f572, var_68eb6389cfeb3270, cameraweaponname) {
  cameracluster = self[[var_68eb6389cfeb3270]]();

  if(!isDefined(cameracluster) || cameracluster.size == 0) {
    return false;
  }

  if(!function_84582dd92c385507(cameraweaponname)) {
    return false;
  }

  currentweapon = self.currentweapon;

  if(currentweapon.basename == "iw9_me_riotshield_mp") {
    self.var_75b981560f8453f4 = 1;
    self notify("activateCamera", "success");
    return true;
  }

  ammoclip = self getweaponammoclip(currentweapon);
  ammostock = self getweaponammostock(currentweapon);
  _takeweapon(currentweapon);
  _takeweapon(var_b8f96bd12748f572);
  self clearoffhandspecial();
  self.var_75b981560f8453f4 = 1;
  self notify("activateCamera", "success");
  _giveweapon(var_b8f96bd12748f572);
  self assignweaponoffhandspecial(var_b8f96bd12748f572);
  thread function_299b7fa84b1d28d1(currentweapon, ammoclip, ammostock);
  return true;
}

function function_299b7fa84b1d28d1(previousweapon, ammoclip, ammostock) {
  level endon("game_ended");
  self endon("disconnect");
  waittime = getdvarfloat(@ "hash_83f60684c63746be", 0);
  wait waittime + 0.05;
  _giveweapon(previousweapon, undefined, undefined, 1);
  self setweaponammoclip(previousweapon, ammoclip);
  self setweaponammostock(previousweapon, ammostock);
}

function private function_d600a854b585442d() {
  self endon("activateCamera");
  self notifyonplayercommand("cameraActive", "+special");
  self waittill("cameraActive");
  self notify("activateCamera", "success");
}

function private function_de1222813ff9939b() {
  self endon("activateCamera");
  self notifyonplayercommand("tacButtonPress", "+smoke");
  self notifyonplayercommand("fragButtonPress", "+frag");
  var_bd1267e9dea3dba9 = ["tacButtonPress", "fragButtonPress"];
  thread function_8d6d95114b2c9b0d(var_bd1267e9dea3dba9, ["activateCamera"], 0.75);
  self waittill("controllerSuperPress", msg);
  self notify("activateCamera", msg);
}

function private function_ab5da94d0c38ab3c() {
  self endon("activateCamera");
  self notifyonplayercommand("tacButtonPress", "+actionslot 1");
  self notifyonplayercommand("fragButtonPress", "+equip_toggle_throw");
  var_bd1267e9dea3dba9 = ["tacButtonPress", "fragButtonPress"];
  thread function_8d6d95114b2c9b0d(var_bd1267e9dea3dba9, ["activateCamera"], 0.75);
  self waittill("controllerSuperPress", msg);
  self notify("activateCamera", msg);
}

function function_84582dd92c385507(cameraweaponname) {
  if(self isswimunderwater()) {
    return false;
  }

  if(istrue(self.isjuggernaut)) {
    return false;
  }

  if(self isinfreefall()) {
    return false;
  }

  if(self isjumping()) {
    return false;
  }

  if(self ishanging()) {
    return false;
  }

  if(self isdiving()) {
    return false;
  }

  if(self isthrowinggrenade()) {
    offhandweapon = self getheldoffhand();

    if(offhandweapon.basename != cameraweaponname) {
      return false;
    }
  }

  if(istrue(self.deployingcamera)) {
    return false;
  }

  if(istrue(self.isusingcamera)) {
    return false;
  }

  if(isDefined(self.vehicle)) {
    return false;
  }

  if(!val::get("supers")) {
    return false;
  }

  if(istrue(self.super.isdeploying)) {
    return false;
  }

  if(istrue(self.var_8a38603863a78b8e)) {
    return false;
  }

  if(istrue(self.var_859654e0445a36d9)) {
    return false;
  }

  if(self isswitchingweapon() && !istrue(self.var_75b981560f8453f4)) {
    return false;
  }

  return true;
}

function function_b1fc1520e09105aa(camera) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("playerLeavingCurrentCamera");

  if(!isDefined(self.c4s) || self.c4s.size == 0) {
    return 0;
  }

  self notifyonplayercommand("c4_detonated", "+detonate");
  self notifyonplayercommand("c4_detonated", "+attack");
  self setclientomnvar("ui_tactical_camera_can_detonate_c4", 1);
  self waittill("c4_detonated");
  self notify("detonate");
  self setclientomnvar("ui_tactical_camera_can_detonate_c4", 0);
}

function function_57e0efe2f886bd46() {
  self notifyonplayercommandremove("c4_detonated", "+detonate");
  self notifyonplayercommandremove("c4_detonated", "+attack");
}

function function_2699a7c2c0b71d3e(camera, cameratype) {
  var_c748b31a33c02c14 = function_f0698aee89c18210(cameratype).exitfunc;
  self endon("death_or_disconnect");
  camera endon("death");
  self endon("playerLeavingCurrentCamera");
  level endon("game_ended");

  while(true) {
    if(self isinexecutionvictim()) {
      break;
    }

    waitframe();
  }

  self thread[[var_c748b31a33c02c14]](camera, 0);
}

function private function_e4d938ad226591fd(cam) {
  cam setentityhudoutlinedata(3, cam.ownerteam);
  return cam;
}

function function_b13a5b9e0ea04dbd(target) {
  if(!isDefined(target)) {
    return 0;
  }

  params = function_f0698aee89c18210(self.cameratype);
  var_128777c73408ae9d = params.var_37782917998d4ff2;

  if(istrue(self.isunderwater) || istrue(target isswimmingunderwater())) {
    var_128777c73408ae9d = params.var_9953dc2e8c205b77;
  }

  if(!isDefined(var_128777c73408ae9d)) {
    return;
  }

  return distancesquared(self.origin, target.origin) < var_128777c73408ae9d;
}

function function_a268c4595bd106ff(target) {
  if(!isDefined(target)) {
    return false;
  }

  params = function_f0698aee89c18210(self.cameratype);
  detectrangesq = params.var_4fbadc7102d30912;

  if(istrue(self.isunderwater) || istrue(target isswimmingunderwater())) {
    detectrangesq = params.var_16187e4d354c3c97;
  }

  return distancesquared(self.origin, target.origin) < detectrangesq;
}

function function_9d2bec87e0754872(target) {
  info = spawnStruct();
  info.isvisible = function_4e3aa9d829b3e164(target);
  info.var_9ae205c4c40af967 = function_f6ba29efe27b0f81(target);
  info.isinrange = function_b13a5b9e0ea04dbd(target);
  info.isindetectrange = function_a268c4595bd106ff(target);

  if(isDefined(self.pilot)) {
    info.isinreticle = self.pilot function_1b1409af5e47b098(target, 80, 40);
  }

  return info;
}

function function_8409d7ce07f426a1(camera) {
  level endon("game_ended");
  self endon("disconnect");
  camera endon("death");
  destroyfunc = function_f0698aee89c18210(camera.cameratype).destroyfunc;
  radius = getdvarfloat(@ "hash_b076f58c9b234db3", 140);
  doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(camera.origin, radius, 20);
  camera.monitoreddoors = [];

  foreach(door in doors) {
    var_31f5044848a4ae3 = spawnStruct();
    var_31f5044848a4ae3.door = door;
    var_31f5044848a4ae3.vectorbetween = camera.origin - door.origin;
    var_31f5044848a4ae3.lastangles = door.angles;
    var_31f5044848a4ae3.doorwidth = 56;
    var_31f5044848a4ae3.doorheight = 96;
    camera.monitoreddoors = array_add(camera.monitoreddoors, var_31f5044848a4ae3);
  }

  if(camera.monitoreddoors.size == 0) {
    return;
  }

  while(isDefined(camera) && !istrue(camera.isdestroyed)) {
    foreach(doorstruct in camera.monitoreddoors) {
      if(doorstruct.door.angles != doorstruct.lastangles) {
        doorstruct.lastangles = doorstruct.door.angles;
        anglebetween = math::anglebetweenvectors(flatten_vector(doorstruct.vectorbetween), anglesToForward(doorstruct.door.angles));

        if(anglebetween < 5) {
          distancewidth = vectordot(anglesToForward(doorstruct.door.angles), doorstruct.vectorbetween);
          distanceheight = vectordot(anglestoup(doorstruct.door.angles), doorstruct.vectorbetween);

          if(distancewidth < doorstruct.doorwidth && distanceheight < doorstruct.doorheight) {
            camera thread[[destroyfunc]]();
            break;
          }
        }
      }
    }

    waitframe();
  }
}

function function_2f4e45ab83f0b424(camera) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stopMonitoringCamera");

  while(true) {
    self waittill("switch_thermal_mode");

    if(camera scripts\cp_mp\emp_debuff::is_empd()) {
      continue;
    }

    visionset = function_149fe9342a5ea239(camera);
    camera function_7f8da30c35b9ab0(camera, ter_op(visionset == "tacCam", "killstreak_thermal", "tacCam"));
    function_4789702c319cd7a7(camera);
  }
}

function function_7f8da30c35b9ab0(camera, visionsetname) {
  camera.currentvisionset = visionsetname;
}

function function_4789702c319cd7a7(camera, var_3830144da9e3136b) {
  visionset = function_149fe9342a5ea239(camera);
  players = [self];

  if(!istrue(var_3830144da9e3136b)) {
    if(isDefined(camera.watchers)) {
      foreach(player in camera.watchers) {
        if(isDefined(player) && isalive(player)) {
          players[players.size] = player;
        }
      }
    }
  }

  foreach(player in players) {
    player function_7abf9767930dca21(camera, visionset);
  }
}

function function_7abf9767930dca21(camera, visionsetname, transitiontime) {
  if(!isDefined(transitiontime)) {
    transitiontime = 0;
  }

  if(camera.currentvisionset == "killstreak_thermal") {
    self visionsetkillstreakforplayer("");
    self visionsetthermalforplayer(visionsetname, transitiontime);
    self thermalvisionon();
    return;
  }

  self visionsetthermalforplayer("");
  self visionsetkillstreakforplayer(visionsetname, transitiontime);
  self thermalvisionoff();
}

function function_eca023ad97260f51(camera, var_4602d2933c2d30a8) {
  assertex(isDefined(camera.currentvisionset), "<dev string:x252>");

  if(camera.currentvisionset == "killstreak_thermal") {
    self visionsetthermalforplayer("");
  } else {
    self visionsetkillstreakforplayer("");
  }

  self thermalvisionoff();

  if(istrue(var_4602d2933c2d30a8)) {
    camera.currentvisionset = undefined;
  }
}

function function_149fe9342a5ea239(camera) {
  if(isDefined(camera.currentvisionset)) {
    return camera.currentvisionset;
  }

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    camera.currentvisionset = "killstreak_thermal";
  } else {
    camera.currentvisionset = "tacCam";
  }

  return camera.currentvisionset;
}

function function_804a24f3e1a7b680() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stopMonitoringCamera");

  while(true) {
    var_ff8e235b01cd7409 = getthermalswitchplayercommand();
    self notifyonplayercommand("switch_thermal_mode", var_ff8e235b01cd7409);
    returnednotif = waittill_any_return_no_endon_death_2("input_type_changed", "thermal_handling_ended");
    self notifyonplayercommandremove("switch_thermal_mode", var_ff8e235b01cd7409);

    if(!isDefined(returnednotif) || returnednotif == "thermal_handling_ended") {
      break;
    }
  }
}

function function_7df57541f06a5f0() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("usingCamera");
  starttime = gettime();

  while(gettime() < starttime + 1000) {
    self disablephysicaldepthoffieldscripting();
    wait 0.1;
  }
}