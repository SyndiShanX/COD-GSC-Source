/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\events.gsc
***********************************************/

init() {
  scripts\cp_mp\utility\game_utility::initchallengeandeventglobals();
  _id_14609B809484646E::_id_8ECE37593311858A(::_id_9C6DFCAF923F186B);
  level._id_27DCAF9644646944 = "stat_DB5FE74CFCEEBFE6";
  _id_C8F690457A04A764 = scripts\cp\utility::getgametype();

  if(!isDefined(_id_C8F690457A04A764))
    _id_C8F690457A04A764 = getDvar("g_gametype");

  scriptbundlename = "score_event_list_" + _id_C8F690457A04A764;

  if(getdvarint("t10") > 0)
    scriptbundlename = scriptbundlename + "_t10_cp";
  else
    scriptbundlename = scriptbundlename + "_iw9_cp";

  _id_D442547D75DFFD09 = getscriptbundle("scoreeventlist:" + scriptbundlename);

  if(isDefined(_id_D442547D75DFFD09)) {
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

  _id_187A04151C40FB72::registerscoreinfo("stat_BB5BE601232DC24D", "stat_7CE4FD9430E80CEA", 500);
  level thread monitorhealed();
  scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawn);
  scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(::monitoradstime);
  scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(::updatestancetracking);
  scripts\cp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback(::events_monitorslideupdate);
  _id_18A73A64992DD07D::add_global_spawn_function("axis", ::init_ai_kill_params_for_events);
}

_id_E1FB4DFA1DB65CE2(_id_F90358454413407F) {
  if(!isDefined(_id_F90358454413407F)) {
    return;
  }
  ref = _id_F90358454413407F.ref;

  if(!isDefined(ref) || ref == "") {
    return;
  }
  _id_187A04151C40FB72::_id_4806D99C032B59E9(ref, _id_F90358454413407F._id_98EA5AFB293A76A2);
  group = scripts\engine\utility::_id_53C4C53197386572(_id_F90358454413407F.group, "unassigned");
  _id_187A04151C40FB72::registerscoreinfo(ref, "stat_DC57E42946F6E08C", group);
}

_id_51E853369BC3F0BF(_id_F90358454413407F) {
  if(!isDefined(_id_F90358454413407F)) {
    return;
  }
  ref = _id_F90358454413407F.ref;

  if(!isDefined(ref) || ref == "") {
    return;
  }
  if(istrue(_id_F90358454413407F._id_EA8529D33B9E81AA))
    _id_187A04151C40FB72::registerscoreinfo(ref, "stat_6DD3D93BBF03ABC6", 1);

  score = scripts\engine\utility::_id_53C4C53197386572(_id_F90358454413407F.score, 0);
  xp = scripts\engine\utility::_id_53C4C53197386572(_id_F90358454413407F.xp, 0);

  if(!istrue(_id_F90358454413407F._id_C3D1929B58499072)) {
    if(score == 0 && xp == 0)
      return;
  }

  _id_187A04151C40FB72::registerscoreinfo(ref, "stat_7CE4FD9430E80CEA", score);
  _id_187A04151C40FB72::registerscoreinfo(ref, "stat_08F14807B58DDF35", xp);
  _id_C9147B02D8B3DD0A(ref, scripts\cp\cp_hud_message::getsplashtablename());
  group = scripts\engine\utility::_id_53C4C53197386572(_id_F90358454413407F.group, "unassigned");
  _id_187A04151C40FB72::registerscoreinfo(ref, "stat_DC57E42946F6E08C", group);

  if(!istrue(_id_F90358454413407F._id_34044050829EABA9))
    _id_187A04151C40FB72::registerscoreinfo(ref, "stat_90AAF79C829783F5", 1);

  if(istrue(_id_F90358454413407F._id_5B5911ECA3F2426F))
    _id_187A04151C40FB72::registerscoreinfo(ref, "stat_582866801A05178B", 1);
}

_id_C9147B02D8B3DD0A(ref, _id_AFD0D34073D29C5D) {
  eventid = tablelookuprownum(_id_AFD0D34073D29C5D, 0, ref);

  if(eventid < 0) {
    return;
  }
  _id_187A04151C40FB72::registerscoreinfo(ref, "stat_EC3B335BB0B2F752", eventid);
  text = tablelookup(_id_AFD0D34073D29C5D, 0, ref, 2);
  _id_187A04151C40FB72::registerscoreinfo(ref, "stat_FA04F4EF1995407E", text);
  priority = int(tablelookup(_id_AFD0D34073D29C5D, 0, ref, 13));
  _id_187A04151C40FB72::registerscoreinfo(ref, "stat_F5B6EA8C35AC1E89", priority);
  _id_043297BEEE133B22 = int(tablelookup(_id_AFD0D34073D29C5D, 0, ref, 14));
  _id_187A04151C40FB72::registerscoreinfo(ref, "stat_4EA41C9D7136599E", _id_043297BEEE133B22);
  _id_63D0D76D9A02DE46 = tablelookuprownum(_id_AFD0D34073D29C5D, 0, ref);

  if(isDefined(_id_63D0D76D9A02DE46) && _id_63D0D76D9A02DE46 != -1)
    _id_187A04151C40FB72::registerscoreinfo(ref, "stat_5C5EC1055409EBFB", _id_63D0D76D9A02DE46);
}

onplayerspawn() {
  self.jumpcur = 0;
  self.mantlecur = 0;
}

_id_9C6DFCAF923F186B() {
  self.killedplayers = [];
  self.killedby = [];
  self.lastkilledby = undefined;
  self.greatestuniqueplayerkills = 0;
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.lastkilltime = 0;
  self.lastkilldogtime = 0;
  self.damagedplayers = [];

  if(!isDefined(self.pers["cur_kill_streak"]))
    self.pers["cur_kill_streak"] = 0;

  if(!isDefined(self.pers["cur_death_streak"]))
    self.pers["cur_death_streak"] = 0;

  initslidemonitor();
  initmonitoradstime();
  thread monitorreload();
  thread monitorweaponpickup();
  self.lastweaponchangetime = 0;
  initstancetracking();
}

damagedplayer(victim, damage) {
  if(damage < 50 && damage > 10)
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_damaged_light", undefined, 0.1);
  else
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_damaged_heavy", undefined, 0.1);
}

playerworlddeath(attacker, meansofdeath) {}

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
  _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < numkills; _id_AC0E594AC96AA3A8++) {
    self notify("got_a_kill", victim, _id_366B0ECC2F28AEAD, meansofdeath);
    waitframe();
  }
}

