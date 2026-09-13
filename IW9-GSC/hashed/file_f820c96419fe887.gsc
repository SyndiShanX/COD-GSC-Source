/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_f820c96419fe887.gsc
***********************************************/

init() {
  if(!getdvarint("scr_br_alt_mode_zxp", 0)) {
    return;
  }
  level._id_14CC24A75E8CD64D = ::_id_14CC24A75E8CD64D;
  level.brgametype._id_AD12A63C860848AF = 1;
  level.brgametype.zombierespawning = 1;
  level.brgametype.zombieloadout = createzombieloadout();
  level.brgametype.zombiehealth = getdvarint("dvar_457A291554D55361", 350);
  level.brgametype.zombiesdamagezombies = getdvarint("dvar_7D04136E229C6D7A", 0);
  level.brgametype._id_8FAAF289E5D10151 = getdvarint("dvar_8584A72DD6AFA977", 80);
  level.brgametype.zombiesignorevehicleexplosions = getdvarint("dvar_9E8F30B569E2ABE5", 1);
  level.brgametype._id_08EB8826347F1258 = getdvarint("dvar_3AD2F81E6E6CF99C", 1);
  level.brgametype.zombiepingrate = getdvarfloat("dvar_4DAB1AAF5C7733BE", -1);
  level.brgametype.zombiepingtime = getdvarfloat("dvar_35B72E2558F0A7CD", 0.5);
  level.brgametype.zombienumtoconsume = getdvarint("dvar_1322659CEB016A98", 4);
  level.brgametype.zombieregenratescaleingas = getdvarfloat("dvar_732DBD6BA0B0F252", 2.0);
  level.brgametype.zombieregenratescaleoutgas = getdvarfloat("dvar_DD936BDB4CF1F2EF", 0.7);
  level.brgametype.zombieregendelayscaleingas = getdvarfloat("dvar_C186667E8CB3BC6B", 1.0);
  level.brgametype.zombieregendelayscaleoutgas = getdvarfloat("dvar_B0687A8F2794F3B8", 1.5);
  level.brgametype.zombiepowersenabled = getdvarint("dvar_B760176B090452C1", 1);
  level.brgametype.powerscooldown = getdvarint("dvar_2546D85E9D039F6B", 1);
  level.brgametype.zombienumhitshuman = getdvarfloat("dvar_A08FD1AAD589D41B", 3);
  level.brgametype._id_DF9BA21D322F48A0 = getdvarint("dvar_6931DEF073D51E8C", 1);
  level.brgametype.zombienumhitsheli = getdvarfloat("dvar_8D24CF268D991C83", 2);
  level.brgametype.zombienumhitsatv = getdvarfloat("dvar_AFB1F56AC422F668", 2);
  level.brgametype.zombienumhitscar = getdvarfloat("dvar_9162A16AAD712F5B", 3);
  level.brgametype.zombienumhitstruck = getdvarfloat("dvar_5552790671B23F3E", 4);
  level.brgametype.zombiespawninair = getdvarint("dvar_9C4658BFBE5E2B39", 1);
  level.brgametype.zombievehiclelaststand = getdvarint("dvar_46634A326AA6BC5E", 0);
  level.brgametype.zombiespawnabovedeath = getdvarint("dvar_B2CCEFCD02E5660F", 0);
  level.brgametype.humanspawninair = getdvarint("dvar_9EC879D1DAFA798B", 1);
  level.brgametype._id_863F6D0E1A1C01E9 = getdvarint("dvar_1EE25065B4A3191C", 1);
  level.brgametype._id_A4A60D445462181D = getdvarint("dvar_B5AC32636B6FF882", 0);
  level.brgametype._id_854EDAEC88CAF865 = getdvarint("dvar_21FBBC29B9FECAC8", 20);
  level.brgametype._id_854ED7EC88CAF1CC = getdvarint("dvar_31D8C8E967F4F20F", 30);
  level.brgametype._id_437EAAAE9F85F287 = getdvarint("dvar_41594FBB80D9883E", 1);
  level.brgametype._id_F0435C9DEED2849D = getDvar("dvar_23BFD5F2A84EB6D8", "mp_zmb_pm");
  level.brgametype._id_63D9BE743A6BA8CD = getdvarint("dvar_FDB01D1A58DCDCB1", 1);
  level.brgametype._id_F08BFC048423D1DC = getdvarint("dvar_08C5546E4F573664", 0);
  level.brgametype._id_68DFC0A151952869 = getdvarfloat("dvar_340B7EB839056345", 0.65);
  level.brgametype._id_9DD997CED889B541 = getdvarint("dvar_A34F4BB4586CA7A6", 1);
  level.brgametype._id_888A368FC494C603 = getdvarint("dvar_77B0C9B7F8217BE6", 1);
  level.brgametype._id_B8456BBDF46925A3 = getdvarint("dvar_4903CBD81395DA65", 0);
  level.brgametype._id_FE1ED6B37A8D2BBA = getdvarint("dvar_EF3CF14423EA0971", 1);
  level.brgametype._id_52D26462081A2D41 = getdvarfloat("dvar_6DB0C7F59C294CB4", 1.0);
  level.brgametype._id_5A945BE17BF844BD = getdvarfloat("dvar_6715C45DD1CDA5BF", 10.0);
  level.brgametype._id_89B7489C115DC08A = getdvarfloat("dvar_89B508DFEC9FB80A", 15.0);
  level.brgametype._id_695B3601560F5703 = getdvarfloat("dvar_F2BCE8BFF1023A79", 1.2);
  level.brgametype._id_6225CE8E059E5CE5 = getdvarfloat("dvar_03A436A2EB1BD593", 2.0);
  level.brgametype._id_07F417534E5C75F9 = getdvarfloat("dvar_3382204607436AFE", 0.75);
  level.brgametype._id_CA0A3CE7573E0780 = getdvarfloat("dvar_ADD73918EA9FCAF8", 0.2);
  level.brgametype._id_2D23E5B9ABED638C = getdvarfloat("dvar_C63870E71431980A", 1.2);
  level.brgametype._id_5BA111AE6C83EFFE = getdvarint("dvar_345C19750D32D4A7", 0);
  level.brgametype._id_DBB3B2958AF5562B = getdvarfloat("dvar_3489D22533419D85", 1.0);
  level.shownonspectatingwinnersplash = 1;
  level._effect["zombie_trans"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_transition_to_human.vfx");
  level._effect["zombie_splat"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_freefall_splat.vfx");
  level._effect["zombie_buffed"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_zombie_shout_buffed.vfx");
  level._effect["zombie_shout"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_zombie_shout.vfx");
  level._effect["zombie_shout_shockwaves"] = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_zombie_shout_shockwaves.vfx");
  level.brgametype.impulsefx = loadfx("vfx/iw8_br/gameplay/zombie/vfx_zmb_human_push_blast");
  scripts\cp_mp\utility\script_utility::registersharedfunc("airdrop", "specialCase_canUseCrate", ::_id_AA5AF609F16F8351);
  thread initpostmain();
}

initpostmain() {
  waittillframeend;
  thread setupzombiepowers();
  thread _id_E4CFFB22A28408E2();

  if(!threatbiasgroupexists("player_zombie"))
    createthreatbiasgroup("player_zombie");

  level._id_C3A0F3B16CCE4CA9._id_B6064226993B9C1D = ::_id_81E6ECFD4DF39002;
}

playerspawn() {
  player = self;

  if(!isDefined(player.hudzombie))
    player playerzombiesetuphud();

  wait 0.5;
  player _id_10FFA1071B1C2681();
  wait 2;
  player playerzombierespawn(0);
}

modifyplayerdamage(data) {
  idamage = data.damage;
  _id_7BFCAD6985F865AC = isPlayer(data.attacker) && data.attacker _id_2CEDCC356F1B9FC8::playeriszombie();
  _id_EB938D26F29141AA = isDefined(data.attacker) && data.attacker entisvehicle();
  _id_8D6DEEB9C425CE1B = isPlayer(data.victim) && data.victim _id_2CEDCC356F1B9FC8::playeriszombie();
  _id_5C3F9357F11D2223 = scripts\mp\utility\weapon::getweaponbasenamescript(data.objweapon);

  if(_id_7BFCAD6985F865AC && _id_8D6DEEB9C425CE1B && data.meansofdeath == "MOD_MELEE")
    idamage = level.brgametype._id_8FAAF289E5D10151;
  else if(_id_7BFCAD6985F865AC && !_id_8D6DEEB9C425CE1B && !data.attacker isinexecutionattack() && data.victim isinexecutionvictim())
    idamage = 0;
  else if(_id_8D6DEEB9C425CE1B && isDefined(data.inflictor) && isDefined(data.inflictor.streakinfo) && (data.inflictor.streakinfo.streakname == "toma_strike" || data.inflictor.streakinfo.streakname == "precision_airstrike" || data.inflictor.streakinfo.streakname == "manual_turret")) {
    _id_6B3343960B7F7865 = data.victim.maxhealth;
    _id_5DFC4383CDE705A4 = data.attacker.maxhealth;
    idamage = data.damage * int(floor(_id_6B3343960B7F7865 / _id_5DFC4383CDE705A4));
  } else if(level.brgametype.zombiesignorevehicleexplosions && _id_8D6DEEB9C425CE1B && isexplosivedamagemod(data.meansofdeath) && isDefined(data.inflictor) && data.inflictor scripts\cp_mp\vehicles\vehicle::isvehicle())
    idamage = 0;
  else if(_id_8D6DEEB9C425CE1B && (data.meansofdeath == "MOD_GRENADE_SPLASH" || data.meansofdeath == "MOD_EXPLOSIVE"))
    idamage = data.damage * getdvarfloat("dvar_BF750007EA105D69", 3.0);
  else if(_id_7BFCAD6985F865AC && !_id_8D6DEEB9C425CE1B && data.meansofdeath == "MOD_MELEE") {
    maxhealth = data.victim.maxhealth;
    _id_676A5FD0436C01A9 = level.brgametype.zombienumhitshuman;

    if(!level.brgametype._id_DF9BA21D322F48A0)
      maxhealth = maxhealth + data.victim.br_maxarmorhealth;

    idamage = int(ceil(maxhealth / _id_676A5FD0436C01A9));
  } else if(_id_8D6DEEB9C425CE1B && _id_EB938D26F29141AA && istrue(data.victim.vehicledamageimmunity))
    idamage = 0;
  else if(_id_7BFCAD6985F865AC && !_id_8D6DEEB9C425CE1B && data.meansofdeath == "MOD_IMPACT" && _id_5C3F9357F11D2223 == "rock_mp") {
    inflictor = spawnStruct();
    inflictor.origin = data.point;
    data.victim thread scripts\mp\equipment\concussion_grenade::applyconcussion(inflictor, data.attacker);
  } else if(_id_8D6DEEB9C425CE1B) {
    _id_E88B8A44100E399F = 0.7;
    _id_49E6EF3EDADD524E = _id_2669878CF5A1B6BC::getweaponrootname(data.objweapon);
    weapontype = weaponclass(_id_5C3F9357F11D2223);
    _id_1646FE11681A5388 = _id_07C40FA80892A721::isbulletpenetration(data.idflags);

    if(!_id_1646FE11681A5388) {
      switch (weapontype) {
        case "sniper":
          if(data.shitloc == "head" || data.shitloc == "helmet") {
            if(_id_1E4A61DB11011446::issnipersemi(_id_49E6EF3EDADD524E))
              idamage = int(ceil(level.brgametype.zombiehealth * _id_E88B8A44100E399F));
            else
              idamage = level.brgametype.zombiehealth;
          }

          break;
        default:
          if(data.shitloc == "head" || data.shitloc == "helmet") {
            playermaxhealth = getdvarfloat("scr_player_maxhealth", 100.0);
            _id_4D995B1DD54EB1AC = playermaxhealth;

            if(level.brgametype._id_F08BFC048423D1DC)
              _id_4D995B1DD54EB1AC = _id_4D995B1DD54EB1AC + 0;

            idamage = int(ceil(idamage / _id_4D995B1DD54EB1AC * level.brgametype.zombiehealth * level.brgametype._id_68DFC0A151952869));
          }

          break;
      }
    }

    _id_CA4A38B357937057 = _func_2EF675C13CA1C4AF("dvar_199E1D44104C7CB8", weapontype);
    _id_4E94C5615C36AB4E = 0;

    if(weapontype == "spread")
      _id_4E94C5615C36AB4E = 0.7;

    _id_FCC299892A3B968D = getdvarfloat(_id_CA4A38B357937057, _id_4E94C5615C36AB4E);

    if(_id_FCC299892A3B968D != 0)
      idamage = int(ceil(idamage * _id_FCC299892A3B968D));

    _id_6721E451F9BE96AA = _func_2EF675C13CA1C4AF("dvar_199E1D44104C7CB8", _id_49E6EF3EDADD524E);
    _id_4E94C5615C36AB4E = 0;

    if(_id_49E6EF3EDADD524E == "iw8_sh_charlie725")
      _id_4E94C5615C36AB4E = 1.43;

    _id_745E6E594DCFBDBE = getdvarfloat(_id_6721E451F9BE96AA, _id_4E94C5615C36AB4E);

    if(_id_745E6E594DCFBDBE != 0)
      idamage = int(ceil(idamage * _id_745E6E594DCFBDBE));
  }

  if(_id_8D6DEEB9C425CE1B && istrue(data.victim._id_750C82BA41F3E2B1))
    idamage = int(float(idamage) * level.brgametype._id_07F417534E5C75F9);

  return idamage;
}

entisvehicle() {
  return scripts\common\vehicle::isvehicle() || isDefined(self.classname) && self.classname == "script_vehicle";
}

modifyvehicledamage(data) {
  idamage = data.damage;
  vehicle = data.victim;
  attacker = scripts\engine\utility::ter_op(isDefined(data.attacker), data.attacker, data.inflictor);
  _id_E67A363CB760BE2F = 0;

  if(isDefined(attacker)) {
    if(isPlayer(attacker) && attacker _id_2CEDCC356F1B9FC8::playeriszombie())
      _id_E67A363CB760BE2F = data.meansofdeath == "MOD_MELEE";
    else if(isagent(attacker) && istrue(attacker.zombie))
      _id_E67A363CB760BE2F = data.meansofdeath == "MOD_IMPACT";
  }

  vehicletype = vehicle.vehiclename;

  if(_id_E67A363CB760BE2F) {
    switch (vehicletype) {
      case "atv":
        idamage = vehicle.maxhealth / level.brgametype.zombienumhitsatv;
        break;
      case "jeep":
      case "tac_rover":
      case "veh9_sedan_hatchback_1985":
        idamage = vehicle.maxhealth / level.brgametype.zombienumhitscar;
        break;
      case "cargo_truck_mg":
      case "cargo_truck":
      case "veh9_suv_1996":
        idamage = vehicle.maxhealth / level.brgametype.zombienumhitstruck;
        break;
      case "little_bird_mg":
      case "little_bird":
        idamage = vehicle.maxhealth / level.brgametype.zombienumhitsheli;
        break;
      default:
        idamage = vehicle.maxhealth / level.brgametype.zombienumhitstruck;
        break;
    }

    idamage = int(ceil(idamage));
  }

  return idamage;
}

mayconsiderplayerdead(player, _id_887D9BC9CBAD47F1) {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    return 1;

  result = player _id_AFA8B73EB004C380(_id_887D9BC9CBAD47F1);

  if(result)
    player.respawningfromtoken = 1;
  else if(_id_2CEDCC356F1B9FC8::playeriszombie())
    thread playerdelaydisablezombie();

  return !result;
}

spawnhandled(player) {
  if(istrue(player.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done") && player _id_2CEDCC356F1B9FC8::playeriszombie()) {
    player playerreadytospawn();
    return 1;
  }

  return 0;
}

markplayeraseliminatedonkilled() {
  if(!scripts\mp\flags::gameflag("prematch_done"))
    return 0;

  return !istrue(self.respawningfromtoken);
}

_id_AFA8B73EB004C380(_id_887D9BC9CBAD47F1) {
  if(!istrue(_id_887D9BC9CBAD47F1)) {
    if(_id_2CEDCC356F1B9FC8::playeriszombie())
      return 0;
  }

  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done") || level.gameended || !level.brgametype.zombierespawning)
    return 0;

  return 1;
}

playertryzombiespawn(_id_887D9BC9CBAD47F1) {
  if(!istrue(_id_887D9BC9CBAD47F1)) {
    if(_id_2CEDCC356F1B9FC8::playeriszombie()) {
      thread playerdelaydisablezombie();
      return 0;
    }
  }

  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done") || level.gameended || !level.brgametype.zombierespawning)
    return 0;

  thread playerzombierespawn(0);
  return 1;
}

playerkilledspawn(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7) {
  if(!istrue(self.br_infilstarted) || !scripts\mp\flags::gameflag("prematch_done"))
    return 0;

  if(level.gameended)
    return 1;

  if(istrue(self.respawningbr))
    return 1;

  if(istrue(self.respawningfromtoken) && !_id_2CEDCC356F1B9FC8::playeriszombie()) {
    self.respawningfromtoken = undefined;
    thread playerzombierespawn(0);
  } else if(!scripts\mp\utility\damage::playershoulddofauxdeath(0))
    _id_642470E1ABC1BBF9.victim thread _id_6489FCDFE6FA2E36::spawnspectator(_id_642470E1ABC1BBF9, _id_8B3F6477DBED24D7);

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("zombieDialog_tryLastHumanAlive"))
    _id_362C58E8BB39BCDA::runbrgametypefunc("zombieDialog_tryLastHumanAlive", self);

  return 1;
}

playerdelaydisablezombie() {
  self endon("disconnect");
  self setscriptablepartstate("zombie", "off");
  self setscriptablepartstate("compassicon", "defaulticon");
  self setscriptablepartstate("skydiveVfx", "default", 0);

  if(level.brgametype._id_437EAAAE9F85F287) {
    _id_234906F719267CD4();

    if(!level.brgametype._id_63D9BE743A6BA8CD)
      self setscriptablepartstate("headVFX", "neutral");

    self._id_054E863EBAD3E233 = undefined;
    scripts\mp\utility\player::restorebasevisionset(0);
  }

  waittillframeend;
  playersetiszombie(0, 1);
  _id_FD7BDFFE7CEA51ED(0);
}

_id_234906F719267CD4() {
  foreach(player in level.players)
  player hudoutlinedisableforclient(self);
}

playersetiszombie(value, _id_5FD0C9CF6D0E1D68) {
  self.iszombie = value;
  playersetiszombieextrainfo(value);

  if(value) {
    self notify("zombie_set");
    level notify("zombie_set", self);

    if(level.brgametype._id_A4A60D445462181D)
      playerzombiesetuphud();

    self.numconsumed = 0;
    self.bcdisabled = 1;
    self._id_F8E21465665E3F81 = 1;
    playersetisbecomingzombie(0);
    scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(7);
    scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(9);
    scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(10);
    scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(11);
    _id_936F0EF6E203A7FC("numVaccine", self.numconsumed);

    if(threatbiasgroupexists("player_zombie"))
      self setthreatbiasgroup("player_zombie");
  } else {
    self notify("zombie_unset");
    level notify("zombie_unset", self);
    self.numconsumed = undefined;
    self.bcdisabled = undefined;
    self._id_F8E21465665E3F81 = undefined;
    scripts\cp_mp\calloutmarkerping::calloutmarkerping_removecallout(7);
    _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("numVaccine", 0);
    self setthreatbiasgroup();
    self _meth_ 9 DD858480D66BBC(0);
  }

  level notify("players_remaining_changed");
  self setclientomnvar("ui_br_inventory_disabled", value);
  self notify("stop_battlechatter");

  if(istrue(_id_5FD0C9CF6D0E1D68)) {
    self lerpfovbypreset("default");

    if(level.brgametype._id_63D9BE743A6BA8CD)
      thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();
  }

  foreach(_id_B2810E8D06E0A042 in scripts\mp\utility\teams::getteamdata(self.team, "players")) {
    if(isDefined(_id_B2810E8D06E0A042))
      _id_B2810E8D06E0A042 notify("refresh_revives");
  }
}

createzombieloadout() {
  loadout = [];
  loadout["loadoutArchetype"] = "archetype_assault";
  loadout["loadoutPrimary"] = "iw9_me_fists_mp";
  loadout["loadoutPrimaryAttachment"] = "none";
  loadout["loadoutPrimaryAttachment2"] = "none";
  loadout["loadoutPrimaryCamo"] = "none";
  loadout["loadoutPrimaryReticle"] = "none";
  loadout["loadoutSecondary"] = "none";
  loadout["loadoutSecondaryAttachment"] = "none";
  loadout["loadoutSecondaryAttachment2"] = "none";
  loadout["loadoutSecondaryCamo"] = "none";
  loadout["loadoutSecondaryReticle"] = "none";
  loadout["loadoutMeleeSlot"] = "none";
  loadout["loadoutEquipmentPrimary"] = "none";
  loadout["loadoutEquipmentSecondary"] = "none";
  loadout["loadoutStreakType"] = "assault";
  loadout["loadoutKillstreak1"] = "none";
  loadout["loadoutKillstreak2"] = "none";
  loadout["loadoutKillstreak3"] = "none";
  loadout["loadoutSuper"] = "super_br_extract";
  loadout["loadoutPerks"] = ["specialty_null"];
  loadout["loadoutGesture"] = "playerData";
  loadout["loadoutExecution"] = "none";
  return loadout;
}

_id_0330F2255DA6B470(_id_92A1C0C07F53993D, _id_92A1BFC07F53970A) {
  teamlist = getarraykeys(level.teamdata);

  foreach(team in teamlist) {
    players = level.teamdata[team]["players"];

    foreach(player in players) {
      if(player _id_2CEDCC356F1B9FC8::playeriszombie()) {
        if(level.brgametype._id_A4A60D445462181D)
          player playerzombiedestroyhud();

        player playerpowerscleanuphud();
        continue;
      }

      player playerpowerscleanuphud();
    }
  }
}

isvalidspectatetarget(player) {
  if(!isDefined(player))
    return 0;

  if(!isalive(player) && !istrue(player.respawningfromtoken) && !player _id_2CEDCC356F1B9FC8::playeriszombie())
    return 0;

  return !istrue(player.br_iseliminated) || player _id_2CEDCC356F1B9FC8::playeriszombie();
}

_id_BE23DE35D5DB5CF0(pickup) {
  if(pickup.scriptablename == "brloot_zmb_stim") {
    if(self.numconsumed >= level.brgametype.zombienumtoconsume)
      return 12;

    return 1;
  }

  return undefined;
}

_id_14CC24A75E8CD64D(pickup) {
  if(pickup.scriptablename == "brloot_zmb_stim")
    pickup.instance onuse(self);
}

playerzombiesetuphud() {
  _id_5F243323AF462B6A = -60;
  _id_5522365EA860860B = 120;
  _id_748F3DDC7533D2A9 = 180;
  self.hudnumconsumed = playercreatehudelement(_id_5F243323AF462B6A, _id_5522365EA860860B, "right", "middle", "center", "middle", &"MP_ZXP/NUM_CONSUMED", 0);
  self.hudnumtoconsume = playercreatehudelement(_id_5F243323AF462B6A, _id_5522365EA860860B, "left", "middle", "center", "middle", &"MP_ZXP/NUM_TO_CONSUME", level.brgametype.zombienumtoconsume);
  self.hudzombie = playercreatehudelement(0, _id_748F3DDC7533D2A9, "center", "middle", "center", "middle", &"MP_ZXP/ZOMBIE");
}

playercreatehudelement(xoffset, yoffset, alignx, aligny, horzalign, vertalign, label, value) {
  _id_94480E1669B7FF0D = scripts\mp\hud_util::createfontstring("default", 1.5);
  _id_94480E1669B7FF0D.x = xoffset;
  _id_94480E1669B7FF0D.y = yoffset;
  _id_94480E1669B7FF0D.alignx = alignx;
  _id_94480E1669B7FF0D.aligny = aligny;
  _id_94480E1669B7FF0D.horzalign = horzalign;
  _id_94480E1669B7FF0D.vertalign = vertalign;
  _id_94480E1669B7FF0D.alpha = 0;
  _id_94480E1669B7FF0D.glowalpha = 0;
  _id_94480E1669B7FF0D.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.archived = 0;

  if(isDefined(label))
    _id_94480E1669B7FF0D.label = label;

  if(isDefined(value))
    _id_94480E1669B7FF0D setvalue(value);

  return _id_94480E1669B7FF0D;
}

playersetiszombieextrainfo(value) {
  if(istrue(value))
    self.game_extrainfo = self.game_extrainfo | 16384;
  else
    self.game_extrainfo = self.game_extrainfo &~16384;
}

playerzombierespawn(_id_FD96C3C1EC7B2988, _id_BABF157DEC7ECB90) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("zombie_unset");

  if(level.gameended) {
    return;
  }
  if(!isDefined(level.teamdata[self.team]["lastZombieTime"]) && !isDefined(level._id_42D67D7E9F82F50B))
    _id_2CEDCC356F1B9FC8::brleaderdialogteam("zmb_need_someone_alive", self.team);

  setteamlastzombietime(self.team);
  playersetisbecomingzombie(1);
  playerzombiestatechange(1);
  waittillframeend;
  playersetiszombie(1);

  if(istrue(_id_BABF157DEC7ECB90))
    _id_0A34750D17473C49::unmarkplayeraseliminated(self, "outbreak");
  else
    self.respawningbr = 1;

  if(isDefined(level._id_42D67D7E9F82F50B))
    playerreadytospawn();
  else if(_id_FD96C3C1EC7B2988)
    playerwaittospawn();
  else
    playerreadytospawn();

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("playerGetZombieSpawnLocation"))
    [spawnorigin, spawnangles] = _id_362C58E8BB39BCDA::runbrgametypefunc("playerGetZombieSpawnLocation");
  else
    [spawnorigin, spawnangles] = playergetzombiespawnlocation();

  [spawnorigin, _id_11F3B4465C8B637B] = playerzombieprestream(spawnorigin, spawnangles);
  _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
  wait 1;
  scripts\mp\class::loadout_emptycacheofloadout("gamemode");
  self.pers["gamemodeLoadout"] = level.brgametype.zombieloadout;
  self.class = "gamemode";
  self.forcespawnangles = spawnangles;
  self.forcespawnorigin = _id_11F3B4465C8B637B;
  scripts\mp\playerlogic::spawnplayer(undefined, 0);
  thread scripts\mp\music_and_dialog::_id_5407F73C49740FC7();
  scripts\cp_mp\execution::_clearexecution();
  _id_7E52B56769FA7774::initplayer(1);
  _id_6489FCDFE6FA2E36::playerclearspectatekillchainsystem();
  self notify("endSuperJumpFov");
  _id_3184653FDF31DB44 = makeweapon("iw9_me_fists_mp");
  scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_3184653FDF31DB44);
  _id_E3438B8CB9C2C515 = makeweapon("iw9_me_fists_mp_zmb");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(_id_E3438B8CB9C2C515, undefined, undefined, 1);
  self detachall();
  self setModel("fullbody_zombie_a_br");
  self setviewmodel("vm_arms_zombie_a");
  scripts\mp\utility\player::_setsuit("iw9_zombie_mp");

  if(level.brgametype._id_FE1ED6B37A8D2BBA)
    scripts\cp_mp\execution::_giveexecution("execution_345");
  else
    scripts\cp_mp\execution::_clearexecution();

  _id_F053FD568237D1F2 = self _meth_EFED183E552B0625();

  if(isDefined(_id_F053FD568237D1F2))
    self _meth_ECDCCFDA4326DE02();

  playerstreamwaittillcomplete(spawnorigin, spawnangles, _id_11F3B4465C8B637B);
  self skydive_interrupt();
  self.ffsm_state = 5;
  self skydive_setbasejumpingstatus(0);
  self skydive_setdeploymentstatus(0);
  self skydive_beginfreefall();
  childthread _id_1D3F5814F83DD9AC(_id_E3438B8CB9C2C515);
  _id_FD7BDFFE7CEA51ED(1);
  thread playerzombiehitground(_id_E3438B8CB9C2C515, 0);
  thread _id_1E4A61DB11011446::br_displayperkinfo();
  thread playerzombiesupersprint();

  if(level.brgametype._id_08EB8826347F1258)
    thread playerzombiesetradar();

  thread playerzombiegasthink();
  self disableexecutionvictim();
  scripts\mp\utility\perk::giveperk("specialty_tracker");
  scripts\mp\utility\perk::giveperk("specialty_sprintmelee");
  scripts\mp\utility\perk::giveperk("specialty_sprintads");
  _id_3B64EB40368C1450::set("zombie", "vehicle_use", !self.iszombie);
  self _meth_ 9 DD858480D66BBC(1);
  self lerpfovbypreset("zombiedefault");

  if(level.brgametype._id_63D9BE743A6BA8CD)
    self setclientomnvar("ui_deadsilence_overlay", 0);

  thread playerzombiedelayturnonfx();
  self setscriptablepartstate("compassicon", "zombie");

  if(getdvarint("dvar_04171E2BC0238543", 0))
    self forcenetfieldhighlod(1);

  if(isDefined(level._id_42D67D7E9F82F50B))
    scripts\mp\hud_message::showsplash("br_reveal_stop_exfil");
  else
    scripts\mp\hud_message::showsplash("br_gametype_zxp_change_zombie", undefined, undefined, undefined, undefined, "splash_list_iw9_br_zxp");

  if(!scripts\mp\utility\perk::_hasperk("specialty_pistoldeath"))
    scripts\mp\utility\perk::giveperk("specialty_pistoldeath");

  self.maxhealth = level.brgametype.zombiehealth;
  self.health = self.maxhealth;
  _id_07C40FA80892A721::givestartingarmor(0, 0, 0);
  _id_64E4C3AB6B01B316::givearmorvalue(0);
  self.respawningbr = undefined;
  wait 3;

  if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("zombieDialog_respawnAsZombie"))
    _id_362C58E8BB39BCDA::runbrgametypefunc("zombieDialog_respawnAsZombie", self);

  if(_id_294DDA4A4B00FFE3::_id_4AD287E0971672A6()) {
    _id_C492F22D5C11B367 = _id_294DDA4A4B00FFE3::_id_C6B950C21813B5CD();
    dlog_recordevent("dlog_event_zxp_player_zombie_respawn", ["infestation_index", _id_C492F22D5C11B367]);
  }
}

