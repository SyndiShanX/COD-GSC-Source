/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_sandbox.gsc
********************************************************/

main() {
  if(!isDefined(level.brgametype) || level.brgametype.name != "sandbox") {
    return;
  }
  init();
}

init() {
  level.isstandardsandbox = getdvarint("dvar_77135C6FAF81B889", 1);
  level.isx1ops = !level.isstandardsandbox;
  _id_362C58E8BB39BCDA::disablefeature("circle");
  _id_362C58E8BB39BCDA::disablefeature("teamSpectate");
  _id_362C58E8BB39BCDA::disablefeature("oneLife");
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerKilled", ::onplayerkilled);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerKilledSpawn", ::playerrespawn);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerDropPlunderOnDeath", ::playerdropplunderondeath);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("restartCircleElimination", ::restartcircleelimination);
  _id_362C58E8BB39BCDA::enablefeature("allowLateJoiners");
  level.brgametype.extractplunder = getdvarint("dvar_3110A9F80A569319", 0);
  level.brgametype.respawndelay = getdvarint("dvar_0AEA1EED13D0FB77", 10);
  level.showplunderextracticonsinworld = 0;
  level.brgametype.killcount = 0;

  if(level.isstandardsandbox) {
    _id_362C58E8BB39BCDA::disablefeature("infil");
    _id_362C58E8BB39BCDA::enablefeature("dropBagLoop");
    _id_362C58E8BB39BCDA::enablefeature("tabletReplace");
    _id_362C58E8BB39BCDA::enablefeature("attractions");
    _id_362C58E8BB39BCDA::enablefeature("allowLateJoiners");

    if(getdvarint("dvar_BD0D69513661A7CF", 0))
      _id_362C58E8BB39BCDA::disablefeature("drogBagLoadout");

    _id_40F522DB9C1FD341 = getdvarint("dvar_DB81BA0EE7498C90", 300);
    _id_362C58E8BB39BCDA::registerbrgametypedata("dropBagDelay", _id_40F522DB9C1FD341);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("getInfilPlayers", ::getinfilplayers);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerConnect", ::onplayerconnect);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("spawnHandled", ::spawnhandled);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("modifyPlayerDamage", ::modifyplayerdamage);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("modifyVehicleDamage", ::modifyvehicledamage);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::playerwelcomesplashes);
    level.brgametype.disabledamagefilter = getdvarint("dvar_122A052CFE57EBE3", 0);
    level.brgametype.nextcombatareaid = 0;
    level.brgametype.maxkills = getdvarint("dvar_4D3BB8B3622A156F", 0);
    level.brgametype.joininprogresstimeout = getdvarint("dvar_9E641EBFA783445F", 900);
    level.brgametype.drawprematchareas = getdvarint("dvar_CC82255853836056", 0);
    level.brgametype.timelimit = getdvarint("scr_br_timelimit", 1500);
    level.brgametype.redployanywhere = getdvarint("dvar_DE172A2A55733D1B", 0);
    level.brgametype.autostartcircle = getdvarint("dvar_86F116AD4C284595", 1200);
    level.brgametype.firstteam = "tie";
    level.prematchperiodend = 0;
    level.br_infils_disabled = 1;
    level.skipprematch = getdvarint("dvar_77135C6FAF81B889", 1);

    if(!istrue(level.br_allowloadout))
      level.parachuterestoreweaponscb = ::blankfunc;

    level.skipprematch = 1;
    level.extractplunderheliinvulnerable = 1;
    level.plunderextractalertnearby = 1;
    level.disableforfeit = 1;
    level.brenableagents = 1;
  } else {
    level.skipprematch = 0;
    level.giveloadouteverytime = 1;
    _id_362C58E8BB39BCDA::enablefeature("prematchBlueprints");
    _id_362C58E8BB39BCDA::disablefeature("kiosk");
    _id_362C58E8BB39BCDA::disablefeature("movingCircle");
    level.finalkillcamenabled = 0;

    if(getdvarint("dvar_9202A03077277B83", 1))
      _id_362C58E8BB39BCDA::disablefeature("drogBagLoadout");

    _id_362C58E8BB39BCDA::registerbrgametypefunc("onEnterCalloutArea", ::x1opsentercalloutarea);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("onInfilSequenceEnd", ::x1opsinfilsequenceend);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("playerSkipLootPickup", ::playerskiplootpickup);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("lootUsedIgnore", ::_id_B6B71C738C7F7CA4);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("getFinalCircleCenter", ::_id_21C3E8D48552A4FA);
    _id_362C58E8BB39BCDA::registerbrgametypefunc("mapCenterFinalCircle", ::_id_21C3E8D48552A4FA);
    level.brgametype._id_E2FFB7EE26B080B6 = getdvarint("dvar_3A78A0387C6FC510", 100);
    level.brgametype._id_E46CF5267BD6DC28 = getdvarint("dvar_308FC442310D31BD", 12);
    level.brgametype._id_F29EAE31F81C88BA = getdvarint("dvar_1BD5A86EFA3D1327", 1);
    level.brgametype._id_ABB52F743501A63F = getdvarfloat("dvar_0DEE9CF4B9B1B35D", 500);
    level.brgametype._id_F4F30AF2777795EF = level.brgametype._id_ABB52F743501A63F * level.brgametype._id_ABB52F743501A63F;
    level.brgametype.respawntags = [];
    level.brgametype.respawntagsfreed = [];
    level.brgametype._id_28EBAC07FDF67F25 = getdvarint("dvar_46C9C3C8C25300D9", 9500);
    level.conf_fx["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
    game["dialog"]["zeus_reveal_infil_sequence_01"] = "zeus_reveal_quotes_10";
    game["dialog"]["zeus_reveal_infil_sequence_02"] = "zeus_reveal_quotes_20";
    game["dialog"]["zeus_reveal_x1ops5_ascension"] = "zeus_reveal_quotes_60";
    game["dialog"]["zeus_reveal_gulag_area"] = "zeus_reveal_quotes_40";
    level.brgametype.respawndelay = getdvarint("dvar_2057BFD69D9F6323", 0);
    level.brgametype.timelimit = getdvarint("scr_br_timelimit", 1500);
    level.parachuterestoreweaponscb = ::blankfunc;
    level.brgametype.maxkills = undefined;
    level.x1ops = 0;
    level.x1opsnpcs = spawnStruct();
    level.x1opsnpcs.npcbodies = [];

    if(level.script == "mp_br_mechanics") {
      level.x1opsnpcs.locationsnames = ["default"];
      level.x1opsnpcs.origins = [(400, -2300, 0)];
      level.x1opsnpcs.rotations = [(0, 0, 0)];
    } else {
      level.x1opsnpcs.locationsnames = ["super_tac", "storagetown_tac", "layover_tac", "dam_tac", "airfield_tac", "quarry_tac", "lumber_tac", "farms_tac", "transit_tac", "boneyard_tac", "shopping_district_w_tac", "shopping_district_e_tac", "hills_tac", "tavorsk_park_tac", "port_tac", "gulag_tac", "tvstation_tac", "hospital_tac", "downtown_tac"];
      level.x1opsnpcs.origins = [(-13079, 9089, -286), (-26160, 8012, -156), (-23309, 26362, -331), (-24097, 43669, -159), (5351, 51881, 1045), (39911, 46919, 1118), (53868, 8230, 89), (55468, -15190, -273), (-11703, -19526, -615), (-29746, -14684, -136), (-23741, -26638, -89), (-3177, -20882, -247), (-10146, -33398, 168), (17460, -35155, 329), (29860, -32473, 241), (50722, -40232, 453), (15700, 17358, 153), (7993, -8089, -247), (16093, 985, -463)];
      level.x1opsnpcs.rotations = [(0, 92, 0), (0, 104, 0), (0, 7, 0), (0, 155, 0), (0, 264, 0), (0, 69, 0), (0, 88, 0), (0, 193, 0), (0, 86, 0), (0, 254, 0), (0, 195, 0), (0, 134, 0), (0, 158, 0), (0, 54, 0), (0, 285, 0), (0, 82, 0), (0, 45, 0), (0, 292, 0), (0, 264, 0)];
    }

    level.x1opsnpcs.teamsassigned = [];
    level.brgametype._id_D1944CD1FA64CA75 = _id_B4A62B8CF10E52B0();
    level.disableforfeit = 1;
  }

  level.br_allowdropspawnafterprematch = 1;
  thread initpostmain();
}

initpostmain() {
  waittillframeend;
  level.prewaitandspawnclient = ::brprewaitandspawnclient;
  level.modemayconsiderplayerdead = ::brmayconsiderplayerdead;
  level.modeonspawnplayer = ::onspawnplayer;
  scripts\cp_mp\utility\script_utility::registersharedfunc("vehicle_spawn", "gameModeSupportsRespawn", ::vehicle_spawn_mp_gamemodesupportsrespawn);
  level.vehicle.spawn.respawndelayoverride = getdvarint("dvar_59BE02F2DCB88B23", 30);

  if(level.isstandardsandbox) {
    level.ontimelimit = ::ontimelimit;
    thread setuptimelimit();
    thread setupglobalkillcount();

    if(level.brgametype.joininprogresstimeout)
      thread runjoininprogresstimeout();

    if(level.brgametype.drawprematchareas)
      thread rundrawprematchareas();

    if(level.brgametype.autostartcircle > 0)
      thread runautocircle(level.brgametype.autostartcircle);
  } else if(getdvarint("dvar_9D868E9083FD9424", 0))
    level thread x1unittimedivision();
  else
    level thread x1timedivision();
}

blankfunc() {}

vehicle_spawn_mp_gamemodesupportsrespawn() {
  return 1;
}

onplayerconnect(player) {
  if(istrue(level.brgametype.redployanywhere) && !istrue(level.brgametype.circlerunning))
    player thread playerhandlesandboxmenu();

  player.sandbox_safe_area_count = 0;
  player.sandbox_combat_area_bits = 0;
}

onspawnplayer(_id_9156B53BCF7CE573) {
  self notify("br_spawned");

  if(isagent(self)) {
    return;
  }
  if(istrue(level.isx1ops) && (isDefined(level.x1ops) && level.x1ops != 0)) {
    self setclientomnvar("ui_br_infil_started", 1);
    self setclientomnvar("ui_br_infiled", 1);
  }

  _id_756150045B2B7AD8 = istrue(self.gulag);
  _id_7E52B56769FA7774::initplayer(_id_756150045B2B7AD8);
  _id_1F6BC044DD1738AB::initplayer();
  self.oldprimarygun = undefined;
  self.newprimarygun = undefined;
  self.healthregendisabled = 0;
  self.br_lastscenecheck = gettime();
  self.needtoplayintro = undefined;
  self.gunnlessweapon = undefined;
  level.superdelay = 0;
  level.superpointsmod = 1;

  if(level.isstandardsandbox)
    self.br_infilstarted = 1;

  if(level.parachutecancutautodeploy)
    self skydive_cutautodeployon();
  else
    self skydive_cutautodeployoff();

  if(level.parachutecancutparachute)
    self skydive_cutparachuteon();
  else
    self skydive_cutparachuteoff();

  thread x1infilarmorwatch();

  if(!scripts\mp\flags::gameflag("prematch_done"))
    self setclientomnvar("ui_br_x1_checklist_state", 1);
}

playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_gametype_sandbox_welcome");
}

spawnhandled(player) {
  player thread playerspawn(0);
  return 1;
}

brmayconsiderplayerdead(player) {
  return 1;
}

playerrespawn(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7) {
  level endon("game_ended");
  self endon("disconnect");

  if(level.isx1ops) {
    if(getdvarint("dvar_9D868E9083FD9424", 0))
      x1opsunitrespawnselection();
    else
      x1opsrespawnselection();

    return 1;
  }

  thread playerspawn(1);
  return 1;
}

playerspawn(respawn) {
  level endon("game_ended");
  self endon("disconnect");

  if(level.isstandardsandbox) {
    if(!istrue(level.br_allowloadout))
      self.class = _id_1E4A61DB11011446::pickprematchrandomloadout();
  }

  if(!istrue(level.skipprematchdropspawn)) {
    if(respawn) {
      height = _id_0930A1E7BD882C1D::getinfilspawnoffset();
      self.prespawnspawn = _id_5BAB271917698DC4::_id_952548D8AED47102(0, undefined, height);
      self.prespawnspawn.index = -1;
    } else {
      self.prespawnspawn = _id_1E4A61DB11011446::getspawnpoint(1);
      height = scripts\cp_mp\parachute::getc130height();
      spawnorigin = scripts\engine\utility::drop_to_ground(self.prespawnspawn.origin, 1500, -20000);
      _id_A6427A6A24F058DC = (0, 0, height);
      self.prespawnspawn.origin = _id_1E4A61DB11011446::getoffsetspawnorigin(spawnorigin, _id_A6427A6A24F058DC);
    }
  }

  scripts\mp\playerlogic::waitandspawnclient(0);
  self freezecontrols(1);

  if(!istrue(level.skipprematchdropspawn))
    thread _id_1E4A61DB11011446::prematchdeployparachute();

  while(!isalive(self))
    waitframe();

  waitframe();

  if(!istrue(level.isx1ops) || istrue(level.isx1ops) && istrue(level.br_latejoininfilready))
    _id_1E4A61DB11011446::givelaststandifneeded(self);

  _id_07C40FA80892A721::givestartingarmor();

  if(level.isstandardsandbox) {
    startammo = getdvarint("dvar_D43BAE2741E07C5F", -1);

    if(startammo == -2) {
      foreach(objweapon in [self.primaryweapon, self.secondaryweapon]) {
        if(isDefined(objweapon)) {
          clipsize = weaponclipsize(objweapon);
          self setweaponammoclip(objweapon, clipsize);
          self givemaxammo(objweapon);
        }
      }

      _id_724736FCF0FB6604::br_ammo_update_weapons(self);
    } else if(startammo == -1)
      _id_724736FCF0FB6604::br_ammo_player_max_out();
    else if(startammo > 0) {
      foreach(weaponname in [self.primaryweapon, self.secondaryweapon]) {
        if(isDefined(weaponname)) {
          clipsize = weaponclipsize(weaponname);
          self setweaponammoclip(weaponname, clipsize);
          objweapon = makeweaponfromstring(weaponname);
          ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(objweapon);
          _id_724736FCF0FB6604::br_ammo_give_type(self, ammotype, clipsize * startammo);
        }
      }

      _id_724736FCF0FB6604::br_ammo_update_weapons(self);
    }
  } else
    _id_724736FCF0FB6604::br_ammo_player_max_out();

  thread _id_1E4A61DB11011446::br_displayperkinfo();
  self skydive_setdeploymentstatus(1);
  self skydive_setbasejumpingstatus(1);
  _id_4DE859B9228E5CFD = !self isplayerheadless();
  _id_C30AC8F00CB1CC8A = gettime();

  if(_id_4DE859B9228E5CFD) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist)) {
      if(_id_C30AC8F00CB1CC8A + 3000 < gettime()) {
        break;
      }

      waitframe();
    }
  }

  self notify("brWaitAndSpawnClientComplete");
  self.waitingtospawn = 0;
  self freezecontrols(0);

  if(respawn)
    _id_0A34750D17473C49::unmarkplayeraseliminated(self);
}

brprewaitandspawnclient(_id_9156B53BCF7CE573) {
  _id_CFE7A96C940A3337 = 0.5;

  if(!isDefined(self.prespawnspawn) || self isplayerheadless()) {
    self setclientomnvar("ui_br_extended_load_screen", 0);
    return;
  }

  thread _id_1E4A61DB11011446::brprewaitandspawnclientcleanup();

  if(!isDefined(self.initialprespawn) && !(isDefined(level.x1ops) && level.x1ops == 6)) {
    _id_59F83245849A4353 = level.brgametype.respawndelay > 0;
    _id_35311C66551EA674 = undefined;

    if(_id_59F83245849A4353) {
      _id_35311C66551EA674 = level.brgametype.respawndelay * 1000;
      _id_1E4A61DB11011446::spawnintermission(self.origin + (0, 0, 100), self.angles);
      scripts\mp\spectating::setdisabled();
    }

    droporigin = _id_2CEDCC356F1B9FC8::playerstreamhintdroptoground(self.prespawnspawn.origin, self.prespawnspawn.height);
    timeout = getdvarint("dvar_6CE81E74109AF8D3", 9000);
    _id_2CEDCC356F1B9FC8::playerstreamhintlocation(droporigin, timeout, 1, 0, _id_35311C66551EA674);

    if(_id_59F83245849A4353) {
      _id_38BE833E8648FD5F = 4.0;
      _id_B2D4B76E9BBD89ED = 1.0;
      _id_92E4C63FBCE4E020 = 0.25;
      _id_C6B801FDECA88BFF = _id_B2D4B76E9BBD89ED - _id_92E4C63FBCE4E020;
      self setclientomnvar("ui_show_spectateHud", self getentitynumber());
      scripts\mp\utility\lower_message::setlowermessageomnvar("waiting_to_spawn", int(gettime() + _id_35311C66551EA674));
      _id_804CDB270D2D1FCC = max(level.brgametype.respawndelay - _id_38BE833E8648FD5F, 0);
      wait(_id_804CDB270D2D1FCC);
      thread _id_5BAB271917698DC4::fadeoutin(_id_B2D4B76E9BBD89ED);
      wait(_id_C6B801FDECA88BFF);
      _id_1E4A61DB11011446::spawnintermission(droporigin, self.prespawnspawn.angles);
      self setclientomnvar("ui_br_transition_type", 2);
      wait(_id_92E4C63FBCE4E020);
      _id_B1959D90F987E135 = max(level.brgametype.respawndelay - _id_804CDB270D2D1FCC - _id_B2D4B76E9BBD89ED, 0);
      wait(_id_B1959D90F987E135);
      _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();
      self setclientomnvar("ui_show_spectateHud", -1);
    } else {
      if(!istrue(level.x1playertransition))
        self setclientomnvar("ui_br_transition_type", 4);

      wait(_id_CFE7A96C940A3337);
      _id_1E4A61DB11011446::spawnintermission(droporigin, self.prespawnspawn.angles);
      scripts\mp\spectating::setdisabled();
      _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
    }
  } else {
    self.initialprespawn = undefined;
    _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
  }

  self freezecontrols(0);
}

setuptimelimit() {
  level endon("game_ended");
  _id_808680E2DF7D0DE5 = getdvarint("dvar_16865407B6ECC362", 120);
  scripts\mp\flags::gameflagwait("prematch_done");
  setomnvar("ui_br_circle_state", 5);

  if(level.brgametype.timelimit <= 0) {
    return;
  }
  setomnvar("ui_hardpoint_timer", gettime() + int(level.brgametype.timelimit * 1000));
  _id_0098EE5131DA5693 = max(level.brgametype.timelimit - _id_808680E2DF7D0DE5, 0);
  wait(_id_0098EE5131DA5693);
  setomnvar("ui_br_circle_state", 6);
}

ontimelimit() {
  if(istrue(level.gameended)) {
    return;
  }
  handleteamplacement();
  thread _id_1E4A61DB11011446::brendgame(level.brgametype.firstteam, game["end_reason"]["objective_completed"]);
}

setupglobalkillcount() {
  if(!level.isstandardsandbox) {
    return;
  }
  if(!level.brgametype.maxkills) {
    return;
  }
  _id_B4C134E149B2E70B = 2;
  _id_D2C8C88F6FF982FA = -2;
  level.brgametype.hudglobalkillcount = createhudelem(&"MP_BR_INGAME/SANDBOX_GLOBAL_KILLS", 0, "RIGHT", "CENTER", -120 + _id_D2C8C88F6FF982FA, -170);
  level.brgametype.hudglobalkillcountmax = createhudelem(&"MP_BR_INGAME/EXTRACT_MAX", level.brgametype.maxkills, "LEFT", "CENTER", -120 + _id_B4C134E149B2E70B, -170);
}

is_player_damage_disabled(attacker, victim) {
  if(!isDefined(attacker) || !isDefined(victim))
    return 0;

  if(attacker scripts\cp_mp\vehicles\vehicle::isvehicle())
    attacker = attacker.owner;

  if(!isPlayer(attacker) || !isPlayer(victim))
    return 0;

  if(attacker == victim)
    return 0;

  if(allowassassinationdamage(victim, attacker))
    return 0;

  if(allowassassinationdamage(attacker, victim))
    return 0;

  if(allowvipdamage(victim))
    return 0;

  if(attacker.sandbox_safe_area_count || victim.sandbox_safe_area_count)
    return 1;

  if(attacker.sandbox_combat_area_bits || victim.sandbox_combat_area_bits) {
    if(!(attacker.sandbox_combat_area_bits &victim.sandbox_combat_area_bits))
      return 2;
  }

  return 0;
}

allowassassinationdamage(_id_A9FF06560DA3D11F, target) {
  _id_D95DA0355CF4CCB4 = getdvarint("dvar_AFD3A352453AA76C", 2);

  if(!_id_D95DA0355CF4CCB4)
    return 0;

  instance = _id_3ACF1C0EBAF602F2::getquestinstancedatasafe("assassination", _id_A9FF06560DA3D11F.team);

  if(!isDefined(instance))
    return 0;

  if(!isDefined(instance.targetplayer))
    return 0;

  if(_id_D95DA0355CF4CCB4 == 1)
    return instance.targetplayer == target;
  else
    return instance.targetplayer.team == target.team;
}

allowvipdamage(player) {
  _id_D95DA0355CF4CCB4 = getdvarint("dvar_C9C62340447351C5", 1);

  if(!_id_D95DA0355CF4CCB4)
    return 0;

  instance = _id_3ACF1C0EBAF602F2::getquestinstancedatasafe("vip", player.team);

  if(!isDefined(instance))
    return 0;

  if(!isDefined(instance.vip))
    return 0;

  if(_id_D95DA0355CF4CCB4 == 1)
    return instance.vip == player;
  else
    return instance.vip.team == player.team;
}