killedenemy(_id_61B5D0250B328F00, victim, objweapon, meansofdeath, inflictor, psoffsettime, shitloc) {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(level.numkills))
    level.numkills = 0;

  level.numkills++;
  self.modifiers = [];
  self.modifiers["mask"] = 0;

  if(!istrue(self.pers["ignoreKillstreakKillRewards"]))
    checkkillstreakkillevents(objweapon, meansofdeath, inflictor);

  if(isai(victim) || isDefined(victim.classname) && victim.classname == "script_vehicle")
    victim.guid = victim getentitynumber();

  _id_7B9F10ECED207B58 = victim.guid;
  _id_5155CBAA6170E292 = self.guid;
  _id_6B7BEE46F2C6DA28 = gettime();
  _id_366B0ECC2F28AEAD = getcompleteweaponname(objweapon);
  thread killedplayernotifysys(_id_61B5D0250B328F00, victim, objweapon, meansofdeath);
  thread updaterecentkills(_id_61B5D0250B328F00, victim, objweapon, _id_366B0ECC2F28AEAD);
  thread updatequadfeedcounter(self, _id_61B5D0250B328F00);
  self.prevlastkilltime = self.lastkilltime;
  self.lastkilltime = _id_6B7BEE46F2C6DA28;
  self.lastkilledplayer = victim;
  self.lastkillvictimpos = victim.origin;

  if(isPlayer(self)) {
    if(self.deaths > 0) {
      _id_1C8AD3040C864084 = self.kills / self.deaths;

      if(_id_1C8AD3040C864084 > 3.0)
        level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_kd_high", undefined, 0.75);
    } else if(self.kills > 5)
      level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_kd_high", undefined, 0.75);
  }

  if(istrue(self.laststanding))
    incpersstat("clutch", 1);

  if(isDefined(self.damagedplayers) && isDefined(self.damagedplayers[_id_7B9F10ECED207B58]))
    self.damagedplayers[_id_7B9F10ECED207B58] = undefined;

  _id_CF4209C200F8BBF4 = _id_74502A9E0EF1F19C::getweapongroup(objweapon.basename);

  if(!_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename) && !scripts\cp\utility::_hasperk("specialty_explosivebullets")) {
    if(meansofdeath == "MOD_EXECUTION")
      execution(_id_61B5D0250B328F00);

    if(objweapon.basename == "none" && !scripts\cp_mp\utility\player_utility::isinvehicle() && meansofdeath != "MOD_EXECUTION")
      return 0;

    if(isDefined(victim.attackerposition))
      attackerposition = victim.attackerposition;
    else
      attackerposition = self.origin;

    attackerisinflictor = 1;

    if(isDefined(inflictor))
      attackerisinflictor = inflictor == self;

    _id_A2C3FEA3986AF52A = anglesToForward(self getplayerangles());
    _id_146F31F6B6666CA7 = victim.origin - attackerposition;
    _id_9669EE24872DD095 = vectorNormalize(_id_146F31F6B6666CA7);
    _id_72705A221874F8A9 = vectordot(_id_A2C3FEA3986AF52A, _id_9669EE24872DD095);
    isbulletdamage = scripts\engine\utility::isbulletdamage(meansofdeath);

    if(isDefined(victim.attackerdata)) {
      if(_id_CF4209C200F8BBF4 == "weapon_sniper" && meansofdeath != "MOD_MELEE" && _id_6B7BEE46F2C6DA28 == victim.attackerdata[self.guid].firsttimedamaged) {
        self.modifiers["oneshotkill"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 20);
        thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_D3BB96C8BD6EFD71");
        incpersstat("oneShotOneKills", 1);
      }

      if(_id_CF4209C200F8BBF4 == "weapon_shotgun" && meansofdeath != "MOD_MELEE" && _id_6B7BEE46F2C6DA28 == victim.attackerdata[self.guid].firsttimedamaged) {
        self.modifiers["oneshotkill_shotgun"] = 1;
        incpersstat("oneShotOneKills", 1);
      }
    }

    if(meansofdeath == "MOD_MELEE") {
      if(_id_CF4209C200F8BBF4 != "weapon_melee" && _id_CF4209C200F8BBF4 != "weapon_melee2")
        thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_020FBB2528F21BD3");

      if(objweapon.basename == "iw9_me_fists_mp")
        thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_D3DD8A69E4A03838");
    }

    if(isPlayer(victim)) {
      _id_F24845EEAEEDC946 = victim getheldoffhand();

      if(_id_F24845EEAEEDC946.basename == "frag_grenade_mp" || _id_F24845EEAEEDC946.basename == "cluster_grenade_mp") {
        self.modifiers["cooking"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 37);
      }
    }

    if(isDefined(self.assistedsuicide) && self.assistedsuicide)
      assistedsuicide(_id_61B5D0250B328F00, objweapon);

    if(!istrue(game["firstBlood"])) {
      game["firstBlood"] = 1;
      firstblood(_id_61B5D0250B328F00);
    }

    if(isDefined(self.pers) && self.pers["cur_death_streak"] > 3)
      comeback(_id_61B5D0250B328F00);

    if(meansofdeath == "MOD_HEAD_SHOT" || isDefined(shitloc) && (shitloc == "head" || shitloc == "helmet" || shitloc == "neck") && !istrue(meansofdeath == "MOD_FIRE") && !istrue(meansofdeath == "MOD_EXPLOSIVE")) {
      level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_headshot", undefined, 0.75);
      headshot(_id_61B5D0250B328F00);
    }

    if(isDefined(self.wasti) && self.wasti && _id_6B7BEE46F2C6DA28 - self.spawntime <= 5000)
      self.modifiers["jackintheboxkill"] = 1;

    if(!scripts\cp\utility\player::isreallyalive(self) && isDefined(self.deathtime)) {
      timesincelastdeath = gettime() - self.deathtime;

      if(timesincelastdeath < 1500 && timesincelastdeath > 0)
        postdeathkill(_id_61B5D0250B328F00);

      if(scripts\cp\utility::issimultaneouskillenabled()) {
        if(timesincelastdeath == 0 && isDefined(self.lastattacker) && self.lastattacker == victim) {
          thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_992BAA42F95D6A55", undefined, undefined, undefined, 1);
          victim thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_992BAA42F95D6A55", undefined, undefined, undefined, 1);
        }
      }
    }

    if(isDefined(victim.lastkilltime) && (level.teambased && _id_6B7BEE46F2C6DA28 - victim.lastkilltime < 1500)) {
      if(isDefined(victim.lastkilledplayer) && victim.lastkilledplayer != self)
        avengedplayer(_id_61B5D0250B328F00, victim.lastkilledplayer);
    }

    if(isDefined(victim.damagedplayers)) {
      foreach(guid, _id_C42F14360A123E9D in victim.damagedplayers) {
        if(guid == self.guid || guid == scripts\engine\utility::string(victim.guid)) {
          continue;
        }
        if(level.teambased && _id_6B7BEE46F2C6DA28 - _id_C42F14360A123E9D < 1750)
          defendedplayer(_id_61B5D0250B328F00, guid);
      }
    }

    if(attackerisinflictor) {
      _id_3C709D201F0772AD = getshotdistancetype(self, objweapon, meansofdeath, attackerposition, victim);

      switch (_id_3C709D201F0772AD) {
        case "pointblank":
          thread pointblank(_id_61B5D0250B328F00);
          break;
        case "longshot":
          thread longshot(_id_61B5D0250B328F00, self, victim);
          break;
        case "very_longshot":
          thread longshot(_id_61B5D0250B328F00, self, victim);
          thread very_longshot(_id_61B5D0250B328F00);
          break;
      }
    }

    if(isbackkill(self, victim, meansofdeath)) {
      if(objweapon.basename == "iw8_knife_mp")
        thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_ACEEE63CB46A233A");

      self.modifiers["backstab"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 31);
    }

    if(self _meth_E40102956C887F7C()) {
      self.modifiers["swimming"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 52);
    }

    if(self _meth_415FE9EECA7B2E2B()) {
      self.modifiers["ledgehanging"] = 1;
      self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 0);
    }

    if(self _meth_C1092F42B6BBE490() || self getplayerdata("cp", "progression", "thirdPerson") == 1) {
      self.modifiers["thirdperson"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 63);
    }

    if(level.script == "cp_hydro") {
      if(!istrue(self isnightvisionon())) {
        self.modifiers["withoutnvgs"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 53);
      }
    }

    if(self getclientomnvar("ui_assault_suit_on") == 1) {
      self.modifiers["victiminstronghold"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 61);
    }

    if(attackerisinflictor) {
      switch (weaponclass(objweapon.basename)) {
        case "rifle":
          incpersstat("arKills", 1);
          victim incpersstat("arDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT")
            incpersstat("arHeadshots", 1);

          break;
        case "smg":
          incpersstat("smgKills", 1);
          victim incpersstat("smgDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT")
            incpersstat("smgHeadshots", 1);

          break;
        case "spread":
          incpersstat("shotgunKills", 1);
          victim incpersstat("shotgunDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT")
            incpersstat("shotgunHeadshots", 1);

          break;
        case "mg":
          incpersstat("lmgKills", 1);
          victim incpersstat("lmgDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT")
            incpersstat("lmgHeadshots", 1);

          break;
        case "sniper":
          incpersstat("sniperKills", 1);
          victim incpersstat("sniperDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT")
            incpersstat("sniperHeadshots", 1);

          break;
        case "rocketlauncher":
          incpersstat("launcherKills", 1);
          victim incpersstat("launcherDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT")
            incpersstat("launcherHeadshots", 1);

          break;
        case "pistol":
          incpersstat("pistolKills", 1);
          victim incpersstat("pistolDeaths", 1);

          if(meansofdeath == "MOD_HEAD_SHOT")
            incpersstat("pistolHeadshots", 1);

          break;
      }

      if(meansofdeath == "MOD_MELEE") {
        incpersstat("meleeKills", 1);
        victim incpersstat("meleeDeaths", 1);
      }

      if(scripts\cp\utility::_hasperk("specialty_bulletdamage")) {
        incpersstat("stoppingPowerKills", 1);

        if(!isDefined(self.stoppingpowerkills))
          self.stoppingpowerkills = 0;

        self.stoppingpowerkills++;
      }

      if(scripts\cp\utility::_hasperk("specialty_quieter")) {
        incpersstat("deadSilenceKills", 1);

        if(!isDefined(self.deadsilencekills))
          self.deadsilencekills = 0;

        self.deadsilencekills++;
      }

      if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
        foreach(drone in level.supportdrones) {
          if(drone.owner == self && drone.helperdronetype == "radar_drone_overwatch") {
            drone.owner incpersstat("killstreakPersonalUAVKills", 1);
            break;
          }
        }
      }

      if(issurvivorkill(self))
        thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_0358D0D85E7B1851");

      if(scripts\cp\utility\player::isplayerads()) {
        self.modifiers["ads"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 2);
        incpersstat("adsKills", 1);
      } else if(isbulletdamage) {
        self.modifiers["hipfire"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 3);
        incpersstat("hipfireKills", 1);
      }

      if(!self isonground())
        self.modifiers["airborne"] = 1;

      if(isPlayer(victim) || isagent(victim)) {
        if(!victim isonground())
          self.modifiers["victim_airborne"] = 1;
      }

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
      }

      if(isPlayer(victim) || isagent(victim)) {
        if(victim issprinting()) {
          self.modifiers["victim_sprinting"] = 1;
          self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 1);
        }
      }

      if(level.teambased) {
        foreach(player in level.players) {
          if(self.team != player.team || self == player) {
            continue;
          }
          if(!scripts\cp\utility\player::isreallyalive(player)) {
            continue;
          }
          if(distancesquared(self.origin, player.origin) < 90000) {
            self.modifiers["buddy_kill"] = 1;
            break;
          }
        }
      }

      if(_id_07C40FA80892A721::hasarmor()) {
        self.modifiers["weearingarmor"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 59);
      }

      if(_id_07C40FA80892A721::_id_9BCA5C1D23A3E0B3()) {
        self.modifiers["fullarmor"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 60);
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

    if(isPlayer(victim) || isagent(victim)) {
      if(!victim isonground() && !victim iswallrunning() && (!self isonground() && !self iswallrunning())) {
        if(attackerisinflictor)
          thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_0585359FB294F2C3");
      } else {
        if(attackerisinflictor) {
          if(self iswallrunning())
            thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_6D681BB42E1AC28F");
          else if(isdeathfromabove(self, objweapon, meansofdeath, attackerposition, victim))
            thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_77BDA5EA2C97FBD8");
          else if(events_issliding()) {
            thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_AF4AB7B4B90C051B");
            self.modifiers["sliding"] = 1;
            self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 32);
          }

          stance = self getstance();

          switch (stance) {
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

        if(victim iswallrunning())
          thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_A7776242889BF154");
        else if(isskeetshooter(self, objweapon, meansofdeath, attackerposition, victim))
          thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_37C5D5F71008DB1D");
      }
    }

    if(isDefined(victim.streakdata)) {
      foreach(streakinfo in victim.streakdata.streaks) {
        _id_A43966F605DF8CA3 = streakinfo.currentcost - victim.streakpoints;

        if(_id_A43966F605DF8CA3 > 0 && _id_A43966F605DF8CA3 <= 1) {
          buzzkill(_id_61B5D0250B328F00, victim);
          break;
        }
      }
    }

    if(attackerisinflictor && (isPlayer(self) || isagent(self))) {
      if(self ismantling())
        thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_86C2B3D1FA522F2B");

      if(isDefined(self.tookweaponfrom[_id_366B0ECC2F28AEAD]) && self.tookweaponfrom[_id_366B0ECC2F28AEAD] == victim) {
        thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_224B63CC1F966A36");
        self.modifiers["backfire"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 15);
      }
    }

    if(isDefined(victim.stuckbygrenade)) {
      level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_semtex", undefined, 0.75);
      self.modifiers["grenadestuck"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 34);
    }

    if(scripts\cp\cp_weapons::isthrowingknife(objweapon.basename))
      thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_123320811BF44B63");

    if(isDefined(victim.baitedbydecoy) && isDefined(victim.baitedbydecoy.owner)) {
      if(victim.baitedbydecoy.owner != self)
        thread killeventtextpopup("stat_EF68378274BC9C41");
    }

    if(isagent(victim) && istrue(victim _id_18A73A64992DD07D::is_specified_unittype("juggernaut")))
      thread killeventtextpopup("stat_FD0C8FBAC1063EAA");

    _id_B96DBC6F3068658D = self.pers["cur_kill_streak"] + 1;
    _id_962DA519C8067AAD = 5;

    if(level.gametype == "arm")
      _id_962DA519C8067AAD = 10;

    if(!(_id_B96DBC6F3068658D % _id_962DA519C8067AAD)) {
      if(!isDefined(self.lastkillsplash) || _id_B96DBC6F3068658D != self.lastkillsplash) {
        thread scripts\cp\cp_hud_util::teamplayercardsplash("callout_kill_streaking", self, undefined, _id_B96DBC6F3068658D);
        self.lastkillsplash = _id_B96DBC6F3068658D;
      }

      if(_id_B96DBC6F3068658D <= 30)
        thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE(_func_2EF675C13CA1C4AF("stat_81E00C932D6CB164", _id_B96DBC6F3068658D));
    }

    if(_id_B96DBC6F3068658D > 30)
      thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_1236123912008792");

    if(isDefined(inflictor) && istrue(inflictor.isequipment) && meansofdeath == "MOD_IMPACT" && !scripts\cp\cp_weapons::isthrowingknife(objweapon.basename)) {
      thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_29065087E352EB71");
      self.modifiers["item_impact"] = 1;
    }

    if(scripts\cp\cp_weapons::islauncherdirectimpactdamage(objweapon, meansofdeath)) {
      thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_E13C7899C2EED171");
      self.modifiers["launcher_impact"] = 1;
    }

    if(_id_72705A221874F8A9 >= 0.6428)
      self.modifiers["victim_in_standard_view"] = 1;

    if(meansofdeath == "MOD_MELEE") {
      self.modifiers["melee"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 16);
    }

    if(isDefined(self.lastadsstarttime) && _id_6B7BEE46F2C6DA28 - self.lastadsstarttime <= 500 && _id_CF4209C200F8BBF4 == "weapon_sniper") {
      self.modifiers["quickscope"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 13);
    }

    if(self.health <= 50) {
      self.modifiers["low_health_kill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 26);
    }

    if(isDefined(self.lastweaponchangetime) && _id_6B7BEE46F2C6DA28 - self.lastweaponchangetime <= 1500) {
      self.modifiers["weapon_change_kill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 14);
    }

    if(isDefined(self.lastweaponpickuptime) && _id_6B7BEE46F2C6DA28 - self.lastweaponpickuptime <= 1500) {
      self.modifiers["weapon_pickup_kill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 5);
    }

    if(isDefined(self.lastreloadtime) && _id_6B7BEE46F2C6DA28 - self.lastreloadtime <= 1500) {
      self.modifiers["reload_kill"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 24);
    }

    vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

    if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self.modifiers["in_vehicle"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 23);

      if(meansofdeath == "MOD_CRUSH") {
        self.modifiers["crush"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 47);
      }
    }

    if(victim scripts\cp_mp\utility\player_utility::isinvehicle()) {
      self.modifiers["victim_in_vehicle"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 30);
    }

    if(self _meth_A7DE57196F4B5D16()) {
      self.modifiers["vehiclelean"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 55);
    }

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
      self.modifiers["vehiclesurf"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 56);

      if(_id_D4E556C137E61B46.classname == "script_vehicle" && _id_D4E556C137E61B46 vehicle_getspeed() > 25) {
        self.modifiers["infastvehicle"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 57);
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
        }
      }
    }

    if(istrue(victim.isdefusing))
      self.modifiers["killed_defuser"] = 1;

    if(_id_74502A9E0EF1F19C::iscacsecondaryweapon(objweapon)) {
      self.modifiers["secondary_weapon"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 27);
    }

    if(_id_0AFB7E332AEE4BF2::isinlaststand(self)) {
      self.modifiers["last_stand"] = 1;
      self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 10);
    }

    thread checkmatchdatakills(_id_61B5D0250B328F00, victim);
  }

  if(!isDefined(self.killedplayers[_id_7B9F10ECED207B58]))
    self.killedplayers[_id_7B9F10ECED207B58] = 0;

  if(!isDefined(victim.killedby) || !isDefined(victim.killedby[_id_5155CBAA6170E292]))
    victim.killedby[_id_5155CBAA6170E292] = 0;

  self.killedplayers[_id_7B9F10ECED207B58]++;
  victim.killedby[_id_5155CBAA6170E292]++;
  victim.lastkilledby = self;

  if(isPlayer(victim)) {
    if(!victim scripts\cp\utility::isusingremote() && (!victim scripts\cp\utility::_hasperk("specialty_survivor") || istrue(victim.inlaststand)))
      victim thread scripts\cp\utility::setdof_killer();
  }

  scripts\cp\utility\script::bufferednotify("kill_event_buffered", victim, _id_366B0ECC2F28AEAD, meansofdeath, self.modifiers);
}

