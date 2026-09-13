/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\gameobjects.gsc
***********************************************/

_id_E39F8BC855EE1D4E() {
  level.numgametypereservedobjectives = 0;
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  level thread getleveltriggers();
  _id_8729FEF0FDE291B4();
}

onplayerspawned() {
  if(isbot(self))
    level.botsenabled = 1;

  _id_15B82FBCA96A0FEC = !istrue(level.disableinitplayergameobjects);

  if(getdvarint("dvar_01E97927453AD138", 0) == 1)
    _id_15B82FBCA96A0FEC = 1;

  if(_id_15B82FBCA96A0FEC) {
    if(isDefined(self.gameobject_fauxspawn))
      self.gameobject_fauxspawn = undefined;
    else
      init_player_gameobjects();
  }
}

init_player_gameobjects() {
  thread ondeathordisconnect();
  self.touchtriggers = [];
  self.carryobject = undefined;
  self.canpickupobject = 1;
  self.initialized_gameobject_vars = 1;
}

ondeathordisconnect() {
  self notify("gameobject_watch_drop");
  level endon("game_ended");
  self endon("drop_called");
  self endon("gameobject_watch_drop");
  self waittill("death_or_disconnect");
  _ondeathordisconnectinternal();
}

_ondeathordisconnectinternal() {
  if(isDefined(self.carryobject))
    self.carryobject thread setdropped();
}

onjuggernaut() {
  waittillframeend;

  if(isDefined(self.carryobject)) {
    self._id_C7945BE244726AD0 = gettime();
    self.carryobject thread setdropped();
    self switchtoweapon(scripts\cp\killstreaks\juggernaut_cp::_id_A869748B27159997());
  }
}

createtrackedobject(player, offset) {
  trackedobject = spawn("script_model", self.origin);
  trackedobject setModel("tag_origin");
  carryobject = spawnStruct();
  carryobject.type = "carryObject";
  carryobject.carrier = player;
  carryobject.curorigin = player.origin;
  carryobject.entnum = trackedobject getentitynumber();
  carryobject.ownerteam = player.team;
  carryobject.offset3d = offset;
  carryobject.triggertype = "none";
  carryobject.compassicons = [];
  carryobject.objidpingfriendly = 0;
  carryobject.objidpingenemy = 0;
  carryobject.carriervisible = 0;
  carryobject.visibleteam = "none";
  carryobject requestid(1, 1);
  carryobject thread updatecarryobjectorigin();
  carryobject thread deletetrackedobjectoncarrierdisconnect();
  return carryobject;
}

deletetrackedobjectoncarrierdisconnect() {
  self endon("gameobject_deleted");
  level endon("game_ended");
  self.carrier waittill("disconnect");
  deletetrackedobject();
}

deletetrackedobject() {
  if(!isDefined(self) || !isDefined(self.type) || self.type != "carryObject") {
    return;
  }
  carryobject = self;
  carryobject.type = undefined;
  carryobject.carrier = undefined;
  carryobject.curorigin = undefined;
  carryobject.entnum = undefined;
  carryobject.ownerteam = undefined;
  carryobject.compassicons = undefined;
  carryobject.objidpingfriendly = undefined;
  carryobject.objidpingenemy = undefined;
  carryobject.carriervisible = undefined;
  carryobject.visibleteam = undefined;
  releaseid();
  self notify("gameobject_deleted");
}

_id_FD1B4A7D915FC9A6(origin, offset, showonminimap, _id_182036C56E421297) {
  _id_D409B732B55F7696 = spawnStruct();
  _id_D409B732B55F7696.type = "codcasterWaypoint";
  _id_D409B732B55F7696.curorigin = origin;
  _id_D409B732B55F7696.offset3d = offset;
  _id_D409B732B55F7696.ownerteam = "neutral";
  _id_D409B732B55F7696.compassicons = [];
  _id_D409B732B55F7696.visibleteam = "codcaster";
  _id_D409B732B55F7696 requestid(showonminimap, _id_182036C56E421297, undefined, 0, 0);
  return _id_D409B732B55F7696;
}

_id_E3C8FB6519162627() {
  if(!isDefined(self) || !isDefined(self.type) || self.type != "codcasterWaypoint") {
    return;
  }
  _id_D409B732B55F7696 = self;
  _id_D409B732B55F7696.type = undefined;
  _id_D409B732B55F7696.curorigin = undefined;
  _id_D409B732B55F7696.offset3d = undefined;
  _id_D409B732B55F7696.ownerteam = undefined;
  _id_D409B732B55F7696.compassicons = undefined;
  _id_D409B732B55F7696.visibleteam = undefined;
  releaseid();
}

createcarryobject(ownerteam, trigger, visuals, offset, useifproximity, _id_08B9949739F4E0F6) {
  carryobject = spawnStruct();
  carryobject.type = "carryObject";
  carryobject.curorigin = trigger.origin;
  carryobject.ownerteam = ownerteam;
  carryobject.useifproximity = useifproximity;
  carryobject.entnum = trigger getentitynumber();

  if(issubstr(trigger.classname, "use") || istrue(trigger.usetype))
    carryobject.triggertype = "use";
  else
    carryobject.triggertype = "proximity";

  trigger.gameobject = carryobject;
  trigger.baseorigin = trigger.origin;
  carryobject.trigger = trigger;

  if(!isDefined(trigger.linktoenabledflag)) {
    trigger.linktoenabledflag = 1;
    trigger enablelinkTo();
  }

  carryobject.useweapon = undefined;

  if(!isDefined(offset))
    offset = (0, 0, 0);

  carryobject.offset3d = offset;

  for(index = 0; index < visuals.size; index++) {
    visuals[index].baseorigin = visuals[index].origin;
    visuals[index].baseangles = visuals[index].angles;
  }

  carryobject.visuals = visuals;
  carryobject.compassicons = [];
  carryobject.objidpingfriendly = 0;
  carryobject.objidpingenemy = 0;

  if(!isDefined(_id_08B9949739F4E0F6))
    carryobject requestid(1, 1);

  carryobject.carrier = undefined;
  carryobject.isresetting = 0;
  carryobject.interactteam = "none";
  carryobject.allowweapons = 0;
  carryobject.carriervisible = 0;
  carryobject.visibleteam = "none";
  carryobject.carryicon = undefined;
  carryobject.ondrop = undefined;
  carryobject.onpickup = undefined;
  carryobject.onreset = undefined;
  carryobject.pickupchecks = [];

  if(carryobject.triggertype == "use")
    carryobject thread carryobjectusethink();
  else {
    carryobject.curprogress = 0;
    carryobject.teamprogress = [];
    carryobject.teamprogress["none"] = 0;
    carryobject.usetime = 0;
    carryobject.userate = 0;
    carryobject.useratemultiplier = 1.0;
    carryobject.mustmaintainclaim = 0;
    carryobject.cancontestclaim = 0;
    carryobject.teamusetimes = [];
    carryobject.teamusetexts = [];
    carryobject.numtouching["neutral"] = 0;
    carryobject.touchlist["neutral"] = [];
    carryobject.numtouching["none"] = 0;
    carryobject.touchlist["none"] = [];

    foreach(name in level.teamnamelist) {
      carryobject.teamprogress[name] = 0;
      carryobject.numtouching[name] = 0;
      carryobject.touchlist[name] = [];
    }

    carryobject.claimteam = "none";
    carryobject.claimplayer = undefined;
    carryobject.lastclaimteam = "none";
    carryobject.lastclaimtime = 0;
    carryobject thread carryobjectproxthink();
  }

  carryobject thread updatecarryobjectorigin();
  return carryobject;
}

isremotekillstreakweapon(weapon) {
  _id_608BEF26DD02E2C7 = 0;

  switch (weapon) {
    case "ks_remote_bomber_mp":
    case "ks_remote_gunship_mp":
    case "ks_remote_nuke_mp":
    case "ks_remote_hack_mp":
    case "ks_assault_drone_mp":
    case "ks_remote_drone_mp":
    case "ks_remote_device_mp":
    case "ks_remote_map_mp":
      _id_608BEF26DD02E2C7 = 1;
      break;
  }

  return _id_608BEF26DD02E2C7;
}

registercarryobjectpickupcheck(_id_C6961A94F7638AEE) {
  self.pickupchecks[self.pickupchecks.size] = _id_C6961A94F7638AEE;
}

checkcarryobjectpickupcheck(player) {
  passed = 1;

  foreach(_id_DAC2FE2E7CCCDA53 in self.pickupchecks)
  passed = passed &[[_id_DAC2FE2E7CCCDA53]](player);

  if(isDefined(self._id_EA5E94E328A4B626) && isDefined(self._id_EA5E94E328A4B626.pickupchecks)) {
    foreach(_id_DAC2FE2E7CCCDA53 in self._id_EA5E94E328A4B626.pickupchecks)
    passed = passed &[[_id_DAC2FE2E7CCCDA53]](player);
  }

  return passed;
}

deletecarryobject() {
  if(self.type != "carryObject") {
    return;
  }
  carryobject = self;
  carryobject.type = undefined;
  carryobject.curorigin = undefined;
  carryobject.ownerteam = undefined;
  carryobject.entnum = undefined;
  carryobject.triggertype = undefined;

  if(isDefined(carryobject.trigger)) {
    carryobject.trigger unlink();
    carryobject.trigger = undefined;
  }

  carryobject.useweapon = undefined;
  carryobject.offset3d = undefined;

  foreach(visual in carryobject.visuals)
  visual delete();

  carryobject.visuals = undefined;
  carryobject.compassicons = undefined;
  carryobject.objidpingfriendly = undefined;
  carryobject.objidpingenemy = undefined;
  carryobject.objpingdelay = undefined;
  releaseid();
  carryobject.carrier = undefined;
  carryobject.isresetting = undefined;
  carryobject.interactteam = undefined;
  carryobject.allowweapons = undefined;
  carryobject.keepprogress = undefined;
  carryobject.carriervisible = undefined;
  carryobject.visibleteam = undefined;
  carryobject.carryicon = undefined;
  carryobject.ondrop = undefined;
  carryobject.onpickup = undefined;
  carryobject.onreset = undefined;
  carryobject.curprogress = undefined;
  carryobject.usetime = undefined;
  carryobject.userate = undefined;
  carryobject.useratemultiplier = 1.0;
  carryobject.mustmaintainclaim = undefined;
  carryobject.cancontestclaim = undefined;
  carryobject.teamusetimes = undefined;
  carryobject.teamusetexts = undefined;
  carryobject.numtouching = undefined;
  carryobject.touchlist = undefined;
  carryobject.claimteam = undefined;
  carryobject.claimplayer = undefined;
  carryobject.lastclaimteam = undefined;
  carryobject.lastclaimtime = undefined;
  carryobject notify("death");
  carryobject notify("deleted");
}

carryobjectusethink() {
  level endon("game_ended");

  for(;;) {
    self.trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(player ismeleeing()) {
      continue;
    }
    currentweapon = player getcurrentweapon();

    if(isremotekillstreakweapon(currentweapon.basename)) {
      continue;
    }
    if(player scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress()) {
      _id_C978DE6B5D36A7E0 = player scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon();

      if(isremotekillstreakweapon(_id_C978DE6B5D36A7E0.basename))
        continue;
    }

    if(istrue(player.inlaststand)) {
      continue;
    }
    if(self.isresetting) {
      continue;
    }
    if(!scripts\cp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(!caninteractwith(player.pers["team"], player)) {
      continue;
    }
    if(!player.canpickupobject) {
      continue;
    }
    if(isDefined(player.nopickuptime) && player.nopickuptime > gettime()) {
      continue;
    }
    if(!isDefined(player.initialized_gameobject_vars)) {
      continue;
    }
    if(!isflagcarrymode() && player _id_74502A9E0EF1F19C::grenadeinpullback()) {
      offhandweapon = player getheldoffhand();

      if(!scripts\cp\utility::isgesture(offhandweapon))
        continue;
    }

    if(isDefined(self.carrier)) {
      continue;
    }
    if(player scripts\cp\utility\player::isusingremote()) {
      continue;
    }
    if(!proxtriggerlos(player)) {
      continue;
    }
    if(istrue(level._id_9A8E3EB5BC672807) && !player isonground()) {
      continue;
    }
    setpickedup(player);
  }
}

carryobjectproxthink() {
  if(scripts\cp\utility::getgametype() == "ball" || scripts\cp\utility::getgametype() == "tdef" || istrue(self.useifproximity))
    thread carryobjectusethink();
  else
    thread carryobjectproxthinkdelayed();
}

carryobjectproxthinkdelayed() {
  level endon("game_ended");

  if(isDefined(self.trigger))
    self.trigger endon("move_gameobject");

  thread proxtriggerthink();

  for(;;) {
    if(self.usetime && self.teamprogress[self.claimteam] >= self.usetime) {
      self.curprogress = 0.0;
      self.teamprogress[self.claimteam] = self.curprogress;
      _id_58E8D1412BC688CD = getearliestclaimplayer();
      setclaimteam("none");
      self.claimplayer = undefined;

      if(isDefined(self.onenduse))
        self[[self.onenduse]](getlastclaimteam(), _id_58E8D1412BC688CD, isDefined(_id_58E8D1412BC688CD));

      if(isDefined(_id_58E8D1412BC688CD))
        setpickedup(_id_58E8D1412BC688CD);
    }

    if(self.claimteam != "none") {
      if(self.usetime) {
        if(!self.numtouching[self.claimteam]) {
          setclaimteam("none");
          self.claimplayer = undefined;

          if(isDefined(self.onenduse))
            self[[self.onenduse]](getlastclaimteam(), self.claimplayer, 0);
        } else {
          self.curprogress = self.curprogress + level.frameduration * self.userate;
          self.teamprogress[self.claimteam] = self.curprogress;
          _id_B0C33D224B825287 = scripts\cp\utility::getenemyteams(self.claimteam);

          foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
            if(self.ownerteam != _id_F90358454413407F)
              self.teamprogress[_id_F90358454413407F] = 0;
          }

          if(isDefined(self.onuseupdate))
            self[[self.onuseupdate]](getclaimteam(), self.curprogress / self.usetime, level.frameduration * self.userate / self.usetime, self.claimplayer);
        }
      } else {
        if(scripts\cp\utility\player::isreallyalive(self.claimplayer))
          setpickedup(self.claimplayer);

        setclaimteam("none");
        self.claimplayer = undefined;
      }
    }

    waitframe();
    scripts\cp\cp_hostmigration::waittillhostmigrationdone();
  }
}

pickupobjectdelay(object) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self.canpickupobject = 0;

  if(isDefined(object.ballindex))
    _id_EA6796B0AB236D3B = 1024;
  else
    _id_EA6796B0AB236D3B = 4096;

  for(;;) {
    if(distancesquared(self.origin, object.trigger.origin) > _id_EA6796B0AB236D3B) {
      break;
    }

    wait 0.2;
  }

  self.canpickupobject = 1;
}

setpickedup(player, _id_5760E0F038D1BAA3, defused) {
  if(isai(player) && isDefined(player.owner)) {
    return;
  }
  if(isDefined(player.carryobject) || isDefined(self.carryweapon) && !player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon") || !checkcarryobjectpickupcheck(player)) {
    if(isDefined(self.onpickupfailed))
      self[[self.onpickupfailed]](player);

    return;
  }

  player giveobject(self);
  setcarrier(player);

  if(isDefined(self.trigger getlinkedparent())) {
    for(index = 0; index < self.visuals.size; index++)
      self.visuals[index] unlink();

    self.trigger unlink();
  }

  for(index = 0; index < self.visuals.size; index++)
    self.visuals[index] hide();

  self.trigger.origin = self.trigger.origin + (0, 0, 10000);
  self.trigger scripts\cp\cp_movers::stop_handling_moving_platforms();
  self notify("pickup_object");

  if(isDefined(self.onpickup))
    self[[self.onpickup]](player, _id_5760E0F038D1BAA3, defused);

  if(isDefined(self._id_EA5E94E328A4B626) && getdvarint("dvar_85B8D86D0EA96EE1", 1))
    _id_3961F0EA9A43DB11(player, self._id_EA5E94E328A4B626);

  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9._id_22282E7D48CA3400 = player;
  _id_7E2C53B0BCF117D9._id_239B4B5FA4BCF6C6 = self;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_objective_state_changed", _id_7E2C53B0BCF117D9);
}

_id_316D9DA870E12A03(ignoreents, trigger, _id_9EAE3C6DE4C6DE86, _id_20F30C47C5442258, _id_D81857413879B334, _id_BE2108E27AC7A4EF, _id_08E58B28EF44CBE0) {
  _id_EA5E94E328A4B626 = spawnStruct();

  if(isDefined(ignoreents))
    _id_EA5E94E328A4B626.ignoreents = ignoreents;

  if(isDefined(trigger))
    _id_EA5E94E328A4B626.trigger = trigger;

  if(isDefined(_id_9EAE3C6DE4C6DE86))
    _id_EA5E94E328A4B626._id_9EAE3C6DE4C6DE86 = _id_9EAE3C6DE4C6DE86;

  if(isDefined(_id_20F30C47C5442258))
    _id_EA5E94E328A4B626._id_20F30C47C5442258 = _id_20F30C47C5442258;

  if(isDefined(_id_D81857413879B334))
    _id_EA5E94E328A4B626._id_5338AB800FA9B63A = _id_D81857413879B334;

  if(isDefined(_id_BE2108E27AC7A4EF))
    _id_EA5E94E328A4B626._id_BE2108E27AC7A4EF = _id_BE2108E27AC7A4EF;

  if(!istrue(_id_08E58B28EF44CBE0))
    _id_EA5E94E328A4B626.pickupchecks = [::_id_FFAE0B2BDEB1BB92];

  self._id_EA5E94E328A4B626 = _id_EA5E94E328A4B626;
}

_id_3961F0EA9A43DB11(player, _id_EA5E94E328A4B626) {
  if(isbot(player)) {
    return;
  }
  _id_3A3C81E298FFB596(player, 0);
  thread _id_3FDDADFD0F60D749(player, _id_EA5E94E328A4B626);
  thread _id_F4B0940FEDB9A105(player, _id_EA5E94E328A4B626);
  thread _id_5D1E933DF9172036(player);
  thread _id_A4729874A8DAF9AC(player);
}

_id_A4729874A8DAF9AC(player) {
  self endon("manual_drop_cleanup");
  self endon("dropped");
  self endon("death");
  player endon("death_or_disconnect");
  player endon("manual_drop");
  _id_A97560119766513F = player usinggamepad();

  for(;;) {
    _id_7D9937FD539F02D0 = player usinggamepad();

    if(_id_7D9937FD539F02D0 != _id_A97560119766513F) {
      _id_A97560119766513F = _id_7D9937FD539F02D0;

      if(_id_7D9937FD539F02D0) {
        player notifyonplayercommandremove("manual_drop", "+armor");
        player notifyonplayercommand("manual_drop", "+actionslot 2");
      } else {
        player notifyonplayercommandremove("manual_drop", "+actionslot 2");
        player notifyonplayercommand("manual_drop", "+armor");
      }
    }

    waitframe();
  }
}

_id_5D1E933DF9172036(player) {
  scripts\engine\utility::waittill_any_3("manual_drop_cleanup", "dropped", "death");
  _id_3A3C81E298FFB596(player, 0);
  self._id_8A6E15B947EDAB69 = undefined;
}

_id_F4B0940FEDB9A105(player, _id_EA5E94E328A4B626) {
  self endon("manual_drop_cleanup");
  self endon("dropped");
  self endon("death");
  player endon("death_or_disconnect");
  player scripts\engine\utility::waittill_any_2("manual_drop", "force_manual_drop");
  thread _id_1069580BC0A235CB(player, _id_EA5E94E328A4B626);
}

_id_1069580BC0A235CB(player, _id_EA5E94E328A4B626) {
  level endon("game_ended");
  _id_47125DA1471F5C68 = isDefined(_id_EA5E94E328A4B626.trigger) && isDefined(_id_EA5E94E328A4B626._id_9EAE3C6DE4C6DE86);
  _id_4942BA4AA5D8EEA2 = undefined;

  if(_id_47125DA1471F5C68) {
    if(_id_EA5E94E328A4B626.trigger isusable())
      _id_EA5E94E328A4B626.trigger disableplayeruse(player);
    else
      player._id_1CECD248DD213DCE = 1;
  }

  thread setdropped(0, undefined, 1, 1);
  self notify("manual_drop_cleanup");
  self._id_0C3018ADEACDD826 = 1;

  if(isDefined(self.ondrop))
    self[[self.ondrop]](player);

  if(isDefined(_id_EA5E94E328A4B626._id_BE2108E27AC7A4EF) && isfunction(_id_EA5E94E328A4B626._id_BE2108E27AC7A4EF))
    self[[_id_EA5E94E328A4B626._id_BE2108E27AC7A4EF]](player);

  self._id_0C3018ADEACDD826 = undefined;

  if(_id_47125DA1471F5C68)
    thread _id_EDA9340B865645A3(player, _id_EA5E94E328A4B626);
}

_id_EDA9340B865645A3(player, _id_EA5E94E328A4B626) {
  level endon("game_ended");
  player endon("disconnect");
  self endon("gameobject_deleted");
  wait(_id_EA5E94E328A4B626._id_9EAE3C6DE4C6DE86);

  if(_id_EA5E94E328A4B626.trigger isusable())
    _id_EA5E94E328A4B626.trigger enableplayeruse(player);
  else
    player._id_1CECD248DD213DCE = undefined;
}

_id_3FDDADFD0F60D749(player, _id_EA5E94E328A4B626) {
  self endon("manual_drop_cleanup");
  self endon("dropped");
  self endon("death");
  player endon("death_or_disconnect");
  player endon("manual_drop");
  waitframe();
  _id_AF6BDFD2F2EE7BAD = !isDefined(_id_EA5E94E328A4B626._id_20F30C47C5442258) || !isDefined(_id_EA5E94E328A4B626._id_5338AB800FA9B63A);
  _id_C3248B9962FE3B35 = undefined;
  _id_20F30C47C5442258 = undefined;

  if(!_id_AF6BDFD2F2EE7BAD) {
    _id_C3248B9962FE3B35 = _id_EA5E94E328A4B626._id_5338AB800FA9B63A;
    _id_20F30C47C5442258 = _id_EA5E94E328A4B626._id_20F30C47C5442258;
  } else {}

  _id_2A707EFFF417BE6A = isbombmode();
  ignoreents = [];

  if(isDefined(_id_EA5E94E328A4B626.ignoreents))
    ignoreents = _id_EA5E94E328A4B626.ignoreents;

  ignoreents[ignoreents.size] = player;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1);

  for(;;) {
    if(scripts\cp_mp\utility\player_utility::_id_1E4A0E61FDB00E32(player)) {
      _id_3A3C81E298FFB596(player, 0);
      waitframe();
      continue;
    }

    if(istrue(player._id_C47EBA4C148AFA86)) {
      _id_3A3C81E298FFB596(player, 0);
      waitframe();
      continue;
    }

    if(_id_2A707EFFF417BE6A) {
      touching = 0;

      foreach(_id_EEF26A325310D3AF in level.objectives) {
        if(player istouching(_id_EEF26A325310D3AF.trigger)) {
          _id_3A3C81E298FFB596(player, 0);
          touching = 1;
          break;
        }
      }

      if(touching) {
        waitframe();
        continue;
      }
    }

    trace = undefined;
    height = player getEye()[2] - player.origin[2];
    end = player.origin + (0, 0, height / 2);

    if(!_id_AF6BDFD2F2EE7BAD && isDefined(_id_C3248B9962FE3B35) && isDefined(_id_20F30C47C5442258)) {
      forward = anglesToForward(player getplayerangles());
      x = forward[0] * cos(_id_C3248B9962FE3B35) - forward[1] * sin(_id_C3248B9962FE3B35);
      y = forward[0] * sin(_id_C3248B9962FE3B35) + forward[1] * cos(_id_C3248B9962FE3B35);
      _id_85CDA59B0F7F2FF2 = (x, y, 0);
      _id_23596220A6C8C97D = _id_20F30C47C5442258 * vectorNormalize(_id_85CDA59B0F7F2FF2);
      height = player getEye()[2] - player.origin[2];
      start = player.origin + (0, 0, height / 2);
      end = start + _id_23596220A6C8C97D;
      trace = scripts\engine\trace::sphere_trace(start, end, height / 2 - 1, ignoreents, contents);
    }

    if(_id_AF6BDFD2F2EE7BAD || !_id_AF6BDFD2F2EE7BAD && isDefined(trace) && trace["fraction"] == 1) {
      _id_9D0D801EAB27109A = scripts\engine\trace::ray_trace(end, end - (0, 0, height), ignoreents, contents);

      if(_id_BABD6A87808A6651(player))
        _id_3A3C81E298FFB596(player, 0);
      else if(isDefined(_id_9D0D801EAB27109A["position"]) && (scripts\cp\cp_outofbounds::ispointinoutofbounds(_id_9D0D801EAB27109A["position"]) || scripts\cp\cp_outofbounds::ispointinoutofbounds(_id_9D0D801EAB27109A["position"] + (0, 0, 12))))
        _id_3A3C81E298FFB596(player, 0);
      else if(vectordot(_id_9D0D801EAB27109A["normal"], (0, 0, 1)) > 0.8) {
        candrop = 1;

        if(isDefined(_id_9D0D801EAB27109A["entity"])) {
          if(_id_4FCFFD6D229B848A(_id_9D0D801EAB27109A["entity"]))
            candrop = 0;
        }

        _id_3A3C81E298FFB596(player, candrop, _id_9D0D801EAB27109A);
      } else
        _id_3A3C81E298FFB596(player, 0);
    } else
      _id_3A3C81E298FFB596(player, 0);

    if(!player isonground())
      _id_3A3C81E298FFB596(player, 0);

    waitframe();
  }
}

