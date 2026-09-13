/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1311c5c284dd1537.gsc
***********************************************/

_id_E24031140ED11F4F() {
  level._id_3E2A48A1C201B444 = [];
  level thread _id_343D2853C2474FEF();
  scripts\cp_mp\utility\script_utility::registersharedfunc("deployable_camera", "attachXRays", ::_id_E4D938AD226591FD);
  level._id_BB0266F422D9AFA3 = [];
}

_id_F0698AEE89C18210(_id_08862825A0618BDA) {
  params = level._id_BB0266F422D9AFA3[_id_08862825A0618BDA];
  return params;
}

_id_7C5E1578B6FC9166(grenade) {
  _id_A681B7890CD017C7 = spawnStruct();
  childthread _id_4AD19757691771F4(grenade, _id_A681B7890CD017C7);
  childthread _id_DBD4125446485A2C(grenade, _id_A681B7890CD017C7);
  childthread _id_7A1589C1A8D2CD25(grenade, _id_A681B7890CD017C7);
  grenade waittill("deployableCamera_returnStuck");
  return _id_A681B7890CD017C7;
}

_id_7A1589C1A8D2CD25(grenade, _id_A681B7890CD017C7) {
  grenade endon("deployableCamera_returnStuck");
  grenade waittill("missile_water_impact");
  _id_A681B7890CD017C7._id_6150B9D03028F80C = 1;
}

_id_4AD19757691771F4(grenade, _id_A681B7890CD017C7) {
  grenade endon("deployableCamera_returnStuck");
  grenade waittill("missile_door_stuck", _id_C1D84AB4C521636D);
  _id_A681B7890CD017C7._id_972C39A514F196D1 = _id_C1D84AB4C521636D;
  grenade notify("deployableCamera_returnStuck");
}

_id_DBD4125446485A2C(grenade, _id_A681B7890CD017C7) {
  grenade endon("deployableCamera_returnStuck");
  grenade waittill("missile_stuck", stuckto);
  _id_A681B7890CD017C7._id_82D5E3B42D0191C9 = stuckto;
  waitframe();
  grenade notify("deployableCamera_returnStuck");
}

_id_EE24B83D39692536(_id_73BDD079F000DAAD, stuckto, position, _id_2CE0B44B312EC3CF, _id_076BA9E808A42F81, _id_08862825A0618BDA, _id_D20DFBBBCD940269) {
  _id_303D9FA226476812 = (0, 0, 1);
  _id_C83A8D3D629F1DAC = anglestoup(_id_73BDD079F000DAAD.angles);
  _id_0FCCBF8939AD0065 = vectordot(_id_303D9FA226476812, _id_C83A8D3D629F1DAC);
  _id_9745168C66BABA25 = _id_0FCCBF8939AD0065 <= -0.707;
  _id_9FFCC6E392E7660E = _id_0FCCBF8939AD0065 > -0.707 && _id_0FCCBF8939AD0065 <= 0.707;
  _id_243889C6E373EF11 = _id_0FCCBF8939AD0065 > 0.707;
  mode = "";
  _id_98AFBD56092F6F05 = 0.0;

  if(_id_9745168C66BABA25)
    mode = "ceiling";
  else if(_id_9FFCC6E392E7660E) {
    _id_98AFBD56092F6F05 = -90.0;
    mode = "wall";
  } else
    mode = "ground";

  turret = spawnturret("misc_turret", position, _id_2CE0B44B312EC3CF, 1, 1, _id_98AFBD56092F6F05);
  turret.mode = mode;
  turret setModel(_id_076BA9E808A42F81);
  turret.team = self.team;

  if(!istrue(_id_D20DFBBBCD940269)) {
    turret setturretowner(self);
    turret.owner = self;
    turret setotherent(self);
  }

  turret.origin = _id_73BDD079F000DAAD.origin;
  turret.angles = _id_73BDD079F000DAAD.angles;
  turret disableplayeruseforallplayers();
  turret setmode("sentry_offline");
  turret._id_08862825A0618BDA = _id_08862825A0618BDA;
  _id_4C663252DABD1483 = _id_F0698AEE89C18210(turret._id_08862825A0618BDA)._id_4C663252DABD1483;

  if(isDefined(stuckto)) {
    turret linkTo(stuckto);
    turret thread scripts\mp\equipment::_id_4AF015619E2534BA(stuckto, _id_4C663252DABD1483, 0);
    turret.moving_platform = stuckto;
    data = spawnStruct();
    data.linkparent = turret.moving_platform;
    data.deathoverridecallback = _id_4C663252DABD1483;
    data.validateaccuratetouching = 1;
    turret thread scripts\mp\movers::handle_moving_platforms(data);
    turret thread _id_15380CDF3E4666E6(_id_4C663252DABD1483);
  } else if(isDefined(level.wztrain_info)) {
    data = spawnStruct();
    data.deathoverridecallback = _id_4C663252DABD1483;
    turret thread scripts\mp\movers::handle_moving_platforms(data);
  }

  return turret;
}

_id_15380CDF3E4666E6(_id_4C663252DABD1483) {
  self endon("death");

  while(isDefined(self getlinkedparent()))
    waitframe();

  self[[_id_4C663252DABD1483]]();
}

_id_5D36462331845D5F(_id_4664EE07AD6B2CBD) {
  if(!isDefined(level._id_D381DA74CC527EC5))
    level._id_D381DA74CC527EC5 = [];

  level._id_D381DA74CC527EC5[_id_4664EE07AD6B2CBD] = [];

  foreach(team in level.teamnamelist)
  level._id_D381DA74CC527EC5[_id_4664EE07AD6B2CBD][team] = [];
}

_id_B1D73DD45D89A318(_id_08862825A0618BDA) {
  params = _id_F0698AEE89C18210(_id_08862825A0618BDA);

  if(!isDefined(self._id_D381DA74CC527EC5))
    self._id_D381DA74CC527EC5 = [];

  if(!isDefined(self._id_D381DA74CC527EC5[params._id_9C35CA95BD1D22FA]))
    self._id_D381DA74CC527EC5[params._id_9C35CA95BD1D22FA] = [];
}

_id_C827C58258222D48(_id_08862825A0618BDA) {
  params = _id_F0698AEE89C18210(_id_08862825A0618BDA);

  if(level.teambased)
    return _id_78871160104C5295(params._id_53EC43FA38FC3243);
  else
    return self._id_D381DA74CC527EC5[params._id_9C35CA95BD1D22FA];
}

_id_E60E9CE3B6484E52(_id_08862825A0618BDA) {
  params = _id_F0698AEE89C18210(_id_08862825A0618BDA);

  if(isDefined(params)) {
    _id_494D71491A409C84 = _id_78871160104C5295(params._id_53EC43FA38FC3243);

    if(isDefined(_id_494D71491A409C84) && _id_494D71491A409C84.size > 0) {
      if(isDefined(params._id_5B125DF6B587A5C2) && _id_494D71491A409C84.size >= params._id_5B125DF6B587A5C2)
        return 1;
    }
  }

  return 0;
}

_id_78871160104C5295(_id_4664EE07AD6B2CBD) {
  if(_id_58BE75C518BF0D40::shouldmodesetsquads())
    return level._id_D381DA74CC527EC5[_id_4664EE07AD6B2CBD][self.team][self._id_0FF97225579DE16A];
  else
    return level._id_D381DA74CC527EC5[_id_4664EE07AD6B2CBD][self.team];
}

_id_B785ABAE83E23E41(_id_4664EE07AD6B2CBD, val) {
  if(_id_58BE75C518BF0D40::shouldmodesetsquads())
    level._id_D381DA74CC527EC5[_id_4664EE07AD6B2CBD][self.team][self._id_0FF97225579DE16A] = val;
  else
    level._id_D381DA74CC527EC5[_id_4664EE07AD6B2CBD][self.team] = val;
}

_id_9C46884FE9337FA7(camera) {
  params = _id_F0698AEE89C18210(camera._id_08862825A0618BDA);
  _id_5EC35B0D0E09922D = camera.owner.team;

  if(!isDefined(level._id_D381DA74CC527EC5))
    level._id_D381DA74CC527EC5 = [];

  if(!isDefined(level._id_D381DA74CC527EC5[params._id_53EC43FA38FC3243]))
    level._id_D381DA74CC527EC5[params._id_53EC43FA38FC3243] = [];

  if(!isDefined(level._id_D381DA74CC527EC5[params._id_53EC43FA38FC3243][_id_5EC35B0D0E09922D]))
    level._id_D381DA74CC527EC5[params._id_53EC43FA38FC3243][_id_5EC35B0D0E09922D] = [];

  if(_id_58BE75C518BF0D40::shouldmodesetsquads() && !isDefined(_id_78871160104C5295(params._id_53EC43FA38FC3243)))
    level._id_D381DA74CC527EC5[params._id_53EC43FA38FC3243][_id_5EC35B0D0E09922D][self._id_0FF97225579DE16A] = [];

  _id_81113FD663E237B1 = undefined;
  _id_494D71491A409C84 = _id_78871160104C5295(params._id_53EC43FA38FC3243);
  _id_4928EC336FD14163 = _id_494D71491A409C84.size;
  _id_6DE7667C11DFC31A = 0;

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= _id_4928EC336FD14163; _id_AC0E594AC96AA3A8++) {
      if(_id_AC0E594AC96AA3A8 == _id_4928EC336FD14163) {
        _id_81113FD663E237B1 = _id_AC0E594AC96AA3A8;
        _id_6DE7667C11DFC31A = 1;
        break;
      }

      _id_0CA318DD2DE5793D = _id_494D71491A409C84[_id_AC0E594AC96AA3A8];

      if(!isDefined(_id_0CA318DD2DE5793D._id_59D945F45B4733EE) || istrue(_id_0CA318DD2DE5793D.isdestroyed)) {
        break;
      }

      if(_id_0CA318DD2DE5793D._id_59D945F45B4733EE != _id_AC0E594AC96AA3A8) {
        _id_81113FD663E237B1 = _id_AC0E594AC96AA3A8;
        _id_6DE7667C11DFC31A = 1;
        break;
      }
    }

    if(_id_6DE7667C11DFC31A) {
      break;
    }

    waitframe();
  }

  _id_494D71491A409C84 = scripts\engine\utility::array_add(_id_494D71491A409C84, camera);
  camera._id_59D945F45B4733EE = _id_81113FD663E237B1;
  _id_B785ABAE83E23E41(params._id_53EC43FA38FC3243, scripts\engine\utility::array_sort_with_func(_id_494D71491A409C84, ::_id_15A4C63A63AF8B6B));
  level notify(params._id_4F401574FC47899E, camera, camera._id_59D945F45B4733EE);
}

_id_0E5A484F7C5FAF5B(camera) {
  if(!isDefined(self) || !isalive(self) || !isDefined(camera) || istrue(camera.isdestroyed))
    return 0;
  else
    return 1;
}

_id_F5CDA4DA64C5C579(camera) {
  level endon("game_ended");
  params = _id_F0698AEE89C18210(camera._id_08862825A0618BDA);
  _id_5EC35B0D0E09922D = self.team;
  level notify(params._id_67D467748271444C, camera, camera._id_59D945F45B4733EE);

  if(_id_58BE75C518BF0D40::shouldmodesetsquads()) {
    level._id_D381DA74CC527EC5[params._id_53EC43FA38FC3243][_id_5EC35B0D0E09922D][self._id_0FF97225579DE16A] = scripts\engine\utility::array_remove(level._id_D381DA74CC527EC5[params._id_53EC43FA38FC3243][_id_5EC35B0D0E09922D][self._id_0FF97225579DE16A], camera);

    if(level._id_D381DA74CC527EC5[params._id_53EC43FA38FC3243][_id_5EC35B0D0E09922D][self._id_0FF97225579DE16A].size == 0)
      level._id_D381DA74CC527EC5[params._id_53EC43FA38FC3243][_id_5EC35B0D0E09922D][self._id_0FF97225579DE16A] = undefined;
  } else {
    level._id_D381DA74CC527EC5[params._id_53EC43FA38FC3243][_id_5EC35B0D0E09922D] = scripts\engine\utility::array_remove(level._id_D381DA74CC527EC5[params._id_53EC43FA38FC3243][_id_5EC35B0D0E09922D], camera);

    if(level._id_D381DA74CC527EC5[params._id_53EC43FA38FC3243][_id_5EC35B0D0E09922D].size == 0)
      level._id_D381DA74CC527EC5[params._id_53EC43FA38FC3243][_id_5EC35B0D0E09922D] = undefined;
  }

  camera._id_59D945F45B4733EE = undefined;
}

_id_8E7C5F27949002C7() {
  if(level.teambased) {
    _id_F5D0256E4366D1FF = _id_58BE75C518BF0D40::shouldmodesetsquads();

    if(_id_F5D0256E4366D1FF) {
      return scripts\mp\utility\teams::_id_3D0F2343793D709B(self.owner.team, self.owner.squadindex, 0);
      return;
    }

    return scripts\mp\utility\teams::getteamdata(self.ownerteam, "players");
    return;
  } else
    return self.owner;
}

_id_86B60845E9A3D301(_id_4D91D0458127BDC0) {
  params = _id_F0698AEE89C18210(_id_4D91D0458127BDC0);
  self._id_D381DA74CC527EC5[params._id_9C35CA95BD1D22FA] = undefined;
}

_id_CF9AA20EB9489DE5(_id_D2EEE016E3820550) {
  return isDefined(self._id_D381DA74CC527EC5) && isDefined(self._id_D381DA74CC527EC5[_id_D2EEE016E3820550]);
}

_id_3265A4A8A3BDB477(_id_4D91D0458127BDC0) {
  params = _id_F0698AEE89C18210(_id_4D91D0458127BDC0);
  return isDefined(self._id_D381DA74CC527EC5) && isDefined(self._id_D381DA74CC527EC5[params._id_9C35CA95BD1D22FA]) && self._id_D381DA74CC527EC5[params._id_9C35CA95BD1D22FA].size > 0;
}

_id_F7A32619BBA6E450(_id_4D91D0458127BDC0) {
  params = _id_F0698AEE89C18210(_id_4D91D0458127BDC0);

  if(_id_CF9AA20EB9489DE5(params._id_9C35CA95BD1D22FA)) {
    foreach(camera in self._id_D381DA74CC527EC5[params._id_9C35CA95BD1D22FA])
    camera thread[[params._id_4C663252DABD1483]](1);
  }
}

_id_99F14479415346E9(camera) {
  params = _id_F0698AEE89C18210(camera._id_08862825A0618BDA);

  if(!isDefined(self._id_D381DA74CC527EC5))
    self._id_D381DA74CC527EC5 = [];

  if(!isDefined(self._id_D381DA74CC527EC5[params._id_9C35CA95BD1D22FA]))
    self._id_D381DA74CC527EC5[params._id_9C35CA95BD1D22FA] = [];

  _id_495F77E8BD8D6576 = self._id_D381DA74CC527EC5[params._id_9C35CA95BD1D22FA];
  _id_495F77E8BD8D6576[_id_495F77E8BD8D6576.size] = camera;
  _id_495F77E8BD8D6576 = scripts\engine\utility::array_sort_with_func(_id_495F77E8BD8D6576, ::_id_945C96AD7442451F);

  if(_id_495F77E8BD8D6576.size > params._id_1790D4C69D5F45A4) {
    _id_E297B70980F770A3 = _id_495F77E8BD8D6576[_id_495F77E8BD8D6576.size - 1];
    _id_E10E5A74D99B447A = _id_495F77E8BD8D6576[0];

    if(isDefined(_id_E297B70980F770A3._id_DEFBEED1A2C29C34)) {
      _id_E10E5A74D99B447A._id_DEFBEED1A2C29C34 = _id_E297B70980F770A3._id_DEFBEED1A2C29C34;

      if(!level.teambased)
        camera._id_59D945F45B4733EE = _id_E10E5A74D99B447A._id_DEFBEED1A2C29C34;
    }

    _id_495F77E8BD8D6576[_id_495F77E8BD8D6576.size - 1][[params._id_4C663252DABD1483]](1, 1);
    _id_495F77E8BD8D6576 = scripts\engine\utility::array_remove(_id_495F77E8BD8D6576, _id_495F77E8BD8D6576[_id_495F77E8BD8D6576.size - 1]);
  } else {
    if(isDefined(_id_495F77E8BD8D6576[1]))
      camera._id_DEFBEED1A2C29C34 = scripts\engine\utility::ter_op(_id_495F77E8BD8D6576[1]._id_DEFBEED1A2C29C34 == 0, 1, 0);
    else
      camera._id_DEFBEED1A2C29C34 = 0;

    if(!level.teambased)
      camera._id_59D945F45B4733EE = camera._id_DEFBEED1A2C29C34;
  }

  self._id_D381DA74CC527EC5[params._id_9C35CA95BD1D22FA] = _id_495F77E8BD8D6576;
}

_id_4BE323B74B86DBC9(camera) {
  params = _id_F0698AEE89C18210(camera._id_08862825A0618BDA);

  if(!isDefined(self.owner._id_D381DA74CC527EC5) || !isDefined(self.owner._id_D381DA74CC527EC5[params._id_9C35CA95BD1D22FA])) {
    return;
  }
  self.owner._id_D381DA74CC527EC5[params._id_9C35CA95BD1D22FA] = scripts\engine\utility::array_remove(self.owner._id_D381DA74CC527EC5[params._id_9C35CA95BD1D22FA], self);
}

_id_CEF7DB6ABFE1CEEB(camera) {
  self endon("disconnect");
  camera endon("death");

  if(!isDefined(camera._id_DEFBEED1A2C29C34)) {
    return;
  }
  while(!istrue(camera.isdestroyed)) {
    _id_5F04179F0ECE1FA3 = distance(self.origin, camera.origin);
    _id_5F04179F0ECE1FA3 = int(floor(_id_5F04179F0ECE1FA3 * 0.0254));
    self setclientomnvar("ui_tactical_camera_cam_" + camera._id_DEFBEED1A2C29C34 + "_distance", _id_5F04179F0ECE1FA3);
    wait 0.2;
  }
}

_id_945C96AD7442451F(a, b) {
  if(a.creationtime > b.creationtime)
    return 1;
  else
    return 0;
}

_id_15A4C63A63AF8B6B(a, b) {
  if(a._id_59D945F45B4733EE < b._id_59D945F45B4733EE)
    return 1;
  else
    return 0;
}