iskillstreakvehicleinflictor(einflictor) {
  return isDefined(einflictor) && isDefined(einflictor.vehiclename) && isDefined(einflictor.streakinfo);
}

checkkillstreakkillevents(objweapon, meansofdeath, inflictor) {
  iskillstreak = _id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename) || iskillstreakvehicleinflictor(inflictor);
  _id_92D9648CF1326B82 = _id_41AE4F5CA24216CB::isforcekillstreakprogressweapon(objweapon);

  if(iskillstreak && !_id_92D9648CF1326B82) {
    _id_D8061F26B5ECA018 = level.killstreakweaponmap[objweapon.basename];
    _id_F459A13A227B8DE6 = 0;
    _id_D238646F1C6623EB = 0;
    _id_F0D6C6926BF765BB = 0;
    _id_4C20E5ABF3CE9872 = 0;

    if(!isDefined(_id_D8061F26B5ECA018)) {
      return;
    }
    if(!isDefined(self.modifiers))
      self.modifiers = [];

    if(!isDefined(self.modifiers["mask"]))
      self.modifiers["mask"] = 0;

    if(!isDefined(self.modifiers["mask2"]))
      self.modifiers["mask2"] = 0;

    switch (_id_D8061F26B5ECA018) {
      case "assault_drone":
        _id_D238646F1C6623EB = 1;
        _id_4C20E5ABF3CE9872 = 1;
        self.modifiers["recon_drone_explosive"] = 1;
        self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 12);
        break;
      case "bradley":
        incpersstat("killstreakTankKills", 1);
        _id_D238646F1C6623EB = 1;
        _id_4C20E5ABF3CE9872 = 1;
        break;
      case "cluster_spike":
        _id_D238646F1C6623EB = 1;
        _id_4C20E5ABF3CE9872 = 1;
        self.modifiers["cluster_mine_kill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 2);
        break;
      case "chopper_gunner":
        incpersstat("killstreakChopperGunnerKills", 1);
        _id_D238646F1C6623EB = 1;
        _id_F0D6C6926BF765BB = 1;
        break;
      case "chopper_support":
        incpersstat("killstreakChopperSupportKills", 1);
        _id_D238646F1C6623EB = 1;
        _id_F0D6C6926BF765BB = 1;
        break;
      case "cruise_predator":
        incpersstat("killstreakCruiseMissileKills", 1);
        _id_D238646F1C6623EB = 1;
        _id_F0D6C6926BF765BB = 1;
        break;
      case "fuel_airstrike":
        _id_D238646F1C6623EB = 1;
        break;
      case "gunship":
        incpersstat("killstreakGunshipKills", 1);
        _id_D238646F1C6623EB = 1;
        _id_F0D6C6926BF765BB = 1;
        break;
      case "hover_jet":
        incpersstat("killstreakVTOLJetKills", 1);
        _id_D238646F1C6623EB = 1;
        _id_F0D6C6926BF765BB = 1;
        break;
      case "juggernaut":
        incpersstat("killstreakJuggernautKills", 1);
        _id_D238646F1C6623EB = 1;
        _id_4C20E5ABF3CE9872 = 1;
        break;
      case "manual_turret":
        incpersstat("killstreakShieldTurretKills", 1);
        _id_D238646F1C6623EB = 1;
        _id_4C20E5ABF3CE9872 = 1;
        break;
      case "multi_airstrike":
        _id_D238646F1C6623EB = 1;
        break;
      case "pac_sentry":
        incpersstat("killstreakWheelsonKills", 1);
        _id_D238646F1C6623EB = 1;
        _id_4C20E5ABF3CE9872 = 1;
        break;
      case "precision_airstrike":
        incpersstat("killstreakAirstrikeKills", 1);
        _id_D238646F1C6623EB = 1;
        _id_F0D6C6926BF765BB = 1;
        break;
      case "sentry_gun":
        incpersstat("killstreakSentryGunKills", 1);
        _id_D238646F1C6623EB = 1;
        _id_4C20E5ABF3CE9872 = 1;
        self.modifiers["sentry_kill"] = 1;
        self.modifiers["mask2"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask2"], 1);
        break;
      case "toma_strike":
        incpersstat("killstreakCluserStrikeKills", 1);
        _id_D238646F1C6623EB = 1;
        _id_F0D6C6926BF765BB = 1;
        break;
      case "white_phosphorus":
        incpersstat("killstreakWhitePhosphorousKillsAssists", 1);
        _id_D238646F1C6623EB = 1;
        _id_F0D6C6926BF765BB = 1;
        break;
      default:
        thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_1387A1180E68DC64", objweapon);
        break;
    }

    if(isDefined(inflictor.streakinfo)) {
      if(!isDefined(inflictor.streakinfo.kills))
        inflictor.streakinfo.kills = 0;

      inflictor.streakinfo.kills++;
    }

    incpersstat("killstreakKills", 1);

    if(_id_F0D6C6926BF765BB)
      incpersstat("killstreakAirKills", 1);

    if(_id_4C20E5ABF3CE9872)
      incpersstat("killstreakGroundKills", 1);

    if(_id_D238646F1C6623EB)
      thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE(_func_2EF675C13CA1C4AF("stat_868668BDD652FCC1", _id_D8061F26B5ECA018), undefined, undefined, undefined, undefined, undefined, undefined, _id_F459A13A227B8DE6);

    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_killstreak", undefined, 0.75);
  }
}