_id_4FCFFD6D229B848A(ent) {
  if(isDefined(ent.cover) && isDefined(ent.cover.equipmentref) && ent.cover.equipmentref == "equip_tac_cover")
    return 1;
  else if(isDefined(ent.equipmentref) && ent.equipmentref == "equip_tac_cover")
    return 1;

  return 0;
}

_id_3A3C81E298FFB596(player, enable, trace) {
  if(isDefined(trace) && enable)
    self._id_1972CCB1779C69D1 = trace;

  if(isDefined(self._id_8A6E15B947EDAB69) && self._id_8A6E15B947EDAB69 == enable) {
    return;
  }
  if(!isDefined(self._id_8A6E15B947EDAB69))
    self._id_8A6E15B947EDAB69 = enable;

  self._id_8A6E15B947EDAB69 = enable;
  _id_A97560119766513F = player usinggamepad();

  if(enable) {
    if(_id_A97560119766513F)
      player notifyonplayercommand("manual_drop", "+actionslot 2");
    else
      player notifyonplayercommand("manual_drop", "+armor");

    player setclientomnvar("ui_carry_object_can_drop", 1);
  } else {
    if(_id_A97560119766513F)
      player notifyonplayercommandremove("manual_drop", "+actionslot 2");
    else
      player notifyonplayercommandremove("manual_drop", "+armor");

    player setclientomnvar("ui_carry_object_can_drop", 0);
  }
}

_id_FFAE0B2BDEB1BB92(player) {
  return !istrue(player._id_1CECD248DD213DCE);
}

updatecurorigin() {
  self endon("gameobject_deleted");
  level endon("game_ended");

  if(isDefined(self.trigger))
    self.trigger endon("move_gameobject");

  if(scripts\cp\utility::getgametype() == "front")
    self.carrier endon("disconnect");

  for(;;) {
    if(isDefined(self.carrier)) {
      self.curorigin = self.carrier.origin + (0, 0, 75);
      self.curcarrierorigin = self.carrier.origin;
    } else {
      self.curorigin = self.trigger.origin;
      self.curcarrierorigin = undefined;
    }

    waitframe();
  }
}

updatecarryobjectorigin() {
  self endon("gameobject_deleted");
  level endon("game_ended");

  if(isDefined(self.trigger))
    self.trigger endon("move_gameobject");

  thread updatecurorigin();

  if(!isDefined(self.objpingdelay))
    self.objpingdelay = 4.0;

  for(;;) {
    if(self.objpingdelay == 0) {
      break;
    }

    if(isDefined(self.carrier)) {
      if(self.objidpingfriendly) {
        foreach(_id_FABF84450735DD93 in level.teamnamelist) {
          if((self.visibleteam == "friendly" || self.visibleteam == "any") && !isfriendlyteam(_id_FABF84450735DD93)) {
            if(self.showworldicon) {
              if(isDefined(self.pingobjidnum)) {
                scripts\mp\objidpoolmanager::update_objective_position(self.pingobjidnum, self.carrier.origin);

                if(istrue(self.pingplayers))
                  objective_setpings(self.pingobjidnum, 1);
                else
                  objective_setpingsforteam(self.pingobjidnum, _id_FABF84450735DD93);

                objective_ping(self.pingobjidnum);
                continue;
              }

              if(istrue(self.pingplayers))
                objective_setpings(self.objidnum, 1);
              else
                objective_setpingsforteam(self.objidnum, _id_FABF84450735DD93);

              objective_ping(self.objidnum);
            }
          }
        }
      }

      if(self.objidpingenemy) {
        foreach(_id_FABF84450735DD93 in level.teamnamelist) {
          if((self.visibleteam == "enemy" || self.visibleteam == "any") && isfriendlyteam(_id_FABF84450735DD93)) {
            if(self.showworldicon) {
              if(isDefined(self.pingobjidnum)) {
                scripts\mp\objidpoolmanager::update_objective_position(self.pingobjidnum, self.curorigin);

                if(istrue(self.pingplayers))
                  objective_setpings(self.pingobjidnum, 1);
                else
                  objective_setpingsforteam(self.pingobjidnum, _id_FABF84450735DD93);

                objective_ping(self.pingobjidnum);
                continue;
              }

              if(istrue(self.pingplayers))
                objective_setpings(self.objidnum, 1);
              else
                objective_setpingsforteam(self.objidnum, _id_FABF84450735DD93);

              objective_ping(self.objidnum);
            }
          }
        }
      }

      scripts\engine\utility::waittill_any_timeout_no_endon_death_2(self.objpingdelay, "dropped", "reset");
      continue;
    }

    waitframe();
  }
}

hidecarryiconongameend() {
  self endon("death_or_disconnect");
  self endon("drop_object");
  level waittill("game_ended");

  if(isDefined(self.carryicon))
    self.carryicon.alpha = 0;
}

gameobjects_getcurrentprimaryweapon() {
  curr = self getcurrentweapon();
  _id_D426589E25665839 = self getcurrentprimaryweapon();
  _id_A332A0449DA18650 = _id_D426589E25665839 getaltweapon();

  if(_id_A332A0449DA18650 == curr)
    return curr;

  return _id_D426589E25665839;
}

watchcarryobjectweaponswitch(weapon) {
  self endon("goal_scored");
  starttime = gettime();
  result = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(weapon, 1);

  if(isDefined(result)) {
    if(result == 0) {
      if(starttime == gettime())
        waittillframeend;

      if(isDefined(self.carryobject))
        self.carryobject thread setdropped();
    }
  }
}

giveobject(object) {
  self.carryobject = object;
  thread trackcarrier();

  if(isDefined(object.carryweapon)) {
    object.carrierweaponcurrent = gameobjects_getcurrentprimaryweapon();
    object.carrierhascarryweaponinloadout = self hasweapon(object.carryweapon);

    if(isDefined(object.carryweaponthink))
      self thread[[object.carryweaponthink]]();

    self giveweapon(object.carryweapon);
    thread watchcarryobjectweaponswitch(object.carryweapon);
    self disableweaponpickup();
    _id_3B64EB40368C1450::set("giveObject", "weapon_switch", 0);
  } else if(!object.allowweapons) {
    _id_3B64EB40368C1450::set("giveObject", "weapon", 0);
    thread manualdropthink();
  }

  if(isDefined(object.carryicon)) {
    if(level.splitscreen) {
      self.carryicon = scripts\cp\utility::createicon(object.carryicon, 33, 33);
      self.carryicon scripts\cp\utility::setpoint("BOTTOM LEFT", "BOTTOM LEFT", -50, -78);
    } else {
      self.carryicon = scripts\cp\utility::createicon(object.carryicon, 50, 50);
      self.carryicon scripts\cp\utility::setpoint("BOTTOM LEFT", "BOTTOM LEFT", 175, -30);
    }

    self.carryicon.hidewheninmenu = 1;
    thread hidecarryiconongameend();
  }
}

returnhome(_id_7591ED99E87A77D3) {
  self.isresetting = 1;
  self notify("reset");

  for(index = 0; index < self.visuals.size; index++) {
    _id_BF8E5F003146AF44 = self.visuals[index] getlinkedparent();

    if(isDefined(_id_BF8E5F003146AF44))
      self.visuals[index] unlink();

    self.visuals[index] scriptmodelclearanim();

    if(isDefined(_id_7591ED99E87A77D3))
      self.visuals[index].origin = _id_7591ED99E87A77D3;
    else if(isbombmode() && self.visuals[index].targetname == "sd_bomb") {
      self.visuals[index].origin = level.bombrespawnpoint;
      self.visuals[index].angles = level.bombrespawnangles;
    } else {
      self.visuals[index].origin = self.visuals[index].baseorigin;
      self.visuals[index].angles = self.visuals[index].baseangles;
    }

    self.visuals[index] show();
  }

  _id_BF8E5F003146AF44 = self.trigger getlinkedparent();

  if(isDefined(_id_BF8E5F003146AF44))
    self.trigger unlink();

  self.trigger.origin = self.trigger.baseorigin;

  if(isDefined(_id_7591ED99E87A77D3))
    self.trigger.origin = _id_7591ED99E87A77D3;

  self.curorigin = self.trigger.origin;

  if(isDefined(self.onreset))
    self[[self.onreset]]();

  clearcarrier();

  if(isDefined(self._id_4BCC694316C44D94))
    self[[self._id_4BCC694316C44D94]](self);
  else
    updatecompassicons();

  self.isresetting = 0;
  self notify("reset_done");
}

ishome() {
  if(isDefined(self.carrier))
    return 0;

  if(self.curorigin != self.trigger.baseorigin)
    return 0;

  return 1;
}

setposition(origin, angles) {
  self.isresetting = 1;

  for(index = 0; index < self.visuals.size; index++) {
    self.visuals[index].origin = origin;
    self.visuals[index].angles = angles;
    self.visuals[index] show();
  }

  self.trigger.origin = origin;

  if(scripts\cp\utility::getgametype() == "ball" || scripts\cp\utility::getgametype() == "tdef")
    self.trigger linkTo(self.visuals[0]);

  self.curorigin = self.trigger.origin;
  clearcarrier();
  updatecompassicons();
  self.isresetting = 0;
}

carryobject_overridemovingplatformdeath(data) {
  for(index = 0; index < data.carryobject.visuals.size; index++)
    data.carryobject.visuals[index] unlink();

  data.carryobject.trigger unlink();
  data.carryobject thread setdropped(1);
}

setdropped(_id_F2F5B1863E65433F, _id_055D7A145D6897D3, _id_74435D86CB84BE29, _id_A4B132B2321973CD) {
  if(isDefined(self.setdropped)) {
    if([[self.setdropped]]())
      return;
  }

  self.isresetting = 1;
  self.resetnow = undefined;
  self notify("dropped");

  foreach(visual in self.visuals)
  visual notsolid();

  if(isDefined(self.carrier))
    droppoint = self.carrier.origin;
  else
    droppoint = self.curorigin;

  if(isDefined(level.bombdroploc)) {
    droppoint = level.bombdroploc;
    level.bombdroploc = undefined;
  }

  if(isDefined(_id_055D7A145D6897D3))
    _id_869E9FD0CDBD405A = _id_055D7A145D6897D3;
  else
    _id_869E9FD0CDBD405A = 20;

  _id_12F59CD9E8D7E077 = 4000;
  upangles = (0, 0, 0);
  _id_16C9AD20A2797135 = droppoint + (0, 0, _id_869E9FD0CDBD405A);
  _id_812238F6F1F6728C = droppoint - (0, 0, _id_12F59CD9E8D7E077);
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 1);
  ignoreents = [];
  ignoreents[ignoreents.size] = self.visuals[0];

  if(isDefined(self.carrier))
    ignoreents[ignoreents.size] = self.carrier;

  if(isDefined(self._id_1972CCB1779C69D1) && istrue(_id_A4B132B2321973CD)) {
    trace = self._id_1972CCB1779C69D1;
    self._id_1972CCB1779C69D1 = undefined;
  } else if(isDefined(self.carrier) && self.carrier.team != "spectator") {
    _id_8D392109C97647B8 = 8;
    _id_8D5C3709C99CBFD2 = 16;

    if(scripts\cp\utility::getgametype() == "cyber") {
      _id_8D392109C97647B8 = 4;
      _id_8D5C3709C99CBFD2 = 8;
    } else if(scripts\cp\utility::getgametype() == "ctf" || scripts\cp\utility::getgametype() == "tdef") {
      _id_8D392109C97647B8 = 2;
      _id_8D5C3709C99CBFD2 = 4;
    }

    trace = scripts\engine\trace::capsule_trace(_id_16C9AD20A2797135, _id_812238F6F1F6728C, _id_8D392109C97647B8, _id_8D5C3709C99CBFD2, (0, 0, 0), ignoreents, contentoverride, 0);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++) {
      _id_8B39D5984DA1DC7F = trace["entity"];

      if(isDefined(_id_8B39D5984DA1DC7F)) {
        if(isDefined(_id_8B39D5984DA1DC7F.code_classname) && _id_8B39D5984DA1DC7F.code_classname == "script_vehicle" && (!isDefined(_id_8B39D5984DA1DC7F.vehiclename) || isDefined(_id_8B39D5984DA1DC7F.vehiclename) && _id_8B39D5984DA1DC7F.vehiclename != "pac_sentry") || isDefined(_id_8B39D5984DA1DC7F.objweapon) && isweapon(_id_8B39D5984DA1DC7F.objweapon) || isDefined(_id_8B39D5984DA1DC7F) && istrue(_id_8B39D5984DA1DC7F.issuper) && isDefined(_id_8B39D5984DA1DC7F.equipmentref) && (_id_8B39D5984DA1DC7F.equipmentref == "equip_ammo_box" || _id_8B39D5984DA1DC7F.equipmentref == "equip_trophy") || isDefined(_id_8B39D5984DA1DC7F.code_classname) && _id_8B39D5984DA1DC7F.code_classname == "weapon_scavenger_bag_mp") {
          ignoreents[ignoreents.size] = trace["entity"];
          trace = scripts\engine\trace::capsule_trace(_id_16C9AD20A2797135, _id_812238F6F1F6728C, _id_8D392109C97647B8, _id_8D5C3709C99CBFD2, (0, 0, 0), ignoreents, contentoverride, 0);
        }

        continue;
      }

      break;
    }
  } else {
    trace = scripts\engine\trace::ray_trace(self.safeorigin + (0, 0, 20), self.safeorigin - (0, 0, 20), ignoreents, contentoverride, 0);

    if(isPlayer(trace["entity"]))
      trace["entity"] = undefined;

    if(isDefined(trace["entity"]) && isDefined(trace["entity"].code_classname) && trace["entity"].code_classname == "script_vehicle") {
      ignoreents[ignoreents.size] = trace["entity"];
      trace = scripts\engine\trace::ray_trace(self.safeorigin + (0, 0, 20), self.safeorigin - (0, 0, 20), ignoreents, contentoverride, 0);
    }
  }

  foreach(visual in self.visuals)
  visual solid();

  _id_2CA201D5906CDBA5 = self.carrier;

  if(isDefined(trace)) {
    _id_9CA1B8FD292FEFFA = randomfloat(360);
    droporigin = trace["position"];

    if(isDefined(self.visualgroundoffset))
      droporigin = droporigin + self.visualgroundoffset;

    forward = (cos(_id_9CA1B8FD292FEFFA), sin(_id_9CA1B8FD292FEFFA), 0);
    forward = vectorNormalize(forward - trace["normal"] * vectordot(forward, trace["normal"]));
    _id_6E1CFF2315B21CEE = 0;

    if(scripts\cp\utility::getgametype() == "ctf" || scripts\cp\utility::getgametype() == "tdef" || isbombmode())
      dropangles = (0, 0, 0);
    else
      dropangles = vectortoangles(forward);

    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index].origin = droporigin;
      self.visuals[index].angles = dropangles;
      self.visuals[index] show();
    }

    self.trigger.origin = droporigin + (0, 0, _id_6E1CFF2315B21CEE);
    self.curorigin = self.trigger.origin;
    mover = undefined;
    _id_8B39D5984DA1DC7F = trace["entity"];

    if(isDefined(_id_8B39D5984DA1DC7F) && !isPlayer(_id_8B39D5984DA1DC7F) && !isweapon(_id_8B39D5984DA1DC7F) && (isDefined(_id_8B39D5984DA1DC7F.objweapon) && !isweapon(_id_8B39D5984DA1DC7F.objweapon)) && !isbot(_id_8B39D5984DA1DC7F) && !isagent(_id_8B39D5984DA1DC7F) && !scripts\cp\utility\entity::isturret(_id_8B39D5984DA1DC7F) && (!isDefined(_id_8B39D5984DA1DC7F.classname) || _id_8B39D5984DA1DC7F.classname != "script_vehicle" && _id_8B39D5984DA1DC7F.classname != "rocket"))
      mover = trace["entity"];

    level._id_8B39D5984DA1DC7F = trace["entity"];

    if(isDefined(_id_8B39D5984DA1DC7F) && (istrue(_id_8B39D5984DA1DC7F.issuper) || isDefined(_id_8B39D5984DA1DC7F.streakinfo))) {
      _id_A9706ADAF7C52E27 = getclosestpointonnavmesh(self.curorigin + forward * 40);

      if(isDefined(self.visualgroundoffset))
        _id_A9706ADAF7C52E27 = _id_A9706ADAF7C52E27 + self.visualgroundoffset;

      for(index = 0; index < self.visuals.size; index++)
        self.visuals[index].origin = _id_A9706ADAF7C52E27;

      self.trigger.origin = _id_A9706ADAF7C52E27;
      self.curorigin = self.trigger.origin;
    }

    if(isDefined(mover) && isDefined(mover.owner)) {
      _id_BF8E5F003146AF44 = mover getlinkedparent();

      if(isDefined(_id_BF8E5F003146AF44))
        mover = _id_BF8E5F003146AF44;
    }

    if(isDefined(mover)) {
      if(isDefined(mover.invalid_gameobject_mover) && mover.invalid_gameobject_mover == 1)
        self.resetnow = 1;
      else {
        for(index = 0; index < self.visuals.size; index++)
          self.visuals[index] linkTo(mover);

        self.trigger linkTo(mover);
        data = spawnStruct();
        data.carryobject = self;
        data.deathoverridecallback = ::carryobject_overridemovingplatformdeath;
        self.trigger thread scripts\cp\cp_movers::handle_moving_platforms(data);
      }
    }

    thread _id_AE5131DDFA2B3AF4(_id_F2F5B1863E65433F);
  } else {
    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index].origin = self.visuals[index].baseorigin;
      self.visuals[index].angles = self.visuals[index].baseangles;
      self.visuals[index] show();
    }

    self.trigger.origin = self.trigger.baseorigin;
    self.curorigin = self.trigger.baseorigin;
  }

  if(isDefined(self.ondrop) && !isDefined(_id_F2F5B1863E65433F))
    self[[self.ondrop]](_id_2CA201D5906CDBA5);

  _id_7E2C53B0BCF117D9 = spawnStruct();
  _id_7E2C53B0BCF117D9._id_22282E7D48CA3400 = _id_2CA201D5906CDBA5;
  _id_7E2C53B0BCF117D9._id_239B4B5FA4BCF6C6 = self;
  _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_objective_state_changed", _id_7E2C53B0BCF117D9);
  clearcarrier();

  if(!istrue(_id_74435D86CB84BE29)) {
    if(isDefined(self._id_4BCC694316C44D94))
      self[[self._id_4BCC694316C44D94]](self);
    else
      updatecompassicons();
  }

  self.isresetting = 0;
}

_id_CA7C06EF832ACA23(_id_8B39D5984DA1DC7F) {
  self endon("pickup_object");
  _id_8B39D5984DA1DC7F waittill("death");
  thread setdropped();
}

setcarrier(carrier) {
  self.carrier = carrier;

  if(isPlayer(carrier) && istrue(carrier.skipuavupdate))
    thread updatevisibilityaccordingtoradar();
}

clearcarrier() {
  if(!isDefined(self.carrier)) {
    return;
  }
  self.carrier thread takeobject(self);
  self.carrier = undefined;
  self.curcarrierorigin = undefined;
  self notify("carrier_cleared");
}

_id_AE5131DDFA2B3AF4(_id_F2F5B1863E65433F) {
  self endon("pickup_object");
  self endon("reset_done");
  level endon("game_ended");
  waitframe();

  if(!isDefined(_id_F2F5B1863E65433F)) {
    safeorigin = undefined;

    if(_id_BABD6A87808A6651(self.visuals[0], self.allowedintrigger) && !_id_29C0CF699C075F78()) {
      safeorigin = _id_D1C485A557F40CD2();

      if(isDefined(self.visualgroundoffset))
        safeorigin = safeorigin + self.visualgroundoffset;
    }

    thread pickuptimeout(safeorigin);
  }
}

pickuptimeout(_id_7591ED99E87A77D3) {
  self endon("pickup_object");
  self endon("reset_done");
  level endon("game_ended");

  if(isDefined(_id_7591ED99E87A77D3)) {
    returnhome(_id_7591ED99E87A77D3);
    return;
  }

  if(isDefined(self.resetnow)) {
    self.resetnow = undefined;
    returnhome();
    return;
  }

  for(index = 0; index < level.radtriggers.size; index++) {
    if(!self.visuals[0] istouching(level.radtriggers[index])) {
      continue;
    }
    returnhome();
    return;
  }

  for(index = 0; index < level.minetriggers.size; index++) {
    if(!self.visuals[0] istouching(level.minetriggers[index])) {
      continue;
    }
    returnhome();
    return;
  }

  for(index = 0; index < level.hurttriggers.size; index++) {
    if(!self.visuals[0] istouching(level.hurttriggers[index])) {
      continue;
    }
    returnhome(_id_7591ED99E87A77D3);
    return;
  }

  if(istrue(level.ballallowedtriggers.size)) {
    self.allowedintrigger = 0;

    foreach(trigger in level.ballallowedtriggers) {
      if(self.visuals[0] istouching(trigger)) {
        self.allowedintrigger = 1;
        break;
      }
    }
  }

  if(isDefined(level.outofboundstriggers)) {
    foreach(trigger in level.outofboundstriggers) {
      if(istrue(self.allowedintrigger)) {
        break;
      }

      if(!self.visuals[0] istouching(trigger)) {
        continue;
      }
      returnhome(_id_7591ED99E87A77D3);
      return;
    }
  }

  if(isDefined(self.autoresettime)) {
    wait(self.autoresettime);

    if(!isDefined(self.carrier))
      returnhome();
  }
}

_id_D1C485A557F40CD2() {
  if(isDefined(self._id_1972CCB1779C69D1) && isDefined(self._id_1972CCB1779C69D1["position"]) && !_id_0C3C18FCCE2D382D(self._id_1972CCB1779C69D1["position"], self.allowedintrigger))
    return self._id_1972CCB1779C69D1["position"];

  return getclosestpointonnavmesh(self.visuals[0].origin);
}