_id_583884AC581C52A4() {
  foreach(_id_C1E5E178D5D956E4 in level.calloutglobals.areatriggers) {
    if(self istouching(_id_C1E5E178D5D956E4)) {
      calloutarea = _id_C1E5E178D5D956E4.script_noteworthy;
      return level.calloutglobals.areaidmap[calloutarea];
    }
  }

  return undefined;
}

_id_45A7E0EDC973D037() {
  level endon("game_ended");
  self endon("explode");
  self endon("death");
  self._id_49996EBEBBBBF375 = 63;
  _id_4930CBCE302555B1 = _id_F0698AEE89C18210(self._id_08862825A0618BDA)._id_0315C43D476BB095;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    return;
  else {
    for(;;) {
      _id_A69D4E3F623C9031 = _id_583884AC581C52A4();

      if(isDefined(_id_A69D4E3F623C9031) && self._id_49996EBEBBBBF375 != _id_A69D4E3F623C9031) {
        self._id_49996EBEBBBBF375 = _id_A69D4E3F623C9031;
        level notify(_id_4930CBCE302555B1, self);
      }

      wait 0.1;
    }
  }
}

_id_23CF186C8B512748() {
  self endon("death");
  self.madedamageable = 1;
  params = _id_F0698AEE89C18210(self._id_08862825A0618BDA);
  thread scripts\mp\damage::monitordamage(params.maxhealth, "hitequip", params._id_604C545B594E97EC, params._id_4F1335FCE3765DA0);
}

_id_DA29E274CC4A86F4(camera) {
  camera endon("death");
  self endon("disconnect");
  level endon("game_ended");
  timeoutduration = _id_F0698AEE89C18210(camera._id_08862825A0618BDA).lifetime;
  timeelapsed = 0;

  while(timeelapsed < timeoutduration) {
    _id_77B3F0514A25C019 = (timeoutduration - timeelapsed) / timeoutduration;
    _id_77B3F0514A25C019 = int(ceil(clamp(_id_77B3F0514A25C019, 0, 1) * 100));
    camera._id_5C93B81B2052D23B = _id_77B3F0514A25C019;
    timeelapsed = timeelapsed + level.framedurationseconds;
    waitframe();
  }
}

_id_B0210563A392F1A1(camera) {
  camera endon("death");
  self endon("stopMonitoringReticleState");
  self endon("disconnect");
  reticlestate = 0;

  for(;;) {
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

_id_D506961E2710D1E1() {
  if(!isDefined(self._id_0DAE7E92E87A31E4))
    return 0;

  if(self._id_0DAE7E92E87A31E4.size > 0)
    return 1;

  return 0;
}

_id_D103DC61E5B6ABC3(player) {
  if(!isDefined(player)) {
    return;
  }
  if(level.teambased) {
    if(!isDefined(level._id_7D17467ECA3737AA) || !isDefined(level._id_7D17467ECA3737AA[player.team])) {
      return;
    }
    if(_id_58BE75C518BF0D40::shouldmodesetsquads()) {
      if(isDefined(level._id_7D17467ECA3737AA[player.team][player._id_0FF97225579DE16A]))
        return level._id_7D17467ECA3737AA[player.team][player._id_0FF97225579DE16A];
      else
        return;
    } else
      return level._id_7D17467ECA3737AA[player.team];
  } else
    return player.markedents;
}

_id_F91C0FEB9232B257(target) {
  if(!isDefined(target))
    return 0;

  _id_7305A0E8014E47BE = _id_D103DC61E5B6ABC3(self);

  if(!isDefined(_id_7305A0E8014E47BE))
    return 0;

  _id_161E86C260D6864C = _id_7305A0E8014E47BE[target getentitynumber()];

  if(!isDefined(_id_161E86C260D6864C))
    return 0;

  return istrue(_id_161E86C260D6864C.reconmarked);
}

_id_74598558CD270375(_id_BB093C5BEBC99B6F, _id_2F3CF0914D78AC25, target) {
  weaponicon = _id_BB093C5BEBC99B6F;
  weaponoffset = _id_2F3CF0914D78AC25;
  _id_558774275543A708 = spawnStruct();

  if(isDefined(target.weapon_name)) {
    weaponref = undefined;

    if(issubstr(target.weapon_name, "claymore"))
      weaponref = "equip_claymore";
    else if(issubstr(target.weapon_name, "c4"))
      weaponref = "equip_c4";
    else if(issubstr(target.weapon_name, "atMine"))
      weaponref = "equip_at_mine";
    else if(issubstr(target.weapon_name, "trophy"))
      weaponref = "equip_trophy";

    if(isDefined(weaponref)) {
      _id_58907637F9A8D293 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "getEquipmentTableInfo"))
        _id_58907637F9A8D293 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "getEquipmentTableInfo")]](weaponref);

      weaponicon = _id_58907637F9A8D293.image;
    }
  } else if(isDefined(target.streakinfo)) {
    _id_2B7CF61AF0CB9960 = target.streakinfo.streakname;
    _id_D442547D75DFFD09 = level._id_0B23156D776B1D85._id_038F2A11237246AC[_id_2B7CF61AF0CB9960];
    weaponicon = scripts\engine\utility::ter_op(isDefined(_id_D442547D75DFFD09) && isDefined(_id_D442547D75DFFD09._id_890BC2DE5DEADF64), _id_D442547D75DFFD09._id_890BC2DE5DEADF64, "");
    weaponoffset = 75;
  }

  _id_558774275543A708.weaponicon = weaponicon;
  _id_558774275543A708.weaponoffset = weaponoffset;
  return _id_558774275543A708;
}

_id_C2C3F444CFEB61CA(_id_161E86C260D6864C, player) {
  _id_F447BFDBB1256F69 = undefined;

  if(isDefined(_id_161E86C260D6864C.markingent.pilot))
    _id_F447BFDBB1256F69 = _id_161E86C260D6864C.markingent.pilot;
  else
    _id_F447BFDBB1256F69 = _id_161E86C260D6864C.markingent.owner;

  if(level.teambased) {
    if(_id_58BE75C518BF0D40::shouldmodesetsquads()) {
      _id_1B6AE0F8344F5CEA = scripts\mp\utility\teams::_id_3D0F2343793D709B(_id_F447BFDBB1256F69.team, _id_F447BFDBB1256F69._id_0FF97225579DE16A, 0);
      return scripts\engine\utility::array_contains(_id_1B6AE0F8344F5CEA, player);
    } else
      return scripts\mp\utility\player::isfriendly(_id_F447BFDBB1256F69.team, player);
  } else
    return player == _id_F447BFDBB1256F69;
}

_id_7D61D7B52C318D47() {
  self endon("disconnect");

  if(istrue(scripts\cp_mp\utility\player_utility::isusingremote())) {
    return;
  }
  _id_FC0043E95242D5CB = "recon_drone_flash";

  if(istrue(self.pers["useNVG"]))
    _id_FC0043E95242D5CB = "recon_drone_flash_nvg";

  self visionsetfadetoblackforplayer(_id_FC0043E95242D5CB, 0.05);
  wait 0.08;
  self visionsetfadetoblackforplayer("", 1.2);
}

_id_748F3520A7E525A9() {
  if(!isDefined(self.markedomnvar)) {
    self.markedomnvar = 1;
    self setclientomnvar("ui_rcd_target_notify", self.markedomnvar);
    thread _id_BEBD32F6BC2A781F();
  } else {
    if(self.markedomnvar == 1)
      self.markedomnvar = 2;
    else
      self.markedomnvar = 1;

    self setclientomnvar("ui_rcd_target_notify", self.markedomnvar);
  }
}

_id_BEBD32F6BC2A781F() {
  self endon("disconnect");
  self notify("markedUIUpdate");
  self endon("markedUIUpdate");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "get_mark_ui_duration"))
    wait(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "get_mark_ui_duration")]]());
  else
    wait 3;

  thread _id_3C3A95D13D184AC5();
}

_id_3C3A95D13D184AC5() {
  self notify("markedUIUpdate");
  self.markedomnvar = undefined;
  self setclientomnvar("ui_rcd_target_notify", 0);
}

_id_29E7D04CB1F3E556(player) {
  scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headiconbox, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconfaction, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self._id_654DFE33AAE5B35C, player);
}

_id_BF967BC1AC455BDF(player) {
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconbox, player);
  scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headiconfaction, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self._id_654DFE33AAE5B35C, player);
}

_id_7254A960F447A69B(player) {
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconbox, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconfaction, player);
  scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self._id_654DFE33AAE5B35C, player);
}

_id_002F6ABCF7FCC02F(player) {
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconbox, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headiconfaction, player);
  scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self._id_654DFE33AAE5B35C, player);
}

_id_67240DB2BF930CCD() {
  if(isDefined(self.headiconbox)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconbox);
    self.headiconbox = undefined;
  }

  if(isDefined(self.headiconfaction)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconfaction);
    self.headiconfaction = undefined;
  }

  if(isDefined(self._id_654DFE33AAE5B35C)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self._id_654DFE33AAE5B35C);
    self._id_654DFE33AAE5B35C = undefined;
  }
}

_id_686C35E781F41189(_id_5237A188CCDA4D7B) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      return;
    }
    _id_EA3E848C25E3C926(player, undefined, _id_5237A188CCDA4D7B);
  }
}

_id_49AABE4CB7C4C0A4(player, _id_5237A188CCDA4D7B) {
  if(isDefined(player.super) && player.super.staticdata.ref == _id_5237A188CCDA4D7B)
    return 1;
  else
    return 0;
}

_id_EA3E848C25E3C926(player, unset, _id_5237A188CCDA4D7B) {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.owner)) {
    return;
  }
  if(!isDefined(player)) {
    return;
  }
  _id_E8333833A81B6F0D = self.headiconbox;

  if(!isDefined(_id_E8333833A81B6F0D)) {
    return;
  }
  _id_D39DEA1586E13C6C = self.headiconfaction;

  if(!isDefined(_id_D39DEA1586E13C6C)) {
    return;
  }
  _id_D1C9D3655A4F3302 = self._id_654DFE33AAE5B35C;

  if(!isDefined(_id_D1C9D3655A4F3302)) {
    return;
  }
  isfriendly = scripts\mp\utility\player::isfriendly(self.owner.team, player);
  _id_7295A6A7D7AAFAD7 = _id_49AABE4CB7C4C0A4(player, _id_5237A188CCDA4D7B);

  if(isfriendly) {
    if(istrue(unset))
      _id_BF967BC1AC455BDF(player);
    else {
      if(_id_D506961E2710D1E1()) {
        _id_7254A960F447A69B(player);
        return;
      }

      if(_id_7295A6A7D7AAFAD7) {
        if(istrue(player.isusingcamera))
          _id_002F6ABCF7FCC02F(player);
        else
          _id_29E7D04CB1F3E556(player);

        return;
        return;
      }

      _id_BF967BC1AC455BDF(player);
    }
  } else
    _id_002F6ABCF7FCC02F(player);
}

_id_8B5781DD2D18A300(player) {
  _id_C1A442604B2C5E96 = player _id_EAF65BB46D1BD1A8();

  if(!isDefined(_id_C1A442604B2C5E96))
    return undefined;

  if(!level.teambased)
    return undefined;

  _id_6D5ED003AF1F9612 = undefined;
  _id_F5D0256E4366D1FF = _id_58BE75C518BF0D40::shouldmodesetsquads();

  if(_id_C1A442604B2C5E96 == self) {
    if(_id_F5D0256E4366D1FF)
      _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::_id_3D0F2343793D709B(player.team, player._id_0FF97225579DE16A, 1);
    else
      _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(player.team, "players");

    foreach(_id_F0EA4030349A33D5 in _id_6D5ED003AF1F9612) {
      if(_id_F0EA4030349A33D5 == player)
        continue;
      else if(!istrue(_id_F0EA4030349A33D5.isusingcamera))
        continue;
      else {
        scripts\cp_mp\targetmarkergroups::_id_69D232B5E8C5D652(player._id_8CC5D2E4CFBF42B0, _id_F0EA4030349A33D5);

        if(_id_F5D0256E4366D1FF) {
          level._id_8CC5D2E4CFBF42B0[player.team][player._id_0FF97225579DE16A] = _id_F0EA4030349A33D5;
          level._id_8CC5D2E4CFBF42B0[player.team][player._id_0FF97225579DE16A]._id_8CC5D2E4CFBF42B0 = player._id_8CC5D2E4CFBF42B0;
        } else {
          level._id_8CC5D2E4CFBF42B0[player.team] = _id_F0EA4030349A33D5;
          level._id_8CC5D2E4CFBF42B0[player.team]._id_8CC5D2E4CFBF42B0 = player._id_8CC5D2E4CFBF42B0;
        }

        player._id_8CC5D2E4CFBF42B0 = undefined;
        scripts\cp_mp\targetmarkergroups::_id_FD770A1099036688(level._id_8CC5D2E4CFBF42B0[player.team]._id_8CC5D2E4CFBF42B0, player);
        return _id_F0EA4030349A33D5;
      }
    }

    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(_id_C1A442604B2C5E96._id_8CC5D2E4CFBF42B0);

    if(_id_F5D0256E4366D1FF)
      level._id_8CC5D2E4CFBF42B0[player.team][player._id_0FF97225579DE16A] = undefined;
    else
      level._id_8CC5D2E4CFBF42B0[player.team] = undefined;
  }

  return undefined;
}

_id_EAF65BB46D1BD1A8() {
  _id_E1C6011321FD25B9 = undefined;
  team = self.team;

  if(level.teambased) {
    if(!isDefined(level._id_8CC5D2E4CFBF42B0) || !isDefined(level._id_8CC5D2E4CFBF42B0[team]))
      return undefined;

    if(_id_58BE75C518BF0D40::shouldmodesetsquads()) {
      if(!isDefined(level._id_8CC5D2E4CFBF42B0[team][self._id_0FF97225579DE16A]))
        return undefined;
      else
        return level._id_8CC5D2E4CFBF42B0[team][self._id_0FF97225579DE16A];
    } else
      return level._id_8CC5D2E4CFBF42B0[team];
  } else if(isDefined(self._id_8CC5D2E4CFBF42B0))
    return self;
}

_id_BFCDB898D70F248C() {
  team = self.team;
  _id_E1C6011321FD25B9 = _id_EAF65BB46D1BD1A8();

  if(!isDefined(_id_E1C6011321FD25B9) || !isDefined(_id_E1C6011321FD25B9._id_8CC5D2E4CFBF42B0)) {
    return;
  }
  if(level.teambased) {
    _id_838778220EEDE9FC = undefined;

    if(_id_E1C6011321FD25B9 == self) {
      _id_838778220EEDE9FC = _id_8B5781DD2D18A300(self);

      if(isDefined(_id_838778220EEDE9FC)) {
        scripts\cp_mp\targetmarkergroups::_id_FD770A1099036688(_id_838778220EEDE9FC._id_8CC5D2E4CFBF42B0, self);
        return;
      }

      return;
    }

    scripts\cp_mp\targetmarkergroups::_id_FD770A1099036688(_id_E1C6011321FD25B9._id_8CC5D2E4CFBF42B0, self);
    return;
  } else {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(_id_E1C6011321FD25B9._id_8CC5D2E4CFBF42B0);
    _id_E1C6011321FD25B9._id_8CC5D2E4CFBF42B0 = undefined;
  }
}

_id_EC57E0ACBC6C6879(_id_C8462289EDFC0ACA, target, state) {
  _id_7CBB905F3204B5D0 = (state >> 0) % 2 == 1;
  _id_01F6FF6A3877BF04 = (state >> 1) % 2 == 1;
  targetmarkergroupsetentitystate(_id_C8462289EDFC0ACA, target, _id_7CBB905F3204B5D0);
  targetmarkergroupsetextrastate(_id_C8462289EDFC0ACA, target, _id_01F6FF6A3877BF04);
}

_id_C9AD5AAF3183B83C() {
  markedents = _id_D103DC61E5B6ABC3(self);

  if(!isDefined(self)) {
    return;
  }
  if(level.teambased) {
    if(!isDefined(level._id_8CC5D2E4CFBF42B0))
      level._id_8CC5D2E4CFBF42B0 = [];

    if(_id_58BE75C518BF0D40::shouldmodesetsquads()) {
      if(!isDefined(level._id_8CC5D2E4CFBF42B0[self.team]))
        level._id_8CC5D2E4CFBF42B0[self.team] = [];

      if(!isDefined(level._id_8CC5D2E4CFBF42B0[self.team][self._id_0FF97225579DE16A])) {
        level._id_8CC5D2E4CFBF42B0[self.team][self._id_0FF97225579DE16A] = self;
        self._id_8CC5D2E4CFBF42B0 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self, undefined, self, 0, 0, 0);

        if(isDefined(markedents)) {
          foreach(ent in markedents) {
            if(isDefined(ent) && istrue(ent.reconmarked)) {
              scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(ent.target, self._id_8CC5D2E4CFBF42B0, 0);
              _id_EC57E0ACBC6C6879(self._id_8CC5D2E4CFBF42B0, ent.target, 2);
            }
          }
        }
      } else {
        _id_E97B73032A8F6B63 = level._id_8CC5D2E4CFBF42B0[self.team][self._id_0FF97225579DE16A]._id_8CC5D2E4CFBF42B0;
        scripts\cp_mp\targetmarkergroups::_id_B76F204EDB67EFC7(_id_E97B73032A8F6B63, self);
      }
    } else if(!isDefined(level._id_8CC5D2E4CFBF42B0[self.team])) {
      level._id_8CC5D2E4CFBF42B0[self.team] = self;
      self._id_8CC5D2E4CFBF42B0 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self, undefined, self, 0, 0, 0);

      if(isDefined(markedents)) {
        foreach(ent in markedents) {
          if(istrue(ent.reconmarked)) {
            scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(ent.target, self._id_8CC5D2E4CFBF42B0, 0);
            _id_EC57E0ACBC6C6879(self._id_8CC5D2E4CFBF42B0, ent.target, 2);
          }
        }
      }
    } else {
      _id_E1C6011321FD25B9 = level._id_8CC5D2E4CFBF42B0[self.team];
      scripts\cp_mp\targetmarkergroups::_id_B76F204EDB67EFC7(_id_E1C6011321FD25B9._id_8CC5D2E4CFBF42B0, self);
    }
  } else if(!isDefined(self._id_8CC5D2E4CFBF42B0)) {
    self._id_8CC5D2E4CFBF42B0 = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self, undefined, self, 0, 0, 0);

    if(isDefined(markedents)) {
      foreach(ent in markedents) {
        if(istrue(ent.reconmarked)) {
          scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(ent.target, self._id_8CC5D2E4CFBF42B0, 0);
          _id_EC57E0ACBC6C6879(self._id_8CC5D2E4CFBF42B0, ent.target, 2);
        }
      }
    }
  }
}