modifyplayerdamage(data) {
  if(level.brgametype.disabledamagefilter)
    return data.damage;

  result = is_player_damage_disabled(data.attacker, data.victim);

  if(result == 0)
    return data.damage;

  damagedisabledfeedback(data.attacker, result);
  return 0;
}

modifyvehicledamage(data) {
  if(level.brgametype.disabledamagefilter)
    return data.damage;

  owner = self.owner;

  if(!isDefined(owner))
    return data.damage;

  result = is_player_damage_disabled(data.attacker, owner);

  if(result == 0)
    return data.damage;

  damagedisabledfeedback(data.attacker, result);
  return 0;
}

damagedisabledfeedback(attacker, result) {
  if(attacker scripts\cp_mp\vehicles\vehicle::isvehicle())
    attacker = attacker.owner;

  if(!isDefined(attacker) || !isPlayer(attacker)) {
    return;
  }
  attacker _id_5762AC2F22202BA2::updatedamagefeedback("hitspawnprotect");

  if(result == 1)
    _id_8F3CECEFC2DE967C = &"MP_BR_INGAME/SB_CANT_DAMAGE_SAFE_AREA";
  else
    _id_8F3CECEFC2DE967C = &"MP_BR_INGAME/SB_CANT_DAMAGE_COMBAT_AREA";

  attacker sandboxprintlinebold(_id_8F3CECEFC2DE967C);
}

onplayerkilled(_id_642470E1ABC1BBF9) {
  if(!istrue(level.br_prematchstarted)) {
    return;
  }
  if(!isDefined(_id_642470E1ABC1BBF9.attacker) || !isPlayer(_id_642470E1ABC1BBF9.attacker) || !isDefined(_id_642470E1ABC1BBF9.victim) || _id_642470E1ABC1BBF9.attacker == _id_642470E1ABC1BBF9.victim) {
    return;
  }
  if(level.gameended) {
    return;
  }
  attackerteam = _id_642470E1ABC1BBF9.attacker.team;

  if(!isDefined(level.teamdata[attackerteam]["kills"]))
    level.teamdata[attackerteam]["kills"] = 0;

  level.teamdata[attackerteam]["kills"]++;

  if(istrue(level.x1ops)) {
    if(!istrue(level.br_prematchstarted)) {
      return;
    }
    if(level.gameended) {
      return;
    }
    victim = _id_642470E1ABC1BBF9.victim;
    attacker = _id_642470E1ABC1BBF9.attacker;

    if(!isDefined(attacker) || !isPlayer(attacker) || !isDefined(victim)) {
      return;
    }
    return;
  }

  level.brgametype.killcount++;

  if(level.brgametype.maxkills && istrue(level.isstandardsandbox)) {
    level.brgametype.hudglobalkillcount setvalue(level.brgametype.killcount);

    if(level.brgametype.killcount >= level.brgametype.maxkills) {
      handleteamplacement();
      thread _id_1E4A61DB11011446::brendgame(level.brgametype.firstteam, game["end_reason"]["objective_completed"]);
    }
  }
}

playerdropplunderondeath(dropstruct, attacker) {
  _id_6AEE9C9054F09ED5 = int(self.plundercount * 0.5);
  _id_B64F283113C99581 = self.plundercount - _id_6AEE9C9054F09ED5;

  if(_id_B64F283113C99581 <= 0)
    _id_B64F283113C99581 = 1;

  self.plundercountondeath = _id_6AEE9C9054F09ED5;
  _id_6AFF3948CF4CCA03::playersetplundercount(_id_6AEE9C9054F09ED5);
  _id_6AFF3948CF4CCA03::dropplunderbyrarity(_id_B64F283113C99581, dropstruct);
  return 1;
}

handleteamplacement() {
  _id_2E2DD5105CE091DC = scripts\engine\utility::array_sort_with_func(level.teamnamelist, ::comparekillcounts);
  level.brgametype.firstteam = _id_2E2DD5105CE091DC[0];
  _id_DD97C40CA89D18F7 = 1;
  _id_B60FB86E0E39450D = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2E2DD5105CE091DC.size; _id_AC0E594AC96AA3A8++) {
    team = _id_2E2DD5105CE091DC[_id_AC0E594AC96AA3A8];

    if(!isDefined(level.teamdata[team]["teamCount"]) || level.teamdata[team]["teamCount"] == 0) {
      continue;
    }
    kills = level.teamdata[team]["kills"];

    if(!isDefined(kills))
      kills = 0;

    if(_id_AC0E594AC96AA3A8 > 0 && kills != _id_B60FB86E0E39450D)
      _id_DD97C40CA89D18F7++;

    _id_E6D7DE89AE05A160 = _id_DD97C40CA89D18F7;
    _id_B60FB86E0E39450D = kills;

    foreach(player in level.teamdata[team]["players"]) {
      player setclientomnvar("ui_br_player_position", _id_E6D7DE89AE05A160);

      if(_id_E6D7DE89AE05A160 > 1) {
        player setclientomnvar("ui_br_squad_eliminated_active", 1);
        player setclientomnvar("ui_round_end_title", game["round_end"]["defeat"]);
        player setclientomnvar("ui_round_end_reason", game["end_reason"]["br_eliminated"]);
      }
    }
  }
}

comparekillcounts(left, right) {
  _id_4561DDE117631FE3 = level.teamdata[left]["kills"];
  _id_E6E1D2042A0ECD50 = level.teamdata[right]["kills"];

  if(!isDefined(_id_4561DDE117631FE3))
    return 0;
  else if(!isDefined(_id_E6E1D2042A0ECD50))
    return 1;
  else
    return _id_4561DDE117631FE3 > _id_E6E1D2042A0ECD50;
}

createhudelem(label, value, point, relativepoint, xoffset, yoffset, color, team) {
  fontscale = 1.5;

  if(isDefined(team))
    _id_372B658AEA9D2487 = newteamhudelem(team);
  else
    _id_372B658AEA9D2487 = newhudelem();

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
  _id_372B658AEA9D2487.alpha = 1;
  _id_372B658AEA9D2487.hidewheninmenu = 1;
  _id_372B658AEA9D2487 scripts\mp\hud_util::setpoint(point, relativepoint, xoffset, yoffset);

  if(isDefined(label))
    _id_372B658AEA9D2487.label = label;

  if(isDefined(value))
    _id_372B658AEA9D2487 setvalue(value);

  if(isDefined(color))
    _id_372B658AEA9D2487.color = color;

  return _id_372B658AEA9D2487;
}

sandboxprintlinebold(text, value) {
  if(isDefined(self.sandboxprintlinebold)) {
    if(self.sandboxprintlinebold.currentlabel == text) {
      currentvalue = self.sandboxprintlinebold.value;
      _id_8F617FFD000EB682 = value;

      if(!isDefined(currentvalue) && !isDefined(_id_8F617FFD000EB682)) {
        self.sandboxprintlinebold thread sandboxprintlineboldwait();
        return;
      } else if(isDefined(currentvalue) && isDefined(value)) {
        if(currentvalue == value) {
          self.sandboxprintlinebold thread sandboxprintlineboldwait();
          return;
        }
      }
    }

    self.sandboxprintlinebold destroy();
  }

  _id_94480E1669B7FF0D = scripts\mp\hud_util::createfontstring("objective", 1.8);
  _id_94480E1669B7FF0D scripts\mp\hud_util::setpoint("BOTTOM", "BOTTOM", 0, -55);
  _id_94480E1669B7FF0D.label = text;
  _id_94480E1669B7FF0D.currentlabel = text;

  if(isDefined(value)) {
    if(isPlayer(value))
      _id_94480E1669B7FF0D setplayernamestring(value);
    else if(isistring(value) || isstring(value))
      _id_94480E1669B7FF0D settext(value);
    else
      _id_94480E1669B7FF0D setvalue(value);

    _id_94480E1669B7FF0D.currentvalue = value;
  }

  self.sandboxprintlinebold = _id_94480E1669B7FF0D;
  _id_94480E1669B7FF0D thread sandboxprintlineboldwait();
}

sandboxprintlineboldwait() {
  self endon("death");
  self notify("sandboxPrintLineBoldWait");
  self endon("sandboxPrintLineBoldWait");
  self.alpha = 1;
  wait 1.5;
  self fadeovertime(0.5);
  self.alpha = 0;
  wait 0.5;
  self destroy();
}

runjoininprogresstimeout() {
  wait(level.brgametype.joininprogresstimeout);
  level.allowlatecomers = 0;
  setnojiptime(1, 1);
  setnojipscore(1, 1);
}

rundrawprematchareas() {
  while(!isDefined(level.prematchspawnorigins)) {
    waitframe();
    continue;
  }

  _id_513A37DBB29A8EAD = [];

  foreach(area in level.prematchspawnorigins) {
    [minradius, radius] = _id_1E4A61DB11011446::getprematchradius(area);
    circleent = spawnStruct();
    circleent scripts\cp_mp\utility\game_utility::_id_6B6B6273F8180522("Sandbox_Br", area.origin, radius);
    _id_513A37DBB29A8EAD[_id_513A37DBB29A8EAD.size] = circleent;
  }
}

getinfilplayers() {
  return [];
}

runautocircle(_id_74B5B12BB6514385) {
  level endon("game_ended");
  level endon("restartCircleElimination");
  wait(_id_74B5B12BB6514385);
  thread _id_4384ABBF498DF6A7::restartcircleelimination();
}

playerhandlesandboxmenu() {
  level endon("game_ended");
  self endon("disconnect");
  self.hudsbredeploy = createhudstring(0, &"MP_BR_INGAME/SANDBOX_REDEPLOY");

  for(;;) {
    playerwaitilllongholdmelee();

    if(istrue(self.inlaststand)) {
      continue;
    }
    if(istrue(level.brgametype.circlerunning)) {
      return;
    }
    self setclientomnvar("ui_show_tac_map", 1);
    self.hudsbredeploy.alpha = 0;
    scripts\cp_mp\utility\player_utility::_freezecontrols(1);
    self beginlocationselection(0, 0, 0, 0, 4);
    thread playerlocationselectinterrupt();
    _id_6E586A99FA56A20F = scripts\mp\killstreaks\mapselect::waittill_confirm_or_cancel("confirm_location", "cancel_location");
    self endlocationselection();

    if(isDefined(_id_6E586A99FA56A20F) && _id_6E586A99FA56A20F.string == "confirm_location") {
      if(_id_2695A20D4011076D::isvalidpointinbounds(_id_6E586A99FA56A20F.location)) {
        _id_9083EA775F3B0CD7 = _id_1E4A61DB11011446::traceselectedmaplocation(_id_6E586A99FA56A20F.location);
        _id_01230EA36A300368 = _id_9083EA775F3B0CD7["position"];

        if(_id_2695A20D4011076D::isvalidpointinbounds(_id_01230EA36A300368)) {
          _id_01230EA36A300368 = pushpointoutofkothattractions(self, _id_01230EA36A300368);
          playerredeploy(_id_01230EA36A300368);
        }
      }
    }

    scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1);
    self setclientomnvar("ui_show_tac_map", 0);

    if(istrue(level.brgametype.circlerunning)) {
      return;
    }
    self.hudsbredeploy.alpha = 1;
  }
}