takeobject(object) {
  if(isDefined(self.carryicon))
    self.carryicon scripts\cp\utility::destroyelem();

  if(isDefined(self))
    self.carryobject = undefined;

  self notify("drop_object");

  if(object.triggertype == "proximity")
    thread pickupobjectdelay(object);

  if(scripts\cp\utility\player::isreallyalive(self) && !object.allowweapons) {
    if(isDefined(object.carryweapon)) {
      _id_506F2E235EF4BFA8 = isDefined(object.keepcarryweapon) && object.keepcarryweapon;

      if(!object.carrierhascarryweaponinloadout && !_id_506F2E235EF4BFA8) {
        if(isDefined(object.ballindex))
          wait 0.25;

        self notify("clear_carrier");

        if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(object.carryweapon))
          scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(object.carryweapon);
        else
          scripts\cp_mp\utility\inventory_utility::_takeweapon(object.carryweapon);

        thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(self.lastdroppableweaponobj);
      } else {}

      self enableweaponpickup();
    }

    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("giveObject");
  }
}

trackcarrier() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  while(isDefined(self.carryobject) && scripts\cp\utility\player::isreallyalive(self)) {
    if(self isonground()) {
      trace = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 20), self.origin - (0, 0, 20), 0, undefined);

      if(trace["fraction"] < 1)
        self.carryobject.safeorigin = trace["position"];
    }

    wait 0.05;
  }
}

manualdropthink() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  for(;;) {
    while(self attackButtonPressed() || self fragButtonPressed() || self secondaryoffhandbuttonPressed() || self meleeButtonPressed())
      wait 0.05;

    while(!self attackButtonPressed() && !self fragButtonPressed() && !self secondaryoffhandbuttonPressed() || self meleeButtonPressed())
      wait 0.05;

    if(isDefined(self.carryobject) && !self useButtonPressed())
      self.carryobject thread setdropped();
  }
}

deleteuseobject() {
  releaseid();
  self.trigger delete();
  self.trigger = undefined;
  self notify("deleted");
}

createuseobject(ownerteam, trigger, visuals, _id_E62DF0718B7DCBCA, _id_3C2389BA69E5822B, _id_08B9949739F4E0F6, showoncompass) {
  if(istrue(trigger.isuseobject))
    useobject = trigger;
  else
    useobject = spawnStruct();

  useobject.type = "useObject";
  useobject.curorigin = trigger.origin;
  useobject.ownerteam = ownerteam;
  useobject.entnum = trigger getentitynumber();
  useobject.keyobject = undefined;

  if(issubstr(trigger.classname, "use") || istrue(trigger.usetype))
    useobject.triggertype = "use";
  else
    useobject.triggertype = "proximity";

  trigger.gameobject = useobject;
  useobject.trigger = trigger;

  for(index = 0; index < visuals.size; index++) {
    visuals[index].baseorigin = visuals[index].origin;
    visuals[index].baseangles = visuals[index].angles;
  }

  useobject.visuals = visuals;

  if(!isDefined(_id_E62DF0718B7DCBCA))
    _id_E62DF0718B7DCBCA = (0, 0, 0);

  useobject.offset3d = _id_E62DF0718B7DCBCA;
  useobject.compassicons = [];
  useobject requestid(1, 1, _id_3C2389BA69E5822B, showoncompass, undefined, undefined, _id_08B9949739F4E0F6);
  useobject.interactteam = "none";
  useobject.visibleteam = "none";
  useobject.onuse = undefined;
  useobject.oncantuse = undefined;
  useobject.usetext = "default";
  useobject.usetime = 10000;
  useobject.curprogress = 0;
  useobject.majoritycapprogress = 0;
  useobject.wasmajoritycapprogress = 0;
  useobject.stalemate = 0;
  useobject.wasstalemate = 0;
  useobject.captureblocked = 0;
  useobject.exclusiveuse = 1;
  useobject.teamprogress = [];
  useobject.teamprogress["none"] = 0;

  if(useobject.triggertype == "proximity") {
    useobject.teamusetimes = [];
    useobject.teamusetexts = [];
    useobject.numtouching["neutral"] = 0;
    useobject.touchlist["neutral"] = [];
    useobject.numtouching["none"] = 0;
    useobject.touchlist["none"] = [];

    foreach(name in level.teamnamelist) {
      useobject.teamprogress[name] = 0;
      useobject.numtouching[name] = 0;
      useobject.touchlist[name] = [];
      useobject.assisttouchlist[name] = [];
    }

    useobject.userate = 0;
    useobject.useratemultiplier = 1.0;
    useobject.claimteam = "none";
    useobject.claimplayer = undefined;
    useobject.lastclaimteam = "none";
    useobject.lastclaimtime = 0;
    useobject.mustmaintainclaim = 0;
    useobject.cancontestclaim = 0;
    useobject thread useobjectproxthink();
  } else {
    foreach(team in level.teamnamelist)
    useobject.teamprogress[team] = 0;

    useobject.userate = 1;
    useobject.useratemultiplier = 1.0;
    useobject thread useobjectusethink();
  }

  return useobject;
}

createholduseobject(ownerteam, trigger, visuals, offset) {
  useobject = spawnStruct();
  useobject.type = "useObject";
  useobject.curorigin = trigger.origin;
  useobject.ownerteam = ownerteam;
  useobject.entnum = trigger getentitynumber();
  useobject.keyobject = undefined;
  useobject.triggertype = "use";
  trigger.gameobject = useobject;
  useobject.trigger = trigger;

  for(index = 0; index < visuals.size; index++) {
    visuals[index].baseorigin = visuals[index].origin;
    visuals[index].baseangles = visuals[index].angles;
  }

  useobject.visuals = visuals;

  if(!isDefined(offset))
    offset = (0, 0, 0);

  useobject.offset3d = offset;
  useobject.compassicons = [];
  useobject.interactteam = "none";
  useobject.visibleteam = "none";
  useobject.onuse = undefined;
  useobject.oncantuse = undefined;
  useobject.usetext = "default";
  useobject.usetime = 10000;
  useobject.curprogress = 0;
  useobject.stalemate = 0;
  useobject.wasstalemate = 0;
  useobject.captureblocked = 0;
  useobject.exclusiveuse = 1;
  useobject.teamprogress = [];
  useobject.teamprogress["none"] = 0;

  foreach(team in level.teamnamelist)
  useobject.teamprogress[team] = 0;

  useobject.userate = 1;
  useobject.useratemultiplier = 1.0;
  useobject thread useobjectusethink();
  return useobject;
}

createdynamicholduseobject(ownerteam, pos, visuals, offset) {
  useobject = spawnStruct();
  useobject.type = "useObject";
  useobject.curorigin = pos;
  useobject.ownerteam = ownerteam;
  useobject.keyobject = undefined;
  useobject.triggertype = "use";

  for(index = 0; index < visuals.size; index++) {
    visuals[index].baseorigin = visuals[index].origin;
    visuals[index].baseangles = visuals[index].angles;
  }

  useobject.visuals = visuals;

  if(!isDefined(offset))
    offset = (0, 0, 0);

  useobject.offset3d = offset;
  useobject.compassicons = [];
  useobject.interactteam = "none";
  useobject.visibleteam = "none";
  useobject.onuse = undefined;
  useobject.oncantuse = undefined;
  useobject.usetext = "default";
  useobject.usetime = 10000;
  useobject.curprogress = 0;
  useobject.stalemate = 0;
  useobject.wasstalemate = 0;
  useobject.captureblocked = 0;
  useobject.exclusiveuse = 1;
  useobject.teamprogress = [];
  useobject.teamprogress["none"] = 0;

  foreach(team in level.teamnamelist)
  useobject.teamprogress[team] = 0;

  useobject.userate = 1;
  useobject.useratemultiplier = 1.0;
  visuals[0] makeusable();
  visuals[0] thread usedynamicobjectusethink();
  return useobject;
}

setkeyobject(object) {
  self.keyobject = object;
}

usedynamicobjectusethink() {
  level endon("game_ended");
  self endon("deleted");

  for(;;) {
    self waittill("trigger", player);

    if(!scripts\cp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(!caninteractwith(player.pers["team"], player)) {
      continue;
    }
    if(!player isonground()) {
      continue;
    }
    if(player scripts\cp\utility\player::isusingremote()) {
      continue;
    }
    if(_id_2669878CF5A1B6BC::iskillstreakweapon(player getcurrentweapon())) {
      continue;
    }
    if(isDefined(self.usecondition)) {
      if(!self[[self.usecondition]](player))
        continue;
    }

    if(isDefined(self.keyobject) && (!isDefined(player.carryobject) || player.carryobject != self.keyobject)) {
      if(isDefined(self.oncantuse))
        self[[self.oncantuse]](player);

      continue;
    }

    if(isDefined(self.useweapon) && player hasweapon(self.useweapon)) {
      continue;
    }
    if(!player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon")) {
      continue;
    }
    if(!self.exclusiveuse && !isDefined(self.exclusiveclaim)) {
      thread useholdloop(player);
      continue;
    }

    useholdloop(player);
  }
}

useobjectusethink() {
  level endon("game_ended");
  self endon("deleted");

  for(;;) {
    self.trigger waittill("trigger", player);

    if(!scripts\cp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(!caninteractwith(player.pers["team"], player)) {
      continue;
    }
    if(!player isonground() && !(istrue(self._id_DBC472744080C5D7) && player _meth_E40102956C887F7C())) {
      continue;
    }
    if(player scripts\cp\utility\player::isusingremote()) {
      continue;
    }
    if(isDefined(level._id_5FEC67FA7F314C8A)) {
      if(![[level._id_5FEC67FA7F314C8A]](player))
        continue;
    }

    if(isDefined(self.usecondition)) {
      if(!self[[self.usecondition]](player))
        continue;
    }

    if(isDefined(self.keyobject) && (!isDefined(player.carryobject) || player.carryobject != self.keyobject)) {
      if(isDefined(self.oncantuse))
        self[[self.oncantuse]](player);

      continue;
    }

    if(isDefined(self.useweapon) && player hasweapon(self.useweapon)) {
      continue;
    }
    if(!player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("weapon")) {
      continue;
    }
    if(player ismeleeing()) {
      continue;
    }
    if(!self.exclusiveuse && !isDefined(self.exclusiveclaim)) {
      thread useholdloop(player);
      continue;
    }

    useholdloop(player);
  }
}

useholdloop(player) {
  result = 1;
  _id_56C1CE01138CF718 = 0;

  if(self.usetime > 0) {
    if(isDefined(self.onbeginuse)) {
      player updateuiprogress(self, 0);
      self[[self.onbeginuse]](player);
    }

    if(!isDefined(self.keyobject))
      thread cantusehintthink();

    team = player.pers["team"];
    result = useholdthink(player);
    self notify("finished_use");

    if(isDefined(self.onenduse))
      self[[self.onenduse]](team, player, result);
  }

  if(istrue(result)) {
    if(isDefined(self.onuse))
      self[[self.onuse]](player);

    _id_56C1CE01138CF718 = 1;
  }

  if(istrue(_id_56C1CE01138CF718)) {
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9._id_22282E7D48CA3400 = player;
    _id_7E2C53B0BCF117D9._id_239B4B5FA4BCF6C6 = self;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_objective_state_changed", _id_7E2C53B0BCF117D9);
  }
}

checkobjectiskeyobject(player) {
  _id_9DC8B39B9DC38EF4 = self.keyobject;

  if(!isarray(_id_9DC8B39B9DC38EF4))
    _id_9DC8B39B9DC38EF4 = [_id_9DC8B39B9DC38EF4];

  foreach(key in _id_9DC8B39B9DC38EF4) {
    if(key istouching(self.trigger))
      return 1;
  }

  return 0;
}

checkplayercarrykeyobject(player) {
  _id_9DC8B39B9DC38EF4 = self.keyobject;

  if(!isarray(_id_9DC8B39B9DC38EF4))
    _id_9DC8B39B9DC38EF4 = [_id_9DC8B39B9DC38EF4];

  foreach(key in _id_9DC8B39B9DC38EF4) {
    if(key == player.carryobject)
      return 1;
  }

  return 0;
}

cantusehintthink() {
  level endon("game_ended");
  self endon("deleted");
  self endon("finished_use");

  if(!isDefined(self.trigger)) {
    return;
  }
  for(;;) {
    self.trigger waittill("trigger", player);

    if(!scripts\cp\utility\player::isreallyalive(player)) {
      continue;
    }
    if(!caninteractwith(player.pers["team"], player)) {
      continue;
    }
    if(isDefined(self.oncantuse))
      self[[self.oncantuse]](player);
  }
}

getearliestclaimplayer() {
  team = self.claimteam;
  _id_0257DC7B0ABCB815 = self.claimplayer;

  if(self.touchlist[team].size > 0) {
    _id_E300F983791236B9 = undefined;
    players = getarraykeys(self.touchlist[team]);

    for(index = 0; index < players.size; index++) {
      _id_E29BB013735AF9BC = self.touchlist[team][players[index]];

      if(isDefined(_id_E29BB013735AF9BC.player) && scripts\cp\utility\player::isreallyalive(_id_E29BB013735AF9BC.player) && (!isDefined(_id_E300F983791236B9) || _id_E29BB013735AF9BC.starttime < _id_E300F983791236B9)) {
        _id_0257DC7B0ABCB815 = _id_E29BB013735AF9BC.player;
        _id_E300F983791236B9 = _id_E29BB013735AF9BC.starttime;
      }
    }
  }

  return _id_0257DC7B0ABCB815;
}

isteamtouching() {
  _id_687E3456E754E3E1 = "none";

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(self.numtouching[_id_F90358454413407F]) {
      _id_687E3456E754E3E1 = _id_F90358454413407F;
      break;
    }
  }

  return _id_687E3456E754E3E1 != "none";
}

useobjectproxthink() {
  level endon("game_ended");
  self endon("deleted");
  thread proxtriggerthink();

  if(!isDefined(self.ignorestomp))
    self.ignorestomp = 0;

  for(;;) {
    if(self.interactteam == "none") {
      waitframe();
      scripts\cp\cp_hostmigration::waittillhostmigrationdone();
      continue;
    }

    _id_56C1CE01138CF718 = 0;
    _id_58E8D1412BC688CD = undefined;
    self.wasuncontested = 0;

    if(self.cancontestclaim) {
      if(self.stalemate != self.wasstalemate) {
        if(self.stalemate) {
          if(isDefined(self.oncontested))
            self[[self.oncontested]]();

          _id_56C1CE01138CF718 = 1;
        } else {
          team = "none";

          foreach(_id_F90358454413407F in level.teamnamelist) {
            if(self.numtouching[_id_F90358454413407F]) {
              team = _id_F90358454413407F;
              break;
            }
          }

          if(team == "none" && self.ownerteam != "neutral") {
            team = self.ownerteam;
            setclaimteam("none");
            self.claimplayer = undefined;
          }

          foreach(_id_F90358454413407F in level.teamnamelist) {
            if(self.touchlist[_id_F90358454413407F].size) {
              touchlist = self.touchlist[_id_F90358454413407F];
              _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

              for(index = 0; index < _id_59DB5D0F4E3000A7.size; index++) {
                player = touchlist[_id_59DB5D0F4E3000A7[index]].player;

                if(!isalive(player)) {
                  continue;
                }
                if(player.team == self.ownerteam)
                  scripts\mp\objidpoolmanager::_id_8F7A55BDA12EBB21(&"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", player);
                else
                  player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, undefined, 0);

                _id_58E8D1412BC688CD = player;
              }

              break;
            }
          }

          if(isDefined(self.onuncontested))
            self[[self.onuncontested]](team);

          _id_56C1CE01138CF718 = 1;
          self.wasuncontested = 1;
        }

        self.wasstalemate = self.stalemate;
      }

      if(!self.stalemate && self.majoritycapprogress != self.wasmajoritycapprogress)
        self.wasmajoritycapprogress = self.majoritycapprogress;
    }

    if(!self.stalemate && !self.majoritycapprogress && !self.wasuncontested) {
      if(self.mustmaintainclaim && !istrue(self.isunoccupied)) {
        if(self.ownerteam != "neutral" && !self.numtouching[self.ownerteam]) {
          if(isDefined(self.onunoccupied))
            self[[self.onunoccupied]]();

          _id_56C1CE01138CF718 = 1;
          self.isunoccupied = 1;
          setclaimteam("none");
          self.claimplayer = undefined;
        } else if(self.ownerteam == "neutral") {
          if(!isteamtouching()) {
            if(isDefined(self.onunoccupied))
              self[[self.onunoccupied]]();

            _id_56C1CE01138CF718 = 1;
            self.isunoccupied = 1;
            setclaimteam("none");
            self.claimplayer = undefined;
          } else if(isDefined(self.numtouchrequireduse))
            self[[self.numtouchrequireduse]](self.claimplayer.team);
        }
      } else if(!istrue(self.isunoccupied) && isDefined(self.onunoccupied)) {
        team = "none";

        foreach(_id_F90358454413407F in level.teamnamelist) {
          if(self.numtouching[_id_F90358454413407F]) {
            team = _id_F90358454413407F;
            break;
          }
        }

        if(team == "none") {
          self.isunoccupied = 1;
          self[[self.onunoccupied]]();
        }
      }
    }

    allowcapture = 1;

    if(isDefined(self.numtouchrequired) && self.numtouchrequired > self.numtouching[self.claimteam])
      allowcapture = 0;

    if(self.claimteam != "none" && self.lastclaimteam != self.claimteam) {
      _id_56C1CE01138CF718 = 1;
      _id_58E8D1412BC688CD = getearliestclaimplayer();
    }

    if(self.claimteam != "none" && allowcapture) {
      if(!self.usetime) {
        if(!self.stalemate) {
          if(isDefined(self._id_F56EDB5DF74AE868))
            _id_58E8D1412BC688CD = self[[self._id_F56EDB5DF74AE868]]();
          else
            _id_58E8D1412BC688CD = getearliestclaimplayer();

          setclaimteam("none");
          self.claimplayer = undefined;

          if(isDefined(_id_58E8D1412BC688CD) && isDefined(self.onuse))
            self[[self.onuse]](_id_58E8D1412BC688CD);

          _id_56C1CE01138CF718 = 1;
          self._id_2DDA7CAA18DDD5F8 = 0;
        }
      } else if(self.usetime && self.teamprogress[self.claimteam] >= self.usetime) {
        self.curprogress = 0.0;
        self.teamprogress[self.claimteam] = self.curprogress;
        _id_58E8D1412BC688CD = getearliestclaimplayer();
        setclaimteam("none");
        self.claimplayer = undefined;

        if(isDefined(self.onenduse))
          self[[self.onenduse]](self.claimteam, _id_58E8D1412BC688CD, isDefined(_id_58E8D1412BC688CD));

        if(isDefined(_id_58E8D1412BC688CD) && isDefined(self.onuse))
          self[[self.onuse]](_id_58E8D1412BC688CD);

        _id_56C1CE01138CF718 = 1;
        self._id_2DDA7CAA18DDD5F8 = 0;
      } else if(!self.stalemate && self.usetime && (self.ownerteam != self.claimteam || istrue(self.majoritycapprogress))) {
        if(!self.numtouching[self.claimteam]) {
          setclaimteam("none");

          if(isDefined(self.onenduse))
            self[[self.onenduse]](self.claimteam, self.claimplayer, 0);

          self.claimplayer = undefined;
          _id_56C1CE01138CF718 = 1;
          self._id_2DDA7CAA18DDD5F8 = 0;
        } else if(canstompprogresswithstalemate(self.claimteam) && self.ownerteam == "neutral") {
          if(self.lastclaimteam == self.claimteam && istrue(self.majoritycapprogress)) {
            if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.claimteam] == 0)
              stompenemyteamprogress(self.claimteam);
            else {
              self.lastprogressteam = self.claimteam;
              applycaptureprogressanduseupdate();
            }
          }
        } else if(canstompprogress(self.claimteam) && self.ownerteam == "neutral" && self.lastclaimteam != self.claimteam) {
          if(self.lastclaimteam != self.claimteam) {
            if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.claimteam] == 0)
              stompenemyteamprogress(self.claimteam);
            else if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.lastprogressteam] > 0)
              stompenemyteamprogress(self.claimteam);
            else {
              self.lastprogressteam = self.claimteam;
              applycaptureprogressanduseupdate();
            }
          }
        } else if(canstompprogress(self.claimteam) && self.ownerteam == self.claimteam && (!istrue(self._id_823C5A7BF6A0E64A) || !istrue(self.teamprogress[self.ownerteam]))) {
          if(isDefined(self.lastprogressteam) && self.lastprogressteam == self.claimteam && self.teamprogress[self.claimteam] == 0)
            stompenemyteamprogress(self.claimteam);
          else if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.lastprogressteam] > 0 && self.teamprogress[self.claimteam] == 0)
            stompenemyteamprogress(self.claimteam);
        } else if(canstompprogress(self.claimteam) && self.ownerteam != self.claimteam && istrue(self._id_823C5A7BF6A0E64A) && istrue(self.teamprogress[self.ownerteam])) {
          if(isDefined(self.lastprogressteam) && self.lastprogressteam == self.claimteam && self.teamprogress[self.claimteam] == 0)
            stompenemyteamprogress(self.claimteam);
          else if(isDefined(self.lastprogressteam) && self.lastprogressteam != self.claimteam && self.teamprogress[self.lastprogressteam] > 0 && self.teamprogress[self.claimteam] == 0)
            stompenemyteamprogress(self.claimteam);
        } else if(self.ownerteam != self.claimteam) {
          self.setblocking = 0;
          self.setdefending = 0;
          self.lastprogressteam = self.claimteam;
          applycaptureprogressanduseupdate();
        } else if(self.ownerteam == self.claimteam && istrue(self._id_823C5A7BF6A0E64A) && (!istrue(self._id_11D80259A066AB76) || self.curprogress < self._id_9ABE4AB71AE5D548)) {
          self.setblocking = 0;
          self.setdefending = 0;
          self.lastprogressteam = self.claimteam;
          applycaptureprogressanduseupdate();
        } else if(self.ownerteam == self.claimteam && istrue(self.majoritycapprogress)) {
          _id_351B93A4DE4CF1CE = getnumtouchingexceptteam(self.claimteam);

          if(_id_351B93A4DE4CF1CE && !istrue(self.setblocking)) {
            self.setblocking = 1;
            self.setdefending = 0;
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS");
            scripts\mp\objidpoolmanager::update_objective_setenemylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
          } else if(!_id_351B93A4DE4CF1CE && !istrue(self.setdefending)) {
            self.setblocking = 0;
            self.setdefending = 1;
            setobjectivestatusicons(level._id_0A58E0495B821276, level.iconcapture);
          }
        }
      } else if(!self.stalemate && self.usetime && self.ownerteam == self.claimteam) {
        if(!self.numtouching[self.claimteam]) {
          setclaimteam("none");
          self.claimplayer = undefined;

          if(isDefined(self.onenduse))
            self[[self.onenduse]](self.claimteam, self.claimplayer, 0);

          self._id_2DDA7CAA18DDD5F8 = 0;
        }
      }
    } else if(canstompprogress(self.ownerteam) && self.ownerteam != "neutral")
      stompenemyteamprogress(self.ownerteam);

    if(_id_56C1CE01138CF718) {
      _id_7E2C53B0BCF117D9 = spawnStruct();
      _id_7E2C53B0BCF117D9._id_22282E7D48CA3400 = _id_58E8D1412BC688CD;
      _id_7E2C53B0BCF117D9._id_239B4B5FA4BCF6C6 = self;
      _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_objective_state_changed", _id_7E2C53B0BCF117D9);
    }

    waitframe();
    scripts\cp\cp_hostmigration::waittillhostmigrationdone();
  }
}

canstompprogress(_id_C8200ACBB85AC41F) {
  return !istrue(self.ignorestomp) && self.touchlist[_id_C8200ACBB85AC41F].size > 0 && !istrue(self.stalemate) && self.curprogress > 0;
}