playerregenhealthadd(_id_7C90DD5575D81006) {
  if(_id_2CEDCC356F1B9FC8::playeriszombie()) {
    if(istrue(self.zombieingas))
      return int(level.brgametype.zombieregenratescaleingas * _id_7C90DD5575D81006);
    else
      return int(level.brgametype.zombieregenratescaleoutgas * _id_7C90DD5575D81006);
  }

  return undefined;
}

_id_FD7BDFFE7CEA51ED(iszombie) {
  if(!istrue(level.brgametype._id_9DD997CED889B541))
    _id_2CEDCC356F1B9FC8::_id_179A8D5A185DFB56(iszombie);

  if(iszombie) {
    if(level.brgametype._id_A4A60D445462181D) {
      self.hudnumconsumed.alpha = 1;
      self.hudnumtoconsume.alpha = 1;
      self.hudzombie.alpha = 1;
    }

    self disableweaponpickup();
  } else {
    playerzombiedestroyhud();
    self enableweaponpickup();
  }

  _id_4B87F2871B6B025C::_id_9368FFF2B3156346(iszombie);
  _id_4B87F2871B6B025C::_id_F295BD882C3D52F5(iszombie);
}

setteamlastzombietime(team) {
  level.teamdata[team]["lastZombieTime"] = gettime();
}