playerwaitilllongholdmelee() {
  level endon("closeSandboxMenu");
  _id_C01F079EB027D3BC = 500;

  for(;;) {
    while(!self meleeButtonPressed())
      waitframe();

    start = gettime();
    endtime = gettime() + _id_C01F079EB027D3BC;

    while(self meleeButtonPressed() && gettime() < endtime)
      waitframe();

    if(gettime() >= endtime && !self isinexecutionattack())
      return;
  }
}

createhudstring(index, text) {
  _id_94480E1669B7FF0D = scripts\mp\hud_util::createfontstring("default", 1.5);
  _id_94480E1669B7FF0D hudelementsetupandposition(index);

  if(isDefined(text))
    _id_94480E1669B7FF0D settext(text);

  return _id_94480E1669B7FF0D;
}

hudelementsetupandposition(index) {
  _id_FC60CBA78AC17A0C = 200;
  _id_9348226A53701BDB = -75;
  _id_6012BDCA89FF91E9 = 20;
  self.x = _id_FC60CBA78AC17A0C;
  self.y = _id_9348226A53701BDB + index * _id_6012BDCA89FF91E9;
  self.alignx = "left";
  self.aligny = "bottom";
  self.horzalign = "left_adjustable";
  self.vertalign = "bottom_adjustable";
  self.alpha = 1;
  self.glowalpha = 0;
  self.hidewheninmenu = 1;
  self.archived = 0;
}

playerlocationselectinterrupt() {
  player = self;
  level endon("game_ended");
  self endon("disconnect");
  player endon("confirm_location");
  scripts\engine\utility::waittill_any_ents(player, "death", level, "game_ended", level, "closeSandboxMenu", self, "last_stand_start");
  player notify("cancel_location");
}

playerredeploy(groundorigin) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  _id_4630A5DF954561F2 = 12000;
  _id_82C56D440DD1AFE3 = 5000;
  _id_7EDEA18C5297058D = 500;
  height = _id_4630A5DF954561F2;

  if(isDefined(player.vehicle) && player.vehicle.vehiclename == "jeep")
    height = _id_7EDEA18C5297058D;
  else if(isDefined(player.vehicle))
    height = _id_82C56D440DD1AFE3;

  _id_84E2123AACA9A965 = player;
  spawnpoint = spawnStruct();
  spawnpoint.origin = groundorigin + (0, 0, height);
  spawnpoint.angles = (0, 0, 0);
  spawnpoint.height = height;
  _id_11F3B4465C8B637B = player _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
  player.forcespawnorigin = _id_11F3B4465C8B637B;
  _id_B59F471C2C064E56 = 1.0;
  player _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
  wait(_id_B59F471C2C064E56);
  spawnorigin = spawnpoint.origin;
  spawnangles = spawnpoint.angles;
  startorigin = spawnorigin;

  if(isDefined(_id_11F3B4465C8B637B))
    startorigin = _id_11F3B4465C8B637B;

  player _id_5BAB271917698DC4::_id_961B4AFC4C695B94();
  player _id_5BAB271917698DC4::_id_AB31CF673D70F72D(startorigin, spawnangles);
  linker = spawn("script_model", startorigin);
  linker setModel("tag_origin");
  linker.angles = spawnangles;
  linker hide();
  linker showtoplayer(player);

  if(isDefined(player.vehicle)) {
    player.vehicle thread vehiclelinkTo(linker, "tag_origin");
    player.vehicle hide(1);
  } else
    player playerlinktoabsolute(linker, "tag_origin");

  player scripts\cp_mp\utility\player_utility::_id_A593971D75D82113();
  player scripts\cp_mp\utility\player_utility::_id_379BB555405C16BB("br_gametype_sandbox::playerRedeploy()");
  player thread _id_5BAB271917698DC4::playercleanupentondisconnect(linker);
  waitframe();
  player _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
  player _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();

  if(isDefined(_id_11F3B4465C8B637B))
    linker.origin = spawnorigin;

  linker playsoundtoplayer("br_ac130_flyby", player);
  wait 1.5;

  if(isDefined(player.vehicle)) {
    player.vehicle thread vehicleunlink();
    player.vehicle show();
  } else
    player unlink();

  player clearsoundsubmix("deaths_door_mp");
  player clearclienttriggeraudiozone(1);
  player scripts\cp_mp\utility\player_utility::_id_6FB380927695EE76();
  player scripts\cp_mp\utility\player_utility::_id_985B0973F29DA4F8("br_gametype_sandbox::playerRedeploy()");

  if(!isDefined(player.vehicle)) {
    _id_BDA1DE83E1856735 = 0;

    if(isDefined(level.parachutedeploydelay))
      _id_BDA1DE83E1856735 = level.parachutedeploydelay;

    player thread scripts\cp_mp\parachute::startfreefall(_id_BDA1DE83E1856735, 0, undefined, undefined, 1);
  }

  player setclientomnvar("ui_br_transition_type", 0);
  player setclientomnvar("ui_show_spectateHud", -1);
  player _id_5BAB271917698DC4::resetplayermovespeedscale();
  wait 0.5;
  player _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
  waitframe();
  linker delete();
}

vehiclelinkTo(ent, tag) {
  self endon("death");
  self endon("vehicleUnlink");

  for(;;) {
    origin = ent gettagorigin(tag);
    angles = ent gettagangles(tag);
    self vehicle_teleport(origin, angles);
    waitframe();
  }
}

vehicleunlink() {
  self notify("vehicleUnlink");
}

pushpointoutofkothattractions(player, origin) {
  _id_6532DA84552F67BE = 300;

  if(!_id_6731BE38C3B94FF7::iskingofthehillactive() || !isDefined(player.vehicle))
    return origin;

  locations = _id_47611598F3AD2E29::getkothlocations();

  foreach(location in locations) {
    radius = location.capturetrigger.radius + _id_6532DA84552F67BE;
    radiussq = radius * radius;
    distsq = distance2dsquared(origin, location.capturetrigger.origin);

    if(distsq < radiussq) {
      _id_CC168975165B8F05 = (origin[0], origin[1], 0);
      _id_483CE08ECD97C05F = (location.capturetrigger.origin[0], location.capturetrigger.origin[1], 0);
      _id_2D4F06FFC3217FD0 = vectorNormalize(_id_CC168975165B8F05 - _id_483CE08ECD97C05F);
      _id_6B40B4C28ABE0A05 = distance2d(origin, location.capturetrigger.origin);
      _id_C6510E7A22B1EBB5 = radius - _id_6B40B4C28ABE0A05;
      origin = origin + _id_2D4F06FFC3217FD0 * _id_C6510E7A22B1EBB5;
      break;
    }
  }

  return origin;
}

getnextcombatareaid() {
  id = level.brgametype.nextcombatareaid;
  level.brgametype.nextcombatareaid++;
  return id;
}

playerentercombatarea(id) {
  if(self.sandbox_combat_area_bits == 0)
    thread playerentercombatareamessage();

  self.sandbox_combat_area_bits = self.sandbox_combat_area_bits | 1 << id;
}

playerentercombatareamessage() {
  self endon("death_or_disconnect");
  self notify("playerEnterCombatAreaMessage");
  self endon("playerEnterCombatAreaMessage");
  waittillframeend;

  if(self.sandbox_combat_area_bits)
    sandboxprintlinebold(&"MP_BR_INGAME/SB_ENTER_COMBAT_AREA");
}

playerexitcombatarea(id) {
  self.sandbox_combat_area_bits = self.sandbox_combat_area_bits &~(1 << id);

  if(self.sandbox_combat_area_bits == 0)
    thread playerexitcombatareamessage();
}

playerexitcombatareamessage() {
  self endon("death_or_disconnect");
  self notify("playerExitCombatAreaMessage");
  self endon("playerExitCombatAreaMessage");
  waittillframeend;

  if(self.sandbox_combat_area_bits == 0)
    sandboxprintlinebold(&"MP_BR_INGAME/SB_EXIT_COMBAT_AREA");
}

playerentersafearea() {
  if(self.sandbox_safe_area_count == 0)
    thread playerentersafeareamessage();

  self.sandbox_safe_area_count++;
}

playerentersafeareamessage() {
  self endon("death_or_disconnect");
  self notify("playerEnterSafeAreaMessage");
  self endon("playerEnterSafeAreaMessage");
  waittillframeend;

  if(self.sandbox_safe_area_count)
    sandboxprintlinebold(&"MP_BR_INGAME/SB_ENTER_SAFE_AREA");
}

playerexitsafearea() {
  self.sandbox_safe_area_count--;

  if(self.sandbox_safe_area_count < 0)
    self.sandbox_safe_area_count = 0;
  else if(self.sandbox_safe_area_count == 0)
    thread playerexitsafeareamessage();
}

playerexitsafeareamessage() {
  self endon("death_or_disconnect");
  self notify("playerExitSafeAreaMessage");
  self endon("playerExitSafeAreaMessage");
  waittillframeend;

  if(!self.sandbox_safe_area_count)
    sandboxprintlinebold(&"MP_BR_INGAME/SB_EXIT_SAFE_AREA");
}

restartcircleelimination(origin, _id_8F6402AD8E91DA6A) {
  level endon("game_ended");
  level.ontimelimit = _id_1E4A61DB11011446::ontimelimit;
  gametype = _func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_timelimit");
  level.watchdvars[gametype].value = 0;
  level.overridewatchdvars[gametype] = 0;
  wait(_id_8F6402AD8E91DA6A);
  level.prewaitandspawnclient = _id_1E4A61DB11011446::brprewaitandspawnclient;
  level.modemayconsiderplayerdead = _id_1E4A61DB11011446::brmayconsiderplayerdead;
  level.modeonspawnplayer = _id_1E4A61DB11011446::onspawnplayer;
  level.brgametype.circlerunning = 1;
  level notify("closeSandboxMenu");

  foreach(player in level.players) {
    if(isDefined(player.hudsbredeploy))
      player.hudsbredeploy destroy();
  }

  level.brgametype.funcs["spawnHandled"] = undefined;
  level.brgametype.funcs["playerKilledSpawn"] = undefined;
}