killedkillstreak(_id_D8061F26B5ECA018, _id_6181DE250AFA5BB6, objweapon) {
  if(_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename))
    thread checkkillstreakkillevents(objweapon, undefined, _id_6181DE250AFA5BB6);
  else {
    _id_84EA5CF2793332C1 = _func_2EF675C13CA1C4AF("stat_4BB6EAD5813240AD", _id_D8061F26B5ECA018);
    _id_6181DE250AFA5BB6 thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE(_id_84EA5CF2793332C1);
    _id_6181DE250AFA5BB6 incpersstat("destroyedKillstreaks", 1);
    level thread scripts\cp\cp_player_battlechatter::saytoself(_id_6181DE250AFA5BB6, "plr_killstreak_destroy", undefined, 0.75);
  }

  if(isDefined(_id_6181DE250AFA5BB6.perk_data) && _id_6181DE250AFA5BB6 scripts\cp\utility::_hasperk("specialty_chain_killstreaks")) {
    _id_199C16FDBEB2C72B = 10;
    amount = _id_199C16FDBEB2C72B * _id_6181DE250AFA5BB6.perk_data["super_fill_scalar"];
    _id_6181DE250AFA5BB6 _id_56EF8D52FE1B48A1::increase_super_progress(amount);
  }
}