playersetisbecomingzombie(value) {
  self.isbecomingzombie = value;
}

playerzombiestatechange(_id_E2C92CCEDE3B063E) {
  team = self.team;
  scripts\mp\utility\teams::validatealivecount("mode", team, self);
  playerupdatealivecounthuman();

  if(istrue(_id_E2C92CCEDE3B063E))
    [[level.updategameevents]]();
}

playerzombiedestroyhud() {
  if(isDefined(self.hudnumconsumed))
    thread delaydestroyhudelem(self.hudnumconsumed, 1.5);

  if(isDefined(self.hudnumtoconsume))
    thread delaydestroyhudelem(self.hudnumtoconsume, 1.5);

  if(isDefined(self.hudzombie))
    self.hudzombie destroy();

  self.hudnumconsumed = undefined;
  self.hudnumtoconsume = undefined;
  self.hudzombie = undefined;
}

delaydestroyhudelem(_id_94480E1669B7FF0D, _id_74B5B12BB6514385) {
  wait(_id_74B5B12BB6514385);

  if(isDefined(_id_94480E1669B7FF0D))
    _id_94480E1669B7FF0D destroy();
}

_id_6ECE6988ECAF0EA7() {
  return isDefined(self._id_45F93A3BA26BD0B7);
}

playerregendelayspeed(_id_DEC837630EB16CAF) {
  if(_id_2CEDCC356F1B9FC8::playeriszombie()) {
    if(istrue(self.zombieingas))
      return 1 / level.brgametype.zombieregendelayscaleingas * _id_DEC837630EB16CAF;
    else
      return 1 / level.brgametype.zombieregendelayscaleoutgas * _id_DEC837630EB16CAF;
  }

  return undefined;
}

onuse(player) {
  thread _id_DC5E885EDA9F918E(player);
}

_id_DC5E885EDA9F918E(player) {
  if(!isDefined(player))
    thread _id_655264B2E0A7579E::_id_3BBC840FB244D188(self);
  else {
    if(!_id_7FFB58B4CEFFAE1B(player)) {
      return;
    }
    if(istrue(level.gameended)) {
      return;
    }
    thread _id_655264B2E0A7579E::_id_3BBC840FB244D188(self, undefined, player);

    if(player.numconsumed >= level.brgametype.zombienumtoconsume) {
      return;
    }
    player.numconsumed++;

    if(level.brgametype._id_A4A60D445462181D)
      player playerhudupdatenumconsumed();

    player _id_936F0EF6E203A7FC("numVaccine", player.numconsumed);

    if(_id_362C58E8BB39BCDA::isbrgametypefuncdefined("zombieDialog_lootSyringe"))
      thread _id_362C58E8BB39BCDA::runbrgametypefunc("zombieDialog_lootSyringe", player);

    if(player.numconsumed >= level.brgametype.zombienumtoconsume) {
      player thread _id_655264B2E0A7579E::playerzombiebacktohuman();
      player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("numVaccine", level.brgametype.zombienumtoconsume);
      dlog_recordevent("dlog_event_zxp_syringe_use", []);
      return;
    }

    player _id_2CEDCC356F1B9FC8::updatebrscoreboardstat("numVaccine", int(player.numconsumed));
  }
}

_id_7FFB58B4CEFFAE1B(player) {
  return player _id_2CEDCC356F1B9FC8::playeriszombie();
}

_id_AA5AF609F16F8351() {
  return !_id_2CEDCC356F1B9FC8::playeriszombie();
}

playerhudupdatenumconsumed() {
  _id_6BDB7EFE3AF494BA = (0, 1, 0);
  self.hudnumconsumed setvalue(self.numconsumed);
  self.hudnumconsumed thread huddopulse(_id_6BDB7EFE3AF494BA);
  self.hudnumtoconsume thread huddopulse(_id_6BDB7EFE3AF494BA);
}

huddopulse(_id_A1C90D2E290C03FD) {
  self endon("death");

  if(istrue(self.pulsing)) {
    return;
  }
  _id_CC2C2F3EAC3C7BD2 = 0.5;
  _id_5F2809F4E8852C13 = 4;
  self.pulsing = 1;
  _id_B96028986997E29C = self.fontscale;
  _id_672265C8E01995A1 = self.color;

  if(isDefined(_id_A1C90D2E290C03FD))
    self.color = _id_A1C90D2E290C03FD;

  self changefontscaleovertime(_id_CC2C2F3EAC3C7BD2);
  self.fontscale = _id_5F2809F4E8852C13;
  wait(_id_CC2C2F3EAC3C7BD2);
  self changefontscaleovertime(_id_CC2C2F3EAC3C7BD2);
  self.fontscale = _id_B96028986997E29C;
  wait(_id_CC2C2F3EAC3C7BD2);
  self.color = _id_672265C8E01995A1;
  self.pulsing = undefined;
}

_id_10FFA1071B1C2681() {
  _id_45F93A3BA26BD0B7 = spawnStruct();
  _id_45F93A3BA26BD0B7.current = self getcurrentprimaryweapon();
  _id_45F93A3BA26BD0B7._id_BC002676438672C9 = [];
  _id_45F93A3BA26BD0B7._id_AC9CAEBED426E625 = [];
  _id_45F93A3BA26BD0B7._id_734357A0B88E3A30 = [];
  _id_45F93A3BA26BD0B7._id_D1AD88BF84DAA67F = [];
  _id_45F93A3BA26BD0B7.offhands = [];
  _id_45F93A3BA26BD0B7._id_00ACA871F9745FC8 = [];
  _id_D39A4E49BE46E576 = [];
  _id_34CA738E6F3870DE = self getweaponslistprimaries();

  foreach(primary in _id_34CA738E6F3870DE) {
    if(!scripts\mp\utility\weapon::ismeleeoverrideweapon(primary) && !issubstr(primary.basename, "iw8_fists_mp") && !scripts\mp\utility\weapon::isgunlessweapon(primary.basename))
      _id_D39A4E49BE46E576[_id_D39A4E49BE46E576.size] = primary;
  }

  foreach(weaponobj in _id_D39A4E49BE46E576) {
    weaponname = getcompleteweaponname(weaponobj);
    _id_45F93A3BA26BD0B7._id_AC9CAEBED426E625[weaponname] = weaponclipsize(weaponobj);
    _id_45F93A3BA26BD0B7._id_D1AD88BF84DAA67F[weaponname] = self getweaponammostock(weaponobj);

    if(scripts\mp\utility\weapon::isakimbo(weaponobj))
      _id_45F93A3BA26BD0B7._id_734357A0B88E3A30[weaponname] = self getweaponammoclip(weaponobj, "left");

    if(getsubstr(weaponname, 0, 4) == "alt_") {
      continue;
    }
    _id_45F93A3BA26BD0B7._id_BC002676438672C9[_id_45F93A3BA26BD0B7._id_BC002676438672C9.size] = weaponobj;
  }

  _id_A8B87696AB744141 = self getweaponslistoffhands();

  foreach(_id_32D16745C91DBE50 in _id_A8B87696AB744141) {
    if(_id_32D16745C91DBE50.basename == "bandage_br") {
      continue;
    }
    _id_26D3CCFFC7BEBEC9 = self getweaponammoclip(_id_32D16745C91DBE50);

    if(_id_26D3CCFFC7BEBEC9 <= 0) {
      continue;
    }
    _id_45F93A3BA26BD0B7.offhands[_id_45F93A3BA26BD0B7.offhands.size] = _id_32D16745C91DBE50;
    _id_FE758E8B3E5F9EC0 = getcompleteweaponname(_id_32D16745C91DBE50);
    _id_45F93A3BA26BD0B7._id_AC9CAEBED426E625[_id_FE758E8B3E5F9EC0] = _id_26D3CCFFC7BEBEC9;
  }

  foreach(slot, _id_1189BD7FBE2861F8 in self.equipment)
  _id_45F93A3BA26BD0B7._id_00ACA871F9745FC8[_id_1189BD7FBE2861F8] = slot;

  _id_45F93A3BA26BD0B7.super = undefined;

  if(isDefined(self.super) && !self.super.usepercent)
    _id_45F93A3BA26BD0B7.super = self.equipment["super"];

  self._id_45F93A3BA26BD0B7 = _id_45F93A3BA26BD0B7;
}

playerwaittospawn() {
  if(_id_2CEDCC356F1B9FC8::playeriszombie())
    self waittill("spawnZombie");
}

playerreadytospawn() {
  self notify("spawnZombie");
  self _meth_555E2D32E2756625("zombie");
  self setclothtype("cloth");
  scripts\mp\deathicons::hidedeathicon(self);
}

getvalidatedspawnorgangles(origin, dir, dist) {
  startorigin = origin + dir * dist;

  if(_id_45B2B4A889E633FA::iswithinplanepathsaferadius(startorigin)) {
    spawnangles = vectortoangles(dir * -1);
    return [startorigin, spawnangles];
  } else
    return [undefined, undefined];
}

playergetzombiespawnlocation() {
  _id_72541F27D0911A16 = 50;
  _id_DDB70F36E908D6D9 = 10000;

  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent) || istrue(level.brgametype.zombiespawnabovedeath))
    return [self.origin, self getplayerangles()];

  radius = _id_2695A20D4011076D::getdangercircleradius();
  origin = _id_2695A20D4011076D::getdangercircleorigin();
  dist = radius + _id_72541F27D0911A16;
  _id_AC2E1EFDF095AF8C = (self.origin[0], self.origin[1], 0);
  dir = vectorNormalize(_id_AC2E1EFDF095AF8C - origin);
  _id_DDB9B3E2FBE1D70A = dir;
  [startorigin, spawnangles] = getvalidatedspawnorgangles(origin, dir, dist);

  if(!isDefined(startorigin)) {
    dir = dir * -1;
    [startorigin, spawnangles] = getvalidatedspawnorgangles(origin, dir, dist);
  }

  if(!isDefined(startorigin)) {
    dir = (1, 0, 0);
    [startorigin, spawnangles] = getvalidatedspawnorgangles(origin, dir, dist);
  }

  if(!isDefined(startorigin)) {
    dir = (-1, 0, 0);
    [startorigin, spawnangles] = getvalidatedspawnorgangles(origin, dir, dist);
  }

  if(!isDefined(startorigin)) {
    dir = (0, 1, 0);
    [startorigin, spawnangles] = getvalidatedspawnorgangles(origin, dir, dist);
  }

  if(!isDefined(startorigin)) {
    dir = (0, -1, 0);
    [startorigin, spawnangles] = getvalidatedspawnorgangles(origin, dir, dist);
  }

  if(!isDefined(startorigin)) {
    radius = _id_45B2B4A889E633FA::getplanepathsaferadiusfromcenter();
    origin = level.br_level.br_mapcenter;
    origin = origin + _id_45B2B4A889E633FA::_id_01F389456D7C530A();
    dir = vectorNormalize(_id_AC2E1EFDF095AF8C - origin);
    startorigin = origin + dir * radius;
    spawnangles = vectortoangles(dir * -1);
  }

  spawnorigin = _id_2CEDCC356F1B9FC8::droptogroundmultitrace(startorigin, _id_DDB70F36E908D6D9);
  return [spawnorigin, spawnangles];
}

playerzombieprestream(spawnorigin, spawnangles) {
  _id_11F3B4465C8B637B = spawnorigin;

  if(level.brgametype.zombiespawninair) {
    height = getdvarint("dvar_2B1CFE3DD1FA5A38", 10000);
    _id_A6427A6A24F058DC = (0, 0, height);
    spawnorigin = _id_1E4A61DB11011446::getoffsetspawnorigin(spawnorigin, _id_A6427A6A24F058DC);
    spawnpoint = spawnStruct();
    spawnpoint.origin = spawnorigin;
    spawnpoint.angles = spawnangles;
    spawnpoint.height = height;
    _id_11F3B4465C8B637B = _id_5BAB271917698DC4::playerprestreamrespawnorigin(spawnpoint);
  } else {
    self setpredictedstreamloaddist(0.0);
    _id_2CEDCC356F1B9FC8::playerstreamhintlocation(_id_11F3B4465C8B637B);
  }

  return [spawnorigin, _id_11F3B4465C8B637B];
}