x1timedivision() {
  level endon("game_ended");
  _id_3FD1DF8A10225AD8 = getdvarint("dvar_DA6182A9C03D9871", 117);
  _id_E2DE4CFA5366CBFF = getdvarint("dvar_A412E6CDAA04F71E", 180);
  _id_0CBED3301DD5953E = getdvarint("dvar_663B997F05C4745F", 185);
  _id_D109E3BEB159239D = getdvarint("dvar_ECC9CA7DAF58EF04", 180);
  _id_786D44FC90D4AA24 = getdvarint("dvar_77B0DFF7CCF3C17D", 243);
  _id_C74A250153BAD6AB = getdvarint("dvar_785EDACE8CCB194A", 106);
  _id_093A2D59FFF85EAD = getdvarint("dvar_E4D3CDC79C7BC4EB", 18);
  _id_72878E3F377378EA = getdvarint("dvar_59FB5A219585EE0B", 141);
  _id_B18D3429CF88F29F = getdvarint("dvar_FBC680E67BC2C565", 10);

  if(!istrue(level.br_infils_disabled))
    level waittill("br_c130_left_bounds");
  else
    scripts\mp\flags::gameflagwait("br_ready_to_jump");

  thread x1ops1(_id_3FD1DF8A10225AD8);
  x1timehandler(_id_3FD1DF8A10225AD8, _id_B18D3429CF88F29F);
  level.x1ops = 2;
  x1opstransition(_id_E2DE4CFA5366CBFF);
  x1ops2();
  x1timehandler(_id_E2DE4CFA5366CBFF, _id_B18D3429CF88F29F);
  level.x1ops = 3;
  x1opstransition(_id_0CBED3301DD5953E);
  x1ops3();
  x1timehandler(_id_0CBED3301DD5953E, _id_B18D3429CF88F29F);
  level.x1ops = 4;
  x1opstransition(_id_D109E3BEB159239D);
  x1ops4();
  x1timehandler(_id_D109E3BEB159239D, _id_B18D3429CF88F29F);
  level.x1ops = 5;
  x1opstransition(_id_786D44FC90D4AA24);
  x1ops5();
  x1timehandler(_id_786D44FC90D4AA24, _id_B18D3429CF88F29F);
  level.x1ops = 6;
  x1ops6(_id_C74A250153BAD6AB);
  x1opstransition(_id_C74A250153BAD6AB);
  wait 22;
  x1opsbink();
  wait(_id_C74A250153BAD6AB - 4);
  level.x1ops = 7;
  x1ops7();
  wait(_id_72878E3F377378EA);
  setmusicstate("event01_track05");
  x1opsendgame();
}

x1unittimedivision() {
  level endon("game_ended");
  _id_3FD1DF8A10225AD8 = getdvarint("dvar_DA6182A9C03D9871", 117);
  _id_E2DE4CFA5366CBFF = getdvarint("dvar_A412E6CDAA04F71E", 180);
  _id_0CBED3301DD5953E = getdvarint("dvar_663B997F05C4745F", 185);
  _id_D109E3BEB159239D = getdvarint("dvar_ECC9CA7DAF58EF04", 180);
  _id_786D44FC90D4AA24 = getdvarint("dvar_77B0DFF7CCF3C17D", 243);
  _id_C74A250153BAD6AB = getdvarint("dvar_785EDACE8CCB194A", 106);
  _id_093A2D59FFF85EAD = getdvarint("dvar_E4D3CDC79C7BC4EB", 18);
  _id_72878E3F377378EA = getdvarint("dvar_59FB5A219585EE0B", 141);
  _id_B18D3429CF88F29F = getdvarint("dvar_FBC680E67BC2C565", 10);
  _id_3ACF1C0EBAF602F2::disablealltablets();

  if(!istrue(level.br_infils_disabled))
    level waittill("br_c130_in_bounds");
  else {
    scripts\mp\flags::gameflagwait("br_ready_to_jump");
    x1opsinfilsequenceendinternal(level.players);
  }

  thread x1givelaststandoverride();

  if(!istrue(level.br_infils_disabled))
    level waittill("br_c130_left_bounds");
  else
    wait 1;

  thread x1ops1(_id_3FD1DF8A10225AD8);
  x1timehandler(_id_3FD1DF8A10225AD8, 0);
  level.x1ops = 2;
  x1ops2();
  x1timehandler(_id_E2DE4CFA5366CBFF, 0);
  level.x1ops = 3;
  x1ops3();
  x1timehandler(_id_0CBED3301DD5953E, 0);
  level.x1ops = 4;
  x1ops4();
  x1timehandler(_id_D109E3BEB159239D, 0);
  level.x1ops = 5;
  thread x1ops5(_id_786D44FC90D4AA24);
  x1timehandler(_id_786D44FC90D4AA24, 0);
  level.x1ops = 6;

  foreach(player in level.players) {
    setmusicstate("");
    player setsoundsubmix("fade_to_black_all_except_music", 1);
    player clearsoundsubmix("mp_br_event01_slow_fadeout", 4);
    player setclientomnvar("ui_br_transition_type", 1);
    player scripts\cp_mp\utility\player_utility::_freezecontrols(1);
  }

  x1ops6(_id_C74A250153BAD6AB);
  x1opstransition(_id_C74A250153BAD6AB);
  wait 0.5;
  setomnvar("scriptable_loot_hide", 1);

  foreach(player in level.players)
  player scripts\cp_mp\utility\player_utility::_freezecontrols(1);

  teamlist = getarraykeys(level.teamdata);

  foreach(team in teamlist) {
    setteamradar(team, 0);
    setteamradarstrength(team, 0);
  }

  x1opsbink();
  level thread _id_1E4A61DB11011446::updateplayerandteamcountui();
  wait(_id_093A2D59FFF85EAD);
  gunless = makeweapon("iw9_me_fists_mp");

  foreach(player in level.players) {
    player clearsoundsubmix("fade_to_black_all_except_music", 1);
    player unlink();
    player.airholder forcenetfieldhighlod(0);
    player.airholder delete();
    player skydive_deployparachute();
    player setclientomnvar("ui_br_bink_overlay_state", 6);
    player scripts\cp_mp\utility\player_utility::_freezecontrols(0, 1);
  }

  setglobalsoundcontext("gamemode", "reveal");
  circlecenter = _id_21C3E8D48552A4FA();
  _id_79F36C0E74C9FEBB = (circlecenter[0], circlecenter[1], circlecenter[2] + 5000);
  _id_61D3AB7D72BEF359 = scripts\engine\utility::play_loopsound_in_space("iw8_nuke_alarm_lp", _id_79F36C0E74C9FEBB);
  thread x1airstrikemanager(level.x1ops);
  wait(_id_C74A250153BAD6AB - 4 - 10);

  foreach(player in level.players)
  player setsoundsubmix("solo_cin_igc_music", 6);

  wait 10;
  _id_61D3AB7D72BEF359 scripts\engine\utility::stop_loop_sound_on_entity("iw8_nuke_alarm_lp");
  _id_61D3AB7D72BEF359 delete();
  level.x1ops = 7;
  x1ops7();
  wait(_id_72878E3F377378EA);

  foreach(player in level.players) {
    player clearsoundsubmix("solo_cin_igc_music", 3);
    player._id_5D4C8322D01B9C50 = undefined;
  }

  setmusicstate("event01_track05");
  x1opsendgame();
}

_id_21C3E8D48552A4FA() {
  _id_8BA51064F8A54F29 = (28715, 2275, -990);

  if(level.script == "mp_br_mechanics")
    _id_8BA51064F8A54F29 = (-20728, -2000, 58);

  circlecenter = getdvarvector("br_final_circle_override", _id_8BA51064F8A54F29);
  return circlecenter;
}

x1givelaststandoverride() {
  level endon("game_ended");

  foreach(player in level.players)
  _id_1E4A61DB11011446::givelaststandifneeded(player);
}

x1timehandler(time, _id_B18D3429CF88F29F) {
  wait(time - _id_B18D3429CF88F29F);

  if(getdvarint("dvar_9D868E9083FD9424", 0) && level.isx1ops != 6) {
    return;
  }
  foreach(player in level.players)
  player setclientomnvar("ui_match_in_progress", 0);

  level scripts\mp\gamelogic::livelobbymatchstarttimer("match_starting_in", _id_B18D3429CF88F29F);

  foreach(player in level.players) {
    player setclientomnvar("ui_match_start_countdown", 0);
    player setclientomnvar("ui_match_in_progress", 1);
    player.plotarmor = 0;
  }
}

x1opstransition(time) {
  level.x1playertransition = 1;
  level notify("x1OpsTransition");
  level.brgametype.timelimit = time;
  x1spawnlocationoverride();

  foreach(player in level.players)
  player thread x1opsplayertransition();

  level.allowsupers = 0;
  wait 0.2;
  thread _id_46AF76764B1FC7F0::emptyallvehicles();
  wait 3.0;
  level.x1playertransition = undefined;
  thread _id_46AF76764B1FC7F0::deleteextantvehicles();
}

x1opsplayertransition() {
  player = self;
  player _id_F559B8AB160618CA();
  player setclientomnvar("ui_br_transition_type", 1);
  player.x1playertransition = 1;

  while(!isalive(player))
    waitframe();

  player.plotarmor = 0;
  wait 0.2;
  waittillframeend;

  while(!isalive(player))
    waitframe();

  player.airholder = spawn("script_model", player.brradialspawnorigin);
  player.airholder setModel("tag_origin");
  player.airholder forcenetfieldhighlod(1);
  self.respawningbr = 1;
  spawnorigin = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(self.brradialspawnorigin);
  heightoffset = getdvarint("dvar_A17EDC27C246B722", 2000);
  spawnorigin = spawnorigin + (0, 0, heightoffset);
  self.forcespawnorigin = spawnorigin;
  origin = _id_2695A20D4011076D::getdangercircleorigin();
  dir = origin - player.brradialspawnorigin;
  spawnangles = vectortoangles(dir);
  self.forcespawnangles = spawnangles;
  _id_2CEDCC356F1B9FC8::_id_2DCD6A9EB79260A6();
  self.plotarmor = 1;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  self.plotarmor = undefined;
  self.respawningbr = undefined;
  player playerlinkTo(player.airholder);
  player playerlinkedoffsetenable();
  wait 0.2;

  if(!getdvarint("dvar_9D868E9083FD9424", 0))
    player setclientomnvar("ui_br_transition_type", 0);

  player.x1playertransition = undefined;
}

x1infilarmorwatch() {
  if(!istrue(level.isx1ops)) {
    return;
  }
  level endon("game_ended");
  self endon("disconnect");
  _id_07C40FA80892A721::givestartingarmor();
  level waittill("infils_ready");
  _id_07C40FA80892A721::givestartingarmor();
}

x1spawnlocationoverride() {
  if(scripts\mp\flags::gameflag("prematch_done")) {
    switch (level.x1ops) {
      case 2:
        level.br_prematchspawnlocations = [];
        level.prematchspawnoriginsforteams = undefined;
        level.br_prematchspawnlocations = [_id_1E4A61DB11011446::createspawnlocation((50200, 3500, 86), 0, 5500), _id_1E4A61DB11011446::createspawnlocation((23000, -15000, -158), 0, 6000), _id_1E4A61DB11011446::createspawnlocation((-12600, -14000, -249), 0, 5500)];
        level.prematchspawnorigins = _id_1E4A61DB11011446::getprematchlocationspawnorigins();
        break;
      case 3:
        level.br_prematchspawnlocations = [];
        level.prematchspawnoriginsforteams = undefined;
        level.br_prematchspawnlocations = [_id_1E4A61DB11011446::createspawnlocation((15000, 14200, 212), 500, 5500)];
        level.prematchspawnorigins = _id_1E4A61DB11011446::getprematchlocationspawnorigins();
        break;
      case 4:
        level.br_prematchspawnlocations = [];
        level.prematchspawnoriginsforteams = undefined;
        level.br_prematchspawnlocations = [_id_1E4A61DB11011446::createspawnlocation((51000, -39000, 1401), 0, 4000)];
        level.prematchspawnorigins = _id_1E4A61DB11011446::getprematchlocationspawnorigins();
        break;
      case 5:
        level.br_prematchspawnlocations = [];
        level.prematchspawnoriginsforteams = undefined;
        level.br_prematchspawnlocations = [_id_1E4A61DB11011446::createspawnlocation((8375, -11000, -222), 0, 5500)];
        level.prematchspawnorigins = _id_1E4A61DB11011446::getprematchlocationspawnorigins();
        break;
      case 6:
        level.br_prematchspawnlocations = [];
        level.prematchspawnoriginsforteams = undefined;
    }
  }
}

