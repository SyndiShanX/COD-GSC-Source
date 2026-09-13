/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\events.gsc
***********************************************/

_id_6E80B5DDDED67C23() {
  _id_D442547D75DFFD09 = undefined;

  if(isDefined(level._id_62F6F7640E4431E3)) {
    _id_FA3697898BE9A322 = level._id_62F6F7640E4431E3._id_4C4124986B28EFBB;

    if(isstring(_id_FA3697898BE9A322)) {
      level._id_4C4124986B28EFBB = _id_FA3697898BE9A322;
      _id_D442547D75DFFD09 = getscriptbundle(_func_2EF675C13CA1C4AF("enum_443AF5AE2E8388DE", _id_FA3697898BE9A322));
    }
  }

  if(!isDefined(_id_D442547D75DFFD09))
    _id_D442547D75DFFD09 = _id_15FD33EB83CE9723();

  level._id_27DCAF9644646944 = "stat_DB5FE74CFCEEBFE6";

  if(isDefined(_id_D442547D75DFFD09)) {
    if(istrue(_id_D442547D75DFFD09._id_78B5EC940AAB35E4))
      level._id_27DCAF9644646944 = "stat_44B6AC7B2928D30C";

    scripts\mp\supers::_id_22BFF45FCF920417();
    scripts\mp\supers::_id_18A7C22094077FE9(_id_D442547D75DFFD09._id_719A7B2EE809800A);

    foreach(_id_F90358454413407F in _id_D442547D75DFFD09._id_954E1637C0FE6111)
    _id_E1FB4DFA1DB65CE2(_id_F90358454413407F);

    foreach(_id_F90358454413407F in _id_D442547D75DFFD09._id_A45B64683777600D)
    _id_51E853369BC3F0BF(_id_F90358454413407F);

    foreach(_id_F90358454413407F in _id_D442547D75DFFD09._id_2820C891E54B9AC0)
    _id_51E853369BC3F0BF(_id_F90358454413407F);

    foreach(_id_F90358454413407F in _id_D442547D75DFFD09._id_024A4CF263452716)
    _id_51E853369BC3F0BF(_id_F90358454413407F);

    foreach(_id_F90358454413407F in _id_D442547D75DFFD09._id_064F120E8E17D6A6)
    _id_51E853369BC3F0BF(_id_F90358454413407F);

    foreach(_id_F90358454413407F in _id_D442547D75DFFD09._id_C0778D92E20C4A62)
    _id_51E853369BC3F0BF(_id_F90358454413407F);

    foreach(_id_F90358454413407F in _id_D442547D75DFFD09._id_60C4CDC67F3DAA88)
    _id_51E853369BC3F0BF(_id_F90358454413407F);

    foreach(_id_F90358454413407F in _id_D442547D75DFFD09._id_C865E015A35E7213)
    _id_51E853369BC3F0BF(_id_F90358454413407F);

    foreach(_id_F90358454413407F in _id_D442547D75DFFD09._id_DF30271D78B67BC4)
    _id_51E853369BC3F0BF(_id_F90358454413407F);

    foreach(_id_F90358454413407F in _id_D442547D75DFFD09._id_4D8678EB66DB4DEE)
    _id_51E853369BC3F0BF(_id_F90358454413407F);

    foreach(_id_F90358454413407F in _id_D442547D75DFFD09._id_DC9D1000672BE9FC)
    _id_51E853369BC3F0BF(_id_F90358454413407F);

    foreach(_id_F90358454413407F in _id_D442547D75DFFD09._id_22D3E4C7F898CE16)
    _id_51E853369BC3F0BF(_id_F90358454413407F);

    foreach(_id_F90358454413407F in _id_D442547D75DFFD09._id_8CB7D576AFCBADE5)
    _id_51E853369BC3F0BF(_id_F90358454413407F);
  }

  level._effect["money"] = loadfx("vfx/props/cash_player_drop");
  level.numkills = 0;
  level thread onplayerconnect();
  level thread monitorhealed();

  if(!scripts\mp\utility\game::runleanthreadmode()) {
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawn);
    scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(::monitoradstime);
    scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(::events_monitorslideupdate);
  }

  scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(::updatestancetracking);
}

_id_15FD33EB83CE9723() {
  _id_C8F690457A04A764 = scripts\mp\utility\game::getgametype();

  if(!isDefined(_id_C8F690457A04A764))
    _id_C8F690457A04A764 = getDvar("g_gametype");

  if(_id_C8F690457A04A764 == "brtdm_mgl")
    _id_C8F690457A04A764 = "brtdm";

  scriptbundlename = "score_event_list_" + _id_C8F690457A04A764;

  if(scripts\mp\utility\game::isanymlgmatch()) {
    if(level._id_EC2FB549B15AD827)
      scriptbundlename = "score_event_list_leagueplay_" + _id_C8F690457A04A764;
    else
      scriptbundlename = "score_event_list_cdl_" + _id_C8F690457A04A764;
  }

  if(getdvarint("t10") > 0)
    scriptbundlename = scriptbundlename + "_t10_mp";
  else if(getdvarint("jup") > 0) {
    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
      scriptbundlename = scriptbundlename + "_iw9_mp";
    else
      scriptbundlename = scriptbundlename + "_jup_mp";
  } else if(getdvarint("dvar_3A8BBF8D767FB421") > 0)
    scriptbundlename = scriptbundlename + "_iw9_mp_dmz_biolab";
  else if(getdvarint("score_event_dmz_biobunker") > 0)
    scriptbundlename = scriptbundlename + "_iw9_mp_dmz_biobunker";
  else if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "resurgence")
    scriptbundlename = scriptbundlename + "_iw9_mp_resurgence";
  else if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "resurgence_mgl")
    scriptbundlename = scriptbundlename + "_iw9_mp_resurgence";
  else if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "zonecontrol")
    scriptbundlename = scriptbundlename + "_iw9_mp_zonecontrol";
  else if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "champion")
    scriptbundlename = "score_event_list_br_mgl_mp_champion";
  else if(scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5() == "zxp")
    scriptbundlename = scriptbundlename + "_iw9_mp_zxp";
  else if(_id_C8F690457A04A764 == "conflict")
    scriptbundlename = "score_event_list_conflict_mgl_mp";
  else
    scriptbundlename = scriptbundlename + "_iw9_mp";

  level._id_4C4124986B28EFBB = scriptbundlename;
  _id_D442547D75DFFD09 = getscriptbundle("scoreeventlist:" + scriptbundlename);
  return _id_D442547D75DFFD09;
}

_id_E1FB4DFA1DB65CE2(_id_F90358454413407F) {
  if(!isDefined(_id_F90358454413407F)) {
    return;
  }
  ref = _id_F90358454413407F.ref;

  if(!isDefined(ref) || ref == "") {
    return;
  }
  scripts\mp\rank::_id_4806D99C032B59E9(ref, _id_F90358454413407F._id_98EA5AFB293A76A2);
  group = scripts\engine\utility::_id_53C4C53197386572(_id_F90358454413407F.group, "unassigned");
  scripts\mp\rank::registerscoreinfo(ref, "stat_DC57E42946F6E08C", group);
}

_id_51E853369BC3F0BF(_id_F90358454413407F) {
  if(!isDefined(_id_F90358454413407F)) {
    return;
  }
  ref = _id_F90358454413407F.ref;

  if(!isDefined(ref) || ref == "") {
    return;
  }
  score = scripts\engine\utility::_id_53C4C53197386572(_id_F90358454413407F.score, 0);
  xp = scripts\engine\utility::_id_53C4C53197386572(_id_F90358454413407F.xp, 0);

  if(istrue(_id_F90358454413407F._id_EA8529D33B9E81AA))
    scripts\mp\rank::registerscoreinfo(ref, "stat_6DD3D93BBF03ABC6", 1);

  if(!istrue(_id_F90358454413407F._id_C3D1929B58499072)) {
    if(score == 0 && xp == 0)
      return;
  }

  scripts\mp\rank::registerscoreinfo(ref, "stat_7CE4FD9430E80CEA", score);
  scripts\mp\rank::registerscoreinfo(ref, "stat_08F14807B58DDF35", xp);
  scripts\mp\supers::_id_4D75A970580A253C(ref, _id_F90358454413407F.superpoints);
  _id_C9147B02D8B3DD0A(ref, scripts\mp\hud_message::getsplashtablename());
  group = scripts\engine\utility::_id_53C4C53197386572(_id_F90358454413407F.group, "unassigned");
  scripts\mp\rank::registerscoreinfo(ref, "stat_DC57E42946F6E08C", group);

  if(!istrue(_id_F90358454413407F._id_34044050829EABA9))
    scripts\mp\rank::registerscoreinfo(ref, "stat_90AAF79C829783F5", 1);

  if(istrue(_id_F90358454413407F._id_5B5911ECA3F2426F))
    scripts\mp\rank::registerscoreinfo(ref, "stat_582866801A05178B", 1);
}

_id_C9147B02D8B3DD0A(ref, _id_AFD0D34073D29C5D) {
  eventid = tablelookuprownum(_id_AFD0D34073D29C5D, 0, ref);

  if(eventid < 0) {
    return;
  }
  scripts\mp\rank::registerscoreinfo(ref, "stat_EC3B335BB0B2F752", eventid);
  text = tablelookup(_id_AFD0D34073D29C5D, 0, ref, 2);
  scripts\mp\rank::registerscoreinfo(ref, "stat_FA04F4EF1995407E", text);
  priority = int(tablelookup(_id_AFD0D34073D29C5D, 0, ref, 13));
  scripts\mp\rank::registerscoreinfo(ref, "stat_F5B6EA8C35AC1E89", priority);
  _id_043297BEEE133B22 = int(tablelookup(_id_AFD0D34073D29C5D, 0, ref, 14));
  scripts\mp\rank::registerscoreinfo(ref, "stat_4EA41C9D7136599E", _id_043297BEEE133B22);
  _id_63D0D76D9A02DE46 = tablelookuprownum(_id_AFD0D34073D29C5D, 0, ref);

  if(isDefined(_id_63D0D76D9A02DE46) && _id_63D0D76D9A02DE46 != -1)
    scripts\mp\rank::registerscoreinfo(ref, "stat_5C5EC1055409EBFB", _id_63D0D76D9A02DE46);
}

onplayerspawn() {
  self.jumpcur = 0;
  self.mantlecur = 0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);

    if(!scripts\mp\utility\game::lpcfeaturegated()) {
      player.killedplayers = [];
      player.killedby = [];
    }

    player.lastkilledby = undefined;
    player.greatestuniqueplayerkills = 0;
    player.recentkillcount = 0;
    player._id_05431D89A36B0936 = 0;
    player.recentdefendcount = 0;
    player.recentassaultcount = 0;
    player.lastkilltime = 0;
    player.prevlastkilltime = 0;
    player.lastkilldogtime = 0;

    if(!isDefined(player.pers["lethalEquipmentKillMask"]))
      player.pers["lethalEquipmentKillMask"] = 0;

    player.objectiveachievementkillcount = 0;
    player.damagedplayers = [];
    player initslidemonitor();
    player initmonitoradstime();
    player thread monitorreload();
    player thread monitorweaponpickup();
    player.lastweaponchangetime = 0;
    player initstancetracking();
  }
}

damagedplayer(victim, damage) {
  if(damage < 50 && damage > 10)
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_damaged_light", undefined, 0.1);
  else
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_damaged_heavy", undefined, 0.1);
}

playerworlddeath(attacker, meansofdeath) {
  scripts\mp\potg_events::playerworlddeath(attacker, meansofdeath);
}

killedplayernotifysys(_id_61B5D0250B328F00, victim, objweapon, meansofdeath) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("killedPlayerNotify");
  self endon("killedPlayerNotify");

  if(!isDefined(self.killsinaframecount))
    self.killsinaframecount = 0;

  self.killsinaframecount++;

  if(weaponclass(objweapon) == "spread") {
    if(!isDefined(self.shotgunkillsinaframecount))
      self.shotgunkillsinaframecount = 1;
    else {
      self.shotgunkillsinaframecount++;

      if(self.shotgunkillsinaframecount >= 2)
        shotguncollateral(self.shotgunkillsinaframecount);
    }
  } else if(meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_HEAD_SHOT") {
    if(!isDefined(self.bulletkillsinaframecount))
      self.bulletkillsinaframecount = 1;
    else {
      self.bulletkillsinaframecount++;

      if(self.bulletkillsinaframecount >= 2)
        collateral(self.bulletkillsinaframecount);
    }
  }

  waittillframeend;
  thread notifykilledplayer(_id_61B5D0250B328F00, victim, objweapon, meansofdeath, self.killsinaframecount);
  self.killsinaframecount = 0;
  self.bulletkillsinaframecount = 0;
  self.shotgunkillsinaframecount = 0;
}

notifykilledplayer(_id_61B5D0250B328F00, victim, objweapon, meansofdeath, numkills) {
  weaponname = undefined;

  if(isweapon(objweapon))
    weaponname = getcompleteweaponname(objweapon);
  else
    weaponname = objweapon;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numkills; _id_AC0E594AC96AA3A8++) {
    self notify("got_a_kill", victim, weaponname, meansofdeath);
    waitframe();
  }
}

attackerisinflictor(attacker, inflictor, objweapon, meansofdeath) {
  _id_48D48E9CBD631CE4 = 1;

  if(isDefined(inflictor)) {
    if(isDefined(inflictor.owner))
      _id_48D48E9CBD631CE4 = inflictor.owner == attacker;
    else if(attackerisinflictorforradiusexplosiveweapon(objweapon, inflictor, meansofdeath)) {} else
      _id_48D48E9CBD631CE4 = inflictor == attacker;
  }

  return _id_48D48E9CBD631CE4;
}

attackerisinflictorforradiusexplosiveweapon(objweapon, inflictor, meansofdeath) {
  _id_EC001ADF7F355EFF = 0;

  if(isDefined(objweapon) && isDefined(inflictor.classname) && inflictor.classname == "worldspawn" && meansofdeath == "MOD_EXPLOSIVE") {
    rootweapon = _id_2669878CF5A1B6BC::getweaponrootname(objweapon);
    _id_EC001ADF7F355EFF = rootweapon == "iw9_dm_crossbow";
  }

  return _id_EC001ADF7F355EFF;
}