_id_89B59BEDB3802E41() {
  _id_E1C6011321FD25B9 = _id_EAF65BB46D1BD1A8();

  if(isDefined(_id_E1C6011321FD25B9)) {
    _id_C8462289EDFC0ACA = _id_E1C6011321FD25B9._id_8CC5D2E4CFBF42B0;
    return _id_C8462289EDFC0ACA;
  }
}

_id_FE1CD71ED406A649() {
  params = _id_F0698AEE89C18210(self._id_08862825A0618BDA);
  self.headiconbox = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], params._id_6C8C1A666ED5F48D, 5, 1, 1000, 100, undefined, 1);
  self.headiconfaction = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, undefined, 1);
  self._id_654DFE33AAE5B35C = scripts\cp_mp\entityheadicons::setheadicon_singleimage([], "icon_ping_warning", 5, 1, 1000, 100, undefined, 1);
  _id_686C35E781F41189(params._id_5237A188CCDA4D7B);
}

_id_B3D22408D6A4C7AC() {
  if(isDefined(self._id_81BD7C12AC1DCE18) && self._id_81BD7C12AC1DCE18.size > 0) {
    _id_7D4CA51D82F94BE6 = getfirstarraykey(self._id_81BD7C12AC1DCE18);
    _id_298F2CF18F67224A = self._id_1B381F3AA944D595[_id_7D4CA51D82F94BE6];

    foreach(player in self._id_81BD7C12AC1DCE18) {
      entnum = player getentitynumber();
      timestamp = self._id_1B381F3AA944D595[entnum];

      if(timestamp < _id_298F2CF18F67224A)
        _id_7D4CA51D82F94BE6 = entnum;
    }

    return _id_7D4CA51D82F94BE6;
  }
}

_id_3098442B001F283A(player) {
  _id_FA103815A248994B = 0;

  if(isDefined(self._id_81BD7C12AC1DCE18))
    _id_FA103815A248994B = scripts\engine\utility::array_contains(self._id_81BD7C12AC1DCE18, player);
}

_id_A96F380B39543647(camera) {
  level endon("game_ended");
  camera endon("death");
  camera endon("explode");
  camera notify("updateTag");
  camera endon("updateTag");
  self endon("disconnect");

  while(isDefined(camera.pilot)) {
    camera._id_A820130A6D38F1E4.angles = camera.pilot getplayerangles();
    waitframe();
  }
}

_id_CA19A92A4F9D5C3D(_id_08862825A0618BDA) {
  self endon("death");
  level endon("game_ended");
  self endon("disconnect");
  self notify("monitoringPlayerExit");
  self endon("monitoringPlayerExit");
  self.pilot waittill("playerLeavingCurrentCamera");
  params = _id_F0698AEE89C18210(_id_08862825A0618BDA);

  if(isDefined(self._id_81BD7C12AC1DCE18) && self._id_81BD7C12AC1DCE18.size > 0) {
    _id_FE8F7703F6313ED4 = _id_B3D22408D6A4C7AC();
    _id_C888A471B47D0B99 = self._id_81BD7C12AC1DCE18[_id_FE8F7703F6313ED4];
    timestamp = self._id_1B381F3AA944D595[_id_FE8F7703F6313ED4];

    if(!isDefined(self.pilot)) {
      _id_C888A471B47D0B99[[params._id_BE3314F77FEF5D6B]](self, 1);
      waitframe();

      if(isDefined(_id_C888A471B47D0B99) && isDefined(self))
        _id_C888A471B47D0B99 thread[[params.startfunc]](self);
    }
  }
}

_id_E910B2EBA1AF834C() {
  _id_FC36664F5893D75D = 1000;
  starttime = gettime();

  while(gettime() - starttime < _id_FC36664F5893D75D) {
    self disablephysicaldepthoffieldscripting();
    waitframe();
  }
}

_id_06976F2B3945C32F(_id_08862825A0618BDA) {
  _id_BE3314F77FEF5D6B = _id_F0698AEE89C18210(_id_08862825A0618BDA)._id_BE3314F77FEF5D6B;

  if(isDefined(self.pilot))
    self.pilot _id_CDB15C1F9CAB7852(self, _id_08862825A0618BDA);

  if(isDefined(self._id_81BD7C12AC1DCE18) && self._id_81BD7C12AC1DCE18.size > 0) {
    foreach(_id_F3C3089E456BD1FB in self._id_81BD7C12AC1DCE18)
    _id_F3C3089E456BD1FB[[_id_BE3314F77FEF5D6B]](self, 0);
  }
}

_id_3ECFBD63A3E3BED3(player) {
  if(!isDefined(self))
    return 0;

  status = 0;
  distsq = distancesquared(self.origin, player.origin);

  if(self.hasexploded)
    status = 3;
  else if(distsq > _id_F0698AEE89C18210(self._id_08862825A0618BDA)._id_0EFF1AB975C47FE2)
    status = 2;
  else if(scripts\cp_mp\emp_debuff::is_empd())
    status = 4;
  else
    status = 1;

  return status;
}

_id_9B4DB9A4213984CE(camera, index, state, time) {
  camera notify("cameraStatusWait");
  camera endon("cameraStatusWait");
  wait(time);

  if(state == 3 || !isDefined(camera))
    thread _id_45556AA41F4F9AE8(camera, index, 0);
  else if(_id_0309C31383EFD7D3(camera))
    thread _id_45556AA41F4F9AE8(camera, index, 5);
  else
    thread _id_45556AA41F4F9AE8(camera, index, 1);
}

_id_081FB12166C3C0C2(player, unset, _id_C380EB54A8ADB38C, _id_5237A188CCDA4D7B) {
  _id_EC9D4D0EC3D77690 = player[[_id_C380EB54A8ADB38C]]();

  if(!isDefined(_id_EC9D4D0EC3D77690)) {
    return;
  }
  foreach(camera in _id_EC9D4D0EC3D77690)
  camera _id_EA3E848C25E3C926(player, unset, _id_5237A188CCDA4D7B);
}

_id_B3B59C099F93A503(_id_D20DFBBBCD940269) {
  self endon("death");
  params = _id_F0698AEE89C18210(self._id_08862825A0618BDA);
  lifetime = getdvarint("dvar_13717E6E87CB530F", 120);
  _id_8578449C3BEC6372(lifetime, _id_D20DFBBBCD940269);

  if(isDefined(self) && !istrue(self.isdestroyed))
    self thread[[params._id_4C663252DABD1483]]();
}

_id_8578449C3BEC6372(_id_50F9DC4F0164E90F, _id_D20DFBBBCD940269) {
  if(!istrue(_id_D20DFBBBCD940269)) {
    self.owner endon("disconnect");
    self.owner endon("joined_team");
    self.owner endon("joined_spectators");
  }

  level endon("game_ended");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(_id_50F9DC4F0164E90F);
}

_id_57B6E09EDA0090D6(_id_E036BEB70DA584EC, _id_6D693A3A62AA8398) {
  if(_id_E036BEB70DA584EC)
    scripts\mp\supers::_id_7203E7AA96FF0BA9(27);
  else
    scripts\mp\supers::_id_7203E7AA96FF0BA9(0, _id_6D693A3A62AA8398);
}

_id_4E3AA9D829B3E164(target) {
  if(!isDefined(target))
    return 0;

  _id_027B697504D9397D = 0;
  _id_FBCABD62B8F66EB8 = physics_createcontents(["physicscontents_itemclip", "physicscontents_item", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_ainosight"]);
  _id_EB381492A5DB110A = undefined;

  if(isDefined(self.pilot))
    _id_EB381492A5DB110A = self.pilot getvieworigin();
  else
    _id_EB381492A5DB110A = self.origin + anglestoup(self.angles) * 3.5;

  _id_08A4EA3A3BAA22E4 = target.origin;
  _id_D895C679F6A927E5 = [_id_08A4EA3A3BAA22E4];

  if(isPlayer(target)) {
    _id_295719F06C03407F = (0, 0, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive"))
      _id_295719F06C03407F = target[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceTop")]]();

    _id_FC60036BA7BF253A = (0, 0, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive"))
      _id_FC60036BA7BF253A = target[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceCenter")]]();

    _id_D895C679F6A927E5 = [_id_295719F06C03407F, _id_FC60036BA7BF253A, _id_08A4EA3A3BAA22E4];
  } else if(isagent(target))
    _id_D895C679F6A927E5 = [_id_08A4EA3A3BAA22E4 + (0, 0, 1)];

  ignorelist = [self, target];
  vehicle = target scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(vehicle)) {
    ignorelist[ignorelist.size] = vehicle;
    _id_BB7AC665413117FC = vehicle getlinkedchildren(1);

    foreach(child in _id_BB7AC665413117FC)
    ignorelist[ignorelist.size] = vehicle;
  }

  _id_027B697504D9397D = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D895C679F6A927E5.size; _id_AC0E594AC96AA3A8++) {
    trace = scripts\engine\trace::sphere_trace(_id_EB381492A5DB110A, _id_D895C679F6A927E5[_id_AC0E594AC96AA3A8], 0.01, ignorelist, _id_FBCABD62B8F66EB8, undefined, 1);

    if(trace["hittype"] == "hittype_none") {
      _id_027B697504D9397D = 1;
      break;
    }
  }

  return _id_027B697504D9397D;
}

_id_F597EC02DB6AA057(_id_161E86C260D6864C, timeout) {
  self.owner endon("disconnect");

  if(isDefined(self.pilot))
    self.pilot endon("disconnect");

  target = _id_161E86C260D6864C.target;
  target endon("death");
  starttime = gettime();

  while(timeout * 1000 + starttime >= gettime()) {
    wait 0.05;
    _id_192CC07924877D71 = 0;

    if(scripts\cp_mp\emp_debuff::is_empd()) {
      break;
    }

    _id_368AE33CB19F91F8 = _id_9D2BEC87E0754872(target);

    if(isDefined(self.pilot) && isDefined(self) && isDefined(self.owner) && _id_368AE33CB19F91F8._id_20AA5B4097887CB6 && _id_368AE33CB19F91F8._id_CC86ADA7DF8F6C2F && _id_368AE33CB19F91F8._id_C37B1CC67943336D)
      _id_192CC07924877D71 = 1;

    if(_id_192CC07924877D71)
      starttime = gettime();
  }
}

_id_54DEA0F6292103CB() {
  pilot = self.pilot;
  pilot endon("disconnect");
  self endon("death");
  pilot endon("playerLeavingCurrentCamera");
  _id_820E590CB5620371 = 0;
  self.markingtarget = undefined;

  for(;;) {
    if(!isDefined(pilot)) {
      return;
    }
    self.targethascoldblooded = 0;
    targets = self.pilot.targetsinouterradius;
    _id_C8462289EDFC0ACA = self.pilot _id_89B59BEDB3802E41();

    foreach(player in targets) {
      if(_id_820E590CB5620371 >= 3) {
        _id_820E590CB5620371 = 0;
        waitframe();
      }

      if(isPlayer(player) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](player))
          continue;
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
      if(pilot _id_F91C0FEB9232B257(player)) {
        continue;
      }
      _id_820E590CB5620371++;
      _id_EC57E0ACBC6C6879(_id_C8462289EDFC0ACA, player, 1);
      _id_368AE33CB19F91F8 = _id_9D2BEC87E0754872(player);
      _id_177716BEC3407A6A = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(isPlayer(player) && player[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline"))
          _id_177716BEC3407A6A = 1;
      }

      if(_id_368AE33CB19F91F8._id_20AA5B4097887CB6 && _id_177716BEC3407A6A)
        self.targethascoldblooded = 1;

      if(_id_177716BEC3407A6A) {
        _id_EC57E0ACBC6C6879(_id_C8462289EDFC0ACA, player, 3);
        continue;
      }

      if(!_id_368AE33CB19F91F8._id_20AA5B4097887CB6) {
        continue;
      }
      if(istrue(self.markingtarget)) {
        continue;
      }
      thread _id_A295DFCB64A39664(player, "enemy", 0, 1);
    }

    _id_820E590CB5620371 = 0;
    waitframe();
  }
}

_id_348F9AA9CCB88FFA(target) {
  if(!isDefined(self._id_0DAE7E92E87A31E4))
    self._id_0DAE7E92E87A31E4 = [];

  if(isDefined(self._id_0DAE7E92E87A31E4[target getentitynumber()]))
    return;
  else {
    _id_7150DFF45B6D6577 = spawnStruct();
    _id_7150DFF45B6D6577.target = target;
    _id_7150DFF45B6D6577.entnum = target getentitynumber();
    self._id_0DAE7E92E87A31E4[target getentitynumber()] = _id_7150DFF45B6D6577;
    return _id_7150DFF45B6D6577;
  }
}

_id_8B7C344955F8B4C5(_id_7150DFF45B6D6577, _id_57B8F3BCFCA33A4B, _id_5237A188CCDA4D7B) {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  wait(_id_57B8F3BCFCA33A4B);
  _id_B61404171C7A024B(_id_7150DFF45B6D6577);
  _id_686C35E781F41189(_id_5237A188CCDA4D7B);
}

_id_B61404171C7A024B(_id_7150DFF45B6D6577) {
  if(isDefined(self._id_0DAE7E92E87A31E4[_id_7150DFF45B6D6577.entnum]))
    self._id_0DAE7E92E87A31E4[_id_7150DFF45B6D6577.entnum] = undefined;
}

_id_5A659105BA755498(target, _id_57B8F3BCFCA33A4B, _id_5237A188CCDA4D7B) {
  _id_7150DFF45B6D6577 = _id_348F9AA9CCB88FFA(target);

  if(!isDefined(_id_7150DFF45B6D6577)) {
    return;
  }
  self playsoundtoplayer("ui_camera_proximity_alert", self.owner, self);
  _id_686C35E781F41189(_id_5237A188CCDA4D7B);
  self.owner thread _id_45556AA41F4F9AE8(self, self._id_DEFBEED1A2C29C34, 2, undefined, 3.25);
  thread _id_8B7C344955F8B4C5(_id_7150DFF45B6D6577, _id_57B8F3BCFCA33A4B, _id_5237A188CCDA4D7B);
}

_id_FF216D4D2C47565C(state) {
  self setclientomnvar("ui_rcd_controls", state);
}

_id_C9FCE57D5DA1F571(camera, _id_43B83976503B9E6D) {
  if(!isDefined(self) || !isDefined(camera)) {
    return;
  }
  level endon("game_ended");
  self endon("disconnect");
  self endon("end_remote");
  self endon("monitoringExit");
  camera endon("death");

  while(self useButtonPressed())
    waitframe();

  holdtime = getdvarfloat("dvar_8720EAD849D3FBC3", 0.25);

  if(isDefined(_id_43B83976503B9E6D))
    holdtime = _id_43B83976503B9E6D;

  _id_038FC7BD1495C4B2 = level.framedurationseconds;
  _id_6A16936225A5A8CE = 1;

  for(;;) {
    _id_23B90B34FECC58CD = 0;

    if(_id_6A16936225A5A8CE == 1) {
      self setclientomnvar("ui_exit_progress", 0);
      _id_6A16936225A5A8CE = 0;
    }

    while(self useButtonPressed()) {
      if(istrue(self._id_A7D181863F388645)) {
        break;
      }

      _id_86EB80FF19554B0C = self usinggamepad();

      if(!_id_86EB80FF19554B0C && camera._id_08862825A0618BDA == "tacCam")
        holdtime = 0.01;

      _id_23B90B34FECC58CD = _id_23B90B34FECC58CD + _id_038FC7BD1495C4B2;
      _id_6A16936225A5A8CE = 1;
      self setclientomnvar("ui_exit_progress", _id_23B90B34FECC58CD / holdtime);

      if(_id_23B90B34FECC58CD > holdtime) {
        self notify("cameraExit");
        return;
      }

      wait(_id_038FC7BD1495C4B2);
    }

    wait(_id_038FC7BD1495C4B2);
  }
}

_id_9AC601E206D92DEF(camera, _id_C748B31A33C02C14, _id_08862825A0618BDA) {
  level endon("game_ended");
  camera endon("death");
  self endon("death_or_disconnect");
  self endon("stopMonitoringCamera");

  if(!isDefined(_id_C748B31A33C02C14))
    _id_C748B31A33C02C14 = _id_F0698AEE89C18210(_id_08862825A0618BDA)._id_BE3314F77FEF5D6B;

  childthread _id_C9FCE57D5DA1F571(camera);
  self waittill("cameraExit");
  self thread[[_id_C748B31A33C02C14]](camera, 0);
}

_id_CDB15C1F9CAB7852(camera, _id_08862825A0618BDA) {
  _id_83049232BCF4E965 = _id_367656975DB3F139(camera);

  if(!istrue(_id_83049232BCF4E965) && !istrue(self._id_A7D181863F388645))
    self thread[[_id_F0698AEE89C18210(_id_08862825A0618BDA)._id_BE3314F77FEF5D6B]](camera, 0, 1);
}

_id_073AF051EC0973E1(camera, _id_DED994656B8D402A, _id_08862825A0618BDA) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stopMonitoringCamera");
  camera endon("death");

  for(;;) {
    _id_C7AAF56EC881E7B1 = scripts\engine\utility::array_contains(self._id_7D73CBB5CA5D6E32[_id_DED994656B8D402A], camera);

    if(!_id_C7AAF56EC881E7B1) {
      break;
    }

    wait 0.25;
  }

  _id_CDB15C1F9CAB7852(camera, _id_08862825A0618BDA);
}

_id_4842C3896892DC17(_id_161E86C260D6864C, _id_B995F95867DE9AAB) {
  _id_5EC35B0D0E09922D = _id_B995F95867DE9AAB.team;

  if(level.teambased) {
    if(isDefined(level._id_7D17467ECA3737AA)) {
      if(_id_58BE75C518BF0D40::shouldmodesetsquads()) {
        if(isDefined(level._id_7D17467ECA3737AA[_id_5EC35B0D0E09922D][_id_B995F95867DE9AAB._id_0FF97225579DE16A]))
          level._id_7D17467ECA3737AA[_id_5EC35B0D0E09922D][_id_B995F95867DE9AAB._id_0FF97225579DE16A] = scripts\engine\utility::array_remove_key(level._id_7D17467ECA3737AA[_id_5EC35B0D0E09922D][_id_B995F95867DE9AAB._id_0FF97225579DE16A], _id_161E86C260D6864C.targetnum);
      } else if(isDefined(level._id_7D17467ECA3737AA[_id_5EC35B0D0E09922D]))
        level._id_7D17467ECA3737AA[_id_5EC35B0D0E09922D] = scripts\engine\utility::array_remove_key(level._id_7D17467ECA3737AA[_id_5EC35B0D0E09922D], _id_161E86C260D6864C.targetnum);
    }
  } else if(isDefined(_id_B995F95867DE9AAB.markedents))
    _id_B995F95867DE9AAB.markedents = scripts\engine\utility::array_remove_key(_id_B995F95867DE9AAB.markedents, _id_161E86C260D6864C.targetnum);
}

_id_9921A8095E089065(_id_161E86C260D6864C, _id_B995F95867DE9AAB) {
  _id_5EC35B0D0E09922D = _id_B995F95867DE9AAB.team;

  if(level.teambased) {
    if(!isDefined(level._id_7D17467ECA3737AA))
      level._id_7D17467ECA3737AA = [];

    if(!isDefined(level._id_7D17467ECA3737AA[_id_5EC35B0D0E09922D]))
      level._id_7D17467ECA3737AA[_id_5EC35B0D0E09922D] = [];

    if(_id_58BE75C518BF0D40::shouldmodesetsquads()) {
      if(!isDefined(level._id_7D17467ECA3737AA[_id_5EC35B0D0E09922D][_id_B995F95867DE9AAB._id_0FF97225579DE16A]))
        level._id_7D17467ECA3737AA[_id_5EC35B0D0E09922D][_id_B995F95867DE9AAB._id_0FF97225579DE16A] = [];

      level._id_7D17467ECA3737AA[_id_5EC35B0D0E09922D][_id_B995F95867DE9AAB._id_0FF97225579DE16A][_id_161E86C260D6864C.targetnum] = _id_161E86C260D6864C;
    } else
      level._id_7D17467ECA3737AA[_id_5EC35B0D0E09922D][_id_161E86C260D6864C.targetnum] = _id_161E86C260D6864C;
  } else {
    if(!isDefined(_id_B995F95867DE9AAB.markedents))
      _id_B995F95867DE9AAB.markedents = [];

    _id_B995F95867DE9AAB.markedents[_id_161E86C260D6864C.targetnum] = _id_161E86C260D6864C;
  }
}

_id_47C44D1BF801B8F0(_id_161E86C260D6864C, _id_B995F95867DE9AAB, useoutline) {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(_id_161E86C260D6864C.headicon);
  _id_5EC35B0D0E09922D = _id_B995F95867DE9AAB.team;
  _id_C8462289EDFC0ACA = _id_B995F95867DE9AAB _id_89B59BEDB3802E41();
  _id_4842C3896892DC17(_id_161E86C260D6864C, _id_B995F95867DE9AAB);

  if(isDefined(_id_161E86C260D6864C.target)) {
    if(isDefined(_id_C8462289EDFC0ACA) && scripts\cp_mp\targetmarkergroups::targetmarkergroupexists(_id_C8462289EDFC0ACA))
      _id_EC57E0ACBC6C6879(_id_C8462289EDFC0ACA, _id_161E86C260D6864C.target, 0);

    _id_161E86C260D6864C.reconmarked = undefined;
    _id_161E86C260D6864C.beingmarked = undefined;

    if(isPlayer(_id_161E86C260D6864C.target) && useoutline) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineDisable"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineDisable")]](_id_161E86C260D6864C.outlineid, _id_161E86C260D6864C.target);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "hudOutlineViewmodelDisable"))
        _id_161E86C260D6864C.target[[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "hudOutlineViewmodelDisable")]]();
    }

    _id_161E86C260D6864C.target notify(_id_161E86C260D6864C.notifytoendmark);
  }
}

