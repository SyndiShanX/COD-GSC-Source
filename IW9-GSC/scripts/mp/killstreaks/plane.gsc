/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\plane.gsc
***********************************************/

init() {
  if(!isDefined(level.planes))
    level.planes = [];

  if(!isDefined(level.planeconfigs))
    level.planeconfigs = [];

  level.fighter_deathfx = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level.fx_airstrike_afterburner = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level.fx_airstrike_contrail = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level.fx_airstrike_wingtip_light_green = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level.fx_airstrike_wingtip_light_red = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
}

getflightpath(_id_6E7C70B904418DAA, _id_CEBE2632E00D0E2D, _id_5ED27D0675C3B6EB, _id_31A3FFCE4C03AB3B, _id_76AB620FD7CC70BD, _id_23122E7B902F2EA9, _id_3D05B2DD8E6FD146, streakname) {
  startpoint = _id_6E7C70B904418DAA + _id_CEBE2632E00D0E2D * (-1 * _id_5ED27D0675C3B6EB);
  endpoint = _id_6E7C70B904418DAA + _id_CEBE2632E00D0E2D * _id_5ED27D0675C3B6EB;

  if(_id_31A3FFCE4C03AB3B) {
    startpoint = startpoint * (1, 1, 0);
    endpoint = endpoint * (1, 1, 0);
  }

  startpoint = startpoint + (0, 0, _id_76AB620FD7CC70BD);
  endpoint = endpoint + (0, 0, _id_76AB620FD7CC70BD);
  _id_AC0E564AC96A9D0F = length(startpoint - endpoint);
  flytime = _id_AC0E564AC96A9D0F / _id_23122E7B902F2EA9;
  _id_AC0E564AC96A9D0F = abs(0.5 * _id_AC0E564AC96A9D0F + _id_3D05B2DD8E6FD146);
  _id_36AC3439A44D6300 = _id_AC0E564AC96A9D0F / _id_23122E7B902F2EA9;
  flightpath["startPoint"] = startpoint;
  flightpath["endPoint"] = endpoint;
  flightpath["attackTime"] = _id_36AC3439A44D6300;
  flightpath["flyTime"] = flytime;
  return flightpath;
}

doflyby(lifeid, owner, _id_1685818911FDDBED, startpoint, endpoint, _id_36AC3439A44D6300, flytime, _id_CEBE2632E00D0E2D, streakname) {
  plane = planespawn(lifeid, owner, startpoint, _id_CEBE2632E00D0E2D, streakname);
  plane endon("death");
  _id_B81987C3ACA12361 = 150;
  _id_8B79D0E3AD3FB617 = endpoint + ((randomfloat(2) - 1) * _id_B81987C3ACA12361, (randomfloat(2) - 1) * _id_B81987C3ACA12361, 0);
  plane planemove(_id_8B79D0E3AD3FB617, flytime, _id_36AC3439A44D6300, streakname);
  plane planecleanup();
}

planespawn(lifeid, owner, startpoint, _id_CEBE2632E00D0E2D, streakname) {
  if(!isDefined(owner)) {
    return;
  }
  _id_A1F40E475BADBBDC = 100;
  pathstart = startpoint + ((randomfloat(2) - 1) * _id_A1F40E475BADBBDC, (randomfloat(2) - 1) * _id_A1F40E475BADBBDC, 0);
  _id_6C46B9C8F713361B = level.planeconfigs[streakname];
  plane = undefined;
  plane = spawn("script_model", pathstart);
  plane.team = owner.team;
  plane.origin = pathstart;
  plane.angles = vectortoangles(_id_CEBE2632E00D0E2D);
  plane.lifeid = lifeid;
  plane.streakname = streakname;
  plane.owner = owner;
  plane setModel(_id_6C46B9C8F713361B.modelnames[owner.team]);

  if(isDefined(_id_6C46B9C8F713361B.compassiconfriendly))
    plane setobjectiveicons(_id_6C46B9C8F713361B.compassiconfriendly, _id_6C46B9C8F713361B.compassiconenemy);

  plane thread handledamage();
  plane thread handledeath();
  starttrackingplane(plane);

  if(!isDefined(_id_6C46B9C8F713361B.nolightfx))
    plane thread playplanefx();

  plane playLoopSound(_id_6C46B9C8F713361B.inboundsfx);
  plane createkillcam(streakname);
  return plane;
}