_id_E6F3A66A2CD9D802(victim, objweapon, meansofdeath, _id_6B7BEE46F2C6DA28, _id_CF4209C200F8BBF4) {
  if(_id_CF4209C200F8BBF4 == "other" || _id_CF4209C200F8BBF4 == "weapon_projectile")
    return 0;

  if(meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_EXPLOSIVE")
    return 0;

  if(_id_6A5D3BF7A5B7064A::_id_549FBFADA3618987()) {
    _id_DB93CD4BB0F89B37 = 0;
    _id_364D34153014E3A6 = 0;

    foreach(guid, attackerdata in victim.attackerdata) {
      if(guid == self.guid) {
        if(_id_6B7BEE46F2C6DA28 == attackerdata.firsttimedamaged)
          _id_DB93CD4BB0F89B37 = 1;
        else
          break;
      } else if(isDefined(attackerdata.lasttimedamaged) && _id_6B7BEE46F2C6DA28 - attackerdata.lasttimedamaged < level._id_1736DE83D797ADC0) {
        _id_364D34153014E3A6 = 1;
        break;
      }
    }

    return _id_DB93CD4BB0F89B37 && !_id_364D34153014E3A6;
  } else {
    if(isDefined(victim.attackers) && victim.attackers.size == 1 && isDefined(victim.guid) && !isDefined(victim.attackers[victim.guid]))
      return _id_6B7BEE46F2C6DA28 == victim.attackerdata[self.guid].firsttimedamaged;

    return 0;
  }
}

_id_B7F154368ABBE463(victim, objweapon, meansofdeath, inflictor, _id_642470E1ABC1BBF9) {
  if(!isDefined(victim)) {
    return;
  }
  if(!isDefined(objweapon)) {
    return;
  }
  if(!isDefined(meansofdeath))
    meansofdeath = "";

  if(!isDefined(inflictor)) {
    return;
  }
  if(!isDefined(_id_642470E1ABC1BBF9)) {
    return;
  }
  self.modifiers = [];
  self.modifiers["mask"] = 0;
  self.modifiers["mask2"] = 0;
  self.modifiers["attachment_flags"] = 0;
  self.modifiers["hit_loc"] = 0;
  _id_6B7BEE46F2C6DA28 = gettime();
  _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(objweapon);
  _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);
  _id_7B9F10ECED207B58 = victim.guid;

  if(!_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon) && !scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    attackerisinflictor = attackerisinflictor(self, inflictor, objweapon, meansofdeath);

    if(isDefined(victim.attackerposition))
      attackerposition = victim.attackerposition;
    else
      attackerposition = self.origin;

    _id_A2C3FEA3986AF52A = anglesToForward(self getplayerangles());
    _id_146F31F6B6666CA7 = victim.origin - attackerposition;
    _id_9669EE24872DD095 = vectorNormalize(_id_146F31F6B6666CA7);
    _id_72705A221874F8A9 = vectordot(_id_A2C3FEA3986AF52A, _id_9669EE24872DD095);
    isbulletdamage = scripts\engine\utility::isbulletdamage(meansofdeath);

    if(meansofdeath == "MOD_EXECUTION") {
      self.modifiers["execution"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 17);
    }

    if(level.numkills == 0) {
      self.modifiers["firstblood"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 33);
    }

    if(isDefined(victim._id_69A9151E7DE440F1)) {
      self.modifiers["victim_has_dmz_bounty"] = 1;
      self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 29);
    }

    if(!isDefined(objweapon) || !isDefined(objweapon.basename) || objweapon.basename == "none") {
      return;
    }
    if(_id_E6F3A66A2CD9D802(victim, objweapon, meansofdeath, _id_6B7BEE46F2C6DA28, _id_CF4209C200F8BBF4) && !istrue(victim._id_B89B3ADA2D19BE6C)) {
      self.modifiers["oneshotkill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 20);
    }

    if(isDefined(self.lastinsmoketime) && self.lastinsmoketime + 5000 > gettime() || isDefined(victim.lastinsmoketime) && victim.lastinsmoketime + 5000 > gettime()) {
      self.modifiers["insmoke"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 22);
    }

    if(scripts\mp\utility\game::runleanthreadmode()) {
      if(scripts\cp_mp\utility\killstreak_utility::teamhasuav_ignorecuav(victim.team)) {
        self.modifiers["enemyHasUAV"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 25);
      }
    } else if(scripts\cp_mp\utility\killstreak_utility::teamhasuav(victim.team)) {
      self.modifiers["enemyHasUAV"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 25);
    }

    if(isDefined(victim.stuckbygrenadeowner) && victim.stuckbygrenadeowner == self) {
      self.modifiers["grenadestuck"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 34);
    }

    if(scripts\mp\utility\game::isassaulting(victim)) {
      self.modifiers["assault"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 35);
      incrementobjectiveachievementkill();
    }

    if(scripts\mp\utility\game::isdefending(victim)) {
      self.modifiers["defender"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 36);
      incrementobjectiveachievementkill();
    }

    if(meansofdeath == "MOD_MELEE") {
      self.modifiers["melee"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 16);

      if(_id_CF4209C200F8BBF4 != "weapon_melee" && _id_CF4209C200F8BBF4 != "weapon_melee2") {
        self.modifiers["gunbutt"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 51);
      }
    }

    _id_F24845EEAEEDC946 = victim getheldoffhand();

    if(_func_F581838CE4328F7A(_id_F24845EEAEEDC946) == "frag_grenade" || _id_F24845EEAEEDC946.basename == "cluster_grenade_mp") {
      self.modifiers["cooking"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 37);
    }

    if(isDefined(self.assistedsuicide) && self.assistedsuicide)
      self.modifiers["assistedsuicide"] = 1;

    if(self.pers["cur_death_streak"] > 3) {
      self.modifiers["comeback"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 38);
    }

    if((meansofdeath == "MOD_HEAD_SHOT" || _id_632BDD4591097AEF(_id_642470E1ABC1BBF9.hitloc) || isxmike109explosiveheadshot(objweapon, _id_642470E1ABC1BBF9) || _id_D355D90BAB289087(objweapon, _id_642470E1ABC1BBF9)) && !istrue(victim._id_06F0B4FE6DA4A0F8)) {
      self.modifiers["headshot"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 0);
    }

    if(isDefined(self.wasti) && self.wasti && _id_6B7BEE46F2C6DA28 - self.spawntime <= 5000)
      self.modifiers["jackintheboxkill"] = 1;

    if(!scripts\mp\utility\player::isreallyalive(self) && isDefined(self.deathtime)) {
      timesincelastdeath = gettime() - self.deathtime;

      if(timesincelastdeath < 1500 && timesincelastdeath > 0) {
        self.modifiers["posthumous"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 39);
      }
    }

    if(level.teambased && isDefined(victim.lastkilltime) && _id_6B7BEE46F2C6DA28 - victim.lastkilltime < 1500) {
      if(isDefined(victim.lastkilledplayer) && victim.lastkilledplayer != self) {
        self.modifiers["avenger"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 44);
      }
    }

    if(isbackkill(self, victim, meansofdeath)) {
      self.modifiers["backstab"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 31);
    }

    if(!istrue(self isnightvisionon())) {
      self.modifiers["withoutnvgs"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 53);
    }

    if(attackerisinflictor) {
      _id_3C709D201F0772AD = getshotdistancetype(self, objweapon, meansofdeath, attackerposition, victim);

      switch (_id_3C709D201F0772AD) {
        case "pointblank":
          self.modifiers["pointblank"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 9);
          break;
        case "longshot":
          self.modifiers["longshot"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 4);
          _id_1FC88419BEC39729 = scripts\engine\math::round_float(distance(attackerposition, victim.origin) / 39.37, 2);
          self setclientomnvar("ui_longshot_dist", _id_1FC88419BEC39729);
          self setclientomnvar("ui_longshot_special", islongshotspecial(attackerposition, victim, objweapon));
          break;
        case "very_longshot":
          self.modifiers["longshot"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 4);
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 41);
          self.modifiers["very_longshot"] = 1;
          _id_1FC88419BEC39729 = scripts\engine\math::round_float(distance(attackerposition, victim.origin) / 39.37, 2);
          self setclientomnvar("ui_longshot_dist", _id_1FC88419BEC39729);
          self setclientomnvar("ui_longshot_special", islongshotspecial(attackerposition, victim, objweapon));
          break;
      }

      if(istrue(self.focus) || isDefined(self._id_054F2B36B0D0243E) && isDefined(self.lastshotfiredtime) && self.lastshotfiredtime == self._id_054F2B36B0D0243E && _id_6B7BEE46F2C6DA28 - self._id_054F2B36B0D0243E <= 6000) {
        self.modifiers["holdingbreath"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 50);
      }

      if(scripts\mp\class::isweaponsilenced(objweapon)) {
        self.modifiers["silencedkill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 13);
      }

      if(victim scripts\mp\weapons::isstunnedorblinded()) {
        self.modifiers["victimimpairedkill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 16);
        self.modifiers["detectedimpairedkill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 15);
      }

      if(_id_8A4D75143273FD07(self, victim)) {
        self.modifiers["detectedimpairedkill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 15);
      }

      if(isDefined(_id_642470E1ABC1BBF9.damageflags) && _id_642470E1ABC1BBF9.damageflags &level.idflags_penetration && !(_id_642470E1ABC1BBF9.damageflags &level.idflags_penetration_player_only)) {
        self.modifiers["coverkill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 14);
      }

      if(scripts\mp\weapons::grenadeheldatdeath())
        self.modifiers["clutchkill"] = 1;

      if(issurvivorkill(self)) {
        self.modifiers["low_health_kill"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 26);
      }

      if(!self isonground())
        self.modifiers["airborne"] = 1;

      if(!victim isonground())
        self.modifiers["victim_airborne"] = 1;

      if(self playermount() >= 0.5) {
        self.modifiers["mounted"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 6);
      }

      if(isbulletdamage) {
        self.modifiers["bullet_damage"] = 1;
        _id_3483795B0A68EB95 = self getweaponammoclip(objweapon);

        if(_id_3483795B0A68EB95 <= 0) {
          self.modifiers["last_bullet_kill"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 18);
        }

        if(scripts\mp\utility\player::isplayerads()) {
          self.modifiers["ads"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 2);
        } else {
          self.modifiers["hipfire"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 3);
        }
      }

      if(victim issprinting()) {
        self.modifiers["victim_sprinting"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 1);
      }

      if(level.teambased) {
        players = scripts\mp\utility\teams::getfriendlyplayers(self.team, 1);

        foreach(player in players) {
          if(player == self) {
            continue;
          }
          if(distancesquared(self.origin, player.origin) < 90000) {
            self.modifiers["buddy_kill"] = 1;
            break;
          }
        }
      }

      if(scripts\mp\weapons::isstunnedorblinded()) {
        self.modifiers["impaired"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 21);
      }

      if(isDefined(self.tookweaponfrom) && isDefined(self.tookweaponfrom[_id_366B0ECC2F28AEAD]) && self.tookweaponfrom[_id_366B0ECC2F28AEAD] == victim) {
        self.modifiers["backfire"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 15);
      }
    } else if(_id_CF4209C200F8BBF4 == "weapon_projectile") {
      if(isDefined(inflictor) && isDefined(inflictor.adsfire)) {
        if(inflictor.adsfire) {
          self.modifiers["ads"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 2);
        } else {
          self.modifiers["hipfire"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 3);
        }
      }
    }

    vehicle = scripts\cp_mp\utility\player_utility::getvehicle(1);

    if(isDefined(vehicle)) {
      self.modifiers["in_vehicle"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 23);

      if(vehicle scripts\common\vehicle::ishelicopter())
        self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 11);
      else if(vehicle.vehiclename == "veh9_mil_lnd_mrap")
        self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 27);
    }

    if(!victim isonground() && !victim iswallrunning() && (!self isonground() && !self iswallrunning())) {
      if(attackerisinflictor)
        self.modifiers["air_to_air_kill"] = 1;
    } else {
      if(attackerisinflictor) {
        if(self iswallrunning())
          self.modifiers["wallkill"] = 1;
        else if(isdeathfromabove(self, objweapon, meansofdeath, attackerposition, victim))
          self.modifiers["jumpkill"] = 1;
        else if(events_issliding()) {
          self.modifiers["slidekill"] = 1;
          self.modifiers["sliding"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 32);
        }

        if(!isDefined(vehicle)) {
          stance = self getstance();

          switch (stance) {
            case "stand":
              self.modifiers["standing_kill"] = 1;
              self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 19);
              break;
            case "prone":
              self.modifiers["prone_kill"] = 1;
              self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 8);
              break;
            case "crouch":
              self.modifiers["crouch_kill"] = 1;
              self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 7);
              break;
          }
        }
      }

      if(victim iswallrunning())
        self.modifiers["killonwall"] = 1;
      else if(isskeetshooter(self, objweapon, meansofdeath, attackerposition, victim))
        self.modifiers["killinair"] = 1;
    }

    if(isDefined(victim.streakdata)) {
      foreach(streakinfo in victim.streakdata.streaks) {
        _id_A43966F605DF8CA3 = streakinfo.currentcost - victim.streakpoints;

        if(_id_A43966F605DF8CA3 > 0 && _id_A43966F605DF8CA3 <= 1) {
          self.modifiers["buzzkill"] = victim.pers["cur_kill_streak"];
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 19);
          break;
        }
      }
    }

    if(!scripts\mp\utility\game::runleanthreadmode()) {
      if(level.teambased) {
        _id_4CB03CEDEB6F7B81 = 0;
        enemies = scripts\mp\utility\teams::getenemyplayers(self.team);

        foreach(enemy in enemies) {
          if(enemy.score > 0) {
            _id_4CB03CEDEB6F7B81 = 1;
            break;
          }
        }

        if(_id_4CB03CEDEB6F7B81) {
          if(is_enemy_highest_score(victim, enemies)) {
            self.modifiers["kingslayer"] = 1;
            self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 42);
          }
        }
      } else {
        _id_4CB03CEDEB6F7B81 = 0;

        foreach(enemy in level.players) {
          if(enemy.score > 0) {
            _id_4CB03CEDEB6F7B81 = 1;
            break;
          }
        }

        if(_id_4CB03CEDEB6F7B81) {
          if(is_enemy_highest_score(victim, level.players)) {
            self.modifiers["kingslayer"] = 1;
            self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 42);
          }
        }
      }
    }

    if(isDefined(inflictor) && istrue(inflictor.isequipment) && meansofdeath == "MOD_IMPACT" && !scripts\mp\utility\weapon::isthrowingknife(objweapon))
      self.modifiers["item_impact"] = 1;

    if(scripts\mp\utility\damage::islauncherdirectimpactdamage(objweapon, meansofdeath))
      self.modifiers["launcher_impact"] = 1;

    if(_id_72705A221874F8A9 >= 0.6428)
      self.modifiers["victim_in_standard_view"] = 1;

    if(isDefined(self.lastadsstarttime) && _id_6B7BEE46F2C6DA28 - self.lastadsstarttime <= 500 && (_id_CF4209C200F8BBF4 == "weapon_sniper" || _id_CF4209C200F8BBF4 == "weapon_dmr")) {
      self.modifiers["quickscope"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 13);
    }

    if(isDefined(self.lastweaponchangetime) && _id_6B7BEE46F2C6DA28 - self.lastweaponchangetime <= 2500) {
      self.modifiers["weapon_change_kill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 14);
    }

    if(isDefined(self.tookweaponfrom) && isDefined(self.tookweaponfrom[_id_366B0ECC2F28AEAD]) && self.tookweaponfrom[_id_366B0ECC2F28AEAD].team != self.team) {
      self.modifiers["weapon_pickup_kill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 5);
    }

    if(isDefined(self.lastreloadtime) && _id_6B7BEE46F2C6DA28 - self.lastreloadtime <= 5000) {
      self.modifiers["reload_kill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 24);
    }

    if(istrue(victim.isdefusing))
      self.modifiers["killed_defuser"] = 1;

    if(istrue(victim.isplanting))
      self.modifiers["killed_planter"] = 1;

    _id_FB9B83072ABF0EC9 = getdvarint("dvar_A0ADE898BFC7AB0E", 0) && scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587();

    if(scripts\mp\utility\weapon::iscacsecondaryweapon(objweapon) || (_id_FB9B83072ABF0EC9 || scripts\mp\utility\perk::_hasperk("specialty_munitions_2")) && isDefined(self.secondaryweaponobj) && objweapon == self.secondaryweaponobj) {
      self.modifiers["secondary_weapon"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 27);
    }

    if(scripts\mp\utility\player::isinlaststand(self)) {
      self.modifiers["last_stand"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 10);
    }

    if(scripts\mp\utility\player::isinlaststand(victim) || istrue(_id_642470E1ABC1BBF9.brvictiminlaststand)) {
      self.modifiers["victim_last_stand"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 11);
    }

    _id_18C8288BC3264B01 = istrue(scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("radiation", "radiation_isInRadiation", victim.origin)) || istrue(scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("biobunker_radiation", "isInBiobunkerRadiationVolume", victim.origin));

    if(istrue(_id_18C8288BC3264B01))
      self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 25);

    _id_E27987BEA6BAD0D6 = istrue(scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("radiation", "radiation_isInRadiation", self.origin)) || istrue(scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2("biobunker_radiation", "isInBiobunkerRadiationVolume", self.origin));

    if(istrue(_id_E27987BEA6BAD0D6))
      self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 30);

    _id_36C12D04A03471D6 = self getmovingplatformparent();

    if(isDefined(_id_36C12D04A03471D6) && _id_36C12D04A03471D6 scripts\cp_mp\vehicles\vehicle::isvehicle() && istrue(_id_36C12D04A03471D6.isheli)) {
      self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 11);
      ref = _id_36C12D04A03471D6 scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD();

      if(ref == "veh9_palfa")
        self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 20);
    }

    if(victim scripts\cp_mp\utility\player_utility::isinvehicle() || isDefined(victim._id_C7C386DFCCF6492F)) {
      self.modifiers["victim_in_vehicle"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 30);
    }

    if(self _meth_A7DE57196F4B5D16()) {
      self.modifiers["vehiclelean"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 55);

      if(vehicle scripts\cp_mp\vehicles\vehicle::_id_D93EC4635290FEBD() == "veh9_sedan_hatchback_1985") {
        self.modifiers["vehiclelean_sedan"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 26);
      }
    }

    if(isDefined(meansofdeath)) {
      switch (meansofdeath) {
        case "MOD_FIRE":
          self.modifiers["fire_damage"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 29);
          break;
        case "MOD_IMPACT":
          self.modifiers["impact_damage"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 28);
          break;
        case "MOD_CRUSH":
          self.modifiers["crush_damage"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 47);
          break;
        default:
          break;
      }
    }

    if(isDefined(objweapon.basename) && issubstr(objweapon.basename, "molotov") || issubstr(objweapon.basename, "thermite") || scripts\cp_mp\dragonsbreath::isdragonsbreathweapon(objweapon) || scripts\cp_mp\crossbow::_id_FC87AFF67FB01E6F(objweapon)) {
      self.modifiers["fire_damage"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 29);
    }

    if(istrue(victim._id_6C66AFBC7F2CE4B0))
      self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 3);

    _id_D4E556C137E61B46 = self;

    for(;;) {
      if((isPlayer(_id_D4E556C137E61B46) || _func_5FAAB6FEF1BAF5AE(_id_D4E556C137E61B46)) && !_id_D4E556C137E61B46 islinked())
        _id_ACF3EB2AF5579D05 = _id_D4E556C137E61B46 getmovingplatformparent(1);
      else
        _id_ACF3EB2AF5579D05 = _id_D4E556C137E61B46 getlinkedparent();

      if(!isDefined(_id_ACF3EB2AF5579D05)) {
        break;
      }

      _id_D4E556C137E61B46 = _id_ACF3EB2AF5579D05;
    }

    if(isDefined(_id_D4E556C137E61B46) && _id_D4E556C137E61B46 scripts\cp_mp\vehicles\vehicle::isvehicle() && (!isDefined(vehicle) || _id_D4E556C137E61B46 != vehicle)) {
      ref = scripts\cp_mp\utility\train_utility::_id_E58B746157089C68(_id_D4E556C137E61B46);

      if(isDefined(ref) && (ref == "cargo_train" || ref == "br_passenger_train")) {
        self.modifiers["ontrain"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 58);

        if(ref == "cargo_train")
          self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 9);
        else if(ref == "br_passenger_train")
          self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 10);
      } else {
        self.modifiers["vehiclesurf"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 56);

        if(_id_D4E556C137E61B46.classname == "script_vehicle" && _id_D4E556C137E61B46 vehicle_getspeed() > 25) {
          self.modifiers["infastvehicle"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 57);
        }
      }
    }

    if(isDefined(inflictor) && isDefined(inflictor.equipmentref)) {
      if(inflictor.equipmentref == "equip_c4" || inflictor.equipmentref == "equip_claymore") {
        stuckto = inflictor getlinkedparent();

        if(isDefined(stuckto) && isDefined(stuckto.helperdronetype) && stuckto.helperdronetype == "radar_drone_recon") {
          self.modifiers["recon_drone_explosive"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 12);

          if(level.challengesallowed && isDefined(stuckto.owner))
            self.recondroneteammate = stuckto.owner;
        } else if(isDefined(stuckto) && stuckto scripts\cp_mp\vehicles\vehicle::isvehicle()) {
          self.modifiers["vehicle_explosive"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 43);

          if(stuckto scripts\common\vehicle::ishelicopter())
            self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 17);
        }
      }
    }

    if(scripts\mp\utility\weapon::isvehicleweapon(objweapon) && meansofdeath == "MOD_EXPLOSIVE") {
      self.modifiers["vehicle_explosive"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 43);

      if(scripts\mp\utility\weapon::_id_858ED945747DFB28(objweapon))
        self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 17);
    }

    if(_id_07C40FA80892A721::hasarmor()) {
      self.modifiers["wearingarmor"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 59);
    }

    if(_id_07C40FA80892A721::_id_9BCA5C1D23A3E0B3()) {
      self.modifiers["fullarmor"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 60);
    }

    _id_831B0DF5DBB687CF = _id_4948CDF739393D2D::_id_C0A211A69F5F8F2F(victim.origin);

    if(isDefined(_id_831B0DF5DBB687CF) && !_id_4948CDF739393D2D::_id_4EC4F39A2E1745F2(_id_831B0DF5DBB687CF)) {
      self.modifiers["victiminstronghold"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 61);

      if(_id_4948CDF739393D2D::_id_771F278C8C749A28(_id_831B0DF5DBB687CF)) {
        self.modifiers["victiminlockedstronghold"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 62);
      }
    }

    if(_id_2CEDCC356F1B9FC8::isplayeringulag()) {
      self.modifiers["in_gulag"] = 1;
      self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 18);
    }

    if(isDefined(victim.origin)) {
      if(isDefined(level._id_A68DCD3B5A82712D)) {
        foreach(struct in level._id_A68DCD3B5A82712D) {
          dist = distance2d(struct.origin, victim.origin);

          if(dist <= struct.radius)
            self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 5);
        }
      }

      if(isDefined(level._id_116A5F32AEB86391) && isDefined(self.team)) {
        foreach(instance in level._id_116A5F32AEB86391) {
          if(isDefined(instance._id_DCC5F31EC71D6D8A) && instance._id_DCC5F31EC71D6D8A == self.team) {
            dist = distance2d(instance.origin, victim.origin);

            if(dist <= level._id_6ACF91BBF5273E8F)
              self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 6);
          }
        }
      }
    }

    _id_E951084886B44231 = objweapon issilenced();

    if(istrue(_id_E951084886B44231))
      self.modifiers["attachment_flags"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["attachment_flags"], 0);

    if(isDefined(objweapon.scope)) {
      _id_7A4444EFA68407FA = objweapon.scope;
      _id_1439F86640D42E34 = _func_7C612AC92BA98DCB(objweapon, _id_7A4444EFA68407FA);

      if(_id_1439F86640D42E34 == "ironsdefault")
        self.modifiers["attachment_flags"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["attachment_flags"], 4);
      else if(_id_1439F86640D42E34 == "reflex" || _id_1439F86640D42E34 == "minireflex")
        self.modifiers["attachment_flags"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["attachment_flags"], 7);
      else if(_id_1439F86640D42E34 == "hybrid")
        self.modifiers["attachment_flags"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["attachment_flags"], 3);
      else if(_id_1439F86640D42E34 == "acog")
        self.modifiers["attachment_flags"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["attachment_flags"], 6);
      else if(_id_1439F86640D42E34 == "holo")
        self.modifiers["attachment_flags"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["attachment_flags"], 5);

      if(_func_EC9CD761DF1A3271(objweapon, _id_7A4444EFA68407FA))
        self.modifiers["attachment_flags"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["attachment_flags"], 1);
    }

    if(isDefined(objweapon) && isDefined(self.team)) {
      team = _id_724736FCF0FB6604::_id_1A561E5EF2ECA63A(self, objweapon);

      if(isDefined(team) && team != self.team)
        self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 12);
    }
  }

  if(istrue(objweapon.isalternate)) {
    self.modifiers["isaltmode"] = 1;
    self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 24);
  }

  if(isDefined(self.lastkilledby) && self.lastkilledby == victim) {
    self.modifiers["revenge"] = 1;
    self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 40);
  }

  _id_56521B8795115DEB = getnemesis();

  if(_id_56521B8795115DEB.size > 0) {
    foreach(guid in _id_56521B8795115DEB) {
      if(_id_7B9F10ECED207B58 == guid) {
        self.modifiers["killedNemesis"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 45);
        break;
      }
    }
  }

  if(self _meth_E40102956C887F7C()) {
    self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 52);

    if(self _meth_6F55D55CCFF20D14())
      self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 4);
  }

  if(isagent(victim)) {
    if(victim getthreatsight(self) < 1)
      self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 28);
  }

  hitloc = 0;

  if(scripts\cp_mp\utility\damage_utility::validshotcheck(meansofdeath, self)) {
    switch (_id_642470E1ABC1BBF9.hitloc) {
      case "none":
        hitloc = 0;
        break;
      case "helmet":
        hitloc = 1;
        break;
      case "head":
        hitloc = 2;
        break;
      case "neck":
        hitloc = 3;
        break;
      case "upper_torso":
        hitloc = 4;
        break;
      case "left_arm_upper":
        hitloc = 6;
        break;
      case "right_arm_upper":
        hitloc = 7;
        break;
      case "left_arm_lower":
        hitloc = 8;
        break;
      case "right_arm_lower":
        hitloc = 9;
        break;
      case "left_hand":
        hitloc = 10;
        break;
      case "right_hand":
        hitloc = 11;
        break;
      case "left_leg_upper":
        hitloc = 12;
        break;
      case "right_leg_upper":
        hitloc = 13;
        break;
      case "left_leg_lower":
        hitloc = 14;
        break;
      case "right_leg_lower":
        hitloc = 15;
        break;
      case "left_foot":
        hitloc = 16;
        break;
      case "right_foot":
        hitloc = 17;
        break;
      case "gun":
        hitloc = 18;
        break;
      case "shield":
        hitloc = 19;
        break;
      case "armor":
        hitloc = 20;
        break;
      case "soft":
        hitloc = 21;
        break;
    }
  }

  self.modifiers["hit_loc"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["hit_loc"], hitloc);

  if(istrue(self._id_859654E0445A36D9))
    self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 7);

  if(self _meth_B02C8E799779BC10(victim getentitynumber()))
    self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 8);

  if(_id_CF4209C200F8BBF4 == "other")
    checklethalequipmentachievement(objweapon);
}