_id_C84CFCB1299F9B39() {
  if(isDefined(self.pilot))
    return self.pilot;
  else
    return self.owner;
}

_id_362C9A13D18031B1(_id_7295A7FAFBE0D543, _id_4DF19EF5B565978E, _id_9410874EE76BF58E) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(_id_9410874EE76BF58E);
  laststate = [];

  for(;;) {
    self waittill(_id_7295A7FAFBE0D543, camera, index, state, _id_BF15527477B41565, time);

    if(isDefined(laststate[index])) {
      if(isDefined(laststate[index][0])) {
        if(laststate[index][0] != camera) {
          if(state == 0 || state == 3 || state == 5)
            continue;
        }
      }
    }

    self setclientomnvar(_id_4DF19EF5B565978E + index + "_status", state);

    if(state > 1 && state != 5)
      childthread _id_9B4DB9A4213984CE(camera, index, state, time);

    if(!isDefined(camera)) {
      laststate[index] = undefined;
      continue;
    }

    laststate[index] = [camera, state];
  }
}

_id_7858AA4F2BC91D80() {
  starttime = gettime();
  timeelapsed = starttime;

  while(timeelapsed < starttime + 10) {
    thread _id_FF216D4D2C47565C(0);
    timeelapsed = timeelapsed + (gettime() - timeelapsed);
    waitframe();
  }
}

_id_B501CE7305720779(camera) {
  _id_4A3BBCEA93CB04C5 = 0;

  if(!isDefined(camera.owner))
    return 0;

  if(level.teambased) {
    if(_id_58BE75C518BF0D40::shouldmodesetsquads()) {
      if(camera.owner._id_0FF97225579DE16A == self._id_0FF97225579DE16A)
        _id_4A3BBCEA93CB04C5 = 1;
    } else if(camera.ownerteam == self.team)
      _id_4A3BBCEA93CB04C5 = 1;
  } else if(camera.owner == self)
    _id_4A3BBCEA93CB04C5 = 1;

  return _id_4A3BBCEA93CB04C5;
}

_id_F6BA29EFE27B0F81(target) {
  if(!isDefined(target))
    return 0;

  _id_EFB14E53541B5B48 = self gettagangles("tag_player");
  _id_51743D62F4CF524E = self gettagorigin("tag_player");

  if(isDefined(self.pilot)) {
    _id_EFB14E53541B5B48 = self.pilot getplayerangles();
    _id_51743D62F4CF524E = self.pilot getvieworigin();
  }

  _id_B5837EE451EABC71 = anglesToForward(_id_EFB14E53541B5B48);
  _id_08A4EA3A3BAA22E4 = target.origin;
  _id_295719F06C03407F = (0, 0, 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive"))
    _id_295719F06C03407F = target[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceTop")]]();

  _id_FC60036BA7BF253A = (0, 0, 0);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive"))
    _id_FC60036BA7BF253A = target[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getStanceCenter")]]();

  _id_D895C679F6A927E5 = [_id_295719F06C03407F, _id_FC60036BA7BF253A, _id_08A4EA3A3BAA22E4];
  _id_9AE205C4C40AF967 = 0;

  foreach(point in _id_D895C679F6A927E5) {
    _id_F4A43E5290BCE44B = point - _id_51743D62F4CF524E;
    _id_56699F8802BAA8E7 = scripts\engine\math::anglebetweenvectors(_id_B5837EE451EABC71, _id_F4A43E5290BCE44B);
    _id_878F0EB51AB6A646 = scripts\engine\math::anglebetweenvectors(_id_B5837EE451EABC71, (0, 0, 1));
    _id_CEA5805C08F245D2 = scripts\engine\math::anglebetweenvectors(_id_F4A43E5290BCE44B, (0, 0, 1));

    if(isDefined(self.pilot)) {
      _id_E077F4A68ED9A464 = distancesquared(_id_51743D62F4CF524E, point);

      if(_id_E077F4A68ED9A464 > 10000) {
        if(abs(abs(_id_878F0EB51AB6A646) - abs(_id_CEA5805C08F245D2)) > getdvarfloat("dvar_77F60C1216FCA977", 19))
          return _id_9AE205C4C40AF967;
      }
    }

    if(_id_56699F8802BAA8E7 <= getdvarfloat("dvar_0A20D9FBEAB627F6", 31))
      _id_9AE205C4C40AF967 = 1;
  }

  return _id_9AE205C4C40AF967;
}

_id_1B1409AF5E47B098(_id_D89F028A5C8DB805, _id_C6CFD7BE26D2C7DF, _id_5E43B44751D01B1A) {
  if(!isDefined(_id_D89F028A5C8DB805))
    return 0;

  _id_9B96536B85A38BC6 = 0;
  targetorigin = _id_D89F028A5C8DB805.origin;
  _id_4E95FB5DDDA03A33 = [targetorigin];
  _id_C3D9E0B30C6F14A4 = distancesquared(self getvieworigin(), _id_D89F028A5C8DB805.origin);
  _id_251F6FF6684A460C = 0;

  if(_id_C3D9E0B30C6F14A4 <= 10000) {
    _id_5E43B44751D01B1A = _id_5E43B44751D01B1A * getdvarfloat("dvar_20C9852B3129DE04", 2.5);
    _id_251F6FF6684A460C = 1;
  }

  if(isPlayer(_id_D89F028A5C8DB805)) {
    _id_40E2F5706584505C = _id_D89F028A5C8DB805 _meth_415FE9EECA7B2E2B();
    _id_295719F06C03407F = _id_D89F028A5C8DB805 scripts\mp\utility\player::getstancetop();
    _id_FC60036BA7BF253A = _id_D89F028A5C8DB805 scripts\mp\utility\player::getstancecenter();
    _id_4E95FB5DDDA03A33 = [_id_295719F06C03407F, _id_FC60036BA7BF253A];

    if(!_id_40E2F5706584505C)
      _id_4E95FB5DDDA03A33 = scripts\engine\utility::array_add(_id_4E95FB5DDDA03A33, targetorigin);

    if(_id_251F6FF6684A460C) {
      _id_102502C44898B35C = (_id_295719F06C03407F + _id_FC60036BA7BF253A) / 2;
      extrapoints = [_id_102502C44898B35C];

      if(!_id_40E2F5706584505C) {
        _id_0264B006395220D6 = (_id_FC60036BA7BF253A + targetorigin) / 2;
        extrapoints = scripts\engine\utility::array_add(extrapoints, _id_0264B006395220D6);
      }

      _id_4E95FB5DDDA03A33 = scripts\engine\utility::array_combine(_id_4E95FB5DDDA03A33, extrapoints);
    }
  } else if(isagent(_id_D89F028A5C8DB805)) {
    _id_FC60036BA7BF253A = _id_D89F028A5C8DB805 scripts\mp\agents\agent_utility::_id_B071E509C0FB69B0();
    _id_295719F06C03407F = _id_D89F028A5C8DB805 scripts\mp\agents\agent_utility::_id_2E1B23386B967C10();
    _id_4E95FB5DDDA03A33 = [targetorigin + (0, 0, 1), _id_FC60036BA7BF253A, _id_295719F06C03407F];

    if(_id_251F6FF6684A460C) {
      _id_0264B006395220D6 = (_id_FC60036BA7BF253A + targetorigin) / 2;
      _id_102502C44898B35C = (_id_295719F06C03407F + _id_FC60036BA7BF253A) / 2;
      extrapoints = [_id_0264B006395220D6, _id_102502C44898B35C];
      _id_4E95FB5DDDA03A33 = scripts\engine\utility::array_combine(_id_4E95FB5DDDA03A33, extrapoints);
    }
  }

  foreach(point in _id_4E95FB5DDDA03A33) {
    if(self worldpointinreticle_circle(point, _id_C6CFD7BE26D2C7DF, _id_5E43B44751D01B1A)) {
      _id_9B96536B85A38BC6 = 1;
      break;
    }
  }

  return _id_9B96536B85A38BC6;
}

_id_F254912B43C0F30A(target) {
  if(!isDefined(target))
    return 0;

  return scripts\engine\utility::array_contains(self.pilot.targetsinouterradius, target);
}

_id_58A0CAD2ABA60238(camera) {
  return isDefined(camera.pilot) && self == camera.pilot;
}

_id_FC9294FFBD3490F3() {
  self notify("supportBox_makeUnusable");
  scripts\common\interactive::interactive_removeusedcallbackfromentity();
  self makeunusable();
  self.playersused = undefined;
}

_id_88B3522BBDF2F7C1(_id_E036BEB70DA584EC) {
  _id_68D9E792FE9DEF4D = "off";

  if(_id_E036BEB70DA584EC)
    _id_68D9E792FE9DEF4D = "on";

  self setscriptablepartstate("target_marked", _id_68D9E792FE9DEF4D, 0);
}

_id_0E593B8F6770C67E(_id_161E86C260D6864C) {
  foreach(player in level.players) {
    if(!isDefined(player)) {
      return;
    }
    _id_F1493744AA061205(_id_161E86C260D6864C, player);
  }
}

_id_F1493744AA061205(_id_161E86C260D6864C, player) {
  if(!isDefined(_id_161E86C260D6864C)) {
    return;
  }
  isfriendly = _id_C2C3F444CFEB61CA(_id_161E86C260D6864C, player);
  isusingcamera = isDefined(_id_161E86C260D6864C.markingent) && istrue(player.isusingcamera);

  if(isDefined(_id_161E86C260D6864C.headicon)) {
    if(isfriendly && !isusingcamera)
      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(_id_161E86C260D6864C.headicon, player);
    else
      scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(_id_161E86C260D6864C.headicon, player);
  }
}

_id_57D6A393B90824DC(_id_C978CB0E8E5AB65D) {
  level._id_E87DB96E1A77A100 = _id_C978CB0E8E5AB65D;
}

_id_6436809A4ED7E363() {
  if(_id_2E2AC10BD717D529(self._id_08862825A0618BDA, self.origin, self.owner.team))
    return 0;

  if(scripts\mp\outofbounds::ispointinoutofbounds(self.origin, self.owner.team))
    return 0;

  if(isDefined(level._id_CA4E08767CBDAE12)) {
    _id_425925A45729DEAE = self[[level._id_CA4E08767CBDAE12]]();

    if(!_id_425925A45729DEAE)
      return 0;
  }

  if(!isDefined(level._id_E87DB96E1A77A100))
    return 1;

  if(self.origin[2] > level._id_E87DB96E1A77A100)
    return 0;

  return 1;
}

_id_5E8B74F5E3DC4C60() {
  self.owner endon("disconnect");
  self endon("death");
  _id_1C945B3BA45AE582 = _id_F0698AEE89C18210(self._id_08862825A0618BDA)._id_4C663252DABD1483;

  for(;;) {
    isoob = scripts\mp\outofbounds::ispointinoutofbounds(self.origin, self.owner.team);
    _id_44ED718EE62282E1 = _id_6436809A4ED7E363();

    if(isoob || !_id_44ED718EE62282E1) {
      if(istrue(self._id_11F51147CCFF0163))
        self.owner scripts\mp\supers::refundsuper();

      self thread[[_id_1C945B3BA45AE582]]();
    }

    wait 0.1;
  }
}

_id_2E2AC10BD717D529(_id_08862825A0618BDA, _id_863C619037F3AC74, _id_DA8CEC9BCE12F9CB) {
  _id_E448B9771980DFD6 = 0;
  _id_AC939183EB3C79D8 = _id_F0698AEE89C18210(_id_08862825A0618BDA)._id_0106BF36856A998F;

  if(!isDefined(_id_AC939183EB3C79D8))
    return _id_E448B9771980DFD6;
  else {
    foreach(trigger in _id_AC939183EB3C79D8) {
      if(ispointinvolume(_id_863C619037F3AC74, trigger)) {
        if(isDefined(trigger.script_team) && isDefined(_id_DA8CEC9BCE12F9CB) && trigger.script_team != _id_DA8CEC9BCE12F9CB)
          continue;
        else {
          _id_E448B9771980DFD6 = 1;
          break;
        }
      }
    }
  }

  return _id_E448B9771980DFD6;
}

_id_66758C7FFF976896() {
  if(!isDefined(self.creationtime))
    return 1;

  if(self.creationtime + 50 >= gettime())
    return 1;

  if(istrue(self._id_86B37B7A946B6A67))
    return 1;

  return 0;
}

_id_E170D8C3CACDBAF5(camera, _id_CDE48A8A76BC5CD0, _id_08862825A0618BDA) {
  level endon("game_ended");
  self endon("disconnect");
  camera endon("entering");

  if(isDefined(_id_CDE48A8A76BC5CD0))
    self endon(_id_CDE48A8A76BC5CD0);

  _id_C748B31A33C02C14 = _id_F0698AEE89C18210(_id_08862825A0618BDA)._id_BE3314F77FEF5D6B;
  scripts\engine\utility::waittill_any_4("death", "killed_player", "last_stand_start", "successful_exfil");

  if(istrue(self.isusingcamera))
    [[_id_C748B31A33C02C14]](camera, 0);
}

_id_3C4DA29D1ED157C7(_id_DED994656B8D402A, _id_CDE48A8A76BC5CD0, _id_083FA915761BEF20, _id_CDC5DD6C28C9709D, _id_C380EB54A8ADB38C) {
  level endon("game_ended");
  self endon("disconnect");
  self endon(_id_CDE48A8A76BC5CD0);
  self notify("cameraClusterMonitored");
  self endon("cameraClusterMonitored");

  if(!isDefined(self._id_7D73CBB5CA5D6E32))
    self._id_7D73CBB5CA5D6E32 = [];

  self._id_7D73CBB5CA5D6E32[_id_DED994656B8D402A] = [];
  childthread _id_E65F72CDEC46D03E(_id_DED994656B8D402A, _id_083FA915761BEF20);

  for(;;) {
    waitframe();
    _id_B65E76E261A6ED4D = self[[_id_C380EB54A8ADB38C]]();

    if(!isDefined(_id_B65E76E261A6ED4D)) {
      continue;
    }
    foreach(camera in _id_B65E76E261A6ED4D) {
      _id_C7AAF56EC881E7B1 = scripts\engine\utility::array_contains(self._id_7D73CBB5CA5D6E32[_id_DED994656B8D402A], camera);

      if(!isDefined(camera) || istrue(camera.isdestroyed)) {
        if(_id_C7AAF56EC881E7B1)
          _id_6AFEDDDB11741FC9(camera, _id_DED994656B8D402A);

        continue;
      }

      if(distancesquared(self.origin, camera.origin) <= _id_CDC5DD6C28C9709D) {
        if(!_id_C7AAF56EC881E7B1) {
          if(camera.owner == self)
            _id_32C845C60C4E4B37(camera, 0);

          _id_3FB26DA0D61F648B(camera, _id_DED994656B8D402A);
        }

        continue;
      }

      if(_id_C7AAF56EC881E7B1) {
        if(camera.owner == self)
          _id_32C845C60C4E4B37(camera, 1);

        _id_6AFEDDDB11741FC9(camera, _id_DED994656B8D402A);
      }
    }
  }
}

_id_32C845C60C4E4B37(camera, _id_BDEF0C930308D4B7) {
  camera._id_50AA75D01D4622BB = _id_BDEF0C930308D4B7;
  thread _id_45556AA41F4F9AE8(camera, camera._id_DEFBEED1A2C29C34, scripts\engine\utility::ter_op(_id_BDEF0C930308D4B7, 5, 1));
}

_id_0309C31383EFD7D3(camera) {
  return istrue(camera._id_50AA75D01D4622BB);
}

_id_E65F72CDEC46D03E(_id_DED994656B8D402A, _id_083FA915761BEF20) {
  for(;;) {
    level waittill(_id_083FA915761BEF20, camera);

    if(scripts\engine\utility::array_contains(self._id_7D73CBB5CA5D6E32[_id_DED994656B8D402A], camera))
      _id_6AFEDDDB11741FC9(camera, _id_DED994656B8D402A);
  }
}

_id_3FB26DA0D61F648B(camera, _id_DED994656B8D402A) {
  self._id_7D73CBB5CA5D6E32[_id_DED994656B8D402A] = scripts\engine\utility::array_add(self._id_7D73CBB5CA5D6E32[_id_DED994656B8D402A], camera);
}

_id_6AFEDDDB11741FC9(camera, _id_DED994656B8D402A) {
  self._id_7D73CBB5CA5D6E32[_id_DED994656B8D402A] = scripts\engine\utility::array_remove(self._id_7D73CBB5CA5D6E32[_id_DED994656B8D402A], camera);
}

_id_23643A7487214603(target, camera) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  camera endon("death");
  camera endon("emp_applied");
  _id_C8462289EDFC0ACA = _id_89B59BEDB3802E41();

  if(!isDefined(_id_C8462289EDFC0ACA)) {
    return;
  }
  self.targetsinouterradius[self.targetsinouterradius.size] = target;
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(target, _id_C8462289EDFC0ACA, 0);
  _id_EC57E0ACBC6C6879(_id_C8462289EDFC0ACA, target, 0);
  self playlocalsound("equip_tactical_cam_passive_marked");

  while(isDefined(target)) {
    if(isPlayer(target) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](target)) {
        break;
      }
    }

    if(isagent(target) && !isalive(target)) {
      break;
    }

    _id_368AE33CB19F91F8 = camera _id_9D2BEC87E0754872(target);

    if(!_id_F91C0FEB9232B257(target)) {
      if(!istrue(_id_368AE33CB19F91F8.isindetectrange) || !istrue(_id_368AE33CB19F91F8._id_C37B1CC67943336D) || !istrue(_id_368AE33CB19F91F8._id_9AE205C4C40AF967)) {
        break;
      }
    }

    waitframe();
  }

  if(isDefined(target)) {
    _id_C8462289EDFC0ACA = _id_89B59BEDB3802E41();

    if(isDefined(_id_C8462289EDFC0ACA)) {
      if(scripts\cp_mp\targetmarkergroups::targetmarkergroupexists(_id_C8462289EDFC0ACA) && !_id_F91C0FEB9232B257(target))
        scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(target, _id_C8462289EDFC0ACA);
    }

    if(scripts\engine\utility::array_contains(self.targetsinouterradius, target))
      self.targetsinouterradius = scripts\engine\utility::array_remove(self.targetsinouterradius, target);
  } else
    self.targetsinouterradius = scripts\engine\utility::array_removeundefined(self.targetsinouterradius);
}