playerstreamwaittillcomplete(spawnorigin, spawnangles, _id_11F3B4465C8B637B) {
  _id_5BAB271917698DC4::_id_AB31CF673D70F72D(spawnorigin, spawnangles);
  linker = spawn("script_model", _id_11F3B4465C8B637B);
  linker setModel("tag_origin");
  linker.angles = spawnangles;
  linker hide();
  linker showtoplayer(self);
  self playerlinktoabsolute(linker, "tag_origin");
  self playerhide();
  thread _id_5BAB271917698DC4::playercleanupentondisconnect(linker);
  waitframe();
  _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
  _id_2CEDCC356F1B9FC8::playerclearstreamhintorigin();
  linker.origin = spawnorigin;
  waitframe();
  self unlink();
  self clearsoundsubmix("deaths_door_mp");
  self clearsoundsubmix("fade_to_black_all_except_music_and_scripted5", 2);
  self clearclienttriggeraudiozone(1);
  self playershow();
  _id_BDA1DE83E1856735 = 0;

  if(isDefined(level.parachutedeploydelay))
    _id_BDA1DE83E1856735 = level.parachutedeploydelay;

  thread scripts\cp_mp\parachute::startfreefall(_id_BDA1DE83E1856735, 0, undefined, undefined, 1);
  self setclientomnvar("ui_br_transition_type", 0);
  self setclientomnvar("ui_show_spectateHud", -1);
  _id_5BAB271917698DC4::resetplayermovespeedscale();
  wait 0.5;
  _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
  waitframe();
  linker delete();
  self notify("can_show_splashes");
}

playerzombiedelayturnonfx() {
  self endon("death_or_disconnect");
  self endon("zombie_unset");

  if(level.brgametype._id_437EAAAE9F85F287) {
    self hudoutlinedisable();

    if(!level.brgametype._id_63D9BE743A6BA8CD)
      self setscriptablepartstate("headVFX", "zombieVision");

    self._id_054E863EBAD3E233 = level.brgametype._id_F0435C9DEED2849D;
    self visionsetnakedforplayer(level.brgametype._id_F0435C9DEED2849D, 0);
    thread _id_81E6ECFD4DF39002();
    _id_6FEBC57CCE002A98();
  }

  waitframe();

  if(getdvarint("dvar_D2E09E5CB7C82D3F", 1))
    self setscriptablepartstate("zombie", "on_loop");
  else
    self setscriptablepartstate("zombie", "on");
}

_id_81E6ECFD4DF39002() {
  self endon("disconnect");
  self endon("swim_breathing_disabled_begin");
  self endon("swim_begin");

  if(_id_2CEDCC356F1B9FC8::playeriszombie()) {
    self setclienttriggeraudiozonepartial("player_is_zombie", "ambient");
    scripts\engine\utility::waittill_any_2("zombie_unset", "death");
    self clearclienttriggeraudiozone(1);
  }
}

_id_6FEBC57CCE002A98() {
  _id_54216530F9ADE838 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);
  _id_024AECB67BB3A207 = scripts\mp\utility\teams::getenemyplayers(self.team, 1);

  foreach(player in _id_54216530F9ADE838) {
    scripts\mp\utility\outline::outlineenableforplayer(player, self, "outline_depth_zombievision_friendly", "top");

    if(player _id_2CEDCC356F1B9FC8::playeriszombie())
      scripts\mp\utility\outline::outlineenableforplayer(self, player, "outline_depth_zombievision_friendly", "top");
  }

  foreach(player in _id_024AECB67BB3A207) {
    if(!player _id_2CEDCC356F1B9FC8::playeriszombie())
      scripts\mp\utility\outline::outlineenableforplayer(player, self, "outline_depth_zombievision_enemy", "top");
  }
}

_id_C53D906A08ED3E87() {
  _id_54216530F9ADE838 = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);
  _id_024AECB67BB3A207 = scripts\mp\utility\teams::getenemyplayers(self.team, 1);

  foreach(player in _id_54216530F9ADE838) {
    if(isDefined(player) && player _id_2CEDCC356F1B9FC8::playeriszombie())
      scripts\mp\utility\outline::outlineenableforplayer(self, player, "outline_depth_zombievision_friendly", "top");
  }

  foreach(player in _id_024AECB67BB3A207) {
    if(isDefined(player) && player _id_2CEDCC356F1B9FC8::playeriszombie())
      scripts\mp\utility\outline::outlineenableforplayer(self, player, "outline_depth_zombievision_enemy", "top");
  }
}

playerzombiegasthink() {
  level endon("game_ended");
  self endon("zombie_unset");
  self endon("disconnect");
  self.zombieingas = undefined;

  for(;;) {
    if(playerzombieisingas()) {
      if(!isDefined(self.zombieingas) || !self.zombieingas) {
        self.zombieingas = 1;
        playerzombieentergas();
      }
    } else if(!isDefined(self.zombieingas) || self.zombieingas) {
      self.zombieingas = 0;
      playerzombieexitgas();
    }

    waitframe();
  }
}

playerzombieentergas() {
  self notify("zombie_enter_gas");
  self unsetperk("specialty_radarblip", 1);
}

playerzombieexitgas() {
  self notify("zombie_exit_gas");

  if(level.brgametype.zombiepingrate >= 0) {
    if(level.brgametype.zombiepingrate == 0)
      self setperk("specialty_radarblip", 1);
    else
      thread playerzombiepingoutofgas();
  }
}

playerzombiepingoutofgas() {
  if(level.brgametype.zombiepingrate <= 0) {
    return;
  }
  self endon("zombie_unset");
  self endon("zombie_enter_gas");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self setperk("specialty_radarblip", 1);
    wait(level.brgametype.zombiepingtime);
    self unsetperk("specialty_radarblip", 1);
    wait(level.brgametype.zombiepingrate);
  }
}

playerzombieisingas() {
  if(!isDefined(level.br_circle) || !isDefined(level.br_circle.dangercircleent))
    return 0;

  _id_819EDACDACB810E4 = _id_2695A20D4011076D::getdangercircleorigin();
  _id_E86632D645C137D0 = _id_2695A20D4011076D::getdangercircleradius();
  return distance2dsquared(_id_819EDACDACB810E4, self.origin) > _id_E86632D645C137D0 * _id_E86632D645C137D0;
}

playerzombiesetradar() {
  self endon("disconnect");
  self.skipuavupdate = 1;
  self.radarmode = "normal_radar";
  self.hasradar = 1;
  self waittill("zombie_unset");
  self.skipuavupdate = undefined;
  self.hasradar = 0;
}

playerzombiesupersprint() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");

  for(;;) {
    if(self issupersprinting())
      self refreshsprinttime();

    waitframe();
  }
}

playerzombiehitground(_id_E3438B8CB9C2C515, _id_A2F406096E542298) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");

  if(istrue(self._id_584C38D71AA17739))
    self setscriptablepartstate("skydiveVfx", "enabled_zombie", 0);

  wait 1;

  while(!self isonground() && !self _meth_E40102956C887F7C())
    waitframe();

  self setclientomnvar("ui_br_altimeter_state", 0);
  self skydive_interrupt();
  playFX(level._effect["zombie_splat"], self.origin);
  self playsoundtoplayer("zxp_spawn_splat_plr", self, self);
  self playSound("zxp_spawn_splat_npc", self, self);
  self freezecontrols(1);
  _id_4F8BAD3CFC982AF1 = get_ground_normal(self, 0);

  if(!isDefined(_id_4F8BAD3CFC982AF1))
    _id_4F8BAD3CFC982AF1 = (0, 0, 1);

  _id_543553043475C8C6 = anglesToForward(self.angles);
  _id_B98CF035C97EDEE9 = vectortoangles(_id_4F8BAD3CFC982AF1);
  pitch = angleclamp180(_id_B98CF035C97EDEE9[0] + 90);
  _id_B98CF035C97EDEE9 = (0, _id_B98CF035C97EDEE9[1], 0);
  _id_65667E04420C7105 = anglesToForward(_id_B98CF035C97EDEE9);
  dot = vectordot(_id_65667E04420C7105, _id_543553043475C8C6);
  _id_555A507160626B39 = dot * pitch;
  _id_020ADB86449C4CC7 = getdvarint("dvar_F89852FAF4700EB7", 20);
  _id_A4AD9B2F0F9E5A70 = getdvarint("dvar_6B79DDEF31557A12", -70);

  if(_id_555A507160626B39 > 0)
    _id_555A507160626B39 = min(_id_020ADB86449C4CC7, _id_555A507160626B39);
  else
    _id_555A507160626B39 = max(_id_A4AD9B2F0F9E5A70, _id_555A507160626B39);

  self setplayerangles((_id_555A507160626B39, self.angles[1], 0));

  if(self getcurrentprimaryweapon().classname != "none")
    self forceplaygestureviewmodel("ges_zombie_splat");

  wait 1;
  self skydive_setbasejumpingstatus(0);
  self skydive_setdeploymentstatus(0);
  wait 0.5;
  self freezecontrols(0);
  self freezelookcontrols(1);
  self allowsprint(0);
  thread playerzombiepowers();

  if(!scripts\cp_mp\utility\inventory_utility::iscurrentweapon(_id_E3438B8CB9C2C515))
    childthread _id_1D3F5814F83DD9AC(_id_E3438B8CB9C2C515);

  if(istrue(self._id_584C38D71AA17739)) {
    self._id_584C38D71AA17739 = undefined;
    self setscriptablepartstate("skydiveVfx", "default", 0);
  }

  if(istrue(_id_A2F406096E542298))
    wait 0.5;
  else
    wait 1.0;

  self freezelookcontrols(0);

  if(istrue(_id_A2F406096E542298))
    wait 0.5;
  else
    wait 1.0;

  self allowsprint(1);
}

_id_16B62B803CCF6981(weapon) {
  player = self;
  _id_67243B08ECF2E214 = "Weapon Switch failed! ";

  if(player hasweapon(weapon))
    _id_67243B08ECF2E214 = _id_67243B08ECF2E214 + ("Player has weapon " + getweaponbasename(weapon) + " . ");
  else
    _id_67243B08ECF2E214 = _id_67243B08ECF2E214 + ("Player has NOT weapon " + getweaponbasename(weapon) + " . ");

  currentweapon = player getcurrentweapon();
  _id_03549C153A27C9BD = "none";

  if(isDefined(currentweapon))
    _id_03549C153A27C9BD = getweaponbasename(currentweapon);

  _id_67243B08ECF2E214 = _id_67243B08ECF2E214 + ("CurrentWeapon: " + _id_03549C153A27C9BD + " . ");
  _id_F2445C74EEF451F9 = "none";
  _id_D93FAF2B91E9B072 = player scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon();

  if(isDefined(_id_D93FAF2B91E9B072))
    _id_F2445C74EEF451F9 = getweaponbasename(_id_D93FAF2B91E9B072);

  _id_67243B08ECF2E214 = _id_67243B08ECF2E214 + ("CurrentHighPriorityWeapon: " + _id_F2445C74EEF451F9 + " . ");
  return _id_67243B08ECF2E214;
}

_id_1D3F5814F83DD9AC(weapon) {
  player = self;
  player notify("zxpPlayerWeaponSwitch");
  player endon("zxpPlayerWeaponSwitch");
  _id_4EFC0EF0C515E782 = 1;
  result = player scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(weapon, _id_4EFC0EF0C515E782);
}

ondeadevent(team) {
  if(_id_294DDA4A4B00FFE3::_id_989D407AD1798EB0())
    return 0;

  if(!isDefined(level.brgametype._id_8CFE7F196E21E100))
    level.brgametype._id_8CFE7F196E21E100 = [];

  level.brgametype._id_8CFE7F196E21E100[level.brgametype._id_8CFE7F196E21E100.size] = team;
  return 1;
}

_id_734542E73EEACD3A() {
  level.brgametype._id_8CFE7F196E21E100 = undefined;
}

onplayerdamaged(data) {
  _id_F67C3D8D3E5E4C14 = isDefined(data.attacker) && isDefined(data.attacker._id_92AD976BCD196D41);
  _id_E51A346EBC3D594B = data.victim getentitynumber();
  _id_E255F974B378C965 = _id_F67C3D8D3E5E4C14 && isDefined(data.attacker._id_92AD976BCD196D41.targetdata) && isDefined(data.attacker._id_92AD976BCD196D41.targetdata[_id_E51A346EBC3D594B]) && data.attacker._id_92AD976BCD196D41.targetdata[_id_E51A346EBC3D594B] == data.victim;
  _id_7BFCAD6985F865AC = isPlayer(data.attacker) && data.attacker _id_2CEDCC356F1B9FC8::playeriszombie();

  if(data.victim _id_2CEDCC356F1B9FC8::playeriszombie() && _id_E255F974B378C965)
    data.attacker thread _id_A6E881DADEC5222E(data.victim, data.victim.headicon);

  if(_id_7BFCAD6985F865AC)
    self playSound("zmb_npc_impact_hit");
}

_id_A6E881DADEC5222E(targetent, _id_FAFAA28D217BF19C) {
  level endon("game_ended");
  targetent endon("disconnect");
  entnum = targetent getentitynumber();
  targetent endon("removeHeadIcon_" + entnum);
  notifystring = "removePingOnDamageHeadIcon_" + entnum;
  self notify(notifystring);
  self endon(notifystring);
  targetent waittill("zombie_unset");
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(_id_FAFAA28D217BF19C);
}