canstompprogresswithstalemate(_id_C8200ACBB85AC41F) {
  return !istrue(self.ignorestomp) && self.touchlist[_id_C8200ACBB85AC41F].size > 0 && self.majoritycapprogress && self.curprogress > 0;
}

applycaptureprogressanduseupdate() {
  applycaptureprogress(self.claimteam, level.frameduration * self.userate);

  if(isDefined(self.onuseupdate))
    self[[self.onuseupdate]](self.claimteam, self.teamprogress[self.claimteam] / self.usetime, level.frameduration * self.userate / self.usetime, self.claimplayer);
}

stompenemyteamprogress(team) {
  if(isDefined(self.stompeenemyprogressupdate))
    self[[self.stompeenemyprogressupdate]](team);

  _id_3777ECE6A73EADA5 = level.frameduration * self.userate;

  if(istrue(self._id_823C5A7BF6A0E64A) && self.ownerteam != "neutral" && team != self.ownerteam) {
    if(isDefined(self._id_D701BF01C81A10B3) && self._id_D701BF01C81A10B3 > 0)
      _id_3777ECE6A73EADA5 = _id_3777ECE6A73EADA5 * self._id_D701BF01C81A10B3;
  }

  numtouching = getnumtouchingforteam(self.claimteam);
  _id_65218754A3CA92DB = getnumtouchingexceptteam(self.claimteam);
  _id_B0C33D224B825287 = scripts\cp\utility::getenemyteams(team);

  foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
    _id_75016344BDEE1D3A = self.teamprogress[_id_F90358454413407F];

    if(_id_75016344BDEE1D3A > 0) {
      if(_id_75016344BDEE1D3A < _id_3777ECE6A73EADA5) {
        self.teamprogress[_id_F90358454413407F] = 0;
        self.curprogress = self.teamprogress[_id_F90358454413407F];
        scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
        scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, 0);
        _id_3777ECE6A73EADA5 = _id_3777ECE6A73EADA5 - _id_75016344BDEE1D3A;
        continue;
      }

      self.isunoccupied = 0;
      self._id_B276B0D8CBBD0480 = 1;
      self.teamprogress[_id_F90358454413407F] = self.teamprogress[_id_F90358454413407F] - _id_3777ECE6A73EADA5;
      _id_159B97BD7931576C = 0;

      if(isDefined(self._id_AE9B09D28693B763)) {
        _id_9D549FF24E2F8C80 = self.usetime * (self._id_AE9B09D28693B763 / level._id_DA41C55843E26237);

        if(self.teamprogress[_id_F90358454413407F] < _id_9D549FF24E2F8C80) {
          self.teamprogress[_id_F90358454413407F] = _id_9D549FF24E2F8C80;
          _id_159B97BD7931576C = 1;
        }
      }

      _id_3777ECE6A73EADA5 = 0;
      self.curprogress = self.teamprogress[_id_F90358454413407F];
      scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
      scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, _id_F90358454413407F);
      scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);

      if(!_id_159B97BD7931576C) {
        scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_CLEARING_CAPS");

        if(isDefined(self._id_AE9B09D28693B763))
          scripts\mp\objidpoolmanager::update_objective_setenemylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_LOSING_CAPS");
        else {
          foreach(player in scripts\cp\cp_outline_utility::getteamdata(team, "players")) {
            if(numtouching > 0 && _id_65218754A3CA92DB > 0) {
              player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 3);
              continue;
            }

            if(istrue(self._id_823C5A7BF6A0E64A) && istrue(self._id_11D80259A066AB76) && self.ownerteam != team) {
              player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, "MP_INGAME_ONLY/OBJ_PUSHING_CAPS");
              continue;
            }

            player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, "MP_INGAME_ONLY/OBJ_CLEARING_CAPS");
          }

          if(numtouching > 0 && _id_65218754A3CA92DB > 0) {
            foreach(player in scripts\cp\cp_outline_utility::getteamdata(_id_F90358454413407F, "players"))
            player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 3);
          }
        }
      }
    }
  }

  if(self.curprogress <= 0) {
    foreach(_id_AC0E424AC96A7113 in self.touchlist[self.ownerteam]) {
      if(isDefined(self.stompprogressreward))
        [[self.stompprogressreward]](_id_AC0E424AC96A7113.player);
    }

    if(isDefined(self._id_DBEE3CF9CC42CF08))
      [[self._id_DBEE3CF9CC42CF08]](team);

    self._id_B276B0D8CBBD0480 = undefined;
    self.lastprogressteam = undefined;
  }
}

useobjectdecay(team) {
  if(getcapturebehavior() != "normal" && scripts\cp\utility::getgametype() != "arm") {
    return;
  }
  level endon("game_ended");
  self endon("deleted");
  self notify("useObjectDecay");
  self endon("useObjectDecay");
  _id_816A8B5FC977CF64 = 0;

  for(;;) {
    waitframe();
    objid = self.objidnum;

    if(self.stalemate)
      _id_816A8B5FC977CF64 = 0;

    if(self.claimteam == "none") {
      if(self.usetime) {
        if(!self.stalemate) {
          if(istrue(self.decaygraceperiod) && _id_816A8B5FC977CF64 < self.decaygraceperiod) {
            _id_816A8B5FC977CF64 = _id_816A8B5FC977CF64 + level.framedurationseconds;
            continue;
          }

          if(isDefined(self.permcapturethresholds)) {
            if(!isDefined(self.decaythreshold))
              self.decaythreshold = 0.0;

            progress = self.curprogress / self.usetime;

            foreach(frac in self.permcapturethresholds) {
              if(progress >= frac && frac > self.decaythreshold)
                self.decaythreshold = frac;
            }

            if(!isDefined(self.decayrate))
              self.decayrate = self.usetime * 0.025 * level.framedurationseconds;

            if(progress > self.decaythreshold)
              self.curprogress = self.curprogress - self.decayrate;
          } else {
            if(!isDefined(self.decayrate))
              self.decayrate = 0.1 * level.frameduration;

            self.curprogress = self.curprogress - self.decayrate;
          }
        }

        self.teamprogress[team] = self.curprogress;
      }

      if(self.teamprogress[team] <= 0) {
        self.curprogress = 0;
        self.teamprogress[team] = self.curprogress;
        self.lastprogressteam = undefined;
        scripts\mp\objidpoolmanager::objective_show_progress(objid, 0);

        if(isDefined(self._id_FF5925101700484B))
          [[self._id_FF5925101700484B]]("none");

        break;
      }

      scripts\cp\cp_hostmigration::waittillhostmigrationdone();

      if(isDefined(self.objidnum)) {
        if(isDefined(self.overrideprogressteam)) {
          progress = self.teamprogress[self.overrideprogressteam] / self.usetime;
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);
        } else if(isDefined(self.lastprogressteam)) {
          progress = self.teamprogress[self.lastprogressteam] / self.usetime;
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);
        } else {
          progress = self.teamprogress[self.lastclaimteam] / self.usetime;
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);
        }
      }
    }
  }
}

canclaim(player) {
  if(isDefined(self.carrier))
    return 0;

  if(self.cancontestclaim) {
    numtouching = getnumtouchingforteam(player.pers["team"]);
    _id_65218754A3CA92DB = getnumtouchingexceptteam(player.pers["team"]);

    if(numtouching && !_id_65218754A3CA92DB || numtouching && _id_65218754A3CA92DB && numtouching != _id_65218754A3CA92DB) {
      if(_id_65218754A3CA92DB && istrue(level._id_5D1135235E7DB3B3)) {
        self.stalemate = 1;
        self.majoritycapprogress = 0;
        self.wasmajoritycapprogress = 1;
        return 0;
      }

      self.majoritycapprogress = 1;
      self.wasmajoritycapprogress = 0;
      return 1;
    }

    if(numtouching && _id_65218754A3CA92DB && numtouching == _id_65218754A3CA92DB) {
      self.stalemate = 1;
      self.majoritycapprogress = 0;
      self.wasmajoritycapprogress = 1;
      return 0;
    }
  }

  if(!isDefined(self.keyobject))
    return 1;

  if(isDefined(self.nocarryobject)) {
    if(checkobjectiskeyobject(player))
      return 1;
  }

  if(isDefined(player.carryobject)) {
    if(checkplayercarrykeyobject(player))
      return 1;
  }

  return 0;
}

proxtriggerthink() {
  level endon("game_ended");
  self endon("deleted");
  entitynumber = self.entnum;

  for(;;) {
    self.trigger waittill("trigger", ent);

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !isDefined(ent.streakinfo) && scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_instanceisregistered(ent)) {
      occupants = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(ent);

      foreach(_id_F85572CD5F6117C6 in occupants) {
        if(_id_42430BCB47389F23(_id_F85572CD5F6117C6, 1))
          _id_16B7EFBA471CBE36(_id_F85572CD5F6117C6, entitynumber);
      }
    }

    if(_id_42430BCB47389F23(ent))
      _id_16B7EFBA471CBE36(ent, entitynumber);
  }
}

_id_42430BCB47389F23(player, _id_372A5049B4C8B20A) {
  if(!scripts\cp\utility\player::isreallyalive(player))
    return 0;

  if(istrue(self.trigger.trigger_off))
    return 0;

  if(isagent(player) && (!isDefined(player.team) || !isDefined(self.numtouching[player.team])))
    return 0;

  if(!scripts\cp_mp\utility\game_utility::isgameparticipant(player))
    return 0;

  if(isDefined(self.carrier))
    return 0;

  if(isDefined(player.classname) && player.classname == "script_vehicle")
    return 0;

  if(!isDefined(player.initialized_gameobject_vars))
    return 0;

  if(isDefined(self.usecondition)) {
    if(!self[[self.usecondition]](player))
      return 0;
  }

  _id_EDD687A0AB26D9F0 = getrelativeteam(player.pers["team"]);

  if(isDefined(self.teamusetimes[_id_EDD687A0AB26D9F0]) && self.teamusetimes[_id_EDD687A0AB26D9F0] < 0)
    return 0;

  if(istrue(_id_372A5049B4C8B20A) && getdvarint("dvar_7D0A246E9851CE94", 1) == 1 && !ispointinvolume(player.origin, self.trigger))
    return 0;

  return 1;
}

_id_16B7EFBA471CBE36(player, entitynumber) {
  if(scripts\cp\utility\player::isreallyalive(player) && !isDefined(player.touchtriggers[entitynumber])) {
    team = player.pers["team"];
    self.numtouching[team]++;
    _id_597108FD5F20988F = player.guid;
    struct = spawnStruct();
    struct.player = player;
    struct.starttime = gettime();
    self.touchlist[team][_id_597108FD5F20988F] = struct;

    if(isDefined(self.assisttouchlist)) {
      if(!isDefined(self.assisttouchlist[team][_id_597108FD5F20988F]))
        self.assisttouchlist[team][_id_597108FD5F20988F] = struct;
    }
  }

  if(self.cancontestclaim) {
    numtouching = getnumtouchingforteam(player.pers["team"]);
    _id_65218754A3CA92DB = getnumtouchingexceptteam(player.pers["team"]);

    if(numtouching && !_id_65218754A3CA92DB || numtouching && _id_65218754A3CA92DB && numtouching != _id_65218754A3CA92DB) {
      self.majoritycapprogress = 1;
      self.isunoccupied = 0;
    }
  }

  if(self.claimteam == "none" || !istrue(self.allowcapture) || istrue(self.majoritycapprogress)) {
    if(caninteractwith(player.pers["team"], player)) {
      if(canclaim(player)) {
        if(!proxtriggerlos(player)) {
          return;
        }
        if(istrue(self.majoritycapprogress)) {
          if(isDefined(self.mostnumtouching) && isDefined(self.mostnumtouchingteam)) {
            if(!istrue(self._id_88806E65C3197677) || self.mostnumtouchingteam != self.ownerteam) {
              setclaimteam(self.mostnumtouchingteam);
              claimplayer = getearliestclaimplayer();
              self.claimplayer = claimplayer;
            }
          }
        } else {
          setclaimteam(player.pers["team"]);
          self.claimplayer = player;
        }

        _id_EDD687A0AB26D9F0 = getrelativeteam(player.pers["team"]);

        if(isDefined(self.teamusetimes[_id_EDD687A0AB26D9F0]))
          self.usetime = self.teamusetimes[_id_EDD687A0AB26D9F0];

        self.allowcapture = 1;

        if(isDefined(self.numtouchrequired) && self.numtouchrequired > self.numtouching[self.claimteam])
          self.allowcapture = 0;

        if(self.usetime && isDefined(self.onbeginuse) && self.allowcapture && self.ownerteam != self.claimteam) {
          self.isunoccupied = 0;
          _id_E7F80702E259E98A = 1;

          if(_id_E7F80702E259E98A) {
            if(!istrue(self._id_2DDA7CAA18DDD5F8) && isDefined(self.claimplayer)) {
              self[[self.onbeginuse]](self.claimplayer);
              self._id_2DDA7CAA18DDD5F8 = 1;
            }
          } else if(isDefined(self.claimplayer)) {
            if(isDefined(self.didstatusnotify) && !self.didstatusnotify)
              self[[self.onbeginuse]](self.claimplayer);
            else if(!isDefined(self.didstatusnotify))
              self[[self.onbeginuse]](self.claimplayer);
          }
        }
      } else if(isDefined(self.oncantuse))
        self[[self.oncantuse]](player);
    }
  }

  if(scripts\cp\utility\player::isreallyalive(player) && !isDefined(player.touchtriggers[entitynumber]))
    player thread triggertouchthink(self);
}

proxtriggerlos(player) {
  if(!isDefined(self.requireslos))
    return 1;

  tracestart = player getEye();
  contentoverride = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 1, 0);
  ignoreents = [];

  if(scripts\cp\utility::getgametype() == "tdef" || istrue(level.devball)) {
    _id_8B39E5984DA1FFAF = self.trigger.origin + (0, 0, 16);
    _id_6C31025C58CD1AD8 = 0;
    ignoreents[0] = self.visuals[0];
  } else if(scripts\cp\utility::getgametype() == "ball" || istrue(level.debughostagegame)) {
    _id_8B39E5984DA1FFAF = self.trigger.origin + (0, 0, 8);
    _id_6C31025C58CD1AD8 = 0;
    ignoreents[0] = self.visuals[0];
  } else {
    _id_8B39E5984DA1FFAF = self.trigger.origin + (0, 0, 32);
    _id_6C31025C58CD1AD8 = 1;

    if(isarray(self.visuals))
      ignoreents[0] = self.visuals[0];
    else
      ignoreents[0] = self.visuals;
  }

  ignoreents[1] = self.carrier;
  trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride, 0);

  if(trace["fraction"] != 1 && _id_6C31025C58CD1AD8) {
    _id_8B39E5984DA1FFAF = self.trigger.origin + (0, 0, 16);
    trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride, 0);
  }

  if(trace["fraction"] != 1) {
    _id_8B39E5984DA1FFAF = self.trigger.origin + (0, 0, 0);
    trace = scripts\engine\trace::ray_trace(tracestart, _id_8B39E5984DA1FFAF, ignoreents, contentoverride, 0);
  }

  return trace["fraction"] == 1;
}

setclaimteam(_id_EB06B338608EF354) {
  if(getcapturebehavior() == "normal") {
    if(!isDefined(self.claimgracetime))
      self.claimgracetime = 1000;

    if(!istrue(self.ignorestomp) && scripts\cp\utility::isgameplayteam(_id_EB06B338608EF354)) {
      if(self.lastclaimteam != "none") {
        if(!isDefined(self.lastprogressteam))
          self.lastprogressteam = self.lastclaimteam;
      }
    }
  }

  self.lastclaimteam = self.claimteam;
  self.lastclaimtime = gettime();
  self.claimteam = _id_EB06B338608EF354;
  scripts\mp\objidpoolmanager::_id_9B1A086F348520B0(self.objidnum, self.claimteam);
  updateuserate();
}

getclaimteam() {
  return self.claimteam;
}

getlastclaimteam() {
  return self.lastclaimteam;
}

triggertouchthink(object) {
  team = self.pers["team"];
  guid = self.guid;

  if(object _id_9A19CCF8DC6C3CAF()) {
    scripts\mp\objidpoolmanager::objective_pin_player(object.objidnum, self);
    self.pinnedobjid = object.objidnum;

    if(isDefined(object.onpinnedstate))
      object[[object.onpinnedstate]](self);
  } else if(object _id_DC06030CEB03363B()) {
    scripts\mp\objidpoolmanager::objective_pin_player(object.trigger.objidnum, self);
    self.pinnedobjid = object.trigger.objidnum;

    if(isDefined(object.onpinnedstate))
      object[[object.onpinnedstate]](self);
  }

  if(!isDefined(self.touchinggameobjects))
    self.touchinggameobjects = [];

  _id_9D22374A99144826 = object.trigger getentitynumber();
  self.touchinggameobjects[_id_9D22374A99144826] = object;

  if(!isDefined(object.nousebar))
    object.nousebar = 0;

  self.touchtriggers[object.entnum] = object.trigger;
  object updateuserate();

  while(scripts\cp\utility\player::isreallyalive(self) && isDefined(object.trigger) && (self istouching(object.trigger) || isDefined(self.vehicle) && self.vehicle istouching(object.trigger)) && !level.gameended) {
    if(isDefined(object.checkinteractteam) && object.team != team) {
      break;
    }

    if(istrue(self.inlaststand)) {
      break;
    }

    if(isDefined(object.interactsquads) && !isDefined(object.interactsquads[self.team]) || isDefined(object.interactsquads) && !scripts\engine\utility::array_contains(object.interactsquads[self.team], self._id_0FF97225579DE16A)) {
      break;
    }

    if(istrue(object.trigger.trigger_off)) {
      break;
    }

    if(istrue(object.checkuseconditioninthink) && isDefined(object.usecondition) && !object[[object.usecondition]](self)) {
      break;
    }

    if(object _id_9A19CCF8DC6C3CAF() && !scripts\cp\utility\player::isusingremote() && istrue(self.remoteunpinned)) {
      scripts\mp\objidpoolmanager::objective_pin_player(object.objidnum, self);
      self.remoteunpinned = undefined;
    } else if(object _id_DC06030CEB03363B() && !scripts\cp\utility\player::isusingremote() && istrue(self.remoteunpinned)) {
      scripts\mp\objidpoolmanager::objective_pin_player(object.objidnum, self);
      self.remoteunpinned = undefined;
    }

    if((isPlayer(self) || isagent(self) && istrue(self._id_599B158D152C358D)) && object.usetime > 50)
      updateuiprogress(object, 1);

    waitframe();
  }

  if(isDefined(self)) {
    if(object.usetime > 50) {
      if(isPlayer(self) || isagent(self) && istrue(self._id_599B158D152C358D))
        updateuiprogress(object, 0);

      if(isDefined(self.touchtriggers))
        self.touchtriggers[object.entnum] = undefined;
    } else if(isDefined(self.touchtriggers))
      self.touchtriggers[object.entnum] = undefined;

    if(isDefined(self.touchtriggers))
      self.touchinggameobjects[_id_9D22374A99144826] = undefined;
  }

  if(level.gameended) {
    return;
  }
  object.oldtouchlist = object.touchlist;

  if(isDefined(self))
    object.touchlist[team][guid] = undefined;
  else {
    _id_B05A747EA1537870 = [];

    foreach(guid, _id_76FF2376B27F4085 in object.touchlist[team]) {
      if(!isDefined(_id_76FF2376B27F4085.player) || !isalive(_id_76FF2376B27F4085.player))
        _id_B05A747EA1537870[_id_B05A747EA1537870.size] = guid;
    }

    foreach(guid in _id_B05A747EA1537870)
    object.touchlist[team][guid] = undefined;
  }

  if(isDefined(self) && isDefined(object.trigger) && isDefined(object.trigger.objidnum)) {
    scripts\mp\objidpoolmanager::objective_unpin_player(object.trigger.objidnum, self);
    self.pinnedobjid = undefined;

    if(object.lastclaimteam == "none") {
      if(isDefined(object.capturebehavior) && object.capturebehavior == "persistent")
        scripts\mp\objidpoolmanager::objective_show_progress(object.trigger.objidnum, 0);
    }
  }

  if(isDefined(self) && isDefined(object.objidnum)) {
    scripts\mp\objidpoolmanager::objective_unpin_player(object.objidnum, self, object.showoncompass);
    self.pinnedobjid = undefined;

    if(object.lastclaimteam == "none") {
      if(isDefined(object.capturebehavior) && object.capturebehavior == "persistent")
        scripts\mp\objidpoolmanager::objective_show_progress(object.objidnum, 0);
    }
  }

  object.numtouching[team]--;
  object updateuserate();

  if(isDefined(object.onunpinnedstate))
    object[[object.onunpinnedstate]](self);
}

migrationcapturereset(player) {
  player.migrationcapturereset = 1;
  level waittill("host_migration_begin");

  if(!isDefined(player) || !isDefined(self)) {
    return;
  }
  player setclientomnvar("ui_securing", 0);
  player setclientomnvar("ui_securing_progress", 0);
  self.migrationcapturereset = undefined;
}

getnumtouchingforteam(team) {
  numtouching = self.numtouching[team];
  _id_CE6EC2D4FA13CA16 = 0;
  _id_AF55F1216012EDE0 = numtouching;

  foreach(struct in self.touchlist[team]) {
    if(!isDefined(struct.player)) {
      continue;
    }
    if(!isalive(struct.player)) {
      continue;
    }
    if(struct.player.pers["team"] != team) {
      continue;
    }
    if(isagent(struct.player) && !istrue(struct.player._id_599B158D152C358D))
      _id_CE6EC2D4FA13CA16 = _id_CE6EC2D4FA13CA16 + 1;
  }

  _id_AF55F1216012EDE0 = _id_AF55F1216012EDE0 - _id_CE6EC2D4FA13CA16;

  if(_id_AF55F1216012EDE0 == 0)
    self._id_15770AE4F644E96D = 1;
  else {
    numtouching = _id_AF55F1216012EDE0;
    self._id_15770AE4F644E96D = 0;
  }

  return numtouching;
}

getnumtouchingexceptteam(_id_21AEBAA767023F1E) {
  numtouching = 0;
  _id_E7AD7F306D72799C = 0;
  self.mostnumtouching = 0;
  self.mostnumtouchingteam = "none";

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_E7AD7F306D72799C = _id_E7AD7F306D72799C + self.numtouching[_id_F90358454413407F];

    if(_id_E7AD7F306D72799C > 0 && _id_E7AD7F306D72799C > self.mostnumtouching) {
      self.mostnumtouching = _id_E7AD7F306D72799C;
      self.mostnumtouchingteam = _id_F90358454413407F;
      _id_E7AD7F306D72799C = 0;
    }

    if(_id_F90358454413407F != _id_21AEBAA767023F1E)
      numtouching = numtouching + self.numtouching[_id_F90358454413407F];
  }

  return numtouching;
}