_id_2D3E2D45F75D7B9F(camera, ent) {
  if(!isDefined(ent))
    return 0;

  if(isPlayer(ent)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
      if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](ent))
        return 0;
    }
  }

  if(isagent(ent) && !isalive(ent))
    return 0;

  if(level.teambased) {
    if(isDefined(ent.team) && ent.team == self.team)
      return 0;
  } else {
    if(isPlayer(ent) && ent == self)
      return 0;

    if(isDefined(ent.owner) && ent.owner == self)
      return 0;
  }

  if(!camera _id_A268C4595BD106FF(ent))
    return 0;

  if(_id_F91C0FEB9232B257(ent))
    return 0;

  if(camera scripts\cp_mp\emp_debuff::is_empd())
    return 0;

  if(camera _id_F254912B43C0F30A(ent))
    return 0;

  if(!camera _id_F6BA29EFE27B0F81(ent))
    return 0;

  if(!camera _id_4E3AA9D829B3E164(ent))
    return 0;

  return 1;
}

_id_FC89B224136FE202(camera) {
  level endon("game_ended");
  self endon("disconnect");
  camera endon("death");
  self endon("playerLeavingCurrentCamera");
  self.targetsinouterradius = [];

  for(;;) {
    _id_C57955CDA07E6609();

    foreach(targetarray in level._id_E725F44030790232 scripts\engine\utility::_id_0DF633F460888A47(camera.origin)) {
      foreach(ent in targetarray) {
        _id_32608E38AA3071C4 = _id_2D3E2D45F75D7B9F(camera, ent);

        if(_id_32608E38AA3071C4)
          thread _id_23643A7487214603(ent, camera);
      }
    }

    wait 0.25;
  }
}

_id_C99B3A2B715C288B(duration, _id_5237A188CCDA4D7B) {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("death");
  self endon("entering");

  for(;;) {
    _id_C57955CDA07E6609();

    foreach(targetarray in level._id_E725F44030790232 scripts\engine\utility::_id_0DF633F460888A47(self.origin)) {
      foreach(ent in targetarray) {
        if(!isDefined(ent)) {
          continue;
        }
        if(isPlayer(ent) || isbot(ent)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isReallyAlive")) {
            if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isReallyAlive")]](ent))
              continue;
          }
        }

        if(isagent(ent) && !isalive(ent)) {
          continue;
        }
        if(level.teambased) {
          if(isDefined(ent.team) && ent.team == self.ownerteam)
            continue;
        } else if(ent == self.owner) {
          continue;
        }
        if(scripts\cp_mp\emp_debuff::is_empd()) {
          continue;
        }
        _id_368AE33CB19F91F8 = _id_9D2BEC87E0754872(ent);

        if(!_id_368AE33CB19F91F8._id_CC86ADA7DF8F6C2F || !_id_368AE33CB19F91F8._id_C37B1CC67943336D || !_id_368AE33CB19F91F8.isindetectrange || !_id_368AE33CB19F91F8._id_9AE205C4C40AF967) {
          continue;
        }
        if(self.owner _id_F91C0FEB9232B257(ent)) {
          continue;
        }
        if(istrue(self.markingtarget)) {
          continue;
        }
        params = _id_F0698AEE89C18210(self._id_08862825A0618BDA);
        _id_5A659105BA755498(ent, params._id_57B8F3BCFCA33A4B, params._id_5237A188CCDA4D7B);
      }
    }

    wait 0.25;
  }
}

_id_EA702996EA718070() {
  self endon("death");
  level endon("game_ended");
  self setmode("manual");
  _id_303D9FA226476812 = anglestoup((0, 0, 1));
  _id_C83A8D3D629F1DAC = anglestoup(self.angles);
  _id_0FCCBF8939AD0065 = vectordot(_id_303D9FA226476812, _id_C83A8D3D629F1DAC);
  _id_9745168C66BABA25 = _id_0FCCBF8939AD0065 < -0.001;
  _id_9FFCC6E392E7660E = _id_0FCCBF8939AD0065 >= -0.001 && _id_0FCCBF8939AD0065 <= 0.001;
  _id_243889C6E373EF11 = _id_0FCCBF8939AD0065 > 0.001;

  if(_id_9FFCC6E392E7660E) {
    _id_5CBACC152FE4FD06 = anglestoup(self.angles);
    _id_BEBBFD784C183FDC = vectortoangles(_id_5CBACC152FE4FD06);
  } else {
    _id_5CBACC152FE4FD06 = anglesToForward(self.angles);
    _id_BEBBFD784C183FDC = vectortoangles(_id_5CBACC152FE4FD06);
  }

  direction = 1;
  _id_466E4D7D54778D71 = anglestoright(_id_BEBBFD784C183FDC);
  _id_3117E27E0168D75E = anglesToForward(_id_BEBBFD784C183FDC);
  _id_F0706F7D15D2324D = self.origin + _id_466E4D7D54778D71 * 100 * direction;
  _id_0225777DDDBE18EE = scripts\engine\utility::spawn_script_origin(_id_F0706F7D15D2324D);
  level thread scripts\engine\utility::draw_angles(_id_BEBBFD784C183FDC, self.origin, (1, 0, 0), 1000, 50.0);

  for(;;) {
    self settargetentity(_id_0225777DDDBE18EE);
    level thread scripts\engine\utility::draw_angles(_id_BEBBFD784C183FDC, _id_F0706F7D15D2324D, (1, 0, 0), 1000, 50.0);
    _id_077B9E4B599269EB = scripts\engine\math::anglebetweenvectors(anglesToForward(self gettagangles("tag_player")), _id_466E4D7D54778D71);

    while(_id_077B9E4B599269EB > 10 && _id_077B9E4B599269EB < 170) {
      _id_077B9E4B599269EB = scripts\engine\math::anglebetweenvectors(anglesToForward(self gettagangles("tag_player")), _id_466E4D7D54778D71);
      waitframe();
    }

    direction = direction * -1;
    _id_F0706F7D15D2324D = self.origin + _id_466E4D7D54778D71 * 100 * direction;
    _id_0225777DDDBE18EE.origin = _id_F0706F7D15D2324D;
    self cleartargetentity(_id_0225777DDDBE18EE);
    waitframe();
  }
}

_id_A295DFCB64A39664(target, _id_39E02A8A79B6BA4C, _id_CAD4997EBDA279C7, useoutline) {
  pilot = self.pilot;
  pilot endon("disconnect");
  self.owner endon("disconnect");
  level endon("game_ended");
  self endon("explode");
  pilot endon("playerLeavingCurrentCamera");
  params = _id_F0698AEE89C18210(self._id_08862825A0618BDA);
  _id_161E86C260D6864C = spawnStruct();
  _id_161E86C260D6864C.target = target;
  _id_161E86C260D6864C.targetnum = target getentitynumber();
  _id_161E86C260D6864C.markingent = self;
  _id_161E86C260D6864C.ownerteam = self.ownerteam;
  _id_161E86C260D6864C.outlineid = undefined;
  _id_161E86C260D6864C.headicon = undefined;
  _id_161E86C260D6864C.beingmarked = undefined;
  _id_161E86C260D6864C.reconmarked = undefined;
  _id_161E86C260D6864C.notifytoendmark = "unmarked_" + _id_161E86C260D6864C.targetnum;

  if(!isDefined(_id_161E86C260D6864C.targetnum)) {
    return;
  }
  if(!isDefined(pilot)) {
    return;
  }
  _id_C8462289EDFC0ACA = pilot _id_89B59BEDB3802E41();

  if(!isDefined(_id_C8462289EDFC0ACA)) {
    return;
  }
  self.markingtarget = 1;
  pilot notify("marking_target");
  _id_2095B8A1AFAAF65E = self[[params._id_06E5F6320607EB69]](target);
  pilot playlocalsound(params._id_91389DD68A70BE33);
  self setscriptablepartstate("marking_target", "on", 0);

  while(_id_2095B8A1AFAAF65E > 0) {
    _id_161E86C260D6864C.beingmarked = 1;

    if(!isDefined(target)) {
      return;
    }
    if(!pilot _id_1B1409AF5E47B098(target, 80, 40)) {
      _id_161E86C260D6864C.beingmarked = undefined;
      self.markingtarget = undefined;
      pilot stoplocalsound("equip_tactical_cam_marking");
      self setscriptablepartstate("marking_target", "off", 0);
      pilot _id_FF216D4D2C47565C(5);
      return;
    }

    _id_2095B8A1AFAAF65E = _id_2095B8A1AFAAF65E - 0.05;
    wait 0.05;
  }

  self thread[[params._id_273F2A99F4833F00]](_id_161E86C260D6864C, pilot, target, _id_39E02A8A79B6BA4C, _id_CAD4997EBDA279C7, useoutline);
}

_id_7853D0AADD9C1525(target) {
  return istrue(target.beingmarked);
}

_id_6643DD06CF63B76A(_id_161E86C260D6864C, _id_B995F95867DE9AAB, timeout, useoutline) {
  level endon("game_ended");
  self.owner endon("disconnect");
  self endon("explode");
  target = _id_161E86C260D6864C.target;
  target endon(_id_161E86C260D6864C.notifytoendmark);
  _id_F597EC02DB6AA057(_id_161E86C260D6864C, timeout);
  _id_47C44D1BF801B8F0(_id_161E86C260D6864C, _id_B995F95867DE9AAB, useoutline);
}

_id_B5BE8B2F7743C406(_id_74B5B12BB6514385, _id_BC0DF70F0A03D70B) {
  pilot = self.pilot;

  if(!isDefined(pilot)) {
    return;
  }
  level endon("game_ended");
  self endon("death");
  pilot endon("playerLeavingCurrentCamera");
  pilot endon("disconnect");
  pilot endon("marking_target");
  wait(_id_74B5B12BB6514385);

  if(pilot.isusingcamera && pilot.currentcamera == self)
    pilot _id_FF216D4D2C47565C(_id_BC0DF70F0A03D70B);
}

_id_6F8FB8F7F63E5164(_id_161E86C260D6864C, _id_18CD5943FE5C2A7D, _id_CAD4997EBDA279C7, useoutline) {
  target = _id_161E86C260D6864C.target;
  params = _id_F0698AEE89C18210(self._id_08862825A0618BDA);
  markedents = _id_D103DC61E5B6ABC3(_id_18CD5943FE5C2A7D);

  if(isDefined(markedents) && scripts\engine\utility::array_contains_key(markedents, _id_161E86C260D6864C.targetnum))
    return 0;

  _id_9921A8095E089065(_id_161E86C260D6864C, _id_18CD5943FE5C2A7D);
  _id_39E02A8A79B6BA4C = "player";

  if(isagent(target))
    _id_39E02A8A79B6BA4C = "agent";

  self[[params._id_547E8B267C03D017]](_id_161E86C260D6864C.target, _id_39E02A8A79B6BA4C);
  _id_F98E48F2527D4205 = "hud_icon_new_marked";

  if(scripts\cp_mp\entityheadicons::_id_6EDE573723F08C0F())
    _id_F98E48F2527D4205 = "hud_icon_head_marked";

  _id_F9CD7FDA74E92E2A = 8;

  if(isPlayer(target)) {
    if(istrue(useoutline)) {
      if(level.teambased) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForTeam"))
          _id_161E86C260D6864C.outlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForTeam")]](target, "orange", self.owner.team, 0, 1, 0, "killstreak");
      } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "outlineEnableForPlayer"))
        _id_161E86C260D6864C.outlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "outlineEnableForPlayer")]](target, "orange", self.owner, 0, 1, 0, "killstreak");

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("outline", "hudOutlineViewmodelEnable"))
        target[[scripts\cp_mp\utility\script_utility::getsharedfunc("outline", "hudOutlineViewmodelEnable")]](5, 0, 1);
    }

    target thread _id_7D61D7B52C318D47();
    target _id_748F3520A7E525A9();
    target playlocalsound("recon_drone_spotted_plr");
  } else {
    _id_C6E17B4BC2EED915 = _id_74598558CD270375(_id_F98E48F2527D4205, _id_F9CD7FDA74E92E2A, target);
    _id_F98E48F2527D4205 = _id_C6E17B4BC2EED915.weaponicon;
    _id_F9CD7FDA74E92E2A = _id_C6E17B4BC2EED915.weaponoffset;
  }

  if(istrue(_id_CAD4997EBDA279C7)) {
    _id_161E86C260D6864C.headicon = target scripts\cp_mp\entityheadicons::setheadicon_singleimage([], _id_F98E48F2527D4205, _id_F9CD7FDA74E92E2A, 1, 4000, 500, undefined, 1, 1);
    _id_0E593B8F6770C67E(_id_161E86C260D6864C);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("helper_drone", "watchMarkingEntStatus"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("helper_drone", "watchMarkingEntStatus")]](_id_161E86C260D6864C);

  thread _id_B5BE8B2F7743C406(self[[params._id_06E5F6320607EB69]](_id_161E86C260D6864C.target), 5);
  return 1;
}

_id_7ABFAE4E338CC940(player, func) {
  _id_7305A0E8014E47BE = _id_D103DC61E5B6ABC3(player);

  if(isDefined(_id_7305A0E8014E47BE)) {
    foreach(ent in _id_7305A0E8014E47BE) {
      if(istrue(ent.reconmarked))
        [[func]](_id_7305A0E8014E47BE[ent.targetnum], player);
    }
  }
}

_id_01E34B5A5489BE90(camera, _id_07873097F48BD513, _id_08862825A0618BDA) {
  _id_EA3E3B2121E6713A = _id_F0698AEE89C18210(_id_08862825A0618BDA)._id_36411D05D3F1E503;
  level endon("game_ended");

  if(!_id_07873097F48BD513) {
    _id_7ABFAE4E338CC940(self, ::_id_F1493744AA061205);
    _id_BFCDB898D70F248C();
  }

  camera.pilot = undefined;
  camera setscriptablepartstate("piloted", "off", 0);
  level notify(_id_EA3E3B2121E6713A, camera);
  self remotecontrolturretoff(camera);
}

_id_B4E750DBD5734B12(camera, _id_07873097F48BD513) {
  if(isDefined(camera._id_81BD7C12AC1DCE18) && isDefined(camera)) {
    _id_C88649561F89170A = scripts\engine\utility::array_find(camera._id_81BD7C12AC1DCE18, self);

    if(isDefined(_id_C88649561F89170A)) {
      camera._id_81BD7C12AC1DCE18 = scripts\engine\utility::array_remove(camera._id_81BD7C12AC1DCE18, camera._id_81BD7C12AC1DCE18[_id_C88649561F89170A]);
      camera._id_1B381F3AA944D595 = scripts\engine\utility::array_remove(camera._id_1B381F3AA944D595, camera._id_1B381F3AA944D595[_id_C88649561F89170A]);

      if(!_id_07873097F48BD513) {
        _id_7ABFAE4E338CC940(self, ::_id_F1493744AA061205);
        _id_BFCDB898D70F248C();
      }

      self cameraunlink();
      self lerpfovbypreset("default");
    }
  }
}