setupzombiepowers() {
  if(!level.brgametype.zombiepowersenabled) {
    return;
  }
  level.brgametype.zombie = spawnStruct();
  level.brgametype.zombie.powers = [];
  _id_F9A7592661710983 = level.brgametype._id_52D26462081A2D41 + level.brgametype._id_5A945BE17BF844BD + level.brgametype._id_89B7489C115DC08A;
  addpowerbutton(level.brgametype.zombie, "jump", ["+speed_throw", "+toggleads_throw", "+ads_akimbo_accessible"], ::playerzombiejump, 0, undefined, ::playerzombiejumpcleanup, undefined, &"MP_ZXP/CHARGED_JUMP", undefined, 6, "jumpStatus", "jumpProgress");
  addpowerbutton(level.brgametype.zombie, "jumpStop", ["-speed_throw", "-toggleads_throw", "-ads_akimbo_accessible"], ::playerzombiejumpstop, 0);
  addpowerbutton(level.brgametype.zombie, "gas", "+smoke", ::_id_03287E064CD7027F, 0, ::_id_2418BEAF3229ED30, ::_id_95863013475AD0E9, ::_id_2418BEAF3229ED30, &"MP_ZXP/GAS_GRENADE", undefined, 15, "gasGrenadeStatus", "gasGrenadeProgress");
  addpowerbutton(level.brgametype.zombie, "shout", "+frag", ::_id_7F013D8A91788FDF, 0, undefined, undefined, undefined, &"MP_ZXP/SHOUT", undefined, _id_F9A7592661710983, "shoutStatus", "shoutProgress");

  if(getdvarint("dvar_DA9AA24852C36FD1", 1))
    addpowerbutton(level.brgametype.zombie, "gas_or_shout", ["+equip_toggle_throw"], ::_id_C799021256142C7F, 0, undefined, ::_id_CD06C81E9ADCBEE9);
}

addpowerbutton(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB, _id_918EA1F249A033AE, _id_FB3A9F61FC511DB4, _id_91513A57AA89BE6D, _id_1A5269312D3A0B00, cleanupfunc, _id_7939D347ADE41DA0, label, labelpc, cooldownsec, _id_84F872FF989AAF52, _id_B11F66F8BF2C2553) {
  _id_2AFD19924DAD2B4F = _func_2EF675C13CA1C4AF("dvar_B75FF36B09040395", _id_EF7579BE51267BDB);

  if(getdvarint(_id_2AFD19924DAD2B4F, 1) == 0) {
    return;
  }
  if(isstring(_id_918EA1F249A033AE))
    _id_918EA1F249A033AE = [_id_918EA1F249A033AE];

  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB] = spawnStruct();
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_15DD801166D1AB7F = _id_918EA1F249A033AE;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].func = _id_FB3A9F61FC511DB4;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_1A5269312D3A0B00 = _id_1A5269312D3A0B00;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].cleanupfunc = cleanupfunc;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_7939D347ADE41DA0 = _id_7939D347ADE41DA0;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].label = label;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].labelpc = labelpc;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].cooldownsec = cooldownsec;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52 = _id_84F872FF989AAF52;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_B11F66F8BF2C2553 = _id_B11F66F8BF2C2553;
  _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_91513A57AA89BE6D = _id_91513A57AA89BE6D;
}

_id_C799021256142C7F(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("playerZombieGasOrShout");
  self endon("playerZombieGasOrShout");
  endtime = gettime() + getdvarint("dvar_64480C2E87BC9A43", 500);

  while(endtime > gettime()) {
    if(self secondaryoffhandbuttonPressed()) {
      self notify("gas");
      break;
    } else if(self fragButtonPressed()) {
      self notify("shout");
      break;
    }

    waitframe();
  }
}

_id_7F013D8A91788FDF(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  zombie = self;

  if(!isDefined(zombie)) {
    return;
  }
  zombie._id_3F4318A44CFC517F = undefined;

  if(!zombie _id_72E633A2CADC2F8F()) {
    zombie _id_00E63114420500FB();
    zombie _id_AE8ECF6E5F68F1EA(zombie._id_3F4318A44CFC517F);
    zombie thread _id_F2DDB7C78178C1BE(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
    return;
  }

  if(zombie scripts\mp\utility\weapon::grenadeinpullback())
    zombie _meth_3BB358C91ECD131D();

  zombie thread _id_120695737ABD78F4(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
  zombie thread _id_502603B3A9BDDBC4(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
  zombie thread _id_2726F662B9CD30A8();
}

_id_72E633A2CADC2F8F() {
  zombie = self;

  if(!isDefined(zombie) || !isPlayer(zombie) || !zombie _id_2CEDCC356F1B9FC8::playeriszombie())
    return 0;

  if(zombie _meth_6F55D55CCFF20D14()) {
    zombie._id_3F4318A44CFC517F = "MP_BR_INGAME/ZMB_SHOUT_ERROR_UNDERWATER";
    return 0;
  }

  if(zombie isonladder()) {
    zombie._id_3F4318A44CFC517F = "MP_BR_INGAME/ZMB_SHOUT_ERROR_LADDER";
    return 0;
  }

  return 1;
}

_id_AE8ECF6E5F68F1EA(_id_67243B08ECF2E214) {
  zombie = self;

  if(!isDefined(zombie) || !isPlayer(zombie) || !zombie _id_2CEDCC356F1B9FC8::playeriszombie()) {
    return;
  }
  if(!isDefined(_id_67243B08ECF2E214)) {
    return;
  }
  zombie scripts\mp\hud_message::showerrormessage(_id_67243B08ECF2E214);
}

_id_2726F662B9CD30A8() {
  zombie = self;
  zombie endon("zombie_shout_finished");
  scripts\engine\utility::waittill_any_ents(zombie, "death", zombie, "disconnect", level, "game_ended", zombie, "zombie_unset");

  if(!isDefined(zombie)) {
    return;
  }
  if(istrue(zombie._id_A2906C0A3DA2C192)) {
    stopFXOnTag(level._effect["zombie_shout"], zombie, "j_head");
    stopFXOnTag(level._effect["zombie_shout_shockwaves"], zombie, "tag_origin");
    zombie _meth_ 7 FC894E8A5C5E56(0);

    if(zombie isgestureplaying("ges_zombie_shout"))
      zombie stopgestureviewmodel("ges_zombie_shout");
  }

  if(istrue(zombie._id_750C82BA41F3E2B1)) {
    zombie setscriptablepartstate("zombieBuffVfx", "off", 0);
    zombie setscriptablepartstate("zombieRageVfx", "off", 0);
    zombie.movespeedscaler = 1.0;
    zombie setmovespeedscale(zombie.movespeedscaler);
  }

  zombie._id_A2906C0A3DA2C192 = 0;
  zombie._id_750C82BA41F3E2B1 = 0;
}

_id_502603B3A9BDDBC4(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  zombie = self;

  if(!isDefined(zombie) || !isPlayer(zombie)) {
    return;
  }
  zombie endon("death");
  zombie endon("disconnect");
  zombie endon("zombie_unset");
  level endon("game_ended");
  zombie._id_A2906C0A3DA2C192 = 1;

  if(isDefined(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52))
    _id_936F0EF6E203A7FC(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52, 4);

  zombie _meth_ 7 FC894E8A5C5E56(1);
  zombie forceplaygestureviewmodel("ges_zombie_shout");
  playFXOnTag(level._effect["zombie_shout"], zombie, "j_head");
  playFXOnTag(level._effect["zombie_shout_shockwaves"], zombie, "tag_origin");
  self setscriptablepartstate("zombieRageVfx", "fx_start", 0);
  wait(level.brgametype._id_52D26462081A2D41);
  zombie stopgestureviewmodel("ges_zombie_shout");
  zombie _meth_ 7 FC894E8A5C5E56(0);
  zombie._id_A2906C0A3DA2C192 = 0;
  zombie notify("zombie_shouting_finished");
  zombie._id_750C82BA41F3E2B1 = 1;
  zombie thread _id_74B142AC51E57492();
  self setscriptablepartstate("zombieBuffVfx", "on", 0);
  wait(level.brgametype._id_5A945BE17BF844BD);
  self setscriptablepartstate("zombieBuffVfx", "off", 0);
  self setscriptablepartstate("zombieRageVfx", "fx_end", 0);

  if(isDefined(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52))
    _id_936F0EF6E203A7FC(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52, 1);

  zombie.movespeedscaler = 1.0;
  zombie setmovespeedscale(zombie.movespeedscaler);
  zombie _meth_9354C4C50C43ABC0(zombie.movespeedscaler);
  zombie._id_750C82BA41F3E2B1 = 0;
  zombie notify("zombie_shout_finished");
}

_id_74B142AC51E57492() {
  zombie = self;
  zombie endon("death");
  zombie endon("disconnect");
  zombie endon("zombie_unset");
  zombie endon("zombie_shout_finished");
  level endon("game_ended");

  if(!isDefined(zombie) || !isPlayer(zombie) || !zombie _id_2CEDCC356F1B9FC8::playeriszombie()) {
    return;
  }
  zombie _meth_9354C4C50C43ABC0(level.brgametype._id_2D23E5B9ABED638C);

  for(;;) {
    zombie.movespeedscaler = zombie _id_9AF8AA334971AEB0();

    if(isDefined(zombie.movespeedscaler) && zombie.movespeedscaler > 0)
      zombie setmovespeedscale(zombie.movespeedscaler);

    waitframe();
  }
}

_id_9AF8AA334971AEB0() {
  zombie = self;

  if(!isDefined(zombie) || !isPlayer(zombie) || !zombie _id_2CEDCC356F1B9FC8::playeriszombie())
    return undefined;

  if(zombie _meth_E40102956C887F7C())
    return undefined;

  if(zombie issprintsliding())
    return level.brgametype._id_6225CE8E059E5CE5;

  return level.brgametype._id_695B3601560F5703;
}

_id_C6519D37ADEDCB4F(time) {
  if(isDefined(time))
    wait(time);

  self enableplayerbreathsystem(1);
}

_id_120695737ABD78F4(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  if(level.brgametype._id_A4A60D445462181D)
    self.powershud[_id_EF7579BE51267BDB].barelem scripts\mp\hud_util::updatebar(1.0, 0);
  else
    self.powershud[_id_EF7579BE51267BDB].frac = 1.0;

  thread playerpowerstartcooldown(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
}

_id_CD06C81E9ADCBEE9(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  self notify("playerZombieGasOrShout");
}

playerzombiepowers() {
  if(!level.brgametype.zombiepowersenabled) {
    return;
  }
  thread playerstartpowers(level.brgametype.zombie);
}

playerstartpowers(_id_6C9D93D4584E15F7) {
  thread playerpowerssetupkeybindings(_id_6C9D93D4584E15F7);
  thread playerpowershud(_id_6C9D93D4584E15F7);
  thread playerpowersmonitorinput(_id_6C9D93D4584E15F7);

  if(level.brgametype._id_A4A60D445462181D)
    thread playerpowersupdateongamepadchange(_id_6C9D93D4584E15F7);

  thread _id_539DC27334184E77(_id_6C9D93D4584E15F7);
  thread playerpowerscleanup(_id_6C9D93D4584E15F7);

  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    if(isDefined(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52))
      _id_936F0EF6E203A7FC(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52, 2);
  }
}

_id_2418BEAF3229ED30(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  scripts\mp\equipment::giveequipment("equip_gas_grenade", "secondary");
  scripts\mp\equipment::setequipmentslotammo("secondary", 1);
}

_id_03287E064CD7027F(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  level endon("game_ended");
  self endon("offhand_end");
  self endon("zombie_unset");
  self endon("death_or_disconnect");
  self waittill("grenade_fire", grenade, objweapon, tickpercent, originalowner);

  if(!scripts\mp\utility\weapon::grenadethrown(grenade)) {
    return;
  }
  self playSound("zxp_grenade_vo_npc", self, self);
  thread _id_120695737ABD78F4(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
  wait 0.25;
  _id_95863013475AD0E9(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
  self notify("gas_grenade_finished");
}

_id_95863013475AD0E9(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  scripts\mp\equipment::takeequipment("secondary");
}

playerpowerscleanup(_id_6C9D93D4584E15F7) {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::waittill_any_3("death", "zombie_unset", "zombie_set");
  thread playerpowerresetpowers(_id_6C9D93D4584E15F7);
  thread playerpowerscleanupkeybindings(_id_6C9D93D4584E15F7);
  thread playerpowerscleanuppowers(_id_6C9D93D4584E15F7);
  thread playerpowerscleanuphud(_id_6C9D93D4584E15F7);
}

playerpowerssetupkeybindings(_id_6C9D93D4584E15F7) {
  if(isbot(self)) {
    return;
  }
  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    foreach(binding in _id_8723CFF430A72C82._id_15DD801166D1AB7F)
    self notifyonplayercommand(_id_EF7579BE51267BDB, binding);
  }
}

playerpowerscleanuphud(_id_6C9D93D4584E15F7) {
  if(!isDefined(self.powershud)) {
    return;
  }
  if(level.brgametype._id_A4A60D445462181D) {
    foreach(_id_94480E1669B7FF0D in self.powershud) {
      if(isDefined(_id_94480E1669B7FF0D)) {
        if(isDefined(_id_94480E1669B7FF0D.barelem))
          _id_94480E1669B7FF0D.barelem scripts\mp\hud_util::destroyelem();

        _id_94480E1669B7FF0D destroy();
      }
    }
  }

  self.powershud = undefined;
}

playerpowershud(_id_6C9D93D4584E15F7) {
  _id_6E2C1BD41E3923D6 = 200;
  _id_6D8E1E3CBD28DE50 = 18;
  currenthudy = _id_6E2C1BD41E3923D6;
  self.powershud = [];

  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    if(isDefined(_id_8723CFF430A72C82.label)) {
      if(level.brgametype._id_A4A60D445462181D)
        self.powershud[_id_EF7579BE51267BDB] = playerpowersaddhudelem(_id_8723CFF430A72C82.label, _id_8723CFF430A72C82.labelpc, currenthudy, _id_8723CFF430A72C82._id_91513A57AA89BE6D);
      else {
        self.powershud[_id_EF7579BE51267BDB] = spawnStruct();
        self.powershud[_id_EF7579BE51267BDB].frac = 0;
      }

      self.powershud[_id_EF7579BE51267BDB].incooldown = 0;
      currenthudy = currenthudy + _id_6D8E1E3CBD28DE50;
    }
  }
}

playerpowersaddhudelem(label, labelpc, currenthudy, _id_91513A57AA89BE6D) {
  _id_94480E1669B7FF0D = scripts\mp\hud_util::createfontstring("default", 1.5);
  _id_94480E1669B7FF0D.x = 15;
  _id_94480E1669B7FF0D.y = currenthudy;
  _id_94480E1669B7FF0D.alignx = "left";
  _id_94480E1669B7FF0D.aligny = "top";
  _id_94480E1669B7FF0D.horzalign = "left_adjustable";
  _id_94480E1669B7FF0D.vertalign = "top_adjustable";
  _id_94480E1669B7FF0D.alpha = _id_91513A57AA89BE6D;
  _id_94480E1669B7FF0D.glowalpha = 0;
  _id_94480E1669B7FF0D.hidewheninmenu = 1;
  _id_94480E1669B7FF0D.archived = 0;

  if(isDefined(labelpc) && !scripts\engine\utility::is_player_gamepad_enabled())
    _id_94480E1669B7FF0D.label = labelpc;
  else if(isDefined(label))
    _id_94480E1669B7FF0D.label = label;

  barelem = scripts\mp\hud_util::createbar((1, 1, 1), 160, 14);
  barelem.x = 13;
  barelem.y = currenthudy;
  barelem.alignx = "left";
  barelem.aligny = "top";
  barelem.horzalign = "left_adjustable";
  barelem.vertalign = "top_adjustable";
  barelem.alpha = _id_91513A57AA89BE6D;
  barelem shiftbar();
  barelem.archived = 0;
  barelem.hidewheninmenu = 1;
  barelem.bar.archived = 0;
  barelem.bar.hidewheninmenu = 1;
  barelem.bar.alpha = _id_91513A57AA89BE6D;
  _id_94480E1669B7FF0D.barelem = barelem;
  return _id_94480E1669B7FF0D;
}

shiftbar(point, relativepoint, xoffset, yoffset) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "left";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y + 2;
  self.bar.x = self.x + 2;
  scripts\mp\hud_util::updatebar(self.bar.frac);
}

playerpowerscleanupkeybindings(_id_6C9D93D4584E15F7) {
  if(isbot(self)) {
    return;
  }
  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    foreach(binding in _id_8723CFF430A72C82._id_15DD801166D1AB7F)
    self notifyonplayercommandremove(_id_EF7579BE51267BDB, binding);
  }
}

playerpowerscleanuppowers(_id_6C9D93D4584E15F7) {
  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    if(isDefined(_id_8723CFF430A72C82.cleanupfunc))
      self thread[[_id_8723CFF430A72C82.cleanupfunc]](_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
  }
}

playerpowerresetpowers(_id_6C9D93D4584E15F7) {
  if(!isDefined(_id_6C9D93D4584E15F7) || !isDefined(self.powershud)) {
    return;
  }
  self notify("disableCooldown");

  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    if(!isDefined(self.powershud[_id_EF7579BE51267BDB])) {
      continue;
    }
    self.powershud[_id_EF7579BE51267BDB].incooldown = 0;

    if(level.brgametype._id_A4A60D445462181D)
      self.powershud[_id_EF7579BE51267BDB].barelem scripts\mp\hud_util::updatebar(0, 0);
    else
      self.powershud[_id_EF7579BE51267BDB].frac = 0;

    thread playerpowerstartcooldown(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
  }

  self._id_F07121951BA8E9A5 = undefined;
  self._id_741CB4EDF0F0590C = undefined;
}

_id_561F3BEAF33B80C0(team) {
  if(!isDefined(level.teamdata[team]["aliveCountHuman"]))
    return level.teamdata[team]["aliveCount"];
  else
    return level.teamdata[team]["aliveCountHuman"];
}

kioskreviveplayer(_id_4AC881E2A39322A5, _id_57D71760971F748F) {
  player = self;
  level endon("game_ended");
  player endon("disconnect");
  player notify("gulag_auto_win");
  player notify("zombie_set");
  player notify("zombie_unset");

  if(istrue(player.respawningfromtoken)) {
    return;
  }
  _id_84E2123AACA9A965 = _id_4AC881E2A39322A5;
  _id_DF2FBB13C226BE75 = "token_sponsored";

  if(!isalive(player) && istrue(player.br_iseliminated)) {
    if(!level.brgametype._id_863F6D0E1A1C01E9)
      player playersetisbecomingzombie(1);

    [_id_84E2123AACA9A965, _id_DF2FBB13C226BE75] = _id_5BAB271917698DC4::playerhandlesponsor(_id_4AC881E2A39322A5, _id_57D71760971F748F, 0, 1, 0, "zombiesRevive");
  } else if(istrue(_id_84E2123AACA9A965.hasrespawntoken))
    _id_84E2123AACA9A965 _id_7E52B56769FA7774::removerespawntoken();

  player.respawningfromtoken = 1;
  _id_1476E0F78320A501 = player _id_5BAB271917698DC4::playerwaitforprestreaming();

  if(_id_1476E0F78320A501)
    player scripts\mp\utility\lower_message::setlowermessageomnvar("clear_lower_msg");

  player scripts\mp\hud_message::clearsplashqueue();

  if(level.brgametype._id_863F6D0E1A1C01E9)
    player _id_655264B2E0A7579E::playerzombiebacktohuman(1);
  else
    player playerzombierespawn(0);

  player freezecontrols(0);
  player freezelookcontrols(0);
  player allowsprint(1);
  _id_9D45F503AE900A7D = "br_gulag_kiosk_redeploy";
  _id_1F0A356715870574 = _id_4AC881E2A39322A5;
  player thread scripts\mp\hud_message::showsplash(_id_9D45F503AE900A7D, undefined, _id_4AC881E2A39322A5);
  player.respawningfromtoken = undefined;
}

_id_539DC27334184E77(_id_6C9D93D4584E15F7) {
  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    if(isDefined(_id_8723CFF430A72C82._id_1A5269312D3A0B00))
      self thread[[_id_8723CFF430A72C82._id_1A5269312D3A0B00]](_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
  }
}

playerpowersmonitorinput(_id_6C9D93D4584E15F7) {
  if(isbot(self)) {
    return;
  }
  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers)
  thread _id_A17E5100D67F2109(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
}

_id_A17E5100D67F2109(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_set");
  level endon("game_ended");

  for(;;) {
    self waittill(_id_EF7579BE51267BDB);
    waittillframeend;

    if(isDefined(self.powershud[_id_EF7579BE51267BDB]) && self.powershud[_id_EF7579BE51267BDB].incooldown) {
      _id_00E63114420500FB();
      continue;
    }

    self thread[[_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].func]](_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
  }
}

_id_00E63114420500FB() {
  if(!isDefined(self._id_F07121951BA8E9A5) || gettime() > self._id_F07121951BA8E9A5) {
    self playlocalsound("br_pickup_deny");
    self._id_F07121951BA8E9A5 = gettime() + 1000;
  }
}

playerpowersupdateongamepadchange(_id_6C9D93D4584E15F7) {
  level endon("game_ended");
  self endon("zombie_unset");
  self endon("zombie_set");
  self endon("death_or_disconnect");

  if(isbot(self)) {
    return;
  }
  waittillframeend;
  _id_FD0EFA5C23BE8228 = scripts\engine\utility::is_player_gamepad_enabled();

  for(;;) {
    _id_890736E866204B96 = scripts\engine\utility::is_player_gamepad_enabled();

    if(_id_890736E866204B96 != _id_FD0EFA5C23BE8228) {
      _id_FD0EFA5C23BE8228 = _id_890736E866204B96;

      if(_id_890736E866204B96) {
        foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
          if(isDefined(_id_8723CFF430A72C82.labelpc))
            self.powershud[_id_EF7579BE51267BDB].label = _id_8723CFF430A72C82.label;
        }
      } else {
        foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
          if(isDefined(_id_8723CFF430A72C82.labelpc))
            self.powershud[_id_EF7579BE51267BDB].label = _id_8723CFF430A72C82.labelpc;
        }
      }
    }

    waitframe();
  }
}