x1opsrespawnselection() {
  if(scripts\mp\flags::gameflag("prematch_done")) {
    switch (level.x1ops) {
      case 6:
      case 5:
      case 4:
      case 3:
      case 2:
        thread x1playerspawnoverride(1);
        break;
      default:
        thread playerspawn(1);
    }
  } else
    thread playerspawn(1);
}

x1opsunitrespawnselection() {
  if(scripts\mp\flags::gameflag("prematch_done")) {
    switch (level.x1ops) {
      case 6:
        thread x1playerspawnoverride(1);
        break;
      default:
        thread playerspawn(1);
    }
  } else
    thread playerspawn(1);
}

x1loadout(index) {
  player = self;

  if(!isDefined(index) || index < 0 || index > level.prematchloadouts.size - 1)
    index = randomint(level.prematchloadouts.size);

  if(isDefined(player.smokinggunclassindex))
    index = player.smokinggunclassindex;

  player.pers["gamemodeLoadout"] = level.prematchloadouts[index];
  player.class = "gamemode";

  if(isDefined(player.smokinggunclassindex))
    player scripts\mp\class::giveloadout(player.team, player.class, undefined, 0, 0);

  player _id_7E52B56769FA7774::resetsuper();
  player _id_7E52B56769FA7774::forcegivesuper("super_ammo_drop", 0);
}

x1playerspawnoverride(respawn) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(!istrue(level.skipprematchdropspawn)) {
    if(istrue(self.x1playertransition) && level.x1ops == 6) {
      self.prespawnspawn = spawnStruct();
      self.prespawnspawn.origin = undefined;
      self.prespawnspawn.height = undefined;
      self.prespawnspawn.index = -1;
      _id_F6AC3C609E85CB74 = getdvarfloat("scr_br_respawnmaxteammateoffset", 1000);
      spawnorigin = scripts\engine\utility::player_drop_to_ground(self.brradialspawnorigin, 32, undefined, undefined, (0, 0, 1));
      heightoffset = getdvarint("dvar_A17EDC27C246B722", 2000);
      _id_A6427A6A24F058DC = (0, 0, heightoffset + spawnorigin[2]);
      self.prespawnspawn.origin = _id_1E4A61DB11011446::getoffsetspawnorigin(spawnorigin, _id_A6427A6A24F058DC);
      self.prespawnspawn.height = self.prespawnspawn.origin[2];
      self.forcespawnorigin = self.prespawnspawn.origin;
      origin = _id_2695A20D4011076D::getdangercircleorigin();
      dir = origin - self.brradialspawnorigin;
      spawnangles = vectortoangles(dir);
      self.prespawnspawn.angles = spawnangles;
      self.forcespawnangles = spawnangles;
    } else if(istrue(self.x1playertransition) || !respawn) {
      self.prespawnspawn = _id_1E4A61DB11011446::getspawnpoint(1);
      height = scripts\cp_mp\parachute::getc130height();
      spawnorigin = scripts\engine\utility::drop_to_ground(self.prespawnspawn.origin, height, -20000);
      _id_A6427A6A24F058DC = (0, 0, height);
      self.prespawnspawn.origin = _id_1E4A61DB11011446::getoffsetspawnorigin(spawnorigin, _id_A6427A6A24F058DC);
    } else {
      height = _id_0930A1E7BD882C1D::getinfilspawnoffset();
      self.prespawnspawn = _id_5BAB271917698DC4::_id_952548D8AED47102(0, undefined, height);
      self.prespawnspawn.index = -1;
    }
  }

  scripts\mp\playerlogic::waitandspawnclient(1);
  scripts\cp_mp\utility\player_utility::_freezecontrols(1);

  if(!isalive(self))
    waitframe();

  waitframe();

  if(!istrue(game["inLiveLobby"]))
    _id_1E4A61DB11011446::givelaststandifneeded(self);

  _id_07C40FA80892A721::givestartingarmor();

  if(!istrue(self.br_infilstarted)) {
    startammo = getdvarint("dvar_D43BAE2741E07C5F", -1);

    if(startammo == -2) {
      foreach(objweapon in [self.primaryweapon, self.secondaryweapon]) {
        if(isDefined(objweapon)) {
          clipsize = weaponclipsize(objweapon);
          self setweaponammoclip(objweapon, clipsize);
          self givemaxammo(objweapon);
        }
      }

      _id_724736FCF0FB6604::br_ammo_update_weapons(self);
    } else if(startammo == -1)
      _id_724736FCF0FB6604::br_ammo_player_max_out();
    else if(startammo > 0) {
      foreach(weaponname in [self.primaryweapon, self.secondaryweapon]) {
        if(isDefined(weaponname)) {
          clipsize = weaponclipsize(weaponname);
          self setweaponammoclip(weaponname, clipsize);
          objweapon = makeweaponfromstring(weaponname);
          ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(objweapon);
          _id_724736FCF0FB6604::br_ammo_give_type(self, ammotype, clipsize * startammo);
        }
      }

      _id_724736FCF0FB6604::br_ammo_update_weapons(self);
    }
  } else
    _id_724736FCF0FB6604::br_ammo_player_max_out();

  thread _id_1E4A61DB11011446::br_displayperkinfo();
  self skydive_setdeploymentstatus(1);
  self skydive_setbasejumpingstatus(1);
  _id_4DE859B9228E5CFD = !self isplayerheadless();
  _id_C30AC8F00CB1CC8A = gettime();

  if(_id_4DE859B9228E5CFD) {
    while(isalive(self) && isDefined(self.weaponlist) && !self hasloadedviewweapons(self.weaponlist)) {
      if(_id_C30AC8F00CB1CC8A + 3000 < gettime()) {
        break;
      }

      waitframe();
    }
  }

  self notify("brWaitAndSpawnClientComplete");
  self.waitingtospawn = 0;

  if(respawn)
    _id_0A34750D17473C49::unmarkplayeraseliminated(self);
}

x1spyplane(_id_287C4487D96DF2C4) {
  if(!getdvarint("dvar_4B4884BCBD43A277", 1)) {
    return;
  }
  _id_4F105563CA74CF73 = undefined;

  switch (level.x1ops) {
    case 1:
      _id_4F105563CA74CF73 = "mp_x1trans1";
    case 2:
      _id_4F105563CA74CF73 = "mp_x1trans2";
    case 3:
      _id_4F105563CA74CF73 = "mp_x1trans3";
    case 4:
      _id_4F105563CA74CF73 = "mp_x1trans4";
    case 5:
      _id_4F105563CA74CF73 = "mp_x1trans5";
  }

  thread _id_72EB7558D3496DE0::brevent1(_id_4F105563CA74CF73);

  if(istrue(_id_287C4487D96DF2C4))
    level waittill("spyplane_done");
}

x1opstransbink(_id_287C4487D96DF2C4) {
  if(!getdvarint("x1opstransbink", 1)) {
    return;
  }
  _id_4F105563CA74CF73 = undefined;

  switch (level.x1ops) {
    case 1:
      _id_4F105563CA74CF73 = "mp_x1trans1";
      break;
    case 2:
      _id_4F105563CA74CF73 = "mp_x1trans2";
      break;
    case 3:
      _id_4F105563CA74CF73 = "mp_x1trans3";
      break;
    case 4:
      _id_4F105563CA74CF73 = "mp_x1trans4";
      break;
    case 5:
      _id_4F105563CA74CF73 = "mp_x1trans5";
      break;
  }

  foreach(player in level.players)
  player thread scramblebink(_id_4F105563CA74CF73, 5);

  waitframe();
  playcinematicforall(_id_4F105563CA74CF73, 1, 1);
}

scramblebink(_id_4F105563CA74CF73, waittime) {
  player = self;
  player endon("disconnect");
  player playlocalsound("br_event1_scramble_sfx");
  player setclientomnvar("ui_br_bink_overlay_state", 4);
  player setclientomnvar("ui_scrambler_strength", 5);
  wait(waittime);
  player stoplocalsound("br_event1_scramble_sfx");
  player setclientomnvar("ui_br_bink_overlay_state", 0);
  player setclientomnvar("ui_scrambler_strength", 0);
}

x1ops1(_id_3FD1DF8A10225AD8) {
  thread x1circletime();

  if(_id_3FD1DF8A10225AD8 >= 20)
    wait 20;

  x1opstransbink();
  setmusicstate("");
  setmusicstate("event01_track06");
}

x1ops2() {
  level.x1ops = 2;
  x1opstransbink();
  setmusicstate("event01_track02");
  thread setupx1timelimit();
}

x1ops3() {
  level.x1ops = 3;
  x1opstransbink();
  setmusicstate("event01_track03");
  thread setupx1timelimit();
}

x1ops4() {
  level.x1ops = 4;
  x1opstransbink();
  setmusicstate("event01_track04");
  thread setupx1timelimit();
}

x1ops5(_id_786D44FC90D4AA24) {
  level.x1ops = 5;
  x1opstransbink();
  setmusicstate("event01_track05");
  thread setupx1timelimit();

  if(_id_786D44FC90D4AA24 >= 18)
    wait(_id_786D44FC90D4AA24 - 18);

  _id_2CEDCC356F1B9FC8::brleaderdialog("zeus_reveal_x1ops5_ascension");
  wait 3;

  foreach(player in level.players)
  player setsoundsubmix("mp_br_event01_slow_fadeout", 10);

  wait 10;

  foreach(player in level.players)
  player.plotarmor = 1;
}