_id_81704D1224BD6FE0(_id_48449F38D385A654) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(_id_48449F38D385A654) {
    _id_3B64EB40368C1450::set("tactical_camera_actions", "weapon_switch", 0);
    _id_3B64EB40368C1450::set("tactical_camera_actions", "offhand_weapons", 0);
    _id_3B64EB40368C1450::set("tactical_camera_actions", "fire", 0);
    _id_3B64EB40368C1450::set("tactical_camera_actions", "killstreaks", 0);
    _id_3B64EB40368C1450::set("tactical_camera_actions", "allow_movement", 0);
    _id_3B64EB40368C1450::set("tactical_camera_actions", "armor", 0);

    if(scripts\mp\equipment\nvg::_id_258C5E445C8B7F80())
      _id_3B64EB40368C1450::set("tactical_camera_actions", "nvg", 0);

    _id_7A22AB98BE3D0849(1);
  } else {
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("tactical_camera_actions");
    _id_7A22AB98BE3D0849(0);
  }
}

_id_7A22AB98BE3D0849(_id_48449F38D385A654) {
  stance = self getstance();

  if(_id_48449F38D385A654) {
    if(stance == "stand") {
      _id_3B64EB40368C1450::set("tactical_camera_stance", "crouch", 0);
      _id_3B64EB40368C1450::set("tactical_camera_stance", "prone", 0);
    } else if(stance == "crouch") {
      _id_3B64EB40368C1450::set("tactical_camera_stance", "stand", 0);
      _id_3B64EB40368C1450::set("tactical_camera_stance", "prone", 0);
    } else if(stance == "prone") {
      _id_3B64EB40368C1450::set("tactical_camera_stance", "crouch", 0);
      _id_3B64EB40368C1450::set("tactical_camera_stance", "stand", 0);
    }
  } else
    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("tactical_camera_stance");
}

_id_54E1472F61B86413(camera, _id_4C663252DABD1483, _id_35F8C6D718D434CE, _id_96972634A7A8B430) {
  if(istrue(_id_96972634A7A8B430) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("SUPER_MP/TACTICAL_CAMERA_INVALID_DEPLOYMENT");

  if(istrue(camera._id_11F51147CCFF0163))
    thread scripts\mp\supers::refundsuper();

  camera[[_id_4C663252DABD1483]](1, undefined, _id_35F8C6D718D434CE);
}

_id_9CD4393CAC778989(camera, _id_4C663252DABD1483, _id_35F8C6D718D434CE) {
  camera endon("death");
  _id_ED87DDDADCB02CEC = getdvarint("dvar_C57F2DAEBACD2A11", 0) > 0;
  _id_C7C4CB56353A2626 = getdvarint("dvar_77164862B5DD9238", 1) > 0;
  _id_5386D3F222C813AE = 0;

  if(getdvarint("dvar_05D72D66FEF5F7D5", 0) == 1)
    _id_5386D3F222C813AE = 1;

  if(_id_5386D3F222C813AE && istrue(_id_35F8C6D718D434CE)) {
    offset = getdvarfloat("dvar_A63EAACD700C5FE0", 0.75);
    camera.origin = camera.origin + anglestoup(camera.angles) * offset;
    wait 0.05;
  }

  _id_35F8C6D718D434CE = istrue(_id_35F8C6D718D434CE);

  if(!isDefined(_id_4C663252DABD1483))
    _id_4C663252DABD1483 = _id_F0698AEE89C18210(camera._id_08862825A0618BDA)._id_4C663252DABD1483;

  if(_id_35F8C6D718D434CE)
    wait 0.05;

  _id_F09B1F15E73C9E38 = spawnStruct();
  _id_5392A68C99C4A46D = getdvarfloat("dvar_EA48E956738A089C", 8.0);
  _id_F09B1F15E73C9E38.origin = camera.origin + anglestoup(camera.angles) * _id_5392A68C99C4A46D;
  _id_2FC7B90001702E5C = [camera, self];
  contents = _id_F0698AEE89C18210(camera._id_08862825A0618BDA)._id_58906CC2DED735DB;
  _id_F09B1F15E73C9E38.angles = camera gettagangles("tag_origin");

  if(camera.mode == "wall") {
    fwd = anglestoup(camera.angles);
    right = anglestoright(camera.angles);
    up = vectorcross(fwd, right);
    _id_F09B1F15E73C9E38.angles = axistoangles(fwd, right, up);
  }

  _id_558F2EC8E231DF5D = getdvarfloat("dvar_71131DEB09E9DCBF", 2.125);
  tracestart = _id_F09B1F15E73C9E38.origin + anglestoleft(_id_F09B1F15E73C9E38.angles) * 0.2;
  tracestart = tracestart + anglesToForward(_id_F09B1F15E73C9E38.angles) * getdvarfloat("dvar_9837B8C055D50463", 1.0);
  _id_F9788B8FC8DCB768 = tracestart + anglesToForward(_id_F09B1F15E73C9E38.angles) * 16.1;
  _id_F3739A2563448690 = tracestart + anglesToForward(_id_F09B1F15E73C9E38.angles) * 16.1 * -1;
  _id_2C009776DC6F509B = scripts\engine\trace::sphere_trace(tracestart, _id_F9788B8FC8DCB768, 2.125, _id_2FC7B90001702E5C, contents, 0, 1);
  _id_6EBFAFCF06305E63 = scripts\engine\trace::sphere_trace(tracestart, _id_F3739A2563448690, 2.125, _id_2FC7B90001702E5C, contents, 0, 1);

  if(isDefined(_id_2C009776DC6F509B["position"])) {}

  if(isDefined(_id_6EBFAFCF06305E63["position"])) {}

  _id_21F7B8E410C6D2E0 = _id_2C009776DC6F509B["hittype"] == "hittype_none";
  _id_1515FEF1B3851218 = _id_6EBFAFCF06305E63["hittype"] == "hittype_none";
  _id_98C4FB9955FF6E51 = distancesquared(_id_2C009776DC6F509B["position"], _id_6EBFAFCF06305E63["position"]);
  _id_E339BFB2E37C6DCD = _id_98C4FB9955FF6E51 <= 174.504;
  _id_668318F72D08B88B = camera.origin + anglestoup(camera.angles) * -1.5;
  _id_75728142E6146447 = camera gettagorigin("tag_player");
  _id_F9F735A1790F607F = distancesquared(_id_6EBFAFCF06305E63["position"], _id_668318F72D08B88B);
  _id_FE15317BEDB99E47 = distancesquared(_id_2C009776DC6F509B["position"], _id_75728142E6146447);
  _id_0607A2501BCE0189 = _id_6EBFAFCF06305E63["position"] - _id_668318F72D08B88B;
  _id_8971B89742AA65E7 = _id_2C009776DC6F509B["position"] - _id_75728142E6146447;
  _id_22515E1E2A9B9ECC = [180, 180];
  _id_443E943CC3579457 = [85, 85];
  _id_3E004EAE34CA6E6B = scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587();

  if(!_id_21F7B8E410C6D2E0 && !_id_1515FEF1B3851218) {
    if(_id_E339BFB2E37C6DCD) {
      _id_54E1472F61B86413(camera, _id_4C663252DABD1483, _id_35F8C6D718D434CE, _id_3E004EAE34CA6E6B);
      return 0;
    } else {
      _id_AC0A60A93BEAEF5B = vectordot(anglesToForward(camera gettagangles("tag_player")), _id_8971B89742AA65E7) < 1;

      if(_id_AC0A60A93BEAEF5B) {
        _id_54E1472F61B86413(camera, _id_4C663252DABD1483, _id_35F8C6D718D434CE, _id_3E004EAE34CA6E6B);
        return 0;
      }

      _id_21F7B8E410C6D2E0 = 1;
    }
  }

  if(_id_21F7B8E410C6D2E0 || _id_1515FEF1B3851218) {
    if(!_id_21F7B8E410C6D2E0 && camera.mode != "wall" && istrue(_id_35F8C6D718D434CE)) {
      _id_38E7FB5A6C0292F2 = _id_2C009776DC6F509B["normal"];
      _id_BEFE3B57021A5FF8 = anglestoup(camera.angles);
      _id_389660BB1A8E35CD = vectorcross(_id_38E7FB5A6C0292F2, _id_BEFE3B57021A5FF8);
      _id_F09B1F15E73C9E38.angles = axistoangles(_id_38E7FB5A6C0292F2, _id_389660BB1A8E35CD, _id_BEFE3B57021A5FF8);
      camera.angles = _id_F09B1F15E73C9E38.angles;
      wait 0.05;
    }

    if(!_id_21F7B8E410C6D2E0 || !_id_1515FEF1B3851218) {
      if(!_id_21F7B8E410C6D2E0) {
        _id_FCC5982A28F6EE8E = scripts\engine\trace::ray_trace_detail_passed(tracestart, _id_2C009776DC6F509B["position"] + _id_2C009776DC6F509B["normal"] * -2, _id_2FC7B90001702E5C, contents);

        if(_id_FCC5982A28F6EE8E) {
          _id_54E1472F61B86413(camera, _id_4C663252DABD1483, _id_35F8C6D718D434CE, _id_3E004EAE34CA6E6B);
          return 0;
        }
      }

      if(!_id_1515FEF1B3851218) {
        _id_FCC5982A28F6EE8E = scripts\engine\trace::ray_trace_detail_passed(tracestart, _id_6EBFAFCF06305E63["position"] + _id_6EBFAFCF06305E63["normal"] * -2, _id_2FC7B90001702E5C, contents);

        if(_id_FCC5982A28F6EE8E) {
          _id_54E1472F61B86413(camera, _id_4C663252DABD1483, _id_35F8C6D718D434CE, _id_3E004EAE34CA6E6B);
          return 0;
        }
      }

      if(_id_F9F735A1790F607F < 174.504 || _id_FE15317BEDB99E47 < 174.504) {
        _id_22515E1E2A9B9ECC[0] = _id_22515E1E2A9B9ECC[0] - 70;
        _id_22515E1E2A9B9ECC[1] = _id_22515E1E2A9B9ECC[1] - 70;
      }
    }
  }

  if(camera.mode == "wall") {
    _id_22515E1E2A9B9ECC[0] = 110;
    _id_22515E1E2A9B9ECC[1] = 110;
  } else if(camera.mode == "ground")
    _id_443E943CC3579457[1] = _id_443E943CC3579457[1] - getdvarfloat("dvar_FB3D586E02F08FC9", 30);
  else
    _id_443E943CC3579457[0] = _id_443E943CC3579457[0] - getdvarfloat("dvar_FB3D586E02F08FC9", 30);

  if(_id_35F8C6D718D434CE) {
    _id_38E7FB5A6C0292F2 = scripts\engine\utility::flatten_vector(anglesToForward(camera gettagangles("tag_player")));
    _id_303D9FA226476812 = (0, 0, 1);
    _id_389660BB1A8E35CD = vectorcross(_id_38E7FB5A6C0292F2, _id_303D9FA226476812);
    _id_F09B1F15E73C9E38.angles = axistoangles(_id_38E7FB5A6C0292F2, _id_389660BB1A8E35CD, _id_303D9FA226476812);
    _id_A4B48904A62E6AEE = getdvarfloat("dvar_630DA9DBEA450037", 5.5);
    _id_901AE9E096C5AD06 = getdvarfloat("dvar_1ED9270646935E4F", 0.25);
    _id_53F975D1BAC9F666 = getdvarfloat("dvar_158DBC8DFE38250F", 0.05);
    _id_F09B1F15E73C9E38.origin = camera.origin + anglestoup(camera.angles) * _id_A4B48904A62E6AEE + anglestoleft(_id_F09B1F15E73C9E38.angles) * _id_901AE9E096C5AD06 + anglesToForward(_id_F09B1F15E73C9E38.angles) * _id_53F975D1BAC9F666;
    camera._id_972DB1E8C83AF680 = _id_F09B1F15E73C9E38.angles;
    camera._id_61B4BF1265754402 = _id_F09B1F15E73C9E38.origin;
  } else {
    _id_F09B1F15E73C9E38.angles = camera._id_972DB1E8C83AF680;
    _id_F09B1F15E73C9E38.origin = camera._id_61B4BF1265754402;
  }

  if(camera.mode != "ground" && _id_35F8C6D718D434CE) {
    _id_64EC3898ED3D1CB3 = camera gettagorigin("tag_player");
    _id_187B3C4C217506BF = camera gettagorigin("tag_origin");
    _id_9B2D69C8A06FCC0B = [_id_64EC3898ED3D1CB3, _id_187B3C4C217506BF];
    _id_C6EA0EC449C6E3F7 = _id_64EC3898ED3D1CB3 + anglestoleft(_id_F09B1F15E73C9E38.angles) * 13.21;
    _id_13A898E5C4B84AC4 = _id_64EC3898ED3D1CB3 + anglestoright(_id_F09B1F15E73C9E38.angles) * 13.21;
    _id_1E4CC740E1CD5CD3 = _id_187B3C4C217506BF + anglestoleft(_id_F09B1F15E73C9E38.angles) * 13.21;
    _id_4A90CE9B71E8F578 = _id_187B3C4C217506BF + anglestoright(_id_F09B1F15E73C9E38.angles) * 13.21;
    _id_2FE0CCF3C745186A = scripts\engine\trace::ray_trace(_id_64EC3898ED3D1CB3, _id_C6EA0EC449C6E3F7, _id_2FC7B90001702E5C, contents, 0, 0, 1);
    _id_E9B3DCDC29694157 = scripts\engine\trace::ray_trace(_id_64EC3898ED3D1CB3, _id_13A898E5C4B84AC4, _id_2FC7B90001702E5C, contents, 0, 0, 1);
    _id_7B8DBE0A384C48B6 = scripts\engine\trace::ray_trace(_id_187B3C4C217506BF, _id_1E4CC740E1CD5CD3, _id_2FC7B90001702E5C, contents, 0, 0, 1);
    _id_1163F374B636FB8B = scripts\engine\trace::ray_trace(_id_187B3C4C217506BF, _id_4A90CE9B71E8F578, _id_2FC7B90001702E5C, contents, 0, 0, 1);
    _id_7D1AF73532EA6CA9 = _id_2FE0CCF3C745186A["hittype"] != "hittype_none" && _id_7B8DBE0A384C48B6["hittype"] != "hittype_none";
    _id_31344CE38DEC89FC = _id_E9B3DCDC29694157["hittype"] != "hittype_none" && _id_1163F374B636FB8B["hittype"] != "hittype_none";

    if(_id_31344CE38DEC89FC && _id_7D1AF73532EA6CA9) {
      _id_54E1472F61B86413(camera, _id_4C663252DABD1483, _id_35F8C6D718D434CE);
      return 0;
    } else {
      _id_F576B98E7C123DF5 = getdvarfloat("dvar_CB3FEA1CA4B915E8", 6.0);

      if(_id_31344CE38DEC89FC) {
        camera.origin = camera.origin + anglestoleft(_id_F09B1F15E73C9E38.angles) * _id_F576B98E7C123DF5;
        _id_F09B1F15E73C9E38.origin = _id_F09B1F15E73C9E38.origin + anglestoleft(_id_F09B1F15E73C9E38.angles) * _id_F576B98E7C123DF5;
        wait 0.05;
      } else if(_id_7D1AF73532EA6CA9) {
        camera.origin = camera.origin + anglestoright(_id_F09B1F15E73C9E38.angles) * _id_F576B98E7C123DF5;
        _id_F09B1F15E73C9E38.origin = _id_F09B1F15E73C9E38.origin + anglestoright(_id_F09B1F15E73C9E38.angles) * _id_F576B98E7C123DF5;
        wait 0.05;
      }

      camera._id_61B4BF1265754402 = _id_F09B1F15E73C9E38.origin;
    }
  }

  if(_id_35F8C6D718D434CE && camera.mode == "wall") {
    _id_92FC2D8BF944ACD6 = camera gettagorigin("tag_player");
    _id_1F0BC580944BA8ED = _id_F09B1F15E73C9E38.angles;
    _id_5985D426AA39D205 = getdvarfloat("dvar_BB708C290AE38743", 20);
    tracestart = _id_92FC2D8BF944ACD6 + anglesToForward(_id_1F0BC580944BA8ED) * -1;
    _id_4B787D72C87EDFD7 = _id_92FC2D8BF944ACD6 + anglesToForward(_id_1F0BC580944BA8ED) * _id_5985D426AA39D205 + anglestoright(_id_1F0BC580944BA8ED) * _id_5985D426AA39D205;
    _id_61795BC1D5BE4F22 = _id_92FC2D8BF944ACD6 + anglesToForward(_id_1F0BC580944BA8ED) * _id_5985D426AA39D205 + anglestoleft(_id_1F0BC580944BA8ED) * _id_5985D426AA39D205;
    _id_B463C6A2527F428A = _id_92FC2D8BF944ACD6 + anglesToForward(_id_1F0BC580944BA8ED) * _id_5985D426AA39D205 + anglestoup(_id_1F0BC580944BA8ED) * _id_5985D426AA39D205;
    _id_A96922AA595ECA1F = _id_92FC2D8BF944ACD6 + anglesToForward(_id_1F0BC580944BA8ED) * _id_5985D426AA39D205 + anglestoup(_id_1F0BC580944BA8ED) * _id_5985D426AA39D205 * -1;
    _id_D253C9F2BB45B0D4 = [_id_4B787D72C87EDFD7, _id_61795BC1D5BE4F22, _id_B463C6A2527F428A, _id_A96922AA595ECA1F];
    _id_DAE0F3FC0FBFA6A5 = scripts\engine\trace::sphere_trace(tracestart, _id_B463C6A2527F428A, 1.0, _id_2FC7B90001702E5C, contents, 0, 1);
    _id_45505EA96C00D672 = scripts\engine\trace::sphere_trace(tracestart, _id_A96922AA595ECA1F, 1.0, _id_2FC7B90001702E5C, contents, 0, 1);
    _id_8D79ECCBAC18169D = scripts\engine\trace::sphere_trace(tracestart, _id_61795BC1D5BE4F22, 1.0, _id_2FC7B90001702E5C, contents, 0, 1);
    _id_B8290060D3AAF6CA = scripts\engine\trace::sphere_trace(tracestart, _id_4B787D72C87EDFD7, 1.0, _id_2FC7B90001702E5C, contents, 0, 1);
    _id_349DEA642CFCC3A9 = _id_DAE0F3FC0FBFA6A5["hittype"] != "hittype_none";
    _id_71DFF7AD0A7AFED6 = _id_45505EA96C00D672["hittype"] != "hittype_none";
    _id_8E56F6F1F53A2E01 = _id_8D79ECCBAC18169D["hittype"] != "hittype_none";
    _id_BBF9A1560509DC4E = _id_B8290060D3AAF6CA["hittype"] != "hittype_none";

    if(_id_349DEA642CFCC3A9 && _id_71DFF7AD0A7AFED6 || _id_8E56F6F1F53A2E01 && _id_BBF9A1560509DC4E) {
      _id_54E1472F61B86413(camera, _id_4C663252DABD1483, _id_35F8C6D718D434CE);
      return 0;
    }
  }

  _id_B4FC3C0BEAF3B0D8 = getdvarfloat("dvar_3C8365AA23C0A4E9", 8.5);
  tracestart = _id_F09B1F15E73C9E38.origin;
  _id_F9FBCA64918F0D03 = physics_spherecast(tracestart, tracestart, _id_B4FC3C0BEAF3B0D8, contents, _id_2FC7B90001702E5C, "physicsquery_all", "physicsquery_all", 1);
  _id_AA1B18A5EB18ABF2 = 6.65;
  _id_8A1427F1B510F82C = 2.4;

  if(camera.mode == "wall") {
    _id_AA1B18A5EB18ABF2 = 6.65;
    _id_8A1427F1B510F82C = 1.5;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_F9FBCA64918F0D03.size - 1; _id_AC0E594AC96AA3A8++) {
    _id_D895C679F6A927E5 = _id_F9FBCA64918F0D03[_id_AC0E594AC96AA3A8];

    foreach(trace in _id_D895C679F6A927E5) {
      if(!isDefined(trace["position"])) {
        continue;
      }
      if(!isDefined(trace["normal"])) {
        continue;
      }
      if(trace["hittype"] == "hittype_none") {
        continue;
      }
      _id_340D59422336E85A = tracestart - trace["position"];
      dot = vectordot(anglesToForward(_id_F09B1F15E73C9E38.angles), _id_340D59422336E85A);

      if(dot > _id_8A1427F1B510F82C || dot < _id_AA1B18A5EB18ABF2 * -1) {
        dot = vectordot(anglestoright(_id_F09B1F15E73C9E38.angles), _id_340D59422336E85A);

        if(dot < 0)
          _id_22515E1E2A9B9ECC[1] = min(_id_22515E1E2A9B9ECC[1], 110);
        else if(dot > 0)
          _id_22515E1E2A9B9ECC[0] = min(_id_22515E1E2A9B9ECC[0], 110);

        continue;
      }

      _id_27CF81241A809664 = vectordot(anglestoright(_id_F09B1F15E73C9E38.angles), _id_340D59422336E85A);
      _id_F5F0BE1AAE34652D = vectordot(anglestoup(_id_F09B1F15E73C9E38.angles), _id_340D59422336E85A);

      if(_id_27CF81241A809664 <= 1.6 && _id_27CF81241A809664 >= -1.6) {
        _id_DC8625458EE5ED14 = 2.25;

        if(_id_F5F0BE1AAE34652D <= _id_DC8625458EE5ED14 && _id_F5F0BE1AAE34652D >= _id_DC8625458EE5ED14 * -1) {
          continue;
        }
        if(camera.mode != "wall") {
          if(_id_F5F0BE1AAE34652D < 0) {}
        }
      }

      if(_id_27CF81241A809664 >= 6.0 || _id_27CF81241A809664 <= -6.0) {
        continue;
      }
      if(_id_F5F0BE1AAE34652D >= 6.0 || _id_F5F0BE1AAE34652D < -6.0) {
        continue;
      }
      dot = vectordot(anglestoup(_id_F09B1F15E73C9E38.angles), _id_340D59422336E85A);

      if(dot > 2.25 || dot < -2.25) {
        _id_54965E7BA439553D = scripts\engine\utility::ter_op(dot > 0, 1, 0);
        _id_443E943CC3579457[_id_54965E7BA439553D] = 1;
        continue;
      }

      _id_EBE3D10DD7B17327 = anglesToForward(_id_F09B1F15E73C9E38.angles);
      _id_5CC8D461E23B45EA = trace["position"] - tracestart;
      _id_8E56F6F1F53A2E01 = 0;
      _id_56699F8802BAA8E7 = scripts\engine\math::anglebetweenvectorssigned(_id_EBE3D10DD7B17327, _id_5CC8D461E23B45EA, (0, 0, 1));

      if(_id_56699F8802BAA8E7 > 0)
        _id_8E56F6F1F53A2E01 = 1;

      _id_56699F8802BAA8E7 = abs(_id_56699F8802BAA8E7);
      _id_100094A8F26DA73D = scripts\engine\utility::ter_op(_id_8E56F6F1F53A2E01, 0, 1);
      _id_22515E1E2A9B9ECC[_id_100094A8F26DA73D] = 1;
    }
  }

  if(_id_35F8C6D718D434CE) {
    _id_A820130A6D38F1E4 = spawn("script_model", camera.origin);
    _id_A820130A6D38F1E4 setModel("tag_origin");
    _id_A820130A6D38F1E4.origin = camera gettagorigin("tag_player");
    _id_A820130A6D38F1E4.angles = camera gettagangles("tag_player");
    camera._id_A820130A6D38F1E4 = _id_A820130A6D38F1E4;
  }

  camera._id_DF8EAB23E5A5A0B7 = _id_22515E1E2A9B9ECC;
  camera._id_3EBF8C1AE3ACCE22 = _id_443E943CC3579457;
  return 1;
}

_id_736CF4E3EA65E3D0(currentcamera, _id_D32DB81FACF26305) {
  if(!isDefined(currentcamera)) {
    return;
  }
  _id_EA5E69CB5E96E49C = self[[_id_F0698AEE89C18210(currentcamera._id_08862825A0618BDA)._id_1EB35A5A7992E498]]();

  if(_id_EA5E69CB5E96E49C.size == 0)
    return currentcamera;

  _id_5EC35B0D0E09922D = currentcamera.owner.team;
  _id_D193C305EC44EBD4 = scripts\engine\utility::array_find(_id_EA5E69CB5E96E49C, currentcamera);

  if(!isDefined(_id_D193C305EC44EBD4))
    _id_D193C305EC44EBD4 = 0;

  _id_294AE6F4E7A2ECE9 = 1;

  if(istrue(_id_D32DB81FACF26305))
    _id_294AE6F4E7A2ECE9 = -1;

  _id_D2E8EC5A21155950 = _id_D193C305EC44EBD4 + _id_294AE6F4E7A2ECE9;

  if(_id_D2E8EC5A21155950 < 0)
    _id_D2E8EC5A21155950 = _id_EA5E69CB5E96E49C.size - 1;

  _id_D2E8EC5A21155950 = _id_D2E8EC5A21155950 % _id_EA5E69CB5E96E49C.size;
  _id_64177B5A8B8ADBA4 = _id_EA5E69CB5E96E49C[_id_D2E8EC5A21155950];

  while(_id_D2E8EC5A21155950 != _id_D193C305EC44EBD4) {
    if(isDefined(_id_64177B5A8B8ADBA4) && !_id_58A0CAD2ABA60238(_id_64177B5A8B8ADBA4)) {
      break;
    }

    _id_D2E8EC5A21155950 = _id_D193C305EC44EBD4 + _id_294AE6F4E7A2ECE9;

    if(_id_D2E8EC5A21155950 < 0)
      _id_D2E8EC5A21155950 = _id_EA5E69CB5E96E49C.size - 1;

    _id_D2E8EC5A21155950 = _id_D2E8EC5A21155950 % _id_EA5E69CB5E96E49C.size;
    _id_64177B5A8B8ADBA4 = _id_EA5E69CB5E96E49C[_id_D2E8EC5A21155950];
    waitframe();
  }

  return _id_64177B5A8B8ADBA4;
}

_id_AA1196B484E39ECA(currentcamera, _id_61C10206B89FCB56) {
  level endon("game_ended");
  self endon("disconnect");
  self._id_A7D181863F388645 = 1;
  _id_BE3314F77FEF5D6B = _id_F0698AEE89C18210(currentcamera._id_08862825A0618BDA)._id_BE3314F77FEF5D6B;
  scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0.25);
  _id_FE7523EC001DD34D = 1;

  if(!isDefined(_id_61C10206B89FCB56) || istrue(_id_61C10206B89FCB56.isdestroyed) || !isalive(self))
    _id_FE7523EC001DD34D = 0;

  scripts\cp_mp\utility\player_utility::_freezelookcontrols(0);

  if(!_id_FE7523EC001DD34D) {
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.25);
    self thread[[_id_BE3314F77FEF5D6B]](currentcamera, _id_FE7523EC001DD34D);
  } else {
    self[[_id_BE3314F77FEF5D6B]](currentcamera, _id_FE7523EC001DD34D);
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.25);

    if(isDefined(_id_61C10206B89FCB56))
      self[[_id_F0698AEE89C18210(_id_61C10206B89FCB56._id_08862825A0618BDA).startfunc]](_id_61C10206B89FCB56);
  }

  self._id_A7D181863F388645 = undefined;
  self notify("deployable_camera_switch_complete");
}