killedplayer(_id_61B5D0250B328F00, victim, objweapon, meansofdeath, inflictor, _id_642470E1ABC1BBF9) {
  _id_6B7BEE46F2C6DA28 = gettime();

  if(!isDefined(objweapon)) {
    objweapon = makeweapon("none");
    _id_7CD970F4AF82282C = "killedPlayer called with undefined weapon\n";
    _id_7CD970F4AF82282C = _id_7CD970F4AF82282C + ("killId = " + _id_61B5D0250B328F00 + "\n");
    _id_7CD970F4AF82282C = _id_7CD970F4AF82282C + ("victim.clientid = " + victim.clientid + "\n");
    _id_7CD970F4AF82282C = _id_7CD970F4AF82282C + ("inflictor.clientid = " + inflictor.clientid + "\n");
    _id_7CD970F4AF82282C = _id_7CD970F4AF82282C + ("meansOfDeath = " + meansofdeath + "\n");
    _id_7CD970F4AF82282C = _id_7CD970F4AF82282C + ("victim.origin = " + victim.origin + "\n");
  }

  objweapon = scripts\cp_mp\utility\weapon_utility::_id_1E3102980C3A4CC1(objweapon);
  _id_B7F154368ABBE463(victim, objweapon, meansofdeath, inflictor, _id_642470E1ABC1BBF9);

  if(istrue(victim.islaststandbleedoutdmg) && isDefined(victim.laststandattackermodifiers))
    self.modifiers = victim.laststandattackermodifiers;

  checkkillstreakkillevents(objweapon, meansofdeath, inflictor);
  thread checkfinalkillachievements(victim);
  _id_7B9F10ECED207B58 = victim.guid;
  _id_5155CBAA6170E292 = self.guid;
  _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);
  thread killedplayernotifysys(_id_61B5D0250B328F00, victim, objweapon, meansofdeath);
  thread updaterecentkills(_id_61B5D0250B328F00, victim, objweapon, _id_366B0ECC2F28AEAD);
  thread updatec4vehiclemultkill(meansofdeath, inflictor);
  thread updateghostridekills();
  thread updatequadfeedcounter(self, _id_61B5D0250B328F00);
  self.prevlastkilltime = self.lastkilltime;
  self.lastkilltime = _id_6B7BEE46F2C6DA28;
  self.lastkilledplayer = victim;
  self.lastkillvictimpos = victim.origin;

  if(!isDefined(level.numkills))
    level.numkills = 0;
  else
    level.numkills++;

  if(self.deaths > 0) {
    _id_1C8AD3040C864084 = self.kills / self.deaths;

    if(_id_1C8AD3040C864084 > 3.0)
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_kd_high", undefined, 0.75);
  } else if(self.kills > 5)
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_kd_high", undefined, 0.75);

  if(istrue(self.laststanding))
    scripts\mp\utility\stats::incpersstat("clutch", 1);

  self.damagedplayers[_id_7B9F10ECED207B58] = undefined;
  _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(objweapon.basename);
  _id_EFDB9FE54D750E6D(victim);

  if(istrue(self.modifiers["firstblood"]))
    firstblood(_id_61B5D0250B328F00);

  if(istrue(self.modifiers["execution"]))
    execution(_id_61B5D0250B328F00);

  if(_id_728FFCEE8CBF30EE::_id_8EF404291EA37583(victim))
    _id_728FFCEE8CBF30EE::_id_E01BC5DBA2DA7D6A(victim);

  if(!_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename) && !scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    if(objweapon.basename == "none" && meansofdeath != "MOD_EXECUTION")
      return 0;

    attackerisinflictor = attackerisinflictor(self, inflictor, objweapon, meansofdeath);

    if(istrue(self.modifiers["oneshotkill"])) {
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_D3BB96C8BD6EFD71");
      scripts\mp\utility\stats::incpersstat("oneShotOneKills", 1);
    }

    if(istrue(self.modifiers["gunbutt"]))
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_020FBB2528F21BD3");

    if(meansofdeath == "MOD_MELEE") {
      if(objweapon.basename == "iw9_me_fists_mp")
        thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_D3DD8A69E4A03838");
    }

    if(istrue(self.modifiers["assistedsuicide"]))
      assistedsuicide(_id_61B5D0250B328F00, objweapon);

    if(istrue(self.modifiers["comeback"]))
      comeback(_id_61B5D0250B328F00);

    if(istrue(self.modifiers["headshot"])) {
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_headshot", undefined, 0.75);
      headshot(_id_61B5D0250B328F00);
    }

    if(isDefined(self.vehicle) && isDefined(self.vehicle._id_8BB6B9B919C2C19D))
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_6D65A58E1DE667E1");

    if(istrue(self.modifiers["posthumous"]))
      postdeathkill(_id_61B5D0250B328F00);

    if(!scripts\mp\utility\player::isreallyalive(self) && isDefined(self.deathtime)) {
      timesincelastdeath = gettime() - self.deathtime;

      if(scripts\mp\utility\game::issimultaneouskillenabled()) {
        if(timesincelastdeath == 0 && isDefined(self.lastattacker) && self.lastattacker == victim) {
          thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_992BAA42F95D6A55", undefined, undefined, undefined, undefined, 1);
          victim thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_992BAA42F95D6A55", undefined, undefined, undefined, undefined, 1);
        }
      }
    }

    if(istrue(self.modifiers["avenger"]))
      avengedplayer(_id_61B5D0250B328F00, victim.lastkilledplayer);

    _id_5737B6F741A2CFD9 = undefined;

    if(victim isinexecutionattack()) {
      _id_C962A2C5D41D3887 = scripts\common\utility::playersnear(victim.origin, 300);

      foreach(player in _id_C962A2C5D41D3887) {
        if(player.team == self.team && player isinexecutionvictim()) {
          _id_5737B6F741A2CFD9 = player.guid;
          defendedplayer(_id_61B5D0250B328F00, player.guid);
          break;
        }
      }
    }

    foreach(guid, _id_C42F14360A123E9D in victim.damagedplayers) {
      if(guid == self.guid || guid == victim.guid) {
        continue;
      }
      if(isDefined(_id_5737B6F741A2CFD9) && guid == _id_5737B6F741A2CFD9) {
        continue;
      }
      if(level.teambased && _id_6B7BEE46F2C6DA28 - _id_C42F14360A123E9D < 1750)
        defendedplayer(_id_61B5D0250B328F00, guid);
    }

    if(istrue(self.modifiers["pointblank"]))
      thread pointblank(_id_61B5D0250B328F00);

    if(istrue(self.modifiers["longshot"]))
      thread longshot(_id_61B5D0250B328F00);

    if(istrue(self.modifiers["very_longshot"]))
      thread very_longshot(_id_61B5D0250B328F00);

    if(istrue(self.modifiers["backstab"])) {
      if(objweapon.basename == "iw8_knife_mp")
        thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_ACEEE63CB46A233A");
    }

    if(istrue(self.modifiers["silencedKill"]))
      scripts\mp\utility\stats::incpersstat("silencedKills", 1);

    if(attackerisinflictor) {
      switch (weaponclass(objweapon.basename)) {
        case "rifle":
          scripts\mp\utility\stats::incpersstat("arKills", 1);
          victim scripts\mp\utility\stats::incpersstat("arDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT")
            scripts\mp\utility\stats::incpersstat("arHeadshots", 1);

          break;
        case "smg":
          scripts\mp\utility\stats::incpersstat("smgKills", 1);
          victim scripts\mp\utility\stats::incpersstat("smgDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT")
            scripts\mp\utility\stats::incpersstat("smgHeadshots", 1);

          break;
        case "spread":
          scripts\mp\utility\stats::incpersstat("shotgunKills", 1);
          victim scripts\mp\utility\stats::incpersstat("shotgunDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT")
            scripts\mp\utility\stats::incpersstat("shotgunHeadshots", 1);

          break;
        case "mg":
          scripts\mp\utility\stats::incpersstat("lmgKills", 1);
          victim scripts\mp\utility\stats::incpersstat("lmgDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT")
            scripts\mp\utility\stats::incpersstat("lmgHeadshots", 1);

          break;
        case "sniper":
          scripts\mp\utility\stats::incpersstat("sniperKills", 1);
          victim scripts\mp\utility\stats::incpersstat("sniperDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT")
            scripts\mp\utility\stats::incpersstat("sniperHeadshots", 1);

          break;
        case "rocketlauncher":
          scripts\mp\utility\stats::incpersstat("launcherKills", 1);
          victim scripts\mp\utility\stats::incpersstat("launcherDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT")
            scripts\mp\utility\stats::incpersstat("launcherHeadshots", 1);

          break;
        case "pistol":
          scripts\mp\utility\stats::incpersstat("pistolKills", 1);
          victim scripts\mp\utility\stats::incpersstat("pistolPeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT")
            scripts\mp\utility\stats::incpersstat("pistolHeadshots", 1);

          break;
      }

      if(meansofdeath == "MOD_MELEE") {
        scripts\mp\utility\stats::incpersstat("meleeKills", 1);
        victim scripts\mp\utility\stats::incpersstat("meleeDeaths", 1);
      }

      if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
        foreach(drone in level.supportdrones) {
          if(drone.owner == self && drone.helperdronetype == "radar_drone_overwatch") {
            drone.owner scripts\mp\utility\stats::incpersstat("killstreakPersonalUAVKills", 1);
            break;
          }
        }
      }

      if(istrue(self.modifiers["low_health_kill"])) {
        thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_0358D0D85E7B1851");
        level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_2F4FCDB5F53AF5CA", undefined, 1);
      }

      if(istrue(self.modifiers["ads"]))
        scripts\mp\utility\stats::incpersstat("adsKills", 1);
      else if(istrue(self.modifiers["hipfire"]))
        scripts\mp\utility\stats::incpersstat("hipfireKills", 1);

      if(self ismantling())
        mantlekill();

      if(istrue(self.modifiers["backfire"]))
        backfire();
    }

    if(istrue(self.modifiers["air_to_air_kill"]))
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_0585359FB294F2C3");

    if(istrue(self.modifiers["wallkill"]))
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_6D681BB42E1AC28F");

    if(istrue(self.modifiers["jumpkill"]))
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_77BDA5EA2C97FBD8");

    if(istrue(self.modifiers["sliding"]))
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_AF4AB7B4B90C051B");

    if(istrue(self.modifiers["killonwall"]))
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_A7776242889BF154");

    if(istrue(self.modifiers["killinair"]))
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_37C5D5F71008DB1D");

    if(istrue(self.modifiers["buzzkill"]))
      buzzkill(_id_61B5D0250B328F00, victim);

    if(istrue(self.modifiers["impaired"]))
      impairedkill();

    if(isDefined(victim.stuckbygrenade))
      level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_semtex", undefined, 0.75);

    if(scripts\mp\utility\weapon::isthrowingknife(objweapon.basename))
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_123320811BF44B63");

    if(scripts\mp\gamescore::isdebuffedbyweaponandplayer(self, victim, "decoy_grenade_mp"))
      scripts\mp\rank::scoreeventpopup("stat_B2F4241375A3DC69");

    if(istrue(self.modifiers["kingslayer"]) && scripts\mp\utility\game::getgametype() != "ballmode") {
      kingslayer(_id_61B5D0250B328F00);

      if(scripts\mp\utility\game::getgametype() == "gun" && meansofdeath == "MOD_MELEE")
        thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_FE6243D280C9E5CF");
    }

    if(self.score < victim.score)
      scripts\mp\utility\stats::incpersstat("higherRankedKills", 1);
    else
      scripts\mp\utility\stats::incpersstat("lowerRankedKills", 1);

    _id_B96DBC6F3068658D = self.pers["cur_kill_streak"] + 1;
    _id_962DA519C8067AAD = 5;

    if(level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "risk" || level.gametype == "brtdm" || level.gametype == "brtdm_mgl")
      _id_962DA519C8067AAD = 10;

    if(!(_id_B96DBC6F3068658D % _id_962DA519C8067AAD)) {
      if(!isDefined(self.lastkillsplash) || _id_B96DBC6F3068658D != self.lastkillsplash) {
        thread scripts\mp\hud_util::teamplayercardsplash("callout_kill_streaking", self, undefined, _id_B96DBC6F3068658D);
        self.lastkillsplash = _id_B96DBC6F3068658D;
      }

      if(_id_B96DBC6F3068658D <= 30)
        thread scripts\mp\utility\points::_id_0366980B6A8796AE(_func_2EF675C13CA1C4AF("stat_81E00C932D6CB164", _id_B96DBC6F3068658D));
    }

    if(_id_B96DBC6F3068658D > 30)
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_1236123912008792");

    if(istrue(self.modifiers["item_impact"]))
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_29065087E352EB71");

    if(istrue(self.modifiers["launcher_impact"]))
      directimpactkill();

    if(scripts\mp\utility\game::getgametypenumlives() >= 1) {
      if(victim.pers["lives"] == 0)
        thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_0C1F0EC4C332C192", undefined, undefined, undefined, victim);

      _id_7774F401143EECCF = scripts\mp\utility\game::trygetlastpotentiallivingplayer();

      if(isDefined(_id_7774F401143EECCF) && _id_7774F401143EECCF == self)
        thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_A3E7EBF904A38850", undefined, undefined, undefined, victim);
    }

    if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && scripts\mp\flags::gameflag("prematch_done")) {
      if(self ispcplayer())
        self setclientomnvar("nVidiaHighlights_events", 25);

      if(victim ispcplayer())
        victim setclientomnvar("nVidiaHighlights_events", 26);
    }

    checksuperkillevents(victim, inflictor, objweapon, meansofdeath, _id_366B0ECC2F28AEAD);
    checksupershutdownevents(victim, objweapon, meansofdeath);
  }

  _id_E2ADEC8D28854D3F = 0;

  if(isDefined(victim.damagedplayers) && victim.damagedplayers.size != 0) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < victim.damagedplayers.size; _id_AC0E594AC96AA3A8++) {
      damagedplayer = _func_5162A2AAAD39B2C7(victim.damagedplayers, _id_AC0E594AC96AA3A8);

      if(isDefined(inflictor) && scripts\engine\utility::is_equal(damagedplayer, inflictor.guid)) {
        _id_E2ADEC8D28854D3F = 1;
        break;
      }
    }
  }

  if(!_id_E2ADEC8D28854D3F)
    _id_08D62D448FC0010E();

  if(istrue(self.modifiers["revenge"])) {
    self.lastkilledby = undefined;
    revenge(_id_61B5D0250B328F00, victim);
  }

  if(!scripts\mp\utility\game::lpcfeaturegated()) {
    if(!isDefined(self.killedplayers[_id_7B9F10ECED207B58]))
      self.killedplayers[_id_7B9F10ECED207B58] = 0;

    if(!isDefined(victim.killedby[_id_5155CBAA6170E292]))
      victim.killedby[_id_5155CBAA6170E292] = 0;

    self.killedplayers[_id_7B9F10ECED207B58]++;
    victim.killedby[_id_5155CBAA6170E292]++;
  }

  victim.lastkilledby = self;

  if(!scripts\mp\utility\game::lpcfeaturegated() && !level.multiteambased) {
    _id_BE2203D59EE928B6 = 0;

    if(level.teambased)
      _id_BE2203D59EE928B6 = scripts\mp\utility\teams::getenemycount(self.team);
    else
      _id_BE2203D59EE928B6 = level.players.size - 1;

    if(_id_BE2203D59EE928B6 > 3 && self.killedplayers.size == _id_BE2203D59EE928B6) {
      _id_3E955591D6FEBC8D = 0;

      if(isDefined(self.pers["killEnemyTeam"]))
        _id_3E955591D6FEBC8D = self.pers["killEnemyTeam"];

      _id_F0002BF98C633919 = 1;

      foreach(player, killcount in self.killedplayers) {
        if(killcount <= _id_3E955591D6FEBC8D) {
          _id_F0002BF98C633919 = 0;
          break;
        }
      }

      if(_id_F0002BF98C633919)
        killentireenemyteam(_id_61B5D0250B328F00);
    }
  }

  if(!victim scripts\mp\utility\player::isusingremote())
    victim thread scripts\mp\utility\player::setdof_killer();

  victim _id_1CF2ED809496BF4E::_id_A22D831B624CCCD2();
  scripts\mp\utility\script::bufferednotify("kill_event_buffered", victim, _id_366B0ECC2F28AEAD, meansofdeath, self.modifiers);
  thread scripts\mp\potg_events::onplayerkilled(self, inflictor, victim, meansofdeath, objweapon, _id_642470E1ABC1BBF9.psoffsettime);
  thread _id_0F0C7425BD5A7050(victim, meansofdeath);
}