is_enemy_highest_score(enemy, enemies) {
  foreach(e in enemies) {
    if(e.score > enemy.score)
      return 0;
  }

  return 1;
}

getshotdistancetype(attacker, objweapon, meansofdeath, attackerposition, victim) {
  if(isalive(attacker) && !attacker scripts\cp\utility::isusingremote() && (meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_HEAD_SHOT") && !_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon.basename) && !istrue(attacker.assistedsuicide)) {
    _id_11A735A56B3FCBAD = distancesquared(attackerposition, victim.origin);

    if(_id_11A735A56B3FCBAD < 9216)
      return "pointblank";

    if(_id_11A735A56B3FCBAD > 4000000)
      return "very_longshot";

    _id_A77E978567103B98 = _id_74502A9E0EF1F19C::getweapongroup(objweapon.basename);
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
  return player.health > 0 && player.health < player.maxhealth * 0.2;
}

checkmatchdatakills(_id_61B5D0250B328F00, victim) {
  if(isDefined(self.lastkilledby) && self.lastkilledby == victim) {
    self.lastkilledby = undefined;
    revenge(_id_61B5D0250B328F00, victim);
  }
}

proximityassist(_id_61B5D0250B328F00) {
  self.modifiers["proximityAssist"] = 1;
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_1585DD0E8F21044D");
}

proximitykill(_id_61B5D0250B328F00) {
  self.modifiers["proximityKill"] = 1;
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_B2545F22CF7AD376");
}

longshot(_id_61B5D0250B328F00, attacker, victim) {
  self.modifiers["longshot"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 4);
  thread scripts\cp\cp_matchdata::logattackerkillevent(_id_61B5D0250B328F00, "longshot");

  if(isDefined(attacker) && isDefined(victim) && isalive(attacker)) {
    _id_1FC88419BEC39729 = scripts\engine\math::round_float(distance(attacker.origin, victim.origin) / 39.37, 2);
    self setclientomnvar("ui_longshot_dist", _id_1FC88419BEC39729);
  }

  incpersstat("longshotKills", 1);
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_9501A62017D709D3");
}

very_longshot(_id_61B5D0250B328F00) {
  self.modifiers["very_longshot"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 41);
}

pointblank(_id_61B5D0250B328F00) {
  self.modifiers["pointblank"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 9);
  thread scripts\cp\cp_matchdata::logattackerkillevent(_id_61B5D0250B328F00, "pointblank");
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_A4EE120BD3F61B35");
  incpersstat("pointBlankKills", 1);
}

headshot(_id_61B5D0250B328F00) {
  self.modifiers["headshot"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 0);
  thread scripts\cp\cp_matchdata::logattackerkillevent(_id_61B5D0250B328F00, "headshot");
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_FC56E889052D3823");
}

avengedplayer(_id_61B5D0250B328F00, _id_35F3D76A60187C15) {
  self.modifiers["avenger"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 44);
  thread scripts\cp\cp_matchdata::logattackerkillevent(_id_61B5D0250B328F00, "avenger");
  incpersstat("avengerKills", 1);
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_F751297C1A2FA2A9");
}

assistedsuicide(_id_61B5D0250B328F00, objweapon) {
  self.modifiers["assistedsuicide"] = 1;
  thread scripts\cp\cp_matchdata::logattackerkillevent(_id_61B5D0250B328F00, "assistedsuicide");
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_25AD6F034F93AF2D", objweapon);
}

defendedplayer(_id_61B5D0250B328F00, guid) {
  self.modifiers["defender"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 49);
  thread scripts\cp\cp_matchdata::logattackerkillevent(_id_61B5D0250B328F00, "defender");
  incpersstat("defenderKills", 1);
  _id_F8C66C48A93B4140 = scripts\cp\utility::getplayerforguid(guid);
  thread killeventtextpopup("stat_106962D4EDB25321", 0);
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_58B9CD84A305DD09");
}

postdeathkill(_id_61B5D0250B328F00) {
  self.modifiers["posthumous"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 39);
  thread scripts\cp\cp_matchdata::logattackerkillevent(_id_61B5D0250B328F00, "posthumous");
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_DAB63315ABCDB6B4");
}

revenge(_id_61B5D0250B328F00, victim) {
  self.modifiers["revenge"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 40);
  thread scripts\cp\cp_matchdata::logattackerkillevent(_id_61B5D0250B328F00, "revenge");
  incpersstat("revengeKills", 1);
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_7670901F9461C455");
}

multikill(_id_61B5D0250B328F00, killcount, _id_C95C893C15217527, dontshowscoreevent) {
  if(!isDefined(self.currentmultikill))
    self.currentmultikill = killcount;

  if(killcount < self.currentmultikill) {
    return;
  }
  self notify("multiKill");
  self endon("multiKill");
  waitframe();
  _id_A773025016ED337A = undefined;
  teamsplash = undefined;
  self notify("got_multikill");

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

  if(isDefined(self.pers["highestMultikill"]) && killcount > self.pers["highestMultikill"])
    self.pers["highestMultikill"] = killcount;

  thread scripts\cp\cp_matchdata::logmultikill(_id_61B5D0250B328F00, killcount);

  if(isDefined(_id_A773025016ED337A)) {
    thread killeventtextpopup(_id_A773025016ED337A, scripts\engine\utility::ter_op(isDefined(_id_C95C893C15217527), _id_C95C893C15217527, 1), istrue(dontshowscoreevent));

    if(!istrue(dontshowscoreevent))
      thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE(_id_A773025016ED337A, self getcurrentweapon());
  }

  if(isDefined(teamsplash)) {
    if(!istrue(dontshowscoreevent))
      thread fireoffsplashforplayer(self, teamsplash, undefined, self);
    else
      thread scripts\cp\cp_hud_util::teamplayercardsplash(teamsplash, self, self.team, undefined, 1);
  }
}

fireoffsplashforplayer(player, _id_1B4ADA49A21B51CA, optionalnumber, owner) {
  player thread scripts\cp\cp_hud_message::showsplash(_id_1B4ADA49A21B51CA, optionalnumber, owner);
}

firstblood(_id_61B5D0250B328F00) {
  self.modifiers["firstblood"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 33);
  thread scripts\cp\cp_matchdata::logattackerkillevent(_id_61B5D0250B328F00, "firstblood");
  thread scripts\cp\cp_hud_util::teamplayercardsplash("callout_firstblood", self);
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_891A26E1130EB05B");
}

winningshot(_id_61B5D0250B328F00) {}

buzzkill(_id_61B5D0250B328F00, victim) {
  self.modifiers["buzzkill"] = victim.pers["cur_kill_streak"];
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 19);
  thread scripts\cp\cp_matchdata::logattackerkillevent(_id_61B5D0250B328F00, "buzzkill");
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_03858CE1E38B2CFC");
}

comeback(_id_61B5D0250B328F00) {
  self.modifiers["comeback"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 38);
  thread scripts\cp\cp_matchdata::logattackerkillevent(_id_61B5D0250B328F00, "comeback");
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_61CC49DF58D8244E");
  incpersstat("comebackKills", 1);
}

collateral(numkills) {
  if(numkills == 2) {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_twofer", undefined, 0.75);
    thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_8368A43E439D8A67");
  }

  if(numkills == 3)
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_threefer", undefined, 0.75);
}

shotguncollateral(numkills) {}

quadfeed(_id_61B5D0250B328F00, struct) {
  self.modifiers["quadfeed"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 46);
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_DABB834E68CCA5AF");
}

disconnected() {
  _id_5155CBAA6170E292 = self.guid;

  for(_id_F90358454413407F = 0; _id_F90358454413407F < level.players.size; _id_F90358454413407F++) {
    if(isDefined(level.players[_id_F90358454413407F].killedplayers[_id_5155CBAA6170E292]))
      level.players[_id_F90358454413407F].killedplayers[_id_5155CBAA6170E292] = undefined;

    if(isDefined(level.players[_id_F90358454413407F].killedby[_id_5155CBAA6170E292]))
      level.players[_id_F90358454413407F].killedby[_id_5155CBAA6170E292] = undefined;
  }
}

monitorhealed() {
  if(_id_187A04151C40FB72::_id_377A94F711D96927("healed") == 0) {
    return;
  }
  level endon("end_game");

  for(;;) {
    level waittill("healed", player);
    player thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_7F9CDAB528B70D9A");
  }
}

updaterecentkills(_id_61B5D0250B328F00, victim, objweapon, _id_366B0ECC2F28AEAD) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updateRecentKills");
  self endon("updateRecentKills");

  if(!isDefined(self.recentkillcount))
    self.recentkillcount = 0;

  self.recentkillcount++;

  if(!isDefined(self.recentkillsperweapon))
    self.recentkillsperweapon = [];

  if(!isDefined(self.recentkillsperweapon[_id_366B0ECC2F28AEAD]))
    self.recentkillsperweapon[_id_366B0ECC2F28AEAD] = 1;
  else
    self.recentkillsperweapon[_id_366B0ECC2F28AEAD]++;

  weaponinfo = scripts\cp\utility::getequipmenttype(objweapon.basename);

  if(isDefined(weaponinfo) && weaponinfo == "lethal" && objweapon.basename != "throwingknife_mp") {
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_grenade", undefined, 0.75);
    level thread scripts\cp\cp_player_battlechatter::saytoself(self, "plr_killfirm_amf", undefined, 0.75);

    if(self.recentkillsperweapon[_id_366B0ECC2F28AEAD] > 0 && self.recentkillsperweapon[_id_366B0ECC2F28AEAD] % 2 == 0)
      thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_978B9BAB778F200B");
  }

  scripts\cp\utility\script::bufferednotify("update_rapid_kill_buffered", self.recentkillcount, _id_366B0ECC2F28AEAD);

  if(self.recentkillcount > 1)
    thread multikill(_id_61B5D0250B328F00, self.recentkillcount, 0);

  wait 2.5;

  if(self.recentkillcount > 1)
    thread multikill(_id_61B5D0250B328F00, self.recentkillcount, 1, 1);

  incpersstat("mostMultikills", 1);
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.recentkillsperweapon = undefined;
}