playerpowerstartcooldown(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_set");
  self endon("disableCooldown");

  if(!isDefined(self.powershud[_id_EF7579BE51267BDB]) || istrue(self.powershud[_id_EF7579BE51267BDB].incooldown)) {
    return;
  }
  _id_67BF71BF64A4C87F = self.powershud[_id_EF7579BE51267BDB];

  if(level.brgametype.powerscooldown && _id_67BF71BF64A4C87F.frac > 0) {
    self.powershud[_id_EF7579BE51267BDB].incooldown = 1;
    cooldownsec = _id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB].cooldownsec;
    _id_B1F7CE0445D66AC9 = _func_2EF675C13CA1C4AF("dvar_A726FD9FDB5568E5", _id_EF7579BE51267BDB);

    if(getdvarint(_id_B1F7CE0445D66AC9, 0) != 0)
      cooldownsec = getdvarint(_id_B1F7CE0445D66AC9, 0);

    thread _id_90F6FBBB6332DADD(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB, cooldownsec, int(_id_67BF71BF64A4C87F.frac * 100));
    fraction = _id_67BF71BF64A4C87F.frac;
    cooldownsec = cooldownsec * fraction;

    if(level.brgametype._id_A4A60D445462181D) {
      _id_67BF71BF64A4C87F.barelem.bar.color = (1, 0.6, 0);
      _id_67BF71BF64A4C87F.barelem.bar scaleovertime(cooldownsec, 0, _id_67BF71BF64A4C87F.barelem.height);
    }

    wait(cooldownsec);
    _id_6538D60A6FDBA877 = "zxp_restock_" + _id_EF7579BE51267BDB;
    self playlocalsound(_id_6538D60A6FDBA877);
    self.powershud[_id_EF7579BE51267BDB].incooldown = 0;
  } else {
    if(level.brgametype._id_A4A60D445462181D)
      _id_67BF71BF64A4C87F.barelem scripts\mp\hud_util::updatebar(0, 0);
    else
      _id_67BF71BF64A4C87F.frac = 0;

    thread _id_90F6FBBB6332DADD(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB, 0, 0);
  }

  if(level.brgametype._id_A4A60D445462181D)
    _id_67BF71BF64A4C87F.barelem.bar.color = (1, 1, 1);

  if(isDefined(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_7939D347ADE41DA0))
    self[[_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_7939D347ADE41DA0]](_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
}

_id_90F6FBBB6332DADD(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB, cooldownsec, _id_25CCCE114196D19C) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_set");
  self endon("disableCooldown");

  if(!isDefined(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52) || !isDefined(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_B11F66F8BF2C2553)) {
    return;
  }
  _id_936F0EF6E203A7FC(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52, 1);
  _id_5659806E75F89695 = cooldownsec * 1000 * _id_25CCCE114196D19C / 100;
  starttime = gettime();
  endtime = starttime + _id_5659806E75F89695;

  while(gettime() < endtime) {
    _id_A0DFC893004C6EB3 = gettime();
    fraction = (endtime - gettime()) / _id_5659806E75F89695;
    progress = fraction * _id_25CCCE114196D19C;
    _id_936F0EF6E203A7FC(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_B11F66F8BF2C2553, int(progress));
    waitframe();
  }

  _id_936F0EF6E203A7FC(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_B11F66F8BF2C2553, 0);
  _id_936F0EF6E203A7FC(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52, 2);
}

_id_936F0EF6E203A7FC(_id_AC85B79DFC4E45C6, value) {
  if(!istrue(level.brgametype.zombiepowersenabled)) {
    return;
  }
  _id_64571E3AECCD1A07 = 0;
  _id_8534515023AFC188 = 0;

  switch (_id_AC85B79DFC4E45C6) {
    case "jumpStatus":
      _id_64571E3AECCD1A07 = 0;
      _id_8534515023AFC188 = 2;
      break;
    case "jumpProgress":
      _id_64571E3AECCD1A07 = 2;
      _id_8534515023AFC188 = 7;
      break;
    case "shoutStatus":
      _id_64571E3AECCD1A07 = 9;
      _id_8534515023AFC188 = 3;
      break;
    case "shoutProgress":
      _id_64571E3AECCD1A07 = 12;
      _id_8534515023AFC188 = 7;
      break;
    case "gasGrenadeStatus":
      _id_64571E3AECCD1A07 = 19;
      _id_8534515023AFC188 = 2;
      break;
    case "gasGrenadeProgress":
      _id_64571E3AECCD1A07 = 21;
      _id_8534515023AFC188 = 7;
      break;
    case "numVaccine":
      _id_64571E3AECCD1A07 = 28;
      _id_8534515023AFC188 = 2;
      break;
    default:
      break;
  }

  if(!isDefined(level._id_CE83FB46B0B7D8F3))
    level._id_CE83FB46B0B7D8F3 = [];

  if(!isDefined(level._id_CE83FB46B0B7D8F3["ui_br_zombie_powers"]))
    level._id_CE83FB46B0B7D8F3["ui_br_zombie_powers"] = 0;

  mask = int(pow(2, _id_8534515023AFC188)) - 1;
  _id_A463992091F1D483 = (int(value) &mask) << _id_64571E3AECCD1A07;
  _id_F8F977081D3DA8B4 = ~(mask << _id_64571E3AECCD1A07);
  _id_EE27F3F198276535 = self getclientomnvar("ui_br_zombie_powers");
  _id_ED711AEAF5E8CB76 = _id_EE27F3F198276535 &_id_F8F977081D3DA8B4;
  _id_82A90E56E416FA55 = _id_ED711AEAF5E8CB76 + _id_A463992091F1D483;
  level._id_CE83FB46B0B7D8F3["ui_br_zombie_powers"] = _id_82A90E56E416FA55;
  self setclientomnvar("ui_br_zombie_powers", level._id_CE83FB46B0B7D8F3["ui_br_zombie_powers"]);
}

_id_F2DDB7C78178C1BE(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  if(!isDefined(self)) {
    return;
  }
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");

  if(isDefined(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52))
    _id_936F0EF6E203A7FC(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52, 3);

  wait(level.brgametype._id_CA0A3CE7573E0780);

  if(isDefined(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52))
    _id_936F0EF6E203A7FC(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52, 2);
}

