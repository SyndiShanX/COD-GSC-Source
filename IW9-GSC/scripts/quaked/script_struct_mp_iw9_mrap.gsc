/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\quaked\script_struct_mp_iw9_mrap.gsc
********************************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_mil_lnd_mrap", ::_id_8385E33CB3E5E39E);
}

_id_8385E33CB3E5E39E() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_mil_lnd_mrap")) {
    return;
  }
  if(scripts\common\utility::iscp()) {
    return;
  }
  callbacks = [];
  callbacks["spawn"] = ::_id_C02DD63D8657CF38;
  callbacks["delete"] = ::_id_72B740C96F213C47;
  callbacks["enterStart"] = ::_id_517BCF849B4EC232;
  callbacks["enterEnd"] = ::_id_EDFACDE58CB56417;
  callbacks["exitEnd"] = ::_id_CCD9DB63CABE6FF1;
  callbacks["reenter"] = ::_id_A4D7A7606411E415;
  callbacks["createGrenadeTurret"] = ::_id_FCACBCC0004574A0;
  callbacks["exitExternalTurret"] = ::_id_1346CDF1ABB57E5B;
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_mil_lnd_mrap", callbacks);
  _id_E2818AD39A3341B4 = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_getleveldataforvehicle("veh9_mil_lnd_mrap", 1);
  _id_E2818AD39A3341B4.ammoids["popsmoke"] = 1;
  level.vehicle._id_EFB5620DEEAD5E9B = spawnStruct();
  level.vehicle._id_EFB5620DEEAD5E9B.canautodestruct = 1;
}

_id_C02DD63D8657CF38(spawndata, _id_EE8DA5624236DC89) {
  vehicle = scripts\cp_mp\vehicles\vehicle::_id_BBA34CF920370FF4("veh9_mil_lnd_mrap", spawndata, _id_EE8DA5624236DC89);
  _id_42691F43DB8E6783 = _id_4C0A67070435B7BE();
  mgturret = _id_994F2F7FD7A2BBDB(vehicle, "iw9_mg_mrap_mp", "veh9_mil_lnd_mrap_turret_gun", _id_42691F43DB8E6783.tag, _id_42691F43DB8E6783.tagoffset, _id_42691F43DB8E6783._id_7862C7C7ADE2B42E);
  scripts\cp_mp\vehicles\vehicle::vehicle_registerturret(vehicle, mgturret, makeweapon("iw9_mg_mrap_mp"));
  vehicle.mgturret = mgturret;

  if(!istrue(spawndata._id_427538F5A2AD4F8B)) {
    turret = _id_FCACBCC0004574A0(vehicle, spawndata);
    scripts\cp_mp\vehicles\vehicle::vehicle_registerturret(vehicle, turret, makeweapon("iw9_tur_mrap_mp"));
  } else if(isDefined(spawndata._id_14CDE247AC3313A4))
    vehicle._id_FADC8CE0C904ABDA = spawndata._id_14CDE247AC3313A4;

  if(istrue(spawndata._id_065DA0A245B653CC)) {
    vehicle.occupantsreserving["gunner"] = vehicle;
    vehicle._id_065DA0A245B653CC = 1;
  }

  if(istrue(spawndata._id_D04816FE2F5BCEE6))
    vehicle._id_CF9BA498AF4E41E9 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle("veh9_mil_lnd_mrap")._id_29F1EA79ED2B40DD;

  vehicle._id_EC76FFDBE2F37C5B = istrue(spawndata._id_EC76FFDBE2F37C5B);
  vehicle._id_B3C822AF793D474F = [];
  vehicle._id_09CD07317BA52DF4 = !vehicle._id_EC76FFDBE2F37C5B;

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    vehicle._id_C2594AC36EE74A08 = 35;
  else
    vehicle._id_C2594AC36EE74A08 = 10;

  vehicle thread _id_9C0FBC8660BE15B7();
  return vehicle;
}