planemove(destination, flytime, _id_36AC3439A44D6300, streakname) {
  _id_6C46B9C8F713361B = level.planeconfigs[streakname];
  self moveTo(destination, flytime, 0, 0);

  if(isDefined(_id_6C46B9C8F713361B.onattackdelegate))
    self thread[[_id_6C46B9C8F713361B.onattackdelegate]](destination, flytime, _id_36AC3439A44D6300, self.owner, streakname);

  if(isDefined(_id_6C46B9C8F713361B.sonicboomsfx))
    thread playsonicboom(_id_6C46B9C8F713361B.sonicboomsfx, 0.5 * flytime);

  wait(0.65 * flytime);

  if(isDefined(_id_6C46B9C8F713361B.outboundsfx)) {
    self stoploopsound();
    self playLoopSound(_id_6C46B9C8F713361B.outboundsfx);
  }

  if(isDefined(_id_6C46B9C8F713361B.outboundflightanim))
    self scriptmodelplayanimdeltamotion(_id_6C46B9C8F713361B.outboundflightanim);

  wait(0.35 * flytime);
}

planecleanup() {
  _id_6C46B9C8F713361B = level.planeconfigs[self.streakname];

  if(isDefined(_id_6C46B9C8F713361B.onflybycompletedelegate))
    thread[[_id_6C46B9C8F713361B.onflybycompletedelegate]](self.owner, self, self.streakname);

  if(isDefined(self.friendlyteamid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.friendlyteamid);
    scripts\mp\objidpoolmanager::returnobjectiveid(self.enemyteamid);
  }

  if(isDefined(self.killcament))
    self.killcament delete();

  stoptrackingplane(self);
  self notify("delete");
  self delete();
}

handledeath() {
  level endon("game_ended");
  self endon("delete");
  self waittill("death");
  forward = anglesToForward(self.angles) * 200;
  playFX(level.fighter_deathfx, self.origin, forward);
  thread planecleanup();
}

handledamage() {
  self endon("end_remote");
  scripts\mp\damage::monitordamage(800, "helicopter", ::handledeathdamage, ::modifydamage, 1);
}

modifydamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  _id_702BFC08FABD86CB = damage;
  _id_702BFC08FABD86CB = scripts\mp\damage::handlemissiledamage(objweapon, type, _id_702BFC08FABD86CB);
  _id_702BFC08FABD86CB = scripts\mp\damage::handleapdamage(objweapon, type, _id_702BFC08FABD86CB, attacker);
  return _id_702BFC08FABD86CB;
}

handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  config = level.planeconfigs[self.streakname];
  scripts\mp\damage::onkillstreakkilled(self.streakname, attacker, objweapon, type, damage, config.scorepopup, config.destroyedvo, config.callout);
}

playplanefx() {
  self endon("death");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_right");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_wingtip_light_red, self, "tag_right_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_wingtip_light_green, self, "tag_left_wingtip");
}

getplaneflyheight() {
  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();

  if(isDefined(_id_5FA1E1697A302583))
    return _id_5FA1E1697A302583.origin[2];
  else {
    _id_76AB620FD7CC70BD = 950;
    return _id_76AB620FD7CC70BD;
  }
}

getplaneflightplan(_id_DEDAE0DD99C6FC10) {
  result = spawnStruct();
  result.height = getplaneflyheight();
  _id_5FA1E1697A302583 = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();

  if(isDefined(_id_5FA1E1697A302583) && isDefined(_id_5FA1E1697A302583.script_noteworthy) && _id_5FA1E1697A302583.script_noteworthy == "fixedposition") {
    result.targetpos = _id_5FA1E1697A302583.origin;
    result.flightdir = anglesToForward(_id_5FA1E1697A302583.angles);

    if(randomint(2) == 0)
      result.flightdir = result.flightdir * -1;
  } else {
    forwardvec = anglesToForward(self.angles);
    _id_6F0E7A5743E7A561 = anglestoright(self.angles);
    result.targetpos = self.origin + _id_DEDAE0DD99C6FC10 * forwardvec;
    result.flightdir = -1 * _id_6F0E7A5743E7A561;
  }

  return result;
}