_id_EF76557BFC468AD7(_id_91BF4C3AA63185A2, camera) {
  self endon("disconnect");
  self notify("cameraSwitchMonitored");
  self endon("cameraSwitchMonitored");
  self endon("playerExitingCameraMode");
  self endon(_id_91BF4C3AA63185A2);
  self endon("death");

  for(;;) {
    msg = _id_537B1C669B864647();

    if(!isDefined(msg)) {
      continue;
    }
    _id_234A04A66D98D450 = 0;

    if(msg == "cameraSwitchLeft")
      _id_234A04A66D98D450 = 1;

    _id_367656975DB3F139(camera, _id_234A04A66D98D450, _id_91BF4C3AA63185A2);
  }
}

_id_367656975DB3F139(camera, _id_234A04A66D98D450, _id_91BF4C3AA63185A2) {
  self endon("playerExitingCameraMode");
  self endon("death");

  if(!isDefined(_id_91BF4C3AA63185A2))
    _id_91BF4C3AA63185A2 = "tacticalCamera_allCamerasRemoved";

  self endon(_id_91BF4C3AA63185A2);

  if(istrue(self._id_A7D181863F388645))
    return 0;

  _id_64177B5A8B8ADBA4 = _id_736CF4E3EA65E3D0(camera, _id_234A04A66D98D450);

  if(!isDefined(_id_64177B5A8B8ADBA4))
    return 0;

  if(_id_64177B5A8B8ADBA4 == camera)
    return 0;
  else {
    thread _id_AA1196B484E39ECA(camera, _id_64177B5A8B8ADBA4);
    self waittill("deployable_camera_switch_complete");
    return 1;
  }
}

_id_6ECB6C565C248E04(camera) {
  level endon("game_ended");
  camera endon("death");
  camera endon("explode");
  self endon("disconnect");

  if(!isDefined(camera) || camera.hasexploded == 1) {
    return;
  }
  _id_525A3C292FD60B90 = camera gettagangles("tag_player");
  _id_E80EE348F3979BF2 = anglesToForward(_id_525A3C292FD60B90);
  _id_13CF1760124232F8 = anglestoup(_id_525A3C292FD60B90);
  _id_4F6B26E67CBC1FD4 = scripts\engine\utility::flatten_vector(_id_E80EE348F3979BF2, (0, 0, 1));
  _id_EF86F2326135BD83 = camera._id_972DB1E8C83AF680;
  _id_254B947358335EE3 = scripts\engine\utility::flatten_vector(anglesToForward(_id_EF86F2326135BD83), (0, 0, 1));
  _id_75301576E282501B = anglestoup(_id_EF86F2326135BD83);
  camera._id_509338690AEB5FAC = [];
  camera._id_F7E06E4A1DE98489 = [];
  _id_E04F1CBEA4A658EA = 0;
  _id_D11C3A1B9568CDDB = 0;

  if(camera._id_DF8EAB23E5A5A0B7[0] != 180 || camera._id_DF8EAB23E5A5A0B7[1] != 180) {
    _id_D11C3A1B9568CDDB = scripts\engine\math::anglebetweenvectorssigned(_id_254B947358335EE3, _id_4F6B26E67CBC1FD4, (0, 0, 1));

    if(_id_D11C3A1B9568CDDB <= 0)
      _id_E04F1CBEA4A658EA = 1;

    _id_077B9E4B599269EB = abs(_id_D11C3A1B9568CDDB);

    if(_id_E04F1CBEA4A658EA) {
      camera._id_509338690AEB5FAC[1] = _id_077B9E4B599269EB * -1;
      camera._id_509338690AEB5FAC[0] = _id_077B9E4B599269EB;
    } else {
      camera._id_509338690AEB5FAC[1] = _id_077B9E4B599269EB;
      camera._id_509338690AEB5FAC[0] = _id_077B9E4B599269EB * -1;
    }
  }

  _id_2F30D3353D5DD64D = 0;
  _id_F73236F3C070CE6E = scripts\engine\math::anglebetweenvectorssigned(_id_75301576E282501B, _id_13CF1760124232F8, (0, 1, 0));

  if(_id_F73236F3C070CE6E <= 0)
    _id_2F30D3353D5DD64D = 1;

  _id_077B9E4B599269EB = abs(_id_F73236F3C070CE6E);

  if(_id_2F30D3353D5DD64D) {
    camera._id_F7E06E4A1DE98489[0] = _id_077B9E4B599269EB;
    camera._id_F7E06E4A1DE98489[1] = _id_077B9E4B599269EB * -1;
  } else {
    camera._id_F7E06E4A1DE98489[0] = _id_077B9E4B599269EB * -1;
    camera._id_F7E06E4A1DE98489[1] = _id_077B9E4B599269EB;
  }
}

_id_5A7867448F866939(data, _id_C0754CA9AA8976DA) {
  if(!isDefined(self) || istrue(self.isdestroyed)) {
    return;
  }
  self setscriptablepartstate("ddos", "disabled", 0);
  self.owner thread _id_45556AA41F4F9AE8(self, self._id_DEFBEED1A2C29C34, 4, undefined, 6.0);

  if(isDefined(self.pilot)) {
    _id_E7C55E8864B07CCA = [self.pilot];

    if(isDefined(self._id_81BD7C12AC1DCE18) && self._id_81BD7C12AC1DCE18.size > 0)
      _id_E7C55E8864B07CCA = scripts\engine\utility::array_combine(_id_E7C55E8864B07CCA, self._id_81BD7C12AC1DCE18);

    foreach(_id_EEE718E33217DC9E in _id_E7C55E8864B07CCA)
    _id_EEE718E33217DC9E thread _id_E0A9C9A0A70B1EE5(self, _id_C0754CA9AA8976DA);
  }
}

_id_45556AA41F4F9AE8(camera, index, status, _id_BF15527477B41565, _id_BE632E8C9259A360) {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self._id_2D5BAA13A621C5EB))
    self._id_2D5BAA13A621C5EB = [];

  struct = spawnStruct();
  struct.camera = camera;
  struct.index = index;
  struct.status = status;
  struct._id_BF15527477B41565 = istrue(_id_BF15527477B41565);
  struct._id_BE632E8C9259A360 = scripts\engine\utility::ter_op(isDefined(_id_BE632E8C9259A360), _id_BE632E8C9259A360, 0.0);
  self._id_2D5BAA13A621C5EB[self._id_2D5BAA13A621C5EB.size] = struct;
  thread _id_797AA6BAAE156A75();
}

_id_797AA6BAAE156A75() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("tacticalCamera_allCamerasRemoved");
  self notify("deployableCamera_statusQueue");
  self endon("deployableCamera_statusQueue");

  if(istrue(level.gameended) || !isDefined(self)) {
    return;
  }
  while(isDefined(self._id_2D5BAA13A621C5EB) && self._id_2D5BAA13A621C5EB.size > 0) {
    waitframe();
    struct = scripts\engine\utility::array_get_first_item(self._id_2D5BAA13A621C5EB);
    self notify("personal_camera_status_updated", struct.camera, struct.index, struct.status, struct._id_BF15527477B41565, struct._id_BE632E8C9259A360);
    self._id_2D5BAA13A621C5EB = scripts\engine\utility::array_remove(self._id_2D5BAA13A621C5EB, struct);
  }
}

_id_3F6B8F7CFF6A2C37(camera, _id_B18D3429CF88F29F) {
  camera endon("emp_cleared");
  self endon("playerLeavingCurrentCamera");
  _id_C99E130247EA0019 = _id_B18D3429CF88F29F / 2;
  _id_7ABF9767930DCA21(camera, "taccam_static_start", _id_C99E130247EA0019);
  wait(_id_C99E130247EA0019);
  _id_7ABF9767930DCA21(camera, "taccam_static_mid", _id_C99E130247EA0019);
  wait(_id_C99E130247EA0019);
}

_id_E0A9C9A0A70B1EE5(camera, _id_C0754CA9AA8976DA) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\cp_mp\emp_debuff::play_emp_scramble(1);
  _id_110A8239B8D015BC = _id_47E6ED10BE33FEF1(camera, _id_C0754CA9AA8976DA);

  if(!isDefined(_id_110A8239B8D015BC) || _id_110A8239B8D015BC != "timeout") {
    scripts\cp_mp\emp_debuff::_id_F7C6D776D032122F();
    _id_ECA023AD97260F51(camera);
  } else
    thread _id_9F25AE386DB6338A(camera);
}

_id_47E6ED10BE33FEF1(camera, _id_033153258526A7B2) {
  childthread _id_3F6B8F7CFF6A2C37(camera, _id_033153258526A7B2);
  msg = scripts\engine\utility::waittill_any_ents_or_timeout_return(_id_033153258526A7B2, camera, "emp_cleared", self, "playerExitingCameraMode");
  return msg;
}