_id_FCACBCC0004574A0(vehicle, spawndata) {
  weaponname = "iw9_tur_mrap_mp";
  turret = spawnturret("misc_turret", vehicle gettagorigin("tag_turret_front"), weaponname, 0);
  turret linkTo(vehicle, "tag_turret_front", (0, 0, 0), (0, 0, 0));
  model = "veh9_mil_lnd_mrap_turret_grenade";

  if(isDefined(spawndata._id_14CDE247AC3313A4))
    model = spawndata._id_14CDE247AC3313A4 + "::" + model;

  turret setModel(model);
  turret setmode("sentry_offline");
  turret setsentryowner(undefined);
  turret makeunusable();
  turret setdefaultdroppitch(0);
  turret setturretmodechangewait(1);
  turret.angles = vehicle.angles;
  turret.vehicle = vehicle;
  vehicle thread _id_6546F94C0980E1DD(turret);
  return turret;
}

_id_6546F94C0980E1DD(turret) {
  self endon("death");

  for(;;) {
    turret waittill("missile_fire", grenade);
    grenade.owner = turret.owner;
  }
}

_id_4C0A67070435B7BE() {
  _id_42691F43DB8E6783 = spawnStruct();
  _id_42691F43DB8E6783.tag = "tag_turret";
  _id_42691F43DB8E6783.tagoffset = (0, 0, 0);
  _id_42691F43DB8E6783._id_7862C7C7ADE2B42E = (-40, 0, 11);
  return _id_42691F43DB8E6783;
}

