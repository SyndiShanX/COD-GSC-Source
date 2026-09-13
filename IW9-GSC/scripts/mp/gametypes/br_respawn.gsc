/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_respawn.gsc
***********************************************/

init() {
  setdvarifuninitialized("scr_br_respawn", 0);
  level.br_respawn_enabled = getdvarint("scr_br_respawn", 0) != 0;

  if(!istrue(level.br_respawn_enabled)) {
    removeambulances();
    return;
  }

  level._effect["ambulance_light"] = loadfx("vfx/iw8/level/stpetersburg/vfx_stpburg_police_lights.vfx");
  level.br_respawnambulances = [];
  _id_2695A20D4011076D::_id_ECA79FA0F341EE08(6, ::dangercircletick);
  thread setuphud();
}

removeambulances() {
  _id_AA43B883CBA2C7FD = scripts\engine\utility::getStructArray("br_respawn_station", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_AA43B883CBA2C7FD.size; _id_AC0E594AC96AA3A8++) {
    collision = getEnt(_id_AA43B883CBA2C7FD[_id_AC0E594AC96AA3A8].target, "targetname");

    if(isDefined(collision))
      collision delete();
  }
}

spawnambulance(struct) {
  if(!istrue(level.br_respawn_enabled))
    return undefined;

  ambulance = spawn("script_model", struct.origin);

  if(isDefined(struct.angles))
    ambulance.angles = struct.angles;
  else
    ambulance.angles = (0, 0, 0);

  ambulance setModel("veh8_civ_lnd_palfa_ambulance_ukraine");
  ambulance.struct = struct;
  ambulance ambulancesetup(struct);
  ambulance thread ambulancethink();
  level.br_respawnambulances[level.br_respawnambulances.size] = ambulance;
  return ambulance;
}

ambulancesetup(struct) {
  thread ambulancelights();
  _id_58208F21379E7390 = scripts\engine\utility::getStruct(struct.target, "targetname");

  if(!isDefined(self.defibrillator)) {
    defibrillator = spawn("script_model", _id_58208F21379E7390.origin);

    if(isDefined(_id_58208F21379E7390.angles))
      defibrillator.angles = _id_58208F21379E7390.angles;

    defibrillator setModel("medical_defibrillator_wall_01");
    defibrillator makeusable();
    defibrillator setCursorHint("HINT_NOICON");
    defibrillator setuseholdduration("duration_medium");
    defibrillator sethintdisplayfov(120);
    defibrillator setusefov(120);
    defibrillator setuserange(80);
    defibrillator setHintString(&"MP/BR_RESPAWN_TAKE");
    defibrillator hudoutlineenable("outline_depth_red");
    defibrillator setusepriority(-1);
    defibrillator setasgametypeobjective();
    self.defibrillator = defibrillator;
  }

  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  self.objectiveiconid = objectiveiconid;

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "invisible", (0, 0, 0));
    scripts\mp\objidpoolmanager::update_objective_onentity(objectiveiconid, self);
    scripts\mp\objidpoolmanager::update_objective_state(objectiveiconid, "active");
    scripts\mp\objidpoolmanager::update_objective_icon(objectiveiconid, "hud_icon_respawn");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
  }
}

ambulancelights() {
  wait 1;
  dir = anglesToForward(self.angles);
  self.fx = spawnfx(scripts\engine\utility::getfx("ambulance_light"), self.origin + (0, 0, 75), dir, (0, 0, 1));
  triggerfx(self.fx);
}

ambulancethink() {
  self endon("death");

  for(;;) {
    self.defibrillator waittill("trigger", player);
    ambulancedefibrillator(player);
  }
}

setuphud() {
  level.br_deadcountdownhud = [];
}

initplayer() {
  if(!istrue(level.br_respawn_enabled)) {
    return;
  }
  hideallambulancesforplayer(self);
  disableallambulancesforplayer(self);
}

hideallambulancesforteam(team, _id_7A6A0B6777C25197) {
  if(istrue(_id_7A6A0B6777C25197)) {
    _id_203492E1624302BF = getrespawnableplayers(team);

    if(_id_203492E1624302BF.size > 0)
      return;
  }

  foreach(player in level.teamdata[team]["players"]) {
    if(isDefined(player))
      hideallambulancesforplayer(player);
  }
}

hideallambulancesforplayer(player) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_respawnambulances.size; _id_AC0E594AC96AA3A8++) {
    ambulance = level.br_respawnambulances[_id_AC0E594AC96AA3A8];

    if(isDefined(ambulance) && !istrue(ambulance.disabled))
      ambulance ambulancehidefromplayer(player);
  }
}

ambulancehidefromplayer(player) {
  if(isDefined(self.defibrillator))
    self.defibrillator hudoutlinedisableforclient(player);

  scripts\mp\objidpoolmanager::objective_playermask_hidefrom(self.objectiveiconid, player);
}