x1ops6(_id_C74A250153BAD6AB) {
  foreach(player in level.players)
  player setclientomnvar("ui_br_transition_type", 1);

  wait 1.0;
  _id_A1F74C7A34770749 = getdvarint("dvar_4DC092512B559301", 43000);
  _id_9258CB0A424E19D6 = getdvarint("dvar_8CCFC4D4FB53A5BE", 15000);
  level.x1ops = 6;
  level notify("x1Ops6Start");
  level.brgametype.disabledfeatures["circle"] = 0;
  _id_362C58E8BB39BCDA::enablefeature("circle");
  level.br_level.circle_defaults = undefined;
  level.br_level.br_circleclosetimes = [_id_C74A250153BAD6AB];
  _id_74B5B12BB6514385 = 15;

  if(getdvarint("dvar_9D868E9083FD9424", 0))
    _id_74B5B12BB6514385 = 22;

  level.br_level.br_circledelaytimes = [_id_74B5B12BB6514385];
  level.br_level.br_circleshowdelaydanger = [0];
  level.br_level.br_circleshowdelaysafe = [0];
  level.br_level.br_circleminimapradii = [10500];
  level.br_level.br_circleradii = [_id_A1F74C7A34770749, 0];
  circlecenter = _id_21C3E8D48552A4FA();
  _id_2695A20D4011076D::initcircle();
  _id_2695A20D4011076D::applycirclesettings();
  level thread _id_2695A20D4011076D::_precalcsafecirclecenters();
  level thread _id_2695A20D4011076D::runcircles(0);

  while(!isDefined(level.br_circle))
    waitframe();

  _id_F92F5E52F78CE181 = _id_A1F74C7A34770749 - _id_9258CB0A424E19D6;
  brcircleradialedgespawn(level.players, 0, _id_F92F5E52F78CE181);
  thread setupx1timelimit();
  thread x1opsenableelimination(level.br_level.br_circledelaytimes[0]);
  _id_03D9F98F82018559 = getdvarvector("br_final_circle_override", circlecenter);
  _id_91D9E1E8C558E3EA = spawn("script_model", _id_03D9F98F82018559);
  _id_91D9E1E8C558E3EA setModel("risk_dom_plate");
  _id_91D9E1E8C558E3EA setscriptablepartstate("risk_dom_beacon", "on", 0);

  foreach(_id_12461E617D024EF9 in level.questinfo.quests) {
    foreach(instance in _id_12461E617D024EF9.instances)
    instance.forcefail = 1;
  }

  level thread setchecklistsubversion();
}

brcircleradialedgespawn(participants, _id_50139A2E049FEF67, _id_D4CE4E0F8DD17C0C) {
  _id_0A9552E9348D0FEE = 360 / participants.size;
  _id_9258CB0A424E19D6 = getdvarint("dvar_8CCFC4D4FB53A5BE", 15000);
  origin = _id_2695A20D4011076D::getdangercircleorigin();
  radius = 0;

  if(isDefined(_id_D4CE4E0F8DD17C0C))
    radius = _id_D4CE4E0F8DD17C0C;
  else
    radius = _id_2695A20D4011076D::getdangercircleradius() - _id_9258CB0A424E19D6;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < participants.size; _id_AC0E594AC96AA3A8++) {
    _id_81954D580B24281B = radius * cos(_id_0A9552E9348D0FEE * _id_AC0E594AC96AA3A8);
    _id_E4F34F3A01C6FFF2 = radius * sin(_id_0A9552E9348D0FEE * _id_AC0E594AC96AA3A8);
    x = origin[0] + _id_81954D580B24281B;
    y = origin[1] + _id_E4F34F3A01C6FFF2;
    z = 0;
    _id_EF0DADE73FC874D7 = (x, y, z);

    if(_id_50139A2E049FEF67) {
      foreach(player in participants)
      player.brradialspawnorigin = _id_EF0DADE73FC874D7;

      continue;
    }

    participants[_id_AC0E594AC96AA3A8].brradialspawnorigin = _id_EF0DADE73FC874D7;
  }
}

setchecklistsubversion() {
  level waittill("br_circle_closing");
  wait 5;
  setomnvarforallclients("ui_br_x1_checklist_state", 10);
}

x1ops7() {
  level.x1ops = 7;

  foreach(player in level.players) {
    player freezecontrols(1);
    player._id_5D4C8322D01B9C50 = 1;
    player setclientomnvar("ui_br_bink_overlay_state", 9);
    player playcinematicforplayer("mp_x1hype", 1, 1);
  }

  level notify("endCircleDamageTick");
  thread _id_D018817B01AE6A0A();
}

x1opsbink() {
  setmusicstate("");
  _id_4F105563CA74CF73 = "mp_amber_run";
  _id_A143CDB0E0E442C2 = 4;
  _id_A702584AD793F703 = getdvarint("dvar_9D868E9083FD9424", 0);

  if(_id_A702584AD793F703)
    _id_4F105563CA74CF73 = "mp_amber_pause";

  foreach(player in level.players) {
    if(_id_A702584AD793F703) {
      player setclientomnvar("ui_br_transition_type", 0);
      _id_A143CDB0E0E442C2 = 8;
    }

    player setclientomnvar("ui_br_bink_overlay_state", _id_A143CDB0E0E442C2);
    player playcinematicforplayer(_id_4F105563CA74CF73, 1, 1);
    player scripts\cp_mp\utility\player_utility::_freezecontrols(1);
  }

  level.prewaitandspawnclient = _id_1E4A61DB11011446::brprewaitandspawnclient;
  level.modemayconsiderplayerdead = _id_1E4A61DB11011446::brmayconsiderplayerdead;
  level.modeonspawnplayer = _id_1E4A61DB11011446::onspawnplayer;
}

setupx1timelimit() {
  level endon("game_ended");
  level endon("x1OpsTransition");

  if(getdvarint("dvar_9D868E9083FD9424", 0)) {
    return;
  }
  _id_808680E2DF7D0DE5 = getdvarint("dvar_3FF71B787E4E28C7", 60);
  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(player in level.players) {
    player setclientomnvar("ui_br_bink_overlay_state", 4);
    player playcinematicforplayer("mp_connor", 1, 1);
  }
}

x1circletime() {
  level endon("game_ended");
  _id_808680E2DF7D0DE5 = getdvarint("dvar_3FF71B787E4E28C7", 120);
  scripts\mp\flags::gameflagwait("prematch_done");
  setomnvar("ui_br_circle_state", 5);
  _id_49E97EB274785186 = 905;
  setomnvar("ui_hardpoint_timer", gettime() + int(_id_49E97EB274785186 * 1000));
  _id_0098EE5131DA5693 = max(_id_49E97EB274785186 - _id_808680E2DF7D0DE5, 0);
  wait(_id_0098EE5131DA5693);
  setomnvar("ui_br_circle_state", 6);
}

x1opsenableelimination(_id_74B5B12BB6514385) {
  level endon("game_ended");
  wait(_id_74B5B12BB6514385);
  level.prewaitandspawnclient = _id_1E4A61DB11011446::brprewaitandspawnclient;
  level.modemayconsiderplayerdead = _id_1E4A61DB11011446::brmayconsiderplayerdead;
  level.modeonspawnplayer = _id_1E4A61DB11011446::onspawnplayer;
  level.brgametype.funcs["spawnHandled"] = undefined;
  level.brgametype.funcs["playerKilledSpawn"] = undefined;
}

x1opsendgame() {
  level.x1ops = 7;
  level thread scripts\mp\gamelogic::forceend();
}

x1opsentercalloutarea(_id_E90349C02ADFB3A0) {
  if(!scripts\mp\flags::gameflag("br_ready_to_jump")) {
    return;
  }
  player = self;

  if(!isDefined(player.hasbeeninprisonarea))
    player.hasbeeninprisonarea = 0;

  if(_id_E90349C02ADFB3A0 == "gulag" && !istrue(player.hasbeeninprisonarea)) {
    player.hasbeeninprisonarea = 1;
    _id_2CEDCC356F1B9FC8::brleaderdialogplayer("zeus_reveal_gulag_area", player);
  }
}

x1opsinfilsequenceend(players) {
  thread x1opsinfilsequenceendinternal(players);
}

x1opsinfilsequenceendinternal(players) {
  _id_2CEDCC356F1B9FC8::brleaderdialog("zeus_reveal_infil_sequence_01", 0, players);
  wait 1;
  _id_2CEDCC356F1B9FC8::brleaderdialog("zeus_reveal_infil_sequence_02", 0, players);
  wait 4;
  setmusicstate("");
  setmusicstate("event01_track01");
  teamlist = getarraykeys(level.teamdata);

  foreach(team in teamlist) {
    players = level.teamdata[team]["players"];

    if(players.size == 0) {
      continue;
    }
    level.teamdata[team] thread x1questmanager();
  }
}

setcheckliststateforteam(team, value) {
  players = level.teamdata[team]["players"];

  foreach(player in players)
  player setclientomnvar("ui_br_x1_checklist_state", value);
}

x1questmanager() {
  level endon("x1Ops6Start");
  wait 0;
  level.x1ops = 1;
  _id_4BBE27A3F6380B30 = _id_D2DB537FB1A62107();

  if(!isDefined(_id_4BBE27A3F6380B30)) {
    return;
  }
  setcheckliststateforteam(_id_4BBE27A3F6380B30.team, 2);
  _id_4BBE27A3F6380B30 = _id_D2DB537FB1A62107();

  if(!isDefined(_id_4BBE27A3F6380B30)) {
    return;
  }
  setcheckliststateforteam(_id_4BBE27A3F6380B30.team, 3);

  foreach(player in scripts\mp\utility\teams::getteamdata(_id_4BBE27A3F6380B30.team, "players"))
  player scripts\cp_mp\challenges::onunlockitem("x1_emblem_02");

  waittime = 5;

  if(!getdvarint("dvar_4B7D23AD6FCA65D8", 1))
    waittime = 10;

  wait(waittime);
  _id_4BBE27A3F6380B30 = _id_D2DB537FB1A62107();

  if(!isDefined(_id_4BBE27A3F6380B30)) {
    return;
  }
  instance = _id_4BBE27A3F6380B30 _id_00D67C1EA6FA326C::applyquest();
  setcheckliststateforteam(_id_4BBE27A3F6380B30.team, 4);
  instance waittill("removed");
  _id_4BBE27A3F6380B30 = _id_D2DB537FB1A62107();

  if(!isDefined(_id_4BBE27A3F6380B30)) {
    return;
  }
  setcheckliststateforteam(_id_4BBE27A3F6380B30.team, 5);

  foreach(player in scripts\mp\utility\teams::getteamdata(_id_4BBE27A3F6380B30.team, "players"))
  player scripts\cp_mp\challenges::onunlockitem("x1_playercard_01");

  wait(waittime);
  _id_4BBE27A3F6380B30 = _id_D2DB537FB1A62107();

  if(!isDefined(_id_4BBE27A3F6380B30)) {
    return;
  }
  if(getdvarint("dvar_7241762AC469B87E", 1)) {
    setcheckliststateforteam(_id_4BBE27A3F6380B30.team, 6);
    _id_4BBE27A3F6380B30 = _id_D2DB537FB1A62107();

    if(!isDefined(_id_4BBE27A3F6380B30)) {
      return;
    }
    setcheckliststateforteam(_id_4BBE27A3F6380B30.team, 7);

    foreach(player in scripts\mp\utility\teams::getteamdata(_id_4BBE27A3F6380B30.team, "players"))
    player scripts\cp_mp\challenges::onunlockitem("x1_charm_01");

    wait(waittime);
    _id_4BBE27A3F6380B30 = _id_D2DB537FB1A62107();

    if(!isDefined(_id_4BBE27A3F6380B30))
      return;
  }

  setcheckliststateforteam(_id_4BBE27A3F6380B30.team, 8);
  _id_4BBE27A3F6380B30 = _id_D2DB537FB1A62107();

  if(!isDefined(_id_4BBE27A3F6380B30)) {
    return;
  }
  setcheckliststateforteam(_id_4BBE27A3F6380B30.team, 9);
}