_id_994F2F7FD7A2BBDB(vehicle, turret_weapon, _id_076BA9E808A42F81, _id_7FD2FB13F979337C, _id_F7C8FC384585FA86, _id_721F077D971E21D5) {
  turret = spawnturret("misc_turret", vehicle gettagorigin(_id_7FD2FB13F979337C), turret_weapon, 0);
  turret linkTo(vehicle, _id_7FD2FB13F979337C, _id_F7C8FC384585FA86, (0, 0, 0));
  turret setModel(_id_076BA9E808A42F81);
  turret makeunusable();
  turret setmode("sentry_offline");
  turret setdefaultdroppitch(30);
  turret setturretmodechangewait(1);
  _id_644E15BD3BC54B4E = getdvarfloat("dvar_B1BCF912F9600C0E", 150);
  _id_963953C3478BF4FE = turret gettagorigin("tag_origin");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle", "createHint"))
    turret.useobject = [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle", "createHint")]](_id_963953C3478BF4FE, "HINT_BUTTON", undefined, &"VEHICLES_HINTS/USE_TURRET", -1, "duration_none", "show", _id_644E15BD3BC54B4E, undefined, _id_644E15BD3BC54B4E);

  turret.useobject linkTo(turret, "tag_origin", (0, getdvarfloat("dvar_634C96FA241F9C5D", 0), 0), (0, 0, 0));
  turret thread _id_5C1DBB360748154D(turret.useobject, vehicle, turret_weapon, _id_7FD2FB13F979337C);
  turret.angles = vehicle.angles;
  turret.vehicle = vehicle;
  turret.maxhealth = 400;
  turret.health = turret.maxhealth;
  turret._id_9F925F5509626DF1 = _id_721F077D971E21D5;
  return turret;
}

_id_5C1DBB360748154D(_id_EF5D5141FDB51174, vehicle, turretweapon, _id_7FD2FB13F979337C) {
  self endon("kill_turret");
  level endon("game_ended");

  foreach(player in level.players)
  _id_EF5D5141FDB51174 enableplayeruse(player);

  thread _id_EEDBAB7FAF413258(_id_EF5D5141FDB51174);

  for(;;) {
    _id_EF5D5141FDB51174 waittill("trigger", player);

    if(istrue(self.inuse)) {
      continue;
    }
    if(player isonladder() || !player isonground() || player ismantling() || istrue(player.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
        player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("VEHICLES/CANNOT_ENTER_TURRET");

      continue;
    }

    self.inuse = 1;
    _id_EF5D5141FDB51174 _meth_DFB78B3E724AD620(0);
    vehicle scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_stopwatchingabandoned();
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_hidecashbag(vehicle, undefined, player);
    player _meth_5847240C0F9900F2(0);
    weapon = "iw9_mg_mrap_mp";
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_deleteseatcorpse(vehicle, _id_7FD2FB13F979337C, 1);
    scripts\cp_mp\utility\vehicle_omnvar_utility::_id_D2D9C09551D91164(vehicle, player);
    turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(vehicle, weapon);
    level thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(player, scripts\engine\utility::ter_op(istrue(turret._id_ECC491F42AACEAF4), 850, 2200));
    turret._id_ECC491F42AACEAF4 = 1;
    scripts\cp_mp\vehicles\vehicle::_id_160EF1C877C69AB1(player, vehicle, self, _id_7FD2FB13F979337C);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(player, vehicle, weapon);
    scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_onentervehicle(vehicle, player);
    turret thread _id_9BF55F5544386843(player);
    turret thread _id_ED8363986249E9A4(player, vehicle);
    turret thread _id_47F1F11FAA1E0BFC(player, vehicle);
    turret thread _id_0870A09B029F348E(player, vehicle);
  }
}

_id_EEDBAB7FAF413258(useobj) {
  if(isDefined(self))
    self endon("kill_turret");

  level endon("game_ended");

  for(;;) {
    level waittill("connected", player);
    useobj enableplayeruse(player);
  }
}

_id_ED8363986249E9A4(player, vehicle) {
  self endon("kill_turret");
  player endon("end_turret_use");
  player endon("disconnect");
  level endon("game_ended");
  _id_71982E9B7E15C211 = 62500;

  for(;;) {
    if(player isinexecutionvictim() || distancesquared(self.origin, player.origin) >= _id_71982E9B7E15C211) {
      thread _id_1346CDF1ABB57E5B(player, vehicle);
      break;
    }

    waitframe();
  }
}

_id_47F1F11FAA1E0BFC(player, vehicle) {
  self endon("kill_turret");
  player endon("end_turret_use");
  player endon("disconnect");
  level endon("game_ended");

  while(player useButtonPressed())
    waitframe();

  for(;;) {
    if(player useButtonPressed()) {
      thread _id_1346CDF1ABB57E5B(player, vehicle);
      break;
    }

    waitframe();
  }
}

_id_0870A09B029F348E(player, vehicle) {
  self endon("kill_turret");
  player endon("end_turret_use");
  level endon("game_ended");
  player scripts\engine\utility::waittill_any_2("death_or_disconnect", "last_stand_start");
  thread _id_1346CDF1ABB57E5B(player, vehicle);
}

_id_9BF55F5544386843(player) {
  self endon("kill_turret");
  player endon("end_turret_use");
  player endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self.lastuserangles = player getplayerangles();
    waitframe();
  }
}

_id_1346CDF1ABB57E5B(player, vehicle) {
  self.inuse = 0;

  if(isDefined(player)) {
    player notify("end_turret_use");
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_showcashbag(vehicle, undefined, player);
    player _meth_5847240C0F9900F2(1);
  }

  scripts\cp_mp\vehicles\customization\battle_tracks::battle_tracks_onexitvehicle(vehicle, player);
  scripts\cp_mp\vehicles\vehicle::_id_4D2324450A951B2B(player, vehicle);
  vehicle thread scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_watchabandoned();
  self.useobject _meth_DFB78B3E724AD620(1);

  if(isDefined(player)) {
    player enableturretdismount();
    player controlturretoff(self);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(player, vehicle, self.objweapon.basename, spawnStruct(), 0);
    scripts\cp_mp\utility\vehicle_omnvar_utility::_id_5211953231A09ED5(vehicle, player);
  }

  self.owner = undefined;
  self setotherent(undefined);
  self setentityowner(undefined);

  if(isDefined(player) && player scripts\cp_mp\utility\player_utility::_isalive()) {
    player _meth_0A055801DA45D769(rotatevector(self._id_9F925F5509626DF1 + (randomfloatrange(-20, 20), randomfloatrange(-20, 20), 0), vehicle.angles) + vehicle.origin, vehicle);
    player setplayerangles(self.lastuserangles);
    thread scripts\cp_mp\vehicles\vehicle::vehicle_preventplayercollisiondamagefortimeafterexit(vehicle, player);
  }
}

_id_72B740C96F213C47(vehicle) {
  if(isDefined(vehicle.mgturret)) {
    vehicle.mgturret notify("kill_turret");

    if(isDefined(vehicle.mgturret.owner))
      vehicle.mgturret thread _id_1346CDF1ABB57E5B(vehicle.mgturret.owner, self);

    scripts\cp_mp\vehicles\vehicle::vehicle_deregisterturret(self, vehicle.mgturret.objweapon);
    vehicle.mgturret.useobject delete();
    vehicle.mgturret delete();
  }
}

_id_517BCF849B4EC232(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(seatid == "gunner") {
    if(istrue(player.insertingarmorplate)) {
      player notify("try_armor_cancel");

      while(isDefined(player.currentweapon) && isDefined(player.currentweapon.basename) && player.currentweapon.basename == "iw9_armor_plate_deploy_mp")
        waitframe();
    }
  }
}

_id_EDFACDE58CB56417(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(istrue(data.success))
    thread _id_9C320C91AB9708EE(vehicle, seatid, _id_FC7C7A874B43A31A, player, data);
}

_id_9C320C91AB9708EE(vehicle, seatid, _id_FC7C7A874B43A31A, player, data) {
  if(seatid == "driver") {
    vehicle thread _id_D6B5AD0707B3539E(player);
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(player, 250);
    player scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
    thread _id_50F0644FFD3CD614(player);
  } else if(seatid == "gunner") {
    level thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime(player, 100);
    player thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret(player, vehicle, "iw9_tur_mrap_mp");
    player visionsetkillstreakforplayer("aviCougarGunner", 0.0);
    player playerlinkTo(vehicle, "tag_seat_1");
    _id_E13DFE8CE29194BB(player);
    thread _id_BC35436299B4B69D(player);
  }

  if(!isDefined(_id_FC7C7A874B43A31A))
    vehicle _id_63F3C4DF75521924(player);

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter(vehicle, _id_FC7C7A874B43A31A, seatid, player);
  _id_48658D8851154485(vehicle, _id_FC7C7A874B43A31A, seatid, player);
}

_id_CCD9DB63CABE6FF1(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(istrue(data.success))
    thread _id_CCF255ACAB209214(vehicle, seatid, _id_7558F98F3236963D, player, data);
}

_id_CCF255ACAB209214(vehicle, seatid, _id_7558F98F3236963D, player, data) {
  if(seatid == "driver") {
    vehicle notify("mrap_driver_exit");

    if(!istrue(data.playerdisconnect))
      player scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
  } else if(seatid == "gunner") {
    turret = scripts\cp_mp\vehicles\vehicle::vehicle_getturretbyweapon(vehicle, "iw9_tur_mrap_mp");
    thread _id_50F0644FFD3CD614(player);

    if(!istrue(data.playerdisconnect)) {
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(player, vehicle, "iw9_tur_mrap_mp", spawnStruct());
      player enableturretdismount();

      if(player islinked())
        player unlink();

      player visionsetkillstreakforplayer("");
      thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime(player, data.playerdeath);
    }

    turret.owner = undefined;
    turret setotherent(undefined);
    turret setentityowner(undefined);
    turret setsentryowner(undefined);
    _id_6C43FBFC4C4772B2(player);
  }

  if(!istrue(data.playerdisconnect)) {
    if(!isDefined(_id_7558F98F3236963D))
      vehicle _id_63F3C4DF75521924(player);

    success = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit(vehicle, seatid, _id_7558F98F3236963D, player, data);

    if(!success) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](player);
      else
        player suicide();
    }
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit(vehicle, seatid, _id_7558F98F3236963D, player);
}