_id_9F25AE386DB6338A(camera) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("deployableCamera_monitoringEMP");
  self endon("deployableCamera_monitoringEMP");
  thread _id_F238D4C7BAB11C82(camera);
  self.targetsinouterradius = [];
  _id_BFCDB898D70F248C();
  _id_7ABF9767930DCA21(camera, "taccam_static_full");
  self setclientomnvar("ui_tactical_camera_ddos_on", 1);

  if(!isDefined(self.empscramblelevels) || self.empscramblelevels.size == 0)
    scripts\cp_mp\emp_debuff::play_emp_scramble(3);

  msg = camera scripts\engine\utility::waittill_any_ents_return(camera, "emp_cleared", self, "playerLeavingCurrentCamera", self, "death", self, "playerExitingCameraMode");

  if(!isDefined(msg) || msg == "playerLeavingCurrentCamera" || msg == "death")
    _id_ECA023AD97260F51(camera);
  else {
    _id_4789702C319CD7A7(camera);
    _id_C9AD5AAF3183B83C();
  }

  if(msg == "death" || msg == "playerExitingCameraMode" || msg == "emp_cleared" || msg == "playerLeavingCurrentCamera")
    scripts\cp_mp\emp_debuff::_id_F7C6D776D032122F();
}

_id_F238D4C7BAB11C82(camera) {
  level endon("game_ended");
  self endon("disconnect");
  camera notify("deployableCamera_monitoringEMPVFX");
  camera endon("deployableCamera_monitoringEMPVFX");
  camera scripts\engine\utility::waittill_any_2("death", "emp_cleared");
  camera setscriptablepartstate("ddos", "neutral", 0);
  self setclientomnvar("ui_tactical_camera_ddos_on", 0);
}

_id_652247CE1ACB67C2(data) {
  attacker = data.attacker;
  self dodamage(self.maxhealth / 10, self.origin, attacker, data.inflictor);

  if(isDefined(self.damagetaken) && self.damagetaken >= 100) {
    if(!isDefined(self.owner) || scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) {
      attacker notify("destroyed_equipment");
      attacker thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_521EDEBB385E3753");
      attacker scripts\mp\battlechatter_mp::equipmentdestroyed(self);
    }
  }
}

_id_C7DBEA1F56DF2B64(camera, _id_08862825A0618BDA) {
  _id_C748B31A33C02C14 = _id_F0698AEE89C18210(_id_08862825A0618BDA)._id_BE3314F77FEF5D6B;
  self endon("death");
  camera endon("entering");
  level waittill("game_ended");
  [[_id_C748B31A33C02C14]](camera, 0);
}

_id_30DD206C5D9B45A7() {
  childthread _id_D600A854B585442D();
  childthread _id_DE1222813FF9939B();
  childthread _id_AB5DA94D0C38AB3C();
  self waittill("activateCamera", msg);
  self notifyonplayercommandremove("tacButtonPress", "+smoke");
  self notifyonplayercommandremove("tacButtonPress", "+actionslot 1");
  self notifyonplayercommandremove("fragButtonPress", "+frag");
  self notifyonplayercommandremove("fragButtonPress", "+equip_toggle_throw");
  self notifyonplayercommandremove("cameraActive", "+special");
  return msg == "success";
}

_id_537B1C669B864647() {
  childthread _id_CE83A297E29BC7DD();
  childthread _id_F981C735613B390B();
  self waittill("switchCamera", msg);
  _id_13E2543CD1847CA6();
  return msg;
}

_id_13E2543CD1847CA6() {
  self notifyonplayercommandremove("camSwitchKBM", "+special");
  self notifyonplayercommandremove("cameraSwitchLeft", "+smoke");
  self notifyonplayercommandremove("cameraSwitchRight", "+frag");
}

_id_F981C735613B390B() {
  self endon("switchCamera");
  self notifyonplayercommand("cameraSwitchLeftController", "+smoke");
  self notifyonplayercommand("cameraSwitchRightController", "+frag");
  msg = scripts\engine\utility::waittill_any_return_2("cameraSwitchLeftController", "cameraSwitchRightController");

  if(scripts\engine\utility::is_player_gamepad_enabled() || scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587()) {
    msg = strtok(msg, "Controller");
    self notify("switchCamera", msg[0]);
  }
}

_id_CE83A297E29BC7DD() {
  self endon("switchCamera");
  self notifyonplayercommand("cameraSwitchLeftKBM", "+moveleft");
  self notifyonplayercommand("cameraSwitchRightKBM", "+moveright");
  msg = scripts\engine\utility::waittill_any_return_2("cameraSwitchLeftKBM", "cameraSwitchRightKBM");

  if(!scripts\engine\utility::is_player_gamepad_enabled()) {
    msg = strtok(msg, "KBM");
    self notify("switchCamera", msg[0]);
  }
}

_id_EB1F8C19D4194AC3(_id_B8F96BD12748F572, _id_68EB6389CFEB3270, _id_AEA949753FB27001) {
  _id_EA5E69CB5E96E49C = self[[_id_68EB6389CFEB3270]]();

  if(!isDefined(_id_EA5E69CB5E96E49C) || _id_EA5E69CB5E96E49C.size == 0)
    return 0;

  if(!_id_84582DD92C385507(_id_AEA949753FB27001))
    return 0;

  currentweapon = self.currentweapon;
  _id_AC9CAEBED426E625 = self getweaponammoclip(currentweapon);
  _id_D1AD88BF84DAA67F = self getweaponammostock(currentweapon);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(currentweapon);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_B8F96BD12748F572);
  self clearoffhandspecial();
  self._id_75B981560F8453F4 = 1;
  self notify("activateCamera", "success");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_B8F96BD12748F572);
  self assignweaponoffhandspecial(_id_B8F96BD12748F572);
  thread _id_299B7FA84B1D28D1(currentweapon, _id_AC9CAEBED426E625, _id_D1AD88BF84DAA67F);
  return 1;
}

_id_299B7FA84B1D28D1(_id_17372FFC28DC7D78, _id_AC9CAEBED426E625, _id_D1AD88BF84DAA67F) {
  level endon("game_ended");
  self endon("disconnect");
  waittime = getdvarfloat("dvar_83F60684C63746BE", 0.0);
  wait(waittime + 0.05);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_17372FFC28DC7D78, undefined, undefined, 1);
  self setweaponammoclip(_id_17372FFC28DC7D78, _id_AC9CAEBED426E625);
  self setweaponammostock(_id_17372FFC28DC7D78, _id_D1AD88BF84DAA67F);
}

_id_D600A854B585442D() {
  self endon("activateCamera");
  self notifyonplayercommand("cameraActive", "+special");
  self waittill("cameraActive");
  self notify("activateCamera", "success");
}

_id_DE1222813FF9939B() {
  self endon("activateCamera");
  self notifyonplayercommand("tacButtonPress", "+smoke");
  self notifyonplayercommand("fragButtonPress", "+frag");
  _id_BD1267E9DEA3DBA9 = ["tacButtonPress", "fragButtonPress"];
  thread scripts\mp\supers::_id_8D6D95114B2C9B0D(_id_BD1267E9DEA3DBA9, ["activateCamera"], 0.75);
  self waittill("controllerSuperPress", msg);
  self notify("activateCamera", msg);
}

_id_AB5DA94D0C38AB3C() {
  self endon("activateCamera");
  self notifyonplayercommand("tacButtonPress", "+actionslot 1");
  self notifyonplayercommand("fragButtonPress", "+equip_toggle_throw");
  _id_BD1267E9DEA3DBA9 = ["tacButtonPress", "fragButtonPress"];
  thread scripts\mp\supers::_id_8D6D95114B2C9B0D(_id_BD1267E9DEA3DBA9, ["activateCamera"], 0.75);
  self waittill("controllerSuperPress", msg);
  self notify("activateCamera", msg);
}

_id_C57955CDA07E6609() {
  if(isDefined(level._id_E725F44030790232)) {
    return;
  }
  level._id_E725F44030790232 = scripts\engine\utility::_id_21A6A1C613B50A28(level.characters, 1575);
}

_id_343D2853C2474FEF() {
  for(;;) {
    wait 0.25;
    level._id_E725F44030790232 = undefined;
  }
}

_id_84582DD92C385507(_id_AEA949753FB27001) {
  if(self _meth_6F55D55CCFF20D14())
    return 0;

  if(istrue(self.isjuggernaut))
    return 0;

  if(self isinfreefall())
    return 0;

  if(self isjumping())
    return 0;

  if(self _meth_415FE9EECA7B2E2B())
    return 0;

  if(self _meth_E5BF22923D0004BC())
    return 0;

  if(self isthrowinggrenade()) {
    offhandweapon = self getheldoffhand();

    if(offhandweapon.basename != _id_AEA949753FB27001)
      return 0;
  }

  if(istrue(self._id_77FEFC8456ADB545))
    return 0;

  if(istrue(self.isusingcamera))
    return 0;

  if(isDefined(self.vehicle))
    return 0;

  if(!_id_3B64EB40368C1450::_id_E0751B03DFB9EB43("supers"))
    return 0;

  if(istrue(self.super.isdeploying))
    return 0;

  if(istrue(self._id_8A38603863A78B8E))
    return 0;

  if(istrue(self._id_859654E0445A36D9))
    return 0;

  if(self isswitchingweapon() && !istrue(self._id_75B981560F8453F4))
    return 0;

  return 1;
}

_id_B1FC1520E09105AA(camera) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("playerLeavingCurrentCamera");

  if(!isDefined(self.c4s) || self.c4s.size == 0)
    return 0;
  else {
    self notifyonplayercommand("c4_detonated", "+detonate");
    self notifyonplayercommand("c4_detonated", "+attack");
    self setclientomnvar("ui_tactical_camera_can_detonate_c4", 1);
    self waittill("c4_detonated");
    self notify("detonate");
    self setclientomnvar("ui_tactical_camera_can_detonate_c4", 0);
  }
}

_id_57E0EFE2F886BD46() {
  self notifyonplayercommandremove("c4_detonated", "+detonate");
  self notifyonplayercommandremove("c4_detonated", "+attack");
}

_id_2699A7C2C0B71D3E(camera, _id_08862825A0618BDA) {
  _id_C748B31A33C02C14 = _id_F0698AEE89C18210(_id_08862825A0618BDA)._id_BE3314F77FEF5D6B;
  self endon("death_or_disconnect");
  camera endon("death");
  self endon("playerLeavingCurrentCamera");
  level endon("game_ended");

  for(;;) {
    if(self isinexecutionvictim()) {
      break;
    }

    waitframe();
  }

  self thread[[_id_C748B31A33C02C14]](camera, 0);
}

_id_E4D938AD226591FD(cam) {
  cam _meth_5226227BCE83EBE9(3, cam.ownerteam);
  return cam;
}

_id_B13A5B9E0EA04DBD(target) {
  if(!isDefined(target))
    return 0;

  params = _id_F0698AEE89C18210(self._id_08862825A0618BDA);
  _id_128777C73408AE9D = params._id_37782917998D4FF2;

  if(istrue(self._id_6150B9D03028F80C) || istrue(target scripts\cp_mp\utility\player_utility::_id_988138367C74B1F5()))
    _id_128777C73408AE9D = params._id_9953DC2E8C205B77;

  if(!isDefined(_id_128777C73408AE9D)) {
    return;
  }
  return distancesquared(self.origin, target.origin) < _id_128777C73408AE9D;
}

_id_A268C4595BD106FF(target) {
  if(!isDefined(target))
    return 0;

  params = _id_F0698AEE89C18210(self._id_08862825A0618BDA);
  _id_7E2345A74EE18A53 = params._id_4FBADC7102D30912;

  if(istrue(self._id_6150B9D03028F80C) || istrue(target scripts\cp_mp\utility\player_utility::_id_988138367C74B1F5()))
    _id_7E2345A74EE18A53 = params._id_16187E4D354C3C97;

  return distancesquared(self.origin, target.origin) < _id_7E2345A74EE18A53;
}

_id_9D2BEC87E0754872(target) {
  info = spawnStruct();
  info._id_C37B1CC67943336D = _id_4E3AA9D829B3E164(target);
  info._id_9AE205C4C40AF967 = _id_F6BA29EFE27B0F81(target);
  info._id_CC86ADA7DF8F6C2F = _id_B13A5B9E0EA04DBD(target);
  info.isindetectrange = _id_A268C4595BD106FF(target);

  if(isDefined(self.pilot))
    info._id_20AA5B4097887CB6 = self.pilot _id_1B1409AF5E47B098(target, 80, 40);

  return info;
}

_id_8409D7CE07F426A1(camera) {
  level endon("game_ended");
  self endon("disconnect");
  camera endon("death");
  _id_4C663252DABD1483 = _id_F0698AEE89C18210(camera._id_08862825A0618BDA)._id_4C663252DABD1483;
  radius = getdvarfloat("dvar_B076F58C9B234DB3", 140);
  doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius(camera.origin, radius, 20);
  camera._id_8AC5EFCE71CC57C5 = [];

  foreach(door in doors) {
    _id_031F5044848A4AE3 = spawnStruct();
    _id_031F5044848A4AE3.door = door;
    _id_031F5044848A4AE3._id_8FFB4040B18F4E9E = camera.origin - door.origin;
    _id_031F5044848A4AE3._id_86974817459B2EF1 = door.angles;
    _id_031F5044848A4AE3._id_C8767A772842D047 = 56;
    _id_031F5044848A4AE3._id_2B0EFC06E5B01E0A = 96;
    camera._id_8AC5EFCE71CC57C5 = scripts\engine\utility::array_add(camera._id_8AC5EFCE71CC57C5, _id_031F5044848A4AE3);
  }

  if(camera._id_8AC5EFCE71CC57C5.size == 0) {
    return;
  }
  while(isDefined(camera) && !istrue(camera.isdestroyed)) {
    foreach(_id_1E92D8D3755A9FF8 in camera._id_8AC5EFCE71CC57C5) {
      if(_id_1E92D8D3755A9FF8.door.angles != _id_1E92D8D3755A9FF8._id_86974817459B2EF1) {
        _id_1E92D8D3755A9FF8._id_86974817459B2EF1 = _id_1E92D8D3755A9FF8.door.angles;
        _id_77C133840A36C8A4 = scripts\engine\math::anglebetweenvectors(scripts\engine\utility::flatten_vector(_id_1E92D8D3755A9FF8._id_8FFB4040B18F4E9E), anglesToForward(_id_1E92D8D3755A9FF8.door.angles));

        if(_id_77C133840A36C8A4 < 5.0) {
          _id_88D662FC2C82EDCA = vectordot(anglesToForward(_id_1E92D8D3755A9FF8.door.angles), _id_1E92D8D3755A9FF8._id_8FFB4040B18F4E9E);
          _id_ED6905BA175361C5 = vectordot(anglestoup(_id_1E92D8D3755A9FF8.door.angles), _id_1E92D8D3755A9FF8._id_8FFB4040B18F4E9E);

          if(_id_88D662FC2C82EDCA < _id_1E92D8D3755A9FF8._id_C8767A772842D047 && _id_ED6905BA175361C5 < _id_1E92D8D3755A9FF8._id_2B0EFC06E5B01E0A) {
            camera thread[[_id_4C663252DABD1483]]();
            break;
          }
        }
      }
    }

    waitframe();
  }
}

_id_2F4E45AB83F0B424(camera) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stopMonitoringCamera");

  for(;;) {
    self waittill("switch_thermal_mode");

    if(camera scripts\cp_mp\emp_debuff::is_empd()) {
      continue;
    }
    _id_FC0043E95242D5CB = _id_149FE9342A5EA239(camera);
    camera _id_07F8DA30C35B9AB0(camera, scripts\engine\utility::ter_op(_id_FC0043E95242D5CB == "tacCam", "killstreak_thermal", "tacCam"));
    _id_4789702C319CD7A7(camera);
  }
}

_id_07F8DA30C35B9AB0(camera, _id_0AE77C9542367530) {
  camera.currentvisionset = _id_0AE77C9542367530;
}

_id_4789702C319CD7A7(camera, _id_3830144DA9E3136B) {
  _id_FC0043E95242D5CB = _id_149FE9342A5EA239(camera);
  players = [self];

  if(!istrue(_id_3830144DA9E3136B)) {
    if(isDefined(camera._id_81BD7C12AC1DCE18)) {
      foreach(player in camera._id_81BD7C12AC1DCE18) {
        if(isDefined(player) && isalive(player))
          players[players.size] = player;
      }
    }
  }

  foreach(player in players)
  player _id_7ABF9767930DCA21(camera, _id_FC0043E95242D5CB);
}

_id_7ABF9767930DCA21(camera, _id_0AE77C9542367530, _id_B18D3429CF88F29F) {
  if(!isDefined(_id_B18D3429CF88F29F))
    _id_B18D3429CF88F29F = 0.0;

  if(camera.currentvisionset == "killstreak_thermal") {
    self visionsetkillstreakforplayer("");
    self visionsetthermalforplayer(_id_0AE77C9542367530, _id_B18D3429CF88F29F);
    self thermalvisionon();
  } else {
    self visionsetthermalforplayer("");
    self visionsetkillstreakforplayer(_id_0AE77C9542367530, _id_B18D3429CF88F29F);
    self thermalvisionoff();
  }
}

_id_ECA023AD97260F51(camera, _id_4602D2933C2D30A8) {
  if(camera.currentvisionset == "killstreak_thermal")
    self visionsetthermalforplayer("");
  else
    self visionsetkillstreakforplayer("");

  self thermalvisionoff();

  if(istrue(_id_4602D2933C2D30A8))
    camera.currentvisionset = undefined;
}

_id_149FE9342A5EA239(camera) {
  if(isDefined(camera.currentvisionset))
    return camera.currentvisionset;
  else {
    if(scripts\cp_mp\utility\game_utility::isnightmap())
      camera.currentvisionset = "killstreak_thermal";
    else
      camera.currentvisionset = "tacCam";

    return camera.currentvisionset;
  }
}

_id_804A24F3E1A7B680() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("stopMonitoringCamera");

  for(;;) {
    _id_FF8E235B01CD7409 = scripts\cp_mp\utility\player_utility::getthermalswitchplayercommand();
    self notifyonplayercommand("switch_thermal_mode", _id_FF8E235B01CD7409);
    _id_FD99CC32B0AC87B4 = scripts\engine\utility::waittill_any_return_no_endon_death_2("input_type_changed", "thermal_handling_ended");
    self notifyonplayercommandremove("switch_thermal_mode", _id_FF8E235B01CD7409);

    if(!isDefined(_id_FD99CC32B0AC87B4) || _id_FD99CC32B0AC87B4 == "thermal_handling_ended") {
      break;
    }
  }
}

_id_07DF57541F06A5F0() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("usingCamera");
  starttime = gettime();

  while(gettime() < starttime + 1000) {
    self disablephysicaldepthoffieldscripting();
    wait 0.1;
  }
}