disableallambulancesforplayer(player) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_respawnambulances.size; _id_AC0E594AC96AA3A8++) {
    ambulance = level.br_respawnambulances[_id_AC0E594AC96AA3A8];

    if(isDefined(ambulance) && !istrue(ambulance.disabled))
      ambulance ambulancemakeunusabletoplayer(player);
  }
}

ambulancemakeunusabletoplayer(player) {
  if(isDefined(self.defibrillator))
    self.defibrillator disableplayeruse(player);
}

showallambulancesforteam(team) {
  foreach(player in level.teamdata[team]["players"]) {
    if(isDefined(player))
      showallambulancesforplayer(player);
  }
}

showallambulancesforplayer(player) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_respawnambulances.size; _id_AC0E594AC96AA3A8++) {
    ambulance = level.br_respawnambulances[_id_AC0E594AC96AA3A8];

    if(isDefined(ambulance) && !istrue(ambulance.disabled))
      ambulance ambulanceshowtoplayer(player);
  }
}

ambulanceshowtoplayer(player) {
  self.defibrillator hudoutlineenableforclient(player, "outline_depth_red");
  scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.objectiveiconid, player);
}

ambulanceenabletoteam(team) {
  foreach(player in level.teamdata[team]["players"]) {
    if(isDefined(player))
      ambulancemakeusabletoplayer(player);
  }
}

ambulancedisabletoteam(team) {
  foreach(player in level.teamdata[team]["players"]) {
    if(isDefined(player))
      ambulancemakeunusabletoplayer(player);
  }
}

ambulancemakeusabletoplayer(player) {
  self.defibrillator enableplayeruse(player);
}

ambulancedisable() {
  self notify("disabled");
  self.disabled = 1;
  self.defibrillator makeunusable();
  self.defibrillator hudoutlinedisable();
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);

  if(isDefined(self.fx))
    self.fx delete();
}

ambulancemakeunsabletoall() {
  self.defibrillator setHintString(&"MP/BR_RESPAWN_CHARGING");
  self.defibrillator setuseholdduration("duration_none");
}

ambulancemakeusable() {
  self.defibrillator setHintString(&"MP/BR_RESPAWN_TAKE");
  self.defibrillator setuseholdduration("duration_medium");
  players = getallrespawnableplayers();

  foreach(player in players)
  player.respawnent useentsetupcloseambulance(player.team);
}

anyambulancesavailable() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_respawnambulances.size; _id_AC0E594AC96AA3A8++) {
    ambulance = level.br_respawnambulances[_id_AC0E594AC96AA3A8];

    if(isDefined(ambulance) && !istrue(ambulance.disabled))
      return 1;
  }

  return 0;
}

dangercircletick(_id_819EDACDACB810E4, _id_E86632D645C137D0, _id_5D954F1724092F5A) {
  _id_52D59C928EB97C81 = _id_E86632D645C137D0 + _id_5D954F1724092F5A;

  if(!istrue(level.br_respawn_enabled)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_respawnambulances.size; _id_AC0E594AC96AA3A8++) {
    ambulance = level.br_respawnambulances[_id_AC0E594AC96AA3A8];

    if(isDefined(ambulance) && !istrue(ambulance.disabled) && distance2dsquared(_id_819EDACDACB810E4, ambulance.origin) > _id_52D59C928EB97C81 * _id_52D59C928EB97C81) {
      ambulance ambulancedisable();
      disablerespawnscenarios(ambulance);
    }
  }
}

disablerespawnscenarios(ambulance) {
  _id_86D657AFE8206DDA = !anyambulancesavailable();

  if(!_id_86D657AFE8206DDA && !isDefined(ambulance)) {
    return;
  }
  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(isDefined(player.respawnent) && _id_86D657AFE8206DDA) {
      player.respawnent notify("respawnComplete", 0);
      continue;
    }

    if(isDefined(ambulance) && isDefined(player.usedambulance) && player.usedambulance == ambulance) {
      player notify("defibrillator_done");
      player notify("portable_defibrillator_done");
    }
  }
}

playershoulddofauxdeath() {
  return istrue(level.br_respawn_enabled) && anyambulancesavailable() && (istrue(self.brwasinlaststand) || isDefined(self.respawnent));
}

playersetinlaststand() {
  self.brwasinlaststand = 1;
  _id_2CEDCC356F1B9FC8::setplayerdownedextrainfo(1);
}