_id_A4D7A7606411E415(vehicle, _id_9DE41F2EE77C33BA, _id_3F68C37BAFD38606, player, data) {
  if(isDefined(_id_3F68C37BAFD38606) && _id_3F68C37BAFD38606 == "gunner")
    thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret(player, vehicle, "iw9_tur_mrap_mp", data, 1);
}

_id_BC35436299B4B69D(player) {
  player setclienttriggeraudiozone("veh_mrap_turret", 0.2);
}

_id_50F0644FFD3CD614(player) {
  player clearclienttriggeraudiozone(0.2);
}

_id_E13DFE8CE29194BB(player) {
  if(isDefined(player.gunnerdamagemodifier)) {
    return;
  }
  player scripts\cp_mp\utility\damage_utility::adddamagemodifier("ltGunnerMissileRedux", 0.4, 0, ::_id_CDA65DC0EB19E782);
}

_id_6C43FBFC4C4772B2(player) {
  if(!isDefined(player.gunnerdamagemodifier)) {
    return;
  }
  player.gunnerdamagemodifier = undefined;
  player scripts\cp_mp\utility\damage_utility::removedamagemodifier("ltGunnerMissileRedux", 0);
}

_id_CDA65DC0EB19E782(inflictor, attacker, victim, damage, meansofdeath, objweapon, hitloc) {
  if(meansofdeath != "MOD_PROJECTILE_SPLASH" && meansofdeath != "MOD_GRENADE_SPLASH")
    return 1;

  if(!isDefined(objweapon))
    return 1;

  switch (objweapon.basename) {
    case "iw8_la_kgolf_mp":
    case "iw8_la_mike32_mp":
    case "iw8_la_rpapa7_mp":
    case "iw9_tur_apc_russian_mp":
    case "iw9_tur_cougar_mp":
    case "iw9_la_juliet_mp":
    case "iw9_la_gromeo_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeoks_mp":
    case "iw8_la_gromeo_mp":
      return 0;
    default:
      return 1;
  }
}