checkkillstreakkillevents(objweapon, meansofdeath, inflictor) {
  iskillstreak = isDefined(objweapon) && _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename) || scripts\mp\utility\weapon::iskillstreakvehicleinflictor(inflictor);
  _id_92D9648CF1326B82 = scripts\mp\utility\points::isforcekillstreakprogressweapon(objweapon);

  if(iskillstreak && !_id_92D9648CF1326B82) {
    if(isDefined(inflictor) && isDefined(inflictor.streakinfo)) {
      _id_F459A13A227B8DE6 = 1;

      if(isDefined(inflictor.streakinfo.mpstreaksysteminfo)) {
        _id_35C572B2759818A9 = inflictor.streakinfo.mpstreaksysteminfo.streaklifeid;
        _id_A1AE8509332598F7 = self.lifeid;

        if(!isDefined(_id_35C572B2759818A9) || _id_35C572B2759818A9 != _id_A1AE8509332598F7)
          _id_F459A13A227B8DE6 = 0;

        if(inflictor.streakinfo.mpstreaksysteminfo.ownerxuid != self getxuid())
          _id_F459A13A227B8DE6 = 0;
      }

      if(isDefined(inflictor.streakinfo.streakname)) {
        _id_D238646F1C6623EB = 0;
        _id_F0D6C6926BF765BB = 0;
        _id_4C20E5ABF3CE9872 = 0;
        _id_D8061F26B5ECA018 = inflictor.streakinfo.streakname;

        switch (_id_D8061F26B5ECA018) {
          case "bradley":
            scripts\mp\utility\stats::incpersstat("killstreakTankKills", 1);
            _id_D238646F1C6623EB = 1;
            _id_4C20E5ABF3CE9872 = 1;
            break;
          case "chopper_gunner":
            scripts\mp\utility\stats::incpersstat("killstreakChopperGunnerKills", 1);
            _id_D238646F1C6623EB = 1;
            _id_F0D6C6926BF765BB = 1;
            break;
          case "chopper_support":
            scripts\mp\utility\stats::incpersstat("killstreakChopperSupportKills", 1);
            _id_D238646F1C6623EB = 1;
            _id_F0D6C6926BF765BB = 1;
            break;
          case "cruise_predator":
            scripts\mp\utility\stats::incpersstat("killstreakCruiseMissileKills", 1);
            _id_D238646F1C6623EB = 1;
            _id_F0D6C6926BF765BB = 1;
            break;
          case "fuel_airstrike":
            _id_D238646F1C6623EB = 1;
            break;
          case "gunship":
            scripts\mp\utility\stats::incpersstat("killstreakGunshipKills", 1);
            _id_D238646F1C6623EB = 1;
            _id_F0D6C6926BF765BB = 1;
            break;
          case "hover_jet":
            scripts\mp\utility\stats::incpersstat("killstreakVTOLJetKills", 1);
            _id_D238646F1C6623EB = 1;
            _id_F0D6C6926BF765BB = 1;
            break;
          case "juggernaut":
            scripts\mp\utility\stats::incpersstat("killstreakJuggernautKills", 1);
            _id_D238646F1C6623EB = 1;
            _id_4C20E5ABF3CE9872 = 1;
            break;
          case "manual_turret":
            scripts\mp\utility\stats::incpersstat("killstreakShieldTurretKills", 1);
            _id_D238646F1C6623EB = 1;
            _id_4C20E5ABF3CE9872 = 1;
            break;
          case "multi_airstrike":
            _id_D238646F1C6623EB = 1;
            break;
          case "pac_sentry":
            scripts\mp\utility\stats::incpersstat("killstreakWheelsonKills", 1);
            _id_D238646F1C6623EB = 1;
            _id_4C20E5ABF3CE9872 = 1;
            break;
          case "precision_airstrike":
            scripts\mp\utility\stats::incpersstat("killstreakAirstrikeKills", 1);
            _id_D238646F1C6623EB = 1;
            _id_F0D6C6926BF765BB = 1;
            break;
          case "sentry_gun":
            scripts\mp\utility\stats::incpersstat("killstreakSentryGunKills", 1);
            _id_D238646F1C6623EB = 1;
            _id_4C20E5ABF3CE9872 = 1;
            break;
          case "toma_strike":
            scripts\mp\utility\stats::incpersstat("killstreakCluserStrikeKills", 1);
            _id_D238646F1C6623EB = 1;
            _id_F0D6C6926BF765BB = 1;
            break;
          case "white_phosphorus":
            scripts\mp\utility\stats::incpersstat("killstreakWhitePhosphorousKillsAssists", 1);
            _id_D238646F1C6623EB = 1;
            _id_F0D6C6926BF765BB = 1;
            break;
          case "assault_drone":
            _id_D238646F1C6623EB = 1;
            _id_F0D6C6926BF765BB = 1;
            break;
          default:
            if(!isDefined(level._id_5EF21D1318ACECEA)) {
              level._id_5EF21D1318ACECEA = spawnStruct();
              level._id_5EF21D1318ACECEA._id_E0BADEC2B1517CA3 = 1;
            }

            thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_1387A1180E68DC64", objweapon, undefined, undefined, undefined, undefined, undefined, undefined, inflictor.streakinfo, undefined, level._id_5EF21D1318ACECEA);
            break;
        }

        if(isDefined(inflictor.streakinfo.kills))
          inflictor.streakinfo.kills++;

        scripts\mp\utility\stats::incpersstat("killstreakKills", 1);

        if(_id_F0D6C6926BF765BB)
          scripts\mp\utility\stats::incpersstat("killstreakAirKills", 1);

        if(_id_4C20E5ABF3CE9872)
          scripts\mp\utility\stats::incpersstat("killstreakGroundKills", 1);

        if(_id_D238646F1C6623EB) {
          event = _func_2EF675C13CA1C4AF("stat_868668BDD652FCC1", _id_D8061F26B5ECA018);
          _id_91185FF4A2E16A72 = undefined;

          if(_id_F459A13A227B8DE6 && scripts\mp\utility\perk::_hasperk("specialty_chain_killstreaks")) {}

          _id_30E33D4E4669117F = 1;

          if(!isDefined(level._id_5EF21D1318ACECEA)) {
            level._id_5EF21D1318ACECEA = spawnStruct();
            level._id_5EF21D1318ACECEA._id_E0BADEC2B1517CA3 = 1;
          }

          thread scripts\mp\utility\points::_id_0366980B6A8796AE(event, objweapon, _id_91185FF4A2E16A72, undefined, undefined, _id_30E33D4E4669117F, undefined, _id_F459A13A227B8DE6, inflictor.streakinfo, undefined, level._id_5EF21D1318ACECEA);
        }

        level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_killstreak", undefined, 0.75);
      }
    }
  }
}