playerdied(attacker, objweapon) {
  if(!istrue(level.br_respawn_enabled)) {
    return;
  }
  if(isDefined(attacker))
    attacker playertrytakedefibrillator(objweapon);

  if(!anyambulancesavailable()) {
    if(istrue(self.fauxdead))
      thread scripts\mp\playerlogic::spawnspectator(self.origin, self.angles);

    return;
  }

  self.brwasinlaststand = undefined;
  team = self.team;

  if(level.teamdata[team]["alivePlayers"].size == 0) {
    foreach(player in level.teamdata[team]["players"]) {
      if(!isDefined(player)) {
        continue;
      }
      if(isDefined(player.respawnent))
        player.respawnent notify("respawnComplete", 0);
    }

    return;
  }

  if(isDefined(self.body))
    self.body delete();
  else
    self.nocorpse = 1;

  scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_respawn::playerDied()");
  self.health = 1;
  thread playerkeeploadingstreamedassets();
  _id_DBCE45A33308630D = createpickupuseent(self.origin, team);
  _id_DBCE45A33308630D.timerhud = createplayerdeadcountdownhud(team, 180);
  updatecountdownhudlist(_id_DBCE45A33308630D.timerhud);
  _id_DBCE45A33308630D.drophud = createdropplayerhud(team);
  _id_DBCE45A33308630D thread useentrespawntimeout(180, self, team);
  _id_DBCE45A33308630D thread useentrespawncomplete(self, team);
  _id_DBCE45A33308630D thread useentpickupbody(self, team);
  _id_DBCE45A33308630D useentsetupcloseambulance(team);
  self.respawnent = _id_DBCE45A33308630D;
  playerfakespectate(1);
}

updatecountdownhudlist(timerhud) {
  _id_85AE1E2EC737A227 = -50;
  _id_85AE1D2EC7379FF4 = -100;
  _id_88939A74DB0EDC4E = -15;

  if(isDefined(timerhud))
    level.br_deadcountdownhud[level.br_deadcountdownhud.size] = timerhud;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < level.br_deadcountdownhud.size; _id_AC0E594AC96AA3A8++) {
    _id_620AC4FB091FB161 = level.br_deadcountdownhud[_id_AC0E594AC96AA3A8];

    for(_id_AC0E5C4AC96AAA41 = _id_AC0E594AC96AA3A8 - 1; _id_AC0E5C4AC96AAA41 >= 0 && getsoonerhud(_id_620AC4FB091FB161, level.br_deadcountdownhud[_id_AC0E5C4AC96AAA41]) == _id_620AC4FB091FB161; _id_AC0E5C4AC96AAA41--)
      level.br_deadcountdownhud[_id_AC0E5C4AC96AAA41 + 1] = level.br_deadcountdownhud[_id_AC0E5C4AC96AAA41];

    level.br_deadcountdownhud[_id_AC0E5C4AC96AAA41 + 1] = _id_620AC4FB091FB161;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_deadcountdownhud.size; _id_AC0E594AC96AA3A8++) {
    _id_620AC4FB091FB161 = level.br_deadcountdownhud[_id_AC0E594AC96AA3A8];

    if(isDefined(_id_620AC4FB091FB161))
      _id_620AC4FB091FB161 scripts\mp\hud_util::setpoint("BOTTOM RIGHT", "BOTTOM RIGHT", _id_85AE1E2EC737A227, _id_85AE1D2EC7379FF4 + _id_88939A74DB0EDC4E * _id_AC0E594AC96AA3A8);
  }
}

getsoonerhud(_id_FB11BBCA74CC0F51, _id_FB11B8CA74CC08B8) {
  if(!isDefined(_id_FB11B8CA74CC08B8))
    return _id_FB11BBCA74CC0F51;

  if(!isDefined(_id_FB11BBCA74CC0F51))
    return _id_FB11B8CA74CC08B8;

  if(_id_FB11BBCA74CC0F51.starttime <= _id_FB11B8CA74CC08B8.starttime)
    return _id_FB11BBCA74CC0F51;
  else
    return _id_FB11B8CA74CC08B8;
}

playerfakespectate(enabled) {
  _id_B138439CAA9E8B9D = !enabled;
  self allowmelee(_id_B138439CAA9E8B9D);
  self allowads(_id_B138439CAA9E8B9D);
  self allowfire(_id_B138439CAA9E8B9D);
  self allowcrouch(_id_B138439CAA9E8B9D);
  self allowprone(_id_B138439CAA9E8B9D);
  self allowreload(_id_B138439CAA9E8B9D);
  self setCanDamage(_id_B138439CAA9E8B9D);

  if(_id_B138439CAA9E8B9D) {
    self enableusability();
    self enableoffhandweapons();
    self unlink();
    self setcamerathirdperson(0);
    self notify("stopFakeSpectate");
    self setclientomnvar("ui_show_spectateHud", -1);
  } else {
    self disableusability();
    self disableoffhandweapons();
    thread playerfakespectatecontrols();
    self setcamerathirdperson(1);
  }
}