_id_CE4C02D228C5B367(_id_45C9B66826527876) {
  icon = self.headicon;

  if(!isDefined(icon)) {
    icon = scripts\cp_mp\entityheadicons::setheadicon_createnewicon();

    if(!isDefined(icon))
      return 0;

    self.headicon = icon;
    setheadiconzoffset(icon, 110);
  }

  self.headiconforcapture = istrue(_id_45C9B66826527876);
  _id_30516B4AFD1763DE = scripts\engine\utility::ter_op(istrue(_id_45C9B66826527876), 0, 0);
  maxdist = scripts\engine\utility::ter_op(istrue(_id_45C9B66826527876), 2250, 2250);
  _id_94DC5DEAB609FDC9 = scripts\engine\utility::ter_op(istrue(_id_45C9B66826527876), 1, 0);
  _id_C18F8868BD35FEE2 = scripts\engine\utility::ter_op(istrue(_id_45C9B66826527876), 1, 0);
  setheadiconnaturaldistance(icon, _id_30516B4AFD1763DE);
  setheadiconmaxdistance(icon, maxdist);
  setheadicondrawthroughgeo(icon, _id_94DC5DEAB609FDC9);
  setheadiconsnaptoedges(icon, _id_C18F8868BD35FEE2);

  if(istrue(level._id_32FE21B3C5052471) && level.teambased)
    _func_CE9D0299637C2C24(icon, 1);
}

_id_A9DF40A21CD98D19() {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headicon);
  self.headicon = undefined;
  self.headiconowneroverride = undefined;
  self.headiconteamoverride = undefined;
}

_id_6457B39281A7F9CA(_id_26EBC4AB45D7E908, _id_C8251387149387A0) {
  if(!isDefined(self.headicon)) {
    return;
  }
  if(isDefined(_id_26EBC4AB45D7E908)) {
    if(isstring(_id_26EBC4AB45D7E908) && _id_26EBC4AB45D7E908 == "none")
      self.headiconowneroverride = undefined;
    else
      self.headiconowneroverride = _id_26EBC4AB45D7E908;
  }

  if(isDefined(_id_C8251387149387A0)) {
    if(_id_C8251387149387A0 == "none")
      self.headiconteamoverride = undefined;
    else
      self.headiconteamoverride = _id_C8251387149387A0;
  }

  _id_AB60EC681CA9AF95();
  _id_ECB6F9099A4E8F6B();
  _id_4CD40B506A2F07FF();

  foreach(player in level.players)
  _id_63F3C4DF75521924(player);
}