getexplodedistance(height) {
  _id_E5DC9ECDAD877027 = 850;
  _id_17BCA7AB954CC95F = 1500;
  _id_3369989E4AAB456A = _id_E5DC9ECDAD877027 / height;
  _id_1003B817E555135A = _id_3369989E4AAB456A * _id_17BCA7AB954CC95F;
  return _id_1003B817E555135A;
}

starttrackingplane(obj) {
  entnum = obj getentitynumber();
  level.planes[entnum] = obj;
}

stoptrackingplane(obj) {
  entnum = obj getentitynumber();
  level.planes[entnum] = undefined;
}

selectairstrikelocation(lifeid, streakname, _id_9DD357E6FEE9854E) {
  _id_F9A71726D6ADA1FD = level.mapsize / 6.46875;

  if(level.splitscreen)
    _id_F9A71726D6ADA1FD = _id_F9A71726D6ADA1FD * 1.5;

  config = level.planeconfigs[streakname];

  if(isDefined(config.selectlocationvo))
    self playlocalsound(game["voice"][self.team] + config.selectlocationvo);

  scripts\mp\utility\killstreak::_beginlocationselection(streakname, "map_artillery_selector", config.choosedirection, _id_F9A71726D6ADA1FD);
  self endon("stop_location_selection");
  self waittill("confirm_location", location, _id_A4521BB88F4EB389);

  if(!config.choosedirection)
    _id_A4521BB88F4EB389 = randomint(360);

  self setblurforplayer(0, 0.3);

  if(isDefined(config.inboundvo))
    self playlocalsound(game["voice"][self.team] + config.inboundvo);

  self thread[[_id_9DD357E6FEE9854E]](lifeid, location, _id_A4521BB88F4EB389, streakname);
  return 1;
}

setobjectiveicons(friendlyicon, _id_30F120A1EFC1DCBE) {
  friendlyteamid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(friendlyteamid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(friendlyteamid, "active", (0, 0, 0), friendlyicon);
    scripts\mp\objidpoolmanager::update_objective_onentitywithrotation(friendlyteamid, self);
  }

  self.friendlyteamid = friendlyteamid;
  enemyteamid = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(enemyteamid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(enemyteamid, "active", (0, 0, 0), _id_30F120A1EFC1DCBE);
    scripts\mp\objidpoolmanager::update_objective_onentitywithrotation(enemyteamid, self);
  }

  self.enemyteamid = enemyteamid;

  if(level.teambased) {
    if(friendlyteamid != -1)
      scripts\mp\objidpoolmanager::objective_teammask_single(friendlyteamid, self.team);

    if(enemyteamid != -1)
      scripts\mp\objidpoolmanager::objective_teammask_single(enemyteamid, scripts\mp\utility\game::getotherteam(self.team)[0]);
  } else {
    if(friendlyteamid != -1)
      scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(friendlyteamid, self.owner);

    if(enemyteamid != -1)
      scripts\mp\objidpoolmanager::objective_mask_showtoplayerteam(enemyteamid, self.owner);
  }
}

playsonicboom(_id_CB3339ECE72DBDEB, delay) {
  self endon("death");
  wait(delay);
  self playsoundonmovingent(_id_CB3339ECE72DBDEB);
}

createkillcam(streakname) {
  _id_6C46B9C8F713361B = level.planeconfigs[streakname];

  if(isDefined(_id_6C46B9C8F713361B.killcamoffset)) {
    _id_7A05F5CEED8AB610 = anglesToForward(self.angles);
    killcament = spawn("script_model", self.origin + (0, 0, 100) - _id_7A05F5CEED8AB610 * 200);
    killcament.starttime = gettime();
    killcament setscriptmoverkillcam("airstrike");
    killcament linkTo(self, "tag_origin", _id_6C46B9C8F713361B.killcamoffset, (0, 0, 0));
    self.killcament = killcament;
  }
}