monitorcratejacking() {
  level endon("end_game");
  self endon("disconnect");

  for(;;) {
    self waittill("hijacker", cratetype, owner);
    thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_519E0923D0608694");
    splashname = "hijacked_airdrop";

    if(isDefined(owner))
      owner scripts\cp\cp_hud_message::showsplash(splashname, undefined, self);
  }
}

updatequadfeedcounter(attacker, _id_61B5D0250B328F00) {
  if(isDefined(level.quadfeedinfo) && gettime() - level.quadfeedinfo.starttime > 5000)
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
  if(scripts\cp\utility\player::isreallyalive(self)) {
    _id_22D57060C0BF0ECE = self issprintsliding();

    if(istrue(self.eventswassliding) && !_id_22D57060C0BF0ECE)
      self.eventsslideendtime = gettime();

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
  self.wasads = scripts\cp\utility\player::isplayerads();
  self.lastadsstarttime = 0;
}

monitoradstime() {
  if(scripts\cp\utility\player::isplayerads()) {
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
    incpersstat("reloads", 1);
  }
}

monitorweaponpickup() {
  level endon("game_ended");
  self endon("disconnect");
  self.lastweaponpickuptime = 0;

  for(;;) {
    self waittill("weapon_pickup");
    self.lastweaponpickuptime = gettime();
    incpersstat("weaponPickups", 1);
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
  self.laststancechangetime = gettime();
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

  if(!istrue(_id_9D6C7038172EB8CF) && self.mantlecur) {}

  _id_32931493C5657794 = self.jumpcur;
  self.jumpcur = self isjumping();

  if(!istrue(_id_32931493C5657794) && self.jumpcur) {}

  stance = self getstance();

  if(stance != self.laststance) {
    if(self.laststance == "crouch") {
      starttime = self.laststancechangetime;
      time = (gettime() - starttime) / 1000;
      incpersstat("timeCrouched", time);
    }

    if(self.laststance == "prone") {
      starttime = self.laststancechangetime;
      time = (gettime() - starttime) / 1000;
      incpersstat("timeProne", time);
    }

    self.laststancechangetime = gettime();

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

predatormissileimpact(_id_25DE37BAEC255643) {}

largevehicleexplosion(_id_408F3E834E201526) {}

vehiclekilled(damagedata) {}

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

missilewhizby(player, missile) {}

bombdefused(_id_34E4B26FEE2CFD2B) {
  _id_8F8DC78C3242728B = 0;
  _id_C148DFE3DD8379C8 = 0;

  if(!_id_8F8DC78C3242728B) {
    _id_F47DD9D668CC52E2 = scripts\cp\utility::getplayersinradius(_id_34E4B26FEE2CFD2B.origin, 600);

    foreach(player in _id_F47DD9D668CC52E2) {
      if(player.team != _id_34E4B26FEE2CFD2B.team) {
        _id_C148DFE3DD8379C8 = 1;
        break;
      }
    }
  }

  if(_id_8F8DC78C3242728B)
    _id_34E4B26FEE2CFD2B thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_B723EF4352E748D0");
  else
    _id_34E4B26FEE2CFD2B thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_D42F3A6D11E62127");

  _id_34E4B26FEE2CFD2B incpersstat("defuses", 1);

  if(isPlayer(_id_34E4B26FEE2CFD2B)) {
    _id_5814D27874B48E54 = spawnStruct();
    _id_5814D27874B48E54.player = _id_34E4B26FEE2CFD2B;
    _id_5814D27874B48E54.eventname = "defuse";
    _id_5814D27874B48E54.position = _id_34E4B26FEE2CFD2B.origin;
    _id_4A6760982B403BAD::_id_80820D6D364C1836("callback_on_game_event", _id_5814D27874B48E54);
  }
}

revivedplayer(reviver, _id_22F7E3F7E360775B) {
  if(scripts\cp\utility::getgametype() == "cp_survival")
    return;
}

doorused(player, _id_6CB6920473D33EE3) {
  if(_id_6CB6920473D33EE3)
    player.lastdooropentime = gettime();
}

shothit() {}

shotmissed() {}

killeventtextpopup(scoreeventref, showassplash, dontshowscoreevent) {
  if(_id_16AA7CE5EFACBCCB()) {
    return;
  }
  self endon("death_or_disconnect");

  if(!_id_187A04151C40FB72::scoreeventhastext(scoreeventref)) {
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
  _id_3ED8EAA77725D27A.priority = _id_187A04151C40FB72::getscoreeventpriority(scoreeventref);
  _id_3ED8EAA77725D27A.alwaysshowsplash = _id_187A04151C40FB72::scoreeventalwaysshowassplash(scoreeventref);
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

_id_16AA7CE5EFACBCCB() {
  return istrue(level._id_16AA7CE5EFACBCCB);
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
      thread scripts\cp\cp_hud_message::showsplash(event.scoreeventref);
    }

    event.processedsplash = 1;
  }

  foreach(event in self.splashpriorityqueue) {
    if(event.processedscoreevent || event.dontshowscoreevent) {
      continue;
    }
    thread _id_187A04151C40FB72::scoreeventpopup(event.scoreeventref);
    event.processedscoreevent = 1;
    wait(getdvarfloat("scr_splash_kill_buffer", 0.25));
  }

  self.splashpriorityqueue = undefined;
}

initpersstat(_id_B03F67117DA3F61A) {
  if(!isDefined(self.pers[_id_B03F67117DA3F61A]))
    self.pers[_id_B03F67117DA3F61A] = 0;
}

getpersstat(_id_B03F67117DA3F61A) {
  return self.pers[_id_B03F67117DA3F61A];
}

incpersstat(_id_B03F67117DA3F61A, _id_2F977E27FA739602) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[_id_B03F67117DA3F61A]))
    self.pers[_id_B03F67117DA3F61A] = self.pers[_id_B03F67117DA3F61A] + _id_2F977E27FA739602;
}

setextrascore0(_id_8F617FFD000EB682) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self.extrascore0 = _id_8F617FFD000EB682;
  self.pers["extrascore0"] = _id_8F617FFD000EB682;
}