_id_63F3C4DF75521924(player) {
  if(!isDefined(self.headicon)) {
    return;
  }
  vehicle = player scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(vehicle) && vehicle == self)
    scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
  else {
    owner = undefined;

    if(isDefined(self.headiconowneroverride))
      owner = self.headiconowneroverride;
    else
      owner = self.owner;

    team = undefined;

    if(isDefined(self.headiconteamoverride))
      team = self.headiconteamoverride;
    else
      team = self.team;

    _id_962A30A9BB8C0F09 = _id_C38A5128F25CFBEE();

    if(level.teambased) {
      if(team == "neutral") {
        if(!isDefined(owner)) {
          if(1)
            scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
          else
            scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);

          return;
        } else
          team = owner.team;
      }

      if(isenemyteam(team, player.team)) {
        if(istrue(_id_962A30A9BB8C0F09.showheadicontoenemy))
          scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
        else
          scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
      } else
        scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
    } else {
      if(!isDefined(owner)) {
        if(1)
          scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
        else
          scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);

        return;
      }

      if(player != owner) {
        if(_id_962A30A9BB8C0F09.showheadicontoenemy) {
          scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
          return;
        }

        scripts\cp_mp\entityheadicons::setheadicon_removeclientfrommask(self.headicon, player);
        return;
        return;
      }

      scripts\cp_mp\entityheadicons::setheadicon_addclienttomask(self.headicon, player);
    }
  }
}

_id_0FA5FBAF4803F160(player) {
  lighttanks = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstances("veh9_mil_lnd_mrap");

  foreach(lighttank in lighttanks)
  lighttank _id_63F3C4DF75521924(player);
}

_id_AB60EC681CA9AF95() {
  if(level.teambased)
    return 0;

  owner = undefined;

  if(isDefined(self.headiconowneroverride))
    owner = self.headiconowneroverride;
  else
    owner = self.owner;

  if(isDefined(owner))
    setheadiconowner(self.headicon, owner);
  else
    setheadiconowner(self.headicon, undefined);

  return 1;
}

_id_ECB6F9099A4E8F6B() {
  if(!level.teambased) {
    return;
  }
  team = _id_A52340952557C2B6();

  if(isDefined(team) && team != "neutral")
    setheadiconteam(self.headicon, team);
  else
    setheadiconteam(self.headicon, undefined);
}

_id_4CD40B506A2F07FF() {
  _id_962A30A9BB8C0F09 = _id_C38A5128F25CFBEE();
  _id_9318D957CB71A518 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 1, 1);

  if(_id_9318D957CB71A518) {
    setheadiconfriendlyimage(self.headicon, level.factionfriendlyheadicon);

    if(1)
      setheadiconneutralimage(self.headicon, level.factionenemyheadicon);

    if(_id_962A30A9BB8C0F09.showheadicontoenemy)
      setheadiconenemyimage(self.headicon, level.factionenemyheadicon);
  } else {
    _id_C3E202ACF77E4DD4 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 1, 1);
    _id_F1A0DCC04676E92F = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), 0, _id_962A30A9BB8C0F09.showheadicontoenemy);
    _id_74CE33B771C6CA07 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley_friendly", "hud_icon_killstreak_bradley_friendly");
    _id_9830D857024187A1 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley", "hud_icon_killstreak_bradley");
    _id_36A93664071874B4 = scripts\engine\utility::ter_op(istrue(self.headiconforcapture), "hud_icon_killstreak_bradley_enemy", "hud_icon_killstreak_bradley_enemy");
    setheadiconfriendlyimage(self.headicon, _id_74CE33B771C6CA07);

    if(_id_C3E202ACF77E4DD4)
      setheadiconneutralimage(self.headicon, _id_9830D857024187A1);

    if(_id_F1A0DCC04676E92F)
      setheadiconenemyimage(self.headicon, _id_36A93664071874B4);
  }
}