playerfakespectatecontrols() {
  self endon("death_or_disconnect");
  self endon("stopFakeSpectate");
  _id_E4087BADB9BB99D1 = undefined;

  for(;;) {
    next = self fragButtonPressed();
    _id_D4145D9E255225DC = self secondaryoffhandbuttonPressed();

    if(next || _id_D4145D9E255225DC || !isDefined(_id_E4087BADB9BB99D1) || !isalive(_id_E4087BADB9BB99D1) || isDefined(_id_E4087BADB9BB99D1.respawnent) || istrue(_id_E4087BADB9BB99D1.fauxdead)) {
      _id_D7487BBE79134C02 = getplayertospectate(self.team, _id_E4087BADB9BB99D1, next || !isDefined(_id_E4087BADB9BB99D1));

      if(!isDefined(_id_E4087BADB9BB99D1) || _id_E4087BADB9BB99D1 != _id_D7487BBE79134C02) {
        _id_E4087BADB9BB99D1 = _id_D7487BBE79134C02;
        self playerlinktodelta(_id_E4087BADB9BB99D1, "tag_eye");
        self setclientomnvar("ui_show_spectateHud", _id_E4087BADB9BB99D1 getentitynumber());
        scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
        scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_respawn::playerFakeSpectateControls()");
      }

      if(next) {
        while(self fragButtonPressed())
          waitframe();
      } else if(_id_D4145D9E255225DC) {
        while(self secondaryoffhandbuttonPressed())
          waitframe();
      }
    }

    waitframe();
  }
}

getplayertospectate(team, current, _id_75C19E050779587A) {
  _id_9A6BA9F5A0E705C7 = 0;

  if(isDefined(current)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.teamdata[team]["alivePlayers"].size; _id_AC0E594AC96AA3A8++) {
      player = level.teamdata[team]["alivePlayers"][_id_AC0E594AC96AA3A8];

      if(player == current) {
        _id_9A6BA9F5A0E705C7 = _id_AC0E594AC96AA3A8;
        break;
      }
    }
  }

  if(_id_75C19E050779587A)
    _id_9A6BA9F5A0E705C7 = (_id_9A6BA9F5A0E705C7 + 1) % level.teamdata[team]["alivePlayers"].size;
  else {
    _id_9A6BA9F5A0E705C7--;

    if(_id_9A6BA9F5A0E705C7 < 0)
      _id_9A6BA9F5A0E705C7 = level.teamdata[team]["alivePlayers"].size - 1;
  }

  return level.teamdata[team]["alivePlayers"][_id_9A6BA9F5A0E705C7];
}

playerkeeploadingstreamedassets() {
  self endon("disconnect");
  self waittill("spawned");
  self endon("spawned");

  for(;;) {
    _id_B45E94B269AE0A46 = scripts\mp\class::preloadandqueueclass(self.class, 1);
    _id_1583B947947AD005 = scripts\mp\playerlogic::getplayerassets(_id_B45E94B269AE0A46);

    while(!scripts\mp\playerlogic::allplayershaveassetsloaded(_id_1583B947947AD005))
      wait 0.1;

    while(scripts\mp\playerlogic::allplayershaveassetsloaded(_id_1583B947947AD005))
      wait 1.0;
  }
}

playertrytakedefibrillator(objweapon) {
  if(isalive(self) && isDefined(objweapon) && isDefined(objweapon.basename) && objweapon.basename == "iw8_defibrillator_mp" && self hasweapon("iw8_defibrillator_mp")) {
    self takeweapon("iw8_defibrillator_mp");
    weapons = self getweaponslistprimaries();

    if(weapons.size > 0 && !scripts\mp\utility\weapon::ismeleeoverrideweapon(weapons[0]))
      self switchtoweapon(weapons[0]);
    else if(weapons.size > 1 && !scripts\mp\utility\weapon::ismeleeoverrideweapon(weapons[1]))
      self switchtoweapon(weapons[1]);
    else if(self hasweapon("iw9_me_fists_mp"))
      self switchtoweapon("iw9_me_fists_mp");
    else {
      self giveweapon("iw9_me_fists_mp");
      self switchtoweapon("iw9_me_fists_mp");
    }

    self notify("defibrillator_done");
    self notify("portable_defibrillator_done");
  }
}

useentrespawntimeout(_id_6958D396E4AD3B95, _id_F99D56BCB582A8BA, team) {
  self endon("respawnComplete");
  _id_F99D56BCB582A8BA scripts\engine\utility::waittill_any_timeout_no_endon_death_1(_id_6958D396E4AD3B95, "disconnect");
  self notify("timeout");
  waittillframeend;

  foreach(player in level.teamdata[team]["players"]) {
    if(isDefined(player) && isDefined(player.usedambulance) && isDefined(self.ambulance) && player.usedambulance == self.ambulance)
      player notify("defibrillator_done");
  }

  if(isDefined(_id_F99D56BCB582A8BA)) {
    _id_F99D56BCB582A8BA playerfakespectate(0);
    _id_F99D56BCB582A8BA thread scripts\mp\playerlogic::spawnspectator(_id_F99D56BCB582A8BA.respawnent.origin, _id_F99D56BCB582A8BA.respawnent.angles);
  }

  cleanupbodydrop(self, team);
}