_id_3E2FF5954AACAA33(objweapon, meansofdeath, inflictor) {
  if((_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename) || scripts\mp\utility\weapon::iskillstreakvehicleinflictor(inflictor)) && !scripts\mp\utility\points::isforcekillstreakprogressweapon(objweapon) && isDefined(inflictor) && isDefined(inflictor.streakinfo) && isDefined(inflictor.streakinfo.streakname) && isDefined(inflictor.streakinfo.kills))
    inflictor.streakinfo.kills++;
}

checksuperkillevents(victim, inflictor, objweapon, meansofdeath, _id_366B0ECC2F28AEAD) {
  _id_AFF23472F0596BBE = scripts\mp\supers::issuperinuse();
  _id_EBEC497FF8B18A45 = scripts\mp\supers::getcurrentsuperref();
  super = scripts\mp\supers::getcurrentsuper();
  _id_641083E829D5514C = scripts\mp\utility\weapon::issuperweapon(objweapon.basename);
  _id_8F5249908F8F07FB = undefined;

  if(!isDefined(_id_EBEC497FF8B18A45)) {
    return;
  }
  if(_id_641083E829D5514C) {
    thread killedplayerwithsuperweapon(victim, inflictor, objweapon, meansofdeath, _id_366B0ECC2F28AEAD);

    if(meansofdeath != "MOD_MELEE")
      scripts\mp\utility\script::bufferednotify("super_kill_buffered");
  }

  _id_7D701A3F18F52454 = 0;

  if(isDefined(_id_EBEC497FF8B18A45)) {
    switch (_id_EBEC497FF8B18A45) {
      default:
        break;
    }

    if(_id_7D701A3F18F52454) {
      thread superkill(_id_EBEC497FF8B18A45, meansofdeath);
      scripts\mp\supers::combatrecordsuperkill(_id_EBEC497FF8B18A45);

      if(isDefined(_id_8F5249908F8F07FB))
        thread scripts\mp\utility\points::_id_0366980B6A8796AE(_id_8F5249908F8F07FB);

      scripts\mp\utility\script::bufferednotify("super_kill_buffered");
    }
  }
}

checksupershutdownevents(victim, objweapon, meansofdeath) {
  _id_727E0F6C828ADF76 = victim scripts\mp\supers::issuperinuse();
  _id_8550E94C928E5CDD = victim scripts\mp\supers::getcurrentsuperref();
  _id_D5AE9F1C103B36C0 = victim scripts\mp\supers::getcurrentsuper();

  if(!isDefined(_id_8550E94C928E5CDD)) {
    return;
  }
  switch (_id_8550E94C928E5CDD) {
    default:
      if(_id_727E0F6C828ADF76 == 1)
        thread supershutdown(victim);

      break;
  }
}

killedplayerwithsuperweapon(victim, inflictor, objweapon, meansofdeath, _id_366B0ECC2F28AEAD) {
  _id_EBEC497FF8B18A45 = scripts\mp\supers::getsuperrefforsuperweapon(objweapon);
  _id_398A9D42AF1D5E5F = self.recentkillsperweapon[_id_366B0ECC2F28AEAD];

  if(isDefined(_id_398A9D42AF1D5E5F) && _id_398A9D42AF1D5E5F > 0 && _id_398A9D42AF1D5E5F % 2 == 0)
    superkill(_id_EBEC497FF8B18A45, meansofdeath);
  else {
    _id_F5F7B5E4219A0145 = scripts\mp\supers::getcurrentsuper();
    _id_F5F7B5E4219A0145.numkills++;
  }

  scripts\cp_mp\challenges::updatesuperweaponkills(objweapon, inflictor);
  scripts\mp\supers::combatrecordsuperkill(_id_EBEC497FF8B18A45);
}

superkill(_id_EBEC497FF8B18A45, meansofdeath) {
  _id_FE600A5EA17DD64D = scripts\mp\supers::getrootsuperref(_id_EBEC497FF8B18A45);
  _id_E235CCC5D0B8027D = _func_2EF675C13CA1C4AF("stat_2112A8B102A3950E", _id_FE600A5EA17DD64D);

  if(scripts\mp\rank::_id_377A94F711D96927(_id_E235CCC5D0B8027D)) {
    if(!isDefined(level._id_B4E942EDB1952CA1)) {
      level._id_B4E942EDB1952CA1 = spawnStruct();
      level._id_B4E942EDB1952CA1._id_3A13C58C2A354968 = 1;
    }

    thread scripts\mp\utility\points::_id_0366980B6A8796AE(_id_E235CCC5D0B8027D, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, level._id_B4E942EDB1952CA1);
  }

  _id_F5F7B5E4219A0145 = scripts\mp\supers::getcurrentsuper();
  _id_F5F7B5E4219A0145.numkills++;
  scripts\cp_mp\challenges::updatesuperkills(_id_EBEC497FF8B18A45, meansofdeath, _id_F5F7B5E4219A0145.numkills);
  self.modifiers["super_kill_medal"] = _id_EBEC497FF8B18A45;
}

killedkillstreak(_id_D8061F26B5ECA018, _id_6181DE250AFA5BB6, objweapon) {
  _id_84EA5CF2793332C1 = _func_2EF675C13CA1C4AF("stat_4BB6EAD5813240AD", _id_D8061F26B5ECA018);

  if(isDefined(objweapon) && weaponclass(objweapon) != "rocketlauncher" && objweapon.basename != "iw8_la_kgolf_mp")
    objweapon = undefined;

  _id_6181DE250AFA5BB6 thread scripts\mp\utility\points::_id_0366980B6A8796AE(_id_84EA5CF2793332C1, objweapon);
  _id_6181DE250AFA5BB6 scripts\mp\utility\stats::incpersstat("destroyedKillstreaks", 1);
  level thread scripts\mp\battlechatter_mp::saytoself(_id_6181DE250AFA5BB6, "plr_killstreak_destroy", undefined, 0.75);
}

processscrapassist(_id_6181DE250AFA5BB6) {
  _id_ABFD7751A2D536A5 = scripts\mp\killstreaks\killstreaks::getscrapassistplayers(_id_6181DE250AFA5BB6);

  foreach(player in _id_ABFD7751A2D536A5) {
    if(!isDefined(player)) {
      continue;
    }
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_2009F98B7647C4A4");
  }
}

is_enemy_highest_score(enemy, enemies) {
  if(!isDefined(enemy.score))
    return 0;

  foreach(e in enemies) {
    if(e.score > enemy.score)
      return 0;
  }

  return 1;
}

getshotdistancetype(attacker, objweapon, meansofdeath, attackerposition, victim) {
  if(isalive(attacker) && meansofdeath != "MOD_MELEE" && !attacker scripts\mp\utility\player::isusingremote() && (scripts\mp\utility\weapon::isprimaryweapon(objweapon) || scripts\mp\utility\weapon::iscacsecondaryweapon(objweapon) || scripts\mp\utility\weapon::isthrowingknife(objweapon)) && !_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename) && !istrue(attacker.assistedsuicide)) {
    _id_11A735A56B3FCBAD = distancesquared(attackerposition, victim.origin);

    if(_id_11A735A56B3FCBAD < 9216)
      return "pointblank";

    if(_id_11A735A56B3FCBAD > 4000000)
      return "very_longshot";

    _id_A77E978567103B98 = scripts\mp\utility\weapon::getweapongroup(objweapon.basename);
    _id_90A1A9DC0F8175FF = undefined;

    switch (_id_A77E978567103B98) {
      case "weapon_pistol":
        _id_90A1A9DC0F8175FF = 800;
        break;
      case "weapon_beam":
      case "weapon_smg":
        _id_90A1A9DC0F8175FF = 1200;
        break;
      case "weapon_battle":
      case "weapon_lmg":
      case "weapon_dmr":
      case "weapon_assault":
        if(objweapon.basename == "iw9_dm_crossbow_mp")
          _id_90A1A9DC0F8175FF = 1200;
        else
          _id_90A1A9DC0F8175FF = 1500;

        break;
      case "weapon_rail":
      case "weapon_sniper":
        _id_90A1A9DC0F8175FF = 2000;
        break;
      case "weapon_shotgun":
        _id_90A1A9DC0F8175FF = 500;
        break;
      case "weapon_projectile":
        _id_90A1A9DC0F8175FF = 1200;
        break;
      case "other":
        _id_90A1A9DC0F8175FF = 1969;
        break;
      default:
        _id_90A1A9DC0F8175FF = 1536;
        break;
    }

    _id_6057E03A8A2E2DAF = _id_90A1A9DC0F8175FF * _id_90A1A9DC0F8175FF;

    if(_id_11A735A56B3FCBAD > _id_6057E03A8A2E2DAF)
      return "longshot";
  }

  return "none";
}

islongshotspecial(attackerposition, victim, objweapon) {
  _id_11A735A56B3FCBAD = distancesquared(attackerposition, victim.origin);
  _id_A77E978567103B98 = scripts\mp\utility\weapon::getweapongroup(objweapon.basename);
  _id_90A1A9DC0F8175FF = undefined;

  switch (_id_A77E978567103B98) {
    case "weapon_pistol":
      _id_90A1A9DC0F8175FF = 1500;
      break;
    case "weapon_beam":
    case "weapon_smg":
      _id_90A1A9DC0F8175FF = 2000;
      break;
    case "weapon_dmr":
      _id_90A1A9DC0F8175FF = 4000;
      break;
    case "weapon_battle":
    case "weapon_lmg":
    case "weapon_assault":
      _id_90A1A9DC0F8175FF = 3000;
      break;
    case "weapon_rail":
    case "weapon_sniper":
      _id_90A1A9DC0F8175FF = 8000;
      break;
    case "weapon_shotgun":
      _id_90A1A9DC0F8175FF = 1000;
      break;
    case "weapon_projectile":
      _id_90A1A9DC0F8175FF = 4000;
      break;
    default:
      _id_90A1A9DC0F8175FF = 4000;
      break;
  }

  _id_6057E03A8A2E2DAF = _id_90A1A9DC0F8175FF * _id_90A1A9DC0F8175FF;
  return _id_11A735A56B3FCBAD > _id_6057E03A8A2E2DAF;
}

isdeathfromabove(attacker, objweapon, meansofdeath, attackerposition, victim) {
  if(isalive(attacker) && attacker isjumping() && scripts\engine\utility::isbulletdamage(meansofdeath)) {
    _id_9FDDA7532CD6D8A2 = attacker.origin[2] - victim.origin[2];
    return _id_9FDDA7532CD6D8A2 > 60;
  }

  return 0;
}

isskeetshooter(attacker, objweapon, meansofdeath, attackerposition, victim) {
  return isalive(attacker) && victim isjumping() && scripts\engine\utility::isbulletdamage(meansofdeath);
}

isbackkill(attacker, victim, meansofdeath) {
  if(!isPlayer(attacker) || !isPlayer(victim))
    return 0;

  if(meansofdeath != "MOD_RIFLE_BULLET" && meansofdeath != "MOD_PISTOL_BULLET" && meansofdeath != "MOD_MELEE" && meansofdeath != "MOD_HEAD_SHOT")
    return 0;

  _id_CB116AC8AA94CE55 = victim getplayerangles();
  _id_524B19D2034E1406 = attacker getplayerangles();
  _id_077B9E4B599269EB = angleclamp180(_id_CB116AC8AA94CE55[1] - _id_524B19D2034E1406[1]);

  if(abs(_id_077B9E4B599269EB) < 80)
    return 1;

  return 0;
}

issurvivorkill(player) {
  return player.health > 0 && player.health < player.maxhealth * 0.5;
}

_id_8A4D75143273FD07(attacker, victim) {
  _id_DB1EE1676A83E16E = isDefined(victim.lastsnapshotgrenadetime) && victim.lastsnapshotgrenadetime + scripts\mp\equipment\snapshot_grenade::_id_905247D1B30C84F1() > gettime();
  _id_BC1D14D99EAA6485 = isDefined(attacker.radarstrength) && attacker.radarstrength > 3 && !victim scripts\mp\utility\perk::_hasperk("specialty_br_ghost");
  _id_ABEE336EA25765C6 = istrue(victim._id_ABEE336EA25765C6);
  return _id_DB1EE1676A83E16E || _id_BC1D14D99EAA6485 || _id_ABEE336EA25765C6;
}

proximityassist(_id_61B5D0250B328F00) {
  self.modifiers["proximityAssist"] = 1;
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_1585DD0E8F21044D");
}

proximitykill(_id_61B5D0250B328F00) {
  self.modifiers["proximityKill"] = 1;
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_B2545F22CF7AD376");
}

longshot(_id_61B5D0250B328F00) {
  thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "longshot");
  scripts\mp\utility\stats::incpersstat("longshotKills", 1);
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_9501A62017D709D3");
}

very_longshot(_id_61B5D0250B328F00) {
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_03454D945DD7A9A2", undefined, 1);
}

pointblank(_id_61B5D0250B328F00) {
  thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "pointblank");
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_A4EE120BD3F61B35");
  scripts\mp\utility\stats::incpersstat("pointBlankKills", 1);
}

headshot(_id_61B5D0250B328F00) {
  thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "headshot");
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_FC56E889052D3823");
}

avengedplayer(_id_61B5D0250B328F00, _id_35F3D76A60187C15) {
  thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "avenger");
  scripts\mp\utility\stats::incpersstat("avengerKills", 1);
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_F751297C1A2FA2A9");
}

assistedsuicide(_id_61B5D0250B328F00, objweapon) {
  thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "assistedsuicide");
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_25AD6F034F93AF2D", objweapon);
}

defendedplayer(_id_61B5D0250B328F00, guid) {
  thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "defender");
  scripts\mp\utility\stats::incpersstat("defenderKills", 1);
  thread killeventtextpopup("stat_106962D4EDB25321", 0);
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_58B9CD84A305DD09");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_A84B87147883E407", undefined, 1);
}