updateuiprogress(object, _id_9828F1535ACBC937, _id_03ABA92EB548E3F1) {
  if(!isDefined(level.hostmigrationtimer)) {
    _id_E44D265BACCD0E6C = scripts\engine\utility::ter_op(isDefined(object._id_014D7B0ECC80353B), object._id_014D7B0ECC80353B, &"MP_INGAME_ONLY/OBJ_CONTESTED_CAPS");
    _id_FE62D726A93F1F9B = scripts\engine\utility::ter_op(isDefined(object._id_956F480AF849A6CA), object._id_956F480AF849A6CA, &"MP/GRABBING_FLAG");
    _id_CE9728BAC543FA33 = scripts\engine\utility::ter_op(isDefined(object._id_F526EF46FECF38B2), object._id_F526EF46FECF38B2, &"MP/RETURNING_FLAG");
    _id_1CBDE9E31BD172CB = scripts\engine\utility::ter_op(isDefined(object._id_B2DFB3F0778C829A), object._id_B2DFB3F0778C829A, &"MP_INGAME_ONLY/OBJ_SECURING_CAPS");
    _id_2A63708633BD227B = scripts\engine\utility::ter_op(isDefined(object._id_C767098338453A2A), object._id_C767098338453A2A, &"MP_INGAME_ONLY/OBJ_DESTROYING_CAPS");
    _id_DE151C192E2EC2B1 = scripts\engine\utility::ter_op(isDefined(object._id_66993F4666BFA134), object._id_66993F4666BFA134, &"MP_INGAME_ONLY/NEUTRALIZING");
    _id_F40E023C11CB4137 = scripts\engine\utility::ter_op(isDefined(object._id_BAA644F30ECA9796), object._id_BAA644F30ECA9796, &"MP_INGAME_ONLY/OBJ_DEFENDING_CAPS");
    _id_7C84CA05B5D89121 = scripts\engine\utility::ter_op(isDefined(object._id_A761F33F4834F584), object._id_A761F33F4834F584, &"MP_INGAME_ONLY/OBJ_REINFORCING_CAPS");
    _id_AA979EC1219EA3FB = scripts\engine\utility::ter_op(isDefined(object._id_0B7827C280B90EAA), object._id_0B7827C280B90EAA, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
    _id_1D748649DC019EFC = scripts\engine\utility::ter_op(isDefined(object._id_73D0A540867D306B), object._id_73D0A540867D306B, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS");
    _id_1CB654297B9AFBF3 = scripts\engine\utility::ter_op(isDefined(object._id_FBE10B7E6C62A772), object._id_FBE10B7E6C62A772, &"MP_INGAME_ONLY/OBJ_LOSING_CAPS");

    if(isDefined(object.interactteam) && object.interactteam == "none")
      scripts\mp\objidpoolmanager::_id_160F522B63C32D76(0, undefined, 0);
    else {
      if(!isDefined(_id_03ABA92EB548E3F1))
        _id_03ABA92EB548E3F1 = object;

      objid = undefined;

      if(isDefined(object.objidnum))
        objid = object.objidnum;

      progress = 0;

      if(isDefined(object.teamprogress) && isDefined(object.claimteam)) {
        if(object.teamprogress[object.claimteam] > _id_03ABA92EB548E3F1.usetime)
          object.teamprogress[object.claimteam] = _id_03ABA92EB548E3F1.usetime;

        progress = object.teamprogress[object.claimteam] / _id_03ABA92EB548E3F1.usetime;
      } else {
        if(_id_03ABA92EB548E3F1.curprogress > _id_03ABA92EB548E3F1.usetime)
          _id_03ABA92EB548E3F1.curprogress = _id_03ABA92EB548E3F1.usetime;

        progress = _id_03ABA92EB548E3F1.curprogress / _id_03ABA92EB548E3F1.usetime;

        if(_id_03ABA92EB548E3F1.usetime <= 1000)
          progress = min(progress + 0.05, 1);
        else
          progress = min(progress + 0.01, 1);
      }

      if((scripts\cp\utility::getgametype() == "ctf" || scripts\cp\utility::getgametype() == "tdef" || scripts\cp\utility::getgametype() == "blitz") && !isDefined(object.id)) {
        if(_id_9828F1535ACBC937 && istrue(object.stalemate)) {
          if(!isDefined(self.ui_ctf_stalemate)) {
            if(!isDefined(self.ui_ctf_securing))
              self.ui_ctf_securing = 1;

            scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_E44D265BACCD0E6C, -1);
            self.ui_ctf_stalemate = 1;
          }

          progress = 0.01;
        } else if(_id_9828F1535ACBC937 && isDefined(self.ui_ctf_securing) && isDefined(object.stalemate) && !object.stalemate && object.ownerteam != self.team) {
          scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_FE62D726A93F1F9B, 1);
          self.ui_ctf_securing = 1;
          self.ui_ctf_stalemate = undefined;
        } else if(_id_9828F1535ACBC937 && isDefined(self.ui_ctf_securing) && isDefined(object.stalemate) && !object.stalemate && object.ownerteam == self.team) {
          scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_CE9728BAC543FA33, 2);
          self.ui_ctf_securing = 1;
          self.ui_ctf_stalemate = undefined;
        } else {
          if(!_id_9828F1535ACBC937 && isDefined(self.ui_ctf_stalemate)) {
            scripts\mp\objidpoolmanager::_id_160F522B63C32D76(0, undefined, 0);
            self.ui_ctf_securing = undefined;
          }

          if(_id_9828F1535ACBC937 && !isDefined(self.ui_ctf_stalemate) && object.ownerteam == self.team) {
            scripts\mp\objidpoolmanager::_id_160F522B63C32D76(0, undefined, 0);
            self.ui_ctf_securing = undefined;
          }

          if(_id_9828F1535ACBC937 && !isDefined(self.ui_ctf_securing)) {
            if(object.ownerteam != self.team) {
              scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_FE62D726A93F1F9B, 1);
              self.ui_ctf_securing = 1;
            } else if(object.interactteam == "any") {
              scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_CE9728BAC543FA33, 2);
              self.ui_ctf_securing = 1;
            }
          }

          self.ui_ctf_stalemate = undefined;
        }

        if(!_id_9828F1535ACBC937) {
          progress = 0.01;
          scripts\mp\objidpoolmanager::_id_160F522B63C32D76(0, undefined, 0);
          self.ui_ctf_securing = undefined;
        }

        if(progress != 0) {
          scripts\mp\objidpoolmanager::objective_set_progress_team(objid, self.team);
          scripts\mp\objidpoolmanager::objective_show_progress(objid, 1);
          scripts\mp\objidpoolmanager::objective_set_progress(objid, progress);
        }
      }

      if(hasdomflags() && isDefined(object.id) && (object.id == "domFlag" || object.id == "hardpoint" || object.id == "bomb_site" || object.id == "rugby_jugg")) {
        if(_id_9828F1535ACBC937 && isDefined(object.stalemate) && object.stalemate && !istrue(object.majoritycapprogress))
          scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_E44D265BACCD0E6C, 3);
        else if(_id_9828F1535ACBC937 && (isDefined(object.stalemate) && !object.stalemate && !istrue(object.majoritycapprogress)) && object.ownerteam != self.team) {
          if(scripts\cp\utility::getgametype() == "hq") {
            if(object.ownerteam == "neutral")
              scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_1CBDE9E31BD172CB, 1);
            else
              scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_2A63708633BD227B, 2);
          } else if(istrue(object.neutralizing) && object.ownerteam != self.team && object.ownerteam != "neutral")
            scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_DE151C192E2EC2B1);
          else
            scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_1CBDE9E31BD172CB, 1);
        } else {
          if(!_id_9828F1535ACBC937) {
            if(isDefined(object.overrideprogressteam))
              scripts\mp\objidpoolmanager::objective_set_progress_team(objid, object.overrideprogressteam);
            else if(isDefined(object.lastprogressteam) && object.lastprogressteam != object.claimteam && (object.lastprogressteam != object.ownerteam || istrue(object._id_823C5A7BF6A0E64A)))
              scripts\mp\objidpoolmanager::objective_set_progress_team(objid, object.lastprogressteam);
            else if(object.claimteam != "none")
              scripts\mp\objidpoolmanager::objective_set_progress_team(objid, object.claimteam);

            scripts\mp\objidpoolmanager::_id_160F522B63C32D76(0, undefined, 0);
          } else if(_id_9828F1535ACBC937 && istrue(object.majoritycapprogress) && isDefined(object.lastprogressteam) && object.lastprogressteam == object.claimteam) {
            if(isDefined(object.overrideprogressteam))
              scripts\mp\objidpoolmanager::objective_set_progress_team(objid, object.overrideprogressteam);
            else if(object.ownerteam != "neutral" && object.claimteam == object.ownerteam) {
              if(self.team == object.ownerteam) {}

              scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, undefined, 0);
            } else if(object.claimteam != "none") {
              if(scripts\cp\utility::getgametype() == "hq") {
                if(object.ownerteam == "neutral")
                  scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_1CBDE9E31BD172CB, 1);
                else
                  scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_2A63708633BD227B, 2);
              } else {
                numtouching = object getnumtouchingforteam(object.claimteam);
                _id_65218754A3CA92DB = object getnumtouchingexceptteam(object.claimteam);

                if(istrue(object._id_3BA42E8C18B42C71)) {
                  if(self.team == object.claimteam)
                    scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_AA979EC1219EA3FB, 4);
                  else
                    scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_1D748649DC019EFC, 4);
                } else if(numtouching > 0 && _id_65218754A3CA92DB > 0)
                  scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_E44D265BACCD0E6C, 3);
                else if(istrue(object.neutralizing) && object.ownerteam != self.team && object.ownerteam != "neutral")
                  scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_DE151C192E2EC2B1);
                else if(!istrue(object._id_3BA42E8C18B42C71)) {
                  if(object.ownerteam == self.team)
                    scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_F40E023C11CB4137, 1);
                  else
                    scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_1CBDE9E31BD172CB, 1);
                } else if(isDefined(object._id_97FEB74E7C5669C7))
                  scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, object._id_97FEB74E7C5669C7, 1);
              }

              scripts\mp\objidpoolmanager::objective_set_progress_team(objid, object.claimteam);
            }
          } else if(scripts\cp\utility::getgametype() == "rugby") {
            if(!isDefined(object.claimteam) || object.claimteam == "none") {
              object.numtouching[self.team] = 1;

              if(!isDefined(object.lastclaimteam))
                object.lastclaimteam = "none";

              object setclaimteam(self.pers["team"]);
              object setownerteam(self.pers["team"]);
            }

            if(_id_9828F1535ACBC937) {
              if(object.claimteam != "none") {
                scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_1CBDE9E31BD172CB, 1);
                scripts\mp\objidpoolmanager::objective_set_progress_team(objid, object.claimteam);
                scripts\mp\objidpoolmanager::objective_show_progress(objid, 1);
                scripts\mp\objidpoolmanager::objective_set_progress(object.objidnum, progress);
              }
            } else
              object.claimteam = "none";
          }

          if(_id_9828F1535ACBC937 && object.ownerteam == self.team) {}
        }

        if(scripts\cp\utility::getgametype() != "rush") {
          if(!_id_9828F1535ACBC937 || !object caninteractwith(self.team, self) && (!isDefined(object.stalemate) || isDefined(object.stalemate) && !object.stalemate)) {
            if(_id_03ABA92EB548E3F1.curprogress == 0)
              scripts\mp\objidpoolmanager::objective_show_progress(objid, 0);
          }
        }

        if(progress != 0) {
          if(showspecificteamprogress(object))
            scripts\mp\objidpoolmanager::objective_show_team_progress(objid, object.claimteam);
          else
            scripts\mp\objidpoolmanager::objective_show_progress(objid, 1);

          if(level.teambased && isDefined(object.teamprogress) && isDefined(object.claimteam) && _id_9828F1535ACBC937) {
            if(!object.stalemate) {
              if(isDefined(object.overrideprogressteam)) {
                scripts\mp\objidpoolmanager::objective_set_progress_team(object.objidnum, object.overrideprogressteam);
                scripts\mp\objidpoolmanager::objective_set_progress(object.objidnum, object.teamprogress[object.overrideprogressteam] / _id_03ABA92EB548E3F1.usetime);
              } else {
                scripts\mp\objidpoolmanager::objective_set_progress_team(object.objidnum, object.claimteam);
                scripts\mp\objidpoolmanager::objective_set_progress(object.objidnum, progress);
              }

              if(self.team == object.claimteam) {
                if(scripts\cp\utility::getgametype() == "hq") {
                  if(object.ownerteam == "neutral")
                    scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_1CBDE9E31BD172CB, 1);
                  else
                    scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_2A63708633BD227B, 2);
                } else if(istrue(object.neutralizing) && object.ownerteam != self.team && object.ownerteam != "neutral")
                  scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_DE151C192E2EC2B1);
                else if(!istrue(object._id_3BA42E8C18B42C71)) {
                  if(object.ownerteam == self.team) {
                    if(istrue(object._id_823C5A7BF6A0E64A))
                      scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_7C84CA05B5D89121, 1);
                    else
                      scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_F40E023C11CB4137, 1);
                  } else
                    scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_1CBDE9E31BD172CB, 1);
                } else if(isDefined(object._id_97FEB74E7C5669C7))
                  scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, object._id_97FEB74E7C5669C7, 1);
              } else {
                numtouching = 0;
                _id_65218754A3CA92DB = 0;

                if(object.ownerteam == "neutral" && isDefined(object.claimteam)) {
                  numtouching = object getnumtouchingforteam(object.claimteam);
                  _id_65218754A3CA92DB = object getnumtouchingexceptteam(object.ownerteam);
                } else {
                  numtouching = object getnumtouchingforteam(object.ownerteam);
                  _id_65218754A3CA92DB = object getnumtouchingexceptteam(object.ownerteam);
                }

                if(istrue(object._id_3BA42E8C18B42C71)) {
                  if(self.team == object.claimteam)
                    scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_AA979EC1219EA3FB, 4);
                  else
                    scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_1D748649DC019EFC, 4);
                } else if(numtouching > 0 && _id_65218754A3CA92DB > 0)
                  scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_E44D265BACCD0E6C, 3);
                else
                  scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_1CB654297B9AFBF3, 5);
              }
            } else if(object.stalemate && istrue(object.majoritycapprogress)) {
              scripts\mp\objidpoolmanager::objective_set_progress_team(object.objidnum, object.claimteam);
              scripts\mp\objidpoolmanager::objective_set_progress(object.objidnum, progress);

              if(self.team == object.claimteam) {
                if(scripts\cp\utility::getgametype() == "hq") {
                  if(object.ownerteam == "neutral")
                    scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_1CBDE9E31BD172CB, 1);
                  else
                    scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_2A63708633BD227B, 2);
                } else if(istrue(object.neutralizing) && object.ownerteam != self.team && object.ownerteam != "neutral")
                  scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_DE151C192E2EC2B1, 6);
                else
                  scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_1CBDE9E31BD172CB, 1);
              } else
                scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_1CB654297B9AFBF3, 5);
            } else
              scripts\mp\objidpoolmanager::objective_set_progress_team(objid, undefined);
          } else if(!level.teambased)
            scripts\mp\objidpoolmanager::objective_set_progress_client(objid, self);
        } else if(isDefined(object.teamprogress) && isDefined(object.claimteam)) {
          foreach(_id_6FA664D6C4F6967B, progress in object.teamprogress) {
            if(isDefined(self.team) && !object.stalemate && istrue(object.majoritycapprogress)) {
              if(self.team == _id_6FA664D6C4F6967B && progress > 0)
                scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_1CB654297B9AFBF3, 5);
              else if(self.team == object.ownerteam && progress == 0) {
                if(istrue(object._id_B276B0D8CBBD0480))
                  scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, undefined, 0);
                else if(istrue(object._id_823C5A7BF6A0E64A))
                  scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_7C84CA05B5D89121, 5);
                else
                  scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, _id_F40E023C11CB4137, 5);
              }

              break;
            }
          }
        }
      } else {
        if(isbombmode() && isDefined(object.id) && (object.id == "bomb_zone" || object.id == "defuse_object")) {
          if(isDefined(self)) {
            if(_id_9828F1535ACBC937 && isDefined(self)) {
              if(!isDefined(self.ui_bomb_planting_defusing)) {
                _id_FE8F7703F6313ED4 = 0;

                if(object.id == "bomb_zone")
                  _id_FE8F7703F6313ED4 = 1;
                else if(object.id == "defuse_object")
                  _id_FE8F7703F6313ED4 = 2;

                self.ui_bomb_planting_defusing = 1;
              }
            } else {
              self.ui_bomb_planting_defusing = undefined;

              if(!isDefined(object.resetprogress) || istrue(object.resetprogress))
                progress = 0.01;
            }

            if(progress != 0) {
              if(!isDefined(object.showprogressforteam)) {
                scripts\mp\objidpoolmanager::objective_set_progress_team(objid, self.team);
                scripts\mp\objidpoolmanager::objective_show_team_progress(objid, self.team);
                object.showprogressforteam = self.team;
              } else if(object.showprogressforteam != self.team) {
                scripts\mp\objidpoolmanager::objective_hide_team_progress(objid, object.showprogressforteam);
                scripts\mp\objidpoolmanager::objective_set_progress_team(objid, self.team);
                scripts\mp\objidpoolmanager::objective_show_team_progress(objid, self.team);
                object.showprogressforteam = self.team;
              }

              scripts\mp\objidpoolmanager::objective_set_progress(objid, progress);
              setomnvar("ui_bomb_progress", progress);
              return;
            }

            return;
          }

          return;
        }

        if(isDefined(object.id)) {
          _id_FE8F7703F6313ED4 = 0;

          switch (object.id) {
            case "care_package":
            case "bradley":
              _id_FE8F7703F6313ED4 = 1;
              break;
            case "intel":
              _id_FE8F7703F6313ED4 = 2;
              break;
            case "support_box":
              _id_FE8F7703F6313ED4 = 3;
              break;
            case "deployable_weapon_crate":
              _id_FE8F7703F6313ED4 = 4;
              break;
            case "laststand_reviver":
              _id_FE8F7703F6313ED4 = 5;
              break;
            case "laststand_revivee":
              _id_FE8F7703F6313ED4 = 6;
              break;
            case "breach":
              _id_FE8F7703F6313ED4 = 7;
              break;
            case "use":
              _id_FE8F7703F6313ED4 = 8;
              break;
            case "breach_defuse":
              _id_FE8F7703F6313ED4 = 9;
              break;
            case "bounty":
              _id_FE8F7703F6313ED4 = 10;
              break;
            case "hack":
              _id_FE8F7703F6313ED4 = 13;
              break;
            case "hvt_search":
              _id_FE8F7703F6313ED4 = 15;
              break;
            case "laststand_interrogator":
              _id_FE8F7703F6313ED4 = 19;
              break;
            case "elite_arrow_arm":
              _id_FE8F7703F6313ED4 = 21;
              break;
            case "elite_arrow_fuse":
              _id_FE8F7703F6313ED4 = 22;
              break;
            case "plea_for_help_looting":
              _id_FE8F7703F6313ED4 = 23;
              break;
            case "weapon_trade":
              _id_FE8F7703F6313ED4 = 24;
              break;
            case "scanning_code":
              _id_FE8F7703F6313ED4 = 25;
              break;
          }

          updateuisecuring(progress, _id_9828F1535ACBC937, _id_FE8F7703F6313ED4, object, _id_03ABA92EB548E3F1.usetime, _id_03ABA92EB548E3F1);
        }
      }
    }
  }
}

showspecificteamprogress(object) {
  switch (scripts\cp\utility::getgametype()) {
    case "vip":
      if(object.claimteam == game["attackers"])
        return 1;
  }

  return 0;
}

hasdomflags() {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return 1;

  _id_C8F4C582625F492D = _func_1823FF50BB28148D(scripts\cp\utility::getgametype());

  if(_id_C8F4C582625F492D == "stat_6A87626330D9D40E")
    return 1;

  switch (scripts\cp\utility::getgametype()) {
    case "grnd":
    case "grind":
    case "dom":
    case "hq":
    case "mtmc":
    case "rugby":
    case "btm":
    case "rush":
    case "arena":
    case "cmd":
    case "koth":
    case "siege":
    case "control":
    case "gwai":
    case "risk":
    case "pill":
    case "defcon":
    case "arm":
      return 1;
    default:
      return 0;
  }

  return 0;
}

updateuisecuring(progress, _id_9828F1535ACBC937, _id_FE8F7703F6313ED4, object, usetime, _id_03ABA92EB548E3F1) {
  objid = undefined;

  if(!isDefined(_id_03ABA92EB548E3F1))
    _id_03ABA92EB548E3F1 = object;

  if(_id_9828F1535ACBC937) {
    if(!isDefined(object.usedby))
      object.usedby = [];

    if(!isDefined(self.migrationcapturereset))
      object thread migrationcapturereset(self);

    if(!existinarray(self, object.usedby))
      object.usedby[object.usedby.size] = self;

    if(!isDefined(self.ui_securing)) {
      self setclientomnvar("ui_securing", _id_FE8F7703F6313ED4);
      self.ui_securing = 1;

      if(isDefined(object) && object isrevivetrigger()) {
        if(isDefined(object.owner)) {
          object.owner setclientomnvar("ui_reviver_id", self getentitynumber());
          object.owner setclientomnvar("ui_securing", 6);
        }
      }
    }

    if(object.id == "laststand_reviver") {
      _id_22F7E3F7E360775B = undefined;

      if(isDefined(object) && object isrevivetrigger())
        _id_22F7E3F7E360775B = object.owner;

      if(isDefined(_id_22F7E3F7E360775B) && self == _id_22F7E3F7E360775B)
        self setclientomnvar("ui_securing", 16);
    } else if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && object.id == "laststand_interrogator") {
      _id_5BEBD2013B0F01EC = undefined;

      if(isDefined(object) && object _id_AB8D64FE065BF6F7())
        _id_5BEBD2013B0F01EC = object.owner;

      if(isDefined(_id_5BEBD2013B0F01EC) && self != _id_5BEBD2013B0F01EC)
        _id_5BEBD2013B0F01EC setclientomnvar("ui_securing", 19);
    }
  } else {
    if(isDefined(object.usedby) && existinarray(self, object.usedby))
      object.usedby = scripts\engine\utility::array_remove(object.usedby, self);

    self setclientomnvar("ui_securing", 0);
    self.ui_securing = undefined;

    if(isDefined(object) && object isrevivetrigger()) {
      if(isDefined(object.owner)) {
        object.owner setclientomnvar("ui_reviver_id", -1);
        object.owner setclientomnvar("ui_securing", 0);
      }
    }

    progress = 0.01;

    if(isDefined(object.objidnum))
      objid = object.objidnum;
  }

  if(usetime == 500)
    progress = min(progress + 0.15, 1);

  if(progress != 0) {
    if(_id_03ABA92EB548E3F1.curprogress > 0)
      progress = min(_id_03ABA92EB548E3F1.curprogress / _id_03ABA92EB548E3F1.usetime, 1);

    if(isDefined(object) && (object isrevivetrigger() || object _id_AB8D64FE065BF6F7() || object _id_693C0C5A3D8E214E())) {
      if(isDefined(object.owner)) {
        object.owner setclientomnvar("ui_securing_progress", progress);

        if(istrue(self._id_93018D510A589832))
          self setclientomnvar("ui_securing_progress", progress);

        if(isDefined(object.owner.reviver) && istrue(object.owner.reviver == self)) {}
      }
    } else
      self setclientomnvar("ui_securing_progress", progress);

    if(isDefined(object.objidnum))
      scripts\mp\objidpoolmanager::objective_set_progress(object.objidnum, progress);
  }
}

existinarray(ent, array) {
  if(array.size > 0) {
    foreach(entity in array) {
      if(entity == ent)
        return 1;
    }
  }

  return 0;
}