useentrespawncomplete(_id_F99D56BCB582A8BA, team) {
  self endon("timeout");
  _id_F99D56BCB582A8BA endon("disconnect");
  self waittill("respawnComplete", result);

  if(istrue(result)) {
    if(isDefined(_id_F99D56BCB582A8BA.body))
      _id_F99D56BCB582A8BA.body delete();

    _id_F99D56BCB582A8BA playerrespawn(self.origin, self.angles);
  } else if(isDefined(_id_F99D56BCB582A8BA)) {
    _id_F99D56BCB582A8BA playerfakespectate(0);
    _id_F99D56BCB582A8BA thread scripts\mp\playerlogic::spawnspectator(_id_F99D56BCB582A8BA.respawnent.origin, _id_F99D56BCB582A8BA.respawnent.angles);
  }

  waittillframeend;
  cleanupbodydrop(self, team);
}

playerrespawn(origin, angles) {
  playerfakespectate(0);
  self.forcespawnorigin = origin;
  self.forcespawnangles = angles;
  self.isrespawn = 1;
  self.alreadyaddedtoalivecount = 1;
  scripts\mp\playerlogic::spawnplayer(0, 0);
}

useentpickupbody(_id_F99D56BCB582A8BA, team) {
  self endon("respawnComplete");
  self endon("timeout");
  _id_F99D56BCB582A8BA endon("disconnect");

  for(;;) {
    self waittill("trigger", player);

    if(isDefined(_id_F99D56BCB582A8BA.body))
      _id_F99D56BCB582A8BA.body delete();

    if(player.team != team) {
      continue;
    }
    useenthide(team);
    player playerpickupbody(self, team);
    useentshow(team);
  }
}

useenthide(team) {
  self makeunusable();
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
}

useentshow(team) {
  self makeusable();
  scripts\mp\objidpoolmanager::objective_teammask_single(self.objectiveiconid, team);
  objective_setplayintro(self.objectiveiconid, 0);
}

playerpickupbody(_id_DBCE45A33308630D, team) {
  self endon("droppedBody");
  holdingbodyhud = scripts\mp\hud_util::createfontstring("default", 1.5);
  holdingbodyhud scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 120);
  holdingbodyhud.label = &"MP/BR_RESPAWN_BODY";
  self.holdingbodyhud = holdingbodyhud;

  if(isDefined(_id_DBCE45A33308630D.ambulance)) {
    _id_DBCE45A33308630D.ambulance ambulancedisabletoteam(team);
    _id_DBCE45A33308630D.ambulance = undefined;
  }

  _id_DBCE45A33308630D scriptmodelplayanim("sdr_cp_hostage_walk_hostage");
  _id_DBCE45A33308630D linkTo(self, "j_clavicle_le", (0, 0, 0), (0, 0, 0));
  _id_DBCE45A33308630D thread useentdropbodyonplayerdone(self, holdingbodyhud, team);
  _id_DBCE45A33308630D thread useentdropbodywhencomplete(self, holdingbodyhud, team);
  _id_DBCE45A33308630D thread useentmonitorambulances(team);
  self allowads(0);
  self allowcrouch(0);
  self allowprone(0);
  self allowjump(0);
  playersetcarryteammates(1);
  showallambulancesforteam(team);

  foreach(player in level.teamdata[team]["players"]) {
    if(isDefined(player)) {
      player notify("defibrillator_done");
      player thread scripts\mp\hud_message::showsplash("br_respawn_start");
    }
  }

  while(!self stancebuttonPressed() || !self isonground())
    waitframe();

  dropbody(_id_DBCE45A33308630D, self, holdingbodyhud, team);
}

playersetcarryteammates(carrying) {
  self.carrying = carrying;
  _id_6D5ED003AF1F9612 = level.teamdata[self.team]["players"];

  foreach(player in _id_6D5ED003AF1F9612) {
    if(isDefined(player.respawnent)) {
      if(!carrying) {
        player.respawnent enableplayeruse(self);
        continue;
      }

      player.respawnent disableplayeruse(self);
    }
  }
}

useentdropbodyonplayerdone(_id_11F6008C3B0C47BF, holdingbodyhud, team) {
  self endon("droppedBody");
  _id_11F6008C3B0C47BF scripts\engine\utility::waittill_any_3("disconnect", "death", "last_stand_start");
  dropbody(self, _id_11F6008C3B0C47BF, holdingbodyhud, team);
}

useentdropbodywhencomplete(_id_11F6008C3B0C47BF, holdingbodyhud, team) {
  self endon("droppedBody");
  scripts\engine\utility::waittill_any_2("timeout", "respawnComplete");
  dropbody(self, _id_11F6008C3B0C47BF, holdingbodyhud, team);
}