postdeathkill(_id_61B5D0250B328F00) {
  thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "posthumous");
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_DAB63315ABCDB6B4");
}

revenge(_id_61B5D0250B328F00, victim) {
  thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "revenge");
  scripts\mp\utility\stats::incpersstat("revengeKills", 1);
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_7670901F9461C455");
  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "stat_0C85E7A0886653E4", undefined, 1);
  playFX(scripts\engine\utility::getfx("money"), victim.origin + (0, 0, 64));
}

multikill(_id_61B5D0250B328F00, killcount, _id_C95C893C15217527, _id_5AF31C1555EB14B1) {
  if(!isDefined(self.currentmultikill))
    self.currentmultikill = killcount;

  if(killcount < self.currentmultikill) {
    return;
  }
  self notify("multiKill");
  self endon("multiKill");
  self endon("disconnect");
  waitframe();
  _id_A773025016ED337A = undefined;
  teamsplash = undefined;

  switch (killcount) {
    case 2:
      _id_A773025016ED337A = "stat_A0880A9CE131DEA8";
      break;
    case 3:
      _id_A773025016ED337A = "stat_F42B79A30529BA75";
      teamsplash = "callout_3xkill";
      break;
    case 4:
      _id_A773025016ED337A = "stat_DD33FE790C41DDE5";
      teamsplash = "callout_4xkill";
      break;
    case 5:
      _id_A773025016ED337A = "stat_AA851578EFEA8575";
      teamsplash = "callout_5xkill";
      break;
    case 6:
      _id_A773025016ED337A = "stat_82488B195CEC9F4B";
      teamsplash = "callout_6xkill";
      break;
    case 7:
      _id_A773025016ED337A = "stat_01359A3079F1D01E";
      teamsplash = "callout_7xkill";
      break;
    case 8:
      _id_A773025016ED337A = "stat_FA09C7954013CDF0";
      teamsplash = "callout_8xkill";
      break;
    default:
      _id_A773025016ED337A = "stat_A3A0144007C5F9F2";
      teamsplash = "callout_9xkill";
      break;
  }

  if(isDefined(self.pers["totalMultikills"]))
    scripts\mp\utility\stats::incpersstat("totalMultikills", 1);

  if(isDefined(self.pers["highestMultikill"]) && killcount > self.pers["highestMultikill"]) {
    self.pers["highestMultikill"] = killcount;
    scripts\mp\codcasterclientmatchdata::_id_7EE466E81B1AFC12(10, killcount);
  }

  thread scripts\common\utility::trycall(level.matchdata_logmultikill, _id_61B5D0250B328F00, killcount);

  if(isDefined(_id_A773025016ED337A)) {
    _id_5AF31C1555EB14B1 = istrue(_id_5AF31C1555EB14B1);
    thread killeventtextpopup(_id_A773025016ED337A, scripts\engine\utility::ter_op(isDefined(_id_C95C893C15217527), _id_C95C893C15217527, 1), _id_5AF31C1555EB14B1);

    if(!_id_5AF31C1555EB14B1)
      thread scripts\mp\utility\points::_id_0366980B6A8796AE(_id_A773025016ED337A);
  }

  if(isDefined(teamsplash)) {
    if(!_id_5AF31C1555EB14B1) {
      if(scripts\cp_mp\utility\game_utility::_id_22CD3D64FDB05892()) {
        return;
      }
      thread scripts\mp\hud_util::teamplayercardsplash(teamsplash, self);
    }
  }
}

firstblood(_id_61B5D0250B328F00) {
  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_548072087C9FD504::_id_7D42D3F8DD68280C(11, self.team, self getentitynumber());

  thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "firstblood");
  thread scripts\mp\hud_util::teamplayercardsplash("callout_firstblood", self);
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_891A26E1130EB05B");
}

_id_EFDB9FE54D750E6D(victim) {
  if(isDefined(victim._id_1EA3D23E8D49BB49)) {
    self.modifiers["hvtKill"] = 1;
    self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 21);
  }
}

buzzkill(_id_61B5D0250B328F00, victim) {
  thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "buzzkill");
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_03858CE1E38B2CFC");
}

impairedkill() {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_909D2A91D79F1DD5");
}

comeback(_id_61B5D0250B328F00) {
  thread scripts\common\utility::trycall(level.matchdata_logattackerkillevent, _id_61B5D0250B328F00, "comeback");
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_61CC49DF58D8244E");
  scripts\mp\utility\stats::incpersstat("comebackKills", 1);
}

supershutdown(victim) {
  _id_FE600A5EA17DD64D = scripts\mp\supers::getrootsuperref(victim.super.staticdata.ref);
  self.modifiers["superShutdown"] = victim.super.staticdata.ref;
  _id_E235CCC5D0B8027D = _func_2EF675C13CA1C4AF("stat_499E8B2730BB3818", _id_FE600A5EA17DD64D);

  switch (_id_FE600A5EA17DD64D) {
    case "chargemode":
      _id_E235CCC5D0B8027D = "stat_B21113802F70845A";
      break;
  }

  if(scripts\mp\rank::_id_377A94F711D96927(_id_E235CCC5D0B8027D))
    thread scripts\mp\utility\points::_id_0366980B6A8796AE(_id_E235CCC5D0B8027D);
}

collateral(numkills) {
  if(numkills == 2) {
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_twofer", undefined, 0.75);
    thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_8368A43E439D8A67");
  }

  if(numkills == 3)
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_threefer", undefined, 0.75);

  thread scripts\mp\potg_events::collateral(self, numkills);
}

shotguncollateral(numkills) {
  thread scripts\mp\potg_events::shotguncollateral(self, numkills);
}

mantlekill() {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_86C2B3D1FA522F2B");
}

backfire() {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_224B63CC1F966A36");
}

quadfeed(_id_61B5D0250B328F00, struct) {
  self.modifiers["quadfeed"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 46);
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_DABB834E68CCA5AF");
  thread scripts\mp\potg_events::quadfeed(self, struct.starttime, gettime());
}

killentireenemyteam(_id_61B5D0250B328F00) {
  self.modifiers["killEnemyTeam"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 48);
  scripts\mp\utility\stats::incpersstat("killEnemyTeam", 1);
}

kingslayer(_id_61B5D0250B328F00) {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_B25FDA74D611DDF2");
  scripts\mp\utility\stats::incpersstat("highestRankedKills", 1);
}

directimpactkill(_id_61B5D0250B328F00) {
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_E13C7899C2EED171");
}

tripledefenderkill(_id_61B5D0250B328F00) {
  self.modifiers["tripledefenderkill"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 49);
}

execution(_id_61B5D0250B328F00) {
  scripts\mp\utility\stats::incpersstat("executions", 1);
  thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_40C5F8104D76CC15");
}

_id_08D62D448FC0010E() {
  self.modifiers["cleanKill"] = 1;
  self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 22);
}

disconnected() {
  _id_5155CBAA6170E292 = self.guid;

  if(!scripts\mp\utility\game::lpcfeaturegated()) {
    for(_id_F90358454413407F = 0; _id_F90358454413407F < level.players.size; _id_F90358454413407F++) {
      if(isDefined(level.players[_id_F90358454413407F].killedplayers[_id_5155CBAA6170E292]))
        level.players[_id_F90358454413407F].killedplayers[_id_5155CBAA6170E292] = undefined;

      if(isDefined(level.players[_id_F90358454413407F].killedby[_id_5155CBAA6170E292]))
        level.players[_id_F90358454413407F].killedby[_id_5155CBAA6170E292] = undefined;
    }
  }
}

monitorhealed() {
  if(scripts\mp\rank::_id_377A94F711D96927("healed") == 0) {
    return;
  }
  level endon("end_game");

  for(;;) {
    level waittill("healed", player);
    player thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_7F9CDAB528B70D9A");
  }
}

updaterecentkills(_id_61B5D0250B328F00, victim, objweapon, _id_366B0ECC2F28AEAD) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");
  self.recentkillcount++;

  if(scripts\mp\utility\game::isdefending(victim)) {
    self.recentdefendcount++;

    if(scripts\mp\utility\script::isnumbermultipleof(self.recentdefendcount, 2))
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_5F9FC734692AF8D7");
  }

  if(scripts\mp\utility\game::isassaulting(victim)) {
    self.recentassaultcount++;

    if(scripts\mp\utility\script::isnumbermultipleof(self.recentassaultcount, 3))
      tripledefenderkill(_id_61B5D0250B328F00);
  }

  if(!isDefined(self.recentkillsperweapon))
    self.recentkillsperweapon = [];

  if(!isDefined(self.recentkillsperweapon[_id_366B0ECC2F28AEAD]))
    self.recentkillsperweapon[_id_366B0ECC2F28AEAD] = 1;
  else
    self.recentkillsperweapon[_id_366B0ECC2F28AEAD]++;

  weaponinfo = scripts\mp\utility\weapon::getequipmenttype(objweapon);

  if(isDefined(weaponinfo) && weaponinfo == "lethal" && !scripts\mp\utility\weapon::isthrowingknife(objweapon)) {
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_grenade", undefined, 0.75);
    level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_killfirm_amf", undefined, 0.75);

    if(self.recentkillsperweapon[_id_366B0ECC2F28AEAD] > 0 && self.recentkillsperweapon[_id_366B0ECC2F28AEAD] % 2 == 0)
      thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_978B9BAB778F200B");
  }

  scripts\mp\utility\script::bufferednotify("update_rapid_kill_buffered", self.recentkillcount, _id_366B0ECC2F28AEAD);

  if(!isDefined(self.recentkillcount))
    self.recentkillcount = 0;

  if(self.recentkillcount > 1)
    thread multikill(_id_61B5D0250B328F00, self.recentkillcount, 0);

  wait 4.0;

  if(self.recentkillcount > 1) {
    thread multikill(_id_61B5D0250B328F00, self.recentkillcount, 1, 1);

    if(self.recentkillcount > 2) {
      if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
        _id_548072087C9FD504::_id_7D42D3F8DD68280C(12, self.team, self getentitynumber(), self.recentkillcount);
    }
  }

  scripts\mp\utility\stats::incpersstat("mostMultikills", 1);
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.recentkillsperweapon = undefined;
}

updatec4vehiclemultkill(meansofdeath, inflictor) {
  _id_CD37CE775909957B = spawnStruct();
  _id_CD37CE775909957B.meansofdeath = meansofdeath;
  _id_CD37CE775909957B.inflictor = inflictor;
  _id_43828ADD0312B6BF::challengeevaluator("br_mastery_c4VehicleMultKill", _id_CD37CE775909957B);
}

updateghostridekills() {
  _id_CD37CE775909957B = spawnStruct();
  _id_CD37CE775909957B.maderecentkill = 1;
  _id_43828ADD0312B6BF::challengeevaluator("br_mastery_ghostRideWhip", _id_CD37CE775909957B);
}

monitorcratejacking() {
  level endon("end_game");
  self endon("disconnect");

  for(;;) {
    self waittill("hijacker", cratetype, owner);
    thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_519E0923D0608694");
    splashname = "hijacked_airdrop";

    if(isDefined(owner))
      owner scripts\mp\hud_message::showsplash(splashname, undefined, self);
  }
}

updatequadfeedcounter(attacker, _id_61B5D0250B328F00) {
  if(isDefined(level.quadfeedinfo) && gettime() - level.quadfeedinfo.starttime > 10000)
    level.quadfeedinfo = undefined;

  if(!isDefined(level.quadfeedinfo) || level.quadfeedinfo.player != attacker) {
    struct = spawnStruct();
    struct.player = attacker;
    struct.starttime = gettime();
    struct.feedcount = 1;
    level.quadfeedinfo = struct;
  } else {
    struct = level.quadfeedinfo;
    struct.feedcount++;

    if(struct.feedcount == 4) {
      struct.player quadfeed(_id_61B5D0250B328F00, struct);
      level.quadfeedinfo = undefined;
    }
  }
}

initslidemonitor() {
  self.eventswassliding = self issprintsliding();
  self.eventsslideendtime = undefined;
}

events_monitorslideupdate() {
  if(scripts\mp\utility\player::isreallyalive(self)) {
    _id_22D57060C0BF0ECE = self issprintsliding();

    if(istrue(self.eventswassliding) && !_id_22D57060C0BF0ECE) {
      self.eventsslideendtime = gettime();
      scripts\mp\potg::processevent("recent_slide");
    }

    self.eventswassliding = _id_22D57060C0BF0ECE;
  } else {
    self.eventswassliding = 0;
    self.eventsslideendtime = undefined;
  }
}

events_issliding() {
  if(self issprintsliding())
    return 1;

  events_monitorslideupdate();

  if(isDefined(self.eventsslideendtime)) {
    if(gettime() - self.eventsslideendtime <= 150)
      return 1;
  }

  return 0;
}

initmonitoradstime() {
  self.wasads = scripts\mp\utility\player::isplayerads();
  self.lastadsstarttime = 0;
}

monitoradstime() {
  if(scripts\mp\utility\player::isplayerads()) {
    if(!self.wasads) {
      self.lastadsstarttime = gettime();
      self.wasads = 1;
    }
  } else
    self.wasads = 0;
}

monitorreload() {
  level endon("game_ended");
  self endon("disconnect");
  self.lastreloadtime = 0;

  for(;;) {
    self waittill("reload");
    self.lastreloadtime = gettime();
    scripts\mp\utility\stats::incpersstat("reloads", 1);
  }
}

monitorweaponpickup() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_pickup");
    _id_7731A04537766917();
  }
}

monitorweaponswitch() {
  level endon("game_ended");
  self endon("disconnect");
  self.lastweaponchangetime = 0;

  for(;;) {
    self waittill("weapon_change");
    self.lastweaponchangetime = gettime();
  }
}

updateweaponchangetime() {
  self.lastweaponchangetime = gettime();
}

initstancetracking() {
  self.laststance = self getstance();
  self.laststancetimes = [];
  self.laststancetimes["prone"] = 0;
  self.laststancetimes["crouch"] = 0;
  self.laststancetimes["stand"] = 0;
}

updatestancetracking() {
  if(!isalive(self)) {
    return;
  }
  _id_9D6C7038172EB8CF = self.mantlecur;
  self.mantlecur = self ismantling();

  if(!istrue(_id_9D6C7038172EB8CF) && self.mantlecur)
    scripts\mp\potg::processevent("recent_mantle");

  _id_32931493C5657794 = self.jumpcur;
  self.jumpcur = self isjumping();

  if(!istrue(_id_32931493C5657794) && self.jumpcur)
    scripts\mp\potg::processevent("recent_jump");

  stance = self getstance();

  if(stance != self.laststance) {
    scripts\mp\potg_events::playerstancechanged(stance);

    if(self.laststance == "crouch") {
      starttime = self.pers["lastStanceChangeTime"];
      time = (gettime() - starttime) / 1000;
      scripts\mp\utility\stats::incpersstat("timeCrouched", time);
    }

    if(self.laststance == "prone") {
      starttime = self.pers["lastStanceChangeTime"];
      time = (gettime() - starttime) / 1000;
      scripts\mp\utility\stats::incpersstat("timeProne", time);
    }

    self.pers["lastStanceChangeTime"] = gettime();

    if(!isDefined(self.pers["stanceTracking"])) {
      self.pers["stanceTracking"] = [];
      self.pers["stanceTracking"]["prone"] = 0;
      self.pers["stanceTracking"]["crouch"] = 0;
      self.pers["stanceTracking"]["stand"] = 0;
    }

    if(stance == "prone" || stance == "crouch" || stance == "stand")
      self.pers["stanceTracking"][stance]++;
  }

  self.laststancetimes[stance] = gettime();
  self.laststance = stance;
}

predatormissileimpact(_id_25DE37BAEC255643) {
  scripts\mp\potg_events::predatormissileimpact(_id_25DE37BAEC255643);
}