updateuserate() {
  if(self.claimteam == "none" && self.ownerteam != "neutral" && self.ownerteam != "any")
    team = self.ownerteam;
  else
    team = self.claimteam;

  _id_672A08AAEFB8DE3B = self.numtouching[team];
  _id_6C3B950F29AB2EF3 = 0;
  _id_65218754A3CA92DB = 0;
  _id_3C3D61129F8F8827 = 0;
  _id_CC0DA48E9A204A66 = 0;

  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    if(team != _id_FABF84450735DD93) {
      foreach(struct in self.touchlist[_id_FABF84450735DD93]) {
        if(!isDefined(struct.player)) {
          continue;
        }
        if(!isalive(struct.player)) {
          continue;
        }
        if(struct.player.pers["team"] != _id_FABF84450735DD93) {
          continue;
        }
        if(isagent(struct.player) && !istrue(struct.player._id_599B158D152C358D))
          _id_3C3D61129F8F8827 = _id_3C3D61129F8F8827 + 1;
      }

      _id_65218754A3CA92DB = _id_65218754A3CA92DB + self.numtouching[_id_FABF84450735DD93];
      continue;
    }

    foreach(struct in self.touchlist[team]) {
      if(!isDefined(struct.player)) {
        continue;
      }
      if(!isalive(struct.player)) {
        continue;
      }
      if(struct.player.pers["team"] != team) {
        continue;
      }
      if(isagent(struct.player) && !istrue(struct.player._id_599B158D152C358D))
        _id_6C3B950F29AB2EF3 = _id_6C3B950F29AB2EF3 + 1;

      if(struct.player.objectivescaler == 1) {
        continue;
      }
      _id_672A08AAEFB8DE3B = _id_672A08AAEFB8DE3B * struct.player.objectivescaler;
      _id_CC0DA48E9A204A66 = struct.player.objectivescaler;
    }
  }

  _id_4D9BD2CD1CE666EE = _id_65218754A3CA92DB - _id_3C3D61129F8F8827;

  if(_id_4D9BD2CD1CE666EE != _id_65218754A3CA92DB) {
    if(_id_4D9BD2CD1CE666EE == 0)
      _id_4D9BD2CD1CE666EE = _id_65218754A3CA92DB;
    else if(_id_65218754A3CA92DB > _id_672A08AAEFB8DE3B)
      _id_4D9BD2CD1CE666EE = max(_id_4D9BD2CD1CE666EE, _id_672A08AAEFB8DE3B);
  }

  _id_EA2744AFC870C5CE = _id_672A08AAEFB8DE3B - _id_6C3B950F29AB2EF3;

  if(_id_EA2744AFC870C5CE != _id_672A08AAEFB8DE3B) {
    if(_id_EA2744AFC870C5CE == 0)
      _id_EA2744AFC870C5CE = _id_672A08AAEFB8DE3B;
    else if(_id_672A08AAEFB8DE3B > _id_65218754A3CA92DB)
      _id_EA2744AFC870C5CE = max(_id_EA2744AFC870C5CE, _id_65218754A3CA92DB);
  }

  self.stalemate = scripts\engine\utility::ter_op(istrue(self.alwaysstalemate), _id_EA2744AFC870C5CE && _id_4D9BD2CD1CE666EE, _id_EA2744AFC870C5CE && _id_4D9BD2CD1CE666EE && _id_EA2744AFC870C5CE == _id_4D9BD2CD1CE666EE);

  if(getcapturebehavior() == "all_teams_dom_together")
    self.stalemate = 0;

  if(!_id_672A08AAEFB8DE3B && !_id_65218754A3CA92DB)
    self.majoritycapprogress = 0;

  if(!self.stalemate && istrue(self.wasstalemate) && _id_672A08AAEFB8DE3B > _id_65218754A3CA92DB)
    self.majoritycapprogress = 1;

  if(isDefined(self.triggertype) && self.triggertype == "use") {} else
    self.userate = 0;

  _id_672A08AAEFB8DE3B = _id_672A08AAEFB8DE3B - _id_6C3B950F29AB2EF3;

  if(_id_672A08AAEFB8DE3B) {
    if(_id_672A08AAEFB8DE3B > _id_65218754A3CA92DB) {
      self.userate = min(_id_672A08AAEFB8DE3B - _id_65218754A3CA92DB, scripts\engine\utility::ter_op(isDefined(level.objectivescaler), level.objectivescaler, 4));

      if(self.userate > 1.0)
        self.userate = self.userate * self.useratemultiplier;
    }
  }

  if(isDefined(self.isarena) && self.isarena && _id_CC0DA48E9A204A66 != 0)
    self.userate = 1 * _id_CC0DA48E9A204A66;
  else if(isDefined(self.isarena) && self.isarena)
    self.userate = 1;
}

useholdthink(player) {
  self endon("deleted");
  player notify("use_hold");

  if(self.exclusiveuse)
    player clientclaimtrigger(self.trigger);

  if(!istrue(self._id_2EFB40714A6E9468))
    player allowmovement(0);

  _id_D9842C97BADABA31 = isDefined(self.id) && (self.id == "traversalassist" || self.id == "breach" || self.id == "care_package");

  if(isbombmode()) {
    if(!_id_D9842C97BADABA31 && level.gametype != "cyber") {
      if(istrue(level.silentplant)) {
        player setentitysoundcontext("silent_plant", "on");

        if(istrue(player.isdefusing))
          self.useweapon = makeweapon("briefcase_defuse_silent_mp");
        else
          self.useweapon = makeweapon("briefcase_silent_mp");
      }
    }
  }

  useweapon = self.useweapon;
  lastweapon = player getcurrentweapon();
  isrevivetrigger = isrevivetrigger();

  if(isDefined(useweapon)) {
    _id_4EFC0EF0C515E782 = 0;

    if(lastweapon.basename == "iw9_cyberemp_mp")
      _id_4EFC0EF0C515E782 = 1;

    if(lastweapon == useweapon)
      lastweapon = player.lastnonuseweapon;

    player.lastnonuseweapon = lastweapon;
    _id_D21DAD9EA4D9CC0D = 0;
    _id_2E5C1E9548E8884F = 0;

    if(scripts\cp\utility::getgametype() == "cyber" || isrevivetrigger) {
      _id_D21DAD9EA4D9CC0D = 1;
      _id_2E5C1E9548E8884F = 0;
    }

    player scripts\cp_mp\utility\inventory_utility::_giveweapon(useweapon, undefined, undefined, 0);
    player setweaponammostock(useweapon, _id_D21DAD9EA4D9CC0D);
    player setweaponammoclip(useweapon, _id_D21DAD9EA4D9CC0D);
    player thread switchtouseweapon(useweapon, _id_4EFC0EF0C515E782);
  } else if(!_id_D9842C97BADABA31 && !istrue(self._id_070814AA80E0D3D1)) {
    if(isDefined(self) && isrevivetrigger || isDefined(self.id) && self.id == "rugby_jugg") {
      player.weaponsdisabledwhilereviving = 1;

      if(!level.allowreviveweapons) {
        player thread forceunsetdemeanor(1);
        player _id_3B64EB40368C1450::set("useHold", "sprint", 0);
        player _id_3B64EB40368C1450::set("useHold", "fire", 0);
        player _id_3B64EB40368C1450::set("useHold", "ads", 0);
        player _id_3B64EB40368C1450::set("useHold", "offhand_weapons", 0);
      } else
        player _id_3B64EB40368C1450::_id_3633B947164BE4F3("reviveShoot", 0);
    } else
      player _id_3B64EB40368C1450::set("useHold", "weapon", 0);
  }

  if(!isDefined(player.usinggameobjects))
    player.usinggameobjects = [];

  _id_9D22374A99144826 = undefined;

  if(isDefined(self.index))
    _id_9D22374A99144826 = self.index;
  else
    _id_9D22374A99144826 = self.trigger getentitynumber();

  player.usinggameobjects[_id_9D22374A99144826] = self;

  if(!isDefined(self.resetprogress) || istrue(self.resetprogress))
    self.curprogress = 0;

  self.inuse = 1;
  self.userate = 0;
  result = useholdthinkloop(player, lastweapon);

  if(isDefined(player)) {
    player.usinggameobjects[_id_9D22374A99144826] = undefined;
    player detachusemodels();
    player notify("done_using");
  }

  if(isDefined(useweapon) && isDefined(player)) {
    if(scripts\cp\utility::getgametype() == "cyber" && !isrevivetrigger && !istrue(result)) {
      player setweaponammostock(useweapon, 0);
      player setweaponammoclip(useweapon, 0);
    }

    player _id_56EF8D52FE1B48A1::unstowsuperweapon();

    if(player scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(useweapon)) {
      player scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(useweapon);
      player scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(lastweapon);
    } else {
      if(scripts\cp\utility::getgametype() == "sd") {
        if(!istrue(result)) {
          player setweaponammostock(useweapon, 1);
          player setweaponammoclip(useweapon, 1);
        }
      }

      if(player scripts\cp\utility::isjuggernaut()) {
        _id_ACF2963740B6F292 = player scripts\cp\killstreaks\juggernaut_cp::_id_A869748B27159997();
        player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(_id_ACF2963740B6F292);
        player scripts\cp_mp\utility\inventory_utility::_takeweapon(useweapon);
        player thread _id_6503CA663EB11045();
      } else
        player thread scripts\cp_mp\utility\inventory_utility::getridofweapon(useweapon);
    }
  }

  if(istrue(result)) {
    player allowmovement(1);
    return 1;
  } else if(!istrue(result) && isDefined(self)) {
    if(!isDefined(self.resetprogress) || istrue(self.resetprogress))
      self.curprogress = 0;
    else
      managecurprogress(player);
  }

  if(isDefined(player)) {
    if(!isDefined(useweapon) && !_id_D9842C97BADABA31) {
      if(isDefined(self) && isrevivetrigger || isDefined(self.id) && self.id == "rugby_jugg") {
        if(istrue(player.weaponsdisabledwhilereviving)) {
          player.weaponsdisabledwhilereviving = undefined;

          if(!level.allowreviveweapons)
            player thread forceunsetdemeanor(0);
          else
            player _id_3B64EB40368C1450::_id_588F2307A3040610("reviveShoot");
        }
      }

      player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("useHold");
    }

    player allowmovement(1);
  }

  if(isDefined(self)) {
    self.inuse = 0;

    if(self.exclusiveuse && isDefined(self.trigger))
      self.trigger releaseclaimedtrigger();
  }

  return 0;
}

_id_6503CA663EB11045() {
  self endon("death_or_disconnect");
  self waittill("gameobject_endUse");
  self notify("bomb_allow_offhands");
}

forceunsetdemeanor(_id_E3108E412AFB3811) {
  self endon("death");
  self notify("forceDemeanorSafe");
  self endon("forceDemeanorSafe");

  if(_id_E3108E412AFB3811) {
    while(self issprinting())
      wait 0.5;

    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
  } else {
    result = 0;

    while(!result) {
      result = self setdemeanorviewmodel("normal");
      waitframe();
    }
  }
}

managecurprogress(player) {
  if(!isDefined(self.prevprogress))
    self.prevprogress = 0;

  progress = self.curprogress - self.prevprogress;

  if(progress <= 1000)
    self.curprogress = self.prevprogress;

  _id_FA542857794825BC = self.usetime - self.curprogress;

  if(_id_FA542857794825BC < 1000) {
    if(self.usetime <= 1000)
      self.curprogress = self.usetime;
    else
      self.curprogress = self.usetime - 1000;
  }

  progress = 0;

  if(self.curprogress > 0) {
    if(isDefined(self.teamprogress) && isDefined(self.claimteam)) {
      if(self.teamprogress[self.claimteam] > self.usetime)
        self.teamprogress[self.claimteam] = self.usetime;

      progress = self.teamprogress[self.claimteam] / self.usetime;
    } else {
      if(self.curprogress > self.usetime)
        self.curprogress = self.usetime;

      progress = self.curprogress / self.usetime;

      if(self.usetime <= 1000)
        progress = min(progress + 0.05, 1);
      else
        progress = min(progress + 0.01, 1);
    }
  }

  if(isDefined(self.objidnum)) {
    scripts\mp\objidpoolmanager::objective_set_progress_team(self.objidnum, player.team);
    scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, progress);

    if(self.curprogress > 0)
      scripts\mp\objidpoolmanager::objective_show_team_progress(self.objidnum, player.team);
    else
      scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 0);
  }

  self.prevprogress = self.curprogress;
}

detachusemodels() {
  if(isDefined(self.attachedusemodel)) {
    self detach(self.attachedusemodel, "tag_inhand");
    self.attachedusemodel = undefined;
  }
}

switchtouseweapon(useweapon, _id_4EFC0EF0C515E782, _id_026CA36763FA5B82) {
  _id_56EF8D52FE1B48A1::allowsuperweaponstow();
  _id_41BF9BF4918115AC = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(useweapon, _id_4EFC0EF0C515E782, _id_026CA36763FA5B82);

  if(!istrue(_id_41BF9BF4918115AC)) {
    self notify("bomb_allow_offhands");
    _id_56EF8D52FE1B48A1::unstowsuperweapon();

    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(useweapon))
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(useweapon);
    else
      scripts\cp_mp\utility\inventory_utility::_takeweapon(useweapon);
  }
}

usetest(player, _id_F4B4020BAA4A83E3, _id_DD9707A466EFA528, _id_3DAFA337A7EED569) {
  if(self.curprogress >= self.usetime)
    return 0;

  if(istrue(self._id_C99A7A6AF360DABE))
    return 1;

  if(!scripts\cp\utility\player::isreallyalive(player))
    return 0;

  if(!player _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("usability"))
    return 0;

  if(!isDefined(self.skiptouching) && (isDefined(self.trigger) && !player istouching(self.trigger)))
    return 0;

  if(!level.allowreviveweapons && !player useButtonPressed(1))
    return 0;

  if(player _id_74502A9E0EF1F19C::grenadeinpullback())
    return 0;

  if(player meleeButtonPressed())
    return 0;

  if(player isinexecutionattack())
    return 0;

  if(player isinexecutionvictim())
    return 0;

  _id_EC6EA16813D7DF7D = undefined;

  if(isDefined(self.trigger) && isDefined(self.trigger._id_B9ABE6BDF97E9A79))
    _id_EC6EA16813D7DF7D = self.trigger._id_B9ABE6BDF97E9A79;
  else if(isDefined(self._id_B9ABE6BDF97E9A79))
    _id_EC6EA16813D7DF7D = self._id_B9ABE6BDF97E9A79;

  if(isDefined(_id_EC6EA16813D7DF7D)) {
    _id_1CFCCAC3E5778BBB = self.origin;

    if(isDefined(self.trigger))
      _id_1CFCCAC3E5778BBB = self.trigger.origin;

    if(isDefined(_id_1CFCCAC3E5778BBB) && distance2dsquared(_id_1CFCCAC3E5778BBB, player.origin) >= _id_EC6EA16813D7DF7D)
      return 0;
  }

  if(!self.userate && !_id_F4B4020BAA4A83E3)
    return 0;

  if(_id_F4B4020BAA4A83E3 && _id_DD9707A466EFA528 > _id_3DAFA337A7EED569)
    return 0;

  if(istrue(self.checkuseconditioninthink) && isDefined(self.usecondition) && !self[[self.usecondition]](player))
    return 0;

  if(isDefined(self.useweapon)) {
    if(player getcurrentweapon() != self.useweapon && !player scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(self.useweapon) && !player _meth_E40102956C887F7C())
      return 0;
  }

  if(isrevivetrigger()) {
    if(!player islinked() && !player isonground() && !(istrue(self._id_DBC472744080C5D7) && player _meth_E40102956C887F7C()))
      return 0;
  }

  return 1;
}

useholdthinkloop(player, lastweapon) {
  level endon("game_ended");
  self endon("disabled");
  self endon("deleted");
  useweapon = self.useweapon;
  _id_F4B4020BAA4A83E3 = 1;

  if(isDefined(self.waitforweapononuse))
    _id_F4B4020BAA4A83E3 = self.waitforweapononuse;

  if(!istrue(_id_F4B4020BAA4A83E3))
    self.userate = 1 * player.objectivescaler;

  _id_DD9707A466EFA528 = 0;
  _id_3DAFA337A7EED569 = 1.5;
  _id_038FC7BD1495C4B2 = level.framedurationseconds;
  _id_A1DFE9D4920A43FA = _id_038FC7BD1495C4B2 * 1000;
  objid = undefined;

  while(usetest(player, _id_F4B4020BAA4A83E3, _id_DD9707A466EFA528, _id_3DAFA337A7EED569)) {
    if(isDefined(self.objidnum))
      scripts\mp\objidpoolmanager::objective_pin_player(self.objidnum, player);

    _id_DD9707A466EFA528 = _id_DD9707A466EFA528 + _id_038FC7BD1495C4B2;

    if(!_id_F4B4020BAA4A83E3 || !isDefined(useweapon) || player getcurrentweapon() == useweapon) {
      self.curprogress = self.curprogress + _id_A1DFE9D4920A43FA * self.userate;
      self.userate = 1 * player.objectivescaler;
      _id_F4B4020BAA4A83E3 = 0;
    } else
      self.userate = 0;

    player updateuiprogress(self, 1);

    if(self.curprogress >= self.usetime) {
      self.inuse = 0;

      if(istrue(self.exclusiveuse))
        player clientreleasetrigger(self.trigger);

      _id_D9842C97BADABA31 = isDefined(self.id) && (self.id == "traversalassist" || self.id == "breach" || self.id == "care_package");

      if(!isDefined(useweapon) && !istrue(_id_D9842C97BADABA31)) {
        if(isrevivetrigger() || isDefined(self.id) && self.id == "rugby_jugg") {
          if(istrue(player.weaponsdisabledwhilereviving)) {
            player.weaponsdisabledwhilereviving = undefined;

            if(!istrue(level.allowreviveweapons)) {
              player thread forceunsetdemeanor(0);
              player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("useHold");
            } else
              player _id_3B64EB40368C1450::_id_588F2307A3040610("reviveShoot");
          }
        } else
          player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("useHold");
      }

      player unlink();

      if(isDefined(self.objidnum))
        scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, player);

      return scripts\cp\utility\player::isreallyalive(player);
    }

    wait(_id_038FC7BD1495C4B2);
    scripts\cp\cp_hostmigration::waittillhostmigrationdone();
  }

  if(isDefined(self.objidnum))
    scripts\mp\objidpoolmanager::objective_unpin_player(self.objidnum, player);

  player updateuiprogress(self, 0);
  return 0;
}

updatetrigger() {
  if(self.triggertype != "use") {
    return;
  }
  if(self.trigger.classname != "trigger_use" && self.trigger.classname != "trigger_use_touch") {
    return;
  }
  if(self.interactteam == "none") {
    self.trigger.origin = self.trigger.origin - (0, 0, 10000);

    if(isDefined(self.trigger.classname) && self.trigger.classname != "script_model")
      self.trigger setteamfortrigger("none");
  } else if(self.interactteam == "any") {
    self.trigger.origin = self.curorigin;
    self.trigger setteamfortrigger("none");
  } else if(self.interactteam == "friendly") {
    self.trigger.origin = self.curorigin;

    if(scripts\engine\utility::array_contains(level.teamnamelist, self.ownerteam))
      self.trigger setteamfortrigger(self.ownerteam);
    else
      self.trigger.origin = self.trigger.origin - (0, 0, 50000);
  } else if(self.interactteam == "enemy") {
    self.trigger.origin = self.curorigin;

    if(self.ownerteam == "allies")
      self.trigger setteamfortrigger("axis");
    else if(self.ownerteam == "axis")
      self.trigger setteamfortrigger("allies");
    else
      self.trigger setteamfortrigger("none");
  }
}

getmlgteamcolor(team) {
  if(team == "allies")
    return game["colors"]["friendly"];
  else if(team == "axis")
    return game["colors"]["enemy"];

  return (1, 1, 1);
}

setobjpointteamcolor(_id_B74984F8B12CF978, _id_840037EE5DD73309, _id_EDD687A0AB26D9F0) {
  if(_id_840037EE5DD73309 == "mlg_allies") {
    _id_B74984F8B12CF978 setmlgdraw(1, 0);
    _id_2C5085251C6170DC = self.objiconscolor[_id_EDD687A0AB26D9F0];

    if(_id_2C5085251C6170DC == "friendly") {
      _id_B74984F8B12CF978.color = getmlgteamcolor("allies");
      return;
    }

    if(_id_2C5085251C6170DC == "enemy") {
      _id_B74984F8B12CF978.color = getmlgteamcolor("axis");
      return;
    }

    _id_B74984F8B12CF978.color = game["colors"][_id_2C5085251C6170DC];
    return;
    return;
  } else if(_id_840037EE5DD73309 == "mlg_axis") {
    _id_B74984F8B12CF978 setmlgdraw(1, 0);
    _id_2C5085251C6170DC = self.objiconscolor[_id_EDD687A0AB26D9F0];

    if(_id_2C5085251C6170DC == "friendly") {
      _id_B74984F8B12CF978.color = getmlgteamcolor("axis");
      return;
    }

    if(_id_2C5085251C6170DC == "enemy") {
      _id_B74984F8B12CF978.color = getmlgteamcolor("allies");
      return;
    }

    _id_B74984F8B12CF978.color = game["colors"][_id_2C5085251C6170DC];
    return;
    return;
  } else {
    _id_B74984F8B12CF978.color = game["colors"][self.objiconscolor[_id_EDD687A0AB26D9F0]];
    _id_B74984F8B12CF978 setmlgdraw(0, 1);
  }
}

hideworldiconongameend() {
  self notify("hideWorldIconOnGameEnd");
  self endon("hideWorldIconOnGameEnd");
  self endon("death");
  level waittill("game_ended");

  if(isDefined(self))
    self.alpha = 0;
}

updatetimer(_id_CC748B6D457627FE, showicon) {}

setobjectivestatusallicons(friendlyicon, _id_30F120A1EFC1DCBE, _id_30D3474E85B85838, objid, ownerteam) {
  if(istrue(self.lockupdatingicons)) {
    return;
  }
  if(!isDefined(friendlyicon))
    friendlyicon = _id_30F120A1EFC1DCBE;

  if(!isDefined(_id_30F120A1EFC1DCBE))
    _id_30F120A1EFC1DCBE = friendlyicon;

  if(!isDefined(self.iconname))
    self.iconname = "";

  if(level.codcasterenabled) {
    if(!isDefined(_id_30D3474E85B85838))
      self.compassicons["codcaster"] = undefined;
    else
      self.compassicons["codcaster"] = _id_30D3474E85B85838 + self.iconname;
  }

  self.compassicons["friendly"] = friendlyicon + self.iconname;
  self.compassicons["enemy"] = _id_30F120A1EFC1DCBE + self.iconname;
  updatecompassicons(objid, ownerteam);
}

setobjectivestatusicons(friendlyicon, _id_30F120A1EFC1DCBE, objid, ownerteam, _id_3B41B9A0EA9AF087) {
  if(istrue(self.lockupdatingicons)) {
    return;
  }
  if(!isDefined(friendlyicon))
    friendlyicon = _id_30F120A1EFC1DCBE;

  if(!isDefined(_id_30F120A1EFC1DCBE))
    _id_30F120A1EFC1DCBE = friendlyicon;

  if(!isDefined(self.iconname))
    self.iconname = "";

  self.compassicons["friendly"] = friendlyicon + self.iconname;
  self.compassicons["enemy"] = _id_30F120A1EFC1DCBE + self.iconname;

  if(!istrue(_id_3B41B9A0EA9AF087))
    updatecompassicons(objid, ownerteam);
}

setmlgobjectivestatusicon(_id_30D3474E85B85838, objid, ownerteam) {
  if(!level.codcasterenabled) {
    return;
  }
  if(!isDefined(_id_30D3474E85B85838)) {
    return;
  }
  if(!isDefined(self.iconname))
    self.iconname = "";

  self.compassicons["codcaster"] = _id_30D3474E85B85838 + self.iconname;
  updatecompassicons(objid, ownerteam);
}

resetmlgobjectivestatusicon(objid, ownerteam) {
  self.compassicons["codcaster"] = undefined;
  updatecompassicons(objid, ownerteam);
}

updatecompassicons(objid, ownerteam) {
  visibleteam = self.visibleteam;

  if(!isDefined(self.visibleteam))
    visibleteam = "none";

  updatecompassicon(visibleteam, objid, ownerteam);
}