playerzombiejump(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  if(!isDefined(self)) {
    return;
  }
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");
  _id_4CA6E232B3A08AE5 = -1;
  self._id_EE75699E65F68166 = undefined;

  if(_id_77BAB0532BC12F0E()) {
    _id_00E63114420500FB();
    _id_AE8ECF6E5F68F1EA(self._id_EE75699E65F68166);
    thread _id_F2DDB7C78178C1BE(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
    return;
  }

  _id_E8B1539C9F6CCBC1 = getdvarfloat("dvar_2FC6C2DC7F9C722A", 1.0);
  _id_EEC1CA5327266614 = getdvarfloat("dvar_F3ADFE2BA0C4E72E", 0.25);
  _id_6B00AA3867C7F0D9 = getdvarint("dvar_69111E35067F9D8F", _id_4CA6E232B3A08AE5);
  _id_57BD73D0ECAEE169 = _id_E8B1539C9F6CCBC1 * level.framedurationseconds;
  self._id_17C60A92AEA65107 = 0.0;
  self allowmelee(0);
  self disableoffhandweapons();
  thread _id_647BA9E9A0D700C7();
  thread _id_7A9B3F5644B41347();
  _id_715D7709363E068C = undefined;
  progress = 0;

  if(!isDefined(self._id_741CB4EDF0F0590C) || gettime() > self._id_741CB4EDF0F0590C) {
    self playlocalsound("zxp_charge_jump_start");
    self._id_741CB4EDF0F0590C = gettime() + 500;
  }

  if(isDefined(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52))
    _id_936F0EF6E203A7FC(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_84F872FF989AAF52, 0);

  while(!_id_77BAB0532BC12F0E()) {
    if(level.brgametype._id_A4A60D445462181D)
      self.powershud[_id_EF7579BE51267BDB].barelem scripts\mp\hud_util::updatebar(self._id_17C60A92AEA65107, 0);
    else
      self.powershud[_id_EF7579BE51267BDB].frac = self._id_17C60A92AEA65107;

    _id_9D6D9B43B9128E64 = self._id_17C60A92AEA65107;
    self._id_17C60A92AEA65107 = self._id_17C60A92AEA65107 + _id_57BD73D0ECAEE169;

    if(self._id_17C60A92AEA65107 >= 1) {
      self._id_17C60A92AEA65107 = 1.0;

      if(_id_6B00AA3867C7F0D9 >= 0) {
        if(!isDefined(_id_715D7709363E068C)) {
          _id_715D7709363E068C = gettime() + _id_6B00AA3867C7F0D9 * 1000;

          if(level.brgametype._id_A4A60D445462181D)
            thread playerzombiejumpmaxholdwarning(_id_EF7579BE51267BDB, _id_6B00AA3867C7F0D9);
        }

        if(gettime() >= _id_715D7709363E068C) {
          break;
        }
      }
    }

    if(level.brgametype._id_A4A60D445462181D && _id_9D6D9B43B9128E64 < _id_EEC1CA5327266614 && self._id_17C60A92AEA65107 >= _id_EEC1CA5327266614)
      self.powershud[_id_EF7579BE51267BDB].barelem.bar.color = (0, 1, 0);

    if(_id_9D6D9B43B9128E64 < 1 && self._id_17C60A92AEA65107 >= 1)
      self playlocalsound("zxp_charge_jump_full");

    if(isDefined(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_B11F66F8BF2C2553)) {
      progress = max(int(self._id_17C60A92AEA65107 * 100), 0);
      _id_936F0EF6E203A7FC(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_B11F66F8BF2C2553, progress);
    }

    waitframe();
  }

  thread _id_A1B195BC24DAE315(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
}

_id_77BAB0532BC12F0E() {
  zombie = self;

  if(!isDefined(zombie) || !isPlayer(zombie) || !zombie _id_2CEDCC356F1B9FC8::playeriszombie())
    return 1;

  if(zombie meleeButtonPressed() || zombie attackButtonPressed()) {
    zombie._id_0E11136ACF00D18F = 1;
    return 1;
  }

  if(zombie getstance() == "prone") {
    zombie._id_EE75699E65F68166 = "MP_BR_INGAME/ZMB_CHARGED_JUMP_ERROR_PRONE";
    return 1;
  }

  if(zombie _meth_6F55D55CCFF20D14()) {
    zombie._id_EE75699E65F68166 = "MP_BR_INGAME/ZMB_CHARGED_JUMP_ERROR_UNDERWATER";
    return 1;
  }

  if(zombie _meth_415FE9EECA7B2E2B()) {
    zombie._id_EE75699E65F68166 = "MP_BR_INGAME/ZMB_CHARGED_JUMP_ERROR_HANGING";
    return 1;
  }

  return 0;
}

_id_D4E7D5BFEDB0B977() {
  if(level.brgametype._id_854EDAEC88CAF865 != 0) {
    end = self.origin + (0, 0, level.brgametype._id_854EDAEC88CAF865);
    result = playerphysicstrace(self.origin, end);

    if(result != end)
      return 0;
  }

  if(level.brgametype._id_854ED7EC88CAF1CC != 0) {
    start = self getEye();
    end = start + (0, 0, level.brgametype._id_854ED7EC88CAF1CC);
    radius = 10;
    height = 20;
    contents = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 0, 1);
    result = scripts\engine\trace::capsule_trace(start, end, radius, height, (0, 0, 0), self, contents);

    if(result["fraction"] != 1)
      return 0;
  }

  return 1;
}

_id_A1B195BC24DAE315(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  self stopgestureviewmodel("ges_zombie_superjumpcharge");
  self notify("playerZombieJumpChargeEnd");
  self notify("playerZombieJumpStop");
  _id_EEC1CA5327266614 = getdvarfloat("dvar_F3ADFE2BA0C4E72E", 0.25);
  _id_E5482B00771C4909 = getdvarint("dvar_2A5201CCBCD3B1A1", 1);
  _id_B13A0E71EF0DE57C = 1;

  if(self._id_17C60A92AEA65107 >= _id_EEC1CA5327266614 && !_id_77BAB0532BC12F0E() && _id_D4E7D5BFEDB0B977() && !self ismantling()) {
    self playsoundtoplayer("zxp_superjump_vo", self, self);
    self playSound("zxp_superjump_sfx_npc", self, self);
    _id_F71D03F58AF1672A = getdvarfloat("dvar_FD6822A1C2607510", 1300);
    _id_DEE6508B0BA437C5 = self getplayerangles();
    thread _id_A3335DA8620D547C();
    playerapplyjumpvelocity(_id_DEE6508B0BA437C5, _id_F71D03F58AF1672A, self._id_17C60A92AEA65107);
    thread _id_DD8A4B0712217000();
    thread _id_46BB895F743DDB94();
    self._id_F07121951BA8E9A5 = undefined;
    self._id_741CB4EDF0F0590C = undefined;
  } else {
    if(_id_E5482B00771C4909) {
      if(level.brgametype._id_A4A60D445462181D)
        self.powershud[_id_EF7579BE51267BDB].barelem.bar.frac = 0;
      else
        self.powershud[_id_EF7579BE51267BDB].frac = 0;

      _id_936F0EF6E203A7FC(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_B11F66F8BF2C2553, 0);
      self enableoffhandweapons();
      self allowmelee(1);
      self notify("endSuperJumpFov");
    }

    _id_00E63114420500FB();
    _id_AE8ECF6E5F68F1EA(self._id_EE75699E65F68166);
    thread _id_F2DDB7C78178C1BE(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);

    if(istrue(self._id_0E11136ACF00D18F)) {
      _id_936F0EF6E203A7FC(_id_6C9D93D4584E15F7.powers[_id_EF7579BE51267BDB]._id_B11F66F8BF2C2553, 100);
      _id_B13A0E71EF0DE57C = 0;
    }
  }

  playerzombiejumpcleanup(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB, _id_B13A0E71EF0DE57C);
}

_id_647BA9E9A0D700C7() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");

  if(self isgestureplaying("ges_zombie_superjumpcharge")) {
    return;
  }
  if(scripts\mp\utility\weapon::grenadeinpullback())
    self _meth_3BB358C91ECD131D();

  while(self ismantling() || self ismeleeing())
    waitframe();

  self forceplaygestureviewmodel("ges_zombie_superjumpcharge");

  while(self isgestureplaying("ges_zombie_superjumpcharge")) {
    if(self isonladder()) {
      self stopgestureviewmodel("ges_zombie_superjumpcharge");
      break;
    }

    waitframe();
  }
}

_id_A3335DA8620D547C() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self allowjump(0);
  self setscriptablepartstate("skydiveVfx", "enabled_zombie", 0);
  wait 0.2;
  self enableoffhandweapons();
  self notify("endSuperJumpFov");
  self forceplaygestureviewmodel("ges_zombie_superjump");
  thread _id_A0810CB7BB46CCDB();

  while(!_id_BD2A29FEEF8F2889())
    waitframe();

  self notify("zombie_jump_complete");
  self stopgestureviewmodel("ges_zombie_superjump");
  self setscriptablepartstate("skydiveVfx", "default", 0);
  self playsoundtoplayer("zxp_splat_plr", self, self);
  self playSound("zmb_npc_breath_land_hi", self, self);
  self playSound("zxp_splat_npc", self, self);
  wait 0.2;
  self allowmelee(1);
  self allowjump(1);
}

_id_A0810CB7BB46CCDB() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_jump_complete");

  for(;;) {
    scripts\engine\utility::waittill_any_2("gas_grenade_finished", "zombie_shouting_finished");
    self forceplaygestureviewmodel("ges_zombie_superjump");
  }
}

_id_BD2A29FEEF8F2889() {
  return self isonground() || self isonladder() || self ismantling() || self _meth_E40102956C887F7C();
}

playerapplyjumpvelocity(_id_44AAE8E966034513, _id_F71D03F58AF1672A, fraction, _id_2AC23F64117A2050) {
  _id_355760D151D56E05 = 1;
  _id_B2D80E99C4EA7F00 = (0, 0, 20);

  if(!isDefined(_id_2AC23F64117A2050))
    _id_2AC23F64117A2050 = _id_B2D80E99C4EA7F00;

  _id_DEE6508B0BA437C5 = _id_44AAE8E966034513;
  _id_AA4EA3B3807E1650 = (0, 0, 1);
  fwd = (1, 0, 0);

  if(getdvarint("dvar_CE6D7D66848CDBCC", _id_355760D151D56E05)) {
    if(istrue(level.brgametype._id_5BA111AE6C83EFFE)) {
      _id_AA4EA3B3807E1650 = get_ground_normal();

      if(!isDefined(_id_AA4EA3B3807E1650))
        _id_AA4EA3B3807E1650 = (0, 0, 1);
    }

    _id_0A2A227242F2C364 = (0, _id_DEE6508B0BA437C5[1], 0);
    right = anglestoright(_id_0A2A227242F2C364);
    fwd = vectorcross(_id_AA4EA3B3807E1650, right);
    _id_829CEAC2F5EC057B = vectortoangles(fwd);
    _id_B184911D23195923 = angleclamp180(_id_829CEAC2F5EC057B[0]);
    _id_98B04C3F8A107752 = -85;
    _id_9D83796E5DFB9A1C = _id_B184911D23195923;
    _id_5A112B1311CF05E5 = _id_DEE6508B0BA437C5[0];

    if(_id_5A112B1311CF05E5 > _id_B184911D23195923)
      _id_5A112B1311CF05E5 = _id_B184911D23195923;

    _id_E6BC250926C6D64D = getdvarfloat("dvar_9EC479015407C245", -45.0);
    _id_E6980F09269E2B33 = getdvarfloat("dvar_9EE78301542E1FFB", 0.0);
    frac = (_id_5A112B1311CF05E5 - _id_98B04C3F8A107752) / (_id_9D83796E5DFB9A1C - _id_98B04C3F8A107752);
    _id_AEE49E405BF58492 = _id_E6980F09269E2B33 + frac * (_id_E6BC250926C6D64D - _id_E6980F09269E2B33);
    _id_DEE6508B0BA437C5 = (_id_5A112B1311CF05E5 + _id_AEE49E405BF58492, _id_DEE6508B0BA437C5[1], _id_DEE6508B0BA437C5[2]);
  }

  _id_179DB9ACB8F30E85 = getdvarfloat("dvar_CF56037C34EA141F", 0.0);

  if(_id_179DB9ACB8F30E85 != 0.0)
    _id_DEE6508B0BA437C5 = (_id_DEE6508B0BA437C5[0] + _id_179DB9ACB8F30E85, _id_DEE6508B0BA437C5[1], _id_DEE6508B0BA437C5[2]);

  dir = anglesToForward(_id_DEE6508B0BA437C5);
  velocity = dir * fraction * _id_F71D03F58AF1672A;
  _id_D917428537562C1F = self.origin + _id_2AC23F64117A2050;
  self setOrigin(_id_D917428537562C1F, 0);
  self setvelocity(velocity);
  glassradiusdamage(self.origin + (0, 0, 30), 30, 50, 51);
  _id_3A4A04B6CA3BF17D = anglesToForward(self.angles);
  _id_CC05C7FA92D3F6BA = self.origin + (0, 0, 30) + _id_3A4A04B6CA3BF17D * 15;
  radiusdamage(_id_CC05C7FA92D3F6BA, 100, 1, 1);
}

_id_DD8A4B0712217000() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  _id_4992594DD7EE57B6 = getdvarfloat("dvar_1DF491267FCC6307", 400.0);

  if(_id_4992594DD7EE57B6 <= 0.0) {
    return;
  }
  maxspeed = getdvarfloat("dvar_A60F6BC28D9BC0C6", 1400.0);
  wait 0.2;

  while(!_id_BD2A29FEEF8F2889()) {
    _id_F619FE4A4E1D4868 = self getnormalizedmovement();

    if(length(_id_F619FE4A4E1D4868) > 0) {
      _id_85680A998F9FA886 = rotatevector((_id_F619FE4A4E1D4868[0], -1.0 * _id_F619FE4A4E1D4868[1], 0), self.angles);
      velocity = self getvelocity();
      speed = length(velocity);
      _id_3B61B63C7E59F697 = _id_85680A998F9FA886 * _id_4992594DD7EE57B6 * level.framedurationseconds;
      _id_4E3D8F59BF0F7030 = velocity + _id_3B61B63C7E59F697;
      _id_EFC4E0686536F8E8 = length(_id_4E3D8F59BF0F7030);

      if(_id_EFC4E0686536F8E8 <= maxspeed)
        self setvelocity(_id_4E3D8F59BF0F7030);
      else if(speed < maxspeed) {
        _id_4E3D8F59BF0F7030 = vectorNormalize(_id_4E3D8F59BF0F7030) * maxspeed;
        self setvelocity(_id_4E3D8F59BF0F7030);
      }
    }

    waitframe();
  }
}

_id_46BB895F743DDB94() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("zombie_jump_complete");
  _id_70E2EFB856B2EEBF = getdvarfloat("dvar_407C08E67D1CB43B", 0.3);

  if(_id_70E2EFB856B2EEBF < 0) {
    return;
  }
  if(_id_70E2EFB856B2EEBF > 0)
    wait(_id_70E2EFB856B2EEBF);

  self _meth_AAA37279040DD667();
}

_id_8FDE79C22DC9F857(_id_D917428537562C1F, velocity, _id_01230EA36A300368, _id_AA4EA3B3807E1650, fwd) {
  level notify("hitVelocity");
  level endon("hitVelocity");
  end = _id_D917428537562C1F + velocity;
  _id_A73107A327311AEF = _id_01230EA36A300368 + _id_AA4EA3B3807E1650 * 20;
  _id_4BE927B6D84B8823 = _id_01230EA36A300368 + fwd * 20;

  for(;;)
    waitframe();
}