largevehicleexplosion(_id_408F3E834E201526) {
  scripts\mp\potg_events::largevehicleexplosion(_id_408F3E834E201526);
}

vehiclekilled(damagedata) {
  scripts\mp\potg_events::vehiclekilled(damagedata);
}

missilefired(missile) {
  thread trackmissile(missile);
}

trackmissile(missile) {
  level endon("game_ended");
  missile endon("death");
  missile endon("entitydeleted");
  missile.whizbyplayers = [];

  for(;;) {
    whizbyplayers = scripts\common\utility::playersnear(missile.origin, 220);

    foreach(player in whizbyplayers) {
      if(isDefined(missile.owner) && player == missile.owner) {
        continue;
      }
      missilewhizby(player, missile);
      missile.whizbyplayers[player.guid] = 1;
    }

    wait 0.1;
  }
}

missilewhizby(player, missile) {
  scripts\mp\potg_events::missilewhizby(player);
}

bombdefused(_id_34E4B26FEE2CFD2B) {
  _id_8F8DC78C3242728B = 0;

  if(scripts\mp\utility\game::getgametypenumlives() >= 1) {
    _id_677AE66DF2125F53 = scripts\mp\utility\game::getpotentiallivingplayers();

    if(_id_677AE66DF2125F53.size == 1 && _id_677AE66DF2125F53[0] == _id_34E4B26FEE2CFD2B)
      _id_8F8DC78C3242728B = 1;
  }

  _id_C148DFE3DD8379C8 = 0;

  if(!_id_8F8DC78C3242728B && scripts\mp\utility\game::getgametype() != "dd") {
    _id_F47DD9D668CC52E2 = scripts\mp\utility\player::getplayersinradius(_id_34E4B26FEE2CFD2B.origin, 600);

    foreach(player in _id_F47DD9D668CC52E2) {
      if(player.team != _id_34E4B26FEE2CFD2B.team) {
        _id_C148DFE3DD8379C8 = 1;
        break;
      }
    }
  }

  if(isDefined(level.bombowner) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && scripts\mp\utility\player::isreallyalive(level.bombowner)) {
    _id_34E4B26FEE2CFD2B thread scripts\mp\rank::scoreeventpopup("stat_83821E6F33D9A7B2");
    _id_34E4B26FEE2CFD2B thread scripts\mp\hud_message::showsplash("ninja_defuse", scripts\mp\rank::getscoreinfovalue("stat_F982730CA4AE79C7"));

    if(scripts\mp\utility\game::getgametype() != "dd")
      _id_C148DFE3DD8379C8 = 1;
  } else {
    _id_34E4B26FEE2CFD2B thread scripts\mp\hud_message::showsplash("emp_defuse", scripts\mp\rank::getscoreinfovalue("stat_F982730CA4AE79C7"));
    _id_34E4B26FEE2CFD2B thread scripts\mp\rank::scoreeventpopup("stat_F982730CA4AE79C7");
  }

  if(_id_8F8DC78C3242728B)
    _id_34E4B26FEE2CFD2B thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_B723EF4352E748D0");
  else
    _id_34E4B26FEE2CFD2B thread scripts\mp\utility\points::_id_0366980B6A8796AE("stat_D42F3A6D11E62127");

  _id_34E4B26FEE2CFD2B scripts\mp\utility\stats::incpersstat("defuses", 1);
  _id_34E4B26FEE2CFD2B scripts\mp\persistence::statsetchild("round", "defuses", _id_34E4B26FEE2CFD2B.pers["defuses"]);
  _id_34E4B26FEE2CFD2B scripts\mp\codcasterclientmatchdata::_id_48544E365F4F5648(2, 1);

  if(isDefined(_id_34E4B26FEE2CFD2B.pers["sneakDefuses"])) {
    _id_5E88ABB83D46A357 = scripts\mp\utility\teams::getenemyplayers(_id_34E4B26FEE2CFD2B.team, 1).size > 0;

    if(_id_5E88ABB83D46A357)
      _id_34E4B26FEE2CFD2B scripts\mp\utility\stats::incpersstat("sneakDefuses", 1);
  }

  if(scripts\mp\utility\game::getgametype() != "sr")
    _id_34E4B26FEE2CFD2B scripts\mp\utility\stats::setextrascore1(_id_34E4B26FEE2CFD2B.pers["defuses"]);

  if(isPlayer(_id_34E4B26FEE2CFD2B)) {
    _id_7E2C53B0BCF117D9 = spawnStruct();
    _id_7E2C53B0BCF117D9.player = _id_34E4B26FEE2CFD2B;
    _id_7E2C53B0BCF117D9.eventname = "defuse";
    _id_7E2C53B0BCF117D9.position = _id_34E4B26FEE2CFD2B.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_7E2C53B0BCF117D9);
  }

  if(_id_8F8DC78C3242728B)
    scripts\mp\utility\game::logannouncement(_id_34E4B26FEE2CFD2B, undefined, "Bomb Defused", _id_34E4B26FEE2CFD2B.origin, "last_alive");
  else
    scripts\mp\utility\game::logannouncement(_id_34E4B26FEE2CFD2B, undefined, "Bomb Defused", _id_34E4B26FEE2CFD2B.origin);

  scripts\mp\potg_events::bombdefused(_id_34E4B26FEE2CFD2B, _id_8F8DC78C3242728B, _id_C148DFE3DD8379C8);
}

revivedplayer(reviver, _id_22F7E3F7E360775B) {
  if(reviver == _id_22F7E3F7E360775B) {
    return;
  }
  scripts\mp\potg_events::revivedplayer(reviver, _id_22F7E3F7E360775B);

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_715028F54BAD19A1::branalytics_revive(reviver, _id_22F7E3F7E360775B);
}

doorused(player, _id_6CB6920473D33EE3) {
  scripts\mp\potg_events::doorused(player, _id_6CB6920473D33EE3);

  if(_id_6CB6920473D33EE3)
    player.lastdooropentime = gettime();
}

shothit() {
  if(!isDefined(self.pers["shotsHit"]))
    scripts\mp\utility\stats::initpersstat("shotsHit");

  scripts\mp\utility\stats::incpersstat("shotsHit", 1);
  scripts\mp\potg_events::shothit();
}

shotmissed(_id_C1480A81B0387196, _id_7EB0CCF010359357) {
  scripts\mp\potg_events::shotmissed(_id_C1480A81B0387196, _id_7EB0CCF010359357);
}

_id_2FCA19675EB69F1A(victim, shitloc, idamage) {
  if(isagent(victim) || !isDefined(victim.clientid)) {
    return;
  }
  if(isDefined(self._id_8A3630D09E62CCB3) && isDefined(self._id_8A3630D09E62CCB3[victim.clientid])) {
    if(isDefined(self._id_8A3630D09E62CCB3[victim.clientid]._id_D7CB4D5D8B4F8E2E)) {
      if(self._id_8A3630D09E62CCB3[victim.clientid]._id_D7CB4D5D8B4F8E2E + 10000 > gettime()) {
        if(isDefined(self.currentweapon) && isDefined(self.currentweapon.basename)) {
          if(isDefined(self.primaryweaponobj) && isDefined(self.primaryweaponobj.basename) && self.currentweapon.basename == self.primaryweaponobj.basename) {
            if(_id_632BDD4591097AEF(shitloc))
              self._id_8A3630D09E62CCB3[victim.clientid]._id_2AC787419BD6D040++;

            self._id_8A3630D09E62CCB3[victim.clientid]._id_C1480A81B0387196++;
          } else if(isDefined(self.secondaryweaponobj) && isDefined(self.secondaryweaponobj.basename) && self.currentweapon.basename == self.secondaryweaponobj.basename) {
            if(_id_632BDD4591097AEF(shitloc))
              self._id_8A3630D09E62CCB3[victim.clientid]._id_5398CCD715C76B80++;

            self._id_8A3630D09E62CCB3[victim.clientid]._id_05C9DA7308AD57E2++;
          }
        }

        self._id_8A3630D09E62CCB3[victim.clientid]._id_D7CB4D5D8B4F8E2E = gettime();
        return;
      }
    }
  }

  _id_C5F7E38F739B35A1(victim, shitloc, idamage);
}

_id_CF1CFBBEC7D07D44(_id_C1480A81B0387196, _id_1F4904B24E56FAF5) {
  if(!isDefined(self._id_8A3630D09E62CCB3)) {
    return;
  }
  if(self._id_8A3630D09E62CCB3.size > 0) {
    foreach(instance in self._id_8A3630D09E62CCB3) {
      if(!isDefined(self.currentweapon) || !isDefined(self.currentweapon.basename)) {
        continue;
      }
      if(isDefined(self.primaryweaponobj) && isDefined(self.primaryweaponobj.basename) && self.currentweapon.basename == self.primaryweaponobj.basename) {
        instance._id_F506140B2CA169B7 = instance._id_F506140B2CA169B7 + _id_1F4904B24E56FAF5;
        instance._id_C1480A81B0387196 = instance._id_C1480A81B0387196 + _id_C1480A81B0387196;
        continue;
      }

      if(isDefined(self.secondaryweaponobj) && isDefined(self.secondaryweaponobj.basename) && self.currentweapon.basename == self.secondaryweaponobj.basename) {
        instance._id_05C9DA7308AD57E2 = instance._id_05C9DA7308AD57E2 + _id_1F4904B24E56FAF5;
        instance._id_2BBE05E4FF81CADB = instance._id_2BBE05E4FF81CADB + _id_C1480A81B0387196;
      }
    }
  }
}

_id_F3096708AA63946F(a, b) {
  if(isDefined(a) && isDefined(b))
    return distance(a, b);
  else
    return -1.0;
}

_id_C5F7E38F739B35A1(victim, shitloc, idamage) {
  struct = spawnStruct();
  struct._id_48B7B944A7A02B2C = victim.clientid;
  struct._id_6305027F095FBC1B = scripts\engine\utility::ter_op(isDefined(victim.origin), victim.origin, (0, 0, 0));
  struct._id_A5B2B38B5622A18E = gettime();
  struct._id_D7CB4D5D8B4F8E2E = gettime();
  struct._id_05BC3FC581D33D22 = self.primaryweaponobj.basename;

  if(isDefined(self.secondaryweaponobj) && isDefined(self.secondaryweaponobj.basename))
    struct._id_648180638343688C = self.secondaryweaponobj.basename;
  else
    struct._id_648180638343688C = undefined;

  struct._id_2B2DBB6B26A12A45 = victim.currentweapon.basename;
  struct._id_5983E1858F15E19E = _id_F3096708AA63946F(self.origin, victim.origin);
  struct._id_C1480A81B0387196 = 0;
  struct._id_F506140B2CA169B7 = 0;
  struct._id_05C9DA7308AD57E2 = 0;
  struct._id_2BBE05E4FF81CADB = 0;
  struct._id_965F053894722BC1 = victim.health + idamage;
  struct._id_2AC787419BD6D040 = 0;
  struct._id_5398CCD715C76B80 = 0;
  struct._id_61944D23E1FCF1C2 = self.primaryweapon;
  struct._id_AB9BE282F142F11A = self.secondaryweapon;
  struct._id_56AEAE6C53565509 = self.primaryweaponobj;
  struct._id_8F7CFFAEA5DCDFF1 = self.secondaryweaponobj;

  if(self.currentweapon.basename == self.primaryweaponobj.basename) {
    struct._id_C1480A81B0387196 = 1;

    if(_id_632BDD4591097AEF(shitloc))
      struct._id_2AC787419BD6D040 = 1;
  } else if(isDefined(self.secondaryweaponobj) && self.currentweapon.basename == self.secondaryweaponobj.basename) {
    struct._id_05C9DA7308AD57E2 = 1;

    if(_id_632BDD4591097AEF(shitloc))
      struct._id_5398CCD715C76B80 = 1;
  }

  self._id_8A3630D09E62CCB3[victim.clientid] = struct;
}