updatecompassicon(_id_EDD687A0AB26D9F0, objid, ownerteam) {
  _id_00DCA4604F39117A = _id_EDD687A0AB26D9F0 == "any";
  _id_C0D426FB0DA57CF2 = _id_EDD687A0AB26D9F0 == "none";
  _id_AA4F261BA2F9905A = _id_EDD687A0AB26D9F0 == "codcaster";

  if(_id_00DCA4604F39117A || _id_C0D426FB0DA57CF2)
    _id_23AE7B386046354E = level.teamnamelist;
  else {
    _id_B66CFD2561F4565B = getupdateteams(_id_EDD687A0AB26D9F0);
    _id_23AE7B386046354E = _id_B66CFD2561F4565B.teams;
  }

  _id_01341915118CC82B = 0;

  for(index = 0; index < _id_23AE7B386046354E.size; index++) {
    _id_840037EE5DD73309 = _id_23AE7B386046354E[index];

    if(_id_00DCA4604F39117A || _id_C0D426FB0DA57CF2)
      _id_5C5D470BD64763F8 = _id_840037EE5DD73309;
    else
      _id_5C5D470BD64763F8 = _id_840037EE5DD73309.team;

    if(!_id_C0D426FB0DA57CF2 && !_id_00DCA4604F39117A && !_id_AA4F261BA2F9905A && !scripts\cp\utility::isgameplayteam(_id_5C5D470BD64763F8)) {
      continue;
    }
    _id_58498FC5D5879BA1 = !_id_C0D426FB0DA57CF2 && (_id_00DCA4604F39117A || _id_840037EE5DD73309.showtoteam);

    if(!_id_58498FC5D5879BA1 && shouldshowcompassduetoradar(_id_5C5D470BD64763F8))
      _id_58498FC5D5879BA1 = 1;

    if(!isDefined(objid))
      objid = self.objidnum;

    if(objid != -1) {
      if(!istrue(self.visibilitymanuallycontrolled)) {
        if(!isDefined(self.compassicons["friendly"]) || !_id_58498FC5D5879BA1) {
          scripts\mp\objidpoolmanager::objective_teammask_removefrommask(objid, _id_5C5D470BD64763F8);
          continue;
        } else
          scripts\mp\objidpoolmanager::objective_teammask_addtomask(objid, _id_5C5D470BD64763F8);

        if(!isDefined(self.compassicons["enemy"]) || !_id_58498FC5D5879BA1) {
          scripts\mp\objidpoolmanager::objective_teammask_removefrommask(objid, _id_5C5D470BD64763F8);
          continue;
        } else
          scripts\mp\objidpoolmanager::objective_teammask_addtomask(objid, _id_5C5D470BD64763F8);
      }

      if(!_id_01341915118CC82B) {
        icon = getwaypointshader(self.compassicons["friendly"]);
        scripts\mp\objidpoolmanager::update_objective_icon(objid, icon);
        _id_A3EC0E7732B1EDF1 = _id_3672AF010E23DFC8(self.compassicons["friendly"]);

        if(_id_A3EC0E7732B1EDF1)
          scripts\mp\objidpoolmanager::_id_79A1A16DE6B22B2D(objid, _id_A3EC0E7732B1EDF1);

        _id_91DBC914C620CCB0 = getwaypointbackgroundcolor(self.compassicons["friendly"]);
        _id_91DBC914C620CCB0 = scripts\engine\utility::ter_op(isDefined(_id_91DBC914C620CCB0), _id_91DBC914C620CCB0, "neutral");
        _id_B068858B9EB29701 = getwaypointbackgroundcolor(self.compassicons["enemy"]);
        _id_B068858B9EB29701 = scripts\engine\utility::ter_op(isDefined(_id_B068858B9EB29701), _id_B068858B9EB29701, "neutral");
        _id_A5250821FB1BEA6A = 0;
        _id_05FA71E8FED5161B = getobjectivestate(_id_91DBC914C620CCB0, _id_B068858B9EB29701);

        if(_id_05FA71E8FED5161B == "contest")
          _id_A5250821FB1BEA6A = 1;

        if(_id_A5250821FB1BEA6A) {
          scripts\mp\objidpoolmanager::objective_set_progress_team(objid, undefined);
          scripts\mp\objidpoolmanager::update_objective_sethot(objid, 1);
        } else
          scripts\mp\objidpoolmanager::update_objective_sethot(objid, 0);

        if(isDefined(ownerteam))
          self.ownerteam = ownerteam;

        _id_A041BEA72BA46E04 = getwaypointstring(self.compassicons["friendly"]);
        _id_BA5C3A2B11FFF3F5 = getwaypointstring(self.compassicons["enemy"]);

        if(_id_05FA71E8FED5161B == "neutral" || !isDefined(self.ownerteam)) {
          if(isDefined(self.claimteam) && self.claimteam != "none") {
            if(isDefined(self.ownerteam) && self.ownerteam != "neutral") {
              scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, self.claimteam);
              scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objid, _id_A041BEA72BA46E04);
              scripts\mp\objidpoolmanager::update_objective_setenemylabel(objid, _id_BA5C3A2B11FFF3F5);
            } else {
              scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, undefined);
              scripts\mp\objidpoolmanager::update_objective_setneutrallabel(objid, _id_A041BEA72BA46E04);
            }
          } else {
            scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, undefined);
            scripts\mp\objidpoolmanager::update_objective_setneutrallabel(objid, _id_A041BEA72BA46E04);
          }
        } else if(_id_05FA71E8FED5161B == "claimed") {
          if(self.ownerteam != "neutral")
            scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, self.ownerteam);
          else
            scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, undefined);

          scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objid, _id_A041BEA72BA46E04);
          scripts\mp\objidpoolmanager::update_objective_setenemylabel(objid, _id_BA5C3A2B11FFF3F5);
        } else if(_id_05FA71E8FED5161B == "contest") {
          if(self.cancontestclaim && self.stalemate != self.wasstalemate || self.cancontestclaim && istrue(self.majoritycapprogress) && self.majoritycapprogress != self.wasmajoritycapprogress)
            objective_setlabel(objid, _id_A041BEA72BA46E04);
          else {
            if(!scripts\cp\utility::isgameplayteam(self.claimteam)) {
              continue;
            }
            scripts\mp\objidpoolmanager::update_objective_ownerteam(objid, self.claimteam);
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(objid, _id_A041BEA72BA46E04);
            scripts\mp\objidpoolmanager::update_objective_setenemylabel(objid, _id_BA5C3A2B11FFF3F5);
          }
        }

        _id_BAB98E6EFFF82B79 = getwaypointbackgroundtype(self.compassicons["friendly"]);
        scripts\mp\objidpoolmanager::update_objective_setbackground(objid, _id_BAB98E6EFFF82B79);
        _id_EAD9736888ADD0DF = getwaypointobjpulse(self.compassicons["friendly"]);
        scripts\mp\objidpoolmanager::objective_set_pulsate(objid, _id_EAD9736888ADD0DF);

        if(hasdomflags()) {
          if(!istrue(self.stalemate) && self.ownerteam != "neutral") {
            if(self.numtouching["axis"] > 0 && self.numtouching["allies"] > 0) {
              self.captureblocked = 1;
              scripts\mp\objidpoolmanager::update_objective_sethot(objid, 1);
            } else {
              self.captureblocked = 0;
              scripts\mp\objidpoolmanager::update_objective_sethot(objid, 0);
            }
          }
        }

        if(self.type == "carryObject") {
          if(scripts\cp\utility\player::isreallyalive(self.carrier) && !shouldpingobject(_id_EDD687A0AB26D9F0)) {
            scripts\mp\objidpoolmanager::update_objective_onentity(objid, self.carrier);
            scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, self.offset3d[2]);
          } else if(isDefined(self.visuals) && isDefined(self.visuals[0]) && isDefined(self.visuals[0] getlinkedparent()))
            scripts\mp\objidpoolmanager::update_objective_onentity(objid, self.visuals[0]);
          else if(isDefined(self.objectiveonvisuals) && self.objectiveonvisuals) {
            if(!shouldpingobject(_id_EDD687A0AB26D9F0)) {
              scripts\mp\objidpoolmanager::update_objective_onentity(objid, self.visuals[0]);

              if(isDefined(self.objectiveonvisualsoffset3d))
                scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, self.objectiveonvisualsoffset3d[2]);
            } else if(isDefined(self.objectiveonvisualsoffset3d))
              scripts\mp\objidpoolmanager::update_objective_position(objid, self.curorigin + (0, 0, self.objectiveonvisualsoffset3d[2]));
            else
              scripts\mp\objidpoolmanager::update_objective_position(objid, self.curorigin);
          } else {
            scripts\mp\objidpoolmanager::update_objective_position(objid, self.curorigin);
            scripts\mp\objidpoolmanager::update_objective_setzoffset(objid, self.offset3d[2]);
          }
        } else if(isDefined(self.objiconent))
          scripts\mp\objidpoolmanager::update_objective_onentity(objid, self.objiconent);

        _id_01341915118CC82B = 1;
      }
    }
  }
}

shouldpingobject(_id_EDD687A0AB26D9F0) {
  if(_id_EDD687A0AB26D9F0 == "friendly" && self.objidpingenemy)
    return 1;
  else if(_id_EDD687A0AB26D9F0 == "enemy" && self.objidpingfriendly)
    return 1;

  return 0;
}

getupdateteams(_id_EDD687A0AB26D9F0) {
  _id_23AE7B386046354E = spawnStruct();
  _id_23AE7B386046354E.teams = [];

  if(_id_EDD687A0AB26D9F0 == "codcaster") {
    _id_23AE7B386046354E.teams[0] = spawnStruct();
    _id_23AE7B386046354E.teams[0].team = _id_EDD687A0AB26D9F0;
    _id_23AE7B386046354E.teams[0].showtoteam = 1;
    return _id_23AE7B386046354E;
  }

  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    index = _id_23AE7B386046354E.teams.size;
    _id_23AE7B386046354E.teams[index] = spawnStruct();

    if(_id_EDD687A0AB26D9F0 == "any") {
      _id_23AE7B386046354E.teams[index].team = _id_FABF84450735DD93;
      _id_23AE7B386046354E.teams[index].showtoteam = 1;
      continue;
    }

    if(_id_EDD687A0AB26D9F0 == "friendly") {
      if(isfriendlyteam(_id_FABF84450735DD93)) {
        _id_23AE7B386046354E.teams[index].team = _id_FABF84450735DD93;
        _id_23AE7B386046354E.teams[index].showtoteam = 1;
      } else {
        _id_23AE7B386046354E.teams[index].team = _id_FABF84450735DD93;
        _id_23AE7B386046354E.teams[index].showtoteam = 0;
      }

      continue;
    }

    if(_id_EDD687A0AB26D9F0 == "enemy") {
      if(isfriendlyteam(_id_FABF84450735DD93)) {
        _id_23AE7B386046354E.teams[index].team = _id_FABF84450735DD93;
        _id_23AE7B386046354E.teams[index].showtoteam = 0;
      } else {
        _id_23AE7B386046354E.teams[index].team = _id_FABF84450735DD93;
        _id_23AE7B386046354E.teams[index].showtoteam = 1;
      }

      continue;
    }

    if(_id_EDD687A0AB26D9F0 == "none") {
      _id_23AE7B386046354E.teams[index].team = _id_FABF84450735DD93;
      _id_23AE7B386046354E.teams[index].showtoteam = 0;
    }
  }

  return _id_23AE7B386046354E;
}

getobjectivestate(_id_91DBC914C620CCB0, _id_B068858B9EB29701) {
  if(_id_91DBC914C620CCB0 == "contest" || _id_B068858B9EB29701 == "contest")
    return "contest";
  else if(_id_91DBC914C620CCB0 == "neutral" || _id_B068858B9EB29701 == "neutral")
    return "neutral";
  else
    return "claimed";
}

shouldshowcompassduetoradar(team) {
  if(!isDefined(self.carrier))
    return 0;

  if(self.carrier scripts\cp\utility::_hasperk("specialty_gpsjammer"))
    return 0;

  return getteamradar(team);
}

updatevisibilityaccordingtoradar() {
  self endon("death");
  self endon("carrier_cleared");

  for(;;) {
    level waittill("radar_status_change");
    updatecompassicons();
  }
}

setownerteam(team) {
  self.ownerteam = team;
  updatetrigger();
  updatecompassicons();

  if(team != "neutral")
    self.prevownerteam = team;
}

getownerteam() {
  return self.ownerteam;
}

setusetime(time, _id_3535AD78361036A5) {
  if(istrue(_id_3535AD78361036A5))
    self._id_3B3185F4D42EE4E6 = self.usetime / 1000;

  self.usetime = int(time * 1000);
}

pinobjiconontriggertouch() {
  self.pinobj = 1;
}

_id_9A19CCF8DC6C3CAF() {
  return istrue(self.pinobj);
}

_id_DC06030CEB03363B() {
  if((getDvar("dvar_7611A2790A0BF7FE", "") == "dmz" || getDvar("dvar_7611A2790A0BF7FE", "") == "exgm") && isDefined(self.trigger) && isDefined(self.trigger.objidnum))
    return istrue(self.trigger.pinobj);

  return 0;
}

setwaitweaponchangeonuse(_id_E3108E412AFB3811) {
  self.waitforweapononuse = _id_E3108E412AFB3811;
}

setusetext(text) {
  self.usetext = text;
}

setteamusetime(_id_EDD687A0AB26D9F0, time) {
  self.teamusetimes[_id_EDD687A0AB26D9F0] = int(time * 1000);
}

setteamusetext(_id_EDD687A0AB26D9F0, text) {
  self.teamusetexts[_id_EDD687A0AB26D9F0] = text;
}

setusehinttext(text) {
  self.trigger setHintString(text);
}

allowcarry(_id_EDD687A0AB26D9F0) {
  self.interactteam = _id_EDD687A0AB26D9F0;
}

allowuse(_id_EDD687A0AB26D9F0) {
  self.interactteam = _id_EDD687A0AB26D9F0;
  updatetrigger();
}

squadallowuse(team, squadindex) {
  if(!isDefined(self.interactsquads))
    self.interactsquads = [];

  if(!isDefined(self.interactsquads[team]))
    self.interactsquads[team] = [];

  if(!scripts\engine\utility::array_contains(self.interactsquads[team], squadindex))
    self.interactsquads[team][self.interactsquads[team].size] = squadindex;
}

squaddenyuse(team, squadindex) {
  if(!isDefined(self.interactsquads))
    self.interactsquads = [];

  if(!isDefined(self.interactsquads[team]))
    self.interactsquads[team] = [];

  if(scripts\engine\utility::array_contains(self.interactsquads[team], squadindex))
    self.interactsquads[team] = scripts\engine\utility::array_remove(self.interactsquads[team], squadindex);
}

setvisibleteam(_id_EDD687A0AB26D9F0, objid, _id_3B41B9A0EA9AF087) {
  self.visibleteam = _id_EDD687A0AB26D9F0;

  if(!istrue(_id_3B41B9A0EA9AF087))
    updatecompassicons(objid);
}

setmodelvisibility(_id_7D3CF95BDBCA0939) {
  if(_id_7D3CF95BDBCA0939) {
    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index] show();

      if(self.visuals[index].classname == "script_brushmodel" || self.visuals[index].classname == "script_model") {
        foreach(player in level.players) {
          if(player istouching(self.visuals[index]))
            player scripts\cp\utility::_suicide();
        }

        self.visuals[index] thread makesolid();
      }
    }
  } else {
    for(index = 0; index < self.visuals.size; index++) {
      self.visuals[index] hide();

      if(self.visuals[index].classname == "script_brushmodel" || self.visuals[index].classname == "script_model") {
        self.visuals[index] notify("changing_solidness");
        self.visuals[index] notsolid();
      }
    }
  }
}

makesolid() {
  self endon("death");
  self notify("changing_solidness");
  self endon("changing_solidness");

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
      if(level.players[_id_AC0E594AC96AA3A8] istouching(self)) {
        break;
      }
    }

    if(_id_AC0E594AC96AA3A8 == level.players.size) {
      self solid();
      break;
    }

    wait 0.05;
  }
}

setcarriervisible(_id_EDD687A0AB26D9F0) {
  self.carriervisible = _id_EDD687A0AB26D9F0;
}

setcanuse(_id_EDD687A0AB26D9F0) {
  self.useteam = _id_EDD687A0AB26D9F0;
}

getwaypointshader(shader) {
  image = level.waypointshader[shader];

  if(!isDefined(image))
    return "icon_waypoint_dom_a";

  return image;
}

getwaypointbackgroundtype(shader) {
  _id_BAB98E6EFFF82B79 = level.waypointbgtype[shader];

  if(!isDefined(_id_BAB98E6EFFF82B79))
    return 0;

  return _id_BAB98E6EFFF82B79;
}

getwaypointbackgroundcolor(shader) {
  _id_2C5085251C6170DC = level.waypointcolors[shader];

  if(!isDefined(_id_2C5085251C6170DC))
    return "neutral";

  return _id_2C5085251C6170DC;
}

getwaypointstring(shader) {
  stringref = level.waypointstring[shader];

  if(!isDefined(stringref))
    return "MP_INGAME_ONLY/MISSING_STRING";

  return stringref;
}

getwaypointobjpulse(shader) {
  pulse = level.waypointpulses[shader];

  if(!isDefined(pulse))
    return 0;

  return pulse;
}

_id_3672AF010E23DFC8(name) {
  _id_A3EC0E7732B1EDF1 = level._id_ED9ACFB4A79FB6BE[name];

  if(!isDefined(_id_A3EC0E7732B1EDF1))
    return 0;

  return _id_A3EC0E7732B1EDF1;
}

set3duseicon(_id_EDD687A0AB26D9F0, shader) {
  self.worlduseicons[_id_EDD687A0AB26D9F0] = shader;
}

setcarryicon(shader) {
  self.carryicon = shader;
}

disableobject() {
  self notify("disabled");

  if(self.type == "carryObject") {
    if(isDefined(self.carrier))
      self.carrier takeobject(self);

    for(index = 0; index < self.visuals.size; index++)
      self.visuals[index] hide();
  }

  self.trigger scripts\engine\utility::trigger_off();
  setvisibleteam("none");
}

enableobject() {
  if(self.type == "carryObject") {
    for(index = 0; index < self.visuals.size; index++)
      self.visuals[index] show();
  }

  self.trigger scripts\engine\utility::trigger_on();
  setvisibleteam("any");
}

getrelativeteam(team) {
  if(team == self.ownerteam)
    return "friendly";
  else
    return "enemy";
}

isfriendlyteam(team) {
  if(self.ownerteam == "any")
    return 1;

  if(self.ownerteam == team)
    return 1;

  if(self.ownerteam == "neutral" && isDefined(self.prevownerteam) && self.prevownerteam == team)
    return 1;

  return 0;
}

caninteractwith(team, player) {
  if(isDefined(player) && isDefined(self.interactsquads))
    return isDefined(self.interactsquads[player.team]) && scripts\engine\utility::array_contains(self.interactsquads[player.team], player._id_0FF97225579DE16A);
  else {
    switch (self.interactteam) {
      case "none":
        return 0;
      case "any":
        return 1;
      case "friendly":
        if(team == self.ownerteam)
          return 1;
        else
          return 0;
      case "enemy":
        if(team != self.ownerteam)
          return 1;
        else
          return 0;
      default:
        return 0;
    }
  }
}

isteam(team) {
  if(team == "neutral")
    return 1;

  if(team == "any")
    return 1;

  if(team == "none")
    return 1;

  foreach(_id_FABF84450735DD93 in level.teamnamelist) {
    if(team == _id_FABF84450735DD93)
      return 1;
  }

  return 0;
}

isrelativeteam(_id_EDD687A0AB26D9F0) {
  if(_id_EDD687A0AB26D9F0 == "friendly")
    return 1;

  if(_id_EDD687A0AB26D9F0 == "enemy")
    return 1;

  if(_id_EDD687A0AB26D9F0 == "any")
    return 1;

  if(_id_EDD687A0AB26D9F0 == "none")
    return 1;

  return 0;
}

getlabel() {
  if(!isDefined(self.trigger.script_label))
    return "";
  else
    return self.trigger.script_label;
}

initializetagpathvariables() {
  self.nearest_node = undefined;
  self.calculated_nearest_node = 0;
  self.on_path_grid = undefined;
}

mustmaintainclaim(enabled) {
  self.mustmaintainclaim = enabled;
}

cancontestclaim(enabled) {
  self.cancontestclaim = enabled;
}

getleveltriggers() {
  level.minetriggers = getEntArray("minefield", "targetname");
  level.hurttriggers = getEntArray("trigger_hurt", "classname");
  level.radtriggers = getEntArray("radiation", "targetname");
  level.ballallowedtriggers = getEntArray("uplinkAllowedOOB", "targetname");
  level.nozonetriggers = getEntArray("uplink_nozone", "targetname");
  level.droptonavmeshtriggers = getEntArray("dropToNavMesh", "targetname");
}

isbombmode() {
  switch (scripts\cp\utility::getgametype()) {
    case "sr":
    case "sd":
    case "btm":
    case "cyber":
    case "cmd":
    case "dd":
    case "gwbomb":
      return 1;
    default:
      return 0;
  }
}

isflagcarrymode() {
  switch (scripts\cp\utility::getgametype()) {
    case "tdef":
    case "ctf":
      return 1;
    default:
      return 0;
  }
}

touchingdroptonavmeshtrigger(droppoint) {
  if(level.droptonavmeshtriggers.size > 0) {
    if(isbombmode() || scripts\cp\utility::getgametype() == "ctf" || scripts\cp\utility::getgametype() == "tdef")
      self.visuals[0].origin = droppoint;

    foreach(trigger in level.droptonavmeshtriggers) {
      foreach(visual in self.visuals) {
        if(visual istouching(trigger))
          return 1;
      }
    }
  }

  return 0;
}

touchingarbitraryuptrigger() {
  if(level.arbitraryuptriggers.size > 0) {
    foreach(trigger in level.arbitraryuptriggers) {
      if(self istouching(trigger))
        return 1;
    }
  }

  return 0;
}

resetcaptureprogress() {
  if(isDefined(self.teamprogress)) {
    foreach(team, progress in self.teamprogress)
    self.teamprogress[team] = 0;
  }
}

getcaptureprogress() {
  if(isDefined(self.teamprogress) && isDefined(self.claimteam)) {
    if(self.claimteam != "none")
      return self.teamprogress[self.claimteam] / self.usetime;
    else
      return self.teamprogress[self.lastclaimteam] / self.usetime;
  }

  return 0.0;
}

requestid(_id_11584E4650A8CDC0, world, _id_AA530B7C5AEFA0B4, showoncompass, dointro, iconsize, _id_08B9949739F4E0F6) {
  if(istrue(_id_08B9949739F4E0F6)) {
    self.objidnum = -1;
    return;
  }

  if(isDefined(_id_AA530B7C5AEFA0B4))
    self.objidnum = scripts\mp\objidpoolmanager::requestreservedid(_id_AA530B7C5AEFA0B4);
  else
    self.objidnum = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(self.objidnum != -1) {
    _id_024C76FC549F7FD9 = "done";

    if(_id_11584E4650A8CDC0 && world)
      _id_024C76FC549F7FD9 = "current";
    else if(_id_11584E4650A8CDC0)
      _id_024C76FC549F7FD9 = "active";
    else if(world)
      _id_024C76FC549F7FD9 = "invisible";

    scripts\mp\objidpoolmanager::objective_add_objective(self.objidnum, _id_024C76FC549F7FD9, self.curorigin + self.offset3d, undefined, iconsize);

    if(getdvarint("scr_game_objOnNavBar", 0) == 1) {
      if(isDefined(showoncompass) && showoncompass == 0) {
        objective_setshowoncompass(self.objidnum, 0);
        self.showoncompass = 0;
      } else
        objective_setshowoncompass(self.objidnum, 1);
    }

    if(isDefined(dointro)) {
      scripts\mp\objidpoolmanager::objective_set_play_intro(self.objidnum, dointro);
      scripts\mp\objidpoolmanager::objective_set_play_outro(self.objidnum, dointro);
    }

    self.showworldicon = 0;
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.objidnum);

    if(world)
      self.showworldicon = 1;
  }
}