dropbody(_id_DBCE45A33308630D, _id_11F6008C3B0C47BF, holdingbodyhud, team) {
  if(isDefined(_id_11F6008C3B0C47BF)) {
    _id_11F6008C3B0C47BF allowads(1);
    _id_11F6008C3B0C47BF allowcrouch(1);
    _id_11F6008C3B0C47BF allowprone(1);
    _id_11F6008C3B0C47BF allowjump(1);
    _id_11F6008C3B0C47BF playersetcarryteammates(0);
  }

  if(isDefined(holdingbodyhud))
    holdingbodyhud destroy();

  if(_id_DBCE45A33308630D islinked())
    _id_DBCE45A33308630D unlink();

  origin = undefined;

  if(isDefined(_id_11F6008C3B0C47BF)) {
    _id_DBCE45A33308630D.angles = _id_11F6008C3B0C47BF.angles;
    origin = _id_11F6008C3B0C47BF.origin;
    _id_DBCE45A33308630D.origin = origin + (0, 0, 40);
  } else {
    origin = _id_DBCE45A33308630D.origin;
    _id_DBCE45A33308630D.origin = origin + (0, 0, 40);
  }

  _id_DBCE45A33308630D.drophud.alpha = 0.0;
  _id_DBCE45A33308630D useentsetupcloseambulance(team);
  _id_DBCE45A33308630D scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  _id_DBCE45A33308630D scriptmodelpauseanim(1);
  _id_DBCE45A33308630D.origin = origin + (0, 0, 1);
  _id_DBCE45A33308630D notify("droppedBody");
}

useentsetupcloseambulance(team) {
  ambulance = getcloseambulance(self.origin);

  if(isDefined(ambulance)) {
    self.ambulance = ambulance;
    ambulance ambulanceenabletoteam(team);
  }
}

createpickupuseent(origin, team) {
  _id_DBCE45A33308630D = spawn("script_model", origin + (0, 0, 1));
  _id_DBCE45A33308630D setModel("fullbody_usmc_ar_scriptmover");
  _id_DBCE45A33308630D scriptmodelplayanim("sdr_cp_hostage_dropoff_ground_idle_pilot");
  _id_DBCE45A33308630D scriptmodelpauseanim(1);
  _id_DBCE45A33308630D makeusable();
  _id_DBCE45A33308630D setCursorHint("HINT_NOICON");
  _id_DBCE45A33308630D setuseholdduration("duration_medium");
  _id_DBCE45A33308630D setuserange(120);
  _id_DBCE45A33308630D setHintString(&"MP/BR_PICKUP_PLAYER");
  _id_DBCE45A33308630D setusepriority(0);
  _id_DBCE45A33308630D hudoutlineenable("outlinefill_nodepth_red");

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    if(player.team == team) {
      _id_DBCE45A33308630D hudoutlineenableforclient(player, "outlinefill_nodepth_red");

      if(!istrue(player.carrying))
        _id_DBCE45A33308630D enableplayeruse(player);

      continue;
    }

    _id_DBCE45A33308630D disableplayeruse(player);
    _id_DBCE45A33308630D hudoutlinedisableforclient(player);
  }

  objectiveiconid = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  _id_DBCE45A33308630D.objectiveiconid = objectiveiconid;

  if(objectiveiconid != -1) {
    scripts\mp\objidpoolmanager::objective_add_objective(objectiveiconid, "invisible", (0, 0, 0));
    scripts\mp\objidpoolmanager::update_objective_onentity(objectiveiconid, _id_DBCE45A33308630D);
    scripts\mp\objidpoolmanager::update_objective_setzoffset(objectiveiconid, 40);
    scripts\mp\objidpoolmanager::update_objective_state(objectiveiconid, "current");
    scripts\mp\objidpoolmanager::update_objective_icon(objectiveiconid, "passive_icon_health_on_kill");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objectiveiconid, 1);
    scripts\mp\objidpoolmanager::objective_teammask_single(objectiveiconid, team);
  }

  return _id_DBCE45A33308630D;
}

createplayerdeadcountdownhud(team, _id_6958D396E4AD3B95) {
  timerhud = scripts\mp\hud_util::createservertimer("objective", 1.4, team);
  timerhud.label = &"MP/BR_RESPAWN_DEATH_COUNTDOWN";
  timerhud settimer(_id_6958D396E4AD3B95);
  timerhud.starttime = gettime();
  thread countdownhudpulse(timerhud);
  return timerhud;
}

countdownhudpulse(timerhud) {
  _id_CC2C2F3EAC3C7BD2 = 0.5;
  _id_5F2809F4E8852C13 = 2;
  _id_B96028986997E29C = timerhud.fontscale;
  timerhud changefontscaleovertime(_id_CC2C2F3EAC3C7BD2);
  timerhud.fontscale = _id_5F2809F4E8852C13;
  wait(_id_CC2C2F3EAC3C7BD2);

  if(isDefined(timerhud)) {
    timerhud changefontscaleovertime(_id_CC2C2F3EAC3C7BD2);
    timerhud.fontscale = _id_B96028986997E29C;
  }
}