_id_A52340952557C2B6() {
  owner = undefined;

  if(isDefined(self.headiconowneroverride))
    owner = self.headiconowneroverride;
  else
    owner = self.owner;

  team = undefined;

  if(isDefined(self.headiconteamoverride))
    team = self.headiconteamoverride;
  else
    team = self.team;

  _id_9A6FCCC729B4650A = team;

  if(!isDefined(_id_9A6FCCC729B4650A) || team == "neutral") {
    if(isDefined(owner))
      _id_9A6FCCC729B4650A = owner.team;
  }

  return _id_9A6FCCC729B4650A;
}

_id_9C0FBC8660BE15B7() {
  self endon("death");

  for(;;) {
    driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

    if(istrue(self._id_EC76FFDBE2F37C5B)) {
      if(isDefined(driver))
        driver setclientomnvar("ui_veh_flares_charge_perc", 0);

      waitframe();
      continue;
    } else if(self._id_09CD07317BA52DF4) {
      if(isDefined(driver)) {
        if(driver getclientomnvar("ui_veh_flares_charge_perc") < 1.05) {
          driver setclientomnvar("ui_veh_flares_charge_perc", 1.05);
          scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("veh9_mil_lnd_mrap", "popsmoke", 1, driver);
        }
      }
    } else {
      _id_77151E8D83F062CB = 0;

      while(_id_77151E8D83F062CB < self._id_C2594AC36EE74A08) {
        wait 0.05;
        _id_77151E8D83F062CB = _id_77151E8D83F062CB + 0.05;
        _id_E9227A816ED1D671 = _id_77151E8D83F062CB / self._id_C2594AC36EE74A08;
        driver = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriver(self);

        if(isDefined(driver))
          driver setclientomnvar("ui_veh_flares_charge_perc", _id_E9227A816ED1D671);
      }

      self._id_09CD07317BA52DF4 = 1;
    }

    waitframe();
  }
}

_id_D6B5AD0707B3539E(player) {
  self endon("death");
  self endon("mrap_driver_exit");
  player endon("death_or_disconnect");
  player endon("vehicle_exit");
  player notifyonplayercommand("pop_smoke", "+attack");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("veh9_mil_lnd_mrap", "popsmoke", scripts\engine\utility::ter_op(self._id_09CD07317BA52DF4, 1, 0), player);

  for(;;) {
    player waittill("pop_smoke");

    if(istrue(self._id_EC76FFDBE2F37C5B)) {
      continue;
    }
    if(!self._id_09CD07317BA52DF4) {
      self playsoundtoplayer("lbravo_noflares_warning", player);
      continue;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("popsmoke", "deploy"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("popsmoke", "deploy")]](["tag_smoke_grenade_front_left", "tag_smoke_grenade_front_right", "tag_smoke_grenade_back_left", "tag_smoke_grenade_back_right"]);

    self._id_09CD07317BA52DF4 = 0;
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_setammo("veh9_mil_lnd_mrap", "popsmoke", 0, player);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_fadeoutcontrols(player);
  }
}

_id_C38A5128F25CFBEE() {
  return level.vehicle._id_EFB5620DEEAD5E9B;
}

_id_48658D8851154485(vehicle, _id_FC7C7A874B43A31A, _id_7558F98F3236963D, player) {
  vehicle _id_E9E5CD0650EE3E3E(player);
}

_id_E9E5CD0650EE3E3E(player) {
  _id_962A30A9BB8C0F09 = _id_C38A5128F25CFBEE();

  if(_id_962A30A9BB8C0F09.canautodestruct) {
    if(istrue(self.autodestructactivated))
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("burningDown", player, "veh9_mil_lnd_mrap");
    else
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", player, "veh9_mil_lnd_mrap");
  } else
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", player, "veh9_mil_lnd_mrap");
}