releaseid(_id_321E7A51D3237066, _id_301EC764DD09B364) {
  if(istrue(_id_321E7A51D3237066))
    scripts\mp\objidpoolmanager::returnreservedobjectiveid(self.objidnum, _id_301EC764DD09B364);
  else
    scripts\mp\objidpoolmanager::returnobjectiveid(self.objidnum);

  self.objidnum = -1;
}

getcapturebehavior() {
  if(!isDefined(self.capturebehavior))
    setcapturebehavior("normal");

  return self.capturebehavior;
}

setcapturebehavior(type) {
  self.capturebehavior = type;
}

applycaptureprogress(team, _id_3777ECE6A73EADA5) {
  _id_B0C33D224B825287 = scripts\cp\utility::getenemyteams(team);

  switch (getcapturebehavior()) {
    case "persistent":
      self.teamprogress[team] = self.teamprogress[team] + _id_3777ECE6A73EADA5;
      self.curprogress = self.teamprogress[team];
      break;
    case "contest_only":
      if(!isDefined(self.ownerteam) || self.ownerteam == team) {
        return;
      }
      break;
    case "neutralize":
      foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
        _id_75016344BDEE1D3A = self.teamprogress[_id_F90358454413407F];

        if(_id_75016344BDEE1D3A > 0) {
          if(_id_75016344BDEE1D3A < _id_3777ECE6A73EADA5) {
            self.teamprogress[_id_F90358454413407F] = 0;
            _id_3777ECE6A73EADA5 = _id_3777ECE6A73EADA5 - _id_75016344BDEE1D3A;
            continue;
          }

          self.teamprogress[_id_F90358454413407F] = self.teamprogress[_id_F90358454413407F] - _id_3777ECE6A73EADA5;
          _id_3777ECE6A73EADA5 = 0;
          self.curprogress = self.teamprogress[_id_F90358454413407F];
          scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);
        }
      }

      if(_id_3777ECE6A73EADA5 > 0) {
        self.teamprogress[team] = self.teamprogress[team] + _id_3777ECE6A73EADA5;
        self.curprogress = self.teamprogress[team];
      }

      break;
    case "only_associated_teams":
      if(!isDefined(self.associatedteams) || !scripts\engine\utility::array_contains(self.associatedteams, team)) {
        return;
      }
      foreach(_id_F90358454413407F in _id_B0C33D224B825287) {
        _id_75016344BDEE1D3A = self.teamprogress[_id_F90358454413407F];

        if(_id_75016344BDEE1D3A > 0) {
          if(_id_75016344BDEE1D3A < _id_3777ECE6A73EADA5) {
            self.teamprogress[_id_F90358454413407F] = 0;
            _id_3777ECE6A73EADA5 = _id_3777ECE6A73EADA5 - _id_75016344BDEE1D3A;
            continue;
          }

          self.teamprogress[_id_F90358454413407F] = self.teamprogress[_id_F90358454413407F] - _id_3777ECE6A73EADA5;
          _id_3777ECE6A73EADA5 = 0;
          self.curprogress = self.teamprogress[_id_F90358454413407F];
          scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1);
          scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, self.curprogress / self.usetime);
        }
      }

      if(_id_3777ECE6A73EADA5 > 0) {
        self.teamprogress[team] = self.teamprogress[team] + _id_3777ECE6A73EADA5;
        self.curprogress = self.teamprogress[team];
      }

      break;
    case "one_way_contest_only":
      if(team != self.team) {
        return;
      }
      if(team == self.team) {
        foreach(enemyteam in _id_B0C33D224B825287) {
          if(self.numtouching[enemyteam] > 0)
            return;
        }
      }

      self.teamprogress[team] = self.teamprogress[team] + _id_3777ECE6A73EADA5;
      self.curprogress = self.teamprogress[team];
      break;
    case "all_teams_dom_together":
      self.cancontestclaim = 0;
      _id_8AB430C83AC9F21C = 0;

      foreach(_id_78153A9558995315 in self.touchlist) {
        if(_id_78153A9558995315.size == 0) {
          continue;
        }
        _id_59DB5D0F4E3000A7 = getarraykeys(_id_78153A9558995315);
        _id_8AB430C83AC9F21C = _id_8AB430C83AC9F21C + _id_59DB5D0F4E3000A7.size;
      }

      test = _id_3777ECE6A73EADA5 * _id_8AB430C83AC9F21C;
      self.curprogress = self.curprogress + test;
      self.teamprogress[team] = self.curprogress;
      self._id_3BA42E8C18B42C71 = undefined;
      break;
    default:
      progress = self.teamprogress[team];
      progress = progress + _id_3777ECE6A73EADA5;
      _id_6736D41E2AF881DE = 0;
      numtouching = getnumtouchingforteam(team);
      _id_65218754A3CA92DB = getnumtouchingexceptteam(team);

      if(numtouching && _id_65218754A3CA92DB && numtouching != _id_65218754A3CA92DB)
        _id_6736D41E2AF881DE = 1;

      if(istrue(self.majoritycapprogress) && progress >= self.usetime * 0.95 && istrue(_id_6736D41E2AF881DE)) {
        if(self.ownerteam == "neutral") {
          foreach(team in level.teamnamelist) {
            if(self.touchlist[team].size) {
              touchlist = self.touchlist[team];
              _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

              for(index = 0; index < _id_59DB5D0F4E3000A7.size; index++) {
                player = touchlist[_id_59DB5D0F4E3000A7[index]].player;

                if(!isDefined(player) || !isalive(player)) {
                  continue;
                }
                if(team == self.claimteam) {
                  player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 4);
                  continue;
                }

                player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 4);
              }
            }
          }

          self._id_3BA42E8C18B42C71 = 1;
          scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 1);
          scripts\mp\objidpoolmanager::update_objective_setneutrallabel(self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
        } else {
          foreach(team in level.teamnamelist) {
            if(self.touchlist[team].size) {
              touchlist = self.touchlist[team];
              _id_59DB5D0F4E3000A7 = getarraykeys(touchlist);

              for(index = 0; index < _id_59DB5D0F4E3000A7.size; index++) {
                player = touchlist[_id_59DB5D0F4E3000A7[index]].player;

                if(!isDefined(player) || !isalive(player)) {
                  continue;
                }
                if(team == self.ownerteam) {
                  player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 4);
                  continue;
                }

                player scripts\mp\objidpoolmanager::_id_160F522B63C32D76(2, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 4);
              }
            }
          }

          self._id_3BA42E8C18B42C71 = 1;
          scripts\mp\objidpoolmanager::update_objective_sethot(self.objidnum, 1);
          scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS");
          scripts\mp\objidpoolmanager::update_objective_setenemylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS");
        }
      } else {
        if(self.ownerteam != "neutral") {
          if(self.ownerteam != team)
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel(self.objidnum, "MP_INGAME_ONLY/OBJ_LOSING_CAPS");
        }

        self.teamprogress[team] = self.teamprogress[team] + _id_3777ECE6A73EADA5;
        self.curprogress = self.teamprogress[team];
        self._id_3BA42E8C18B42C71 = undefined;
      }

      break;
  }
}

createhintobject(_id_963953C3478BF4FE, _id_EE1F571F85C89C5C, _id_EFE526BF6A23D275, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  hintobj = spawn("script_model", _id_963953C3478BF4FE);
  hintobj makeusable();

  if(isDefined(_id_EE1F571F85C89C5C))
    hintobj setCursorHint(_id_EE1F571F85C89C5C);
  else
    hintobj setCursorHint("HINT_NOICON");

  if(isDefined(_id_EFE526BF6A23D275))
    hintobj sethinticon(_id_EFE526BF6A23D275);

  if(isDefined(hintstring))
    hintobj setHintString(hintstring);

  if(isDefined(priority))
    hintobj setusepriority(priority);
  else
    hintobj setusepriority(0);

  if(isDefined(duration))
    hintobj setuseholdduration(duration);
  else
    hintobj setuseholdduration("duration_short");

  if(isDefined(onobstruction))
    hintobj sethintonobstruction(onobstruction);
  else
    hintobj sethintonobstruction("hide");

  if(isDefined(hintdist))
    hintobj sethintdisplayrange(hintdist);
  else
    hintobj sethintdisplayrange(200);

  if(isDefined(hintfov))
    hintobj sethintdisplayfov(hintfov);
  else
    hintobj sethintdisplayfov(160);

  if(isDefined(usedist))
    hintobj setuserange(usedist);
  else
    hintobj setuserange(50);

  if(isDefined(usefov))
    hintobj setusefov(usefov);
  else
    hintobj setusefov(120);

  return hintobj;
}

sethintobject(_id_5E8EB3C31F9C265C, _id_EE1F571F85C89C5C, _id_EFE526BF6A23D275, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  if(scripts\cp_mp\utility\game_utility::_id_0B2C4B42F9236924())
    hintstring = undefined;

  self makeusable();

  if(isDefined(_id_5E8EB3C31F9C265C))
    self sethinttag(_id_5E8EB3C31F9C265C);

  if(isDefined(_id_EE1F571F85C89C5C))
    self setCursorHint(_id_EE1F571F85C89C5C);
  else
    self setCursorHint("HINT_NOICON");

  if(isDefined(_id_EFE526BF6A23D275))
    self sethinticon(_id_EFE526BF6A23D275);

  if(isDefined(hintstring))
    self setHintString(hintstring);

  if(isDefined(priority))
    self setusepriority(priority);
  else
    self setusepriority(0);

  if(isDefined(duration))
    self setuseholdduration(duration);
  else
    self setuseholdduration("duration_short");

  if(isDefined(onobstruction))
    self sethintonobstruction(onobstruction);
  else
    self sethintonobstruction("hide");

  if(isDefined(hintdist))
    self sethintdisplayrange(hintdist);
  else
    self sethintdisplayrange(200);

  if(isDefined(hintfov))
    self sethintdisplayfov(hintfov);
  else
    self sethintdisplayfov(160);

  if(isDefined(usedist))
    self setuserange(usedist);
  else
    self setuserange(50);

  if(isDefined(usefov))
    self setusefov(usefov);
  else
    self setusefov(120);
}

createobjidobject(position, ownerteam, offset, _id_3C2389BA69E5822B, visibleteam, showoncompass) {
  object = spawnStruct();
  object.type = "useObject";
  object.curorigin = position;
  object.ownerteam = ownerteam;

  if(!isDefined(offset))
    offset = (0, 0, 0);

  object.offset3d = offset;
  object requestid(1, 1, _id_3C2389BA69E5822B, showoncompass);
  object.compassicons = [];
  object.interactteam = "none";

  if(isDefined(visibleteam))
    object.visibleteam = visibleteam;
  else
    object.visibleteam = "none";

  return object;
}

isrevivetrigger() {
  if(isDefined(self.id) && self.id == "laststand_reviver")
    return 1;

  return 0;
}

_id_AB8D64FE065BF6F7() {
  if(isDefined(self.id) && self.id == "laststand_interrogator")
    return 1;

  return 0;
}

_id_693C0C5A3D8E214E() {
  if(isDefined(self.id) && (self.id == "elite_arrow_arm" || self.id == "elite_arrow_fuse"))
    return 1;

  return 0;
}

_id_D36DCACAC1708708(timer) {
  level endon("game_ended");
  _id_038FC7BD1495C4B2 = level.framedurationseconds;
  _id_A1DFE9D4920A43FA = _id_038FC7BD1495C4B2 * 1000;
  _id_ACFA0707DD372692 = timer * 1000;
  _id_D3D9F3AD00693948 = _id_ACFA0707DD372692 - _id_A1DFE9D4920A43FA;
  endtime = gettime() + _id_ACFA0707DD372692;

  while(gettime() < endtime) {
    _id_6403FB28FBB44896 = _id_D3D9F3AD00693948 / _id_ACFA0707DD372692;
    scripts\mp\objidpoolmanager::objective_show_progress(self.objidnum, 1, 1);
    scripts\mp\objidpoolmanager::objective_set_progress(self.objidnum, _id_6403FB28FBB44896);
    _id_D3D9F3AD00693948 = max(_id_D3D9F3AD00693948 - _id_A1DFE9D4920A43FA, 1);
    waitframe();
  }
}

_id_BABD6A87808A6651(_id_D665271789F9526D, allowedintrigger) {
  if(!isDefined(_id_D665271789F9526D))
    return 1;

  for(index = 0; index < level.radtriggers.size; index++) {
    if(_id_D665271789F9526D istouching(level.radtriggers[index]))
      return 1;
  }

  for(index = 0; index < level.minetriggers.size; index++) {
    if(_id_D665271789F9526D istouching(level.minetriggers[index]))
      return 1;
  }

  for(index = 0; index < level.hurttriggers.size; index++) {
    if(_id_D665271789F9526D istouching(level.hurttriggers[index]))
      return 1;
  }

  if(isDefined(level.outofboundstriggers)) {
    foreach(trigger in level.outofboundstriggers) {
      if(istrue(allowedintrigger)) {
        break;
      }

      if(_id_D665271789F9526D istouching(trigger))
        return 1;

      if(ispointinvolume(_id_D665271789F9526D.origin + (0, 0, 12), trigger))
        return 1;
    }
  }

  if(isDefined(level.jugg_maze_killtrigger)) {
    if(istrue(allowedintrigger))
      return 0;

    if(_id_D665271789F9526D istouching(level.jugg_maze_killtrigger))
      return 1;

    if(ispointinvolume(_id_D665271789F9526D.origin + (0, 0, 12), level.jugg_maze_killtrigger))
      return 1;
  }

  return 0;
}

_id_0C3C18FCCE2D382D(point, allowedintrigger) {
  if(!isDefined(point))
    return 1;

  for(index = 0; index < level.radtriggers.size; index++) {
    if(!ispointinvolume(point, level.radtriggers[index])) {
      continue;
    }
    return 1;
  }

  for(index = 0; index < level.minetriggers.size; index++) {
    if(!ispointinvolume(point, level.minetriggers[index])) {
      continue;
    }
    return 1;
  }

  for(index = 0; index < level.hurttriggers.size; index++) {
    if(!ispointinvolume(point, level.hurttriggers[index])) {
      continue;
    }
    return 1;
  }

  if(isDefined(level.outofboundstriggers)) {
    foreach(trigger in level.outofboundstriggers) {
      if(istrue(allowedintrigger)) {
        break;
      }

      if(!ispointinvolume(point, trigger)) {
        continue;
      }
      return 1;
    }
  }

  return 0;
}

_id_29C0CF699C075F78() {
  if(getdvarint("dvar_AB99C7252936D7ED", 0))
    return 1;

  gt = scripts\cp\utility::getgametype();
  return gt == "ctf";
}

setwaypointiconinfo(name, _id_96D1603BEEEFA4EA, _id_673B3CDBD1F53958, string, icon, _id_B50E35D9C370899B, _id_A3EC0E7732B1EDF1) {
  level.waypointcolors[name] = _id_673B3CDBD1F53958;
  level.waypointbgtype[name] = _id_96D1603BEEEFA4EA;
  level.waypointstring[name] = string;
  level.waypointshader[name] = icon;
  level.waypointpulses[name] = _id_B50E35D9C370899B;
  level._id_ED9ACFB4A79FB6BE[name] = _id_A3EC0E7732B1EDF1;
}

_id_8729FEF0FDE291B4() {
  _id_A443300A7CC92EF0 = 0;

  switch (scripts\cp\utility::getgametype()) {
    case "dom":
    case "mtmc":
    case "siege":
    case "control":
    case "trial":
    case "pill":
    case "arm":
      setwaypointiconinfo("icon_waypoint_dom_a", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("icon_waypoint_dom_b", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("icon_waypoint_dom_c", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("icon_waypoint_dom_d", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_e", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_f", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_g", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_h", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_i", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_taking_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_taking_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_taking_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_taking_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_taking_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_taking_f", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_taking_g", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_taking_h", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_taking_i", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_capture_a", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_capture_b", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_capture_c", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_capture_d", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_capture_e", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_capture_f", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_capture_g", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_capture_h", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_capture_i", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_defend_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_defend_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_defend_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_defend_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_defend_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_defend_f", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_defend_g", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_defend_h", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_defend_i", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_defending_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_defending_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_defending_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_defending_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_defending_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_defending_f", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_defending_g", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_defending_h", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_defending_i", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_blocking_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_blocking_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_blocking_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_blocking_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_f", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_g", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_h", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_blocking_i", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_blocked_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_blocked_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_blocked_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_f", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_g", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_h", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_blocked_i", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_losing_a", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_losing_b", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_losing_c", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_losing_d", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_losing_e", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_losing_f", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_losing_g", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_losing_h", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_losing_i", _id_A443300A7CC92EF0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_captureneutral_a", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_captureneutral_b", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_captureneutral_c", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_captureneutral_d", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_e", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_f", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_g", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_h", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_captureneutral_i", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_contested_a", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_contested_b", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_contested_c", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_contested_d", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_contested_e", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_contested_f", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_contested_g", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_contested_h", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_contested_i", _id_A443300A7CC92EF0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_dom_target_a", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_dom_target_b", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_dom_target_c", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_dom_target_d", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_e", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_f", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_g", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_g", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_h", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_h", 0, undefined);
      setwaypointiconinfo("waypoint_dom_target_i", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_i", 0, undefined);
      setwaypointiconinfo("waypoint_clearing_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_clearing_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_clearing_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_clearing_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_f", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_g", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_h", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_clearing_i", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_CLEARING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_a", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_a", 1, 3);
      setwaypointiconinfo("waypoint_reinforcing_b", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_b", 1, 5);
      setwaypointiconinfo("waypoint_reinforcing_c", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_c", 1, 7);
      setwaypointiconinfo("waypoint_reinforcing_d", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_d", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_e", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_e", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_f", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_f", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_g", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_g", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_h", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_h", 1, undefined);
      setwaypointiconinfo("waypoint_reinforcing_i", _id_A443300A7CC92EF0, "friendly", "MP_INGAME_ONLY/OBJ_REINFORCING_CAPS", "icon_waypoint_dom_i", 1, undefined);
      setwaypointiconinfo("waypoint_locked_a", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 3);
      setwaypointiconinfo("waypoint_locked_b", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 5);
      setwaypointiconinfo("waypoint_locked_c", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 7);
      setwaypointiconinfo("waypoint_locked_d", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_e", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_f", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_g", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_h", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("waypoint_locked_i", _id_A443300A7CC92EF0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, undefined);
      setwaypointiconinfo("icon_waypoint_dom_captured", _id_A443300A7CC92EF0, "codcaster", "", "esports_codcaster_minimap_checkmark", 0, 11);
      break;
    case "sd":
    case "missions":
    case "dd":
      setwaypointiconinfo("waypoint_bomb", 2, "friendly", "MP_INGAME_ONLY/OBJ_BOMB_CAPS", "icon_waypoint_objective_general", 1, 15);
      setwaypointiconinfo("waypoint_exfil", 2, "friendly", "MP_INGAME_ONLY/OBJ_BOMB_CAPS", "ui_map_icon_obj_exfil", 1, 3);
      setwaypointiconinfo("icon_waypoint_escort_bomb", 1, "neutral", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_objective_general", 0, 10);
      setwaypointiconinfo("codcaster_enemy_escort_bomb", 1, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_objective_general", 0, 10);
      setwaypointiconinfo("waypoint_target_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_target_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_bomb_defusing_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_bomb_defusing_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_b", 0, 6);
      setwaypointiconinfo("waypoint_bomb_planting_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_bomb_planting_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_defuse_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb", 0, 4);
      setwaypointiconinfo("waypoint_defuse_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_bomb", 0, 6);
      setwaypointiconinfo("waypoint_bomb_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, 4);
      setwaypointiconinfo("waypoint_bomb_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, 6);
      setwaypointiconinfo("waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, 3);
      setwaypointiconinfo("waypoint_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, 5);
      setwaypointiconinfo("waypoint_defend_c", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0, 7);
      setwaypointiconinfo("waypoint_defend_d", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0, 8);
      setwaypointiconinfo("waypoint_defend_e", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0, 9);
      setwaypointiconinfo("waypoint_defuse_nt_a", 0, "enemy", "", "icon_waypoint_dom_a", 0, 4);
      setwaypointiconinfo("waypoint_defuse_nt_b", 0, "enemy", "", "icon_waypoint_dom_b", 0, 6);
      setwaypointiconinfo("waypoint_bomb_defend_nt_a", 0, "friendly", "", "icon_waypoint_dom_a", 0, 4);
      setwaypointiconinfo("waypoint_bomb_defend_nt_b", 0, "friendly", "", "icon_waypoint_dom_b", 0, 6);
      break;
    case "gwbomb":
      setwaypointiconinfo("waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_defend_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_defend_c", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_defend_d", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_defend_e", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_defend_f", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_target_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_target_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_target_c", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_target_d", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_target_e", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_target_f", 0, "enemy", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_planting_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_planting_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_planting_c", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_planting_d", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_planting_e", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_planting_f", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_c", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_d", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_e", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_f", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defusing_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defusing_b", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defusing_c", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defusing_d", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defusing_e", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defusing_f", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defend_nt_a", 0, "enemy", "", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defend_nt_b", 0, "enemy", "", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defend_nt_c", 0, "enemy", "", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defend_nt_d", 0, "enemy", "", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defend_nt_e", 0, "enemy", "", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_bomb_defend_nt_f", 0, "enemy", "", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_nt_a", 0, "friendly", "", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_nt_b", 0, "friendly", "", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_nt_c", 0, "friendly", "", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_nt_d", 0, "friendly", "", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_nt_e", 0, "friendly", "", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_defuse_nt_f", 0, "friendly", "", "icon_waypoint_dom_f", 0, undefined);
      setwaypointiconinfo("waypoint_locked_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_a", 0, undefined);
      setwaypointiconinfo("waypoint_locked_b", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_b", 0, undefined);
      setwaypointiconinfo("waypoint_locked_c", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_c", 0, undefined);
      setwaypointiconinfo("waypoint_locked_d", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_d", 0, undefined);
      setwaypointiconinfo("waypoint_locked_e", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_e", 0, undefined);
      setwaypointiconinfo("waypoint_locked_f", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_dom_f", 0, undefined);
      break;
    case "hq":
    case "btm":
    case "gwai":
      setwaypointiconinfo("hq_destroy", 0, "enemy", "MP_INGAME_ONLY/OBJ_DESTROY_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_defend", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_hq", 0, 1);
      setwaypointiconinfo("hq_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 2);
      setwaypointiconinfo("hq_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_DESTROYING_CAPS", "icon_waypoint_hq", 0, 1);
    case "gwtdm":
      setwaypointiconinfo("carepackage_incoming", 1, "neutral", "MP_INGAME_ONLY/INCOMING_OBJ_CAPS", "hud_icon_killstreak_carepackage", 0, undefined);
      setwaypointiconinfo("carepackage", 1, "neutral", "", "hud_icon_killstreak_carepackage", 0, undefined);
      break;
    default:
      break;
  }

  setwaypointiconinfo("waypoint_dogtags", 1, "enemy", "", "hud_icon_minimap_misc_dog_tag", 0, 15);
  setwaypointiconinfo("waypoint_dogtags_friendly", 1, "friendly", "", "hud_icon_minimap_misc_dog_tag", 0, 15);
  setwaypointiconinfo("icon_waypoint_locked", 0, "neutral", "MP_INGAME_ONLY/OBJ_LOCKED_CAPS", "icon_waypoint_locked", 0, undefined);
  setwaypointiconinfo("waypoint_capture_kill", 0, "enemy", "MP_INGAME_ONLY/OBJ_KILL_CAPS", "icon_waypoint_kill", 0, undefined);
  setwaypointiconinfo("waypoint_escort", 2, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "icon_waypoint_escort", 0, undefined);
}