_id_0F0C7425BD5A7050(victim, meansofdeath) {
  waittillframeend;

  if(!isDefined(self._id_8A3630D09E62CCB3)) {
    return;
  }
  foreach(instance in self._id_8A3630D09E62CCB3) {
    if(instance._id_48B7B944A7A02B2C == victim.clientid) {
      if(instance._id_C1480A81B0387196 > 0) {
        if(instance._id_F506140B2CA169B7 == 0)
          _id_5813D1E9FE8E86E4 = 100;
        else
          _id_5813D1E9FE8E86E4 = int(clamp((1 - instance._id_F506140B2CA169B7 / instance._id_C1480A81B0387196) * 100.0, 0, 100));
      } else
        _id_5813D1E9FE8E86E4 = 0;

      if(instance._id_05C9DA7308AD57E2 > 0) {
        if(instance._id_2BBE05E4FF81CADB == 0)
          _id_56DCCC97E40A858E = 100;
        else
          _id_56DCCC97E40A858E = int(clamp((1 - instance._id_2BBE05E4FF81CADB / instance._id_05C9DA7308AD57E2) * 100.0, 0, 100));
      } else
        _id_56DCCC97E40A858E = 0;

      _id_5D0716264ABD2B2D = (gettime() - instance._id_A5B2B38B5622A18E) / 1000.0;
      _id_85598E67455E57C4 = _id_45F403E1732217D3::_id_B4ED203552F83BCA(instance._id_56AEAE6C53565509);
      _id_79DD046C94822604 = _id_45F403E1732217D3::_id_B4ED203552F83BCA(instance._id_8F7CFFAEA5DCDFF1);
      self dlog_recordplayerevent("dlog_event_mp_combat_instance", ["victim", victim, "combat_duration", _id_5D0716264ABD2B2D, "attacker_weapon_primary", instance._id_05BC3FC581D33D22, "attacker_accuracy_primary", _id_5813D1E9FE8E86E4, "victim_weapon", instance._id_2B2DBB6B26A12A45, "distance_start", instance._id_5983E1858F15E19E, "distance_final", _id_F3096708AA63946F(self.origin, victim.origin), "attacker_weapon_secondary", instance._id_648180638343688C, "attacker_accuracy_secondary", _id_56DCCC97E40A858E, "total_shots_primary", instance._id_C1480A81B0387196, "total_shots_secondary", instance._id_05C9DA7308AD57E2, "victim_initial_health", float(instance._id_965F053894722BC1), "attacker_headshots_primary", instance._id_2AC787419BD6D040, "attacker_headshots_secondary", instance._id_5398CCD715C76B80, "primary_weapon_receiver", _id_85598E67455E57C4._id_A03DDD0D0225B263, "primary_weapon_front_piece", _id_85598E67455E57C4._id_8B043EABC16B00B4, "primary_weapon_back_piece", _id_85598E67455E57C4._id_D6EFE963BDA0A080, "primary_weapon_magazine", _id_85598E67455E57C4._id_B7D2E220B07DBAD8, "primary_weapon_optic", _id_85598E67455E57C4._id_AEB6A391017838B3, "primary_weapon_underbarrel", _id_85598E67455E57C4._id_349604C14927DB04, "primary_weapon_modifier", _id_85598E67455E57C4._id_62593976EFDA2B1B, "primary_weapon_muzzle", _id_85598E67455E57C4._id_FAA4002F92DB269B, "primary_weapon_rear_grip", _id_85598E67455E57C4._id_A2BF51FBB4438A81, "primary_weapon_trigger", _id_85598E67455E57C4._id_319E593017C07BFE, "primary_weapon_extra", _id_85598E67455E57C4._id_4C8CBAF983AD420C, "primary_lid_receiver", _id_85598E67455E57C4._id_230A9E4B47172A82, "primary_lid_front_piece", _id_85598E67455E57C4._id_E5D800552E426FFB, "primary_lid_back_piece", _id_85598E67455E57C4._id_B14B1E17A70A4EF5, "primary_lid_magazine", _id_85598E67455E57C4._id_B6717D21185B3C59, "primary_lid_optic", _id_85598E67455E57C4._id_07C25C6724C108F4, "primary_lid_underbarrel", _id_85598E67455E57C4._id_431219808B1B28FB, "primary_lid_modifier", _id_85598E67455E57C4._id_9C52B25A65573476, "primary_lid_muzzle", _id_85598E67455E57C4._id_CB7042EB5BB68FEE, "primary_lid_rear_grip", _id_85598E67455E57C4._id_CA2F4A84799BFC82, "primary_lid_trigger", _id_85598E67455E57C4._id_792C55F863E07071, "primary_lid_extra", _id_85598E67455E57C4._id_C596750E1DFB9873, "primary_tv_receiver", _id_85598E67455E57C4._id_DEF32C4A258195B9, "primary_tv_front_piece", _id_85598E67455E57C4._id_F0802681DA395BFE, "primary_tv_back_piece", _id_85598E67455E57C4._id_FEB38F6B0627DD52, "primary_tv_magazine", _id_85598E67455E57C4._id_5347CF04D65E699A, "primary_tv_optic", _id_85598E67455E57C4._id_A189C936E207A6AD, "primary_tv_underbarrel", _id_85598E67455E57C4._id_78309ECB7C6C1F12, "primary_tv_modifier", _id_85598E67455E57C4._id_E4A2F6B057AD85AD, "primary_tv_muzzle", _id_85598E67455E57C4._id_CCA4852BF2C81C11, "primary_tv_rear_grip", _id_85598E67455E57C4._id_B437EE6ECC505CF7, "primary_tv_trigger", _id_85598E67455E57C4._id_E4CEFFC67FBB1FC0, "primary_tv_extra", _id_85598E67455E57C4._id_2BCDCFCB2CD5465A, "primary_is_bp_tuned", _id_85598E67455E57C4._id_F58B539A89B0BC91, "secondary_weapon_receiver", _id_79DD046C94822604._id_A03DDD0D0225B263, "secondary_weapon_front_piece", _id_79DD046C94822604._id_8B043EABC16B00B4, "secondary_weapon_back_piece", _id_79DD046C94822604._id_D6EFE963BDA0A080, "secondary_weapon_magazine", _id_79DD046C94822604._id_B7D2E220B07DBAD8, "secondary_weapon_optic", _id_79DD046C94822604._id_AEB6A391017838B3, "secondary_weapon_underbarrel", _id_79DD046C94822604._id_349604C14927DB04, "secondary_weapon_modifier", _id_79DD046C94822604._id_62593976EFDA2B1B, "secondary_weapon_muzzle", _id_79DD046C94822604._id_FAA4002F92DB269B, "secondary_weapon_rear_grip", _id_79DD046C94822604._id_A2BF51FBB4438A81, "secondary_weapon_trigger", _id_79DD046C94822604._id_319E593017C07BFE, "secondary_weapon_extra", _id_79DD046C94822604._id_4C8CBAF983AD420C, "secondary_lid_receiver", _id_79DD046C94822604._id_230A9E4B47172A82, "secondary_lid_front_piece", _id_79DD046C94822604._id_E5D800552E426FFB, "secondary_lid_back_piece", _id_79DD046C94822604._id_B14B1E17A70A4EF5, "secondary_lid_magazine", _id_79DD046C94822604._id_B6717D21185B3C59, "secondary_lid_optic", _id_79DD046C94822604._id_07C25C6724C108F4, "secondary_lid_underbarrel", _id_79DD046C94822604._id_431219808B1B28FB, "secondary_lid_modifier", _id_79DD046C94822604._id_9C52B25A65573476, "secondary_lid_muzzle", _id_79DD046C94822604._id_CB7042EB5BB68FEE, "secondary_lid_rear_grip", _id_79DD046C94822604._id_CA2F4A84799BFC82, "secondary_lid_trigger", _id_79DD046C94822604._id_792C55F863E07071, "secondary_lid_extra", _id_79DD046C94822604._id_C596750E1DFB9873, "secondary_tv_receiver", _id_79DD046C94822604._id_DEF32C4A258195B9, "secondary_tv_front_piece", _id_79DD046C94822604._id_F0802681DA395BFE, "secondary_tv_back_piece", _id_79DD046C94822604._id_FEB38F6B0627DD52, "secondary_tv_magazine", _id_79DD046C94822604._id_5347CF04D65E699A, "secondary_tv_optic", _id_79DD046C94822604._id_A189C936E207A6AD, "secondary_tv_underbarrel", _id_79DD046C94822604._id_78309ECB7C6C1F12, "secondary_tv_modifier", _id_79DD046C94822604._id_E4A2F6B057AD85AD, "secondary_tv_muzzle", _id_79DD046C94822604._id_CCA4852BF2C81C11, "secondary_tv_rear_grip", _id_79DD046C94822604._id_B437EE6ECC505CF7, "secondary_tv_trigger", _id_79DD046C94822604._id_E4CEFFC67FBB1FC0, "secondary_tv_extra", _id_79DD046C94822604._id_2BCDCFCB2CD5465A, "secondary_is_bp_tuned", _id_79DD046C94822604._id_F58B539A89B0BC91]);
      instance._id_D7CB4D5D8B4F8E2E = undefined;
      break;
    }
  }
}

_id_632BDD4591097AEF(shitloc) {
  return isDefined(shitloc) && (shitloc == "head" || shitloc == "helmet" || shitloc == "neck");
}

_id_7731A04537766917() {
  self._id_8A3630D09E62CCB3 = undefined;
}

killeventtextpopup(scoreeventref, showassplash, dontshowscoreevent) {
  if(_id_16AA7CE5EFACBCCB()) {
    return;
  }
  if(!isDefined(self)) {
    scripts\mp\utility\script::demoforcesre("killEventTextPopup called with invalid self");
    return;
  }

  self endon("death_or_disconnect");

  if(!scripts\mp\rank::scoreeventhastext(scoreeventref)) {
    return;
  }
  if(!isDefined(self.killeventqueue))
    self.killeventqueue = [];

  foreach(event in self.killeventqueue) {
    if(event.scoreeventref == scoreeventref)
      return;
  }

  _id_3ED8EAA77725D27A = spawnStruct();
  _id_3ED8EAA77725D27A.scoreeventref = scoreeventref;
  _id_3ED8EAA77725D27A.showassplash = istrue(showassplash);
  _id_3ED8EAA77725D27A.priority = scripts\mp\rank::getscoreeventpriority(scoreeventref);
  _id_3ED8EAA77725D27A.alwaysshowsplash = scripts\mp\rank::scoreeventalwaysshowassplash(scoreeventref);
  _id_3ED8EAA77725D27A.processedsplash = 0;
  _id_3ED8EAA77725D27A.processedscoreevent = 0;
  _id_3ED8EAA77725D27A.dontshowscoreevent = istrue(dontshowscoreevent);
  self.killeventqueue[self.killeventqueue.size] = _id_3ED8EAA77725D27A;
  self notify("killEventTextPopup");
  self endon("killEventTextPopup");
  waitframe();

  if(!isDefined(self.splashpriorityqueue))
    self.splashpriorityqueue = [];

  foreach(event in self.killeventqueue)
  insertbypriority(event);

  self.killeventqueue = undefined;
  thread processsplashpriorityqueue();
}

processsplashpriorityqueue() {
  self notify("processSplashPriorityQueue");
  self endon("processSplashPriorityQueue");
  self.playedonesplash = 1;

  if(!isDefined(self.splashpriorityqueue))
    self.playedonesplash = 0;

  foreach(event in self.splashpriorityqueue) {
    if(event.processedsplash) {
      continue;
    }
    if(!istrue(level.removekilleventsplash) && istrue(event.showassplash) && (!self.playedonesplash || event.alwaysshowsplash)) {
      playedonesplash = 1;
      thread scripts\mp\hud_message::showsplash(event.scoreeventref);
    }

    event.processedsplash = 1;
  }

  foreach(event in self.splashpriorityqueue) {
    if(event.processedscoreevent || event.dontshowscoreevent) {
      continue;
    }
    thread scripts\mp\rank::scoreeventpopup(event.scoreeventref);
    event.processedscoreevent = 1;
    wait(getdvarfloat("scr_splash_kill_buffer", 0.25));
  }

  self.splashpriorityqueue = undefined;
}

insertbypriority(_id_3ED8EAA77725D27A) {
  if(self.splashpriorityqueue.size == 0) {
    self.splashpriorityqueue[self.splashpriorityqueue.size] = _id_3ED8EAA77725D27A;
    return;
  }

  foreach(event in self.splashpriorityqueue) {
    if(event.scoreeventref == _id_3ED8EAA77725D27A.scoreeventref)
      return;
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.splashpriorityqueue.size; _id_AC0E594AC96AA3A8++) {
    if(_id_3ED8EAA77725D27A.priority > self.splashpriorityqueue[_id_AC0E594AC96AA3A8].priority) {
      self.splashpriorityqueue = scripts\engine\utility::array_insert(self.splashpriorityqueue, _id_3ED8EAA77725D27A, _id_AC0E594AC96AA3A8);
      return;
    }
  }

  self.splashpriorityqueue[self.splashpriorityqueue.size] = _id_3ED8EAA77725D27A;
}

getnemesis() {
  _id_56521B8795115DEB = [];

  if(!scripts\mp\utility\game::lpcfeaturegated() && isDefined(self.killedby)) {
    _id_54401FF0F381643A = 0;

    foreach(guid, killcount in self.killedby) {
      if(killcount > _id_54401FF0F381643A) {
        _id_56521B8795115DEB = [];
        _id_56521B8795115DEB[_id_56521B8795115DEB.size] = guid;
      }

      if(killcount == _id_54401FF0F381643A)
        _id_56521B8795115DEB[_id_56521B8795115DEB.size] = guid;
    }
  }

  return _id_56521B8795115DEB;
}

isxmike109explosiveheadshot(objweapon, _id_642470E1ABC1BBF9) {
  if(isDefined(objweapon) && _id_2669878CF5A1B6BC::getweaponrootname(objweapon.basename) == "iw8_sn_xmike109" && isDefined(_id_642470E1ABC1BBF9.hitloc) && (_id_642470E1ABC1BBF9.hitloc == "head" || _id_642470E1ABC1BBF9.hitloc == "helmet"))
    return 1;
  else
    return 0;
}

_id_D355D90BAB289087(objweapon, _id_642470E1ABC1BBF9) {
  if(scripts\mp\utility\weapon::_id_160A992C78BDF589(objweapon) && isDefined(_id_642470E1ABC1BBF9) && istrue(_id_642470E1ABC1BBF9._id_F83C15ACB64C91B7))
    return 1;

  return 0;
}

checklethalequipmentachievement(objweapon) {
  if(!level.challengesallowed) {
    return;
  }
  _id_1189BD7FBE2861F8 = scripts\mp\equipment::getequipmentreffromweapon(objweapon);

  if(!isDefined(_id_1189BD7FBE2861F8) || !isDefined(level.lethal_equipmentmaskoffsets[_id_1189BD7FBE2861F8])) {
    return;
  }
  if(self.pers["lethalEquipmentKillMask"] &level.lethal_equipmentmaskoffsets[_id_1189BD7FBE2861F8])
    return;
  else
    self.pers["lethalEquipmentKillMask"] = self.pers["lethalEquipmentKillMask"] | level.lethal_equipmentmaskoffsets[_id_1189BD7FBE2861F8];

  _id_DDACADD2126887BD = 0;

  foreach(ref, offset in level.lethal_equipmentmaskoffsets) {
    if(self.pers["lethalEquipmentKillMask"] &offset) {
      _id_DDACADD2126887BD++;

      if(_id_DDACADD2126887BD >= 6) {
        self reportchallengeuserevent("collect_item", "lethal_achievement");
        break;
      }
    }
  }
}

incrementobjectiveachievementkill() {
  if(!level.challengesallowed) {
    return;
  }
  if(self.objectiveachievementkillcount == -1) {
    return;
  }
  self.objectiveachievementkillcount++;
  _id_5EADAE570201E028 = undefined;

  switch (level.mapname) {
    case "mp_m_speed":
    case "mp_shipment":
      _id_5EADAE570201E028 = 50;
      break;
    default:
      _id_5EADAE570201E028 = 30;
  }

  if(self.objectiveachievementkillcount >= _id_5EADAE570201E028) {
    self reportchallengeuserevent("collect_item", "objective_player_achievement");
    self.objectiveachievementkillcount = -1;
  }
}

checkfinalkillachievements(victim) {
  self endon("disconnect");
  _id_B8AB57B5FEE4C51F = 0;
  _id_D3683388E46C971C = 0;

  if(!level.challengesallowed || !isDefined(victim)) {
    self.recondroneteammate = undefined;
    return;
  }

  if(isPlayer(victim) && isDefined(self.recondroneteammate)) {
    if(istrue(self.modifiers["recon_drone_explosive"]))
      _id_B8AB57B5FEE4C51F = 1;
  }

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    if(istrue(self.modifiers["execution"]))
      _id_D3683388E46C971C = 1;
  }

  level scripts\engine\utility::waittill_any_timeout_1(1, "game_ended");

  if(level.gameended) {
    if(_id_B8AB57B5FEE4C51F) {
      self reportchallengeuserevent("collect_item", "recon_drone_achievement");

      if(isDefined(self.recondroneteammate))
        self.recondroneteammate reportchallengeuserevent("collect_item", "recon_drone_achievement");
    }

    if(_id_D3683388E46C971C)
      _id_43828ADD0312B6BF::challengeevaluator("br_mastery_roundKillExecute", undefined);
  }

  self.recondroneteammate = undefined;
}

_id_16AA7CE5EFACBCCB() {
  return istrue(level._id_16AA7CE5EFACBCCB);
}

_id_4A4D0D400FD59760() {
  level _id_4C770A9A4AD7659C::_id_52004C7A02FCFFD6("on_ai_killed", ::_id_3D5389E7BAE53CE5);
}

_id_3D5389E7BAE53CE5(_id_D27680FF86693F5C) {
  if(!isDefined(_id_D27680FF86693F5C.eattacker) || !isPlayer(_id_D27680FF86693F5C.eattacker)) {
    return;
  }
  victim = self;
  _id_830A1FCFBE58BAF4 = "";

  if(!isDefined(self._id_AAF0465944B061ED)) {
    return;
  }
  _id_813307117C9BEA44 = self._id_AAF0465944B061ED;

  if(!_func_D03495FE6418377B(_id_813307117C9BEA44))
    _id_813307117C9BEA44 = _func_1823FF50BB28148D(_id_813307117C9BEA44);

  if(isDefined(level._id_9871526022516E0B))
    [[level._id_9871526022516E0B]](victim, _id_D27680FF86693F5C.eattacker, _id_D27680FF86693F5C.einflictor, _id_D27680FF86693F5C.smeansofdeath, _id_D27680FF86693F5C.sweapon, _id_D27680FF86693F5C.shitloc, _id_830A1FCFBE58BAF4, _id_813307117C9BEA44);
  else {
    points = scripts\mp\rank::getscoreinfovalue(_id_813307117C9BEA44);
    xp = scripts\mp\rank::_id_D06C3CBB904AE29B(_id_813307117C9BEA44);
    _id_D27680FF86693F5C.eattacker killeventtextpopup(_id_813307117C9BEA44, 0, 0);

    if(points > 0) {
      _id_D27680FF86693F5C.eattacker scripts\mp\gamescore::giveplayerscore(_id_813307117C9BEA44, points, self, undefined);
      _id_D27680FF86693F5C.eattacker scripts\mp\utility\points::displayscoreeventpoints(points, _id_813307117C9BEA44);
    }

    if(xp > 0)
      _id_D27680FF86693F5C.eattacker scripts\mp\rank::giverankxp(_id_813307117C9BEA44, xp, _id_D27680FF86693F5C.sweapon, 1, 0);
  }
}