_id_D2DB537FB1A62107() {
  while(self["players"].size != 0) {
    foreach(player in self["players"]) {
      if(isalive(player) && !istrue(player.inlaststand) && !player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag())
        return player;
    }

    wait 1;
  }

  return undefined;
}

playerskiplootpickup(instance, _id_B2635DB617B09ABD) {
  player = self;
  return istrue(player.issmokinggun);
}

_id_B6B71C738C7F7CA4(instance) {
  return 0;
}

airstrikebetweentwopoints(_id_45C9D37D4B0BDB41, _id_E3DD6C7DBE5DBD4B) {
  teamlist = getarraykeys(level.teamdata);
  _id_BBCDD8A9438F1EA9 = [];

  foreach(team in teamlist) {
    players = level.teamdata[team]["players"];

    if(players.size == 0) {
      continue;
    }
    _id_BBCDD8A9438F1EA9[_id_BBCDD8A9438F1EA9.size] = players;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BBCDD8A9438F1EA9.size; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 3) {
    players = _id_BBCDD8A9438F1EA9[_id_AC0E594AC96AA3A8];
    _id_3FAC2B649331D46C = players[0];
    origin = ((_id_45C9D37D4B0BDB41[0] + _id_E3DD6C7DBE5DBD4B[0]) / 2, (_id_45C9D37D4B0BDB41[1] + _id_E3DD6C7DBE5DBD4B[1]) / 2, (_id_45C9D37D4B0BDB41[2] + _id_E3DD6C7DBE5DBD4B[2]) / 2);
    _id_084D0C3E36ADDFA4 = 5000;
    _id_191EBD2DD0D5F975 = 5000;
    _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
    _id_1BBCFFA61E3A355A = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(origin, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, _id_FBCABD62B8F66EB8);
    _id_3FAC2B649331D46C scripts\cp_mp\killstreaks\airstrike::callprecisionairstrikeonlocation(_id_1BBCFFA61E3A355A);
  }
}

x1airstrikemanager(_id_1F7FD473E2E3E8AA) {
  if(_id_1F7FD473E2E3E8AA == 6) {
    _id_DC0FC3FB6211CCFB = getdvarint("dvar_4D482683FB18B09D", 4);
    _id_0878CAD8AD255E0B = getdvarint("dvar_0E5D6341374C90DD", 2);
    _id_E1943B588B6965BF = getdvarint("dvar_19893E6BDCC70890", 16);
    _id_1D28C81CF6215B51 = getdvarint("dvar_61387E2FC2BA660E", 10000);
    _id_AC12EE310BA197D0 = getdvarint("dvar_4303731EF29F5A87", 30);
    level thread radialairstrike(_id_E1943B588B6965BF, _id_1D28C81CF6215B51, _id_AC12EE310BA197D0, _id_DC0FC3FB6211CCFB);
    _id_E1943A588B69638C = getdvarint("dvar_19893F6BDCC70AC3", 12);
    _id_1D28C71CF621591E = getdvarint("dvar_61387F2FC2BA6841", 7000);
    _id_AC12EF310BA19A03 = getdvarint("dvar_4303721EF29F5854", 55);
    level thread radialairstrike(_id_E1943A588B69638C, _id_1D28C71CF621591E, _id_AC12EF310BA19A03, _id_DC0FC3FB6211CCFB);
    _id_E19439588B696159 = getdvarint("dvar_1989446BDCC715C2", 8);
    _id_1D28CA1CF6215FB7 = getdvarint("dvar_6138802FC2BA6A74", 5000);
    _id_AC12F4310BA1A502 = getdvarint("dvar_4303711EF29F5621", 75);
    level thread radialairstrike(_id_E19439588B696159, _id_1D28CA1CF6215FB7, _id_AC12F4310BA1A502, _id_DC0FC3FB6211CCFB);
    _id_E19438588B695F26 = getdvarint("dvar_1989456BDCC717F5", 4);
    _id_1D28C91CF6215D84 = getdvarint("dvar_6138812FC2BA6CA7", 1000);
    _id_AC12F5310BA1A735 = getdvarint("dvar_4303701EF29F53EE", 90);
    level thread radialairstrike(_id_E19438588B695F26, _id_1D28C91CF6215D84, _id_AC12F5310BA1A735, _id_0878CAD8AD255E0B);
  }
}

radialairstrike(_id_ED710A70ECB1FA77, radius, waittime, _id_DC0FC3FB6211CCFB) {
  if(!getdvarint("dvar_332E3225D3EA898B", 1)) {
    return;
  }
  if(!isDefined(_id_DC0FC3FB6211CCFB))
    _id_DC0FC3FB6211CCFB = 0;

  if(!isDefined(waittime))
    waittime = 0;

  wait(waittime);
  circlecenter = _id_21C3E8D48552A4FA();
  _id_084D0C3E36ADDFA4 = 5000;
  _id_191EBD2DD0D5F975 = 5000;

  if(radius == 0) {
    _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
    _id_1BBCFFA61E3A355A = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(circlecenter, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, _id_FBCABD62B8F66EB8);
    [player, _id_7AA09B9781611A6A] = findfirstaliveplayer(level.players, 0, 1);

    if(isDefined(player))
      player scripts\cp_mp\killstreaks\airstrike::callprecisionairstrikeonlocation(circlecenter);

    return;
  }

  _id_0A9552E9348D0FEE = 360 / _id_ED710A70ECB1FA77;
  _id_7AA09B9781611A6A = 0;
  _id_AC0E594AC96AA3A8 = 0;
  pos = 0;
  _id_39EE1AAE9BB89FF8 = 0;

  while(_id_39EE1AAE9BB89FF8 < _id_ED710A70ECB1FA77) {
    _id_5CDAEA9D623E0E09 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_5CDAEA9D623E0E09 < _id_DC0FC3FB6211CCFB; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 3) {
      _id_81954D580B24281B = radius * cos(_id_0A9552E9348D0FEE * _id_AC0E594AC96AA3A8);
      _id_E4F34F3A01C6FFF2 = radius * sin(_id_0A9552E9348D0FEE * _id_AC0E594AC96AA3A8);
      x = circlecenter[0] + _id_81954D580B24281B;
      y = circlecenter[1] + _id_E4F34F3A01C6FFF2;
      z = 0;
      _id_EF0DADE73FC874D7 = (x, y, z);
      [player, _id_7AA09B9781611A6A] = findfirstaliveplayer(level.players, _id_7AA09B9781611A6A, 1);
      _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
      _id_1BBCFFA61E3A355A = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(_id_EF0DADE73FC874D7, _id_084D0C3E36ADDFA4, _id_191EBD2DD0D5F975, _id_FBCABD62B8F66EB8);

      if(isDefined(player)) {
        player scripts\cp_mp\killstreaks\airstrike::callprecisionairstrikeonlocation(_id_EF0DADE73FC874D7);
        _id_5CDAEA9D623E0E09++;
        _id_39EE1AAE9BB89FF8++;
        continue;
      }

      _id_39EE1AAE9BB89FF8++;
      break;
    }

    wait(_id_DC0FC3FB6211CCFB);
  }
}

findfirstaliveplayer(participants, _id_2F55781AF96F22F9, _id_26FFC7E7D59C5821) {
  player = undefined;
  _id_7AA09B9781611A6A = undefined;

  if(!isDefined(participants))
    participants = level.players;

  if(!isDefined(_id_2F55781AF96F22F9))
    _id_2F55781AF96F22F9 = 0;

  if(_id_26FFC7E7D59C5821) {
    _id_7502F9FEF0559294 = getarraykeys(level.teamdata);

    for(_id_AC0E594AC96AA3A8 = _id_2F55781AF96F22F9; _id_AC0E594AC96AA3A8 < _id_7502F9FEF0559294.size; _id_AC0E594AC96AA3A8++) {
      if(isDefined(level.teamdata[_id_7502F9FEF0559294[_id_AC0E594AC96AA3A8]]["alivePlayers"])) {
        if(level.teamdata[_id_7502F9FEF0559294[_id_AC0E594AC96AA3A8]]["alivePlayers"].size > 0) {
          player = level.teamdata[_id_7502F9FEF0559294[_id_AC0E594AC96AA3A8]]["alivePlayers"][0];
          _id_7AA09B9781611A6A = _id_AC0E594AC96AA3A8;
        }
      }
    }
  } else {
    for(_id_AC0E594AC96AA3A8 = _id_2F55781AF96F22F9; _id_AC0E594AC96AA3A8 < participants; _id_AC0E594AC96AA3A8++) {
      if(isalive(participants[_id_AC0E594AC96AA3A8])) {
        player = participants[_id_AC0E594AC96AA3A8];
        _id_7AA09B9781611A6A = _id_AC0E594AC96AA3A8;
      }
    }
  }

  return [player, _id_7AA09B9781611A6A];
}

x1opsruntoicon() {
  objid = scripts\mp\objidpoolmanager::requestobjectiveid(99);

  if(objid != -1) {
    circlecenter = _id_21C3E8D48552A4FA();
    scripts\mp\objidpoolmanager::objective_add_objective(objid, "current", circlecenter, "ui_mp_br_mapmenu_icon_x1_05_objective");
    scripts\mp\objidpoolmanager::update_objective_setbackground(objid, 1);
    scripts\mp\objidpoolmanager::objective_playermask_showtoall(objid);
  } else {}
}

_id_D018817B01AE6A0A() {
  foreach(player in level.players) {
    player scripts\cp_mp\challenges::onunlockitem("x1_emblem_01");
    player scripts\cp_mp\challenges::onunlockitem("x1_playercard_02");
    wait 1;
  }
}

_id_B4A62B8CF10E52B0() {
  loadout = [];
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = "iw9_me_fists";
  loadout["loadoutPrimaryAttachment"] = "none";
  loadout["loadoutPrimaryAttachment2"] = "none";
  loadout["loadoutPrimaryCamo"] = "none";
  loadout["loadoutPrimaryReticle"] = "none";
  loadout["loadoutSecondary"] = "none";
  loadout["loadoutSecondaryAttachment"] = "none";
  loadout["loadoutSecondaryAttachment2"] = "none";
  loadout["loadoutSecondaryCamo"] = "none";
  loadout["loadoutSecondaryReticle"] = "none";
  loadout["loadoutMeleeSlot"] = "iw9_me_fists_mp";
  loadout["loadoutEquipmentPrimary"] = "none";
  loadout["loadoutEquipmentSecondary"] = "none";
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "none";
  loadout["loadoutPerks"] = ["specialty_null"];
  loadout["loadoutGesture"] = "playerData";
  loadout["loadoutExecution"] = "none";
  return loadout;
}

_id_F559B8AB160618CA() {
  player = self;
  player scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  player _id_7E52B56769FA7774::resetsuper();
  player.pers["gamemodeLoadout"] = level.brgametype._id_D1944CD1FA64CA75;
  player.class = "gamemode";
}