playerzombiejumpstop(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  waittillframeend;

  if(isDefined(self._id_17C60A92AEA65107))
    _id_A1B195BC24DAE315(_id_6C9D93D4584E15F7, "jump");
  else
    self notify("playerZombieJumpStop");
}

filterdamage(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc) {
  if(!isDefined(eattacker))
    return undefined;

  if(!istrue(level.brgametype.zombiesdamagezombies) && istrue(eattacker.iszombie) && istrue(victim.iszombie))
    return "zombieFriendlyFire";
}

get_ground_normal(_id_31CAEF840B7AC074, debug) {
  if(!isDefined(_id_31CAEF840B7AC074))
    ignore = self;
  else
    ignore = _id_31CAEF840B7AC074;

  if(!isDefined(debug))
    debug = 0;

  ignorelist = [ignore];
  _id_D895C679F6A927E5 = [self.origin];

  for(_id_AC0E594AC96AA3A8 = -1.0; _id_AC0E594AC96AA3A8 <= 1.0; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 2.0) {
    for(_id_AC0E5C4AC96AAA41 = -1.0; _id_AC0E5C4AC96AAA41 <= 1.0; _id_AC0E5C4AC96AAA41 = _id_AC0E5C4AC96AAA41 + 2.0) {
      _id_4E6D9BE609009734 = ignore getpointinbounds(_id_AC0E594AC96AA3A8, _id_AC0E5C4AC96AAA41, 0.0);
      _id_4E6D9BE609009734 = (_id_4E6D9BE609009734[0], _id_4E6D9BE609009734[1], self.origin[2]);
      _id_D895C679F6A927E5[_id_D895C679F6A927E5.size] = _id_4E6D9BE609009734;
    }
  }

  _id_F863280C4EB41018 = (0, 0, 0);
  _id_97D8F5A9EB04C1F2 = 0;

  foreach(point in _id_D895C679F6A927E5) {
    trace = scripts\engine\trace::_bullet_trace(point + (0, 0, 4), point + (0, 0, -16), 0, ignorelist);
    _id_B68850986D4C6C13 = trace["fraction"] > 0.0 && trace["fraction"] < 1;

    if(_id_B68850986D4C6C13) {
      _id_F863280C4EB41018 = _id_F863280C4EB41018 + trace["normal"];
      _id_97D8F5A9EB04C1F2++;
    }
  }

  if(_id_97D8F5A9EB04C1F2 > 0) {
    _id_F863280C4EB41018 = _id_F863280C4EB41018 / _id_97D8F5A9EB04C1F2;
    return _id_F863280C4EB41018;
  } else
    return undefined;
}

playerzombiejumpcleanup(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB, _id_1FC7E7DDBA5D5771) {
  if(istrue(_id_1FC7E7DDBA5D5771))
    thread playerpowerstartcooldown(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);

  self._id_0E11136ACF00D18F = undefined;
  self._id_17C60A92AEA65107 = undefined;
}

playerzombiejumpmaxholdwarning(_id_EF7579BE51267BDB, time) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");
  self endon("playerZombieJumpChargeEnd");

  if(time <= 0) {
    return;
  }
  _id_2C728360E4C9326A = _id_2695A20D4011076D::array_init_distribute(time, int(time * 5), 1);
  color = 1;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2C728360E4C9326A.size; _id_AC0E594AC96AA3A8++) {
    if(color)
      self.powershud[_id_EF7579BE51267BDB].barelem.bar.color = (1, 0, 0);
    else
      self.powershud[_id_EF7579BE51267BDB].barelem.bar.color = (0, 1, 0);

    wait(_id_2C728360E4C9326A[_id_AC0E594AC96AA3A8]);
    color = !color;
  }
}

playerhumanconcusspushplayer(victim, _id_5991EF3EA72A6543) {
  _id_00F508C8516E132D = 1800;
  inflictor = spawnStruct();
  inflictor.origin = self.origin;
  victim thread scripts\mp\equipment\concussion_grenade::applyconcussion(inflictor, self);
  victim thread playerpowerrestartallcooldowns(level.brgametype.zombie);
  dir = victim.origin - self.origin;
  _id_44AAE8E966034513 = vectortoangles(dir);
  dist = distance(victim.origin, self.origin);
  fraction = 1.0 - dist / _id_5991EF3EA72A6543;
  victim playerapplyjumpvelocity(_id_44AAE8E966034513, _id_00F508C8516E132D, fraction);
}

ignorevehicleexplosivedamage(data) {
  if(isexplosivedamagemod(data.meansofdeath) && data.objweapon.basename == "emp_drone_non_player_direct_mp" || data.objweapon.basename == "emp_drone_non_player_mp" || data.objweapon.basename == "emp_drone_player_mp")
    return 1;
  else
    return 0;
}

playerpowerrestartallcooldowns(_id_6C9D93D4584E15F7) {
  if(!isDefined(_id_6C9D93D4584E15F7)) {
    return;
  }
  self notify("disableCooldown");

  foreach(_id_EF7579BE51267BDB, _id_8723CFF430A72C82 in _id_6C9D93D4584E15F7.powers) {
    if(!isDefined(self.powershud[_id_EF7579BE51267BDB])) {
      continue;
    }
    self.powershud[_id_EF7579BE51267BDB].incooldown = 0;
    thread _id_120695737ABD78F4(_id_6C9D93D4584E15F7, _id_EF7579BE51267BDB);
  }
}

_id_7A9B3F5644B41347() {
  player = self;
  player endon("death_or_disconnect");
  player notify("applyFOVPresentation");
  player endon("applyFOVPresentation");
  player lerpfovbypreset("zombiearcade");
  player waittill("endSuperJumpFov");
  player lerpfovbypreset("zombiedefault");
}

addtoteamlives(player, team) {
  player playerupdatealivecounthuman();
}

removefromteamlives(player, team) {
  player playerupdatealivecounthuman();
}

playerisbecomingzombie() {
  return istrue(self.isbecomingzombie);
}

laststandallowed(damagedata) {
  if(_id_2CEDCC356F1B9FC8::playeriszombie()) {
    _id_EB938D26F29141AA = isDefined(damagedata.attacker) && damagedata.attacker entisvehicle();

    if(!_id_EB938D26F29141AA || !level.brgametype.zombievehiclelaststand)
      return 0;

    thread playerpowerrestartallcooldowns(level.brgametype.zombie);
    thread playerzombielaststandrevive();
    thread playerzombievehiclehittoss(damagedata);
    thread playerzombiedovehicledamageimmunity();
  }

  return 1;
}

playerzombievehiclehittoss(damagedata) {
  _id_33A88760203205C8 = 500;
  _id_7188C5AD86F4BCDB = 90;
  _id_D511B11429292C8A = 60;
  _id_D809DF5FD4884122 = 30;
  _id_0C009F1B4120B07D = damagedata.direction_vec;
  _id_7973EC383855B23B = vectortoyaw(_id_0C009F1B4120B07D);
  _id_EE8D7FD04AE3145C = _id_7188C5AD86F4BCDB;
  _id_517B722235216A01 = _id_D511B11429292C8A;

  if(scripts\engine\utility::cointoss())
    _id_517B722235216A01 = _id_517B722235216A01 * -1;

  _id_517B722235216A01 = _id_517B722235216A01 + _id_7973EC383855B23B;
  _id_50600B9245D45105 = (_id_EE8D7FD04AE3145C, _id_517B722235216A01, 0);
  _id_19468A9F48671D17 = vectorNormalize((_id_0C009F1B4120B07D[0], _id_0C009F1B4120B07D[1], 0));
  _id_2AC23F64117A2050 = _id_19468A9F48671D17 * _id_D809DF5FD4884122 + (0, 0, _id_D809DF5FD4884122);
  playerapplyjumpvelocity(_id_50600B9245D45105, _id_33A88760203205C8, 1.0, _id_2AC23F64117A2050);
}

playerzombiedovehicledamageimmunity() {
  self endon("disconnect");
  self.vehicledamageimmunity = 1;
  duration = getdvarfloat("dvar_E466123B801BD8D4", 1.5);
  wait(duration);
  self.vehicledamageimmunity = undefined;
}

playerzombielaststandrevive() {
  level endon("game_ended");
  self endon("last_stand_finished");
  self endon("death_or_disconnect");
  self waittill("last_stand_transition_done");
  waittillframeend;
  self setlaststandselfreviving(1);
  self.isselfreviving = 1;
  self.laststandreviveent makeunusable();
  _id_6BCC6405C250ECB4 = self.laststandreviveent;
  _id_6BCC6405C250ECB4.usetime = getdvarfloat("dvar_CA5A718F09F3343F", 3.0) * 1000;

  if(!isDefined(_id_6BCC6405C250ECB4.curprogress))
    _id_6BCC6405C250ECB4.curprogress = 0;

  while(scripts\mp\utility\player::isreallyalive(self) && _id_6BCC6405C250ECB4.curprogress < _id_6BCC6405C250ECB4.usetime) {
    if(self isinexecutionvictim()) {
      waitframe();
      continue;
    }

    if(!isDefined(_id_6BCC6405C250ECB4.userate))
      _id_6BCC6405C250ECB4.userate = 0;

    _id_6BCC6405C250ECB4.curprogress = _id_6BCC6405C250ECB4.curprogress + level.frameduration * _id_6BCC6405C250ECB4.userate;
    _id_6BCC6405C250ECB4.userate = 1;
    scripts\mp\gameobjects::updateuiprogress(_id_6BCC6405C250ECB4, 1);

    if(_id_6BCC6405C250ECB4.curprogress >= _id_6BCC6405C250ECB4.usetime) {
      break;
    }

    waitframe();
  }

  _id_6BCC6405C250ECB4.usetime = undefined;
  _id_6BCC6405C250ECB4.curprogress = undefined;
  _id_6BCC6405C250ECB4.userate = undefined;
  scripts\mp\laststand::finishreviveplayer("self_revive_success", self);
  self playsoundtoplayer("zmb_breath_land_dropin", self, self);
  self playSound("zmb_npc_breath_land_dropin");
  self setlaststandselfreviving(0);
}

_id_758E2F92ABFDFDD3(_id_869D699197F920A2, _id_7FD613FA13DEEC82) {
  if(isDefined(self) && isPlayer(self)) {
    if(istrue(_id_7FD613FA13DEEC82))
      scriptables = getentitylessscriptablearray(undefined, undefined, undefined, undefined, _id_869D699197F920A2);
    else
      scriptables = getentitylessscriptablearray("scriptable_" + _id_869D699197F920A2, "classname");

    if(_id_2CEDCC356F1B9FC8::playeriszombie()) {
      foreach(scriptable in scriptables)
      scriptable disablescriptableplayeruse(self);
    } else {
      foreach(scriptable in scriptables)
      scriptable enablescriptableplayeruse(self);
    }
  }
}

_id_E3C3B1FD15E0116A() {
  _id_6E1AB2B17CC36743 = [];

  foreach(team in level.teamnamelist) {
    if(_id_561F3BEAF33B80C0(team) > 0)
      _id_6E1AB2B17CC36743[_id_6E1AB2B17CC36743.size] = team;
  }

  return _id_6E1AB2B17CC36743;
}

postupdategameevents() {
  if(istrue(level.br_debugsolotest) || level.gameended) {
    return;
  }
  _id_6E1AB2B17CC36743 = _id_E3C3B1FD15E0116A();

  if(_id_6E1AB2B17CC36743.size > 1) {
    return;
  }
  _id_037E0FE1F4E33613 = _id_6E1AB2B17CC36743[0];

  if(isDefined(level.brgametype._id_8CFE7F196E21E100)) {
    _id_A9CEB9B39C78FB07 = 0;

    foreach(_id_F90358454413407F in level.teamnamelist) {
      _id_849D01AFB2FC0F0A = _id_1E4A61DB11011446::_id_99E3948BFD8A99B8(_id_F90358454413407F);

      if(_id_849D01AFB2FC0F0A > 0)
        _id_A9CEB9B39C78FB07++;
    }

    teamplacement = _id_A9CEB9B39C78FB07 + 1;
    _id_8CFE7F196E21E100 = scripts\engine\utility::array_reverse(level.brgametype._id_8CFE7F196E21E100);

    foreach(_id_F90358454413407F in _id_8CFE7F196E21E100) {
      _id_1E4A61DB11011446::onsquadeliminatedplacement(_id_F90358454413407F, teamplacement, undefined, 1, 1);
      teamplacement++;
    }
  }

  _id_03784E17637539B8 = scripts\mp\utility\teams::getteamdata(_id_037E0FE1F4E33613, "players");

  foreach(player in _id_03784E17637539B8)
  player _id_655264B2E0A7579E::_id_85AC199ED33991D6();

  _id_93D2F288E29B5DC7(_id_037E0FE1F4E33613);
  thread scripts\mp\gamelogic::endgame(_id_037E0FE1F4E33613, game["end_reason"]["enemies_eliminated"]);
}

_id_93D2F288E29B5DC7(_id_037E0FE1F4E33613) {
  if(!isDefined(_id_037E0FE1F4E33613)) {
    return;
  }
  _id_607DA387F3617ED1 = scripts\mp\utility\teams::getteamdata(_id_037E0FE1F4E33613, "players");

  if(!isDefined(_id_607DA387F3617ED1)) {
    return;
  }
  foreach(_id_8F7040E569EC9E98 in _id_607DA387F3617ED1) {
    if(isDefined(_id_8F7040E569EC9E98) && _id_8F7040E569EC9E98 _id_2CEDCC356F1B9FC8::playeriszombie())
      scripts\cp_mp\challenges::_id_8359CADD253F9604(_id_8F7040E569EC9E98, "zxp_zombie_win", 1);
  }
}

sortbylastzombietime(left, right) {
  _id_10374502ED47925D = level.teamdata[left]["lastZombieTime"];
  _id_1B1911B9658C8A60 = level.teamdata[right]["lastZombieTime"];
  return _id_10374502ED47925D >= _id_1B1911B9658C8A60;
}

_id_E4CFFB22A28408E2() {
  wait 5.0;
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("br_zxp");
}

playerupdatealivecounthuman() {
  team = self.team;
  level.teamdata[team]["aliveCountHuman"] = 0;

  foreach(player in level.teamdata[team]["alivePlayers"]) {
    if(!player _id_2CEDCC356F1B9FC8::playeriszombie() && !player playerisbecomingzombie())
      level.teamdata[team]["aliveCountHuman"]++;
  }
}