cleanupbodydrop(_id_DBCE45A33308630D, team) {
  if(isDefined(_id_DBCE45A33308630D.timerhud))
    _id_DBCE45A33308630D.timerhud destroy();

  updatecountdownhudlist();

  if(isDefined(_id_DBCE45A33308630D.drophud))
    _id_DBCE45A33308630D.drophud destroy();

  if(isDefined(_id_DBCE45A33308630D.ambulance)) {
    _id_DBCE45A33308630D.ambulance ambulancedisabletoteam(team);
    _id_DBCE45A33308630D.ambulance = undefined;
  }

  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.objectiveiconid);
  scripts\mp\objidpoolmanager::returnobjectiveid(self.objectiveiconid);
  _id_DBCE45A33308630D delete();
  hideallambulancesforteam(team, 1);
}

useentmonitorambulances(team) {
  self endon("droppedBody");
  _id_A9B8B5AB4910CB48 = 0;

  for(;;) {
    _id_F2D5D211DF31ECC9 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_respawnambulances.size; _id_AC0E594AC96AA3A8++) {
      ambulance = level.br_respawnambulances[_id_AC0E594AC96AA3A8];

      if(!isDefined(ambulance) || istrue(ambulance.disabled)) {
        continue;
      }
      org = ambulance.origin;

      foreach(player in level.teamdata[team]["players"]) {
        if(!isDefined(player)) {
          continue;
        }
        distsq = distancesquared(org, player.origin);

        if(distsq < 65536) {
          _id_F2D5D211DF31ECC9 = 1;
          break;
        }
      }

      if(_id_F2D5D211DF31ECC9) {
        break;
      }
    }

    if(!_id_A9B8B5AB4910CB48 && _id_F2D5D211DF31ECC9)
      self.drophud.alpha = 1.0;
    else if(_id_A9B8B5AB4910CB48 && !_id_F2D5D211DF31ECC9)
      self.drophud.alpha = 0.0;

    _id_A9B8B5AB4910CB48 = _id_F2D5D211DF31ECC9;
    wait 0.1;
  }
}

createdropplayerhud(team) {
  fontscale = 1.3;
  _id_372B658AEA9D2487 = newteamhudelem(team);
  _id_372B658AEA9D2487.elemtype = "font";
  _id_372B658AEA9D2487.font = "default";
  _id_372B658AEA9D2487.fontscale = fontscale;
  _id_372B658AEA9D2487.basefontscale = fontscale;
  _id_372B658AEA9D2487.x = 0;
  _id_372B658AEA9D2487.y = 0;
  _id_372B658AEA9D2487.width = 0;
  _id_372B658AEA9D2487.height = int(level.fontheight * fontscale);
  _id_372B658AEA9D2487.xoffset = 0;
  _id_372B658AEA9D2487.yoffset = 0;
  _id_372B658AEA9D2487.children = [];
  _id_372B658AEA9D2487 scripts\mp\hud_util::setparent(level.uiparent);
  _id_372B658AEA9D2487.hidden = 0;
  _id_372B658AEA9D2487.alpha = 0;
  _id_372B658AEA9D2487 scripts\mp\hud_util::setpoint("CENTER", "CENTER", 0, 100);
  _id_372B658AEA9D2487.label = &"MP/BR_RESPAWN_DROP_BODY";
  return _id_372B658AEA9D2487;
}

getrespawnableplayers(team) {
  _id_6D5ED003AF1F9612 = level.teamdata[team]["players"];
  _id_203492E1624302BF = [];

  foreach(player in _id_6D5ED003AF1F9612) {
    if(isDefined(player.respawnent))
      _id_203492E1624302BF[_id_203492E1624302BF.size] = player;
  }

  return _id_203492E1624302BF;
}

getallrespawnableplayers() {
  _id_203492E1624302BF = [];

  foreach(player in level.players) {
    if(isDefined(player.respawnent))
      _id_203492E1624302BF[_id_203492E1624302BF.size] = player;
  }

  return _id_203492E1624302BF;
}

getcloseambulance(point) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.br_respawnambulances.size; _id_AC0E594AC96AA3A8++) {
    ambulance = level.br_respawnambulances[_id_AC0E594AC96AA3A8];

    if(!isDefined(ambulance) || istrue(ambulance.disabled)) {
      continue;
    }
    distsq = distancesquared(ambulance.origin, point);

    if(distsq < 65536)
      return ambulance;
  }
}

ambulancedefibrillator(player) {
  if(player hasweapon("iw8_defibrillator_mp")) {
    player switchtoweapon("iw8_defibrillator_mp");
    return;
  }

  thread ambulancedosiren();
  player.usedambulance = self;
  self.defibrillator hide();
  _id_B26608B570FC6AAC = player playergivedefibrillator(self);

  if(isDefined(player)) {
    player notify("defibrillator_done");
    player.usedambulance = undefined;
  }

  self.defibrillator show();

  if(isDefined(_id_B26608B570FC6AAC)) {
    _id_B26608B570FC6AAC.respawnent notify("respawnComplete", 1);
    ambulancedelayreuse();
  }
}