setextrascore1(_id_8F617FFD000EB682) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self.extrascore1 = _id_8F617FFD000EB682;
  self.pers["extrascore1"] = _id_8F617FFD000EB682;
}

setextrascore2(_id_8F617FFD000EB682) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self.extrascore2 = _id_8F617FFD000EB682;
  self.pers["extrascore2"] = _id_8F617FFD000EB682;
}

setextrascore3(_id_8F617FFD000EB682) {
  if(istrue(game["practiceRound"])) {
    return;
  }
  self.extrascore3 = _id_8F617FFD000EB682;
  self.pers["extrascore3"] = _id_8F617FFD000EB682;
}

getplayerdataloadoutgroup() {
  return "cploadouts";
}

setplayerdatagroups() {
  level.loadoutsgroup = getplayerdataloadoutgroup();
}

canrecordcombatrecordstats() {
  return level.rankedmatch && !istrue(level.ignorescoring) && scripts\cp\utility::getgametype() != "infect";
}

getstreakrecordtype(streakname) {
  if(isenumvaluevalid("mp", "LethalScorestreakStatItems", streakname))
    return "lethalScorestreakStats";

  if(isenumvaluevalid("mp", "SupportScorestreakStatItems", streakname))
    return "supportScorestreakStats";

  return undefined;
}