ambulancedelayreuse() {
  self endon("disabled");
  ambulancemakeunsabletoall();
  wait 30;
  ambulancemakeusable();
}

ambulancedosiren() {
  self notify("ambulanceDoSiren");
  self endon("ambulanceDoSiren");
  self playLoopSound("siren_ambulance_lp");
  wait 30;
  self stoploopsound();
}

playergivedefibrillator(ambulance) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");
  _id_8AACA974612AB844 = getrespawnableplayers(self.team);

  if(_id_8AACA974612AB844.size == 0)
    self iprintlnbold("No dead teammates");
  else {
    self.lastweaponrespawn = self getcurrentprimaryweapon();
    _id_05B1C712938E3ABF = makeweapon("iw8_defibrillator_mp");
    self giveweapon(_id_05B1C712938E3ABF);
    self switchtoweapon(_id_05B1C712938E3ABF);
    thread playermonitorweaponchange(_id_05B1C712938E3ABF);
    thread playertakeawaydefibrillator(_id_05B1C712938E3ABF);
    thread playermonitordistancefromambulance(ambulance);
  }
}

playerdodefibrillator(_id_7A30DF5C798AB7EE) {
  for(;;) {
    self waittill("melee_fired", objweapon);
    _id_FFC368C1D2A95B7B = 0;

    if(objweapon.basename != "iw8_defibrillator_mp") {
      if(!self hasweapon("iw8_defibrillator_mp"))
        return;
    } else {
      _id_C2F4EC03C9EC610E = self getEye();
      dirfacing = anglesToForward(self getplayerangles());
      _id_8AACA974612AB844 = getrespawnableplayers(self.team);
      _id_DE0A18979FF9A55E = 0;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_8AACA974612AB844.size; _id_AC0E594AC96AA3A8++) {
        _id_F0EA4030349A33D5 = _id_8AACA974612AB844[_id_AC0E594AC96AA3A8];

        if(!isDefined(_id_F0EA4030349A33D5) || !isDefined(_id_F0EA4030349A33D5.respawnent)) {
          continue;
        }
        _id_DE0A18979FF9A55E = 1;
        origin = _id_F0EA4030349A33D5.respawnent.origin + (0, 0, 40);
        _id_16CBDE366E22C3AD = vectorNormalize(origin - _id_C2F4EC03C9EC610E);
        dot = vectordot(_id_16CBDE366E22C3AD, dirfacing);

        if(dot < 0.5) {
          continue;
        }
        distsq = distancesquared(self.origin, origin);

        if(distsq > 10000) {
          continue;
        }
        return _id_F0EA4030349A33D5;
      }

      if(!_id_DE0A18979FF9A55E && istrue(_id_7A30DF5C798AB7EE)) {
        self iprintlnbold("No teammates to revive");
        return;
      }
    }
  }
}

playermonitorweaponchange(_id_05B1C712938E3ABF) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");

  for(;;) {
    self waittill("weapon_change", _id_DD515FCF025B2E79);

    if(!issameweapon(_id_05B1C712938E3ABF, _id_DD515FCF025B2E79)) {
      self notify("defibrillator_done");
      return;
    }
  }
}

playertakeawaydefibrillator(_id_05B1C712938E3ABF) {
  scripts\engine\utility::waittill_any_3("death", "disconnect", "last_stand_start", "defibrillator_done");

  if(isDefined(self) && self hasweapon(_id_05B1C712938E3ABF)) {
    self takeweapon(_id_05B1C712938E3ABF);
    self switchtoweapon(self.lastweaponrespawn);
  }
}

playermonitordistancefromambulance(ambulance) {
  self endon("death");
  self endon("disconnect");
  self endon("last_stand_start");
  self endon("defibrillator_done");

  for(;;) {
    distsq = distancesquared(ambulance.origin, self.origin);

    if(distsq > 65536) {
      self notify("defibrillator_done");
      return;
    }

    wait 0.1;
  }
}

giveweaponpickup(weaponname) {
  self endon("death");
  self endon("disconnect");

  if(!istrue(level.br_respawn_enabled)) {
    return;
  }
  if(weaponname != "iw8_defibrillator_mp") {
    return;
  }
  _id_F0EA4030349A33D5 = playerdoportabledefibrillator();

  if(isDefined(_id_F0EA4030349A33D5)) {
    if(isDefined(_id_F0EA4030349A33D5.body))
      _id_F0EA4030349A33D5.body delete();

    _id_F0EA4030349A33D5.respawnent notify("respawnComplete", 1);
  }

  _id_05B1C712938E3ABF = makeweapon("iw8_defibrillator_mp");
  playertrytakedefibrillator(_id_05B1C712938E3ABF);
}

playerdoportabledefibrillator() {
  self endon("portable_defibrillator_done");
  return playerdodefibrillator();
}