execution(_id_61B5D0250B328F00) {
  self.modifiers["execution"] = 1;
  self.modifiers["mask"] = scripts\cp_mp\challenges::_id_6D40F12A09494350(self.modifiers["mask"], 17);
  thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_40C5F8104D76CC15");
  self notify("killed_ai_via_execution");
}

init_ai_kill_params_for_events() {
  self.killedplayers = [];
  self.killedby = [];
  self.lastkilledby = undefined;
  self.greatestuniqueplayerkills = 0;
  self.damagedplayers = [];
  self.lastkilltime = 0;
  self.lastkilldogtime = 0;
  self.recentkillcount = 0;
  self.recentdefendcount = 0;
  self.kills = 0;
  self.deaths = 0;
  self.pers["cur_kill_streak"] = 0;
  self.pers["cur_death_streak"] = 0;
  self.pers["cur_kill_streak_for_nuke"] = 0;
  self.tookweaponfrom = [];
  self.guid = scripts\cp\utility\player::getuniqueid();
  thread watch_for_long_death();
}

watch_for_long_death() {
  self endon("death");
  self waittill("long_death");

  if(isDefined(self.attackers) && self.attackers.size > 0) {
    foreach(guid, entity in self.attackers) {
      if(isPlayer(entity)) {
        if(isDefined(self.attackerdata) && self.attackerdata.size > 0) {
          if(!isDefined(entity.longdeathtracker))
            entity.longdeathtracker = [];

          entity thread killedenemy(undefined, self, self.attackerdata[guid].objweapon, self.attackerdata[guid].smeansofdeath, entity, 0);
          thread scripts\cp\cp_challenge::onplayerkilled(entity, entity, self.maxhealth, undefined, self.attackerdata[guid].smeansofdeath, self.attackerdata[guid].objweapon, self.attackerdata[guid].smeansofdeathshitloc, entity.modifiers);
          entity thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_EF9582D72160F199", self.attackerdata[guid].objweapon);
          entity.longdeathtracker[self getentitynumber()] = 1;
        }
      }
    }
  }
}